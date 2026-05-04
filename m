Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE40FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BECF10E3D9;
	Mon,  4 May 2026 14:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2gHEK4k";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED82510E3D9
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlWX1ZkTelOsiAZoPcqYYWtjowIhq3FCjaFhtoJkxtWDmhwNUn0BWcGTfaYJ0YH0YdH4FGI/UEPIdhr5i6pl0T/ZUNi86DBApToo/dmDdIL3nvWchY2l+F35PK5kznPbtHX45KHrfhkg7WJuTnhP2+FTpTcm7OvyrbNtaCLFLoR1LAHKbOLAAWJUIp34z2g5ug15qhG6UoQUsUp3wrBMvkG+5ijzlul8PDxn2ezbvYXF03otDVwgP9Sok82yn/zp8ZCf78wIdFZl1iTU4BQK03YB1Ri/SOKvHYpv4clScwdLSOZMWDI2iDfWW1qfyJXCj0pQlfP//LqhweDc5eQWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOZkdz2Pa10hb/TJ6zcwajtpgXnq72Z6h74CMdnH+gs=;
 b=dVgtOE+VqGfwpKFCRmMsUxuO93/efoZK7unn8w3pDni+mEmUzRHyyxT6v1OjZSk1E+8VYnhXFemYh8LU5gNTt/1cqVR7vjcOLs4R5CMDYRZt/hcnLN6okv8eqgAa9QRyCaRbwkRmO4J2Rxu/jd/7loGpY2DUf8WaFHlej8uvjqlQQEzCX6l1dzFfAzM75XqVDOMlfWs7v0K1QqxjQLyOeUO9N0LnKS7lL1bZo5Fa9kT5kbTAiSGJRGVLhhpRxkI63YOWTgYNGn4DDsBrmHGo4Vi1QC+/vu6x+I3WW6gZkD8HqZ8k36r3unJmHNwCQv2l9LgDzZ5OI3q5HZVFH/r73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOZkdz2Pa10hb/TJ6zcwajtpgXnq72Z6h74CMdnH+gs=;
 b=E2gHEK4kDEdv64EB13e3OEhxI+3fSesES6h62U0qDqhtdrm7tXxo+b4z4Mvkwh8G71a+NOr2Gob5Fj4MVXSIlQOOe8/aT8qokgM2XdOF0UphUSgFR3dbotOPyW932s8dhf2msweL38PMQrgkmjO15t9MlSqvbc47XxW1I9QVE+oacwZbMyYMeqvfsygFT7G1+dBurK6GOqnkh87tjmdZhmbHRjTAq7HNeo/GGxwzKLqeh8S0cCX3TJEIGwWhZIXznQx9IIWfGRmoSXZOOf8IXOUubYOfbMjTyjPL39k1yl3GLsRFe7iJMUou8hCONcisTM7dNMvz2HNQUkEuW+DNpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:27:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:27:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 23:27:45 +0900
Message-Id: <DI9YOBRCZO89.2351OMVLR5N15@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 09/22] gpu: nova-core: mm: Add common types for all
 page table formats
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-10-joelagnelf@nvidia.com>
 <DI8B094FNUYM.3MA4K3VXN53NV@nvidia.com>
 <a9d1fc72-a5aa-440e-88cf-b04882c24878@nvidia.com>
