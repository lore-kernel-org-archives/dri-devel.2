Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DAECD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBE910F546;
	Fri, 12 Jun 2026 14:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akgAIBJZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7645310EA53;
 Fri, 12 Jun 2026 14:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3Arpo7wf9V4fYeH9SfBhL0yE87cPwPbeBdffTKfJMYfUEdTwf+2ccXPwnoPsmaNIrC4J8fDA77iWEUTT8Pr7EpWuaUgyfaighwg9S4pkbRdwwk68ie3xBrdyPNiJTgO9FD8jUzn8r1fNyyBkDa3IvAGSOwn/YSa/D6UMl0QauG7bbvzsN/N60zYItVJ+a7VwCBSAse2Yz0bR0VZjS4IUdEDAUobLhoIqeqdWrktgKTFy0bbeqHNeHo4cQ0VoZ00ufjWFePsq+y9HElsjl0WCjTDsHKBZJfneFHhs+hy/72j2Da5b9bDFl/zHpSTp0ZeMu23AHg23G/ihf2BwaEAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/6j+I6K0YA2Vgtm9YaQilD6+Cu9IkVBoRBcziKe0Wk=;
 b=CB9kDhhohdX2wUjxoMiqBh6MMung2BxnvCt+r52+Cp2tlJ59xRCnInRj8E5gD75mXSgng8kRQyN2NvW4iJrehw65kFtAJBKZLtphoR4DHnlkrxT1JOIKNregjQeZSkKdSBIFfAp30k+zGxXSgESAWP+5f3VqlnJZP4TzTrmB9B3TLLJZEpTE58xUhmPU7xkcaIGLKdwMsRiGWZa/t6XGWg8EC5JWDl4OO1tkhJI1n0ncOWzxGRpk1XzygRkt1JCcL7TsDuuDKAmd2KM3ShneWMsVykC2ZVPVbf06Ztnlb3LdBDDKoW26zej+6F7sUOkDA6UdMQZO0UIEYwB/pnU01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/6j+I6K0YA2Vgtm9YaQilD6+Cu9IkVBoRBcziKe0Wk=;
 b=akgAIBJZ5V8WZJqoFwllHcqJKL3R4Y3TPz+OemraspyJeHC1YEEwbB+DCqj2Isiit3vUiIGJgQR3sOZIbXXI2PVWaspP+aDIbr/uKZQPmwl86lxpBntcuLVJZVmx9eYol8LcX72ADYJwCfPDpF/iD7yMZmz7Are0rg+TontlwP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:25:16 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:25:16 +0000
