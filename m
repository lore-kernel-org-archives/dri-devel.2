Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EF8CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1086112192;
	Fri,  9 Oct 2026 14:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OsuM/vi2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFDC10E9D2;
 Fri,  9 Oct 2026 14:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfMKnPq7ZH9/lNyrbR+Y1dUOVmoNYadlll4i80xB3mIBMTnmxaRvDqpq9c54XLdUmrCdB5V6Ng8fLRHha1928GjXOcvuxVhgWuA0KKLSlW8KZaT0MJpTS4MzgOYFEfop/kGkUkT30kbkXPFoxwCmnl8feWhzWl6Ci6cu7xAuUzf+YaS8+Pz+tXsglA9bJUigwthIOy0n9iS2q3m22lDlyD5iftQn1txlqfLHa3Kgs9u04UhPYpIC77QyWdxOeDhgXFuGiaLOq48ZBrxwvfrxHK0+pbz7oFKsK7G/PDMhAcT89Qac1ec1gvIrt9FDVdp/B7YIHVHMphVJOgQauQauQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1xaJLkPGSsW7BKJHlmD/jxgy6pwgI/LFkYtZx7XmhI=;
 b=pDrstW94p99AppiSoy/ARGtImDUVOp5VjcgPhP1yAVtHoPgZXSUCWDEaqXhKiAuWzKQSd7H3eIPdGgm33JhEWubVve4kR0gkvn2M7tGV6Qfwf3CW+cl/lN0bBWb5pzjd/nLFbEm7GiwIuG3ZKoIJkrTrwlcJ49csH97grkOq0pyWqpdqDJFnWez+qnaouq6Rkoy8felw3fcZZzyZReyAFvDbMH0gV2YVUdInA3A1rQ+qFqzO/HSHxPhGm9cq1KvbuhIi3IkwxvSLzDFbBDkaw3IHJhg8AFxM5hOIWzNO54tYVJF+GT2g/VnvTHADAZm7bD8vOlTETalx9SahISN/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1xaJLkPGSsW7BKJHlmD/jxgy6pwgI/LFkYtZx7XmhI=;
 b=OsuM/vi270BFlcNiq52xkASFrjv45OsmHZ0G5IEcsbNO97paz+eu2l/7IoOP0OwE2nhbOw3ZFTIdET6Z8k+EotDv77nDhuFa8sLw7cr5nkYB0bLjEalqcx2ZBSIw/bykzh25UslRe4g7Dpmy3lcBJtfXPU/U9Tpo7/mX9RlKODY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA0PR12MB7604.namprd12.prod.outlook.com
 (2603:10b6:208:438::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 9 Oct
 2026 14:38:24 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:38:24 +0000
Message-ID: <91cb8302-350b-43b8-bcd7-73637deb207d@amd.com>
Date: Fri, 9 Oct 2026 10:38:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdkfd: Fix use-after-free in the process creation
 error path
To: Binbin Deng <18983559317@163.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261009132619.40151-1-18983559317@163.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261009132619.40151-1-18983559317@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0336.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e05e3c-4f16-4161-9576-08df2612f906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|10067099003|18002099003|11063799006|260925021311599003|260925021911599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: VW1c29mNK+wFQ4/JkYkQLZ8lhtYXsY0ylNZYEsOQgPUMCEd74E3oNG9QBFO7tg2mSwwN36BjTEIZFCioHEiJ/aSJWcGTiXX4L2k1QLSEwPXA4PKIWtroui9p3svxCeQ1pjlKOEWCQ+ep4UJP/kmKQjTWFfMhNC93pFJPfMPcz0UcxNr9xJR4Yks1gLRZMkgUjWesEB2cu9e7GNAGW1Nv4qIdRmtU5tQwe5rivJo650Da2FlmvY+GF6lyvMJs4W05bK9sisrpf+KjxwR30SNnX9Bup4r11F/a3fjdVJ9j2eHNKQXqhRCLKgH2iGbwtKJcVpIOOfXS+GY5WVJSJw9H+fGikPUqZYkv61vldzIK/biPnWk274WaFEVP9i1/7/kXMEsspDhSUZ3RftTRjHpUiTHsBa5DwnIJeCA3zxWXcRlA1+Ejc/pZAFRLLTAvOoLgPk7g77r5RZ+nSpr+X7CfAoacsmk+Nwo1Do+hYT/ooNb9f3+8WVKqgOOCdFg98gr8ULr85h0I1dOLHEQhOLtSdwFjgatyRztJcqcVAlxHOI+AUs6U81jt/cWAusj/xJ/J6XEuuWZUUswIy86qS2eQ6Rh3e/vo2yuOu6w07wf8kXJ6Wy6NL+qI4PBX6bYdtZVzoQbXUP0a9x0E+FsI15ZDNMviCyJUwGLmoQyRguUA1Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVJsY3BlQXU1Vzk2RStiZ3hDOEpVbGs4eUVpMHBKcjJLczBIa0dtcTh5aTlJ?=
 =?utf-8?B?VUJEdlhsYWFLQm5pTWZnNlhlUW53bVIrSGw1UnduZUZ6alJDQmFWNCtpWHVT?=
 =?utf-8?B?a3lXV0djVjBPRXRwRGxSV1BpVnAyNVRJUnZmN0JUcnRHZFhRVk5COUlYTlZW?=
 =?utf-8?B?ZkltNThnT3MxT01aVDJ1a0F3ZzI3RURUZ3o1NlpEK2dnRVAzOHEweUhFbzRX?=
 =?utf-8?B?M0pENW1FYVc0NFhZL0FWanZISlIzUy9KRzd2YkhVMXQrSHJFcEVLZkE2T1Vy?=
 =?utf-8?B?ZlNUM3BDOWFKaDErMkRIalVIQjJLRk50MGxhUWRaTDVlc0pDRjRmay82Wmg4?=
 =?utf-8?B?azdXVnM2TVArTlJsdk9JZ1I0K1hUR0haOFFxNFBSS0szUjViWFA5RmpNUk5C?=
 =?utf-8?B?VHcrMzFhY1BPNmlHTFRRaVp4K2Z1b2tKRHNPdHN5cDRuMFEwc0tHMHFBZFpo?=
 =?utf-8?B?RDJBK0t1akQvTEp6SVN6MVpSNlJua1d4Y20reWE1VlMrMmN4cTg1UFdtZm1U?=
 =?utf-8?B?cjQ3Mlk5bGlhOHBCSmdEZ2R6RGpUMDRJM1FoOHI1cVBpWWFXL0pEWHNRODAw?=
 =?utf-8?B?a01JVHRzalozUTJyZ1lsallnL3RJdCtIQTFNb0JsdEZEVENIbXJnUVBmRFdD?=
 =?utf-8?B?UkQrYitlVXR1RitzVTE4ZVJZZUFEVkdYN1NNU1FXZHMwYllpbmJWajBJQ2RW?=
 =?utf-8?B?dmVzT29aSVBxaUlUZ2FVYWpCeXM2dkRWbzAwWXprczR2SEtnU0htTnJmZVZr?=
 =?utf-8?B?cnVNUDZuQUlvV3d1dFRYQXM5dDFPemoyN21NL2lXT3RKYXJuUlIzeEEyNnlF?=
 =?utf-8?B?WlcvUTQrZkVlRTJwekFXcEVzQTJ2aHo1TktLcHo3amVaM2JGQ0FRU0c2MVM1?=
 =?utf-8?B?TXF6SDhoRWFWS2ttaWRaME1ZSmxvRWovY0xtM2dhekd6NFBremFZRy9tNXVl?=
 =?utf-8?B?Nm01M3JDbk1aekJqTGpQaHl3YktCZFRiN0tBNytnWmlKMWxKQkZtUDhWZkN2?=
 =?utf-8?B?NzYxYW9JQ2FuR0FsSzlWR1IxSVlvMUVYblRMWUc3TmN4Uk5JdmFKYTZESUFC?=
 =?utf-8?B?OEdFblA0Y0hTUGV1ZWRkVW5qZCtibWJSZ1l4SVJUUjQrTUVXUUV3MnhTaG5T?=
 =?utf-8?B?Z3ZPcHc2RDh0ekZXNUNlZjRjWUxldWg4b0FiWUc3VXJ6dWZWbVV4b2thdTcy?=
 =?utf-8?B?VzdJRm5tT3ZOWG5ZU0NEMzhEQXg0NnhPc1lGTjRQN0kyTXduV0hMdVhQT2dr?=
 =?utf-8?B?eHNGUmxFRUxDa2d6UmtQbEtYT1JJNDFEV2JhdmtaS3g4RGt2TDEvWmdwaWNr?=
 =?utf-8?B?QzhWQmtUcWR6YjkrdWQwcmRTVmZKQTJyNkdDcGt3ZDRZbGZ5YkRudW9WMkYx?=
 =?utf-8?B?ZnYyc05Bd3pDbThIMVJPbTJncGpTWVFVWnVOdmcyMUtlODhmU1RGemdTcWhx?=
 =?utf-8?B?VE9MNzFFN1ZvSWxMNTBLK0xUREQ0T3o0QzM4QS9Jbld5cng5K3ArZTF6MmNw?=
 =?utf-8?B?Q1RwT3FNUUVwa2g5L3BBdDU1YlQ2bEkyZlcxZzlseTZIQlRGSE9FbVp3Zzdi?=
 =?utf-8?B?ZWtaUlY0aExIZ2IyV21hZ0tQNkcxcXkwdFhlb2VNVmlGK0ZuNmtFWUd6VWYy?=
 =?utf-8?B?RUVnRGdFQ3Q0U1dZL1JIamYyKzZ0U29uSEVuN2duem9KdXEybXZEQzhGZFpE?=
 =?utf-8?B?N2ZGNFgrdmcvR3haUXkrOGZwUG9ZYmlEKy9JUGZhbWRVckprL3Noa1ZxT1JU?=
 =?utf-8?B?VWNkWGluMXdlaENUZndRdFkxZVVoK1Vja0xHSUFiNEhieFNtMmlmQ0ZFZk5v?=
 =?utf-8?B?QmlvUmNVTkhFamMvMVd2cTNGdWxaMGdkcE5nZTBtRXVlZDRQTnMzT2tqTE5G?=
 =?utf-8?B?SXFYTG5nR3UzeVBDbHJOOWNweFdkNStDL0lmcTgyUk1lNGVxMVpFT2QxK1ZY?=
 =?utf-8?B?aXJZMW52NTBKaE9qZnBSZm51eUtlbnQvM1I4V1hTSEVkcis5c0t2L0xLeU9O?=
 =?utf-8?B?NUllM2FPeGR3TjVXNDhZUzBjend5RHA4U0R2eEVzUU5WdmMwYlJHZ3dscjhS?=
 =?utf-8?B?RlFFSFRyeUkzYzJXdkUyeHNZT21IMTQxUGRFcGR4VVRCYWNZS2dOc2RETE1T?=
 =?utf-8?B?ZmdlVElLZU1XN2ZZMVRaakpZemdTOEFjbjhVVWVQYjlLNUJQc2tEMEZORTRS?=
 =?utf-8?B?bWVXMjFsRkhPRkcxeVNoMDU3OXhCcUpaaVpqQnlmSmlMTkdnRW82YWRlaFhK?=
 =?utf-8?B?Vml3bE9FZmhPcWNMdGhpM3pJNTc1V1pyTWQ4OHRaQzExbG1DM2h5V1N3K3Q0?=
 =?utf-8?B?bVE0ajdNOXNrY3hqMXp2UWN3cmdWc0RFdmRoOUYwV2ZwVklYUFFwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e05e3c-4f16-4161-9576-08df2612f906
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:38:24.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPytnsi9NrywMrrpWlOhTbrBPfvZ6fgY4VmMnMhFNCIGMH8ODHoUM+PViuqjESYkiqqhFRVLI64KBniW9eVHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

On 2026-10-09 09:26, Binbin Deng wrote:
> [Some people who received this message don't often get email from 18983559317@163.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> create_process() publishes the new process in the global hash table
> before the steps that can still fail:
>
>          /* alloc_notifier needs to find the process in the hash table */
>          hash_add_rcu(kfd_processes_table, &process->kfd_processes,
>                          (uintptr_t)process->mm);
>
> If a later step fails (mmu_notifier_get() with a pending signal, or
> kfd_process_alloc_id()), the error path removes and frees it:
>
> err_register_notifier:
>          hash_del_rcu(&process->kfd_processes);
>          svm_range_list_fini(process);
>          ...
>          kfree(process);
>
> hash_del_rcu() only unlinks the node; readers that entered an SRCU
> read-side critical section before the deletion can still be walking
> the hash bucket and using the node.  The unconditional kfree() that
> follows is not covered by any SRCU grace period, so such a reader can
> obtain and dereference freed memory.
>
> The readers are the GPU interrupt and ioctl lookup helpers, which run
> under srcu_read_lock(&kfd_processes_srcu) only:
> kfd_lookup_process_by_pasid() iterates the whole table with
> hash_for_each_rcu and dereferences p->pdds[] of every entry;
> kfd_lookup_process_by_id() and kfd_lookup_process_by_mm() match and
> return the process for further use.
>
> The normal removal path (kfd_process_table_remove()) already executes
> synchronize_srcu(&kfd_processes_srcu) after hash_del_rcu(); only the
> error rollback path misses it.  The race is reachable by an unprivileged
> GPU compute user: a thread whose process creation fails (e.g. ioctl
> interrupted by SIGKILL at mmu_notifier_get) while another thread is
> servicing a GPU interrupt that walks the process table.
>
> Fix this by waiting for an SRCU grace period in the error path after
> unlinking the process, before the object is freed.

I don't think that's sufficient. Typically the lookup functions get a 
refcount of the kfd_process under the srcu read lock. Even after 
srcu_synchronize returns, other threads can be holding a reference. I 
think we need to use kfd_unref_process to free the process after it has 
been added to the hash table, instead of doing the cleanup manually.

I see another problem: kfd_process_alloc_id can fail after registering 
the MMU notifier. That should be moved before the registration.

Regards,
   Felix


>
> Fixes: 0029cab3146a ("drm/amdkfd: fix a use after free race with mmu_notifer unregister")
> Signed-off-by: Binbin Deng <18983559317@163.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0a7c1900da95..8d0e70a256f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1747,6 +1747,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>          kfd_process_free_id(process);
>   err_register_notifier:
>          hash_del_rcu(&process->kfd_processes);
> +       synchronize_srcu(&kfd_processes_srcu);
>          svm_range_list_fini(process);
>   err_init_svm_range_list:
>          kfd_process_free_outstanding_kfd_bos(process);
> --
> 2.43.0
