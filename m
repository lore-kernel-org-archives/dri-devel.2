Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B528C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE3810EF02;
	Wed, 12 Aug 2026 08:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W+1Cbt3u";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051BE10EED3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9ToREupCAGEcKhTgJ+9+V9lwAL6lCJRO4kkU4MU8u4C9FfAzwMzDTKvBcjxmok5Ptih+iyTuWBmeK3Eap5KtS5OmZpyo4g0AEhsbmUpAyJvayPpZ2EPiBGqD1DLo1b/u3lHs3YfwOIg78oOWKWG7EgdDnQJ0pBnr0XakodNik0FbFa/thneoZs3DGTe/OJDRZXJ0hK+PFdRygTi907ey0Clqkns/qz1E+0hsA4ZV6sqXYmhtFOrhLOodpMA8mEbDYF9SqNN6efah9TKnVVEjQZpkYNPZyaHqQ6sN62jzWy5Vb/CMJu9oAaQ8fJF7h/vZfJQb3sP472mu99/nRG/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAueGrAyytbObpMFUEk27mH0ElDFMUre/hv5UPvHExw=;
 b=wunJa2BPbJiZ3N66mXXrZDcnEFjizTgOfi395IyB2Iko+00+VuQNqlzSv9gvl5dcYsNKolKKimxbjmno6epwnmnLKW+qA5meymNL5WMTYGDD0ri3rQWrTg23mpSG/UCV3/D7U0PTnj45+oqxBtWeP5gU394DkgO4Zs1BBGae8Yf7VL5mW/ZeaOgM2uOqyWjJPLtvITy4x1GGIK8EAbF1Dc3xKJMSUpUgeh/TKWEeZOPHfdUAk5oABugMUif/zasR3eabenac6b0WaZ5FyZp9jzR2QtzvpvsZrKjLC2nvEkfvjrZfwFP57d5gKSbVRobxk1Kp1nQ3jHENTS6B750a0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAueGrAyytbObpMFUEk27mH0ElDFMUre/hv5UPvHExw=;
 b=W+1Cbt3uYsRs0rh4pgX9lp+Go847gd/quFksfCPT309MVlcFc1RPWgfQYnXTt+SizLUph/0OGLTdWLlcnl4DUw6Xv0++Fht3cWozNRmBDY8o5PRai/S8++dsAFbfP20I5feZoQKK1SVpzD+fZyzRpAJkINhW+rZWGZTs/WWwaco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:57:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:57:51 +0000
