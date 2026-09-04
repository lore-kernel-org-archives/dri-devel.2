Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47822C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AEF10F8D6;
	Fri,  4 Sep 2026 07:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Bc1N9OiZ";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AA010F8D6
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3Xw0W151nubsL9USQ10Vkx7z0EEsMcB9e6dzeGtlwZteqM+hUbzwpFIsFgUZMRxP/90BzOz/LPrqasrPN3+LQ6iTUPgSUBJjMdbiWjflxxF1OaTMiqIDDr1WiRr29fsy6RTEYEGqYGczLXez7/mFSYMo169VRaCB8WsvSzQTGi1HoXsPkIB3CwNZZixZ8EGn0Mammuv7vpaDgBFRGSQD+TgbspnmfjC3FmNzdVAXREaULWeQNRI8RFlTd8UnplwHZBw8xOJO6ZO31QnE7a9zZfR1R3xrHqbDKuOogeywPtmWq4tvXeaPGLNejxokwsGglRoHthkRG58KAhxgO9hIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zeJ/Is5miliXDA7sNXonnDiQoOdhjzWvbuWvcgGnik=;
 b=YHfS1S57lQh9vb/NHQbefUSBDKa8Fo77N7KDtEQDQAe09Ax4seM5kLYDp7F/e0rKEL4kd4+NXYq13XBM4MSkXGDYK+s4OJ9qT5tfal0lflytRWmStM0zm5ZkHCONLVpY2TV9iTVQ0TAh2yeCGFzN6G4jUXS/uXsNCx+4y9AxtzPKv82pFfF8wo1H0NmqIAF66p35Bd9Ak6KH7QpGcJzvabtI/zrCSDJGBdyL1b1X4juz+OsPInkgg9qKG9yTMXYZx9mTUI1vRAsNR8LR+RqgineKfNXBUXYCBJGgahdLXYi2dFH5c0noLS25vi/X5WEsmdqnCgxUQpnyORmVz92DTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zeJ/Is5miliXDA7sNXonnDiQoOdhjzWvbuWvcgGnik=;
 b=Bc1N9OiZpvITehYA0nBoZyl7dRTz2jmrVHcTG4C2+DgF36oyuzBUvno54mHtQGJaDW+RWsx2YGBmICRMi9IcPu5+1V6E54LxDrOJFYZZug5H5SovWZyu/sC+wVKtgoYX3Q5DoRLp/AUWI9+rVxhPDftLdaiUjMjth/8hfX0VfVY2NpfhLqa5d/UjmK+4ai30XkZACqFCKwcFZAfzNxTX/icfB3J/d/oWXcmXvH2NiXkraXw3AimouSHM+FIBHX3ia4zesl/6cPCcNT7ofpUPEFKhPEzfheZFMvwXbD5m3M426MEvDKOuINLGevTWc5rUlcAkR6934Hht1xWdpzPQow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:53:36 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:53:36 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:51 +0800
