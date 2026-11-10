Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED0606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YqEKrFGl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632D910EE36;
	Tue, 10 Nov 2026 06:24:05 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE4C10EE36;
 Tue, 10 Nov 2026 06:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oz/gTiA2xClvkzl/cuQBwXbomjNxVRkAHvsS4MYf2Jx14VtZ3qlMAhgtS88X69aCcsU081TJ4lFTOUF3Lv9Hpd3U3GqyJo5dQWsJbcj9YC4S8lIQD3c4lMDUCbd9GAtJEkM+DmQ3e99RvCgXQKfDIjTyVhXZ5Z0QuwT/WEOe1ICOwGmnp/ywGx355bvW29WpJ63eL030mH1cF12XfqtJ5PC8YVQbMKvT3qALxp/lsk61jGgLXhRH+Z02+Ljqoe/KwbeC9hPxIfhJ2dBddjkOGYXVVOSaYFu7mN0XR0PmTNoRGBITbTFMIfcuvv1ucoTANqAqrXyHN8KNq8sMNIUzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXw/vI2Khs6Tbm8WbycFdTUObfS5LOhsqDFOYqQyaZ8=;
 b=ESSmMqdK9ZjNRrUj2wX1PbIgRed6TK/1k/hfhoPgiWHoNBZavG6MMxMd7vcX1c95sBFSGgmhh1+4FNtD8tLz+zamFsBw/akHcrYl9vC1LGRPgk/mPlCJMCL1OvAEAIEcwjd7iIORMbuAXp13ZbX5IDhpGjPcHdVWS44XraDcYp0Te0kcmTwbQNc1YVxNpPhz4eN42sYsLf83o+FauFZT/pUOUpNwdGHQ0DmWBHNgQQrE+Hp93stY+ba+XtheituIX+blmUDQXacDKQI+1eVs3zq3ucmoeihAdazuhVb387GihB9REBH8pvSbROjP1jS4F8v+z2W4fgYo4/NwJShM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXw/vI2Khs6Tbm8WbycFdTUObfS5LOhsqDFOYqQyaZ8=;
 b=YqEKrFGl4YyFcEEkV9+cYhWIAuhjEq/J0xZb1hpk9ciV835fdJv1dVlleFGm6+q0ShLQc3h8MV7IJDB0xe349WXF7JPLN1Gp/gU64LPSMu5ZGIwP9XbOhfmQ34eK6KLbiAxkzVTbWFeFtQvJ6aU2YwWYZiDc0fs7tZOSMap6lxE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 06:23:54 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 06:23:53 +0000
Message-ID: <f55d5e19-99cb-4d15-9ea6-0cc063853f14@amd.com>
Date: Tue, 10 Nov 2026 14:23:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/22] drm/amdgpu: implement SVM attribute
 set/get/clear operations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-5-ray.huang@amd.com>
 <e2423693-a6d2-45fc-9a0d-0665b07301c2@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <e2423693-a6d2-45fc-9a0d-0665b07301c2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e89b0a-5532-43e2-269d-08df3ef33122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261009221727099003|261021123027099003|261026140227099003|261009220027099003|261009223327099003|261009221227099003|4143699003;
