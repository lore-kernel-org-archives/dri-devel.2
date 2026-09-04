Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFB5C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56A110F8EF;
	Fri,  4 Sep 2026 07:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QwsNuzcL";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA2110F8EF
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWlueV29D+xo7g/jMDnqs0QoFRKN2wpbrfA+DLnyk/ZWPBrdnzWZ22j5RNoYdyb1HBUExKFbbrqc263pyS56ix5ODEQi2Y1HoO13oEF1F6yPUUHjBKOD/bxffNmshUx/aM6NTALFQkODrdbWYQYpMOuSXhPKopXhM/5mXX0Edu/Lq5hrJ4D5WIfAUkX+Ym3bVlluPPDLKU2VxiWSsCxFx6eC6PQzJw80BeyNNiAd4OCY103ON6O++pfYCP69aIWuWKNqP+irdPLFa+fRQVhewcIQhTyMp94w8SdWfzT3iMjXnikHfZ8hZ1kOvvyBzWpQgZaqkscYDtwqpHmy2QieEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2QK2D9p57qld+bLb22osBNtky/o87QOikOAoOnM238=;
 b=EvXgo1f53jKOW1dsxxNlyWLWDIsLU6spEGpHP+ILL/jYTzyFuZ1S3jt2SHa/0EO5u6tH+Rsml5p4xhdYL0lCo4qtVKIoLsvXUJ2c5LefL0mHrHSLTe2dI0h97kOKm2sbn8R6DpBXXrvIG2bmj2IBU1PUFUD6amV1ub2QPXigtS0MFU7yqDtppWLEv6FIdSf9Xn1kTgZPOWORdj+g9i4tIm2SCGETudhld8k9zpijGGFu9kR9k7Fe70WWTdacWUp+fV49Idbh1YitdU8CMDYLywLD9IVPgdayeUgdWVtvr3gHoD6N/suLJgsBF86yjoqCntQ6zjER5ZSrK8gaRGgPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2QK2D9p57qld+bLb22osBNtky/o87QOikOAoOnM238=;
 b=QwsNuzcLlK3hOlGKNX8JgdQxH8+B24nelemBbNGVx1bSAz4TxCatKnDHAGqDEBUKECeG26mkxbJUvnwa0VwmQrFg1fQMKHzGCGbXVAu/z5LtdEtJ9p45aNzSdKOo5T/Ug0CUv3ZTT8qSkxtYJQP6XGd2oVItxo/VAJrKng37pCrzxtudOVQjnWlaSjxVPWUD0bA681rI6f4H5p+++IPUHKhLEFqEm/dlR5bdUzjAJ3y8iHoy9OTSgm0/gKKyfVjul2haiWrwx44vu8bT1LZPH3B7fUovFOxVx8f0E/XoAWe8vg3kdlIJFFD1d1AT5F8sHC+LaegWe+6svOdmDE/3Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:53:58 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:53:58 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:54 +0800
