Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6160A3824
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EmlBmXfw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A2910ED95;
	Mon, 26 Oct 2026 10:04:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A2A10ED8A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOJ/uBqkLVqLENHhu+d148qPWYBcy4gZ29CcIs9YNPNEcOH8nxE6s7RC7wrMyBqkemIOo0S7k8lBXrKmcOsWPG54Efe5XeHSDoioxRdwkZNK0TDdDmLJMazzLpthdJXYwNF6KC01thoJKSdU0GYtgHG5CyyPXgL1stu8nl0J6/xxC7YFUvnR74ZTGcR1Y5bPNxMpGPM5ab1yVu7v4A6UL6ElyxCOcrzvH73ADke4rtqeIjSXXnWGRznHrUNSj0gsToxwFKQPRhPvMU0mWmePC90lMsIxoeT+0w6BQ/ZvmuL/39r9sw9u4x3VyF947xq/fwWokDrcOczbNb03hgC3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZfmnAd7pc+fubqdc1P9AwrD4bXoFVWjysLOQVy02C8=;
 b=NHGIY02nJVlNY0PzxI2Bwd2o80F1OShH1fRp5k3q52MAUAIyYsvOV90J52QWRKG851oyVy+ycahk9BeBf2gYk3WG7y3UMpRO27TrloJ5XoE7h6CatnnHPolzDoyuT9HG5fcGlFj+CTKHMXVFvlY9kFPMfanlld/dYH/Nbkhdm0+OqLQZbnceRlLWW3JRzOvO9OXMeTQRuzsNmbiAdlm47/zS1rSDr8yPYCY6kVrcFnfDinbHJ5PhL6Z0uHt+BOBhez1glTiP2BUWXXsoEmrKlDJlW9M+cYVkvxSbx00yaalcAXo89b+KstTW9oR+bzxtDvEOgKkgkR0xVzfduCxWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZfmnAd7pc+fubqdc1P9AwrD4bXoFVWjysLOQVy02C8=;
 b=EmlBmXfwvV0XV/X7HNV3gClacRT4/Z7dpIbc1+kMuVQsgJ28ey1dIfwh2YF9AQaIZKY4ltivB6iwCZyJIKgMAUyfR0idx8tjPoKTj3LmK81tefs9Sjkk4qr3fdnHaGdmKimKe1Otdu8XZjNtDBPl3Ph9c7uwI64yyeFdVUJFzfFM9qlCIebVFZ+ToSynMi3gs3qMv/U1Vu/e+sLU6903bwvs0MWdMRWPxBbBcIFV4TimxsZCR4zPNAdKJJ/Wif+JAzBcitK+MczvZiU9aJbJAfI5aDNUjQQEhpgWNIf0v4M4dwL46aSX3QHSh2J8I/CxmvWGJaXMMla12gZuLRe+Rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:41 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:41 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:16 +0800
