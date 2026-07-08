Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA749C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B8510F43A;
	Thu,  9 Jul 2026 07:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tFLRu6oM";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1C510E60C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 13:43:27 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-59cd803792aso364347e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783518206; x=1784123006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTjqa+8oynSoVj1P4JC5t/e1L3Jq0cVpGMAlSPn0/oc=;
 b=tFLRu6oMRZVeGsW8VeP1a57m5TyezZzToNqsXsEr+fuj8f77vUeVEFxwwCiFA2QrUb
 FLNoG1iPQs/ExNP6L6bdu0NKrLaWxGqUf/sjPwbmAh67uv8c1wyN6QxCM1Vbt6I+g1zw
 FOv3C0RUsqF/q9Gr1DZhhCYyTV18o1ueB1cykofRoCSNZSeuQltraTf6E3QpD3VW7cdS
 NTZ8EMTt21A1IrhFWNIAWOqHs5LK0em0CnzdaBXMyjFzmnKmXLQuV9gGeAXnTfLBzh7C
 UeTwaTOGT1Nmr9chc90L35PVb9onJhgTU45u7+uU/uL9vQaPYSvs8VLKW0Kb2JBXj2XR
 DT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783518206; x=1784123006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTjqa+8oynSoVj1P4JC5t/e1L3Jq0cVpGMAlSPn0/oc=;
 b=pzOawe360QnqbzqYHU56OmlehlOeYqxX7ranzV0FxhY4XNHzJ24xHH73B/PKVCYUTE
 mN5SeJkZ5trJo7z8GXA731p+COivLJWlptLBVkA3DuBRT65jBbOqK0dqTct937JWIvHA
 f0AK2EEUva4y/RmYP+mLZlrgMK0DZ68louGOQ7nNbGt0Yj7qqN8PnkkC9sUTbsyfuagX
 62xLPwVYqvpL84iCfEfSYFZEGly4sTaz6saD7ZXq12kUkLDh5fdB0pxuWfWGDTj/9HyM
 gxFODkgulYm4eAxhWG831x43grtJGk5UEujgRNIG2qOGtImk3vKB5yrMYCAhlD4CTi3e
 o8kw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrtx6fQX1d2E+HDEL4v6LiVAiC27fECucjP8YEzUFezpQy7eCm4qu07meW3O/H5ZLaz9PzHJUk4lfE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxufD058gZv2Ce6obVSgfDtgr2C9Wg/Su+MhlljUR6MckPbo44L
 JAm9PPUZjy6+gpMWopnR9/Ao5oUXD6jKi8CZ6aCg0sG9jEzp7lLURtxW
X-Gm-Gg: AfdE7cl+BZmQj6BaPhyBBMARJv3yZDEmVxhDCivhIPeWmbpUUSVfe/4bhNJWG6F0MOK
 xmIR64dHEba8RTQ2Po28MVbadW76FpJ92N8NQZ/sKhXBxJrLs7NHgh9KuV98K0Eu39tczaEceQh
 n2OnDyA0NnoE3n85Uq1jXS7Rtd1WHjgaZzuPx+2su6TqIFmJdvzEI9pFvyKy9C9T4WBvanD+Qi0
 EntwzKcb4bc27m35aPO/trcyoaguTg6uM8tlGhNckw5OgeZtdXxenMeFCaHPXNJfmHtFqBd8lj0
 9YFRHzwJZ/NSSzEHfe0ldNsC2NimpsrR9HzeXx8vwIHVg072nR+RCg7qzBN98Rqn+0UjqYdD7Zl
 1G26C4+Trih+em9RViuIQjvO2F6PmREcX7H0BoMp/zRGbIO6Z7nfPhVZgRAKbsUmgPTXbXkPVjp
 kEDwudvQ0fFv706i+fSroAcS37DmDu
X-Received: by 2002:a05:6123:102:b0:567:4e8a:fb13 with SMTP id
 71dfb90a1353d-5bf75dc3cf4mr1129732e0c.8.1783518206208; 
 Wed, 08 Jul 2026 06:43:26 -0700 (PDT)
Received: from fedora ([67.230.148.25]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bf6f5e12a9sm1652971e0c.1.2026.07.08.06.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:43:25 -0700 (PDT)
From: Thierry Cantin-Demers <thierrycantindemers@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Mika Kahola <mika.kahola@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Thierry Cantin-Demers <thierrycantindemers@gmail.com>
Subject: [PATCH] drm/i915/psr: Disable eDP Panel Replay on XPS 16 DA16260 (LG
 0x07C5)
Date: Wed,  8 Jul 2026 09:42:52 -0400
Message-ID: <20260708134252.11854-1-thierrycantindemers@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

The Dell XPS 16 DA16260 ships in more than one panel variant. The existing
quirk entry only matches the LG Display panel with DPCD sink OUI 00:22:b9.
Another variant of the same laptop (subsystem 1028:0dba) uses an LG Display
0x07C5 panel with sink OUI 00:aa:01, which is not matched, so eDP Panel
Replay stays enabled and the panel hits a persistent PANEL-REPLAY Link CRC
error, dropping the internal display to ~5 fps.

Add a quirk entry for OUI 00:aa:01 so this variant also gets eDP Panel
Replay disabled. Confirmed xe.enable_panel_replay=0 resolves the issue.

Fixes: cb8d155b0806 ("drm/i915/psr: Disable Panel Replay on Dell XPS 16 DA16260 as a quirk")
Signed-off-by: Thierry Cantin-Demers <thierrycantindemers@gmail.com>
Tested-by: Thierry Cantin-Demers <thierrycantindemers@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..e452235832fe 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -286,6 +286,14 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
 		.hook = quirk_disable_edp_panel_replay,
 	},
+	/* Dell XPS 16 DA16260 (LG Display 0x07C5, OUI 00:aa:01) */
+	{
+		.device = DEVICE_ID_ANY,
+		.subsystem_vendor = 0x1028,
+		.subsystem_device = 0x0dba,
+		.sink_oui = SINK_OUI(0x00, 0xaa, 0x01),
+		.hook = quirk_disable_edp_panel_replay,
+	},
 };
 
 void intel_init_quirks(struct intel_display *display)
-- 
2.55.0

