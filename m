Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F84FB5190
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 04:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0019B10E1EF;
	Tue,  7 Apr 2026 04:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XKRGZyIn";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA710E1EF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 04:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJQGSgBoYCHKa9ihN/oe7v+ygRgy98CLH12VwZUPNERv3lYQVI/E4xi1Ija7tE9mmRd/D4F5YdaaM0IKBX/8T4LmEdaGhjBbPb/H0h79ujEWTR9X5xTiYGqSsYB7lCMxK+gTxCMNo1UzMgo2L7tFYt3uNuQqNt6cbC1ucLx2rcB4WPwQdL+tdBDuot9eAIzE9/lw+IpyTUicUIgSbxeB9+ABWw1qvxUHozup7li4f2MiCDI81M3rYr+h67E5hHqIvlEpDV3u5a5n5cvkba4zl6zynKgAuSza1BBxKfY+aexkalf1/vv87uaDkLL0TRzJKyVjZjC355BuNMslQIF8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd/E+OcDfJSkIk7FyCmSCTr/6gAWhKE1EER20onIQ94=;
 b=VKCbQbhoW7Tk2ZGN+bk6bWANTW760YNpkFanI17tXYSkUb50Tydj4nC0ljp9kmFceksKxPQ9a3aHV6YP9WQLdcY9XQ/LPqjbA9l7ZgOEny8JUnYaxtWSRPmipSr6G6rjyUE2OiAnTDGjhGTJauR4dEoRZIt7aNU5b555qDNt5FiTOefFPKF8OdaygNJSZu3XTxte/4h8862A4YnWhSSuUMQPQwt81NfjOA0FvFLqmCNAEJgN2npxeoLKWSX8EE7mZ9p0lerIHWuCi09MnH7OqoqmElrA1CrALx/w+K8qEiDTxhqAObPqZ2jtYy36vY78uNmUQIARJ96E+eBfWxV5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd/E+OcDfJSkIk7FyCmSCTr/6gAWhKE1EER20onIQ94=;
 b=XKRGZyInrxoKeGYKaBJRnjs3vHhuA5E7+IrV4/S70T7FQUvtOfSV76ixpIuqpNecnNrjeqFtfgkeJD3JjzVqT8rATrbVXeH+fX1GE+gZhPgUTt4xNod9qZuRbsJ9QmQYvMSpxNSwRuBmYzFRs3CMUc1A/ND0lvy0zzNaRdb0b6XIB2pTvnwUqvZFcdIGrN1VaN9UthWM3f/YihahtdyYWF5ADeXBgS1lsySzuq4h3Q0+kvKiwjEn0IDllXK4AitIGyCBaBfcmWax3+CPNcv/BVeixy8LP8WSYSDxAVP+q3rDDz2wX43Pi2Vl9e7LBPBFDFwZfbs+J0GAToqoiyM+ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 04:00:12 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 04:00:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 07 Apr 2026 12:59:50 +0900
Subject: [PATCH v2] gpu: nova: require little endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBREr9L8tRhKkYor72G6QArt1wgGKtE03
 F2oW5cvM/NmhWgCmginZoVgEkb0rgDbNaBn5SZDcCwMjDJBORXE4pvctXcWJ9IpepBWMCZkD2X
 xDKbEm+0y/Di+rjejl6qojRnj4sNnu0tt7f03p5a05GhFx7mUtrf07BKOqPbaP2DIOX8BS7KIA
 rkAAAA=
