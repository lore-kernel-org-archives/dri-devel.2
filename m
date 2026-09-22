Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D115C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E3F10ED02;
	Tue, 22 Sep 2026 14:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mkzsc5xs";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2C210ED02
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zInCHj/uzRXrVB4rXEyPTfOaY2xJWAb4JL1G/V/YZJjTz8lqpVTd6gKjPoVh16Jg/To2ImZabzPhjbkm8Vp0urUOD76dhUC2Dq7NI3u1H3Ra0LlA6G1R/1X7e7yaHB6qaJsqr0Yk1rfik7iIG0FxtACdzefPdPHIutKiMYTqoSdo8Le0MOZIpsTxyK81yJ4GF0pVXWUJWrkRPbQB3IWJuMKxaf3Ii9nM8+XY0Cyth6ZNNIBgszsmDvzBOyhv+Oo0Q/i2ARiQICGyjDA0e73tCuoY8Uq7x60xkKBKjCF+QKOiWTf7oipFBHFsn8DL18/oUfDVIlYruO7HMz/VljDCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmfxcMJpsGagKTcMCCmrxPASfA/jFxvekumoINY0hd0=;
 b=TcCOM41O38gG+4j5eSmBepkaQBTAZdetKeWTaEVViTh84tOJg4jxWCjDiXrzUn4UCeLTTs1j6RwK6iVRL4MOqpxz7Eu8qw3dyK9iQPahDDoyvlWeoNtvLALhl8eSv0aoLkjfYDo6YGww7IlfrhKkAtbjz6n6/vUlDsz36S1C2PL7NULE3fH87WiafQW2VcozxV+0m7EwRvKPgesmSrj5VfbhQfR+CJJLvkpdYlNXmG+kFoyMqKBNvYQNFnPpF4QhTLiWV4iZ/yA7AMlF0HSsKcW++ypFtOV+Q6GbXv5U/AFTyTEUKN4bSZD3ROd3KppcLjoqjY8MQ24juarpUk8eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmfxcMJpsGagKTcMCCmrxPASfA/jFxvekumoINY0hd0=;
 b=Mkzsc5xsA60+aBUOl7tXPyLmsI9fy7ttnM+gYkLMUGG++fZzatElmoRCVHafCA4BEMFzGav6lEOlN0x/BMr9CVZP/FZHWXNjk6nkvT9YgF1vOTf6gHPfzUWaqa+/sgqOLxREbwWuN6v4akcQH3Ujo2oeGbqhHEGLH17U3F/SsAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:00:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 14:00:33 +0000
