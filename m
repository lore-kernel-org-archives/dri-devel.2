Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F71C531D2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E1F10F111;
	Thu, 23 Jul 2026 13:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="nWGjC7Y9";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013043.outbound.protection.outlook.com [52.101.127.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C59710E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAh7/G9lYC4hHxJ1WnadF1L5GX+5YUhLJ6vZ/tIB6sa9t/LvWZ/cwcN50Xnpk+8GoUP4v/mYsaLUS5fJMrCu+PEnqbolCsWx6E89gDMN8dgqHR9p/WNlgXdkC1MWZwMv8Zm+tojQKzGRv6l52CmmQCq1RkkPqjInY7TpK7hUd6XYsXUJiiUIlgACd8hKzWICRnaFjJeDvzxpaXGxNRCHdbd9z0zeSWuadE3YbBt0JnYDa8fWokbv58vIj+4hQ4QDUdqTNtryvdMLetlNXjDiyhkDiGGgaiGJFft1iJR9WIF+/cJFlXvDI/XScXb70y5iK6c0K45yZjoS/oa3W2vbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrgQt4Lx/QGpmw0WIgxVp9sQJTJRYZMQerwwCyqYFT0=;
 b=BCQ/QqjYKXDiCO/KTsmmzWfL8PEUnWt5e2UjZ2jHGJCNlMXu6UNy332ebhUuBdEQWuZ+shPw357RzAASjltSQKfiNn8zCaS0vPRRH5OlQisgzayzgrufnIETPAPxvbOQDtRFxuFkzC8csVUnr/xvehDUpoZf/YM3KjvgleArCwqbdfZedN40ih/Neve9XNaS0GqekeeNp49vMIcPF3++N7ce803is5ZEKoELa3r/zHLuggDfAI/KwJSIOWgkm8Lvn54GzC1HrUlqXtoWsur9FlaSvOX0Fze3fYZIdVhR3e0OnuXSqNboKar8/+1LT3itS6zymgI8ejSiLo36Uu4KWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrgQt4Lx/QGpmw0WIgxVp9sQJTJRYZMQerwwCyqYFT0=;
 b=nWGjC7Y9IYYZCARnT9UBg2P+ElDn/iwHqgfDytehVNGSAtrB1Y9Xn1vjVlmovRDQWfNlU72Ysqr+tDngOjP3CtPKT4rgcfFKQ2YX6aK0FvAmatmrOVblw+P5mz9hvOxJlKTbZ0gf3JJjUh5QX4uZd9N3fnt2JzTrdiULK0wQC+NXNMeKGOUZmOyo/yJnIaiCBP0F1tNnoM52975D1ARN7uLB6g4mky2I9qCg6a4t0adijSp1cj4DTd01jA9sum1oclDcTM7NATf90+FdxenmiEpNK/BilbqxgAdMfryNuSWALn4irbLe8g/BuDuZs1A9oD9SKiPPvUaBIsWV0m/yJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:21 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:21 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 07/10] drm/bridge: it6505: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 21:16:39 +0800
