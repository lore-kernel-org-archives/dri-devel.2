Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B7ECA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 18:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7918B10E097;
	Sat, 10 Oct 2026 18:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sjcqaQ3i";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC33610E097
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 18:07:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso3680485e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791655643; x=1792260443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DRdRSHL4zHnCw7Uu5TIKezwFTjyQd4oKLN7dpP508Sk=;
 b=sjcqaQ3inHXozjJx9fnonuiLgh3uDMFHH1AQKmFfwTUqbN3Ll8KkSN27H4J+Olj1sw
 9rKgcnzd6lUjXaXegegfA0+iRJFDBh3xU9sQl0/cpQk+CgiZZO2eOjmo0CwcqU8bNr9G
 iWWwBMSSJ3vsnlmihClSyFRsFrW0fjxTFGqToyYQiWxwkN8Mc6UjT73QXQH1dfiyjQwp
 VofhbnoDZCWc20IMRusYoyoNEG6yXq0clC+oQGPBHPVMOo6/VANB/qOmJedIdrZwM55N
 asXzkYOgfKTwg6K0sr1MkmjdZYgn1euUNaf+X8TzGH+Z/hE6JvBUZmPNWv3m2R+mdrZv
 TuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791655643; x=1792260443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DRdRSHL4zHnCw7Uu5TIKezwFTjyQd4oKLN7dpP508Sk=;
 b=ya6qTgTfDMobaQdP0qV5KMHBF3qpEN4Ht0XAa7rdQwRwvnlH1gJTqqKM/x1FxD1Ws1
 qDSYAbbQIGTX6Wn1P2UGC+HXEMUcqSgUSb5FaoGMJpbCiW3MZHH8WSL0h+dcVa8pMim/
 AixgezIRxJWcvzOCPnVoaSIv/9pPPolAi05x6Ucmnh2OYX81f4xsd0dt5ME3tilaN6pP
 jAyISnnRKGRLfEoquKcWDEe2mp46sH4fdNCriwSjnniLUNffqcs8FsUP1SKQWfq/FWCK
 i+z6J520/3Bn98gzOZzVTZEOSitC4KHAFtxhFkPinu3ko1X2O7+CO69BhoEfd+XvRAu1
 7phg==
X-Gm-Message-State: AFq9FYL1/81aHs5EtFSbFu4nvFY1U7RY+OoU5sjLrNP+MkUInz24moG0
 7n/c8SwipWUTJXpMDUI0tn1aMpkRPiZx2xCVtlRWPMRI/ZLw27LDgh3Bfk5HFdzC
X-Gm-Gg: AYBFou0BR84fN7EcaGigCkD1hicHnDAknOY8dWqO0TJseOSxL9YUJNa6br17cjqSFAN
 rb5+ZUfOywWX3ymjM1KoMpjiOrYHnHphKmdELQkrbzmItJhWSrlpjXM/cR5wmixwYVQFAHjr3Bz
 XJ7cPqfrZ1194pWOnKik7U0eS235ysKvZMOrk9G7BCKYRS46TO+01QeU6OAGAV/iQC0EYpyqS5s
 SqVzou7ch8c51ILl4l6/HWgglLhDmE5rgsbz4k5BAiLb7eAVDZ45vya78y9Xlg1g9fHqF9F8+e5
 jCKkUpwBiaGw17fwuIBl9IaYaMjqcqnw2QfBjGZclKE7GWo8RNo5znKGObaqpDzLzAQ8dycWcbr
 gYRkmDaehaQ4+Tidu2fNdhxdiU3cYkQhoAopINJRo5lCBXt6Kn9Ps066oTlM/1Es0PApH8DFnt5
 ecghnHMsgH2NGwIpGGJ2eZc6yx/GJ+aMnSre1EYArZgYt85kzNHYRi8qf4zVgGTial+mKjC70wt
 2U8HSchR+ucskGUkflWLDXRGnE0KVsacw/ZZc/dkZY=
X-Received: by 2002:a05:600c:3b0a:b0:4a1:779c:dc8e with SMTP id
 5b1f17b1804b1-4a18e4a01b7mr103655525e9.10.1791655642961; 
 Sat, 10 Oct 2026 11:07:22 -0700 (PDT)
Received: from desk (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm9617208f8f.13.2026.10.10.11.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:07:22 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Julian Orth <ju.orth@gmail.com>
Subject: [PATCH 2/2] drm/syncobj: flatten chains when importing sync_file into
 timeline point
Date: Sat, 10 Oct 2026 20:07:11 +0200
Message-ID: <20261010180711.1548333-3-ju.orth@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010180711.1548333-1-ju.orth@gmail.com>
References: <20261010180711.1548333-1-ju.orth@gmail.com>
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

A sync_file exported from a timeline point can contain a dma_fence_chain.
Importing such a sync_file into a timeline point with
DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_IMPORT_SYNC_FILE |
DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE passes the chain directly to
dma_fence_chain_init() and triggers

  WARNING: drivers/dma-buf/dma-fence-chain.c:286 at dma_fence_chain_init

because chain fences must not be wrapped in other chain fences.

Flatten the fence with dma_fence_unwrap_merge() before adding it to the
timeline, as drm_syncobj_transfer_to_timeline() already does.

Reproducer:

1. Export a sync_file from a point > 0 of a timeline syncobj with
   DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD.
2. Import it into a point > 0 of another timeline syncobj with
   DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE.

Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 5ca5163d0..c545af77e 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -742,8 +742,18 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	}
 
 	if (point) {
-		struct dma_fence_chain *chain = dma_fence_chain_alloc();
+		struct dma_fence_chain *chain;
+		struct dma_fence *tmp;
+
+		tmp = dma_fence_unwrap_merge(fence);
+		dma_fence_put(fence);
+		fence = tmp;
+		if (!fence) {
+			drm_syncobj_put(syncobj);
+			return -ENOMEM;
+		}
 
+		chain = dma_fence_chain_alloc();
 		if (!chain) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.56.0

