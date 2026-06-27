Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D06BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B8510E523;
	Sat, 27 Jun 2026 21:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZ8Otb6v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kbsk3YzZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4416A10E523
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHna4B1737279
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SMdVw15e8oXkfVkyfrzV3E+v80WV2Hb4jhkVApQRyHU=; b=NZ8Otb6v3ev9VLp5
 6bgDpXp9i7Vk9dAJQCcnHa2FUMB5sovZOHGIeZDDRLDjDSpVuL7k2eqXPqY5mUtt
 SzczK9Bq3rl5dAwgCfZ1Z6+/7JWrgz+sD9D1d/Li6cc98oJ37mToRbukaVhxJmVy
 xTxJpFdQ5ROIzqpf87n/mSpbCQogz9x0RG0kL0eh5qnrG8HwNnTTMOC4f89kP9ZL
 +f6t0G7QOySJm7bmr0FKuxROOJV+iUcmbrLU48Xeu213wzrgKXgDB31btaZEv3pj
 FA5vneQ7aCbBOtIiOAN0Uv73AfdniPyZfJ14+amj90RsqimtxeffnXNpIhHIA4ch
 hCm5lQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tusp23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca1f74cacso1822293eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782594298; x=1783199098;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SMdVw15e8oXkfVkyfrzV3E+v80WV2Hb4jhkVApQRyHU=;
 b=kbsk3YzZLss3Jcx1274gM4ZVuYkY8KJK57rXqsX0mFNYoltm7wjz+c2XVElBlC0Dds
 GdgevvkcVNpqQHHoEv6YiIIyTlu4wJBeNvr0MKeYw2AkCFueJdhz4HUUV2jQ8tZQpSNj
 v8dNDyl47pHEZ/+2M3m2bIYNvIP/Wx5VNDQhz/RyYcfRv7A8wjJfsIu6mT3SBfXpk3Iu
 MW2NJ511GUcu9G1j4Oi5R/BfbAVS1xBNaEzrMJ0tLlVFJm/A3Z6Bv6gX1pnfVeWFGsi0
 E7ge0DSaNzmYA6suvYkayWtLUpH8RJX6/LADg/PXzJqfpTROKWhRAgU7uGSVwslW7xe6
 qqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782594298; x=1783199098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SMdVw15e8oXkfVkyfrzV3E+v80WV2Hb4jhkVApQRyHU=;
 b=FmgziDukYMxCFXJagV7kd7P7Hp6BfAQqOdoR3USt+UrZGyw/8JSF52bPdjdxhsLy16
 z+oB4npz/rojqtFdAkEUzlANCmNegdLBWYgX7gHmRmjgL+qwTKipcrlKT9NDN7Vlflbe
 28s5AJwqd5tCNIZaqDlrcYiQ98ZyNnSOr++DoPrPXtD2Fcv+UjT5k70p7ZYUbApIuD4o
 iaZTqMXm8JMZ4sDVpe4vzPNeC4ZbGxT6oaY1BaQZJwhEHS4XHdSzUJBEXbWUXpOXFm+r
 pHnQo1+vZCjXYltVzkkAAY3JvflJMDZ3XOxhh3Ygi7L3eMPFQ92n7jFRATUTDs+d1XhS
 AmPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdMLk5dBCMx5QOCHbOilBRxEpao5oW744YGMh15mwgXaYiuLpPyn3My5HF7ueFK+DU9v9XYQHmCUs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/QCbSVzvnitpqS/GlksOeQWnIrtwPoXxsOMUCNCs8GW60NezL
 EeDic6/ngnGT+ICKi0y/722SjeXmdxHfgVQYEOAvF4gE2fkmf6c5wtuNc0FqXDgTLZHzXsThfnG
 kn9d3dzqGeW6cHaEHI0zgYpARnrfzZCFgeBu+oOIvt1ENi6PCfJFmXxQW3x7s71vizgE8veM=
