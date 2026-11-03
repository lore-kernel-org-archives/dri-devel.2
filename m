Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF8606A334
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=junoZHl/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3C210F384;
	Tue,  3 Nov 2026 06:20:42 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013018.outbound.protection.outlook.com
 [40.107.162.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D94810E343
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaK+sEMsO/ep4RzE/Ca6nJ8M+hZ9rDR9VZ87UW1mkJGb7/MB1XjK82OXmZKMSE5Zi6mVkVryKdVhj9opFOEIO2Ih4tm5aw0bqbmv2ADtB2uyo3EX+1b7jf+0ZB1NyhUu37yPlCFigdPDU5IXu/cSZVQLIEM5qpL+UL+LFKjyKOaosWtPixgWQQrRNWbiWAGCVVqB1DN9rA+UOwndC6cWh/bvLaB5yvp4Xa2TZT6F/awcJ6DQboq0sFQ8m48Kblg2he/10Yjoy7PALC36k72VBVhP3t1ONLNDNZstS8MFLEsfUkQjK5yn69/24QXLtoX1qUcbdFO5fRDFO/B9x44kSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV+Kt+v4D6YwSIL12GHVCRN5zjzy8SLqAASQA3oLxC8=;
 b=M0EFfN8ENzMOTtqw2VRu0chgzWvwA07lnZw/92u8DyM4kPRFIl7beNDktE7hPt0cp+TqHrseSxbkVB/8fC7BO9bKFWDtA7EX0xbf8IbmLiCUlLGNOyGhGg6ZM9YSQb2NmbtbuZZJCyUNYPVhUPegRnv1AGKa4fLZUcDNMUjeGuxXOQZoTUmGnry4KFauisDO9eh4+SG3j6STUtWN3sMrGphURKrvX6rQa+CHX9/bo2c93gpgIWB9jFzdwlHfdGEp6BU3sa6ySFhai/qj7VYZKmsgWnFr8fSdVXVeHwciQucsBAguuvFCbIWLjs8e3VeIyGUTGLcK01TwVKc5zWExdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV+Kt+v4D6YwSIL12GHVCRN5zjzy8SLqAASQA3oLxC8=;
 b=junoZHl/Gd5rv1yFbbUVh+UJ9tW+FCh4FlmjyH+l78jP5Um1P6kUgKtT6zc+Ka452lxIcJb+cKmkBvPShsdmKjieeqc5wSYJdl8dl2NrggnGVAl/DeUoaVHOkShl/X6wXR4RxhQUY9n1Bx7ijeUO56L1+gvNWRg0eSXT8mxPpG2kHRVBqyRwSXFnYrS38uwOmZVqlINym2XzxCOXPZ1n7QBeS0uKWg1asanSrjXm8jeIfJI0QbiAN6bpYu3BkwTPzw1B8TkdsxlX7dEI7hx0vHyK5+8vb8VoqC/ntdQlHkZrCuelSBtzBJwdT+Jbx7J6Kml+6Ngzph92RrrTlSZUoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:20:32 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:20:32 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:21:57 +0800
Subject: [PATCH v9 01/16] dt-bindings: display: imx: Add i.MX8qxp/qm PRG
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-1-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d74abde-6cec-44ea-25ab-08df39729054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|3023799007|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tpYZ4AYZimzurxM//xzg6R8kKX0cyx6L6cUmDRcPtj9v6PcoT7SUX7zVYflxX/s1wWztu3hbg3UO2PVoouWj4kYmkFOccWsaPPBXsUhdxKNXqlpqDF8khwpGxr3SWmyJP+1x4RFKCLGvVa7VZMFJ956OUJNMkkWRMlIVLblcWSuswTnkZSvd2LRhb6KM59Qcz3Plj4eHoXGXPxZQHVuYjCbgToyWnnjMkG5WTTOhIvbKFR82wOD/gvCdQaLJoEufkei30gSbKD9PGyfapTLiYedN68SAQpVj0N/0fcRmyFKi7Bje8aNL8Iz5Gw5sqJyDsB3rFZnze1aq5eHnPMUSPtGTORLQzNiG4jxMU2TiML7q5ZmX3fRJzIXRBf5l8QwS77PtJmugKeCL8E9LVrJdNFz35EJ0aBCPpMNCmaWl/aYrq4P4F7YwkMqa4aMZ5KG77aTanw+4I+qh64kHr6V5wW68fgTl6LI5hkG0U5HjKHMiF11AqKjxUrxCZfjXn+aaky1DnP4aqWxU6TNnyzyqVGTPMGWVU9SdXpa21O05qVufQG8yQZ0/n1Cn7JQBMoyDPZ6hToBQGFhvMuixVNAc/Ty4QUt70Q7f9oQfzZPGsOqC8QuIrpSWjjXWncZ6FQekxGjax+t/qEHUtIxutLo3w02tlYLVSy/x3bY/qoZ23Jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(3023799007)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFJK09TNzZvQVN2TjdpODN2d0xzZlN4Qm8wNWZERWhYYnBYV0dobjNPT3NU?=
 =?utf-8?B?SUJtc2VIM3hEK1dFMnVrTTJQRWRrNnVEZjVPTXVsUWlSbEh6c2QvUjZ6aHQ0?=
 =?utf-8?B?bEU2NFIyNzVUOEgxUlpzOHkrS1diS25oOGVBZlZFTkxqVFVYQ3dXMTYwZWpC?=
 =?utf-8?B?MnA1NXptUDhNV2ZCRkExQVlHY1NlYzBKOXlmcjQzb0ZNNktQV0x3cG5zbEoy?=
 =?utf-8?B?OXR3bEtlbHd6K04zSTc3SkN2MkJ4WWpNUzVQK1VnUENLeVN0ZVpIaWJMTUdX?=
 =?utf-8?B?dEpKaTlETm5CZFFGUnhmWHdxa29ubnhYVEFCTkFuZVljWnVhUjJjWWp0QmYr?=
 =?utf-8?B?U0JnRGpCd0swamo5bWNXSVlTWFJqZEgxY2E3MVd5M2FPbmFEUzFVaXFEd0Yv?=
 =?utf-8?B?YkFNUytPYU9HcUM4dk9MNEV4SGpKbW44UHlqTnRpT2txNkRKb3dKOFBxQkJ0?=
 =?utf-8?B?ZjZ5cVJCSm5zTkEyVjU3cEVyY2o2bGVXa0tnNzNYMmt4L04rKzNDNFcrbWh2?=
 =?utf-8?B?K3NpcmN6NlpYS2h0ZHFCMkFYa0pia0xNVDNMcm5KSzJjY3JmL3MwT3hJYUF0?=
 =?utf-8?B?YUVmLzNzcU1maWtSVVJzZVI0QWJGVHdPdnhwSkg1SVdRUyt5eVV5R1ptZk1L?=
 =?utf-8?B?ZVdVelEvZjlYb1ZadlRxOWduRWdSalBPU1JzdmVhZm16clZnU1Y5NklyekIy?=
 =?utf-8?B?TlNYTTByeE0weXg0YmJmdHN4alNWVE9ONndKVVd6UjA5WDhkdGduSkdBNURC?=
 =?utf-8?B?T0lraHpSM2VoREtPdUhCSTN3aDErLzUxOXBlMzU3R1JsN043eDlPUlZhZ2dV?=
 =?utf-8?B?bHZabW5WWHowMEwyNDhrS0ZHSlVNOGtieW9sZGFlbWtJdzJwVHpZczZmUFdJ?=
 =?utf-8?B?WEFleDN0L2h2eUx5SFkvd1BkQ1hFQVgxTVFpazIzdU5ya1poYllMNHZkR2tk?=
 =?utf-8?B?amVldTFFRVhwaXJCck5Ldlo1M1RiSUFZMG00cE1nbElrMjlPT21DMDlFYWZY?=
 =?utf-8?B?WGxWMlc2ejVSNU9pZWM3Zkc3dnNoNTR1anlIUVhqaExMOHJLNWZoV2VSVXR0?=
 =?utf-8?B?NlgrVGhkaWdFQzJpNm5MUGxjdnV0SVo2TnpUWUNIY1IxUjFpd0VyQ0R1SWZR?=
 =?utf-8?B?VWRkaTZnYWdBTCtsUjUrMU1NSGo1UEhieWpERThrRDh2cC9DM0RnSTNzSEda?=
 =?utf-8?B?bDFjSHp4TGF0VjZkZVNTMHQxYUpnVzlIaXUydEZTY1pNai9MdHdQVXRBL1Va?=
 =?utf-8?B?ZHZDTVIxajdsWDRwWmUyY1d4UXdlcUF1RnIyMXVwcEFDK1BsYTNkWG5jckNq?=
 =?utf-8?B?K2JzeDlEWm0wM1pJWmwyekRHS3hVVnkxZjM2Z3lIR3hNWXRPYVRxY2dPYkdH?=
 =?utf-8?B?bEVqbm1uY2hTaW9RQ1BFL3EwNVlZM3hScU05MnBHZUtjbW5UdjE3ZURBaTB5?=
 =?utf-8?B?dDBGbDJ6WllOdGIxTWlPOEVBb3V3blhKd2JaUENiZEIrbmZxZGI0MmNvUGxj?=
 =?utf-8?B?UTRGOWZadmhLRGN0ZEYrUGxqYUtzdUNsQkJOMWdnV0o3R29IWTZjNDduWWF4?=
 =?utf-8?B?MFBDWi9lNGVRbjk2Q1VBcTE1Ujd4OUVmcnJBWkhET0hEVkZ5dUR5S1k3YU1O?=
 =?utf-8?B?anl5cjdMaW5ORnc0bXhrQ2F5Y1lsbnFKMGxKUXRNN1M1Z1BCeUJ3d3Z1NkR6?=
 =?utf-8?B?YVR6d2R1cHZWcU1Nam1kZTdQNzFNVmdCSDRtTkp2ODNyNHhleTVnNVg3QTds?=
 =?utf-8?B?ZWNrUlVlMGN2QmExQXRGais0MWhLcXdJbmw1TS9pczVUdkhBbWRzbHBoUWZj?=
 =?utf-8?B?K0NtazBwTElPTXZyVXFUdnJIZGNlcmZ0UEc2NFhyMXNlSGZMMW43dG90WlBM?=
 =?utf-8?B?R05qeDgxKy9PSHgvbmpxdkNzajNSTnIvU0syNDZSbTdPODNBSlNlcmdyaFdq?=
 =?utf-8?B?T0dkTE1yZnJpdFMwdXBNU1Nqekxuckd1eERDU1JUSitaejJRc3B2WThjL1BM?=
 =?utf-8?B?TFJlNHlQSkN6SnhQZUFySmc3c3h2TEgxQjhvWmJRcSswRXoyOExFeHAzbTYx?=
 =?utf-8?B?SVlQdXhiWmtiMktaWWVGdDhMcSt6T0xKVXpyL29LTFkxZklzanBWYXJmR1pj?=
 =?utf-8?B?OFpWSko4ZU9oaDRIVlQ0M29YVEhFWWRLaWNlTE9MWGNCMEY5Nlh0d2ZzL2Zi?=
 =?utf-8?B?OURIUmdlY3Z4RFBUWThsVHFFVjhHL0Z1U0draXlZSG9XOTlqMSs4M2hsbkhR?=
 =?utf-8?B?TTUxamFKRTlDZ0g1TEN1RTVjQ1hnOFRzSDJzSVRFMDRoZytxTUVXTDE4M0VJ?=
 =?utf-8?B?TERLY012KzhTaC9sQ1VWUWU3WS9jRWNSejdhUTVORUU1aW9SVGY2UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d74abde-6cec-44ea-25ab-08df39729054
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:20:32.2455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8c832UGWP/aFcWjvX2D23Y9KSxI4VNJtFbavwVXTZZ1+uP4442evvC/xND6aV0AJKQWvSwn0YfVmkuy7gpdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993
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
index 80d9c9e9a1a9..4bd0e4ea8495 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8813,6 +8813,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 
 DRM DRIVERS FOR FREESCALE IMX BRIDGE

-- 
2.43.0

