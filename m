Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391BACC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FF810E965;
	Thu, 15 Oct 2026 12:47:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB6D10E257;
 Thu, 15 Oct 2026 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792068431; x=1823604431;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bvXFTVevT/4siiiX7VkmbMmYCZE/7GqmyTvQg8diYYc=;
 b=le3R4SXcrCwVo4XNvwe4DNVo8ZqKAO+ybmI88pMGWTkJGH/Wy8bYR/Hs
 9ZgcgP2tFCD4ziq9+s4QVww6wtB4vLni+dC8RAjSqHumqXbRE2Bq8E81v
 hmoEBDXSUmMzs3adR0e6/d3mANDVDo1q5LUutMrbWGNGF3ii1Sdl9GhnE
 PqpGRchJnWXQzXPBeQ+J9uaxM4/bwGPGAhbf85FOy05zy5t3rZJK+WKLL
 zgiBj60+BpQ6RzSZVx9B6Cr/31p2Lgt8u+6ZWkhz8LrrjoiiKKW3yd+S1
 lJsopFJ6RZ8wqFURg7CNCDsJHxJ1JgCPDPUgEAycwnjpORiJPlgSRZhNN A==;
X-CSE-ConnectionGUID: 4Y44ywMnT3Kt88PuC/Xw3Q==
X-CSE-MsgGUID: R2FdiKzlSz2dai0v4+U3MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="837919"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="837919"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 05:47:11 -0700
X-CSE-ConnectionGUID: aIks1wlFQjK7vLD7HXIubw==
X-CSE-MsgGUID: 1CpjhlChSaqAWgFyZK56LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2152839"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 05:47:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:47:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 05:47:10 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFxXH+WvsTS+RviKoaMbj989CIRGnZF1fusUTUFi7iq4LrOwpwWrM6SDxBsdvHXNmxJH8uk2TYncHKSLRX19M4EGGVnfcjUDmInbsPvR+3kpg7RmMm9tKUMkWungF1H+TjCiId7i5mXY1CuBfem6E0dPVPDMJbqd9z1Tup5/v7bQmh7zuyy9UbkDLve4GvwrKrwUcsBtBO3S1BrZdAyjMtvJJWxMCwZkwhnWVKxem2B9qCWGBnBVSvdYqOQDkd9xOn376W3VRYXwuUbiIijHqQi0MxGj6JUxnu/Eb1iORJB57SI/yHdcvsMgx8o/xu7aKqRdKBGh4NH4IQJo10YS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd4kPVnDSKV9I1knnqvzy6Okou+LUAVYhigLvTNDcqc=;
 b=xfHr+BYbICytt/nGdXWf4VT5KafrN0YeV/s/vyunK8EGn6CmbiIwfltZwAvnoPCVt8/yWsjvtTJ41mnPAKo/Mcg2M8DJf8Vz4z/UIvUYAS94kKuRnet51TAjBxX2c1e0vI81MNkRDHRfApsdY/JBr19ZkZyKui5ftjbLKMUm3PRVeD/mLOZkkVmFG4XBMS9aZW0K/kauEXvHW68so3k79BZHbAp4PL+z5eRcsNgbxblu8fTv6z/u3eLs1YNJLQuMY5XYI2iFew09cyZ7KUp9vSDhy8uvnmj1rFCzb8EeuGvUiz4Lw39zg/O7zqNxKkaIu7Rv77zTKwNKe72dIxzY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 12:47:06 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 12:47:06 +0000
Date: Thu, 15 Oct 2026 08:47:00 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>, <karthik.poosa@intel.com>,
 Zongyao Bai <zongyao.bai@intel.com>, <anshuman.gupta@intel.com>
CC: Constantinos Chalkias <cch@e-psn.eu>, Bata Roland
 =?iso-8859-1?Q?Kriszti=E1n?= <batarolandkrisztian@gmail.com>,
 <intel-xe@lists.freedesktop.org>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
