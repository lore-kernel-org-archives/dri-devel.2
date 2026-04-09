Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6835F31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1077510E7FF;
	Thu,  9 Apr 2026 14:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXni+thx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B72610E7FF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4K4KdBeLw1St2Yto7N8uIZPmvkUEkOsju/UjgfenTwiDPrggu69DoYzBxy8wJ7qQbC6R9n1QQ37D3V0DxXlGep48SqMXVFOr4+ZXozF3YVgJU8G+juVtF74gV3FAZFpkBHhL78js651RARe9yWMwc0hAcuyFQTsfYtvhMGIsLHeilNQZ6RtpbfXwjhXc5e7Mbjwe5OOys+F7HVoPq8J48Uney6/4IyFNlX00BuJDV4RvXarBUPcPkM14U5POHoYFtIV64wW5B7LGNuO9l5zNo8c0kVVBQFQ73kWWjidwNNGqhBLI7w1VnuW45XUby8VhEi2V27BthSwNt031nJKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTBKEZMvz12b1ftS1ZuX8EGWQ4lsbRBrkkC8HJQLQZs=;
 b=eMGReogO4luiHOF1O7RUgPRuE2ccalyyAIevRynqlLFJ/qO8AMbAKxsaNk+FSvRRdQ4DLDtz48tFqoaiULK+JWhmC//xjgXTJVRWWByi0MegCnwRAfZJTVHBRTQyzay5WJ1OQQCGrOOu/4SntQcmN1NEhAegkO/ofMuBWNoNHP1Od3pJElOmZKwgbtWwqTzgXWOT+gFQvDUSk9zcNmM9pqdj0Xom/sfblFpQaqvWysTqg6fThUmL1hvDK00P86h5nohuxmq5qWOL5spFN6IcfSd30dggJmDsQnvmyesYHItlkAbjLsEHInEYF4WJMr7Hme+trH+Ft7sC2MufO+JdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTBKEZMvz12b1ftS1ZuX8EGWQ4lsbRBrkkC8HJQLQZs=;
 b=eXni+thxKkUQEBn5GLNalX9SPcyYSzTXboUz30G9MxlspzMWfaTd7WKfL76gvkAz6KRXeFGoxeg40AnjG2Nmi+JO+utdkDvPxPveRaNDuhMLRoc7hOUeoI90mZtQPZVRV0ghlikyoSUglNkEKclkPGILOLKiHsOlBugR8L4WKCQOWxi0VrYfV1XqIFJLFfK4p7A3NYri1UwTbPSnh12ifamBz1IFsxGki/VDEgYKw67kUunsC53WC+4R2Zhs+nsTWo95jgkL7UH1Sc0aRcfnSg6m+kjyZECWKBzVlnLpFJLOF6QpOwCOOtuR8Vr1h3THAgN/Sjwfm01f8SeXT2LRRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 14:20:00 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:20:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 09 Apr 2026 23:19:39 +0900
