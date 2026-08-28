Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD17C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0CC10F37C;
	Fri, 28 Aug 2026 12:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fLz3xwr4";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011006.outbound.protection.outlook.com [40.107.74.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675EC10F37C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2oCTy2TiLS0RrjTQarq6ov3wUTDkS1Iwu13VE8L0hrIPVDcAy2mmx0SXqQ+RhIKoQpwtGydW8Q/jgUlswjCPwpDQkA3XVTF9Fm3C9lxdAjJTQ7pFBXTVq8CTk/pgVv3QoHecjrqBP4NF+BRSVSPa/PKsd5dBA6uLYve690z+CfJyDk6DcBbEco+FmEIMMwRwZbWuUyenFKBVzKCHIk0U530lxQ7A80Ht9m7zzIlhU9Fj0R98fb6HWQRjeHQY3SU7mmNdcPTEL6XQ8Uf2B9uvGvICbwU8SIu9ZtiX4Ik2A99hUtUc1N4SxSWGWkUWTGjANBYlLa9vxlDHGiEwRmJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeYE1H2VsMrft91c92LkRL0+eq/l/OA0i2OWfg6aa+k=;
 b=j8OJ4WFQIi3Cl8eJLAufMK7g3+jQ6HHTnojfMCJrOit/FJqncTb53DWh9FnJdNtQ7nVdtfAgq9IG6S2h18PTNXSrEOlYf6cwDF8mRf4k5jCB7oT7ovj1iOc/bDHyNshBSURExYlYwzONqP59JEnAS+5Dxkpc3yOugAEEnccROAuBOIVPKRbYn8SEgCXABlGWpn+NfNqOVu2KyXIqz329dxEQaDFRnQsVXmC7ORrlLAHvQNHMEF6bKNdIKHNrJrxSyE7113hM3RF3suTfFHQ51O0mgNf+JIrm7oKBDQo0llYq5/Htuq025BkiDwcNtFi/z8fe8cQjYkCr7K2cRrzUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeYE1H2VsMrft91c92LkRL0+eq/l/OA0i2OWfg6aa+k=;
 b=fLz3xwr4zU6TtFegKdA/uPzCdhNwHfh0Bjt5tzof5skiEN4p1ynbOz8UKoGSijD6IJaIdtx+zuq6thKLUAM05+F6f5hiI2Z4+SD9G7+NTv7svOVEctHD6cSdaBo5pAKQT23QCVaJuzmlSz41R0dUjdydpnBaBggNIAUMyyBgGps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:22:31 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:22:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/9] drm: renesas: rz-du: crtc: Support per-channel named
 resources
