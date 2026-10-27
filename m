Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B43606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oggH1X6d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B5B10F5CB;
	Tue, 27 Oct 2026 14:29:02 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997EC10F5C7;
 Tue, 27 Oct 2026 14:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvS1098xGgtxuKFNljYEcunvXDHeGbTKZlCNXA7kk3iFibBvZGBPF94iH2dRIOZfXUVscApC3lkxafFxDf4loc4KG24sxO6rMlVjHjeLvnwb0WVbQBzB82lJUMa8erJP+TwCDAQzddohv51xonSfn9B/8MP73mKgO0/PtQ0Hq07E0hAqVCIBrtXZph0CMCjNlbvbwwIyJ4nx3sUZFqtxk0e/k0l7yWTKcwc4Hxy7CGahAgC4dvmQADnDLd9j/Jsw2SutSa92vRTqB7CSxHTngSNNHHdoHsKssbaYzv3XGp4Ie2F17tyh4gkFkOO1uskUrZZ3qrBHEJ/XJJPer5cu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0s5ggbh7kqVYkzzWQnKGKbjmpSckG6UuNoEWgWsFDA=;
 b=oTb2WP47YlPB2SMSQN2XIQpPYPjSW/3DF/U8BrK1DZWHHgXXuXHm6GPFHP8Vu8/FZBrmxyGWSzg7ntq9KtyoGHt3LGXeAnEAHiQHZfbNjdhM/dv5RHfZuik6wUAU+DIwK54Szy3cUD4C7EaFJW6vDsNPxt7rVO1sJXFADDTPwlkkwxpAyuNreyDaZ2cKFJPDoies8AL39mnhftInzq961xSw8NOp3bN/5J/glEhcM6wzEN3J1AppL46ARa1VsW3kWts6vhc9GDuaRNPVDeaNn3GMOVRo2iIGu8B131spbFx6csJ094hUQ2ws7aefhfBsVwhkrkXxdtEBB332A9R+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0s5ggbh7kqVYkzzWQnKGKbjmpSckG6UuNoEWgWsFDA=;
 b=oggH1X6dUSIjzc3xIvBizwSW8fs7mmjK610F+pt5c8XXBJGHZq6MwSM3/QEzlbyWGlT34FAS9yhsyGO9OXu0mI8YInBTMkc9Llx7AjzLNVYHiM83jvxI9Pzeqliu4q8X07brb68MYsP3XFBBhAPc09mdX6NhbcQcrZED8e0cneY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:28:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:28:51 +0000
