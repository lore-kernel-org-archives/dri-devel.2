Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F220606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=a-marquet.fr header.i=@a-marquet.fr header.a=rsa-sha256 header.s=gm1 header.b=fHNPpS6/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F20D10E873;
	Fri, 30 Oct 2026 09:13:04 +0000 (UTC)
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716A910E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:18:53 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 by mslow3.mail.gandi.net (Postfix) with ESMTP id 9A1EE58106A
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:55:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7616D3E80D;
 Thu, 29 Oct 2026 20:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a-marquet.fr;
 s=gm1; t=1793307337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCeY9APsxfmvH+XIUoqxjY0kS3crPoTx7BAYNg4i0WY=;
 b=fHNPpS6/zRSIqBqW0irfQrba/Am6sjIe0bCyOZ9wSRemRCscDo88TA3tfrFBbE3GiwLt7Y
 3N2SPdppcp308rVqUai92uPlqYhZ2+K7xx2g3fU2BJBc0gu678ikHavLC1XVPHyuhgefGe
 bO4hpOZI0hRgDI8/Y3PMkNZbc9EJre/iDTusQ4JjL5D0Qp5MoX8xAEGKoN57kHc73WreZF
 yOKACCtkSVpBV93+2aE7HCiA9B8Z6xFbDEDmKBkyUDlByz+4RlGKVCu3ew6Lw0l3QWDkAb
 vsPhIrkW4Z/XKdY0nYZfv4nqknWlG9Uj0F0HoWNoRRQb7/3emhfS8AzB7w5VMg==
Date: Thu, 29 Oct 2026 21:55:32 +0100
From: Alexandre Marquet <tb@a-marquet.fr>
To: Doug Anderson <dianders@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 Lukas Timmermann <linux@timmermann.space>,
 Henrik Grimler <henrik@grimler.se>, Hendrik Noack <hendrik-noack@gmx.de>
Subject: Re: [PATCH 3/3] drm/panel_edp: Add SEC LTL101DL02-002 panel
Message-ID: <auOyxKTuSNysAA3X@laptop-218>
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-3-3a45c3cf531d@a-marquet.fr>
 <CAD=FV=XmfYM8diBOh3UidN7xEuB3n+n9oAm_zhopfFLERC2QpQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XmfYM8diBOh3UidN7xEuB3n+n9oAm_zhopfFLERC2QpQ@mail.gmail.com>
X-GND-Sasl: tb@a-marquet.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGxku9aeGpo+7YMc4F4PvFpGsua428LZyVCxiu3ZWgW8HsKPegYmks3ajh0iP00ZRx4hi8T0K5ZaS2j9uikJ2QuMOT4yOHAarDYQ/vvPPSXaxQ9YiezR0t+7oZ4eh+B2zE3r6eUVUGyZ4uHSUMJMLGkL5aA4rnWYnOn1rXAzjdxtLJYHY2/1ABQODzEWZ8Hsc7aJohKnNtreJrq+OmZqVnNI8IRujZJfkJEWTPHT+wHz4/6JwmKHothvuxNPxfv+OzFjhdGR/x3mRLNO8Us1THXppONAs77llR98XJUNrwxrIX1oHy352yibAosFmCGLOfypPxGom41RVBtm+fdli5ujOvJQavDP2e89f6vc94LNpZV9nkW3fVkbnwbgEuHhI/I/HU2RCRXG9Tv398eMl8ZjQFZwyZjflbVReLRZktwQMzPf5y7ZVduqvKlncYQl+nTgz8yq3LfzYyl9/mwIXjhlTSJaK/7j3/iF1GiEFXV5di1y4SOk54XmIQS5AQQnYu1pDadCFAw820n9VCVyOsPIKS8p+rEdIJKtBNAd0twExBKmSKGj2sR9yv/YyvIllvM4E3dZcEP6Gavj7CtndjrBC2LM5kvfWOYkw5l09gJrhEnRg0K1g73dxTDZpW/An+kRuYkG3K/LN9NJDjxtOIjVmlmLbaQsmwOPwGeEBb35w
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thank you for your feedback.

Le Wed, Oct 28, 2026 at 09:34:15AM -0700, Doug Anderson a écrit :
> Hi,
> 
> On Tue, Oct 27, 2026 at 5:01 AM Alexandre Marquet via B4 Relay
> <devnull+tb.a-marquet.fr@kernel.org> wrote:
> >
> > From: Alexandre Marquet <tb@a-marquet.fr>
> >
> > Add an entry for the eDP SEC LTL101DL02-002 panel used in
> > google-manta.
> >
> > Raw EDID dump:
> >
> > 00 ff ff ff ff ff ff 00 4c a3 0f 9c 00 00 00 00
> > 05 0e 01 03 80 21 19 78 0a 87 fe 98 57 51 8c 27
> > 21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 14 69 00 a0 a0 40 2e 60 30 20
> > 36 00 1e d6 10 00 00 19 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9e
> >
> > Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> nit: subject doesn't quite fit the pattern of recent commits (_ vs -).

Apologies for not noticing. I will fix that in v2.

> 
> 
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 94bc54c3833a..c92985363093 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -2198,6 +2198,8 @@ static const struct edp_panel_entry edp_panels[] = {
> >         EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
> >         EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d200, "LP116WHA-SPB1"),
> >
> > +       EDP_PANEL_ENTRY('S', 'E', 'C', 0x9c0f, &delay_200_500_e50, "LTL101DL02-002"),
> > +
> 
> It would also be good to note in the commit message where you got the
> timings from. Datasheet? Downstream code? Guessing?

Both downstream code and guessing, as I could not get my hand on a
datasheet. I will add an explanation to the commit description.

Basically, the downstream code waits: at least 500ms before toggling the LCD_EN
GPIO for power on; and 200ms after. I matched the 200ms to the hpd_absent
delay, since in panel-edp.c, hpd_absent is also the delay that happens
right after enabling the LCD regulator (or toggling the enable GPIO, as
appropriate). Similarly, the unprepare delay is called just before
enabling the LCD regulator, through panel_edp_wait(), which matches the
way the 500ms delay is used in the downstream code.

For the enable delay, I went with the smallest value that would still
work, but I admit that I did not try anything below 50ms.

> 
> I had my AI agent take a look for itself. It found evidence suggesting
> the enable delay should be 97ms, not 50ms. The other ones seem to be
> OK.

In the downstream code, 97ms is the delay used before setting the
backlight on. My understanding is that this should be used elsewhere
(e.g.: in the backlight node of the device's DTS).

> 
> -Doug
Best regards,
Alex.
