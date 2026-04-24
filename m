Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6817AFE51FB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A5D10F4B5;
	Fri, 24 Apr 2026 10:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wm+eHpy1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A10C10F4B5;
 Fri, 24 Apr 2026 10:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSucteUWa1NO9CXqah42Sk0WyETUjqKPrLebWKhgwb7Q7s1lVZVtB5U7mv79s1Xy7PqChRdY0R6rjCVtyFxD8OM3vE6fN+iuUHNwuANsMLCjQu0DwQ+BWaGU9uphqOtF+k3MEwpDYyn0AA0Ue+FsTRfNCwWC9ya+KQLGL9/8WhDpDs5ix+sAn3GezZSrbdioUl4oHeiTTHgr8HZMB2d0TyRHDuQIMYV2U/fjyjzmpzwhSXwOC0V14orf5H/VHPdPZCIbBExaf8N0zqKhmf7npFepiT9k9CBjzvqwG5twLRsMzklJXeqo5LFDnm5EFtAjAtU5VtkDs0yvj8Gv+cDlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7X6PfH2jkuCLoC8M0g9FuiLQHlZXv9roitp7nw1IKo=;
 b=PMIy2xzV4R8hxwdqK0nxhi4tAHYtSjaZPsHqVIxa5G2PfReIy73XF12uKWQSEX/R6OPb8e4ikpEB01IuDBhkLKPz5kEpVabmCEOtmZiBx7WHK/J82eSIMe4PB5T9h6EZCm1sxz/e/KqO34MFLP3I6K1X4+f85OuCB0llwU/SIvWvKbje49FKvdOlobXq//TOZ7722o70iOW199XEG1/YEVBDLQ0hfam70UQv7aPviJQ7nSio+IYI8DaoDqIanCnyG4yr95kcLVRc+HpVGmlJJwtHQMg9Kh6n07HAkIwMhzNPndDX+5zGz6B+a4FG1WK9nsk85f/WDZhp5K1pX9Qbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7X6PfH2jkuCLoC8M0g9FuiLQHlZXv9roitp7nw1IKo=;
 b=wm+eHpy1dZ/3HwGgUSXmZX/t1QDTo9uBzpxCyHdz9gCL77JsTh8KUTSEGMVLl0dBDUB8WE+a07i7tZtlruWbnha7cAmGsiMhGf3y2Kpy68CttOWiZikbvnxiPcixP7xU+DxILOXzIeUeZ7UbMasvBDXD6IzA12XGmzG8MVUH7Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.14; Fri, 24 Apr 2026 10:12:35 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:12:35 +0000
