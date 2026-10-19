Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43660705F7
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fvuilNl6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2D310E8B5;
	Mon, 19 Oct 2026 15:34:27 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6124C10E8B5;
 Mon, 19 Oct 2026 15:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V33P+NbBPE5t1NVUEgKfdV1MuhbrMqLIDGVXoCZ//nYrB2aEy/Krh5TeGlF4citdW8O5hECT427Ohh9O0lzqnzrGaZWImgj2vWzGWyKYYOpHB4z+p/JrzOxl7d5gmSD7t9+o8JEkZoK+7LDr69rcF7XRPBbuYw49mtyNSLtxXOMtLge0F/bnhj68j0nHuZ5DWgp2A+emxIPWpm5TBc25PDQbM9GTLnrttTt3M2lkaUxNHlFtX+jhVM04/XA36GPRn+zISNdg15KOGzMa0H9izYn9qHutLcv6ZyhncwdmvNRCQcruB1re6/u6/itgoEyNmhSPvDTu6HpiQwVgKz42YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TgGrXvkTLwbS3fxf64vrEIuaSZ86PBv2dE0OvaVd3I=;
 b=Z305zHJTaccbRU7gaq27KyLHv41/3hxjFB+clY/w9gqEpk5uKKGcKO4abcJVVyE54oVqyf5Je+CXmLYP8AFLbqz2tBny0X+zttdg+56crwdhHjhHagIuO2UKyNL5L9MngbslIOqLU7aHlnAS8DB3QBUF0Qa19k2jmzyY5eYbQnvw9i3o1sacdAa8vmqfFuA174kq5cPLV9SYh+Hp3ddejsDqBWFVnF6aEP3E6pB4N5Sm+Hz48BwkjCkM//EPNyc5cPfz9snZ4yzk+rLMJ0Bgo6WxZlQPUdKv+D9rFTMEtzYimD7k6Spz42nVi8mL8jPyFFvXZsC1oJvF6Og2X0aYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TgGrXvkTLwbS3fxf64vrEIuaSZ86PBv2dE0OvaVd3I=;
 b=fvuilNl6/0hweckxuDkHKs5A6n6C1OrXCGDlkKfqRiygmzW/Z5Rhi/mW3nszSnqowUBiD39gmWr7RXonqyexN6IclBASYJ0prjhCHtcxq7KntDOrYFm6hZkkMYYuYgpiyowxQMqtGgpkH/7VEpEu3t+BLxUijqJ+zS3/KIVHnVw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:34:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:34:17 +0000
