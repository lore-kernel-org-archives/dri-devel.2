Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F43C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF66C10ECBE;
	Tue, 29 Sep 2026 04:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pu4yzoOI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idNJs2XV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1FE10ECBD
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47jJa4053026
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0dzBLWpivrUI4Nat3yuVRNItbUI8yEZDWAO6tGswt/E=; b=Pu4yzoOIH3/Ae7rt
 YaO7pkWAeS2mRSTUkhjGLRtrRjPSa6EsuRzj45nkv3BeIxp+ZQxj3C8tHX/KoxfW
 6upNeE1TDCEqkT88r6Wh1cphTT0EqTZhbzTlhO4H5IOTZvoEThueAejd1lIspe+5
 UjnxpjRp/gLwKah3aDzUqSA46Vz1g3ui9ntSCN+jo7GNXd4AdPJvG/8SZg9Diqks
 xTqLF9fu38xbj3qB+4PMDAgPbO/KjoaFYrFuh/Hy8YeB0ahji5W2FmOMapibxQ0G
 WZUzadqR+XJCtfDerQDhFRjmvbW0H06TUk9IrNgeXbVf4Mv1JLuLJBv0y0DVSE2e
 worTyw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9143cb073b9so68846706d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656110; x=1791260910;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0dzBLWpivrUI4Nat3yuVRNItbUI8yEZDWAO6tGswt/E=;
 b=idNJs2XVil++niOS/A+mjdjoSM5O8QcA/wawoITrAFLfQ3z8IP9JQbQOb/d4rkWZci
 XGqROKXgvJYPPKERwaXgZXDsgErJAHaZQfWxpwVBEK/11ru0BgD+s9JtXL42JxuE0RcV
 YbhJVWgZqnkV3D9F0ZdNeR8Xn4YrUHZeCW7f0KiN3yFHrokPudQlACRHbTl0q98wGq7Z
 TfFf9bjR3EGLimMoRN8N/6CcIYroESzhOrbg1nZ1Y7YC2CePu8PShq10BVFAuVcHMc0e
 1ek9NT1h9wzwqiV4y9nDSa9vgTLdXGCsUP5hdkR7N18lj6F8B2fYncVez4/6I54SVxkF
 iypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656110; x=1791260910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0dzBLWpivrUI4Nat3yuVRNItbUI8yEZDWAO6tGswt/E=;
 b=ohsP1yJEIvt69z6pkVxGKksN2QNT2rfrKowKCcZckhVrA8o8tAvVFgZrNxFd/Q+VNm
 WNAVrY/vdz9Ysdv+NDgQ3rnUXBWjsI2JTgdWb6bcWRerYy5B6+ztmYmntVAtI6sBJEaH
 LZKXiJvSnp2JEtwNVJ73oZ+KiEMDBnS6o2n9fBeh1ReGFPnxp7ZB6UERdyMMfx0LND3h
 sDDYEPWR76NWUVcewm+BE7aOkLGNiXkfOg7Bas12q6qq7ZmR4ByX08+4IJHNZ1F7MzXv
 2ABZLs/X64d99L/FqqRxSX9E+u9Bau7V9FdF7u6T+vCbHFIZ48yBp3JcASCPS8T0XRG1
 nfxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVVgDroNIKCEb+JBBf9WUkjwpq+xCzhqDOQT5MdJO9nFICTJBmLZeNArJTb93Jmx2F0AWj8aHGGPk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQ7dRcwbeNgP7iZvDjsOIhgzYkkFwaBphu5JkwwGQ0ggB9whp2
 lHQT6LqNYaSsY7l4/RvyWb9UxS9Dg+eGYsgXxJ3X2YhKjLnka3wTKSJPjl+Z+iReGN+I+ArSU10
 VsuEUPOndvnD2yYqZnerQwsmn3vF3c+pm363T+2dYfPg5N45Ol0Y6sg1j/FsGOzOredQcywk=
X-Gm-Gg: AYBFou0trerosD/52ISNcPlrYufrf535DIDzOn/Pp/jXCTcAWipZsOfAvDrWqOBp8ex
 XyR0ZPfBiaGjL9FbZAKHED+SnxgqyYf7o924NVgiMqlipIOuyg5+QJd7Lk7XWBHexoDXn3Fhc+j
 LEwmrefFeECBc4aIWAcEpsrMu8QJwBgZAnvi3nDbOXc+8/gFgRzwcb9qqo9NNCFZAcaBG62Y+m0
 cl+vLq5hQqqaiK/nm9zbI4ZQXKbKC9bE8IFXoqmRMl8xMsVbJyvX4+L0LwqF9XT30Es/jIPklhQ
 XaX5joeNyyTG0a4WMi1VeQTNq55SsJWKksWOgoQZaTw1Wd9mMa4vgkBQB8tQHDUzE2H0ZcyZz4S
 pBIe2xgrBnP/QLgwSYmbo4koHqSG9haq9mva5+hqZlRYJAvpl/WeIvvun6YbC9Wk=
