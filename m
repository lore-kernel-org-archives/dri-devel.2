Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B128CA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037D510E9FF;
	Wed, 30 Sep 2026 02:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dsGkYBir";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB12110E9F4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5+TWBrQS9V3tkeTv6zArA9LKKGt2BlWjE7mFfj1cHjBXTAA8xOhHbSQRRHWForyB0Rn7qOq4nrSnq51PrJMnfsuZL43ByPHLoiICwc6yae7VRHCNxMMsQHlVLbdSUuHoE1fVtFX7lr+amr5+Hlw1UNVkiWT0gzA3cFKUxnuRP3P17RVlazni5zaRddqgLuRvfyqAQQ2eJXuTk68ybpmVw6khlY3Mlqvg6Beke6NLg+qkEWOpTxNTk2eu4CwOHNfoG7e+r75AOWQGrAkK/8812W5mEv2GpChCMXMv1FsytUseYrO03yqb41Of2tZF86/7iBs249wT1okVs6WF/niAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFemma4DnXXdAkSxbWD1HFwqppeufdb4HtQRLODouPg=;
 b=Ezr36JTllYjxHGx8qOglmwMRY7QtERS4scvflcObIYWG5PppaxijQW6xRHKDSRlV7hEMXKJW8zYN1nq1npFa6tW++JOD+ievDbkGQn9IuyUKdLRzn/aGy7BUYC508HJjbLVyxGanxpGXtYsSxhajscoAV3qTjLPYvcFXep6FUsppj6Gl2aIbu6eypOMRYlYlLM7A9qB3OvEQstpHssynQXiVKZBl4SnSegeGKt/N3HtrSmiRIr+s9ExFyC6VRZqa+h/w/aFyEM5jHmCvrvlM6y0fKD4VBWeDps45v5G0qodKGLlR8HMF/I3br96fUtvMYP10ytgDXXGlPkeqIRDr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFemma4DnXXdAkSxbWD1HFwqppeufdb4HtQRLODouPg=;
 b=dsGkYBiratSPaXg53wmbcBnNcFjMMyEzys4BftWhwb/rDQ6S2oWewLCqxQWe6a0A+hI9CyN0hco6y5H8HrqGi5t25tGg1XT8c9gpDGIXPBCFno8CiW+OGCPqeg8bvjt/M79gBKZwxWJwgmF2LdB7IjEk2pJeniTT2QLVjz67ojt6bFLJA/egQ+YqYHpTD6XBlsqSrWLTaDFNEnM8JD5RQQ26jUfzNYP0deCwrp+x+rwMnu3JSQFfK6BpLYSxfSZmdF7WyDMcICPD93LRLtGxcQ9gLF1VSulviLiB+gboX/+Hv6NiR4flLkqlzLa41LU7FHVugBnF0uheZ3O1ZKwfOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:32 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:32 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:52 +0900
