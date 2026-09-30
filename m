Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B118CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D2010F454;
	Wed, 30 Sep 2026 14:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubNz3YrL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E452410F430
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cReaCo9dU9xM2z94H//vsYV2cLij63xCePNtOL2mpQjvLBG+kOyIsuEbelcYj8rt2YlQb79Q0KIdGtr8ROBb8qgWVnyhN/LdX6dsJ+Ds6ilQ80pe1T4hEOvntgOy40otZMCSzxe97dwBERiZ2dpnKN9ZHAVS7IFNYbsc8p6kJIt5Dy3nEEN87ihDcOgOc7jfrkDLWAfnJxJG78bMtJWMg83SzOdppSXZivAeDM8eeNn0JA7IuBHBUezlx1MKccbkv+FdcuzFX2cYguh2NX3ZE0S5bci+jjcgakpsgeOkC0MqxG43d65gmCtQkiHnRRmaacVnkKOuPxxDleu+TkFXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVOseAKsk04fSRwpKmGT2GI/z1dw5Ge+0k84GYH/uCU=;
 b=m2a1ZekJ9c9yKvqVOn/eOHk9/Bk5hUuM/4OE1JuKU4Ao/D+49HHpzJrsB32J5ZzDbc79DSM3trTSTkwCMKFcX3XbqnLnzELmy8cOYX7066HRmI70ZhtSs0f9wdxF1jyx6F/kuUcKZHDgVSExMYCTKr4DwOJxNlyigoe9OGYc5nWiKqbvlxgquU7rxRGQH8WY0dIXoQqeCrSKFSTBjixBzm+xYG2rJ3ZpteltRTPNgSm7aPGy22yfXvFPeTxHOpxIANQ2A48XItRLkaesNXAa5x+htF1RnRug9v4TIpYENIWW6KSSsnluwYEGy4ISMcT4uwPhqPebzwlc8+GV/bid7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVOseAKsk04fSRwpKmGT2GI/z1dw5Ge+0k84GYH/uCU=;
 b=ubNz3YrL8RZ9IsmXQ7aU+PHncgxPiYYfYQgY4BuKLzn43WPslCDt3yr4WDk99+I/WdY0r8NXcts+4+WjrD88vxhSSUXcA98NMGG+XyEJRpXm3Y4eEjAYRS6cXs+VvWgDCYyMrNCsj5ulsN7288S3iyx9b0OPSukLFzFstr9AAwwcslJFkxrqJL+s5vQn2QVJPMIp8uTsIN/tHk3CoeJZhy8HTqCSOhkqYFwisXCVnpAJ0bVu8VdGaqf6615gckqYF+XUFJ1COBGJQTHaSnov/Tn0dUcB9L4MrtHz8RrPDyPGqQgYVT0lGhgzLMbXkTOCEJypakXYVXlAdclHPOnisw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:42 +0900
