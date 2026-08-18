Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB3C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5088D10EB86;
	Tue, 18 Aug 2026 13:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WM1reKVA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF8C10EB83;
 Tue, 18 Aug 2026 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060592; x=1818596592;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fnQ+TlvaXMipJUfM9bsw7hjWqaGQbxmNMQAYTsHrRbk=;
 b=WM1reKVAKsqU/b3VK1TodMC+/wAnTM7L5rV/1n2kjB7IXCq2By5H5jSG
 yuvC0WFkcDWg7EBFKSkAWRrVcMHAN5cI0YDnG4LnM8lPRxkTlyYHrTYfa
 Ewr3OIw2hHDM8vjpXwUQ8zfaULIFqViKg0+NdZCxI+Zd48AHHk5YLHTpT
 NruMBbmWakHZXeH/mLvetNcuZe4mk1tusgopGO29oSV55WfvpPymv3j3X
 YVXR9Q7LZJYUARoUZ/2DQkchWQsjua3NIzmh+ySXffr8IRN4Wc8XvgoGj
 qLI0Af5z0PifeqKaaHApTZAId/fSB4egVNAPKtduOrcg+zEzyCv3oPd8I Q==;
X-CSE-ConnectionGUID: C0L/N+2CS3anPZE5Q6EZ2w==
X-CSE-MsgGUID: NmiEWrgjQOmKuwqpB2JdMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="105086739"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="105086739"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:43:12 -0700
X-CSE-ConnectionGUID: UliH1GzsSHOP9DonOrT0+g==
X-CSE-MsgGUID: zkJL5gamTnO/dGlmf7+M8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="269070181"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:43:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 06:43:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 06:43:10 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 06:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuonPlwqWRbAtmyADq+PZmcjMxhiWbFBuXBWZRHQHScSdVhdWs4MySl95lX5FrdwoF2y1iVX4csR36Xkp7X6H/CpRDQftdwGTKSEmSvAaE6DBnBH3QHILAYWV/Pg1ck89VjnRVYVHPhPkEuTyc9QwQgAzx1oJXDnP8fiEoGf7lIzgBP/qPTQUQoU5MDY2Szl9euBb3WTcyah5FPXuvBzQD0JPrcMadjSfcT7rVjI4ogJK/TF+wNyOhJUIgsXpQDj04ltX2wtNieeaw+SSmwTaVzOTzRipEwNbIwDH0Ipo8gEUpfwdm9P+ZA3OJ13s2wbpqTVkOhmw6Lh1Y4/bccT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPf+YK/7WSFQJlu0kIonSilb85gmkWoxRUK/3OGTGeQ=;
 b=Mq1lu+HFzDrRTPMmp6FkVXeTJNTX+HzSz4m6pEEm787fR7Q7sU5qkcI2DM97z/9jWDXU4jHCgdycfqdYFFtEM/n7jA0xU9Ka1caq0eI8IA9AaYt31OE/3gR2L9bwaKUIazyKpLXgyRgdrM1WqvYO/KEZl/CZqDf6kqtCjKtDKwgYs+FOL+kU5dpIb81JNGuWEYGDwWxw++M7n7+MdndObstC6JGVzucTKdi7fTWb7lS2sZYlXxFGacFy7RZp6WyAW1gQ5n+sc0leOoYpVJvd20/eC22XP520CfJ4uDl/JUz93iKTc/+zwTzJr9dcw/CQfTRw5P7ta1FFPzG4iS4JwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by SJ5PPF09F392AFF.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::808) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 13:43:07 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 13:43:07 +0000
Date: Tue, 18 Aug 2026 09:43:01 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <dev@lankhorst.se>,
 <zachary.mckevitt@oss.qualcomm.com>, <riana.tauro@intel.com>,
 <michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
 <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v5 2/5] drm/ras: Introduce error threshold
Message-ID: <aoRhZdKBFG4yF_fL@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-3-raag.jadav@intel.com>
 <amD-SVMRhA0SsW1t@intel.com> <amymMwoSOxpHhEvX@black.igk.intel.com>
 <anMICHct8ipD-u12@intel.com> <aoRDd7mgRi8KqT2H@black.igk.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoRDd7mgRi8KqT2H@black.igk.intel.com>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|SJ5PPF09F392AFF:EE_
