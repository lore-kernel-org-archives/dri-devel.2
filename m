Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB74EC79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB40F10E253;
	Thu, 10 Sep 2026 07:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LloP5C3C";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B55510E253
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utppVEkJS+uid+vUi9TOqPOLWXs2xCRn5/AvOzMoN20TRJT6Ey4UQCaXqUZn8Z31bumxqtlWfNEJyGz9hfri7Y++WLSoxknPF85aLCLc5r0OG3qwhowx+bU9W3Jvufi/JLru9eO5vx7wLHiukA/lhVH+XaKjxP0Z0x5I8YlMKX+tVUYRjfMAGla7dMU6AoT4TkMQUYvPltBuAtMJK31s/UR2TpC/QLtkmKzOfxcNbJ7lacjySYEdpYi35IcrN+4SlYh/ohuzclQa/7wr2sE3lRQcJWnqB51azPZplO3K8fG4hf3sS3HRb+RUmM6Uop2Z5gXEx4GF5307FRXEXmcy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWVE04E06qCRLyHJ4eh85dsFfj1fbJBHPfFB9QFCink=;
 b=qSDzTOWmGFqQfvq1Mq07RAiZrCMbnuVGqCM82RZs1IMFOfLeSw80VX9g7nXR4nMJz5vyhuVGrqhcc+AN1oLwQ3XRZLP0NXioTfVr5OkIZ8h5Szh1yviFmGSdraAcpK5u1i5ckjiNUFKReO0pnXutWEhEGVh0IZMitWmDlZT9oW/JtxMeMxPDsCwqlnwyt1z0d5YEqnzS2MOBB13j2eIrBOnHekX6oEDXR3Ll2uaV3Z4Vd87c0HQMVFuSUncCywS7Q6TXK/QyMFcMyZJHOazllewdYU6p7CrIbhWwWOKh8UjOBxjte+dRo8Pjv3MAewi+YboXjqfbgG1h1NkY/+5MQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWVE04E06qCRLyHJ4eh85dsFfj1fbJBHPfFB9QFCink=;
 b=LloP5C3CalOQb4vKsUwWpIvrOQjF1eFrbrBpxAo7w62NqC0IIbwHq2G/XCMDJug4vcebvfoxyF2dKpoIOSJ2+83A5uxfHEZN1z1yS+43WdaFZDvUAWJnXj6pjEaaoyjIASGJU+H7L/W6XrZ3woz2NybwVO4TW8V/M3TF/9IPztU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:32:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 07:32:09 +0000
