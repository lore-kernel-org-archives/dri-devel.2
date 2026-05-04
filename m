Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14BBCD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2A310E985;
	Tue,  5 May 2026 07:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Mv47BYqL";
	dkim-atps=neutral
X-Greylist: delayed 389 seconds by postgrey-1.36 at gabe;
 Mon, 04 May 2026 07:01:39 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F6810E38A
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gk
 yJeK0xh7ft8l0KrjIr5L7TmwFz7SabyNUN7O8c/TM=; b=Mv47BYqLBTe08xKFOb
 sclDIReMVsNlzMuxuwQIXeKPPlaFoMMKxRC+kmPlE79DXuLqbph6XYt4mySRkFm0
 4yVqnDBCAJxXGmaQKG9vfpMO1+rAurSIHZ782kW0dRQIXOjO26HxuJJeEyHLnxlP
 PKZh7tj7b/h8gnUovfe20wkn4=
Received: from wmy.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3GtGyQvhp0AomDQ--.49192S2; 
 Mon, 04 May 2026 14:54:54 +0800 (CST)
From: w15303746062@163.com
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-pci@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] char: agp: amd64 - fix null-ptr-deref in amd64_fetch_size and
 related functions
Date: Mon,  4 May 2026 14:54:41 +0800
Message-Id: <20260504065441.99033-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3GtGyQvhp0AomDQ--.49192S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1UCw1UJFyrZF1fur1UAwb_yoW7GrWxpF
 4fZFZxtr4UGr4agF40qa1DCrn5ArZ7XFy5JrZrCw1F9a1vyry8tr1ftFy5ZrWfCFWDXF43
 Can8tF4kGFyqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFg4fUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAB5YPGn4Qr7DNwAA3j
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A NULL pointer dereference vulnerability was identified in the AMD64 AGP
driver (amd64-agp) during driver initialization and aperture size fetching.

When the `amd64_agp` module is loaded on a system without a physical AMD
Northbridge (e.g., in a QEMU/KVM virtualized environment with a simulated
AMD 8151 AGP bridge), the underlying hardware query `node_to_amd_nb(0)`
returns NULL.

In `amd64_fetch_size()`, the code previously attempted to unconditionally
dereference the `misc` member of the returned pointer:
    `dev = node_to_amd_nb(0)->misc;`

Since `node_to_amd_nb(0)` can return NULL (either due to missing hardware
or when CONFIG_AMD_NB is disabled), this direct dereference results in a
General Protection Fault (GPF) and a subsequent kernel panic, as caught
by KASAN.

Fix this by introducing proper sanity checks. Before accessing the `misc`
pointer, explicitly verify that the pointer returned by `node_to_amd_nb()`
is not NULL.

