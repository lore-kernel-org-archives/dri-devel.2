Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47460A260D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=tlMQsWE9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2371128A3;
	Fri, 20 Nov 2026 10:04:38 +0000 (UTC)
X-Greylist: delayed 320 seconds by postgrey-1.36 at gabe;
 Fri, 20 Nov 2026 10:04:31 UTC
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net
 [178.154.239.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD0611288F;
 Fri, 20 Nov 2026 10:04:31 +0000 (UTC)
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
 by forward202d.mail.yandex.net (postfix) with ESMTPS id 8160082959;
 Fri, 20 Nov 2026 12:59:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87
 (mail-nwsmtp-smtp-production-main-87.yp-c.yandex.net)
 by forward100d.mail.yandex.net (postfix) with ESMTPS id 4BC5CC7D2B;
 Fri, 20 Nov 2026 12:59:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87 with ESMTPSA id
 5xYQkYIhda60-aq5HLcQq; Fri, 20 Nov 2026 12:59:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1795168745; bh=utJqrDCG+r/KNlvUKQ3l/OrRw/b43YbdV5mQQLDyiTU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=tlMQsWE9iwHVsh5Q77fuM4SbEpnXIGvoddI9X1HFhzFAJ1dgwEkPhVqc7dvLrSrUt
 CBwJe688SnH/EyLkjl8YIgoyz7kbKe3Rra/4Yrb8dFOskexec4FtaL/TZNkVwzQZ1Z
 rIM9b+nHw9hw5Z1huAxcIQokeWBUiKPzQfJo8BYA=
Authentication-Results: mail-nwsmtp-smtp-production-main-87;
 dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] drm/amdkfd: simplify kfd_debugfs_hang_hws_write()
Date: Fri, 20 Nov 2026 12:58:39 +0300
Message-ID: <20261120095839.745461-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use kstrtoint_from_user() to simplify kfd_debugfs_hang_hws_write().

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 25 ++++++++----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 33e905d59dd9..251d9ba5af98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -55,31 +55,22 @@ static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
 	const char __user *user_buf, size_t size, loff_t *ppos)
 {
 	struct kfd_node *dev;
-	char tmp[16];
 	uint32_t gpu_id;
-	int ret = -EINVAL;
+	int ret;
+
+	ret = kstrtoint_from_user(user_buf, size, 10, &gpu_id);
+	if (ret)
+		return ret;
 
-	memset(tmp, 0, 16);
-	if (size >= 16) {
-		pr_err("Invalid input for gpu id.\n");
-		goto out;
-	}
-	if (copy_from_user(tmp, user_buf, size)) {
-		ret = -EFAULT;
-		goto out;
-	}
-	if (kstrtoint(tmp, 10, &gpu_id)) {
-		pr_err("Invalid input for gpu id.\n");
-		goto out;
-	}
 	dev = kfd_device_by_id(gpu_id);
 	if (dev) {
 		kfd_debugfs_hang_hws(dev);
 		ret = size;
-	} else
+	} else {
 		pr_err("Cannot find device %d.\n", gpu_id);
+		ret = -ENODEV;
+	}
 
-out:
 	return ret;
 }
 
-- 
2.56.1

