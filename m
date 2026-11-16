Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A049606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w0G8d884
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F9410F177;
	Mon, 16 Nov 2026 13:17:18 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5F710F160;
 Mon, 16 Nov 2026 13:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frCcu5bIHStDb+29Sj9M8DhIuJApRMxjxMXXleOndAMPqxIQV3eOuuh22mFC9E/LjM4/8aBKQfntQ39LxiAv9ViwKN7o6vaj8MstlbLNIQIVlVOpWGKn5ipHarrpazCBmr7Bpqt3Rl+x+FlCoyb+7OVdZ1HhHPyvwy5fBtveW5EQMQ2futlSkIrsvuI76+sJbthHYOUWQhYW/Cmxim3pL9FZHx1rodLSlnQKVaDs1YNT6ePKza2F5wrlRa/lIDTop84PNJ+bKDvIVbZ0gGdRtjqQyeRA29OKr86IExLx89oaL1ioDzDtBETs0dPSXvOZ+KXfAE25xvC6uhC7O0WsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5fqc3Ve8jEuP5FziROitgMnEeqDa8iZ5Y3XB18IlCU=;
 b=HL3KrVJgZbLMnmrotHCbU81AgMRh0xMHg0v8hjEIw7nxmlN8SW57AT1ZcGrV+ABrV35r0xQoH1fZ6MRC5dDwb8cUHHoiRhUYeOYg0faUS4ZdbJkwnMWxjKRcY10KARt8xCyoE4jmJ+e4ciwil/b0WzxxErMzJSuNZH9efW7lRrrONPg9a9X8iHDQvLjf0OW5XLfUqyoliCDDQP5AN6bkfE25FMLFu9VWAnSj5DPP0B/2MFv9ywF1HpkHdrEQ2hBh3vHV+5s6mCSuWVB8S4Xb1HyOUfrOfmWyG3LsrYSYcsu4/4Gbayo90Fncv4L3BhA3yKan0yZpSuWdSn1et9NxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5fqc3Ve8jEuP5FziROitgMnEeqDa8iZ5Y3XB18IlCU=;
 b=w0G8d884B8K1kfD3Chcr638ozUACspKWrBWSunpp4RQvFCYM2ye+Guvgf1i+uHlEZNpYvTPGhddic+t6qUZSJS9uxx41+9PYAFxE6I3KvhvNglLClqWwh9Lvogo0BDb2/MbE+5jRuue5ZSLdSlBAbC0ocrF6yMVLkhyCtbQbGTk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV1PR12MB147030.namprd12.prod.outlook.com (2603:10b6:408:514::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:17:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:17:09 +0000
Message-ID: <e97d0efc-a6de-4060-be48-c2ca128461b1@amd.com>
Date: Mon, 16 Nov 2026 14:17:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] drm/xe/eudebug: Add userptr vm pread/pwrite
To: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org, David Airlie <airlied@gmail.com>
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com, maciej.patelczyk@intel.com,
 gwan-gyeong.mun@intel.com, michal.wajdeczko@intel.com,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-15-mika.kuoppala@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109135549.4128280-15-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:52f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV1PR12MB147030:EE_
