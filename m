Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F0606A32F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TIOSC20C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YUOIosSF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A80610E976;
	Thu,  5 Nov 2026 21:39:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DABE10E976
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:39:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L67ih2891012
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C/c7itDsVVLIt8oIhrEQAQGvpBCCFqMAiXSmwOS2mWo=; b=TIOSC20C0vzukLEm
 C29z/egWfChkQf/y89hE7R3EwkDA7lhYGQr27nLSLQ3ZBSacOXIVBIv+wZ5ZpbDK
 xN8RUmxB+O+w2JOCj2UB/Dz/D4ZjFwnqWz+I/W6rkxh0poejW+5SdgV4FHwhC/Go
 nTgBDQpv9HehWOX0g0LN4a+vadAbIFPdi5Mh2fHAUs/qbieXtJZjsV2LrvPNpy6U
 IIPy+nSxjvZqEd0bKGq+4gBFeoE1rT3zddF9RtUFGRS9gADj44VVpM2Z8UlXnfIR
 heCjnkZFOgoKkAeKCcnE/oKa4npyyajSd3QC3loIr9Wj5zlPrv4pgAcCQflViHWy
 Myq2VQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs14gg6p1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:39:22 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so131914c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793914762; x=1794519562;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C/c7itDsVVLIt8oIhrEQAQGvpBCCFqMAiXSmwOS2mWo=;
 b=YUOIosSFIALfk4hvq7Cn8VhSVkp3W1qShPZF9od6J4AxtV1z8PwW+QYdtd3vd6oR7Y
 vqsjvGR4yyomecyfcXMRCV1aipWeIgdNMOIDPgsFeI8FF+/zJV12wmfLOb6FGa/eAlvo
 lfT2lF4HwtQ0X1KDGhrowqAC9rCIum7woXwJGdbWXhfNvywfz8D4gO/v2oikG6qfesCb
 yiI5L8Qiq5iyAYZS1p6d43XgDJiflcskzp12rQvRfNgVw8NAT7Q/36wBPLEeht+DfNRP
 tTH0ar4okFC0YzdsZLD1Ur+VajIV6JO59+mNqd6g+5f4Z8/3v83wTdeDBhlrurhsGgcw
 xO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793914762; x=1794519562;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C/c7itDsVVLIt8oIhrEQAQGvpBCCFqMAiXSmwOS2mWo=;
 b=sJfgAd93/r4GuzMQCokHP8XmQ/HPGYioi35ywGxa/CKhORz7n64OxkhflGlkBNw3m8
 cthJ7WuFITwzr1HmRM+GNmkd1ZYiNQExvtPHKzsEKFhA9rV40S323AHmNoWsWeVz9JgB
 nI5dyplTq34fdqgk6QpFsx0n0gt1EcrsR3KGFrJpdkliLzEXoIwcv03uhpGZa7gMsNLk
 qIl8Jdv4mgeM3KIOTL9+0iWd6uiH2eaPh/GKMIWSVn8/eP9AnnOwZxHA37koiXYkOcIN
 rwZIbyBbcA9a+INYup2O3fg+QkNembGmLDPzXjsNmvJK9rsANjUey+2cLWWBSNhOeG2z
 7/5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHyfxOL5tux6jIyhnJrw6bQNU+yxvkbfOAAtj+WGAA9r71vgFff9zE4gvFmK9iRoDocp3ICd41r1Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KBtIdoF/dy/lF1uvRzXLceWRR3/THg+H8VSnV/y0wv9Nfinph
 cqWzLXVFjpp5gn5BtwvAEMnvfb9/ltNZyNRbni9Ge1pzIXMA03wE+VyCtGU8INdh5pWPkxuHAkM
 HkeHG9ze1G4y11ABt9DwDj8bmc4/p+YUL7BdX/ZdpCJHeJhGjrZcpl/no4UsNmJjIhSk5tgE=
