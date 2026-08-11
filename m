Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E139C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8824F10EB36;
	Tue, 11 Aug 2026 11:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LccXCfw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EAF10E31A;
 Tue, 11 Aug 2026 11:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZgoJ8WEIc0lKFqLoc6wF0fI4q7jk7hunv6wS/v1Zcri8kR6gpcET0xZzQypRE0bQEMjYGWEYttO7Fd5/00ait8VsrDVJAZSNlWSgYtDG855Y+Zl6shyhnJlLYLe/mfq7UcZ4P5RjDm6lNzFh9Lqpa4kEGb//YOC4GpGkySAStQA06wMZ1dsw7HcaKZA2oO/iXVqczm0SSi4DqTHFyHD5eP+R9ZRys+FfTWhPhlC1netE745ANrMb4PY0hViMO3DeqM/5r92yIwt9xwuupKR+cmqJydlrkBPrEcHv1PyLSAeTdm+Plxf6kzqJ/KrCJY1AFgv7ZWQCK+PxtAA95Odaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XTMinJ6XvHNu7NUcNTrg9Zlx4c+ne4xm0r4dTwbuhE=;
 b=lTndN4que6dDhqhPIIUlCbQd0Q3dkKe5gTU42a+l8Omw4GUEBIo/QK9F/QZOw2vzGVoEi2YLf4AFige//rlxEMXhyXC6YlNMAtqJ8Qye6gF3j11cyKsxaP/nnpZCCUmcO0q2dBJXVBymh6iojkRwKfMmeOHKpW7YcHbydynv6BZjuBbzy2al39fMVAwhg+t+3z2QlbBtt7ptX5GjosENSVIBv8arGnbPy56ISrJjQ9VnBpMHYfylA0rfGkd2oFnjZs7eZvYMIw7RdqLunw/wqslBKbK409TxEykXXff1sz7ewliz8I1sGuTpAgcqOt8LmCuBb01IXe307zwTPsVZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XTMinJ6XvHNu7NUcNTrg9Zlx4c+ne4xm0r4dTwbuhE=;
 b=3LccXCfwEeK3MowU+xayCyQAvjjr0VmtH351Pkz2KDrjaJxn0LBgSLmgVe8uDJrVq7TOiLnA7UoHwwptWuVADga0LxVp0JFwMTqHX7uMOMAbQCmoCSZUKZU3WJHGGCjm5rk/XaFNeqaxSJB0cBV9zQb+wwNJ9Cunn2yLxuqlU4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:02:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:02:20 +0000
