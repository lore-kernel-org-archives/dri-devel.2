Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705C7FA1FC9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D428C10E04D;
	Wed, 22 Apr 2026 15:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eh6h25AJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/koRI/B";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A97710E04D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:47:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAx3YJ3377466
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TIu+DBStZtyj0oJu2FZ3xGC9
 pVsbcUr12+1053rYZU0=; b=eh6h25AJgDrEZuVCUlq9yOcElyGqH/Fi9NmySvei
 8v1+u0UKn26YDxyuUamZJTGhB20QivW9pW9IWnnSNitdU/YXhRkxcrRhkmmBxLM/
 usHltQC5g8lvYnXYu4gwLfxiN2Ho9Gaupls0WDovlNXiiy68DlD/3RFSbwYd5BT6
 pWm2CgWaRf8CO4yq46GQMtKMtW5yb4ZWHrSdi8k0jKoZjCyRY5UsHNODwXvM3i8J
 y9YvMBP5mZ3Ff6352oyI9D7TtEfPKLx9/MgpLPT7XlARG0qcpqY6F9qgfAV6oM6U
 m3kZnbxJHVImoFapYLeFWi3DMhioYYXOpCsNf1obJS4FOA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng44u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:47:23 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-612ef4e6c54so9465462137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776872843; x=1777477643;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TIu+DBStZtyj0oJu2FZ3xGC9pVsbcUr12+1053rYZU0=;
 b=P/koRI/Bq9mLZvwd9RKIhaAMT42F7fvuTd7f1/tXDgNWYNJ2pSRWukuP1tH8QFBs4z
 vNftPAEIUEnPhB5p5gDZK8ipp3GwJQU1WNf6o5PUrRPiC/g65U93aFWQtzw8pCuWN7b1
 qiLvihcVz8QyDs0havSh2MmQSEJv/mjCgMMhCAOcg41ERpYxEKF1aseKQ6JJuDHOsT/d
 owLZ9sdTat6stC9Ti0HhRTZZMbmMpSOTSg+RvY88VenaMJkj4i4P/oCJvlTh215/qe5d
 VqsvpGiBhmsvj613vxYMrUTQtWvJAPYgES7NsPJdvR2b0aEplhBq2EBt4Liz6UHVJHKU
 rQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872843; x=1777477643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIu+DBStZtyj0oJu2FZ3xGC9pVsbcUr12+1053rYZU0=;
 b=pL+PnasaieLfgDKk5FwTKCemlrKJXscBGP+lWnmCFBGdmrW3sylrs5Cv6vTPB1h1hY
 9Z/1jdbaFvWwvyiTPpNVaPZgTK3/2W4ijdbYY7sKXUzdobWJhU/QtxSinj0hHxJyAs6x
 1bCulXx5POXAGZfee0br8CAavqMwA6HomAaOvieOugOWeRuIg8yxjNeYeIX40m41xpqm
 P5LSLm/9P6cF4QQE6OqaCiJru4BMIpVQcKc7m5Qo6doGsN5ScJOR2p5DFOo8ZW9+NKXW
 bGbwI21tGBq0fJJDsi5zcHsCBTvZ8LgMOBlnFxEHv7eBNtl377GmKBiS+EUgYkdIr/+q
 MxXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F581WxwcceJomWp6pcLw9yqkRR2CklVyQ16oUVbHQ6P6CJ/3+p9+Hc8opVtRvN6bvJpM8SAUkTuw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkKlxJ/o/5Bd7uJ8OnNGf/+HjeYQ6d7Qz2jczU578NL8FzpStw
 v5/L/8shwwYHB0sYeHO8Zcua2H6cu953HU00zsBR0X6em8ZsiBuEQkZFsHab/A7Z+UjKelJuzBw
 XIt24vmpQ3AO/mYbTGJOdlSvI4Mi/nUeNok9vJXG4xdGRmQ6l82EJxx8uvujZ6XLMTRZNS4g=
X-Gm-Gg: AeBDieufBYbIOuZsbD0tDlfM8r59QuAmLebXIBfILV39pCjMvCX0+XY5tOK9mb6gQEE
 bSFDF1ldJFnvVndaqN0tJwsPQ51uakMwVGYPYgw4lfuUohvtMKk9oksGYvc0WKOjZbVBW4nxahj
 obNjs7tbwquhEtcBOhjSfToDXTPzIgkcKwnugN4j405obN0Ya8Rz5oGcLxRQMqh5h8yx6PoY/X6
 3l1YWE2wUmf2/ttXJVDxLU5uV2MDCOdYuWYDJJJcXKVz2speuWrdKNgGz1xOudW8dBcaDkyEQtv
 TOs+kw4tTMVCMEOazM6WXlTZVml4jUFmCIcL/xNkutl6UGHm1rnCw7ZW2pnjqLqFhPT1b0RGNy5
 B9v9dggBL8rxtu7noYmaO0uSq7SLlRl8sgvu4rJEHgm8tMurZZk6PIKnLdWRaDCWBWd+9peVIDN
 v1b51sRI6cA/vwGCymYwvegtCNMgf+xs/pTKma+hsj/WBRYQ==
