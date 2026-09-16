Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2BAC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB0F10E467;
	Wed, 16 Sep 2026 11:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pN76R6yX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D75F10E6C7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUz4GBaBiX8RVHJsUw0NqTrQQlF2ywKgwyGBJXOMtmhweMV5s0hVPOdNhXMyVnPgXdDGixntGM8bX8+xQZAWF/lsmCQ1RllfhwLuSxxZL7V8feJH6yiMCT1fTua6bkj8d7t+g3yOhYv/k+0Y2Zp/JBuHXMoe5frv2Ieg/pFHorMqzXoYIhgJKtbxxZZ5PgEiP7ssHqT3OEi3yTdatD7SnliILIZySmqpOIIRaYisGjTGVv6K2RSuqc1ZqQWjvMMq1by/wpZnGMQcWopo+T6EtGHkmkEmKgWnhrZsS0/PkiH1G4ibT+mFbxQgbQ0wiN115xqyRdsWkvQ7Rj5SAvXFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSc8TncsUUqKeAk1qtN39PwX/k1zTCmgwTdBLab+PYs=;
 b=o6pLVkDJJ3ZO1Nn+Ewm0e6T40vFPQaj4ccqhamidecTPXGQA+W8OoyNNrIedmoalDPj/3R0BDunFYredUGdC3AKFLcLx/oj01n4vZkmL+FhXBVgmlG/WCA0Yhb6ns176a8cICaUzi4sis/PKToZRsz4wzoxsNwiCJKLooV0VTZlUMuvzS5EJGEUO9Ign0c9Z0F9eIZhLbScLyVRmR+vDsUIt4VNP110MhTj3mQCvZg88QQE206cJptgjSQZiMHtys0fLbp4x4uYGvbDiYxKb6t7pTxVTMB1X0wh1KpSIKvHpWGoh8q8k1vYWEcD31lN/OivYYQ6FNHO/Xpr2IWJwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSc8TncsUUqKeAk1qtN39PwX/k1zTCmgwTdBLab+PYs=;
 b=pN76R6yXnq0LGoabZ0g+lFNJP2erQp5iFlKUgozXefWKa1lkDpFXBpj0L8L0rLkBeojvL5kfdf7bOCQdtuf+CzMZwV0FpdSvi4u+tLKi3a9uPe+UhwgnkUR253NkjEVOjvCIlxZMro5ut8Vb9l9AgdCnjO6xZSPnwGvUPw4w72g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 11:28:49 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 11:28:49 +0000
