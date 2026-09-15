Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0BEC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172B210E20B;
	Tue, 15 Sep 2026 22:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YQBSeMJR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D8D10E0EF;
 Tue, 15 Sep 2026 22:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789512700; x=1821048700;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=X+0FK8OT2PjhefoI5L4zXoqLw5l4jyKdtf50y7iPCmU=;
 b=YQBSeMJRe6jXDP7/dVijE46Ui5TEGSA5qILH9UqzI0UVR1cJIVx8A06G
 aNEKkrnfmz+AYn2RTSKnV5UV9XQH8AMI89V0NdzA6Z4VX8Kbo2eWxPxUA
 NMwwaOV5uKyqk7q3VmXvZA+O5QYXbgQINq6UfU9RT3LoZawakIFjtB1jz
 fPpbQlmc+EvF7Rj9Jo/Ci2RcOR1cyXieOMjJs0zwm/M4O8uzoMvb9IGHx
 jnIEJCDnKw5DNaZGtR6AjhDGFwahPDW+AOR5afFXZJLsuzjYATlK8Pvq+
 lvPpBkXsUrGr47bhmMw5TLdGg8uWWb/BFLrRyWyrYmmgx/w6UDUpAYjS2 w==;
X-CSE-ConnectionGUID: RhtYyuFgQ5y6b9gTTotDfA==
X-CSE-MsgGUID: RSjl4ySrQUqWkq4OzlEsAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90025553"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90025553"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 15:51:34 -0700
X-CSE-ConnectionGUID: 2IbZ+6OQSnq0XydSqdFa0g==
X-CSE-MsgGUID: lVrrjLmcTFKCt7qLXcFtXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271364714"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 15:51:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 15:51:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 15:51:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 15:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzu+0XcIRQBK7IvSF8mJdKxXGGvKtZJWwb6HYxer76pXC86jpY8q0vjRUMmQ51ultnQP/bCmDaW0UDHh05xWTDFbRA+2gG/872AuM3fI3YCVsolnQgMgyi7KWFzQGwtOC/ZVd9fnAlcLt88BSGwOm4Dj41Y1snDbOu9Qbq4dcaTI/Nlt+/O68p7NFN6svrm0iJWiLfejpFDTLFhajgYXdw3eD4uuukxj41951aLxcGru7tzWfHpf+rpajgRfFTUQkrpfVMMcXNkbRPdRabtBPfH0XbZaFG49d2UyrUkCRiXQF8PqynclRwMdk2Hl4UqDeLLaSdfOq8wVXglLdo0uaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vnor5VvsUY+d1QMHBnAJegGJbhCLJIoymakgP7f7bU=;
 b=gIa6oSika4Aec5G9gggDpnJOyYeefPggD0wj8d9o/6IlB0TSgdYK0s2EfP5YeMuWeZOCRThRJN2aVe6uji/ygdd6ckDOZFMzcusDIunYxYHwG+4tinShaOcH7P4kgeWupyZ7qSIQpotiCJWR2VUg0wVlF3jXYApxA0zXyL4jaqyDceoQMMtHb5M6eVFFZjXuJ02iwkah0yoMbz+i34eaNJ7VdVnOHaIW8g3+h8f0o8aDSY3660kCg4QHUayShshhOkAwYrj/d8u1xK+TyZznfvOvEtXeaRt2UNPNxE6MyqqCKWYP4mPjusoc/1tVaIOoG8uLJgtro2mxZYZXfGSHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 22:51:31 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 22:51:31 +0000