Subject: [PATCH v3 3/9] gpu: nova-core: gsp: cmdq: group the RPC-specific
 part of send_single_command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-3-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e4e612-b6e1-40d2-0bf3-08df1f03172e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5vf4oAjooyLUTS7nJ69GEBVnLO3tFov+qiR2rD9MSfb0OHRspzNtQvdqz+ttW6FH7aG/V5ItQpwJeKUOiXMoaPxw3Z6qf/mIcpfuHOVm00Hs3coSPG2QwR86n5uEQZlJsL4f1l+YBYlvnE48NLxCR2it/ibga3kw9gU0RSnm61Hcmrl2usHgG4dNAGoF02RBG+eirC7t69j/+UOFDkhwcMOIiGLpQII4PNPNVs4H3lLwsRXGoOJPV2G5YDC+Hw/t3EbmFBA8yzB23TJvP7j0LZpBJMrwtoHtTAv/mGGBRILgnjQTde7NvTOzYsijgtNOyJMa4T5dSr+G3CEpST5htO7tw+gqMQF44W8hgKU6UKJi8vT2teKpQD7z0o0Fc6dUi5xatEyecFDoYSEFTDMUYlmAvrHLikfUHEU+vavqjRBLFyOxGQ73C2YiNTbzqFbzqtL4+QoK0ESJeLh9jVxDQWu/9C+zo3AtxtJSDmyswWneVvpI5cDpcUhQ/UkXwTZI7W5OoQUa0Vn5A1tWcXUbYHgxDnTgufctYlYb5+F0oG5o8CMwBqitr3iURRfeVMrOVq2oKNc6xk59PrB4TDvSEPhVrfH35NyuRNkozkkv4S6ENWVdObHTZ5ZxlQkFsmj2pnRc/37oeRc/9x6B7r4j8u+iQCsxvAA/gyPmL64FV+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VxMmhaWkhQbE53ZW9lWWNDc1I2MWg1cTk1WUNaY2xFbVA2UnAxUEg5T3Fn?=
 =?utf-8?B?Q3pVVEVvRm5vakNlSkwweFhueDdqSnVETzNFdXJUOU5mckpOSDZxcGhEU043?=
 =?utf-8?B?NUIzbU5YU1lBRVZGOWlTMVUrK3Z2Sk1SaTUyOC9LU1d1M3p6RVl0eWtYQWN2?=
 =?utf-8?B?dTFuZ0pzbzJXWW1Ka1FQWDFDaDBaT09wU1B4a0VKV0syY0YrNHlUQ3pFM2hD?=
 =?utf-8?B?amwwVFAxWktKbjNXR2dmV1JMbEFGVnVQbkk2MGRpZW03b1VrU2NMeEV5ZG1z?=
 =?utf-8?B?c0VPU3g0WUVsdzdsNzNaSkx1YjZSL3pvQ29RaE1CaGtRTUVnUkgveGlXbm1U?=
 =?utf-8?B?NG92ZEtyVHFuczA5aTVFQndBd3FHNjJnRCtLNExBY1FzR1Z1M2ZBbkdCMkVM?=
 =?utf-8?B?dnQyczRMMGEzUVBSOEYwcER0TnhyVFhaZmYwRmVxVWt4amdQL0lMVVdUc0F2?=
 =?utf-8?B?cDdNZVV3TWJ6Vlh0VkFvMXpieU9HQkNPekdSWTVjUjRMZVJXRjM0RVdLd3la?=
 =?utf-8?B?bmNDcVZpa0VxYk5LTUFTelNEQkIrUm9jYmhJUm9WSE5Ea09nRCtJNE10b3F0?=
 =?utf-8?B?bHI5MmhqK0gzVG15OWprV3dvQ1U1bVI1QnQxU01iRFhLbksyRkp0YkliaE1H?=
 =?utf-8?B?NFBhV2dEd0p4UlhaY0NvL240TENZcXE0bWtCV1hlWE9sMkgxSHJhcGl3cEZN?=
 =?utf-8?B?MHF2UkdPUW0vMFBReDNJdjliZTUxZTRlMXhGUUw1cTdacXIrQWdqTVNOeksy?=
 =?utf-8?B?QUlzMmUrTkdKU3FHZTdFQmFFN3BXOC9mYjlKNWU4NU9wVXkzWjdodTkzdWJV?=
 =?utf-8?B?RzRoOEpEQlhINHVrbmcvZ08xQTRaMWgzSGhncFFQdndSZ3htOHVVRm9FNEZV?=
 =?utf-8?B?alp4d0xiODlUby9hM3orV3NJTlQwaFFZTXBHOStERlNTdE81c0VSZUFVQ0sz?=
 =?utf-8?B?Q21PbDFnem8yLzRGOXM0T2FkaVlpMitQaStxMUYxRW5ueXpMbFpMWVhocURJ?=
 =?utf-8?B?UDRlYWI5K1phazJIdEhWWTArYTlRb1gxQ3NLSTF0QTFOTFJmaFhrSzlqY2M5?=
 =?utf-8?B?TFFtVE1vaTlGUTA0aFg5bjk3WnpCUFVUS1BwOWdUSk42Ly9zS2lJdTBDa2tG?=
 =?utf-8?B?U0dIdm5oNENQOXhNN2N4ZlRPaHJsckxqRHFOQjkxaFZETjJTY1djYmhpMUNW?=
 =?utf-8?B?QzJDdUJJVFJCWTFyVmRjdm9mMEIxbHNDRDBYNStLZWJSbG1Md0Jzd1p0SW5K?=
 =?utf-8?B?TlRqMXdmMnBRcEN4YVhVTVBWZmd3K21aNFMvcHJpVGo5aDRJbHZBazF2OHcr?=
 =?utf-8?B?dDNsN0FCWHBDbFh6VExnZFBJeUlLZ01CY2xTVDdNRGRiSkNBSGdrT1I1WE4x?=
 =?utf-8?B?M2NPRmFLckhNTk9vTGFjTDEzUDRXYjNQRXRxcnVrWWY4a0N3bTY2NkNTbFlw?=
 =?utf-8?B?UGdlbnc1NGJ3RlY5a1p2R2ttWjdHUVVtUjAyMS9Mc210MkUvdU9iL0lOWkJl?=
 =?utf-8?B?SlBTM0JCZTRoZEZWeWdWTWQ0b3llazRGcnVXRjdJL3BFK2FnZnpvNmgrU2pJ?=
 =?utf-8?B?bWg3bzVxWnMyelpOSzZIWVltR3doTEF0WW5KdVhCVk1TWmNBdVBsOUFTSCty?=
 =?utf-8?B?Y2xqeXhUVGNJbmgxTDJUb3BlVjl6a1Z4WktxdElINyt5dUMxR2kyUUFYNW1a?=
 =?utf-8?B?azBpeTFReWZKd1ZQVXEvMWs5bkE2Ynh1Z1JTZXpvL2VnbkI5UGZnZCtPNlo4?=
 =?utf-8?B?dnE1aGdOcW9FZUlSN2pESFZrTnBnRjJFbUdHMzVpVGIwT1FvQXd5NkZvZER3?=
 =?utf-8?B?MlBqVHBzRytLTklCSzFDNUJDRXNGLy9IUzBNM2M0YkUwZWRJL3l1STIzRHoy?=
 =?utf-8?B?a0ZnWHllZG5LZVFycU1mMGo1ZTBGcjVaZHo0S3N3ekxYR20wWjB3RFJ6ZjR6?=
 =?utf-8?B?S2tVV0ZQdlpnS3FSMytWRWJYRUVpdnQyR1ZaYXFWMWhEN3ZjR1lGY1BvR2NS?=
 =?utf-8?B?ZnZaUzhFMW4xZjRuM0NkQ1hWNVpwOU5TbHFQcUxDRVNYN2Q4VzJ5aEViNlZh?=
 =?utf-8?B?TnN0NFIyWWJhcVc0MGZMMjQzbjBYbCtNWHZybWlNREluK3RPNmhVUjRqaHIz?=
 =?utf-8?B?bU1lVUg1OXVLM1RHWFN5djZFSzdSTmNBVjNjL2tOUkNwcGFmVW9vZkt1Yk1y?=
 =?utf-8?B?NjE0RzJpdmxCM0Fib3R2N3cvazIwQ2NENmNOdzEzdzZQR0QzSUpvVWhWWkpN?=
 =?utf-8?B?UU9UUFNMZWc1OW5pN0ZxRW95YlRiRy9wTDdEc20xWnpkOGd4U09TOGVTN0xR?=
 =?utf-8?B?MkZvdGxnYTJURGt6THVmaWpockdRdXJVNDY3K1VQdEtzQ2x4d0lsRk8vVHRR?=
 =?utf-8?Q?DwvxB1W9Zy7yMtIQEbocFvzoNDNS9CWNYnORDhp6iOuan?=