Message-ID: <9cb67ac3-4de2-4033-8904-eb30ba51a070@amd.com>
Date: Mon, 19 Oct 2026 17:34:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
 <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
 <20261019133031.GQ13920@nvidia.com>
 <5f57c49d34f2812b0b68be71218ce0a9b6510c14.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5f57c49d34f2812b0b68be71218ce0a9b6510c14.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:530::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e1af6f-996c-4eed-8180-08df2df67005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|7416014|6133799003|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CeAD4Yofb5R6TzBtDxLwovmWZ/cd0t6kgcMiHmL7KhRsRGKnTv8L4CoToLzTR2Wij6AGVmHNm+6XP8TA2YpOwZxpf+dGn8z7cLGbknka7ivz+1h7Qbf6I/jNOY+InNUoITqx9QvBJigFl+qcHKBMbzJK3U2UuKc/iNsynMlMgTJOpqo5bI7aZC4DpGPpL7c6Rqim4nsXH6XHH/VLoICSRMC4Cr5S49tGXn0zjicl/zVB3vBPupgpXYXLxr5fWqVbN61nXbhkP4vtSbVk7lkElz/UIJUdF6vScCLDQCT02TbWPXylYKCk0jLD/+75L6cAvb2CR/oCO6/PdipbNMlDjTpOdoyGw/L1wi6Q3woppTdA1AV3IEIXkYJpPDOJMa+ygi+KvL9gILWR/DzJXVdc7u9m/ufNBheBEdzQASixJjyywkADykMMHKuJSoQahzFyDLtvmtqXyrK/+cbCGOp0QIiFGmmlnPkXB2aYFcDOFgveyLkMzvoD1T/CL3de0qlnenIjwApZ2TDhplWmw1RlRJDgDkwsrBD5m+jCPe9tWzHNUUxwR+JQ3OSulwCaj150jtB4mzD/2X36JgUTmOAXim6E0GvA3vcGNtgwvGC2uMtSTZD8Zn8KyldxuqJsDEmxq1LVYUQTZr63xCaU3m7Epe47M/aBj9q2nIwq1UYPGI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNWMGxZaWllN0hmMUFGdHk1ejJCaldtWnhFczJhTldCVXQ0clQwVG1WUXF5?=
 =?utf-8?B?bFNIajdyOU9ma3Z3Nlc3R2NqUlRXSmNrUzBwbHJmcmJ3dkFKa253eEI4dGJs?=
 =?utf-8?B?QnRjQW1GNGhMMHdxRGpVWTdwUWF0RjE5cm13VHZ6QXdCTjl6SkFockdMY29x?=
 =?utf-8?B?d0ZtWVFyMmM3MEw1M3VkRjFHbG1GSFFzemtrNitJdUhDYkFKS0VhNVdPV256?=
 =?utf-8?B?SFdNL041cFl5ZFlOMHFhRzVqSVBySENxaWVxdTdZaUw2MitZRnQzeWl2VHJh?=
 =?utf-8?B?cjJWTlYvK2QzbnhLbFhzMmpRbTRQUVI5dVdNYXVNVC9GdjVueThBRjJZWVF4?=
 =?utf-8?B?STh5ZnVEWFNTeWVxakVmbi9rVGNZeHFoUzcwZElDRGZiTUZHdVV0UzJDSHlJ?=
 =?utf-8?B?ZTY1VFdXNlpwUEZONFB0YXFjRm9ZQ1gxMGxGWnQ3a0RGeEdCZzBvVDZiWFZZ?=
 =?utf-8?B?YTdYWUY4RVMzbmFoYWZ0dVBhSmxDOHppQXgxMzNSOWwvaXgySmFLVkxSWXJN?=
 =?utf-8?B?R2dTTE9OOHNUNlJRM3JJTGUza2RhRmJHenBFKzZpWnNuK1Bab2VnZWlSNERv?=
 =?utf-8?B?RDdramFRZU1PMDgvODgxeHBSQUt5NE5QZUg4ZkFqeldDcGtnUHlxQS9iWkZs?=
 =?utf-8?B?V01aM0pJNCs2TWI5OStId2wyYTJsN01mY2p0bHZLQ1pZZkt1bjZRMGxDYVpI?=
 =?utf-8?B?cDNZMjE1T3BlUGFhK3pWTlF4eDl3N29FU1BPcGVTMFZwOE5RaWM3QVJ5Y2w0?=
 =?utf-8?B?cWJ1UWFHWW9qYkRvWlh0WHRTTzhiOFZ3NWtzOGdiRFV1c1FqYlBybFY3cTJQ?=
 =?utf-8?B?RGJwMUp5NkVFU0N5Uk1OanhZcUw5NXI4a3VLbXFacysvWjlhVDBSMFU2S0w3?=
 =?utf-8?B?cXhHNktqM0FmYVBKN0tmRERSbEl3R2ZicjlpM1NpUFJINFVKZ3hWQWpWRzRH?=
 =?utf-8?B?SGZpOG4wek5pNFZVWkxHaExpd2ZPT3dKZFlYaGpyS2JoYXc0V2xzd0tPUXpR?=
 =?utf-8?B?QlNUSVpaUjNvenRGZUtjZitxY2dRSVA2MjlpUmVDc0hBeWtDc0lobkRsNFBm?=
 =?utf-8?B?RDZ1bWpaY21aSE0rMmxvTjJwbjMyREpMTUwrWVh5Q2t1VmJZVnRtRTBnTUdp?=
 =?utf-8?B?REx0R3FGbGYrQ1FNc2lrYkVTZERRa3luVElXTnNPOFdUSmdhVHEvRjV4MEpy?=
 =?utf-8?B?anEvTTVzQ1lpUmRMcnB0SmE1aDlhMEJGTlZobVBWTVI1SGlRNlJidnpzMXQ5?=
 =?utf-8?B?Y3lNN2x2dzBjdGRPc2U2ZncvZml1MHc5bFhreWx5K0JWVEZVemh6RjhnQi9w?=
 =?utf-8?B?eWdhQ2NtSlV0R3dPV0pkSHlhU3FJZFY5Z3ZLMU0rNFREVUh6OS8zT2syYkNC?=
 =?utf-8?B?bkVIK3hxSjVyaGxDa01kZjNXbEZTZGtNTTFhbWtDOEoyR283M0FQQ0pBVlNK?=
 =?utf-8?B?V3F5YWRCTmsrYUxPNGszdFZPa014M08wMVRONHdPY3EvMmd0V25ncXo1bC9F?=
 =?utf-8?B?KytEZnZ4SXlhOVhPYkVWM0MwQk4yZHZLTFFMYk0zam9WV2g2ZFdrY1ZSWjND?=
 =?utf-8?B?OVd1b2xDa2lTd2tnZEw0cUNGMnRUbk9EUGVFcTJjTDd1Z2NyY2lIZWFTR2VK?=
 =?utf-8?B?ZmxLRUxtaDYxYUFVYkU4NzdqSVp0V1FkdlNadG5Ba2k4OWhKM3lmemFwTk5p?=
 =?utf-8?B?c1dFWW5QQkhYTDRpOWVBS2Zodng2RnBsZDErSG02QXZQcUY0ZkZ5OGZaZFZO?=
 =?utf-8?B?aDdpYWhXQmRSTnc2UWdkT1VxbEZPUkxaZTc4b0RIV1BKdHdYbk5PRkpzcm84?=
 =?utf-8?B?NmtZMXR3dTU0ZmtTdThwditaMVpGSWtlRXZabGRUQzdIQ3c0SndjOGdNNVVC?=
 =?utf-8?B?SGNJV3JYeU1kbU1nSGRuaUg3UWYyV2x3a0Jsbks2c3NUK3pDSGJCZUJuRVJw?=
 =?utf-8?B?cmVtaDQ4WllVK2xibU1QOENQSXpMZVJoRC9SazFjRUJWbnlNL1JMSmZkSkha?=
 =?utf-8?B?RlVybnNxMk1YL3U2Q3B4bTdXSXdiamtMcFNvemxlcSsxL1NSS0lCZDUzWGJa?=
 =?utf-8?B?bU5lR2Jja0N2V2NmM0JscklmdFZLcGtxMUY1U1RxOXpoZGw1TjZ5MkMyTHBL?=
 =?utf-8?B?clF1b2NSb2FiaGViTHUwTWNNV0VZMjJSUUpURk1Fei9UdkZ1SFZvWk54cjFM?=
 =?utf-8?B?UHRTdFgreXlQSjVFV3RacGVJUWdhMXdmY1l2WjhXVXh6LzBXWUxNd1NoMml1?=
 =?utf-8?B?K1RidGJXVUxXMWREUy8zcXB2OHc2a1IybWRoNTZHTUhtU3FrOEcrRzNuSGlC?=
 =?utf-8?Q?e+k4M9rCbUaGHLfpaU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e1af6f-996c-4eed-8180-08df2df67005
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:34:17.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhUbdzPmHafRZLhlxs6f47XYQcqn76XzQtFqs2ihSMdVQ39EhLKC+pEDFbgqiSVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 15:47, Thomas Hellström wrote:
> On Mon, 2026-10-19 at 10:30 -0300, Jason Gunthorpe wrote:
>> On Mon, Oct 19, 2026 at 02:43:29PM +0200, Thomas Hellström wrote:
>>> On Mon, 2026-10-19 at 10:35 +0200, Christian König wrote:
>>>> On 10/16/26 22:26, Karl Mehltretter wrote:
>>>>> On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe
>>>>> wrote:
>>>>>> +	match_args.attach = attach;
>>>>>> +	if (dmabuf->ops->match_mapping) {
>>>>>> +		ret = dmabuf->ops-
>>>>>>> match_mapping(&match_args);
>>>>>> +	}
>>>>>> +
>>>>>>  	attach->dmabuf = dmabuf;
>>>>>>  	attach->importer_ops = importer_ops;
>>>>>>  	attach->importer_priv = importer_priv;
>>>>>
>>>>> I may misunderstand the intended contract. match_mapping() runs
>>>>> while the
>>>>> attachment is still zeroed and without dmabuf->resv held.
>>>>>
>>>>> Patch 11's amdgpu callback needs importer_ops and
>>>>> importer_priv, so
>>>>> its XGMI
>>>>> match cannot work here. Patch 12's VFIO callback asserts
>>>>> dmabuf-
>>>>>> resv and
>>>>> reads priv->vdev, which cleanup changes under that lock.
>>>>>
>>>>> Should the core initialize the attachment and hold dmabuf->resv
>>>>> for
>>>>> match_mapping(), or should callbacks avoid attachment and lock-
>>>>> protected
>>>>> state?
>>>>
>>>> Right. This completely misplaced.
>>>>
>>>> The matching can't be done at attachment time, but rather needs
>>>> to be
>>>> done before creating a mapping while holding the resv lock so
>>>> that
>>>> the matching decision can't change.
>>>
>>> So question is what exactly should the contract be?
>>> Looking at the pcie_p2p negotiation today it looks somewhat like.
>>>
>>> 1) Importer and exporter agree at attach time what mappings are
>>> allowed
>>> pending placement conditions and other attachers.

