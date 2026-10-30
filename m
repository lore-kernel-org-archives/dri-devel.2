Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD593606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Jw8DgaoW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B041126D1;
	Fri, 30 Oct 2026 09:53:18 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9F410E865
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa1XGdBMtUls+o9kU8WOcgl/1SZ3omKpyQ0Fp/HAlRNXoeCIYCE+u1MgphPUshHJ/oC+Oz2KpqXXqUSoqV7Be6pt1bvKHRQf22VpQugj/7bM0BULYsC9pQ9y2nnea8idLKHSXVxoqetznR4BxXjqDwa7sPzkw+u33V2WyQxJzTPqDjjsPfsyBLWrQdlmDOR0d5o+vqVVJ7RfXqCpLgI2wtgQlZ8lf+SJ2bIt8f72pv9PJy4lrTGOnqcoEHcSgKrhh4uFVY9+RSFZ2B9ksSpp6Lt29xTQvZviQogT2ydJSVLnDtfQ6qjUUJsRe5eBxdzQ2Ff6OShfv6iFanMsSpCAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJPb65xdCggsCd4rDUvrzjjr3FMznVVlmFXpXbFDOmo=;
 b=sHs0l7PWqp9vJUFI17PR7t2r0hZGu8lJKd9ocp+n0wJjdoRidtytME6d0mYq7g4ovT8QTgO4ME3CE2bZOy/KF9N3hg3oPcjx8yfKxg1djgDrvfWcQV6kR+dhmXffdinEbPsEjG/wUkiHzLugUAuh6Uzj1caKWiXNUXVNjHHL+tTziY7WFO6zQrvbvFpriud58fzqzndzRQpODfgCC3qaz2Hmmd+Xn2UdOe4XZU5z1t/b6iNq3h9o9GnavHF/Cr4uEnjOlZ9oKiy7qHDpZ52pnQ112SiJZz13Nle2lFpYFc3JJxnwhKZj45w9QYplSLLd/w5PzkbcKQbEgaBKmJQSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJPb65xdCggsCd4rDUvrzjjr3FMznVVlmFXpXbFDOmo=;
 b=Jw8DgaoWVFFVGK2ITI3HAiBeBb5BgiH7JqTSjX9dAFn5cXKAEZcqkdz2PJUOyYqmxbKgYFNOKVC9uB5pdBlXGEtD/6XARpJ+ifQTjAkWm91Sotz4KScwscl7p87i7SFHuRUsmJwAcUD884Kw4S0zt5M3Ar2+xSALYY4Dmz7dl4TgJ2QJaCW7CVNQEDFKwAfF6bm+kfbxZrAVmXwK/T/9xWD+McMSKqpSz/4hQLjKXg7SjYm7ChDAXcgVolSvLD7rT9YAsqb2HjaEC4IgXPnNEw6/vqxUhX9yuDyuAzGrMVOHomlVNJWNDzJBC2G0iFkk5HV0Uu0fYdwB3K6GJH4rUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:06 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:06 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:26 +0800
