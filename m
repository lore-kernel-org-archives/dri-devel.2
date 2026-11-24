Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC52B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=fAboNPbu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=6BMe9E2q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C5110E8FC;
	Tue, 24 Nov 2026 00:03:01 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4744F10E8FC
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 00:02:50 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AB0AC14003A3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:02:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 19:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795478569; x=
 1795564969; bh=FagAZg+Im8kBz6Vcei8zm5WZ7a1dtTdHDa3QEm1Bml0=; b=f
 AboNPbu9dG6rWXMqRDfDQ0BcbMYvTO36fMJUm5Yb51iZtsfiJ+kk5Tp6tVPK98Mz
 mUdShBiv6BREb9w4LRB79dyWJLkPMtU5NvFpJhvbjHq/uyci654fBIH/V8FGGHGj
 z6ORZOrA6cs91ILWeW6sLu684BVmHDAPmCzfFnjFDXi6n0zjiN2Mm8SXLz5MRr+3
 KsC/EHHSIC/HZxIWhhn00UF5v9HMg/8dja+Cl4fVK2zsAp/BozDgW1O6YB3IpALl
 wwHQSbcrHahWFaMnaQUUpf5xMPdUNsgNfUOBJjddmd80LVhIsgdIY2tRfxPDDzYO
 rbiQsnSVs3gVee+c2pn2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795478569; x=1795564969; bh=F
 agAZg+Im8kBz6Vcei8zm5WZ7a1dtTdHDa3QEm1Bml0=; b=6BMe9E2qyXpwxbraK
 w41uF9ukHJ5CgAXn8QztQRwPtVweVWPITDJDhmp9WEe/e553OkDzCJzJwrGSEY56
 83+5e1vU11z/So6uFK3R2ybAfDxlQllfb/fD7Qki8bQqqW7C77UgEfyLbFMEl60l
 g0gdxrbpQfkTBGESu45kaABhi2yBOj+VR4Rgw6nGVRbA0Tg87eJ+hPyUnx5lZAHR
 OFS3z/w/YC4Zq/Zuw2V4X6XmH+n4eercfNIKcR35vYHYxkDJAhZUZLKSJCqEiF+0
 ZqmdEykPFDgKQD/sWSj/VHXoPvjyOjqdc4nIbL9z+wKvmMzBaSV+0bU+K8FZ/rd8
 tImdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478569; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:RJfrgaTfKHogpjvKtyEl9zlI9AAujWTu3yw3VEPvzOumBjw
 IfvZpCpOJ2Nb34AWkY+u77eUEHWL312kbkffP3LaLTZ/a6IIFZrrjkWqayd6KHxi
 Owi4yHvqgYie+ut0h95fCiRb/uEwsIwM9nUZ4NNDOm1XVMWmh+Q8WqSvxkxMquUe
 KZvSEruXlDufGXXeyNjlZPbO2bK1WIEFQ4LdgLbh+v2IhH5s3WhVJPgleY2AaHsI
 hs27T6lDrvesbLAf2DGHCc6o3qoFQHdJ6cej+fehDtVtsOZYnhpo+TsCfPkN+HSA
 suFMLwiINLeZQSKkqBGtSRe0c3RyCFiEJ52NgvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:o6FP75dJKH9X5/9KPNLMRJ9lfUK/DT24mcLPsEaVg+c=:AHiG4a7x119G+X4jdteSkHgTCheNVw/xoy7P3CIiUKY=;
X-ME-Sender: <xms:KdQEa3U_8BkE3Ae3AyIDhshogt2qlYW8YxVT87jkz59S0At9QzYT5A>
 <xme:KdQEa58Km3iD1FSuOes4RZkeBFR2Mfal_B8xMRBx3oU5NHV25wAYczg-zS0sNlCEw
 7fTa9tEd8Xwn4nuGfVVAbehuRpapy4OE2hvmz73Rof0hYcLaTWqn4Jx>