Message-ID: <f646d216-2c8f-4773-a4e9-f7aec0a19984@amd.com>
Date: Tue, 22 Sep 2026 16:00:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
To: Robert Mader <robert.mader@collabora.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Xaver Hugl <xaver.hugl@kde.org>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
 <77b5fa08-6c95-4f9d-a12e-5ddca3c1c1e0@amd.com>
 <IA0PR11MB718502111B354D893D71FA0CF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a6e77fdd-52b9-4701-a677-c984ce534c42@amd.com>
 <e60fdbae-293c-484a-bf3f-2d8b2d136b7e@collabora.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e60fdbae-293c-484a-bf3f-2d8b2d136b7e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ffcfe2-da65-4db3-628c-08df18b1de52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|3023799007|18002099003|22082099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 06gWT1d8xl5EN0x8sxKIlY+yRRDrvTg6Np6WDeTcYdYZcFNIJFM0ER1zI8S+SJCzwgGvliCq7sL3neknLawuFrHO1k1dFlbnaWH2h4qp4nbZINnbYZN20q6MlgehPDZ69UDL8z8Sj7frwwkh75hnABtBS5j+vAsnMGH7iMAFDgjA5zm+pMa3vPk0ZW5ALK3o3kdzRFcOeKRZ4phWWlFZjVbvTpfOEs4U4deWTJ6uXxeoEJ2eQLz08YEG62EtuuTny+baR5N79s3f9YMattCw5dja1TleH2UZ6B8Eu/ZX9zRDkpas0Jsg2tK7UAJVtkADEA3UvXA5eMrWGYbPBD1vvi/yAhMp1TQ8/Jvg+lEpClaPbZ0BvKynedGeB4lILuW8wRyQTyJLWlNHPn6JG28tO1XQ+MyKMw+8b6e5rp308VRWj/cSTeFWPOQ/u/3AIQDZ8PkwqK+7C32d4v0BkfQHYtdyjvViBZNx2RGExpwTs34RFHF2w3QhxAebwzL1mRPIxr1IMWpD4gKYkLQttD4K/MOn6VUyMniZYn/cxdLwGUI2GfkRRoN6wF3ts1TO6A0r3NNWkbgpl3YcgPL9DVdgO38Bg1/exjmd13uXMpLPoZfRLIbsnNp+5McXk3cAKxXBc/hv41HOU9juUnNuXSS8AYEk7jBK/DxJVAFkKRE56l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzE0NGxBd2hNLy9zeUJNMFlWVVprUis4NGdtZE9XdE95TVZKeU9GY3Vva0lM?=
 =?utf-8?B?cmhoTTlzejZDdDBobXB1YllBMmFKNEp5UmZCTENZdlY2dGs4NllvWmxMYXpL?=
 =?utf-8?B?ZGcwd3IxeXRBVHNxU2VzSjlobzgxa3c2Z2ZoamZuOEYxNkF1U21YQithVm5H?=
 =?utf-8?B?dDlidGZzSC8zYnovRVZDbVg1R212UTdSS29xby9BcSt0UmtwYzdBb3psQXlU?=
 =?utf-8?B?QlB1ZmhJMk54Vmh6ZVZncmY2bWhaQ1VrU0xZS0JnVUVtZGl0cmV4K1REb2tY?=
 =?utf-8?B?UnBJaHAzSDZMd0UwcVB0ZGNQUjhCdGlVUVZXelZqQVVrTlJ4L2oybjd3SVBH?=
 =?utf-8?B?YitzR2kwa0ZaZWFKYnphSzZrUzlVNUtwY28xNlVEeTFmVUlZSnl6YVpxdW9s?=
 =?utf-8?B?WDB3RDU2cEZsL3YvdWZ4UkN1dVJraFhMY2tSN2pPbUM3WW5Oa3lOSlorZXFN?=
 =?utf-8?B?OWVjWEcrcndqcHlQMXdsZmJFVHRyRTdjb3FQTklkekg2OXF2M2QrazRLUmh1?=
 =?utf-8?B?ZjBHL281YjJWVEtxNjlxNDV4VVBGNmhadDJmbS91Nlh1cTkvYlFIOTNrTVBj?=
 =?utf-8?B?eWRsSHEvNFgzak1lQmkzTzRLc29zZ2VVSENvdEVPR2h2eUh5dTRMMTRSaTRI?=
 =?utf-8?B?bWRScW4rcXJ3dFlaSXE4eXJ5Um1CWHAyMFZrdXNlclJDUVAwMytZK1Fjb05X?=
 =?utf-8?B?c3ZWOTJNTUU2WVVGTmNCTDd0WTltNWZZMEU4YnR5OUhkVkpsbU9CNk0rOVJ4?=
 =?utf-8?B?NUFRKzJ6U005RWtUbTBoSWpFZS9hU2NhclAzbzRrUkhDYjZ3amYvdXdxUm9i?=
 =?utf-8?B?ZkhiUTZqRFVZOG5mbmpjNTV5RzhxZTFDK05LN09vaXVlMjlGdnBSUGZSZ1VV?=
 =?utf-8?B?c3R1R0dJM0k1bG4reFNkQlpnbWVQMDJvT1BiKytYYTlvcDBqdm9RUzJXMWJV?=
 =?utf-8?B?YU5kNmZlaGZFQU9zTnFhUEhNdTV5N3ZUenNqQkZRVW1Nam00cks0bFlGL3h3?=
 =?utf-8?B?aXRzL09YWFZVWWRTSklyd1FmQmNKZ2dtQWEvTmV2azhGQ1dmS2gyd2NFTktm?=
 =?utf-8?B?cWc5em9sVXo1WGZnNHVIS09WdWxXZGRueGxDSVo1ZkVJSEgyakhuQVBNZHZy?=
 =?utf-8?B?L0dCUWVCK3NsSXV6a0x5RkprTGoyNWJOYTFnVGZtUThqb1FxZjZRaDJUMzBY?=
 =?utf-8?B?SEUvamFwM3MyK3RXZ1N4MGNVcy9HOEFLTFNrVE41b0FjVkxjVFRFcFRMckRZ?=
 =?utf-8?B?bUVzZDFGaUV3OSs2cFZRM1FEdmZyTUFnQzlEc0VWY25RLytWMk1VWmZKM0I4?=
 =?utf-8?B?Q25RMExLNTJSMkhUR3RlNVRnY1FqUEZ4cW5yWUx0Zzd5ZGcwa3BPOEJBam9J?=
 =?utf-8?B?YXo3MzR6Z0VyRnA5SnNoSzU5blVXVS9MVHBLQzNEeDdyUjBwUzdSU2U3eCto?=
 =?utf-8?B?dXZLb04zYm5iakhRbjhNa2VxcG1BUGxCdW9HVWtwSGhRWE5SMUEzVFFpeTZP?=
 =?utf-8?B?b1p6WXRxaU9ORk04SGRFY01ISkxaejFpR29NM0kydEVUSWlydE5Eb2FESVVy?=
 =?utf-8?B?cUd5MWZrYW5NQ1ErdFdWVU5Zd0hSbi8vQWV3ck1nbkRla05IYnZZNzBFQ2pK?=
 =?utf-8?B?dEFOemdWMjlVMmtTR0ZwQ1AxNWtSM3NuVzBibEJGTWVSZGx5Wk9LeDV5bWVo?=
 =?utf-8?B?djVSTjJRRm9QWm9rNUlRRjBScjZtRDdiaDc0MmU0d210Lzh0VXQxQmsyMXVk?=
 =?utf-8?B?WFVJUU9yM2xVaEpWRDFzS2NHRTVkZ1dPQzBjWndzSk16VVdERGd2TGdBZldC?=
 =?utf-8?B?VnVMdUNXQkZlaGJXK215WWdTNjdpZFVTaFFHSWhLRzZMOGNYWkVHMFBOQkR2?=
 =?utf-8?B?a2pyS3hPRDZWRVdZdnFwQVNxZGFqT0hMSVNVRHR5WmlON3pLNVFRbWhPOGtk?=
 =?utf-8?B?S3NDY0pIWk0wZFdIN0ZDeW4wenBqVjEyOUcvVEFiaFBZbkxYYXd1d2M5bk1U?=
 =?utf-8?B?Y3Z2UHlTNTJYOGlERnFnNDN3a05Ua2lvejdtN20xanZTdndRQlRQNXhkd3pP?=
 =?utf-8?B?aDlNVUN6Ny9MaEdzY0FXTnZ2emo2bnk5WTd5cnJId3AxN0lCMXFGM2NjNzRR?=
 =?utf-8?B?V3FwR1BDeVI5dnpPOUZGd3JGTTJEUDJWNHN5eG1XOHMwY0p6VnZ5NXNZcVVw?=
 =?utf-8?B?YTVaOTRhMDRUWDdmM1pMbm41M0ZJWXFwVkdZSitZK0NwWVZQMGI5Z2lDVDZ6?=
 =?utf-8?B?elc5dGlvWWxjbWUvbUlXRHEwR2JPQndrSjQzdm1lcWQ2VG83azE4ckdRU0F3?=
 =?utf-8?Q?kGoUevwFBic8CMumnC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ffcfe2-da65-4db3-628c-08df18b1de52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:00:32.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdxXFS7DwPHeye0RNkAZOkW85ZZUTTIBNmcAR1hEHaFBRAyMPl0MStkK56cSMjHP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On 9/22/26 15:40, Robert Mader wrote:
