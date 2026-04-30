Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DB7CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329DB10F328;
	Thu, 30 Apr 2026 11:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="K7pgp+Gl";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C27010F315;
 Thu, 30 Apr 2026 11:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXQzSWV9wm3hrheEjCs/Hh8a+Age+XxqwasomDCsfmswC78pMYJjQ+T3oI54qBLHFP3JbGr8gghG4d5QFcss5NMcErlTUMYOR3TxzYLrZJvCUqsZjtgZFB7KJ76jfbIIstdUPTw/1EyXlQUlcyFdS7QFDAcCs1xO7nIUjz3yX+8hnDCuToPNBj/NhHMfc/P+HX6TF1t1OXYCdF6wPFO0vYnQJ+RCxWqzsariZbjWK3N8wErSi4Ho0KeE0967rWvD1KbHxqVDi8caNbZ0wYuRrpEiLp6gMKruE1qw9bbcjgEcYvU8d2aXYYhgsZNj3xvP8+eBhSHk7xPpsMareD5zkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNo2vJjVGvY+4ZuX/jDOamNq9wcD0efUE8tQmxcyBMM=;
 b=ra9l+T0zKVCH7n+L0wfE37UmLLRMC/VZ9M/z4SgciPzzz2jvpHLXPTFSSLhd+YLFFFX5JOH+6RiELBp0EEi7XS7IKPqcaizOyWaRgL0F3p48VgPZrLJS1m9oPesniGOdx9+/RJ2MWMvQRvHWOQ7jbmnjtzZcffUH+esSZNyDhxmV/Anh4KH3ezXmxU12afsWmcXs0HxMYhSzDZzk/rDzsWkk/n0S2ggp8SW3ykwJUe9CiSVS1/95uZTKDanOqPCXb41Gk4/DA3Hf8Q8Q0kgC+17Vu83TsqY84jXtThWCt2+cx+6+GEhY1VOZ65bPBmpv1UjxGFMAdSp1AEwFkBbgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNo2vJjVGvY+4ZuX/jDOamNq9wcD0efUE8tQmxcyBMM=;
 b=K7pgp+Gl66hx3E9HIdUaLX3SvRbKemdHAJIhb3CSaTFVEYRqQk41zWzbAYEjOTetnhUVCxkloAiaYx65iW/cLc4ybrRsAc5V1lE9oF759vmZJDwLXkdMwD5lxfWbTfP3W9ZU7NDQunXucSWMBGma9CB3mzto/y8Dvv/ervLhYy03ktqf6FmPuGlQDEgfns0IVp/kMBCz0sbPGcUnf9U6zxV92Rgb/dOj/Hs2yIGRSF2Yby6Wy0ZlROD5U0BShBeZsxcI/KPpFNQpJthTZsxdW3Lpyn+Og13uLuP32JkUWQ+87f8thr0DAlKkpcbLoUIETTrmRny2h/OIT8OrRIUz1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:25 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com
Subject: [PATCH v7 phy-next 16/27] phy: make phy_get_mode(),
 phy_(get|set)_bus_width() NULL tolerant
