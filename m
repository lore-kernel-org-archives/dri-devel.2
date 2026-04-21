Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2591EA7184
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 03:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF29F10E79B;
	Tue, 21 Apr 2026 03:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t9YJ6TGQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5007810E763;
 Tue, 21 Apr 2026 03:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlzNI9QA72CN1hYtmhsJ5F5FArP81XNzI+Yah6F98JRB9n2hRRXrcM3WbqPflZb7K7jrJrTQFZ1VY6ZMlfvnpyIoHKRk2aD8X+jCb4RFFblbL4GScpGm2m4YvtxoOuPe2wy6pZqiMY66re5ykFFgynDApGnBcC5LVmFS3T36NSLh943hg0KiE3Y9uEUup3aApZWpL1sKW59u6w//U9ij2nYJHNeePCXHlMKa7x0D2bTPat9wN2OejfXHLSw+WAudh7kBp+Pqbw7P0PiCmyW/EgTJsLedrMZHKM1sSmVw1AjcYOu2OvRagpof7TFHHfTdyt0cWPTejw6zPrHKDUrn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVcSBfuqfSbaZCJB+ZOh5hFVFmIyUvNflWZUxc+rz1w=;
 b=jji+qUjz3GkZrJ6c6ARZHEX4XVRyvv/++22CatERyqKtrMP0jG80B4+XR9UNE/W3ZRz7OON/E3xSGtQcIvYwDjIGCgwvXVkKjQEt2cmHnOcjsML+z/1Zf8VCzzqH4LUVt7viw3mteM1AenPtCpZwMQpvxGJ5Yu9UuECIosR3lhr/DqEQX4MEvYl5FcjwYbx+td7hZySLT9Yeg9aZ2K9oW7vxypuIJqFFNPXqugjYHATweb7tXETR3BrtGOKj/SbOt4HFufPK2fbejT2ddN4+i9XusvhOo9KCSkUTeCSdJRC7ltN9QqILVboVT2yL1fgqMjVqPWexRuchzoymqpv55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVcSBfuqfSbaZCJB+ZOh5hFVFmIyUvNflWZUxc+rz1w=;
 b=t9YJ6TGQMNxETBOvHzKupWxX96x/KZK5CcyCJDlzNj9yJZjGF9f2t+fmiGPDaoIWzoc2wV8JYhhQX25upBAXWfuj5g2+2P8jQqD+wAfvPETJRN651QFUR8/xtBmcu8IvrOStJxi7/UrEOqyEIUvxbD/beeg1kZ7vGASJi3Qz7I0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 03:37:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 03:37:26 +0000
