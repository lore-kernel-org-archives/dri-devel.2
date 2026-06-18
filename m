Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE0BCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C3210EDF0;
	Thu, 18 Jun 2026 12:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Va+5djxM";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DE410EDF0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:00:53 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c03a466c96aso133549466b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781784052; x=1782388852; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W9ZVu+TQxqykUMzB+TkWY3eQThy4ReD8LVPOwN/E+6k=;
 b=Va+5djxMYXb2F4IftYELa/zj7jnxkn2i66bwcJjLxkFq2pMKFZft8Ko3aDbTuUpiAN
 md3qN23nZXxVSB+d6cH3WZYYjvTQNli69D+5/904moRYTBqCStNaOJg4eervyALp5MHa
 UY7PTMEaM7onmGIDXIKKpkV84aRL5mS0U5Bi60BxNWVwBwLYJ+6LjPCuaDmDv7qyI5Q5
 RxtdPkkITHIUIGn6qSE+fUa8Cck1mwfL9kx6wG1yTCrJMnbvY5o+hdkjWAGtd75yTCRs
 226hAe69vWWHsgPhITMhmDsBEwrT9EgOeHEpCbdD/UcJc7OpbnJFqIAaoIXwZdgPKp6s
 wevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781784052; x=1782388852;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9ZVu+TQxqykUMzB+TkWY3eQThy4ReD8LVPOwN/E+6k=;
 b=MroZOCTvTL4afXQE3SbeBzA+2maCy58sEW0CvCuANx+gPtoASPVHgOs1rvKbIoU58i
 gp85vmDNlCS7tGDcHi70W8cbIGHkPzZxGdaG69EG6CsmGW7ZZIt5kMtXLSwdokWBGRFO
 4g8qvbiqe0bqeb9fuiQQ/hzyLc3kBfqRtF0NKMCYkdKfevWWWKNxkVZ/FL3ITS6/sQZ+
 mYfZHO0eG/CDJCQYVmLqsuQCGbtDtDNGTjTeumntHlB50ayEjP56FmgjKMl/oBedC/1v
 5tFoazre0J6IUBFY00wXY0/SLaHwie9YZnWeRZfkn/+nyPekKbYqFrbL+mD0IPQNcc+V
 ESBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ODuxSjBc9/KRjwrrDoEeDfmeSA/PiXqpgojmB2nmQw6cTRot8GbHVokMg6o2paE26nMMDiQOEd5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCyoljNe/e0SyYanjXqBnlfxqXf+PsuvJE2metdtOMUZH9zCH/
 m9DlUktluJB/Ouz5oH9/fboZpM74Wm7pJE34NAt+54rETu7TsnNHDrldUwcpm/uex2Y=
X-Gm-Gg: AfdE7cmbDBgh+P87Oo7x1jHq66DY6DPPGcF8922Zo8x0WDn0sTj+lAvq7zRE8tnFDT2
 XzvNIoVZ4gMay0HBPcHc+Y2mV5vgYwQIVBZJE/CCUdPbzqRvdh57nbfeToahYTzg/qAOGOlubiR
 kzJtzEWg7Tt8qd3oXiPuqtl5Rrxt5561yBGCZj3POtO11FxZpSmH+gSmx8I5qsi8fy6Vp8bnFxw
 jed+E2gJZ91nq5JLxUDYO8HYZFZ1c6dJION0iZmK5YikiGcEdLJl7XAwXhFqSwCllwb8tqV0iw4
 C1Nx5fS13p78DQYePu6YXGDhwiywc+/F35wKJZYM4FJ2GZnS6pVGzOuKsd4rlb60feZkkIPTuJy
 +0B5HGhIEV5UsiXpk9Xo9gb18gMUGIS+UtiZ0L+u5d6K0sjrSQ0M3kVFUweNxw41Vq63p0gtb8U
 jhme6ZueF9zve/wjHFVKIK+V2qtFzLdh7zczWmwfGwnzidLrHKqraatvtf8AnFJtoXIJdV6ZO7D
 Puis9o=
X-Received: by 2002:a17:907:94cb:b0:bef:8141:668c with SMTP id
 a640c23a62f3a-c07c4a063e6mr96074166b.6.1781784051445; 
 Thu, 18 Jun 2026 05:00:51 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (181.179.204.35.bc.googleusercontent.com. [35.204.179.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4420966sm954924566b.9.2026.06.18.05.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 05:00:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 18 Jun 2026 13:00:39 +0100
Subject: [PATCH] dma-fence: use correct callback in dma_fence_timeline_name()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOfdM2oC/x2MWwqAMAzAriL9tuAGm4+riMiYVQs6pVMRxLs7/
 EwgeSCSMEVosgeELo68hQQqz8DPLkyEPCQGXWhbWFXhwuG8cZC193L4fuQbtS2tMU75qh4hhbt
 Q0v+07d73Azf7nLhkAAAA
X-Change-ID: 20260618-linux-drm_crtc_fix-267655a1c89f
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
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

dma_fence_timeline_name() is a wrapper around
dma_fence_ops::get_timeline_name(). Since the blamed commit below, it
calls an incorrect callback.

Update it to restore functionality by calling the intended callback.

Fixes: 62918542b7bf ("dma-fence: Fix sparse warnings due __rcu annotations")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index b3bfa6943a8e..5292d714419b 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)ops->get_driver_name(fence);
+		return (const char __rcu *)ops->get_timeline_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";
 }

---
base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
change-id: 20260618-linux-drm_crtc_fix-267655a1c89f

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

