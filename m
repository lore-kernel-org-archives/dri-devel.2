Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BA0FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5367910E3DD;
	Wed, 29 Apr 2026 09:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SnZFkBNc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABA810E3C1;
 Wed, 29 Apr 2026 09:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8gji3TG9c1Kb0a9uA7p6h0/h4Zare2Sii/PT41P9TVfIIk0p3wSjiRM/Erc6H1as9o0VzFt51ykMtZLVmvVpYxAX1HlwoqSYxruupPFEVxaIhgjznecVsWDfYq6E1vdLYZ8mf6QbiTd/DSVnpI8iLJjLiewTH7WnpzVs38ag7ik9W0wn7eve8heIAnWAqa9cIYpVMt+RZXarVoG4coXvDRxFvkSQ84409s/p1LkqSOEtKU8UzCiJkxJK5ocZ6wU0YE1RCnh76l6tm+BCPB7M/Pz5CdlQGT3uKLbPfwQYPUI29NMKlDT+kuiJlMIGEywHIdC3cQHkgFYFyPa+7vccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z+LA0eMFHBdqmBVxO3mCdC7TPIAje98Vb0pGS6iGM8=;
 b=wFchY/qFS8tvBFsZHNK11jjd6K9Ro/V33XBAfvvMcatWUvR8utN/QXgdM/N24gVCr54rd08APqz46hrLjYdnnFk54261WAGQHsomWZmPHg0FiujRLzwKFIjVISpGiftNPC3JE3/WApO7T6B2QPZMRO2JClZrNBCuN//5H20tZ0Wl8IzgugOf6QR2HFHaCnbfTRNE3+vGsMGVU0Q157edpgSu1GRqFpxMIv/hzVnHnjEOwP2u0B835/3s6LM91PLEfftB7WDh/nCQ4cg04b8uUeqd0K4o02glaeiy5OF9j7YT+OGKeALnBStHIDmxprr0S+rtOUCDC7glTf974JOb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z+LA0eMFHBdqmBVxO3mCdC7TPIAje98Vb0pGS6iGM8=;
 b=SnZFkBNcFsntGcMe5kZVkx75DXlmtUiSJrO58kiWmu3ItnG89ANQ2B2GRhqqVkmYKP/rWVnHyJnddpKD2fgeIY4B9vL7qraRaiUUkPAkMmPjh3zJeMqDaTKHoCFN5KKZFloxP+FyCBqq/mE8gLkoTJy1kLzc5e/+05993eYAoFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:56:38 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 09:56:37 +0000
Message-ID: <5e44f013-a1c1-4621-9eea-e4f2459f223e@amd.com>
Date: Wed, 29 Apr 2026 17:56:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
From: "Huang, Honglei1" <honghuan@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Honglei Huang <honglei1.huang@amd.com>,
 Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
 <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
 <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
 <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
 <a9d979e7-6ff1-47c5-87c5-b905e5c84ded@amd.com>
 <aenBy61U66DkSZUl@gsse-cloud1.jf.intel.com>
 <7a1ba278-1201-4585-b35b-3fb2cec6035f@amd.com>
