Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF2C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04EE10E594;
	Thu, 23 Jul 2026 13:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="AR0GmXYc";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012045.outbound.protection.outlook.com [52.101.126.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A45810E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubBHFSbcNEiPe2X4k//joydeORtRzgYJLNK4PwugP/KgZ4qE2dY4HEFAcdsi98QOPFbg7aLmZbPMZeXXx5VjTWO+HMhtqaJXZcJuqRKnnlzTBs2a3Ki+Ef7TgDMSads86wZgNlXzQGGrk0vqB+yhBMgQAUsrsXRTvm1PZJXpAuRD56a50ulB4mlUJNDJFNS52PDckicNnyepUrdTiTpTvoIRKJQHW8g6+TuwCxXBnIUY3T5YOwuVnmekZNt8AC0e2txDkDCbdSeVA1X3gW77lBVYctYbC2g6nASFSBnWodA3YLZTHKpEBIWJzlP+AbAaDoOQNHbA7kJsW3QxFgjrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VoNU5TQJs6gjzzzKiBkjQ+eEyKeGUXfBqkEn1OCwdQ=;
 b=yNbRa0hDpnEAkyV6AsXSKommTkKEvi7XoRZF2LulZ1d/ky9nxGoj4UImvUl/IVR6qEBqFeJqroDmnUnjQJnRC93x8kYDFGHpK+zGb7xY+HkZpR/3OASBzu7RTjTVCL6UMORdRy0nLnHf2veB5Zr2AhGjRm8lB8veCP5a55Naii/hn4qnGt2dAx67kP8tDj7D7LwCS0YNeyHmvZLUiJWruasmMutUacByj3bpP8xdxDP0EnhPiO4NgBSGIvQxQ46pgGagYuFOaCP+F2tlww5yG+FrzZ3zR3V44OCHWk099gAmm2XFzoYk9AYQLqK6AHpqogGoFQHFJeXvH3RXX+oBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VoNU5TQJs6gjzzzKiBkjQ+eEyKeGUXfBqkEn1OCwdQ=;
 b=AR0GmXYcFsofduH3TfCh5ATw5E9yJioNSEvlMvjpU0Z/WVPpWxeXS7E7hkpx1YuYo8O06qkPWwcb8XNeU6Zs+e9nR796zWtgo0jxJxoS/7gATciOAjDdpd1fpgun1xyt9zEG0Vb5iMMrOJdUINxatbx4KgCr1PubjogG56L83aZxFT218BEJkpVF7ZO2uXDFFOk4FRDtbmLgmTLWat3m5neM9lS1UdR44TH8jP3B7Sz+J1tTby1jOQZq6I5r4Gl1n+FjolZrPC7GmNBi3ppr5OHoZuCozEXBp5NEE1RpM+iZsIftDIt53RVODdI6Sf4hgEdls2vgH0un5m4GR7L1jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:23 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:23 +0000
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
Subject: [PATCH 08/10] drm/bridge/sii8620: Remove redundant dev_err_probe()
Date: Thu, 23 Jul 2026 21:16:40 +0800
Message-Id: <20260723131649.134127-9-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d4e8c53-884c-448b-3986-08dee8bcbb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ugiiSksl1r5a3O9dKfRNRqeablfj+mJLLz7D7AXGqOKh5fsBvpLD7Sc86xET92BRG3rozXrVGzCtTE1CbyhIrGuOosLpH6Op7/CqGypY6DNxNhvd5AYxxmC/1mZiHxabkVWtVtysRuuflc/CsN7vmdfIHjF9cNXsU2O4L1ufiff285/HTa8g7ccK4MkKwcdvWIMHDWy+lkuomgULBC8/umHDyQ8N5G++1l/JBckWJrvLg86tqGperd/nu9m9gP719bGvDBJ/SPIktK6O5UCrjVdsU0OOJFhBbQ680ZCBAOIhAgm6W2ldkX+udeXpwmmDFpBy034TA2uVEV+Oa3YDj/h2JDu23SDf3HOkeDbPqLUmIUXD6X+AN0rjGMloIsuO0Q/JVvhSpxPftZU6nkbdbDiQOHMHCro6n6aXpN7bXaxB0N5sjNnuz0APDIV4/919X7rPw7QtucbBfHxZ6Gjwjt/kmSi5KaAAab3/K7f8q2FbiNBncsrj8jsxjZtkk8FQESQrpMH7HBTuM5MONSeXefy53kaohR+GJ9hzWDck18Byyu/CKdzwd884uPjCJuypXv9jH2H6Lk3z9Go4e8D9FZNTHqk4G9WPTWd17E1Qo9Lne6dvb7h3yE4UsJiJOnMf0ddmnqumG+EW+BP2QNLaoc+0PqwDNK0iI6mjt1fIfhIltWerbKjX0YqmST6W93UTL8ctUVlF4Y0r0VXu9Mq77T6/CGQhCjz33wffL/6j44k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9ZCmW+IO7iyzwIbkaGhfEE9Rj1nvE2rzxAf+8HltYQ7ciAvdLQXJZ3HqLEO?=
 =?us-ascii?Q?oZcMaxLUuTAWkeY5K59KZBtYqgl8ttpyav4U7t41X5QRMywAh0XbWyfTgPTF?=
 =?us-ascii?Q?LLph1jk5MHswUxPH6CcMRoowuY2N+lqjcCDSiLAgumrNe0Cbk/cJKiNMLcI1?=
 =?us-ascii?Q?kBulRMzMZAAXnuybi489qtvXjDEbaMd3HG6qQA2sIew05/Q2312f6uXYL93m?=
 =?us-ascii?Q?FqIJ4txWnrdq17V1cHNfcuNfXLXs17hpXCIvJp8HnsfrMllG7/NKqMtKoFim?=
 =?us-ascii?Q?ijutAwEkoDkLK1ZMTm1+OKbFkXtDGVl5hAScnvE3dvJgNqX7zOXKxg9lVivx?=
 =?us-ascii?Q?jbgOafq5+9HXgiKwB9/oQ++wgQM3/m/KaVZIkoQYECUplaQfHi5fZ61fULfC?=
 =?us-ascii?Q?b4dDXIR0+GzYuhwmbw5dr9/7m9eB6dlPKYBhHShiB8VylCoj8UENUcS1yu1B?=
 =?us-ascii?Q?NB4v8rlALsvLMzga9ZgLhFCG2EvQUqVVcevGWbM1QWerYbZFMrYjBmEGNVMW?=
 =?us-ascii?Q?zxxHKHUPQNDYmMPL8UebUI9SPGrIN4f/KWTsK/i1ZhDbM9aWhcEVt4/l6Qj4?=
 =?us-ascii?Q?PfsyZI7PhXiSRNMVcJC37AxLApeNutMB7hoe7Xs7DMG/gK0wtmEVropkMxjO?=
 =?us-ascii?Q?7bTWsDRvnyicxdjK8c6/FR3BT/3I7ffdmKjkT+04oHY701YEeTrEM/KnrAx4?=
 =?us-ascii?Q?tvgzgc6+M8rzw6E7VEuaX0SwcCUk+4Gr8tqJ+n71Pcm9Q3FyPq8hU7MsQj1v?=
 =?us-ascii?Q?GxzCDSl17LIY8xhXRyCNG211R/Y/Pn2lUVfkGziJIuC/vHj+f5CWjmnl/DkM?=
 =?us-ascii?Q?/bMU4IhJIjfjxT+1pMmOKu9HFppUDUmEAHPk1E8QpDaoT08TnoQFKgfrmbrf?=
 =?us-ascii?Q?iKwcYopd2bO1CI8Zc4/7Jh99TgQuafZ04L4SRABmqj+FzlQbkKm3i7jH0oxj?=
 =?us-ascii?Q?UwOG3tyteLAqoNdbKbNVQlAKonWqeV0PqQk/eYo43szHGamcxOyKa6m4GcGy?=
 =?us-ascii?Q?O59dgdc5a7VVcjTQyZDg3BqDL/t77DDxV/uPaKK4V7MY8C0AChFTbHUSds/A?=
 =?us-ascii?Q?KTzch3VTzLP0F7iuCx2p1yNT5Qyc6unablG/plDcYpwDZ00gs7RozeaK4AW+?=
 =?us-ascii?Q?RGLBjdehRedu2AHXxtw4r5zM6eJMdFccpOkpCef5kHuysETlxRq8VAhiPGEF?=
 =?us-ascii?Q?eYxmCxlKUdhcx1JwMAAr3gQki5XZrednJO39kpODGvSBCiyGu6cwToiVphCn?=
 =?us-ascii?Q?nGP5lu5VaYyC8HJqcIIw6s41IipkvRMt1IsfpSYTDSRQaPnLz/Y5AQEV7jud?=
 =?us-ascii?Q?LtVm+WpouLa5Vt+ok2irzNHbBFey7hNz/PsAfsw5LHZkLXZ2AcRF3e7wqwAV?=
 =?us-ascii?Q?AekieoVm/Srs88TPRk0YtB+cCOtqkhbBUy+qN56GQNNYK1vFd41UEXUwqCG8?=
 =?us-ascii?Q?P/1/SVF5ZYcaCSQlIN7tfml4LGszT+o7O7kySj41pBE64IP++dZW/50pR6RG?=
 =?us-ascii?Q?NE0fWZAQYbHCOjsj0cdipp2lPliDMXdlgY+2etLbgUIKaFZV+BsF9abcW+c+?=
 =?us-ascii?Q?tBz6VGkd1UkgBbqQhS4LVYQTSn4otDpzo6Uv16/4i0BEleASnHKKLx+BhkbA?=
 =?us-ascii?Q?ZafhhxdsXeezb19BukUzaMVP8Cyv261O6PO9tt4pvaSL5bKWpeTs+eN21Z6+?=
 =?us-ascii?Q?AWKvY06mc4lT5KVt2bkELeosKRo6WiCraRf77LoMqOQGLEbh4tOcdNVGJSxr?=
 =?us-ascii?Q?njBhRuLxAg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e8c53-884c-448b-3986-08dee8bcbb7f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:23.2138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJei8RmJ+xKwt/W1UKgWc+aGuOlm5Ldy/PhXDj6w6jXG38aSpWJru0sZhymWd0jwuXMThAfOMLSDQc2iyo/3iQ==
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
 drivers/gpu/drm/bridge/sil-sii8620.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 22c81b38b41e..0b03142faa37 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2320,8 +2320,7 @@ static int sii8620_probe(struct i2c_client *client)
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"sii8620", ctx);
 	if (ret < 0)
-		return dev_err_probe(dev, ret,
-				     "failed to install IRQ handler\n");
+		return ret;
 
 	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->gpio_reset))
-- 
2.34.1

