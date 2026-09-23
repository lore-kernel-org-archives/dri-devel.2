Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0682C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4151210E1A1;
	Wed, 23 Sep 2026 23:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmUrYRvg";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4583F10E1A1;
 Wed, 23 Sep 2026 23:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDLXCz16OsE+0efu+EyFBybZLuFSahJFc4/bDk79RxYCYQPbwysV3um3TTwW5q9ywKKL6Jw9GSVTdQ04SOya0Ww6f9cxeymIrUg2oUcJvqPyqgnwHla5RyPj/SE8sXCSgqKDjjAbmCbvswdSDpzxUEE9CGoCriiM+XUDdwWJtz0UoPj9Vwl6VgqyxiddqDEVR9sf4PtdpNXuw8VeHYA87vYQ17mz6r4wq65edmqMxeCnMpTOYxePTaEuDRettNh2MNXCLiltOHcTGlv6XlMlRm3Gunm5GjdBOL5/VoE2cDk2XdpcoxLbcL+C3xZrfbSnHipmntz/nXeKgWF1dmq8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjzSfbmot2oLMR17gLjpFaXvIDEfhHfrbP2NjaI53xk=;
 b=sUz56jvXePh/XsppY3TXC0mmuOsrLzcVP4tAoCFxy8vE3liVeA5FQiaJPbTDVrB/hNAom5Fitp7h1kYJyvRHDGpLR+zdDgnsh6bQk1XqS7N+EeuhyK8XQ8/3gZYukxuCLrUozdrpD/hMpWLXyQpQ0ZFoAXhe1VchCcGlIVmmlQ5d2ocL98urOYYr2RwxlQ/N8ovM5u4LcuvzeJjO89DOpgX4lxUsyPryAcAZs6FM5UdEsNMU0AR8l9F1RHpxyNMwuUw1tLYHoPIbW6pht5zusF2vqVX6cMp4daJqJ/wS2EHYGYuH5DhQ569/gfIaKeEsCx8/NQ+ez1248yatbCJ8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjzSfbmot2oLMR17gLjpFaXvIDEfhHfrbP2NjaI53xk=;
 b=HmUrYRvgt+ygrgPq768kdvb2ehxENAa71QKkQSiINAJAJju0aMR53Q9TN4wlg11ooW8T6e2FphzrOSatrChw1vXC2c0WjV6lAD8q3L/ub19jcuwyG8Uk/DSfRs6I9VOtoZINkHkPbwKXAFBpFylh7EFfny615GVnVddkCYAxIHV82iO4HutRXMM/vZCpqwGWs+fKiN+JOkDEGyr+IgGvf2SAo1bProGhYABeZCynAqoJpMlkqtBZQkTeX2s7ERN0kiq5wMvZ5PZk/rZxawHbHl2TvQnQaxshzltSiYsbyIFdDJ2Cc0CsViWNZO9OMv279OFtG2yEqVRexcbgCWYOiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN0PR12MB5858.namprd12.prod.outlook.com
 (2603:10b6:208:379::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 23:24:03 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 23:24:03 +0000
Date: Wed, 23 Sep 2026 20:24:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 00/12] [PATCH v14 00/12] migrate on fault for device pages
Message-ID: <20260923232402.GI2545495@nvidia.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922192726.90dec3c4c77b8c9063dbf218@linux-foundation.org>
 <5b1d0fa6-d183-446e-bc52-56e0afd3f398@redhat.com>
 <20260923141936.d1f9e5b85355f0bdc6a6ecd2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923141936.d1f9e5b85355f0bdc6a6ecd2@linux-foundation.org>