X-Change-ID: 20260406-fix-kconfig-3a059f622697
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DB3PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:8::42)
 To BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: d8aaab82-12e8-4647-8f41-08de945a2a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wvgtYI7LbbJG7pw/pTlcaEnBTRzuyUg22wv7Fcs5k8skSYS3EEiQNN/sUlOMf2ryqcapE+z1btg8yhSmFIt1fbPDkwSGHMovch8iVTFKZrdXtEMwGrL1j6zRzWIy8ykgEsnm6TeX9lHXKbJEW7lXkHWZXHs2eqApIjrRMEv65wpf1nqmpyJVRP3nyZU+4j/3PioPLsi24SlyifDmzGuk62ShL02z+jX0IU114ZjJF/9qW7avQxv7ne4dwGDNIz9/23gpSk7makdGwLnQWE0hQjtdeJLxugBUkiJGt8awltS9DzEzfbcXY9HCv7meTP13uKulQHKvMOR6A+5x6liUC7qUE0wIjsWViFvkRvaVN83Gfqzs8TmC9DV2MHdde3NTOAJ7AiYj8GGleASy+n5Zu76kiaDgJerYpIz8g+B6O4kJRMphFuumOvZh3sz6WcSTv2COM1L5wPn8+9mQdWnZIWbiWFgHRuBSw1lhL3cPjfLZAeitrrfjphMsqZ+5ya+KyuOxKVJ1pZsOP7VFI8KILVxa/tb/mIoKdarXNCHceg4utTa1pI/dmBTvp0qAt7KUW3k/MpFniXtpygO/1UHTqNovF5Fm6aWq7KBtodjriZNalLNm2Xjzeb9B64kSlBXaa7YKeiVhvyb+oNEYBptOFk/QGU9y1ZtRtm18Da8v7/MB9SnYz6nFUqlMbGF3Uyf9GW27zidG0oP4QBN14fHd/LRbMxkXwue1PKmDGTfoRlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllvazBMb0s0RVdiYnMvQWRhN05wcXc0TVF0ZE1qVUJaWWlWSnEySEU0amU4?=
 =?utf-8?B?eUNkL0RYb3VRWkNIN3ZLeDZpeWt4VkF5b2lWMXVpZzVxcTZ6eEk5UkxNK0VV?=
 =?utf-8?B?M3BQcE9TUExSRjhuUlNlaGlLaS9qaWxsRDZ6VkZQVWJONFdTRTNIZVN1aHZu?=
 =?utf-8?B?aHIwczZOaGZyZnJLNGFUSmtkNHBBbmVnb1Mvc0FmTVBadXgrWS90blM5c1VW?=
 =?utf-8?B?cHhKemdEeWhpOHhPTlg1dWFzWVpkai9zUVhXYnBFQ2tUMjU2YktUanh3S25y?=
 =?utf-8?B?OHUrbkRLaHdvbW5QaXQ0MGV1dGQyVWxDQ2lMc3FaRDhoK1RMVEhCcm12OU1P?=
 =?utf-8?B?M3JxZTE1cWppUC9mb0Zpa2t4S0ZyRzBIYnF4Q0Q4Q3ZYL3RwRW1qOTJDL3Zr?=
 =?utf-8?B?MXBkaUxURWlvZFErdkhpUm12dEczK2xVcDU1TjB5UTBSU3UrK1JjSUVhRmpx?=
 =?utf-8?B?bkpiMHdYUFdlWVVidFczdEhuc2RFY2UvNDljSHQvU0FBVzJMQ2QyQ1FtU2FH?=
 =?utf-8?B?L2FjeEFKcXFJdDV4M1JIYXE5cUxNVXovS2E1QnE5WWxiaXZYUDZrMjR2ek13?=
 =?utf-8?B?TkdjL1dkdDJMTjMwaVYzdnh1dmtjUlkray9VQzlxTWF5RW02Yi9TRUk5NkFL?=
 =?utf-8?B?R0xidVkzYWNuTUpQSG1qeHJjOGJUckFFS1FHcHdhbG1ic0NFUkJidkRhUHhy?=
 =?utf-8?B?UEY3YmZvcUtSQURHVHl3aVkwWTlXU3BVWmQvbk9tRFo1YTZGSnAvZEVvRTI5?=
 =?utf-8?B?am53cDN2cDY4azdTK1hZMytIUG4xeFF3UGhBVU1yU25WNFRRNkpmZEJJQkxp?=
 =?utf-8?B?TTNkUlFERFJFRnFUOW56d0dFaDBXS2IzQnlaU3pWeVVuMlVYaHIwOXQvQ1Nx?=
 =?utf-8?B?YWxhaWx3d3pnNElmVzFCdWU5MmxtekVrMWhtOXNjZng1RlpHZG5nLy83TzUr?=
 =?utf-8?B?UDYwb0FadTFyT3ZlU0FIdHFIaTEwai9Da2xsc2ZKMncyTkZOdHVab0h2OCtI?=
 =?utf-8?B?dVJILzVLT3FwTnVVS2oydDNRWVU4bVpMSU4yRzRzRU5DaFNHT2tPRm9pdVJP?=
 =?utf-8?B?Y0ZjLzRkM204SHdQbmFWWThJZ1cwRldQQ285bnR4VGR4VUtldzFOa1ltTVQy?=
 =?utf-8?B?cExBZVRmdFJiK2U4cldVM0sxQUxGOGl6Zmh1NzdyV3ZtVElCdjlxWUNOb1Jv?=
 =?utf-8?B?RTRSSEFhRWVoTDVOVkk0VGsyVitOaG1RdmNjRjFueUNpODI3cDNsTk5QVG5W?=
 =?utf-8?B?Snk1SElDMDdTUWpNVFY4WDZ0QkIzcXhGdXNXRHQ1aTk5aGxpdnJTZldFblgy?=
 =?utf-8?B?QW10TnhsU1QwbTBGS0hXQlluUExRRlpPbmJxREhHcmtvRi9mTFNzdkdIUE5I?=
 =?utf-8?B?czB4Y1pmN0xCMThlSU9hR1hLWXdINVA5YnRBOTZpNDRuVHlRbWRVTEJSWkRi?=
 =?utf-8?B?NmFRVnpMY2IvRXBiUXF0VjBpTzZpK2p5M3dXMDdwMmREbytOMEZDTjhLTWhv?=
 =?utf-8?B?MFNMV01CalNqdVZ4aGFzVHdVZG9KK3hXOFpycU5pRHFCMnRWa1ZkdUVhR2c1?=
 =?utf-8?B?NzVCMmx2T2dlSFFFTW9DVGtjWnhpZ0Z5VG52SEpTQVFPREtvS0diNkNkdzdD?=
 =?utf-8?B?OFB2VGkwVkJCTjVhK21mWUtSNTBrM3R5MWFpY2d2QzFHdE5tWURaREJxbzl5?=
 =?utf-8?B?VWNPQWQ1V2t1YWhOU3hNZFZtczNqQWNpVDFkby8yV2haSmdzTW5GN2g3NzJW?=
 =?utf-8?B?Q21RWlQrcEowbGNKODM5YVpEQ3FVR0x2Zzg0M1BRbjBkcExYMHNWWXFDRFda?=
 =?utf-8?B?WTVOTDJkVTZVOTJXc21zQS83aGV6UFFEMTR2OWYzUkx5ay9MTlZRSUF4akh0?=
 =?utf-8?B?K1l6b3E1azg2Z2gwTER0S2h4ZGR1RW9PTTBNWVlPK09qRTlLc2xJYXJZTTQy?=
 =?utf-8?B?a3RPdWZia2xqNG5VSG1GS2p5WThTL3grY0F2WC9sWmZpaEd0cXZuakNTNitZ?=
 =?utf-8?B?MWtaamVqUWFLdXVScHF6YW1IbWJMSjY1ZVNEaU9Bb2FnYVpRdGFacUlpaUZp?=
 =?utf-8?B?TWdZYStESUhjYnBKOXIzNlhEdEJNcGxBS2EzeWtjNGVrN2xTSktPRjltYm50?=
 =?utf-8?B?bWdwRi9HNnArTjlpcjRad2VVTFFPaFBLajJCRUxsdUk1VHhRWnZqYWpLQzhJ?=
 =?utf-8?B?am95RnprKzRkSkxiMTNTcnR1UFl2VWZVMnA2S3pkOWxRNXN1Tko0dWdFT214?=
 =?utf-8?B?QWYzWm9KeERmcGg2NmQ3UXN3bW5JV0xQc2xIUFVtL0x5dXk5aXVuRFcxc3Ba?=
 =?utf-8?B?cCtjSE5wSm80Mmo0NDdGQ0hJTXJ1dUdJd1pmdmFEcXZ3UGlUbGpCcExick93?=
 =?utf-8?Q?T3Q+YjHQbqjngGzlzzVUFLnewEhBYJbeOOcFYNP57JybN?=
