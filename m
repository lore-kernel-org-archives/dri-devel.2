Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A849606A336
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dXWL2rmz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9C810EEAE;
	Tue, 10 Nov 2026 08:49:32 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B10DC10EEAD;
 Tue, 10 Nov 2026 08:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsxXt+siY8/AkH2V7PESR+QCmcl3saJpGSecDvuTPc+w4kZIwgWwp8/k5kvD9NnUvBuEPoMbuh1TI23OxxWJL2saZGCa7rMFjSBpcsPIjoTNJkcAwx/aXOXbl+BXsFNQaTCzK13kNxWDsLmL6MqtJFoXw4TrZebsCstcql5YZxokqLgk6ib3pl/wVvQ46DEnkV1AfdLGpsZJJ6xueOnmpGBSQfOR0QdJ0S1Fxx/m6UgzG72yO0Px0+UYfMEARkLQR6U+nm2c+WlS6x9UKqzVK7hoBaN62IlupaiaOtKrAtZyOgB0QovKCOfuIj2jNc/6n+0vRSv2/B5reW46fcl0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuTERlj8mrPvIDetW39we38yPvkuWFM9P09SiWG8mkA=;
 b=Vc1gJtBNsOfQ6zgHqvE//c08GM2h+sWMzXlwq/9yNasbzRyTzUjM/4MHkuCw4C1/UZEbY0F+raiVACCLCIhEDOfBExy4kJk9umEN9o7x72bIXiGc2eb5mZG/ab2Hh7ScTkx88Zbe5FBKyUNDflQY7PMnaEWH1y++9yduxpHOFGIv0v1xhCconHQMN/CensHW97CWFijZQxzaQ0ns6cbrB8wHVPE9zyQgTAlJ1/r1zgSGeP0ZGEgYm+SA8mMwIqH9snN1FYY42PCBBxaKoyfsj4PXmVSc/ZPCGliGIjA9+cq0O5k4dq6uiu2GsVP8TQLHX8n5EUOzKlVN39W5bcme4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuTERlj8mrPvIDetW39we38yPvkuWFM9P09SiWG8mkA=;
 b=dXWL2rmzDnX2zA9jJ/NCKKwCfavPPgUwWjAaJg9B7FTnri0OSNCLvoXoLjxf71lNnr9LUtaiJZHJXkRqu0keoj8K2TOGO5atAWyfUX7YY7rUMekgDOlwoD+NHONYwtGjbFs+O6o3xhPv+26FboB9UuinVPVBHTPbYyfT70QM/6E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:48:57 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:48:57 +0000
Message-ID: <1c55cca0-6e80-4704-8192-352704748d98@amd.com>
Date: Tue, 10 Nov 2026 16:48:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/22] drm/amdgpu: implement SVM initialization and
 lifecycle