X-MS-Office365-Filtering-Correlation-Id: 911cadd6-2046-4b6d-a95b-08defd2ea295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: o2pHBj/5RqahI8QaDYUn353brupmBmgyC9/k5rrUNnrW5OEgMRnthnfgiQ4D6fdSL/x0pQQeexGz5AjiTtFAlbwLyf6ruGHUazYDwI/N14UvNI7fKNlfE8B+mdRiXYitgj+IQlhlWf/Xe8vNd+t0+hKp52NtqF1UrdwAsIvio8koVE2mrjD5ZNaqKsHHiIqwNcq8z9S8LDp61+ma/0ztPLHxbUQo7vanK+FIpCeaGyR6kLbUiJaJui4u027wbOfCamEbonrW9cf83GrFud8QXPEtT3P9fnnewm4l1O+lr2ST3cbuhASsiII6gfuYPWBYM+ByABARZtAeFccpMH2btAwD7nb5Z4lBF/YvFmvYqggIDi44odQokpEMuXWBVt5f7C5SS+OeMuaSlmHPgSt8zkkobFSJ7T1ZnrhquAVOdHU4WsSbT7bPnSr4ZyIqwtApANQi9cq9xY01kIiH7SA+8cvRm3QxwyVX8gtfauH6JfLKVbd3S55YQjDi6SplLNjgA3bgmZAoqEtgdTqeidSCI0YBOB3kj+wUen0JWYmj9SL8OwpEBqy1x4FF+oqIId/i239qrFYpnYzXZsF56fnU55v96UUbbczKyzHiyXU9V2TXLGdHYAVuDfnC3PAToE/L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7752.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1gZwXxJIkKTRxbafKvxIUJXMEF1Zlh93akjuWQEige23ljyDggE5jeW7XOGk?=
 =?us-ascii?Q?t7SelkoQDTXt7O2xyQL6SkYWRc93SVdmjSQXLfFzJo06zEYfuJXwtbcduinO?=
 =?us-ascii?Q?5QrMcgEbzemsrnUW2XbN74ND98khU+KZ2sPpvQfBKAPawAQKzOKgiHG1mrPp?=
 =?us-ascii?Q?fEl3RQCfFDW/TdK0NCGxEMSr5qhhihXVvWC7y9KzHeUkLOEOE4H85ED61ktk?=
 =?us-ascii?Q?PY3Q8x9foO5PYAUCD9xL0jmWB3ohKFKm1KPNgs2Eo2GGpJDXs8+6eQEwbohi?=
 =?us-ascii?Q?c0+RiSVbulxXUf7+amAw6votwN1XBnhKGny2fi3NGvdppDL+V0lO4RHhJxnz?=
 =?us-ascii?Q?FyT8h55wl8Vg5f75g5XjHU+TnLatwoq9TA+jGdzSCi0bKLCtgvZq3r5ZVxlj?=
 =?us-ascii?Q?jzrVuxlM4bu+kJI9bOKmNGiozw9b4QKo3zYrO9TLqfvdQ7qjLMHjvoykOlSp?=
 =?us-ascii?Q?xGQjyzSHwoReO22eaTFVw2vtXKFaF86LT+lqgaEqQYndGBFCZITjnQjXoLmS?=
 =?us-ascii?Q?3SeUe9UM1YrAmN5TrtGfTEHPgbyKv/pdvpsH4N37wpyM30ORm1I8GSDH7QYy?=
 =?us-ascii?Q?SVZy95xhsTDvWPVdVeIw7BroiAfvt9kHxUs8MvpzQV2uJH74PT4NXMaxv+sX?=
 =?us-ascii?Q?PDncRbKRLhhnEYmMa/AEKUU886V4uyqvFzLhejVUWGBBKeQuui2B9NvVXkZa?=
 =?us-ascii?Q?7PAKeGsTcy4xnJPSiaVhYVMunpbofcqY/bC337SiXfK5xmsT6AwDd0nlKUbO?=
 =?us-ascii?Q?tJDZVFdbNJ+WLUsKCgf2P/yK6brULaXcih3QU52KREV9yjsFa/nzaKobf8ep?=
 =?us-ascii?Q?y89nO4ZFwQaL+C5WjtKtMEtqYet4NxOh1cUP2Y9bzWjGq0Bs51kguOncnRje?=
 =?us-ascii?Q?dbgaS5VG21qw5J+NLgecsfOwk9ON0opo3paCV/k5EjCUUOoLXc0+GjCv25e5?=
 =?us-ascii?Q?hFXb7WJaZbphcgvahZTZSgn8Aj5mL5J8/P7PGpJNLNTPrfidcTVU8Ew5/as3?=
 =?us-ascii?Q?FZvDTiM/Y+FKd1nXP3M2DA/bldf3wIxtCvI7yWrYmPq4EkvA/GbztAtFTyfJ?=
 =?us-ascii?Q?0YrMjOLPf0KK/u/YCZ1GEoTF7Bw/kKxzOgKGs9CuhPll/0BmKA/yX3gc4A30?=
 =?us-ascii?Q?Xu5Kn4KnFeDml4K/DdpXvJFjCjSz1eRxR3bPL8NGRe75lpMQaapiwDu8MGOK?=
 =?us-ascii?Q?HK6uApUbVMjXHbbW0QVmnz4LQlTZKajWEGYGic5uk+aRCDpYnx3VhE96OGOG?=
 =?us-ascii?Q?KPIzz/X0nK8i7qBb6FXO7Ru+kfvGV0izssOrBp7LV7oubtOC7v4PvqZaSwEC?=
 =?us-ascii?Q?p4DbYaC3lXUlapr5DH9s1vz4gUy6n0lEosgNESacJ8OW0XCstgVPcL6NnrKU?=
 =?us-ascii?Q?t51KU0hhCiSBeHOu6oHuRHlcCSMWYltqIVIMNbMk6PTlUOUlZh1Z2/mKKrT/?=
 =?us-ascii?Q?jAPSogwW5iC9OT/SphFnb0sxNxvbCTNUGVDqbAIt4c5mOwz1oxlqr2LqO8k8?=
 =?us-ascii?Q?LYqChrubPZfSziXsLsLaKce37tDEWbkX1ILPiwDZzf10fa26qZTytbiYxOsa?=
 =?us-ascii?Q?xDqzhtx+WnVqW0tfSk1o6boi5D28IwPSpcgDmXMqqutxE4pNz/rNagyemz3k?=
 =?us-ascii?Q?cbqkqwvj0uKzCPlxPbg9WnQ8vV/yA1Pl9F7at1wsxzpKHXiQVluI0GXIbvMD?=
 =?us-ascii?Q?FdOXurf55Ixdu4v3IzM5WFvRtT8VjEgev9S0AHHWZ3LRAT26BAIN9h5MIR4M?=
 =?us-ascii?Q?uaNGeEXegg=3D=3D?=
