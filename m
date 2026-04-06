Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B3CFB5164
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D7210E2F4;
	Mon,  6 Apr 2026 21:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TaKrvooC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAAF10E2F3;
 Mon,  6 Apr 2026 21:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775512412; x=1807048412;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=E7E1iOfO12PNFuVWDyCBrUQb1InNsC6BaV9y84JpQU0=;
 b=TaKrvooCIA0Wt+Hue9doiGNXM4eisba2WsyaXY0+Fg4XRA+SBVKgCWwq
 s2Bw4wxbD9Kjow2quY29L3Ii1LMMMWfPYSdfg4tw+3nIl1z/phb3lAVsc
 onPEFXZ/lps+NWOeGcABDvlBFBgnab+YEodY9rIx1XmNZTp9XW9sSNjwE
 ZZAprtY3XUOeBmOXFzmQTWHD7WlYDjq9exiTdAZK4aBGtXgpiHLRDUBLk
 KORzr/DBJtMnHt1RsYNTYaqXENn/J50ehanOv+vqXd23SpmApcz945MM8
 JzVv3eupZ/LReS4Rd0TI4tkQe0D/T6J0rpf6DnYLA+gFydeBBJns7bdw5 Q==;
X-CSE-ConnectionGUID: 5kHMRK0qRuaoawaCqb5jHg==
X-CSE-MsgGUID: b343BBlCTzqpAhkqVWW4UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="86759433"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="86759433"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 14:53:31 -0700
X-CSE-ConnectionGUID: Y9d7i8G7QGi/sZuMtvMsXQ==
X-CSE-MsgGUID: m9GVbsIVSPi6UEwEZruxPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="221407208"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 14:53:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 14:53:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 14:53:30 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 14:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKEjo+jEmcd+Ko7wAJuMe3/w0T4uoiOFwAF4MzmWMLkCgYhSe5CIwB/wUknIRgrNFCn0ia3uUKQcetaaC2tUOC3HylwcwZgQrJopf6aF9mm/lc1+Qfyb9DWpDGk3Ndjx+KaZqtyQsu9IAr7Qm53B6tf+HIyLSwevzLViU9zKyEfQdWlMeuOz8vqybkJIm0VFoXnNSVKyH9BX460V1CoeX3fLIK13WQBYzOo/mS6BkVabsG2+d9wpcZfNLlXsbebKAqy87wciz5intQA3XVY8CeWHkcokY44goIrSbc+aEcH5tEatC/EgXJKqVxOvj0ys9zMlUJDtvyDU1r7CavhrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LR/27/fhMSIt7pRPuNhV3ISsy/2iABc2zoEuA2EanA=;
 b=gAQoKwb+be9MHN0EvO/tnAvBuiAHe0hsQeuvrteqVhMm248vNE/FoePHZSJ4j9YOI7MgpE+1j6+Q2q+A/GP7MWOhI7gA2dcBKCt2ihBdfDzOYdxCXe0sD0Elen0n4QVAaGWom2rf0m/rZnF6m+mJQYYe7fGlDCFC0nv9yDTaTUAMcKV6Gp9MwT79xAeRw2u2H/AuCB/Ig3f8xJrd1hlWIv0lNYdKsygSLAbbpIBmbh93N+eGMUNY8JOaopY+JlyNC+A5KhTBiz0b5nSa1ZB3jddvvfFbkl+q58Ypt+jKUCP1weT5sANtUxDbqT98z/37FOQDgpFIFocGjLnjXlUxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 21:53:27 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 21:53:27 +0000
