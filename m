Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A107C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC5F10E882;
	Mon, 10 Aug 2026 13:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uy/0N1Wo";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22EA10E882
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVuoJ9cnf+siHhXGRPFLfKQ3EitDmv0xoL9SvEkhHc6F9iopla7GjJBeDT7Kk33Xb74t6KpM9CFHzfZ1szcUbK4nwIO21M67g2SPirx6Jr+GAXzkZQHgHaRGxzIzFBu0Jx4c5HbMf7WX25nr1UoVy12EhQTCLjIV9iotDL+hbna2FApS3JQBcmVBqkJ+hv7j5jQ+qWAgdWgjrMXSi9AVSS37YZFl59SaUhZri1JUsE3urtlJS5A2WLUEGQtAtlVQBT9uTqBLJ2j1lVneKlL37/V3i7faEAYyLyRQ9KvgCjHK8DFzE0wmnioYCIQHSxQG3OAJdO8U4FnAmoYGZcYrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OEU9ssj0ixjoDI+9Hr/NYoH/pSw1QKw8a4/EbLXqT4=;
 b=gQ1Q/XqEm569Gjup/kijTRl4BSzjPTAb3hHVI23ZBfSy2jC2Gd8JUbxbJGVuVJJYCg2tlcQmWBpL4IIdYFtzVadXW9onCIx4wc9SoZwRqTvs0XCEwy0UT4cj+ZLiHzn2Jn5WT8fOqKHb7t+ky+a4y9MDTpOwn7ICHWu++1YHbVKD5lIt06Chp9GKPVGy4g1HN3BqLr7KZTEYrF1U//spXD1bTojhzVggrEfVHanWQC8FqjieDHrYB6a92HgX7thKRud+yTzgVaEffj6ztEtgbq6JRdEY1ymwe8qcRdP30Xb5UGv01XFfFwcM6xwrfrXwxpZ6mJY402fFAIWIH7zCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OEU9ssj0ixjoDI+9Hr/NYoH/pSw1QKw8a4/EbLXqT4=;
 b=Uy/0N1Wo73UBpBFuRZc0A01wxI+f6IzZY5tkraZt3dywipcJAmkLkVPyNAKeYQBFzOlrlDxHk7PYgPrPksF2SsP0xxJFxQp8KvGQu6OYsNXusANO6DHxZEBcoxRuPELo4Q9qjELo+fdbCDcF0WLQVvR7c/YPc0x6lLnwwKV5osGWbKmNAbvM1owCGQVMaCN6k71NUcHowdRTns/Rw4aVpmMdZ1IJD+e3yceCapvoTYYihhajpplvTzr9rWh8srVdtT9CrDEWPabyy2pmYh/6Fn6AfFYgHaeupUyowBoFIK+X2B5DjzrS7FLFzQgruPXXO/u05RXWjDiQyuE4MJQ5lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:57:42 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:57:42 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:23 +0900
