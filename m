Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82A606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mqamvBqA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC9A10E2E3;
	Wed, 25 Nov 2026 13:32:10 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96EC10E8D1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:31:54 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c511cdd5a82so687320066b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795613513; x=1796218313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kUd8mtuTeF2l1knNzHoNf1IiFpWulU/A3oJSHuGeAWQ=;
 b=mqamvBqACPtRT/V9FMdsdNP6Iis2nhKeKlbdcJhVPfCwk7pdH01jfOhZQH5NDvW5Hg
 Ebor5JXyiNfgwDdP+f7NoG49wbisouk+1tzGaJD6Y5YkTYtBVLedPGL9k5ho0kEKm1Kv
 ByfkooDGAf7F6NHBVaJ2+0JZhMH3NyAKRnrctiQQ8i9Br3NEhWQkS7o65fv3NOf+XW71
 9Kx4YDGr9Xr/4P5hNKI/0sqQVoSPigM/qIWzZQEdeYp2y8wQPygkzGv4+fd8JU+Q9KNW
 ndJ4f9lRbW/DeXEIiX8zGx+tpDUFJ5bH5y1iAlIr96tFEVhs7uG9y840fdwj8Hnj42wV
 Q4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795613513; x=1796218313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kUd8mtuTeF2l1knNzHoNf1IiFpWulU/A3oJSHuGeAWQ=;
 b=J4AWbSs8g43duUlBkyEOHXWIGV+Rn38QAZWpCFGHT9C9Au7OY0IU+FjRSIPpXFLhGQ
 z202Z+LSB58w8VEjcqOmYRXcr/LK3hiaJSHsNk8TKxRzZErktEbp/6wP+1vl77E0G5Bd
 fxEuaBBdqPNjn3ZP5Vvr2DOE5oq1QeFXvoon945rB7ddTnvZr3gIzXvQUvMVnBBJuqpb
 m2MnTAsOQ121oOU9u1t/wAi05dzraQKPQxhlAQsNgQoJyu/OuucDqDgp/8p1ze7R9v4z
 1y9D3eV6J2d4l2ZOoH+48QOPROt9M0oQdI8Hu5KMDDy1BksILMWYreCTzslmHYl4bR/E
 yJzg==
X-Forwarded-Encrypted: i=1;
 AL+hErFbC1K/ihN1CnBj0y4Zz2rNLvORwtMoHPoPPiGe2q5EOhCMc7okulfgUplO5U4A179qXzCwdDmlCT8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rzChnWdIKAyuSHUCFTl29QDDvPtbM9tIN4B4m+mwO5Kk1MwPj
 vrARWK//2DSd2dKPwxtl8J2YdwhsClfJm1BX04J1CwW/Yh4rOU3ajXLf
X-Gm-Gg: AZFdTZdJdlMOSeeaDuwvOsE/cXMhVeDX5wnFNaBG94BefoXWXX61Eyi+xnKKnL6YWvo
 zDCgg9tlVZOOFD3f6lp996gu0MTu0KvAjoZnGty97mE+H8jBo6SC9TttilUD2/vRKkBX6uD/sgI
 TpFVbUhU8/Rzq0arx6Mf2OH2Ro4kpGvui2OJLi9e2JyMISOpIIF8e/Roy8nMvXp/Ux+/7MFz2je
 JGHzg2s99wlsMyRRe3aaHpvZ7eFscC4FVaV3XcRG896aipITLTWqEXib+LyWtiVPW6yjdMOBah7
 Mnc+IE+3uU5XWKnQ8p7XtubErHOiKSVdxmiQkBhE2cqPyQWK/HtzRWmGg4sJzCmBxjrlCnm9jO4
 VEvf+wqZi5Glckb6iIl8NDiELEpeAxuxcj2a36TMUIvJD5+2LWKq8fdF14mtGumaSnysJ9QtIBj
 xbMDmexpL4mfJBtfDHYf4ELP/jc+vw3Aubqx6x4ja1qP5KOWPkbMjCcByt+aqCf9Ln3uk/t/ohv
 8UQLRb+8pr665YvVFt8KrKoQ278I2YAKTpzj5nz7FG/IYXG6uqmE+XVFoiJZBPfMHgxZveqBUqa
 kuadRgVFHtpFG80w73zNKk6Lph0UZX7iVxWaLX6zARsOkA8gqR4r7FE=
X-Received: by 2002:a17:907:7fa1:b0:c45:c030:732a with SMTP id
 a640c23a62f3a-c513ac6169emr1443388666b.35.1795613512746; 
 Wed, 25 Nov 2026 05:31:52 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb42absm35814912f8f.1.2026.11.25.05.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:31:52 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
Date: Wed, 25 Nov 2026 14:31:49 +0100
Message-Id: <20261125133150.507558-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <awau4IF7KE7hUg6U@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com> <awau4IF7KE7hUg6U@houat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 11:07:17AM +0100, Maxime Ripard wrote:
> > The tidss approach rounds the clock to the closest standard refresh rate.
> > Panels driven by tilcdc often don't use one: with the timings from its
> > datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which would
> > be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
> > match the panel mode, even with U-Boot programming exactly the same one.
>
> This is *very* surprising. Do you have the datasheet available somewhere?

You were right to be surprised, I got it wrong, sorry. The datasheet
counts the sync pulse within the back porch: a line is 1056 clocks
(800 + 46 + 210) and a frame 525 lines (480 + 23 + 22), so 60.06 Hz at
33.3 MHz. The board DT added the sync lengths on top of the porches,
hence the 56.8 Hz. The bootloader had the same mistake, and also ran the
panel at 16.94 MHz.

With the timings fixed, and the bootloader programming the same mode as
the kernel, the readout adopts exactly the DT mode (33300 kHz, 60 Hz),
and the first commit from userspace with that mode doesn't need a
modeset at all.

> > So the readout keeps the actual rate (rounded to the nearest kHz), and
> > tilcdc's CRTC compare hook accepts a 1% difference on the pixel clock
> > before calling drm_atomic_helper_crtc_compare_state(). [...]
>
> Yes, that's why we need the above mentionned helper, and more generally
> why a lot of drivers allow some deviation from the clock.

If it helps, I can write that helper: dispc_find_closest_refresh_rate_from_clk()
turned into a DRM helper, with the tolerance as a parameter since drivers
want different ones (5% for tidss, 0.5% for most). Something like:

	int drm_mode_set_clock_from_rate(struct drm_display_mode *mode,
					 unsigned long rate,
					 unsigned int tolerance);

with the tolerance in per mille, so 0.5% can be expressed. It would fill
mode->clock with the ideal clock of the closest standard refresh rate, or
return an error if none is close enough. tidss would then use it, and so
would tilcdc instead of its own compare hook. I'm also fine with you
folding it into your series if you'd rather do it yourself, just let me
know.

> > Testing on v9 also found a bug in my readout: re-enabling the CRTC
> > (ACTIVE=0 then 1) with the adopted framebuffer crashed in set_scanout(),
> > since it has no GEM object. It now keeps the DMA address the bootloader
> > programmed.
>
> It should be fixed in v10, I'm now creating a gem object.

Great, I'll drop it when rebasing on v10.

Thanks,
Màxim
