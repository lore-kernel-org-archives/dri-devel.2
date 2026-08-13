Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A92FC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DC810F1CB;
	Thu, 13 Aug 2026 07:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KAOunxW6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA1810F1CB
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4/3CzXVv0X9JZlf65BiArkTl659SbjkwW36yeKJu8NUlIFJPFxtad2NPzRyEaKxsOVE96HiCDIstu0XnAGwFszsNBUVDpRyjQIEcAP/1lllxDa1HfC73J+cWgcLXSDTHhgfmBqGYgQWhvLbTJDTP0DAZ/LA584BwrSgr59kzyxxf5MwA7VDZCbVAmRaOFrOxOpsJ3IKu9lBP/pntkaAijiwkzyY8SG9I2MAu20hV6NJFcRoJ11ygrUwNal8/wOTClSgiDoiTHThsVFdNtSH0zMNqfVWNAzurBWkP9Euqn17FFfyrwTD+qW9b54m7lLLXuRV4tCNwRlj05hsty6CTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbMmkr2Te5Xj+XFEun8FX9aFZfZGFeNZvxXCIR+yfJU=;
 b=fPfJHjIwX7NTe9a3b6AQgrqJF958SyvkuMtbx9tBOywtyxsAbRsVKo7FhLcGzzzmnlzY4W2UjLWZ3MqNEf2ENCRAngA3J17f32vXaJhmmrp2/TMbub86B5ZgR4zU9eOK0WX5EW61gtakZ2iOY95zbAPMrV3kgt7S9izVrUEh2gAZcsmMZ1ckW8h5lbs8fsqIzxUsStQ+Dslq5mKe7wDHRENLsR9eYSDuDjsPRlnyztAiNm6FJTPn+l3cnrBeTRmnFeefRlohgf99i3ycVHt3DxcShYktL27ko9qbeHGO6Dcd+yTUOH9LyYQ6tXzcQAI/95nVVjXTyqsqGcPYXHkebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbMmkr2Te5Xj+XFEun8FX9aFZfZGFeNZvxXCIR+yfJU=;
 b=KAOunxW6op+UgqvpgM1Gnt6byPStOd8ICzcbg2FUMF6CWpP88kStYjV5TFjPbyZlTs5/B/2ScnREta14IZep8v6mEyYr/bmINbN5MMigyeTChh8nexNGh6uYX7UYPVq1eKJWqFheCtqwamVZKnW0qkPrYXHDu/bWBWtVoyJFFnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:44:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 07:44:58 +0000