X-Gm-Gg: AYBFou3TpLoJO3iHcs+M1mTs6x6/dXL7acU7Eeh4/FmIoNmKhrX9LO44YpWBvLYoYSJ
 L4TrIUVtDt5HRigAUd0aZDN7w1zMUDbUoA+R1igmVGjvJJwwvbU5pVfdMfkYpqN42svP89PuEIT
 jsLCRMXOylfnJEZ2523b81exxW8ag4KcCt1kp6vusrRx+jrhdpDBlZOwEFfx5A4JJDyhGZNDu3O
 I9ZUG3VmByuPXOxNVAasWAraq9aEQrzwfnNcFAbvKzT/H1Yez9cFgZb39mSzIZQclFwFDIOwr/L
 xUPVrLLtK3w6H4UBFyf21kVfQTxzjePZH4tLC6L4r0RvslqQd0Ivm8TcoMJdc7IVEMWcPaepWOL
 wGdvdZPSfoYYFGLD03WEapcAl4YTvH2tqiGF5/FJmmrnlPAqjBUra/iGkmcG87iR2VPj/TmE=
X-Received: by 2002:a05:7022:3b81:b0:194:3a84:e67d with SMTP id
 a92af1059eb24-1b25d38b6f0mr402185c88.44.1793914761713; 
 Thu, 05 Nov 2026 13:39:21 -0800 (PST)
X-Received: by 2002:a05:7022:3b81:b0:194:3a84:e67d with SMTP id
 a92af1059eb24-1b25d38b6f0mr402157c88.44.1793914761234; 
 Thu, 05 Nov 2026 13:39:21 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b8822fsm22952190c88.2.2026.11.05.13.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:39:20 -0800 (PST)
Message-ID: <f79f25cf-4b71-4942-84d6-dadf9b5fc52a@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:09:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist
 entries
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-6-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NI1AaE6g c=1 sm=1 tr=0 ts=6aecf78a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7x8pgU0wZ-WXSjAT5BsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: cDPfWQfVCHSPBaDj-GL1l6i0yfovpZOw
X-Proofpoint-ORIG-GUID: cDPfWQfVCHSPBaDj-GL1l6i0yfovpZOw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfX2ihxEMN2kGMd
 uLWOnBepefo4uqZlBa0dDWU6VMisT5etpvXnAFVD9DpWhcmS/cKW75XNN3RcrrLxfNt/sfkdiwh
 /ASqa/s3RU23MhxbFSYZvafCcMqxD94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfX+30OyuoAlROt
 DQSWYjcVqszeU2pQ9GmEIeMzeZe4k3fLXFOEkHJUUVd36NnJYsJbiItnond0qEpYV/CQCc8D9Di
 N+dg5+X7sMq9MsMYmOh8QaBFL/xrilLX6NqlJnFJKNtPxa5W7fUz8HOFHCoVkuD4GgbO2yb+Mow
 o2eRYedfQYkOVVFVhd/PwpHyLfjGwLT9shxa7qsFQf3lX033GnWYGmwcYiji5TGdkyx6bV5nvrm
 4syMdQDBnjZnp5YbUNsW7j42HWWBaYYs8Pv4uHmnmsBfkjPbw35FQ6Ot5sSRoRmGGQ/qNKZtpBG
 /PMYzQCYLo8+NkdUQew+Xe4WbpZMtSnTxpnHpsLF5q4T0QIZf9M52k7oEWohfqJIAG4Aqcr/2Fd
 smXuK3OWX+lfUA646LmvZnCPviFcq44pXWO3LU4d68ei6+4H5ARaAvMUFe25VqP1/BpjBM/NoZn
 T1n0gLchOF/gpOWy2ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050086
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



On 11/6/2026 1:59 AM, Rob Clark wrote:
> We want to save/restore all of the CP_PROTECT regs across IFPC.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> index a3eab0307529..dd1a5ca91812 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> @@ -1393,6 +1393,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
>  	REG_A8XX_CP_PROTECT_GLOBAL(53),
>  	REG_A8XX_CP_PROTECT_GLOBAL(54),
>  	REG_A8XX_CP_PROTECT_GLOBAL(55),
> +	REG_A8XX_CP_PROTECT_GLOBAL(56),
> +	REG_A8XX_CP_PROTECT_GLOBAL(57),
> +	REG_A8XX_CP_PROTECT_GLOBAL(58),
> +	REG_A8XX_CP_PROTECT_GLOBAL(59),
> +	REG_A8XX_CP_PROTECT_GLOBAL(60),
> +	REG_A8XX_CP_PROTECT_GLOBAL(61),
> +	REG_A8XX_CP_PROTECT_GLOBAL(62),
>  	REG_A8XX_CP_PROTECT_GLOBAL(63),
>  };
>  DECLARE_ADRENO_REGLIST_LIST(a850_ifpc_reglist);

