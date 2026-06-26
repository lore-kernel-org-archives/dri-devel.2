Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DBACDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FDB10F515;
	Fri, 26 Jun 2026 09:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJuIRox1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B89910F511;
 Fri, 26 Jun 2026 09:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEPucyrCMGAjYeVJuB9tetRLm35bQl7HmfyLYraJXBJUHfAs6C39IIoGV33ffjQV5tAXtRMSZ9NflaYu1C0rU/nvkshLE0ZFbacC/yZXyOG6YY8Jh1/O20OB+8e0grD2cD5/qUVVCzHmu4q9jFT4E7BULE435ZbnGwB0hKOdYgf4VpcVzLyKwVXIp849CU3WXbvaIjYk0TM3vDZ2MKVd2OeNB11flc4eHWjC01bHmyXdiRxJWDaAZeu9JnYtJVd5T8Tdg2hAqFCU3vWF5SuU+LQHVmCKEVRkAjRvSOEM7mQmZpyyp4+S2BjAY1Z2vPmvtgxskaCftrniEt6ecGFoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqMGR85rb22dbFd8r3euIXkHv69IyGXgXK6n0ZcQCYY=;
 b=eWxVKTC6wk+4iMzqScfSGAGZkFgqNajsdwFPUC3L2qr7T50XaNMpn/WQki7cfcIaq3hTqagVlmcK6VzFar7brz6XNcJAkie+T/iPcbSVONBDb1J37RBinO8ZbWTARoL6PTpTmKcXIOoRmUPGP1LzyFqsMGQLZXo6WLi0R6LzG0qTgeFj7St0vB5tq8IKoEfhJ5qksVjfdANjfR8Rq3HH3LC9VZS3EbLcNhMgNiA7yrGLOeeJ7xo24f+rKDxIfZA/0v7X6aVSQtgrzP6fka9Kzy61V4nI5/2hSI9q6RIWDTp57GIFGMhWi/sHvmZG0lICKFk6KxxGKJ1A7nxcgnSfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqMGR85rb22dbFd8r3euIXkHv69IyGXgXK6n0ZcQCYY=;
 b=rJuIRox1x0GIwe6YEgc4lS7GVxvYw+lRkRuAuZASOl4fX6p16Vgm0UUkHqA6pu7J52nap7Ty1ykNtshcGfnXS07+UkSTGz07Ein43e024RntIl9MNJgqj2oImMbQGie2n8TvYi4Prfpc3mINc6k/pqHTbTUuz50lYd8AMFMxArk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 09:07:32 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:07:30 +0000
