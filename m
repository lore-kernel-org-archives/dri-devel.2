Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0C4CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C9710EBF7;
	Wed, 10 Jun 2026 21:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DU9wx6Pr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dJyH4no5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D51410EBF7
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYTUr2472905
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0WiNIoHn0tPoQszF7OPT5fMxwm/uPz62m9J+Xlh/PCo=; b=DU9wx6PrSxuJQAFd
 Pwdq5CLTdkcy0tq710HkqJYRm8Wz3WwuffLj0Vm0us6+NAe7QI4JkCIn7g77rU5+
 s/Iw4Bz95Qa/bziW0P7ucKr1+/hk/ndRIdzIleU//wWu/c7WT2XnvzTm2hqHeFIr
 99GyIrxPYyhpLwKMEOKa95kWVmrC5yGeSrVsbJ83q24ciFrNo+iYFJqB+PC67F17
 NxrloUr5uqGnxqECOoNi8GdRXfeccE1WsAt4GDecRf9c5PK/+2xNh3prfeMz0owW
 wl5BQiiqBkAz28Wk5bQYge/eO/2OnK+PXLvelOHTsy7QIDOZUJSDJo0GTXwoPC+y
 i0PCRw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v8bma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d99629fd6so11666518a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781126127; x=1781730927;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0WiNIoHn0tPoQszF7OPT5fMxwm/uPz62m9J+Xlh/PCo=;
 b=dJyH4no5qFXn32ovNF6wISsTSomR1QpQd/X7p+2mpEiv2W0hKa/h8+OhcSZzx6qTrc
 SvIHZ1JtFgeHEZoBcv4wefw6beqCqD1Mb436a9rpBnOXqgXgCeAGYh7o/hh9aoCFDXC7
 wGJY/g/HZVo5EoOjgUQ3yCW+SmFP4URh28KfR/VQYDKE2wlLzhUszyOLeEVvwE3FTYa5
 X3AFZHS3oLbEeicksnbzc1fV6Re6khMtCFWYlYO7Jyi2M04BA/9RIYCay/PyEAM4QPp5
 4Wsr7F5xlmz2moQSp/iJBGFOj2iUUhkheg8tVacHsAlbp2GGGrP0+12hW5yGh7zIXBHM
 wq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126127; x=1781730927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0WiNIoHn0tPoQszF7OPT5fMxwm/uPz62m9J+Xlh/PCo=;
 b=pw9mC1RX28vXMmrSOsJrUuPsC6T5D2tOREMFS/BMKBTYtyja6sO3gK7zTKhLzkRXfC
 N2riQsww+GD17r6BLwWKNVVMqH//jEkHgUCzR0YfpQPSDU3m2ZgI4z45NUaxfgN6oRvQ
 R1sR8GLJBFxD5X8QFOhkXBsvbCmNITgu5+X25H3Ogd1SdlDrvuzcidmMeXuhi2CIpyKz
 0n2UzAYarp56bOfQrLuuEUYqsy91hFzvEr3JZbW6KCm2tOf+wfUFxFj85sM03tDa9iOj
 88wU6HA4MpwYuicJi2sOF1RyVRzNphjwpKWY6vKaQuCN2n6KKBcj9RyIAzcNxtI5sxkz
 pltg==
X-Gm-Message-State: AOJu0YyEZ3OjWd+HgUxw9P7dxTlPmmW+cMHSelYRhstl1Md/vIlaiZQW
 Q535DIu19rT7Kn8eUKGmMy0uT5cDnQ4d5E3/6345Xl6vkcWeJtOseVk8r/clm4Zxip5ebEbW152
 VtyjvmZkUZQ6iIbKC+fUxS1QIh7LOYxBkPZt0TDWYkng/4nLVYKgVmrLsieK1r8EsnEu++sU=
