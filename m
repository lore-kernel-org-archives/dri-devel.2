Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AE9C79FB9
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD7510F0E3;
	Wed,  9 Sep 2026 12:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="K39Qlvje";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K39Qlvje";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330F810E4EA
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:37:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=f9HlKTZLYcDowc0Ys2AovyXlmag5iAWalEoikS+5TaSU7np/wMnIG8t5T+E54Ks8uO1ECfUt+wtooBRRi1EOACE0VIeEv8ywnH+78j/vVPyFVtMiGHhVqUDtpzcjQsNzkAHqROIcgTSWPZepa5FjPAqeSKtmq6SDgf69bY12BDUw41T6VGiHFY37vdiZLk16NLoae7bFrxb0HSr3WOHDTQEoh3Kd2l7SjLvSWJKAO6ngvkYgc2aS1l7c7mBBKSmhjsdzrMZu9ge9hDAL1O+KW9Ori8OpQshIB88XFvnHxqYxx3q4eWfL1nssPrHNDqYJ3sgYPkVUvrhZJOHa74zm6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxhh1H0Dwo0sRBQFkiCobiwpVQydAaIgTlQuqBNciGs=;
 b=dwd+kehuCOlTgZTWt0YxSKM6fUhAcEZbVQjOtT6oFo9BBOnjjr+oiwluFUVTb0rRz9AWNsA4XLJ7yK/cW94YGtyGExsZJ5avV0GRxMLbUZbt2NGoB+hMXOXheCe934Y4SxR5PEeXSAsCdvTN3FM2exrAX8yaPNEl/1ebTW+1G/FrOo3Z0wzKsQTbnJ05eqiV1R6poSPMSHZsukx/hpZp6Llb0VDuFaA4y3bN3+dY/rW2145Qw0sVrJ8mm+9FK4hQVrbgepI9TGDbYYEmELKLhiyGVasWkaJWUXptgVprYBa/Vvd3hgCwlSV2LsoG8T0NDYZSMrQmVV5UwqXAksjHUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxhh1H0Dwo0sRBQFkiCobiwpVQydAaIgTlQuqBNciGs=;
 b=K39QlvjevRHl3WhOHW72V+dlNjJNizWVa78/HtMaw5N7D4tO4n09QXd5pGMLHJaNS48fSpNlsVceRbAKCCiLKBi2j4V0stgbdtXY79WDpjrqG04AAYIkqXQUi+IQCbv6tH/Oo0tGJdfWPMFkKtZQlRCzAopiPYdYkvfFRIt8o88=