Message-ID: <d55151eb-4b81-41c7-927e-96635c1f6b7f@amd.com>
Date: Wed, 16 Sep 2026 16:58:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 christian.koenig@amd.com, ray.huang@amd.com, nat@pixelcluster.dev,
 matthew.auld@intel.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260915154804.605772-1-christian.koenig@amd.com>
 <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d43ef8-2a84-4c5d-7b7c-08df13e5ad9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7WYUFk7p+1JXf1XwWlahsr/Cywh9CRk7ztxvx6Ga0/rvumoct+aAgrQ8Fe+OFoIFJ6xcDhTr7HePEjLShOt71ggsuR10V3nhw3JQrbgLnnlQJG4quaFOa9UCsowdMSKZDx3sLBJnsgiKy2KdkIpJjuGFjoC6QxEPvTlIS7k/0YmKCL9lVnoIMvdqb86eYjC4zTp8GJa5m8XG4Q9n68W9/skdVo3IY0OOfx/3AmoLUybNQwpY1PIoHdg6Dv804EDU+7tXSs9VxZDkkXJIlVBMB45Py6TxZSlnG89C6nvE2Hkis8OGh3O2fDUe9k62jO43RiRRxiKKiXSaErP9aSo0z091oCMGNb00IDRgXUfREklH+Su1cujeYsv75yMySZVMj0ZMpbh0g+HS4JYZYAHj8thWM/iyBJbsgoU4jTvHLsoY67gUMALMTU49kgybpZRb78T3iln4nQvv4nCJbyabKy2lV0wi+zFZeop2r0QD8WLcafIHNL1Wxbfl7M0UN9JZNunxghHHT+kZUStZOoBKbnwiVKXC0A8gSQHiNbUok1zR56zSe06BPKj4aDtzaE6Kd64vcyDQhmbyaSnyWjdzCVA6k46Cph6j3p1eb2asRBJmA31sF0Yvah1vkDuy2rko
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElyVzdmdVpGLzE0NHNVMWpMQjRyT3ZiYXZqdVI2SjFvR2RiYTlva08wcUtI?=
 =?utf-8?B?Y014Sm4vTFNSN3hmelRjZkNZQkpmTGFTMVV5WkF1OHArZTdIRlVpVnI3UGx0?=
 =?utf-8?B?ZFFTY2sxT2ducEhOQXlPK3VobDk5cjNiTUhYNERuVklRQnpnNzNlUzRwR2I5?=
 =?utf-8?B?WU5pdmZHK2dscE5YeVpXVFFoNEs3d0J1TDhaUUZXSC9Id2tpUUhTdTA1a2pt?=
 =?utf-8?B?bWRjOHFPWDl6NzNhMkxrLzNSNU9XVER0ZVlOSWdqYURnUnMvSjRPaG0vV01H?=
 =?utf-8?B?b1J5VjI5Yi9nK1VnVHlPTzIxRlNhZDAxVWdqV2kxanE1WWNXelBZWUNrcEpz?=
 =?utf-8?B?d1l2TmNlU2NaT2NPRTlmRElGM2VWQkZwUW9WTDM5WTFMNWcvR2VQdE5UYnFu?=
 =?utf-8?B?TUF0RHdkWmFXV3kzVy9ndGlnd2hBWnBMclc2UnJabWJpcURiUDhtMUErZC9x?=
 =?utf-8?B?RGczeDBPZGFhNzdtS3JyeHZDT3ljVlg2YXpWNGh4Wmx1eWhhR3poenVOYVli?=
 =?utf-8?B?MHFsZEZ6aDdkRUlLNERHYjUrVVJRQVh4V3ptMGIyMnF3MXJadkJVdU14aGk3?=
 =?utf-8?B?bkxQZE5ZbmZ5NitrLzhhdm1NeTRBS1B1bDYwaUk2TUQzV0ZLMnRXMjg2eFVI?=
 =?utf-8?B?eGNqYnhWTzFZTFNqbTRWcEtwWFJYYnVmSmV1b0FlRmc4clk0NW5uVmdLdFZD?=
 =?utf-8?B?bko0K2Rla0J3L3VTZ0pEbVV6b3JlYVhtQ0ZYeXI2TzdaTkVVRDdlVWpyRFR5?=
 =?utf-8?B?WGZ0TUNtallVUGh0ak1XdEVKbHdudk83aWxIdW1zMDgycU1SVVJSVHRLaXlR?=
 =?utf-8?B?R2lDbmtCaDF5ZGJsSk1DRDdxdVBxM0FHYkMwZFdjMThUd0czTHBaL2RYVnlN?=
 =?utf-8?B?dzljWm4rOFRjVGdUYlN6VTd0UmF4QmxIdC9ncjlXd29IV2k5VzRnbVFqUy9J?=
 =?utf-8?B?UFJ6eGk3QzQxbmZrTjV1MEF3OFoxKzhQbElmVmdGTmNwdEY5STRqdlg5ekt0?=
 =?utf-8?B?VnJibHNqVjRocW5qM0p1bTg5YWg5Uml2eVZybklFQmtLc2s0V2lUUXlUckNs?=
 =?utf-8?B?RjZad0tpSDAzSVdBb0JPTDAydjA3dC9hWmxsdmZBVjhQN1NjeWVzWExSUDFi?=
 =?utf-8?B?ajlOV1RDbHVsWGNHd0Z5K1h0YmZsSDRrQ3RlVUVaMXZTTWpWZ2ZDZTVuQTls?=
 =?utf-8?B?SzU0T0J2a2djOFphYUZQM2trWjNjbTRxUHBOVnZpVEFQVm1Eai9FRHZLYnBx?=
 =?utf-8?B?VnVqV0lqK0ZheFo2TXl6Y3Z0Rk9wQnBPclYzVEZCRUpNbWtOaisxb1U1NmRI?=
 =?utf-8?B?SG1UTGhOcWEvM1k4TmxBejdQejgwbGVrWTE2ZFJDUUMxSTkwbUZzRmZBWWNz?=
 =?utf-8?B?ZVN2Vzc4YXc1c3NxRjMrL3NMNVdZcW4yR0VBcEw0MU5TV2E5dmpLaEkwYitC?=
 =?utf-8?B?dkR0TldDbDBLSzZPL3hCWHFWcGdHN3ZOM3RvcXd3d0dXbGpTMnlwajAxZmRl?=
 =?utf-8?B?Mm4vM0VnK08xdGpYLzJDUzE4ZHVoQWdJR1JjVTNFT0JMMVFDL2hrME9DSjNB?=
 =?utf-8?B?MjBySjFlNi9tcFJOdWdkZE9SaTFIVWtUSCtBM211Mk1xdWlSU0pVdzNrYkV6?=
 =?utf-8?B?V3lNVEtpVlZFbmcyZTNkYkxNTE5RN2tCZ1NudjAwQlNPNUtGa2ROY1hESDd5?=
 =?utf-8?B?eHplSVdpd1p0R0lvY0tqNXlTNTcvYnpYeXdVTFY2YkJMVm45Y0dqS2htQm1k?=
 =?utf-8?B?emtYTnphSDgyUE1rMHRyVGlscFhad1hyayt3cTZneUlqbEZ6T3cwTDduU1ps?=
 =?utf-8?B?c2I2UnFSVlRuQjlFRzVaMlBJYldSMStHcXNsbWo2UDhkZzkrVEx0dVNJYysr?=
 =?utf-8?B?NjJ5eHdqTlY3U0JsSUNISTBhYzcwZlROWnVKV2YvZkZKSUZ1NDFEN1Yrd1B4?=
 =?utf-8?B?ZmpEMkUrWURnN3pjcGx3WXVnTzEzVEhoOVpkS2pENm54ZHdwWEsvVVo0TW10?=
 =?utf-8?B?dkhUMjhXcSs3RDI0SzNpb3haaFJmMkpBd3EzUjl2V2F5WnloZHIvaTZTcXJW?=
 =?utf-8?B?ZkRvV1ZqWE1IUFFSRFZFc05saUZjZjdTSDFIbUZVaHAyaGg3cEdnTDJUdWR0?=
 =?utf-8?B?TTM2clo3TjdUa0NITzNYM0J5R2Q1MTgwdVRvZXNNbGVGa3VCVWM0dWU4UUJz?=
 =?utf-8?B?dDhLNXl6OWpYWk1BR1lqQTgrdTdTbHlJdXZOdzE4OENtSkNLb053U0VydGJu?=
 =?utf-8?B?dFd4dmpxOWIvY2QwVkNMVjVMQ3V0cUZCQjJnanZlbm16UHJaT0JPbjJQTC9L?=
 =?utf-8?B?cW1FTGlBZFJFMFp3SjM4ekxFdjJaOFo3QXljTUQ2NXNRVVJSL0ZOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d43ef8-2a84-4c5d-7b7c-08df13e5ad9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:28:49.4648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBFRGMWtP5PN/KPx1VGzy4vqZPmXdw3ZZH1fRJmFWvN5I5YY5w9ksdFXAoA/edZq+GhuEW8MGp9nemb9KE6vnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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



