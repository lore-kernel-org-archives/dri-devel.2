Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7874C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A624610E316;
	Mon, 31 Aug 2026 17:00:06 +0000 (UTC)
X-Greylist: delayed 1548 seconds by postgrey-1.36 at gabe;
 Mon, 31 Aug 2026 17:00:05 UTC
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C6C10E312
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:00:05 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1x14xL-000000007ih-0eiy; Mon, 31 Aug 2026 16:33:59 +0000
Date: Mon, 31 Aug 2026 17:33:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v6 00/13] drm/bridge: it6505: DP audio support +
 shared-DAI hw_params fix
Message-ID: <apWs89912pK8qK37@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <7eebbd9b-3a5e-4d95-bbbb-8ba3a7238383@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eebbd9b-3a5e-4d95-bbbb-8ba3a7238383@collabora.com>
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

On Mon, Jul 27, 2026 at 01:34:12PM +0200, AngeloGioacchino Del Regno wrote:
> On 7/25/26 04:57, Daniel Golle wrote:
> > Revive HDMI/DP audio support for the it6505, originally posted by
> > Jiaxin Yu [1], rebased onto current -next with the review feedback
> > addressed: &client->dev is gone (the driver gained it6505->dev) and
> > "#sound-dai-cells" has since been added by commit 325af1bef5b9
> > ("dt-bindings: display: bridge: it6505: Add #sound-dai-cells").
> > 
> > Patches 1-11 fix pre-existing bugs found during review of earlier
> > versions of this series; they carry Fixes: tags and are ordered first
> > so stable trees can pick them.
> > 
> > Patch 12 wires up the it6505 audio helpers via hdmi_codec_ops,
> > unblocking the mt8186-mt6366 sound card which references it6505 as
> > the I2S3 codec. Patch 13 makes hw_params succeed with no display
> > attached, needed when the I2S bus is shared with another codec as on
> > MT8186 "steelix" Chromebooks, where the speaker path must keep
> > working regardless of the it6505 link state.
> > 
> > Tested on a MT8186 (google,steelix) Chromebook: the sound card comes
> > up, speakers, microphone and headset jack work. HDMI/DP audio output
> > itself could not be tested for lack of a suitable adapter cable.
> > 
> 
> Whole series is
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioachcino Del Regno
> <angelogioacchino.delregno@collabora.com> # Steelix Chromebook

Any chance to get this merged in the new cycle now?
