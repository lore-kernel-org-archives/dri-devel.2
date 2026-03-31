Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C52FF60CF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4F510E85C;
	Tue, 31 Mar 2026 06:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KYjl3cbi";
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0AF10E862
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:17:03 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-38bd60d7a2cso50420861fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774937822; x=1775542622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=slrIynpsyCDGbw/DVJ139y58tD8HDF7VkYtGZ4Dd10U=;
 b=KYjl3cbiqXD1V2LSE3rOHTotoq21mJE1uC9i75jAQR5DiaJ6jKLxz37NqEPPJLmJIZ
 wBq2gKPt6GU++CO0UwpC5R/YQrRTExuTr2wfVney9QRwz/zVKU8hmJL7MMtrDWlOm+L5
 l6jSv7Bp3/VRw4nSoQej3HvvI7lEsPyNhG0iMk/477Q+SQWVvsIcDH4VkLSyOdp1RSNr
 9Hsq1Cse/NGH2A04E0uFTUxvDeVvZNT2rZ4ep+zRRB8cYS3Ep9xrDJkC+ON1Rsy/vrGA
 9+mVfq5LG1RgQdO/j07CagTFJOrfC7ITefkmZWPFrGmFg9UK+K1yXGgL0YhUwYu4CEBM
 fzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774937822; x=1775542622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slrIynpsyCDGbw/DVJ139y58tD8HDF7VkYtGZ4Dd10U=;
 b=Dgjw0lmHgotViuFUbA+EMxyjRKsiJVVnL7TiYWSwcr2IypgC+x6XTf2JoQutVjfQ78
 aEPGZtoxynWAlpTtWyCQ4YfcdphJX0rEteSZcoX2YwfbamjLMj93RsylsDn02L9XjSMI
 +YVRKdpkojv5wie0uRt2Qp9CP5FPSCgKY+c6jIkZByKa17urBAYJaw6Dqv9iIOipkhLz
 UAslcFArwJGR1u3siVKKKYZoW/aKih90dRwYX5MpJunszCnoDRe6x4bxzDqGMiMEclKO
 oAB0Z+aGNUuO2kv/9Vjp/5+lFuIFl2exmqaRb76WKon21v8Myi325HZYL4TRTyhJVe23
 Gypw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeDm9vqS0/DCizAqVjPNc2aqc3LVZshCIZ7P/TXPYmQAp7y+WVsThc/RApFQUbRgEBdpYQ3uhgatc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+xNhf6aobEPwQCjJtPKdi0hgRsFVbFQuDLoIS68AC+zwKHuZj
 MksJe1Tjw/U0hody2PauOl2M3dGAjIL+pmNgS71nRWzmJNFlfmvGMZT9
X-Gm-Gg: ATEYQzy4xh1c4b8FJRfVsoTWS7DlvJAJxdp/TnrO/cxfMKjkKo2ws8006RNwCuliiL9
 MoGoaVAHYJH7RHETc0JrNlg+gn19vO1iThTyrRsaRrKRd/AKUckvN92XmLR4mRGX81dQEoAMDNH
 TK1NUIj6QPh7RPNbveCpy4px9kya3ghGKRiE2g4iPX2LQFj9Apf2ZWk3UG1CmIwyLhuKFEnOuDc
 iFPtGQM5yF73VVSITfe8MqFr9QlKJ/bp7yGUsB0rTRIGcWyZpQfBARSmyLvfGEip6wvrjVanzDt
 ERN4lHcXHCuyXiQXH6PDhT9qYcjqw3MXY2kqS4CASaG+VCwG1YK+4FXWUlb+4f7NEcDufXwiwrP
 W4qZ3te++KqdagQSpjrRtTFcOrfWV52yp+QJtdOtz2Xv/FZthTPZFBNSOfG8EV1LE5WC6mm9TzR
 mo5kebGatEGSbCckBpMwHZnS3tzJlrJOPy7Q==
X-Received: by 2002:a05:6512:3b2c:b0:5a2:b3fc:b877 with SMTP id
 2adb3069b0e04-5a2b3fcbaacmr2578412e87.25.1774937821564; 
 Mon, 30 Mar 2026 23:17:01 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1455e14sm2145277e87.64.2026.03.30.23.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 23:17:00 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: kraxel@redhat.com,
	vivek.kasireddy@intel.com
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline
 EEXIST warning
Date: Tue, 31 Mar 2026 11:16:57 +0500
Message-ID: <20260331061657.79983-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When CONFIG_DMA_API_DEBUG_SG is enabled, importing a udmabuf into a DRM
driver (e.g. amdgpu for video playback in GNOME Videos / Showtime)
triggers a spurious warning:

  DMA-API: amdgpu 0000:03:00.0: cacheline tracking EEXIST, \
      overlapping mappings aren't supported
  WARNING: kernel/dma/debug.c:619 at add_dma_entry+0x473/0x5f0

The call chain is:

  amdgpu_cs_ioctl
   -> amdgpu_ttm_backend_bind
    -> dma_buf_map_attachment
     -> [udmabuf] map_udmabuf -> get_sg_table
      -> dma_map_sgtable(dev, sg, direction, 0)  // attrs=0
       -> debug_dma_map_sg -> add_dma_entry -> EEXIST

This happens because udmabuf builds a per-page scatter-gather list via
sg_set_folio().  When begin_cpu_udmabuf() has already created an sg
table mapped for the misc device, and an importer such as amdgpu maps
the same pages for its own device via map_udmabuf(), the DMA debug
infrastructure sees two active mappings whose physical addresses share
cacheline boundaries and warns about the overlap.

The DMA_ATTR_SKIP_CPU_SYNC flag suppresses this check in
add_dma_entry() because it signals that no CPU cache maintenance is
performed at map/unmap time, making the cacheline overlap harmless.

All other major dma-buf exporters already pass this flag:
  - drm_gem_map_dma_buf() passes DMA_ATTR_SKIP_CPU_SYNC
  - amdgpu_dma_buf_map() passes DMA_ATTR_SKIP_CPU_SYNC

The CPU sync at map/unmap time is also redundant for udmabuf:
begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
access is requested through the dma-buf interface.

Pass DMA_ATTR_SKIP_CPU_SYNC to dma_map_sgtable() and
dma_unmap_sgtable() in udmabuf to suppress the spurious warning and
skip the redundant sync.

Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v1 -> v2:
  - Rebased on drm-tip to resolve conflict with folio conversion
    patches. No code change, same two-line fix.

v1: https://lore.kernel.org/all/20260317053653.28888-1-mikhail.v.gavrilov@gmail.com/

 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b26ea706a3..bced421c0d65 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -145,7 +145,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 	if (ret < 0)
 		goto err_alloc;
 
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
 		goto err_map;
 	return sg;
@@ -160,7 +160,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
2.53.0

