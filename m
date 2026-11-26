Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17027606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=1FyswOWR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A8E10EA35;
	Thu, 26 Nov 2026 18:34:39 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374B110EA35
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=gZd0J6e4Vwhc7KaA03ZOyx2UROI87QlvB1FAZkxX2CQ=; t=1795718073; x=1796927673; 
 b=1FyswOWRGK5JchlGFX9QjqALR4GRf8fMJiNOVMN/kW3fs1qM1CjKZ1uCpbOAoSmS54veiusMMQo
 Ev1f4MqA+Cp3kkwi+/9+hBhsq+U5jcTkIVeHD9XOCbEywVLWuUPzkFB8nQVpzg3JqQOTpPcHBDEJx
 ItPlaBXNhEbFHrFpEdOjmsscLh3yHlumZvEv7VoKUla4fucAVXHrJjeuqO0s0fZg8z0kdDGjznf4l
 A5KQBBdli+2nea2/5rM868MGt+w9gJIln+Q4Qpe9rQ1smNX8eth4s7el6T0MK9YoN88tN5vbHA/9B
 yzNmb+Me8TsK60irYjEWepqfMU0oLRbKzKww==;
Date: Thu, 26 Nov 2026 19:34:23 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Dmitry Baryshkov"
 <lumag@kernel.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Christoph Niedermaier"
 <cniedermaier@dh-electronics.com>, "Marek Vasut" <marex@nabladev.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <kernel@dh-electronics.com>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358762: fix reset handling
Message-ID: <20261126193423.2344f609@kemnade.info>
In-Reply-To: <DN5AB16C26GE.3M5Y1X38QATK8@bootlin.com>
References: <20261125-tc3-reset-v2-0-32eefcaf1460@kemnade.info>
 <DN5AB16C26GE.3M5Y1X38QATK8@bootlin.com>
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

On Thu, 26 Nov 2026 17:31:09 +0100
"Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:

> Hello Andreas,
> 
> On Wed Nov 25, 2026 at 12:37 PM CET, Andreas Kemnade wrote:
> > The bridge driver desserts reset after disable and asserts that
> > upon enbale. That requires users to workaround that by declaring
> > the reset gpio wrongfully active high.
> >
> > Fix polarity in the one device tree actually declaring
> > a reset line. That patch has to go in after the bridge fix.
> >
> > The issue came to sight during experiments with reset lines on the
> > Epson Moverio BT-200. There are two of these chips with a shared reset
> > line, so also prepare for future conversion to use a reset controller.
> >
> > To avoid having GPIO maintainers spammed with a bunch of patches for
> > BT200 support, do that fix separately and now, so it can go in more
> > fast-track way.
> >
> > The devicetree change is only compile tested and is more
> > a cleanup, not an urgent fix.  
> 
> Can you test it and report back? I guess it just means applyint patch 2
> without patch 1 and checking whether it works.
> 
No, I cannot test that. What I can confirm is that BT200 reset with a single
chip works with GPIO_ACTIVE_HIGH without Patch 1, with Patch 1 it works with
both GPIO_ACTIVE_LOW (which is the correct descrption of the hardware) and HIGH.

Patch 2 is based on the assumption that things are working in the state it
is in right now, and only corrects the description of the hardware.
I expect to break things if it goes in without patch 1, so probably the
best strategy. would be if patch 1 goes to v7.n, then patch 2 should
go into v7.n+1.

BTW: BT200 support depends on the stack of patches from Tomi + my RFC +
reset wire up.

Regards,
Andreas