Received: from AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::8)
 by DB3PR08MB8892.eurprd08.prod.outlook.com (2603:10a6:10:43d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 12:37:13 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::25) by AS4PR10CA0016.outlook.office365.com
 (2603:10a6:20b:5d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 12:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 12:37:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1P+n52tXciGqeDBxg+h6UciBEE33dHmG9665UnHa0zh9fvdhRt1ZZ/eAw5Vbxk55yr6BvpOoNA6mLAyAB044U7oCp9eiAnp5hsbWRpemSY4tJX5Kh8Lhwbe09b4pBwMhInI97AuURdP+wRjsNSbVtOOC5H7HsZOUE+yBpwMEeLK8pq9y+Z/iJL0aMbZtmLjChxwmL5ZU/d4+CohVHwIE7YEkXdKBHNZLmINRBH3Q6/cAQhOWFTxc6BxNNs9e+gZX64+WctPD6Z7D3dD1IWnIXEX13m0bh8DrmWuoV9uGFSipar8uS/WBjwsEeQZC5rxzx9wumEgN/gIsEtYd1dAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxhh1H0Dwo0sRBQFkiCobiwpVQydAaIgTlQuqBNciGs=;
 b=q++W9UGifHmM6QElo/eKQXmw2gw36askam/L/33T8YHQ36ZPAbb/Daqgg5krr+wmp06BEwqZvahIfoTJtT5EDc7OBicSJPRMs0g465RltstO18iiXaaEoe8+fpefjfmuDR7dGaYpe4A2i7fqShGl91iIlTRuUXq2CGPbysmDc/rMfa9hQiUFRIG7r0ZUZuof4gvp8ZDBXHq0KttPw3Y1RbUBl6seyP7mNWzB0fdkXj0i28fifkXAargbuUNE8QYsN/FN5M8zJsuoFVlkBHL/+jfd/d6pv3oz8W6YHWDhpYBsL89lzXNrP4awdectOpoqGJMOPDAR/UoTDb4fobkyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxhh1H0Dwo0sRBQFkiCobiwpVQydAaIgTlQuqBNciGs=;
 b=K39QlvjevRHl3WhOHW72V+dlNjJNizWVa78/HtMaw5N7D4tO4n09QXd5pGMLHJaNS48fSpNlsVceRbAKCCiLKBi2j4V0stgbdtXY79WDpjrqG04AAYIkqXQUi+IQCbv6tH/Oo0tGJdfWPMFkKtZQlRCzAopiPYdYkvfFRIt8o88=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by PAWPR08MB9781.eurprd08.prod.outlook.com
 (2603:10a6:102:2e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 12:36:36 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 12:36:36 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Wed, 09 Sep 2026 14:36:29 +0200
Subject: [PATCH 1/2] eventfd: Add scope-based cleanup capability
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-efd-autofree-v1-1-c6c3c19cc702@arm.com>
References: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
In-Reply-To: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Bence Csokas <bence.csokas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|PAWPR08MB9781:EE_|DB5PEPF00014B8D:EE_|DB3PR08MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a53d0b1-54bd-4fa0-5bdc-08df0e6f130e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 9gI8c7jR6UIoBIOpZfba1RD9l6rRTwOla1Y+OSyxrWZZ0bUzggfWAmaO6p6VXp7ko87o5ZOQndH00PgoxW3wpVSJgnLfRqxQ48BCUppgX9AACEZKs2hRhSl9GaCWqG8elB3p6elzvQH4JZJo/ULjdNBV94r7/49p386w7JZVTyqCPHuQ6cGV9Ak28tcTcTA6aEtL/PgVCBXAXFS13EnZeD7YOKXU9AWhjFtJ/XZnBgn7qCz9q9TW1nGCt0aZNhGUi9c+Zy63+0xJSWdTxU2FUVO8XJHqfl73ARKpg+hCfip+WhzJQHkDRpQtE+7F07SIynMDmkZwGNkXVJuG3GoFgXXswoq2LGcAgHTfiTjeOCD+yLrs+modzABSAVzq4bYjc+0RJh5CxwbDPGJmCwDmzvt+m0lH5/FuuKzTWEY4SWCr8hnc/pt/jFeD8jtuGuLnZUmsQK+XPDoJ9p97A5JkiNe4JEbujgM3Ei+EcnN/acA13oD73xJwe7Zl0AqTVNWi/P3HJNg79Gu+IKQFrcEdhGoSLnR7uZoSHe4E+GaOtLOIYZcLz5h86kW8BGWdztmKUmcMFBOJ9SVwRpvBMPjk3ZgYr66NkizBr2ZomW/Q4ZkgboXfzi9TWJRw8BBMKuh485baUWkOTIKevkzhn77iUxT+DRErsPoBgaGLWbD0ykg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: CQgCuI7x5Wi6iyWRlLI6imLlP3vAFOz53UoEsPDiNW8oL2zittBT85PVcnEINWLkZDyOqGjAZahWvsa5W3owf//3SL+S/ALmFxlztEe3NI6oof7Us68QkiOIH5YYY+2GPgczaflHnIkIQ+JUlq4qeLhTqMeuxtu1ibFwq5GAkFF0z8eWrlouCs76NFS0hiTkQK9OPZk8NlalsGjaRnr1HOOS9K1lpN88GeJw9vhpY1B2seLMti2jJJNTpAHfGVcDIl1iL0duGERb3YM7S24vWnnZqEv2xQ6YrIVmHec6ArOn9kWF4cJq8iSoAGh1x7g5vL0GGNTrNZ3xB4MwLO/dsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9781
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b9c7342d-c92c-49e4-e42a-08df0e6efcc6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|36860700016|23010399003|1800799024|376014|7416014|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: vbUEo7T9YRuMwhOQAK8YTl+ENug31COEhYV0Iq1bz+FYjcNwv6mLmTrgnGzX7yo+Jf2vTcdH/DIfw+3KgnUUqgGUZtLUMgMDa5DUe9WCoyJS8zmE/Lr9exU37JAn+zEHw9d5/f3GOVo71/jNLOzf0eC6vf6W4u4cvNN3XpfTcXmF8TnkNghPG5UxaA/3HgW+P+cLiQFb0yLiVfQ4D2kzCwQ7XvfkRHEzLwRVCLYzTL+VuAx35R+ncwRgAKN2/IapPoko2/dupBlzW4Q9NVAFdbdnzpSh/ToZggVkt3rwtkoHpPVm3BawbKhGeXXqvhzHZH9IxM1KiU1+iJ+/lwrlwDZ9lekrKDn4is2nf3DHo6M5RRG+mc65c2QYppPMhDTllf2SQ91lALBcZXAOg9lYzdY/d0cSkp7JvxyKf4dqj2SEHuPDluyTdiJKZgZK6qDi6leyS9r6G9NvPnlhigKaZ8KRZjJQVsErjdKuEeOizc/SI/L+YyQS9X/QJFGZfJ3+x2B6TgKvRB8mztOQPSRO8SHn0VIQTsKgqTSb5ZJSFOCme8+Foz2FunTAfJ3YiAsF77g30uZEhu6CLjAA0KZNPENvwTy9z6n0LtzvzlZFTPaCBPgB8AOBDiDjuBFzzArXr8pz5ZgDk4JGKE+Ywe5HYEWhGR+W5f0L/SVmYMOVokrR9mKUPt/85oz1igCXhxNCHlEaSOgJHu4fWFbCepbOiQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6tayOfpXvYhE7N9UekNLDjeAJQF/bZb4Pa49kvYKhg7tFtGxkDxiUmuupXgyOZVgCNdKAs8GhoVsRc09gCRfUlVM7ozWdMwbsC4/I7i+HFjiFNhJ2chNXotBAk68dW4sJ/RFWe36I6vpagfK/cWVPC5xLqTuwf01oZAF9iMMHKffePUYhgMG10TuCTUjk0a/g64Rll0ljasXRdJ879zBncwn2APlrpj2PCkzuZedPGwEtIDwdOz6yTMQz78umk5buO0afbXll8/QynBmt1JCwuiTAyEESQftjStNXh5nQgj3VtjEC25/87Nvjs2rnJi+E5820TjQqtFu0UkEUqWXZ1aUTlffyqEMPwLj2Y8dyaLAkTQeiJNtlA5Y3Z/3GxP8StTixEDqpOghVric6HfSfGhvcr1Htil2aeIH8Lg0dtwSrjWgfvkfWQzA9ajLav+1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:37:13.2667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a53d0b1-54bd-4fa0-5bdc-08df0e6f130e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8892
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

Allow eventfd_ctx_put() to be used with the RAII-inspired __free() API.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 fs/eventfd.c            | 3 +++
 include/linux/eventfd.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9d33a02757d5..24111a16284f 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -102,6 +102,9 @@ static void eventfd_free(struct kref *kref)
  */
 void eventfd_ctx_put(struct eventfd_ctx *ctx)
 {
+	if (!ctx)
+		return;
+
 	kref_put(&ctx->kref, eventfd_free);
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_put);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index e32bee4345fb..689358c2b0ae 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -10,6 +10,7 @@
 #define _LINUX_EVENTFD_H
 
 #include <linux/wait.h>
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
@@ -89,5 +90,7 @@ static inline void eventfd_signal(struct eventfd_ctx *ctx)
 	eventfd_signal_mask(ctx, 0);
 }
 
+DEFINE_FREE(eventfd, struct eventfd_ctx *, eventfd_ctx_put(_T))
+
 #endif /* _LINUX_EVENTFD_H */
 

-- 
2.55.0

