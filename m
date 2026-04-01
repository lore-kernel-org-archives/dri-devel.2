Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6D0D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B149010EDE4;
	Wed,  1 Apr 2026 07:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HO2i+Brb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VN+/v3yc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 556C610EDBA
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316HZuq639212
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fp6DewLgWhkxTtOGAF8HtbyDZ+xvVZUBiujky/Sm5BA=; b=HO2i+BrbJS3aiPtj
 v4kPGZNKYHHM86EH38RuVw7cei4j+KVK6xNRer833xxTv2tlTElZSKpgU5sPejLM
 BDip6oXrnV1PlK75RYJp6ugchKetW7zmQXWq7WWw9yDBj75EFaSvcQ8nlzmicbyu
 QLwpltl59LvbAJoqGZUIQwfizh/BK+55T8sSDdHSEky4cM3TuGiOg/bnI570NV9o
 kqDnzVKejNQ+/I8cTI+CSQdBiBd0Nz/v29xbuu55PrDUqyTrXnLJLH6cAgHgUsif
 pqiAYs6MWezMRqVjscd1Mv/Ey7o4icaZjcmQeSJgy9PQIFT4E5fVE25FUCzHr8v4
 veB8QQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2auxdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b34223670so95435851cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028413; x=1775633213;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fp6DewLgWhkxTtOGAF8HtbyDZ+xvVZUBiujky/Sm5BA=;
 b=VN+/v3ycqQ5pu3bAcqXmN5r5FXWrEhS8zlSreF3+yJU4V4AdTAsKaeMMmpcAdaFsCr
 /kG1O0Opnh5LAsDfK4+rSQOEHnPpXrnjG1Cke8EVSEAIhcIlLMMZgAXXYIKOcylwQLgN
 KSgaYlat/aomD3LKvtPWX5Tpm606mD/Edxsqp3P92Df6Er6AoYMM9+J1ppuPxzW88L9j
 Z6Cxcs5mU2WEeoKytEppf18uqcfYLwRJEBGQe9j+IGOybvzwpCgidCqO8M5hLHQc8IcT
 A3Rk+PO9Vv258fJkkul3eSxOSqb3ow95NJR8Mldk5VBKVPBat4Hpr29zmKTrIFCyCR2C
 ozPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028413; x=1775633213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fp6DewLgWhkxTtOGAF8HtbyDZ+xvVZUBiujky/Sm5BA=;
 b=CpmwCpvM2TX7flChKW2oldwQJNS3oH0c916YOjYO18zibJ1RPgFvyL2hkHhNxoxW6U
 cnVfIulTaJvJnrlIzCkpHOr/DnzGNqSjx3qA0HFmo52EqWjhZtVfCnJAXKMOu5daHL4v
 GTvl7FVTOHgYdZuRkHXkuzOllYV1Fg/ur46CjMzttUFITIs0ffi3gnvxQaPiXnFrXCnL
 LF7y98J4Wu8p/k/coa9Jnr1JFdIv117rPhABo2mBcQrbjD+UxaCeWb9T/N8fJg05Xyiw
 Uk1jD85/36Ai0udkVleFFqhlailtEU2DkUq1A3VYuvYcErGQbXGNmJp44UihFi93wbTA
 h4Jg==
X-Gm-Message-State: AOJu0Yz0/9z0Hs3x7WQ8W+kJxt/0GD+8knkcFDh8oKgWpjVZ9ZnujIa2
 7nn5Zde53EemcM1F2m6o06I512Teq+oJ3ZOX3COx/ivAatVMbIgI5spC8upYASqeuAuDMJYzEqn
 V0lZeWTAZ9a5z+5rQsuYXy/foHey/mBMKRHq5k9spHrQdYyOqulbPXa0n1H5Z4yisc2mPZrQ=
