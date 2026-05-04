Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C0CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D5B10E004;
	Mon,  4 May 2026 19:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLefpc2g";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F5610E004
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYaFWBTKyVY/ULg8FkQk13QxFZ+8GgyvVsMuaLss4SAaQ0vTJtCDK7Z6BtNUwypJiui9AMpHpL2lEWhb9yz1cvxlzm6NytC45hQvoJu9SxcAI3Mvuw+P0S6RFBSpWQxYYEIO81Gf8F9fGYNRQg7YsVdrsKuiKwhduyfkHYz2jf9Kjtu0M46d4R4St44YsWEpoXuHkK84JPrCT96yq+DTdB2Zloq+AIBOT2G36EHfTEiurVYw37BSBkPaje2rIVl6EfP5xyXbX3PPFgqPMa2AZig5946efJSLC3yYlYJHnJdwOjzxo+cIDQ9zk9J+mkJIrjh8+NVAKfODXHpMAdEINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOAIB3o0BEk1ik1dYYL6eqvx1BuzW9yLnuffAL18upw=;
 b=UPbM8jcrD7WdLJuSDx1mCzTVmnOE34DECYHKODc1vr//mcWS3dtQGdp9xjEH9p/0YsHpdgm3VPumybiPDRhCyvM6yEL+fE7nIlyb+y/Jclrm5tWPnf0PIsb69nwOwAGZFCIWwaxhtDzPfl8t3zIaFVg/1aUFGqf8/lzYtxrPOUHaDQyr/WkuPoQAkL0S3EpPZyDKRwT386/xdHqGNoCIqoje01KusOv/2CnmvY8xbEtr5vnFbMfI8S4RaP6k/vU6w5MyKiB56FSfJSG5nqVzRx4JqRF4leuH/JYImycPzkn+k9B3u7XX13EIPobqjbv6CYDOdtjf6uN/BnpeUWoKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOAIB3o0BEk1ik1dYYL6eqvx1BuzW9yLnuffAL18upw=;
 b=pLefpc2g6lttIHysbcVlgbofQqFj2+2nTZ9CuMDTZ773cI17aQOO56pQewBce718sBOk7wu60jTADwXzWQdqYstOoCF1MpnXnYAYs7Wvad8TSAVm6ctjEZU8lVEKSVOLHa3rrESj5H6UdEZk5iIiV8H/oKc4X2a/YJEpZTZJLuAWG9hca1fUxsPKhnOhDAaNrkyJv4c+QypgnPuIM/c6j9CVnTv2OfFyDPvhO6cP8T2cRdgXldb6uAarG0ci/KjORH5nSU4fTLNoCtySxAHEsQ1ad11obgYhser6zYUUmEaf1CSi/t5a3DhKiAP1Pn4cnuBN/k/rmEwk4IW8GegmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 19:28:10 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:28:10 +0000