Date: Mon, 6 Apr 2026 14:53:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Daniel Colascione <dancol@dancol.org>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
Message-ID: <adQrUl7GbSMyOmeU@gsse-cloud1.jf.intel.com>
References: <87341fsa85.fsf@dancol.org>
 <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3287823a-b4c8-4df2-ff6c-08de9426eec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Pd5LUg04Qo8H38HkxE6WDPFru12SH5Zh8cgcdteMbRbwFevvNV3Fo+vo1JspZGm62M0hgFNZep43q5lndeEGjl8q/MFOdsdVYXUIIuIYQtcRxPjcoWGWaM1ivk2+DQ+s5eY6qlOAsIww0h4yNhLbAvoiNcxD+JTRy1dmXmDsI6gLfgM09LA52HaASjFpbiPPJ9XlaOUtVBUF7LOI35JqSyhjge7Z53botWBju7B/yNcQ/Py6XF6WVw5oH7Ey6mhOiNGOK6kcun+v3q3DpVPscd3dQxQLNHgmYUzTfDM9Ej/XCfDLh2jpV8abnSpbb614L1baLs3pZ5HG1+O+m1etIwiRLPXv3nyZgAi1TLwExceR+fty/lszksjaG9OttxbnfrvKQlXG1RuwNFj3SPwnJlvtIT89wywOfISU47Uta1tWxgZrYOsNB8N4BQ94exuNyr2xma2/MxlKQ2yONu4lCQscFR22+DSaVcvZCmwCDgUjUSYjlyDTfFMBph4ddMKTPRQ2Z2jeZ8lhaKOQd3DaTdx9tLEaL4zMUrhRgv+Xoj6pHCQ+wdATNGieMXKprCtoaDo+kYPknGCycen387/+kisHhKyxMhX3LYfrhi2aWdJ6b8TOEeU0HpNQmMjlmNYkEeozpyJKwFRsWdyH4eH5V2V8vJsjY7v3n+mbRdi8FoqOHSGzGk03BJm37C2Mcl4j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVpSS9NbWR0L2VtclNhUmc5MUlScjMxNEJSc1pEOW5aaGozQ25seUVSSDZt?=
 =?utf-8?B?dk4rayswekdNY3FkaGE1Z1hhSURFVG5JdmkvMkhFWjJMcnl4VU9nVHR1V0xY?=
 =?utf-8?B?WHNwWXQ4ZnVJSjV3ZmxuQVFrK0ZYTklSV1BIdDZFODhvR1dNRnFjSk1qYkxz?=
 =?utf-8?B?QUhPSXJ0TWJJS1pLQXE4azNnaFpkQTM0ZGhweHUxY3BJWU83QkFubTY3OWQ2?=
 =?utf-8?B?eEswY29nSFZzMHRjUGtZK2FHRjgvNGs4clZmdGk1ejZiaVpSU0tzenVIdnF3?=
 =?utf-8?B?TjRISVJ5ajlsOFZKRUR0dTNEenJLQzk4TFF4T0krYndRTVlJMW1ZQTZiR0Zr?=
 =?utf-8?B?QXZubE9kcTZDamRJMmt4RDJma2xtVG14bnk0eDFJMVZGelZuQkF2ZnUzNHlN?=
 =?utf-8?B?bXk5YnArVXBhdG5CcU1JbjNzV3prSkZJMmNmQmNaOFN2RSs3VjI4Ynh5Vity?=
 =?utf-8?B?TU9VL3E2MHNnNGdZaW5lZ0QwQWw5cEttME1NSHpEOGhpRVJyY04vWGswclZn?=
 =?utf-8?B?VUdibFJhaWhPVFpGVmI1R2JJSTFRL1hjYVRWRHhwYUVYbS9SK250WVZIdlRP?=
 =?utf-8?B?OG0yOHdYRi9ubStPTDB4aytJY3U0TklsNFdnOHRNNUd0NTJvRlREWGNsZUxt?=
 =?utf-8?B?Qk5LeXQ0Ry9QcktWcERBNllZZHZsOTB1WjF2YXpTSytZQUhzRHdKMmxLaDI3?=
 =?utf-8?B?WGdqVFdycXlzcjlGTHlTZml5UldMc25sNlpKVjdJV1BHYStlQkJuNEdYUGdo?=
 =?utf-8?B?MVN0N1pIZXhjeXRyY2ROa0l0ZDVjcUJGejNOb2xjVWhBcG9pN3NQV3RNS2o2?=
 =?utf-8?B?aDcxMW1SdlV6WWlRTlUwWVlRNU1kTEFmck8vRmF6aGR1eDBGc3BGSmhnQXhm?=
 =?utf-8?B?K2h0Uzl6RzNNSjVrNWNGTTVic2oybThUOFFCZmdaMTBDYWRVdFdDem1LV0N1?=
 =?utf-8?B?V1BjNTRXdDBCSFI5dzluajJFVGVaSERCYkppdVBsY2N4bFhhVmUzN2xMV29W?=
 =?utf-8?B?VDFxSXM2dnZtWlVJU0RYeWRwRjZuSGR6MjkwZmZkMXVxNHMxWkM2YmFZNVc4?=
 =?utf-8?B?TlNZOW1RdnZYUi9BRnhpcjNSZnUzVU9ZTTcwWW5qU2VWaUFQY2FKenQyTVpw?=
 =?utf-8?B?ZU9CTWZjSTBtL3RKSkcxZW42S1B1ZHczSlFLSmsyMDFtNFJ5Q1J5SFdkNUk4?=
 =?utf-8?B?YWVnQ3lmMHZpNmNvTkI5U2hlUS83Vm9xYzRYVHVDRzdDRzVXWnZxMC95TzE2?=
 =?utf-8?B?NWk3MzhGSklybi9KL2JweS96VE5ZT2xWNEQ0Yml6d1VUTUpGcTdHSGprRDI0?=
 =?utf-8?B?c0xVK0d5TGIzTzFzcUJWeEF5T0hwOTdGN2QzZmNjM0xJbWRZVktTYkx0ZzZw?=
 =?utf-8?B?WURnNmpXZ3pYTlF0UDZ1Y3poNUFYSFZscXJTZ3BqWE9kazV6NXJyTCtkLy9t?=
 =?utf-8?B?WFFPdVQ3c0FzSFlTVTRNdyt0cmVGWmFXbzJodHJ6WjVXcHFXTmVHRjNNdzQr?=
 =?utf-8?B?M2NHdTM5dkJwSFdoU3pNSEE3M2QvZzM0R3Rudi93cVVaeWU1TlppNXpBSXc3?=
 =?utf-8?B?dTZ3MDh6M1pFaHRCRDNSM2VXTzlRUDVyNlV6OU82WVZNNHhSbm9RUmp6Q1Bv?=
 =?utf-8?B?T0RORGIzN2NkRmIyVFpoK1VmaENEeUJrY1FzQk8vQ3RNaDR6RmZFRVF0MFAv?=
 =?utf-8?B?OFRzdEh1NDZFQ2xBYXBvNmd3RGlzdXhZckdjZkhWa2RSay9YZmJhYzNTV2F1?=
 =?utf-8?B?a2lDamZOeUZEZFJkMW4rbVVKOHlRbDRHZ2RhUkR1d1RDVElCaUVYdVpya0Vj?=
 =?utf-8?B?d0FXTUp4WmViV3R4YkljRFd4VlppeUcxR21UOU1nb3RtNitzd3lQVEp6OXo1?=
 =?utf-8?B?WmVHYkRJSkJtdXMxRFh1dEhVQjA2L0dMUW9FTTdhdzFWUXczcm4yOHJCdVE1?=
 =?utf-8?B?MHRsQ295ZG14ZFkxbDRYTEhIRFFkNnZDV0NORjJla2RxOTJBV0JqZEZHTDFB?=
 =?utf-8?B?aVIrN1FKRjZpelZlK2VKNng0MnVTMTE4Y3ZLOThqWkcwUHJrTS81bG91ZEpn?=
 =?utf-8?B?d1FrWjJ3MVZqMU5ZUzR4eEpsT3dvS1pTOGw1NklyaHF0a3dWUGZkT1Q2eW43?=
 =?utf-8?B?L0hjOXdWUXV2cEJGdi9VNmExM0hGVEFYS0VNRWwrRDhUTmcyWWQ0eGxqcTVY?=
 =?utf-8?B?NElBTi9FVG5xSWRIdmVCczdhK0lONUlNeGswaEpSTzdSRnBDd0ZOZFhMTzJa?=
 =?utf-8?B?SmdUYzcveVJaTUpyemZBWnZKWUhNOUw2cHhiaXpMK1ZBOEswWDdralZ6elNp?=
 =?utf-8?B?ak1GOFphYjBSSXplV0wzOTdZT1QvQ2lBWko0Zm8yTjl3OUR6WXFjaE90eHpP?=
 =?utf-8?Q?9F8T6oXmDk3iMEu0=3D?=
