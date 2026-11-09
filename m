Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E00606D80A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CWWlQzRI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913EB10F0D8;
	Mon,  9 Nov 2026 08:33:33 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4E610E883
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfLHbDaT5TfxEe/DLIy6eDG4d8ca0EYVcIY4SUtA3TC4Kn+UYDKSnLXrtxlKcstad4uc/aOcuDM0z63hnfjqbPgQ1s7Lg7zBbF3RXWEKZyCMXPIJWIzL7DXWOv4t6/l0/aNkPa8Qb2C5rODAwQ7dQNJ8JDheFCoTVXJ+tu3sxjMb+1WOQUIVlRPkv94Jsqq9roDQ07fezLkHoim9YbDtNhR0B/ouFVZr1lMiO6RsTo3zQ2JXuy5+9xllRltN/0081GuDxptBGLIZ7nXcvZN57Th1BmqZqIM/VzlSkYZUWtXSW3hZFPJYmbUJb72QswtOJZLzXtAWTwCfOxQCM1t2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em/rA/izVCD6PB9qTV90Hhv3DyaX2d/T1uMChpAGSsQ=;
 b=hlQxvaxKTsUgS2uNZL8//PZiSiOtCkZRTeGSEQbkQSF2b+M5kmGql9HMW3BfjviAH2NWYH2gyHELitHd/usrm3yRD8NGvjv2SrzUfLiycDpRHMN/Vo9os+NPX9Y1zRYj1y1jamk2Nbp5eIzTn8qIomnTmg+2fg1RaHpGqTRclrf22bGAPKuvC6d1YJOGe+nMMyMe/ClGvF9s7GtdS3JVgqTOjEe++2bKchBSv85Ad/DITCdmYrcWFojLMcjDtgrSNuBqDC6QubL7PD/bnqIu8jpSKzMPdbexQ3mkJmbllRuBNCKtOaQzdWjhBaVjWmsCnFk4FGH7TNC8SivE0sJEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em/rA/izVCD6PB9qTV90Hhv3DyaX2d/T1uMChpAGSsQ=;
 b=CWWlQzRI4UatNIZ5ZQvCrwZlbIZaa5kSKj+Ex6TbjUQuUI7iavQQ+gTaumfauV/Cxs6djib444IKo7Fk8iepCCj/yenavKx/iwl3gKUiqgsXBouKLAlkcx/Snejyrg5lbf1udwbcEsFjlYdfDHZUwCuopyh2A0jqL7ojQcUJ2AOxXvIVnzKjliYgG/0HdHV/Xaca5N1f2CphzOZCRUUeM6EJQeGbP96dYZyp4VCHf8ZS/H14otQvgUzmQYK7pB0TkrHIkzzsVC/fQ+Vui54PdLW1I/4lmlkdy9sjPtvZ9lqQzZYjXLubc+O8CUJm4Fc3ZHlfmZiG5GM38ZdOxsK9+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:33:18 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:33:18 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 09 Nov 2026 17:32:52 +0900
