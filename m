Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAFBC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1EC10E9FE;
	Tue, 21 Jul 2026 12:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VqXsEZpH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1B310E9FE
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:42:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66EB540407;
 Tue, 21 Jul 2026 12:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36621F000E9;
 Tue, 21 Jul 2026 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784637738;
 bh=lArIhcHzAKqXSmaKgvnqbdST5dwwZncsJFNsUoeIWDY=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=VqXsEZpH7AfMNnxdHZSnsbuT+XCpnEX1d/fTyW4vUHHDCgnaMmCpQB5cGvYbpMorB
 0I7DXt+zR4DwyYpgO3ak6F5Lybbbng/Etks+dEkK3cbZE42Ii4RdtgcvsETsAfX+hf
 DFqlm7pUWbKUQ7CHVqyadjU2NZobAXmN/3xFvZUYtjgmSXPNe2slpr5S0JoAiBO49+
 uHVOHb6mg0QAiu8iKVktzOebhHnC20PBq48YN3Jtfc9ESUiFwhqUQwEfOkaXuaJ1Cm
 rkQFn3m6ZpqVHH5EKXLS30Beai4wqSUI0Rz3AIA9OJ4iVOmd63mdfWo05JqVBx79Iy
 ZwaWQO2aZ2sIw==
Message-ID: <9afcb7c026bdd910082b95eeddc939ee@kernel.org>
Date: Tue, 21 Jul 2026 12:42:16 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v7 3/5] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
In-Reply-To: <20260721-scdc-link-health-v7-3-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-3-92df1b6ad5fc@collabora.com>
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

On Tue, 21 Jul 2026 10:58:59 +0200, Nicolas Frattaroli wrote:
> HDMI 2.1 redefines previously reserved fields in SCDC for various new
> uses. No version check needs to be performed, as an HDMI 2.0 sink's
> reserved SCDC fields are well-defined to be 0, and any zero-ness of
> these fields for an HDMI 2.0 sink is not a surprise for SCDC parsers for
> HDMI 2.1.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
