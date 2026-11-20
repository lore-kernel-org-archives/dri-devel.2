Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484A606A6BE
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MG1kJM/Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071E1112D6D;
	Fri, 20 Nov 2026 23:31:24 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F212110E031;
 Fri, 20 Nov 2026 23:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6jCyJEPSDr3zLj8spy7TkSLR2W1yQs/O7UGeirJVVGVXHzioIm4/X+bbUhgtS7F1r7Fwy/U84q7OMT9U10xZGMYRTx7Luh6Tkib6jI/yikcOZSoNXBcwPrm9U02ARpSiHEeLUruLx9txV0yV4G0WdDarjLZzAvxT2k3SxgSjWs3hHhFHnJZ8hi+xxX8FZ+cOSa8E+vxYVqiYdT5ixHz2Po7YrohZ4QBDTaZO8HH1mMBZIirHHYu9zXzTvdG8bW9khI2SJPEBGM3IWIFeggrer5J52zwOqzvBKi4bAM6PNdc5C71cWSmTVFeZFTBi+4oop4jOs/CpKl+6nDATIGNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhrxakkc/QvxVGl/ledVdA29GHCur2NBysSgYypvnk=;
 b=kUs1ELkisro2pT0RjxfS7gfM1sFTpit1hX/xFXZqoYkfXpQ7b281s1H/X+W9XVqUo+41BeUEHxgvn6XsUqsORKwIge0pkJ7dVRvt63hWYP+gaxgMYDL6ZpRgPnxaFaxb5wcU3777mm9mC3xJcsSzK25XCBrAckcV0aa0WxovBGx1qrPV45v2qqTvZTpu/A106mk7fd7Sl3RS9MvQmyj0jMiiwTXTLUJf0Ic855yTqOALEGQVQFlIjXDFWrbBrQUdTJ0ldlrEgnyPcnjzBKtqabnmCx4NOYWQLqFciqUmdEz6F1dwItLbAo1r3gS8PBDM2lUYLEioiLBIeOFZV/SGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhrxakkc/QvxVGl/ledVdA29GHCur2NBysSgYypvnk=;
 b=MG1kJM/YYKB/QZymzkqskJZ/J09tdEBOHUlCrZTgjo2UkVXnUgE0r9JSCOsela9lXmhgUeMEo8GgJ+q2yBaIStbHnkOLbj3pjbKzh9OQaattRMfuLjwGF04nTxXWEZvHQluRsHBrri4aKoKMLXJKjPIutUydMyKc7uSid7hFHKo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 23:31:14 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 23:31:13 +0000
