Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CE606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VAObjPjS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B4911203D;
	Thu, 29 Oct 2026 08:18:43 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9B311205C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:18:36 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029081835euoutp0157f0ab094dbd3d4a29f190999ebf93b4~i8jYJ5G8f0896808968euoutp01S
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:18:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029081835euoutp0157f0ab094dbd3d4a29f190999ebf93b4~i8jYJ5G8f0896808968euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793261915;
 bh=0lgHRoa196DEU+2U1lk70FoFCFplkDsDz1Bz0nF6vpc=;
 h=From:Date:Subject:To:Cc:References:From;
 b=VAObjPjS2TY/SX4X40nIReHrB6Gf9/nC4Ty+LHPFAbmqtDo9dIAStoadIx1rX4WhM
 2A+ZGkSpSIRYFfwvj2S6DG3xjde1aUoSqXQg+hflKlB3R2zcTLgqRudotEaNqj0IKQ
 Ny6015+uRrXUr9ZjvVV5KVEe2dlUnJAadAz89DLI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029081835eucas1p290190c4899f87b740d022b9db9bc361f~i8jX9Cv7L2606526065eucas1p2e;
 Thu, 29 Oct 2026 08:18:35 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029081834eusmtip19ac2ae38f3972126e7d077eeb848237a~i8jW-rEcn2949629496eusmtip1h;
 Thu, 29 Oct 2026 08:18:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 09:17:18 +0100
Subject: [PATCH v4] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fix_imagination-v4-1-689745dd52ef@samsung.com>
X-B4-Tracking: v=1; b=H4sIAA0B42oC/3XOSwrCMBAG4KuUrI1kJq1NXXkPEQkxabNoKkkNS
 undnRYEpbj85/HNTCzZ6G1ix2Ji0Waf/BAolLuCmU6H1nJ/o8xQYAWIyJ1/Xn2vWx/0SLNcWSd
 MU1LPlIy27tHSyCqeL5Q7n8YhvtYDGZbqfysDBy60UUKjcxLqU9J9eoR2b4aeLVrGj3AQSlRbA
 UmoZQMapFENuK0gvwQQW0GSYOk/WTU1ojO/wjzPb4VZ0LQ0AQAA
X-Change-ID: 20251222-fix_imagination-8ef0c94122c4
To: Frank Binns <frank.binns@imgtec.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>,  Alessio Belle
 <Alessio.Belle@imgtec.com>,  Matt Coster <opensource@mtcoster.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,  kernel
 test robot <lkp@intel.com>,  Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=JvFUP7flyqTbe0DcKzZ1qgU/tpsVC6tlbD1knLD9FIs=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9ZowKeise9Fucc5e+ZeNaDomt8jlzd/wV3bmP1Tdui
 49gyDWFjlIWBjEOBlkxRZazG6ONJP8xPC0//vgXzBxWJpAhDFycAjCRx0sYGc6sSep53XNNnGdN
 6yqRnZY2DkVZM+ycdW3jxPU/J8Rq72ZkeNVZGVvwTa232VHkYMXZ55bL9v8rubFMYUb6pY8Pvin
 28wIA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029081835eucas1p290190c4899f87b740d022b9db9bc361f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029081835eucas1p290190c4899f87b740d022b9db9bc361f
X-EPHeader: CA
X-CMS-RootMailID: 20261029081835eucas1p290190c4899f87b740d022b9db9bc361f
References: <CGME20261029081835eucas1p290190c4899f87b740d022b9db9bc361f@eucas1p2.samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sparse (W=1) builds fail because `SIZE_CHECK(struct rogue_fwif_hwrtdata,
384)` expects 384 bytes, but the compiler generates a 336-byte
structure.

This is due to an alignment conflict: the inner member `cleanup_state`
requires 64-byte alignment, but the outer struct is explicitly marked
`__aligned(8)`.

While a non-sparse build implicitly pads the size to a multiple of 64, a
sparse build strictly respects the 8-byte outer alignment, resulting in
a size mismatch.

Fix this by aligning the entire structure to 64 bytes, which resolves
the contradiction and forces the correct 384 byte size on all builds.

Fixes: a26f067feac1 ("drm/imagination: Add FWIF headers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512131851.1WNXk3BC-lkp@intel.com/
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
Changes in v4:
- Reworded the commit message to state that the size mismatch is reported
  by sparse (W=1) builds, not by regular GCC builds on RISC-V, as
  requested in v3 review. The commit message rework announced for v2 was
  never actually applied, so v2 and v3 went out with the v1 message.
- Picked up Matt's Reviewed-by from v1.
- No changes to the code.
- Rebased on latest master.
- Link to v3: https://lore.kernel.org/r/20260810-fix_imagination-v3-1-e512359722fc@samsung.com

Changes in v3:
- Cleaned up the changelog section by removing the accidental b4
  "EDITME" template from v2.
- No changes to the code or commit message.
- Rebased patch on latest master.

Changes in v2:
- Expanded the commit message to properly explain the root cause of the
  GCC alignment conflict on RISC-V vs ARM64, based on v1 feedback.
- No changes to the code.
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
index 5d590c4c25663e431601dd26944465b62c31526b..2f8daa93c9e6832bbeec7460275c4b803792cb02 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
@@ -2174,7 +2174,7 @@ struct rogue_fwif_hwrtdata {
 	bool geom_caches_need_zeroing __aligned(4);
 
 	struct rogue_fwif_cleanup_ctl cleanup_state __aligned(64);
-} __aligned(8);
+} __aligned(64);
 
 /*
  ******************************************************************************

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20251222-fix_imagination-8ef0c94122c4

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