Subject: [PATCH v8 02/15] dt-bindings: display: imx: Add i.MX8qxp/qm DPR
 channel binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-2-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f27abd6-abd9-4daa-a53d-08df366b98d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|3023799007|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: j4aPkTZCJEiGMUgPHqfTQfJrdCDiwnVvftjFO/Z6vpsYJ5gG9vLuiAEfZVa1PagBxqjH56ofCloUAp8jF416h4QSiJWmh1+y5MotZmk7YT049waCIJLQt/wsuwWT49zKPz5mEWAygXC4tXTkg38AQk0ueYf2Ei1PSXtTp09QOW4J+5h4jSFfzKHxgQ6k5Ml11sJVqdf8S/VEozGRmlpUNTm7hi7nPeNjdZFFu7TlP0ywBGQ1Fqr//xfxnTNsSbiSOE0vNXc3he8TPandJVLdyzFKWXcu1Zm76AUH16wuTNRYCIY9bk8WqtmiODVeQbo2PRdD+jxFG3Z8HdUXi/rqY4MXejdwZaffq/65Fv9r4ECa8rj62UQzxiREclog8NBIV3J3omsV9OJjgUAtjKWEbwC5eO4PxrMsJdpy7gutOdU5u+IaSQ/efqawxdZeklWUBJ0AXNf1/eg1LAbU9r9/rVAz5vjn+Eh3M1SVDWYQuxhz+kK7aoRTIOSWvRXk5GsMIRZIiZfYLJqYmFHhaK0fxzrPtVF6hUxnAbModcjOy4GQP2wFZiq6EJ+HWOF9VPHtEMxGKny4BcepCLE0bKYxtgS8KjbZWr7dq5nHOkzThYK27aQDaZ3V2h78tIIKFLCZolTwe3A1lyCFwf0preCU6osuyihzNt876oMEqNgKSkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlZakp2cWFDVkhxaVlQZXo2MVhrRmhBS0pvamt0WlBIcGdLMGRlT2RZOXNY?=
 =?utf-8?B?TUdlZnhBUmxPUmk5SkI5RHZiWW5pYVZLb0Noa0hwMHNJTHhlTm0wVWFXUnVH?=
 =?utf-8?B?dmhsWDZxWTJLaG1CUnBIck1ZaFlkVk1IWWNlbTg0bTY1K0d1UHM0eVhvTS9q?=
 =?utf-8?B?QjJtbW5PVnVNM1B5UzB0YW11Qk03cjJuT0hsbnE5N2h2WlduKzErRnZ2Wnls?=
 =?utf-8?B?NHZDRGV2RTBTMXk0cXFSNjhmZjV1LzVxTi8ySkE4R1VYL1JOQzVCdGZabDJV?=
 =?utf-8?B?WmE4OXdtYnZuYjRLME1ZUFVWWDRiL3hBT1JqQkN6b04yblliS3ZZZE50aEYx?=
 =?utf-8?B?eEJ1RUJpS2FSdEF3bzZIK2R3UnU2cEo1NWc4R2pEK1pHL0RzSFlpV3BzR1Br?=
 =?utf-8?B?OVBkR2JJVWM2MExrOUp5S05TczdxK0dHajFuMUw5S1dnL3F4d1QwQmllUE5r?=
 =?utf-8?B?R3dVMHdJUm9NVmxLQmU5QStRTE45YmM3WmVWSmViVk85NzdodlpIeC9FRThE?=
 =?utf-8?B?YjhzYk9BcU16QURyblFHZ0FjdHMzNCt2a3d4d3MxOFhoM2VOc0Fqb0dPclFC?=
 =?utf-8?B?QUlZNzgrQ0d4V3hTb1MvOUtSalFhVHMzLzkxMGVHRUxNYnV4M2FlQ1ZLN2Rh?=
 =?utf-8?B?TVNQU0QyWi93L3I4SnA4WFpPVFM5aXdvbHZyWTVyTzI2TS9ab01FVURFYjFj?=
 =?utf-8?B?RW9IMGpwc3lvZ1RnZnB4WTBkWlRQbUpvS2RXcEJpckJVenduNmtleE1RTVFu?=
 =?utf-8?B?Qk9HVkNwVStMSDJsSXAxQ0JENWRWeVJWaUJxQUNNMUI4OG1uYTY3bmhRRjg1?=
 =?utf-8?B?SWk5dk1yTUhndjRqZjRkc2tNMmw3bi9HVFdmRlhMV0J6WmhQSU1Xby90Z0lM?=
 =?utf-8?B?cWdEUlo3YmY4Y2NkcVRtZTVZTXhMVWJHMFFlV0tXU3ZOOUk5eUJKMSs4QXNQ?=
 =?utf-8?B?TDhoZG4vbGMyeHZQM3NXOTZsek9uT1IvUjlOYzB6c1Q3U0x3ZGJQMDVaWWYv?=
 =?utf-8?B?ZzNUQWl1ekIzV1kzUllLdkMwZ0JCWEQxUzQzRmtLL1d0OEtlM1BLaFJyZ1NE?=
 =?utf-8?B?WmV1eC9obTI5SVFxSXBCRTM0MDRsdGkzVjlrTDJPalFDZlMzK3IxMWhOWFNZ?=
 =?utf-8?B?UVNEVDBINGZpajExK3cwRUFCNEdCRHA5bldMckt4dml5WnpYR0RHVDQxODhD?=
 =?utf-8?B?ek5DMUNUZHFJOStYTEQ3NjF2bjBxcThKU2hRQTA3NzRvdjJjWEUwZ2xTNUk4?=
 =?utf-8?B?NjNIQnlRalpTellWQS9nS3hma3pSTVNqeFVoVVVCR0UxbDgyMmJGbnJ6SkVZ?=
 =?utf-8?B?YjlpVWsrcVAxVGwwOEx6TXc5UllRNTZJUE1lTzlPR0ZweEJLcXIyaDIwbHRZ?=
 =?utf-8?B?aHkxbkFCWENLdy9abCtzSXBkZzM3VzV1aExxL09kYXB5K0preDhRdnZUVFJv?=
 =?utf-8?B?dUNlcEViQ0FwR2NSRzl3WkJuRVRiYUcyWE9NUUF2RHBYYnUrT08zblhNYkM1?=
 =?utf-8?B?TVQ3dm9OZUpHcjh4d2liK1Vxd25ZK2daOHNJMlQwR2FIZWJJV0xvUldJdGVv?=
 =?utf-8?B?eVZwdWVnSUM4UEVMN2dyUkJ3bVgxUzZSeDcxaS94UVI4bkd3R0s4TWVWTDl5?=
 =?utf-8?B?QnJSeFJFakdEM3BQRkRhcDVOanYzOHFqanNUNDZHM2hNM0ZPaTdPSEh5U1cr?=
 =?utf-8?B?aWJjc1JhWEZBMWNpYjRDbmI2d0l6NzR6MnVXM1NNZHorbUdEYmRCL0t1TG5k?=
 =?utf-8?B?YTIwUW5CcHJhZzdySnBrWllzalBFTDR4VGpIQUJoVmVWdjRKSFQwMGxwYSt3?=
 =?utf-8?B?TkJKRUZlZzRrajl0ZW9WWFJ6Q3ZrcUNRQTNoa1psa1JRME1UOEhiaitTSXFn?=
 =?utf-8?B?V3dQNGdFcWtpYjl2N3EzQWF3TDBrQU1aamZmcnpscEZvRTNodjkydzhCNjgv?=
 =?utf-8?B?R0tyZjRsK3hrUGVTVWdySTl3eEVJWFN1OVZkUWVEZ0l6dWxEUUhQOEZsVDlk?=
 =?utf-8?B?R3A1b2RzNjZZVmVXYUFoR2JBZWs1WjBjZ3I2R1JZS0ZlVkdZVUlHRFZGenU2?=
 =?utf-8?B?aXliQndUQTNEeU5NdWd2ZkZkY0ZwWER1ZFRrd0tlNzNSWGJ0QlpLWDB1V0px?=
 =?utf-8?B?NzZHcmV5NG1KUGZNMHFqOUkwNVJIcXNSdE5PbGZMZ1pzbEQ4YnY2aDdxUk8v?=
 =?utf-8?B?ck96WmxVWFhWTmdYU1VFYk5IUmdKTUJBM3NEc0JWOTErOW91dGU2TWVlTHNh?=
 =?utf-8?B?YTBLTUZQRk8wbndaTXBMWmxSL3lpOFpXdC8zTnhucEpvWXZTcmtGV2NxeXJ3?=
 =?utf-8?B?azBSdnUvanoyMGJBV0wzd3RNRkZXbzFHS3R1WlgrL0d1UG5IcTF0Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f27abd6-abd9-4daa-a53d-08df366b98d0
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:06.5137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GnveMhQynFZ/5yTkjlNo+ppf13V/MEZASAcAoThJ8cx6fhwWiZJaWmVeEGlmCqqTeMtkC4+c0odLX/kXjkg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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