Subject: [PATCH 1/3] gpu: nova-core: fsp: wait to consume message before
 sending another
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-blackwell-unload-v1-1-0f5a2ff838dd@nvidia.com>
References: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
In-Reply-To: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0a73c2-1791-4984-7e7f-08de964315c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: e1015yBEHt0hZBXfVwasdxx8sC5Tcq2V2I2uvEpj8DIms7baUVyMQEOdTgN1wlUpAr3AhezAIYSHDnvs9v55Q2Ys/MTrIB2xaYzJBlNYwGKK+nSaKK3jveyVxqSckvhtCtyndE4E3hlRXgHay2v/TdqkZZiw4SbGtkZq9S1Q5Kfjf3YMWyvebuoRf5EsG5TjChiBBZp4xa7w4P7b3DjKsQAkwKaSQW0hB28WPb+15p4b0uSaAv2ZVO3vIGZIBeVg1P9Vh3qbesxjL6WWEet6LGy5sccWpskphUvOKqtE3bmbHDDcVznWMxFoANbGZ9EcGkM6Xyn+EDId1KQk9iH4yTpftuIcoI+Jtcpot4EVmtGt01FytsezfN+AXy0+9j9zQpu5StQQCjL75meQJayEpEpB7Fvcn9oNA/Bn0RMdoFtUkXzQcmFA7ZN7u/4KCO3RB3HTz+2NQpk2SlmO1lyxRSPZWbEGdqzTWF1uqtGpsfFu1aDaOsGeJruS+3MFtU0xthTypKK0ByMC0lV6z7aBlX7HnqHvLe27mYao5SJBdgbDm8wpDT87E0OXrGtus/A9UVohGx7ITguWG2PQ2fvHfoQTIZyXBjJ/IUizDCOT0escAWl93Gm4m7o+tokRKXOPgQasd1wqt+vTVfv+MH2LvnZQ9iuRbR65s6lvzy0xkY1n7Xr6TIj0Lv8ebIr0TzXuDwe7M3GemcvaoOhs1q9Eh8PFZkK54fJjyySa2CZDCHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tVdXhWelJDL3NkYzdvNnovRy9pRnR2SmRMYWJ1QUUrM0NPcm1mMjhkSVlZ?=
 =?utf-8?B?V2ZDRjg5NWNxL2Nqb3QvN09QcmsxTldOOUtuU1JaaDJkYk9tVGlOYzFEWmhC?=
 =?utf-8?B?TzhuM1VQaXovWDNvVDBCeDlEU3hObHdwMENaVGxLUW1WdzBnWEFXZFZiTUlo?=
 =?utf-8?B?UXNqd1EzeFlXd2QyTzh3bFJzMk5TWEgvWW1iY3dscGRxUjlyb2RhTTZxTExj?=
 =?utf-8?B?TUVybXRaZFcweUp4SlMxb2RNM3FnVE5uRkdrRUZLZ1pjc0FvdkpVUUo0czZR?=
 =?utf-8?B?WHdBZFMybkJvaFZBS2hlR3oxZm1ndTFWUFJQbnFqRUMydDlvWTRiVy84VVVY?=
 =?utf-8?B?WmJFa0ZLMGFVcmw1VWttL1lsK3o0NjMvdDdyZ1ptSUxnaXhOMSttNUtsaE9p?=
 =?utf-8?B?cGFBWGYzWDRSUEdSaFNjUnlqVHkvMTZLL3pJaW9BdFNPbCsvZHZ6OEN4aHMx?=
 =?utf-8?B?RUZuOG5mcHV5akpkT1MzWE95RkJxVE9rS1dPSlMwVlJ0eVZGQ3o1RDBxdGo3?=
 =?utf-8?B?Qy9BVERWcjhseGFWYU1FMlNNL1VxQkNvZ1RyMXYvNGFqMDB1M1hTWUJOYlln?=
 =?utf-8?B?MjBzTk5nTk9hTG54ZFJSM0JhSFZCdzJyZ1pQWDFCVUNHeDBJWTJtT2VMUU44?=
 =?utf-8?B?dlpYd0JkUGcyS0t0SEJvbzIzRktWQ2VyNWJJQVlYbE9FUGlMcGZMUEpOZXAz?=
 =?utf-8?B?c1lMa0dzb3pXVXliL1FiM2xhN0lBdThacGh1MkNlSUw0Wmk2am80K25YeUNH?=
 =?utf-8?B?OFEvdUYxdW5kSjUzcVlwa0x1dWJMR3NwMlVqRGRvV3Q0Ri81MHFDaFYrSHlG?=
 =?utf-8?B?Wkx5UmRndzVlK0p6eXl3RjM5d1BzVTBHenJIVllHcUtJc0ZMaDlUTU5pK2RP?=
 =?utf-8?B?dkg1SDNndDZCMlFjMk5kRENmL1RyN1J0eWFpOVlESDY4SGl4K0NPUURaZzYv?=
 =?utf-8?B?Q3VRVERNTUJScFo3M3BwQU0xRTMyS3VFUEZCbitXOXY5WFhXbHZoTjNWZE5s?=
 =?utf-8?B?RHhUb1picW9RVEJqcG81TzNDWXE0Zk8wSGgvajZmUU5OZmljNVNQQk9mblpD?=
 =?utf-8?B?SmRDOTJJMzRhSUpZalVoQ3E3MWVFbmVtSkVyNzNNdDVhdjZsVVJzbHdMdCtt?=
 =?utf-8?B?MFAzR3ZvbW9ZN0lVVXFTUDZFYUhmdXNQRXdnSTU0dEFFYk53WUdLT0JLc2Jz?=
 =?utf-8?B?My9DS2c2VmlXMlVOUzg4cGh4RWNZR1VoS3NNSWF3Rm9EYVdaZ2tnNU45VzFJ?=
 =?utf-8?B?REdmZGMrWFNlYVVSVFVXVk92V1JiNG9aT2laalpiZ2ozVDM4d0Q4L2dQS08r?=
 =?utf-8?B?bTF0UWhxMGhhbDJuV045R1U2L3RiQ0dPYVRxZ1UzN0xWWm5hcllZY1BZNk9Z?=
 =?utf-8?B?Yi9SNGoxbXlUWlpDWENJanB6cTV5NEFpeUtEZ3ZYL1NUcmlhZEtsUFlKdW9N?=
 =?utf-8?B?NGoxczVoZmkrWmdhQXVlMnE2Nkh0T3JpU0llanNoVlh3Y1RtQ2paKzhPZVdu?=
 =?utf-8?B?eXVpSU9PeDBjRHNob3NWakJueWhWWkdnOWtYMnd4RC8xL2c2dzJQZWZ3eVQz?=
 =?utf-8?B?UEF0cGc3UEtiL01WcU1UVXpyNmtmbmtHRW9xeHI5QzhIcmRiaWY3cGplTDVl?=
 =?utf-8?B?NEJzV1lxWGFLRHgwTkVNZ2JXV2M3QnZDcVRTN0hCUERqWHNJdjBvV1J6aitp?=
 =?utf-8?B?S3VlV2hxQlVhd0ErbE1SaHp6YjBzaDhpeTdPVi9ydTVEN0hxOW9hVllwdkVD?=
 =?utf-8?B?cHhLQi8xREFzZGpjVm1NOWVKYjRFVFhlWjRmVFh1dUpCOHRCeUFJYXJqNHF5?=
 =?utf-8?B?dmR2K0tvV1dLL3lrN1JSM2NBZS93N2ZSVDBYZnBpb1R2WFBxQnFnMVhmbm0x?=
 =?utf-8?B?bmZROU5pcnQrMlVDYXhwbWw0S2hpL0lDNXA3dWJPa0RIMWZUMlY2WTBlR3FZ?=
 =?utf-8?B?MFR6bDBsd2RoMnNhak1DS1VHU3A5VWpaSml6djdXcjc0YVBzYkx2Zy81TEFk?=
 =?utf-8?B?M3NMSVhaQXllZEhOT1dKWHRmR0c5ZVZYSm5Fd0ZkWksrSS9FSlpMeXkrVlJW?=
 =?utf-8?B?ZzM3YUthbEpRZjF2Q0Ftd2tZT0IzMW96Y0RjYWhyYlNDOHoweDV5Rmx0SVdw?=
 =?utf-8?B?S0VJd0VsUHliTzMwV3hZS3c4NlhRU2VrYkdHVjJDNmJLQU5vL0p1Q0VlNE1m?=
 =?utf-8?B?Z3RPbnA0RXRtOVFqc212dkV4enYva1M3bUhDSE1ubk9haElnSWZ3Vm1xNllN?=
 =?utf-8?B?bzNObWRWWDdrMm1UeUVqUjlpTlA4OHRld05UV2VvQjI5SzRTeUh2ZWdNU0I3?=
 =?utf-8?B?UjY3cHE0R2doekRQVkFtaElzSjdVcDFBNktjTFRHeDM5Z1B1UG1ndzlBSy9Z?=
 =?utf-8?Q?ZtVIjQ4hJJFRSkUC8NkgZdAuRyavjZzrjjHBporCEKXTg?=
