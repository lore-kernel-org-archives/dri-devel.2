Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FF8CD484C
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 04:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF0910E2DF;
	Wed, 13 May 2026 04:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="Xxnyp9ij";
	dkim-atps=neutral
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3036210E2EA
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1778646652; bh=jao3C9hjnud6Ug5HguXODDDvFR08PIGevezNPa49qMg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Xxnyp9ij9Ztj79AxPuhgiJ4zwbKjjjOGYFr2/BCKqY6rEPC+6L8RBMILNSdF4/xlv
 RvnJoxD9lKQPPz/wHDOmkPoJfBexAS+dOFvZ+x5CYPVsMuOAyipZSnTLdLNg5Bh491
 f29+X0DPIgGUgUW35O0SXMenAY1a04fk+PNaBhbE=
Received: from lxu-ped-host.. ([111.198.231.89])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 7B1342F7; Wed, 13 May 2026 12:30:49 +0800
X-QQ-mid: xmsmtpt1778646649t9igv4z1w
Message-ID: <tencent_C267296443AAA4567771176886DFF364A305@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn6BNGvTIE8xYgjYv2a6B6Ukpbwek5tx+ybjccufiLPgSV4yRA4l
 5mZYRWxZf4hOhRWVy7eHNc+zF8zlj/0so11zcr6zcoEWFQS7iqBeCnQdcwfnTlkNBnje1Pf8xi9z
 7joExwa0j9+iR914R75JuQeUhob1RAOB9qRlcFXvIO9cuNvbUAyVorLRTVxO5+ahjY9sn0/MZEbc
 b9z6a7g5c8LZV1b0hgM0piSMNvnwNjEdukMW6OlBbT2lGmYjgTvq1B7uiXeoE3CMkP7MzhC9a0Uv
 /6u7YtAGKFzuEGJ4kUM+Sm/bM2JLGX5GkdodCh9KMZ2acPdQUdeMgnp2l6bDD4fY+08dpEnCoLtx
 TpbDpbblaoVtak2CyBD0c3CEGystXCJ1TphYrJ6EfKlNIIcA059OmUt+zJcPlTlTuMpeU4sNymSF
 G0a6aM+dF91iQTvFrVPve848KYGR+afI/OFmMUP4mc9DJsLdUnHLBMkShuPryDsnsEREs+eqOdM0
 86tvi8hB2mGEobBvY9lrGZO62qNhOGQGcT1iUtPW7bPWzUw+VdE+tjZmPEPjU3L4Ge1yyneS6Psu
 xCgdegV1ZOMaJ+e9nbXmeBHCJbTQKwL1c0HO6nxOlcfh62Gphugykil14lrY6N4OAp5jHy5/p7zO
 zQXtSymIuW96gv5O0wDcVmXpTVtgH1ZNMcYIHnzFvJePNkIB7OgpmFT+GM0U6IAAgmwCSWUTEgzL
 ILBygtjW3QlIQZ3j+BpOLZr+Slo5dd9C3XIeRpjP832RE+Rk0UVpFkf6vJ2YSYbnpxjYfRo25dYW
 nti3/CLYW4vXhvGV16fVGs+MK+MO/3WSmxwdD3FO4p5i9qW192AAoNiUBgGp9vFnaErszF9Lusj5
 1f/ZVOsgFuY4xMCy3PdpJ83lmRDlp5cz9/2o9HhAvp9rih+HFuX2e9hDQ0F10lBz5cCCYQrr80nd
 rbc3VV5QzbLZA5yo32kTJQSyMsPGsbO9dBam/A45miA8MheMWM8v5Fp/jJk2HQEZQ8bPFsENl5C9
 aiLAdPkcsNrQCyAU+e
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com,
 tzimmermann@suse.de, David.Francis@amd.com
Subject: [PATCH] drm: Replace old pointer to new idr
Date: Wed, 13 May 2026 12:30:50 +0800
X-OQ-MSGID: <20260513043049.363250-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a0385f1.a00a0220.3890a0.0002.GAE@google.com>
References: <6a0385f1.a00a0220.3890a0.0002.GAE@google.com>
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

Commit 5e28b7b94408 introduced a logical error by failing to replace the
newly generated IDR pointer to old id's pointer at the correct location
within the "change handle" logic; this resulted in the issue reported by
syzbot [1].

Specifically, the new IDR object pointer is intended to replace the original
id's pointer during the normal execution flow.

Additionally, an unnecessary conditional check for the ret exit path has
been removed.

[1]
!RB_EMPTY_ROOT(&prime_fpriv->dmabufs)
WARNING: drivers/gpu/drm/drm_prime.c:224 at drm_prime_destroy_file_private+0x48/0x60 drivers/gpu/drm/drm_prime.c:224, CPU#0: syz.0.17/5833
Call Trace:
 drm_file_free.part.0+0x7e6/0xcc0 drivers/gpu/drm/drm_file.c:269
 drm_file_free drivers/gpu/drm/drm_file.c:237 [inline]
 drm_close_helper.isra.0+0x186/0x200 drivers/gpu/drm/drm_file.c:290
 drm_release+0x1ab/0x360 drivers/gpu/drm/drm_file.c:438

Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
Reported-by: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7c9eed171647e421013
Tested-by: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/gpu/drm/drm_gem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 51a887cc7fd7..8afab57fc055 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1067,17 +1067,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 
 	spin_unlock(&file_priv->table_lock);
 
-	if (ret < 0)
-		goto out_unlock;
-
 	if (obj->dma_buf) {
 		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
 					       handle);
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
 			idr_remove(&file_priv->object_idr, handle);
-			idrobj = idr_replace(&file_priv->object_idr, obj, handle);
-			WARN_ON(idrobj != NULL);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}
@@ -1089,7 +1084,9 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 
 	spin_lock(&file_priv->table_lock);
 	idr_remove(&file_priv->object_idr, args->handle);
+	idrobj = idr_replace(&file_priv->object_idr, obj, handle);
 	spin_unlock(&file_priv->table_lock);
+	WARN_ON(idrobj != NULL);
 
 out_unlock:
 	mutex_unlock(&file_priv->prime.lock);
-- 
2.43.0

