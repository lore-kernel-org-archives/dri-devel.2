Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51548F013E6
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255B610E1F2;
	Mon, 16 Mar 2026 09:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqQRjCvc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jj2myALe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A604510E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:22:50 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G64kGR538935
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UtWXTGagT/GGBueURbq9/nje29CFuwHmLEoPSvQmhuc=; b=RqQRjCvc0rawgpoE
 OTePQPjeAADE3fgu7fHeo9i2Fay09uLE6T86LJPMaB3aQQIeOMxodoe70h1PA/VA
 YDTofbhkFE5OEMMPQeakL0fWNsMZThM+PK/9clgZ1U2sQ/PV6az9bbnODqE2GbFG
 SiCFU2dUJQfuYyAt+Jk4E/9jYE2nyCrrTufFYMLseooGM7g/RmucvIdexnDP91dj
 5IBMoqUJGyGrHyHyaVPiLtWqokxJgv0iJsR6vrTHVJYwlwdMHSliO546bpDTz/5P
 hYemKC5wdCdV74NcvUGMy2Ys6zfPDu4+3paH2XXvu1af7A/6fm9C12Z8OdZeo2z0
 dWdp3Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyy5n0av-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:22:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89a01982dc5so42253546d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773652969; x=1774257769;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UtWXTGagT/GGBueURbq9/nje29CFuwHmLEoPSvQmhuc=;
 b=jj2myALextZXg3KrY2KIiIZLeae0aqGSjyYW60s4kcYdIWs3Dg3mKF4DFhQrEDFf2e
 B9RjhovXLVfTgCdY0DgR/NCXUx1M3lLPpJeeRU6e24nXsKT3cPkyAoccs3mesC7IIkNP
 6Mac/ZNoIs1tsxFeNLP+Klzb3RqVgrig2cmyqUJqE5nRo/Bw03DpxNR1KpXREf/le2jB
 p3LEl4PFpS8SpiOfO6XsYQw//oDWI6yKUICVZgEzPybzZI7eU48tZqtVCgj8J96XDUit
 1PKfnkcqPkXkWejYSNcokbLjL+6sJltbZ+nL7Ix32NsZFYu1StOcO9lLbPyDX8yDa3Vv
 Fv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773652969; x=1774257769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtWXTGagT/GGBueURbq9/nje29CFuwHmLEoPSvQmhuc=;
 b=ntBDJkFMpLm7mmsGV/QOwTevbm9cwxaipuwyhQ5wIIZ7S4666+Z+eseDhqlPINVLDk
 if6KjxBlstHKX+vKNH2l0SE/PGYeYEROisnPpOC4LWOvJU8HV0116blSr2d0fNm6+Wgs
 +0pfkfgZsPcgylJJse/Ene9xsR3vxwr2mgm9HbmgEpbv5DodIM5C5kwFYGJQf2EmTa2w
 wiUpHavK7R5Ph2IkZa7i/avfxc0HmY2Q3nOL74BnHhl6ihgnNfN4kqimZsjGb/hd/Lx1
 NaHiUzctrPn4dHGqukC/JcYRp1PZOKPcZvd01nzGeczCfnGqpBEhH/y2U10det+KSQGK
 emiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjw0IdJUZs4lbuAiYgBlvxsx7wB9o+BXl1Pmq22wSfGhF3DTE7CJC8yUeHDqMW40PT38NgKLrtS2A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTFWPCEsa8Opx8lYNUh+zss2ziP25On2U2P9Jk2vsJE+8nPmdx
 zbqQ5R1EPd8wLBYUhNzMlury8uPUxyZ1fPeM+NzArW9VxqIMtTjwARO19UYPml09ibQ/gpct+sm
 AmldXC+LcYSwUDYkctKhhh5/lABKnCQ3RDc+ecDpxiHl4QuRlt4+TiDX3r2NivaQ0zbm0WzQ=
