Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBC4C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B2010E51A;
	Sat, 27 Jun 2026 21:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="py5wvbrg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WBeZ7f23";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B1910E51A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHof2e1719787
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l0lyybLA9GA5IwVm+MUJgH5DxOFpXLZuMYk0Z7DMwG8=; b=py5wvbrg/6kFRXqN
 0LswTyaSoaJO210eRHWwoawaQ3lWJh+437vOMiDFxMl4NseCNX5pBYJ9SQtj90bf
 vS57+JERDbXK0QNuFy3VKP/yWZTl8fjuIu4qecGE2CTCtZhD58+rqT2R5/9bgPAx
 KeQG9xxPed24kzKlEltDGCYhPJFVDyjYmqtsuA9l84Nfaq8mPts9tMsAR8ufGxir
 dYR5w2xDuPTB2bJv29ZcAIZ2+8z8PSs26GWUxr/56qY9st5SiWhpUoiA2tZzkg3R
 st/vKauYF8W+6J39BJZV2C6JApyXockQtf9VhVOgRov1FiQ4CbbRAruFhGbSoaJh
 dV1SEA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6hpg4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2503749eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782594304; x=1783199104;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l0lyybLA9GA5IwVm+MUJgH5DxOFpXLZuMYk0Z7DMwG8=;
 b=WBeZ7f2382JhojCcxpOqJuVv1pi1CAahLTQYEwXmqnh3f3bg9AOTwrabeXqTC95Kj/
 e3tMyGG/I91hFpi3mR2jkIFu1xm6I0bUjuWgGM6ceq5o8ackWvacxHoDrLSqtoujjAiI
 DF58IJLTJCF7M29gLSNEwOkVSpqB7L/5WUzWwfeTn9Z9ieXz9K+KFQDrmdiEmtbSRDKK
 QGiHnUDWmViy+0RYzidRABj9Wti5F9M8KyVKIdirowqTPYJuDbZMhJ6jKKT6Kw6qxZA9
 qv5FHwtlouZxoKmloJdDg1LtDQQZ/RPxZaPSMPUUlMYSa/98+RIJyeVcngahThys0KYU
 Na8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782594304; x=1783199104;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l0lyybLA9GA5IwVm+MUJgH5DxOFpXLZuMYk0Z7DMwG8=;
 b=GXo3U9Mh2r9BPbYRoykni+J51QxY8hhyRyNWeiVJKFw2RCEJeeD8tg90Z/xvoiajFV
 3S5KTl1hyetTjxOJmRctYxUDxdMdvnHfGmBmoY8swoWrg+7m5gDu4tsVzFGLQUg3IjS9
 cVw9PA7e3jZyYkpJraGLS+ix2ZIOIhgcEQdtqx/BU+eCe6qOWw7JlkdIX7mmenZza0TJ
 yItvL5byEWe9rmPk3FMwU5/9VcngGM4il9YOFfSmHk+s59ntao5RHce/MnqQEccNnOFh
 k5cFF6T5GVHrhsANE7gmawNiMJOkEn9tsPqdB8/hktFN1LxjWn4Cw+zojULG2CfSssnD
 VdyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXOPW9Pt/fphvHeLONoOb3vLte5lw3DWvLfaF1KDBjZmiwH/UvCFnKiQ1hudXYz2sAT33Op6fBXiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKacxNWE+SHTlGgWUQGLcxtBz5zdh+2NLNNjkwIwwciEgbB7To
 J8po1ziFxexe/xkx6xMrY2Oq7v3fxxOcnUp7N/ON50b0NPsMCdvJ8RR70TarE40X0FlXSL2pab3
 p7p+N3SxwIQsFsv7ocFi2C1iVaQC3+BtvctOz8V8FNXZ9WoDV93t1esnTsZ172RzvvvgEo0E=