X-Exchange-RoutingPolicyChecked: WrmGYOJ/bj0MNxxdJnhyYNZm+JzybZnmUUipLQ+GYi19OMVty4WRyhDmczWdd0QYPEonlr9C49Jzt+bdXc7qKJvjqvZxChkTZoMcfIArWFSBpDpHJgWOxE0Z4HR5fojKShA3iEOixzVWr5Uy2kR3KHvHQ9Ppkr0+wSg5CzldJBeafoMRvsu+J0kCmYDEc6bbWmNCxwSOR8JcarhVmK86EglYdP9n2caz7PXw00URoiUj7/VXZ8mP+0BJ48kQxjrmr4EK9XgUDXEOGfbLfo1l04DArks4lIBt+oTn9Nuf6teU6M2YYy/qqoZ9WgoUdSs86XqYKlss+ZfnIwMvVSSccA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3287823a-b4c8-4df2-ff6c-08de9426eec1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:53:27.0245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVoMPvY3pRgii5i3fDrAAB62gUq10icdyoRnBjljzLQL5D9eBg728HZ2fc4EnasY7pRYdKNqVf8b9MeAr64ETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
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

On Mon, Apr 06, 2026 at 02:02:44PM -0700, Matthew Brost wrote:
> On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
> > TTM seems to be too eager to kick off reclaim while kwin is drawing
> > 
> > I've noticed that in 7.0-rc6, and since at least 6.17, kwin_wayland
> > stalls in DRM ioctls to xe when the system is under memory pressure,
> > causing missed frames, cursor-movement stutter, and general
> > sluggishness. The root cause seems to be synchronous and asynchronous
> > reclaim in ttm_pool_alloc_page as TTM tries, and fails, to allocate
> > progressively lower-order pages in response to pool-cache misses when
> > allocating graphics buffers.
> > 
> > Memory is fragmented enough that the compaction fails (as I can see in
> > compact_fail and compact_stall in /proc/vmstat; extfrag says the normal
> > pool is unusable for large allocations too). Additionally, compaction
> > seems to be emptying the ttm pool, since page_pool in TTM debugfs
> > reports all the buckets are empty while I'm seeing the
> > kwin_wayland sluggishness.
> > 
> > In profiles, I see time dominated by copy_pages and clear_pages in the
> > TTM paging code. kswapd runs constantly despite the system as a whole
> > having plenty of free memory.
> > 
> > I can reproduce the problem on my 32GB-RAM X1C Gen 13 by booting with
> > kernelcore=8G (not needed, but makes the repro happen sooner), running a
> > find / >/dev/null (to fragment memory), and doing general web
> > browsing. The stalls seem self-perpetuating once it gets started; it
> > persists even after killing the find. I've noticed this stall in
> > ordinary use too, even without the kernelcore= zone tweak, but without
> > kernelcore, it usually takes a while (hours?) after boot for memory to
> > become fragmented enough that higher-order allocations fail.
> > 
> > The patch below fixes the issue for me. TBC, I'm not sure it's the
> > _right_ fix, but it works for me. I'm guessing that even if the approach
> > is right, a new module parameter isn't warranted.
> > 
> > With the patch below, when I set my new max_reclaim_order ttm module
> > parameter to zero, the kwin_wayland stalls under memory pressure
> > stop. (TBC, this setting inhibits sync or async reclaim except for
> > order-zero pages.)  TTM allocation occurs in latency-critical paths
> > (e.g. Wayland frame commit): do you think we _should_ reclaim here?
> > 
> > BTW, I also tried having xe pass a beneficial order of 9, but it didn't
> > help: we end up doing a lot of compaction work below this order anyway.
> 
> I was going to suggest changing Xe to align with what AMDGPU is doing [1].
> 
> Unfortunate this didn’t help.
> 
> [1] https://elixir.bootlin.com/linux/v6.19.11/source/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c#L1795
> 
> > 
> > Signed-off-by: Daniel Colascione <dancol@dancol.org>
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index c0d95559197c..fd255914c0d3 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -115,9 +115,13 @@ struct ttm_pool_tt_restore {
> >  };
> >  
> >  static unsigned long page_pool_size;
> > +static unsigned int max_reclaim_order;
> >  
> >  MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool");
> >  module_param(page_pool_size, ulong, 0644);
> > +MODULE_PARM_DESC(max_reclaim_order,
> > +                "Maximum order that keeps upstream reclaim behavior");
> > +module_param(max_reclaim_order, uint, 0644);
> >  
> >  static atomic_long_t allocated_pages;
> >  
> > @@ -146,16 +150,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> >          * Mapping pages directly into an userspace process and calling
> >          * put_page() on a TTM allocated page is illegal.
> >          */
> > -       if (order)
> > +       if (order) {
> >                 gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
> >                         __GFP_THISNODE;
> > -
> > -       /*
> > -        * Do not add latency to the allocation path for allocations orders
> > -        * device tolds us do not bring them additional performance gains.
> > -        */
> > -       if (beneficial_order && order > beneficial_order)
> > -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> > +               if (beneficial_order && order > beneficial_order)
> > +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> > +               if (order > max_reclaim_order)
> > +                       gfp_flags &= ~__GFP_RECLAIM;
> 
> I’m not very familiar with this code, but at first glance it doesn’t
> seem quite right.
> 
> Would setting Xe’s beneficial to 9, similar to AMD’s, along with this
> diff, help?
> 
> If I’m understanding this correctly, we would try a single allocation
> attempt with __GFP_DIRECT_RECLAIM cleared for the size we care about,
> still attempt allocations from the pools, and then finally fall back to
> allocating single pages one at a time.
> 
> Matt
> 

I think I'm actually missing another part of this...

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index aa41099c5ecf..19a163334756 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -154,8 +154,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
         * Do not add latency to the allocation path for allocations orders
         * device tolds us do not bring them additional performance gains.
         */
-       if (beneficial_order && order > beneficial_order)
-               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+       if (beneficial_order) {
+               if (order == beneficial_order)
+                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+               else if (order)
+                       gfp_flags &= ~__GFP_RECLAIM;
+       }

We’d need buy-in from everyone in the TTM community, but to me this
makes sense—only kick off kswapd at the orders we actually care about,
and only allocate at higher orders than those as well. If you’re running
a recent Xe Mesa version, the smallest page size we ever allocate in
Mesa is 2MB because suballocation in Mesa, I suspect most other venders
Mesa implementations do this too or are moving in that direction.

Matt

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index aa41099c5ecf..f1f430aba0c1 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -714,6 +714,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>                             struct ttm_pool_alloc_state *alloc,
>                             struct ttm_pool_tt_restore *restore)
>  {
> +       const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
>         enum ttm_caching page_caching;
>         gfp_t gfp_flags = GFP_USER;
>         pgoff_t caching_divide;
> @@ -757,7 +758,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>                 if (!p) {
>                         page_caching = ttm_cached;
>                         allow_pools = false;
> -                       p = ttm_pool_alloc_page(pool, gfp_flags, order);
> +                       if (!order || order >= beneficial_order)
> +                               p = ttm_pool_alloc_page(pool, gfp_flags, order);
>                 }
>                 /* If that fails, lower the order if possible and retry. */
>                 if (!p) {
> 
> 
> > +       }
> >  
> >         if (!ttm_pool_uses_dma_alloc(pool)) {
> >                 p = alloc_pages_node(pool->nid, gfp_flags, order);