> Hi,
> 
> On 22.09.26 09:33, Christian König wrote:
>> On 9/22/26 07:19, Kasireddy, Vivek wrote:
>>> Hi Christian,
>>>
>>>> Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for
>>>> udmabuf pages/folios
>>>>
>>>> On 8/31/26 08:00, Vivek Kasireddy wrote:
>>>>> Since udmabuf allows users to pin pages in memory, which is a vital
>>>>> resource, we need to ensure that unprivileged users cannot abuse
>>>>> this feature to exhaust system memory. To address this, introduce
>>>>> mlock accounting for udmabuf pages/folios. This change ensures that
>>>>> the number of pages/folios pinned by udmabuf is tracked and limited
>>>>> based on the user's mlock limits.
>>>>>
>>>>> If an unprivileged user/process exceeds their mlock limit, no pages
>>>>> are pinned and EPERM is returned to the user. Note that, privileged
>>>>> users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
>>>>> allowing them to pin pages without any restriction.
>>>>>
>>>>> Earlier, there was a 64 MB default limit on the size of udmabuf
>>>>> allocations, but it was removed in commit 44e9eb5a7621
>>>>> ("dma-buf/udmabuf: Disable the size limit by default") which left
>>>>> open the possibility that unpriviledged users could pin unbounded
>>>>> amount of memory. This change makes the limit dynamic, by invoking
>>>>> user_shm_lock() to check the mlock limit for unprivileged users.
>>>> That makes no sense at all and would create a massive problems.
>>>>
>>>> The mlock limit is per process, but udmabuf is represented by a file
>>>> descriptor which can move between processes.
>>>>
>>>> So this here can be trivially abused to account the allocation to one
>>>> process while accounting the free to another process and overflowing
>>>> the mlock housekeeping.
>>> The goal is to have the mlock accounting be tied to the exporters since they
>>> are the ones that pin the pages/folios. As Sashiko identified, this patch doesn't
>>> quite do that but once fixed, both alloc and free accounting would be attributed
>>> to the exporter. Would this idea not work?
>> Most likely not, no.
>>
>> First of all this is trivially circumvent-able, you just need to create a child process which allocates and exports the memory and then gives the fd back to the parent and dies.
>>
>> The result would be that you have accounted to the mlock limit of the child process (which is now dead) and then a dangling reference to the cred structure of a dead process. Both are most likely no-gos for this.
>>
>> Then the second problem is that you often have processes which allocates the memory on behalves of another process (display servers for example do that).
>>
>> The fundamental issue is that Linux doesn't have a way to track file descriptors as they move from process to process and so if your file descriptor represents more than just a standard file on a file system you run into tons of trouble with resource management.
>>
>> Regards,
>> Christian.
> 
> I'd like to quickly chime in on what we IMHO would optimally want (from a userspace perspective). Some context:
> 
> 1. Unprivileged users by default don't have access to /dev/udmabuf

