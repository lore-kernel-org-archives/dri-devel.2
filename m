Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B2F34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2932710E496;
	Mon, 13 Apr 2026 14:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQQ/bH3y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COqlqLeE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21A210E495
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DCZIv13989851
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GER20aNRyZAzUKwcjDT9x/OFiH7hEb7KOqKA2FbdkL0=; b=fQQ/bH3ye3psNQw1
 4KQ13lxs8CCzZjFxE8jYCe82EMLhjFHpyBbnNwEjV/vo0+tu5JzzQWKG+R+3PGdk
 XkZZs7P00lK3iKj9I4AJRsZnMXN1wFTh2qarn7BgFXDZ+sSC5JZZk57BghnkBWJB
 mVSqKxnPZxBg2VHqGa9vUfep+A3n+pxJcQ3xOXaBi3JmbmaalkCVPZ45sRz4aP7K
 c5QA3M6btcGe1U94s8jymR6Pyitr4J8ZH6zidpruCkuUMLWM8q9jPZfn7F3NJTzS
 niWmPLGL1JS6TdJFD0yMqmlW/SQ5Ng69r/5hWAhsF5Eyoga1Y3dBk98rsvtl68oK
 skuiSw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh0mfrcgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:45 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-41c08879ba3so7121283fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089145; x=1776693945;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GER20aNRyZAzUKwcjDT9x/OFiH7hEb7KOqKA2FbdkL0=;
 b=COqlqLeE5iOmR8i5XQIfAKFRPO6l/fkjGlBVGGZSQgaT75jVjil/AdHCHmlrKdSy92
 meIpJkdWJOMcPhoO1PYbtb5w14/W609qiYR9cD8O2SNGKx9yiPqvq86eUp5LI2420g91
 8bibF/wOS4aPMY9LtPKwktpMvu5WATsE/pAL3ftHO7IIzq+NjuosOAYU12G5t+eHdCKA
 VYmnQE58qaz3Ac8ZF6oKI5t41aw6TFoa3wA+KeIV6NlOmaNIjpI8bSLn67ACBX/guexm
 nlZEvHl2yZJqs7iErQVENqPZrjMYkIkBatgvXFyBTeRCseYxgvoV5fVT1RQUeE3u/KuH
 5Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089145; x=1776693945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GER20aNRyZAzUKwcjDT9x/OFiH7hEb7KOqKA2FbdkL0=;
 b=YAgkuMNASDuAffhJOp2WHw4J3B2DTCmitHwVszN7jkVSGA4mRxoOsPInbhtiU+5lll
 PQJ383v8j+o6JXISLoDzx+T2SBGVnYdawKWjPlIwTsB/xROQLQ/I6ApWH1Fr2LEMVrr9
 Zv//Dp7R7muoCaiy14fgaIV5s8J2uglE/DCG7K/HWU4cA5PF88bmdK9p7ahB0dtZCVDL
 u1f632L6C6uhJH51ZZE7I+drsrdx4Le3q/IPHMu6PcR3CVoolk+lt2Z6tgyZr1JO0dXt
 ElwLvDxDfmMF3R7PuTH89TxYnGKR8X1MHcoB7ftZ7i7SSwqNqQBFkh4zPQt9BhwzQl1v
 Yvdw==
X-Gm-Message-State: AOJu0YycMruH6UQfleyDTdEw3z4dAZE7KGKOHn3PVHZhAjIln0GgZA4X
 KGeYNwNVJVKxOl3lkYNeBs2++0v3jX0f1AGUpLMA39Ac6nxRmyEO44jzrhQcWyoDuULfkRO5JIh
 vJETLifqAgVATtei7DE/JllO+L/e9KP47Qpz1q6REKppyMXGrrM7jY5gbxtCXrI96ipyKMl0=
