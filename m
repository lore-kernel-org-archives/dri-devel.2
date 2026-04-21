Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82421F89251
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C37210E1A1;
	Tue, 21 Apr 2026 11:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+29Q2mz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WD4m2eK7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C379F10E1A1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:22:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L6ePS53574145
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=50XlgasD2lNjDD3FnXwrtdbf
 2oU2iRb6FUDysqOc+hQ=; b=H+29Q2mzPwQQB4kjO0sv3zl7gcQMgTp9YGWhR7jS
 ETIZlednz38QIN8BbjKFyvjGxATQlHBsG+Ke6Bazi8QcumZ99EIE+wkk3SIXzv6N
 YIre/e4s2jLt1Ff3P1qTr0D+XV27wGLeN/dUqQy+o7b0cISfowXvyprNCqgyNGvv
 t5ldGWMBc+YutCYXI7OyNnFOm9esDPfPOgeBs8CDMRgmyhCVGnM8vcU2GW4KXuhk
 2lhKMvlGSEw6IJbtnP2R5fm22fsZ/e/IaUX6M1lDOVthTNVGY7MLNIcGw11T/ioK
 il2pVUUkm0tdS60XSqP3NrLwYix6yg/QPijdBFsDgv4QbQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465h1c8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:22:10 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-953b90636a7so5486291241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776770529; x=1777375329;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=50XlgasD2lNjDD3FnXwrtdbf2oU2iRb6FUDysqOc+hQ=;
 b=WD4m2eK75/UQaxeRVoddU+7pNNMdWzP0ZZcdy0JmnX5GBH8dOFu1/dd4TL0MSv6Pjl
 yHNX2FQ3Oz2bPBf3Jyhgn72cKunKBmeDSZ5iUeG/1A4MVGrzQDPEdAC17fqe0BaHyO9J
 VUYsT7Q4Ny293ErvZjvs1T1GXeRo0D85mmCnmULXkn9gMUvlkqXnOe9lGEyg8Uvgln5i
 ZY6b16+eEjf2NyEURnFmBhJo5hjX97H/cMq2fbHXOMe9biHpvMXDNYGd7Jzhok6r6odL
 49r9LvcgRd/h87wlFl9j8CFzkD8f0XVK/tYpygJ/eKPa5RGE0qc/jIVbDy/KMX2X9O3U
 65gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776770529; x=1777375329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50XlgasD2lNjDD3FnXwrtdbf2oU2iRb6FUDysqOc+hQ=;
 b=bpjx7q06qBZ6M1TGbQp/EpXkquaY+ZEIKeYqDPFgMK1J9YcNPRUNA+UG9g1P45ErVU
 TebZqZC4ahS0ryHQLqzRNH3KKmi97Jlme0Sw1hn/Rx3Zzx5N1YwwdCjfvbVWLQ+lN6eN
 nAJBenvUbnzxYiy2oGsjbonr+GJpCyZ6kZ5U+aDBIStcBUmaeLOBv/SKyh9oiCAuSErn
 zjchs8MiwT9E8nPbEt+c/QTHrFpY3uwEouvV+04CUvleZ8Ilitf0y2PYYxslg/y6YEOB
 8BJfIihOOPbitICSX9OJLsaDCfZ5s/MkHgEASsCHwzfTibXRkheQKNlfpuF630QuEhcd
 9JAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EmyBM8YXzzr3I5wM9jxJDOdjjcBp7d0vwkmmroDaZE8S/T4JPuagqizutkqPz9CKz1zztpo9NLco=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz0M9kDlZoXKB0LcqDHMAAlwW0h5UrZhPkbY7ZO7wbRsFgpNRU
 FjIMeMKqdRPRVp6wtMX3T68Yu3gVP/LuNd93/EKO5IYnY4HIrgCBweWmIjKgQ4NLsdw2qXMP5pJ
 cRdrXUg3qfz58IjrrxEfVoM1mUzCfRtmrIHT+6Ms8pvaW841aAW/4BDVB2wZhD0m4jzIiCbA=
X-Gm-Gg: AeBDieuxnqouNmmq4Xs71eyZPKsG1h72Guprnb4TsI2rvgAHvXz0EDsR3e0AMQMGjsi
 y0OEV8W3g/pK5Db7xKlXvyWJW+rZ68pDDnJKJg4DngQchm3uk3qg/HVUEWcX70BRmT/4zL92/QR
 xZ+VA277B0L30UQnVbsqZohCVi9c6BO9k9rBmYwqQK+XQ4BnsibAornULfoLlOZoZ3y+nMB36dQ
 aFLoR9Kmy4wcyiuSQHmTZLddv5+RiaNG5L2+WDijIu/NKtffztIqls4xHPI7cE3Jp9F02cTy70r
 zfQzsj+dmthPTUZO4E0KfLkWZNhSAuU2GQhz3SJ0uqzEhC8ECdqVPP28DlrO8fjNBc9QLqdYPdz
 jS+TsmUcwRdXvD58DRUTa2UBf0pzu7KhZo4N1FCqtws/1ZUWqUQZJilvSpVJ3SU1e4LtgtN/Uws
 7h3BRSozGbWWoVHGT9wZuK0P9eF3AHkBD3IYpuUDNHPze2RA==
