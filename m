Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC8606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USA++iVm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FE7112049;
	Wed, 18 Nov 2026 21:46:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CA5112051
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F3BA63EF6;
 Wed, 18 Nov 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795038373;
 b=Crl3x4yV9K7Bo8go0ZfcXFlHr95VOAGQyCc5puae5/f/mbmKTHnfUPTxXAsOzLUDHcv6
 x4OpyBsm1G6H5SU1u3PQItauQOZVbDkYpyqvaT8yTKRU8/gcRWpE8ethJMMbg3n3M5hoO
 dcO90LN8fIWV9qRhPzkQ273JRxLgOqrxonvIZDTq4IXBCQNJPBSahx0A5bui5WjW3/cbN
 NWMgtoQI/2sqYBHzUj4HWHHThOYm8GNBsIZj+9D3EPlVUderRaxWTvTg8SLpJB1RcXeSg
 /cUyxafyIQ4U/E3dl/HFIefxGDop2aP10HAloR8ev1VINjyoSYk/mtzxXdvsSJcKXsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795038373;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Ub5FGgymBIHQ/4R5fQ4sm6HAhxGJYj6EuFKbouwlUbU=;
 b=nGGxKkZmi53bb29v3XH5I/iPVvDjoGAE2SiYTqyBqmn+TJvckGK0zLg66+ZPVhyT9vgw
 mKbbjBPEDeViT82TvOkiMASUGVXQQNwDjvAO7cLV6Rgj+Z3W6ev7sEDL4QWlE6cC3Wgwc
 b0t9F6rNzNvB29MwY+ynCb/qO0T7CGKGr+LOQ4WP6KKT3qP/AZiIn65GcbYKPYeIBkeyK
 vfUJd0xomYFDAtwhjSej1+eAZTm6d81eHHTHYBe/vLLHrghRywjItBt6iKYecV6rKabEm
 20QDWVPGUYBVMt+/4ARFfdYv+TvGNCEd/f6IcBFZHCWBVRMRX0gA9Bxe7fgQbg63+ow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0823F1F000C6;
 Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795038373;
 bh=Ub5FGgymBIHQ/4R5fQ4sm6HAhxGJYj6EuFKbouwlUbU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=USA++iVmokDbfAysQ5onjaOXhvCS9xdjcVh2JBM0M/6CgfrW6KFy+IAF1UFRvljJ5
 mDCCKqVDQYUatAHIojwDqHlhALn+ASBE8Ty+RN80ru2vx+/n/HlT2zYcYeYEVqH8Tp
 2sl6oAPtsUyZvmjzJ++Nz4z6dShsVaFdsAnLCmvGl3E+NNfQ1NTN2lZxs3IMWd1kcy
 E3/S1XcPFdZbMpEnoH3rcUWGoa05Ek9j0kpBffdTrHev/SNHyB+2nu+DuBWuSQcMAV
 ZFfRvSxl+crNrniMFslZxIg6qYTNIK56CW2f/AlQ8pMMZrrraRecgQkSUavf3a0zs+
 7Y16MbBeM2BjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8CCCC4AFD1;
 Wed, 18 Nov 2026 21:46:11 +0000 (UTC)
From: Joachim Eastwood via B4 Relay
 <devnull+joachim.eastwood.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 22:45:29 +0100
Subject: [PATCH 2/4] drm/bridge: synopsys: dw-hdmi-qp: Attach the next
 bridge in the chain
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-dw-hdmi-qp-bridge_attach-v1-2-e370920bc7f3@gmail.com>
References: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
In-Reply-To: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Joachim Eastwood <joachim.eastwood@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038370; l=2517;
 i=joachim.eastwood@gmail.com; s=20260701; h=from:subject:message-id;
 bh=1lj8+1BKN4Nmy9uS7g9V3h/v7ntQIcakt96ADfZAy+E=;
 b=qq32ej2OwuLI/6OrZU8KxRARx2vkpz9KS9rNSkIXUhwn2XNIS7+VOH1ZX6Rl+Vc7M/OvdOdHH
 E5qFVxvmA1HCsi5jMmSESIPXKvWfeo2N8U7fvzw7LjmNPZ7lQWSvd9k
X-Developer-Key: i=joachim.eastwood@gmail.com; a=ed25519;
 pk=ZN/8xWtdYaSd5oEfloYSZ1a+/ri0n0VZqjlEeHlbXFU=
X-Endpoint-Received: by B4 Relay for joachim.eastwood@gmail.com/20260701
 with auth_id=846
X-Original-From: Joachim Eastwood <joachim.eastwood@gmail.com>
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
Reply-To: joachim.eastwood@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joachim Eastwood <joachim.eastwood@gmail.com>

Implement the drm_bridge_funcs attach function so dw-hdmi-qp will attach
to the next bridge in the chain. This will allow the properties on the
next bridge be used. In the case of hdmi-connector this will make
properties like ddc-i2c-bus and hpd-gpios can override the on-chip
functions in dw-hdmi-qp.

Signed-off-by: Joachim Eastwood <joachim.eastwood@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index eed249aca1e23..200229e5d9afc 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 
 #include <drm/bridge/dw_hdmi_qp.h>
 #include <drm/display/drm_hdmi_helper.h>
@@ -39,6 +40,9 @@
 #define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
+/* OF graph port carrying the output towards the HDMI connector */
+#define DW_HDMI_QP_OUTPUT_PORT	1
+
 struct dw_hdmi_qp_i2c {
 	struct i2c_adapter	adap;
 
@@ -1024,7 +1028,33 @@ static void dw_hdmi_qp_bridge_hpd_disable(struct drm_bridge *bridge)
 		hdmi->phy.ops->disable_hpd(hdmi, hdmi->phy.data);
 }
 
+static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
+				    struct drm_encoder *encoder,
+				    enum drm_bridge_attach_flags flags)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+	struct device_node *remote __free(device_node) =
+		of_graph_get_remote_node(hdmi->dev->of_node,
+					 DW_HDMI_QP_OUTPUT_PORT, -1);
+
+	/*
+	 * The HDMI connector node is optional. When present, chain its bridge
+	 * so that properties such as ddc-i2c-bus, hpd-gpios and supplies are
+	 * honoured by the DRM bridge connector.
+	 */
+	if (!remote)
+		return 0;
+
+	struct drm_bridge *next_bridge __free(drm_bridge_put) =
+		of_drm_find_and_get_bridge(remote);
+	if (!next_bridge)
+		return -EPROBE_DEFER;
+
+	return drm_bridge_attach(encoder, next_bridge, bridge, flags);
+}
+
 static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
+	.attach = dw_hdmi_qp_bridge_attach,
 	.atomic_get_output_bus_fmts = drm_atomic_helper_bridge_get_hdmi_output_bus_fmts,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,

-- 
2.56.0


