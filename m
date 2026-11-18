Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3B60A261D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N10e3bat;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OQ6chrN2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A78F10FF4A;
	Wed, 18 Nov 2026 18:44:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081C410FF46
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:44:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGkno1155236
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a/1FJMohcTZY+9QiEVW33qHS2hIU0UKeXROf1tu+3XU=; b=N10e3batxmo44iLK
 e0ggGLrFGUVup8oItqLUH94w7nY6RAHtXIuHt9Unc2uY6AcvHHLBiPdFxWNULtPg
 j6Sc4+X/SyXwh7OlgxOem2VHCJRbZ6VxZy7hDxiSaMRRA4SpjTfNT/yk9hCRW5/s
 1wKHdF3HQEdHFh2vixpA1/iCP7JOKCLnAuE1nrKpJ5XBbJpzdqDF4YExSah1eLwl
 ke/XIvT82L7xdeTB31pxziL+/qvoAYbvilwRs9t43KVum3xyHgI6IGJXazuY24LP
 A8vD7V0pC4GZDlTfulL91iLC38KbVNCbcLV2Odpo0M1x7s3iwO7MBDzEUdJSGfLP
 M6HrBw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9egd3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:44:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ed05b3eaecso10547495ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795027483; x=1795632283;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a/1FJMohcTZY+9QiEVW33qHS2hIU0UKeXROf1tu+3XU=;
 b=OQ6chrN2jIPfZeF6yWZ8PMTcEgo4pc98hjWJWswT2JmJAgwyHVsAIbl8PoCwz/4fsT
 QWqCoq3EkBkvDrrVDci4EOzF7q1AETbFYnTTinVJR/tSfrwbjqOqySYgKOU3KeLcitZB
 3MEgjO2QC1CtUbX2ACui9CVgxas/mjLGeGEoUI3Ntl0mlSB1rGX05IBTPQ/ODY8oz0x/
 0G2LzZ19zoivpkCmtwQ66tNk4FeiX8iHRwPnDMl4xs/zk8nKbjHXzQD5GCzqx6LJe7dO
 qBmHKCjqDaFystWuNN8+Fg+wVnWZWWcqU+InF/HklNkyByjLzWEK9odE+4kFyTuLJZD5
 0iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027483; x=1795632283;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a/1FJMohcTZY+9QiEVW33qHS2hIU0UKeXROf1tu+3XU=;
 b=aYFHnitxtVY3LJm2gAd+y78wPllqiXtoJSaMfiC4WBELBqQrcAWNQ69yDTv1GGGtID
 gMKurSGAOtf7WPDyeiQoAaRmSG2p2VigtOnVa8UP1UzKNdf1lDmYkDsdmmBexHoxnCf1
 Wm323RAQ+ghskE4CL0UlPaUIhyhWMjl5dAf183hncUpJe01tR8wGGx9uwvSqLS/JWac7
 Ln8WiXu1rh83VHcpLomYa+RuS2Xua3NfZKOIBHR3l5W8BRwCzrNJsxM5v7+WHock/GHV
 v92M3uUWDvv2Jxi2ml9z+9LWYC4r+7KB/DRqOs/Kmsk/Sq4V4V5lkIJloTuF0Qy+UpGH
 ISQw==
X-Forwarded-Encrypted: i=1;
 AL+hErER/JT0/aKRFN7Ol/8dPyLLYenuF0D5aU4uGudP6qw+JyCAzj+2fN4TLZZs39TDSQJlMCCD5hvl02Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Rd/N/hyopZzJ6mNuBSTg3fUPKnETAmCsDFULNgoUz2TlgTO2h
 3oe66qjIe9xhRAvBKWuEjb3L1XdofjGxbQbkHI67NarUOXFFFs3pPPQuKHBjmmBbyDETw5DZwWc
 /4vITQZnhiq3FkMRicyyTLzYM+1iu2I8xGd3T66PT2zOw2e/BVzaqTQ7BSNAoXHEs2rGGQCo=
X-Gm-Gg: AZFdTZf3wtiz5nm+WfqgkIy8DFcXEXsNnskhHTstwUlvNSlA6Cik0WJfD5cj+fXkufk
 qce4TMgRtpq3gBs3pzVwmAPwm/T71lr7QtRRVl9qHF5xQbYLoAQeCYPWsPruPZhyvJ9qpqTYMce
 5XOBdWF/YKzT/OjKRKtiSi64NzZdu5LLOYwohFPtDux67jcURsdC6uEzdbSqF28nL+3ShMjdA5D
 a5IkBgIMRx4kuYMr3STiA7WNVpxGLxzhpy03yKVVKYJwKD8xZPWw1lNbcv+RX300jcSQz7eWvcA
 GEqiyPCnOU0YhvD44kNlU1XhS8qh3vwNi/rP5VhCOEOigTaoHK3ySplQWY9VL1zmFgGd16jLAJi
 vlohEIQ2rtgCiwaQx+RyF4X1xxAgPW9LZDDFl2M0pQDfc1hX84Ye6oxaT0eOHZT2N6F8JrZKmKw
 ==
X-Received: by 2002:a17:903:32c1:b0:2ed:1b26:2bf2 with SMTP id
 d9443c01a7336-2eff7100c7bmr32660415ad.3.1795027483414; 
 Wed, 18 Nov 2026 10:44:43 -0800 (PST)
