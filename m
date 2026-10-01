Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAD9CA5FC1
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07C110E10D;
	Thu,  1 Oct 2026 02:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRdP1ylR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8BMjkGo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8E410E10D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:35:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jipN171516
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=htg6wDlN38DdW2E5SbXi6aX/
 Ov2gAq5Dj5yDzZtrY9k=; b=nRdP1ylRLq0X7V6uMTE9XSHIb39aoFGl4thT7L09
 5TKyYdzUGslF0cJk1ADxYz8m3ZOQcpAdCFyR3dCLW3jHUrgkQp0lRVUaFYq5LPz0
 xiLGxETO9TPuHn8vFlA7qA84RzNXVxHbSOHuKp76GedFCk+3NxgrZ6H5V5n5Yb3p
 SSbia/uot3oaHbXkpX6MhjrHkje+3huqFJU3X62WW6FzrTPIZgzsAvgjATMlXx/P
 +wHYZ3SuWq71CgGK4V9xGnZN5uHBB5m5aChAB5IrXIHFxjFXGmFb59WGH79Ob6Pg
 DBygFE1kA3tOeq+gmQIf8pMKJQ3DNoNfpljc+CPVqMqFGQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcsvgd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:35:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-339628f2bbaso708206eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790822104; x=1791426904;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=htg6wDlN38DdW2E5SbXi6aX/Ov2gAq5Dj5yDzZtrY9k=;
 b=X8BMjkGoBT6hZFEuXd89rfPS0+ve+kNeuRZUc5flwDC0xLhp/6+5t2kDtEo1sk8KHE
 CIp+Nq5x6W4Zlx7o+p3ct4N9SlpmwtbmfwyA1VAkGvGzepw1rOqHwubPQCM3Q61ubobh
 ORoAd+dtZjV3mmB10FWL5rlKijkOAoBPCWz9KMCSw8FM3BU020sz3E4bhCcEcqgl4yCr
 NbmfAr4CfURGLWmx93R2LsnH6vhWcDACo4Va5fARMUrAGjTAwT5IfwiGZor4iawDbBtj
 MGFZv+iVE/Fm842LRThsoLNZ8wiKVXWJFMnrCYdV0LKmOR+aScsptIHDJCFfvmjvzVue
 9IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790822104; x=1791426904;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=htg6wDlN38DdW2E5SbXi6aX/Ov2gAq5Dj5yDzZtrY9k=;
 b=Dgnj2UwdZ1wHYJIbRvlZCHT0lv5lsPRh1wiVl1IQ9VsvrOXC2Mb99kbBP/sPJj0xEP
 PvdO4xNY0uAFZ1vxtaFFV+85cAKtnSttP3csOM9T4azCvJiOhdjrGthdhJrY03JlahH4
 KswuxO/vRVMMll/LjcCj0snSXniqA2H9tirfhaX1kjL9H+scIMwPom89Qc3VkzGuudmU
 4tKrCad1KTYZ670Rl7hZFMQct5jUk9W5nbb1wrU4DUeadvp0ZA8hpVUF3ItRdmOY4z8h
 dZ7ELdn7lU6LugFmFKQ5NdKnl5fVgHCTQGyYS2OTaCVkb+Vw5T+v4ufw9MjwWfW/oW8W
 K3pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTMQIhraD0g4YRS0/Ybk3oNTVWh8+FGqeMm2l0dKk2HVrq3IQDXSWKg60kHy/o1nkwoCZlBPCTMcM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlOQcPjve4ENvYdtDN2EevASI9Gm5k0m90VBsT6ywBfCsDFpHx
 F1KMRj4vUbeXlJXtRX6dHwlLIFGxLHu3azbaR1+Q8zi0bDN+eOGVcd2D8whZROVQlvdVAzDoAPJ
 1kZRo/BIN2ZXiPQzT0qUwbb/R/VoY4NatS75j2OoP5hI7v9mggJlg32x/01a0oTMypM7Zqwk=
X-Gm-Gg: AYBFou2iGElrIrppAQZ4n925+/jHQlHha3EtDRUU2wIieYHrbdjau1qyRo6Wl+EdvyV
 jYN9vomBv28oMLC9o9q0qfXbfsJKpLnd8UUAKn0X9iXoY8ltSyE7b9dn88pkeXPqF9n82B/bCGh
 o5Eix+APvWkcihE2KCBsfJkgAfBsFmE8I8gqO9fCkeqheqYsinBel459oxfAgeoQ88Jc4fCkSnq
 PrHvp8iha8dWYluAKaVVPXeghQ/mf7LLzDFWdH5ovY2V7D0Pr8KQxGtOePEocr6nyLO+bRMRvd7
 PtdrqNGXcFLUiT60iKADsF23T4bWcoERka8xBKUKY9IAG9kRziBOdrfaOyg57yyqm5yzEsCiDoq
 93IuFpv3E78nr3pNjPk27hksYw9krhKedBYJCRDzQAebqKdyvHNadTOHxqnkOTDd1DU0qXCquSx
 mBcL71SoJJFH3xkLNqPA0=
X-Received: by 2002:a05:7300:b54b:b0:343:fdea:9a0 with SMTP id
 5a478bee46e88-34cdd9900bfmr6742062eec.2.1790822103372; 
 Wed, 30 Sep 2026 19:35:03 -0700 (PDT)
X-Received: by 2002:a05:7300:b54b:b0:343:fdea:9a0 with SMTP id
 5a478bee46e88-34cdd9900bfmr6741984eec.2.1790822102643; 
 Wed, 30 Sep 2026 19:35:02 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14df3bb4a2fsm2427281c88.8.2026.09.30.19.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:35:01 -0700 (PDT)
