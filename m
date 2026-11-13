Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC2606A336
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ30UlO6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FAC11276E;
	Fri, 13 Nov 2026 19:06:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC0111276E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 19:06:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 605314149C;
 Fri, 13 Nov 2026 19:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51F1F000C4;
 Fri, 13 Nov 2026 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794596773;
 bh=cL8S/XqxcRvYdatGqNCRqCS1nB5EOhT90pF+3yj6n8I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jQ30UlO6deD0sM8Ipvji+bfs6IOnwdbfvWVbGqkrnOCID5EjlBCEHkCef2wm3rtiv
 BORlIW690dLvWNYzzpaxS+tGFV/W+yGtfDZLYY8syXThsvlc62Ib+zP4rVWqKmSETl
 F5ZQVPw+ImyJAZS3bD6wIDIj7Ell9Ry3G0WeGCIKwvyG58TWsgGVY4JvPnQdio5Crh
 r/wxnGbIJyoHHtYN8rJcOnlgdLqtCn70OUalFXuvBjkE/aW1sbnq2tlqKj0oSv3ow/
 3mL6T8XrcpSboGtxK8/UT3Oi8k7pgmtyb49sER4xOee+XZeiVLTABHkwHQQoQfkzMh
 A//XszwPrFLdw==
Date: Fri, 13 Nov 2026 19:06:08 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Message-ID: <20261113190608.GK6323@joneslee-macbookpro.roam.internal>
References: <20261101142435.130520-1-clamor95@gmail.com>
 <179370032880.793788.4424159880220279586@kernel.org>
 <CAPVz0n1E2bLOzKEC6_2iiPM5ZZ6-NOXuOkwx+jQYn8BRvPXwSw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1E2bLOzKEC6_2iiPM5ZZ6-NOXuOkwx+jQYn8BRvPXwSw@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026, Svyatoslav Ryhel wrote:

> пт, 13 лист. 2026 р. о 16:53 Lee Jones <lee@kernel.org> пише:
> >
> > Drop the 'video: ' part of the subject line.
> >
> > Please review, explain or fix the Sashiko review(s).
> >
> > > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > > defined in the device tree.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > > ---
> > > This was part of the original LM3533 controller DT/OF conversion patchset,
> > > but it appears to have been accidentally separated during the final iteration.
> > > Therefore, I am sending it as a follow-up.
> > > ---
> > >  drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
> > >  drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++

[...]

> > > +     if (bl->num_leds) {
> > > +             for (int i = 0; i < bl->num_leds; i++) {
> > > +                     if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
> > > +                             continue;
> > > +
> > > +                     output_cfg_val |= ctrlbank << bl->led_strings[i];
> > > +                     output_cfg_mask |= BIT(bl->led_strings[i]);
> > > +             }
> >
> > This for loop doesn't need to be in the if statement.
> >
> 
> It is in if statement because if node has no "led-sources"
> LM3533_REG_OUTPUT_CONF1 should not be touched and must be left in its
> default state.

But it won't iterate if (!bl->num_leds), so it's being indented for no
reason.

-- 
Lee Jones
