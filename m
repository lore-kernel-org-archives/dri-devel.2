Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC5606A338
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBD510E3A1;
	Mon, 16 Nov 2026 08:56:38 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5712210E3A1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:56:37 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xSsVs-000000007sv-10gN;
 Mon, 16 Nov 2026 08:56:33 +0000
Date: Mon, 16 Nov 2026 08:56:18 +0000
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
Subject: Re: [PATCH v8 08/14] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
Message-ID: <179481904178.211952.8076269834336042526@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <26ee2c94c42fb09c081201071cb5730c96c8c25b.1790552614.git.daniel@makrotopia.org>
 <179251509978.78870.2485132679226608837.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179251509978.78870.2485132679226608837.b4-review@b4>
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
> By just looking at your patch and the current driver code I'm failing to
> understand what's going on with the REG_AUDIO_INPUT_FREQ register:
>
>  * it is read, but never written
>  * its value is used by:
>    - it6505_enable_audio() only for logging: is that logging really useful?
>    - it6505_audio_input(), just checking whether it is 0xFF or not; what's
>      that 0xFF? Is it documented? A macro hinting at what 0xFF means would
>      be better than just '0xFF'
>
> If you could share what that register is for, it would probably answer some
> of those questions.

I don't have documentation for it either, and with ITE gone there is
nobody left to ask. Judging from the debug print, which computes the
sample rate as 6750 / regbe kHz, it is a read-only measurement of the
audio sample period, and 0xff looks like the counter saturating when
no audio clock is present.

As for the logging, I don't think it is worth an extra i2c read and a
division in the enable path, so in v9 I'll drop the read and the
print from it6505_enable_audio() instead of guarding the division.
Without documentation I'd rather not invent a name for 0xff and leave
it6505_audio_input() as it is.

Cheers

Daniel
