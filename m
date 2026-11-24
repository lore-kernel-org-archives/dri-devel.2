Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MStmwY5z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9778310E7B2;
	Tue, 24 Nov 2026 06:55:51 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C8F10E7B2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqSXB5OLeOeCAVXHHKQ+147oeoKIF7vA9K2eBTKCou9XNoyQPI/Dv7eyBAKC80ETBEjMbAbTnq8J99sys6pipvMrcdmBG1AZpEUoshOPRk2ZLtRfwQ1kIkrYHHS6d2/pWu89poz3hDiBVW0yftofJcFeGrjIEq+WDGc7p/sojO2Ec5au4FgU8KXtSWtxkCaHwsorOxTxFFI06tEtqF8Oth8e3E6GYOJ2MLhN7/+YNUmgxcBRUQMMsLSa4ELuSxUG08dne8EaHL8ejYDGKNd4BEi2FGGwTqWeeS7bH5pGqzS8i5llCIJGfmftP7gRB0tbd1P4kaT6WqnIXQbXOHqXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/9Fphxt/tr7xoRzcpxOwjLl6TNyKsy37AhAaUvpRRA=;
 b=SP84EtrGFIgiwM5Ga20YP/FSYqvhzsRfxSuTc1Ms51jvXQPTCC7+Q8glz+yrYdn16s1BZpRDtnqQm+villFobJvq+NCwRlPe6UYlkPhnwTlRxY+WSJLX5kmaAQsu9HfZ8JnfW3az7fjWfgryqs02jvfAqbgKdFll52/vIBKMCBQo1D0oegW0szG/LSVxD5XfMNXRNY4Yr9J8zf1aemgu1FJ42zurVJnj/dTFIKSLfKVHiQQHZJ3ruko8x1UCaEMUZgOc6BVnP+00LhZWVVz09ThhWqbtwtyg4tGd3e1UYbzSg4+eq411/tqTxjfd6+b5hkwIWT+d09ARnK7RkZ693w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/9Fphxt/tr7xoRzcpxOwjLl6TNyKsy37AhAaUvpRRA=;
 b=MStmwY5zmzU1lt9xQCXhMnXrv+cb1iNvDE9/YxFh/Kxa5yI+VjmH8Qmhq/8cRfCkc/+iJcPal7fxPC7dNmQR1DNZUadULPsV9PdVq72T+rZUmxguCsNEsUzCKnj8RMKF0Hdv/CjKOhHGXvLd5qx3eXylI+XotyaI+nhB+CBGuN8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 06:55:41 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 06:55:41 +0000
