Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFA6C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DE110E8FA;
	Tue,  4 Aug 2026 08:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYYzJRno";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E9A10E8FA;
 Tue,  4 Aug 2026 08:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wxt7rCbdx1a8nYEd/Zw+J20C00bUpOqUuzhgP2rVAz5TlrCtaCPvm0afIjXuyEbt6ltXNzJ+w+s+OsB+fGVeD+Sm+HBO8k5r6ngivxCYN8S2E/q3fCgg3Vq71w4BynxfUnZAXsiPjflPzX8663GyuBl6VAo3891eHACbNIZY7A565omtUa/ysi2ny2UiT1+kH+NHL8B89ptMtskUjaVZdJ28NgJzO8ZV9JCJyUeSL33Gg8ZWmBumqMOWowdgUHgA6VJw/1D+lAOLSqXDi3j/jRSUqerHBUpAyD8cGY1LQrm3AM/ndjTi0x9mZPzGdMfRPchjkE3Nsp1yeaWcZbiutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C1ppodPgGEKAbw5a43DRy79IxJrmOjGRUWQYc6Knfs=;
 b=PS7YtazYZZ1FHRhYNibTQAqBgsTw70t9CD+5GSFjiOsz0vkHmOGhuomDtmCOEbsqhYoa/HODblCw4YKRsWfq1pky7eK+V8RBBdDxNASWKSSXq38o0DfxekoogAWzPZoGA/XSQWkqKJVKgY0ipkmB/bz5dAPV2eySuXFspY+Uz3rYjhSdpYWBhMa84XydcSpMbyw7eabRveVd+vEt88yfpvfONtdLzzXR492iajN76LeiKH4wywgYP4g885U8Ep7v31yLkrtb0UEgPTmnGqlAxxqNLYnUNYMI4csIvZrnkMqAbe6GlKVB6yKDOyXvDgex0R4gTKC4Va8YAVUYXQ9tYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C1ppodPgGEKAbw5a43DRy79IxJrmOjGRUWQYc6Knfs=;
 b=uYYzJRnonTGi0+RQ/75Z/FCesG8hxOqaKxA/EhLLt1pSJ5GBB+lximAqf1weTiXdOz5b9Xtkpy/ovzvOXOSXW8BCljLWcprFB0mO5e7PbgT7kfWVCg9MDqPf5+jX0J3E8RS3+j73Ma5n/O2Zwv9vA1r1IX2b414XGvDYsivi0AMzZsMYC4GEtjmSaBbum6zr9lcI4iiJW+QulUKlScIMRoZVcTx1rbxRku3oon++uLT8y3PpFmVJ8Lt3OCY0uSwWGrlpcALk7g1TU6ucm5DdfbciiLb3n2jp55ezBxjhqIGxfzJASF0FOJxHevxZtij526/lxk6AnKTCE08CK5yM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:37:32 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:37:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 17:37:28 +0900
Message-Id: <DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com>
Subject: Re: [PATCH v3 2/4] rust: bitmap: add contiguous area operations
From: "Eliot Courtney" <ecourtney@nvidia.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
 <20260729-chid-v3-2-20cc08032bbc@nvidia.com> <amrZcX33BGJCTDMp@yury>
 <DKFBEPDNAD1V.1LFARFHMO5WKC@nvidia.com> <anELwosZSI5MZR4d@yury>
