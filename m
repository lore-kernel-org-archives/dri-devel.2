Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBFFC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2346010E475;
	Sun, 27 Sep 2026 11:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYvLwxdt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C5610E55E
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbKx4ihZ/Y+mIO7ApOhGONKyoBX/FADqZz1jsqy9VeL1cu/PjptCJg0a+7snlowujf3AeY3YAV3OZdbKB4BgGDngzi/RHZAya0TkmD6pg5iq6iPZF0/neCrlgjgEiFoz4Gv3emtMEKO9Rr5fC/OfBfmnb6KcgO9gewYprw4g7UQmdJP3MrWqiyf1bU/9V5TZ7eQXGdQBxllh/iS2lAuktOhGmPWV9oLSDaDxS2JeiV98P+L3H5ji+WeiJ5qOmmnXrkylxslz+YnHPS+jm0NkgrQfctRd70xltw5EuPIQcHPtTqeI9o9jjuIwUNsRoWu9PZtNn5kzuxZw0M3zAWN6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsCBU9w9ifY7i1KeS+7mWR5+649tBphJ0vwt9BF8jCQ=;
 b=STvwUIRn15yuHfL2+NnX3AOGlEbMej5gkT8bZZFOFx+g5pJoP2pWT88f5g2Xn75uZH6VWuHlLTPGYL4BOMQIR6EOpWjbiBc6ofQhJ3cabtGIaSVGSXsVy3VInsb7IRnU1W1Q/ek2gt9MEP0vO6mIiibvULf5tpkM6NcvJQhKw4vkFjqGJLc6IzdRRjNqvgVajqhXLd3EmGCstMKpj663mVDPI9equcCFLr6o4W6j2t7qLKaBip/T+wMzR6lbhJGCB2e6QVN8huOWGT0wPjzgMsr0ncqhxEKnS3BpIvMmIOXj817HLd4hjmMoxOCmkSMiP0Dv8wrYUcUf7EpgKKU9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsCBU9w9ifY7i1KeS+7mWR5+649tBphJ0vwt9BF8jCQ=;
 b=YYvLwxdtwe4saII3Cu2G+aRTnKxEG+EWA4bc/I1ykVyer7AqhDNZW3tDALS1MDmFNGn9qDkDlu/ArZgM+oOGoQcX6yUeDSf+cV6KyYBw5oIXYrSD18dLwpQmZ2eWmGEE8javkAAixfP8AqPr4ZRRlkp7yDMWk0IjAoUbnjtWZ6o1jseYcJMEWOhlHlMFxI5OP3cBH76d+qzifgzFEY7DY21565SCTxtIPVzmMqWPyw0bQ0Zij5+kP+y0y1HrR9kAsnsX4lpMyIzfCrpmKwTopPP8VJYBgmW42AmHOD4cMbbHZJJgbhlBb9v5LIisYei18TmiAHRVYy3sDNxxC59wyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:33 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:24 +0900
