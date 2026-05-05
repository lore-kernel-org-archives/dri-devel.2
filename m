Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B01FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F5E10EBC6;
	Tue,  5 May 2026 22:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="FPNuhlyJ";
	dkim-atps=neutral
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com
 [74.125.224.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9870610EBC0
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:28:00 +0000 (UTC)
Received: by mail-yx1-f99.google.com with SMTP id
 956f58d0204a3-651d6347a69so385897d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020080; x=1778624880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yFgJm1o7U9xQEZ9b4LfHLjyrTl3yA1tMTPG1FhFRCKc=;
 b=WhZoy9AjW1XrECsCCMpIMzA4f+1pXpPrCzT9RCyhA8gwU6I5FsgPV6UlQcuBOTbW+Z
 AtJ+RqsGELNcXau6cItVbpxOe3Byv+jxcGG/TNdayN1JdemcONfo2wnAPKpBccj99XUx
 W3DxyxR+lmv7pv1q5m/e4hScUXy+NrlkfH5tVUac+T+8MLu8+vuxqNNFY4PwVW/wP+U5
 AAXHb+LNjwre+oETs8sDDvs3jmWYM4SzL2OcoLgsxGj9zfLc5IZ1c8OmSupSAUuIEkHY
 Qyiq0HfmsGBYzCFcCpHF2SmzF7nNM0p/+q2dDQEBh8KUe8PVBhOHgKUlGtZpNJsBHy0W
 xA+g==
X-Gm-Message-State: AOJu0YwqmzI6fGXbFxO1l8u95zckYv8hUWaElsdBctkETVWqLDfjgAfR
 Bg8mTq/ZMuG+qc/8kcYzwVaUBujv4K7He1a5z1jN6bMaK0NvzxKo69m1mGxB/Su762Dih6okiDQ
 3Que/52Bn+Ly5yYaAooWM+rSy/NYYYRBKhHywbJfWJhctQltWfMV34on3Ei42U960a0cjjFUyxM
 h31A1CZbG1m+WG2DEZors+w4lT0AaGOdRfonCHkwqUJbug062EmyPNrXlYgOBrsUANb1ql8BNDP
 QH5UJRIeDhywgcK5BXg
X-Gm-Gg: AeBDieuIWdzTOCr9XYYP5G2oVOsSvnhAXAS7LNPUu/M86BCRmkle6KfeOENWLGA/F7P
 pRCflSRcta/Kq2NCMyGmMuv/VVuXKOdipCW/Eiw+mU3Bz1ycvoS/tvC52GlSrfQqYJhUzBnvpq1
 LRXuYDyljgISBh5jz4BCV4rXXOYM0yb8vbZvvtZ7vLng2ONSPvYgBgDj7XJlX7ZeUt3jezjettH
 w27HP+0rHC8LmZUk3SQLVuWXFi/123t/tYbici0K3OchVYT/A3RL1BMLcNeJFys2y/3CgpzHDSJ
 iLoD79wbsgbQcZoi3d8Grf9qX5iA4YmQinC/zzDQv/FDcCCrPU1EKBzc3kQFKOC7h1cCaoHQ4iw
 pj4oSp+XFuyWgtpvp4VJp0mVuRjrqDra6d/U+VhNHEJGZl67h3H6FJBY3mmrcAJ4Ygdc2EdzFT9
 OJWB5vXbobYN00AaZ2Jnw8ez9H9FSZs7W/7/7cOMjjXBASni2l7GByBW6ROKbNSNIi
X-Received: by 2002:a05:690e:1285:b0:65c:72cb:8a97 with SMTP id
 956f58d0204a3-65c72cbc267mr2790528d50.29.1778020079543; 
 Tue, 05 May 2026 15:27:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-65c7adff02esm24537d50.7.2026.05.05.15.27.57
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b4bebd2b2aso10587166d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020076; x=1778624876;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFgJm1o7U9xQEZ9b4LfHLjyrTl3yA1tMTPG1FhFRCKc=;
 b=FPNuhlyJMPm7UUOzMC7Bj4QcsA6C+rkFcanAzkaOg1dfcOrehHZ/xwokb+HaK0ZZsZ
 GwM7m72fUdy7UdjBwwMexyGha+YAKPa+9jmnqDZ1fx5SVtt9p3lvzxLvwI4iFNk17rvx
 eNDkzZJxPOTyiQzVC0nI3IayDSIBRRpeJPpg0=
X-Received: by 2002:a05:6214:3283:b0:8ae:660a:be75 with SMTP id
 6a1803df08f44-8ba9e59e537mr80509686d6.9.1778020076646; 
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
X-Received: by 2002:a05:6214:3283:b0:8ae:660a:be75 with SMTP id
 6a1803df08f44-8ba9e59e537mr80509316d6.9.1778020076102; 
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:54 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 08/12] drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init
 failure
Date: Tue,  5 May 2026 18:22:29 -0400
Message-ID: <20260505222728.519626-9-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Two paths through vmw_vkms_init() can leave vmw->crc_workq NULL while
still leaving the rest of the driver in a state that calls
vmw_vkms_cleanup() at module unload:

  1. vmw_host_get_guestinfo(GUESTINFO_VBLANK, ...) failing or
     returning an oversized buffer -- the common case on hosts
     without a VBLANK guestinfo entry -- early-returned before the
     workqueue allocation.
  2. alloc_ordered_workqueue() returning NULL on memory pressure.

vmw_vkms_cleanup() then calls destroy_workqueue(NULL), which
dereferences wq->name and panics.

Fix the first case by removing the early return: vmw->vkms_enabled
is already false on the rpci-failure path so no work will ever be
queued, and allocating the workqueue unconditionally keeps the
control flow simple.  Fix the second case by guarding the cleanup
with a NULL check, since alloc_ordered_workqueue() can still fail
under low memory.

Fixes: 7b0062036c3b ("drm/vmwgfx: Implement virtual crc generation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..0d499917682d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -214,14 +214,14 @@ vmw_vkms_init(struct vmw_private *vmw)
 	vmw->vkms_enabled = false;
 
 	ret = vmw_host_get_guestinfo(GUESTINFO_VBLANK, buffer, &buf_len);
-	if (ret || buf_len > max_buf_len)
-		return;
-	buffer[buf_len] = '\0';
+	if (!ret && buf_len <= max_buf_len) {
+		buffer[buf_len] = '\0';
 
-	ret = kstrtobool(buffer, &vmw->vkms_enabled);
-	if (!ret && vmw->vkms_enabled) {
-		ret = drm_vblank_init(&vmw->drm, VMWGFX_NUM_DISPLAY_UNITS);
-		vmw->vkms_enabled = (ret == 0);
+		ret = kstrtobool(buffer, &vmw->vkms_enabled);
+		if (!ret && vmw->vkms_enabled) {
+			ret = drm_vblank_init(&vmw->drm, VMWGFX_NUM_DISPLAY_UNITS);
+			vmw->vkms_enabled = (ret == 0);
+		}
 	}
 
 	vmw->crc_workq = alloc_ordered_workqueue("vmwgfx_crc_generator", 0);
@@ -236,7 +236,8 @@ vmw_vkms_init(struct vmw_private *vmw)
 void
 vmw_vkms_cleanup(struct vmw_private *vmw)
 {
-	destroy_workqueue(vmw->crc_workq);
+	if (vmw->crc_workq)
+		destroy_workqueue(vmw->crc_workq);
 }
 
 bool
-- 
2.51.0