Message-ID: <565b4929-1a66-4167-b53c-243d4a20798d@amd.com>
Date: Fri, 12 Jun 2026 22:25:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/18] drm/amdgpu: add SVM attribute subsystem types
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-4-ray.huang@amd.com>
 <e71a85ef-2b75-4870-841c-c23849918275@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <e71a85ef-2b75-4870-841c-c23849918275@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 724a82d6-de2d-425c-f445-08dec88e6bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 1pZHUCLG373cHM4vsosAElJDzOv/ktfAWo9qBLPlRu3EJmZtOHTnbYgkd0ClRW58fvJQvDBlQ4brs9zq5oA0jGoTgbfVhe28XwRwdd+gPTwd1iCCVwYbKzMjJ2bhKz84BNYkwA70JO8w1+T9gfvWXyD3Bhpl6W0Ug1MB9rABc2OrDjfJZAiyOqdiu6F5gxoLnEi5NOx3dzpY7axCmmPVRcFoVChhtAbAMINbk7O0ka6XF70GH6IGZalh21xLnJLexxJnpTzyctAW46L+Kd/kfIf147fEWd1EJ9DNl3Dt6HQ6yJHFcoMHv3ai7J7KFTeLGOwmnpNHtRT1WAa5SFypse3s6E8KB9rPcnMgfB/7ZZ1pqNdTOqSO2maYodMjULLlus85MSaHcOuSEp8tkKEX9k6JDoUXf8EfquAH9Tg8NDs9plgV8SZmq++UxMgk6BE9Bmfjh4k68I+Tmoy2442iR3c1gxPMKnVq/B3yhQ21rI8eR1x1Vbi4HYJK5VsxKIKyOSu/bRU3Y38zcefWy7XWr3CDYnlhmkMfLcqPSs6MKkHF4/YKq+TLxzsFU94ldDeKCRnhT2rsQIxeUcWy9W/Dnz2vRL6VggCvakfg9A6LftUYYV01+7aG8SszqUYOm7euoT4Mw2Ef0uM36wi+QoUmgErZq2aG2roYQ1mFvM/+TDmkOhPUG1BvaZzq+sZOZrou
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9oazVNZjRRWlR5bEdvd2NTMWJ0emFwSTVmZU9iN0EwaU4yYVpZb2h3dXll?=
 =?utf-8?B?aDZUUWNVcHRTekZPZGQrdGYvaGR6dEZYd0ZFa1Q2OTBNNFU4b3VGeUJWUU1z?=
 =?utf-8?B?NVRwRk9YN3QxWmVJRURmTkVUOStrTGh0ZElQa0ZKU3hPRnRaSFd5ckV5UnE5?=
 =?utf-8?B?UEhXUHpHVENCL2d6SWx5Qmx5aXg2WnZpS2ZaRVZXK0JhVEZtUEg3VUlVL2dQ?=
 =?utf-8?B?ODBxM1ltcjRybERiMmZZWEcra29ibjZONkdiVWtvYjFjcVlRYm9oeEs2djJZ?=
 =?utf-8?B?YTF4UjRNTTNsTnBCNVF0VDJscytPVW4xcVpjTnNCTUxBZDZoSWIrVUNlNDJ3?=
 =?utf-8?B?SjNVSHpTT0NPVG91b1pUY3lka1VqbElPNmFKcnhTVGxpVmlYa2Q4MjR1Z2pR?=
 =?utf-8?B?RmJFS09VMklpOGRKaTh5ZDF5ZGdseEhYSE96eU9xUG5oS1NSNjB2OElCQ0o1?=
 =?utf-8?B?RGRTbWFoVnVDejJuMEhUa0VESmRNelA5bGp1eEJWM2g0UWk4MnpzOWNTQ09D?=
 =?utf-8?B?NlZjcXJlRDBGbVNDOXpDbHl1U0RYWE9PbThwOUJTeWJtcGk3UWxBTnpMQWE0?=
 =?utf-8?B?NFdlNEkwVk8rSjVlZ2tUVFFOaEdORU5TT2F2ZVNKVUhyS0hrQmQwMDRUQ3Zq?=
 =?utf-8?B?aEE1c3pLdTJhTWVkM2l6bkZGTXFqcWMxWUtCQjAxSHRnUEFkZW9scXFoOTJN?=
 =?utf-8?B?OUQzTHdjQlNlcDNGQjluaEJ1VmZvMk5uNEdOOGYwQ3pybnRzMWJVZ3AwOVFq?=
 =?utf-8?B?UU5VKzdvSWV2MEZqZ05yZWRYZTROVU16KzlxMUJ6Mk44cS9vamFTN2lOZ2Qv?=
 =?utf-8?B?YXhjaGVaQ3kwTVNhSDhrdWRqd3NFclNJVHZzakFxUk1SWjUwYzNzWGxSb202?=
 =?utf-8?B?WVh5TkZVOTFGUjhmem1EZ2JzVndyd0hpT09Id1RXOGxSN2d2NmFHemRZTVRa?=
 =?utf-8?B?cTNVQndya1FIeTdXTEdkanY0aUozY25mdDB5aHNBekdnMWY5U3AxblBab0t4?=
 =?utf-8?B?dGNPTDUweXhiR0JiQmIvVkhpendEN2xmZzlaRkxnSUZCRkdqTGRnSXRvUFJy?=
 =?utf-8?B?YjdHa2Qzc3VnRUxuS2JvcGZPVllFSnFMejE4R3lYVlVKaEZhS2djUzY0WXVs?=
 =?utf-8?B?U0huUGVJcEM2ZmxKZW11MUU3TmdkdzcxSXo5YmVwVys2MEFUaGxBaFJSbVU3?=
 =?utf-8?B?UWZWdnptZ1VZOTcyMUNyZVAvRGVRSkVZam9qS2I0UjV2dUNXcnlTVG1qemYv?=
 =?utf-8?B?MXZNN2I5am43OGpxaEV5SVN0Wk9USlFXTldXMHA1RHhrVkM0eWo4aXVXUXo5?=
 =?utf-8?B?akwzUk9QelZvR1VmYi9jdGVOV1UzNm5IWlpiMGhhSnZDMFAxUko5bGFubFNv?=
 =?utf-8?B?eXV4VFpJUTJVNkFnNkw5bkgwcFFReitnT0xtUk5iUjEvL1NKdVJlVFlBM20w?=
 =?utf-8?B?bFMzcnd1alJiOGc4WFBKQVE3YS9DQUM0UDNmOHM1VUduZGhWY01hU1lhdjc0?=
 =?utf-8?B?aGVyQjBER3JvVlFxeGZGYjlkemlEdjFVaWE5ODVoY2JIa0pBaFdXekJ3YkFO?=
 =?utf-8?B?eFhyVmtJK0NrNjArN0ZiWUU4K2ZobFRWVnpyN25yMVhrS3FuWDZLSHpJS0dk?=
 =?utf-8?B?ayttdElhOGw2QUY2dmc3bk5lWnIrdUVyVjRwSm1nVXkxSFBtWGxVTEUyTmUv?=
 =?utf-8?B?MEJRMjZWMi95bDF6MnVvZk9uVlZ5dTg4bTZnbGxiZFJiSEQ3S3g2WnNadXgr?=
 =?utf-8?B?V3FoQ3QxVnh5Z0xhY1lvM0pVaWdHSm9sNml4VUNsQmVxZUVnWW41MGRSb21l?=
 =?utf-8?B?RW4wbldBY0ZqR2QrTUlWZFk0MDhlbU0vbnJzSnByMzVQaC9tOFZINTEvUUN5?=
 =?utf-8?B?OVNVZzJiYXUzcFBHNkxZMGpwWXZaNDRKUGRQSGtUZ0QxSmJIUUMvdlFURUdW?=
 =?utf-8?B?dWhpWmN5M3pmOWZPaGk2U1J5QVRBbHBlN3pRK3lwV2JYdEsvejVpUWo5aTRF?=
 =?utf-8?B?MlhNb3VFVlEvMmorQVFod2d3cmkvU2tkd0k3V2szME9XR0RNeEhzN1lvcUhk?=
 =?utf-8?B?UzN0enV0ZURPcjIvZVRNNDhaY2M4SlFPQWVuL3U3aUdqWmFyK3pjWTVyWk9P?=
 =?utf-8?B?R2pzaVB5ZURIazYrSEFFYnNBazh4QzA5aFBWZUpCbXNraW9Gd3NlcTJmY21m?=
 =?utf-8?B?VUpOaEhWL2svMmo5U1h2STFtMHlrc0pPZE9UMUdOR1Bxb3d6VnV1R0hTcTVE?=
 =?utf-8?B?OGN0eENMQ01SeWwrWmhiYVVXalNId3VlQXEwS2RYK3Y0VG51YmdlbTJQaTA4?=
 =?utf-8?B?RTczSTN2U2NWVDVBcWMrM3VSQ1V1bGtDamhpcjVlYjl0eW44QjdEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724a82d6-de2d-425c-f445-08dec88e6bf5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:25:16.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f6cGnTO5eOR/2RaJKzI0AF3ZgKIrX7MxTmZLXxudoqL2H2876LxDJ+yUW1cHywmE5hKbKWT6qjSDjI758YNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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



