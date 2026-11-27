Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2923606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uq2ifurF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EED0112991;
	Fri, 27 Nov 2026 11:21:28 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2AA10E92B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:21:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B508DC2AC49;
 Fri, 27 Nov 2026 11:21:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 054726049C;
 Fri, 27 Nov 2026 11:21:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B00311E69316; Fri, 27 Nov 2026 12:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795778466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FGZYTUh9Dnh9HZb1Mwnhgv50c7gO4reBCDDbaHESy94=;
 b=uq2ifurFDt+OWR/OdzOTiiONHUMO3jkrjLeTYLU/+VbPV3vZAXktNr0/4VGvIyLVV6KE2Y
 p4jid0jXBhthIHqKD0643ssYVPID5fh8Js1KOD6o+iESR7UgZ9NqkH9vhNTm/jRQC2wMqJ
 YdsHoAKhGjTWQuA8lXBwJbXO0IFeFYVjR0ZLzt1lWhQwyp03FaNBTOFy7D1pXxgWz218cT
 vAIFungOmLKFZHLk5MWBnu6ssCNrVAZylZkhSKkms1hm50/xoq6i930jicIVYV0Lp35guC
 DpV420BEgeHvd9o0cFlo1O2Q+9v6MLq2JCFzpEmzhr1AL+71YsPtZIELTqBTuw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 27 Nov 2026 12:20:36 +0100
Subject: [PATCH v2 1/4] drm/bridge: ite-it66121: check for read errors
 reading IDs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-ite-it66121-log-probe-errors-v2-1-dbe9b5a3c5df@bootlin.com>
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

it66121_probe() calls regmap_read() four times to read the vendor and
device ID registers, without error checking. This leads to silently
continuing using invalid ID values when any of the reads fail (which has
happened and is being fixed [0]).

Adding error checking on all 4 regmap_read()s would be annoying, so switch
to regmap_bulk_read().

[0] https://lore.kernel.org/lkml/20261105-drm-ite-it66121-fix-reset-v2-1-02039d66af29@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- Use just a u8 array (Javier)
- Split v1 patch 1 in two parts (Javier)
---
 drivers/gpu/drm/bridge/ite-it66121.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 34302db25a8e..8bc96ef006f8 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1572,7 +1572,8 @@ static const struct it66121_chip_info it66xx_chip_info[] = {
 
 static int it66121_probe(struct i2c_client *client)
 {
-	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
+	__u8 chip_id_regs[4];
+	u32 revision_id;
 	struct device_node *ep;
 	int ret, i;
 	struct it66121_ctx *ctx;
@@ -1636,19 +1637,19 @@ static int it66121_probe(struct i2c_client *client)
 	if (IS_ERR(ctx->regmap))
 		return PTR_ERR(ctx->regmap);
 
-	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
-	regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
-	regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
-	regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
+	ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG,
+			       &chip_id_regs, sizeof(chip_id_regs));
+	if (ret)
+		return dev_err_probe(dev, ret, "Error reading device IDs\n");
 
 	/* Revision is shared with DEVICE_ID1 */
-	revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
-	device_ids[1] &= IT66121_DEVICE_ID1_MASK;
+	revision_id = FIELD_GET(IT66121_REVISION_MASK, chip_id_regs[3]);
+	chip_id_regs[3] &= IT66121_DEVICE_ID1_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(it66xx_chip_info); i++) {
 		chip_info = &it66xx_chip_info[i];
-		if ((vendor_ids[1] << 8 | vendor_ids[0]) == chip_info->vid &&
-		    (device_ids[1] << 8 | device_ids[0]) == chip_info->pid) {
+		if ((chip_id_regs[1] << 8 | chip_id_regs[0]) == chip_info->vid &&
+		    (chip_id_regs[3] << 8 | chip_id_regs[2]) == chip_info->pid) {
 			ctx->id = chip_info->id;
 			break;
 		}

-- 
2.56.1

