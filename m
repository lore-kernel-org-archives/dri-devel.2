Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E7606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IS8J38Eu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6988510E1CE;
	Thu, 29 Oct 2026 12:52:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAA710E1CE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 12:52:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2161643933;
 Thu, 29 Oct 2026 12:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6A01F01825;
 Thu, 29 Oct 2026 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793278324;
 bh=Iid3eWpVe8olQMkvpXTW8m9qOGkSJpcW1KaQejtRK1Y=;
 h=From:To:Cc:Subject:Date;
 b=IS8J38EuHK3inR5WNoXkUqRieBG6uy85jRetqgdMxEnVwBvk8dONXaq2UW5HwB2rI
 meRNHV3CmcRbii+uCmvEhqk28UdZs/URUOOf9niOzOrpmoU0OaycS9kFCtw1f11nSX
 uT50qCMRLJyfOkjZtxWRDqIXYLjOu0BbKEVOgdL2SxSDmBmHOqJjN/RAg49P0Z1UFu
 W8a22kipU+v1QfjsTFTdj/YBvbZk27ESBknMui5dYniY28Krmup6SyPFySTnPhjY8W
 rRHJTkztfBKIUstMZqoOsoCDaBeR63CeDb/lOa2r7Je60uY7EFK9R0AT5Xjdt667I3
 e5lXTnBQm/Orw==
From: Philipp Stanner <phasta@kernel.org>
To: Neill Kapron <nkapron@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, Sam Day <me@samcday.com>,
 Michael Bommarito <michael.bommarito@gmail.com>,
 Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
Date: Thu, 29 Oct 2026 13:51:44 +0100
Message-ID: <20261029125143.1744481-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dma_fence_ops function ops->release() has been deprecated because it
prevents drivers from unloading. f_fs's implementation merely frees the
fence. The dma_fence backend performs this deallocation automatically in
the correct manner if ops->release() is not implemented.

The backend simultaneously correctly frees struct ffs_dma_fence since
struct dma_fence is its base class.

Remove ops->release().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a4..e8672b37e890 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1479,18 +1479,9 @@ static const char *ffs_dmabuf_get_timeline_name(struct dma_fence *fence)
 	return "";
 }
 
-static void ffs_dmabuf_fence_release(struct dma_fence *fence)
-{
-	struct ffs_dma_fence *dma_fence =
-		container_of(fence, struct ffs_dma_fence, base);
-
-	kfree(dma_fence);
-}
-
 static const struct dma_fence_ops ffs_dmabuf_fence_ops = {
 	.get_driver_name	= ffs_dmabuf_get_driver_name,
 	.get_timeline_name	= ffs_dmabuf_get_timeline_name,
-	.release		= ffs_dmabuf_fence_release,
 };
 
 static int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
-- 
2.56.0

