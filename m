Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C01606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CIcjMH7m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KD/y85Es
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA0010EA6D;
	Thu, 26 Nov 2026 19:42:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931C910EA6D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:42:28 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQFtvkb2835001
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fhRNdMl5UxG3D78/zB54I3eapISFAykzMxNkOQtD+wI=; b=CIcjMH7mZVk621ON
 XyRT18DTnvQMl/DV23mpSp4rW0J3q3RwCExsHi/HI8wXPP19OEYQ4ZXNl8Q75HJQ
 EHQ6fgcGYCnO3Z22DE52lm+HBIFIBH29WHALAaRRFFfmhGqpbQzYA39ZMWvUlZHr
 sZ3VXABeqGmyiENsdV4Q0ijhq9k/KWcGptVhGTRvUl9Ac98yHOQaTkyx9bFzGqo5
 hi1KfjKlqdJAnX031HKlgRd4GDHPJ/tqm75qSpD0DdNc4uwSTfcYGAdq62qp2oY2
 NQcJzZC2Q+7JF+SvqT7KCKEMkG9HbkuCKOMqJcFbicHzSIYsOWS/9rpspiDuKIHL
 8ZFHSw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqgwvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:42:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-382af5cfc58so4008612eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795722147; x=1796326947;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fhRNdMl5UxG3D78/zB54I3eapISFAykzMxNkOQtD+wI=;
 b=KD/y85EsOXXEitp+xhMBuYQgM8nvRMAseQxbIHbKnrh0C0DpiXvsAC325pZz/IATaN
 hJChCBxZpgAq9VAaKYijVnfSuvSQMvWIAPUPRqtoeywehIacSy9Id77lQBzZx2s4kwka
 FSp+Mjvs+hMkzNumusy0kgF8JDY+UMtqd54HY0E85IAOQ7byFS2wQrGi9hID/ZKTXsvF
 J99sXs1CBoTcu/2pOjkZIC/zNlFCH1tFa5e7XUZv1R1eLtphIXcshUWnkt6uMJcs4QkM
 b2gz2SS0MLf6HOY/xyz+ADDvaL15NU1GyJ6y1oqX8a+gvij+mAUSYrCOf9vCZL4hHYNH
 3e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795722147; x=1796326947;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fhRNdMl5UxG3D78/zB54I3eapISFAykzMxNkOQtD+wI=;
 b=Vue5Sck1+/wO1YFGsOrhZftUDQJH7LPGMGj7fGjzsdIl0Zimefe7ci1LKgJK5w1ty9
 PiuNl/+bWwvPnUVXUlm9BgaMUxSXrztBgKxMoQIcd+c9snV2WHUfV1CjROQ8opxTsZG8
 zWqS/Xi+jFVK/jIXviAxYePIPSgEPIe8oXOo6KSnivJvs0/n16tb/dW4av235yQi9eQM
 5Cei410yEYZ6Vi7O28Dq71tFEf16UDWNb3ZRnSqAlvwwl+hYg7it6P6TnCrhK7/w4Ddf
 8xAO7yKphbLXT/SV2NEd3rqMobOVFO50SEqSaKxkBUWaMZhv7DqoIayQne81HhOQ680f
 utmg==
X-Forwarded-Encrypted: i=1;
 AL+hErE/Ge5t7C8Hz0mx7Jb/1mP7TthiHQ+ou0ipD3TDiOtEoZLxfh+DCvLlv9AUG3dQpaxJOg9CNmxpRU0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8VGI8lA9hmlWek3fLoChZzYC451XZ0qyjIcFewNBtGeoCOwHRv
 DEwIeVlqqMOyjOvXWPEnWmYn5BSMUXxYjKQPYOAEF6iaA7UlOPts/Gqq+kAO2124zG6cDE54dg9
 vCdTyJSNK/JbpgkbdvsuNna+GwT3SghlqbCnONyGvw7U9bJeLDHgIKVML9D432tKlMnhUcf4=
X-Gm-Gg: AZFdTZc8sGZD7x9GN4Arij7ePJbvRgzDxv5FAlMktOZs0fOZhe0XHl53/VGWh3H0NmP
 xB6C9D5bH4Q+71Grdo88UGkZVDI1AyTO9iUhF3qrp1/rnMcBCqVlE+Gneuah/vYJa3095MT1IbM
 20ziE2E/8IZ/U94tMFeIwFzRnoVqphR4mLKTQajS0vRiBXOOgshFrA/uG2XBmbe8aq0oRJms3aU
 81k/90CGZqtYObKN0DnCMOZa6MyT0aGmIsvrn1qIlifBSWRymkxSYujwFAM2NIcHVeEzhMGz7Mf
 GKgmmvI/dxSlBHrYI5BrzJNE3hNZql6e9AEAzsarqIjN8nxlIOIYp1KbVg7KCYxmko8vxv4gku7
 wiMDVDoexl46q2jao/u2pUvbIFIea4C20ELf3uPpjgtpBlFsSH0y9p18aK8jWx745aQUrN/licQ
 ==
