Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932D6CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC80D10E450;
	Wed, 10 Jun 2026 08:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXxvfvaQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E9010E450;
 Wed, 10 Jun 2026 08:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEqT66bcHJJUiiEevAc8SEZZobV2S9B1F5VRDUA6itvGMTbhooTTXEdyTozqzbU8jrAegjJ0FHCgA8Kr0w3pMiLX3TYoTLyjJaSdcvVEKWIHuE59eEgwnY7mZwHClmLOz2LSM1TlO4dd388Ucl+rg0TZe+eQ31UMiVXiC7nRjyyCKKZALFeZv9KhHaR/sU9mZ1oMRhL2VA3s23B4ynBxqVVS0ZE0nRs+Y8Gk7PXqnBBNVU2SNn+in1C5g4UEtEBEAoe6VO+zr+wiKarj/G4A7drJHrBfLq0p9SbgrpY+cPaTJaRW6bx5FJN5QrcGcOikfUkOVmFBzrFI9/GWhzifoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6F+Za+vSR9A5/NDRtMe9sUUwSEY2C5qXGGOfGeitEE=;
 b=qCkJi630Ki2THv3JYQ7DYXjkTaiN70ekU2e7TKf8O+AQjcLCDmRrS+DGUZhTLudKNSyzXmY3L4N2r5tEV3vb0fiyyTyQyCS49XFYKfZJkKsbJPSj+U4P99bHa7HDxX+sTWkwTKPegLjp+idUs1i/8y25UrvhdoVZ1l2jzofhg3mDckff+H9uxWvaYSeXyFZmydyhSKgePWkA6cba7FY4rpH07ZXHRZf6EPmg8y1+mJRlUpOg4nt2zwJ0hCWQ14C78dEqI+TWBQ/Dc9ThG3xXxqsVeEZkPISUiJbRh69N8KsWKzMpE9zuhkRrwLXJz5U2oSXAqRo4az8mJwF1ZdHl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6F+Za+vSR9A5/NDRtMe9sUUwSEY2C5qXGGOfGeitEE=;
 b=RXxvfvaQAR50VCynL6KDJsJhdmLBO3U1sb88I9cgJ4y3m/WRKn72E4nXKD3jQCiMYowwRos5jforfKCWYVQT0pzz5doxRy0qbnuWtfMVfH6+e6h85+eO7+yCyn8hC/FuvuNBeyAkpaEPptArMIsAdrXUVdj+5IFfDILcKb2kqh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:49:39 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 08:49:38 +0000