X-MS-Office365-Filtering-Correlation-Id: bc59d8b6-5ffe-4cde-7b78-08df43e3eb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|5023799004|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261102130727099003|261009223027099003|7136999003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5ZsdzzBbY1mDVZX9Uc5nd66LcT1TZCmos4ElVaC+M+zYy36ep0re+1rbBaKF1tV+sqOhfeXQJvhye5ZaisIeC8YjvBTSLQ0CzBfoICD1Xp+2/RegwHMVq+YyvxwsOLOfpPfBU30JVZo2A3T6nWNKCbBZtg+U+5QwEQtbilTZ9XVi8xA1xGvg1/HaRQSY+LOT4p3IZMJqpDVhNOzUF/Rt0hjaZnBk0exOi/E8/IqpHTkCUAMMAPrCNaau2zmmp8rbghLT/MIRga4jcggLA67/nUBNb1mUnFWggYyXz/cfiPi9A6eXBBKqM3vE5zlB/iVRrv0fgU6AjGO8jLUFhtjVog//VKPsrHIfsXEXJ/G4qpz7drcBrsfL53wMat4lb6Peh+SCdq5WvPJik/l6onuAXjc0EXsFNYPqKDHc1Ky9ViwMg1oERVncXOvzM5LFO6XFfUdoc3wIM+fLI38KHc/0evctiBhl09OERGntoW6VfTtx5Q4DR3qL1ZjEnt6uGA9QyfWw7/0hTfevG4WjlD+GiucB4+Ju1zPjoVSV9fl/ktzqVl3fyVO4F9Uf41Bc2voIvQ+1hhgCAlLb9aSMW9GJhRWnNzAcFuiltMmd7hkPwqhTZuf/9bkHgkUNtXKQV2L7BGnxHMPWAY+j2c/12c1Du+8A8E+l7lKbJlwY/aW0Q1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261102130727099003)(261009223027099003)(7136999003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9XT1hIUzBKZ1JZY1JGcnA5Q1RENnRkUk1KNmlRamJlWWJYUWxVZWsycVR6?=
 =?utf-8?B?cmlWTkZKOGI5RGxCNElkaEVGR0hEVEszbFJYQkFBRWllRms5dmtpTFdzZ3Jx?=
 =?utf-8?B?S3pvRFdIbHB4NlpscmYvaFYyR1d0L2hjbzkvRUdEL0ZGeUdSTHBXVjVNT2hL?=
 =?utf-8?B?UUlLSVRka1U4VVdkSi9oUnB6Qm1CdXkrM0ZaZzlOU1J2QXdraGI2Qkk2UWdJ?=
 =?utf-8?B?ZlBDUGtaMWsvd0hQOUpNam0vUFB6dFRyUlZjdTQvZTNEdm4vMG92WEhXWldW?=
 =?utf-8?B?WjVKV3dnRVdXTU1MRkJGYlcxcFZUUmU0QXlqTHRxRnMycUZTbytRckNnbG9G?=
 =?utf-8?B?NmdKSFBMdWxKT2E4Q1Vib0ZQdmxVZUg0VStiZnpKazFtVFEwUG5qQ09yRjdp?=
 =?utf-8?B?Q2gvMHdaaHRxeEdQZnZ4RTg0NW9SeTV5cVNjT3Zrd1ZVWldOZElCcno5ZzZv?=
 =?utf-8?B?VWcyalFEVFAxcll2a3ZtQ2VjbmoyTGlFVTR0Sml6MDUvaUZVa3hSQllJZzRX?=
 =?utf-8?B?QVQ1elJUdURkS2g3MDI3T1I1UEVUbnRSWXc3c0xEMFYrRWttNjQwVkFYZnE4?=
 =?utf-8?B?Zjd5N1dxZkpnd1J6L2h0aDJRamw3dzFoNGlhTzgzMmlmbkloNmVjOEI5T0pT?=
 =?utf-8?B?QTRURnFtczc5RFIyYXZRTVFLWWdkb2ZSSmNxTlgrRU9FM09UVHByNjVtOWxF?=
 =?utf-8?B?YlJFdk1RbGZiR2JzWlZucUsyYk1jd09TemU1bHBVQ2VoRVFndkVWVVNsbVlS?=
 =?utf-8?B?TncyZWdCSzBMZUFaRzdGS0RyS01BdGtiTThmUlgyVy9XTlBUdndCZ29uQ1Rj?=
 =?utf-8?B?MWUvQkNoSFVhazlWWDREM1QySWlacGFDS3lXbFVlbnlCb0MyelpiOVZTUk95?=
 =?utf-8?B?NHdzZTlUbmF4RWhLOWhqYTNqT05lbUtyVFJ0ZUdZdHFwZVdrdDVqMU9tT3E0?=
 =?utf-8?B?bjVKWS9WSnliazF5QjREdXU2MEhXMDRPakFOdG9PL0lKZjkzY0tqL1hlRXA4?=
 =?utf-8?B?N1VpWk5TK3RRQkJLR3hLS2ZjS3dZQmJ0c2IxaDN3MUo1WkxUMzkrZi9NTnIw?=
 =?utf-8?B?clJhU01wLzFoNWt3bSt1STNLNjBTNVhqRXZWa29od0J3VnJ3eW9zR1g0N2hu?=
 =?utf-8?B?TTRPUThTYnlwRVIrQlp3b0F2UmlYKzlKYnJsME42UUR2Si9FekpCakJwTHIv?=
 =?utf-8?B?T285aHEwWUExdFQ3RG15azdlbjV4SnFNMnVoblBTcVRBUXgwbFBHSzc0bEdT?=
 =?utf-8?B?eUR1NXpHYnhTRVN3Tk03SHVHQ3NHRFFEV1d5ajFVTS9pRWQxQi83L2hNOW5K?=
 =?utf-8?B?WktYMXdYQVNRNFgvS3NXZU91Ny9QQ0FtNmlEWDR1Z3dSK1hCdEtDOExXSzBS?=
 =?utf-8?B?YkZUV3FlYmowR3d5d1BuMDE1WHlXT1JOTEFodjlBVGRYOWl5VjBZMjV6SW5z?=
 =?utf-8?B?WkVXVkZ3NThxT2NOTUxxUTFvWkZtUFpFaHF4akxyOWZsVklEcHBuVEJpK0FC?=
 =?utf-8?B?R2RGelgvNzBPZnI5NndzYThBMnZ5dVhJTXAvZW5pSGlUdE5tVTk2RUFQZjZy?=
 =?utf-8?B?Y2tLemxUR3pPZHFsSzdkaFJLZVdkR2ZKTEppT2pyRjZPcXZSTXMybDFXaERB?=
 =?utf-8?B?YUhjbmdCckhqSTBBMVJIcUJ2TnZKYkJ4RzVFVTFoRlo0N1g2T0J3ell5T0Jq?=
 =?utf-8?B?K3ViNEVqelRKVDJoQWlsTnA4cnAzL1QzZUgySmdZVzQxRzhtRmhIb0hrZmFE?=
 =?utf-8?B?T0QzaG4zeVFhNk5EeTJ4ek5NNkI1SXliQ2s1cXR6bGVYT3RDcWY5Z3NzRGxU?=
 =?utf-8?B?L0xXT21VWHoxREhNejZIVXREL2crcG15cmNXcW12TUZQQkxFS0Q2UHAvbk03?=
 =?utf-8?B?ZUlVNnBUOVlXa0MwRTlESDB1RWwwTEdQdUlrZXVkcVpwNjBjVUphQThOaGVD?=
 =?utf-8?B?Rmt0VHMzTFlrUFh6UnFkZkZDNWozelJtNEFoNml6UVFoUytKVzdRSUhndVpZ?=
 =?utf-8?B?UFZsWjFxYy9LWnJlWnU3UkZJbWxSRk9WQWhWc2dZQ1lLeW5YdVBSUWRzeG1Z?=
 =?utf-8?B?N2FJL2VneVpWelJabGkyRkRSWDJoYjN3ZFVNdThxMUtxV25yd3Vmc1JxM3FU?=
 =?utf-8?B?OXBxMGZLalRPbVAzQjV5ZWFwYjBVWURWa2Q3ZHVuZmgxaFB1bnZtS3VTR2Vl?=
 =?utf-8?B?T3dLR2VmaDArSWFvRXI2eC95eUpuUUMzQVNWSWU3RDBEUmNpMGIwUGVrSzRa?=
 =?utf-8?B?Vml6VWhTditSMWJud2FmWnp4UWFMTW5GMnYreXFIeVp6bDhiRmt3WHJlU2t6?=
 =?utf-8?Q?qqP1a1ym4c0fcOo4qT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc59d8b6-5ffe-4cde-7b78-08df43e3eb1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:17:09.3062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOvk+Sm/W7sdx4+zdCWe+fNA3mUNLItCWczg15yRQzjwLVVhsT/bIh7p0xIA02zg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB147030
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

