Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F36BC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0280E10E1CA;
	Wed, 14 Oct 2026 20:12:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3991210E1CA;
 Wed, 14 Oct 2026 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792008770; x=1823544770;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3TtRVDy/+gNFXdTibeAvqDr3Txvt/TkFHvXjNBwxyAs=;
 b=E0k8FSvAOdjWy2aRYlLLGNpyPI8f1nmaTVIaIVagqztDjDJK7mBGP9/H
 hJV3ci1wR5XnXxW3Z8J1kqRlaUqtyIXkkLKn7B5fcccmD4wEL6e7caFUC
 aMkJ9AqNPfKMtiufQoNjPWiaXt5hBUOPMzC/QnvZj5adHgyruIEnat21d
 QlAYgzmQdMNAjz6wLu1GuYpxML6CN8G2aNIOjG6bveULgHrMQdoqsQIaU
 qkspwyaNP8NUA+90q3cJxQ1cHYUTqaNkGypKffMiiN1L5CUm2Xz4Xruo1
 t5tYyVqKEthabYMAiLZ6z3X3pWcrbLFs4IoMeTzVMpaPgdE6zvpIJs8gu g==;
X-CSE-ConnectionGUID: xWRC35+ES32rrA1l3URb1A==
X-CSE-MsgGUID: Lh2pn4quRga/hUfzK4ooTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="665713"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="665713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 13:12:49 -0700
X-CSE-ConnectionGUID: KMueiIw0QSeQM+mXllwnww==
X-CSE-MsgGUID: +j9wI3LUQt2U39u1ArOFdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1594498"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 13:12:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 13:12:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 13:12:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 13:12:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEWzOxv31J5AR7sBTLSuvp8eYPbYTpsdz4VI19JHn5KzafBPA0OMEaIw3X2KcX30k1mVZ0Zw7kX6SlsTVgdMB9Ygj9Ofp79n90MU8v1mLGO69WfYcFfROyrtaciW9ji/pr6LIZBdW795EVsA5PjRZml0lgKh5mL9cNEgpCn2F7yaBJDXZ15cAuLzBICSe+6IjtkBBEw0zm/KNu7rlpvcZRAn4iW6Lf9CynavZQPChLO7CMaADweYpZRYrSJlP4qc+qAqmz87myk1zns4LEnHHGoJEWNdClBlzedoLPR8NTDzALMFZuwC4s16cRXxbSA0vX61Keh+Yuz/tAZCai/YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRYHNqgZxiL/1VJ2YbbcB0XXw+9JGjwIVyWqUGGxfC0=;
 b=q6i7//6bn9NFCt9Wgj318zobxrsNmQqSOp+6u0PIs0EI5sN+HKQGxZE7L2R3pAICtWW9b7Nqzrrhd6mVVMyJgXOyHo/jhhr3EDsli9XJxkt7O7WAg+lchdL+uGQ+EICy/V3Ypc1BNYtQrHwZwTV9YPVltlLeFGNxU3pn7Wgn0Rf4rhgKBSK5Rj6LX6oKgHZrKJb1gkj5ms79e0AF+bxpu1UpHbPhTGpOgdtXMD8QwP3s9FVHLSMH7jq3c3wUP841mQ1y7V8C0TaPWqc/r2f3beWnr0FGSn8D6wweNa9OMRrROOkBwQQUXo5y5avgtRPjB3/+U4Rztx8oeKcgzsrcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by SJ5PPF56FDAD370.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 20:12:46 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 20:12:46 +0000
Date: Wed, 14 Oct 2026 16:12:41 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Constantinos Chalkias <cch@e-psn.eu>, Bata Roland
 =?iso-8859-1?Q?Kriszti=E1n?= <batarolandkrisztian@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
