Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C5606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hdeMYQYA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EB4112D15;
	Fri, 23 Oct 2026 19:45:47 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5770112CD9
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRFV8HO+npHCRb62rqGE3sFHqFsl8p3gDE/Qy9XMPS/EzlQa7sZHIV/Z4V2nLq3NH1VzJoXIJ9bX/DbgKrMhPXGeBKQIm4NQnwazug5r2PhotFrZ1wc3Rn7rvv3EuzQZihXLmiRT5U9dYvavffr2HREbpPX0nBwn63LrjL0+DaUbrgyQC9LaQE1Ls/kKYkPWIiDNLApHzYzYK5rZTV3w4zZSLWXL8nOt4kfS9qBQBtAOkQRmwEgDDTAZnk090i/xT7ZiGRRmJviqezVQLN56ZKvPlugUjU7JU5pnGUDcK6VzyG/VP5m/R5JSlVgimTaXW5MQMO4/+hhwcjpb90rOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2zTIuQyK3622MP92UcGb2L4wiQgWGPoQJvtud5Maho=;
 b=NGaXus5WNwyQqFRZN+fPRJCYvRS5uNrMA4pKXKomQx+29V2TS700LQUx8L5PFeGHx5aRWSUSwa5LrZ1Fi9F0sYhwhWbjF9sHHIuWrQ0LH2YZKCsG7bUZFmMWv8cAo0GDNjIjlFFx4fHkraULxSkoqGreOliywtGHpPiIU74u70jhuezQSdgcztG+6bwDI7dp4CfGw7/936NvYv2IeSP8FRlFWUSPpJVB15p1Fz5dLOkcTqLPf5k2TWSkYVnso4tVsTLXKHerw83UHaP+n8PZWMWVAEJTHN38aCP6ZgtAdC6dE1Q8nmo5HD3BvdM+ZFKtvIjYcLqrmszuaGeeLRGCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2zTIuQyK3622MP92UcGb2L4wiQgWGPoQJvtud5Maho=;
 b=hdeMYQYAwP7TzJwHI1CAJ8GOgOQf+G2uE9dReW3ztliEsCwqEjnJcXoo0QU48gjmb6Xb/wGlqdalgsMwrSh9VW925fZrzng1n7692nfjhn0h7kLaH7+iFDZ4snfxgX9DGPBlVjQLQgD6NNK134wNZQxoR2uaNtbZy1Z2ebZtr6XmfrmRV9WNliJUxR99M8omutq0yXZbCU4w63QW6bWOQiCsA4y0GQnlG1ln1Aw8e0M0sDXeIo5wA9X4hpxVNKi0uJCWbYl06YlZhO98MZ4sslzSXcQMvHu5/HfgEJ1cjGzXtQhStaaByLkk5LpcP08zLnFRM+09g9SLZCsNDF5CdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB12639.eurprd04.prod.outlook.com (2603:10a6:800:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 19:45:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 19:45:32 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 23 Oct 2026 15:45:11 -0400
Subject: [PATCH v4 3/7] drm/panel: simple: Add Waiken WKS101WX001-WCT panel
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-dxl_lcdif-v4-3-4ae8395a4b23@nxp.com>
References: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
In-Reply-To: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792784713; l=2552;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=az+/0LiAwAne/3gzuso+b4pc2SRuyTBaR9nf50mThPQ=;
 b=vlzNkIHgV+P1GBnqGf3/Epi6aN5zU99zIqkZLX+H5+qw1QJnRqiaZp6ZeG/nMCefZbRrtleDr
 rtEj55thSgkAqF+xvmGC849A4EoJMU65M8N4hz6kNyaa2Catn0dQvUv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::6)
 To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB12639:EE_