Message-ID: <e61ae49f-35a9-4eb2-9cd8-ac1162c38c0a@amd.com>
Date: Fri, 26 Jun 2026 17:07:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-5-honglei1.huang@amd.com>
 <aj48KjDIZadzFVSZ@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aj48KjDIZadzFVSZ@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9c1d94-0cae-4d8f-685e-08ded36259bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: x/LuN9rTkh+fsbWktlWsVDJw8NRoWgP29oSLAzTdAa3eydGxvv5u5Iy8qU0AkV46gMQ/mm+uuXWJN7d2xMlFuFAgvxwG6iTxHjRHLVoBYOP7NuqdKBJBaMtVgAEeLwq0uhaufk07FHXuI+HOdLJGJ93g+iq1YCELC2ZTW7Ia/ccxTjTKqtyLx4rPBFsyoqyLXH/CdCsMQEoCaiey89aNIctHVkIs2XHnijmm0KC9FZmxCCVR1Eq0/iSYGEXKKp48bc1x8r0mDxIIfkKGvSYcJy03kzVHCBvxjlwI3tnYd2m1zSP4fMNvtoMNlRh9OWLcMkda3k4VpcCEgZMnmn42mSo+VmnnMgjB4P4pGhpZg59KOt551DFt5Q+5Aa6gH0FwCpktGcI3HlH+SBv2WRE16Rf5N7tnAize2DPO2QgQA8UO28gaZP3D91Jpsrh3Rf0FnjuRVUy0I1DZS7pk1yo9cRxFooA6J3q1XNXbPEIUFhbVQ3ja4w6aYqnmQI15YUZ014DhLCx4YIU7eJEF95VdPAHP1Kc4JAwU385/u8YlwC1E4otd2ZqNqd90po+WzhJzAH7MpQlIVvqjhDH77G8/fx7VS1Lev0rx5OAyHlLwzltZqaUu/te9qmxGQoCSNlpP6pJPeXeSMkuNuKZdRW35ImqWDroxkdC64AtL/Di6h/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hFd2ZDRXNqWVpOTkhLeTk5bmFOcFdRZ1JHTWE3a1NLY0M1TktldmllYTBO?=
 =?utf-8?B?dG40bmFnWXU4c3ZjanM4Z2VmaFBuM0JmbzBHOTMzTHE4M2NRc0Y5bWhvNG9k?=
 =?utf-8?B?RU1MaW1tTmNNbEFuQithU056RnlLOUlkU1ltMWs5cUVIaHREaUNsclV6MUQ0?=
 =?utf-8?B?WnVpRi91N3dMRTdVa2FrUlVxVXNIQVV2TExDeGxBakloQXJtelpRWE5YYTBn?=
 =?utf-8?B?dy9tVFIxZEMvb3k0T2VLeWFpanJEUVA4UEF6UThjaURPN25YQU9iSnplbFVk?=
 =?utf-8?B?OTVHbUxPeFNtVW9oUGxPVkgxNDcxSnhZUjBmUW1jWjBoY0VLUTB2UFpQdW9y?=
 =?utf-8?B?RVZoSi9CdmlkcnFmNWFxdHpXaDM2M1ZrNjlWQVpKNVdybnBjVS81ZEVic0Z1?=
 =?utf-8?B?MlZNNXhSQVdRNnl6dEhTUnBsbWRSWVB1U2FuSXpET2pDazRMQityUEUxeEV5?=
 =?utf-8?B?ZFJURGhNblAvelpxMVZaM3BDblhHT3I3eDdYbVR3cTlKUkxuQUxJOXptTHRR?=
 =?utf-8?B?RklzbzhZaEx2aUlqUkhmU2g5VnFMcDhNUitiNXhaSVc0Y2tydVlteDUxMkVY?=
 =?utf-8?B?R1U2MkttTzkvSUl5N1o2eEhCb3ZmYzBkTDhUczhSSWxpTmxteno4aTZrQVNQ?=
 =?utf-8?B?anVBVW1kTGw4NnNLWlorbHBmeHlDUkdqbm42VG52dzVDakVXYzR5R2t2TTFp?=
 =?utf-8?B?eGFoUGRCaUFZamNHcVEyUTZNbDNSTjFHdi9JZmFhTDN5ODRMc1c4NXF0SC9l?=
 =?utf-8?B?Qkw0TFZ1d3hWOXNRYW1lOWRVcnBqQ3N6S0FNbWI3anI3ZzFhMEFLSWRUWmVB?=
 =?utf-8?B?SEVUdko5QWx0OGtaQ3lDbk1KbC9iRFFNSHBFUWgwYklIUkpjcHpJam5qU2xz?=
 =?utf-8?B?ZHJ1ejdZVzVYRVZyS1hkS1VvZnc0SEtHeC9wRHNhcFA5SXIrVmpBNGtJSDRm?=
 =?utf-8?B?R1FndVRMeTIwdnlhVFY5RlNJL2E2T1UveXFrMmNtZ1N1dnJHVzZKRUZHK1E1?=
 =?utf-8?B?eTM1VXo2UTY2K1lUK1I2TCtHVHRqWjJXcGxBYlUrdkVUcHFVUHV1NkE0eHdY?=
 =?utf-8?B?cUQzNWc4bFFkb1ByazJCTnJGWEhFaVRVZnlZeFhtVTB0WmNIOHFDajZnNHZW?=
 =?utf-8?B?bm9vZmxKbGF0Y1BnMFY2eHBjcTNJNEx3MlJoUVdDd2JkbG40Wng3NFd4VzdI?=
 =?utf-8?B?RGJOYUlXdVZZa1ZqTjJTYXNDc1FWT2dtaW1qYmFEM2FsSkhqTjA2Z3F1Q21D?=
 =?utf-8?B?Ky9VVllDd0FjNG5sQngrdCttTE9HZ1hFV3QxcTRkeVIzRE9SRC9uWTVMZHl0?=
 =?utf-8?B?TjNFd0JBeU9uOE5JUlVRcFJrMlZMakZtTkFEUWR1YXcvUUptK0xPU0s2R0VO?=
 =?utf-8?B?b3U3UWxGZXJuOVJTOUNGSVZLUjRJYkt5SCtMK29EM0t5QkpIRXFMZ1FpTVA4?=
 =?utf-8?B?TVljU3hURzJVTWF3TzFpUmZvZU96RzJpN05VMUlrOHNxYzhtTlRwNjJlUEdZ?=
 =?utf-8?B?VXFZSUcvbGdXSTQzcFYzZmtpOERpZS82VHk0WDFDOFpLeGZBZW1HenFvaFFz?=
 =?utf-8?B?N2hYZFliLy9vL1hDR3A2VjRBZ3NLRU55SXBoeG52T1lsZ2lRZE1nZVc4bFho?=
 =?utf-8?B?eU95UmtKMCsySmdvZFFFOGRIbjZseXNSNS9ZaHpWc2VTUHlnY0JUSFhldk9P?=
 =?utf-8?B?YnNjQXJCT0F6VHpsUlFNWmRFcEhYa2NUYVY0YU9KUXRnUThuTXhPOTBaQXp6?=
 =?utf-8?B?QTdoVW5FRVZid25SYm1BakZYWXBheDI3MU9zT3ZvQXdGR3pjS041VmhIODg4?=
 =?utf-8?B?T09FeVFBV1p0UlRTdUlUYXFHc1Z6K0EyOFI0VDV0RUUyLzdBYTQvTHEyVWp4?=
 =?utf-8?B?N3dTOVRUWjJQTTdNQ21nbEt5d1pVQ2NkNHhtUExJNjFZbUlqYTdnRXE0ZVRN?=
 =?utf-8?B?MWNvc09qMG1IWEsrMEFqYVUyMEVOQXE2QjBKM2c2eDI3TnNtNGNjekxXYkZF?=
 =?utf-8?B?M01EcWxyQnpLcitZQjBTTzNWNFlGb0dnRHQ5cmJGOE02ZTFxbitSbmtJeFRE?=
 =?utf-8?B?RmRlMHRDMXEzRWZadERBQjI0cVNqd2FpbnNiZkZUZXZvdnlodlpJYTVVRmVC?=
 =?utf-8?B?Z1ZTaU4rczFaUjR4SmxEVHpPcW9rMkF0MzB1WkQ4VE03YUtBWTI5Mm94bDZK?=
 =?utf-8?B?YXZSN1p6RVZtZUYxdWFhZC9HbkdZY0V5Z01vU25ZUXpYOGVvUTNlZDB6eHlD?=
 =?utf-8?B?REgzQUJtQVRoOURrdTNBZWpXcUNMSUpDcGtGVDBxaElqU0JRTUkwcUZ3aXc3?=
 =?utf-8?Q?o9m+YHygesUqZE/Uqb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9c1d94-0cae-4d8f-685e-08ded36259bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:07:30.2525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXyFaFSK1OnrfsYdPhoZzpzb6S/qswmAaQk0IxSvfVzNXem2JgkXGVFbecQKUJ1Rt+44AKmtFRsThOO8CUJTNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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



