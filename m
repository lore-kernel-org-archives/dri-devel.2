Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008DCF327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119FB10E7EB;
	Tue, 21 Apr 2026 06:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ih5iuMmw";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000AA10E7DE;
 Tue, 21 Apr 2026 06:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byKOq2zJBrhV2u1uChJmYhMWc8of16exZW+8yUwjA7u+pQAn6l+Nq98hsSBglewUJoAIlCesIEwalxr5TYAPkcD4Q4F8qSolyEL46lrW/24LVmyuG+w9BZcVRGGA38kbeL8JXG+TColkqU+v3xzd8GY0+C3c9pIDJ6hWbjqmyT866TUF1Rx9Qr++3H7Yf9OQFBYKfXb/ifbXqKXEuIGbaLmk+WGO2EJ74ZTS7xDFeGe+uLKjavF95nBPHnn70Jrh7NfTKXldNBvAFW8Hf0Nm8Q/yqBbZQD+6uAOc1JYotfqcwHgoBS8f8cGdpE423VGhwPuyRlqeFUZ4FbtBQDj2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRI1nMnuB4W1KqCpGAp5qSsl55DGQz7aUwcPqN4dOtE=;
 b=uVFtU7WPTx42f96Uh7Bnw1W2i+A/uPSB4ArQ7GVzioSsphakJ+8fugLfScPiwB9sWZzXTJz/jiYTxBuTHHIXksSvb4SQFBYBz8X52m8yEeXZGpPZMGpKVMSG/vaghJ8iFBusecrMvPu5OeiFAHi+Mm2hgJiOCv1ROLU32VoUb+ZyuOLeEHZjr8elLZC/4mqNKRrhqAWIfptKmZxKrFK5ZROKJLp5A+xTbvWcR7jCB1Mo9Oqit3aqa1HiH2ykQN8LAmHkcxazlDDx53MQdCPKz8isL+6rUEBiwrZ8O2gta9pQsWt0oB1Q4CEOUe7ts0dTV7+NLK/LN/uEMqQNvvnH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRI1nMnuB4W1KqCpGAp5qSsl55DGQz7aUwcPqN4dOtE=;
 b=ih5iuMmwytingjBXWa8e0XIcohMZ2AZluiAdkp20uoPWQfPPfqu7YNytma+kV2M7wmMLvLkjRWh1hr8xaKFH9eHS5AKRMwiilF7jN+0ZNZECESLHIu2JvDwCEpwvGsnxO7VASeoMcSW2cEmD3yjyBYLtpecowYOTqRNsOh1z1oQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:39:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:39:08 +0000
