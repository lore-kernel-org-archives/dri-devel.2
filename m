Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73297606A339
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=fUoNGg3P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E961126E2;
	Fri, 30 Oct 2026 09:54:13 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D955C1126D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3h6fokoGlt7bdEXdGCMptzdq93HPrYnB7upN3I/32TLlxWlACoDfh0D9RrR0Iyb+MrABnlIDzVR7AeETlQATeuCN2DdIcGXJlFT/NQJOuF4iRc6jsC0R8bl65z9EMKhqD16Dn6J4V0G4gAnGgK9iBfuLLg4+7Opy74+zsyT7cRCXLunNYGQg6tKtXoNU/GvVqVXmtVtiEitO0CG1EqqNyO8z4sS9tiTcYqJg8xKdhNrEYlQjfHZpNkSwTIAmGQ4P0fNURutlvLbfQ+rIxNAEt4pgIG3uzp2ZcJS/zgaEHIN84AhvzD+3lQWlQT6mr1HayyKZwK5x3XFzPobPZoldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ht9nvrRP7MJmmvEf9IaM1WvMEL9gyNrapNdmCfL3Fk=;
 b=C5cfA9VjoNyBKKxk2448c5nnz6du5CwKyGYm75y5XApNUG7mOzCB5F2mFacmrNo4sgfjMw//bTqcqLyaGqkTFGBfxSTl/VrrSUPKHHUVwgrvGj/CKaGKfBqkj3txWPmi1M9gXK1KlA4wNxuR3zBf47kVmaEsDQgc/CodrtBLuqBwvGt32nL2lMTPgAqtKVe/SLfC7ndjmXYBmjMa8n2bXk3Ok6rf/m41N47IsZYWEg7UyyhdbACQ//xrmojvNMshGfjBYHNVJIZ/Y1p9XpJspiBLh+Cea0cBDsC19s+HCkapLx7TInhdv8gysZ1tyxUUrL4i5/xIoTl00Bouv1t1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ht9nvrRP7MJmmvEf9IaM1WvMEL9gyNrapNdmCfL3Fk=;
 b=fUoNGg3Ph4TVBw1fesY3u1+ml++5vP3OhJ2b6no2Br9c5H8Q1O9IAKBZLcUilkX5W9N9CPR4HO9cmOpMRZbj5E4ttujE7HsyCpaJ7rEHt0xCY7hk6XaM6JKTw487gJa/UNr4TCx5Qfq6JNESY/zi14SBlNXOVRaJAdk/gR8lGoWIxEbT4w/J41uBlHpdk1dNz2Ix1UmA7lsNDuDQbUTyeH4YgvNDYmd1ISl7ghSJ1vjHyulpxzhqrhuLy4/oxvLQ4pBgtNkBKIsOwLdu76ypK15LLClNjqiZV1EzJu8HJ72iKYGxGKp8YVi88br2CzUnyBTztlx2duywimFhYto3ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:54:02 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:54:02 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:35 +0800
