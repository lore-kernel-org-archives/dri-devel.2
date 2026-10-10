Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CC6CA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 18:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05E610E00D;
	Sat, 10 Oct 2026 18:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxwR4OHq";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7594010E00D
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 18:07:22 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so5519125e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791655641; x=1792260441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4cQOSGMTi903DsbkZFEEk4+RD6TWLVh4oE9VBqnyk1A=;
 b=HxwR4OHqgyhFUDwgqcV/SiVDRKkGPvSZSAGc/vGwz4oGvUD0DCCCBg2TgZakOkZv1u
 azWXuFbLPa0SPSxXj7HM8JorOj5t1de5FCK7AsfuC1sTp4PBrRQitKn+u+BDML/muzkF
 oMGpC2j3M3OfIcNQ4VKZ/tQUsAi1t2MYSfy2M0kjK9eKE/yVQra6Sf7y42EdQd5w1sZ7
 tj78GrZov2Z6bSO5QJu4oM1Gn1UPLolSEG5wTpnZ6Czvj00TNTzTCxDNAw5wQF+i6BTx
 TuZiszF8i0jCY+IlKV9zNtiUu1Pek9uLNVqsWyO5kddKVa1m9NEWsH9D/PcF/bxmm+5m
 BYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791655641; x=1792260441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4cQOSGMTi903DsbkZFEEk4+RD6TWLVh4oE9VBqnyk1A=;
 b=0JV4+Q4edQhDQfS0XL2BpE1dyX3zS6hiH/qzpkUkqibVMm+E/+grKhBkAeqWZ74K8N
 eAtDddVf9hvaGu0rTipkNm+ec/UZ1AzOQO+Pp6LS75oxXFaAqn6yOZwD+PwmpCmlm9XS
 6OYFIpSKQ1mFBLoN67Zs1jC5b+8m9380mR7PcwJKjz34QsIzNO9aEfZOSp3NZGG/w1v9
 VFW0dHP+jYhsciSGmEtWxFEQwdZUggOC41ue/GfiXnsTRtCJ1sqrc8fU3QxjQ9nPoRIT
 nRlEO/MDoN4ZDYltxSsYcfU10PTRDMVN4geiCZ96S6+vRmfx3p+MLhMvIfAd/RSpWf3p
 ITpw==
X-Gm-Message-State: AFq9FYJcrm22npLORMmnM3n1FaiKl9Nk+mqcMC5KtbIUrLKPejKnzAe9
 QS+AEAa/z3VpA5j8Z+QfaCvhQ89X+FFOggCVHqU0Wkdp788XvpczjRN0
X-Gm-Gg: AYBFou2jWsKQflvYagKlaCwGQFnU8hC5UqA4YKVq/VBv4iJocG9ff0w4glqZKucF8hV
 gzxTfBpQzbtexrytJBpU28u1czjS+EaVveSA6ijTs/bsU2W2WlnFFhaZun02nl0SAsWLTpYz3Rc
 zuFhS/PWs2rUKcOFYbJzxQ+zvkGvd8aWvVFSiXCSK4LxfSv4qqAXOLT+Rnwzmt8uYu/bJLhLZ/f
 Q6jfPQ1crivCgeujlwEE+3yBeBp7yflmYBa1NLqVoNj1aymO2qg1Cs6/I8b1WyVt0OzLCJF1jxJ
 XsbkgazP+96hwftoZ9BzbN3e7QhL4hoRmntlsURDpyEnv3+hSU6zo7wcZmQvYFE+rBE2lMx0qU6
 j1m6VUVPK8ZJpCjFNLPflBSruuG7Lin4tdiBv2uwUV2t68QUlEhz9fhKx+Xx4ZxHOt1oaFugSg+
 6+pR82EfU2TxOC/+LW1y6HDQYiQKbKvvLC6o0+4o6VNMblDMLbdSYE/fyXbrdQlC50ODBZrOzK7
 FTxFkg5eKvkPNV7ROsUGruj1N16Proq9GwW9M7UdfwMURS6QpSNWw==
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id
 5b1f17b1804b1-4a18e4d2b31mr106881115e9.27.1791655640518; 
 Sat, 10 Oct 2026 11:07:20 -0700 (PDT)
Received: from desk (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm9617208f8f.13.2026.10.10.11.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:07:20 -0700 (PDT)
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
Subject: [PATCH 0/2] drm/syncobj: fix sync_file import into timeline points
Date: Sat, 10 Oct 2026 20:07:09 +0200
Message-ID: <20261010180711.1548333-1-ju.orth@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Importing a sync_file into a timeline point
(DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_IMPORT_SYNC_FILE |
DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE) has two bugs since
c2d3a7300695:

1. The fence and syncobj references leak if dma_fence_chain_alloc()
   fails.
2. A sync_file that contains a dma_fence_chain (e.g. one exported from a
   timeline point) is wrapped in another chain and triggers the
   WARN_ON in dma_fence_chain_init(). I reported this on 2026-05-20.

These patches were developed completely autonomously by AI. I have
reviewed them, but they have not been tested at runtime. They are only
compile-tested.

Julian Orth (2):
  drm/syncobj: fix fence and syncobj leak in
    drm_syncobj_import_sync_file_fence
  drm/syncobj: flatten chains when importing sync_file into timeline
    point

 drivers/gpu/drm/drm_syncobj.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)


base-commit: 6ccf996a0dec1852dab94ad865f27b4904750e12
-- 
2.56.0

