Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2CEC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B6710E20D;
	Tue, 15 Sep 2026 20:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NqPwjwec";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82ACD10E2DE
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=4f5DSs8JvTthAFewPMgULYekHAi3JpduAGZQ5Ig/qRI=; b=NqPwjwecIRbX6K7+8XyWTe3J11
 4C3ciZsNUKuE49csJDEbhzvLEbC87bf3s45YAVPWTrTpRmxja8PBN3wTKUjlAkwv3WwVTHQLxv7d/
 cL40aXenBe0wVybHCe6fJbn/SliiGxlcN8GSo35pSN4NsLEi1Nbhr37kYFiIxGw5kI6JI1+sSHjok
 /Wmxzk3pf2rquVkzjYZ1YqCfqzWEThCvlj+HZ8xcWQIIhlUJbh6N4TjeNmsTFjaFSve8CMd951vNb
 DAEqNo/2eh2uyNQ6kJkVftc/mfajMeJb4bzy2ctreiHlbxX9Kw7vjQVhX45L530K54Nco+KCVKOLX
 oiQ7OWAw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6a7u-002dV8-TE; Tue, 15 Sep 2026 22:51:38 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 15 Sep 2026 17:51:24 -0300
Subject: [PATCH v2 1/4] drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-vc4-reset-control-v2-1-cb3a25b07822@igalia.com>
References: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
In-Reply-To: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ZLxH2KxtMio/paY3T16TRijehex03fMfVu4+8ymWrvA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqqa/QuYdaVr19gxYSMUhADmU31rSf4WXcJpc2d
 7d+RRLslkaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaqmv0AAKCRA/8w6Kdoj6
 qomHB/95i5suSvu9rj8DhSWeO6TLeSxiytcg48ux30BGSFj71uAkqCN3a3v/5BdfrA2iqpXzDPp
 VkhJrA4YDa0Fi7zboQUDOrUrH0rObfiGFgQTVvA5jZiimZ0x5qxF7xXEr6UbwX6Gh4RzsmhtPxi
 4wu4/3TIdonvyipLKi/EgFBN2By/d8w9/3W2PfUVHYZykPy1cI9RzDFco4wQF71X4aWbENkuVt7
 pyEP4++DJjtsSDK1L+m6NwkhCtNCnwGqytoInAtN0WdH9VPBte1/o/b+QWO5AxtOpCkcrTxDuPG
 aPR4IrWoj6x9UeY9Nh9JE3NOzZ1ZD4VtaWbabaAmQQoDCV7H
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

"brcm,vc4-v3d" is the compatible string V3D support originally shipped
with in commit d3f5168a0810 ("drm/vc4: Bind and initialize the V3D
engine."). Commit 90d7116061f8 ("drm/vc4: Recognize a more specific
compatible string for V3D.") added "brcm,bcm2835-v3d" in v4.6 and kept
the original one around, because the Raspberry Pi firmware was shipping
device trees that used it.

That string was never part of the binding: the documentation added in
commit 4653f22e9ab0 ("dt-bindings: Add binding docs for V3D.") describes
only "brcm,bcm2835-v3d", and no upstream device tree has ever used
"brcm,vc4-v3d": the first in-tree V3D node, from commit 49ac67e0c39c
("ARM: bcm2835: Add VC4 to the device tree."), already carried the
specific name. The firmware device trees the compatible was kept for
predate v4.6, released in 2016.

Drop it from both match tables.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 1 -
 drivers/gpu/drm/vc4/vc4_v3d.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 616caf9d9915..eb859c65a453 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -279,7 +279,6 @@ static const struct of_device_id vc4_dma_range_matches[] = {
 	{ .compatible = "brcm,bcm2835-hvs" },
 	{ .compatible = "brcm,bcm2835-v3d" },
 	{ .compatible = "brcm,cygnus-v3d" },
-	{ .compatible = "brcm,vc4-v3d" },
 	{}
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..a86739873e05 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -531,7 +531,6 @@ static void vc4_v3d_dev_remove(struct platform_device *pdev)
 const struct of_device_id vc4_v3d_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-v3d" },
 	{ .compatible = "brcm,cygnus-v3d" },
-	{ .compatible = "brcm,vc4-v3d" },
 	{}
 };
 

-- 
2.55.0