X-Received: by 2002:a17:903:32c1:b0:2ed:1b26:2bf2 with SMTP id
 d9443c01a7336-2eff7100c7bmr32660205ad.3.1795027482912; 
 Wed, 18 Nov 2026 10:44:42 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6115f28sm18076975ad.19.2026.11.18.10.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:44:42 -0800 (PST)
Message-ID: <069c590a-7b30-4985-ab83-56150efc8009@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 00:14:34 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/msm/a6xx: Don't fail GMU resume if the GPU init
 regs SCM call is absent
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-2-e99cdbf3121d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-2-e99cdbf3121d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfXw6gNsLwvsgG9
 H0C7OQGMY09FS7B63xcaNHYwoHZs11/NvVnMJ49x4fMxSIPsU0XyNK802zPw8pO0pPNZMyORILt
 BZTYWIXaGPZusjDDkrjJIxELNHDpd0ceNEmIexoJ1kBSLEouH52A2ncoc5SaAfApZVU3I/GylX8
 ewR6P7/w6Y+hrmKOzxRnAjtDA7coVVBrryAQuxwpsMxQaX5V2KeY7pnq4yYofEY66DuWWKxAhHM
 OtIdNQ7yR7DPSWbdWddFBQJipY7YZ2h2VBMTggNLvgCS4SQZq3UjVvdzBrnU/8zIyUAf4UxpXpQ
 z4bQRbsUbgGCPCM1Eip7defs7qgP3ar3g2dY5LUgPsRMJENfybIXQWuGnMTYu1WihEcmU54wq9r
 PizQvQCZP7vam0j2ti5jUOZvAc/OTg/WiwaLXvz6oVPb2BK9BrAT4YfijOyXFpcsE5oWMoJ14KX
 29HG05R5vLWzNttr76Q==
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6afdf21c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xDuVsFAvjFWeh2iC3aIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 2jLaHC68x-saa2oJDXsFO_LDkqdEZSxI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX2vThT/PZd8up
 G7/ZzxqldoqOJnuzTMGC6/F6qHNn/KiLNStPLgjZwMv4wv9o+CzP8X85BO0HHjULH39RXCsm/Eg
 OmfcmHNof2AoJh++9z/nSfuFasNk2gw=
X-Proofpoint-GUID: 2jLaHC68x-saa2oJDXsFO_LDkqdEZSxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180074
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/2026 6:38 PM, Puranam V G Tejaswi wrote:
> On A750, A753 and A8xx, a6xx_gmu_secure_init() asks the secure world to
> program CX_MISC_SW_FUSE_VALUE through qcom_scm_gpu_init_regs(), and
> aborts the GMU resume if that call fails.
> 
> Some platforms have a secure world that does not implement this call.
> The call fails every time and the GPU never powers up. The fuse
> register is still protected from the kernel, so the driver cannot
> program it directly either.
> 
> If the secure world does not support the call, skip it, but still read
> the fuse register back. An earlier boot stage may have programmed it,
> and the features it enables, such as raytracing, are then reported
> correctly. If nothing programmed it, they stay disabled. Log once when
> the call is skipped.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Maybe shorten the subject a bit. Say "Make gpu reg init SCM call optional".

Either way:

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 0fa2d2091f3e..95636dabee38 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1249,22 +1249,31 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
>  			goto done;
>  		}
>  
> -		u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ | QCOM_SCM_GPU_TSENSE_EN_REQ;
> +		/*
> +		 * Some secure world implementations do not provide this call.
> +		 * Skip it then. An earlier boot stage may still have
> +		 * programmed the fuse register, so read it back either way.
> +		 */
> +		if (qcom_scm_gpu_init_regs_is_available()) {
> +			u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ |
> +				      QCOM_SCM_GPU_TSENSE_EN_REQ;
>  
> -		if (adreno_gpu->info->a6xx->clx_tbl)
> -			gpu_req |= QCOM_SCM_GPU_CLX_EN_REQ;
> +			if (adreno_gpu->info->a6xx->clx_tbl)
> +				gpu_req |= QCOM_SCM_GPU_CLX_EN_REQ;
>  
> -		ret = qcom_scm_gpu_init_regs(gpu_req);
> -		if (ret) {
> -			dev_warn_once(gpu->dev->dev,
> -				"SCM call failed\n");
> -			return ret;
> +			ret = qcom_scm_gpu_init_regs(gpu_req);
> +			if (ret) {
> +				dev_warn_once(gpu->dev->dev, "SCM call failed\n");
> +				return ret;
> +			}
> +		} else {
> +			dev_info_once(gpu->dev->dev, "GPU init regs SCM call not available, skipping\n");
>  		}
>  
>  		/*
>  		 * On A7XX_GEN3 and newer, raytracing may be disabled by the
>  		 * firmware, find out whether that's the case. The scm call
> -		 * above sets the fuse register.
> +		 * above, or an earlier boot stage, sets the fuse register.
>  		 */
>  		fuse_val = a6xx_cx_misc_read(a6xx_gpu,
>  					 REG_A7XX_CX_MISC_SW_FUSE_VALUE);
> 