X-Received: by 2002:a05:6102:3581:b0:611:b9be:1199 with SMTP id
 ada2fe7eead31-616f6ee96damr8142486137.14.1776770529203; 
 Tue, 21 Apr 2026 04:22:09 -0700 (PDT)
X-Received: by 2002:a05:6102:3581:b0:611:b9be:1199 with SMTP id
 ada2fe7eead31-616f6ee96damr8142470137.14.1776770528743; 
 Tue, 21 Apr 2026 04:22:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f54ffsm29613461fa.1.2026.04.21.04.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 04:22:07 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:22:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Message-ID: <m225f2xw3xkzacscycaifnc4hb3mv3o6ezaxjyhtphnjo5cfw3@6smswij3txnc>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
 <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
 <9523bd97-2730-4b99-b3d0-6accc7622478@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9523bd97-2730-4b99-b3d0-6accc7622478@tuxon.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfXwaDOfP3KI00K
 BR957sI0SxlSl3/5a9gkWsQ+JvfxbHxZ18sdRN02HXXsN+uOCQ7KWoFIfrH0f/L2ZpjKKuAhOdH
 CCXBjvALKTOmDUKxI2P4/zbDE+Rs9+94o5mlwPNN8ItsFnXAsXtX6PRUL0IbugSrcce/zd/33Pn
 uR3Qquq7/ySnvtn8jbuNyniZ/6exPXSYXI636mawrNZZsD8i2DBO38BAZ04hvKwQbdcoLzD0RoA
 O5u28aaVGZf/8UkdcI5DtMQ2MfQq6QYDupLzC5VkUKE4wV6ptUas5bmx/KOklvZuSnjOjq0DTUx
 mCEQT0L673LA24mVsY6mL8hKuCrMnOdtd/3SgzeRnKpNgYGpEVrDds4+sF0U6I1xy0eT3vnAd53
 MmhSS+EwWaNSG8HM4age6UhVhXvL9DBPLQFZU4kHT5h5SGHTN0gOq0TLMQ7waMK3P3OX3kx8sYp
 /EByFpDcGeuaLmIzINw==
X-Proofpoint-ORIG-GUID: v6c1IOSKMyAEgeKg7QucPurAl26GuXBc
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e75de2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=yC-0_ovQAAAA:8
 a=aPXnMlqv0fPtNfNeGM4A:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: v6c1IOSKMyAEgeKg7QucPurAl26GuXBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210112
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

On Tue, Apr 21, 2026 at 12:11:28PM +0300, Claudiu Beznea wrote:
> Hi,
> 
> On 4/19/26 18:58, Dmitry Baryshkov wrote:
> > On Fri, Apr 17, 2026 at 06:52:30PM +0100, Biju wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > 
> > > Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
> > > mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
> > > from 25 to 87 MHz. The LVDS module cannot be used at the same time as
> > > MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
> > > the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
> > > MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
> > > module.
> > > 
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> 
> [ ...]
> 
> > > +/* -----------------------------------------------------------------------------
> > > + * Bridge
> > > + */
> > > +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> > > +				     struct drm_atomic_state *state)
> > > +{
> > > +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> > > +	const struct drm_bridge_state *bridge_state;
> > > +	int ret;
> > > +	u32 fmt;
> > > +
> > > +	/* Get the LVDS format from the bridge state. */
> > > +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> > > +	if (!bridge_state) {
> > > +		dev_err(lvds->dev, "failed to get bridge state\n");
> > > +		return;
> > > +	}
> > > +
> > > +	switch (bridge_state->output_bus_cfg.format) {
> > > +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> > > +		fmt = RZG3L_LVDS_MODE_JEIDA;
> > > +		break;
> > > +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> > > +		fmt = RZG3L_LVDS_MODE_VESA;
> > > +		break;
> > > +	default:
> > > +		fmt = RZG3L_LVDS_MODE_VESA;
> > > +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
> > > +			 bridge_state->output_bus_cfg.format);
> > > +		break;
> > > +	}
> > > +
> > > +	ret = pm_runtime_resume_and_get(lvds->dev);
> > 
> > If this  fails for any reason, the atomic_disable() would still be
> > called and it will decrement the counter, potentially undeflowing it.
> > Consider switching to pm_runtime_get_sync(), which suits better here.
> 
> AFAIK, the clocks of this HW blocks have MSTOP functionality. HW manual of
> RZ/G3S [1] (should be the same for RZ/G3L as well) mentions the following in
> the chapter 41.2.1. "If the master accesses a module that has the clock
> stopped and the MSTOP bit set, a bus error will occur". [1]
> MSTOP is set though the clock enable/disable APIs.
> 
> The clocks on RZ/G3L are part of clock power domains. If the
> pm_runtime_resume_and_get() fails (or any runtime PM resume calls), the
> clocks will be off and MSTOP set. In this case, calling atomic_disable() or
> any API setting HW registers will lead to sync aborts.

Then you've identified a bug in the code. The atomic_enable() doesn't
fail, so for each enable there always will be an atomic_disable() call.

-- 
With best wishes
Dmitry