Message-ID: <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
Date: Tue, 11 Aug 2026 13:02:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260804094246.1719318-3-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:208:23e::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 3445e40a-11ca-4a71-cbb5-08def79803a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info: MawSBI30mAWzbPwxGJ3Dp0R0fnXfF/sQeoKSMXWGa+/CTikk625KniVnS1VAyeq9BugGR3/Q8S1ELwDovZtyBHgtdk/NG/sTENkn+5iwkedlTOWDjhb7ea5T/UdyecNgTarNkBHlHU8io1P7dgiDcIyQ3upk+y6OHZPKKJCQ2FGRx5ARzAS2ZgxWnzXeQHJepdzaYfBCXEjpLgfpNyIil/5hcPb3IIjpB55Lr7DemtDOsPVH7Pl1EYGcXVdV7BOKe/zUdt+bmAuPy1FKdLHv2VCw/OQHdYgmu6ytThsuWl+jqL6iOrOsczY40oGLPhnGgd28A51m0t7O4M/7lZAI6mhFXsLmkIn4ssFfjZ/Gm2RECmEmyCFtpHWxsik+SoPibIoLcIsoHbwHkKoeWZAJjJtvNmADqsj70jva2GRbhhnPS+h6K2BAuhCqxYw7xuC99O5lPU1WlyM/+mQGUFp2ieLItp5Usix0GIjKHBFgrgOU8hKKMmuMG34SNXGQ+OjexndCRjO3YAsdLF8zN3mQ7/BV1Kb+fRKyFBSq7gzoTpTYbdc1XyfnV20YA/1B2d3FRGoldjHxYC/l5NdwaGi2T9hHEUE1UKkIHM+OjZhPenB00ITvXy4TDSqSWkc0KH2Bz4qVw8F/4YQR6LZHsES3zi6pM3NFd0KbH+KMumxJCWA95mbNtZrh6VrefHcHl3p9cUDurYJp8Ygq+3EMdJ5ZDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(3023799007)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEIyMVhrQ291T0wvelRBcDd5S3prbjNCNHNrSlJnY2hWalhWM1NwMXIxT29L?=
 =?utf-8?B?eTZBMG5JN25mSTdTZHpHLzF4R2VwTS9EVldCL2pFd2ViaXVwN2gwOW4rcERQ?=
 =?utf-8?B?Q3ltbEhOMThaWGNsUWFZbjR6b05Pb0xXZ2NsYlVUbjlEVHRZYTBndGNtVy9m?=
 =?utf-8?B?bkhGbDhNM2h5RFIyUGN2NmVFUFJrdG5SYnplY0JxUG1iUHQzcUVucnQ0S0xn?=
 =?utf-8?B?dTZ2WWZ2OGpPWmxNWUhJWUNMQmU3bk40bkI4Z2hOTmdmenJER3FaYU1pVFZq?=
 =?utf-8?B?UUEyQ0dVeUJuWDJUQWxONWE2RlFaVDI0K0RFNVpHVnVjR3d3RDdoaFR6aU5E?=
 =?utf-8?B?TWN4RDBIODdlekl6TE4zaUtxZXhrb3NaNGp0MkcvR3Q0dUFJZ0NsMWtHeVdR?=
 =?utf-8?B?K3ZMUDRlMFVIOUx0NVZoNzJlS0NoSzMrQ3RSU0Q2b2h5Wm5NeVJyVlVkeUZK?=
 =?utf-8?B?K1Q5RFRFdHlkZzlpVUNwTTNXeDFNcWUzREgrTmgrUjVwRkdMYjZuNngrcWQr?=
 =?utf-8?B?QVR6WFdXSDZSOW10d2VYTktLWUpobG52MHpITDNSM1RPb1hCRnNUMGVtdHZU?=
 =?utf-8?B?b0xzTEc2WGRxbHc2K2ZkcHBYOGhLOWNVVTZvQTJmamZaYVNmSUxEbDQrdXp6?=
 =?utf-8?B?d2ZYcGMvZ0VtTmprV1dpWnVuY054MXd2amtaZUlFZEZwV3lnZE1kYnhFWmFp?=
 =?utf-8?B?YnJJZThEWlJNSC9aUllIeXJEdUV6WWR2U1FjSUJHQUdqbUg4N0FTOHRDNXVN?=
 =?utf-8?B?YU56WnlHU2tkelRYWHdLY0NvYTBxOW9jb0R5dFczZGttdXUxSDUxS0Evc1l3?=
 =?utf-8?B?ZnNyM2RHblk2enQzSWVRaDRvTXBnZG1HRXpuSE5FZUh2b3dXMU5LbTZQSDFZ?=
 =?utf-8?B?YURmajlySFVnNkYrQ2xiMEdZZURPWTU1blQvMzF5cDIrWTc2UlY5NDZ5RE1w?=
 =?utf-8?B?Ykl3aXBoWDY4R0ZmeGVSRjJFYk9qQmRENEhIczFxRHpHNE03VFNMUVhwOERk?=
 =?utf-8?B?UTlFeC9ZSThBekxtaHlnVHRDYUtEb2ZnUGxPTnNMbkF0dnNZK1ljcmRvVHZ5?=
 =?utf-8?B?N0J1N1VJL2ZPcExTcllwdDg5TkRpbW1QWDdlSHpmazZkSzNXTHZjZlU2cFZU?=
 =?utf-8?B?UlhRa3FXMjRKQXBmNVVOVlZmcmh5YTlXOFdQZXZ4cGNjTjRWSGQzQ29OQ2g2?=
 =?utf-8?B?YW1xbEpYNjl4S2ZWQ3JWem12MjIraWxUNWZvRFRQL2xNaWJyTHB2MHpFVDRO?=
 =?utf-8?B?ZFdPSG00Sk9ZRGRBL0ZJSzNXWnhNMFRhNEw1d05rRUJ6ZVZDaVpDMlFTa1Vt?=
 =?utf-8?B?VUE3Szk5OHh2NldNLzV4aVd6OHl6SGo4bGIrRDJ5U1l6K043TVFvc1BnYjYr?=
 =?utf-8?B?eG1odGVDNEcxWDgzV0VDdFFpcDVhNUpNZEx6czZHTjlQL1dRdkxtVlhnMFh6?=
 =?utf-8?B?TVRnTDdFMEV5bE9QZ2VOQlNOR1BtVG9DV2xiVmtTY3UzUFFVaUxKUGovNkxh?=
 =?utf-8?B?N3JwRC9XODdkOG9XQzhReUx3YVF5aC90MUpUeFZvMXI4N205Qjd3QkFFRGVQ?=
 =?utf-8?B?bXFHM3kreG1vYmw5Wk91UDJOYVRBRzVJR3gyZUpCbEZ5dlV4T1BsRmNQcFR3?=
 =?utf-8?B?RnQyU2dGM3JFQlFjc2xCbC80VSttb3NYVFE0NEQzMVB1bndVQU5rUkhnc0xq?=
 =?utf-8?B?dTQzZ3M5Sk9QTVhCYUphblovWUVtVkJidjVtcW5ZZWNVVjhTcmNNazVidXVL?=
 =?utf-8?B?OGFJN1ZHUkZOMTB4UWtjWXRDMkxDUjhnV1EzdWdocmNaSkRDOUxXZTVWTUg3?=
 =?utf-8?B?SGhkM01FemRhZzBZdDNnWjFWNlJ0N3F4Zlc5MmNJZVlETWRLVFcvME1kV0Na?=
 =?utf-8?B?cGNKUUYrRDlPMm5vUElyZmg4a2dhYW1oeDV4RlUxMEpvZ3FEL0syTW45Qkp2?=
 =?utf-8?B?aW9tK0Y2QTlBRUJ4a0FrNHZKc0puWjNyQ25rdDgrcTZyd2t4MDFiREhEOHNR?=
 =?utf-8?B?cDRxanBrNEtSbjZwNWNqdUsreS9BYzBVTGJIdloxRjJPanRKN0dHaGphLzV1?=
 =?utf-8?B?enU2TmJIU090QThwZTQ5NERRWWJlaVprVjVHZnRteWZZNU5IYnNDWS9IZ1Qv?=
 =?utf-8?B?ODgraXJFQm12OVl4NWdmTUMxL0NkZTdjaHZmUzcyeWg2SExCRUt6MzBiN2dT?=
 =?utf-8?B?QTZGSzN2Nyt5MzR0TnhYL0Nva2JwS2tlR21meWFBcGZaOVBFdFJmdkVGUEg2?=
 =?utf-8?B?MVNTRTlFaDhMWGFEZmV5UFRKNXlRYTVMOS9FRys1c1NPZVFSaWdaaGxuYXUr?=
 =?utf-8?Q?2eF9Vl9QkyzBydTlb2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3445e40a-11ca-4a71-cbb5-08def79803a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:02:20.3066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfYVnokKx63pbzdbcq0v/dg1mgQhVJ8q6NwP6RL60quvE8VooFTUXOfVr/XiXL8t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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



