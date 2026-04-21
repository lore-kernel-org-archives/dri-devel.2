Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D62AF327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10BC10EBB3;
	Tue, 21 Apr 2026 07:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r8NFZiqu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713BF10EB9C;
 Tue, 21 Apr 2026 07:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0kev6zPxG9pYCULv94JqAui74T7jh/BDcIURgGtEeBPG/2subHvrLz7/Nzu9cz/jSKgfLLlpBRMzk9Vq0mHtfFxhPwRCREytG1U0aqswU0rD0ShBy9fYVDPZZfR/q7rQNPBwYZIXR9Qh/x+Ai9IirVeYPugzCM4ixNH3BqPshHtdGsZbNj/Mgn2oOv1cKEn92AC0mmLmGLhVwswLwCpsveLDHmqYg3KgPpESU6B+5tU2rQl20vqVBHJdal5WFGjp6iBGGdesLwQs8KVwRg6DZDgd1b/6QQA2WTjghbOR5E9FPXPnT+A0Iolzse8JTjZzob7aHSrazL0iw6H0dI+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CarXnG3nSfkX+ngL5r3+h4CnY0UXCQibxXkYoc78fRw=;
 b=JgrdxsVxx5moT+0cNmI1qC3TUVGScZ0QR5ddHv0r/BZauc1RtSbtD/6yQ+R0j2CwTP7XF7zvuSIn4e56Zj7PyXN8ki6JwLp0SsRl6xdkJZ2lma3v8p7bxE9SZEk1lhWV9bw1Gp2cGaTCMDQxhyasPEtrxepeT3d2Rfo+FJ9oURQQ66HIfS1VX5DvomGNk3HlxEwzjAv2pzGe91seyWgLwTl+A5WyIdH+SighfqBZgMRh7UgByIlqAoYqwUOHo2QvEjVDzOI50O2ZRPXUbv456BX64u94Eye4Ze/hqUttLY4k8pEJLfDeGV8FKLaxmbQf3jCrLuSBlRGvFlNlCt21cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CarXnG3nSfkX+ngL5r3+h4CnY0UXCQibxXkYoc78fRw=;
 b=r8NFZiqubldXuCkbfvQ3bmEe+0/blplSzs29YLf/w9CN2RVrj2QWRAFgvzrfZGLDik9ZF/lESJnDUF9GYTg0m7aygnGlRbF+BCdDQrvhX+zBfRDoCDAgbQcXVzTz3kwoTM9fKDMbQzjUIv1WtccFfwRa3K7/j5/unJcQoyBqae8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Tue, 21 Apr
 2026 07:13:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:13:16 +0000
