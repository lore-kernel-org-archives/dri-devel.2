Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D6606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=djKR8I6d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FF910E5B8;
	Fri, 27 Nov 2026 11:21:21 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4F410E9B5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:21:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DEDA5C2AC4C;
 Fri, 27 Nov 2026 11:21:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2E4566049C;
 Fri, 27 Nov 2026 11:21:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CEE4311E69318; Fri, 27 Nov 2026 12:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795778469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Jix6Pz7UW5pobNRnrruUYw+ovR/f4EeQICu+13Oeqv4=;
 b=djKR8I6dFfVi4JSDL2RujtjcTL3aNWdXrGLhBE04WDhnsnKieD252IL0pu7TXKw3XL49+p
 8jYWdL9u+zaBaOpiRqnXTA1YiMbBxOM5F3QIodkJDvWzVl7CqMoFxudUyTjE2OH9N+d/Px
 yd9SBXbSFZk4TAbna76F149P+//VsgKKnC4IELxkluAAyLnPUj26dGI/U+hpxOgQfrNdsz
 7yqgptijrUiuxx+sYdHTUgowGaknln2JiWNKbV0p3/GiDFmFZzFZDUOxZZAO1qgdpl0mWa
 b5hRrybkZO5YYwHzdKhWw1NObuaMWkgcE/d783xXjAhh4P7mpbb250KRKRct6Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 27 Nov 2026 12:20:37 +0100
Subject: [PATCH v2 2/4] drm/bridge: ite-it66121: simplify getting the chip IDs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-ite-it66121-log-probe-errors-v2-2-dbe9b5a3c5df@bootlin.com>
References: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
In-Reply-To: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
To: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Julien Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Simplify how the vendor and device ID are computed by using
get_unaligned_le16 instead of open-coded bit operations.

While there, also store the IDs into variables and log them for debugging.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- new patch, split out of v1 patch 1 (Javier)
---
 drivers/gpu/drm/bridge/ite-it66121.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 8bc96ef006f8..4642a32f1bd0 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1573,6 +1573,7 @@ static const struct it66121_chip_info it66xx_chip_info[] = {
 static int it66121_probe(struct i2c_client *client)
 {
 	__u8 chip_id_regs[4];
+	u16 vendor_id, device_id;
 	u32 revision_id;
 	struct device_node *ep;
 	int ret, i;
@@ -1646,10 +1647,14 @@ static int it66121_probe(struct i2c_client *client)
 	revision_id = FIELD_GET(IT66121_REVISION_MASK, chip_id_regs[3]);
 	chip_id_regs[3] &= IT66121_DEVICE_ID1_MASK;
 
+	vendor_id = get_unaligned_le16(&chip_id_regs[0]);
+	device_id = get_unaligned_le16(&chip_id_regs[2]);
+	dev_dbg(dev, "vendor %04x device %04x (rev %01x)\n", vendor_id, device_id, revision_id);
+
 	for (i = 0; i < ARRAY_SIZE(it66xx_chip_info); i++) {
 		chip_info = &it66xx_chip_info[i];
-		if ((chip_id_regs[1] << 8 | chip_id_regs[0]) == chip_info->vid &&
-		    (chip_id_regs[3] << 8 | chip_id_regs[2]) == chip_info->pid) {
+		if (vendor_id == chip_info->vid &&
+		    device_id == chip_info->pid) {
 			ctx->id = chip_info->id;
 			break;
 		}

-- 
2.56.1