Message-ID: <50d4c92f-cffb-4486-86a9-9e457b879632@amd.com>
Date: Mon, 20 Apr 2026 23:37:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 60312529-cd0c-4ec9-baaf-08de9f574e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ff0wU+DXMJt1z+62BZzGxM00mW5daNjqnPIsAqSpa93QTDHXDsNQQBKzcSJyAUiZtdK2690pcx74ldQnKDF8Zp68owPyP1My80SRJ8hUJjdeu4T8aDqdNaXOw1Vr+BWFQNZEKS63sdMYLkRePXP3Mn9eckgNWjnQx556L/SuzeRSMf6PbXGFgKpmo6QTYUPOFxz7T6DT044v7X8IfG1s4jUq9qYSoDbyXFAGtT67YKl7E2LwvI6VEzY1m5gyEej5a9xFQebf/PlHJfM9CSMiLBCeHtbSxwbA4YzpMP4yAJngeGw2Op0UHTZh6mu1WT1uaDUMHs7x8TPEJq1kvKJq8qJbX5/K2S4azsxNZxwxXid2xm60OQHDcNIfGpvec62angV4DuoLJur0EWuFOq9UwovaERkf4UklDxzkq3B2rdzp1TioF+Te6tshFj6A7RmGy+kqxPHpdgFiGAf2+zpf5bQyCT387fwcLMglEivq40vaeCGV8DbhtnuKE6eXRgXeIWaTYmCp4Zrem/D3knur2GanNcakb8YBBu8Di2PDnt9GfvgSS9pp1TsOVdNRG1AIuobuP6T6ItfOmcO92UEN5gHyYKAfu+Xb8yEAww8Phv1hQb6NPMnrmh2a3ajnyXaKYfkU08oFvx9oFnCP7MDtVu3Qh8mfdqUXkBsio92aLze7H6HTklt5FT17pPzsyCgrq+j9qSmKloxsGgWrZBXgenmx3NOUw/xbpym0zzok6F/tTPlOjjzzhAKwUsRM6RJu5nHld0zFKBy4VHOup0csMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDBQdHZKTDhlMm5hOE1BRmJMTGJ6dlYwVk9aRm9yc3BUd0wxQUd6bG1LOXJZ?=
 =?utf-8?B?Nk1lbWVnd1YrZXUzaEZpY2o2OTRrdlJZeitlVHY2M2h5eGpXNU9McHpveGFi?=
 =?utf-8?B?REJRVmQrLzNDYk9VQ2FoNzFvZXRzd0NKVGtjMlhqZFN2cXFxMzdBV3BrT21X?=
 =?utf-8?B?c3UxbjBocWJCYkFpc051eVJ2WGNnMzZxK09yZ2NjVVdTQWhSUUpHREcyYnhi?=
 =?utf-8?B?eGdQN2xVM3RIYkFBMXVYYjFMU0RTL2kwVlJhdCtnVEZ1SVBYb1FRYjBQSS9T?=
 =?utf-8?B?Ui9TZjhKM1ZnZTBkTHdneXZFRUFLR3lCQWFvU0U3UnFuTGVxWHVrTXBGS1VZ?=
 =?utf-8?B?WEdsWU1ITjVYd1pVMWFTTUhFWjVyUzRXbFRaYm02NHZlWCtnQUM3NUlnQVBF?=
 =?utf-8?B?N01hWXF2Sk9lL2prNHZNWjNrenpwbEhDQnBTc0h0MW1xL1dSdVBGQnJ1TzBr?=
 =?utf-8?B?UjAreUlKNllKckV6ek42V0d6QlY4ZDdrNFhVUW1JOUNTRTdnaldhOXpBQnFq?=
 =?utf-8?B?dHhxeXVSZzg5S0IyTy8ra0M0dUxsTWNxaEptUmMvVW80dWNLZCtMdStVNDU1?=
 =?utf-8?B?c0k2TUo2czIzVUx1OThUNUVvS0ExdktKQzVlQnZOWTBnd0xRRnArSGZZbkZv?=
 =?utf-8?B?ZG00RjNYMFNObURJY2JIV2FwRVNPbnNyeGRWU3NibVM1YWdUOU9JNWRXTVh5?=
 =?utf-8?B?WGJJWHdiZk9MSzZHZENlU2JsekRmRUFOeTl4UEUrRjgrdVZLTGo3TzE5dlJP?=
 =?utf-8?B?ajZGYVZKYUdmbEx3R0ZybHpZSTAwTE1ST0luWXp2SFVlUHNzQzg2KzBnQVd5?=
 =?utf-8?B?SGJTYllaZm10cTB1bU44blZpNHJnNGVUOTREaUZKUUZxcDZUTEhrWUtUNU1L?=
 =?utf-8?B?eHl3UHpHQnJta1hBNVoxekgyMGZFYm5ERlE4K2kwM2xsSjVBVGFmSGR1eFlN?=
 =?utf-8?B?WG1iL1RPd3FiNHh0bmFPaGlEWUNkVmlrak5JTitjWmt2TDF2TS9XdGZhUm1M?=
 =?utf-8?B?MTFPYVpWYjJPaU9QVlZndzlFU0tHYUFkWGhwUDBaemtGdC9FSGx6b1JDS1RW?=
 =?utf-8?B?dTNOMnlQNEZ4OUVEcGV3RURsOFo5UU85UHhMRWxYWkMzRlFWL2lWUlFvd1E2?=
 =?utf-8?B?d1hKdmZCeThEYUJEYVFUUnFuSWhIOFEybVBPSlVXRDExYzBQZjllZkZoMVlw?=
 =?utf-8?B?NUlmMmYvWWcxMU5vN1BHK01mUHpBQmpmbFFuYzdURXh3SWpJNjhCTHl5RXJL?=
 =?utf-8?B?WHRORnFLY212d3JRZUhoQVRDS2swb0VTUXR0dkhGVGJLMm14ZDBRVUt6anl5?=
 =?utf-8?B?eURUY3BscXovTmdJdDVOclR1UEtNVlRNVkgrSW9YcEJXTGFVQktMZW1yUmNX?=
 =?utf-8?B?Y1Jydnd5a0FqczNjaFpkdkNhZDRSL0lIUVR4UDN4MCtrdExQRitubVlFUkNL?=
 =?utf-8?B?dTNnSGREYXI2VXJQRTFJWFUzTmNMak1sTUJNREE2cmMyRzFrQURkUDdTN1A1?=
 =?utf-8?B?djV3MFRDMy8yeGJZQW9pRWtGcFRkNnRXa2Z0bXdkMGpDL05reVVDQVhGRDdq?=
 =?utf-8?B?RGFMeEdLRVpxbmQwRkhEK2xZbXBMU3duRUI5NU83SU9lMVM1TlZSU1dtUUUy?=
 =?utf-8?B?eEMvQVNTUkZuR0I2UnZsREUzUUpoaWxEVWhvR0ZrcllRejNsTENiTFAyWHBk?=
 =?utf-8?B?K1QzRWk1ZXFVd2NYbHdiSVkwMFN4WFFOYjlWT1lsTDZyWk9vZ2I2eWp5azFJ?=
 =?utf-8?B?L2h6SlVBU3o2bDVFVlowTktVc2FIUEovUU4yZ3BCeG5RVWlGZnlGZ3g4V2Jn?=
 =?utf-8?B?S081YXdtQng3bWpIbHlCVEk4N2d0cmlTMnM1UVozUThGYUN6UWV0M1RjdWZt?=
 =?utf-8?B?N3JoL2JPY3V2YnVaRFFDdTdZWlRlL3F5S0ZyVDdZaFB2Ri9wRGR2YmpPSlhW?=
 =?utf-8?B?aG81SWNTZlgrUmRsakloVkp0YkYvRG50NDgrZExIOGtDWm1nRzQ5UWEyVXVR?=
 =?utf-8?B?dnMvbXkvbzJmdHIwN2VZd043RmJvaVQxZVdEWVRZeXh2THYyMlpNUzlpT0hh?=
 =?utf-8?B?aE0yd255SUZFaFZqMkhaR2RlejZOWEVJWW55QlFpVFFDVWNFa0IrNlFscG1F?=
 =?utf-8?B?d2kwVHllTVJ0Tkx2cnNMVE1vTnJQL0lrVXRDWFNJdGVVUXU0NGhXZlNQVzhi?=
 =?utf-8?B?YmZQLzZoQ2tCM25aMFRGcGNIUFVERjBGenJxSFd2cTNPL0duck1yTUFPYTBO?=
 =?utf-8?B?VzdDM1B6MkhrYWlreGMxSi9KR3VWcWJodkpXQ2hydWI0cG1ZVGdaYm5jUDln?=
 =?utf-8?B?UTJTMjU1a0pDdFhTeGJqbDJrU1BTcnU2YVJUVnRQZlNCdlV5MVowUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60312529-cd0c-4ec9-baaf-08de9f574e43
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 03:37:26.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00u8qXrtfe2KwGi9oBzx7oBx52CcBQVxY3RvDI/qdWjmsmA9ty3eB7rIigXS9WtxmA/H0SOaL4n3TuHtxbUCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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


