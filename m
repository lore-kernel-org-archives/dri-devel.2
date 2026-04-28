Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA3BFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB24D10E301;
	Tue, 28 Apr 2026 07:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sKbHyH+0";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A3E10E06A;
 Tue, 28 Apr 2026 07:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhnpwynV6scAX5YOcwJiqTIT/fwRtLs3wF1BDXyHcB15BDy1O5+kr4XARCAj5FrPjnumJjDF+GVGx1yJOGgeYcOkpEv2vt+/5CmU/wCDzG1+84z9dsiAPM4Lw1tOrsngba2WTvCWALlaOfl74GIHPTrl2Wi+/3u+waIZRzifBLlOL1o5ylOKNFJAm/bTAXkE8iqixg/bKj2xJY2aPey7ZWP6VU77MstKAXVlh6xFEh1XuLZOYwpRuribmikXDkajTjueWV+yVozifUN7sUVXw74GsRcuE03+ViwTfDYQgxYmrKC2sGibPdZkgddAN2InE1ls4qWa3EiNUiDnOl03rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F6pCmmEkBDAM7OCvOE9s2cxQAgrKsxDOtcR3d68v8g=;
 b=dd0voQjybKCHqNMOmpWSxuqy3PRjbOIgTtadRKnXSv/3S8qm3JUc8dwgq3hULBLN++exYISWh3w4X4NDDesa4V06y5X5J611YQPwIlfL+TIurRYTLkW6NLTLbdoku1ygQ+XA4H/k7hfEX/toMOA5uNEyn0I8RzyRnSgytUun+QwSm5PVu6UESO0U4JEoJgrif+W/NfkGUJHcePNSsb7+bUhhcT3CV3A1b/nbfrqi0vaciNDGjZ8FQFgd3t325h4CzxYz52sUSCnwNQYnAwRN3nUUaE7dVTrqnd7GK4f3819CH5vXRuEVcLtEDDOSrzaGPVgeQQ6kHfIJoguMR8J0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F6pCmmEkBDAM7OCvOE9s2cxQAgrKsxDOtcR3d68v8g=;
 b=sKbHyH+0I8vFGPFo+X9y50UVPcYXERpp1McwTCunLbMgfMqfRKytlvjObZcT2FNVVfW7inUg1Nv1/7bOtQbmA+bAVLMMatzp8wm7dhbBAYTwhwNJGV4n8F/qDRFcvZ3sxha/v4BVRMsmHvjB+57RhI1iWaRLi1hLHIyC9JcaKco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 07:00:51 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 07:00:51 +0000