Message-ID: <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
Date: Thu, 13 Aug 2026 09:44:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
To: Lizhi Hou <lizhi.hou@amd.com>, Taimuraz Kaitmazov
 <taimuraz@kaitmazov.com>, mamin506@gmail.com, ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, "Zhen, Max" <Max.Zhen@amd.com>,
 "Santan, Sonal" <sonal.santan@amd.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
 <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d29eec-8514-41d9-9290-08def90ec62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|3023799007|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: WUDArLtoCEsNy4n0oEnJ6JeoX5uu6yc8SrFOxqPxpmypL5O9rEIfzlaOP561xQhOjl3TTG9fjA3S5TZPrkDDEQDERXJ3fDpGWcZck6jZ1FjIBpmgijUr+rzZrobSk0JOJaH8rOjtxuv6F5UCOyEjlbQ8ZEakwAoKEQMuMl9PdhY5GwoVJf0Pc9ZXx4I6ROQKMa46M0wgvNKWPM+rqbh434lHlkqqiDxDVz10iUBIagsfPWJ/OoqeZPKbXO+H1gXGFeySNDdcgPyZSnGHXKWmDJ96t3rK8wfirIqG8FU2lwcB3JIdHZAS/spoihqSeP4neyk2mmgvMz3U27mTJfu+hdCiYPr5cQ/kA27M/saNeP5tpdo9/iG+zfDmqe3nlP9ljk1/gIrOSd8QCfYuQEWw2N1h7XwezFuIolpkVU6xBJKv5qTFaGEEGr3c2gk/+Mrwa++kATCOzXzVeD6xxqGiwCco95QrRZUkjO9/e7dapMs+o6NnRAspdPdcoC0+PQN25rU3WPapLq5Qx66usIB7e+0eJ1BujfwCqu9KjZpHFysb5fscM9HBftnQLrmsIRb62oyr2vgzt7IkVma1cy8y/CCRloEF/WJCn89NkaxaUIce+8S9GzfQXmJ+LheXHKpYTRInCGsYJniPrssK//5RyjRRrd1qBYk04ClhIeckeHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNQRU5yc0lzRVlpT0Z0djB2TDFIT2RxR2RaVDdtY21uaDJkWjhtVkhkZVIx?=
 =?utf-8?B?VXF2OEw4SzFtdEd0K0luRkNIaUFXL2E1ZlNUTTMzbTRkWXFXV3VCK3RlUlhq?=
 =?utf-8?B?bGtwRGdjZktYSDRFNnRwK0hiOEtZYmVSMTF3NkFjZXUxOVUwTnBZMWs2K0V4?=
 =?utf-8?B?elRpOWI3ZWQzZVR3OU0rMHo5dk44NGRtbUhMUFBYUHg0NlZ2NkdHbko2Y0Jy?=
 =?utf-8?B?bEJDaUsrd0JNcTlnWDF1TWgyd0xyUVlnMmo4eEJUdURBRGxYZDc0L285TEpV?=
 =?utf-8?B?cXdsSW5GOVhZcGU5dytwbjNFcHh1WnNoV2t4RWd4ayt0cElIbWk4NU5BeU1Z?=
 =?utf-8?B?NWNKQmR2OXhzTHRscy9aWmdBc3F5TTNaR0t5MGJUOER0a2ZuQ1llY1o3MXhN?=
 =?utf-8?B?MG9TamVYZTlmSlJ5WnRNdkFEVjc2NHZXWHdyQTFDOCtYTjhmOUdKY0pBRTRQ?=
 =?utf-8?B?TmFuY0poUlYybGtPeUd3SjVCeGZ5ejBNek5UOWpmUElSZWNCRmZRUStLZjV4?=
 =?utf-8?B?dk1XZjcwVGplMWpTakJFdy9aT2VNS2pDS0V2Yld4dERRcXpWZC9KblNvZWUx?=
 =?utf-8?B?RGVzbTVtd0djaWk2U0tPVG03WmI0QjZGZVdxVlFCand3VzRjWGlMcnExc09q?=
 =?utf-8?B?YS9icFJJVDNEWE1SSVhWRnpUcmpodEoxTGlrejVQd21MaUxMTGxLNStBeG9w?=
 =?utf-8?B?d21VWjFUT1BOV0QvRERnN3VKZVhsaFB6c2MvT0pTZmU4SkM2YUdIM3Y5SERh?=
 =?utf-8?B?U1dqS2V0TUlETWxDdWxXVkNRaC9aZUJ5Z0dVN3gyeWNlUmM5a2dtSWtoQnIv?=
 =?utf-8?B?YjM2NzM4WHo1bUtIZzlJWm5yYzc3MnUxVzc5RncyN1VrOUZ3eE9ZVzFiNVFZ?=
 =?utf-8?B?Si9ZaURyZ0pLSjFqVUZVRlBtblczZnpyOUl2d0k2VmxVWHEvRnljOFZPdTZr?=
 =?utf-8?B?QmZUN1RjcExlczZkQnl4R3RHeTdOZjNSZmRNaksvNGlDQTVUV2FrQmlLeDZi?=
 =?utf-8?B?dk5Kc1JUMUhTbDdlS084V3k5TTkwdTh1TXMyT215REN0T1NObU1TR00xc1My?=
 =?utf-8?B?Qlc1ZEF5VGpxYUdxT3BBVU5zZDlNVTdCQW9GS2M2VzNRd09GMS9Obzl3cTZP?=
 =?utf-8?B?MHphSTJjRTdaTEpXbUd6QWFnQ0J3eEVkWlJma1pjK0VXd2dvWE5QLzYzUjlN?=
 =?utf-8?B?cXlPZktydVByZnkvM1hiQWZpRldCRlVzNWE0S0ZKaVNrSlBrL3psWkZiaU1K?=
 =?utf-8?B?T3NxOWZNaUQ4clhvdDlPblhSV3RxaEQ4NDE5Wk0wWUNlQlM3UUMyTGpFMlgx?=
 =?utf-8?B?ZldsbEduOVozSjhZcGZJQ3hLOUFFeHJvcC81ZzNBcVpOZ0luTlNrTFA5dmRD?=
 =?utf-8?B?dEVOZkFZNW80WnBFRktna2V1SHpWOE9uUnRyTlF5ZjlMNzUxMWNrU01iTFlT?=
 =?utf-8?B?NXZWb3g1a2RyWWNTeXd2SmtQcit6QWZKNmREQ2h4OURMUlEzS3VQaUVSaGtQ?=
 =?utf-8?B?MlpYSEpOZnhtOFFjWkhUMzRFRGRRdXZoRHJKbnBVaVNWYldxaGFTaFk2MVAr?=
 =?utf-8?B?MEdjNVNNUkJGMXpvY0tIUmtZbHlPdk5WNk5EL1RBNGRZY1dKSHY0dDJYYkcr?=
 =?utf-8?B?QW9uWE9nZWdnYmpDNGpUbWRoM3VpSk5SamUzWlJGQ2dyNVhSYVp0blBqQ3Vm?=
 =?utf-8?B?ZW5OOWp1SDBsdTFIZGF4QzZiMHhiQ3V0Q2ZaTVBUVTBObjNkeVRpS2hSN3lX?=
 =?utf-8?B?MzcyS1hYZWdra082d2w4bXpHVnZOZzZLeEZnZ1JGNkdvZkl6VnJMKzk0cjZk?=
 =?utf-8?B?ZWg5Zk40V1NBYUhZK3VkVDQwa0xpOTZmZ0ZYZVF0R2QyWklQM2pEU01XekdN?=
 =?utf-8?B?UzBuNUZDZy8xcUNaN0NRRitzK0pOOW1rTncyaTB2ZXEzZXRycTJaRzJZc2Vx?=
 =?utf-8?B?V0hCMXlOZEhwdmFTanEwV05GTnRFcmltM3YydXAwSXFRMkkyYTMwcU5yY1R2?=
 =?utf-8?B?bVZXWnZLNFJMZmNZbWNPMDBqQW84MkgvbS9oWFhqYmxJeGZ6U0lIUTVjaCtN?=
 =?utf-8?B?d1JEYmw3aWNYUzFOVlMvWG1OcUVBaW5iTW5qVkl0bitWb0xvV2ZyeENGRTJP?=
 =?utf-8?B?OGtuRDZvOVVKL3BzaEFmdTBaaEZSVjYzT1F5bkt4TjMzcGU3MVo0Y05HakRl?=
 =?utf-8?B?Wm0zYVFQQ3hxYTgvbEtUZ2F2VW1sV0hoSDlHUVJzR1BtaGlEdVFmOVNLK21I?=
 =?utf-8?B?MnluVmJuTHJKQnhxMmJHUFY4dEhkeXc5enNTbFRGdzdVNmJqOUtwcUhLaHJ6?=
 =?utf-8?Q?713yHgTahW7PXFzY8e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d29eec-8514-41d9-9290-08def90ec62e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:44:58.5911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5L4hFvPdttVPY6RWcHDP5tgVuDU2czADhOgYHkUugCd0E7OZHFE4xP2v6f3Whc5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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

