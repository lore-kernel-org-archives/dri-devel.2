Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE47C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E4A10F39E;
	Fri, 21 Aug 2026 20:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MUcn5AgH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA13B10E33F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787342780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Edr5cAtYcXCdnLa7oLzVihOqQYUUfcaDCBdJd9wwpE=;
 b=MUcn5AgHgiUsds/Y3vn3z9uUHhptOYsvpWZ1wR9b9u3XApOh8ESYAPkZSMH1mpBo4OOMG3
 oeMMI2j9GLM8vbtJHdKEEmKT3ZiyjVvwraDx4c7UMjnAprVJV/YXB5bbsiwC2fMJP8Ew4t
 otuzsx8baWj92rFnOkpGDF3GWstkjLQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-A8Al9uYjPEyH8ezlI4yzgQ-1; Fri,
 21 Aug 2026 16:06:15 -0400
X-MC-Unique: A8Al9uYjPEyH8ezlI4yzgQ-1
X-Mimecast-MFC-AGG-ID: A8Al9uYjPEyH8ezlI4yzgQ_1787342773
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28AEB1956073; Fri, 21 Aug 2026 20:06:13 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 702DA426; Fri, 21 Aug 2026 20:06:11 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Ryan Brue <ryanbrue.dev@gmail.com>,
 stable@vger.kernel.org, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and
 16AHP9 Nvidia GPUs
Date: Fri, 21 Aug 2026 16:04:51 -0400
Message-ID: <20260821200607.621341-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 5dSFzF75nl4G76oCbPQeVyrlsq3DjPGykogWLee3BCE_1787342773
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
GPU enters D3Cold. This means that every time the GPU is runtime suspended,
ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
the GPU. Once it falls asleep again, the cycle repeats.

See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905

Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
nova as well, and it even seems possible for this to happen without any
driver loaded.

This seems to simply be a bug. Luckily, there is nothing that we actually
need ACPI wakeup events for on the GPU. Events such as display connector
hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
affected by this quirk.

Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905

---
V2:
* Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
* Check if parent_adev is NULL (could happen if booted with acpi=off), just
  consider it a no-op if it is.
* Base the patch off Linux master instead, I based it off drm-misc-next by
  mistake because I'm too used to working on DRM drivers :).

 drivers/pci/quirks.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..b6d8ba5e4c2a6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6165,6 +6165,85 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
 
+#ifdef CONFIG_ACPI
+#ifdef CONFIG_DMI
+static const struct dmi_system_id nvidia_dgpu_broken_gpe_quirk_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "16APH8"),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "16AHP9"),
+		},
+	},
+	{}
+};
+
+/*
+ * On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
+ * firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
+ * GPU enters D3Cold. This means that every time the GPU is runtime suspended,
+ * ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
+ * the GPU. Once it falls asleep again, the cycle repeats.
+ *
+ * See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
+ *
+ * Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
+ * nova as well, and it even seems possible for this to happen without any
+ * driver loaded.
+ *
+ * This seems to simply be a bug. Luckily, there is nothing that we actually
+ * need ACPI wakeup events for on the GPU. Events such as display connector
+ * hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
+ * affected by this quirk.
+ *
+ * So, workaround this by disabling wakeup events for the parent PCIe port of
+ * the GPU.
+ */
+static void quirk_nvidia_dgpu_broken_gpe(struct pci_dev *pdev)
+{
+	struct acpi_device *parent_adev;
+	struct device *parent_dev;
+	int ret;
+
+	/* Just to be extra safe and make sure we don't try this on an eGPU */
+	if (pci_is_thunderbolt_attached(pdev))
+		return;
+
+	ret = dmi_check_system(nvidia_dgpu_broken_gpe_quirk_table);
+	if (ret == 0)
+		return;
+
+	pci_info(pdev, FW_BUG "GPU PCIe port has broken wakeup events, disabling\n");
+
+	parent_dev = pci_physfn(pdev)->dev.parent;
+	if (!parent_dev) {
+		pci_err(pdev,
+			"Can't find PCIe parent? Your Nvidia GPU will have broken runtime PM\n");
+		return;
+	}
+
+	parent_adev = ACPI_COMPANION(parent_dev);
+	if (!parent_adev) /* No ACPI? That means no GPE, and nothing to do here. */
+		return;
+
+	/* The spurious GPEs will be sent from the ACPI device for the PCIe port this GPU is
+	 * connected to, so remove our PM notifier to turn them into a no-op.
+	 */
+	ret = acpi_remove_pm_notifier(parent_adev);
+	if (ACPI_FAILURE(ret))
+		pci_err(pdev, "Removing PM notifier failed: %d\n", ret);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x28e0,
+			      PCI_CLASS_DISPLAY_VGA, 8,
+			      quirk_nvidia_dgpu_broken_gpe);
+#endif
+#endif
+
 /*
  * Device [1b21:2142]
  * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.

base-commit: 2be02a7c996aa733bb36e29e07715621b0de9736
-- 
2.55.0

