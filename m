Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12586C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A0A10FB7C;
	Tue, 15 Sep 2026 11:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SW/Lazfa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SW/Lazfa";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2536B10FB7C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:10:44 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DYi23Mr7L6YilD20ESeCnD+XjITKRcbKnwxslNGe22v+I3i5D5MZ5i/OFYOlk6AG/AsmE094oXsquECMx+JKKp5w5Oc3xO5tkCNsgnxolZkuGTJO9tQGWpbWx8xM58xbXlL2XF+s1/+QeBHhwiPxzolcgwu+oMpEdKDU9WOK0CajofwUmsfStlJZhO5eoKM2w6viCo5vDiRd4u1nsrPu0OTkYYANlvqzFRBvuv2IBGhXWMsmQcsbqxBQo/mSyGhCLl8/VkWK0jLRFUFkqnIN0Os7xLuvldMR0hEJPh01M4mDVaeWEkdAThTXTXJqWnBzBm+kO/xuILwFZLnLowP78Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHIsu4Dtb+ZY8vi5rKPCR96hNxyvk865G5yHQZJByzU=;
 b=mCktQbOV0+W/jgczNcYbI2XS9JI4vQKFlRbS2SGxS0oUUar0gf6yK+Ib+9wGDGnrjubrja6doODBepKhCyQbfzq+PyWw+Uw6Um1hBGtJ+RxTcz4MVHyehLR6kCy2/TtDvoI24mym8ZuKRJd0e/aA5pBtx2S0TTj2RbsMZcnVbG4OSpfG/+qByImwS010LCm4rWdnu+hYThJsTbt4UH7NFFgPgao+7b0QQkIxP4UZdfZ0QbCyIvpX14LdKhqvddtjduA0/F7OqUJUpUL9kFqik9QCfKd8Ku1TQJnupQTqYWG4BgdY/+YFbDgO0VbU+3Ffu2O0oSLslkiKmyFdzkzIHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=zeniv.linux.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHIsu4Dtb+ZY8vi5rKPCR96hNxyvk865G5yHQZJByzU=;
 b=SW/LazfaymxQEHeYXRY7/QP0Le7VgmM3OmHp/e7K3M+EjhG2WXYOUsgtE/2knZ4im3ptCok6vYR+oLEpx2FvlzKgAI4jYRJ+klyZXYIuBx4FS/PMqugdv8vSTUe9wBzwulkY76RqsgGYPLKEJT+7IXJJ5GFBdQCDdXsxeAH6op8=