Message-ID: <3c762d0c-ef16-4e3e-af96-fd65fc492db5@amd.com>
Date: Tue, 24 Nov 2026 14:55:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About NUMA support in drmsvm helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>
References: <316c1d61-f297-41ad-95d1-43aaa67c9696@amd.com>
 <c844403b-8c07-4a37-a988-85d2548bb674@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <c844403b-8c07-4a37-a988-85d2548bb674@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a18f33-cece-479a-9aaa-08df49f7f41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|261026121527099003|261102123227099003|261028144727099003|261009223027099003|261021121427099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: wbQXAVc1bOHUHdwSJCyPB2PTmdW+b8YTbezh6UInwQqnAo8j3yd7hSr6MY4p0LRyZJoY/DE1P7lV6YFU+aRo5ey/OLIODQoIFBcSDbrLnYcPUVBSNi8tUXbmD+XlS+BPgKRohevyL1ljRwyM4gQ7ZJZxA7u1YdRXNJ0xcBpwyCuHRpO5aGBIlD7/OwKayNbFZ+9C/5Fa1VLrTVNjxFdGIT3tuDuBGYboI+L0taRT6hhGNgMwCIDIvEOnRnWktrcLkE6D1H/C8CAJFXyAAUvv0B6FYSCcJfrS3IJooxTkXcErqZV7Ux+koVW37VpuNmmKspkNseAtqLz5+hO/N4SGdd4KYdc3vCs52FULSIuVKcWuSN2BX2/5kjiEFZ/p7mfGMHHzciqZSkwk/QCMyH6oLSuoISGxsCekuLfqgq4hPPsq5RHPAoNQjlyg5mgYuyWPY7+ygZsNkCJ3wSKBmx3rRFxoYIMU1jissCQXxYSUKjkXfEB3aIZ1yw0IeAw1z/GD/TZlkayC/+8Z6nDWYgrfFuHOP945sFd1BtFBWcZDi6AWxjm1DAMjoBccyBS7Y0nuZUFnbSztb4qQzhd9nqHi5h72GLZWfHif72+a2K5pEd5VK5zlAqSF+FREikwHM7Nz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlKUTBQcnJPZFJOMEhYejdVL2p2bE9rVjdBejc0K2NIYythR3BlbTEyREYr?=
 =?utf-8?B?TWJoWERhc3ljdDRUZmowZzd2U1VzY1MvNEJiSFZWcTIwb2dMbDJWVE94MDhK?=
 =?utf-8?B?TktjNTlGWjVqNWNTVG5GdXFFUFpOS0xiUmFRZlR2RzlXQkd3SzFmZFpLRzRs?=
 =?utf-8?B?RGxuTkUvbldCRmRRWlFSYWZYOTBtbmFPNmFZNEE4a0xsOWVJR3JjZXowc0da?=
 =?utf-8?B?MUd3Z21aRnZzK0tGVHNlSXl5ZXlSR3RpOEJpdFBJM3ZEam13TDJndUNJRHpN?=
 =?utf-8?B?RGVnclhjdklvWHNkbE9MQjQySWpFaVNlRjloS3VMYUY0djBORDZaS1p4Y0FE?=
 =?utf-8?B?Y09jWWFhWXZCUk5qRm8va1lDVGRKRTFmamw0bEYxMVhkVTFIeG9PSTQ5N2ZE?=
 =?utf-8?B?dUVuM25xeDArWW5CM3h4N2ZhM3F4aXE4Z3pWYy9ndWQzazUxSVlRaCs5aUdB?=
 =?utf-8?B?K2ZNZnp3cWVsK0U0RzNjbTVKU1UrU0Z1Q1d1bUZHVXAyeTJxR2hFVzFaUHRQ?=
 =?utf-8?B?L09SbUsvdmNWZi9talNack1hZ0Y3Y1RtY2I1Ukg5VEdtU2ZBYWxIOCt1bjFz?=
 =?utf-8?B?TFNieW1vVVRGMWQzSStsT3o3MnNoNzRqelZ0L3d2eStkUzZ1UUQ1S0w3dzAv?=
 =?utf-8?B?bmNpZURqTEJaSlRST0N3U1RDRTRVRDhDL3UzdDZXa01TOWpTdFVxNXVwdjF3?=
 =?utf-8?B?YmRNOXBaYk12VjhwWVdVWWFXQ0NFbVdyQVdiOHoxdlExUDRrZ3JvU1NrazIx?=
 =?utf-8?B?RVV6dmI3TjVtYmt4WnM4c1pkYWJ0ZUlsODFBelFuUjd3MDVsYmJmT3RCMXNr?=
 =?utf-8?B?Q2tDYzU1c2JwYWJndVlLMmhtOGEvSHhPK09RbFRJNmdCMzF1ajlUbFRuaHRI?=
 =?utf-8?B?WlUyM2tRMVp6eXZQdWMvT0hqdDZJditFdk91eU0wTE54N0IzZjdmbnJKV3I2?=
 =?utf-8?B?cmQwVHZlbHFiQ29pUDZMQm16dzFLclFWSzlQaXlwUmpDaHhTcWhPTXlZMnEv?=
 =?utf-8?B?MW5BZURNYzZTV3BGNENLTXdsa3VLZy9NaDUzUFJyOXRtQmcwYzRweTBQMlpU?=
 =?utf-8?B?a1VIaGRNSXZYTXVzMlJ2UGc4V1RoUEVaQVkyTWlRd3FBSms2S3ZGWFlmVXdX?=
 =?utf-8?B?UzBCRXJaMG1mR09TbTBidi9yei9EYXZMZWg5LzBqa2ErbEJxK1VIYk5zbmtT?=
 =?utf-8?B?clBlOWloZzJESmxPSXNQcFJ1cU93RFJFdk1IN0dkZ2lKT3p1NmwzQjI5ck0r?=
 =?utf-8?B?YzIyT1F5VzhxNW4raVkwWkIzUTJjWW1rUWs5THNWRGFBSTNVWUJNWThIVnhj?=
 =?utf-8?B?MGRjQUdCNDMxR0QrOWdYMER0ZHZ5OVRUWllLYmxRSWlYTlo0VHFqYm9HRkRE?=
 =?utf-8?B?TFZSZHk2U05vOWkvR1VkajlyQWZKZWV2eEFzVjhjRk0rL1R3K0xrb3NxcWl0?=
 =?utf-8?B?akg2YWRNdG5IYUkzVzQraHA0cldXS3FoRVJ4cUQyS3l0OUcydDd5WFdwcEFJ?=
 =?utf-8?B?SVpTVTU4bUVGUkV1ZExRUUNIdjVBb1czYjdqcERQcFo5bk5kVTh1Q0c3eE92?=
 =?utf-8?B?U01uYlk5ODQrdW1NTmx4WUZSZjNnMEpDeDZyWTF5cWdyZ2FMcURFS0xnVVoz?=
 =?utf-8?B?c0hhRUJSWmoyRzA5YS9RbHl2c0JSNlY0NzVxYitmOVhPeTVSRjExbDF4RU1n?=
 =?utf-8?B?RjgzTm9KaHo4VCtDM1RybmRRdW5xRWpnRkFuYnY2bnRGaGlPcW5KcGtkL3BY?=
 =?utf-8?B?cHVqWSsvVXlLbXpkQjZRRXVqdmtRenVzV1c5cDdhM2JiZC9iTjZPTXFCSi8x?=
 =?utf-8?B?L3p6WkNKVm1scDZxSHM3b0xtKzhyUVdVd1hucUpac2N5cDFiWVJhTnhpeVZB?=
 =?utf-8?B?T0dYUnc1N3FYSTNnd1lVM0p3OG0vaFFrbEwyN2JSQTBNbGhmM2NsbFJ2b3Fs?=
 =?utf-8?B?ZDcyYWcvejhGMlNHRkp0NUtVVVBRclN5S3JJbTVXME9yUllkTUNZd2NWd0Z2?=
 =?utf-8?B?WXVzNndqNDBvSDFNbFhSbnFNWW9yQXJYNmowMlBlV2VsN3JHV0szMGFWbUlP?=
 =?utf-8?B?VFU1N0tGeUZVV21CRTVCcW1Lb3VHcytCQ3NNQlovcEtjK2RRU3lmYnpOa1o0?=
 =?utf-8?B?UjZQTUVuM3JUQnZPTWlFZHB0S3JWeS92Ly85WnNSNno1eS81VTlFMkhWMTBu?=
 =?utf-8?B?QzFZN2FueHA1c3Z5MlVxRFZkWVVvbEdnU0x3MVUrb0w4TXpTSUtEWnRieGFG?=
 =?utf-8?B?eE4ySHZ1RFZ0U3RPK1hEaTN0eVp0ck5tbDAxbENpYjNTeVR4c3J3MmJpMk9a?=
 =?utf-8?Q?5MqIoiyYK/dgkR7QCH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a18f33-cece-479a-9aaa-08df49f7f41f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:55:41.5698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fD+aS7e3Haq6b1MlwWtvrcbKKk5cvyHApb2mPa6IDqW5iA4JCww5PKdqzGHgGcZJyMPm5+s64tm9/tlh2+42zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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