Message-ID: <7193d384-5e28-4f85-8004-1dc9318d5c1c@amd.com>
Date: Tue, 27 Oct 2026 15:28:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/26] treewide: Rename dma_buf_attach() to
 dma_buf_sgt_attach()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 sumit.semwal@linaro.org, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, treding@nvidia.com,
 jhubbard@nvidia.com
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-24-apopple@nvidia.com>
 <27307d58-9ca9-4624-a564-6e35fb4befb5@amd.com>
 <20261027123859.GE1671235@nvidia.com>
 <3a09ef96-45a6-486f-b482-fd34c27415af@amd.com>
 <20261027140831.GA2338330@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261027140831.GA2338330@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 906e6d36-975b-4a41-1e42-08df34369ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|6133799003|18002099003|261026140227099003|56012099006|5023799004|4143699003|11063799006|10067099003|261021121427099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: I65T/2MOCmjWRc3O9jztwZha6yx/JBupsKA4lVWLA6JL+Om3OzPAvjQVHvLc2k2Qfs2PKNAlfK5S5yM/POdKpqwUKahTtccqXzv/HbnLVw54WijNDUbVLywngjgoRQ1dCZNpKgoPj5fc0aVBDuV2ftTpygUzmK87W1AIXzOYMcI4DJ7F/ZKypqxJuNPZajJGXipN2bwGIUeLRobFw8AMIBxpl/PSAaB8WgPSqyR9hoYkKgwtwplTcCGgz9gAK1tpKEQAwkNMDhWOuAX64avK+QGjnhQE9LDrFYEaZKK1Jm0jg9GfspUgYws83JOJcZLFMg0uokonME2697RLmoeVvux4fL/ksFCEF5E5JtLMqwSbXBW3qZHrTXlSyc4iJRqYYrJkoK3qoHqK3A0s8RzZi+gwAZK9e+QGfu+Mtv012vrwEr1ERmo5XFDpL+eA9Hw2Z3U8K3d2Gfx0s6tANX9ArRZOqnjl+t/vcPYn9ZXAb4D80ChOkevQ1fZsnh9NbSFr3jk4iJS42Pe8WcJh8b14KwcN1hfM4Vea8aVsJbMb4r/533H7kyVeBtP1+1t9dTUZewSDYe1riGr7/PqqTWAinX3tUNfG1ukWzJ+hK0IlauBQII5KJnXvBEkOXhex1qPSATmoB5wT3HZMjBmPOJJbHAbiMPUn2CkHPQqaqnR+pds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(6133799003)(18002099003)(261026140227099003)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(261021121427099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWV4aTBJczBCemt3Rll3b2hMYUZuMXJOa0tnL1JqcEtqTVNhSXp6Si8xWU1j?=
 =?utf-8?B?WG5iZjN5cnFOWVU5K3UyL3dMNU5wUXlyR3ExUEtWR2lZZzFobEFHNkk2dUQv?=
 =?utf-8?B?ejhGNU1ySGtSeVBSQVhlSXBWRU5NdG9EbGpsRzR1MmhrY3gvNmlOa1MwTFRz?=
 =?utf-8?B?K2J4V010b2Q1bzY4WHNHUUlEVGN6MnRsUWpBUGV3dXBEWGN3Z1Y4SzR1NzVv?=
 =?utf-8?B?UWRIYnhTcGNtMHNzZmJkTVhpdUZ0WHEwUTZNcXRjTUlFa0EydmdDZ2x1QllG?=
 =?utf-8?B?L1ZsTFBnd09SMzU5SnV6d1pGZnlBT2hhRkVZeGYvK280VU80RHZnYnJSUldG?=
 =?utf-8?B?SEJMQVozRURSQ2xmK0F6S3kxNFk3M214M2I4NENwV2w2enRtU3BEQTVud1Zz?=
 =?utf-8?B?czNJd0xLaXpnbGdEWlE5UjNjQ0lkbDBqcDcwbmRHdGFNVEtIWlFncElEaXJX?=
 =?utf-8?B?aTVYeEJGeEJLdTdPUXc1blY2aUVWZy80T3ZOTFVVTEdRa0NXRFlJTnhFaXF6?=
 =?utf-8?B?emJ6TXlDWTBrUndkUDM3dHlMeTlZZlFaMlBGUWtyb1B5aERubVN4bXdPamZN?=
 =?utf-8?B?MWhyMDIvNytQUW1zQkRyQ3pESldqVEFKbWxUbWNwZ1VlMXRDaHRtUlEzVmhK?=
 =?utf-8?B?MEpESU1rMlJkSmh4SFducHI2clNtTU96TDhvbGZmSW81T2NSclE5cWxTaFNH?=
 =?utf-8?B?UFhJaWU0ZXBmMWd5LzdTUWs0NGFUa3ZOVEtXTGJVcFFkRjNTNm1hUFNxU1FH?=
 =?utf-8?B?TCtNSzNnU0NsVjR3UjFYT1FmVkVxbGVNTEZQYlhMS1d5RGNNYjBqSDMvQmkr?=
 =?utf-8?B?UW93OHhwUEMxNXVUVmQvSXM4NEFSamUyR0RQSHFvR2tTZXBpVUlLMVQvc2E1?=
 =?utf-8?B?RS9yeWJRRTNzaFp0VUU5TStaUXM2ZDg5eVNJd1BnR3VCWnFwc0lGVDd4aklm?=
 =?utf-8?B?MzRka0RwWDduVEZURllvdmdpamxWOUJiQk5rWm5IeWlab04xaVhRaXcrNE5r?=
 =?utf-8?B?bWw1Zi9pSHl0YlBFek0rOCtaZFNXU0poTG1xSVVvcEpncWNuTDJzRWREd1JF?=
 =?utf-8?B?b3FzNVh0UDFicUw5c2V3YkgyckNheHRHbCtjSkhhYWhSMEVjdmxqYTBpcFE5?=
 =?utf-8?B?RTZJT2NkRUtYb2JyWWtFaDRDU2NhcEJORTl3TDFrQ3ZFQU1LcGlxTUtVRUNu?=
 =?utf-8?B?U1BLekM0dVc4WGQyQ1A5NWoxejV2eU1QcXBUU1QrMGpsb2ZPaW9mY1hKZkFC?=
 =?utf-8?B?UldWTDJwa3I1NjdEdnhLd0k5Zy9kWGF6dUFvd2txL1RRalBMRTdxNlkrLzls?=
 =?utf-8?B?T2Q4SGR6bzArRjFZb2M5VTJrRFdNdkd5aTNoZWhYYTZzVHdLL0JWcmV4TFIz?=
 =?utf-8?B?MFFKK2wvOTFsMGcxZ0tNVm1hamNMTHUvV2QvMWFDWi8xell5N0M1L29Gd2Ru?=
 =?utf-8?B?MVJ4MFQ1L091UHFBMVREOFl5cyswQ1pYbzJnNWNtQk4vWDJDdkkybzgzUHdU?=
 =?utf-8?B?OUo4akZwRjFWR01mTERadGFZMzBJdUNVWW0xQUlBaXJIWEYyYy9YUlFlYjU3?=
 =?utf-8?B?bjJkQTNiQnpodjFuUFB6TW9WVkxVOUtTb0RPbkZSNGFwRnpHNTFIOVFkRlU1?=
 =?utf-8?B?Zmh2WE5YYVhwTWRJdSt5QmhhZDhWL2R1RmVBQmxkNlVVZWJXQVVKbDQvZ1lT?=
 =?utf-8?B?UEFiS1lESEdrelZyWlN3RzBjMFZBU3oyQkhmdmc3QUtQOUhuaWUza0grNm12?=
 =?utf-8?B?TTVsYmRpREorK01Id0ZsZjB3bmxudURxMThwU1RocXQ0Q2lwSHVwMTE3SVpH?=
 =?utf-8?B?NXJDd2NWVVo4c3RpTUx2UU1UVTBJOFJKYytITzJUcGR1MWFudVViNmVNWXQv?=
 =?utf-8?B?TW5DQ0lETDkrbkl5MXdSQlZnekZPVTdOQ3E5Q1psOWFTaFZ6WDVkUEJXN3Zn?=
 =?utf-8?B?Q2t3VUIzVlFxeEpRMnl6eDBqaGplbEdqWklNSzJhN1A5QjJqNXhoWEcxUDdY?=
 =?utf-8?B?b1IrUnBBdm5TR042azZXb3RiQWpBallZUDVMWnNtT2ozT2xDM1BFRjVUeHVG?=
 =?utf-8?B?SGpMVWxveUFCc1NCRWpRcEV1WGtCQ2hDRnVjTzV6UG5sbThBY09OQ2Q4TVZq?=
 =?utf-8?B?RzhCLzlLVzZ1Qllpb1AxZFNnTEZhd0d1UVpyMmZWdmszbGtOc2J2T3BWZi94?=
 =?utf-8?B?U3VMNmRyQ0xwK01WK091aHJFM3IzUTIyMTE1UDZNWHcwNmQvbTRyN2NsS3VW?=
 =?utf-8?B?WUEvdVdkNUtja1paUkZFQksvSSttRkNJQ01mN0xROXRyUks2N0VRTy9nR2Vv?=
 =?utf-8?Q?VziHOssc67S1jq/lZg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906e6d36-975b-4a41-1e42-08df34369ef9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:28:51.1215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gH8+G0QTjhwAoELk7ZqOvuIniw7Ge3TmTRcp9HiXWWXRTt394/bkEWyFZuJUs0C3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 15:08, Jason Gunthorpe wrote:
> On Tue, Oct 27, 2026 at 02:17:16PM +0100, Christian König wrote:
>> On 10/27/26 13:38, Jason Gunthorpe wrote:
>>> On Tue, Oct 27, 2026 at 01:07:36PM +0100, Christian König wrote:
>>>> On 10/26/26 06:36, Alistair Popple wrote:
>>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>>>
>>>>> This attach function always creates a SGT mapping type importer.
>>>>
>>>> Yeah that is a clear NO-GO. The attachment should be the same for
>>>> the new interface as well.
>>>
>>> Not sure I understand this comment...
>>>
>>> This was intended as a helper so that existing drivers can run through
>>> the sgt based mapping type flow without having to open code it. It is
>>> hardwired to only do sgt like this. If you want to use more than sgt
>>> as your mapping type don't use this function
>>>
>>> The point was to create a clear distinction in the API names when
>>> things were in a SGT-only flow vs using the newer negotiable flow.
>>
>> Well that is my point, the dma_buf_attach() or rather
>> dynamic_attach() function should still be part of the new flow.
> 
> It is, this is just a helper wrapper effectively to run the flow
> exactly as it is right now wired to only do sgt.
> 
> Unless you want to see that open coded in ever driver using the more
> general functions, I'm not sure I see the alternative?

I still don't see what you mean.

If a driver can only deal with sgt then it won't implement the dma_buf_attach_ops->supported_mapping_types (or whatever we name that).

So if either dma_buf_attach_ops is NULL or dma_buf_attach_ops->supported_mapping_types is NULL then we only match to the sgt export.

What I want to avoid is to get just another dma_buf_attach() variant since we already added a parameter structure here.

Regards,
Christian.

> 
> Jason

