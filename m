Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E07CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 01:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FD710E6A8;
	Wed, 10 Jun 2026 01:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GM1Zcu3K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA67B10E201;
 Wed, 10 Jun 2026 01:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781056455; x=1812592455;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=bDjFIwLAqHz5+iczg/npaxZ67yaYn3pJKlxikYIE1Ww=;
 b=GM1Zcu3K6P1pLOPdhJEAnqXaiu7JtxeSiO8qVLnJC8bZ98zec6xPL3Nb
 xfLxAwRS09JCQE7lBM99sX5bEFHkxZvFCX/o0ItCszseYNXVbIKd7B4EP
 QoiBWVkmFVeZmdXnzhkN/YiTTNAcwUV3dPmMyZglM+8GBPn/WXkXXDk/j
 8BHbNZfFJOcuOyt/1ZSpz/SxmVZA8uEwiJDvmdm92df9q8X5ucVoD2iDn
 tPxXWObJOoc3+iqLz6G/FKi64IQspZ77vofZeo1vQdC+5uD8ceVHhwsl0
 1nXDuoF2jLg3nVTSWZ0BOoBoYQLaeSMl+OOpL/N4grfSOpJ+Q4BvNNdWq A==;
X-CSE-ConnectionGUID: cQYBkmeBR22vwkezhXTGDg==
X-CSE-MsgGUID: mc7rsCqMT0iEFYEU+rmOtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85464783"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="85464783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 18:54:13 -0700
X-CSE-ConnectionGUID: 8O4neSNxQxW1LWQnICxAzQ==
X-CSE-MsgGUID: tqpaZYS4QtGDrwbhBq8+nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="284103872"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 18:54:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 18:54:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 18:54:11 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 18:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur+dJh5snkhn/nnnYF8MfPpBjjm2vOA4Kn8hTasJGBPfvKAhI/RcjmYN8i5ctL7OmBCtBrS7GtT6CQc5WbQDkl32zN9YuxzoxHBu+RUqQsI2fCCySyBObMAj/SP9Z/CC5nSvxSgvLGS8mwT85F8kpPqawpIDn3vOwY5e188Y7m2mx2yq4QC7yBNIDFhTD/C7ZcjwxIN5ucrYbE3m54wm4pfpLgsx3r0pY2KiOvYlNP7trW6IfXnl4b7m8lRBxu6YlIO9yqpSjqnbDQiF05IWs+nMWrL8OXnP0MSt8GXFUnUS7yTw3Y0W1/4gkS4vnrxcgyEy7GG0TNzGjI13MzpOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64E7TTbvPXPkBhk+SLRKRj2s0OX3M8UkFmXCsAP1k+I=;
 b=dfKYuiR6wIH0vIsto0pzWr9U4sTtAeaeflHEAAuUY4v/tq6/AVRMJkatGxJ3NkqiZZvGdBLMJgc0UwzFCiewKad1LzVocIluGUYdCqDr0JAxvkva2zcDgWRvEsluaqPweO7X7Q1tcl567GrJ4p3L/kcgKp6kMglm1V5W54OtWxg+uKI/mK3z9DuK/UBX/ppmtQIjcly6zcWad6FPCRivHZq06tJq340xwIsQyTg2Y2/aT9vbQ9EhkwEobm7Ki4jzAP27JffVL/GvnPZIIB8upxjxurnT45DdxJ7UAmCyqQ5lWW+bLAckRrzUG0LNc6YfOzlryunimJ/dCWbFre/63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Wed, 10 Jun 2026 01:54:08 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:54:08 +0000
Date: Tue, 9 Jun 2026 18:54:05 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Nishit Sharma <nishit.sharma@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <himal.prasad.ghimiray@intel.com>,
 <honghuan@amd.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] [RFC]drm/xe: fix cross-tile SVM migration mapping on PVC
 and harden ENOSPC retry path
