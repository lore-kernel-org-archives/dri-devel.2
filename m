Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA166606A321
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsToAD7F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ClKn7TiA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440A910E5EC;
	Fri, 23 Oct 2026 08:13:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E8010E5EC
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F6gA1200748
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yT6jPp8HY5vKvIY0G2r/UqKlv2QeCR0DI5RlNnDypO8=; b=BsToAD7F4z6PT6ao
 Dbx6eAkp4dN+Uc09wNhoOpzDiJGaBcnQC79Fo1vA1+99onhGuNbP+145nIUsu5XP
 OribmwcCr5O4eG/uXwtBmuAOMnNprqyK6LYe1jALe2jE1KHaDDYpCEVnzseIqjcq
 hPL3JvIXLeE3cSQDjMrrVLOZbE/VXuwkTuWuHX+tOFyF/jqKzu0rxCcWUm3gs90+
 gytP95IctXyM9rGiw8r0QAjZBMbusbqI0X4fsBemAMPqKcd0StpKITNT6O87gzLW
 L08WW4LkTdS20l/AGAoyRvgNhAd3CuvX87QzY3mEbbSnlXXnW0XQI0eYOEroOa1J
 N2d9dg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms2mvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b994cb09fso14125756d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743218; x=1793348018;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yT6jPp8HY5vKvIY0G2r/UqKlv2QeCR0DI5RlNnDypO8=;
 b=ClKn7TiAEB9FSx4xqT/P2y6NFbalaq7bfWmUxyZUiuZDIDJpwfrUjLx5yzWATfCCrv
 qVJZoh8UQHHTEzRIu+tIChDR+y/WT7Kq0SjCCurQs+bgKtN9hl0xdyXDJXy9zX4PJmDa
 mzhm7dt+CV4rBe/RBfb0N73xALSMJb9MVBK/10iPeK+WUWC1mzDDwYgrgPWjgv88SqrC
 xDJqsncbMvvgXxCmLD4bseJs13OjqF/3qx0tAwFQj6pL2hTVIudSCJZFc7EspOFhr1X3
 VnewnB1LNayR7an6I2v7vAEam8aHzLroq1bqkFV2jixP2wxRdZCGRZkCrvPzpb3V0Ygd
 P45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743218; x=1793348018;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yT6jPp8HY5vKvIY0G2r/UqKlv2QeCR0DI5RlNnDypO8=;
 b=2YdEDwidx87nXNy/qFNMLCkMcFiGxM9qc5BbWQRz/9IiVfalA6jRuk54rI1aW2avL7
 ylKYUaW3K7/vJPU+It2JhUGeAuDMlAAEVLzv7svgoUHBRthXREA0jl0sW9UrkCpmzPaj
 qLXamFvFj690LgQgeNOegZQOYlfQDXdiJKRUErHnq98OR0ymsrpXvUqlCYdOfXurwUc1
 cDwR+Nf7xFwSJ+nH9+p1+3L1iIyWGqJoZY4aq/W1yS7OzJgUi6KtEgqyUnHTjKUcBZ9w
 t/mClSwMxCvuGUVuMSG8UmU/O42YSidH0U4qtF7C4sJpVX/5m3smisKS+3aRgYft1IPs
 xZRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1EOyZ7jYLflyRGlIE6OGzJuUZi1e97XAhzXhJesebytUcuGEDNb6gCrzmcRpeK3xZqMwK7MDBoaE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuSoptPau28dPZ2Y5E9V9jqSK+YPOgFzSdcFbnA7SXXhjuUzfT
 EGQ5QjcOzuSBGA0SKj4eTm/mliqauYKYLhGjFewBGpMLYrh1DiPw83mL7eTPfvAaOrM+ELlAVEr
 DEiYbvABYbo9OqcRKhJ85xpOwkzB3vvfO5uj5JfJgYzJWJPnO/TDy8oB3DVl+kN/RN8a6l84=
X-Gm-Gg: AYBFou02Jg6j0hBchUX/OLZjhN97O2KwYOb0Ni6kTRrdqzOxqTWjB31EmjLWbaQIwV5
 OrT0rmsjjn23BvKg5opPgTk/ClZnjSXkPBJ8s9fIsFAXQrG1DEYEVBy22H6gla4oWSBS00jkIHX
 H0YogRXqkJVaLUlMZg0g6w/hcdGmGCOVQcxZkfTUlfYTdTVmzrGQKJpcuDema6lkW3gd85Ryx5m
 OIhsdvuWZOvku09VhVp4vpVjb3UbpdVTQNr+uC3VqJ4fW79F8zfhGxZavc92hBI5L72dbStJ4Av
 6+Lnc+FpbPv0+vPO8gnrMqL9tPycZmoO+oHZ1HBMcDSVTmC+7q6bUlAjK8JEuKQqv2QC8LvHfRp
 XJDA/IAikbnvUjY40iK15nCIIAWMmBBlpYL5XrZ9dUSbigamalbq1Br3bv2AILA==
X-Received: by 2002:a05:6214:20a2:b0:91b:7601:342b with SMTP id
 6a1803df08f44-91c3ab0bd0emr18512236d6.49.1792743217870; 
 Fri, 23 Oct 2026 01:13:37 -0700 (PDT)
X-Received: by 2002:a05:6214:20a2:b0:91b:7601:342b with SMTP id
 6a1803df08f44-91c3ab0bd0emr18512016d6.49.1792743217328; 
 Fri, 23 Oct 2026 01:13:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c396af493sm14345626d6.9.2026.10.23.01.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:13:36 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:13:11 +0800
