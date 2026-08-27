Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46970C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B78210F0EA;
	Thu, 27 Aug 2026 16:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="N+Y/YQoB";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7CE10F0EA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 16:01:52 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1b838f9b6so44471a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787846512; x=1788451312; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yLi7v7g15LnedtmXwdYoapwhUgM7Q6Gg36WKTShpPEs=;
 b=N+Y/YQoBe2v6gajdo2uvdxJj1cHegKzMz6ftZ3cY8+3gdmpootmqFIH6BgQjw1EXfH
 RF1WPHtxxg1Bip0QnjZtfdh6gXtYfWAPIemqrmwNJwtkH0r3+ItyWGeWIRyjMgDgPDIk
 kZ1MvMn2XVjnNzD/5rGJw5dgID9WgCH2JieGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787846512; x=1788451312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yLi7v7g15LnedtmXwdYoapwhUgM7Q6Gg36WKTShpPEs=;
 b=OGsGoAH7YgzE/3D7wyiw2ddRUsqTtM6fgpu+dPoYaMgXcmwHCiP8swGsCmwJ1bTK6d
 lzp6MVtFfL8+Dv4gW5psw5Qs6w0e94qDvY7GzmLWtknGZGG+p8fe+OSM5FwATFSORkZi
 HE6qyDPPE+T9df3MxMKJF4ugboYfDdK131KyDyPG57IdHutu+mU1pRqn0i3uwZl5iyA7
 Kv5BSDsWZHKhPws7YIhNEbbq3m7LJkkBB+kiDXCkuNYKGTgoH4oP4U0S0Y9B+FDqj+ub
 K5bxvN/9grftduUISKuIPjTNZokZj5fzdtBAyekqH5erPkgiYugA10Pp5uyuAYkog1Ue
 nbYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMJiDlccZ0crgJfqQNf4A47PiGT4lBZJDCN9++ve8wvkXrJ590ZNjdqi6jxcvSozHDg1JFaa6XJFQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nOMohX8XjQk4WsRU+prjzjNcjPGU82gJgyxqpz+Y+ETitIxC3x
 iKQtSY/K0OpQVrK36DFntkOk/z7YzMz9RBNQeU2hO9Y8SL0ZWe1Gjm2xamAoIU3rNuo=
X-Gm-Gg: AR+sD126qTwmc4dUYztLrymrwTzs9PSf0s3KPq0EK5BdaQ+DqJSxRDnxvFF6K79zdmC
 LVaL9ZzJx6VR+VoG3ZXipYm7pN/tVvLPFXIBp+mg3yAD+HSjz1svJHWia44Zrzh4pTch0R2Ev6K
 m6ExtIGI+16vQ3m0jbZsf0FAKMoQC54awClF9osAr6C+ro3f7xwDYUD2ZnKpZD1x9BhCr8jITxz
 fNliNwT7kU5lNZ5MGNJpGtGYuGPsQC0iNntXNnagMEMiMU+V1XVqrRYxnL5pCh3fJDYitENYc9j
 Njs4ueana8SPJbMo0A7tyswyAwEGBFi6vKK6YKeFM9B/oylxuNQTDkV2b0DLgmUPtNeexdiaDd0
 o8PV608XAjYTLGa3TkLqqhHU9mDCOitlFg+rJL9rBXeqRJYFDsXAReGOnd2ThIGcZpkixySpEYv
 z0TAX/HAFZRvtvIzGcJYQ4c2WQahmz/n66RH4M/vmD7WsCdF6Oy1ybbrKIqQ==
X-Received: by 2002:a05:6a21:4a97:b0:3d1:5c01:e6c0 with SMTP id
 adf61e73a8af0-3d15c01ef14mr12486129637.11.1787846511540; 
 Thu, 27 Aug 2026 09:01:51 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535a8bd941sm2178632b3a.18.2026.08.27.09.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:01:50 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>,
 Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH] drm/radeon: check radeon_ttm_tt_pin_userptr() return value in
 bind
Date: Thu, 27 Aug 2026 16:01:23 +0000
Message-ID: <20260827160124.679309-2-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827160124.679309-1-hsj0512@snu.ac.kr>
References: <20260827091532.340141F000E9@smtp.kernel.org>
 <20260827160124.679309-1-hsj0512@snu.ac.kr>
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

radeon_ttm_backend_bind() calls radeon_ttm_tt_pin_userptr() without
checking its return value. If pinning fails partway through (e.g.
sg_alloc_table_from_pages()/dma_map_sgtable() failure, or an invalid
userptr range), ttm->pages[] and gtt->ttm.dma_address[] are left
incompletely populated - containing stale entries left over from a
previous bind cycle, or uninitialized memory on the very first one.

radeon_ttm_backend_bind() proceeds anyway and calls
radeon_gart_bind(rdev, ..., ttm->pages, gtt->ttm.dma_address, flags),
which writes those stale/uninitialized DMA addresses straight into
the GPU's GART page table entries. This is not a bounds violation
(the table indices themselves stay in range), but it programs the
GPU to have DMA read/write access to whatever physical memory those
stale addresses happen to resolve to, which may since have been
freed and reused for something else.

Propagate the error and bail out before calling radeon_gart_bind().

Fixes: f72a113a71ab ("drm/radeon: add userptr support v8")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index cbc0339cf127..58bd1e73587a 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -431,7 +431,9 @@ static int radeon_ttm_backend_bind(struct ttm_device *bdev,
 		return 0;
 
 	if (gtt->userptr) {
-		radeon_ttm_tt_pin_userptr(bdev, ttm);
+		r = radeon_ttm_tt_pin_userptr(bdev, ttm);
+		if (r)
+			return r;
 		flags &= ~RADEON_GART_PAGE_WRITE;
 	}
 
-- 
2.43.0