Message-ID: <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
Date: Mon, 4 May 2026 15:28:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
 <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
 <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
 <DI9YR10HH6PE.AMLEZUV7701V@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI9YR10HH6PE.AMLEZUV7701V@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d1a618-ddce-4b4a-f25e-08deaa134671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FNhxHjRMOAcAjvVawULUn7NlDFz77Ic2xPtzVEpvhgzUUerClAGG17Tn8PusYsew6HFBXW05io4kPqgQwGN7sh0QmapoxArUylv40MV/5diI8bXYNRKKmcIEWIGBIRM1bkb4Mufh6BflGQAhXe9CdbX2UGIVU1uv71QqoQtUlnX2gu6bTliSUbT023a/Hs2ZXRQ8ysgmPSX9AZDFOpsowzlVrB40jHNPHNL5eYHATWCUVFFAL974MCH5UJba5at+1HlhsSG5vFsQLxrx4gYq5K3N8h8WWSBXrKsAWkiwik6m0AI8sEeDaMjXBh31z1jM6mOpB8zn3I2WU772pr34BA2OcTrzrvJLzo4YPqHpXqgI3Hs8C/ZQ8Z6jbGqpxQ+qbZCbSAgWr0xKKTF8KcDRdFpYOdAeJ2f0kMS7TuNFplNFAmzG+ja21n+vIbWdJt3JKKHgdkTiClLmGap4kxYv5u+/sV6jGODSml+VnzVaXu5GJIlg81fslgm0x4ISVQghsWzSaLgTk5e/WdC1nmD5MdusMSDhibEMIAFkdQHd1AlrvLG/uYWCIUPpR9RW+bmdQjxegYkpDKC4jAtSuiVNp2D4Mo+jaRMe8cO2l4netEUT/WApgAXh2LJff0xuU19YSYKmBEP4w42rh+H4ny+n3cKcCd7f/vBITSOMrh2+Zod0l5RKeefRr6CBAN/4NRAZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NPRWsvUXh4YUMySlNYajB4MTJwb1BHSlhuUHRPWENPYzZXNzloOGU1Q2No?=
 =?utf-8?B?SDJvaGdFT2VPcnFQRWl0cTBIZmRES09ZbmhZbTJYTm5Da0FUVzFHQ2NteW80?=
 =?utf-8?B?MXRuQ1pRMWNjRldlRGdQeDNwNzdMTmFGTHQzK2p5dnAyUFpPYXE3aTlGWFVa?=
 =?utf-8?B?dUxkdlZweUM2ZmZ2RHYvcjNtRm1HOWJwK0V3akxOUldvSExUdk9PeHVzdDlm?=
 =?utf-8?B?UDVpZzByUE44RGo4V0YvalV0RmNRWU9LMFZ6Q2wrajFxeUQ5d093TkN2RW45?=
 =?utf-8?B?eGdmWGdqZ0FKVnpFUHgyQXVuVEJZV25lTC83NFd3MUNjRk9HdDdTMU8wTERB?=
 =?utf-8?B?TlM4M01kMzFVOEdsTjRhL3d6MHJ1RXJjY1BXU2pZODk0TFdlRFJ3NTlEQlJ4?=
 =?utf-8?B?RlpoMTlWYWF1Tm11SFNxL2ZyTG5DMDdsMkZtS2NMcmNHV0czRXVXbE1HRGpE?=
 =?utf-8?B?OTFmbExLQ0FoUVVvcHBtWUU2eWNtRk5nV21yYnZRbEpWTis5R1p2UzlxOXd2?=
 =?utf-8?B?a2NZRDV5MXBNeGVvL2IrVEd0QUYweXU3R1VheW9CRUxrdCtjaDBXejJOVUlh?=
 =?utf-8?B?SDV0ZUlHbDJ1dkVFTkVJcGpabnhyd1VaQ04weWYyeXRUN0xDaUNuU084Z0x3?=
 =?utf-8?B?azlONndqRWNWTERaa3daLzM0MmdCd285dks1eW1ZYzZjV05wSHN5Tm9rV1hU?=
 =?utf-8?B?emxpbk5xWnVuUm9KY1J2ZHhOVGZsOFEwc1l0STJzUWF5azN3a1lMZmpMa05W?=
 =?utf-8?B?UWpTQkxwM3VZbHA5Q3R0OHIvM0tQbCttMEZNRjFYTDlTeEZDV05TWWpmS3c5?=
 =?utf-8?B?aVYycnNBT0EwU2VpMEIyazZVdUlvMjBocXVrZjcwS1hoT09OaXFja25DYnA4?=
 =?utf-8?B?MFVKY3M2dGJhdVVId0w1OWtyRzZyTnM1REdjZEphRFZzWFphUHl2NGU4NkFC?=
 =?utf-8?B?Zlo0eHVRckdCMHVZUHVCYjNkZDhuQkhqUUxlalpYWkxCbEVBR2JRKzcydC80?=
 =?utf-8?B?QmE5UnowS3pVN3hrTVEzNWZvYUh3SEZ2a1IxQW9WNzNQZENrdEJ2K3JVMk4r?=
 =?utf-8?B?MjJxUzR0TE0rZEN0MERndTFaQ0Z4bVh2aUQxQlJTcEFobHkvL1J6WDE4VE00?=
 =?utf-8?B?ZUFnQlJHSWJpeFlhUkJ3V3VpVFpseDEza29iSkFieDlOSHNyajVla2hLenh0?=
 =?utf-8?B?VG1ZSkNLVktlRVFQYnNjWFB3YU9Ddmpna3JweXg3NFNvRm5XeVdGRENWTUhr?=
 =?utf-8?B?RXNsa24rVW90SHZRazZ2VXA3ckVZOUpFK2lSZEpwOUpEbmN1ZDlKeW1Sa3Fz?=
 =?utf-8?B?eFJHNGNHVzIvWlcyejM2dkRiWjliTGdMbXluaStyeU1tTFljWDRBWDdoeFRI?=
 =?utf-8?B?MURvUjExNG9tdzBlTUlnakh6dlV2NU1rTkFUQnRPUzI2dHlDYkQvbkJEZTNv?=
 =?utf-8?B?WmduM2gvNmNNRXNVRDZYdjQ5WTd5dGpEV1FwV3NKZU5FMzhjQzFrQlN5ZWwv?=
 =?utf-8?B?QUZ3eGdpNHhPLzNWcGxKdk9GT0FHKy96S0pDZVdHMUVmZVlVTU9vZzduZkZl?=
 =?utf-8?B?TFRRQWdwa1FmWEVqMGd4VHpTNXdocm1UaVZIdGNyWVlhdHlZUnRSZGVUQnpV?=
 =?utf-8?B?YTlGM0JDdi9lemQvTXhRZUE5Rm5hTEFQK1lFL2FPdEwreUtidTM3UUhEOTU3?=
 =?utf-8?B?VlRSQ2dzckxpTFZma2N0OXlLT2V0SUhZdmdYVHN5YjFmVWRqRC90ZjVqYlV4?=
 =?utf-8?B?cE13c1VibHg3QVJRYXNzYms3SEdkT0lvQjFqazdNQ0xYc2dtZTR6TCtIbjZ4?=
 =?utf-8?B?MWM1SVRWMmcwR3pKbTNLTDdoOVNSVm0vMHBQL1VwcWdmWlJRbFphdFc3TGQ4?=
 =?utf-8?B?ampnR3BZcG9STHduNjAwUjc3ZW1VTHk2dTZrL0poWDc4QWhDcWxIdjVOTnp3?=
 =?utf-8?B?dTJrZG9FcHF4M3gxaGhGY3RFZ204aDI5UjR2WmZUSnY5VmRvT0FYdmg2Q2g5?=
 =?utf-8?B?ZWtvUE1Ka2hRcmVzejZjdTluUzhjUHFYVXNjaE12NVU1ZGhLUTM2R3ZCNGxV?=
 =?utf-8?B?RkV5eXBpSTgvM09VTmtjMG0yaU54Ykx3YUxRTCtQZzhjRzZKNjFGaWt1UTZQ?=
 =?utf-8?B?MU45TUYzVzE4cHA5L1ppUnZ0TURnRG5qQml6TWp0RVl1VmllNnZJdmpWaDhO?=
 =?utf-8?B?UFIxUzFSVEpFU2N5c0E3NWhYZDY4VStYTkNZQnJ5a3hRRUc2VFJjM0lBVjEz?=
 =?utf-8?B?WjVoOW0yRzFWdDhPS2ZLZnhjYVY5RzFKNDJKeHhFNThCQy9tSHp0dkZ6a0hR?=
 =?utf-8?B?cVZITzY2ZWgwUGlUMzVUWU1mVGlrS3lHWDFxbTZ3OUw5M3hoWGt6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d1a618-ddce-4b4a-f25e-08deaa134671
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:28:09.9686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kj3STbZB165cOTTxOAl1sL6iUqyu9S2Fpd4QUUlN/XRhDpxzZjviG89449/Za9Vikge7uLqJnYZlkgiuIsF+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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



