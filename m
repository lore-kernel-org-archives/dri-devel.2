Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2996C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D838610F1BE;
	Thu, 13 Aug 2026 07:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BqIBk3j3";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8963910F1BE
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X32fURFnxk4SRnX0tHHPLY3cDJzEK8RsrDwwbzBqa6bQNtp4RNg4U5VLCSTMmxXbAfin7bYCb0k8BzLDI9e3mLx32raaxGhqrs1GBLdygm/fMOXrzqIlCPb/a2AodmE2wy1y0BNyv4iNGYW9uVR29OhJVj3hA9dT6DqznDND/xskG5CdOrdIDFVS8jv1Y6KdLuaJgaPKXj2IUiEqO8xQFqcawJdfAQuBAWjP2uLp6BD+CfbhFYZ+fSyZxKKCQMjLO9gpRkpvrLfdDm6UG7jiEoF8bEgUmTzVDyLVicflWJmRG1k4YewQ4lTuT2COONGASjMUGQPgPzmm/fL5ORCHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4CEEOyYYQXTbzEpKw2zMZEOe8DY1XbC0D12CuV6rbs=;
 b=L3Q4CnsQhP/uersOhvsO5TYfrvw3y5TWkcqMharlWNaT8AZ+f3teqbrVpXRRpZkseA95ikYI/HoeqI7mr3N3RF2WUQinTU82BWwTR9m218lejIPqxTs8j6ZSlWzZGGCuO8C27JRtQySy41jOQWa4CXFdkk5xrIrQ061DKqDwI0hqNX+xNfHhDalIskOvBeqg+Q53cTuxICuQnEpY2xJ5LvAA0LZhSPJhx5Fw2V1+xRWE7RQTG82V8XF5FD/9iW42Narly2/9isUl4BDEKjeHAMiol8kqB0DpURhyeVWKBlKkYAi3lntXMS3c7qh4pg38PH/i8aDlZxLSdPG12MeLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4CEEOyYYQXTbzEpKw2zMZEOe8DY1XbC0D12CuV6rbs=;
 b=BqIBk3j3+exZNFw1nXDhjz+NghvEJ5/ek8HrlgM+RXXCnQ0A/8vPwLSVrr3HSlTU2xm3R5AvX2uvQaF1F9bwyUFHJi1ND9izy1Ap4kaUR4TmTimHcgziqdw/5hHe0uD9qp+UGGKUBZxpluj48YRv2VbPNCp52tRrjyzGvQUl9YAY/WT+bdGc2odNXvRKFIDdw0tw1MIw/U+BEkPUMrtWVwhVcI4876VhpwVzLKBakK9Q+g/W/H07DQxohX5QErkCQZaa8aCTNre/WzL5oy+9RfHV8SyZ48seCZ2HdWLn4/3JGZwgh8MgQVEo6SuGYpJKC525Rv+X41xFV7VDR/7hWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:25 +0900