Message-ID: <9c5afd4b-f9f0-445a-9b39-35f56fa2bea4@amd.com>
Date: Fri, 24 Apr 2026 18:12:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
From: "Huang, Honglei1" <honghuan@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix.Kuehling@amd.com
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
Content-Language: en-US
In-Reply-To: <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0088.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b80cd9-9384-4d89-cfbd-08dea1ea010e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: AiSXp9NVaV4OW57peL967FpekUbhgAZbbTKq9p8cQUVpv+Pc1wqJZkvRM5WcQoMz/SjEGBNECvu5DKIPcMgL4M7rnlgOcJ3PM0fRu1nDCD2pXHdJYUn+U4gOU2WcI1DyhscUcE4NrLNPdjBpvovXb4aKOUOQJqoGEKMVFIeG6tUYvo5xBWudhxsz6bbPfi1zhGbC7h/GYIZ79dnC9QbQ2aD+OeK6kJrC07iTHk1Cwa96wz959nq9U22/oaodkCnvKizoPkV2PF0O6fcxal9+cpY8Yi2Lq8jj1xGNLT1s2d+Jf/AYYoChW0X+uPDAVO7ljgrdW/h/Elb8uynvtf1w9mVlDjqDy920fR7SYaMjw3r1kjk2/OD/YKK2qG2mVmMEZqWPSNCr0VN0Cba5uP/85oP54H8CLx39tu2cGo1KNuuh3+uN3VMi77dMvloxMU2Kialvrs/+uHMl7lsbrvH2s92Gt+8aHYitep0nFfku7vXUAs/YmthtcATGIxUma1uxYLOMdqldD/oDui1VRXG1fttJjOIkvg049AEKihKJXFgvtLsA4wyLVQW3UsvSxkdM7FgcMfV8kNptnLjewxdQHJdTrfcf1xsj7CF2nvZm+16vXzZySMDnANuBBOIHq2qHhLYhlbMlvGP1G9djilwMfhAiOK73HnpA5KPQXX/dKfQa4unXkih6U0B1kgr4Zc+OF5TiKrj9cB+n57WYqKQ5nBTTm+nBve29X5PTTd+9/4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJWTkcxQjFXdWo2SmdaZDVzeHovaThTbEd4Qms1elhONkN2ZUI1a1ZqUGJi?=
 =?utf-8?B?M2VDQzlYWE54eHZYUVR6bUs3QVh3Rmx3b01KOEpXV0dpK0xJSEJ2Z1hSRkly?=
 =?utf-8?B?T2hodm1pUGY0NkM2RG9DRGw4UHQ3aDNWdG1xS29IRnh0U3NlOXo5RDFiZUJF?=
 =?utf-8?B?eGhoR083UHdoUXpyTHRPVWVjZitWc3lYaUsvRnptRVltSE9uVDRRWTk2TW4r?=
 =?utf-8?B?ZzFXaFVZQ2ZZRWErRTdRRW9mZ2N5SGxycldXV3Y4aFJtb2pkM3BCL1R4WE5V?=
 =?utf-8?B?UlF2a0U3TTBQb3dSWHhvWjZQK1ozcHB4THVXTStyVGRPclI0VDJQRWlqRGta?=
 =?utf-8?B?bUNOYnJHWEFaMjBvWWxFS0sxMnpLMkVtQTIvNWs1ckw1ZmE5M2lWdkF5YmY0?=
 =?utf-8?B?NkNubXplTFREdjdFS0hXbUJRdGw3bm5tWm8xT0pXeXBZb2lOUVJ5NCtzcmJj?=
 =?utf-8?B?bXJ4UlVWdVBCazk3eWVzSlBBZGdiWHVOUDE4bjk0WUNWQWFyRGE3WW9RZWRH?=
 =?utf-8?B?bnI0Rno5cXJQb0p4d2pWc0lmNHk5RVU1aEVIc2hhSjdGZ09vL25qbmRjNHpQ?=
 =?utf-8?B?SHRZSlNHWWVicXYzUkg4WjVQa2FSVGpaUkVtQVRHL21iTldMak5nUDdLV2xD?=
 =?utf-8?B?bzVvUHBtSHJyOFljMHZUZDZLdVBvTXZoSldzeWlNSlJUVUM3QUFIZ01qMnpL?=
 =?utf-8?B?L1hzNC90M1ZTdzVTbjJ6Sjd6T1czZnVkSFZGV1JHNWV0dFhpRjZFYkEwdk5t?=
 =?utf-8?B?RFNSOXljVlBkei9jSmkvSk9lRjFSaHU1b3JrcTBJZVZWRlM5cXBYTVNldTNk?=
 =?utf-8?B?bEFTeFhWM2Z1ZW9hSW50T3pvMlVFS2h0ZjU0MXJHNEpHWXZQVDBjdW4wMUxM?=
 =?utf-8?B?dlZDdGtLNnpiQlhZeGkvaXlaZTArcG9POG1OYTh1UEh2UlIzc0VLc3lBWk0v?=
 =?utf-8?B?QVdYbFcyb0traFF0NHlUd1F2QStPZlNJUStaTnVIVVFFOXBrY2czMW5xbytU?=
 =?utf-8?B?TzFRc1pWRDlvMXFTalJHL0o4cWJVVXp6TStRMTF4ZFI4VE5YQ0xNSzNQbXpq?=
 =?utf-8?B?S0lmM2hmRHY3cDlmbTh2Vk8rSlNjeTc2UC9rejdxRzh1bmp4elVzTUdJdmZS?=
 =?utf-8?B?SEtab2tRTlBoYjM2M2dub29wU3VSQ3lUdjcwK053TVk3VytsT1kzQ2xQcGZH?=
 =?utf-8?B?TmNYNjJkcy9CcUQzVE5XUUdqR2pWb1JTY25haUs3Nmk0MWthQWZhM05oNk5l?=
 =?utf-8?B?emtUMXNvaXorcW05Vk1NRlhFVGFCMmp0eHhONlJjV3JkWU1JVmhzbW9ocTF2?=
 =?utf-8?B?NTg5cW9KUmZyRmFidGMyT29jTGc4bkIvSHEvRnV3T25UaTFFTGN4a3NlQ0ov?=
 =?utf-8?B?MU1yRFQzdU1JK1kzWHl6b291NVBmcXBlL0xCR1Z3R0pqS3RiQzZzU2M5RHZL?=
 =?utf-8?B?TG1lY0tNQU55aG1jT3hQUm5DUXRXNlZiY3g4K2NnT2xNMTVYWnlFTFg5NG4x?=
 =?utf-8?B?ZlBuMUczWkxMUzlSWGdIODJOT2g5SlBRa3RvOGpDdHd3V29KVEV4S2xORmo4?=
 =?utf-8?B?SG1Jd2E3TDhXQVlROTZhWWNaRmc5SE53TDZIWGJtSjFWTGlNNERMTWVROXd5?=
 =?utf-8?B?VitwMG9obitqdWhnTlIzaE5QMUNTL2plV0UwYzFzM0dCVFdqd29rRTVCWm5v?=
 =?utf-8?B?Zi9rblU4RzJDSDJmUllYWVY3SVVyRS9HMjdNLzFKd2JkREZOamJzVmtTS005?=
 =?utf-8?B?T1UxcnZmZkNzNkJia2U2d2lNQjlZSTAzQm94QkFPcE9VRnNjdXdvVERKWVo5?=
 =?utf-8?B?ckZEbXlOejlFWW4rNjJmRUJUNWNxa1V0dFpmWlZlcHFpUWJ0QVBNYnZnSVRV?=
 =?utf-8?B?TkkvaU5VdTNJSmFkaUZaY0JVR2VyUmRNWk5SOXRyTzl0bFA4ZXE5U1NjcCtD?=
 =?utf-8?B?YmVNSEJzZTlOYjJ6MmlTNE1rMzg5NUVCSXZsZUsrMG9qZHdRYlR5dFJqVjNx?=
 =?utf-8?B?emV0TXlyYjVWNXo4U09uUXpKalNaaURoS2lVOHE1ajNsazBMVjM0cWFXOFpx?=
 =?utf-8?B?YU8yTy9PVnZqOHEySE9QTnowdmRhK1ovSS8xNnd0QmVaMEFCS1NnUDcyWmhC?=
 =?utf-8?B?VkwwSUNEd1RsWldYQTEzem1jTU4vaW1vSkx4UFFzOUh3N25Za2FzbFhGNm10?=
 =?utf-8?B?VTNYRWdNZFl5WXdnNi9peThFQTFKWDRPbkEycGVZNnFrT2kvR00vVU4yQ0NT?=
 =?utf-8?B?SGVzSWp6LzR0RVBabkRVVWFYOFA3eS8vZWs3cUNSeUtGMXA4RlBaT2xXc2pr?=
 =?utf-8?Q?qJ0nvKlNw46e57HpYA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b80cd9-9384-4d89-cfbd-08dea1ea010e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:12:35.0587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmdjK0u8gxYH/tsRynCYj5XSxkcjCLWdBvPZROO937u1cxGGevXnFSKnNy+cg6gI3aXceGEwkQf6+R+6s0ge3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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



