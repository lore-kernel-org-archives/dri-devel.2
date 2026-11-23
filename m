Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F1606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xj7flpRp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CB910EC77;
	Mon, 23 Nov 2026 10:55:43 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C6610EC77
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:55:37 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so2160510f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795431335; x=1796036135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T3sb7Ptp8raMgEjUcbiNjen+AWYmPSXzPSHe2BRivVk=;
 b=xj7flpRpCsevX8FOdGUeOaOtwXtrRtyRTALP74Oc46TbM7Pstztm1GLJJV8QSu4pgr
 qCbCQJIWhFTN4f5PhRPSV6hdmcP8iBQdtCarxhRR96wGWm08g7ElaP7uW8t+oHFQAT2i
 OJ25Tuui0BtYFPHYYgt27Uc6HzWoFj8HJ90DavgMuU0gQpsKmBAhBSWtcXPjtMoCd1Y0
 yJHhBEWfK3IqXsKK2BH1qvzgmzMifLqXjVO/tPcoSjwlDYELknzb1Gtu0KgTcOkjJLOm
 KBKfFP08pzRn0eWveiptk4zxp5RzWPzdg8FV57n7EZtoXogaYMHr7L/N81BQBSY+X2hT
 qQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795431335; x=1796036135;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T3sb7Ptp8raMgEjUcbiNjen+AWYmPSXzPSHe2BRivVk=;
 b=wSy4U6twHgTI71GFl4bK44kwqZZOfa6+3TumkmxeHdpwbp6qMV7w6wwX4QnH9r9Yb5
 kVyEz1f7kWkx/eyqnanU6Xjs/owE5LpNOgY2k1K6C7V9m4B+KpeYz1az90I8Cx23mSrC
 TN1OU7EzC2pzAtXsOokpUvPvuEx6kYsLxJgSQTWmSuyS6JUqfd2DrcIwqfaaXHEIcVxc
 Cjf1Hxnv5/iRDJWlWVXScR/oJcg5H9U5dNONkjRHJvU0QnHF1IiMrSV/QcoJEN1z5pcq
 aVubilIv8NErIU3gwqtB2vJCS51zmoHfhgtb0XEYDu0vUNSVDiKiEiHCvcQ38oqzHUeJ
 QQwA==
X-Forwarded-Encrypted: i=1;
 AL+hErEZ4tl03DojEqV6D8ODRXr0WX3Dj6SwAHEr7YbPwFw4uNGlKurLutmnyjcyOBKryHeFYJEUcJniX2c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/L+AHTmgQwAY2ypSYYGZwdV/2HeBD12fAJLu4k5COXjLnD+dbu
 MSQMbMuHJcQwdCeQYsqkTFlWMQWHcMZ2+8k6FPcclcro8hGAvlp2ddGo
X-Gm-Gg: AZFdTZeG/Gbb/38hqE4MyFqJFu1+Ohh9LqV/INdajPuskTKsKT/wY/km7j+8zRVvJ6s
 NBb6DXSRAZYnrMd7wZ99F2hxASG8zEzNeNBi6Vk8RimveSVjBUEfIiScSnZ07RZ2U+6pINprUFn
 n/DxZUO1q5BpQ3EOabKTGgSPDDYI9iJkEUInwoV2AHxdCEEvwC+RqV0mE7eg8gC464w0cwRjGK+
 swy0xnDEssOy4DZAJO8PvlRjrvFR9aPfhicVYiMJCQ9XF8g30IB3CpJvZEbb4mYijkgnZ2/BoOb
 86dfTP2Gzco2bFpBPtCewWP79wyJAOV/oWGgHHTT7chtQKfBnlP3mHZTntCoxgUfGknIgN8EhEo
 4CtnkaRYL95/Fpxva21SxCin3qDWNovZapKdLd10Jw+gAeGJYG4mJQEElHOGiKs6VJUAk2oPdrb
 3v5S2LdUADlqQ0j0cg1ZiMbSO1E2HVybcLLRMlSz75KFFoNoPn9cBaPDdDqp6A5R0egARBTS4E3
 kzIECHQv1+ogOJ8lve7JVP83EIRmJs2tVu9xFBDFb6ZvLRl7DLsOdtg+7idzTFdw6wzZYr+7Giz
 EwKN5Tsv3xx7znyRdOC7+3FSzlzDbJ8hxyc10z/08lY+xXLmrvg3it6z
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id
 ffacd0b85a97d-4aa545e244fmr32329698f8f.7.1795431335383; 
 Mon, 23 Nov 2026 02:55:35 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c248b75sm21977304f8f.54.2026.11.23.02.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:55:34 -0800 (PST)
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
Date: Mon, 23 Nov 2026 11:55:32 +0100
Message-Id: <20261123105532.21980-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <awBShK7cjwT5LTLg@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com> <awBShK7cjwT5LTLg@houat>
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

On Fri, Nov 20, 2026 at 03:01:50PM +0100, Maxime Ripard wrote:
> I think the real solution in this case is to fix the panel to report its
> polarity properly.

Agreed. The panel datasheet specifies negative HSYNC and VSYNC, and the
timings in this board's DT didn't say so. U-Boot programs both as active
low (IHS and IVS set in RASTER_TIMING_2).

Adding vsync-active = <0> works as expected. hsync-active = <0> doesn't,
though: tilcdc_crtc_mode_fixup() flips the HSYNC polarity of the adjusted
mode, so DRM_MODE_FLAG_NHSYNC ends up with IHS cleared, i.e. an active
high HSYNC pin according to the AM335x TRM (SPRUH73L, table 13-26). With
no HSYNC flag at all the pin is active low, matching both the panel and
U-Boot, and the readout matches the DT mode.

The fixup comment says the LCDC aligns VS on the second edge of HS, but I
couldn't find anything about it in the TRM. Do you know if it's still
needed? If it is, I guess the readout should keep undoing it; if not, a
fix there would let the DT describe the panel as it is.

Thanks,
Màxim
