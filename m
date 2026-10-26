Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0760A5BD3
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EiyUdIw7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5ED710ED9F;
	Mon, 26 Oct 2026 10:05:12 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E3D10ED91
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f103ESHB5674rfqObSx2Ra+5vhsy9a7G9M2zkBKtzX2XqbpLF1o3PoqjpqOPQC2UFGKOALkXoiKgXvfCCZXjCkJlMOvkZFY6lMgUs28Nt+TwRa/w1tFWECodH+yQJul5UgY3kUHJrffTsJNiEVs/yNjBIdrFFjlSJk1QDG1/QnTGC3E6hKXmjrOpVyudAPAR9LGkw7GDlzZDG6AKJld+tcvpPKTehymaq2GtmG8WaACG8pXGhK6BpMMPmMW5iWwbF7ULWxBFnU7ljKcwHV21Uor4fJ8zkJ9bofR680iVmB6EHnjjTDT7ieEOWen0VtHZ0WYoB4dTVTItm8F9skSr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thy+JEcuYCvau3raZT9C66yUHQRSG4HUVU1BtxFtetE=;
 b=ZUCUFMQBNieTma99E+4XxuZhRvXztbkiVd0MFvOnmGf94dYCAKAUuTomljZ4Jd2nKhKmVX5qL+Q2XqGAvxmAFOOBnZl/ITiA5rlu/bBAcWRBoJ0uW4iadQdQR4RNEGYsUe0AinfzuvxvqcG82YsxGEcck5MYWYVcWVJBe4J94ybXb0ZsflTKtciV9Xva9atZy1C+ow3ni1/KRqQko46Cv9r9G/+ucvPiZnvbDUPxaULm41oowHy036pimNcgutd++ofg5rKOo3e4gwmsAUmtZ3LNbD7Av8YYb78MzjZRuxjwfGgvEu1I8zRHS0K682HxdLZ+dfEmOj4/+EYCQ5Owjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thy+JEcuYCvau3raZT9C66yUHQRSG4HUVU1BtxFtetE=;
 b=EiyUdIw7vNYM32BJWeoVBcTuEFF2OKOQ+mdAZR/6Rl5symxtaMpekljuLqxJR/XkKcLl5AVlqo1PR7tISqPeCkDd2ilC7cSAhoq1N9niJ/HDNHUNTUzYjHrZNdvJWMbLIQuXW4TOHgV4zh8bGMkMLZxUhiJG7lfuZlCIiesiLTln2PM1ax9MUy2SDY5cDqr0/m5s0wq2JzSfdoKFEri0tr8g6Z7w7H0HssNOLkVxNwCzdKozGZ/1py2WqTmITxQXJnSVLYmB2jFX/EvGXuuFa58sSKrXPy6BWGW8kknhEhklgJSULG5rdEWEQVkNNScPmDxSqiGo4AIvQqx94/XL9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:48 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:48 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:17 +0800