Content-Language: en-US
In-Reply-To: <7a1ba278-1201-4585-b35b-3fb2cec6035f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:d10:31::7) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad1b0bb-ac71-450a-01d3-08dea5d59aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: /MxvW2vE9VxZBPGOybEftjhbDHmLwGvuUl/UL1G1L3BCKxzhVJHcEwfQEnRkwnHSmgF4kWGTlTeoe5p3JUm7sMKAIPVq0kV0G4LlUI88Oya6GQ4z7yy3nZyOnIFFLYCCAHS/vQ0rFePPQRnBwjyBdAPO3JBbNXW56TAfRbaGtNnYH5k4cG4g6TfnE0+fSvRiJel9AHkzy5i3uxzdHZ9QaZZ2kfkuL9pCNyR1LESCOyqO2KE8tEw4nwu6opCQ8cys6CC2R/CHXX7iQqgry6DF1HDo0LpzHC1tHajY4eDmna4R1xfBkXg8YdHaO9LEfqtJQzbInfThpwMQsPGJesCt9+a8tDGQSYCLmQG4L8a04gbD5NufAmnu6163aBNrusAxLy9axoyD/YEeVlMNYpMQ8Mc8l7vitO9TRK97jRW2IxrRIWXuDIkPAUAlcKxjBgZTLqrd8AnRVlfCKB4/T9l5iTXRdMZ6SGfy6zZWULkASLcAFaqTlnkVmcI8jGmJYLXfrZHsCGGS4Au09kO6edjM6fq4rcKUHdubclSt6v0Poto/ucnUrOxDG8W6qS8JZZ/KuS5LOFWpsn7bJ3ehrckavfsthvQtGeGlp2+giRUbcNoUck6L3O9moJJB4IgrRlUsiY35ObBMFaMp+Zov4r/5qi3LNt+Q3Bqx3GP5ePTtpCMCR/t5hd73r81eMdswRCSk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhIbzNYcHBYaThmNW9uNlZSNEFGRlZsaGNEZmJmaFBYNkhSbXROMkdrTFc2?=
 =?utf-8?B?STdYb2ZjVkZkUVc5MEQvVEVoNFp6R2tNR0lWWGxyY1RoODRYc3Q0T2NQcXpS?=
 =?utf-8?B?ZWM5ZVFzaXd5Z1NJZWpOb0VBSkxzRnhZOFdTcVFHN3UrZ3dSMzZBOTlxaytG?=
 =?utf-8?B?dDUyRW15SCtpRXR1eTJESGFPUkdDQkJjR2lqSHRCMUxuYm9LYmpld0tQTVFS?=
 =?utf-8?B?cEJmcnBWdGoyWVdCcTF1TzNGQnFKWTV6T2pUeTh4Y1kycVo2b1F3VmNIajdY?=
 =?utf-8?B?NW5QMUZSUGRPQnlGTStsNmx1THFPNWFjUm5BcWd3WVNaMHRRVTlPRjVDMTA1?=
 =?utf-8?B?MmVkZ2U4TVRHcWxkRmd0aEZPYzhZUUhhTTFoSWMxNm1JdC84N0JOMlVNRTFi?=
 =?utf-8?B?c0wxT0kvcE9PM00wY2FpZ3RVb0tGTnUyaFNyeUlQWUxyOG44MzI1ZEZIOGhU?=
 =?utf-8?B?N2Rva0loTHNZQXNaMXd0N0tyRWorNlBHSjdRQmYvUWhqY3dYMFlRenJ0enFw?=
 =?utf-8?B?cStQM2JXQm9mK2RUbkFOcnRLUTJjbjhORXhPbjlMaTdkVjkreWZ1ZGh5VFJn?=
 =?utf-8?B?cDdJdFppUGIvYndieEk3eFg1OHZiMWsxNVk2U01kS2dGOFZyZ295NHdKUlh2?=
 =?utf-8?B?eWphcHN4UENLdGRCYlMreDh3UHEwRktlTGZ0MnZiYXE4L3VUSXI2VjlKM3F3?=
 =?utf-8?B?N05iNzBNeEJ0ZzM2OTNncDR1aTFDSzhpamhGM3YrM2hIVlVQZ2hHQ0FWbE1o?=
 =?utf-8?B?ekh3ejN0NHdCR3kwYXNRQ2pRSXQ3SnErVjk0Tzh3WndWemJVa2l5cVdJY3gz?=
 =?utf-8?B?WGF0ZWMyRXR4cSs2OXRuYlM3SERUOUpVQks1Z0dtTzBoMlorNFR5MWtvMStD?=
 =?utf-8?B?NEEzeWVuVzRwb2JMczlaLzRLR2NFRytudVJmZCtZT3l2eTJkdFZpRElza0tT?=
 =?utf-8?B?aXNlLzBSeG9yYUdkZ2JTMTk5QTN1MDNOOUwzTXcxM0hPZll6RlVMWkIyQmY3?=
 =?utf-8?B?RGtGb0lTVWdJQkRrazUvcVJiVEZHUlU3TFp5dmpvWkNYVVVYNnA2dlFQYmdT?=
 =?utf-8?B?UDVtMzRiRmhOYzdJbVF1NUJqamR2OFJoZ01qN3JiekxYT2xLRVV2eWNNY252?=
 =?utf-8?B?cisrMjREcjF5S1VqS1QySCs3bTlvYU5GaCtDYlhSenBQaVdIWE80d21POVRO?=
 =?utf-8?B?Mks0NnVWL2hYZEliQS9zQXNHanRUUnJIQjlpTGRWTmVRWEVKaGNwaCtXMXBt?=
 =?utf-8?B?eEc1Wi9SQmlpS2NKS1UzR25tMFhRNnlvaGVndTMxZk51MjBzaTB0aDVuTHJH?=
 =?utf-8?B?cTNZc2tnZjA4WHhjSUtudWdhTkZIQ0VqR1NMcElXUU11THAwQWxZMzAvckVP?=
 =?utf-8?B?OERTc1Q1ZU9hR0MxcmJLODR0WHkvOWRVa2l6SnZ0ekdIcHNwRnlLTkRIb2o5?=
 =?utf-8?B?Q0p2N1gvRUU4SHpIWnB5MjR4SFYyeVpWYTNJWS9DNmRrMEZmVENsYkFrL1JR?=
 =?utf-8?B?a0hReVFTV3VneWZ4WUZwZytPcStEWnVqdFl0cDQweUttMmtqLzZSeFBTaDd0?=
 =?utf-8?B?R0w2TmpiZEx5a25oOXE2LzdndzVkY21FcHY5RVUzeGZMdUh3VmUrN3AvaXFQ?=
 =?utf-8?B?VUJ0a3hwZEowWU5PWVJNV2lRK3dLRTgvaDNxUS9QR252K0ZsVzJSWDR3ZWhS?=
 =?utf-8?B?aWFWbzdiM2ZjL2R3b21ueTlKNUFPbnRubHBSTEd3VFFvM2NPQlJjaWhIRUx5?=
 =?utf-8?B?S1JTanZhWTdGd3BzM2pqMFo1cGxZelBsalJrZlVITlZRRjRYTGVXUld1bVJt?=
 =?utf-8?B?M2FCa0dPQzBSOHRabjA3anhWeXpXK1g4bmxZRWMrZUhDYTFlaC8wRUk4Q0JX?=
 =?utf-8?B?NWc0ZERweW5iV21GcXhxQVhIa0hjeFhmWmVPNTQranhkZjFvSUlMZlFxTndw?=
 =?utf-8?B?ZlF4Y0NQNWFtQy85cDdvRXlaeXRhYk05bVZnU0laUTZZb203OW01eS9BZlN5?=
 =?utf-8?B?NDc1TnRaKzU0ejQySW5sOXNweTBtN1ZmazRCOFIvdFRmYkpYUDZuZFBQcXRn?=
 =?utf-8?B?R2hYL1V0a0lacEtCeGhmeUhiQmoyYTg1YlNoamlqVXlET1BaQjRsVFI4YklN?=
 =?utf-8?B?eXpGRlAyQW1NMXBCM21kSElhRFc5VXJhSG40OGR1UEhWYTkvNDRZM1JkU0d4?=
 =?utf-8?B?ZXh1QXBrdnhVcTBXaXowb1JtekJ5RDVmaEMyTWNBY0VKYnA1Vm9HY2JnTG5p?=
 =?utf-8?B?ZWN5dEJRMml1ZSsrdVpqc2gwUVg1QXZHTElRb0c4WXE0L09nNm8yRGNHcms2?=
 =?utf-8?Q?ov7ufSynddVAosywLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad1b0bb-ac71-450a-01d3-08dea5d59aa6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:56:37.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRWLbdrXbjZox62l/vx/Dqrdjd3Lu7Bjczu0VaFESHWLWC8qw3RaJgPvmS8XrlplLyFcJQ41gRF4XGTwYVboGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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



