Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377B9C531D3
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7C910F109;
	Thu, 23 Jul 2026 13:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="ec10VFGD";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012000.outbound.protection.outlook.com [52.101.126.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19F810E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl9BET75XgF1IgPKGRFJz9oBiaShRx5yUXK64KSzdAfP+ptVI780p6ZO2i59HC4eaTzwNc8HtM9Aj7Z8aIT7xjIt/Rx5XSjSyT84250t4BCcApYVO3DuxbKYPRfGNug60Iti2ftzV0ClWKPzjm/u6oV6Pj4F6FZAOGdHERX0BIaNDObhgsN/m8e0x+D2qtLluUf34Rmag5ZGySk7TPvfAh6Y+RSr+XC+KYtQ74eqtfd1Qrml7ctn0T+Epx2TPv4r971wT15zOwvRfosPZZuujc1WPcbLrsjzlD8NUV7F/qV1Alv6s6mdeYM9uJ3uSYmVFxgVroBarUW/b/4Ew8YenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgCrD/y4HyF2fmGBV65WbPkgxjBFfon/dylRufsUbNU=;
 b=Utv1rH7mUyA6c/RtrnCHnVCfhgXcux6tOfDS5P41jsMrMMV0/7Xo4EChzNDiUGtuPuYGQve6LowcOjfqMlAXDgTjY2zF4SaNAlvGzS3m7/ASYfDLsEv4Mu3N85LnUFUigWUhJnrKx7YvD/9j0YOC3lAr4mRvjJVINJyu/HgvW01Dcv2cIQYTZTP9vKcdiHMLvs2Zs9KJQVDDE6g0TaGl2TN8icU1s/SXd+9YJu0eyebnbj4MnM1oLE68EHl7BGY65iYshRSQvySkPLqUscVDjS9fhhR6/3vzFIL4SclrL7d9JsfZY/7uIx0oOWEr5Z7coYT2bgk6s7JW3/b9dq25Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgCrD/y4HyF2fmGBV65WbPkgxjBFfon/dylRufsUbNU=;
 b=ec10VFGDXWhf6RDy3/A9wta8GIZaHFRy7eTkWnq1htuvml72OOnZWY8kpXPfw5Tze+/uJzP55uqUiVclFn6dYLTn7Et/LhPmRdhrVzQzdoSD1XsFK73l+oaC6WVbz0VXiGONnRWTU+myIx0zoaRKERWJulz/Ok3QMiH4g5tKABr9x9lfIsalU99kpXwOEKe5THxktXgude3AWjq3SFFN3oyRbQ9b6n5/M+msd2anR+s3ehVM2P8YhrGpKcME/YCOk/qxy3CTYUd3GfNnvpae7/4ZFo3mdA6bfgV1f1TRrGGVJt8dmbyWeNMrzN08IZdnYQaOZ0JhAPPDsIH697BHnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:17 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:17 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: [PATCH 05/10] drm/bridge: synopsys: dw-dp: Remove redundant
 dev_err_probe()
Date: Thu, 23 Jul 2026 21:16:37 +0800
Message-Id: <20260723131649.134127-6-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ed45d91-fded-446c-01b7-08dee8bcb823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BJgxShhuHKLQ58P2XPunngDlI+3pTUpKIWBvFf4MhqgCIgad5HDISG+k/ABTKHvpi6cICrjc7HuVaCuKqHjAPLo27g6N05zkrBeOXOEBOS4HHoDaEYnXcDOqWJo3fHLDfXYbinkDHqdz0M6Yqelms+tmxJ522CvIT3/pjMa35QL58m/zXDD/mAEvYpwbIeRU517X9kdaFmPkINbwL5FVQ+XTYeXGXilU8xp6aFe00nFLAkdvd4aynp+JuOkbkN1YVllWo7hEKWagXFcPhMZrWp6aPp+KKK1wvbv7brG+xHnzpKJvWHkjIsuoHVvy/YzIy9FNIXYF01eyS9Ju0xszClK7qlIbQrzmNFY3FIAhvx4Yf2os3ol8g7Od2ld8Ek0u4N7maa9gej7ir8VlY7yU6IVClu07/8La4QMN8O8Q3xAScQbtSHtC8y0owglzEUhHfG1v4BXm5g/iuODcqVfqf/2uVK+WoMh3OnkNoJZqOfIMhpGNaEfoGg2CJsudYWlcalvkJgrXPX4ydww2A2MbDLfe1KnV8H9Sxb7+hKJHzC+Les/K2aR5TNbSaSiMUR0ErnN70WluYXivm7AIPeMAvGSeKm+alRJ2oEAlRwZUhuz+s+BQDJSWUnbFWaFl67vfQ8cNL6Q0K+OZ4MGRpcz1cEM6pVOxxm/k0JTP5uHejlqHTJg1jRqr6xGMYro28JOrhcFlOuXuTakOi67MOJcfSzU5fJKbKwujJrgGbiWnp8u+Ps9xTfr5FoaJ+Hf1Vj5g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?inzhEBma7kG4lMlaEF15ccp76FKnUBtZHb/VNRfyICm5fpDBIsxuPiqxTODR?=
 =?us-ascii?Q?LFOWQiNQfHsucZ/aE8MyBou/LefeL5IGHjzxixE34kMXX5MmHZEkejPLyIWX?=
 =?us-ascii?Q?Icz44vqTEP32Y6ijHO92Z6dqDgkp+UhxrgWl9daEae3eiHR6nDpyql4hzGp0?=
 =?us-ascii?Q?JrAsRtDv2BpaCyrHb4KZgCpHsq4TaLudTl0UI9Mq8r+jyqwEQci9kkKiwond?=
 =?us-ascii?Q?dPCJf2/jnhwyQTBMVlbf3WhevpDws4/Up2v39fDnhr/r0lKozkabEO7tA++C?=
 =?us-ascii?Q?1WBoKU/aL1Pd/TnsmO/REez2MC5iz9G6jhjMU5t3OouFHz6/CsJkGpyCFOA5?=
 =?us-ascii?Q?U5NYiq78V8hIwzRzLiq83E9yej93LvjC8yJQZeEXa/1gIKyRRa2GtMtyN19d?=
 =?us-ascii?Q?OtkCDK7prIoSBNEQsS+/thJDOKKs3RH5/imc2+nb6dYm22bKZE5B5IJfla1d?=
 =?us-ascii?Q?N1GCnxMNZYQ0IKJnpWdVS5us5z1vshEO50wINxWfJOYvURzXmq6+F6etS4NG?=
 =?us-ascii?Q?RvT7VIKYIiRZyNIBnGpFKpyaG9uHg7w5OuT/RXVjCP0Wv039BjvMEzXAM0sU?=
 =?us-ascii?Q?N2PxetEdRmUhbwx1TNO7MZb6pmmNf8NaYkVA3AlvW6KgyI+Op7+k+ygK1BVK?=
 =?us-ascii?Q?uwVjgbdi1H7CzefXCpV01EuMK7M33Uy/X8DmjVpgggvXdzvlnn04jQhnwxmZ?=
 =?us-ascii?Q?vXpsO84FepmLNu+R4oxaDjpH8kAhuogjAQ7iKhI8tnpjFBLp5ujDxGDTMoQe?=
 =?us-ascii?Q?fs0KkGnj65TKdMaoD5Qv/SuYASkENRerkP1pU+HvUCMtVHif0P6bFDo16eC1?=
 =?us-ascii?Q?0ieKrXtmsPwSESb5RqgmpMVEUXqPYtu0hc8jfktuq6GFTYOqGYXDUvxilpwY?=
 =?us-ascii?Q?tIy7nber/Kiffr8ABeJ7oxH2t3sX2MYpVMcpCgOUCJ4vLm8ZOLK9vooJsOeu?=
 =?us-ascii?Q?Xj77HHwTgklH2zd73F/0Czdy539x12/h9IViFrn7io6oRIXLNqk0Mpms+V7P?=
 =?us-ascii?Q?8pR4rRu3brKQWQ/e6w7IOCNmheaLWTQD41NIyBshUauGduV4cU/SWd0xgx3e?=
 =?us-ascii?Q?Z0psNyWfYZEGqNGW+oxdK8HTarKl5JAEHjE2wd72ih6bvYeg4tHN+m4GmtCK?=
 =?us-ascii?Q?R+2tHOkxhldIsgu54yXL+FEFTRyuKqicYf4mMlBPeBmoZjQ0ofkbXEmG20Si?=
 =?us-ascii?Q?ZusJZFb/v/duPKUdQ7434jK6GNy/2dcywAFsQde+1+K+1CJOINNdxKKCk+Ch?=
 =?us-ascii?Q?gGXyRahBBR92XbQ3B3JXa7S3h1f4GxHIRWF4FyMV/SzhraTNfMllF0ZLLZRZ?=
 =?us-ascii?Q?uyzqgD2hjbBBM1oVOgqFTjbnMmr0FZbfi1fAW5EP8qz4ztm+Wfm/qNmCdtbi?=
 =?us-ascii?Q?OOYLRzRvYu/aWlP345TZEuNEt/DqVvSGlSaprSfI9/SUvsLEvtDDVvy04fTI?=
 =?us-ascii?Q?01KxI3D9lZ9Sq7Gq55OC/HeYGnbaTpnbhWZsQxnN9njaq1Bp/doeQPTa79Pg?=
 =?us-ascii?Q?YPsWB99Bi/6XqoG5uWy1p0gadwW3gLMdp6H/FUm7ZIC5w+M/2KWzgT2oA1a2?=
 =?us-ascii?Q?4k/JQ5RvRwqV6Xp9kGKAFtDENq7xXYtFZK0dgY7Zzw1ViLm4FzF2H3C/Lybx?=
 =?us-ascii?Q?H5UYG9xvLbMX4UPiFD0c5irk4ieTXg6k0HHmoDNFIWRhCX0RGbje/GijBDMX?=
 =?us-ascii?Q?l04ulLw+rlM6WZH9m350P35hsEkryS1xP5+14Bti85+LqQ/9uc3dQg3MPwI2?=
 =?us-ascii?Q?R2x8TADUyg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed45d91-fded-446c-01b7-08dee8bcb823
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:17.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BbQngL9K+8p4B5qybhtyTBnb3ly/O9gJL6nRa+ef/GFO0wPQpCJ6X714w3Axbg6WX437CWwYSl6l3BL08vKgA==
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
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 3445c82e6f50..aea8973fb825 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2080,10 +2080,8 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to request irq\n");
+	if (ret)
 		goto unregister_aux;
-	}
 
 	return dp;
 
-- 
2.34.1

