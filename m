Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A133606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gBRbKbNT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fC/+DOX2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF0F10E00E;
	Sun, 22 Nov 2026 03:27:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212F910E00E
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 03:26:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AM0993U2012473
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 03:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=W7OY6MxFu6gAkMGCReTmSg
 JedpxuJg01UlJjHzDgArU=; b=gBRbKbNTv1kn166qT1l3fsVBHKPoiAQrlOCTQL
 F9QsWm1XFiQgzQ6BVsN6n8BmcS9H1R1XWDiHWkoeY1T3I+Ds4cc4YcEhftTjIRUe
 oeatucmw8KAq8KmgkBlBexlC1WF1VCpEmoPKr7Her0QV8/BHNpHFFDk9XPMEo+cG
 n7G1ED5Ke+79hprWPANEsJiMcjOvnXDTq7IN/nbhEhpRIQA/xSLP/pDYUV+FeRnf
 5bCOYGbLfPHih+UgVl6wWVwKJgJMATUnH+0RyafkE2WbbrSNHDiII59oD/3GyF86
 7bqsRSafTnqBuW+x6CShpjD+/catdIuiyBd84PCI96g+6tJA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33cu2kkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 03:26:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c58d35c0aso320227eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 19:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795318013; x=1795922813;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W7OY6MxFu6gAkMGCReTmSgJedpxuJg01UlJjHzDgArU=;
 b=fC/+DOX24Lfp5CIlyVACyhoW6haj8Guay8e+siHhGbIVVt8YVfp47cA/srMX2Ppz/i
 XfaCmmtBYHSgMw4twAHZkzz9v6FbevMrEop0LeJIP46iCQjGPBE50RfA4bcyVSyy7spM
 3SFUkgM+kqphn2WhW6rNPufP/zpafoQTz+ONsg6YfZjcYn7nPaGaJC+K+jnmotfkzRRY
 e9PU9uwHdIOe0IByCSaavDPM94TybI1P5NTL86aTF28l2ahI0L+DNgIBDkmOAna8bz9G
 Qk1qjDsTojifaGXQ6Vx8ub34n0fnNWGZqg1jOiFQTI0EefNKUcie6agaJkX7GDtZzvPF
 uA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795318013; x=1795922813;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W7OY6MxFu6gAkMGCReTmSgJedpxuJg01UlJjHzDgArU=;
 b=tWB3tQGdgOLj6pp7Qd17orvk9K3cKO6REHUWuBAcGzv/tRkmwod3ukBPjuJ2/ShYwI
 jJCImRn29Qc+UJS/bz1r/vp+q2sXdX0G10oPYppvZ22jkhGJgXsbhKcGrcNMsrX01cmN
 9vB2vCl/H/yd8bowu1RCLOTuHLzG9GCyzzNtKSZ9sGab1Q4u4D1bsLNtsQ/Ip3kWxj5G
 /S/uo2jQv0jvynT0Eth66Ay1yJKhp3jVE1bXnucdvGGrku0TfVxTtH46grllRsmMYkkq
 ZEzdbxuQ6I5IhXC3x4Qc9HwEHjehDU/MyVXYeMYRorQZfhCQPOlP00LcaLIBpMKPl0h+
 jf3Q==
X-Gm-Message-State: APuU4Z+PssDqAm0mCdzzwtg6h2L3bPqv+l24Up7G3XGDpjXFIoSYaJo1
 PR846fl0rWzLe4zNI4Rc6vIlF9342yh36jkcN0/0LNwvTPSwcAx5AbhQc7UtC/+K1vZyrzhj+4C
 nrCSxjz97KEF/dBH6H8mVkjnoP7hhFLPIlpUxjhDA/sPF5N00l7wP6BMAiqFKvSaSr8eDuno=