In-Reply-To: <anELwosZSI5MZR4d@yury>
X-ClientProxiedBy: TY4PR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:405:370::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: b975420d-1275-4a41-a1a6-08def203a024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|4143699003|5023799004|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6aQwGbKFycT52roOQSHWxGxtYtwI/ZTfMEKpOugl1NsrEJca2rots5XfUoOiETV+VvZmAGc07DNFuw6Mtg1BsB4R3QvWXdPxIXngENH/T4wh8SmYOlOl6q/nNwba2PXOxEbLSsQZY34MAfG/gVyUnVobIAvO+u5jfNW0eEZYYio6Azt/+clBioG4BC/hL4uETnP+IuYscwstbMB1Ids6Y0FctJSEX7uVdHIw7jK1rhOIDbXcoSg5veUWIhyc3T6d1uIdiVRzC1KFDmiDO0C6X9IkZlvTGKUUrF2SWiMCnKDb3lsOJxbxqL36pF5n6STAfWdUAPLD753wGaWbpIfnu/H0h/69Ze7Pi5ly84p9tyJr4TebUJWw4aZw0CRJcq2AEQU85XkzM1T8mnUFp+hezJ6AZEsOv3oPHP8o7hK9RGGcz6Z2NiyTgaEP4n56TpysneweZ4EjKST1QZTdKPhYbj9J+NRHpGYVprTqd2JUYryqZKguQR8bnCRo0a581/4mi/qd7As8cPIrwFuKJb3tVRZ8GR24T05bbOI66Kg1K8whP6kOCIgZTD+yHTF2XXAjmeHLYSIo6kA1VY3Ik+4OJXYa7wA6vnBGzdeVb5SlBq5jw8dLab+nv9IQukryPeroTvMJna6xKfR7sLkR2oixIpyCNR24iZjAbdR/n4zrRcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(4143699003)(5023799004)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9LMWxVSlFaMkpEaHlyckx3WG5JT1JSYVc3ZTBOM0psOHNDMmM4Z3ZldmFn?=
 =?utf-8?B?T0sxVys0czJvSE4wbnhyUTdFdWFHOG03a21OU3BMc3B1MU0zc1VxUEQ0dEJV?=
 =?utf-8?B?VCsxdlZJN0tzTHUyZTIwZnV1dUo3UDZZa3QvL1ROd2pkVG84ZGUyYjVTRFpM?=
 =?utf-8?B?MkNIN2NJUHozcFBZd2xNVWdjcVVRMk5kYTdSSm5FSi9mZUVmOFQ1NTU4VlNw?=
 =?utf-8?B?SmVuNGc3YUNmcHhxVjdQenZQZWpSRmM4WHRrN21jMlhrU3NlTTY0eUlubjBG?=
 =?utf-8?B?em5PRDNkeUhlbHc2Q1lxVzhiOVNHVC9ZclNaRGtJOUljejQvRkVHZDJTOGhI?=
 =?utf-8?B?KzBMbWpSZVFQeHZhU1BhcFc2YjhCRXVOZlFDUlRVckU4WUF0M2lJdDdmcVRZ?=
 =?utf-8?B?RUFWNTRhZFplU1g2RWtZM0hEai94Qjd6VHcrbWYxODhycUd0YXNjMFVZQ3Iz?=
 =?utf-8?B?NG5qK3ViU1dnMmsxTm9IamtZQU5kcFptZno0OGxwbU5SWGEvakN1cW1wbGtD?=
 =?utf-8?B?c1lNVzZVN08rVXlXMU5CTEl5TWcyM01kME9rZi81ZmptRzRHUjVTTVc2bmli?=
 =?utf-8?B?TkR3K1A3Yy93c3RVVThFZWlveURKbG1kdktCaThoY0w1c3BKUDlFUGNIeHNM?=
 =?utf-8?B?QU5nb1JrVXBMd0pGMzJXaHFtU2FYYnhxc1pwc2ZWbnJnZkdtQTNTWE9WdThK?=
 =?utf-8?B?b2NyeDJIaTErRE9Hd21Jd2lmV0FKc0F1dHFZeXFlZlZlUS9Vczk3SnI5eWE4?=
 =?utf-8?B?QVVrUkFhc1pEeWJJY3BSTklNUyswQmhYeVBxZ2VSb3l6MHVSSGR3Ujdrbzk1?=
 =?utf-8?B?Tms5VGdFaUVmQ2lQRkVwUUs2dDFMWGlCTTd4QXNyRUhNdS85ZER5Mjk5MUlC?=
 =?utf-8?B?WlJ2Nk1tcTFnWi9GL1AxMmgrQUo3SG45S1ExVTJHSTZqMSs5Rm1JQU1TLy9x?=
 =?utf-8?B?M05QNlVzZ3lIVGVrem5jQlpqVnlEOGFkT1B4Slo5cVY5OGx1OFVQbWtkVGtU?=
 =?utf-8?B?VElTdFhhWXdlTk5QYjVsU204NTd5Mmg4WWYxZlR3VW5Xd2NzaXE5QlVFZmQ0?=
 =?utf-8?B?RmVwRlEzWWJyWFltdTdwOUVOMjEvYkg2d1FMTy9vVmpURVk3MW9XTTJCcC9L?=
 =?utf-8?B?UmJVeTVzRUI0MWJJMUV4c3pzakd6cFdyVWpoQUNjUWFCRnVSUlJ2Ry96SDJr?=
 =?utf-8?B?L2x4S2pjcWRIeGhoc1Y3UkNEZ1ZhanpxY0FUcmpiemdDR2JMclcrcjlEeHI1?=
 =?utf-8?B?OWRoVGwzVVNwVjFXaWZqdjBQZmNIa25uSFZpOHk2Sk56bjFXb2lmMElrQTdM?=
 =?utf-8?B?cUZZQUErQUNnbk9rc0liclZtZTRLMkc5YUZnWENpTDFmVElqNVpCZ1UrR3h5?=
 =?utf-8?B?c0hldVdXZGN4TGovSlQzejNLSHZUY2NRdTJQTjNUbjBOdmVnODZLREY3UnFK?=
 =?utf-8?B?L0cvUFRDaS8wcURJQWFPVmVXaXJHWGU1bXB1cGc1dWF5Rjd3Z3d4OUhNSjln?=
 =?utf-8?B?c2kyb0x1QlRZcDNDT3BpWGZYQVVaVWhYSjl4dHpjQTFOdzI0SkVOTDcyaktk?=
 =?utf-8?B?elJmS0tpbjhKVzROYXdjT3c5Z1F4OUxkZlk0YlJVWkFpUjk4Yk1mK0lLb1Fi?=
 =?utf-8?B?dFM2WDNIcGxzVTlMaHFacFNkRVFCL24xdjZ3WFJrOFlSemlUU0ZQd3pYS0Uv?=
 =?utf-8?B?VzVJRmREbWhwem1xRHFGOTZNTVBMRCtZYTJsQ05vdHVxZ3diZkkwMzJCYkpU?=
 =?utf-8?B?c1JQZTllYWp2KzZrRXkwLzRUU2ozc3dycGJhc0Uxc2ViWWx5Qy9pdko1Y0ZX?=
 =?utf-8?B?ZFJzQndVeDgwVnpkMC9GY2lMbWRIRncxUFZPZENHaFdJK0Rmam1BS09FajZN?=
 =?utf-8?B?bU52cFdqcEtNU3l4RERNNkZQZ3ZDYld1Z3o0SnRnbjBIMUpWVGJma09tVFlO?=
 =?utf-8?B?MWNTWi93MlB5VmZuRFhiN3ZCVkNQZGliamx5L3VVdXV4M0plaW50UnpVMENz?=
 =?utf-8?B?R1dGR3dsbmxwSWowWVdmOWdCNWtlLzhHbzNoSlV2ZUY2Qm16VjJUVXpJZkpO?=
 =?utf-8?B?eWl2M3VoYVI2Ylp5bmlMazlHMjR2SUIrWmcxUGdDSU0xYzBPQTJaRUg1MWQx?=
 =?utf-8?B?UTV5aVJVZ0piZUdxdXI2MUV1N1YrVzRkS3dVYlVXc1kvaWt4YWxkV1BVV3Z6?=
 =?utf-8?B?bitnalhyVXdEYVZyS2tBTzZMRDRQcHh0UVZSc3VqV3c2SDJRcEVLZnpYQ0F5?=
 =?utf-8?B?YThrNVRnZ0l6LzhRN29MUVVRRW4xOUlLZ1YvZVlHNExqWVA0OVNTWHVEOFhN?=
 =?utf-8?B?WjBsRTVqYytGVzU2QW5PUlE4T2YrZlA5OGticktjQWtjSWRWWGwvK1hTZFhL?=
 =?utf-8?Q?MmpG/EcCzMgRWp1dkRcdvGSAg1LSvztLgib2HYc0/R2Sc?=