Message-ID: <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
Date: Wed, 12 Aug 2026 10:57:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, mamin506@gmail.com,
 lizhi.hou@amd.com, ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 24509a5a-78e9-44ff-f60f-08def84fca78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: e2sva9l2JRm/NpZ+n56zxDan782PXiIGm8eKAdeMZtSyMg/UpF6zf8BfROVkEwg6FUD0ZPZCEn3fI+c+lPX1BjEXMrWIMLlahdznRhATD85xiY3hfLG3Sjr9NCwoCJp+4hgbxAiQ/QH2bfudgHznBXSs8OoXZhKLd947RhAm8MlBsUOYcUSfHWa+sPD2LGU+HX8eGrZcK3gIL/TUAIdmQ4Z+DZF8D4zy5zei72pnAw5yBbTpqWzsblBc6sotAkq+6rZoz1vrRYC5YpTsvWlyl+r1trOeE5gIHKhytdeQ9lKnYokYPsoeOBs6yzmyJzcsEQc/370uZrgYbx0Hw14Dd7Ok2C1Kp+d3Y91TquDh3P0rwha96EicdApw2YVKnE0N5loDsEfR3xVnAfEQVdxgkN/T+rC4Gy5kzKxuCjkBvSZrRslXH5NiMp37CYwNS6YsArbVT+cwFouAZx0+fTyEoavgUYXClSmIVRhOPX7gikGQh9udSY7VsgElShkQd0wgWlsr2+InKZhq1Cl9HwS+SV9A2yiDfxOxrbHBY+pyzyoi8G4nfb9K7SWPiYMbbYqP00P439ABnempwqBAQO/PGK+DNjp2s+kj3fxPVT0YIAKXVaqbsPCKE+TeAExb3TFOW9+0KvdeRtQKzfnQRjXIXD40h2hEZtkS4aX1XrRvEfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVjNS9SSWVuWnloM0hENHMwMGpBRDhvZ0JSWG5NZzEyQ1hyRzg0c3p5NmVy?=
 =?utf-8?B?UUZWejFSbm0vbllpNEk5YnliNXBIZE83WjZVQU1hZDRKM29nZk45K3BVZTVq?=
 =?utf-8?B?Z2ROcWI2Ym1oWCtzMFhXd0pBUmFVYmdMbXRPY3NXTUIwSE9JNXkvSDhYWGNr?=
 =?utf-8?B?YkZlOCtLK0lUUmxNOTk4WHJqVVdTNC9TU1g0Ky82eGFkVWo4M2pzR0gyMW11?=
 =?utf-8?B?QjlLWjFTdkZZZFRvQVZuYnpLSEVLKzZyYzA5SHZNUFZ3S2xkYk84OGJnRjVE?=
 =?utf-8?B?T25lN0I2b01tUkNVN2N5RnQwaFJNbTFMVDYxc3VjamtpRUxWNURvQnRPMURR?=
 =?utf-8?B?MXlYcXluaFVKZHFCN1pBaThHd2VtMjMzUVFkcXo3aVRWUDVnT0k2M1NnUlow?=
 =?utf-8?B?VUY5NHJnU3hDZTN1T1kvYnZMTGZZWG9LTGptUG5rbVlCYlFQZ1dJL2wxWVcy?=
 =?utf-8?B?SXQrRy93a2RxUC92QUs3b2FGYkFqRjRhZDRsWXY5WlFWWERBVEVuTUMxN1Nr?=
 =?utf-8?B?cWZsUEhLcW9RbkpXSTlFTzRTSG0xTENudG9SMkN3bERUc1JYN1daT29YVDVx?=
 =?utf-8?B?STlMNUwyd1JkbW1FVWNHTlJYZWMwWjVBd21MQ2Z2U3JSQURNSTZpbzgrRDVr?=
 =?utf-8?B?cUtFYkJXY2RCcGRFbUxmWU5LVnI2dFI3Z2RhNm5XZ3BuUktmNGJwdlAyeFh4?=
 =?utf-8?B?aHJ6RENVREpaOXQxVU43K2pFSit6aGlDUTVienlXdXJ2SmxpTWVsZnVEeDNR?=
 =?utf-8?B?aDJMbTlMWHBpTkVZM2hRdVg5dnhqQ2h6RlhtSnFDQXNuc1UyYk9hMHJOV1pq?=
 =?utf-8?B?VDJnQ013YWtYSU9OMFZXNkx0T3BTQk56ckhxVEcrUmNYVFBRR3FmSXZWS1Jo?=
 =?utf-8?B?d2FDM29QQ0FOeVBkM29GTzVtTldHUzlBWVpXcXlpMUJRNVZjQzk4b1ZESkFX?=
 =?utf-8?B?Vmt1aHhua1Z5OFBPcnlwSy8yMmNEMFVvaDVBUUhOSFZkcWg5N1Nsc2RvYWF3?=
 =?utf-8?B?MEl1bkhiTmlpaWE0aHczRW04QmsrZ09IdVE3V3VwWGg3YVdmV2dLODZzSi9Y?=
 =?utf-8?B?UzJpcU5LbDZRQ0FPNUVPQ3NNbEdEVWNzMGR6M1pTR1FkOFl5M0xtYitnUThW?=
 =?utf-8?B?QlJFMmhITU5nVWNONlp2RTZnWUhucTl2NTB2ZG90OE15NU9tckZyUGoxbEMz?=
 =?utf-8?B?MUY2S1VCM1BjZmRQcEsyOE81VXc5Kzhpc05TYUU2Wkkyd1J4cjhNK0tZU1RT?=
 =?utf-8?B?LzVXUEI0ZEpZN3kwNUdNTmpLNXJlbTZRVjNzbU80clUwMUJkbHZTS1J1UGJh?=
 =?utf-8?B?d1ErZis3R1BQYzhrdmJpUUxBZWp4MXMya0pSZmozWTI0VUd3akNjTkpIZ0hE?=
 =?utf-8?B?L2JsQ1NSVUFmbXIreEVlMXY3ajEwL3FndXhhTDdveVhBSk5STHczUEtRVGoz?=
 =?utf-8?B?UlI1eGdGQnR1UmNIMVRpdU8vVWUyM2xEeUFXN2NIcnJ4Rk1FRStxQ2lXR3lX?=
 =?utf-8?B?ZytlOUlhKzNXN3RkS0lxMkwwQjZEclhyL0hBb2YwYU1EWmNwckFVakFkbEFR?=
 =?utf-8?B?cDBVQnVGS2hVSlkrTGJHMWV0VU9tUkllRUlUU0t0eENFYUxXcnFpMUYzZnZq?=
 =?utf-8?B?RFl2QWJsODBhdUw5dWMzUGpZeGh4YWx3NTVCbCs2VHo1WFRrK0MrWjRQS2g0?=
 =?utf-8?B?Y1JiWmc1LzUzNDk0T1NTRGRMTzJmMWNBQ0R1dHZjRW9hYTJiSmZLVU9FbGlZ?=
 =?utf-8?B?SmlUOUlpbXVtWXpMWHV1bnE0bGJZZGhlUndRSVY4OUhRTGV6MVlWaUVnMnAr?=
 =?utf-8?B?TURxU0ppMjQwWDJZYldLa0lDemRvODJkUjB4dTFrcWZCTG5MU1lVdFRxZW0y?=
 =?utf-8?B?RWg3K2pacmhZSjJiam1ZR3A2MEtpdFdIRGVLd2hnb2o2SCtVQXpMdkdDSS9v?=
 =?utf-8?B?MzVTQlZQcUplUTBDQ3FOSTErOThMTy9Mb1Y0MmY2U3dyS3lMT3RMNlFQa0x5?=
 =?utf-8?B?YlFBNkt5SlZPR0h6QzltM3hDVFlpVnU0SnZwa1AvTFdEd2pLeWd4eGR1YUhH?=
 =?utf-8?B?eERldmJKMUVuaHFzaEZra2NURmhuLzZwNC9ZSlJBM1Fvaklzc2xDNm0vdUFv?=
 =?utf-8?B?TXBoZG51L0JGK2s0d3QxcVhIQ3B2Y0RXZGEwWHBveTZWTHpzeGRvNDdHWTVn?=
 =?utf-8?B?b2FQd2FDMUEvU1ZUQytIcDNKcnZJcFZ4b3hUQURUb0hWVTQycGVHSkVPNGVk?=
 =?utf-8?B?SXUvMHprL0pGdTArQkhYVXNPdCt5UEMvZXN3NXR0Vk9qNTJFWEY1RmlYZnV4?=
 =?utf-8?Q?SkPifw2laYiwXHy8ty?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24509a5a-78e9-44ff-f60f-08def84fca78
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:57:51.7986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thKHdwUqD8LwBSGGpN8/zOC6XOB9ykWWDy6gBcS4fnxbiXgmSeLTROWIG1AYP48L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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