Add bindings for i.MX8qxp/qm Display Prefetch Resolve Channel.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changed commit message to use imperative mood.

v5:
- Add the DT binding file in MAINTAINERS.  (Krzysztof)
---
 .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 100 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
new file mode 100644
index 000000000000..bd94254c1288
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dprc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qm/qxp Display Prefetch Resolve Channel
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The i.MX8qm/qxp Display Prefetch Resolve Channel(DPRC) is an engine which
+  fetches display data before the display pipeline needs the data to drive
+  pixels in the active display region.  This data is transformed, or resolved,
+  from a variety of tiled buffer formats into linear format, if needed.
+  The DPR works with a double bank memory structure.  This memory structure is
+  implemented in the Resolve Tile Memory(RTRAM) and the banks are referred to
+  as A and B.  Each bank is either 4 or 8 lines high depending on the source
+  frame buffer format.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-dpr-channel
+      - fsl,imx8qm-dpr-channel
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    items:
+      - description: DPR wrap interrupt
+      - description: |
+          'r_rtram_stall' interrupt which indicates relevant i.MX8qm/qxp
+          Prefetch Resolve Gasket(PRG) or PRGs are forcing an underflow
+          condition in the RTRAM.
+
+  interrupt-names:
+    items:
+      - const: dpr_wrap
+      - const: r_rtram_stall
+
+  clocks:
+    items:
+      - description: apb clock
+      - description: b clock
+      - description: rtram clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: b
+      - const: rtram
+
+  fsl,sc-resource:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The SCU resource ID associated with this DPRC instance.
+
+  fsl,prgs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandle which points to PRG or PRGs associated with
+      this DPRC instance.
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - interrupt-names
+  - clocks
+  - clock-names
+  - fsl,sc-resource
+  - fsl,prgs
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dpr-channel@56100000 {
+        compatible = "fsl,imx8qxp-dpr-channel";
+        reg = <0x56100000 0x10000>;
+        interrupts-extended = <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+                              <&dc0_irqsteer 324>;
+        interrupt-names = "dpr_wrap", "r_rtram_stall";
+        clocks = <&dc0_dpr1_lpcg IMX_LPCG_CLK_4>,
+                 <&dc0_dpr1_lpcg IMX_LPCG_CLK_5>,
+                 <&dc0_rtram1_lpcg IMX_LPCG_CLK_0>;
+        clock-names = "apb", "b", "rtram";
+        fsl,sc-resource = <IMX_SC_R_DC_0_VIDEO0>;
+        fsl,prgs = <&dc0_prg4>, <&dc0_prg5>;
+        power-domains = <&pd IMX_SC_R_DC_0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d9a6bdc65826..cbb8aef958e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8806,6 +8806,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 

-- 
2.43.0

