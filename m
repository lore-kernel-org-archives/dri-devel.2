Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F3AC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3961F10EAD9;
	Tue,  4 Aug 2026 15:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="gXceyeqU";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA14610EADE
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:19:04 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CWqhA3771746; Tue, 4 Aug 2026 16:18:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=q
 Uhbe5UbluRYtgvuOwqQBvKYhFMZvgz5XOrtiuGlrt0=; b=gXceyeqUAKCtCknpo
 kFZ6NL78AkAK1b/L4F2kpVyWv33EyEq3jizQIcJFSgFn2HHnaJGipnqhvYdOH4Lc
 k7BhvA7kbrD/WLvui4PxdQ6KFUTr60Ph/ExmyeUwFs4h25huP2C+QsVFm/KbrPYf
 962JgZ9s89K5OlQOuWiATny/R60mjOnK8sc7Bz2tXN42TCRbrQJzDhD8A62G9pNG
 f6eWVTjV2TaqooPzrH7sODnMDpzeGfhY+QNauyfDy1KDpZa3aT8JME3cAOcFevlW
 3aO9ZiiYNzThJSkOv0u/ei02QEJQrvDiNzphYG4frz/9uErAJF4HICX2E9t24vgT
 uEiIw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72pth1w-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:18:51 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 16:18:51 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Tue, 4 Aug 2026 16:18:27 +0100
Subject: [PATCH v2 1/3] drm/imagination: fixup some docs in pvr_gem.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-staging-pvr-docs-fixes-v2-1-a5a9569a1c1d@imgtec.com>
References: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
In-Reply-To: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785856730; l=1328;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=0KLg0lpBi/LzpVgIhnmrjTkLbCn1SNOxCFUcymW4k34=;
 b=7EtctoUb6nUo4ghLxQtQsvZhHb3eUhl3emNFGlVWdOiJ430oMrAiZ8aYSOF1fFRVqRuw08Sxj
 hSEVPCyOPJcBCvbiNZxy+xqEEYL6AGRbweQYgF11iqj9NH0Kj66N3dD
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfXyDfKUfyN3pd1
 h0llO5SQKGscVVG7NR3vQKIJEjtSY5iPNdCPRFTzsfxzygswBCr57l2MY6Zm+uFkQbB/eMam6Tf
 D913K5RtdZaZ2Zrcr5Md2ygDtOzSkH4=
X-Proofpoint-ORIG-GUID: lyJ5XnNqIDnjh35wwOWlBfhQZAkJp1OE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX9AT8d57V1tsP
 tt95RKYVZfq9MH/n1KUEjK7JsCpNQVtufxlWnXj/Co34N/ZDNtz6sZSSdThpFNJPR6gTf2D7K1P
 rL4vRmsFXenAl40Ao4HjhhCjiNy7hsAM7lQjtk1Bg68+z1gUKxE4H6stH7FXEsuH1y+CheVccTm
 Bk3jJzAVAJLZkngAqDsEHFDOL1alo9Z3gjBn7KCN9rVltPzgUaSdhalzXlzIQwucINw8P/mD16p
 EzwDkoZKxnhK9O+rO5PeiswUepc+BdrROu8CbXPwleXxnkAYoSNtblTN+RK+/356OHkQAEbdzAJ
 SMK31FCm66VaADRq8R6jgybMUmrm4kNDlAEP1yCpPYlu0p10fGCHntfsTVE9+ik4J88mpYrzX4Q
 Lt1HsXqz7tt+AAFlTAJJtyrXt5teLuCV4y4KwqlMmEqzuBAeb0AKhxbilzAMVNlCQ4LVG/wi31e
 br6V4X7CQ1/+D75NUwA==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a7202db cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=UV7XqEwYxg3KGVgAFc0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: lyJ5XnNqIDnjh35wwOWlBfhQZAkJp1OE
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

From: Matt Coster <matt.coster@imgtec.com>

Update and remove some old comment in the PVR GEM documentation.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_gem.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_gem.h b/drivers/gpu/drm/imagination/pvr_gem.h
index c99f30cc6208..4286e047ae24 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.h
+++ b/drivers/gpu/drm/imagination/pvr_gem.h
@@ -84,8 +84,10 @@ struct pvr_gem_object {
 	/**
 	 * @base: The underlying &struct drm_gem_shmem_object.
 	 *
-	 * Do not access this member directly, instead call
-	 * shem_gem_from_pvr_gem().
+	 * .. note::
+	 *
+	 *    This member should not be accessed directly, but instead by
+	 *    calling shmem_gem_from_pvr_gem().
 	 */
 	struct drm_gem_shmem_object base;
 
@@ -97,12 +99,6 @@ struct pvr_gem_object {
 	 * changed after creation.
 	 *
 	 * Must be a combination of DRM_PVR_BO_* and/or PVR_BO_* flags.
-	 *
-	 * .. note::
-	 *
-	 *    This member is declared const to indicate that none of these
-	 *    options may change or be changed throughout the object's
-	 *    lifetime.
 	 */
 	u64 flags;
 

-- 
2.43.0

