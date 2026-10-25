Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E7606A31B
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENT6JoZ7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A1210E53F;
	Sun, 25 Oct 2026 04:02:28 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAAE10E57B
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:02:22 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-14394530ec6so2669393c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900941; x=1793505741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9V8bhrkeRqD536LIpEdmwvDv4vBsMscyvHJCjoTqtsw=;
 b=ENT6JoZ7/cS1zzuSFPQ30InrUvZhLeApIsyfv4bXb020S0pa0eh45ME/dgYbMLQG3A
 Rw9YlbMjrZXkFYPL4X5jicqzB5pipYiJNONpM3UB0VBBTnqKfAWD6N3YB+EXNW+xXGDJ
 JAW97YXhevvkCksMWvtOJBYA1mxNN0iew/xI0Xzw7tf1YnoFiE5zUZ6kV/pgtEn38bgr
 S4bi3rSg5qYIFqD5uSm19XEr7rin39R5+mdrsfndfK0Du+PWLuF2994uxVMDaZUQKd2l
 73cCnfJQU02o3pFKK8f+82yo4vbjBb/AEdqa0NahgbsD/HICpEHqo4uKT9r/7MDyUL7e
 CMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900941; x=1793505741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9V8bhrkeRqD536LIpEdmwvDv4vBsMscyvHJCjoTqtsw=;
 b=kxDGpamL8sfMCHtsDDlIGy6D+W0b6FwPkfPAJnanFwHo1op3zCbLSF5PpJy2OyYE6k
 FDQgu9k1ONulUMi69wNDsFS/5ebzqOIB/OxcZXglqmni/6HXK8uxA4oA6zOmYHECVFj6
 E01bf+3LvrrpoyTRWLwjO9cK4yd/eNMs+Hw/L6BCog6FGxlN7rxZi+U0iuDFTWfUYT6f
 x0eN1b+JXeLotPaKM77mmH+9OpvWeCJkVXddr/8TH9VFplCDdqACOGvd6nhOLxlThhVD
 6uRFLyS2x4r87mjooLjMGJwFn0kGznLFiqtQExfNr0BxQnnLaWkCr5yZyifDJ/LEdWHA
 tNGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHyOuAqiO+mEdbk6DCs8oeTo6ioiI021tazqd9Y2j/oJD4HgF3QHGmwwMNwBnPFiG7f9yWErcckJo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLs7bvkxT9CDJduf/P31KB6h/4icTz8krYQrMpoeBfqqZsasW+d
 kBjrgXskfArKH3TaP+WCF4YMN8wEeZyVyaubpb8xjSd9s4awdJW65iQ=
X-Gm-Gg: AYBFou22Z8AO8Bbvm47WRLks9Rw9toL/ICv8xzUmeZvJ51KinbsEEgrxYryKl39sYxg
 2Ez2iz3u3PDtTFSfEPdMisoaQzQwT4IBf36CBswYnqu6XszlA28hqd4kNh79QCjkkOTM+/Sri97
 Z0LW3V0fdO1MAkLPf9+VhYwZ/NOqAUFXnF4Cr5iqhFKNg9+CdCXKMt2gODUeU2NGO7/KLCcawB5
 SACbvTXYQZvQ4lesicUcIqqBole8018Tl3WSsLVXHd6zWTxBIEKsGOG1+T6qGZLIWu6YI/ZAHwq
 1OyQSUoRDYcKyAINZECFus16ZlFvYDhfAkDadOMZyGRk0MEN+puwk3nqa/pqTjGvPfrrWQK8fml
 DWC1COi9AFzs+gK88QzygvLNt9bgaSMKMuCe/ariAWnOyYjhAYHVVLyNebY3T5TaYL1XYvwxk2Q
 x1cCBxSpUmPz0tCKwOMQN1p4GPlpCzyRgNBNsqG7CuAzLtjXFLmrGkMLz2zdtN8txQCYbuGZj9f
 lGulQWPBxcat+1xRGiqIc8akFchGMSpVNZMFh2IYrbG+ppvXRdS8yC4coq+0hZQ8gcTspyscYRa
 zfcNfQH7bymD8HQ=
