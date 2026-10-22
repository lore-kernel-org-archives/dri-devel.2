Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B586606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hNXvjwHN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3468112629;
	Thu, 22 Oct 2026 13:30:28 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59179112624;
 Thu, 22 Oct 2026 13:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN2VY7+JKp3yCbk4ejPHhpHavPP1E003oeOJ8dMW6lAZDkUIk4YKTkNtREbssoijPl41+sMZiW/HF+0ZQnvCTmTV+izRwsoC4UW/Uns6KIXRPb/+e5JDePk8DAO2eD8G0DiRXvw0gi24eWpUlbX+kVc3xnsW1lqYv6KDAqANcBizFlPouyUHExn6COwJmJNT4AbTojTlwZa53yRemgtA1vqoGfAhZy1105iWbFHnlsmYwiQnBR1QoG0KlI0HReyzn4HfYw835hHCl7sBiG/8cP7ke/CGRpvXYWYHmFtv1jKPDLEQ7m+waDWjCxmpqTo198ixSjTv7huEMaya7sHcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTcl00j1OPpmyqOqO/eot6rKBqByxj2eXdhEQBe7icE=;
 b=syF74JJMvuYjGpkm4mp0/0CPMK6GqytiymO/fZSlFx2ji5JSTzgFiIdGNsdn8hvNxaXMIg47izfyNunr7FV9mkP3+1zZCK+eu8oUFeb7ahIY+TVmNnQHqB6NGurDD9smJ98Qm8264BqpFPu2/Praq3Ml9el58az4UBy3/XZ7KpBAwxSwqgt3PplZVP/qQFnGt3Bxw0k5cwuUsPxQOQnpeYiOD7PJnOPqwH9+11wao66sYNNVSdcacw7jvzE2q9D/GeT6HEXaZzS/lET3w7HUpKy26ZnJ/wUCESxIKKrs6l76PivJ9NNCDgZSoZ1L26O35eULzaq5JpTyg0gyBbvS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTcl00j1OPpmyqOqO/eot6rKBqByxj2eXdhEQBe7icE=;
 b=hNXvjwHND7VCT8TOKlV5Ud0RoW8NzX5F6Ybrr40opPj8AtOp+Z85vtfCwNR9dOLV1Cwnp88nDEsx85hnv+mdad0qTdyVUZEZ6/zNB0df6UqAnlKBwkwyz7YT/t80FoSfwhJGSElSCqIf7bMRxI1wknSdTP/mpMzN7jT9XYb7aqs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 13:30:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 13:30:17 +0000
