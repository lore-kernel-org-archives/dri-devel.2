Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6D606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dMoGaZzJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E197C10EB98;
	Tue, 20 Oct 2026 10:08:55 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C5A10EB98
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW6CpJrWlAYnQqFoTcsUUbfsHPQK6vE3wPUVxRB0O5NItEX9ShEkI/lA1K6LFWDdB/KzqsOxlEDqMXHNoqpT6M+M2c8K0AA5487q/Pw/NexUJko795RhmKQ1OlIUhELNvRUfynlzDjBczSL7/Fj806EPmYIBkXLHnk+iMeygUvdsFay4XJCoLTAwc+Ocuc0SJoUYE8yZYzXNg+5j5XFGmdZrCSqQMEmb7z18Iyrcd4yqoKBJ3BNB3Q1t3+UqQQO0sYnw6f1fwi4aiLskUHOJtYDPp47t6tAmhabnUpoGHPZslFAIShR5miiwzEHsUl1ciewk14ATfrDOdaKxiDu3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUMYTBfo1Bxb83xVJVk2CRhyXR9Jn0p3/zHpRZ1IRIE=;
 b=Unn8Ukq3BhnNCZQiUjLGeJgGPNl09WP9OO2Aqc9MxxdByP0B23kPWW0yVyKzN0EIXMiLaxqmioNuSQogprvax4GgXJptspqIwW0N11OLANPDmBubqhyBS54mQnK1S1zuLQ4egMp/e75ej2bbGd3837W1HXGmEMQHvjcBzRCKvP5vSkrUwfzNg5Z/9yZ2+03B03fST8k9Xf8DdFDuSOLNuhaE4KZNGNKpIR8gpqkkTXX3cuaGL7KZtAtgWuSuB23ignU1lENjva2sWAaz8oQTwtw1lkhhyWu3WP6Tf787nyHdYzTJJGwKk3CnCXHRY/qJtd7rBkUDJ4hQrfubQSxb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMYTBfo1Bxb83xVJVk2CRhyXR9Jn0p3/zHpRZ1IRIE=;
 b=dMoGaZzJ+Wupi9e8r8nn2iXh9hh/IGZeqqqS693xtKDMaqZYIU9xC9kztPyCJa4VU2WJzcKrlaKXJ6JU6DvSEGRvPR/AAM2LZ0oV6+ajCm4MX4rJtIQ1KfOc/RTXU2e2VQWhiJ74TUsGDleBWWDppLpriJNxe2fxUzK40EWucA3Y4l5NT1pKYEcxo4eBcR6K7LUZFV0YwTvkbr91TFAKd0mCnby3jcvOBGGxQxJg5VfIgWVA9M5jQnwCeHcI7ThctG61aqgd7MJ1IJwBk8Whfh5kqVq41BfcaMab80yHlrdCA6wl6zgFYXJgmGIWF9XmnbwDwsGOEqqP33NYkWjwTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB754991.namprd12.prod.outlook.com (2603:10b6:8:4d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:08:38 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:38 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:24 +0900
Subject: [PATCH v5 03/14] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-3-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB754991:EE_
X-MS-Office365-Filtering-Correlation-Id: 94109c94-3847-479d-9a2d-08df2e921bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|11063799006|261009223027099003|10067099003|11062099010|18002099003|22082099003|7136999003;
X-Microsoft-Antispam-Message-Info: TTZE4WOequsUtfhP74Lwhea+ItiW8B8VTsF1la3Ph3NoStuki60J1+CX0XjhSAboum81efdw9n/xvTOxJz3Ky2IbUxAr3KFTYSxXSqBtF9T2GLoLyxEj7SyZtRuDjTs8+tML9qHiJe3+zVt5NWgJpZ7DEYgeoA+pq9GMjnQfLR2x+bWMu3sHoshbIRk6KWlr1l/707lFlh2Mbkz6pf30mOBzsG6g+8sAE7xdSmnWpk/QDhIAJq9UCP7ozNtLv9YEF3RDywSAEBKoVwXv7/J2bTLTveQSsW3GDQq73riz0Gp5T07JGgEpwmpWLd93XbYq2eF1o4iVIHfQ5az0cDzOjVnReImE75cuX1ifmwfi3+FkXWlGJaeXPJA1LFtwB935+bN6Bdt78S+klj/Rm/hddS/X3gmopdZXbLpwel8FLNlOq159zzVQt3X2K0hf5qeeWyfWMilkvivMLb0ZLMhV6fJjE+kAgsv3sUWBHv2l2zysZDgGO6xGBbOSU9z9vTg5FdpXa0L5iAkFGcAVmGa40Z3P8G48UI+elaLdN9fYb8ibzifQkrhI2nl2YyPWyAVZ+zvGn1hHSQEeLLT7kBzH8PW3K09WwnhiQ628NW4dNj4u3EHUz9OyOod73BXc3m31y93HAsBCbdDNmsLQVezl9fusuJOhOxzs20JVOQcJMyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(11062099010)(18002099003)(22082099003)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFF6c2loUlkxbXIxQ1NaVG4rN3Z6Z2pFYkhCMmFYTzNvRkFVTys2NkJ6M1NZ?=
 =?utf-8?B?L0VHL29hODZ4Sm5QU1ZENXNWRURBenlkeGtFODMrbzduWmp6UXduZmV3QzlJ?=
 =?utf-8?B?VEhyMU1rcWEwYnpuWWNtaVlmWDhHS3ErdzNxL0JsUjlhbTMrWDRPNm1XWGto?=
 =?utf-8?B?VEM2dmtXQVFmVlRNbnhlbVBGNG1pSFdNbGhMMzlET00wdGNtQ2E3SE9ZV25Q?=
 =?utf-8?B?VjJFMWVLQU9td25YY0tDeGhxcXc0Nkt3eGJubFlSK01TektnVS9ERTJ6RFZV?=
 =?utf-8?B?Wjl3NW05eGxWSmhsNGVEVFN4UFJ4QU5Ed1lGZWtrdFNFbDBEbHVpQ0MwRnRL?=
 =?utf-8?B?TFAxNVZuWlBxM0RDNVMzV3JLMExvQURWbVQvUi9qS013Z0xKUHVUMzhiZmgx?=
 =?utf-8?B?QTBhejVDbytGTGlxaE43MkdjSTRxRHpHeHZXNFhranhPREZ6WDVWZTdIbHZJ?=
 =?utf-8?B?cTNKMjJBaXNrNFcyT05hR2lWaVEyL00vVzUvamJpWU9rL0lXT0RxeU1BazJ2?=
 =?utf-8?B?Zjd0by9tVVdNK2NReGw0ZXJFMFBQV0JtUS9MSVpZVkVSUW1TaGhpdHQ4Mmt6?=
 =?utf-8?B?dnBZU25KOU85VTBLaDJFN0RuMEl4VzVhMnhJYWFoRkpmeUtxSHNjRXVqSStm?=
 =?utf-8?B?NjJCTk9tcnJEOE1pYmRrNDNhd3ByWFlvemhoN3FtajFjTVRsSi94ejUxUU1o?=
 =?utf-8?B?TFg0c1dPbXNncmhJWXdSMzN0dWV4VVZrVTFpQ3c5L1NrZmZsQlF2Wk52bHFJ?=
 =?utf-8?B?T0ZYTTNiVkhGb1h1aUx1Z3QxMlVMSVhIYkpjSmdrL3grbE5jZkgvNmxHTmFJ?=
 =?utf-8?B?TVo4NVdTK0U2Yi9ydzM1bklKNlAyT1lnK042OFFWZVFxeE9QdXFZYnR4b0R5?=
 =?utf-8?B?Y29EOG8zZXhmSnpleUVtZjJFWFNRZHRWUGhkc1JsS3ZNSkNQNWs0ME1PS2lP?=
 =?utf-8?B?Sm8wT2tCRnQ0cUs3SXpxN3dtQkdMNkFaSEJobEtRUGZlR3BKM3pUMUlaNU9p?=
 =?utf-8?B?bnd4cUx3NmZaSENiUzFBTDVMMWQ4YzBrUUpueFhwOG4xaGtnVk1WcGtLTWhW?=
 =?utf-8?B?YWZNNCtrdjFnajY3ZkNUeVFodk9ER0t3NWJvcG5mYlZVNmlmK0VZRU03b2VO?=
 =?utf-8?B?b0QyUUp4VHJaalhqZ1pKVkw4Qmk5OHRlWjlpdStjVGhwYUxJbWxUbFpNdDVX?=
 =?utf-8?B?VHJIWnV6VFlqS2FOVE0ya0hNRlRuS2dqVm1wNlVpeFEvV3ZjWkgwWFNUSkE5?=
 =?utf-8?B?WWlVcEZSSEI0NzZhd1pmVk1HNHN3ZVpKdHlaUCtnL2RIS212SVFnSzNiOUhi?=
 =?utf-8?B?VEozc3htUHFNWFlyWjBNZitjVHh3OGY0aUJRNkwvMmU3UW5sWGUyQzd6QThI?=
 =?utf-8?B?bVBuYTZya2t2WEJlRHZ6Qnc4a2lsWnJONktFU2tIVTYxZElwTEpTWXRRWW9J?=
 =?utf-8?B?a29vTmxZd3NqUkZ3TktIVWlRY1IyWUNuVGFob1F2T3FwWHNwRmVFVnM3eFFr?=
 =?utf-8?B?UGhBWDFtbC9sdmVNbDdLYnpjWEthNk5SZHdwYkhWYmJVMmx3N1hJMUgzeXow?=
 =?utf-8?B?azl0YVc0SmQ5UDVJci9JRHROS1h4WlArSWQ1UllidlBnQWl2M3JYdXBHeTZq?=
 =?utf-8?B?WnVRZ1pNbkpQZnZUN25FRjJNN2plQ0EzL3NBK3plZjE5WUx2bm1lWEswMXJ4?=
 =?utf-8?B?eDhSeTZDUG1RRWpQdGxQQXVjUFh2S29GUG1mamxscXhCZ0FIMnVzWXRra2hT?=
 =?utf-8?B?dzRFZFprZEJqeHZFWlM5a0w3QnFCR0liT01tRXF1OU1aVHV2TUJUMDBDTVMx?=
 =?utf-8?B?OG05T1A4a2VDM3VYM0JteHVla0drSHhzczkrMlNKQ1Q2SWoyeEhVc04zUTB3?=
 =?utf-8?B?aU9pM0s4OTNjb3FadVNRYi9Kam04alhwNGNGUi9JVGhwbHJKK3ltRHFMa2xN?=
 =?utf-8?B?N2MvTTR1TEowdGIweURjbHJlS3lqL2pvcjMrbkxDY0FoNnN2ZjZrVnp1VEhT?=
 =?utf-8?B?RGtXLytPSmlmTWxtRkhaUGphRUd1Wm9wdk1JZUQyY1UvNEhsODEwUnA2U3I4?=
 =?utf-8?B?bmFXSFBGeEJ2K2lDUFI4N0I2UUpjTk1UMEN4U0dqLzJqSE9ZcmV5SW0ybnU4?=
 =?utf-8?B?VzcyejRPcS95VndGdmJOdU1xL1luTDMybzFtSFFvYmQ4MHI3THpoQm0wMGVq?=
 =?utf-8?B?TXFmeWg3Q25hNnFmTG1HMituWHZYaUlweW5OKzRSd0xwNlRtenk5cnRUWHRa?=
 =?utf-8?B?aGJtM0FwUWZpTEQvK3lneFdGYStReE5Sc1NLdE0vMGRLazdRbE5TUnBpS2Iz?=
 =?utf-8?B?czFhOVAwZkUwTkxVYXRWdUJrWEIzQmRndjZCdmdDc2ZsRlF4R2tXMUl1S1ZF?=
 =?utf-8?Q?KMw8C1xQmE7zEKAQVdaXQgDBgnglBlMbRafv+x7M/NiDz?=
X-MS-Exchange-AntiSpam-MessageData-1: Q2Pri6guhYrp2Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94109c94-3847-479d-9a2d-08df2e921bf0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:38.0037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0LH5VkpYJB1Ulg7cEK3aLzDIAFkhEDtQAnSsxtkKa2cmB7/dKvwOPQRS0tx5HVeAvQNsD7HGJcFJa1VNxT7Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB754991
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1bd15fc0aef2..0c18a586576c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -789,6 +789,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Extract the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
 
+        // Validate checksum after truncating the message to its exact length.
+        if Cmdq::calculate_checksum(
+            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take(header.length()),
+        ) != 0
+        {
+            dev_err!(&self.dev, "GSP receive: bad checksum\n");
+            return Err(EIO);
+        }
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
@@ -817,21 +826,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
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
2.56.0

