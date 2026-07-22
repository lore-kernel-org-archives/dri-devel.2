Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E41C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D9310EDB9;
	Wed, 22 Jul 2026 12:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KjS+i/uA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZ8FK+2w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEB910E2CF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:42:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xLm7412301
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TNCbQBLNUlZS9iHiAbrge6
 eIanHbXlLkcTm3G7asg0o=; b=KjS+i/uAW7xlrH/PYdZ7NIOkYUSVMcvySoLXd6
 QbhZ//KIoVVluOzUoQu8BTp72O99iSBMtonk+6GPj6YLSt24/D9woGoDt2ZxzoSI
 9Cxx6qr5uV2tf/Afq+Kj/b5PsXa64LmYcjlDD39nEpb2uz9P3xSgDJCiFfvoBVLd
 hOnckF4djOiOuJ2SB/vnDMEgoOC3z083MMXGk3Hax9m+oFwCV0GNkTcqlZMizvxO
 +sZAItVOkz1nbgaqgyNwUnW/HbzzKVzErx7tY6z0sAzedBmonl/VyA6Q5nQJiPO7
 qVAbS6OYxC+y9qEHIRiAfeE1cZq2Y9haGp4c8ciioRMOXJlw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdhvn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:42:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e6cb57d25so252844185a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784724161; x=1785328961;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TNCbQBLNUlZS9iHiAbrge6eIanHbXlLkcTm3G7asg0o=;
 b=UZ8FK+2wwI4hdWh/jhVqPYzzrAFhuuecDszB/GoDZE0vwnyqDW6WZgDxM2/+2kR/gn
 o4kbxggyI33G4lAQsGINt1B0Xsa55q3aq/PlOVnr6SbfjJrxlgwTRWtWvOtwvS3JClcB
 UOVk97mMAJNEhGlWPgZHDf5QLLxnQtqAy080nwFJ3YR37Tjx8KmjJ3jiCN4Oys7xLi6J
 iiwraIXFcJfbmx1lqRAgGNuXMxeNMpAc5j3heSDQISBWg2fxsVM4AWPc65rpxC1hSLPk
 +Taw3XUwcOoz0uHJfOUtMQm378SrAm4k0+iLH1Cq2URPNfktYrSJ6w1my84SKBhQCRzp
 e8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784724161; x=1785328961;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TNCbQBLNUlZS9iHiAbrge6eIanHbXlLkcTm3G7asg0o=;
 b=TyPMaU5Pbf15e5uXg3ipoJXHOAUjafqjUvPdgE5wuRYlmQd4qsDbDqwGqk7LjwYUJy
 WiDYPuDev6iNtNHXr0pckyi2htkuWAm04WilmdUo+w0GhbXbH54D27lydkcxVn24wuKV
 4XCr1Jms6IbPGH25yrHIeMAoZ8TzUBKoBy9vqQNgxleGtkCxzJhrCCOXGpGw2tr7zibV
 BVlff7lTn8zJqiQe+HaFlFgYypC7PxEpdnunNi+a7dYOCkgGSRa053emGL6HzH35V3CA
 YEYPtMZRMQWFrtNCpE118+vDOY41XrliPCfvjmnF3vgXSsVhDYnJFr0Q120ZkKvF4tqL
 SYRQ==
X-Gm-Message-State: AOJu0YwXhs/9xzJ2uI0KbHwZu/c0eLEq2ln/SI9wIkUEvMZ4SVTmuub4
 5wiRXdcIv3jQM1C/sVVUAjO9Z5b9SVDxQMghzotRA7QjSYVnxST+7ivZjqzFFeyrxTw0JZG9sM2
 hlDzPg+iM2A6s6Lgg8AK/xa5TkHZAb+WuQe/0cBK231Y3V74YjiHPelxJmyK0U2pUhxDRgpc=
X-Gm-Gg: AR+sD12ItRQPyi9vr4/5PoHXr1KeDAokkyf+OXFKdf2zQ/N6IRiweuwcPTg3JqDwVZX
 WQuJ6I1R2uoqZxJAISVTs1DIShkP+0cJDHoLYM7bhtsa3TNboBx8+Nz3nk1q126P/J5S+54cSNU
 OpfrLBxWNDJgFX8tPU/KT/uGZU0JIK6eQzitQZLnoYy4FzQ23fFKrZgAKVHn3DCk8QUP5gCOM80
 kQJmZlnRZvGqPGLhgPzZDKZBNEqi/C1XoAed95IUDjBekKAyMjVi7uJXuTxcoZ06iQ5Pvo8BfPK
 mg0ZfeFP7oEmeF3CVqI7QgjO4lMtrtnWED6sE4NNlzvdK99B2lN6BRxz5JR1PF7MXY5wbSV5oZ7
 0XNKMiB2CfWgvXIwZgal3yRQ19v6JlNs/k6uAxz+BUR8AXhq8pZ7mMDkJORdaKIX1JnQ9Jd929M
 GQhOEXLws73rDYn1udmSDs
