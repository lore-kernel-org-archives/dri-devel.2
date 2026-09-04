Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719FBC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A508910F903;
	Fri,  4 Sep 2026 07:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dKCGoJIx";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E4310F903
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzHD0tCftDcJMPdf7xvtyXc+XkkHWUegPA+XjZe8q8lXe3dx53B/iK9mBW4Bf4phdmSqJ1yQF8nyCSf8PHFYlu0atf7LiaQoqjfAh3AmFwxv/ZvzkTd8dZUdaKnisCNOsBtQpLrG3cNGmoZArUkMt+buaEbbW4jy+zjaUl+X+Bj6YxdWXpYtObx4TcPu8Dsz1XI2d9ryCLwFR44NNql8QBeUQaXZKUG5gLPiBv0KX80sVt4zk9H8XwTwYXoSRIkb+PjANhtvD836Y0jLqaeY8I8nxnvmmd8QFZy216MiPAlqceTHKS/SsVfD7C4JaB7QAI9orAa2QgwJCx1ZmMgCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at6cKKNNWV7MY2ncMO48qzhd8YG4503J7cQ4K0EiTpU=;
 b=y5WDLYqjfPL4SBl0rb9YV7p9ZPzZtR8i1KgAXetdrMArnUJBL1DGg9S9+hkcTAmCUNCMaL9GuHxZXLHuKwRrHS/zSIHYhZPPBbdZWDmwFOSD5Gsy4lDdmnKFkJU8WdDtarChzDMqkXHZOvawqy1DmG+6XCNORToCfeXNntz4hhujiO9orVjwSK7fEzl+yK5w6bpsfC/6+/M559gOlg9DAElbonLcT1wSEy0V1EzR7l4Fw5M/hQ0/JDbqLJ1WZTwmtn8PaMCsdem4ImWeJUVdv8wE/iFr0YNHgBN8ecKuPliWXU19VH52dtyJk74nkZ4lFAbRC5QIARdZyT527fmv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at6cKKNNWV7MY2ncMO48qzhd8YG4503J7cQ4K0EiTpU=;
 b=dKCGoJIx+q3oBiyjLP9jbqLseItjXyZqFB1pCQBtQfZPEFOUKj79keJ4D1kJfnQ0HAGf0N6yOxm3Bw6VHJ7OAcLsbxhTL3BEI9vHDsqKkoi0LyHqrngrAsAyAYLLUkj/YERRMVRlCiU9JidB2Vhf2W3ko/mwkotNM1r1Btutu2R7yjmjW4j9hrFqqYpZLYR0wtEylHA6hjOqtzPruqlFe7AoXD8U7Wqt7MIQnhPKKF54eXFDe5YhN9DwMjGy+8Zwi6E6HVOVL2HDiasv5SehOgXhkV5YS3dpbyvHJhp70XdQWKJrsLHt8L+hDX5omitr58g/Dfh0HZzaHK9RVvZX5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:30 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:30 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:59 +0800
