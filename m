Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03EDCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F48C10F521;
	Fri, 15 May 2026 13:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdJn2sYn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E3AlK5Br";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550D410F521
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:37:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FAoocF655515
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=O7epNKlvduCkj+W0ihTOhazY
 SpPpW52OLfX1S5ZV3nk=; b=WdJn2sYnpounX+J/LfuoizYUoNYAXs9k4gYf6i5+
 pArFKCykV0eve7A3robOqlzZjsRPHgKhZbAmQU6C0VcFuDZQQCTW+zD2kapcTPJD
 naBqzK0bhxk9TjedffBAgKfCu+jPCo6uJ0z/s2J0wEwsWz4UcX2zUrwCquurpn7Y
 rNbtnXAR9Dlw0/bw+NWHmPcAE06fASuYK5oRPyd1Ip9To1dLqDLVuwPygu/N3+bt
 AJ1YiUNvLAaz+CqVk9T/t3pSXCPFihwNeQFRA3FFY7tGQyscDqaySzIe/31iKgmx
 ueFIwBHj6E9ilqZ/292PcKIEBtVqSnrSXWyrNy1d2p8pOw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1pug38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:37:41 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-63271d633b5so4545585137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778852261; x=1779457061;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O7epNKlvduCkj+W0ihTOhazYSpPpW52OLfX1S5ZV3nk=;
 b=E3AlK5Br0xQUzP7HK+3ZULvvvT+5nqsqPZyO7DFQbCXeEh/oTOzWJf5VpEwbLPsE9K
 pqO8TztAvMYr87nSFMYnWIqNbJ1jtK+e5Ht+PyAlmHtnRhSoqNukdYRARDJho9r41p0b
 ihnOZia16iO/iPc0kjkQqyViLZAJgxVUDBQu5VuJgKynbifuKxjyzZGrQQHzoq1a7QcB
 qDpX1ScvezRdm4TQC6jlfUYu7nrS1hDUtCrePCsM8Z2W1OqKBmxHn6Jk1dV/r3FlleDq
 OUDUA6A2r43UxT/wm1ah1igSVLQOCmXgL4hsC5o1AMIm4IrfB/SHPbQALannvQuPuRO+
 47KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852261; x=1779457061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7epNKlvduCkj+W0ihTOhazYSpPpW52OLfX1S5ZV3nk=;
 b=kE+HlrkkQH9TsVeBd5zQO3j0wfW0yH4DxuHPdP3KtozB7ufgx08MYp11mTw5zwrX7G
 Ff2QT5tVHDmfy76+u3gFdB7SMqUFdRCTYv626Td8zyqCy9qQPC25RYJ8E8FOYqzeaM5c
 waqVz/bfycZn8w5j1VpPa2VSZc1MGmFaN/OhvheWjjgp608XwXqJ+h3cLmYYw1hbjMXE
 /UED4X5ZgoLTDTPXn3VhaNXcCf0HRzL+obLqe7A+hYU+mAkUz6Zncp0fhO5wVlq4+u3B
 NB0owSGHL0nIgx5yLMpwL6B8EJAGqPpVU5tEVZC6EpscVFwVdgVdjDrE2LmaKewr9uoC
 /k7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Zw++BAu6XpDBdJ3AInF2X8a9m/B+WaCDpLjdYRO1cRcK0bbeh/4RAU96nPze/aHWMAKNaQJJOq5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweLN/Ud8MhELPMg7KLLFl2myVFZ2V1dS30lPilO4Tqspb3HRar
 xT60rZ/JAwfjyYcN5lGtFy9ck3gXpBp5jo7YEutAIait4qIGfxWGe+aCG46wi2Q1fnCOul6oQ+J
 h0+cfFkdTRVsOhmISnXIruJmZ1cK4wZMpbQRrnW8HF7HjXmbKQiCzt3/q1loXAhElqsBSV8Y=
