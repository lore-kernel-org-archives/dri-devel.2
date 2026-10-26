Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E660A380D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cCiHauIS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6410ED92;
	Mon, 26 Oct 2026 10:04:48 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97ADA10ED8A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ukz10TkBz3EBYrjcHhAr6ktuaKg7J4LbRK9meiPRunLVCW9una6aun6QHmX/pY+L+0q7z3vlIlc7LeP4S0GhbFI5QV0m0YiIAomJVy92GSMo7NOc6lQXyBKCTHTep1jkGRsLLzsKq7mi4YiDvUk6h3EcYF25hUzWxSwXGNAdvvnZB4shEITU1eQ87Z136rdPq8Gu4VIV3oZpEv7idllQASv20XL/p8eXcB2jDps9Bjec+ppS3JNjacpTk7iX+Ni5alQ2hgnnOeZeEEd/Hj/JV0B6wKFmLJG0QqY8LsglxeC0JUrzl88ynMk2mjHTnwcvQbBAZd+G7o27tjEL9gJatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMH3zU+XDv3vEsb0lLv1QK6i2SRkrAOMfTZrTVi0+J8=;
 b=EMyo8zRGHErN7h1tWS4RDeNwBmAEpUctTzptGe2m4WYmUfQaiLkIAgLBhnEn3EEEbTuPG6PhM99szsjzRwecJ/4yQHiRKJLF2BtuGTTFYv1T2td9O21EkP1lH8hN10nEvnait8uSSoPM7Xr7mRUu5boowocLZNoFQantBZ1p1//VgtmpTcGItEDlZOvsit+K46ecmgvSNB+RNRlNUYVq165SZbLCpgIKQsvs55JGwOyw6c44rHIcADRRQ6+8LXj84+hLzmdZaPF3rR1L2hEfeyXG2qErcF/bS8FyhTceahqeLC4XTng4nKfvpzq7R+oVmD601O6U465VecVQWetoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMH3zU+XDv3vEsb0lLv1QK6i2SRkrAOMfTZrTVi0+J8=;
 b=cCiHauISagGAMp9GuozlcoFJnh5r1sPoImbU4Z1ov4PPzOsXw4//y5R2ZGLQ6w2jlsbDqxI54VuK/vM9QRbaR1bIQh7b7mThW6/0qFkzybQZmaHwLLh6gGklVJPt1pDoyjy63N0jVqp6s5h8QR8gPQ6ebBlhW0iK0Q7ClWfX/f1AR1bBwTS0uaul5uFMBXVy+rjStPCgkFudl+xVA3tOBEMONRWajOQKpAXXVnfN3ylUL+APLSqFZmwwFOiiVytpKk4Oe4upz6uFZlDpW9Yye+QlOC09Rv5EwwpIdlJTTM81iGxVMxaDc7AvO7B1xyKPY1rJVd5kZYnN44cp4LvQ2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:33 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:33 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:15 +0800
