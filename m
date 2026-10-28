Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QWdPEyLt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E88410E15A;
	Wed, 28 Oct 2026 19:56:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDEB10E15A
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 19:56:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A912F600DA;
 Wed, 28 Oct 2026 19:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BB91F01825;
 Wed, 28 Oct 2026 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1793217366;
 bh=fezGMMHkUJ0c5ry5NRRLZdVCXziTP+1DxoF5Fhdba+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QWdPEyLteWhufpAX1emKcD1bP5BZM5IjZybbZKQeWwViEmc061Ov+NqnBqZVItIOw
 1/fXZKHIYp7wmkW/Rf0xZrCMal/t8w/WrSwf4cdkafD84qOcRMWX5K9fW6n+8X2vf+
 Dyb5NyWA/WFAxBumCQMXJGw2bUiyXPhruQZAIWM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 1877/1887] fbdev: Use /* */ comment in initializer macro
Date: Wed, 28 Oct 2026 18:06:13 +0100
Message-ID: <20261028170542.169314060@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028170459.200466217@linuxfoundation.org>
References: <20261028170459.200466217@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit cf683e8870bd4be0fd6b98639286700a35088660 ]

Use /* */ in initializer macro to avoid out-commenting the comma
at the end of the line.

Reported-by: Christian König <ckoenig.leichtzumerken@gmail.com>
Closes: https://lore.kernel.org/dri-devel/20230530150253.22758-1-tzimmermann@suse.de/T/#m356cda2679c17d7a01f30ce2b5282cd9046ea6d4
Fixes: f1061fa641b8 ("fbdev: Add initializer macros for struct fb_ops")
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230614131253.10208-1-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2435aeddf47fa..10844193fb9d8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -621,7 +621,7 @@ extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
 	.fb_imageblit	= cfb_imageblit
 
 #define __FB_DEFAULT_IO_OPS_MMAP \
-	.fb_mmap	= NULL // default implementation
+	.fb_mmap	= NULL /* default implementation */
 
 #define FB_DEFAULT_IO_OPS \
 	__FB_DEFAULT_IO_OPS_RDWR, \
@@ -654,7 +654,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	.fb_imageblit	= sys_imageblit
 
 #define __FB_DEFAULT_SYS_OPS_MMAP \
-	.fb_mmap	= NULL // default implementation
+	.fb_mmap	= NULL /* default implementation */
 
 #define FB_DEFAULT_SYS_OPS \
 	__FB_DEFAULT_SYS_OPS_RDWR, \
-- 
2.53.0