Subject: [PATCH v2 01/12] rust: num: use const_assert! in Bounded
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a0ea8b-eac0-4b13-a67e-08def6e758e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 9t8JeuqGIM7dc8QL2nWB/M3jSti0BZzW+6V9t/MTY+vjjeqf8yw+lmQ3iVFErUzECHhDZjKPY+9P+enhjNnbAWLKhnZq0mqka4Y1Wen1TLI143fUmNLC2ZI41iF0sq5cuGNOwaV6c3l+HWzporV5LcpsCsrpitiyV4kL4x1289m8PfCNVAOyJYE66pWCVTLVgoWHRu5wtL6d78mkI/wnjMg726+xH6bSxVzU6gkQQ1ofB1GJwFcOh3e026c8mPYILqluDkrmEwsQKCCKCTrigsYr37U5UV6q+p4PcxitqwqoFyPkFX2F9n49QhEgE5BYBjG+5xBlxOpfoHq97i938EYC0L9NCwXOv07m5wlt50tlwb7b05c2gW/ncD67aAImbD4ALUgk3PbPDRaI7MndAnlEAsPsSd44HFiXVCEjNfyjgjqHMjAzk1PIguu7EIhIZ6M1yhCoE0XYS/UoOyjnOuKjIJ7hkhcVBBCZpnv+BEQDmmRYRjQljtxmE710K2bprnKr1P0Xva4hMvGjHYeYDeiG6U2HSbGFTP+kAIKFt8cEazXzZu9Tt6/Aan4lvcum6f+YyaPXdywr5CNz06WAVwznfx5zZhYTDK83425jF0/2W37H+I/+Sve6tIp+ul3fsYMxTMOjZhwdpujDbfbUaJe/YXuRxOaGa8joZ0cWPonMovHe+gUdOhgO8jNuFSHbAeMTCXOhWkCIr7xqHzYw2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXcvUC80Q01LQngwdXFzVlA2NVN6elV3TVBtVXpEVW5xWm5hdWdVL3Q0Vzdx?=
 =?utf-8?B?RmpOU3FtWENuNzgzR293NkhGbG85TTFmTVQ1dWRwM1RCNndWR2ZoY3RvQ0l1?=
 =?utf-8?B?OUI1REdmZmZpTTZZZWkyL1d6bG1OcWcwT3AvVzV2Sm1ER29va09qaHRWY0Rz?=
 =?utf-8?B?UnJ6MktQNjRMQXJDaHk5cnl4NDJoUGtzL0RPWHRaK2sybFgxY1NHem5yamth?=
 =?utf-8?B?bkN6TFBkUDFhcEl5MHNTelVzTGdHWGEzWUNpRWc4L3V2WmVOTFJwRW03a0kv?=
 =?utf-8?B?M1lLakEzMmtlWkFoVHR4NkFQckxrc294VTE5MlFieVhjTUticU51dTl0ZFNs?=
 =?utf-8?B?U003ZEhTaEtFS0xDR2hSK0xtRXZqQVlrRmRhNHpQcXFHOVY2MGJiUGlBZzNX?=
 =?utf-8?B?YVhDRnRmYkF1UUM0Y2pTY0h6c1gvMEN4dndIRkZBTUNzbzN5dEsxdWgyd0FC?=
 =?utf-8?B?QTVRMERHNUpId2tPRzA1Y00rTGptdit6Umw1Y2dLa0laNlJydXVNbGNIeXR6?=
 =?utf-8?B?S2ptdTJQUGF6TnR3c2RveS9pMVZqdmlxSmZMVmExN1haRFcwRkxBTFhJMjlw?=
 =?utf-8?B?Y1RvbmhUK0UvQlJtdkZWTngzVDNMY3dvRi8wS1ljQjU1bElDYUc1bi8yRW1X?=
 =?utf-8?B?dVRwZHF1bkMzRVNtVFVCOW9jUzliNTEydXYzS2xCNzFjUk5ZUFBJalZNYUtw?=
 =?utf-8?B?WFhvWmxKZktiSVVvSXR4K09OVHl6dmRxaHNNL1AvbTdLQi9ZWmlVUzZQUW5Z?=
 =?utf-8?B?RFduaUJ0Tk1QdFp4MzQ4REdYTFRKcFE5OVVyZDErRzBhN0ptbENZbUZoUzJo?=
 =?utf-8?B?NmpiUGQ3elBEL05EbnZ2ZndMOCs4Z3N6c3BoV3FEOUd2a3lJZHZGVEJGbnkw?=
 =?utf-8?B?RU0rV1hLbm1UTGQwVndTZ29YVlRESU5IN1Z3dDNlRGJ6cURXRWVaRzRRU3lz?=
 =?utf-8?B?TExIRENzVUFiczdEa2pQYTJuL3duaHlRSWpoNzFaejZzNU9ZcHcxVERxQ2Ev?=
 =?utf-8?B?djR3VkROZXUxSXRDejgrMEZleTNzZlNzZW45MFpqcWM4QjBpTm1NUVZuUXI1?=
 =?utf-8?B?SGJxeldWSzlqVlNnWFRSQkNHZm1kZEYzaDdKRXErTUpDRm1Wd3prUmp2V1Br?=
 =?utf-8?B?dUNyM0FHLy82Ymh6MTcrZXFWdEJxV3JHUUhueUI1dGY1Z3dNZTI2OEdZVGF0?=
 =?utf-8?B?Zm9ORHEwOHowZ2kyYklXV1dhUFA3YWE5RmRGQWFWa0JDbFdWN2tuUVpBRVVO?=
 =?utf-8?B?dGs3TDJ3dGxEMndmNy80VHhlSnY5M3Q2eXk1NG1Dc28zOWF1anpnSWFWc2ww?=
 =?utf-8?B?RTVxSHFUYXhDQkpEYWZURzZHaEVZZXBnMUF1QWloQlNmQWwyblY5eTBVa2ZW?=
 =?utf-8?B?S0pFRG1EOWVLQ1R2VE81RCtZNDRkT1JVOVJYOGFCdVVyNitsNG9zdGYvN1R4?=
 =?utf-8?B?VGJoMHE1NUlKdWg4MktyaXBJdVZ5R2ZiZU5xdmtlVzdhNmxDWnVVYnhmMWg0?=
 =?utf-8?B?R1o5dm9LRnBuZ3RDN0NzRHlFUW1ENG5mWXZnZE4rV1BDb2dkWjZFZG0xSXlE?=
 =?utf-8?B?Qmg5VWkxOTBpSVVjQ3Bhek9RZFNmYWtFeXlDQi9sb0ViVjZldzIxN0V5Y1Z1?=
 =?utf-8?B?TVdDQUovVGxvSXlIMUtzSzRURktmaUlRWVlYMEdhQVNVbE1halkyV1dOR3Fy?=
 =?utf-8?B?N0t5QldORDhUcHh4Z1FtU1orMkRja3NqR1VlcDFxYTRJRWxlVHU5dGZWQlVG?=
 =?utf-8?B?TXBnT25kWkFHQkpLdnVDWW5QUzFXZmVIMDRaLzlNNTlGdGZ6c0VJQitZU01K?=
 =?utf-8?B?K1k0RXdySGdlRnd4dHNTaWpWWVE0YmlKNDRqaWwzL1M3ekZLVjl0TmlhV2xV?=
 =?utf-8?B?UVNDdHdlUzdCdWJHZEp4SllJQm84bzNZcjdKZzFSQ0pCRzRoSERycnZDQlBy?=
 =?utf-8?B?NW50eUhySUJCVDBmbEVTeWRGOURYQUMra2djNmZMSTVGUU9CbnZrL1JMWEd5?=
 =?utf-8?B?dlpWNWtMNExwSHdIb3psYTZnOVlEdHJnNkFMVFNKdktjcHVxRkFuZTExZWZt?=
 =?utf-8?B?YjJ4OWxTVEFVeUVvZzNMa1FVblhDVXF4UTRobVVnTXhTYno2WFlWN21ka3JK?=
 =?utf-8?B?ZnRaUm5uSU9WdkZCWFlVNXlqY2lRbXdGZFN3aEJMdm51Zk1vRG13a3JOR2I5?=
 =?utf-8?B?Z0x0ZW5WanIvSllCZmovb1hzQWpSUHBwbWY3L0xCYlJzVTVDWEVzdVpTVmoz?=
 =?utf-8?B?V2x4cnN0SVA3SXA2Njd6NnpaSWw2TnQ4R09MMXo5TVhyNmRaWU9LNFRvQWsr?=
 =?utf-8?B?QVdUcjRYVDJIV25Zb0ZFbkxxM2xwSSs1dUhyTTBubFIvZlNpV0pvb0JJQVdl?=
 =?utf-8?Q?2ulEEtzXZONhHTlkfQHtMcTP0ydkaYpUwx5TFC6Y3eoUS?=