Subject: [PATCH v9 3/9] rust: sizes: add sub-1K size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f6929a-2c85-492c-5038-08df1e9cc151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tPsMFrDk1IuGNvAb2V/XyMxoM9T93jU07dxPTOwkK34AdyGNsSGhJbKDwEu/fDatpBZNT61KWLEfGkqIvNTdd1im+8RKB9YfE5FaaI8HeyfgXrq29HH75WPLXyvt2pVYXEHnsXlUyIqq2vzF/DC18JyjMQ7aBz3fh/DZzRGBWZliw0N3uL37BxPhr/Mz+kKUJHzX22974xZ5f9Tx/sVmrXuaRaN76hp1nUNTxvWx103dcZkKSBSSWeI2WGd3NRfBoYSG79PtZpZfoOy2XOBu55+B58QQsD+huX80KuDyDaAcGKa1EZnwIkX7nP0DLCfphEy6g6AwnnqMqlmCZp4Cpyq162oz06cH+e3RR9Ha49ZVtCH39dojNeUrCRbLAwwdl8k8G6JUjidq/0vEEYFwmHJFEb/mQImyBrvpYf18JZaBWdT8RY/4Ust9JWrQY5msq2PUYMDlIgHs2/foLVufThwkAUZWbM0dDf9r/6k+uBhIu5XGJAkWNDdq6FYfC9BoRe/ECAE1aKf13RBJ1iAVrqxgdWS3NvM3djy5s/hMfk6vR3MRyqI0ExqmUIowJ75jnL3jTX/j3R0hFC+LU68njOdgeXipoBEV3OC6DQjTMTXoO0E/cocGVFyWddxo4qG4f7MFIsoGJrXqen+lVatX9HXDvv1D7dCvRWAoWwTx5Z9dqlXqbGU0afLuSbumexqd2kuuPW7FEY1nMy41Y40o3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFnSkFGMHlEVnZMWHNkZkJZRmJlcDB6d1pjZy9kYXd1cyt1LzR2UGczZTFF?=
 =?utf-8?B?UjNKeGlnZzdBZjV0VmZVSFR5Y1QrejhXVkhoWWowTkNxb1RsY0xHODVzWnNk?=
 =?utf-8?B?WnBob0FWS2V2bTFPbHBTd21RRndPUlZGK2p0V0JiSENUT3l6K0NpV29HVWt2?=
 =?utf-8?B?VXhwQXcrT01kWWZycTlHbFlhYVJCVVBUakw5aU0zNG5GTDRjQ2dzakd3eEd0?=
 =?utf-8?B?Tk5XRm11L3hFbSs5RFdmRis2RThZSzNCVFVrc2lvVVhiUlZVU254b0hOU0E4?=
 =?utf-8?B?K3A0L284ZGsxUENKbExEZzdmSUhuZjVTRzlsQ05KWDNwdi9JM21ZTm5RLy9q?=
 =?utf-8?B?OGQxcEV6RlhhbzY5dk8wQVRaVXY3VkNDTHZXSTlCN1FGdmxENDFvRkVuWnhJ?=
 =?utf-8?B?TGdsS3Q5ZEVrOERqRDc5R1FMTWRhY0pHNHB5c1plWGkzOWtTMURwd3VSSytE?=
 =?utf-8?B?OTBBVVpLTlJJOFBtcm5uTFd2WG54blhSdFVlaTg0dU1uajVtZUIvSXBhZE9D?=
 =?utf-8?B?dnJHWGs1MnhJVlhVNDZxK3lKd3MrS0Z0eVZiK1Jzd1kyeU9SQndVU1ZRMk1o?=
 =?utf-8?B?aE5ieEROWklSSkZvaXJFRDcwNy9tTU81b1JhVlVXRmdodFVydDhDOExLbkJC?=
 =?utf-8?B?QkNEc3RrTkluWWoxb29zWlN4c21GRWhRMEVCSWNFdzl5ZEZRU0JOQm5KTENY?=
 =?utf-8?B?NmJLSWsrWXBNWS9RWXVkSnJoamZtV1FUYlJmQndpRUVKZ0pNeDZlQWNXeVdT?=
 =?utf-8?B?RGp6TVRKemxpcy96cEtCQUdubGhERlIwRkNJQXBEREJhb052MUp2b2ZBUXVJ?=
 =?utf-8?B?V0oxWHEwY1M1YUxOeXh3VUtSVXh1OUZndlZZOGdsY3d0LzBCdnVHZnlSSUJk?=
 =?utf-8?B?UTlDdEx5VFNMSmNhTjZPMytXRDZyTStFcGhtQ24zd0IvZ1BseTZCOG15MnBP?=
 =?utf-8?B?VGZ6MDAvR2xaTFg1ekxvajdxSkNKeDhxL09xMVBFNWZvekZJQ3hzTUpZblV3?=
 =?utf-8?B?L3NVTW5iNGhIY1paYlAwbll1STdIOUZNYmhXM3VsNUZtZHppYm5iSHMyYlFH?=
 =?utf-8?B?dUYvM1V5eE1kL3FCYWR0aklHYTNDN3NEMjVIeDRZSkt4L2tXbndwUEpEQ1lt?=
 =?utf-8?B?TFpWNDMwQWZLV2RjWUw1alJjVFVIUjRPWVVBWjNHMDJuOFdlSTMvU2xHUitt?=
 =?utf-8?B?bVJrTm5HQlZla3duK2ZRYStWdVZZdTg4S1F1SldSTGsxcTRoeitmSWtCQlhx?=
 =?utf-8?B?UHRwbkZwb283bGFsWGZ0Wkp1bUxhMTFqUlJUQkZvVlZRZWJYeXhuTUxndXUr?=
 =?utf-8?B?ZXdHWjhUeEw3c081bW04Y3dOd001Qk12NncyYlNkcjUyVHp6NDVqOTMwaFVu?=
 =?utf-8?B?WGRtRW1wZjJwazJhTWhFdnZibC9UZnJBbnhnZ1dYb2w2clBkS2hkQnRyYWRN?=
 =?utf-8?B?OHNqZkptbUJLTnFCMzdGVi83MU5WUUVibU1IaGZtbjIybGc5dWkrWElvR2JX?=
 =?utf-8?B?Z3FqQnRhTTBWd1lralRmNDA1OXNmbWVvMHNmY0JvNVJYUmc3RWt4aURIRitv?=
 =?utf-8?B?YVdMT25SRDQ4ang1UllqY3QxVExCZmh5ZUtVV25heWZnemh0SzNpWk4rY0F2?=
 =?utf-8?B?ay9uMW9hREFxUit4NWoyeXREL3ZPakVUMnVmMU43c3k5eUx5dHdxWWcwd3ha?=
 =?utf-8?B?OFYvSmVFOUNQaWNBelc2UEdkbUpMTHZGWUs3aitVM2dUVGIvRkZDa1FVVDFt?=
 =?utf-8?B?bzQzbmNPZkFCV0N6WlY0TUlEY3ZQd2ZGUDBvWEQ5LzFSYUQ0UW1UdVRVQm1l?=
 =?utf-8?B?cGloVXVJN3AzUm53akg1QlJLc25yWWdzdXc5bmRUZEVEbWR3MUdpNzZ2d2VT?=
 =?utf-8?B?Q004b1ZnUTNYRnNjSUZtNFdjZXQwTkJydFlBM1RDUHhNeHMwMmFuemVVWTRI?=
 =?utf-8?B?MnFZRWl4Uy9qRkxnYTdLa0xBTVdRSzRua2piN3JIUTdYZm90ckVVT1lYV2t0?=
 =?utf-8?B?UmxCbXkyeThMSkFUWGl5ZnRUZTA4Nk9CZHJjVTViMU81RzZnSnVWa25lNVlL?=
 =?utf-8?B?SFRTWnBxd3F3VnBJYVNXUlVxUThsVW14ZWVkVEJSbUlkb3lURlc3eW1hK1Ns?=
 =?utf-8?B?YmpSZW42TUE2ejdjdklDd2o5SXM1MVRnWFA2RmtEbjJMZ2NCbUtCUFJ1TTN0?=
 =?utf-8?B?VGlRQjNMTTBXR0JGVE8raDJWa1hYN1BFTGwvWnNwczB6U0lKQlN3d2RZT3JD?=
 =?utf-8?B?QWViNUZibUxhMzh1R2tlbTFkdGszZVMvUUVNcnBTblhlbEdDK3YzMTJuVGZH?=
 =?utf-8?B?MGtsR0x2VUlKek5Obm5aVnRMdlQ3eTlrUlR5eW05TDRrMXRqaDdRbTZXYXlm?=
 =?utf-8?Q?L3kfUbmOOT1MqoV6ulM13rfjZgoAFeVKB1rFblJNOy314?=