In-Reply-To: <a9d1fc72-a5aa-440e-88cf-b04882c24878@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: a11c979c-0a3d-4bd4-8f59-08dea9e95119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: k7tf3CQGnzgP3NdIilXAhaxbWa2ODMe5OQtTssFJR7wRDxBfzvdltFdKhl8MbnQcBWEUZ/NBuK4jvGZRC+MZw1JJZ98ZRFIoWdmm8hCCO8UtZRISuGiwUiCVNmumNXqTJis4YJJt+RzLCo5Iw+iD8AmPvkHOBVFzBAOCb33fLvvuUZzQxnJTv/giw9hAjXVujyDSIpNQNuQVgZw/cASF68iX3Aid9SzrArW3ihw1EJGet/mae36CqsK97ByUn4EQ7sa2Ugo8srj2ehY/Q8a5XPwBvutdppaCdFB3dmxa4tz5rb/6gFPOEvBdlnLrC5okuDA+4vB8V6qcDq1p3B3gN8LBs/lzQvV8/Nn55AMhEbPLEPuLsE2i86f8Xpi1Dbn2cKFcbMUqkgN2bmzMg4pnhKNmf3JhGw3PMZMln9nCVCpc9J7VHEiuT+6TLngwDVbvb6n/jUidRRXrceRwZWJmfv+/rCY/hnn7htXJh6OotTi+qR+yfuKxXZ92tgghkWZyurt1kDjnuBn2DWDF4SYxcTSQO7N3sQo9fEcW1JR8n9AjptuLxEglrDZNZso3DK+XVJDSmzyxjykTaHOAmv+Ns2eh3rnIgntbArpsFuFQiGtXT7CPRZTzfNGUTVHyW23inn268voDofIYMrNabMLMzwlrfcJIU1OmaaC5uqhZUwkZHwRaA3d7LYOGXp5w/9ud
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUl3VnRROUEwd2ZhTldUbnFmdVliZEptT09GeG05Um1RcWxGZVBEclBOM0NK?=
 =?utf-8?B?aHhWNm9GK0FudHNaenNjTTBRcWhCRUgwRzMraWZHM2lZeG05cjRYdVdiZDRO?=
 =?utf-8?B?V2xJZ2lXYjR0R0NrSE16S1Ird0o1dXJOekJ1eDhsczlXKzNLWmwwWVMrUEN5?=
 =?utf-8?B?WDM0eXZxYzRPWVpRVjF0VnNac2RXREFidmtDN2ZxZG53TXRTKzN6SGRwUzlO?=
 =?utf-8?B?dlU3eVRzZHVWanlkZFdGd2JJOXFidDJ1Y1A0UFdCZnNmQ0NYR05YRnlEQThp?=
 =?utf-8?B?MGtqamwyZlExTHpFQ1A0bzFvUjFBQWdqR1VOWmhTUWplVk4yOGVDV2pOOW9V?=
 =?utf-8?B?VnFQbXcwMXdOOHhkcEROelgwSlFlRktSVEFQU3hOcUlFV1Z6YnNhZldyZ3BL?=
 =?utf-8?B?bjZ2Vkx0NHZrQ2lGMVpHbWVWNWoxaDBpNFR5NklaM3Y0MGVvTC8rUi9sZEcw?=
 =?utf-8?B?R3lLV25STFVuV3F1OW9PVVRCYnAzTUFZTXdudGNOOVhXM3FVQWxySFhkNDA3?=
 =?utf-8?B?bGhUUkJMWWF2YkJBUHFOMFFDMHZxZ21RVlhRazErZ2R6TTllNUNTaVpYbGJw?=
 =?utf-8?B?WmRMRGM2dUY3UlVSeGY5TDN6TlBCSXhpVXZINTRPTnMwV1RkMmJ6ZUQyUGVv?=
 =?utf-8?B?WUdWYTh0OUpZT29waE5Gb1MrQi90aUFENit0N0dpWXYvZ0tKNWo2dUx4TmRh?=
 =?utf-8?B?cFZybENrdEZzaVZldytKaWFsQnZqVldjQ0Jpc1RPak9mUXZjRlRpdUUwQUs2?=
 =?utf-8?B?RXJUTkR6VGhTVVkxTFJWKzZQeS9LdnpDZFlGdUFBMXN1UndzeTFRaW4ycmRU?=
 =?utf-8?B?ejk2V0Z4QURsLzh6TkxTVWpFSkFNc29WbUQ4N25Pb3ZxL0ZYRU1Yc3dlcHlS?=
 =?utf-8?B?L2ZwRWJXNVdRdTlMelM2UzV4dHlvUjRqbEs1OEpNeW5zT01EUmI2enppR2dG?=
 =?utf-8?B?d1NubWVXNFZUblAzTkJKWXM3VVpudGpCNDZSYVZoWWJxbUtzUjlLN3FEdi8v?=
 =?utf-8?B?T3V3WXN1cjNmQkNqUXk1SGhDT01GMldsV2RHeDdKUmd6T3ZrMjBoMXdoenhv?=
 =?utf-8?B?YS9CRHExZ2ZWMUNQUVkvbkpOaUl0N3hrRzhDZ3l2K0dvSkJRZkIwNnNFQTZP?=
 =?utf-8?B?NnMraWZFSWs4UzdtVDB3YzBXbXFmRU0yeGpEZCtNZnJhbmJ0NWl2dEM1Qklr?=
 =?utf-8?B?MU9Ebi81a3pIUlU2UzlOMGh4aFQvOE9yVWxXb2JGcEEvdzVBc0NaY3Y0RjR5?=
 =?utf-8?B?a0VaSFMwTS82VXFsODBoNUNQRVMzVW5xRWhFRVkrc3BTUGZ0QlplcXRicERj?=
 =?utf-8?B?SmtiOFNaZjk4enhOL29FM1BLUGw5OGpZSzRSWDlrdGppVHk1MkxCNmRoWWVz?=
 =?utf-8?B?STJ4L1VaMWNPejJRNHZJVThpL3FOdmo2TWpEd3R4ek1VVTlvNnhrZDVwdGdT?=
 =?utf-8?B?dENiTU5CL1dNQTlFWlBpN2RJbzJHMGIwekRaNWl0WmlYL1lINFkzeUx6MnBl?=
 =?utf-8?B?VHlWV25uNUd4dkJCYUEzdHJjUGtxS3NhWmxHSytaTlB6Z3AwdnNyeHZrN1NF?=
 =?utf-8?B?NUdmZWh3c2xGOG5Tc0EvRzFjNTNUU2lQQ1BzK0xQYnBWTVVncHlrVmxuSkhz?=
 =?utf-8?B?TTI3NUFGRkNxRFZsRVJYbXdnRVhzZzZRV3NQbmZ3bEx2NnRCVTVKbWNIKyts?=
 =?utf-8?B?VlNHUDM3R2d3RWlvMWpNbkNzNDVYd1ZZRWd6NXV6ZlExZUhQUC9hZ2Z0MkY1?=
 =?utf-8?B?UnFUWUMxc0hYTjA4VEorM00ycS9kWTBpWnkxS2ovaHIyaTkrMEQvRDd1N3dV?=
 =?utf-8?B?dSttYXRNUHVNWGh2ZWszNGU5ZXlVaGQrVkgvdCt6bjdLaHBDTHhqcUllTm1w?=
 =?utf-8?B?RGplRzFESWpTcGxKRnMvNEdONEprQU1kNkwxWkFLd2hpa1dmM3RCQlduQlVy?=
 =?utf-8?B?U0d4MVZPeFRwdVZocEN2Y0hzRXFuaFQ1OHNIanduTzlkbEtBVVA3MWFDZktP?=
 =?utf-8?B?Y0JEKzBwejV6Y3NOV3NOZFdtUGY2cmJ3VXQ4TVFmRk1kMUVpTFB0NWdmckVr?=
 =?utf-8?B?bUlzV3k5dzM3TFBEU3AzenhvSVlMVFNpUUhXNHV3S3huZ0szMDJER2dxdVdk?=
 =?utf-8?B?TEhYcnBXZWVCZS9DV0cxN0hxd1B3aFBxcmY3QTNIS2pDc1VlaVlPaUhYNWRM?=
 =?utf-8?B?QjFGamt4SkprelRDRktrV21ub2FGZmlFdGxUWVV4NzlJMFhMNFNTaWt3a2Jl?=
 =?utf-8?B?d1RtNWlYUTNEQy8rOXBsOURBTTZFb2ZVd1llaFJ6K0xCN0VSNkl2MUJvSTFr?=
 =?utf-8?B?cFJWZG1CVkNkSXRLc204UGhST1RrcHJTbzR3Z1A3cVpsa3V1eWIzUHRhV1Ix?=
 =?utf-8?Q?dGOSmeIQD8VTpHVLL1CbVMEG+9huViR0RBw8QyLZTcoUl?=