On 4/23/2026 7:06 PM, Huang, Honglei1 wrote:
> 
> 
> On 4/23/2026 6:39 PM, Christian König wrote:
>> On 4/23/26 08:21, Huang, Honglei1 wrote:
>>>
>>>
>>> On 4/20/2026 11:37 PM, Christian König wrote:
>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>>>
>>>>>>
>>>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>>
>>>>>>> Add amdgpu drm SVM API definitions built on the
>>>>>>> DRM GPUSVM framework.
>>>>>>>
>>>>>>> This includes:
>>>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>>>
>>>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>>>> ---
>>>>>>>     include/uapi/drm/amdgpu_drm.h | 39 ++++++++++++++++++++++++++ 
>>>>>>> +++++++++
>>>>>>>     1 file changed, 39 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ 
>>>>>>> amdgpu_drm.h
>>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>>     #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>>     #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>>     #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_CREATE    
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union 
>>>>>>> drm_amdgpu_gem_create)
>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP    
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union 
>>>>>>> drm_amdgpu_gem_mmap)
>>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct 
>>>>>>> drm_amdgpu_userq_signal)
>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_WAIT    
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct 
>>>>>>> drm_amdgpu_userq_wait)
>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES 
>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct 
>>>>>>> drm_amdgpu_gem_list_handles)
>>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>> DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>>       /**
>>>>>>>      * DOC: memory domains
>>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>>         __u64 matrix[12];
>>>>>>>     };
>>>>>>>     +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>>>>>> +
>>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>>> +
>>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>>
>>>>>> Up till here the interface makes perfect sense, but then it 
>>>>>> becomes a bit fuzzy.
>>>>>>
>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>>
>>>>>> Why are those separate attributes? What is the difference between 
>>>>>> those?
>>>>>
>>>>> Really thanks for the comments, I have some content mistaken in V2, 
>>>>> so I updated the V3 to fix that. For the header they are same. for 
>>>>> other content please review the V3, sorry about that. And will fix 
>>>>> the concern you raised in next version.
>>>>>
>>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and 
>>>>> AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and 
>>>>> the SVM can set the preferred location, it can be in VRAM or 
>>>>> system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM 
>>>>> and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>>> it can not migrate, GPU only can access it in the initial place.
>>>>
>>>> Yeah but that doesn't then the interface doesn't seem to make sense 
>>>> since such states are mutual exclusive.
>>>>
>>>> It would make sense when you have some attribute which is named (for 
>>>> example) AMDGPU_SVM_ATTR_ACCESS which can have the values 
>>>> INACCESSIBLE, IN_PLACE, MIGRATE.
>>>
>>> Got it so can I change the UAPI to the following format?
>>>
>>> enum amdgpu_ioctl_svm_attr_type {
>>>      AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>>      AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>>      AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>>      AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>>      AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>>      AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>>> };
>>>
>>> enum amdgpu_ioctl_svm_location {
>>
>> The enum name could probably be improved, but apart from that looks 
>> reasonable to me.
> 
> Will improve the name.
>>
>>>      AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>>      AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>>      AMDGPU_SVM_ACCESS_MIGRATE = 3,
>>> };
>>>
>>>>
>>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>>
>>>>>> Why is that separated into set and clear flags?
>>>>>
>>>>> This method inherits from KFD and is also designed to be compatible 
>>>>> with upper layer applications such as ROCR.
>>>>
>>>> That is *not* sufficient as justification. We need to document why 
>>>> that is necessary and *not* just say ROCR works that way.
>>>>
>>>> As far as I can see just a SET_FLAGS should be sufficient.
>>>
>>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient 
>>> method for deleting large-scale flags, do we need to redesign this part?
>>
>> I think we should expose those flags as individual attributes then.
> 
> Got it will do.
> 
>>
>>>>
>>>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>>>> +
>>>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>>>>
>>>>>> No location for device local memory?
>>>>>
>>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses 
>>>>> fd for device local memory.
>>>>
>>>> Absolute clear NAK for that approach. This interface is per FD!
>>>>
>>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the 
>>>> memory should be migrated to the current device.
>>>>
>>>> We also need to make sure that setting attributes for different 
>>>> devices doesn't affect each other.
>>>
>>>
>>> I Totally agreed with your thoughts, but according to the reply from 
>>> matt, it seems like we need to consider the P2P/multi GPU situation.
>>
>> When the drm_svm or pagemap component has already code to deal with 
>> that then it is probably ok to have the same interface.
>>
>> When when XE only hacked that together on their own then that is a bit 
>> questionable because getting the lifetime right is usually tricky.
>>
>>>
>>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need 
>>> to modify the UAPI to align with xe_svm?
>>
>> I think we need to full clarify how XE works here. E.g. that you can 
>> specify both 0 as well as give the fd to get the memory migrated to 
>> the local device sounds odd.
> 
> Got it, for this part maybe require more discussion and time to fully 
> understand, so this part will remain unchanged in the next version.
> 

Hi Christian, Felix,

Based on the v3 review, I've reworked the SVM UAPI. Please let me know 
if anything still looks off before I post v4.

Changes with v3 UAPI:
   - OP / ATTR_TYPE / ACCESS / LOCATION converted to documented enums.
   - Three ACCESS_* attribute types collapsed into a single
     AMDGPU_SVM_ATTR_ACCESS carrying enum amdgpu_ioctl_svm_access.
   - ACCESS/MIGRATE renamed to ALLOW_MIGRATE to means permitted, not 
required
   - SET_FLAGS / CLR_FLAGS removed; each former flag is now its own
     attribute carrying enum amdgpu_ioctl_svm_flag_value: CLR / SET


   enum amdgpu_ioctl_svm_op {
           AMDGPU_SVM_OP_SET_ATTR = 0,
           AMDGPU_SVM_OP_GET_ATTR = 1,
   };

   enum amdgpu_ioctl_svm_attr_type {
           AMDGPU_SVM_ATTR_PREFERRED_LOC           = 0,
           AMDGPU_SVM_ATTR_PREFETCH_LOC            = 1,
           AMDGPU_SVM_ATTR_ACCESS                  = 2,
           AMDGPU_SVM_ATTR_GRANULARITY             = 3,
           AMDGPU_SVM_ATTR_HOST_ACCESS             = 4,
           AMDGPU_SVM_ATTR_COHERENT                = 5,
           AMDGPU_SVM_ATTR_EXT_COHERENT            = 6,
           AMDGPU_SVM_ATTR_HIVE_LOCAL              = 7,
           AMDGPU_SVM_ATTR_GPU_RO                  = 8,
           AMDGPU_SVM_ATTR_GPU_EXEC                = 9,
           AMDGPU_SVM_ATTR_GPU_READ_MOSTLY         = 10,
           AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED       = 11,
   };

   enum amdgpu_ioctl_svm_access {
           AMDGPU_SVM_ACCESS_INACCESSIBLE          = 0,
           AMDGPU_SVM_ACCESS_IN_PLACE              = 1,
           AMDGPU_SVM_ACCESS_ALLOW_MIGRATE         = 2,
   };

   enum amdgpu_ioctl_svm_location {
           AMDGPU_SVM_LOCATION_SYSMEM              = 0,
           AMDGPU_SVM_LOCATION_UNDEFINED           = 0xffffffff,
   };

   enum amdgpu_ioctl_svm_flag_value {
           AMDGPU_SVM_FLAG_CLR                     = 0,
           AMDGPU_SVM_FLAG_SET                     = 1,
   };


Regards,
Honglei

> Regards,
> Honglei
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +struct drm_amdgpu_svm_attribute {
>>>>>>> +    __u32 type;
>>>>>>> +    __u32 value;
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct drm_amdgpu_gem_svm {
>>>>>>> +    __u64 start_addr;
>>>>>>> +    __u64 size;
>>>>>>> +    __u32 operation;
>>>>>>> +    __u32 nattr;
>>>>>>> +    __u64 attrs_ptr;
>>>>>>> +};
>>>>>>
>>>>>> Those struct make perfect sense but clearly need documentation. 
>>>>>> Preferable as kerneldoc.
>>>>>>
>>>>>> And we usually use unions in this header to separate the input 
>>>>>> from the output parameters.
>>>>>
>>>>> Got it will add documentation for it and will use unions in next 
>>>>> version. Really thanks for the comments.
>>>>>
>>>>> Regards,
>>>>> Honglei
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> +
>>>>>>>     #if defined(__cplusplus)
>>>>>>>     }
>>>>>>>     #endif
>>>>>>
>>>>>
>>>>
>>>
>>
> 