Subject: [PATCH v7 12/15] drm/imx: dc-ed: Drop initial source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-12-a0b50cc4fc65@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: f58c2d29-d442-41df-e525-08df33489171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: djoeXSTQoYubCGUlNvvwRTy8+Clhqym67NwE2t7uhJ9JhswT65lTH3mQKrbnc/CxG1c3Z56DJZmDk3NtIiprn1BNp0QdUIJ3Lv9MpC2zFdE/VWHwjkk/+KMxHCF3zfUdX6cXbv5llXiQy/n4tE4irRkoCzGAa+90icHN2UkOJ3QSZ4zRw0fMNcYkFH6ewyc6A7WUZan0KHBYRYlwC64BcMUy3USaPv2VCqiuc7S9xD/CryS7C1AZtp5rY8Q9NQkC6F181LYf99FxsItqqh/9QX7sVBYEiY+8o0qMMdKmZl7zTlNU93oLsrZzvWezeTEvjIYOMUFcDxlEVsSiGO4luayYcdLV4vVWQDpbHBRUuKtC1u+E3/u+Vqu7kjCX9UVeyUBXcIDYgMvX/6/lK/Zyame5/Gz7SOB17xDl/eX2o47WZlYwOdYU8UxCElV947+5smjm3CIgfsQCyZJoM77fElYHhGySzVnLHVIoVcutQbK7AI17FCrf0kzksxqvjjnnfwASifhwnntO8cAVJRx2dGWYYLQ0QG5ilobvm/gXNztavCpZ4vr1VuENrrxkVhI4iQwqsuCljuHhJywQYA8QLYOcTHSzPcao6758xudYHqEpkPVuOw9tt9i1t5cPkJfxOeh6CrmscZ+lS6M0QeVnSMjeonbbjnUeEcBNBMKefZeuANjZEu/zOOg9gagOf0taVNKpWjV/NpXCsdZEfYkveQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVg3K3pHeUVsb1JGYlg5cXptRzhDUkkvRW5wdkxydnhWYU9ESHRacHpmeERW?=
 =?utf-8?B?M2dKdlc1QjhyRUdCT3JUZ1hXdm9wUThETUU1SlNhTVFBN2Vua2d3YjQ4d29x?=
 =?utf-8?B?N2NST1Y4eFFNZ0ZuZFBaZU9sTS9hV1YrRW4xUmlXMTZES1duMjhlMEZISGh5?=
 =?utf-8?B?M0o4L3R5VnM4TFpVV0VDQVF6UWd3d3dTN0VsTWN5bW1uTXNZbWRaOGpBQ0g1?=
 =?utf-8?B?emplZU82RlhqRExEZjhRSWl0bG93Nk5OeTFmUHNBTkk5aGo0U0d1eExnaU82?=
 =?utf-8?B?bWdxK2Y4TVByOWorNU5QVi9Hek1haU9TckNOS2o0SjFFVDJoUXBLZzNKYWo5?=
 =?utf-8?B?SU43V3c0RVU5R0NudkhEVlpkWGNlQ2RNTFB2cEo0V0ZHbmowMFhMS2FjN3c0?=
 =?utf-8?B?WHc1OHFxQkxtaXhLZWtOTDhia1doYXo2OENSRDEwbFJSWkR0NzRCdUZPeThI?=
 =?utf-8?B?c3hSMGpzUVVEQ05ZY2QrMkpUK3ZnOUszUjVlRXUzaXU1MkdyWTlXcjBML1Ur?=
 =?utf-8?B?WTMvSE1sUW5iZUdNVFNRSk9JYlZBSmIxYUdOVWFqUHR2RUd5TzUxZFZuVkdS?=
 =?utf-8?B?Q1g3MTRiMnQwT09uSE1IOTIyU3NKamNRSkxDU1haRzJsVWc1VU9VVkZUQ3dk?=
 =?utf-8?B?YTk2RTlicGRMbXBDTU5HNmlYbGdRbHcwN2VEcE1GVnpHampHODNMbFpXMlhK?=
 =?utf-8?B?dTh4R2IzQW9Fdy9mVThIZU5SYXNxSG1sbHNlRFdUUEhBQzJnT2FxWEFoWmNZ?=
 =?utf-8?B?dnR1S2xTWFR1NENUQ2hiL3FySjJQMkVlQy8zWUFWdHpCcXBtNjgxbDkyV3VO?=
 =?utf-8?B?bU1VbjFwRSswZXBWZVBFQVF1bUQ3N0RBKzIxbHI4N201RG42M0hQU0xybDBo?=
 =?utf-8?B?UjRramhrR3h3UkRDNUZZOGFWM2plMG9RUmZEODRXb0dTTXdNbW5IVktzZHYv?=
 =?utf-8?B?bmZFWUczeWk3VFF5eGUycnNXc3dicU5QVnYyRVdEWm9MT3MzZGtBdmNZTVdL?=
 =?utf-8?B?cStvSlhEb3Joa0V3Q1dlWGZveWFWZzUwZ00wcjZSQ2ltVjVJVzdNWDVDUys4?=
 =?utf-8?B?blBteHFhTllpZGxTZWhnTDFrVVNXcTY0REJwZ09sdWhpQUQyd1VtVWhES0Jz?=
 =?utf-8?B?SHdGUS9naHJOamw0TUkxOWN3aHYzQzZnV283VVJUT0pCbU5FeTRuaXVVQmdl?=
 =?utf-8?B?VDM0WGpIc0xlS3JaNFJpZEs2ZkwxN3hleTJNemZzSHIvWVA4aXRPRmpCM2V3?=
 =?utf-8?B?dlRZNU1Kbnp6UzdCZGdXcHA0bEVQMFprVUh5dVZLWkYyQXdWYnZpd2hkS0ZI?=
 =?utf-8?B?WGd1Q1NHRVNuRnRGU1FBcVRoUVBUZW1YKzJ5VnkzNms0WEJKTUhBRjFCVmtG?=
 =?utf-8?B?ZXlNSnM4TzJ4dDhUQkZ5VmNCcWpLYmVsSTdYV0xtMm52bWt0N3B5SW9oYkps?=
 =?utf-8?B?WHd3MHgrUXZQVzFqUmExazlIT1h0ZGNQZzEwNEF0eXB2UnFTRE51Ykp6N2dU?=
 =?utf-8?B?dlR3SGJqMzN1SU9ZY21TcWVoQ2ZNK1E5UnB1RFk3eGRGd3RLSUVVOHNONWtj?=
 =?utf-8?B?OWJZMlhxbDEzSEJtbksxV3g1bjBiWjAwZlVZWDFMUkdPS2pXdHlNUnZIUENo?=
 =?utf-8?B?Sk9URGZZam9IYU1HZ2g2dExqRWwrK1M1b3ozYzAzZGlqM0RTWU11a20rTWtI?=
 =?utf-8?B?anVMRkVaV1Q0UUpHRGMrZ1dwZndxUGVzdktVMTRGd1cwcmVSR3loc2Jlek5P?=
 =?utf-8?B?S2owNGdndVh1TjdCSHBzZVdMRVRLLzJwdkhrWlFWL3hpaXVqS2djZmNzR28z?=
 =?utf-8?B?NGpEeXR1ai8wYlZ5SjRVdGZldnVjcWJ0dXlWNTFMMDFuSW9qLzBXd1dRb3JZ?=
 =?utf-8?B?UVk0enBSaWVDUnZLUmdncWdScTYxMlcvcldHQzJvRXZRS0FHZmJZSkM4Q2tW?=
 =?utf-8?B?MVoyU3NQWXFPSm5RQ2E5dVRvRTNTSHN4ZCtSL0NLUjBmZm5xZk5XL3U1WVZt?=
 =?utf-8?B?c1dTMVJNWExOUlZoRUhFYjhwNThnWGFma2NNR2Vpam56dExaZWQrUmJ1MHRG?=
 =?utf-8?B?VXVhNS9jWUUySXdyM1oraldvS1h4Y0VmZW9ZQVhSUGR1dThJUUVoUTRKdUFa?=
 =?utf-8?B?TVZvTzRzSUFoMmw1OElHTEMzMnFVTjNBSjN1T09JZ29mR1FiQy93VnVhU2hS?=
 =?utf-8?B?bUxDTTVtb2hqanFPSHFhaEM3YTBvb3dZcUtEUkFTSU5rTVozUFNoeGQ5ZmNo?=
 =?utf-8?B?UWo2dnlxWTdyMUZwdnJ1QThXdHdDVlByR2Y3cm4xWkdaK1VIRWQza2p2R2pk?=
 =?utf-8?B?K3E5cGRnMUdSaXlpMTdoUktjMitzaHFRMFNuWkRnbW1vZXpwcjNFdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58c2d29-d442-41df-e525-08df33489171
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:48.1319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eZnS9JC6JzK1udwpxjJHzHY7PdryQHQh9u6CszRj90swTXDF3HxSG4xX2dP1A5QaxEQcuH2RCiNcGb8o42+VQ==
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

It's unnecessary to set initial ExtDst source selection because KMS
driver would do that when doing atomic commits.  Drop the selection.
This is needed as a preparation for reading ExtDst source selection
when trying to disable CRTC at boot in an upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Collect Maxime's A-b tag.

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index 67163dca1363..2f8d8c94e2d9 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -205,7 +205,6 @@ static inline void dc_ed_disable_gamma_apply(struct dc_ed *ed)
 
 void dc_ed_init(struct dc_ed *ed)
 {
-	dc_ed_pec_src_sel(ed, LINK_ID_NONE);
 	dc_ed_pec_enable_shden(ed);
 	dc_ed_pec_poweron(ed);
 	dc_ed_pec_sync_mode_single(ed);

-- 
2.43.0