If we have the normal DRM render node group that would be ok for me, but could be that others object.
> 2. Since https://github.com/systemd/systemd/pull/33738 systemd grants uaccess to graphical users - i.e. if I'm not mistaken only the users currently owning drm master should be able to use udmabuf (or something similar)

No, that is not correct. If I'm not completely mistaken everybody can access /dev/udmabuf at the moment.

> 3. When owning drm master one can probably already DDoS the system in various ways - so probably not really worth to try to hard to defend against.

Well without cgroups even regular users can trivially cause a local deny of service on Linux.

Just try the following code:

char buffer[1024];
int fd;

fd = memfd_create("Test", 0);
while (1)
	write(fd, buffer, 1024);

The OOM killer will kill every process in the system except for the offending one. Background is that the OOM killer can't see resources locked up in file descriptors.

> 4. An exception here would be sandboxed apps - e.g. flatpaks. Such apps get udabuf access if they also have dri device access (https://github.com/flatpak/flatpak/pull/6158). Preventing these apps from pinning unlimited amounts of memory would be great - however I guess this would require mlock accounting on the level of cgroups. Is that realistic to have by any means?

I don't think that this will work. Pinning memory is as far as I know not seen as something problematic.

Regards,
Christian.

> 
> Best regards,
> 
> Robert
> 
>>> Thanks,
>>> Vivek
>>>
>>>> What could potentially work is to grab a reference to the cred structure
>>>> of the allocating task, but that is also not the nicest thing to do.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>> Cc: "Christian König" <christian.koenig@amd.com>
>>>>> Cc: Robert Mader <robert.mader@collabora.com>
>>>>> Cc: Xaver Hugl <xaver.hugl@kde.org>
>>>>> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
>>>> default")
>>>>> ---
>>>>>   drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
>>>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>>>> index 7c4339130eff..e78947f01656 100644
>>>>> --- a/drivers/dma-buf/udmabuf.c
>>>>> +++ b/drivers/dma-buf/udmabuf.c
>>>>> @@ -203,9 +203,10 @@ static __always_inline int
>>>> init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>>>>>       return 0;
>>>>>   }
>>>>>
>>>>> -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
>>>>> +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf,
>>>> pgoff_t pgcnt)
>>>>>   {
>>>>>       unpin_all_folios(ubuf);
>>>>> +    user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
>>>>>       kvfree(ubuf->pages);
>>>>>   }
>>>>>
>>>>> @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf
>>>> *buf)
>>>>>       if (ubuf->sg)
>>>>>           put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
>>>>>
>>>>> -    deinit_udmabuf(ubuf);
>>>>> +    deinit_udmabuf(ubuf, ubuf->pagecount);
>>>>>       kfree(ubuf);
>>>>>   }
>>>>>
>>>>> @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice
>>>> *device,
>>>>>       if (!pgcnt)
>>>>>           goto err_noinit;
>>>>>
>>>>> +    if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
>>>>> +        pr_warn_once("%s: User not permitted to pin more than
>>>> %lu KB "
>>>>> +                 "of memory, either increase ulimits -l, or "
>>>>> +                 "obtain CAP_IPC_LOCK capability\n", current-
>>>>> comm,
>>>>> +                 rlimit(RLIMIT_MEMLOCK) >> 10);
>>>>> +        ret = -EPERM;
>>>>> +        goto err_noinit;
>>>>> +    }
>>>>> +
>>>>>       ret = init_udmabuf(ubuf, pgcnt);
>>>>>       if (ret)
>>>>>           goto err;
>>>>> @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice
>>>> *device,
>>>>>       return ret;
>>>>>
>>>>>   err:
>>>>> -    deinit_udmabuf(ubuf);
>>>>> +    deinit_udmabuf(ubuf, pgcnt);
>>>>>   err_noinit:
>>>>>       kfree(ubuf);
>>>>>       kvfree(folios);