X-MS-Exchange-AntiSpam-MessageData-1: 8MkmMTeAgS9Uzw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0a73c2-1791-4984-7e7f-08de964315c2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:20:00.6338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30mAjxV4VjNWHOSbgZVFXbwOqjP5EyQ0OAYdv+XOoC6xZYpp2++QHaVatGxVz2sOnT8HotUhqFVTdUhULEfgwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

FSP can only get one message at a time, so make sure it has consumed the
previous one before trying to give it another.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index f618a681ff28..1497f163806e 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -7,12 +7,14 @@
 
 use kernel::{
     io::{
+        poll::read_poll_timeout,
         register::WithBase,
         Io,
         IoCapable, //
     },
     num::Bounded,
-    prelude::*, //
+    prelude::*,
+    time::Delta, //
 };
 
 use kernel::io::register::RegisterBase;
@@ -186,6 +188,18 @@ pub(crate) fn send_msg(&self, bar: &Bar0, packet: &[u8]) -> Result {
             return Err(EINVAL);
         }
 
+        // Wait for FSP to consume any previous message before sending.
+        read_poll_timeout(
+            || {
+                let head = bar.read(regs::NV_PFSP_QUEUE_HEAD).address().get();
+                let tail = bar.read(regs::NV_PFSP_QUEUE_TAIL).address().get();
+                Ok(head == tail)
+            },
+            |&ready| ready,
+            Delta::from_millis(1),
+            Delta::from_secs(2),
+        )?;
+
         // Write message to EMEM at offset 0 (validates 4-byte alignment)
         self.write_emem(bar, 0, packet)?;
 

-- 
2.53.0