Subject: [PATCH v4 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm_gdsc2-v4-1-40b6a71d4e3f@oss.qualcomm.com>
References: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
In-Reply-To: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743200; l=9471;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=SyvO6c5OqZG1y5uyyTt/nacH1a0GGIXJnhjYmRYH77E=;
 b=2PDRPPGqQSheevFKzeSb+UFybjKNC1ZZC9UQkbAwkrEuU/MSUnsim2k59q/UHD+PD8WwLJb5i
 A3maWpNotevCJYdQUR/FBOISA+dcXa1WsZfrlTIpmH04l8YmlIURVPW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX+yLRybp+lkb4
 DahlI67yR3zRw2Esp51Xbcimnq6FhwZPaA4PUj/9Syl+/xqRm6+L7EoSh8/7Uz/eYSGg4nZcGdk
 aYHT+Rif2M0jRzLyNOeSPOXcTW/26RIvvxPemBJdAeFVI/Twf8d1by5Xegwt09ARv/50M6dPOQP
 TJ3EHvk+nL92Ix1MV5he7sbLtSkXPwQN06HNx/mR9pXjXREWa/jHe0RJctvH6Z8d6rVBIAmBVbw
 JlEo5tAgfEkqct6ROmzuIpluoEuD/QkdCijw8Xa8yytFbEM6bXcCsnapWMMzLSnlie3yt9u7nIa
 a5BG6MVYRR8JFm4VRQInQyjAyXsjvJbB06JhUN+FMThcb4MSVOVAaNnMEQf5ywZbuTeuH7XVdHl
 r7SqyqRT989XkJYkvd05/6MTwqGCqxfNQVey5EC6qHGa+iMB/dajGgbaUh4ihrVENz5ZXfg78KQ
 EFMc1sHFhBnzg1/mAUg==
X-Proofpoint-GUID: tB6AVYfTQEVTFKcRCC8GI88VzIX7YAxo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX0RxM+JAPS3xG
 B4QpLo4CBjpy+X+fLICmUnxkOu60P192S6AKhYlfIkWLVb5k3lTZepL7aUVO9KhVZs0FinJELuG
 nslqQStDMUmTQfFxAmp+xN9cyWMziMs=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb1732 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=3e6MG95HUu93SJj1PsAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: tB6AVYfTQEVTFKcRCC8GI88VzIX7YAxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032
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

Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
MDSS hardware and most of the DPU, while INT2 GDSC supplies the
VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
remain inaccessible.

Describe CORE and INT2 as power domains of the DPU device, matching
the hardware partitioning. INT2 only supplies DPU-local source pipes,
while CORE also remains attached to the parent MDSS device because it
supplies shared MDSS hardware. DPU performance-state votes on CORE are
propagated through the genpd hierarchy to its parent MMCX domain.

Keep the widest valid power-domain constraint in dpu-common.yaml and
narrow it in each platform-specific binding. Require two domains and
their names for Kaanapali, while retaining the existing single-domain
constraint for all other DPU platforms.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/dpu-common.yaml           |  3 ++-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 +++-
 .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 +++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 +++
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 +++
 .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 26 ++++++++++++++++++++++
 13 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
index 3f953aa5e694..c67199011f26 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
@@ -26,7 +26,8 @@ properties:
     maxItems: 1
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   operating-points-v2: true
   opp-table:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b1..6d6391970d6b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -125,7 +125,9 @@ examples:
 
             operating-points-v2 = <&mdp_opp_table>;
 
-            power-domains = <&rpmhpd RPMHPD_MMCX>;
+            power-domains = <&mdss_gdsc>,
+                            <&mdss_int2_gdsc>;
+            power-domain-names = "core", "int2";
 
             ports {
                 #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
index d5a64c8a921f..bded43a34b87 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,msm8998-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index 034d3df8d247..6c1476a0faaf 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -19,6 +19,9 @@ properties:
           - const: qcom,shikra-dpu
           - const: qcom,qcm2290-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index 8137618237ce..3fa0f02f4489 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -19,6 +19,9 @@ properties:
       - qcom,sm6350-dpu
       - qcom,sm6375-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index df9ec15ad6c3..7703d9b017cf 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -24,6 +24,9 @@ properties:
       - qcom,sm8450-dpu
       - qcom,sm8550-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
index a411126708b8..8e10f9e0d176 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sc8180x-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
index dc11fd421a27..9dafe1d827e1 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
@@ -17,6 +17,9 @@ properties:
       - qcom,sdm670-dpu
       - qcom,sdm845-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
index 510eb6c19364..173c2f034241 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sm6115-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: MDP register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
index 8cbf99f9fcba..b8344ff8895a 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
@@ -16,6 +16,9 @@ properties:
   compatible:
     const: qcom,sm6150-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
index c79b2d442800..8e50942f3e1f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sm7150-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
index a88d22f30a60..b407bc399462 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
@@ -17,6 +17,9 @@ properties:
       - qcom,sm8150-dpu
       - qcom,sm8250-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index aa0cf0ec5b93..7f8e52d52078 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -61,6 +61,32 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,kaanapali-dpu
+      required:
+        - compatible
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+
+        power-domain-names:
+          items:
+            - const: core
+            - const: int2
+
+      required:
+        - power-domain-names
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
+        power-domain-names: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