Furthermore, to prevent similar crashes, this patch sweeps the entire
driver and applies the same safeguard to all other functions that iterate
over or directly access the AMD Northbridge descriptors, including
`amd_8151_configure()`, `amd64_cleanup()`, `cache_nbs()`, `uli_agp_init()`,
and `nforce3_agp_init()`.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/char/agp/amd64-agp.c | 50 ++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 2505df1f4e69..7bbadfc74ffe 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -121,14 +121,16 @@ static struct aper_size_info_32 amd64_aperture_sizes[7] =
 static int amd64_fetch_size(void)
 {
 	struct pci_dev *dev;
+	struct amd_northbridge *nb;
 	int i;
 	u32 temp;
 	struct aper_size_info_32 *values;
 
-	dev = node_to_amd_nb(0)->misc;
-	if (dev==NULL)
+	nb = node_to_amd_nb(0);
+	if (!nb || !nb->misc)
 		return 0;
 
+	dev = nb->misc;
 	pci_read_config_dword(dev, AMD64_GARTAPERTURECTL, &temp);
 	temp = (temp & 0xe);
 	values = A_SIZE_32(amd64_aperture_sizes);
@@ -187,8 +189,12 @@ static int amd_8151_configure(void)
 
 	/* Configure AGP regs in each x86-64 host bridge. */
 	for (i = 0; i < amd_nb_num(); i++) {
-		agp_bridge->gart_bus_addr =
-			amd64_configure(node_to_amd_nb(i)->misc, gatt_bus);
+		struct amd_northbridge *nb = node_to_amd_nb(i);
+
+		if (!nb || !nb->misc)
+			continue;
+
+		agp_bridge->gart_bus_addr = amd64_configure(nb->misc, gatt_bus);
 	}
 	amd_flush_garts();
 	return 0;
@@ -204,7 +210,13 @@ static void amd64_cleanup(void)
 		return;
 
 	for (i = 0; i < amd_nb_num(); i++) {
-		struct pci_dev *dev = node_to_amd_nb(i)->misc;
+		struct amd_northbridge *nb = node_to_amd_nb(i);
+		struct pci_dev *dev;
+
+		if (!nb || !nb->misc)
+			continue;
+
+		dev = nb->misc;
 		/* disable gart translation */
 		pci_read_config_dword(dev, AMD64_GARTAPERTURECTL, &tmp);
 		tmp &= ~GARTEN;
@@ -335,7 +347,13 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 
 	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
-		struct pci_dev *dev = node_to_amd_nb(i)->misc;
+		struct amd_northbridge *nb = node_to_amd_nb(i);
+		struct pci_dev *dev;
+
+		if (!nb || !nb->misc)
+			continue;
+
+		dev = nb->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
 			dev_err(&dev->dev, "no usable aperture found\n");
 #ifdef __x86_64__
@@ -391,6 +409,7 @@ static int uli_agp_init(struct pci_dev *pdev)
 {
 	u32 httfea,baseaddr,enuscr;
 	struct pci_dev *dev1;
+	struct amd_northbridge *nb;
 	int i, ret;
 	unsigned size = amd64_fetch_size();
 
@@ -411,9 +430,14 @@ static int uli_agp_init(struct pci_dev *pdev)
 		goto put;
 	}
 
+	nb = node_to_amd_nb(0);
+	if (!nb || !nb->misc) {
+		ret = -ENODEV;
+		goto put;
+	}
+
 	/* shadow x86-64 registers into ULi registers */
-	pci_read_config_dword (node_to_amd_nb(0)->misc, AMD64_GARTAPERTUREBASE,
-			       &httfea);
+	pci_read_config_dword(nb->misc, AMD64_GARTAPERTUREBASE, &httfea);
 
 	/* if x86-64 aperture base is beyond 4G, exit here */
 	if ((httfea & 0x7fff) >> (32 - 25)) {
@@ -453,6 +477,7 @@ static int nforce3_agp_init(struct pci_dev *pdev)
 {
 	u32 tmp, apbase, apbar, aplimit;
 	struct pci_dev *dev1;
+	struct amd_northbridge *nb;
 	int i, ret;
 	unsigned size = amd64_fetch_size();
 
@@ -479,9 +504,14 @@ static int nforce3_agp_init(struct pci_dev *pdev)
 	tmp |= nforce3_sizes[i].size_value;
 	pci_write_config_dword(dev1, NVIDIA_X86_64_1_APSIZE, tmp);
 
+	nb = node_to_amd_nb(0);
+	if (!nb || !nb->misc) {
+		ret = -ENODEV;
+		goto put;
+	}
+
 	/* shadow x86-64 registers into NVIDIA registers */
-	pci_read_config_dword (node_to_amd_nb(0)->misc, AMD64_GARTAPERTUREBASE,
-			       &apbase);
+	pci_read_config_dword(nb->misc, AMD64_GARTAPERTUREBASE, &apbase);
 
 	/* if x86-64 aperture base is beyond 4G, exit here */
 	if ( (apbase & 0x7fff) >> (32 - 25) ) {
-- 
2.34.1

