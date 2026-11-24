Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD4606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=C8M1+SN+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A2B10E44C;
	Tue, 24 Nov 2026 14:24:06 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E0410E44C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=NrmR7f4NWvJtaGShihv5Oaav7f9YUTikEYvCAM/Zj8A=; t=1795530240; x=1796739840; 
 b=C8M1+SN+SyxPP5AW+s6I/sBL2KqFAW3E3QJGTgSikI7+HnWSU8AznlacoOxzRLiW2AyrxIktkVo
 L6WpnCmoBr7GySzD70da7goNISGRiyQNBUunTLf3xnSY/wfRcKOORWLBEVJ24P8SGgPj+9OHCkidm
 ROe8AUj3BCFxJF1rVZBRfssGDXqrLRONs4d6WLhYerxhhCiZPatOzCjZgDYpvd5f3gFabTBBLvJVu
 jPUmmE5HllI+7BtGER1PavmxWkNdBtvsnmuo3CxgEhDj6LgByj9hwpNot9OI6zsf5iCnOVphcXfi6
 jlHDd6yIzqeSSzNZ916USVVKcPj24VIxsCxQ==;
Date: Tue, 24 Nov 2026 15:23:49 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong
 <neil.armstrong@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>, Robert
 Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Christoph Niedermaier
 <cniedermaier@dh-electronics.com>, Marek Vasut <marex@nabladev.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH 0/2] drm/bridge: tc358762: fix reset handling
Message-ID: <20261124152349.6a1b6826@kemnade.info>
In-Reply-To: <7a94fa5a-ddfc-449e-b014-387d8e868e97@ideasonboard.com>
References: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
 <7a94fa5a-ddfc-449e-b014-387d8e868e97@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 15:44:40 +0200
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
> 
> On 24/11/2026 13:54, Andreas Kemnade wrote:
> > The bridge driver desserts reset after disable and asserts that
> > upon enbale. That requires users to workaround that by declaring
> > the reset gpio wrongfully active high. As an interim solution,
> > ignore polarity, until things have settled to fix it afterwards.
> > That will break setups with an additional inverter in the signal
> > patch but those should be uncommon, at least not seen in in-tree
> > devicetrees. Fix polarity in the one device tree actually declaring
> > a reset line. That patch has to go in after the bridge fix.
> > 
> > The issue came to sight during experiments with reset lines on the
> > Epson Moverio BT-200.  
> Indeed, the driver has it the wrong way... But what is the way to fix 
> this? Fixing it will always break the backward compatibility with dtbs.
> 
> Is it worth it? Or is it easier to just adjust the bindings doc to 
> mention about it, and add a note to the driver that the gpio is set the 
> wrong way "on purpose".
> 
I am a bit wondering whether to use the reset-gpio driver as aux device,
and then we would need correct dts. There are two chips sharing a single
reset line, so I have to deal with shared gpios. It seems not to work
that well directly. But first I try to have things working with well-defined
boot state.
That reset-gpio stuff was invented exactly for that case, see commit
cee544a40e4426040946e685988b1489f13e6600.

> Or, if this is to be merged, I think the code around the 
> gpiod_set_raw_value_cansleep calls should have a comment to highlight 
> why it's calling raw funcs and what the plan is.
> 
Yes, the comment should be there.
Sashiko suggested to add an entry to 
of_gpio_try_fixup_polarity()

to have fixups.

Regards,
Andreas
