Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F159CD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEF510E29F;
	Sun, 17 May 2026 18:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TuxZwDbN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrzsX/M6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819FE10E29F
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:15:26 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64H4UNdm784662
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VkAux7c99nCmiCstfqghQP
 2WfhLSd2R/WBDymk4hXZY=; b=TuxZwDbNIggtPHJPn6YN53KGVKM44J77MGRI9A
 N7ZOONWOuX+thiIhSM52Ie+o93HxTUJQ0QBN1NzG/kd9N2Tm2kWOJi0834nh1A3f
 gj+Xfjgv1sbvQOh5w3mtbbOvxWkVfJxqbkCktW8lg4d/r60ta/9w7Zjm0BboZGrp
 tU9ULCNV8iVNY29Vuomp82x6uDASbNELEKb6ko8qpEI8acRjC/6JZne3b9CY8obP
 zbxtaWDtn6qiUx1c+E32qu4UUYMlSBPkg1PEKotI4RGNtv5MgJv7EMW01nUJQWeU
 Rn8zWqiaoMtyMI0jKyx674BDQk9QS81Mjlu6+N+KnIj8qW5Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hbcb9kr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:15:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-366037cd67aso475357a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779041725; x=1779646525;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VkAux7c99nCmiCstfqghQP2WfhLSd2R/WBDymk4hXZY=;
 b=NrzsX/M6gL4JVUoFeQpI8n1o1caFO5F6wsbKUhS5m1IErcafgIOZV2H7ZKup3QwmSY
 kwALhBJIYF/7K7isoFNT29TJYmc562DhMZRs6DwA1dO3vhdHNB2trl1jSLmtc51GVG4P
 1Z/8wxsv19lmg1oKQp68ijTNT04QKFJdXIGWfCZsmayzRq1d3BNwphy+xED3Si9/xhd4
 NqlO4b9B/E1C6Z3gbJRxAb/UxIL9QuIaI3jV1OzDvUnJIVxGoo6GJUUkyotxHk7sxHL4
 BD8BbTX38X3zrQtyQzg73BlGsSYx8B26JRpnbo27fHQeANtgJCUmUAUbzVGtHe2rntzN
 boKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779041725; x=1779646525;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkAux7c99nCmiCstfqghQP2WfhLSd2R/WBDymk4hXZY=;
 b=bE1CGdKFGnY4bJ2PtcQ7YgYXl76xPHgC0A65KQFbuqusjWBiM+l2uNXPChQcZggz6D
 m3oM0i5ig6I9v0Pu54zGWQnk+MziJgafdrB+2+QINnDI7ny4P4DfhdqzZuD0QoBRG7Z5
 fx45fnW1ag4USrP6/YGNnOLKc2ZX6Vvj80LrXK2mjYTZC7dmYF2a/gc+lTApyKc1NRsk
 Euo3f6C6IXiyTFFO1p0fwpC96pYwdM9qZTECY1Ae0vbejO+TtN1Anbuyaqm9gzHbnyC4
 N2lrH+3XJ+I7hbwGmPTCzCVAc5oWHU8DlzFgTrP6JelWqq2VEaTy43rw9ocWfBJKKIh7
 l25A==
X-Gm-Message-State: AOJu0Yz9NLTxm/OqnrwaY/hWdIpHGUTcBj5Sy14bGtqCnUM9lAnKjnW+
 yMaYK9fr0Vfk2DsGLwwm473gGVMbgM9KKllYv6Y4pO9Jl+Qw6Zj+1JpRWr99UFTZ6PmC9+3yV3l
 JcnQFpnl+EDyRADaLGxvdi3185+s+V1Cj49x1u9WLoZqA8z9ffPK24+KZYaau3gtq7N8iYSg=
X-Gm-Gg: Acq92OEvaOsjsTCzSbq160uW5sO0/3ppr/BJTotA19CMvbUwrP3WgVn53LRIOYB2P+J
 SqAAbWoTeXvKwf3bONjDV+GSTsTv/8MzosKhlCMybBH8/AHp4/jmpdka73kY5EfrYdxZZe9/JlM
 N4QsBeBCQzacr0uJTB4lGNDSm95sJhjxV3fgkrtUci024fE8NvhLg9tv7QcfI48zLg2CWdhRkfd
 /6YTmJf6I7ctV7mvWI010mWRwyDP9cfixpHqUO7pTTxic3oZUhWhlxUDPfnE1TR+Z9ofyr9DE6R
 U5/fTPgnOQVAWZ8jSzncqhniCcolzolAYbAsvqbsmHbn0HyBmGP0Wt0hdiv2rMXx3Ua8lJbl77l
 Qo+W+Q47DhoNb19XuTQfu45dCkInKq/7u8sveOthzuhAeuewj0P8xugJUkN8H7rf3uiAxE983XI
 DJEa4ufI+evaArnSU90QV9W7l/YfRnwy0H9nmNq15IXg==
