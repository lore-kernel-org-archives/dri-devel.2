Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26A60A2610
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lLZ0aKcT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246EF10E0F0;
	Tue, 10 Nov 2026 02:52:19 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7020310E0F0;
 Tue, 10 Nov 2026 02:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYrPwTLFyRK7uLEQtaO2NAalfzI4K0QGSZcBZ1oKgg4Y9YiqPLf31WcLvtoMBCZmr1j7RY9yUcSbtMjySDjsCreS8PMv/NNk9OAEm+USqQg8PPJvBICYkxlzNV53JcxatlIMG7ucDr9oReB4adanmuc/AgHRAudfbMxwdke6q2iZxJtylwOGUvo9bjmtehC/eOa0XNOK2EfVB5+2h1OLj67TSb8HEWOlukwdJxmgD2wRI+EuTvD7UWCwS32JUXsLer0r46KT8Yw/K3KvqZbvseKS4Q7+odJRcPZEPGA0dYA937STMPjMIlP5NM5CB5TE5671abqhd1u7+MYMKfTStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA9Xk1/nZlfcFPpnImRNjvx5ARb1zc8pLPfB4FTVzgk=;
 b=P/S9jfhtde+N9lImrRBh6XMIVpR/cwrR1dGGk4+TyaDU+DOsf1Bf0UhjbFObe9iLQbQyudsIj33l6DelJvaGHsket8mqVUrFnmzfcEh3H1pvza+F9G3Mlw9wxON31O9M5y/l31av3hwYRF5hQit6+5n2O1ZbVBkCSKOUbJzbnL/aatuixMavjNQvAx6VESHL8nPlG1jbLatbd2eDhOiUgcLA7XehK+75m2W3o4slBxpK4PB+qGB/gsN0BBg9OcN+IcAH3iVGKP8xnN7MS0dN+KU2VHqcNASF+9uIeEBm3fgi2Qao0WhSTGaTfba2ADyKIW+1nw7KChj4ManxFiiylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA9Xk1/nZlfcFPpnImRNjvx5ARb1zc8pLPfB4FTVzgk=;
 b=lLZ0aKcTGUj0o5VNDOjsWviAzyD6Et3P/ck/K1FDBXlXHGN2+vmfGSnnyb46/0G7/xZtSAK3urMtFgr+tRggDxXYPrENNT+aE9k1jT/SzV7O45M+Szsdt+XAIvcWIyE9u8O0o9rR+LeWys1us/MOKdyOADn3l1rUQEaVL5HcdNw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:52:03 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:52:03 +0000
