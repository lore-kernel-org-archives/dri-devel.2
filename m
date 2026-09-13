Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19662C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD5210E71D;
	Sun, 13 Sep 2026 10:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjlRF3a0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZ5c62Bm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56EF10E71D
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:32:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DAU2YN1004911
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D5vAKqT6Wkkpii4lrLSYCVCPovwE6ZV45z1ikvs4rFc=; b=DjlRF3a0oH/oZqUd
 sXxPdDvrvayU7rLuv9n8W/fBt75uI7MZorhxobwtNTwZWUAIPTgbNAglaqHNu/gY
 3itqSnnWoT8RFzuVwXzI+hCjHP3RfkapSK0/OMJjKinAwTLfGvQSjOS2Gwi2VJSk
 9CcACRh1f6M8lKy+dZWH/cqFVftH8bn1wemff/+xWwwNkqfVDrMMVS3vl70D9+Cl
 WpH5Bt/crC51uIfpOuza9LoUoNOXzlZS+jandBp025RgHNSMrm+Zbdcl2Qpw451w
 V46vo4N3pJQhwI87KuWX8ZmnlMN9fXEZGoZvmwArpEQVQn5uWYBFBUHNNZ4nB7Cd
 XwL8Ng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd33b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:32:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so480628685a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789295535; x=1789900335;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D5vAKqT6Wkkpii4lrLSYCVCPovwE6ZV45z1ikvs4rFc=;
 b=iZ5c62BmEUdhsZRaI5+E5tZStbUpDNXgf1JyA6VWSZ5CVdueDEIaGV7ehiMzgOVmik
 lTfH4I4LG119d/Gw/TyQVh9FlGPMTPeiJxUY1WBbnUV3QyvoSQS3suoNMLN1yNzec9dj
 4897t4kERQzizm6LvtW0i+3temHd5SMPlOTzhzkTqiO0KQtyJ9W/JgwyVGUmb8Lud5VY
 NLyRQn2MMvKOIiVktjpis3Wo2iusBwp8plMjuRXquJD4QcCImBtO1a17pGLzuYUARUHe
 Bo3vaD003Lk9wN5rFjlLiAN7jzgajSUIfLROPNoJ5M1VuuAIKjpaNavHJtwQg0ol9YaK
 /5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789295535; x=1789900335;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5vAKqT6Wkkpii4lrLSYCVCPovwE6ZV45z1ikvs4rFc=;
 b=a4HRwYg7Kqcd9WVHpdF/lO3rmucWPfxxE8yUtqqGUZmgUq5IkZMutV5nh12RWsxNvE
 0jE8MIJA9hitK9FrA2eP88MDpMQ++Mld4e0AGUfa+idCgZq07rqnISY1m7X/pjQ9ccVu
 qiohJ1ZgEtk9MbLBNw/tNMlUiMpxlXLr2eJYI2G+XoPODG3oDAVZTOZET1lRZJAWcREy
 2NFGY9TohpKl7yfU0PnmY5rL3bZBuWLI9KgEUzM7KyWGkhOjaefWZMFaM3B7gkvbil2z
 UzwsSW+K6/CzgLDRvICyNsVIpzlRCNeSJBPMwV0QnoWuwoHuR48n4wFHazW8leWuro+2
 VwEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJbNGua9jj/rt/ud7mKOld/B/Szl2JUIRqwGJk76ae5IbwNx2NwkXSVKJsps7FUeC3od5w+vJEyfA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lB7gIvv+EufycLbl4inKrenjCUa2B0HmKNBX79o8P8NE98TNuB
 isBMA4xfevvG9dsxwD4l/niErxpltnH9hQKfkI597ahaeI/2a+q2daRMnW1ksEmnYIozIGpWPav
 sI8S2kr1iABy84+Oq9sdW3iYQ3N779qQufeLza4YNQ2baMgja9G/wn5QBgqDGIStI1e6pMno=