X-MS-Exchange-AntiSpam-MessageData-1: 8JivVh5hW/d44Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a0ea8b-eac0-4b13-a67e-08def6e758e4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:57:42.3826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR05NA2JRYVIm56f8rEaHecn7no1r5nfQsjPKpoW9ObHksR7kBZV9hXauo3Z80tAqmnDTK7U3qLfwsHfGs1Nfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

Convert the const-block asserts in bounded.rs to const_assert!,
matching the rest of the file.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num/bounded.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index dafe77782d79..9ad7df1a243d 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -485,7 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
     /// assert_eq!(v_shifted.get(), 0xff);
     /// ```
     pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
-        const { assert!(RES + SHIFT >= N) }
+        const_assert!(RES + SHIFT >= N);
 
         // SAFETY: We shift the value right by `SHIFT`, reducing the number of bits needed to
         // represent the shifted value by as much, and just asserted that `RES >= N - SHIFT`.
@@ -506,7 +506,7 @@ pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
     /// assert_eq!(v_shifted.get(), 0xff00);
     /// ```
     pub fn shl<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
-        const { assert!(RES >= N + SHIFT) }
+        const_assert!(RES >= N + SHIFT);
 
         // SAFETY: We shift the value left by `SHIFT`, augmenting the number of bits needed to
         // represent the shifted value by as much, and just asserted that `RES >= N + SHIFT`.

-- 
2.55.0