X-Gm-Gg: AZFdTZfdWIReen2J2bk3kVshgcFtpXgW7OX6pyxTsgSFgtJ1cZy2VeslWDgfuLhp4cL
 8MrcysFMPGY1FhzzZJmWN6cS8ZbMF6hZe2inlyDYOvs46nBmvc/FqV2YwhkAMVH4VIq7ieI6IwM
 RLuAyuk4kLGWAYbhXU3XCWk5EyDxqyaz9D4/yPm4QC/F+pifNU69jWBMf9JdTJclytZ+Lf40UkD
 KXAy1mVPdQRtv9Kd1VwuKztHYiMVyXEHtUz9TR9ZQ3PgQZnzRgzPB/BSjuGbZLKmsJkF1j7GlAE
 IBRRKYbcuAvQxREClvrxHm+HSTxmaek/NifLBQ1D6iVIPECh7aeTl4aYOgDd/Gm4y9L3qgBteXN
 lvpeqDv16CV+r0wM/NFU1ZIMG3RTewlMW/kLv0kdS2zljAw/2UmpmTY9bZEAbs80QW8a/CRI18B
 6eKI+f+Gv+IPmY9D4+4RlrBBEGc+7N6T5O9+HYIuW/2Y3bP1v1u3cDZNcsXHH7T5Lxth+BU1pdx
 NesJoGcORgvhDfxgCwVc70nIoLGsA==
X-Received: by 2002:a05:693c:26cb:b0:381:6297:8f99 with SMTP id
 5a478bee46e88-3856e748babmr11364097eec.2.1795318012412; 
 Sat, 21 Nov 2026 19:26:52 -0800 (PST)
X-Received: by 2002:a05:693c:26cb:b0:381:6297:8f99 with SMTP id
 5a478bee46e88-3856e748babmr11364051eec.2.1795318011756; 
 Sat, 21 Nov 2026 19:26:51 -0800 (PST)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567ea2cc5sm21117766eec.29.2026.11.21.19.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 19:26:51 -0800 (PST)
From: vishnu.saini@oss.qualcomm.com
Date: Sun, 22 Nov 2026 08:56:36 +0530
Subject: [PATCH v5] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-lt9611usc_edid34_misc_next-v5-1-00b562fe4a24@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOtgAmsC/43NzW7CMAzA8VdBOS8ocb4aTnuPCaEmcUYk2m5Nq
 UCo7z7DpZfBdrH89+HnG6s4Fqxst7mxEedSy9BTmLcNi8e2/0ReEjUDAVYY6fhp8lbKc40HTCU
 pfegK7T1eJh4EGA8JRQDDCPgaMZfLA//YUx9LnYbx+vg1y/v1X+wsueQGIacmWuV9eB9q3X6f2
 1Mcum5Lg931GVbRgn4pAomgI6psnBOheSKqVXQAL0VFosMIIbQ25wafiHoV/R+iJlG7ZJQ0Dcj
 8m7gsyw83R5I2wQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795318005; l=7199;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=NTQaNIpTYJy5Bg7EIKV4sTcHmVS3gOpADRjFZ5rUNIY=;
 b=4PL0aAbRLLgHbZDheHdCQrnlX+TFHj1FopcgaVs5Z+ltVWLN8D6lzQIsEKFWHkXC8Wy64oDxN
 SlwUH2/VWsfBcsAO2tzemgZ6NYKUHfkJLIhSB1smvWBBQJM9xuTT+rp
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: Cn9o9qsfHH_BKFpgEantnhW_9Cyg6J3X
X-Proofpoint-ORIG-GUID: Cn9o9qsfHH_BKFpgEantnhW_9Cyg6J3X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMyBTYWx0ZWRfX134ViH5q2esJ
 S9DwmguZMAUR7JQ7PpuzAIY0QQfEBgVslizU8g3XOXbYQdHMm4MKn6jqf2nqsay3sKwZUjY1hcl
 pH7FOrRr2Dg2SVjyoibSz1IRmRwRSZMw/QYf+DcKkzHLeti7HE2Rb8Wuu8MwBQOnTPWUxtXwuvG
 /JiqZXNzwca3NVypV7l1IpnDuH+O8JKJm/qc0nD7KJf09gC27QOwhqZqmeSZMgfq723zKaNgah4
 8H6GwaYO5YljlLoVVuA4Dv389r3omaWw0lFyRMfv7Ch4WWLuda4qBXLk7yTGQhRhcyfjRKSOCwB
 Fxkvk5e5wRbB7TkEZbtfbIj6v95gnMWsKJ7+YBMvtRqo0wAbhxAgpWHyceF4DGMHsSoXfUMgaHZ
 3jeC2rBKGvurThN0WOsQGTXftMC1wLZLB5/V74hbuMS9yNRZGFNY318g9GxIPKRqPuAI9nzQoWB
 SZ0fpjGFGJpyzYXKyow==
