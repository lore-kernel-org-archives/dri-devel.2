Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4613FED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCFF10F675;
	Fri, 24 Apr 2026 17:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a7dCTalx";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD99210F5AA
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:08:19 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7dccda31d3eso1680601a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039699; x=1777644499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCyLy6DDJKSoLzccYLKiC2rCMua8OU8Lv96sFiOKNFg=;
 b=a7dCTalxbGgbrx5tJuoRarIHQe7SES//NfHJiV12MmUEXeCWflq9gNGYqnvLrCLpQI
 ro9lGmIcqQilKbEgzYv0UOnz0J+EDsYoyzL1LsshqUAo/Q4Wa9LezJ4zO++RQ554uqWn
 6ZiwbXPKiHw/guy71t0zs7Exaq6CRtWf9tzEoewB1DxJvR+bWzPJTKphKEy8gZetLy1o
 8nLpvd58NgUrKwx94uYDo3w92ehmeDtBj2pI6vQZ3FrLdMARCPuXE3+gTXrUAMss7TFH
 omX9d+jPpGbMDNnNo/XcDCDBaTqvNpFDq9s7+fF8L65z8vpytYuFlVrdScSDa2CYWSZ8
 FMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039699; x=1777644499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QCyLy6DDJKSoLzccYLKiC2rCMua8OU8Lv96sFiOKNFg=;
 b=G0GTxZ4bUEY51F7c49WT7EltvywjBtVK3I1x/ZQgsvd23V3Q0DyCJQxDFCLMtHk2Gj
 3pH/nwX/bOE1yJkX+rly9QShjay9fPcXfmZYw0ourBHQc3jhT0iuJeVCxZG6F0h15J7j
 rmDelXzWEbd8cKgrfnNrorGbk1l71yUs3G3ZA056iLC7C8d7YkVUAkaSTYh755cZHQsL
 uxiI2B91gRDxPn25poJyKocgURUHQeDvkPKbopGwoYHpjXuNpe4D7S3K5hxWnJVE8Mef
 JFZjHJhrT0v45fmV1bwfwVSBT5D40pO03NA7u5/mnrFpZUO+p99gv2HhuHqfLZEkb6KB
 RxTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oJgBry23T81S22clkjnqe28vHxmPcDztSGVs9o8C971qnSVjJCnnTHEnt36QLclqvgSLuhEp4OG4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8sI9EPMGd1v4+DH4+auCCK4aDA6N8lrgNeemlvb5wVd2K/ugB
 gY5ETQHytNuBnjlnQF/Z+KXmLx87ZwCSEb6Hz/hQ9GUjiQCg8pU8wkw=
X-Gm-Gg: AeBDies2Qhi1IcuFWGVxpdR3Q/J+hyq7fjzFmzeQDa0iV9T1zWOOlviA0pq5mJoM/Wy
 5Jm914ZIMQMiZszjDELNXupPbjYe1ae7b6pYZ0QrBfyvnTjMYe3t/wBli8wkCWTH7yMlGt0/zTy
 curuSHRKnF8EeHG0YNaMv7Jy87y85zWu4UZYDodSQRs4SrwsQhOZgFAGVBgToTnhAPF8MsBWMbJ
 z0zhhp5aZDVKJjCZO+zHQgNCvo3Pfy6DN4SXutFn3a95arElq6S4ELVfuQ+6g4cu7j/CIe4OcXx
 l907wscnwrLmjtXrN2TbCNsmaFYBgafyso5MB0zOmXuoXJ3hJM+DJSYvrf93mVgc+0ofgVl8e/d
 8EqYo8DUsePZrKwBhddBife95OZVF0LBXdHFmLTAmo22JMEPFWqkRkcXsIjGQGGax0yY7WPWLQI
 aeEx++UaTgpywDFk9Wtj8E+fpH/oijbl+cPl3Ap0dNnc+EkFeVoUcMvbLy1WFPsumB4J4mZYMCf
 yuk1Y1Z23SX1rhHfazZJvGIG+kWxj+M2pk=
X-Received: by 2002:a05:6830:490e:b0:7dc:dd19:7f69 with SMTP id
 46e09a7af769-7dcdd198242mr9266087a34.17.1777039699009; 
 Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org,
 "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 1/2] drm/amdgpu: reject IB addresses with reserved
 byte-swap bits
Date: Fri, 24 Apr 2026 09:08:15 -0500
Message-ID: <20260424140816.43766-2-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424140816.43766-1-jbmoore61@gmail.com>
References: <20260424140816.43766-1-jbmoore61@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

Reject IB GPU addresses with bits [1:0] set early in the CS parser,
before they reach ring emission callbacks. On legacy AMD hardware
(pre-amdgpu era), these two bits encoded byte-swap mode for IB memory
fetches. That feature was dropped on all hardware that amdgpu supports,
but the ring emission paths still contain BUG_ON(addr & 0x3) assertions
that crash the kernel if userspace submits a misaligned IB address.

Add an early check in amdgpu_cs_p2_ib() to reject such submissions
with -EINVAL before the IB is allocated, and a defense-in-depth
WARN_ON_ONCE in amdgpu_ib_schedule() to catch any that slip through
from other code paths.

Fixes: b0635e808290 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 10d8dcc3a..53f537f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -379,6 +379,14 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
+	/* Reject IB addresses with reserved byte-swap bits set.
+	 * On legacy HW (pre-amdgpu), bits [1:0] encoded byte-swap mode
+	 * for IB fetches. That feature is deprecated on all HW that
+	 * amdgpu supports, so these bits must be zero.
+	 */
+	if (chunk_ib->va_start & 0x3)
+		return -EINVAL;
+
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f1ed4a436..3111d2c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -272,6 +272,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
+		/* Defense-in-depth: the CS parser rejects misaligned IB
+		 * addresses, but catch any that slip through before they
+		 * hit BUG_ON(addr & 0x3) in ring emission callbacks.
+		 */
+		if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) {
+			r = -EINVAL;
+			amdgpu_ring_undo(ring);
+			goto free_fence;
+		}
+
 		if (job && ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
-- 
2.43.0

