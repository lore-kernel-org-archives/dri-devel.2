Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79514CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D223D11325B;
	Mon,  1 Jun 2026 12:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IhXnaEfM";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6050C11325B
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:03:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9CC504E42DE3;
 Mon,  1 Jun 2026 12:03:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6053B602AB;
 Mon,  1 Jun 2026 12:03:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF7D41088822D; 
 Mon,  1 Jun 2026 14:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780315379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uWZK7z2P5SqHQterG9O6RCjs2Xr6uPCHYM9aiGRmqRk=;
 b=IhXnaEfMcTcaubGypKAmMZxJPKJQkO/bSKPx689Og3rTQZf9qEx6GbJsfUH43upSAJmX9F
 UnpZzkzOmrrJB3iexvqrr4PNzwcIBs/eUdrMd+8dgR9pjbXjGwDEEGaNfztGp3Wj7TnqSc
 KbfCNeys6R2LkwzoRkX1LwsiEmStUDJ6cpbyUHxItvk9ufNMOmFLMXvNU+rRO/b7yHr+og
 3XCSi1tU5Hlnmv++bF/nWIPzudrq/Z9ZT8gWkMEVL8ys2USKiODFUJ6M6ycgknCfqGQ+J0
 wmNmXairRRUv9jARUHNFgyzA7TTuoLxDLoDpvpnjCmhrF0s0eoK7jo4eZ8Kcyw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/3] drm/bridge: analogix_dp: Add validation for
 samsung,lane-count property
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, hjc@rock-chips.com, 
 heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com, 
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com, 
 dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org, 
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <17160115-6c30-434b-9dab-b768110cd8d6@rock-chips.com>
References: <20260529040530.741336-1-damon.ding@rock-chips.com>
 <20260529040530.741336-3-damon.ding@rock-chips.com>
 <178014803941.21632.16225608049285101452.b4-review@b4>
 <DIW1WGLL0GW5.1BGU194UXN0HO@bootlin.com>
 <17160115-6c30-434b-9dab-b768110cd8d6@rock-chips.com>
Date: Mon, 01 Jun 2026 14:02:48 +0200
Message-Id: <178031536852.7135.7751258958371598959.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Damon,

On 2026-06-01 10:59:27+08:00, Damon Ding wrote:
> Hi Luca,
>
> On 5/30/2026 9:38 PM, Luca Ceresoli wrote:
>
> > On Sat May 30, 2026 at 3:33 PM CEST, Luca Ceresoli wrote:
> >
> > Meh, messed up with 'b4 review' :-/ Apologies
> >
> > "This sashiko report" [0] was about an enum being signed, so '== 0' could miss
> > negative numbers coming from bogus DT values higher than 1^31.
>
> Ah, I agree. It would be better to add a new inline function to validate
> that the lane count passed from DT is exactly 1, 2, or 4, just as
> Sashiko suggested.
>
> >>
> >
> > And this was about "Additionally, does this check inadvertently allow 3,
> > which is an invalid DisplayPort lane count?"
>
> Yes, the DisplayPort specification only allows lane counts of 1, 2, or
> 4. I did miss the check for the invalid value 3 in the current code.
>
> (BTW: I did not find a common helper function in drm_dp_helper.h to
> validate valid DP lane counts (1, 2, 4). I'm not sure if it would be
> better to add a generic lane count validation function to the DP helper
> library instead, to avoid duplicating the same functionality across
> individual DP drivers. Perhaps other DP experts could provide some
> advice on this.)

A bool function in common code, to be reused by all DP drivers, would be
good.

