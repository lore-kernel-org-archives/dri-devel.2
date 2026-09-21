Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85AC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A8B10E35A;
	Mon, 21 Sep 2026 07:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1x3Rkxa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hPO34yjX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B032810E147
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:40:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L79sgY1096065
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXBm8BbIlNlS9kij4DyUUNrfUO/dqmeuJb9GLNDGhLA=; b=p1x3Rkxa/Ri6FZmM
 swaVj3mjJj1KVPn2xk0A9rf15aEH7VumO78sNYkHdG9Jxv5CZDq6k7x7YZngk1YE
 +ItJUGiXVT3z+pIHQXeqRtoYV/YTlnMLbVa2xUzM3UmrVrYqoaWWRII9YE6w1soD
 bEeODR9EJoiRQ3e+QLtCiaiXWGseqodbd3A6p2gsd4ctBk2dvQx7oom+VugiPa9W
 ff2SREqjxxDqeq3BgthSa70YPo37OVTQnTzq1uuxCs5lXfavekiGjabfpaIJOxtc
 QMUYk7VCyI9C7enFvmn4F8jZXDgNKH6xVSL2qmFAP+upuLhzKvHH/BuxeymaiHGq
 JOlAXQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw05r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:40:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93bfab40895so20972685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789976440; x=1790581240;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RXBm8BbIlNlS9kij4DyUUNrfUO/dqmeuJb9GLNDGhLA=;
 b=hPO34yjX7Hzq2lW5kUOMq5pVbTjc50CNSbcQI4PjTwekP4PnbpiBM/Pgilw6VCvGLW
 zIFcWV3U2hf0plyavPMhSlS5eThfe9dHy1XIoYgRWR/sDmUcstbJjTe3aCCEpFFmVqQy
 elByy2gTmwc4KiD3ryO0zdbl6kllEX7SSA1bZ5vASY4IQBqB6F8gAssxZIBaen8IDUzU
 smed8Fb3pEjojh9g9J+GJH85YtBdRSTtkFDHnZ98U2+OhtmOsEZKc0FaP2rfrTA00XlG
 GgE0B6B3HnxbF4lvFodpqNv91YQOdex4tRZlja+VoLOIEJpP4t2L4M3C3wm/YxLgZWfr
 ZFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789976440; x=1790581240;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXBm8BbIlNlS9kij4DyUUNrfUO/dqmeuJb9GLNDGhLA=;
 b=hsgI6K/ZRs7/aPOrgDjhCUBYM7HJ8QXDxpeK3gPmdrLEzV2gmRzS6RPDqBO77Lcba4
 lWnShbP0eSiRjUHBCwd+GT0trEag8L6FKJbOxaGFbp0Z7BSGIne9Rqqm5HHjCdu6FV8M
 bWepfqrwB4YkOg0AvPfeaz2kMgJ8UvE8smL2eKquxthpkEwr6dzbxZOZdaRlEjYrPjzq
 0Dhx99dQN3dJCB7o8YBgX2dTE4wtLd/lNX1+VUIXYkTCz7P3tjcjXhMjOM0VOSvGd4s6
 4f/3xveO+qOjA9ZFUL/dNnvokU+WCtBn0HPUO832C2AMJ+lrZES1Jmi7Cobsb+eTHYAI
 hLKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6/mdwko+/v/fiCn22/Bewq86hpsPBCEb4btDogtOKTYsuc+uMp8gpf/ioKJSxd/4qSnpohgjchsw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPguEQ5cfXp2eXvP2IXmsY01ugRAnt//rzGvROrF4LkA/BLu/4
 Lx4hSJ1FIvBDQGgUBN56xBzL7ncAjL6xU0AZAXZSyyhA8Uu9MBW2pLAYz1Ohlk/jp6mRvjE2qXE
 n7lDuScwZUPrETPF4grw3PZcFLJ3GlnDEl5eJFnIV5iHv2+vR6SfCLwMNhOJgfpGDAKSC/SI=
X-Gm-Gg: AYBFou1iR4qqcC1MAbUvGEV2yUZHdgEky5kddzLbSnes5Y2zqgp3ciCVFaxxzfbNOKf
 fMPQlCV+P5sJCb4GAxo6qU30Aw4HIVbcPQHObmSFKnkVkSjdxN/ifeTMWu9+d+PzOMDl2Lqp+el
 djjNdeYhLs6y3rQKJnjuELqN/NJLx3JRfViAWteoMIqPzvsQlhjjL6jsDKCCKHr2uRcgPObZZQY
 1Uv+YSqB1ONdmQpIwLjBbOsBJFBFrc6OwWLRdPeR+HdiZ1gkyVCCxUUT6yIFfqGkvzK6NPGIMCn
 rLTrdVnN3CctcvN21tln4xqhNdLiK3aU4xs+EzIbv9D+dfVqIa3GcS7V3r7LQQla13RBWohn/cJ
 7aUquQ1WsOkpHWCAoaFXMhg==
