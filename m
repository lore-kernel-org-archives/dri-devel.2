Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C989DC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38D410F1B0;
	Thu, 13 Aug 2026 07:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A6jW+YSk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC8C10F1B0;
 Thu, 13 Aug 2026 07:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXtcA4oWGnOnsZLy2ksjXoPw5ykdGc1f9anewz2ss1uEOIMx6B99FUBEeLFk2LPdPnf1EZvUnjXvDIlpPDUDa/a+BCoAit8Q/l9XQNoEBMlLzOWpCtpoge+nI752TgTrNhw2Hbc333KlOanzYksnHIjJbdNXsmkiaYYSYsYOzv4qDBIq/OLZ58EDqbRjSWuPxDSVyQewBQz6hJKyS57PN7X5qteJuM0D8YpPCN8Kx/7uP6G9SE6bymAf/TivKO+ipO9y7L9JW/OoM1lxRCsDMYdTK907k4/I2dlAoLI2zQmyb6SH4V3tV4WUDTmGN38IDAOAoMCgU+uAsSACywqKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mFtTsG3AHbfBiZrlQdwTsnT+qOw3CJSB73+hUW4S3o=;
 b=hIJcNYvEvINV3azJrhDp+PpFtkhRCAJGCCPmzoXXNw72FZwV93Uj+fa1YE+sTGOM/eNar3GR8FmXyZlGHiTzi3tC5opOauq+ozCOAa3k7UVnTIOoUTi1ohOP24kYew8KMJo55yzyznafoKUOq4MJxAHcTe/lali1+aNrYDG/XSdlKskfWLZLeKrCYw7EZB5ZfgJi18ysSd9TCMNzmJbJXbXqfgM3R0DLUAV5pWq/9DrYbh2dHVtBN6/hN+otVFRezzpSCEhcEvR3mcQ5KEIWSNB5sbW/CngrkASmeU8zaDL8jXJI5TawcTnOLESHxa02Dhl324h4b2LKe8Q2H9ZK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mFtTsG3AHbfBiZrlQdwTsnT+qOw3CJSB73+hUW4S3o=;
 b=A6jW+YSkVk68g0WnC/VCKnLefS4EfP3n2cg+1DxFjf2458GCOuE1pv0PggUl1udNC1gP6cPnODS15HzpfaVgivA9HpbxrLFleA2deYPqPodXENonkBBH5AjnWjDPtH97mnZgTPPjgQ2ljSm9KiNAZ5YQArCs9DdL4T+GFmRpw7b9lvssvvEhoQLqSJvvkR/AxDokUCeobRM0Z8uEcP5AuAuckizZmIbaZKtvqwAcVfWz+TlpGE8+xnOOVaynsgzWlL6imo1nxoUBZIRACE6vx8Dy4ekIoXK4MhYmr9Qsk1FM0pgASk1Fq3g2SUJA6JLhUH2NM6O4u+Eq5XhCtZ14+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:29:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:29:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 16:29:26 +0900