X-MS-Office365-Filtering-Correlation-Id: 925cdd8d-b7bd-44c0-cf0b-08df313e32bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|921020|11063799006|261021121427099003|10067099003|261009223027099003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: 1KFWjLP0lz2UShUfaixWnrrHUDlTi0jLDV+2OW8ZHOCd+x84ay3YrhlPvr7Poullu8p6RWd3it9q+ZqZvv+tM/yXXs6Hms0iiTpyd3W5q4qDshHGx6qF2rAMPVJqfED3B2oit2cUhGOdKjqamHHMtCWJzkk8wTUP3127zU8C2ZXaNAv7m3k2/r74m3OnYmLq9TAZlB8eS10Qgi/vR20cfQrNAPbTKPvD1/dHWG/2aZGa5DH/uViP6lK3p2Ct13zWinvIhwkhhSQsYrlBGUji8YrF4PbrnAfF9z/2gD9iVGKcZysq/EIJRnOUWoQYJabucS+yyucLSTDgaWFfcnQssUc8OjW5rfWMLb55PzqoY0eJPNYetXRfuvJMiPrFYAyx1mp8pN+aCv5batXto0K8mhCDUhxDW3aaIfxn7Wk0R3+/ZOg4Rg2yQsXzXT5YALFaegn5iS6r6TXHtvmmO7OdDJILbI6+dB6tAyhIcV6g6SrtI0+6heWf/vzYjxWZAi2JwwtI69mIzkd1FBtbkg4eXz9RWgl4DngQRkAxsqiGhStcC12Rm5f5VrdRIrs49rZ0m+qk78BEp1U6TuuBLrN8xBvuj0g902Yv36cAW6CskupUdFHByxadytD6Q8NeWz/MQIDexfWK7H/RaYChsryH5WNkLn0xu+KJmiGHBtm7ngoCRWnxBeKMU2f5ZVaYHJB+cQr4txVU5GMNp9o/fdvwRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(921020)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFHUER1VDdlMXQ5eVFFYWlRbEJsMnhrdTJzazA0clhGR29aY203MU5ITGNs?=
 =?utf-8?B?aDRUYW03QXYybFc0dXhyTTQ4djdmWHlwMG9tU09tR2dwS0dGUEpEUnVKMmo2?=
 =?utf-8?B?cGFtRS84L2pYaFkvdjhpOG5VdlFROUkxeFg2WTdYb09abTF1QkRsdklrbWFt?=
 =?utf-8?B?ZmhuSlZHb2Y0dXlXUDBUTm13UDBBUnNTQkVGeVpQMG1neTRWclVRamdIam5k?=
 =?utf-8?B?Sy80MVZQZUp2R2F2Ylp3aGdLMHp4a29oMkcyRVQyRUw5aDhwRnhSK3dBa25l?=
 =?utf-8?B?NGdTK2RyNmthWEtrVlVFUHdMNVZOd1ZFRTJnYktxa1g0ZTl4c005dG9oc3BE?=
 =?utf-8?B?RTJBdHcyVTRzelBiSUxjYWVCbXZneS9oS2ZPa0gvVmkyeEsxdWVROVNCa1Vw?=
 =?utf-8?B?UEprekRxWkxMMmNmUHdMeUJnTkdVM1VUbThnRDcxZHNqcFY2Q01ySVpnVnk4?=
 =?utf-8?B?WWhtSERxWm0wS1JKVE4zekYydVpYcE1YVklSTTk3L1VvVGRMZHl3ZEF4blE0?=
 =?utf-8?B?aVNzRTVJTEdNa3lOWUdvNHppQmt3RTNDSGtUQnFyZ2IyOXRKKzlTQkszZVJ0?=
 =?utf-8?B?cUpwcVh6WEdUMkhGTFVYWWkxZ3NWRnJxaFNpQ0FuelVrNDRQQThQa3ZpREc0?=
 =?utf-8?B?YWVjSzA4M2dDYnNoQ3UycHBiV1ROVE9VWDRBK2hFN0FoblJSMFR5OVE2VVJS?=
 =?utf-8?B?djBvOElkOXIydy9jeTNsMFlQcEN3bEgzbGRiQ2M5WWdlZjExekNYNGZxL2lW?=
 =?utf-8?B?RTliam9sRU02ZGI0ZEdlcDJMeTliQXNscWxRaVJZZnRUU1FTcUhzSDdTSTVS?=
 =?utf-8?B?SFZoblU3dmNTa1BvTFZFMmlVRk53dFY5RFRMZytXYmRTWllTSmpnREdKWUcw?=
 =?utf-8?B?V1pzTnY5eTUwcVFpRFFqUkdCb25WelJpR1dJaEsxVHZ4WS9VZ1h3OUoyckZ6?=
 =?utf-8?B?Y3U5ZGFCVGpGZHRjWUVoVjM5dU9KQVFVMFU4VFVueDE3eXA4OUtqQThMcmc2?=
 =?utf-8?B?WlRQcWJHaFlrRjFSa2xuSklJUm54OUhUNWIycHpWcmdMdDRTclpmYm05ZWpZ?=
 =?utf-8?B?T2lIaEw2Nm5Ob0hjc1FqbVlNZXpIc2V3cjlaR2pNaWF2K3RnaWFxaFFFUkRn?=
 =?utf-8?B?eWZvZGw3MkhvMnJDWWJvek41a2w0akhDUG9mREVxSG04cDJVakpZcmY1bWFo?=
 =?utf-8?B?T1NvRE5wMCswNENWSXlNQ3p3SWw5cDAySGZHQ2c3VmZuZG93VC9RWHB6ZHhW?=
 =?utf-8?B?Q3VleGFtOVU4MUdacjdZRC9sMlZLMjlhWk45MmlGYXVDQ3pWUFJWNVZsTWJG?=
 =?utf-8?B?Z24vbVBFRU1uNkRSbkI2UFN2dWpLbjZHTzc2bGRlS0tySVJ2NE82ZGI1WGFY?=
 =?utf-8?B?cUpRUmJaajRYVVBJWU9vOUtGR2VFZzE5THZCZHdkMzJ3czhRR1h2VUx6d1Js?=
 =?utf-8?B?SXpmMGFqbzRDZjNCbERVTVZGVFFSWUh3QmEzQzN3eGdrN2hWbjZXQmMrMkhW?=
 =?utf-8?B?aktMNjAzcTFVN2swTmQrclIzYW9MVG56cnA5bGFhOEhObFpFRjlQYUthMEw0?=
 =?utf-8?B?ai84TkpwVmxzZGUxSFBOSE82RjNsVEttRWl1NVRjTm9kZW55U014eDU1Tm5X?=
 =?utf-8?B?b1I0Z3VSRzdLZUZrUWVjSGtmbDY0WDdRUUNTZEZaZFR1aEFVZSttaHB4OUJI?=
 =?utf-8?B?SXEvL3h5Mnpnc1h0QVRzUE54REJCb2Fjem9ZbW9Fb0NPbjZRZDVzY1FjazBJ?=
 =?utf-8?B?WnM5bkZSNDV2dG9Cb0owSTRaanF4M2FMYnB3Tmo4aUVEeS9iODNkcjBBN3FQ?=
 =?utf-8?B?UzdiVkVzSWYrRjdVaTQzNWIvL0hIVEo3cG5XdWpVRXp4TjVQeDdRS2wwdDNE?=
 =?utf-8?B?NW0zZ3ZJcWF5MVc5YlFVcWh3aWNkUFRVRG5JSzNtcFAzWW9SNkgyS1laMXE3?=
 =?utf-8?B?enBzRlF4OGJwNGg3RElIYXNkNldqd0pTbzZ5Z1JwR0g5TmxTMW02bEQrSjhW?=
 =?utf-8?B?eW53dGpiTUdXZWxkNEZYRG50YUROYTdSOWtSTlNkSUIrK3laMFFsOGlFekdY?=
 =?utf-8?B?U3Fud0FGWjk2TUdDd0lIbCttTzlMbUtDbTk0bU00amYwRHpyeGltUUNFdVdQ?=
 =?utf-8?B?MFIxaUVPWDZkcmhUaXhTRExKVlZsZU5VcjN1VGVVM1BoVmI2SUVFL1hEL3hv?=
 =?utf-8?B?TzRCaWE2aXJDVjc1S2xnWWZmYnpoZXFvcnF0RnhDYUVVUE5WL2VqVUN1T1JG?=
 =?utf-8?B?dVhvWXNLdmpzT0J5NTlSTjJSM0RYWDlBdkRHUzBPc090VmZiUFZCU2taTitO?=
 =?utf-8?B?eUJ0ZUhOUk1samNYdDJCV2loSk1JR0k3V2w1SVY0UldEaVljQVFLKzEzL25m?=
 =?utf-8?Q?5bZkp2ZWXb3UcgdRshmnxmfDm9+qU1fmFUZ/q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925cdd8d-b7bd-44c0-cf0b-08df313e32bd
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 19:45:32.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtA5YdVobeZxI/VRE3XnYzIdtJqs58kiLTYjSB9GirL2SpIcsnaLVoj/IlUtZ2aDCQ+oplX/C1S56XpScN0/N6mXJ7QCN8iuOJgi8tqB2ARfJYwyvafAV1DZ+PcUUTWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12639
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Add support for the Waiken WKS101WX001-WCT, an industrial-grade 10.1-inch
IPS TFT LCD panel with a capacitive touchscreen.

