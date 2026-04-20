Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E20F36C5D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 08:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C022110E122;
	Mon, 20 Apr 2026 08:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="cvYzRWIc";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA45A10E112;
 Mon, 20 Apr 2026 08:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1776674005;
 bh=TZSZ3QzavpGQCMKaDwWJb6p/9aZGmtm1MdSbP6yEPtQ=;
 h=From:To:Cc:Subject:Date:From;
 b=cvYzRWIcrVcEOqIG+K0mc4cihEqKmwkU/+DmvcGlhoBAxmFTO9NAAYDnZ+3awywE3
 gqb3cVglRVrzAqqtFp8CVouzMT9VXi9VFJpsKs/EVnp2bs057rpOoBW8Mu15LRtfiB
 5cEnGv9bUwuw0JAg73XwKqrvdK2u+tja9HsDFXTrpGXVC5CuLkhR6meMKTnT5z2Qjl
 MhyrhmRoWs+fDN+VfX1u9yESWyO7CL2m+DE+KKy+iGqg8ouWhT81VryLZam5h4V/qP
 O1gMuukUyihnwzSgYhR4mMkxucENUPFbo7+S2ghldEZ1uhcY6z+SnXcbNTvh92XZDn
 mR2x71CN4aUNg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 0/4] drm/doc: Remove obsolete RFC docs related to i915.
Date: Mon, 20 Apr 2026 10:33:18 +0200
Message-ID: <20260420083318.92038-6-dev@lankhorst.se>
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

I believe small_bar has been implemented, as is gem_lmem.

xe has implemented GuC submission and VM_BIND, but realistically
this will never happen for i915.

Either way, those RFC's are completed, and can be removed.

Maarten Lankhorst (4):
  drm/doc/rfc: Remove i915_gem_lmem.rst
  drm/doc/rfc: Remove i915_vm_bind.
  drm/doc/rfc: Remove i915_small_bar rfc.
  drm/doc/rfc: Remove i915_scheduler item.

 Documentation/gpu/rfc/i915_gem_lmem.rst  |  22 --
 Documentation/gpu/rfc/i915_scheduler.rst | 152 ------------
 Documentation/gpu/rfc/i915_small_bar.h   | 189 ---------------
 Documentation/gpu/rfc/i915_small_bar.rst |  47 ----
 Documentation/gpu/rfc/i915_vm_bind.h     | 290 -----------------------
 Documentation/gpu/rfc/i915_vm_bind.rst   | 245 -------------------
 Documentation/gpu/rfc/index.rst          |  18 +-
 7 files changed, 1 insertion(+), 962 deletions(-)
 delete mode 100644 Documentation/gpu/rfc/i915_gem_lmem.rst
 delete mode 100644 Documentation/gpu/rfc/i915_scheduler.rst
 delete mode 100644 Documentation/gpu/rfc/i915_small_bar.h
 delete mode 100644 Documentation/gpu/rfc/i915_small_bar.rst
 delete mode 100644 Documentation/gpu/rfc/i915_vm_bind.h
 delete mode 100644 Documentation/gpu/rfc/i915_vm_bind.rst

-- 
2.53.0

