Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93971606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tuB3xFuI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386E310F520;
	Wed, 11 Nov 2026 08:22:59 +0000 (UTC)
X-Greylist: delayed 544 seconds by postgrey-1.36 at gabe;
 Wed, 11 Nov 2026 03:51:14 UTC
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com
 [111.22.67.151])
 by gabe.freedesktop.org (Postfix) with ESMTP id E8CB010E010
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 03:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=tuB3xFuIzKoH1PmSbz3AjZAFJY/M+MnffAHc5HNT+5K/QtlmSLeJowd797THucyqpxIkPGw8wIR2l
 BFc7j77VR9tyYGiUaXjXTrky1vCbhus0MkkdzGugXfPqFkGSNfq3QBFrZqJyIZPqRvAsPKEtcS6fT7
 DNPv+aEBjfS8qmkI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af3e40f029-0fe83;
 Wed, 11 Nov 2026 11:42:07 +0800 (CST)
X-RM-TRANSID: 2ee26af3e40f029-0fe83
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [25.255.2.225] (unknown[10.55.1.70])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af3e40dfe5-cd088;
 Wed, 11 Nov 2026 11:42:06 +0800 (CST)
X-RM-TRANSID: 2ee76af3e40dfe5-cd088
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com,
 xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH] drm/fbdev-shmem: don't warn on a transient dirty callback
 failure
Date: Wed, 11 Nov 2026 11:41:08 +0800
Message-ID: <20261111114108.675721-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fbdev dirty callback (drm_atomic_helper_dirtyfb()) can fail with
-ENOMEM when the atomic commit allocation fails under memory pressure.
That is a transient runtime condition, not a driver bug: the damage is
only cosmetic and the frame is redrawn on the next flush.

drm_WARN_ONCE() turns this recoverable failure into a WARN splat (and a
panic with panic_on_warn), which syzbot keeps reporting:

  virtio-pci 0000:00:01.0: [drm] Dirty helper failed: ret=-12
  WARNING: drivers/gpu/drm/drm_fbdev_shmem.c:118 at ...

Keep the warning for other failures, but do not warn about -ENOMEM.  The
error is still propagated to the caller.

Reported-by: syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=369ee6a6e9d0bbf14b37
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/gpu/drm/drm_fbdev_shmem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_shmem.c b/drivers/gpu/drm/drm_fbdev_shmem.c
index 8eb05fe9b..c3fa5a663 100644
--- a/drivers/gpu/drm/drm_fbdev_shmem.c
+++ b/drivers/gpu/drm/drm_fbdev_shmem.c
@@ -115,7 +115,14 @@ static int drm_fbdev_shmem_helper_fb_dirty(struct drm_fb_helper *helper,
 
 	if (helper->fb->funcs->dirty) {
 		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
-		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
+		/*
+		 * An allocation failure is a transient condition under memory
+		 * pressure, not a driver bug, so don't warn about it.  The
+		 * error itself is still propagated to the caller.
+		 */
+		drm_WARN_ONCE(dev, ret && ret != -ENOMEM,
+			      "Dirty helper failed: ret=%d\n", ret);
+		if (ret)
 			return ret;
 	}
 
-- 
2.43.0


