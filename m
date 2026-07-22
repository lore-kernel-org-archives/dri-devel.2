Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED851C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB4110EFDA;
	Thu, 23 Jul 2026 07:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="UOkU8yuB";
	dkim-atps=neutral
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012002.outbound.protection.outlook.com [40.107.75.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7664D10EC77
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG8fC6uboCkDojSxdhVkwxSAf6PwqmaD29kRfYx0FtdYUG9/ZXgavwGuNlTmZ5AguwjrrRRZmKo6kqZPaARo/KifsHCbZTo8Dzx7Oyj9c02yAHYzSmz0C63+dbxagFo/zhJcT+BJc5vfhvZ8W6HUz3GbVHgq9JpNhDJeKohVdCoPlCTvFJ8gEPLoV3bkPBvCwtuqXiharDXa4xHakkMS+hC223IqiX4uB2ET4q4y0YN1drut2VdMBJWRIQkCV9FAmaiB15yECHq+hLtZHqjLB3FcQStGvLjvJWsrAY26jIM55KGwSLS2Qj5Xyvpxya8A6f6ZDe85ONtbxfHJgrInmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPJYAulmgxtDwd04OtbMV0I9ljJr4lfhPbBaJqyPiKI=;
 b=LbcAR7LGr8rpwq+YjQFg2JHBVliKCYDQ9mVrJtoEGEts3Ta9GrUpPj1VAhUETPcGGq1QCht1Q8WLvI4abLejVGAQzN5Mg+HY98bU7bKqwO0WaKxB7oQSIXxPrWI8qnc3dvBYuddPmJeDo7E4+o3+aQuTeHP9xDX4L2Cb0HOpP+HpZajulXLPG7ePmMpmsjRFy4JdQJStHvYUIkRKPjb2kk21H4T9pNIZ/L/e892pk3Uvn4VaNrMN6Ce8I+4DsZeXEnHa0YXEGXrXqWjpBe1UwiGPZ+XMGAcikaTq4FjJLs8DdjvFtbe++ZHvu1tfYVF+/elgYuWZCoNFdk8RZ3YAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPJYAulmgxtDwd04OtbMV0I9ljJr4lfhPbBaJqyPiKI=;
 b=UOkU8yuBlC0mH4isjlC45FmpnR6Hye2BIFZzK5F3aN0VhIlpAk1d7Jbh9fw98KuIHkv6m1AoXqhvHkDUqVJgRcp8CFJeexKXV8sJ2wrYkhUrngpxFLlBJsOu0NnbZDZLm7GEqdMJXlG+gJW37h0pBsS52BMv8Y3FHIiaiQvjdgLmenAA1OErxw074NAVpIKSqRr7Pv9RgMC3veySkKKWd7XVogk6FtbGnoDY+ZMyqH7oc+pjV4vkpw4F71Mzi8TYLPlGmNjNCa2QWFBJTUjrnATX+OvZ5tAIltk/TwIVw7JGl4PD5g+nSMyqnx/M+LXElnw0/x9GsUsnf0dugGvKCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB5014.apcprd06.prod.outlook.com (2603:1096:101:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 06:57:19 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 06:57:19 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
 dri-devel@lists.freedesktop.org (open list:BACKLIGHT CLASS/SUBSYSTEM),
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] backlight: qcom-wled: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 14:57:08 +0800
Message-Id: <20260722065709.346072-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0101.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: b250ac26-c653-45b4-9a60-08dee7be78a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|366016|1800799024|38350700014|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: +pU9oL4VR6/jkOsa/Bc/PMVpBARUcsXK+6Kh1Z9DBivPDl1VzT08jeXH+XtTxzudxUrD3uwnmpD8PA5GNZelrSgV+I+muyh7l8hkjx62qnt/NKv4suolIV9BzYXzWITsKnIi37ehaFEvG75HGUTgvf7Ry6NFrBn2ZMeR385hPQbV1IhyzLaYxRdXw0T+lJW2+3J+6p6zMxG4HxLqyZ8AzAnmvhUi7Prf8PJGRE1G/ZuXoopRAQJlZvEi83+clssYNuRdQuOrx9d3w1vxaAbVJ+6eSXrTowXHFMUQwaFlkFkQvia179Xqr4/DAFb/JHyCbW5BCTLSzSYp6s2ZWuIQUQJgKE9lguS9BLrYuo8D3qtYeEC2avKrAT9DkVBj1rHTXXrdd5ZISAjJxSF8Pj+Rqu/BiVI38zZ7EBAiDT+zCqQTo8zxGYwPzcaMgOZFV4Gf8UiyAxAsPHbYQuB7+rHLtpdvlQVSyN7As8UTiU7bBHho8pTpgXRRZSjCnNGUplTC4zygXP6wc8TlKAA8ZX2NE8AWTPUeGF1iHGkV+H4EwbO9YF7bmM+mQUSENoJm7VbFlW9YNP45WEhhzN124hOzn8SKC5qKzkQg+SBILQFlaEJPsWXmulPoIvMkhTasIDItCn5OFnaWyt3X/wpEhEzp4pHIl9IoWjUXpserQGmm2gYtx8z8xS27Xa38OTJDfgmlYcVi6WLrAwKB5BpQ9IdqiKKjzDhq+w5Bx51Fi+fMzAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1kqtMYfl/nSLYdcYIwaIJf2uW6PdtlOZCBm3q4sTzbzbfHXY24jzEGv+17i?=
 =?us-ascii?Q?9DtjhMzsaZ609ePrjbB3iKP07tvqPcMW8/34EELKj4N8hJiFY0Try9HxnGuT?=
 =?us-ascii?Q?3cytOwNiUcUUQjJVY76HH2F2GISDmgVrZZLswh0CQ/9NE1iR4zNMSOdTAzLj?=
 =?us-ascii?Q?DVLg8s3y/b3cjvIomrCsvbNhnCSSy6olxFBba2QcmRkWj7wwDClWQU3otufv?=
 =?us-ascii?Q?5hc1TRfYl9AYNESFJlpD3flriskP379lPCVDurmhLDPDj7HR22W1V+1lzBU/?=
 =?us-ascii?Q?GKfXorZJrMAVxbS0DoGVhAuQqMrcHVEt+vlW2J8YMSNtonivJsYOvjRPAEQ7?=
 =?us-ascii?Q?fGoN1eNSHwHdIkMivQPR10Vnf1JkN6MfWspMNC7ASqOKrPdK9wiwgRE0y1OY?=
 =?us-ascii?Q?n5N1wjtJc9wI5/4st9s9Qq9idhyLQx/4Gb6DT1ZPkA9tZLD9ivJfPAraa7kf?=
 =?us-ascii?Q?l79rX0+3MP6xTdgzvin4LxeW0Eh3RKmpXI48+JOMeSIuBm8JXyrebRHb5FpJ?=
 =?us-ascii?Q?AQDqMnvkCIvk8hJSrrNRxJKbNjpaLy9P9tvqwcJf9CYIHDLjZoda3SmCY9kg?=
 =?us-ascii?Q?IXVzGEu+wm7Bh3aIq4covln4KT6frTJxKuFbJsHuYu/SCtU9hHD6V35kzO1s?=
 =?us-ascii?Q?aNEMNOKERQrV/HPAxdiHQEYO864ZaoRmdiSgRrCJBBtQUOoCpH63A3khV5Xc?=
 =?us-ascii?Q?AFvOeYUu3XyAHBYSu7BOLEnKedfD5LXqsFCAEZrQMFhT+B+vrQueZnBBbzx6?=
 =?us-ascii?Q?r95N3mCvN+Q1lvfIEUNLfujyXxrsTNs9SSMI/dIDoBEzAfAdQjEJ7MAjSGw3?=
 =?us-ascii?Q?3RJKERjUjynxE3WTeuDL7lSvRhoYTsQ1FTrTN/q7PFsfUInu2l+IB7LD0eHt?=
 =?us-ascii?Q?igmGoSxl/kBDpgW17p4SaYCpabcjIoJMBzgX3h3wmHgfg+JK3ISwwctEU7Xj?=
 =?us-ascii?Q?f59h8Cgj6ZUy59haekUKCbDofL9WaAe8zBwlVbKWJFTC6ahkahF+40P1lHrF?=
 =?us-ascii?Q?BmplZVsEyM+HJtK926NC8A4AnvetGAzSEM81XQXZTo6wGg+nMsM165WZKOA/?=
 =?us-ascii?Q?Qbft1uHb3dLmdSQuKdbGgf3zFALhn2VpcIfajv3/75W+gRBLZo37Wz4QhFfB?=
 =?us-ascii?Q?iErVem2u8AeVXwHKi0SijyKHJyOr9G8keq6SkoyWAo4DWDJY+E2FWPrDnHfT?=
 =?us-ascii?Q?w+EvwmpmVHwQpvgrkSJCpIJNG0Dd6RPZnYVsbdTk2ZTgO3fBAZcnYLDuSCnH?=
 =?us-ascii?Q?YX2TFvow3juF6CZS8cg/23afFz8yNaO/fcGPmKsHnthJqyNUKZQVI66JuqjC?=
 =?us-ascii?Q?Q6sg8bvncsb2Y+2PjygxpQkYy6x7FljMr7ixGPDDd9eEKCQbdWzs7LJrc798?=
 =?us-ascii?Q?q2yNkWaYgzoqY5/4SQ3q6xzhMXZOaEUetm4IRJLHFE668Kwz4CPp0dut6EfU?=
 =?us-ascii?Q?Oidt5SQfgMNlRlPAYJHwFY/aLY/9tmZGuwot6PblsDIprwCV2xgiAMnWiPgH?=
 =?us-ascii?Q?2na8G9hiTS0e9NXptnH3mcPku8wVpR5fZFxu3GvN27vSvWsgYFDeRjuoL+PJ?=
 =?us-ascii?Q?8EMH5Oiz/es3X8ddGF4ppFnCqMNimT4PrFYhpGwMbhOCK1VialTmI2V12NXp?=
 =?us-ascii?Q?+D9MB8WvT1GvPrXyNOnS3UN43nrMq4/MFz3UucySe75qaspXlDXYzzDndM5T?=
 =?us-ascii?Q?3d4Os0zUvb2C7/cxsZvCUDHpbtkiJGj4cSL6XnTuzNcXxU5LDDvGlOEn9rdo?=
 =?us-ascii?Q?FLoliGe25A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b250ac26-c653-45b4-9a60-08dee7be78a8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:57:19.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALs3fESBj/oCnDmgi3qJp36EIwHN00CpCNOqWu73dgyi4Y79lwUIwZXFWTIsgQdj0G8Hne6Gs1k0oquNhyi7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5014
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
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/backlight/qcom-wled.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 8054e4787725..650dd95f06ef 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1639,8 +1639,6 @@ static int wled_configure_ovp_irq(struct wled *wled,
 				       wled_ovp_irq_handler, IRQF_ONESHOT,
 				       "wled_ovp_irq", wled);
 	if (rc < 0) {
-		dev_err(wled->dev, "Unable to request ovp_irq (err:%d)\n",
-			rc);
 		wled->ovp_irq = 0;
 		return 0;
 	}
-- 
2.34.1