Subject: [PATCH 02/10] gpu: nova-core: gsp: cmdq: validate checksum earlier
 on receive
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-2-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0345.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 534e968e-ecbd-43c8-b7c5-08df1c88820d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|7136999003|22082099003|18002099003|11062099010|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hhcFhcPU35i8Vy3FgEReGXBIWGgOTOB4oqoQ2+VqRQ3APZKroNZazvYTrnPMS68WfcI96LhhtQfd8dvPMl5LiHA1WqK/fACS7uD7WEnDDWtnL4z120v+7iOe8aGw7XylOkni70XN8fOPuxdCdnd/WegVKRjg1r1q1uCMgEVQvZ22RBJ3D6rrp1xLj+FGiIYpFJKeUtQCCjY2Xf3EOzv9BpqgVCNJ7mmh5vkneOEBj1GSD6mgFG3qG8s5GoN2hY1bXLyLKt2yP4ztkKzQTm8+d5XjxF/uzAok+OKV4LdFOTpNIDM9IXr5VwE7T8iEManuTBjy7tv0TTHVzdvnhpTr5O5Wjk1r08QG9pabqCBzqlq2nmun00tNWUfxv2qp3GfHXC/L6IY1c/zeJhWiQTyEpNvVKsLglNtif8NWe8YZxc8HI+Mc5FNBNEYdR+2gkLHHiE5R/yRKeIumZJW/YfqyBSMarKMDx5PTpdVJLWnqUPe5L6pL/gWg+JEIuiFOformbz4KYIjPlbPsy/O09bN30jAMeQESfitCd2RbXdDPbLMvXrrM0ExJc9gopHWA9SvnDwVrOEpnL6XtjMIl05AfJtOI2DGSh/DT1iuB27FATGXwv1pQ9kBuEgIN80BeVWlJtSipHKWtOgCKrMwlueg9NlpgKzEzSdGFiFnxSAH5XIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(7136999003)(22082099003)(18002099003)(11062099010)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRGdk5ZSVc2VkN1R0k0UE9wdWlLUlExRGNabWZnanRiOC91MUVPV25DbCsw?=
 =?utf-8?B?RzN2QU9qVjAwOXJXZHNsY1dJZkJvV3BWd0xNQ0pNV1Q2WTI5alJETHRzbnBl?=
 =?utf-8?B?Q3h1ZmJkSHF0ZkRIR29hZ2NBOE5UdnVibklkNjNZWHF0SUUwVEpWVENwbzBG?=
 =?utf-8?B?ZE1oQVhPNXZDVUlxOGJPbmRTOFN2Rmk3MGV6c25Mb0x1N013Tm1MQ2NKaDhD?=
 =?utf-8?B?N2JsVGh1ZXZwbmpwclpzbUxsbXc2MCtmMTk2Ym1nQWxUQnE1N2FWaEg1L0Zv?=
 =?utf-8?B?YXlsOHZFekdFblRjRExUb3BYSFcyR0FaRFd2dnI4MW9IY0pVL1F5R2FISk5S?=
 =?utf-8?B?aVloUUloT2lWNW9lMUNVQlRHQVFrRktWbkkwbUJ1VzRQcmI0dkE5Y0hTYkxu?=
 =?utf-8?B?Z0hCRElpOUtMWnZzSFQvUVYvbnYxUW1xNDlXQ09vcHd5cFRzNnJWRUlZNkVx?=
 =?utf-8?B?WDlnSWZiOTVaVFNYUm5JNTZBSkRLdk90Zk1JNnNCazdWNGtWRXZwSlQxVG9O?=
 =?utf-8?B?eFZ2dGE4Qkx3b0ZZSFJFWHpPNWtXbEc2cS82VWphcW5oMDVjOWpiU01wY3Vx?=
 =?utf-8?B?N21qdGpGUEtqVGVRd2dXL3hkeE5PVjVRZ3VteGlQa216aDlJajYwYlZWNHl4?=
 =?utf-8?B?K0QrUUQ1TGtQSndTMXlDN1NVQ1NhUUp6dkdrN2kwaDRQNVcwTHRmUWFLdk1z?=
 =?utf-8?B?czViNXcvYTlrWkFXWm5RbUJLWlBRZjVXWGI2ajdzaWF5WENQdjZvRkVmUkc2?=
 =?utf-8?B?VUNhS0JOUGFnejVYTzhuSUxuNDZvM1RDSXJQQlZVTnk4eHVkQy9KeGtaclIx?=
 =?utf-8?B?Wi9IVmlvM1FxM1kvTDJSMTJvaUlnMFFaVldaNWljL1o1YzhOcVUrRHJHMk11?=
 =?utf-8?B?Rm9pcy9DK2xJaUh4cUM5VEpKS3kvMjlEaWVOTW4waVpzQnA3VTFHb3dBaDNz?=
 =?utf-8?B?OWkveHFIQlRVMHdpYkZqVCthMkJjcWR1ajZtek5icHg0L29CbWNoWXU0bXVC?=
 =?utf-8?B?ZXNld20rbG45TStiRWVlY1h1N0Qwb1ZydW9yVHc0ZXBobWlsNGtVSndxdkc0?=
 =?utf-8?B?aGJoNXR0djBDMEp5ZEZoZEswbVluWHZJREt0Q044eFkxMTBOMHBlMnJqM0RO?=
 =?utf-8?B?R0dFeTVXbDB0UUNDUXVzUldOd3FkRHY2Q3JhUWJ2aWJRQlFDZy85RkpJdmJ1?=
 =?utf-8?B?VlBjaXRUWVhNY2lZbUdDcStDbmhKbUIvNjIvR2FOc1d4N2VMeHFuR0dUMjky?=
 =?utf-8?B?MU8rbkkxUW8zOTRvR09IZE85emx4R25ETDJEWlNVT2RwcVlsVW82OTUrUHFL?=
 =?utf-8?B?YkJyY0l3blB2blJjQ0lBNlV2Q3FUdlJCdEc3T1Eva2lOZzhseS92Tm5Db0xk?=
 =?utf-8?B?djZjd050clFyYWdSZSsybFpmTFRMRXBJcHl4STIxME9JWGs4ZWhMcG83TmFo?=
 =?utf-8?B?akRBeU9aMlNrb0pmdXVYbkNmd0hzUHNnbGlTblcvMUx5M2IyZFZTUzJ5L3FH?=
 =?utf-8?B?N3JDb0Qyelh6dUxPOGFwWlgvY1l2aGtxOHpVQk9Ea1RYTWFVaEhYWTN5TUlH?=
 =?utf-8?B?M2QwM2ZEc2c2UGZ3YVdXM1pjSUNMbWVTdXMrV0t6cmFpbWd0OW05c2hNamtU?=
 =?utf-8?B?a2ExSllrMmlhR1diTEdXMjRpRVhqWVNkamVUQmtQSC81NmtUOFg4ODNxVGYy?=
 =?utf-8?B?dTJ0dHFJRVJETFBWYklEeHg2bmEvWTVCUUVyZTlDYVJvczI0R0RZM0haYVEx?=
 =?utf-8?B?VXpDdHdlQjI2aWZXdGVEN2U2L2pEQTMrbkVQTGI4bTcrL29CbWtSTHQ2SG8x?=
 =?utf-8?B?R0tkQnNEaHhid21GWTUrcVJEOXpBeXMvbHNaR1hNVjRKOGd3THhOZi9zZDRN?=
 =?utf-8?B?a1hoR0tsejJrejljdDRadDhkTUphNmhvNUNNWjJzRDlxY2lBTlB2TmwzUkZt?=
 =?utf-8?B?Z2U0TG9vNXc3VmRBVzZlWno1ZDlwSHZQWDNvUG9uODFZT2JqMUFyZ0VHWjdk?=
 =?utf-8?B?cGNwNlgwbEtUdngxQmxKV25FZ0J3NXBaMnp4dkYzd2RPcUJBbUtRenZ3RG5S?=
 =?utf-8?B?dkczVkIzNDVxWUFRQWtXVlk0elRoZittUEtGTm9OTTB5YnVnQTJaSDBFd3lk?=
 =?utf-8?B?aCtmbnZCR3I2cEIyN21vMnFJbjdvenpaOU80d0gzUnZsVmEwNUtZL3QwMFh5?=
 =?utf-8?B?QjA5WFBHemthalRJbVV3dllnTVJ2REkyN2xZdUplSmw1TWE5TDdnNzJNdENw?=
 =?utf-8?B?a1U5aHZZVTBmUXFhb0tLVmdiQkRCTFNqUTJsM2tYcEtuSFNrUGdvSTkwSklB?=
 =?utf-8?B?RGZIN2lOV3B0bjVaWjdsaVNyNlFZcGRrck56SkpYMldXaEJ4UTRPNW1xRXda?=
 =?utf-8?Q?ZYoAePC5CvIcpbgSqNfXggZHfQYengIyjInpipzEdmNBf?=
