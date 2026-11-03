Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA5606D80E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F2gOIRwQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F3710E7F4;
	Tue,  3 Nov 2026 17:21:14 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A0A10E7F4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:21:07 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so36355065e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793726466; x=1794331266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VdlowWmvfVZz+69VMJzw63b7hr3S2rAy0+a2cDKUzcU=;
 b=F2gOIRwQq/e1oF32TzcbDwCmxov5FcR7KGO/3p5UL8h9/fpI0yMpvKmlHnXHAkLyvu
 pIKGdraiFp2DR+1KNHGTfdStE1yJYajcoZJMGlsseG/wSk7HYn9XQDzMYIkivFUpY8Fm
 apV09D4t+mwckyuXqQZXBnOkAXS3N5WYzZ7+UEUy3L20EKDFXPFp3jxmo87BzifLnZ4M
 pxbWzMpWsEfh8xhX7Fd9miKUY+6yfB/mD1DKcjOBcihli5wn0YHTTUcFcp8QHeHJUxVI
 Wu20QcdHEaD8pSAWU9odpnYruK1Zvl4CpFvADMmD3xlTR7mqMOnFP6kW0q83UAuu3yrT
 BiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726466; x=1794331266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VdlowWmvfVZz+69VMJzw63b7hr3S2rAy0+a2cDKUzcU=;
 b=oj/KqgdpbXeKY5ARzxsBTzXXxyYwaXZUkv9BeXVrIPQMcykpkHLlYBzKugDcqqH1Ld
 ywxF+aBfRFd7wi65k6etcOsYxXLvHAllY1gzePY8Mf0onKXodE3+2K38DeQ3hT+nVSqT
 Q8O4jH5YJPztl3PWwwtHFbbUD6sW24coNbxPD7+W+WAjX0X1joKBzdVqK1vKVfYkjzaf
 gFpdwWEA3KdDkyLmHXWBGv5VMDs1CWSPEx4I4O74TcZcCjFXHIv9/dMVLnSSk3ujpRix
 viXcWW7qBTZWYTG9l+oLgT3IE0CGk0zV0NyHS690RRDBkFno9ZxZUTmfZp3CYkgMGk/H
 /4kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgCHcGZ8xLWYMldNZ+Y7T66IM28aYk15u0n9zhMnWaQe2tzIHSzP/UmKG9iIPfbFDfQOHtKw1L+ZU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+HpZCDl3HG9Hh88whC3JVc27fX1pYGGJKoPNhj9DVNRDj1yeOH
 ae44YQ935Obcm7n1rleGDymbn5CWv9HbZByNOJtfwTa1moiVTIg2/hfy
X-Gm-Gg: AYBFou3ZbRa+ZI8VeD8ljqY83jRx78mU6R8A8nCNRfH//rX3v0YvPOukwN5sV6fPowu
 O9Xr9igpkHoM5d2JYokcM0O1Xmj0FkSr1z4U5iSoUd9oLJBqXT4gD5OW+7M7lEMtwqyu7JVQdJS
 IhU+aqb8GPgalb/9XFDKGU8WFLKAGT2gmGkAGdD5lflQIrKrHWkVc7Wo4s/ydSd2AmCzSRHQa7x
 uHrB33neazYsrLy+zqsDuwAbpHZMdCGW5VO0vKCHKCqt2mF1vimfqBrTdFn5sJRVztdL8zojddb
 CdjhBB6JIrBPPtZtd+79xgSNDnnzYU+4bh8eucrjqTAXrnUsV+0L6rOURQjG1KaaEvPXAQu9UER
 ChC4hXWUMmEmHG1cwS7Po89oqg0C0aKU27/fJ6sCeb2Aw3rw1R8gR2w0htEZ/4EjI2RlZDWF8I1
 OseIHTB24g7hGNS9RpLN6cV0eu8/7KdXldBdV8iC8VX9zCvNRPUKNHuwK9l0Ixr2150toJFBplF
 qzkj0HU/1mVkY9MfhZFrBzNUoa49hkaKnwh+j5hUo5tXlcjX4Uo/fMN3D8f2P6r77Z9muhhXDX6
 L4WSJNo/lUKmKFnYeoqX4rcCsVE5v9y/dRziFkb0zP85A4hVAWh2bPZTFMPqHFv82uZSbWrgsd9
 TABSSnFLIlUlaVhogSKKQJYzdR+TmhxSxa3EecFE=