Subject: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0083.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8e386b-6d7d-49c5-3202-08df3e3c1aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|22082099003|18002099003|10067099003|921020|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jj2KoCpvI7zFwo3Y2gbqUvJZgFxtJZif2xmUL3UfXpJ/BtXABN0OkXR8t+7PA/FdKdawUywp+ubwxZGB28gFgbMw5wHuwWFKEiL+vmMves+5VzB6wC9r7bFKcunQXsuto42ufShpGqepo2v1Ldcjve6lLJyWDQYPBOB+2VU+7hIMApkh5ADh63hVarVpFpAUV83Cvv/CCPHx5jY0RmvEuMv1tBZ26K8fUKKFu+F4f4bvoEWPAKhqzwiLjT5SgiBskitihG64RC2GJGXhsftQrsI3EBkdC7T3vZigZzJi9c3P6WaZU5sfVyN+TOZ38pqSqehGc5jzqlCA6qs2SOVmhG04LDBJyAu6NnKiShfXQfZ70rY6hHqljai7O1BBPwELGv5PwGNzkq6nEdJsEDZYzrZSFKFjGrAkXIkp5eshouga9z1naQHnUdSbgCNLuEUmp3dhzAS+hCMXBSrj7gPDJUwXd+056huV/PY7IV8pCn7vbYDPXFKk1rDMxxuHzZ6jZq8Ow+SJE421+ZVHi8WiSgsm13ilfGW5CX+9NehhCFSg5zoYqQg7ZMq+/VdTjhqIN2wz5j2b8E1EU5aUMlS5jChquy6wQOAIM+RvGAiR3SJgDv5zubV9vZ0MnYT/t1DFi7YXXegPAL0ROzIjQ2FLbkJ2SYwHMfwXiU+bXFN/2YKbqciibhCEyPlr97/HOcD/zOiGgwks/bTpE6xYOK1s1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzdrbnd4T1BnUUdPSmNGTlBta1JsSmluditMNzhSa0Rqa3J6bm9oRlBIdk1t?=
 =?utf-8?B?bnE1Smd5QWdPeTh5T0dMbTFzaE5Hc3VQdUg5dDZTS2VxYTIrSVdmQU9WT2hk?=
 =?utf-8?B?Mm40Zk9xcDlSak9Cb3Y3K2pVSjZLWHk0Q2RKTmpkQW4vWnYrSGdjQndTeit3?=
 =?utf-8?B?SHoxNDVpNmZuRmdTbW5sNUp6NTc2b24yNDQyMytUcDRqMXdDcTVlMWJ1RVVn?=
 =?utf-8?B?RjBFN1NsWjJybXZKb3Q2RE4wdUlXTGdPclI5S3pDOGJjRzdFdXRtblFRTDBU?=
 =?utf-8?B?bytlZEJSYklEaE1XV0p1Z1RSME5kVXR3WXFOMS8raHZGcW9VQUowUmtjWGRU?=
 =?utf-8?B?WGh3MzNlRGJlZ2w5ZWpnQUtXelVuUXJHdGRlYTB6TUdVdEJpMW11cFk3VEIr?=
 =?utf-8?B?eWZLbjQ1ZXZqd0d1OHZCaHpKWjg1SHhKdXkzUDB0eEJiT1Z2TzVUNDI3NUQr?=
 =?utf-8?B?WXFrQlBqQ21EajRTUHdtOENUbW13RlNIbUkwLzUxaEFmT0h6Y1kzVXpGOTdy?=
 =?utf-8?B?dzRnbjVtaUI5WHpIWGVuMFJ5MkNmVUlaeEtWQityc1pMY21XRmE3TWRFbGxL?=
 =?utf-8?B?SmNIeTE3b1EvRmgvbHhKemZDUlVEMHJud0JzeUcwazJoeEgwdEZxY2lOKzdp?=
 =?utf-8?B?U3ljakVMVURPbGx2dnpQWjRreTdHV2pMbHRGZm80QVdKdXJmZlhIcEdyODRK?=
 =?utf-8?B?MVIwY2VCRHRYU281Q1RDVHZ1Wm9rSmVYWVVCMGNGazhRTkpNcmk4K0IrTkpV?=
 =?utf-8?B?MnNDUExZNVpqRmU4YUJYemdhRVY2SG1vNzc4VEI1V1JDa2JybktCUVdPOXdJ?=
 =?utf-8?B?b1NiVTM2dm1xaUh6cmdxeFltSUdZQ2toOVVWNXFTQmJOc2Eybk82VGYzMkl5?=
 =?utf-8?B?QnJtY0ZacFdOcDU1R0RHOUdjRXJ0cHFKYW1pN3B3WkJmWm1rT2VNaEIrUWxX?=
 =?utf-8?B?MTdYKzg0Sk43V2lyUTNCQms1SHFveWVUTmhnL1ZQbXRWekFiNG9CWWdybEdZ?=
 =?utf-8?B?SWtSQjR5SkxvWXo1Zmg4WWt0ckk2dzdYcmlOWThWMXppS0J2MVdFYllFOFAw?=
 =?utf-8?B?YW9UbkF1UnYvbXZPYk01eWVrRkNVN2gydjg0dndMa0RTbHk4MVJEcVVWR1Bx?=
 =?utf-8?B?U2xmU2EweGxQaGpYOFE5UEZ6WFV0dnIrdkVOSnZJYXZxMmh2SzlaUHY2WHBa?=
 =?utf-8?B?TlpSaVhEbC84LzIzcVRGblBVQXl2MmU4WHBEOEJSN0VzdElGcUQ5eTJvOW9Y?=
 =?utf-8?B?VTgrY3FzMFM5d3ZBY3pqWEhmRzhsQkpXU0FQdksvNGtnbEJPUk9YdGM1N1lM?=
 =?utf-8?B?azErR1RTOURvNDNtNm1sK0c1NG5aYjZXVFY5b0NpbnZXM0NaTnU0ZWx6Y3k2?=
 =?utf-8?B?VHpubEJPNk9CUjZIeEc0S01NWEZsd3FJVE8rUkVtbmVGeTFmNjh0dXhxRW9P?=
 =?utf-8?B?ODdVYWw3Z0JpR1gydEQvKy8vSThwT0RsZW1nbE03cDhvUDNLTXZ6NXhtNEZF?=
 =?utf-8?B?bzZOMW5sVDFUSTA4aVdwSDVZYjVUc2ZvdDJyaE5ZWGxFTlprcnNJdUh5eDlT?=
 =?utf-8?B?cE5OTzlQUmxNY0JHbWJCQUM5d1ppNm5vMUswL0tzUzVtSFVYTlR5NjNWOXZy?=
 =?utf-8?B?K0ZTTGpPMWlrRjR4Y2tPTnhEM0lvMlZmV1N0QkNwaVIrUTY3QXpEckg0QjZP?=
 =?utf-8?B?QXJJR2RWQnVMejF1a0tMWmZtSnBuRkhFT2JWSm9FdDhuY3RuRTVEMzk5NldX?=
 =?utf-8?B?bDJuK2VVMDE3SXVOeC81OGVzcFhKTG1tUUo2bVllNTBxZmhQVFdoZGFpNkpD?=
 =?utf-8?B?MVNPL2dscHhuM3NPVFpKRmlTTnZBZUxEUEFLVnBpR1NlVS9pZHovSkpkN2Rk?=
 =?utf-8?B?eFBCcW9nYm1XUzJiYkg5Q0ZNQmFvTnlDUzhZTkJHdkxKeDhkcmsvSjdwcGtp?=
 =?utf-8?B?YWwrdGJQS011ZHYzbEIyeUI3MnBXRTBEbU43N3RXQkMrOWZvdW1NelRvMnBY?=
 =?utf-8?B?eDhIeTVSMVVMdlpmMy90S1oxa2RTUTZ3ZnYyTFJzS0tqV1JleWM0MmIycjU5?=
 =?utf-8?B?MkNBVnBZaDhRWmQ3OUx1WCtxcHRWV2hMOGRXSE1tbGVaYkJtdExJbDAvcXpO?=
 =?utf-8?B?OGFrYjZJN2VRdi9kYWd0Z3FraHhnRGFJMEU3L3RaYklxMVJkYWpIK3Zab1la?=
 =?utf-8?B?NjdndkYzakM3UG5JaFJxZEhERzQ4RmZIVDNBSEc4TnVrZ3EycFpMbEFoekc4?=
 =?utf-8?B?ZThTWktVRGgxQjA1aTlNVFVzYjNWL3FSZUk3NDVrV0lsaDZjRWhGZ2tNUkFM?=
 =?utf-8?B?S00vbjluQndITGlYS21BSkdBem1pREVYZGFaZ01NM1cwTkg5ZEdab1lVMzMw?=
 =?utf-8?Q?1Qr3THjvcaNNlNAR7jpHoubVq2aL4pjV8SEcb6tfDJmSP?=
