Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D4DC982DA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B1F10E160;
	Mon, 21 Sep 2026 05:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QyKJCIS+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E50910E0DA;
 Mon, 21 Sep 2026 05:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzYrCaKDwjVznZscuBYTgmQdf8gyqbpGjfzaex/iD79HU577jQzD7EdKTgB2MHvBOyjd87QYj7uj2kWBFx1dlldgSchkAo8Nhin6n9nA6Ien0Q4trbiO8/0Imjw9vti4BLjOFqEiJFabyyQ2WtC2FemrkJdNYIBx2pJpaF9wCvem4HAr4hSwR5FhO3NHddMP0ZtGNK2fBXdUrzk08RkZ/m1wZNbpoKeu/YlhBKBe8mmzWk3j0kmgbnKzna9h/iZEdS5+jisdjLEkMwo0IW/aRYZ8o8NVaH/4VQfS3Z298AcoAbj2DG5h7JzPl7PcRU/dOfMmc2SRNF9s7ti9K0IHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcadPfdBScFuFCSlmdwnN7Yuvb3lX7en5Bjp8EJNeaQ=;
 b=Oo/XGStMeAd24OQsBJ4jFdpS03gY6k8eqTS5DNnZ1NbQXrFDstH90Cf1WmEOIpBZueG4jInp5IElWLszSu4BCqY8RwhccvmrdsCKodt9iDBdED43SVb3nlAlSTQnGPHMGk3RLXXf8PEW6prrCaweuBZxsrqfj74+02dHDoX8uWuxGt2Zl1XaUeeMvA5xZAICs9wcYLkgDUTji3Y3xo8mpf9qp9bJhfTfWy3NTdiSAUUB2wn4Kluaj2zMV1vMGy7zSh6RpqKNQuVR8FP+9xVqO0PhxbsAUy1Gm1/Az7MsUiQdO5v3ahKTRSUpB88q/4D8nrKkDp/AciC7SC785+egWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcadPfdBScFuFCSlmdwnN7Yuvb3lX7en5Bjp8EJNeaQ=;
 b=QyKJCIS++fauZObPl+o0jtj/e086Vc3bpF80n11CgQ+YzfkNFfPcfwy33e+jJJVJ/R7fXW78zzRtUkMfNLwrXK1jo/pVrVvAilQkSGAX8SVKP3ezFfHDLDQ2xy1ksMsiilk7dG9e7+4hUAPCiWSvku5TQOhtFsP1qvg8J+kevek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:08:25 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:08:25 +0000
