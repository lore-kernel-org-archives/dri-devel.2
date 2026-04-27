Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF4EFF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA6D10E9B4;
	Mon, 27 Apr 2026 23:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kKFfGkJT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC6F10E9B4;
 Mon, 27 Apr 2026 23:58:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F62E60121;
 Mon, 27 Apr 2026 23:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE43C19425;
 Mon, 27 Apr 2026 23:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777334301;
 bh=2uhLD0tH1NwpJiWOQG116+gMkzVllKmTE1oc9AVp0dU=;
 h=Date:From:To:Cc:Subject:From;
 b=kKFfGkJTvVWVQxPcyS8d+RRPD4dm4+SnBAnNjyFEcvwbszfa8aDfc+NW+qKHp4MMJ
 eJgSPVgz/qCv1/DMuR9VFcN8CRnipTllaVPCn9LSe2An4tsnBtVC4XMxsZg9Jjd224
 k++7MTsodi3NhSke+fkF88y/VZB8LPmtuKnuztisX3iNDBmLSDxijl5nyQxGOFuN4e
 IYcYPvVhd5F44lhHlCebbIjKjsPPQ8X5D5KyMPCmX7KkvciQWygzVmx3IJ1BBBqcA9
 5AW1+/L0zS1mllpYvzFvpLFIJZp0O6HkpbZr/7dPFte3zvaTGWwyaIl/SPDytV/MrF
 w3Fywm4EmjMnw==
Date: Mon, 27 Apr 2026 17:58:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/i915/gvt: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ae_4GkBsNl_0SYTm@kspp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the TRAILING_OVERLAP() helper to fix the following warning:

drivers/gpu/drm/i915/gvt/opregion.c:126:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Lastly, the static_assert() ensures the alignment between the FAM and
struct efp_child_device_config child0; is not inadvertently changed,
and it's intentionally placed inmediately after the related structure
(that is, no blank line in between).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index d6e76ba31d60..efe457c02788 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -122,17 +122,21 @@ struct vbt {
 	struct bdb_data_header general_features_header;
 	struct bdb_general_features general_features;
 
-	struct bdb_data_header general_definitions_header;
-	struct bdb_general_definitions general_definitions;
-
-	struct efp_child_device_config child0;
-	struct efp_child_device_config child1;
-	struct efp_child_device_config child2;
-	struct efp_child_device_config child3;
-
 	struct bdb_data_header driver_features_header;
 	struct bdb_driver_features driver_features;
+
+	struct bdb_data_header general_definitions_header;
+
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct bdb_general_definitions, general_definitions, devices,
+		struct efp_child_device_config child0;
+		struct efp_child_device_config child1;
+		struct efp_child_device_config child2;
+		struct efp_child_device_config child3;
+	);
 };
+static_assert(offsetof(struct vbt, general_definitions.devices) ==
+	      offsetof(struct vbt, child0));
 
 static void virt_vbt_generation(struct vbt *v)
 {
-- 
2.51.0