X-MS-Exchange-AntiSpam-MessageData-1: yrhoamyDdEM5Zw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e968e-ecbd-43c8-b7c5-08df1c88820d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:33.5159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PD8OjNCYQLlXL/H8ZtLNfpsUOcqLGR2QpEYF5QgR2f0SowC7T7Ee3OLTPM8wZYlUYthnlv/wde+hzvjsC42eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

The checksum validation error message of `wait_for_msg` prints the
message's sequence number before validating the checksum.

But the checksum is part of the transport layer, and it not validating
indicates a corruption that could very well be in the RPC message
header, meaning the value of this field cannot be trusted.

Furthermore, the transport layer is not supposed to know the kind of
message it transports, and it accessing the RPC header is a layering
violation.

Thus, move the checksum validation before we start looking at the
message header, and drop that information from the error message.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 9285fd796f9d..08a49450bca0 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -768,6 +768,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Extract the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
 
+        // Validate checksum.
+        if Cmdq::calculate_checksum(SBufferIter::new_reader([
+            header.as_bytes(),
+            slice_1,
+            slice_2,
+        ])) != 0
+        {
+            dev_err!(&self.dev, "GSP receive: bad checksum\n");
+            return Err(EIO);
+        }
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
@@ -796,21 +807,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             )
         };
 
-        // Validate checksum.
-        if Cmdq::calculate_checksum(SBufferIter::new_reader([
-            header.as_bytes(),
-            slice_1,
-            slice_2,
-        ])) != 0
-        {
-            dev_err!(
-                &self.dev,
-                "GSP RPC: receive: Call {} - bad checksum\n",
-                header.sequence()
-            );
-            return Err(EIO);
-        }
-
         Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),

-- 
2.55.0