Date: Fri, 28 Aug 2026 14:21:09 +0200
Message-ID: <20260828122113.1426778-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: c6491b56-e9d9-4b0a-5b9b-08df04ff0861
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: 0coxkfALir43pjRo3IWNH2KBkRRr8BtETlwd4tTW5FV82JVwWOst7ZofoTXAPhMf5FmrpEo9gNiSc+EXCOWnQMsZgzyD5IUcP6+fCEN7r68E/3u4+idi95NvxIVdjB1ZyefsqYeArCeXSbAlGq7sgywGZdgzQYogyCbjsNjL05AfIrEfWRFNiN81lVMwdPK9YkNjhu0A9/y7q9NRcbLxONeJRar0o8wQRoN50LzfmfH65EDP7r/Ula76QH3wjqH7ZHHFXDnuefahjeZAog6JGzjX29Ri/9iW9SofJgfhRCZZwzDL9Q/05tI4Jm31YIwlAtbhEB+4gQTZKex6HF4GgdoRlHTO9UZMr9G6ng0aCWbRXvR0aDjj5n+d28GYKWKBaZmSVjaCpMbgnah7hNgM+2jY1O3MYpQxEWFUe6j0ILdZ5AcrhdjHbRf6jjPQK2UmyCCOXXE8J7dM4GacH6hjF2eSsSvL3z0KaKn99HBBttPTELqiiIuZaBT9Mrk+ziInBV9whqVBUcV/AQmMu+6EZIhEA2UBlSHgLSrWWXfm3jQ4pn9ICefPAKl9kt0txrJ1YGwUY7i/q2je2vflc1vWPeEjoubYlLMcEN6GztahIgjJx1gbup5n5KRyL3yNPWgopQLMXQwkT2e+H1+XYSrJOwXEGndTRkyd3ngWp97qVlksxPsyxrBTEjmUX19bv8qKqvm3tA/WmW1hVKglk57QQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YQI3F9tJHz3Qc0YIqckRMvkBSeKDSMhKZsBMtUkfipdPNWfZjXuANmQ4T0I?=
 =?us-ascii?Q?WAobCEcT0TncVFMSdwCzZDv4HFlSqnS9T8abWXn6UdA4Lg6AZ8dmf5R3Zlt1?=
 =?us-ascii?Q?jjM+kIjLY8ihkHiMet5BA5pNtcUA0qlIxqj1WXc2XVPT12WLVUfSiRyd+J/l?=
 =?us-ascii?Q?Q1ofNp02nhMYZxgZmaGSpPRV8pqAEGT0TL6ziPTloiB+rfI5mXJ5Igq9zfy9?=
 =?us-ascii?Q?oNBj9tLLGM0qjSSPneoZuqrD89ZNt/FCG1UK02afe8skFrfVFiRmdbTZaD/+?=
 =?us-ascii?Q?9u8uz5xcVGRkjpa09j7fdYBaRc/REE7lERjlbfwYSZB0A6YenX3bSIuHPJVa?=
 =?us-ascii?Q?mwQl0DLuZUGV276SiFI/xTC0JAcJPTughnS7I4IfdaPOeQHyqMR+Px7+u0fo?=
 =?us-ascii?Q?vATD7kF46yHHEZeDpJ/OSGidW7SQxemXluvijYUx80s8mX0sDw5GPi8h7u6d?=
 =?us-ascii?Q?WSKdFM+/JVKDagIWDsA9S8IQE3/QTdDrxHfC7Gi6ZfRl98yrIx8xEMiP/URN?=
 =?us-ascii?Q?L4xRJgdso0FWvVyjKyU3isvULsOL48ZO1Upc4Q1052ufry6DJfKKfaPNYcXK?=
 =?us-ascii?Q?aDxHjCq6Vdru1RUrLzKoQ8c1PukcpW5H+7Jb42YB1Pb3ug2RQ7v3FxiAHJmV?=
 =?us-ascii?Q?OV5g2NIuKFF2nD6BXadS7wuVWUt5iw5mdbqFgO4ZgE7xiTKMT34j+KTuSBq8?=
 =?us-ascii?Q?TrTjS6B4MbRUsMuTDkZYlqbksDiUlcIsXltkrg0au4/C8sGjpqS6Bgra/8MR?=
 =?us-ascii?Q?vu854K5M1AQQJ32sphmpHROdbdb+ln1BZBjuZ/BLHLY7vDOnXKRnRBSCv9Df?=
 =?us-ascii?Q?OL5hoS00Uk4QPBDJ/6bUouBFAmS4i+2a/gVXdXvB0O+wNdZD0ls5okRaN/dI?=
 =?us-ascii?Q?xb2BSktashYOTVFHHk0CQYd5DqW9DqcepJi/ox2IOdvZfZRIaCa1IY9sIIYp?=
 =?us-ascii?Q?7Qm5KBLiD7a703OboT3nNBmGVmOIUwvIDWCoMJAzkFDPMcQsY9Zifjul8Jjt?=
 =?us-ascii?Q?h8DOr0LbGwWIfO+vtarT6HmCwtMPcVrnt8T9qIHejyq3bneGMSqUqsh3G+7z?=
 =?us-ascii?Q?A8Odh6UPh3R5X8U17iTw5179LrF+7RZPV3t1IeTMXDF4dk+5OBGszqQ+CFSm?=
 =?us-ascii?Q?VP7elfRMtqLmYDdMl92IOIh76Q19dZLfgilXmJupL+d8EOSiN7AX+XEgpt9l?=
 =?us-ascii?Q?6pXyvEXHVcCpdmBIwxj9PzqZZ2weuP3cs2aY9C4Lks0KYTiWJw2uFet11XbF?=
 =?us-ascii?Q?9aiRgjgwxICHPXawg1ighN9ALYrse8P0V4vLPfp5Wtov3hPSEXUrb20l82yg?=
 =?us-ascii?Q?Zx4O0avL/IKkd8aX12NX1j1Cv/ck05zkdXBK7uxLS47Kx7RJl55QvvnPtk9p?=
 =?us-ascii?Q?dRa9XBj1BWm4hnkZUs84lABzo2H9qP/mOe3gnDBTBRILBOUliyJij/TFd/o8?=
 =?us-ascii?Q?o22Y+p8LSmmw87jE2AnGvvm6NLvkVrgYkfrTZ3TzDaVLhfk1j6jN8i/lXNkd?=
 =?us-ascii?Q?8Zse2zRWEd4qlql095FuDnYpg31D8kBORP2WQgSht5Wl2fvALY/XLw8HwOVr?=
 =?us-ascii?Q?IHCoV2gFJoliIv06VpFMVgFGvHouWNcflBwePpHSjL3VDrzaPpy8r5t0wReO?=
 =?us-ascii?Q?6WIlWqM8zmYEjsDk0EyO1KfddIjHnyrZqabABKlw7qEWPgydICztmNdIzul9?=
 =?us-ascii?Q?nioYudQBrwm80cexKR/GZX8T7XGmYEhzw6940+lZ263v/GnmjhB7dj8CxbfP?=
 =?us-ascii?Q?Qh3EH4LRjtzCC6Gg2nA9Iv225+LIQPLht6W0UX2pzsp5j3nuPdC/?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6491b56-e9d9-4b0a-5b9b-08df04ff0861
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:22:31.7036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5UMI2rpO8Fs/8mgkkP61wa0/OausH0qNL4k8CFo2WbxbKjwdFGYtK99ew4S2tqCgtl1j4lcXdSFVarDjrz5R9kHQhNdULDr0i8WklTrujw6gzxM9F4H99afX1AGUzBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17444
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

