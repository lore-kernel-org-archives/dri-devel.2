Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C30CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E03F810E066;
	Wed, 24 Jun 2026 08:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtgkQjlR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GykM7mNT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D427210E066
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:40:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O7FuId2440597
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DsmXvYMEwIY+Vvn9ADapPw
 Vq30xdvUbVrk3erjYnXi8=; b=FtgkQjlRRVwtCD1FFfwYBHkIq6CBwymHjEH8oX
 IUyyADLO8GvQqZynUnEN9dO6l+D+u5nJnDqB9QLVv0fuFzrx6kx/2jIvRnIBC6ev
 r8P96KtPf5eA3dmNXXLTNk+oeWqHahNAJ1/lm94GhRd6iCKOclYReNVEc/YwUA30
 l706w+JFfcODVAQhj0KGOKvc4ywvWoK9TRXnECyKrvcvmGGxIgrmzeOzxSABBTSP
 6rdCtS/I8Vdag1WbnkcK491OYy4NWGKrY5fPcxanWN7Ks8mX1iYqXnLeg/EetWmW
 Y08blSQYkCG6vfgfhuo5xCaNmwMylvMRZcfq+nk+Y4GQb8Jw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0apq09g6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:40:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37deb2d3a3aso44505a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782290451; x=1782895251;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DsmXvYMEwIY+Vvn9ADapPwVq30xdvUbVrk3erjYnXi8=;
 b=GykM7mNTgS1zbF/59BeBGfuR84f8knAoQX2XvRcYkMH5Vdnu3U9x/9G0jCvf4XvTML
 66DdQuaVVDF8CVpAlbwQP1VVAjgF9m2au0td1AZafXo8vGoBvpCB7BOQDhg/0UbZKwD9
 cYs38O7WX1wwiMPYz9VMyplyfhJtLjkd8piqkR+Y4Ts60gvXQKdbNVnb/IyXHmn0PKQR
 4c44SbH9588LgeLvlxj+xqV87VBH+qeUh5F8gc0O5/D3rpa+q4Kv4dG3qMGqdGq1yAx3
 8W4KAk1HWZvWNrBZjhQ5luUj9dy1PvUm2KcqI/6Ef9xe+gOFG70yzJjQ56hIWT/Ung/M
 kfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782290451; x=1782895251;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsmXvYMEwIY+Vvn9ADapPwVq30xdvUbVrk3erjYnXi8=;
 b=skDVpCy9PDOpYA2FktJxR1Q03oz6gb4deHvUCqBmIvOGQ7Zp9SvMbHQ6VHNdZacg/e
 1x01ipQvmx4+x+2EXQ1ZeS1se00NJLalVem8NW74zHBPPm6IVuu8s2cV4ebZNEPaauQP
 R9JYeuUKEMb9MDfmaVpxnoLGJpqfl/eMq5Qcv7/aehu+0HDSgL7eRAGghkuzCox6DntZ
 7NSGe18ricSrpXlZ2yK4Po55To6ufPPpLHmQfHk7K8XavEpsucR9Q10uANhaBPiPms4u
 brSl46iiMZf/hrK5LnFHCmKT44loO0rj8wulMhFand5PLqmojiPWeKhzcp4J56Exi/5v
 PEAQ==
X-Gm-Message-State: AOJu0YwXzayZu1Znuy70tAJj3wIUODkbBpRJrFfJ7heXVaIvddzn7x0+
 WoqU0eXfMwHyB4smJw7aqbXtEr3+QpZOd+222K5nTL/p1ZsmUXTAAeSkfZV0fL0F6vNTkNbeYYZ
 X8Wo2rbpxHrqe3+qRmzgqRHCdlHsGkQbrLcFwrAstuIWbhiaET1xjkhC4r9oQS2RGxbOorhw=
X-Gm-Gg: AfdE7ckkrGau/5BN+bW/vcc9UEIJWRCYXDBVnm1EZ8qDV8izLm41sRQdTiGFJbMT81T
 wRK6N+e76SP72MFxBLZnuqCetMFFCmZ38OTIUTyQ3qUsdYGK12Y7zfgkzg+dqg2R+C/TyMp5vuo
 qanQkepSc9sKS6BFCHP1+n9FDgQNb0aZsp0nVd8XxC5Ylaw7e6PxTBDmfhWde/hKmLZ1jMAzyel
 Qq8pRpEv5OpcBsLqUYP0knpvL4ylwQd8piOALriDIOQfLRW2U8nvSqoPR7VJk24RbE+5b/dOA6Q
 Rss2jJbIby+dPt73zZnrPyXBom6Pz5r74pOo6L5RU8WMn62rOS01tn7UZEADabuMy3S40aHOUXJ
 hDG9JFXf8SIpN4jtZy2NXUIA+LYfT7lOfDhGq5GCT1DYk7ADMuLHFddm17myxmhh66Y+F3Qv5Zy
 gqxLJ3U6lYBFjjJHwtThlr7NR4lrW4q4k=
X-Received: by 2002:a17:902:f54e:b0:2c6:d204:10b1 with SMTP id
 d9443c01a7336-2c7bf228529mr43473845ad.8.1782290451151; 
 Wed, 24 Jun 2026 01:40:51 -0700 (PDT)
