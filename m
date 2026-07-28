Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEFCC54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B1610E597;
	Tue, 28 Jul 2026 15:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6xZHZLT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E15510E526;
 Tue, 28 Jul 2026 15:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQhVbNc2U4P836sNHtCo9tyKrCyUnol+dpwmhha+7ebQMoLGbMYHowGdw6ej/FrT74u3TzMAZlwRnDFoe6Yogaif7R3zeYTIyk8oayXfd7SV62QbrRSKJpq3Y8bPK+50v5xp1siufpYpCUFSzArPC7PLVQNn4QuhCyvlHFAVuR+IoBmPRAU8SdLYXDvqnGUjB3NVX8Ahj/cGB4GHAyjDidQRLX+9PkxKknnqFhpOjz7dCmHWYd48Dvc0zCLKJlizc2V31S/XlFhIWZcBQJRVt+ybSEeKReta4rJIwMFIKm/wR5ksdMDRx9HDyn8KqaOCSAabX4YU03ZTK6lKJTD3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQvuONd6sNka9ZQMxYV6S/sSmLeA7Fc0BjCasjm7aXw=;
 b=qG+ko6EkCEFx+LF+IPIt15F8MZeexktnbBDYfxOxK0gtC4P4KckFrp5FXflIDYyP8jzNfNAEZbF31Smpo2oNK59IkoJQVI6UGml7/sd+wXbbV17G/hrjO2H5bUeaCN7conwT1iZEhflyDf0K1556KJ0Sdy8pQoVIZOGOFeISWr88whodSrWGrZuzX9n8mvWa3goNNnkc/A0VopRVz98jY3IxPC/5lmuExWQmKFt881JcodRtdg5PXbjsgMREytJAYYRCsuwVXkjehvir7tVO9Kho9eS7mTyY7tWLc/TlQovPbaVWtrJEMXHBbSmUl/vErsi1Ymx4ouff4gyxokJ3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQvuONd6sNka9ZQMxYV6S/sSmLeA7Fc0BjCasjm7aXw=;
 b=S6xZHZLTUthmXIB2gAykuSCDcWwvCndBOPl71W8sZsEPxZuVhAA6nL5kHMH0gFdQuMP6CwmGFGoUj32cYNd4SADCAij3qn2X/6+77J488rAVQlRzKyh3D8cq2KFAyLXTDyn23ujZ64fwVFMuLGDcGkoOLCIIp1/RAD8oT5WmO8J6Stec12ZZpzYj4TmhHyblpgh2pqYh3cDQ68EuzpcvgbwrI+BVShVCl362N36BiA+ZffVUI9arTCFF1eFYfioNlLfQWFNvpuNEp6gam8nR4jY4PADu/PaYYrJsgQxi7T/o1kvf+lRRC4yXZx8kJij8ho7hSXC+C1t1LUk/tzHcJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Tue, 28 Jul 2026 15:52:22 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:52:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Airlie <airlied@redhat.com>, 
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
Date: Tue, 28 Jul 2026 11:52:19 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <00499B8B-F546-4A4E-84A6-126BAE5BC239@nvidia.com>
In-Reply-To: <ami_wF2QhQ1ZM6-f@lucifer>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <DK564OOZ3JUK.292JORO9KGKEV@nvidia.com>
 <DK57FVTRTLR2.1A906PYJ2TCE4@nvidia.com>
 <a0c06d8c-fc3a-4ede-8aba-8c7430027a35@kernel.org>
 <2FD2B991-09B3-40EE-8230-49BE3A239EEC@nvidia.com>
 <603ef1ec-bccc-4fe4-9523-e8b8a731be63@kernel.org> <ami_wF2QhQ1ZM6-f@lucifer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8044430a-dd81-4ffd-4b2e-08deecc035d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|56012099006|4143699003|11063799006|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Rvjk+j1kFw3t7ia8SQxnIL4df3c/IE/IPWWYeNT6xgXXqBSfWGcehw0w9LDKawt8XgKH9V/NcRaubXAKfM66/e6Mg9WDZhzt2uNv/AOh17dRx0CmrW4TdMcJmrwFPnlRogJudKTLuqaJNQUfxjzgbxAoRIOS9fKsqYs9HTVmrNP09WeaPiN+ft3xm35xDdpc3dE5rqPZfVPgSiB+vtTV9QyBrFFhCCLHU0+ax5XoA8/hqWBqW3b1ETpVXie+HoGXfH7giv2YHbTUC2SWdXJMS4ve25iaG77Up7wSmPoh1CF/IRDXNkD7SF/+RTCx7N7hBDGsLpc0aBhUw91gBtv+MGYNxWKp8ULUXXvTIF3Ub6lXIQbNVCXPsJXegv8P75zdJUWE50DDiMHfQ28xfzRuBs/vM8UHHKt9pYL1YDZvxind8MvvHJhCpJUhdHTZJV4RvLVzP8QLCyE6oca0LtEz8GrvfSkjkmUYVxhZrv7YyG68iZy0XILS+8gKrs+/3xmLKBLBYGLEo3pEapRlzKQtSsfRgEyVIPKi3Wmn6ihclNum8qeV4ON6WwVbtQJEwbiDIocqbLy0Ph7uH7vwcTTCA6vjyz/YCsLbt0/rMLzPvEXgxtJFQqj+K/cPb63xSC0ZsaNl6jpO23AP/kNYN/YCJ+p5JhwkUi05NRfDL0ZsUmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(4143699003)(11063799006)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xsZmtWc1ZwQmF2ZHh2WmczbEcwRmYwbWcyMU5LeS9EQXZNRHhtTC9GbG1O?=
 =?utf-8?B?OGVsbVRsUXd6L0tKR1FvSTN1V2JyNjYza0NSU0drZGxFVjdhcWRBRkVXZ2Jx?=
 =?utf-8?B?UWhnNGVPbjZZSzZuY3ZwN1BMU2Q4ZW4vY2kyWWxGcmJNL0NBMzhLSU1YbU5J?=
 =?utf-8?B?WnVOcUhCWW43OU1nK0x3NnhpVzI5c0pkSXdnS2VLVXg1QVAzMnhSTFB0K21t?=
 =?utf-8?B?K1Q5NlR5bW5BUHRGaXEyZ2gwR252QkRZU2xYS3M5NlR1cUxKaEowWkduTHVr?=
 =?utf-8?B?eS9HK1lMU000TXdLcEdLTk8xQ1NkUDFkejdqUHdoVHpUdmI4NHZLRy9HUUF6?=
 =?utf-8?B?ZlBzTDFYRnBsNDh0Vk0zM3JuTG51U2ZpT0pHeTlqdXZlYU9Xb1BEN21vd0VZ?=
 =?utf-8?B?ajV6SHBuTWorNUhxVGs5K3pXd3I2ZnMzWkZxUW9UNTQ4YzgwdEVQOEFBR001?=
 =?utf-8?B?b0NCVlZyMThwWmg3Z1MzancySGU4VndXdmZ5ZUFkMWNCRGkzV1FhWit4S3Nu?=
 =?utf-8?B?WC9aVkRjUWVBWCtqS3JUREcwNExhMkpaNE44Qk44bUZPSXh3WkpUQncraUtx?=
 =?utf-8?B?OEdxWnMwVDEvT1ErbWl1S1Z2TXRqeUlSWTAwL3NBdlR3cTkvQmQwaWJtWWVJ?=
 =?utf-8?B?ZE9SRFJ1bkl3UU5Ebi9VRzlXaGVmR0xlTTNVeWI0cXhlSy9yTFJPeGRZdVhO?=
 =?utf-8?B?amVYb1UrQ0hFRThabGVJM3JPK2ZSTzhCVkZBN1RmZVNMK2U3MExFYVUvT1N5?=
 =?utf-8?B?S3BlQmhzVzhVUkdra0hGQjdjWDN3RGNIUlNIcitXTXZRYVFVajNOVjJEempL?=
 =?utf-8?B?OEc4T0VBYXgyYmZhbHd4RXhveGQ4NEtHaEdwWDdQWnBlM2VnMU5oOXppdE51?=
 =?utf-8?B?TThXcjZrU3hrMTA2WUd4d1M1OWUyR0pITHo4M2xubnRZZVYrT29KRVlGSitC?=
 =?utf-8?B?eW8rSVI1MEhkNnVnSHFyMUZ4TmttZ0FIbC9XOU5aM2pxTk90VlQyK2dtYmxW?=
 =?utf-8?B?U1AzWURhWTZKUmJFbVdER3d4RWV0bG12OUhNaXZGN1NTVEVYZUdKWXQ0amlL?=
 =?utf-8?B?VFNMNFhsbnE3d2RyUmx1Z3dhdnRLNjVHaWdoZ2JkM3EveUpHOGpNNXRuYWFt?=
 =?utf-8?B?MXF0VXNndVYxZDFoaXFzdzVRZk1DNHRpaFdpU3dRUmdMbXg2N1p3aUFaR1JC?=
 =?utf-8?B?UDNSVGJPYmlnam5ZbGNqZjdzOEVTSDRpSjJCTzRhSHdodG5Ed0lQZG5TejV4?=
 =?utf-8?B?ZkQ1VlEvMCtwSjREeVh4NHI0QzF5bXEzY2xZMHQ2aFhFcUtXdW14c2t1RkYy?=
 =?utf-8?B?bjNQMkRTQ2FuYkZMR05ac0hoTFlXQ0xjUnE5OGVNeTVmS3J0N3V6Z1A5aW8x?=
 =?utf-8?B?LzJLOHM1VmlvbTR5ZnJvVnZRY1JTdFN1QnBvc1p2ZGdGaGlqaUo0eFhYYVRC?=
 =?utf-8?B?TVcvNFJ4ZktkaWVqZTM1L1BSTVc2TjRzQ0J1SlRST2xOTnU2RVNRdGxHV1dw?=
 =?utf-8?B?STBHN25DZE84MWg1bk9HTzRaRGZEbDBuS2ppNjk1OGRSeFdZY3NOMHNVdjQw?=
 =?utf-8?B?V2JPaVloalV5c3hTNy9pa2ZDN1M3b0VhWXZsbVNnLzdSWWl4ZFdsNEZmMHpk?=
 =?utf-8?B?WEZNTEFBWU1FU3k5RFZyS3ZBdkJOcHAvdWJvSVhLTHd4Q2dkNlZtNzZSUHd4?=
 =?utf-8?B?YlZOVXZQU0hKQWkzbWJqOU52enVDU3Y4U0loUkFQUHdyTVpRMmJ1RmszVXl2?=
 =?utf-8?B?d2tHR3FhTWtOL1BJWjZsTEV2TEx5a3UzT0dCSm4zSDdwMFk2dUFsQ1NENWxG?=
 =?utf-8?B?OWlBYmZqUktITk1Wd0MxVkNja1REbnRaZG9FQ3VKVHlyanVIYWFsRmkxZHRD?=
 =?utf-8?B?RWJCMnV1VE0reTVhVHRYWmxCdTRwaU42UE9FcU9rbzJKNEhSeU9mdkM0dGJI?=
 =?utf-8?B?TVdlNDVmbmR6NC9rdEY1Q293NjZUblVDSm5iNVIwalNBSFlEQU5KaHpydEtX?=
 =?utf-8?B?VE84a3RlcXg1clB1RXFRemFMa3E3S29LeldCY3IzVTA0cE9tbUtRNWFSeGZE?=
 =?utf-8?B?RldZUmtBZnhROFNXUTFzbDQzdUhMejFyajVhSUkvU09HZ1FTTDBEeHpKc0NZ?=
 =?utf-8?B?SXE3cnF2Rit3OVIrV0cxNEh6Tjc0TEk0dWk5ZXhMUXZxdmJ5L1VpbHBSdmVi?=
 =?utf-8?B?QmJhOXlyWmVocGdLbm1lTDc3T24yRzkya202dHFUZW8weUZDZmtnRFVBTlpK?=
 =?utf-8?B?RlVyT2p6SDNRcGxxbjBleUZHWlFaWUpmYWpEWlU3OTdPYnkrckFOeE5SUXRT?=
 =?utf-8?Q?nYTyZK/oIm4TrXCLGk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8044430a-dd81-4ffd-4b2e-08deecc035d2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:52:21.7356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASeMUIPDKpNnurr71F0hUcPRzD0rHkkRjTx5bPLcT1fCqpXtLDWluAhnZNHyZ6nG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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