X-Gm-Gg: AfdE7ck/4f/0KP+EJaVrVJygJEkfLndDAwVZXrQKB9c4hVoN1t65APMP4NdceyQ7Xys
 nH44dzZ6SeJ8ebWb+8Plq//EyYnBWBk9iCi7XHWZppOR7QBhyUJIyzjiN7+X3a/mi1ENT2ez4Qy
 7Rb7G/9XEwBRjwcibXfv5d+D0yag20g1e1TIohgTJhi0iJI1QI7Y3RiYPn+a4AfYLLKM5re1OZr
 PG2WV4pta0nx9KK8U43PdrO4Ug0nk0jXU2gRJDb+3iaTxBfDKfFTnDGBDKpD077m+sxY4cMAw62
 Yq4Y/r63yV2oYCWzMFh3rH4CTL3sWU1YGUFvoAy4mJG4ukfdistKMlkEX1BksGnRylWaJl0tQv7
 wcsadlrWIOzm9BtHlw5tOJ5Y9Y2NENsqZE96e
X-Received: by 2002:a05:7300:8b15:b0:304:cefc:5fe3 with SMTP id
 5a478bee46e88-30c84caaa5bmr10652506eec.18.1782594303907; 
 Sat, 27 Jun 2026 14:05:03 -0700 (PDT)
X-Received: by 2002:a05:7300:8b15:b0:304:cefc:5fe3 with SMTP id
 5a478bee46e88-30c84caaa5bmr10652486eec.18.1782594303416; 
 Sat, 27 Jun 2026 14:05:03 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm34561999eec.8.2026.06.27.14.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 14:05:02 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 02:34:39 +0530
Subject: [PATCH 3/5] drm/bridge: lt9611c: fix DT parsing and bridge
 refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-hpd_stable-v1-3-13d8b732c4c6@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: eLCjXcNhEIczXOM9WJU5p-mM-zkpYxdE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfXzc7ztdZLFEWB
 lppkzaXZu4Ch0h+GZLlieHZVp4BTf5F/PoHQXQgvKxhyWIOAKilv2LlfkvvNZRGBRmCZuVR5ggw
 YFqjSoyRuH1t6sAU6q2FR0xpalpfixs=
X-Proofpoint-GUID: eLCjXcNhEIczXOM9WJU5p-mM-zkpYxdE
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a403b00 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wKAF-K-d-Ge9zTf_WYcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX/lgkN/DBxlow
 P4vcazf2+GwpvzUw0jCToJ0eaIlvFxp8Xl3MjS0qJjS6JNLlNKwGImp3zBUhNDVILvyte9DM/tq
 FWoqZRK8qa/65mr8c1bms8vEb6wLQwp+sRehq6cUelrAz4t7QSvuJwONamKDonp9+RF1TsBWM51
 b6NJ1H+z378JRyHW7gV69v/15Me/z5KV1fgpIP72LyAbCrVUDPCX7hWi/l23yRXy30NJi/f6cay
 tpIFoEpmFqPDa2WKm7tHew6rbAQjaFuZQz78y48qJ8RYqAgR7xqAL8ZAlGlMU4oREBS/4YFWrzU
 7clmgvqqgeK1BTSvayPcOlD8z5Lc5S6U/4wrjfgJUispJ36xN3zsPID7JVnA30AfSPwbCAyifAC
 N+KOBsDvL5yI4R5aj77EJq7L8tsjJLm9hBLQqouDC3NTEJkfKhWrHkJyF9b7iynYQxV+HyTcN8e
 /kdRZ6bHGFjKCmXmtEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
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

Ensure DT nodes are properly released on error and acquire a
reference to next_bridge

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 30a07e97626a..4c8a3829a4be 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -974,6 +974,8 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
 static int lt9611c_parse_dt(struct device *dev,
 			    struct lt9611c *lt9611c)
 {
+	int ret;
+
 	lt9611c->dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
 	if (!lt9611c->dsi0_node)
 		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
@@ -984,7 +986,14 @@ static int lt9611c_parse_dt(struct device *dev,
 				 &lt9611c->selected_port))
 		lt9611c->selected_port = 0;
 
-	return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c->bridge.next_bridge);
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c->bridge.next_bridge);
+	if (ret) {
+		of_node_put(lt9611c->dsi1_node);
+		of_node_put(lt9611c->dsi0_node);
+		return ret;
+	}
+	drm_bridge_get(lt9611c->bridge.next_bridge);
+	return 0;
 }
 
 static int lt9611c_gpio_init(struct lt9611c *lt9611c)

-- 
2.34.1

