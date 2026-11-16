Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA5606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z2QX+32Y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zsg4ExrT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2874D10EF7E;
	Mon, 16 Nov 2026 11:35:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EA110EF7E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBLO7n3685047
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gnF7nUiKa64cGMOPkzafRQ+xlLpRILvOHKnNIMFoPAk=; b=Z2QX+32Y9/8Ixjps
 svM98CT7t5nw8ZiK3q6x0xO2l/iDYJE8ktbl2uCG5wSDEa0hn1SCcOup2LVclavB
 nRO4Sb1fsmByzbRybkNmer9HNSC6zHPbGT98DvohpPOkmqsObH3+9gwt5mY39PUg
 A3CimrVpsK7eq2F3Fd8T0rM1u+Y9QBzVVeOl1rkJemmGgqLyJebzqwNvUGXS8goI
 lA0dYZ+RnWjNFa9+OXi8DNyJuiHuI3ghuiM3hkuJrE2jazUtCU36z7a+aqHlAwR/
 x2sFX8a4O0GmQ0ROAlEeLquVxUnlHXcL8YElvcuHH2OygFEwJE193bXyTqLU4kOd
 kkSR5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6ggenn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aed37745bcso3242358a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794828890; x=1795433690;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gnF7nUiKa64cGMOPkzafRQ+xlLpRILvOHKnNIMFoPAk=;
 b=Zsg4ExrT/Y2SRLVwB3UKJo7SQqH9+IcqRyFb07cg1RJwdIrMRUDkhaYdmJzS6gssva
 p7x8ERo/66onHXdof8W7M0vXAXXS4LOlUyDj1qD73jLEl6hwRwb8JomxB12CJbZgI1F0
 cx4cB2pMgvxQHE1dTIIYRZUoUpikXtVhus2bKl+I+gbMn9vwkf1d5zjBs7Eqxo4iXk+P
 b5kmA0QZQufKgmDcZiz8Ti0SIISziAipHRw5ZsrVWUK+/GU7UAntpRvKAhNCYVWyfs1g
 5AnVh7zzxItkWUm4/Fqz5At9ocd2WBWcM7NPl3+6BEiC55t4dB9HEtUJkzCoh8gq/HBI
 wvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828890; x=1795433690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gnF7nUiKa64cGMOPkzafRQ+xlLpRILvOHKnNIMFoPAk=;
 b=tKIs3siCCOd48OtCRCFyF2sAut1FJzGEaNqS4wV/jcQ26dnRb6JS2JwgcLCDtqrkwc
 MhuwasjZu/wL1b9GACbjnqnnu9DArsJUyE1Iv+cexCjwhdZSU02LKHPBpyqO6GtSkDWB
 Ufn994h8CnN1ZcU9+kAzBy93WKnEurZFL+L/vyvVIqqDfkVSsW1qdHMwjWR18CWaN0o8
 qziRWvFQyLXFpUlmOPLLd2rPTm2m6M85e6CEWdSUIJCROLVvrEYdetFtqHw8V7VerzDQ
 H9RRpAzucAapYQPgtx0SrF1nComYoYDPtRheAQYE/0X3efGGcz3fVz5CIHU+KLF3es3X
 ID0g==
X-Gm-Message-State: APuU4Z85XMfIwCxO8zdSS4IAC9Pa11ZbmiY7d5Is6UWH5i1FlIOX0qsM
 vw/9f3CWdB1rpfw2Rv7QJBzn8iZ8Id1efbcK8pD1ArEAlODgV1m+oUarpLXbnlmGFBaTSOdvoBa
 ZEmyVTjZSdMHGYeIS7PySOHUV+2qNUm3uyrqjQ8/uJiNWjNzg1roYAYweB0d9rmZV/lj8sUjtCe
 6Cjz0=
X-Gm-Gg: AZFdTZd2+4AF0lAkgdg+Ws+1kstA1rCfAvHuYYdCnXhi2AY7z3yC1c0/ua9p6rMPqHn
 VlWqklw6cWzQdvt5xe8s10mKE9EUjTkQMBO1bCZb4icmtxuwp0DVsZjygsEp6xt/Wr//6H6Q0oa
 qDfr+R99OtJeuQfNWv7gIl3pMJEb9Ouv03QramQuLpGb+lJ8NsAtpoTcXvKVE30GQsVfAzto/Cz
 QpOCnHGcuDH3tEH0htT6nHtLeeKNDSTC3vgyYJUTjzrHU1b1u9RVnUFyitl9m7LezsdHhs1/lIi
 pKi+PO4OV1UVPHjMnvEm89B1qlTjFseNuv2/pK2NRFhYGsUPMVBR+oFOpxzygdPvGvwu1NXteOs
 PiYis+3vzruxuACTTpcS7yCqWpZ7OY5f8gaOM3Q8pSlgvqK1iqA5VvxMiNPvXhQbKVktTRVuPWy
 i3
X-Received: by 2002:a17:90b:184b:b0:3ac:9ed8:f301 with SMTP id
 98e67ed59e1d1-3b1b0ccf45cmr6831654a91.30.1794828889736; 
 Mon, 16 Nov 2026 03:34:49 -0800 (PST)
