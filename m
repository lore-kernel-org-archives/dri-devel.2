Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159E0C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D3C10E045;
	Mon,  3 Aug 2026 15:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcFVzeYY";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC77210E702
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:25:57 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47df6a5655aso447291f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785770756; x=1786375556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LoyqYzYJ0Nb5xInecrCvJNeUVfm0JCLfhe5/5aWpTE=;
 b=JcFVzeYYMezuM1/WVlh0hs57+HiFxsWB6mLR3X/08fk63m3DanXNmAwBOpjeeaNkvG
 LCookTF874h84LMmHXLx7glwzG2WEZEM/x37wpoJ9Vl/IEJjTJ89fjgWXOJ/8cD/33fj
 tD18P4Dlz0A03A0XBPDXloaDxqItN1H72IhpUbmzRptDC5o9U2xzJv+Qw6ZNt2ft69dV
 1WYbX+CBLuVqBt1CIFtp7skALtWUC9X2DOYKdsl25u5rFQFYxIjvVDXN5JjCkqblOMLA
 3ueIB6R4jf7c9lkF7m7nAvZTMX6CVEx9UdEhjcQTWHEWBjeVXdXPNidcbkbhpe2mo62y
 Tgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785770756; x=1786375556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9LoyqYzYJ0Nb5xInecrCvJNeUVfm0JCLfhe5/5aWpTE=;
 b=JuqaIZrq9f3amhlp9KOiAJeheI9BXve8ObP+K5vwa3qLeo7R9Op2zzEe1G7AXfxUtk
 i7b6R5jXrP9I8AsOM1ezbujyF63yLBD1hKs+ouMF538++zepy3Z5wY4k0ZHOO/9zUaLL
 +5B9cf9vAAUyQfIrsj84dOElBC50OCoffGoKPqYkEUTm0G4pEwCVCuUjMbQwfIqqiVrX
 cq5sbfXQo1rpvluZKgz00qyNOWihBQJ1USjqYiWCcZwCKu98U5Uyoo8KXBHhii6OA+zQ
 rzWlArQ+cl2FVPi+MLMFoBERDxnqH07xrazfXxXlGA1JWa9HwL5rJhAQGxoVdyxW6Bt2
 5cAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpST8CszqQR3UKeOM/KRwLdUw5Lt1ozG7keqgJKkYymkosQYyN2ZfL3ITmUu4zhpI68yVmLMo1HToQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS2PqTxhhi+XjJp8zkqPt7QpHVskUZd5GU7qYviB2wjd0Dusjw
 jgVyl7ekZOWgY9YXam2eFx1m8Chc3gDg9Tepi4p6oisJk/OMckywz2y0
X-Gm-Gg: AR+sD125uTGP5F4fvteksXy1tvve23KRRmJGU9dXZvgFzNL6s+EoA7WSaHzdUaJtOXZ
 NC80ufnTZn/PBkLWy5txmh4gbECyRAcVk2qqvygNnd5BeHPF9XEu3Kut2YeLVlkojE7J2TRAvYt
 Y/OX9NzwKgEixAOhaJFyyJ/tn2hZxHedqOhVyadHEiIvpSU+yGuR12FVtDqZTyhGUVCTuQoHVCj
 rcJ7Jfby0UefbbO5P/hh24M4HGLGW0H+JTGc8itkUXy0FzPdJUko3fRBuCs9RS25ELt9Nl8i5UO
 YSPjotwS2Zm6bhXSIRRJUnHhxgBe4ZMhRJYu7xOglDkkleWeLoYu6F7GcITYDEwNSycgDbLJzYr
 sGn3Mb2Q4hKZ6nmDaDzQdlWBrJ11FRDJeFpdAVgKwLuIMo7mU0r6LHpoJBmtVwG4DaPkPGJT1xv
 ucWyKOdzTplJ+X93QvtWTMH06dewbLNKiqL6JuKRrUamH1zy1FY/CWF6hoUfLHQBWE2oW770q34
 0HbMjtZ/GGq7ke6FFLxYpGY8n+zBZwr5kXhL/MWK9EoroUhuCTsHTCz2Nw401QrGFFjGZVcCGi/
 8yg=
X-Received: by 2002:adf:e197:0:b0:47f:6c7e:b32d with SMTP id
 ffacd0b85a97d-47fd72a0d89mr15322739f8f.1.1785770756108; 
 Mon, 03 Aug 2026 08:25:56 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B85F300A5CC0DBDABDC4661.dsl.pool.telekom.hu.
 [2001:4c4e:1b85:f300:a5cc:dbd:abdc:4661])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2abbsm34461507f8f.9.2026.08.03.08.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:25:55 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: nlucasgit@gmail.com
Cc: Igor Paunovic <royalnet026@gmail.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, joshua@froggi.es, mwen@igalia.com,
 leorize+oss@disroot.org, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: fix BT.2020 YCbCr output CSC
 matrices for DCE
Date: Mon,  3 Aug 2026 17:25:33 +0200
Message-ID: <20260803152533.9008-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
References: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Nathan,

I hit exactly this on a DCE 11.2 part, so here is a data point for the
path you could not test.

Setup: XFX RX 580 8GB (Polaris10, DCE 11.2) as an external GPU on an
Orange Pi 5 Plus (RK3588, arm64) over PCIe Gen3 x4, driving a Sony 65"
HDR10 TV at 3840x2160@60 with HDR enabled under KWin/Wayland. The sink
lists 3840x2160@60 only in its YCbCr 4:2:0 video data block and caps
TMDS at 300 MHz, so the stream comes out as PIXEL_ENCODING_YCBCR420
(confirmed in hardware: FMT_CONTROL = 0x002a0000, FMT_PIXEL_ENCODING = 2),
and with the compositor setting Colorspace=BT2020_RGB the output color
space ends up COLOR_SPACE_2020_YCBCR_LIMITED.

My tree predates 51e6668ab4ba, so global_color_matrix[] had no BT.2020
row at all. That is worth recording as its own failure mode: with no
matching entry, dce110_opp_set_csc_default() programs no matrix and
configure_graphics_mode() leaves OUTPUT_CSC_GRPH_MODE at 0, so the
output CSC stays bypassed and plain RGB is fed to the 4:2:0 formatter
while the AVI infoframe declares YCbCr 4:2:0 with BT.2020 colorimetry.
The sink then applies a BT.2020 YCbCr to RGB matrix to RGB data: luma
lands on green, Cb/Cr sit near mid scale, and the picture is washed out
with a heavy green cast. SDR on the same link was fine, since it stays
on the BT.709 entry.

Applying 51e6668ab4ba plus this series on top of 7.0 fixes it: colors
are correct on that TV in HDR, across a reboot, with no amdgpu errors in
the log. As a cross-check, the same desktop on a second monitor driven
by a completely different pipeline (the SoC's own display controller)
now matches it.

I also booted 51e6668ab4ba without this series on the same setup and
could not tell the two apart by eye. That is not a counter-argument to
the fix, just a note on sensitivity: the compositor maps SDR content to
around 350 nits, so nothing gets near the top of the PQ range where the
full-range luma scaling would clip, and the residual difference stays
below what this TV's processing reveals.

Tested-by: Igor Paunovic <royalnet026@gmail.com>

Thanks,
Igor
