Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906A7CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A678010E2ED;
	Wed, 13 May 2026 08:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fibdBxt5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA1710E06A;
 Wed, 13 May 2026 08:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOt1LTzU7BZmeE3ZAEFZzXA9fSCAmZq6Nsh89ABPBMb9EKTwDju3FfBREfvd116oWJRjFL4fi66RLGZm3jwpcLQUN+ZTgO+YSL85sz/tgX/tJKrWDXEA/lXATHnU9VyT8mTx4Z+tfipN7KYUUssmlGSQrEA4sSDalzM5axJhj0wK9ZkXGZATUcM4rLVC3o21+b+omQWR7MQ4PSGfArIrxVj9Sj3ESniIPw/eLTiYQeJ8Zcx8pPDC/cPAhOdk/igbmkSOrngtm99FTIBkxP8Z+GiJ9fAgSrbKa0CjJ+Y9D3LWDONAZ8AHoeXb2oXdCO9d9BOTst3xyyNRs52Gdo0GPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX9Ivbjjk2qhQu6YAP9Z+XzqJ+t6QkrAVysbOAZJ/sk=;
 b=q4cMb/pPC9OW/7TzxiVvA673y9SarhVPpipM4MkSln9XW7Nh7coy2RZN4EWOEBfWgLWWeIf0famTqJBoRUzUKiT+Q3MZNUX46vw2JdzFyvwNQh67QQgbpkOgrKHGPLzi3cSVsOsFNDJvbbgN0ZNOQn8ZcrRu70J+x9EE4aHy05ICJECiyWIkJwo7W+Yqvk+cs5cbyzMDZJcpVVku+K0SlcJUV8KWvwNZuiA8tEu3GORcYB4kdfayxrgDmYFGZiD9Z0CBVDTTn6QeYWEeLBqkn/rsRZmApr88ehXmdpkRC/MGyGXL1ajAIP6doHsfWlBE0S00n3Dj2B+qUR1xZOV+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX9Ivbjjk2qhQu6YAP9Z+XzqJ+t6QkrAVysbOAZJ/sk=;
 b=fibdBxt5POc2KXR7OEodOK88ugBIF4Usu1Vfe7GURULbYSI280w3iAJwcyjYCFk7MX7FfxfhCfvHRUDppBgzR/8cLxElysfK8XLtL7hc6/oNr2lOrwEm9uwS7OxZxAEbsx1Imqjb8SFytzzi8T+QhmRYfz9IIOsrZYBD3EzP3BE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:06:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 08:06:21 +0000
