Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D2606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PhkJ+RTg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE7B10E04A;
	Mon,  2 Nov 2026 13:52:23 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C605210E04A;
 Mon,  2 Nov 2026 13:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZOv5qvXOl+xnn/Wergl/Kz8fk9NjPLwGbxZE27w283tpqJLlDuujA6Ln4SLOdsIUtlr8JpMJ46/usGYDgZY2QI8VxwMWfAVj85Rs/QooIDkM3gctmFyPbaHpJ5Vc32XBh1e7yMu+yzhufMJk1oFOJK+fynW9KGrDwsVCqA9tILU57r2eE6w3EUXgGP18vWwrvme/6M5EnX+zZGHg4MBAQhOfqjGK4fxg1Aeqx9q7wxgN/E2sm7R3JESxKSkHUOwJ6vsKEsTIO5waBjqa8oow+BMFQP5UNyGbFOvF/bwI4nayiKMAdWrK10ICjBOt153g/W21Ob+vtAoY8INHZavvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q3u5pS+Y65E8Bopb11C+ZzErL0aPrjpl0habtp1hMo=;
 b=cINUl31lVZNVCx9Gbew15/VoWUDxpJjwT/uy18SOZxNf+0MHLEbwnlCAFWGilb2/ZN27x08To0sTlgAopHR+V/mhYQpFODeJPtqVZR9DWAyCCVbIIpOIz9t2FhGoz5+dtCnIPiu8NTvWhFDkpG6IY2FUNk4wRxX61P+GTLKObNlM6a95YkH2PV44IUcUI3PDOdwbf+yY13aiV1Hq7Ds4KeJ3MeBteCC9YMSeo82CpcToYCqxlo6orXEwkttWq9CK8xuzl1h8w3wIvDFxxBMPwKKKj2/UDVECreRM4uSQqobMMgO+1P9Sg/tfo6fQ75YDiXnx2BCXg32WMuBZbcQlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q3u5pS+Y65E8Bopb11C+ZzErL0aPrjpl0habtp1hMo=;
 b=PhkJ+RTg7zo5+f3XBcvevcFTuKlj3ne3tcVdShLAZNIyEfWd4b5vYiMc2V0OOeAmWLnriVk/4ZhU0q49vnUoA9SZ6SXabaiwvTG3Xzj3EAIWk4UC88dUe4zpSRrx0eCyOw0m9Wq8N5ilKZ858vkapGlmqwe9q1N50+lWYE8eckg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:52:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:52:11 +0000
Message-ID: <e925fde8-5d07-419f-a25e-4dd0bb90ad46@amd.com>
Date: Mon, 2 Nov 2026 14:51:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: honor write requests for owned device-private
 pages
To: Aveline Noir <jm5905938@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Andrew Morton <akpm@linux-foundation.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jonathan Corbet <corbet@lwn.net>, Danilo Krummrich <dakr@kernel.org>,
 David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 dri-devel@lists.freedesktop.org, Francois Dugast
 <francois.dugast@intel.com>, Christoph Hellwig <hch@lst.de>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Honglei Huang <honghuan@amd.com>, Jann Horn <jannh@google.com>,
 Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Leon Romanovsky <leon@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>, Michal Hocko <mhocko@suse.com>,
 Nico Pache <nico.pache@linux.dev>, nouveau@lists.freedesktop.org,
 Pedro Falcato <pfalcato@suse.de>, Philip Yang <Philip.Yang@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev, Simona Vetter <simona@ffwll.ch>,
 Shuah Khan <skhan@linuxfoundation.org>, Sunil Khatri <sunil.khatri@amd.com>,
 Suren Baghdasaryan <surenb@google.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Zi Yan <ziy@nvidia.com>