X-Gm-Gg: Acq92OEzfthor7LP7Rc4mW9QKClvPmuHkwfLlF19asHe9yU0/zMYbKgO3fFmfmblLWa
 5o4x7zL4aaTmUc3OxRCHG7D8p42NyESxoOyrvOm6PSxiLLX72HC5QnZm63FwAtJOB9ftqbiGfa5
 Qpn6UanmBHWRClG+ts/5ncH9ElFsDF7so1bdmLB2FMC7dfqrTO0AmVMNuvU+s6IekNq+sF1o+oc
 zXsSJKGeJwcXxPoPLGFiRew2cUXWxXNfCg1Q6CmUQVkVR2ee5E/vvbNLRIcFMTgs4/mX+xfpg8+
 tEXpoWx5Yts+9h/lJjD9L/L2Qc8jmfnCkVP5SyvGxSxz9ba7NWG/iPbbC9c9ibzoUfdIR46/P0e
 hkXXsHHFL6jkLbYDQCDFX+WkfKBPEx3WUi8ZxYYcCxkQDAKkXEBA51V5M/g==
X-Received: by 2002:a17:90b:4c41:b0:36d:b12f:613c with SMTP id
 98e67ed59e1d1-37746e0873fmr847486a91.10.1781126126621; 
 Wed, 10 Jun 2026 14:15:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4c41:b0:36d:b12f:613c with SMTP id
 98e67ed59e1d1-37746e0873fmr847448a91.10.1781126126014; 
 Wed, 10 Jun 2026 14:15:26 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37753d01cc6sm309490a91.11.2026.06.10.14.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:15:25 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 02:44:58 +0530
Subject: [PATCH 3/4] drm-bridge: lontium lt9611c: fixes and improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-lt9611-b4-send-v1-3-42abbcd3bb1e@oss.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
In-Reply-To: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 boss@oss.qualcomm.com, qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: agMSssRsch9tJiDGyJAoVxxe1W8dQlMi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfXxL4BFdg7mKpP
 kBGAyG4/6nXbbSJtH3mwEw8Iovsx1h1A1v9lwf8EdmDKSy0ZZAAzvLVsVMrSXlSkU4ZY3oCQT/F
 0lndPqcGMNZ7qCCsWYzKTSiWLYBnKiI=
X-Proofpoint-GUID: agMSssRsch9tJiDGyJAoVxxe1W8dQlMi
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a29d3ef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wg3Ek5SRs51OoikjvKEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX9aawSqsTTo8k
 N+CaLCOfWHsjlAEFTkKF5t0CL0F1EH+zCQ8C7sIoSeF28bY7m2fOC4dCi0v6BXD3mpHgRkPBeKv
 XOip9nCRVhMu7FbK1RD/c4/CPChXYIbtMpK9x7AinAgYZej9i4lVUM4T2hXlgNaQQum9NabhSLr
 BuYOA+4WGdziE/jXDmMeG6qfsDQGrk1vbliMKCE9eBd29j/HNiJzvm7jweTN8b6zv6NyWmRVU0Z
 S4CcRzFgpxhD+nvW6dtFfOE/tK4GNKvHGMzsZrbWBQAib85j0fC/Xrofz/bDZxH6epNMBlzXmU9
 Mo8h/9N2dG7vb51FX3Dc9+opbU21dH6+0paf54ZCgfKSxbu0MnTUSi/Cau7EXV/VdswBNTm/gue
 +lPipadUNH3eo2JtaJpZdd1We7OO7Gek/Mqfwe5sewnf9eDqUbStp1OPTmGoWoASgRWhbJtxRMt
 sZcYWpSEXRvT4BAlCjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100204
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Remove two redundant lt9611c_reset() calls:

1. In lt9611c_bridge_atomic_pre_enable(): a reset is already performed
   during probe and resume; calling it again on every display enable
   adds ~440ms of unnecessary latency.

2. At the end of lt9611c_probe(): a reset was already performed earlier
   in probe before lt9611c_lock(). The second reset is redundant.