Message-ID: <7b4dc988-5dbd-40e4-b17a-47b6eaf4bf81@amd.com>
Date: Thu, 22 Oct 2026 15:30:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
To: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com> <atmurtZOhKwwGjV3@nvdebian.thelocal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <atmurtZOhKwwGjV3@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 73190f50-df86-49bc-6e3f-08df30409c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|11063799006|261021121427099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: nRHzcom1AZbaAyuyCDaRt6lw8Y72XZxEWXGEXvIY220iwZgUcx4ZW3OG1tpdi1Ry1xXvIvglQY38Rwx+X5ZXG6OVc1l8c5SNODcCWzZb1CD4zPEd2wszfU0uOjf6IGLy86el5dfExxrSz1dlHoFf/roq9r4w1kzkf6hL23E6/VbLBlH76gGhAWOa+5z8VRYHDrKJ2pExv5Yo/+LTmDJQPW7mMl930PvHQU+cFrjyI/DCOOcVwEBzl1t0aLHzMFxd1nbZL756pvYoMJivzUJK4mk+i/HWYCldmgJ18ZdTKaG8VDpQ8dofbMV2+yJsMiz6nRz644lC9p+5DQfi+SWU0ZVz5lCtpJDEgnZ9c99FkL3BvFHcs4mFDNWUuE20NbPSZL2Stt3hZ9e86JPetHxp1r/Sr84e4o9q7Frp3qvbXWWfEGpMqPv3SB655dfL8RKOpre//gge/ovnrFkdYtt+ZJEZ6SSOsFNGif0ceMQoVcNQ4BFIpyi4Od2J8wybxe9hh7pIItKeQubF+hlPNzRxe2DeRFBKG9ZGIhrITNyYDTyB1OuppfZJv1IR7KxxezqXHtOdmC2UFsKNzmEeFsU3Sd4pIqaTaTp1bN5OoZ62N8ePrFcoPc69DJ/5z0l29a/T9rsM/OsyXov0zbnGGD/1KbzCdFvDIeavddMpccYpJBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?USttTFpzUmJlejI0SXF5azQyWm9WQTNrKzhhUTlkZEpNQXZpMHljc0ZraUtH?=
 =?utf-8?B?cXUzeElxQllXbllnUWgyalJjYXV4UlFiK2FSSldqOTN0QjB2b0J2a3FWMFBl?=
 =?utf-8?B?MDR6VnpqN05wWWtNbEY1STlzOVpYZUQxWjR4cEdQRkozS1J3L0FoRWtFV2NF?=
 =?utf-8?B?QVY2VDRNMFNxU2NPc084ZUNWS2lQUVdMTmlOOHc2TGxOYU1pWHU1dS91aC9V?=
 =?utf-8?B?Szk5WTJLZ3BSSTcxOWlJREV5emlsbnNVdVVnQlFTOGdpS3BZbFFDNU1VZFcz?=
 =?utf-8?B?eTZKQVVyYi9TYWR2RlVmSHdueGQ1UFJ6K0x0Z3BiSUxtS1RZMHZNeCtsUTZm?=
 =?utf-8?B?Z1NkOVNGSUtvRGZmYTlKRzNWNmdHQnRoSmFlcTNWOGl6TFhZTEJHY3c5L1hN?=
 =?utf-8?B?TlFQSlJKTEw0aCs1Z0xwNkhxWFY4QUdQMDZCT2FNT3BQeG52NDlRRGw3R3BQ?=
 =?utf-8?B?VkNUd05jWWpBNWNFaEF4dVRMY2p3UzdiTnpoV2lMNkhrcmxHQUNRYURnK2Ja?=
 =?utf-8?B?d1A5c1MzaG1rTUpKWWhNc253L3ZKUE01em5GOTJGOXRlMGdZQ1RQTm8vTGtW?=
 =?utf-8?B?OHNyUjg5eXFHY0k3N3I5dU4rZzh1V2VyN0VJME12cU5GTDh5M1k0NDMrUHNQ?=
 =?utf-8?B?bUliVFhheVphRG9vdXRQWWtQQUg3cVprRmZCTVk5VHZSZmhZRFpoVXd3UEN4?=
 =?utf-8?B?QTJjODBKcWdDVXZHb3R2eGtMQ2JONXNudVhIWlVWbC9UVjM2UnJOd0Y2VDhE?=
 =?utf-8?B?NkkxdWNKanVzdncrYTdVYkhqbmNTWk5KZ3VUVUh3TDgzQUQ1a29UNTlGOVpR?=
 =?utf-8?B?VGc3UXZVeWRBZTY2Qkd2ZkNlOHpkSEdIOUhqUHpNSVllVXAvY1UyTDJlWmhQ?=
 =?utf-8?B?S0FwUVNoYytjNXJPS3YwdGNuRjRUV202SFRFSXVwUk50L2RMYk9na0U4cnA0?=
 =?utf-8?B?YkZRUW54T3lRR3RVWTJ4eTJ4Wnkvek9DWFRNa1JOMStwTEo4M2M1NWlXTGZM?=
 =?utf-8?B?eEttc1BFZEpOeDErMlNoZ1M3eTZ1bHBPVURaVkluRTJHdDFqa3hqeHEvV01U?=
 =?utf-8?B?MUVCY2U3aGNWUnROTUxJOENqOG9OSUV0SDVDeUZJblBSQ0tYNXpVdGxDZ0Zm?=
 =?utf-8?B?ZXJvdmxhWXFhb0hZeTd1YmpTTVJ5YUQ4RnJiZk1ybDlIWjRERHZTQzI0a0ZP?=
 =?utf-8?B?UVFiM1NzcHdaOXdGSnlDS3htdXFwZE9KZ0pubmJMM3BmSU1jcktNQllob3p2?=
 =?utf-8?B?QTkzQm9JL1hwZ21hNU1YWGdYN1h5aEM3cEhLUDE0R3UyOEFscUxTMU5yNzhy?=
 =?utf-8?B?WFdOTjY0dXdyK0hnRDR2WmZsMlFpQUVHMkVPR280RDJvNDRFU2lyTlZwVzFs?=
 =?utf-8?B?VWcyNVdoazl6VzJlVUxHemVsb3IvSGlPMTBmNUt2NHRSZ0xZSUJQY0xHOUE4?=
 =?utf-8?B?aU1reFJKQStaODZ6ZzRSbFlNZHpRTS9ubVlOK0hNN24rY3pNUUlhKzBDa1cv?=
 =?utf-8?B?RFhTdVBBTS84MnBmWjF6amhhZlMwR21DNVFaYnBpSnR0THNLd3UrV0xCUkdm?=
 =?utf-8?B?UGJDdnhkNkUrdG85bmxQT3dKbzMweUZZLzBLOWdTa1Z3TGZuNmNMUERMa29t?=
 =?utf-8?B?QjI1WllacXQrNURidzRUSU11cUVQNkw4L0UvYjBOWlA0TDZqZUFXWmYvZHVR?=
 =?utf-8?B?UXZ2RzEyNUZ4cmFVZ2czT2JlcTJPYkw3NGw4M0hZa0l2QmZEci8xaW0vQ3lN?=
 =?utf-8?B?NDQvWFNqOTducm9RUDBBVHZ3VTlvUU1WWWVEc1FzSUNnK1hJVTBQalFyNTFM?=
 =?utf-8?B?dzJyY3VtUDFYZ2xWemJxVmtJTitsSnh5bTFjMk1IUjBERk5rajVnQkdKbHlN?=
 =?utf-8?B?bTRVUDc5b0YraitXbGFXVWJOcUJGVmVOMTNzdndmNjBTalkwWFFHUzJLT2h3?=
 =?utf-8?B?RUUvd2o1U01QTkV5cUl6TVFBN2FlemY4dEFhV3hnSDlrSGNTTkFRcnNwM0Fs?=
 =?utf-8?B?Qk9WbWFoUndhd1M2L0NSS09VWWJvTWV0SHpiMkFqcEpxaHc5QS9hS1VVdUJu?=
 =?utf-8?B?UGdGdFphYVhEa2hRTUxsNGVNZldmVjUzU0U1ZG4vU1Z5Z2p5cWhnZzZvbjNV?=
 =?utf-8?B?a05GK0lKVkZMajJTa1NpL3V4VDdsamNvRVlWOXd2Zm9hMnFvMEJsMjd3MXV5?=
 =?utf-8?B?MmkrdGdLTzhWSnpGaVhPMC9URzJ0U09pNVJYbXlIaGJtR1d2WG5QKzAzODVx?=
 =?utf-8?B?ZGoyc3RFTG5wdUg4SDZROWtnTWNDRmRRSzNiTkEvUWpkbjZjUy9jdlNmS1FO?=
 =?utf-8?Q?XyIrJK9fnfdR4fF1fx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73190f50-df86-49bc-6e3f-08df30409c60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:30:17.6000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: if7RAX/syMIplZuaxOBa8fzCmVEpdY9Zk5qkNEQfpdvFfmbldYQZ2cgItPnH8UVb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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

