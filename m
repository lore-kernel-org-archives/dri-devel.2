Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C12C5AD05
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 23:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348D610E474;
	Fri,  7 Aug 2026 23:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O/fthJEO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F276310E3E1;
 Fri,  7 Aug 2026 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786144061; x=1817680061;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2EpfaSNgVB3UHNToJ75MF9XN/jT9ZXgvfC/b9VpeGt0=;
 b=O/fthJEO/ZtmsH0LwFUDc1Qq6y+hEStwFK3yNsAhSgC9T4gkrL+OApAj
 J86gxI1jU2hE++9mCy5OpUMsYLI1Z2Y2NQaR9eZjQaycG1Fcj/ZDUYuFH
 +kKy6wKLnLnfoFhhi7OcdfhxuR2DnM2yjgAg32KYNDd3nrhDHU1LLc0HL
 Qa8ybrTYIwLMifrNj84Tbnb3TyQsLWby9HpI41fAAothu0hBRFWobDAMu
 StDb8QbDkOVbqAAMZm/f6Gsi1/YKAAhM2qUB/FNaUOkY5Maz/LAPsFPMJ
 jS0RFIPvbmrZM7DYRZIZUa3gka0Gy72Uiiu3A6hxHcZBttixn3/djVBCE w==;
X-CSE-ConnectionGUID: mlDUEwxfSriPPx4+9zv4zg==
X-CSE-MsgGUID: Sl85Jz7zTFaHb/QdSWv/WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="74297130"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="74297130"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 16:07:40 -0700
X-CSE-ConnectionGUID: Uo56y95RQjGn/PmJr+/H2A==
X-CSE-MsgGUID: zWiqsK85RxGYflsa3EWSAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="263140228"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 16:07:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:07:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:07:39 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWPaSUEeJ3PJszdz5mfi3VUI8DLNnUxFJ4bl11s1q+VocUDfhdczm0Pj3yma3slF3uQJHZa2FxIXlH+NfSnJ+kXd3JKtCKRMbbh4XOjaMQEA1pPVq88S349WgEDMQjAuUNTPd0zk+IpX0dZGGkK/hK14y57k0RFZ9Mm7GeshG2FhFCFr08y5/L6YUYHkYMsNMOU54A3zkMFBrkdVag+FqjYkMe68Rvk6Jl28CYtw7cC5wdxGcduz+AqZCg7F5D9LVrWiROh0xD2/S0y1QKGyysCdsbYhvaJZulCrk3GmYlOJXLMSNef4eIJJTPSDzq+Jl3kA5RBJDHF430JwkCbH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQX0+mkTg1aAElBC1n3/tmihX9zkug7TTXK6fhoKNyw=;
 b=oDl9N286pXIP03rCHJyv5W56dYV1P+/3qAYyXgNP+D9VqiOQS1/DzRZaBsDyAMzUepgrXlrOGV2d7Pke0nHN+OA4dKbOcQs5d8fxKp3pGGsvZQCkTQbrUYH9Cb9nqyJe/87RdT2cjMgZvI4721OWuek7lovcNUDns+uyO/BleGsjcb9C9ntysahFtF9QIpBy6fdAa3cQOikHqJyAMKy/IZ9Bq8rmZshRF8M0zludId8I4WdSxD0gF29P9kEaaAISOTLRJzDIGDLHJVxyU4r9Uc4Z8vmMBg3ni/41dm+lxem5g8Z4uniEEE8dKfdV3Cyo2KbwToZf3xnDZ0aCMZ7kqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 23:07:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 23:07:26 +0000
