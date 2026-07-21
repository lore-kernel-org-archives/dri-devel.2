Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE4C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D17110E0F8;
	Tue, 21 Jul 2026 13:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QDJ9u6Rh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B71510E34C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:49:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07EDA41E8A;
 Tue, 21 Jul 2026 13:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F091F000E9;
 Tue, 21 Jul 2026 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784641776;
 bh=T71grAhlefTCoaH3/HnR/Gxf7jbUfL6CXZ/mQnb6MnQ=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=QDJ9u6RhEeqAQ8jRz5BRa0K3ugTnmhNm7eztASTRdi5Y93mY+g3mkl5aB/7e68AKh
 tIKQXQvBCnCJVEPkg+wTDAiVWVwiUqVK/TCvMdMPCVjkbf+ia+0kupgi786QSHjrPp
 uTiuNedR3H6uLoeYDNzl9cwTvJtdJr/fb8nwubMlqBLK8bcpqr/Ca52ZLoG5hRErfn
 J6/cwCL4/Ik5o+a2zOXOiOxc6YezMtne+yDrx68yGv6Zlpec7+b1Y+9A8Y0p62zsn4
 HnCZZ3j0tCxSX4HjrTgmQv7RUiy//p73Vsi7rtGVOI3sqEACeM7ZOaW1Rg1mqAvkO/
 guXxfX6ju+7+Q==
Message-ID: <41e0ff0b380e6f4bf4a9f64061f17d58@kernel.org>
Date: Tue, 21 Jul 2026 13:49:34 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v7 5/5] drm/display: hdmi-state-helper: Init SCDC
 debugfs for HDMI
In-Reply-To: <20260721-scdc-link-health-v7-5-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-5-92df1b6ad5fc@collabora.com>
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

On Tue, 21 Jul 2026 10:59:01 +0200, Nicolas Frattaroli wrote:
> Initialise the SCDC debugfs file for connectors that call the HDMI state
> helper's debugfs_init helper. This makes all connectors that use the
> helper expose the scdc_status file in their connector debugfs.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
