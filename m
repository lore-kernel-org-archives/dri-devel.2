Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17771606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743E810E64B;
	Thu, 19 Nov 2026 16:26:49 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AF610E6FD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:26:48 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xU4y2-000000007XY-2OT2;
 Thu, 19 Nov 2026 16:26:34 +0000
Date: Thu, 19 Nov 2026 16:26:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hermes.Wu@ite.com.tw
Cc: luca.ceresoli@bootlin.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, allen.chen@ite.com.tw,
 treapking@chromium.org, wenst@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 08/14] drm/bridge: it6505: avoid division by zero in
 audio FS debug print
Message-ID: <av8jL0W1vgdqPQhu@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
 <26ee2c94c42fb09c081201071cb5730c96c8c25b.1790552614.git.daniel@makrotopia.org>
 <179251509978.78870.2485132679226608837.b4-review@b4>
 <179481904178.211952.8076269834336042526@makrotopia.org>
 <9485b4a86b124cc3a528ca147609bf4c@ite.com.tw>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9485b4a86b124cc3a528ca147609bf4c@ite.com.tw>
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

On Wed, Nov 18, 2026 at 03:12:14AM +0000, Hermes.Wu@ite.com.tw wrote:
> Hi Daniel, Luca,
> 
> On Mon, Nov 16, 2026 at 08:56:18AM +0000, Daniel Golle wrote:
> > On Tue, Oct 20, 2026 at 06:51:39PM +0200, Luca Ceresoli wrote:
> > > If you could share what that register is for, it would probably answer some
> > > of those questions.
> >
> > I don't have documentation for it either, and with ITE gone there is
> > nobody left to ask.
> 
> REG_AUDIO_INPUT_FREQ (0xBE) is a read-only input audio frequency
> counter. The driver uses it to check whether the I2S BCLK is
> present and changing, i.e. whether there is audio input.

Great to see you are actually still around, and thank you for confirming
that we can drop the register read there.

I was afraid the bouncing emails of the former driver maintainers would
indicate the driver has now been orphaned. It'd hence be great if you
can enlist yourself in the MAINTAINERS file for that driver.

> > As for the logging, I don't think it is worth an extra i2c read and a
> > division in the enable path, so in v9 I'll drop the read and the
> > print from it6505_enable_audio() instead of guarding the division.
> 
> Fine with us, the value is only informational there.

+1
