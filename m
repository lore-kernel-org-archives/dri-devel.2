Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF3606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 12:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD0110E86C;
	Sat, 14 Nov 2026 12:39:53 +0000 (UTC)
X-Greylist: delayed 1223 seconds by postgrey-1.36 at gabe;
 Sat, 14 Nov 2026 12:39:51 UTC
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDB210E86C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 12:39:51 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xSCix-000000004N3-2XUv;
 Sat, 14 Nov 2026 12:19:15 +0000
Date: Sat, 14 Nov 2026 12:19:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
Cc: Jani Nikula <jani.nikula@intel.com>,
 Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: Re: [PATCH v8 00/14] drm/bridge: it6505: DP audio support +
 shared-DAI hw_params fix
Message-ID: <avhRv2PdtfFMOu2v@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790552614.git.daniel@makrotopia.org>
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

Hi,

On Mon, Sep 28, 2026 at 12:49:25AM +0100, Daniel Golle wrote:
> Revive HDMI/DP audio support for the it6505, originally posted by
> Jiaxin Yu [1], rebased onto current -next with the review feedback
> addressed: &client->dev is gone (the driver gained it6505->dev) and
> "#sound-dai-cells" has since been added by commit 325af1bef5b9
> ("dt-bindings: display: bridge: it6505: Add #sound-dai-cells").
> 
> Patches 1-12 fix pre-existing bugs found during review of earlier
> versions of this series; they carry Fixes: tags and are ordered first
> so stable trees can pick them.
> 
> Patch 13 wires up the it6505 audio helpers via hdmi_codec_ops,
> unblocking the mt8186-mt6366 sound card which references it6505 as
> the I2S3 codec. Patch 14 makes hw_params succeed with no display
> attached, needed when the I2S bus is shared with another codec as on
> MT8186 "steelix" Chromebooks, where the speaker path must keep
> working regardless of the it6505 link state.
> 
> Tested on a MT8186 (google,steelix) Chromebook: the sound card comes
> up, speakers, microphone and headset jack work. HDMI/DP audio output
> itself could not be tested for lack of a suitable adapter cable.

Kind reminder regarding this series.
Some of the patches have received a review, others did not yet.
I'd be great to have the Ideapad with working audio without being
force to build with downstream kernel patches...

I've added Dmytro Malovanyi and Jani Nikula who have both also
recently been involved with other patches for the same driver.

If there is anything I can do from my end, please let me know.


Cheers


Daniel
