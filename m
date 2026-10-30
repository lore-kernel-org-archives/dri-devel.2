Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E565606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rt6wGl9e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EE51126CE;
	Fri, 30 Oct 2026 09:41:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAADE10E22A;
 Fri, 30 Oct 2026 09:41:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D85040676;
 Fri, 30 Oct 2026 09:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BB51F000C1;
 Fri, 30 Oct 2026 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793353306;
 bh=Ey4e9MzSvJkP1rnuMio8C0fl+aTIgJsGS7g5QzPfgJo=;
 h=From:Date:Subject:To:Cc;
 b=Rt6wGl9eYZJhaLBEUb+SzLeNqsUI4X24IqYurK1bvaWatYXjzeLic6eUekfatCAt3
 kYi3ATulPZ82chhij0blLNR/qE/CfnEeu6XPRsg4EjCXnslqBmvmVtssiCDc6opOY4
 sBDC68vivBl2tMZxjfEhK9b2JrgGeFj6vMDGziaUbqRxU/tlFbXFAmoCgdnIBORu7B
 QI42cLK/JdfJVrYfutZA40dWco2TN2VpsMd0iUJdK+GDiSbHNFZz0v7NwzGVXN55Ig
 9tQVVVypnuo942/gorH0IkD7wl6QvA8AlJ2ePIeaDU3kaKQjCg9B8vbMnf9FABMFZE
 KuzVMEZNloedA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 10:41:40 +0100
Subject: [PATCH] drm/msm/a6xx: Send AB GMU votes on A8xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a8xx_ab_vote-v1-1-66afb5bc50b9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrA3ENFj1KlIkP2MdF0aSVAKSu
 zfq8lu8d0JATxhgqE7weFAgtxU0dQVmUdsXGdliEFy0DX9xFt1OhqkupUnp6XARmXjr3spOtsp
 YKOHucaZ0T8fP4/DTK5p4nSDnPzEffh12AAAA
X-Change-ID: 20261030-topic-a8xx_ab_vote-27b9d4846acd
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793353301; l=1007;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=eVOTqO7c837FF2FRgrfs8NEe8GzqfRGTnA355bl0RHI=;
 b=Wj8KHiAuUU+tmeDHSDD5iLYKughCNxCCKgvgigdfLzK5zkiLvSxA74yMKeRzFPWqSKBP+5v1h
 9QqSWJRUxKYBPflzhREFvgUFUVjiNyXpPGBwchVJjNAow7w1/cx0tBS
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This matches the kgsl behavior.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Compile-tested only
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..271e7b5fb871 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -196,7 +196,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		}
 
 		/* Vote AB as a fraction of the max bandwidth, starting from A750 */
-		if (bw && adreno_is_a750_family(adreno_gpu)) {
+		if (bw && (adreno_is_a750_family(adreno_gpu) || adreno_is_a8xx(adreno_gpu))) {
 			u64 tmp;
 
 			/* For now, vote for 25% of the bandwidth */

---
base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
change-id: 20261030-topic-a8xx_ab_vote-27b9d4846acd

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