Message-ID: <as_iOd6A_Yncj8Gt@intel.com>
References: <20261012104245.2108030-1-cch@e-psn.eu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012104245.2108030-1-cch@e-psn.eu>
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|SJ5PPF56FDAD370:EE_
X-MS-Office365-Filtering-Correlation-Id: 042511c8-e07d-44d5-01fd-08df2a2f8313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1GOoYFVghdo+k/JOsAbrHovnwsjI5esRu7s+nEQzhEZG05GF59ohFJbr8gQLi+8KuMUWyd7kZfQzUWJqPf1XvkEljO5OejNQ0RT7mWh8jOqRfzuWR24pfKg/m4N9ApcI4CVMgIIZMmTeLoL3oxUTLC/5vHJJcmhQzDIlnSaZEhRY+W3UWZCZnjPOS/IO2cBIMemz7aPo/KuDx0gxY3hbInD2A/Mava/D+yDorUKoVjH6eKGqTJFx2YD9fUzcT6rp3S4FMadaB1HncgjC2pI/wNXC0UU8Lgxm8+qH7QvskReBhyhBDL7POhm71O+6bBMHkAW0FvGHF4HAez2qyZpz49EMkrmPzn4u+phgiZ1SsFIR97wTndQqXWJ2UnGtIMPvJEnBIa72h1v0Ps/96tKS5MH9aN7/Hn8lR0xZKWfPMCGHOONmVjlBlkCAgurj33XfbUdxxjWrYeachWeZKsDH7YK22PvMBX50hW6DcYH7Hsru3CItRaPTNzZhKg2uzx4dRvf0An/SRZcAG/t9rwjZgNqWTUBG6G8C+kYq1n+4TigRUmxVqZev0kxyier77SklNKC2V7s/IkfeAqAZKrdGNat+dAMnqx1QAIKTLieEMB+8OOmdoRYO58+JnTIMUA3c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?THCWiz2OeOtSvi+yjkl2NKvUwnJ43wsjBlGmtjukXH1R7uKCqbwaOARRcN?=
 =?iso-8859-1?Q?sxT5fWOjFJIqjlPZYBSezzpkPLpVyd5z/VwTPALD0YZXDbzUGmPuDq/MRr?=
 =?iso-8859-1?Q?PtWV12x1n3iZXuHhjizLy9vUUrTz1viA0JeIZH/Gr8+lhk/hLYTpyRcc63?=
 =?iso-8859-1?Q?t3/MdIM4/BY4mZ+12hr+3OtgbgrlgfnzqaS3DvgY7Izr4siVM9m+amYGr5?=
 =?iso-8859-1?Q?sgoRmGnp6rvPfZZaloR9LYrtjQYIph9WUkbOG0OqI5QmKKs0JlpSDelToG?=
 =?iso-8859-1?Q?GZabi9KhjLSNgs456/HEmYbH3Ww0HRlpy2cgmf0D9CND6oTI52rQ9iO4zX?=
 =?iso-8859-1?Q?kNdjCPGhFB6SdRvWPGn9X/tJ+eaC16L0DYlLdkB+YQ2SVZqvp061NZU5Nk?=
 =?iso-8859-1?Q?q6en/P4xQy5sdOSFRKL+JkLeb7JktIRDW+HanLSZuJ66rFwhigQpETpgR8?=
 =?iso-8859-1?Q?c1jlEeydvGSZM3eYXQlKo1vAB72fl/bvavOzOqWpaqmqis/XUj7n6NtE+H?=
 =?iso-8859-1?Q?J3R5fh7YsE0RxaRgirrEZQ+EKDdb7B4JC0ywuxHwUW5A9mr+aOrQSs3coN?=
 =?iso-8859-1?Q?QvicamyETAG12UikTfLfWNME1zOAWf7wTTi2jioZ7A2iV3bRHPaGEpcUNu?=
 =?iso-8859-1?Q?5iK5knMExQ1IsWqsgLIDwOoye6hgVtYTtKT+Ya9Gx5Ue6a3yeZXyVyXkGk?=
 =?iso-8859-1?Q?myGs1jQaLSkPcuT3aI/eJXVsirnH4fQSsUgYyKsaDZri1PaecnG+0waVm1?=
 =?iso-8859-1?Q?H/QkfpLR9PVWF8R8zlNoJ51P1qXdT7ZTbSknEThYgaBBbs92EEH93ZASxr?=
 =?iso-8859-1?Q?Vo+NdJIcpXDQw0R9Y2HbU/L56Kuqr/bUwyIe/0fsRIXnnzPfNttEH74LDM?=
 =?iso-8859-1?Q?Y1QCYyrKRKQ2G8IVZyLO1Mt6rs81kvNQpXqJjetOpIgO4hlvpq1HuqfAxl?=
 =?iso-8859-1?Q?0AEMzFSlokSYFlBjBi5fVlsS8q5KeSUy61Iy5pAfm+4tUALnNbE3ChuFj+?=
 =?iso-8859-1?Q?1deV5DFjyEGaE6RAClsc6MmnjchkBv7qzJJM4IPr5MKcMxK31JzebpKHI3?=
 =?iso-8859-1?Q?vJYoNWfGXX0vZzlEAOgsqW4xEF7sfnXr5t316jnCECbLXiEdLKOrH+qz8E?=
 =?iso-8859-1?Q?uygkewvGd3YJmTtrtO0V4MKsWDqx4jV/5afLCvV8o+l8YM4daCsvnJwvwJ?=
 =?iso-8859-1?Q?1KUqySyzYqzcMkbQLYgdcwZQ4OkCHrmhgdr2qM4TQBzSzNusJZ6XXcp/Vw?=
 =?iso-8859-1?Q?qmi3uOGdP90umNe2r0GEpuO+HPXaGthy3zNbPfjt+q9pqeLXRJFOr0jwpQ?=
 =?iso-8859-1?Q?6wi8XYFdWKKJzpbbC9Ry78QVdJBJFFT/ZJRqywVgdQAKPdmmp3xMY28EYv?=
 =?iso-8859-1?Q?gyN0+Kp0k7Z3aNsiMUR3ubwPiIrXDs+gRhQfr4kLJ45gB7e/npVxLAOIXC?=
 =?iso-8859-1?Q?LwioiykTndi/yH+13X3fM1sllCjiLB9l0CmpnGx1WDCMMd4qoImyxrzP37?=
 =?iso-8859-1?Q?vloc8Xax29FDLcqPAPWDkF+BG9QxQeEReA7Re7FO78y+7v/AJl3u/HnDlP?=
 =?iso-8859-1?Q?JI6O2Fmop6FmLMmj5DiKFGPFr6640pzALMGm4UPihtU7iegaz03DY3wTqE?=
 =?iso-8859-1?Q?+LrPp7Dt1QRebnWQkyrDdLO81fbL1VNc3Fo9XMPrtPB8PIZ27cD8HPc7P6?=
 =?iso-8859-1?Q?q1IbeKb2Bfzo1mxY7i/CDUH0LWQu4zRg2PKlPNxaazAc9qSIsRSEFu502T?=
 =?iso-8859-1?Q?PzxRPtgx8FD70mm3rYf1BJGWfcBed5JMqOKw7/hvgg0Xzzmz4f4MqlIVyl?=
 =?iso-8859-1?Q?XuitkBAKww=3D=3D?=
