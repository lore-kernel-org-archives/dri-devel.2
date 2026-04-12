Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380E5E937E1
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 11:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4AE10E036;
	Sun, 12 Apr 2026 11:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="SC0Xm2pK";
	dkim-atps=neutral
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E4E110E29F
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 11:46:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1775993983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ad7/bRfV8u7IERX/bf/ei/J84Int3n51xEDFDCTajV8=;
 b=SC0Xm2pKbwJ4oqXrDqkrFOoZinzDFNd7LoMtyBjR537A+zvoh3Zc2iCyMrTsjHvPUxYhr2
 6XzDKDuN86U5V04qVIY20FXEfqszjJAmGdGUOZKJxGdCDp9CbNu4B6eFxS+tqkKGNsS5XE
 0cHVzQssuSlGRZfZG/V8FpHm/dLRj6HRbjHwypWNYAe0zeuUT2PiMb4Pl6fVb0xmIOAdz+
 GPTdrkCoKVyGKrFiaGJA4sCmUW7LGDY8dxmU8fWHrPzl1qfmR6bScaLJJEomRWP5wOD90x
 5Z3+2j+TrxbMwqdmKfa+QVbx71m/bY1RvRYlSQ+1t/tHdAW2cdLJXsrDNHfPEg==
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alicja Michalska <alicja.michalska@9elements.com>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Novatek NT37701 driver / mode-aware drm_panel_prepare
Date: Sun, 12 Apr 2026 08:00:43 -0300
Message-ID: <20260412113851.355944-1-val@packett.cool>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

I've been working on a driver for the panel in the motorola-dubai[1] phone,
which is a 6.55" P-OLED panel based on the NT37701 IC and made by either
Tianma or CSOT. Unfortunately there is no info whatsoever on the internet
about this panel so I cannot confirm any model number. (Please feel free to
suggest a better compatible string.. I'm not sure what the latest convention
is for these situations, but I've seen a couple drivers land that don't
even mention the panel vendor and use a generic DDIC compatible heh)

The "interesting" thing here is that like most other modern OLEDs this panel
supports a lot of refresh rates, and can even change them seamlessly on-the-fly
(in downstream dts there are command sequences for this). However upstream
currently there hasn't been a driver that needs to send specific DCS commands
to configure the mode at all! Most drivers for panels that definitely support
various modes have just been listing one mode (e.g. nt37801 only has 120Hz).

(If anyone's wondering about what happens if you skip the commands and just
run a mismatched mode: visual glitches, of course.)

Not content with only having no choice of refresh rate at all, I worked on
a way to make this work, and it turned out to be pretty easy. The mode
can be passed via bridge/panel since it's available there. Adding an alternative
prepare callback seemed like the easiest thing to do.

I'm looking for some guidance on getting this to a final patch, if there's any
caveats I missed, a better way to pass the mode, etc.

(For the driver, I know I haven't written a binding yet :D)

Thanks,
~val

[1]: https://lore.kernel.org/all/20260403054417.167917-2-val@packett.cool/

Val Packett (2):
  drm: Introduce drm_panel_prepare_for_mode callback
  drm/panel: Add driver for Novatek NT37701 based OLED panels

 drivers/gpu/drm/bridge/panel.c                |   8 +-
 drivers/gpu/drm/drm_panel.c                   |  15 +-
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37701.c | 532 ++++++++++++++++++
 include/drm/drm_panel.h                       |  12 +
 5 files changed, 564 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt37701.c

-- 
2.53.0

