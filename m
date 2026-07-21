Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25407C44524
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 00:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC1E10E236;
	Tue, 21 Jul 2026 00:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bV3PV+pE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D143F10E234;
 Tue, 21 Jul 2026 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784593619; x=1816129619;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hOWNIElnQ5MtSoqng+zS54wjpm8fKwAIrbPlXeWE0Yk=;
 b=bV3PV+pE4uJmydpqM4iK+O1FijXjIdgx0KfYB5tpnimOX0lBgIpvw4VG
 dJidWbmNuzvcAsKivcVQn4Y7vu95daeoARJH6Kw0Jlc1XKI3HrTkYBwm0
 i10v+C+EsW6SbiClyO8Vjn9HAAgZR6hIf4kruIHP6yqPgXVuftbQsE05K
 rSw3lhiKQMTL25/zSIF06QfvILVX/JiiYenzsOqXQdDJTpzYBS9YH5nYz
 0TSJ9NlZRwqI0IMacIkn1rVzUKcnEguENjWLziMEXHYniyQasapGN32ZL
 wrtcZ52fYbLlroH6U/rhTPJkFKe8JNYV+p+cd3CKODl9ZbPQBX4gSxGEU w==;
X-CSE-ConnectionGUID: o0QXmSEaTzWVVJ3i5IuxQQ==
X-CSE-MsgGUID: oqESNJl7TVW+S/35jsOqMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85280546"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="85280546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 17:26:58 -0700
X-CSE-ConnectionGUID: VFfwE3sSQve+Go/FDgHuPQ==
X-CSE-MsgGUID: N/6NhVUKQXqcyyIPhnalbg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 17:26:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 17:26:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 17:26:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 17:26:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH0oTKA4IDwmhL08YJViiw3vPzNNHIQ84WJQHPXdGKse6dObCpXLc1yh+d/oX6p58tINVpUKyErltDXJGHeS1Si+IO8rks3G+wxuJoBYqV2REI+MWL0OVc34drTtd7zLXSv0p0w3grmF/uT55jesRO8zBhFVeXFoX8eVFVCKwGKhx21cgJXYIWn7RIuwKxRY6eTDCIIP+D4XLFOSoKtaPT9IhLRCYuWnXCzTspccsbuumBKZFs4vpueJn1R08N+PqZot43NpefC9NW3209UT8TheMVgO6HQpB5jPxqmP8hrYglBWCIXhJY2XQnnFAdXQ8hDrmaIQ/pVafv96SsWbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng2WBxRXFZq4CXSW9cEVRr1J4aqd5f0XvY/efG23erk=;
 b=e7/uNcTqEAJfEdWF2n87PEryFaFe1cqqugDCTcO8z5IEIOtH6bpTa7PeJ4i1UAc2GS7ijdcVYDuad0a2IxmrKLv9jw248JIv9Qdl+30+nz9LtOuXSDG3TsXD0v327SNofDniHaIpTL3UinC6mTis8MlgUwH2kUAD4Opel0YSXTr6xFkt2kJWHHvqAyQl3Q6GqkgzrGiqCStsXPEGlRWdZR4PvYt6gmG8G2qvx8TWEVj+5Thbt/sSwnKn78/hjkI2uQ/uV/9VnRd6WKOaURi++Gz46XQKj5RpOJrKvL3VPQDK6BxM639HC6EpppBnWfO6new9L7uXSZfS8W7jh/KqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 00:26:55 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 00:26:55 +0000
Date: Mon, 20 Jul 2026 17:26:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <thomas.hellstrom@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/gpusvm: Zero HMM PFNs before scanning ranges
Message-ID: <al68zIUmM9JS+Woq@gsse-cloud1.jf.intel.com>
References: <178406967042.1113483.2116704310277917086.stgit@skinsburskii>
 <al5u+iJi1h6FhKsu@gsse-cloud1.jf.intel.com>
 <al6zslgo1Hm-l6oP@skinsburskii>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <al6zslgo1Hm-l6oP@skinsburskii>
