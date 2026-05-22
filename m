Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D146BCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3465D10F51E;
	Fri, 22 May 2026 09:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkfFc1Jf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J20+LCYW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAA810F51E
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:28:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M65O7D776908
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mOpwbG5ilD10AxWa1l2Er2Zhjy5C62KFsf52M3F+W+k=; b=AkfFc1JfvYP6u2v3
 tbUl0pXRgriopNhoiwzsobwEmYwhxhGK71VR85z6bGkdH+fF6ebh7CdvtALjdNfr
 nYYX5Z79ByFJ0VqUdRFsIBJ/6Yd7ySS/r/cxcnY9JhwyoCAOOWfM4a1FyQH5g7hy
 c3UnIu5qm6sFFh2v2YwsdX76jWkcJF/Zm+6gsObmuzODZHNF1VsnxjoDJcrgPXC4
 B+PKlmfyXzWR6O0Umn0vTjTW+Q2/aTI/Y0wLGmlwvc5mN1NWJCkmG5NGsFSESaLN
 IlOMRsGMPr7lvdqi21bV8hZAiB2I4sXD7ZuIHb9lBKPr75fgelwGdMO+JEfJ6hQI
 L3sQmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h2tf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:28:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-914ae262b06so35082485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779442117; x=1780046917;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mOpwbG5ilD10AxWa1l2Er2Zhjy5C62KFsf52M3F+W+k=;
 b=J20+LCYWQV4V05y+N5PxGspFIQEQB0fQbVcDIGWo7XkeK56CvL1+6iDVSjtC+12ol5
 dRrBhjMK42aPQ2LUCE383nZ0pP747xJ/B+ps++cE/6LGSMNGk1PRIIbvNeLjS9qykLDf
 UBUUspp0C1PNQbLmAC6vVVfWqsbfpySgt05HEEjhDA9JPdB7x8lZ8As+eAw8CgOMKeRa
 2mf+BbX/z+MFZk0H5dSV2NTFYkA9OwTZIB1yTpIu9eJtIA2sUYCBJOThs/AD0gmZJ5uh
 chq/riLFPvZamM+g1/jI0WdyzMj8Bwccyj+DeNQr61Bdzui55qMEnSodR2UoAFxWweuc
 EPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779442117; x=1780046917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOpwbG5ilD10AxWa1l2Er2Zhjy5C62KFsf52M3F+W+k=;
 b=VoUPMfwfoH4nBqNVhGf9+BH3yODgftRGKGt1XtYwXDiCLMivcLILrhGyAwBSKk9FLd
 ofe5XCg1F6u/ACtOgjKoMm1nBdr34lrOE/1UXTlJ6eh590zX0UoT/vPk/ucf6ObLYLyz
 +FL23zKgJCQW20Cu3g29odRoQ6fO2Db87GR0Jqz88elI9FvqqihdhudzcGULrWC904pf
 tttJzUu7XbLleQ9RgmPcQDfrU5qmOAyq6AKSAuxd/4kLDyxRs1FiGTtItUG6QiWgHQ+a
 U5FHnbf6YBszuqO/FT6pxTbNKpbiysyvcZ1DUy9R2CAPmUNyUPEZOExMiyhE45EIsh+A
 dmcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RBrqvTdPdZpuiYlgX3AxcBr9RBxRVT9BZ3du8SDJcD0j2qxMraO3U+TpOVfFLQuWzj27/nD24jtc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3bD3ASbp+pVIFKpioRjaFNKM76Hw97Tz4R6Q7jrjKr/8r3E/F
 ZMJYYSC96rZRdmT1fD2gFr7WFOL7ZfHef5xn2kQNlGvjFRkBG4xd+gvyjhlLWyoA+1QG+cWAs2Z
 2VUjMKnWJgrOqYpoV9HqYlZGXiAAU2wPaYewC44SFdxrgFXK+ufuwY7hyqnTQPTW/PTF2H3g=