X-Received: by 2002:a05:7023:d04:b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-19936e34bacmr5319231c88.37.1792900941134; 
 Sat, 24 Oct 2026 21:02:21 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:02:20 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 04/13] platform/apple-gmux: Fix Interrupts for MMIO systems
Date: Sat, 24 Oct 2026 23:59:40 -0400
Message-ID: <20261025040046.1602-5-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

on MMIO systems, we need check to for failure in interrupts,
and we have implimented display hotplug to wake up the gpu.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 96 +++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 076ed7ba6..bef87a57a 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -6,6 +6,8 @@
  *  Copyright (C) 2010-2012 Andreas Heider <andreas@meetr.de>
  *  Copyright (C) 2015 Lukas Wunner <lukas@wunner.de>
  *  Copyright (C) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
+ *  Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ *  Copyright (C) 2026 Andre Eikmeyer <dev@deq.rocks>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -23,6 +25,8 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/debugfs.h>
 #include <linux/dmi.h>
+#include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -66,6 +70,10 @@ struct apple_gmux_data {
 
 	struct backlight_device *bdev;
 
+	/* interrupt handling data */
+	bool external_state;
+	struct work_struct interrupt_work;
+
 	/* power handling data */
 	struct pci_dev *discrete_pdev;
 	bool uses_pwrd;
@@ -105,6 +113,7 @@ struct apple_gmux_config {
 
 #define GMUX_INTERRUPT_STATUS_ACTIVE	0
 #define GMUX_INTERRUPT_STATUS_DISPLAY	(1 << 0)
+#define GMUX_INTERRUPT_STATUS_FAILED	(1 << 1)
 #define GMUX_INTERRUPT_STATUS_POWER	(1 << 2)
 #define GMUX_INTERRUPT_STATUS_HOTPLUG	(1 << 3)
 
@@ -417,8 +426,8 @@ static const struct backlight_ops gmux_bl_ops = {
  * the discrete GPU can then be woken to drive the newly connected display.
  * The ability to switch AUX on these generations could be used to improve
  * reliability of hotplug detection by having the integrated GPU poll the
- * ports while the discrete GPU is asleep, but currently we do not make use
- * of this feature.
+ * ports while the discrete GPU is asleep, but currently we only make use of
+ * this feature on MMIO/T2 Macs.
  *
  * Our switching policy for the external port is that on those generations
  * which are able to switch it fully, the port is switched together with the
@@ -796,9 +805,10 @@ static const struct apple_gmux_config apple_gmux_mmio = {
  * value is read and then inverted.
  *
  * Because Linux masquerades as Darwin, it ends up in the notification-only code
- * path. On MMIO gmux's, this seems to lead to us being unable to clear interrupts,
- * unless we call GMSP(0). Without this, there is a flood of status=0 interrupts
- * that can't be cleared. This issue seems to be unique to MMIO gmux's.
+ * path. On MMIO gmux's, The Polarity is initally left in a undefined state leading
+ * to lots of interrupts, that we can't clear, to fix this we set the polarity to 0
+ * everytime we enable interrupts, On MMIO gmux's, GMLV reads the same GPIO pin as
+ * GMSP, and setting the polarity to 1, stops the Interrupts completely.
  */
 
 static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
@@ -807,8 +817,11 @@ static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
 		    GMUX_INTERRUPT_DISABLE);
 }
 
-static inline void gmux_enable_interrupts(struct apple_gmux_data *gmux_data)
+static inline void gmux_enable_interrupts(struct apple_gmux_data *gmux_data, bool do_gmsp)
 {
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO && do_gmsp)
+		acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
+
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
 		    GMUX_INTERRUPT_ENABLE);
 }
@@ -825,23 +838,78 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
 	/* to clear interrupts write back current status */
 	status = gmux_interrupt_get_status(gmux_data);
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
-	/* Prevent flood of status=0 interrupts */
-	if (gmux_data->config == &apple_gmux_mmio)
-		acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
 }
 
