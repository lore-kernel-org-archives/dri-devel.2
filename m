Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A2F9EDD1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3F510EA0A;
	Wed, 22 Apr 2026 13:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6qXfBRE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0E210EA0A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMNjdg0y0e0BKnHM0YQZU6Mp5/VvvKKoKKid3FqRNLz2W98xBVYm+jWarDqjwWFihKw/arhOJxZlyyPGYakD1KmCeBkNtAkXw20j6XI9Hqrm+SMzBbcNsukSHlYWMuXjYSJ1WmlDQoEdjvhhsZrbmrhmoX/lr0X5YCtBQGGyyF+JLouDntfZs+VzQeTqHRzuevTWRzt239kuSYQHnzVuPURT4mV1t4yor4XsloMpzB4O58scyL8NC4jFp64UsIQs2wYodTeCCbS09s8sEKKU6KACjHI+k8QkDkt3ZvOvi/qK0U6sfFtAXpO/WETcM42bOLQ8K71TEWkj959LQJT8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqiGqQxZe4rTMJ2YqaEkwki7AbVhCs3yw9p3h/46i5I=;
 b=oLgB8Hu9q97yxEY0fIeVa5AFoxoXrLZFlZoE9gPxmgXBI2M3ydQZ3JSdotfX+dr14VwNBk/uyO0h6Npn65LqB3fZiPxRUqmgm0uWZFi3UPz+za9074GqK8SeuOjn6isPJOAdoIMECVVpDElhNJU3b3F7RwtRuvCmWhmHpbLwoEdYheyUlsiE/rQ6sZ821Inj7us6TQ1NBFCbWQOt5bFCC42OBnRCjpfTrtFTL7Isb9a98cTpZnnCxm6VJChgDEyB8SZ1vBA8Ov6QzjePp31UKQg9qEDEGSkugioLUKCSrvY01J0vbmuwxoEKBmL5bGBSAOm1FluDBN3IV7yc52ChyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqiGqQxZe4rTMJ2YqaEkwki7AbVhCs3yw9p3h/46i5I=;
 b=V6qXfBREwYGqitqgdDAUlXKfFV+ZzfdbORkmVkwY0YLUS00Mveipj4UdHxDyegpGpyc7h/uEBcpGjrbtiun4Mipp/UD8Av2OQahsKVkjdtmXqo5HrKyB38KOXa21wNKMLnjb9yLdF0IuTI6caxpBeH1fDSKH34BssxDJQ4jko+/5cDzUWvn26Uq6y84PCPpu7F6CPz4HlWlvSu2lhF2WKQw2t5QJSMj4Q2GbrlttfZXGd9vokMj0LYDy2Cvqm+a0/3SDhHITJfsrk6AdSEmbtqCPXyn1G3T0MG9h70I81m1AxK9LmFQlaaYOmHOTQUhT867jc7J1ZHRGkWqhzE9G7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:41:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:41:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Apr 2026 22:40:51 +0900
