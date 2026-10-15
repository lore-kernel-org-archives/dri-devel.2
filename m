Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1EACC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D28010FFC2;
	Thu, 15 Oct 2026 16:15:11 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B5710EA05
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:36:41 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-93cbc3ab2fdso65516385a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792053400; x=1792658200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHz/bzikXk8pek8hRSIu9eCONXczI/isD7IKkwfqttA=;
 b=hdKj33vjzBqSf/8e55fEU7GEFk+ilqUGvKGSFCHq7pjXQ9riFxDo7AH/dZk+2Wov74
 zg/oUvupfDSEf8R86AlvK/y4JKrMDPu5qLsgE9sh0igSe9i1LUPBLtP7LkOLtlMBaNUv
 Q4tSC3T7xc074UGlvFNX8sxTMzjM+YDhwfvNxN+wQ+jQ83/KURc71vHaLk/af0u+5pdT
 vdjgGJW749nEuxdOZ2s90Zi/Sj4tlWLDc0/XpGREHdfflKosA2rwtQcUBxkYa7YwAnMg
 qlJbVkWPNnxZqCLG7TDfp38/sBoYouuECW5zoix3U6RmgwJ2iTvmVnUtaoZB1GuYw5J1
 JAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053400; x=1792658200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHz/bzikXk8pek8hRSIu9eCONXczI/isD7IKkwfqttA=;
 b=XedujOvk+v1CTrYsLiP5aUMw2ybkJyW2m6G3MwP/b0qWrMLrH3ghR9+SpoYmdAfmBM
 z2ZY0Bjd8vp5/PvJ7J1e9hpHGq5W0SoVudMoWHw0ur/EVsDMXh3D8W+iyOj0Q78mtXTB
 lPPLXSRyp5ypQmKoRcAnhs9oNEbkyC8ivsPbaXWe6qxDR9/oQYlkR0HGv1sypbHuqwBb
 vrnO4RCJ+PuG0Zx20bUd78LtxuaPsVEfOSyRcj8kkuPDamopyWUMY5KUDF+5jClipK+m
 97izURNKbMP3lLyw4g4uag7EKUh/wzJH4D/2YYN89wPVSo8pf0dBVyrxCdEmwvU9f9mv
 Mfdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTP0i3jg3qNojBd2HIADascOsxVNMUIPvtBvzIqJ1K50UjFyjxoLPnfRpVyadO+hoTLMTOfkQjZN4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIgKJWz7C0iSLpgPYAo+LLKCrUTanwojMOV7wIlBJOtrGuWDx23
 Vfzt6BvB5P29ZhiM1mx2j3bwUtdmv4GlvEYreLwhJ36zLs8vnWM+ILmo
X-Gm-Gg: AYBFou0En3xw1ZebSRI+kYDkwbSy+xVl1RPAJT2EDKnF5WddpTgG7Iq2rDJykBb0rM6
 xeHs7ILjwaNxqh/oZw9hsI6CIzIqtzUWfX8SYnqFhRZsj6hYvP3Xzzbb7CPSkvgRLJzvaq0+18h
 ULiR99F6WE9i1YEEaMQveLCTNx+3yswzIj1M4LFcgg+col1F8vCj04KPxqHqlHWAQrPjYEucYsp
 UkqVjOWyTDVSPy34xotkaq4WuMPgUXtmirBbu+ZHX8lvPpZGDenT/Cb1qjEmbX4Vo6FwwBWCIVM
 EH7zC9/RyRQj5nfw8LIYhsYL2FxSAGlfx3hwJ0GJmqP1kBcDc/0vbsY5UcUiLJkpuk8q/19RMwf
 /ovsG1X6zMaJDs04qjOFwU9W6mU4sR6e3eTC89p0GpFrtWQTb1TCkgU/E+4+n6TJ6CK3Df4t8lz
 z+SJ4goNVwNDt8C3ps5nxasmB0yDljW1DcTD5M7DsI34n3RopReZ1dgK866Uot/ZZn0Dx1s17kA
 KzdKcjJuua4fthtqDJoaD0iPr7huK4GDI4mbZni7o5oDQfT+v9XrqT9E1JOD5lwJLr5tP9505MH
 WzJTsgGOcMjzx2jsPxfZzxk=
X-Received: by 2002:a05:620a:6081:b0:93a:1fa7:1afb with SMTP id
 af79cd13be357-93ebd24d180mr2908976185a.42.1792053400267; 
 Thu, 15 Oct 2026 01:36:40 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal
 (ec2-44-200-54-59.compute-1.amazonaws.com. [44.200.54.59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5090050sm711843985a.40.2026.10.15.01.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:36:39 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Deep Shah <deepshah146@gmail.com>, stable@vger.kernel.org
Subject: [PATCH rdma-rc 1/2] RDMA/uverbs: Fix uobject leak in DMABUF release
Date: Thu, 15 Oct 2026 08:36:36 +0000
Message-ID: <20261015083637.200958-2-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015083637.200958-1-deepshah146@gmail.com>
References: <20261015083637.200958-1-deepshah146@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

uverbs_dmabuf_release() treats a NULL uobj->context as an aborted
allocation, but normal ufile cleanup also clears it. Closing the uverbs
FD before the dma-buf FD therefore skips uverbs_uobject_release() and
leaks the uobject and ufile references.

Clear dmabuf->priv before dma_buf_put() on allocation failure and use
that NULL pointer to identify an abort. Otherwise, always call
uverbs_uobject_release(). This also avoids reading a freed uobject if
release is deferred until after the allocation has been aborted.

Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Deep Shah <deepshah146@gmail.com>
---
 drivers/infiniband/core/uverbs_std_types_dmabuf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
index 2411ebee69e2..d88d30f1e42f 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c
@@ -68,9 +68,10 @@ static void uverbs_dmabuf_release(struct dma_buf *dmabuf)
 	struct ib_uverbs_dmabuf_file *priv = dmabuf->priv;
 
 	/*
-	 * This can only happen if the fput came from alloc_abort_fd_uobject()
+	 * This can only happen if the fput came from the error unwind of
+	 * UVERBS_METHOD_DMABUF_ALLOC. The abort cleans up the uobject.
 	 */
-	if (!priv->uobj.context)
+	if (!priv)
 		return;
 
 	uverbs_uobject_release(&priv->uobj);
@@ -141,6 +142,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMABUF_ALLOC)(
 	return 0;
 
 err_revoked:
+	/* Tell uverbs_dmabuf_release() that the uobject is being aborted */
+	uverbs_dmabuf->dmabuf->priv = NULL;
 	dma_buf_put(uverbs_dmabuf->dmabuf);
 err:
 	rdma_user_mmap_entry_put(mmap_entry);
