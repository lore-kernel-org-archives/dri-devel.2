Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1065606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q2EnXl6G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D54F10F026;
	Mon,  9 Nov 2026 15:18:32 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD60D10F080;
 Mon,  9 Nov 2026 15:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ7XnZxfmpqGnkMo8PlubLOtj1kC0sPQxQ88jwp7PXot9j3ITXN838suxMMJAMJriYOrzFCIOKpfZvlmqeqqvvln7EY7Sbu0n642QKPKJXxDejBCNR2CJugOqFmzjI79czOej6K8V6ccfKMRMNmXiBcJjxc+paJngtykRT8CRJhAALlrbCKVfSkJfdBYXZC1GlS8f8bUR4nioWASiwDK48OwOmLmaboejh58e18iI1A7Kun+8aKLf1oJGzHeYkNKFWBnix/ANxl7hCDmC/qQEjfmK3RFxrd45qrBW32GpofYBDFysYssoTdJlUBhpOjAMFxG5h0RlPkjswthk8DcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWcOFZiHyBCrmD07OoTpkNS9RVLfuvhi8BXLl4rMxrI=;
 b=DH7jTfm9JR3cfiQ6P0CT6MQwyYXYxLJaHM+uMsCV0qgOwsK2z+Vzd7aNc9yIA1NZDitc2lVOXVF8ZrnbXYD/PAKoGkuuyeDqMCKozLSBWLunnXNZ8pnSeBrrPvuTTRRSO3HsUXwuImjUxcg3fks7S1c8k/IKtPixb0l2UkGPxUriR/M7iN+Ly7uBGi5bHcLl4Q1FVSu/+gJ1tH9hgVJkrWNlyJL8FSrJ95hvWdPNQffxWiu6O9s35hr5l4QrDo/oceSW7hlaGcfdaNmF8DjSKKEcYtaA7nyTCijuM30p/9+h/gk6IbMSudrwrWd8vl/aTyxLcFRlNvf04jacf30Crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWcOFZiHyBCrmD07OoTpkNS9RVLfuvhi8BXLl4rMxrI=;
 b=Q2EnXl6Gl2aiJJZXJex1CUnj9wrh1esImu0GiKLh5NKadK2fA/xdWrieftoLjE3Fzx5IL7NffzFVCZhRnBYIh32zIVgi3+KZGuyAYZq8YM/ZUGvios8EzMhk0Sstti9aDP0Jb5uBdfOC43+EZu7hfPorJ5ntdtiJOrn0B5n/zJ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by FT1PR12MB322216.namprd12.prod.outlook.com
 (2603:10b6:170:39::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:18:22 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:18:22 +0000
Message-ID: <d70f012f-94be-4e9d-8228-8cdc7c1aa4f5@amd.com>
Date: Mon, 9 Nov 2026 10:18:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/13] Add DRM_COLOROP_3D_LUT_DMA for fast-loading 3D
 LUT
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>, Autumn Ashton <misyl@froggi.es>,
 Xaver Hugl <xaver.hugl@gmail.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
 <aupkDmY1HUlS27HT@intel.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <aupkDmY1HUlS27HT@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::15) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|FT1PR12MB322216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2362dadf-0f85-48ff-8e95-08df3e74b18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261009221227099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0Gi0kZiVdY7PWyH3KRgWUbze1kkAIS+qTlzOthNXNjLY75uC456DAwNjFfG/mN8lXAyclRVi7x2UNQoNmsDoi3hrffKxAw3V7g4hmk5Ho3CVQfJ3/WolUj7x9dVWmmla1ugxOv9cFVlsGLHTTy2YOial0zSP2amcx/Mg/A3pP0sjIEHGP6YapA63lsZVWI25Ffy7NQmniHp0ILWoHOARYyWHdPsOW/sYaj9NY5Q6czJUmeF8WjqdVOTlxUFEYsK6ERkhlbarsjrfRZ4FMIEMAzijuV9+RxoQ9/aVeyromb8GFtOEJrBXJ0FQnucPCadb3bL/deZPenDAwJf0FyaX9Zg/zcZ0JP9brdPa+XOyC9Y2HpZ36hL1i/UdIzrt61wlMCcDnYT7LyiilAWtMSt28AYdOzW6B1ZXLVYNnPgLaLshxGDihOI0rj1KRZdiMsF1x1Q3ORfIbFxTCt1+ugBroB64wiQI9pz+qLLBn9ameTReAKPFMZxC9wEGpwoLHljl4xh97hLAgicFf8dVwdplqbbvNupev/WG8RDMXuNYXecsR/KKB5UKwC4kKkAArOl5DtNVGqRKN+wqafgygrfkEFqAKp2iFo+xkrdpbvGHZVmu8pGsVEAA37wA4qSQqxl4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHF4Q3VOcjE2R05LSU9ocjFidkZmTkZrOHhrVzBNNGp5bndYblhDNEo4VXlC?=
 =?utf-8?B?ZXZ4dkdYZmhrZDAvdVY4TzBUZjVoNlBnRWJLbEt2SmpoSTFPMU1VWG9BNXdq?=
 =?utf-8?B?WUMvVnBDbEhwd2xJVUNSb3pjN0JYbHFZZ0FwdHk3emkrRmZ4WGdnUU1CaEdI?=
 =?utf-8?B?ZHdRSDVkS2FMeTgyd2E2SGpQTm1jcXc4Y2MxNFg3ZkJ3TEZaSVc0bVNMNVM0?=
 =?utf-8?B?T2NrdmJhRUNudFl6NDQvQjc0Z0dQWENZaGVmYVRwU0Evdm9Id0xsSHhWZFVr?=
 =?utf-8?B?QlJSYm4ySE1wcVk4Y1FKaXhDeW1KK0Q3WUZBenFTQ1NpaFpZNHFwTmpsUFRs?=
 =?utf-8?B?MlRhaDVNa2lyTTNCNzA4THlVa2hGdnlkNGViU2Nja0l0SlZzdTQvS0VuZGNZ?=
 =?utf-8?B?S3d4bnd2Z0RRNkFra0ZseXNBb0lHTjVuSk82T1cvaFVWSUlITW1XRGVneW9v?=
 =?utf-8?B?OGVERVNzSEc5cEZvb2h1cy9lb0xlZnM2bTlUWXkyWTd0RW9IcXAzckgzREQ5?=
 =?utf-8?B?SVNrNWNiS1RVN3pDYThna3BkaVRiTXBjcGY4dTZzQ09HSE1ZTHIxeUNJMG9x?=
 =?utf-8?B?M1pSb2o2WC9jVmorNFNuYmNjNzVSYVV4VEFMc3EwdWFISktxL2VqTyt6WWtH?=
 =?utf-8?B?eVYvNmZlSENCQWVNNDFPRFZFV3lFR1RIazVLOVN5eWhYQ2tsc2RTaTRGMGsz?=
 =?utf-8?B?MkNMS1Nnd0p6TElPcWRwVHZJQ05yQUZkWFMvcWZqRmdNOFF4a1NBRkxXT1VR?=
 =?utf-8?B?d2pQL3BVRUdaRXJBZFhmWm96UXc2RUZqTWFmeE5jQXFUMUhTUmxLdmM4d0Vi?=
 =?utf-8?B?V0hmemkvV2RHWTBlOWdPMXdxditKeHkvZ3MzcGYrUTJnckNDYTU0T3ZpMkJ1?=
 =?utf-8?B?OUhtbnV4VUNKaGx1VnFBRkRDeXVldlZtL1pyWHBBaUJqYjcxNWZlS1Nwd0Ru?=
 =?utf-8?B?WnNBZ0NYMEFqZGFTRjFpU29KRWZwMjh5bk1VdEgydEpHeXQzcXgrMnBXSjBP?=
 =?utf-8?B?TzdFNFJqdHFmd3VHWnRRblZVYTE2ZmtkbUpyeEcyZWJLMmFlTGtFVUkvcFpK?=
 =?utf-8?B?eWFxNERwdWJJemV5bTBTbW5GQVgvcUlRaTEvUEkxRmZPcjl6QnFReFV4MUVK?=
 =?utf-8?B?UzRRTDBpZmNZcG5uK3U4OEhGUEloM2dITXFKMlEwNFNSRnVDRDg4NkJYTGJs?=
 =?utf-8?B?bXFRM2hySm5jNVg0WWo3cE93SjUwcGJFTG5LaFRqdHFnc3VVNU5RVkxOaXdX?=
 =?utf-8?B?MHF0YjN3MTlHY04vTjF6c3ZOZkk3c1NZbmxsTGhTeWVLeUJSNFpSNGxNWWtp?=
 =?utf-8?B?bm1Ub2VpS2F3MytoVjJlT09jUXo5SGFOVmVCdGlpQU1iZnV5T1MvWm15dTQz?=
 =?utf-8?B?b25VRzMrYzVJVFpGRlM4eXdZR1FBT0x0d2UrVTAyTzd6WUtkeDlPR0N3OVZh?=
 =?utf-8?B?WWNOWk9mTmpROGNKbVdtTmUwdzJROHh5bTh4OUFGS0NwclJEVGdYUzBOM1Nx?=
 =?utf-8?B?T0hoVTlpUklMQ2lYcm1JanJHZGtBVGg1ZG55TndvNmZZcGljaXFVSmdjaHlt?=
 =?utf-8?B?aW03YlZrVEdrcWc2dk1RWHRrOEVpRHF3bXF4Mk5QVFVnRzYvV1ZGem5DOXow?=
 =?utf-8?B?V1BmRzlRajZJTGYyUG9IRFdvQTNTRjl5TnJ6U0M1Qmdac1dWRmFiL0kxVjBz?=
 =?utf-8?B?UFdoWkdHMnBXMWVPVDFFM3JFc2VSSTNPN1UxU2g1b250aFltdHJWVFNkbVAr?=
 =?utf-8?B?enI0ZWh4bG5CT1h4THZtZmdrT09NbTd6VzBwUlZiWk5YUGVBeG9PVEROWVU5?=
 =?utf-8?B?UUdLLzB2VWFBQ0wrS3hUNXB1bHkwSkJYN25ZZ0pUelRmNzZGRTA5YnFTbXdt?=
 =?utf-8?B?VGhjY3B5ZWhUbWV3Z0o3cnBZMVVwS21mT05lS0kwbmxMVlhXUmw3L2VydHBC?=
 =?utf-8?B?R2ZDUHZ1UEd5THBCbTg1WExZWi9MN1hFNERCNlV0TVptZlpDdUIzdW43Y0Jr?=
 =?utf-8?B?MTVZQlJlZnoza0Jwakpqc2tHU2I1WGZka0cya2hDVXdwaFM4VG1BbmI2MHpZ?=
 =?utf-8?B?bEM2RW8zQnlQYkduOHozSEY4MkRVVnh4aWRkV1RBeTdZb1cwbGhpYmJjd1dv?=
 =?utf-8?B?dE5mV2poemQzclZSU1dkOXMzdDVlUmVOQUg2TEJjUkdHT1V3TVVHaHYybDJM?=
 =?utf-8?B?aGdldDRCWnpKaStBaE14b1A0U0x6ZHFYQlYrZiszQVdBTi91b1FLTTEyRW5H?=
 =?utf-8?B?bk9TRkxJQ2FOU2pmVHhFaVhTb1JFaWpEZmFpY1NrazRwM1R4Q25GQW9kckNh?=
 =?utf-8?B?bTRXRUtqdjhEdUVtZjhiWWpxenA3Y2xlbGswbFVLVjJYTlBYdjJ2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2362dadf-0f85-48ff-8e95-08df3e74b18c
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:18:22.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE1LJa9rfqSe7HuAuDOzci/P9i/dwRC9HINRuHvUegdJe7mvEmGCW5YCa3QnuL8iRxg4XReI9LxcCh8JBEMCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB322216
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-11-03 17:45, Ville Syrjälä wrote:
> On Tue, Nov 03, 2026 at 04:37:43PM -0500, Harry Wentland wrote:
>> Loading a DRM_COLOROP_3D_LUT on AMD HW takes a long time because the
>> driver has to load the entire 3D LUT via register writes.
>>
>> Starting with DCN 4 the HW has the ability to load a 3D LUT via DMA,
>> which only requires an address update for programming the 3D LUT.
>>
>> I propose exposing a new DRM_COLOROP_3D_LUT_DMA type to support this DMA
>> 3D LUT loading mechanism. Users of the DRM_COLOROP_3D_LUT_DMA will parse
>> the supported formats via the LUT_3D_FORMATS blob property, select the
>> desired format via LUT_3D_FORMAT property, and pass the 3D LUT buffer as
>> a drm_framebuffer via FB_ID on the colorop.
> 
> A framebuffer? That sounds like a very weird thing to use
> for non-pixel data.
> 
> Why don't you just copy the LUT from the blob into a BO in the kernel
> and DMA it from there? That's kinda how everything now works on Intel
> hardware. Sure, it's not 100% optimal because of the extra copy, but
> at least it avoids userspace having to care about it so much.
> 