On 8/4/26 11:42, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Add amdgpu_svm.h with SVM data structures and public API:
> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>   attribute tree, rw_semaphore, GC workqueue, xnack state.
> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct

> - Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_WARN, AMDGPU_SVM_ERR

Please drop those, use pr_debug/warn/err directly in the code.

> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY

Those where already dropped.

> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
> - Public API declarations (including clean_queue, sync_work)
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 204 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>  2 files changed, 208 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> new file mode 100644
> index 0000000000000..f3b4f228405c2
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> @@ -0,0 +1,204 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_SVM_H__
> +#define __AMDGPU_SVM_H__
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/drm_gpusvm.h>
> +#include <linux/atomic.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/printk.h>
> +#include <linux/rwsem.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +struct amdgpu_svm_attr_tree;
> +struct amdgpu_svm_attrs;
> +struct drm_device;
> +struct drm_file;
> +
> +enum amdgpu_svm_xnack_mode {
> +	AMDGPU_SVM_XNACK_OFF,
> +	AMDGPU_SVM_XNACK_ON,
> +	AMDGPU_SVM_XNACK_DEFAULT,
> +};
> +
> +#define AMDGPU_SVM_DBG(fmt, ...) \
> +	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +#define AMDGPU_SVM_WARN(fmt, ...) \
> +	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +#define AMDGPU_SVM_ERR(fmt, ...) \
> +	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +#define amdgpu_svm_assert_in_notifier(svm__) \
> +	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
> +
> +/**
> + * struct amdgpu_svm_gc - SVM range garbage collector used for unmapping
> + * SVM ranges in response to mmu_notifier events.
> + * @wq: Workqueue where @work runs on.
> + * @list: Ranges list in garbage collector. Protected by amdgpu_svm.work_lock.
> + * @work: Drains @list under amdgpu_svm.svm_lock.
> + */
> +struct amdgpu_svm_gc {
> +	struct workqueue_struct *wq;
> +	struct list_head list;
> +	struct work_struct work;
> +};
> +
> +/**
> + * struct amdgpu_svm - shared virtual memory context
> + * @gpusvm: Embedded drm_gpusvm base, manages the range/notifier trees.
> + * @refcount: Reference count guarding the lifetime of this instance.
> + * @adev: The amdgpu device this SVM context belongs to.
> + * @vm: Back pointer to the owning amdgpu_vm.
> + * @attr_tree: Interval tree of SVM attributes.
> + * @svm_lock: The driver_svm_lock described in the GPU SVM locking section.
> + *            registered by drm_gpusvm_driver_set_lock().
> + * @work_lock: Protects the deferred work queues such as @gc.list.
> + * @gc: garbage collector for ranges queued for destruction.
> + * @exiting: Set once when the context starts tearing down.
> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop stale
> + *                 faults.
> + * @default_granularity: Default range granularity.
> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
> + * @invalidate_ranges: Callback of the MMU notifier invalidate event.
> + */
> +struct amdgpu_svm {
> +	struct drm_gpusvm gpusvm;
> +	struct kref refcount;
> +	struct amdgpu_device *adev;
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_svm_attr_tree *attr_tree;
> +	struct rw_semaphore svm_lock;
> +	spinlock_t work_lock;
> +	struct amdgpu_svm_gc gc;
> +	atomic_t exiting;
> +	uint64_t checkpoint_ts;
> +	u8 default_granularity;
> +	bool xnack_enabled;
> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
> +				  struct drm_gpusvm_notifier *notifier,
> +				  const struct mmu_notifier_range *mmu_range,
> +				  struct drm_gpusvm_range *first,
> +				  uint64_t adj_start, uint64_t adj_end);
> +};
> +
> +static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
> +{
> +	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
> +}
> +