X-ME-Received: <xmr:KdQEa-_g--3woyN6QziPdAXjsCwQUdiADt2GUSjbSDM8EVnB56buIyVj4M40qsiQprP1bJdh>
X-ME-Proxy-Cause: dmFkZTFGJwiJYq3bYmfBLb8pMOOvLmIOZgVzH901YDuykMl1dQznEGwIVrklNvPXzWnPu7
 fShZisimGLCbctWsvfk14BQ9Z8GtL4/tyCc2kin9zS/oloRTXmjb9giwCT+mcbqOg+OmOd
 k1FdvdUynDyL8kBV9+4RAISGHAEL/bgEYJ+vJw344jxkEBIbLc5oapoi/JYx4ozS4mQE9k
 Etq6lydb9uYCqCXYOWnLKpk5G3ixKNSXJUInIJOQFVjTBYMYq5+EOO0l6OAa8RgRhARcRT
 8kECX18/pyz8TwgSsWL/kps1Gl6gGTw6vLOWFFeWEhWKydQnLF7BSQXoJp22mQMskgz6GI
 wizvM0qsIrAMqUlKU37NfquZj1MkwmA55EK+HZG3CpsYu5ITnSvSCWA4axCAAC4RBtykYH
 1s8zqb9GoMzPnMLSRUda+O8+W52I+cYk8vJTn+tmHnH0xg79YqUrFB/7CB5ptdr583WtH9
 EDW9D7fv2dD4Nc55P0Yz53keVpU+MDrtwgxGJyS/HFNBRU5Z/L10nzf59TS2bJu6DplVmO
 6Wrlg0PTMdZ9go0FDZEf7EXUTIJ4LUQG7DC+SnqluV+5WLD1vbsg/v569aAcMUo4XSqz0N
 HmK5K8SmRutZeKucoNyRFH7q0gtZfRPryDfAurrmyxWgdBjjBbwOiNAX9u5Q
X-ME-Proxy: <xmx:KdQEa8U6SYxpFEnn7828_PkbM7x-pRRRk8gES3-fZHCx4gXevO8CDQ>
 <xmx:KdQEa7aVz1hvl26GcI7iP5313I-_FMTXSpBkGQV922vjCVQb5uTX9g>
 <xmx:KdQEa-oO1Pqpu1P6ME_QuFD6DHLedKtv2MbCLBF3hguoPzV2cLzqUg>
 <xmx:KdQEa65NUAeUdlyJmK1WNto2udrla_geX80cu_Khijt17Z4fQP9U_Q>
 <xmx:KdQEax8EFZ9PIF-KEem3LopjWg6yaXFZXSDq7ttca_dbP-EX1sAPYbla>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:02:40 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: ddrake@baylibre.com, royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v18 5/8] accel/rocket: add a GET_PARAM ioctl for the hardware
 version
Date: Tue, 24 Nov 2026 13:01:40 +1300
Message-ID: <cbb77a43deedadb6667a84bd1c57030cf1c9ce74.1795478392.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795478392.git.gahing@gahingwoo.com>
References: <cover.1795478392.git.gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can tell which NPU it
runs on. DRM_ROCKET_PARAM_HW_VERSION returns an enum
drm_rocket_hw_version value, taken from the compatible's match data when
the first core probes. The PC_VERSION registers cannot be used: the
RK3568 reads 0 from them.

A core with a different hardware version is refused. An unknown
parameter or a non-zero reserved field returns -EINVAL.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_device.c |  4 ++-
 drivers/accel/rocket/rocket_device.h |  6 +++-
 drivers/accel/rocket/rocket_drv.c    | 34 +++++++++++++++++++++--
 include/uapi/drm/rocket_accel.h      | 41 ++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index db137e2ec15e..3bceeb2cbedb 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -11,7 +11,8 @@
 #include "rocket_device.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
-					 const struct drm_driver *rocket_drm_driver)
+					 const struct drm_driver *rocket_drm_driver,
+					 u32 hw_version)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *core_node;
@@ -26,6 +27,7 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
+	rdev->hw_version = hw_version;
 
 	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
 		if (of_device_is_available(core_node))
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index c62d56701069..40cabae538bc 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -20,10 +20,14 @@ struct rocket_device {
 	struct rocket_core *cores;
 	unsigned int num_cores;
 	unsigned int max_cores;
+
+	/* enum drm_rocket_hw_version of the NPU, the same for all cores */
+	u32 hw_version;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
-					 const struct drm_driver *rocket_drm_driver);
+					 const struct drm_driver *rocket_drm_driver,
+					 u32 hw_version);
 void rocket_device_fini(struct rocket_device *rdev);
 #define to_rocket_device(drm_dev) \
 	((struct rocket_device *)(container_of((drm_dev), struct rocket_device, ddev)))
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index b72f4fbd8e29..8aa431db5968 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -5,6 +5,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
 #include <drm/rocket_accel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -12,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 
 #include "rocket_device.h"
 #include "rocket_drv.h"
@@ -128,6 +130,26 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
 	module_put(THIS_MODULE);
 }
 