Date: Thu, 1 Oct 2026 08:04:51 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v9 2/2] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <ar3Gy4F1Ym3KNuaV@hu-vishsain-blr.qualcomm.com>
References: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
 <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
 <61aa851b26f9aa85a3ec1dc4bc8f46d7f1fbd24e.camel@pengutronix.de>
 <d924369a2f907aa796d7eba692001593ef1e6d0d.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d924369a2f907aa796d7eba692001593ef1e6d0d.camel@pengutronix.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX7pG8w4EYMXW1
 8A/HDbVaNv/5mGlnWpTI18am/3V9cbU4zJZPwdeTXOAUvB8jiNeOVNezgHy7213Tc/HsiVeax1M
 0l0POxjbE3eB049+y+JvLw0pOJ7w2egubQBC4b1oL25mKdXaDs+V7sONn768eN+cPnMWltJ4cyx
 zxgJjmAqUPuGwbuhcGrgJKgxMRIgassI2Mj7P5AXpUUxIz6RiLnj9g3Xkk0t9DZmNiPJcp0H8Dc
 EvdoM/0KDVr5RoeA3v7OcnEDT8sPNygAkZ5AuYx8sUDERFRmJ3OaQ88Hl9Mc+OcuC/Pw5cOI0Jv
 BgmSgj7B1CTYouQI34YE43/8O6wh5q7199aVPGfzZ7kzaPh7TADo4fM0oGdxedpgmKhujH6WPiq
 vlTA1cqekhuJrMZyLVI7mgyOUMNzJwF+a9Nq/+uXw3e1p3mc97gcu0o2qr2bxMequbv8ybNU77e
 Ba5yrfDqp1+WoyLEhvA==
X-Proofpoint-GUID: OHVl-rjODyjHFPdgD2RN_nfaRER5kDup
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX16d5jNug97bT
 NKMK9zcUF5YJ64S3W+kwvJoHfBDLGWUXi6SrVU9OBBnAShe3wUrjZLDmK2zNeLBWkF7fuQz0jsR
 hjCTHAnNCGS9IdUx+MV40eBN61VEt7w=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abdc6d8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jvwfOezYHQUHBwXlzkIA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: OHVl-rjODyjHFPdgD2RN_nfaRER5kDup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010010
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

On Mon, Sep 28, 2026 at 12:13:42PM +0200, Philipp Zabel wrote:
> On Fr, 2026-09-25 at 15:23 +0200, Philipp Zabel wrote:
> > On Do, 2026-09-24 at 21:29 +0530, vishnu.saini@oss.qualcomm.com wrote:
> > > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> > > 
> > > LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
> > > Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> > > Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
> > > bridge configuration by detecting and handling both LT9211 and LT9211C
> > > variants from a single driver.
> > > 
> > > Chip detection in lt9211_read_chipid() is extended to identify the
> > > LT9211C by its distinct chip ID registers, and cross-checked against
> > > the chip type requested by the DT compatible string to catch a
> > > mismatched board/compatible combination.
> > > 
> > > Add LT9211C-specific regmap support and use lt9211_chip_data with
> > > i2c_get_match_data() to provide per-chip configuration.
> > > 
> > > Five new functions implement the LT9211C DSI-to-LVDS initialisation
> > > sequence: lt9211c_configure_rx(), lt9211c_autodetect_rx(),
> > > lt9211c_configure_timing(), lt9211c_configure_plls() and
> > > lt9211c_configure_tx().
> > > 
> > > Defer the remaining LT9211C initialization to a work item scheduled
> > > from atomic_enable(), since RX auto-detection requires an active DSI
> > > stream.
> > 
> > This is still wrong, and I don't understand why you need it.
> > 
> > All scheduling initialization as a work item should allow is for
> > downstream bridges and/or panels to be atomic_enabled while
> > lt9211_work_func() is waiting for a vblank interrupt.
> > They expect the LVDS signal to be active at this point. If LVDS is
> > enabled at some unknown later point in time by the work item, any
> > startup timing requirements the panel might have can not be applied
> > correctly.
> > 
> > Also, deferring initialization as a work item shouldn't have any
> > influence on the upstream DSI signal. That should already be active
> > when lt9211c atomic_enable is called. Could it be that there is a bug
> > in your display controller or DSI bridge driver that causes the DSI
> > signal to still not be completely active at this point?
> > 
> > > Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> > > Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> > > Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > > Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > I have not tested this version (yet).
> 
> I have now retested this on RK3576 - both as-is and with the
> "drm/bridge: lt9211: drop delayed work" patch I just sent.
Thank you i will see how atomic_enable is handled in RK3576
   
> I still think we have to figure out why the DSI signal doesn't appear
> to be streaming as it should when lt9211_atomic_enable is called in
> your setup.

> When enabling the lt9211c synchronously, is there any error?
> Is just the Sot/RX: debug output incorrect?
Yes, few details were mentioned in our v6 discussion.
droping delayed work is not working as expected. lt9211_autodetect_rx failed to read the format,
Tried increasing the delay upto 3s before reading the format buf, did not help:

With synchronous approach,
i defined a dummy drm hook, hw_enable_timing which is called after enabling the timing engine in drm/msm dsi host driver, and it starts working (bridge configuration was synchronously but in this dummy drm hook). So to remove delayed work, changes required in dsi host driver. Shall i defer bridge level atomic_enable callback from drm/msm/dsi host till timing engine is enabled?

> Which display controller / DSI bridge drivers are used to send the DSI
> signal?
I used drm/msm/dsi host driver on qcom lemans/kodiak/monaco evk platforms.

> regards
> Philipp
