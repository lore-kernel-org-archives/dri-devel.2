Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC2CFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C8C10E154;
	Tue,  5 May 2026 07:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LeAUcFWR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC7910E150;
 Tue,  5 May 2026 07:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6AcFTgoR7WHwDpTGmTgZIYk0NURlijet9orubHUAwT5Jz4c+nxf5jLiVg7ZVtv2Y4jJZ43Lks6LFySYr3K0CSJ+MAB/bHa0g47icYgN1tKPBfzzNGmHwOBDl/da31v75dIlBUs7uzVZJtL4VcpZ+9GnFN07zQlDd0NSHVjjGOZFh/JsgVEvheu5Qe8wLri+4w9T9Xg7/kusprpE07S4EArb+fHRsoJOm7KIU3ai21iqjs1HJPsraCh4Vq8aPic6PouaRSg6pYU0D17al8owTj1DO2F6GLG8wbXoK551vxbrInw5ucat8zHQh2ZeG2jpO+RcUo2F9tUUUBFOvnRhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpblTVw1gVyfwtb+90Dl2jo8u2z2G/Hf2CLutB5AO/4=;
 b=baBzICxG2UoyaeAskwWGjIRbRyrZZWJPwIMN90i5m4x+/52jTVy5N165sA08jUzeu2rv7K3OOJFI+al399AULZoq4SZsPwcyiVooDW3n386EIfPA0XjWH3FGHDU8YgMxVzOgY2PBFDobpTUywhW/C2GJcl7EvKBr0U6iGAITFf+or/xbLsLh/WHJCbKp3OEDtHd8IG7GkaXWZaSYxkUEuohvVsoxj35bQ7KKkfo2uS/w0B576hdLtUqldTQp1PBVtY6WQv4La08L+Cz5ko/MOtEXt3ffRTyyQe2du6x5P/fyISnfUiLVRnbcH8oYJS7iAM2BscDnr8bLQbz4zrUkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpblTVw1gVyfwtb+90Dl2jo8u2z2G/Hf2CLutB5AO/4=;
 b=LeAUcFWR6b+icBcuZIbLnuZbYVXJkdcmTHfGwFf6R/VAyngLjB1EvxkXHmC9zgdM2RBBRx3xZIexI7IhxNGAb4iyDya/uBJ72PjNfeiIdlvBxCYGSaZICXuPTdxspXM6xkQPK5s+NQw+cXfq7Rj6nw5dWXoz/W7ZFgioopBN358=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:40:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:40:40 +0000
