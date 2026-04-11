Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01093F3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E8C10E1D4;
	Sat, 11 Apr 2026 12:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDdlQJeL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqOBRHRR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC7910E1D4
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B9mbsG1322400
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GER20aNRyZAzUKwcjDT9x/OFiH7hEb7KOqKA2FbdkL0=; b=fDdlQJeLfUJ/6fnP
 4WuAE2oNwfNKdLsfhcknpaOxkpm3LKFlX0RdRq+b/p9mvmH162VbFuE42hNkC8Xf
 zFDZ5JE96e9JEP52tWvDkVwygdNZBSaFYvVFpwwpQWC2lIgYlKdPBNVXkYbZsbl/
 b3eRNKm9G2dTEINWcaEVKLZB4MKrsv3KtATazQoGlHfoavMFvIlAI/BVatMs5zuy
 Sj7oQmoL3iu11im5gbL/KwPpUl6Cb7vTyl5GP8MSZTNXfTNVdw1SW0i60qppqhca
 X7oEYk7VS/maaYuX+QlJbe2ky65PBl9O2M4G05LOUcm5GVYBOBvqBiRdzhB8TfxJ
 x17s4A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfrnam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso36864671cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909460; x=1776514260;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GER20aNRyZAzUKwcjDT9x/OFiH7hEb7KOqKA2FbdkL0=;
 b=kqOBRHRRE4E5pz/hnVXcL2/t+yKb2xWP00+KGYqtQ4/DNUbYDHd9JFl5Q5mcz5DThP
 4ky4+BwRGGW9Yg/fy1hdJBomDGmBwXJb/9674YkFjTGRNgcXiiNg649nsNvt3NFFuRCR
 dAZRSmxGb26HZOPH+v0yVjJ4a5j2AQtIaI4UDrnBZoyYXNioJcLyHwiInT5uQB7zSuA+
 H0h9UFVPuUKzAqC4zWA9lpjmzSDm6Z7/Wh/bSP6djSMRE+jl+ACHPphlhkGVobrnMYP0
 0Da4D6F04UjuUWW2PGpAqQ2PWEbFC6XcXn0r4G2Ymy4lj9Tfy1c9pDNzb6agmVfjZF89
 pKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909460; x=1776514260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GER20aNRyZAzUKwcjDT9x/OFiH7hEb7KOqKA2FbdkL0=;
 b=e0hCHqcrUcuA/n1oaxMpvUJpRhB+2HfW/XtoTsB9zDala1449bveK9HOrnUxb58+Ey
 YfXqTQ0w3CEowfXCsbYKlJDddcM+OaXgslrXXMWhCrPq6qkAbtiTLOWEpC7AH9iUDkxQ
 J0nMCMLdpWtBtkWMwdM5mkVQ/2RSF65WE77bQhziWWnx4FexzJLs7fFwtUM1dG0WkMEE
 qmIWLhVgamGYKRhFIwMuLLezjlPhc18Vzna0Xf8xuT8x5gMLhfKQc6f9r4nOOnvmpwuZ
 8US4Qr8k1ho8a8AeHolDeHBtsbNt+CbXxVSlgAMexGkNVtKhHvrqvTOlWmaNcdPoXGX3
 e5Gg==
X-Gm-Message-State: AOJu0YwL/YxqHL1DKv6MOxjPg3wBkQz9dRrorCCkIu1uwOQ/1VKJKZ82
 YVbik8/VJo3LP5l/t6u88WkZ4UWy2QsTULCkYKTEk43TJF6J7Ji+ER6e+Un85UXOktokvo2C24w
 dwFN5CSrHTo9AXl/m4BPKL3RhT1TJFhl0Ew9gtUjOQkwRieu432cbqmp1c6fD8yd54GyoIso=
X-Gm-Gg: AeBDievWn9/Pm+CzaZAmByyaADFcsUaKJJ3wRA6aHc1g6x9dm0/d4kp2KP3nxGuzN6C
 DSOnVQ+XsiHrMcVJGyme/XlHyFBjZEK+zD5tkmcCEcawJzpUeS+0EnrUW1uGmgyxulpM1KDLrPi
 bZ+deR5PZc7aTNlPlODgBYcCFkpmn5yc1HwENBBdRponsTcGbS855KKm/4XKsEA9n47sUc9Nnxf
 NmRWdDhw9IbEnZ4NSH2Rw0D71w9P8/j7JmoPruinmj4hzW8XzHBXqEzK8/koRwavDuGR4qMpIfG
 P8dsSjVV/VFLzCXI0nFxjXXpa1g6YyXlpHKMV0vf9XnwOnQR2D20fhzpB6Qlp3Awgc4LEDm7miu
 77/bmYdfgqZSe8dyI+6HaRNy01XLkw8ubuPdAiBTezA3aiGz/t2ljmahUeRtVTVzfyj9JUj1Rkv
 RfnvA423EkBOVI3EySFaoqSG/3W35BstaBjzY=
X-Received: by 2002:a05:622a:2299:b0:4f1:ba0b:90 with SMTP id
 d75a77b69052e-50dd5a91f78mr97758911cf.8.1775909460533; 
 Sat, 11 Apr 2026 05:11:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2299:b0:4f1:ba0b:90 with SMTP id
 d75a77b69052e-50dd5a91f78mr97758351cf.8.1775909460029; 
 Sat, 11 Apr 2026 05:11:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:26 +0300
