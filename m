Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE61CC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5920B89E01;
	Wed, 22 Jul 2026 11:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="c7eJHv/b";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F33989E01
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784718141; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FTIzYTAHnNmqg3YqHfP0hRY6WyltBO43A2zQcoksCICAljD8pkR/d39o4ABWODjpsR6Bap8E4WbvNlu4XUOGK2N5OeHrliPej+YjQM9xP1abBn/JuQXRh10v0SbVgXpUl/QckkuoW6kbifJE3kIQ4gxh5nWhAOS9u8YPNvOMj7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784718141;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WSLpe5B4oyutsM1XL0vI0oMyM7hDOuX8x5AFgnGgADQ=; 
 b=g4oLwvNAbeeLhZGyOb9s7maRHSEMPptt81l7sgSmJ7mNFRKCYDTwU0sxM1SZjDkLYNgrllA0IK6yRHPRf23tib2W6s80hFLlmrrVXcrOWoXQK1+1hDhXk+HXEXHHKCMXMfZZy0pk4ZxLD1wksjA8+kboQdcPRsFlfBFjt6uG+9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784718141; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=WSLpe5B4oyutsM1XL0vI0oMyM7hDOuX8x5AFgnGgADQ=;
 b=c7eJHv/bFoqiK62YpQ5vhqKvsWM6RnZxxulXEfDVXoQrJbc2V3qRFPJ+zNlxohFn
 XBqhzgGL4PRJwoaFRz5caib/DtUjKZoA2XjfCGv0bVQ8L19oAH7t7W8EorVdbQHv4Ef
 S4WaHffQ3cnlmRJEypFu1vkghQ4V6CyvpjC6YNKU=
Received: by mx.zohomail.com with SMTPS id 1784718140462259.5530375342954;
 Wed, 22 Jul 2026 04:02:20 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Robert Mader <robert.mader@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
Date: Wed, 22 Jul 2026 13:01:45 +0200
Message-ID: <20260722110145.36641-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.55.0
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

As udmabuf increasingly enjoys popularity - being used in projects like
libcamera, Gstreamer, Mesa, KWin and Weston - users more frequently
encounter cases where the current default size limit of 64MB is too low.
Examples include allocating video buffers at a 8K resolution - and even 4K
is affected when using non-subsampled video formats and high bit depths.

In its current form the size limit for individual buffers does not seem to
provide any additional level of protection - such as limiting the amount of
memory a process can pin - as the later can just allocate multiple buffers.
If additional guardrails are desired, they would likely require some kind
accounting not limited to individual buffers.

Therefor let's disable the size limit by default by setting it to the
maximal possible value, INT_MAX.

Signed-off-by: Robert Mader <robert.mader@collabora.com>

---

Changes in V2:
 - Use INT_MAX instead of 0 in order to not change behavior otherwise.

See
https://lore.kernel.org/dri-devel/20260711144814.8205-1-robert.mader@collabora.com/
for a previous attempt to make the value configurable via kconfig - and
in particular
https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-2ca867ac2d41@amd.com/
for the suggestion and discussion to remove the default limit.
---
 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index bced421c0d65..639e93704924 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,9 +20,9 @@ static int list_limit = 1024;
 module_param(list_limit, int, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
 
-static int size_limit_mb = 64;
+static int size_limit_mb = INT_MAX;
 module_param(size_limit_mb, int, 0644);
-MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 64.");
+MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is INT_MAX.");
 
 struct udmabuf {
 	pgoff_t pagecount;
-- 
2.55.0

