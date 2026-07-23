Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A69C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732F410F10E;
	Thu, 23 Jul 2026 13:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="maqPH6IH";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012059.outbound.protection.outlook.com [52.101.126.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2DC10E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhrsbxofBn0c4jjrY0OKQt331mRBpj81D1llzbr/5scL7OB+5lNYbaVGcQb9R40l1yyGhLeNyC4GkYaNgFMm2dlL5wwenO5e4rbQzaaSPtBbKIODO471t9Loe4Y+VKEyAdNyAPKm3V83N/LtGu2scKcJw/d4iJdI7FxnP2vj4uCp8CWBhzlSKJHGQM5zi8+sYPjytBw//paazWfx+OlpGj386ooSiaky6nyR5Yq5fFJ2JR5AN6USegpG34p1GQwFwjpgIYW/6IWhCIWFDhO+Lq3Aw8+mcuhwmQkzcqyDpZi5q8SPCNsr0xfH4Yoodcz6IiCSvD6tRNGjPUhZHzTkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne5huL4iFawTvG2Rd22vnic5OV4bq0X03zfb+UPTKlE=;
 b=eaxMaymNybterJ2MFjmeyruGy/plmC8oaBfrtCfX4TnwuGNZpJ0JId8Bcu3uex0bPJtnW7l/EFgcS8juLvZzNGOae8lFWvkGtRq8XUek2sr3nFtY1KOyI/iGpaUqeenlDbcgWF+H3wmG3t/IkS4y7W4/5jQe4OVWuLar7DJ+WB7znEOSnri8L6U3RJgadSPMjoZ3e/DOp8Df8mpF48UQrzW8cfFF/slaNoGG9JhW19pvI6zwWpTg7BAMTEwC7Cg3ElSQB8hwqw0kMc7nI9vH9s5ZY0l6c9tbnC48u0qYrf0eQFyanJe9LxaBZb2Ik+GseyISGPRLYbnbKinnPzKhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne5huL4iFawTvG2Rd22vnic5OV4bq0X03zfb+UPTKlE=;
 b=maqPH6IH1upFee/jcmAFzwwnyUGUAbLyr1TtFj9XMh0eDtxfvLy99HapYQjkfrXeJqYT1DqV/rFldXP8iujkYwcgj7QRQRf6/PamAJr+65pgDvd6g0R9l91gXt9aoj2eKohzklM/iDFJa9Gbm9fv4GEifDDSZ+0NVScmXl2aPRVS6ot6oeKZYVtDALw0yWtIL+/1fNrIkoYtdqVP+UD+29CdaDC1FWT+8IpaxgKmWWln6OREpE74MoaUxe9dnmJU0A9iuklbGW6QerW+xaAZ53D022JNFy9o6gDFw7cFclPatzdsl3A8P5/Tl6vQ8Ov+jeSgnV8UjcAj6OcCZ9FIjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:11 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:11 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harikrishna Shenoy <h-shenoy@ti.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Kees Cook <kees@kernel.org>,
 Qi Xi <xiqi2@huawei.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 02/10] drm/bridge: cdns-mhdp8546: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 21:16:34 +0800