Message-ID: <ceb093fc-f028-4c03-8f16-08ab2d0b1ed7@amd.com>
Date: Wed, 13 May 2026 10:06:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t 0/8] dmem: add amdgpu support and one more test
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260512215156.4083082-1-cascardo@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512215156.4083082-1-cascardo@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e29abf-a7f3-4410-ffe9-08deb0c684c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: b80D50iCrxOpswCxSB1pPKIcsjMMb5YjrhpxZClKEcbSg4caQ+NkeYpk1ruBwcTZ00dWYZX6d6SnZcjgaOjUfFEz1Ozj9d3e7qwX0BOfZRYMI/oKI6z87ONELx8JiJCl4Wc7mqhYBq7I49rdjggdeum1+irT25tNs0AmcGMX2+pbREWundE+nuDFbI283BYaPRhYixb/geTxofU5lhKjc3FbP3kynizyndndyPBX2Ni+CG8s33HJgTIR2Qna9PnFLepadnie9NgVuWnrlEml8A10zk2C1CImdTUOfGzLNKOq2FqApB/MUf4xz7SOBmPXCZs3R4WIkwHQYEw5b1ocV922DzctwJRYcyFyaD4c73rXpixq5pfQKNYBCfFhoIu4eveI2UmxjuqM+OcPbTrU+MnZFNKAXOiTtOTISgsT7mdWWhYn9pojcm7Ueo2M2Kbhd254p+eCMxURtw8Syaq2piOO/u44Fz/QB78iWG6XqFEhmjxTJPKPcP6eIvYY2VKm15bxWnb6wgSkju/SAMKpWpOlq/zerUSY+shzc71tF8FwkT6sAdInHkzILDyxsneXBVwi/eHHnK5PglmNYZQVKPV8z9nls2T1hSyuAxefb4KzZ/H+zFkkdUlumGZdgV4Yg9WRjDZKYCqXyKpKTpiJtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnY2Z204MlI1RWt1ZzlRektia2U4MFo1THZES2dMSTBUV3E2bVlPMlNoZjF1?=
 =?utf-8?B?QklzWUJwNi9qaFRoU3doQXdvczduK2NRdzhUaS8zdlN6WEhpWTU0TlZQUGxa?=
 =?utf-8?B?TDRIYWdwdFlOdENicjdtZFowYTczMDAweFA0S2pmZ0RRa21TZ3Vub0F4MWNC?=
 =?utf-8?B?bFRBWVUzckswWnBDSE0xNjIxOGhmdW41TFlJckk5YUhYYjFzY3RpSnJhOFVl?=
 =?utf-8?B?cmMwZXc3UDJ5d3BaSjAxbjg2NWM3RkFkTDd2enllRGViODZjTW55cFFoTHFS?=
 =?utf-8?B?NXVmRURTMUdoMi9LbmFXY1Zhc20yQ1YyRFBtSncvdzJIbk1CUlBQWVFpOTY4?=
 =?utf-8?B?c0RtbHpQS1lBc041UGxJaWVBVTBGZWdUWVE0NTR1U2dhMEIyRnRwMms5VHdw?=
 =?utf-8?B?MStua3BOVnE5cDdzay9OSUNXVUpBZjZENnF2VHRnalduc3JjcGFydW9EQTBM?=
 =?utf-8?B?MnpZRWszeDNoVzdYUTYyZHpiTklRYjcyTzQ5c1owK3lnQzErdEkrOGU2RklU?=
 =?utf-8?B?SHI3UFhPSm54a3RDekh6UnFvZGJRYjJBTUJBVmsyMDR6TStaTWMrMUxORHFs?=
 =?utf-8?B?NDRIVlRXT1p6N2tEY01VY1c1cWdIc0hRTnJPVm9paUFUb0hrOVlsbGE2WTI4?=
 =?utf-8?B?bThCRzNxSW93bm5ubGo4RjAxWGRydjJzNlNyRVNPdG01MnBsQUI3a1ptelpJ?=
 =?utf-8?B?VmdwUlo5bjJXc3Z3elQ5QlVmUFloYlFLdTYrVDZrS3A2T0xWcG9kRDJHbkU4?=
 =?utf-8?B?ZzZJVnhId1k3ZHZpYktmN1VOaC9xU0JtVkx4aFV3MEl1eG9MdTRyRGxBMW1D?=
 =?utf-8?B?cFlLbXp3ek9VTUcxVVMwSFBZcVhiWEFxaFowNEpLTFhlVTY3VmJmZmlqY0VD?=
 =?utf-8?B?NWprOUpYVFpCZmdKckhNMUtmNkhlUjVDd3dmdldFeVBNMExVYzA2d2UweEd3?=
 =?utf-8?B?c09KYS9udWJ6NkJPRzVrOVAzbXFoM0FmTlkvS2VLWHY0ZGtubjI2cE9WcmFH?=
 =?utf-8?B?eDV5NXpVbGlnYytSUkpuYTJoTVpmQkFWNC9SRXNUM3NBemJkRFMwYWt5RWZF?=
 =?utf-8?B?dDYzd1hxRlhhQTBDQlVKb0h6cFd1WUFHbU43OTFZQ1RyUFc4SjQxaEtKaWZa?=
 =?utf-8?B?K0xYQWY4bkJaZjZ4Wk5xZ21PVFhDVks2M2MrRUN2NGxGWEJHZkhpYmJkTGFZ?=
 =?utf-8?B?anhJUytIeGZlTE5hdW5ZeDhBZm5rc1F0VW1iKzNLSm1MbnJZbkZvcU5OckdZ?=
 =?utf-8?B?cVhCUnV4UEQ3Vm96VXZub3BZdzQ0eUpGQXNpRFo5Q1RzOWJYMGlsL0VPOThL?=
 =?utf-8?B?TG9CTlptT3FFbkUwV0RQbDJFTWpVZ3RiQmx0VDJnaVZxaTVRN0xqamFqQ3JD?=
 =?utf-8?B?bWxrS09QK1RuYms5b2sraGxGcENCaXY4S2IrdTJjT3dyREkwTDV1b3NjVEdi?=
 =?utf-8?B?SmI2YW1ENGVIWkFZU0MwYXdSN2FINzZHWWRvZUdDK2xoUGFZNmtFL3lSSTJo?=
 =?utf-8?B?RTVTTEw3eS80Y29WRVlhRE5TWXZMZGN6Lzdsaklxc0dFWU8xSWtOSlJBakRr?=
 =?utf-8?B?LzhlZm5kZUlwdXE0QWhOS1hTQW9STzA5RHdieW9WVjFHUzBRSFlKb1ZPTVN3?=
 =?utf-8?B?Sy9yaEVrRFJaNVljL1FSbnVvT2FTT1lKZEJZVkd4dkcwRHh0RzBwd3l0VUJE?=
 =?utf-8?B?L1NhYXZna21RbFV2Y2pjeUJaVW5wY3ZvL3F1bXZZWFptUHUyVjZOVTVUZWJa?=
 =?utf-8?B?czJqam5RWWpKeW5wckNEQmkveVhiKzA0bTVqYlpUNFNia2cxQmJONWYzSUsx?=
 =?utf-8?B?K3RrNFUxQm9PV1pJUlV1Y2x3WjdVUnloOUFzd1c2R0UvbGhjS1hMaVZUVDdk?=
 =?utf-8?B?a3RpdkxhUTgzZmVpc1pMRUsvVEd5S0xyekd6czNyVmtpbG9JVVROVDRwYUJP?=
 =?utf-8?B?NFhpVkpkQUM1SjA1eGdjV2FEV0NRQnpPTFlMOGtKME1MMk00Sk93NnVFdHNO?=
 =?utf-8?B?Nm1ycmp0U0dZMG9XajB6ZzBuRGo2Y1cvMlc5SDJ1M0xnTCs1SFlLeloybXp3?=
 =?utf-8?B?OHY1SjV2N3JGWnBKdHpWcSt0dUFWdGlraktrbFNTRVBTK3F2djd3UzM1dStT?=
 =?utf-8?B?U2FkaURLUVBlVlJEakJnNUpGVENsNk9HMVhoZ2VPVWZVQ3dXVG9la3NvK3k1?=
 =?utf-8?B?VHN3eGJlQlpVOGp0eS9EcEJqK1JMeXczU1JXZ0NEYlpWaHNOWklQcHBST1A3?=
 =?utf-8?B?dmhEajdKYkhYZm4zSEViZ1BvM1hPQ2U3RUxjQUM2YmpKS0VDU0dVdWZacGsw?=
 =?utf-8?Q?GWJt0cDL8BHZkML4X/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e29abf-a7f3-4410-ffe9-08deb0c684c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:06:21.2666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDkQnbQbpnJZvakzCCqPlmJNkc8sw7fwyR5Mc0EIoqsPX4H94bZIhLhhqT7AABVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

