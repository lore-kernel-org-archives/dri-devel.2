Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49B4CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093C11120A0;
	Thu, 15 Oct 2026 09:12:01 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42441120A0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:11:54 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso725348a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792055514; x=1792660314; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PVjmHGw5O4smXiseMBYfifX+jfasJS0dPUWrUM1BnS0=;
 b=FB2jz/paXh0Jmsh3fy36iEeY9iYAlaebN5yVwJ8UAgGc32Tb6g551m84sRRZ69PQ8Q
 1OMeQHJFgajMzsYwlHQiwhgztGth/46zrcV25XgqbGJhQBrUhT8+xRblIa5vNsimfkX/
 U437yuDltdl/4kGTKYWdskMDM9r67W0ZitU7/mHwDXKb399YFHoSdNcUhPSa14F+fZzD
 WFRkN9+Cp34TFw998ZcoxQSHGARQZJtzEgvgDeqLguUt7rtL11V3MtYVmKbNxhGgnTX9
 XmPodGsSifKPSPwSlXOXyplR8oIEEtDFZApdLBZn6aWQ6i/k+ayQmBx6tBw5wiMo/swA
 naIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055514; x=1792660314;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PVjmHGw5O4smXiseMBYfifX+jfasJS0dPUWrUM1BnS0=;
 b=su9oHdsUSXjxxOPEavPffyQ6d9IFFCGrfTIWmb7J3ISLbltQGV/4TagRFoOBVCJ3rB
 8L4n88n4i6R66+k5s9HunY0A5srdYExjyf1rBwhVcCE7W9YD7+xersisDa5SNURinv1B
 GBESiIcHlFIo9XwDcwHfzOHz8M/rkHLp8E+n329p57ivibaIinWa3upGbD6VuHowQLSq
 b/vMvWe8XEwDG+evmnto3K6GXo0PgifSstLI/Ukc3iPWJ4VUc/A7afM490Y0SrhahK4c
 EIPHosc14A9DaLxaVnPJMgNqCr56ZJxIN/KiFJdD5L4pGCqQv0RWo+iOo5oFgrqgfWtq
 qXzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDrBFgalV4f1Gu9+tWBvqitxX8t7juxthUtCya/oSY+/186TkWQlstowYbr8680Fme24E7NgP6+/w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIVj8UtHKGa6T6H4i9H/RYBu+Nsn34Qm3yxCKSLRhIFj/Nkjkwi
 tbFzaCyMQNOoXE1+FgRQu+q8FFcv1U2eH2KkGj9oDXSRxMANbj4kKE5p
X-Gm-Gg: AYBFou2MMIy/pNH7qHOB4yEbeoV+aMyRKeSX3lhKMOIgFI62FWyhZYykb+vSFdnwBXs
 onIjC9M65MY73VAMdlUFj4ctTu6nyvnsL6eX2RFH9cKBCqpK6M0vbw+W6Xbb6L3MwxXegfTQ3Mo
 JFhLszfmtQJPieAwfxN6jx3xN9HFwfKLiVpZKlZfpK3YIJiCKTJtMY9INQSsUP05Ip82seECmPP
 X5g0t6bts5BTkbuPIwbQ0NcGgRT5bA1PRJLin4L4CwkvQ6lRDd9Kflqp0jFylmFsr2T0eBjexS1
 oL0VWZdaBYf/PD4a6x3vn3XCc1G5v+a6v4qOC8HVGDtOJlDcf1txotFFPMIPgwF5DCrfsD2z/sv
 RNhThg88/EW6LmfNm2p0DdG3ATCYD909vhT0iTCYLz1RjChafxhF22r6ZCWj0KXC9w0H2PuIRzs
 slbbKWgYDfYAgJOJxwY8AsNhMemqUuWYJsreG4CZNZMIhRMFpb9px8XDbx1AXzLBDS/LQ=
X-Received: by 2002:a17:90b:4ac7:b0:3ab:f38:2b41 with SMTP id
 98e67ed59e1d1-3ab3a8e5b2emr16863678a91.39.1792055514281; 
 Thu, 15 Oct 2026 02:11:54 -0700 (PDT)
Received: from [127.0.1.1] ([115.88.114.131]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac944511c7sm3727363a91.10.2026.10.15.02.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:11:48 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 15 Oct 2026 18:10:51 +0900
Subject: [PATCH] drm/imagination: Don't retry a failed unmap in
 pvr_vm_unmap_all()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJqY0GoC/x3MQQqAIBBA0avErBtQo6KuEi2sxhowFaUIwrsnL
 d/i/xcSRaYEY/VCpJsTe1cg6wrWQ7udkLdiUEJ1UsgWwx3xcqcOqK1F633AYTCkjFp6agyUMEQ
 y/PzTac75A1wuhQRkAAAA
To: Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Matt Coster <opensource@mtcoster.net>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Brendan King <Brendan.King@imgtec.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imagination@lists.freedesktop.org
X-Mailer: b4 0.13.0
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

pvr_vm_unmap_all() repeatedly looks up the first VA and unmaps it. The
VA is removed from the tree at the end of this path:

  pvr_vm_unmap_all()
    pvr_vm_unmap_obj_locked()
      drm_gpuvm_sm_unmap()
        pvr_vm_gpuva_unmap()
          drm_gpuva_unmap()   <- removes the VA from the tree

If this path fails before drm_gpuva_unmap(), the same VA is found
again. If the failure persists, e.g. memory allocation failure under
memory pressure, the loop never terminates and the task hangs.

Always advance to the next VA, whether or not the unmap succeeded. A
VA that fails to unmap is left in place with a warning.

Fixes: a5c4c3ba95a5 ("drm/imagination: Hold drm_gem_gpuva lock for unmap")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-167146@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Tested with the IGT pvr_* tests.
---
 drivers/gpu/drm/imagination/pvr_vm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index cbdd15ed74fd..8ea6e88c8bd7 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -887,22 +887,25 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 void
 pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
 {
+	u64 addr = vm_ctx->gpuvm_mgr.mm_start;
+	u64 end = vm_ctx->gpuvm_mgr.mm_start + vm_ctx->gpuvm_mgr.mm_range;
+	u64 va_addr, va_range;
+
 	mutex_lock(&vm_ctx->lock);
 
-	for (;;) {
+	for (; addr < end; addr = va_addr + va_range) {
 		struct pvr_gem_object *pvr_obj;
 		struct drm_gpuva *va;
 
-		va = drm_gpuva_find_first(&vm_ctx->gpuvm_mgr,
-					  vm_ctx->gpuvm_mgr.mm_start,
-					  vm_ctx->gpuvm_mgr.mm_range);
+		va = drm_gpuva_find_first(&vm_ctx->gpuvm_mgr, addr, end - addr);
 		if (!va)
 			break;
 
 		pvr_obj = gem_to_pvr_gem(va->gem.obj);
+		va_addr = va->va.addr;
+		va_range = va->va.range;
 
-		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
-						va->va.addr, va->va.range));
+		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, va_addr, va_range));
 	}
 
 	mutex_unlock(&vm_ctx->lock);

---
base-commit: c347fef5f8f8927985bd67835331ce4cf7ff43a4
change-id: 20261015-pvr-unmap-all-loop-99fe2f2b7e3f

Best regards,
-- 
Gyeyoung Baek <gye976@gmail.com>

