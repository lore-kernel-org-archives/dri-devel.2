Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A740C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C8B10EECB;
	Thu, 27 Aug 2026 07:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6Bav958";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDEA10EEC7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFpa6xR0cMjB8OjKe0zO5493p7a+ch6hSZgwbCB3nZN8SJk/0k/slHaCBPEZe6NpCtg8Yy6iRzG0h0Q6jBl6SFuHp+jpAula5sqzKnvmUUbeUEEE9ezxMjavPkvVlX+MBiqnxbIlQj97sbN64/+3h81GtBsFUvayH03TQrh5k1rMhkjsofFgqif+IiLog5qQHjemlTXlyfGOYNXCP3hPJ5wF0f4zYWfgXC44aqPj2/78rdFHjNHrxwwlmcg7y0Mhxb2kvBzgIjH49D78TY7u/Trvjvopkq13haG5Rv4s3poCh/d8C9yvKtESTvMx1m6F1JW4AUyUogN5tlF0k4UpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5aLLm7ugufMFPvjCTovVkma4So9mGCQdTkhGB6v5r4=;
 b=glFLHno7PG1RKjDUE8MAlvKkQXh7zfMFM3B1P+o2M3pjf+AgwYCFiQCyTohZ6ZHIZoj2MPxwVYqZcEoz4GvttOPMIB2vLUAZUzr3PN6dhlvQ8ZwqnPNh8hSBfsMoL2UH89oTh7uXRTOMrgcjxju4pXdOFDFZlM+sB8eZhrKpsUuRQucuirlz+KFN5EIX6wXSolTGmvotvV5PX515vfcldCZ5rArQe5WqdE37ArtNJKOr38Q24B8W2uUgl64JMGdsRUxeOtaxCNL91ujDY7unQR+vMNe+yYw50vPjlsnLuSAnwh2NtVz1CzMWeMJnkUT1VsZQz9W18Dl5GIe3L6ldew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5aLLm7ugufMFPvjCTovVkma4So9mGCQdTkhGB6v5r4=;
 b=V6Bav958HmNouV/C4vTMZgRpH6XIszVewbovQ2Q8sYJ0qGzemOUwSCkk+ztlnog8twBozrztnbFv9kPOzh7QOUR+zoejZy084mAzBTDE8pqwAlPK3Y2L3/3IlKy2ldKB6r9uIOe/nqMllgJviJv1GpeApktIb0flZFiFJx0m6MlNnrXN+USFupRO7MNsgL5Zm4q6LLtwEk6xTnXlkxxX+BzSadqqCM//hJuA/i4J2Rd9FMVgvKL0oAcu4ockkJyriKlavCILpJ1d7l19+Hel/8FwXHojO1FuUBv0xpu+oWqnzfHjrvQ4L/yn1Lb/us72r6p0fWuTgfTB/QeRHCm+1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:30 +0900
