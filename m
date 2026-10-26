Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BAB606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6jUNACE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fjyH8exI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE0410EBF7;
	Mon, 26 Oct 2026 06:25:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3810910EBEA
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:25:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4asUa3303634
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=; b=d6jUNACEdMZOAneb
 efc/lmRa0ouqmtZPn6+Lmoacckw5QKLPorWHW4OB6TWz/6dvAfcL4m1WDtfznd0/
 ICcLtZNS6b6JuiLKehMPapqK0XJsrbbmgRHvTAIwtvwZtP2wE1s4xTZ9ajwUCjkN
 YFWqESrQ7CIZ3WoQURT/1XMXMTOx8cm2OdPGdBFYnrROzceKLxgy4PjYxvaR+PAq
 ap0JCgeSelkq9r9Kx/mX8M1U4XV0z8HOiA0SSt+mnjbiexaAT0DpabYJ+4KEPVda
 cBrcqlp4m1v3mtoL7YbfppntANJNpzQFWBN4xBUjoIJslJriDxA+zLbfod2FcQZ2
 gBpCBA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsd5aq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:25:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so3930023a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995935; x=1793600735;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
 b=fjyH8exIUv9V/qxqZfHWJK5QcLopcxZtuejL1NTBhF9NBbJLSwmijLXxT1xboeaNJ8
 D7iI+LwEllh+SdqYYnZVAUH4EzSP6PP7PhpnNvDJNyxjhzU/OU+BoUDXOIlKV/E3TnRe
 JQE7S+HIf43ce8dKi0Xz2IHpCnNk3h6avMbEWk+nCVabZA7/o83dvhawbhnDOkMyP8ze
 rBoxn1hrQFFvifHDGAZoMHZOcYxC1PP5jBb/Z3FyxgirRXaRuZDG45J4ySnJ4VMQMJtS
 LdP4Gb6G3UAZiu3Y6JIvAIaRQjc3myYVxemXX+jrQ/yOO7A0/K7XRvOAAuDkpkebOAwF
 GjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995935; x=1793600735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
 b=fu99GLWYWE+0LElT0pRcp3ty+YCqqNhCnhs94iHKCtdUjW67m3RX1+wyqwOcAMjdI3
 OqBGGdCH9QlpGK5Ci3MWHcclM69KwL6CQ4SwQX1DfTSb9uS5YEl1WWGthyTGOIApnHcs
 HXBRZfPInEB1WgXsRy7+NN6URR0B3cyAcrs4WCo2/UtiO8VovNShRc4JV3mJ5BVyL4xh
 ixpFhhbtyb/xt51Kek2MsPYGk+Sg8ECSv87CI1gdF46vpyeQYk5IVGFQfaBQlnvZFG7v
 Lu9UTPP1tdYdexmfnXa1MCAQy6IhOiXShiPY6B4J8UuQDtWxrmS7fGmIuldymmv3iN9Q
 z15w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbMn5dx2uQbO5G1fpF9kAhdfI2DCTAdW+KllwRDHO4oa245FQh2l33Yq6l682UD/cV0E86fNM+LcA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLr0ev+C1bowsHLSr3kT5SqBWwe8dCY5z/pRTWYh7Ld4hp+bDoO
 NznZctDXXAfZ6YmLe2jM+cYuwSwKhVJs13fUMz1Hbf4wAV2RPtG9hA5j33laN2OO5zIXxgzKa8/
 U5nwxy/b7uWJm+CbMBqTYR+YLR4y0ZfsiwOQMfezeJCBPY/Yq28wQHT1dO2/XIgLRllok7jQ=
X-Gm-Gg: AYBFou28Ef3NNEHErY28K4mf26O7r7hrj9EbFGQc/h8ceddQYsDxGOjl1KaLePRrLbk
 5+iMz9fOp0xZScndCQHu74JZy/U41H/1xItdX/xaW0HYuVZif4DWFIvCfULUETIp0mHiBYWAeRF
 unWqgmFK4EMSgJuesOpbU8lqG1sIHvGvHxVfBwG5C6nYLC0d0IqZc8zm4eWkt7EtBKUDnSBgpMA
 zsZYkisJu6fUeQR/EWuR2cS0fqA2pziIp19MempKn/T0k2I02nBfuF7sTc/M0lARMPCRa5ASsa3
 dsFAcYy1eH4w/fwOC6UN+4bfdDCmdLJ2DI1tpUktWJbpvb6IBauBbELEcNHde3Yzlaf7mp62bd0
 EoK1ox3vZw8mOvaqFMdl+2aEbbzY1OSyMLg==
