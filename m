Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BC606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smOYP2bx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697D310F648;
	Tue, 24 Nov 2026 14:11:29 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019B710F64F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:11:23 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so44139525e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529482; x=1796134282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iCvyfFUl0IzhjF6ZOx8Uvl3XeIM4nkq47bTo1+RuUoc=;
 b=smOYP2bxwedq4yfUG5ZEn2eAs6GLXQenB0ulpYfSd5JoNxtfelfB5fGwDxxtt4WG5z
 wQdMETvdFnPaN6wUpbMJ3MemRlvlhS8+9aDJb4GqWF0Zzd28gzJ0/3xdQA/pjI7nlHvF
 vVfqzWD0updaoL5H6uz7J6XdrltgrjsTxot4vhJrB31LZxLW504jFVgxFT/6jfOO7nvj
 pE44eI20oxSeXpOaFiE5DyZMGhnhlzxa1sEWQKgsoX5nrhfasMNcncSY0/sQtn3seW9r
 xgEbh7eJ/BddzayVRKtGMx6uVnfQ8tQdhzultROh2cR+Hlr9dBbv/6+z+nd+9AvzXpSN
 PSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529482; x=1796134282;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iCvyfFUl0IzhjF6ZOx8Uvl3XeIM4nkq47bTo1+RuUoc=;
 b=yrLqV7ilB4oVMzDt1zQLB/G4Qy94cv7IWH7FEikHdjmWpxTSb4WjO2HspJflkq19HN
 CYkHMV0IT/SqJsjjB/yEBfEl5KE5YrPLPKApylRAuCCP/KjsbFChnMKcjr8ecnCv1Q1Y
 l+sFSxjxUID9hYz1ZkKiS4YrgRzMeTukgGRTjKFoq1cHCkOl94alNuqlq2CG9KUTztk3
 95g1ZbT3lvvepbtduXh6mtBfxxoQyYVof+32WfsQ5O92crKD2uai2xbhREfxK8Qu+IJD
 IfLAv8h9RK/nK9IOl16lK2E4bHkOIju6wUQjpV6ZYaQygjCeRcFGUtTc4Z+hxeJlVMC/
 KOTA==
X-Forwarded-Encrypted: i=1;
 AL+hErGlbE+wSgumQ11pXq7lZLcHDo2hxJTN8e6zXct6wnNe5ilmGUjnpW3O+so+hc4y8ePpt1a8x22Xbzw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/9MCWhsHfEs0CJmDHRUgHhiBOcOWk01SwYaeQQhgyu3SFCgXrE
 k8p8wsz8dyfjsjdoJ+Sybolf+5SOMxyPGBGVZQEjlCWY93zoydRHE9m8
X-Gm-Gg: AZFdTZcEUh3LawshJr+zAOrg5NVQA2/3WyT+SRD4Feo18giUM27vmnQpzfH0hHiJMLL
 4EoKBBnpKwjId45fRrGSDSDcq0A1yenLnIKGHe0PvzM673D0ozqgR3gxM0EIDJK+qhbKkUex0hj
 z8C6dRIBhKV3fxwivP0ZZDs35pEc9J8Tksp+iqBzVlv+ee0BH5qzYXL41bVHvWxPMjuoz6HPwpg
 +WSheEo/HatQnnO0fTTH8065tCTubFrrw0NszYf2NaluA24RrEOpPd2rPc++yTiCrapwhpIrMyG
 sNgb1E2ZIGt4+zy9MYaQ/hKydkOxf78cZLCteUBDqZCIrSHTP5sBnQtHfISK7c4a60P5YNDMVHd
 HO6PksYwoVfKYVOpfSrAD43jjoW8rR19ykgTmzWhcqfcKkMY9x7BU24ndksIopJcdwqnkA6W9cG
 GZUWtFhDzvJU6ByQQTL8Jpte42vvidZRRatC7s1P830L2tsr07RktqbMTTAYXLz31SRA1IoxSba
 7HMnc/7sjwsN7/Qeeea9FhSTZUZG7X1nn/5ESFIrCBF5zUl2S9up2iQHxfTdxYTkrVjLg/XF5Fx
 NvxtZLONMTr45w3WEmUnkmCqLGJYtPZRV1GWiQKxerFH4A51dT0ngCI=
X-Received: by 2002:a05:600c:64c7:b0:4bb:68b9:f610 with SMTP id
 5b1f17b1804b1-4bb887ffee2mr287311235e9.9.1795529482013; 
 Tue, 24 Nov 2026 06:11:22 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm27952654f8f.38.2026.11.24.06.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:11:21 -0800 (PST)
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
Date: Tue, 24 Nov 2026 15:11:19 +0100
Message-Id: <20261124141119.441163-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118212114.150992-1-maximpedraza@gmail.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
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

On Wed, Nov 18, 2026 at 10:21:14PM +0100, Màxim Pedraza Padilla wrote:
> Makes sense, I'll use the same approach in tilcdc, and see if it can be
> turned into a common helper along the way.

A follow-up on this one, now that I've rebased on v9. I ended up doing
it differently, so I'd rather explain why before sending the next
version.

The tidss approach rounds the clock to the closest standard refresh rate.
Panels driven by tilcdc often don't use one: with the timings from its
datasheet, the panel on this board runs at 56.8 Hz (33.3 MHz), which would
be read back as 60 Hz and 35.19 MHz. The adopted mode would then never
match the panel mode, even with U-Boot programming exactly the same one.

So the readout keeps the actual rate (rounded to the nearest kHz), and
tilcdc's CRTC compare hook accepts a 1% difference on the pixel clock
before calling drm_atomic_helper_crtc_compare_state(). That's what the
leeway is needed for: tilcdc_crtc_set_clk() only gets as close as the
clock tree allows. I checked it with modesets at 20 pixel clocks between
16.9 and 45 MHz: the PLL misses some of them by up to 0.015%, which the
exact comparison reported as mismatches, and they all pass now.

Testing on v9 also found a bug in my readout: re-enabling the CRTC
(ACTIVE=0 then 1) with the adopted framebuffer crashed in set_scanout(),
since it has no GEM object. It now keeps the DMA address the bootloader
programmed.

The rest of the comments are addressed as discussed: the format follows
blue-and-red-wiring, the panel describes its polarity in the DT, and the
initial state comes from your no-more-config-reset patch. With v9 all the
comparison warnings I reported are gone.

I'll send the next version on top of v9 and that patch.

Thanks,
Màxim