On 5/12/26 23:51, Thadeu Lima de Souza Cascardo wrote:
> This work builds on top of Thomas Hellström's patches at [1].
> 
> Besides the case of eviction when setting dmem.max, which still needs
> support from [2], there are other cases for testing dmem behavior and
> potential regressions. Thomas' patches lay over the groundwork for this,
> while this patchset addes one basic test of checking current usage and that
> drivers respect max setting when no eviction is taking place yet.
> 
> This patchset also introduces a driver layer such that the same tests can
> work with different drivers. amdgpu support is here added too.

Of hand that looks really nice.

Please always keep Vitaly CCed for igt test patches which affect amdgpu as well.

Thanks,
Christian.

> 
> [1] https://patchwork.freedesktop.org/series/163935/
> 
> Thadeu Lima de Souza Cascardo (8):
>   Introduce dmem driver and implement Xe support
>   Adjust xe_cgroups test to use igt_dmem_driver
>   Make xe_cgroup test a generic test
>   amdgpu: add amdgpu_cgroup_region_name
>   igt_dmem_driver: add amdgpu support
>   dmem: add test for current/max
>   dmem: only check for dmem availability once
>   dmem: get region once per driver
> 
>  lib/amdgpu/amd_dmem.c    |  94 ++++++++++
>  lib/amdgpu/amd_memory.c  |  25 +++
>  lib/amdgpu/amd_memory.h  |   2 +
>  lib/igt_dmem_driver.h    |  25 +++
>  lib/meson.build          |   2 +
>  lib/xe/xe_dmem.c         | 145 +++++++++++++++
>  tests/drv_dmem_cgroups.c | 390 +++++++++++++++++++++++++++++++++++++++
>  tests/intel/xe_cgroups.c | 296 -----------------------------
>  tests/meson.build        |   2 +-
>  9 files changed, 684 insertions(+), 297 deletions(-)
>  create mode 100644 lib/amdgpu/amd_dmem.c
>  create mode 100644 lib/igt_dmem_driver.h
>  create mode 100644 lib/xe/xe_dmem.c
>  create mode 100644 tests/drv_dmem_cgroups.c
>  delete mode 100644 tests/intel/xe_cgroups.c
> 

