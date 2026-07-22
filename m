Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED97C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF36710EC82;
	Wed, 22 Jul 2026 06:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXm1Yfcs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i/n03eKg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5700410EC82
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M54J4M3769548
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s5GcuVSqx3TARTmxR3YrApkKUxojUC5YenbypcGMgm8=; b=GXm1YfcsRmTqE3rC
 aILbKPzSetOC6pvsAzmynIuuXw9OlyqPoIOUf9dtoEDfi+aHt9vp+3e+VFmpTHc/
 mUgiRBgCLqQIJugiJfALEhZ6P2QbzadQ8ZWU1szkp3Zxss1QM92X3PHwsJrQ3vNr
 v8zQzcdUyWvDiIDQA8WyOjM9t5YO5wUFL2WMtjqzUFXN/vjC9q+S9eHhUJU5fRO6
 XIOK0eUrEbVLj+tjA8aMqaKNLhvreclevqL50D8Azh5f0fSMCZDi2P9DUkZvyVCs
 r6/TBFMlKANjoSPuoKB3m+7Ek76CiUFXPK0TUcjMogXJAfXd7yZpdnch1X+zuj+q
 NATlhg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rnb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0408254aso128040611cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702253; x=1785307053;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s5GcuVSqx3TARTmxR3YrApkKUxojUC5YenbypcGMgm8=;
 b=i/n03eKg7HQCLVz9qQjga9HYURjyE+vbFNdQD74rEeHHtFUB4oZYN9TXRVZozYuoj+
 ngrlEJEIeqYzNMIUBgC88M+76do6uzlEbaBa/xJxL88Nd7TJJzuWnqi+3f8zsZ72/aOq
 O0negMC965SeSpDSuoxn3ovVxmL70oaBXc2a+Aqp9aL8TsiL9OHI7nGveWDOJe0PtQkq
 wihNNL+CWWV5+aGXlRQcIPLi0/h34WXce0xWQvfCZDgtlKRmW9R20YFCBo0TITsg0nZY
 mXmxncjyMTZ96SHAWu9mrr37S6Nl5rWDg+FJ6JUt0iN+df3L0xbO+n7Ic3zkU8k0prhK
 bPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702253; x=1785307053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s5GcuVSqx3TARTmxR3YrApkKUxojUC5YenbypcGMgm8=;
 b=X+Rr6QatBmsKscdCIq8s59zUUSPz3d2IF2LAhwNgyyfQrAblIRgcHW3/xUqaEFpo+H
 LnqHJfeWpdNdfySrccb2q77m3G78cE2uy6jqy/VIoKQEgivNYLyppx9ymZCbkQoLq7Xq
 eKjwoApSs7QH4NiJfVKEM9rL4V9KEGUIr5tHxUwMrJnii6Wc0gu0kgWpv/5NTA8026a9
 s4PLPP8yY0Sobao3+jISRIj2Z+Jx8piz1v3HhS642L3KfA+y3V7fEW6y9ge3RpNci2LN
 ClMskAFYOIZ3PKMAYkbcajvuqPT1ZLCRN3K8yPeaDYOn8SOOcCQamkPFJ1mCqP93q8qC
 nuew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqSz/sWQsjL+ufnNlaeVq1h8OSQh+EjkQ5TA/qaRwj9BVOKMMaXIfX524rULTguusF5UkLvXvLvy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIlhaXiMfFvuRWoyViS0RATSN/LM6rygaQqhPIrw1V+P5ygGnA
 7Os5vHE62J7dT4UmlEbElimOViSMC88+bHY2F7xN+H6apTbiLfdN0Rl1rlNWiZikFgGaYCmjpPM
 frMuKAn1QLS4JjqLvZtmUu89gIbIg6C79sY5EAT5hcUUQ+NhzE7I3BjC/vG3+l5Y0t+PFJD0=
X-Gm-Gg: AR+sD12NlFs2udaEyrBOyHembHYXviLevWpf9NCkoDJgOuUa2S84fhA3aCqcnP5IDDH
 i0YRAfiYQnYEYBpUjbv/HhxJq566OO2vbPbbSQMb23zUJjKVKlhj7gigU6cSAreyvEPa9Wo8yJT
 59QZFv+DVuRQULiJ2VaYHuxEUmZfRLda2vhz8dExAJB30Km5nJm5kMUKcXgUZYg96RBD/g6pf/1
 MFk3A37U6zNFBc+nFfNFT3A24xXqugp6PkldXZcucg5jEj0VYytHsawtqRb8vr8t4emnEF8cALl
 Z194QUDyV3x72gM5pNwarCQupcOy6phQ76T1ENj8XjtTyw572sGs1jLCmaTaWSLwSz2LsNQtyGA
 TgdIaRoL3d74i9OZpG9nW24zB0i4tIZU3T1GOP/6DCCpTi06UhjEsFs+ToV6X8+IdiH3rphEIz0
 R1QOmKx3aCjbpf6A==