Message-ID: <aijDvfAOMDOxrBEI@gsse-cloud1.jf.intel.com>
References: <20260609084003.70975-1-nishit.sharma@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609084003.70975-1-nishit.sharma@intel.com>
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffad0ea-fc80-4d4a-3fef-08dec69328e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ttIdC/lFzsIeRcjo9daSTj/t4iZjRt2v4W2qpCQURaPe0jKntFspachutMYXStpES31fKVDtpWch6mwUp9MlhMGRFZ+AEv7oCH2EcEyr1nYxhf2jMhCkAoWthEyPCoZ7hQtmM3ZcUqCW9bntK2/C1ld9ozDj10sqaweUC8lGKwXzavcLkJ1GsbdiAuBBeai+pvoznPy3HwgHWw3f2mdmvjgIPwYoW8FeEtzxALhjszBtXE0vzgGn/lfi41DjOtsIv0B5qdt8cvHb35LgPhwTgKnkK6r1VcxYJyyAGy39CGgzGtCLEphdxX3OBOXsa6NJU5FOTaE98/9N6NWOboe9IPgdcEkD/5oBw67XQsl4sHbzq9sSyJqMxuaS/9v4IyhFeNdfgSsntXC702YbJGyrC4vleXSgO5x1EacznXr458ouTPp+yDYX1DSS6zUUitl/U6tDjbBBxaCswFswO9CulTu3R8uxyrZJy8Juo92BxhjeqDNwSCC4ojFkVcixcWlVakaIUwYyE+QBUOCgoSmWuFz9kkiBU9fnV+Xkje+6qBcJqcPzd+k1zIPLKeIXgbkdxxgybmN/HEog7/RhoppUtznfY4hbDly4Bi98WaEIOX0iKAmfXSZmss6/AmPHWYPLww8YRe+ivGXqjwhNJIFIJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2UrRDkycUxzSmpSYk14RlNBdlRGUlBneXZqRkQxaHNSTHlkc0kwU2RiMWR4?=
 =?utf-8?B?clJSb3M0b0prejd3TnBHY3ZnZDY4R29IR0dTcmhwcGtvWGVkOGlUNFJFWG9u?=
 =?utf-8?B?RW1IMnYwNm5EMmltRGIrK1plZWcvU0NTSUdXaXlOY3hqYnYwZnhWS04zSU1z?=
 =?utf-8?B?OXZqQVFFOWJudVpRUnBTS3VOSjdHM3ArYzMwWGk5S2RYUHFlQVV3OGNVRmlz?=
 =?utf-8?B?WktJSG9oRkMwaXV1emNlL1hMSU9hTGkwUzhlVkNIMkhGN2JQY2NHM2tHVjlJ?=
 =?utf-8?B?b3lidVhiQUFQMWJ5SXFmZFlxb2lCZ1Aya3F0TWZZWmxPYW1zc1p3bmZNWXJD?=
 =?utf-8?B?NjNpWlZqcFVuaHNmWWhlaUxXeGF2eG0vd29ncGtBaTdPcGo1dWljUm44Zlh1?=
 =?utf-8?B?RVlQQXNBMFlYZURURTVPV1ZQVHdURW84RTVIeitWYUF1bFdsK3FhLzdFcGRm?=
 =?utf-8?B?S0kxWDdVN3duQ1FndVRkUmtrVmpab0VoemdFQ1ZBeXNPM1h3L2p2enJxU0Zo?=
 =?utf-8?B?WFluN3F6NUZ0eHdLUlI5VWdocnZhTERuNld5eVJPNkVvYUJrTHRuTUViU0Vt?=
 =?utf-8?B?Tlh0cXYzV0krclFuSW9VbEphTlM0RS9NWUprdTNEYXYwZFdlOXdLNStwVDda?=
 =?utf-8?B?aWdUU0kxWmtJc0JoSDVkZ1RYc04yUUltVENpWStMUW9uTVc2R2VWeHZPSC9K?=
 =?utf-8?B?cVpGUjgrUDZFYjhhOHJJWno1VGZZSUNreTNZeWRpQ0JzMHpmcVpDMW1VcEEx?=
 =?utf-8?B?Sm5DMlllZklPZEZpZG5tUjh6RVhBamN6OVFBa3pNcmRiUGJHWlNmTXN3RWUv?=
 =?utf-8?B?UU9BVkJ4RUNXQTF0azgrRmsvWGMxQWlGN2dBbWM3d1JpZjV2MndheGRYSnNn?=
 =?utf-8?B?dDNDSWNYOUZXR3N6SWJtYVBPTzlOQksvR09oRDdBTWh6d0UvTDhJMVF4Y28r?=
 =?utf-8?B?TlNtb1hlK2duNHRaNW5RSFdmaDVuc1kxVnJISHNsc2U1clVOUE4zVFQ2WUJ3?=
 =?utf-8?B?eGt5WXJnak1rRFltazVodUNiRG9EeFB3WjBnMUZZdUt3aGZpSHAxcnZhUDBj?=
 =?utf-8?B?aW8yUEZrMWtNUGtkMjRlMzl5Q2tHY04wRm03dzBzYzlnek52ditxdUE3T05P?=
 =?utf-8?B?Q3NQcHhEOHdKWE16ckYvQlQ2Vjd3VjV5eFZvUVg0NUhWdSt6Q290SFNWMXVL?=
 =?utf-8?B?NGRKa2xHRzNCS0t5bjV4T0xTc3RRRXo1bjN1MURSZGd5dG9tQUlaaUI0Yldw?=
 =?utf-8?B?NkdnNnRCdmhHaDR1QzFDS0oxNnRGZjg1a0dwRnlIN3MrYXY1enBHSkwyK1dI?=
 =?utf-8?B?RGl1bkNKNEFNZ2FHcHZEOUVkdjREcXdySlJXTGdWT0VERnNOSXljdFgreWYw?=
 =?utf-8?B?SHZDUEpVYzREOTFGbG0weXJqNHhmdXhkUytJUkg0R3JQQ3ZwWGdBSUE4b2ZF?=
 =?utf-8?B?Sm01b2hNSlNhUjJ2bHZwZUxRL0pZczVQbXhRZlMweDFvNi92VTdZbjVEVjcw?=
 =?utf-8?B?eU5jVURlTDdMMEtUV0RTUFpSVEVRZ2dVb1lUc3cyK3NWME5ISnZVTlFPdEox?=
 =?utf-8?B?Yjl2WmttdStVMk5tdjVlbWd3ei93bitkUVZQYXhWYjgvL1I3aHRTS3AzQk1t?=
 =?utf-8?B?VnJ1YXNaSU03L2VsUkpNYzBQU09DZmp6UFQxMmF4d1BwV0Vick5yT3JBTmhB?=
 =?utf-8?B?S1o0U2tIN1RJVlJJQ3JkUU9jUVdhd0o5SklRSlIwV3ZBUlNneEJCemN3alJ3?=
 =?utf-8?B?M294OC9kdFU0Sk9lTUU3akxXWk0wZW9vLzZPajZGakFtUTM3WlBibnlRa2p0?=
 =?utf-8?B?WU5KVlQ5YnlRVHpzRFYxejcyYnZtbDRLQXg5YlVpUGYrUWlYYXlSTjZZemtB?=
 =?utf-8?B?NTkrYnh4TTBGQmpQTXlCYm9PQXRWb2tKSno4dlB2M3FHVDdCeUtQNjNwOE9I?=
 =?utf-8?B?aERscVJHQjZkZEtQNlVSYlk0QmNMWFpoaytpSVJoYjJxNDdYZnBTWGV2TVdt?=
 =?utf-8?B?QThXbUV1NVovTEVkdnQ5Wlg3Ym9wTG5kS01DbC9RU3kvM2FJa0ZmZ0FvblhZ?=
 =?utf-8?B?bkVhQUpJWmJLWEozUU1sbzQ1U2VZRWllTnJLVkRWK21OVWpBejE1WHExZWVi?=
 =?utf-8?B?Z0NtcllWWXlzQ0U5eGsxUG51UVp6bUhPa3RXMDFpOTBwbStrVzZ3aVprL3hD?=
 =?utf-8?B?Zi9MK1VPWUl3UFZjTjlUbHFpMCs1dFlDYkNQSFVscEQ0anQ2TGY4R1RmdGdk?=
 =?utf-8?B?Z2JaelNqZ3lXbXlxVDBMN04za3pGUnR0TWRrSGxPZW9BTzJZMnFlWUFKQ0hD?=
 =?utf-8?B?N1c3RnJOeXpEUy91dTlzSTR3Q2xlbFFMSWpuQmFLZFRrNlM2RUtiQT09?=