Message-ID: <0db79594-c302-4576-a87c-ccab1c3ce326@amd.com>
Date: Tue, 21 Apr 2026 09:13:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Matthew Brost <matthew.brost@intel.com>
Cc: "Huang, Honglei1" <honghuan@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
 <e494689d-f126-4be8-8337-f04be1abd12a@amd.com>
 <aecGNdso+EB/Aip5@gsse-cloud1.jf.intel.com>
 <3d19f4c4-5173-4879-b2ee-7bdfb8aeee53@amd.com>
 <aecds3CWc99E1p6q@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aecds3CWc99E1p6q@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d8b337-b02e-40a3-df88-08de9f757504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: dL/ge3NRc7Q3gKP1fTS72MDAomm9ZM+yClvwBKSTQY38epfz+FhxVV6N/fJWlY0+hGDwDmYpRRL7sXGaYFxcKf07Je7B8aDfbpOWT9EiJi6/jcOiVg5xr6JDuVH6GhL4vWvPolgYUa4GBzjQPYeuNAaC7Ym9Q6bmf0B6ari7nYPm+lb7VVdFglNT/b0GNa6ZQfInKmn/J2o5HvJpjbVILW59xtl/hppP2JzituWgm7oJiJczszq6cu8DN25urvdadiJ73oE3EF2wL9hfGEif0ClwSkoDv20sKYOJ8HjlQNPUrkXrP0dpaQFe6zvGYrnrodD/KpBstLB25swbx9q5GXmNVYyFNWSAfBuHbsEMBn7xFFjPWTSdZdpPpyD/tl6VqCSMA9WaLGlzQMjQsB16iH6JTsNx4PCTGd2wAikYvDVpetrZEyeQwwGy6bco14lnVwfv85oq0pWZ374q3/P0Rv1FIXbmqJNbmxOtxznCcGmcZMuKclsykUVcIANoQZpTj40qJIbs8ZGVsfBZukcafBDJXvlwRYwzFMN9L8UbPFG8azbny4BNAFBywiQ6qaoe4cMdwz1SA2GnCHQ2mIaswzbTXdtQoAbFUJ9eHamlVzts/VWtg9wGH04hz+BOuHMBRmy+qj8nI3PM36B8UdOKZu6n/Fk9uxIDr9YAkFH26GZ+HpcFLTrXF3zNnhZL1hMJ+j9czgErJUoPqQY9ZKsI2mNH6tdIm8ViaXXE/OZabAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhFV0dMUEVJZzIzNVk5TEFObTJWSXVub3VZK3E0SVhNYXZnZHZnckFla3gz?=
 =?utf-8?B?OXl2cDBJcGc3bTJ0eUZLZUQ0cnBQbC84NFNQM3hNQXNyR2hmYllCVy9CRmhs?=
 =?utf-8?B?b0Z0RVdDeGpHVDFTQjB2cUkwM3MzdllhVXJqVkFOV2gvVytSK2ZrVGVqU05F?=
 =?utf-8?B?VkY0RHFKa3BOWjYxRzJLRVVYOUJFVXI0VG51VEZDTThRcmJiMXdQQzdaUytR?=
 =?utf-8?B?Q2ZqRUwzWG9JQlZrbkxwRU8xbXVrQUcvNExHaVlnZzZtd3U0NUZhSVViNW15?=
 =?utf-8?B?dGNNVHRBY0ZRbnBMNjllZU41bnJNTlBDSGp5dG9sS3pab2ZCU05JRVhmSCsr?=
 =?utf-8?B?S1dweC9UdWRacERBVmVoeHNocm9XUVNxaHc1M2dZL0tDTGI3c2JKZ1dqRTgz?=
 =?utf-8?B?TmZVOGxRY3NKVFA4Wjhoak1XTlBMUkxLQnpWQlJVNnBhdGpUNm5VdVRlNE9x?=
 =?utf-8?B?MGFKQWR4VU9ETXBSTjBhOFVQSWlFcExKUGRHN3FVUTZtY3Rtd2l6UlZldEVH?=
 =?utf-8?B?czBrVWxYVHU3aElqV2R0NzB4SmEwUzR4dFhJb1lNb3E2bHM1eDd2VlRFTjRI?=
 =?utf-8?B?VDJWUEpWLzI0MC9Rd2JiKzBCSGY2NE0rME10SE1nbkQvY3c0UmYvREhMVHhK?=
 =?utf-8?B?cFpnV3poTVMrUnRld3k3SXFQQSs2ZWhrUFRNa0pkUndvYVZwREVaR1U2WlA5?=
 =?utf-8?B?ZURsWGNtUFc4RzFyRFkrZ2xVcTJING9TRHRvSGFZc2h6MXRZamlsWFdmWHlz?=
 =?utf-8?B?S0dOS1JqemU0dTFYYkhBSStpL0xqUyt1U2pyODRsRUltZTYxa0tJNlI5WHZa?=
 =?utf-8?B?TnFOeE5JMUZHOXFtelcyczhacXRTbUtWRUVQLzFCTjBMVmRTU2FVeFpJbDdD?=
 =?utf-8?B?bjJWZlRWZXZtZEhwUEJ6NzJENlRic2kzS29pUjZlUm5NeGNBZERReHFhYzVJ?=
 =?utf-8?B?T1BUZzNHYkdCWFVub3RKaTdMUHdIVUowTXZGeFpZM2xqR3A1dzNFMVN0cjBr?=
 =?utf-8?B?c253WkxwMXN3Rk9zMXUrMThyZVN5N1RlcTFhbnpOblkrU202M1JTV01BbTBG?=
 =?utf-8?B?T21CVEl0STZ3VXZ2cDhVd2ZZVFRQTzJHZWlYZ29rK3JFY0trdzZaVnZXOGtk?=
 =?utf-8?B?ajNCT1JNL3ZCdFJtaTlQSFhZbTZraTlRLzRFWW9JaTRxSmdaemcxWWpuYVQz?=
 =?utf-8?B?Wm1yOFJTY0JxeUlPV0x6QlIrT2Y4c0RFS1o5Nk9zWWd6TnZMaE1zc21ZOFZo?=
 =?utf-8?B?R05IN3REYzdRelpJZ2Q3c0hVTGlQczc5Tm5CdGNla3lnUDZiZmNGYTQ0NDUv?=
 =?utf-8?B?VFNCNDc1dVRSZUJXM3BicGFPTjdza1l6d1dyMUZXb1hrZXdWK2czZFQ2RHlE?=
 =?utf-8?B?RHRPMW9LajZhL1NNYW42NTdBdytwVWVuT2tDSkNacXhLbjFKclVTSjV5RDZu?=
 =?utf-8?B?WnQ3K3dtcFpCM0VnZTBJV0YxeFc1cFNJUWNFMVJRUzZHSTB3U1BBOGtyRE9Z?=
 =?utf-8?B?TExqN2cxUHdXRVlTTERpYW1vRjVBM0o0K0NRK0xLT01MOTBEeElVa2wyTHVC?=
 =?utf-8?B?ZmlCR0RnVk41Y0VzMWtzWVRqWnJCZkV3K3NuQUZoQjQrU01yVWxpYlRVcDRv?=
 =?utf-8?B?SDJtaWRydldhVEJCQythMnprS2d6WnVQWFI3ODZqdnpIQ0ZEUVllamhqZWhx?=
 =?utf-8?B?N1FQN2xhL2NGN01rTlQvcmxybUFmY0VJTENnb0R2V1VyQ3FhMk52akFTVlM4?=
 =?utf-8?B?NUVCZDZsOTBPWnNvVlhBYktTSXU4RCtsejJqM1FiNWlFMnFCa0JacG9pOEJE?=
 =?utf-8?B?S3kxMWs5NDJBR2t4bFIwai9semdBZ29HVUJlWHl0d3FCd0diZVZBNllIMk9H?=
 =?utf-8?B?NmFYczB4VUN1OHdHWWsxM2xTNy9Kek9ZVXRmQ1JMcUJ3d2dzRGR1RG1OSTVn?=
 =?utf-8?B?R3NlNTZ5Qndxc1JxTm45WEJ0S0NwRzh5eTUvT0UvWkg2UzRZQjNUTTRkbGkr?=
 =?utf-8?B?VlhQcmoxdTNsK2MvOHowWjhJa2R5aE82dk9uMnZkamgwTWtHNUlzNEFCTnZo?=
 =?utf-8?B?ei92OUt0RGlqbjZvbUpPZHVMTm5TbElIaElFU0t0MkZaejNTdi9JdS9BUkQ4?=
 =?utf-8?B?MGh6d095UWdNV1RrQUFtUkNQRWRuNkRhdkhCV240aUhvTWRGRHJFcjhZRi9x?=
 =?utf-8?B?L2h6RCtOTVpzVGxYTVFuVE90bjVqREdaMFcxbG1kYUlTaHZ4YldQRXhMTnZz?=
 =?utf-8?B?YTN4MUZza1RnT1c0dGpOLzd6ZnlURyszM3p6NlNLUzJqM2hSTjVyVjhIYWla?=
 =?utf-8?Q?EzzZuerPsfrTp7cuz1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d8b337-b02e-40a3-df88-08de9f757504
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:13:15.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eI1NfQy1js5XlHFFNJyb67q68ZWc0UiioxrYnn5g2x5HRqz2XMTja0Jehr19VWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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

