Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EB610A62CC
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C31810E92C;
	Thu, 26 Mar 2026 13:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qFpIHdO2";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2019510E213
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:40 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D339B1587;
 Thu, 26 Mar 2026 14:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530680;
 bh=nEYzezcIAjmSLC9VcRjnoTGH7YY5s81VvSuJLMxj3K4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qFpIHdO2FN8LO2EpDiBtSydK9u7q/gri2kfJOpClQCrd78TVAY1N8P6hKpJWmS63B
 KZFkz5sL0eOvF+Iwmqqkv8ddo6dDaFRZDguAphSZAZNY45zYb6VgVP5yOkP1fMdqmA
 0yjRk2iJnN+zuo0t+NH3cr2PTYK5EPJ2OESIViMY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Mar 2026 15:12:16 +0200
Subject: [PATCH 6/8] drm/bridge: tc358762: Improve DPI enable handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tc358762-fixes-v1-6-65f479227af5@ideasonboard.com>
References: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
In-Reply-To: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=nEYzezcIAjmSLC9VcRjnoTGH7YY5s81VvSuJLMxj3K4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxTC/7eRjZhjkofu4vCvPe311boTXRVtawW2Dc
 UkmejPV0l+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacUwvwAKCRD6PaqMvJYe
 9amCEACE4G4ZZC/IvhSV8l9AenmbB4VVX5Vd+detQdiAKdLt99tvXuzpn7AosMesw6g8EuOnZQC
 mJltN9U1U6MQTlXzn8yBOjHrB5RQVvS2nCLJeIKrkChuEeVtWbhKDRSTH3M0FGxRAv6NlERcBPV
 M+mSb14yU/Bhx7FpwwBe8lF0vh4sQIvka7qVQwaNBdufXjqoC7RxQb2tJCLQSya4VF0/LnxLwrL
 AZiULT9F4gqleKZ0dzmobDmt9jRrzlZ+ij5co6Kp/gyjM8a0kRn2eC3cQ/+OUm+NFjNV0u/WFn9
 B3lu+DKPNL88fdtxfw3DjKksFk6d4xcNFQ/bXmaNhdIufAX8DgkRw/kBhZkooVzidWkJtPMnRf4
 Efi5TAUUKht7s9BWRVOCuSQQutt8OTn6Tt6egfYcPpmzZ3Apdnwvv4ojG3I/oFiFBIudB/Psd3A
 DgtFydjYD26r41fIGRLyafFy3zTCmdOa0+MQ+33pcMW7iszSwtM1OspApE7DOJJuGmaVJ0MGRBD
 OurxbUQnv7+hd2LerFo9vG26IzypSbl2zG6CMWCTPktfj47dtRHXveThzVN49Kn2/6CPd4d7Gqe
 4n8/2aDAwWlBI64fbhc9tv2bQCBS9FaUjiwIAoqEmh6ZMHW29gTdJAS/MNRZDwakYpZBF+Y7Om0
 ISL2BI6VAIU8L3w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

The HW reset defaults has DPIENABLE bit as set. In the current driver we
configure and enable various things while DPIENABLE is set. This results
in a temporary DPI output with wrong timings, which may cause artifacts
on the panel.

Fix this by clearing DPIEANBLE as the first thing when we start to
enable the display. DPIENABLE is set later with the rest of the LCDCTRL
configuration, and at that time we have done all the other
configurations.

Also, for symmetry and possibly improving the DPI output at disable
time, explicitly disable DPIENABLE when disabling the bridge.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 52e2f3a73721..cc1c5ff42cbd 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -134,6 +134,12 @@ static int tc358762_init(struct tc358762 *ctx)
 {
 	u32 lcdctrl;
 
+	/*
+	 * DPIENABLE has reset default of 1. Make sure we don't output on
+	 * DPI until we have finished the coniguration.
+	 */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	tc358762_write(ctx, SYSCTRL,
 		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
 		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
@@ -185,6 +191,9 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 
 	ctx->pre_enabled = false;
 
+	/* Turn off the DPI output */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	if (ctx->reset_gpio)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 

-- 
2.43.0