Date: Tue, 15 Sep 2026 18:51:26 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Nikula, Jani" <jani.nikula@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Roper, Matthew D"
 <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Message-ID: <aqnL7lUojj9jm8q_@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
 <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 5580f3d4-1ff7-44da-e7db-08df137be253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B3HkI0hN4j3j/8RNL3XdiNAYrIhXwMa9kQzXrMoSn0Yu8WSN1O/K55QKkFUiAaS5PeHKJdwHTR6j/OUuu/bYO+8i8Irn2fzjT5O8hYHAD0DC37poiMREJcEyDkHYlHFHELj56yLchhUB7JL9yF3aXJOviyUILGj8hLMTTn9ClmqX4ckgDhpOK6lpnHVK93yGUig3nRLF+hsMPiE4PaByqBUYT9tg49PusYlM2VC8NM1azBWcmzpXkOSHbOkoxCfwpGT2I8GxhBVgWSuHzAvPFCS9S6QRLEImnrvAhjCXXVeDoZDCuy0kiVp/htYtp63ArWnYtxHyuZOz35YxOwA+BZzUBC06wYX/JIsxdm+bRXtdgaRof2W0GVHKIuws+gZLGHmcmt3RYhQBwQvqB4swAkii2cCM9+mAeBNZVN0lIe3Lv962RpIHHq2bzzPMgVfQomAw09xy83krB6dOeh7c8VLjxw93LN3RVEzUPN6Nv5+rFa3UpOuqsHIT60UAgQsdr34Wglp27Yomi3+rD20jb/jEqSOuANqrrYJn1ArvtwcJ9MMb17Ue7s+XddiQJEX4e16PWjCt4IALkMpjtizW2+zCpP7vD5gjJQt0XjFQHFUXyIVL6jf4N0kiiXUhTvpF9lwKItl1Ae4uwhIIi6k92r58QoksZl0JsTm8tc5etFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NdgkNIHT0gE8eDyNszjrtgvcVgVdma3W7SCxcHYImziuraQhl4uk16hMZAs?=
 =?us-ascii?Q?VqKu4DT8E8Rru9JniysCy2BeWEA3U2GzH45T0+aJhtEu0hIdy9OFj7/wBvme?=
 =?us-ascii?Q?eC7uhZuP8rLM/M7l4gz/WjDR20R27WabmhSCYxEie4abL9G4nulHoWfc78UF?=
 =?us-ascii?Q?jrjVW4DTc9kYqt1TImKeMT4n1GP8SRObduzzPk3UxF43BEL3lOgP+51tvCh/?=
 =?us-ascii?Q?uNR28+Qpa0FfFaVbgixgq1iU2CdsQ1ojiYX5UPCFxnuTpqCtEp/1BWZMiyzo?=
 =?us-ascii?Q?YUZtRgw4jJVEwhkq/j155kIf1iqme8sqnftAxZf8Alsciy+5cjyJYGKfsi8Z?=
 =?us-ascii?Q?ypdglKpHeMpk4jDe9ahgOivFc3XHtT7FO7taXsz+a62s1T6/zK3uecG7tg/o?=
 =?us-ascii?Q?BPCa7k84zLCGUFP3ovT+rJ8P4fdIuGp6SW/r7uIK5Qx7o30Bon1i0VB5i6Xf?=
 =?us-ascii?Q?pstNRUUwWfVl1YjX+9UopArVGE0ysRz6zMXv27MsZLLSqVfcFxxHsev4R7AM?=
 =?us-ascii?Q?PsHbqPWaf1GQj2BKw3RbMn2v6FuSFmcXKbacenDMKORx0yzc48dCuDtjysSB?=
 =?us-ascii?Q?LnDaK1iPikg0lPvdHopuDhDnuKHvbTusMw8AU67QQtNPmbB4kwuj8jvXzosT?=
 =?us-ascii?Q?xcCh1uFwewCdNj+WjscVfjMWGaOTcOkJGgu1/8MVNHJom9mXz2RyRK5/Zyun?=
 =?us-ascii?Q?mNyfcKjj2oPqHPtXV7SctW4HNYcgfuQYHclPErPowDCrKM3f+Kb11bcOWnu7?=
 =?us-ascii?Q?pymNQrKNQFLT1Zps0F9cf6/M7koRaTdfnFLfxMt9ByoXHCIHZ0cHvT2QXbCQ?=
 =?us-ascii?Q?wMSf9jFnADFu4jhMncepe/CnZ5Nmeq5al6KHaziLOV/PtpdEYii/RQASre+K?=
 =?us-ascii?Q?w0NKSC5RVUTGdIWq7ChgX9tdzMb8T/veFyP8yYE5AK12bWjMEZCy3bDweWOQ?=
 =?us-ascii?Q?sBagsxXDcIVCokFq2HfLQM0ZQWElakPcQGiZHh9m3/oPY4bVKHx2dVaDlEVJ?=
 =?us-ascii?Q?N3Bs2W1TMevMa61+BO/IC+QfTNY4fb1z3oyzufLnBS+e4iP+tzWLHmh3Pt8T?=
 =?us-ascii?Q?QA7OPQrsOKnKkLxs8HWDIv33DFwzpwQkSVsODmXNKzYxpXvVw8gCH2VA88e9?=
 =?us-ascii?Q?VTGJ9o0l+sCtajUWCCi+EiYinjJbkjFugi5xkORbXFdLC5BVphOHjJ9eGgwB?=
 =?us-ascii?Q?hNUqt7LTUqP5i6n3Kw4A0MKluCY7TspxzGG0oGHXkQ4FRGRwShMefnkuaHTM?=
 =?us-ascii?Q?zmghw5kqV3cRhAjEx5vxrYdR12sKDQASufLHiG4oD6hkq5jbi0ifQXuxyEq5?=
 =?us-ascii?Q?p4vT19xohsQD9SwOzOMNXuDrqLc8JiZl7VZ3KDssbuoLI+kqsV9NolnYhj9r?=
 =?us-ascii?Q?2kBcpD60+RuBgCO2j7Ltk8pWKNSgpxeGlbkqmHWzbmVZmtzk79NXY7CkncmB?=
 =?us-ascii?Q?3CcNmA6aq0FTVl9zvc4qDqwFeX+sSNPUuKYKkYlmUnRGt0BlbRE40wjYuER1?=
 =?us-ascii?Q?1Yo2RVpsgARJH2G2h9IDmneA17a2AuU/9JJ0HGL3nlHSeio6lh3EhFkH9N/g?=
 =?us-ascii?Q?IgMllDJ6MUHqIDdMoZsq7o3Dxkaw71+XM/M4Gg5F1MLzl2fM69X1go5KhNLg?=
 =?us-ascii?Q?f9fGrbZydkWsbBatWeuJwStDQA45dDBBNG9kdi2LYuLQBRFs5+kwlyh3zwkb?=
 =?us-ascii?Q?xF2+K5CH5glvRorfHFmVSS5UiFD6KoYun+Dt8oj/tOAec0f+psneyQqSIlz6?=
 =?us-ascii?Q?iwNqNyUncQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: j3l6WDbEofPyxdUeTFy9p+OAKu3Feiui1VYIITbwO4qIVVIeSeDpjeH6hZXDJrixm5P2UrfdcixNxKD5XDFW/GvhBGPAu+amQR90snblcQGeJr4/me9xCPMyBr/jpJWD14kPHTR0dPcleBMT7RUFueOtMusIOKaviN0dCEe58yFNIkm0is+K0XfR3pT9nU0pHidsLM2CKCK+DPxdg0RwFWKGG3orKtNh3PkzzPCM9QR8j3byTvjOi1RT+iGUywAHVtwH8Y4iZbkOusroPDIS73I7hOGBTSoxSOOBe0oZSz+NUQTF5JYdhkxVFgBLttt45Aze6j86T06Nx9qxFPSI5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5580f3d4-1ff7-44da-e7db-08df137be253
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:51:31.1626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJgaLvLhTuxF7ga/hxC86eRp8pZFkgGBeTeVfeNakereBiyzPrVbizHKj9xj+fd6fNcZsMENUHqlvmsjAlo2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
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