X-Microsoft-Antispam-Message-Info: mNkWOUR7vG0lDwerNDQu4W6NpjiWnsAunvhlFtbu++aWE8wPycnUxjHMM3FNxQmBA+1SnBtTEcl4H7B0PwnvJGewzsH771FwvVuExgEpVW+us/wU1WLReDu9dQL3S20S8O4Zv23ks8pGsgbCztAI9RUbXkKH/sFnaVFL0WqaZb23rL/3kIdAqoMDBXo9gNgGDaXqZYIVkfYhHyPva97CFutq/l8vJA0end7nUsCM2huVnTwqYUu7ovK+/l00IrXhfe/lnEGlYtUfEdp6Z/wA4eNn4ZnGixiKZ9KlklfL319/4sKkv+hUQ+pu0umjQ43tBuajjpOyyAdM8FmFFifc7pV6pgM3bjjx+ZsU1NnKJsh5ePNiI7xXD7pIxCTf6whWuLRZUIzS3e1JJ1pZ+VRS0Hr0mYtJ/HuZOTJVtLbDiGc6Oi++fYZEhrOpqZ9eIe/GIlvoXyuO9GjEONMPpraVBdvfnQ9v86sH9V2qBBOhTtxDnI349CwtVeSwIjQiqbHEDTGejNYdVhf3iwsBRQK2onJg2M9blmDvxghug9Jv0zlLFZnHdZYHW7WKSXsgVifpf93Nwp+8vIfhyZPJBKbkWoxRAhZJJXWrlx3+E3rAUhES5k48kZYX6t9qbolBUmJXG0PPEkonHY4QIe8iCcjH18PN05bFlAIEmFPCJds/WWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261009221727099003)(261021123027099003)(261026140227099003)(261009220027099003)(261009223327099003)(261009221227099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5OaXk1dWFYU3JEbjZPbnM4czdXQjJLdTZyTWJrTXNDOHZ0Q1hhWFdDczNS?=
 =?utf-8?B?RUF0cnZaMlk5WW45WTAvUW1qQVF2ditKK3VMVGYyM2VhSHRabUJIdk5SV3E4?=
 =?utf-8?B?RkEwWjRkd1hwcmwvWkhDcGVkNjIrZmFzYkh3L3JkNTBEbnUxdEhubU41bndX?=
 =?utf-8?B?Rkl6bjFzdHZ4MmZkZHlXQ3hqdEpCU085eGdZTWtsM3pOUnpoNGhTMkR5Y1gx?=
 =?utf-8?B?Y0k3a2FFb3h5blg4cCsxQmxKZ1JxcFN1bUVWbmJ3d25JSlNhczkybHp3aEkv?=
 =?utf-8?B?NkJHK0ZROXNQclNRNGMwaEE0VkNiRjBTY3VubkxmTGxHSXNyNXpmMm1ESEFy?=
 =?utf-8?B?T0dtbkRKVTFtaUl5ZDhVMmhFbEhGOS8xZm1FVXlGV3lWeEN1TFMwa0ZXcWJQ?=
 =?utf-8?B?SmRwVllhWWVvNFVXSnI3YWhjWS9oNkt6L21LLzRFamt4VTBEWEpvejdIZExC?=
 =?utf-8?B?WFNDTFhGWGdNalBhTGFkRnNZaE9temYweWlIQVRXK25QMVdQTjVJMy9rTUd3?=
 =?utf-8?B?cmlFUkJna1l0QytJeG9abUN0MUJOSG9DVklRZzdoWVZCL1AzZG1MeFZJUTBU?=
 =?utf-8?B?SEN6ZEVSY0FjSW41TDlNTldWeGt0TkR3YUhFd29WUnJ0d1V6c1I0SUt5dDl3?=
 =?utf-8?B?MnNIM0s4STFrdWx4RHY3RUR4VUNaMzRLMXRscGYwTjRwZlBOOFQ1ZXdZY3N1?=
 =?utf-8?B?UW1Vb0FNRmphcHA3eThhQjRoWVhqM2haWlBwcFpPUXliREVpQlJ4MERWb3lY?=
 =?utf-8?B?dDc2Q0JPVk1GdC9SN2NYcHNQMFJ1cWNiVXA5QW9aWkhmY0dxVmVuTHZSK1BB?=
 =?utf-8?B?d2lvQmFLR2hDUnIveFNpR0FscTBBUnVvVzRucDd4UWZsMlAzaWp4S1ZVR21h?=
 =?utf-8?B?QmVOaFJoOURGV2VnQUZ6MTQrN1VHdUlIVmZ5cVVuTWRmdjFxeUVzNjhYeURU?=
 =?utf-8?B?czA4VHc5YURuNm1pSVE4Ni81TmdrSm52dHpnNEZSTXRoZ3llWHI4Q1VhYTZ0?=
 =?utf-8?B?UDdrR25RV3M4cTFtTUVNTXBnZjU3dW90N1VGOEpwcWl2cVNMOGRQK3Zoc2hx?=
 =?utf-8?B?SnRsdGhodzFYeS92aWcwSW9NS2h5LzI1QlZFb0xlMTNPQmhpQmJheDErV1Ix?=
 =?utf-8?B?eHY0T1c2bEVVV2h4OE1YbXQ0RnFWWG5IV05Vc0VoK0JjRjk1blIvRUUwUUh1?=
 =?utf-8?B?MFZPbVoyTURxSkpZckhYc2ZuYnVzeVRnbWRMcXptTlhvWVlaNzdqdHpMVWdw?=
 =?utf-8?B?U3E5L2dqYjFlQmRETU5NU3VXYi9XL0l5bVVvdWxrMm50MW5yY0pHVFhJSnZP?=
 =?utf-8?B?UDk5am1OeUZ0S011dVA0WVVPa0VERVoyQ053K2Q0djNHSUd2VEJyd1pibkNQ?=
 =?utf-8?B?cFpwcjU2WmlrOUF1bFJScWthTUw0MllZdjhyWTE4dTZtVGJtQWVYeURBdUVC?=
 =?utf-8?B?aUh2dDZxNHBwL2Nua3BxNWo3UWZuT1M0YTRTTitncjJ5ZWdiN2x1ZS9SNzlx?=
 =?utf-8?B?TnBxUkpyTU5mS253MCtOOXVoUDR4SGRkZTJYODUrYXJ3c0RLMmRDSWl4UHgx?=
 =?utf-8?B?K2R2b2dDZytwTXlTM2FjZ0N6UWVWaDBLbXpacTRVUWMyOU9LN0ltN2JJeGs1?=
 =?utf-8?B?Q21DdmJKMkhTdnNwdkFxL1N3amdWRkc2cmVGeURqSzJ6d3dlejVhWEdWMjlk?=
 =?utf-8?B?emNGeDZCVURmWitXbWd1ZUFtVkVEZGViS2FxRkM1Y1Y0NHoyN080U3VEWDZa?=
 =?utf-8?B?NlBsZ2lOOHRpOUQ1a3pnR1RPaWpmY01maldEOEdjL2hsbmlJRXBXZTBHZ0k4?=
 =?utf-8?B?Y2grRGdDWVh0Tkw2R0hMZjliVnRjUytkck1PY2d4NGRoQS9NWkdZem9RUlFn?=
 =?utf-8?B?NHVtb0Y0aDM5UzB0UnlRUjY0TXJwRlJremFTYTlPSUZoUDhZU2hWOWZFWXY5?=
 =?utf-8?B?M2tEVm9NRk9RSWJZdVNFNVpoTlhuYWcyL3AwRG5mQ0taNy9sb3R0akFpV1Z6?=
 =?utf-8?B?bmpHd1dxM25aVnM4Wmg4VEpPRUo0bHo1ZC9QcDE5NDR1SFk4Zm1hR2NMREJo?=
 =?utf-8?B?clIrL2ErMVVxUXdVbWJJcStNUktma2dpcTdZL2dpVi9XRFRidU9JdXg2UHBL?=
 =?utf-8?B?L1Y3SFZ4VTJxdFB1NTYwYmxwMXJNaERNaytnVk80QXcvZ0lMQjhDNERacUgx?=
 =?utf-8?B?Ty9CNlV3OENiRDhxNmdOMUI2TC9EL0pGRGxQbXgxaEhIaVZUb0tkTGpsQTZZ?=
 =?utf-8?B?ZUY5YWFtSlY4bVVBLy9oQlkvKzUyaERtSHIxSzdSdmh6dDR3aWNRSkNlZ3dx?=
 =?utf-8?Q?JTZlWrJMeohVxt6vNT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e89b0a-5532-43e2-269d-08df3ef33122
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:23:53.5441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiI5fkxuVV36wsnatcPINvOgcvwl+jNysAjMgRtf0cM99c5gE7SzJfwxX90EiGn1HqTKlzX1TkMHOKK7VZYvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 8:52 PM, Christian König wrote:
> On 10/21/26 04:58, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Complete attribute subsystem with validation, tree modification, and
>> public API:
>> - Attribute validation: per-type checks for preferred_loc, prefetch_loc,
>>    access, flags, granularity
>> - Flag application: attr_apply_flag, amdgpu_svm_attr_apply
>> - VMA range validation: amdgpu_svm_attr_validate_range_vma
>> - VM BO overlap detection: amdgpu_svm_attr_check_vm_bo
>> - Tree modification with gap/overlap handling:
>>    amdgpu_svm_attr_set_hole (new range in gap),
>>    amdgpu_svm_attr_set_existing (split/update existing range)
>> - amdgpu_svm_attr_set_range: cursor based iteration with per segment
>> - Lifecycle: amdgpu_svm_attr_tree_create/destroy
>> - Public API: amdgpu_svm_attr_set (validate, set_range with retry),
>>    amdgpu_svm_attr_get (aggregate attrs across interval),
>>    amdgpu_svm_attr_clear (interval removal with split),
>>    amdgpu_svm_attr_reset
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 736 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h |  20 +
>>   2 files changed, 756 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> index a5afa75421fbd..c76e10473968e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> @@ -78,6 +78,43 @@ struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
>>   	return vma;
>>   }
>>   
>> +/*
>> + * amdgpu_svm_attr_range_is_valid - validate an attr ioctl address range
>> + *
>> + * Synchronous input validation for the SVM set/get-attr ioctls: walk the
>> + * CPU VMAs covering [start_page, last_page] and reject the request if any
>> + * part is unmapped or backed by an unsupported VMA (-EOPNOTSUPP).
>> + *
>> + */
>> +static int amdgpu_svm_attr_range_is_valid(struct amdgpu_svm *svm,
>> +					  unsigned long start_page,
>> +					  unsigned long last_page)
>> +{
>> +	struct mm_struct *mm = svm->gpusvm.mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned long start, end;
>> +	int r = 0;
>> +
>> +	if (!mm)
>> +		return -EFAULT;
>> +
>> +	start = start_page << PAGE_SHIFT;
>> +	end = (last_page + 1) << PAGE_SHIFT;
>> +
>> +	mmap_read_lock(mm);
>> +	do {
>> +		vma = amdgpu_svm_check_vma(mm, start);
>> +		if (IS_ERR(vma)) {
>> +			r = PTR_ERR(vma);
>> +			break;
>> +		}
>> +		start = min(end, vma->vm_end);
>> +	} while (start < end);
>> +	mmap_read_unlock(mm);
> 
> Again a clear NAK to any of those static checks!
> 
> The result of the check becomes invalid ass soon as the mman_read_lock is dropped, so that here only gives a completely false picture if some operation is valid or not.
> 
> We have two possibilities here, either keep the mman_read_lock while installing the SVM range or completely drop the check and make sure that faulting on a range which isn't backed by any VMA or an invalid VMA is properly handled in the fault handler.
> 
> I think we need to have a resilent fault handler who can deal with such errors anyway, so it is probably the best approach to go down that route.
> 

Got it, wil drop that check, and some negative test will become fail for 
some no vma setting SVM test.
And the behaviour for xnack-on and xnack-off will be different, xnack-on 
will get a silent fail, no error return when SVM set ioctl, xnack-on 
won't do fault when setting ioctl, but our fault patch will handle no 
vma situlation corretcly.
But for xnack-off, it always do fault when ioctl setting, so it can make 
the negative test pass, return error in iotcl.

Regards,
Honglei


> Regards,
> Christian.
> 
>> +
>> +	return r;
>> +}
>> +
>>   static void attr_set_interval(struct amdgpu_svm_attr_range *range,
>>   				unsigned long start_page,
>>   				unsigned long last_page)
>> @@ -233,3 +270,702 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
>>   	if (free_range)
>>   		kfree(range);
>>   }
>> +
>> +static void attr_change_ctx_set(
>> +		struct attr_set_ctx *change,
>> +		const struct amdgpu_svm_attrs *old_attrs,
>> +		const struct amdgpu_svm_attrs *new_attrs,
>> +		unsigned long start_page,
>> +		unsigned long last_page)
>> +{
>> +	change->old_attrs = *old_attrs;
>> +	change->new_attrs = *new_attrs;
>> +	change->start_page = start_page;
>> +	change->last_page = last_page;
>> +}
>> +
>> +static inline int attr_check_preferred_loc(uint32_t value)
>> +{
>> +	/*
>> +	 * SYSMEM and UNDEFINED are always valid; LOCAL/HIVE select device
>> +	 * VRAM (see enum amdgpu_ioctl_svm_location).
>> +	 */
>> +	switch (value) {
>> +	case AMDGPU_SVM_LOCATION_SYSMEM:
>> +	case AMDGPU_SVM_LOCATION_UNDEFINED:
>> +	case AMDGPU_SVM_LOCATION_LOCAL:
>> +	case AMDGPU_SVM_LOCATION_HIVE:
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static inline int attr_check_prefetch_loc(uint32_t value)
>> +{
>> +	/*
>> +	 * Prefetch accepts the same values as the preferred location (see
>> +	 * enum amdgpu_ioctl_svm_location); UNDEFINED means no prefetch and is
>> +	 * what GET_ATTR reports for default or mixed ranges, so it must round
>> +	 * trip through SET for CRIU restore.
>> +	 */
>> +	switch (value) {
>> +	case AMDGPU_SVM_LOCATION_SYSMEM:
>> +	case AMDGPU_SVM_LOCATION_UNDEFINED:
>> +	case AMDGPU_SVM_LOCATION_LOCAL:
>> +	case AMDGPU_SVM_LOCATION_HIVE:
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static inline int attr_check_access(uint32_t value)
>> +{
>> +	switch (value) {
>> +	case AMDGPU_SVM_ACCESS_INACCESSIBLE:
>> +	case AMDGPU_SVM_ACCESS_IN_PLACE:
>> +	case AMDGPU_SVM_ACCESS_ALLOW_MIGRATE:
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static bool attr_flag_type_to_bit(uint32_t type, uint32_t *flag_bit)
>> +{
>> +	if (type < AMDGPU_SVM_ATTR_HOST_ACCESS ||
>> +	    type > AMDGPU_SVM_ATTR_GPU_READ_MOSTLY)
>> +		return false;
>> +
>> +	*flag_bit = 1u << (type - AMDGPU_SVM_ATTR_HOST_ACCESS);
>> +	return true;
>> +}
>> +
>> +static inline int attr_check_flag_value(uint32_t value)
>> +{
>> +	if (value > 1)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int attr_check_flag_attr(uint32_t type, uint32_t value)
>> +{
>> +	uint32_t flag_bit;
>> +	int ret;
>> +
>> +	if (!attr_flag_type_to_bit(type, &flag_bit))
>> +		return -EINVAL;
>> +
>> +	ret = attr_check_flag_value(value);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int attr_check_granularity(uint32_t value)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int attr_set_validate(const struct drm_amdgpu_svm_attribute *attr)
>> +{
>> +	switch (attr->type) {
>> +	case AMDGPU_SVM_ATTR_PREFERRED_LOC:
>> +		return attr_check_preferred_loc(attr->value);
>> +	case AMDGPU_SVM_ATTR_PREFETCH_LOC:
>> +		return attr_check_prefetch_loc(attr->value);
>> +	case AMDGPU_SVM_ATTR_ACCESS:
>> +		return attr_check_access(attr->value);
>> +	case AMDGPU_SVM_ATTR_GRANULARITY:
>> +		return attr_check_granularity(attr->value);
>> +	case AMDGPU_SVM_ATTR_HOST_ACCESS:
>> +	case AMDGPU_SVM_ATTR_COHERENT:
>> +	case AMDGPU_SVM_ATTR_GPU_RO:
>> +	case AMDGPU_SVM_ATTR_GPU_EXEC:
>> +	case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
>> +	case AMDGPU_SVM_ATTR_EXT_COHERENT:
>> +		return attr_check_flag_attr(attr->type, attr->value);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static void attr_apply_flag(struct amdgpu_svm_attrs *attrs,
>> +			    uint32_t type, uint32_t value)
>> +{
>> +	uint32_t flag_bit;
>> +
>> +	if (!attr_flag_type_to_bit(type, &flag_bit))
>> +		return;
>> +
>> +	if (value)
>> +		attrs->flags |= flag_bit;
>> +	else
>> +		attrs->flags &= ~flag_bit;
>> +}
>> +
>> +static void attr_apply(struct amdgpu_svm_attrs *attrs,
>> +					uint32_t nattr,
>> +					const struct drm_amdgpu_svm_attribute *pattrs)
>> +{
>> +	const struct drm_amdgpu_svm_attribute *attr;
>> +
>> +	for (attr = pattrs; nattr--; attr++) {
>> +		switch (attr->type) {
>> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
>> +			attrs->preferred_loc = (int32_t)attr->value;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
>> +			attrs->prefetch_loc = (int32_t)attr->value;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_ACCESS:
>> +			attrs->access = (enum amdgpu_ioctl_svm_access)attr->value;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
>> +		case AMDGPU_SVM_ATTR_COHERENT:
>> +		case AMDGPU_SVM_ATTR_GPU_RO:
>> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
>> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
>> +		case AMDGPU_SVM_ATTR_EXT_COHERENT:
>> +			attr_apply_flag(attrs, attr->type, attr->value);
>> +			break;
>> +		case AMDGPU_SVM_ATTR_GRANULARITY:
>> +			attrs->granularity = min_t(uint32_t, attr->value, 0x3f);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static bool attr_same_attrs(const struct amdgpu_svm_attr_range *range,
>> +			    uint32_t nattr,
>> +			    const struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm_attrs target;
>> +
>> +	target = range->attrs;
>> +	attr_apply(&target, nattr, attrs);
>> +	return attr_equal(&range->attrs, &target);
>> +}
>> +
>> +static int
>> +amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  const struct amdgpu_svm_attrs *default_attrs,
>> +			  unsigned long start_page, unsigned long last_page,
>> +			  uint32_t nattr,
>> +			  const struct drm_amdgpu_svm_attribute *attrs,
>> +			  struct attr_set_ctx *change)
>> +{
>> +	struct amdgpu_svm_attrs new_attrs;
>> +	struct amdgpu_svm_attr_range *range;
>> +
>> +	lockdep_assert_held(&attr_tree->lock);
>> +
>> +	if (start_page > last_page)
>> +		return 0;
>> +
>> +	new_attrs = *default_attrs;
>> +	attr_apply(&new_attrs, nattr, attrs);
>> +
>> +	/* Always create a range entry even when attrs equal defaults */
>> +	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs);
>> +	if (!range)
>> +		return -ENOMEM;
>> +
>> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +
>> +	attr_change_ctx_set(change, default_attrs,
>> +				       &new_attrs, start_page, last_page);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * amdgpu_svm_attr_set_existing() - Apply attrs to part of an existing range
>> + *
>> + * Update @range over [@start_page, @last_page]. If the request fully covers
>> + * @range the attrs are updated in place, otherwise the range is split into the
>> + * head/tail, carrying the old attrs, and the covered middle, carrying
>> + * the new attrs. The resulting change is reported by @change.
>> + */
>> +static int
>> +amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
>> +			     struct amdgpu_svm_attr_range *range,
>> +			     unsigned long start_page, unsigned long last_page,
>> +			     uint32_t nattr,
>> +			     const struct drm_amdgpu_svm_attribute *attrs,
>> +			     struct attr_set_ctx *change)
>> +{
>> +	unsigned long range_start = amdgpu_svm_attr_start_page(range);
>> +	unsigned long range_last = amdgpu_svm_attr_last_page(range);
>> +	struct amdgpu_svm_attr_range *left = NULL;
>> +	struct amdgpu_svm_attr_range *right = NULL;
>> +	struct amdgpu_svm_attrs old_attrs;
>> +	struct amdgpu_svm_attrs new_attrs;
>> +
>> +	lockdep_assert_held(&attr_tree->lock);
>> +
>> +	old_attrs = range->attrs;
>> +
>> +	if (attr_same_attrs(range, nattr, attrs)) {
>> +		/* Report old==new so apply_attr_change can decide */
>> +		attr_change_ctx_set(change, &old_attrs,
>> +					       &old_attrs,
>> +					       start_page, last_page);
>> +		return 0;
>> +	}
>> +
>> +	new_attrs = old_attrs;
>> +	attr_apply(&new_attrs, nattr, attrs);
>> +
>> +	/* only need to update attr */
>> +	if (start_page == range_start && last_page == range_last) {
>> +		range->attrs = new_attrs;
>> +		attr_change_ctx_set(change, &old_attrs,
>> +					       &new_attrs, start_page, last_page);
>> +		return 0;
>> +	}
>> +
>> +	/* split head */
>> +	if (start_page > range_start) {
>> +		left = amdgpu_svm_attr_range_alloc(range_start, start_page - 1, &old_attrs);
>> +		if (!left)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	/* split tail */
>> +	if (last_page < range_last) {
>> +		right = amdgpu_svm_attr_range_alloc(last_page + 1, range_last, &old_attrs);
>> +		if (!right) {
>> +			kfree(left);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	attr_remove_range_locked(attr_tree, range, false);
>> +	if (left)
>> +		amdgpu_svm_attr_range_insert_locked(attr_tree, left);
>> +	attr_set_interval(range, start_page, last_page);
>> +	range->attrs = new_attrs;
>> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +	if (right)
>> +		amdgpu_svm_attr_range_insert_locked(attr_tree, right);
>> +
>> +	attr_change_ctx_set(change, &old_attrs,
>> +				       &new_attrs, start_page, last_page);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * amdgpu_svm_attr_set_range() - Apply attr changes across [@start_page, @last_page]
>> + *
>> + * Walk the interval in segments, each segment being either an existing range
>> + * or a hole.
>> + */
>> +static int
>> +amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  const struct amdgpu_svm_attrs *default_attrs,
>> +			  unsigned long start_page, unsigned long last_page,
>> +			  uint32_t nattr,
>> +			  const struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm *svm = attr_tree->svm;
>> +	unsigned long cursor = start_page;
>> +	bool need_retry = false;
>> +
>> +	while (cursor <= last_page) {
>> +		struct interval_tree_node *node;
>> +		unsigned long seg_last;
>> +		struct attr_set_ctx change = { 0 };
>> +		int ret;
>> +
>> +		amdgpu_svm_lock(svm);
>> +		mutex_lock(&attr_tree->lock);
>> +		node = interval_tree_iter_first(&attr_tree->tree, cursor, cursor);
>> +		if (node) {
>> +			struct amdgpu_svm_attr_range *range;
>> +
>> +			range = container_of(node, struct amdgpu_svm_attr_range, it_node);
>> +			seg_last = min(last_page, amdgpu_svm_attr_last_page(range));
>> +			ret = amdgpu_svm_attr_set_existing(attr_tree, range,
>> +								   cursor, seg_last,
>> +								   nattr, attrs, &change);
>> +		} else {
>> +			struct interval_tree_node *next;
>> +
>> +			seg_last = last_page;
>> +			if (cursor != ULONG_MAX) {
>> +				next = interval_tree_iter_first(&attr_tree->tree,
>> +								cursor + 1,
>> +								ULONG_MAX);
>> +				if (next) {
>> +					struct amdgpu_svm_attr_range *next_range;
>> +
>> +					next_range = container_of(next,
>> +						struct amdgpu_svm_attr_range,
>> +						it_node);
>> +					seg_last = min(last_page,
>> +						       amdgpu_svm_attr_start_page(next_range) - 1);
>> +				}
>> +			}
>> +			ret = amdgpu_svm_attr_set_hole(attr_tree,
>> +							       default_attrs,
>> +							       cursor, seg_last,
>> +							       nattr, attrs,
>> +							       &change);
>> +		}
>> +		mutex_unlock(&attr_tree->lock);
>> +
>> +		if (ret) {
>> +			amdgpu_svm_unlock(svm);
>> +			return ret;
>> +		}
>> +
>> +		ret = amdgpu_svm_apply_attr_change(svm,
>> +						   &change.old_attrs,
>> +						   &change.new_attrs,
>> +						   change.start_page,
>> +						   change.last_page);
>> +		amdgpu_svm_unlock(svm);
>> +
>> +		if (ret == -EAGAIN) {
>> +			need_retry = true;
>> +			ret = 0;
>> +		}
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (seg_last == ULONG_MAX || seg_last == last_page)
>> +			break;
>> +
>> +		cursor = seg_last + 1;
>> +	}
>> +
>> +	return need_retry ? -EAGAIN : 0;
>> +}
>> +
>> +struct amdgpu_svm_attr_tree *
>> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
>> +{
>> +	struct amdgpu_svm_attr_tree *attr_tree;
>> +
>> +	attr_tree = kzalloc_obj(*attr_tree, GFP_KERNEL);
>> +	if (!attr_tree)
>> +		return NULL;
>> +
>> +	mutex_init(&attr_tree->lock);
>> +	attr_tree->tree = RB_ROOT_CACHED;
>> +	INIT_LIST_HEAD(&attr_tree->range_list);
>> +	attr_tree->svm = svm;
>> +	return attr_tree;
>> +}
>> +
>> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
>> +{
>> +	struct amdgpu_svm_attr_range *range, *tmp;
>> +
>> +	if (!attr_tree)
>> +		return;
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +	list_for_each_entry_safe(range, tmp, &attr_tree->range_list, list) {
>> +		interval_tree_remove(&range->it_node, &attr_tree->tree);
>> +		list_del_init(&range->list);
>> +		kfree(range);
>> +	}
>> +	mutex_unlock(&attr_tree->lock);
>> +
>> +	mutex_destroy(&attr_tree->lock);
>> +	kfree(attr_tree);
>> +}
>> +
>> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
>> +			uint64_t start,
>> +			uint64_t size,
>> +			uint32_t nattr,
>> +			const struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	struct amdgpu_svm *svm = attr_tree->svm;
>> +	struct amdgpu_svm_attrs default_attrs;
>> +	unsigned long start_page, last_page;
>> +	uint32_t i;
>> +	int r;
>> +
>> +	start_page = start >> PAGE_SHIFT;
>> +	last_page = (start + size - 1) >> PAGE_SHIFT;
>> +
>> +	for (i = 0; i < nattr; i++) {
>> +		pr_debug("set attr type %u value 0x%08x range [0x%lx-0x%lx] xnack:%d",
>> +			 attrs[i].type, attrs[i].value, start_page, last_page,
>> +			 svm->xnack_enabled ? 1 : 0);
>> +		r = attr_set_validate(&attrs[i]);
>> +		if (r) {
>> +			pr_debug("invalid attribute %u value 0x%08x",
>> +					 attrs[i].type, attrs[i].value);
>> +			return r;
>> +		}
>> +	}
>> +
>> +	r = amdgpu_svm_attr_range_is_valid(svm, start_page, last_page);
>> +	if (r)
>> +		return r;
>> +
>> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
>> +
>> +retry:
>> +	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs,
>> +					       start_page, last_page,
>> +					       nattr, attrs);
>> +	if (r == -EAGAIN) {
>> +		pr_debug("attr_set retry [0x%lx-0x%lx]\n",
>> +				 start_page, last_page);
>> +		amdgpu_svm_sync_work(svm);
>> +		cond_resched();
>> +		goto retry;
>> +	}
>> +
>> +	return r;
>> +}
>> +
>> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page)
>> +{
>> +	struct interval_tree_node *node;
>> +	int r = 0;
>> +
>> +	if (start_page > last_page)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +
>> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
>> +	while (node) {
>> +		struct interval_tree_node *next;
>> +		struct amdgpu_svm_attr_range *range;
>> +		unsigned long range_start;
>> +		unsigned long range_last;
>> +
>> +		range = container_of(node, struct amdgpu_svm_attr_range, it_node);
>> +		next = interval_tree_iter_next(node, start_page, last_page);
>> +		range_start = amdgpu_svm_attr_start_page(range);
>> +		range_last = amdgpu_svm_attr_last_page(range);
>> +
>> +		if (range_start < start_page && range_last > last_page) {
>> +			struct amdgpu_svm_attr_range *tail;
>> +
>> +			tail = amdgpu_svm_attr_range_alloc(last_page + 1, range_last,
>> +							   &range->attrs);
>> +			if (!tail) {
>> +				r = -ENOMEM;
>> +				break;
>> +			}
>> +
>> +			attr_remove_range_locked(attr_tree, range, false);
>> +			attr_set_interval(range, range_start, start_page - 1);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, tail);
>> +		} else if (range_start < start_page) {
>> +			attr_remove_range_locked(attr_tree, range, false);
>> +			attr_set_interval(range, range_start, start_page - 1);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +		} else if (range_last > last_page) {
>> +			attr_remove_range_locked(attr_tree, range, false);
>> +			attr_set_interval(range, last_page + 1, range_last);
>> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
>> +		} else {
>> +			attr_remove_range_locked(attr_tree, range, true);
>> +		}
>> +
>> +		node = next;
>> +	}
>> +
>> +	mutex_unlock(&attr_tree->lock);
>> +	return r;
>> +}
>> +
>> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page)
>> +{
>> +	/*
>> +	 * Range with no attr node in this implementation is treated the
>> +	 * same as one that explicitly stores default attrs. So clear
>> +	 * the attribute ranges when user wants to reset the attrs.
>> +	 *
>> +	 * - GET_ATTR: return default_attrs to userspace when there is no attr
>> +	 *   range.
>> +	 * - SET_ATTR: holes are treated as having default_attrs when
>> +	 *   computing the change trigger.
>> +	 * - Fault: attr lookup falls back to defaults when no attr range exists,
>> +	 *   so migration and PTE flag decisions are unchanged.
>> +	 *
>> +	 * This approach simplifies the implementation and avoids redundant
>> +	 * attribute maintenance. This ioctl operation is for attribute only,
>> +	 * so do not invalidate the GPU mapping here.
>> +	 */
>> +	return amdgpu_svm_attr_clear(attr_tree, start_page, last_page);
>> +}
>> +
>> +static void attr_get_ctx_add(struct attr_get_ctx *ctx,
>> +			       const struct amdgpu_svm_attrs *attrs)
>> +{
>> +	if (!ctx->has_range) {
>> +		ctx->preferred_loc = attrs->preferred_loc;
>> +		ctx->prefetch_loc = attrs->prefetch_loc;
>> +		ctx->granularity = attrs->granularity;
>> +		ctx->access = attrs->access;
>> +		ctx->flags_and = attrs->flags;
>> +		ctx->has_range = true;
>> +		return;
>> +	}
>> +
>> +	if (ctx->preferred_loc != attrs->preferred_loc)
>> +		ctx->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
>> +	if (ctx->prefetch_loc != attrs->prefetch_loc)
>> +		ctx->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
>> +	if (attrs->granularity < ctx->granularity)
>> +		ctx->granularity = attrs->granularity;
>> +	if (ctx->access != attrs->access)
>> +		ctx->access = AMDGPU_SVM_ACCESS_INACCESSIBLE;
>> +	ctx->flags_and &= attrs->flags;
>> +}
>> +
>> +static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx,
>> +				uint32_t nattr,
>> +				struct drm_amdgpu_svm_attribute *attrs)
>> +{
>> +	uint32_t i;
>> +
>> +	for (i = 0; i < nattr; i++) {
>> +		switch (attrs[i].type) {
>> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
>> +			attrs[i].value = ctx->preferred_loc;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
>> +			attrs[i].value = ctx->prefetch_loc;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_ACCESS:
>> +			attrs[i].value = (uint32_t)ctx->access;
>> +			break;
>> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
>> +		case AMDGPU_SVM_ATTR_COHERENT:
>> +		case AMDGPU_SVM_ATTR_GPU_RO:
>> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
>> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
>> +		case AMDGPU_SVM_ATTR_EXT_COHERENT: {
>> +			uint32_t flag_bit;
>> +
>> +			if (!attr_flag_type_to_bit(attrs[i].type, &flag_bit))
>> +				return -EINVAL;
>> +
>> +			attrs[i].value = (ctx->flags_and & flag_bit) ? 1 : 0;
>> +			break;
>> +		}
>> +		case AMDGPU_SVM_ATTR_GRANULARITY:
>> +			attrs[i].value = ctx->granularity;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * On return @out_size is shrunk to the length of the contiguous range starting
>> + * at @start over which all attributes are identical, so user space (e.g. CRIU)
>> + * can walk the address space one uniform range at a time.
>> + */
>> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
>> +			uint64_t start, uint64_t size,
>> +			uint32_t nattr,
>> +			struct drm_amdgpu_svm_attribute *attrs,
>> +			uint64_t *out_size)
>> +{
>> +	struct amdgpu_svm_attrs default_attrs;
>> +	struct amdgpu_svm_attrs ref_attrs;
>> +	struct attr_get_ctx ctx = { 0 };
>> +	struct interval_tree_node *node;
>> +	unsigned long start_page, last_page, cursor, homog_last;
>> +	bool have_ref = false;
>> +	int r;
>> +
>> +	start_page = start >> PAGE_SHIFT;
>> +	last_page = (start + size - 1) >> PAGE_SHIFT;
>> +
>> +	r = amdgpu_svm_attr_range_is_valid(attr_tree->svm, start_page, last_page);
>> +	if (r)
>> +		return r;
>> +
>> +	mutex_lock(&attr_tree->lock);
>> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
>> +
>> +	homog_last = start_page;
>> +	cursor = start_page;
>> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
>> +
>> +	while (cursor <= last_page) {
>> +		const struct amdgpu_svm_attrs *range_attrs;
>> +		unsigned long range_last = last_page;
>> +		struct amdgpu_svm_attr_range *range = NULL;
>> +		unsigned long next;
>> +
>> +		if (node) {
>> +			range = container_of(node, struct amdgpu_svm_attr_range,
>> +					     it_node);
>> +
>> +			if (amdgpu_svm_attr_last_page(range) < cursor) {
>> +				node = interval_tree_iter_next(node, start_page,
>> +							       last_page);
>> +				continue;
>> +			}
>> +
>> +			if (amdgpu_svm_attr_start_page(range) <= cursor) {
>> +				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
>> +				node = interval_tree_iter_next(node, start_page,
>> +							       last_page);
>> +			} else {
>> +				range_last = min(last_page,
>> +						 amdgpu_svm_attr_start_page(range) - 1);
>> +				range = NULL;
>> +			}
>> +		}
>> +
>> +		range_attrs = range ? &range->attrs : &default_attrs;
>> +
>> +		if (!have_ref) {
>> +			ref_attrs = *range_attrs;
>> +			have_ref = true;
>> +		} else if (!attr_equal(range_attrs, &ref_attrs)) {
>> +			break;
>> +		}
>> +
>> +		homog_last = range_last;
>> +
>> +		if (range_last == ULONG_MAX)
>> +			break;
>> +
>> +		next = range_last + 1;
>> +		if (next <= cursor)
>> +			break;
>> +		cursor = next;
>> +	}
>> +
>> +	if (!have_ref)
>> +		ref_attrs = default_attrs;
>> +
>> +	attr_get_ctx_add(&ctx, &ref_attrs);
>> +	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
>> +	mutex_unlock(&attr_tree->lock);
>> +
>> +	if (!r && out_size)
>> +		*out_size = ((uint64_t)(homog_last - start_page) + 1) << PAGE_SHIFT;
>> +
>> +	return r;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>> index 36fee11aa9ea0..56bcd81c608cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>> @@ -158,6 +158,9 @@ enum amdgpu_svm_attr_change_trigger {
>>   	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
>>   	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
>>   
>> +struct amdgpu_svm_attr_tree *
>> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
>> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
>>   struct amdgpu_svm_attr_range *
>>   amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
>>   			   unsigned long page);
>> @@ -169,6 +172,23 @@ amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
>>   void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
>>   				 struct amdgpu_svm_attrs *attrs);
>>   
>> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
>> +			   uint64_t start,
>> +			   uint64_t size,
>> +			   uint32_t nattr,
>> +			   const struct drm_amdgpu_svm_attribute *attrs);
>> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
>> +				       uint64_t start,
>> +				       uint64_t size,
>> +				       uint32_t nattr,
>> +				       struct drm_amdgpu_svm_attribute *attrs,
>> +				       uint64_t *out_size);
>> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page);
>> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page);
>>   struct amdgpu_svm_attr_range *
>>   amdgpu_svm_attr_range_alloc(unsigned long start_page,
>>   			   unsigned long last_page,
> 