On 4/23/2026 4:22 PM, Huang, Honglei1 wrote:
...
>>>>>>>>>
>>>>>>>>> This patch series implements basic SVM support with the 
>>>>>>>>> following features:
>>>>>>>>>
>>>>>>>>>       1. attributes sepatarated from physical page management:
>>>>>>>>>
>>>>>>>>>         - Attribute layer (amdgpu_svm_attr_tree): a driver side 
>>>>>>>>> interval
>>>>>>>>>           tree that stores SVM attributes. Managed through the 
>>>>>>>>> SET_ATTR,
>>>>>>>>>           and mmu notifier callback.
>>>>>>
>>>>>> Can you explain the mmu notifier callback interaction here? See 
>>>>>> below in
>>>>>> Xe the attribute tree is existing VMA tree (gpuvm).
>>>>>>
>>>>>
>>>>> Let me try to explain, apologies if the description is not fully
>>>>> precise.
>>>>>
>>>>> In current implementation, the MMU notifier callback interacts with 
>>>>> the attr
>>>>> tree only in the munmap path remove the corresponding attribute
>>>>> entries from the attr tree so that stale attributes do not persist for
>>>>> freed address space.
>>>>>
>>>>
>>>> Ah, yes. We reset our attributes upon munmap too. We actually don't 
>>>> this
>>>> 100% correct quite either and series in flight to fix [1].
>>>>
>>>> [1] https://patchwork.freedesktop.org/series/161815/
>>>
>>> Hi matt,
>>>
>>> It seems like you are tring to modify the implementation into remove the
>>> attributes when munmap.
>>>
>>> Actuall we have a discussion internally that does the driver need to 
>>> remove
>>> the attributes when munmap.
>>>
>>> So there servel ideas:
>>>
>>> 1. attribute need keep: attributes may be needed again when a new VMA
>>> appears or on subsequent faults.
>>> 2.attribute need keep: attributes can be set independent of whether 
>>> memory
>>> is currently mapped; attributes persist and are modified explicitly via
>>> ioctl, not implicitly by notifier callbacks.
>>> 3. attribute need remove: casue VMA is gone, driver can do nothing 
>>> without
>>> VMA.
>>>
>>> and I saw xe_svm set default attribute in the previous version, this 
>>> is also
>>> a option.
>>>
>>> Can you please help to give some information that why xe_svm is 
>>> turing to
>>> remove the attribute when munmap? And does keeping attribute is a 
>>> valid way?
>>>
>>
>> This is a semantic choice, and we’re trying to match the semantics of
>> CPU madvise. I believe any semantic an individual driver stack wants to
>> define is valid, but if vendors mismatch sematics this will create a
>> level of vendor lock in which may (cough Nvidia, CUDA) or may not (open
>> source) be desired.
>>
>> AFAIK, if you do something like this in C (a CPU-only program):
>>
>> mmap(addr_range);
>> madvise(addr_range, some_flags);
>> munmap(addr_range);
>>
>> mmap(addr_range); /* Here the madvise attributes are reset */
>>
>> Also, AFAIK, the CUDA GPU madvise API works this way as well.
>>
>> That said, making this work 100% reliably is quite difficult, especially
>> with a rude user.
>>
>> For example:
>>
>> mmap(addr_range);
>> gpu_madvise(addr_range, some_flags);
>> /* GPU never actually touches memory */
>> munmap(addr_range);
>>
>> So we have an opt-in VM bind flag,
>> DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET, which we’re working on to mostly
>> handle the “rude” case above. Maybe we can reach 100% correctness, but
>> again, this is a difficult problem is WIP.
>>
> 
> I think the current amdgpu SVM draft version also has the issue for the 
> rude user situlation. Maybe this is caused by the separation of 
> attribute layer and physical layer. Seems like KFD_SVM doesn't have this 
> issue.
> 
> Maybe driver can find_or_insert in madvise ioctl path, to add a MMU 
> notifier but do not to get_page, and then clean the attribyte in mmu 
> notifier callback instead of GC. This is just my thought.
> 
> And really thanks for the information, and waiting for other's comments.
> 

