Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0111C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DF210FB7A;
	Tue, 15 Sep 2026 11:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KQf8Y/kC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KQf8Y/kC";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD6110FB7A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:10:36 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hIDzvvGkW4KGMrrzHmZjVJmJs5ZUiv3qsWU66MtwFFGb8ZuJzX2E1ZACDw0JGxtKDzpMwjZaXzHaQvjX2jE8xnx/xrrIRPboQleoE9PlZ4+khV6Q+lhuaUyTnCYvC2qbXKWgfZkXXS3AyBut6bLAfue0pnGFUjYipX0BUoLAO8alcLL0+4wDAkxpdTxogJ2Roylg9non8oBE8ItXhdDoePJkHPL5+0jXEpj/88XCn75a4xlfpaMn3jclB/B5SwDZeBi505hIxq9YGp7XDdQOdNr6lwOpmKbCPN//FEo89K0S6QU8mPQfYRwimSKQ1GMdksm9x5RGuvOWdEnSJUybCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzJIM6W84xZcbe5QawIC2QTI75JmavnrSxBW+76Fr9o=;
 b=jTzniUgRe/bfOl83fUkJ24KYywGUnnsSMQdqZzP7Cg6IRkhsaL5VLwYhgYp4eoz87qYgp2C1DwFuQPPUy/dJfqbBDSX5Pb7/SJEzyQTGTbZoWpBXEMieTlyQMqB8V5s8rHGSoPFTMKgMnF3cKyNw2JowYetuBzq8t087VAI04KUMY7pSQ/3qMxkLIbBJrnaU8qxmd30NdR5pIU7HMfvhnHI+OI84FCqmxST0fGHaC0doiyjzJA1YP3yhFrGd6wvT1pIcnXvOG7tSRdySiLvpXsz5SdkSPPvZ+Pza9nDhRKbUllzYX3fB51MaVX3xuUzfBGt1iqP7uRvGbSDd6ksqIg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=zeniv.linux.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzJIM6W84xZcbe5QawIC2QTI75JmavnrSxBW+76Fr9o=;
 b=KQf8Y/kCb4Cpz2o2eOz3eEfOPGc4YYyqloQeuoPOL2SzZRQPh1PsGthKSM7I2/166qULyfJrkcv409OZ66ek3mfs7ck6DHPlJP6xj8aG6Q0CXXEtQWNzfOoRnvkFSfAR4tWI4p+qKldUGfh0w1ugGmWoobRbDXuz7SSRoSVEKAE=