On 10/22/26 08:52, Alistair Popple wrote:
> On 2026-10-21 at 23:37 +1100, Jason Gunthorpe <jgg@nvidia.com> wrote...
>> On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellström wrote:
>>>> struct dma_buf_mapping_exp_ops
>>>>    Base type for the per-mapping type exporter provided functions.
>>>> This
>>>>    would be the map/unmap callbacks. Each mapping type can provide
>>>> its own
>>>>    functions for map/unmap type operations with optimal type
>>>> signatures.
>>>
>>> Does it make sense to try to land this patch first, plus a conversion
>>> of pcie_p2p so we could agree on what the contract should look like?
>>
>> I think it would be good to focus on this patch as the main 'crux' of
>> the series. The API contract is the main agreement. I'm relucant to
>> merge code that has no users, so it woudl be ebtter to go up to at
>> least through SGT.
>>  
>>> s/mapping/interconnect/? My gut feeling is that "interconnect" best
>>> describes what's typically going on, but "mapping" perhaps better
>>> describes all cases.
>>
>> My intention was to cover more than just the phyiscal transport. We do
>> really want to get away from scatterlist, so having PCIe map with
>> scatterlist and PCIe map with <something else> still ends up with two
>> mapping types in the system.
>>
>> This is why I choose the name over interconnect.
>>
>>> Location of common protocols which typically carry cross-subsystem
>>> dependencies?
>>> drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
>>
>> I'd encourage people to design more like PCI where the actual
>> *interconnect* has its own home and there is just some minor call outs
>> from dmabuf to help the matching logic.
>>
>>> As discussed previously: 
>>> Agree on theoretically possible matches at attach time, Match at
>>> mapping time and guarantee the match is valid until
>>> invalidate_mappings().
>>
>> I was thinking about this some more, and I'm less sure now.
>>
>> If I think about mlx5, in a multi-path PCIe configuration, it can move
>> the translation around within a single PCIe path, but it cannot move
>> it to another path without creating disruption for the
>> application. This is a HW limitation in how the internal routing
>> works..
>>
>> I strongly suspect this will be the norm for any hardware that doesn't
>> rely on decorated page tables to select the IO path..
>>
>> So, while I agree we should support hardware that can fully change the
>> path on each and every map, we also need to suport hardware that must
>> pin the path during attach.
>>
>> Probably this points to needing a 'pin' operation for the mapping
>> selection after attach.
> 
> If I'm understanding things correctly we're expecting a change in path between
> attach and map time to be rare in practice. Therefore the need to handle this
> case is mostly as a fallback to not break things. So instead of pinning could
> new attachments just invalidate all existing incompatible attachments on the
> list by setting eg. attach->valid = 0?

