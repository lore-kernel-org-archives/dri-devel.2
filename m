Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2382C88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D0C10FBD7;
	Tue, 15 Sep 2026 11:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a6dDn4u7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49CF10FBD7
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:37:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABFD44184D;
 Tue, 15 Sep 2026 11:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A48B1F0089B;
 Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472237;
 bh=BqXm1gwNkPuV8t/s5aBHvxXoZQi1gmoyMrWOmcTh+e0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=a6dDn4u7UHWeS4oTPwJxZY/4MEQxfhe+w1dKAeLobwNA3kw8GA3R9jRM2UR2mitay
 53rP31LX9IqiX4KyqJPeG5/A7Wk+vS/URJ+UIVi9s1V2CPS0HR+hZ4KD6LOwLi84oS
 QHwPtObpcQ5V14Eq0QEfaz7SuQthG9rIDnYNoZNXfjPTl3loRHMdpOz24R20W3G90W
 UlZUihfBsJUGHcwdaoYH/9Wk5PPbgvkC3G4N/+PjxTb+vMzH1dM6mnf2s5E522jH4C
 ipwBTphCPJfK0gAPAR1mBJJ0lQjIBDvfQG7LHcMtNeNhxBkuWpXGTndvfVHeezP+yl
 SKtsU9/kk2SGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:32 +0200
Subject: [PATCH RFC POC 46/50] xen/gntdev-dmabuf: stop putting the
 descriptor back on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=brauner@kernel.org;
 h=from:subject:message-id; bh=njDuxDGw0hmgU8wKPypyXyk5GfJpiYpSpC9eP8wkYpU=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqpLH/I6D6Uv1WDf9ilssavQSoU/hfbYczV5DbAAkrVEcQbC
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqpLH8ACgkQkcYbwGV43KLDpAD/YSHF
 Q2prY93oobCwIjSF/SfO7Zal68tdHzxKNHmWJJEA/R/JD6+ZeSXqBuxwWtOWojlugYUiab/9tAe
 INmLXFesK
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 83b0df460894..a3ecc7c83974 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -357,10 +357,10 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct gntdev_dmabuf *gntdev_dmabuf __free(kfree) = NULL;
-	CLASS(get_unused_fd, ret)(O_CLOEXEC);
+	const struct fd_slot *fd = fd_prepare(O_CLOEXEC);
 
-	if (ret < 0)
-		return ret;
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	gntdev_dmabuf = kzalloc_obj(*gntdev_dmabuf);
 	if (!gntdev_dmabuf)
@@ -388,17 +388,17 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 	if (IS_ERR(gntdev_dmabuf->dmabuf))
 		return PTR_ERR(gntdev_dmabuf->dmabuf);
 
-	gntdev_dmabuf->fd = ret;
-	args->fd = ret;
+	gntdev_dmabuf->fd = fd_prepare_fd(fd);
+	args->fd = fd_prepare_fd(fd);
 
-	pr_debug("Exporting DMA buffer with fd %d\n", ret);
+	pr_debug("Exporting DMA buffer with fd %d\n", fd_prepare_fd(fd));
 
 	get_file(gntdev_dmabuf->priv->filp);
 	mutex_lock(&args->dmabuf_priv->lock);
 	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
 	mutex_unlock(&args->dmabuf_priv->lock);
 
-	fd_install(take_fd(ret), no_free_ptr(gntdev_dmabuf)->dmabuf->file);
+	fd_stage(fd, no_free_ptr(gntdev_dmabuf)->dmabuf->file);
 	return 0;
 }
 

-- 
2.53.0