On 9/16/2026 3:14 PM, Thomas Hellström wrote:
> On Tue, 2026-09-15 at 17:48 +0200, Christian König wrote:
>> The blunt reality is that I don't have time to look into patches or
>> bugs
>> any more as it would be necessary. The same counts for Ray.
>>
>> Natalie has been working on the dmem cgroup patches for TTM and
>> agreed
>> to take over looking more into TTM.
>>
>> Arun is working in my team and already maintaining AMDs VRAM backend
>> for
>> TTM and the underlying buddy allocator.
>>
>> Add Thomas as reviewer as well, better to have more eyes on that
>> component.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5b5a4e4b35cf..b6e58a138501 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
>>   F:	include/drm/drm_privacy_screen*
>>   
>>   DRM TTM SUBSYSTEM
>> -M:	Christian Koenig <christian.koenig@amd.com>
>> -M:	Huang Rui <ray.huang@amd.com>
>> +M:	Natalie Vock <nat@pixelcluster.dev>
>> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
>>   R:	Matthew Auld <matthew.auld@intel.com>
>>   R:	Matthew Brost <matthew.brost@intel.com>
>> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>   L:	dri-devel@lists.freedesktop.org
>>   S:	Maintained
>>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> Acked-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
> @Natalie, @Arun Do you have a presence on dri-devel IRC? If so, Nicks?
>
> Also what is your stance on merging pages to TTM?
> 1) Requiring an explicit maintainer ack, or
> 2) an R-B from one of the reviewers/maintainers and no concerns raised
> within reasonable time?
> 3) drm-misc as default merge repo?
Hi Thomas,

I am not currently on dri-devel IRC, but I will set up an OFTC account 
and follow up with my nick shortly.

Regarding the merge process, my preference would also be option 2, i.e. 
a Reviewed-by from one of the reviewers/maintainers with no concerns 
raised within a reasonable timeframe.
For larger or more significant changes, I think a closer maintainer 
review before merging would be good.
I will also try my best to review patches on time so this rarely happens.

Using drm-misc as the default merge repository sounds good to me as well.

Thanks,
Arun.
>
> Thanks,
> Thomas