X-Exchange-RoutingPolicyChecked: sE2b9VDRx+HGxmQxXOKa7s0dtUa6FKpQ1SzDKyCVeVaunPvjJtCIN60ZIFSLtSE4aukD5v2T67uJKbnYGPrR5EJeeg813PSe57qIue1oPmnwVR5uujn7CC4MEZ4n5ROOpuKna49LsoUqJANKc4ypurZ17UOjmj0ZLmJ7ypw7WteXSx+IbyB1C8wqfnOstlMUKf/5IougaH6EkDvLsdwCaTdg0QbvrxyhRMkQ6nXjQ/jQ6N2daCoeGGLaQFy5Rpqtiq+aVaJnFOrAKXNpRqGLnZ/8ocWovEkxVgUsDcj/l0VXrtSrbknOAs6uuQVdAA4mUIcyuqeSt0FG8iiqd1bElQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffad0ea-fc80-4d4a-3fef-08dec69328e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:54:08.3120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCQL41+1ixYmWplob0jfqV+yaq9N479HCp+ZzLnW+2gCMZLvx28cwaRyOMTgZp2ZBEQzvcvwYiNHhHvgoGHEOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
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

On Tue, Jun 09, 2026 at 08:40:03AM +0000, Nishit Sharma wrote:
> This update addresses correctness and stability issues in unified memory migration on
> multi-tile (such as PVC) systems where multiple tiles share a single device context.
> In that environment, local and peer memory paths can appear equivalent at the device level,
> which may cause cross-tile traffic to use an address form that is only valid on the owning tile.
> Under page-fault-driven migration, that can intermittently fail when one tile accesses pages
> currently resident on another tile.
> The fix introduces explicit peer-aware mapping semantics so cross-tile accesses are resolved
> through a valid peer-accessible DMA path rather than tile-local addressing.
> 

