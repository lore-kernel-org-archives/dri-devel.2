Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911C9C5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA98C10E1EE;
	Mon, 10 Aug 2026 16:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="itKSwwlG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PAzo2FE6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDC910E1EE
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:45:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGERRo2184965
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=N7ZoU6l9gAur6xLvTry0EmvP
 Ub1/IYFKLAnZnyKwao8=; b=itKSwwlGYDWEEcQ91+aQGmc1hi9gFVjeaN0KwapT
 cXBO0G1VOXnUVwUKFegtpoyw6j2Tfd9SXqTQoBOjKo5DCed9CiLbOk7kdSAZb0cS
 7zcQadk5hisLHpmGky+lH1Ex0mYbC5K71yNd7VIdxRkQbo2Ign7lK8J+0pmk8kDz
 ir0jOzf9zs3eA0o0vLJxYJ+xF5WV3mBychGQd2HJ8XRJXumlfDQAZcSZTtw8VIpe
 hW0iNRXCR9pPDUJYaPl+fDa92rcrefE4WpvMKq+kfFqCsC+anDUPazsbKT7ry+Gh
 7XiWg7fie9auiY80hav5ZPnZ7cP7eGLV0go/CcbNIIDtSw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fybh5a1jh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:45:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-387087245e4so690170a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786380357; x=1786985157;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N7ZoU6l9gAur6xLvTry0EmvPUb1/IYFKLAnZnyKwao8=;
 b=PAzo2FE6zKTF9t0ZyJZNaP0QXOWaUTHeIABzhRvgVk6yZiJ/84A/ZEvj9nnUcNQWKF
 /EzZt9zigtHI6zJ49ldpwQ444jrfLOBwwyxZuuSaJbI8HUcArboUJdlyK3KBDgIT6xWT
 ld7q1Da3O8vLL+0eidDjpjuC1/nEMx2TgVdgKCLorA4C7C04mXKzPuFlnWl6F4NdkgtV
 +/Izor8Q0vJUwoTJYgwYoiLeBydt9xbPahfQtikzvhRUGYSrr/sZ2I6IH/un8EhCkTct
 e0zbYHfJzvNSGLedvVqXq6GDhuIGKAfl1GlhVBjogX7gGiPhQqLR+qTKD6f+pJGNRhqz
 jdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786380357; x=1786985157;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N7ZoU6l9gAur6xLvTry0EmvPUb1/IYFKLAnZnyKwao8=;
 b=P0VpW+mIMyyxV1dGklKJXbL7f9YhelmDO3vjxtndtGt1IjYDaOyYSqLXjU4UW6tvee
 OkyfXZxymfP0/LtxkxyPWYZ6r5JwAQaIUHoFaqYmnhY3cIyK44R2lrvWHUEWPmv00IHk
 0wQKZFTxHT4LgVkwKH78fUNqV447+Mf3GzMSiILg8AP4iSHpArgXHtRM/8YY8cVYkVbI
 lxWcgB8Q3/LY3HqOhFkle+5Ggh1+Y0tAKoypxl5fOlqig575FmCVtOhFqDvSkxZybLpr
 Kz47TFGE2JLNGAlcrSIcLekTGoit74tgTPlwDb0OO3KJmLgtoHbegP1F62Xsjr5i6l02
 hHoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeTwOlaGWya61wj1B99GisBfVe6CIn9tZ5fBsvPaI/06aaqc2TgwXPMhpeba9bvMbeQ6RCJS/ykUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmptcg/odTBNVGcwhFxJ6dwPtTcmrNsM/Bs+eg6ZxlnkT8hz+4
 XPK1NwYpFgcqH0V2wcYzNmg/dYnTyz81LfbuSdteD+YPSEfIAnIRw5Cf5WdZ7+m+kOLyDVlxWDg
 el+qwYKHzTSDk904FF+Xnkh5kllxKF/dVGl9ljm9gLlQiqxkdJ95ScFI6N/x03RO1r3N2v6c=
X-Gm-Gg: AR+sD100comdmSSd98G0eH96p5aXElL0++TITHXBPVCyI0ZteWJaynnBjVqffNcqssi
 X/RuvoMFOTCVdv8/NnqgqdnMdiXKgLnh/WdrCQPEJ07oDu1Io0iyQfCHNEArVu0667WxErYUThP
 SYSNysJcGGbT/S9KFjNY8HXK4/EwUq56fZvtVqqywcgYQx2kP9AbhrjD9X9D06hYE28dttyKTv0
 LTf0rhLo+D0kDI1JC8voRXRUYsC02sqbROWr0mMi9HQsNBsHm9TMO/2+tf1PWJ6o+p0rm2Yn8li
 fYHWMPQJfU4rWANOH8s9oCsV877N/1onayKGH0yaHJqiz/DAMfntfKfNc3U4dyf0OzFNEGlzDof
 0p1EJ4ugr7wMqFZTsaS2egcli10GPlIOi4mnAWQVMmbZWyRQp/65xPDLkxGHac3C8JhsCUhXZGu
 bVt3rhR10acwVG6pOsZMWs