X-Exchange-RoutingPolicyChecked: U0QPL23NiyMcT643EH0fq2d0mdftqQ3LaF2KiuZSD/Ld0Ofr4TbspD4AVVbLIhGKsFTjUbACVKkHPGfQd4gybPne1FTXKUpin74inPrWEeaFzzk8YKbms3rMCtVj6hctvg1xalSk8AwORb327OQo3xj3ZaO1cIeqC2H449sVWL+CJjUy+Ew2/dRlun8TtHUI0BtkkYaLPlsvyZd93iyW1Fj36PlyFDaINnFGxLy7pslLLa7C6smcKoHO6XJ0LaWl0xMY3P9qc9ihUu4nwMdCfj+Jd55GezutphE3QyZiHEVPKV+8OpdMMC9VJVwDj74gHecMehLacvlcYniqeApqhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 911cadd6-2046-4b6d-a95b-08defd2ea295
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:43:07.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j65q4c/RRmurgsHx41qgX+DcyMHAuDy+cVFM62nOGmtXtZkjpVZE1bHHU8ZTmO2rd14rO5riID9Fcxpha40OgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09F392AFF
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

On Tue, Aug 18, 2026 at 01:35:19PM +0200, Raag Jadav wrote:
> On Wed, Aug 05, 2026 at 05:53:12AM -0400, Rodrigo Vivi wrote:
> > On Fri, Jul 31, 2026 at 03:42:11PM +0200, Raag Jadav wrote:
> > > Hi net maintainers,
> > > 
> > > On Wed, Jul 22, 2026 at 01:30:49PM -0400, Rodrigo Vivi wrote:
> > > > On Wed, Jul 22, 2026 at 09:11:12AM +0530, Raag Jadav wrote:
> > > > > Add get-error-threshold and set-error-threshold command support which
> > > > > allows querying/setting error threshold of the counter. Threshold in RAS
> > > > > context means the number of errors the hardware is expected to accumulate
> > > > > before it raises them to software. This is to have a fine grained control
> > > > > over error notifications that are raised by the hardware.
> > > > > 
> > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > > Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> > > > > ---
> > > > > v2: Document threshold definition (Riana)
> > > > >     Return -EOPNOTSUPP on threshold callbacks absence (Riana)
> > > > >     Cancel and free genlmsg on failure (Riana)
> > > > >     Document threshold bounds checking responsibility (Riana)
> > > > > v3: Move documentation from yaml to rst file (Riana)
> > > > >     s/value/threshold (Riana)
> > > > >     Use goto for error handling (Riana)
> > > > > v4: Clarify 0 threshold expectations (Riana)
> > > > >     Drop redundant wrapping (Riana)
> > > > > v5: Drop redundant documentation (Riana)
> > > > >     Aesthetic adjustment (Riana)
> > > > > ---
> > > > >  Documentation/gpu/drm-ras.rst            |  18 +++
> > > > >  Documentation/netlink/specs/drm_ras.yaml |  32 +++++
> > > > 
> > > > Jakub and other net maintainers, ack on getting this through drm trees?
> > > 
> > > Can you please provide guidance?
> > 
> > Even better, could you please ack the MAINTAINERS change [1] so we can stop
> > bothering you with these asks?
> > 
> > [1] https://lore.kernel.org/all/20260805094949.536651-2-rodrigo.vivi@intel.com/T/#u
> 
> So anything I can do here?

