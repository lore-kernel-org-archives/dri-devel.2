Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2A4C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E38010F11D;
	Thu, 23 Jul 2026 13:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="gR80P1TZ";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012059.outbound.protection.outlook.com [52.101.126.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B2210E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIIRww9aO4jrQWZBxTDOgH6ajoToyiHPHyQOydJO4Px/n4Lny06qFbt8Ua1v0oLFtOEkx+OS2+CJuE10p02/8kfKl5Wotnkh0/p/hvD1ZOzyJUg3pSYslWfBTqVH8zuyCS6k2cTW+iIuBhM7mb6PCXGAl250dB+wGM9CARi428+ItyfXrkPr0wEGIZRyS4QEVc43NgJMPlIHgnX2k+dsxs82/LaYEPJ0IcSy6yQRLAI1myM7LGx194xAO6ZgMssRMbfT8+8WLIqxl3p6/kdOHvUfbeC5g8syI34o59OwJKc/flRCS6NRe61iJppSetZ9VabNjQqhuQT9B5pV0952Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KGasz4LcRBN+tUll2BOGEchPxNOXam5P3D37gIsyz4=;
 b=qI3KYQRJ7OodiG+acEnN9IT8lCr799zvDbu3n5+QBfIqduRGXVL3Qh7FFXPTH4HEd2ghNAdcFq7W8fqtlbhXYrY1duD8N/IJwxBrpAuN8wuDZLTaorxIrfB8/dqfVz0UIfG0WIX3UBQw/7IDzV/h0xq+YGA/gEn5zinBaoWCM+bZ/0PVYTt3UFGNOzx+BepGxwpPUVeM3ayWctHVYZmPbzOhATdihpSgnpTywaCbf8un18QzWH6GlsxGBTHjmA0qimN6Hmd2D76F+chQMexIuWNea87gq2egSrcAe6lLPqEU2t2JUl5fdEh8KuTmAEiOmrgECAnE89hGhLpvPWqiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KGasz4LcRBN+tUll2BOGEchPxNOXam5P3D37gIsyz4=;
 b=gR80P1TZoyMbGzGXv4tl0IWgxGklbMP1buNhj6VYu/+YY426iwKsUNZYc9QIiOqDZHNb+xjjvdP0bfd9wwz1/H9iLpoIjEjaDNyQU9rlboIPyq9RWDWC0hAtc1Oy1d8goa7cvrKqXVBV7gT3aY2b/YCp8tM/RHBuKevE325DEGYfW+BLzYLHkR1eZwcW8YR1OBHqeFEvjG6UN2zq70Wb/VG4vZmjnSTiySoe/75LX+es8rKlBiv460uAsjfI8nhPXV7vZHYglCG3SkkV8EaogATAEgIln6pd65qRzs9NwMwhk1SStaMMm0oTPdc873rHFpwf5oZDqzXXNmQfHiwIYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:13 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:13 +0000
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
Subject: [PATCH 03/10] drm/bridge: lt9611: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 21:16:35 +0800
Message-Id: <20260723131649.134127-4-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5b71fa3-5dd7-4240-1816-08dee8bcb5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tZE3mNj2omp+dklTF16OGcxswdEiK3jaQ0n2gOnMryuxjTO5Md1VIW7Zak6UGu91ouCcb6Y55TMX+/qwMJZsuyiczOSFpRn8iBKUhMo+OkeRUxiDHJiu9irQwMe3aXTDFoLLUzm26nDBIkNewSN5dhxvxST9OtIOhjnAfS3YLV0IbLHAvVEf4FymnSAvQa33aHlmzTbO8ONWsmRMR0QIKK0oN/PFX7ZhqgTypwAXbQ8O76dSH2yWdrVrKK4m0gNp443G+PUBskvNTAiksJdq7760m1whlEXb+9smFOuiXXVK3TnuXa+QrWIhETovwxhvUqZvVDFcw9XMjmBZqbCJLZfq27VX8Owffl6LnfvUhLC4JQekDq4QqPqsXo0dRAQE8fuvW6xVvzhX4lKLOC2PxY13xLMfiulLva6t4VaiXeGWp+ejSC8iuN+GKz78VM64/R0mBZVthPhDzqUqPLMyLnuhwWvePZaPbwOPH6qrASkBUnxWh7XbI73Sn8BeVYF898syAeWle7U3TXiENRsIvHd42T0Z3OgGL/AMdHPs959UYxX9nV6t0EK4mJTpR7QrAd6XVjUKrS5yKkocUkDnbBlcpfIz7g0zKBM5TUbriZQTomz0GxfKv9fkClfttsqCX1qWWobpIhtqNK8BpLmSeJFZMD5yP2hFcZNcjwbTcbNSwGBiDpNfTC5WfhffCt8kiaL4meG0cCImvLFwgk468FiS8GiIv6Qxs/3n/ExsfYSdBN/eBhHY7Wt5SFxVLr9X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYK2M+lEfhJAAtplKOAoGP9plr2OaIF5Nc/cWUa5oCEiXwIdF74GqEB+PwLj?=
 =?us-ascii?Q?DtL2AUCrUPnkast2LaRj63rsyfc/ke5qlgPLP/c2X7vMCXJj6nFOv+czyESg?=
 =?us-ascii?Q?yPZe91OrFpQN7hIcbxBnPjn/vtm6Kn4bVKLJJdY2DsXDd8qCftPRJdiDeq/e?=
 =?us-ascii?Q?xc39DudK0MgHWIaeas2n+SUOkWK8mliK8ggZO52pGsAnreZNeme1WPOxmWaM?=
 =?us-ascii?Q?cAT7Ll5/ORZaGzCZhdNQaqr+ywvCCNz7/lNhdWUrkR1JblLpGffE4jAzMvNM?=
 =?us-ascii?Q?w1xGykMdhlgBRXR+HaxQVQZYLbEeM3wv4F6w+faL77E7Wiwrj1iQ6LhkzXjG?=
 =?us-ascii?Q?Uf0BrmXUr7uxfbloXiOeX/39IV+9eSpRZ7Kwgu5InaM8LyiRh100mrdI3a/g?=
 =?us-ascii?Q?NiqoB1HcNRZKyo9Q1w8GudicqlnOrwiR7H7JMpmWdro6NDNaKy/bKYwcNkrQ?=
 =?us-ascii?Q?7uqW9m1dY3ny49T7cZXe+8ZLbxuRfYpPAEZW+ZRG5v7+55vfFokYlnQFyV1e?=
 =?us-ascii?Q?J8CRGIU3vbiYVgrKOjgHQ9ddcK8iGjDZyv5+4lPVOnqmyLKXmBF6RxaLSXO5?=
 =?us-ascii?Q?JVqFhF1Pu4XXtBsv1WnPK6+IWXhywy7mtlzHTbb0vDIGvGxafeBvOiBEfL4M?=
 =?us-ascii?Q?7t7Hl1+rH6mC5s0P1KT3ES6tOb8y8YXSXsYl8RRLlXkf+k5C4F2Jr2yU/D3B?=
 =?us-ascii?Q?D25Ud/j5NXd3b7lg6eEiqKiH+yRcycFeJQGVg1fj7ugo2uLpYYRUbC9uoeNg?=
 =?us-ascii?Q?BTejd60B3HVV61WxcPvMdniZ5gSck555ZpPmy+uf2Pv0dOFY1wZ+8uH+2fC9?=
 =?us-ascii?Q?PM6Ey/EBUcRepToIS2O4IY++ViD2dF+2iOHnSJmsa+qOzG7eGwdHb2JoRU0M?=
 =?us-ascii?Q?KgsNoFdcET/hFPGrb4Kips4B8fcdDAZNYewFC7Pf8Yk1LG+N2OOULG9BFaF3?=
 =?us-ascii?Q?nV0ZQhXCwZ242kSe328PC4KviNmq33gkOC5F2rpOMJWRfrtMWCi/VJn+Vc61?=
 =?us-ascii?Q?1yvoBy8XvektkcuU6TKBhODHdC7mkxye7zvrkw19ePu6LFIwGOCjwmV2DgqO?=
 =?us-ascii?Q?aedNDQO+b5o2g3IApFqXMSK5rYfPw0lftMYm5HbwflU4wgLx+9X72oqyr+e/?=
 =?us-ascii?Q?7ZEOsUu97iWhKGjqX7Lf0R66YoqcSlg1GYLf3BT3q6DqFtXOTNs7SICleVKC?=
 =?us-ascii?Q?r1Y6gDOGKo1gEPBMTN6wB2nRKUwP/3UC6cKyEBeCvfVeUZ5rhS0EwIVKARMa?=
 =?us-ascii?Q?+O/gDVKDSSCO9Gaq97sQzHEFMReFjHBOoH/ulUHoRWFS6Q4cjbFs6g79F3YV?=
 =?us-ascii?Q?Q/jDcyYaF/GQry83Q5tmXrdPF6nKhRU7jUVcmb0WeWgBOZzs/Ifv8xYUZM2I?=
 =?us-ascii?Q?FMXRIrgovNZzAYUZJzxY9a7DW5/zCfAxoioCrYNXOYOHmB8pXli3lfJgf0pi?=
 =?us-ascii?Q?GRMGYxSTiJApFkNT8MxfLZZITvjN1e7FK5fJKA6PEqnq60xFaScKaJcvROFr?=
 =?us-ascii?Q?NarMSzh9ltrOFPeIGWqWwubPXV22BpvYZYsZ5xAD71RVsF8Z0CzU9RJ9C3xr?=
 =?us-ascii?Q?PwcOIKe37hpqdx2qsClRM5H1MLQhcnBBaQXdrCNXXUdU12hcAwItORvSXMwo?=
 =?us-ascii?Q?mFxXNdkZT08yFWCZYL8QwGViD6jDna7lYPilCU6dgV3Ahi5C6mH9rdGBfFQb?=
 =?us-ascii?Q?uDrHsqINPFSSzoWACUbBTJ1fIta7zYa+rdn9Qz5WtgBiMMnp79QZtF56Kh3C?=
 =?us-ascii?Q?k2DL9RihCQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b71fa3-5dd7-4240-1816-08dee8bcb5b4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:13.5305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hOjLXOR3ULALEmRt7ahXdfzPq1pguIIDbJqzHBGuQN5oFtJ2PzW72aBHdezEWdzvjruhls+x1UFkBMWrZr4dQ==
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
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index b6a368f71285..05950cbc0a90 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1156,10 +1156,8 @@ static int lt9611_probe(struct i2c_client *client)
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					lt9611_irq_thread_handler,
 					IRQF_ONESHOT, "lt9611", lt9611);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
+	if (ret)
 		goto err_disable_regulators;
-	}
 
 	i2c_set_clientdata(client, lt9611);
 
-- 
2.34.1

