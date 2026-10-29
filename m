Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B20112071;
	Thu, 29 Oct 2026 07:59:24 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D0A10FEFA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 01:56:35 +0000 (UTC)
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax29HQp+Jqxk8aAA--.11429S3;
 Thu, 29 Oct 2026 09:56:32 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxW87Hp+Jq7QwxAA--.11701S2;
 Thu, 29 Oct 2026 09:56:23 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 chenhuacai@loongson.cn
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 wuqianhai@loongson.cn, zhaotianrui@loongson.cn
Subject: [PATCH] vga-switcheroo: Allow VGA_SWITCHEROO to be enabled on
 LoongArch
Date: Thu, 29 Oct 2026 09:36:18 +0800
Message-Id: <20261029013618.3558115-1-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxW87Hp+Jq7QwxAA--.11701S2
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LoongArch systems with hybrid graphics (integrated +
discrete GPU) can benefit from the same GPU switching
mechanism that x86 laptops use. Relax the dependency
to allow VGA_SWITCHEROO to be built on LoongArch,
consistent with the existing dependencies on ACPI,
PCI, and FB=y.

Change-Id: I84d38fdfe5e1591495fb3681474a7f1f64281fa8
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 drivers/gpu/vga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index bad4bcee313..89edd1211aa 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VGA_SWITCHEROO
 	bool "Laptop Hybrid Graphics - GPU switching support"
-	depends on X86
+	depends on X86 || LOONGARCH
 	depends on ACPI
 	depends on PCI
 	depends on FB=y
-- 
2.39.1