X-Gm-Gg: AeBDieuAdcJ/4LRkmPO51FsQlOVNO4FG/+p5Mpb9mEdqoqadWl2c1Bgcvq2yXaCbpWk
 az9DM7xqT6z/+4lMA2UU29Jbhvsl7XICx/A8emYsLcX0y1IPDOf1dN2pnZhhp3PvcgupL+B4qoY
 eXhdSzqylibD2RXNCuztabrz/1W05wGGeESUFSoeEez02hSQxBsRJuzY37WrE+B7jrJ2IGHUQ55
 tga0m0aqVRs2KYwMHegBZw3mMITYGcRix+EIzeQbenyGs5XcgdRHJw2xxaCOnudzFY0Hu55WKzL
 +L4e7d/DjtOP4JTNUCx82D2WVwQFQMrQE8GfVZsyPGyGr34dGZNGdRY5bMi8wrcofbnG95R1InK
 7Te5i1YfhGDG89eWUd3ZFcF2gofkUxLxYLwOfcR8Yq8zYDe/HZq5w3uCZ+jcPceOE/MNN5CMlwf
 H0/VJdfQpEOP3uUc/7XrXAJ81TbrvOIoNM7lw=
X-Received: by 2002:a4a:e75a:0:b0:683:121c:5aa with SMTP id
 006d021491bc7-68a68c658b4mr5989922eaf.10.1776089144763; 
 Mon, 13 Apr 2026 07:05:44 -0700 (PDT)
X-Received: by 2002:a4a:e75a:0:b0:683:121c:5aa with SMTP id
 006d021491bc7-68a68c658b4mr5989901eaf.10.1776089143843; 
 Mon, 13 Apr 2026 07:05:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:29 +0300
Subject: [PATCH v3 06/21] drm/of: add helper to count data-lanes on a
 remote endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-6-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bq/ApaAu9Cba0NC2uhfLECwnb5KKZEMKi1G7RCOyYOE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3Pgn/KFfGhQShasaHa6RZpRh36xAil8iwYTaF
 PURzX5YSwSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JwAKCRCLPIo+Aiko
 1fDFB/9EesztfHAvYdUmud1fJO8CCtfNhvEOQ3kNwUvIqdraNNcQIOwG+H7kHh0yg20MWC6Jn+8
 FqoQJDs5Co3bpIo8ZwJ4IDnYK/kCqqtZjzlYd9zRgILKvL3icL64LlBLD9gDewH4sYKkwFTtWQc
 fSbO8HHfaTxY8VdvALi5Fzn+OGQvs/mSJnTyTiNVMNpPghzRBG27oiM8IHtiZ6aEHzU49y2X/kH
 s7UlKDnMqPAnxmpYfHnOIpArkvJua6TULsf9kClMopHCdaET8FSNnwmMQoXT7Mzh8WndcaFk/gi
 YO+8mpPk9sCX+978OKLV0XocfLnJh9Q4fsX0TakkWLQe4jXS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: pmRbiAnfl946ACylImt_ExAjlzoz75Xh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX6jgh1s7aObVR
 emazV0xene/pBlKeFEbs5ckk8wYAdoz6pons5b10vAsK0yfMrbpXtb2AEME9YRq29GKGYQr5qkH
 frKPTEE066CV+/sp3+5oJ+YtfGmqCIJB3it1nHWaamE1iVXOD0CLIrgRODOEVs8kmEFKEtE5NJ1
 ILoEsFW4XYFNkXB+z4CDyjZl6LnQwM+whbpD42JMDYRUVXKBPlI4etfrY9ZTknUqxbPEh01kWiJ
 NkUzAM3apFUE+VfslTnzF7u+HHyPXXjy3B+QRQq3lrRN5EZ+wSSTJmuXg668VgeL6iPDgL8SdUl
 saG5iC6LBAukDBqRcDUR6gTgY1AxapLa223IIbpBFtVnWp1D1EtQUoWJsIdut4Cqop9JjPMKHjm
 UG8u0+TUw9yHRq7uapyk+n+dVkBmAxUbeGUxjYV1OxxHNFRlkfesAA377ZfD9rdWNpquIGA7elk
 1wGXNYzWOfpk8GJj8EA==
X-Authority-Analysis: v=2.4 cv=cMvQdFeN c=1 sm=1 tr=0 ts=69dcf839 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=O3ifdCkKFGgQ8ueZnWQA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: pmRbiAnfl946ACylImt_ExAjlzoz75Xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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

