Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33558CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D7110E1D1;
	Mon, 15 Jun 2026 06:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVSz+8m5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7D610E1CE;
 Mon, 15 Jun 2026 06:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeNCh6ZL330udJSxNboT5LLAk1La2YYqiJ6orJR5c5PPQ4ITm+Q4srilrRil+UpJo8zWIo7pUdsZDCNhf9jmV+ycbCPY9ZF4FHLAKg0/yQOalkTgRbn8NvANzFXTp/gAKs3KYjZxev4BAJgSZRbvTCrKmStF20hj5HjNtGwnU+OBaK946krnwZY9+kHe367xaovDHHsfZOxBRwv3499BI9vWAZyi080yJGErgzT9aToITqaYgpOIyHuL8+Sq34xoVVXxlM+7FCdr87xMUZSv1BI7d7yG0ZbrfRosX4iT18DGwetuL4L5vFYJpF9BgkY51bitNs2N042u8ryqLlwRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enUZ93Sz9I35ZiPcO16qq6bX94qYX0DdDHt9Db7BU9c=;
 b=fwgKw+GMV/gieAhIr3rzsz23ErQDeGAzuCPyCPibwXXl+xEo/Y34PFW7vPzute/u/JLnQMc53mBe3inqaKA5ISVNLavYP+Nf/fenEL18avMao7w2BOZzp49O0x5Zdl9Pnub5I+m8J1UAVYKYkYXcVyNu0iYalqx58P+nXnRR2/QBiFv1943ONTsv7kisgAjvWVnKTsnT9VD8V06+dRcP5Ifg/k8oe/NSFSS+Jcg/2KoSJa7dgXxZIzrqnjn7TGiFQ7hXij3DQjFksegVtHFLJqcypfPKzj/gRJBXilGKxUUCNA5TDPJdnh/e8BLcQmehlqA5RE+N1lx+d3LUg6/jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enUZ93Sz9I35ZiPcO16qq6bX94qYX0DdDHt9Db7BU9c=;
 b=VVSz+8m5nsN7p9dfVXect+C7Et6WkbSgQzwZ5pdGvdryOdpFr+YNwGcoFEGcsMVzpa167Ma33b5P66cOa3xzYRRWmSL9xoi+NWx6ibzyasNJS9WjSzo2+mOea4y+k7bWYxS4h9jMjbxrwpWo6/HDQmA3Yw0+HrYnzETxEZBwNTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 06:22:56 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Mon, 15 Jun 2026
 06:22:56 +0000
Message-ID: <66bb3ba5-97a8-4eaf-850a-f06f2e7a476c@amd.com>
Date: Mon, 15 Jun 2026 14:22:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/18] drm/amdgpu: implement SVM attribute
 set/get/clear operations
From: "Huang, Honglei" <honghuan@amd.com>
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
 <20260612090928.29682-6-ray.huang@amd.com>
 <32a43737-d2cc-4b8a-9f9e-6b7d0fdabf67@amd.com>
 <3a1ee25e-8fbf-420f-9940-cd3ba487a241@amd.com>
