Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F93C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9B710F0D0;
	Thu, 27 Aug 2026 16:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="OiipsV10";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1185810F0EA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 16:01:37 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso1090919b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787846496; x=1788451296; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7sryVqJwijt526l6++VdXSITZiFhPfcV5wF4kc67w4s=;
 b=OiipsV10svfhMiovOn3v1SR0g35ovedJcRfO7N+pqqb5y1C7wbuMcM/GlqIyvel56Z
 bD3vuscDp/ReQCx+L6SMxlJldRqjU6RMr76GlyA8SFPJfeFTJEOckJEjaF7MdDN0hXt5
 qiOCNjqVa6Ul4MNuVJAIxMK8OU0NcaebjfPDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787846496; x=1788451296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7sryVqJwijt526l6++VdXSITZiFhPfcV5wF4kc67w4s=;
 b=T+KLxHRqv4cHcb7wcIRkOFTYCGR7jgcsyzSDABAcQwZDxq7j4FFkNGTUtcOzL+IOGP
 3FYDTR/utdQe3+0oO2rkSIlBgb+zFlfSbZo9VZnJzlQPFRJPg/xUyu0Yj5+iKdDRXzTv
 K0ILsb1qciqUkEOvbY+ldr+SLbkapWvBvitH8D8Uc2gACnnlOIslCjbRVjQ4/TP4dCXX
 4GONNCl17TJwOdzCBYJSFrz3Psil30qRFhaXsVa9wjKJ/vo5yp1Y9iuj8fHWDa8F5JZe
 IIeKgGQ6a/prftU3uR9ThofgxUc+yn7HCtWpZiys2meB7Xqtc2KsRowCiMfLOdgN20kb
 3u9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJ5os9cG5+PTJ/uJm6LDPpKq5zc2Y4MRbIyPuthlgKdLKQdOLmjBGkTbX9njyzgnH945m1q50V8ic=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mjaeGrWL6BD0ixF1iOaQ6CRAtUsiVMKgcKeHOEk2EKQZmVp5tz
 xP61q/Vhy+dk8TCdtpIrr6NYGWYxKDYfHEWvoq8MdI7biECbAkZIIZD5/5tU20FMht0=
X-Gm-Gg: AR+sD13ignyWRkFXHzrGa5MF2aTPeKOjY7N+wwXUiTB3yYvHCA3mTLRv7o/oNHTyLB8
 dQlfZSyoTZ7QWhBnli+DT3iRwFY3jAV1al2lNbUKpyt7iqxqmDh6rUqBJ5eYasH845N7lHM7PMD
 yYjFQk63cyMAbF2AEnaUV/D9MRFFD09dd+0d+RBQB4ub/G/eNAW7muO4hHTAtDRKFQvZbfW6RnD
 TtwrqMX1Zqa5YU6dUyy8g1bwWcn+XJNjt03k8NmxZsQSbxTydPz2pVo0dECKuE33ueWED24PWSO
 TqJES8uhym998859EJtoFXt9U5pJCjgljr5iLvmh5moxGFEX65go4SXUNBe84TiE5duuyyV2X5f
 B4nNGv8hw+hF+HUfE3hd+lZ02YUFu2ojRkCiLjvFZJrheI1AliHxbeB1Vt5kdDY89o1HPy19KIh
 cPb1qRxduzONf2I8CvIKG8RoguLs2U2WAFlXmVKnVM1ZsD4f6h60tQT/Y+/w==
X-Received: by 2002:a05:6a00:4fd0:b0:84b:9a69:156d with SMTP id
 d2e1a72fcca58-8562543f74cmr429998b3a.0.1787846494915; 
 Thu, 27 Aug 2026 09:01:34 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535a8bd941sm2178632b3a.18.2026.08.27.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:01:34 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>,
 Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH] drm/radeon: fix double-free/UAF of ttm->sg on userptr pin
 failure
Date: Thu, 27 Aug 2026 16:01:22 +0000
Message-ID: <20260827160124.679309-1-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827091532.340141F000E9@smtp.kernel.org>
References: <20260827091532.340141F000E9@smtp.kernel.org>
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

If sg_alloc_table_from_pages() or dma_map_sgtable() fails inside
radeon_ttm_tt_pin_userptr(), the error path frees ttm->sg with
kfree(). But ttm->sg is not owned by this function - it is allocated
once in radeon_ttm_tt_populate() and is only supposed to be freed by
radeon_ttm_tt_unpopulate(), which persists across multiple bind/unbind
cycles of the same ttm_tt.

kfree()'ing it here without resetting ttm->sg to NULL leaves a
dangling pointer:

 - radeon_ttm_tt_unpopulate() will kfree() the same pointer again
   later, a double-free.

 - Anything that dereferences ttm->sg in the meantime (e.g. the
   "!ttm->sg || !ttm->sg->sgl" check in
   radeon_ttm_tt_unpin_userptr(), or a retried bind calling
   sg_alloc_table_from_pages(ttm->sg, ...) again) is a
   use-after-free.

Additionally, if sg_alloc_table_from_pages() succeeded but
dma_map_sgtable() failed, kfree() only frees the struct sg_table
header, not the sgl entries array it allocated internally, leaking
that allocation.

Use sg_free_table() instead, which releases only the sgl entries
this function allocated and leaves the ttm->sg header intact for
radeon_ttm_tt_unpopulate() to free later, matching the ownership the
normal (non-error) unpin path already assumes.

Fixes: f72a113a71ab ("drm/radeon: add userptr support v8")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 22fc35a0e8d8..cbc0339cf127 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -374,7 +374,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 	return 0;
 
 release_sg:
-	kfree(ttm->sg);
+	sg_free_table(ttm->sg);
 
 release_pages:
 	unpin_user_pages(ttm->pages, pinned);
-- 
2.43.0