X-Received: by 2002:a05:7300:fe4c:b0:386:9b1e:dcd2 with SMTP id
 5a478bee46e88-3869b1edd57mr19615023eec.20.1795722147442; 
 Thu, 26 Nov 2026 11:42:27 -0800 (PST)
X-Received: by 2002:a05:7300:fe4c:b0:386:9b1e:dcd2 with SMTP id
 5a478bee46e88-3869b1edd57mr19614999eec.20.1795722146941; 
 Thu, 26 Nov 2026 11:42:26 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm73795985eec.24.2026.11.26.11.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 11:42:26 -0800 (PST)
Message-ID: <86e748e7-1cde-41b9-a1d5-905e62a44d36@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 01:12:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 8/8] drm/msm/a6xx: Wire up IFPC on A615-family GPUs
To: Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-8-6992841a9a32@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-8-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qdNaWslD5KwDLkiERsxVJhhzLEK9kVfW
X-Proofpoint-ORIG-GUID: qdNaWslD5KwDLkiERsxVJhhzLEK9kVfW
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b088ba4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ZLclF_L0AI5UrEzEu98A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NyBTYWx0ZWRfX9yVWeLNGI9qD
 zFTGzEvldJxL3YKDetZuarLlpN+3pLjWeUKgwkRhK7UeZCpXjYxA4uCZWBrjP1+XUAJ1sEei6+D
 JFSzPxF3TIPQJrGsyBP+CUH0FisQdxs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NyBTYWx0ZWRfX6lxrOTLLkUVp
 VGNmjqholgbSTkI1HC70M8yw0HTxyz3JZ9tXLirpbCn0MxNsmsK/jD5CGVA0o9HPMCmYn9iddV9
 x5q+3SuNHe8mlTlxndklUg+adr2wQH6WKdtuUoNpzRPJSH+AwdkGHR7hKXWc1PQy+eV7018JP6l
 ET9tMJpI0otEC4Nwc4rHuvGBPygW4YnBspnMOCPuoD76Vk6UfkqBo8GVNQcUVU1nspWuK7V2V3B
 jQndt4Fys3R4oOq+Zx+aiYLwqY1/XQTadH8Xf5pb6hyCxptOOwOYVNuSqDCuvDOf8NmMvPy7fIi
 StszObUTjhbO27DAYztFisU4CID9ehJxao4PhcxGCpgYOtOzVSL3iUHqVYEAVRU8IA+mAf7SHgw
 +cP+laT7VbON5+3/1qG0A0YEVq6HV3HcrEMUb7u6el4nNc0QqGaNdS9K5R/yvH6VhjGJPeWeuDa
 5/rak9EXNhCfTAhfiQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260077
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



On 10/30/2026 3:34 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> They reuse the existing tables, so just wire them up.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 2d59f7735c90..257771d4eb4d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1012,7 +1012,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			[ADRENO_FW_GMU] = "a630_gmu.bin",
>  		},
>  		.gmem = SZ_512K,
> -		.quirks = ADRENO_QUIRK_4GB_VA,
> +		.quirks = ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a615_zap.mdt",
> @@ -1021,6 +1022,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00000222,
>  			.prim_fifo_threshold = 0x0018000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			/*
> @@ -1044,7 +1047,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a615_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1052,6 +1056,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00000222,
>  			.prim_fifo_threshold = 0x00180000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> @@ -1071,12 +1077,15 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a6xx_gpu_funcs,
>  		.a6xx = &(const struct a6xx_info) {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00000222,
>  			.prim_fifo_threshold = 0x00180000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> @@ -1102,6 +1111,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00000222,
>  			.prim_fifo_threshold = 0x00018000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> @@ -1127,6 +1138,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00000222,
>  			.prim_fifo_threshold = 0x00018000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> @@ -1143,7 +1156,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_512K,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a615_zap.mdt",
> @@ -1152,6 +1166,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00000222,
>  			.prim_fifo_threshold = 0x00018000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a640_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> 

