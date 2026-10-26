Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BC60A380D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I3MxlfGq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D0E10ED8F;
	Mon, 26 Oct 2026 10:04:44 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE62C10ED86
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRUxZWJ15bzN3OcY/pTDhNNwEktsGeievUERiLUHrIWX97lxVng2TaFyGo/2LHyb92+r/mP+J4sSzVGTmgwN313iwNTtGXGUNkjwmEONbysIOlkUAIe6jlXmLgc192fCxihGBU8m7wYdSsTuCNkFK2Lv/3CpUMHQCdjdMFiGEOp8GJ/jIxOrFuhkpQBgII+mfo43qFEXSzCWA0BVkwGs04OeO+WKdd2D5uGDuC9QVhvOj8fGF4wsaUWGa2pDx9fUk3rs5ycKgfeUrWDhmdFlc+08bgfMImw8h5qBsZxe6XnPgG4HGtEagpoOlUC6uOZl26+r62nEwL9OusCVqcAGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBFWcvZ/FwH7x2oZJnqtnRgbxqk78saubX2JmqUU2L8=;
 b=M4cL9jfrM6WwSgc0crhK7i7a513UVJTM+Yvt8dGKYXuYWyyMMSADKmHb+tKZXS5hKR1Zr9uhX6/isdcpn/+B9aV82Ah05A8pP5yOas5pGXcLyZGO00YFHNNTrly5n58zZJDCfsO1HEFQ2fUR/B2ptwi2DOmwHar4omeXXZXFwQi3AMBsjgoKllNb2KU27U+zFGhne5rQHbd9yLMpHmjz6dh9ZZ+mObaJH83A9TTpt/uYkGiRZpJekHJ92U/PgVcLD3Mu7lSwsfeZQJyzCX8uxNLMxTD6yWYCy8hGKrJ7iOjuzlNVpNaMukzb6PAln7lf76379APJg5UJsbg0jXtc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBFWcvZ/FwH7x2oZJnqtnRgbxqk78saubX2JmqUU2L8=;
 b=I3MxlfGqrJgZ9+50NrFLZULJYNVs9eJ2CaPWKgfiK/lM1N/0lGkscTJj775w7rY/CMjvwx4VCFhGbkctgonutKROM7CSSu6FSs3NL6ByQYL9ie5Ixkd0h2pP+DR01TSOq9KsMvPWlVSVCIQ+Uz/2Mxai6paU98keSQPE2GMEJF0ilRSsIcRS8qDMIoyQc5tw0EyBYLkobOdI65SOcpDJzgGjFxb6WO1IvyYSj5Ww69N5iC3D43dkofGZXuoi6stkIB0Ro4sejtreRCpYWvLKmsJ3C+zGtEm2j11XP84aBdKn9DHvOEpWbGT3O43Tgnk/0BWPc+Jh1w8SVUI3Eevtlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:13 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:09 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:11 +0800
