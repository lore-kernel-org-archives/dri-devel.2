Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4327EC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2243910E23D;
	Tue, 22 Sep 2026 03:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkzMmMD5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AeQ/T05G";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B15F10E23D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:50:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M0eP8N3044036
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HCF9ztuiYaUSmwixpuXSt/
 17Bn8vi3doxoPOAgZ8CAA=; b=kkzMmMD5l4VTGK2gSgmRtKdy1Y5Ir0rnlwMzGO
 1WW7vbjcw2JDZAyAoEdcJ7QD+y9mxWGMm+B8CKYsVMdKHSXAh7okd9ZpfUtpojkD
 BwLqdjGyYdlpottgu0y3XQ7x6etpYayom5/d+mqvT9m7nTORcFnbB+aqRv3b7fO7
 iT3IBSy8GcyEwfqQWXW/zC/9DGt8FZGvrnQ14MMggRuuM30lR8awuPbWfUzgjOY8
 BXFYak/njGAzQwChs074h1p+H+5ECphrWoRoeuzHnESrbl3eOoWamoao2n3N3QTe
 VvFXnP/FRssJN7MyPPO6+CIA5bI25+9ZlIHgkxwr2cycB8NA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbarkh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 03:50:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3989c51d5daso1013625a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 20:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790049034; x=1790653834;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HCF9ztuiYaUSmwixpuXSt/17Bn8vi3doxoPOAgZ8CAA=;
 b=AeQ/T05GWxUM9KqmNrrHwDEfVDLDcwhc6Bug3DsjNX6ZajrkbbcaxQAZQXhhy1nKp3
 y6XOXyJtB+bcOY6XnJjj4MlCypYXH7ZK0U3vZ1/Zr9ChSpFbiIIT7kr/dt+aldy+ffyA
 jilzxBWPxdnCDrkMll1u1kc/WkNesiElgU3IMeSbaWjp5y2XFvlAkTUbVEMax/E8XgBS
 uy0aNJ2HEuGzHPuYA+ufhlY30f/TWn26I6OLPrZrh25O6wAdPkRxAMKbk8LFuKmC+pZB
 5jhJftghkvt89tdKDuvoCPur/uTX/pmwZpECFzDIgn05yMuk/xF87lDepcQO+B3wpcNp
 uH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790049034; x=1790653834;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HCF9ztuiYaUSmwixpuXSt/17Bn8vi3doxoPOAgZ8CAA=;
 b=DCctCFhDF96y30MNOmZleLUdfXnS63oGbjC1Ky2J3Ut8/3KKpmg/Uz3hvm5LiLnOax
 B3R1og8cbiybp4WF9l9GkvzSDm+20vv9eUsWPUU8qkHMQFIALAza4yv9dJNUnZU8B5YS
 Obs6tJhyoyP0wQNetnHSc++UAuH9IEXvW8RkW7Y2PK2lt/2JRu3+Vl9kZNq7j9AidZBX
 eiuZwg/QoFpygQIuXyoWEMZvZSg4aPQHeBmIRCFXXduVpqbdUO7yzVmb/PNOCgIz97qE
 17eFEiIfiVn49Evzc8JfxG6UaBzR41SkOWRIk8ZGGx4IWisT/Fhci3fkl+/vyLAnUEfa
 CWKg==
X-Gm-Message-State: AFuF++lv11uvJU8MHUIhWuci/Yq239ePecYXpJcG5Ov+n3bRlwwt346R
 aCgXiXBJc+LiUcPSBsP9R5gSg7Gu2QmCKFw1/ou/0J4DcJqyXOETeDZI9+tcGdHEdPQXen07rAr
 oJ84ad9TcDd4ixPbmb6IO7egd8llhFQjVSBwFH8mMp5+Uu43xKxxHwive7btFZ17nYXmANAo=
X-Gm-Gg: AYBFou2P4UXmGmwOVIU6UzeCDpejWPGzqQnRG9RjSsJVX2VFpEB4NUjWvHiEVDiM7Zz
 GgNjqu05id5L+4Aw5y30e8SX+e3FrK/gxDuYFOq+MemYRQsD1wrgMF0W+jtPaCEHN6RU+feICrk
 ocfh+J8+3MrIs1TphsqLVKE171uH7p84v5sxx3WYapX6soMFi/QSY1SDAJ1XpkAGDR+R4O2goc7
 YMbHmaL44xVzr9CRq9nKy0kttwgDOyBGCtmad8WAQa3v96zRrPSmTbXJZ76ja0ibXKec/XYu6Mp
 fwrU/BTg93YJpuqGn5s/yzw0dNH5L0SA2QS/trvMDAd/juPfUiepf++sNhq/y/f0VTDugMzgVIX
 jN+dzVmn6jQ369xfB7hcnPYdRW2ASGHkQ1kVmrVPPki9AqEy/OWaUuwy1D3+1HPS8CZ6Q6gV4SZ
 mlxO8YDD3ob6ArOHCrKbWb
