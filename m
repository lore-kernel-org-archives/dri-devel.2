Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFAECD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE8E10F20D;
	Thu, 30 Apr 2026 06:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5NOMZEqY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDBA10E038;
 Thu, 30 Apr 2026 06:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1iD0khUHbSGi6dxpzuMyy4knFuAW7WY+z3kH+MgoHqJYqN1DgC1v4odi+wnBj1nCR/79oTYw/JqtmboTYoVpfF3UYMCCumnU5PR+ea2DfdvVzI5t6ENH5d4W0o6tTtXTeG/iccAbnsVwPzntAqX/rdwONNP0rBMUwloOytXjfnS4Mg+wMPAHMUA/EGRvwRshm/IOME+1UhYN/4Vzs06gSWdGKBYUMLDfsn6VkDQeIS9ZtmOhHyk4DXt1E2XXdPLAdP6BqJjVIKzbhlG4CpK8ELDYnPc00T5AzNwoK6uObY1hfz3vRf/vnaJooC5/3L5F7wqa6h53fG1gUVkADvUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bXCh3INlQtSlxSvpoWsIPLy8HGUkq5twM/iqzuKPvM=;
 b=f6Y8WWb/av5si9f828WcQ2u1+4YpPxiqU7TSZCF9rDvrWR8vAMVnWMrRS0l4sttD6o7wlFsWT/5uwY72IaDnbmuU/HsN+kIZRvgVu397Oeg3s/VXJGa5ZzLGf096rgWqIptwvyILnZyuxOEzXFKskHUgrS2mHuOcA8T7d65jVEEelLKQcSHuPLHhZQion6Q9draMh3aC49dT2yvbDxCZE4c/lq92Y5iUO/SBfMZQ08rol/HW3CDMYwZFu/ODlWNI24pBxa8Oo7SPFZcm+/Uf3Gadq+hDiJxNT9g8SHMjUkVPH0gbANpohNd1EgY4g9Cik0vFh4RcQ7r16UECSP3Inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bXCh3INlQtSlxSvpoWsIPLy8HGUkq5twM/iqzuKPvM=;
 b=5NOMZEqYv/KH/6DZQW7hbVN4ZOhJJvd4u9vg2n3iwn8HmDia0ZraYexLNRnKjE+C+f2VfUQw1Y4j/9Mat7DqZGIJUzOOGdSp3ptX4q8LLSDwUknOlwIlmgrLhyqLDtCKX0ewbMbSGP2/w8IKBkKASbTavZrtx94QrtZey/2Xs2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:22:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 06:22:01 +0000