Although the module advertises LVDS support, enabling LVDS operation
requires hardware modification, including the removal of several on-board
resistors. As there are currently no known users of the LVDS configuration,
only the default interface mode is supported.

If LVDS support is needed in the future, a dedicated driver can be
introduced to handle switching between LVDS and DBI modes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- s/LDB/DPI
- variable use 101wx001_wct

change in v3
- add wct surfix and change to use MEDIA_BUS_FMT_RGB888_1X24
- Add information about lvds support plan.

change in v2
- update height to 135 from 136 (sashiko)
---
 drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d7dbd7442919b..5ef6a79f0de95 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5252,6 +5252,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode waiken_101wx001_wct_mode = {
+	.clock = 71100,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 70,
+	.hsync_end = 1280 + 70 + 10,
+	.htotal = 1280 + 70 + 10 + 80,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 3,
+	.vtotal = 800 + 10 + 3 + 10,
+	.width_mm = 217,
+	.height_mm = 135,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc waiken_101wx001_wct_panel = {
+	.modes = &waiken_101wx001_wct_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+};
+
 static const struct drm_display_mode waveshare_28_lcd_mode = {
 	.clock = 50000,
 	.hdisplay = 480,
@@ -6248,6 +6276,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
+	}, {
+		.compatible = "waiken,101wx001-wct",
+		.data = &waiken_101wx001_wct_panel,
 	}, {
 		.compatible = "waveshare,2.8inch-panel",
 		.data = &waveshare_28_lcd_panel

-- 
2.43.0