Message-ID: <1dc453cb-bf8e-4b30-b486-b75326be2e0f@amd.com>
Date: Wed, 10 Jun 2026 16:49:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] drm/gpusvm: split MM and device state across
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Honglei Huang <honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <aijdg7RWwrEDEMxC@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aijdg7RWwrEDEMxC@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::10) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c63fa65-ab9d-41f1-2703-08dec6cd3450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22122799003|18002099003|22082099003|6133799003|11063799006|56012099006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: b0QJNI/TO8bxfaJvf7cdR84N2MSICa0iOf9QKMeYvTuQFyvXOvKaXMwqUwVi4jN9bOkXDuAQSpOVLb64XFPX5IZuwX5UK4MbOX8c4g6mrPiMkRpM1RWq2bBV4/tOnLSnA1K6qqrNDa5vFfqTB9t58XnOndzyMNTGkWtmdeChaoc48rkBtvJz4Q3raxrlO/SMxRLdArWgcsswdkhemEIrxqQqq44qoWY2/VuqXl1k4badAuUJvxmbQnMBrQvzAJU8ErVVnXOkdwYw84Tipe+fbBjreGI9iWBEa92AxXyZvpxtx0++p7T/FAHB+KnH4VI1RaozCQMvn6kSU+/fxq6i3o9Cuu/PS3FvYnjhaz36TI5CCRB34792NfPEGMtf8kCUT/+sBjFq5j3w0vgzldSxFMbjqXZ+cFCyCYGI2Q8tmgCgZAQDRHW3CJ6b1F6QiN5d+QxXxDnQDMz0SXhFuvDMwSEAeb5VM5j+WCv+tTTUnKKhjHDBtVG/H8zIWMoUijqvxoJd+CohdH1ZFBIVVBf0eeI5SBK7f7XL+vt55X6nEOcU5QGuivj8+olQTIVCCyP3TbWKaiTeLNnlU8kgGNDJ5BdLd36LhZr1+DupSQVQjDSf5jVYAToWE5/Uc3lI0LGMQOW/F4lL7NRr2kJToLxBuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22122799003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhrbWJmdkJ3K24zbmJ3RGNWSzlKWk1rM05zSW1ZMU1WR3Y5WTRFVHEzOWdH?=
 =?utf-8?B?ZXFHRkNiTnliTGIySnB4QzAxUnJLSWV6aVNBMXlwVHpYVXN5emF2ZGV4dUxH?=
 =?utf-8?B?eTRGVW1McXEzRWpUdlltM3RuSHVaY2NuYVRnUXgycC93TncrNmxwcmEydFZS?=
 =?utf-8?B?bjE2YWhKSW5FMnV4T0JLOTViZ2dFV0N1WThtNG54L0RPOHNTQm1tcU1qMGNH?=
 =?utf-8?B?WGZCSkRRT1RadE0rTHowOXIzUkkyeDE2WWtLdEdNQzhzaFZwWk5ncmUxRnRu?=
 =?utf-8?B?UUJPWnhhRnlkbUFCQ1FLVk9SOFB3ZEJ4R0ZJcnRGbi9KdlAzU2FiWTBOVGpx?=
 =?utf-8?B?b1luNkFxaW5VRkhwSmZvTXphem80d2w5VXYwdnNIMmM1S3RVSnVBNkJmemJJ?=
 =?utf-8?B?alk3amlyYkJ2enNiVURQWGRjd0REUHhVSkx0K3psUHpYNWUzWGpSUmJNTU5Z?=
 =?utf-8?B?ZkhZaytzckVQNmxzdFhwYjJhc2d0eGhPcDBFQWcvQU1MdTNtN05Cb2M4TTJj?=
 =?utf-8?B?N1pMZ2pBRGF5dlJ6VmEyZVQ0dmlhVXpMZHM1bjNJTG1HOHdKdnRZZ1JDM3pC?=
 =?utf-8?B?MEE1bWJpdTVJNGJoY1huZ3lOR2U1WVRzQy94OERwQm9qUzVCL2JpTWwzcFJz?=
 =?utf-8?B?QmZCTHZSa2x1YnJ4MFZDd2ZvRjR1UVhGRTljakprc2o2eDNpYldEUWQ2ZkFR?=
 =?utf-8?B?T1NOSEQyZG9qNnZ0MlBXck8vU0JCYXZTdEY0NGFnMGRlcjE0TGxBVVhrMUh0?=
 =?utf-8?B?Qks0WkN4Rlh4cVFjSWtuWGJLeWJzSVZ3bnlaU1lRSlB3THpyYXhvR0Q4SmVt?=
 =?utf-8?B?SmI0VjhsN2lkQnJrQWZKTlpqSmh5OTJyTE1HMFdvcHNJRHIzRnc2VjNGQit5?=
 =?utf-8?B?VGxxVzZLZjd6NFdmY09xN3YxczNVWVZ2SlA1S2oycEx0Q1R4Yis1b1Y4VU1F?=
 =?utf-8?B?OWJyQzRGWXE0UkE1N001SEtOOXBnR2dUeEFHejczY3FyQ3E5d2luS01BSjdB?=
 =?utf-8?B?dVJFZnAxdkZRTWw2Z2poODVSeitVb1h5NXBjSkJxckd3eVZTSERheWN5UU9r?=
 =?utf-8?B?K21WOTIraHorQ0YySW5POElWL0lwL0wwUDR0TXlXL2wwekJnaFhBTEV5YWNN?=
 =?utf-8?B?c2RjaEJmRWZuMlkwbUxsckRpb21WNUZkQmprMlhyTVNtcHFDM09qVUluVXRa?=
 =?utf-8?B?Q3hrcXRrS0dhOVJBTVloVWh3aENPcFMwaFVDQjdXRXNKSHpXalBLaWNhWGVk?=
 =?utf-8?B?SVI2ZXBPaW9UV3RKakYyYjBXSlkvWGpLUkZuTzVmRTEydmF0Y1B6akNMZFJv?=
 =?utf-8?B?dWxmenMvSWc5alFadmJHSFRiY3ZUQkE4QVNPc21meFpwaXBPZlA1UTIzODJG?=
 =?utf-8?B?U1QzaFZLRWQ3YnBEL3ZHNjVaMkpTNjdXQ3BUbDRFemJ0cVNrTkVXcys4WXlv?=
 =?utf-8?B?eE5mWXBRV3NXQW1nOXEwdEgxRkJXOXBCUk1VMENvbTFHYys2eXpYYkxFZnJK?=
 =?utf-8?B?TzVPeGhqSWZOSkRSTFM2OTk2dDNLRndMVFFCeTJvT0wrRFZ0aVMwamxPdFVW?=
 =?utf-8?B?ZVV2TWdXN1NjeVhMMVRjZ2hRbkNMS3d3bVppS3dzKzhYWHJVankwYjUwV3Bu?=
 =?utf-8?B?TFpDSzNLeVhFdjdFZ1ZDclVHbTFmb0VtTW5uNGJXem9UdmNDZWYxc2UwTVhi?=
 =?utf-8?B?OHZ2S3ZEc0NTOWlmeENUUU93bnBDaVA1SDZJazVaSDBzQlVIT1YxRis2V1Aw?=
 =?utf-8?B?c05MZ1JYbnFzZGJ4VzNvZTNVTU0wL1ZzcVZpamx0SXV4RUsxYmFVNmQ0am9k?=
 =?utf-8?B?cGJPOGd5b3lVbWpSQ2dETTZtaHBQUDJhYUpQVHI2K1g0ajZQcTBEUzFtM0Z2?=
 =?utf-8?B?MVdRbU00R0ZrVkNPb1ZnSWk3c0RFQjB6YjVoYXlPMDljUzFGalZlYjZtaHBl?=
 =?utf-8?B?MkVWdU9zdUpzZjJwb0NzNk1RT1NlTkdBRVdxT0REZTk0OWpTb0NEZkFGcXdB?=
 =?utf-8?B?clo2TDUxb0traWdxVzd5dm05TXREZ0tTSkNTYnY0ZFJsQ1FkdXAyV0RpWW1G?=
 =?utf-8?B?c0dMdkszMk5wYW5aRmhVY0dya0hmc2UxYjZSMzEzSFBqcytyNzZxUk9jNXhq?=
 =?utf-8?B?eFRvZnFYV092ajBHQUs4R0dUazlQRUdtMDFXSFBOaXpqUTRiSytTdCtra3RS?=
 =?utf-8?B?NDNJUjdYRUNjNTQxWE15RU5keSt5UjQyT085allRYkJ4dldRS1lzcVI3aFJS?=
 =?utf-8?B?dERJeWJTZW8xNnZWd2dXVE40MTFmSjU4YUpEcmNFckxXckgvUTVwTVhXeXdV?=
 =?utf-8?B?WDBHUmJoaUV5anVKczRCYTZlNjlpSllpUk4vZC9yTmxpd2w2cTZOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c63fa65-ab9d-41f1-2703-08dec6cd3450
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:49:38.5496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6ABUBqUL8kSPYPM7+Q0aEH57Z0vOowZf66jlP+9ZeFofY4FVUH4bcBpXHEq+dT1bIHkYbukoE8ssqwjzKTTRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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



