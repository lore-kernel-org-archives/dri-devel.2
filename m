Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E340CC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEF610E9B8;
	Thu, 24 Sep 2026 08:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Suq7ndvW";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011017.outbound.protection.outlook.com
 [40.107.130.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7676D10E9B8
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvauH6yO2XddD9MvE3LNp0rwqxSPgUi3vsag2rwQbg1B94YMVLlh/NtZYxcCSWV939IkMzzF5SN3DDnK1/6KnQ4LZZ6RGiSw9gz+8ucx/7CKkFPtkciATzHcyawJmnOe8FgyqRB0UbxLH2uyid6+a0N9imks5tzkbLYWHlEpCOu20SFrY0rbJ83ynu/bu5v81ZLET5i7jv4S7w/87VjSES4FIriDJruXyW0zFjR6tCFX9HEMQtJNbhLDWtFELBfmM7auBlHxkKb3FpYTXzSowgW39lGDAn9fwMzmGFErFCctcx2cD1E8DHoNFBsg61hjkvA169xy1n1RA8AqKSb2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyyRmgf6luKwbmyb+3rxCwVLP5ATZrWI7rTwLer+jmg=;
 b=l11bCwrZS44OnljGMl/eNLr5nK+0e6IJVEFY+7mV1yc6DbeG+Z+kBbOnHWERhks4AzCb0l1UNquoOfpLSW3+1cj0Cx7QSbByHuO26mXoP4moZ/VWLuSjKmP9V7H6wbglRRzrqe2jnJHUkbnwBHs3AyeEKcZiIhtBsraGEB8+aSQfBEeFuyquAzibwUOTQJm0g/DPohJ2L4GV0i91YFsBJfuIDBAtK9lMxHWEL4OkZPzIljpGGIVVGq+IAjSwXYASqp5wItEikXd923wAjLKzSBPt1hcdNrKDI/B2WTY7EcReSk0Mq/DgHgOMgaaQX8gBQfRt0D5vMkjUfj8qsMntkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyyRmgf6luKwbmyb+3rxCwVLP5ATZrWI7rTwLer+jmg=;
 b=Suq7ndvWkuISeQbbrkj4r+QqZ3YAIpX2MUosfg03zV1kSmb60mGQr3pcHNdeTzM07+L9gKjcZ7/VyVN2MpSR2JVGp9+mg6l+25PjUziGJF+6bJ5nX395xXY71Moid4KZWxEezBcQtU1OS4L7/XbAlVBzgBFbQNuPqSqRDbGJQ1KGn5R3VZeyAXhSYE5Reqj1YQOSsZDTffTPNhwcC/cJP6WhSTIGaIBZudrrecCmBD8spMNpPrjVY5oFxaOrP6Xr0WjOD4AAW1kIwGrmgCRPGeZXPcP5Ia/YAUAN6xKi7al3naRSbvRQqPzMEgSOVAU9v+5kUr+PMsl/HvjRWlo2SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9937.eurprd04.prod.outlook.com (2603:10a6:10:4ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:37:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:37:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/mediatek: hdmi: use regmap_assign_bits() for conditional
 set/clear
Date: Thu, 24 Sep 2026 16:34:56 +0800
Message-ID: <20260924083456.461815-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:990:4::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ea4ed2-04e8-49bc-6972-08df1a1712d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|10067099003|56012099006|3023799007|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: frmE4hGtpZl/IXdzK4l02FiN+HdBS/VJjkV3vEhtALVjD6PsQR+XmyjEam3a93ge4jrn8FYQA3CzfG8E7667+hNQygEYbA4N2QkpeOQZmdHkBQI+Ud6ugxmsrjKHZyu0PsiwuoPR0MGXVvsuPPsgH1qxmigrWITRyaSzkAllo5g9TkfUDQgETksbbh1Bh4TCaweEmovnpV4uSHoiKUSVc/sG9nad+WRde1CRovXCOYhu774hbVmsVjHuxp0dBQ/rPhIh7+vh9I1nblWa2Xu2ACfIfbe3yMnGU6IMHTNC+uai5j5/3LiOPPkCxOx1sPXoBqq9fIA7Wc5LrAeV78w6+ewQfFCWvUjK3jXKiKDPSO1/SZQD7V3Dp7AlDUNLq60skqLGtRWux2FN7mYStFJEemqzXC62rw0ip9GETVuNr6gKucfA/PAQFcfEvMn2mOiiUidz0pGbdknRDRrZ+NKkZMfQOcI+UyhAbcLPymtKNZtmez7WusrJqt0aWfoDN2GerMnSMAv5GSoZTPq9F4UGMmzf86VSIawI1qRROtR6JBLcAoT/Fo16CRBRi7tCw5zK1XsxfCnQnDdAUQC6k0aYV5qJPq52IC7Ajn3xuf+Putg7+QWSEZjZ67G4AXxwD+cNkubqWWuKH3A+JJSWHHspEmjMWJTn3QN+E7ztCvLOYbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pcokbg2KwFQq0iKAOb3v+Mo4UeKZuhtYIjKfpfFX65Q/2QIDAuaLJthYaQOh?=
 =?us-ascii?Q?BPh7oXhG15kW3Di/cU4LfN27oWq9sllC4fPvmxT2PUvUsnlmH2RdNJUaF89k?=
 =?us-ascii?Q?P0hAtMDYN1/R8fnk+OBCl5J95wun0v2mflwccZ8AysdiI/bsgJRJDYnSBlPJ?=
 =?us-ascii?Q?Nv+e8hPomWcbZ5buSLDbG82OK9mIh+zzDRzTH3G6j+FJeBZD7adssH2XfvJT?=
 =?us-ascii?Q?TaHajOpRomd7chZ8kpY69OMN6bQgiJN/Mf+0vCGV48wm+B+Wm7jdvfHqKyMF?=
 =?us-ascii?Q?tNTdUcL/Yz2p/cv2JZGqPll9a+WNjtWLuGlrSJG1CWBomGJFaAES+yvQ9/+M?=
 =?us-ascii?Q?z43Q6sjypxNOuWreGCF89nCdbeoiGV+Isr0nm66FaEasCikbdNsmOQjQLAFd?=
 =?us-ascii?Q?UBTuGBm7TPGPCkJmM/i9z+BXHveU418PhqKBQ3Lu82aWXgwY+/T0i2YDzk4c?=
 =?us-ascii?Q?7JyvB5Dk/7FjDMCxdctInexUSgnTgJNDmRZkYUXxAtJgRe5g9h5NEk+oudHh?=
 =?us-ascii?Q?UodxcwI86GH764ve20AQtC938OgFZn51LVxH0OoO4/iJ6J35F3evBAMqmIS3?=
 =?us-ascii?Q?2J4TyyH0thoxL5kvSs3+lf9DSpxa0yS3Dsfz0XSKBhF/7G2bT5FvMo8YP/5T?=
 =?us-ascii?Q?5Hk+zVTZvHCUILN6+3zi4o1qOxQgpXsRc4nNsSlUMudQi3uNmehSpSvz5kON?=
 =?us-ascii?Q?9T+51i184w4Bb6rMeOpuiycSW8f9EIdzHc3kN5MYUrqp4iFM2pRpCZR/1eAj?=
 =?us-ascii?Q?YhQjCG/0kFbLV6uueqnHV6fcbLs4pxHTKbrppacwHBF6NvaNlzHEIPQO9fQm?=
 =?us-ascii?Q?GISBEUaEg2auO+eHQGnfHJ2KurKOgREjY+Ao3fFATc7qc01xiI1laNZyktpp?=
 =?us-ascii?Q?WHqNoWG6gzefflX6nEKWkBYWcaXFKpk0YWiIwsdDbK/W5q/wWxXFKIAMIKe5?=
 =?us-ascii?Q?E2aVWtiysucK2AbsXNwG/hgXWxA1fHD7NZotSz2YQRGn6TGPD9LrQ1uCyAMr?=
 =?us-ascii?Q?nA2YdP+jbBKdACvwN7E8mNMf9joxukyP2zOUaqCXwR4byuSk5GKi3FFAfwOg?=
 =?us-ascii?Q?bwJioV9isiHpjJip+b0gCD+j9Kw+wORxCCoOErcAMR09UxDamCJZXWSElvVG?=
 =?us-ascii?Q?ytkhFw+8j6CUm5vX7kY1gzvne0a0iYHunCndVeTJM50tG1SLhA7wO6DmhR+n?=
 =?us-ascii?Q?4YRG/zypKLjyfdf+1y5UuJ8GajFf+ZuGy2JPq4TWa6yB8sEjxFVOvn3/9/IQ?=
 =?us-ascii?Q?HC5ZkRrJJsuK9ladullAcf7Hq6Il4igyPf0MOVuC504l3zGEoDtSkEuOn2dS?=
 =?us-ascii?Q?EHcFbxPBlXemHJ0uxrEv+YdS/GVpCWQU8F8JRm45ycIkKp9XPH00rBnsPrSL?=
 =?us-ascii?Q?P85u4YeVWpkqK8ssp0dY2f38xyb7cOujE124gvN398dHar2Dm/XomPA7yFZm?=
 =?us-ascii?Q?UNVdVMIobl77WjlOEYmye5UkTC+1lDc761JOEQTe97QP9PjgWj5ZL8NpkDny?=
 =?us-ascii?Q?/uxW+9N9tqQB6meO851RcJyqhvgUKA0DUqwzht02muKqbRgWQ85W52LCNZFZ?=
 =?us-ascii?Q?KmCVJlBnNoh+Xz7WE8Zr2ODyU1mNxcT5u9vgQlUZ2Dl9YjwHLUbCrQXNOLvk?=
 =?us-ascii?Q?FzYygmPnrsEtdS4pAjioyCELnbEZUgsM31lJqiGCh4L+zqoJayfAlGzenNXo?=
 =?us-ascii?Q?l7ivT6kp9+U5vEwEkWQYAyGv/iEfTuNXvX15ebVYm+q1ZtdzePjHyAFmT/Xs?=
 =?us-ascii?Q?cE6FLJYmcdztzLl+LW5e01qBXDCieflAromrDkEJEdG6nagEvB76?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ea4ed2-04e8-49bc-6972-08df1a1712d6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:37:31.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ddOlcVPiC1reguT2xfQOKO0YIXXbuDFHpI5SNECQkWdBX83xfE+MvhvhdixYuyTGdgBBPXWuoViePOxP9o/EQK1w4jEwjXaY+xbhf209auVCVO2iu709RmKQM9+Ovul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9937
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

From: Peng Fan <peng.fan@nxp.com>

Replace multiple if/else blocks using regmap_set_bits()/regmap_clear_bits()
with the simpler regmap_assign_bits() calls throughout the HDMI v2 driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 46 ++++++--------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index f0277fcf3345b..cfd99b630cc2d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -65,10 +65,7 @@ static inline void mtk_hdmi_v2_hwirq_disable(struct mtk_hdmi *hdmi)
 
 static inline void mtk_hdmi_v2_enable_hpd_pord_irq(struct mtk_hdmi *hdmi, bool enable)
 {
-	if (enable)
-		regmap_set_bits(hdmi->regs, TOP_INT_ENABLE00, HPD_PORD_HWIRQS);
-	else
-		regmap_clear_bits(hdmi->regs, TOP_INT_ENABLE00, HPD_PORD_HWIRQS);
+	regmap_assign_bits(hdmi->regs, TOP_INT_ENABLE00, HPD_PORD_HWIRQS, enable);
 }
 
 static inline void mtk_hdmi_v2_set_sw_hpd(struct mtk_hdmi *hdmi, bool enable)
@@ -88,10 +85,7 @@ static inline void mtk_hdmi_v2_enable_scrambling(struct mtk_hdmi *hdmi, bool ena
 {
 	struct drm_scdc *scdc = &hdmi->curr_conn->display_info.hdmi.scdc;
 
-	if (enable)
-		regmap_set_bits(hdmi->regs, TOP_CFG00, SCR_ON | HDMI2_ON);
-	else
-		regmap_clear_bits(hdmi->regs, TOP_CFG00, SCR_ON | HDMI2_ON);
+	regmap_assign_bits(hdmi->regs, TOP_CFG00, SCR_ON | HDMI2_ON, enable);
 
 	if (scdc->supported) {
 		if (scdc->scrambling.supported)
@@ -103,10 +97,7 @@ static inline void mtk_hdmi_v2_enable_scrambling(struct mtk_hdmi *hdmi, bool ena
 static void mtk_hdmi_v2_hw_vid_mute(struct mtk_hdmi *hdmi, bool enable)
 {
 	/* If enabled, sends a black image */
-	if (enable)
-		regmap_set_bits(hdmi->regs, TOP_VMUTE_CFG1, REG_VMUTE_EN);
-	else
-		regmap_clear_bits(hdmi->regs, TOP_VMUTE_CFG1, REG_VMUTE_EN);
+	regmap_assign_bits(hdmi->regs, TOP_VMUTE_CFG1, REG_VMUTE_EN, enable);
 }
 
 static void mtk_hdmi_v2_hw_aud_mute(struct mtk_hdmi *hdmi, bool enable)
@@ -302,10 +293,7 @@ static inline void mtk_hdmi_v2_hw_gcp_avmute(struct mtk_hdmi *hdmi, bool mute)
 
 static void mtk_hdmi_v2_hw_ncts_enable(struct mtk_hdmi *hdmi, bool enable)
 {
-	if (enable)
-		regmap_set_bits(hdmi->regs, AIP_CTRL, CTS_SW_SEL);
-	else
-		regmap_clear_bits(hdmi->regs, AIP_CTRL, CTS_SW_SEL);
+	regmap_assign_bits(hdmi->regs, AIP_CTRL, CTS_SW_SEL, enable);
 }
 
 static void mtk_hdmi_v2_hw_aud_set_channel_status(struct mtk_hdmi *hdmi)
@@ -423,10 +411,7 @@ static void mtk_hdmi_v2_hw_i2s_ch_mapping(struct mtk_hdmi *hdmi, u8 chnum, u8 ma
 	 * Layout 0 is for two channels
 	 * Layout 1 is for up to eight channels
 	 */
-	if (chnum == 2)
-		regmap_set_bits(hdmi->regs, AIP_TXCTRL, AUD_LAYOUT_1);
-	else
-		regmap_clear_bits(hdmi->regs, AIP_TXCTRL, AUD_LAYOUT_1);
+	regmap_assign_bits(hdmi->regs, AIP_TXCTRL, AUD_LAYOUT_1, chnum == 2);
 }
 
 static void mtk_hdmi_i2s_data_fmt(struct mtk_hdmi *hdmi, unsigned char fmt)
@@ -456,10 +441,7 @@ static void mtk_hdmi_i2s_data_fmt(struct mtk_hdmi *hdmi, unsigned char fmt)
 
 static inline void mtk_hdmi_i2s_sck_edge_rise(struct mtk_hdmi *hdmi, bool rise)
 {
-	if (rise)
-		regmap_set_bits(hdmi->regs, AIP_I2S_CTRL, SCK_EDGE_RISE);
-	else
-		regmap_clear_bits(hdmi->regs, AIP_I2S_CTRL, SCK_EDGE_RISE);
+	regmap_assign_bits(hdmi->regs, AIP_I2S_CTRL, SCK_EDGE_RISE, rise);
 }
 
 static inline void mtk_hdmi_i2s_cbit_order(struct mtk_hdmi *hdmi, unsigned int cbit)
@@ -645,10 +627,7 @@ static void mtk_hdmi_v2_aud_set_input(struct mtk_hdmi *hdmi)
 
 static inline void mtk_hdmi_v2_hw_audio_input_enable(struct mtk_hdmi *hdmi, bool ena)
 {
-	if (ena)
-		regmap_set_bits(hdmi->regs, AIP_CTRL, AUD_IN_EN);
-	else
-		regmap_clear_bits(hdmi->regs, AIP_CTRL, AUD_IN_EN);
+	regmap_assign_bits(hdmi->regs, AIP_CTRL, AUD_IN_EN, ena);
 }
 
 static void mtk_hdmi_v2_aip_ctrl_init(struct mtk_hdmi *hdmi)
@@ -662,10 +641,7 @@ static void mtk_hdmi_v2_audio_reset(struct mtk_hdmi *hdmi, bool reset)
 {
 	const u32 arst_bits = RST4AUDIO | RST4AUDIO_FIFO | RST4AUDIO_ACR;
 
-	if (reset)
-		regmap_set_bits(hdmi->regs, AIP_TXCTRL, arst_bits);
-	else
-		regmap_clear_bits(hdmi->regs, AIP_TXCTRL, arst_bits);
+	regmap_assign_bits(hdmi->regs, AIP_TXCTRL, arst_bits, reset);
 }
 
 static void mtk_hdmi_v2_aud_output_config(struct mtk_hdmi *hdmi,
@@ -728,10 +704,8 @@ static void mtk_hdmi_v2_change_video_resolution(struct mtk_hdmi *hdmi,
 	/* Disable adding deepcolor information to the general packet */
 	regmap_clear_bits(hdmi->regs, TOP_MISC_CTLR, DEEP_COLOR_ADD);
 
-	if (hdmi->curr_conn->display_info.is_hdmi)
-		regmap_set_bits(hdmi->regs, TOP_CFG00, HDMI_MODE_HDMI);
-	else
-		regmap_clear_bits(hdmi->regs, TOP_CFG00, HDMI_MODE_HDMI);
+	regmap_assign_bits(hdmi->regs, TOP_CFG00, HDMI_MODE_HDMI,
+			   hdmi->curr_conn->display_info.is_hdmi);
 
 	udelay(5);
 	mtk_hdmi_v2_hw_vid_mute(hdmi, true);
-- 
2.50.1

