Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F8606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B/Tq2xt2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D2E10E08E;
	Sun, 15 Nov 2026 04:48:10 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5986C10E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 04:48:04 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-37d424f1ae8so713588eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 20:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794718083; x=1795322883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LLWhkWwyzjalnr3Z5HU+EI8soyzPleNcaIf48jvo+8k=;
 b=B/Tq2xt2yheTPGvxB6sT1O6dz5DDWdSqF4uXrwxQyVvx3kWracinQ09bFYmKScp27G
 KIckxchbqAkeXWqfJXB7iOAlL/irIcxmYBjHJucMKFCByt5tqs+z5VJ5dE0rB93NbM4D
 yCqEctkaGeB+4Lr+UsUnMoUuFQcgnhS/SiPIGse4bdFTiawLTgyginjEUIPr2JNDSP5/
 gaSKmfUsRnKOUyRUFOmyqruAXjfWwSF/lkxUe/5JKIYMdU8FgOrbLEFotAdqPHi7gZMX
 Qy1Y+Ok5vlrCf/K+NyF+g3rYP4vwWVKsOzsbXMdpnoRYHL/QcNywMGhqIVy0RURFLfnh
 hXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794718083; x=1795322883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LLWhkWwyzjalnr3Z5HU+EI8soyzPleNcaIf48jvo+8k=;
 b=ej9zGE95AjORPPT07L5Gi/mkXYaf13KC/la+/Zldd8Nlx3vExQmOEqZh9EdL7U4BE6
 ywRayetye2BOrD+OeigpQqVrx0oH9qJb2vQhowLQuKc7SpFmyl8nQ9686qOT8dBf8Z1M
 yC6K5bLuLMZ19HOjsFoyB1V51+BX3YHPacD4cazo+EvVSroYNJNPuYormw1n+RpZrPWj
 r3J8NuCfeMl5rxlTjejrHut1UyXGB9g/hiDKznd9LsR4I6vMDMP3qGQD1KYbeGv9Z4xo
 IQM08AQwXEzshFkU1XdadyO8k3ENorIEekzYLwY6JxR+A/fBuJJopExaicIyatARerkz
 w0Wg==
X-Forwarded-Encrypted: i=1;
 AL+hErEacgBUh/LZFCJT7aRVzVCJuvbSWvMiys7904it7iVvJl6yFiOwlaSUkwO0d5SGnyfXDCNQeFBgix0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2C1GMkFYawJVew2bw78SmaBmrtY/7g4/AgOQCDDLHlManC2I1
 R6OmZyzJkQrpc0OqwbfH67mL9Zjxnjk1cMFdUS7y0p+lkvKcBoQACY7w
X-Gm-Gg: AYBFou2M4QXTaw+fSVAu3vqvHhkBlVdV1YGYNB/gB5Pr3CBWdq+vg31jtRRFLsKB4Ww
 i8tgKVNEaXqJcygMYPJbwEdRG+rVPJMSo9t/3RqCpfuNZCfybky/ofM6gblFPKMi06oEz3//wz2
 xlM7oHRqrihm3GeHPNih3+1kaLwF7LFCiQDXHvaZMCDDmPv7DKTpmmQy7onQqtsyHWhUbj/xSL2
 3xY7gy9Qz1I7pV7e4y9AtDiu3aMClA0H9hMPHDONRn1iP/6epWNvqjlD8Sfxdq/Vh0OdhhRkccD
 jAn8W6W4cwAgc5NmPDAxEVVn8vIzLTg5K4pP89r/6T/V3JGkrM/pCDHDXhA4umDtQ3cafzyHXuj
 t14d5qg/tBSsy7lRhFSygQXLT4XfNDVBqelnxALmIDCKWbYOSjfutOEFSWhUz7IhCvTW0Gj/jId
 OGrmFOWKxuSHjZUlnC3Ekf7zefDWkc52rwLBPb9Kfx9HLAh+cAsmuhExxnm/xy7yNPltI3xRPBP
 KfbeZXzsI4LzNANJDILxTNqIm4v274OjA4YhyXs31y6fpO8Kc7AsEriuVozz+B/AoxM6J0D3DWK
 EQIk/vZcdh52S+a+xl1h3O/EmheByBSLzj2ljrA=
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id
 5a478bee46e88-37963660405mr7150743eec.4.1794718083366; 
 Sat, 14 Nov 2026 20:48:03 -0800 (PST)