X-Gm-Gg: AfdE7ck+6RhYsPqEkwdULAdqzt768npIOXzRJQhfkKgDmnmIcUY5rfVlrVoqfyWTH6G
 FCuV0c+H38sXR0nzAt4hVKoYQ3gFa9cUiA2zxk8mzFdFIrZyBnwYdKU4CHsIYrxArUR6vVCHkPh
 3Zes+3QxuB9aBW2uZA9byvyxkv4gjkHk5f7yijeLM7dlm28WLHvPkTFniFxxiwYpSVbnsM1VF2w
 GmA6FWi1dt1jlxTMEbY0IIdezqYbaN6uXbHTdkT+CSHZ5kfnYhxCvjSesUNEgyO/oc1OkTqUDjk
 IdACDjw/68rmmI/OQfwsdjqUbLwX3UZwQ/JqVrUBu5sG6duQ6KbGTqwJ1JQAe5TX+7koa6UivE0
 NGHhB4qIE97Rol4O0ZtJS+4W1W11Z9Ac+t6IB
X-Received: by 2002:a05:7300:d021:b0:30c:536e:3a8a with SMTP id
 5a478bee46e88-30c84b7208amr10260251eec.6.1782594298215; 
 Sat, 27 Jun 2026 14:04:58 -0700 (PDT)
X-Received: by 2002:a05:7300:d021:b0:30c:536e:3a8a with SMTP id
 5a478bee46e88-30c84b7208amr10260217eec.6.1782594297697; 
 Sat, 27 Jun 2026 14:04:57 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm34561999eec.8.2026.06.27.14.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 14:04:57 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 02:34:38 +0530
Subject: [PATCH 2/5] drm/bridge: lt9611c: implement hpd_enable callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-hpd_stable-v1-2-13d8b732c4c6@oss.qualcomm.com>
References: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
In-Reply-To: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX85/xh3wivt09
 PMCZzI6akdeQSBi8mA7iGrwFqdpNbR6mwAn7B3xxOD0A/rXCkCWBUThmyQpDNPH2NLlwY2wW1RU
 hNg+n8BEX6EXXtD24KFGP2JOthC/TVc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX6DSLwddDxnCV
 mx/hHHoS/xTvi/1I6uho6vSOqbgVgZoLP0n99GZ01xr0cVKmHFMtFZgP0hLrzPpiE21zRgEMVN3
 byrwxw9FwwMImm1m94kKswcjhof21DJV9TuBYccEdL+LJrJSNHORbLDJAnJvgXeGzzfn7/GRVwP
 kTQb4TfjC5k0YPW98pgwt99QwPw+W+b7TDvMvB1SZtP4G9kJoIZB+DZKhC0gEXWTSNOpqH9Sblu
 TGYHIVlj3wluBHh/vKt04YWVA2VsHoXFDCpoqJqg0r+Q9QfKHP9EBuoMnECXpOly5oPjFCWGiY7
 5iOxBmkmbLt9BfHPd83zOytBBJ+vsSINzXB0QXHJTUQzQ9afAOKGcl2nuYfn6Ty35hG4ReWhX2Q
 k3kFtBQ0ngq4bEaMydwc5ePlJ4vdFx7qf1fsTlobQOQM9AaXztUckY6vC/ESFKMEXkoSfxGbxjE
 MbIMdbcvSCySzqNeKuA==
X-Proofpoint-GUID: mm_rZtSiwG80l98ZTbU9yvztJ89p_mGC
X-Proofpoint-ORIG-GUID: mm_rZtSiwG80l98ZTbU9yvztJ89p_mGC
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a403afb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1Hw9fzs1msmsMXDTu6QA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270187
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

Implement the .hpd_enable callback to trigger HPD status update
and schedule event propagation.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 81ca9d62eae3..30a07e97626a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -923,6 +923,23 @@ static void lt9611c_hdmi_audio_shutdown(struct drm_bridge *bridge,
 	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 }
 
+static void lt9611c_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	u8 cmd[5] = {0x52, 0x48, 0x31, 0x3a, 0x00};
+	u8 data[5];
+	int ret;
+
+	mutex_lock(&lt9611c->ocm_lock);
+	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
+				      data, ARRAY_SIZE(data));
+	if (!ret)
+		lt9611c->hdmi_connected = (data[4] == 0x02);
+	mutex_unlock(&lt9611c->ocm_lock);
+
+	schedule_work(&lt9611c->work);
+}
+
 static int lt9611c_hdmi_audio_startup(struct drm_bridge *bridge,
 				      struct drm_connector *connector)
 {
@@ -939,6 +956,7 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.hpd_enable = lt9611c_bridge_hpd_enable,
 
 	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
 	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,

-- 
2.34.1

