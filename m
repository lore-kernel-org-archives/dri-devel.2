Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D6606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ADoKEDrF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE3C10E3AC;
	Mon, 23 Nov 2026 08:53:18 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F08710E3AC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipb6rZBZggVRpRoCdL6y8RBBVfqx7tmXHrve2NhO9wtqX5KVft1KhD/UFpWc3GM7LRGrMFb8InT5f4Mgm7GFd7rHkDHvEvxX8cZI87h7ITovW0IeI/XZQjCQJRvCmFSsXGMuEdFnTiAHTV5zlCcJO8Lsyg66pOWY8e7QsvxQ1jvqZo+h/3pRAd8dsfa/BV3UJA7R+fj/yK53LJJ3uP5c9TxCHHD+qBpAAQ8PTBkfwGRkIWOBVDX/TdXZn/EengQuDqxctF0JEIZmH05yVwMBRbX/NjczMuMthMzQkVO+BP606iOEZIsn4zI3q9OzK0vi425L6ExiDqf/N7t5DUcMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+I3nqTuSVcP1MqEnmiXMVzx7Y/hAtndfzaEFDl2t1M=;
 b=u2wyBjHDLA1TAn7l1sCEskgscW8W1fFOowAw2y5XXB+La/o5pp+Eq3Jp+DbiK9plnnz+aPQk17OZlOn9WMkPQpucr96CmJ3CHuc7VSvu5hP1dmkLRze429KLexceMXBKlxnlfTLBWnOxUeF3KKRoH8QPkYemalqVlFRxN2NDOLpmHg1FAos17h1NZWnNszfXkA4wBGO6Zga5/7MxuoFXLcTdxOs3ghbyZh3kkp1YNyv1/7kvO1dSzZO3cuAZWHrZknk3HIUCi8rWDsye5XvA5Qt0at6m8rJwA5DbESFIthxHs2AiH5hw5HeGOhow3a3pnrnmX10BRrd8whR+1Q+yvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+I3nqTuSVcP1MqEnmiXMVzx7Y/hAtndfzaEFDl2t1M=;
 b=ADoKEDrFKJvMly4zdNl8TfkN3oYtNECtKL+W2ymI9tQP0CWf4Y4yMzR3NMarD5GxOROmbEWsMWaz143a/LrI/vii7U24tXRfSYzxR5f7SIrtYloPHqmmy7hP1GDs++QI0bFAAiXrFreYBS/mxBB22CmeLuDHeo8vnneki0lshxg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:53:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:53:09 +0000
Message-ID: <b59cd917-4709-4f9c-8cd8-afdc24138d85@amd.com>
Date: Mon, 23 Nov 2026 09:53:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Reject a zero sized buffer in
 amdxdna_gem_prime_import()
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 mario.limonciello@amd.com, karol.wachowski@linux.intel.com,
 max.zhen@amd.com, linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com
