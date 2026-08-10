Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DBCC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FD610E71B;
	Mon, 10 Aug 2026 08:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbC6uvuj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9F410E71A
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVvpk0Ybf/UATOb9+OD7Uyhm4XE/KJYmhKfNHhqVmZQ/yZ6htiRhMcwd0AYI5s+ZQTVwwtoMmEXupjUay/MNb16DiTu3xTqrP+ef9nw+LBwP9xLSSwNFrhHKHosh5CpIPJzQ1+hi/xN8IfVlYilaEHYOXiYeuHIGoHOSQIZCkLOmlWgSjyjEkvU2CnWW7MHBFmqAfFct3vkfjE2IHhUnPL4MZUsTGL04VTEg0guhFmEVYqT51Ek3IOJtFRC7QXK2Kz8b9n3tvb3J04SfgKD4yrXSzKrAZsTAQnMsSNfRC7q5+2X06XYdtJb1C0d1dtYztMz2bxSA96rugfHLSJKDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=cFeHnRww3PzUQy3wh4Yz/rY1qoJm1pIqhkfkYRgglwOkQz8vC+uT2qfK62pyjJa16qXMeHNsq/gUb4WuQSxY0MxvVb3CMOU3KF9/UFmP6Bx4QWik4jH9AWpLcDaYBSEaPBfdCn+tsXe6iHg9Y4Sb2ccAPg+WNIW116RaWvcM/RLgj77dwEQxaU1Q6wqRlAI/eIL/JtkuaF2lWBMaWS0Bbu1TOvc3yAOyatZlvDdmgNwgroRT0L/5wck7LItPGDtoxv/8wu3MWz7Blp2iH0Fo7M4BTaDqOvEIxcHhTcBdgZd2Yc6gB0aLCgREz3GrmgayqeqlDhN/G9PpCVXgJmc2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=XbC6uvujw/VNbvM/WeTFMgiuM3MchK1+agcR3F1ifPDeoMwFUV+369ZMTbMz3+QyKiRfbzMYpBV3yJe2QxeoEvrVDlqHdPDpH09y49M4/MBmH64MGWVlrun7q3TwKEP6LYAJrwmCoVPN5enl2cEFSiCU9PDNZZNHOR/T+urXBmDopR18532PkRTZUPNQWL1A62miU6m+zGQLMKqy+0mvTpKDxp7ycivyGWNjXRfr5p9wHZpo738q2b+SKXpb9PMNPu6LKEpWTltjHUkIG12awFZvt/FZnJhJpvIr3US7D+HUzGHxjpBzC62YoO/kosvf7KLOPDB//4wP08hNV3UFyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:35:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:35:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 17:34:09 +0900
Subject: [PATCH v4 1/5] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-chid-v4-1-c9f206fdcb97@nvidia.com>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
In-Reply-To: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: f707a148-3753-435d-cd92-08def6ba5b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 9n5rTTsWC3V4RvGcLSkPr5k7ndCG9MGgW8lPjc/7vA5Kg2fDrX1wG8q8n7OOTMwb6oaxhWo+vOoeNOVLTxXBwsT9BaKZhh10p9kQILq6WodhXARVCxAEl0kRvh9EJlXL/EkdUXoyK8Xk6b51GsLrskCmCExdczBLa9M+aKMFJrtfHqiIvshkBZxerNuNy+PIZHEax+DTRYnfyTUpnNDQIN1xxSEd/Pp+C4LqoaIPME7q4wZ3Q2Tiwk1ubzmCiT+VumPOm80RDMM/4D+bWmugCiZzeFW61zqWaTeoBdb46P28ql+yS5wtMoGzTjmFPml5KgZqk7eG39XCI3swfnfKfYNXW4lknzEHgXZLfbh6QO0A1672TMY/DcY24ZFIJt5XdlHIEqPtJoWSm7C5klJYjk71IrR53Hab8fK0SrJTERvPQMuV63vQ17x3JXiETP31HrHmeiOg9uwjLkkezoCPenfQzEZmtlteEsbb62QNasW9bMoMaqDXSGHFavIfW6HbXjB555AdyCVdG1dZzZ4LwHB1uPOoqy7fUGacBRV/naSej4gAGuDuuV8EpInQj1P6RG2pjteijeFUSjuunvrsW9QRlCICQ12kclUv9gJTogp2eg2exREJn9bTtTRgquHjlihHlZ8jtQrWyUGKVuPmRxHe0OBDx0p3pU2jnfwrwCvr0CiAL2NC7RV58qelHjtCRqstZ82pAUIAtfsoMPUQPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVA0aDlqeUdobDg0Skd4cHBQTjZGWTdibTFPUm1JVlF5UGZsNC8wek9pVEFa?=
 =?utf-8?B?STV5LzlGK000M1BOWFlEUXFsdE5xRFNFR3hBaEU4UVQzdkJzb0tjVmxlWG1s?=
 =?utf-8?B?YjRWdzBrZTI4WXdWTkFCemlYd0ljMWt6d1JKa3NHblBNSVNzamk2Q1Z2SmhK?=
 =?utf-8?B?ZTRTaCtlbTEzRnhUenp1c05zcTNYam1uWElEdzM1ZW9xWTlYNHYyRCtUb1hm?=
 =?utf-8?B?V3k5ckRMaW1mTTVXOVYySWsrVUk1T2NlWmFTaXB6ekI3Zi9QVHhoRG5RbnI0?=
 =?utf-8?B?Tkh5RDZkK1Zqcm5yR01KSVprTE9IZDMvTlhHKy91Rlg2TjJWWmlmaUlEYzFW?=
 =?utf-8?B?Wkp4Y0hmVXlWMVE2VTlEZU43SWxLbTByalhBaHd4NU12VlF2QUpyYjh3Wk9G?=
 =?utf-8?B?eGRiTUMvZlU2WVltejhYQ3JXNWhNeWY1aUt1TGpwRDRxaGxPRW1TY3hPUmZq?=
 =?utf-8?B?eXBabmdoUlhvL1ZPZzY3ZHpFcEVuVGNXQXh0VjJFTHE0empVbWVHeldRN1E5?=
 =?utf-8?B?QWVEZGdFZ2ZmTXRvNVlCa3U2dzdoMjIyRThkTjQ0dGhNdmJTUFpKR3FPY2Jj?=
 =?utf-8?B?b0JZVFVWNElDcWxVWmhFK0drazBGRTY5T2xUd1NyTWVHV0pWRTlVRGhNZ2ND?=
 =?utf-8?B?K0E2Skh5akVPWWJsaENXR1FVeDVJQ1JVcXUrZGtNS01UaURLa2ZiVWxvbWRP?=
 =?utf-8?B?ZlhsZ294OSt3YTF6TGx2ekl1TzNZdVE5Z2xQdTJNcmhqTjRJQTBSQ1VGUjc2?=
 =?utf-8?B?NTFvbUVLVk1CVEtXQkdGVXUvYzBWd2dSdnRCd1g3dzdiQ3VSWVlOOEFyWnN3?=
 =?utf-8?B?dndoY0o0ZVZqWk0yYTYxRytvTUNmeFNNTjlLZUdHS29FK1N5N0dZcVRSTUpB?=
 =?utf-8?B?YWI0ODRuTEt4amNCQkpiNVdvUjMwYnQyejRGRmdZWkZQOERUVnE5TmI5aS8r?=
 =?utf-8?B?dlJnUXlBYVc4c3ljUm45WnlSOEttYnVrc1k3anJWY2lJQUdPRFVudVBxaFBR?=
 =?utf-8?B?azltdWtsR0kwSGVkMmN4aFprQkhrTnZhRVFZNzJibjNSS0xiRWhYTmhIM0E1?=
 =?utf-8?B?UGExQjBNL0tVQi9UQWR0aVYzYjZZSEw3NVRoRFJ6d2p3eWtKd2xYb2dNUlFI?=
 =?utf-8?B?b29nTitTKzlyd0xUQWEzSmZXT1FtcFBjVjEydUV3RXhrZUZLWmp6S252M2tm?=
 =?utf-8?B?OU9QU2JaTEFaaXJudnM3cm9aK0FnWmR4M2lXaEw2dG5mNmJ2YXQ0VWNuZ3Zv?=
 =?utf-8?B?SjFiODVwM0hyamZ6V3p3Ulh0dDhuV25lakQ1TmxNd0x0ZjNURUsxckxoQmNv?=
 =?utf-8?B?NUcvMTJVYnZ6MytZRS9pU0dSRmg5NzdCNVdNSTJ5Y3NuODhNU2RaTDlRazgx?=
 =?utf-8?B?Zko3VnBzR1VYMGVvQklIdHhGWjJjUVIrai9Kb1hSYi9HMXdIQ1U3dlI3RFBt?=
 =?utf-8?B?THBxSlNhTkFZOStmbFpLY0lvVVNFWXp2bjRzSHRJcExlTEduVHNTWDNyeXdI?=
 =?utf-8?B?V09RRFRtYVY0T2dxOEVzczR1Tk41cXpkaWEvK09lRDZDVzNDQWJZbSsrOWlG?=
 =?utf-8?B?Tll3STFvbWx2SmEwcndRdG4vbmlPeTBvTkhvTENhcHFqR2I5bFkzd09LaWFZ?=
 =?utf-8?B?ZDljdnd1L2R1cDhEcEJtQ3N3NlFCNkQvU1RXa2YzcVhaTjNCY3ZycDJXVUpn?=
 =?utf-8?B?UGhCSFFHcFlHZ0tBRi9ic1V0SE1yR0dxS05NSWFielVuVC8yT2poRjlVUllV?=
 =?utf-8?B?M3NrOGp5RVNaeHVxVUI2TjVWa1htVVN1V2l5MEZVblByUFQvS0dpUVdTTlJy?=
 =?utf-8?B?QTFrS2JYR0lLbXdXRmp2cGFBa1I2MkRBY2ZwRGZ4Vk5HZ0tJWVJoQ0FqQjFN?=
 =?utf-8?B?TTZWTnFhQ2NNRTJpN3dreFR6aVRLMlg1S3JjeHBiM0NDL3N4bFhHSTFlVGFK?=
 =?utf-8?B?bGNzSXZLQ21CZUtWd2pKR2xBRUpwbnhZbFZERmsrMVM5bUR1TFhJK3Qzbmpr?=
 =?utf-8?B?V0JQYVdDRVBRU1hveW9yc3M0MHZLRmpTb2Q5Z1NwcFhkS3N2K0RUS21YOVRU?=
 =?utf-8?B?cEhKeE05VzVac2xleVZ5V29odXp2VEpRNWV6MDk0T21ZY2duVFFCSFpQMnN4?=
 =?utf-8?B?OXU1MDgzVi9nY29sbUkzSXFXVVQxNGE2cTNJdTJHZVV0R3BVS3hlQy9sV1g4?=
 =?utf-8?B?TGFJcTRkWDdpbjcvVjRBSllJRncvZmhtY1VYTWcrbldBQjZEMWl3RzY4VUpC?=
 =?utf-8?B?UXorUHhmRXdUMFNhNHI0MkNUMzdYMHRKZ0E4RllHSTFobk8vS0RJMWJiQXZK?=
 =?utf-8?B?MGNaN1I0TnlaTlMwdWE5K2dOOHpxOENmMmhPK3IxNVhuK3VwYWoxM0NKeDdH?=
 =?utf-8?Q?ETFpcuhQEwCrPS09trn40lbPyLa3mTxeT66tPm4CIC1Ld?=
X-MS-Exchange-AntiSpam-MessageData-1: MXuZJafl04dA8w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f707a148-3753-435d-cd92-08def6ba5b47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:35:39.0777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWqh/tuSZZhB15E785RPihF7JXRhBt5KhAOxY44pzv2ivkHid2MhKq2CXeqpOTSIN6AV8uj/Y1r0w9vTxPT9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