Subject: [PATCH v7 10/15] drm/imx: dc-ed: Support getting source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-10-a0b50cc4fc65@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GV1PR04MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da50516-9ff0-41b5-fd80-08df334888d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|921020|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: eWF6nlDncXQIQu5kvcQwaDqZ49G4Sa2SfDMh+J1SUulP4wI3zihjBBJI7LGs6uzIkOC2sAM80Cb/p1aAcjq0XzFSSAuiMZKLLRdLp9sipjOzUedRZO+fdtuxhnaTcCTIWByMtvIFIj6I4dL9mvKPQiuUir5l4YDfydLJgs/PrT/j5Am9bBEE8zAFz98/xBrxo/pFlcEdXngC/WjQwU+ANkilsTOQ/q65kvS4FLVKIQ6Tdb4ex4cs46rOaZM10E/DnMCqMPyb+mrCwMZGIF1ZZkE3hEgtO/pLjr7tdrhbAD4OUA2hj+LOIjjt75yHly3lUNkvXjHwXstFR36uCxVnKdMGSHg6JisptOqn/eAYmcqrO6Ijv152W3pWkNQBGR6yhJ4FQtUiz6mwvExJdBYci5A523byO09BroP+kNQMB9lQswDmBOS4YzrDpyx4QZpSrvUrfNusYqHpfiYp0fPul63XSmMDly9q2TBOo8aqUL6nBgZWYUPI+HD68kZvfK09noq32l0O0JyDssgucUZHVrt/dNqKl/7LglMhGJROMyyAXOnPyJK/gh44pA+WhuKWFby4wyZ1TiJNz6aOYwETp3gAy5nTdQuutNllUYs8KIhJcWLgQ17AF40M2iDgv9dCJE96gHCGLei7Zam1xhHlF4GIOX4A6E4fzRh93gmll+rRjspHvFsW344KKKaebnupHcMDhL5RApFjOMIR6Aziww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmQ0SStLRHVwUkxSV2dNVnludnp0TWdKdHg3OEJnOTV5clR1SWJ1WHdUZnVl?=
 =?utf-8?B?OVBReGZWTEllQkdwVDgzTTA3YUJ0QUJPcHB1STlmc3ZKOGtNK2FJSjEyRkhU?=
 =?utf-8?B?ZzJmRzZJZCtQb24xVExINGtPSWVNME5xMnBvbWtEU3N5azV1WnpCMVR3NEtW?=
 =?utf-8?B?S2Zma2dsMEc0QnpFNDhGb1l4UlJQVVFsWnYwczkyNmV6QnNhZnZrZHB5cUdw?=
 =?utf-8?B?Ymw3THl4WnZXeDBrU3MrWFBXelo2dURmUHBoL0pzWFhHLzNqZjk0ZzFNd2Fx?=
 =?utf-8?B?L3UyUEh4VHo2VXdYSi9BWTFDUVo1azFBUXJJaVBjdXpqdUNKTGtXc1BmbnA1?=
 =?utf-8?B?RWdkVTVzY0VJUUpmYnA3SXdPRjlTaGY2MHVNaDF3dVJMMWFjeWRxVVc5S0No?=
 =?utf-8?B?MHRLcDU4ZmNwdjNRclF2ZS8yTEZpWDhCQ2hrSzRxMElHY3ljc2h4YjY0RkN2?=
 =?utf-8?B?aDgyRGZOMS82Q0w1eEZ1YVFOTGpWUGxlV1FBVzBVa3BxcWx5WTVXSHZCdXN3?=
 =?utf-8?B?Zm0yQTl4aENHMmNBZWd6UjR3SW10bUM1QXloNVE0eHpDa0dNcFpZRkhBZlZr?=
 =?utf-8?B?cWNLTWpIVmJ5UGZEbmM2NFNwOGdJQVVYNnRIMDNwK2xFbTZ2bHY0eG1pSTZF?=
 =?utf-8?B?UVZaTWFoc3JrWFZSM0dGQ0tRVFBhVnFWc0h6eXRTK1NwVFI0QW9qWG1kVHd0?=
 =?utf-8?B?YVl3ajV1WkdhTGliRDViaW1ZSkxraCtOU2Fvd1dycFlQSG96Ymlxb05lY1NI?=
 =?utf-8?B?NWcvNzhQMG92anRhZVFQVTYwT0x1a2ZvbzFmSWh0Y29rSDZvUUN4VGxYVC9S?=
 =?utf-8?B?Y0kwRDJrRDRITHZsd2gvVVFmdGt2N040MWRlWFNRdjVVWE81QnVtZVdrRkNT?=
 =?utf-8?B?bHgyaURGV1NCTmpCYTF2QlN3SzBhcU1rV25UaE5KcXJueE1pVFRlOFFGNWtq?=
 =?utf-8?B?Q0hYOERmSk53WmFaUmNSNTJGRWsxeEpXbFgzOURWcWJCd0xSeXErbnhMbW5s?=
 =?utf-8?B?Q0FaMHMvNXdZV3dJSGpVNCsxME16dlBTbDh6eS9RL0JEOXk2N2IvQ0JtNEVY?=
 =?utf-8?B?cUprMHR4bFpjMVgzTmVyZHR4eW53ZTJIVUtMbXdIbnVmYy9ucERObTJPZWc5?=
 =?utf-8?B?dC9iQ3psZ1VMenZDQkFwbEZYNUwzQW53MlJJZzMyNkFFdUtzSXQraW14U1l4?=
 =?utf-8?B?UW12MjZCdU5tcHVoRVYzL1dxT29GOCtGaGtDeDhyVzU2bmlmV2pzcndXZUor?=
 =?utf-8?B?NWZZSjFhUG5Dd0VzejJoaERVZVNTOFJpZmR0RVg1RGJUQXhiWks5Tk5zYjh3?=
 =?utf-8?B?WW5kQ0RBNWpsSGNxWStwcFYvVWtCemJTak1kdG5RS3ZzNndpTEs5SkNFd2hs?=
 =?utf-8?B?ZldkWDVWSDJFOUhlVW13dnFvaTI5MzhHWThicTIzdnQ3Q1Rnb3BmYmd0cDJo?=
 =?utf-8?B?Nk1ENmo3UnIza3JSUlc1Z0QzWUsxVHpLZFBsL0dJVVpoWTA0dlJWcmpLVHF6?=
 =?utf-8?B?aXphSUJ4dEdicHUxSXMzNys2dnoxc0pWcVZWTEtWRWdEWEk2d3dLZHFPZXdK?=
 =?utf-8?B?NFdJVHRpbFRYWHZ0bzZSK0lVNWRWRWE0WEZ1Ulg4QXBmdlcxWG1KN2Z6MEFI?=
 =?utf-8?B?UzVyUVkrWXZFWmY1cjYwRDZXb2FGN1gyaDN5NmpUODVEc0liUWVRbW9tekNJ?=
 =?utf-8?B?Rk5YcnBjZUpCSHZSellqTUdxOURXZDRTbVVJVDlEMytsNXl6N1JqbkRta1cz?=
 =?utf-8?B?Z0s1QVFsbUoxUnd0V2ZGSGxtRVJnYXBnaWFVOVFsWGlMQ015K3NtalVwWXV2?=
 =?utf-8?B?SndHODh4RkpuMG1DUHZNWGEycEYva1h5OGkydmYvQjk2WElVR3ROdkFkVlVj?=
 =?utf-8?B?REJwVHVhaWRSTHBIcXNuRW5mNGdFTlBkY016NFJDeFgyQzYybjNPelAwSFUv?=
 =?utf-8?B?bWxhR0ZqQ3VPMmNXdGFzSmxLUmpOL0twb3lhRlZjT3ByQkw5V1pZdXlmNjFH?=
 =?utf-8?B?cm1SN0R0YkthdzZ3SE1RQ2lyeXBsSVl5YTU5Q0dnNVhBZ2VYTit3ZWtzTFRo?=
 =?utf-8?B?bFlORGoydW94aHVOdkdLMXRWWVhVWXQzRU9mNC9yM2d1eE5RMHFwTHFkS0Vs?=
 =?utf-8?B?c1EyTFlIQlo2MlRmNEtMQVdBK2J3cjc5Yno0bnBSZzlOZm9yaVJndmVxVUVY?=
 =?utf-8?B?Zjcya2twL3gyaVY5SmZQS0J0OW5Qd0s0OVFKY2tuUDQrSjkraFVjSHhzQ2xw?=
 =?utf-8?B?N3hDbDFrZ2cramQxcG00NHA2aktQWFJDRjh6dUZPZyszbjcyRWJLZk80NEEx?=
 =?utf-8?B?TWk1dDVPdWgvd1BnSUZOc2xPbkorYXVVVnJIYkhJVHhCT3QwR0g1UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da50516-9ff0-41b5-fd80-08df334888d2
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:33.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOK1JG3iTbn6+HQNm/agXcgOC6PNSLjKU2ivyO5xEjGX/kamEIerCteJ6QPodXSbHO2iFIZKlu8VT35OyqHiCA==
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