References: <20261120023540.888381-1-lizhi.hou@amd.com>
 <48d1dd13-9ec6-402f-8a72-ce417f331332@amd.com>
 <a94437f4-f0e0-dccf-3dac-1bc1f0dda835@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a94437f4-f0e0-dccf-3dac-1bc1f0dda835@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: a0499b21-1ec8-4b75-6b5e-08df493f3285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|10067099003|11063799006|56012099006|261102130727099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 6ovdjS5VippqV4FHmwGYUndwcco7WQOuV3tHtfig/EJAldfAnNtG59jWnn0c4w5o7bpMNXU+/VZV0zajR5pieMrVs9m8oRukLnEBgLrZRXyc82TJGrKeNSyZfblX5hCX/g+8dNWpcFeitMZC+qUvkukTtN8bcXN4l3xdq6eH32kUH8rvfFG9xYQGV+IKFQenpeTkmmUbp+13TjvRM79QXPQ+7m8+aEI5+C3jTWJP4bCrC78tpkRXSxc5fPUSCGeKl1joQB799UxQ7B62c76cdQVpEYT89mEIp2tWL3WXYG0W4jnGvsINqU7g8cPtm+huyXx6HlAC4RivCWAzU4c2C5R+koCpspOIAezPMVNmEH/07dqh52Hj17RoWcLTc+goXPt0ldvlvymYsRKPbM5ScqUY1Uf1QYobmFmGiv2Yjadd5DgZ/EAyzmut/0CuOISfEL3iCzAVfD4uEE4zltCJ8V179zg0RVnAl3rRun5ew5r3g/cxYljYXv+lxV2jtLbNAlQwXt+HK6ZwytV2I9iE1cvzJ8bW6jRwc3V4jG0HAh17Yn4gNV5r4f04iqXWRXpZpjcAY7BWA+xqtrz50H+InU9c4UH+OHLlKm33W9s+TqRnt/4I+TjUamSFuLzMDiV4+WX/JJLxouBuvDjZAaSCRuJQiqX307YljL4GRr+TIAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(10067099003)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHAwM0FCUWM1bkN2UVdPUHlCbHhtdXBHWlFwYytsMXptT0tKdTh3VHIzRHRW?=
 =?utf-8?B?c2F5RlNGUkZqYVkzNFNYRjhaZ2hYUEtYVGF5WFhHcW02L1JMd3R5Q2NramdF?=
 =?utf-8?B?S3djMEhTWStQaElXd1VsNmRFZDNyelk4N3JGVWNKZkRZUnRIUFBNdDA0d3ph?=
 =?utf-8?B?QkRSQm5IRHdPUm5RZWxreVc4WGl0b2tkSnoxa05GcGtUeko0dDhzc2FqR0FB?=
 =?utf-8?B?UlBycnZTWEVWMGVHOGlXd3dCdlFsWmFBbUR1Z1NzMlI0eTl3ZmFlUGFuQ3Fi?=
 =?utf-8?B?SnVncTUwTzZvQXFORlBhZ1FlMG1UR3JhN2FmcmZkTnJxenpwMWU4aGxGWGs4?=
 =?utf-8?B?S1dyWDNHV1IxUDdzZGdGdGpSZHRZOEk0T3B4SDNwejdFWG9XQTRrRWxkZytH?=
 =?utf-8?B?Tlh1NEZpWU9xbzdNSldwaU5GM2ppbm92elVqMjhsaEVpZURFajRxUlhqdmpa?=
 =?utf-8?B?S1haa0padjJ1QWdBYU9hdXN3VDBSSFR1SlJCRDhHK0ZnaTNGaXpCSGMzKzhG?=
 =?utf-8?B?cmhUVFNmSjdwSGQzYkNlNzhOc2VvVkdybnZVOFdKbHByR1g4MFcwQ0FHMUsy?=
 =?utf-8?B?WnZLZ0xXdW1BVElSZEYxRVB0bks0d0c5M1NCZGVKeXFvL01OZVNTRW56d0pZ?=
 =?utf-8?B?eXJXSllVSVN4U2trbjVKcExTZ1BPaTYvUFNzWGdud3daRFVvblpBWHpxV1Q2?=
 =?utf-8?B?azc5bURJTUZINi9vNDQvK2hrVEJRaU8rbThIRTFJYjBMNmVkc0NIQUJ4Rjlo?=
 =?utf-8?B?b2xOQzI4SDdVOVlUb3dsU282R2FVbzVCRFMrWUFlb2JRVTBCcGgvc0xQazgw?=
 =?utf-8?B?aXhZRTBuQ3VXZzRnM01PMjZPSUFFRkQwMVFJSTE3SCtVNXR3N1AycXJFSXY1?=
 =?utf-8?B?cXgxUUhhOFJJREdlZnQxd0lCL21wdDNlQ1JIZjRoZS94cURxaTRiQkVoSDlo?=
 =?utf-8?B?eFZSM1laZjBuT1Y3R1JEVnk4Y0pQQTFJdTd2T2x3SlpCY3htOFYyK2lOWVl1?=
 =?utf-8?B?S0lRaVB4cThacjR1aUZFdzBTWm0xajFFRXAwTlNueGxtUFZEWHpIYnppTVJW?=
 =?utf-8?B?bThvTmlQWUg3ZFZmMktXUThOcHNpYjdZR3VGR0JiNGF1OExuQWU1a1NnQlFM?=
 =?utf-8?B?R05BcjY2S2JFZDh3a1QzMmt4bUhPN1o1Zk9ob3h6T1F3QkhTTXBtc1AzelpG?=
 =?utf-8?B?WUhZQkxTY3pHd1J5cnVnYlhPNDhRL2dsVmpYWVFqdmFQdndiQlpPaTlyb2xM?=
 =?utf-8?B?eWFWU24yQ3cyc1hHcDRnV2x2UTdaUmlKQ1R0NjU3cGFYMWkrQXlGNDZuNXpX?=
 =?utf-8?B?UjN3dWxiQVpmVzAvcHlrSytJbDlMMHhCZElsZXhBOUFVQTF1TWYyRWNaNC9Z?=
 =?utf-8?B?a2tIclZTdkNGaDVFS2lEeGx0d2hYYlRJd0hZeHdsb3RIdktqZDJUcXUrSWc1?=
 =?utf-8?B?V25JTjk3YlZnUmxoZmx3MnpWUmxlZHA4WWI4L1YzVG5zTXNpQWlrYUlTM2lo?=
 =?utf-8?B?emtyV3F4cVlRMkx0cUFoZFd2V0d3U0pCaEFna1pkWVhZdXdkTEJMKy9qb0Fo?=
 =?utf-8?B?bWpLWlJ5aDczYWtpVFl5Mzg5YWtsZEY4MXEwM2hWd29XRDlmenVia2NDMVRT?=
 =?utf-8?B?aVJIcDVuUkVMN1N3UUZkekE4ZjQvcG0yTDV4dm51aDlmT29VTGRJV3JrNWVw?=
 =?utf-8?B?NUpBOXdMbFpqU0x4WWpLdkUwNUVxTkVNQnMyaml4dFF3ZWhlYndFeWZmTTIy?=
 =?utf-8?B?dStnb2pxaXVXVGF2Q1NQamdSSmpCdkE4U1lDUmd5L1I4SklPWGVmTm1IWVpv?=
 =?utf-8?B?TURjNDZ4dmZKSHZkaVQvQkJFQUFIUlZ3VjN5aXFrQ01xc3l6TkJyLzROeHc5?=
 =?utf-8?B?QnB3N1BoTXJPSXpNR1BDUHBuNmxSc1E1dmhJc3BGNHViUkZzQWx0YUNyYUhJ?=
 =?utf-8?B?MUt5MnJlc3BYY1NVTTlQVkpzdkVxTEYwNmVwNjBSdWxJRGlNZzZWTXhPb3RQ?=
 =?utf-8?B?UUl1MG1LWU5mUUpxQ2c1cUpTQXh0M2RBZnA3ajVKVEI1Z2IxZEt4WUxFYzJ1?=
 =?utf-8?B?K3BEQXdBdHhuS3FNbnh6VFRIcXVrSit5N3FGNklRRU9QMHZtZWNyeGpHWXVY?=
 =?utf-8?B?alJISmd0YmcrRWJkdW5sU290OGtxNEU3YlhzcDlzQlZYNHVNWEZaUGFvdTkw?=
 =?utf-8?B?VE5xYVZ4MnlnNWtzenhFdnVBMHRTREhyN0JROWRMbWRXS3JyQ2FNYlFZNEV1?=
 =?utf-8?B?VWZQVXBzY0xzcDZzYWl1UWRHZVdXcWVKV2g2NklydGlVRCt1TFRHeVNFQkkv?=
 =?utf-8?Q?BMhQ8Qs8ZlCuCRCx1t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0499b21-1ec8-4b75-6b5e-08df493f3285
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:53:09.3114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlZxvMbnqyx0B6pKC8eIScmFbp7xBIruUsZm3cQxjyACJT8Ydn1iD811//w7EqMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 19:44, Lizhi Hou wrote:
> 
> On 11/20/26 04:32, Christian König wrote:
>> On 11/20/26 03:35, Lizhi Hou wrote:
>>> Zero sized buffer is not supported. Check the buffer size and return
>>> -EINVAL if the size is zero.
>> Oh that is surprising a zero sized buffer shouldn't be supported by DMA-buf in the first place.
>>
>> Doesn't DMA-buf check that somewhere?
> 
> No. I built a local test to reproduce.  The test driver calls dma_buf_export() with exp_info.size=0, and it successes. Then, import that buffer and get the stack.
> 
> It looks other drm drivers check the size as well, e.g. drivers/accel/qaic/qaic_data.c, qaic_gem_prime_import().
> 
> Maybe it is better to add the check to dma_buf_attach()? Or I can use the check in amdxdna for now?

