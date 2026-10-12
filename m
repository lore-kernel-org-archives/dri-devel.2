Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A278CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FE410F266;
	Mon, 12 Oct 2026 17:48:12 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A90F10F266
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6ubZ3eg3dYWEKZ4nmu8J1aYakgHQUTBIAN2xp+QYUgJVc/fM8i/bNXZzxO4PZzgX99ObufwZUvqZ77Kg9MC9S5268/L5ZoF09SaVDfRKx91xwAchhoW8gEY7pqroHTNayOPxv8Qwk/bdee/HAZ50O2Hd4uHy3pJznVruBNU+W4av3Kek8vHQYuBO6ZAzdDT3W98kPqMJ3eWqajYDo6qF2DS4HkkT3xESMEWyuIFEQe4Pq8gT7Oy0qcqW9G8sk0TWbDryH6a/jLdF33tC4cLjPlpxkeZHgegf7hDfNj31PUxJf+D2klyctIc1wCojRCwSHebFB2lmIyRfur0Qk+J5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUFW3W42+cJngosDuqrX18JKcNe2oC6c3dCujeLONtg=;
 b=ipa5lNBqQQivfzzwWZn05HQEUliE76veoQpUuBKRbJEDOQUINAPVkfq0jehQ8Ye8DZLQfXlSsvFGEQYhAkrRaXHIssKVoGYROOGENuU3ishLrwvCDV0niCcnxnxys+NL7d0kObE9wC0tvAmf1GpGkiqCEF7b7Iar2P+xOOuPCXWa5s9MMhOogNhcLmFYGUfcWx4HF7WVIUk6bKpjuVIT1nYYkxWdWLAOPoiJGf6hanjy8KfB7qb8FTUjYFcfDlZIfmIXvOK0ThPyEKnATvdwLHtnRcsFBC9z76Dj2jJ+uCctyURnOIl+yRM9IjOaMNsS0fJ9VIsdTEc5zFfCO0evUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUFW3W42+cJngosDuqrX18JKcNe2oC6c3dCujeLONtg=;
 b=s9chMa9oEZTPQVvjd7FOdWrQCFAppkVU1d7qbKssWJn/5qZMPgsgwq40GbAcQWl22GBzgyqzknsTkQar5JbsNieMLx3NnY447eLO7zeOs2iF0obJ539HhkYdm8Zymi1ofylR0eJo+pRDwooYkunBnSrxDDSEKUfGBQHsiumtloY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 17:48:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 17:48:04 +0000
