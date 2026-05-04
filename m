Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BDCCD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BFE10E976;
	Tue,  5 May 2026 07:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="H7olWS5R";
	dkim-atps=neutral
X-Greylist: delayed 3078 seconds by postgrey-1.36 at gabe;
 Mon, 04 May 2026 07:48:48 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB5910E5FA
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BG
 2utFDGULuhQh672bTQWamHdZY+4eC37jgZ9SY1idg=; b=H7olWS5RZg7vQT1sno
 c2iSGZnhunC5zuuMpS042oREnPlUBbZ7VeQGSGP4syeZfS2+GA3RYkYsTd0peFo5
 pfHaB9gP1ADxF1fHUeAQkX3goD+T9GvbWGvTMLYBmVlzxUjg+RQYE1bbelCV7P1u
 Hb3bwr7FAr4jYYInHdI35jzqI=
Received: from wmy.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDXP31IT_hp5Vw+DQ--.51144S2; 
 Mon, 04 May 2026 15:48:36 +0800 (CST)
From: w15303746062@163.com
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-pci@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] char: agp: amd64 - fix broken error propagation in
 agp_amd64_probe()
Date: Mon,  4 May 2026 15:48:23 +0800
Message-Id: <20260504074823.99377-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXP31IT_hp5Vw+DQ--.51144S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr15CFy3AFWxGryrXF1DZFb_yoW8tF1fpa
 93GwsYka1kK34rKFWDtw47Ar1Fvwn7WFWYkr1kGw4DuasxGFyxAry3tFWj9Fy5CFWqyr4a
 v3W5KFW5ua4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFg4fUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5BSBZWn4T1RBhAAA3b
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

A NULL pointer dereference was observed in the AMD64 AGP driver when
running in a virtualized environment (e.g., QEMU/KVM) without a physical
AMD Northbridge. The crash occurs in amd64_fetch_size() when attempting
to dereference the pointer returned by node_to_amd_nb(0).

The root cause of this crash is broken error propagation in
agp_amd64_probe(). When no AMD Northbridges are found, cache_nbs()
correctly returns -ENODEV. However, the probe function erroneously
checked the return value against exactly -1, rather than < 0.

As a result, the hardware absence error was masked, allowing the driver
to improperly proceed with initialization. It eventually called
agp_add_bridge(), which invokes amd64_fetch_size(). Since the hardware
does not exist, node_to_amd_nb(0) returns NULL, leading to a General
Protection Fault (GPF) when accessing its ->misc member.

Fix the issue by correcting the error check in agp_amd64_probe() to
abort properly when cache_nbs() returns any negative error code. This
prevents the driver from erroneously proceeding without hardware, thereby
resolving the subsequent NULL pointer dereference at its source.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
+ Changes in v2:
+ - Dropped redundant NULL pointer checks in various initialization functions.
+ - Fixed the actual root cause: broken error propagation in agp_amd64_probe() 
+   where it erroneously checked cache_nbs() against exactly -1 instead of < 0.
+   (Thanks to Sashiko AI for the review feedback).
+
 drivers/char/agp/amd64-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 2505df1f4e69..6741270e0a98 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -546,7 +546,7 @@ static int agp_amd64_probe(struct pci_dev *pdev,
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev, bridge->capndx+PCI_AGP_STATUS, &bridge->mode);
 
-	if (cache_nbs(pdev, cap_ptr) == -1) {
+	if (cache_nbs(pdev, cap_ptr) < 0) {
 		agp_put_bridge(bridge);
 		return -ENODEV;
 	}
-- 
2.34.1