Also, the DRM HDMI bridge framework requires hdmi_write_hdmi_infoframe and
hdmi_clear_hdmi_infoframe callbacks for HDMI vendor-specific infoframe
(VSI) support, used for features such as HDR metadata signalling.

This patch add stub implementations that return success. Wire them into the bridge
function table.

Also, Store the chip variant enum value in the of_match_table .data field and
retrieve it via of_device_get_match_data() when probing from a DT node.
Fall back to i2c_device_id.driver_data for non-DT (e.g. ACPI) probe
paths.

This is the standard kernel pattern for passing per-compatible data
through the OF match table, and avoids relying solely on the I2C device
ID table for chip type detection when DT is available.

Populate bridge.vendor and bridge.product so the DRM HDMI framework can
report the correct manufacturer and product name in the HDMI connector
properties (visible via xrandr --prop and related sysfs entries).

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index b0402726367e..fe51f4978546 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -622,7 +622,6 @@ static void lt9611c_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
 	if (ret)
 		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
-	lt9611c_reset(lt9611c);
 }
 
 static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -777,6 +776,17 @@ static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
+static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
+					     const u8 *buffer, size_t len)
+{
+	return 0;
+}
+
+static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
+{
+	return 0;
+}
+
 static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
 					      const u8 *buffer, size_t len)
 {
@@ -895,6 +905,8 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
 	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
 	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
 	.hdmi_clear_avi_infoframe = lt9611c_hdmi_clear_avi_infoframe,
+	.hdmi_write_hdmi_infoframe = lt9611c_hdmi_write_hdmi_infoframe,
+	.hdmi_clear_hdmi_infoframe = lt9611c_hdmi_clear_hdmi_infoframe,
 	.hdmi_write_audio_infoframe = lt9611c_hdmi_write_audio_infoframe,
 	.hdmi_clear_audio_infoframe = lt9611c_hdmi_clear_audio_infoframe,
 
@@ -1025,6 +1037,13 @@ static int lt9611c_probe(struct i2c_client *client)
 	lt9611c->dev = dev;
 	lt9611c->client = client;
 	lt9611c->chip_type = id->driver_data;
+
+	if (dev->of_node) {
+		lt9611c->chip_type = (uintptr_t)of_device_get_match_data(dev);
+	} else {
+		lt9611c->chip_type = id->driver_data;
+	}
+
 	ret = devm_mutex_init(dev, &lt9611c->ocm_lock);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to init mutex\n");
@@ -1111,6 +1130,9 @@ static int lt9611c_probe(struct i2c_client *client)
 			DRM_BRIDGE_OP_HDMI_AUDIO;
 	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
+	lt9611c->bridge.vendor = "Lontium";
+	lt9611c->bridge.product = "LT9611C";
+
 	lt9611c->bridge.hdmi_audio_dev = dev;
 	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
 	lt9611c->bridge.hdmi_audio_dai_port = 2;
@@ -1136,7 +1158,6 @@ static int lt9611c_probe(struct i2c_client *client)
 	lt9611c->hdmi_connected = false;
 	i2c_set_clientdata(client, lt9611c);
 	enable_irq(client->irq);
-	lt9611c_reset(lt9611c);
 
 	return 0;
 
@@ -1214,9 +1235,9 @@ static struct i2c_device_id lt9611c_id[] = {
 };
 
 static const struct of_device_id lt9611c_match_table[] = {
-	{ .compatible = "lontium,lt9611c" },
-	{ .compatible = "lontium,lt9611ex" },
-	{ .compatible = "lontium,lt9611uxd" },
+	{ .compatible = "lontium,lt9611c",   .data = (void *)CHIP_LT9611C   },
+	{ .compatible = "lontium,lt9611ex",  .data = (void *)CHIP_LT9611EX  },
+	{ .compatible = "lontium,lt9611uxd", .data = (void *)CHIP_LT9611UXD },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lt9611c_match_table);

-- 
2.34.1

