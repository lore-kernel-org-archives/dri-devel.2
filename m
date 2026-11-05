Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1B606A32F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AUZXkwZA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QgJbpi5z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D966910FF68;
	Thu,  5 Nov 2026 00:03:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA0810FF68
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 00:02:51 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4MFeM83209178
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 00:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9RSuIZdwtYVcc2DoJVsmwG7WZuhihyHHeboegvG5hKc=; b=AUZXkwZArcmvGexQ
 TQZmhATI0LtBwQwk7FyA2OyzObTgrdFIhZlSx7cVLhcg8Ds9mjRWwJ/b9xNyXr+C
 7ZrhTuEpB41c4slKvyCvJHCrJzTtkK0IyNUJ9dnFmYgSMLK5SsPQqorXZKOjXM1I
 7c3ZjL/PVtlhByF/694QQf2GFBtJntjViy6NCyd0KzFwEzEniE0fvRhuH0YQZK6O
 o5iXSc7jPRqy3Hug6r8vN6pUFKL+ihL29AQl4U31u53iSDdVlXS1CQe4a0nSkhZq
 iX7ayF9VfQLiq8aO30aTqO1ToqNH8/YUU/2VrYc//7JTr6uEWoVxt88flUeoQVah
 yaY7KA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj2877-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:02:50 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1af203073e0so2140919c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793836970; x=1794441770;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9RSuIZdwtYVcc2DoJVsmwG7WZuhihyHHeboegvG5hKc=;
 b=QgJbpi5zfo+69EAXJV8JYpmUIWnyuzZlFnhstrgTiJ3/h5njTLuV6kNZfSI6fjMyv3
 dzPInye9btIM/WkrCR0G4wildX7knD4BW/DM07BaQU4+XiLCCZUYemDGToQKd4+KOxx8
 0YWdcb6gQieNeyOzsox1N6r7OGgvdfPeg1LJxGJZD0vZ3Y/PiadmTPSdSFWeAkYVPlVM
 42+F/nDWLhOdiKXuSstAi4uVelggETi65vKVYK2pRCiWst3EV3A4wZv81PlJQOKkzG2E
 OzBChuta6WTTX/FaPBp3CMJ8P4EIINXxDQw+fSIjM5aoh9vw4xgmIa/idBFXrBJ0VLWm
 RTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793836970; x=1794441770;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9RSuIZdwtYVcc2DoJVsmwG7WZuhihyHHeboegvG5hKc=;
 b=ikvBBEfB4R48VYIAZoRoKon2L6ZsLrw5GGooHklpMBKNU4+FtHDHA+/14eVrfLUuyt
 8OfTsG/mU4s6qT8DksL+C7M5dvUBWIt4BoW2nmj3h6G9Q1kQ7NLPXfDJ8jEAYMGLibEJ
 m0GGz8neHstyjSphCspNFwf3UEnRea8fJl9VoB7N3+tjX1z3amw5N9phdcoFi/0p72yE
 Oa9kTZep6z9ERQ3Wft9+Kii7pf+9XyeranbjRd+sp+03YabtlFZzjrJYVe8hfsXk+7MF
 FNRgQz1+Lc4vGGB/HKbnrfhUBIqF6MC0UPMVhyZ2Z6oKFJsXC5avAT1WDRYs1EEHYwqn
 vJsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwueP8r5zebs+W06ridkwQXGkw32yaPPCmBvyFarV5MdAAyFcXGIS1h/gFiuvpIKaJl2LyBxIWGB7E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8YcF3NR7I+NcQPD+rZUU8hw/A4+C0qi7C0J/pQzgXlhKEFX1rI
 zb9XGVueqWno0YiKhCcgJFTk3UPnGpWiSBm2p82n21vjkCgV74VZJCJ93a0krjaJaZ6jlpbdMBf
 7EbbsMqjK+RimLLWPDcQeRhqw5wEOaZXyCtIqIR4jv1mXqPSaWWY7g29F7P3X7+VClo6uIb0=
X-Gm-Gg: AYBFou3lj3Vy7eAnFD2ZbkbCkl790Dhyb/6bvji/UNOjLiEe4Dh1VGOZBt9D/MmqF8B
 bdPYziE7Kg+sVuY6MGsyZ3D6NN/J6bQ5MWr66VbV5IWteKNXwQ1ALF0A8DejaBmD3dlYRtYoHAt
 F7w7plgnxpRBiR2N1luBtq3FmRGmhD2dAck9tuLUi0P56jS8q3+ZqKjBbpaaw1irTpFqiWdSwEj
 Xy5O5Bmu47ulwbON7HAV1Xx/CIc872qqsRwgcdTO076eXjCb3V4UtsCbJfccnt3E1vpbfkKjzig
 f/JUqH0pIJ6pozKY4g2Lt640RY20vnlHs4nkYxWlJN4Ss4QymK4AIkjAVvAxaSWXSsWJmQ47iq1
 yGFpSU1slURFPlxpJmbEvTJlobTT//mleuHZsXoQApgnAFuHsuVhpdMa381faaccuWeZ4Gzk=