X-Received: by 2002:a17:90b:2743:b0:368:65d4:486b with SMTP id
 98e67ed59e1d1-36951b8707cmr6990125a91.3.1779041725235; 
 Sun, 17 May 2026 11:15:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2743:b0:368:65d4:486b with SMTP id
 98e67ed59e1d1-36951b8707cmr6990105a91.3.1779041724767; 
 Sun, 17 May 2026 11:15:24 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a09e95esm3311021a91.9.2026.05.17.11.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 11:15:23 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Sun, 17 May 2026 23:44:49 +0530
Subject: [PATCH] drm/bridge: lt9611uxc: support displays with up to 4 EDID
 blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJgFCmoC/x3M0QpAMBSA4VfRubbaDiNeRRJ2cIrRNlLy7pa7/
 7v5H/DkmDzUyQOOLva82wiVJjAuvZ1JsIkGlFhIrUqxhqpQ6vRjR4ZNlncbx7Z0BzFI1BUakgN
 qiIPD0cT3P2/a9/0ABHFuomwAAAA=
X-Change-ID: 20260517-lt9611usc_edid34_misc_next-b02592de0b25
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com, Ravi Agola <raviagol@qti.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779041718; l=5489;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=PVnlx+qXF4KKGq77JzeXOV4FGhSmay/AfUHJ3roX32g=;
 b=b9eoNwVV6IR/WBsw+qw4BWlxlqf1byjwchgMv0zFVrMpo73ITCL9TbMNpwTVpzV5u+6VdCosT
 ckMSGmAu27vAevU+6WCbh/gLyEeMIZJdGmlSOU5YPlzAKnbitSsvjcs
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=cuSrVV4i c=1 sm=1 tr=0 ts=6a0a05bd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ptdtENT6H51gLo5mYI8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5NyBTYWx0ZWRfX0J1Jmqppbczd
 WVCnJ33fHKWuHKHjnR5XCUdhUldN2ZzmrTi6uYVj7JMyUe/pv8uiw+Uyvbylgs3i2/S7jkiju2L
 BCf1e7Sathdciw/h6lQ2OGwC0EJqIzEGTWZxSasyELOgkaUvc5vzY3MnGe96EqK/+zktMFWJYOK
 WDqMmflGskruakLpD9KVwJIt1WclAxrcGyFmf4GXX/t2WbKFWWvGhl8YU67AxXmBiAkHxlanVb9
 BYCqQ1jsp7TMyhl3xmCDD64C6rSlJs3uK23xvma/PaU6rvAcmmD5/sfrAmnh3J6B1nwNsG0EvUS
 B9t2jvaYZ8pI653EwDk6yiZ5ub9QS95EM2sum1fi1Ql0m/Bf2/Bdahnqi8gm+Aa5vDkqFqgW0VS
 1oEgonpno+yu/PHfgCiqSnHrLrp2699mJkFwh3a7so6cdj9VbJ5yx9/E6xhQUMtEoLznPAe++dU
 bcSFr3CN1o2ksNQf5iw==
X-Proofpoint-GUID: sAvgglJ5KhW2vk168KErwF81B1TN1DJO
X-Proofpoint-ORIG-GUID: sAvgglJ5KhW2vk168KErwF81B1TN1DJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170197
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

From: Ravi Agola <raviagol@qti.qualcomm.com>

The LT9611UXC bridge can fetch only 2 EDID blocks at a time, which
previously limited EDID reading to 2 blocks and prevented support
for displays exposing more than 2 EDID blocks.

Extend the driver to support up to 4 EDID blocks by re-triggering
EDID access after the first 2 blocks are read. For block 2, clear
the EDID ready flag in 0xb02a so the bridge can expose the remaining
blocks, then retry the read until the expected EDID is returned.

Also cache the full EDID blob in the driver and reuse it until the
next HPD disconnect event, so repeated EDID reads do not re-query
the bridge.

Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 84 ++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 11aab07d88df..b5a9f62b9fe3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -28,7 +28,7 @@
 #include <drm/display/drm_hdmi_audio_helper.h>
 
 #define EDID_BLOCK_SIZE	128
-#define EDID_NUM_BLOCKS	2
+#define EDID_NUM_BLOCKS	4
 
 #define FW_FILE "lt9611uxc_fw.bin"
 