X-ClientProxiedBy: MW4PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:303:86::18) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: f693f928-17e4-43b9-ea97-08dee6bec49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: imAo/9KnLeARM10Rg1/xAaUGeP6T9monxh3cGzBGIaNo2Q0zfY0JLa5FA8R8qi+9KmPN+xIKY//Lgi/n6poJ+KehNJ52lXCuqLbve48VLADNfCNpNYlTajlqCdfgs939FVe8oDuNGhCRS6DfsQkwNaM5fvGGfMH3h+b1IYzicx0T6hNWSV8d/kDO6DLkevRUO4gxmLOCpFVbvGByRi+UHuwb/7cTOBuNGR53yUxqiHESGnOASyC3G5a1KFW8Crsi2aS7yGHr+EoYehDCm1EtMbZgt99JDtKFPIbAWx/iAn8xwi9hiNLRvO/PxyWT3vG4jolxc92vJ9Go3YRoEnt49i9JYytUgqySqfogM4WSjhi+yYdU4d/8ZMAr7BlC9k+Ni3qEwRiXn1AYUfi+T9I7YnctUfAybXlG4WTNyz3hK6KPMLpceJzhdV5R2Ua6bosaSy3b471dixIT2S8xSulfTPxYz2++Kq9D3hptBOCrx8E4rQF2JunG3yJ3pKNbHDSWM8mjdrHCmvopY71vR9P0xY6s1opfmwpFlAtATk1GsKPj+z2y4G/utl8KndZ3dAPXhriK8m6Gn2R/+Lnv98wh4Otf6LttOLffvkM15GC/x7rUbiWp90Q4hv9bI1optx0uAQrvsaBXtgUkgxjSXfnUksim6he8aDg47t5Dp/Us904=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2GVF3otWqR8hULeLHcP7US9W6VFkY6Fs8Y6+QY1hWbAqQMoRF65+TAZcIsI?=
 =?us-ascii?Q?NwrEt0GtfYDpugmYCAo/TRzsqrLjWaPbptrX4B84T2EG9sAF9CXnmfPNdr3Z?=
 =?us-ascii?Q?jd6dAiMFgflcyC8eDrepvA5xM6kCO4r+Xqivyyv4nMTO2xfuF2AOJKw8idsC?=
 =?us-ascii?Q?eeVaTQ3mgx0qDehTgGrKNvO0g1aRZT2P8dBcDE/chRGbmqkX66Sikq73EiEN?=
 =?us-ascii?Q?eOdxmLB8p2KKCTnb4+JmaiLIRrIJMPGS3o7NkzX3nY60ovk0Qf19AAAjcdbL?=
 =?us-ascii?Q?sAEPeGN9yQifYlU+j/v8BrnJDvwhZsEvByubN4flMvY7S4hhCEYQhwRmclIp?=
 =?us-ascii?Q?J8Q4cPsv5emFsk+dSL++VkUKHrjlBzhJP/4BdFXdv+Dd/AZ+jxcDy2OJ/qb0?=
 =?us-ascii?Q?4lHCdbd4caThuifqbRYu4ZD5q9dK+Wu3DlOkUt1vPG0tnYFt/tIYE91lJjxk?=
 =?us-ascii?Q?gWdu6M+tx44MAekjPFshF63DH4IbSV+JJoLK8mR6kY5o7osF7Xcnf1xF0Zv7?=
 =?us-ascii?Q?k8TNf66a+HUB3Y2B7EBm52bBJWw8YhVyWYvVIZR3WLltz4ev2/7mVV8fRQE/?=
 =?us-ascii?Q?lO017RKhP9Pl9iPT+Rgyzw3UEK2eTfsre0wgCNFVDcl9fH1fzY8vSzzsEEfc?=
 =?us-ascii?Q?otidfGeEyIiUS74gWslbgvniVl3yoiPTQtIfTSTxU1JAWYnBROfkZZz60hsH?=
 =?us-ascii?Q?kXDX4kIFm1vuY1GQt2HJpUlHnI94TiYLRV3ijI2IOFB2ZVSWd8rKm6QsXibK?=
 =?us-ascii?Q?6vSOTVEKX5R69RWYXBikWkBYUPOvIkBc9MwpFDW5JoZx6oisWBB1F4/hIZ4F?=
 =?us-ascii?Q?gT1T3wirgkp9waFLPHZW6k21bZWHp8SI6loSs31EMd1WiUIqKj5RGv91ZF44?=
 =?us-ascii?Q?gBIfIXHXHm/AqRlTUW3gzQIuXVUK+y2tHj+p5r1b5xFMM59EGb/K2J9s00Zg?=
 =?us-ascii?Q?uHEI3ZETAVxN75TzHpIEESUP0pt8HQTi+yJUnsk8bE21c4dNz61i5Qaoc5/j?=
 =?us-ascii?Q?4Y1vPPdLD6Swsj5+GckAhoKt+uULvCebeyAI8yyXCLaqYfPMm7gL5otan7qh?=
 =?us-ascii?Q?1q4080dSWgK1eKvQZK35fdi6lMIlpw2YM4ePJrnjjApi2Ed5JzXgULz0ZUYX?=
 =?us-ascii?Q?YSzq2jkc0FuhnybtOAeDN8yPYDzlyFILMWSKPpSjAw82T6Hfudygn5pVXqLW?=
 =?us-ascii?Q?u9SUd8G95NfYcIJtoFABOvCHtkrYd8kf8pLnvkYLzQ7M30D5XUgdZNHwk8zi?=
 =?us-ascii?Q?rPnkI+cji1rvOUHtgpG8wrnerlZ3nTu/1hsCdLWRiid1MufkNwtRnxxG8mtT?=
 =?us-ascii?Q?NMGEU1/tLOSdQ/QWbRY7X/cGhnJnGavuQT+7jfYbjeuNYKAb2lihsSiLYrIw?=
 =?us-ascii?Q?GWcC53PiaLfUGacFMf7CFT9u/a+bEo7Jb+d0fuaBTjoqL6jA/9dTz8kp/yWs?=
 =?us-ascii?Q?xDPHCL+ltI/B4asQpIKLO3njgLnSQab87Y3zJ/02c/1lDnjGRZzE6hjJq6Og?=
 =?us-ascii?Q?WeozRDxFT4xghjPsMO0X5N/oc2YB2KPAAKqwAiRdbJZ3RdzT13Sm2Bcp7XgB?=
 =?us-ascii?Q?didqf8YMIGy0gzx42fCHbcBge4UpzjqaYq0Apazn0ZdSN8dvGsSbNIcgjGfy?=
 =?us-ascii?Q?riOtRyj08MqHkIPWU0tfjCXeNQAcLMHVCDodrbQ7Pv56YT8DW2yfJJmmaORc?=
 =?us-ascii?Q?2PmGWQ+S6aXGsSeAquNizxLSB1M270eQEdreEgBfX8VBYh04uuLBvdHqjpJc?=
 =?us-ascii?Q?3jU1myNhiPEB2tBO+ouFgahANhcQUDc=3D?=