Hi Matt,

I'd like to share a concrete bug we hit in the amdgpu SVM 
implementation/tests about stale attributes.

In short it is stale attr_range overlaps with VM_PFNMAP VMA

1: User allocates memory and sets GPU attributes but never use/fault it.

    CPU VMA (anonymous):
    |<── 0x1000 ── 0x5000 ──>|

    attr_range:
    |<── 0x1000 ── 0x5000 ──>|

2: User munmaps the region, attr_range is NOT cleaned up

    CPU VMA: (gone)

    attr_range:           stale
    |<── 0x1000 ── 0x5000  ─>|

    No gpusvm_range existed, No MMU notifier, No GC, No cleanup


3: User mmaps new memory for device pfn remap  partially overlapping the 
old range,
and new memory for GPU set attribute


    CPU VMAs:
    |<── 0x1000 ── 0x2000 ──>|<── 0x2000 ── 0x4000 ──>|
    |   VM_PFNMAP                  |   anonymous (new alloc)      |

    attr_range:              STILL STALE
    |<────── 0x1000 ─── 0x5000 ─────────────>|


4: GPU faults at address 0x3000

    Fault handler finds the stale attr_range [0x1000, 0x5000):
      gpuva_start = 0x1000  (from stale attr_range)
      gpuva_end   = 0x5000  (from stale attr_range)

    drm_gpusvm_range_chunk_size()  find the  chunk: 0x0000-0x5000 cover 
the VM_PFNMAP area

    |<── 0x1000 ── 0x2000 ──>|<── 0x2000 ──── 0x4000 ───>|
    |   VM_PFNMAP                  |                                    |
     hmm_range_fault fails
     or vma check:
     VM_PFNMAP -> -EOPNOTSUPP

I think it is caused by of the stale attribute.
Or is this considered as an invalid userspace behavior?

Regards,
Honglei

> Regards,
> Honglei
> 
> 
>> Matt
>>
>>>
>>> Regards,
>>> Honglei...