Subject: [PATCH v6 04/13] drm/imx: dc-crtc: Disable at boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-4-26643e3f6cb7@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0111.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::6) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 210c9a75-d758-455c-9efd-08df0a59ad2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|921020|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: X+62XzVWUJJPlDVwX3vGL2qazmLjiv7w6EcFpm3DuSQFGdbNrGgSqTZr+CAw3wpnaaJZAM/qRAvBu+7q+MTBPAudbU9NSx+mUwXzfAmMTUi9czi0YgNNQQ1ci65TPSIoqsnrWCLRCljjMlxfijP29YpRHTy9ZgoAS76NqKCl79Q3f4uaK6/woJuNf+3LOt9TXTSb+WQiFHInsoam5/uYTkLhcMgn087ItYNHjMMFTuS8X6x4qMsSWjaFPFo5x7Y5GtwnzHqWYcKZv8z2M4HTfJdSSo2ooKdtNLThSyH1H8WCgYTkA4IIQono5sSi+jMEgvaLqvM5QMGdhVu57HUcvxbKcb2avf6ypNa+wccPuIM/9ZuUj3quKLUdjqcR4hrC1iPYbuZjqHLxmW57Gj7OVvrp0uo/9Ci4p4/5rsajyrOauMEN1lzxbMNk98iHidRNusa5qo0ZmDnKzcvFs0TSe+TA2qYfkMaILvd25juGbUtqIMPlI+TkxNfNhSPMR9myl4pKvLjDpezzYeorSr3ryFYRFgUXr4XJQZ0fHmojTMfjIpWbjJsoAwS5PeCamCfb7mABQFVtrvXBiVcWwKiW/7Fb+Dgrn03KAb6Lk4t7iExVcufA3nQ/C8AoeyWNBF3Z4ar39lBXx4W/eco0QAzyM9KEBXHHGN9v+v76g94nWhQ12S8RgLYcp8op2wCVdE/62O8NA2UZL+H8wwMQjQoopw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRzbU1pOGIvQUlqMmRkZ2lZRmJwUDRLTVgrU3l4c0RIeGcrU1lRNTVJenlH?=
 =?utf-8?B?d2pMQjZOeG9qUkRjU3dtOUFqTjNIbVpvcG1wcGRoOG9xWDdsU0tqVVlsVWxY?=
 =?utf-8?B?LytiTTJRRXJjd0xMdlNRVnZoaUxmRk9ZVnlJZXZTbjhvWUJQRllEWkZReXo2?=
 =?utf-8?B?bjNmeElUeUdxK29mVjBlSlBmb242aURtU0RkYVdmQVJZcEpESm5udi9mZndQ?=
 =?utf-8?B?NzA4bjBuUFlKQ0dHMGdjSGw2c0cxU0x2OXRSK1Y4NnJHN20rUVkzRzNjTTJC?=
 =?utf-8?B?SlpIalVCbjd3V0dLdnR2ZWlFbi9mT2ZzMXRIeFFPYlBXeVJ3T3hOc2VWcWNs?=
 =?utf-8?B?MVZicmNIVDczSWJXQ2NZRVBVM0FVTjd4OTNXOFNFUHVrYkhuUFpWWkd2Smo0?=
 =?utf-8?B?MGs1NWVPeU90QXA0LzIrRkFDMkowdzJUakFka3c0U1djUzEvVmd3WWptcHZl?=
 =?utf-8?B?d1FCMmpBQ240WldoKzJnby9DLzlZSzZyRGl0MmxwOVBGcmJ4TVQyNnJKU1lk?=
 =?utf-8?B?NUxkR25rN2FmRVpjSnVZUzc4MFRvT1dURFlnaDJwZHRZNDRzbTNXdE83Y2lF?=
 =?utf-8?B?QWxwZXgraGZZVW9LZU14Zi9nczF4Um5tZFdrcW5IeCs1dlpXbVlzVzRtT2ZF?=
 =?utf-8?B?b2Fja0o0SnNYWmVXb05xaTJRdXdtb1VVM2FhdFY0ZGduK2xUQ3ZDeCs2MXYz?=
 =?utf-8?B?c04rNlZSY1JhVG9kVkl5aFhyZjdLZVAzKzFDdi93YmtUaHNma2diRjMyOGtZ?=
 =?utf-8?B?dmNQbkdPK2J4OHpubTk5LzU1NFFUN0dkUUtHZXV3a1MzbXMya0x3b2xtV1lQ?=
 =?utf-8?B?bFhGMUp4ZHpkT1ZUNnUrZmpsMHNVOU01N09IcGY3a3BLMTgwY0s4cTJwUDdH?=
 =?utf-8?B?L0xwdVFRSDZXcjMzVFI4ekVUcm55M0lVemhGTXBOY29yUUE3ZGJGM0Vmb2do?=
 =?utf-8?B?UUprcS9Ub2ExZ3IrVU9EaklMVW5XQTg3MmxLUEFyQTEvS3lGMktudEhCK3ky?=
 =?utf-8?B?MU92aGV4UHoyb3RMMTZ4OHhIbTAzcU1YYndYVXJNSWlKRXJ5cjRLQjFrbDhT?=
 =?utf-8?B?TEtqSkE1Ymt3MjIzQnBMeUtHUnA3ckRTZE03S2dBdGlGZ0Exc3FCQ0w2ZVdH?=
 =?utf-8?B?OXdEVTRXa0VqQ3UvYTFCVks4S2ljR0t1aFRBeEJ1OGtBYm9uMGU3aHlNUklk?=
 =?utf-8?B?dm1tOWJaek10QzcyZWV6YWNDeElmMDM2SzMxV0tYWnlPMDR0MDJBVnQzR0ZP?=
 =?utf-8?B?NWV3NHJ5ekZ4MGhjRDh5bmFxODJJcjlOdDl4aFMyVnlHR0pTcjRMb0VINCtn?=
 =?utf-8?B?b1RkN3Zpc2NNSEdUc3djcVBlSGY0L2F2dEVhcWdBTUpJVGZXOFFxaWphM0h0?=
 =?utf-8?B?U1dhdUtPb2RIa3J6ekVZblJscy9DRUhHRFJsWEJzUndsVG1COEdvN21lZGZH?=
 =?utf-8?B?TFRmbVl6dDVLU3hSSzRGK1BPb1o3OUF5Qmxrek53a1hUMDVMRVpZbWZPRTRm?=
 =?utf-8?B?NUI2VTVOZ3I0NlFZMDE1Yjc0MUtveEZVOUNoVGs0bXlHR1JiQjk0bHFnNmY2?=
 =?utf-8?B?a2x1VzVvZ2xmQXpYR3U4RGJVcG9IYkpQREh1Z053M0x1ZUROMTU3WnRGRmRp?=
 =?utf-8?B?bXBjS1Q3TUd6TWpobEU1QXpYdWg0dGFRa09KRzd5RkdGSkJzekRTbnBQWlUw?=
 =?utf-8?B?UTlKM1BBQ1ljTXBCMWU0STlZMTJzRVgyYXVUWkJNcXROS3pxbnFJMjhVczNX?=
 =?utf-8?B?RlE2cWZSMU4xYWE3Q2JhR3JCNXpuakFuZ2FXYVNuOFNEd01hRXFibEtzNWp2?=
 =?utf-8?B?U25ZeHBUT0ZuMXNxenczTlF4RFBWcmhHRUpUZHVQdC9tSHN0cnphd0ZuWXg0?=
 =?utf-8?B?Smh3Vit4d3VVNzVZMHdIbENDeExld1B5NzMvendCNEVPRUNhVVV1ZmkvZkVF?=
 =?utf-8?B?RXZ2M01uUVVMZ3NWR3k0STFuTVNBNHNjS29KQkM4U3dFUklFTlAvMng2L3Ft?=
 =?utf-8?B?STI4VE5lWFo4ai9yaEpHd1g2WnZqcStQTTRWWUhCQjl0S1lDdXdCemdkTGRE?=
 =?utf-8?B?WXdiZDU5ZWJ0YmV4QkhMc0pkSkdFWStHa1I1d0NRVHc5MVFsVnBIaTI1WS9n?=
 =?utf-8?B?M1JCRFlHRVVQNEl0VXlOdjlMSE9vNDFlbWVwRThNYjdVMWdGMW5IRTVsK0tq?=
 =?utf-8?B?cFhLSDZpRWovdVJidzZkc2g5YnVOSjRQNkpwdUFtdlN5WW5WbmkzMnUxQmcy?=
 =?utf-8?B?dVRqcXVXcWNydmVmNkp0dDlvS3pkNmt6dkE0OFlnRThBNUlBdjltS0VpRWc2?=
 =?utf-8?B?bWpoVGpLWDdsZG9BL0RGSHZnb2JQZk11bXFzR2RUcGtCbFVYZ0Qydz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210c9a75-d758-455c-9efd-08df0a59ad2a
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:53:58.4053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzzHaiwTwVv1vkX0wskMYNrluqegRtRZGUr/kro2mGPKkvOcfwj/SXT2fi+fp7sXzZD8PXeg3GJpuajHVkrfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7115
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
---
v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c | 55 +++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/imx/dc/dc-drv.c  |  5 ++++
 drivers/gpu/drm/imx/dc/dc-drv.h  |  3 +++
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 0d64186a9901..1a537cf88daf 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -293,23 +293,29 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
@@ -331,6 +337,37 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
+	dc_crtc_dbg(crtc, "disabling at boot\n");
+	__dc_crtc_disable_fg(crtc);
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
index 13795a2ad735..c051a17c3643 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -16,6 +16,7 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
@@ -95,6 +96,7 @@ static int dc_drm_bind(struct device *dev)
 	struct dc_priv *priv = dev_get_drvdata(dev);
 	struct dc_drm_device *dc_drm;
 	struct drm_device *drm;
+	struct drm_crtc *crtc;
 	int ret;
 
 	dc_drm = devm_drm_dev_alloc(dev, &dc_drm_driver, struct dc_drm_device,
@@ -117,6 +119,9 @@ static int dc_drm_bind(struct device *dev)
 	if (ret)
 		return ret;
 
+	drm_for_each_crtc(crtc, drm)
+		dc_crtc_disable_at_boot(crtc);
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "failed to register drm device: %d\n", ret);
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index eb61b8c76269..68e99ba7cedb 100644
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