On 8/12/26 01:13, Taimuraz Kaitmazov wrote:
> SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours them
> only on the vmap path. An imported BO is tested for first and flushes its
> whole scatterlist,

Absolutely clear NAK to that from a DMA-buf maintainer side.

Flushing on imported scatterlist of a DMA-buf is a really big NO-GO.

If DMA-buf imports are used with the device then the device needs to be able to coherently access the underlying memory.

In other words you *CAN'T* call drm_clflush_pages() on imported memory.

Regards,
Christian.

> so a sync costs what the BO is worth rather than what
> the caller asked to maintain: on npu4 an imported 64 MiB BO cost 1056 us
> to sync at every size from 4 KiB up. Patch 5 reorders the arms so the
> vmap path is tried first, and indexes the page-array fallback from the
> requested offset.
> 
> The four before it are the ground that has to be solid first. Patch 1
> refuses an I/O memory mapping, which the driver currently stores as if it
> were an ordinary kernel address. Patch 2 adds a probe that does not log,
> so patch 5 does not make an exporter without a vmap op print on every
> ioctl. Patches 3 and 4 fix two ways the ioctl mishandles its own range: a
> zero length reaching drm_clflush_virt_range(), and an offset and size
> added to the BO address without an overflow check, one level above a
> function that checks the same arithmetic. All four stand on their own and
> can be taken separately; only patch 5 depends on them.
> 
> v1 did not reach dri-devel, so this is the first version visible there.
> It is on lore via the other lists it was copied to:
> https://lore.kernel.org/lkml/20260811204556.875037-1-taimuraz@kaitmazov.com/
> 
> Changes in v2:
>  - patch 2: take the device from the GEM object rather than abo->client.
>    amdxdna_gem_obj_close() clears that pointer under abo->lock, which the
>    pre-split code held across the log and the split did not.
>  - new patch 3: return early from a zero-length flush.
>  - new patch 4: check the sync range for overflow on a device BO.
>  - patch 5: say why the persistent mapping adds no pin.
> 
> The measurements in patch 5 were taken with the equivalent change in
> AMD's out-of-tree xdna-driver, where this merged as #1541. That version
> and this one differ only in a page-array fallback mainline has no field
> for, reached when the mapping fails and the BO is neither imported nor
> shmem backed, and in the name of the mapping helper. The flush and the
> helper are otherwise identical. This version is compile-tested; it has
> not been booted.
> 
> Patch 1 is from inspection rather than a reproducer. The exporter I can
> test against is amdgpu, and amdgpu is the case that cannot reach it: it
> implements .pin, so a non peer to peer attachment like this driver's
> forces the buffer to GTT before anything maps it. Reproducing it needs a
> GPU whose exporter has no .pin, which I do not have paired with an NPU
> here.
> 
> Taimuraz Kaitmazov (5):
>   accel/amdxdna: refuse an I/O memory mapping of an imported BO
>   accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()
>   accel/amdxdna: return early from a zero-length flush
>   accel/amdxdna: check the sync range for overflow on a device BO
>   accel/amdxdna: flush only the requested range in amdxdna_flush_bo
> 
>  drivers/accel/amdxdna/amdxdna_gem.c | 66 +++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 17 deletions(-)
> 
> --
> 2.55.0
> 

