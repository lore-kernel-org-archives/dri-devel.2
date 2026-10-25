Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3785606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rEdqyE0w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0452110E4BF;
	Sun, 25 Oct 2026 04:01:48 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758B210E53F
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:01:41 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so3321700eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900900; x=1793505700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWT24l7xbjXALR1pzUf9E6S/BOyGgYFBc+LwoYkXDPA=;
 b=rEdqyE0wtm8SGRh9RcUy2E+uQI3h41F/IAHkQlsNAFnEoE2CybEYby+hjiywsbHqK8
 2O5DXIu5UvW877KraNVmEwAEqLMEdwer+OYnRQahv7wGjZygHoKYCByM2+wLlXTcCWN0
 KZbA8gV0TLtlNCvMaL9AjaB+J770m5N2qrG3rEw87d4pj0KshIBnzTE+ptBROEhZ9exN
 uxp7ZYMga85Y0HRxfzN6XAmEtl80nXeunQrWKK22+b3jVDN4+ZifCnzLg8uq2+bI6qqD
 OX5mwBZ6qvzz41mXNW6QWhhi9RLZwM9i2Ji4JHCiYFEvAFn1VgJqwEhaEPSDs6VMGs1z
 KkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900900; x=1793505700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWT24l7xbjXALR1pzUf9E6S/BOyGgYFBc+LwoYkXDPA=;
 b=ie+0Y2uDqnbC29mJcstBQqbHTCsV3Pr9Kl1ig6zQ9NPbVWKHv2HDHj/8kMOCPiKAoD
 oodWEpHKy2vXLdWg3HuaFVDUAfJuiPraAz0NJuoJwSG/ZU10aJw34QT9VbVW9GOygQTY
 4WgLhQrqrnST9wrTB/7UqIvWXEfVujItE6xmDmAdUSC3PKOa3dgq61K8099bQgwjd/HI
 ZgXAMAigW/liV188dWGPWn7im1oCRsODR0l3SUzRjIycJPQ9fPFngAvccUH82yFUoHCQ
 OhlOeaCK+lpYRZ/XDgQNzb0NhAY8hzRFT7DwBB4Z535VcrLmh0bXzDmcoZ+oyxCc8nLB
 GYtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7ZljW4ZA/VQmRryrF4t1+h7Nwbra/hee/qjTm+ETqlrh52MNmClMv4LqRAcGC2F9g5fdAfj9biGs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK8/3zyYbXXQlt4RoWjWTLINlnpL2CNYUntSdt7sqe3l/GPL9T1
 nLeIuqU6hmjZ82lmVZTSGEx7viyBXGD9/Vufk98jDluXvwi/qtlBeFE=
X-Gm-Gg: AYBFou3RrPsP7ENeHoRHMxg4hCkqnc5TIHnDqQX2+9f1LqvwkW9OC4IsuIM0YDexgW1
 5lg85N5+GxEhDUfVOTrujcddfgwNWMpNTOS2j91w2fAf5AzwH7AYJd0B1Qp7aX/XOMSLMEcQQss
 PcWXVAWxEb+/v1QBfbQ7skeW/AA2QCDUks3ooZi283wLx+2S/w3Pql0MIJw0W/QdRHLL0s90D9r
 zb/SuyALWHpLdA+o4j/KHu9mH7mdldiunrYKmSe/gs4fApidoELq8avHbi44DxsLFmHb5zVtIS9
 YKdsS6KmOM0+jAwpIQLHRztZfeNPTy0cCusN5Sv2Fw+TLVyctxP67s66XaH0MDIor0RfTlEbIrt
 JiQ6D5hhzpNdytP0QYtee3l97PeCSThmMhQuEYsgcGYACqx74ZxveTVJhQMTg2G1WOLWmAnHyHP
 e29/9WjMlnwlC8Po+YO0rKvpwZqkSTbwQHz27Fpc4jSbLT0B4IgKBV+pODWUJRhbL9vFDNqy9SE
 11sao+nb4SX7+hLT7xJXo/XKZZS+XR3sJ4pJnZjzw12iDezKVL1g9qUUG95KT2KXhnW8rsdFTdz
 feKLQeefpyjSaHU=
