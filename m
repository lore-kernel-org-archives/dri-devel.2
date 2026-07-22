Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC52C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC5210EFFD;
	Thu, 23 Jul 2026 07:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="Fq9jZgKt";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012032.outbound.protection.outlook.com [52.101.126.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9241B10ECB5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ/twSrpr8srpkm1gRY8qQewjewYtZfa5QjL6NBdSowz2ImTzsvNM+svm/p71YP6dd0kPgPv3BDB/a2UzMutXSvZNQKSrUpB4IO/r2jL/9KHFr7SnW4d8GRYMfEVXsKKB6FRsZeJKC7p/pmxP14k8qE/D44KfBDY/mh7geowepNLPX4wsLtNBGCfN2V7AW4nnwnD3B0A2NSWk46vlV3lIXh1irYt+7dLY5XhedHRTmFZX8jhdbw1qDPCTQ/zSJ0myGaEVKbR8pdsNd27vPqHmBMOBcp08RSlrRKHzzVDJJaPpGNOhY7VwU93b719a6O4QKnXf8ck6fX8D/9rkyS62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNYCN3ObeGyhvPqD2SON8cyshGGv6V5b9jhuzZLIMj0=;
 b=atkua+9LNYM7ZdkYd2t3IXXTHp5eid6W7Yav6kjzL7MJ/H6XH8Rco6BkSyRy07XLpGq0jZVe9DyUdM5m+YdgxgKhSzqc+oAwpoqk2QOABzU8uga3ktm5Pon0cCCvWEUV3JbO5b8cKfvyvBtUlZbFcMVBTnk+wQh3ksC+dNRgCwfPadCnuaQf4YouGUGg4+wiU917ENgdIoRGfckPN6OD2PT+mtXLs8s5TRrRrFVHMqZwkiIYDiSpNkzO1uD58OtdvcFP5LK/HYKwa+vM7aiR1Osh/TfINHmNpXY5V9bSF+WH874o4LWH6SXOqF/hzMSMbLpQx0ldhmHBw76oGzbFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNYCN3ObeGyhvPqD2SON8cyshGGv6V5b9jhuzZLIMj0=;
 b=Fq9jZgKtmLJrOC2w2F3UjFUwiJ6rBwfbEeSj3DvhE9il5zPDFYRHnyZ6KF0zlIMZodb+rSW/uXVSfDEXqMPoxwEjArarKT9HndCU1LzjIbeYYimXo3G3nC1GlJKt/CBIW08tt5k5Jo2yR8eMCQTvZ0Kt7eDTAMQO+69W8ke8N0Uhskv9xej6kLh+8Q5BqWGxoitS++Bx8AMZo72m//pat/sfdwkD1yGUIjP0Bf/dM5DtSr2AdUODto/Q+tDIZXGptPk8ngXfuG26/4gb3RxgWJN3BohC6v4FFTQ7/Lu8BpGxKDSpwwrPP3JYjUZSTU4124mzckhCejaXFzoH6r7N1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8492.apcprd06.prod.outlook.com (2603:1096:4:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:29 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:29 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>, Pan Chuang <panchuang@vivo.com>,
 AlbertoArostegui <aarosteguig@gmail.com>,
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/7] fbdev: pxa168fb: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:43 +0800
Message-Id: <20260722075803.570532-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722075803.570532-1-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b21d108-9648-41e6-fcf0-08dee7c70466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|52116014|366016|38350700014|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: xIGOawbBexr9YB+Vi1MxVn9vwCU5zFkD53kplzdV2H/0ArsaD7FjFPO+TvrvVX+7S2c0me+ReGEAEZadOLIK20b6BfHVCwCOd1iguK1P8CZ/udI/7BPY3usWOHtAZAN0WcDP7yNqE2cMxLBqrxfvLXHKR2mKdXMlmJDlUXYwEczlFiM1oF89u5XzQ7iku+qOsjyqb/LvXKnqf74N45YaKKmHCWSACWQKUdzwiY0YCh/hIMoHYVk+rbRnlaGgdIjJej6fe6gZa1jR8uliXHv0hzydlY1hdxkXH6gLmVzvYfnm+Pyknmbt991RfyP6HgvWcg/Bwn7TsVN8D6yPpLsHH8Yvu8PSQgfEYyQwne4ZoMEIUifG346R+ocqkuAGf8cExtA9TVtQBNgl85ZieR+P4V2hgB1/wz30Q5eceIxWnFx85g+4qVAp1iIkCZh4XVxCXLbhKmJZO4HdXAlhtTmOJtEGTALk15QrEBl3wVmQh9OS/RlUFyERrdKmc2Iq2GVuD/cep31+954WPKYEtLedxrcDJ7nNvxpo83xXb3Mot9mU+r+jbm8e6IXHmsn+IVtq5ssESChSmIdgU8PFrR6goeS5psoq/lPatBNN4BOgeHaCIvy9nSCOEWNxc1HB1OWyKAyHuAyt5IQfvCVdcemi6rgaGrC4LaffZRPEIX6kJU7HEbmgYtE+Wvu8mzGhw6exyYxDygeuEcfuvOI36VY1ZGwv5H9YOB0wTU46An6BJuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69p5/I0GpuGXmqVthX2Gy2RDm/AO0ED7l7mM4Z3qleqs/dQbAbTk6UixHPGe?=
 =?us-ascii?Q?2EXLPKGChx9YOo00PxkuSswE2roOWunv1OsWHZxfsIgO2GPO5i+cSajSiCvr?=
 =?us-ascii?Q?ke9me1p8ZOWHguwyYzT4nru4IljjlGaiBlniB8HHwRwN3v6QOY7uCCxyELgu?=
 =?us-ascii?Q?ShkvWNK2pw4PDtnyAKrEd1rV+4nhqTj0e1Hj0+gh1HEPnYFxEOUxacyrKJSW?=
 =?us-ascii?Q?tbFgJ+E4vGGE4PVvdW1YmFLdlVBjuC21sJxKPAaO35tFCX/ZtPDi3nqQbQXH?=
 =?us-ascii?Q?E7blihPRQg3u1wvzmgepz1DEsDB/P0i1GiNe5UQx7hgBEkxCOhBQNuOdHo/s?=
 =?us-ascii?Q?Xfb+RSOFdyduIi8R+s1SnwV42LbZfFaNe+2VssreBRbqveaMQF0Sw8XD6H6D?=
 =?us-ascii?Q?qDvpGs0CxjJg7g2CLVMn4oTzvl5G1JEvbNmGC9jFednblpgW6cQnWSNAFo+b?=
 =?us-ascii?Q?dylfBMRP/H7ifsFHFNG0yH9UuYmC+aydcCTd70oqk4f5gmAF7cNK5LfIx4Ya?=
 =?us-ascii?Q?TZzMuPj5wEiqr3tgPw0qkZLlfYQspetA3bTTBU6DbNT6C4DI3xws41ZApSOb?=
 =?us-ascii?Q?DWHlnL5ZB+WEUNN92rymV/nsSUH37FDQWXfb8USZubXKnEQ1N0ZyUbLVg0z5?=
 =?us-ascii?Q?s/X2bLZF8BppbGtQZ2SB0RICVkC06zb5m8vJiAAOgci2u1KbMH/IPGYHZ0kC?=
 =?us-ascii?Q?epyMoYtc5VKxNVcSUZ5x0/c1N2G0S+j/EfFO90XdiN2vIJ9tklkdHXhfFjjT?=
 =?us-ascii?Q?3eMRSE5opIWnACzmeG77nG/LC6qJNsenYaPUsi8u5puXVkseXZpwxtE+j2MR?=
 =?us-ascii?Q?08l/iBTLSUy4nnvlgUS463ZrJLXuIpLjGGFnF9FGYUYSxEDcdDP+SZSZJ9ST?=
 =?us-ascii?Q?EFHziOtXM0Nd0gNfKwpMcgelBi9qhs3et6GmfdLqtqz9crf8FkyECYw75fI5?=
 =?us-ascii?Q?/Ltsq0BTq1H1O3NrqKm8a1Uhm/UCzlusXIVwLb1rAeC/Fw9CqkZba+9gFCNe?=
 =?us-ascii?Q?YiP1XCIUWES8XigUsbG838AQNfVkE4h8i2hcBEJBwvVLHLBRgo8tlGpo9PxS?=
 =?us-ascii?Q?wvKMMRe7VExAzJn3g3d8jdcAERhNQeEGjAxPLQ1Yc63Szva6snZoFfpIy1DP?=
 =?us-ascii?Q?hh/uncHA6V9lfTp125cK8pwhWnXIB/bYeX/1+/XBQ6oD+h9ElgShGgz4CyEf?=
 =?us-ascii?Q?OOkbhXMV3Z/qHlFTJXvygRFQlGNsj7Je2KqHGtYUgc00GStuT8tDf1vgwPIS?=
 =?us-ascii?Q?3Efyqt7sYpDbbVkZatEGuPE5R/eibgTsL/SsAswpbXrDZphL7RR3rCF6NMO0?=
 =?us-ascii?Q?MEf36CdNQf+mVc1DJYwVTjeDJqTlFBf3Kxho947lofQ1qYIycvwbiJe3TiZl?=
 =?us-ascii?Q?02c4GKLnf+j9ksaMp+wrX2snbYjXGroHTX6o7jbe8ZemhrILYEkwgPS6jkOE?=
 =?us-ascii?Q?5sSdA9EYmtCEyjvt/UDQkkcWZEJAwaGlOiw8UCEd7E+tYJWm1aC3kUHNe0xd?=
 =?us-ascii?Q?gHMpmgLBmKjYvi9+QjgTS3PSVh5O1zzGBZ3YJzG03AvILTmRbHWYF8FGF2F4?=
 =?us-ascii?Q?WMhOJoid2ZG5wndAdIld3NBFxY7WV5b+4SpMbof6Ftj614WoDDHk4NY3v3vQ?=
 =?us-ascii?Q?kVOwiK7Vi/CvFc70V/If+sh2UX7VrxGSL9mvneuKkl7Yba5dRiumv6UBkuws?=
 =?us-ascii?Q?Xsr7euGdayk+xAegrGMx8gy1qYh9uz2XEziLgFX+hPKSz5BpI0+z69rAOVi8?=
 =?us-ascii?Q?7pS+o2m1+Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b21d108-9648-41e6-fcf0-08dee7c70466
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:29.4374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSkquvfwyFcrLJqxI80dpvCgRXb7Porr8/HV33itRprwTjzz4zsO5n1y/P2n7rRv550e3wEjzf4fQBtot+1cEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8492
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/fbdev/pxa168fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 6784888d93c9..ce8a823d7128 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -725,7 +725,6 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, pxa168fb_handle_irq,
 			       IRQF_SHARED, info->fix.id, fbi);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to request IRQ\n");
 		ret = -ENXIO;
 		goto failed_free_cmap;
 	}
-- 
2.34.1