Content-Language: en-US
In-Reply-To: <3a1ee25e-8fbf-420f-9940-cd3ba487a241@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0075.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::8)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: e8781751-429d-4ca9-797d-08decaa68a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZtavLnc7wVwYOpvpNPA4a1vGY3WGLDWGXkqmDCOklskMamBI1wfM1LlnVh/bU9oCXWj7JKG+aa1PjlasM6UhGQpk6Oh4Pr49fLv721sDPU4lrJJydts6mvyZiDG1H31u9rOMMVGfvlW0xd0i8f1M0gcv2xCIvETfid833c6gQ5zQUsB/0/Gq9VgkmRCP3vTTe/m0NpKur2mgfUqnOOh/eZvU1m5Q+x1yi9Cj7ScKYDab6GWYMOLeqxcujKBVEnD1QwCMwb1DU5mm4a18CwTXKM94T7SMgxfPIC5sC+0WZUTkRnpQ8qzzupbVIynOhT0NVCmWLTkHIGz1QyEZ6o3TG+48yi7HK0VLraR0GZ3vl8pV8AjxBNRqulA1UDfzpd3+H3IKS21cPNCVad3cmlDAO8q7zJswVZWxqVaKB9Es3mjY6iqd8H+maZkibqov/yxvKak+ThZzp1NEb27zb8xDsmIUTH/cbE09lLOEQsXBrbtMXwwEiR0ii1OnWx+2maCaaZKv+s32oGWtSm8MiYAjA2qqKxC8pVB0GZavASpKXCKfl8hF1H53Ox2J9V7kyWB1l18GdvM3lMHaS5yAmPTQSP2DtSWerwC66XVq4R4VC8hTO3Pu7TISkhi0yaunp4vUU0Zp3WDVNcpoXfBGCNdpRYDVY3PWmLQIrgvqrWQkpBOZrU+QnSkoiVQhbt+EuZiM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9WeVFueDFJOTFxdkFYbEZKak9yNWFtN3BmUy9QMHozMGgyb29nRFpRMTYr?=
 =?utf-8?B?RHB2Y2dkQktzUFA1VlpSbkpjcGxzSXFaYU9MREZuQ0FGeUlHbnRFOVkxZ1oy?=
 =?utf-8?B?eXMwdjRoeHVub1hnbzc2eXEvdm5TbzRyaWVPZWgzNm5FbGdlVTBGb3JrTlFv?=
 =?utf-8?B?UDh4QVR5dk1NSkJhWGJ3aXMxZmxpYnVlRkt3ZWNPRDF1eWxEYklYNXBFL3d6?=
 =?utf-8?B?djB3V3cwUXVCbFIrK2lIMVl0QUlPcEtwYXBDQ0kvUWphdXMyMWtuT0JuUmJL?=
 =?utf-8?B?QmNXc1R1bk1YekdmcitMOTByNUZTS080VjRESVRZa2xwckVMeUNvM3ArU3hM?=
 =?utf-8?B?NnpZTzlScVA5LzFVekJEMHhVWHZvTUlXamhYUi9TODdOTjZ0N2YwSzc2eE1K?=
 =?utf-8?B?MjRpTzNaMkZDWXFCVk9RVnJrd3hEcTFaa2hqM1J4V05scDhBVDNmaHRFZ1di?=
 =?utf-8?B?bWVPVFZZU1pLSlMwZHdsWHdhVlFYT0xNOXlzZGNaVnUwUjJYTW5QOWxwdGVY?=
 =?utf-8?B?ZVNCQ2VrYnJpdGs4M09Jd09Gbkxham5rUEZIRWdJajg4Y21XRmhSNklFdHZB?=
 =?utf-8?B?VXhlRnBGTTlibFlSYVRIWkZob1JXN1ZvZ3ZUVU14bFF3UFgyRjVDNkRVZ3U5?=
 =?utf-8?B?TXVEQ25HQ3puR0MyNHg3Q1YzUnc1Umppd2Fid3lpalV5Q3IrNU5ZNlNWdnJh?=
 =?utf-8?B?eGdESVM0NlVObnFiTjl6eCtBdURaYm9XTEtTMDJPd2VHRjdkWGVKckRUOTNt?=
 =?utf-8?B?WGZ5R0VxOUJmcG5rT0VsbWNNZlltVGVBZk5OOHRIbkpXTHhyejhoZVI0Lzda?=
 =?utf-8?B?VDlTL1UvRm1XQUpIRkwyV25DcVk0aHV5aDRoQTF6ckVPTWpPSGUreUNPNzVk?=
 =?utf-8?B?RUVPSkl4N3NmQkw4TE1mL25ZN3NjSW0vcER5VkJLMGMyZmVQN2h5b0lLYXVt?=
 =?utf-8?B?SnB0K1pqYnY0WjRiWjVndlE4OS9qMmY2VnVwVFRud0pBYjJMem95MFNyV3pt?=
 =?utf-8?B?SEovZW9OUUN6T0pwRVdnOHdhbGkyTXh5aUM3NzZaTUxxYzFzV2tsa1lsWjlq?=
 =?utf-8?B?V2ZqWEh3akpocHd4eGZsdUdUL0NCRHl5RnlHekNDSDJVY282ZHRVRFlFb25n?=
 =?utf-8?B?N2NMUjI4ak84eTZsanF4NlpmUitrSXgyS2FkWkZ3dEQ1cysrN280dHg2Ujdw?=
 =?utf-8?B?dlkrWEdvakYvdVRuM1dJUU8wYWZLaHNTdHE5eElHQnlBTC9BMitYREE3Y3pz?=
 =?utf-8?B?Y3RwWk9uTHVXUTRYYjREdm5xMm9ORFpKdHFxQVVocGhMVGY5R28zQ2VJVmxx?=
 =?utf-8?B?VTU1TDJuRHNwZWpxMUdBSlhPU1c1RFp4bU5pL2lLR1R1b1BCcnd5ckRhQ29J?=
 =?utf-8?B?ek5OaCs0NG0rOEV1ZTZtMDJITythNXowKzh6TXZMWW01ZkQ4YnY4YnNxU1FX?=
 =?utf-8?B?OUFRbmhXZDRMbTNtbEQvRS9DazNzaHE3bWUxSnhDSDAxK01zWjg1bjlRS2FU?=
 =?utf-8?B?TFpwTmdLMGVkMGcwZkxNOHl1NDZMSlBRcHc2SXVodmxISjNrbUhBemFtdnkv?=
 =?utf-8?B?ZlRoUFpweStVcG5ObVVQZW11LzR1ZHhmVXByeGVyNldvbkw1ay85elVGMjZP?=
 =?utf-8?B?QVpGVmgyQ0R1MVk3N3FsOXNZMkVTaVZXTlNFUkRXWEpoNytROElqdU8vckw0?=
 =?utf-8?B?Z3VwZFlHV081KzBsZlArQ2k1bm1FM2tsakFvWXloVVhCQjlmcTRjSU9vNGJH?=
 =?utf-8?B?SERHK0VpRGl4c0xFeStDa0tzcFJGR0pYdmdhZHZYNWZOc0lVN0U5SVBzbTkw?=
 =?utf-8?B?RndUVkFORWdOYTdSbUVrVldyVXVNVHpubGpUa1VmeUVQV004U2Foam5RRk44?=
 =?utf-8?B?UVN4VVJCcXM5R0NpRDJEeXppbXFWRk91RWY4eTdaeGE4TXMrVUhwbG5HaEdP?=
 =?utf-8?B?cnk5aGNQNDVKZndFMW10SDZVNk8rUytmMGNFWmJ3WTJWVWUwakN4M1pZemJp?=
 =?utf-8?B?NXlWT215OUxGR1BkU0JtakNRY1daUUpuQUp2YVpKV04yd1BNSUJnV29HbWJN?=
 =?utf-8?B?K0NBaW8xSzNhUUQ0Yk5XYWUzak1BRnFFQUtWOVBxdVUrWU9DY2M0b0w3OUN0?=
 =?utf-8?B?TGpvQzdiUERiUVJ0dnZTUm8zVzBzOFVXMGprUnc0a2JJWlA5WElwSWZlWGZO?=
 =?utf-8?B?RmxOVk02U096bW1vSktPRUpjdHRLNklUanR5NUxGbldJODBsK2o5TWtTUWtG?=
 =?utf-8?B?TDZsalRkcnluK3A3dWxYMFMxN24xcFlIV2FQMVgxQjVITFROR0RWQmZ4cUpk?=
 =?utf-8?Q?dUUqqHsEDKvv60muMo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8781751-429d-4ca9-797d-08decaa68a2b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 06:22:56.6424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJ/bFp05xMrE2mDllaxGaXfqE+PEmuLFZTPJMkdkIPRjhWMfTE5JGzQXLywynsXV6bR0pPa7mdxwb2EvrbOEfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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