To: Aveline Noir <jm5905938@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>,
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>,
 Huang Rui <ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-11-ray.huang@amd.com>
 <179424356769.208802.11801490347938606155.b4-reply@b4>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <179424356769.208802.11801490347938606155.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: e1146272-2c46-42c5-6206-08df3f07751c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|5023799004|11063799006|56012099006|261021121427099003|10067099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 978d9xlIuaoDU36tdW46sSxuwnDFYoZ96EOpc7P4eWdspljofwnALLbEOkOTtSJXZSjdB2SfRhfhx5C6y7pKy4mrBlawIIDfnjmgYH5cJQwipvMLcNr2ELRqN2W9AC8BbKpDkNmAiBvybJsAFJb8QH5V+WMq4R35Ut/mO6YIKaH+38NBFEdCJafho16NghYbn7I6q8wVr71/29NNtDh252Y9IFnWk41MpNzyfvN1JS5k0UEUy89p668vYEzKqyvl3+v09qhkywYL7ERg8IXZdS866chSo0puiGYPEeENfhsfWuurelJCbuSoudh+YtvuMQE9tfjCZ+MSGUW5YA8I21mbRhpKyuHNjk44TdaZKomNBZv46Fe7l4Wgpz6wFifbz/9L1SMSH9nmzsFTNSdAre/TwU4vvE6h67ESHAZ8Zb4QKTLgUecleNBPdZqbcJpvRqjPb7SKpV1lDOYqiPYDy3yqTtwf3nkGjqA2tQgXn/2ydTNbsQGG1Z9efUzDVwxQl/Cvsrs2FSfEakC5Y1aejCUjah9vYw0OejmmHaDYbXQW/Qgpr9tQ/Wrxa5vd4v3rE/ubDvziKHEoUOQk7wRGj+NE35mzd1Tf+Bci0RoKw9rrLtSm+KQiIRXzxSBQ6PlCG9F/f/ZU9Y26nXi9BVjJ3GsMqpzfPQN/lvoxNhdPFT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENLL0VxN0VUMjJSdXp4S1lQQWlYSlF4WitHREVEVDRiUUVaUlFHTUtSUE9E?=
 =?utf-8?B?Q0RBVGRJTE8zWXpuZnhGS0ZrVFJybDBiQjMrekFPMDdmSVJhS0JuT1lNNVpP?=
 =?utf-8?B?YjNHc3RhUjZCTGtSVnQ5b2xmeDNuNklzTXRmc3JCRnFCWHdxRUM0TTBpdldS?=
 =?utf-8?B?N3BVTVNZVm9WVXRsZkRkMFRYMXRkbVhrREdrcUtJOXBuNThoVEpoRWVxRVV3?=
 =?utf-8?B?Nzh4dGRvQ3FkN0hUYmk0aERkZHFXei9YeDdXREppSnlCTU5SMk9IUk11R2J6?=
 =?utf-8?B?QTUxZUV0QW5ORWFCdXl3Rnk2OXNTalpSN1hFZDI0L3Q4OUZsMnBvYmNqTWZz?=
 =?utf-8?B?cGZYbk1oNDgrN3VmUXFjdDN1cjlqOHhubDVSeThlK01aQ3JJYno2czNuczlK?=
 =?utf-8?B?MmZ3bCt2YXJScldvQXpSSE1jUEgvalp2N2JmdHUvbGVkb2RQRTZKWGhrK0Z4?=
 =?utf-8?B?bmlaQ2lLTEZKNGQzU2gzYkl6MmhJSmFxTTRXM3B3MkphWkRuekQ1amZUd3ZJ?=
 =?utf-8?B?Y1NDSjJiT0lhdW5oSHNGY2FsRHBZSHFOcVgxTDhVRzE4TVFtS3NrdXFyalVK?=
 =?utf-8?B?eDhMa3B0MXhLRXNudENBRDZnVzVyNDd4M0NJRWNKUWFQbHJhemFvTFdkNjI5?=
 =?utf-8?B?eHZWcjhHM1ZQOUtMd3RNMUNrWkJLVkdnZ3MwZXovQUFqWnpEbEhKV25ZeWZ1?=
 =?utf-8?B?aVBaN2hEc0o4RXNhU2Z4OTc3SS9aR3VNOXdURnNUR1gxSU9LODc5YmtwMmxN?=
 =?utf-8?B?MUhBVnVVNEdIMzgyYjVFeEYzWEw0UmJRUHJWRWFmS2xEVnFFbnNkdjE0QW55?=
 =?utf-8?B?R05lMzVaYVlGRWZOQmY3SUM2Tnl0bmRBdmR4T1JsbDllNThxTy9Fc2x5U0RS?=
 =?utf-8?B?Zy9CdUl3QmdVK2dya2Z1SE1qdU9qODJEWVVUbjloWmJWeC9RbHBvRm9ORHJD?=
 =?utf-8?B?c3lnd2J2bkRocWtKNitsTEtId2NXNHJLY3NDQStFKzRFNXdsbkRWV2hEVGRn?=
 =?utf-8?B?dTdGWmZ4ZjV0emhOclBoNnFXQ2MxOWtTUEVZQTYvUXBEZkU4TGFLcmJUcHRn?=
 =?utf-8?B?VHBJVDhaalZSK21BcXJJS2RvdWxmZ3ZBRWllNHlQdXFRVGVEeXZrMXIwRmVo?=
 =?utf-8?B?N2tMNGZQUDRjL1d3UHU4SEIvTmIrLzVTKzVHM0M5TjZRUVcyZ0R5eW55R1JQ?=
 =?utf-8?B?NlVrMjRneEx1b3hydDJESlVueE9wdS9iOHhOR1Y1NTcxbWNJRG5Kem85ck1p?=
 =?utf-8?B?aitFZVdzSGJTY2hxUFRiNjU3SVFOdk5yclQrdjdObDlWSEFKR1pGVHQ2dk4v?=
 =?utf-8?B?TGtYbElDdE42TkduTHBGTmtRbVpjVklVckdrZ3I5dU9SdkgyNlFzK3p2a3RW?=
 =?utf-8?B?VXkwNG00cDJZQXdKeHNRWDl3V1cwdmErdHpyVnpxYWx0ZG5vSjRkVGFDbGdt?=
 =?utf-8?B?SnVHdmNXamFSZlpRQW5qeGJRTVNUSnA1a2NOR3RjNW8rT2xTN1Foa0hHQmxY?=
 =?utf-8?B?TWtiS21aSjJTVmJCQnhyTUhGNkJpWndCdmJRMlllT1orenhKRXVtcmo0ZkVm?=
 =?utf-8?B?M2w5d2Fub2RMS1lYL1dkeHl6L2hCSWpWTDVERlZqamhBQmtqK2RibzdwQUs0?=
 =?utf-8?B?MEZWMHUxYmZLM2xxSzl0VERWb1dyWnA4bWhlbHRwNXlwb012b2xGYnc4eHVN?=
 =?utf-8?B?aWpFVXBUZjZHdjRXcVhDQVp4eCsvZUZxc0U2OHhNeW5aSXAvd1lGMFJmYk1D?=
 =?utf-8?B?aFJqWlFWZDNsNjRZdmNBR0xVYjA4R3VjQWozOUNGR0ZUQmR2bkE2OE1EQ2w5?=
 =?utf-8?B?Vk1aVldwY0h1My9haHFWMThNM0hyYk1rYlU5MEliZ2JLUnZWSXhwOG5rc3lR?=
 =?utf-8?B?WkJUeng4ZHFUbEVMa3dwK0pQRWlCMGxxc3NwRy9GMFBLb0s0NXpJQVFVdHRY?=
 =?utf-8?B?QTZPNmF3ZWptVzkwSHlhOTQ1Z2N6VDNuWXF1dmRjTzdoKytMbHZVclpkeW5O?=
 =?utf-8?B?U2srMU92VXJhYXZQSnFWUnZnaFhpYVpCd2xpSy95RjV2V2Jiak91Zk1HSHZS?=
 =?utf-8?B?Nlg0YUwzbGlCTkZ1dVVpdDFNaHFraWxnZWFKOC8xZnN4NWltMy96TDYyTENr?=
 =?utf-8?B?eTdIQmhPSG1Pa0owSFUrN25oc2xweVM5ZFRORnZINS8ybmE0V2lVMjBIeTlI?=
 =?utf-8?B?VzF5RURDUWhZQUxEVlBUSUF3NTkwbjQzY0h3V2RNazVZRXpjUnYxK1FrSm01?=
 =?utf-8?B?S0paMXJjRHR0OGJaaFUvbnN4K3cyWGpSN0FZeUdwUmNKVlJFOWhlZWVaRytl?=
 =?utf-8?Q?D2jVmFATVfpRZApSIp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1146272-2c46-42c5-6206-08df3f07751c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:48:57.4945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uth9yc7gQel5cZvRoG0LfNZxmv2UXEI1UUBS+f9WX1tC2NUhPublqfkJWcSARmXLCjePMX5FVHA1+CuCoUOnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
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



On 11/10/2026 12:59 AM, Aveline Noir wrote:
> Hi Ray,
> 
> On Wed, 21 Oct 2026 10:58:49 +0800 Huang Rui wrote:
> 
>> +	if (new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
>> +	    new_attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
>> +		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PREFETCH;
> 
> I'm not sure about excluding SYSMEM here... The proposed libhsakmt
> adaptation maps a CPU prefetch target to SYSMEM. If the pages are in
> VRAM and the update fully covers an existing mapped SVM range, nothing
> gets mapped or migrated eagerly. The GPU PTEs can be zapped, but the
> pages stay in VRAM even though SET_ATTR can return success.
> 
> Is SYSMEM prefetch meant to move pages back to RAM, or only to set the
> attribute for a later CPU fault?

This is indeed a issue, will add local system into prefetch in next version.

Regards,
Honglei


> 
> Thanks,
> Aveline Noir