Message-ID: <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
Date: Thu, 10 Sep 2026 09:32:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
To: phasta@kernel.org, Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec744b9-155d-4039-29f2-08df0f0d9f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EruHSVDxgeiOgMwDJQK1prxDuRCwzzEfCbrNmkuQU0v4R6uuMuPqe3lAXJeu5emosIHAphaUR1iXE6B9Z+vU5OQrWCsTzCP6ECu548eIVJgRZ5PGixzgHPDDRi9qni0fUe42msUCOGbJO3pvrJH0QUDVd/NKF7EJIIFRhDGH/J+jBTeK4KCBIhkrupY2WCzWdaCQAcZGd79u/3gzvlVCUo1ZoyxxiPL9UGah3FH4s1szZaVM7S/lJBV62IbPiV5pDOnUoBhQrVVrkXk3h6Cs19Ew1/eVb0eVK2x0at/k4tUo8TYEO4115Z30HnwC+5vGJI2dTDfAfw2Tc5MuTaXFLX6So3o9cZ11RSLZ1MUzY4sZWArzVN55t8wqN/0TznkFYpvcpZR8ba2WU4701I/g3k0VY6Kx4H7V9C+jp2GFiTv3ZeKozBHa+EjgBR4drjF9VDyogIMGi9JAx4JzVn7kXHkecinNJNt4ro35WAPj1XxBQB/6Z4bX5NTXEKVc2q9cjx6kA+DlvPjESaWPd7QtU9urHuSL6J+MndCqBZzBgwO6a2o8KetwYkFIsG4gmouHqyWZTGVXeLmtaTd9Wcyh7PfrKcGNvncoiTrnGGf0H10outmyYUUW40U5JUU4i11aT9zxA37l0jSpPvFOHE0b3sRmWaQB2cGv/9PDLltMyh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVg3SDFQcllsM2FTK2xaYUw0aVpBM1ZQUnc5SzhTVVl1VDZRckhPOEJwVkZO?=
 =?utf-8?B?RnAxeVl6S3ZSVVRHdlFuSlliRnZqcEZYOW01Rzhob21oTU9PZlpuMHRKdGN0?=
 =?utf-8?B?eUg5MXZOZFZHZStnN1BFT0Z3YW4zK0hlRlk0bm9vWjJTVUpmbEdxQkQ4TDR0?=
 =?utf-8?B?OXU2YUZqTHZCazBOc1loS1JZN3RwOUcwam9wcklhSXh1ODEyVHhreWUxNWtQ?=
 =?utf-8?B?eUg4YWJUeXRTaFlFaVBYTGdycjZCWlQ4WElYMHBtaFcwNUVRcnlIY0RyN3d0?=
 =?utf-8?B?RGZPeS9reFRxajJjYjRxMWx4NTlpekx3d244cXhQMUxDUmZXa1MwMFdVVmUv?=
 =?utf-8?B?Sll2Tkp5QXdPcklTY2hRQWhuL0dXYW15SDR6UkFTWEtRVysvaldSRGNuSTJr?=
 =?utf-8?B?bVErcmZDd3B4QVlpdXQ4ZDhXakwwVElKelhnaTZZcUppZmFPZUdUSjlDdEI1?=
 =?utf-8?B?cVZFZEhCSGN6R2JVVGtubzljN3UvVFFQMXduZW4vZHJsTXNqYWF4MU5zZ2ty?=
 =?utf-8?B?Mno3cno2eTU4TENRemt6L3gxeStwbXhzVDJWWGFKdGdYVU9KWnp4NG85TlB5?=
 =?utf-8?B?NE1UenlkQWhQY0JHNlBGZkJGVEluYlF3dlF6dVpoTXZFcFJvZXRnSE5pNHE4?=
 =?utf-8?B?NjBCQk5jSmhnajBBNitoMnM1bUpTV1JEQ0hrZmdDVXNJOE05VmdUWC8reWFG?=
 =?utf-8?B?aSsvWFRydjEza2V2ckpZUy9wNFZ1MjV6cGZHZXc2QzFEMG1rRTA2T3RXOE1C?=
 =?utf-8?B?R3FmZFFzSGpETjFqVGpyL0p1ZmJGc1VhczM5azhqMTNmTzhKSGM4ZmdvYjRU?=
 =?utf-8?B?QzVPY0VHWm5ibHhlY250anFXcldLL3hQS05yTVZtdUpNSExDTEhiQ1Q3ck5j?=
 =?utf-8?B?K0pGcXhvZHlNUDVBSmt5NnlBc0VBUG43ay9BR3laS29pSktNSjYxVGUzYkh6?=
 =?utf-8?B?SUtiM0Q2WXRSM2RTL0lYUTE5R1NsTzc5VlFMdldpK2VGVjJKd2pPL1RpZzFE?=
 =?utf-8?B?bEd0RWpkVFU3SDJqbnp2RCtnSnNXOUhtWlNvUXFPSHVBQVdsVWFXUEVBejBq?=
 =?utf-8?B?VUhvOVF1VytoeFZSbGdITHEvUlREUVZQazBCcjNwTExiNlYrMHR5OGt4Umgz?=
 =?utf-8?B?bHRlTHpqRFBaQmNzaFJ4d3BKNVU5SFg4TDIxNllyU253azBvMFlGYjc5QzJ3?=
 =?utf-8?B?a2lQbTRBQXE2TDdrRVJsWVl2ZnQ1U3ZnbHljRWVrbWJMMlNCejJHOEZmK3hq?=
 =?utf-8?B?TC9DOEZkbjFlRVZXdUJFRVc5c1NiL0QxNitTamY4Uk44Y0pycXBJL21CQkgw?=
 =?utf-8?B?NlhZcnFyMndOVHNKWEI0d2tDUCtXWFBNWUFITUZFTFhGZU1wVmJPYUM4Qzlv?=
 =?utf-8?B?WXBJM2xNQ2J6KzBuSFZ6dk9iWERyZzQwZmtmRzdyYUk0RExudEZLblQrUE1R?=
 =?utf-8?B?UUZTL0dXNi82QjVEU2x6eTV1VjZXaGxYUkVrL05ybDhhbGlvZEZpWjVRWXdz?=
 =?utf-8?B?KzVpMEttUENTNTErWW1peTVBRjd1RmdtSWhzWCsxemZ2cjVLTE9NSXFhbnB1?=
 =?utf-8?B?RkJPdm1CV1UvOXA1VXl0dmtDMXBDUXZQVWc2VFFiYXNDZHU3bURBWXVwZ3E2?=
 =?utf-8?B?QnVHQms3NC9icHJLZm1ITWFTUnRBd09iSS8rUzdtd0Nzbk13T3luRXVsVm5R?=
 =?utf-8?B?SVp0NmN1N1FtdC80MlpSUFVVY2tYTVdzaHdHWUM1WkpkQXRHSnRqc284WFll?=
 =?utf-8?B?WTlDTWVGV09SVUxqY21RdW5CNGtKOXJFU1IxRVJaYTk2K1hNMW9HVlRNMFA4?=
 =?utf-8?B?L1dUZXJhY0ZUT29JNVJhZFRsOUxibnYyZTRBdC9PM2duZzhUWkg0b0NNbHdx?=
 =?utf-8?B?Rkowa2lFUU9pRjBRbEZSOTNLeWNNWVFLUkJRbkVWN2JSM0xMQS9qZ2YxY2Y1?=
 =?utf-8?B?dk1OS09lY2tEbkdzd2FuRmszRlp1eWZ1TTUrYXJUVXRYSlZxeGZ0d0VOT1ZL?=
 =?utf-8?B?K0JpS3pKNkQzRjlDekRpK056K3ZlSVBpOXBxRTV0b0lSWU1HcmNFMmIydzl2?=
 =?utf-8?B?ZHBucnVuVStMQ2NuSkNDWWZXTzVTdEJRTXcxOTdWOXh0UEtLYmtIbUtCWGR6?=
 =?utf-8?B?cjh6TXZXZFdZRXg2anFweS9wckZEUU1lQUhmbi9mSzcwbHNXRDdTZUdCc05l?=
 =?utf-8?B?SFJjMXJ0OTN1U2Y0ckV6LzBUb1JIT1puR1YzY0t1eFRLNWw0V3NsZVZGT3ZI?=
 =?utf-8?B?OVAvUEVaSXUrYmgxdmJUYnIyVS9DWTB1dHFRcUlGQUY2U3BVK3NIZXhHWUFF?=
 =?utf-8?Q?TkGCxXAzSFw04Z3kQl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec744b9-155d-4039-29f2-08df0f0d9f6e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:32:09.6242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV9wU/UUeze7/+A6UAkLsRbabYLQNtITmK9qcFfsg/CN6pr/y9pscGSf2sVxGJ3t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