Add a helper to get ExtDst source selection.  This is needed by
disabling CRTC at boot in an upcoming commit which tries to get
the source selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Collect Maxime's A-b tag.
- Check regmap_read()'s return valure.  (Sashiko AI bot)

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index de1b71315eab..67163dca1363 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -149,6 +149,35 @@ void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src)
 	}
 }
 
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(ed->reg_pec, PIXENGCFG_DYNAMIC, &val);
+	if (ret)
+		return -EINVAL;
+
+	switch (val) {
+	case LINK_ID_NONE:
+	case LINK_ID_CONSTFRAME0:
+	case LINK_ID_CONSTFRAME4:
+	case LINK_ID_CONSTFRAME1:
+	case LINK_ID_CONSTFRAME5:
+	case LINK_ID_FETCHWARP2:
+	case LINK_ID_FETCHLAYER0:
+	case LINK_ID_LAYERBLEND0:
+	case LINK_ID_LAYERBLEND1:
+	case LINK_ID_LAYERBLEND2:
+	case LINK_ID_LAYERBLEND3:
+		*src = val;
+		dev_dbg(ed->dev, "get source selection: 0x%02x\n", val);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 void dc_ed_pec_sync_trigger(struct dc_ed *ed)
 {
 	regmap_write(ed->reg_pec, PIXENGCFG_TRIGGER, SYNC_TRIGGER);
diff --git a/drivers/gpu/drm/imx/dc/dc-pe.h b/drivers/gpu/drm/imx/dc/dc-pe.h
index f5e01a6eb9e9..0b81dc6b251c 100644
--- a/drivers/gpu/drm/imx/dc/dc-pe.h
+++ b/drivers/gpu/drm/imx/dc/dc-pe.h
@@ -85,6 +85,7 @@ void dc_cf_init(struct dc_cf *cf);
 
 /* External Destination Unit */
 void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src);
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src);
 void dc_ed_pec_sync_trigger(struct dc_ed *ed);
 void dc_ed_init(struct dc_ed *ed);
 

-- 
2.43.0