Message-ID: <072d1780-1f69-40fe-8a6e-a588a7967a99@amd.com>
Date: Mon, 12 Oct 2026 19:48:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dma-buf: Annul dmabuf->file on file release
To: Matt Evans <matt@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev
References: <20261009123601.94079-1-matt@ozlabs.org>
 <20261009123601.94079-3-matt@ozlabs.org> <sashiko-outbox-165603@kernel.org>
 <749905e4-52ea-490b-98c7-3923655a52ba@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <749905e4-52ea-490b-98c7-3923655a52ba@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: d27fa8d0-3982-4271-3c1a-08df2888f740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|261009223027099003|10067099003|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: hDXUW8y2m6SDJpd+yKsNQ6FePf8vi9jAmJIiXZ/LzDGhnKslbX5cAocjP+dq9Yk8ZRyQVN+R/AleB3aLW4tjclIjjHDOPGj61cU/yOC4I4ojJgJcP0Qg3elqtL04R5fcVTA+rlJkZ+JX1iZvoFZ9NDyB/As+V5kcxsOSGAbhjGyu6m0MNcGzOyL73RJK3URsKl7V0nOygMxiHVVDsNSc/hgkAWJkjmikMEfZHZzEolypRrnkJfI+lwocTdY+5icQMmvqFncQGkG1zpARB46an0Sn337fUaJyX/39mcigAv8F5OFUqxHS4qf6p/Ji+ur9BYFE6q6Kk9Lrqf9F0X8N7Gda4Eoraa8AdRUuVTKz7VfR2yevYXYST5GfRx8EohVBcoCxzmcV04phZnDiZHVskx/F8WjoIBCPTohONLiA0CyqQK97YgVdrSNeUgUbuC5+3lDLgTPLqOaL3iRC+Yt2lbwrXqLbninPxvnNMCYmujwAlVcLdZXRIv+UaNtlS7XGscxaISophpoieXOfVuqNWMgYkhwLAH8Kg453x6a/bu2zDZ2LPPNziIP/xbjV9C3AHxeSdfTTUb/1tzuzJWBp6pqCigRLa727FRP2KRodfha1gHMj/plMFTa++EEsoeoLN3uVPmmKoJ0oGDQuwWLZxTUW4ovgU0plO+lSMWNa4CQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(261009223027099003)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpydGdXNjVGN3FJc3FOS2J1cmhPNUxHeG9rU3JRazkxeFlLNmdHZWMzRERy?=
 =?utf-8?B?bzg3TFNUMEV2MzMvbXFoZzV5TS9xaExsem1kRFlpTmtaVDZQOThaMllLSElX?=
 =?utf-8?B?a0hnSWlZV1lXK0c4a1l1N3dzTlZXVHdGMkJMV3IvSkJQSkRrSDBXL3N6QTBy?=
 =?utf-8?B?aWlJMU9Kb1FlMmJ2R1daMHBUU2ZIMGFxbmRFdHBTNG4rbFo3OEtLcyt2Skpj?=
 =?utf-8?B?VThQWmdwYzlVWlRJNW5FY1l3S0s5ZnIrWFB2cXplaWljb0E4MXlJdVE2MEZT?=
 =?utf-8?B?U3hHZlVmYVdQQWFVcnVFbDdjZFpMbDB1Zk5OeW04Zkd0c0dodk1zRFZkMFBY?=
 =?utf-8?B?MjBJbU8rQ3lkaTJVaVk5alFKR21OekhUYS9uNnphUEc4YnN6dmp5Ky9IVlJI?=
 =?utf-8?B?djI2ZnZ0S29tVU4yNDJGRG9PblVPMktlRHlCOFFhbFFKWGZManBZV0lDenV0?=
 =?utf-8?B?QXc4ZTdtSlk5ZVFCbTloVWxlbm1sUWJWMVUraWtkakhpVVhHMzFKTndQTUxU?=
 =?utf-8?B?TXFlMmV2N0cySytXZmt6VmRQbHFCeXZxQk1IV2tidXRjSVpkOFlhWVo4dE9t?=
 =?utf-8?B?WFdTUnhzaHg4azZnVnJYZC9IY2RwdmlaQ0ZyNjBSMlBFdjR4WUdWQnlxeUpI?=
 =?utf-8?B?UU9CM2YrTER5SVR0ZE0rV0IvZGMyUkU5dzJvdUpHcHN2TXVNVmlzWDZsTExK?=
 =?utf-8?B?YTdTanpJY1p1cEc4Z29ZdHArSk0wUmw4QzRFZzJwckMrZTJINm93Y1RLMTJx?=
 =?utf-8?B?bTRFN08xaVZkeGJyN284bHJheXI5ZjZKUlNVWDRjSm9BZDQzRDV5S290TDZu?=
 =?utf-8?B?ZXdCaS9yUHNrSmxPMGw3cEcxSTNsRlQrbFVXOGh2dVV5UEJnOVlKMEp2eTBP?=
 =?utf-8?B?ZVJUSWEwTzNRNmlNeUp5TXhmbEhlRzhmTU9SVFNlYTVuSVFwVjBKNkxBKzJT?=
 =?utf-8?B?ckZOT05tbkYwTWpsN1hFcEY1Qm5ZZWdITWk3Y0Vrb2EwVllWTEdKQjFHTURr?=
 =?utf-8?B?UlZiejZucVBnTm5hVVFGazRhMUNwUENHMGROWUxSSEVaRE5FNEV4ckJvaEtD?=
 =?utf-8?B?SzhPR2NaVkQ2QVZ1RDk5L2VNN3doZEgwTnJ0T2pMdEQ1SWd1WTdFcVBpd1ow?=
 =?utf-8?B?TFlwWTJPdjNwV1lSeVF0UTlSQmRVZTZTN1I4Nld6VHU2c3NraG5uMGpvMmN4?=
 =?utf-8?B?K2dMM2trZkkvYWpsZnFSZVQxNy9tc0JhMWFCZitrOGxNMlZyZXprbFlJSERZ?=
 =?utf-8?B?RUlXM0ZnRVJRUTVoYzNCejRydWFLMStsenRsT09yL3VCTmN5RVVMOWhTcEJH?=
 =?utf-8?B?UUk2VGhKbEhVN2EzWE84NFVFUGJ0bXMrVFRTVWd0bEZmOHcvejBaeUxGOUl0?=
 =?utf-8?B?YnZjdlM2MTB3UloyMzNuR1QwaFMzVGw2Uk00TndmZEduNms3OUdPTEpmcWtS?=
 =?utf-8?B?VHFLS3UrYzJvNXJCVUgxb256TXR2VC81MnFRb3c3NWh0TGNaY1RIMkFkZTlG?=
 =?utf-8?B?NzJTQnVGUnUvMTNhSG5tUlBheGkzZ202Y0dGc3FHNXI1eWkwSVVJd0V2allZ?=
 =?utf-8?B?QVdYbE10MkdzT3QrRWRiajR0ZE1LK2dFQ2sycFNwSHBVeG4vYzdGQnoyUmtt?=
 =?utf-8?B?OS93VzZ3SXY2R0tUQlpsR3p5TEsrZTVjQkdkdER0VGhwVGYyaElSTWRSckM3?=
 =?utf-8?B?U2J5WHV3RW8rUlFMYnBhMlh2ZldNbUtYQ09EVTZCUm1aWXg3MHE3Z1Z2dlg0?=
 =?utf-8?B?RGMvYUowNG9URmRFSGxEcm43aEx0cmJYMUFucXB4VkZhOTBMNWVqVjRNWnox?=
 =?utf-8?B?RVpwOGM1c1dHb2RLWHE4eUFXR2J1cXEzd2lCdnF0Ti81NUtKSG1QcGphQllM?=
 =?utf-8?B?bldjUWRhK3U0RC9aZkUwcStuajB6cDFMejBtRk1ScnRobGlkVlhSSVJHQ0Vy?=
 =?utf-8?B?VTRXYjhLRS9hYTFCTWFuKzdvSllPamdqYUNnbXlHWUo4ZXVaUGRtUmlaRjhy?=
 =?utf-8?B?V3NJUVk3dkVTNDJoWm9ST3NHSDZWbzJ5TmJ4UVRlSG1LN2ZVdmJKeTVhTTYr?=
 =?utf-8?B?Yk5ucE84VnR0aDJ5N1dwMzF2R2ZxUU5RdytOM0R5ZkE3ZGVqNzBzZ0RtcG1Q?=
 =?utf-8?B?QkVIdkVxNFRyejFmV09iYVFwNFpLWitSd0NLdkFDYXEreXdEcFViYTRYMkRM?=
 =?utf-8?B?RE9vdFljL3JQS2Y3T0dsbCtBSFJueUlWMTNkczJYRTNtMVRZcGU2VmMrT2s1?=
 =?utf-8?B?RmpaTGVtMVIvRXIzS3BpQ3BPaHdzOGZJWDlHV2RrOXY5blVtNGdnaXZEOTRN?=
 =?utf-8?Q?IR4VF0Fb0mU5N+jqXP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27fa8d0-3982-4271-3c1a-08df2888f740
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:48:04.0586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: janVpDq9CZ/97JVSIdw3lcH2axSDQ9LiKmBRpsb3v8cOAFZjFK4sT/LlSvK8v3OU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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

