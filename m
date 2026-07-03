Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F44C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1F710F64F;
	Fri,  3 Jul 2026 06:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jV/mu9zH";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37BCF10F64F
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:35:28 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso218053f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783060526; x=1783665326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5nzq7a1ESEwR4QVo1d/CJQNhFbIp6HJBMyLysl2f+yo=;
 b=jV/mu9zHadQ69odLX1OcjJ+P6uQWLh7lJnnsGUQ3PP0sCPko0b7IOP5Wrdfzc5bs4V
 JgPGFWMqK1Xss9xDeDRMH8+woYm46SC+0xIHMbMcPmLZs396q6h3TjzRY+84fQD1Lbx+
 207jmd0TJrclNIi7qWH8ojL36CcY6kf0gi+s7zjy0lloNVjs0b3m81jFBMrYzIuqdenU
 U3NNydOSOBuhE3vR8nw5+Fikrcwqo33vI7WETvNZCQxeDj8kFa2tNQVCFj/jtIuNJjDn
 9jbWbVNZ6yTHb05autYjzmbg52yvo9ewfyvPYy74NkZWcQ0X6uKT8++oworo8ULsH7vL
 38fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783060526; x=1783665326;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5nzq7a1ESEwR4QVo1d/CJQNhFbIp6HJBMyLysl2f+yo=;
 b=Ty2PLEbfYxjsw6ddnn14jWouSWjKNov3JVtrNBmxtwHTxZz5yuDIGi1s3ZCRVoRfCO
 Tm/A6KqWwSXaJMFYO96qDkZIrifg8fu1wUHaJKtFVC+ov8TSzjSLcRs77xZzDgoHxGKY
 zluQWD1FnwNI5ocld8t/mWc+t4T/fZComIO797aTd+tbKDpoTdYZEZzA7tt60AnKKXX5
 KDlvA0fe8qte+Ro2hI8m+6s5oDZYZtQACpYbrPliznti+aEnssBbtbceWThoQ37qOxjK
 nItYl+ZK6FJq/RgDdP2ErCwn5icoeYUuCpY2hr56BUaH/BMZDxKzmG9rYw/cHOUoQE66
 JxeA==
X-Gm-Message-State: AOJu0Yxd2CXZMGz/9Xle/Cjf4QFvIyrBUsq1kab+nyM71vHKvEXgLGZP
 BIdgxka0+KGXLmTc6A64g6spFFSFzYTuMy5w2fIj1DEvk4n7rXYcRQTpLzHATw==
X-Gm-Gg: AfdE7cmALrSnPMk2WNXnSLz04FCKBgWws/5oKHDSNv6RGBLK9m9S0XIxAWmayup/Ty5
 rNcRLYPB+RyZr+awzBNegOuilYsKWQQKqqkpgPoSUu7rnCR/0FIG9wrqOr2l01OD24pmTw1kOzF
 nR6aeCDHxsgb7vv5uU8NYkanOaOemMUIuXKDk9YfVI1Owvrx2To8AMUCbng6duKhrmEbm6jYC/O
 Luk1QoBU5aWP+VhWjWUniapWfndddSge/zcQLs8hF/z+URGOVXl+Qh0v2DC7wjU9fglPKa57Yj9
 U6v2vvq4YGybjZCnJQA6wK7HigRtHvjzAgabbSwTg1SU/1QbLTLbZIEv50oY9ltTx8hc64fZdVG
 3xJmIsDgwqdTrcwPPUSUHxgBYqW6KE92dCwmKDcCuid50/5iJslDkXSHu2+rardQzXWo3kqXYre
 LnMHxo7G4YFqX6jYy3HAFGQw==
X-Received: by 2002:a05:6000:2c0d:b0:476:cfa0:a976 with SMTP id
 ffacd0b85a97d-477aeb5c312mr12493355f8f.5.1783060526376; 
 Thu, 02 Jul 2026 23:35:26 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba3csm14687656f8f.3.2026.07.02.23.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 23:35:26 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/2] drm/tests: shmem: Fix intermittent DMA overflow on
 ppc64le/s390x
Date: Fri,  3 Jul 2026 08:34:25 +0200
Message-ID: <20260703063517.6346-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Two drm_gem_shmem KUnit tests, drm_gem_shmem_test_get_pages_sgt() and
drm_gem_shmem_test_purge(), intermittently fail on ppc64le and s390x CI
with a DMA address overflow warning followed by -EIO:

  DMA addr 0x00000001130b0000+65536 overflow (mask ffffffff, bus limit 0).
  Expected sgt is not error, but is: -5

Both tests call `drm_gem_shmem_get_pages_sgt()`, which internally pins
backing pages and DMA-maps them via `dma_map_sgtable()`. The DMA mapping
path is:

  drm_gem_shmem_test_purge()
    drm_gem_shmem_get_pages_sgt()
      drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
        dma_map_sgtable()                  [mapping.c]
          __dma_map_sg_attrs()
            dma_direct_map_sg()            [direct.c]
              dma_direct_map_phys()        [kernel/dma/direct.h]
                dma_capable()              Checks addr against DMA mask
                  -> FAILS: addr > 0xFFFFFFFF

KUnit devices are initialized with a 32-bit DMA mask
(`DMA_BIT_MASK(32)`) in `lib/kunit/device.c`. On systems where the kernel
allocates backing pages at physical addresses above 4GB, `dma_capable()`
returns false because the address exceeds the 32-bit mask. The `dma_set_mask()`
function updates `*dev->dma_mask` to the given value; setting it to
`DMA_BIT_MASK(64)` allows any physical address to pass the check.

The failure is intermittent because pages may or may not be allocated
above 4GB on any given run depend on memory pressure.

A third test in the same suite, `drm_gem_shmem_test_obj_create_private`,
already calls `dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64))` before its
DMA mapping. This series applies the same fix to the two remaining tests.

José Expósito (2):
  drm/tests: shmem: Set DMA mask to 64-bit in
    drm_gem_shmem_test_get_pages_sgt
  drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem_test_purge

 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.54.0

