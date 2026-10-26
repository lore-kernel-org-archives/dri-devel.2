Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87460A2608
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lbJz6e35
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFF310E1E0;
	Mon, 26 Oct 2026 10:03:54 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC65910E1E0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN1kG1pAI3keVy51A0YPL7Vb+Otah047JNVCFQX/RITEpjKOGU+LbKUfiKvdRGFcSySdurp0zDxh8Eh0fBD7rvHubdhbD43HWJdI6QsL6eIJyWDYmy9H7v29TvoftZG88+Hf/x3T31WCQK/dECqiZq1B26QqpmQu/v2CtLhZyOTtRf/GJfgb02Ijz0sCXPnpvzq4rZhT3b9rAiZZesBffFPtNeyjwOGw+gc0K9iThSoTl29TOakj9e9HmwLmRQycIKAh+2YL6UOt5pPjT0f++U3qnhfm/6iLgY8IuRLlZTtdKNK+Nzp7htOdLmUi3u1rNeBrDa7pAItBAHurT5FJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJPb65xdCggsCd4rDUvrzjjr3FMznVVlmFXpXbFDOmo=;
 b=QpJqVMVegNymwGLUiUPIcKaglukK+l6DKuia5Ela99D50YEp+Z2WswfruR2BRNTUQz7x0wFSVvhbAXIjdFgk+4rzBdzakXd/Pl+cFUOmHXzsDwUIUojcBGL8RfLhuNQOiaQQ6N7AGp+aV2W6zKYaeuPS5r9QFwIHCAxIJ0BD4RG4qKPf1TOtnRvSYy6i4Fy7XGyTeAQCJWw1yVG5q8bDMuuaYQ2T+L+klBZ/XPcqvADxJBhPdTT2vuQvV7ak3u8NK78/fReSGcpb77ZI32+i3BEMVPn3/j4qB+NUQZ9tyR5ZILcrKrs862UFbsz+DEcT/LRGOqM915sdHSsEGt46sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJPb65xdCggsCd4rDUvrzjjr3FMznVVlmFXpXbFDOmo=;
 b=lbJz6e35hz5tDnqRAwTSIiGtv3RClhZjKuGf8QRsxrXm/TohzghRM6fbKfiotZWu8fMQaQlgxxC4xmXu28J7PSFcxedkt2cPmpxGP/B4pO5cGEEHOk/KCqo4QRvd/PF4/ekBrTaSL9cwDORWpZywjgs6g9EzfABzeE9Dj6kl1Hdqm+LzlFqF84/Ds1A2EpKLNLNtRoxmekQgTtDG1OqnkNErPll3eN1OsHGrle9C4jQrj9lKp7w72wcl37/Xg8yTvKYKG1bP83mIlW9VryZO7T9LSjZt2FYHWlyTvmRopRxv64wNnybh3wOsYRnKayFSTOwSzDnDy7GIg2vLlqoKAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DU4PR04MB10529.eurprd04.prod.outlook.com (2603:10a6:10:55a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:03:46 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:03:46 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:07 +0800
Subject: [PATCH v7 02/15] dt-bindings: display: imx: Add i.MX8qxp/qm DPR
 channel binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-2-a0b50cc4fc65@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34be0108-c954-4096-4d19-08df33486cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 7952NjKebOzjzG1oKLhjo0aR+yWiNy1EWJaXAzgXHU7ncI4NJi2yM9nz2PUwfh3/ui7jpuYz2qNHLdkpal81HuhNQcDo6Cu9qiAi9p+XQpzpq5xMYib9YrjLQfduPcCF1N4Q0zWM7sYeoF8mknqGZXA2OMaKljLC8TGhxAEAbFY+mk1VCh8Aj73JI9bAns4iFoE1fWYZcwnydvZYEpqVYfMUvyd2JeJ20IbThuBnRlPdNKHiZqlH+UyBKJpE1x26jokH5Zwt0QOOoq68Ub93OLRW38rH2V7v0cvw63Z0dfV+G7cDb/mdTFdH83wXtRzji8VqKr19jdF21sUClfRtBOkQcb8q5f5PcwMl+funoHHUXNkSCgpDAfE6D02n2sH7FV23lNos3iurZsUO/yt3Wms7r2Rrwuqd7SnUwEGeTOxl/vSZsu14tB5f/BSxgjPbrahPpBVYtR+aqiDKKiwJXEU3FyWDhfz4U2E//Zy3LAvob2Y4GhX+H6WqnnvdT0CrHcdsTX7h8FbKQsP+LP8MSl8xgxEcjm1lTpetIRP2CIra6YyHuivc7w85aBKP763OXP3Sin8j4y1NCDuogl94MpvlgQgjLjVlBERbFFuS2cqbZDpVwLw6E2HkoEqiLTCScvKuUYsPASiF2Es6xU+WGIG/YuhjPCS8tCI15xFJ7Dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRPWHNTbGdnaFd5cmJOTVNHc0FVQjBoalgrUnhRdlJPN1F5TTFpNWlDT3pW?=
 =?utf-8?B?RzJRWkRwVTZTUzJsR2dqNy9LbWt6eVNJS3lNTFNZeFRlbFJUVzZoUGhwcVNl?=
 =?utf-8?B?VXZsaFNqSTBra0lqTU1FZEt4MFBOMGRvUm10UXFkdmlscWYvVVlJTnUyRWg2?=
 =?utf-8?B?QlZWYTRMMk04ck5VSHljS3lMSUJ5ZEVqRG5CZERuYWthZkRBdUNORUdLanBJ?=
 =?utf-8?B?NnFCQktIR0NZeU1hYmFsZDZSMXd6emVvWUl3VUFuMnVJdDZCZStGM1FiVTRu?=
 =?utf-8?B?cmQ2WkUxOVp3Zkl2UU1SWG9BMHJlY2FqRkl2cTd6REcwektXbFlySXloTXJy?=
 =?utf-8?B?dVcyWXFmK3djQjlXQWFGTWVBalVxd3NWcW05MzNSbFZoWTZhRmFXaXJZNWw4?=
 =?utf-8?B?STZNS0ptSEVOMDhGNDNvWjJ3dzBEZUtkcTlRWG9MYzg5dE5nbTZqaVNYUjRn?=
 =?utf-8?B?elFrbVBsenBmVjEzSFlWeFZaMTErTXYzMW02YmRFQ2pCSWg3L3pXWW96SWkw?=
 =?utf-8?B?Z2dzdFhCVWhhWlQ2bTNaT0VhTU5UYkpXa3lrYTIyYXFScUN5N2dNZ0FRWFpy?=
 =?utf-8?B?aEluMm80VEJEN0lBRjZCc3gyTEVyREo3VG1ESEpnUi9HQmo2ai84UnBLaFZU?=
 =?utf-8?B?MEhlbW5RWVd3QjhFTkM1ZnpuMWhmaXZ4WjRFOHBmdERiclhoQ0huMzNVYXlk?=
 =?utf-8?B?MHhmdGRCS2xiTVhDVXh6dWFvRytleXFqU1dBUFhiWjFBQ1kvQWFDNnNiejNC?=
 =?utf-8?B?aW1qOUdoRUlGeUE1VkhCS3pMNStjcUNPaTlNWW5NbEp2OEErU1gzb1ZNTlNi?=
 =?utf-8?B?Y2ZyUlhoSHA2MDlZMW9hdnNpOFp1ZzBPRnVCZUpRbTRDVnI2dVJLT3NOOVEr?=
 =?utf-8?B?ajhWYmhueXNJOUxlSjBvNHYyY3NxWEZtUjM5Rmc2dmFkVHpuZjNScEhEdzR1?=
 =?utf-8?B?ZDJFYlhXMzhMZEIyNjh5cTBnWDZYYWRkV1RZTjNOcmZoMlkzV09aMnpaSWFG?=
 =?utf-8?B?MGFPcjNDSGFZcmVWejZlQmFScFpEaW0wYUd4Y01LdG5NVFhRVTU0dlVsc3hU?=
 =?utf-8?B?RC9NUW1jWWM5Njk3eTJJL0NKVlZxR1BJNStHUlppZTdCbDRSeFlMU1hKQXE5?=
 =?utf-8?B?TzcwSmZFZlR1WXVtWXlpNk1pY0VvbEd0ZWE2SGhZaXlOWS90SXJpYTVIZ002?=
 =?utf-8?B?VnNpN3lsa0tHMmE0MWZpNXZod1FPNkhTZ0g2Uit6NGVGSTJVWmhkaEEyVWdR?=
 =?utf-8?B?NFlsVVdpZS9kZHhhcGszb1d3MTVYd3p4LzdxWUI2L3J3YTY1V0lBenI0RFNG?=
 =?utf-8?B?M2hDM0lQRGhrL1MzYWNGZzlpa3pCU1FxY3BZcHlJOEVzKy9CdFpsMk5Demlv?=
 =?utf-8?B?KzdKN3pFc0xGSmVHSU5meHZMS21VbmFNWnlyQ01ETkRiZHRhNGoyejVQR2hB?=
 =?utf-8?B?TUZCUjFNRFJ1UU9lUXAyTEtFY0RBS1FXRmRTMC92YU5seVRNWjFwYUxTMTkx?=
 =?utf-8?B?UEU3cURMRUlYQnUzRXB4ZzYrWGRjV2lnZDcrNWQzQXNOVWZ3bDdYTkZjaDFC?=
 =?utf-8?B?RHlqcGk3RDJXVFdCRHdTMnFTYzJOMFlTeHJLeVRtbW5XVElRamxxU2JJNDZW?=
 =?utf-8?B?RG1JQ252bWZlbjMvNVc4bzFqRCtMTHNXNnczLzJxZGN0YlhscFpGTXhoMms5?=
 =?utf-8?B?dUt6dklNNFp6OHNwb3crT1RObzFaWHozTlpDQ3RpYzNNL3RLd21qN05mcDRL?=
 =?utf-8?B?NEJOWHJiWUtYQW5XUmU1U2tFWTBUZDRGaHNhSGJMQTNONkROTXRYbjF2cktm?=
 =?utf-8?B?RWlwOW1oQlduTm0wZWVVbGFBM2E5cGord1oraW5CcHZuM2txZlNPN2FJS1Rl?=
 =?utf-8?B?SGtad1IzMGhXaElDRHVNdkdkM05JZGhQb2tBYUd6ZHlVS1B1MStXY2NLcWRh?=
 =?utf-8?B?WWYxWVRNbjVVWHM0bkpsTSszTEdpQlJGeERPYWZNbkFxQ0pGRUJOZmhyY05D?=
 =?utf-8?B?SjhyZU4wMXhUY3R6eE5wZ01KT1MvMjhMUVNkM3lPUWRrYy9vdEQ4SzVGaHo5?=
 =?utf-8?B?UXBNTlMzM0lBdUN2cEJwYURhTW5XY2FHalBPdFFEcXNLSHZuYmd0d0M3eXA1?=
 =?utf-8?B?cENRNjNNS0lRRUo4bDlrdGdTZnlPNm5Wbm9Sa1JpRnZYQlkybWg3VE1ZdU1p?=
 =?utf-8?B?bkM2eXcrZk84Uks0SXdTN2Vmck83VVVUVUdNSEhsZEJqc2trdTd4R3J3b0ti?=
 =?utf-8?B?eHNSdmxrNzNoeFBwbzRjWEF5aTJLYkdwRktaRDlEV0VjL200WWRVMHpoa25m?=
 =?utf-8?B?bVNmMExiRHRFRGZOOEkzN1NZdXlEeWdzekRNS05zWkJDNDZVd0JDQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34be0108-c954-4096-4d19-08df33486cad
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:03:46.4898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5re7EqtPY53u7GAZwpvzxyMC6yx7nHku9OE9rKr2Dz1oc2rPcwWIAnO8svmu/PUPJTme36tJSA+Q6FzagQjTOQ==
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