@@ -61,6 +61,8 @@ struct lt9611uxc {
 	/* can be accessed from different threads, so protect this with ocm_lock */
 	bool hdmi_connected;
 	uint8_t fw_version;
+
+	const struct drm_edid *edid_data;
 };
 
 #define LT9611_PAGE_CONTROL	0xff
@@ -170,6 +172,12 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 	connected = lt9611uxc->hdmi_connected;
 	mutex_unlock(&lt9611uxc->ocm_lock);
 
+	if (!connected) {
+		lt9611uxc->edid_read = false;
+		drm_edid_free(lt9611uxc->edid_data);
+		lt9611uxc->edid_data = NULL;
+	}
+
 	drm_bridge_hpd_notify(&lt9611uxc->bridge,
 			      connected ?
 			      connector_status_connected :
@@ -384,10 +392,34 @@ static int lt9611uxc_wait_for_edid(struct lt9611uxc *lt9611uxc)
 			msecs_to_jiffies(500));
 }
 
+static int lt9611uxc_read_edid_block(struct lt9611uxc *lt9611uxc, unsigned int block,
+				     u8 *buf,  size_t len)
+{
+	int ret;
+
+	lt9611uxc_lock(lt9611uxc);
+
+	regmap_write(lt9611uxc->regmap, 0xb00a, (block%2) * EDID_BLOCK_SIZE);
+
+	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
+	if (ret) {
+		dev_err(lt9611uxc->dev, "edid block %d read failed: %d\n", block, ret);
+		lt9611uxc_unlock(lt9611uxc);
+		return -EINVAL;
+	}
+	lt9611uxc_unlock(lt9611uxc);
+
+	return ret;
+}
+
 static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct lt9611uxc *lt9611uxc = data;
-	int ret;
+	int ret = 0;
+	int retry_cnt = 10;
+	int edid_ext_block;
+	const u8 edid_header[8] = { 0x00, 0xFF, 0xFF, 0xFF,
+				    0xFF, 0xFF, 0xFF, 0x00 };
 
 	if (len > EDID_BLOCK_SIZE)
 		return -EINVAL;
@@ -395,19 +427,39 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
 	if (block >= EDID_NUM_BLOCKS)
 		return -EINVAL;
 
-	lt9611uxc_lock(lt9611uxc);
+	if (block == 2) {
+		lt9611uxc_lock(lt9611uxc);
 
-	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
+		/* Read number of block available in EDID data */
+		ret = regmap_read(lt9611uxc->regmap, 0xb02a, &edid_ext_block);
+		if (ret) {
+			dev_err(lt9611uxc->dev, "edid block read failed: %d\n", ret);
+			lt9611uxc_unlock(lt9611uxc);
+			return ret;
+		}
 
-	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
+		/* Reset EDID ready flag so that lt9611uxc can read 2nd and 3rd block */
+		regmap_write(lt9611uxc->regmap, 0xb02a, (edid_ext_block & (~BIT(3))));
 
-	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
-	if (ret)
-		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
+		lt9611uxc_unlock(lt9611uxc);
 
-	lt9611uxc_unlock(lt9611uxc);
+		msleep(100);
 
-	return 0;
+		ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
+
+		/*
+		 * Compare first 8 bytes of EDID header (0th block) and 2nd block to confirm
+		 * that 2nd EDID block data is read successfully by lt9611uxc
+		 */
+		while (!ret && 0 == memcmp(&edid_header, &buf, 8) && retry_cnt-- > 0) {
+			msleep(100);
+			ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
+		}
+	} else {
+		ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
+	}
+
+	return ret;
 };
 
 static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *bridge,
@@ -425,7 +477,17 @@ static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *brid
 		return NULL;
 	}
 
-	return drm_edid_read_custom(connector, lt9611uxc_get_edid_block, lt9611uxc);
+	/* If EDID is read once, provide same EDID data till next HPD event */
+	if (lt9611uxc->edid_data == NULL) {
+		lt9611uxc->edid_data = drm_edid_read_custom(connector, lt9611uxc_get_edid_block,
+							   lt9611uxc);
+	}
+
+	/*
+	 * Copy the EDID data and return the copied value which will be freed by DRM.
+	 * The original EDID data is cached in the driver until the next HPD event.
+	 */
+	return drm_edid_dup(lt9611uxc->edid_data);
 }
 
 static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,

---
base-commit: 4c26e162947f91aa78ba57dd4fddd38fc80e7d60
change-id: 20260517-lt9611usc_edid34_misc_next-b02592de0b25

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