On 6/12/2026 8:03 PM, Christian König wrote:
> On 6/12/26 11:09, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu_svm_attr.h with attribute types and tree infrastructure:
>> - Internal flag bitmask definitions mapping from UAPI attr types
>> - PTE_FLAG_MASK and MAPPING_FLAG_MASK for change detection
>> - struct amdgpu_svm_attrs: user set attribute range
>> - struct amdgpu_svm_attr_range: interval tree node with attrs
>> - struct amdgpu_svm_attr_tree: mutex protected RB tree for store and
>>    search
>> - enum amdgpu_svm_attr_change_trigger: change flags of user attributes
>>    change tirgger
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 171 +++++++++++++++++++
>>   1 file changed, 171 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>> new file mode 100644
>> index 0000000000000..4181ec3bdb046
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>> @@ -0,0 +1,171 @@
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
>> +#ifndef __AMDGPU_SVM_ATTR_H__
>> +#define __AMDGPU_SVM_ATTR_H__
>> +
>> +#include <drm/amdgpu_drm.h>
>> +#include <linux/interval_tree.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/rbtree.h>
>> +#include <linux/types.h>
>> +
>> +/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
>> +#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS		(1u << 0)
>> +#define AMDGPU_SVM_ATTR_BIT_COHERENT		(1u << 1)
>> +#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT	(1u << 2)
>> +#define AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL		(1u << 3)
>> +#define AMDGPU_SVM_ATTR_BIT_GPU_RO		(1u << 4)
>> +#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC		(1u << 5)
>> +#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY	(1u << 6)
>> +
>> +#define AMDGPU_SVM_PTE_FLAG_MASK \
>> +	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
>> +	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
>> +
>> +#define AMDGPU_SVM_MAPPING_FLAG_MASK \
>> +	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL | \
>> +	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
>> +
>> +struct amdgpu_svm_attrs {
>> +	/* keep preferred_loc to adapt to kfd API */
>> +	int32_t preferred_loc;
>> +	int32_t prefetch_loc;
>> +	uint32_t flags;
>> +	uint32_t granularity;
>> +	enum amdgpu_ioctl_svm_access access;
>> +};
>> +
>> +struct amdgpu_svm_attr_range {
>> +	struct interval_tree_node it_node;
>> +	struct list_head list;
> 
> This needs more documentation. Why do you have an interval tree and a linked list here?



Got it, will add documentation.

And why need interval and link list is:

interval tree: point/overlap lookup on fault
(amdgpu_svm_attr_find_locked) and on svm_attr_set split/merge.
linked list: address ordered traversal for svm_attr_get and for teardown.

And actually it references the design in xe_svm/drmgpu_va:

struct drm_gpuva {
     ...
     struct {
         struct rb_node   node;
         struct list_head entry;
         u64              __subtree_last;
     } rb;
     ...
};



> 
>> +	struct amdgpu_svm_attrs attrs;
>> +};
>> +
>> +static inline unsigned long
>> +amdgpu_svm_attr_start_page(const struct amdgpu_svm_attr_range *range)
>> +{
>> +	return range->it_node.start;
>> +}
>> +
>> +static inline unsigned long
>> +amdgpu_svm_attr_last_page(const struct amdgpu_svm_attr_range *range)
>> +{
>> +	return range->it_node.last;
>> +}
>> +
>> +static inline unsigned long
>> +amdgpu_svm_attr_start(const struct amdgpu_svm_attr_range *range)
>> +{
>> +	return range->it_node.start << PAGE_SHIFT;
>> +}
>> +
>> +static inline unsigned long
>> +amdgpu_svm_attr_end(const struct amdgpu_svm_attr_range *range)
>> +{
>> +	return (range->it_node.last + 1) << PAGE_SHIFT;
>> +}
>> +
>> +struct amdgpu_svm;
>> +struct mm_struct;
>> +struct vm_area_struct;
>> +
>> +static inline bool
>> +amdgpu_svm_attr_has_access(enum amdgpu_ioctl_svm_access access)
>> +{
>> +	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE ||
>> +	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
>> +}
>> +
>> +struct amdgpu_svm_attr_tree {
>> +	struct mutex lock;
>> +	struct rb_root_cached tree;
>> +	struct list_head range_list;
>> +	struct amdgpu_svm *svm;
>> +};
>> +
>> +enum amdgpu_svm_attr_change_trigger {
>> +	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = (1U << 0),
>> +	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = (1U << 1),
>> +	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = (1U << 2),
>> +	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = (1U << 3),
>> +	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = (1U << 4),
>> +	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 5),
>> +};
>> +
>> +#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE \
>> +	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | \
>> +	 AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
>> +	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
>> +	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
>> +
>> +struct amdgpu_svm_attr_tree *
>> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
>> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
>> +int amdgpu_svm_attr_cache_init(void);
>> +void amdgpu_svm_attr_cache_fini(void);
>> +struct amdgpu_svm_attr_range *
>> +amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +			   unsigned long page);
>> +struct amdgpu_svm_attr_range *
>> +amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +				  unsigned long page,
>> +				  unsigned long *start_page,
>> +				  unsigned long *last_page);
>> +void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
>> +				 struct amdgpu_svm_attrs *attrs);
>> +
>> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
>> +			   uint64_t start,
>> +			   uint64_t size,
>> +			   uint32_t nattr,
>> +			   const struct drm_amdgpu_svm_attribute *attrs);
>> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
>> +				       uint64_t start,
>> +				       uint64_t size,
>> +				       uint32_t nattr,
>> +				       struct drm_amdgpu_svm_attribute *attrs);
>> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page);
>> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page);
>> +struct amdgpu_svm_attr_range *
>> +amdgpu_svm_attr_range_alloc(unsigned long start_page,
>> +			   unsigned long last_page,
>> +			   const struct amdgpu_svm_attrs *attrs);
>> +void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +					 struct amdgpu_svm_attr_range *range);
>> +bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
>> +struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
>> +					unsigned long addr);
>> +int amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
>> +				unsigned long start_page,
>> +				unsigned long last_page,
>> +				unsigned long *bo_start,
>> +				unsigned long *bo_last);
>> +
>> +#endif /* __AMDGPU_SVM_ATTR_H__ */
> 

