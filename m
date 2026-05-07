Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF6DCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAAF10EFFC;
	Thu,  7 May 2026 09:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2kgtRor";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GPH9m6Mw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691E210EFFC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:58:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64744GV6151176
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=; b=W2kgtRorpmg7moVR
 3nlYSTqKjEDGPqScfuuynl+ySOpMiJh83vEoZcBlOZEBh9yd3nCqsBUdd8VyvyP7
 GunBZVbuedem/NmEEbvHSKYmCNI8BbCFA88sy9bQWNUT3SjpawchIXUNJcHbNCNZ
 A6y+M4ZcA0j5BqpSH6Ippu7OdwKtHpIKqCiEW2Gy4eXjArnoKxB7hI5nmunLc38a
 S/rIBKkfYIiUNH9HUrcODxWx6Ct18jo64EBIz2ifaGHEVpsG81ZQF4ejIDHW1cmw
 wFYxfs4tdAcbB07HrRZgEQplVz3PDrPovSug5QxRHGiIg2JgXC55BG65GnfwaiBl
 btSNSg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kcts9ch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:58:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3650a4eb60dso734426a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778147909; x=1778752709;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=;
 b=GPH9m6MwFsO4wMGB5ykGK6rxqTQfoKh1ADx3mncXOaGPGg1MoCS7AY4wVlnCcr7W0o
 GtQmAXkSfOzhlNZ6Cl7onMAZ87DYB+pENPjVQ56AEhhM9W7Vo6WIcyqIegniSlQDgAB8
 o77leWAbFO581f15cHBOfAkVW9xm90widKBnPwAKwSKpkhloK9olV1nzWfjVXtaMT3jo
 GSAxEcSt5f8ZXjS57voyF6r65fZiP0H3mXdNkuE/S6r7HrRDEImeAzA4tgjHuJ002mnx
 HmCMOok5L4I4pRT7cJHXi87Dn3z+pnvcPTE5d77aMw5fQzjZ5EocETk3KnEhpE1Ylo+E
 L8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147909; x=1778752709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=;
 b=KRjU0q6mcwXVRqJSEfk7FwbY4vSpHW0wKWINc3k0kbYFL0tGnZQ4AbYIWVfjUE5ytp
 qvsKeyfpX0a7/msAM5ZP5xoBkDRCx6F7hx4TBYl0HjnqywN7DfoOyVSCUFMZHmgodpyU
 PQtGeiCk82SGEkEzhaomQBZugoZhoLgfROfMOe/Mvq5NKqKZnxst57tx+dfZyJQfo8YV
 Mz+cXEK0HGPpRWIav+N1Qga0CZBpwsYhMO/dQQNLpGZTOc/zypfjmWXb6zb8cWw+OMjx
 wmjFlpauQkbvfICSoOOoRMLnSY/drsz3x//1v6rfZBK3oE5YZfSTZ54ad98PoixyjJlS
 OB/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KSLaCbufqdUqvT2W2ky006PgFF2/Wbgz34OxWdNm8ZFrOaEdLcaBfYaAjSvmPIm/695akQ8H4gEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYXTQ5SE6+YFt1V+Yw1Q4R8PsDHlcxQLQKNjOS8QYA4nRV7iCt
 p2QMq58cqBvtAsH+ZRW4RExKlDuEGNkT6mIbZPJYYsSeZhao8MkMDqTUJjMC6URU21qXuju3abE
 /HTgnoPjNbHjj43xANoqH91FkQ1LtA68bjRe+5yoSUDfhAZ3Kk5b5xbGzNQYYlAslGWxqj6I=
