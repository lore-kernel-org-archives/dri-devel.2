Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE90C4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CA010E75E;
	Tue, 21 Jul 2026 11:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaaDbZaA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE74410E74B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQzwC2ow9M1ADSg9ZC3aUDc8hnbBbq0dnPVleEIxewkUNSBES/0YYVqqhXAGykNL9U+tOXqezTi3kfHxTOSa5Q12XGA36MWbZ3f9D2GFVFHZ3dd45cFBzSlEf7pF8FgvpL2eOfa82bLdcGImdgEwQdjFSrnSvKUp85GlS9BTP3ibDqYWgD4o37jLICt/idle+GeOtoREg1reztY7AgDfyCW9C7bxjfCcXZ1s5iyi78qi7nt+XZSvF0qw53RjkG0f4OxS4EBYyC/G4oBCGkq1kMkzDDs9RR7d/pktdyIMFgbd+x8IpUWpCJmM28ND/g8n3ReZ+E+llKQFDY8brL8dCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDlH+YVH8tHI+csmJ/+plzj8sveApw79WjimdUzy+qE=;
 b=WZ0QQ4NHqR41LloScsBpFGZ8Z8Ho/1VOw9Xy2enxi52+13PSPC8hHsumZZKyqctwfcxiEjz1G1cmVdAC1EX1Lkp/spJkv+k/eslAHpli02R+8Bc7kAS+6kfH94gBt64CAyg+ft8VeTl0d/wNnCH0tqwR5c0+LmFVVVN7dDGK5+/grCD9jobWLn/hgKXpqF9d4HM2jxpfU4oS+Mu8wXj8gqVFGE2Ugg62duuuIw65YgYkrkglu8K9PPuKaiyy+yXqXTjD7rr20plmo/vjiq/KF0Xvg0MWnGFMwJFglk+QJILwRmyWqHSUqS+s7k2IkyFzrc8lSmTLh367+jNIdoe0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDlH+YVH8tHI+csmJ/+plzj8sveApw79WjimdUzy+qE=;
 b=kaaDbZaACaWGYoWe/shF+cLa/l/45KOedkkp7IlxPFfyGfIlen5bnZVfPOhuyLC0XM7Xx1ZMRbCmA3jNclIuPrNKNr8/Fie/443OrxHRVo19AkDkQC+KeA+ui0jVXegiL5mCahReXSgPmZGqkoDJo9VAgw5DI5AmVXbfrh8SlhehnCRPGkrzIRF1gfzY4j81WLUXLJoTr4VN6r/eots6q4BZPDl4xIjF00VRW8jBV6hmpD7sPMtXg8bHgB99qbq2quSvAxw+bOHbh/8z4LL+QA51/f9W3gxcVoP180rkRXJ6tpyJZkcy+yC9AHkzIYVQJRnuvppQUANMofVb8blotw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:00:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:00:38 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:10 -0700
