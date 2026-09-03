Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F4AC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115FF10E138;
	Thu,  3 Sep 2026 13:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="gE4LAx0Q";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021078.outbound.protection.outlook.com [52.101.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F5F10E0F1
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlzWseuKaXsJVZIo+Hz64KOTCNMN3UiPMH8RXuwqK2RpXbxCujyhLorW9IhZwnIEQewZM8gJez07hRs/6INzDElA4nBI4K5OBmzhC1zSY0lUexSb+npK3nj7/txZquBo0Mw9WmP4f+JpGQR2Iim2CrYwtsPWUjkxvupnLvXW/oHP9fbdmezHfm9kO8N/RPJu62G+oQYs1JCUq0hoUQzQ77Nj7H0dF2IVUwlg6ElrbAsAoVKN8dZAMV1XYLA9rzgYaPWMSP10rVpOndASlNe2ZxO2KWymrcIiuvQ7BlJHWKYErT+1lEMNiphq/t1rmaANF80PXu+4wlDYefRTnM/FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIVzaf3CYDKwc5bs/jFOAoA9pBOOX3UPellMa+CdTO4=;
 b=W/X0f/l73bF/Vjqlr0DIugkaX2d8saGFx0DXnlQTwcpKWnvmNGcGsX0pp7v3diYTDUiOe2oVRpIq+WiHgG+49AAV2QZ9slJBo4FL3JW7i8Xp0j/nPAWqqYijoccnBg1rDg4XRiJDm+JCm0k7X0EXR2ew0YYTtXyZHPBHQGBByKJ6e6cmhgPRkzxhqw/DYka9tU4y+ZonUv7Xo+5aRbpMTg656H0pu9bX5G8TikjzUs0UHqEajfrYy1wRT5EJwesUXDEYOQEkBJUiCiUDsCIGtrfTTrzRESpXNOrxLLI2eyJBq50KVHqFi2U4mDqDHD4unQ5aTdw0qb0f6Ge2rGa8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIVzaf3CYDKwc5bs/jFOAoA9pBOOX3UPellMa+CdTO4=;
 b=gE4LAx0Qb4JAgUt//2IecYG5rXnpR5ExJAhQaQgz65/Omqy8/4pLneznzO9C9FycJYhPeX4wFvQOmPh9Hjct9B0XjKfjQSmzyz5OALVlAKEvjj9Os5DjeMKyAU65hA/fnRNMlJBTXzvdZa8bWD+hx8Ql1a5FPyFbBSmew+lZ1N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7602.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:12:24 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:12:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 14:12:23 +0100
Message-Id: <DL5PH2S8AP7E.25CW1PZIQ8BM3@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] rust: debugfs: drop 'static bound from ScopedDir
 file creation methods
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <mmaurer@google.com>
X-Mailer: aerc 0.22.0
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-2-dakr@kernel.org>
In-Reply-To: <20260830193824.471089-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4a2330-9d23-4ae0-72ec-08df09bcfeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|6133799003|22082099003|56012099006|17002099007|18002099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info: PrB13zxIvyit7nlRqSZxTrkE/u8RxObUL0K8XAejjw8uGHB+FLytvBQPaS0pMHcz4XkmINz6J7yjii76YrDUsJwEa7Yl6u6V9/YdEfAYxtibgYHNoNNKIqti/HiIi0zim171381Q+r756qYk0ityG+jeHku9/rg4gIEZCWK/xyuzMv6vO8Vn2tJLp34551kZqcR0CBQ8uAsOGzRVN6qDjQ3hg0+FYW6Quhl85RPXeffGCLyc/Lhv66xxFLSdKcHollo7a84KRbXh2tQmx1SlVsib1jU+FObQGxwn1/7NrMlkYnN/qXMGuWnULnsiKBnkegMMpdN5RjWItCcVPqoisY+bLCCBHAMnypPojUUHDtb2LwI6ks1AXmXlz+UPLWW9O3kknEMy6ReasliOKy+F8q6ZrOdrWs/DZkpy88IytVlscPOpRtRMecy7f9xwVG4LEpCaMvbq0TNWGNH9OeuNtO2lFFc3nRp4XPrshbuLwvTF8Qfy/6PUeYtjFzL41BtLIDLLdW+Taei1gSDNwg8hgoRu66cOIiCvgXneL4fSDX2h58pXoFkOKRD5y9RoDuZcP30L044iImM2JgorljlLfiEnH72YahkodvKkDXOVdl0CG7JkK6PsdVVCCQMIH47kF30ge9vBgQpWczhp0x06VX/xhy75zZCyGi1RTjYFxnDesTgroOhhMcpZVB+KBqZomXArfnf6/Df7zmWdIxxhvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(56012099006)(17002099007)(18002099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThFWEd3RXpuNzhPTnd1VjA2ZlQyK1RVV0NFWkxJU2x4TlIxdTZMbWR2ZTl2?=
 =?utf-8?B?cjh2Z0NONER5SkgxYWhKM2gzd25jeHlleEJVNmJla1c0UHd4bUNFUDdiZENF?=
 =?utf-8?B?SENRdFgvQWJ4UFo0WTZ5N2cwQ011K0ovWnI3UG5MN0VxWW5iZVFrR0dOTFlo?=
 =?utf-8?B?aUZUQXgyNVlaYjFrYWpjSFRLZnNGT2NFQjBKenZQTTFPUDk3NG1XcWNhNGFL?=
 =?utf-8?B?US9ZNmlZcHpKZno3cnpiM0MyaHZRQlpsRFlva0krbE1JbWZ1b3NqdXRBQmxi?=
 =?utf-8?B?QUlXVkhwZlI5K3ZIT1dtbFM4Sms2QkZ6SytsTzkreEVKVGZwR1NHZmlYMWcy?=
 =?utf-8?B?RXc4L1lVVjdacDdDVFVSTTNGOW1hRUlDNDVZc2dRY1pLSzBUSjBwZ3UxR1Qx?=
 =?utf-8?B?TllhWUY0QjFGOHRhVHpreTRTcVZQOFBvU1YyV0FoeXpnTmZwTVJpbUF2ZXVF?=
 =?utf-8?B?ZlhDZXIrUFJoU1RkODBWRHJQTWRncFhVMTRaRUZnSHY5dGI4aGw2TkxQNi93?=
 =?utf-8?B?K0N1azFmL2hTbkthbFNKNjEyWDZjeUdBN2p6MGxITVlIdjE3dzBtNjdsMUt3?=
 =?utf-8?B?RUF2bGhoczNMUSswSWR4RTY2cEQ1b3dXbnJEcHNha3JtUVZMRmptUTlaWGZ5?=
 =?utf-8?B?Ny8yKzNNeTZmQXdsLzRGUzNLOWxjeVBXWmoxZi9iMkx0UHZkbDgzdm1kQzJk?=
 =?utf-8?B?ZThWUWoxZitwS2ZJNTZWdnpPbVUyQzZTZUdKV000VG5VTkNyaEtMWXAveFBn?=
 =?utf-8?B?WXNpUU1jKy9pNHlzZXZpc0UzNWNpZGRmaUx1RzlGb3Z0ZnR6VW5OdklCNGx1?=
 =?utf-8?B?d3BKWXE2REtSTTF0ZWc4cXNORlE3MnF4R0srTEhBakh2eTV2SnVibWNLT0li?=
 =?utf-8?B?OFlhdm1QcHp5Q3NabnNodmxHU3pBaHE2eXlYS3VPZ0srNXc3eWFrQ2xyOG8x?=
 =?utf-8?B?Rkg5V2NEWnhMTExrQUplYTlZUER1bmlrS3J3dXJZbkl6WXBnVmpMOElkZDBq?=
 =?utf-8?B?ek9DRE80YUVVRGQvbVBXb3FYNy9kNUk0WlJEQW5WTG5tRDZMV1l2bkFrTmN5?=
 =?utf-8?B?VFRwOGxERXZDVzc1RnlIbEhIWXh1dTFCZlBNb0pKakxKN2JvT3UxNTNmK3NI?=
 =?utf-8?B?Wnk4Mm81ZFljTWFndk9tS2tCLzkyUUYvR2w3czd2bFNrT2M3QXVPVGI2TWFQ?=
 =?utf-8?B?MGRNeE15MklON3lvR2xGUWpHYmN2cG9ha3hEdHEwangzUmJOMXNhcVkwU2lh?=
 =?utf-8?B?TkRhWENlSFQ2d2U3dWwzWi9vUGNIWFFnNUs2NFYvMDVFSjAyZklCK3RXSDZa?=
 =?utf-8?B?WDVQcG9BcXhVd0p0ai9IOGlkNnZJSFNEWk5vcDFKKzdBdnphbWhWQkxzQWFx?=
 =?utf-8?B?azZCSStRd2Z3dTdSSE82T2YrYlVQdEl5S01KY1JOTGlGU2VTWURPaGc2VlRw?=
 =?utf-8?B?aVBNaWZPOVQ0ZEpVaWRMcGc2U0RRVGVQYnkvTVpFMGVvZlFsdFFUN0RLdzdu?=
 =?utf-8?B?RWM5K204WDVmZFpwYTFscExyVExTTDBpeHFldGhDTmtRYlRRdDhMWkNqcStv?=
 =?utf-8?B?ZUVqaFEvMlBTL2l3dWJ6VkJnNU1CYVR2WFdKU21aSkF6TTVMalZTTGVkOEs5?=
 =?utf-8?B?M3k0MDJxMzY5QldMNkFxMnF4ZTRHWEloUlFMR3V0djNFTXkyT0FjU1N2SHBL?=
 =?utf-8?B?RjBZY2NGMkVPSWNKbjRLNGkxWTVXdG93QUFJeHpyZWNTeWJjMEFEYUplZHBE?=
 =?utf-8?B?YmdQa0YvM1dKNW4zQ0JJTnJDS01DN1Q5Um1ZWVdvWlF5aDV3bHRScDlDZjll?=
 =?utf-8?B?UVFrM0JJRFRGRmNSb3draEZNanI1dTZOb3EzaXhoYmN3RWFJOTdURGJxMjMw?=
 =?utf-8?B?OEdaVnhWM2lXS0RidjBKUythb1FpK0ZUZ04yeHBNRjF6T1VhRUo0WFVBcUFC?=
 =?utf-8?B?a2t2Z29pNmtDaHNZb0hQODNmQnJjdmxKcktJUnAwZTBORWNucjZwR1JrMDRN?=
 =?utf-8?B?VjNBRWFHL1JBQlZSY1IxbEVLb2ZseTRRZHUxUndCWDd0WkRyWHdzeFd5Wklh?=
 =?utf-8?B?VWxtdjFJcUhCQnNLdGFyUll3NktIT3BScngwSG54R3A2QUZNRFRFb1Vqeitw?=
 =?utf-8?B?NGJCNEI0SWM3by9HTUpVUnYvT1VhSitQcVNWTC9hTzNOSGl5ZXlCd1QxYlpz?=
 =?utf-8?B?cXN3YkFtUzhXRVpTek1qUi9EekxjRDU1R3Bld1c0WUxuVUVFakNoYkxhdHIr?=
 =?utf-8?B?bWFEdS83NlF0T2ZQenlvTGVySkhlYU1uQlB2OUdtZzNNTjlGSUI5WkdOdjha?=
 =?utf-8?B?bXVmWVQwRlFZZGVxM0V3M3NRZEVGZ3N6ZGxOYjNsS2tlUm41amlzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4a2330-9d23-4ae0-72ec-08df09bcfeb4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:12:24.2725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6J9juE/3Adj0lPeXb7TjT2d4KporYJWJoDlTaetORW5kdtkYxppeczCp7BB87iTzEg/KXlLzjUimTbwdKLPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7602
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

On Sun Aug 30, 2026 at 8:37 PM BST, Danilo Krummrich wrote:
> Drop the T: 'static bound from ScopedDir's file creation methods
> (read_binary_file(), read_only_file(), etc.) to support registering
> debugfs files backed by types that contain non-'static references, such
> as dma::Coherent<'a, T>.
>
> The previous 'static bound existed because ScopedDir::create_file() took
> &'static FileOps<T>, and &'static requires T: 'static for well-
> formedness. However, this was overly conservative; FileOps instances are
> always associated consts residing in static storage, so the pointer
> passed to the C debugfs API is always valid for the file's lifetime.
>
> Formalize this as a type invariant on FileOps. All instances reside in
> static storage, enforced by requiring FileOps::new() to only be used in
> const/static items. Replace the Deref impl with an explicit fops()
> method that returns &'static bindings::file_operations, justified by the
> type invariant.
>
> With this, ScopedDir::create_file() takes &FileOps<T> (no 'static),
> preserving the generic type safety (T links the fops to the data type)
> while allowing non-'static T.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/debugfs.rs          | 26 +++++------------
>  rust/kernel/debugfs/entry.rs    |  4 +--
>  rust/kernel/debugfs/file_ops.rs | 52 +++++++++++++++++++--------------
>  3 files changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index d7b8014a6474..2beb55d444ca 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -538,7 +538,7 @@ pub fn dir<'dir2>(&'dir2 self, name: &CStr) -> Scoped=
Dir<'data, 'dir2> {
>          }
>      }
> =20
> -    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: =
&'static FileOps<T>) {
> +    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: =
&FileOps<T>) {
>          #[cfg(CONFIG_DEBUG_FS)]
>          core::mem::forget(Entry::file(name, &self.entry, data, vtable));

With the signature change you're relying on static promotion to happen -- w=
hich
would still happen without a lifetime bound, but I find it somewhat
uncomfortable relying on that fact without a lifetime check.

>      }
> @@ -550,7 +550,7 @@ fn create_file<T: Sync>(&self, name: &CStr, data: &'d=
ata T, vtable: &'static Fil
>      /// This function does not produce an owning handle to the file. The=
 created
>      /// file is removed when the [`Scope`] that this directory belongs
>      /// to is dropped.
> -    pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name=
: &CStr, data: &'data T) {
> +    pub fn read_only_file<T: Writer + Send + Sync>(&self, name: &CStr, d=
ata: &'data T) {
>          self.create_file(name, data, &T::FILE_OPS)
>      }
> =20
> @@ -560,11 +560,7 @@ pub fn read_only_file<T: Writer + Send + Sync + 'sta=
tic>(&self, name: &CStr, dat
>      ///
>      /// This function does not produce an owning handle to the file. The=
 created file is removed
>      /// when the [`Scope`] that this directory belongs to is dropped.
> -    pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
> -        &self,
> -        name: &CStr,
> -        data: &'data T,
> -    ) {
> +    pub fn read_binary_file<T: BinaryWriter + Send + Sync>(&self, name: =
&CStr, data: &'data T) {
>          self.create_file(name, data, &T::FILE_OPS)
>      }
> =20
> @@ -596,11 +592,7 @@ pub fn read_callback_file<T, F>(&self, name: &CStr, =
data: &'data T, _f: &'static
>      /// This function does not produce an owning handle to the file. The=
 created
>      /// file is removed when the [`Scope`] that this directory belongs
>      /// to is dropped.
> -    pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
> -        &self,
> -        name: &CStr,
> -        data: &'data T,
> -    ) {
> +    pub fn read_write_file<T: Writer + Reader + Send + Sync>(&self, name=
: &CStr, data: &'data T) {
>          let vtable =3D &<T as ReadWriteFile<_>>::FILE_OPS;
>          self.create_file(name, data, vtable)
>      }
> @@ -612,7 +604,7 @@ pub fn read_write_file<T: Writer + Reader + Send + Sy=
nc + 'static>(
>      ///
>      /// This function does not produce an owning handle to the file. The=
 created file is removed
>      /// when the [`Scope`] that this directory belongs to is dropped.
> -    pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send =
+ Sync + 'static>(
> +    pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send =
+ Sync>(
>          &self,
>          name: &CStr,
>          data: &'data T,
> @@ -655,7 +647,7 @@ pub fn read_write_callback_file<T, F, W>(
>      /// This function does not produce an owning handle to the file. The=
 created
>      /// file is removed when the [`Scope`] that this directory belongs
>      /// to is dropped.
> -    pub fn write_only_file<T: Reader + Send + Sync + 'static>(&self, nam=
e: &CStr, data: &'data T) {
> +    pub fn write_only_file<T: Reader + Send + Sync>(&self, name: &CStr, =
data: &'data T) {
>          let vtable =3D &<T as WriteFile<_>>::FILE_OPS;
>          self.create_file(name, data, vtable)
>      }
> @@ -666,11 +658,7 @@ pub fn write_only_file<T: Reader + Send + Sync + 'st=
atic>(&self, name: &CStr, da
>      ///
>      /// This function does not produce an owning handle to the file. The=
 created file is removed
>      /// when the [`Scope`] that this directory belongs to is dropped.
> -    pub fn write_binary_file<T: BinaryReader + Send + Sync + 'static>(
> -        &self,
> -        name: &CStr,
> -        data: &'data T,
> -    ) {
> +    pub fn write_binary_file<T: BinaryReader + Send + Sync>(&self, name:=
 &CStr, data: &'data T) {
>          self.create_file(name, data, &T::FILE_OPS)
>      }
> =20
> diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
> index 46aad64896ec..88a870d8c295 100644
> --- a/rust/kernel/debugfs/entry.rs
> +++ b/rust/kernel/debugfs/entry.rs
> @@ -74,7 +74,7 @@ pub(crate) unsafe fn dynamic_file<T>(
>                  parent.as_ptr(),
>                  core::ptr::from_ref(data) as *mut c_void,
>                  core::ptr::null(),
> -                &**file_ops,
> +                file_ops.fops(),
>              )
>          };
> =20
> @@ -127,7 +127,7 @@ pub(crate) fn file<T>(
>                  parent.as_ptr(),
>                  core::ptr::from_ref(data) as *mut c_void,
>                  core::ptr::null(),
> -                &**file_ops,
> +                file_ops.fops(),
>              )
>          };
> =20
> diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_o=
ps.rs
> index f15908f71c4a..7e1dd8c75ad9 100644
> --- a/rust/kernel/debugfs/file_ops.rs
> +++ b/rust/kernel/debugfs/file_ops.rs
> @@ -20,14 +20,12 @@
> =20
>  use core::marker::PhantomData;
> =20
> -#[cfg(CONFIG_DEBUG_FS)]
> -use core::ops::Deref;
> -
> -/// # Invariant
> +/// # Invariants
>  ///
> -/// `FileOps<T>` will always contain an `operations` which is safe to us=
e for a file backed
> -/// off an inode which has a pointer to a `T` in its private data that i=
s safe to convert
> -/// into a reference.
> +/// - `FileOps<T>` will always contain an `operations` which is safe to =
use for a file backed
> +///   off an inode which has a pointer to a `T` in its private data that=
 is safe to convert
> +///   into a reference.
> +/// - Every instance of `FileOps<T>` resides in static storage.

This can be better done by storing `&'static bindings::file_operations` in
`FileOps<T>` instead of just by value. That is actually better than the cur=
rent
impl, IMO, because `mode` for example doesn't have to be in static storage.=
 (You
can also then make `FileOps<T>` `Copy`).

If you made the change, you'd still have `&'static` checked at compile time=
, and
the fops below can be safe.

Best,
Gary

>  pub(super) struct FileOps<T> {
>      #[cfg(CONFIG_DEBUG_FS)]
>      operations: bindings::file_operations,
> @@ -39,9 +37,13 @@ pub(super) struct FileOps<T> {
>  impl<T> FileOps<T> {
>      /// # Safety
>      ///
> -    /// The caller asserts that the provided `operations` is safe to use=
 for a file whose
> -    /// inode has a pointer to `T` in its private data that is safe to c=
onvert into a reference.
> +    /// - The caller asserts that the provided `operations` is safe to u=
se for a file whose
> +    ///   inode has a pointer to `T` in its private data that is safe to=
 convert into a reference.
> +    /// - Must only be used to initialize a `const` or `static` item, to=
 uphold the type invariant
> +    ///   that all `FileOps` instances reside in static storage.
>      const unsafe fn new(operations: bindings::file_operations, mode: u16=
) -> Self {
> +        // INVARIANT: The caller is required to only use this in a `cons=
t` or `static` item,
> +        // ensuring that all `FileOps` instances reside in static storag=
e.
>          Self {
>              #[cfg(CONFIG_DEBUG_FS)]
>              operations,
> @@ -65,11 +67,11 @@ pub(super) const fn adapt(&self) -> &FileOps<T::Inner=
> {
>  }
> =20
>  #[cfg(CONFIG_DEBUG_FS)]
> -impl<T> Deref for FileOps<T> {
> -    type Target =3D bindings::file_operations;
> -
> -    fn deref(&self) -> &Self::Target {
> -        &self.operations
> +impl<T> FileOps<T> {
> +    /// Returns a `'static` reference to the inner `file_operations`.
> +    pub(crate) fn fops(&self) -> &'static bindings::file_operations {
> +        // SAFETY: By the type invariant, `self` resides in static stora=
ge.
> +        unsafe { core::mem::transmute(&self.operations) }
>      }
>  }
> =20