Message-Id: <DKNN12FQ5C8E.O2TZ8XW5TD3G@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 4/5] rust: id_pool: add contiguous area allocation
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-4-6c767770b3f4@nvidia.com> <anzitCSFv28wKWeX@yury>
In-Reply-To: <anzitCSFv28wKWeX@yury>
X-ClientProxiedBy: TY4P286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f585e9a-c204-448d-7fb8-08def90c9cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fV7aKZS/48LHPA2CEltSGotWCt6U/14KHtiqEe28G28UNBxvfHP+42OXYQgfo+QybktZOFn6I2B5uo5yITO1tg8GA+JT7Qp9JxZCFMBBhxri2tlWJzikA1/kl8qit0Ffvc+m3lo7kOAIgIuaSpJmYrni69xkWLiz8TvOWsLM4PskbTuKHZ/K9R2FhksIkvgqz+YCMRKQ3n5emNTOBCxEMSr4qwD8npvKyXAnw42c2NDIJtN0AtnHalQOo6tDpNhcYRs3N6YkQSs2jRpMWmxzLihkANG7ISzPnC4DkKTnXWviV2v9rPJB07MZuSXW14BWq9Dap0SV2CbdG5dm7GKpPLBEaiH688p93uDdTrZHTBBdOfhCacBazGXu2WG3gWLFD4Z+TlaY2PyFLRVfs2ntBLVRUmc4lptilVuQY6U3bEgjGinkVjPGdGeeyuHFueuMUa8bdQWk/6XSxFxm8/g46wB7InFEzO10potVQdj6zawnmcIYLjPZgaQ4Ng/czPL7ZNm7ZsKUEKz0c/K+4ERwc1/VLPCRacwVNwUhr/1/7Kw1Js3pJFXN/CW7TVWlGsfksUZT0+81siCxrOrO6gTnSZwXVoCIfsjYVmRL9NJBMsURflrRJdjGMofLIVjsazeL0OZEGmFTwkF/D1Zv0rGuh02eTfnlYuNXQrbjClgmmq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJZY0VJamZvR0V0dTFGdW81S08rd2JHY2p5Ymlwb3JlNDdnT2drVUp2emdm?=
 =?utf-8?B?U1Y2aFJESTRBT1d2MzVCV2pLNFViWjUwT0dUY3ZSdDZIcXAwMmk5SmVUNjBP?=
 =?utf-8?B?ZU9pczhyeW44bDIzSlBhR0N4UmErYW1zMEFYc2ZQSGlmN0ZEZkpEZjFHQ2E2?=
 =?utf-8?B?dElQcjZRL0EzZHNRanhPSG9LVXBWMHJiak9BcUJwZXVwUGFiaTNaMUpKUWRP?=
 =?utf-8?B?dE14WmVRNG9vaW5KTVpjcnhYc2owYWl1allzRERtR2orTUFQdGtrWUI1Z0Vs?=
 =?utf-8?B?MWRWU0g5QnZnMS9EK3lHOGFBYmxkMXFCZ3h6cys2WGVUa2lRM0pJSlR3NlNy?=
 =?utf-8?B?SjFrOEVXTGorSGlVcU1ZeVNrMGU1SHpFTVdoZEFFandIb0VnVW9sNXk3d1hC?=
 =?utf-8?B?bUdRYUZEODViL01pUmlPMlYwZzQ2Nk9ySGU3cm1MQ0ZGb1ZaSHhtMmRwRm9a?=
 =?utf-8?B?ZXA5eEV3aExVMnVpU1kzWUdOMTBOQkJWaitmak10YjByMWFaOG5vdGlaUC9T?=
 =?utf-8?B?c3Z0aXI5MXRjUnZwN1lFa2lFMWYxUmp0NS9EM3JydlQ3YWdvdHl2QWpFVWpG?=
 =?utf-8?B?d1d1QXpqTzJicWRFTUV1d1c3REYvTURPQVM2bnJ6UExnSHlWdmtFT3hHQmlQ?=
 =?utf-8?B?NjYwZ3h1S0docFJyVTVZZi9wd0VNM2JZUUdZQ3kwajRYQTNYUkx2YTQ5dCtU?=
 =?utf-8?B?dVhTWml2SHYvRGZ4WDB0ajRMVHliVWU2Q1Uyb05uOWxWR0ZGOGhqRnRVeTNW?=
 =?utf-8?B?Z0JIKzlhZnYxcCt1N0tKaFlPQlJyUVl5SjVDYUk3WGF0cWluOEFrNDhrRXFs?=
 =?utf-8?B?Q3d3TnV1VGVvQkpQWE9uYTZMUHNPODl2QVdTUTRvZEVoS3ptK3M4TWFtWElI?=
 =?utf-8?B?RGRocU51VWd2SDVFdjJEa05sUXJJRmVkNjJ1d1lwc3JMQWpnR0xZb2YxRFdj?=
 =?utf-8?B?bU5aU1YvcTFmNUVsOTV2dmJBcTZ2cGUrNi9sM3krTy9pQnhrOENRdWFwbE9o?=
 =?utf-8?B?b3ZrdGt6cXhBNExIS2NsaXVWREFxL3F4SXozVGVYR3JiWHRXcEg2bzV5UTht?=
 =?utf-8?B?am5BNXVvR1FLOWIrcXhJcFNpVnpIT2p6UFpDL0FGUTRIaWljSEIxQkQveGlv?=
 =?utf-8?B?UzRrTTZRRks5Z2tlTjdVZUJLUEJRajl6anhzYlFuK095R0JxSGVHdXVXWU1Q?=
 =?utf-8?B?KzZLdStGTk9remdhbjYzQW5wWTFscE1ML2lIbUZDUGZBMUlTdlRDVVJ4VEJl?=
 =?utf-8?B?dWRWMnpFTWJJdU81TkxISlc5SmRNV3RVVUlZeXNzYm9lUE5aUDM2SDlPblYv?=
 =?utf-8?B?NG1DUHBZWlZHeVRzakUxSXlCWjdxVUI1cGxZNEJSMHhoQ2xXV2FnT204SHBZ?=
 =?utf-8?B?a3dscUsxYUVucVRYRUpTelhpSXYrS1JuZ0h5eUpLUmV1REVNQVF5NkJ3SWdY?=
 =?utf-8?B?LzRxZ1RBRVErbFlxZjg0eGIvbDEwUXlHVWtoVHFOakNXelI3SU5sWGU3a25V?=
 =?utf-8?B?U2xhMG9GSFAzMWUwQW9lWW05SHM3ellQankzV3lCdFMxbjJjcER0SjZ5LzVH?=
 =?utf-8?B?T1JFQ1R6bklRWFMvNWh2bVZGNmhXSXFtazNqM1JESWhoQmdNU2pRYWFVMEl6?=
 =?utf-8?B?akFhc1pwa2FRRU9vbzkvNzliNTlkbG5vTjhlM1c1ZjBZUW9LRVY5eit5UzBz?=
 =?utf-8?B?NjlsQkx0Qzg1TXk0OXZnaVNGTmZIM2ZPUlJWVU5YSXB2eUZqVitxQXFUSEdC?=
 =?utf-8?B?WExvQTY0d2pxQ3AzQ0txOENiL2dZVmJsTytiWkJlRVVvdytLVTEzbW1XV0Zj?=
 =?utf-8?B?WVNGeitEQWJQRTc4aXViNDZsN25QV2UxR1R0NFk1QmQvcVRsRDVqYUJvWWFh?=
 =?utf-8?B?YUdBRHdTYnRCZDZPYTUrVzRxS3M3YllKT2NYR0FrSlJIMTVSQlFZaVQ0NG93?=
 =?utf-8?B?aW5hVmRiK3BGK0ZDNXFRZVBzYStYQmt5VldoS2ZuTWUvcFFLOGFZSWtKN2FP?=
 =?utf-8?B?MjNobFJ6RUVyL1krRzU5RHY1NHMxNlNLSjdJaU9DNm1HOEtSMkRERjVIUVQ1?=
 =?utf-8?B?TUNsYzY5WS9MZnA3YWpIb2FVM2hmZ2lGelk3RytaUGdnUFlYVzZOaVRCandq?=
 =?utf-8?B?UFpIVFE5TjRmVWJWNEhGdFcyRGxCWWFPMlN6TGh1bmtiTUM2Q1VYQThHS05L?=
 =?utf-8?B?TXVGbjlIUFhJZ3NkZDJVcGFDZjMrVkFpZ201N2s4dVlkeFl5eGNiQVA1U3Rn?=
 =?utf-8?B?ekU4akdLb0VTa0NueTVWRVREQXh3SVVULzg5b2VwWFllUmRCNkNjcHl0d3Fi?=
 =?utf-8?B?b1JaNlpVblpIQTR4bXVsV0ZvN010ZzRDcGg4YVJxT0VJS0pDS01KSE9jT0J1?=
 =?utf-8?Q?95MCvHhhF3Q+1w+Z9io0hVliE2oeoYR4FLUekH+RQvVkp?=
