Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FDCC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C01210E65F;
	Mon, 17 Aug 2026 07:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYUYbYQV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7E210E65F;
 Mon, 17 Aug 2026 07:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVi3cPia3vhiV9F7It0EYxnJU6TBj20kxxiorHZXipZ80HZU6xyqE+akkinzan5srN71bcxc+2yNmq1hLk1hBytN8TlRkABZl5PKwztL7pkOVhJb2sNmJSut2RPIPEhSIOwfVi4p0OkedpkOff9gMfHx7Vtn1wZxC8majyS+llLYwdUf1uP8CXxKEDaxZJdoMya0p9PeMX+pvwmcfHuSIWI+2M54oxnBfNuNT+33Qc1vWDpCEmlpII0KIP6Q5gguxRJy3uv4sI2Zn8BqWitAHyIRdX1RS0pgvCcTGxUs31qYxMbRPQZHM7RlVil1n12HDoFURiYImgLNf3j1ZS3eHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q21J9KzuvdH2vJmkhAxBPrjPk+VkKC3Ihbb2a3Ym6EU=;
 b=s0lZeMWFAt28gCevjiPIpvAlV6kANq434WhelQSbVaXftOpNIAeEe5EJFI9I0sx+UXqgkgXc4scxugI/5UGq0j0Ys+IqtAJHNYj7HxPDN+z4lDsZZR3mC31km6Nh47FLBuFkmxLyeplYRppLKwiie09xTbGHduvosChNTnqrriqzJhAIbZ+FwJjK7TRkKO2cxqOl5aLX9Lex0vJe96QSSfMCuYVCwA0CX28inNISB+lDxDNZ4OXX/zy94Y4y32vZl/8JYsxhQ2/AV3CmXQ3FGDiwMzVGxcl57opeIO67Zur8BL4JoiR6EmKv5XnQSptyIaN6G7Kw4FZgMWEHns+H/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q21J9KzuvdH2vJmkhAxBPrjPk+VkKC3Ihbb2a3Ym6EU=;
 b=PYUYbYQVYQ70K1f9O16xgEdsYXbuA5njndIQIRPVx4wnUwwHdsHZsChTCawWPwaKsdj0NvTwMIr6f+fct0D6acNnkQoU+t4ClOi+NBlD5sBUXIEKEuIciYkDJTYn1GfNkg52Jm6kmw5WZJEGSLrIZT7gOu3xbWG6jnzvNxMIAR/cV2pNtqAbTDqGYADwQJkIQVZq29ZGYwJW5sd/CMr/0jyas//nwGSC4Yuwh02xkaTbUpxUdsvtq+EmXtf4HSRk5wg1zJ4YScm04rHLuTJyYRHTcpr2UqKhVMvlVTHDEylLvG0Xr7h7NfRz5v4MmPByNkWokaP4zffo21r96zl5LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:03:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:03:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 16:03:51 +0900