Subject: [PATCH v7 11/15] drm/imx: dc-lb: Support getting secondary input
 selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-11-a0b50cc4fc65@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GV1PR04MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4245e7-62d9-44fa-1443-08df33488d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|921020|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cYueoLOmyqngsTpTaFbbva9x8TdXLxL5mCpN8XHc1GHuTB21hmq2nSNw+DTyRdtJkuHCeBE7EY6XCofqff/s1/DlD/WWEiEn7fsDxipZ14SUB5jbrBMjeoci88n6X9pLT9UsZZRmq0TUR8BXuFcOSYdk8jYzh2HEat1z46xNGVnNG/ircGLm2ltpnQ7i1z2uINkO5QS6UiidSqSUi9zVb4H2MPdBbPfcR1GxAn7hiZuk/1Bz01cv1/yvV7bXSHLiCtLTUzx0spHbRnUR7Ku7VfQJocoUG8TdQmUN6tDs6B/bS20DwhPw/cf4n7zo/+8UGkOQExgLbtIlRacfxnng5iftQomj4wxwlDoyh0EQbAFVK+WDnRDgu/udRTWSDsI/vIqY5gj7/ws4+54aMTZbQ8mI7lZKdGGA6qcyrBZdCHaM9GGwc1hfGoo1yv45mXbp1FVbKS8o5y+wWmFrPuonxDEjVoTh8LKZNqImu3EWTBaq6sTDKdhAN7h/DEuZ/tu3pRBFdij90bmXyM3L3S/3nX+lf2Cj82K9nQVhH58EGOn9MIDAE38yacyGuOLZh4z4Kema0EhEH8YqxT3k+9Qx4pgyzRWlF69KqAMzcqtQGXSwE0k9EduJI26KCVXbENw+ricwYuozwl1OgG/FZ0SKMuYL+4rpDFdobWAenHpeh+VoWh34aExGdakJS09jK9Nk57LM05uTV2lywgD/oM0J3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(921020)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3J6RmhyUmhQTjhXMkdnMmpkdXNzT0V4alBIUytvaGJ3ZklXbnFUemdPSUhU?=
 =?utf-8?B?eXlhTTRBcHNDL2pIL3VjUjMxM2FzbmdHeFpSS3VQVEk0ZDRKTEg4ZXN3Rjda?=
 =?utf-8?B?RHlxVEdqSGNud3RBRTkxL2Ixb2lSYTBTM0NRYzhHTStBQTJCYlNMRzVSTEx0?=
 =?utf-8?B?Z2xodldDa2ZqTVZIZGtJRnJCd2ZYMk52cVJiU2IwZitNdGl1Wm9Dc0NQcWxx?=
 =?utf-8?B?by9ldG12bkFCcjM1NkxPbmhxSDd3MlNjY01SeWtnVHZnbmtXR3pGNDNFNHdE?=
 =?utf-8?B?NUJ5eHlTRWVDcU8xeVEwSk9PRVRGRktNL1VMM3QxV3MvWnlVb0N3OWxiVmlW?=
 =?utf-8?B?WnZQMHZnYllWUWVFWHBuWlRjZnJ4VFhESnQrN0FqRHh1aDdDa1pseVJsSTJE?=
 =?utf-8?B?aFhyamxlZW1uN1oycWdTbDhENWtUdHZmV0MvMTdMenFJdldWNzNaeWxMOFJP?=
 =?utf-8?B?eEdVTnVUUXJTMDFDTzViTkFkNW1ZdnNaTHZUeHVjanFPS0hqK2s0S1RFM0RE?=
 =?utf-8?B?eHZvbGJuT1ZpeDc2QXZGeEh6UEd0ZW5GQ0luS0ZEV0ZIek9rendlcytOUFVT?=
 =?utf-8?B?R0dFOVU0a1FrQzNvMmpuZDUyMWtuM0RmTWJaUGpIWWE0WFdJellCS3J1MlZm?=
 =?utf-8?B?TzMwakp3akgzQ3JvSGx5RjlRL3V6bDdiUHk5dWRuN0VwT1hIL3dXMXZjWEtT?=
 =?utf-8?B?dWZ0d0l0VTBDQXkzZm1YKzQzZjlzaGg2d3JqTEppMzhJNFlhK241NlZMNWRC?=
 =?utf-8?B?a0JOMkNsUU5MS2NrSC9yeE9XVGoxVng0TWVMeUJLNytsdDlZK05ycExYTThh?=
 =?utf-8?B?am9VcDBkSDJyOTFsRkJMNE9KNVY5WXJxaGhUT3hXbDF4cEUzKzROVDBzZjZ4?=
 =?utf-8?B?eXFXQzRURlhpQWYzVXU0YVczU3FaeTVWTXpUWkpRbmpnZWNReExXUTBpODhV?=
 =?utf-8?B?T1ZraDhNa2VNdzIzdm1ZSk5mazliNDVtQ2wvQ2Q3Q2ZYeThIN0czQThVbzJW?=
 =?utf-8?B?dkVxMFNlNWF6cFZjYW5jVmZDdllWUUgxQ2o5Y0hFQWVCc2hldzVGNGFEcFFS?=
 =?utf-8?B?bnFiS29tS1gyWUdDV1Z4ME53d3EvVVBJcWRBbjFHWDdITHp5WUpoTTBzTG0z?=
 =?utf-8?B?bHJJN3lyU1FRcktXdXNZdGxqNTBDM2NTU3hiUS9JREtNK1lwL1FQZ0xHb011?=
 =?utf-8?B?bk5UclE0b2tqMDNRQ2xBNFJMdDViWnBXOTlKN0lCRCtBdGUza1lFdUFPUExM?=
 =?utf-8?B?b3RjK0ZqRVBOSnAxbHVNTVMzNlByK25MMk1zL1VvRmNVVGpmdEhiYWVSRFZ0?=
 =?utf-8?B?Ykk2bzhKQTRjQmRzSExZd0RtT2M0NmVnRURaRHBFaTV2clovc1E3MzVsNGEr?=
 =?utf-8?B?MTNCRlZtSEZueTdXSFcrTG4vREZsVUl4dWpvZkhlZVY4WUZQbmw4WUxYRlIx?=
 =?utf-8?B?NVd0UVhwN0k4QXE4N1JjdEsxbmFWWGNvUmN1QTM0ZGFXV1Q2QlAzR25xaDdq?=
 =?utf-8?B?NE00c0tHV0RpL0FLSktqOWduNEQ2bzlOZ2JPWFg2ZTVIYmdZZGdZeUFIUUli?=
 =?utf-8?B?YitEcngwdW0wb1BReU1yUVpEYTB0YUJFdU45bk8xV2RFWVgrYjFEUmoxYkp0?=
 =?utf-8?B?dzM1ZUxMclo0cjhiaFF0VzNabk1FejliOS93aGZWa0lPVXdjV0JMWjJieXhK?=
 =?utf-8?B?NS8vVG9RaG9CcHVPNTd6Uk5EakcwYTArM3A2dVdPVFQrRmpESHN4R3NJZTA2?=
 =?utf-8?B?NzBMaTlsM2lLV09oNDltWlVCUHRqMC9lcG5QbUxPbjBKdFdWK3Ria2xMWjZG?=
 =?utf-8?B?NUsyTXZvMFlBLy8raU1KYUZGQW0vNVpOT2I3djhibXFGN1VLMHZlenRBWFli?=
 =?utf-8?B?Ynp4ckZoSE9WSnoxRG9zdnZrRjFoM205ajU4bUxHUCs0ano5SmthbmdvQ29E?=
 =?utf-8?B?M1cxYU82dmZ5QVM0RTFKRFdhUUR4bGtaTllBOWdYMkpNSWhJbGNOU2xybG14?=
 =?utf-8?B?N2ZZUzlwTHpQc1F2NlQzUDRUMU1lRXVTZUxMcVZLbENsSG1GS0tXVFhoQ0hv?=
 =?utf-8?B?Ukt2Z1B2ZCtybDZQTm1uTWw0TWVGYkhoVHpxODlMcEpKZTVINTVkeXFBR2Zl?=
 =?utf-8?B?em02SVlTeHVodTdBb290bEVqRGQwazR5R2VDWFpyQm5McnIwUkF4RUxYREFB?=
 =?utf-8?B?dWg0amY4TTlLeXh4V2xBVTg4b1ovVU1reHl1aUwvRmdPS2k5eVQrbUsrOWM5?=
 =?utf-8?B?SjNNU0N6bHhlTW4vRVM4b2pTZ0JVZE9JR0QrYzgrbzhqblFWdXRheG9WcnZB?=
 =?utf-8?B?b252RmIydUZ5S1pmVXRqSURBWndmSkRrM3dESENycVRvQUtQak4vQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4245e7-62d9-44fa-1443-08df33488d17
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:41.0585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8tCwJL5CQEy9ft4P1C4w4Rz4QAWjJFLBxsAWyk62EF7gzdZzO+FL7Sie1I29OgePH2xCBZLW8xfuRjHULA/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133
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