Message-ID: <dda47c3b-1303-4f10-b375-1f3eab032ee5@amd.com>
Date: Thu, 30 Apr 2026 08:21:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260429173646.7653-1-ulissespaixao@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260429173646.7653-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 381da84c-16d2-4273-1c87-08dea680ca38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: AKAv1H2tVOY4WYiVbI2hr7N4VnwHWW+9gupR3ZJXVxzawVMZlFInRjhOZUex8/1r8l/IKKvtDSSUPUR/76JC5mlNzun2OrIlJNVedRZ0jk1F53z14xuTZpiQd9xiSBfKliIhdwmYg7TWdqqg7V1hXJdLBuaqnHcMYNWW99fdTNT8LEGYC67JjPLzaDnBDBou7MJTemzHAtOnIUcfVXsBAgsXjtbpcF59Z2J7WK6sis0L+TVAkz2HTd1FdqF6f1nAnDJiZYXEcxnEWmakMzemUuqOcyNA6wW2QUZ2jijL+DdTh8rjUEv2WliUnEgL/AzKZGJCa9/IP78n8WBtZsni328WyROufDDhnFlPWH6a7vbd9FaEg+zw25mXzMiQKi8lSuIcR7vJrU2qjpsC90hU6AEzeeaguUF1aqgwcawgT/xzovmGyAR4MiyJa/Yl+tRRd2LwBnOPN56UBtPdg1zjHpHqpWQAEhEq3alA95J04pvSwsESXjgEDKSN+px/wAKiY+68el1DRz/MUWxt/RcgOzm7JSebAvNTTF4GMk39LuqyMfE8rBKYoceRY25u1up8syP32zoTpcCdZCRDk8U83UzqBn0/uc+gZFeYDFJfU75C3g/avH5n/I48nCb5P5JePeCVIJYw07Iv81E8W8nspMGj4t0u7Vw9Z4sMtvYrcxNEPA0hCRVeqMrri4iJmy7/pd9p5K5JuFRimesoc750bYxY6GlWkizjh8dilDMe+U4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVuRDFKQWtTa2pPVjRsY05Qc24vZzZ2VlBNZWc3K0prVDJ1RW5WaE0rN0lZ?=
 =?utf-8?B?cFp0U1lPTnVUZHV4SzEvSllRZTM4WnI0T0l6Vkxuc0xXS25iVlJ1N21oSHZG?=
 =?utf-8?B?ZW9iWWxEMGw4SWdmME5PZU82dDJLUnJtT1JkVE56dFdpNFlGblVXV1luY0RQ?=
 =?utf-8?B?d0xlM1UzSGUrU0RkSUtXT1BsZ3JBYjlDYUM0K3V3RytEbUFCNStjVFgzeVhP?=
 =?utf-8?B?TUxCTFErckZZYjdrR0xSWVE1a2ptTk1EQnRrZldMMDFIYTdzUHg1dzVSVmNW?=
 =?utf-8?B?Mm5EZC82RlhkYmYvODFjOVNhbTZobnMwdkpFVHBnbGNTZXBpeG9ia0p4QkZ3?=
 =?utf-8?B?WjJDOENKRnFRV3Rkd3JoZVhnWkx5dUZBL1Q1UjJWTUl2MDlJdU90bE1JRXhj?=
 =?utf-8?B?NlM5bEc4UHdEWHdTWVQ0Z1BUR21DSUg2MHpzaVRqR21PZTcrVkZ0MTZUNUMz?=
 =?utf-8?B?Mi9QUUxzZVc2UGdHbVFjUUY2WGV4bzUvbExPejEvMnJPZnpwYm5jbVZ5MzNB?=
 =?utf-8?B?N2RQUmJiNVpFNHF1VnRQczFlM05WSHpKK1diV2dybHJGN0pib29QNCszbE1i?=
 =?utf-8?B?MHowcHJxL3NJZWNLYWVRVVhMRlZtdTBHNGRoek5JVWtySXdwSndZQUhRZHZU?=
 =?utf-8?B?MnVNaTh2Z29PMTA4UVhnbjFoNzVRMG5wV2NRV3hiR0d5UzljQVkvc1JGTkZi?=
 =?utf-8?B?UVdFQXBZZDE3TlNTTnVMck1TNEw3SFl5NlVLNy96aXFaYkVPZGJsMWlhajlj?=
 =?utf-8?B?bThBeW0xaFpMaEJFLzRGUXFOSC9XRDZ4NzJ2YmNoQkN4MWVseTBhbSt3eHpV?=
 =?utf-8?B?RE45dmQ2amVhZWg0RVN6dk1tRHJ5SGNOVCtEYmFEaUxxREhWN0VPa21KeHZm?=
 =?utf-8?B?dmdOaS9JSVo4QlMyaEV2VTJERXd2VzkwcFN5c2JQdS9rT3RIOHBuSUNqTXFX?=
 =?utf-8?B?bW03OVJuSTBvaXd0RXprcTVpVmRObW1CcVZNZzZ2L3hNbkQ5VTJpOFdCblRq?=
 =?utf-8?B?aDVBTWlKMFo4eWUwMTF5bEZqYzdVbWQzb2Nva2VDZm51VGxqTVRnQ1RtUFln?=
 =?utf-8?B?ZnBsNzJ1czFRbVJiYmtOakQzZE04bTdrMkEyRkR6ZUdQZ0wwcDFzYXNOMWpG?=
 =?utf-8?B?aEZVQVVPRE1pMVV0ZUVMMm8wYVp4VlJmbjNKNHdzOFk0NHQrY3hlcVZnTnMr?=
 =?utf-8?B?ODJXUUZ5ZWNHUFV4M2JhYXlXRmVkSTEwbjhiZ0kvM0ZGQkhEV0RYS1JscW1q?=
 =?utf-8?B?MlVrenlMQTgwbkZHQlIvUDV0S1E5V1NrSHpQc0w4WDc0dnkxbkFycW9TdGN4?=
 =?utf-8?B?bHRwVkdYV2ppMnAwOGZVNndLQTR0c1RnQWNqWGJ3U3ZkRnlnaGtuZWNneW13?=
 =?utf-8?B?M3JtbUtkOG84bm9maWI5Tjh5ZU9saVUvaGhlNWVkUVdBalZzb0ltYUk0YTN3?=
 =?utf-8?B?WHl2QmJweG5WdXE3TE1yTU1OeXFZcDhvWlZlbGVJWEpmMnBaM1oyck4xRHhm?=
 =?utf-8?B?dEF4OWNJQ3V2SWVBQzRxZS9odi9UQUNvS1M1aVZ5ZmJWekZmYWpKOUxWbmlz?=
 =?utf-8?B?b2ZNQllMbktkRTE0YVlVUkx3RnlWVHhWeHJERTBVeEdRWVZzTHZEVVRQb0FH?=
 =?utf-8?B?L3dPOE5DeFJCUGd6QUtNS3JIZGJuK1doNWhLazNsejU5ZHBjMld1eFFQei9P?=
 =?utf-8?B?N21rcXordDVrRVE1K3E2dytnbDJvZGNOSnU1bDJMRTVQdE90aWxIREoyeFB3?=
 =?utf-8?B?QlEzaVFtemFUNmlFekl3NlNxNlh4NGppb2FvUFZ5OW82VHRBRHRobWJ3QkNW?=
 =?utf-8?B?SU5HSE55VUtzbDBqREkxM0xncnlxYjZ1VVVTU3MycEJBay9TS3FNS3hGZm5q?=
 =?utf-8?B?RHJZMmYwUHFydHU1Zk1ibmVRRS90cktDN3owSHRjOUN0UVJhbk1Fc0hKUHhV?=
 =?utf-8?B?NEt3OXJRSGpnaTVhcFV4NmpUZk1WMnFDenNNeUlGWG1uSzBVVE5tTjdVZGdO?=
 =?utf-8?B?NkxMNWpPRVd2QXJaL0d3cER0ZHRLSVBZTGdESldUUUl0ZnpidDByV0h3NVFz?=
 =?utf-8?B?LzZTNUtibUJSKzFaZWNqRXRmT2hmdnBwUlFUSVg2aExma2ZXd0pRVk04c1N4?=
 =?utf-8?B?NzNmd2FRUFVxWlhDa1N1dTEweTJnQVNRVUk0dkJUNkpBTW1yYUZXbE5IS1pw?=
 =?utf-8?B?K3krUXdvUzFKOElDcDFGWlNlem4xREd6YnBFV2ZqY1Fkei9wMUNNR2tocUFw?=
 =?utf-8?B?ZDJTdUtTSzV4WHBpTE96ZnZMVE1sZlBxc2lIQStwRGFzRDBEY2p1cmpGNmpP?=
 =?utf-8?Q?oZPCuoKivxK5elq554?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381da84c-16d2-4273-1c87-08dea680ca38
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:22:01.3657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JqBuM6F1M2w1VujrzK9U69TWDVZli3OPGNKguAmflW0tZQgYCPAh7PwK7WnM/1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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