Message-ID: <bf8f0174-c986-4b11-8c83-4be88794c45d@amd.com>
Date: Tue, 21 Apr 2026 08:39:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Alexander.Deucher@amd.com,
 Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com,
 Xiaogang.Chen@amd.com, Ray.Huang@amd.com, Lingshan.Zhu@amd.com,
 Junhua.Shen@amd.com, matthew.brost@intel.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 honghuan@amd.com
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d4c92f-cffb-4486-86a9-9e457b879632@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <50d4c92f-cffb-4486-86a9-9e457b879632@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a62c6e-a1a6-4fd9-3648-08de9f70b030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uPlh0Y62FLO5ilnzpAy3GqBAICwYhkxIJERpO9l6eix5cRR/lcdTuIVN8zNJArftL9n5fDEGrhp4BkEL+lP48P+v1OXlbEummXyDUPi2NP7UzJ0a1v4GPe1PmHvc3Mv3P0b3ICbYRD4NbvuPYefjdfAmW14pUow9pIAg50xbGhv6zhJTomCj+nGmNcB5Yugq80oh1j0dX5a7AYd6NWMJGXXVp1q4IMJhmfyNBkNItWnf6IXz8b5t2/mUXDhEmSScY2OI4FcPTpfJTpX2LC7QMj4+KHaGg+xFdi08NYJprDdqN2hEKtA/qusRXog48r+2pie5ZB9QIEwwSMO2RGqGZPa53CS2SEIp1Dwqperp9DBKt7B5f3RkLdtgVhgd5IBarcZGdAZ37t4mg8sH7+mZqe42PbxvF0AeTpzoSAkbUK2umG5zv79PCTJNaOB0gWOm5fefuEg7dcN4wJ91uSbG9K2g5QoTRpMI5LxQ18BVI7dNnKZ5t1lvckiwOWvEREM+81HCalgSoUSPGNt6+DDvIV6SZtJ1YVf+7ojNXCRPpexx85BC06Nhi1XVVjTRNyx7A+4hTqSJv10a+IEDcwp4vWQjl4WX8Kjlq4jlMwSYb5dO38sBaYy3LI3zLXsDpNya6/5fBhX6KfzEbooE5QyCsWbUHj/CKlJqJHgZaK+XkO3wAiobn22oxSZIXLF6I/MIrbr4irJefhOn7vwEUxgkPrqVJk1vXOwEF3nhVSGwKA8XZeQpm1o33IllWOThteofQ39QcW7CIj+ztZ2ri0epjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDl6Nm1uMU5LVjJpRmY3TWM4dWJyUW13ejFjN3FCMTZUZFZxZWFuK3l3WUFa?=
 =?utf-8?B?c2xCOXN4a2hpdXlCUE5LbDdPRHBVbEJoVlhGa1EwTlZMNUM4Q1hhb0Jmbnpx?=
 =?utf-8?B?N25VNkptOVlFUDVyT2ozNHZFSCtES0p1WFhheG9aZWJRbVVIM1U2a2NsRHMx?=
 =?utf-8?B?UFBMLzNuUWRsdkhRTy94VnkxamhqVHZNQ1pYTlh6SWEzNU5jMXB3UFJTc0Fu?=
 =?utf-8?B?L2pQbHpVVUxKaFJOZ2xleXFHNmpLWW5RQndaWXVwQVBqbEg0d3VzQ3JkcEN6?=
 =?utf-8?B?RDRBT2VuSWJ1dDB3dkhCYVNILy9vWUJRdDlpQlpUQXAzTlVxeGQ2QlJQWGVp?=
 =?utf-8?B?VXZBNzJVVkJrS29xQ0d5VFFmTE9jRXhpbFNLcE16R3FrSWJxUkJ1TzhjMFNG?=
 =?utf-8?B?MU55Y2dWWmg4MlNQa0VqUkFDM0RCNHB4KzdxT3dtanRnT2NRMUhzdm5WTmNZ?=
 =?utf-8?B?WHI0ck01eDFVQ2NRQjlsQm01ZENLcEVxNm4yaVhxUkVsOEF1WFZxN1BJYVFX?=
 =?utf-8?B?aVlkY2w0R0xPYWZYclRhVmNGL001NGtZWTVBaUVQRy9mQlpXTmxPZnFsQ0Mw?=
 =?utf-8?B?NGhBTWZLOGwyMGZtV3dYdmlqMXV6dUhoTDJldUpPOUQvSCtQOEU4VFM3eWxm?=
 =?utf-8?B?elRSWlMxcDZWSW91WDNvcmtuQ05abmtrNkx6UG9qbnRxcUt6MWFHSjl6aWJH?=
 =?utf-8?B?b3FkWkhXRGJnNW9aeGVieHVqRlppUDJNb3dvQStQU0NRTnN6Y1pMc3JwNWZl?=
 =?utf-8?B?NHd1d2VUanZOWTEyc3J2dTdJbHdlTlRWQmFOUDRtTFprSGR3bTVxZjBZMGFY?=
 =?utf-8?B?bXJoQndWNUxhdEszbm5mazh4enpDTjlYcDBub2pKOUVkTVkvM1czL01rSmRk?=
 =?utf-8?B?RXVpcnplRXhDazlSbFNnMHBWQmlGQTNwRnRkTFVCWFdJdVBEV2F4ejZHQ2Fy?=
 =?utf-8?B?VTFpcjNHMlcrT3JTSnk3ODRKRHcwOENWSlNHd2pGaTEzcnltTVJGSi9nc3Ra?=
 =?utf-8?B?dk5wWmI1S2U2SjYrbWg2Q1RRMDQvN1I5ME5GNlZqOENVRG1iL3N4eDg5ZjVJ?=
 =?utf-8?B?YTJ2VE1ldWJ6RTgyaVA2UWpqNTJQZzRzYUg2aW95Yk5kdVJDN0N5Ym5TUHBr?=
 =?utf-8?B?S09KWmVRSzliUUMrNGV0bTJEZ1J5RVJaem45d1Q2MzJBVlNocTFCWHhjN1Nz?=
 =?utf-8?B?ZTRoQVdXR1dJVWpPUEFyTXI1OXZ3UXNUZzhIZEdWNExSZ3d3NGpkS3dRYTlN?=
 =?utf-8?B?YVhYUUN4a3VKWC9wMTkyd1M5dFc5V3FsZzE1VlA1UVZPYmRlYWZtdHFHZFo5?=
 =?utf-8?B?OE5ES25VV1d3eTNKbEtqQUJSSjQwd080TGFCclVQVU1rS0hGNGtmbDhqVFJN?=
 =?utf-8?B?UHZ0NWM4azhNOVpVUEM1eFdDcXFJU3Ixc2JyTThlL0ZxcWVMRlFiOUQrOG80?=
 =?utf-8?B?SW5kak1UMzFGYTYrVnB5aXRpMEJFcXVycnN6SURKZ3A5Q0JpTTA4UVF2MlNy?=
 =?utf-8?B?M2I4RGJYa0tUeUd4VXIvRWppOHNxU1V1NEwrNklHNUdwUFczUTF3T2oxczR6?=
 =?utf-8?B?cFFQKzlFN2xSUTdreTFuUU1xTVZNWmRHUnJXd3l2a2VwNzVYUlI0MnMvUWJV?=
 =?utf-8?B?YmVoT0xwelRUdFVBWU9Zb1QrYm1hRmRrQVRweS9maXhLSFQwT2JEVnozMGRo?=
 =?utf-8?B?a1Z5UUlLSDJoekx0NlppTTFFNHc4RjlVak0ySlNubzBvMmVCN0xQNW1RYkts?=
 =?utf-8?B?ZGtsV0ZrZ05FbWFybk1YVy9PaC9sY01qOENLOGxKMHBRRmh3bGRoNkFTT0Na?=
 =?utf-8?B?cXFpYUlkZURVb2c1Qy9nZTFZN2JERml3VEs5ZFpadkl3alE3QXBWSFRMMzFD?=
 =?utf-8?B?b1Vxc0VWWithRmQ4SHFrQzNFeGRzTFBOcGJXaXlSZUlPK1o0SkJLbmtDejl5?=
 =?utf-8?B?RWhudng0ZG5mSVVRQlpKTWNmZmNadmFBVmc5eXl6eld6RCtwV2tkVk5kZ2du?=
 =?utf-8?B?UUs2S0gxOTZxVVFEUWVnOVpaQ1JrTjZVdmV6WElYTTl6cXVja0REWU1JSTZa?=
 =?utf-8?B?ZVpNaTNJQjNTUWhPSm95UDZHd0hGY3AvRHZqdlhJV213RVRQY05sSjhVY1lQ?=
 =?utf-8?B?K0NOdkZSWFhnSVRJbjcxWFJ4cjlNZlBGMlF5V041NytRNFRYRm1rSklaQnpG?=
 =?utf-8?B?ZTk1NjE2bE42Mk1INFhtd1lGamI0STdiQWtURm5UNzRUQVZXRlRBL3JQQXlu?=
 =?utf-8?B?d2UwVnFEZDV3dGlaVlZKWG56RHBqeHVvYm1tNkJZRE50dVpVNDhiUXM4SnEy?=
 =?utf-8?Q?vTpfpiM6WaiU+8e7mb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a62c6e-a1a6-4fd9-3648-08de9f70b030
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:39:07.8177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbO/kujmW3ZNkG8dh0usZOhN5+pXatoB8ZowuOFUhD4eOkCQ2H6ADab2j0L+fRgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
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