On 28 Jul 2026, at 10:44, Lorenzo Stoakes (ARM) wrote:

> On Tue, Jul 28, 2026 at 02:58:39PM +0200, David Hildenbrand (Arm) wrote:
>> On 7/27/26 20:23, Zi Yan wrote:
>>> On 27 Jul 2026, at 13:33, David Hildenbrand (Arm) wrote:
>>>
>>>> On 7/22/26 17:28, Zi Yan wrote:
>>>>>
>>>>> Strickly speaking, these vm_insert*() compound pages are not folios,
>>>>> since folios are supposed to be rmappable and they are either anonymous
>>>>> memory or file-backed memory. I am working on separating them from
>>>>> rmappable folios by replacing PG_private with PG_folio and marking all
>>>>> pages in a folio with PG_folio in page_rmappable_folio().
>>>>>
>>>>> Hopefully, we can find a better name, like refcounted_folio, later for
>>>>> these non-rmappable compound pages.
>>>>
>>>> They wouldn't really be folios, I guess. They would likely be a simple
>>>> "refcounted" memtype that allows for compound pages.
>>>
>>> Yes, they are not folios. But “folio” was started to replace “compound page”
>>> and slowly becomes rmappable anon and file-backed. People outside MM still
>>> thinks “folio” == “compound page”.
>>
>> Yes, it's a bit of a mess now.
>>
>>> But once I manage to remove PG_private
>>> and get us PG_folio, page_folio() will return NULL for non-folio compound
>>> pages and we will need a new type for them, “refcounted_XXX”. We can decide
>>> XXX when I get there. :)
>>
>> So far willy did not document a type that just has a refcount.
>>
>> https://kernelnewbies.org/MatthewWilcox/Memdescs
>
> I was going to say.
>
> It seems a bit specific, because different things might have a different use for
> 'pages with refcounts that shouldn't be touched by core mm' and different
> semantics perhaps.
>
> Obviously if it was a different memdesc type then it'd not be a folio.