On 6/12/2026 10:38 PM, Huang, Honglei wrote:
>>> +int
>>> +amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
>>> +                unsigned long start_page,
>>> +                unsigned long last_page,
>>> +                unsigned long *bo_start, unsigned long *bo_last)
>>> +{
>>> +    struct amdgpu_svm *svm = attr_tree->svm;
>>> +    struct amdgpu_vm *vm = svm->vm;
>>> +    struct interval_tree_node *node;
>>> +    int r;
>>> +
>>> +    r = amdgpu_bo_reserve(vm->root.bo, false);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    node = interval_tree_iter_first(&vm->va, start_page, last_page);
>>> +    if (node) {
>>> +        AMDGPU_SVM_ERR("SVM range [0x%lx 0x%lx] overlaps with BO 
>>> mapping [0x%lx 0x%lx]\n",
>>> +                   start_page, last_page, node->start, node->last);
>>
>> Yeah that approach is a clear NAK.
>>
>> We must enforce that based on the range I think.
> 
> How about mirror what xe does, but on amdgpu_vm. xe puts SVM ranges into 
> the same drm_gpuvm va tree as BO mappings, tagged with
> XE_VMA_FLAG_CPU_ADDR_MIRROR, so overlap is enforced by drm_gpuvm at
> insert time.
> 
> vm->va is already an interval tree of amdgpu_bo_va_mapping with
> amdgpu_vm_bo_map() doing the overlap check on insert.
> 
> But it needs some modifications in amdgpu vm, so what is the next step?
> What is the feasabile design in you side?

I removed the amdgpu_svm_attr_check_vm_bo, it is a defensive code, so it 
did not generate any regression, kfd test /rocr /HIP test result are all 
same with previous.

Can I put this check into TODO list? We may need to figure out a solid 
design, and it seems like needs some modifications in amdgpu VM?

Regards,
Honglei