Message-ID: <64f0db19-7ea6-4974-afa4-797b765a581f@amd.com>
Date: Tue, 10 Nov 2026 10:51:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-3-ray.huang@amd.com>
 <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cb3b07-1375-445b-0802-08df3ed59908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261009223327099003|56012099006|4143699003|261021121427099003|261022105027099003|261022115727099003|261022075727099003|261022113327099003|261009220027099003|261009221227099003|261026121527099003|261026140227099003|261009221727099003|261009223027099003|261028144727099003|261102123227099003|11063799006|10067099003|18002099003|18092099006|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: awPYc3Jw9kAjYVO2z3AI3Z8rGfnefI1bTJQILddopp+CpLMeG8IGKObtV9BwESxDARr735FXDJClszUDiL3oMtca6E+qkndtcBpRuAIW8HBIPKFrQXi41YmpvKb7pYBpMOUSjk/mHDzYa6yntgH2xikfwu1YelQkXGF8c/Fat57V6qWogj0m2+Q00LKIeNOPYC0WJ6ZG1HsAevP9VFfkolQxfq+j7wYNLQwArFWIPNC45BwG+O0lKCHT25Qj8EdLZbBxeodGjFrjlfuZe5M0b5usX8Cf0Erwz66uPLqF9Sw9u5JCaq8zm080fYCIKrOh0lrIiuAeXkYeiWmCEgnJdYI3xTHJgiYt/s0RRx58IKO3l0yttKW9FO2n9NbPcMV/fZl1Fex72LBk/PqWF8KTfSb0q2KN9z6mkvhn4HS5nqDbIrNXwEUVKqbt8vv898VwfZKpJwjQ3xskawwuZZ1O32ubqNz6GRKUTYyMhoGH/8THozxrI+9OpE7Bia6Knvm4NPdA9SZ7I2fUonvF45Et8tkjyLZSJErwR7vkXcNo9B5uS+IDsLRHBIkL/ckh9IrFZLfDBjF+ODSKelN/+evT+g+HWzirYqcqDgRTWTYDcnjrFJJEKt9nHB3xNTgK+DaLvKXhshIBhXsxnWbKXFwYw29JxeX2zy+bWk7pczhCf5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223327099003)(56012099006)(4143699003)(261021121427099003)(261022105027099003)(261022115727099003)(261022075727099003)(261022113327099003)(261009220027099003)(261009221227099003)(261026121527099003)(261026140227099003)(261009221727099003)(261009223027099003)(261028144727099003)(261102123227099003)(11063799006)(10067099003)(18002099003)(18092099006)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3UyZnJWaFlNNDZvelp5bkY5YjN5cytnT1piREVrbFh6VllBMHJKczFuM1Nu?=
 =?utf-8?B?UnFubGs0aEM0Q0hvL1NJMkJOL1dRRjBmNVh1MHBWc1JpdEROM2dKRndaczFM?=
 =?utf-8?B?MXRyRGdtUERtclJuQUp0SWhWM2ltVm5FOEJmcjVvTUJHT3lRWER6eThHQ2E4?=
 =?utf-8?B?SVpKWG5jc2wrNi9Mb3RFaGFmYW9qdzc1bms0T2RhT0ltOEU0b05NN0ZidzA0?=
 =?utf-8?B?emY3YmxHWWxOVWtUYTU1Q0Q4Vy9oTkhsWlFYeElsb0RaNm5GNy9kSE5sSTFB?=
 =?utf-8?B?TDdicVZHTzZkeitOQjFuUkJCeUFtajczaHIwMGlwckdLSklnbDhvc0pYblhI?=
 =?utf-8?B?cDhxTE1lbUZtNmtvZDdzak1Ca1ArM0wzQVA3Tzk4VWNQbTRVVkNxRXJPa1Qw?=
 =?utf-8?B?K0wxRS9PeWs2bUZuOXdLWUhIRyt0MTg4cVpwTjR1ZzFhOUtwQzBwVHJvZXMx?=
 =?utf-8?B?Tk1DSlNNb2xjNmRnUVRmajRleElTMFlMc0lBeHJoa2xoM1RHWWR1SU5MM3pm?=
 =?utf-8?B?R2NwSzhtZFhxQ0wzbkJQOEJNQUwxeFhKQUd0UC9JRUxGUlhKS0hlRHNVb01B?=
 =?utf-8?B?ZzViMGJNRjVmSThyTGtVWWxSZ1k5YTQ2LzRaZ3YvZEZHQmFicGNnMXR4ZVpq?=
 =?utf-8?B?TkUvUzQ0L0RtT1ZoQ0w3ZzJycmFrWFlIZkNGSXpSblRUWk5wZldXckViWmlt?=
 =?utf-8?B?RXQ4c2lGQ1VsWUMwRUJUK2tpbC90YUpuUTZOOXFYd3dZblM0NkNqSTEvelZO?=
 =?utf-8?B?SThJaVkwVDhPa3VjeW12NlBwOEhudWJUdUZFVzQrcFhZRmpMcmJYRHVhamg3?=
 =?utf-8?B?OTF6T2ltWmdrNEZvK0QyVkNoTjl1L0lwQ2JzZkgwQ2RqeUJnL2dZeCtPTnBL?=
 =?utf-8?B?Njljai83ZEEzeUp5RHd3eWY2b041MkFKdUVHK1ZWRzh2MmY3dkpQRmFERk9M?=
 =?utf-8?B?MTJwUy83QWxsOURkZUJtQW5DYnF6ZnBzSnNQdU0wSXdXZGFQY0Nqb0FQN2ox?=
 =?utf-8?B?WlpHNnI1U3VoamdkV0NMTTJNc25CZkRHTTNnRUJmYm5IdGU4K1pYVlVzVVRO?=
 =?utf-8?B?ekFXUFFDU1NJY2UxRXhUY3JyNGl2WDNwRU1KRUFLQnpoZkdpTDVsUW95V016?=
 =?utf-8?B?TWFIeVNWbGRPakdaUnhMdS9Xb1VZU0hWSld0aXhHUVhSUk9icE1LUVBnb1Az?=
 =?utf-8?B?dWhWRnMzNDV5a3VhREJoZlltdldpd011OWlIM0NYMzFkanZOc1IxRVpmN2Uy?=
 =?utf-8?B?c1g1dFdlVStMUTlKREpuWjUrdjJhcjMxR21HMFE4am9ybWg4SDU5VGs2TWFC?=
 =?utf-8?B?ZE5xdVRXSVMxTTA1MHlMMFBEQkdjWU9CYUttUmt0ZlJ3R2d0bjMwdk9HY285?=
 =?utf-8?B?bW1vNXhQQWhBK3hvUEcwYWo3M1pqT3phUkE2WmpROTZQVGwyTXByVlJZZXVF?=
 =?utf-8?B?S1Z3L3NBbVNwU3JycDloL2tDZDdYL05HckRZS0ZzTnVvbkFqb0lPKzJRUkww?=
 =?utf-8?B?b2JkVEVRZXNqeS9jSm8xZTgybnFaSWNteDlVVkJTeG9MNVptYkxIbW9lU29R?=
 =?utf-8?B?QTZIdXpDU3h4S21xZG9KaUk3ckc3alhWd01Fd0pMdFlSMEFReG1JbnRYR0Ew?=
 =?utf-8?B?R0QyT0xFS3djT0YyQ2l2cUQwdDBNcVA3R2JWMHo1MUhVNWFkVlJBTm9iNDkz?=
 =?utf-8?B?SUFYM3JJTXR0NEdFcVlTVEJsMVBoQWprcEFUU1dvZytnNXZhZm5QLzJ3Q2l0?=
 =?utf-8?B?MEV6RW1PS2piTlJLK1h1WHZWMnRwR21vV3BwaW5MRk03cEI0bCt4WFVOc1I2?=
 =?utf-8?B?TU1FanFrMjBhTWFJU1hZdzVHNmlYeithb3F4WEhqV0FiUWM1Ujh4bkN4OWJy?=
 =?utf-8?B?UktnLytIZlQ2b2t2Vkp4V2ROVm9zVnZDdkQrU2Jwb0xqT3NZb0lpeS8wZitB?=
 =?utf-8?B?RmVXRWNBRVZ2ZmllSnZvemc4Z2l2YW5ZUlRFbXFDN2hSUCtlV3JqUER5WkVs?=
 =?utf-8?B?ejF6cGVyYWZEU3BKSXlZWVFJbkIrRjlqZ21VM0xreG92elZzMVlKQlY4eENw?=
 =?utf-8?B?M2FWSThqcUpoSmpydG56T0pybGhUaXowNWdpQ3h3ZllWemlTN0lnT0pyUjI1?=
 =?utf-8?B?cTVDSXpmbWlvQ0swTmZzYXJqaThaV0FwZ2lFRVJvanNTZ2lkQmVqM1hIYmtj?=
 =?utf-8?B?b0VVRUtlK3RKRmNZemtNZTVNdlRnaEJsclhZQnF4NnNUOUgvNnkxVm8wNGFu?=
 =?utf-8?B?MnpKSjIvNEVua2NzR3Y0Qys1VUhTTmFmMEJQdGExS3hTNUFkUU4zL2Vvancz?=
 =?utf-8?Q?1U1F8pyHOGP3ksmVxC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cb3b07-1375-445b-0802-08df3ed59908
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:52:02.9423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERa8jY+kmF1TxmG+eIbglp1IOW5ZnF16/4Kc0rCa//ishVPoDQv+xvXfvc9Ja6gpJEqhsnnRItg1RRLELJioDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 8:33 PM, Christian König wrote:
> On 10/21/26 04:58, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu_svm.h with SVM data structures and public API:
>> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
>> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>>    attribute tree, rw_semaphore, GC workqueue, xnack state.
>> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
>> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
>> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
>> - Public API declarations (including clean_queue, sync_work)
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 195 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>>   2 files changed, 199 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> new file mode 100644
>> index 0000000000000..72f954d2df39e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> @@ -0,0 +1,195 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_SVM_H__
>> +#define __AMDGPU_SVM_H__
>> +
>> +#include <drm/amdgpu_drm.h>
>> +#include <drm/drm_gpusvm.h>
>> +#include <linux/atomic.h>
>> +#include <linux/kref.h>
>> +#include <linux/list.h>
>> +#include <linux/printk.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +
>> +struct amdgpu_device;
>> +struct amdgpu_vm;
>> +struct amdgpu_svm_attr_tree;
>> +struct amdgpu_svm_attrs;
>> +struct drm_device;
>> +struct drm_file;
>> +
>> +enum amdgpu_svm_xnack_mode {
>> +	AMDGPU_SVM_XNACK_OFF,
>> +	AMDGPU_SVM_XNACK_ON,
>> +	AMDGPU_SVM_XNACK_DEFAULT,
>> +};
>> +
>> +#define amdgpu_svm_assert_in_notifier(svm__) \
>> +	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
>> +
>> +/**
>> + * struct amdgpu_svm_gc - SVM range garbage collector used for unmapping
>> + * SVM ranges in response to mmu_notifier events.
>> + * @wq: Workqueue where @work runs on.
>> + * @list: Ranges list in garbage collector. Protected by amdgpu_svm.work_lock.
>> + * @work: Drains @list under amdgpu_svm.svm_lock.
>> + */
>> +struct amdgpu_svm_gc {
>> +	struct workqueue_struct *wq;
>> +	struct list_head list;
>> +	struct work_struct work;
>> +};
>> +
>> +/**
>> + * struct amdgpu_svm - shared virtual memory context
>> + * @gpusvm: Embedded drm_gpusvm base, manages the range/notifier trees.
>> + * @refcount: Reference count guarding the lifetime of this instance.
>> + * @adev: The amdgpu device this SVM context belongs to.
>> + * @vm: Back pointer to the owning amdgpu_vm.
>> + * @attr_tree: Interval tree of SVM attributes.
>> + * @svm_lock: The driver_svm_lock described in the GPU SVM locking section.
>> + *            registered by drm_gpusvm_driver_set_lock().
>> + * @work_lock: Protects the deferred work queues such as @gc.list.
>> + * @gc: garbage collector for ranges queued for destruction.
>> + * @exiting: Set once when the context starts tearing down.
>> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop stale
>> + *                 faults.
>> + * @default_granularity: Default range granularity.
>> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
>> + * @invalidate_ranges: Callback of the MMU notifier invalidate event.
>> + */
>> +struct amdgpu_svm {
>> +	struct drm_gpusvm gpusvm;
>> +	struct kref refcount;
>> +	struct amdgpu_device *adev;
>> +	struct amdgpu_vm *vm;
>> +	struct amdgpu_svm_attr_tree *attr_tree;
>> +	struct rw_semaphore svm_lock;
>> +	spinlock_t work_lock;
>> +	struct amdgpu_svm_gc gc;
>> +	atomic_t exiting;
> 
>> +	uint64_t checkpoint_ts;
> 
> By now we have figured out that TS in faults are not useable for fault handling.
> 
> Background is that they reset from time to time because of GFXOFF and may vary depending on the engine who sends the fault.
> 
> Adding Timur from Valve on CC, he send out a patch to completely remove the existing timestamp handling from the fault filter.
> 
> We need to come up with a different approach here.

Got it, is that valid for you to remove the checkpoint_ts check in this 
series?
I check the series of Timur, didn't find speific new approach, can you 
please help to point out the new approach.

> 
>> +	u8 default_granularity;
> 
>> +	bool xnack_enabled;
> 
> It's probably ok to have that here for now, but that will become a VM property in the future I think.

Will try to move this into VM.

> 
>> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
>> +				  struct drm_gpusvm_notifier *notifier,
>> +				  const struct mmu_notifier_range *mmu_range,
>> +				  struct drm_gpusvm_range *first,
>> +				  uint64_t adj_start, uint64_t adj_end);
> 
> That looks a bit questionable. Why is that a pointer inside the amdgpu_svm structure?
> 
> Apart from those questions that looks rather reasonable.