Message-ID: <d3897089-05ad-4048-b11c-fa86f2ef35df@amd.com>
Date: Tue, 28 Apr 2026 15:00:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Alexander.Deucher@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
 <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
 <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
 <9c5afd4b-f9f0-445a-9b39-35f56fa2bea4@amd.com>
 <67e190b3-deb9-44c0-a3a1-d269de677c21@amd.com>
 <078b3f0f-cb92-4e4f-b863-d454958b690c@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <078b3f0f-cb92-4e4f-b863-d454958b690c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 676797e8-33d6-4c34-3a33-08dea4f3e1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: tOzWLZbvM188h4wMtAlIQc5+wxIfiOpmq0WLWS7DIECkPqqJz7Zneo5lkwqzjOH9s5FpCOHMjhBMKqBSe0BG7slqcjZU8i+a84tlhT8rL+Y/cCq6zPASmb2AnZ8q0DzEOryY/2qL7GGjr6N2M4k43l2kZST3B+vfojFJUG+XZwubxQOr71fhSUgu8JHkaoVRZ6Sr51oEsCzC42ATP5gdOEsLxaYbXXgFPxYP6EHCrOhUSX+AeNequrRhULuQ4hFxosdhyOhrRTMyjWXSQLPORGHL21EScDWD5EVVb3iyLRviKRQsCYTRPaFMDzVySkGuoVoCFAj5l4NCU+Zx9XiIyGoWZVz5XgK7eq3ACw7uKEx6r9vu+U7zBrAwG6cZURDpizi9bw+oWAKu4Nec7DcU3FFkAZB68gf96XjbTfZogkHD2m0PpV+8pI6+jwy3Z0qyC4MgUL4uOYD9unJ62LyF3NeZrFy6C1KulXC8wHhTDtZhKRCNfidH0cM2r317NUTCjbwx/AR+Rdo6k/hCoX16WWdKiiCRkNr72jGFWrU6o+i6SdzmPk8dRbmYntpLPK29y8n26sQmwmGdCF+2HH8nylpwmbBETZXn/R511UyQmzpnCNdxYvN9PIWRLFvpYcxvixM/x7IMoP5ktOASnomnkjkYjjhUWcJvUNHzv2LqoG/nZMQh/ZYfynAsNEqhvG9CZuyRPfX6Twss3X3ier5K5KyHysMAoKm2M6jQ3qP5p1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BvL2VHT0p6UkloNW1QcFF5MUNSczRhL3JUd3JEczZUOEZSRE12QmNyMXlw?=
 =?utf-8?B?c0tMa1JnTy91VTkzM2xaNzhVVDg3NERrN21NYnB0SG5QWFBwdi9CUU1ER0k2?=
 =?utf-8?B?SzZnWkhibDlkbFc1TWNnUy9tbTJUVzFBVlMzeXFOVmI5bFVCUEZFbXI5Mjh2?=
 =?utf-8?B?czN0dVB0OUZGeGZSbk9WNm83MndYOW03K3Y1MkNNeEpKYTZ0REhsNmNyQlF1?=
 =?utf-8?B?aFBsV2VEUE00M2ROL1VOWXpXOXducW1BejA4NS8vbytuSjBIOVpFcjE0a3hE?=
 =?utf-8?B?VkFhMDJ5V0k5NWd5SlliR1BnMkRMdnljK1FHb3BDOWpxVFMzb21ONVJncjM2?=
 =?utf-8?B?ME1sZ1NYSmtmcnZLUmJPdUlEV0FQblpFSHdxMkZJbitSMWx4cldZcWtsRFdY?=
 =?utf-8?B?cFpnVlc1VXkvSUdwSXl0YXZTWVRGUkJBVjM1VWt5SE84dmt3MUxPczNuUGxV?=
 =?utf-8?B?dk1UUjQ0QXNiZUFVQzRoNVo1OVE0bTU0ZmlDck9lTHIwUkVvbG1GQlNmcGk1?=
 =?utf-8?B?WG9OUHpXclpwQzhJd2QzMXdsTWpGL1I3dVlPcE1zaHgvVHBnWGdzbmg1WmMx?=
 =?utf-8?B?akxyK1NHUm92OGxRdkJGcS9IV1Z1L0hHYkJSMmQ1M2twRmIvbk5SSDEvQWFt?=
 =?utf-8?B?bVMzdHV6QUJjckZCdXYwUTZZSWFSUURCczVwKzdJeEN0Z0pmVVlycjRUUGZs?=
 =?utf-8?B?YnhhODI1S1Z5M0FHVXFRWUgxMFZQSCtuTXg1bmUvZi9BazVUdlZqRWJJZlp0?=
 =?utf-8?B?VkR4OFE0L1dYWGttdTlJTElmK0xReGNuNW9FOE12c0ZZa0FsWVpvdzlNRmJE?=
 =?utf-8?B?UlU5dk9FejlVVEdROFRhbVp3djgxNkVVNzZhY3lFcjEwSkVaTTExMnpmQ1Av?=
 =?utf-8?B?WnBHbm9DOTl3SzZ3L0NUTnYzb2llSXpYQ1I2blFjUkJqd0VxdGZRTDRRUDJs?=
 =?utf-8?B?b3orNThxdVNMRGgyMXZrTVJackdyN3ZzSnpTeEllZUhMcWdBSytwVkd1Rk5O?=
 =?utf-8?B?VFVNc00wQ1kyNXd3NU9pcUdHL2xlYnUzaWdpUmJmNGFRWktjMEZrUXk3UkdJ?=
 =?utf-8?B?dXg4K0tOcUFIVEJLZlpaU0t2bDEyS1dKbXNxT1QwWitpTHZmWStoZWtPUlJR?=
 =?utf-8?B?SXBOaVg2QzkrOWVodXhFZWVia0VwTTVNS25YTVRJRGlTc3BHaExKKyt6eERq?=
 =?utf-8?B?U0JmSmNGQXAxWUtCVFhOVmM3N0xTNGJ1OXp0eVNiVW02dVZsa2ZpVFdnWUw5?=
 =?utf-8?B?UVFxMGoxRTQ3S1VoeFVBMElBTTRRaHF2aXBGanZhTURCblFFdElzZ3VnTlhX?=
 =?utf-8?B?OG9RY3dZR0x6NWYya3pYOU1reHMwNGRKWFVTR0tURkJaaFR6V2ZKWUdtL3Va?=
 =?utf-8?B?VFpPcjhxRWVOR3hFQlFYZUo5RU5yamNlSXRha1RsVmpkR09oUng3UjFFZzZr?=
 =?utf-8?B?YUNCbzJJTTZ5UHYvUWpZbHZvOVcra2RZcXJtaHFjQzhrVStmRkQ4N2ZiaVlx?=
 =?utf-8?B?VEppelVDUk85VkpIeGM5cWU1QW1oQnVSVUd4VE1BNHdURnk2N3RMaWgxVzF6?=
 =?utf-8?B?VnhGUjZqSlFacU9pYW9IVHlnK3V2QlE1S2g1Z2lZU3AwOXZMWXkvV0EyQ3VO?=
 =?utf-8?B?RkZkUjY5dVE5ajFNb210TFVyRkpKdkZsZUNkbFN5UWIxd3puQ0FoMy9pVGhE?=
 =?utf-8?B?UHRjNTg2OUJXV0hmVXZkYUtQOHdYR0l3bU5uSnY0RzBvOS92TG4zNHQwVTNO?=
 =?utf-8?B?Tk5NWi81ZUVTWnNRTVo1Lzl2a1lSNUNudEJIbDRoSzFyM2Z0NGpXbjJGcE50?=
 =?utf-8?B?TENpNDBwcUJVNHVxckRxYTg0aG5RcjRwenA5emd4cW5KbG9ycDdVZ3pnS3lS?=
 =?utf-8?B?bnlWQUNGZms4bFJoYUJVYWVRQWV0SldzeWNPWnZXZTZiaDl5N0xoQ2xpYVp2?=
 =?utf-8?B?eEdyMHJjOWIzK1ZobG5NWTNVcmhPczVTS21pQmVwUmpzTCtwZHVNVDRtcndN?=
 =?utf-8?B?d2dVTCtwcGlLdmJaWDN2RGJ4Y0FMV09lVjhhZWZTRTVzdVpGd2sxVnFEZ1c4?=
 =?utf-8?B?Z3dIM2NJQlFmelRaS3IrSzhTRWlYUGZwdFJLRWpVQlRtcDkybDJncmlKWVJ2?=
 =?utf-8?B?Y0lOY2dBWGlIUXlaS2RsemVlNEFFUjZ2WnRxdFVMWXpLUzFoSThSZUFTZ3Zi?=
 =?utf-8?B?dFgxNXJiaCtWNVhiaTJvRXE0TEttc3hkc0xqQnk1cFAxTlNTL1JuekpmQ2Vp?=
 =?utf-8?B?OXUzbFBlcDkxNW1zUnBVQlhIWkNSdER3QWU1bGZKUkZndkVSSDJEUWdMdHo3?=
 =?utf-8?B?VTBMeXB2TktqMWp2aTRkbXdHM2dSN1hUVEIxb1hGREJPTW9WL2dtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676797e8-33d6-4c34-3a33-08dea4f3e1e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:51.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD9oDZjWs/qQPgkmqr2wccz0MVKkF30LFWOf+eOyzmIOtvE4P2tnoLauPmdGpPay5838ZDIdqJXmlIHPa0Tb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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