On 2026-04-20 08:15, Christian König wrote:
>
> On 4/20/26 14:07, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu drm SVM API definitions built on the
>> DRM GPUSVM framework.
>>
>> This includes:
>> - DRM_AMDGPU_GEM_SVM ioctl
>> - AMDGPU_SVM_FLAG_* flags
>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>> - AMDGPU_SVM_ATTR_* attribute types
>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 406a42be4..bed71ed9b 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -58,6 +58,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>> +#define DRM_AMDGPU_GEM_SVM		0x1a
>>   
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -79,6 +80,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>> +#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>   
>>   /**
>>    * DOC: memory domains
>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>   	__u64 matrix[12];
>>   };
>>   
>> +#define AMDGPU_SVM_FLAG_HOST_ACCESS		0x00000001
>> +#define AMDGPU_SVM_FLAG_COHERENT		0x00000002
>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL		0x00000004
>> +#define AMDGPU_SVM_FLAG_GPU_RO			0x00000008
>> +#define AMDGPU_SVM_FLAG_GPU_EXEC		0x00000010
>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY		0x00000020
>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED	0x00000040
>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT		0x00000080
>> +
>> +#define AMDGPU_SVM_OP_SET_ATTR		0
>> +#define AMDGPU_SVM_OP_GET_ATTR		1
>> +
>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC		0
>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC		1
> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>
>> +#define AMDGPU_SVM_ATTR_ACCESS			2
>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE		3
>> +#define AMDGPU_SVM_ATTR_NO_ACCESS		4
> Why are those separate attributes? What is the difference between those?
>
>> +#define AMDGPU_SVM_ATTR_SET_FLAGS		5
>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS		6
> Why is that separated into set and clear flags?

This looks like it's based on the KFD SVM API. We created this so we 
could set or clear specific flags for address ranges without know what 
other flags were set or not set on different parts of those address 
ranges already.

E.g. you may have set an RO flag for pages 1-5, and set a COHERENT flag 
for pages 3-7. Now you want to clear EXEC for pages 0-8. If you specify 
an exact flags parameter, you wipe out all those other settings that 
have different values for different pages in the range. Instead this API 
lets you say "clear the EXEC flag on pages 0-8 without touching any of 
the other flags".

Alternatively we could have made all those flags completely separate 
boolean attributes. Making them flags that can be set/cleared in this 
way is more economical for how they are stored and manipulated.

Regards,
   Felix


>
>> +#define AMDGPU_SVM_ATTR_GRANULARITY		7
>> +
>> +#define AMDGPU_SVM_LOCATION_SYSMEM		0
>> +#define AMDGPU_SVM_LOCATION_UNDEFINED		0xffffffff
> No location for device local memory?
>
>> +
>> +struct drm_amdgpu_svm_attribute {
>> +	__u32 type;
>> +	__u32 value;
>> +};
>> +
>> +struct drm_amdgpu_gem_svm {
>> +	__u64 start_addr;
>> +	__u64 size;
>> +	__u32 operation;
>> +	__u32 nattr;
>> +	__u64 attrs_ptr;
>> +};
> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>
> And we usually use unions in this header to separate the input from the output parameters.
>
> Regards,
> Christian.
>
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