X-Received: by 2002:a17:902:f54e:b0:2c6:d204:10b1 with SMTP id
 d9443c01a7336-2c7bf228529mr43473755ad.8.1782290450633; 
 Wed, 24 Jun 2026 01:40:50 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c743bfd9d2sm148642995ad.56.2026.06.24.01.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 01:40:50 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Wed, 24 Jun 2026 14:10:34 +0530
Subject: [PATCH v2] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAGYO2oC/42NQQ6CMBREr0K6tqQtFq0r72EIgfYjP4FW+4FgC
 He3cgI3k3mzeLMxgohA7JZtLMKChMEnUKeM2b7xT+DoEjMlVCm0vPBhMqWUM9kaHLriXI+Yuod
 14q1Q2igHolWaJcErQofrIX9UiXukKcTP8bXI3/qXdpFccg2qc1dbFsa090CUv+dmsGEc8xSs2
 vf9C9tZl8bLAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290445; l=4908;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=CnYJyfd4ExMQkQqor65eo2+OEYI7MIMX9RUFTKwNb1g=;
 b=zft3EL+OdDKxP1wWIQMlofb0WxvlXPrIw/WpNG1NNxTls5BtkN1I9h159+ZCeF3Ad1dWtFSrw
 nA8XkV42KtLCwcRpET2sZJ99hpvp+RUJZATvipqbBzniR7VgjH7v+eZ
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: BOLB1RIH0E4tPEtp6k9o9NoHN86Ya_oD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA3MSBTYWx0ZWRfXwi3V3FagbA7s
 W2iq/oj58NhDpjT7LKC2GGypEMHJGV2QcQMecNcu4+/Nt0jiJPuYnC5cpd/YMAvpmnGM/ape2tZ
 Dqr53BN8h3GiLlIR4VWztJGPOxZh5NEPa/L+VuSZ5BeCSRbUhXaMBoN31V6W7SMeXJ0EeIsjs+s
 URdfXcvvKcd9vAB0wYEq4QZpazu+ScYRISeabLVi+xu0g7RSFPsrEjYcHaF3l4opsvBACYH2IAW
 sefYRRKdtRNCEcNdVHawWEsIM67JlrpYxrxACrtjE8JtOY9o8pqR7Zj6VzTCwAdl4D0ZjDCW0l/
 ZUcPYPPSasPdvlfNWrdPSGAtiEPQheFzZKFZ34dZQqlRgj1EnyrKJiSzN2Ge9xMh3hiQh4qFO/w
 OESQfOdk2vLBhPnd4vy57DhBboBmPUYYPVLEY25utUOx4ED70WCjxabARAZ7YkgHpf3blrUx2+K
 gStNCeuKWeqzqCO/AyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA3MSBTYWx0ZWRfXxVLjiXlQAj3h
 3v6y4qL+LGglmlNpD/p7roqmaGmT3VxNRU/ud1laPQGlXywE9tYiZ0IYBZPjS5BFxG7uAnGh2Or
 oTKWdRIh2SdLUp9p0eRjpKJT5sbsJvg=
X-Authority-Analysis: v=2.4 cv=NpbhtcdJ c=1 sm=1 tr=0 ts=6a3b9814 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=o18bOsZyImRqxqLLsysA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: BOLB1RIH0E4tPEtp6k9o9NoHN86Ya_oD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240071
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

Also reset the edid_read flag on HPD disconnect so that the next
connect event triggers a fresh EDID fetch.

Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v2:
- Removed memcpy and doing edid fetch everytime. Required an update in firmware as well for edid block0 reset.
- Verified patch with existing firmware V5.0.21, patch is not causing any regression if V5.0.21 firmware is used.
- Firmware V5.0.22 is required with this patch to support edid fetch on more than 2 edid block monitors.
- Link to v1: https://lore.kernel.org/r/20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 74 +++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 11aab07d88df..6c13d93996b1 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -28,7 +28,7 @@
 #include <drm/display/drm_hdmi_audio_helper.h>
 
 #define EDID_BLOCK_SIZE	128
-#define EDID_NUM_BLOCKS	2
+#define EDID_NUM_BLOCKS	4
 
 #define FW_FILE "lt9611uxc_fw.bin"
 
@@ -170,6 +170,9 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 	connected = lt9611uxc->hdmi_connected;
 	mutex_unlock(&lt9611uxc->ocm_lock);
 
+	if (!connected)
+		lt9611uxc->edid_read = false;
+
 	drm_bridge_hpd_notify(&lt9611uxc->bridge,
 			      connected ?
 			      connector_status_connected :
@@ -384,10 +387,35 @@ static int lt9611uxc_wait_for_edid(struct lt9611uxc *lt9611uxc)
 			msecs_to_jiffies(500));
 }
 
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
+}
+
 static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct lt9611uxc *lt9611uxc = data;
-	int ret;
+	int ret = 0;
+	int retry_cnt = 10;
+	unsigned int edid_ready_flag = 0;
+	bool header_matched;
+	const u8 edid_header[8] = { 0x00, 0xFF, 0xFF, 0xFF,
+				    0xFF, 0xFF, 0xFF, 0x00 };
 
 	if (len > EDID_BLOCK_SIZE)
 		return -EINVAL;
@@ -395,20 +423,44 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
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
+			if ((block == 0 && header_matched) ||
+			    (block == 2 && !header_matched))
+				break;
+
+		} while (retry_cnt-- > 0);
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

