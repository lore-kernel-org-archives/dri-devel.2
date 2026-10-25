Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA4606A31B
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pOMZPskZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9333B10E55C;
	Sun, 25 Oct 2026 04:02:00 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CD510E55D
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:01:54 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1931ff67a29so4176851c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900914; x=1793505714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gibUibvdgP83xG+GS9VEMDqCdWat6T2Cw1tMDL5UgY8=;
 b=pOMZPskZ8ofwJ/JhiY9dz0BfGk5tYTd6IzoRtBfKUb6xxQJLj9bU80YDrxptz2vDD+
 HDFoZsHawHupujYqAzDXBpt5xzybiuQ8h/OJ6uQcghDd44kCyg6V9OoxY683cN+Eh+xs
 cZ5UNVfr4tBG269fiq5p7KiHKJhVECoTpFmJDc7/bxXM+c9QX/2BeJTDftJRc3TbBd+c
 HgSddyeCrXiXHqtZEjUDFiC61fFPsPRCCw6u7nC9Wx6fYsU4AWjtATIe8GQgatU4EFxx
 gWPew1UYS3nxc1R1M4dsvgaDUdsWxOH2xqCkX/EprCnGZYv20JsSKCdTYWsKBlZZdnEF
 QcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900914; x=1793505714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gibUibvdgP83xG+GS9VEMDqCdWat6T2Cw1tMDL5UgY8=;
 b=ZuYzU+AcGrgDW+0enk1PSO1kkC4Tms61uSpS91TifCUy+QDghr6hhXSG5xbihRUi4w
 Qc1dXlhE1hxzFIj+ScBWiNj+WW+77X0XNl/vzkZzwm606f/ai5MBPp9vLgtUK2W98LKf
 UbByWcF9H9iJ8dvfxf79JjG72hZeXN8Yuveanl5Ngj3u+8YcDEn9twMmyh46RMrZ8iAN
 c7xSVhiN9pw5J2ThiV5p7NDGYn/MuU9B02FNXzP4UUPvl/OwsE1XGh9neQugUeVT2L4c
 ADhr05RLkEszZ//UVyxGEIzghTTldSd/4abu5yvYGmJfP2X2vmaSs1S14BgCM2NZJFQ2
 4oqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDHgcXhW2DmnsJ7bwQbY4bKqf8KhPxWK6uohMIGzbMR4AYE7bcoTgWBYB1db5F3ciuZWblekXGI2Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJins+ZRCu6on0ekinLI3lizY3pwPiLgZazSQUvqRVGrwlvXSCd
 0nIY372PTOaDUev6pP+yA6nI95Q67PgB0fPu99IB+45531AiqfS5QhY=
X-Gm-Gg: AYBFou21ce8MkmsM9f0tsVWviBf8xiMNi6OlCHSrmLv4fp+Yo9r7uD28NdbdnAJU8BQ
 iqbeyHxUbHxdwvAEozo1woYp7eXkoIMAYsXRoloS77f8LLi8YGne5DyM7QuQsCQ38UaK/X3OOtp
 G8B3rFowZVvQ2b0l5sjf4XHkcOaWArAtZwkhMtxYttWpdvyNu98JvLUVXyfMYtYl3M7szokeREm
 jC9i1qriyw8u5UU5Z9duqcZzxCnSIwCnN8PFliSmLbp3hXh0nt/ahbwqfPoExSbhbwypZpdF+MC
 NHF7d9wQqVZl10pJEBpP/h9Z77Uj3qwqHmczlffHd8nIJRNujeRQJAYVaX55qsbRuQPCCWTQol0
 0RWXuG+cZWuSmsG11/crBiPNIgaUbQQBanyhtA3elEmwiAjq3h7jcgIr4HZU25bh6kwtm8zCjmN
 +457OiQ6Y56N9LOX9XWFW7HBzc5hjpfI8Xa7w+1ahrd3D8h1xGB8P3LVKTbHYDWT6vkXy2Ebvr+
 2j/mqm9x2lhkB26SfX0fwX7cirhC9jUxuSZGg9LH6g653Yqtajm6HfvluHEmLqtYtFWhuXrB6Vg
 nYomCa4sCso0jQk=
X-Received: by 2002:a05:701b:2501:b0:17b:fed6:7449 with SMTP id
 a92af1059eb24-19937abc522mr4807131c88.47.1792900913608; 
 Sat, 24 Oct 2026 21:01:53 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:01:53 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific amd
 devices
Date: Sat, 24 Oct 2026 23:59:38 -0400
Message-ID: <20261025040046.1602-3-atharvatiwarilinuxdev@gmail.com>
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

As mentioned in the previous commit, PWRD turns off the entire
bridge, and if we read/write anything to the config space
or the PCIE space when the bridge is dead, the CPU CATERR's,
so to avoid interaction when the bridge is dead,
we remove pcieport support for the bridges, and we restrict
access to those bridges when the bridge is dead.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/pci/fixup.c       | 30 ++++++++++++++++++++++++++++++
 drivers/pci/access.c       | 18 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c |  2 +-
 include/linux/pci.h        |  7 +++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 795d81c7a..66829941e 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1094,6 +1094,35 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
 
+static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{}
+};
+
+static void quirk_disable_pcie_port(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream = pdev;
+
+	if (dmi_check_system(quirk_disable_pcie_port_dmi_table)) {
+		while ((upstream = pci_upstream_bridge(upstream))) {
+			upstream->no_pcie_port = 1;
+			upstream->ignore_access_d3 = 1;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_port);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
@@ -1179,4 +1208,5 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
+
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b..5e9513067 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -559,6 +559,9 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev)) {
 		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -569,6 +572,9 @@ EXPORT_SYMBOL(pci_read_config_byte);
 
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev)) {
 		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -580,6 +586,9 @@ EXPORT_SYMBOL(pci_read_config_word);
 int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev)) {
 		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -590,6 +599,9 @@ EXPORT_SYMBOL(pci_read_config_dword);
 
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
@@ -598,6 +610,9 @@ EXPORT_SYMBOL(pci_write_config_byte);
 
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
@@ -607,6 +622,9 @@ EXPORT_SYMBOL(pci_write_config_word);
 int pci_write_config_dword(const struct pci_dev *dev, int where,
 					 u32 val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a9cbfc1d2..d2f19e566 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	int status;
 
-	if (!pci_is_pcie(dev) ||
+	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
 	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (type != PCI_EXP_TYPE_UPSTREAM) &&
 	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..8835b1c82 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -420,6 +420,8 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	no_pcie_port:1; /* PCIE Port driver is forbidden */
+	unsigned int	ignore_access_d3:1;	/* Ignore access when device is in D3Cold */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
@@ -2747,6 +2749,11 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
 }
 
+static inline bool pci_dev_ignore_access(const struct pci_dev *dev)
+{
+	return dev->ignore_access_d3 && dev->current_state == PCI_D3cold;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
-- 
2.55.0