X-Authority-Analysis: v=2.4 cv=MM71C8Zl c=1 sm=1 tr=0 ts=6b0260fd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uKTj4MC253UD0qxwTz8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMyBTYWx0ZWRfX9olUR4pmXvEF
 B5TZc3TEjfuxakdbf4gsJDdsyJhYTsszrIgfGj7ke/I941kYXioy8Nl7xhrWGOthfd+bp33Tvwk
 MM88rfckqzP4lkpIRh7DE+JZULC1q08=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220013
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

From: Ravi Agola <raviagol@qti.qualcomm.com>

The LT9611UXC firmware buffers only two EDID blocks at a time, always at
the same offset (block % 2). Until now the driver read blocks 0 and 1 and
stopped there, so sinks with more than one extension block, such as the
Dell Curved Monitor U4021QW, could not be fully read.

To get blocks 2 and 3, set the EDID ready flag in register 0xb028. This
makes the bridge asynchronously fetch the next pair of blocks from the
sink into the same buffer. The bridge has no "fetch done" status, so the
driver polls the buffer until the new data shows up. Stale data is
detected from the EDID header:

 - Block 0 always starts with the EDID header magic
   (00 ff ff ff ff ff ff 00), so it is accepted once the magic is
   present.
 - Block 2 never carries the magic, so it is accepted once the header
   left over from the previous block 0 is gone.

Poll for EDID availability up to 10 times at 100 ms intervals. This
provides sufficient margin for the observed EDID fetch latency, which
can reach 600-650 ms after the HPD interrupt.

Reset the edid_read flag on HPD disconnect so that the next connect
triggers a fresh EDID fetch.

Also increase the EDID wait time from 500 ms to 1000 ms. On the
Qualcomm rb3gen2 platform the EDID read interrupt sometimes arrives
600-650 ms after the HPD interrupt, which made the EDID read fail.

Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v5:
- Updated commit msg and comments [Jani Nikula]
- Rebased onto latest drm-misc-next.
- Link to v4: https://lore.kernel.org/r/20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com

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
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 93 +++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index b3bb7f2cebb3..d5924a8df1f9 100644
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
@@ -394,20 +422,55 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
 	if (block >= EDID_NUM_BLOCKS)
 		return -EINVAL;
 
-	lt9611uxc_lock(lt9611uxc);
-
-	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
-
-	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
-
-	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
-	if (ret)
-		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
+	if (block == 0 || block == 2) {
+
+		lt9611uxc_lock(lt9611uxc);
+
+		edid_ready_flag = (block == 0) ? BIT(0) : BIT(1);
+
+		/*
+		 * The bridge only buffers 2 EDID blocks at a time. Writing
+		 * 0xb028 re-triggers it to fetch a fresh pair of blocks
+		 * (0+1, or 2+3) from the sink over DDC into that buffer, an
+		 * asynchronous operation with no separate "fetch done" flag
+		 * to wait on.
+		 */
+		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
+
+		lt9611uxc_unlock(lt9611uxc);
+
+		do {
+			msleep(100);
+			ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
+			if (ret)
+				break;
+			/*
+			 * Poll for the fetch to complete: block 0 is only
+			 * valid once it carries the EDID header magic, and
+			 * block 2 (an extension block) is only valid once it
+			 * no longer carries that same magic left over from
+			 * the previous fetch at this buffer offset.
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
 
-	lt9611uxc_unlock(lt9611uxc);
+		lt9611uxc_lock(lt9611uxc);
+		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
+		lt9611uxc_unlock(lt9611uxc);
+	}
 
-	return 0;
-};
+	return ret;
+}
 
 static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *bridge,
 							 struct drm_connector *connector)

---
base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
change-id: 20260517-lt9611usc_edid34_misc_next-b02592de0b25

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