There a bunch of different fixes in this patch that warrent individual
patches which makes this a bit hard to review but will try.

> Signed-off-by: Nishit Sharma <nishit.sharma@intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c |  6 ++-
>  drivers/gpu/drm/xe/xe_pt.c    | 14 +++--
>  drivers/gpu/drm/xe/xe_svm.c   | 97 ++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_sync.c  | 13 +++++
>  include/drm/drm_gpusvm.h      |  1 +
>  include/drm/drm_pagemap.h     |  6 +++
>  6 files changed, 132 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b..e781cbdfa494 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -267,11 +267,15 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
>  				goto next;
>  
>  			num_local_pages += NR_PAGES(order);
> +			addr = dpagemap->ops->device_map(dpagemap, dev, page, order, dir);

Let me start with the problem statement as I understand it so everyone
here can align.

I believe the issue on PVC is that a single device has two pgmaps (one
for each tile), so the unseen if statement above can fall into the else
clause, which skips the can_migrate_same_pagemap step. Xe sets
can_migrate_same_pagemap to false, which results in a bounce to system
memory when the if statement is true. We can then correctly copy the
data from system memory to VRAM—this is a limitation of the copy
function that should eventually be fixed, but that’s a different issue.

However, this behavior is skipped when the pgmaps are from a remote tile
on PVC. In that case, we call ->device_map, which checks for local VRAM
based on a device check, and our copy function fails.

I think what we really need is to bring congruence between the unseen if
statement here and our ->device_map() virtual function. The easiest way
to do this would be to blindly change the unseen if statement to a
device-based check. This assumes that multi-tile devices can read/write
VRAM across different tiles using our copy engines. For PVC, this works.
I believe this should also work for future devices (though that may need
confirmation).

AMD is also starting to use this common code, and I’m not sure whether
they have a multi-tile/pgmap-per-device concept or similar cross-tile
communication.