Yes, this part is easy. Slab uses GFP_COMP and no one regards large slab pages
as folios. The confusion comes from large pages without a page_type.

>
>>
>> Maybe "Managed memory" (struct mgdesc) could be the right thing for some memory
>> with a refcount.

For driver allocated memory, probably yes. I also see allocations listed below
with GFP_KERNEL_ACCOUNT | __GFP_COMP, so AcctMem would also be a candidate.

1. arch/s390/kvm/dat.c
2. io_uring/memmap.c
3. drivers/dma-buf/heaps/system_heap.c when mem_accounting is enabled.

>>
>> The question is, if the use case at hand would even require a refcount, of if
>> frozen pages would be good enough.

I hope so and that could simplify our work without handling refcount. But I assume
user outside MM would still want a refcount to do the page life time management
work, otherwise they might need to build their own one(s).

>>
>>>
>>>>
>>>> But what is the conclusion here? It sounds like "folio_split_" is the entirely
>>>> wrong interface for these compound pages.
>
> Yeah the thing is we need some clarification on what is a folio exactly.
>
> 	A folio is a physically, virtually and logically contiguous set of
> 	bytes.  It is a power-of-two in size, and it is aligned to that same
> 	power-of-two.  It is at least as large as %PAGE_SIZE.  If it is in the
> 	page cache, it is at a file offset which is a multiple of that
> 	power-of-two.  It may be mapped into userspace at an address which is at
> 	an arbitrary page offset, but its kernel virtual address is aligned to
> 	its size.
>
> By that definition a compound page _is_ a folio. And anything that _could_ be
> mapped into userland.
>
> But if we are going to say folio == rmappable then can we actually update the
> description of folio to say so?
>
> Or perhaps reference the fact that 'transitionally' it is as above, but in
> future will mean only rmappable.

I can come up with a patch clarifying the comment.

>
>>>
>>> We probably would allow folio_split() to be used on compound pages now
>>> until we can make a clean distinction, e.g., using PG_folio, between them.
>>>
>>> Yes, folio_split() and its helper functions are meant for rmappable anon and
>>> file-backed folios. But currently “folio” is de facto “compound page”, since
>>> for example prep_compound_head() initializes folio fields even if it is meant
>>> only for compound pages.
>>
>> If we can stop more abuse right from the start, that would be nice.
>
> Yes.
>
>>
>> We do have split_page() that splits a non-compound higher-order page. Maybe we
>> want a split_compound_page(), or allow for split_page() to accept compound pages.
>
> Ha! I read this after making this very same suggestion. High.. 5?
>
> But yeah obviously agree.
>
>>
>> Because splitting a folio is really something different than splitting just some
>> compound page (no mapping/pagecache/whatever involved).
>
> Yup.

It sounds like split_compound_page() gets some love (David, Lorenzo, and Matthew
all want it). I can add one to mm/page_alloc.c, so that Matthew can build
his patchset on top of it.


Best Regards,
Yan, Zi