X-Gm-Gg: Acq92OHR4WRe+OsrYwmOVvt7279DZvPivKEN6Y1j6e40At7WyF4qgZ1+Z+WCKpUx88D
 18qAGkPNYaEjvLavyLHK/ExuStIVe0mZj7hou4y/JcRB2W0neQI89lKfieX6kA2PewbmxJ/Mo6U
 XHO/RlJjgReZMGmSFd0MOuQLDhNCrReyiO4PljGkuWEzL7qjg8M705fAnYofC0e2dkl0BhMAxZT
 3Lk/1HvCCcrBb+Vq78LOU3NrcMrohxCxuUEhMwNGRepS6jgGklBWXB7PK/K0oYYmn6LnweR+OiY
 kA3SCrqp82q9reXs7xgbT0OqdoGaF80D42Up87fG0bQtSGY6YryjLyyS2ZGR43XF6Q3azt2W3dv
 fMEPjPrOE4Mltj4ns0/Krp1921E2B88cghBoXc0qn+cn9lw==
X-Received: by 2002:a05:620a:468a:b0:8ee:a1d:bac6 with SMTP id
 af79cd13be357-914b49e9d14mr292563185a.4.1779442117052; 
 Fri, 22 May 2026 02:28:37 -0700 (PDT)
X-Received: by 2002:a05:620a:468a:b0:8ee:a1d:bac6 with SMTP id
 af79cd13be357-914b49e9d14mr292561285a.4.1779442116624; 
 Fri, 22 May 2026 02:28:36 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f50364sm473973a12.8.2026.05.22.02.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:28:34 -0700 (PDT)
Message-ID: <7e435e8c-ba0e-453a-b95c-450446dfc0ff@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/msm/dp: Limit voltage swing level to 2 for RA620
 bridge
To: Graham O'Connor <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-4-graham.oconnor@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522060645.4399-4-graham.oconnor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fcT7kpaaI5bfmMDZ3_C_Ip9aCLxy8Ufj
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a1021c5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=wrdFt3MdCHdAHujQ4X4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: fcT7kpaaI5bfmMDZ3_C_Ip9aCLxy8Ufj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MyBTYWx0ZWRfX3fvrlpu2M79r
 D101ny+a+DWekBwoYvrwBeN2PsyUO/5eNas0wE1UtiIGz9ZYSwFU4rgTQaL5A9jwXlUZObts/Zk
 cR4MDRY+c+qvynTPv3r8thqVrvgNJnovSSPLHY6n+pXF/YPMqdMilJu/P5d84kEBFPHBxvR5VIR
 uAOxe9ifHj7MU6OO7wvjvtM5y94E53hi51yQDfkhNr5IfExfxgZ5yPJhY1NOxQ2Wma9YkopjvAK
 VX4HmZgtr+CBmTskhvHnPDWZcfmRe2gt73gg0zntekrHwhfBw627M5/uqWuZg4UtxjthTSEipkb
 NGIePWoB4tfsS5f+RizX1f5TQM/LPxe7grPxMa7VJzuRu+FtoQKhKz/jgL9GxxtWLisqOCQLsTt
 mnXrYbMZ5smKEbh5wCm1jjW/+p/zyajt9Q5mQQPKGUgM1sbKpq4SM4TgzpQwNWb2mvJNFcALcyd
 mkL09wgzqxrReG2mikA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220093
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

On 5/22/26 8:06 AM, Graham O'Connor wrote:
> The RA620 DP-to-HDMI bridge used on the Radxa Dragon Q6A does not
> acknowledge DP link training at voltage swing level 3. The bridge
> requests maximum voltage swing but never completes link training
> when the driver attempts level 3, causing HDMI output to fail.
> 
> Cap DP_TRAIN_LEVEL_MAX at 2 to match the behaviour of the vendor
> kernel, where link training completes successfully at level 2.
> This allows the RA620 bridge to establish a stable HDMI connection.
> 
> Tested on Radxa Dragon Q6A (QCS6490) with RA620 DP-to-HDMI bridge
> 
> Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_link.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
> index 76125e9c0..ff0d8e99d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.h
> +++ b/drivers/gpu/drm/msm/dp/dp_link.h
> @@ -24,7 +24,7 @@ struct msm_dp_link_info {
>  	unsigned long capabilities;
>  };
>  
> -#define DP_TRAIN_LEVEL_MAX	3
> +#define DP_TRAIN_LEVEL_MAX	2

You're limiting this value for *all* devices featuring a Qualcomm
SoC with a DP controller. Instead, if this is really an issue that
results from the bridge's capabilities (which could potentially only
be a symptom, not the cause), this should be somehow limited to the
specific bridge itself

Konrad