Another option would be to wire in a flag via
drm_pagemap_migrate_details that controls whether the unseen check is
pgmap-based or device-based. Then we can rely on ->device_map() to
determine, based on the device, whether it should consider the device or
pgmap when setting up the mapping.

Let’s get Thomas’s input on this. Also, please include dri-devel on
GPUSVM patches, as well as honghuan@amd.com, who is working on GPUSVM
for AMD.

This part of the patch is an individual fix (I'll call fix A for
reference) and should be sent either as a standalone patch or as part of
a patch series addressing PVC.

>  		} else {
>  			num_peer_pages += NR_PAGES(order);
> +			if (dpagemap->ops->peer_map)
> +				addr = dpagemap->ops->peer_map(dpagemap, dev, page, order, dir);

With above, adding ->peer_map() doesn't seem like the right solution.

> +			else
> +				addr = dpagemap->ops->device_map(dpagemap, dev, page, order, dir);
>  		}
>  
> -		addr = dpagemap->ops->device_map(dpagemap, dev, page, order, dir);
>  		if (dma_mapping_error(dev, addr.addr))
>  			return -EFAULT;
>  
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2669ff5ee747..e0aed463373b 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -564,9 +564,17 @@ xe_pt_stage_bind_entry(struct xe_ptw *parent, pgoff_t offset,
>  					xe_walk->vma->gpuva.flags |=
>  							XE_VMA_PTE_64K;
>  					pte |= XE_PTE_PS64;
> -				} else if (XE_WARN_ON(xe_walk->needs_64K &&
> -					   is_vram)) {
> -					return -EINVAL;
> +				} else if (xe_walk->needs_64K &&
> +					   is_vram) {
> +					/*
> +					 * needs_64K VM requires 64K PTEs for VRAM but
> +					 * the 64K PTE cannot be formed: partial VRAM
> +					 * eviction or partial migration created a mixed
> +					 * SRAM+VRAM 64K window. Return -ENOSPC so the
> +					 * page fault handler can evict remaining VRAM
> +					 * and retry with SRAM-only mappings.
> +					 */
> +					return -ENOSPC;

This is different fix, I'll call 'fix B' for reference. Again please
break this out into its own patch for review. On its surface, this
explaination seems reasonable.

>  				}
>  			}
>  		}
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index e1651e70c8f0..150391c9878b 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -602,8 +602,39 @@ static int xe_svm_copy(struct page **pages,
>  			vr = xe_page_to_vr(spage);
>  			gt = xe_migrate_exec_queue(vr->migrate)->gt;
>  			xe = vr->xe;
> +		} else if (spage && xe_page_to_vr(spage) != vr) {
> +			/*
> +			 * On multi-tile devices (e.g. PVC/Xe_HPC), migrate_vma
> +			 * may return VRAM pages from different tiles within the
> +			 * same batch because all tiles share the same
> +			 * pgmap_owner. Flush the current copy chunk using the
> +			 * old tile before switching to the new tile's VRAM region.
> +			 */
> +			if (vram_addr != XE_VRAM_ADDR_INVALID) {
> +				xe_svm_copy_kb_stats_incr(gt, dir,
> +						(i - pos) * (PAGE_SIZE / SZ_1K));
> +				if (sram)
> +					__fence = xe_migrate_from_vram(vr->migrate,
> +							i - pos, vram_addr,
> +							&pagemap_addr[pos],
> +							pre_migrate_fence);
> +				else
> +					__fence = xe_migrate_to_vram(vr->migrate,
> +							i - pos, &pagemap_addr[pos],
> +							vram_addr, pre_migrate_fence);
> +				if (IS_ERR(__fence)) {
> +					err = PTR_ERR(__fence);
> +					goto err_out;
> +				}
> +				pre_migrate_fence = NULL;
> +				dma_fence_put(fence);
> +				fence = __fence;
> +			}
> +			vr = xe_page_to_vr(spage);
> +			gt = xe_migrate_exec_queue(vr->migrate)->gt;
> +			xe = vr->xe;
> +			vram_addr = XE_VRAM_ADDR_INVALID;

I think we resolve 'fix A' differently this part can be dropped, not
100% sure about this without jumping on a PVC device though.

>  		}
> -		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
>  
>  		/*
>  		 * CPU page and device page valid, capture physical address on
> @@ -1148,6 +1179,14 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>  
>  	if (range_size < SZ_64K && !supports_4K_migration(vm->xe)) {
>  		drm_dbg(&vm->xe->drm, "Platform doesn't support SZ_4K range migration\n");
> +		if (!supports_4K_migration(vm->xe) &&
> +		   (!IS_ALIGNED(xe_svm_range_start(range), SZ_64K) ||
> +		   !IS_ALIGNED(range_size, SZ_64K))) {
> +			drm_dbg(&vm->xe->drm,
> +				"Range not 64K-aligned for VRAM migration, start=0x%lx size=0x%lx\n",
> +				xe_svm_range_start(range), (unsigned long)range_size);
> +			return false;
> +		}

I think this part of 'fix B'?

>  		return false;
>  	}
>  
> @@ -1227,6 +1266,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  	ktime_t start = xe_gt_stats_ktime_get(), bind_start, get_pages_start;
>  	int err;
>  
> +	ctx.local_dpagemap = xe_tile_local_pagemap(tile);

This field looks to only be set (i.e., it is unused).

>  	lockdep_assert_held_write(&vm->lock);
>  	xe_assert(vm->xe, xe_vma_is_cpu_addr_mirror(vma));
>  
> @@ -1360,6 +1400,45 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  		goto retry;
>  	}
>  
> +	if (err == -ENOSPC) {
> +		/*
> +		 * 64K PTE not possible for needs_64K VM: mixed SRAM+VRAM in
> +		 * the DMA address array prevented xe_pt_scan_64K from forming
> +		 * a 64K PTE.  Three invariants must hold for recovery:
> +		 *
> +		 * 1. Evict unconditionally via drm_gpusvm_range_evict: the
> +		 *    advisory has_devmem_pages flag may be stale (false) while
> +		 *    VRAM DMA entries still exist in the dma_addr array.
> +		 *
> +		 * 2. Explicitly unmap pages after eviction.
> +		 *    drm_gpusvm_range_evict clears has_dma_mapping via the MMU
> +		 *    notifier ONLY when a migration actually occurs.  On a
> +		 *    second recovery attempt the pages may already be in SRAM
> +		 *    (no migration, no notifier), leaving has_dma_mapping true
> +		 *    with stale VRAM entries in dma_addr.
> +		 *    drm_gpusvm_range_unmap_pages clears this unconditionally,
> +		 *    guaranteeing that drm_gpusvm_get_pages takes the full HMM
> +		 *    path and returns fresh SRAM DMA entries.
> +		 *
> +		 * 3. Use goto retry (not goto get_pages) to re-lookup the
> +		 *    range with fresh dpagemap and device_private_page_owner.
> +		 *    After eviction the notifier sets tile_invalidated so
> +		 *    xe_svm_range_is_valid returns false and we proceed to
> +		 *    get_pages.  --migrate_try_count becomes -1 (< 0) at
> +		 *    retry, skipping VRAM re-migration.
> +		 */
> +		range_debug(range, "PAGE FAULT - EVICT PARTIAL VRAM RETRY");
> +		drm_gpusvm_range_evict(&vm->svm.gpusvm, &range->base);
> +		drm_gpusvm_range_unmap_pages(&vm->svm.gpusvm, &range->base,
> +				&ctx);

