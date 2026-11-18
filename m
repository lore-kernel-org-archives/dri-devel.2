Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE51606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nZ1MxDru
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB6E10E64D;
	Wed, 18 Nov 2026 16:19:46 +0000 (UTC)
X-Greylist: delayed 6890 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 16:19:40 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7A710E64D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rx
 H4cRTlih2nYqrfKusqL9MuJhz5QOuEx96vGmCTg/E=; b=nZ1MxDruYTpiRv6Taa
 lw7kkSrSjo66gEswW5Y2FYtbwBpe+nG3z/HapSm7MpYdLBwFVUPShFrwWF875Kfh
 lKECJtU1+sy9z9obfOo34ouoVkVYUhiQ53DDV+gFHpQB93wci7sh3GcobJRKgXp7
 bbq/ed7FrzpXPVXhp3AdgmTo4=
Received: from localhost.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgD3WJIJ0P1q3Za9Gg--.25673S2;
 Thu, 19 Nov 2026 00:19:23 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: anitha.chrisanthus@intel.com, airlied@gmail.com, simona@ffwll.ch,
 tzimmermann@suse.de, sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] drm/kmb: Uninstall IRQ handler on DRM registration failure
Date: Thu, 19 Nov 2026 00:19:21 +0800
Message-Id: <20261118161921.2460608-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgD3WJIJ0P1q3Za9Gg--.25673S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr43Xr1fWw17urykAr4DXFb_yoWfZrg_WF
 12qr4xWrs0kFnxJr129F4a9rW2yF1v9Fs3Gw10ga95K3srZryqvrWq93Z7ZF18uF45AFZ8
 Gw4jqF4fW347WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiBHq5UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QtQvmr90AsG0QAA3T
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

kmb_probe() installs the LCD IRQ handler before calling
drm_dev_register(). If registration fails, the error path stops
polling and cleans up the display resources without uninstalling
the handler.

Call kmb_irq_uninstall() in the registration error path

Fixes: 58889cdc39cf ("drm/kmb: Convert to Linux IRQ interfaces")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..d8e2fc28ee9e 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -569,6 +569,7 @@ static int kmb_probe(struct platform_device *pdev)
 
  err_register:
 	drm_kms_helper_poll_fini(&kmb->drm);
+	kmb_irq_uninstall(&kmb->drm);
  err_irq:
 	pm_runtime_disable(kmb->drm.dev);
  err_free:
-- 
2.25.1