X-Exchange-RoutingPolicyChecked: FJouS/ysoF25Sm2XAbEhUi3ry6u/yJzzsxUv8tdfR79DFDsY/z9ywqAwG3Og+TsBd1YFzAgjc5VWoz6VjtsCc3c0l/DvX3mtrhFEyQwMVYeN/TluwGOQ5fiTS5ABW96NqlZYWVx9ZxJnKvwpRbNTigXUKsZwtU5PABe7Z80nRvj5WI/MrJfwR0+rHu+iBomC6+4chv9ZnfaLwJR50rb5Z8EQXNTxPA4f97yzvxVnClH57Ykc+AfTnjJBlo3SVB+x5NzpSkRBNsKlfEbbNV/R3antbNdePqRxh1dkwh5IQ5I23MAfvXb7gDuqNI2BTpMiX5QxPQp4ZQldsDAWsQO9ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 042511c8-e07d-44d5-01fd-08df2a2f8313
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 20:12:46.3060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoO9OQ4HtPYIBiW92FTQWNaNqKncMr1HkfGOkasLREwKcq4uAvM8pdbSMO2k99bKmpCg4i1kCbVJCUgUcKITJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF56FDAD370
X-OriginatorOrg: intel.com
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

On Mon, Oct 12, 2026 at 01:42:45PM +0300, Constantinos Chalkias wrote:
> On Battlemage, thermal telemetry can remain stale after the GT returns
> to RC6 following sustained workloads.
> 
> On an Intel Arc Pro B70, package and VRAM temperature telemetry may stop
> refreshing after a long inference workload. Fan telemetry can also
> become invalid while the physical blower remains elevated.
> 
> Acquire the GT force-wake domain around Battlemage thermal MMIO reads
> and allow a short settling interval before reading the register. Route
> package, VRAM and VRAM-channel availability reads through the helper.
> 
> Testing showed that an immediate read, as well as a 100-300 us delay,
> could leave telemetry stale. A 500-1000 us delay recovered correctly
> across repeated inference-to-idle cycles.
> 
> The change is restricted to Battlemage, where the behavior has been
> reproduced and validated.
> 
> Signed-off-by: Constantinos Chalkias <cch@e-psn.eu>

Cc: Bata Roland Krisztián <batarolandkrisztian@gmail.com>

https://lore.kernel.org/intel-xe/179041811564.526373.13204522833274380927.b70-hwmon-rfc@gmail.com/

I believe you guys are facing the same dificulties and arriving to similar
conclusions.

If the consensus is that we need this forcewake, let's do it.

Let's just avoid duplication of efforts in here.

And thank you all for the contributions.