Please rebase and resend it.

We got the maintaineship of this file so we can go faster now, but it is not
applying anymore.

Sorry for the delay in here.

Thanks,
Rodrigo.

> 
> Raag
> 
> > > > >  drivers/gpu/drm/drm_ras.c                | 158 +++++++++++++++++++++++
> > > > >  drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
> > > > >  drivers/gpu/drm/drm_ras_nl.h             |   4 +
> > > > >  include/drm/drm_ras.h                    |  29 +++++
> > > > >  include/uapi/drm/drm_ras.h               |   3 +
> > > > >  7 files changed, 271 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > > > > index 83c21853b74b..2718f8aee09d 100644
> > > > > --- a/Documentation/gpu/drm-ras.rst
> > > > > +++ b/Documentation/gpu/drm-ras.rst
> > > > > @@ -56,6 +56,10 @@ User space tools can:
> > > > >    ``node-id`` and ``error-id`` as parameters.
> > > > >  * Clear specific error counters with the ``clear-error-counter`` command, using both
> > > > >    ``node-id`` and ``error-id`` as parameters.
> > > > > +* Query specific error counter threshold with the ``get-error-threshold`` command, using both
> > > > > +  ``node-id`` and ``error-id`` as parameters.
> > > > > +* Set specific error counter threshold with the ``set-error-threshold`` command, using
> > > > > +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
> > > > >  
> > > > >  YAML-based Interface
> > > > >  --------------------
> > > > > @@ -111,3 +115,17 @@ Example: Clear an error counter for a given node
> > > > >  
> > > > >      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> > > > >      None
> > > > > +
> > > > > +Example: Query error threshold of a given counter
> > > > > +
> > > > > +.. code-block:: bash
> > > > > +
> > > > > +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> > > > > +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> > > > > +
> > > > > +Example: Set error threshold of a given counter
> > > > > +
> > > > > +.. code-block:: bash
> > > > > +
> > > > > +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> > > > > +    None
> > > > > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > > > > index e113056f8c01..9cf7f9cde242 100644
> > > > > --- a/Documentation/netlink/specs/drm_ras.yaml
> > > > > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > > > > @@ -69,6 +69,10 @@ attribute-sets:
> > > > >          name: error-value
> > > > >          type: u32
> > > > >          doc: Current value of the requested error counter.
> > > > > +      -
> > > > > +        name: error-threshold
> > > > > +        type: u32
> > > > > +        doc: Error threshold of the counter.
> > > > >  
> > > > >  operations:
> > > > >    list:
> > > > > @@ -124,3 +128,31 @@ operations:
> > > > >        do:
> > > > >          request:
> > > > >            attributes: *id-attrs
> > > > > +    -
> > > > > +      name: get-error-threshold
> > > > > +      doc: >-
> > > > > +           Retrieve error threshold of a given counter.
> > > > > +           The response includes the id, the name, and current threshold
> > > > > +           of the counter.
> > > > > +      attribute-set: error-counter-attrs
> > > > > +      flags: [admin-perm]
> > > > > +      do:
> > > > > +        request:
> > > > > +          attributes: *id-attrs
> > > > > +        reply:
> > > > > +          attributes:
> > > > > +            - error-id
> > > > > +            - error-name
> > > > > +            - error-threshold
> > > > > +    -
> > > > > +      name: set-error-threshold
> > > > > +      doc: >-
> > > > > +           Set error threshold of a given counter.
> > > > > +      attribute-set: error-counter-attrs
> > > > > +      flags: [admin-perm]
> > > > > +      do:
> > > > > +        request:
> > > > > +          attributes:
> > > > > +            - node-id
> > > > > +            - error-id
> > > > > +            - error-threshold
> > > > > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > > > > index 467a169026fc..9a7b3d2acd25 100644
> > > > > --- a/drivers/gpu/drm/drm_ras.c
> > > > > +++ b/drivers/gpu/drm/drm_ras.c
> > > > > @@ -41,6 +41,13 @@
> > > > >   *    Userspace must provide Node ID, Error ID.
> > > > >   *    Clears specific error counter of a node if supported.
> > > > >   *
> > > > > + * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> > > > > + *    Userspace must provide Node ID and Error ID.
> > > > > + *    Returns the error threshold of a specific counter.
> > > > > + *
> > > > > + * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> > > > > + *    Userspace must provide Node ID, Error ID and threshold to be set.
> > > > > + *
> > > > >   * Node registration:
> > > > >   *
> > > > >   * - drm_ras_node_register(): Registers a new node and assigns
> > > > > @@ -61,6 +68,13 @@
> > > > >   *     + The error counters in the driver doesn't need to be contiguous, but the
> > > > >   *       driver must return -ENOENT to the query_error_counter as an indication
> > > > >   *       that the ID should be skipped and not listed in the netlink API.
> > > > > + *     + The driver can optionally implement query_error_threshold() and
> > > > > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > > > > + *       threshold of the counter. Threshold in RAS context means the number of
> > > > > + *       errors the hardware is expected to accumulate before it raises them to
> > > > > + *       software. This is to have a fine grained control over error notifications
> > > > > + *       that are raised by the hardware.
> > > > > + *     + The driver is responsible for error threshold bounds checking.
> > > > >   *
> > > > >   * Netlink handlers:
> > > > >   *
> > > > > @@ -72,6 +86,10 @@
> > > > >   *   operation, fetching a counter value from a specific node.
> > > > >   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
> > > > >   *   operation, clearing a counter value from a specific node.
> > > > > + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> > > > > + *   operation, fetching the error threshold of a specific counter.
> > > > > + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> > > > > + *   operation, setting the error threshold of a specific counter.
> > > > >   */
> > > > >  
> > > > >  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > > > > @@ -168,6 +186,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
> > > > >  	return node->query_error_counter(node, error_id, name, value);
> > > > >  }
> > > > >  
> > > > > +static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
> > > > > +{
> > > > > +	struct drm_ras_node *node;
> > > > > +
> > > > > +	node = xa_load(&drm_ras_xa, node_id);
> > > > > +	if (!node)
> > > > > +		return -ENOENT;
> > > > > +
> > > > > +	if (!node->query_error_threshold)
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return node->query_error_threshold(node, error_id, name, threshold);
> > > > > +}
> > > > > +
> > > > > +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> > > > > +{
> > > > > +	struct drm_ras_node *node;
> > > > > +
> > > > > +	node = xa_load(&drm_ras_xa, node_id);
> > > > > +	if (!node)
> > > > > +		return -ENOENT;
> > > > > +
> > > > > +	if (!node->set_error_threshold)
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return node->set_error_threshold(node, error_id, threshold);
> > > > > +}
> > > > > +
> > > > >  static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> > > > >  			   const char *error_name, u32 value)
> > > > >  {
> > > > > @@ -186,6 +238,22 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> > > > >  			   value);
> > > > >  }
> > > > >  
> > > > > +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
> > > > > +			       u32 threshold)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
> > > > > +}
> > > > > +
> > > > >  static int doit_reply_value(struct genl_info *info, u32 node_id,
> > > > >  			    u32 error_id)
> > > > >  {
> > > > > @@ -225,6 +293,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
> > > > > +{
> > > > > +	const char *error_name;
> > > > > +	struct sk_buff *msg;
> > > > > +	struct nlattr *hdr;
> > > > > +	u32 threshold;
> > > > > +	int ret;
> > > > > +
> > > > > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > > > > +	if (!msg)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	hdr = genlmsg_iput(msg, info);
> > > > > +	if (!hdr) {
> > > > > +		ret = -EMSGSIZE;
> > > > > +		goto free_msg;
> > > > > +	}
> > > > > +
> > > > > +	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> > > > > +	if (ret)
> > > > > +		goto cancel_msg;
> > > > > +
> > > > > +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> > > > > +	if (ret)
> > > > > +		goto cancel_msg;
> > > > > +
> > > > > +	genlmsg_end(msg, hdr);
> > > > > +
> > > > > +	return genlmsg_reply(msg, info);
> > > > > +
> > > > > +cancel_msg:
> > > > > +	genlmsg_cancel(msg, hdr);
> > > > > +free_msg:
> > > > > +	nlmsg_free(msg);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
> > > > >   * @skb: Netlink message buffer
> > > > > @@ -358,6 +463,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > > > >  	return node->clear_error_counter(node, error_id);
> > > > >  }
> > > > >  
> > > > > +/**
> > > > > + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> > > > > + * @skb: Netlink message buffer
> > > > > + * @info: Generic Netlink info containing attributes of the request
> > > > > + *
> > > > > + * Extracts the Node ID and Error ID from the netlink attributes and retrieves
> > > > > + * the error threshold of the corresponding counter. Sends the result back to
> > > > > + * the requesting user via the standard Genl reply.
> > > > > + *
> > > > > + * Return: 0 on success, or negative errno on failure.
> > > > > + */
> > > > > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> > > > > +{
> > > > > +	u32 node_id, error_id;
> > > > > +
> > > > > +	if (!info->attrs ||
> > > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > > > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > > > +
> > > > > +	return doit_reply_threshold(info, node_id, error_id);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
> > > > > + * @skb: Netlink message buffer
> > > > > + * @info: Generic Netlink info containing attributes of the request
> > > > > + *
> > > > > + * Extracts the Node ID, Error ID and threshold from the netlink attributes and
> > > > > + * sets the error threshold of the corresponding counter.
> > > > > + *
> > > > > + * Return: 0 on success, or negative errno on failure.
> > > > > + */
> > > > > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> > > > > +{
> > > > > +	u32 node_id, error_id, threshold;
> > > > > +
> > > > > +	if (!info->attrs ||
> > > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> > > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > > > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > > > +	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> > > > > +
> > > > > +	return set_node_error_threshold(node_id, error_id, threshold);
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * drm_ras_node_register() - Register a new RAS node
> > > > >   * @node: Node structure to register
> > > > > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > > > > index dea1c1b2494e..02e8e5054d05 100644
> > > > > --- a/drivers/gpu/drm/drm_ras_nl.c
> > > > > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > > > > @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
> > > > >  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > > >  };
> > > > >  
> > > > > +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> > > > > +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> > > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > > > +};
> > > > > +
> > > > > +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> > > > > +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> > > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> > > > > +};
> > > > > +
> > > > >  /* Ops table for drm_ras */
> > > > >  static const struct genl_split_ops drm_ras_nl_ops[] = {
> > > > >  	{
> > > > > @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> > > > >  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > > >  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > >  	},
> > > > > +	{
> > > > > +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > > > > +		.doit		= drm_ras_nl_get_error_threshold_doit,
> > > > > +		.policy		= drm_ras_get_error_threshold_nl_policy,
> > > > > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > > +	},
> > > > > +	{
> > > > > +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > > > > +		.doit		= drm_ras_nl_set_error_threshold_doit,
> > > > > +		.policy		= drm_ras_set_error_threshold_nl_policy,
> > > > > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > > +	},
> > > > >  };
> > > > >  
> > > > >  struct genl_family drm_ras_nl_family __ro_after_init = {
> > > > > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > > > > index a398643572a5..57b1e647d833 100644
> > > > > --- a/drivers/gpu/drm/drm_ras_nl.h
> > > > > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > > > > @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> > > > >  					struct netlink_callback *cb);
> > > > >  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > > > >  					struct genl_info *info);
> > > > > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > > > > +					struct genl_info *info);
> > > > > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> > > > > +					struct genl_info *info);
> > > > >  
> > > > >  extern struct genl_family drm_ras_nl_family;
> > > > >  
> > > > > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > > > > index 0beede3ddc4e..b1fa87975cc5 100644
> > > > > --- a/include/drm/drm_ras.h
> > > > > +++ b/include/drm/drm_ras.h
> > > > > @@ -71,6 +71,35 @@ struct drm_ras_node {
> > > > >  	 */
> > > > >  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> > > > >  
> > > > > +	/**
> > > > > +	 * @query_error_threshold:
> > > > > +	 *
> > > > > +	 * This callback is used by drm-ras to query error threshold of a
> > > > > +	 * specific counter.
> > > > > +	 *
> > > > > +	 * Driver should expect query_error_threshold() to be called with
> > > > > +	 * error_id from `error_counter_range.first` to
> > > > > +	 * `error_counter_range.last`.
> > > > > +	 *
> > > > > +	 * Returns: 0 on success, negative error code on failure.
> > > > > +	 */
> > > > > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> > > > > +				     u32 *threshold);
> > > > > +
> > > > > +	/**
> > > > > +	 * @set_error_threshold:
> > > > > +	 *
> > > > > +	 * This callback is used by drm-ras to set error threshold of a specific
> > > > > +	 * counter.
> > > > > +	 *
> > > > > +	 * Driver should expect set_error_threshold() to be called with error_id
> > > > > +	 * from `error_counter_range.first` to `error_counter_range.last`.
> > > > > +	 * Driver is responsible for error threshold bounds checking.
> > > > > +	 *
> > > > > +	 * Returns: 0 on success, negative error code on failure.
> > > > > +	 */
> > > > > +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> > > > > +
> > > > >  	/** @priv: Driver private data */
> > > > >  	void *priv;
> > > > >  };
> > > > > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > > > > index 218a3ee86805..27c68956495f 100644
> > > > > --- a/include/uapi/drm/drm_ras.h
> > > > > +++ b/include/uapi/drm/drm_ras.h
> > > > > @@ -33,6 +33,7 @@ enum {
> > > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
> > > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> > > > > +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > > > >  
> > > > >  	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
> > > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> > > > > @@ -42,6 +43,8 @@ enum {
> > > > >  	DRM_RAS_CMD_LIST_NODES = 1,
> > > > >  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > > > >  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> > > > > +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > > > > +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > > > >  
> > > > >  	__DRM_RAS_CMD_MAX,
> > > > >  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> > > > > -- 
> > > > > 2.43.0
> > > > > 