X-Gm-Gg: ATEYQzzWIuH5PhCS2wvFu+iRoPFBN/HGfm1lgxszi4YIrNAbA0sN/M/+5T7PDBClGUJ
 ol50HI5q5AVTQLzFEUxMJhcweCSzO6CDaos1cIgQyshQnQbhsqYij1PBTqkISAJjy934F7RwnCK
 UBYbaafhd/HYkxSyYeUKJjZJSs7t49Sp+rlMWplo3ileiTSjxTO77C45wBVOCFXjwMlAFXbJijy
 hXQftYqA5XApnefyBPU6VlRA7iuEuWZKJ1eASw2ffKK6j2uYOfH7nfSlFAhhaR9IFFRA7p5Frxd
 Z7SYpB9UNkijUB2bjlYmfD3mWHUs/YEtNEcn79jBqs2BdH7TvdtxnMIbAhGwOwG6/Sadf6aCaSk
 Uni0tooXn13/cccqxBwEYkxakF3Zw9G7SILf17wKtXqGEed8cTkSBqGd3q2HXFxOLSWIYm+hYfJ
 XfNBU=
X-Received: by 2002:a0c:f105:0:b0:89a:7d14:66d4 with SMTP id
 6a1803df08f44-89a8203defbmr112828846d6.7.1773652969189; 
 Mon, 16 Mar 2026 02:22:49 -0700 (PDT)
X-Received: by 2002:a0c:f105:0:b0:89a:7d14:66d4 with SMTP id
 6a1803df08f44-89a8203defbmr112828636d6.7.1773652968804; 
 Mon, 16 Mar 2026 02:22:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cc220basm525813566b.28.2026.03.16.02.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 02:22:47 -0700 (PDT)
Message-ID: <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SnISUqu_hhfFDLutINIRTbG_4S_yNZOj
X-Authority-Analysis: v=2.4 cv=QOxlhwLL c=1 sm=1 tr=0 ts=69b7cbea cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e0mgrY8X18LXsc_zQXUA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: SnISUqu_hhfFDLutINIRTbG_4S_yNZOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MSBTYWx0ZWRfXyEg+JzzGru8N
 imkUfCtNkEecGl43TTxW5HTjwx0ML/6f3e9VxWSIuRcZ6+Kggk7KHK5Tnw1bQ6oFjrLfKCGZxM3
 BaLofY4zL0VOXvXKA9cOI8LH+c8n7fToF7dHa2NeTlk3qssl65Dsxmf6iZyMuLN2mEC0E7Wi/BE
 ZOO1neDUzJNqEw1xeEAYMJP8owTEMJc8vjQ43uO8XUsS1NgoL47gug/wgvMUwPLgoPxfhusHihG
 gxVmPXtJYEtDbrHO8K3FwXddFM2kN8SkisuNQbXScghGp1qCDHXCN9YJxxBn5x21oCwUxZZ/3Ex
 7OCtk6lwigJ/Fl931pBegt/hU+Zx+Eh/Tf/7fnmdovf5ElAPyun5PuHNc9QpCzR/HmoUenVjtUn
 0JtMdXMxsJdTg4tZE+d3/NWdRw1m+OKg7TrpkpcquR/PGz//8KkSG99rc4+FvCYhiIbSH9RvCFY
 R4sepcJlZ6roxF8Nzmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160071
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

On 3/14/26 5:14 AM, Alexander Koskovich wrote:
> Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
> GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
> to family >= ADRENO_6XX_GEN4.
> 
> This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
> an incorrect GMEM_BASE which results in severe rendering corruption.
> 
> Update check to also include ADRENO_6XX_GEN3 to fix A650.
> 
> Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")

Hm, that commit also changed the value for A730 - Akhil/Rob, should
that be changed back?

Konrad

> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index d5fe6f6f0dec..0ac3fba5c277 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		*value = adreno_gpu->info->gmem;
>  		return 0;
>  	case MSM_PARAM_GMEM_BASE:
> -		if (adreno_gpu->info->family >= ADRENO_6XX_GEN4)
> +		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
>  			*value = 0;
>  		else
>  			*value = 0x100000;
> 
> ---
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425
> 
> Best regards,