X-Gm-Gg: Acq92OEEzUtlVNhe/+8zmFEYjmA/qhzecrSRWPf8dImOevEnoFP6+U7dzvq6tJjQw9N
 MhIuG6Ekv4WzJc8T+tajgsr5A6y4Gnoyesw4+aMe+4NQQRsVYNNxEHPrluSqrDzbR4Ar/ywj48U
 8EPw1G8yOyWvVCwAyiNp4vikfiUp1C+no6UeJszA3oTHbK5mJFs8FQ3qSb6KCf/mOhzwlE6DqVQ
 2Y++6kjZYESsYDM6uevSlfYkKF+Jeb0ieOnwiVo5I+ddMuzzE4ZcY43FDBpgx22Nu7auN9WvtVJ
 6x5XzzSutdYjdmvstFw91RcOP13TPvm6EwBtQWJG+Z9YbVj+5YUkpjMSewaRjAQPqCZfMRKC1jy
 T/dgSbKDf69c7QRbgCDl7lYYTa/ShHAUsMcUm2ce6+R0romuJ99MRtANvlFDm1QsbfxstoLhqYo
 CxPNwN/bc89YeVh54zXnQCUB4C0T2SOodvTaS44O1LOVVu5w==
X-Received: by 2002:a05:6102:f85:b0:631:4d87:ba5f with SMTP id
 ada2fe7eead31-63a3d0182e9mr2173380137.3.1778852260625; 
 Fri, 15 May 2026 06:37:40 -0700 (PDT)
X-Received: by 2002:a05:6102:f85:b0:631:4d87:ba5f with SMTP id
 ada2fe7eead31-63a3d0182e9mr2173348137.3.1778852260157; 
 Fri, 15 May 2026 06:37:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945cab497esm15704201fa.25.2026.05.15.06.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:37:39 -0700 (PDT)
Date: Fri, 15 May 2026 16:37:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
Message-ID: <5rpyaoyx3dsf3c7llnt57uukeaef2qgget42itfc45tura5esy@b4cwvazm42uo>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
X-Proofpoint-GUID: UZs1Jg9exM2Lhm-34xcHHiqFP8-LQ9Jz
X-Proofpoint-ORIG-GUID: UZs1Jg9exM2Lhm-34xcHHiqFP8-LQ9Jz
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a0721a5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hhTr-yxhb_4ls8DXav4A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNyBTYWx0ZWRfX3u+OaTXD2dOV
 pAHqxsN9Zh3zpu0jd6leqGL0FDBhvu2UzEZRIGNhR11h6LkAYYphCQGmg+T2+1NEeCyVvnVqIxy
 N/CqK64llh0zygK4UdeTeVFcVrTj4zo8dXiMtim3gP2PQt/d03oyebhrlL3hAipLD7M8jOofaPn
 +0Ma0AYGhzBZGLCTf3aDNMZz9Ab+tj6UnbJ5BRkaYujwFa4dVr/bhAGoHyO9K4VVPsOSw5K5XX7
 OLFE6EmzOTArdc4yvj7vFAYbmMsIbt9nRbY49UtkioVTYMv41Qzp7dr6zMJL3mmCYQ17Qf1IXQd
 hZfXJeNl7NX763nDtv3KGQmQoL0ZWlasRtEYdAt0FWcuc8sPShYDo+FNfnhG/3zAESDxJ6xjSVo
 qn6iHPuBLhaVOmSFkQd3nzP6o+km7xN/6cSapRtRDYVgZc0GftV6hPpV5HYRx+ob13PnEdl/jVm
 tvoTWm+zD3Rug9VwtgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150137
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

On Fri, May 15, 2026 at 08:42:15PM +0800, Jianping Li wrote:
> Audio PD static process creation assumes that a reserved-memory
> region is defined in DT and exposed via cctx->remote_heap.
> 
> If reserved-memory is missing or incomplete, the driver may pass
> invalid address/size information to the DSP, leading to undefined
> behavior or crashes.
> 
> Add explicit validation for remote_heap presence and size before
> sending the memory to DSP, and fail early if the configuration is
> invalid.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 3c7c3b410d7d..a0337cce77f3 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1363,6 +1363,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	args[1].length = inbuf.namelen;
>  	args[1].fd = -1;
>  
> +	if (!fl->cctx->remote_heap ||
> +	    !fl->cctx->remote_heap->dma_addr ||
> +	    !fl->cctx->remote_heap->size) {

I guess that !dma_addr || !size should fail much earlier than here.

> +		err = -ENOMEM;
> +		goto err;
> +	}
>  	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>  	pages[0].size = fl->cctx->remote_heap->size;
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
