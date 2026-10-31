Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608C606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alwcupk2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642C410E0D9;
	Sat, 31 Oct 2026 10:45:01 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A48F10E0D9
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 10:44:55 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1044577f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793443493; x=1794048293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4nZEer0OBORnNh+HtOSAonBsrwjZLbFagqy2gDjha3U=;
 b=alwcupk2NJJwSzOBYFyY5yiAT2rdePiwZBCS3QbLBTUHn966xhPTPwCUqv4hzPPO0/
 pWUWU7nV+Af0DmfqM+Z7iPM+rN18pocon2+4zYIdiNBwJQN1OFS0JGc1lQRhQM7iM0iX
 9q9nEjGIGyIg0cTyFRp9xeODgeh4QIX+CZZqWZtmsMixprZ5mm0ytHDwp+07kUZBZtmS
 CrkZNJvEFx6oC81cA7sRvYYZxsg8dIYoEy1Tqi2qZJnKl/bD9osocNGdbTzo0E8rcPcR
 WDZByd1phlbqpXY8QHTf1AfIreV0U46e/nCofP8+xPulJSWAqGbOaJ17IsCF6bsGC5Q6
 ujMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793443493; x=1794048293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4nZEer0OBORnNh+HtOSAonBsrwjZLbFagqy2gDjha3U=;
 b=o9bf9aYfGHsrPIxESC/XteteOStSPfGb4boxPJqK46FgVQ3J6/nlmX6HRBClHk0tIf
 +oNQf1dCBZY3Tz+6mH33ub8zsjvr4AuenqdG+z2EBBXcW/OdX/eYT1QzIjGLm/b3RB2m
 OEVbF1b6BNUUJtOtl6ZiLKrH2diktoDqG3liUiFZPXsBfj1OqC6dg6mDCRskV83CaNnN
 /aHCKJAuYiuIXarzigQEzlZEBI4LM170xeixb8xTHQvmQT8cit2FS9Ps+uwSbtdbxCIV
 B2ivGxvQPHtVUa2q7j4O87XW6O8whKNUqPlPGij5r7Y6VtOiaZxJ7ex2/0AI3p4hN/uz
 xlOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtpN8X6lkBHcbGbwNkNmvk64kg654bTA3WFs3RRkmGSp+koX/IIWR5ZS/ZM8FzDMSbvlpQv+cOPIo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKtvFfz/7aZjl4yJjHP/wpFYkHWGaHrIaymFwpjqCMpUhxPZ6Ij
 mmsHNM0v9We5Tjp8/w06/vFkVr8wMysSrjO9QiZkUuYgS0tMhY3FgIr/
X-Gm-Gg: AYBFou1Wnb0oSFDcDVqNFwaORcFF/o1Rpe+vOs2/zkw4bH1JgHlVfrNbEGYuvsj/VlD
 euONdkKflOMaHVGSxaDibwmkip7HiqUHEt0QMYLTQFq2OPxa1BHiZGVf79Wk0GZzVQgoiWp8xhm
 bYvzQc8rNuW+axNlAnoDkaEwcck15fK10PLdAGZEVtSd3PnrO5nyRX+omkiX3uUqjlF1pSV57iG
 0S/XgPipfUPWWbbpbj0D1Z8dyKp6xMmyu8t+07SqcerdiTT4d5JZ8KJxp5nq4/dMJ+Afl1IkAct
 i60ka6+o+0r//iJd+lVnATF4o+QKjXasxfEgnhgtPL81GyHh07XJtWIQ3gdK8V6EY/m9Pihi5di
 IiVubPEKgrgIESZdAs8QrWkiPAhHSeEICNJ5EanCrOjDge6rQzaoQl8+D3aqDQCY4JCM2zbXNdl
 8qSn0yVf5mz8CJIIfn+76RsdwiReVQEDJchlSYiA7+ZKvtloN/YgGGecjLvjJpHlS/a8L7486Es
 7McZFGCFAQS5cqrw2N9M+ZR8gVVrWc/IzBH3JycTtC29NSKKHCLGwMtXMwAQ83VIDWYkJQp6mcC
 KKJ+uVVBnitJVBQsxEUzvZGeGBmrlEfwZzt8ykSPDnlWw9m3Xgkp8sHqr46OJgLFP4GrdMh39Wx
 ofpZk/To9RLteKaYUUR/QV3Etv9GpD2fG0vJpVufYGytibAoqEFWgXP6xwxCTK4SC/4mgANBPIW
 Rm8QheSe8IQ8UxAWtjzwvU7qV/Z3ronYk=
X-Received: by 2002:a5d:64a7:0:b0:48e:5e1f:9a36 with SMTP id
 ffacd0b85a97d-48e6e50191cmr8399741f8f.42.1793443493010; 
 Sat, 31 Oct 2026 03:44:53 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a81d-e001-9c9b-db33-f166-0fda.310.pool.telefonica.de.
 [2a02:3100:a81d:e001:9c9b:db33:f166:fda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm8093899f8f.10.2026.10.31.03.44.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 31 Oct 2026 03:44:52 -0700 (PDT)
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
Subject: [PATCH v2] drm/tegra: Fix dma-buf reference on import errors
Date: Sat, 31 Oct 2026 11:44:39 +0100
Message-Id: <20261031104439.91346-1-kmehltretter@gmail.com>
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tegra_bo_import() takes its own dma-buf reference only on success, but if
mapping fails, its detach error path still calls dma_buf_put(). That drops
the reference held by the PRIME caller, which then puts it again, and can
release the dma-buf file while its descriptor is still installed:

  VFS: Close: file count is 0 (f_op=dma_buf_fops)

Remove the unmatched put.

Fixes: f5b8794e17e4 ("drm/tegra: gem: Don't attach dma-bufs when not needed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: Clean up the commit message (Mikko). No code change.
v1: https://lore.kernel.org/r/20261026055842.96484-1-kmehltretter@gmail.com/

Tested on a Jetson Nano (p3450-0000) with CONFIG_DMABUF_DEBUG=y and a local
change that rejects zero-byte IOMMU mappings to force the error path. Without
this patch the forced failure produced the warning above. With it, 100
consecutive failures returned -EINVAL, kept the original dma-buf fd and left
no dma-buf objects.

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