X-Gm-Gg: ATEYQzxpsYiZlqiyYSyCJ252750Oc69JoIiFf3f31G0zO2nMf13mqK5rxWzkL9j+2Na
 3n5rwaCMimcMK3f/Hf1hs3/D2yi0/FHz0cTeP1Aqelvp02eZG1TGblIyJXBdEabvDmcK08KQD3y
 OUY523ge9wS086XADzz7ibOxjiX1nBVXYw8TAZHwzaDTg6dnbTHTeERnyqT1xCoKFeNABKVTXmi
 2TX8hdHu6FvE0Q58Xia0xZbVukXvOgCUYguyniwhd/yxaobn1CvS+cp9fJfn9ro3qWRV/tpfexX
 5w9DDICI+VRfvRj9pJU+fRew+j0Umj4XsuN8dwAIgrphiBPtnnkakGFV2XAHYa9TThHftcTCKNz
 PJ6iHLH/iAmC1G1AMQH7DB3pae4Sdg+4Zwb2PCf/ZDgXwdABT4rLvpaRjO8Hg/z6fJgGAdUEORy
 u9FgQjPzZyS6GQLfr1VdwMw/VICsI+Fr700Gg=
X-Received: by 2002:a05:622a:60c:b0:50b:3a6d:db64 with SMTP id
 d75a77b69052e-50d3bd40f98mr34192211cf.48.1775028413490; 
 Wed, 01 Apr 2026 00:26:53 -0700 (PDT)
X-Received: by 2002:a05:622a:60c:b0:50b:3a6d:db64 with SMTP id
 d75a77b69052e-50d3bd40f98mr34191931cf.48.1775028413026; 
 Wed, 01 Apr 2026 00:26:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:25 +0300
Subject: [PATCH 06/19] drm/of: add helper to count data-lanes on a remote
 endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-6-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3274;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HHcarmRqwtUT/YnQfaZxOlaXpKjrD/Y/4QHeex8uzNo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMirf/D5V8Y5hyL+Zg63UnoU5G3+GGFvPWTA3
 7U5rYhghZ2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqwAKCRCLPIo+Aiko
 1RVtB/4wGDo7gJsEJlTeeGYm6xCRzzyNAlOtSsGBTzAqQjHPPxemPBNkIIjpDpEz3WAVxdAhg9A
 z3CJpRTKg2RDGPZjsDcfkwEhklLBd+HYehWEO+wPo9AbfvKZA8sAW51n5xjPOHuoVtuc/sLzp+I
 S7V8xpBqtx+0B3QlWtjtT4wT+V3nM8h9gJ97rUPvUMnOpeutrDFhB3puaTciW2MnLmCaEHJfveV
 nuRAV3XJkr5oFj01gfqI08tlheFfBvnTt0HdEk+KLBZREem9VRaSYf+rk+ZnBa2Hdgm6yecZZ7h
 8ytRBoa6UKtwFtSYKd+y7TpqPuKaoroauh6BtknYEVstJS5Q
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfXwPW85oU4kXpm
 yViUjujFdyKy78m4lAiIPqnfuRmYpHEpFepC6D/AAL8tq6YDxw9U58yxakPNVtsMVnIQgSY/9tx
 dS1MCKjqrrqwhP2YEsftJAUhtSRQBKrr8zupYmfMxHXjDiO6w/Txy7Mt7vIungSEqvJOzQwS35B
 hVcIIku18skMM7rTwi57B5A/Rxxsax67kGp5XCZQWrADzskuo+WXMIwYrnn76ggvHiEsjdg301f
 YMt1ONG8vJ6xBB/jCR2otTrdW4Gmb93UPDvh9NU+cNam497kkTjEtYOO3pXgXDvj4KcjrErLewt
 YZdd53KSONXE8bEPBz2ro3PMB3rDiesv+LqizjNsLOVON3M4sm8LlX/kWbdnkfwnB+pM/+y0stJ
 XTvgDuuUP+DhoJ70D/qlcuwBdFku3T5CKm7k24zzjox6sdE2pzvzr2K/He4sLWGeZhtVoQHICNy
 RiReaeLF2EXf7s50fmw==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69ccc8be cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=O3ifdCkKFGgQ8ueZnWQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: utSgAfx6hFUhdQuk4Iac0jDP-WCDnF0U
X-Proofpoint-ORIG-GUID: utSgAfx6hFUhdQuk4Iac0jDP-WCDnF0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

