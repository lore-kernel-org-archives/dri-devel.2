Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86A606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE6SLmFS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E17E10E316;
	Sun, 15 Nov 2026 20:19:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4536910E0EB;
 Sun, 15 Nov 2026 20:19:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05C4441B4B;
 Sun, 15 Nov 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794773950;
 b=J72OSoKhlmbBaO1YhLT/RuRfi6XyHx9ED6Jm8uC/8XVwLXSd3owgLH1HdvA6rumCfxL6
 bjYWwMM638AaQXe0qG1NKXOPTD/627XR7i1pPAVgcWTEtiatB2151JtADqATP+zDUQqMp
 GoiqzZi0uHjFsJgmYm3LDN/qCacgr7so/Gr2v+CMYrSgx13O8yz56GjGeWzQQpgzJPymB
 EKXg+XvNQbDWKEdLnvhFps4zg+YDwpgX1F3EFvhaUGr948AKRbHAE4PYG6BTPido3HQnP
 wF0qb4pfbHrjl+ztWvpzKMrt7e6XBjKs8OhIbXuNwrlo93bdvyBoc049CEk994DxnwA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794773950;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=xbPrB86BknoS9rdJM+cIMNmZoWf9bXqGDcdQjshBvPQ=;
 b=je+4NUFCVYDfU7kPOwEG4pGSEdiBrbVjApY4HWvk6goorcjraCBJfGvD03BAXTbSd0BK
 X5nKvJ9dFNhkD1SyLiarlYk8x/jtFSXDa0pyUF+WBU2+LiPK+62lROeu7bFPUVVP0Vvmm
 YBKr+8idO8rBwmZvP3yLJJ6gSraM1/PY6i9L1u96CHL/ZYvFLNvmMVv2/qgySghneCNvr
 KyCwR3F1JlbAxSqQx0CO9BmWWarOJWuO/6bQacDEtVd3bHlgB2k5AWAxoa1BZTc+oIwvF
 kee4Pls/kb+HOCMolrO5zA5bonr0JAGdoxkhvekgnaCSR8L7Oty+lse8PRtuxR+UzVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 72DF41F000C6;
 Sun, 15 Nov 2026 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794773950;
 bh=xbPrB86BknoS9rdJM+cIMNmZoWf9bXqGDcdQjshBvPQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=AE6SLmFSFerHbOiBAF9jkmjHENliDMCG+nRRc8MB+uH6Pv2oAW6ewEh6P5nMbmLbl
 hTGuGa41UQntXl63zZOvFuVV6Kpy+pLHfB9ZobhUq3vRUhpSd0QeGg/khkof+2xLSu
 nLJjPbwMAeQpv8SKGpZ4nEbSE89T3Oc6mkzMs2t9vKCglQrv9xFlBDEc1SmrXQim9N
 NdECPhDa+vTP7mIwJuLWotdDA0JDTJgsHx4cvyyhpndnUftaq97ajxfC/55vyszA0I
 cGxLLUh04RwUrcPqVfjolQeGn/eXWj12lu35s8PhswEJcVGpTdKdapwdJN0mMWfyCH
 wFYwkuUQynk1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 03D6D4A170;
 Sun, 15 Nov 2026 20:19:10 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 01:49:10 +0530
Subject: [PATCH] drm/msm/a6xx: Fall back to MX when GMxC has no levels
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-msm-gmxc-fallback-v1-1-a9daad716a1e@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1oAg2tVxEXyTjaqUYl0xZBv
 LvRLt/i/w2Uk7BCVWyQ+Ccq85RhygLo5aeeUdpssDfrjDEOo0bs40rY+XEMngYM92fgh2VHtoX
 cLYk7Wa9n3fyt3/Bm+pwj2PcDMV8WrnUAAAA=
X-Change-ID: 20261116-msm-gmxc-fallback-b59be82e6c2d
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794773949; l=2658;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=BA89LyPLwbpk5+OPvueWTT6sDxsYtskxk6HHZayfkmQ=;
 b=Mc+/cZ8bF9Ufxr4KlPw90MYzIclxGRxJCOCF2QMi2DJdCfve/8sIQxpJucNuBPujQjEYWS/HC
 YdW2ZPHan7oArZj622DLM1t4YiOHoRAceWuqy6qnu5DqxhXZUsPwyi2
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

The command DB of Molokai (SM8845) lists the gmxc.lvl resource without
any level. Since a6xx_gmu_rpmh_read_arc() trims the trailing zero
levels, reading it now fails with -EINVAL, so the GX votes are never
built and the GMU of the Adreno 829 hangs on the first GX vote:

  Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 8 timed out waiting for response
  Timeout waiting for GMU OOB set GPU_SET: 0x4
  gpu hw init failed: -110

Before, the empty list made the GX votes use the lowest GMxC corner and
the GPU worked. Read gmxc.lvl the same way when choosing the secondary
rail, so that a GMxC without levels is treated like a missing one and
the GX votes use MX.

Fixes: b5269bf0e1ad ("drm/msm/a6xx: Factor out RPMh arc-vote helpers")
Assisted-by: LLM
Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
Found while bringing up the Adreno 829 of the Motorola Signature
(Qualcomm Molokai, SM8845) on next-20261113: the GMU firmware loads but
never answers the first GX vote. Bisecting the arc vote rework points at
commit b5269bf0e1ad: the Molokai command DB lists gmxc.lvl without any
level, which the new helper rejects, so the GX votes are never built.

Tested on the Motorola Signature: the GMU answers, the GPU comes up and
Phosh renders on it.

I used an LLM (Claude) to help write this patch and its commit message.
I reviewed it, bisected the regression on the device and tested the
result there.
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..914434b49eed 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1889,13 +1889,17 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	const char *sec_id;
 	const u16 *gmxc;
+	size_t gmxc_count;
 	int ret;
 
-	gmxc = cmd_db_read_aux_data("gmxc.lvl", NULL);
+	gmxc = a6xx_gmu_rpmh_read_arc("gmxc.lvl", &gmxc_count);
 	if (gmxc == ERR_PTR(-EPROBE_DEFER))
 		return -EPROBE_DEFER;
 
-	/* If GMxC is present, prefer that as secondary rail for GX votes */
+	/*
+	 * If GMxC is present, prefer that as secondary rail for GX votes. Some
+	 * SoCs list it in the command DB without any level, use MX there.
+	 */
 	sec_id = IS_ERR_OR_NULL(gmxc) ? "mx.lvl" : "gmxc.lvl";
 
 	/* Build the GX votes */

---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20261116-msm-gmxc-fallback-b59be82e6c2d

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