Message-ID: <fe76a5db-7d18-4f67-be38-723a5821a818@amd.com>
Date: Tue, 5 May 2026 13:10:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260505021417.32520-1-ulissespaixao@usp.br>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260505021417.32520-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5d1a83-dd75-4ad9-f17c-08deaa799b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: UavQIYMD+Y/XZjXUiXQ9d0jNyqBIrbpMMBPqpKRwlMAnRHx75o97kFBX9PsPd7PDSrbemhLBAHWoUy1CQjdu2Jw6S9qgwYL6oU7PbJeryiaF9qzjkOvIbEbrp2o5IUOtCDYtSxeV5ySmpGgJKmTI6yi3lB0/vCjKHdmohCnyvS2cyX/ec3cXGXrd/gZ2GGc6DkQ5KWn7g7n/vICJ1jbb01Nh1OYRz6cDMKhVbk4wEO/O4FBmCLBzMUCi5CQXD1zgsCs08p/WeduFRj+n93aiAFtcpmSOs/r7xmFIhtuTDRn/fNml24yPg81dmeV9wHmJuox7cMr6pXNVC0TXMlenAxj8L8ijv6w2NuMM/IYf+hceilCoHw5z8q/5BiOoW2i2YO9ra3vKIT/2ArPlZfqKEB6p8PyF8xWeaebVj6Fv1/jQyafwpyQbGwcpxdthtHBet6Z1jrNBSkCLlA0KeU6ZaCkiQq8eF4KpplX/6Xf7yk8u+I9A1xbEyMrV96UyYimjCxOfbeRborvAzGHQN/BsqFXc6OpeYjxNYEBB1YfHqhwRGryTp3DZxgluciJoyZZJLNbzq6HYCnGxQXIalkF4hYmHGcYDTbj3FA8RE3HQTQaUFyJ2SlNvlzxDm5kyoV8KBfgfB3YnsnjCrJU0COVBN5mXGKV0CdF/G1fdyzi5OtGYQN8/02PdKVmQHMqEehJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlWMTM2MjF4OEcvU2NDeFo2KzdtSnRoc25aRjFMTU5weGZjc2piVkk1RnNl?=
 =?utf-8?B?dXpVWDNxcGdTM1o4bG0rUElOVUlDOEYyWjBYOTlLYXpxOE13Q1VzSnVhQzlS?=
 =?utf-8?B?YmJYNGNYd3ZpRXIvWVBMWE5tb1FsSnNzVTE4MDJZNkljWVZtL1BMbEw5K05q?=
 =?utf-8?B?b2VDYWdobmlYcWw3eDYraTlCd1FnNEVlUXhHYndHU1VrKzA2RzEyYU1ZQnZ2?=
 =?utf-8?B?VVlSYXVCM2p1dC9iWUhvQmJNMnNjTHdURmY1RW9MR1d4a2Z4ZC84N2h5NTho?=
 =?utf-8?B?eUI4SjdCbHR6eGpHSDNHUThRcFdaN2ZEVXorRStvMm85YlozWGFIaGY0Y21F?=
 =?utf-8?B?TEg1cThqRXBtdXZIUFVqV0FEMWRIeEdvd3FVWlhONVdWTXJIdFJvdmhWTmVR?=
 =?utf-8?B?STJuSytrL05teXlXamlTR1NXb3RUY2d4ai9qdW9YbFhxcDJzc1laQXh3WTJn?=
 =?utf-8?B?VVFPZU9GS3czR0dNUVBIUmhVenVyS3g5THFjd3kxalJrTGUrSWUwckZpZm9v?=
 =?utf-8?B?YXRzTXdTVHhFNGNPckw5V1dOZ3NLU01sNUQydjFaQXk3NFVuZzdwT0ltbW5k?=
 =?utf-8?B?MjlDYm5Ec2VSUlhXMEl1MGxWNVRmM0wyZjQxNTYvRjJPL1B2K0RORk93eVl6?=
 =?utf-8?B?bEpPSlJaNnl1UW1IbkVTc0ZzcU10MnM3YjBIOENubHNwL0ZVZ3lWUmNMRmgy?=
 =?utf-8?B?QzdQL3BkNWlJMFYxeEtvTVhucDhyT0JabnBnYXdPalZJc1o2STBrWDZJSWM3?=
 =?utf-8?B?NGJFZXVjMzgrN08ybTNQWFE5aWlPbTdpOEtPVHZZRm01UndIRUFzUTVRTlgv?=
 =?utf-8?B?MmRFckhId2F5aXIrWFovMnRlS2ZrZ2h5M1ZhaThiZHovTzF0dkNReVlDcm84?=
 =?utf-8?B?bVJIVzRSc0tJdnV4T0QvcTRNZ3hsWGVoT05mTElwOE16S3QzSUxZVnBoclJW?=
 =?utf-8?B?M2FDMWM4VVo0ek1GNVIrOE9tNTJNR0lKakUveTEyM0JBZkZwbzRBVUhJYkha?=
 =?utf-8?B?RjZ2eVVTK2lCUWVjV2lsTVc2ZzdKK2JibDhKamlxZ2JXMzRDWTVHMGFKSDBI?=
 =?utf-8?B?c1BENzBzM2hURnhJYzdvenJ2N1RibGRvMXBsNHlqSzNsaWhHSXE0UFluYXYv?=
 =?utf-8?B?aTM4ZlR5Zk84UHhTcVdzYTlaWnRUcFNRWTBPeHpXVGtWREcxMTdmTzdnRytp?=
 =?utf-8?B?eFNVU0pYU21CS2I5R0tLZUNPQTU0Z0p2WTlJSUVXZ1BsRVdZaDZQTHJXdi9C?=
 =?utf-8?B?V3BCSEdVd0liTGtzYUpaUS9GTCtUMWFHR1JnbWE1YjF0dHUxZWxIY1ZNNTNx?=
 =?utf-8?B?aFRrSVRtVWZNMDZqcUMrQkhKTlRpTHQ1K21HVS9tWnBLKytyY2ZQN2YraW51?=
 =?utf-8?B?blI3UUZ1NkRnRW5pQVdkMTRpUEtVNmd4Wm1HYU95ZEZLTEhhQ014SmtyWlhQ?=
 =?utf-8?B?alpMS2xCSmo1aEZuL1AwSUJ3WlZPaXM0bEx5WVNScW5NRmtlc3Y4b0xJR2dk?=
 =?utf-8?B?NGVoOENrSVg5Q2Joc0VUdDVjdFlTOVhlbnFuTi95cFhQQk1GblE2TUYxNS9h?=
 =?utf-8?B?eEx3MGJzWmFmd3FtVzJPdk1ZUmUybHRkekc3STVHTFVibWp3eUl3VXNXVFRR?=
 =?utf-8?B?NXBJV1dkMVgvNmpkaGJMK0t2VXhKMHVBVXZYVjliVFpXQXVSTlZ3TzB3Z2lo?=
 =?utf-8?B?bDVFN2JjODQ4ZU9aZ1cxQmVyN2VNczAwdlA0MHRMTVhFVHAvKzEzMlNuN0FW?=
 =?utf-8?B?S2JtSlFmY1Awb2VXb3k3YWZmaEUrQmtmTHNTTnd6RjNHeHNFWDBNSWtaUms4?=
 =?utf-8?B?MWNzK2F2bjZWMEVSN0NOaDNOc3Q1ZTNDbnkweld4Mk4xb2lWcFpSdnI3MlBp?=
 =?utf-8?B?akQ0dDZ1Q2NBVnZBcjZCeGNBOVE2UGpoZEY2djZyeEFiYWdxQVlUTHNkU1Ur?=
 =?utf-8?B?VmErTWRTcXpSU1VmbXdYN1N3K2c5R2tMMUVndjB5QVRBL2hMYkdzQkxsWEpM?=
 =?utf-8?B?amUxY1U4eUF4NXNPZVlzSHFhSGgvT2Nxb3E0alpJSEZTSndRbCtmTktaMGJt?=
 =?utf-8?B?U1hMZEd6WmVncHJlUE9XU0dHOEZZRWFBakxDRnU3QitIZFhsemNjRkF2VzZQ?=
 =?utf-8?B?RmYrODRHdmVkSUxpZ0Q5ckVjUEpIa2Z4aXhOSm5XL2xoVy9LQ1lTSGcyMkhZ?=
 =?utf-8?B?U2FCWE5RL1lxb0VjTGwyYUY4a1J6dlFPK0J6eHRBWWc4eTRnVW9lU3hFa1dE?=
 =?utf-8?B?aUJTYlhSK2RCb1FFZFRHMHF5ODh1MmNmSTlwYlFYczEzVUE1WlM3LzVFcXhT?=
 =?utf-8?B?ZDZZd0tacUJaOEE1VU5ibU95Tk5LcU5YUW5EZnQ2WU5MRnFpWWFndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5d1a83-dd75-4ad9-f17c-08deaa799b18
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:40:40.7576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2v9vs3VS8YySGtH4MvepjYagBNWluqAZWfEgGhNdgN/3AHQYxf1R/mDONcTPCWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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