Message-Id: <20260723131649.134127-8-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 16edb101-f635-4f20-4bbe-08dee8bcba64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g21BpjEzp51FY0DUYbn7WOX9Rjhb2G/4jLkULycmCZq1536HO82DkLRb7/zkZtv/ATCTlFdGd9z5bc7mqsrdODGCcH31BBb4+D8Sqnx2g0PjShTde7UFLYXuqwU+T+ol8wuedqnmysPFZpi5xkRS9RTUb4pV5dXoIG7u2rVG5PH6q8eQATQXoXwPI/yF91kEXMVFniRK7cYiy+AvW1enh612xo1WEn+sn0Pd66yvS/8437Lh1XANO4NJgzCjYmQfEH8XmF3wNlUlhw6b1+UljxqViBEvLThDPZJh0ySHEnrQhdgEQigoEcLoZ5xmMX/wF///wG3XOQLoxwkIEr+dtzWmrBXFO8+DS5ZueeiFBp/D8DkPoeWwixyFZ5YchmvSDd0sRL5L3MxsAz9IBh8JtNs4UcWPGgioARGioQLnWO4IaCMmx+e+M9f9ogWhqCuP9YOWGqhaY2Ddaq4Bry/edbb9Z7rrZ0375RP3TslIXeUCcfIzc5W848z2ejWQU7zSP7gezvyhwe3v9qHuNuU4Zi91G+HlPDi48L8v3jR4hlEg67ZXgmfwU57Ir2VPS/cJUyi5NF3jP649mjgPOzfjEFdNGlhbhu4MKkNezcW6x6v+Jf9ivyIH/GiFmoRt8YpugVnEYnQWdoElJ6IyAcT0d6Miw9rnhVFqqw8n5YrTIGCSkhGXbT0oqVEP+3zhaMQzTwRwBc/iJoJNFIauELN7MalcOxtgFn1okcaXcUpU2zOQqheYqO5ruytP2Vi7o1Oo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5o2r8UIaFEoR1SmfeICAm+WsUY4qKL6QKf1rJZWIe7e3Rkna6d/lRCkugIPw?=
 =?us-ascii?Q?/46R2qcnBTqdaGtuqFHp06sHGSa3UQl3OTSTMLGS2ZjD7TkVYQF432ktgKcy?=
 =?us-ascii?Q?DkXr+6rFZxa1JKFjMmpepyZQmUNtuU4FZ/hjhi6OcT5PEgP1CZflxPimGic7?=
 =?us-ascii?Q?zCqJ7+SPlO97lGsCVA7UgjFPDDY6oHu3rwMJCJ/vUsSIn4HQdotI4ZujNSV5?=
 =?us-ascii?Q?EGfIEtOHETGr1x2WkpP6eBHNE0wMwqScsN/Ti3GsKD78f3pCHFx50Yq0MBfW?=
 =?us-ascii?Q?eikN6l+SybMfnY9UXLanpr6ao781acZssocIPH9/TnG4U+RroVm0X9+tUL2S?=
 =?us-ascii?Q?vwJi9bVod3yC/A3znAl50bpJaXk3/jkGN/uHWJVp5OOxqSakW5badB48qbGH?=
 =?us-ascii?Q?r4kofzz4IpJR4MFk1DzLQJLoXYukbPWKWmQvdz1HovNFpamnQqHG0lLlgUKM?=
 =?us-ascii?Q?sRUFGfb8eund+9f4vfrggQdXQsvso6HUmBB/37i9wT8gZR8ynB6HMiTvP7Mm?=
 =?us-ascii?Q?nyuB2oZgarfL9X4m1xBXrtArHOz3vkaSzoBW/ev+wCAQx8KEAM/BW9hCI5yC?=
 =?us-ascii?Q?gziEfId7l+ys4isjZ5aTPwv6Cmzz8PQN4iRlt3WZizyposthz/ImfE5n9RNv?=
 =?us-ascii?Q?WkvjJFO+boVpKnpLnnZxeUxrWSY+NLN1I9ViMXKXcBbHeNYaSKP4Mtw/rFKi?=
 =?us-ascii?Q?zevK0RTMe8e7+++eFClLiv+4/roBlX/kyhqPFz1LVRpd2rz8Qx9TIeBd8YMJ?=
 =?us-ascii?Q?Om8YrrD6bzH4dSImqZyeMDM2gVFEjxvayk4QrNSifqmpnPdTgOnNmgD3lFKF?=
 =?us-ascii?Q?yL5mUi58sUtanzzVo4WqF1ACEnK9rDFTFqw9nDyl2nI7TQie5y2aZ81yFJm0?=
 =?us-ascii?Q?ocFRQpOPKZ2vC6oMYoyEH0BXSQfdIAuiS09b23VPFTexX+8+oOw2+wEhya8j?=
 =?us-ascii?Q?dBPo6pIPTrVuK+GF+/GS3CaRo6wvjCqYGpbA7VlyuWFGf2mACf/vwfQ2DYja?=
 =?us-ascii?Q?MgFQgcgrvtWZcJ01tgYtSudcHfxJ+AexuAggUxuRo7PmthyVRb5l93VEQbb+?=
 =?us-ascii?Q?L9JcPwDdspq6JdCJgPgV5SnN1FkT1H3dw4xruTd3Qum8DEamoUrCyp6ZEx0w?=
 =?us-ascii?Q?0AdqZG97C+B2bDS72afwIKWupnjIiM6p1++TITmA8ZEkZbH5wZQ7ugpNjG48?=
 =?us-ascii?Q?3hmNDkGhlQLT3EJ5nwfGwJIf8zaUReytfwQ3uaIBdvrmKbJ9z25RJqbWh2E0?=
 =?us-ascii?Q?FkRxbj4BgIHKYbLoaD2UJsUGTxawV/LnYj2TGpxHf6kd42NVpd7RQVAPhzq5?=
 =?us-ascii?Q?g3r7EiT855KtxKMcyKhHDbDI1hA22wPXuABRw851URo/7SHUoFA7mCXebXqh?=
 =?us-ascii?Q?v+ow+mI9pgx8fiEGJD3JAVf1CvIPxHkc/n2e5wRfyAHDPv8XiKiw9s6TYD9Z?=
 =?us-ascii?Q?ICzfkLLbVuQDluHrfTwr4luF2MJb9lDxMI2QbaMwNJYLuTGJ3MDgdILSZh4D?=
 =?us-ascii?Q?+5joHsWK4Wf5v33kIPBEbvp1qEzKVab/WPnDhgkJCkNBzKV4OX8Qz8no6W4q?=
 =?us-ascii?Q?mjj7nZwBnU5VCcKkI6iit5Eq/j8jJA2m0COwjdTqVSNHSMPxeIdLxrHEChiN?=
 =?us-ascii?Q?H3SBcvAnU0bUnHQN6DV+8M1OJCncdVL+VEUNpFsBHghvHvKaz3EIWKWap+YZ?=
 =?us-ascii?Q?gdwqu+DimZ8HD+/MqZCRofTFdhxul9V83hzX7fiRUILxC6KDHeNxBVQAUsb4?=
 =?us-ascii?Q?9P6HXfLJrg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16edb101-f635-4f20-4bbe-08dee8bcba64
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:21.3420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TxfhflGIIKt7O/Qwd11oxUKg89rmVkATmcA5Em7OZIOK0+KRsOwEwbpqNuIX/PqRIQ0mGCONKARpAG0a7wtRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8724
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:26:48 +0000
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

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8ecb43611dba..fe0f4ab16216 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3607,10 +3607,8 @@ static int it6505_i2c_probe(struct i2c_client *client)
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT |
 					IRQF_NO_AUTOEN,
 					"it6505-intp", it6505);
-	if (err) {
-		dev_err(dev, "Failed to request INTP threaded IRQ: %d", err);
+	if (err)
 		return err;
-	}
 
 	INIT_WORK(&it6505->link_works, it6505_link_training_work);
 	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
-- 
2.34.1