X-Gm-Gg: AeBDievEuNMhpe6owabkTmM3MkjimvwhpETsD89FrdQ1a5FsZ67haB3t1oA+JwRAsHg
 enBMcw4oYwROJ5uZOyUMqltYyu/CKtI+4gFG5lPE4laFNx7iQHD48GTJqQJxvFo+DmWvFKoP7vM
 eYzttxKMPdQ9BsRS7nkzUoWGjguKSsNhyzxVPafviC3GYQbmej73TGQA7cag4a82dbRq8c7fgLZ
 bcN4Eu9JBTFi864WQXVLmCHxjL5qYLHcxRcUV/0EqreXDT/wSLrBnRUYY50gn0cRUXh8YcdhR8Z
 aPpasTmq6xo3eOaTSJcut1foaGkdmGp3Hwojdq0vgWRtWvaY381/nBdwNSe5Kg9rI+CAwblwpKF
 mQhnl8I9JOkZJMbbDOI3KAHDqD0CNpB4Rnt2ujHEqZxibEzHQAnrltpmmjiLkuyarmntEp7rBCj
 RFcLgjxjCM4cWZZKU=
X-Received: by 2002:a17:90b:3a0f:b0:361:472e:3be6 with SMTP id
 98e67ed59e1d1-365ac79e167mr6984126a91.26.1778147909424; 
 Thu, 07 May 2026 02:58:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3a0f:b0:361:472e:3be6 with SMTP id
 98e67ed59e1d1-365ac79e167mr6984112a91.26.1778147908928; 
 Thu, 07 May 2026 02:58:28 -0700 (PDT)
Received: from ?IPV6:2405:201:e02c:3e:6c6b:1a56:afde:6508?
 ([2405:201:e02c:3e:6c6b:1a56:afde:6508])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4c4270esm6906007a91.9.2026.05.07.02.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 02:58:28 -0700 (PDT)
Message-ID: <605bcc1c-a4ab-4125-a4b9-facf801db26c@oss.qualcomm.com>
Date: Thu, 7 May 2026 15:28:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor Extensions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, jonathanh@nvidia.com,
 thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fc6246 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=nip31g8rMu7ECPMDnyQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: EEwkGN0r05ZVciLUvaR_6LiabwEwIn1S
X-Proofpoint-ORIG-GUID: EEwkGN0r05ZVciLUvaR_6LiabwEwIn1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5OCBTYWx0ZWRfXw02oBPqk+fN6
 rhmAWI62r14dKhYDFYNYUbY7cZdt0lX6xtC7+TR/ItYTKJBVE1to+MGoaUqkshxjzGVTLIvsm00
 rzaS0RkVPkjQKobuQkD9Gtxnkj7YDb+J6nHVvXYtPl508Lr/789PBqqiH2YjkDzGBOyQc7smEdG
 1Uy4sUbTrXb2Y0LYR4CTVhUh8/ARRstIqi4w3oGMZkEskccijRaMbWZCd8oz3J8CjUE69hzciKh
 9+US4VD0a1GfTnYr4qpvPRFBx/+D68Q+Z362Djun98CByG17gIP68LigsHeMcXxnxi1MfpcwhEk
 iPS15qVhreN3AVZxDL88yq9FRzowBr9s9unhmARvyQ8ZhaCiq1NxrIQTVOs5Y9gjBFph8TEFMRb
 ufVPQ7b7fdEBNbDJeYRlLECMiHqWEgBJIshDA2sLcv4gwA/J3hC0OihRnz4fM5rX1ObOyE+60iL
 obIQOYR7Cmd70vV1J8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070098
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 5/7/2026 2:40 PM, Dmitry Baryshkov wrote:
> On Thu, May 07, 2026 at 11:52:29AM +0530, Sibi Sankar wrote:
>> The QCOM SCMI vendor protocol provides a generic way of exposing a number of
>> Qualcomm SoC specific features (like memory bus scaling) through a mixture of
>> pre-determined algorithm strings and param_id pairs hosted on the SCMI
>> controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
>> mechanism to control the various caches and ram is hosted on the CPU Control
>> Processor (CPUCP) and the method to tweak and start the governor is exposed
>> through the QCOM SCMI Generic Extension Protocol.
>
> Could you please clarify, does this apply to the common commercial
> Glymur and Hamoa laptops?

Yes, they do apply to common commercial Glymur/Hamoa Laptops
as is. This is the same solution used on the windows side of things
as well. There can be certain cases like Johan has reported earlier
where certain oems are stuck with on older version of CPUCP
which requires a the memlat string to be sent out in lower case
we should be able to handle those as well with overriding those
by using driver data and specific compatibles.

-Sibi

>