Message-ID: <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
Date: Mon, 21 Sep 2026 10:38:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix IP instance memory leak on kobject add
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Tim Huang <tim.huang@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260919165511.3687822-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260919165511.3687822-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: b14a7cc5-5653-4aaa-5c46-08df179e5d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|921020|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jv0NZbY0CbNZXwXTv5LVMiqXdaO0etYudp57JYVwfcgLFjcPSBR4WCstVEFKRZM2cSbiO8ki7zy+p4gV8uqgmYiLHASTMOlkR9qFBwb3OJ5GY12E1+l5tM+cDBx09Y2PaLMf3C/yY96P55i+8V6Gh/mQgpKA+dR4buky77PtBW9cgNHQErgl80L3xXeSDY2bu/+wyPko2jrC/gO6AEGvO6xndnqDbX67wHVilrBrhvlzmnJPqjfyq2vUaqRVtiaSCIveHLulIQhA60qG7iyV81IZUb+19WC8eKEFE2L3XKIYNTzUMg8b8yI2njR7ZEHz0UxLTEBCuELON0Cj9pnsq6sxakmMUurlzf3l/sJCY/RKZwMXmCuAzrZK2R9r/qylgCC+Hc80h97PKgcEOAvn4iAONMhRzrxS2cxLRqA1r140u16+qh72So28iKT8sGzrx1D2+QryAZFkpPsQnOSy85ZyFjkkF/Ic+atKEg3aLlMJfANsnBkUwfd1dGg/mIEQP9A1iP7Z40Gksmotsewp+WYaRL89zAjkwfki8pe10/2hVZ0/tSfhPoE5qdnCRmq+BjHaWP+BR1HX5Qy3oivSUd5/wa3Y1rcQQQrM8FT5ycmFeDITwLUI9WeIOBhK2BLxHpdWOh5LRkld/lhQyeyK0AIHxmWIoAJjDt4ZcV8sm/mjytnom+lY10wQrlNufxl3bOBT669ZkRJL703BCnoEsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(921020)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFSNWVsYW9Sd0VYM0lVcjJwMnFzMXJVZTFjbVNqUDc5b29hZ3NyUVU0Yk1m?=
 =?utf-8?B?aUJmSkdiTUJNZTlzZ2tBVWQ4Z3BSOEV6bnNCZVFOVVNrZ1EvcnUzcDEyV3pt?=
 =?utf-8?B?czNEN2VXeFo5enozS0lueU0wSlhEVmYrVkp5ZGE0bDYrQnlWbnVmcU9nc0sy?=
 =?utf-8?B?V3c2cXdmZ1drSXFoSGRXV2ZWaVpoRTREWFA1TnFsSEtNM1MxV3dmWXFJSVRl?=
 =?utf-8?B?d2hVVmgyZnhGc1NUNzJxV1RqenphWDZEelJhcnZYNUxYSXd3cFlUV2Y1c05p?=
 =?utf-8?B?VVplVzBRYTVNdkkwZ2Z4emt3TlFlNmw5a0lpSXl0QmNkU1RtckdPRW9UUGxT?=
 =?utf-8?B?Z2pDcXZWcUVoRkJQT3YvK3VXc1FSQVdIYmdWbHMzdmFLMFRWNld2cWJxOWRp?=
 =?utf-8?B?a2tBYzlKZkRITWdSNFFxOFNoNXArS1hNYzBjOGpuSEgwZk1LeTMxTWNRTUNn?=
 =?utf-8?B?Vkp6cFZHRDEzQUd2dmI0NDd3emlGSGdJUHhOcGFxU3ZMbkdueGYyS3prc2U4?=
 =?utf-8?B?Unk2WG8rZXdpdUVqQnhCRnROaEVFUTM4VmJLSW1hTlIzZzVQSURJb2JBY0pv?=
 =?utf-8?B?TndXQWNvSHJIQlcxZ3ZFY2lRbXdyYVJucTZKRld5ZSt3d0JtMnMxVHA4d0ZO?=
 =?utf-8?B?S3FpMlpVMjlhSXQ1bi9qdmJFU2xxcTRqZWRxQldPVUVVbnVDMmM2WWQ0TTVk?=
 =?utf-8?B?b3BpMEh1WmYyZXd1TzJFdVpGbFJNbXIzSXFhRWxUOXJqY2FpQ0dTUTZ5eU1J?=
 =?utf-8?B?MC9oQkFQTHVCVUczY1FYU3k5UlBlckJoQTFxRnpNWVM0eDdsdExMQW52TDJt?=
 =?utf-8?B?R0JBTC9UeitNTHJSa0tvT2M5WDNkVzRodGdtVlF6OWRXY3oyZE91ekJpdktk?=
 =?utf-8?B?MmxFVjRpR0tyR1orcVpJZ2doTkhDOXlMSWtjZXc0S21UWjF0WDVJQVBnclhS?=
 =?utf-8?B?TUt3UXY0cWYxaFZZSTNxbVd0aTJMMktUNUNSUERXb3ZWd3IwWFhpVENQOWlt?=
 =?utf-8?B?NGxzc2EzRmJxUjI5dGQvai9JYjBMeVgyQTFHY0VOb3YxbCswUXNTWm10eksx?=
 =?utf-8?B?amNhVDJ2U1grSzQzUWIxakFNZUZXTnlnTXVRamxwVDlaQ3YvS2FJV1h2UXh5?=
 =?utf-8?B?U09Zb2xsa2R6MTBiSEh0aEN2QnZ3eXNEcTQ2cVBaTk9vMTQ4ZXRHKy9XUXQr?=
 =?utf-8?B?bzNlR1pJbEhVcGhuak1lcUNZVnlZcHVlbHBIWUdtM2pxemFkYTlwZWtGV05l?=
 =?utf-8?B?ZzVPZGtodHZlUlBtSVIxelVuTzlZWWMxbVV6U29XeVhtQldNSGFVd204VEVp?=
 =?utf-8?B?cXJ3UkFpSW50Y1FWRmZaYjdVUzRJeno4RVpTeEJSb0NqTThEaE9MTHZnZ0xJ?=
 =?utf-8?B?L0REYmVSelNGcDI3bFI2SFp3RnBVbWVNNDdOL2krTFFoYS9DTUZCNlJROUlk?=
 =?utf-8?B?R3dESENJNTJUY0tWNitGdTBaSmM5SDJHSlZ5L2dqK3BCaUJsazhVTlN5R290?=
 =?utf-8?B?dDE0UkRUR1orcGlDVU50bW9QUmhINmN0TXpyaXhYTmQydzhiODAwQ2xOSERk?=
 =?utf-8?B?Y3c1VVRSVi9EaWRoa3JWMzA5d0JXM2ZGUGpKVTB5U3B2NlRwZE5tWUVYQ0J6?=
 =?utf-8?B?enFJWisxUkV5aGZpRk95U3g3bm1odTlNZGZFc3I4WFlPN05SV1BUMzlReVFj?=
 =?utf-8?B?SEgwM0Y1V1B5ck1WbXJwZG9UaXNKZVRaYXBxRG5pZEdKWGRkbVF2QitDWFh3?=
 =?utf-8?B?dWxGTTdGck5zcWlDTURIcTlFM2k5QkRLVEFQNmQ2cjdlRHVtMVFISFMxRmtC?=
 =?utf-8?B?ZlJRVm9uQnBjRTRaVnJCTlhDakRZVGdPU1ZGa2M0YUtOUkpXcFRVb216RFlh?=
 =?utf-8?B?VHJ3TS84OHNhVmNtMDVpZnB4QUlUM285SlJ0M1IzZEM3SFhYUytNMEFUN2h0?=
 =?utf-8?B?UmVqazdrTkpjcWVtZjVhQ1RkZXdodDg5K3d5L2VRaFJ6OXFpekZDSGZKV2sz?=
 =?utf-8?B?NTF1ZlNSTmVYcllwMFRqQU5qa1Rkd3pwMUxHVmd3YkluandYWXhrVzRERC9s?=
 =?utf-8?B?UEZZLzVnRUh1dXFzdmM5bkdNQmFzako1VXNTVUtEcGZVbm1XNWFPd0FSYWE3?=
 =?utf-8?B?bUtvaXlmbERtUW15RXg5cHh0eHBkT0lXWjJPUnVxNU42NXd6SGd2TkxxUnZx?=
 =?utf-8?B?bEcxalArYmxMcGRUbmgxTjZlSm5xNTRUQ05Od1ZTUm1oNVpPUDJMRkpoakpz?=
 =?utf-8?B?T280dFRBODBtNk5VOWV6WS9ibHplVHZuMTRuYWZBMkZkSWozNjF3RXlPQkc0?=
 =?utf-8?Q?TIFjs+KYuHlIiA+9n6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14a7cc5-5653-4aaa-5c46-08df179e5d69
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:08:25.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le4HTKDcj66y8JepkJPyWrm3rmUPi3gwjT84FjO+b0sgJXeLVwExmXUXzf0qMe3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
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



On 19-Sep-26 10:25 PM, Guangshuo Li wrote:
> amdgpu_discovery_sysfs_ips() allocates ip_hw_instance with
> kzalloc_flex() and initializes its embedded kobject before calling
> kobject_add().
> 
> If kobject_add() fails, the return value is ignored and execution
> continues without dropping the initial kobject reference. The failed
> kobject is not retained in the kset list, so the normal sysfs teardown
> path cannot find it. As a result, ip_hw_instance_release() is never
> called and the ip_hw_instance allocation is leaked.
> 
> Call kobject_put() when kobject_add() fails so the initial reference is
> dropped and ip_hw_instance_release() can free the allocation. Keep the
> existing best-effort sysfs behavior by continuing with the remaining IP
> entries after the failed registration.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a404d8aa13ee..4b1ad1c0a10b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1314,6 +1314,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>   			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
>   			res = kobject_add(&ip_hw_instance->kobj, NULL,
>   					  "%d", ip_hw_instance->num_instance);
> +			if (res)
> +				kobject_put(&ip_hw_instance->kobj);

Adding a message that this instance got skipped also will help.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   next_ip:
>   			if (reg_base_64)
>   				ip_offset += struct_size(ip, base_address_64,

