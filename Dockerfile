# Image
FROM node:18

#Set Working Dir
WORKDIR /app

#Set Environment Variable
ENV SECRET_WORD="GODEBUG"

#Copy Application Files
COPY . .

#Install Dependencies
RUN npm install

#Expose Port
EXPOSE 3000

#Start Application
CMD ["npm", "start"]
