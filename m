Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B24EC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C904A10E528;
	Mon, 21 Sep 2026 18:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mdNr0d7F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6EE10E0A5;
 Mon, 21 Sep 2026 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790016538; x=1821552538;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=C9jOh+AeVVH5DB8jV6Z065OJNYMikQqlTyuNNL1soMs=;
 b=mdNr0d7FongJezYNrcmnu5TmocQ3dNtw02Xb2+psbArh45I/VjO1oFOu
 VsVau89j9U7rA7kuyknSgiRM/7KtprkQRgx99QKk87PUUliZnGLQ1DCji
 0HA1krMdUDWrkVHPQJuTsNXhBnp2Y9CV/ngJdG6kfpuX/r5rj0aSCdZ9j
 1CNsue9/8VXPzjDUHP3kNNG/ITfVx+ZbrFHau63Y+Y5KsEJRWac5+3NLs
 v/Tcc+G1a4TknrMteaM45sZYslwFUDqWf8A51QBrs1FpXlMGbF3klCQF6
 GuYXNsTir87uTm3YqNuthzmoDvD/Axgz+VRMpN4ewujDtkLB0197ox6F5 w==;
X-CSE-ConnectionGUID: 3W49XCQnSDeiKxv8Bu74Gw==
X-CSE-MsgGUID: O4MgoiIVR0qOz0wzYSxYFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1064496"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1064496"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 11:48:58 -0700
X-CSE-ConnectionGUID: HXe0NyWaRxGGp1fLWx8qag==
X-CSE-MsgGUID: HEqTVOiqSpK021bYg3AL6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="269291821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 11:48:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 11:48:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 11:48:57 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 11:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvqfiuIFTwL5whF7g9ttIYr3snJ4Qlo2sA8+DtJ44Dp9W189Ci0G4MIhVSc8mJBDqc+L0r9GVT0CNBP/fFgaBH2sCKXycNMOBOgAFjJ14p8TuiBNnR04tuSj+0F/4sasU3+Co7ESE7zWIPs7EsYzIgW6s4qhialzChKs3+yuPedMneC2zoNPFCoQijxFXU9VUGRc4heFzgzvmKDZS9fPpIrjr/buqLupx4L67CwCFHTssRFQ7X8/4BnSxSA+I5h13lWryHUNcyNeTD88eM0eEhjb1JcPvEebTngMQl3PABx9WEow1Y8eBGVJiHQre54JAyan6RTpN4pLyIPBHquq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqU2ny84xMkjHdv59EbnE9AuVoIDn34LYWgEZyrZCOg=;
 b=aO9f4Xf8FBM7msSGKDX5WLbcbLBMbit5XrAa0cpT2oIvaX9mtuk8uO9UFNBeIkXiYkniHl+aCWsbSWt0usBwEIqRofgFhGyUZePqtuEBE/bbZfZcs6aH1A3QWRh4OXN4ORQqoJQd92LdlMxpVO2JZNtbmxafVyU3vPTlj5kVk+xHqUj5lKm6VCkETaTuY4+7h7+Uv3c+aAGNSLcCCnTecf4KVrfZCjXI9NPH0zzJOObQJQiXEK3caiUZhYKyUlG/skHgrFijw0Rwfwpb5rjYaeqjTDAFxypd4sdirVFfvMmRI0rM3A+o7W7/fThjrwCKLQihejc+8sxKZVHDHq9Qpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS2PR11MB236486.namprd11.prod.outlook.com (2603:10b6:8:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:48:55 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 18:48:55 +0000
Date: Mon, 21 Sep 2026 11:48:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 3/3] drm/xe: Implement Wa_22016122933
Message-ID: <arF8Fbk7evath6oT@gsse-cloud1.jf.intel.com>
References: <20260921182121.308217-1-talesam@gmail.com>
 <20260921182121.308217-4-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921182121.308217-4-talesam@gmail.com>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS2PR11MB236486:EE_
