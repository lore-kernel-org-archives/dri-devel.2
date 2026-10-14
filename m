Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49F4CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1808C10EA6C;
	Wed, 14 Oct 2026 09:19:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759B410EA6C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E5wptr3951349
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I9vbNOPgSoW2/s5EmJhhLhQxF1+z/I0nBNc1/Lx6mzA=; b=RZSQxUg8DMWENbz8
 /2tgFMNww2z5LvmzbTrkdYN9ICez/UgIJRwOx/TMVyQvFAjY3qR4Y8Mm9dNGlfat
 A1064UEzfyNvw8PSF2d9hDrnNn23L1YXP7hFAL8Kh5SBc1Sv4q6y6ZPI7mwFxNjH
 m9UsN7zh2CIHVNo5eTvRL7oQAb1E6+3vtAu1tYOdi0E0OuRHHJkvnJ1z1dsZcFFN
 8xHSTAl2DVJwQIxTfEr5veeA6ukArm2e6oXEA3lN/FGyhaIJz0wyAsmrT9TWTZ4y
 yXdXPTtfHdXenKcYL9+rAuaODX1Ac9FAgS8NseC9haHxLCURnbGlLwg3xy9sP1XN
 9opTeg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p0u3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e6188d1e51so46411215ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791969566; x=1792574366;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I9vbNOPgSoW2/s5EmJhhLhQxF1+z/I0nBNc1/Lx6mzA=;
 b=Z5ZIsOWNn6UHcGjzxJEKrFmPKW4U4yDQpqlPCH5T9o3CtPzgniVFi1qjq5uoUb521s
 Iva+fiZESIRUfxrHGd35M8yVcx8vePS2x9uRsvsnYi/xGy3v4xSudKwtgFlSc5FCvYsZ
 6LHt+Q4n/twy/HXZzoB+zvExToYaLeqkDc+qzNCfl1/KfTEbS1dH/itRIKgvhrKnMLqb
 ECztYI2H5Y0mLtuv3lMOsnc9+TRop4wdtmiwYauvOQAlnkMe6cIqksUBbt7V4tV5h2+m
 nrvX4UbndqIwMdHU9DTWBhoeOIlgCoeUXkdXiOUzXn+JHP09Jiq8uld8UlpBCBAEolFc
 NXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791969566; x=1792574366;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I9vbNOPgSoW2/s5EmJhhLhQxF1+z/I0nBNc1/Lx6mzA=;
 b=rAR4tSsfPAenh97xDp++4KlTs9qnHhT+iAe1AE8E5KSXyAtE/TKGsiv1urnVRxq0BD
 /tznZt9SpU9Ud26/2J8/FPzOV7Viqtkt0JNJmnop1tydjZZaFg1FjL45XIOI2xZnwaeB
 p8M99gklEr82zAw2+rC6U/KcmsE+daV+v1L/uM7lcPtb/OKSneha+ofD3dy4/5dMZr6C
 JOVW99J/aGdQOhKDs7xZdeSKZwV7B7OX/vrWBlnfTQLdXRH3hdVDDJk7yqJg4eD+6rMj
 sn+LollfY9Qbr7PBKUpwPvTSV30C7yqS6G1sNEh8+2WYmAqp5nvDGYjTwelW/9qXJJBp
 8N7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkNJNvWU0ugoQHDEndboyMbn2R13qcV1OvCB4GhpwLV17sMDPeH33ioiNqht1iSWehqz016f6k4vA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcm/EaLJr9l4RvXXcjgvCYyKBoC9KDJbOEFbcfN8XiXMW3Q2b3
 lFCSCNw7oHQjlIXh4aRgsvXp2ywaRBdFJCs2Wk6pC98GC8JWG+YCIZqo6+DaPLDl0xDzFQxiccq
 JZLcomoHguEGdCXNiz44EL0wSuHmN6uVF+e51NPoEBd/rY9KHMAlhdCNkHoVK4kmHnYbhF+g=
