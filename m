Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD174CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E2310EAD1;
	Sun,  4 Oct 2026 17:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LB58/RE4";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B9610E3B1
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:15:38 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so55433555e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790925337; x=1791530137; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qqyFh9OKcAKMhJTMe6dKznZlWeuV8+PzVNUvWK2iZbM=;
 b=LB58/RE40cdt+FlDXWLM45LIR5PFMSpR4XAxLIy/mROWcD2mtSHqnZK9I/lovYaWcf
 nR7IeQK//zli2IZ5H5gr4uDXjR9T+9Vb1uFf1jHO4zbK48R8sSq2IQjF1SIcN/myP/Bv
 nMYiXBGzNkDXSbU3bGkVqIS8San8spNkPjsxdUPeKo8jARjH44dzb8MQSpepfmKIwHGy
 W60vq2cAKNSTZ+5pib2nSRFyHsTlVo6cDY9m9aunbfW4I1uKnVVnhDkZRWJIULKSFoc3
 8uoBdRNSudxLOmO98Ci1nxVoshHTRiPuckNQ9puuCc5SSe4X9KxdBLiTiQzzUi1gCSyJ
 mSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790925337; x=1791530137;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qqyFh9OKcAKMhJTMe6dKznZlWeuV8+PzVNUvWK2iZbM=;
 b=FmahmBPj82mku7ucE/F2N33mUSl0B/VO77tnrJg+HxxB4a00MIz9kOWwKG5+ZxfUJZ
 fHpai6eViG6AF1jLZy8/m/07gPLOGhq2hme1Lp7aRCtbb/kt7DeCKBA0AQeVRk2iyJyy
 6l8b/w4DhbFvpunnbk+lPhKrLTummmBRvOHbghDKMgKCnH7UQD9BS3jtUF0PysJfTVI8
 7utxGp/I+anpgfZ70cSW4Oyqsxduayj95PLkPC54UmBCqmpDp70igdKWfSKvt9sFuY4e
 lNLYbjZDEPjzDMGasyHFQ8+g6RWYNtzKKiCLLf5+nnbRPuUXVAEuCJQyCkZGasIVbJpt
 w4kw==
X-Gm-Message-State: AFuF++kYMSjLIQ1SnwvZrlINaRBGDlZjSuU8QtgIR17BNmWZACboGPlb
 DxTpi0sHfFBgE3qBUrzayC1mCtk7EekP0iuIzMLL/GOmRVtw2latnyIM
X-Gm-Gg: AYBFou1ek2jbvpUIUkKujb+mn23UBLUem38tPFyjpCGmM9ECcPEX8aIHxfWWhJbnfER
 WplGAgvoQ+vaq1GRR1ez2TPtlwca90P+FVfzv9zrOKtli/QLTF0Uh737I4xSUXyKkci4bfn3/Lp
 eRUquYhhly6AvUEPdjxr+RfapFqdzk6hGSvtvTBlnPpEdnpvIa+Cvae1lHC4MlG7I81gCmIUhmX
 VE+u+3aLXz9Ub4Dyht/bHgAD05iD5T7miBYCZ2cxyZNLhD4FmdHicnPMGMq21xR4eCtFc9dxPUd
 phLnrUB2YquQV2mYY2E6yj7/sav0NndbOkcllKs1SH0tQSggzNs8LjTQTs0uu668TybpALFBiRe
 3JNlky7ILU5PUyOesV351mNiWKJKDT2d+Nkp1i3mYoolfKiz1dg1RJRJi8/XQhE9zrlGCj17+gm
 tpQSS++955C6kMC7qQipSBm1EOb4huwMqmmgnDEXH1Ud9sOZJMuk4uTy0bbg8qFNIhztephSifQ
 b65v89/AKw4ebQVSRgz5HSLWH7Z7jlIuwzC7q31J6PNW50LYu4Tgx0G8vte7dOu
X-Received: by 2002:a05:600c:3b01:b0:49f:ce72:e930 with SMTP id
 5b1f17b1804b1-4a02758eed8mr33065465e9.34.1790925336506; 
 Fri, 02 Oct 2026 00:15:36 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027741586sm57170235e9.14.2026.10.02.00.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:15:36 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Fri, 02 Oct 2026 04:15:23 -0300
Subject: [PATCH] drm/bridge: simple-bridge: Enforce input bus flags via
 atomic_check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com>
X-B4-Tracking: v=1; b=H4sIAApav2oC/x3MSwqEMBBF0a1IjS1IKbSfrYiDJL7Wwi+JiCDuv
 UMPDxfuQxFBEanNHgq4NOq+JUiekZ/sNoJ1SKbCFB8xRvgSjroeC9gFHVK3576qZz/Bz4zKVXB
 1WQsaSo8j4Kv3/9/17/sDJdI5NG8AAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Leonardo Costa <leonardo.costa@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790925335; l=2106;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=xqan7CitOzDVUI34jPQl+mNM+DqEBoLtPLpDOGRqX00=;
 b=ypmqd1FinxsQrSduoBP46+XorgtAIAyXI8upcyPQebztuVjZA3vNWwcOm4JJxZnxm+RAwXFtx
 zf24w8B1BtFB3hQKmC39JAdK+fLmT5Vw5Do2qA32k7MG4//9p3mYYvP
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

The input bus flags set at each bridge's timings are never actually
added to the bridge state and are not considered during modeset.

Implement the atomic_check function, to allow simple bridges to declare
their required input bus flags.

Existing bridges that configure specific flags (currently the ADV7123
and THS813* bridges, which set DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE) now
write them to their bridge state, and have them propagated to the
previous bridge in the pipeline.

Fixes: 0a01de65a741 ("drm/bridge: simple-bridge: Switch to atomic bridge callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3fba7002322e9..848c2df2a276a 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -158,11 +158,23 @@ static void simple_bridge_disable(struct drm_bridge *bridge,
 		regulator_disable(sbridge->vdd);
 }
 
+static int simple_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	if (bridge->timings)
+		bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.attach		= simple_bridge_attach,
+	.atomic_check = simple_bridge_atomic_check,
 	.atomic_enable = simple_bridge_enable,
 	.atomic_disable = simple_bridge_disable,
 };

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20261001-v1-simple-bridge-atomic-check-e7b7eb8381e9

Best regards,
-- 
Leonardo Costa <leonardo.costa@toradex.com>

