Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDF2FEEF55
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 21:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7F810E4CE;
	Tue,  7 Apr 2026 21:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOFsKHBp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DI7El6Mc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B7110E4CB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 21:14:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637KABfd3815234
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 21:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e1Kutq6gg7YsIbs7+s2mX6Bpa2oe9QoQec3Qm6sEQPs=; b=LOFsKHBpQitMeY9c
 aojgScYXyCWOxcgZhyCgBYPSQEixwd/0kB+woNggVOUIfgfIL50JFG+Y01acYsfE
 cVxrR0HR+OsnVgZKe7bks1CM6IBVFrir8JKsz7y5relci/Za9HBGkspO4tgeHTkm
 miXRmFcjgqrFYwuXEhOIVgffdGpagyFSN0ArsqcUYgekaU4lIzodYcBhW4q1znWQ
 nKEHtAaFnrfuvUJgW0GEDR0VqO1kL9aseXIxjW9gMTN6v8bL34UHg2ndO9Ra7WDm
 fDvfV8cNxOaFFAasjDtHTuJ0Itf3yqaOXYsfsIIaW7gciUfIHSTs3iPiJP/z3HbX
 R8zeJg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4vndv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 21:14:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b24611696eso40387415ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775596460; x=1776201260;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e1Kutq6gg7YsIbs7+s2mX6Bpa2oe9QoQec3Qm6sEQPs=;
 b=DI7El6McqLCViBb/8UsJmOOkJg/xjn5sgOUuHOWBLijc0PC1Ldgb/puuGjlvEeFI+N
 4xNbs9erXoFAshiQjNPYSHlJKlZmWjMLIG3zpaRq+UKsP/eL6LvUHLfFcauQuyGnUgot
 AIxPBL8NVTMfzW1xC3uWw+i82DurUTzqIJ8rhujj3rQYgjU7qL4qHtiWEhydM/fBrJq/
 rJO9osyu0d6YKlbDP5pkVv0TAJ4Y6Lh+O+/uhOgHRB67z1Fq8/2heIOb0jO5hGT4LIbG
 GPYty0IVZBjgU/Cs05q9IrbXdtEbWTsqJZVs7haai5OYPMdznpmP7zwRqpksSZkKdO3D
 P2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775596460; x=1776201260;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1Kutq6gg7YsIbs7+s2mX6Bpa2oe9QoQec3Qm6sEQPs=;
 b=W+CeuMrMbmUwgKonvFlWbJSk9Bnj/gnB4FGFWAY0Vy6ENj5+esq1jN/KjkbGkN+g5i
 uxp9Non1058XkNaibj9NoxNXhsAVAFoAw6Q70dxr4KCwuRoNqdpAhkH6dJRGGhmXVwd5
 Ve+d3gczoDUV1yoQpwnK7lIDh/XO0QdmIFVOoekyRXY8a1XsrAH3ZDt89wcCNyZ5cOLs
 Itd+CufcDXAs0Wj+oI2bQ1CbSq/+UdT/NouiUjAFDwVaFX4A2cAppzyJEW575gc6xO74
 Ahxxs1V64hGRHGiYOxm8dEuV162Ij1ci6mKX9nhjiYEFjWtVcLVb4eb5j8A72c7EPWgp
 TgMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3bhdWGhJc//ikeQ372lLSpevhaIvcvnSKubxJc7tcdJEfXQWvt+BcpSHgAz+HHrhnuR/xI7fa6rA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdJiS2T8elp1X3MyRoXAi5VjHLLba6lr9CH8t8wsOncCXmg/K+
 I3JNCOdlWyeHf5H1/j1pnMeyIFiLOTY3Whzwr0aVmv+GbLZgMUOx3JFWDlssxUkqgGMmq5BaB10
 MvorvSvL1OCbK62uO5gKDWFlpwsukJc5SbKYfnmnO6flWngKyrnbdFj1RWHYpYoct3TiI2TQ=