X-Received: by 2002:a05:622a:841b:10b0:51a:8c9c:7de1 with SMTP id
 d75a77b69052e-526756d33d1mr44304661cf.11.1784724161203; 
 Wed, 22 Jul 2026 05:42:41 -0700 (PDT)
X-Received: by 2002:a05:622a:841b:10b0:51a:8c9c:7de1 with SMTP id
 d75a77b69052e-526756d33d1mr44304331cf.11.1784724160666; 
 Wed, 22 Jul 2026 05:42:40 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d2e7662bsm14161961cf.18.2026.07.22.05.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:42:40 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Wed, 22 Jul 2026 18:12:31 +0530
Subject: [PATCH v3] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALa6YGoC/43NwQ6CMAyA4VchOzuyFTbAk+9hDIGtyBJgymDBE
 N7dwcWLMV6a/j18XYnD0aAj52glI3rjjB1CJKeIqLYa7kiNDk2AgWSCZ7SbCsn57FSJ2ugkLXs
 T9gGXidYMRAEaWQ2CBOAxYmOWA7/eQrfGTXZ8Hb88369/sZ5TTgVCo3Mlk6KoL9a5+DlXnbJ9H
 4dBdt3DR5SQ/hQhiJAqTBqRZazOv4jbtr0BPjToeR0BAAA=
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
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Ravi Agola <raviagol@qti.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784724153; l=5762;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=eh9qEtAzPAIBVXCRjxt6ILoJN1DJyrhboPX0nP3Zhao=;
 b=3UgSXe34Qb6lqaq7H8nSL5kB/GY7ftQ/BG0uxxrYCDqaVDthnct7l8jJ5d7qe6Ox0AXvWA8b7
 R2Xc4jwj/ujBJ6Npi8GjV/0aE2EVMOSX30sjt6GFIBt8lOZQS7bHGpc
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEyNCBTYWx0ZWRfX1XC0jMg7U+7n
 djBy6mlMiw0+f6x5rop5sUaHBYFeN3CppyvsdXEcOxgysz/l3ozPOj+z/J1Iv/r2fp+IDOZQA5f
 xeOvosotDOJoLvBwwW4C9Ox4eXB4x5Z0iBIpenvssTToke29hKvBfaTHG0Pc2VD8787O4j6tnO0
 iKz7x12maWPNxFiVcQlCP1FZXHwd9P6Ck9ChAt4JF8cG+EJ4Wuhny/7gvI8boH8pr8BTz2kcFpz
 nJkZabyK7OgGWOyamn5D4e+qxn2AaPmSJxtl/Qj9Qd6fkUT1CV3P45G1GwUcZf1JunyvrVvSDr1
 U+ktLS81KmCtPcP4WZSPk54GTC8+59btYHWap3SjaecCrDPrpIVmaQCsfX4Yr1FwCK8L1L2lyPX
 Ma2uFaFIuOXftZg3ZeXMTSSIzh8+wX/F1J01jpgSbI/Tps2gmy8+OAWuiCXtXxee+3BUxQiAheQ
 jNMfLNeRg29aVnMUFeA==
X-Proofpoint-GUID: A2NOVTY7NKGTicXRptgEZg-ve2ru_08g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEyNCBTYWx0ZWRfX0uSll32F1ZIF
 kl2AQ8ev20vkI+FZcagGdhGqzHdtgW3g8LZaE9SSeQzJK8ysmjGAB6sXLmi4ffaMTLMEyYUJ4bJ
 okEpTlpQxKrMvrqK2xxnLXI1x076Ha8=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a60bac2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YtTfkkFDc2t7ANI9DR8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: A2NOVTY7NKGTicXRptgEZg-ve2ru_08g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220124
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

Add driver support to fetch up to 4 EDID blocks by re-triggering
EDID access after the first 2 blocks are read. For block 0 and 2,
set the EDID ready flag in 0xb028 so the bridge can expose the
corresponding EDID blocks, then retry the read until the expected
EDID is fetched.

Reset the edid_read flag on HPD disconnect so that the next
connect event triggers a fresh EDID fetch.