Message-Id: <20260723131649.134127-3-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 428c2c8d-0fe8-4d06-8bb4-08dee8bcb498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jgELKegO6Ywsd2zna3O8DHFak+vpA59VaGd023WVyMevzAZlBMBqlYHwvcyEouswcxBqc+zmH+UTBeQflXonYTt3KAhrj96Qok54AsLt5YFIIGaihd73HZCh92xRzB3XMwhAR2npH6COxAPdYNUZ9iVEq1VP2ODa3TJnTOYJ9wN38mVlQC4l2uxBzbatzsvpnDu02bcsR5YmsunLOTeb/l6OgrZAgH83ojfQ1aVjjBB9w49Y3xa91KNSc7xuBqWYA1H1RS444ZG3Gmrld0lLc3pLgsQj5GadLkxNM0AIqKi9Xj+kabJ9eVWQFKAbwtWNk1HvI4DRxq0BLMeWMsAYH5yct0DuQQBcfxh6t0UsuDf5rTfbmnaBln1+t9hqfu/90geC5sWhotMdjkd564pqx6NfqZ6bfJzks+XuVYPdIP5MqqAfd642B2slpyX5M+1ypMMtY6cSbRlhu2txeO4/W9OK1toC6++F3hrqt+8K0TN5hqRO+7uhzVeAzq4xMFAjG0StyQNhRag6c4rURtpInv4m+nAzGLvvRl7LNfAPXYeThasQdOCvb49+jsCmUrlXdkaSSlstO4UPNXKwC/hMT2qcrW726Xv7I3MR9Qv5fYrHvA6Sm8tYTiWDxn33MhgPpvfD2qqrmLrRXTNn79vjQY5BslRmD7GEYWYWEuQLJEMHJyqhWKTWJT4dsnm3pOP8/h24H8B3OgdrSJ9SlutFzXXnqUSb7FGTzZ/QFH2kA6a2qcKS+81Ng9oKsOuW8Zp/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FtzcJRfIKat6Mm1F/m0zB6ky58cpIAVbuLZOQKYj1g5qiC1wN4r3jRkq0bbO?=
 =?us-ascii?Q?WClBMwQ/YafECHxS5IqEQvK9eMqIDNs+sJZlRzZTE+LiHQ+3WJREMMpy6M9Y?=
 =?us-ascii?Q?U0gbGcSZ+jnudAQKxpguTsphfMSsTE2+o/u9vye/MWeDCqJfzI5hxMNLZ7jb?=
 =?us-ascii?Q?ShBWcJ0yyVZ0Qt8/twf6tV0GYsvtuo4NHFWDWUEJeT4QtvDsQ/8H0KI0T16k?=
 =?us-ascii?Q?VIFlLHclOLOj4Kw4lzcz49579h9l9L278lxR2O4S4lDML39Rzmy7woHWOHon?=
 =?us-ascii?Q?blBtWfxH7jIo/+/5lBaIobFoxViI/p3YUgGaHIAbCWXKrELX7XPG8fDMn3QO?=
 =?us-ascii?Q?DDrMyEzOBViY/spSBS5WS88BDg7AT6SM8ZYJ6Fp77gasG9yODIBP1wNFr7Ob?=
 =?us-ascii?Q?yFVhjEoqDptV6y95LaXJQBUmIdWrQVlqc7/8TXuzzIyRitWTX6X7k/iugrsG?=
 =?us-ascii?Q?yD9eLvcqSz8b/rqoi1PQml5XpxbHuB7tz13ZA5m/uCDPz4wTeVOfn77dF6yD?=
 =?us-ascii?Q?NWf5YfKa5RrL75UCKLUNbCWcgQ6h9wyAaAOnXy0OtpCyH3yL0CX9aqMnybD0?=
 =?us-ascii?Q?0MixvHMDEqhVJ//HSrLDGUr2NgHXG8EXcN1RBwbeqnrCQKNPlMW/SjXDRls0?=
 =?us-ascii?Q?hW1mrOr/fSJOQBlMYnTjjkup7T3pu1/Dpz2w/EsibhU7PpGbHWIOGP1UcxUW?=
 =?us-ascii?Q?rEj7WCZQFSwQUvDyEbML2NKAL57v0TNBVzTedqtQ7twVbJXA34qdmuIHIux8?=
 =?us-ascii?Q?9I2C0Zs9ErMNgr6vTKu5Wf1iIwYEia1TN9Y9y95LC0JT/l3Ymjf4Aq9+Raa3?=
 =?us-ascii?Q?6MzY9PgJAmB25zJP6E8lp4Y1x0AACNdmFzAkFm9LupQFGr7Yw8+0ZcgjX6sH?=
 =?us-ascii?Q?qbfmFuYIh3v5bW6d65TnJa8f+nvZRVcneE1+aoCkH7JTPGndLxnh2V7BDlUa?=
 =?us-ascii?Q?5qmouAmVX8J0dhA/4EJoge4hTmr5zum18Y29VpEH6b7V6Umjc0T+c0k2KYMe?=
 =?us-ascii?Q?mWXTAM1kc+kR3dvXz0ejcWmtPFVaUOPaRmyseAVD1F3W6MLUmyZWfPiYQRo8?=
 =?us-ascii?Q?i2LlvgK9gChn7MfdMU5RXDbqMam7lVDYZUvYjT9WSUakaC4xfG7r7DnzS1Cu?=
 =?us-ascii?Q?kQ8hsniQ7cPK3f6OMoYZrwv5yefF+naoeqBpvnDcOCIPmsB6mjnB+mBQaKPf?=
 =?us-ascii?Q?Cro4V+m1hxG7MdCf5TzLbSkioq3bGtBaM4cqcsOuHU+ntrsj1SsCj5vVPOnN?=
 =?us-ascii?Q?00dTQ/jdG8zvJlvmlYf/aeP9a/5W9bKSYDb4CZn4Ib8d7XLuJlhRT57394Bc?=
 =?us-ascii?Q?FitOX3vv4GC/yb+f9OAYlaxVnWRggEA9u9McyzJSIw03fR/kW5SPKAeJs4gB?=
 =?us-ascii?Q?7mwlaAfOTIJed1nQnBr/UtWYHLZtGZ+bOTpd0H/JGEPzYR5e0fbwMSlVWJyP?=
 =?us-ascii?Q?D1pXcDxKZJ6tGzZcz5k9B5ui+n6F+NRvUWUybL5jo80+3ZgCwGvjJGuC5ExM?=
 =?us-ascii?Q?0R6Xp25o1PK+yC0/4Kf8NAkPhjBK+5a/RKoFc60H0NmsrrQUX+3aJK5Qiz5h?=
 =?us-ascii?Q?Glpxmyl3JZW/Z/3lWrkqK2RSKicP4mCEmvMlKFoYXOLmlfWihW/4ReT4ZTFg?=
 =?us-ascii?Q?fX7PgZxVPTJSI8eIIbICOwP7yUKWdTjyYtkB8+IRoy5KoL6nEQQNwOLp+250?=
 =?us-ascii?Q?XRDmm6cgmVwkjuble5LuugOzSc3ZoR0cgtkiETAZHJbTNTqTa2wyzGnEYUpD?=
 =?us-ascii?Q?ymUfvm0WxQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428c2c8d-0fe8-4d06-8bb4-08dee8bcb498
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:11.6904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClqS6dQNURVKUm3dXK7dY4grQCb4I5qmG4MMJ20Y89y9YwGMuEEy42BzaSLbTRvHszr+mB/09Uu/Km2ykwZZlQ==
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
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 504a3186ebb3..f47717bd1079 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2343,7 +2343,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 					cdns_mhdp_irq_handler, IRQF_ONESHOT,
 					"mhdp8546", mhdp);
 	if (ret) {
-		dev_err(dev, "cannot install IRQ %d\n", irq);
 		ret = -EIO;
 		goto plat_fini;
 	}
-- 
2.34.1