Message-ID: <61bec126-d855-4b14-a8bf-80cfdcea66fd@amd.com>
Date: Fri, 20 Nov 2026 18:31:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
To: Honglei Huang <honghuan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-3-ray.huang@amd.com>
 <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
 <101922f3-d918-4429-a7c8-c96f72474993@amd.com>
 <1bf6fd84-9ea5-49fd-b906-7b2c9692c018@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <1bf6fd84-9ea5-49fd-b906-7b2c9692c018@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::18) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3e7ff3-87ee-4b0d-bc11-08df475e5da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|4143699003|261009223027099003|261021121427099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kfTQ5RlMKXt0/0Kb69MQoo1dSE5wxv12Umz27xSY5zoLnxZiu7tgOWJiozn/XK6Sz0rrv5z6unOJBwQuxr4FBVYgUkvXcdnxOnt/lwHJBHy4/r/uQp/JktnMz8vN2PlPY/BY5f2Fop0X/nNxbmInlS+0b4LB5a108rvgzoiS9ROaUbnHENa9JOY3Qx/VpeRW+c2dmGB2cbP8WusSXqZI/bduWYFdsejj7CTWKdq3lbcIWuJ0wY50I5wtphkUZJzFqcMxxFjB4xA7wOXmV7BhIsk4tnwm25H/xxjcmSQ0tVnBFuxqtzdER1IvjvjaEAJeYf28I3uKYV6mKZVYFTEvIokNGmn8Dk1UA5q7WbZmEPHlnuw/0PEsX7Olu+B6TF/kzAIr+F/6oJSVSlKx6cADkn387k73bC52yWXKVsBV+F7hVAtB598NEGRKrKJT3EjgXLW0xaRm6B9biUxSCDguDSVWdjbf+f+RqProLWAXMGD89JEeR53MOS4VMinQjaxNTsVBiFkh20Ht5KVd28+6QOAtHSGmiv9glW/cwBRHsPMgbFKvUbHDKAqkxCVLRq8zr1hmwCMfbBQ+nxFTIXcVbyi+D+5qyOCj9rk3m67oqBKvjB92QpOXQjDvubJNXm0XcS6j+5ZhaEfLGbdi/qTseMBrehaCkmEiSgOKE1yZCU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTdGaCt2UHUxWk85dW84ejBUQTE0Y2tDWklPeER3ekp4OFhoeUwzOTFnSnEr?=
 =?utf-8?B?YjRZZWNlYXFlNWU5cnRwb29ocFJ0OXJFZDVpWnBNcllPQmRSNDc5SlFaWE90?=
 =?utf-8?B?UXEzZ1NWaFVwY09GL2c2b0JYdDJ6aHBnK0Z4cnJTZ2d0RHBCYnRrUTAwZHJ6?=
 =?utf-8?B?N3dJRlNLZ3V3M2dScGZpenUyQm93UnFtcTlRMk9PcjFEeTd6eEhsek96Q3kx?=
 =?utf-8?B?eHQ5TTZqQmk3eHBGb0RQSnVOZXNFR1hOdERrV3RWVkNQZTUzM3RxNElLWUZZ?=
 =?utf-8?B?K0lUazZOcnZyYkUyd1N5ckVNMzBDTkFOREtIaE5VQkIza1NEWFNFeU5KQk5P?=
 =?utf-8?B?bVZKZzV5U1RlVDNpd1loNEZLQ1QrTk1BaE9KZzZPM1k3NGhJRGVJOVhldTUv?=
 =?utf-8?B?aE5NUitrcWRaK3gxbXQ0TmJnRi9oTERRbzVFdjl5OS80UDJhUUNOYXkxWXkz?=
 =?utf-8?B?REVFWlg3OHpGeFFZemhxdmUvbVZGekhySlFFUWVnMExEcGNZVm5mTEJQTHVC?=
 =?utf-8?B?T0h5Z0lHdVNmNG9oWEh6dmNXMDZLUldjTFBraVN2L3IyQktPUUNIVmQ3MGVr?=
 =?utf-8?B?U3lNQUhvNjVPN0tCSDdwbXdCM0UrSURnc2dNWHhhL01xeDBPb0ZnMEdUZXVH?=
 =?utf-8?B?dUVEcVc1YXR6alB5QkZCL1RaYmJOMXVGR241dGQvY09pbmE5ZmEvVlpPQlBh?=
 =?utf-8?B?MjFHOXZPUEhYNDZpT3NBdDd5QnFZZEtoNG1QdGVCbjFTMUdiNW1WUTB6U1Ir?=
 =?utf-8?B?QTdQREJ4SCsvVkNNTmh4KzlocHNyWUR3bmlJV0dneFhOc09LY2I4amp3a0cr?=
 =?utf-8?B?QWR6STJUQnVodGQ5QXhWMllQTW4vN2pVV0MvTlNuNGFxdmM1dHVuODB4U0oz?=
 =?utf-8?B?dTVBTDdWQ2Zoekcvb295R3ZWYjA4OEc4MTRrMFNXUGdpdGhsUnVyd2VNaG81?=
 =?utf-8?B?dXF6QkdxT2ZmbiszRzM0WXZmSlNlZ0wvaTBhQU51Y3Z6STBROGxMSFE4Q1pq?=
 =?utf-8?B?akE0Y3NsM1pVYlR1bjNIZjdPOE9WRnZ0TzVONmUxT0FBNWVuUW1YTEZHRTFR?=
 =?utf-8?B?YjZDenlxZ1ErRmFFK0dvN01PbU4wclYrK2FxOVhlQkZmbEZlNTg5S3V6MElY?=
 =?utf-8?B?ajRHN3dranEvdGlPbElITHlKQTc1TEl2ZXJPTFJYZUpJN3htRDRiMFF5aFla?=
 =?utf-8?B?OVBaMnNadHRQOTZhTVM4RG1CancveEdwM1ZpUDRqbUYvZGJRam04OVBKT3Vk?=
 =?utf-8?B?aVpEZEVRbURKWUd0WlVyQ3ExUjJ0VVZVbkl3MEphTkpVdHk4OHN6Q1BWWGlH?=
 =?utf-8?B?QWFsTnJpTXJMUkVQR2ZWM1A0VVMreWJVQTZObUR4VG5rcFhNaVNEMnV1ZDFP?=
 =?utf-8?B?TXZiR2MrL2JTR2xrVmR1bUg1MVVpZFZGcFRxT241RlF5Qmo0dGp5TlNzSzF3?=
 =?utf-8?B?c1JtakhaazlKNHlkMGhCM0RpbnFiOUlMN0c3azZzcEJidGRMVkR5d00xT3dh?=
 =?utf-8?B?YitNeEtnUENocnRIVWZxaDI3M1F4UmdqcmFhSksxSndKcllLR3NRdnhxVWFw?=
 =?utf-8?B?eFhDY2NqUkE5K1RFTThyek1QWDREWldUZzFLeWRaY2hmbG1hVUp3aUJDdGhl?=
 =?utf-8?B?RkxoVDN5REJCUitRUWJpYjhMVFJ0c05OVFJDYkJCNUs0clA1NS9GWVoycm5n?=
 =?utf-8?B?QVE4ckd0R2UyZXJlUi9uUEtRVndzTnFNcFRjUElleVA2WWNNMEpIeG5iNnI5?=
 =?utf-8?B?L3VzMXY0QkJyZGpLbHQvWEU1TlYva3p3ZXRoRm1vY2ppZzdObC9VK21oWDhm?=
 =?utf-8?B?RzlIdzFpZXdQNElJWDhLWnRMVDdjMmVsdzljSWJqaG45TlJoM0hJSVFzSUY1?=
 =?utf-8?B?Tko0b240RlJ2a3Y3WFI1M2U1cDI4ZFpITnJ4VjI1VnhESjdSRmRWVlg5b0pO?=
 =?utf-8?B?WS9vR2RYRFhmQkdIRHg0QTVrRzFUZ2oyVmliZWlZdnJER0lwWTI4WHdDQmhR?=
 =?utf-8?B?WUZxTTc3MVBUcUNJeGw5c29XYWZBZjBtT05vR0tnM25adnlrVmg3aWt1N1Jv?=
 =?utf-8?B?cjZONVQzOXFSdjdHaUpBVFc1SGNwNS8rN1FlbHorTjZ6b2VhcGthTHlkMm4y?=
 =?utf-8?B?dklQbXVYTjZSWEE5ekxmYUxzVitObzBXMkN6NUVuTGJONFd2OFovL0g4MFRs?=
 =?utf-8?B?Wk0rUFMrVm52d3ZmOE5VVVU0N2RaUThDUGZlQzUwMm1VTlcyNmhCRUp1MlJP?=
 =?utf-8?B?TDJlZHVmNkZBNGhqUGFGd3pUdUk1OVo2dlYyTzdnNFhRU1IvaVFSeCt4WGhB?=
 =?utf-8?B?eEJZclQ3QVlpQW0ybnI3NE5Uazl5UGhKLzF4U0dROFMyMExzM05jZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3e7ff3-87ee-4b0d-bc11-08df475e5da8
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 23:31:13.5584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRaZhHJIsWk+/C1C4DxAXyf3ck84060Vsu8WZhgTAyvnglt+nFGaIh6zBPm68NX8o8+8q33Xzz8NiB1okKy9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-16 00:18, Honglei Huang wrote:
> On 11/10/2026 10:46 PM, Kuehling, Felix wrote:
>
> ...
>
> >>> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop
> >>> stale
> >>> + *                 faults.
> >>> + * @default_granularity: Default range granularity.
> >>> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
> >>> + * @invalidate_ranges: Callback of the MMU notifier invalidate 
> event.
> >>> + */
> >>> +struct amdgpu_svm {
> >>> +    struct drm_gpusvm gpusvm;
> >>> +    struct kref refcount;
> >>> +    struct amdgpu_device *adev;
> >>> +    struct amdgpu_vm *vm;
> >>> +    struct amdgpu_svm_attr_tree *attr_tree;
> >>> +    struct rw_semaphore svm_lock;
> >>> +    spinlock_t work_lock;
> >>> +    struct amdgpu_svm_gc gc;
> >>> +    atomic_t exiting;
> >>> +    uint64_t checkpoint_ts;
> >> By now we have figured out that TS in faults are not useable for fault
> >> handling.
> >>
> >> Background is that they reset from time to time because of GFXOFF and
> >> may vary depending on the engine who sends the fault.
> >>
> >> Adding Timur from Valve on CC, he send out a patch to completely
> >> remove the existing timestamp handling from the fault filter.
> >>
> >> We need to come up with a different approach here.
> >
> > At least for the fault filter that shouldn't be a big problem. We don't
> > need the SW fault filter on any GPU that has a CAM. That should be any
> > GPU that supports retry faults starting with Vega20. AFAIK the only 
> GPUs
> > that still need the SW fault filter are Vega10 and Raven. If the
> > timestamps work on those, we're fine. If there are any newer GPUs left
> > that don't enable the CAM for whatever reason, let's fix that instead.
> >
> > Regards,
> >    Felix
>
> Hi Christian and Felix,
>
> I totally remoed the ts check in amdgpu drm svm fault, following is 
> diff, is that looks valid for you?
>
> diff:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
> index d95ac3651..15d8da7ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
> @@ -31,7 +31,6 @@
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_gmc.h"
> -#include "amdgpu_ih.h"
>  #include "amdgpu_trace.h"
>
>  #include <drm/drm_exec.h>
> @@ -358,18 +357,16 @@ static int fault_map_range(struct amdgpu_svm *svm,
>   * @adev: The amdgpu device.
>   * @pasid: PASID of the faulting context.
>   * @fault_page: Faulting page index.
> - * @ts: IH ring timestamp of the fault.
>   * @write_fault: True if the fault was caused by a write.
>   *
>   * Entry point from the VM fault path. Look up the SVM context, drop the
> - * fault if the context is gone/exiting or the mm is dying, filter stale
> - * retry faults using the checkpoint timestamp, then resolve the 
> covering
> + * fault if the context is gone/exiting or the mm is dying, then 
> resolve the covering
>   * attribute range (creating a default one if needed) and map it.
>   *
>   * Return: 0 on success or a dropped fault, negative error code on 
> failure.
>   */
>  int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> -                uint64_t fault_page, uint64_t ts,
> +                uint64_t fault_page,
>                  bool write_fault)
>  {
>      struct amdgpu_svm *svm;
> @@ -378,7 +375,6 @@ int amdgpu_svm_handle_fault(struct amdgpu_device 
> *adev, uint32_t pasid,
>      unsigned long attr_start_page, attr_last_page;
>      uint64_t fault_addr = fault_page << PAGE_SHIFT;
>      struct mm_struct *mm = NULL;
> -    uint64_t ckpt;
>      int ret;
>
>      if (amdgpu_in_reset(adev))
> @@ -414,21 +410,6 @@ int amdgpu_svm_handle_fault(struct amdgpu_device 
> *adev, uint32_t pasid,
>          goto out_put;
>      }
>
> -    ckpt = READ_ONCE(svm->checkpoint_ts);
> -    if (ckpt != 0) {
> -        if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
> -            pr_debug(
> -                "draining stale retry fault, drop fault 0x%llx 
> ts=%llu checkpoint=%llu\n",
> -                fault_addr, ts, ckpt);
> -            amdgpu_gmc_filter_faults_remove(
> -                adev, fault_page, pasid);
> -            ret = 0;
> -            goto out_put;
> -        } else {
> -            WRITE_ONCE(svm->checkpoint_ts, 0);
> -        }
> -    }

You can't just remove this. The reason this is here is to drain stale 
page faults for ranges that were unmapped. If you remove this, those 
stale faults will cause correct applications to crash.

You'll need to replace this with some other method. E.g. a sequence 
number that doesn't wrap when he IH ring wraps around.

Regards,
   Felix


> -
>      amdgpu_svm_lock(svm);
>
>      mutex_lock(&svm->attr_tree->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
> index c169a9660..15c3915bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
> @@ -33,7 +33,7 @@ struct amdgpu_svm_attr_range;
>  struct amdgpu_svm_attrs;
>
>  int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> -                uint64_t fault_page, uint64_t ts,
> +                uint64_t fault_page,
>                  bool write_fault);
>
>  #endif /* __AMDGPU_SVM_FAULT_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> index 627b61c7e..f552725f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> @@ -758,39 +758,6 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm 
> *svm,
>          drm_gpusvm_range_put(&range->base);
>  }
>
> -/**
> - * amdgpu_svm_capture_checkpoint_ts() - Record the IH ring write 
> pointer time
> - * @svm: The SVM context.
> - *
> - * Capture the timestamp of the most recent interrupt handler write 
> pointer
> - * into @svm->checkpoint_ts. Retry faults whose timestamp predates this
> - * checkpoint are stale and are dropped by the fault handler.
> - */
> -void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
> -{
> -    struct amdgpu_device *adev = svm->adev;
> -    struct amdgpu_ih_ring *ih;
> -    uint32_t checkpoint_wptr;
> -
> -    if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
> -        ih = &adev->irq.ih1;
> -        checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -        if (ih->rptr != checkpoint_wptr) {
> -            WRITE_ONCE(svm->checkpoint_ts,
> -                   amdgpu_ih_decode_iv_ts(adev, ih,
> -                              checkpoint_wptr, -1));
> -            return;
> -        }
> -    }
> -
> -    ih = &adev->irq.ih_soft;
> -    checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -    if (ih->rptr != checkpoint_wptr)
> -        WRITE_ONCE(svm->checkpoint_ts,
> -               amdgpu_ih_decode_iv_ts(adev, ih,
> -                          checkpoint_wptr, -1));
> -}
> -
>  /**
>   * amdgpu_svm_range_invalidate() - MMU notifier invalidate_ranges 
> callback
>   * @svm: The SVM context.
> @@ -802,8 +769,7 @@ void amdgpu_svm_capture_checkpoint_ts(struct 
> amdgpu_svm *svm)
>   *
>   * Dispatch the two phase notifier handling across every range in
>   * [@adj_start, @adj_end): run the begin phase for all ranges, then
> - * the end phase. On an unmap event, also capture a checkpoint timestamp
> - * so stale retry faults can be filtered.
> + * the end phase.
>   */
>  void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
>                   struct drm_gpusvm_notifier *notifier,
> @@ -814,9 +780,6 @@ void amdgpu_svm_range_invalidate(struct amdgpu_svm 
> *svm,
>      struct drm_gpusvm_range *r;
>      bool needs_flush = false;
>
> -    if (mmu_range->event == MMU_NOTIFY_UNMAP)
> -        amdgpu_svm_capture_checkpoint_ts(svm);
> -
>      r = first;
>      drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
>          needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
>
> Regards,
> Honglei
>
> >
> >
> >>
> >>> +    u8 default_granularity;
> >>> +    bool xnack_enabled;
> >> It's probably ok to have that here for now, but that will become a VM
> >> property in the future I think.
> >>
> >>> +    void (*invalidate_ranges)(struct amdgpu_svm *svm,
> >>> +                  struct drm_gpusvm_notifier *notifier,
> >>> +                  const struct mmu_notifier_range *mmu_range,
> >>> +                  struct drm_gpusvm_range *first,
> >>> +                  uint64_t adj_start, uint64_t adj_end);
> >> That looks a bit questionable. Why is that a pointer inside the
> >> amdgpu_svm structure?
> >>
> >> Apart from those questions that looks rather reasonable.
> >>
> >> Regards,
> >> Christian.
> ...
