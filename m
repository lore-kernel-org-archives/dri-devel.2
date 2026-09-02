Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75696C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75A310ED94;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRaj7ukN";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA3010F1B3
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:29:15 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so886774b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788352155; x=1788956955; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjSLQKBgLLYQIi/C+rXjtu2+hrtewX0LNh0mFPYrFIw=;
 b=SRaj7ukNhHXrM2V9EeF2J2VWm81lLQ7ay5bgc3aig+kqSGRzWqbrAoBFV0u0TV5jh2
 GcxUAXu0CPi9rTZazQI9z1xwPf9eP97cEqn+TznAchdNTDhASoHZqUkqqKMt3/8mdPtD
 Es8dSHsKQK3YpAu+Ytyn7XZebAziv0m1qmUbjnxO2OlJxtVm6k+0NxxAbghMtk+XShwA
 mPRCUWZE05DnXcmIQlguYKB8O4DjBX2iKqtgsDB5huW2UUo2lyPfoUUpX7427zZvqGVq
 M01U9F0CB6RvB9oDVhqtKuX+5sK9/FtaSIRXnaOGKwhh/93uzcOrH96COlMqgq7L1804
 iclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788352155; x=1788956955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjSLQKBgLLYQIi/C+rXjtu2+hrtewX0LNh0mFPYrFIw=;
 b=KYqDqbDEIOQM+M7k5RCg4PGJ9cMg/HG739szKC4dvjhCCf/ho1p09biEH0JCx3XkRf
 j3G54Gt0sb0huc0Gx7FgLn9zRYHlav7tODPPHQkbZLBv+cIe6lEjGPrHVamv8R5YrvqG
 EhU7UgZvZHPIP/axdL/j/+nfLxWMkLKT3n1V2yyLacd8XEANatwko+CmTdNvLIXc3PGJ
 Ahy33Kdv8/SOcaT1a1kYZ0UEjIN3oMG+usLjFbPqiX2R8M0AccXqsbZIjwbRNclyZCyi
 MDLkSFusVZOv6UChnxSQdyodRiBytwnq+jVSkikWVAqzjPKUxqYcdSlx3kO5gfmh01MX
 1HNg==
X-Gm-Message-State: AFuF++mZmkrw+pjOagfNX337cfeiuJqCVW3s1wCuUcXpXwsEpAdD+Cn2
 x/rtg6S0bPa6yDy6QFvaF3oQxzrtAzc/lrqv+4zalxh0Kr+OlvOrm3AP
X-Gm-Gg: AR+sD12/dicXzJRW2LGjPQo95Ke5yLlJJ79tAgeVi6rWEdFtIbusPAUUlXksQIcIW5P
 STqurnRyCyrIu4inKodKZgqOWUqp9mbB1reWefj3QvQ4HyTigdZH5q4A6AuHz4AsAGkgtpWqvwn
 CVObfpEdm1W2pzmResRUnYB82dyVfwLhYAYEYjD+HQFOkKqhdy+kanIgZJUdNFPJL1qOiO7Y/57
 nsEE1KISRLaDH36mdeQLFGj/FeUnqTmFutRRyYIIccZhuaxB/w26DLop7gTaVb5+CMLIZFocArR
 W72RCluLVIRRNQo2XP6qFJR1hLdrZi+qnaFfhLJIhca9NEiIxN2RVSkc0LB9Sqb3G6Q48k3U5bn
 Ybepk9SrP591UDzx0C5ZRSv+GFbZc28ia7zCRB60WtbcXIjCyXiTIH/mXj6DmSJGif0z9rFnhR6
 kQaU+ueBBmz/Upy7miDZdt+AOkAxeV6mYXfPqDH81TrIE5y/gHqxhui8CU54Y=
X-Received: by 2002:a05:6a20:431a:b0:3d3:adad:f172 with SMTP id
 adf61e73a8af0-3d9af0f8f96mr6795606637.20.1788352155062; 
 Wed, 02 Sep 2026 05:29:15 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc34d03b5a8sm944767a12.26.2026.09.02.05.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:29:14 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 02 Sep 2026 20:28:43 +0800
Subject: [PATCH v2 2/2] drm/gpuvm: reject zero-length range in
 drm_gpuvm_range_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-drm-gpuvm-zerorange-v2-v2-2-da63269c6ec4@gmail.com>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788352136; l=2951;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=p/V1AbwpqTcbOr6E67iKq4k/gI8GHbt2e0Eoz+/coFc=;
 b=vi/JETsoNsWUA5ztPyQT1Va9wqQSTg+1zn+8ro4xEvkjuHiIGNbMmkkJEMzOsbmzvS0Z+Teb0
 HFMW+KuWNOCDhgCUIsdE5zmQkvsguAOi6mEepd4sNaEPzysYjOdu4At
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

drm_gpuvm_range_valid() is the common gate every GPUVM map/unmap path
funnels through: drm_gpuva_insert(), __drm_gpuvm_sm_map() and
__drm_gpuvm_sm_unmap() all reject a request unless it passes. It checks
for overflow, the managed-range bounds and kernel-node overlap, but it
never rejects a zero-length range. A range of 0 is page-aligned and
addr + 0 does not overflow, so a zero-length VM_BIND request from
userspace passes validation.

The GPUVA interval tree derives a node's last key as addr + range - 1
(GPUVA_LAST()). With range == 0 this underflows to addr - 1, producing
an interval whose end lies below its start (and, for addr == 0, wraps to
U64_MAX). __drm_gpuva_insert() then issues its overlap query with that
inverted interval, so the -EEXIST guard matches nothing and a malformed
zero-length node is inserted, corrupting the augmented interval tree's
subtree-last invariant and misleading the overlap checks of later
map/unmap operations on the same VM.

Because the shared helper's own kerneldoc promises to validate "the
range" yet silently accepts range == 0, drivers have papered over this
individually and inconsistently: imagination and xe reject a zero range
at/near the ioctl boundary, while nouveau and msm do not. Fix it once at
the common gate so every current and future caller is covered.

The only in-tree user that legitimately accepts a zero range,
xe's DRM_XE_VM_BIND_OP_UNMAP_ALL, interprets it at its ioctl layer and
never passes range == 0 into the GPUVM core, so it is unaffected. The
in-core lookups drm_gpuva_find_prev()/drm_gpuva_find_next() pass
range == 1 and are likewise unaffected.

Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index c422c5af1f4b..b73ad6988171 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1021,7 +1021,8 @@ drm_gpuvm_in_kernel_node(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
  * @addr: the base address
  * @range: the range starting from the base address
  *
- * Checks whether the range is within the GPUVM's managed boundaries.
+ * Checks whether the range is non-zero and within the GPUVM's managed
+ * boundaries.
  *
  * Returns: true for a valid range, false otherwise
  */
@@ -1029,7 +1030,8 @@ bool
 drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 		      u64 addr, u64 range)
 {
-	return !drm_gpuvm_check_overflow(addr, range) &&
+	return range != 0 &&
+	       !drm_gpuvm_check_overflow(addr, range) &&
 	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
 	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
 }

-- 
2.34.1