Subject: [PATCH v7 06/15] drm/imx: dc-crtc: Disable at boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-6-a0b50cc4fc65@nxp.com>
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
X-ClientProxiedBy: SI3PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:4:297::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: a4aed128-0319-43c7-4d3c-08df33487a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yKCVKl248Pj3jK4FiU9bQXK0G2ccE7AJwfZkRNr1joZ8ZsWWBNghD+B9MZ2TtdNkxmaoN11hXiBIT2/DTzcUoWGNEiNFV5D6mhpZU4e/euke/zDJBFB87o9qCTciXfdiyP9SJUe9XQqNw0kRgxBL+hsQmnrXptg6IcjKoeD/3C5pnnH/45ogMZ0h9q1zLxVFwGkeqC+9xeE6MJwpZS83OaxEdYVkVERVuBEbOhkCWAp4p2mqWK4WXmRGfJCzwpV6gt7H2JBp6OR+BeJZvnL/eVP6XUVYUIihsqs2xzopw/3+iCtrWdkSu2DIKZVhRNjNjbOjyUy0hKzR3MmUh7mbWXWDl0WkWWJjpXHJHbjPg3i6DDNwEmsSCL99pDCPnW0Cidk6Z8hzIYIZ+GCNTjpyFQlHZOWesN0TahBxXro8bh478SHiV5BZobHSGp5pKkB/AW9pt+BZOu7J7nVSJ1ZrRnGs894pKDAeIXXQICHHDKSpa6d4cLgxdbDFKxBb7Rk6utCg2Xyk3FcvaczI5VNioMUPr11nae0SUh9xgzGRMqlakl+hdD/E1pWyguGH2UJxnWcOSMIwttPd/tguesIkZUW6Vw8WQmj227zFvTcsYwyZNeUBB06r5B20jRmrx7dgZ6yRvycjbwndOdAjzHEGFSYl89cK9zTX07AUf5O7RT6S5RZSCRo4HQVVJoJgpiHJeS7sujbNxjeBTrkmBp59jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3lyNzJsNFhzclVhSmY1c3FseUFlZUNZbmFBRHBpTkZJYlRkWmdQWEVWZk5w?=
 =?utf-8?B?UGpHWXJ5N2Z2L2w5MlRRRHFqejdPbEhFZ3ROWWxwM0pOOGp0MXRCSGtkYlpt?=
 =?utf-8?B?TVVCQkZnRnRTTGR5MExRNVZBSVNmY2I3STIwcDl3MnRmdm9vODlCNGU4SENU?=
 =?utf-8?B?RnhuOG54dUg1MmcrWVZUU2FOTERDeEpteWp4elFYSjFnN0J1VTBxVGNURGpU?=
 =?utf-8?B?RGROVGNQZm9RemNpcFdXcXA1cW9PeW5yT2RHNy9lajdFbWI4WUJuZlZUdXpt?=
 =?utf-8?B?K2MrZzhPMTRTM1N1cWtBbWs2MnNnQXZ1QUZ2cHNtMDFzSkppOVNJZmpwMjF2?=
 =?utf-8?B?VnRkeGc1NG50YUlrZGVucGN3V2ZscE9MS3J1dW9LWEVwZG5uVFJma3hRL2o5?=
 =?utf-8?B?dS84dFhXUW9MTmlwc09udkp5NlNiL1ovaytsbWVNendLRFc0RTl2ZEJTelR4?=
 =?utf-8?B?d2p1ZURKcnNFTktNZlFYZm1lbzVLUkdkcDU3YzBkcUpMek54dE9seFpBcHpJ?=
 =?utf-8?B?VDY3LzZYbDhMWmxwWjVlY1JZaVpkR2t1RWFMQytOaGxYWE9qMlh2MFU5disy?=
 =?utf-8?B?cWxBdU1yZDBZbnNqUHJRbUlzaGdPWE4rTmsvSjdtUVlrNEZrd09pdCtOcXNt?=
 =?utf-8?B?elNRVWFBdTgvM0piT3NIcE1hZloyeXpvSXVKR0RLbE5Zd2NwZ0JPa3NTUWhR?=
 =?utf-8?B?RTBUTmtOU2J5NTMzOWJ1S1JUNzQxZXppOXVPVmlYM21RUUpDRDZBVEo0YTZH?=
 =?utf-8?B?eUR3SEFtRmNRK1NyTm84dGdKNTJpREFmeFdDdlhyYUZva3dWOGlHcWM4ejFa?=
 =?utf-8?B?NHhrZEVPYzlDcmkvUkV0QmdBZCsyQy9xNjFQSFZyalJ0U1kzcFZ0ZGNpbEk4?=
 =?utf-8?B?czNFcndUZjhLVm5GZ1FQUHgwWno2a0NFRmk4T1ZzSmd2MzVtNlNUcUN0NDdS?=
 =?utf-8?B?UVUyWU5XbmNhRWszZUpuV3BLd1Z2WWUrbFF5SEp0OUtvVHBrTW1xS1J3NlVx?=
 =?utf-8?B?ZWorcnNNdjdTbDhNTXp4TUxnRGQ3amN4eWxTbENLTXJIVGpPYXJsVTdDLzAv?=
 =?utf-8?B?VVptMmpLVlpVQVpNUkcxS2ZYRDdHd2dOV1ZvT2lCamh5WjNCU3IwTjgwbDlM?=
 =?utf-8?B?SGs5QkRxYVJha3NuaVpiaFFUQkdjOFdQOU40M2tFZm1WUVdkaHZzZXZpdDhl?=
 =?utf-8?B?eGo0MTNNWXQ4QkdLbExIb1l2V0NmdWpIZ05aQlZWWWlmQ3FHcy8vMHVieUZq?=
 =?utf-8?B?RjFIVG9RUzlCZWxHYVF1aDd0N0I1V1hDeWxndENIU0FFaENmcER3cDZIajFQ?=
 =?utf-8?B?R0pEYmlOQ3FvZi9vVVhIZVFRbjhScDhabHlleFg3Z1puTDNzZ0o2a1hKZnAw?=
 =?utf-8?B?S1JadXBxUzFlK2EycGhIRXZoSjR4Z3NHOEsyajJ2VTJTZ2I4MXM4b3lORC9j?=
 =?utf-8?B?QlhCOGwrRXQvQ0x3WlFzK0pRRnR0eDY2L3IzOHZ1UlhJaTZoOW1VeGczMHNZ?=
 =?utf-8?B?aUU0cXhLY3VaMk92bTd4cytFVVB5QldvY3NNZjQrbEtWbGlrYm5ZTUh3Ulha?=
 =?utf-8?B?ZmRIUGZCeWZFNUVFLzZUMWlEdTJiVFFCcEplRDFjWjFiUUsrQVdjZFhyYU1G?=
 =?utf-8?B?d0U4Vi94Tno2ekJaTGtsa2FXNlFXSk9sNXlUMkJWcWQybXBNVktra01tcU5X?=
 =?utf-8?B?UjlRd1RBSkdNdGFvOWI2NlFiUWZvTmtxbW43MHJiVlR6NG12d2JGNGpMQXNk?=
 =?utf-8?B?d0FicE5wWlY0MHNZRnRLMmh1dXpRSTY3RXREbThjRlJWM3pxZXBHYzB0Y2Ew?=
 =?utf-8?B?ZDU4cXRVRjJOcFVsdDBQZUduOUZpOURWVlFnSnZiaHc3NmhEZjdoM3poTC9o?=
 =?utf-8?B?ZDcvNm5TVkNSTDdOL0ZjVmUzbVZPYWM0MzIvaFZMUG9reGUrQjRjaFVqd2FP?=
 =?utf-8?B?L254S0lhUldoaHh5VHJTbFQvazV6NHhyVzVzVk9YZzJHaTVVako4WEpkSStP?=
 =?utf-8?B?K01uUEhuSTNJMUYvR1l3WVUxVDlLTDNCbFd4VHJORTduNjBxMjlUVFl4YitP?=
 =?utf-8?B?b1VSUzBLektMZGIwZXlpUVZNRnVhazhzYUZlNWRBQlRFaGZtcWlkSlE3d0FM?=
 =?utf-8?B?bWVmMXY4ZjY3ZTh1dW5lbDRyN1dFR2pGMlBxSFdVU2N6QXgrU0NDT0ZiRURF?=
 =?utf-8?B?TndiOFFVOTBMQXg1VVVndnEzaGlZTk1nYXpHKzVaTG8vcGFscTFzb2Q2Mncv?=
 =?utf-8?B?WWxtendZOGZ2R2xnbHZkbWQveWt1N2NRdlM0WUp5WDdhdm1rNzk2Vnc5TjJp?=
 =?utf-8?B?YkZtTUV6eW9iZU5ZeWJrdnRrdFNWU3RXd0dHbzY4VXdpMnRrdnBUZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aed128-0319-43c7-4d3c-08df33487a81
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:09.7836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eBb8fm7rc8sFXHRzBlagKeXvz2tbGpFwfaZZKd8cDLZyNxlJAQ3Wjk+l8l66tmMSqHwkszKVkGnIBCz2IRpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11500
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