Subject: [PATCH v8 11/15] drm/imx: dc-lb: Support getting secondary input
 selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-11-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e1db6a-39c4-4b7f-cfde-08df366bba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: I1SqUFXeebKLkwAjCV6AW6AkFpr5+jrs8T8Wc4rOwLZ8uEgY7HdJ6bnkDN89PvfCheIKdLbOmOdeHeGhxd4rVDsipHLA4w+I/6mOiUAAhms/ICzv9R/NAIdwuXdmZXuB97OtNikHYNT6O6fRHJl9RTj5jBLsur8G8mi4Qp54zrs/cvaAx7oHum3OC/dBtCweRGWQgtM/z0H46I9Y6OwaLL1ApUVSRacXs+w8D869JI8yZki06Njn91Fp8jgtHQJyY5qs+nETGNWPQmpMWb36cHNLvUvqDk8XgeAJdBRqqtOU6qtG5l3OsJolwJugTcZvQdjqXVD4bUc60nB4k8PrNW/9GTQi6/kCEzacCa1nig/zDwyH/8y+U4+wBrt1XDl4gyVJ2++b++95wG/Q8cZebFNWKTVpOGE9dwnjZxJCmyHCofRHvgg9EVFI7ejtcPQs/nxsl/HQi6OVlVcU9q3I9Ohyd9IMeKRYGc/hamNLSW+rcZFA9N/509qPFbZsrw0pjkWWUE4iNnUtB+Zr8IA9mxJvsoCWpU5fSWW4CVD6HLp2GZVS1oxOZdSFHXTSoS6caOm2dmoXvOyv2vfioshLeTGX13DAPS6aoa5H9MHs9usmTQVoEL6+A98y6HKsd97eS1D97WPK0u6CxjHSeFaA6UVESYh0JGWY1sY2PWFEF4vnoKbC4vkZNPMZkDVkk+gwyMnAJJ0vO208SkZ2z5gsMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJUSkJFVWo1MWhEQ3c3ZVMxY0NaZkpaYUZSQ3NEcnZkcjBzM1lnL0Q2V2Yw?=
 =?utf-8?B?ekx4TnhsUEo5R0JTeFR3MkFpVE0vYWJPMWxjcjhGNjhBZm0zSXB4TE96aTlB?=
 =?utf-8?B?OUZXYUp0SHhDQTdabklsc3Q0elNudEF5WHFYS2t6cFFMKytxYWhIMXc2UUVq?=
 =?utf-8?B?c2VKNStMUy9WcGlSWmpIWjcrbytsY1g5QnVudUFUYTdEelhRek05c21HZDcw?=
 =?utf-8?B?UFJjNE9mMUdmM0J0R1hyL2plM3VZNjJJS2NPaWdobmlyVTJZblJ4WXhTVUV1?=
 =?utf-8?B?aFcrTFFOT3RjWlhlSU83NDNCZ3hqK1o0OVRjbkN0YVRqNERDcWovZGlrS1lt?=
 =?utf-8?B?NGswd1FUeEJyUENoUCt3TmtkK1M1UkF6TWZva2NGQytDN2R0UVg5QkdQdDhJ?=
 =?utf-8?B?Tzd4MjRIYzBGMzN5TXVtMU03UnAwckNCczlscXhxSHBNS2I1ZWhBU0R0Njlq?=
 =?utf-8?B?Rkl0L3NxK1dZRGFxbU1lL1J0NzFGcDMxTk5TeFZ1TkJuZVlNNDk0OEdHZzc4?=
 =?utf-8?B?MDJFdTY5R1ROQkFReS9ybHJVNTR1OWVwNk9lbWdxWmhGY3k2cG41Tm5TNzlK?=
 =?utf-8?B?djczTU5QY3QzcnZMY2JpMGp1aVAzMWppMkxkOWpLdWw3UDNIOGh4ZXFId0Rm?=
 =?utf-8?B?bmlBTjg3Y2ZMcUI0RmNCOXN5Q3ErdHRQRW9meklpT01NWVRDN2Y1Yzc5TlNH?=
 =?utf-8?B?S3FOT0g5SEhJbzRyT0xOYVIxT1Z0anh6cTk3YS9BVlNCKytTNVZ6Qno1LzJE?=
 =?utf-8?B?K3ppLzAyS0poeHlHNFhFc2wzQzlrZ203RFN5eVJSOUM0RFRRemhIcXdWZW95?=
 =?utf-8?B?cUVESS91TE1jS2M2dDI2UXcrYVZrK0lnWVlETTlIOWVYR2k1T2cvUkpOeTNr?=
 =?utf-8?B?Ni9NNTJOellVTUNQV1BDY2lTY0x0M0krSWtHSUVQUkpXQXliT1drTFgvbWgz?=
 =?utf-8?B?SVZNSWFEUFBVZWF3QjdCSFY2ekRxS3RBemI4ZGtLM2p2dHdWTVQvV2Q4QXhp?=
 =?utf-8?B?UVVzNEZJZ3Q3U1VOdndqVzBqQzJvODNxZHN1RjVZT3gzVXQ3UFF4aWQwME1Z?=
 =?utf-8?B?QTltOERacGV4clI1aG9KTVA1eGdNOWIraFBabGptVmhxOG1KU2FYNUhKM0lS?=
 =?utf-8?B?R3NuY0NyUG4yN0RpVThGQURxbDBWaXpVMGxTY2xIaDBsTnBXM0NYSmZMTW11?=
 =?utf-8?B?bVRHbjNqeXZSNC9iVTdkRGZxa01qS0RBVE54dS95MjlUc1NZRjBXYWEwNy9M?=
 =?utf-8?B?TlpMOThQbHEwR1lVRmdpWEJCRzhVTVN0Y2RmdnRNK09UNGZwWVh5L3JXMWZZ?=
 =?utf-8?B?RkZoenBZK0w2S1FORVh1MXNOUjRESGFrcWIrMnUyclBxcGh4eER5UDFpVGVq?=
 =?utf-8?B?MkxPMEMrakUwOGxTMXZhbFh3YVVXQW40WFpRNWtDeHRjMWtLZ2hiN2w3NCsv?=
 =?utf-8?B?d0JxeTljZzJEaUI1VU96dTdycm1NSllPaHhBNE9aNVBMSVkxUzlDb0k1V2lr?=
 =?utf-8?B?R2NSRFAxeExSbEoxa0d6ZlE4dTNRU1JMd3JTajFIcDR6OGVkM2c4Tmo0eWV3?=
 =?utf-8?B?VVcvL1BkdS9FT29kOVhONzlGR1hYRndTdE5nd1hDaG5paWMxbTdQSVY5a1VH?=
 =?utf-8?B?VFhlMlJ3UmpPd0lkbU1PalNJTWpsTFZCdWI3VFpHaGxSckZhTU5nWUpRRXJW?=
 =?utf-8?B?N3g2NHQxdVNCOGliejUzMVZRRFdPZ3psMEFtczNlY3RraXBreEFHSW1POEY1?=
 =?utf-8?B?U0xUVGR4dW1Tb3drRnVXYUZUQzdRYnBLS2xJSWlsaDdGWmdBMXkzLzZTRDg0?=
 =?utf-8?B?dFJvckFHSUpJSGN0WThhUFpON3QyWW93NjhYQmlXODZQMzJLRmptTEp3UTli?=
 =?utf-8?B?VXh2V0FjQm1uTkljOUUyVmxIWVQwcnNVK1ljd2l0MWQ2cjlQcWlxTG81NGJS?=
 =?utf-8?B?MnVlQkNGNGJ2ZDVpOUFVcTNxaEJJbVh2SmorMHNOc2EvMzFONmpqdzd3ZXVz?=
 =?utf-8?B?ODJxN0lTTTFxL1hURlpPOTh2VWU3YXl3TGRibmwxaGhXU2ttM2Zla05CazQv?=
 =?utf-8?B?RGxndUlQMTR5OTUxR1V6Qkc0TnRJWUs0SnR4emx3LzZxT0dVNWUvMy9hRkFW?=
 =?utf-8?B?Q2JaT3FSSHByTlZpRXBFci9wTzhwUnJIUDFQNENEbTRLaUdDOFpBekdlZy9i?=
 =?utf-8?B?QUx5Z3VKSHVMTDJVVkJFY0ZaUnZFcm54Q2RnK1J3MnZMcnBkT1FBTzRMdk9x?=
 =?utf-8?B?U21EVDJKMlNvazA2b09Oc1RQYlVzWFhrUWNza1l1QU1BbkFuMkRkTUxIMEVP?=
 =?utf-8?B?NTV0b280ZFlBbEtjY2wvWHgxaks4ZVAvNGs2TitaYUpCYmNXRmNqUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e1db6a-39c4-4b7f-cfde-08df366bba5f
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:54:02.6859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JIhYAvlQ/+Otv4J9qN1VW65JSUoyjNfUqhWMjxMGhXF0A9oGe0pAq96sklUAqJecSoJP7WMLqPVvshX8swlEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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
---
v8:
- Fix dc_lb_pec_dynamic_sec_sel_get()'s return value when regmap_read() fails.
- Iterate over sec_sels[] to find the secondary input selection.

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
index cb614f3c2f69..924a0de4b909 100644
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
+	int i;
+
+	ret = regmap_read(lb->reg_pec, PIXENGCFG_DYNAMIC, &val);
+	if (ret)
+		return ret;
+
+	val = PIXENGCFG_DYNAMIC_SEC_SEL_GET(val);
+
+	for (i = 0; i < ARRAY_SIZE(sec_sels); i++) {
+		if (sec_sels[i] == val) {
+			dev_dbg(lb->dev, "get secondary input selection: 0x%02x\n", val);
+			*sec = val;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
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