X-Received: by 2002:a05:6a21:329a:b0:3c3:94bb:ceb8 with SMTP id
 adf61e73a8af0-3cb85e263a8mr36034898637.1.1786380356779; 
 Mon, 10 Aug 2026 09:45:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:329a:b0:3c3:94bb:ceb8 with SMTP id
 adf61e73a8af0-3cb85e263a8mr36034840637.1.1786380356190; 
 Mon, 10 Aug 2026 09:45:56 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f370e61sm4307737a12.27.2026.08.10.09.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:45:55 -0700 (PDT)
Date: Mon, 10 Aug 2026 22:15:46 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Yi Zhang <zhanyi@qti.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH 0/7] Fixes for lt9211c
Message-ID: <anoAOgbBmS5iyccu@hu-vishsain-blr.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
 <20260806131715.508557-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131715.508557-1-p.zabel@pengutronix.de>
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7a0045 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=B3w4L13e9EP2vHzqb_cA:9 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: nFxv5eKvzyLQFG9rWKtlQFRnPy9c09h4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0MyBTYWx0ZWRfX3himvHj5fRtv
 UD8KQhPmnUCYWOLjvUKRCIT8itsgjOw9dYQeswGdihqziexQN87voeS6e3Ztu1++NdQWK54AzKw
 i5e6TIS2qE+JxT4QOsYo2Kv6p07poFA=
X-Proofpoint-GUID: nFxv5eKvzyLQFG9rWKtlQFRnPy9c09h4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0MyBTYWx0ZWRfX0xAeNlkWfb4B
 FsEO93R2qZ43CaibbnlLHburBFdsq/nwnPkgTX3ZxuuJjBY5mdq3PoBRj05VKqpNdUyiOK5gPkN
 zDV4c0ZXbUjdHdzUE2xJqevTguYiFg562e5hblQ51Zgv2Y4WiyMcbHiG7rNMDOa6h5flCsh2YT0
 BTSd9xDrN657JsXat6jWWB9+7JI+h8RkttfPnDmfqUD6BceF61fA7vOkLgaLRwZe67OuY5wb0Il
 H59Wk7MMlnn5QBHztd5/CqYJRdCp0FEZGjhKHIWKBYS8Qv0pypt29I8tf5I9RF2sutAtezyEISf
 H+jvLrlMjXASpusMXhaQYWQnYAJjMwe0D2F7lrCReiSMDj4bYGO1pQQETuCagzN3CNHYcA/u8d7
 oqpQFSQCk+zCTNUD+YLRWZhCB1yMqyuxzeBM36M1olsvt4ESrKMT6kln21dRa77m00K4IRRJBM1
 CS+gCT/Tf5BIM3DHTsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100143
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

On Thu, Aug 06, 2026 at 03:17:08PM +0200, Philipp Zabel wrote:
> With these fixes
> 
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> on RK3576 with a 1080p60 panel @ 148.5 MHz.
> 
> Feel free to squash any of these into v7.
Thanks Philipp for the review and fixes on V6, will be addressing them by EOW.

> regards
> Philipp
> 
> Oleksij Rempel (1):
>   drm/bridge: lt9211: Enable DSI burst mode for LT9211C
> 
> Philipp Zabel (6):
>   drm/bridge: lt9211: drop delayed work
currently droping delayed work is not working as expected.
lt9211_autodetect_rx failed to read the format, Tried increasing the delay upto 3s
before reading the format buf, did not help:
lt9211 2-002d: Unsupported DSI format 0x0

I am further looking into this, let me know if you have any suggestions.

>   drm/bridge: lt9211: fix regmap_write error handling
>   drm/bridge: lt9211: use regmap_write_bits
>   drm/bridge: lt9211: reuse lt9211_configure_timing in
>     lt9211c_configure_timing
>   drm/bridge: lt9211: combine equal branches
>   drm/bridge: lt9211: use devm_drm_bridge_add and drop lt9211_remove
> 
>  drivers/gpu/drm/bridge/lontium-lt9211.c | 189 ++++++++----------------
>  1 file changed, 61 insertions(+), 128 deletions(-)
> 
> -- 
> 2.47.3
> 
