Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A06070A89
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyKZ+5Pq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5A110F658;
	Tue,  3 Nov 2026 14:58:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C3810E0DB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:58:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26135600D1;
 Tue,  3 Nov 2026 14:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7701F000C1;
 Tue,  3 Nov 2026 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793717923;
 bh=nTUozzCyh+pEWeTB0Eeq+kV2EjmkicqTp4fHiliIMdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SyKZ+5Pq0K6VAtbMhCIWRWD1raf64pFT1Qxgeysf2Gg9T6CoRkWJbK3dt1APo6UGb
 Y5pvlb9fGUZ/bl3qg0opZi/iyhu4CqqD8cck4G0dy3/V5YDAG+h3N+TkeTA/Wgj3pP
 b0eGW3dNFvsLky1aa9t/KYVhxBP4v5Qe5vpZ2KxakwzXIuSVcWTYkFhYoVT5QcFT0A
 VjJeobyw2wnDET8K+9p6sfD8AoexzjO6pM1LJRG7GpHwtgOOzVHlkMxwfaz+km/i9d
 5Bs4PNRZujCeRKcIk7cxiuPfIZVebc9eYx2l3SdVhLvfFZKHcXaiQHXOXIcZCHrN9u
 +2eP93vKiDPOA==
Date: Tue, 3 Nov 2026 14:58:38 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: add ktd3137 support
Message-ID: <aun2nniPnWaC36UY@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com>
 <aunskqwg_CbpBL49@aspen.lan>
 <1IItRacxO3yGApfxlr9c4eyKqir8AGxFAmGYXWKDS_spX5pByW6JP0hxMqthOs7_8j0cOzthZYeTyu2wA1LAwNWDqsw0B_E-WExI1IjjmRM=@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1IItRacxO3yGApfxlr9c4eyKqir8AGxFAmGYXWKDS_spX5pByW6JP0hxMqthOs7_8j0cOzthZYeTyu2wA1LAwNWDqsw0B_E-WExI1IjjmRM=@protonmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:45:52PM +0000, Roman Vivchar wrote:
> On Tuesday, November 3rd, 2026 at 4:15 PM, Daniel Thompson <danielt@kernel.org> wrote:
> > On Mon, Nov 02, 2026 at 09:58:49PM +0200, Roman Vivchar via B4 Relay wrote:
> > > +static void ktd3137_remove(struct i2c_client *client)
> > > +{
> > > +	struct backlight_device *backlight_dev = i2c_get_clientdata(client);
> > > +	struct ktd3137 *ktd = bl_get_data(backlight_dev);
> > > +
> > > +	backlight_dev->props.brightness = 0;
> > > +	backlight_update_status(backlight_dev);
> > > +
> > > +	gpiod_set_value_cansleep(ktd->enable_gpio, 0);
> >
> > Is this needed?
>
> The datasheet says "When HWEN is set high, ... if SCL/SDA’s pull up voltage
> is much less than VIN voltage, it can cause a small leakage current ...,
> there will be around 7uA additional leakage current from VIN in this standby
> mode."
>
> It's better to put chip into shutdown mode, which won't cause power leakage
> according to the datasheet, and ensures that I2C registers will be reset in
> case chip needs to be cleanly re-initialized.

Right but this is the remove path which as about to free the gpiod anyway
(allowing the GPIO driver to do whatever it likes and which will often
be HiZ rather than pull-down).


Daniel.