References: <179343062238.2.2773026701442863377@gmail.com>
 <sashiko-outbox-192310@kernel.org>
 <179352350180.2.12918668886938034091.b4-reply@b4>
 <179362220860.2958105.9509793190720553695.b4-reply@b4>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <179362220860.2958105.9509793190720553695.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: cf739b49-f493-4e31-a969-08df38e87e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 7PhJomOzB1ZVcNR4zVVcPV71oPfOUSyJB9kloBNlOxNSIAKpsROMTJk8aGEP7vGFYyGKj55VR4zH8jBXOX8kmS8DvSrbkuIQDSqpjCZOjYc5Aa/KLZWEHTgT8DXb4xihvSxGw0kBW0hl/ddrA2LkmHAvN+M3F+2R7+XTMdq/7hR9Sa7eGPWab7z+d39quY1BOvzSHRUfqqMKlJcisOSWpMW3qtmUQVmTAW4V4TFoQYRfimvdT34vA4GKM1HlE6RE8jlBKB9fQgYBFagu3MZaWbZELOhtmCPyVLq/nZdEEuKrSGfPTJYTD/krIe9kUNXYULyGRYtbDYolKaVA7lSMBRrUBcUFIb0q5Fs4AnZuKxxi16u7STCktZk1KLvQFAbbnY0B+dp83L96vlp9pSOh65wroNDtFQ7bmdJpTa9Fl0nk3p/nIbGz/YLRkHVQkF5f87XSH7fxOzl2Bg92+pXrJ9Mf5j5N9JOmwWhpWlpUG5ZtbdkaX/z/B/lyX9EvtyfXYyCV0XYPeCGtdac8q32DXML7vLrN3BbYZ79KV8JhwzMdn8bzO3jIQEGFX1lFAFLBAv1vFF7ELCyi99q04HemWn4yTyG6vViBlZX6bifl88s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5VMml3bXNCMVNyYmU5V1o5TXEyN29oaXRoSDBBc1hSVjZhT0V6MkNQQjlC?=
 =?utf-8?B?MmNkeVV4WkhiTGxpUVlad2dYd2N3bStWNnIrWCtobERpWVRuWXpsZksraktN?=
 =?utf-8?B?WXRwOXdPZHAzalNjYWF5ZzVSSW1nbkc1TDd4SGJnbVNHMHlvSGpvMC9VZnBp?=
 =?utf-8?B?QXhpMXhTc1lwQUM5b1JlYkF0cmNjWXV1bGYvZjhTWCtZcStxL1hVMVFUc3ds?=
 =?utf-8?B?b2dCQmpsSlc5Qjl3cDJWZk9hSFJiQ1kvaE5CbG5uWEZCNGtIT1RUc2xMQmty?=
 =?utf-8?B?NmpUZ1NWazdaUHlqNXRoZG5PM1o3TzJ5SVFCM01OY0NaNHUvWlpib1N3T1FW?=
 =?utf-8?B?aVQyRGpINzRvYU10aWpVSEY0VnJDeU9aMWcxN2Z2M2pQcTkwWGxtYnNZb0hX?=
 =?utf-8?B?aERCV29YQXo0eGl5Zm92aTlzenVjaGhxaDRrbEJSSTRGcS9YOCtmcklnY3N1?=
 =?utf-8?B?UEZvaGxoWGNvcSs0dHBRd1FFZDVQQyttU3NERzBnd2tENkllOTVuQ20yN3l5?=
 =?utf-8?B?NFBTemwzWVJBeUdJb2NXdzhROUZFaGZxNEdQMHlLT1FCMHNzVm56VDRyZXRi?=
 =?utf-8?B?NFIwYnpJK0hQT1lPQWNIVjBpb24wNEJHK3E2RTJLMWN6TXBXZkQ2enhwVDhj?=
 =?utf-8?B?NFQ3dHJOSnNMWkRTV0JRZTFLaDVvUmtBaVhRbHVrZTcxTHNXbUh5TmZsdzRW?=
 =?utf-8?B?NUpOMnpLNzRVR1VvOWJ4ejdnaHpCVmk2aTZwTlRxQlRpVlczNExvK0l5dUYr?=
 =?utf-8?B?MUtueTl3T0FPY3VXVndoS2hZd1ZRdnBIcTJiWm9tQXhtTVN4b1llckxGZlpZ?=
 =?utf-8?B?ZUthejFaRlhLOVRjWStKelNhUEtkYTJKWUNrdkhLblMyOWUyRGdNR1EybHo5?=
 =?utf-8?B?NG1rOUgvTXBobk5zdEZoS0l3dkc3VElkc05YcTlFSDU0bGJQQ0UzcnZ6ckcw?=
 =?utf-8?B?eURWZmt3V1M4cXlJSkhtS2FsclJobERDcG5YL3FUY0VqYktNZmJjUlh2Wjhs?=
 =?utf-8?B?UEhqZUtWS3hQV2R6RmpGNmxiS3F4c1Z1dytrZjFadmZDbWxuVStoc1R1dXRO?=
 =?utf-8?B?WXhpSTkxVUk3NWZCd3lPdEZBRHMwOStBckxKMUdRdzRKM3IzMmVTOWxZZDAz?=
 =?utf-8?B?Umtnd00zTHppaWY3TW5PQ2U0TGdDZ2tsYmk2VlgxWXhsZ0JFVFUzQTY2VU9z?=
 =?utf-8?B?ZkhUM2thYmNTNEU0U0VZTll3VG1YdHhOWjgzTUNEa2xKWFNMamdFWGVabzU2?=
 =?utf-8?B?N3ZzQnlLRnRtQVA4bEZGK0pnekp3bU5LSTA3cUNLRTlOMDZNVWlTMFpZN05y?=
 =?utf-8?B?cGJ5NXZob0cvaVcxUUY2aGFWYUpMaFZTNHFmSUMyejJwZjFReXNNREdqWUxy?=
 =?utf-8?B?azN3SFE5MzBmZ09QYml4QmMrcnpzWnR4SDdxbGx6UkU4MVREdmN3bU1QUHI2?=
 =?utf-8?B?UzFZVnlDY3VNOW5qd3lNZVdLL1NVZENpRmU3a2IrOWhVWXFITHN4ZTBSdytN?=
 =?utf-8?B?Vjk4NGVWYi92TmQzR2lWaHRpK3pGbVVFZXdkajJFVXhtSlYvVjFibGRKSHhy?=
 =?utf-8?B?TE9aSnhtRTY5eVdPSDJhYXgrdjZOT1RzaVRRSEx4YnlqYUgzdUpZZGdubFpF?=
 =?utf-8?B?Z2l4Z1N4MlhBeEczTm5pM3JPeXhZYmpDcmtmQjVBZjdocTJKR3hjbmR1Qmtp?=
 =?utf-8?B?YWg5YVdvQlVIbkxleTF4aGRZaTduN083bmNEUnJvcUJqWDNCdHplRWJ0YXBi?=
 =?utf-8?B?T25TeHdsdmJVbG9KRmIxaS9xR2pvQmcrclBnYWl3WFJLUlEyNnBXRnRZVExh?=
 =?utf-8?B?NVRqKzZTdmJ0MVpkUTVrVGdIazRQelNxb2pjTlBjSEk5VWVRU0NTN01RMVZU?=
 =?utf-8?B?MndjODJYbHJtWXBoYVlkUEM1cHV4RHo0RHp6QitqSnczdDFPQ0hjQW9OVjA1?=
 =?utf-8?B?dnF2VlIvRHJtbmNhVDAzekF0dDdCdEFyQ1JVRG5FWDBQRHphUFVvd3BTQnBw?=
 =?utf-8?B?OEhSWDJyeW5VdnRPcGl1dlNJWTFSMTgrclZnbC9IQTJZYy9TQ0RHMkdidHUy?=
 =?utf-8?B?TVNCZjlIeURjVEV5aDJmVmw3WDJLRWJ1SjUxMEdNQitZN05VQ0pPMkNoRXEr?=
 =?utf-8?B?eTB0Rjk5YTZDemljekFvVklONXlCM1lCaDhRMEdlL2tBZ2FYNG5pekMyVWtq?=
 =?utf-8?B?eE8wUCs1TDNoK1RMNDVPMWt6ak1rNXp1QTlDNGpDUGFFYTZZSDVKRHZxazZW?=
 =?utf-8?B?UWI1UnVhbTVaN3ZqdjZLM0JGL1V1KzhVOEo3WHh2c3B5eDlUckZ2YjFsUDJo?=
 =?utf-8?Q?eREMN8QRzG3ZKebURz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf739b49-f493-4e31-a969-08df38e87e1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:52:11.0837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yad+RD9Svb4hOML9IswF3mL7R72ighP3dBewQbiIgWaRJdSDPOEjJaL7Ao3+wbpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aveline,

