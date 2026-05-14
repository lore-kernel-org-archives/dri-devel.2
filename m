Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FE2CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F7710F342;
	Thu, 14 May 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="iMvVhPD+";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0919410E111
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ax
 v3kt0/X+Ju3helrk5fBsUgAvH/ndDA/ivuh3VEB6s=; b=iMvVhPD+vUQDaLSwiC
 fIv7YO4rY9oUfEa7kErBhEtZqmDtC67BhrJ8mE1GBPmi42nypvkOu5hfGq50ewJA
 k8gP2VdY1jk/KZiRRP0rQ0qmsLmZIt/N9NNcLk+jSqojAPiuAyQERmVTYjLFHFZY
 7s7pZrzNOyq3Lxt4+VAHHMIzA=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wAXApbekgVqz+5QBQ--.35178S3; 
 Thu, 14 May 2026 17:16:24 +0800 (CST)
From: liuqiangneo@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Qiang Liu <liuqiang@kylinos.cn>
Subject: [RESEND PATCH 1/2] drm/debugfs: Replace seq_printf with seq_puts for
 constant strings
Date: Thu, 14 May 2026 17:16:09 +0800
Message-ID: <20260514091611.153919-2-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514091611.153919-1-liuqiangneo@163.com>
References: <20260514091611.153919-1-liuqiangneo@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXApbekgVqz+5QBQ--.35178S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw4UuFy3Jw15JrW3Xw4DXFb_yoW8JF1Dpa
 9xCF90kr40yF45KryxA3WDZryfG3ZIvFySgrZrXw15Cry5Zr4UXryYga12yrykWr97Cw4Y
 qFsYgFWUWwn8uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9WrAUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC3wi6HGoFkujtPQAA30
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

From: Qiang Liu <liuqiang@kylinos.cn>

Replace seq_printf() with seq_puts() when printing constant strings
without format specifiers. This is more efficient as seq_puts()
doesn't need to parse the format string.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/gpu/drm/drm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index ae1c6126c2c5..f9658bdf703e 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -66,7 +66,7 @@ static int drm_name_info(struct seq_file *m, void *data)
 		seq_printf(m, " master=%s", master->unique);
 	if (dev->unique)
 		seq_printf(m, " unique=%s", dev->unique);
-	seq_printf(m, "\n");
+	seq_puts(m, "\n");
 	mutex_unlock(&dev->master_mutex);
 
 	return 0;
@@ -139,7 +139,7 @@ static int drm_gem_name_info(struct seq_file *m, void *data)
 	struct drm_debugfs_entry *entry = m->private;
 	struct drm_device *dev = entry->dev;
 
-	seq_printf(m, "  name     size handles refcount\n");
+	seq_puts(m, "  name     size handles refcount\n");
 
 	mutex_lock(&dev->object_name_lock);
 	idr_for_each(&dev->object_name_idr, drm_gem_one_name_info, m);
-- 
2.43.0

