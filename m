Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E1DCD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E0110EBF6;
	Wed, 10 Jun 2026 21:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8smhcYR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFWPAKpa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DD310EBF6
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJZtLG2620957
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xaHWtK7eO2a/H2LXqc+Cs2jlO+QiA3eArtK5Kd7RsE4=; b=g8smhcYRoEvl6jJy
 bTNTujRYDljlYroPNYy7uYfwKbYO/GCi7OdOzpBAu9mnIfF/OcidtbosaZS5P+hX
 /IDC31esepve7rfjrmMkw/DAfLr1gamkEGQb8XYJQEuo8jUje8MnubKNYduTCh5l
 vWx68Fv3HGqa00XJAiIXAFVC4fNMIaw8dbfF9CohPxla6XrYMAPlg5am1kp/tP50
 1c0N5tpGHpo3wbas7u88rW/a2sEZEMYWhmi3L3SUY36zoEt5/jVtzetZCCkuzC9s
 qoh4hgtl4ckJ46Vbz8rndthtwki00JaPaj5rBM8Cv9Exv02PpshA3PVy2F7IITv2
 muNQ1g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sgdg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso6777029a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781126120; x=1781730920;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xaHWtK7eO2a/H2LXqc+Cs2jlO+QiA3eArtK5Kd7RsE4=;
 b=OFWPAKpaV0KgqUGqHJqQ0+c55zk77lCT6AdG2hb1atqpE4EhHbt3QXxY6WoQ9ljNbj
 R8zmL8ut7WKVqvG+HaP+PZJVO+QaORex8rPy3wLxg1LSULAztVHKh5T+GOHLj1L6R7vj
 r1FimkVngJ1pG8SI8nolNeEmaE7UMub9t2mRQ3bLLwnvXxhgbI7UzQZUMpMajJ5zLEKM
 o1Bg2FmVAe4V02QO347MDiT3MI8/6KTS/cQS0URePbEEqEagoe0P8eG+rhzUDfLQg4qR
 CUEcJLvSf506yhiFZyb4wkLIWJzIGCm+b8EifnZB4O7tW+YhTZtNjkmoxlLiGzGGgD65
 lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126120; x=1781730920;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xaHWtK7eO2a/H2LXqc+Cs2jlO+QiA3eArtK5Kd7RsE4=;
 b=WLH35aG2wI75Tj7GNGRjLaGk8OqvtjNPwMUAWb1dHqRd0IvBbad3vg63LGIPdOVBUa
 A6T4SXnN9ZKHsb1MML0al2Ag+fi2Kp3Dxs+XNAuASkloVvS4QClx3ikVltKquMqvh2Db
 PrnKOhoD0AIlBdlFPgcyR7ftO+lFzefxK+dhZv0I30bW1gLui18f8z4HWxqAfyYeijHa
 HtAddx0oK4OVyglX2X5qEMc+KtTNmu4fLhzJRdeWjCmh3ZFREoynmUIQol2O8M1qovHc
 S3uB6x4gNyusvqtf7FdF9Wf5xMZ1KQu8RzRAm9UPv8qgj4Y1mObFiG1cmdfucG49vOSz
 szog==
X-Gm-Message-State: AOJu0Yw9ZC/KkutVHeduLMJku2sTl+fFwNTHDIJO7MBpeSnmKgu6/i4C
 fxdNn44yTSFbdNuuHq080mR6XnV2jCyL9ngd3ibH0FjyGXRI+c7T8nHs6WVD115w3hTmdr2ivsw
 /+if5pHw4yoDWeRBKTXYyIvrHRyKkydJqISXt0OYNH00sVdOrlWUx85vsv5kbVersm8PWg/2P6t
 kLdXg=
X-Gm-Gg: Acq92OF8ojBDcZk7Wy5riqHQHC4Zli1tnhNVQcrOCgBcI1vd2MgBk30DmODihpUMFQ3
 zNT1fSF2v/USAZfFW0nF4MRhu6DFpKloIOen3C9NHgu1D1CeRvZmswxdESqBTGuhFfvRzesqZEv
 gO4Cradua02IX0x+Z44ZgDbZIG/fteLhR1/0JDX68R9D1oskNOHYRZWiyEIWm8+btoO5JjPAVov
 +ngT5uxedsbVq2kwnuGM4yblwreQgsIal8AB1mTcvUSumI8ACsDyWjfBjTC8r6QR7dyQ5+BnMy3
 JFhTfQJdXTRaw9nDFEkY0vg8edIzK2SFV0t71JLIZG85sDMB0CqrgivX14Bqk4JGkoMTmFPIjwr
 FNNnZbyIZ/b6PfKsbn32N101QnL9lF654IiRu1wKkBuqiy7Mqzu8s46vROA==