On 11/2/26 13:23, Aveline Noir wrote:
> Hi all,
> 
> On Sun, 01 Nov 2026 19:58:21 +1100 Aveline Noir wrote:
> 
>> Oh, I missed that. I'll try to fix it.
> 
> While working on this, I found that the fix reaches well beyond
> mm/hmm.c and would likely need rework in several subsystems, so I'd
> like to hear your views before going further. v1 shouldn't be applied
> as is.
> 
> amdkfd holds svms->lock and prange->migrate_mutex across
> hmm_range_fault(), and svm_migrate_to_ram() needs both, so it can't
> migrate the page for the validating task. Migrating under those locks
> can deadlock, since do_swap_page() waits for the device page lock, which
> a concurrent CPU fault can hold while waiting for svms->lock.

Yeah those issues are already known.

Because of that AMDs KFD team is in the process of replacing the self made KFD based SVN handling with the drm_gpusvm module which is also used by Intels XE driver.

> From
> reading the code, amdkfd also maps such read-only pages writable today,
> as it takes GPU write permission from the VMA rather than from
> HMM_PFN_WRITE, so GPU writes after fork() would be visible to the child.
> I haven't been able to confirm this on hardware.

That is a new issue as far as I know.

> One option I tried is an opt-in HMM flag that returns -EDEADLK and the
> page address instead of faulting, so amdkfd can drop its locks, fault
> the page and validate again. It works with test_hmm, but the amdkfd
> side grew to about 550 lines across the GPU fault handler, the restore
> worker and svm_range_set_attr(), and is only compile-tested. Read-only
> entries also come from NUMA hinting scans and mprotect(), so pages that
> aren't shared would be moved out of VRAM too, and Xe and nouveau would
> see their pages migrated in the same cases.

I don't think we should try to fix the KFD SVM code, as said we are already in the process of ditching it because of those problems.

> Would you prefer an opt-in interface like this, a change to the amdkfd
> locking so that migrate_to_ram() can run during validation, or
> something else? I can post the amdkfd part as an RFC if that helps.
> 
> I also found a few smaller related issues, and I'll send fixes for them
> separately.

There is also https://gitlab.freedesktop.org/drm/amd/-/work_items/6003 which I'm not sure how to properly handle.

Current AMD GPUs don't have dirty tracking in their GPUVM, so it doesn't really make sense to set the PTE or struct page dirty from the MMU notifier (both data pointers are not around there any more).

We also can't set the page dirty directly after calling hmm_range_fault() because we don't own a page reference and so it could change at any time.

At least for the GFX CS path it would make most sense to set the pages dirty in hmm_range_fault(), not sure about the SVM use case.

Regards,
Christian.

> 
> Thanks,
> Aveline Noir