The drm_gpusvm_range_unmap_pages shouldn't be needed - the notifier
should handle this.

> +		ctx.timeslice_ms <<= 1; /* Double timeslice if we have to retry */

I don't think the timeslice needs to be increased here. This only used
when races occur.

> +		ctx.devmem_only = false;

I'm wondering for 'fix B' if we could just avoid trying to migrate to
VRAM if our range is less than 64k? I thought to code already did that?
Can you explain condition for 'fix B' being required. I'm having a hard
time reasoning when the problem occurs.

> +		ctx.devmem_possible = false;
> +		ctx.check_pages_threshold = 0;
> +		migrate_try_count = 0;
> +		goto retry;

Part of 'fix B'.

> +	}
> +
>  	return err;
>  }
>  
> @@ -1695,6 +1774,21 @@ xe_drm_pagemap_device_map(struct drm_pagemap *dpagemap,
>  	return drm_pagemap_addr_encode(addr, prot, order, dir);
>  }
>  
> +static struct drm_pagemap_addr
> +xe_drm_pagemap_peer_map(struct drm_pagemap *dpagemap,
> +			struct device *dev,
> +			struct page *page,
> +			unsigned int order,
> +			enum dma_data_direction dir)
> +{
> +        dma_addr_t addr = dma_map_resource(dev,
> +					   xe_page_to_pcie(page),
> +					   PAGE_SIZE << order, dir,
> +					   DMA_ATTR_SKIP_CPU_SYNC);
> +
> +	return drm_pagemap_addr_encode(addr, XE_INTERCONNECT_P2P, order, dir);
> +}
> +
>  static void xe_drm_pagemap_device_unmap(struct drm_pagemap *dpagemap,
>  					struct device *dev,
>  					const struct drm_pagemap_addr *addr)
> @@ -1742,6 +1836,7 @@ static void xe_pagemap_destroy(struct drm_pagemap *dpagemap, bool from_atomic_or
>  
>  static const struct drm_pagemap_ops xe_drm_pagemap_ops = {
>  	.device_map = xe_drm_pagemap_device_map,
> +	.peer_map = xe_drm_pagemap_peer_map,
>  	.device_unmap = xe_drm_pagemap_device_unmap,
>  	.populate_mm = xe_drm_pagemap_populate_mm,
>  	.destroy = xe_pagemap_destroy,
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c..d2aa888f2d03 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -346,6 +346,7 @@ xe_sync_in_fence_get(struct xe_sync_entry *sync, int num_sync,
>  
>  	if (q->flags & EXEC_QUEUE_FLAG_VM) {
>  		struct xe_exec_queue *__q;
> +#if 0
>  		struct xe_tile *tile;
>  		u8 id;
>  
> @@ -354,6 +355,18 @@ xe_sync_in_fence_get(struct xe_sync_entry *sync, int num_sync,
>  			for_each_tlb_inval(i)
>  				num_fence++;
>  		}
> +#endif

No if 0 in code.

> +		/* Count fences for main queue */
> +		num_fence++;
> +		for_each_tlb_inval(i)
> +			num_fence++;
> +
> +		/* Count fences for main queue */
> +		list_for_each_entry(__q, &q->multi_gt_list, multi_gt_link) {
> +			num_fence++;
> +			for_each_tlb_inval(i)
> +				num_fence++;
> +		}

The above code here is a different fix - 'fix C' and should be done in a
different patch.

Also worth noting this is fixed here too [1] but since this part of
larger refactor that will take a bit to merge, fine with a isolated fix
going in ahead of [1].

[1] https://patchwork.freedesktop.org/patch/707885/?series=149888&rev=3

>  
>  		fences = kmalloc_objs(*fences, num_fence);
>  		if (!fences)
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 8a4d7134a9a7..6f03111fc8ef 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -250,6 +250,7 @@ struct drm_gpusvm_ctx {
>  	unsigned int devmem_possible :1;
>  	unsigned int devmem_only :1;
>  	unsigned int allow_mixed :1;
> +	struct drm_pagemap *local_dpagemap;

This looks unused aside from being set. If this is needed, move above
the bitfields.

>  };
>  
>  int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 95eb4b66b057..414a8a19bfe7 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -87,6 +87,12 @@ struct drm_pagemap_ops {
>  					      unsigned int order,
>  					      enum dma_data_direction dir);
>  
> +	struct drm_pagemap_addr (*peer_map)(struct drm_pagemap *dpagemap,
> +					    struct device *dev,
> +					    struct page *page,
> +					    unsigned int order,
> +					    enum dma_data_direction dir);
> +

I don't think this needed if 'fix A' is done differently.

Matt

>  	/**
>  	 * @device_unmap: Unmap a device address previously obtained using @device_map.
>  	 *
> -- 
> 2.43.0
> 