X-MS-Exchange-AntiSpam-MessageData-1: +BcpeG5GVTH12Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11c979c-0a3d-4bd4-8f59-08dea9e95119
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 14:27:49.0861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHn7m6FGTM+J5+ur290VYUP/oidp1Uz0XBlbKnq3zUHwGiNJuffZHiX8GcsR5112cVEgvk1o7V1JzsHRw/NecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

On Sun May 3, 2026 at 2:55 AM JST, Joel Fernandes wrote:
>
>
> On 5/2/2026 11:42 AM, Alexandre Courbot wrote:
>> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>>> Add common page table types shared between MMU v2 and v3. These types
>>> are hardware-agnostic and used by both MMU versions.
>>>
>>> Cc: Nikola Djukic <ndjukic@nvidia.com>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/mm.rs           |   1 +
>>>  drivers/gpu/nova-core/mm/pagetable.rs | 157 ++++++++++++++++++++++++++
>>>  2 files changed, 158 insertions(+)
>>>  create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
>>>
>>> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
>>> index 8b8a86980bb6..045e35c92b78 100644
>>> --- a/drivers/gpu/nova-core/mm.rs
>>> +++ b/drivers/gpu/nova-core/mm.rs
>>> @@ -32,6 +32,7 @@ macro_rules! impl_pfn_bounded {
>>>      };
>>>  }
>>> =20
>>> +pub(super) mod pagetable;
>>>  pub(crate) mod pramin;
>>>  pub(super) mod tlb;
>>> =20
>>> diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-c=
ore/mm/pagetable.rs
>>> new file mode 100644
>>> index 000000000000..637ff43ea83a
>>> --- /dev/null
>>> +++ b/drivers/gpu/nova-core/mm/pagetable.rs
>>> @@ -0,0 +1,157 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Common page table types shared between MMU v2 and v3.
>>> +//!
>>> +//! This module provides foundational types used by both MMU versions:
>>> +//! - Page table level hierarchy
>>> +//! - Memory aperture types for PDEs and PTEs
>>> +
>>> +#![expect(dead_code)]
>>> +
>>> +use kernel::num::Bounded;
>>> +
>>> +use crate::gpu::Architecture;
>>> +
>>> +/// Extracts the page table index at a given level from a virtual addr=
ess.
>>> +pub(super) trait VaLevelIndex {
>>> +    /// Return the page table index at `level` for this virtual addres=
s.
>>> +    fn level_index(&self, level: u64) -> u64;
>>> +}
>>> +
>>> +/// MMU version enumeration.
>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>> +pub(crate) enum MmuVersion {
>>> +    /// MMU v2 for Turing/Ampere/Ada.
>>> +    V2,
>>> +    /// MMU v3 for Hopper and later.
>>> +    V3,
>>> +}
>>> +
>>> +impl From<Architecture> for MmuVersion {
>>> +    fn from(arch: Architecture) -> Self {
>>> +        match arch {
>>> +            Architecture::Turing | Architecture::Ampere | Architecture=
::Ada =3D> Self::V2,
>>> +            // In the future, uncomment the following to support V3.
>>> +            // _ =3D> Self::V3,
>>=20
>> The architecture definitions for Blackwell are now in `drm-rust-next`,
>> so I think the next iteration can handle this.
>>=20
>> Which reminds me: is V3 working? I remember some fixup by Eliot
>> wandering around, have you integrated it to the series?
>
> MMU v3 is working. But this series needs more patches on top of it for
> Blackwell, I am carrying those extras in a different tree based on this
> series. The fixes from have all been integrated (either in this series or
> that other tree of extras).
>
> Have all the base blackwell patches made it into drm-rust-next? If yes, I
> can rebase this series on it, pull in the extras, and continue posting th=
e
> next mm iteration with blackwell support.

The architecture definitions are there yes. The full support (as in GSP
booting), not yet - `Gsp::boot` returns `ENOTSUPP` at the moment. If
practical, including support would be nice as it would allow the
self-tests to run on Blackwell as soon as the series is merged.