Increase EDID wait time from 500ms to 1000ms, On Qualcomm rb3gen2
platform sometimes edid read interrupt is coming 600-650 ms after
HPD interrupt resulting in edid read failure.

Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v3:
- moved edid_read state change inside mutex lock     [sashiko-bot]
- returned -ETIMEOUT when retry_cnt is exhausted without a match.    [Sashiko-bot]
- Increased edid wait timeout from 500ms to 1000ms as edid interrupt is sometimes taking around 650ms time
- Link to v2: https://lore.kernel.org/r/20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com

Changes in v2:
- Removed memcpy and doing edid fetch everytime. Required an update in firmware as well for edid block0 reset.
- Verified patch with existing firmware V5.0.21, patch is not causing any regression if V5.0.21 firmware is used.
- Firmware V5.0.22 is required with this patch to support edid fetch on more than 2 edid block monitors.
- Link to v1: https://lore.kernel.org/r/20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 80 +++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 11aab07d88df..20e3383a510a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -28,7 +28,7 @@
 #include <drm/display/drm_hdmi_audio_helper.h>
 
 #define EDID_BLOCK_SIZE	128
-#define EDID_NUM_BLOCKS	2
+#define EDID_NUM_BLOCKS	4
 
 #define FW_FILE "lt9611uxc_fw.bin"
 
@@ -168,6 +168,8 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 
 	mutex_lock(&lt9611uxc->ocm_lock);
 	connected = lt9611uxc->hdmi_connected;
+	if (!connected)
+		lt9611uxc->edid_read = false;
 	mutex_unlock(&lt9611uxc->ocm_lock);
 
 	drm_bridge_hpd_notify(&lt9611uxc->bridge,
@@ -381,13 +383,39 @@ lt9611uxc_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connect
 static int lt9611uxc_wait_for_edid(struct lt9611uxc *lt9611uxc)
 {
 	return wait_event_interruptible_timeout(lt9611uxc->wq, lt9611uxc->edid_read,
-			msecs_to_jiffies(500));
+			msecs_to_jiffies(1000));
+}
+
+static int lt9611uxc_read_edid_block(struct lt9611uxc *lt9611uxc, unsigned int block,
+				     u8 *buf,  size_t len)
+{
+	int ret;
+
+	lt9611uxc_lock(lt9611uxc);
+
+	regmap_write(lt9611uxc->regmap, 0xb00a, (block % 2) * EDID_BLOCK_SIZE);
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
 }
 
 static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct lt9611uxc *lt9611uxc = data;
-	int ret;
+	int ret = 0;
+	int retry_cnt = 10;
+	unsigned int edid_ready_flag = 0;
+	bool header_matched;
+	bool edid_valid = false;
+	const u8 edid_header[8] = { 0x00, 0xFF, 0xFF, 0xFF,
+				    0xFF, 0xFF, 0xFF, 0x00 };
 
 	if (len > EDID_BLOCK_SIZE)
 		return -EINVAL;
@@ -395,20 +423,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
 	if (block >= EDID_NUM_BLOCKS)
 		return -EINVAL;
 
-	lt9611uxc_lock(lt9611uxc);
+	if (block == 0 || block == 2) {
 
-	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
+		lt9611uxc_lock(lt9611uxc);
 
-	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
+		edid_ready_flag = (block == 0) ? BIT(0) : BIT(1);
 
-	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
-	if (ret)
-		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
+		/*
+		 * Set the EDID ready flag so that lt9611uxc can fetch correct EDID block
+		 */
+		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
 
-	lt9611uxc_unlock(lt9611uxc);
+		lt9611uxc_unlock(lt9611uxc);
 
-	return 0;
-};
+		do {
+			msleep(100);
+			ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
+			if (ret)
+				break;
+			/*
+			 * Compare first 8 bytes of EDID header for block 0 and block 2
+			 * to confirm EDID read successfully
+			 */
+			header_matched = (memcmp(edid_header, buf, 8) == 0);
+			edid_valid = (block == 0 && header_matched) ||
+				     (block == 2 && !header_matched);
+			if (edid_valid)
+				break;
+
+		} while (retry_cnt-- > 0);
+
+		if (!ret && !edid_valid)
+			ret = -ETIMEDOUT;
+	} else {
+		ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
+
+		lt9611uxc_lock(lt9611uxc);
+		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
+		lt9611uxc_unlock(lt9611uxc);
+	}
+
+	return ret;
+}
 
 static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *bridge,
 							 struct drm_connector *connector)

---
base-commit: 4c26e162947f91aa78ba57dd4fddd38fc80e7d60
change-id: 20260517-lt9611usc_edid34_misc_next-b02592de0b25

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

