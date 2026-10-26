Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD8606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YjC7P+yz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA2610E201;
	Mon, 26 Oct 2026 10:03:50 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903D210E201
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjaYI0mIRsv88SKy84WFHF9OryS3cRh5pr1p32oyUTMWno2HcZQ6ZlBhL2AHaeEqgi6/HWzXOKH+i/d2lgVLza+keq236z5FIa1yDCg5g3k+JJXTlNk+mNne433xTQSvy5BFkvVLJjgvW3ipybJPOvHDx6GV0XG/uihGVig4kIFF6COYj9zs90LQ2Sd2QMVfVcZw3l6dCYhCP7CIS/cmNF5shojAm7XDkjMzWCkkt1Q9X+LhvZH+IZFqQYJuTbifxSNq8e50SBlxKB9ua0uzP3fqpjL/dVwltXE3FoJoSJznMXym7VcZsKwMqAJYrwSNBn67NulSlIBHu9qjKqU1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIrbh3ffXq/7M6Ur9WnvhmIrqy2uxyth1D/4ud0L2BU=;
 b=eThrfgdKYHZOqyuOPvy5ExEGHYTCX5OzxO8QcO/zDec1X1zYJtSby8gDw8TlBwjHa/ZRMYzXyRtrdO+gQnpA8MtgxMgEG/+tnlMgBvPWwyZaLjWddM9Isv97IUKvz9Twq0pOCPlOZDF9Om/++bak0ogofSYHpKZegnaVXt+VQz35P4eZFYpVhHC4v2PVcJHwnetIJMG2P6O9LYKnZ0yEeFYcOlxJvOefSscwjpJu4Ll1FutXZ2Enj8B42uNpr0KZ/tF/7fzVD2FuypEvcrJBrmGm2fxunCzhuCcmTGWmjZvPgOeY0d3N141swnxfkOsv0LItxYH2gAFTeUjrN84Z0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIrbh3ffXq/7M6Ur9WnvhmIrqy2uxyth1D/4ud0L2BU=;
 b=YjC7P+yz52V7cIVn8ZZ4tP7iMdjj6JRyi80tmcOzq7teWy6HVQR2Deqtnldr7BFODY9LX1wRvhkSbwU4hThKhzWC2k0zPdQzAuCNAwUCSHgzfRHI3aEyMLVjXlR9MvmKOg2x+y2SOODwhD7+oe+JwytkH0y57dMlQ/9qF+lObYqa3Q2cS8kzl++rIZc0ONeTgMdEG4mgf0ueQoUA3ktE9Sc6kAh8hrPuhv3dmOjZqifvF4BP50c+GYHfAvpP4VXHwMCG8OjFFDs7KBTQn3a0kzxV2FLa2V2qd5iJpS6SOLkOL/yRwqL+u6+CBj10yyb/DazHbl6jKx7vFMwtGYSI+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DU4PR04MB10529.eurprd04.prod.outlook.com (2603:10a6:10:55a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:03:41 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:03:41 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:06 +0800
Subject: [PATCH v7 01/15] dt-bindings: display: imx: Add i.MX8qxp/qm PRG
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-1-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
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
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DU4PR04MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d4b6a4-215a-466e-4d47-08df33486959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: kZ7ZAzq0fNFKThpQSLYYujzIO1vtmPSgU4UL50EgqDZcuV0+MNzLHqhQCaVBh+CvcMPqJz4tODjcLvzSR/YtDpKunNcZnOCvnQQZ0iIttXrsTzUYG+dUWKrt9Y6JFI0p4Zt9wT7sl3UxZWEprbEdFE7Qb9jR6vUN0shZqY8yDBulh0+a1aErN2IC1JfWQB2uleSNAZldz/83l6qxf8GTeoCndGHYekynnMPIqPv38zzU5Ee3Jc+rkXNVvGBSWs7A0zPbQ+vA83YvfAPBvXxNhtqYgr/pmCw3f37V73+cPPCRp380m+62YBedsWIVKtQu1An56Oin9n36Eo/cAcp/gPYcIFr3WPqjKPSknkvNXQ04BG45DSmT4fOVlV1GW3zOTXW86tl47sGbv8V5X/O5tiaQff3pIOtDbCOmuXtlGzB7NOHEK6SH5ykgi6UQhzjtu1yo0NmR6A6dVsBkVa+I0MUStnITiGy4D3TjnxMF0URugdjGbzO9jMIZyUW9IQe/5SbhZ+wTqhHqHK+S+Ebl9VnvP5TJMLK+QAfT6stqEgsUJPy1zDqz+jx5Wj1QUvgG6K9YxaMWh4+DcfgDc/EGkvF/XH4wR5lZQ2ztZku6qkImldtPw2ZU1r4TjHTwcjvOXG7vzaAhuKF2LpzI00qr25WzqNXQgMLWtd4X5e/DmRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNGQWd4bzl1WER4U0hhaFFUTHBTa3hZUmhJMUcxQzFramE1dmdBZjlRT3lN?=
 =?utf-8?B?TWlnMWhlZmFEdytWSkxncGsvL1dDQ0JIR0FkNjF0aGZEbWt4bGtabjdsWDA5?=
 =?utf-8?B?N3AyYmk5VHVGQ0lpeTBDWTBQTncwdWEwZm1ZbEJia0NkNzU5YlVIbW54d0ph?=
 =?utf-8?B?R1gycFUrVEZqWDlOeEhDNFdIZnRJQ05zR2g3U1RrbzZpZ25lOTVWVWthZDdP?=
 =?utf-8?B?VEdNek0rckVjNFkwb0lFc1RYN25lU0djY1lJNENwY055M2xzc2c5VUhORk5K?=
 =?utf-8?B?OGIxQ1RsSGw5N2JxM0VSRWFWSGVvcHViYnJuWFc1NjJRSmpQcjdvSTdBY3B3?=
 =?utf-8?B?RXVjUWZKeGp0ZGlmcmRqVVQzYzFuOEd5QUdka0k3RU5UYVE4d0srMFhQMmJU?=
 =?utf-8?B?b0wxMHdnbTg2WVljV3BST1RxaGJIR0FOZWhvMENoRFIzallDaHFtZjZaRE1k?=
 =?utf-8?B?U25ueEQ3a1I4bElyY3RhRGhvVTB1NHg1Ynk0dzZwc051M25XTWFsT3lnKzNW?=
 =?utf-8?B?YTQ1T0FjbnVXOEtiOXFTejBwaC85REo3SDh1T05JWEt5QkVjUGxNUTNDVXds?=
 =?utf-8?B?T1lEUkNSYTBRREJDUWFBcEZpR3gvN2RjM0MvaUJmK2NJdGdoM09BQVhmUmls?=
 =?utf-8?B?WDhtUlBDaVRaZkI4OUpicVM3VEpkKzhhWXFVZkVHQmdveloySHdKbkhLc01U?=
 =?utf-8?B?VWp4V05rWjZqenFjdloyRW4waEt2amtXZkU1blpodEt6WjdGdE5UMmZJVGI3?=
 =?utf-8?B?VzkxUFhNNFBRTGl1Um83T1I4N0U1MXhBdmhpdkdEWE9MV1lVV0dxL29IdG1p?=
 =?utf-8?B?VkR2b2doaWlFTy9iNG9OMTV6NDlMbFhEWkd2SzgyaXgvbml0VVFNRlQyRU1h?=
 =?utf-8?B?b3ZUc2VOdzZlSU1EUEU1Rk5Rc1dBMEdwSGlzRG14NjFIcGpaSFd4LzMzUFA2?=
 =?utf-8?B?R2FieW8vQ3hCVHVvZmZ4SkZNb1VtTm4vcDJMSUFhMDBKOWd0d1NlWERWMTND?=
 =?utf-8?B?dGkxa2tUNVY5amh1bkZDVURKK29SNHlYTVZnYWt2Rk5FRUJzaVdGVnZ2b0w0?=
 =?utf-8?B?RFFWQ3VQZTFJRFVYcXR3OFVNRzNZTFJId2ZkYjh2TG5OZGh3Q05pcktaaGpH?=
 =?utf-8?B?dG9hMWV3T216S2pqU1A5NStoRlc5Y1N2NkVOYVh1aTFFdWdXeVZLcmJHQys5?=
 =?utf-8?B?d0hXZHpUVG8vaGw5b2xSRWRvVTFFU3hzSEJVU3lxUzU5S3I5VTAweXlnRGFP?=
 =?utf-8?B?VUxQWWRFZVViZFJhTGtidjlnMmhPR3hoRzVUTGdscFhzcUluVWY3cG8zUGxL?=
 =?utf-8?B?UXRlcWdWU2hrZnZqS0R0Q2dIcEQ4ek1vVjBvUDJUZjdmRDJNdlhMWGZXZit0?=
 =?utf-8?B?cjBWb2lmdG5kYTg0OThhT0N3VDBKUjVmQyswYlFiQ3YrTys1bjY4Z3Q2ak0v?=
 =?utf-8?B?VjlTZUZuK0poSWVEb3RCUnpOYnBQMGErVXB4NEQ2L013S3hXNVBPY2p0aWND?=
 =?utf-8?B?SXc4Mlg1ajkxNzRyb3o5dk5welE1Q2hQZjcwVi9hOWVlVWtqY0tVYURUcWVm?=
 =?utf-8?B?aFErSzJTREVObFVxZXV1eEEyNy93TVNLdGFUUlRndGIwU0JzTlVLdkRCNnh6?=
 =?utf-8?B?SHZiKzgxT2MyclhDZzBvM21PUHpNdWllS1pQS3FUZkhyRXBXQmdweG9lRU1s?=
 =?utf-8?B?QUkrdzVFbElYTFR6R0ZyY083alJLS2Z1Q1BPNmk0UUgxSXgvbkcyT01XSW1p?=
 =?utf-8?B?VVVjMUlUOGc4cXlSNElhRCtUZ1l1SkdYUlduc2syUm5NaEVBRDgyMGhTZHNh?=
 =?utf-8?B?N0FRRTlpa3RFa1NGL1F3ODljcGdTMmpGSklHMjczT2Z6QVdzTGxrR1NDR0Ja?=
 =?utf-8?B?WUp3N2JCazRYOEtIOWk0OGRIWHBtM3loSkM0NzBVb0pmWGtuYUtKZ0NQdVgz?=
 =?utf-8?B?bGFFaVRIZWdudkJMYkNOOWRmUTF5dkhNWDlMWXpnU2dTUi9QeURNS2I1R3Qv?=
 =?utf-8?B?Mi85LzQ3blVSRU5xRS8vOERxOTY1TE53Qkl4ZndqSnBzWGp3ZUVQQ3U0Vk9I?=
 =?utf-8?B?ZFU5c1JsVDltVjlUMGQ2ZnpXUEN4SUFqM2lZSjF2TkRJMGZNSDEycVpSczNo?=
 =?utf-8?B?T1c3L2p1aENiOEMvcXE1VDhXN29IQ2psUUcwOEhMeU1wQysvRStLaWZ6dVJQ?=
 =?utf-8?B?WE4yc0lxT21BbDFUOVNQTnE1ZVJRenJjejZOODFwODVwZHdRRGJRZytyYTIx?=
 =?utf-8?B?WnFyZTNpRkhtNFRqdHQwMGVMYVcwSXBVb3EwQU5pam13RnJFRDJ2amM1UDBZ?=
 =?utf-8?B?ZUgxbnRVbVRzY01vWUxxTmoycHA2NzlxUFJxc0dnN2dDYkkyMjE3QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d4b6a4-215a-466e-4d47-08df33486959
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:03:41.0778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciz5l7a+ATUvMFLbOKcNEAKl4W3h/oHCnATIEjzgs6WfDCjKImAaVckx38JiP6HemT5JSYLfhlH5L0A3ib0IKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10529
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
index a08087fb6e67..d9a6bdc65826 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8806,6 +8806,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 
 DRM DRIVERS FOR FREESCALE IMX BRIDGE

-- 
2.43.0