On 5/4/2026 10:31 AM, Alexandre Courbot wrote:
> On Sun May 3, 2026 at 4:19 AM JST, Joel Fernandes wrote:
>>> Please reorder things so they land, as much as possible, in their final
>>> form. In this case this probably means defining the trait *before* the V2
>>> and V3 page table definitions, so they can implement it from the get-go.
>>
>> That is a reasonable approach too, I can try to do that, but it is
>> misleading to say '270 lines of diff that reviewers will have processed for
>> nothing' which is nothing but fiction. Please look more carefully, the
>> patch is iterative on the series.
> 
> For context, here is where the 270 lines of diff come from:
> 
>  drivers/gpu/nova-core/mm/pagetable/ver2.rs | 150 ++++++++------
>  drivers/gpu/nova-core/mm/pagetable/ver3.rs | 120 +++++++----
> 
> But the number is not important.

It is important, numbers and accuracy are really important things
especially on the Linux kernel mailing list. Sorry if you feel that is
inconvenient. And even quoting the 270 is a falsehood, the 270 lines were
not refactored, only 90 lines or so was.

> My feedback was that refactoring code> right after you introduce it is a
strong indicator that something should
> be reordered/squashed to prevent unneeded cognitive load on reviewers.
> This is particularly important on long series like this one.

Again you are misleading in the email, because the scale of 'refactor'
matters. Only 90 lines were 'refactored' with 300 more lines added so it is
a perfectly reasonable approach to refactor a small part of an earlier
patch when you're trying to introduce a new concept (in this case, we
introduced new traits). Do you want me to show you examples of that in the
git tree or are you convinced?

Considering the amount of change is so small, I would prefer to leave it in
its current state since I don't see the benefit of further restructuring.
We are already at v12 now and the patches were posted and reposted (and
tested) now for months. Keep in mind also that I already re-ordered the
patches once per your request, and I don't think I would do that yet again.
We are getting close to merging at this point.

thanks,
--
Joel Fernandes