X-Received: by 2002:a05:701b:4212:20b0:19d:6484:869f with SMTP id
 a92af1059eb24-19d648486dbmr1491542c88.7.1792900900042; 
 Sat, 24 Oct 2026 21:01:40 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:01:39 -0700 (PDT)
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
Subject: [PATCH 01/13] platform/apple-gmux: Fix power for MMIO systems
Date: Sat, 24 Oct 2026 23:59:37 -0400
Message-ID: <20261025040046.1602-2-atharvatiwarilinuxdev@gmail.com>
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

Currently The dGPU on MMIO Systems, dies when we write the gmux values
to turn off the gpu.

On most systems we can just write PWG1 (link-training method) and the
dGPU comes up, then we write a MMIO variable, and run PWG3
(link-retraing method), to stablize the dGPU.

But on 16,1 and 16,4 this dosent work, instead we have to use PWRD
method, which turns off the entire bridge, and completely messes the
pci config, so we can't use pci to traverse through it. we save the
entire bridge using ACPI addresses then we run PWRD(1) to turn off
the bridge, then we write gmux states, and resume we do the vice
versa, but here we dont need to retrain the link and write the
MMIO variable.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 177 ++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9c728ac4e..4e8786a5e 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/debugfs.h>
+#include <linux/dmi.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -65,6 +66,11 @@ struct apple_gmux_data {
 
 	struct backlight_device *bdev;
 
+	/* power handling data */
+	struct pci_dev *discrete_pdev;
+	bool uses_pwrd;
+	enum apple_gmux_type type;
+
 	/* switcheroo data */
 	acpi_handle dhandle;
 	int gpe;
@@ -502,23 +508,171 @@ static int gmux_switch_ddc(enum vga_switcheroo_client_id id)
 /**
  * DOC: Power control
  *
- * gmux is able to cut power to the discrete GPU. It automatically takes care
+ * gmux is able to cut power to the discrete GPU. On most
+ * Systems the gmux automatically takes care
  * of the correct sequence to tear down and bring up the power rails for
  * core voltage, VRAM and PCIe.
+ *
+ * But on most MMIO Systems, we have to PCIE link-train the discrete GPU after
+ * power on, we can do that using PWG1 and then to stablize we write to
+ * 0x8C340 and then link-train the PCIE link again (this time using PWG3).
+ *
+ * But on MacBookPro16,1 and MacBookPro16,4, the PWG1 method does not work
+ * instead we have to use PWRD method, which turns off the entire bridge and
+ * messes up the PCI config, so we can't use pci_upstream_bridge to traverse
+ * through the bridge, so we use ACPI addresses to save/restore bridges.
+ *
+ * NOTE: Communication to these bridges (not the dGPU/HDA) in any form
+ * when the bridge is off, will result in CPU CATERR.
  */
 