X-MS-Office365-Filtering-Correlation-Id: d321f149-8066-44ca-7d45-08df1810fcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 8wH8zEmwT4ReyA+CU21GxLj1n7KfLoH4+V/XljG9iSnuHTL/u7zhCDYbEyZtPjES6pdbzebYotl/P6RfwdiUUOa6h6duhDqgi8E7rmX+oqR3dT1AqC4fPi3LEHg0CoBresrFxRsA6bssY3mW73UCtGaXjEpwtdmGD/6jdKES/PnuZZq2DxE1xv9wc8k6IdsTw///LdMyPoObkvseD3mNnbVkag0Z3Nc+1ed+9N3Phwg3YXSC7Ub6V/zVongoDcpArbXfxFecUBjpn5nxCoGBaDjz7Tjs05SzaCFOvAD5Mn/Eo5iEypzU8nceFv1wSc+OpFxzI0cBmKG29RgyPNWkAYond/5OBKj2h689RHuE1eRaSmcyjbZSg+PpDwcc5ZbswrguHYf7FrzChUWnTVRAKGy7hZQEY6MXib3JUlzGYcOEHgEsw/spqPVbg83nxHslT2TtLrriw1SCoNIw0QwX/YKAXPVp1Ct0uWZDQupgNfE4hwBBu+5xcMBcsnquOKUE/DYXRnsuS5t8NBLgZaRqJWF5HthAI0YJDL2Dmx6CE1QM41eIs28yK1vTnkmwu8MJg7bjFLkaOQhJ6fn+/C5Rmqqgnlyl2f0XTLZhTxvyTGpQB+s9xPHU+kHQ3G1laUhZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cHkxHAhw1xrmtgK3MrN9ZDT8EyjjfKLS3bMVNpXy1TLtpoos6leaReutCn?=
 =?iso-8859-1?Q?z20zfjPxZScu8W3EsAl5dIOcFLld6cDildZsaELVK7PK5IZLTHSZn+Zzp1?=
 =?iso-8859-1?Q?tHiwVubA/BnFGTugi61+gI8Oru3as6QE2hWt3EB+rLMKroECJK3m3MfPxv?=
 =?iso-8859-1?Q?Ho6y9t24WcKS7vnXhFSqkDvs/Qp9Q81YgYhrByWgiMpzFnhgf9nQoBXtH+?=
 =?iso-8859-1?Q?ivNz02qbHKucodaqzZVYxtTVHaOiHweMYjpzRCcIhZ+PUVud/GUAqXeFng?=
 =?iso-8859-1?Q?jJlkSkouELSwTip/tErUwiWr9VHNUqU9lD0fV1mbNzacrtHJ/qK2unO5JP?=
 =?iso-8859-1?Q?kW4BiMIqNzRRD01NS4Igx0fYo5pzqpLy4VZVCag/UJ/0uYjH3lCzD2sAXD?=
 =?iso-8859-1?Q?d0erWQi00VQVAbAgqEfc+HQHUPOnGOlHoB2yuC75LFgaachHDSu8sQQysP?=
 =?iso-8859-1?Q?qHwN8xXIuEycMl93hxD8fiYe6XCms5r1F6KfQqWxitR3vFEbGvBUm0e7Mq?=
 =?iso-8859-1?Q?0gH/IOzQU6EHF7GCTKBZ/Ab3kZ2tvSbxGnR3d/WQUn2D75gXSV5SudEQD1?=
 =?iso-8859-1?Q?B5k39ojrPcAguupq1WUBlnVuQTYdnVWVUCNdcPCd8qe13DhDQ2WlHKtDdx?=
 =?iso-8859-1?Q?ZpSvetplpY6TZxxdck9C9V2iEzqO8aApo9RHsiSlVIUmCLg1wShGFQIBen?=
 =?iso-8859-1?Q?RZAmGltV6jE+IwTyxgMeWx4MYyeFC5omsEnWvwQm1QGJK0kvDNNCy/cM4C?=
 =?iso-8859-1?Q?CJoQjJ2T1QP7J3uNJNmM0nc/HoA55z8A+RacpKOE92k7TptPLz6c1YqVjo?=
 =?iso-8859-1?Q?WdV8BKeqGXQL1CQWDOtBJMHPu5h+RpbN5PTgMfp4Z6vtbPsrGnZRMzZ+GS?=
 =?iso-8859-1?Q?I7Fc3AYMAYr8EwaXD5vnXN/4JDQDxk0K/bfS7DOKxukGhEfp5szrM5Zlge?=
 =?iso-8859-1?Q?TJ/RYbUnwaVkOjwbMNrrzVBSHbMK8Ff1hH6q87tTgU48WHA9MnY0V572SK?=
 =?iso-8859-1?Q?buU3MQYi2nwfw7jwA6O/HEI8CZq75nJBdLuFKWQy7iIoqaaSEWUFeXvHQ+?=
 =?iso-8859-1?Q?fguYpngI3l3Mf4xDY+AlVZkrjxeshfOEycKW+D9JrKWe2sfH9AO/KuliTr?=
 =?iso-8859-1?Q?M63/xjtWKDocPgVX8zBrA63bnt4YB9JMijyv9Shtqa5uCO0cNbF6BreWCa?=
 =?iso-8859-1?Q?Pa7dDuIXdiFlc3zfS/p4HFZOqoREJiiJ2FySO8tQfA+MvyzuWBe2hhysP7?=
 =?iso-8859-1?Q?OXKt22AkGDjv0H9XStZVmPbjtyVkl0xNz08trxQmxHmSLRiW9cHA3weLdf?=
 =?iso-8859-1?Q?fLvRcOiWcgdUR3DdoM8akdGZZYVQJfwStjkuRZbuSHGfDouEel2yxBJBju?=
 =?iso-8859-1?Q?8owh41OCDVbui6ObPbvj0hq6XKJ0UjLaycHR3yRQiEb5uplqKbCC0abNDc?=
 =?iso-8859-1?Q?OlRlG2WDlHzzHDcz3pKAFYl+PaTed68yrF0QKuzLZ3OxW7pj1PrSi4J7Rp?=
 =?iso-8859-1?Q?lG5A5HmN8FBCziB0NyzNzilDfJM3gjtrEelUPtu6eJEYXiuB/zaTnjwOn2?=
 =?iso-8859-1?Q?efel2p8MNs1h0nUkMX1gylXiUPRcfomaPUej/XOKuonkVGrVYd0F2+oz0F?=
 =?iso-8859-1?Q?iBV+x8JMV1Z2+fUZthoV07GbBc0g56PDEHYJcfj+4tqTUQmzr5HqwRCfP4?=
 =?iso-8859-1?Q?eQjihC80WD/0eYUiPfiKRMA3W2QGq8CX5W8D/KerN9M+xSuSqrqfkamq+B?=
 =?iso-8859-1?Q?QET/4XEpdhp/WNh1tzwSoCqCR5Xg7TruEDa7nxv5bWWz7qZmlTjgalGccM?=
 =?iso-8859-1?Q?2kksl6+YKA=3D=3D?=
