Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD72C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0495D10E769;
	Tue, 21 Jul 2026 14:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G7GRxw8W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B9010E769
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:19:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FF246001A;
 Tue, 21 Jul 2026 14:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC091F00A3A;
 Tue, 21 Jul 2026 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784643558;
 bh=doxlar0h1i/Mc/eyGBx3FgbrfxAmZ8ASm3b2ucZdj4Y=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=G7GRxw8WUXfAFYdaeTm340OKqVwsM3pgjKqi658oBzEJArpgcXW9knXwU8T25VR4a
 F3cZe2hY5XwAd3TmJYfMgYC8dWlY6xPppV0vrcZ5DtsvCBggKMkHm3kApoC+9Y6Rai
 /OteLMOyfX3s1ssPqCk9tXZTmHluhuinWGYC6hbzYOGyXb+F6KrcJBDniwNikbKUvt
 VqFjji77T49zcZNP6armTeUrSlgk75f7nxgvBae1ADT3rjzHV6ZQmNcer8a++tJ3Y5
 afDoLmwZQ5DzCuuG0sSsyQo02eOfhtAsRJZIgmisxac4ZtOZzS6zo7B7bCoI729Nn+
 fDcuPhWEFPnGA==
Message-ID: <351720a5ab7640ef0239448b1f7965c4@kernel.org>
Date: Tue, 21 Jul 2026 14:19:16 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v7 4/5] drm/debugfs: Move HDMI debugfs registration to
 state helper
In-Reply-To: <20260721-scdc-link-health-v7-4-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-4-92df1b6ad5fc@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniel@fooishbar.org>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil+cisco@kernel.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Tue, 21 Jul 2026 10:59:00 +0200, Nicolas Frattaroli wrote:
> The HDMI debugfs files are only useful for connectors that already make
> use of the HDMI state helpers. In addition, relying on HDMI-specific
> functions in drm_debugfs.c can lead to circular linking problems later
> down the line.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
