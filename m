Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87789606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=mr0XE0sE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0689510E3DC;
	Sun,  1 Nov 2026 11:58:19 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 74AB010E012
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=NwxbiKZt5M6bguLSwezvKHdUYiGPqH05Pt
 mFGqFk5EE=; b=mr0XE0sEItzOPl7x19LcUZFi5gYUt7VgIhMkPpMfZUG3nYvody
 hbJHwMJywo7aWBrLgsdKWJfL3i1UcWb6SMw3b/0cOQVu/CxxNu2RBiwjjjN3WewD
 NiyAq03PZmLR19pMiA9emMYsMmdbc1Z4Orbzk9512af8lSA/GUxQoFxuI=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.113])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDHS0ApA+ZqqSNvAA--.5005S3;
 Sat, 31 Oct 2026 23:03:06 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/msm/dsi: move bonded command failure flag into dsi
 manager state
Date: Sat, 31 Oct 2026 23:03:01 +0800
Message-ID: <20261031150305.1107572-2-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDHS0ApA+ZqqSNvAA--.5005S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xKr48Wr4fCry8Xw4xWFg_yoW5Gr48p3
 9rWw4jvFWqv3ZI9anIyFW5CF1fAFn3Gas7J3ZrWw4xAFs8t3W5ZrykXrW3KrySvFy8AF1j
 qa1DGFyFqF1xG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4
 AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bw
 LvNUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARERB2rk8FY0gwAGsf
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bonded-DSI command path kept a file-scoped `static bool
dsi_bonded_cmd_failed` next to the global manager instance, so bonded
state was split across two storage classes. Move the flag into
struct msm_dsi_manager (msm_dsim_glb) so the manager owns all of it and
nothing mutable stays file-scoped. READ_ONCE/WRITE_ONCE use is unchanged,
so behaviour is identical.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 559c07a8b9..93d636220b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -30,6 +30,7 @@ struct msm_dsi_manager {
 	bool is_bonded_dsi;
 	bool is_sync_needed;
 	bool is_sm8750;
+	bool bonded_cmd_failed;
 	int master_dsi_link_id;
 };
 
@@ -37,8 +38,10 @@ static struct msm_dsi_manager msm_dsim_glb = {
 	.master_dsi_link_id = -1,
 };
 
+/* Serialises bonded command transactions; the failure flag it guards lives in
+ * msm_dsim_glb so no bonded state is file-scoped.
+ */
 static DEFINE_MUTEX(dsi_bonded_cmd_lock);
-static bool dsi_bonded_cmd_failed;
 
 #define IS_BONDED_DSI()		(msm_dsim_glb.is_bonded_dsi)
 #define IS_SYNC_NEEDED()	(msm_dsim_glb.is_sync_needed)
@@ -51,7 +54,8 @@ static bool dsi_mgr_uses_bonded_cmd(void)
 
 bool msm_dsi_manager_cmd_failed(void)
 {
-	return dsi_mgr_uses_bonded_cmd() && READ_ONCE(dsi_bonded_cmd_failed);
+	return dsi_mgr_uses_bonded_cmd() &&
+	       READ_ONCE(msm_dsim_glb.bonded_cmd_failed);
 }
 
 static inline struct msm_dsi *dsi_mgr_get_dsi(int id)
@@ -374,7 +378,7 @@ static void dsi_mgr_bridge_enable(struct drm_bridge *bridge,
 	if (!panel->prepared) {
 		dev_err(&msm_dsi->pdev->dev,
 			"panel is not prepared; refusing video enable\n");
-		WRITE_ONCE(dsi_bonded_cmd_failed, true);
+		WRITE_ONCE(msm_dsim_glb.bonded_cmd_failed, true);
 		return;
 	}
 
@@ -646,7 +650,7 @@ static int dsi_mgr_bonded_cmd_xfer(const struct mipi_dsi_msg *msg)
 	ret = master_ret < 0 ? master_ret : slave_ret < 0 ? slave_ret : len;
 	if (ret < 0) {
 		/* Never reuse a packet buffer while either DMA engine is unresolved. */
-		WRITE_ONCE(dsi_bonded_cmd_failed, true);
+		WRITE_ONCE(msm_dsim_glb.bonded_cmd_failed, true);
 		dev_err(&master_dsi->pdev->dev,
 			"bonded command DMA failed: master=%d peer=%d\n",
 			master_ret, slave_ret);
-- 
2.53.0