Date: Fri, 7 Aug 2026 16:07:24 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v4] drm/pagemap: Prevent double migration of device pages
Message-ID: <anZlLADT45F75WKQ@gsse-cloud1.jf.intel.com>
References: <20260807081244.2229191-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807081244.2229191-1-arvind.yadav@intel.com>
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: b26fdb9e-69e6-46e3-1c24-08def4d8a5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|5023799004|3023799007|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: P6yOwJM1xu5PFoKdd4ud5aNs6kx2HvpQ7dPtHV2bUgZ6bhYGZyL/ILJZeoyGiZdm0PHG8H9Sb4RIBtBEEV6tlxr/ZwBz0FZW2V4X6V4/KQRCyjm/w4Ocwd1JmHR1CsP9nnc+edFxQ1xTU+gK+JbuInrkgakVc+Cq0QW8YAOqemQnUSImiXGjX1he+VsTXZZt1M3MFV30wccpmDGTCrvjUOXUvFgZeRc2kh4LVxLuAOCLReCQqbluYHP+9O4Y/4Y9xcZR7zd32Yrgns2B53ibGHG5NdPYiROpo2UQd+K3Ry4OWeQbw3BcS/p1/ep++rbUyarf+YoWpJIy789OZoMn9zzse813c0A+Rbo1zcGnr3a961in07Fwj9rp5A73jn+7rNWABlIZ/Gnk/yFh22CeFPCs/bv9oCuOMaA7n+48O6lMoR5cF4+Q56fkxhSUV1ufwyTkb/3DkYIl8JoKi8t5b6hJMdQ6GYcJ3v83pFE5GNuFt4kM9R/EPe6lROKD9YEH6ew8Euz9qAuAg5It8bk/NqV2u897U+StHHxot9B1unPX0eokWoN6K+jcicbA9sn+twTnqzBKVWkJrlEZocrq/+0cm1ktdm4Jla36IQNeJbW/m1oTU267EsVohoYtnd2fwFuwv7sokpwZo0heiqPw+VYNNztvyVs9Ae5sXcO2e90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(5023799004)(3023799007)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?H2911nNGcAqJOaPA6fYA12BtlMUW0PhsqRMzq1e1BE3eDiNQaXHi20qC1O?=
 =?iso-8859-1?Q?7Fzi5xAbENP2c+VP6/GJ+36cfNALBnG4/9EXhH7CbTG8PfUmA4NETTfSPX?=
 =?iso-8859-1?Q?DHDEUbWEI/e3IfYSgo3oUCK3X4T2M0vAct1LcF9LIeve9xd5OXKe2vqZqE?=
 =?iso-8859-1?Q?xb3qHjvfEc9/Cr+KO68uNxHwHxHSsXyi6JRMhYg1HFpBfGJOxknuy/sprN?=
 =?iso-8859-1?Q?WPbq0UbuBr5jCNNFNiCg2uK/irAnvew824hxRW4Id4aqBBbQOyg1daHVcV?=
 =?iso-8859-1?Q?yZbeYXAIV4h+YYM3yvxr5K7T/1fpi2grd6l7L7Q8KuXZvzl10cv5EEY7AE?=
 =?iso-8859-1?Q?j53mb1duC5yBl7SRnfnsVMcuiLxLCDd/qJdi9E+5row6vw8Jl+E66NIgG8?=
 =?iso-8859-1?Q?rQm2maQOeo+16aZsBBprKmTNtfS/7ItrBfC4KWdwaOYt8UATpy2rBRAxYa?=
 =?iso-8859-1?Q?fKZ0otDUK4SVplvU0wClf9ViR3DbE9vBoQUoyXrHZXMC8hjCuGfeAJYGID?=
 =?iso-8859-1?Q?EHWnsljsB6aWrjBjtyw4Msm1nMT0un4AQKmlWyQdldQV7x7iBHi4KFOtRJ?=
 =?iso-8859-1?Q?Bj74knxqwD/XEI/ZRPrv0brBbIVdq6yF4SM7IUSM6wEGeMy+UoRyyxLZRs?=
 =?iso-8859-1?Q?oETrEQ2syLf9QPLfSigXndcNQ1I1xBpOVtbagCwbn8KBy0aOS3psAievQB?=
 =?iso-8859-1?Q?lNzgJnkBGvA2jaYCno7Nf86ituCKDTh57GpnhXIuiXBzhU95OgPzuEc5rE?=
 =?iso-8859-1?Q?U/TxszzA6EjWeU1rkE/QYFPtO1520CotivR2Bnm4twbD0VYYKWGSeRrX6X?=
 =?iso-8859-1?Q?6nWmaz8DHCU3e1K0PtYtuTfo5v7goj3CJi3WNo8nRd/TPWM4m9xB1Tf2rq?=
 =?iso-8859-1?Q?pniFuffj5vNwalBqyVrcMy0nWE85gPUVwlULqEa1rxvTWuXRzZHIkZvd2I?=
 =?iso-8859-1?Q?nhPoyGFYF5a9uHfuSAQAB59izO3CVBRNRf571vGMVm98vniWWCA3I6ffdK?=
 =?iso-8859-1?Q?ol2Je1AlaIXBmV/aZtlqQToijBv0bvjJeFKyZGTRz+UMKTDZd0vTmO5RpF?=
 =?iso-8859-1?Q?0+LTq6t+fatOhjLBqKQ1a4OSs3gFvmehYsQ9FPl0tZ0l1Wzs6ofgF+E6ZZ?=
 =?iso-8859-1?Q?Cw5sN5bHWUPtu1HnTm3Ee5QFWvIGno1gW9q8x1+9LNwoWixEhclkQjc1SK?=
 =?iso-8859-1?Q?NEcQvnUJdxnZrOQOSsATt0xGfDjDFCjeCpyOUKExO4eIE33opVzBhi+tgC?=
 =?iso-8859-1?Q?X+i9eQ5dFgsQLHpqHHvNpehY3mQC50i8j/G6cAu6w1rnx2M3UU9bdtnPJx?=
 =?iso-8859-1?Q?ZxP7Nx5bA3QDtSb5I1YSasPgXWHmf7MsU4vo8SvAF2b1yT3zODgNu+DShm?=
 =?iso-8859-1?Q?szbfSSTUMy9P1QR4pqsW7Ay5ogUEiRtk1pZDrHDVtL0un0X9rTUahMuykF?=
 =?iso-8859-1?Q?qYwrTQkstdeF33vhBfSRL345gw11usZZ9P/SlhfoQmrsSEsCwbQA0IrpGS?=
 =?iso-8859-1?Q?avCwaN0fn+o5Q4ZDmuQDwrvRovmU5k51BbNsVS1zfvt6SZxH9Xk86kHDon?=
 =?iso-8859-1?Q?FsQe/0UspObRXJkmDmOJiyQgKzq0cF3Ql2G+D+uuwmEKv+figCpixjt0KZ?=
 =?iso-8859-1?Q?3j4rj8XAKYtwrazl6tEMiLkqg908keODTkiIimxn+1/7hfdIRtg4TSyDkB?=
 =?iso-8859-1?Q?sb3vaxQcjKXVTbWWdGKzLp8FmF8oFoZjDfvBPb5JnIdpliniutvb64nn9Z?=
 =?iso-8859-1?Q?kdxXKIPDXhy2WoYvt+pZ0BX1ZlSEEVKBpxinpWUWIQneNalyd4sAME5r1g?=
 =?iso-8859-1?Q?eEgBW9THlr46yIs8b9hQLg9QTVcXwwQ=3D?=