X-MS-Exchange-AntiSpam-MessageData-1: p9UHNgzjJ5sIrw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8e386b-6d7d-49c5-3202-08df3e3c1aa6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:33:17.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9RJjACySnx08lR7hqwzKwoYY+71ExYJ1EP0bDEtk5jcOsfS0/IyPh4+JtNtMB11Pa3FBUsOhSY+T0RjYL7o3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current code in IdPool::with_capacity rounds the capacity up to
BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
smaller than this and still uses an inline representation. Remove this
behaviour.

This allows specifying a real capacity of 0, which was not previously
possible. This breaks `grow_request` in this case, so change it to grow
to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
`shrink_request`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 92eeb7caa243..f77bd90325ff 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -112,13 +112,8 @@ pub fn new() -> Self {
     }
 
     /// Constructs a new [`IdPool`] with space for a specific number of bits.
-    ///
-    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
-    ///
-    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     #[inline]
     pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
         let map = BitmapVec::new(num_ids, flags)?;
         Ok(Self { map })
     }
@@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
     /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
     /// pool.shrink(resizer);
     /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
+    ///
+    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
+    /// assert!(pool.shrink_request().is_none());
+    ///
+    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
+    /// let small = IdPool::with_capacity(8, GFP_KERNEL)?;
+    /// assert!(small.shrink_request().is_none());
     /// # Ok::<(), AllocError>(())
     /// ```
     #[inline]
@@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer) {
 
     /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if possible.
     ///
+    /// Grows to at least [`MAX_INLINE_LEN`].
     /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`].
     ///
+    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     /// [`MAX_LEN`]: BitmapVec::MAX_LEN
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{
+    ///     alloc::AllocError,
+    ///     bitmap::BitmapVec,
+    ///     id_pool::IdPool, //
+    /// };
+    ///
+    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
+    /// let mut pool = IdPool::with_capacity(1, GFP_KERNEL)?;
+    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
+    /// pool.grow(resizer);
+    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
+    ///
+    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
+    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
+    /// pool.grow(resizer);
+    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
+    /// # Ok::<(), AllocError>(())
+    /// ```
     #[inline]
     pub fn grow_request(&self) -> Option<ReallocRequest> {
-        let num_ids = self.capacity() * 2;
+        let num_ids = usize::max(BitmapVec::MAX_INLINE_LEN, self.capacity() * 2);
         if num_ids > BitmapVec::MAX_LEN {
             return None;
         }

-- 
2.56.0

