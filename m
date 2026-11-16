Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60944606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CB510E385;
	Mon, 16 Nov 2026 08:56:05 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE2A10EC8E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:56:04 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xSsVK-000000007s4-3RPS;
 Mon, 16 Nov 2026 08:55:59 +0000
Date: Mon, 16 Nov 2026 08:55:45 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 06/14] drm/bridge: it6505: bail out of the IRQ handler
 when status reads fail
Message-ID: <179481904177.211952.7029866729856302771@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <2e003c2e6fdb56d03c3a6effdf090079afb2ffaf.1790552614.git.daniel@makrotopia.org>
 <179251509977.78870.3399297204284524303.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179251509977.78870.3399297204284524303.b4-review@b4>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luca,

On Tue, Oct 20, 2026 at 06:51:39PM +0200, Luca Ceresoli wrote:
> One first question it whether a read failure is realistic or not, and
> whether you have experienced it on real hardware.

I have not hit it on hardware. It takes a failing i2c transfer, e.g.
the chip NACKing while held in reset, which can be provoked through
the force_power_on_off debugfs knob: it6505_poweroff() only calls
disable_irq_nosync(), so a running handler keeps reading from a chip
that is being put into reset.

And hostesly, my interest here is basically getting audio going on
that Lenovo Ideapad, and for that

https://lore.kernel.org/all/cover.1784561622.git.daniel@makrotopia.org/

is sufficient. The 12 other patches are what Sahsiko has been chasing
me into, and all the complains it had looked valid and legitimate, so
I took on writing the fixes for that as well.

[...]
> I would consider replacing all the 3 it6505_read() calls with a single
> regmap_bulk_read(), making error management cleaner.
>
> What do you think about this option?
>
> Perhaps the three it6505_write() below could also become a bulk write.

Makes sense, INT_STATUS_01..03 are contiguous and the driver already
uses multi-byte transfers elsewhere. I'll switch to a bulk read and
write in v9.

Cheers

Daniel
