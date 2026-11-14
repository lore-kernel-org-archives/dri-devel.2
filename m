Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B37606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IuAQjQzL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646BA10E2AC;
	Sat, 14 Nov 2026 16:06:00 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA2210E2AC
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:05:54 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so1403108c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672354; x=1795277154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rwXxXGuI8odA6JxbQFYflPGUh67I5rWeLK+lGKx8MRg=;
 b=IuAQjQzL8t1i8JOujGZOpuUkIu9dN8KDfyKLJvz8CHdInrwqRv350IILiyzqAxdwyF
 R4KFQFcO007mVsXPEHmGhlHAFX7T4i3c8CwXSJmJNoH8ixPx8Xy9iz/lOhqxLGwn3kwz
 7ixznOhbQGaJQirAWd4i6QA57CKVqEj/fG4bBBnPwalFwJk7pSiJxAkbJhJMJTXiVk6/
 8gs56/rMmE6YA6C8X7EoQ6IObEHo9Uyhj+PTQr45k28PpxmExYegzNK8nYM2o7ndpWYO
 o46t4t1Ti/elKtmDAbmqP7Ij/BBSKLL7s69fss9DN2WQq7uVzEzvBDXZr6EuHx9O3dg3
 dM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672354; x=1795277154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rwXxXGuI8odA6JxbQFYflPGUh67I5rWeLK+lGKx8MRg=;
 b=pLIo75cLFbyIOw96cpK+YHxIEW2P35zqt8QcrXSrsNqFXrkQgMrTsFnoJ+lLin/aVt
 L1JPygRnlDGoLA7tySKKbRTD64sjPloRx//Qc83J3e4kHES86ttYKDid/LybJRxTQToI
 tDuTO/xoTaMzBH9QdHyB5BYg1D6ZQGKJVHeydmYjnGUpMe+SoTXdwfvE7CF+dXr41CTT
 U7Lf6NGsqcnBsf1RxHTQO8x0eCCRKa7DED4Z19f5Kz8h/Azn/DpPkOsd9MjDAiJqgvfj
 /Px8rHxEnU4cC+9peEt7YzVkp9gJ2ms/QdIngGPdN2CpNXDQ3i92bq1dPx1mMmjer9Jd
 TK+g==
X-Forwarded-Encrypted: i=1;
 AL+hErEN+IIg6ry0YoZHBQOjQNiKlq/sub61guRKUD92uTmnwUoDflfGS8wbbdfTaZl2+z1c6UJqmrutWcw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/UZabKIOvGM2643vr7F9LJvR607WhggreQF4mfDkhoSWnrx1MC
 8kgX+WZ+WyvK3/p6exICLXFQeWGEb2fNXHpuzuaq9PfKWhN7racsceE=
X-Gm-Gg: AYBFou0r34sbv1joU9cTMN7WW97NoCjG0am8JWQ3nB+2CzrEBPdI581ZZR24F9DJ8X4
 9v/g3yInMAeZBwllAqlHwfUfeOoUW7Sg8EMzxaLyq7Pugb/gH2fdVIF1CciYvc+jp/AGaFII5mI
 8ajz1qrAmwP0crXNSvMetYSEpvCLzYzWvYLUNKBJnSl8QbiWOG/a+gho0Njy6HLqs/vy0MqkwCR
 CbXsmdM79Mp3NVbIaCCBecBwlvI3udKM86rzPRMalFgmpruTBKKijcAYR0D30p8Eeeberckya+Y
 QEGwysiWu4Bcb3tgUqqFwk42NRt1WC1sspnVWKujZHHQ4hKH0YNaN5Lj7fPZ3QE/ugFmkEnFmB8
 7t3/mqHnZL0rUVygy8XM31h4KS+h9eRJbeJQ5/ls6w1UHu2ybOlftonzeGsrvozc/Qh/igRPrq+
 t8C9myvFdKsHC61ZIeCtCIhTOUvKPT1KjDs4/E0QRxlENbpU6aTYaGv0c5rLAu2/5cdd/sS/Zdy
 78aJdFq0wMu9nDzzz1lYmIVVbFfHxB0jlUz+jn4ora9Lp75WciNZitrQt9b6y+oD3iQUA5P5pms
 8b2z9jACGC/sGmooY+uK8EYZODLBBOBo9Cfh1CAwO23r4P0ZfjnlLXUVtZOOpXcxHQ==
X-Received: by 2002:a05:7023:d0a:b0:1a4:fac9:aeee with SMTP id
 a92af1059eb24-1b50302aba6mr5983738c88.4.1794672353408; 
 Sat, 14 Nov 2026 08:05:53 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.114.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b505b5bf76sm13378548c88.10.2026.11.14.08.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:05:53 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>, Andre Eikmeyer <dev@deq.rocks>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: [PATCH v2 01/12] platform/apple-gmux: Fix power for MMIO systems
Date: Sat, 14 Nov 2026 11:03:48 -0500
Message-ID: <20261114160457.3034-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
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

Currently The dGPU on MMIO Systems, dies when we write the gmux values
to turn off the gpu.