X-Gm-Gg: AeBDiet8T3q2Oq0IVnyg/Vpc6EwgyPxcFX0pKCv3FeMtjYpM7bCGYTjKgGnn7uuQ8i+
 m8s6lrfZI7n9ck5lB89aU1Bag2tLHWsc0nVEnMND4viEbOV8htxGibqwoJibL0/Dm15Ez3awKzX
 NpKzGxlRQfuji30xpe6eHE76t5TKONmvYBJaJb5TYvE/Y6FAgJXs8Ayv9qgIkzQXT9k7zIqmDOl
 LyKu968GEyA0gL02w5GQyrtzKZWBPXBXCEMP7uFT8jTy5tV7V0o1T72EtrmjyDdu3vENvnjJLq3
 xBtffie/oQcJwrCAvy8116qri6K2iTft0aVtU4vSbx3ltq/Xa+0ywWvgn+jhQCXt4W+e5ChYMCF
 R/rh7RUbXMKGrzyzohcVfxmaNQUh6KlkWpMOT9pi3dc2QUw==
X-Received: by 2002:a17:902:f78f:b0:2b2:4d78:eec2 with SMTP id
 d9443c01a7336-2b281821ca2mr197860755ad.18.1775596459668; 
 Tue, 07 Apr 2026 14:14:19 -0700 (PDT)
X-Received: by 2002:a17:902:f78f:b0:2b2:4d78:eec2 with SMTP id
 d9443c01a7336-2b281821ca2mr197860515ad.18.1775596459201; 
 Tue, 07 Apr 2026 14:14:19 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d233sm186754435ad.2.2026.04.07.14.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:14:18 -0700 (PDT)
Message-ID: <f85253a3-e03b-4f33-a7ae-df18ba01fd8b@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 02:44:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/6] drm/msm/a8xx: use pipe protect slot 15 for
 last-span-unbound feature
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
 <20260402-adreno-810-v2-4-ce337ca87a9e@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260402-adreno-810-v2-4-ce337ca87a9e@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d573ac cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bYgO6XzdekrPMLAnqt8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Fby8SfzBkcGi3LIUx7yxp-2kPYcasKs7
X-Proofpoint-ORIG-GUID: Fby8SfzBkcGi3LIUx7yxp-2kPYcasKs7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5MyBTYWx0ZWRfX99YhTpd1sxts
 E2pn5XRS25BdInLNkdqv+VRXW/PDuG2qWrrg7+Qys5vr61K9h5OD80GFWycYagJGkERPnAIFyp9
 jk2Lb1e+CPJLxYEzt6yBssVAZ1AcPkxexCHhRle8plXCdNwz8xBpnCm1gpq/fC89F8a1H12/zX4
 L6eO/ctB5O//pGK7UwbxLibEhozLTQFqG1MZo5qleKJ++AEh23HA/FHH66H1EzS1d2twaQGI1pm
 KpI+4vDcw5GvPpYLlLS82me4Nv3yllfLO19p5/KjSwsVVkuY3DR3jwtWhwj1DvNlQA5514/CBGu
 xcTxcw8vRKBVhJqSasCa7ojWhFBntvlIEhSD/LqrHKLB5jtODM2YecIPrvGH2ytYGBhaBjDLOMO
 Mh7QILhLi+Kf//NbpS65r/dhdz2BJUt9MCAj4EgCyhoUpaXGZxyL//cHr0ad3LrHAJxRqhjD21+
 L9S+uWtWvaD0FhwukHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070193
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

On 4/3/2026 4:39 AM, Alexander Koskovich wrote:
> A8XX GPUs have two sets of protect registers: 64 global slots and 16
> pipe specific slots. The last-span-unbound feature is only available
> on pipe protect registers, and should always target pipe slot 15.
> 
> This matches the downstream driver which hardcodes pipe slot 15 for
> all A8XX GPUs (GRAPHICS.LA.15.0.r1) and resolves protect errors on
> A810.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 8b4b022d9a6b..102d5e751536 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -252,11 +252,12 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
>  	}
>  
>  	/*
> -	 * Last span feature is only supported on PIPE specific register.
> -	 * So update those here
> +	 * Last span setting is only being applied to the last pipe specific
> +	 * register. Hence duplicate the last span from protect reg into the
> +	 * BR and BV protect reg pipe 15.
>  	 */
> -	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(protect->count_max), final_cfg);
> -	a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(protect->count_max), final_cfg);
> +	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
> +	a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
>  
>  	a8xx_aperture_clear(gpu);
>  }
> 