Subject: [PATCH v6 09/13] drm/imx: dc-lb: Support getting secondary input
 selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-9-26643e3f6cb7@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::14) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: a5767e8e-cff8-4f1a-4ee4-08df0a59c063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: vAsSuN3sqShUx3A1N2pi3ULU1IkDeMy7ucuDUJWW9RZYcQxwErBxnLW04FyVN0hNkJQYwkQ0B+IwIy4LI6u18hd7c/A11rVPGwmrL8WdR2HWrejDmS+vciGiwE6DvcBkewnDUj5MtSJ1TIzvV+v3nerw6irlXPrEJRTSnqanGSWgjKe4C6535PeA9o8zJjWC1vpl6wXBMG+2yPi3nsbo6qM1W68N7QEeTdGyoT4boY64inrXioAo8elYeLjOxOxvMMQIQ7Um74TjpRUIjZCeqTrUck/rvqikoQhFKuvfq1Zjjsvqn5EOiVFZQneEZvINHAXMZFcIRZoyrPOkvvTy9HGABblgScxQbbotxQ0SYLX8i8GOY8J0CTtmn/2apMa6Xh22dV0b6KFoP08KBjrArxYIJ5xQ/P5L+Obdi9D8m16tqSeQyQcPl7o9ZXgYnfeQGO/vv5z8ja0toN2/6mdOaeP2dmw3vVOXnyAgT36xChJEGd6v/cAqJnsAItcvcW53LcwWpfIjvk/mUmOIvk3jEcfFJ7558uNZvgxj/ZebQud18nDULFJCFeKDP+HaTr/WaQt+0rVE7Ma4A4UtfMnZIb3VaJjarGg+CBM+2NGHHpVK6sdvW6+0XmezdnCyP0OqdNErKRfJyR/1KF0shStHAq1ELDxv5qTKDGuVCHL2KXgcREcYbvdVT7aiuTe5s2HUr1tTboMrGMdY3KLO7sNX5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1xcVNvQjk3cDl6d0RMMWRQUFlqQ1MzcDNGV21DajNnb1dvb3NBY052VU5M?=
 =?utf-8?B?RmlVOUNRL3htTHNqVXUreCt4bk9oSFhZRzJJdVc3M3Q3UThBVHJPUGQ3Rzc3?=
 =?utf-8?B?azJxRlhRL3NRRnZWNzdMUVZSaEVOZlFBaGhtZ0hZY1NPUER2K0NHNXRkVVdq?=
 =?utf-8?B?cVE1blJyZDFJK3dtNWkvRy9ob3h6VW1GQVlJQUdoeFZWbThJY05HYklXdDQ1?=
 =?utf-8?B?czJkK0hsQVUrRjJsNGh6NUs2K0s4KzFWN0UyM2lYUTViTk03SC82bVEvM1c2?=
 =?utf-8?B?YVVwVmZlblBqdVdmS0pUSzc4NVRPT3R6T2padVgxTk9xYzFkYWtOWEgxaFJt?=
 =?utf-8?B?UGhHVHFwQWpaUE5NTTZvOFFlL0QwZXFhQzd1S1llbGVsYldOWmd4ZzkzcVRD?=
 =?utf-8?B?di8wcVd3VjVnb3JONU5wVEs3MXovcURwY3RrdEpXdUJBMnAyUXFkMEVFK3pW?=
 =?utf-8?B?VmJsWXRxNmZFSGltMzFSV3BTZHdHdGFvUXFidVNUMlJGUWx2cmRwK25kNFVE?=
 =?utf-8?B?ZkJZMWtxUEFNN1RaRm9ESEtUQUdrQkRhQjlLQ2FFNkNnVmJlNmFRT2VlYlVI?=
 =?utf-8?B?OFZ5ZDJBUnNOMXVlK3JwRWRtekc3VkxCRkxONDFuQU1ZcGNrak9zOFVRQmZU?=
 =?utf-8?B?akVpamd1RUJUdmhEVGpLRHcyS3VPZ2wxdVhEMklMR3VCMnQ3SHZPYWZCQmla?=
 =?utf-8?B?UjJuUEJkbFhPUlQxVFdXQW5lWUVTV2EwL2xlc05KSjc3ckFtQkdLMllXUTgx?=
 =?utf-8?B?dUFBdzlzRGxzS0V1V0tENTQyZU5qREgrbFNvWFNUakhQSWJlUWxNQWdWdE0z?=
 =?utf-8?B?azlGTlRBYys2V1JDTVF4TWdrWFhRTzlHMlczTkRyak1SQnpJQjZwZUErd2Rk?=
 =?utf-8?B?cFFrTDAzOG1mQTRWNFVuSFE1Vnhlc2J4aXROaHdwaE1QeDFoWUJBcWFvbi8v?=
 =?utf-8?B?UTNoWkxDRVZ2dUxpdlZhK0ptZWluTU4vSGNEQS9yekZoMHc4NDJEblU0eWpn?=
 =?utf-8?B?emNmbjhwdWZWYUpWZFovYVNLUHZ6eDlNUW1EaGpFa1REcEgyR0VVTW5IZm1O?=
 =?utf-8?B?QmdPUURTdVhzNmx3Tm1nOGpyanpyU081RGRKOXJCVmhYckozb0lNeUdIQ1U2?=
 =?utf-8?B?UlBaaGU0RTE2cnBGUUNGWUpwc1hJMWFmOEJGYVlMTnNGVStxS3BGUi96Wk9K?=
 =?utf-8?B?STlWSGpGcnNsK3JjZlRPWjBVaWNuMm44Skg4UXdSWkJSemlLZkZ3SmNweXRh?=
 =?utf-8?B?aUFtOGh1cGZ4M1BENjh2TkNjdjVsTCtiM3RsL2lKekU4V2JMV1h3L2JqR0pS?=
 =?utf-8?B?QWE4SUdETHQ1a2FJbFV3a21qNllNLzY5RGd5Z0dyck5UTUNmTnd1WWxQNlE3?=
 =?utf-8?B?a3JlTkVJY3hiV0piZWNPNzdNb05aMCtJV2pQeWRieWFIUERBZ1BpSDhqb3hj?=
 =?utf-8?B?akFna0NpWnBSYWdHNGRPdEhzMVRGZWlFeWNzTVNFY2tjS2daZHp3NUVPR0xv?=
 =?utf-8?B?ZG14U3ZJYXJDbmFYSE55ZUs4QkVGTEpuNGl5N3NtQTZSMk5OcUgzK0crWUhN?=
 =?utf-8?B?bDZLSmIwMnA4amh2ZXRVRjNMbEFZYjNrYXhBc0d4WCtLRVp6VWVIQ0lSL3l0?=
 =?utf-8?B?VHkzc3IxcTRiUFdpWmZCaTA1bSszM3g3Zm5aaklxZDM0QXd0NmVmZnM0ZzdX?=
 =?utf-8?B?bFI1T3RnQUU4ZFpWRkc5anU0bmV0QWl6dE91VEVtUFF2dE1qNlNrVEtuWUxI?=
 =?utf-8?B?VW51eWNnUDI1MlFJT3lVc3pPZkoxeEpaZ1RrdlFvbFpLNVhaemlNK2dOR24x?=
 =?utf-8?B?SFdycDVqMDE4ZUdZODN2cloveVZYY0FHUHdSdW40S3NRekRIcDVUeTJMVVdG?=
 =?utf-8?B?bXJ3c3JLMUxWWVpWY3lBNkZRcVFzL0NsR2dqc01wODlDQjUxUE9MMDZNZnY5?=
 =?utf-8?B?QjRzcnE5U2lzUGlFaUhMVEJDK2ZRMWRwRUxubUhkZTB6VlJEa1ZGOFd4dFNx?=
 =?utf-8?B?cFhqTDFuRmc3NWV3UGtJNVFuN083Wk52VlNXQkVQWmh2TVFCQlJncm9WNWJz?=
 =?utf-8?B?UUNMajlQNVUvQmJwbERPSHU4WlJZRUNjQTN5bUZFU0lXenBFSjBSbVVET3M4?=
 =?utf-8?B?M0pha1c4RFJCWnBablFiU1JRb1U4VStYRU1nSzhPSmRzVWhNUUpLcWdINDNq?=
 =?utf-8?B?bzVRVmFWcGxoVjFKbGRzNjFwazJSWGYzclNCZUFsSHo5RzNBeDhnbWEyVWd0?=
 =?utf-8?B?YzB0OUttZGh6QmxxYkpxLzR6SDJmZUVnZGNKZERvaFkzOTdjWU5qOGtoV0VU?=
 =?utf-8?B?TVJQdFRCeUZOdVNBVVk1Mzg3RkFOSHZHdGxJS052V0FvYmdvV003QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5767e8e-cff8-4f1a-4ee4-08df0a59c063
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:30.6543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxLNMh4JapqM8zV2AXJhQluXyxZn3eCAkZ1QEatvc1nxBeix8c4ZqE9IhCPsyPj1Uv81WkWLX9XBxxcA3gG1vg==
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

Add a helper to get LayerBlend secondary input selection.  This is
needed by disabling CRTC at boot in an upcoming commit which tries
to get the selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4:
- Rebase onto the latest drm-misc-next and resolve conflict.

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-lb.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
index cb614f3c2f69..ecc7e14b4a87 100644
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
@@ -181,6 +183,25 @@ void dc_lb_pec_dynamic_sec_sel(struct dc_lb *lb, enum dc_link_id sec)
 	dev_warn(lb->dev, "invalid secondary input selection:%d\n", sec);
 }
 
+int dc_lb_pec_dynamic_sec_sel_get(struct dc_lb *lb, enum dc_link_id *sec)
+{
+	u32 val;
+
+	regmap_read(lb->reg_pec, PIXENGCFG_DYNAMIC, &val);
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

