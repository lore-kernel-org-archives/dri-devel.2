Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDB8C44538
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FFD10E704;
	Wed, 22 Jul 2026 04:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FjgAdQ2P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BFB10E704;
 Wed, 22 Jul 2026 04:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784695348; x=1816231348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DPPvDE2ZYkY75cjC/FOqIdz/rzKIfyUjxxUz+ht8NJo=;
 b=FjgAdQ2P+ipuNYpfbshL/uSTrYJX1j0NSjxjx6J2yYtH1IxFd9H2fzsl
 wGWMduEr5GLuO3SzsbAZNEuffdNGzPK8IvIeCcw5/AyKfNj4KVtEA8hjE
 vZ4mmLCXQyCSCHo0RgkylvcUHED/EmFg8fDSlKsFA+Ikpj6tp051tyZ/v
 cHMPIuhezhBe5p9+mWF9cILAlzktquJghJR4q3gvKxHRWccumhldLr7yr
 nVyW3HbVlMY2aNl0+BCpWipBGuTCk8ISb26CUVQT52g5fzFa3o2nZkLcf
 rT8iKX1FNUplejsHdW11oCKMg96UamCSrVlqbK1gxtpfMkOznE1lTsMrZ g==;
X-CSE-ConnectionGUID: PHXdPR9MSTyW0SrWpn+DFw==
X-CSE-MsgGUID: 0DYpTbVjSTOY7GpBky/LVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="102865802"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="102865802"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:42:27 -0700
X-CSE-ConnectionGUID: yeAK+zsQTJ6aZaftSkRXRQ==
X-CSE-MsgGUID: U6MJW0PsSS2/6S9Nm9dxBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254063558"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:42:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Airlie <airlied@redhat.com>, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] drm/xe: select TRANSPARENT_HUGEPAGE
Date: Tue, 21 Jul 2026 21:42:19 -0700
Message-Id: <20260722044220.1110278-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722044220.1110278-1-matthew.brost@intel.com>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
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

Xe is currently the only TTM driver that drives the TTM shrinker, and
hence the only user of TTM's incremental swap path. That path splits the
pool's higher-order compound folios one page at a time via
folio_split_driver_managed() so individual pages can be backed up to
shmem and freed under memory pressure.

folio_split_driver_managed() is part of the transparent hugepage split
machinery in mm/huge_memory.c, which is only built when
CONFIG_TRANSPARENT_HUGEPAGE is enabled. Select it from DRM_XE so the
split primitive is always available for the driver that needs it, rather
than forcing it on every TTM user.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 drivers/gpu/drm/xe/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b91..88a4f3d09d5f 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -11,6 +11,12 @@ config DRM_XE
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
 	select TMPFS
+	# Xe is the only TTM driver that exercises the TTM shrinker's
+	# incremental swap path, which splits the pool's compound folios one
+	# page at a time via folio_split_driver_managed(). That helper lives
+	# in the THP split machinery, so pull it in here rather than for all
+	# TTM users.
+	select TRANSPARENT_HUGEPAGE
 	select DRM_BUDDY
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
-- 
2.34.1