X-Received: by 2002:a05:620a:4803:b0:939:b8da:1242 with SMTP id
 af79cd13be357-93bf518f649mr907436985a.0.1789976439789; 
 Mon, 21 Sep 2026 00:40:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4803:b0:939:b8da:1242 with SMTP id
 af79cd13be357-93bf518f649mr907434085a.0.1789976439390; 
 Mon, 21 Sep 2026 00:40:39 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67d821efsm3775171a12.10.2026.09.21.00.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 00:40:38 -0700 (PDT)
Message-ID: <1eca3b55-fce3-4a39-9e0d-2c6d1fcd6a86@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 09:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a5xx: don't read the GPMU registers on GPUs
 without a GPMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260920-a5xx-no-gpmu-v1-1-714200254f76@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260920-a5xx-no-gpmu-v1-1-714200254f76@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOSBTYWx0ZWRfX5z35P4LnqTVE
 DQHaZbEsUOP8IpfoQyhSqAX604kG1xNKOeATysDUJ7j0XgUzR7fY8z5auA8GnBUQ4URRtf1hZXk
 eV70b/XeXgl08zZpGDwUFlDuKkabfpAHd9VlNZZiMz2/xxerlWW5/UwfO47Kf0GQiaQASLIZ9a+
 wwtFFjK+I4Jzlektgx6qvG+6y1vHwz63iVbp/p/yVlALwEWh4XsurtwXdVuBLyCS8eYXfCGZu9B
 Gld+tn/Cv0fItVMT4Ob247JjooakKZdelkh8c9/YnnZzqkzY0Ya7g/IkDHG1AvCAi1ccpgcdW+7
 IqhMX0W9Kys0pPwZh6oJ9R/NnkWLw5lDo4LdUSlVBs6uox9AFrMBxKKRFbmh2kKbtTctTPqY0w5
 2QASufRmh0NbuL1Zoil+ot/VhBIDyLuOUjN5UL/3zlug2pLvyKU3p/ASpdZ8pghqldjr1n4/ruD
 B+PfCM6e6vjlEZPXNiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOSBTYWx0ZWRfX6IC8rTv9eevH
 7pblk22IwzcZvjEmUrFLGP7yIgmxNl+D+GgdveFihzxBJwEH2XltV7stRuwvZUjZBj2hYDLMRH2
 BoTkrLShf3Lv4Is7qT8bIh3mjWjZmDk=
X-Proofpoint-ORIG-GUID: 2c95Pj7kRMfDARP_cBgaW7jqwtieT9ln
X-Proofpoint-GUID: 2c95Pj7kRMfDARP_cBgaW7jqwtieT9ln
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab0df78 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nNp-cgRbjtXmMSB73TMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210109
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

On 9/20/26 1:08 PM, Dmitry Baryshkov wrote:
> Only a530/a540 have a GPMU.  On the other a5xx parts, reading the
> 0xa800-0xac60 GPMU aperture during a crashdump resets the board -- on
> sda660 (a512) a GPU hang thus reboots the SoC instead of recovering.
> 
> Split the GPMU block into its own array and collect it only when a GPMU
> is present.
> 
> Fixes: e20c9284c8f2 ("drm/msm/adreno: Add support for Adreno 510 GPU")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 49 ++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 5d96b8f63156..3974aaf6fd33 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1337,9 +1337,14 @@ static const u32 a5xx_registers[] = {
>  	0xE800, 0xE806, 0xE810, 0xE89A, 0xE8A0, 0xE8A4, 0xE8AA, 0xE8EB,
>  	0xE900, 0xE905, 0xEB80, 0xEB8F, 0xEBB0, 0xEBB0, 0xEC00, 0xEC05,
>  	0xEC08, 0xECE9, 0xECF0, 0xECF0, 0xEA80, 0xEA80, 0xEA82, 0xEAA3,
> -	0xEAA5, 0xEAC2, 0xA800, 0xA800, 0xA820, 0xA828, 0xA840, 0xA87D,
> -	0XA880, 0xA88D, 0xA890, 0xA8A3, 0xA8D0, 0xA8D8, 0xA8E0, 0xA8F5,
> -	0xAC60, 0xAC60, ~0,
> +	0xEAA5, 0xEAC2, ~0,
> +};
> +
> +/* GPMU registers, only valid on parts with a GPMU (a530/a540) */
> +static const u32 a5xx_gpmu_registers[] = {
> +	0xA800, 0xA800, 0xA820, 0xA828, 0xA840, 0xA87D, 0xA880, 0xA88D,
> +	0xA890, 0xA8A3, 0xA8D0, 0xA8D8, 0xA8E0, 0xA8F5, 0xAC60, 0xAC60,
> +	~0,
>  };

I'm not sure if there are holes in these ranges in the hw, but msm-3.18
(8998 kernel) simply has:

0xA800-0xA8FF
and
0xAC60-0xAC60

(both ranges inclusive)

Konrad
