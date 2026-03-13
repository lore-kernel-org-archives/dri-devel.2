Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30EC106FD9D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22FB410E05C;
	Fri, 13 Mar 2026 08:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJD444aV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NB36qmEP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA9510E05C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:21:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5thhk070734
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zVgkF3qUxj8TKLaQX0IRF8
 n9GQ171XB8SlvlnnEmIDo=; b=GJD444aV0asOsTy5B6YBihuhvJ2BAUQj2O1fLM
 5FAQ1m4hWpu1f3pX4viursOJDZnNWQnMZhB+3semZVlLsOOo4DzRk6ANIXjzCpLJ
 y5mYi9V3cAG+/RpRChKb6qs9Q/J86lXAobuyzbGM94boQN0kLL2EWz/Uta76GXDA
 ixUsLpPLCocqrBNfVZUbWoLwRyDaZkd/3YawmCfhCL1N6YCOgIhyaTJx11cDMKtc
 zi/bhWyAExc+bcgbs2QH7S1ENwUeGW5z/Gwwc9E8tF+k1HvuJKmd+ZB3E2garjgW
 8CkbK1/WM111LBL6du05BMKXCzl8pGUXLkVFTwmMtqwtjvFg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4yn7e1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:21:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8950562d351so41557866d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773390063; x=1773994863;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zVgkF3qUxj8TKLaQX0IRF8n9GQ171XB8SlvlnnEmIDo=;
 b=NB36qmEPDT4lOVbE6u0X2CI/ck0Zl1Vq6PJLjxKk3QfEoAKdmgAvPjTdFb/wO/LLcf
 zgbQE6R3pyukoLbgvs5du5+DQABeE2YYwsJAFx5G6tOKVnzlJ5/CewEYbbMVP+zFiKdS
 S0FYqa1EeIrZOmWiWXgTR5Ls8rfXkSFipS69D1D0QK/Dy15vatbMw83UyZl9Qd3QjDFG
 KqSK96hIypasU9RsrwiGwLRxFOCsuPJUysBKfgYJa2ssj3SZxk14nC1V64HRs2Xg5r+i
 zSasD7Rgbbe+mZt3RwmswnqeHxpmWWB5yOL8kdrBWNpdIAzMnhGlswXooFtJgsHUtOZC
 3Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773390063; x=1773994863;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVgkF3qUxj8TKLaQX0IRF8n9GQ171XB8SlvlnnEmIDo=;
 b=iQ0+mafRLg4IIjWMbH3feJjQvAHr9fNvhADOPNv+VRrUuhb3BPfRBmV/hKNqUuRz/4
 1wWoIAtU1O9go6PQJrP7KkNxOAMyVz6U/nW3U/GIMLNH18O8yTEVTyuIBPXBYBIVkam0
 MkESUlctHVMJrNsnJJAp2WUgVmD5Uk2GpLtZmjLMP12PerIwucEzmtJkYNY6kXjuIjxg
 ASl74lTbV1AvjGCG/Dm8BQhqa/MYhPgEUi2QfN/jrf1B4qpqemGMH4YEDY1F0sLQtbuK
 g4NdPkUDZS3c78G7qTGVdIBiH9qNzp2g/s83cA0EEHjMvPVAYqczvYS0uqzOIgYxhfYi
 hghA==
X-Gm-Message-State: AOJu0YwQiRXCVjvBNgu7sEknIA1AjI/66iIaspX7z8CwWjMeXAi1xzW9
 tUO8VL0fp9gad+4mVWh3Oq3vVjz1lP9Hf6IWtnlm2BoWS7tG6CQRLrQJufE1FhRcfDARAOC6uQX
 QlO0T7+0dI+Z5KsfkK+WBFuRQEIF60uIzcPdTsozQh96MMK7xiNTmntovoc938mhaj8ju5wk=
X-Gm-Gg: ATEYQzwQFy5Fc0BO4KNcJAZ9+ff5WRhwBGKOUVdu35xvOUTEpJviSK2LGBhVxqcf3fG
 nurT+YUIQ+sN6FNRuNpB3TeUOWf75FW5VbVJ5i0RIT/n5zK9SiAqCyZjwiqNg9igv+G/RwZMtmE
 17SmmNZiu6BGSCS6LrQUHQ3svC3JG7aeo/5xvYYdoiMYWCXzYL38glq3BIHRuFayUb+xtWZLKZ0
 /FDxxD5xhL0xgM61TdfRV2h01uzQuaP64Me7UVI+r0HB812f4fy7dS+5L96fWPNY3H+E6glJzGQ
 fR/gTXHaj8ywXKbpQNzsuJzMQFWS5KC1Ov1natFCTgS0SvE2ogKcdeXPEIn6ukmbutk8ktmx8iC
 YdENJLHvu8UgdNhfbd3bm/pDLSkOTvjYNFuqQS3L5tuNV