X-MS-Exchange-AntiSpam-MessageData-1: 6QuY0GBtGtV9KQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e4e612-b6e1-40d2-0bf3-08df1f03172e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:04.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7vQKv4SacJsWmYKflTjhIl6ThMM6qFaLlxGON0VZ0Y4aKe5jGDXB/oIXap4V0cva9oXoTcmNLJOt3+LKa6YMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

`send_single_command` handles both the transport and message layers of
the command, intertwining the logic of the two.

Reorder the code so the message layer logic is within the same
contiguous block of code, so it can easily be moved.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index b40d45bf0a92..bda79f23626d 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -659,18 +659,18 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
-        // Extract area for the command itself. The GSP message header and the command header
-        // together are guaranteed to fit entirely into a single page, so it's ok to only look
-        // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-
-        // Fill the header and command in-place.
+        // Fill the header.
         let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
-        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
         // SAFETY: `dst.header` is a valid reference, and is not touched if the initializer fails.
         unsafe {
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
+
+        // Extract area for the command itself. The GSP message header and the command header
+        // together are guaranteed to fit entirely into a single page, so it's ok to only look
+        // at `dst.contents.0` here.
+        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
         // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
         // initializer fails.
         unsafe {
@@ -693,14 +693,6 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         }
         drop(sbuffer);
 
-        // Compute checksum now that the whole message is ready.
-        dst.header
-            .set_checksum(Cmdq::calculate_checksum(SBufferIter::new_reader([
-                dst.header.as_bytes(),
-                dst.contents.0,
-                dst.contents.1,
-            ])));
-
         dev_dbg!(
             &self.dev,
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
@@ -709,6 +701,14 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             size_in_bytes,
         );
 
+        // Compute checksum now that the whole message is ready.
+        dst.header
+            .set_checksum(Cmdq::calculate_checksum(SBufferIter::new_reader([
+                dst.header.as_bytes(),
+                dst.contents.0,
+                dst.contents.1,
+            ])));
+
         // All set - update the write pointer and inform the GSP of the new command.
         let elem_count = dst.header.element_count();
         self.seq += 1;

-- 
2.55.0