X-MS-Exchange-AntiSpam-MessageData-1: hQj3AwrLTYATWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f585e9a-c204-448d-7fb8-08def90c9cf7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:29:30.4296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjUqUD8mIv3cYIBeZQRtdfT/chKByuvy4XoZUSjEJFtcmD2mUB9NyjMQBLCJxIe4X0xv7JRua7KLNiedAODaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

On Thu Aug 13, 2026 at 6:16 AM JST, Yury Norov wrote:
> On Wed, Aug 12, 2026 at 05:51:24PM +0900, Eliot Courtney wrote:
>> Add support for contiguous area allocation. Add a new type,
>> `UnusedArea`, following the same pattern as `UnusedId`.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/id_pool.rs | 69 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 69 insertions(+)
>>=20
>> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
>> index 384753fe0e44..eb911a0e3217 100644
>> --- a/rust/kernel/id_pool.rs
>> +++ b/rust/kernel/id_pool.rs
>> @@ -4,8 +4,14 @@
>> =20
>>  //! Rust API for an ID pool backed by a [`BitmapVec`].
>> =20
>> +use core::{
>> +    num::NonZero,
>> +    ops::Range, //
>> +};
>> +
>>  use crate::alloc::{AllocError, Flags};
>>  use crate::bitmap::BitmapVec;
>> +use crate::ptr::Alignment;
>> =20
>>  /// Represents a dynamic ID pool backed by a [`BitmapVec`].
>>  ///
>> @@ -240,6 +246,33 @@ pub fn find_unused_id(&mut self, offset: usize) -> =
Option<UnusedId<'_>> {
>>      pub fn release_id(&mut self, id: usize) {
>>          self.map.clear_bit(id);
>>      }
>> +
>> +    /// Finds a contiguous area of `count` unused IDs at or after `offs=
et`.
>> +    ///
>> +    /// The start of the returned area is a multiple of `align`.
>> +    ///
>> +    /// Returns an [`UnusedArea`] upon success, or [`None`] if no such =
area could be found.
>> +    #[inline]
>> +    #[must_use]
>> +    pub fn find_unused_area(
>> +        &mut self,
>> +        offset: usize,
>> +        count: NonZero<usize>,
>> +        align: Alignment,
>> +    ) -> Option<UnusedArea<'_>> {
>> +        let start =3D self.map.next_zero_area(offset, count.get(), alig=
n)?;
>> +        // INVARIANT: `next_zero_area()` returns None or a start with `=
start + count <=3D map.len()`.
>> +        Some(UnusedArea {
>> +            range: start..start + count.get(),
>> +            pool: self,
>> +        })
>> +    }
>> +
>> +    /// Releases a contiguous area of IDs.
>> +    #[inline]
>> +    pub fn release_area(&mut self, range: &Range<usize>) {
>> +        self.map.clear(range.start, range.len());
>> +    }
>>  }
>> =20
>>  /// Represents an unused id in an [`IdPool`].
>> @@ -287,6 +320,42 @@ pub fn acquire(self) -> usize {
>>      }
>>  }
>> =20
>> +/// Represents an unused, contiguous area of IDs in an [`IdPool`].
>> +///
>> +/// # Invariants
>> +///
>> +/// `range.start <=3D range.end <=3D pool.map.len()`.
>> +#[must_use =3D "the ID range is not reserved unless acquired"]
>> +pub struct UnusedArea<'pool> {
>> +    range: Range<usize>,
>> +    pool: &'pool mut IdPool,
>> +}
>
> So, the compilation message refers the "ID range", not the UnusedArea.
> To me, this 'unused' language is confusing. What should I do with the
> area that I just allocated? Drop the 'unused' one and create the 'used'?
>
> Can you rename it to id_range please? Then the API would look more
> consistent, at least to me.

tl;dr: I will remove `UnusedArea` according to your suggestion

`UnusedArea` here mirrors the design of `UnusedId`, which first finds
the unused ID then lets you actually set it whenever you want (first
introduced in f523d110a63b ("rust: id_pool: do not immediately acquire
new ids")). According to f523d110a63b, the reason for this design is to
allow some fallible operations once you know the ID you are getting
before committing to actually allocating it. So `UnusedArea` just
follows the existing design for this API. But, we don't need this
intermediate fallible operation behaviour right now, so I think it's ok
to get rid of it.

>
>> +
>> +impl<'pool> UnusedArea<'pool> {
>> +    /// Returns the unused ID range.
>> +    ///
>> +    /// Be aware that the area has not yet been acquired in the pool. T=
he
>> +    /// [`acquire`] method must be called to prevent others from taking=
 it.
>> +    ///
>> +    /// [`acquire`]: UnusedArea::acquire()
>
> So maybe implement the find_acquire() method? In the caller you
> serialize it with:
>
>         let mut ids =3D self.inner.lock();
>
> Is it possible to pass this down to the suggested find_acquire()? In
> my experience, having non-atomic sequence of find + acquire that
> requires the external locking is the recipe for troubles.

In this case, since we stash a mutable reference to `IdPool` in
`UnusedArea` (just like `UnusedId`), it's not possible to hit any
non-atomic find/acquire issues. The compiler will statically prevent you
from being able to allocate anything else in the `IdPool` as long as the
`UnusedArea` is alive. That is, it's always valid to acquire an
`UnusedArea` (or `UnusedId`).  In this case IMO it is more flexible to
let the caller decide how it will do the locking (and that's the
existing design for allocating single IDs here), since it can e.g.
control the granularity. Or maybe it really exists in a single threaded
context and doesn't need locking whatsoever (i.e. can get a mutable ref
to IdPool without locking).

>
>> +    #[inline]
>> +    #[must_use]
>> +    pub fn range(&self) -> Range<usize> {
>> +        self.range.clone()
>> +    }
>> +
>> +    /// Acquires the area.
>> +    ///
>> +    /// Returns the now-reserved ID range.
>> +    #[inline]
>> +    pub fn acquire(self) -> Range<usize> {
>> +        let Self { range, pool } =3D self;
>> +        // By the type invariants, the range is within bounds.
>> +        pool.map.set(range.start, range.end - range.start);
>> +        range
>
> From hierarchy perspective, the UnusedArea wraps the Range, and
> passing the Range to the higher layer breaks the hierarchy. If you
> follow my suggestion, the hierarchy will be enforced stricter:
>
>         ChannelIdRange -> IdRange-> Range
>
> instead of =20
>
>         ChannelIdArea -> UnusedArea-> Range
>                       |
>                       -> Range
>
> Or I misunderstand the concept of the UnusedArea?
>
>> +    }
>> +}
>> +
>>  impl Default for IdPool {
>>      #[inline]
>>      fn default() -> Self {
>>=20
>> --=20
>> 2.55.0