X-Received: by 2002:a17:903:1246:b0:2dd:9b53:f9ba with SMTP id
 d9443c01a7336-2ea9c03e626mr53707685ad.1.1792995935071; 
 Sun, 25 Oct 2026 23:25:35 -0700 (PDT)
X-Received: by 2002:a17:903:1246:b0:2dd:9b53:f9ba with SMTP id
 d9443c01a7336-2ea9c03e626mr53707485ad.1.1792995934668; 
 Sun, 25 Oct 2026 23:25:34 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:25:34 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:32 +0530
Subject: [PATCH v2 22/23] drm/msm: Register the DCP backend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=1867;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=DnOVMMMul1WJd1CWK5XVZuD8++FkNWwJHoR8dINot9c=;
 b=QG83X9aBE4jBa1DAS4wPcmTipRI+XMBqCLy0NmwgeS2ERiIBadYlckpX6pOlVddmoKAl5KzcE
 g7G+3CHykn2CWWGLoyNuBrJN0+MFb1zULSaZ+b7RPKVSseb+q1g9A9G
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: 5-pUL72Gdsj1V0OvJVsCpY6mxr0WhrIA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX85pHd/sHpWAW
 WHLQMwZZDK6NXRFe4+/Qpni+yGuK1rDXbdogTZeAWegdfnHQz7jqZ3vMJ70JVIva75PGw8A24kB
 mithweyTcPJJe9vHl7SBXGipyvP7CQGN1Nz6qgdKV07DZL7qzrZQyt1qOHfAgT3N72b47eOlds2
 TDx1NYVE7KqLApG1kRLzadADf1J3SSqHbahMzgfCTcCEe23jbIhSZnSl+s2s6S3PfzB2uDz+Otn
 iTCkTnQoP00HGEpSZKSWvj+Dc9DG7xBNge0qlOzymmR9OVTw1SrXWMZWbwWovHi/9iKewwscD5h
 JXeLM0d962rV1Ay2l8EtJqKvqKRV8lXdhZVmdV2ug1xDq6gySWCKB75U++0L65++ZZVL5fXfldf
 /4ixPAYnsEzLMnKCS3iKZG0qvQiJ6VBkecz0hxpQ/DlKQQYe5PjeVIrVtPvgiSkOqJsSpWfy1vp
 G59CCOVu+sZtWj40z5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXy3tM3dcZvpuQ
 XQ4kExClq/boB8Zf3SKUocDsCFEaMxMbqWoq70I7JjaP5B9QEvA1Cxz3FUJ/cwxQ7y80/w2B2yy
 qkkd9JB2B3Ers3bOuj0TXP9UitdSr08=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adef25f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=lVH-uUz8Z5eEn0x1YxIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5-pUL72Gdsj1V0OvJVsCpY6mxr0WhrIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025
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

The DCP platform driver provides an MSM KMS backend. Register it from the
MSM DRM driver init and exit paths so the VirtIO driver can use the backend
when the DCP function is discovered.

Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
disabled. This keeps backend registration consistent with the other MSM
display backends while allowing DCP support to remain optional.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 ++
 drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5816c64d7ce7..d413c361c442 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1208,6 +1208,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_mdp_register();
 	msm_dpu_register();
+	msm_dcp_register();
 	msm_dsi_register();
 	msm_hdmi_register();
 	msm_dp_register();
@@ -1229,6 +1230,7 @@ static void __exit msm_drm_unregister(void)
 	msm_dsi_unregister();
 	msm_mdp_unregister();
 	msm_dpu_unregister();
+	msm_dcp_unregister();
 }
 
 module_init(msm_drm_register);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index aa5dfd82ac6f..befaa9f2cb5c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
 static inline void msm_dpu_unregister(void) {}
 #endif
 
+#ifdef CONFIG_DRM_MSM_DCP
+void msm_dcp_register(void);
+void msm_dcp_unregister(void);
+#else
+static inline void msm_dcp_register(void) {}
+static inline void msm_dcp_unregister(void) {}
+#endif
+
 #ifdef CONFIG_DRM_MSM_MDSS
 void msm_mdss_register(void);
 void msm_mdss_unregister(void);

-- 
2.43.0