X-Received: by 2002:a05:701b:42cb:10b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-1ac5fa237f9mr26890368c88.41.1793836969696; 
 Wed, 04 Nov 2026 16:02:49 -0800 (PST)
X-Received: by 2002:a05:701b:42cb:10b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-1ac5fa237f9mr26890329c88.41.1793836968977; 
 Wed, 04 Nov 2026 16:02:48 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b8822fsm13232698c88.2.2026.11.04.16.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 16:02:48 -0800 (PST)
Message-ID: <4d24ae8d-24a3-4ea7-ab94-2b8886668428@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 05:32:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a8xx: Fix 1/2b alpha filtering precision
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Danylo Piliaiev <dpiliaiev@igalia.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261104212048.21010-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261104212048.21010-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA5NCBTYWx0ZWRfXyaHOMS8rN3F4
 3q0NdBIbnpXca+h3/305GzH8M3XBfAo92U6Zex1/6GZR8tJn2cYQ9BNWMO81FNnH3jA4XVIw5dF
 qrirXsPyXao3MoA/kgHTyJmYgZAECcLYqS1sChV+tggdZRT4LOOOu6KPh6bddzNy1SDsxu9rhgi
 oKeC07Ft9vqOVeYutkC8L7IBNMRj258JRHwgOC2qTWRHNPg4k7YITa5OMuToT9QIM/MpaT5gD3H
 b1ET7doc5sYtpkJvQf0bNT1J2+qHLXH7ZuAiuMf1kCbY4DHKxewc7q/zPgUwTjDpxFC7PQbhWo2
 qwFmDBFHbgWjrt9axhrE6bRRm6qqdvjJob6wGMFjbbU1i6ik/8KkeuMcZqreK53BENxkRkg1JvU
 Fo8q2JVLAQY6ZstyEnc/op3Qd5EhwdKJWXnHV/eiEcyv16J+YqujK/NhQ0ju45A+WESfnI375Ez
 4+G/RbDPagnNZTxUkCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA5NCBTYWx0ZWRfX9D4KUaUqdnH3
 glk9AN6HkrCFJL3tA0p/9m6NMMP6++dmqWRdsC7IPxwBvFuOyJPDI87rHzLpNLdY1kEIEXlmz7Z
 eJL9+RHVA6q1I+TQ7BklgDjPHqoBmck=
X-Proofpoint-ORIG-GUID: qnoykWevuXBnugfZPPf6zg0Zl-jkRsRX
X-Proofpoint-GUID: qnoykWevuXBnugfZPPf6zg0Zl-jkRsRX
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aebc7aa cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V2sgnzSHAAAA:8 a=EUspDBNiAAAA:8 a=mnaISKIp132CONEVCwcA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040094
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



On 11/5/2026 2:50 AM, Rob Clark wrote:
> Need to set b25 in TPL1_DBG_ECO_CNTL1 on all gen8.
> 
> Reported-by: Danylo Piliaiev <dpiliaiev@igalia.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> index a7d9ccf26493..510c2f6017db 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> @@ -61,7 +61,7 @@ static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
>  	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
>  	/* Enable cubemap small miplevel optimization settings */
>  	/* BIT(26): Disable final clamp for bicubic filtering */
> -	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000724, BIT(PIPE_NONE) },
>  	/* Disable tag bank id hashing */
>  	{ REG_A6XX_UCHE_MODE_CNTL, 0x00080000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
> @@ -297,7 +297,7 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
>  	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>  	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
>  	/* BIT(26): Disable final clamp for bicubic filtering */
> -	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000720, BIT(PIPE_NONE) },
>  	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
> @@ -397,7 +397,7 @@ static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
>  	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
>  	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
>  	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
> -	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000724, BIT(PIPE_NONE) },
>  	{ REG_A6XX_UCHE_MODE_CNTL, 0x00020000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
> @@ -630,7 +630,7 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
>  	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>  	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
>  	/* BIT(26): Disable final clamp for bicubic filtering */
> -	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000720, BIT(PIPE_NONE) },
>  	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
> @@ -972,7 +972,7 @@ static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
>  	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>  	{ REG_A8XX_SP_L0_PERF_TUNE, 0x00000024, BIT(PIPE_NONE) },
>  	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
> -	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x00000720, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x02000720, BIT(PIPE_NONE) },
>  	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_DBG_ECO_CNTL_0, BIT(31), BIT(PIPE_NONE) },
> @@ -1030,7 +1030,7 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
>  	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>  	{ REG_A8XX_SP_L0_PERF_TUNE, 0x00000024, BIT(PIPE_NONE) },
>  	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
> -	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x00000720, BIT(PIPE_NONE) },
> +	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x02000720, BIT(PIPE_NONE) },
>  	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
>  	{ REG_A8XX_UCHE_DBG_ECO_CNTL_0, BIT(31), BIT(PIPE_NONE) },

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil
