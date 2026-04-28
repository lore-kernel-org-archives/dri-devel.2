Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC96FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C4310EB78;
	Tue, 28 Apr 2026 16:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XAOIAPWd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NHk5mkIZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7705010E2F8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:40:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsCHo3634329
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kLFgekwjjAN3eLuAfL7QdjfZhVRek/Ch91VNErfxHxw=; b=XAOIAPWdaZNrgqfv
 6qwH9I2uHD0hYKaVwSWn0W4viuxiLiIhsAc/3Feoh6e/NmNfelWfdVaH4f0vGIjq
 BWMGUvGtbaNj8MVTkkATX4oRvUrUCU/rTNvUL+5ClBBjjAJ2pFJ6VcnrYLTxi+GP
 Q/FPBJ4O3aaUvpe4NmGRoDiLIR5hutGl+Fvqma+zbtcA5iUAyqA8h/+MXyL27WHF
 Cw8wJ3ffpgxEh/SMxlTksy01Z6++zZyyyCvW6+XI6A8bTULGQ3i64MZoH1u6RSUE
 qDyiZcsnPAw3bLeRAXa81LAZL4+ZaEtGAbiGpmMlgOY/Cg7rSBY+/U2opjv/x1oE
 C3VKZQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dty87rd70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:40:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35dacc40f92so11946668a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777394434; x=1777999234;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kLFgekwjjAN3eLuAfL7QdjfZhVRek/Ch91VNErfxHxw=;
 b=NHk5mkIZR4m5+sVnknUGJU7QblTy9QU1wa9JgPYrIEuBHrADnAloxG1XrJ3qMyEmaE
 C1TMM1nNwAIJ9Pxhdwsvww+Gx1kAQ2Rt0PFmFTF4Y+fWPnPXEkPEYZvcNAzF2jc47iCs
 zBuJ1AR3mzsxky1AnooorQ2mZ8mlKjtL/9nRoxs8MmhQCpiJo0mT7jUXQsk8iHZy6Xk/
 JC0GZ2qW/VzKn2mVczYkCbj0lshmIwxpwW1ebMoqOXaYM2+YSmWApUc5D+plcCk+A2+H
 c4vEyYfqnmxOKBjP+lDR+NXf9pymLd//BnMBAn25PP7By4Nnsb0dGalvPo/AAhED4EyD
 6+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777394434; x=1777999234;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLFgekwjjAN3eLuAfL7QdjfZhVRek/Ch91VNErfxHxw=;
 b=eC7fXoZJbNfyuygi2GvJvii8C5/zTCII9FVpACpFi4aY5xYXNzG7vAwoyqufRStm/p
 DqRx8dO9alL/YdaNycf1O8BdlXMItk3Ni2Uh64bF5UW1XN8FLP6/+YXqsWM5a0Va6UbN
 XNbZGEHPh5j0jieWGOF72XX5mp+T7XXYYBeNL4nozzaA2iW+/PBglflSsO0YsLYIiCH0
 bQWnllACa8sZPuF8GZLJ7Y//VGzCNgB7Vyxd/qycRQL7mX5137RCvVfIK4DoenWlAkYV
 WJRWlXNE7MOmgvNLVdR+RJ8syxruQMud4jWzxlBrhRC/kLQWUNBnBeWXunPa2v4oweQ6
 JsFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wJOieM+KfsxgQDndzL63qzJcTg2Nrd7KDJPhJWTyOTVoQO+bp7WbSUjatlK4hmKW3XrRg/fJ5HEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb/ZDYHVWE9PTda8zF8niLr5XJnvJjUldqSsiG1fvSywi8wlhQ
 hW6JjwaLs0Jt1a9rsbgjQZw4KyWs92zelek/sCyaU2FPAv1KGPJ21ufyTIKkAgw8hwAxaqMowaN
 FEHCDmB40j0V2mnNFMhFBVNaPb6P6pwxjXbwhMQ8v09DyQCS03LVuTscCi/X59fw+HPasL8E=
X-Gm-Gg: AeBDiesj0vdRN4FzkH9Yi5l96ONWp+I/AYBeGUq40GeOC6LxLxtzwjynILxxMiaZ/mi
 g1KyJ5XDcunbqzRtMkSqxRVYoGG/FMX88IYg1A3PAe9Kd4Ufqknd5BaJotu41UVaAHJkUo6R8XP
 4PhpkbU9iupemKcMoOvJjvJrp76zVqbmqybFp6n4cV14PnoBa5ijTutdNB3pi18F/e4EZDqgen1
 zbucsUlLkmidBzL6idnilopNFoDdd1gQ9HBnQebOEUilwgWMfqQ9GNt+ujqNMv8mreYJt2jvLhY
 KeyHJThXcdHCcYfqmFf1dBi8cpDHubzl6E22WNZA2Km1obImGZ8bKg7FWQQoD2LEJysZFvj460O
 9WQIJhdbnZdSyhwk9AwImh5KmK3jABi7ZoxM2bR86dMLGgN9YqAF40g==
X-Received: by 2002:a17:90b:4cd0:b0:35f:bb33:d72c with SMTP id
 98e67ed59e1d1-36491f891f9mr3691696a91.4.1777394433972; 
 Tue, 28 Apr 2026 09:40:33 -0700 (PDT)
X-Received: by 2002:a17:90b:4cd0:b0:35f:bb33:d72c with SMTP id
 98e67ed59e1d1-36491f891f9mr3691659a91.4.1777394433473; 
 Tue, 28 Apr 2026 09:40:33 -0700 (PDT)
Received: from [10.91.112.28] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a011512dsm157755a91.4.2026.04.28.09.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 09:40:32 -0700 (PDT)
Message-ID: <e1a94dda-1a4a-4034-b695-a7038760c53c@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 22:10:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Check kzalloc return in
 a8xx_hfi_send_perf_table
To: Chen Ni <nichen@iscas.ac.cn>, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: sean@poorly.run, konradybcio@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260428073558.1234238-1-nichen@iscas.ac.cn>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428073558.1234238-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=abJRWxot c=1 sm=1 tr=0 ts=69f0e303 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=PRwU12TgqmUXp5Sp-ksA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: NayoR-lw-ilbAupMtRJ_UI96GvacAZAs
X-Proofpoint-ORIG-GUID: NayoR-lw-ilbAupMtRJ_UI96GvacAZAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2MCBTYWx0ZWRfX63JVIoRbhSRX
 g6fzlz8skLzil5lx9SjjGLB8sprl09EHpYJO5gPldZpbsKWzrOD8WqizXeuRInsjZ6leuCudzg5
 weSnq6/WX0q8sruvyQXtiXNwHvQuyyRb5+KdMb0Mx7E97teL1ifjhsCXHbjG59EZKRNCnqrq7cg
 McvNP7USfU+McPbcar529AhABDavqv8eHK1MT+sghptztgiwRmcfqOh9fDnDrqvf2BK1docmyPX
 pEQESI8QeFzO8sAzxZZDEvO0nXf8Md+NkjLPju6b7yjNhfNexdesMv/DDV3J/I/Gj3W138jbOLq
 AFvb9tws41xxn1eSckxwYigwOziyyg+ruoSREtnHcTRoKicV8fRTXi6ldPkIhGA3WPX5DryY5Ad
 XH5Nwv9Gt2DM9jXC7hQRTIQ4yBMzw7xpbwHW7n7euh9ZXr4FF0rsCW5R6aveiup03k4XBfZ75aA
 dlF5YGXLkdgk1E7Hhrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280160
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

On 4/28/2026 1:05 PM, Chen Ni wrote:
> Check the return value of kzalloc() to prevent a NULL pointer
> dereference on allocation failure.
> 
> Fixes: 06cfbca0e1c6 ("drm/msm/a6xx: Share dependency vote table with GMU")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 487c2736f2b3..186a73c0b99c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -289,6 +289,8 @@ static int a8xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
>  		(gmu->nr_gpu_freqs * num_gx_votes * sizeof(gmu->gx_arc_votes[0])) +
>  		(gmu->nr_gmu_freqs * num_cx_votes * sizeof(gmu->cx_arc_votes[0]));
>  	tbl = kzalloc(size, GFP_KERNEL);
> +	if (!tbl)
> +		return -ENOMEM;
>  	tbl->type = HFI_TABLE_GPU_PERF;
>  
>  	/* First fill GX votes */

