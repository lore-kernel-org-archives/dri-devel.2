Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E569F5A8C5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E643F10E75A;
	Mon, 20 Apr 2026 21:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Hoy/ghY8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D8E10E75A;
 Mon, 20 Apr 2026 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776722154; x=1808258154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w+3+7D8I1N+j2pOZG4/w/Tn5xMRqwYVSXrbz6iuzedM=;
 b=Hoy/ghY88MM67Nk2wgglA0rMSC/7in+tBv9ncqix+pb5fgk+CR7uoiC6
 cvvvgpMkPj+TuaaqtqzsCchPkvbSOznF+KyuPZvomdW9WYl2nJ5X8XPLx
 GORByubBAnAjVE098zlrg+1MK0P4o5uUL+iqIUqCqnh3Sq+kMt9IlfAVK
 YdxHxdF48cMu5IGvJMgxG1MNIYYFxPp44oAuWS2NRs4is1pne57czvrkB
 S3HQrOOE1ZCMTJlKSx8YECS+6KY1+7c+DK6rIGU9PVK6wDv2HaNhObwao
 WU9NblOWrnF/CLhuV89Qmraf6aO8+4S768kpVrnH5BrmUQWnzuGm8fMMI g==;
X-CSE-ConnectionGUID: 6q60E86RRYi6XoT1WXZ6hw==
X-CSE-MsgGUID: nJjs1YF+Tu+5RTrkU2Zxrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88348266"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="88348266"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 14:55:54 -0700
X-CSE-ConnectionGUID: vIyOxeQSTKqfmJqE424eeQ==
X-CSE-MsgGUID: wIc//DBMSIu+dULRm5/kvA==
X-ExtLoop1: 1
Received: from arjan-box.jf.intel.com ([10.88.27.153])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 14:55:54 -0700
From: arjan@linux.intel.com
To: amd-gfx@lists.freedesktop.org
Cc: Arjan van de Ven <arjan@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix zero-size GDS range init on RDNA4
Date: Mon, 20 Apr 2026 14:57:15 -0700
Message-ID: <20260420215717.223372-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bug-221376-2300@https.bugzilla.kernel.org/>
References: <bug-221376-2300@https.bugzilla.kernel.org/>
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

From: Arjan van de Ven <arjan@linux.intel.com>

RDNA4 (GFX 12) hardware removes the GDS, GWS, and OA on-chip memory
resources. The gfx_v12_0 initialisation code correctly leaves
adev->gds.gds_size, adev->gds.gws_size, and adev->gds.oa_size at
zero to reflect this.

amdgpu_ttm_init() unconditionally calls amdgpu_ttm_init_on_chip() for
each of these resources regardless of size. When the size is zero,
amdgpu_ttm_init_on_chip() forwards the call to ttm_range_man_init(),
which calls drm_mm_init(mm, 0, 0). drm_mm_init() immediately fires
DRM_MM_BUG_ON(start + size <= start) -- trivially true when size is
zero -- crashing the kernel during modprobe of amdgpu on an RX 9070 XT.

Guard against this by returning 0 early from
amdgpu_ttm_init_on_chip() when size_in_page is zero. This skips TTM
resource manager registration for hardware resources that are absent,
without affecting any other GPU type.

Link: https://lore.kernel.org/all/bug-221376-2300@https.bugzilla.kernel.org%2F/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221376
Oops-Analysis: http://oops.fenrus.org/reports/bugzilla.korg/221376/report.html
Assisted-by: GitHub Copilot:Claude Sonnet 4.6 linux-kernel-oops-x86.
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index afaaab6496def..8075ac735321e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -75,6 +75,9 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
 				    unsigned int type,
 				    uint64_t size_in_page)
 {
+	if (!size_in_page)
+		return 0;
+
 	return ttm_range_man_init(&adev->mman.bdev, type,
 				  false, size_in_page);
 }