X-Received: by 2002:a17:90b:5627:b0:3a0:6e3e:4314 with SMTP id
 98e67ed59e1d1-3a06e3e438bmr963987a91.2.1790049033916; 
 Mon, 21 Sep 2026 20:50:33 -0700 (PDT)
X-Received: by 2002:a17:90b:5627:b0:3a0:6e3e:4314 with SMTP id
 98e67ed59e1d1-3a06e3e438bmr963964a91.2.1790049033389; 
 Mon, 21 Sep 2026 20:50:33 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e612bdccasm1571076eec.16.2026.09.21.20.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 20:50:32 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Tue, 22 Sep 2026 09:20:19 +0530
Subject: [PATCH v4] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPr6sWoC/43NwQ6CMAyA4VcxOzuydWwDT76HMYZtnS4RUAZEQ
 3h3Bxcvarw0/Xv4OpGIXcBIdpuJdDiGGNomRb7dEHupmjPS4FITYKCY5Jpe+1JxPkR7QhecyE9
 1SHuDj54aBrIEh8yAJAm4dejDY8UPx9SXEPu2e66/Rr5c/2JHTjmVCN4VVomyNPs2xuw+VFfb1
 nWWBln0Ed6igvynCEmE3KLwUmtmii+ieIsa4KcokqjRgjGV8r7AD+I8zy/hbp53bwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790049027; l=6019;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=QSIB/+DBr/Cy57z1iM18yi8sk5A8MPxjd5VXoPTJ/z4=;
 b=z8j/iYJ+YD7a0h9IKSeCDpU4cteQUOHO+0KX9/6iavTkA0sH/GDGZrgZnmHJPqCBeuDj0mqAk
 LtD214F75q8DxXmx7smtHHiEFM1Bb5P7kas1aRGSefiS9bWNpVsTYJD
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA1MiBTYWx0ZWRfX0er/ZoFJOqAD
 NA3EzDWBy/7+Pl4NRhrENhhZxJLEVDK4SbeF4P0SHTfqgqjbuuvxSIpgVpU3i9msWZca14ABnX8
 JSP6zD+q3eXcFbqCpCpkYPPx1r+14QDzzqw4hDuM5LbuG/5GIC5fbKE2qNXE23o2pO9+zOCsNiO
 OVOc0vC3JyMUv0vgBgmohHZaMQktr2wi/Q9rH7kMjIXm86DUgj2FBb6P9KwCHNN+eflszFensLR
 3g3M4Oxps/I5+vvI1WJgUXSXdr4U2cwvdmdJsN1O3WVXRcC0+SwKHP0ioe1ydikj5SSQeUDhEWX
 ghBNxsTqXyP+sBDFcfkF2FrktzhxqU2jjxERouuoC2zFLucnIqSXzJl9aFRMp0Y/tTSezALVy+8
 LPMX8Mqz1R1ML7pwzFz7dm/jP2AUlodKZ6WrEyHWBhrt1aa0jF5ivrk597oQTBTYClmaOUeSyf8
 gnDRSLRBSDeOWZToiWA==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab1fb0b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YtTfkkFDc2t7ANI9DR8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA1MiBTYWx0ZWRfXxMCF51bCpgLb
 q0QYr0LXk9gLTDOngu+W/XmBr6pC5u9bqGkukYM4CyTMnKhvYxvmjQHPrS8cxBHqC8bcsEwbhyh
 bnDe9QtLWJdy214hl4IF93lLMfs5sBs=
X-Proofpoint-ORIG-GUID: GMk4lY1nZFc9Hcu-2NxWKax6c56NNqUP
X-Proofpoint-GUID: GMk4lY1nZFc9Hcu-2NxWKax6c56NNqUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220052
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
Changes in v4:
- Rebased onto latest drm-misc-next.
- No functional changes; replied inline to the two Sashiko-bot
  review comments on v3
- Link to v3: https://lore.kernel.org/r/20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com

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
index b3bb7f2cebb3..a74077a65f62 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -28,7 +28,7 @@
 #include <drm/display/drm_hdmi_audio_helper.h>
 
 #define EDID_BLOCK_SIZE	128
-#define EDID_NUM_BLOCKS	2
+#define EDID_NUM_BLOCKS	4
 
 #define FW_FILE "lt9611uxc_fw.bin"
 
@@ -167,6 +167,8 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
 
 	mutex_lock(&lt9611uxc->ocm_lock);
 	connected = lt9611uxc->hdmi_connected;
+	if (!connected)
+		lt9611uxc->edid_read = false;
 	mutex_unlock(&lt9611uxc->ocm_lock);
 
 	drm_bridge_hpd_notify(&lt9611uxc->bridge,
@@ -380,13 +382,39 @@ lt9611uxc_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connect
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
@@ -394,20 +422,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
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
base-commit: 8ef59ee794076e2b58cff357b12de2ba5d441271
change-id: 20260517-lt9611usc_edid34_misc_next-b02592de0b25

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