X-Received: by 2002:a05:620a:469e:b0:8cd:96e5:f7c5 with SMTP id
 af79cd13be357-8cdb5bc7f66mr325181185a.70.1773390062672; 
 Fri, 13 Mar 2026 01:21:02 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:8cd:96e5:f7c5 with SMTP id
 af79cd13be357-8cdb5bc7f66mr325178685a.70.1773390062184; 
 Fri, 13 Mar 2026 01:21:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22529csm14481320f8f.31.2026.03.13.01.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 01:21:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 09:20:54 +0100
Subject: [PATCH v2] dt-bindings: display: panel: Align style of "true"
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-dt-bindings-display-panel-clean-v2-1-d49615218f92@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOXIs2kC/42NQQqDMBBFryJZdyRGsNJV71FcpM5EB2JiM1Yq4
 t2beoJuPry/eG9XQolJ1K3YVaKVhWPIYC6F6kcbBgLGzMpo0+haN4ALPDkgh0EAWWZvN5htIA+
 9JxugRsSWdHslZ1S2zIkcf87Co8s8siwxbWdwrX7v/+61Ag21bhtCW5Gz7h5Fytfb+j5OU5lHd
 cdxfAGfho/g1QAAAA==
X-Change-ID: 20260306-dt-bindings-display-panel-clean-3ddd8e087ef2
To: Artur Weber <aweber.kernel@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8672;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=g7L1WllfMIyTsb96Mdes/FnTILe3dasa8QoibMXIUSo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBps8jok2siRiUEMA/j4PdlKEEYSO34ubztNzdln
 2Wv+VPCDfSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCabPI6AAKCRDBN2bmhouD
 10L9D/9P/K1TxPTn0K9RGVYtBJiffvFCtfkKDLqlltkFpM71JLuyNv33aNpd8s8g0pESgE/BozQ
 X4OHnxjiyJIR/raYYYz99L5CttyOZb9RnyL/BfGPPlHsH+OEefFmhLT9vZJZIMuxPpwh7fTBBqp
 4rOuhRzuPfSGfolj0jZrc9yM54T7P/9ze3qmkXp/coCjVaD0r2O2SUIeNnALEtlKW9AP5tt+Hg8
 i/u7XBTJ5/IL8BHHCqmOVOiQrNVNL216R+c4xI0Fhjb++KzCQ1/U6K02DFW44IsyykSGJTsNPN0
 Fx99d12pjCRtJ+xhcv4u2MbMqgYNrivUPnqGEOuK4nAC7oToSve5wQb3pSBAYSNm/uagf/ZakO/
 3MT3apPPi2rQOLIBkSqQIuNwLNNMhvlzHMtsrK3kmX5YZgbbA63NKrpY5nmKrNF6hwsD8cYzkkg
 hI4sDX+K2fre/7qwPUSndQwgCopczKfUf1+tC6G4lLR5TBnbMEJECNZEuEacbDWkC4IWeF4Fzak
 xOmKdZfvNBNiguCB7SDfHc2MEbfRH3c054u0wbYjR10sVc6nNWbGGWixrwn7gL35expJxogj4I+
 8UfZeVsgHxtzm8Lo7P7WsJl2JYxWn6PqBPYlVC2cLfrW7+d07VPPqwE3tljCcCDlsxbQCLVYvVC
 wTbkVzIPLKjyAKQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2NCBTYWx0ZWRfX/7OQFf3PBxKa
 XcB58NfUUzXDv6uzfA2O8MINOQ5hY59TZI5WQglwZ+NngzOvuAP4RSmFuTncbQYEgXBOFHeQ6Xl
 y30WAKothDvFW+YDidmtjyysdM+9AjQv8n4A6bX00RxMiVQmRsVRuLkjwzGHYH1OuQ/IbXQ/sSQ
 2yV4T3pfqmvZJxDWD2NdHgvDIDhIxuxiJVMXH8hJxSQXK6M/s6mLwQjVGo3GMz0c+pyxFCpicxW
 XZIMGz0APGzwbHhbRdbirVQD1B/FuywzyAM8Mceb5tYbSsPJRmg5NL8FAy5opEjqnvyiQ8qtPsF
 Vr5m1S1VLAkdtinfjwHcWxV22Hv+LIfHgSi0bZY31I5rOfudyIFeMeP7fLIimmSQHWPDYFLYPyI
 K++gFDCfVDllx/voowMIoca7hItgiUFR+t9RUDNf/Ccu2Zp2fyNc3vHQuGSdB6CvjJUrK7+tNx3
 vp9dz8p0DCw3cxnGw/Q==
X-Proofpoint-ORIG-GUID: kormqsnHuDSGSkVh1YyXfmSAUk6MCC_k
X-Authority-Analysis: v=2.4 cv=C+7kCAP+ c=1 sm=1 tr=0 ts=69b3c8ef cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=y7DYbA0_Xfvc-Urf_C0A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kormqsnHuDSGSkVh1YyXfmSAUk6MCC_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130064
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