X-MS-Exchange-AntiSpam-MessageData-1: GlrHkv1nHOIQEw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aaab82-12e8-4647-8f41-08de945a2a9b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 04:00:11.8022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdpjfNFVfIDELtmZeS3x5nYQKLGxF7r8JStBYJGPeragGrWS0qMyvSqSzZ4gNm9/UGTBHmA3Be106GKKhMkTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

The driver already assumes little endian in a lot of locations. For
example, all the code that reads RPCs out of the command queue just
directly interprets the bytes.

Make this explicit in Kconfig.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
The current code assumes little endian in a bunch of places. I think we
should either explicitly decide to be generic on endianness or explicitly
decide not to - having some handling sprinkled around in various
locations seems confusing to me.

I believe that currently e.g. `RUST` transitively depends on
!CPU_BIG_ENDIAN, so this is more about making the decision explicit for
nova-core rather than fixing any kind of hole.
---
Changes in v2:
- Also add to nova-drm (Thanks Danilo)
- Did not take Reviewed-by + Acked-by because commit changed
  substantively
- Link to v1: https://patch.msgid.link/20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com
---
 drivers/gpu/drm/nova/Kconfig  | 1 +
 drivers/gpu/nova-core/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nova/Kconfig b/drivers/gpu/drm/nova/Kconfig
index 3e637ad7b5ba..a2028b8539d7 100644
--- a/drivers/gpu/drm/nova/Kconfig
+++ b/drivers/gpu/drm/nova/Kconfig
@@ -4,6 +4,7 @@ config DRM_NOVA
 	depends on DRM=y
 	depends on PCI
 	depends on RUST
+	depends on !CPU_BIG_ENDIAN
 	select AUXILIARY_BUS
 	select NOVA_CORE
 	default n
diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index a4f2380654e2..d8456f8eaa05 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -3,6 +3,7 @@ config NOVA_CORE
 	depends on 64BIT
 	depends on PCI
 	depends on RUST
+	depends on !CPU_BIG_ENDIAN
 	select AUXILIARY_BUS
 	select RUST_FW_LOADER_ABSTRACTIONS
 	default n

---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260406-fix-kconfig-3a059f622697

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