> ---
>  drivers/gpu/drm/xe/xe_hwmon.c | 51 ++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
> index 5edeac961ec3..fee358ab9a6b 100644
> --- a/drivers/gpu/drm/xe/xe_hwmon.c
> +++ b/drivers/gpu/drm/xe/xe_hwmon.c
> @@ -3,6 +3,7 @@
>   * Copyright © 2023 Intel Corporation
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/hwmon.h>
>  #include <linux/jiffies.h>
> @@ -14,6 +15,7 @@
>  #include "regs/xe_mchbar_regs.h"
>  #include "regs/xe_pcode_regs.h"
>  #include "xe_device.h"
> +#include "xe_force_wake.h"
>  #include "xe_hwmon.h"
>  #include "xe_mmio.h"
>  #include "xe_pcode.h"
> @@ -946,14 +948,43 @@ static void xe_hwmon_get_voltage(struct xe_hwmon *hwmon, int channel, long *valu
>  	*value = DIV_ROUND_CLOSEST(REG_FIELD_GET(VOLTAGE_MASK, reg_val) * 2500, SF_VOLTAGE);
>  }
>  
> -static inline bool is_vram_ch_available(struct xe_hwmon *hwmon, int channel)
> +static int xe_hwmon_temp_mmio_read(struct xe_hwmon *hwmon,
> +				   struct xe_reg reg, u32 *reg_val)
>  {
>  	struct xe_mmio *mmio = xe_root_tile_mmio(hwmon->xe);
> +
> +	if (hwmon->xe->info.platform == XE_BATTLEMAGE) {
> +		struct xe_gt *gt = xe_root_mmio_gt(hwmon->xe);
> +
> +		CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
> +
> +		if (!xe_force_wake_ref_has_domain(fw_ref.domains, XE_FW_GT))
> +			return -ETIMEDOUT;
> +
> +		/*
> +		 * Allow thermal telemetry to refresh after leaving RC6
> +		 * before reading the temperature register.
> +		 */
> +		usleep_range(500, 1000);
> +
> +		*reg_val = xe_mmio_read32(mmio, reg);
> +		return 0;
> +	}
> +
> +	*reg_val = xe_mmio_read32(mmio, reg);
> +
> +	return 0;
> +}
> +
> +static inline bool is_vram_ch_available(struct xe_hwmon *hwmon, int channel)
> +{
>  	int vram_id = channel - CHANNEL_VRAM_N;
>  	struct xe_reg vram_reg;
> +	u32 reg_val;
>  
>  	vram_reg = xe_hwmon_get_reg(hwmon, REG_TEMP, channel);
> -	if (!xe_reg_is_valid(vram_reg) || !xe_mmio_read32(mmio, vram_reg))
> +	if (!xe_reg_is_valid(vram_reg) ||
> +	    xe_hwmon_temp_mmio_read(hwmon, vram_reg, &reg_val) || !reg_val)
>  		return false;
>  
>  	/* Create label only for available vram channel */
> @@ -1025,15 +1056,19 @@ xe_hwmon_temp_is_visible(struct xe_hwmon *hwmon, u32 attr, int channel)
>  static int
>  xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr, int channel, long *val)
>  {
> -	struct xe_mmio *mmio = xe_root_tile_mmio(hwmon->xe);
> -	u64 reg_val;
> +	u32 reg_val;
> +	int ret;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
>  		switch (channel) {
>  		case CHANNEL_PKG:
>  		case CHANNEL_VRAM:
> -			reg_val = xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, channel));
> +			ret = xe_hwmon_temp_mmio_read(hwmon,
> +						      xe_hwmon_get_reg(hwmon, REG_TEMP, channel),
> +						      &reg_val);
> +			if (ret)
> +				return ret;
>  
>  			/* HW register value is in degrees Celsius, convert to millidegrees. */
>  			*val = REG_FIELD_GET(TEMP_MASK, reg_val) * MILLIDEGREE_PER_DEGREE;
> @@ -1043,7 +1078,11 @@ xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr, int channel, long *val)
>  		case CHANNEL_PCIE:
>  			return get_pcie_temp(hwmon, val);
>  		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
> -			reg_val = xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, channel));
> +			ret = xe_hwmon_temp_mmio_read(hwmon,
> +						      xe_hwmon_get_reg(hwmon, REG_TEMP, channel),
> +						      &reg_val);
> +			if (ret)
> +				return ret;
>  			/*
>  			 * This temperature format is 24 bit [31:8] signed integer and 8 bit
>  			 * [7:0] fraction.
> -- 
> 2.56.0
> 
