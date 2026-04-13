Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01883F531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665F010E4FC;
	Mon, 13 Apr 2026 18:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRKkzj4e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EA7T8A2z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE43210E444
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:37 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DF5JpR3750379
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Cvg9O/QkoL6L++yjzZgvdyr7
 NcHvlP+82mqh/kFxhmE=; b=pRKkzj4eBCLt7MBIHrvfMDHA8m40GRD33k+hBScN
 2Ygbk73IPzEDe5rG8ZQVNp8xBORszviNd5JgeNCOkbvUnUKjd21Wk49Ec2c5jaWp
 ZuFeKcPeVikXiC5f5XXRfMKFA3nc2UtOSWQeAxW7U6+2nIKSHrkRkL1O7jVf5MJ+
 Pclf8y65gFhT2lcawQlBhx+jbhrc3dT4B4OZEmPqWu5IFEwCz3xMcaRHUpqu/OHE
 5YdK3FVApL2VjsE7Qc/RzlpqDsG/Xfz7W7golo5D7kaxCNwer0pxx9pFrNarWl1S
 o57bOBJPnO7cOv3F+q6PLIGpZjy9Tks13KdMF9PWNA2ELg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh2tu8p5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d890580e1so86832861cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776104316; x=1776709116;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cvg9O/QkoL6L++yjzZgvdyr7NcHvlP+82mqh/kFxhmE=;
 b=EA7T8A2zhoBoZ4ndtFeUsC0h9QMjOS/OL1vvNrp/rc1LhQOnvjDiqWfUomZaU24wLG
 WSDxTUbfnZKqk6lkScpXeNN5bKiNeHQRBWU1p3SqwQuHwHFc4HSv7MRb3njzerh3q/lK
 wX87hg42MrPhkRDe149Ay+Cpo8KY50VKrI3efNdhZnw+W85smu7tcuULay38gOZNNa94
 ODMl70b5ER5WvAnuvPHHNh9Y8jt29rUhJWrJG3XbDsBmG/6NLzNh7GzI/hKY4HsyUgW9
 alyvUHseHRIkvBTiqup88XfHTyQb5aB2gndJxfCuPPpbu7+Lkxa2IhEzPeT2JWejaTeJ
 Ps6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776104316; x=1776709116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cvg9O/QkoL6L++yjzZgvdyr7NcHvlP+82mqh/kFxhmE=;
 b=oL8Dgl9q5hZtb/ikmomXQAjCijUNmdGzfAY6DoGgeaxgrtpUhm0VW3ih13VMluR+eq
 YYszXy4WZWni6UTOhb0Ba6YBGW4cKEozIzZe+kTSiENl6nE1Q4lK7IfeJtWMI/PHgOMN
 ZTtyCGxPUHlbV8bFxeeOpC97o9fm9PT+R6ypeSJWiVtVDlcQHFzgQqH54RdlX8iIOZLM
 k2SBlbviee5ll3bMV8lCAVQAhngt9LPS54OrDcPl0qtEJdIC/A4+VsrJ5OKZPSqWpNZr
 tAKlYUiGiLNANBEGfMkEz4JzIbSvaFZGzYPMOjYkKlBcAdEFnmDm8HuNPVAnvC5UjE6o
 WM9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P1mHgT7KIERnzeW+1FnTVdp9CgHH+wqcwquE6olCeTelEhzu6O8oDPIzhyB21hlR/eUHi/vmhLo0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDSSp2sdDHEOQumK9iYaikhZ1kRMMKAl1W5Aidy8PoB6jIl3nT
 FK6EW8sa+4vonOmuFhoSXGkow5Lmqevg1KImar6CNRdta68gjGjVEqxUcaRE3pj0H5CMsovsdkr
 Uvnexs5tEyZJpW/offKfHIcgMPSKqzuxPn5vzkWI+Y+42TgWgkMYrRrY4Jh0iWffTQ9GrYtA=
X-Gm-Gg: AeBDiesxQlg7Gwx54RAL1BRaXei4an6P2i2Z4d+SdOsh5ZugfuImAGFuhd8G7pGKxwS
 8SbK91v34vzFn6Ex1DfEGXpUGBx6ESdohPttXdGjgOT08USTM0xWAqhgJLUDCDcTmuuojSeRmHb
 t6f51AEsbF/NHJL5jK9Yxu0gda3g6GGHYlG2BzsuiBIS8Jn34UP5fqH/J7/PQmJAsOHbPS9roDt
 DlBClpjVyAnG6dCX003+ybF0elHpwQLmjU99JkQdYrslQwOlJ/6QxhAiKZWA7ugmNQZi7sRsKo3
 yu/ohWXQj/LQ4Dwdx1AvsAnm3MhQPrhrQHJMjyKZjaxRA+d2F+nOWvmf42uUm+QzZjtpH+XlT2X
 dBFWNbOVazTxHTMyvawUbJXUXnFih1VOGsiqEkSZKslVxCsiUdB5pR5u/kNUg72BX8PYQEkNxw+
 iLnmfD77zeO7l6zgkhZbYqq+oTTszavziNr9NLDxr6PyNRgQ==
X-Received: by 2002:ac8:5916:0:b0:509:348f:bc1a with SMTP id
 d75a77b69052e-50dd5ad989amr232215951cf.26.1776104316325; 
 Mon, 13 Apr 2026 11:18:36 -0700 (PDT)
X-Received: by 2002:ac8:5916:0:b0:509:348f:bc1a with SMTP id
 d75a77b69052e-50dd5ad989amr232215361cf.26.1776104315794; 
 Mon, 13 Apr 2026 11:18:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49298f1csm24034161fa.12.2026.04.13.11.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:18:33 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:18:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/10] drm/bridge: lt8713sx: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <5d4juwqjm2wxxzd6vf3rjrsrp3xhg2spklukvocwrdenuepk6v@a7mdfn27fsgt>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-8-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-8-acd01cd79a1f@bootlin.com>
X-Proofpoint-ORIG-GUID: 91wNY-AelPihuGnRiYz7JHWWXCdDK3xj
X-Proofpoint-GUID: 91wNY-AelPihuGnRiYz7JHWWXCdDK3xj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MCBTYWx0ZWRfX5eZ/Tznhx2qZ
 B1ei7N8dQNwuIo8ajXNPIN/XzsAQSIk9frJGj8TSiybDT+MOgrWn6FMU5UV3tJ116sA6hWdpQuB
 rT1T78cdGqCoh/Hb+ViDidZwz5f9HWYig3AeTVBq2wJs+pyYpGouPFTso3kTfUWH3MkRXxbRl4T
 ASBqxZR0MZrBwWttr7wurZHQD+cHL4QenVgveVF1bgmUJIhE5ap2PrTYLnVafmf97w6e+X2k6Xg
 g0fctjHl/pennJmAfOsPrOCWcOxBKRDcudhYWDY3ujXO67svDfHS6LZeP1D4dARpKKxePleXj4T
 F88KE0I9b15wd90dzn6QomeDa49Qb6QNMoDd9zXDvA1XJUon99gSxHng6EMkIcRelMObmB6Fuq4
 aaYCtQBdFs/QcYow4ypQkbVMFGNb2IReq13pKZrT0OM/RhQR4UgeqG2l45/tSwAx0f/yTVRcR8z
 uTGYGbA7H+eMriN2FXg==
X-Authority-Analysis: v=2.4 cv=RJ+D2Yi+ c=1 sm=1 tr=0 ts=69dd337d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=sqxsbOWVCbAVHG9YZwUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130180
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

On Mon, Apr 13, 2026 at 03:58:40PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8713sx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