+static int gmux_save_restore_pci(acpi_handle parent_handle, const char *name,
+				bool save, acpi_handle *out_handle)
+{
+	acpi_status status;
+	acpi_handle handle;
+	struct acpi_device *adev;
+	struct device *dev;
+	struct pci_dev *pdev;
+
+	if (name) {
+		status = acpi_get_handle(parent_handle, name, &handle);
+		if (ACPI_FAILURE(status))
+			return -EIO;
+
+		if (out_handle)
+			*out_handle = handle;
+	} else
+		handle = parent_handle;
+
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
+		return -EIO;
+
+	dev = acpi_get_first_physical_node(adev);
+	if (!dev || !dev_is_pci(dev))
+		return -EIO;
+
+	pdev = to_pci_dev(dev);
+
+	if (save) {
+		pci_save_state(pdev);
+		pdev->current_state = PCI_D3cold;
+	} else {
+		pdev->current_state = PCI_D0;
+		pci_restore_state(pdev);
+	}
+	return 0;
+}
+
 static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
 				   enum vga_switcheroo_state state)
 {
 	reinit_completion(&gmux_data->powerchange_done);
+	acpi_handle discrete_handle = ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
+	acpi_status status;
+	unsigned long long result;
+
+	if (!discrete_handle)
+		return -ENODEV;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+			u16 vendor;
+			int i;
+
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 2);
+			msleep(100);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+
+			if (gmux_data->uses_pwrd) {
+				acpi_handle handle;
+
+				status = acpi_execute_simple_method(discrete_handle, "PWRD", 0);
+				if (ACPI_FAILURE(status))
+					return -EIO;
+
+				if (gmux_save_restore_pci(NULL, "\\_SB_.PCI0.PEG0", 0, &handle))
+					return -EIO;
+
+				if (gmux_save_restore_pci(handle, "EGP0", 0, &handle))
+					return -EIO;
+
+				if (gmux_save_restore_pci(handle, "EGP1", 0, &handle))
+					return -EIO;
+
+				if (gmux_save_restore_pci(handle, "GFX0", 0, NULL))
+					return -EIO;
+
+				if (gmux_save_restore_pci(handle, "HDAU", 0, NULL))
+					return -EIO;
+			} else {
+				status = acpi_evaluate_integer(discrete_handle,
+							"PWG1", NULL, &result);
+				if (ACPI_FAILURE(status) || result)
+					return -EIO;
+			}
+
+			for (i = 0; i < 1000; i++) {
+				pci_read_config_word(gmux_data->discrete_pdev,
+						     PCI_VENDOR_ID, &vendor);
+				if (vendor != 0xffff)
+					break;
+				msleep(1);
+			}
+			if (vendor == 0xffff)
+				return -ETIMEDOUT;
+
+			if (!gmux_data->uses_pwrd) {
+				void __iomem *bar = pci_iomap(gmux_data->discrete_pdev, 0, 0);
+
+				if (!bar)
+					return -ENOMEM;
+
+				iowrite32(ioread32(bar + 0x8c340) & 0x3fffffff, bar + 0x8c340);
+				pci_iounmap(gmux_data->discrete_pdev, bar);
+
+				status = acpi_evaluate_integer(discrete_handle,
+							"PWG3", NULL, &result);
+				if (ACPI_FAILURE(status) || result)
+					return -EIO;
+			}
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		}
 		pr_debug("Discrete card powered up\n");
 	} else {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+			if (gmux_data->uses_pwrd) {
+				acpi_handle parent_handle = discrete_handle;
+				bool saved_hda = false;
+
+				while (ACPI_SUCCESS(acpi_get_parent(parent_handle,
+								&parent_handle))) {
+					if (!saved_hda) {
+						if (!gmux_save_restore_pci(parent_handle,
+									"HDAU", true, NULL)) {
+							saved_hda = true;
+							pci_save_state(gmux_data->discrete_pdev);
+							gmux_data->discrete_pdev->current_state =
+									PCI_D3cold;
+						}
+					}
+					if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
+						break;
+				}
+				status = acpi_execute_simple_method(discrete_handle, "PWRD", 1);
+				if (ACPI_FAILURE(status))
+					return -EIO;
+			}
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			mdelay(10);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		}
 		pr_debug("Discrete card powered down\n");
 	}
 
@@ -552,10 +706,15 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
 	else if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
 		 pdev->device == 0x0863)
 		return VGA_SWITCHEROO_IGD;
-	else
+	else {
+		if (apple_gmux_data->discrete_pdev != pdev) {
+			pci_dev_put(apple_gmux_data->discrete_pdev);
+			apple_gmux_data->discrete_pdev = pci_dev_get(pdev);
+		}
 		return VGA_SWITCHEROO_DIS;
-}
 
+	}
+}
 static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
 	.switchto = gmux_switchto,
 	.power_state = gmux_set_power_state,
@@ -803,6 +962,9 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (!gmux_data)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
+	gmux_data->type = type;
+	gmux_data->uses_pwrd = (dmi_match(DMI_PRODUCT_NAME, "MacBookPro16,1") ||
+		 dmi_match(DMI_PRODUCT_NAME, "MacBookPro16,4"));
 
 	switch (type) {
 	case APPLE_GMUX_TYPE_MMIO:
@@ -993,6 +1155,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 
 	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
+	pci_dev_put(gmux_data->discrete_pdev);
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
 		acpi_disable_gpe(NULL, gmux_data->gpe);
-- 
2.55.0

