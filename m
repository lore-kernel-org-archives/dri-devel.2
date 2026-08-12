Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B2BC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660B010EFA0;
	Wed, 12 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="AYMyJcVO";
	dkim-atps=neutral
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E33B10EF9F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:28:07 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1786537334;
 bh=MTdYm4b5/2+t61MrfV1y6CcwLblkQbpBbXWHOYayEXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AYMyJcVOWJKfn2GI/VkuwdfjX/RyCU96NaSmEWAIgmq7SAygDtUB2Ug0VxwYIJwPL
 OElz5ebD0CKIE0FLwANJEiGoCz4rfqKzOthSIHh+8RtdxuJVi6DS09YHg2Ut+8LAa7
 3Ag53Y3+gQ6qjIB6Wt7Axt7IMeHmQvi/xYtw6uI0IHTO2zozbzygGED+OhMIiSYSCz
 wnrQIajBxKXtYcZtU+J38x1+MEAs0x2Se4meU2bkMEGwmDfG4fhZR17ie5RziCevZn
 kpM32TJraGVC59MJ4VRzMpHeYacpNtiGJ1lGPeQYYNpb+OVHmi6fwXBrrLmLxHhzGr
 DJxDBGc/BKPbQ==
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH 1/3] platform/x86: apple-gmux: add MacBookPro15,
 1 dGPU power sequence
Date: Wed, 12 Aug 2026 14:22:04 +0200
Message-ID: <20260812122206.193680-2-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812122206.193680-1-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
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

From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Hello everyone,

We managed to make hybrid graphics work on the MacBook Pro 15,1 with
iGPU as primary and dGPU with DynOff/DynPwr for offloading using
DRI_PRIME. This needed a few changes in apple-gmux, amdgpu and ALSA.

The discrete GPU on the MacBookPro15,1 did not return with the original
GMUX power-on sequence. The PCI configuration space remained inaccessible
and runtime PM could not provide usable hybrid graphics with the iGPU
as primary.

The firmware PWG1 and PWG3 link methods are evaluated around the GMUX
transition, and power-on completes after PCI configuration space becomes
accessible. The sequence is limited to the MacBookPro15,1 while every
other model is unaffected. Unfortunately, we were not able to make
MacBookPro16,1 and 16,4 dGPUs return from D3cold yet. But we believe
this series will also serve as a good base for upcoming fixes.

This patch was tested on both the 2018 and 2019 MacBookPro15,1 revisions
with the integrated GPU as primary. The discrete GPU transitions between
DynOff and DynPwr, and also external display work across the transitions.
When an external display is connected, the dGPU will turn on automatically
and also turn off again when disconnecting.

Thank you for your time and consideration.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 84 ++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9c728ac..9154348 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/debugfs.h>
+#include <linux/dmi.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -74,6 +75,8 @@ struct apple_gmux_data {
 	enum vga_switcheroo_client_id switch_state_external;
 	enum vga_switcheroo_state power_state;
 	struct completion powerchange_done;
+	struct pci_dev *discrete_pdev;
+	bool use_pwg_power_sequence;
 
 	/* debugfs data */
 	u8 selected_port;
@@ -82,6 +85,34 @@ struct apple_gmux_data {
 
 static struct apple_gmux_data *apple_gmux_data;
 
+static int gmux_call_pwg(struct apple_gmux_data *gmux_data,
+			 const char *method)
+{
+	acpi_handle handle = ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
+	unsigned long long result;
+	acpi_status status;
+
+	if (!handle)
+		return -ENODEV;
+
+	status = acpi_evaluate_integer(handle, (acpi_string)method, NULL,
+				       &result);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&gmux_data->discrete_pdev->dev,
+			"failed to evaluate %s: %s\n", method,
+			acpi_format_exception(status));
+		return -EIO;
+	}
+
+	if (result) {
+		dev_err(&gmux_data->discrete_pdev->dev,
+			"%s failed: %llu\n", method, result);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 struct apple_gmux_config {
 	u8 (*read8)(struct apple_gmux_data *gmux_data, int port);
 	void (*write8)(struct apple_gmux_data *gmux_data, int port, u8 val);
@@ -510,14 +541,49 @@ static int gmux_switch_ddc(enum vga_switcheroo_client_id id)
 static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
 				   enum vga_switcheroo_state state)
 {
+	int ret;
+
 	reinit_completion(&gmux_data->powerchange_done);
 
 	if (state == VGA_SWITCHEROO_ON) {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		if (gmux_data->use_pwg_power_sequence &&
+		    gmux_data->discrete_pdev) {
+			u16 vendor;
+			int i;
+
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 2);
+			msleep(100);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+
+			ret = gmux_call_pwg(gmux_data, "PWG1");
+			if (ret)
+				return ret;
+
+			for (i = 0; i < 1000; i++) {
+				pci_read_config_word(gmux_data->discrete_pdev,
+						     PCI_VENDOR_ID, &vendor);
+				if (vendor != 0xffff)
+					break;
+				usleep_range(1000, 2000);
+			}
+			if (vendor == 0xffff) {
+				dev_err(&gmux_data->discrete_pdev->dev,
+					"timed out waiting for PCI config space\n");
+				return -ETIMEDOUT;
+			}
+
+			ret = gmux_call_pwg(gmux_data, "PWG3");
+			if (ret)
+				return ret;
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		}
 		pr_debug("Discrete card powered up\n");
 	} else {
 		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+		if (gmux_data->use_pwg_power_sequence)
+			usleep_range(10000, 11000);
 		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
 		pr_debug("Discrete card powered down\n");
 	}
@@ -549,11 +615,14 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
 		return VGA_SWITCHEROO_IGD;
-	else if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
-		 pdev->device == 0x0863)
+	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA && pdev->device == 0x0863)
 		return VGA_SWITCHEROO_IGD;
-	else
-		return VGA_SWITCHEROO_DIS;
+
+	if (apple_gmux_data->use_pwg_power_sequence &&
+	    !apple_gmux_data->discrete_pdev)
+		apple_gmux_data->discrete_pdev = pci_dev_get(pdev);
+
+	return VGA_SWITCHEROO_DIS;
 }
 
 static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
@@ -803,6 +872,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (!gmux_data)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
+	gmux_data->use_pwg_power_sequence = type == APPLE_GMUX_TYPE_MMIO &&
+		dmi_match(DMI_PRODUCT_NAME, "MacBookPro15,1");
 
 	switch (type) {
 	case APPLE_GMUX_TYPE_MMIO:
@@ -1009,6 +1080,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 	} else
 		release_region(gmux_data->iostart, gmux_data->iolen);
 	apple_gmux_data = NULL;
+	pci_dev_put(gmux_data->discrete_pdev);
 	kfree(gmux_data);
 }
 
-- 
2.55.0