X-MS-Exchange-AntiSpam-MessageData-1: a8sp8+1zEiywGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f6929a-2c85-492c-5038-08df1e9cc151
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:31.9188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d0L2K3Vdlhfry9zRc/Vx+iIDRUvLOAUerhcImxo7PFjhGRad+bgTf4ZdMLyaQZb1QMEvLzNsC8MtGe2UHt1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Add some more size constants, mirroring include/linux/sizes.h. This is
useful for making `Alignment` implement `SizeConstants` in a following
patch, because these are more common alignment values.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/sizes.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
index 521b2b38bfe7..7d03361eae3d 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -35,6 +35,26 @@
 macro_rules! define_sizes {
     ($($type:ty),* $(,)?) => {
         define_sizes!(@internal [$($type),*]
+            /// `0x0000_0001`.
+            SZ_1,
+            /// `0x0000_0002`.
+            SZ_2,
+            /// `0x0000_0004`.
+            SZ_4,
+            /// `0x0000_0008`.
+            SZ_8,
+            /// `0x0000_0010`.
+            SZ_16,
+            /// `0x0000_0020`.
+            SZ_32,
+            /// `0x0000_0040`.
+            SZ_64,
+            /// `0x0000_0080`.
+            SZ_128,
+            /// `0x0000_0100`.
+            SZ_256,
+            /// `0x0000_0200`.
+            SZ_512,
             /// `0x0000_0400`.
             SZ_1K,
             /// `0x0000_0800`.

-- 
2.55.0

