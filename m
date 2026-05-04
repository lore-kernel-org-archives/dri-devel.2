Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1793CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 23:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BD710E052;
	Mon,  4 May 2026 23:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqQ+zYHQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F58A10E052
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 23:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LM2n+n61Fj7BTcK7vbjf52/pj0BnB0RXwEYOOApsN78uiOmOPldOIlM53Y6zxxC3jXVAExwbNk+n37JwLS1TaSpAPrj0DPtgHLneSFsmygHlveVzS5Rv8r1XTGtVsSX7bnz6rg4XbU5T6n+qUS6qo9N5uHVp/GXmoVzrkM9RWWuB0BSs309Lgjgx2Ogkuw9+hMLEGAG6ctNfANRE8m8654NS6FmN/vNFNIl9adn3dXlqrDDatcDnN1geHQHHgUXIXYXqDJ6mX0ZZxffMba+NzPpv71TxXN8y6PoivxQqN727y9CHfD9P8dDjBraeERA4dJofRhqQ0CmMWHUtv9Dc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zurYBn8EGd+819X8UC/MYzCgdK0KUBBWd/pHw4NdktU=;
 b=hbie5FDNjANvV+KnmA1UWPByceCISgqlu1e0Y/uWnBVE+SWhAakAHUb7yo35pI2JEj4c5ATGTdQhPR1xUBjmII9EQm+AjRjm0S/6njolnDmYzK5Y71SoyNMSAyLP7yumcLVHaz++nfs4+hESnc0BnJxG+nx/IdGYcjO9hMUng+EfnG7/dlrskxebj1gP1zsVxcLT5ncPFSAnxBP7CvhuSpmcly8gLkC3aeekGHT9RkjEf5C/TiBKI5h0f9X440iY8PmM3oAKT8h9S8pePB/GzVIjRO7VHkxVHDqo7bferEhUBKhbbXiZDFjzCgcAmLKJogqxigMhDLfLmb9Cv4OKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zurYBn8EGd+819X8UC/MYzCgdK0KUBBWd/pHw4NdktU=;
 b=hqQ+zYHQeHyVs0PzT+Scidcwx1CzZbFcAPjZwX+Oq1mYs8KN0rajo3dL5rV4QkV7uCpmoBieTePiDdFro25QstTsxkXgUQesV5Ru/Sl+vlyzLNOLuWchcM5d8hgLOP9Cq0dD1Dd1OLDh86+zJY7p5rVl7v9O+/ziZRStxKOlTYJYZl1PTRy76A4EIvP0VOPmn0sCHCrjuLygk6+GPmH+4sMZhW3qDapL+PCkEpI9EAVB2lIyDYC1T95sFsV7bdTMpZ2NAOPCB01hK73Ts59gWJUV9velruN8QO+QQcl4T8faPPW473Om2HOrukeTRWxxQtKdqA1ytbLMhDXuGcSOiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 23:50:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 23:50:16 +0000
Message-ID: <a34a844d-0594-4522-8599-9302d130beeb@nvidia.com>
Date: Mon, 4 May 2026 19:50:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Dave Airlie <airlied@redhat.com>,
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
 <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
 <DIA5D0RYRE24.2LB65BF0UK4UI@kernel.org>
 <be30c1e1-414c-49d9-ba0c-4be4f486e8df@nvidia.com>