Date: Thu, 30 Apr 2026 14:06:41 +0300
Message-Id: <20260430110652.558622-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::35) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: ef78419a-82de-4b78-9d68-08dea6a8a8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LR3LN3pM02V/nLS/LGV29oKTOnF2KNNP7frqoFk9yH9qjJHqnERtay2G1gmN+Rb74H6MRI2ClW0FzDVtS/tLd/wsplj1x0DXW5MkHToSukFByDIeOg7PJvNFC5Sr0t6M9xoJF5K54CG37jr3gKlzXdLiRrkDP52e3Ik/Be9vRxYd3NeY0ttSfz9RnYeA7QNqgr1NhefLNZT3yn/y+O7nQpRipQ/NZz7Crr3q0n9yvPy5x2uf4V2z2U3z2jdXvTrr77/ymBcy109RfQMwh646jdxaxaWugIaADkwMpNxd92O0XQnqoROuZ3173MIAQd8D85LFQA2xG5QcwH36aC/1kaPXYmZbVzF3d4vjCHadKiZbaD6Aa5q5k1Rrf7at9cF17hIcTLnH4t8hPOxU0mvXH4My3O+aA5royCy1JZ5p+A4TTCFaxrpKB0rtmd7hR7txOI55EIltKA1mWG+rWKwM0gSEof7JvuxpFZ0WuZe799Iia/dkQEkH5jctZHk3m0t0l7CvY9sOfVnbKeEhWfO6foCYO3UscuL/2T9py4iCRge+cQYYaFejX78KtydMbcGc3czbrisydmyqDoZAikElOujfHpHo+sC+80jB/PBAyaA9N8HlkbVjGklvMAKGlOtm2HLvDI3+oKTvVBuIjEoznrB8EgLAJMPrXw1qdX9yvchsgzDYa9MZ44amARQ6rV0qnEfICU9JyB6fENf797fpTHT8xkz8JXDGHu/1voRPTaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8585.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QV3VH7sCMHiy8ZC4atc6iTvJTSpWXMuaLcWRWDDn9E8O5Zw/PzwI29V0pWrT?=
 =?us-ascii?Q?3r8BtZWY/+bi8CSASLUtWYmJ4bhtir4hG7v57pWILXSBIHySukZiScN34GBS?=
 =?us-ascii?Q?1M7+vjU2QIBBNHKWEwBFOFChrG09fLzrbd/k80zhGT+yuUCmTQ1nrpmzPWCP?=
 =?us-ascii?Q?xZH4F1gymfMmpPoaZfX48vPGsT0OeIbJkZTQmRXe9dbrtqLIn2INV2nu3HGu?=
 =?us-ascii?Q?wt/2Ltov0zV5aM6/U1+0SaqCWY9OQZKmpkRxTqP/q6GrUbBax47WdSyVBj0c?=
 =?us-ascii?Q?Tc54o9flglipBOy4hxuKc8T7WyCjttQYLEG4dVaVt2tfeAKQe6g7To8lnwUD?=
 =?us-ascii?Q?d6rSfR3P9jdni+6KGtGLv92JuFD8RrJt8SC5MVVadsI7Xtgpndha1OY05zLS?=
 =?us-ascii?Q?4TNbc3nv5FqrQwX3bUMPaaAal25hGkw3hKPcjTLzzUSpTwGh2H30ZJMxRU6T?=
 =?us-ascii?Q?w6xHz1zVLWtL9+3yvgzqPUoxfMXXUoLJkOCtFvNiyvcmqZPbXVMSNNylS9D3?=
 =?us-ascii?Q?2l5edk1kmtDmzqzJMyXWOUGSxbhewtK0HLh+eVS6C5MbRGliAlfzke+nMChl?=
 =?us-ascii?Q?r1v2JVPTw7DMjiZfV8IX3Jwr5113L1acXNMaJufkBgN44zP+IZCa3p/lREXx?=
 =?us-ascii?Q?C923cpnGgCokc2t6WSBN4TvRYvBwA9Jtyqr8a0cTpnO62BqIkrcF0ZhnHdu7?=
 =?us-ascii?Q?ZkLjNeGh96EJ4m97zEx1/10SuPFQSCoxoS8fmwKQ0kWQGbib62BGNs9WO4nP?=
 =?us-ascii?Q?sRPaIcSzXhEpp0KdIc80wmMEsf1umxBezxETFTzA8108YvUZGgUGlAcVjSUh?=
 =?us-ascii?Q?RriPb/ZQYfey3554AcsrUgTuXLRM5z58XPc6tmjuiAS3OVTSME/3OZ/jLzoi?=
 =?us-ascii?Q?0ndKSOzadmEhok8od5BI2fwZ36XrpInL8QgQaXg+RKvYkEhWnhZNijFgoM+z?=
 =?us-ascii?Q?9PiHaz58uqEe9HtHQI9ibv43b4uGKwJMVcLJcjX1sL9FLJcuWDBvFRTDxb4G?=
 =?us-ascii?Q?1bJVPAqq2Pkfr3g4JvAD1/fpn88JhuHFMamGZ65eKkJMc97wTBWZdTL8f8Cf?=
 =?us-ascii?Q?O5w/jWLgcTneYWQH1jqM/IQllijEC33j97/q7p6lN7IsnslEq2Mq9UhCkM1X?=
 =?us-ascii?Q?mpsxQ1oFXEud4OXcaWeww2pSqTYNxmjabIzD+HScURauzkThYnqyhUCz1eby?=
 =?us-ascii?Q?svw+8t+PAALb7R6RmjJfNPmik7CIXcd8dh7hCahOMUZd9BV2/g4S8qZ5HHEt?=
 =?us-ascii?Q?rQdxbJ2UGwsOV9RvjKAQzVv9XMsj4d041h9EKY8QatMmki8m0RkmHY56k6Zl?=
 =?us-ascii?Q?npYKQq1CjON46JltUwpH6X1IhuVGq8NH9pe3t5051mPLhTNsE53If0JRXLXP?=
 =?us-ascii?Q?tm2mBK6q24n1aD3l+GgcHO0HiqJ5dvr89UevqX/cksrCLwtjmCaz/U+Hmxed?=
 =?us-ascii?Q?UW+p/nIDRQdYZ863DfCKypCHMMGSgXYo0ykLfl81D9v4jLvXhi3Jz8V5Zs1A?=
 =?us-ascii?Q?s4yqUAKDzR6VmrrAqsH46hoGFlXg0JFfL4e4gSeXFf8nbE8E4r6lPCeVL7Ew?=
 =?us-ascii?Q?6PWZio3qwJfbtSe63Rvv7QFHzweWzfO5LG09jvZvf8uJQhz72pNBpR8UjGHC?=
 =?us-ascii?Q?3Eyq5qllOwpzOopuQ8eNuKfCbApEWRx4vqCQWulGe08JHz/fnS31J7F0OxoZ?=
 =?us-ascii?Q?/nE2MkaE3oh5hud5/e0DIF8+cJY9Rhf7+Bxa1VnCauc1x65hs+0QyYHhQRmL?=
 =?us-ascii?Q?CU+/mpZNUJF4HwBsZI35f1EcILbEkL+38sksoQ2AyJbMhC4XOqtc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef78419a-82de-4b78-9d68-08dea6a8a8be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:25.0168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2bOQ/4wIajlhvGlFMl3Y5A8DoX/ZcvJjvP8F5io+X1TpX1L5jfvTmvU4T16WrM7akXQp/0bA6uwtYRAG2Mu9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
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

The PHY API has an optional "get" which returns NULL, so it needs to
accept that NULL coming back in.

Most PHY functions do this, only the formerly static inline attribute
dereferences did not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v7: none
v1->v2: patch is new
---
 drivers/phy/phy-core.c  | 9 ++++++++-
 include/linux/phy/phy.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a1aff00fba7c..0d0be494cfd7 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -624,19 +624,26 @@ EXPORT_SYMBOL_GPL(phy_validate);
 
 enum phy_mode phy_get_mode(struct phy *phy)
 {
+	if (!phy)
+		return PHY_MODE_INVALID;
+
 	return phy->attrs.mode;
 }
 EXPORT_SYMBOL_GPL(phy_get_mode);
 
 int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	return phy->attrs.bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_get_bus_width);
 
 void phy_set_bus_width(struct phy *phy, int bus_width)
 {
-	phy->attrs.bus_width = bus_width;
+	if (phy)
+		phy->attrs.bus_width = bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_set_bus_width);
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f208edd25afe..a7e2432ca1ae 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -248,6 +248,8 @@ static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 
 static inline int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
 	return -ENOSYS;
 }
 
-- 
2.34.1