On 6/10/2026 11:44 AM, Matthew Brost wrote:
> On Wed, Jun 03, 2026 at 02:56:15PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> The intent of this series is to make drm_gpusvm more flexible and
>> give drivers more freedom over how they assemble the MM related and device
>> side operations.
>>
>> This RFC implements the direction Matt suggested in [1]:
>>
>>    - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>>    - Embed either a struct device or a struct drm_device in struct
>>      drm_gpusvm_pages.
>>    - Drop struct drm_device from struct drm_gpusvm.
>>    - Have the driver's range structure embed one or more struct
>>      drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>>    - Refactor a few range-based helpers (drm_gpusvm_range_pages_valid,
>>      drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages), or
>>      simply drop them entirely and update drivers to use the
>>      drm_gpusvm_pages helpers instead.
>>
> 
> Overall this looks good - thanks doing this.
> 
>> In essence the series does only two abstractions, plus the xe
>> adaptation that follows from them:
>>
>>    - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>>      drm_gpusvm_pages (device physical related), so the two
>>      sides can have independent lifetimes and ownership.
>>    - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>>      the device side down onto drm_gpusvm_pages, which is where DMA
>>      actually happens.
>>    - xe is updated to fit the modifications, no functional change intended.
>>
>> If such changes are acceptable in terms of direction, I have a few questions:
>>
>>   - Drivers now own drm_gpusvm_pages unmap / free and notifier_seq init.
>>     OK to push this fully to drivers, or should some new mechanisms need to add
>>     to ensure functions can be completed by the framework?
> 
> I'm looking at the diff of xe_svm.c before / after and I see
> drm_gpusvm_free_pages moved to xe_svm_range_free. That looks fine to me.
> 
> I see in xe_svm_range_alloc() this:
> 
> range->pages.notifier_seq = LONG_MAX;
> 
> Can we make help like drm_gpusvm_init_pages which does this? I think it
> is better to encapsulate the pages init into normalized helper even
> though it is very simple. Maybe an inline since this just a single line
> of code?

