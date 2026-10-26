Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459E606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3CsxLYm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCB110EA66;
	Mon, 26 Oct 2026 05:59:03 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB3D10EA66
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:58:57 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2234124f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792994336; x=1793599136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3gJomeBmHPSa1nSKsQOjrx0jFw6wNV5cIGdR0fKlHFY=;
 b=N3CsxLYmk1+biIwYRJqhYgf+GK1VN8r4L/Gbc8ntOJiGDyyZqnGQbRpiJcqRAkrRwu
 q4w/eGShui4RFA4bDiJbxj70muUMTgNBjmRNPyUMD2/LqlRm8FmgsLlkZkg9Wb3QzRF/
 YfaT4G62eQkKhmHHNkmQ0UUtTNAmo08nR6BKuXH2Ahg3j5NT8gTWL0TznVyLWdQDa2X1
 F+NQ/pj/LJfjuOuTkuRzyMCCoSB7xSmX/VUmDh6rTaTdEb8Ier/64UPDc/auLiR+Cnx3
 dA8+VTNvmJDrqMh81olwNZ0aS3pcmdL0WNNxGuOfhfdddr/bxGTBpEwwc4F2w9FiKnh6
 q82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792994336; x=1793599136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3gJomeBmHPSa1nSKsQOjrx0jFw6wNV5cIGdR0fKlHFY=;
 b=xX294f/inFJookxx0d7PZAMf6Hhv7ZyhRVtS102TgL928662p7s3nLxppnCqyC46W9
 V9sl7qWeGBHEh5eH4HVYY6sQR9hvKRT5zh9xktVxm1HsC23uj2EFlWjP5VxBRmSDZ5Pm
 Gdk3fEWDbGg42E4zXrmiqb2bCuuyUXssC1+uOlTD7BAhdgxxUPbLorFwRZFdWlh5OEM3
 qPBokFXUWuUhqw4HFAbw3V8El7nvPFCckJ60s6JeEZt2jh6MxkLrK5xRn843Gza0XG9R
 JCgzQcblhUQgjxNY3mTeKjcB2f6nH7zu2dm5gwkbCfVDXy3buqBfioFIIMBk8Ok7MR/h
 78Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBMbwAGSdv7B/5l8UArqGYo9URDQeVI9Bpkavr0zzLfgPIaXqGvKwnWDzYGjJI8iLLI2uMXXGJdi8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLWYxaD4in7R9afqYM8Nt4G8NbZFC9NtXHpeTMJBrCnKdCkyBkS
 wauxxLs9tazJen2dx7ITQCfYfFjXi+9dzV0gOvBDQTWPBia3MAa5abNk
X-Gm-Gg: AYBFou3pOYfL66+MK1aRbbUY1p1G7fjFdbOYzgACANtHQb/MX4XWnbwSoL6igy306RN
 Ty7+o9znnQCTp7/P/7gJ4m6aeQlLKfCM9cSr6CTfxbqtRgYKFY05pJC7cYJZkdTdSQ62rbJTN3d
 Lh9NFOeXtnK+7GdvhXzn2G7pSKrixuENtMwKuLdRufIzX8MIixZToKhEHvMb5KTBWDSqA4LNws5
 IH/HW3XIZltFApeZSVnPxLnHmm5cRc1gIY3fS5/cYsb3/mVoUuJJFkFV0vA2ksmOJWHuYbN+Bvk
 sQoQNDe/88RytKsj4TZ2oBVvaqEMAat/l5hJOUPLMbWDzHIzOxYuAJSZVseuHGWyhWL7cb3n1qa
 T4RnwJHHve8fkMOY5flfVbTVMjDaoRRInmmm7mqSd6zBQvF/LrtkOnPmwJHobNiGYC434tPfbxd
 M3Qotv9q4r/CGRB1z7q9qcdGYuc5LCuB8A+Ibgu+SiscOWFMENuyJYBwQGL19coBnOzyu764xPV
 d7lGPp4nQ+RD6fbvlxZUm3bnuCH8myoVu15lK+w8r2bGgyuGMxb5TTgwzU5D6+2/uJU2+gtiI8m
 1R7jJHwVRb9Ve6b/whsvGd1cexeHiekFL0AP4OWWodsuInd/PC8UowaCLKtNtp4m0e/zF0ArkXs
 XfdBCwN8onLu/pxTO5KEHkZZbYx/cAX3dKEKeW+Rq4t0oFehaU84wQKJ7tkYPxNzB
X-Received: by 2002:a05:6000:4386:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-48e3eba7fdemr8948523f8f.37.1792994335994; 
 Sun, 25 Oct 2026 22:58:55 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b1a4-1201-5c78-89f4-99d8-70d7.310.pool.telefonica.de.
 [2a02:3100:b1a4:1201:5c78:89f4:99d8:70d7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f25fsm13901379f8f.2.2026.10.25.22.58.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 22:58:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: Fix dma-buf reference on import errors
Date: Mon, 26 Oct 2026 06:58:42 +0100
Message-Id: <20261026055842.96484-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tegra_bo_import() acquires the reference retained by a successfully
imported object only after all attachment and mapping operations have
completed. Its detach error path nevertheless calls dma_buf_put().

drm_gem_prime_fd_to_handle() holds a temporary reference while invoking
the import callback and drops it after the callback returns. Consequently,
when mapping fails after a successful attachment, tegra_bo_import() drops
that borrowed reference and the caller drops it again.

With only the installed file descriptor and the temporary import
reference present, these two puts reduce the file reference count to zero.
This queues the dma-buf file for release while its descriptor remains
installed, leaving the descriptor without a live reference for later use
or close. On a Jetson Nano, forcing the mapping to fail after attachment
produced:

  VFS: Close: file count is 0 (f_op=dma_buf_fops)
  imbalanced put on file reference count

Remove the unmatched dma_buf_put(). Successful imports continue to take
their own reference before storing bo->dma_buf, and tegra_bo_free_object()
drops that reference when the imported object is destroyed.

Fixes: f5b8794e17e4 ("drm/tegra: gem: Don't attach dma-bufs when not needed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Found while auditing Tegra PRIME-import error handling for
CONFIG_DMABUF_DEBUG testing.

Tested on a Jetson Nano (p3450-0000) with CONFIG_DMABUF_DEBUG=y and a
separate change that rejects zero-byte IOMMU mappings to exercise the
post-attachment error path. Without this patch, the forced failure
produced the diagnostics quoted above. With this patch, 100 consecutive
failures returned -EINVAL, preserved the original dma-buf FD and left zero
dma-buf objects. No file-reference warnings or DMA-API errors occurred.

Additional regression coverage passed 33 dma-buf heap selftests, with
three vgem-only tests skipped, and all seven udmabuf selftests using a
volatile 2 GiB HugeTLB pool.

 drivers/gpu/drm/tegra/gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index f76af73..ed35a34 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -502,7 +502,6 @@ detach:
 		dma_buf_unmap_attachment_unlocked(attach, bo->sgt, DMA_TO_DEVICE);
 
 	dma_buf_detach(buf, attach);
-	dma_buf_put(buf);
 free:
 	drm_gem_object_release(&bo->gem);
 	kfree(bo);

base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
-- 
2.39.5 (Apple Git-154)