X-MS-Exchange-AntiSpam-MessageData-1: DCO+W6KfnBoi7A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b975420d-1275-4a41-a1a6-08def203a024
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:37:32.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bce3thWjc8+lTrUlv7/ClXH05G7LBq1Jnf5uNeC2PS4B1RKpOz84kwOboJ3q7yO2bjsQ99uMlilG68FaYYN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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

On Tue Aug 4, 2026 at 6:44 AM JST, Yury Norov wrote:
> On Mon, Aug 03, 2026 at 09:41:42PM +0900, Eliot Courtney wrote:
>> On Thu Jul 30, 2026 at 1:56 PM JST, Yury Norov wrote:
>> > On Wed, Jul 29, 2026 at 03:54:13PM +0900, Eliot Courtney wrote:
>> >> Add bindings for area operations on bitmaps. Each one is
>> >> made safe by adding some extra checks compared to the underlying C co=
de
>> >> (for example, checking bounds) and with additional checks to catch
>> >> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>> >>=20
>> >> The C code uses signed integers for some parameters, for example the
>> >> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
>> >> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
>> >> backed by `BitmapVec`.
>> >>=20
>> >> Add tests demonstrating the edge cases.
>> >>=20
>> >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> >> ---
>> >>  rust/kernel/bitmap.rs | 194 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>> >>  1 file changed, 194 insertions(+)
>> >>=20
>> >> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
>> >> index a43bfe0ec3dc..f4b0b8ae39d8 100644
>> >> --- a/rust/kernel/bitmap.rs
>> >> +++ b/rust/kernel/bitmap.rs
>> >> @@ -10,6 +10,7 @@
>> >>  use crate::bindings;
>> >>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>> >>  use crate::pr_err;
>> >> +use crate::ptr::Alignment;
>> >>  use core::ptr::NonNull;
>> >> =20
>> >>  /// Represents a C bitmap. Wraps underlying C bitmap API.
>> >
>> > Some comments use indicative form in the file, but the imperative
>> > 'represent' is a more standard way. Can you please use it instead?
>>=20
>> I think in rust, indicative is the standard even in the kernel - e.g.
>> see Documentation/rust/coding-guidelines.rst around line 208-ish, and
>> that's also what I see generally in code. But please let me know if
>> you'd like me to use it in this file regardless.
>
> The documentation you've mentioned doesn't say: use indicative. This
> is just a one example.
> =20
> This is what my AI machine says:
>
>   Among the 1,266 verb-led function comments, that is:
>
>   - 67.1% indicative
>   - 32.9% imperative
>
> So, unless there's a strong (and not aligning with the rest of the
> kernel) rule, please use imperative form in bitmaps.

