Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0D5FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0DEC10EB1C;
	Tue, 28 Apr 2026 11:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+Lgz3oM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUzhh3H2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB1410EB1C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:36:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S6lTAc1624769
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=377DZ0H74TNC/FjMducyHBrM
 yeDlo9XVy4S3FtiAAA8=; b=B+Lgz3oMYTYR4aesU47o2XByUa2L2NvhtqZpnQ1S
 +6tFes5t/42QcZqpixbU0hAi13wN3SnBRuEIzsNj4+GTibV1XvIYfKANzp5Gmqm+
 GCyePvUap/48NGrRcecJ3NjOADXiT48gIn6V3rZWArVXOPcxLgAjE7ekQv3AYrA3
 RZPPBGn/1/Z+cFFjcDTlt1Ov81DwrRwI23EKhcA1hlKpgVL9KWrCpHuvN6TR+UEk
 NEAxy7lwi5QJ5nuFhStcvwx4R/MHRlqliD3VQRu5Sc/Z9nvoR9ixirZDCTuUnFrZ
 3GltPHWibQBUx6gCP2na6I/3Nd5xxg5RZn+XATfBqssw8w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsaqgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:36:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so128962231cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777376165; x=1777980965;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=377DZ0H74TNC/FjMducyHBrMyeDlo9XVy4S3FtiAAA8=;
 b=CUzhh3H2InvYKmEACgRIU5jl1qxcWS+sJJwiMWai7/RrX+btq+f1B6i9hgOvjjl5Kb
 P1jTP8kXwbAc0lWrzxXtZqEp/W72GMHVs3b60u3O9UxVe2PgBo2ckHM4XrEsqNsCbKLC
 EDUS3S+1Jtja7xSzuWU6F7rXUjdEqFWRb6JXQEljfU0HIhF4GUi7Q63ErrBC3Kyj3Pr+
 sycvoONQu5jxQIcdsGYRq7r2VXVZFSS+ITtQ7RsfDUi9czgQDpE3Stfy8/BhFJiFuB2b
 Hqo+YgnsDLMFOW5MiTX1yA2tkGvpGuWMvF2K70I5/4bQCoDC+YzMUP4/1nmffE2T9MS8
 2zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376165; x=1777980965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=377DZ0H74TNC/FjMducyHBrMyeDlo9XVy4S3FtiAAA8=;
 b=rwvm5hkbHmEEm5hI1W/klZat+3LxPAxeD2lLwRN2En5iEBWxZUKow1bqPmmcc+UhXh
 FPHZbpmIuT3iASIcwr6aNFMrkZrupyLkbDgrPOeH4Q1EZaScL/w5TPukrEgLaK10QiYr
 CIUDMXghOeM+1K/fb4pMzUi8aZAR6QMv8NNtSXTPQ5VHWtOz1jIqmiLxwMmD9BR7teXv
 MPVw0P4tJkuKTp0foyxgyOOHwNjTrGKeLEfpy44PyD8pa3utKifjzubMOfyRznBCOzZy
 bqjQ/lEjDSbXRpSka5KA/2879+wkR6VHUrUaf/5uvGFyQ9iCMpt7V3QVuNVjmBoPnf+4
 3NoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6kbvUOkWxdMUfVh8vfUv0XvWOPD5eknGzNDi9QO5cUiZ8WZ05S0SZcM7JadG+VX3KM6WTu7VHczI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH5PESZW5UAc64Mm+LcHAhzUa5g2V+pQXB2Fs4/JBdyVk4mTIQ
 0wg7mrNuT6EWRrOc1QcZwWFFB4kx5fZ3Vn08pQlkc4g8NOpQ/uhhggXsDw4mJG0FC44GTqL+wOa
 ttUQxy5CRlP9PR5wulXmjOIsaRNF7Ldp6fK5RS827Q9wkdqurNwYO2ZjLsmZO9wcpKAih4qE=
X-Gm-Gg: AeBDieuX45CqOzJw0ZetEyRS7Q962G7+vjAC925JcEn5FYcX31dBeFLyJNuPO5JpIu5
 Wz50GmotjSHNE/iYNDom+TGn7Ed5dcX8/Z5x6hSsU5Ce1XBdtLMGJrWMsxJEZ1kgcw3OxNRznrB
 H9OiZyAEktemWsEITxmTqiGSQK0AMJcMGUpfuYCwBbG8/Z8FDQ58lW0jI2mgU50hIY2KO9TCeLa
 f9WCHczSkguWcjD5w9x0Eco1D3yF+UFbVLagJ0Rp8vtmmRyhabm7MWroQMgs2kL1tacj3q+gBDA
 g6BgicmQ94+JLWl9wB/+liAwDkSxPe7ZW/4hl66R2VrCfN8asLS9qKWbzIbqduWxhjAwdxPYfbC
 f4RGDonTHy+Qa4jMNMgCtAHEhQg2al3GxjYYxkw3z0KU5caerqSvaYwUks0Ds7eLKfF8JB/gRQy
 qq81NEQ/dCGZIy1RK7CLRnhaFuuOmHcQ4Xh6hZLRtat2xQKw==
X-Received: by 2002:a05:622a:2c7:b0:50f:be4f:465b with SMTP id
 d75a77b69052e-5100e1a3f31mr34440741cf.33.1777376164746; 
 Tue, 28 Apr 2026 04:36:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2c7:b0:50f:be4f:465b with SMTP id
 d75a77b69052e-5100e1a3f31mr34439951cf.33.1777376164190; 
 Tue, 28 Apr 2026 04:36:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f9f3esm547988e87.56.2026.04.28.04.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:36:03 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:36:01 +0300
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
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
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
Subject: Re: [PATCH v2 05/11] drm/bridge: chrontel-ch7033: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <3sxkk7hrom35lea4hgfmh6fsm5ikyq7zm4dv7dfg7qrotgvxuz@i6hgeeliqh64>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-5-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-5-4300744a1c47@bootlin.com>
X-Proofpoint-GUID: RgMCmzQlKf_BqISowPpxJGG7Zqmwtmal
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f09ba5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=3wW0AoOGKtJXkwOK0G4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNiBTYWx0ZWRfX8iBqyaOndWIK
 6EbCGUAaxEc01YSvU/A1ymKQiUSCbVho6vrzE+8ZdFFByAodf6qba7W3nfmBFRdMHczthAyrkpg
 sa/wc8v1Do3pEpYNNj5Hp4kPQzWJzDkc5avbWOjPEIbI1QRb5xlOiicTPpJQTz2Ix5inkwHGXAV
 NeOEaPEFtmtZGyi5U30XYs2ZtGW4UllLGkoGwgczudxQXOtYg+sZeqAib6wca9Mdvld3nsGVlDo
 KmPG5V+GnC9BVXAW20b+NaxG6Bq/GUnWbd3P1sKU4Y0HhOJdPZmP6puILQJAPmBKh8uS4JaGoJh
 bQn0SMF89wtsfNKPyZTXq6sd+wr1Vy7XDxVJCvPD7PnVQJjcyKaI4v9nuCjmGo7Sf2RUCeWrvcW
 8X84f72xMntiOWJclNmfs9ITJHWdznDBctCgU4AjOHmgqdSu3LlOACwuvXAsbb07KUJ6fa6hFx8
 Gq4OPE5GPAIPB1I3lqg==
X-Proofpoint-ORIG-GUID: RgMCmzQlKf_BqISowPpxJGG7Zqmwtmal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280106
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

On Tue, Apr 28, 2026 at 11:15:51AM +0200, Luca Ceresoli wrote:
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
>  drivers/gpu/drm/bridge/chrontel-ch7033.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
