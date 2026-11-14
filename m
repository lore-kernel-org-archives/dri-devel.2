Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92460606A33E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=AjzfS0WA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s7oJj5QK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F9810E647;
	Sat, 14 Nov 2026 03:07:42 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922A710E647
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:07:32 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.phl.internal (Postfix) with ESMTP id F2E921381A50
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:07:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 22:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625651; x=
 1794632851; bh=aKwnhfxjZ2H3/fk0iKxR4EQwzXRHmOE32L9gj5tvdXE=; b=A
 jzfS0WADolvgPWTfpPw8rwj0Iirl4A2uLtnTtWhEvf1eZUE+G7wr+UinTXOKFo8Y
 ri5RXhKFlxxXwxaGKYJlQYXfv7pqhL28rKO5Plu/P05uUt2NxkQhI8CzeqjwZV2m
 KVbaovBRNP5V222fcq8icFKNObs4mvGzTmTWZtVpnRO1uj8CghoPQNAzr9myeR6S
 16aBP1h1G50j7f6FJst9cV6ijknMBnCHnolLgqXexnOS1o1jW9vMC8W7Ek5Wr3wP
 e7sJEVSwiqrPj+uyupDajew4nDNtL6eld+2poDmTK5tSdEJvypZqtDJ14ZYa0Iuy
 LLsJwN+2Pfo7SSJpRhwGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625651; x=1794632851; bh=a
 KwnhfxjZ2H3/fk0iKxR4EQwzXRHmOE32L9gj5tvdXE=; b=s7oJj5QKkGNR3lYfa
 rstG+0zg47VimcSyatQNgIqGJ1v4IDnV4q2NIMXbGR75CP+4W2ckRljvIGtSCNA+
 RIw40WIYFPnWCYzdZzvC1CvSiAqaKBQSvKE2h+rp1FD5Tf74kLrLaGwcFRcsWWVU
 LW9pH7rJGGl0rvNg+hidjhI1gUpOmllqC23avoPsLNYD61lUX7a4ZFljBh9vA4lH
 9CQBqML7Wj0ji4uA6nzjLFTASWAfq+3qb87piRxwxVac8puGmv4L1XtOxw0RpfXc
 /+bAtZSLinllmN4cke7VNPozMWTFenfrzG3ByLTmmBBHShm+FvQLxSdDRzmdcoo7
 9r9jA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625651; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:mrDatJKylUNl6CuMP9RQfx/fIsOcrxnNANWh54wRyawlJwB
 mbRiBFjlm/7AtuCQrvgWtYXtyxEm2YPPJyk7EnRswlwrl56Wdw3psk7lzG87PP4S
 b+IAXtmV4RvtrpLUrYvlHPSP5Qong9M8vRQlehX4qPU662c6Z2bgSBV4hw65RQSK
 xzVPJC/MEKyj1WxkL6RBcFMxB7qH9kuLhZ2g9ojiavUAY1sYlZo4U5YZA9QveVt+
 RV5z0EHs89KV4dt6b2vWCt38yKYu0QxSZ8DRMbuIvwbTmGhrZ7XJWb/6dgOkMT1q
 in4la+VkleUPZk0xAZvIb8nmOgKsCdH2XU12khQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:GR+FQ9QfYSuTAIX+WYK94sMVTH4D8jXcgGVyPObQ4zc=:szEQstKcQGiJ1bHOpV/Z9LVgnrgA9VvL+XidX6bQEoA=;
X-ME-Sender: <xms:c9D3aj-vACGB5qEwm1N4ZEjsCubsIhoEOfpYNDFEDLgMVJhTUjAouA>
 <xme:c9D3av5TJpi7B-BQ17hwkZjgiQ9TNYRL95H2-n_O_PG7L0DHNOml2Zt1NSQD9be6y
 hKETV9b2hxv6idFsdR7MlCl-fnrB0PBLfNm2swT4Vmvr03RKndWiUZ4>
X-ME-Received: <xmr:c9D3ajpc0z19B5fyBT7RQszhIbzhkmDMe0IL6bm1-dR5WYolXqLzNw92fQ9sbce3xRUOQWE7>
X-ME-Proxy-Cause: dmFkZTEGMxOoH3y/fMppx2r36gm4cx9GYI3ohK01ZShvs6zT+8h1mVWufLahBuei4Ed1/3
 xRbUYha+QR045BDD8FCRFVIM91rSGwUQ7zMnQH1Bkat2KqUfUo8S4YHSEorvk8zLj3SaDW
 2cnjQVg1N4cjgYIFaRpoqGeOaFHkoldyad78tsE+DecFb61BS2EtavEyFF5qPgk+LGIze3
 1pj9uE4MqQ3E6Y1sY03sy7yic0nfNy3N91ax17Z8mzLg+z2lmCVcb4QExTOBMVx/MohP3G
 wnkdi+msWCJW4WkcwQvXo9jRKjLop8wk5fKsg/aLeHj4SFgb7u29HtVGx3Iv5RN6/FH7P2
 e2OaL9s1jJLCsKcbvi+TalJtVob/JDEPXrV2jNNNf37iNU3/iihbQinSX7DZplSM980E3e
 2/oWKrqTAK0RuNllfmGC+fNc199CAl9/c+c4df1FW9exQwDPknHpQLAUszQ7euUugmBfFW
 Un2wsi3dXTAbFc6ZVaJ7WioAdnpXaBvU9keNDOsLWeXopdFGRVubGI2qW6Quluf77ztBQi
 YKgj3X/+6eYy1/MEhpPn+jHgL7MbrFioS6Tn6h04xHB8x08DRLb76+EAsqSnLxyHNxZBOd
 td6B0xezflbvF0Q0Nauj1358gZEHfjmZ8UCHIpvs+MKRwCzfsv8sh4XBDxvA