On 11/23/2026 7:04 PM, Christian König wrote:
> Hi Honglei,
> 
> On 11/23/26 11:44, Huang, Honglei wrote:
>>
>> Hi all,
>>
>> A NUMA issue is found in another thread in [1]
>>
>> We also encountered a similar issue, performance drop occurs when NUMA balance is enabled.
>>
>> And there is one more thing about NUMA:
>> The current amdgpu drmsvm can specify system memory as a destination, but not a specific CPU NUMA node.
> 
> Yeah I think that is by design. the NUMA node a page ends up when being migrated back from VRAM to system memory should be determined by the original backing store/address space and not the driver who migrates it back.
> 
> In other words when applications said that it wants their buffers to be placed on node X it is not up to the driver to mess with that.
> 
>> This has impact on some platforms like MI300A that feature unified memory for CPU and GPU.  We did a test for 2GB memory accessing in node
>> 0 and node 3. GPU read/write bandwidth averaged about 2.78 TB/s with local pages and 103 GB/s with remote pages, it differs a lot.
>>
>> There is a requirement from AMD HIP to specify certain SVM memory to specific NUMA nodes. But KFD also can not support NUMA fully. So the HIP runtime have to use linux NUMA facilities to move memory to the correct NUMA node, this could lead to unnecessary ram to ram migration.
>> And it also can not solve VRAM to RAM evict to error NUMA node issue.
>>
>> Would it make sense for drm_gpusvm helpers to let a caller pass a preferred NUMA node by interface? An explicit destination node for migration to system memory.
> 
> I think we just need to make sure that the NUMA preferences of the process and any setting specified by madvise() and co are taken into account.
> 

So we should reuse existing MM mechanisms and respect application NUMA 
policies, right?
Some changes may still be needed to cover the remaining gaps, and needs 
do some test to verify the NUMA feature.

Regards,
Honglei


> Regards,
> Christian.
> 
>>
>> [1]: https://lore.kernel.org/all/b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org/
>>
>> Regards,
>> Honglei
> 