X-Exchange-RoutingPolicyChecked: cndZv3bCZ5ozJhGE4syjAg2OCy1qoVG+UXu/HrKA2ZtktVQ/B0eKiHbWL3DpjPVRfzearysdaYAjG7QCt0DSXiT9MyYvTRQfOvkoaJLQm3R9g/xKLJ8qplph3r8ZHYSQdktFHgyR2//BL8WYaRyRDceXyRQ1RTStd6D2hiVjMbo6opup/yf0SlJ82Pvh2f/chbY7YctoV1MnX3ubZxqXcMkUpcz3p3btYMP5pUvjMuY1eUSKLwJHy9l8WHMSXYoDefBJkGqN8MtYacMBCCp1Q1LkWHTpNvADytuPCO8zj+ck4TFwAIS4724qNZylBBqXo7InWTLKffnw0FtOVfcQ9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b26fdb9e-69e6-46e3-1c24-08def4d8a5c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:07:26.6959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A8nP4U8JB9NDr2WTbQytqc/N2DM5rH+N2hi4cTrQGVSdMC78Hbce7Y3wVEzRr12HNJuXmBLGZJZF0YU5zv8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
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

On Fri, Aug 07, 2026 at 01:42:44PM +0530, Arvind Yadav wrote:
> A device-private folio migrated to system memory by a CPU fault can
> remain reachable through the raw-PFN eviction path until migration
> finalization drops the source reference.
> 
> If eviction selects the same device folio during this window, it can
> attempt to migrate the folio again. The second migration can leave an
> uncharged folio on an LRU list, causing folio_lruvec_lock_irqsave() to
> retry indefinitely and resulting in a soft lockup and RCU stall.
> 
> Mark successfully migrated device folios using a low bit of their
> zone_device_data before migration finalization. Make raw-PFN eviction
> skip folios carrying this flag.
> 
> Mask the flag when retrieving the drm_pagemap_zdd pointer and preserve
> it when a device folio is split. Keeping the state on the physical folio
> also avoids depending on a virtual address that may change before a
> fault occurs.
> 
> v2:
> - Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
> - Mark every base page covered by a migrated folio so retirement remains
>   valid if the folio is later split.
> 
> v3:
> - Store the migrated state in a low bit of zone_device_data instead of
>   adding virtual-range and bitmap tracking to the ZDD. (Matthew Brost)
> - Mask the flag when retrieving the ZDD and preserve it when splitting
>   a folio.
> - Drop the pre-existing fixes already covered by Matthew Brost's series:
>   https://patchwork.freedesktop.org/series/171651/
> 
> v4:
> - Advance by the folio size only for migration entries marked with
>   MIGRATE_PFN_COMPOUND. (Sashiko)
> 
> The lockup was observed as:
> [10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
> [10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
> [10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
> [10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
> [10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
> [10109.860655] Call Trace:
> [10109.860655]  <TASK>
> [10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
> [10109.860661]  ? __pfx_lru_add+0x10/0x10
> [10109.860665]  folio_batch_move_lru+0xc8/0x450
> [10109.860670]  ? lock_acquire+0xc4/0x2d0
> [10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
> [10109.860677]  ? folio_migrate_mapping+0xa6/0x110
> [10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
> [10109.860681]  ? __pfx_lru_add+0x10/0x10
> [10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
> [10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
> [10109.860689]  folio_add_lru+0x64/0x80
> [10109.860691]  __migrate_device_finalize+0x12c/0x270
> [10109.860695]  migrate_device_finalize+0x10/0x20
> [10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
> [10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
> [10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
> [10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
> [10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
> [10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
> [10109.861059]  ? __up_read+0x98/0x2b0
> [10109.861061]  ? lock_is_held_type+0xa3/0x130
> [10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
> [10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
> [10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
> [10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
> [10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
> [10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
> [10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
> [10109.861208]  ? lock_acquire+0xc4/0x2d0
> [10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
> [10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
> [10109.861219]  ? _raw_write_unlock+0x22/0x50
> [10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
> [10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
> [10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
> [10109.861359]  ? mark_held_locks+0x46/0x90
> [10109.861361]  ? __create_object+0x68/0xc0
> [10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
> [10109.861432]  ? lock_acquire+0xc4/0x2d0
> [10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
> [10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
> [10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
> [10109.861707]  ? __lock_acquire+0x43e/0x2930
> [10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
> [10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
> [10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
> [10109.861819]  ? ktime_get+0x23/0x130
> [10109.861821]  ? trace_hardirqs_on+0x22/0xe0
> [10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
> [10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
> [10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
> [10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
> [10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
> [10109.861929]  ? trace_hardirqs_on+0x22/0xe0
> [10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
> [10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
> [10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
> [10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
> [10109.862122]  process_one_work+0x239/0x730
> [10109.862127]  worker_thread+0x200/0x3f0
> [10109.862130]  ? __pfx_worker_thread+0x10/0x10
> [10109.862132]  kthread+0x10d/0x150
> [10109.862133]  ? __pfx_kthread+0x10/0x10
> [10109.862135]  ret_from_fork+0x3bd/0x470
> [10109.862138]  ? __pfx_kthread+0x10/0x10
> [10109.862140]  ret_from_fork_asm+0x1a/0x30
> [10109.862146]  </TASK>
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>

Mostly nits.

> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 124 ++++++++++++++++++++++++++++++++--
>  include/drm/drm_pagemap.h     |   8 ++-
>  2 files changed, 127 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b..c1112d492d64 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -1102,12 +1102,119 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>  }
>  EXPORT_SYMBOL(drm_pagemap_put);
>  
> +/**
> + * drm_pagemap_page_get_flags() - Read the drm_pagemap flags of a device folio
> + * @page: Pointer to a page of the device folio
> + *
> + * Return: The DRM_PAGEMAP_ZDD_FLAG_* bits encoded in zone_device_data.
> + */
> +static unsigned long drm_pagemap_page_get_flags(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	return (unsigned long)folio_zone_device_data(folio) &
> +		DRM_PAGEMAP_ZDD_FLAG_MASK;
> +}
> +
> +/**
> + * drm_pagemap_page_set_flags() - Set the drm_pagemap flags of a device folio
> + * @page: Pointer to a page of the device folio
> + * @flags: DRM_PAGEMAP_ZDD_FLAG_* bits to set
> + *
> + * Preserve any flags already encoded alongside the ZDD pointer.
> + */
> +static void drm_pagemap_page_set_flags(struct page *page,
> +				       unsigned long flags)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct drm_pagemap_zdd *zdd;
> +
> +	if (WARN_ON_ONCE(flags & ~DRM_PAGEMAP_ZDD_FLAG_MASK))
> +		return;
> +
> +	zdd = drm_pagemap_page_zone_device_data(page);
> +	flags |= drm_pagemap_page_get_flags(page);
> +	folio_set_zone_device_data(folio,
> +				   (void *)((unsigned long)zdd | flags));

One could write this like:

unsigned long old;

old = (unsigned long)folio_zone_device_data(folio);
folio_set_zone_device_data(folio, (void *)(old | flags));

> +}
> +
> +/**
> + * drm_pagemap_retire_migrated_pages() - Record migrated device folios
> + * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
> + * @npages: number of entries in @src_pfns
> + *
> + * Flag device folios that were successfully migrated to RAM before finalize
> + * unlocks the sources. The migrated state is stored in the physical folio, so
> + * it survives later folio splits and a subsequent raw-PFN eviction can skip it.
> + */
> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> +					      unsigned long npages)
> +{
> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		unsigned long nr = 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (src_pfns[i] & MIGRATE_PFN_COMPOUND)
> +			nr = folio_nr_pages(page_folio(page));

You could omit the 'src_pfns[i] & MIGRATE_PFN_COMPOUND' check as
folio_nr_pages returns 1 for non-compound pages.

> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page))

When this called from drm_pagemap_evict_to_ram this could be a coherrent
page. I'd just drop the page type check.

> +			drm_pagemap_page_set_flags(page,
> +						   DRM_PAGEMAP_ZDD_FLAG_MIGRATED);
> +
> +		i += nr;

You could drop nr and just make this:

i += folio_nr_pages(page_folio(page));

> +	}
> +}
> +
> +/**
> + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
> + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
> + * @npages: number of entries in @src_pfns
> + *
> + * Skip source folios already migrated to RAM, identified by the migrated flag
> + * stored in the physical folio's zone_device_data.
> + */
> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> +					   unsigned long npages)
> +{
> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		unsigned long nr = 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (src_pfns[i] & MIGRATE_PFN_COMPOUND)
> +			nr = folio_nr_pages(page_folio(page));

Same as above wrt MIGRATE_PFN_COMPOUND check not being needed.

> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page) &&

Same as above wrt device_private_page.

> +		    (drm_pagemap_page_get_flags(page) &
> +		     DRM_PAGEMAP_ZDD_FLAG_MIGRATED))
> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +
> +		i += nr;

Same as above about dropping NR.

> +	}
> +}
> +
>  /**
>   * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
>   * @devmem_allocation: Pointer to the device memory allocation
>   *
> - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
> - * migration done via migrate_device_* functions.
> + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
> + * migrate_device_* helpers and does not require the mmap lock. Device
> + * PFNs already migrated to RAM by either migration path are skipped.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -1148,6 +1255,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		goto err_free;
>  
> +	drm_pagemap_skip_retired_pages(src, npages);
> +
>  	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>  						   src, dst, 0);
>  	if (err || !mpages)
> @@ -1178,6 +1287,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
> +	drm_pagemap_retire_migrated_pages(src, npages);

Since we retire the pages here too, should the
__drm_pagemap_migrate_to_ram also call drm_pagemap_skip_retired_pages?

>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>  					DMA_FROM_DEVICE, &state);
> @@ -1308,6 +1418,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> @@ -1360,13 +1471,18 @@ static vm_fault_t drm_pagemap_migrate_to_ram(struct vm_fault *vmf)
>  static void drm_pagemap_folio_split(struct folio *orig_folio, struct folio *new_folio)
>  {
>  	struct drm_pagemap_zdd *zdd;
> +	struct page *page;
> +	unsigned long flags;
>  
>  	if (!new_folio)
>  		return;
>  
>  	new_folio->pgmap = orig_folio->pgmap;
> -	zdd = folio_zone_device_data(orig_folio);
> -	folio_set_zone_device_data(new_folio, drm_pagemap_zdd_get(zdd));
> +	page = folio_page(orig_folio, 0);
> +	zdd = drm_pagemap_page_zone_device_data(page);
> +	flags = drm_pagemap_page_get_flags(page);

folio_set_zone_device_data(new_folio, folio_zone_device_data(orig_folio));

?

Matt

> +	folio_set_zone_device_data(new_folio,
> +				   (void *)((unsigned long)drm_pagemap_zdd_get(zdd) | flags));
>  }
>  
>  static const struct dev_pagemap_ops drm_pagemap_pagemap_ops = {
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 95eb4b66b057..ebbd3b0ddf36 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -2,6 +2,7 @@
>  #ifndef _DRM_PAGEMAP_H_
>  #define _DRM_PAGEMAP_H_
>  
> +#include <linux/bits.h>
>  #include <linux/dma-direction.h>
>  #include <linux/hmm.h>
>  #include <linux/memremap.h>
> @@ -339,6 +340,9 @@ struct drm_pagemap_migrate_details {
>  
>  #if IS_ENABLED(CONFIG_ZONE_DEVICE)
>  
> +#define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
> +#define DRM_PAGEMAP_ZDD_FLAG_MASK	DRM_PAGEMAP_ZDD_FLAG_MIGRATED
> +
>  int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  				  struct mm_struct *mm,
>  				  unsigned long start, unsigned long end,
> @@ -373,7 +377,9 @@ static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct p
>  {
>  	struct folio *folio = page_folio(page);
>  
> -	return folio_zone_device_data(folio);
> +	return (struct drm_pagemap_zdd *)
> +		((unsigned long)folio_zone_device_data(folio) &
> +		 ~DRM_PAGEMAP_ZDD_FLAG_MASK);
>  }
>  
>  #else
> -- 
> 2.43.0
> 