Content-Language: en-US
In-Reply-To: <be30c1e1-414c-49d9-ba0c-4be4f486e8df@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::33) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 053d1ee4-6a35-4d7f-a01d-08deaa37e3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: jatAyG/vUeP/B91lADYvWKw4bnZGH7BAybBHXJhymyRiBnqyL/OvNyk3S1vhD4/7yCaxgkQg7iZ3hvHBK9NbtiGB4NexkGKXwKUNaC5v/RlDrOLyCeEba83TxFOwZRxtuYMR9kcdjiKCoVyrk85ImpqohsZGxLr6o6OIlHyT2J76qhTnwdeyGUwhbHSTGncoecl4QE5LNUETETWLT2oPcl6S/sqmQmkrOUf5sRhwDnn/BvsMLf7rmFYREY6klV1IjE7BJ5a0wz0hydfjTfuEx3vKeZ8SFbP46TBkRXhzutyR4/7g8jq4DaOtxl2WHQgoqRzkgy4nnVnRNVM/v6Jf0e4Z4y59BEYzFfqKPqZHWqk7au6q+MTxDJ6P8NcFoTbwtUPd95vV/PPLwsdIpjetNcTSsaCi8u9kLTb47Q9o1AlZQpJMEKmwqAz2hqGrf8qjdCJXWk6rfyGHMkO+VUpkDxzoAEx/w2cTuzzDxQeO9n5kK9+UgYVjMiOO9E5jhwrCHTHTclaMUZGhUFZytiTN9IhSagjRqW4v1WBSibYVsiwSczfum5p0ROSeoLur/Y5GTwBuJTg08ny+vnU4URRQ8atvwp9FxFjtI3VsmHL4gsZIrIc+eF8u5cNalTXD7oU4RTF5h3a/sP78fRpVvAmIg0l4F8hweo+kr+XfaZcSTfkYtStbtMKZaFp5xJ1SMZdh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lycmxQRkxzWU43ZlNkZHlVNEJrS0xlRlpscEpJZHEwTGk4d2hyaUc0eGgx?=
 =?utf-8?B?SnIra2lCZ0VLYTEzVHFIK28vWUNORmZKK1k0SnJwRjBDVEJxN3hPOEIxUWtz?=
 =?utf-8?B?NUUwZloyQjZWYklVZ05VSEh1TG0wWmtMbXJSdlJrOS9MbzExZGhzRmQ1K0xQ?=
 =?utf-8?B?VEVzSmpQeDZIUmRzTlFMWnBWRGw2ZGNKL0NxUytNVytOK3hkSlllazlpRnVM?=
 =?utf-8?B?ZHZoUnJRS2dsNnJrK2dnQk5lZHJKNFNqUFlKOU0xb3VWL3ltWGp2ZTFTOEIy?=
 =?utf-8?B?SWY0clcvbFRWZWE0RkRRVGZZM1kxc0s5cmgvRXNJY3l4Qk0zblJORUtRTENH?=
 =?utf-8?B?a2RZdmhUMlVpaldBQ2V3dDFmRURLYWJFTTBIUll5OHhGSDZHdG1YVzdVbEI0?=
 =?utf-8?B?WEFBOHhUWHdVWEFUTFovc1BlWkJ4a2ROVEltaWFMaUFvZi9IOVZhU29OV0lU?=
 =?utf-8?B?ZnpXZGVkT0RRdy82Sy81OTd2WDBDT1Nxb2dJNGY0NWRUNjMybDV3OU9ZWXRP?=
 =?utf-8?B?a3M4UzFSUzFZMzMrdEl2SE5hSWszai9zbGxWaVpKRUNPQUlDK3c5T3owR3Vv?=
 =?utf-8?B?dXNva2cwSjdmK0NqNG1YSEVyV0EzSENBU2gwU1MxbnJleWVPUWV2U0hjd3RI?=
 =?utf-8?B?WWUzL1lNdXlpVDIzSlRVZzNjRWt2ell3YnpNamVuS2Mvc0NoWWlEZlVYUmZj?=
 =?utf-8?B?Z3FlcEpibHZOeVJud3FUK1NrR1JlYUtUaUozT1V1NUxsb2N0azlpVytLaUpr?=
 =?utf-8?B?VEEvbjJEbkMvVUwwbkEvUWhtcTg2OVdBQnpsUGdtTHpxaS8xZG1pSkRla1FU?=
 =?utf-8?B?TC82RVdmc3JSMHdlVzFobzlJMnN4cnV4WHRZQWp5WE4zT2pEUjRqbm5VL09Y?=
 =?utf-8?B?QlR0cHl5Yis0NmtmbUROV2xmS2ZsUHg5bHFCRHNlOFgxTE5SSUdHZU4zS3U4?=
 =?utf-8?B?L2lqMll1Q3NKQStLR0VCSFE4UmdzZ1oxQ1p6Z0lIZ25SUnI3TWw5WDdRS09h?=
 =?utf-8?B?Ym5IekVDcUVCOTc3aTRTajh0U090aFVoaHFZWXpxeFpZTG5oOHZRYzR4ZUZy?=
 =?utf-8?B?OUxaelFkZEpJTlJ3cCtTa1BjQmxxaU11WlBSZE1OWWpqSGJnM0dKTjdMQ2JE?=
 =?utf-8?B?WUNqb0VuK1I1M0dKUnU1aWxyaUU5YUdDeEtTY1FMaFFPclF3eFZkSmkwUDVk?=
 =?utf-8?B?b3dSUVFiaVY4alFseHZ6UUl0cHZ5RjJaa09MVnlqQ29sNG10dGVRVWN3RVR2?=
 =?utf-8?B?M25TMFBKVnpJY25kZGk5RnAxdHNUSTdIbW1weFdZUFVRZDFCb21VUzF0bkxF?=
 =?utf-8?B?UE15NmJGQXdmZ1cyWXgvUVpiR0JSeE1qRkN1d2tSaTVRalJ0Y0xHUGE0MW1p?=
 =?utf-8?B?aFRJWiswNUJVTkhHL2tSWkczcjBPQm9aQlJWbUhybWlqRG9Dbmt5RW4veng3?=
 =?utf-8?B?Tzd3OFBUd2NJdnVzN3BNZGx5aEpDSHRYanRRcE13NEF2VVVvZVdJMmFDQnhy?=
 =?utf-8?B?ay9BazdSZGhiOHhwOHFyc3dLVEtuWTlrVE8rZkI3bklWd01kdFlWZjMxUjdG?=
 =?utf-8?B?ZWszb0dMN1dkKzcxSGkxMGQrRlM1ZC9CcndORVhVRnZxc21RRExFVUVNMVdC?=
 =?utf-8?B?UFFKQ2tCNzFSWXhrV0FDSUNsRzN2RXhTRnhwMytlQWhhNlFKM2VVandKMnJz?=
 =?utf-8?B?N1Jzem5tRkhBNHlUc3JPMmRwRkRZc3hRYmRHUE9XY0NIUG1JbkZLS3liY1lw?=
 =?utf-8?B?M0p0a21wOGUyUlVhT0lLRkpKK3FtV3JYYURvUFpQeElqb3JZMXdvZjJtZlpq?=
 =?utf-8?B?c3JrSVZTN2dSbENseTJlZmVsbkpUN0dNK3Zpb0FLTHdHMXBNdjBMdjhIZ0dm?=
 =?utf-8?B?ZVlMR3A4WlpyRTQwYVdpNk93TUl0dGw5N0hxR1BFa3dEUWJjV091M1k4RWZZ?=
 =?utf-8?B?M3ZmNzU1c2tUOG0rbUdZQXY3NGNRNWxJbDhja0Q2QlVKUDVKVnNOV0VTQ0dW?=
 =?utf-8?B?Ync4SHI3RGYxMlp4MHJBeXdjTGRBSlkxWWFmbG1pMTVHdkgyTkx4bVdtblln?=
 =?utf-8?B?YkY1MG1NdGJFa09QWVVCdzZ1R2NCM0dYM2xhVUZVUGR0bzd0bytZdXNMN2lU?=
 =?utf-8?B?cnF0UnRiQTBZc01aa1BsRjUwSUE3Q0VUOEF6bG9GUFJsdlFkeFdTb0xzK2FU?=
 =?utf-8?B?cWR3bWpnbm41d2drWGo1TmxHbzhBV205ek9lTExIU2h4UG8xemsyVHhmWEJN?=
 =?utf-8?B?c2pMaUZpemlXU1dtK0hCMVFEelVHSHdJWTBnRlpCaitoUGFrVVQvbmt1UnFK?=
 =?utf-8?B?OVgybHRXNVdTMmJjU1EzeHRGQnRKNjhxTWQ4SmJDYUYrK1pZN2Jxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053d1ee4-6a35-4d7f-a01d-08deaa37e3e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:50:16.0045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cGv8mu+SEGJiYpRdUJoWUpdAUUvJpKMfhCrORFTRuWH0zQVVdxErF0TndmeLkC1w2x0M89tf3f+E0n42vzthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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



On 5/4/2026 3:50 PM, Joel Fernandes wrote:
> 
> 
> On 5/4/2026 3:42 PM, Danilo Krummrich wrote:
>> On Mon May 4, 2026 at 9:28 PM CEST, Joel Fernandes wrote:
>>> We are already at v12 now
>>
>> To be fair, the series is actually at v6, as you initially added those patches
>> to another series that was at v6 already back then, and then you decided to just
>> keep going with it. So, nothing too crazy going on that front. :-)
> 
> I was thinking of resetting it to v1 and starting by breaking it up and
> starting over from what's left instead of a v13. I think at this point,
> probably breaking it down into multiple series with new version numbers
> makes sense. And I can point to the old patch series that way for reference.
> 
> Could you clarify how much time we have left to submit to drm-rust-next? I
> can then plan the next series accordingly. I did make some changes to GpuMm
> to be more suitable for channels, but haven't posted them yet.
> 

Answering my own question, and correct me if I'm off but I think we have 4
weeks more left since the tree is expected to close on -rc6. So I'm going
to curate a new drm-rust-next series tomorrow with patches that I think are
7.2 ready (with tags, or those that got lots of reviews already).