On 11/9/26 14:55, Mika Kuoppala wrote:
> Implement debugger vm access for userptrs.
> 
> When bind is done, take a ref to the current task so that
> we know from which vm the address was bound. Then during
> debugger pread/pwrite we use this target task as
> parameter to access the debuggee vm with access_process_vm().
> 
> This is based on suggestions from Simona, Thomas and Joonas.

At AMD we had a legthly discussion if such an interface would be necessary for AMDs debugger interface and came to the conclusion that it is *NOT* a good idea to have this.

process_vm_readv() and process_vm_writev() interfaces already allow a debugger to access userptr resources completely without the need of PTRACE_ATTACH.

Especially since this interface here allows to bypass all the extra security checks otherwise applied to such an action it should probably not be something allowed upstream.

Regards,
Christian.

> v2: need to add offset into vma (Dominik)
> v3: move code into xe_userptr.c (Mika)
> v4: check that task mm has not changed (Claude)
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_eudebug_vm.c | 52 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_userptr.c    |  4 +++
>  drivers/gpu/drm/xe/xe_userptr.h    | 34 +++++++++++++++++++
>  include/uapi/drm/xe_drm_eudebug.h  |  2 ++
>  4 files changed, 92 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_eudebug_vm.c b/drivers/gpu/drm/xe/xe_eudebug_vm.c
> index 385fcc7e8f5c..e18792c87ca8 100644
> --- a/drivers/gpu/drm/xe/xe_eudebug_vm.c
> +++ b/drivers/gpu/drm/xe/xe_eudebug_vm.c
> @@ -8,6 +8,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/dma-resv.h>
>  #include <linux/fs.h>
> +#include <linux/sched/mm.h>
>  #include <linux/string_choices.h>
>  #include <linux/vmalloc.h>
>  
> @@ -106,6 +107,57 @@ static int xe_eudebug_vma_access(struct xe_vma *vma,
>  		xe_bo_put(bo);
>  
>  		return ret;
> +	} else if (xe_vma_is_userptr(vma)) {
> +		struct xe_userptr *userptr = &to_userptr_vma(vma)->userptr;
> +		struct mm_struct *mm;
> +		int ret;
> +
> +		if (XE_WARN_ON(!userptr->eudebug.task))
> +			return -EINVAL;
> +
> +		/*
> +		 * XXX FIXME: access_remote_vm() on userptr->notifier.mm would
> +		 * fit better, as the notifier already holds a reference on the
> +		 * mm and no task reference would be needed at all. It is not
> +		 * exported though, so go through the task with
> +		 * access_process_vm(), which is.
> +		 *
> +		 * Going through the task means the address space is resolved
> +		 * from it on every access, and the task outlives its mm: after
> +		 * an execve the same task carries a different address space,
> +		 * and after the thread exits it carries none at all even
> +		 * though the process and this mapping are still alive.
> +		 *
> +		 * Confirm the mm the userptr was bound against is still the
> +		 * one the task holds, so that a replaced address space is
> +		 * refused instead of handing the debugger bytes from an
> +		 * unrelated program. access_process_vm() resolves the mm
> +		 * again on its own, so this narrows that window rather than
> +		 * closing it. Keying the access on the mm instead, with
> +		 * get_user_pages_remote() on userptr->notifier.mm, would
> +		 * remove the task from the picture entirely.
> +		 */
> +		mm = get_task_mm(userptr->eudebug.task);
> +		if (!mm)
> +			return -ESRCH;
> +
> +		ret = mm == userptr->notifier.mm ? 0 : -ESRCH;
> +		mmput(mm);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * access_process_vm() reports a failure to reach even the
> +		 * first byte as 0, not as an errno. Turn that into -EIO, as
> +		 * /proc/pid/mem does, so that a read does not look like the
> +		 * end of the vm and a write does not return 0.
> +		 */
> +		ret = access_process_vm(userptr->eudebug.task,
> +					xe_vma_userptr(vma) + offset_in_vma,
> +					buf, bytes,
> +					write ? FOLL_WRITE : 0);
> +
> +		return ret ?: -EIO;
>  	}
>  
>  	return -EINVAL;
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 9c1dac0fce6f..87ca94a81a50 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -421,6 +421,8 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
>  	if (err)
>  		return err;
>  
> +	xe_eudebug_track_userptr_task(userptr);
> +
>  	return 0;
>  }
>  
> @@ -429,6 +431,8 @@ void xe_userptr_remove(struct xe_userptr_vma *uvma)
>  	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
>  	struct xe_userptr *userptr = &uvma->userptr;
>  
> +	xe_eudebug_untrack_userptr_task(userptr);
> +
>  	drm_gpusvm_free_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
>  			      xe_vma_size(&uvma->vma) >> PAGE_SHIFT);
>  
> diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
> index 2a3cd1b5efbb..d6e1c46f56d6 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.h
> +++ b/drivers/gpu/drm/xe/xe_userptr.h
> @@ -9,6 +9,7 @@
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
> +#include <linux/sched/task.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
>  
> @@ -95,6 +96,17 @@ struct xe_userptr {
>  #if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
>  	u32 divisor;
>  #endif
> +
> +#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
> +	/** @eudebug: eudebug state of the userptr */
> +	struct {
> +		/**
> +		 * @eudebug.task: task that bound the userptr, see
> +		 * xe_eudebug_vma_access()
> +		 */
> +		struct task_struct *task;
> +	} eudebug;
> +#endif
>  };
>  
>  #if IS_ENABLED(CONFIG_DRM_GPUSVM)
> @@ -133,4 +145,26 @@ static inline void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
>  {
>  }
>  #endif
> +
> +#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
> +static inline void xe_eudebug_track_userptr_task(struct xe_userptr *userptr)
> +{
> +	/* See xe_eudebug_vma_access() for why this is a task, not the mm */
> +	userptr->eudebug.task = get_task_struct(current);
> +}
> +
> +static inline void xe_eudebug_untrack_userptr_task(struct xe_userptr *userptr)
> +{
> +	put_task_struct(userptr->eudebug.task);
> +}
> +#else
> +static inline void xe_eudebug_track_userptr_task(struct xe_userptr *userptr)
> +{
> +}
> +
> +static inline void xe_eudebug_untrack_userptr_task(struct xe_userptr *userptr)
> +{
> +}
> +#endif /* CONFIG_DRM_XE_EUDEBUG */
> +
>  #endif
> diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
> index 448821c32d29..4bb01a3c4fe4 100644
> --- a/include/uapi/drm/xe_drm_eudebug.h
> +++ b/include/uapi/drm/xe_drm_eudebug.h
> @@ -371,6 +371,8 @@ struct drm_xe_eudebug_ack {
>   *   marked purgeable (DONTNEED) or the kernel already purged.
>   * - -EINTR if the wait for the backing store to be ready was interrupted.
>   * - -ENOTCONN if the debug target is gone.
> + * - -ESRCH if the mapping is a userptr whose address space can no longer
> + *   be reached.
>   * - -ENOSPC from pwrite() at an offset at or past the end of the vm.
>   *   pread() returns 0 there.
>   * - -ENOMEM, -EFAULT, -EIO or -ENODATA if a bounce buffer could not be