Got it will add helper drm_gpusvm_init_pages in next version.

> 
>>   - This series drops the three drm_gpusvm_range_* helpers and changes
>>     drm_gpusvm_get_pages() / drm_gpusvm_init() signatures.
>>     Do we need to keep thin wrappers for backward compatibility.
> 
> It should be safe to drop these helpers.

Got it.

> 
>>   - drm_gpusvm_get_pages() mixes HMM fault and device DMA map. Multi device under
>>     one SVM calls would repeat the HMM fault. Does it need to modified to Split
>>     into MM level fault + per pages DMA map?
>>
> 
> Hmm, this might get a little tricky because of how the allocation/retry
> loop is implemented in get_pages(). Maybe we could change the function
> to accept an array of pages plus a count? I’m not sure what the best
> approach is here, but I’m open to ideas. That said, I’d rather avoid
> having the driver open-code a retry loop if it could live in common
> code.
> 
> Side note: another modification we need in get_pages() is to make the
> DMA-mapping step optional. I suggested that AMDXDNA use GPU SVM for
> userptr, and I don’t believe that device requires DMA mapping.

Got it, will try to change the get_pages() to accept array of pages and 
a count, and see if it will work well.

For the no DMA mapping condition, maybe a flag like no_dma_mapping can 
be added in drm_gpusvm_ctx or someplace else.

Regards,
Honglei

>   
>> Patch overview:
>>
>>    1/5 gpusvm: split MM state flags onto drm_gpusvm_range_flags.
>>    2/5 gpusvm: embed drm_device into drm_gpusvm_pages; DMA goes
>>        through it.
>>    3/5 xe: xe_svm_range owns its drm_gpusvm_pages and its lifecycle.
>>    4/5 gpusvm: drop pages from drm_gpusvm_range and the range-level
>>        wrappers.
>>    5/5 gpusvm: drop drm_device from drm_gpusvm.
>>
>> tests:
>> AMDGPU:
>>    based on amdgpu adaptation patch in [2], but still SVM:DRM = 1:1,
>>    1:n is on going needs many modifications and testings.
>>
>>    Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>>    - KFD test: 95%+ passed.
>>    - ROCR test: all passed.
>>    - HIP catch test: gfx943 (MI300X): 96% passed.
>>                      gfx906 (MI60): 99% passed.
>> INTEL XE:
>>    TODO: We bought some Intel Arc A380, but it seems like this cards
>>    don't support hardware fault / SVM, waiting for the new
>>    cards B580/B570 to arrive.
>>
> 
> Please send patches that modify GPU SVM or Xe to the Xe mailing list. We
> have public CI, which I believe can be triggered by any AMD email
> address.
> 
> I just pulled the code, encountered a compile error, and noticed a bug
> around unmapping related to that error. I put together some quick fixes
> on top of the series here [3], and locally all of our tests seem to be
> passing.
> 
> I’ll reply in detail to the patches shortly, explaining some of the
> reasoning behind these changes.
> 
> Matt
> 
> [3] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
>   
>> links:
>> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
>> [2] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
>> Honglei Huang (5):
>>    drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>>    drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>>    drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>>    drm/gpusvm: move struct drm_gpusvm_pages out of struct
>>      drm_gpusvm_range
>>    drm/gpusvm: let the drm_gpusvm core context purely MM level
>>
>>   drivers/gpu/drm/drm_gpusvm.c    | 128 +++++++++-----------------------
>>   drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>>   drivers/gpu/drm/xe/xe_svm.c     |  37 +++++----
>>   drivers/gpu/drm/xe/xe_svm.h     |  11 ++-
>>   drivers/gpu/drm/xe/xe_userptr.c |   1 +
>>   include/drm/drm_gpusvm.h        |  49 ++++++------
>>   6 files changed, 95 insertions(+), 133 deletions(-)
>>
>> -- 
>> 2.34.1
>>