X-Received: by 2002:a17:90b:184b:b0:3ac:9ed8:f301 with SMTP id
 98e67ed59e1d1-3b1b0ccf45cmr6831633a91.30.1794828889253; 
 Mon, 16 Nov 2026 03:34:49 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d27d26sm21000719a91.13.2026.11.16.03.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:34:48 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:04:04 +0530
Subject: [PATCH v2 1/4] dt-bindings: display: bridge: Add Parade PS195
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mahua-hdmi-v2-1-0b5af6bf9e70@oss.qualcomm.com>
References: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
In-Reply-To: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794828874; l=4283;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=XqWVS/G6kyEGs7FM3vsOHGEHaxWN/UrO6qm6Co6aCVI=;
 b=WtBTscvQ0DovqRE3dOcQSKtm7PgukaEYc6NSnRNGQ6EeL0dXOyYpjQV5IcW+0oPs2xVZ5B56F
 oeXiTxWZuOTB1Znac4fzZm5gCusQZAZeTeJaJSrWwzttE7+xenJOj3B
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX+R3WZOiHC+pL
 GNKjAogV03BsPg+oku5lcpplinXDFY+G0JIXMtjGNq332S0MAFX14U8awez4Q1O19x0YR95ziIx
 6wsekzbJpD9naf4VB3Yz+r+iZfo7BtfkI9QCdY0qJyYksLJB+cbZwtUMpvorGmXWqSXrwUtuRAt
 /Em4WYmIoL2Tt32wk6kNpMj1Iy2P/Jv/uEOvTDUyrl9RGNCCnQjH7e6xPd2XZuDJDeL6C/b2hcU
 tFZmX+Uyer0dWiAc8Y5bVu2bAhIjpQVHgxya+OiUkpO//tG9tq/fWX0VTOeGKHnqBT5co+QUylC
 In3MSqkQXXfLsBlelU5lfXSRU7aseVuE3XinNm5nv64jgO+wXT8v0q92RXSgJyXwYEZulRpPMrU
 404VeZyUzxGoMuxaOPcsHoLzL83ELMVacOZEt/2pj71M9D5hb1RIcMxIkehvI4BPpReQDsgUHNn
 d3Yts/D8dcoXobcxfhA==
X-Proofpoint-GUID: 1MF57YTZOnCb510Met037V7lbxyiYGh2
X-Proofpoint-ORIG-GUID: 1MF57YTZOnCb510Met037V7lbxyiYGh2
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afaea5a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8
 a=9e7qC0O8hlTshWeg44oA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX2UMyH/U3OG1I
 X0UfU79RGuDWSApZctxHQzooAhXWuHYQ+BO3xInHo8kK+iLBGcTiXphFMsBTcf+Hlz5NdltZpr+
 rblUch+xGkf3TA91KuldWXobcA9oTo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160045
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add bindings for the Parade PS195 DisplayPort to HDMI bridge, describing
its power supplies, optional reset GPIO and display ports.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/bridge/parade,ps195.yaml      | 111 +++++++++++++++++++++
 MAINTAINERS                                        |   6 ++
 2 files changed, 117 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml b/Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
new file mode 100644
index 000000000000..b7484caf93b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/parade,ps195.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade PS195 DisplayPort to HDMI protocol converter
+
+maintainers:
+  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
+
+description:
+  The PS195 converts DisplayPort input to HDMI output. Firmware loaded from
+  an external SPI flash handles link training, EDID access and hotplug
+  detection. An I2C control interface provides access to the device registers.
+  Reset may be controlled by a GPIO or released by a board resistor-capacitor
+  network.
+
+properties:
+  compatible:
+    const: parade,ps195
+
+  reg:
+    description:
+      I2C address, selected by GPIO11. The address is 0x08 when GPIO11 is low
+      and 0x48 when it is high.
+    items:
+      - enum: [0x08, 0x48]
+
+  vdd09-supply:
+    description: 0.95 V core and analog supply.
+
+  vdd12-supply:
+    description: 1.2 V I/O supply.
+
+  vdd33-supply:
+    description: 3.3 V supply.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to the active-low RESETB input.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    unevaluatedProperties: false
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: DisplayPort input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: HDMI output.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - vdd09-supply
+  - vdd12-supply
+  - vdd33-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hdmi-bridge@8 {
+            compatible = "parade,ps195";
+            reg = <0x08>;
+
+            vdd09-supply = <&vreg_hdmi_0p95>;
+            vdd12-supply = <&vreg_hdmi_1p2>;
+            vdd33-supply = <&vreg_hdmi_3p3>;
+
+            reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_in: endpoint {
+                        remote-endpoint = <&dp_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_out: endpoint {
+                        remote-endpoint = <&hdmi_connector_in>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 46c416cadacd..9e1db88ec1c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8581,6 +8581,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
 F:	drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
 
+DRM DRIVER FOR PARADE PS195 BRIDGE CHIP
+M:	Mahadevan P <mahadevan.p@oss.qualcomm.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
+
 DRM DRIVER FOR PARADE PS8640 BRIDGE CHIP
 R:	Douglas Anderson <dianders@chromium.org>
 F:	Documentation/devicetree/bindings/display/bridge/ps8640.yaml

-- 
2.34.1