X-ClientProxiedBy: BN9PR03CA0480.namprd03.prod.outlook.com
 (2603:10b6:408:139::35) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc4d60c-df77-4178-f896-08df19c9c16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jc0vaactrFZ3IQbDQ8ctm8cMZgLjHRdcmqxzz6aDkWqDlWZHoi3H573U7NC7x/oiCz+jhLHWY5C2iWjnfCLVNOGyp3mT61SxtBOMQ8VCO5OM51/csUIF0PotHVCn1b9FrR00grfme+dC7IWcHzYuMNTdpH96H3WdIcJjNaUvn9o8z68bEVnC8hhwVpyB1ecw64xnQ/FO7WOQnNDS86/Wt7THzCliCz+way7JI1MiSa04TkSougoicnoyIioNW9bKLBDFp2N39h98HO1HpYZqOJ3WBlkS/Ds9DUBb2w/GG0nKhc/ZlkDLmAwZPyPDccCSSgGQiQ4YEE4P/Ep9tx+dyaH89DNKRYGBa3n+ecPOZjT3S7Br58a69X5lVTbEoIaLu3U73kCE1IKNssZwaKwoD5On2n33Cxz74FL+b/GB+MD9uAYmhZ5/7k5iZ5XXLteqhul91zYdBJVzYT3KmEUfiJuhukDAY1AlqVDN4ZEa5MjzDhbJxjH8blzY91m0V3bfoAr1U3gmao2ayy38UtfcTQskmxPthY0QIOxDxypfkWtPOVgbrIu0WahMYI4/w/FLWaH1RVD3WUJwYQcF1DBZVm5gjtuHGcQdXK3CnyhAQf+sNx+H7dtQrtTYWBAGCOvjDVaZrFGsfh/FNgb4mEinCwakJHgHvF427AuXQ9uOtKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhWUElkVjdrODFMa1cxWktsMVNpSTdiQzk3MFp5OFE4MHB0L1ZCcDI1WWps?=
 =?utf-8?B?R1YyVnd3SzB5S0QrUmFrdUhQRjlsN2ZIVDdqZFRqeCtZOFEvTUZzYjhMOXV3?=
 =?utf-8?B?S0Rpci9lYmZIdGpubndzQThRZG1TeWcyTU5URU1rbDQyUGV5eTk5dnI0c21J?=
 =?utf-8?B?TGUwZVBOVTZyS1Z2d29yVC9wR2s2TzdYWEZ2ampxOXBLRUluNzdFMDBtM2FL?=
 =?utf-8?B?dDY5dEFvTm4xblZENThtaHcrMWFtSzNTQ0FleWVSZ0hqQXNiMy8wNTZiajVM?=
 =?utf-8?B?VU1TMnlVcnZwRjUrblV2Z3FjSG04dXFtSGhDeDFjSFhMN0N5bEgrbjZ1cG9S?=
 =?utf-8?B?dnFvc0JKYldZTy9OSFVlSy9qaFRQaW0yK1kzd3U3cmJFTkhnZ0lVMVZ0dFNJ?=
 =?utf-8?B?Y1o4blhIWlFQUGYwMjFTZ3JBam9zQkQ0Z2lkVXo3RmswdzNKQVJIRXdNZ1V0?=
 =?utf-8?B?Q1FsOFZHbEdINlYrbFFaWUhsSkZkNDZnSHJkeURCaVJpdjZpNHVVRlMwU214?=
 =?utf-8?B?bWhiNHJxTzUwREt5dWNRYWVmY01uZFcrbjltOVcxeDlMUDB2QUVXeC96amdv?=
 =?utf-8?B?LzZrTzBiZjNRUlZqK3BOTEo5OFZzSUFNRmhvSkVQcENkd1Avb3JQRDRudk5h?=
 =?utf-8?B?ZjAvY1hFV1ZnOERqTWZzUlAzY25NYXlFbUdwMW9wY2tNRm1LOE9JRWFzSk5w?=
 =?utf-8?B?MllNYWhYOUZxR2hoaExBSWd1UFpOSmhyV1ljMWJnb3YyUDJvekwvMzgrVk9R?=
 =?utf-8?B?RTBnQ2dPbElMN2dWU3JGWmZxdm1zTmxIcHVyM2NYN2gzbkwvVXRMcG16bDFE?=
 =?utf-8?B?WHhHaHhkZVBZbXVuY1Z1MU5TVk9LQWJjY1lYMWFKdnk0dU1OZEV6ck1EY3NK?=
 =?utf-8?B?cGpDejR5cm1jTHliWko1VE9mK1JoTENncVNUbDBLeG8xNEN3bm5MQWVtaFhN?=
 =?utf-8?B?ODRSVENDbU9MdDlVK0w1ajRBNWVGd09yRHVrVmprU1B2bHl1K3haSzRmeVUr?=
 =?utf-8?B?ZUZ1Z0J6Vk9jSDR4cExJb20wSHV4ejhFb1Q2Z0Y5bXhsdnZ6b1B5Q2YwMUpI?=
 =?utf-8?B?YWV5Ris3U0tSSUNtaWFYa3VLNlZrWUxhTFpzbkM1VUxrMzR3NENsbmg1eTR2?=
 =?utf-8?B?cEhIS3FWdVgrczZQSm51Q1F3U2YvUWhOUHpqK0U1NjBIWFZjbFU1Y3cwMXRG?=
 =?utf-8?B?N1JydllwWTI1eThUdFd0Z3J4ZnVPTU40UDNHSWNnZ0lZZ3lsUEZORXBwM0Yx?=
 =?utf-8?B?WnhFSk5IR24wbHZxZlMrUVFpaEQwNVd0THowNytDaTBLQkVSY2xhR2ZsQXk2?=
 =?utf-8?B?Ync4aS9yalByb2dNaVZVYVU2cksrWkJUMlVTVWsxOW84WTBtSk9GdmVIektM?=
 =?utf-8?B?ME1qenYzNWhvUkVGVmF2WUdSNWdGM0hSeHlUcDVPRHpoS1YxQUJBamJRN0hE?=
 =?utf-8?B?bmtSa2xkL3BxcVVQZEJNRTlyVFZOWTAzcWhvMUNqOC9ndFU2djFGcnk5WHdB?=
 =?utf-8?B?cCtzYnNBY1JBN3NRQ2JnU1drUjczNUxWUzJZOGpHak5QTmhENlJYbWNRdUJB?=
 =?utf-8?B?VytKTEtpR1RKSU5CQ3cvN0tLbDhzMllzL0llQWtzaFIvZDR5aHFJWTZld2V1?=
 =?utf-8?B?Q0FYdXJoS0ZVenhVK2lBZEczVi9PRGlOKzBaQlFjZ3VkMVdQYmRzNkVJOEpR?=
 =?utf-8?B?VTVocnhteGJ5ZmlSZEJIMWlxeUFnZjdBMXNwall5WmVZQW1sVFNPb0ZUT21J?=
 =?utf-8?B?TXY5ZW1SeUttbmRCNjZLWjNwS2NqbVpQQVU2NHI1dkdjekxjZWtyQzZKK0tu?=
 =?utf-8?B?VlZoUkZmZzhVQWtxMWM3d25kWHFDenI3bWI0LzlLRXpZamx5NU9IYytQa0Rs?=
 =?utf-8?B?Umd6ZjdJZUpIKzZMVmtkSUtXcitKbU92UnhXS0ZXY2IvMEZiSXV4ZlZMaFNT?=
 =?utf-8?B?QkZDODJIZTNUSlNwd1NRK2NsSktjVmpXN1VOREhNbmF5YjNyd3YyNS9YKzJw?=
 =?utf-8?B?U1JXSFVqcUsxdmlMQXVBRm4wUTcxUG56NmQ0NGVYUDFIdVdsdjB2OGVvblUw?=
 =?utf-8?B?bzZ6VE01ZE5LT0wxYkFaTzB1T2dtekRPZDM2cHRQR3N1dnlqWFVBSHRwMmlW?=
 =?utf-8?B?a1YwZGRwY2YxeC9PK0doRjBrdmQ0dXNtMGFPb2pMamdjbUx3SkVaL1F3K2da?=
 =?utf-8?B?Q3Z4WW1WQzFUUmNxdHBadUJVdGdJWlBHRk9Ta0Q5UUlPc3J5MjMrWDR1Mzhm?=
 =?utf-8?B?akh5WHNiTWVTNjJ3V2paZWxEQXZBZzkxQjFBaWhieUhkNGxMSlVXYm0vMjRL?=
 =?utf-8?Q?2/+DIUilJGy6+w6/9N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc4d60c-df77-4178-f896-08df19c9c16c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 23:24:03.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNAiTUmpiu+GlG1R9CiA5XKKWuSdtdhbUDvNS58zMk4PxJRxzEj0ziM6YVNgZXLh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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