CRTC(s) could still be running after the DRM device is unplugged by
calling drm_dev_unplug(), because the CRTC disablement logic is
protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
driver's runtime PM) and pixel clock use count could be inbalanced
after removing and re-installing the driver module.  To fix this,
add a helper dc_crtc_disable_at_boot() and call it to properly
disable all CRTCs before advertising DRM device to user-space by
calling drm_dev_register().

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Check CRTC status to ensure that clocks were enabled by a previous boot
  before disabling them in dc_crtc_disable_at_boot().  (Sashiko AI bot)
- Modify debug message in dc_crtc_disable_at_boot().

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c | 67 ++++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/imx/dc/dc-drv.c  |  5 +++
 drivers/gpu/drm/imx/dc/dc-drv.h  |  3 ++
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 0d64186a9901..c7dbe5f500b4 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -227,6 +227,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
 	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	enum dc_link_id cf_link;
 	int idx, ret;
@@ -287,29 +288,37 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
+	dc_drv_set_crtc_enable(dc_drm, drm_crtc_index(crtc));
+
 	drm_dev_exit(idx);
 
 out:
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static void
-dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
 {
-	struct drm_crtc_state *new_crtc_state =
-				drm_atomic_get_new_crtc_state(state, crtc);
-	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
-	int idx;
-
-	if (!drm_dev_enter(crtc->dev, &idx))
-		goto out;
 
 	enable_irq(dc_crtc->irq_dec_seqcomplete);
 	dc_fg_disable(dc_crtc->fg);
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
 	disable_irq(dc_crtc->irq_dec_seqcomplete);
+}
 