On Tue, Sep 15, 2026 at 04:00:54PM +0000, Teres Alexis, Alan Previn wrote:
> On Tue, 2026-09-15 at 10:34 +0300, Nikula, Jani wrote:
> > On Mon, 14 Sep 2026, Alan Previn <alan.previn.teres.alexis@intel.com> wrote:
> alan:snip
> > >  int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val, u32 timeout_us,
> > > -		   u32 *out_val, bool atomic)
> > > +		   u32 *out_val)
> > >  {
> > > -	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atomic, true);
> > > +	u32 read;
> > > +	int ret;
> > > +
> > > +	ret = poll_timeout_us(read = xe_mmio_read32(mmio, reg), (read & mask) == val,
> > > +			      10, timeout_us, false);
> > 
> > You probably do need to let the callers pass in the wait too. 10 us wait
> > with a long timeout is going to be pretty bad.

agreed

> > 
> > 
> alan: okay - perhaps i can make every caller pass in a polling-wait thats a fraction of their wait time.
> (as a starting point since i dont know what's the expected behavior of every caller).
> so perhaps something like "timeout_us << 4" (i.e. 1/16th) but pass in 10 us if its anything smaller than that
> (i.e. smaller than 16 usec).

I think we might be complicating this too much..

what about something simpler like:

#define XE_MMIO_WAIT_MAX_BACKOFF_US   1000

...
-             wait <<= 1;
+             wait = min_t(s64, wait << 1, XE_MMIO_WAIT_MAX_BACKOFF_US);


Also the Fixes tag is not the right one... the bug was there before...

> 
> ...alan