You make a good point.

I was worried it'd be costly to do the conversion and copy but I'm
seeing this take only 70us on my older 2nd gen Ryzen system, so it's
minor.

I'll send a new version that's fully driver-internal. There's probably
no need to add the additional API complexity here.

Harry

>>
>> For details see the patches and/or posted branches.
>>
>> In addition to the patches posted here the 3d-fl-fixes kernel branch
>> contains a number of fixes that will be merged via the usual amdgpu
>> display process. It also contains a patch to enable support on Navi 4
>> (DCN 4.0.1), which won't be upstreamed since that generation requires a
>> userspace workaround. The 3d-fl-workaround IGT branch exists solely for
>> that purpose. Nonetheless, Navi 4 can serve as an enablement vehicle for
>> anyone who wants to see the new interface working.
>>
>> The kwin branch makes use of a pipeline with DRM_COLOROP_3D_LUT_DMA if
>> such a pipeline is discovered before a pipeline with a
>> DRM_COLOROP_3D_LUT.
>>
>> ### Branches
>>
>> kernel: https://gitlab.freedesktop.org/hwentland/linux/-/commits/3d-fl
>> kernel w/ fixes: https://gitlab.freedesktop.org/hwentland/linux/-/commits/3d-fl-fixes
>> IGT: https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/3d-fl
>> IGT Navi 4 w/a: https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/3d-fl-workaround
>> kwin: https://invent.kde.org/hwentlan/kwin/-/commits/3d-fl
>>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Autumn Ashton <misyl@froggi.es>
>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>>
>> Harry Wentland (13):
>>   drm/colorop: Add DRM_COLOROP_3D_LUT_DMA
>>   drm/colorop: add DRM_COLOROP_3D_LUT_DMA object and state
>>   drm/atomic: wire up DMA 3D LUT colorop properties
>>   drm/atomic: validate DMA 3D LUT colorop framebuffer
>>   drm/atomic: add colorop prepare_fb and cleanup_fb helper hooks
>>   drm/tests: test colorop prepare_fb and cleanup_fb helpers
>>   drm/amd/display: advertise a DMA 3D LUT color pipeline
>>   drm/amd/display: pin the DMA 3D LUT framebuffer
>>   drm/amd/display: program the DMA 3D LUT colorop
>>   drm/amd/display: add 3D LUT DMA pitch alignment cap
>>   drm/amd/display: derive the DMA 3D LUT pitch from DC caps
>>   drm/amd/display: reject direct 3D LUT loading mode changes
>>   drm/amd/display: add KUnit tests for the DMA 3D LUT colorop
>>
>>  drivers/gpu/drm/amd/display/Kconfig           |  13 +
>>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  68 ++-
>>  .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 131 +++++-
>>  .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   8 +-
>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  71 +++-
>>  .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 286 ++++++++++++-
>>  .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  65 +++
>>  drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
>>  .../dc/resource/dcn42/dcn42_resource.c        |   2 +
>>  .../dc/resource/dcn42b/dcn42b_resource.c      |   2 +
>>  drivers/gpu/drm/drm_atomic.c                  |  66 +++
>>  drivers/gpu/drm/drm_atomic_helper.c           |  93 ++++
>>  drivers/gpu/drm/drm_atomic_uapi.c             |  28 ++
>>  drivers/gpu/drm/drm_colorop.c                 |  96 +++++
>>  drivers/gpu/drm/drm_framebuffer.c             |  45 +-
>>  drivers/gpu/drm/drm_gem_atomic_helper.c       |  81 ++++
>>  drivers/gpu/drm/tests/Makefile                |   1 +
>>  .../gpu/drm/tests/drm_colorop_helper_test.c   | 397 ++++++++++++++++++
>>  include/drm/drm_atomic.h                      |  20 +
>>  include/drm/drm_colorop.h                     |  71 ++++
>>  include/drm/drm_gem_atomic_helper.h           |  11 +
>>  include/drm/drm_modeset_helper_vtables.h      |  62 +++
>>  include/uapi/drm/drm.h                        |   7 +-
>>  include/uapi/drm/drm_mode.h                   |  79 ++++
>>  24 files changed, 1672 insertions(+), 33 deletions(-)
>>  create mode 100644 drivers/gpu/drm/tests/drm_colorop_helper_test.c
>>
>> --
>> 2.56.0
> 