X-Received: by 2002:a05:6214:320e:b0:912:428a:8bb2 with SMTP id
 6a1803df08f44-9142f6d304emr237397946d6.19.1790656109695; 
 Mon, 28 Sep 2026 21:28:29 -0700 (PDT)
X-Received: by 2002:a05:6214:320e:b0:912:428a:8bb2 with SMTP id
 6a1803df08f44-9142f6d304emr237397736d6.19.1790656109291; 
 Mon, 28 Sep 2026 21:28:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:50 +0800
Subject: [PATCH v7 26/35] drm/bridge_connector: avoid detect-based HPD
 notifications for DisplayPort
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-26-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1983;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=QDRjR0asQ+YszALPwhIKnWinzSmuIA+ky2juuKuHgt0=;
 b=5qG1cU4igksDXTaXfGOMIAkfLQ1z4WDvVMcOfTgjJbAKEvekS5EmNUyA8aXUh5jFckSUlLJTl
 1MrVKLGbXJMA+HHiKoaJXNLPCRDJqlNjNc6RQvwZRxcIq+NYe/fxcZV
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXxSbdfZdwhwog
 EYZY8pTiqrYGYQOA9QYx4dGX2wDxM4y03PryTuZ0PWG6ehAj2hUdP5+g4j9dYKqDcqX7XHDFMXt
 1qB77uyu8Tujqpw2X2WPwrXNT59Xmsk=
X-Proofpoint-GUID: Lf-XrSCBYGSe7NEoFBJpRW4Rke_W_zgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX582+pfmWHTmj
 Oxad1bhJn+2c0s4oEM0eLYPs570LB+lG/P827+01+0S5BVEuSfEPXhW/5rTawzwvEZyXgETMX9a
 2TSl722B1zSFCi9ntzTYh+5aN9heoVNi+IlPitiGfj5GY3HD78c7OzGBAbgC1ey4XhBngAGaAmC
 oVgbD5wcxKI18Y4HvmJ295gGO+5qsew1MW/dzs0YwXScAUo2S5GVMylzc6E2wavQXkDgmce9+4P
 9+fN9cg4sNu+NALbn5u5sHC93D6hX1VJd9p1fVW6eqe1HENDaGgqhir/narDLMZ/dcugXFen6m4
 2fa21LBq9CY18SFdpRjES/oNiOXe/7JoMOpi6vwfEy5LsRxcrkwcvegazjDbZ1OOLg3Z2w8hyrG
 ZH3wlITPDqVcNIWQX05agrB4xp3ee0Jld0BgbMRybwKCpkT41Pm/ufspLLDhfUDpyutwIKa05qa
 qYtj/QcWa2sMr2qpPrw==
X-Proofpoint-ORIG-GUID: Lf-XrSCBYGSe7NEoFBJpRW4Rke_W_zgR
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e6e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=c5AeteMbgwRpADRefSEA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

When MST is active, the SST connector reports disconnected even though
the physical DP link is still connected. drm_bridge_connector_detect()
forwards this result to the bridge chain as an HPD notification.

On MSM DP, this notification invokes unplug handling and tears down the
active link and MST topology while the cable is still plugged in.

For DisplayPort connectors with an HPD source, stop notifying the bridge
chain from the detect path. Plug, unplug and IRQ_HPD notifications remain
handled through the existing HPD event path.

Preserve detect-based notifications for other connector types and for
DisplayPort connectors without an HPD source.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index d27ce59ca32b..8221a32d00f2 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -240,7 +240,16 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 		if (hdmi)
 			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
 
-		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+		/*
+		 * A DP SST connector can report disconnected while MST is active.
+		 * Use the HPD event path to notify its bridges, rather than turning
+		 * that detect result into an unplug event. Preserve detect-based
+		 * notifications for other connector types and DP without HPD.
+		 */
+		if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort ||
+		    !bridge_connector->bridge_hpd)
+			drm_bridge_connector_hpd_notify(connector, status,
+							DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else {
 		switch (connector->connector_type) {
 		case DRM_MODE_CONNECTOR_DPI:

-- 
2.43.0

