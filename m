Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3F8C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5119F10E1D2;
	Mon, 10 Aug 2026 10:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="OOpCsCS4";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB3710E1D2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:20:39 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260810102038euoutp02bf2345d48733000fdea0d649e316f98f~KanGJeoVc2366923669euoutp021
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:20:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260810102038euoutp02bf2345d48733000fdea0d649e316f98f~KanGJeoVc2366923669euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1786357238;
 bh=nrDSqWh7fWlae3uBeMAL2gKZRJmUMcCwGW+tWicoz3Q=;
 h=From:Date:Subject:To:Cc:References:From;
 b=OOpCsCS4wtHw8vz8ZksAvrrM9uRvibrXy/9HSD5hWNbiJtX9o2OT1WmlYMzIKvFf+
 eIc/M0ylaYzFDbhsShRWgjamM67wjpxUX3tnoVgRpK2Wt4455vgPlTZqm3hUmEI0SG
 hfFHm5KGschmva1KxB0ZtQ1zrfnugQaF2G5J2zQM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499~KanF2J6DV2887128871eucas1p2K;
 Mon, 10 Aug 2026 10:20:37 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260810102036eusmtip1521f40c891104fdf7da0fde0f4b31e8d~KanFFXxgc0452904529eusmtip1H;
 Mon, 10 Aug 2026 10:20:36 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 10 Aug 2026 12:20:04 +0200
Subject: [PATCH v3] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-fix_imagination-v3-1-e512359722fc@samsung.com>
X-B4-Tracking: v=1; b=H4sIANOleWoC/3XNwQ6CMAwG4FchOzuzdiDDk+9hjFnmBj0AZsNFQ
 3h3C4kHYzz+7d+vs0g+kk/iWMwi+kyJxoGD3hXCdXZovaQbZ4EKK0BEGeh5pd62NNiJu9L4oFx
 T8s6Vgq/u0XNlE88Xzh2laYyv7UGGdfrfyiBBKuuMshiChvqUbJ8eQ7t3Yy9WLeNHOCijql8BW
 ah1Axa0Mw2Eb2FZljf0Diup8gAAAA==
X-Change-ID: 20251222-fix_imagination-8ef0c94122c4
To: Frank Binns <frank.binns@imgtec.com>,  Matt Coster
 <matt.coster@imgtec.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>,  Alessio Belle
 <Alessio.Belle@imgtec.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,  kernel
 test robot <lkp@intel.com>,  Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=P/ouuuMO6OH/G/XLDxdGw9tTuBSKR6Qa/Pcf+Rx3Aks=;
 b=owEBbQGS/pANAwAKASw99I2nQptuAcsmYgBqeaXzVWKQPaIJHmLrNWjsrVgPzIA1rdSmxcbwn
 iw533dUzliJATMEAAEKAB0WIQR2xBTdTO5XfoUTSOYsPfSNp0KbbgUCanml8wAKCRAsPfSNp0Kb
 bmdaB/4sH8cPKxybtSHXED7vHt0XRQFiYi/TmglRI4fanaJwB5/gtEc9AS0TS7I2cEeigOee2AY
 aP6ZgQCAdDMIucBDlL5nJ8yxU9vkCULesPWYFzr+vyyC7sOLcKxOfXF2ehkIcwBH2h+A2qAMZNR
 q+5jrcrAHIuY42WiMk92/Sd57Z0EykZudyD41XvGzDwPT33IhCC+lp0gztw2MOPwDcbwwkIHlcC
 GGhyyj60G96MPVF0TB7ny3/feLOJ+ULXb/hbu25/YsqSCIOoYlL0n7gcGpweT8CujDiHXCtC80c
 6RDTc0O8zx/rxgu596rpPOAMFRLdhHHG4cPWQbQefldx5BOD
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499
X-EPHeader: CA
X-CMS-RootMailID: 20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499
References: <CGME20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499@eucas1p2.samsung.com>
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
Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
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
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20251222-fix_imagination-8ef0c94122c4

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