X-Received: by 2002:a05:600c:4704:b0:4a3:12fb:1ef1 with SMTP id
 5b1f17b1804b1-4ac18992a21mr287850375e9.29.1793726465631; 
 Tue, 03 Nov 2026 09:21:05 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:8b77:19e1:26f7:89f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72579sm8800675e9.2.2026.11.03.09.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:21:05 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] clk/drm: renesas: Improve RZ/V2H(P) MIPI DSI PLL
 parameter selection
Date: Tue,  3 Nov 2026 17:20:53 +0000
Message-ID: <20261103172057.617203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

On RZ/V2H(P) and RZ/V2N the DSI HS clock is derived from the pixel clock
produced by the CPG PLLDSI and its divider (HS clock = pixel clock *
bpp / lanes), and the PLL in the DSI block has to reproduce it to within
0.5 Hz. A display mode is usable only if a single set of CPG parameters
satisfies both the CPG and the DSI PLL constraints, but the two were
checked one after the other instead of together:

 - Mode validation took the CPG parameters with the smallest frequency
   error and only then checked the DSI PLL. A divider that lost on CPG
   error alone was never tried against the DSI PLL, so modes were
   rejected although another divider or PLL setting would have worked.
 - The PLLDSI divider's .determine_rate() runs its own search when the
   clock is set, so it can pick parameters other than the ones the DSI
   driver validated.

The first two patches add the clock-side support, the last two make the
DSI driver use it:

 1. Let the DSI driver cache the CPG divider parameters it validated,
    per PLLDSI instance, and have .determine_rate() reuse them when the
    requested rate matches.
 2. Add rzv2h_cpg_get_pll_pars_validate(), which offers each candidate
    to a callback and returns the first one it accepts.
    rzv2h_get_pll_pars() becomes a wrapper passing a NULL validator, so
    existing callers are unchanged.
 3. Evaluate every divider against the DSI PLL limits, keep the one with
    the smallest DSI PLL error and hand it to the CPG using the cache
    from patch 1.
 4. If no divider gives a usable pair, search again using patch 2 and
    take the first CPG candidate that is at most 50 Hz off at the PLLDSI
    output and gives a DSI HS clock error below 0.5 Hz. 50 Hz is at most
    2 ppm of the 25 MHz minimum PLLDSI output, so the pixel clock error
    stays negligible.

The cache in patch 1 is indexed by PLLDSI instance and shared by all CPG
instances, as the DSI driver only knows which instance it targets. If
there is a cleaner way to hand the parameters over to the CPG, I am
happy to rework it.

Testing
-------
"modetest -c" on [RZ/V2H EVK] (DSI -> ADV7535 -> HDMI, 4 lanes,
[monitor]) lists 27 modes instead of 21. No mode is lost, and these are
the newly usable ones:

  mode        refresh   pixel clock
  1920x1080   59.94 Hz  148352 kHz
  1280x720    59.94 Hz   74176 kHz
  720x480     60.00 Hz   27027 kHz
  640x480     60.00 Hz   25200 kHz
  640x480     59.94 Hz   25175 kHz
  720x400     70.08 Hz   28320 kHz

Dependencies
------------
Based on next-20261102 plus two patches from Tommaso that are not in
that tree:

  [1] clk: renesas: rzv2h: Forward PLLDSI mux rate requests to the parent
  [2] clk: renesas: rzv2h: Report the DSI duty cycle from the LVDS divider

[1] https://lore.kernel.org/all/20261029-tm-ssgrlpcsrc-2083-v5-clk-duty-fixes-v1-1-47f23de6bdb1@bp.renesas.com/
[2] https://lore.kernel.org/all/20261029-tm-ssgrlpcsrc-2083-v5-clk-duty-fixes-v1-2-47f23de6bdb1@bp.renesas.com/

Geert, Biju: I would suggest taking everything via renesas-clk
with an Ack from the DRM side, or providing an immutable branch with
patches 1-2 for the DRM tree. Please let me know which you prefer.

Cheers,
Prabhakar

Lad Prabhakar (4):
  clk: renesas: rzv2h-cpg: Allow MIPI DSI to reuse PLL divider
    parameters
  clk: renesas: rzv2h-cpg: Add validation hook to PLL parameter search
  drm: renesas: rz-du: mipi_dsi: Improve DSI PLL parameter selection and
    cache results
  drm: renesas: rz-du: mipi_dsi: Add fallback CPG PLLDSI parameter
    search

 drivers/clk/renesas/rzv2h-cpg-lib.c           | 109 ++++++++++-
 drivers/clk/renesas/rzv2h-cpg.c               |  15 +-
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 174 +++++++++++++++---
 include/linux/clk/renesas.h                   |  38 ++++
 4 files changed, 300 insertions(+), 36 deletions(-)

-- 
2.56.0

