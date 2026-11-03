Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D378606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=US9bxoF4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8493310F389;
	Tue,  3 Nov 2026 06:20:47 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013018.outbound.protection.outlook.com
 [40.107.162.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879E310E343
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw7B7u34FylZZPV11F4/0/NZG2tDiapwQ8P/yHvBXM4VC5Qp4c40DSqOrezKPJuGSyR+RTFb48P7AOhtmjujgkywWi/FeGZTNpMS1D2s4g7F3CrsEKy1ZXpuUFwISCX5c1p5OCvA4Y8UamnYOOr7POxOBQUHc564aq2eiw7i91nuPtf0ZBcs45HKkIAkReWNXFA56Jp7CSC7sSM5tFjYxQkxfVVm7KYZ9ouCOvh3+Vu4/mvkT9UwG+RkBLDsaVvsfIUEt8X+/BaJNKjmIa+rVShzVFqGl3+yBTbvFoTe3TNZLl2FcKeIDhmzZgXg/REsl41J6A4DKHGq/IIRgupF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATDFYt/a16AksGDJO3CNBHFkCS2AyL6c87N+8aO10n8=;
 b=iqmwEBLESApkiWpdRdLLh+klUbkXj57CoQFGB0jISZApl1/j3YoBuVk2drlPB6EC8JzOw0Y2RK/heXN2+r+sKNpiO9Hr5ea3f0sXbxJQLBHg+0+Ur8h3tXgPAorCzCjaG8ue7AFw6MGEKlYnY8RJOOcfUd0UzZl1NsxZWAVY8H5QMg3dayYw3fnGO2ZcUKHzHSWgVFutK0PPFpxg5Vgw2P2zbIPzExu0RZovnFfJEpe4eTOOlav0MsoRycotsdLjSXC/bbMslczsbdOgZg3MCOe9YBQgraA2fxKsFhu7/2vYxfp0aTxSOPEc468Cpf+ejKikqX0uGSjGVwW0setemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATDFYt/a16AksGDJO3CNBHFkCS2AyL6c87N+8aO10n8=;
 b=US9bxoF49ErSGmZd7dL7u2/zLVHuqrHH+jH/l/8gBtvML61pgNpGTzzsbaex+RW7T3xWyTAGvPxaFmvRWOAVnrXpGID8m7272Tq2qkp1HVqtfsUgT60rr7xr6HkCV9ha4YqRYYLE+n/sc+8W2neda0LXYZNO1Z2ryy7+0+iDohl7wbA2oLY2vm/wTaFX+RbqNKbehro8Ryk9Jsvaiacq6tLEvR6IPrTLkWrHtXAlSz9Y2zi4WThaKLlPStCV0pAb5gMbMx1EEOM7PJNWdfirvMJ77rj8NbIWodTLmI3QsEFGuG0ijO6QLp72yfyvYni9UdddQ10ceggeUTS2wfrPOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:20:38 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:20:38 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:21:58 +0800
Subject: [PATCH v9 02/16] dt-bindings: display: imx: Add i.MX8qxp/qm DPR
 channel binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-2-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 52518b20-63df-4d51-0345-08df397293c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|3023799007|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: HCEqXkrI0uSr/Mgqjnaa04PugFt9icYN0pEpQePUZ1/V0cvQsJAcQviSwOPyPMh7b44OozMGdMnmJDwY8NRf57tpTqU8hZ3e9vjAXjZ7L0z3fXzTxii+mNO7O4M0eYRy5tnYk7ARn6Y9ZCSG0y3Y6lg0RD8oIM+pQZ/0dXEZf8PQj7gs4CklYBVHX+PENy/0N3w24Hr3/WyWSqwUjcClOR9QYA/n+I8115bJHugHut7GA7J2271q7HYE56PTCmJALJReYrkbnFZbI+RIxxUxRIcCtYNrNYCYi7/QNGCmo10aJo4ZcixfHEC8xhybu5liU5oHJZ+/rIDt41mVDX5C+wgHg+AX1TdYWyBdZvI2CHNOUST4N/fiA062bMmk08pvPGqsz0MS6RgZDbtzpDOblho9LhJPz3ZhPCizPG9ZpAbi5lVoc5eE5XdDoLbndlwMwLj/2G7TFNi4NQ5U8bZUNZwqBSlwUQEBs8hsOcBTcKkOT5KG2Hxilbwb11CqO1D4s6kjhZWRFnTOhztGTH0J+jpdlYMj9glim29Vlu1xJfWQb7HAFVGqiMR27a8gMc228tNw+4lWkuOuArz4Yc0YMngfuiIdJDytHoeWiVJpNtv9jT/i+dfoJDQCTk83zidAR+uVqinQnPt5sXJfO4bjS1+ZwMCRBMkZuHp98cBkavM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(3023799007)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWV4RE9zbnlJWkd1UmV1c3V1ZnFDaDROOVA5ZWJqMGRLVVBQd3ZsYUlmWTI5?=
 =?utf-8?B?aFhTSlRNOWdEd2k2UVFKbDI0WVJhSHJqalJ3b0NiTUNXZmF0ODcwKzFNYjhv?=
 =?utf-8?B?RWR2cm5Fa3NYK2JUWmJ0SVEyYVBGWmFBQ3RKYWZ4eDVFY3VxTEZ2YWV4eG80?=
 =?utf-8?B?aUpaZWw0dnN5RU0vcWdDcnFtSWtDYmdCdkFwWHlKRFZSUXhDY3JpWE5LRFJ5?=
 =?utf-8?B?WHNCT1ZhajR5UEhGMGIwRUxyVXZMQzhVWndlVGJ6bXJYZDFqeGF2MXpZNlBy?=
 =?utf-8?B?KzFzdVlVWVBiSXZ0OGpUd2RQempIV21jWHdrNzNCRFlBQm5VVEUxRUl0ZUsy?=
 =?utf-8?B?VC9rQVJVS2d0T1QyOEZuY0pjaHd0UjNlTDhxYzljMG1KUHFndFhwaG8ycisx?=
 =?utf-8?B?MVVoa0dPSmM0b1FSLzl5SkUwZ2VZNHlqbGk0bG1ySEVDRmVFODhhOWZ3cmV0?=
 =?utf-8?B?R1E3cGlXeXNsWFdoblZHZlNvYXdrQUw4YzR2aTJCMGl3NTBtdUdjanBUL0pY?=
 =?utf-8?B?TlhicWtzWXRiK3VSZHYzWkUvaHFwTHZTc0JYZmo3VC82Nk1wU2oyRG1NZVdM?=
 =?utf-8?B?RUNMajNEak93U25QK1JQdWNGM1ZJNWpEY1lvRDFIS3hKMHFOUkdrNGdqSk9o?=
 =?utf-8?B?NXNzZzc0MUVsS1VneDdwVlJMUXVvMGczUGQ0WUxCUWhFcEFmZHJyWGtoY0pq?=
 =?utf-8?B?Zms5N1JROFFpUk1kcWVtZjdVSEU2bUJMMVBlL0xUR1JtbndQS05SWlhTdldE?=
 =?utf-8?B?WXRkM2Z0VHk1OTNPb3kzOTBrdDFSSkROUEJnZFpkaE5wTXJha3owYmJqQVpj?=
 =?utf-8?B?Z25jNFpRUVFNaXk4Y0VHbC9xTDh6dTNqeFFDRlQ4RW1VVk5idTZRUDBUb3Y4?=
 =?utf-8?B?NW0yRE9CcjB6aGNJMHVScStsaXh6YjNVVXk2THdkbVJaejF6QTdLd1A2eFVP?=
 =?utf-8?B?UWJBTTVkQzY3UmtIYThBY0xybTUxNFV5RkFKcjNkNTh1eXJYWEFmb3IvQkg3?=
 =?utf-8?B?Um9vR0lPS2VSb1ZuUEJUUkk4T040VWxYRlIwM1dDalVDaDdpai8zM3NKUWll?=
 =?utf-8?B?b0hyS3E0WEJoYVJ0Q29lajJkV3dLc3dXSTNPMUttS0FIZUZDYktHUXo2RkUx?=
 =?utf-8?B?M0doczJXN0JFMTVkRXNleEMzTzZPZE9uZkFKSlpCb0pBNG1wTldkN0tDUnEz?=
 =?utf-8?B?UGl6OXE5MW42eVg1WmFJYTUvRXBjOExTSzBkSEpBbTZ0UUpJeUJjVGs4S3M5?=
 =?utf-8?B?TW9FeHk0TFlCL1lJelNJa1A2aVhHeFdhRnRoa1dKbmE4KzhGQXN1M1lRdERV?=
 =?utf-8?B?SjBTRHZXUWE0Q2VIK3lCaEp4VFRscXhNaHZpUU1KMWFwTXlrYllPMHZEdnQ1?=
 =?utf-8?B?a2J0ZDJPY2JmRmFQMmh1MWFoRG1TOEphK1ZsRmpZU0wrRDhsc2F5TUxxT0Qz?=
 =?utf-8?B?NkFtaVZ5MGZoYmU1eGZVbThmNWNKaEFWdldueE9WeVZrbFBrUFVFY25TbEt5?=
 =?utf-8?B?WlJHYi9VRzZ3Q2V0UXlIVGlrb29WWmlDNFk2RDlXaTN0eWxERHpNL0hIQVB0?=
 =?utf-8?B?UzlXTGpiSGdKVDBFZUpMbVZGTC9vOTV1dGdwTHJjd1krL1Z3OVM0bUZxOEVv?=
 =?utf-8?B?UTRGRVFxckRDUkRKUjg0MEc1S1BtRGlYdFd4bi83eDVPM1ZBWGNKZTl6SU1P?=
 =?utf-8?B?bjJhbHA3VWRGUlJmcHZJY3o4QnljcFVoWXFwRFlOdDVSVlhqK2FEc3AvbDNI?=
 =?utf-8?B?dElnNEY5VmI3bWlNaEhZdVpqNjZZR2R5cnQ3L1A2ZWFiYUF6bmJNSWUzMEZ6?=
 =?utf-8?B?SE1rWmhDakI2SjZKTTFIV0NFWWNEbTdlSWl4SzFzZVM1T1hUY0YxZ2pKMkd2?=
 =?utf-8?B?amhKSDUrVjEzWHFSVlRFaUwwNWlHd1NZTktBTGEzYVJyUFFCQUpoa1FLM01S?=
 =?utf-8?B?WHlWUGpOY3UrVXVFYWV6VjJScTd0MUx1b2lkS09tSUNGS1VkSkVpZG8xSWQy?=
 =?utf-8?B?WTloNTRWeTFiRzFPVkNnd2xxbU45NHBDWGRDY3lBVWxMbU5SVVF3L0lJQmxj?=
 =?utf-8?B?TUtCUFN1ZEQvT09sMzdxNlE0eTY4SGVQUUVCdGhKek9HdzZyREFNaXN6Z3Q0?=
 =?utf-8?B?a21PRmtDK1RmZWV2VlBrdVZadmtiRHc4Y2ZQQUxIems2T3YyWjJVR1JGc0Jt?=
 =?utf-8?B?UnY0dkVWNkVhSHFQOUZRRkc4RFQvQXoyU25Uc0kwMkdiVHQrc3BOMnRIaWkz?=
 =?utf-8?B?emlsSFA5M0F6b3R3N0w0QjZaWU45RGRybyt5R0JqSzZtMVB2cTFkY1U3dDVV?=
 =?utf-8?B?ZUlBWThtcGNPTzJ2YkhqdVgzaUwwZHNOZ1hPSGt1YWZ0LzNLSDVrUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52518b20-63df-4d51-0345-08df397293c2
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:20:38.0593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0oR5HEWKloNJ7R9mfdSGh9ZwdgIVIlsLfxkS0Z95BFY4BurWXU0jzTst/dKfSM1AVUJN8dNfUbxmyJkbMysiQ==
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
index 4bd0e4ea8495..e04da44e0bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8813,6 +8813,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 

-- 
2.43.0