Subject: [PATCH v6 01/13] dt-bindings: display: imx: Add i.MX8qxp/qm PRG
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-1-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: f061916f-2abd-4f42-9325-08df0a599ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|3023799007|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: hpH3sMMOhTboqazElho9WDiE63weSpeJFP4Ute5WlhUqEZZ65bAa867/aternTVFIZ6yIFE3YPFGZLEPYGtuwANIQ1MIVsoX6HIHmg7ev1Ip1oUf4vi3mJpTRvjjmQGaOUHd/GTeVIyAiZZhb6Cd1X8GOif9mvZcBVdG59NT+ILSNgpNSRCnQAFolgFUX77ak4ebXv0ZyP61eEYW7keXoT/ieS9LVnb//mZHtNFjIReKzUgG9awAvVxPXECJd8LDJSIpYFAUVH8sfLSpxqdunjxf+rXjJG84cjslNpn1FYAKOjDv86OtA5bmYrXAAv/rgSDadbdQCdo3tyxm6BG1Zhk9sZfYidZ1TY/q7EwQfMKLFSjP4dMIH2+Q2DLTnzytz8O1dul1rBfpjeYm9pYAalVkPhZ4yE2sfz/JXk2rLgMQ+7Mmmwpv/hFxxtdPq9qHwQWvMnm3RE5ipmtTxxSqoMFpUpCKnFBgceT5Jy3ZYv9UA0kXOTTw4s/88CDzH/qg/AtEQAjTLluttzb8Cp9Trdb9QGj5AdI8Ri/onXsLdZfVph6yx0zHY1Tgg52yp36QIrg5QEZ4UntJTVpf2e3eCxpRVFlkmyU2mfWcDCxBGw+T3JPG1pPkZn8F0T8y9yhJjOLbFkmFHT1cCQQeTlfe9/RJPicFVvVMw6a2uFpi4nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(3023799007)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdXdHZwbWJ3NG10UnRTdUJKcTliOFJndzNBQzFSR1lDVitUZmhvYXZjcFRi?=
 =?utf-8?B?ZWx3RWFud2Vva3kvWkhXbGYyUzN3dFBKaUtuOTVnNXRRTTV0dHdvUDhXMFVC?=
 =?utf-8?B?N0tqZWxiODRLUUJka1R5RndlMis4WTJ3YjZzSXYzaTJjamdEYWZobFZ0eEQ4?=
 =?utf-8?B?V1V1UXdtUS9hUVhxN3p6bkRqLzFmKzgvd2JKS3lYSW9qY0RBMWR1a2dNVnpN?=
 =?utf-8?B?ZkRIL2pVNytMRFpLVnhFRzI1Uk1YNXNYbXRUSGhsZ1VZckhxQm9TTElCaUN5?=
 =?utf-8?B?U1VyZjJnc0tXallsK0NnbUx6YVFjUWpPMm1RdVJxUjhUdUlVaHg1Ymo0Sjdr?=
 =?utf-8?B?dlNaQUwwZVlwK1RIbEtRQnJ1UU45alA0Q1poL1gzUkpENmNQMHRvanB5Njh0?=
 =?utf-8?B?cGJ4MER0YnEwNW5FVVRGWi9ER3M4aEhuTlM2MVkyOXRoSUxzL1VnTTF6THFN?=
 =?utf-8?B?MXR4dGRrSW9CTW03Uy9uQUhqMnBlOWR1SWJCaTlxV2MvZDZOc0RRdjZ4R1BI?=
 =?utf-8?B?d3Fva3RBMnVEUDFvcWF3bjRWTVRZV2dJTnNQaklCU0FiaTNHVlFQUVNPUmRP?=
 =?utf-8?B?RVRyR2k3cC92Q2JIN2E5eUJRaGxSWU16c3EzNkh6RkUwWnBaUjRmUmNvV2No?=
 =?utf-8?B?NFVEWXBLTVB5UDZqdVdoL1lYNWNJVkJySE56dXdKZWEvNmVBRnV0Rjg4aVNw?=
 =?utf-8?B?MXZyaW1LcFVmT3pnY0ZCeER1bzVLeUpsSlRPNXE1WkNETEwvTGkzRzZUbytX?=
 =?utf-8?B?V3l6OEFlTjFOT2hUbUNPdi9ZSXVCcW1jR2c2c1kwTDRpSnkvQlpKa3lCU0g3?=
 =?utf-8?B?eC9WaXNjNkdHdU5xUUlwb2NoVHNVK1p4R05Ud2pXbHdHYllKRHorY05VOGJF?=
 =?utf-8?B?UXJOSytLY2N4a0pRcStuYTM2L2hwU0xqeWVhWjJjTUs0RVZsWFYvSmZXWExk?=
 =?utf-8?B?U1k4TlJyUCtNVFd4YkJxY091WWpuYlpkTFFDc09OZGJvUjY5VDkzckMwazVk?=
 =?utf-8?B?WVltd05Sb3YvNU9oQ09WclN3ZWZOKzQyYlplNEFHRWo4OW5wMFQ4QzBhMWsv?=
 =?utf-8?B?MVhMSHZsU09hdnJ4RmhrT2xLd25oZWxhY1p2T2V6QTJVT2RINC9EdlBxeUNh?=
 =?utf-8?B?M2ZldzBqSGVxbnduTUIxQTdQT1RTRVQvMHNBa0FGQ0RNM3c2SDZUeEdWeksz?=
 =?utf-8?B?TGsrdkJxRDFZRE5ONW9TV0VmK1g0TGoxWStnQUJ3V0swaTRaWjhESTYydHZV?=
 =?utf-8?B?WmNnOTNIbk41WWtzWG5KeC8vdnhuTWhySXQ0Wkh1TjJLd2FIaVp3RnlVMlVi?=
 =?utf-8?B?ckc4VTJ2NEZCQkhlTVdBQWVoUDhNRnhUcmE0cGlCWWg4bXpOMnVTay95dUFM?=
 =?utf-8?B?bEJuQnJ4eDZPckY4bDVmMy9Nc0dOUFJRZjFob0tCbEFVVmRtVHc2bXFPZFg1?=
 =?utf-8?B?RWpsT2RFM2R6NGpVeVIwYWtPMTN5NGZ4bFNNV0ozNmRiOGZYMyttakw4TmNT?=
 =?utf-8?B?cElCcDdNM0ROeElhZEJRS0I2N2FDNnpIc1ZoVXJEdFZ5Y0ljbXdYU2dFZ1NZ?=
 =?utf-8?B?SWltSjBhR2hRMklzOEQrcmM3cXRIWkhpbWRSMnBjUEZ4QzArdEdkYXVkNVNj?=
 =?utf-8?B?WEVWYTVzMDcxSWo1Vk8vdDhndFVDR1RINkdpa0d6R25lZ0taQ2ptVTJLUmd4?=
 =?utf-8?B?cktob1FHWjlRczRUc3pNUTEzbmFMS29mVDEvZU5uZWZhREJoR3ZVTmt0cXBk?=
 =?utf-8?B?b2xacGY5dm8yQ2JGTVdxemt4MGhWYzZab2dKMzRDa3JrN3o1cG95YzVnS3Az?=
 =?utf-8?B?bTQ1Z1BQbGo5cDJBVURRNXUxUzdEWGJLWXkrVjRlVldQOUJ1S0NFeTRPSHAz?=
 =?utf-8?B?dmRoMFk1OHFramNTZ0h0Ny9IRUFpK1dINGRaYS9xMnVQYUQ4dmUvMHM0cEFa?=
 =?utf-8?B?Qm1saXpGcXZJV2dCb3BoN0k3YlNSeDlzNkg5dFRHNnlpdTVKWWFkQmtNUjZ6?=
 =?utf-8?B?VG10bnl6ZHFQaEovQktCQkFGTjlOakQ0ZklWSWZmUkg5Z09Mei92TEFCV3R6?=
 =?utf-8?B?V0Ntc2xRM09KV0VkaGRhYU45SkIycURaT2g3bGF4SkZuL2EvVVk4TmpURGdL?=
 =?utf-8?B?eTJ0dWNuUksxRS9sSmp0OERZQXRPNVdTS0ZydlhtUjBObzY3WWtWQkdBbXhz?=
 =?utf-8?B?aDk4amJEMENaa290bTRndzk4d3FnbGVOWHhUdUJXTkVqNmEzUnFzN3U3WlU4?=
 =?utf-8?B?enhxSFQ0aFJlWmFrb0dnRm5KS0w0eElHakdrbkRDVXhoSXBOTHZuRDljVkJU?=
 =?utf-8?B?ZTZJOVF3RXlPSm52VjlQY0tQenNnSzBuUFNzWEMwK2VwcnlJQXdVdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f061916f-2abd-4f42-9325-08df0a599ffb
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:53:36.3187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ua80cMlsQBWWDYNBZUhJkGyKOmynUnHd21+H2yXRSMIA9pcgdKse+AVPBxLlAF1bvylsxmd0PjHBvopDVBtLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