X-Gm-Gg: AYBFou1qMI5WVQaOJaFubYexru+/xRABjjXgEZz/BVHJjEKjxDZrJEnFWV6UbK31uMn
 JqtOOLjO104kz7IdQ5T0M/g5ewncbZT4UcevXRVdbJS+Vzn4lAvbjdPclAuiStqvzPcYkxDIWn6
 9Ib6Kesb6C3dxNPnoePwwTZ0BRdlmaf2vCFZRkFNnJIZOFy6WDZ4Q9J0CYe+EsXLaN9VXBfDjxX
 0Oy6l8qZ3+P0DGo4M4Yzm1R4hcyigVO6TfVEZxQnPauwFcs2/Z/Rt7OmKxjCef9BWwCsSRIY8M9
 v7BOr63IMJhXbWa/msh7n7JF9D7W7xymRFvtu4b8/oLsBFj39bqV+JuFehtdtX0iuzZsfPVOtpE
 YIXUNDR2zfISV3aTc853OCqM5Ndus
X-Received: by 2002:a17:902:cec2:b0:2e8:2f95:764d with SMTP id
 d9443c01a7336-2e842dfd299mr134805425ad.59.1791969566342; 
 Wed, 14 Oct 2026 02:19:26 -0700 (PDT)
X-Received: by 2002:a17:902:cec2:b0:2e8:2f95:764d with SMTP id
 d9443c01a7336-2e842dfd299mr134804985ad.59.1791969565791; 
 Wed, 14 Oct 2026 02:19:25 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8202sm64057305ad.51.2026.10.14.02.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 02:19:25 -0700 (PDT)
Message-ID: <76ad74bd-e742-428b-b206-9db6cc98f10d@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:49:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] drm/msm/dp: Add support for DP controllers on
 Nord
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-6-a2ab9af954d2@oss.qualcomm.com>
 <gmsyzeugteg67h5vwzf2y2e7k56eg6aicbonzjl72etgedd5oe@vlizd2npwtn6>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <gmsyzeugteg67h5vwzf2y2e7k56eg6aicbonzjl72etgedd5oe@vlizd2npwtn6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX2k/PnarATFJq
 v2bLCBVBYIMhd+zbsWTT0BhqjPdmtq9puOYe+RMRPIpYOMEKebdQSy0AxfMWnZoMLFdR41Wcgkq
 khewt6O84ziLqe5S/ABXAne3wP/34OA=
X-Proofpoint-ORIG-GUID: ZTxokmmK7gWYxxVWyqIisjlYBUmXEUTs
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf491f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9x1Nq3F55a8nTBbgZHMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfXxuLuTRazYVym
 FuKbe6QTdKhHJ7nTSOAomU1fAET/1im5W4Zn5UuAja4++7858JZneCOTh8e5NZgdUdU3xATqImC
 kite9UMKSbudZMkzMz1bSm3TqxMdPWESx/VRzfCETXPsGJrYf6Zl+GqK3fywrJAiS2j+fwjzLQw
 Dn3kVoMxS+UZuvspuu8rEPSBIdWkHrwqpAJJjCM9JinN2zrppNrMyqRH0xWReRSGBPllK5iueon
 YEfPw8fHVcVNRQWr35IGtMGvPR++tEau2yoEeETByQetUiae974iEwQu4FMRZqtryRbNmVVcqSd
 DLDOH1l45nj6sabOFia//e92HkM64pAsSsQOU1HgYTQnFqQFS/XpH+0Uw+Mw/80FMUmUh5ofukG
 Q7S/aEIFbBFDxlnlK3vZ7nawbBGOwpSeaGaALXRT9S0FyDgoAKnilo/P6CV+TCNdUphC1Kzk+Xs
 CSypI/KCHz2rhvq18/Q==
X-Proofpoint-GUID: ZTxokmmK7gWYxxVWyqIisjlYBUmXEUTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140036
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


On 10/13/2026 2:48 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 12, 2026 at 07:02:16PM +0530, Nabige Aala wrote:
>> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>
>> Add the Nord DP desc and compatible. Nord is supporting the
>> four DP cotnrollers, two per MDSS instance.
>>
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> Why are they not a part of the existing entries? Is it a newer core?
Nord has two MDSS instances, each with two DP controllers. The first 
pair (0x0af54000, 0x0af5c000) is MDSS0 and the second pair (0x08d54000, 
0x08d5c000) is MDSS1 at a different base. No existing table covers this 
combination, So I added a new desc entry for Nord.
>