On 4/21/26 05:37, Kuehling, Felix wrote:
> 
> On 2026-04-20 08:15, Christian König wrote:
>>
>> On 4/20/26 14:07, Honglei Huang wrote:
>>> From: Honglei Huang <honghuan@amd.com>
>>>
>>> Add amdgpu drm SVM API definitions built on the
>>> DRM GPUSVM framework.
>>>
>>> This includes:
>>> - DRM_AMDGPU_GEM_SVM ioctl
>>> - AMDGPU_SVM_FLAG_* flags
>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>> - AMDGPU_SVM_ATTR_* attribute types
>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 39 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index 406a42be4..bed71ed9b 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -58,6 +58,7 @@ extern "C" {
>>>   #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>   #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>> @@ -79,6 +80,7 @@ extern "C" {
>>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>     /**
>>>    * DOC: memory domains
>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>       __u64 matrix[12];
>>>   };
>>>   +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>> +
>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>> +
>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>
>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>> Why are those separate attributes? What is the difference between those?
>>
>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>> Why is that separated into set and clear flags?
> 
> This looks like it's based on the KFD SVM API. We created this so we could set or clear specific flags for address ranges without know what other flags were set or not set on different parts of those address ranges already.
> 
> E.g. you may have set an RO flag for pages 1-5, and set a COHERENT flag for pages 3-7. Now you want to clear EXEC for pages 0-8. If you specify an exact flags parameter, you wipe out all those other settings that have different values for different pages in the range. Instead this API lets you say "clear the EXEC flag on pages 0-8 without touching any of the other flags".
> 
> Alternatively we could have made all those flags completely separate boolean attributes. Making them flags that can be set/cleared in this way is more economical for how they are stored and manipulated.

Yeah that's exactly what I thought as solution as well.

I mean the kernel can store them internally as flags, but we should clearly have a clean and coherent uAPI for them.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>> +
>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>> No location for device local memory?
>>
>>> +
>>> +struct drm_amdgpu_svm_attribute {
>>> +    __u32 type;
>>> +    __u32 value;
>>> +};
>>> +
>>> +struct drm_amdgpu_gem_svm {
>>> +    __u64 start_addr;
>>> +    __u64 size;
>>> +    __u32 operation;
>>> +    __u32 nattr;
>>> +    __u64 attrs_ptr;
>>> +};
>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>
>> And we usually use unions in this header to separate the input from the output parameters.
>>
>> Regards,
>> Christian.
>>
>>> +
>>>   #if defined(__cplusplus)
>>>   }
>>>   #endif