X-Received: by 2002:a05:6102:b0f:b0:607:97a9:e3dd with SMTP id
 ada2fe7eead31-616f73fb01fmr11038159137.24.1776872842928; 
 Wed, 22 Apr 2026 08:47:22 -0700 (PDT)
X-Received: by 2002:a05:6102:b0f:b0:607:97a9:e3dd with SMTP id
 ada2fe7eead31-616f73fb01fmr11038138137.24.1776872842469; 
 Wed, 22 Apr 2026 08:47:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7d80sm4485337e87.68.2026.04.22.08.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:47:21 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:47:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: Re: [PATCH v9 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
Message-ID: <jqehwyeoda5t5kabxjouc4kgpnebndotkr2a4tuuiypzqcck42@dv3vu7wbq6nh>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
 <20260422092409.4107093-5-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092409.4107093-5-ekansh.gupta@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e8ed8b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=EekQdeYcPna9Ds66k2oA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: ErudZs1aGcME0wvOTUrXKXD15Fm58TE4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1MyBTYWx0ZWRfX1UZn7o/kYTOQ
 S6G7wFTQs88j8X1pab7ZSSbMqcn7zoZUx422UvHwq5h6J9pgyQbuN21gnpQN8rttGKMLkHZZbLz
 ad0Kyv7pqNrPVAw9/rj1HSDiVqEcawNK4RvkaiWU//ZaPoq80VK1P3FEIlxowf4xDLqon5Ux7uE
 W/+ELmm0EOKivbnbd1oPt/BTemvEgAOMBBSYXkYwju2CHwxHQgL3/zgF3jwq2l6vLALHV+7Kj/5
 Lq4tM+xxsKL6itfF2xKZMctuENcmVOZIwvWAkG78jcLawGkhjh2WEOPekdhrzAXQKyjomuJnZIf
 kj72F2BvqH+8NRx8g6apCe2KEARw84C8nyaZptwE8Ab1niat5Jn1Tj0Ic6mz+SC3oTnsKQu+OmJ
 lfy7MS+MddJ7msIEsJRJQpvCFQaqWgfy0+xO7/LH8l80XTLDL/ybTFBAz0NggBllPvm06YpUy9X
 a8J78/QRXNN6FAKulqg==
X-Proofpoint-ORIG-GUID: ErudZs1aGcME0wvOTUrXKXD15Fm58TE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220153
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

On Wed, Apr 22, 2026 at 02:54:09PM +0530, Ekansh Gupta wrote:
> For any remote call to DSP, after sending an invocation message,
> fastRPC driver waits for glink response and during this time the
> CPU can go into low power modes. This adds latency to overall fastrpc
> call as CPU wakeup and scheduling latencies are included. Add polling
> mode support with which fastRPC driver will poll continuously on a
> memory after sending a message to remote subsystem which will eliminate
> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
> poll timeout happens, the call will fallback to normal RPC mode.  Poll
> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
> request with FASTRPC_POLL_MODE request id.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c      | 148 ++++++++++++++++++++++++++++++++++--
>  include/uapi/misc/fastrpc.h |  25 ++++++
>  2 files changed, 166 insertions(+), 7 deletions(-)
> 
> @@ -2331,6 +2446,22 @@ static const struct fastrpc_soc_data default_soc_data = {
>  	.dma_addr_bits_default = 32,
>  };
>  
> +/*
> + * Older platforms that use default_soc_data but whose DSP firmware
> + * supports the FastRPC polling mode.

There should be a comment, "don't add more platforms to this list".

> + */
> +static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unused = {
> +	{ .compatible = "qcom,qcs8300" },
> +	{ .compatible = "qcom,qcs9100" },

Use qcom,sa8775p instead. See sa8775p-ride boards.
What about qcom,sar2130p?
qcom,sc8280xp?
qcom,milos?

> +	{ .compatible = "qcom,sm8450" },
> +	{ .compatible = "qcom,sm8550" },
> +	{ .compatible = "qcom,sm8650" },
> +	{ .compatible = "qcom,sm8750" },
> +	{ .compatible = "qcom,x1e80100" },
> +	{ .compatible = "qcom,x1p42100" },
> +	{},
> +};
> +
>  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  {
>  	struct device *rdev = &rpdev->dev;

-- 
With best wishes
Dmitry
