Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAF606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tqn5FLtv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC7A10E08B;
	Wed, 25 Nov 2026 10:15:52 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136EB10E08B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:15:46 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so4557289f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795601744; x=1796206544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PFUuksXTO3TNxrTTYeNDfahMSpkP8c6YJRD7Cdnatmg=;
 b=tqn5FLtv0uhbTRW1kGGq3jcRZRIRRFIH2kK5iOpfJ61T9Vc9ot01Z0VARE1dRIeIyi
 6vW0w1LE8606HpXFj7SMqdd23ExEF7rEFfnvsHpIgpE+Eyh5ci0jLReMxlT9rCsGIGHw
 PApWhTJw/J9bqU+ZCpwn09fuk9EA6T84MXevrSC8fNTKmlHsCoQog771m2ivBTXeX5HK
 T72YWcXYJWXbxKPBSgCFlHypz93uy3gb70sAM+PoYmv/7P2cqJCpGP4Dj11NrIaE/3IC
 Q21tVATcujs/ndFWitBZjgeIGvT8EQkC4x3dR5WgEHZ9j+NFmw9c460hzDXeM/5RAx9d
 IM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795601744; x=1796206544;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PFUuksXTO3TNxrTTYeNDfahMSpkP8c6YJRD7Cdnatmg=;
 b=JGLXVgYaS4Y5fB/kBFSfa2AKYIOHNJS0fSW1Qfi9WyXyzBSbL/ws7fuweJ65TB4RJ9
 xqQSRiNo35aN5GXKHTw2qFCrPZFbE2E+HxmhQFsCf9ouvU7S1B9222fEm5Ch5xozcbEN
 JxUr4x0uKCw1yb3Mqecnm9Ed0OsaiMaCC0ZkRx3FLcAdz03APVWS4nteq6TB5oMC+75Q
 aZJuWiqgNbk/d5ncAc5aIuXu72gWQa3wu30OKErc0Pwjeo177qsaEw9BHB3TyBhCDPio
 g/Mop78cBp5Wv8BWBr/Ts4YpFrJV3wxpuxmOu5mN/yb9ZmdR3F1nPsRY3hu3kfPK5qhO
 yZnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMUim6PiDiZCcVoRzVctGtv0kFzM3uoJVbxtKJXnCt469uvbsQV92got/7Qx7YgpJtyS3UXlWbwAo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4UacHWzgpkxw/FXRfJK72GhsTnA3yS7xK20JyI/iZlPduj7Ed
 tmILTDj7nuS0+MfaTndxuyz7iz6aUORWcTyFH6FGN5zx3UVksRE2RkCF
X-Gm-Gg: AZFdTZe29yURqvvYCxXC+GESamujSFZVM1Px1OQSMb5XAvwvS71joJ2RM5vkfUlUAlj
 H/7xIuPU08GXSNnS92pW1w8iXV8Xy8Gzh6uTTJeOnXT1jjxTcdxbU/a+TF8YFeRPxRo/HfhbOZi
 Cj69zsgn9MLXhSE4GBJ8il1K0Uhz/9lKH5SPh62FUjXE+fok2fd2nzr/n1FLR3XUI9ZSlo18mwy
 v7mFPPbspieY4rlzaIZ6rr/JfWM8s8X29QjjIW/o0LwpoNpM/FUjbYVOdM1TtVpkTyrTWinX+ML
 WzWyJb+bl59/VlcvTpsVh/mKSBeHVJq7bAQBeiXb1MuJ7nDr5oMsW667TSMu4G7l0akcMYrVGnK
 g/A7d0xYlWFOmLqNhjkLwqpyn6VE5WZLlWujKVxkcM3p1jHAgPGchj5IiTZANMtSTYYK25jScPb
 cH10ewpypn55/jGjN6J9lBt2c+RqftlvZ8EYriPVlfmhrfygxnp4+ao36I38s5IqtDrWimPlNvz
 7ejxtzkB+qGI0uSAVpDQhdMMF2poV6l6CSwZlyvdZZuZwhi7vMv7psMV6A/2ip4rOq6iXQUep8w
 M28V3j6zff3kgPRC8sLZXzPaAuYvgLlFCE2Fd4rjn1G+8bTdwPMucmg=
X-Received: by 2002:adf:e012:0:10b0:48e:3697:708d with SMTP id
 ffacd0b85a97d-4abb0d51ab2mr23863330f8f.12.1795601743982; 
 Wed, 25 Nov 2026 02:15:43 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb41f4sm32236192f8f.7.2026.11.25.02.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:15:43 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
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
Date: Wed, 25 Nov 2026 11:15:41 +0100
Message-Id: <20261125101541.463585-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
> I felt that approach was a bit odd (and if I recall right, failed with
> my OLDI panel), and in my tidss version I just used the clock rate
> directly from the clk_get_rate() (see dispc_vp_readout_mode):

Thanks, good to know I'm not the only one it didn't work for. v2 does the
same: the functional clock rate divided by the LCDC divider, rounded to
the nearest kHz.

What I added is a 1% tolerance on the pixel clock in tilcdc's CRTC
compare hook. When tilcdc_crtc_set_clk() can't get the exact rate, the
clock read back after a commit differs from the mode by a few kHz: here,
asking for 16941 kHz gets 16940.69 kHz from the display PLL. Out of 20
pixel clocks between 16.9 and 45 MHz, four were off by up to 0.015% and
the exact comparison reported them as mismatches.

Since you know tilcdc: do you know why tilcdc_crtc_mode_fixup() flips the
HSYNC polarity? Its comment says the LCDC aligns VS on the second edge of
HS, but I couldn't find that in the AM335x TRM, where IHS directly sets
the polarity of the HSYNC pin. As it is, a panel needing an active low
HSYNC has to leave hsync-active out of its DT timings.

Thanks,
Màxim