Yeah I got a similar result using my AI machine too~~

There is a strong rule for rust specifically and it's encoded in RFC
1574 [1].

[1]: https://github.com/rust-lang/rfcs/blob/master/text/1574-more-api-docum=
entation-conventions.md#summary-sentence

>
> ...
>
>> >> +        bitmap_assert!(
>> >> +            start < self.len(),
>> >> +            "`start` must be < {}, was {}",
>> >> +            self.len(),
>> >> +            start
>> >> +        );
>> >> +
>> >> +        let nr =3D u32::try_from(nbits).ok()?;
>> >> +
>> >> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use w=
ith an out of bounds `start`
>> >> +        // value and never reads beyond `self.len()` bits.
>> >> +        let index =3D unsafe {
>> >> +            bindings::bitmap_find_next_zero_area_off(
>> >> +                self.as_ptr().cast_mut(),
>> >> +                self.len(),
>> >> +                start,
>> >> +                nr,
>> >> +                align.as_usize() - 1,
>> >> +                0,
>> >> +            )
>> >> +        };
>> >> +
>> >> +        // In case of overflow, we may get back a range outside of w=
hat we requested.
>> >
>> > No, we can't. We've got the test_bitmap_find_next_zero_area_off() for
>> > it (in next). If you think the test is incomplete, please extend it.
>> >
>> > If you believe that bitmap_find_next_zero_area_off() may return someth=
ing
>> > like that, it means the function is buggy, and you shouldn't trust it =
at
>> > all.
>>=20
>> TL;DR: Included some tests below that demonstrate overflow/OOB issues on
>> 32-bit (with increased vmalloc) in some extreme cases. To keep the rust
>> code completely safe we need to check for these, or update the C code,
>> but not sure if the perf tradeoff is worth it. Please let me know.
>>=20
>> Ok it seems I was looking at the code previous to df81d444dc74 ("lib:
>> bitmap: optimize bitmap_find_next_zero_area_off()"), but overflows can
>> still cause wrong behaviour after this commit too:
>>=20
>> [1] On 32-bit, suppose we have an empty bitmap with size=3D=3D64, start=
=3D=3D32,
>> nr=3D=3D2^32-1, and align_mask=3D=3D0. Then, computing `end` overflows t=
o 31.
>> Computing `end - off` then underflows (31 - 32) which can cause OOB
>> reads. So actually we need a check before calling
>> `bitmap_find_next_zero_area_off` to avoid this case.
>>=20
>> [2] On 32-bit, suppose we have a bitmap with size=3D=3D2^31+2 and all bi=
ts
>> set except the 0th and 2^31+1st bit, and start=3D=3D1, nr=3D=3D1,
>> align_mask=3D=3D2^31-1. We'll compute start=3D=3D2^31+1+2^31-1 which ove=
rflows
>> to 0. Then we'll end up returning 0 which is below start. So we need the
>> `index < start` check.
>
> Both examples overflow int32::MAX. It is not supported in rust.
> See the BitmapVec code. Your case is just 2048 bits, so it's not
> a limitation for you.
>
> On the C side, there's a historical mess - some functions work with
> unsigned longs, some with unsigned ints, and so on. I'm aware of it,
> and there's a process of unification the API toward the unsigned
> longs. That wouldn't help 32-bit architectures because they are all
> ILP32, but there's no real use case for them that would overflow the
> 32 bit.

Currently it's possible to construct a non-BitmapVec backed Bitmap using
Bitmap::from_raw that is larger than i32::MAX, and it's not part of the
unsafe requirements. If we can restrict all Bitmaps (even non-BitmapVec
backed ones) to have a max size of i32::MAX then that simplifies a few
things. If ok, I'll add a patch adding that requirement to the unsafe
requirements on Bitmap::from_raw, Bitmap::from_raw_mut, and the
invariants on Bitmap.

But, if we want to keep the rust code completely safe even with
requiring all Bitmaps to have max length i32::MAX we still need a check
somewhere since OOB reads can occur even for a small bitmap. IIUC, we
want to make sure all rust code is safe regardless of the inputs.

In particular, we need to check that `self.len() + align - 1 + nbits`
does not overflow in `Bitmap::next_zero_area`. e.g. on bitmap-for-next,
an empty bitmap with size=3D=3D2 called with
Bitmap::next_zero_area(start=3D=3D1, nbits=3D=3D2^31, align=3D=3D2^31) read=
s OOB (on
32-bit).

Alternatively, an exact fix for this in the C implementation is as
follows (obviating any need for the rust side check I mentioned above).
I briefly benchmarked it (region_alloc_benchmark) and didn't see a
slowdown, at least on x64. I'm not necessarily suggesting this, since in
C I think the answer is just don't call with nonsense parameters, but
just for reference:

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ed685127a107..e500091c7e6a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -435,18 +435,21 @@ unsigned long bitmap_find_next_zero_area_off(unsigned=
 long *map,
 					     unsigned long align_mask,
 					     unsigned long align_offset)
 {
-	unsigned long end, i, off;
+	unsigned long index, end, i, off;
+
+	if (nr > size)
+		return size;
=20
 	for_each_clear_bit_from(start, map, size) {
-		start =3D __ALIGN_MASK(start + align_offset, align_mask) - align_offset;
-		end =3D start + nr;
-		if (end > size)
+		index =3D __ALIGN_MASK(start + align_offset, align_mask) - align_offset;
+		if (index < start || index > size - nr)
 			break;
=20
-		off =3D round_down(start, BITS_PER_LONG);
-		i =3D find_last_bit(map + start / BITS_PER_LONG, end - off) + off;
-		if (i >=3D end || i < start)
-			return start;
+		end =3D index + nr;
+		off =3D round_down(index, BITS_PER_LONG);
+		i =3D find_last_bit(map + index / BITS_PER_LONG, end - off) + off;
+		if (i >=3D end || i < index)
+			return index;
=20
 		start =3D i;
 	}


