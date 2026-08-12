Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03609C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1CB10E428;
	Wed, 12 Aug 2026 14:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="wSIM/Qx5";
	dkim-atps=neutral
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de
 [91.216.248.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EEFF10E428;
 Wed, 12 Aug 2026 14:42:32 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1786545750;
 bh=r//8AyeAQ7KMt3PVWfbj/mhaVNoRT8KhAZ4HUx1fBS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wSIM/Qx5RJLVkUmoOODyLBDgbY+3u4PG/2VfholkhJgrO6VzWftBZj6noQueBlO+W
 xhoCLKla177vsYHZkTBwFrtS8KaooqhtGHNAxoClEQ+I08huKAsoJX9AMx5oE+02TI
 3DTu6jAE4H6WmX9+gNbYBUXtf0wsayMFuf6R0WmsPXLKPzdD0l/ImfcQOp5XPLkEna
 WTmVmenj8rGGtARWa4mqiuLszol/aaqah4TIvb3it9HFYGbCiZPpU5Ebv4QHrxaciE
 Ec2EMTPEUTzUtLDezTFICRpny4/YQG9AWAjjsEQ+yq9qM+oJzpPRVcldKIbRoMRRvf
 ims6NIyM6yVfA==
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v2 1/3] platform/x86: apple-gmux: add MacBookPro15,
 1 dGPU power sequence
Date: Wed, 12 Aug 2026 16:42:19 +0200
Message-ID: <20260812144221.35877-2-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812144221.35877-1-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812144221.35877-1-dev@deq.rocks>
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

The discrete GPU on the MacBookPro15,1 does not return after the legacy
GMUX power-on sequence. PCI configuration space remains inaccessible, so
runtime PM cannot provide usable hybrid graphics with the integrated GPU
as primary.

Evaluate the firmware PWG1 and PWG3 link methods around the GMUX
transition and wait for PCI configuration space before completing power-on.
Keep the sequence limited to the MacBookPro15,1 and retain the existing
path for every other model.

This was tested on both the 2018 and 2019 MacBookPro15,1 revisions with the
integrated GPU as primary. The discrete GPU transitions between DynOff and
DynPwr, and external displays work across the transitions.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 78 ++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9c728ac..16ccf15 100644
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
@@ -82,6 +85,26 @@ struct apple_gmux_data {
 
 static struct apple_gmux_data *apple_gmux_data;
 
+static int gmux_call_pwg(struct apple_gmux_data *gmux_data,
+			 const char *method)
+{
+	acpi_handle handle = ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
+	acpi_status status;
+
+	if (!handle)
+		return -ENODEV;
+
+	status = acpi_evaluate_object(handle, (acpi_string)method, NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&gmux_data->discrete_pdev->dev,
+			"failed to evaluate %s: %s\n", method,
+			acpi_format_exception(status));
+		return -EIO;
+	}
+
+	return 0;
+}
+
 struct apple_gmux_config {
 	u8 (*read8)(struct apple_gmux_data *gmux_data, int port);
 	void (*write8)(struct apple_gmux_data *gmux_data, int port, u8 val);
@@ -510,14 +533,49 @@ static int gmux_switch_ddc(enum vga_switcheroo_client_id id)
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
@@ -549,11 +607,16 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
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
+	    apple_gmux_data->discrete_pdev != pdev) {
+		pci_dev_put(apple_gmux_data->discrete_pdev);
+		apple_gmux_data->discrete_pdev = pci_dev_get(pdev);
+	}
+
+	return VGA_SWITCHEROO_DIS;
 }
 
 static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
@@ -803,6 +866,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (!gmux_data)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
+	gmux_data->use_pwg_power_sequence = type == APPLE_GMUX_TYPE_MMIO &&
+		dmi_match(DMI_PRODUCT_NAME, "MacBookPro15,1");
 
 	switch (type) {
 	case APPLE_GMUX_TYPE_MMIO:
@@ -1009,6 +1074,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 	} else
 		release_region(gmux_data->iostart, gmux_data->iolen);
 	apple_gmux_data = NULL;
+	pci_dev_put(gmux_data->discrete_pdev);
 	kfree(gmux_data);
 }
 
-- 
2.55.0