Not quite. They check if the P2P is in theory possible, but they don't make any decisions on the final placement.

>>> 2) At map-time the mapping is negotiated taking all constraints
>>> into
>>> account.
>>> 3) The negotiated mapping is valid until an invalidate_mappings()
>>> callback is received.
>>>
>>> Following this would allow a re-implementation of pcie_p2p as a
>>> mapping
>>> type and would allow a controlled link-severing to send an
>>> invalidate_mappings() notifier and the mappings to be re-
>>> negotiated.
>>>
>>> Importers requiring an early hint as to what the actual mapping
>>> would
>>> look like would need to be prepared to re-consider at map-time,
>>> with a
>>> reasonable assumption that the reconsideration and re-mapping would
>>> happen seldom enough.
>>
>> The idea was the supported mapping types are fixed properties of the
>> importer and exporter.

That doesn't work quite like this.

>> Like iommufd is not suddenly going to start understanding ualink
>> after
>> an invalidation.
>>
>> Further, I had the (perhaps naive) expectation that the interconnect
>> option was not something that would change during mapping. I did not
>> think you would loose your PCIe option if ualink becomes available,
>> or
>> vice versa. Though on deeper reflection I suppose someone could build
>> HW so you might loose your ualink option if the dmabuf is moved to
>> system memory while PCIe would still work.
> 
> True, but there are other complications. Let's say at map time there is
> another importer that don't support anything but system memory dma-
> bufs. Then both ualink and PCIe p2p could not be used, and we'd fall
> back to system. Or a map() move to VRAM from system for a fast
> interconnect failed for some reason. (Somebody might have pinned it in
> system).

Yes, exactly that.

> But agreed it sounds to me like the interconnect capabilities should be
> fixed at attach time.

We can check preconditions, e.g. if PCI P2P would work with this root complex/isolation setup etc...

>>
>> Making the decision right before map seems like a reasonable
>> enhancement, but I can no longer remember off hand if that would
>> cause
>> complications :)
> 
> It was that mellanox ATS thing, right? That's the only case I heard of
> that needed the mapping type decision (or at least a strong hint)
> early.

Yeah I agree that this is the only one we have heard of, but that doesn't mean we shouldn't at least try to support it somehow.

I mean what we can do is to narrow down the possible placements on attach so that mellanox ATS can at least rule out that P2P is possible early and eventually stop wasting time setting that up.

It can still be that P2P or whatever interconnect fails later on, we have very nice "the fast interconnect has a failure use the slow backup" use cases as well, so importers really won't get away without handling that even if it's slow.

Regards,
Christian.

> 
> /Thomas
> 
> 
>>
>> Jason