Received: from arch.localdomain ([152.175.35.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955a1c5c2sm22624099eec.14.2026.11.14.20.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 20:48:02 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>
Cc: Jun Yan <jerrysteve1101@gmail.com>, Damon Ding <damon.ding@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v4] drm/bridge: analogix_dp: use devm_phy_optional_get() for
 the DP PHY
Date: Sun, 15 Nov 2026 12:47:53 +0800
Message-ID: <20261115044755.395888-1-jerrysteve1101@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DP PHY is optional: the Rockchip RK3288/RK3399 eDP controllers use the
built-in PHY of the Analogix DP controller, which is programmed through
the GRF registers, so their DT nodes have no "phys"/"phy-names"
properties. devm_phy_get() therefore returns -ENODEV and the driver logs
a misleading "no DP phy configured" error before falling back to a NULL
phy.

Use devm_phy_optional_get() instead, which returns NULL when the PHY is
absent and propagates any other error, and drop the open-coded -ENODEV/
-ENOSYS handling and the spurious error message.

The behaviour is unchanged for both CONFIG_GENERIC_PHY settings, because
the real implementation never returns -ENOSYS:

- CONFIG_GENERIC_PHY=n: devm_phy_optional_get() is a stub returning NULL
  (devm_phy_get() returns -ENOSYS, which the old code mapped to NULL).
- CONFIG_GENERIC_PHY=y, no PHY described in DT: devm_phy_optional_get()
  converts -ENODEV to NULL, exactly like the old code, which mapped
  -ENODEV to NULL in its open-coded check.
- CONFIG_GENERIC_PHY=y, any other error: still propagated, as before.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
---
Changes in v4:
  - Rework the commit message to explain why the behaviour is unchanged
    for both CONFIG_GENERIC_PHY settings, with one bullet per case, as
    requested by Luca Ceresoli.
  - Link to v3: https://lore.kernel.org/dri-devel/20261110023721.2014061-1-jerrysteve1101@gmail.com/

Changes in v3:
  - Add missing changelog entries and reference links
  - Link to v2: https://lore.kernel.org/dri-devel/20261013134659.335829-1-jerrysteve1101@gmail.com/

Changes in v2:
  - Added comments to explain the changes made.
  - Link to v1: https://lore.kernel.org/dri-devel/20260924020417.868588-1-jerrysteve1101@gmail.com/

 .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df6963740d2..637b1bff0f6c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1426,21 +1426,13 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	if (ret)
 		return ERR_PTR(ret);
 
-	dp->phy = devm_phy_get(dp->dev, "dp");
-	if (IS_ERR(dp->phy)) {
-		dev_err(dp->dev, "no DP phy configured\n");
-		ret = PTR_ERR(dp->phy);
-		if (ret) {
-			/*
-			 * phy itself is not enabled, so we can move forward
-			 * assigning NULL to phy pointer.
-			 */
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dp->phy = NULL;
-			else
-				return ERR_PTR(ret);
-		}
-	}
+	/*
+	 * RK3288/RK3399 use Analogix DP controller built-in PHY,
+	 * no extra PHY configuration is required.
+	 */
+	dp->phy = devm_phy_optional_get(dp->dev, "dp");
+	if (IS_ERR(dp->phy))
+		return ERR_CAST(dp->phy);
 
 	dp->clock = devm_clk_get(&pdev->dev, "dp");
 	if (IS_ERR(dp->clock)) {
-- 
2.56.0