Add a helper to get LayerBlend secondary input selection.  This is
needed by disabling CRTC at boot in an upcoming commit which tries
to get the selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Collect Maxime's A-b tag.
- Check regmap_read()'s return value.

v4:
- Rebase onto the latest drm-misc-next and resolve conflict.

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-lb.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
index cb614f3c2f69..03c361d25824 100644
--- a/drivers/gpu/drm/imx/dc/dc-lb.c
+++ b/drivers/gpu/drm/imx/dc/dc-lb.c
@@ -19,6 +19,8 @@
 #define  PIXENGCFG_DYNAMIC_SEC_SEL_MASK		GENMASK(13, 8)
 #define  PIXENGCFG_DYNAMIC_SEC_SEL(x)		\
 		FIELD_PREP(PIXENGCFG_DYNAMIC_SEC_SEL_MASK, (x))
+#define  PIXENGCFG_DYNAMIC_SEC_SEL_GET(x)	\
+		FIELD_GET(PIXENGCFG_DYNAMIC_SEC_SEL_MASK, (x))
 #define  PIXENGCFG_DYNAMIC_PRIM_SEL_MASK	GENMASK(5, 0)
 #define  PIXENGCFG_DYNAMIC_PRIM_SEL(x)		\
 		FIELD_PREP(PIXENGCFG_DYNAMIC_PRIM_SEL_MASK, (x))