Message-Id: <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury>
In-Reply-To: <an8r4VECQ8iFP8ze@yury>
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: bad77bc2-192c-46e1-7e33-08defc2db59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: QKXwH+ohzE0uZpPPs9FCU5BKg2H/XEQH4EX4hu43J/COq6ICbx8TPEt6rKqdW7THSTVlblJAVOzfbP0NiA3+ue1UKMA/cXgGN4EzMNgZk5kN4WOXMcKa/BBw48/urkDaykt2AQJV03Oi8f/YPpBesRQFlLLNnxpYGYJb+RzLCqn+JXPsTSwWQqS3EC1piac/N7Wp+uwwZUY2hsmhERipPbmAQt8yqFd5dwmRXGVEkHs5sW6Znea1Qtvvl60Ajca7K7stC8YjQnsD5Sc6be/WiIXFnfZLvs3G8ZjtBAwCEiQbrinKvZiiwDVZlYQ85Hgjt6U4NfKIbpPgaDULoGg2efBpKwpswp2u9JWB7zHGapWhCF5nB3gU/joB7iB+sxtVCDD07ucEgyn/CWHNFbryj2QFxN0CM+uv1UZsJ3/p62b8SYtgKXKPo+XBi0USONwr+DxkrPL+Gy/Sygq+1zY7zKfezpo6gjb+Q6STeTDqY7AEFU6lysKNcLFxjssSQRkZYzLv/QrV+fhUhvZbbNzjAkYGP4AUmg5axlz/kv7kslZIG0mab9nqwCp6k2h9V8MsbLr1y6JJphnAwgAPsCh62vUXtfqsxCSbABkKSgwphtkD7mTUk3rDtvhJ8712n6b4n8gt7bhaBXmjUY/gvjkR+KPFE/9t9KTxAxLWq8Q1lWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJad2FCS3BCM005MGJaOFRtaDlHRWpRc0NnbEk3UEU0MXgyeEd0Mm42T3pW?=
 =?utf-8?B?V2dRQ3hFbnpMVDdMQTQ3SUM1c2xRNUlIeGFyZDFDK0ZWT1QvaE1jQnk1a0hi?=
 =?utf-8?B?aGpTYVhOVzQzRTVrVUd0em5XTHFrTzNRZTRqb0x0ZzE5RUpDV1plN2JpMFEz?=
 =?utf-8?B?YUJuR24zVHNOQ1ppVGJnV3ArengxT3lsem90SEFwNFpwL2RheS94clNrSTV4?=
 =?utf-8?B?QWVHSURNKzFOMjgvaXY3cUF5RXF5RmM3VTEvcGpnREE0WFJseWZLWGlmU0gz?=
 =?utf-8?B?WGZKQmpLZVFJUlJLS3FYMXR4NlVJY0ltSlc1eW9nQ1BVM3drKys5S1VJVnYr?=
 =?utf-8?B?TldPUXBGZDFvRzlWQ0tKU2VEQk9CTk9EN2VkSXJtUnFtU2lldVQ1WVdUR3ov?=
 =?utf-8?B?K1MyTk8vd1hUMUxXWXZ4UDdEZlVIZUlSTnNoRDl0b1ZiVGo3a1BVWWJiTG9O?=
 =?utf-8?B?YVNXclZyRm5ydGRCSGo0UkFVemZJT0dhbVF6UTZlOWZ4S0VrTDRzVnIzZnUw?=
 =?utf-8?B?T3hLMklBa3dHUHgwajFGRS9Md2xZTzZHRkQ2UVNQVGl4Ly9WWklUN3ZYdXp5?=
 =?utf-8?B?STFkZTRnMDlhVXQ5QWs5R0RlalRaby9QSDBzZVhQeTJxc3pJL3RIeTNBVTBp?=
 =?utf-8?B?SUszWWd2Nzc0aHBiamJmMkFMZXE1UE93UThIb01xcDBNMlFwQnl5RDUvbXRa?=
 =?utf-8?B?M1ZsRnM2Yld0dGFDeTFMQktPV21aYkN4K0R4ZnZxcGZCWlMvTE0vcStzcHRF?=
 =?utf-8?B?VEp3R0M5ZFhpaUV4eXB1MGdwMmRFVCs3L3cvNURmV0cxQ1BlMUNaZjV2ZWNC?=
 =?utf-8?B?WU1RVUU5eHN0bDBDTlh5aUduZlJYdU80K1U4OHRPK1N5elE3b2hkeU1ReHF0?=
 =?utf-8?B?ZExoY3ZsR3gyQXFBekY4a2J4WXA5Qm9HdGkxMjNHV0FwV3lpVGNnMFZwZ2xF?=
 =?utf-8?B?QkcwWDJXdGxCUEo1eTdWVFozZG8vdzhsN1kwVkhubEt1Z2RFay9sRXNLRlFU?=
 =?utf-8?B?bG04bGk4SS8vdkxsbzZvc0Q4RHhXSU45c2NvcUVobUFwNzhIMWN6NFhqNnly?=
 =?utf-8?B?bzRmOFBHOStQbWJ5akYwd0E5dGNOMUs4Yy9pSkxpeTZTVDdHaDl3NElGbE45?=
 =?utf-8?B?elRjUE03ejdQeDRqRVN0RXArUExodnB4UDlNcDJxVitlK0d5aS9xUnBpWUdS?=
 =?utf-8?B?Ujk1QWY2dFNkbkVoOXpSb2xtTExLUW15TWFHS2VEQ1hCZS83ajNhV3d5NVRr?=
 =?utf-8?B?bUxrR2w2Mm1TbWVGa3hHQnBHaG55OU1na1pYQmNmZTZSR1RaMkVGNnRmdDVU?=
 =?utf-8?B?QUJodlZ5NTlnZTR5a3U0UUswVkxUT2dsNWlZQjh5UEtITnNhTDVDRzdmaC9I?=
 =?utf-8?B?WWNDVnJCbDJkYlBIWDR0QThvTVpDcjFaUXpxbzQ5Skt4SmcrMkNKeG02MFQ5?=
 =?utf-8?B?YVhUTXg1USs0YXBRREM0NUpwbFJsZFlwVVNuelZsd3R2S3Z1dFhGZ3hsb2xR?=
 =?utf-8?B?Q1oyN21kckJPYjA1MkRyb015WU95VFUyZUpSVlJmVFkzYW9FN3RjNnM1QmJO?=
 =?utf-8?B?ZW8yemdsZkcrd2wxWkZDSGxyN1hWVFlsRlRWOE1MOVc5OFNJV3dkLzg1RHlw?=
 =?utf-8?B?TGM5OEFJTmNMNUM1Mjh6SGxBcytBQ0Q4bVJEVUZ5WVJPYzZzb3BoQVNxUDJX?=
 =?utf-8?B?VmpDVUs4Y1ZOSUpZS1JCQ00zLzZPZ2JuOExlb2doaXFQTVpHRmFnb3ZqNHBX?=
 =?utf-8?B?S0tSUFJkUDNEVmdQRncycWZsUWJpR0QrK2xMbmNYL1pqTmlkVUZDUnVFdFlq?=
 =?utf-8?B?MmlCZHF4bHEybGxKNGpaWWpKUFlvS0VEa2p6RENwRTlQdFc1Z3hDQ2JZQ0la?=
 =?utf-8?B?RWthQkJkakVLQmdhZ0J4dTZuKzA5Tm53QlBmWVJKYlEzUENWcXJ2THNKY09o?=
 =?utf-8?B?OFNNa3E4aEVYUXpPUmNBSEs4YUpPTDBaTGJ6ejVnTUNTZVhtM05Qamt2dlJ5?=
 =?utf-8?B?c3hSRngwQllLWkpTVGRVb0JSczBNZ3NtakJKRC9WNDkwOUo4N2dlRG1EVTZC?=
 =?utf-8?B?d2orazJ3anArb0tDMk5KZ3hXUWd3dDRkV1owMEJ1NEc5SE11V2dad0p0UVUx?=
 =?utf-8?B?TGVvN0RXR05yWU5XUGJaTEZodGVZMzRlQzYyeVVvQm80ekJTN0pqZVBncENz?=
 =?utf-8?B?eVpZb3QwYytlMUorc1lOWWw1REovZ2JSUXZUSng2SWJUOVNNeWZZOVF3Ymtl?=
 =?utf-8?B?d0FGR1AwYW5vdE9uWHBGUWlDRi9lZ2ZXUWExSzNYU1FWSjNEc3YzUE5CUkhw?=
 =?utf-8?B?NTVzRHFuUSt2Mm5aZ0NpdkNONkhDNUdVajlyaDI0N0x2V1hneHJqTDltTEFP?=
 =?utf-8?Q?1c8By26T9udbBtrwecrRu66hZtlVKluGSJJXxEJ2MURCV?=
