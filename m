Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03359C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411A110E74E;
	Mon, 10 Aug 2026 09:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IVZbQw1u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD23E10E74E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:23:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E42E860052;
 Mon, 10 Aug 2026 09:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285BC1F000E9;
 Mon, 10 Aug 2026 09:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786353823;
 bh=IdvPpAswqw4/3CBhh1oPtwObG87J59MBx/ZFjS/sjZ4=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=IVZbQw1uWdTUO6bW6TK+IUk/hHy1q2s7kOEkTjNWa4XzEJ7N5L4oBWdsOJBOG/BQL
 uFQWH/vvS0l9j8DYBrYYi13Khavxk/4QTZvquJX9eYmDZakA2UetFCL9yTymPoTHMg
 pkoJ3tfo3//cjHiBwPDSATQ2ddyXX3e7Xs0lMcMVCGTwd02Zxv3VmPBI3yZJcnFgN6
 0Ebbc+U5q5CbiL6bjBK1yjoh9Z9T/zo/X0nGcWqIcltxTUB7tvvdyjyLgHOKj0hUTC
 xKr5Sk1GL+VAu+kZpKMgFKX8fWatXNVtEaKFUfSyP2zjo4ZJKxhGrzLa7GwRWe0dXr
 oYXfb6zHaqdZg==
Message-ID: <4ffd340eee7fbcaafdb93f203a319416@kernel.org>
Date: Mon, 10 Aug 2026 09:23:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v9 2/5] drm/scdc-helper: Add scdc_status debugfs entry
In-Reply-To: <20260724-scdc-link-health-v9-2-bdda406d016d@collabora.com>
References: <20260724-scdc-link-health-v9-2-bdda406d016d@collabora.com>
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

On Fri, 24 Jul 2026 16:22:37 +0200, Nicolas Frattaroli wrote:
> SCDC provides status information on the current display link. At the
> very least, it may be useful to expose this info through debugfs.
> 
> Add a debugfs entry for it under the connector, which displays a few
> more details parsed out of the SCDC registers. A new
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