Received: from PAZP264CA0123.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::17)
 by PAVPR08MB9794.eurprd08.prod.outlook.com (2603:10a6:102:31e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:10:30 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:102:1ef:cafe::2b) by PAZP264CA0123.outlook.office365.com
 (2603:10a6:102:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 11:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 15 Sep 2026 11:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT5Q3q2WSY7cIIkCOmuVySCWuRC15XfJJRwFQvHIv6WL2uR5QnFnaEIyb3+87TJ01UvWpL4srQyGZsNUFqm+pDm30KnJMSxehleSV/NzXnQL4chPct7y7pTF00I1JEjqGIZ4M2yZeHmgUE3i1fEj3PlgwWIy41VLlld/7sqA6TG2HrFPhxpCykkm3VSE7YcGnoXHCfSkmd4ejm2rGjrb7i6UMdGyrb9y7ArevK4WkjSGDte8IYQt/AsLC2UQBsD3n3tgl90dCi9lOw9pXNaa4JpKJgs0wdA4ZT5KOLdYXdtLZfg31M4LfqNr2tcTYgPuxtteQ3R/2hUm9iSlO2sFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHIsu4Dtb+ZY8vi5rKPCR96hNxyvk865G5yHQZJByzU=;
 b=hWa19RGzKb8Z8Y0DWugyQ1Go4Xbrc/k1tFNixOhFdEjMoncXffCMtaertX0mg4no8yKkLLVVlByZ1Os4oWCIDTigD4B6tqWKvJ9Hiff8unOR+byvsu8lhl4dF1oKTzy40I418DftIl8neZNurHDJWWV9PswyvRguRWNzAjbfOdMVcsHTwl9uAr6tnHflMojFis7XNO6tpQ4rQBbghjE5slWi7/ErLOon+UyS5NeHWpE98gSPfCRauTDhgPTACaV16sSN1yXzoITHPpNslpZi7n85gVsj1FDy1Ka4AHu8j+unSt/hh4QctrYPR0b8wH8+uAZzf8uRtCP1TQsl3/1X2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHIsu4Dtb+ZY8vi5rKPCR96hNxyvk865G5yHQZJByzU=;
 b=SW/LazfaymxQEHeYXRY7/QP0Le7VgmM3OmHp/e7K3M+EjhG2WXYOUsgtE/2knZ4im3ptCok6vYR+oLEpx2FvlzKgAI4jYRJ+klyZXYIuBx4FS/PMqugdv8vSTUe9wBzwulkY76RqsgGYPLKEJT+7IXJJ5GFBdQCDdXsxeAH6op8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by AS8PR08MB10151.eurprd08.prod.outlook.com
 (2603:10a6:20b:628::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 11:09:56 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:09:56 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Tue, 15 Sep 2026 13:09:23 +0200
Subject: [PATCH v2 1/2] eventfd: Add scope-based cleanup capability
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-efd-autofree-v2-1-06d2c9d1547f@arm.com>
References: <20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com>
In-Reply-To: <20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|AS8PR08MB10151:EE_|ZR1PEPF0000E6AD:EE_|PAVPR08MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1509254c-451a-4f30-50cf-08df1319f406
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|7416014|23010399003|1800799024|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: EExDFf8OB6rtLR1bkPF4htWiBk20CqQCkQV0FwtIx3EVzHMQE5ofw18U3J9dSOLFj8n0+76T8lUQvDHe6Ul9OGWgW6ws7RumUlTobJz1MZvnIRliEbVlrZuwYCovSNIi1Crlh4ReepsgyI+2gsGBO1h2P62Pi3yrB+Ac8JQT6V8e1Y45VAm6ToIq6xnQ/mOnrZC5hNRCIvJZzuIOrmDIw8IzkQU8HosCZSGgG6lHShKVhkTOQvJrRZ0a2wqNKXMeKWPMWJhwzupur3MUypHganEOTrl/r4mJGGkQHPPGJBYQ+LQuMkq2uL0ZnLOygOlZ8w92rOO0JCnqTk4AtlMK0LlaGSFMpDpfs/Y6EUaENNqCyF8oa11kYoJ2Bet03Fw6sgESDQTCyykLBnnGKWRs6ZsOdNHArgGnuKBFzzma8SyVXKAeH5o0jdg2SClxmjM1vwPNg+gn0zgfjZYilVQlU21CYiK6U1Mt1kPO6Ey0GJ27Z8t6e5FNnUNY7DK4bpdPwfwt7Upd4c8GGL7LN22LID/eZbE5j0sUs8SM/Ls6uQQl/4K7s0XGqrxD63VPPZrvuhp5bypWfqsx6Znw/s23hxsEUWbFxmkrDukfSfrdZHdzwKc/oC51ge1YBc+nfHqbbMtM5FyZDs7YYxMy6Demo9xb0dinax3YnXa/JIzMV3U=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: n2Y4ofoOwCGsd3c/FxpI6AR9XUVOGgEveCwFmSNIXFFeL3zauspdgQacPM+97W0bNVZhrWGLhLI5F+Hi1AKn18Z4ggNKZ50HjfPCeMAhDwMswR2eyv0eoemSRIacqyPzhueh3Zw9pv4+CdxrOk0cidEjRG9YlGITBD1QfI/GLvIFRum/7KFByxZNuoJcLM/w3VgtL7zxMGbcSFAVlOyJwI3dC/8qf9znJi5uEOztxDfQv6wTVHKRAduc8hes+bytm7iq619qUyx46hk0UsydX5lzQVZdN7f5F4i+1Yp3ZRHV0Y4Apj+H8DhOiHpOXjrwhTWIE51P93Q3QqoExG7mxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10151
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1da66a66-5a75-49fc-bf1a-08df1319dffe
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|35042699022|23010399003|36860700016|14060799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1PhwABmEEKgh7NQ5Nkja+ckJOl3kF4a3srgn7kSYPHdwjOAS4oR0yS/I6wJJKiundxBcdgaUE/T+n8iIyfgHJa5Dg36LPEN+BJgag6jQ4VxG679x4v8SXYYcXI/TsreyrypQE4NrNas7E4ZFx4HlUcFWn2dwiAWFa4r5AjMxdZQ/F8ttIKgmT3kGwSfcYKpfu8mYlzdM6BytPcY4a+jpLVBnWR0NxDwPtFubS9Wy7wgnVLMLEB6IBAWlvit0+aTkVFpNVP/IdwafzW+/z3ciFRhSAqvAbF3j9by6kMUZ/GJqAoKjOW9+LoxWmfYm75RcNhqrOfknT4h703tofNvIsnQLGqXX356DXvDCY08LzYX0hR9oUUwOwvl4Mgu8FXA1Uv+15O+zrgArK7M5ya22y4w3UyyMUFu1gwsphTAVhgbYkRqc6ohIe0vhrW6JloFD6OAVq47nF23OX64fKEgppq8nlMeuCggYEL3H3DN2LpI1QsAhHfRJHs96gvVpexXXpog1gD3qDGWo1s3fWE6+i4av8OEFWRdtgmNxpfWzdr7QcpHv5/21dxds8xTlPpTXZUV6JXRv/ve08N8fYAWk7TJoDuJjCWs+KCOz+YYUibABoOtTTlRo/N6D9EqullMKrUtMa97YCYDI+9i3jaVnh1OnOdt28XhlQ/fccVZX0Xot8oBp67enV995Ns7D8t61yuW4++tafKfjIE0qSXy3uw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(35042699022)(23010399003)(36860700016)(14060799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gnhFIHJpmyo+V1JEkdF566pgyK7Spc0bs3tq/zUE3yaaNH63nTQa+yzOPr1QvOOtOzZw/PJ/fzIqY9qFeZPk6At28RQBfks2R1omCFIhkJUJ/cr2Bvk4oqjSB1kLWPPUOwJENUWo81U/rBp+q2MGld+gjb5ugx077av3dZ2yxAwaSd/FWj1ChmQapzqSU6oZXcuau4vva8tO6Irwu+Wo0e27Hm3FMOGSI75L7Uhnk1DF1ZRNtlwr7ChYRJ/2JVcSobsxDbRJwEkmOFh1vnztptWoObGR+LGMk4QWkfznlX8hJFTGPwLEqfssukQLOrLx16OsJWX05GOw/QcGKsum5k8b1s+MEZTHfTBIfrFO8UUqz81RqzVkJLQsmvP/hmHQTrW4okGMMJbXzDNa5BH7wX56PAUSS69m0j46fg1lIY/uCUZJHrBYmvsb0SZ2oVF0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:10:29.7537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1509254c-451a-4f30-50cf-08df1319f406
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9794
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
index 9d33a02757d5..1cd1741b81b1 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -102,6 +102,9 @@ static void eventfd_free(struct kref *kref)
  */
 void eventfd_ctx_put(struct eventfd_ctx *ctx)
 {
+	if (IS_ERR_OR_NULL(ctx))
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