X-MS-Exchange-AntiSpam-MessageData-1: IynuPElLlNcu5g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad77bc2-192c-46e1-7e33-08defc2db59a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:03:58.5044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbI5FDF8iyiKp6qO9D4EAvBHpY6WNLJAn9OqIBBWvru3knlgugAjr05eIa83xU4xO7NQd2CNQmcSn93cEFOzNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

On Fri Aug 14, 2026 at 11:53 PM JST, Yury Norov wrote:
> On Fri, Aug 14, 2026 at 05:08:43AM -0400, Yury Norov wrote:
>> On Fri, Aug 14, 2026 at 01:54:24PM +0900, Eliot Courtney wrote:
>> > > 1. Provide a nz! macro to create constant non-zero things. Provide s=
ome
>> > >    constants for common alignments
>> > >
>> > > Potentially, we could use build_assert! for cases it is provably
>> > > non-zero but not a literal (although tbh not sure this is a good ide=
a -
>> > > at least not do this initially).=20
>> > >
>> > > So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: som=
e
>> > > build assert gated construction of NonZero. A general nz! macro coul=
d
>> > > also help ergonomics for other use cases too.
>> > >
>> > > That looks like this:
>> > >
>> > > pool.alloc_area(nz!(8), Alignment::AL_8)?;
>> >=20
>> > Actually found that if we implement SizeConstants for Alignment then w=
e
>> > can get Alignment::SZ_4K etc almost for free.
>>=20
>> Then maybe pass SZ_4K directly, and allow the alloc_area() to
>> calculate the alignment:
>>=20
>>         pool.alloc_area(nz!(8), SZ_4K)?;
>
> Even worse, you can advertise the function like: allocate a contiguous
> set of channel IDs enough to represent XXX bytes of memory with YYY
> alignment. And that way, you'll be able to do:
>
>           pool.alloc_area(SZ_8K, SZ_4K)?;
>
> If my understanding of the function is right, it would be a clear
> improvement, because the user now doesn't think about ID channels pool
> as a set of bits, but an abstraction over the memory access technique,
> which it really is.

If we pass SZ_4K directly, we are back to using plain integers, which is
not what we should be doing for rust interfaces according to Miguel. Let
me send a new version of this with my Alignment constants + nz! macro
idea, IMO it helps with the verbosity.

I don't quite understand your point about memory access. The purpose
here is just to be an allocator of IDs, not memory - it's just that we
have some contiguousness and alignment requirements of the IDs
themselves.  The values we're passing in just represent numbers of
channels and constraints on those. I think that callers will naturally
want to allocate a particular number of channels, not a specific amount
of memory that corresponds to some number of channels in some way (e.g.
USERD?). On pre-Blackwell, OpenRM makes channel ID area reservations for
vGPU power of two number of channels and and places them so the base
channel ID is aligned to the number of channels. Sorry if I have
misunderstood your point. Maybe we should rename `alloc_area` to
`reserve_ids` or something like that if it would make it clearer?