On MMIO macs Using only gmux dosent work, instead we have to use PWRD
method + GMUX, which turns off the entire bridge, and completely messes the
pci config, so we can't use pci to traverse through it. we save the
entire bridge using ACPI addresses then we run PWRD(1) to turn off
the bridge, then we write gmux states, and resume we do the vice
versa, but here we dont need to retrain the link and write the
MMIO variable.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 159 ++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9c728ac4e..34e94f2b2 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -65,6 +65,10 @@ struct apple_gmux_data {
 
 	struct backlight_device *bdev;
 
+	/* power handling data */
+	struct pci_dev *discrete_pdev;
+	enum apple_gmux_type type;
+
 	/* switcheroo data */
 	acpi_handle dhandle;
 	int gpe;
@@ -502,23 +506,158 @@ static int gmux_switch_ddc(enum vga_switcheroo_client_id id)
 /**
  * DOC: Power control
  *
- * gmux is able to cut power to the discrete GPU. It automatically takes care
+ * gmux is able to cut power to the discrete GPU. On most
+ * Systems the gmux automatically takes care
  * of the correct sequence to tear down and bring up the power rails for
  * core voltage, VRAM and PCIe.
+ *
+ * But on MMIO systems, the standard gmux writes does not work instead we
+ * have to use a combination of ACPI and GMUX,
+ * and Using PWRD (the method that used in macOS to turn on/off the dGPU and its bridges),
+ * which turns off the entire bridge and messes up the PCI config,
+ * so we can't use pci_upstream_bridge to traverse
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
+	acpi_handle discrete_handle;
+	acpi_status status;
+	unsigned long long result;
+
+	if (!gmux_data->discrete_pdev)
+		return -ENODEV;
+
+	discrete_handle = ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
+	if (!discrete_handle)
+		return -ENODEV;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+			acpi_handle handle;
+			u16 vendor;
+			int i;
+
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 2);
+			msleep(100);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+
+			status = acpi_execute_simple_method(discrete_handle, "PWRD", 0);
+			if (ACPI_FAILURE(status))
+				return -EIO;
+			msleep(20);
+
+			if (gmux_save_restore_pci(NULL, "\\_SB_.PCI0.PEG0", 0, &handle))
+				return -EIO;
+
+			if (gmux_save_restore_pci(handle, "EGP0", 0, &handle))
+				return -EIO;
+
+			if (gmux_save_restore_pci(handle, "EGP1", 0, &handle))
+				return -EIO;
+
+			for (i = 0; i < 1000; i++) {
+				pci_read_config_word(gmux_data->discrete_pdev,
+							PCI_VENDOR_ID, &vendor);
+				if (vendor != 0xffff)
+					break;
+				msleep(1);
+			}
+			if (vendor == 0xffff)
+				return -ETIMEDOUT;
+
+			if (gmux_save_restore_pci(handle, "GFX0", 0, NULL))
+				return -EIO;
+
+			if (gmux_save_restore_pci(handle, "HDAU", 0, NULL))
+				return -EIO;
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		}
 		pr_debug("Discrete card powered up\n");
 	} else {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+			acpi_handle parent_handle = discrete_handle;
+			bool saved_hda = false;
+
+			/* If the power state was OFF, then we only do
+			 * PWRD and we do not save registers, as the
+			 * registers are already saved
+			 */
+			if (gmux_data->power_state == VGA_SWITCHEROO_OFF)
+				goto do_pwrd;
+
+			while (ACPI_SUCCESS(acpi_get_parent(parent_handle,
+							&parent_handle))) {
+				if (!saved_hda) {
+					if (!gmux_save_restore_pci(parent_handle,
+								"HDAU", true, NULL)) {
+						saved_hda = true;
+						pci_save_state(gmux_data->discrete_pdev);
+						gmux_data->discrete_pdev->current_state =
+								PCI_D3cold;
+					}
+				}
+				if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
+					break;
+			}
+do_pwrd:
+			status = acpi_execute_simple_method(discrete_handle, "PWRD", 1);
+			if (ACPI_FAILURE(status))
+				return -EIO;
+			msleep(20);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			mdelay(10);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		}
 		pr_debug("Discrete card powered down\n");
 	}
 
@@ -552,10 +691,14 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
 	else if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
 		 pdev->device == 0x0863)
 		return VGA_SWITCHEROO_IGD;
-	else
+	else {
+		if (!apple_gmux_data->discrete_pdev)
+			apple_gmux_data->discrete_pdev = pci_dev_get(pdev);
+
 		return VGA_SWITCHEROO_DIS;
-}
 
+	}
+}
 static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
 	.switchto = gmux_switchto,
 	.power_state = gmux_set_power_state,
@@ -803,6 +946,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (!gmux_data)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
+	gmux_data->type = type;
 
 	switch (type) {
 	case APPLE_GMUX_TYPE_MMIO:
@@ -993,6 +1137,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 
 	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
+	pci_dev_put(gmux_data->discrete_pdev);
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
 		acpi_disable_gpe(NULL, gmux_data->gpe);
-- 
2.55.0