On 10/12/26 17:27, Matt Evans wrote:
> Hi Christian, Alex,
> 
> I'd be very grateful for your help on this:
> 
> On 09/10/2026 14:11, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] dma-buf: NULL pointer dereference of dmabuf->file in exporter drivers
>> -- 
>>
>> commit b5be810d5fa3244638a9bad8503cacb8ca86027e
>> Author: Matt Evans <matt@ozlabs.org>
>>
>> dma-buf: Annul dmabuf->file on file release
>>
>> This patch sets dmabuf->file to NULL in dma_buf_file_release() to prevent a
>> use-after-free window if the dentry outlives the file. By clearing the
>> pointer, exporters using get_file_active() can safely observe that the file
>> is closed.
>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index 36cdc342627ee..d0f8b766e8fd1 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
>>>     static int dma_buf_file_release(struct inode *inode, struct file *file)
>>>   {
>>> -    if (!is_dma_buf_file(file))
>>> -        return -EINVAL;
>>> +    struct dma_buf *dmabuf = file->private_data;
>>> +
>>> +    if (!dmabuf)
>>> +        return 0;
>>>   -    __dma_buf_list_del(file->private_data);
>>> +    __dma_buf_list_del(dmabuf);
>>>   +    /*
>>> +     * As the file is being closed, dmabuf->file is no longer
>>> +     * valid and NULL replaces an otherwise stale pointer.  If a
>>> +     * reference to the file isn't already held, the file can be
>>> +     * closed at any time, including before dmabuf->ops->release()
>>> +     * happens: dmabuf->file _must not_ be accessed directly.  An
>>> +     * exporter should use get_file_active(&dmabuf->file) which
>>> +     * atomically tests and acquires a reference to the file (or
>>> +     * returns NULL if the file has closed).  The barrier ensures
>>> +     * get_file_active() observes the store before file_free()
>>> +     * frees the memory.
>>> +     */
>>> +    smp_store_mb(dmabuf->file, NULL);
>>
>> [Severity: High]
>> Does setting dmabuf->file to NULL here cause a NULL pointer dereference in
>> exporter drivers that still hold a reference to the dma_buf?
>>
>> For example, if a GEM object is exported to a DMA-BUF and the file descriptor
>> is closed, the dma_buf is kept alive by the GEM object. If a user then reads
>> the debugfs file, amdgpu_bo_print_info() in
>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c dereferences dmabuf->file:
>>
>>         seq_printf(m, " imported from ino:%llu", file_inode(dma_buf->file)->i_ino);
>>     else if (dma_buf)
>>         seq_printf(m, " exported as ino:%llu", file_inode(dma_buf->file)->i_ino);
>>
>> Similarly, during cleanup, amdgpu_ualink_cleanup_imp_xa_node() in
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c attempts to read the file count:
>>
>>     dev_dbg(adev->dev,
>>         "IMP-CLEANUP: dmabuf free for NPA:%llx handle:%llx:%llx, fc:%lu\n",
>>         imp_xa_node->npa_addr, imp_xa_node->handle.handle_hi,
>>         imp_xa_node->handle.handle_lo,
>>         file_count(imp_xa_node->dmabuf->file));
>>
>> Could these routines trigger a kernel panic when dmabuf->file is NULL?
> 
> I am out on a limb here, being the first time I've read this driver. :-I  It _looks_ like there's a live dmabuf->file because a get_dma_buf()-style reference is held here (so a false positive from Sashiko).  But I'm quite uncertain.
> 
> Christian, that you hadn't already mentioned this hints to me that this is safe, is that fair?

The Sashiko comment is nonsense. Each GEM object which has a DMA-buf (either through import or export) holds a reference to the DMA-buf file.

The only case where it is temporarily not holding the reference is during the destruction dance, e.g. handle ref goes to zero, DMA-buf is released and freed, GEM object is released and freed.

Additional to that this is for debugfs which is meant to be used for debugging only and is not really stable. We literally have tons of debugfs files which do very questionable things with locks and/or RCU and sometimes just returns random data because the object in question is about to be destroyed.

A NULL pointer deref is a bit more problematic. But in general most people don't care much, it's debugfs.

Regards,
Christian.

> 
> 
> Thanks,
> 
> 
> Matt