Subject: [PATCH v3 1/6] rust: add warn_on_err macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-nova-unload-v3-1-1d2c81bd3ced@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: feb2347c-a2c8-4c90-b76f-08dea074cb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8EMUahyddUPtl2Fry76Q7uFonK1UKoDhSNQcDeQYd0wvQKwcETguvw+SZab0p0yw3bAVd8Eq55wrQJ2KU/doMvxbB6wRqE/bvijZCbV3d5cTYOFn/mxBoRBZQEBaj+hKeEwNsw+pYK/mfoYwB1lGVO9mSK+ihj50ptbaZynQCdXsfooNSVhAhcy0VffoUBmO1D0kfA+ou9ifpl6ibpA0nbNF1e0XzchaTQ9iPGfOelcwFVxY+7sAlysAqVit+uZpWfVQCrz9X1iGaITNrEsGnshg4gwTSiPTjoaipvcHEadATRbCzVSlNt33fsNXGsP9MIf0+OsZf0oSIgnvFqBq4w3ihxTZjtQDXoiaaJPNRuZT6FeWhdbFvhrxD64+8lp/GLxMjABTzUMCp2azOEBwGvTkeXo73T7gCJo/mw/0GNwvG6cXQgWGhzuW5Vj113hBrvlZo0qjOsfYSYZQU4k9lII/jnpxM0aeLMjSVVmziS79Jt05EMa78eV5bnKjD1wYROTj6QjoVJJGauWXdKpvGpl70ATru1FOH5DaZnRB+EXfqzgNI0mQOxxHHYGWNW5Zk3ehwnj6CJHDrE7VpXcTm7jGNZaN92XytCtGLW3S/N2dC1bc0CwktI5oB3oqgf49UDDXPUKoEF7gBtp/m6bL8VW3hiiy4/Hq26NwctOy+UT4yewV/bVXFFFMGBEirh531lX898Aqijm5tm1ycK/cffwX+7HLFM3uHI5eaOmgkhSisT3JmhiPZArWpQfMGnNNV0sd+eLdMdt5YXxhGP6fgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVHV1k1WlB5QjhsWjZxcmlXbjR1Z1d0MktJL2xYa1dYa29ISEFpamN5K0wy?=
 =?utf-8?B?cDZ4QTBzMXdSZUNkUkxhbk8xWUpWVEgxVUMxZm1pVGc1M2E4R1laeEhKaVd5?=
 =?utf-8?B?ZTVNelJmbnJCeFJmdy81UkZFYzFBbGhuTzBLZHh4T2dYTC9nei9nY0liMW9C?=
 =?utf-8?B?TjR6RTMrUHltS1hMTU9ZbnlacHYyYW9YREdDalh2MDNadzJRMHJKNlgwYTFK?=
 =?utf-8?B?djA5UzE1ckhVbmVSQ2RZaE4yV3FWNkVvb3pHQlBXR0pXaU1tUDY2S0w0cEVZ?=
 =?utf-8?B?UnlEVHllR1JlblJBZlAvVGNrSDgwSVJhdGdRVjNpdXU3MjJ0V0x5U2w4cS9p?=
 =?utf-8?B?U3p1YW1CMVZwbGhyNjQ1U3pYMk5DQjVsWjZ1RFp4ZWxkQkZ0UUMwb2M1LzFz?=
 =?utf-8?B?L29XMFFNQTIrZFFVa1JlMjFhZFRnTFBTcWxmWWxYcWR4NGZmVk11RG5RMHdY?=
 =?utf-8?B?QjBuaE1ORk1FbTIxbXBsM09ON0ZvTTJQNG10Y21HdUd4Z2RUZExjbEx2MDc1?=
 =?utf-8?B?bjdubGRXZlRjWHdsYkRGOG0rM01sMnVCTEQ1bzc5TVZWT2pFcDVUVVgyVUFB?=
 =?utf-8?B?bjRnTWhYTXRFWStSeUlySW1FY2pISjRvMGZLOS9hRjVkQ3VTYUVCNDVlclBw?=
 =?utf-8?B?dEliSGhQMGtZK3NydFk0aS9CZlpwaDlUeTRndG1vQ2VJMXJaNGtRaExXR3F1?=
 =?utf-8?B?VExuc3BCc0pOOEhxbURxT3NwSmRZVitVd1pERG9YWkpoaUluVHZob2xuemlt?=
 =?utf-8?B?cEY5R2EzaGJKYnZDZTVVd2p0K1NvVUdtK0xLeU9DVjFESUZRZVlxQktyU01I?=
 =?utf-8?B?Yzd1eVY5YjdzYVJudnNMVFJlSWZkcUZyUVdvK2J1ekIybERCSTlDbUQ5T1pP?=
 =?utf-8?B?OGx0ZUQrMWMwNFRTOUhJa1NnczRyRW84ZldlRjZMbHdneGtzK1VpOVpxUkRN?=
 =?utf-8?B?eWFSZEcwODFReSsrVnZqa3J1aTV3WG4xUTJtUXRqQllDRWdYWUJHV21naUF4?=
 =?utf-8?B?b1pDa1RGbnFsZWt5NnhQS1YvTzBTellWdFExZ3kxKy9IT0dpUDQyMHdZUy9N?=
 =?utf-8?B?U3BYdEw0L01ZR1ZScGxHOHdCQnpDRWozNFBMRFQxUDQ1cVlzZUd3ZTV2UjBr?=
 =?utf-8?B?ZGwrN2V5VEFoNHdzbFVHK0czVmtpMWNCSzZaajF1b1lGWWhVejRITzVFUkk4?=
 =?utf-8?B?QlNwTHdQdi9BVmZFNjR3b2hzLzVPb2hwaEpJWEoycDNONk5jNW4zUTdlMnRO?=
 =?utf-8?B?d0tQMUVnVFY5b2pZK29XOWhSbERxbC9YSWJSaWpqdzVBSEFIbU1jaVhnbFZU?=
 =?utf-8?B?VTYzc1dGekxqNUp2VldiaEg4TlM0WERqcDdLLzc4ck9ibFgzMVBtNnZTUXps?=
 =?utf-8?B?Rm1qY2lKd0hJdVcrNjFKUU4yKzJqSmM0QXppL0g2V1BXQ1VZQ3g2c1FuVUlK?=
 =?utf-8?B?alVrQmYrRk9BazJ4aGNEcVBUWjc4V3cwYjlxL0Y5QmRsVUdpK21lYklJK0hK?=
 =?utf-8?B?SDRQaVBPbU1nVUJIZll6ZGc1aXlKZVUvZDBtekxlTmExdnJWVURuWHVTZjFv?=
 =?utf-8?B?QUM4TURiVjBCZ2lRaXNmdDA2VHMvUEc2STM1WUdrZVRVNXM0dU8xczBlaG1W?=
 =?utf-8?B?cVBtQ2FxcU03UDc5THF0b1hqdkkyTVFEakJBNmhZTndPTVFnekpidEM3QnI0?=
 =?utf-8?B?NCt4N2RPbUJTbmwxUG1VSmk2b3BsYjdTdlBqcU9KYjErSE9jZ1kyc2NtQzUx?=
 =?utf-8?B?cDkzT0tFZ2ZKU2dwcjRTbTg2VDdjY1BFeFNLMHgwRDB0YkFWVytRYVliUDlJ?=
 =?utf-8?B?RWhmUkJYZkExWVkrdmxqcER1UUtqTmVaVHpnZTRBcnRsVVJidEM4RDdVSVFK?=
 =?utf-8?B?MjZuT09ZY08wOW16Sk5KbW15Y1RWOGxPWm5OY3NZL3BNSS84YjJCckx6Ry9p?=
 =?utf-8?B?R0h2c1UydXp6MGNkSit1QTJTcFNNR1ljckdIL0ZQWDF6c210UG84TmtHdEJs?=
 =?utf-8?B?OWRZczNCVVRONjlXa3JCRTlFNUFRS2tkYnIza2FVbkE4QnVtN2tuTFVxdHJB?=
 =?utf-8?B?ei9peXNQcWRwNjhNZ3V5QXlKOC9Zazg0TXpZK0U5RFN6amlDWW1pK0QxM1Ri?=
 =?utf-8?B?S0JVSUI4RU9sd0xublJZRmFLNFo1Tmw1Mm5rbWtZSzArTHhyRUdoRW1NUlBT?=
 =?utf-8?B?TUZqblg5Mk1tU1FaUkh5cUlOWVNmMUlTWmhxVjZTVXg1d0FxZzg5VXRHUk5G?=
 =?utf-8?B?OWdBVTZ0eTVTKytEMEtLbzBUYzZ2dDBXdjhuSjFJOVRpZndQcW9PcVYzR3ly?=
 =?utf-8?B?Und5LzMwM0NvK0tIV2RmOGt1Wk92WDhLRFdhNUZzRVFzVThhcERwc2dtbnZU?=
 =?utf-8?Q?aenMCzu6KAwtoKyLGW/K2XXBOUo1/jYhmG4QJCitbgMn/?=
X-MS-Exchange-AntiSpam-MessageData-1: /HznuY9sRaySlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb2347c-a2c8-4c90-b76f-08dea074cb5c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:41:02.3528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XrFpqmII0kpgY7vjbtmnt/rUu3LeTME9OlPjS+ZTlAS1NKH0hfNl7Wr1g9kRtfr/Mk9K40Qu1vKfbHAAFKWIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

While we already have the `warn_on` macro, a common usage pattern in
Rust is to check whether a `Result` is an error. Add a helper macro that
allows this.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bug.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index ed943960f851..c5809c554da7 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -130,3 +130,13 @@ macro_rules! warn_on {
         cond
     }};
 }
+
+/// Report a warning if `res` is an error and return `res` unmodified.
+#[macro_export]
+macro_rules! warn_on_err {
+    ($res:expr) => {{
+        let res = $res;
+        let _ = $crate::warn_on!(res.is_err());
+        res
+    }};
+}

-- 
2.53.0