Subject: [PATCH v6 1/7] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-1-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
In-Reply-To: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 387ce760-5425-4c43-1994-08def90d559e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZxEunJ4QxV9klDp7RwPro729C4UG6AUDwYkgO/lJRZ2wz9hvX2Hp//CMglDxQDFt4aUVHyARHSlkwzWV7A8yC2nZtZ8vrjOSBTlV7Wz0G6r4/o27/u/CVc5zfnYiSM/vMO/30RFeH7e+PVI7LRpCenIYpefpt3qVzkRjrGf/nNo96XX4vwdsB9affKaG8B5p5B1gyEW/Qn2xY3dPELGS+6r5z28Wy4H804LaMP1iIgE8G7QR371tVnrn3dNQb0ldLMqrutbNFLtZxL8rVuZetXAL4mlqfFu/WoVJlT1q7nQbHPnWp+7WcbuGE+R4qR21CdR3yyX5PYuHR7ZG4yDcT6x7NYP0s84DdIyp3y4pEV0fA3XoWT3wlecGd1suPViHM6wRrSDSMHsdZgMIiJoyOZXQkVq0xPF6nEMByaiz/VXxkkctOt/rDIsn34IiLxp4ZmSgwqsVGd3nb8HiQVYJFSUQMR3W6hqVz2r+a244LdcjCaX6N/xhlUw5M4pFzIontxHj+jbdr7N710GYz80NyyRn9yQEeuQjR65AgbW05eXhNheoDBsy1PrM4RUUuVhcWlJ2oGOXKgrL+jbp44ja2G9HaUEBZIfmhFkcCWF0Vov4bgGn85ZRH1zR3gH+jmkDLLMnLu66/JVURZ9QadAHCfFbkwnB5ccHiHDN0V+usqBcy5EYOt/+EI6xdws54uD7HolquNfbqgWUzMRl6JyC1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZkMExVRFdVWlVlN2hqL0gyUmprS1k1R0kyeGszR05HUWRoYmJRem4yalZq?=
 =?utf-8?B?WnFYeVA3Y2JKMWZ0dGtaaDR1aW9uUzErQTVEcGZnV2tTOUtXcTMzVGplS1VI?=
 =?utf-8?B?RjI3dENqNW9XdGZIVE9lZW94cjRudXdzWTNDSGpJOWgwOEk3RmVqdTE2Sm9H?=
 =?utf-8?B?aXhzQXdETXVEQXNwTGZLUzFrQ2tMQ1p6aG5mMjVPam00elh0b2NqL2YwQ0Vk?=
 =?utf-8?B?R2M1QmFqbzJYS3A5d0pIMXZtMGJySFZCM3Q1OStTK2NnS0pRbHVtU1lrU0Qx?=
 =?utf-8?B?ckdudEF1Q202bEpWT3B0Nlg4bTdaWTRBeE5ERysyRzlOZTU2ZkxDaEdRbmZr?=
 =?utf-8?B?L21za2VlVFpJa1hJQ29qRjFtMkwycXJvaDBrUVNDNUdRVGRndS82eHNBMjZl?=
 =?utf-8?B?SVp6cTN4VzR3NkluZWQwUG15ejJjQUpLK0dFb3VwUUVBTE9tTzdpbVA2Vlg4?=
 =?utf-8?B?bGVqd3lJd3VvOHQ2SFBWZTVVdk1LdmZvb1Z3YlNvcEVUeEJ2TkFtZ3FkN1FM?=
 =?utf-8?B?MitwbDdXVDdlUUZMai9YdFpCQ2YvcXU1N1dvbmVaTVkvUFRxRWVtdTJYTksr?=
 =?utf-8?B?Tlh4cUw0eWRXRFhKZnNJdy9IaFNZWXEydzdMeXVjaUxTZ3FUaUJzeW9DaTBk?=
 =?utf-8?B?V3RBUHhROFF5ais3Q3ZDemxLbmFTc1psVGxBWVpGR2crNFhITE9qUlhnbFRr?=
 =?utf-8?B?dUh5RWxyN0hjSkcrZkprQU5lbkRLV3Q4SmJGOUEyL2ZzUTBzOUZSdkkzR3Ry?=
 =?utf-8?B?SzIxbWQ0THMvRzF2QTZLeWszS0RpRGdoUW92dERTYkcrcW1HL2R2RzkvTGZJ?=
 =?utf-8?B?WFJBQ1l5Ym1YeFZFamEyczNZbVhQRW9VcFhsTi9NQzlEVno1VzN0bHlBWG1q?=
 =?utf-8?B?UlZQRStJUlFZdkJpbWZqQnRKWFA4dzh2MERQamlMTkVqdXE1NDhNRnZtRVJF?=
 =?utf-8?B?SHhYUC9uRmF1YzVzZXJXWEhyNENONC9SWnBGS01ZdUttYmNTL3kxTm9oTDBB?=
 =?utf-8?B?SmtFRHk0VCtjZGpOMGtsMHZzZEZhYUlVV213bUxUK3ZQeXE0ZVhSVXdKSGZG?=
 =?utf-8?B?ZEpNWUV6TlNwemkxZXBVVkVqZDVtYlg5SHpuaEhkaU4wRXBhMCtDUmRrN2V4?=
 =?utf-8?B?Ty80clNISG5zdUxsWWZMRHRNZExDZ00xTDlVRkRIUnhlVDFTcW1EQ1NVUWQ0?=
 =?utf-8?B?elowZFR0WE5QektVU0tabTBMcTA1ZG9Ua0lsajhtdVU4UWF0T1Z3VzVaZkRh?=
 =?utf-8?B?c25kVmF3SzRMTjNFVC9VTnFvVGk5UDRTREJQNG8vNVR3Mi9jRkxZaUF5MDl1?=
 =?utf-8?B?ZUpodElyRlpZeVd5bGFFNjV0QWoyOGlRM1ZsVWFEU01yQWdoSTd4N1M1Ykk1?=
 =?utf-8?B?dytvb0g2NWhiSzlzSy9LbkJyZXo4ekdWUnoxa1VwN3pvL2RsaXRLR1ZudWps?=
 =?utf-8?B?ckQ5SXVvV3psV3NHMTlQTDQzTWhGTzBzc3lXOXlrNlprMEthS01vNVV6Q1pJ?=
 =?utf-8?B?QWV5SG1Mb3o2T1hYVUwvdDRiZkk3VnlyUFBxTFhxbkYwaUVuLzZhUktkeDhX?=
 =?utf-8?B?Y1RuWEVEc2hKTU9INUlueWtYL3V0SVJ1ek8xUzdEVWFYRUVrNUdNcjFGeXBr?=
 =?utf-8?B?YW1HU3RSbzJlSmtmTFFqNWxoUm1BMGNxSWszN043K0w3ekRRUG8yNjlVRy8x?=
 =?utf-8?B?UWFCMktPbWN1MDc2eGxQK2JpS09oOEFwT0FkTDA0QVlVMTJ4VkU5TXovMkFY?=
 =?utf-8?B?TlA0TjlWTUdYNE12dDFQOXFraHcxRVg4d1V4VDFGY1Yvcmlkck1wUTFBK21Y?=
 =?utf-8?B?K2U0TktvWjh6amlxK1MzYVIrTFMvSWJJY1BaeXRLUUtqelNackhJNnVVYXhR?=
 =?utf-8?B?WFk3azlLVUlKVk43cGRrc1U2bkpSMjNab0JleFI4YkZJVnh3clp2U2swS2ZK?=
 =?utf-8?B?QTlDSjdtNWlrRmZTaXBUOFkzdytoSGxRUGhicjFPOWxqTUpGcjgyQ1dycHNk?=
 =?utf-8?B?djNhb0FYdEUvMWhUNVIxeE04QTZsblNTQ2FBUWF5MXlMMkUxWlJyalArQ3Vt?=
 =?utf-8?B?SGFLZnpjNEJtZEV3TEo0NE00WFNObXhwZlFlUVRwUmpZVjNjRndDem1uVDZV?=
 =?utf-8?B?RFFsWmJLdHhrL3BNOFVZN1loN1o0RVIzc3h5NDJtK0N5NzNkbzhORFFEUFhl?=
 =?utf-8?B?UlVFeFovMWNJRTZhRkw2bEhQdC9uQTA2VGlYclZEM2ozbU8wSUd2MjNIQ29Q?=
 =?utf-8?B?cVNDZW1HM3pRaC9qN1duMlgzekUvWTNodWlibGVDb3ZwT0daYmpOV0JTNmU3?=
 =?utf-8?B?ZEhaUC9hSGRrVW5zaG1vaFNpZFBQa2NDV2ZBSWJhbG1IdTJBbW84TTRTb0Vm?=
 =?utf-8?Q?ReQmdn8yn0raPX8SNS1khDW+v6gFf+AaZ8FpGg7wJkEfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: MWY4pTGwwNQ/dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387ce760-5425-4c43-1994-08def90d559e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:40.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDwkJpzs6C5oILDwLMCMM/sXgzoDJjRJOAPc4knMy0V6EsiM/5Jk/6mjqUzb0WpDGdz0XXEmsQ5WdCloCs+Rqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
we no longer need this workaround.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index b27e0ec80d64..a43bfe0ec3dc 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -572,24 +572,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
     }
 
     #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
     fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
-        // TODO: Kunit #[test]s do not support `cfg` yet,
-        // so we add it here in the body.
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        {
-            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
-            b.set_bit(2048);
-            b.set_bit_atomic(2048);
-            b.clear_bit(2048);
-            b.clear_bit_atomic(2048);
-            assert_eq!(None, b.next_bit(2048));
-            assert_eq!(None, b.next_zero_bit(2048));
-            assert_eq!(None, b.last_bit());
-        }
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
         Ok(())
     }
 
-    // TODO: uncomment once kunit supports [should_panic] and `cfg`.
+    // TODO: uncomment once kunit supports `#[should_panic]`.
     // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
     // #[test]
     // #[should_panic]

-- 
2.55.0

