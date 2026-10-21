Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD55606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=n8ExSwXv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A90310E24D;
	Wed, 21 Oct 2026 14:56:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A1210E10E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=kfnDxCQ1IImtBOQdrk0BB+dlXrbFTbM9NH9uFng7ZsE=; b=n8ExSwXvKDof5cuQf00b9HA+dx
 hcn8lz+93+esPpV7AKh06WgsAN3r+Jw8aRtL16mSfRZ+z+nmU4I4eY1mCBO7qZ0PaLgpaqil/YCfg
 X02lQuwAQ0VqGan+1jmJ6HbcQxgy3fpy2ai+0I+j+/X8jG+GQLZe2UmaU8oKwWyp+chL2c6jak167
 WSHOUMz0CTCHNMQrnBeHb7cefUZ4SOOoafJQyMbgIKJPzcTzHz/oc6AtjLA8aqGICUZyTo8/QWWE6
 wI3cxZvVfdq5D39LRaA8EYxp+0vCpz3m787dYZAys/qkhO/z+MWD2aHQeeYU+GCmEjvO2BHCqM0wr
 RYCfRdGg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJXjZ-005jXv-G8; Wed, 21 Oct 2026 16:56:05 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 21 Oct 2026 11:55:31 -0300
Subject: [PATCH 2/3] drm/v3d: Only program TFU coefficients when used on
 V3D 7.x
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-v3d-tfu-ccol-v1-2-4c99240cca28@igalia.com>
References: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
In-Reply-To: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3774; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Ci5feCu+4gtY7GAz6UMawDspIgW8tP28CBnfs4TDNVM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq2NJ83+PwhYCpwRYbm40R3x1Ai+CMDqpgXXOYU
 z8H4VMRUMmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCatjSfAAKCRA/8w6Kdoj6
 quKeB/4ncFZehbERmKUstqpaff13ckn2Qk6ThsCPE3m13ojUKYLgLW+pPXOxYT2fz62Yi0BfCWG
 +vMVjdN6lIlNLcmTS8Js35dZ/1hWLLt4Wc2xbKReICZG1+uynEKr2pnWRkfv/nJw/dajzN3LJFb
 yDPSMKH4lNmdw4/y08xWlBonps/L54j983YJSccalyMIkz17D+GIuFPlso8k4SUujvbBdjzZJ+N
 TV3ikPtDHncsJ8NT5tEgm1MrZZ39w62T4M4n8+lF1Y9nt5LJOU1t9CW6Bi+4CAxA8Nbrb5m7Gey
 UtckPNitnJGnhwX4LaFmd9hYYFFu3yaKDzh4rgPR0us8nJ9m
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

On V3D 7.x, the YUV coefficient registers are written for every TFU job,
although the hardware only uses them when the field YVCS_RGBP of the
register ICFG informs that there are user-provided coefficients. Skip the
writes otherwise, matching V3D 4.x, where COEF1-3 are only written when
COEF0.USECOEF is set.

To improve the readeability of the code, create a V3D_TFU_COEFX macro to
iterate between the registers COEF 0-3. Also, while here, fix a typo in
the IOC register comment.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_regs.h  |  8 +++++++-
 drivers/gpu/drm/v3d/v3d_sched.c | 24 +++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index c1870265eaee..e09d6c6e188c 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -120,6 +120,10 @@
 #define V3D_TFU_ICFG(ver) ((ver >= 71) ? 0x00708 : 0x00408)
 /* Interrupt when the conversion is complete. */
 # define V3D_TFU_ICFG_IOC                              BIT(0)
+/* V3D 7.x YVCS_RGBP field */
+# define V3D_V7_TFU_ICFG_YVCS_RGBP_MASK                V3D_MASK(15, 13)
+# define V3D_V7_TFU_ICFG_YVCS_RGBP_SHIFT               13
+# define V3D_V7_TFU_ICFG_YVCS_RGBP_USER_INPUT          2
 
 /* Input Image Address */
 #define V3D_TFU_IIA(ver) ((ver >= 71) ? 0x0070c : 0x0040c)
@@ -129,7 +133,7 @@
 #define V3D_TFU_IIS(ver) ((ver >= 71) ? 0x00714 : 0x00414)
 /* Input Image U-Plane Address */
 #define V3D_TFU_IUA(ver) ((ver >= 71) ? 0x00718 : 0x00418)
-/* Image output config (VD 7.x only) */
+/* Image output config (V3D 7.x only) */
 #define V3D_V7_TFU_IOC                                 0x0071c
 /* Output Image Address */
 #define V3D_TFU_IOA(ver) ((ver >= 71) ? 0x00720 : 0x0041c)
@@ -145,6 +149,8 @@
 #define V3D_TFU_COEF2(ver) ((ver >= 71) ? 0x00730 : 0x0042c)
 /* TFU YUV Coefficient 3 */
 #define V3D_TFU_COEF3(ver) ((ver >= 71) ? 0x00734 : 0x00430)
+/* TFU YUV Coefficient 0-3 */
+#define V3D_TFU_COEFX(ver, x)                          (V3D_TFU_COEF0(ver) + 4 * (x))
 
 /* V3D 4.x only */
 #define V3D_TFU_CRC                                    0x00434
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1924e3440dc9..9d18d2e67148 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -307,15 +307,25 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	V3D_WRITE(V3D_TFU_ICA(v3d->ver), job->args.ica);
 	V3D_WRITE(V3D_TFU_IUA(v3d->ver), job->args.iua);
 	V3D_WRITE(V3D_TFU_IOA(v3d->ver), job->args.ioa);
-	if (v3d->ver >= V3D_GEN_71)
-		V3D_WRITE(V3D_V7_TFU_IOC, job->args.v71.ioc);
 	V3D_WRITE(V3D_TFU_IOS(v3d->ver), job->args.ios);
-	V3D_WRITE(V3D_TFU_COEF0(v3d->ver), job->args.coef[0]);
-	if (v3d->ver >= V3D_GEN_71 || (job->args.coef[0] & V3D_TFU_COEF0_USECOEF)) {
-		V3D_WRITE(V3D_TFU_COEF1(v3d->ver), job->args.coef[1]);
-		V3D_WRITE(V3D_TFU_COEF2(v3d->ver), job->args.coef[2]);
-		V3D_WRITE(V3D_TFU_COEF3(v3d->ver), job->args.coef[3]);
+
+	if (v3d->ver >= V3D_GEN_71) {
+		V3D_WRITE(V3D_V7_TFU_IOC, job->args.v71.ioc);
+
+		if (V3D_GET_FIELD(job->args.icfg, V3D_V7_TFU_ICFG_YVCS_RGBP) ==
+		    V3D_V7_TFU_ICFG_YVCS_RGBP_USER_INPUT) {
+			for (int i = 0; i < 4; i++)
+				V3D_WRITE(V3D_TFU_COEFX(v3d->ver, i), job->args.coef[i]);
+		}
+	} else {
+		V3D_WRITE(V3D_TFU_COEF0(v3d->ver), job->args.coef[0]);
+
+		if (job->args.coef[0] & V3D_TFU_COEF0_USECOEF) {
+			for (int i = 1; i < 4; i++)
+				V3D_WRITE(V3D_TFU_COEFX(v3d->ver, i), job->args.coef[i]);
+		}
 	}
+
 	/* ICFG kicks off the job. */
 	V3D_WRITE(V3D_TFU_ICFG(v3d->ver), job->args.icfg | V3D_TFU_ICFG_IOC);
 

-- 
2.56.0

