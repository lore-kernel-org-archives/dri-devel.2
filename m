Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9B606A332
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cCa2zPu0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D73D10E11D;
	Wed, 21 Oct 2026 14:56:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5772010E11D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=gZTrJbSsY6vrVjei/XrH6MCcYUmn2GWIequpUm2Wt/g=; b=cCa2zPu0EDDkp34pbfnc35b0Sg
 667Y8fMFynst4WW3TY7YZv8gvpLR6QZAH+sQSwhwdpXnB83pbeL9sQBIQeOGoI7Pqjmzn6O8wIQpq
 00Eh3BYIPp5HUTQAGvwQMGQshri5VsfTIK6l2MH0JRwN9uE7IdgxWQ5v8VzXEPKK0/RK0xT/FpNjL
 ydZgboRbiee83fPXPq4KuBZc0U/KWEMCQwhL7G7rstrzcEpc7SVeuGVX0/E0vnKKxDnoofcKpgnQZ
 fsbC0NZ7y/sPh0qeBZ68NuX7LZwQln1d1FdPWk2jSOIBf/XSJpUmaOlhRv+wiFw56AM6e83RtZTSX
 WqBPanbg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJXjc-005jXv-F1; Wed, 21 Oct 2026 16:56:08 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 21 Oct 2026 11:55:32 -0300
Subject: [PATCH 3/3] drm/v3d: Add TFU constant colour support for V3D 7.x
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-v3d-tfu-ccol-v1-3-4c99240cca28@igalia.com>
References: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
In-Reply-To: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=WCclP4Gfu8XzTFERJkdpY0T1XxxC4+zEWf9ED1VhWxQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq2NJ8TF6ugbJKo9ZzRT4H9lLbTHPCckYkGrf+2
 EWv7M0NTIuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCatjSfAAKCRA/8w6Kdoj6
 qkZfB/95r8u/gNMmYqCmQgbpE5X+F2eVYlehCO229L3O+RGflw17ZsYqvWUCYYd/dOs5exhrbVd
 HxcX9y1jREL84ExjseXVtxMTX3oD9eAMPwCO0iN68bg6WS8/7n3gVB0t4q2GS4TI0VKqp7YFSq3
 54vVRYIWJqrJGHW8ZFGjyuTEOkD6CpeCCPYQGqwyXiN9Uk/3/CDeWigU48hs4XN65QcmA54/8WU
 M9+My6mB5UFWNUn2TUveYgAAq3eSclTuGHRaQ9Jk7RwmMsQEx+6svbyVGUsWutuC0ut5stzXmWs
 XxDjWowVVq9javgPdUGn3K+V2HpfhURX2ILtz1e2J8Fe75HZ
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The V3D 7.x TFU can fill its output with a constant colour, read from the
CCOL0-3 registers when ICFG.IFORMAT selects constant colour. This allows
the userspace to offload buffer fills to the TFU.

Add ccol[4] to the v71 part of drm_v3d_submit_tfu and write to the CCOL0-3
registers when submitting a TFU job. To allow userspace to detect the
support, add a new V3D parameter: DRM_V3D_PARAM_SUPPORTS_TFU_CCOL.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c   |  3 +++
 drivers/gpu/drm/v3d/v3d_regs.h  | 11 +++++++++++
 drivers/gpu/drm/v3d/v3d_sched.c |  6 ++++++
 include/uapi/drm/v3d_drm.h      |  5 +++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 8d914dbc3315..b790be8a7fac 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -129,6 +129,9 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 		for (enum v3d_queue q = 0; q < V3D_MAX_QUEUES; q++)
 			args->value += atomic_read(&v3d_priv->stats[q]->reset_counter);
 		return 0;
+	case DRM_V3D_PARAM_SUPPORTS_TFU_CCOL:
+		args->value = (v3d->ver >= V3D_GEN_71);
+		return 0;
 	default:
 		drm_dbg(dev, "Unknown parameter %d\n", args->param);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index e09d6c6e188c..8cba47839bf0 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -120,6 +120,10 @@
 #define V3D_TFU_ICFG(ver) ((ver >= 71) ? 0x00708 : 0x00408)
 /* Interrupt when the conversion is complete. */
 # define V3D_TFU_ICFG_IOC                              BIT(0)
+/* V3D 7.x IFORMAT field */
+# define V3D_V7_TFU_ICFG_IFORMAT_MASK                  V3D_MASK(25, 23)
+# define V3D_V7_TFU_ICFG_IFORMAT_SHIFT                 23
+# define V3D_V7_TFU_ICFG_IFORMAT_CONSTANT_COLOUR       2
 /* V3D 7.x YVCS_RGBP field */
 # define V3D_V7_TFU_ICFG_YVCS_RGBP_MASK                V3D_MASK(15, 13)
 # define V3D_V7_TFU_ICFG_YVCS_RGBP_SHIFT               13
@@ -152,6 +156,13 @@
 /* TFU YUV Coefficient 0-3 */
 #define V3D_TFU_COEFX(ver, x)                          (V3D_TFU_COEF0(ver) + 4 * (x))
 
+/* V3D 7.x IFC Constant Colour registers (V3D 7.1+ only) */
+#define V3D_TFU_CCOL0                                  0x00738
+#define V3D_TFU_CCOL1                                  0x0073c
+#define V3D_TFU_CCOL2                                  0x00740
+#define V3D_TFU_CCOL3                                  0x00744
+#define V3D_TFU_CCOLX(x)                               (V3D_TFU_CCOL0 + 4 * (x))
+
 /* V3D 4.x only */
 #define V3D_TFU_CRC                                    0x00434
 
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 9d18d2e67148..43fb97de64dd 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -312,6 +312,12 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	if (v3d->ver >= V3D_GEN_71) {
 		V3D_WRITE(V3D_V7_TFU_IOC, job->args.v71.ioc);
 
+		if (V3D_GET_FIELD(job->args.icfg, V3D_V7_TFU_ICFG_IFORMAT) ==
+		    V3D_V7_TFU_ICFG_IFORMAT_CONSTANT_COLOUR) {
+			for (int i = 0; i < 4; i++)
+				V3D_WRITE(V3D_TFU_CCOLX(i), job->args.v71.ccol[i]);
+		}
+
 		if (V3D_GET_FIELD(job->args.icfg, V3D_V7_TFU_ICFG_YVCS_RGBP) ==
 		    V3D_V7_TFU_ICFG_YVCS_RGBP_USER_INPUT) {
 			for (int i = 0; i < 4; i++)
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index d9b01f4c3a04..2750a6fbb6b8 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -296,6 +296,7 @@ enum drm_v3d_param {
 	DRM_V3D_PARAM_SUPPORTS_SUPER_PAGES,
 	DRM_V3D_PARAM_GLOBAL_RESET_COUNTER,
 	DRM_V3D_PARAM_CONTEXT_RESET_COUNTER,
+	DRM_V3D_PARAM_SUPPORTS_TFU_CCOL,
 };
 
 struct drm_v3d_get_param {
@@ -342,6 +343,10 @@ struct drm_v3d_submit_tfu {
 
 	struct {
 		__u32 ioc;
+
+		/* Constant Colour Data */
+		__u32 ccol[4];
+
 		__u32 pad;
 	} v71;
 };

-- 
2.56.0