On 4/29/26 19:36, Ulisses Paixao wrote:
> [Sie erhalten nicht häufig E-Mails von ulissespaixao@usp.br. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> The functions gfx_v11_0_handle_priv_fault and gfx_v12_0_handle_priv_fault
> are identical. This patch replaces them with a single implementation in
> amdgpu_gfx, called amdgpu_gfx_handle_priv_fault, to reduce code
> duplication.
> 
> Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
> Co-developed-by: Felipe Sousa <felipesousa@usp.br>
> Signed-off-by: Felipe Sousa <felipesousa@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 46 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 43 ++---------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 43 ++---------------------
>  4 files changed, 54 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca87669..c8d769cb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -830,6 +830,52 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>         return r;
>  }
> 
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @entry: interrupt vector entry from the hardware
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault.
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       struct amdgpu_iv_entry *entry)
> +{
> +       u8 me_id, pipe_id, queue_id;
> +       struct amdgpu_ring *ring;
> +       int i;
> +
> +       me_id = (entry->ring_id & 0x0c) >> 2;
> +       pipe_id = (entry->ring_id & 0x03) >> 0;
> +       queue_id = (entry->ring_id & 0x70) >> 4;

Even when they are identical on gfx11 and gfx12 this decoding here is HW specific and doesn't belong here.

> +
> +       if (!adev->gfx.disable_kq) {

That check can probably be removed. Both num_gfx_rings and num_compute_rings should be zero in that case.

> +               switch (me_id) {
> +               case 0:
> +                       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +                               ring = &adev->gfx.gfx_ring[i];
> +                               if (ring->me == me_id && ring->pipe == pipe_id &&
> +                                   ring->queue == queue_id)
> +                                       drm_sched_fault(&ring->sched);
> +                       }
> +                       break;
> +               case 1:
> +               case 2:
> +                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +                               ring = &adev->gfx.compute_ring[i];
> +                               if (ring->me == me_id && ring->pipe == pipe_id &&
> +                                   ring->queue == queue_id)
> +                                       drm_sched_fault(&ring->sched);
> +                       }
> +                       break;
> +               default:
> +                       BUG();
> +                       break;
> +               }
> +       }