X-Received: by 2002:a05:622a:296:b0:517:c582:9161 with SMTP id
 d75a77b69052e-527a5c0ed5dmr28362851cf.7.1784702252769; 
 Tue, 21 Jul 2026 23:37:32 -0700 (PDT)
X-Received: by 2002:a05:622a:296:b0:517:c582:9161 with SMTP id
 d75a77b69052e-527a5c0ed5dmr28362611cf.7.1784702252378; 
 Tue, 21 Jul 2026 23:37:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:36 +0300
Subject: [PATCH 21/24] drm/msm/dp: guard subconnector setup on the
 connector type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-21-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2550;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9/2o8KpXC7EG+vRWo0L9iXCJX0grbq1xFrlQ8yvb2cc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTpUgbAG+XcsMyqOlI37kJQzxzDNWXSDTLYv
 bxCpiezV66JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6QAKCRCLPIo+Aiko
 1QGGB/4w8HILPKpUQzeABwsNjmmVWbOg15aj3qwewGrfqofbXm0E2tKb3tVKsOCsG7v+DaBSTgz
 E35dLqPkiEAHhK/4mg4X3P2vxPpAloYItnJ7ecrofE133fJzft1hvxWP+MhKnwfrHo96ByF0Sbq
 LX2vsVRgNPrxG4tNvuIS6gp3tSzucv1orqKL8aPj6tSbCi4rT7pmqpyBATpDaGIRvRaUy1OuSEW
 NbPya+Cy7ssB9EJ5/VIXExfrLYOngNVhroCV0L3WU+QVDPVBUaK8t13XbRLr/ZpEZoJ86xcAsYn
 eaWfhzSh59icozOG5smoZvcMA4NAb1WsenQvJcawclpIt8JI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: FWkHUnpuAJoVqss24cuHtvnCZYOD3157
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60652d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=m6zLIIb-bBn14vORhpcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX9YD+I2m0O+QP
 XwS+3wxrgjtbtZoNyh0xCUtibzQ20OLPZsj0BbTIQof2JZQ9al5YTykPzO/1OQ6mYw0Z33b7Phu
 vM02iOX579kuld7ch5SsYvMRNSIsdyP55K8GSttIX5LOnRROYCo2hlc+wWeAkLAou+pQO1dFgQP
 Kr5TZzpc2ogcJLntbJW6RU93Gp7SVqpsjtd205S+k76nWPrIgUErrZVFHaE372cWzcfq7vfxyhU
 Ho5Mkjthf5B9GUBUwyaRXAdRcKdugXmKAftWGj/q3m0uskbNreSnO39kgzoprYa6+S3aQzgqvyD
 QSfW++wZHH0WyKMiiWNhBiq2SfVi2SckMh8yJuOPe0zlRXfdBLtNbIh9x8vY5DItnSA7brcDgE6
 gFZvxJvHNUgBo3XQ+UU8kniBlgKbvm7pIcN4i9jsIweuMDMeEYbxJqnmrM7E2FEpe4aZC4vde+f
 zt+mkDeVepkKs3QT7XQ==
X-Proofpoint-ORIG-GUID: FWkHUnpuAJoVqss24cuHtvnCZYOD3157
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXyMmuzi/ec7HH
 vRpNZx2SzlAr19d+xajOF+23n+daEWen4kqPQPMcX+TVI1ixUcAm0XbD07geig68tKL1d9JVuSy
 bV8bM6qluyUhwaIr6aUPNLmiic5O2uw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

The DP subconnector property only applies to full DisplayPort outputs.
This was expressed as "!is_edp", which infers the property's
applicability indirectly from the port flavour rather than from the
connector it is attached to. Besides eDP, that is also wrong for an
HDMI output driven by the DP controller through a DP-to-HDMI bridge:
such a sink is not eDP either, so it would be handed a DP subconnector
property it should never get.

Key the DP subconnector calls off the connector type directly
(DRM_MODE_CONNECTOR_DisplayPort) instead. This ties the decision to the
object the property lives on and correctly covers both cases, skipping
eDP as well as HDMI (via a DP-to-HDMI bridge) outputs.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 drivers/gpu/drm/msm/dp/dp_drm.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3397a3a47ef3..4f6da636f7c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -295,7 +295,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	msm_dp_link_process_request(dp->link);
 
-	if (!dp->msm_dp_display.is_edp)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
 		drm_dp_set_subconnector_property(connector,
 						 connector_status_connected,
 						 dp->panel->dpcd,
@@ -477,7 +477,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	 * We don't need separate work for disconnect as
 	 * connect/attention interrupts are disabled
 	 */
-	if (!dp->msm_dp_display.is_edp)
+	if (dp->msm_dp_display.connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
 		drm_dp_set_subconnector_property(dp->msm_dp_display.connector,
 						 connector_status_disconnected,
 						 dp->panel->dpcd,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 6b55753da0f7..00653b0364dc 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -323,7 +323,7 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
 	if (IS_ERR(connector))
 		return connector;
 
-	if (!msm_dp_display->is_edp)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
 		drm_connector_attach_dp_subconnector_property(connector);
 
 	return connector;

-- 
2.47.3