Subject: [PATCH v2 06/21] drm/of: add helper to count data-lanes on a
 remote endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-6-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bq/ApaAu9Cba0NC2uhfLECwnb5KKZEMKi1G7RCOyYOE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpFtEH514oS6B6o1FC9Zcdoql1nj2N8uYHyI
 nbiRNU5PjWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RQAKCRCLPIo+Aiko
 1dahB/4yloTJ264Ag99K7uwm46uttgOjgWsKsCsqkXWtdhcPQTj/ynjNAQbI/sT1vhT2ZFtKP0i
 W9MEvdMEc2M8TpRXyAbCbtwMywfr8+wJv4RHWN3JHrppa3vT7SxKm8pr3N+N/3xLSx+fRoHbI+s
 MaEesitUe/TgtHA29UVd8bt4wgtaFBUBfF4l2ZxqnMre8maSj92zGmDcvWR8qsxqs8fGUeOaUsH
 u1oNNz2CEEYuqsT/xUuCeZtfapi6f4ARW41ivzbNMD3ycuwkhoAEzG6kUefGoaG1NWEcYwEIpPk
 fWXiJ5mOlkl8M4VIpMrbzD/Hj1Ii9EP9nDi8RwI/JMREJSsg
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 14LSAsbsU8zT0KdpdAWjUDZPhK6Yb9AH
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69da3a55 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=O3ifdCkKFGgQ8ueZnWQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 14LSAsbsU8zT0KdpdAWjUDZPhK6Yb9AH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX8fKOclPYza0A
 GOuMlkwQiUjHJCDLEkiicGaRxV7k4nP3sN2+at4mBy0x/hP9PLbT2wKon09IuXYh36sqE0OUlLy
 GG6hsWljFUjEfLqQcJhRySuswr741+TROyTxxpy4PwXJQWN1SMBX6R7oVfpxq+9hCcUsWYQj4Yn
 g/hrCKqqkWKQ+l5h/taEGzNHX8LIyFiY0mecWkLB82PbL286N7aQYFJtzLytfZF9Pfhah11tV0Q
 iGYa1x3/U5GHjkGqAeMSMo/4r0K859ZshLZ4hotNN6cBuMPfDN0wk2/fqFI7RxC+0q2Mr0N+jzq
 +Sxe+QOb3yWlUa8Nxcao+GrdPbdCu7sFK19y64561vksXvBbQDKlubC2l9+mV9KPTQtlNMoY0hA
 PNZOIeJFHbVWuQFz2ZZznp4tO9dLwqq8hsYg9sdqueApbb1wI7Jy4BZ/ktIRlHH9A1HB5DH6xUn
 kLlm1l7OMBHifBiVd6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

If the DSI panel supports versatile lanes configuration, its driver
might require determining the number of DSI data lanes, which is usually
specified on the DSI host side of the OF graph. Add new helper as a
pair to drm_of_get_data_lanes_count_ep() that lets callers determine
number of data-lanes on the remote side of the OF graph.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_of.c | 34 ++++++++++++++++++++++++++++++++++
 include/drm/drm_of.h     | 13 +++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 4f65ce729a47..ef6b09316963 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -558,6 +558,40 @@ int drm_of_get_data_lanes_count_ep(const struct device_node *port,
 }
 EXPORT_SYMBOL_GPL(drm_of_get_data_lanes_count_ep);
 
+/**
+ * drm_of_get_data_lanes_count_remote - Get DSI/(e)DP data lane count by endpoint
+ * @port: DT port node of the DSI/(e)DP source or sink
+ * @port_reg: identifier (value of reg property) of the parent port node
+ * @reg: identifier (value of reg property) of the endpoint node
+ * @min: minimum supported number of data lanes
+ * @max: maximum supported number of data lanes
+ *
+ * Count DT "data-lanes" property elements in the remote endpoint and check for
+ * validity.  This variant uses endpoint specifier.
+ *
+ * Return:
+ * * min..max - positive integer count of "data-lanes" elements
+ * * -EINVAL - the "data-lanes" property is unsupported
+ * * -ENODEV - the "data-lanes" property is missing
+ */
+int drm_of_get_data_lanes_count_remote(const struct device_node *port,
+				       int port_reg, int reg,
+				       const unsigned int min,
+				       const unsigned int max)
+{
+	struct device_node *endpoint, *remote;
+	int ret;
+
+	endpoint = of_graph_get_endpoint_by_regs(port, port_reg, reg);
+	remote = of_graph_get_remote_endpoint(endpoint);
+	of_node_put(endpoint);
+	ret = drm_of_get_data_lanes_count(remote, min, max);
+	of_node_put(remote);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_of_get_data_lanes_count_remote);
+
 #if IS_ENABLED(CONFIG_DRM_MIPI_DSI)
 
 /**
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index f2f2bf82eff9..7bcc0ccfe0f4 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -62,6 +62,10 @@ int drm_of_get_data_lanes_count_ep(const struct device_node *port,
 				   int port_reg, int reg,
 				   const unsigned int min,
 				   const unsigned int max);
+int drm_of_get_data_lanes_count_remote(const struct device_node *port,
+				       int port_reg, int reg,
+				       const unsigned int min,
+				       const unsigned int max);
 #else
 static inline uint32_t drm_of_crtc_port_mask(struct drm_device *dev,
 					  struct device_node *port)
@@ -140,6 +144,15 @@ drm_of_get_data_lanes_count_ep(const struct device_node *port,
 {
 	return -EINVAL;
 }
+
+static inline int
+drm_of_get_data_lanes_count_remote(const struct device_node *port,
+				   int port_reg, int reg,
+				   const unsigned int min,
+				   const unsigned int max)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_MIPI_DSI)

-- 
2.47.3

