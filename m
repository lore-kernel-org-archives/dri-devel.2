Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD83C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 23:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA80C10E093;
	Fri, 21 Aug 2026 23:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jLcdanvh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DEDF10E093;
 Fri, 21 Aug 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787355636; x=1818891636;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nWDfG7Qldq+guKpy/LdfoG7/00KZoDegXKxkOl8gQGo=;
 b=jLcdanvhx6oQidjfU8n3pYJXgAfb7nF2Isg6XAPeQiI4jJGfnhisU8XQ
 GUOdDsUsXx0MDLc5jAlVLvzKyrZYr9Zh0CSvZ8ktQ4jeZI4aE8MQ/IGmH
 phSDM6peMqrEFQaDIXcUjtkEevdBJ41oFh2b9MvgKH7Cc/jAtpTYIJLIn
 zDn8uvB8cYFwptJV2tg/NRm0ugLz5D44woc/rA8EcMaxvm9w6LOhogTo6
 +HDsatd33T1ep9+9huf+eQEL9eFN9fIYPzckpU8CEWCtuFI4/b17FD8pA
 NZO4D2shfWnUeyKarfw9t/kM20mEmS634kYEy9Rk3+4x3fFHalPod3euq w==;
X-CSE-ConnectionGUID: cW41tpfQS5SVMGLZCvdieg==
X-CSE-MsgGUID: tSiAihu9QgSh6Hj5dTdeqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88036048"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="88036048"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 16:40:34 -0700
X-CSE-ConnectionGUID: f/F4kk+8QFivvXHCB+Cv+w==
X-CSE-MsgGUID: sxrNkFs5TGCSreB7eVMWSw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 16:40:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 16:40:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 16:40:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 16:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrL27y4xbWKQJz4aMK0dWBUjDvcJbBlD2cpxUp9MF6lSmtW/ptyAETYVhPU6gQXEpawSri/55itQZE6XPxYdgloky9oAX61bbFh/B1O+8ewqxz83JcZZuEPv8BJuryHIpdhghxJWcU0DRh1Jc/X3qoPaLCs1HJ/x/kcwo5etwPHfYhQ6UGlhYSh8LcVmDzhr6mlxl2stAw5u2JlyUrq+tZ9+xj5MYpgq3lgBTUe7eH8tfaM/pRl6AZiiIbR5Hg3RaFN8Q5lrGg6ZrEINAeJekMMaD9k3adPs+1HIvxOzu1z5LvY3Fhlvrbb59yGdeBLzGCxV9m+QIK4UghgLH/DVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H8WltDPiBcvyYASRzdKpMs2u/NLOoB5ywlwTeN2ldw=;
 b=vQAB/0ssWEdL+CDC1A0xbajyt0Cakv9+/ZyZqiyIuctViEUEE1E5F4RTuWYSxTM4HvLNsNcNM9LH37S9fk+Sb1+4Xin3JQ4spkd9b8gghBXyTW2yiPT0kZV0IWTwsXSVQdDgNNpkb8LIf7j8Ju22PgVJSNzRPGzjBdCMwZp9ZhhEe83NgJW1Kjw8FV64HUJikRtVW2hsMiCWTwGkjh+IAQcnRN3ql73kf+qSyqoTFILYOU3UNyGdPvD6H1wNoOpGCLlljC2IW1FScwdVobpPdlIb2GMtEs+g15nzBrK4T8oi17exbkchjsWLOKeNqwrnh48GO2zZUZ9SRE1Kx3YzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CHAPR11MB9630.namprd11.prod.outlook.com (2603:10b6:610:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:40:25 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:40:25 +0000
Date: Fri, 21 Aug 2026 16:40:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Matthew Auld <matthew.auld@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, Lucas De Marchi <demarchi@kernel.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-xe@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: drm: xe: Kernel-submitted job timed out
Message-ID: <aojh5XsZyhfHPW9U@gsse-cloud1.jf.intel.com>
References: <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
 <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
 <CAHk-=wjJJH-1q6TK45=z0poSE92mp77JLsF3jHeWXibEtJu7EQ@mail.gmail.com>
 <CAHk-=wjZbz8v3M+qtzdPvDSshRX=2Krg=ByHyWOW9g+uLQgVkw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZbz8v3M+qtzdPvDSshRX=2Krg=ByHyWOW9g+uLQgVkw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CHAPR11MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 38315aab-ab99-46a9-d7fd-08deffdd932a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TsYseVMIcw/GKyf5BIQpvcKQmY9fKo94mLJU3ifI1Q/Sxx16bDfgnCwTHNoWQnmkjNKfQ2SspymxnH93ydYOqzj0x0aKRs/+OVzYkcubQMbfaBpL1gK7di12IkiUQGjr15TCOw6exC6rXIKCwI58zMMdsh8gvoi5v7cicP7SkhYqvHNZBX+tPzHLoW3AhVL1daEk5zn840p7jNPfQrAe9qQ4NA5/O7ZzW08rkzezjoaRSfsZBtJKFBvihCeQWQY2/l6deb0jV1OYHHx1Mr/UU3i59EoTE0DNVRYJ1IPvGG/QCT0N9rY01pDhcUzWQR3ifQLP1ZpA0GtxbVpRVTwKKo5hBHIBmsTMvGRuQbrGD3y2E7wPPXNRyvcKwOCkzE6uBc9g7QYphyqhFqaxcBMSJLfEOqDjW1Fl1/aNJYApdV/mte028XGNecMdh3YoZPFo3IIapM2vwJlczRurt4IrJPZUhcCipeH+E5rFTkSzXXrmwPkqt8pWBtVcz/Wj2qlaqz3jrNN5XP485PdKoqCyeFULQV5rlyjNUstp/SSMrXn2l0Hi5efpMu7L+SfG5c4404tjCAQGC/O+2P59PUf+x0zHu507Q1pzxalRGAzI5HhcxA2cQadaifgOSivjvwg/9IIfyWSod+/9VKD7o/ISW1zpzmIfM2reg1jCTnd3cwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82T+R9WHGfo3kkH4qCnHK08ex6RSK5JDeblfM11lSaQf7LR0xlIPleLBj0i7?=
 =?us-ascii?Q?OWeYRmAz62gWaE1EanqzXeREx9Yua8mx1r++RBtxVzjasQOTiWNZtZP2lsEx?=
 =?us-ascii?Q?P9dUGqf30zZziRsp8Cs322IXgC7mABSAhaZ+Ptyf0Lg8oq9Z1SyILkLxxXdC?=
 =?us-ascii?Q?4RHBjP+aEm8g3e5jqWQK8te+2+n2bQn3v7ybhhit11i4G0waiioBV+f0jRtN?=
 =?us-ascii?Q?kzPzJQuU19KyDGwkhDrulgIgEl5de1HIGUtyEOZuUgvwND2AQA3lD6Fsdkr8?=
 =?us-ascii?Q?4hkFWof/AUwTA+PPBCFqJWdOaWLrtr6Flqv9ME7ryIcX7rGRNK7Bae50XqMZ?=
 =?us-ascii?Q?y3S300VTQ4Yr5ldFySWVSeGuQWsu8i+bezx1LwLPaWX79THr+tt1R961S4Cy?=
 =?us-ascii?Q?hz2jq27SPis5i77V4L27+OskzS1rQnR7zmkv3EPqvY0TD8N+M1AejzRs4TYI?=
 =?us-ascii?Q?kk7ouVd/8kCS8T2VjXABFM9Up+hWRbpB6jze3s4i6AkEuXAP7IWKemWegYvM?=
 =?us-ascii?Q?FzFenY1cqCF0Mem3d8XlXvTGEVOVNzjUOG9XeAGVZfjjUVa71XhtpBh+k2k1?=
 =?us-ascii?Q?M1jl7yUlQb87UFTVTflZgnUfVoMqbhQPDJ1Giex63CiKmtAQqVuX712wBLYI?=
 =?us-ascii?Q?yq0/yNYy/uEVU4pUd4+d0Th1xz76rHMyLdfVV/M3fdqRlxsoajf6UAneeE2H?=
 =?us-ascii?Q?aUqbd/tTP/BO8Xtn353eedBU6m4Z5iJgGQL5iMZ9TT1+ZdGBEQbXPPAq48yu?=
 =?us-ascii?Q?UNPz+7fC+eDt3xyWhTXas/+fDw8Tq/gu30sZyAUju4lZDhTT0IOk09xrZE6Q?=
 =?us-ascii?Q?NAPLAKVw95pA4Iv17r10E7+auzTIjXeWZnKMzwLAkswycDT4ckNBz6gBUfHy?=
 =?us-ascii?Q?AYh7wQEusXxJGjkhlfzlbbKt/ynDX/FNQRhHwyyQpWtU2dwuZlpYnUCraLun?=
 =?us-ascii?Q?Ns9JnIUtPDUfjVhPNnHYfcSEFDset+L6RDAHwI2xWeQtmzCs9B3rc8JYO3gG?=
 =?us-ascii?Q?LHBUXkGSd712APQrQ1i+cpP1KxpXgXbtr7T0IUJHpx4RTAxuSrokt8IUBqzw?=
 =?us-ascii?Q?Dlm3BsbOOPmVKdcNqf/3/DFqt2vw9NgRkCQtTg3nzy2XF6GO9tRExaZpjREK?=
 =?us-ascii?Q?MUDsBcwn/mqR5BACZM1jVecXr1L/Put68YV8GCLG9WV5E5ubMc1XcStBYI4d?=
 =?us-ascii?Q?4yYrHp1n0qL/PpB339aI84yotRGwhymgh1Nu4gtbdJzahBF98r6BAonEvW9I?=
 =?us-ascii?Q?McnyIQQkqdV1ZCvE+nlIbllneBqVseBYDWsLYGJO/IVE4S3RPgVR7g/T/Gc+?=
 =?us-ascii?Q?f5ngmWBNPmUGoxjpfRklaOoWFAJBGg0ESgkhRuSHz1AVYqEilrSIQ7UnXKiK?=
 =?us-ascii?Q?T7fPBcDhiNHTxdsfZ8BOxGUuZM7G8P1id/p0p7cM1aL65owce2pJGqYfy0hn?=
 =?us-ascii?Q?iVi2dbrguK2mYurI/flOtqQtN9i/7c0cLKlAYHEAvQH5ko0CXPkY5XvoiPwC?=
 =?us-ascii?Q?bYbzGS1sjNCTjdptwlHSs3UhveNzoRLl8TCnIxLrwjr2buNwm75myNwXo7M0?=
 =?us-ascii?Q?uY47kGZwSOqzxLYavsuUzU/p0KOdvS6Rk2u90WG2KHC/jVRUR44hJLQBuFF8?=
 =?us-ascii?Q?GItiyO+KxNG+0aScSR2tPYpYhh7LkLWZY0GY+NJPm/kj23DXbnpPn8ddFPqc?=
 =?us-ascii?Q?B5yi5jcrnqclqzAJqpkr0E+3Ra+dtQePZZxmAjB0n1lIDquJUFlSvg6W81Ya?=
 =?us-ascii?Q?nl0KVgu91xlrbtsJY/heYVL+1nZqW5I=3D?=
X-Exchange-RoutingPolicyChecked: iJOmag1eBvcr0yYG9P8/4NoTYt8QSQbtcoeVVqmoG/RSGP3edVPctDRMywD4c88O0rB8251F4rnftTesbj4khEU54P61ugIHFZ9cI2bII/MNmdbOWcZQYzvqsYIEH/wzLr7fbMU61CklpG0mBApMEJSePL69w+mTRnWR66+hb3HpiDKqZILSBWkbiQjJYahpDxFMSMJBZwUpp7VIPA2RtWWqaF56c/RTuw0sMrMPh00A+S8TLFvh8TlfnT1pf4YFtUp7IbywpbgCfh11J9Mt9UGbee8vgmrRysWZcZRW34rF3YkhdGftS4AaoIxsivHiIvy7BjqmLJhv9hiv5tvGbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38315aab-ab99-46a9-d7fd-08deffdd932a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:40:25.8314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXCv8z41h58RBsh73zEy6H2cgfR/sudhbKCDEPVZEuoSjh0yXZ8iVMFaKZZCtVowxZqOmxYucdlW5B1gyTxI6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9630
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

On Fri, Aug 21, 2026 at 09:47:53AM -0700, Linus Torvalds wrote:
> On Thu, 20 Aug 2026 at 20:50, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >

First, thanks for looking into this, and I apologize for the
inconvenience. I had gotten to the point where, based on my testing, I
had reasoned that there was memory corruption somewhere in Xe that was
writing garbage into the page tables, but without a reproducer I
couldn't determine exactly where it was occurring.

> > I committed the fix as commit 818bebeb63dd ("drm/xe: Don't hand out
> > the flat CCS storage as usable VRAM").
> 
> Note: that is most definitely a real fix, but it's not necessarily the
> *right* fix.
> 
> For example, I do not understand the old 128kB alignment at all. It
> not only was definitely the wrong way around, but it made no sense in
> the first place.
> 
> The comment for it said "SW must round up to nearest 128K" and the
> original broken commit seems to imply that thatt comes from some
> hardware document.
> 
> But the result isn't actually *used* for any hardware state, as far as
> I can tell. It's just used for "vram_size" (called "usable_size" in
> xe_vram_probe, which as far as I could tell is only used by the driver
> for the allocator.
> 
> So the whole thing was just complete garbage, and I don't understand

Yes, this is garbage and can corrupt memory.

> *why*. I may be missing something, but yesterday I was so fed up with
> the experience of spending 10+ hours debugging what ended up being a
> one-liner that I just committed it as-is.
> 

one-liners tend to be hardest ones to find, again thanks, apologize,
etc...

> Now I'm back after a night's sleep, bright-eyed and bushy-tailed, and
> still not really wanting to look at it, but at least wanting to tie
> down some loose ends.
> 
> So I just want somebody who actually knows the Xe driver to look at
> that thing. I only round down by 4k, not 128k. I think the 128k was
> simply wrong and nonsensical. But that number came from *somewhere*.
> 
> I claim that the old 128kB number cannot be sane for another reason:
> the other side of that
> 
>         if (GRAPHICS_VER(xe) >= 20) {
> 
> will return an offset that is at a 64k granularity, because that's
> apparently the hardware field definition.
> 
> But the point is that the return value of get_flat_ccs_offset()
> clearly is *not* 128kB-aligned and never was, so not only was the
> alignment done in the wrong direction, it was always entirely
> nonsensical. It cannot possibly be something that the allocator code
> then depends on.
> 
> Anyway. It all now works for me, and apparently reliably. But the
> keyword is "for me". I committed that thing because the old code was
> clearly garbage, and the new code worked.
> 
> But the new code may be garbage too - for some reason that I simply

It will pop an assert somewhere else in the code, but that is also
questionable.

> don't know about - so somebody competent needs to look at it.
>

We are looking into this now and get a proper backportable fix post
asap.

Matt

>                  Linus