X-ME-Proxy: <xmx:c9D3arBX0t9CPG0BNyxjvNbE6KRbH8ZTPrOXk7DH-DyAOXuUSl37YA>
 <xmx:c9D3asNqeZLLRlAZ0BQMlx0ninCtHJBktzln3e0gx2gu_KssUAmWyA>
 <xmx:c9D3aqkpLJvM-mr15HA6hmxZqoCXx9d8QDj6QOF-N7L7ttzIgcbCjw>
 <xmx:c9D3aufeo_HeQA8oXUz7WyqoZSThZlSO0lwQmVt0yuN4TUsMUO6pkw>
 <xmx:c9D3aszvUgG4ePbqVeHhCE0laN8Yaf-wO692xN2so6wDplh3lA0NU2k4>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:07:23 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 10/12] accel/rocket: add a GET_PARAM ioctl for the
 hardware version
Date: Sat, 14 Nov 2026 16:05:27 +1300
Message-ID: <bd963b70e40af3c3c74ac1569cda7be885b0ada1.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
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

Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can query the NPU
hardware version and pick the matching hardware description, such as the
SRAM configuration and the register layout.

Add DRM_ROCKET_PARAM_HW_VERSION, which returns a hardware version enum
that matches the device tree compatible.

The enum starts at 1 and 0 is not used:

  RK3588: 1
  RK3576: 2

An unknown parameter or a non-zero reserved field returns -EINVAL.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.h |  1 +
 drivers/accel/rocket/rocket_drv.c  | 29 ++++++++++++++++++++++
 include/uapi/drm/rocket_accel.h    | 40 ++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index ef7043046bc6..50c8b05bd394 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -41,6 +41,7 @@ struct rocket_soc_data {
 	unsigned int num_clks;
 	unsigned int num_resets;
 	bool task_con_16bit;
+	u32 hw_version;
 };
 
 struct rocket_core {
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index fff31c1ebe52..c094f6843095 100644
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
@@ -129,6 +130,31 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
 	module_put(THIS_MODULE);
 }
 
+static int
+rocket_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct rocket_device *rdev = to_rocket_device(dev);
+	struct drm_rocket_get_param *args = data;
+	const struct rocket_soc_data *soc;
+
+	if (args->reserved != 0) {
+		drm_dbg(dev, "Reserved field in drm_rocket_get_param struct should be 0.\n");
+		return -EINVAL;
+	}
+
+	soc = READ_ONCE(rdev->cores[0].soc);
+	if (!soc)
+		return -ENODEV;
+
+	switch (args->param) {
+	case DRM_ROCKET_PARAM_HW_VERSION:
+		args->value = soc->hw_version;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 #define ROCKET_IOCTL(n, func) \
 	DRM_IOCTL_DEF_DRV(ROCKET_##n, rocket_ioctl_##func, 0)
@@ -137,6 +163,7 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	ROCKET_IOCTL(SUBMIT, submit),
 	ROCKET_IOCTL(PREP_BO, prep_bo),
 	ROCKET_IOCTL(FINI_BO, fini_bo),
+	ROCKET_IOCTL(GET_PARAM, get_param),
 };
 
 DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
@@ -227,12 +254,14 @@ static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
 	.task_con_16bit = false,
+	.hw_version = DRM_ROCKET_HW_RK3588,
 };
 
 static const struct rocket_soc_data rk3576_soc_data = {
 	.num_clks = 6,
 	.num_resets = 1,
 	.task_con_16bit = true,
+	.hw_version = DRM_ROCKET_HW_RK3576,
 };
 
 const struct of_device_id rocket_dt_match[] = {
diff --git a/include/uapi/drm/rocket_accel.h b/include/uapi/drm/rocket_accel.h
index d0685e372b79..597bf892c96d 100644
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
@@ -185,6 +187,44 @@ struct drm_rocket_submit {
 	__u64 reserved;
 };
 
+/**
+ * enum drm_rocket_param - parameters for DRM_IOCTL_ROCKET_GET_PARAM
+ * @DRM_ROCKET_PARAM_HW_VERSION: an enum drm_rocket_hw_version value.
+ */
+enum drm_rocket_param {
+	DRM_ROCKET_PARAM_HW_VERSION = 0,
+};
+
+/**
+ * enum drm_rocket_hw_version - the NPU, one value per DT compatible
+ * @DRM_ROCKET_HW_RK3588: "rockchip,rk3588-rknn-core"
+ * @DRM_ROCKET_HW_RK3576: "rockchip,rk3576-rknn-core"
+ */
+enum drm_rocket_hw_version {
+	DRM_ROCKET_HW_RK3588 = 1,
+	DRM_ROCKET_HW_RK3576 = 2,
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