SoCs that integrate several DU channels describe the registers, clocks
and resets of each channel separately, and name them after the channel
they belong to. Introduce a table of resource names indexed by hardware
channel index, selected by the new RZG2L_DU_FEATURE_CHANNEL_RES feature
flag, and keep looking the resources up unnamed and unindexed for the
single-channel SoCs.

No functional change for the currently supported SoCs.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 42 ++++++++++++++++---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  1 +
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 81934fcb551b..dea6d92a7a8a 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -377,41 +377,73 @@ static const struct drm_crtc_funcs crtc_funcs_rz = {
  * Initialization
  */
 
+/*
+ * struct rzg2l_du_channel_res - Names of the resources of a DU channel
+ * @reg: reg-names entry holding the channel registers, NULL if unnamed
+ * @aclk: name of the channel main clock
+ * @pclk: name of the channel register access clock
+ * @vclk: name of the channel video clock
+ * @rst: reset-names entry of the channel reset, NULL if unnamed
+ */
+struct rzg2l_du_channel_res {
+	const char *reg;
+	const char *aclk;
+	const char *pclk;
+	const char *vclk;
+	const char *rst;
+};
+
 int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu, unsigned int swindex,
 			 unsigned int hwindex)
 {
+	static const struct rzg2l_du_channel_res channel_res[] = {
+		[0] = { "du.0", "aclk", "pclk", "vclk", "resetn" },
+		[1] = { "du.1", "aclk1", "pclk1", "vclk1", "resetn1" },
+	};
+	static const struct rzg2l_du_channel_res single_channel_res = {
+		NULL, "aclk", "pclk", "vclk", NULL,
+	};
+
+	static_assert(ARRAY_SIZE(channel_res) == RZG2L_DU_MAX_CRTCS);
+
 	struct platform_device *pdev = to_platform_device(rcdu->dev);
 	struct rzg2l_du_crtc *rcrtc = &rcdu->crtcs[swindex];
+	const struct rzg2l_du_channel_res *res;
 	struct drm_crtc *crtc = &rcrtc->crtc;
 	struct drm_plane *primary;
 	int ret;
 
+	res = rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_CHANNEL_RES)
+	    ? &channel_res[hwindex] : &single_channel_res;
+
 	/* I/O resources */
-	rcrtc->mmio = devm_platform_ioremap_resource(pdev, 0);
+	rcrtc->mmio = res->reg
+		    ? devm_platform_ioremap_resource_byname(pdev, res->reg)
+		    : devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcrtc->mmio)) {
 		dev_err(rcdu->dev, "failed to map MMIO for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->mmio);
 	}
 
-	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, NULL);
+	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, res->rst);
 	if (IS_ERR(rcrtc->rstc)) {
 		dev_err(rcdu->dev, "can't get cpg reset for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rstc);
 	}
 
-	rcrtc->rzg2l_clocks.aclk = devm_clk_get(rcdu->dev, "aclk");
+	rcrtc->rzg2l_clocks.aclk = devm_clk_get(rcdu->dev, res->aclk);
 	if (IS_ERR(rcrtc->rzg2l_clocks.aclk)) {
 		dev_err(rcdu->dev, "no axi clock for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rzg2l_clocks.aclk);
 	}
 
-	rcrtc->rzg2l_clocks.pclk = devm_clk_get(rcdu->dev, "pclk");
+	rcrtc->rzg2l_clocks.pclk = devm_clk_get(rcdu->dev, res->pclk);
 	if (IS_ERR(rcrtc->rzg2l_clocks.pclk)) {
 		dev_err(rcdu->dev, "no peripheral clock for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rzg2l_clocks.pclk);
 	}
 
-	rcrtc->rzg2l_clocks.dclk = devm_clk_get(rcdu->dev, "vclk");
+	rcrtc->rzg2l_clocks.dclk = devm_clk_get(rcdu->dev, res->vclk);
 	if (IS_ERR(rcrtc->rzg2l_clocks.dclk)) {
 		dev_err(rcdu->dev, "no video clock for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rzg2l_clocks.dclk);
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index cb9ad869d66b..6e1e4222d2f4 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -21,6 +21,7 @@ struct device;
 struct drm_property;
 
 #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
+#define RZG2L_DU_FEATURE_CHANNEL_RES	BIT(1)	/* Per-channel named reg, clocks and resets */
 
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
-- 
2.54.0