Hi Lizhi,

yeah that sounds reasonable.

An alternative would be to use DMA_BUF_IOCTL_SYNC from userspace, but that is usually only for the exporter to implement clflush or similar actions. As importer you need to be able to take the data as it is.

We have discussed before if that shouldn't be changed somehow, but so far didn't settled on an interface.

Question is why do you need clflush in the first place? The NPU is a PCIe device, isn't it? And so it should be using cache coherent memory accesses.

Regards,
Christian.

On 8/12/26 17:45, Lizhi Hou wrote:
> Hi Christian,
> 
> Thanks for pointing this out.
> 
> Taimuraz, this is not introduced by your patch. And the current code violates dma-buf protocol. It look we need to unconditionally return -EOPNOTSUPP for imported BO at the beginning of amdxdna_flush_bo(). Could you help to modify your patch 1 for this if it makes sense?
> 
> 
> Thanks,
> 
> Lizhi
> 
> On 8/12/26 01:57, Christian König wrote:
>> On 8/12/26 01:13, Taimuraz Kaitmazov wrote:
>>> SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours them
>>> only on the vmap path. An imported BO is tested for first and flushes its
>>> whole scatterlist,
>> Absolutely clear NAK to that from a DMA-buf maintainer side.
>>
>> Flushing on imported scatterlist of a DMA-buf is a really big NO-GO.
>>
>> If DMA-buf imports are used with the device then the device needs to be able to coherently access the underlying memory.
>>
>> In other words you *CAN'T* call drm_clflush_pages() on imported memory.
>>
>> Regards,
>> Christian.
>>
>>> so a sync costs what the BO is worth rather than what
>>> the caller asked to maintain: on npu4 an imported 64 MiB BO cost 1056 us
>>> to sync at every size from 4 KiB up. Patch 5 reorders the arms so the
>>> vmap path is tried first, and indexes the page-array fallback from the
>>> requested offset.
>>>
>>> The four before it are the ground that has to be solid first. Patch 1
>>> refuses an I/O memory mapping, which the driver currently stores as if it
>>> were an ordinary kernel address. Patch 2 adds a probe that does not log,
>>> so patch 5 does not make an exporter without a vmap op print on every
>>> ioctl. Patches 3 and 4 fix two ways the ioctl mishandles its own range: a
>>> zero length reaching drm_clflush_virt_range(), and an offset and size
>>> added to the BO address without an overflow check, one level above a
>>> function that checks the same arithmetic. All four stand on their own and
>>> can be taken separately; only patch 5 depends on them.
>>>
>>> v1 did not reach dri-devel, so this is the first version visible there.
>>> It is on lore via the other lists it was copied to:
>>> https://lore.kernel.org/lkml/20260811204556.875037-1-taimuraz@kaitmazov.com/
>>>
>>> Changes in v2:
>>>   - patch 2: take the device from the GEM object rather than abo->client.
>>>     amdxdna_gem_obj_close() clears that pointer under abo->lock, which the
>>>     pre-split code held across the log and the split did not.
>>>   - new patch 3: return early from a zero-length flush.
>>>   - new patch 4: check the sync range for overflow on a device BO.
>>>   - patch 5: say why the persistent mapping adds no pin.
>>>
>>> The measurements in patch 5 were taken with the equivalent change in
>>> AMD's out-of-tree xdna-driver, where this merged as #1541. That version
>>> and this one differ only in a page-array fallback mainline has no field
>>> for, reached when the mapping fails and the BO is neither imported nor
>>> shmem backed, and in the name of the mapping helper. The flush and the
>>> helper are otherwise identical. This version is compile-tested; it has
>>> not been booted.
>>>
>>> Patch 1 is from inspection rather than a reproducer. The exporter I can
>>> test against is amdgpu, and amdgpu is the case that cannot reach it: it
>>> implements .pin, so a non peer to peer attachment like this driver's
>>> forces the buffer to GTT before anything maps it. Reproducing it needs a
>>> GPU whose exporter has no .pin, which I do not have paired with an NPU
>>> here.
>>>
>>> Taimuraz Kaitmazov (5):
>>>    accel/amdxdna: refuse an I/O memory mapping of an imported BO
>>>    accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()
>>>    accel/amdxdna: return early from a zero-length flush
>>>    accel/amdxdna: check the sync range for overflow on a device BO
>>>    accel/amdxdna: flush only the requested range in amdxdna_flush_bo
>>>
>>>   drivers/accel/amdxdna/amdxdna_gem.c | 66 +++++++++++++++++++++--------
>>>   1 file changed, 49 insertions(+), 17 deletions(-)
>>>
>>> -- 
>>> 2.55.0
>>>