> +/*
> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
> + * Hold it in write mode around structural GPU SVM updates, including
> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
> + */
> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
> +{
> +	down_write(&svm->svm_lock);
> +}
> +
> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
> +{
> +	up_write(&svm->svm_lock);
> +}
> +
> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
> +{
> +	lockdep_assert_held_write(&svm->svm_lock);
> +}

I'm starting to repeat myself, so once more: This stuff doesn't work like that!

The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.

So clear NAK to having this functions here.

Regards,
Christian.

> +
> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
> +
> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +void amdgpu_svm_close(struct amdgpu_vm *vm);
> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
> +
> +void amdgpu_svm_put(struct amdgpu_svm *svm);
> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
> +					       uint32_t pasid);
> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> +			    uint64_t fault_page, uint64_t ts,
> +			    bool write_fault);
> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
> +
> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp);
> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
> +			    struct list_head *work_list);
> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
> +				 const struct amdgpu_svm_attrs *old_attrs,
> +				 const struct amdgpu_svm_attrs *new_attrs,
> +				 unsigned long start_page,
> +				 unsigned long last_page);
> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
> +#else
> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm)
> +{
> +	return 0;
> +}
> +
> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
> +{
> +}
> +
> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
> +{
> +}
> +
> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
> +					  uint32_t pasid,
> +					  uint64_t fault_page,
> +					  uint64_t ts,
> +					  bool write_fault)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
> +{
> +	return false;
> +}
> +
> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> +				       struct drm_file *filp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_DRM_AMDGPU_SVM */
> +
> +#endif /* __AMDGPU_SVM_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ec1196d390bb7..30463a83e2e60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>  struct amdgpu_job;
>  struct amdgpu_bo_list_entry;
>  struct amdgpu_bo_vm;
> +struct amdgpu_svm;
>  
>  /*
>   * GPUVM handling
> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>  
>  	/* cached fault info */
>  	struct amdgpu_vm_fault_info fault_info;
> +
> +	/* SVM experimental implementation */
> +	struct amdgpu_svm *svm;
>  };
>  
>  struct amdgpu_vm_manager {

