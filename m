Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50219C44502
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA8110EF4B;
	Wed,  1 Jul 2026 12:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Uu9+yMvR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3567D10EF4B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908448;
 bh=10CwvtT4kY3WD8DU6fNrUFwHds9K/lWQ7/9XIIUig4s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uu9+yMvRjGLMKFl9yW+/o2Vic+6LDilccI6IflxLeP2DCne9qMZqxR0PSBjnRW51d
 vv2L5JmyVP7yDZUqFi1E2Ltg20qiPBYVzY/5SVcsCN1f+/xz6F+SdCEPEO1oepjrJ9
 6AMVIVO25Ntbrp4NUK/dnOemc17i0YE7fhnbLnRkCCEqYTfdGFW5MAISY4pKL3NYvV
 Lk5LqfKjYJawd1dRKqfZvdFjbsSMoON4+HLUpNIUywTUv5ZKTqejaY4YnHDDIzqvyU
 vl9EkdBex3Czq9sFxiVVeYUXhWLPjPklNlOsN4zxaM0jIjLv6+xtCrNU1dNCbw9fR2
 fzRKWxUbdJNaQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EC2C217E0F44;
 Wed,  1 Jul 2026 14:20:46 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 andi.shyti@kernel.org, djakov@kernel.org, broonie@kernel.org,
 jitao.shi@mediatek.com, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 1/6] dt-bindings: soc: mediatek: mutex: Improve title and
 description
Date: Wed,  1 Jul 2026 14:20:38 +0200
Message-ID: <20260701122043.19612-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
References: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
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

Improve both the title and the description of this hardware to
disambiguate its functionality from a hardware mutex and/or from
a hwspinlock.

Though in datasheets this is called "DISP_MUTEX", the meaning is
is "Mute-X" (where "X" means "any hardware trigger signal") really
as this is what this piece of hardware does: muting or unmuting of
signals in each sub-IP of the display or other multimedia related
controllers.

Based on that, also clarify the description text, as to make sure
that the information is actually accurate.

While at it, also avoid forcing literal blocks in the description
as there is nothing in there needing that (no ascii graph or other
stuff that needs a literal block anyway), and add myself in the
list of maintainers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/soc/mediatek/mediatek,mutex.yaml   | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
index 5267cfe92572..1ba086ad749d 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
@@ -4,18 +4,21 @@
 $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mutex.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek mutex
+title: MediaTek Mute-X
 
 maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Chun-Kuang Hu <chunkuang.hu@kernel.org>
   - Philipp Zabel <p.zabel@pengutronix.de>
 
-description: |
-  Mediatek mutex, namely MUTEX, is used to send the triggers signals called
-  Start Of Frame (SOF) / End Of Frame (EOF) to each sub-modules on the display
-  data path or MDP data path.
-  In some SoC, such as mt2701, MUTEX could be a hardware mutex which protects
-  the shadow register.
+description:
+  MediaTek Mute-X, namely MUTEX, is used to "mute" or "unmute" trigger signals
+  like Start Of Frame (SOF), End Of Frame (EOF), Tearing Effect (TE / VSYNC)
+  and others to each hardware sub-modules in the Display Controller IP or in
+  the Media Data Path (MDP) IP.
+  In some SoCs like MT2701, this hardware module may feature functionality
+  to, for example, protect shadow registers by blocking auto write triggers
+  upon operation (usually frame push) completion.
   MUTEX device node must be siblings to the central MMSYS_CONFIG node.
   For a description of the MMSYS_CONFIG binding, see
   Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
-- 
2.54.0