Add bindings for i.MX8qxp/qm Display Prefetch Resolve Gasket.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changed commit message to use imperative mood.

v5:
- Add the DT binding file in MAINTAINERS.  (Krzysztof)
---
 .../bindings/display/imx/fsl,imx8qxp-prg.yaml      | 60 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
new file mode 100644
index 000000000000..3ff46e0d4e73
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-prg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qm/qxp Display Prefetch Resolve Gasket
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The i.MX8qm/qxp Prefetch Resolve Gasket (PRG) is a gasket interface between
+  RTRAM controller and Display Controller.  The main function is to convert
+  the AXI interface to the RTRAM interface, which includes re-mapping the
+  ARADDR to a RTRAM address.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-prg
+      - fsl,imx8qm-prg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: rtram clock
+      - description: apb clock
+
+  clock-names:
+    items:
+      - const: rtram
+      - const: apb
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    prg@56040000 {
+        compatible = "fsl,imx8qxp-prg";
+        reg = <0x56040000 0x10000>;
+        clocks = <&dc0_prg0_lpcg IMX_LPCG_CLK_0>,
+                 <&dc0_prg0_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "rtram", "apb";
+        power-domains = <&pd IMX_SC_R_DC_0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e854d686da3..62cf71b3cf4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8793,6 +8793,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 
 DRM DRIVERS FOR FREESCALE IMX BRIDGE

-- 
2.43.0