X-Gm-Gg: AYBFou0r5kX6T0JlK0dQ8Gf0KwGWA4LadInaUYBqqyCiDV/86I70zxmDmjwtWkW6VZd
 gQbrIlWQXi0Wl6Z4qPZYX0XpliJ53y39031ctMGEdM5NCoDBCad5we6ioKNHB6VBMaNrRbcRDk2
 32h6ojbXylTe4n9851EX/C8BikEsHFMQtZDmq1gY03s9QaFximDQDE7eVHy890IU/N03ey6xwDR
 n7KsWWjELGlZflithF7e9mN63SuH6SqWYRJExtUB1d3q7poMhAwnjqCuDm/md1ArhI4zrwki1Eg
 9Rc0iLkkWz6YkW1e1/BJpgUkvQkb62kzzk/BBw15Kt/3XgqFU4fss6IfGmWmplhhiSM2Eo+PD4C
 RHZGbmgKIZ1K6JwbjwgkEMFFT9UjJ
X-Received: by 2002:a05:620a:4409:b0:939:5f4d:67b0 with SMTP id
 af79cd13be357-939ea037da2mr1792431085a.8.1789295535236; 
 Sun, 13 Sep 2026 03:32:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:939:5f4d:67b0 with SMTP id
 af79cd13be357-939ea037da2mr1792428585a.8.1789295534807; 
 Sun, 13 Sep 2026 03:32:14 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm519682395e9.6.2026.09.13.03.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 03:32:13 -0700 (PDT)
Message-ID: <c478a074-f0b7-4eee-8cea-5f926b6044df@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 12:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260913085814.1509352-1-lgs201920130244@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260913085814.1509352-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa67bb0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eqkjudQgZ73XcBGNVqcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDE0OCBTYWx0ZWRfX8vqLs+gAkaVa
 S3JbOgTdWIdr7BiZFPnSNhobMDD5Sto/EquSiRG+V2ECYUTAxFZH99kBsgKXUYvYT3Ox47J0SYM
 F9DZrsGPrGFCJWLHUslPjCB1MWSbOgkCkizrQqZ3QRHxHd083BGhpGTvRX8PE9OJbYyXaCDa+TE
 /Wzg4qSTfTPCHjTloq6+PZj3WBzHtMqMQ+6qFixM8wld3bKS7JKJ7b/IRqfzS9KuFSLh9I6OBae
 oin+SMKfEC1Z9kudolnrXPCRoJGejq075jcUxbEp42VGocBzYmlsHU7xYzUEeF2sxHhQMJvBgpS
 HqiblDFY9W68Qzp9DZp/KhPxAz7sM6AOD+vHyQmEWc6YusCBKibVrZGaqlrlCyCAewO/GInol6V
 t+v7KZUvMj2g5tEK6uCjDDifKtjyfVmlkqoAepRxaofgMApbVO9amJT6R94CfrUQWS6D7/A0mlU
 4ONoQnOlDvodr5MEzbA==
X-Proofpoint-ORIG-GUID: uv-7neQ9j7vyc5F94SgUR51BFfEXc9l6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDE0OCBTYWx0ZWRfXyfnoYhoFedw3
 wYLXt4jg2k19ZoyW8RTmctYG9+hViUKdP3VwWzZxGk8hm0Vr/0/ifaaIENdy7IAP3oMa33EMhBP
 dNR5rvYdkZqSp8PAOGlSlU1ZMevR+Xg=
X-Proofpoint-GUID: uv-7neQ9j7vyc5F94SgUR51BFfEXc9l6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130148
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

On 13/09/2026 10:58, Guangshuo Li wrote:
> msm_hdmi_phy_probe() enables runtime PM before enabling the PHY
> resources and initializing the PLL, but failures from either operation
> return without calling the matching pm_runtime_disable().
> 
> The remove path disables runtime PM, but it is not called when probe
> fails. As a result, runtime PM remains enabled after an unsuccessful
> probe.
> 
> Route failures after pm_runtime_enable() through a common error path
> and disable runtime PM before returning.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof
