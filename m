Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B19CC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C77610E663;
	Thu, 17 Sep 2026 08:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sw47KuNK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5471B10E663
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIRGzNMyv1xhSw1aRLrgsl26vlqDFZfqExb5rUOi008OQfJ4eu5+AcWyAC8JOlVqgKmHjuCwBaHEtIzi3wVV37qwBCnpcNGzgciMzjBljhKuq62GZA3sQw1qT6z2cOR4m/d7WbCW8apMz9jfjAwZR/IlwRflaGdhnCIXsAkAxrTpQSidD3zAUe5rAmQYMC7Y7290ZT8SPLTNdJ11JnGLK8dH4p5UeyZTebKsbJIA9hdUX1h6zA/hm1JZ5eBApsTgxGCy9oba/Rd+Y/P0le/RTFOMEzCr3CZxRlmCKldNDvVmXclvkgDymUFI2/7OpBLqUjijDihWPn1/GK43mMA9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMS1FIugYhsdli8tJjQoX+SyFNuQTQ2VusLS3zOkT/8=;
 b=nQiwLma2eze/8GG1hqCKz+JVgkjC+RxdsXIfSe3epBazAhhiQJPRLu5sDyHY0WlDhG91mYz9DX7Av+9oUcsV4CB6rhWn1jvQ4If1GZM0Sc+IuLZ/6yeITubTzumEb2RnFFr0HjHyamSCnLWvukBcekxJSNjlBYZ2LaR45r0j0wcwaUHO1PAv4z8btlgB2HGiSy916tbtICgOwj9wi93hghRNxL8alCEfYE+ZdF+wH+q6121yGytHG/NogdASyHzFb6ZNqJ0u8YoN5TTUFFjn6JGWA0uDVv2L3UHeA+LmDg0vNx+0mvoYjPUo2I8ZQiDyDRCJw65lja3Lf6oyDLQ5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMS1FIugYhsdli8tJjQoX+SyFNuQTQ2VusLS3zOkT/8=;
 b=Sw47KuNKtXDCtEJ95cj4fT3ZUEog5rfYZT4W2YYJ3R9y+6RmlW+9lSuK718ZCDKy/OjZElhdxvx+oVAo3tCOhGHrwUp2t3P3xRdb39tF+tt8qxZEz7VWJnhHo7taoHtDzj2Ezj46M5CYQHm7Ab+TiHrNCECw0asV6yx/qQkQWBkhdOxvzljWlkxA4/StTO6Oq8SuKp/UiiKOii3RhiDzJ1J4ZCtNIGvs/jl597i240epJ7dRJfHBHTyL0FpmFggyiKcAAhjwDPuTi3zQV2UUxgr0V+QztKrsLgv+YD8MN2VNXmyqJxeCHYycAr7x3yBwGrxpZZKyxPYiOhIcf0WcKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Thu, 17 Sep
 2026 08:35:15 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:35:15 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 17 Sep 2026 17:34:50 +0900
Subject: [PATCH v4 1/2] rust: num: add cv! macro to create values from
 constant expressions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-cv-v4-1-547ef5727451@nvidia.com>
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
In-Reply-To: <20260917-cv-v4-0-547ef5727451@nvidia.com>
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: dd18a6bf-4866-45bb-d0a7-08df149698bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|6133799003|18002099003|22082099003|3023799007|921020|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fsSZp8pDA7jdQRZfXQfsWN2+DCQKjfFoI59qKpc1/eZ7Ht8uaZquIxQjKaPxUPmRSljk2PnfnHhtiPx8YB+cqOyzPbJg6kJbo3HD//O5qbvnvGvpVhs4+uWR/nyUKnpal+zTq74V77U48HoapUE0DuA3AU5zACuED5/V380t/CSi3Pyvgez477/lChFPY9Tz2fGHpdlOBeVPVJiZwYdEhMsQ+RG9Wb1cja8evvITOVD9x3AMQ3cHzAH1iFQD7t07QHLNOj6AXVlXjMav7WxlS37l2P6ExaDVj8ooriZVLdK5Qe+2F964MPaVdFMMLWzolHPdbp1SJ9lZYLPp6PqqRRCiWls/4X2qmv/seWRY0ooBCb74pHFuMOXk+uvpdzWgRxOKS+pdPo8k8RG71ynvkpfjzlOktNCkoVr8mxzauvaDlICmwSRvyr1+JYMgeV/ZE6JBIGCS4uVPSS9touet1kxISZnPIsaDZbKGdVwsK45XW2/qqJRfncEujLK7KGY+qxPYPbg0kXYWGi9rX28Qv6lh2q5fSy4i1XVfeBUryomm72c8SJXrR2qbLTaLovAdUYn+jNHdT3z4gWycEBOBom6UZ9xRr10IwJNksIY6nMh5ta7h8cO9lH2BEKykynP/9M0uktsmte7BDDlw8jwnSRXrHnTegm1ugzOCgIcbmVN445Hl5bvcPd5BbAkyIw2Yc93i6/bFPYIj2D9UJQEhqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(921020)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFE4UnBMZGpsb3ZUZlI3R0lpL1BQTW4yZXQ0QnZ2b251Ujk2QkE3Q2NrOEhK?=
 =?utf-8?B?aW9oVS9WQXlsd1FGOEk3dE12RTJPZWlHRGU5TGNEaGEvUDlzYVhJVTF1czVG?=
 =?utf-8?B?TzJNb0lFMjlnR05ZYmdoNVlIQTVzdm5WbFBFRlo1bFJnUGQ1NThUMXM3WXJW?=
 =?utf-8?B?ZlJtMmpFK2tSeVB3dlJEVnUrMWovb2VKTWZMcjVWLzFyMHRvZHFDRituZmIz?=
 =?utf-8?B?RXcyWTc3eld6V3RkOFJkaU52VEF1NXZVNDdpem84VDF5cm0xbHE5aTdQRmFk?=
 =?utf-8?B?d1QwSU9SUEUrallIWTk4Z2hZelErVVJKVlN3ekZEZE5DRStCbnB5enJpdndI?=
 =?utf-8?B?WEFkNm40UEN3Q2RvUFhzZWowdlY3UWgyOXBpUE5pWjh1dFlqdlZOL05wK00w?=
 =?utf-8?B?YzR2TXB6SEVXUTN4QkRya2tiVU5Nd1NpNEh4aFRkL2N1Q1l3dE1lRWFDbDFL?=
 =?utf-8?B?UStUZFdYZjRKZkxxMjJzaWJ2WnBmM2o4QmhkTWJId2h4VlBoaW1uK1JXZ0lz?=
 =?utf-8?B?dWRGSlNPVE1OZ0lmejcxQjZ4VDgvMXJTK2luNllDUWF4UENNS0g4MmtJamI1?=
 =?utf-8?B?QmJiRGJvNkQ5b3RvcUlKK1I2TVdDZEp0cDhhTlR1NnUrQ2FTOElTRWFpaEth?=
 =?utf-8?B?QnBzbVhUcVNaMVBodm52SFZnMnVYQzhlNEFLeENsdEZ3M0tUT1JXME5vTTJq?=
 =?utf-8?B?QXhBMDNGTDd0bGJ0Qk01ZWFtVW44ajFhQWZZNzhMQ3l2bVBCenhBM2c0Lzc0?=
 =?utf-8?B?SzJLQ1dHMmpRVUhIVjFQTmxDQ2lOY1krd3hmZHVEOERxVWdRY0M2TDFJdUN0?=
 =?utf-8?B?YlBJbmI4WmNNc2dhdzYrYldBNGhmWGs0TitrbkVISVhmMEJ0WUE2UzA4ZnY4?=
 =?utf-8?B?dGllZUQzdUpFcVI4SlR1dm1IWEpZQzBCWVVyUS95dlJidElqS2xwVGNuTHUv?=
 =?utf-8?B?N1EwOTFMVERLaC9PeDlqc211M25IeXU1bm1uNk1KdnlQYWxzK2dqei9vZXYv?=
 =?utf-8?B?dDNjU01EeForenRjbmhKWFZzc1ZaVS9tNTQrbGY0M25pbmNKa3FmMDYxWUlK?=
 =?utf-8?B?b3hSeDdvenZ0Rm4vSWw3QmI4SUNLbDNjN0t4MkdhejlnNURFYmZVajhaMll1?=
 =?utf-8?B?MVdqRUZtaHp6N0FlcGRybXJQMHNROHVZazJPbjgxVlFMTUtUTk5lZzZzQWdL?=
 =?utf-8?B?VG5ueDlpb00xREx6YjN1TXR1K1d0b1ZLYnlqdkd3eEE5MDd6b29WNXFka1Bh?=
 =?utf-8?B?MGJzMURFTjZFZVNUTUxUUE9UaklxMXpsaEdJTUFTVy9YWkJObXVkenFCYWxj?=
 =?utf-8?B?VXZYRnM1NGRjODN5akpMMTQrVWlYSzl2aEZ4eUVWVHMxSFNlbDkwSURDYmlV?=
 =?utf-8?B?a3g0Mnp0eU1NdzFSanBuYjhnQ2hoQ0ExZUxRNHkrVG1HNytLb0JSbG1DTmlt?=
 =?utf-8?B?Q29jVDRETlRESnBINXgwK0NNUmhwTktCLysvaUJwODVocElGUFRCTkVXdHd6?=
 =?utf-8?B?U1lHMU5RaU42ZzJvN0wxUmRhd0NBWlVBMDVLSFMrZ2tlTnBmTHh0MHZ3K25N?=
 =?utf-8?B?YmpJdXdPRE9nWnVTNFU1U2UvNlhBbURqZ2wvb3JLNW9pUjRVOTdXY2lEbWxD?=
 =?utf-8?B?Q0pkU0tWWFFMT1RGQlRXRkIySU9VWnZLWnJYN3o0dVpjT2ZTOWtaU1FZVVBG?=
 =?utf-8?B?OUgxQVRDcGdkOHppbEkyK1hKaStxcXBqY1FvL1VyOTNtQi9XUUtzaG5ldjZu?=
 =?utf-8?B?ZGtGQmtuUjRXTnhZdjJPckhPQWt0RWdFTFVpNGhuYlB6VkZ1aGFWWFR2d3A1?=
 =?utf-8?B?bXJpRlBTQlg1MWp6T2ViMC9Qak16Q1g0SVhKa2FGOGo0TnI3Y0RXMVJ2cW5w?=
 =?utf-8?B?djc0S1Vqa1BRTEdkd20zL2YvTjZyNGNmZE12RkVIejAyNjIxZ1dUcWxqVXpm?=
 =?utf-8?B?U1cwcUhLdTFlcDVXZzN4NUNUallkUmhLaEZ6d3ZBa0poeE9uRzNFWXhiZDJZ?=
 =?utf-8?B?RDZieFFLTEtPdk9qZFZTU29yTTlvZFBFM0M1SFNCT0VmZzVmUFNUL0Z3S0Vk?=
 =?utf-8?B?Szg3cnZXREYwSkNLVVYybWthSitoNHBra2FaTnlNTHFaQlQ1MzdpdmEyV2h0?=
 =?utf-8?B?SU5oU0dWWEFwOWFTM0gvM3N2WHJmd0RkUUVlOXg2TGtoRVZIM3Vac01ocmk3?=
 =?utf-8?B?U3AwaTBYK01rZ0RtcmlRWk14WFJxYzF2bkRXQnFQUnNuVkNncHpoODFCWnNL?=
 =?utf-8?B?dFdUZGlERjRDWG1odTYzRjAxT1pLSWE1MWFlaU5KaytjQlQ0U2tQWDZpbkRF?=
 =?utf-8?B?RmNaQmpjSC91Y1dUYVJVYWtmcTA4djgwdVNUSFR0RHdWQ2NMN2d0dStUYlhU?=
 =?utf-8?Q?XIdnPvHjTcLsjKZEf7JiUAxPpnMbMtxZR5m4qjckLlPAx?=
X-MS-Exchange-AntiSpam-MessageData-1: Ui3kqQQE5+5VCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18a6bf-4866-45bb-d0a7-08df149698bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:35:15.1049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iqt6C56Sv3U67k6gm89uhDfBZb+vyy6L6pVzjrkee0hfxJHLYy+oUL3cPff2+rGqK8wZ+xFDBqa0w0JAnLzR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

Currently, using NonZero/Bounded constants is quite verbose. It's
unfortunate because it disincentivizes using it in interface boundaries.
Introduce a macro to make it nicer to use. The macro `cv!` (for constant
value) takes a const integer expression and widens it to i128 (at build
time only) before passing it as a const generic value to a new trait
`FromConst`. The value is then converted and appears in the
associated constant `FromConst::VALUE`. The trait is implemented by
NonZero, Bounded, and Alignment and lets values of each be constructed
from constants without a verbose turbofish syntax.
For example, `const { NonZero::new(1).unwrap() }` can be written as
`cv!(1)`.

Add the `cv!` macro to the prelude so it doesn't need to be imported
explicitly to use it.

Suggested-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs         | 135 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/num/bounded.rs |  16 ++++++
 rust/kernel/prelude.rs     |   1 +
 rust/kernel/ptr.rs         |  12 +++-
 4 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index dbe848e30efe..6a4cb8d3ec95 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -79,3 +79,138 @@ impl Integer for $type {
     i128: Signed,
     isize: Signed
 );
+
+/// Creates a value from an integer constant expression, with validity checked at build time.
+///
+/// This works for any type that implements [`FromConst`], with the target type inferred from
+/// the context, or named explicitly with `cv!(value => Type)`.
+///
+/// # Examples
+///
+/// ```
+/// use core::num::NonZero;
+/// use kernel::num::Bounded;
+/// use kernel::ptr::Alignment;
+///
+/// let v: NonZero<usize> = cv!(8);
+/// assert_eq!(v.get(), 8);
+///
+/// // Any integer constant expression works, not only literals.
+/// let m: NonZero<usize> = cv!(usize::MAX);
+/// assert_eq!(m.get(), usize::MAX);
+///
+/// let b: Bounded<u32, 4> = cv!(15);
+/// assert_eq!(b.get(), 15);
+///
+/// let a: Alignment = cv!(4096);
+/// assert_eq!(a.as_usize(), 4096);
+///
+/// // Checked narrowing of integer constants, including in `const` items.
+/// const SMALL: u8 = cv!(200u32);
+/// assert_eq!(SMALL, 200);
+///
+/// const N: NonZero<u8> = cv!(5);
+/// assert_eq!(N.get(), 5);
+///
+/// // The target type can be given explicitly.
+/// let e = cv!(200u32 => u8);
+/// assert_eq!(e, 200);
+///
+/// // With an explicit primitive target, the expression can use generic parameters.
+/// const fn as_u64<const KEY: u16>() -> u64 {
+///     cv!(KEY => u64)
+/// }
+/// assert_eq!(as_u64::<0x40>(), 0x40);
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! cv {
+    (@cast $v:expr => $t:ty) => {
+        const {
+            #[allow(unused_comparisons, unused_assignments, clippy::as_underscore)]
+            {
+                let v = $v;
+                let r = v as $t;
+                // Pin `back` to `v`'s type so `as _` casts back to the source type.
+                let mut back = v;
+                back = r as _;
+
+                ::core::assert!(
+                    back == v && (v < 0) == (r < 0),
+                    "value does not fit into the target type"
+                );
+
+                r
+            }
+        }
+    };
+    // Using `FromConst<V>::VALUE` means const generic expressions can't be used, since it requires
+    // the `generic_const_exprs` feature. Provide a special path for each primitive type that allows
+    // const generic expressions.
+    ($v:expr => u8) => { $crate::cv!(@cast $v => u8) };
+    ($v:expr => u16) => { $crate::cv!(@cast $v => u16) };
+    ($v:expr => u32) => { $crate::cv!(@cast $v => u32) };
+    ($v:expr => u64) => { $crate::cv!(@cast $v => u64) };
+    ($v:expr => u128) => { $crate::cv!(@cast $v => u128) };
+    ($v:expr => usize) => { $crate::cv!(@cast $v => usize) };
+    ($v:expr => i8) => { $crate::cv!(@cast $v => i8) };
+    ($v:expr => i16) => { $crate::cv!(@cast $v => i16) };
+    ($v:expr => i32) => { $crate::cv!(@cast $v => i32) };
+    ($v:expr => i64) => { $crate::cv!(@cast $v => i64) };
+    ($v:expr => i128) => { $crate::cv!(@cast $v => i128) };
+    ($v:expr => isize) => { $crate::cv!(@cast $v => isize) };
+    ($v:expr => $t:ty) => {
+        <$t as $crate::num::FromConst<{ $crate::cv!(@cast $v => i128) }>>::VALUE
+    };
+    ($v:expr) => {
+        <_ as $crate::num::FromConst<{ $crate::cv!(@cast $v => i128) }>>::VALUE
+    };
+}
+#[doc(inline)]
+pub use cv;
+
+/// Types that can be created from an integer constant expression validated at build time.
+///
+/// Implement this trait to make a type usable with [`cv!`]. Use the [`cv`] macro, not this trait
+/// directly, for creating values.
+#[diagnostic::on_unimplemented(message = "`{Self}` cannot be converted from a constant")]
+pub trait FromConst<const V: i128>: Sized {
+    /// The value that corresponds to the constant `V`.
+    ///
+    /// Fails the build if `V` is not a valid value for `Self`.
+    const VALUE: Self;
+}
+
+/// Implements [`FromConst`] for primitive integer types and their [`NonZero`](core::num::NonZero)
+/// versions.
+macro_rules! impl_from_const {
+    ($($type:ty)*) => {
+        $(
+        impl<const V: i128> FromConst<V> for $type {
+            const VALUE: Self = {
+                // CAST: the macro is only used for types up to 64 bits wide, so `MIN` and `MAX`
+                // widen to `i128` losslessly.
+                assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "constant cannot be represented by the target type"
+                );
+
+                // CAST: the assert above confirmed that `V` fits in `$type`.
+                V as $type
+            };
+        }
+
+        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> {
+            const VALUE: Self = match core::num::NonZero::new(<$type as FromConst<V>>::VALUE) {
+                Some(value) => value,
+                None => panic!("constant cannot be zero"),
+            };
+        }
+        )*
+    };
+}
+
+impl_from_const!(
+    u8 u16 u32 u64 usize
+    i8 i16 i32 i64 isize
+);
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 2a2b0a4bca5e..1d5a151478a7 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -14,6 +14,7 @@
 
 use kernel::{
     num::{
+        FromConst,
         Integer,
         Unsigned, //
     },
@@ -272,6 +273,21 @@ pub const fn new<const VALUE: $type>() -> Self {
                 unsafe { Self::__new(VALUE) }
             }
         }