This part can be moved into amdgpu_gfx. But I would remove the switch (me_id) part and just go over all gfx and compute rings to search for the matching me and pipe.

Regards,
Christian.

> +}
> +
>  static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
>                                    bool no_delay)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..5655af43d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
>                                                 struct amdgpu_ring *ring);
>  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>                                     int pipe, int queue);
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       struct amdgpu_iv_entry *entry);
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>  void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
>  int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 2c6f1e25c..da869f928 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6684,49 +6684,12 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>         return 0;
>  }
> 
> -static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
> -                                       struct amdgpu_iv_entry *entry)
> -{
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> -
> -       me_id = (entry->ring_id & 0x0c) >> 2;
> -       pipe_id = (entry->ring_id & 0x03) >> 0;
> -       queue_id = (entry->ring_id & 0x70) >> 4;
> -
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
> -}
> -
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
>                                   struct amdgpu_irq_src *source,
>                                   struct amdgpu_iv_entry *entry)
>  {
>         DRM_ERROR("Illegal register access in command stream\n");
> -       gfx_v11_0_handle_priv_fault(adev, entry);
> +       amdgpu_gfx_handle_priv_fault(adev, entry);
>         return 0;
>  }
> 
> @@ -6735,7 +6698,7 @@ static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
>                                 struct amdgpu_iv_entry *entry)
>  {
>         DRM_ERROR("Illegal opcode in command stream\n");
> -       gfx_v11_0_handle_priv_fault(adev, entry);
> +       amdgpu_gfx_handle_priv_fault(adev, entry);
>         return 0;
>  }
> 
> @@ -6744,7 +6707,7 @@ static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
>                                    struct amdgpu_iv_entry *entry)
>  {
>         DRM_ERROR("Illegal instruction in command stream\n");
> -       gfx_v11_0_handle_priv_fault(adev, entry);
> +       amdgpu_gfx_handle_priv_fault(adev, entry);
>         return 0;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 6baac533a..883878e23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5015,49 +5015,12 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>         return 0;
>  }
> 
> -static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
> -                                       struct amdgpu_iv_entry *entry)
> -{
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> -
> -       me_id = (entry->ring_id & 0x0c) >> 2;
> -       pipe_id = (entry->ring_id & 0x03) >> 0;
> -       queue_id = (entry->ring_id & 0x70) >> 4;
> -
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
> -}
> -
>  static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
>                                   struct amdgpu_irq_src *source,
>                                   struct amdgpu_iv_entry *entry)
>  {
>         DRM_ERROR("Illegal register access in command stream\n");
> -       gfx_v12_0_handle_priv_fault(adev, entry);
> +       amdgpu_gfx_handle_priv_fault(adev, entry);
>         return 0;
>  }
> 
> @@ -5066,7 +5029,7 @@ static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
>                                 struct amdgpu_iv_entry *entry)
>  {
>         DRM_ERROR("Illegal opcode in command stream\n");
> -       gfx_v12_0_handle_priv_fault(adev, entry);
> +       amdgpu_gfx_handle_priv_fault(adev, entry);
>         return 0;
>  }
> 
> @@ -5075,7 +5038,7 @@ static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
>                                    struct amdgpu_iv_entry *entry)
>  {
>         DRM_ERROR("Illegal instruction in command stream\n");
> -       gfx_v12_0_handle_priv_fault(adev, entry);
> +       amdgpu_gfx_handle_priv_fault(adev, entry);
>         return 0;
>  }
> 
> --
> 2.34.1
> 