Subject: [PATCH v8 02/12] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-2-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 081b81a3-ca4b-4370-f5db-08df040d0f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|6133799003|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: CwQJXxiSiyBpMHHxsNC4/FXszHieJuDvl2eCN8OUUTVRLKtqRl2OXwte4wezZOZhGrY9MDUJ0KyDuef94dLfC6GIzDoGrSVoot12StT6+yPoE9nb8WaTBIM6Deg7os51URHerBp5GS3eHwbrH4gwJ8i220ve0yt2fKAkLMfq9n30dofkkjMZ3/86EYbOsEndXFmOvQpayjfWM27byjtvNmD9lMarMuqL6TtvV6sXpzwnc7hYc7tC9N9M+Cm7shtiHMmxWwZfac2LNElVre/lelI1NUF/PBB5OdxWFLWaUK8XH4yDgJVk+3hb5wor53BkkJZ74u/BkiRu32zGE0M908EI20/yWasOiABqSWBDtoxpG9sCaISl9NG+6nnqOuDhAT3zciZJQK9nVbBImaZYl2rTkXPZb9zK9jXYV+ksr9vLj9y4PiVUCQhCWhm7/GhaKgw/uhhoGxwZ616VwLazvwa/t7hrb0VMUplcne/5j09rdZrudzqfUpg+tdhP+pJf/vzxDpgbqSoKRB/2B9vT66AooIXp/PtnSf070o71Wol0+hN5qAC/rtOlSVSDPw7Ya24WS/MLXg3QFn8jwDiHorOFeGdrX944cKV0aZybIdkNKdJodlMGAQZSO9DkJHYZkH8XaqPRGiUxwjWLamdTacqeGtt9cLGp13g2ebMs2ytKfzn9R10+xLIDJuQr9PAnbD59gpVbOBeUBXf9BFkVCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlyc29CeDNjT1BiYkRoNnR3alVidVg4eDYrVkZKaTg5RmNXdk41SC85a2Nq?=
 =?utf-8?B?bkZhR0hnMkhpM1VBM0NNOENoMkFKQ2NscFVlMVU5NE5hUGREMnJIWWlvelp3?=
 =?utf-8?B?bDNDZEM5MkJ5ZlZEbmZZZmVqNmdEZ21PNHpHUys5OWEyYUJrTXBNak9icU4x?=
 =?utf-8?B?KzRZZU9zYkdmMmt2R1p4MTM1d3ltL01DcUhybzU1UE9HS2ZGVFNrenNTRFk0?=
 =?utf-8?B?bVR3bVhxT0p6bDh5akpKWUVMdHdnTkllZ0V2SFcwNVV6NjlNTzEzNTJNVmNQ?=
 =?utf-8?B?d0VwSWI3NUYydEwxTTNpd0V0dUYrR3czY0NrbUVVTk45STJWVDV2L0tnR3F5?=
 =?utf-8?B?azhoaURTOVFNRmkzNmN3WC9wSTQyd2NhUks0NzJlV0NjdzBXaXVjMFgxYnlQ?=
 =?utf-8?B?VTdKVUtoYzdGUnNQNjhFUmxieE5NRDRRR3pLc0cralE4VXpnK0lZb0lSNkpP?=
 =?utf-8?B?allrN2FXTzFoaCt2SDlxd1JtWU5zU0RGNzd3UUVsZlJseXpoOExUWHlZa0xt?=
 =?utf-8?B?Z09xUWV6RjhSakhOOVpHUXJnV2tjeGpoakxxT1dNcnowd0tHeDRzUXFjV1N0?=
 =?utf-8?B?dUNqNDlLTVN0blQxd3FRbXBUbER4dUxJMTZHMXp6R3pGMmkyUndGYnBQa1Zq?=
 =?utf-8?B?NGx2RlRDY0YrRGJJM2NlWWo3ZnBSdDllMXpHbWJ0Q2lNUjh3LzR1L1VRV2FT?=
 =?utf-8?B?c2JMZU9GbGtwZlJuMzRmUDA0YlJuWXhjRGR1elJEeGJPQ2pRdnlMY3FtbFBu?=
 =?utf-8?B?SlVTVi9NMG4zd0prUW5xNk1HS0I4VHdZVkI5YWNTZ25PSE80d3R2Z0p3RFc2?=
 =?utf-8?B?SEFWdGx4eWlGbTZ5ZzYvSXBIbUpFMkVIRFU5SStsK0pHaDdtajlaRkdJNFRW?=
 =?utf-8?B?bFhIczB2dmJ0aUpSbzF6VnlkbktkWUkyS1QvclVpSWtkbHRuWitUditocWFw?=
 =?utf-8?B?RE9qQlRUcThDdnJSUjhyU0R3czVPZkVNbU5tVnE1dzkySGtLdEhyWUpjT25Z?=
 =?utf-8?B?UEllMGNxdHAzL09kNU96eUNvMXU3bnFsdXBsUDRJMm9MUk5vT2c0Rk1wbUVJ?=
 =?utf-8?B?N2NrRFltcDE5QUdFTm50eVo0T3p2WFluSEpiWDJzUHphT1cyUFBkQjZoMk44?=
 =?utf-8?B?dVE3VDdkeEVzZm5ydEZFeFNsdTgrVlB3UkRHc04wM2dXN0FKZkdKMXJ0Yjlr?=
 =?utf-8?B?VmFBa2JJQ2ZEYlJPdk5tVG9iRDk1dzExNmVNeVZURU1wazRUK3I3NGxGYkxl?=
 =?utf-8?B?RTRFMmVFSUxjSjRDNEhCVkViWDBWNjlhdG13V1lnNHBraEdNL1U5MWw0NlZK?=
 =?utf-8?B?c2ptWVRySms4ZmVYdW9JOE5wNHlyREMxN1hreHFqMDltSWJ2OUZBejFXYW1M?=
 =?utf-8?B?dkpzSXY3bFMyQzR6UVRuNG1qSXBramdqK2JBbGdVTnp3NzQ5SlZuUUVubmdl?=
 =?utf-8?B?RWEzaEErblZ0dW1ESkxsUmlKNitGcWpYR2x3bDUrQmFxc0hCdGg1aEczMGQ5?=
 =?utf-8?B?NWZkNGZIODJINFFjSGg3bXd0aG00QWVqdkF4VE5rSU05UVlEazJwRDdZMGZu?=
 =?utf-8?B?WDZtVzFBSEhBZHI3bXl5VHFwSXA2bC9RWkk4N0tuU25jMHIzN0gzZjBuMm9U?=
 =?utf-8?B?cy9JNlZhSkhmUGs0Y2c0SENtekY0Z200WGFld1hYRHdITXVqYi9WcUZFVnI1?=
 =?utf-8?B?UHU4VklpYkhPbHh5SGdjNkdHQy9YV2RGYWtRQmRoQXc5N2ZkdG83TmFYTlZD?=
 =?utf-8?B?QnAxN0YwOW9EVzRFMGNSWU93V2RHOXFFOUtGQ1dlV092S0UyYnJGMWpLYktI?=
 =?utf-8?B?RlhGMzR2ckorclA3WFpQbDZiQzRYM0x0NHNTQi9nRDN6Ni9laGxBUEk5Rnlv?=
 =?utf-8?B?MDhKUjBMN3I1VFUzcTY1aTZYeDVqTndsbkVxMWVDd2k5NGw1TE5kRmJvdUxr?=
 =?utf-8?B?YXlDNkpTZlArUlR6ckNGdXJDU1RmTUtXekNjbmNCY3lsMlRiNE83T1dxZ3ZI?=
 =?utf-8?B?Vi81R2RVTk9GYitjRXNUcHBIV0o3UlY2ZzR5UmxhekJlSVJyUnF0YXUyRnFS?=
 =?utf-8?B?QjlVRDhjaGpTaXYxb0dIYVFUcVNJeVZhelorRXFhY2hGRC94eTEvS1lRS1Mr?=
 =?utf-8?B?U3pYYUtpQWtCU09xVEhIVlFOdDg2M1VOeGVNZzFoOHM4SGFRQVk1V1oxK3l6?=
 =?utf-8?B?NEtkd1VBb24vaHVQbVpHVEZncmRNTzkxaVBacmwySkVQMC9OUDlOSGtjTUhP?=
 =?utf-8?B?OHUxQnY4dUxjSWFmQ2dodzlqeDNyWHFvTm5RbG9JSUpEcjBMWWNTcHI4dkNa?=
 =?utf-8?B?OVZLOThyZzBGb3Q5VUthdlRNMFdwWndIZGVtUkphYVFKd1h3Yk9sWlhPTXBC?=
 =?utf-8?Q?HwO9NZpIUjVTaVftgoWXJ+SCJlIh/Tz57VK1wQ+wsqT3F?=