The invalidate callback is for both xnack-on and xnack-off mode, the 
logic of those two modes are different. Differnet callback is set in
different mode.
How about remove this call back then put two modes logic in a fixed 
function?

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>> +};
>> +
>> +static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
>> +{
>> +	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
>> +}
>> +
>> +/*
>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
>> + * Hold it in write mode around structural GPU SVM updates, including
>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
>> + */
>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
>> +{
>> +	down_write(&svm->svm_lock);
>> +}
>> +
>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
>> +{
>> +	up_write(&svm->svm_lock);
>> +}
>> +
>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>> +{
>> +	lockdep_assert_held_write(&svm->svm_lock);
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>> +
>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>> +
>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>> +					       uint32_t pasid);
>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>> +			    uint64_t fault_page, uint64_t ts,
>> +			    bool write_fault);
>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>> +
>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>> +			 struct drm_file *filp);
>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>> +			    struct list_head *work_list);
>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>> +				 const struct amdgpu_svm_attrs *old_attrs,
>> +				 const struct amdgpu_svm_attrs *new_attrs,
>> +				 unsigned long start_page,
>> +				 unsigned long last_page);
>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>> +#else
>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>> +				  struct amdgpu_vm *vm)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>> +{
>> +}
>> +
>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>> +{
>> +}
>> +
>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>> +					  uint32_t pasid,
>> +					  uint64_t fault_page,
>> +					  uint64_t ts,
>> +					  bool write_fault)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>> +				       struct drm_file *filp)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>> +
>> +#endif /* __AMDGPU_SVM_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9b07df5a2b816..b435e393be154 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>   struct amdgpu_job;
>>   struct amdgpu_bo_list_entry;
>>   struct amdgpu_bo_vm;
>> +struct amdgpu_svm;
>>   
>>   /*
>>    * GPUVM handling
>> @@ -381,6 +382,9 @@ struct amdgpu_vm {
>>   
>>   	/* cached fault info */
>>   	struct amdgpu_vm_fault_info fault_info;
>> +
>> +	/* SVM experimental implementation */
>> +	struct amdgpu_svm *svm;
>>   };
>>   
>>   struct amdgpu_vm_manager {
> 

