Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA5606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=maPI7XGt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB5F10E4F4;
	Tue, 17 Nov 2026 05:20:59 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 25F1310E4B0;
 Tue, 17 Nov 2026 05:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=fPIg4rPaRU
 Xpf1q/YKJMGapkh2w3kNaSjtRfayniq/Y=; b=maPI7XGtZ5OHJpuhzsBugguDFx
 Ofd5LMEMRKAE7SoLIDcpBuAhb4YvYGbFBa90GYcwjuq+MglfW3tZ9qVYdDAOXVzY
 N8HWdA6QSPwg2YbytelVRGEKh8wfVyOfm7YZ0qs6eB20QJRWBjQwNEDWlOeg2kdi
 19qV2MH/aiQZFOMz8=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDnZTov5PtqFULLAA--.1623S2;
 Tue, 17 Nov 2026 13:20:47 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2] drm/msm/dpu: reject undersized gamma LUT blobs
Date: Tue, 17 Nov 2026 13:20:46 +0800
Message-ID: <20261117052046.32092-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDnZTov5PtqFULLAA--.1623S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF47WF18uw1DKFW5Zw17trb_yoW5JF48pF
 W3CFy5tr1qq3yfKwn7GF1vka98Cwn5Xay7GFy7K3sxZFyxAr1YvF95AayDuryUZw12yr1a
 qFyDJr98GF109aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
 wI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
 W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oa0PUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwAMsz
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

_dpu_crtc_get_gc_lut() packs DPU_GAMMA_LUT_SIZE entries of the
user-provided LUT unconditionally:

	for (i = 0; i < PGC_TBL_LEN; i++) {
		val_even = drm_color_lut_extract(lut[i * 2].green, 10);
		...

The DRM core validates the blob against the maximum size and the element
size (drm_property_replace_blob_from_id() with max_size and
expected_elem_size), but not against the exact size, so a blob that is
shorter than DPU_GAMMA_LUT_SIZE * sizeof(struct drm_color_lut) is accepted
and the loop reads past the end of the blob.

Reject such blobs in dpu_crtc_atomic_check().  This is reachable from
userspace on any DPU platform that exposes the GC block (SDM845, SM8650,
SM8750, ...).

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
---
v2: only the commit message changed (added the Fixes: tag asked for in
    <h346otfneexdgpndvmydknzuxuljywvflaoss3xppblp4k2svo@wcanozcwnysb>);
    the diff is byte-identical to v1.

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b4..7a2ed9ad64 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1534,6 +1534,21 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
 
+	/*
+	 * The DRM core only checks the blob against the maximum LUT size and
+	 * the element size, so a shorter blob is accepted.  The GC path packs
+	 * DPU_GAMMA_LUT_SIZE entries unconditionally, so validate the size
+	 * here to avoid reading past the end of the blob.
+	 */
+	if (crtc_state->gamma_lut &&
+	    crtc_state->gamma_lut->length !=
+			DPU_GAMMA_LUT_SIZE * sizeof(struct drm_color_lut)) {
+		DRM_DEBUG_ATOMIC("%s: invalid gamma LUT size %zu, expected %zu\n",
+				 dpu_crtc->name, crtc_state->gamma_lut->length,
+				 DPU_GAMMA_LUT_SIZE * sizeof(struct drm_color_lut));
+		return -EINVAL;
+	}
+
 	/* don't reallocate resources if only ACTIVE has beeen changed */
 	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
 	    crtc_state->color_mgmt_changed) {
-- 
2.53.0