On 6/26/2026 4:45 PM, Matthew Brost wrote:
> On Thu, Jun 18, 2026 at 04:09:01PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Since the pages the physical pages and MM VA range has been abstractly
>> separated. Unbinding a single form of physical page from the MM VA
>> range, brings flexibility to the drm gpu SVM framework, transfer the
>> way of management of MM and device physical pages to the driver layer.
>>
>> framework's range embedded pages object and its range level wrappers
>> have no users left. Remove the following:
>>
>>    - Drop pages in drm_gpusvm_range.
>>    - Drop drm_gpusvm_range_pages_valid(), drm_gpusvm_range_get_pages()
>>      and drm_gpusvm_range_unmap_pages(); drivers should use the
>>      drm_gpusvm_pages helpers (drm_gpusvm_pages_valid,
>>      drm_gpusvm_get_pages, drm_gpusvm_unmap_pages) directly on a
>>      pages object they own.
>>    - Drop the notifier_seq seeding in drm_gpusvm_range_alloc();
>>      drivers initialise notifier_seq on their own pages object.
>>
>> Update the DOC: overview to match the new model: document struct
>> drm_gpusvm_pages and the driver owned 1:1 / N:1 layouts, and rewrite the
>> usage examples to operate on a driver embedded pages object by the
>> drm_gpusvm_pages helpers instead of the removed range level wrappers.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 163 ++++++++++++++++++-----------------
>>   include/drm/drm_gpusvm.h     |  13 ---
>>   2 files changed, 84 insertions(+), 92 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 85fbadc9716..842bfb37a36 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -48,6 +48,47 @@
>>    *	event. As mentioned above, ranges are tracked in a notifier's Red-Black
>>    *	tree.
>>    *
>> + * - Pages:
>> + *	struct drm_gpusvm_pages holds the DMA mapping state for a range of
>> + *	CPU virtual addresses: the DMA mapped device addresses,
>> + *	the device private pagemap, the IOVA state, the per mapping
>> + *	notifier sequence number, and the drm_device that owns the DMA
>> + *	mappings.
>> + *	A driver embeds one or more struct drm_gpusvm_pages alongside its
>> + *	struct drm_gpusvm_range, choosing one of two layouts:
>> + *
>> + *	1:1 - one drm_gpusvm_pages per range (one drm_device). Simplest
>> + *	layout; to mirror a VA range on several devices a driver uses a
>> + *	separate range (and notifier) per device, so the HMM fault is taken
>> + *	once per device.
>> + *
>> + *	N:1 - one drm_gpusvm_pages per drm_device, all sharing one range and
>> + *	notifier; only the per-device DMA mapping differs. The instances must
>> + *	sit in contiguous memory so a single drm_gpusvm_range_set_unmapped()
>> + *	can mark them all. A driver can keep one instance inline for the single
>> + *	device case and switch to a heap array only when more devices join,
>> + *	e.g.:
>> + *
>> + *	.. code-block:: c
>> + *
>> + *		struct driver_range {
>> + *			struct drm_gpusvm_range base;
>> + *			unsigned int num_pages;	// 1: inline_pages, >1: pages[]
>> + *			union {
>> + *				struct drm_gpusvm_pages inline_pages;
>> + *				struct drm_gpusvm_pages *pages;
>> + *			};
>> + *		};
>> + *
>> + *	In the N:1 case the driver allocates the pages array (e.g. with
>> + *	kmalloc_array(num_pages, ...)), initialises each entry with
> 
> Sashiko suggests kcalloc here or drm_gpusvm_init_pages() zeros all fields.
> 
> I tend to lean towards alloc dynamic structs as zero and have init
> functions set fields but either works for me. But the doc and
> implementation should be consistent.