For code readability, several bindings which list allowed properties
with ": true" syntax group them in one place, without line breaks
between each.  Align a few bindings to match this style.  No functional
impact.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
- Drop applied patches 1-4
- Rebase (jadard,jd9365da-h3.yaml change is gone)
- Link to v1: https://patch.msgid.link/20260306-dt-bindings-display-panel-clean-v1-0-3086eda1efaf@oss.qualcomm.com

BR,
Krzysztof
---
 .../devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml | 1 -
 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml  | 3 ---
 .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml    | 1 +
 .../devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml    | 1 +
 .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml    | 5 ++---
 .../devicetree/bindings/display/panel/novatek,nt35510.yaml         | 3 ++-
 .../devicetree/bindings/display/panel/renesas,r61307.yaml          | 3 +--
 .../devicetree/bindings/display/panel/renesas,r69328.yaml          | 1 -
 .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml    | 5 ++---
 .../bindings/display/panel/sony,tulip-truly-nt35521.yaml           | 2 --
 .../devicetree/bindings/display/panel/startek,kd070fhfid015.yaml   | 7 ++-----
 11 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
index 92df69e80a82..f288fa2390c9 100644
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -28,7 +28,6 @@ properties:
 
   port: true
   reset-gpios: true
-
   backlight: true
 
 required:
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 182a2b825e1c..84e840e0224f 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -33,11 +33,8 @@ properties:
     maxItems: 1
 
   reset-gpios: true
-
   backlight: true
-
   rotation: true
-
   port: true
 
   vcc-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
index 5fcea62fd58f..2f49a6bbf3d7 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
@@ -25,6 +25,7 @@ properties:
   backlight: true
   port: true
   reset-gpios: true
+
   iovcc-supply:
     description: regulator that supplies the iovcc voltage
   vci-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
index b0e2c82232d3..3f56047f4469 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
@@ -24,6 +24,7 @@ properties:
   backlight: true
   port: true
   reset-gpios: true
+
   iovcc-supply:
     description: regulator that supplies the iovcc voltage
   vcc-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
index 74ff772973d6..b8b153a6e6cc 100644
--- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -22,7 +22,6 @@ properties:
       - mantix,mlaf057we51-x
       - ys,ys57pss36bh5gq
 
-  port: true
   reg:
     maxItems: 1
     description: DSI virtual channel
@@ -36,13 +35,13 @@ properties:
   vddi-supply:
     description: 1.8V I/O voltage supply
 
-  reset-gpios: true
-
   mantix,tp-rstn-gpios:
     maxItems: 1
     description: second reset line that triggers DSI config load
 
   backlight: true
+  port: true
+  reset-gpios: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
index b39fd0c5a48a..43d134daf0ac 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
@@ -28,13 +28,14 @@ properties:
   reg:
     maxItems: 1
 
-  reset-gpios: true
   vdd-supply:
     description: regulator that supplies the vdd voltage
   vddi-supply:
     description: regulator that supplies the vddi voltage
+
   backlight: true
   port: true
+  reset-gpios: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml
index 90cce221c0d1..3d7761717b74 100644
--- a/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml
@@ -33,8 +33,6 @@ properties:
   iovcc-supply:
     description: Regulator for 1.8V IO power supply.
 
-  backlight: true
-
   renesas,gamma:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -51,6 +49,7 @@ properties:
     type: boolean
     description: digital contrast adjustment
 
+  backlight: true
   reset-gpios: true
   port: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml
index 1cd219b510ee..740185f778a1 100644
--- a/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml
@@ -33,7 +33,6 @@ properties:
     description: Regulator for 1.8V IO power supply.
 
   backlight: true
-
   reset-gpios: true
   port: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index 4ae152cc55e0..ebfc825b8346 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -33,7 +33,6 @@ properties:
       # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
       - xingbangda,xbd599
 
-  port: true
   reg:
     maxItems: 1
     description: DSI virtual channel
@@ -44,9 +43,9 @@ properties:
   iovcc-supply:
     description: I/O voltage supply
 
-  reset-gpios: true
-
   backlight: true
+  port: true
+  reset-gpios: true
   rotation: true
 
 required:
diff --git a/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml b/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
index a58a31349757..85c5dee65383 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
@@ -31,9 +31,7 @@ properties:
     description: Negative 5V supply
 
   reset-gpios: true
-
   enable-gpios: true
-
   port: true
 
 required:
diff --git a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
index 0819f38a9d2c..7fd9364fa385 100644
--- a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
+++ b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
@@ -16,8 +16,6 @@ properties:
   compatible:
     const: startek,kd070fhfid015
 
-  enable-gpios: true
-
   iovcc-supply:
     description: Reference to the regulator powering the panel IO pins.
 
@@ -25,11 +23,10 @@ properties:
     maxItems: 1
     description: DSI virtual channel
 
-  reset-gpios: true
-
+  enable-gpios: true
   port: true
-
   power-supply: true
+  reset-gpios: true
 
 required:
   - compatible

---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20260306-dt-bindings-display-panel-clean-3ddd8e087ef2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

