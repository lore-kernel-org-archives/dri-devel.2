Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B23606D801
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=hUHuFU5R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BE810E740;
	Tue,  3 Nov 2026 01:14:47 +0000 (UTC)
Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEBD10E758
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:14:40 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=/G7wmxsTL23u9bAYd6YQYYYXjzFS/q8bqKEQoNriAAg=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793668477; v=1; x=1794273277;
 b=hUHuFU5RlcnDhKHgGREFIsXDCtO8AnpM/znRVTTc98utRqLH3OFHLnbI2a/R49Nztwqjn1C0
 HDj5hNoQ2xznG3VYVPzFx2Qs2OnVkXMwliOWmo1o/Z5v8RquvRrHn2APWz8ecWK77zcHH47e9S7
 7z/FhK1gFCZ4pCR1D7LwXdBFTpbk58WWXto8rb5CkXeF0qTKgMuOapL5Q0oN1joynV96Aa2baUj
 zXmJQNcRP9UUM5tdyAZNHQGuLbjEvZZ/xqh4FoXVZTlYTsjEuJ9PvK6/lVshfP6BZpr5xQeAVdj
 HvdHq5TrW5288d7oH+qx2QCMSJn21F0rTMpci/Jvxosiw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c2c0fa72fdcaf99d;
 Tue, 03 Nov 2026 01:14:37 +0000
X-Mizu-Trace-ID: c2c0fa72fdcaf99d
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>
Subject: [PATCH 1/4] drm/msm/a6xx: Restore GBIF CX config for A640 family
Date: Mon,  2 Nov 2026 22:13:50 -0300
Message-ID: <20261103011358.65398-2-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103011358.65398-1-val@packett.cool>
References: <20261103011358.65398-1-val@packett.cool>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Maximilian Luz <luzmaximilian@gmail.com>

Commit 60a4e18e0e8a ("drm/msm/adreno: Do CX GBIF config before GMU
start") moved the GBIF_QSB_SIDE{0..3} configuration from hw_init() to
the per-GPU catalog entries. Previously, it was applied to all GPUs of
the A610, A640, and A650 families as well as A7xx. However, the A640
family entries (A640 and A680) were not updated with the new gbif_cx
list, so the configuration is no longer applied on these GPUs.

On the Surface Pro X (SC8180X, A680), this results in GMU HFI timeouts
(e.g. for HFI_H2F_MSG_GX_BW_PERF_VOTE) and GPU lockups shortly after
starting a desktop session.

Add the missing gbif_cx entries to restore the previous behavior.

Fixes: 60a4e18e0e8a ("drm/msm/adreno: Do CX GBIF config before GMU start")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 4ef2bd6e7ad2..6c154792cb07 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1041,6 +1041,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a640_hwcg,
 			.protect = &a630_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00180000,
 		},
@@ -1164,6 +1165,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a640_hwcg,
 			.protect = &a630_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00200200,
 		},
-- 
2.56.0

