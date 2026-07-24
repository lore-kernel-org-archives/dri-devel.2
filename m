Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C5C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189F810E392;
	Fri, 24 Jul 2026 09:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="eCNCgd2U";
	dkim-atps=neutral
X-Greylist: delayed 388 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 09:44:52 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE1F10E392
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xj
 c26gtijyKlp0xxUy20a9plWJdLTseNUX+kKgc45QQ=; b=eCNCgd2UW9EqkTiLkL
 TYNG4kh5ec970h3yyWAYyOoTZM+b1+HSqogOx17qZPjBIifYrH7SDgbOVoIQ484M
 xwc/d9EfMTfJo6fCCvazfIGlhNInngs8N2/9OKHsAsRhJqDoHQs6DseS2MQwTxB0
 ZZ81vaSW8YnFNDjfE3bY7SIKE=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgCnrOWJMmNqMRRwIA--.23923S2;
 Fri, 24 Jul 2026 17:38:17 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/2] iosys-map: Add getter functions for virtual addresses
Date: Fri, 24 Jul 2026 17:38:07 +0800
Message-Id: <20260724093808.776138-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgCnrOWJMmNqMRRwIA--.23923S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUtrW3Cr1Utw1xZw1rXrb_yoW8ur18pF
 nrGw43Gw48KFnxKFZ3Jw4UurZxX3WfK347WrySkas29r13XrW2yrn5Ca4UAFyDZrWUCr1j
 qFsxGrW5urnxJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj5l8UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4gkiMWpjMom8GAAA3u
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

From: Shixiong Ou <oushixiong@kylinos.cn>

Add iosys_map_get_vaddr() and iosys_map_get_vaddr_iomem() as the
counterparts to iosys_map_set_vaddr() and iosys_map_set_vaddr_iomem().

This allows drivers to use the iosys_map abstraction layer properly
instead of directly accessing the structure members, improving code
maintainability and safety.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 include/linux/iosys-map.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
index 3e85afe794c0..658d5038498a 100644
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -200,6 +200,42 @@ static inline void iosys_map_set_vaddr_iomem(struct iosys_map *map,
 	map->is_iomem = true;
 }
 
+/**
+ * iosys_map_get_vaddr - Gets the virtual address of a system-memory mapping
+ * @map:	The iosys_map structure
+ *
+ * Returns the system-memory address. The caller must ensure the mapping
+ * refers to system memory (not I/O memory).
+ *
+ * Returns:
+ * The system-memory address, or NULL if the mapping is not set or refers
+ * to I/O memory.
+ */
+static inline void *iosys_map_get_vaddr(const struct iosys_map *map)
+{
+	if (WARN_ON(map->is_iomem))
+		return NULL;
+	return map->vaddr;
+}
+
+/**
+ * iosys_map_get_vaddr_iomem - Gets the virtual address of an I/O-memory mapping
+ * @map:	The iosys_map structure
+ *
+ * Returns the I/O-memory address. The caller must ensure the mapping
+ * refers to I/O memory (not system memory).
+ *
+ * Returns:
+ * The I/O-memory address, or NULL if the mapping is not set or refers
+ * to system memory.
+ */
+static inline void __iomem *iosys_map_get_vaddr_iomem(const struct iosys_map *map)
+{
+	if (WARN_ON(!map->is_iomem))
+		return NULL;
+	return map->vaddr_iomem;
+}
+
 /**
  * iosys_map_is_equal - Compares two iosys mapping structures for equality
  * @lhs:	The iosys_map structure
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

