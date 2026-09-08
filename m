Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC7EC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4CF10E126;
	Tue,  8 Sep 2026 20:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MUBUX+Od";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EC910E126
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:53:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A857C601FA;
 Tue,  8 Sep 2026 20:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 502E8C2BCB8;
 Tue,  8 Sep 2026 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788900832;
 bh=9ydGklz8bZHOpqIknHpNgAna7Etxuu7JUtYpdMotKqE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=MUBUX+OdC6MdOoyat4SfIhsk/mYkz4s59QX5MjXRe2hVpWVeJ381rg3owK6oNbOCo
 lUgR2Qs/oUYIm01oYYv3pUM+/u9SXoV8CMBvQrIr2qHTXie/VUP27aKbQv/wtCqHnf
 BRk5aqt8t2RJ2WWR3NVFtBx0lxDkTWQmHGmUAYdr50BtU5K4g3P92UIav2P6/Tu6iQ
 uvcezXgqwcb5r1UdX3UlPVUt++cyYYegCEZAYiRf2MPNfr2lsjrEMGv0CDMtTIpnkB
 iS137AuY68j1uaP/Ll00PU2sSut/z2yLy4jfQe0YF3NgB9qG5BgC1B4nO3DTtatBqh
 gUqU0HZytNieg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE48C79FAA;
 Tue,  8 Sep 2026 20:53:52 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 08 Sep 2026 22:53:47 +0200
Subject: [PATCH] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQ6DMAxA0asgr2spDVPpVRALSAyYUoaESULcn
 QDLt/h/B0uGycLX28HQwpb7zuH98kDVeVcRsnYGKWQkEvHBUfV/XFvSWOTq13JVT1jqJIwDIWM
 /9MGVg6GSt/uaZo/tXDSkpmsFx3ECFD8JCncAAAA=
X-Change-ID: 20260908-qcom-wled-backlight-fd9574027353
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6457; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=yBiYmO8d6SvubGxXelZ3t3PQpKGgRFigdJU1itdaGJI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqoHXe926RXgnO3S+glWPVaG88ro/W9WLSTAOOa
 RVPKlHctlSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqB13gAKCRBgAj/E00kg
 cpJiD/98Rs8zIQxocR0idSCh6Ogmgd/J9rMxS2zgWMK/zQLttQS/ry88pN69AVygf/93I4oNLXT
 HOB/m1kb0y4/vP04Ienuwm5+EbyozXYR6U1IKI475fEIlf+W/Jx3ajQN+wNw/h34kM6syjK0ceq
 ZWSxCkvl4y6seLqWv0lKPk/wJNudf0fbnUgXQ6wyooL9i7KE8SkFLKpcx/U7+VSmJbm5wAloaam
 cBR3qw/Eos3TXqHer9+V9BYwpRhnG/MKWFx3k5GpNAc3kYdZxEoSGVFH+CZAC1mT6+soAIZXRLd
 Kt1lAgvuVps7P8XY/dtqDFRAXe4HZb9OO/dElfUmuBbUDveVZpo5w3QiPMufOhCGgvXQZV5f4pN
 rKrQBqoriJrTSefr34riwr8EKBVmXUDIM2vCPJUGpkp6RJThGtK5+qyGSJ2HGg8Ol6kHdzi3M/N
 FJ8pCz6dV09pOGUASI5AmctCOb/wX17gf5rDiy6I2HYqe3j0NcxGYxl5NbNMwTT16KqzA6ZG6Ap
 NqzBPVcmY2zIJ5MbjnITAvToNfbkGQIL8jK0DpJw7ePlzdoBcrUHP9IZDXI80kpa0RV1VINV3M+
 IOiJmgxpKkR0z38200Q80msIDnmBFhfnd/6aP7d9a9HJG44syQg15ObqUKjU7aSFwWL3ZQkH/jT
 adohQTBb5LbvUuQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

wled_configure_ovp_irq() derives the initial state of the OVP interrupt
from the hardware:

        /* Keep OVP irq disabled until module is enabled */
        if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
                disable_irq(wled->ovp_irq);

but wled->brightness, which is what the rest of the driver uses to tell
whether the module is on, is left at zero.

On boards where the bootloader hands the kernel a lit backlight the two
disagree. MOD_EN is already set, so the interrupt is left enabled, while
wled_update_status() still believes the backlight is off and takes

        if (!!brightness != !!wled->brightness)
                rc = wled_module_enable(wled, !!brightness);