X-Exchange-RoutingPolicyChecked: LdOvs0SEU6bDh7TvjRv9/f7rF6q9nkRSted+oWPhmVsuvdNXNyDF5GwQ86wiOro7pnJ+Eb+ssCm7veqWL+4zrNwqOkksWMBY7c41RIWfu5mIhqPjXJgM3g4av0hLDKH+tCSfMOhayKThquW9a1Isw9LWjh7xyYbPsMCHLvYBzs8cgRo6rsF3Jp0SMPU2kzLl2s24q6OEu9yojlgyuvintuKO4JfpgG1y7ddf5FCqp+kGrXFZkrBW3/TqHGbhvCpwDNIHVVpETxkhLRiXKlD38ZbaIM68YtIESDsHNzblsZX3/4fapIEomBR2oqFJkIb0Ec+uAg0lbo4IEi0Ky+tcXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f693f928-17e4-43b9-ea97-08dee6bec49f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 00:26:55.2302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOdKMXac0rKd48uJrZFczxDB2Knj+qyX1cPEkS6rmqcU73owLZU1A0MpAJEDsMLb8bQWjX5QfTxKziYZOL2ziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
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

On Mon, Jul 20, 2026 at 04:48:02PM -0700, Stanislav Kinsburskii wrote:
> On Mon, Jul 20, 2026 at 11:54:50AM -0700, Matthew Brost wrote:
> > On Tue, Jul 14, 2026 at 03:54:32PM -0700, Stanislav Kinsburskii wrote:
> > > drm_gpusvm_scan_mm() asks HMM to report the current CPU page-table
> > > state without faulting missing entries by leaving default_flags set to
> > > zero. The HMM PFN array is still caller-owned input/output state, and
> > > the framework may preserve input bits while filling entries. It is not
> > > safe for the caller to hand HMM an uninitialized array and then treat
> > > entries without HMM_PFN_VALID as an authoritative unpopulated result.
> > > 
> > > Use kvcalloc() for the temporary PFN array so entries that are not
> > > reported as valid start from the documented zero state. This prevents
> > > random stack or heap contents from being interpreted as HMM PFN flags or
> > > PFN values during the scan.
> > > 
> > > Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_gpusvm.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > > index 1a8bb83bd28d..c8f489d7ff7e 100644
> > > --- a/drivers/gpu/drm/drm_gpusvm.c
> > > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > > @@ -859,7 +859,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
> > 
> > Two other cases in gpusvm would need to be fixed as well:
> > 
> > - drm_gpusvm_get_pages
> > - drm_gpusvm_range_evict
> > 
> 
> No, these two are fine, as the faulting is done with HMM_PFN_REQ_FAULT,
> which either populates all the PFNs or fails.
> 

Ah, yes clearly misunderstood the issue here / didn't read the commit
message.

This patch LGTM:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Will merge to drm-misc-fixes shortly.

But then drm_gpusvm_check_pages() should be fixed too as we don't set
HMM_PFN_REQ_FAULT there either.

Matt

> The only case where PFNs must be zeroed is when the caller wants to
> collect the mapped PFNs. In this case, the missing PFNs are simply
> ignored by the HMM framework.
> 
> Thanks,
> Stanislav
> 
> > The offending patch is likely the one that added sticky bits to HMM:
> > `git format-patch -1 285e871884ff3` for above two cases.
> > 
> > While I think zeroing here would be the safest approach, it does not appear
> > to be a problem in practice because the sticky bits are only used by
> > `hmm_dma_map_pfn()` and `hmm_dma_unmap_pfn()`.
> > 
> > Also, there are several non-gpusvm cases in the kernel that do not zero
> > the PFN array either. So I'd say we should either fix the entire kernel
> > in one pass, document that pfns must initialized to a known state, or
> > leave this code alone.
> > 
> > Matt
> > 
> > >  	const struct dev_pagemap *other = NULL;
> > >  	int err, i;
> > >  
> > > -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> > > +	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
> > >  	if (!pfns)
> > >  		return DRM_GPUSVM_SCAN_UNPOPULATED;
> > >  
> > > 
> > > 