@@ -181,6 +183,29 @@ void dc_lb_pec_dynamic_sec_sel(struct dc_lb *lb, enum dc_link_id sec)
 	dev_warn(lb->dev, "invalid secondary input selection:%d\n", sec);
 }
 
+int dc_lb_pec_dynamic_sec_sel_get(struct dc_lb *lb, enum dc_link_id *sec)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(lb->reg_pec, PIXENGCFG_DYNAMIC, &val);
+	if (ret)
+		return -EINVAL;
+
+	val = PIXENGCFG_DYNAMIC_SEC_SEL_GET(val);
+
+	switch (val) {
+	case LINK_ID_NONE:
+	case LINK_ID_FETCHWARP2:
+	case LINK_ID_FETCHLAYER0:
+		*sec = val;
+		dev_dbg(lb->dev, "get secondary input selection: 0x%02x\n", val);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 void dc_lb_pec_clken(struct dc_lb *lb, enum dc_pec_clken clken)
 {
 	regmap_write_bits(lb->reg_pec, PIXENGCFG_DYNAMIC, CLKEN_MASK,
diff --git a/drivers/gpu/drm/imx/dc/dc-pe.h b/drivers/gpu/drm/imx/dc/dc-pe.h
index 0b81dc6b251c..4e38aead69bc 100644
--- a/drivers/gpu/drm/imx/dc/dc-pe.h
+++ b/drivers/gpu/drm/imx/dc/dc-pe.h
@@ -93,6 +93,7 @@ void dc_ed_init(struct dc_ed *ed);
 enum dc_link_id dc_lb_get_link_id(struct dc_lb *lb);
 void dc_lb_pec_dynamic_prim_sel(struct dc_lb *lb, enum dc_link_id prim);
 void dc_lb_pec_dynamic_sec_sel(struct dc_lb *lb, enum dc_link_id sec);
+int dc_lb_pec_dynamic_sec_sel_get(struct dc_lb *lb, enum dc_link_id *sec);
 void dc_lb_pec_clken(struct dc_lb *lb, enum dc_pec_clken clken);
 void dc_lb_mode(struct dc_lb *lb, enum dc_lb_mode mode);
 void dc_lb_position(struct dc_lb *lb, int x, int y);

-- 
2.43.0