Hi,

On 9/10/26 08:52, Philipp Stanner wrote:
> +Cc Tvrtko
> 
> On Thu, 2026-09-10 at 14:46 +0900, Donggeun Yoo wrote:
>> Hi Philipp,
> 
> Hello,
> 
>>
>> drm_sched_fini() frees the run queues above the two steps that wait for
>> users of them:

No it doesn't. You quoted the wrong code, this is what really matters:

        drm_sched_wqueue_stop(sched);

        for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
                kfree(sched->sched_rq[i]);

>>
>>  for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
>>  kfree(sched->sched_rq[i]);
>>

>>  /* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
>>  wake_up_all(&sched->job_scheduled);

That was an extremely ugly hack applied long long time ago because amdgpu was broken at that time and didn't waited for drm_sched_entity_flush()/drm_sched_entity_fini() before calling drm_sched_fini().

>>
>> A KUnit case that keeps the TDR inside timedout_job() while drm_sched_fini()
>> runs, with the callback calling drm_sched_increase_karma() as amdgpu does:

Amdgpu shouldn't do that any more.

It is perfectly possible that we still have a bug in the driver teardown during hot remove, but we certainly shouldn't work around that by adding such hacks to the scheduler.

> 
> How precisely are you reproducing the problem? I'm wondering why it
> wasn't observed sooner.
> 
> Since you mention amdgpu, many of the twirks in the drm_sched code base
> were added to work around ordering problems in that driver.
> 
> The drm_sched life time rules are:
> 
>    1. All fences returned through ops->run_job() must be signaled by
>       the driver before calling drm_sched_fini().
>    2. Entities must be torn down before the scheduler.
> 
> IOW, I would dare to say that the wake_up_all() maybe shouldn't even
> exist in an ideal world, because the driver would never call
> drm_sched_fini() while it's still blocking in drm_sched_entity_flush().
> Maybe Christian has some wisdom on the background.

Yes, exactly that. This line should potentially just be removed.

Regards,
Christian.

> 
>>
>>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2b/0x40
>>   Workqueue: events drm_sched_job_timedout
>>    drm_sched_increase_karma+0x138/0x3e0
>>    fini_uaf_timedout_job+0x4c/0x140
>>    drm_sched_job_timedout+0x1b4/0x620
>>   allocated by drm_sched_init+0x49c, freed by drm_sched_fini+0xec
>>
>> Moving the loop down beside kfree(sched->sched_rq) silences it, and nothing
>> between the two positions reads the run queues. Is that the right fix, or is
>> the intended rule that the TDR can never still be running at that point?
> 
> Can you post a patch or RFC patch for fixing it? It's easier to discuss
> then. I think I get what you mean, and it's probably the best cost-
> benefit-ratio fix. I'd then just put some brain power into
> understanding the ordering between threads though
> 
> 
> 
> Regards
> P.