On 05-May-26 7:44 AM, Ulisses Paixao wrote:
> [Some people who received this message don't often get email from ulissespaixao@usp.br. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The functions gfx_v11_0_handle_priv_fault and
> gfx_v12_0_handle_priv_fault share the same logic for searching and
> triggering a scheduler fault on a ring. This patch moves the shared
> ring-searching logic to a common function, amdgpu_gfx_handle_priv_fault,
> in amdgpu_gfx.c. The hardware-specific decoding of ring IDs remains in
> the version-specific files to maintain proper architectural separation.
> 
> Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
> Co-developed-by: Felipe Sousa <felipesousa@usp.br>
> Signed-off-by: Felipe Sousa <felipesousa@usp.br>
> 
> ---
> 
> v2:
> Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
> Remove the redundant check for adev->gfx.disable_kq.
> Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
> all gfx and compute rings without a switch statement.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 32 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +--------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +--------------------
>   4 files changed, 36 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca87669..67a291781 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -830,6 +830,38 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>          return r;
>   }
> 
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault.
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +       struct amdgpu_ring *ring;
> +       int i;
> +
> +       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +               ring = &adev->gfx.gfx_ring[i];
> +               if (ring->me == me_id && ring->pipe == pipe_id &&
> +                   ring->queue == queue_id)
> +                       drm_sched_fault(&ring->sched);

Could return from here, no need to search compute rings if found.

Thanks,
Lijo
> +       }
> +
> +       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +               ring = &adev->gfx.compute_ring[i];
> +               if (ring->me == me_id && ring->pipe == pipe_id &&
> +                   ring->queue == queue_id)
> +                       drm_sched_fault(&ring->sched);
> +       }
> +}
> +
>   static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
>                                     bool no_delay)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..0b2f6ce85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
>                                                  struct amdgpu_ring *ring);
>   bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>                                      int pipe, int queue);
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id);
>   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>   void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
>   int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 2c6f1e25c..888c9f3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                                          struct amdgpu_iv_entry *entry)
>   {
>          u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> 
>          me_id = (entry->ring_id & 0x0c) >> 2;
>          pipe_id = (entry->ring_id & 0x03) >> 0;
>          queue_id = (entry->ring_id & 0x70) >> 4;
> 
> -       if (!adev->gfx.disable_kq) {
> -               switch (me_id) {
> -               case 0:
> -                       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring = &adev->gfx.gfx_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -                               ring = &adev->gfx.compute_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>   }
> 
>   static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 6baac533a..3f0d29372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>                                          struct amdgpu_iv_entry *entry)
>   {
>          u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> 
>          me_id = (entry->ring_id & 0x0c) >> 2;
>          pipe_id = (entry->ring_id & 0x03) >> 0;
>          queue_id = (entry->ring_id & 0x70) >> 4;
> 
> -       if (!adev->gfx.disable_kq) {
> -               switch (me_id) {
> -               case 0:
> -                       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring = &adev->gfx.gfx_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -                               ring = &adev->gfx.compute_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>   }
> 
>   static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.34.1
> 