On 4/21/26 08:48, Matthew Brost wrote:
> On Tue, Apr 21, 2026 at 08:19:54AM +0200, Christian König wrote:
>> On 4/21/26 07:08, Matthew Brost wrote:
>>> On Mon, Apr 20, 2026 at 08:07:38PM +0200, Christian König wrote:
>>>> On 4/20/26 18:06, Matthew Brost wrote:
>>>>> On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
>>>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>> ...
>>>> Either you set the information per-device and then each device only gets the information if it needs to migrate the page to it's own local memory or you have global information.
>>>>
>>>> So why does a device fd needs to know about remote pgmap?
>>>>
>>>
>>> Simplest example:
>>>
>>> Devices A and B. The user sets the preferred placement to Device A.
>>> Device B faults first, and Device B moves memory to Device A via remote
>>> pull and can access locally via P2P, scale-up, etc. Avoid a double
>>> bounce once Device A faults.
>>
>> So you basically tell the device as soon as you want to access this VA please push the underlying memory away to a different device?
>>
> 
> Yes. GPU SVM supports remote pulls.
> 
>> I didn't thought that would be a valid use case. As far as I can see the only thing you avoid is updating your page tables on the faulting device twice.
>>
> 
> TBH, I’m unsure if this will happen in practice, but it also seems
> entirely possible. Computers are asynchronous, have random thread
> stalls, etc., so out-of-order from expected access isn’t far-fetched.
> 
> No on 'updating your page tables twice' being only bad thing.
> 
> In my example, let’s say Device B moves memory to itself initially. Then
> Device A faults and tries to move the memory to itself.  
> 
> Bad things:
>  - Two copies (one from sys->Device B, then Device B -> A)
>  - Device B faults again after move to Device A - this stalls B's
>    execution pipeline

Yeah, I mean you can always shoot yourself into the foot if you give different devices contradicting information what to do on access.

But I think for this case you would tell device A to leave the buffer where it is and device B to migrate it locally on access.

So the worst thing which could happen is that device A accesses first, updates it page tables, then device B accesses, page tables of A get invalidated, and page migrated to device B. So at maximum you have one extra page table validation/invalidation.

When you tell both device A and B to migrate to local device memory the page will of course start to play ping/pong between the two devices on access.

The feature doesn't sound that useful, but on the other hand I guess drm_svm has already solved the pgmap lifetime issues resulting from that. So why not?

Thanks,
Christian.

> 
> Matt
> 
>> Thanks for the explanation, that was absolutely not obvious. Going to discuss that with the team on the next meeting.
>>
>> Christian.
>>
>>>
>>> Matt