On Wed, Sep 23, 2026 at 02:19:36PM -0700, Andrew Morton wrote:
> On Wed, 23 Sep 2026 08:29:34 +0300 Mika Penttilä <mpenttil@redhat.com> wrote:
> 
> > 
> > >> migration). It is also tricky to code correctly. One page table walk
> > >> could costs over 1000 cpu cycles on X86-64, which is a significant hit.
> > >>
> > >> We should be able to walk the page table once, faulting
> > >> pages in as required and replacing them with migration entries if
> > >> requested.
> > > Sounds sensible.
> > >
> > >> Tested in X86-64 VM with HMM test device, passing the selftests.
> > >> For performance, the migrate throughput tests from the selftests
> > >> show similar numbers (within error margin) as unmodified kernel.
> > > But no performance benefits are demonstrated?
> > 
> > There are no performance regressions for current tests.
> > Real benefits come if want to do migrate on fault.
> > For migrate on fault today missing pages are collected as not-present and
> > the caller has to fault them and re-run migrate_vma_setup(); folding 
> > HMM_PFN_REQ_FAULT into the collecting walk removes that extra
> > fault+retry round-trip, dropping two page table walks. Page table walks
> > are not cheap. Not to mention simplified implementation for driver.
> > Also, the vma looked up as part of the walk is readily available for
> > migration, eliminating the need for explicit vma lookup - one more
> > performance benefit. Net effect two saved page table walks and
> > one vma lookup.
> 
> It certainly sounds that this series will result in performance
> improvements, but have those improvements been quantified?
> 
> > This series also addresses the vanished/reborn page table while
> > collecting problem which can crash current implementation.
> 
> Oh.  I didn't get that message from the v14 changelogs, and crashes in
> the current implementation are not what we want.  In fact, addressing
> those is more important than speeding things up.

Yeah, what is this about?

The series still has lots of sashiko remarks, are they legit?

Jason