+
+        impl<const N: u32, const V: i128> FromConst<V> for Bounded<$type, N> {
+            const VALUE: Self = {
+                let value = <$type as FromConst<V>>::VALUE;
+                // Statically assert that `value` fits within the set number of bits.
+                assert!(
+                    fits_within!(value, $type, N),
+                    "constant cannot be represented within the given number of bits"
+                );
+
+                // SAFETY: the assert above confirmed that `value` can be represented within `N`
+                // bits.
+                unsafe { Self::__new(value) }
+            };
+        }
         )*
     };
 }
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ca396f1f78a6..5facf8f7af90 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -106,6 +106,7 @@
         Result, //
     },
     init::InPlaceInit,
+    num::cv,
     pr_alert,
     pr_crit,
     pr_debug,
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 82acb531b17b..2c12e4fd4572 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -11,7 +11,10 @@
 };
 use core::num::NonZero;
 
-use crate::const_assert;
+use crate::{
+    const_assert,
+    num::FromConst, //
+};
 
 /// Type representing an alignment, which is always a power of two.
 ///
@@ -166,6 +169,13 @@ pub const fn mask(self) -> usize {
     }
 }
 
+impl<const V: i128> FromConst<V> for Alignment {
+    const VALUE: Self = match Alignment::new_checked(<usize as FromConst<V>>::VALUE) {
+        Some(alignment) => alignment,
+        None => panic!("constant is not a power of two"),
+    };
+}
+
 /// Trait for items that can be aligned against an [`Alignment`].
 pub trait Alignable: Sized {
     /// Aligns `self` down to `alignment`.

-- 
2.55.0