Received: from DU7P194CA0010.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::13)
 by AMBPR08MB755206.eurprd08.prod.outlook.com (2603:10a6:20b:7b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:10:29 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::66) by DU7P194CA0010.outlook.office365.com
 (2603:10a6:10:553::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 11:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 15 Sep 2026 11:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4NkDjsDLccBGAZGIELKHo3Bbk8VgIlkDqeNo/m0Ur2v6pJDvOXJYrgVjUpGdmlYXjgh/X9AShCq38S7NabslN3zazyzA8cy2Qkw/8335FsCv7+lz6QCyGPsqDR9htHpgkx4dO6t01cveKLvwmvCyWkKdaHwGwKME2UUMvTE/S+1jprN18NuNyXC3r114Rdk58SQbh18XsnrqQajitnb6Lh8aDCxx+XwZ1Fuc3T/3eUfap0wvlIT0q32mI62eEfb+0VY+YbXhCohrj9yQppvb72BdrCyICYIFqNspmN5Fu4WIC4OUSe53XE0etpJFYi4KXj1RWU7pZiCYTHwNMrWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzJIM6W84xZcbe5QawIC2QTI75JmavnrSxBW+76Fr9o=;
 b=UBVuard/dmCK5pw3CkOyq1YuCcosFQNPU5EOqfScTGD1rGdX/7+Tb0mSBaRiMo2Gqh+b/jvO3/0VMEJUx/ZllEAC4Rmda5AE3sbvFfQqu3bD+5xz/SzB2jqoDNW0bXneasByz1InBpFFyJzr/Qqdj3TCsSrhB9uDFRKcHveueSZmZNvP5z3UKvW4b/yKeUIf/YQe67z3p4VUotPzfojNwC7KQpZ+z9gXHz+aruFSYyGhEY9BGScqeghRZdrnGz2vJxJSjd1k68DVCsxSlBCn3gErMsPvbOniJeLoXc78mpWsiJdMd4oM4m81j1Yom1E5AUTHH4qYcwR8d69GidNCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzJIM6W84xZcbe5QawIC2QTI75JmavnrSxBW+76Fr9o=;
 b=KQf8Y/kCb4Cpz2o2eOz3eEfOPGc4YYyqloQeuoPOL2SzZRQPh1PsGthKSM7I2/166qULyfJrkcv409OZ66ek3mfs7ck6DHPlJP6xj8aG6Q0CXXEtQWNzfOoRnvkFSfAR4tWI4p+qKldUGfh0w1ugGmWoobRbDXuz7SSRoSVEKAE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by AS8PR08MB10151.eurprd08.prod.outlook.com
 (2603:10a6:20b:628::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 11:09:55 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:09:55 +0000
From: Bence Csokas <bence.csokas@arm.com>
Subject: [PATCH v2 0/2] Add scope-based cleanup capability to eventfd_ctx
Date: Tue, 15 Sep 2026 13:09:22 +0200
Message-Id: <20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGInqWoC/1WOwQ6CMAyGX4X07MyYyQBPvofhUEqRmcBMN4iG8
 O5ucvL4/W2/vxsEFscBrsUGwqsLzs8JzKkAGnF+sHJ9YjDaWF0bq3joFS7RD8KsKmtTynVfI0I
 6eQkP7v3T3duDw9I9mWJ25I0OA6tOcKYxRxOGyJIHowvRy+f3yFpmwdHZ6Oa/cy2VVmTpQmVDV
 GlzQ5nO5Cdo933/ArGXOv/RAAAA
X-Change-ID: 20260826-efd-autofree-766608e8d8aa
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
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|AS8PR08MB10151:EE_|DB3PEPF0000885A:EE_|AMBPR08MB755206:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5c1adb-fafa-4853-fe5b-08df1319f3bd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|7416014|23010399003|1800799024|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: bh2tOVPXy+9ja5PdwUj7UomKDkyLqUUwbGjb74TsM1QDL7BwXrftKVxMg8L2wQkiEaqrB5Jq8h5sOTuSfZFEojHfmRD6MiylazFgwinK3uWvxjX9ttVNgwjpFFkxsyz8HYG068/Ru5xL0QcCPxi1YgblbLiglAAaCQGxc3UUWEosPY77m5XiPl5cs4eCWDcf3YcT14EIBsf9FuPKFtpt9q9P8MHuD1kcFeWl+F9zC/i8UJwJYSaPeIeEcGXK6SyZ6oceL+rdMswqce+xEyxzQ1I78SAO5FH4VsX3eOaBrCV/C8iQ2umMiA8hQPzqJQ1vVKI576LuhtO8WvvWuA/RKQ+9/1ib+c8QT1/lJZIImIzWRu152HhLQODUgBrqK8qisG5/2dm9C76fv6c8N/HQ0fBWK9Lh8ITcMHJ8Xau8j3vXV2xuhm7DQeJkkZzs6XNL1801ooN5pNz9kx8GD5wkjwWWXPyCMMf+3SrjGHv0nOaAAo8i05ITy85tW2osjzg/RSt+xPRHa0gVrsBeeD0oCxw+n8mmUIkg456ZuB4KkRx5e57jn3heU2mJfu9IB9us8dQqvEzVw7wJ7fktC3IETPW8RHVb+jIK16K4WygFBVrw2NjPj2OBnXp1DcZFPTKL
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 4n5Ppm8kBcHQPq3WSk6C8J6lieIxYxXuC/1r3UhbXWx2uDGVvCnBVyHoMK0e5lKfMI39gp29j4M4YsA9Y0X7tmZrgsJY/MIpJ/Q313+yKHszS8z6OE41ID0wZizlIU2StAKyqSKYpTg2IGHHnLE5SKKgkrs2JWaM3TXpcDzPhRbHAjEhvDF/TDly4y6tMTBklqEJW38efwq7WsJrrcvNFiru6zo1NqRPjyIduV6arPwpLLb42g7fbFxQeyf0XQdHMBDVCjcf6FS2GUWJqNRjkZDVWWsJILiQRbjmuOgE7ZR7rK4YdeOfvRaXmnotai3FGb1KHt7835vNwKTSSmMoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10151
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d3cda82-5cf4-4274-d032-08df1319df1e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|14060799003|36860700016|35042699022|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: s5gXOOZ6aXdkmN8Mzt7hOwGkHJXaxsHQYPVD3VXP315sUkXxI9hBRCAEt0i3qTz9LfRGXPq4CldfbJ4AgV5IvdNhN0epc4t5dGL8iOld4Iw8S6wdTgDo018wjnU66VdP1RNI6oCA0aybD1mzD19WhbzHy/aJat1ZsJUMySTzdVb4624hi7DsqgDfTClBg/QfUJ7j7m3ymWOQ4G8Nl1lOHSw6novgJrUJkprbnIuIWzq9t83T3eW7ina3WmGywzdAwM7wXe2GWuCenRrcGdEVnBG2+D9YF7sTkI8jqAS2MoTOD4BzBHujregpKM1vUN2ZJiBruGwqrgPz64Oe0YVI6FiNm9D+3DRR7kT0p0DHOP/KEMqoEse4KvivBAKkzql19DNykAW82NZ9JElIBHhW+WwGuEOkMV4LtMhgo8BAt+5cXdzS3xhicgckcYzl4zrk0X7pydf1K2lav/qyM+hTmUEOdocBMh71CNjH7w0Nr3y1+t5fxNJXF0CVKqax7FPhulU2cUPVVnlRs2+FZbLlytNJIR3fztUYmgFzu9wOc+bXnPbw1kMRtL7hYf3TtqQ88bsSdf7k3xxqc7bTBCaEudv6CZoVaU4b7pT0Qit9gpGfdmk3rv+d9Hm/Ers8NAxPXDjNLfV0DSWmM3LAWIGtrA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(14060799003)(36860700016)(35042699022)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 64LAH0euB4OJCTsITQtpHnKDssa4FDdKYOH7qCMrv1nqqFAxflAA37DtNsgYrKV666rPet5anLfAMhFQ6YZ2CwTZTFdcBynQl35KpfZC2mm27FaG6NlzEnu9raQ2G2lnmmFBGoPIEfKrKL5ah4A0ALQ6U2WVV/qN/IfPug+gIEu/tT19ppoW6gxVZ2MWCQMoyvONn1VSeSrR95TwZ/5Ppx5CmBTcTRftGZNRo9Gj2QpaS1GtbkciK+RYybHJ5nd5RS0UCH6tgsEVRe3/+TJg6Llke0iSH0c2GwxswiWE8XzL2uu5AuvJDN7cwfepHYkmB/sfsCSIlgRBmiuKgE9FZjVmxuo2/CKmqNcFlI1zfIwhmDvxx1gQgsWJbKgHd/s3AFm3UGUNkvRXUzKpi8hvJSfVeeMI5IyhOvbmwpabIQaU0rKNwJ1Gw6m8vftx+iXg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:10:29.3277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5c1adb-fafa-4853-fe5b-08df1319f3bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB755206
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

Add __free() support to eventfd and update drm_syncobj to use it as an
example consumer.

A minor discrepancy I encountered is whether to put a semicolon after
DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
I followed the example set in core-api/cleanup.rst, and omitted it.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v2:
- IS_ERR_OR_NULL() check, instead of NULLing out pointer on IS_ERR
- Link to v1: https://patch.msgid.link/20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

---
Bence Csokas (2):
      eventfd: Add scope-based cleanup capability
      drm/syncobj: Use scope-based cleanup for eventfd_ctx

 drivers/gpu/drm/drm_syncobj.c | 8 +++-----
 fs/eventfd.c                  | 3 +++
 include/linux/eventfd.h       | 3 +++
 3 files changed, 9 insertions(+), 5 deletions(-)
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260826-efd-autofree-766608e8d8aa

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

