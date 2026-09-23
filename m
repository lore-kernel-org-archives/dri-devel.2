Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1470C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 03:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33B110E509;
	Wed, 23 Sep 2026 03:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="NoTxzZST";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B28C10E052;
 Wed, 23 Sep 2026 03:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790132485; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VCPrjut2M5FlXYGV0GoEvCnHOUJpE1AcB1y6ysMlGCX7bfx56Kc2eBCTjoUD0e0vqx6bPotDdwP7O3K9HKni/JMV3L++lts+dsZRzGG2IvhQQq5x8PsBg/Vx9mOUaDWPqWOFxoZZ7OUGz389M3pvV9s5zoC9U7SSEL5NTgDxSy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790132485;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QaGl5DuQshI+5WjNU+vPAMnWlIU/LxzRoncQZI3V7ak=; 
 b=Cxuxo6KR1FzfRE3sitLbMeuSMm9DLJ11ywC6vveUCmpH4X7e7tmnnn3mVHFfwCPbbyw9duyUUf4w5SIicyu7Ggf8ckD20ffbR6iCbLmzEvdd4OxmGtHlaqeH/XLYZUomtKJv3gBBJQ8dm75/k5dCBF58TS1LmCi5umrHj5HM9LU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790132485; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=QaGl5DuQshI+5WjNU+vPAMnWlIU/LxzRoncQZI3V7ak=;
 b=NoTxzZST6flf559uY3LYViPTvC82Dv9ckOYtHS92rXPbotKctXN25RlN5PGxXVlv
 /j7MjP80eMRKHDdIfRPL28Al1Nxu1TYUbSqomBqvShyNwchMdIZGAu6JCsal2JuDAem
 sKrCPIyO5s8iVELeXCYnSQn87pQ70ekXbPGLzfvE=
Received: by smtp.zohomail.com with SMTPS id 179013248462329.209373235470593; 
 Tue, 22 Sep 2026 20:01:24 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 22 Sep 2026 20:01:20 -0700
Subject: [PATCH i-g-t] lib/igt_profiling: configure Panthor enable state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-gputop_panthor-v1-1-e908705bd062@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBswif6uEhFpo81GRS2C6O5Jy
 2/x3gOJIlOCqXog0sWJvSto6gr0sTlLyHsxSCE7MUqJqkUbzuzDGjaXDx9RK9UPWhijzAClC5E
 M3/9zBkaLGZb3/QCEmIBnagAAAA==
X-Change-ID: 20260922-b4-gputop_panthor-cbb78c0ffbf8
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kamil.konieczny@linux.intel.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=L0A2zxBQEHaJl588V0MNmnRlNbkkEc48VKD/FwwfXso=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmbHZl1Hm/876acsLVaJHPxhJ+nzNL+9IvYqnyx+9Gwo
 lBNyEyno5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIm8MWVkeOTgeK36Q72nm+63
 EJZ1ht77Xc82PF7ZJ2Q87/zyJ4wWJxn+CvJWdnyLqjummn/0HuNl1dOnDApO993Pus76eUf2nrV
 T2QA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Currently profiling is enabled for every device by writing '1' into the
appropriate sysfs node. But Panthor uses a bit mask where cycle and
timestamp sampling are enabled by the first and second bits respectively.

By default assume that writing '1' will enable profiling, but then adjust
the value to '3' for the Panthor driver.

Closes: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/work_items/209
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 lib/igt_profiling.c | 23 +++++++++++++++++++++--
 lib/igt_profiling.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/igt_profiling.c b/lib/igt_profiling.c
index e1526ad98..5c62a3fb1 100644
--- a/lib/igt_profiling.c
+++ b/lib/igt_profiling.c
@@ -50,7 +50,10 @@ struct igt_profiled_device *igt_devices_profiled(void)
 
 	while ((entry = readdir(dev_dir)) != NULL) {
 		char path[PATH_MAX];
+		char driver_path[PATH_MAX];
+		char driver_link[PATH_MAX];
 		char orig_state;
+		ssize_t len;
 		int sysfs_fd;
 
 		/* All DRM device entries are symlinks to other paths within sysfs */
@@ -87,7 +90,23 @@ struct igt_profiled_device *igt_devices_profiled(void)
 		}
 
 		profiled_devices[i].syspath = strdup(path);
-		profiled_devices[i++].original_state = orig_state;
+		profiled_devices[i].original_state = orig_state;
+		profiled_devices[i].enable_state = '1';
+
+		snprintf(driver_path, sizeof(driver_path), "%s/%s/device/driver",
+			 SYSFS_DRM, entry->d_name);
+
+		len = readlink(driver_path, driver_link, sizeof(driver_link) - 1);
+		if (len >= 0) {
+			driver_link[len] = '\0';
+
+			if (strstr(driver_link, "/panthor")) {
+				/* Enable both cycle and timestamp sampling. */
+				profiled_devices[i].enable_state = '3';
+			}
+		}
+
+		i++;
 
 		close(sysfs_fd);
 	}
@@ -124,7 +143,7 @@ void igt_devices_configure_profiling(struct igt_profiled_device *devices, bool e
 		if (sysfs_fd < 0)
 			continue;
 
-		write(sysfs_fd, enable ? "1" : &devices[i].original_state, 1);
+		write(sysfs_fd, enable ? &devices[i].enable_state : &devices[i].original_state, 1);
 		close(sysfs_fd);
 	}
 }
diff --git a/lib/igt_profiling.h b/lib/igt_profiling.h
index b063d54e1..d38cc2bb6 100644
--- a/lib/igt_profiling.h
+++ b/lib/igt_profiling.h
@@ -12,6 +12,7 @@
 struct igt_profiled_device {
 	char *syspath;
 	char original_state;
+	char enable_state;
 };
 
 void igt_devices_configure_profiling(struct igt_profiled_device *devices, bool enable);

---
base-commit: 65f84b280be2caf8ce376295d97987a808affdee
change-id: 20260922-b4-gputop_panthor-cbb78c0ffbf8

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