+static void
+dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, crtc);
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		goto out;
+
+	__dc_crtc_disable_fg(crtc);
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -318,8 +327,9 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	/* request display engine power-off when CRTC is disabled */
 	pm_runtime_put(dc_crtc->de->dev);
 
-	drm_dev_exit(idx);
+	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
 
+	drm_dev_exit(idx);
 out:
 	drm_crtc_vblank_off(crtc);
 
@@ -331,6 +341,43 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
+void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
+{
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
+	if (ret < 0) {
+		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
+			    ret);
+		return;
+	}
+
+	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
+		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
+		goto out;
+	}
+
+	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
+	__dc_crtc_disable_fg(crtc);
+
+	if (!dc_drv_crtc_was_enabled(dc_drm, drm_crtc_index(crtc)))
+		goto out;
+
+	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
+
+	dc_fg_disable_clock(dc_crtc->fg);
+
+	if (!dc_drm->pe_clk_axi_disabled) {
+		clk_disable_unprepare(dc_drm->pe->clk_axi);
+		dc_drm->pe_clk_axi_disabled = true;
+	}
+
+out:
+	pm_runtime_put(dc_crtc->de->dev);
+}
+
 static bool dc_crtc_get_scanout_position(struct drm_crtc *crtc,
 					 bool in_vblank_irq,
 					 int *vpos, int *hpos,
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index ac1321adf1c8..09387d62cc0b 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -17,6 +17,7 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
@@ -108,6 +109,7 @@ static int dc_drm_bind(struct device *dev)
 	struct dc_priv *priv = dev_get_drvdata(dev);
 	struct dc_drm_device *dc_drm;
 	struct drm_device *drm;
+	struct drm_crtc *crtc;
 	int ret;
 
 	dc_drm = devm_drm_dev_alloc(dev, &dc_drm_driver, struct dc_drm_device,
@@ -130,6 +132,9 @@ static int dc_drm_bind(struct device *dev)
 	if (ret)
 		return ret;
 
+	drm_for_each_crtc(crtc, drm)
+		dc_crtc_disable_at_boot(crtc);
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "failed to register drm device: %d\n", ret);
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index dd1302382ab0..1ec9304329eb 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -50,6 +50,8 @@ struct dc_drm_device {
 	struct dc_pe *pe;
 	/** @tc: tcon list */
 	struct dc_tc *tc[DC_DISPLAYS];
+	/** @pe_clk_axi_disabled: disablement flag at boot */
+	bool pe_clk_axi_disabled;
 };
 
 struct dc_subdev_info {
@@ -96,6 +98,7 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
 	return -EINVAL;
 }
 
+void dc_crtc_disable_at_boot(struct drm_crtc *crtc);
 void dc_de_post_bind(struct dc_drm_device *dc_drm);
 void dc_pe_post_bind(struct dc_drm_device *dc_drm);
 

-- 
2.43.0