X-Received: by 2002:a17:90b:390e:b0:368:a297:bd3d with SMTP id
 98e67ed59e1d1-370ee82f93cmr27505493a91.3.1781126120074; 
 Wed, 10 Jun 2026 14:15:20 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:368:a297:bd3d with SMTP id
 98e67ed59e1d1-370ee82f93cmr27505437a91.3.1781126119471; 
 Wed, 10 Jun 2026 14:15:19 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37753d01cc6sm309490a91.11.2026.06.10.14.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:15:19 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 02:44:57 +0530
Subject: [PATCH 2/4] drm/bridge: lontium-lt9611c: Increase MCU poll timeout
 to 200ms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-lt9611-b4-send-v1-2-42abbcd3bb1e@oss.qualcomm.com>
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
X-Proofpoint-GUID: fq3MPGfYZR9ei7vt7ypKdWhnH4zZxpw9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfXwk7HgBq3/cn3
 zNhiAtKmdijtwsNARHdKbWpwUYqqRRxhMSXhduz2MXf8g3EFUyQ1c9mrN10YVR0ndYJa/iv34va
 iOUk7aM3eMCA1z8p04guWd56tUSgcCo=
X-Proofpoint-ORIG-GUID: fq3MPGfYZR9ei7vt7ypKdWhnH4zZxpw9
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a29d3eb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kk0fxjKgInd3OyqQQRkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX5of9A87uzOtm
 BY20vnb6g4th2m6XTlhFhh+zlu2rm3LEE9r/GtbwuXSR5+mCTLf9Zh3UXMX7PkKQd+1g8fbLBAZ
 D8I+yoQK2kiEE2yRwwKBGbkAdtwUG04uDKa8WPUXReRSifOGYp00SUwWMO2HJosMLc3M0m4rgLw
 IM7+Fu+Sdp2jjp7sd5ZSY92E6pzW5ktuWVnViLYMnJc5h6HQ0K/SKFeLDkvOG1ie3I9Tlha48b5
 +oHNtjBvzCGv4pNG7Pize6YPCKh5ytWNwpT/s+hHVe0M9ciDzYkkEyjRq1p4UeohJphg2qn+mfg
 QW+M9rPbbzJIKq9VH8UJZYxBMHW+TWO+fvDCwPMFUtCqeHyDyryQeHFSVhEBU9HvIyz1OC61Rxn
 NLLiovCuOWV3/2TmwHboyYKiQVBNsA8nxoQ0SC1epef16TpLyYnvjinx1yZKjbLHsdfJDYlYw5R
 RB1Bdw4wgOkJ72v4k0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100204
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

The on-chip MCU may take longer than 100ms to respond on some hardware
variants or slower I2C buses, causing spurious -ETIMEDOUT errors during
normal operation. Double the poll timeout from 100ms to 200ms to improve
reliability without changing the poll interval.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index cb584855fd8f..b0402726367e 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -97,7 +97,7 @@ static int lt9611c_read_write_flow(struct lt9611c *lt9611c, u8 *params,
 	regmap_write(lt9611c->regmap, 0xe0de, 0x01);
 
 	ret = regmap_read_poll_timeout(lt9611c->regmap, 0xe0ae, temp,
-				       temp == 0x01, 1000, 100 * 1000);
+				       temp == 0x01, 1000, 200 * 1000);
 	if (ret)
 		return -ETIMEDOUT;
 
@@ -107,7 +107,7 @@ static int lt9611c_read_write_flow(struct lt9611c *lt9611c, u8 *params,
 	regmap_write(lt9611c->regmap, 0xe0de, 0x02);
 
 	ret = regmap_read_poll_timeout(lt9611c->regmap, 0xe0ae, temp,
-				       temp == 0x02, 1000, 100 * 1000);
+				       temp == 0x02, 1000, 200 * 1000);
 	if (ret)
 		return -ETIMEDOUT;
 

-- 
2.34.1

