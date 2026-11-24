Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D5606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b80r5+Pd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECE610F13C;
	Tue, 24 Nov 2026 22:47:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B173910E26D;
 Tue, 24 Nov 2026 22:47:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C789412B1;
 Tue, 24 Nov 2026 22:47:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795560427;
 b=tz0LWDaEYvNI5wiD2AqZ79KSah2zsc54W0lozbOomPaHPeEnsJbOt2PhiWAvzrplcxRY
 c5bHnOfzzfbG5TmlMjZ3gILS/R9NUyiU0BawQMK0xnuaMabUg2sPXui3tffNT0hf32MP0
 zqQZq9kdO+rUXYHRl8IMKzcoglL1r8lpb3X/ksPDqzlwWMAbwSrkF/T5+6UWFf9pE3lHX
 RaafmmI2EOnJC7y4Z7G88CpJSn3jyC/qrnQ3g0b1rCUJtzUJ3xbJZIReQx4nTcYXfvZfx
 pZ0ra//PdTZmZDa3NNTHU6rTOUXA2YQeJ3J64tgj1cnEuSpcjqrLWcEL+8qnZDJx8og==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795560427;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=V1E0A45IWVmzuKrYVO4JyVjaitHwHUyvy9w2h0vkdcQ=;
 b=dumW9OPPTDxHt7vyGG/qluKJwXuZe5//+DVlnS/QIlMHUbbmZsnWITTL5hNT17NZNztT
 yk85ZpLW05dzG98zuDLXn4TqbaOiJNAfLmL2a84OiYlrpWtHSsztZTKe2amtNw8FGreaO
 d5yr7mLRuyyYx666/hIEpkVHNtO+eDKpt290T13aJMoyL59bhrE5l6IMm3/09MPzwbmoL
 sRVSr0rDY0hp0olqDaBmiMTcV3Zdy22UsjSdUKePALOb/wDhRt6jb5/V7ZSCyHnHuZIgU
 gtWiLrlGofuT5o9b9IO67O3BvMGflN46tVEB2qRTyrIwNQSNsXtP/faDvAl4ChWoKqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8E4F31F000C6;
 Tue, 24 Nov 2026 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795560427;
 bh=V1E0A45IWVmzuKrYVO4JyVjaitHwHUyvy9w2h0vkdcQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=b80r5+PdDz8cDDf+O4OzvBBUZ9mBkGPHgqrteFm2dHLJwpl9J2wfQhrkuRiNqA+d+
 kqjsmRyJq66z3fJ0ZA3eYE96T7ENZAJa/yn9jugPYbTpCSc792nY7D8h84X39iUrQ8
 ettWkpLOfOp4ivdPb5fz3/BKoUL6zfEoyqldWxq3llv80KM7LMCt98U5sChIHMM9QJ
 0J2dfopI+aQ4ReK7htj9NjXsX12BX4V5nULB7GnVUufPQsxC5gydyHJOrKF2AO5uc4
 rUbbYlsv6cA2hAJX0cK7sykSDgJBzxXDRtGB8yK6hlLAVZ9MUX1Ve+OkBVT0rvXfeR
 7XtWsPrRR+Kqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 223EB4CBDA;
 Tue, 24 Nov 2026 22:46:53 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 23:46:52 +0100
Subject: [PATCH] drm/msm/dpu: sc8180x: restore dp_phy_intf_sel on runtime
 resume
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-drm-msm-dpu-sc8180x-resume-v1-1-a6201f43136d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAwA0F8ZORtYyhydvyIeNM00QudIVhmM/
 btVj+/yNnAxFYdTs4HJW11fUwUdGuDHdboLaqqG0IaeKHSYLGP2jGku6BwptiuaeMmCQmmgLvJ
 xIIYazCajrr/8fPnby+0pvHxH2PcPEEPraH4AAAA=
X-Change-ID: 20261124-drm-msm-dpu-sc8180x-resume-e1d9148c591c
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Robert Ijtsma <robertijtsma@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795560412; l=2603;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=LEmFhgAwoaN37Scx4SDiFsrI98URrH/adaZQ6fMNsJ0=;
 b=INOGyHygY6Tv+74+M2k8AElw9Kze/4QI4LXYWJ2VRw2Wk3YNQWM0+SiNE3nHBL94sYsecWXUa
 HgUlPP8KsSpA8ANTB4BLOKY1Mo6YH5QBEEFKWI083nhHrSJAUFPbakM
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
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
Reply-To: robertijtsma@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Ijtsma <robertijtsma@gmail.com>

On SC8180X, MDP_DP_PHY_INTF_SEL is currently programmed only once during
dpu_kms_hw_init(). When MDSS/DPU loses register state across runtime PM
or s2idle suspend/resume, dpu_runtime_resume() restores VBIF memtypes
via dpu_vbif_init_memtypes() but leaves MDP_DP_PHY_INTF_SEL reset to
zero, misrouting eDP/DP output after resume.

Factor out dpu_kms_setup_dp_phy_intf_sel() and invoke it from both
dpu_kms_hw_init() and dpu_runtime_resume().

Fixes: be3415c620d1 ("drm/msm/dpu: Configure DP INTF/PHY selector")
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Restore MDP_DP_PHY_INTF_SEL in dpu_runtime_resume() on SC8180X so eDP/DP
PHY routing survives MDSS runtime PM and s2idle power collapse.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 1b6286d..31166e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1135,6 +1135,16 @@ unsigned long dpu_kms_get_clk_rate(struct dpu_kms *dpu_kms, char *clock_name)
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
+static void dpu_kms_setup_dp_phy_intf_sel(struct dpu_kms *dpu_kms)
+{
+	if (!dpu_kms->hw_mdp || !dpu_kms->hw_mdp->ops.dp_phy_intf_sel)
+		return;
+
+	if (of_device_is_compatible(dpu_kms->pdev->dev.of_node, "qcom,sc8180x-dpu"))
+		dpu_kms->hw_mdp->ops.dp_phy_intf_sel(dpu_kms->hw_mdp,
+						     (unsigned int[]){ 1, 2, });
+}
+
 static int dpu_kms_hw_init(struct msm_kms *kms)
 {
 	struct dpu_kms *dpu_kms;
@@ -1246,8 +1256,7 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 	 * the INTF <->DP relationship isn't static anymore, this needs to be
 	 * configured through the DT.
 	 */
-	if (of_device_is_compatible(dpu_kms->pdev->dev.of_node, "qcom,sc8180x-dpu"))
-		dpu_kms->hw_mdp->ops.dp_phy_intf_sel(dpu_kms->hw_mdp, (unsigned int[]){ 1, 2, });
+	dpu_kms_setup_dp_phy_intf_sel(dpu_kms);
 
 	dpu_kms->hw_intr = dpu_hw_intr_init(dev, dpu_kms->mmio, dpu_kms->catalog);
 	if (IS_ERR(dpu_kms->hw_intr)) {
@@ -1464,6 +1473,7 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
 	}
 
 	dpu_vbif_init_memtypes(dpu_kms);
+	dpu_kms_setup_dp_phy_intf_sel(dpu_kms);
 
 	drm_for_each_encoder(encoder, ddev)
 		dpu_encoder_virt_runtime_resume(encoder);

---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261124-drm-msm-dpu-sc8180x-resume-e1d9148c591c

Best regards,
--  
Robert Ijtsma <robertijtsma@gmail.com>