Message-ID: <atDLRDvuDES7u00Q@intel.com>
References: <20261012104245.2108030-1-cch@e-psn.eu>
 <as_iOd6A_Yncj8Gt@intel.com>
 <55cba965-208a-44cd-a644-e664410af8a5@hogyros.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55cba965-208a-44cd-a644-e664410af8a5@hogyros.de>
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To DM4PR11MB7181.namprd11.prod.outlook.com
 (2603:10b6:8:113::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|DM4PR11MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5afc20-93a8-46f3-895a-08df2aba6b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|3023799007|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: znW+isJxze7vr7+vD+yPdyMSqC6iVziTy/Pur4r34rMc1xmtHmqfntX1+RA5GcaI05PPFWMGz/jE/PNZ0wTn6eBKzC8wW7TDgnsL4evL/04+nSxgPLbCHulI5l0Es+ZUnMeTu5+pzC53/3OQrFP9YVJN3K+51WZb0bWcqZCoqcjzrRaS+rMozlzXYS6JipgzTMDzPA6oUpbYdnqggfa1mTfEa+050FBR0TLzpq1LmUZuzVK9hdR1EA6gnUNxW1lO7FFbkUjnPE1vqvASgClBHW1c5yesVya73H2mWp4e4TZZY9JryH8D46tT8ApTAf1Y+iHU+GQS+xVqY4H3nQAG5cKynQBruAZNfT8Vf8yZoU0JD2XG006VXI9rPi8gMJiH7xdxHhyUAsCMkSCgPNPMQU9zQ1TMTYVW+2Ut/l3WFl8I40bL/zYCwvxeIMwlrqdSB/BFN9yoLIHfg59TqyGR4nVWLZGbub3qDZLiAhNLwDwkf/2odUwcVJKv+2bSEz2F0TphyP+E2ZFq+JEp2QSd/s2AcSltZy10OfsmpZlvRffYYdnbDg+/799+WxIPOB7d2GA6F2hDu/bEkNsZCc/fRoSxkRvqTs7Jg1bJb/KeciAn8YDqCwXL3AC9d989xamO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ga9FuEp8fZuhscHLVYd4iIJyyb1eAHsL8980faMyQZgeUF/79aTh8SZa/rla?=
 =?us-ascii?Q?2FR4vNgm9MBlGZJn+QEkye6SYw9B9nLZZY+HdcfrZNUeBnIo1L0XfWO8fr++?=
 =?us-ascii?Q?b+H7TuX7KNr3qkZ0DzMnj9ee2ZfSdat8feJ3atehOSfLdPQyy5tZ0WZDyjfE?=
 =?us-ascii?Q?vZP8AtUmzrjsqRfhW16SvkVTzrMPljQlJ5nH1wo9kT2tL+m9S9F5tvnhoUSi?=
 =?us-ascii?Q?XQh440ptvUCvsjjFd7nIv0D88jagxftixYe8yF+5N1v6PsYGsRgFO82Spb0i?=
 =?us-ascii?Q?ezEXTmh5B4KdCCpuUZ7x7a8ato02WH838keV/neU9OQ/EhzZ9ag2eXrKIsRK?=
 =?us-ascii?Q?bMvW+ocoq7Ra74zBIs9Wc/l2ZUXdIiZE4CComqarzUFpirJmkcnT5/3Bf8gx?=
 =?us-ascii?Q?hwlJzp7woNHJveQunUpvjaTA+6R6L27ZE5GZY4J4+bWwOEm9qkdtQig0s8hi?=
 =?us-ascii?Q?dZZz5MUAY7UNytlVNpANnkFnX+OcBsGxO5Vh60MrI7bF5A9KGD4gTMh53/zL?=
 =?us-ascii?Q?efFcLhiNDAidtLqPD8pX/p+AJpESAbNUVtoQjHpz50aoM75d1bjHoHnmE3ZF?=
 =?us-ascii?Q?zEw6VKiXBAXA09oi7x3RvLh7VtauxgpTRlr7V+OeLH3qMUE6ZkvUs6DcSLMv?=
 =?us-ascii?Q?BAMJElrsn+C1MLWdc6dBtnBeEkNJ7O67nVM0nAAPdph4/IF8FHhczCq5FhuD?=
 =?us-ascii?Q?kSTujjRQ8IlcUfcO+AlV8otT5HRSeUp5rwLSFE3tJls9/KQFdk1lbKhJ9aws?=
 =?us-ascii?Q?Vzif2bIxu8nhKIbyO7U8O+a+ByDiEjKacRPdxTWW4GZNvlRQepS6h2Cog7Xw?=
 =?us-ascii?Q?82GLwOJuCSd/s5dh25BmwouwJSD7Bon/AfWj3jz69Mj3OKwDEIPA9Hvd7ge2?=
 =?us-ascii?Q?lQuVAcYWlvAC7235XHXblGoWthM1SUIPmU0nNnSAZqBBFO8krVZaiEgkCZMS?=
 =?us-ascii?Q?d0CErF37boc9/1JnrqIaAjp+LU+tBXO3ubd1p5iQ1iI91WcM8aEdjRy6UQge?=
 =?us-ascii?Q?mreDNrkKDIX/S1Nlind2A+DtuOKV1SE6QXl+lbmt32rRFY3CE5qqDf/c0C5g?=
 =?us-ascii?Q?HvrepME8uPKJf2xOvPcS9zth51RjJwzyA47TLViiA0brlGaFl8fk8xOraBNq?=
 =?us-ascii?Q?xdLGGKWnAp7mt2lOPa0ac1Pti8Sf1+1jTd7A0v/wFNm8By8tUUny0imArVm7?=
 =?us-ascii?Q?wvxm1UfRj6iCsP3zAj8j9H9lIWwMyzbDQ0SH3NJuspAw/lya1Ue3E8OwdiVW?=
 =?us-ascii?Q?krolbYJ42X+OHE6gICAIWqgJwurBKhlnndzOydRLngdrkNQRLOX/A8RlafxM?=
 =?us-ascii?Q?fMWUmtW+gNqhNNu8BvfsvH6Tk7ePT9WIHoU0lvrra/M3XoOtTCSP+cTKWnGG?=
 =?us-ascii?Q?btrZT8wTDLDs1yutMLBAPiY10HyFxYETQCNiGy00ac+3w6END//5ctc87qTS?=
 =?us-ascii?Q?zgjX7tIx2cLRZCmt7HYhgbCTYm86My6CTZ+eS3g1uprA+Olxsa49STDDOWO6?=
 =?us-ascii?Q?1nDlpnyavEgbmd7WrGfmBflVxmRQMbJh8SRlXQR9fKU2iBYLvIgG6McH9f9S?=
 =?us-ascii?Q?Ga4tTjoE/pzuQjlWzZ3djWYmEtzD8B/IUSeotfNntU53Cg8MWSmnrzniX4Wu?=
 =?us-ascii?Q?GrCcG/XpIsfLIZcPhSNAtZi+Ipzjyz3wdKxgOep1ROWxWvyP0PN3HOLvpBDs?=
 =?us-ascii?Q?JPbQr+dR5hJ5YQh4rakN2610ylFD/czbWJYgM2e/yg81njGrBkRr3yR5VUhK?=
 =?us-ascii?Q?6rRTTcmvOg=3D=3D?=
X-Exchange-RoutingPolicyChecked: nZXgR/S4hl77uz5NcTb7KHGPVK/SGmdAc2HngqFjmLJV4pdIT9YBm5AOsrCoOQh3tRKlQD/ov6D2TP+DJLciwUy1xG4JetXINWT0n1Q+jg8Ed735/4Srv+s+cR5oZH5eKJXo+lC3kCyUQ5GWYi2L7mYN998dDD4KSg9Kf8PC015ldQJbNdTpBgDD9509oRDTcI/VlEnfOqZWRS8PXK3/Itdd9t5KWCH4sfFRn8xtBy69SVsiUD/PPE2WWjWenjrjd9wRBCengaFagy28Y++ES8sGifBR/stad7nyM3EKVouklUod+ld4ha+q83hf4HIWXSFm1vKyDbbIvfGrk6uECw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5afc20-93a8-46f3-895a-08df2aba6b01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:47:06.0547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gtuoiVXedntv3JAsO5GpcZsF6cVKojWTtlRLzdtrQgg0l1MhFkweKeaByDG6lEBNxIqn4PwP8UXboybC5GzXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
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

On Thu, Oct 15, 2026 at 11:29:37AM +0900, Simon Richter wrote:
> Hi,
> 
> On 10/15/26 5:12 AM, Rodrigo Vivi wrote:
> 
> > If the consensus is that we need this forcewake, let's do it.
> It feels like we haven't really understood the problem yet, we just know
> something that appears to work.

Cc: karthik.poosa@intel.com
Cc: anshuman.gupta@intel.com

Do we have a gitlab issue filed on this already? It should be good to
consolidate all the view there. Furthermore, perhaps we can get some internal
help from FW teams to assist in here.

> 
> If I run
> 
>     while true; do sleep 5 >forcewake_all; sleep 5; done & watch sensors
> 
> then the temperature sensors *do* update, but several of the VRAM channels
> take over a minute, so the long forcewake does not solve the problem. If
> shorter ones do, then I'd really like to understand why; my theory is that
> it's not the forcewake itself that does the job, but the fact that it's
> toggling, and possibly generating some events in some microcontroller. It
> may be sufficient to send some no-op commands instead of playing with the
> power rails.

I wonder if some forcewake histeresis might help on this case as well...

Cc: Zongyao Bai <zongyao.bai@intel.com>
https://lore.kernel.org/intel-xe/20260601213804.707256-1-zongyao.bai@intel.com/

> 
> Starting the loop above with pretty much everything at a nice toasty
> equilibrium temperature of 82 degrees (which is way too much IMO for a card
> that has no client connected and is just displaying a console login), the
> fans immediately come on, and apparently every ten seconds one of the VRAM
> channels updates to a lower temperature, so one forcewake event pretty much
> exactly corresponds to one sensor update.
> 
> That would explain why the patch works -- it generates the same number of
> forcewake events as sensor reads, and the delay makes sure they are
> registered as separate events. However, there is no correspondence between
> the event and the sensor, so if I do my normal telemetry recording (every
> sensor once every ten seconds) I can still get data that is ten seconds old,
> and I also wake up the GPU once every ten seconds even if there is nothing
> to do.
> 
> That is an improvement over the status quo, but my concern is that it will
> push us over into "good enough" territory where the actual problem is never
> addressed.
> 
>    Simon