X-MS-Exchange-AntiSpam-MessageData-1: E+mSX/dx/iq8PQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081b81a3-ca4b-4370-f5db-08df040d0f0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:24.4529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pc7zddrsjAhy2mXXoAUw5dlGun2Xsh8z6tTrtk/klzmPd/ndKcPA0w7PHnlOqVxPEC2SqxS0pYrFe2dzFvDEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

It is currently possible to construct a non-`BitmapVec` backed `Bitmap`
using `Bitmap::from_raw` that is larger than `i32::MAX`, and it is not
part of the unsafe requirements. Restricting all bitmaps (even
non-`BitmapVec` backed ones) to a maximum size of `i32::MAX` simplifies
a few things and matches `BitmapVec::MAX_LEN`. For example,
`copy_and_extend` truncates `len` to u32, which is wrong for > u32::MAX
size. `__bitmap_set` and `__bitmap_clear` need i32 for `size` and u32
for `start` - so they can't be run on a `Bitmap` with a > i32::MAX size.
Rather than adding runtime checks to account for the case of a non
`BitmapVec` backed `Bitmap`, just include that in the requirements for
`Bitmap`.

Add that requirement to the unsafe requirements on `Bitmap::from_raw`
and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.

This also fixes u32 casts truncating in `copy_and_extend`, which could
otherwise lead to OOB writes.

Fixes: 11eca92a2cae ("rust: add bitmap API.")
Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 70 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..df5505ec7a96 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -17,24 +17,59 @@
 /// # Invariants
 ///
 /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+/// Must not be longer than `i32::MAX` bits, so offsets and lengths used with
+/// `Bitmap` functions fit in the int and unsigned int arguments of the C bitmap API.
+/// This also matches [`BitmapVec::MAX_LEN`].
 #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
 #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
 pub struct Bitmap {
     data: [()],
 }
 
+macro_rules! bitmap_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+    }
+}
+
+macro_rules! bitmap_assert_return {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+
+        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+        if !($cond) {
+            pr_err!($($arg)*);
+            return
+        }
+    }
+}
+
 impl Bitmap {
     /// Borrows a C bitmap.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * concurrent access only happens through atomic operations
     pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -51,15 +86,27 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
 
     /// Borrows a C bitmap exclusively.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * no concurrent access may happen.
     pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -96,26 +143,6 @@ union BitmapRepr {
     ptr: NonNull<usize>,
 }
 
-macro_rules! bitmap_assert {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-    }
-}
-
-macro_rules! bitmap_assert_return {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        if !($cond) {
-            pr_err!($($arg)*);
-            return
-        }
-    }
-}
-
 /// Represents an owned bitmap.
 ///
 /// Wraps underlying C bitmap API. See [`Bitmap`] for available
@@ -415,7 +442,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
     #[inline]
     pub fn copy_and_extend(&mut self, src: &Bitmap) {
         let len = core::cmp::min(src.len(), self.len());
-        // SAFETY: access to `self` and `src` is within bounds.
+        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
+        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
         unsafe {
             bindings::bitmap_copy_and_extend(
                 self.as_mut_ptr(),

-- 
2.55.0