+static int
+rocket_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct rocket_device *rdev = to_rocket_device(dev);
+	struct drm_rocket_get_param *args = data;
+
+	if (args->reserved != 0) {
+		drm_dbg(dev, "Reserved field in drm_rocket_get_param struct should be 0.\n");
+		return -EINVAL;
+	}
+
+	switch (args->param) {
+	case DRM_ROCKET_PARAM_HW_VERSION:
+		args->value = rdev->hw_version;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 #define ROCKET_IOCTL(n, func) \
 	DRM_IOCTL_DEF_DRV(ROCKET_##n, rocket_ioctl_##func, 0)
@@ -136,6 +158,7 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	ROCKET_IOCTL(SUBMIT, submit),
 	ROCKET_IOCTL(PREP_BO, prep_bo),
 	ROCKET_IOCTL(FINI_BO, fini_bo),
+	ROCKET_IOCTL(GET_PARAM, get_param),
 };
 
 DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
@@ -174,9 +197,13 @@ static int rocket_core_hw_index(struct device *dev)
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	u32 hw_version = (uintptr_t)device_get_match_data(&pdev->dev);
 	int index = rocket_core_hw_index(&pdev->dev);
 	int ret;
 
+	if (!hw_version)
+		return -ENODEV;
+
 	if (index < 0)
 		return index;
 
@@ -185,7 +212,7 @@ static int rocket_probe(struct platform_device *pdev)
 		rdev_group = devres_open_group(&drm_dev->dev, NULL, GFP_KERNEL);
 		if (!rdev_group)
 			return -ENOMEM;
-		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
+		rdev = rocket_device_init(drm_dev, &rocket_drm_driver, hw_version);
 		if (IS_ERR(rdev)) {
 			int err = PTR_ERR(rdev);
 
@@ -197,6 +224,9 @@ static int rocket_probe(struct platform_device *pdev)
 		devres_close_group(&drm_dev->dev, rdev_group);
 	}
 
+	if (hw_version != rdev->hw_version)
+		return -EINVAL;
+
 	unsigned int core = rdev->num_cores;
 
 	dev_set_drvdata(&pdev->dev, rdev);
@@ -243,7 +273,7 @@ static void rocket_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = (void *)DRM_ROCKET_HW_RK3588 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/include/uapi/drm/rocket_accel.h b/include/uapi/drm/rocket_accel.h
index d0685e372b79..c9271e469231 100644
--- a/include/uapi/drm/rocket_accel.h
+++ b/include/uapi/drm/rocket_accel.h
@@ -15,11 +15,13 @@ extern "C" {
 #define DRM_ROCKET_SUBMIT			0x01
 #define DRM_ROCKET_PREP_BO			0x02
 #define DRM_ROCKET_FINI_BO			0x03
+#define DRM_ROCKET_GET_PARAM			0x04
 
 #define DRM_IOCTL_ROCKET_CREATE_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_ROCKET_CREATE_BO, struct drm_rocket_create_bo)
 #define DRM_IOCTL_ROCKET_SUBMIT			DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_SUBMIT, struct drm_rocket_submit)
 #define DRM_IOCTL_ROCKET_PREP_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_PREP_BO, struct drm_rocket_prep_bo)
 #define DRM_IOCTL_ROCKET_FINI_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_FINI_BO, struct drm_rocket_fini_bo)
+#define DRM_IOCTL_ROCKET_GET_PARAM		DRM_IOWR(DRM_COMMAND_BASE + DRM_ROCKET_GET_PARAM, struct drm_rocket_get_param)
 
 /**
  * struct drm_rocket_create_bo - ioctl argument for creating Rocket BOs.
@@ -185,6 +187,45 @@ struct drm_rocket_submit {
 	__u64 reserved;
 };
 
+/**
+ * enum drm_rocket_param - parameters for DRM_IOCTL_ROCKET_GET_PARAM
+ * @DRM_ROCKET_PARAM_HW_VERSION: which NPU this is, as an
+ *	enum drm_rocket_hw_version value.
+ */
+enum drm_rocket_param {
+	DRM_ROCKET_PARAM_HW_VERSION = 0,
+};
+
+/**
+ * enum drm_rocket_hw_version - the NPU, for DRM_ROCKET_PARAM_HW_VERSION
+ * @DRM_ROCKET_HW_RK3588: the NPU of the RK3588.
+ *
+ * 0 is not used.
+ */
+enum drm_rocket_hw_version {
+	DRM_ROCKET_HW_RK3588 = 1,
+};
+
+/**
+ * struct drm_rocket_get_param - ioctl argument for querying a parameter.
+ */
+struct drm_rocket_get_param {
+	/**
+	 * @param: Input: an enum drm_rocket_param value.
+	 */
+	__u32 param;
+
+	/**
+	 * @reserved: Reserved, must be zero.
+	 */
+	__u32 reserved;
+
+	/**
+	 * @value: Output: the value of the parameter.
+	 */
+	__u64 value;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