on the first backlight update. wled_module_enable() then schedules
wled_ovp_work(), which calls enable_irq() on the already enabled
interrupt:

  Unbalanced enable for IRQ 176
  WARNING: CPU: 0 PID: 160 at kernel/irq/manage.c:774 __enable_irq+0x50/0x80
  Hardware name: Xiaomi Pocophone F1 (DT)
  Workqueue: events wled_ovp_work
  Call trace:
   __enable_irq+0x50/0x80
   enable_irq+0x48/0xa0
   wled_ovp_work+0x18/0x24
   process_one_work+0x1d0/0x350
   worker_thread+0x13c/0x460
   kthread+0x110/0x114
   ret_from_fork+0x10/0x20

The bootloader is not the only way to get there. The readback runs after
wledN_setup(), and wled4_setup() sets MOD_EN itself on the path where the
sink configuration does not already match, as does the tail of
wled_auto_string_detection(), which all three setup paths can reach
through wled_auto_detection_at_init(). A cold-booted board with a dark
panel can therefore reach the same disagreement.

Move the MOD_EN readback into wled_probe() and use it to seed
wled->brightness, so the driver starts out agreeing with the hardware,
and key the OVP interrupt off wled->brightness instead. The first
backlight update then only reprograms the brightness registers and
leaves both the module and the interrupt alone. The OVP interrupt also
stays armed from probe whenever the module is already enabled, rather
than being disabled at probe and only enabled once something writes
brightness.

Note that a backlight update requesting brightness 0 before any non-zero
one now really does turn the module off wherever MOD_EN was already set,
where before it was silently ignored.

wled->brightness is seeded with default-brightness rather than the level
the bootloader actually programmed, so the first update can still step
the brightness. Reading that level back needs a per-version accessor and
is left for later.

Assisted-by: LLM
Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Cc: stable@vger.kernel.org
Signed-off-by: David Heidelberg <david@ixit.cz>
---
this is slightly annoying bug sdm845-mainline had patched for a years,
but not very well. This should be the proper patch, got ack from people
with Xiaomi Poco F1 (ebbg variant) which does use this so it works.

Adding MSM8953 folks into Cc too, which use the early fix.
---
 drivers/video/backlight/qcom-wled.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 650dd95f06ef5..344b8cad90105 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1622,54 +1622,49 @@ static int wled_configure_short_irq(struct wled *wled,
 
 	return rc;
 }
 
 static int wled_configure_ovp_irq(struct wled *wled,
 				  struct platform_device *pdev)
 {
 	int rc;
-	u32 val;
 
 	wled->ovp_irq = platform_get_irq_byname(pdev, "ovp");
 	if (wled->ovp_irq < 0) {
 		dev_dbg(&pdev->dev, "OVP IRQ not found - disabling automatic string detection\n");
 		return 0;
 	}
 
 	rc = devm_request_threaded_irq(wled->dev, wled->ovp_irq, NULL,
 				       wled_ovp_irq_handler, IRQF_ONESHOT,
 				       "wled_ovp_irq", wled);
 	if (rc < 0) {
 		wled->ovp_irq = 0;
 		return 0;
 	}
 
-	rc = regmap_read(wled->regmap, wled->ctrl_addr +
-			 WLED3_CTRL_REG_MOD_EN, &val);
-	if (rc < 0)
-		return rc;
-
-	/* Keep OVP irq disabled until module is enabled */
-	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
+	/* Keep the OVP irq disabled until the module is enabled */
+	if (!wled->brightness)
 		disable_irq(wled->ovp_irq);
 
 	return 0;
 }
 
 static const struct backlight_ops wled_ops = {
 	.update_status = wled_update_status,
 };
 
 static int wled_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct wled *wled;
 	struct regmap *regmap;
+	u32 mod_en;
 	u32 val;
 	int rc;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap) {
 		dev_err(&pdev->dev, "Unable to get regmap\n");
 		return -EINVAL;
 	}
@@ -1729,27 +1724,42 @@ static int wled_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(wled->dev, "Invalid WLED version\n");
 		break;
 	}
 
 	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
 
+	val = WLED_DEFAULT_BRIGHTNESS;
+	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
+
+	/*
+	 * The module may already be enabled, either by a bootloader that left
+	 * the backlight lit or by the setup above. Record that, so that the
+	 * first brightness update does not enable an already enabled module,
+	 * and so that the OVP irq is armed from probe rather than from that
+	 * first update.
+	 */
+	rc = regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
+			 &mod_en);
+	if (rc < 0)
+		return rc;
+
+	if (mod_en & WLED3_CTRL_REG_MOD_EN_MASK)
+		wled->brightness = val;
+
 	rc = wled_configure_short_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
 	rc = wled_configure_ovp_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
-	val = WLED_DEFAULT_BRIGHTNESS;
-	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
-
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = val;
 	props.max_brightness = wled->max_brightness;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
 					    &wled_ops, &props);
 	return PTR_ERR_OR_ZERO(bl);

---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-qcom-wled-backlight-fd9574027353

Best regards,
--  
David Heidelberg <david@ixit.cz>