Yeah, I think attaching to a zero sized DMA-buf doesn't make any sense at all.

Alternatively the the check could be in dma_buf_export() prevent even creation of zero sized DMA-bufs, but it is remotely possible that somebody uses this for driver internal buffers so I'm not 100% sure if that doesn't regress anything.

But the check should definitely be in DMA-buf, otherwise you can do very naughty things with drivers who doesn't check that.

Regards,
Christian.

> 
> [89432.394897] RIP: 0010:amdxdna_gem_prime_import+0xb/0x120 [amdxdna]
> [89432.394905] Code: a2 29 c1 5d 31 f6 31 ff c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 83 3e 00 75 14 <0f> 0b 48 c7 c0 ea ff ff ff 31 d2 31 f6 31 ff c3 cc cc cc cc 55 b8
> [89432.394908] RSP: 0018:ffffd04344fd79d8 EFLAGS: 00010246
> [89432.394911] RAX: ffffffffc10b4bb0 RBX: ffff8ddb05863a00 RCX: 0000000000000000
> [89432.394912] RDX: 0000000000000000 RSI: ffff8ddb084ebc00 RDI: ffff8dd94b17f000
> [89432.394914] RBP: ffffd04344fd7a10 R08: 0000000000000000 R09: 0000000000000000
> [89432.394915] R10: 000000000000000c R11: 0000000000000000 R12: ffff8dd94b17f000
> [89432.394916] R13: ffffd04344fd7ad0 R14: ffff8ddb05863b20 R15: ffff8ddb084ebc00
> [89432.394917] FS:  00007f8216e08740(0000) GS:ffff8de0c09bd000(0000) knlGS:0000000000000000
> [89432.394919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [89432.394921] CR2: 000055c3644b51e9 CR3: 000000011237f000 CR4: 0000000000750ef0
> [89432.394923] PKRU: 55555554
> [89432.394924] Call Trace:
> [89432.394926]  <TASK>
> [89432.394929]  ? drm_gem_prime_fd_to_handle+0xdb/0x220 [drm]
> [89432.394974]  ? __pfx_drm_prime_fd_to_handle_ioctl+0x10/0x10 [drm]
> [89432.395003]  drm_prime_fd_to_handle_ioctl+0x37/0x50 [drm]
> [89432.395029]  drm_ioctl_kernel+0xb0/0x110 [drm]
> [89432.395069]  drm_ioctl+0x2d6/0x580 [drm]
> 
> 
> Thanks,
> 
> Lizhi
> 
>>
>> Regards,
>> Christian.
>>
>>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>>> index ffe12a722dfe..4d7f3de88cd3 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>> @@ -1133,6 +1133,9 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>>>       struct sg_table *sgt;
>>>       int ret;
>>>   +    if (!dma_buf->size)
>>> +        return ERR_PTR(-EINVAL);
>>> +
>>>       get_dma_buf(dma_buf);
>>>         attach = dma_buf_attach(dma_buf, dev->dev);