X-Exchange-RoutingPolicyChecked: eIRoyMWPzcphO8HzjMbXxX5drrCuyqMI6VtFFhjm31l8zADLVU7ZUtaQR8BAaK377D+Z76MBMDlMDKHSs++tTcDQ+47xlMdpDZExlcUDfkVR/wvy/7gkCvQhO+G3aCml/i7BP7QQIzyb+DV0rycMqCyxIzGz4HGF0cgbvLjFsHl45Pkc4neC5zcpeGrudpgEaBdqzbGzCifaOwO2V3uT6aq5H1ZA+jC7BCbtWBp42WnjPhI9t4Kk5xFQE5Zed7bSmuq0M+IIHYZnrCGOgOjNHBF3YmTQTHjZ7mZxMLecjIVpVUlOhU09nXeQ6GtojGthk/Hh7PQFZLt7NK/gTx+QXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d321f149-8066-44ca-7d45-08df1810fcfe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:48:55.4682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBGk1gWD4IxoFUWB0f7Pa0U6lpkmOfLjUjc1Hrdo1UutuLtLY+2gOh3TWfo9eXkoSYjj6JNMg/vbniwHs7ELsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR11MB236486
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

On Mon, Sep 21, 2026 at 03:21:21PM -0300, Tales A. Mendonça wrote:
> On platforms with a standalone media GT and media version 13.00
> (MTL/ARL), memory shared between the CPU and the media GT's GuC must
> not be mapped cached on the CPU side: the CPU can otherwise read stale
> cache lines for data the GuC has already written.
> 
> i915 implements this as Wa_22016122933 (see
> intel_gt_needs_wa_22016122933(), used by intel_guc_allocate_vma() and
> intel_gt_coherent_map_type()); xe never inherited it.
> 
> The visible symptom on ARL is TLB invalidation acks stalling for a
> near-constant ~2.3s: the GuC writes the G2H ack in time, but the CPU
> keeps reading a stale (empty) view of the G2H CTB until the line is
> naturally evicted, so the fence timeout at 2.25s fires first. GuC log
> decode confirmed all invalidations were handled promptly by the
> firmware, and only the media GT was affected. See Link for the full
> investigation (three machines affected: 7d51, 7dd1, Arc Pro 130T).
> 
> Making the mapping coherent instead of uncached does not help: with a
> GGTT PAT entry repurposed to WB|COH_2WAY the driver comes up and the
> media GT GuC runs, but the stalls remain (request-to-ack 2290ms).
> Uncached really is required here. Note that 2-way coherency is not
> normally reachable from a GGTT PTE (only 2 PAT bits), so that
> experiment needed a modified PAT table and may not reflect a supported
> configuration.
> 
> Add the OOB workaround scoped like i915 (media version 13.00, media GT
> only - MEDIA_VERSION() OOB rules only match the media GT on standalone
> media platforms) and apply XE_BO_FLAG_NEEDS_UC to the GuC-shared
> allocations the CPU reads from: the CTBs, the GuC log, ADS, the SLPC
> shared data and the engine activity buffers. hwconfig and the G2G
> buffer are allocated on the primary GT only, where the workaround does
> not apply.
> 
> Note that XE_BO_FLAG_NEEDS_UC drives both the CPU mapping (uncached)
> and the GGTT cache mode (XE_CACHE_NONE instead of XE_CACHE_WB), which is
> stricter than i915: i915 documents the workaround as WC on the CPU side
> and UC on the GPU side. A CPU-WC variant with the GGTT side kept at
> XE_CACHE_NONE was measured to be equally effective, but expressing it
> would require either a new BO flag or decoupling the GGTT cache-mode
> selection from XE_BO_FLAG_NEEDS_UC - simply swapping in
> XE_BO_FLAG_FORCE_WC silently relaxes the GPU side back to WB and the
> stalls return. The stricter mapping is kept here since it is the tested
> configuration and no throughput difference between the two was
> measurable; the extra plumbing can be added later if parity with i915 is
> preferred.
> 
> Scope is limited to the GuC-shared allocations, which is where the
> failures were observed. i915 additionally covers media-GT LRC/ring
> state; extending xe to match can be done as a follow-up if wanted.
> 
> Validation on two ARL machines (7d51 and 7dd1): before, 20-60 TLB
> invalidation ack stalls per day, every day, for weeks, on every kernel
> and on two GuC firmware versions (70.53.0 and 70.72.1). After: zero
> stalls in six weeks of combined runtime, over 10M TLB invalidations
> processed under the same workloads, across kernels 7.1.6, 7.1.8 and
> 7.2. The 7dd1 machine, which could not survive a day of media
> workloads on xe without a platform freeze, has been running xe full
> time since 11 August, including days with heavy video transcoding,
> with zero stalls and zero freezes.
> 
> The coherency experiment, the CPU-WC measurements and the engine
> activity coverage gap were found by Navon John Lukose while A/B
> testing v2 on an ARL 7d51.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> Suggested-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_guc.c                 | 16 ++++++++++++++++
>  drivers/gpu/drm/xe/xe_guc.h                 |  2 ++
>  drivers/gpu/drm/xe/xe_guc_ads.c             |  3 ++-
>  drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++++--
>  drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++++--
>  drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++++--
>  drivers/gpu/drm/xe/xe_guc_pc.c              |  3 ++-
>  drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +

One thing the i915 WA does that isn't present here is if non-dGPU the
LRC is marked UC - see __lrc_alloc_state in the i915.

Is that needed? AFIAK the GuC only reads the LRC though and all LRC
write are issued from hardware, so maybe the i915 application of this
W/A isn't correct? The fact you are not seeing hangs with this suggests
this part of thw W/A isn't needed.

Matt

>  8 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index c7f8bbd4cb9..3ab4cb9e496 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -1469,6 +1469,22 @@ int xe_guc_suspend(struct xe_guc *guc)
>  	return 0;
>  }
>  
> +/**
> + * xe_guc_bo_wa_flags - Extra BO flags for memory shared with the GuC
> + * @gt: the &xe_gt whose GuC the buffer will be shared with
> + *
> + * Wa_22016122933: on the standalone media GT, memory shared between the
> + * CPU and the GuC must not be mapped cached on the CPU side, otherwise
> + * the CPU can read stale data written by the GuC (e.g. G2H CTB writes)
> + * for multiple seconds.
> + *
> + * Return: additional XE_BO_FLAG_* to use when allocating GuC-shared memory
> + */
> +u32 xe_guc_bo_wa_flags(struct xe_gt *gt)
> +{
> +	return XE_GT_WA(gt, 22016122933) ? XE_BO_FLAG_NEEDS_UC : 0;
> +}
> +
>  void xe_guc_notify(struct xe_guc *guc)
>  {
>  	struct xe_gt *gt = guc_to_gt(guc);
> diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> index 61e3ee19a59..c4eca40d69c 100644
> --- a/drivers/gpu/drm/xe/xe_guc.h
> +++ b/drivers/gpu/drm/xe/xe_guc.h
> @@ -30,6 +30,7 @@
>  	xe_guc_fw_version_at_least((guc), MAKE_GUC_VER_ARGS(ver))
>  
>  struct drm_printer;
> +struct xe_gt;
>  
>  void xe_guc_comm_init_early(struct xe_guc *guc);
>  int xe_guc_init_noalloc(struct xe_guc *guc);
> @@ -45,6 +46,7 @@ void xe_guc_runtime_suspend(struct xe_guc *guc);
>  void xe_guc_runtime_resume(struct xe_guc *guc);
>  int xe_guc_suspend(struct xe_guc *guc);
>  int xe_guc_softreset(struct xe_guc *guc);
> +u32 xe_guc_bo_wa_flags(struct xe_gt *gt);
>  void xe_guc_notify(struct xe_guc *guc);
>  int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
>  int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index ff8eee3831a..abc7266fc6f 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -435,7 +435,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>  					  XE_BO_FLAG_SYSTEM |
>  					  XE_BO_FLAG_GGTT |
>  					  XE_BO_FLAG_GGTT_INVALIDATE |
> -					  XE_BO_FLAG_PINNED_NORESTORE);
> +					  XE_BO_FLAG_PINNED_NORESTORE |
> +					  xe_guc_bo_wa_flags(gt));
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 5c4733da385..5c393aa29de 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -376,7 +376,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
>  					  XE_BO_FLAG_SYSTEM |
>  					  XE_BO_FLAG_GGTT |
>  					  XE_BO_FLAG_GGTT_INVALIDATE |
> -					  XE_BO_FLAG_PINNED_NORESTORE);
> +					  XE_BO_FLAG_PINNED_NORESTORE |
> +					  xe_guc_bo_wa_flags(gt));
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  
> @@ -386,7 +387,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
>  					  XE_BO_FLAG_SYSTEM |
>  					  XE_BO_FLAG_GGTT |
>  					  XE_BO_FLAG_GGTT_INVALIDATE |
> -					  XE_BO_FLAG_PINNED_NORESTORE);
> +					  XE_BO_FLAG_PINNED_NORESTORE |
> +					  xe_guc_bo_wa_flags(gt));
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_engine_activity.c b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> index a782be57caa..729ce8ac140 100644
> --- a/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> +++ b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> @@ -97,7 +97,8 @@ static int allocate_engine_activity_buffers(struct xe_guc *guc,
>  
>  	metadata_bo = xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(metadata_size),
>  						ttm_bo_type_kernel, XE_BO_FLAG_SYSTEM |
> -						XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE,
> +						XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE |
> +						xe_guc_bo_wa_flags(gt),
>  						false);
>  
>  	if (IS_ERR(metadata_bo))
> @@ -105,7 +106,8 @@ static int allocate_engine_activity_buffers(struct xe_guc *guc,
>  
>  	bo = xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(size),
>  				       ttm_bo_type_kernel, XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> -				       XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE, false);
> +				       XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE |
> +				       xe_guc_bo_wa_flags(gt), false);
>  
>  	if (IS_ERR(bo)) {
>  		xe_bo_unpin_map_no_vm(metadata_bo);
> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> index 538d4df0f7a..7d006268ce9 100644
> --- a/drivers/gpu/drm/xe/xe_guc_log.c
> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> @@ -17,6 +17,7 @@
>  #include "xe_force_wake.h"
>  #include "xe_gt_printk.h"
>  #include "xe_gt_types.h"
> +#include "xe_guc.h"
>  #include "xe_map.h"
>  #include "xe_mmio.h"
>  #include "xe_module.h"
> @@ -624,14 +625,16 @@ void xe_guc_log_print_lfd(struct xe_guc_log *log, struct drm_printer *p)
>  int xe_guc_log_init(struct xe_guc_log *log)
>  {
>  	struct xe_device *xe = log_to_xe(log);
> -	struct xe_tile *tile = gt_to_tile(log_to_gt(log));
> +	struct xe_gt *gt = log_to_gt(log);
> +	struct xe_tile *tile = gt_to_tile(gt);
>  	struct xe_bo *bo;
>  
>  	bo = xe_managed_bo_create_pin_map(xe, tile, GUC_LOG_SIZE,
>  					  XE_BO_FLAG_SYSTEM |
>  					  XE_BO_FLAG_GGTT |
>  					  XE_BO_FLAG_GGTT_INVALIDATE |
> -					  XE_BO_FLAG_PINNED_NORESTORE);
> +					  XE_BO_FLAG_PINNED_NORESTORE |
> +					  xe_guc_bo_wa_flags(gt));
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
> index 097b075bd89..e0105222a2c 100644
> --- a/drivers/gpu/drm/xe/xe_guc_pc.c
> +++ b/drivers/gpu/drm/xe/xe_guc_pc.c
> @@ -1391,7 +1391,8 @@ int xe_guc_pc_init(struct xe_guc_pc *pc)
>  					  XE_BO_FLAG_VRAM_IF_DGFX(tile) |
>  					  XE_BO_FLAG_GGTT |
>  					  XE_BO_FLAG_GGTT_INVALIDATE |
> -					  XE_BO_FLAG_PINNED_NORESTORE);
> +					  XE_BO_FLAG_PINNED_NORESTORE |
> +					  xe_guc_bo_wa_flags(gt));
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  
> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> index dd69ad07f7a..30958b26a1d 100644
> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> @@ -14,6 +14,7 @@
>  16017236439	PLATFORM(PVC)
>  14019821291	MEDIA_VERSION_RANGE(1300, 2000)
>  14015076503	MEDIA_VERSION(1300)
> +22016122933	MEDIA_VERSION(1300)
>  14018913170	GRAPHICS_VERSION_RANGE(1270, 1274)
>  		MEDIA_VERSION(1300)
>  		PLATFORM(DG2)
> -- 
> 2.55.0
> 