+static void gmux_notify_work(struct work_struct *work)
+{
+	struct apple_gmux_data *gmux_data =
+		container_of(work, struct apple_gmux_data, interrupt_work);
+	u8 status;
+	bool turn_on_gpu = false;
+
+	status = gmux_interrupt_get_status(gmux_data);
+	if (!status)
+		return;
+
+	gmux_disable_interrupts(gmux_data);
+	pr_debug("Notify handler called: status %d\n", status);
+	acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
+
+	status = gmux_interrupt_get_status(gmux_data);
+	while (status) {
+		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
+		if (status & GMUX_INTERRUPT_STATUS_FAILED) {
+			pr_warn_ratelimited("interrupt failed: status: 0x%x\n", status);
+			status = gmux_interrupt_get_status(gmux_data);
+			continue;
+		}
+		if (status & GMUX_INTERRUPT_STATUS_POWER)
+			complete(&gmux_data->powerchange_done);
+
+		if (status & GMUX_INTERRUPT_STATUS_HOTPLUG) {
+			/*
+			 * We get an interrupt every time a display connects or disconnects, but
+			 * the GET_DISPLAY port only tells us if a display is connected or not,
+			 * so we resume every time a display is connected or disconnected.
+			 */
+			bool external_state = !!gmux_read8(gmux_data,
+						GMUX_PORT_SWITCH_GET_DISPLAY);
+			if (external_state != gmux_data->external_state) {
+				gmux_data->external_state = external_state;
+				if (external_state)
+					pr_debug("A display has been connected\n");
+				else
+					pr_debug("All displays has been disconnected\n");
+			}
+			if (!gmux_data->external_switchable && gmux_data->discrete_pdev)
+				turn_on_gpu = true;
+		}
+		status = gmux_interrupt_get_status(gmux_data);
+	}
+
+	gmux_enable_interrupts(gmux_data, 0);
+
+	if (turn_on_gpu)
+		pm_runtime_resume(&gmux_data->discrete_pdev->dev);
+
+}
 static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
 {
 	u8 status;
 	struct pnp_dev *pnp = (struct pnp_dev *)context;
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+		schedule_work(&gmux_data->interrupt_work);
+		return;
+	}
+
 	status = gmux_interrupt_get_status(gmux_data);
 	gmux_disable_interrupts(gmux_data);
 	pr_debug("Notify handler called: status %d\n", status);
 
 	gmux_clear_interrupts(gmux_data);
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 0);
 
 	if (status & GMUX_INTERRUPT_STATUS_POWER)
 		complete(&gmux_data->powerchange_done);
@@ -935,7 +1003,7 @@ static int gmux_resume(struct device *dev)
 	struct pnp_dev *pnp = to_pnp_dev(dev);
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 1);
 	gmux_write_switch_state(gmux_data);
 	if (gmux_data->power_state == VGA_SWITCHEROO_OFF)
 		gmux_set_discrete_state(gmux_data, gmux_data->power_state);
@@ -996,6 +1064,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 			pr_err("couldn't remap gmux mmio region");
 			goto err_release;
 		}
+		INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work);
 		goto get_version;
 	case APPLE_GMUX_TYPE_INDEXED:
 		gmux_data->config = &apple_gmux_index;
@@ -1115,7 +1184,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 
 	apple_gmux_data = gmux_data;
 	init_completion(&gmux_data->powerchange_done);
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
 	/*
@@ -1150,6 +1219,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 err_unmap:
 	if (gmux_data->iomem_base)
 		iounmap(gmux_data->iomem_base);
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO)
+		cancel_work_sync(&gmux_data->interrupt_work);
 err_release:
 	if (gmux_data->config->resource_type == IORESOURCE_MEM)
 		release_mem_region(gmux_data->iostart, gmux_data->iolen);
@@ -1168,6 +1239,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 	vga_switcheroo_unregister_handler();
 	pci_dev_put(gmux_data->discrete_pdev);
 	gmux_disable_interrupts(gmux_data);
+	cancel_work_sync(&gmux_data->interrupt_work);
 	if (gmux_data->gpe >= 0) {
 		acpi_disable_gpe(NULL, gmux_data->gpe);
 		acpi_remove_notify_handler(gmux_data->dhandle,
-- 
2.55.0