Subject: [PATCH 1/8] rust: io: register: dispatch fixed array shortcut
 internally
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-1-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0df14b-2f99-4803-352a-08dee7174c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|5023799004|11063799006|10067099003|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ivLgetTgpz1U/E+lyWA+SKkf8D3pq3vRcX3XaBi2dLgf+TPfMZV+h6EQWYOoQNdQoGdDAfCBr71jHJbpybx/m+epnTCS5q+JNVghXq0Bs1P1RdKr+zo9eyxrqUOMLUUxJB1bcEY6RBI9HfWzm6Ka8Be4vJ2c6e40N3X6Yxg4BmJSoMSmdA9arL5Ouc7P3Fdl2yyM92f3idf2LZPK5qUiYJxKG6GKCUXEf3xf+patONqWYuikgcvnwiCbfl5LRCe1+G2eyIkDGZhGaVlK17/yCAp6end7iSouwlvhR2PTh8hAIIRDGAYUlYpim4Nigm9pT1UG61eG+nrpnUH+QVnyMH0cPTjeLiKihUN0Vfq+MgkGYT3DaxfMH+yYSB/CESAwVLFtaIk8nw2g5Z394d8Nl2K/IQJoxsG4doYXPO5OQirYRoo3w7YZPzltUWrxBKVC9ByydG0ha0Cu4F/1UPJNFBMAP8FCb8eKXPc8VmFGSwUXJ0wC0vq80sajzdRqksvAZLCcZegnIgO6MgxQ4Q0ui9kJmOVUCDxNg/5Tc/Q5o5W7FygBQui4Uq+Cy3ceCXc73bnks7mYvrr7ePJXY8dv5ZwdoKGC+GwZZhgGOnuj8t1Wa0UBWom761LUYXMXl2ztQh5eLcBTRVU2s/PA9NgpGPk3xTNGMX3al/Mv9bsIH3avlEdERTmRfpGcrn3Vap9VjB2eAAsdWcwQG7EHj5MqWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFxWm5DK3YvVXZsdGZoZ1BFTDUxZnFjeGFPVk1QNnhxOXBnRmJDQUQwdm5C?=
 =?utf-8?B?dS9xM3FmMXFXaHNTdUFZUTNHY1RZOWhxMXI0bzV3TW5iaytvdkdyNm10Tk9K?=
 =?utf-8?B?aEx6ZG9OSERlZjRabXlITEZieDZiclJTUlYrVVdQSTR3ODdxTERNZnQ0YjYv?=
 =?utf-8?B?VjV6VkVLeFFkWWZFN0EwSjRsa2dpQ3MvOEcyWGFhRnF4SEgxTEtUM0FSbDNS?=
 =?utf-8?B?aHZxRm5mdHZLbDZwYzcrQ0xudDk0Y2N3ckY1NzRRZzk2ZGJVS2hmRDRzQWQx?=
 =?utf-8?B?N0kxY1ZUUHAxUC9hSnRISVhQT1NBVTk1eFFsdGZ6bmQxUkhuUFBQWWlPYUxP?=
 =?utf-8?B?aVYvVkJDNHBYV2ViOWdJOHNPRUJINms4blNxSDd6ckdISUlybHc4ZTB0bnoz?=
 =?utf-8?B?MC9qdEJoamZoNmhnODlCZVVETm5uaXd4TU9FVVBxNXNTUDNZK2x1RllqODY4?=
 =?utf-8?B?TjRnTU1jV2J3SzJDOE00RWpMVi8rN0wrak92OFczdXFrc3FINWlSSUdhUmpX?=
 =?utf-8?B?ZlJaU1NURmk4WXZyd2IwODF0Y3A1NldPMnRhSU02VTJDY0RscjVnMDdLdXA5?=
 =?utf-8?B?RU91NXIrYm1EbEs2WHRSc041ckt1OGxPMkkxZytwNmk0dzc5cnluN0tyaTNQ?=
 =?utf-8?B?R0w4NFUvVnkzcGFoSXlYeGpkeHhHSTlLSS9Oa3VDMWM5TEcxZ3U2cDNneUZQ?=
 =?utf-8?B?U2h0SGZSdmVUZ2IzN2lmNjlUVVJyS1ZiQnNhaGpjTk0ydzMvZmtMVHFCdWND?=
 =?utf-8?B?czlwNWxxVGpOMjFBYnVreVIrK0djT2JFZU1YK2ErellxWER6dWJrTVF6dnBN?=
 =?utf-8?B?RHB2cVpWMVVzaHM5ejRtTzkzNVBNb1BHL1hBeHE3cWRRQnRteXNoR1piWHNO?=
 =?utf-8?B?eERxY3g4K0cveFVUYlFxNWhZU0dRYVozZlk5b2d0RWw0Yk9uMEFEUGduVHFG?=
 =?utf-8?B?TmRQL1hFbkV3aWtiMEh4TGVaTGgyaVpLYzlnelVxY29rSGtoTnJKQ0VCdDRm?=
 =?utf-8?B?Y3hISU9LaFRsNWlWN1gwMXgvUVczeVlaanRKUTJwUnlueWRWVWFNcUlnY05Q?=
 =?utf-8?B?ZW1JWktpK3Bqc3RJRnpjT2MvRXp3MStIdjA2cm1KT1pLNDNEenNXUURMd0xQ?=
 =?utf-8?B?Wk1ETTZFK0FBajVlMStJWGJjMFQ1aE04MW5EL3FqTzhWSFVLN0hMcVM3SHg4?=
 =?utf-8?B?QkVUdXlqYTFRbTY1NGFpbCsvVFdRRmRjTXdGSnpYQnBiR2lnd1plNzBWc05J?=
 =?utf-8?B?ZlJIZ0x1Nyt5UTBqQ2dCRDRUZEwwSEZRNW5RdDBvZEVCU1lLWFdPYXEybmQ4?=
 =?utf-8?B?a2NnM1N3TE5wdGtaTlg0YUp5Z1lGeE9zVjh3UHQ5ckZHZlRjSTlVcVIrRWlN?=
 =?utf-8?B?T0dNZG1wVlYyei9FcTBybmtOSkJleWtLZ1paOGlmaDQ0eXVzUE5FVVp6anh4?=
 =?utf-8?B?RjhSc2hZMmMzZjhuMnZNQnVvOHpYeVFsaG01ckgxYi8ySXdJRTh6YzBZMllD?=
 =?utf-8?B?NUNobFZGWXFDNnR5bkN1bHlsQzNJMWFUYVd6d0cxeHk3Zm9GQU9CcktWTTVH?=
 =?utf-8?B?STB1Y2JDeElnTE13QytFMFNybU9ZYk1DcGJ5aUZKbWIzVUc2dHJTY1AvV1M5?=
 =?utf-8?B?emhJUDJtN1o5TjNiaERQeGt5OVdjQzBFSVVnU0JwOGtiaGtsZG0rcDRSQWdz?=
 =?utf-8?B?ZnZoL3FuaElVUElwU1F3dlJQTDRVNHBOOTVpR0QyQW1rR3ZtL2k3UUlSQnda?=
 =?utf-8?B?NlREVlpxL2JQc1dqSFNTenF3Um11S1JDVjdzVm5PZUhZbGdjSjZ4MkhvOXdY?=
 =?utf-8?B?S2I0NmprZktya1I5VFdYZStOVk1WSEw2dzVVby9JWDZFVDFtTGpIdklaZ3F6?=
 =?utf-8?B?MHdxeVVta04yNWlXZmtvZFBEWXlZemRIdWZ3MElleW14SUQ2VEtzSGE3enhu?=
 =?utf-8?B?aFg1Z21zQmozeWFGTzNOOGN4dFE3RjlwSnVib3hiSzcvOGJxYzFmNjZ3dGdu?=
 =?utf-8?B?eXVWLy9ML1p3ZUphSjgvTCtmK3FtdHBZMFN1NFdrVllkWGJFTEZCdWJic296?=
 =?utf-8?B?WHJ2VVZRSzdzNzM2ZGM2aFpEbHRiMXNXWVZtVE9YVjA3TGhHTjdGRU9TV1hy?=
 =?utf-8?B?Ym1uU3EyM1BkMFZMdjFtSENjOE1yUUVMOEU1UW1lTUV6TWw4bTluaTQwQWVn?=
 =?utf-8?B?S1I3SjZmd1lVZ21CQjNxaENnc0h5TDNubFdIdkNkV21qbTBqR0hLYjQ4TzE4?=
 =?utf-8?B?RjFIeC8yQm9QdGxqVG1jcGY2dzNlaDhDM1BwL1NNSndrUERiUXlnK3h2bmdS?=
 =?utf-8?B?R3hsUFhncXJxK1BwYmJjVXUvdklzSERTZzd2ZkZRbjFJSjZLMXVMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0df14b-2f99-4803-352a-08dee7174c6a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:00:38.6867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqcHV3i2bIMKdyhQl/mw2QFo2DZqcROKHMbg5xN94krJ3FU8wlCGDKwaoE5KqU9OogOKNxgs3a25svroEaMlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

The contiguous fixed-register-array shortcut redispatches an already
normalized declaration through the public register! entry point. This is
unneeded - the public rule should only be invoked by users.

Dispatch directly to the appropriate internal @reg rule instead.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 80e638a892d7..27a9fe45b06d 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -888,7 +888,8 @@ macro_rules! register {
             { $($fields:tt)* }
     ) => {
         $crate::register!(
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
+            @reg $(#[$attr])* $vis $name($storage)
+                [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $offset { $($fields)* }
         );
     };

-- 
2.55.0