Got it will use kcalloc in doc, and set zero in init functions.

Regards,
Honglei

> 
> Matt
> 
>> + *	drm_gpusvm_init_pages(), and frees each entry with
>> + *	drm_gpusvm_free_pages() plus the array itself, from its range free
>> + *	callback. Each drm_gpusvm_pages is mapped independently by their own
>> + *	drm_device.
>> + *	Each drm_gpusvm_pages must be initialised with drm_gpusvm_init_pages()
>> + *	and released with drm_gpusvm_free_pages() in driver range free callback.
>> + *
>>    * - Operations:
>>    *	Define the interface for driver-specific GPU SVM operations such as
>>    *	range allocation, notifier allocation, and invalidations.
>> @@ -92,7 +133,7 @@
>>    * range RB tree and list, as well as the range's DMA mappings and sequence
>>    * number. GPU SVM manages all necessary locking and unlocking operations,
>>    * except for the recheck range's pages being valid
>> - * (drm_gpusvm_range_pages_valid) when the driver is committing GPU bindings.
>> + * (drm_gpusvm_pages_valid) when the driver is committing GPU bindings.
>>    * This lock corresponds to the ``driver->update`` lock mentioned in
>>    * Documentation/mm/hmm.rst. Future revisions may transition from a GPU SVM
>>    * global lock to a per-notifier lock if finer-grained locking is deemed
>> @@ -140,15 +181,20 @@
>>    *
>>    * .. code-block:: c
>>    *
>> - *	int driver_bind_range(struct drm_gpusvm *gpusvm, struct drm_gpusvm_range *range)
>> + *	struct driver_range {
>> + *		struct drm_gpusvm_range base;
>> + *		struct drm_gpusvm_pages pages;
>> + *	};
>> + *
>> + *	int driver_bind_range(struct drm_gpusvm *gpusvm, struct driver_range *drange)
>>    *	{
>>    *		int err = 0;
>>    *
>> - *		driver_alloc_and_setup_memory_for_bind(gpusvm, range);
>> + *		driver_alloc_and_setup_memory_for_bind(gpusvm, drange);
>>    *
>>    *		drm_gpusvm_notifier_lock(gpusvm);
>> - *		if (drm_gpusvm_range_pages_valid(range))
>> - *			driver_commit_bind(gpusvm, range);
>> + *		if (drm_gpusvm_pages_valid(gpusvm, &drange->pages))
>> + *			driver_commit_bind(gpusvm, drange);
>>    *		else
>>    *			err = -EAGAIN;
>>    *		drm_gpusvm_notifier_unlock(gpusvm);
>> @@ -160,6 +206,8 @@
>>    *			     unsigned long gpuva_start, unsigned long gpuva_end)
>>    *	{
>>    *		struct drm_gpusvm_ctx ctx = {};
>> + *		struct driver_range *drange;
>> + *		struct drm_gpusvm_range *range;
>>    *		int err;
>>    *
>>    *		driver_svm_lock();
>> @@ -174,6 +222,7 @@
>>    *			err = PTR_ERR(range);
>>    *			goto unlock;
>>    *		}
>> + *		drange = container_of(range, struct driver_range, base);
>>    *
>>    *		if (driver_migration_policy(range)) {
>>    *			err = drm_pagemap_populate_mm(driver_choose_drm_pagemap(),
>> @@ -183,7 +232,10 @@
>>    *				goto retry;
>>    *		}
>>    *
>> - *		err = drm_gpusvm_range_get_pages(gpusvm, range, &ctx);
>> + *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
>> + *					   gpusvm->mm, &range->notifier->notifier,
>> + *					   drm_gpusvm_range_start(range),
>> + *					   drm_gpusvm_range_end(range), &ctx);
>>    *		if (err == -EOPNOTSUPP || err == -EFAULT || err == -EPERM) {	// CPU mappings changed
>>    *			if (err == -EOPNOTSUPP)
>>    *				drm_gpusvm_range_evict(gpusvm, range);
>> @@ -192,7 +244,7 @@
>>    *			goto unlock;
>>    *		}
>>    *
>> - *		err = driver_bind_range(gpusvm, range);
>> + *		err = driver_bind_range(gpusvm, drange);
>>    *		if (err == -EAGAIN)	// CPU mappings changed
>>    *			goto retry
>>    *
>> @@ -205,6 +257,22 @@
>>    *
>>    * .. code-block:: c
>>    *
>> + *	// The driver owns the drm_gpusvm_pages lifecycle. The natural place
>> + *	// to release it is the ops->range_free callback, which the framework
>> + *	// invokes when the range refcount drops to zero inside
>> + *	// drm_gpusvm_range_remove(). drm_gpusvm_free_pages() unmaps any
>> + *	// lingering DMA mapping and a no-op if already unmapped and frees the
>> + *	// dma_addr array.
>> + *	void driver_range_free(struct drm_gpusvm_range *range)
>> + *	{
>> + *		struct driver_range *drange =
>> + *			container_of(range, struct driver_range, base);
>> + *
>> + *		drm_gpusvm_free_pages(range->gpusvm, &drange->pages,
>> + *				      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
>> + *		kfree(drange);
>> + *	}
>> + *
>>    *	void __driver_garbage_collector(struct drm_gpusvm *gpusvm,
>>    *					struct drm_gpusvm_range *range)
>>    *	{
>> @@ -215,6 +283,7 @@
>>    *			drm_gpusvm_range_evict(gpusvm, range);
>>    *
>>    *		driver_unbind_range(range);
>> + *		// Pages are released by driver_range_free() (ops->range_free).
>>    *		drm_gpusvm_range_remove(gpusvm, range);
>>    *	}
>>    *
>> @@ -236,17 +305,22 @@
>>    *	{
>>    *		struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
>>    *		struct drm_gpusvm_range *range = NULL;
>> + *		struct driver_range *drange;
>>    *
>>    *		driver_invalidate_device_pages(gpusvm, mmu_range->start, mmu_range->end);
>>    *
>>    *		drm_gpusvm_for_each_range(range, notifier, mmu_range->start,
>>    *					  mmu_range->end) {
>> - *			drm_gpusvm_range_unmap_pages(gpusvm, range, &ctx);
>> + *			drange = container_of(range, struct driver_range, base);
>> + *
>> + *			drm_gpusvm_unmap_pages(gpusvm, &drange->pages,
>> + *					       drm_gpusvm_range_size(range) >> PAGE_SHIFT,
>> + *					       &ctx);
>>    *
>>    *			if (mmu_range->event != MMU_NOTIFY_UNMAP)
>>    *				continue;
>>    *
>> - *			drm_gpusvm_range_set_unmapped(range, mmu_range);
>> + *			drm_gpusvm_range_set_unmapped(range, &drange->pages, 1, mmu_range);
>>    *			driver_garbage_collector_add(gpusvm, range);
>>    *		}
>>    *	}
>> @@ -640,8 +714,6 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>>   	range->itree.start = ALIGN_DOWN(fault_addr, chunk_size);
>>   	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>>   	INIT_LIST_HEAD(&range->entry);
>> -	range->pages.notifier_seq = LONG_MAX;
>> -	range->pages.drm = gpusvm->drm;
>>   	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>>   
>>   	return range;
>> @@ -930,7 +1002,7 @@ drm_gpusvm_range_chunk_size(struct drm_gpusvm *gpusvm,
>>   		 * mallocs 16k but the CPU VMA is ~128k which results in 64k SVM
>>   		 * ranges. When migrating the SVM ranges, some processes fail in
>>   		 * drm_pagemap_migrate_to_devmem with 'migrate.cpages != npages'
>> -		 * and then upon drm_gpusvm_range_get_pages device pages from
>> +		 * and then upon drm_gpusvm_get_pages device pages from
>>   		 * other processes are collected + faulted in which creates all
>>   		 * sorts of problems. Unsure exactly how this happening, also
>>   		 * problem goes away if 'xe_exec_system_allocator --r
>> @@ -1335,27 +1407,6 @@ bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>>   
>> -/**
>> - * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
>> - * @gpusvm: Pointer to the GPU SVM structure
>> - * @range: Pointer to the GPU SVM range structure
>> - *
>> - * This function determines if a GPU SVM range pages are valid. Expected be
>> - * called holding gpusvm->notifier_lock and as the last step before committing a
>> - * GPU binding. This is akin to a notifier seqno check in the HMM documentation
>> - * but due to wider notifiers (i.e., notifiers which span multiple ranges) this
>> - * function is required for finer grained checking (i.e., per range) if pages
>> - * are valid.
>> - *
>> - * Return: True if GPU SVM range has valid pages, False otherwise
>> - */
>> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range)
>> -{
>> -	return drm_gpusvm_pages_valid(gpusvm, &range->pages);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_pages_valid);
>> -
>>   /**
>>    * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>>    * @gpusvm: Pointer to the GPU SVM structure
>> @@ -1636,29 +1687,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);
>>   
>> -/**
>> - * drm_gpusvm_range_get_pages() - Get pages for a GPU SVM range
>> - * @gpusvm: Pointer to the GPU SVM structure
>> - * @range: Pointer to the GPU SVM range structure
>> - * @ctx: GPU SVM context
>> - *
>> - * This function gets pages for a GPU SVM range and ensures they are mapped for
>> - * DMA access.
>> - *
>> - * Return: 0 on success, negative error code on failure.
>> - */
>> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>> -			       struct drm_gpusvm_range *range,
>> -			       const struct drm_gpusvm_ctx *ctx)
>> -{
>> -	return drm_gpusvm_get_pages(gpusvm, &range->pages,
>> -				    gpusvm->mm,
>> -				    &range->notifier->notifier,
>> -				    drm_gpusvm_range_start(range),
>> -				    drm_gpusvm_range_end(range), ctx);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_get_pages);
>> -
>>   /**
>>    * drm_gpusvm_unmap_pages() - Unmap GPU svm pages
>>    * @gpusvm: Pointer to the GPU SVM structure
>> @@ -1689,29 +1717,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_unmap_pages);
>>   
>> -/**
>> - * drm_gpusvm_range_unmap_pages() - Unmap pages associated with a GPU SVM range
>> - * @gpusvm: Pointer to the GPU SVM structure
>> - * @range: Pointer to the GPU SVM range structure
>> - * @ctx: GPU SVM context
>> - *
>> - * This function unmaps pages associated with a GPU SVM range. If @in_notifier
>> - * is set, it is assumed that gpusvm->notifier_lock is held in write mode; if it
>> - * is clear, it acquires gpusvm->notifier_lock in read mode. Must be called on
>> - * each GPU SVM range attached to notifier in gpusvm->ops->invalidate for IOMMU
>> - * security model.
>> - */
>> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range,
>> -				  const struct drm_gpusvm_ctx *ctx)
>> -{
>> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
>> -					       drm_gpusvm_range_end(range));
>> -
>> -	return drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages, ctx);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_unmap_pages);
>> -
>>   /**
>>    * drm_gpusvm_range_evict() - Evict GPU SVM range
>>    * @gpusvm: Pointer to the GPU SVM structure
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index e32d3bcb47b..5edfa7d0c36 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -177,7 +177,6 @@ struct drm_gpusvm_range_flags {
>>    * @refcount: Reference count for the range
>>    * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>>    * @entry: List entry to fast interval tree traversal
>> - * @pages: The pages for this range.
>>    * @flags: Flags for range see &struct drm_gpusvm_range_flags
>>    *
>>    * This structure represents a GPU SVM range used for tracking memory ranges
>> @@ -189,7 +188,6 @@ struct drm_gpusvm_range {
>>   	struct kref refcount;
>>   	struct interval_tree_node itree;
>>   	struct list_head entry;
>> -	struct drm_gpusvm_pages pages;
>>   	struct drm_gpusvm_range_flags flags;
>>   };
>>   
>> @@ -307,20 +305,9 @@ drm_gpusvm_range_get(struct drm_gpusvm_range *range);
>>   
>>   void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>>   
>> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range);
>> -
>>   bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>>   			    struct drm_gpusvm_pages *svm_pages);
>>   
>> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>> -			       struct drm_gpusvm_range *range,
>> -			       const struct drm_gpusvm_ctx *ctx);
>> -
>> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range,
>> -				  const struct drm_gpusvm_ctx *ctx);
>> -
>>   bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,
>>   			    unsigned long end);
>>   
>> -- 
>> 2.34.1
>>