No, that would result in ping/pong behavior which is something we explicitly try to avoid.

This is also not something uncommon, it happens multiple times a second on a standard X11 Linux desktop when a new buffer is started to be scanned out on an A+A or A+I laptop.

Regards,
Christian.

> 
> Attachment could also scan existing attachments to preferentially pick matching
> mapping_types that are compatible with existing attachments, thus avoiding
> invalidation where possible.
> 
> Map time functions (eg. dma_buf_sgt_map_attachment) would check attach->valid
> and return a failure if a subsequent attachment/event had invalidated the
> mapping type.
> 
> Importers with invalidated attachments would then have to retry creating the
> attachment, probably getting a different mapping_type. Would this be acceptable?
> Or do some importers absolutely require the mapping_type to never change once
> the intial match/attachment has happened?
> 
>  - Alistair
> 
>>>> +/*
>>>> + * Match items are generated by the importer using the
>>>> DMA_BUF_IMAPPING_*() and
>>>> + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
>>>> mapping type
>>>> + * defines its own signature with its own data to make the match and
>>>> attachment.
>>>> + */
>>>> +struct dma_buf_mapping_match {
>>>> +	const struct dma_buf_mapping_type *type;
>>>> +	const struct dma_buf_mapping_exp_ops *exp_ops;
>>>> +	union {
>>>> +		/* Each mapping_type has unique match parameters
>>>> here */
>>>> +	};
>>>
>>> Do we really need to add all global mapping types here? Then we'd need
>>> something for driver-private mapping types as well.
>>
>> IIRC it is fixed size up front like this because of how the
>> structure's memory is managed in this design..
>>
>> If you want a driver private thing then I'd add a 'u64
>> driver_private[2]' to the union and the driver can cast over it.
>>
>> But this is the kernel, if you want to add an xe_mapping_type, then
>> just add it. I don't know we need to do driver private things.
>>
>> Jason

