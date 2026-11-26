Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ikpepjGN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C490610E9EF;
	Thu, 26 Nov 2026 19:38:05 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F20710E9AB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:37:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8E8551A1821;
 Thu, 26 Nov 2026 19:37:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5EE0C60558;
 Thu, 26 Nov 2026 19:37:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 156A911E68361; Thu, 26 Nov 2026 20:37:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795721871; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ybgKfYhvLLU6UqBy8vCA/+mhJgc1ZHe5FG2bKhBu33A=;
 b=ikpepjGN6sLKeY5KwFcYxKIG1E9nr29DC1TZLHGxbMfWVZF+/P/Yyr0QsaYzSjFSMvYlda
 /AVOUAjUJ5yv2pMovn9eC2e6V8iKJU+8ekSOrJbyDk1bbAzHKSC1nnBvwJwvu060nADTN4
 OIkLuACu5VZ0Fi6w1MIwulFj1cm6ouGlut+nvLbfHtoTSUYAoWg5bFkntpdzVvcKp9smgz
 /bzChrnaA7J0UiqwudDozyaSFRxadMMqec7pWt2+VFrD2RcDEHICmc3z8Uz+E9qChY0m4R
 eoBnaqA6+wKKu7H2AkAhN/sBVj5CMtyNCUSen+7ZG3+xkzmLBSP4gCgTGNm4vQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:37:40 +0100
Message-Id: <DN5E9UEG4WF7.3HAHIZ08FF1OA@bootlin.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358762: fix reset handling
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
To: "Andreas Kemnade" <andreas@kemnade.info>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261125-tc3-reset-v2-0-32eefcaf1460@kemnade.info>
 <DN5AB16C26GE.3M5Y1X38QATK8@bootlin.com>
 <20261126193423.2344f609@kemnade.info>
In-Reply-To: <20261126193423.2344f609@kemnade.info>
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 7:34 PM CET, Andreas Kemnade wrote:
> On Thu, 26 Nov 2026 17:31:09 +0100
> "Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:
>
>> Hello Andreas,
>>
>> On Wed Nov 25, 2026 at 12:37 PM CET, Andreas Kemnade wrote:
>> > The bridge driver desserts reset after disable and asserts that
>> > upon enbale. That requires users to workaround that by declaring
>> > the reset gpio wrongfully active high.
>> >
>> > Fix polarity in the one device tree actually declaring
>> > a reset line. That patch has to go in after the bridge fix.
>> >
>> > The issue came to sight during experiments with reset lines on the
>> > Epson Moverio BT-200. There are two of these chips with a shared reset
>> > line, so also prepare for future conversion to use a reset controller.
>> >
>> > To avoid having GPIO maintainers spammed with a bunch of patches for
>> > BT200 support, do that fix separately and now, so it can go in more
>> > fast-track way.
>> >
>> > The devicetree change is only compile tested and is more
>> > a cleanup, not an urgent fix.
>>
>> Can you test it and report back? I guess it just means applyint patch 2
>> without patch 1 and checking whether it works.
>>
> No, I cannot test that. What I can confirm is that BT200 reset with a sin=
gle
> chip works with GPIO_ACTIVE_HIGH without Patch 1, with Patch 1 it works w=
ith
> both GPIO_ACTIVE_LOW (which is the correct descrption of the hardware) an=
d HIGH.

Ah, after re-reading the details I think I got what you mean: your hardware
should work with patch 2 + the part of patch 1 changing tc358762.c (even
without the gpiolib-of.c changes), right?

So, well, nevermind.

> Patch 2 is based on the assumption that things are working in the state i=
t
> is in right now, and only corrects the description of the hardware.
> I expect to break things if it goes in without patch 1, so probably the
> best strategy. would be if patch 1 goes to v7.n, then patch 2 should
> go into v7.n+1.

OK. I can apply patch 1 next week.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
