Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E71C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B587610E0FB;
	Wed,  5 Aug 2026 19:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YV8k55tW";
	dkim-atps=neutral
X-Greylist: delayed 356 seconds by postgrey-1.36 at gabe;
 Wed, 05 Aug 2026 19:43:25 UTC
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E3210E0FB
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 19:43:25 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260805193727euoutp01322c3c8059115ae43336dd5d9ff5a1cb~I-_19OWfG0565205652euoutp01w
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 19:37:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260805193727euoutp01322c3c8059115ae43336dd5d9ff5a1cb~I-_19OWfG0565205652euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1785958647;
 bh=Pe2AE989M4TxDmIii+wmo9e6zIueu7uEudXm1OhVJNk=;
 h=From:Date:Subject:To:Cc:References:From;
 b=YV8k55tWjDEXboujXL1akYTHykU61XEOuqust+eYHf/TIH18JyVMwD4vuwYfPAC/q
 w3Oz60W6uJilu/LAubghpbL/yay0cSiHedNzhvVbHOWYhHRd8nebmlCmJEcm6MJGfL
 anHp8Hdj55ZIo1eqEoXBGXQrAOh1s/skly0Q9+xo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41~I-_05Ykwj1922019220eucas1p1i;
 Wed,  5 Aug 2026 19:37:26 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260805193725eusmtip14ff2e94754b44d629b9196d04add9c99~I-_0U279j2331123311eusmtip1L;
 Wed,  5 Aug 2026 19:37:25 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 05 Aug 2026 21:37:22 +0200
Subject: [PATCH v2] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
X-B4-Tracking: v=1; b=H4sIAPGQc2oC/3WNSw7CIBCGr9LMWgyMNVZX3sM0ZoJAZwE1UImm4
 e6O3bv8/ucKxWV2BS7dCtlVLjwnAdx1YCdKwSl+CANqPBpEVJ7fd44UONEiWTU4r+25F8/2IK1
 ndhLZFm+j8MRlmfNnO6jmp/7fqkYZpckOmtD7gzldC8XySmFv5whja+0LlTdhyLAAAAA=
X-Change-ID: 20251222-fix_imagination-8ef0c94122c4
To: Frank Binns <frank.binns@imgtec.com>,  Matt Coster
 <matt.coster@imgtec.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>,  Alessio Belle
 <Alessio.Belle@imgtec.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,  kernel
 test robot <lkp@intel.com>,  Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=ylUIMdTnaHVKRYrmQuCQ+ETiuk8tktJwv+igbEXyaHs=;
 b=owEBbQGS/pANAwAKASw99I2nQptuAcsmYgBqc5D14gAZmV6JdPcOAGETO9ujXWUY554S1Fv3H
 92/E8xWzz2JATMEAAEKAB0WIQR2xBTdTO5XfoUTSOYsPfSNp0KbbgUCanOQ9QAKCRAsPfSNp0Kb
 boXfCACfJ3pLkzdE/hYZMm/E7FyxwLWyPhCoeC3BOhZyCgHyriYb/PcO+ntYSneO5l7qhE/ggSb
 TN+FByGqHQhPsHG+4VeSIIG+tTm/loxemMJEy1n19OXX9/5myegtLuOt1yZX/+x25P3I6ZDZzGT
 TYYZH5haOkzZjrTQA3N99bIESGi4Pq7KPqvbtL3ZraJFu2n3XSfsqk5V9YBrr7t5OJLlja4HHFM
 eP8CoSIE5Ibo2e1I71Tpsafv2r4Hbc0l4ce88hCwSumdvLSDmldS8RMRknG0iVPRg6xnyA5uxwm
 q8hQwy0R5nIoa0CT2SqGDJ9DFwPvMYKS9x/fTyYV1QWKzeus
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41
X-EPHeader: CA
X-CMS-RootMailID: 20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41
References: <CGME20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41@eucas1p1.samsung.com>
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

The build fails on RISC-V using GCC because `SIZE_CHECK(struct
rogue_fwif_hwrtdata, 384)` expects 384 bytes, but the compiler generates
a 336-byte structure.

This is due to an alignment conflict: the inner member `cleanup_state`
requires 64-byte alignment, but the outer struct is explicitly marked
`__aligned(8)`.

While GCC on ARM64 implicitly pads the size to a multiple of 64, GCC on
RISC-V strictly respects the 8-byte outer alignment, resulting in a size
mismatch.

Fix this by aligning the entire structure to 64 bytes, which resolves
the contradiction and forces the correct 384 byte size on all
architectures.

Fixes: a26f067feac1 ("drm/imagination: Add FWIF headers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512131851.1WNXk3BC-lkp@intel.com/
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20251222-fix_imagination-v1-1-0ac80a2ff317@samsung.com
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
index 172886be4c820a32ae1b08d62bf0814250f2a9bd..1ba2a167a38b31911e0846923e4dc70626f5ca65 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
@@ -2170,7 +2170,7 @@ struct rogue_fwif_hwrtdata {
 	bool geom_caches_need_zeroing __aligned(4);
 
 	struct rogue_fwif_cleanup_ctl cleanup_state __aligned(64);
-} __aligned(8);
+} __aligned(64);
 
 /*
  ******************************************************************************

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-fix_imagination-8ef0c94122c4

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