On 4/28/2026 2:49 PM, Christian König wrote:
> 
> 
> On 4/27/26 23:05, Felix Kuehling wrote:
>>
>> On 2026-04-24 06:12, Huang, Honglei1 wrote:
>>>
>>>
>>> On 4/23/2026 7:06 PM, Huang, Honglei1 wrote:
>>>>
>>>>
>>>> On 4/23/2026 6:39 PM, Christian König wrote:
>>>>> On 4/23/26 08:21, Huang, Honglei1 wrote:
>>>>>>
>>>>>>
>>>>>> On 4/20/2026 11:37 PM, Christian König wrote:
>>>>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>>>>>
>>>>>>>>>> Add amdgpu drm SVM API definitions built on the
>>>>>>>>>> DRM GPUSVM framework.
>>>>>>>>>>
>>>>>>>>>> This includes:
>>>>>>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>>>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>>>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>>>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>>>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>>>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>      include/uapi/drm/amdgpu_drm.h | 39 ++++++++++++++++++++++++++ +++++++++
>>>>>>>>>>      1 file changed, 39 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ amdgpu_drm.h
>>>>>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>>>>>      #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>>>>>      #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>>>>>      #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>>>>>        #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>>>>>      #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>>>>>      #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>>>>>>      #define DRM_IOCTL_AMDGPU_USERQ_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>>>>>>      #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>>>>>        /**
>>>>>>>>>>       * DOC: memory domains
>>>>>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>>>>>          __u64 matrix[12];
>>>>>>>>>>      };
>>>>>>>>>>      +#define AMDGPU_SVM_FLAG_HOST_ACCESS 0x00000001
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL 0x00000004
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO 0x00000008
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED 0x00000040
>>>>>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT 0x00000080
>>>>>>>>>> +
>>>>>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>>>>>> +
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>>>>>
>>>>>>>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>>>>>>>
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>>>>>
>>>>>>>>> Why are those separate attributes? What is the difference between those?
>>>>>>>>
>>>>>>>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>>>>>>>
>>>>>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>>>>>> it can not migrate, GPU only can access it in the initial place.
>>>>>>>
>>>>>>> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
>>>>>>>
>>>>>>> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
>>>>>>
>>>>>> Got it so can I change the UAPI to the following format?
>>>>>>
>>>>>> enum amdgpu_ioctl_svm_attr_type {
>>>>>>       AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>>>>>       AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>>>>>       AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>>>>>       AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>>>>>       AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>>>>>       AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>>>>>> };
>>>>>>
>>>>>> enum amdgpu_ioctl_svm_location {
>>>>>
>>>>> The enum name could probably be improved, but apart from that looks reasonable to me.
>>>>
>>>> Will improve the name.
>>>>>
>>>>>>       AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>>>>>       AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>>>>>       AMDGPU_SVM_ACCESS_MIGRATE = 3,
>>>>>> };
>>>>>>
>>>>>>>
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>>>>>
>>>>>>>>> Why is that separated into set and clear flags?
>>>>>>>>
>>>>>>>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
>>>>>>>
>>>>>>> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
>>>>>>>
>>>>>>> As far as I can see just a SET_FLAGS should be sufficient.
>>>>>>
>>>>>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient method for deleting large-scale flags, do we need to redesign this part?
>>>>>
>>>>> I think we should expose those flags as individual attributes then.
>>>>
>>>> Got it will do.
>>>>
>>>>>
>>>>>>>
>>>>>>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>>>>>>> +
>>>>>>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED 0xffffffff
>>>>>>>>>
>>>>>>>>> No location for device local memory?
>>>>>>>>
>>>>>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
>>>>>>>
>>>>>>> Absolute clear NAK for that approach. This interface is per FD!
>>>>>>>
>>>>>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>>>>>>
>>>>>>> We also need to make sure that setting attributes for different devices doesn't affect each other.
>>>>>>
>>>>>>
>>>>>> I Totally agreed with your thoughts, but according to the reply from matt, it seems like we need to consider the P2P/multi GPU situation.
>>>>>
>>>>> When the drm_svm or pagemap component has already code to deal with that then it is probably ok to have the same interface.
>>>>>
>>>>> When when XE only hacked that together on their own then that is a bit questionable because getting the lifetime right is usually tricky.
>>>>>
>>>>>>
>>>>>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to modify the UAPI to align with xe_svm?
>>>>>
>>>>> I think we need to full clarify how XE works here. E.g. that you can specify both 0 as well as give the fd to get the memory migrated to the local device sounds odd.
>>>>
>>>> Got it, for this part maybe require more discussion and time to fully understand, so this part will remain unchanged in the next version.
>>>>
>>>
>>> Hi Christian, Felix,
>>>
>>> Based on the v3 review, I've reworked the SVM UAPI. Please let me know if anything still looks off before I post v4.
>>>
>>> Changes with v3 UAPI:
>>>    - OP / ATTR_TYPE / ACCESS / LOCATION converted to documented enums.
>>>    - Three ACCESS_* attribute types collapsed into a single
>>>      AMDGPU_SVM_ATTR_ACCESS carrying enum amdgpu_ioctl_svm_access.
>>>    - ACCESS/MIGRATE renamed to ALLOW_MIGRATE to means permitted, not required
>>>    - SET_FLAGS / CLR_FLAGS removed; each former flag is now its own
>>>      attribute carrying enum amdgpu_ioctl_svm_flag_value: CLR / SET
>>>
>>>
>>>    enum amdgpu_ioctl_svm_op {
>>>            AMDGPU_SVM_OP_SET_ATTR = 0,
>>>            AMDGPU_SVM_OP_GET_ATTR = 1,
>>>    };
>>>
>>>    enum amdgpu_ioctl_svm_attr_type {
>>>            AMDGPU_SVM_ATTR_PREFERRED_LOC           = 0,
>>>            AMDGPU_SVM_ATTR_PREFETCH_LOC            = 1,
>>>            AMDGPU_SVM_ATTR_ACCESS                  = 2,
>>>            AMDGPU_SVM_ATTR_GRANULARITY             = 3,
>>>            AMDGPU_SVM_ATTR_HOST_ACCESS             = 4,
>>>            AMDGPU_SVM_ATTR_COHERENT                = 5,
>>>            AMDGPU_SVM_ATTR_EXT_COHERENT            = 6,
>>>            AMDGPU_SVM_ATTR_HIVE_LOCAL              = 7,
>>>            AMDGPU_SVM_ATTR_GPU_RO                  = 8,
>>>            AMDGPU_SVM_ATTR_GPU_EXEC                = 9,
>>>            AMDGPU_SVM_ATTR_GPU_READ_MOSTLY         = 10,
>>>            AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED       = 11,
>>>    };
>>>
>>>    enum amdgpu_ioctl_svm_access {
>>>            AMDGPU_SVM_ACCESS_INACCESSIBLE          = 0,
>>>            AMDGPU_SVM_ACCESS_IN_PLACE              = 1,
>>>            AMDGPU_SVM_ACCESS_ALLOW_MIGRATE         = 2,
>>>    };
>>>
>>>    enum amdgpu_ioctl_svm_location {
>>>            AMDGPU_SVM_LOCATION_SYSMEM              = 0,
>>>            AMDGPU_SVM_LOCATION_UNDEFINED           = 0xffffffff,
>>>    };
>>>
>>>    enum amdgpu_ioctl_svm_flag_value {
>>>            AMDGPU_SVM_FLAG_CLR                     = 0,
>>>            AMDGPU_SVM_FLAG_SET                     = 1,
>>>    };
>>
>> Looks reasonable to me. But I'm not sure you really need enum amdgpu_ioctl_svm_flag_value. I'd just use 0 and non-zero to mean false and true.
> 
> Yeah agree. We also should have true/false in stdbool.h or by the C standard itself.
> 
> Apart from that looks good to me as well.

Got it, will remove amdgpu_ioctl_svm_flag_value according to the request.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>>
>> Regards,
>>    Felix
>>
>>
>>>
>>>
>>> Regards,
>>> Honglei
>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Honglei
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +struct drm_amdgpu_svm_attribute {
>>>>>>>>>> +    __u32 type;
>>>>>>>>>> +    __u32 value;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +struct drm_amdgpu_gem_svm {
>>>>>>>>>> +    __u64 start_addr;
>>>>>>>>>> +    __u64 size;
>>>>>>>>>> +    __u32 operation;
>>>>>>>>>> +    __u32 nattr;
>>>>>>>>>> +    __u64 attrs_ptr;
>>>>>>>>>> +};
>>>>>>>>>
>>>>>>>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>>>>>>>
>>>>>>>>> And we usually use unions in this header to separate the input from the output parameters.
>>>>>>>>
>>>>>>>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Honglei
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>      #if defined(__cplusplus)
>>>>>>>>>>      }
>>>>>>>>>>      #endif
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
> 

