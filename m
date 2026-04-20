Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F58F5A8CA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB9010E778;
	Mon, 20 Apr 2026 23:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cFthEILO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27C310E0BA;
 Mon, 20 Apr 2026 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776729182; x=1808265182;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=bsOZsx9+53XjxXD5SrkxSKntx15jzN5cU3JFx6PUK+4=;
 b=cFthEILOGTqrobqisYKhXT/LFygLQgpjH0VLEvMccZIPEK17cUtIkR9C
 eiNajlgR4Gk/FfixidtB4SK3bxgLnjgV/sgbpzWp+xA6ve/JI6JRgt9sJ
 DhImNqkEErYeYIX5vR1lP7ouRGMpCohOj+TrzS/BYwVyvi1V0G042H7mH
 lOGJyiD22CKiIRR8Q6ddJNEE+MQ4b9OmaKo+VeRQ5fBprHzil0C4lIw3c
 UYBW4pbooKWVBnDqyZfzbLgdtFvGTKCqomi1zh7pp4LmNvmwC1LvnuBiI
 n3cVvuDEtfSrcFoXab8bv6uAoTDD7trMbSabafYTA872xLn0U6Omsr3UE w==;
X-CSE-ConnectionGUID: A/FjxB9YQgip5A8xBXCu+Q==
X-CSE-MsgGUID: JDpjOAYuSwuX3FLbjGfhQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="100314094"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="100314094"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 16:53:02 -0700
X-CSE-ConnectionGUID: bRhNyba4QV+IG4NRu0I2lw==
X-CSE-MsgGUID: tmzL1UcmSJa/6+hc9aQUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="228709384"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 16:53:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 16:52:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 16:52:59 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 16:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkXydrItduzyhgIIruHEHK4836ElKhsuiGRkodRdoR82sDW6prF56LySCkJ2ecpuR/zCmSD2ZddRjNxWO/BJGKbB1peEGMYWK7gtLJTvuW5rruFsfC/CxJhYpT+IW5RRcoQWiH06D1Tf4RxNKhIwX8+a9WdVNcwksjbAfrPf2oe8rPXKkK0ogTqW4WsLDlJFbKyI0TDWi5ZrYEqKOb8Ya3t3ftJ0AYb7svPXUSLhhNfcdsK7dyQbKuab1O5Xp3g67zoOrnus0Shj7MAe208QPLbM1WTcPWGJkE9kZPdOogpB3TtpCuTMh1wbNt+HeTfRMMzHg0YdTWd2Br+TkxA3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GBjtr31vkhQ+J4xv3EZz2TObLkdgvefHnhxRCcj3nk=;
 b=hNptNPUo/oi6JN15ks804V3NBfKh1aUnvcC3kF4KbaWDTOrnq77KiD7eeVTN7MWmovtEQIG2+Ac7X7bdRQuYjq2D0FY6W4VOkSnZw7TISUSpSf3lzQs+QfGuS+m6Hq+7vB4YPZgmPFTWZE7Myxuv9eNwqRI5ExEUHg8wLIBE4OC+Y9mO9+AWK0jDmId70bufXfX1UMGpqeC06Czyez9xtEv/8XjZrXxWyrrQ5/ceY7emngn76ETC3TjQ9gyl7bxGMOMn4xTLrsegYxOKp2JZuAkhj1OUF2Apof5VqCxnQ7F+HK1H8sBdx9pCzLBuo6FHXwFmN6poLH+VoNqos6zAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 23:52:49 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 23:52:48 +0000
Date: Mon, 20 Apr 2026 16:52:45 -0700
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
Message-ID: <aea8TXx3fKigzNv7@gsse-cloud1.jf.intel.com>
References: <87341fsa85.fsf@dancol.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87341fsa85.fsf@dancol.org>
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 2484daad-9a89-4a44-10ed-08de9f37ed02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: lvQYW6Y4AeJwIJEdzges74IKpFY/saENQg9HU1gLxgkSkDOVH9S+0C3j3R7MQotNEOj1NqcRoJ7FZDdnXybScdPFaRoly87QXBSr7OBuOJKODtlUbJHLmVgXI7w2EQ/iuOoMxDKwG+22WjG12ZLriuMSQLArUJWfqeFLroFiks+6y405J6+5pFGxGiMbXfH44KnmS9uMlLImFZx0UsBEm7rDQJu/cStfwVKICMgdGOrTHNg8C7UcZOeJWZth+nB4eIL+2L2mMc7qzY9EazDQffqjLaeYz+ovF0fZ7oq4xklMsmHxH1Y+Qrk3jANneGvCQC0dN3OOfXEutfDy+G22wY8Gb7KEvgjcLqh4o3GLmYOCC1PwoSFF2hESN252ZbzyIn9SSEhckK/PkmUR2FgAoDupO1w/bQ2GXuCFJD1tFJa5DaJO8278OJmUtb3tfyQUGLaIaxXJm+an5QWq7itIx1CcVGhMNirzNSVi8hHvDuoDXtH/jKo9SdQkN5xEU+N+8UnQjUBMHcjSjwtLi0+ppyzgE+m6kG2sJzmIUhBeX71hR+a3iZUOsCEAUE0nzkJRLukfUDb8mkLHWsVQhj4LUCelrOiU60yMQq88TptKeNMIU6h1bf0xkRMLTM+nshF7Q/Hhi70efR9Wgw7KjdsyLckFOONTrcP7QdG5m0EX62TCb2YiuenO8s3i8tHF8r4OeTowdNRgWBPvqkz6AUlb0bcV6Pk7m3Ulz9nxl2fkBGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNjL1RFZnkvSk1zaUpyaXZJeXFyRmZSYXdwTWwzNERmakMvbEFRUEk0YTM5?=
 =?utf-8?B?QUh4MzM2ZnZ0VldzRWtYbzFKakhibDFIM20zUW5hRzQ4SVpEakxDb3Y5WkJq?=
 =?utf-8?B?SS9GT2xNVmZBRlBGak8ySnBPUFp0ZTZ0K25PSUJRaGUwUXFnOWxrUzRaU2NX?=
 =?utf-8?B?MUlUd1dIZ3NiU0F2SWpvTkZqWm1nQ0JKTjRzS2p1OE4xZlNmZzZqUC92Yk5R?=
 =?utf-8?B?QUlXbGl3TjFxTE9hVmROaWhxNXFtemZ2akIra1ZJMXF0UitMalcvVkJycGVT?=
 =?utf-8?B?SHBLYUJDT0h5Q1laWG1VY3lYMnFDc0ZlTWZENlFPNzFRM1pBam80T1h5bHZC?=
 =?utf-8?B?NjAyMnFicDcxdXlnRWxVVWdGQXMvRHh1UXBrcXliM0M1OUIvdGk0eVhiTkxM?=
 =?utf-8?B?THRJZ0c2d3d6VTFQTUlVOXdsRVhEa2tmSGIzcURjaDFsZ2VwY29ZbEZnY3h2?=
 =?utf-8?B?VE96MEs1TDFtNlRlSlNJSUZGNklYWFZZdmZQakhNTEpCQlBPZlZtNHYzc1Jp?=
 =?utf-8?B?RStqa2tnSXI4cXVrMTViSFU2QU5MOFBxaEp5U3NuUk5Iajl0RVV6NkdGdVQ2?=
 =?utf-8?B?MjF5OWFVMDdZbDE1UC80QTdjNU9ZRHpuQVNBenBnd0l1WEw0YVI3ZHRJTC84?=
 =?utf-8?B?SWJ2NGhEbmZPakk5Y0Vvdk5wRzZTMUlQbnBselREdFhaOTV3Q1FiR1Z3dXVU?=
 =?utf-8?B?cWg3N2tsZ1FUakpNcXdlSE9xTGdvUDhTSjNLTHJLZGMwMktCRVJyd3YrRTJB?=
 =?utf-8?B?eFByVFdyMGQ3MkltN3djN2NqY3VsMy9rcTA3cTRIam52V3F0cEx5cWZMTlVu?=
 =?utf-8?B?UnhtWjloWlhiNU9lL0wrb1FPQ3NaSUdNVlFkNk4yUnlHa0o2U3lxalRveExk?=
 =?utf-8?B?bjVvUEhPL3FBNVhFNjRyTWZmZElpM3NFZXM1Z2k2ekRHUTRIK0k5M2ZiQnA5?=
 =?utf-8?B?b09JK1IrRy9XQmRxQmRnMEYxZHdPVStHTUpHZ3grWVNMejNRT1IxK1dTZUxL?=
 =?utf-8?B?eFRrU1RHeVJTeFdnZGM4cFVXc1lNUmkvQWxpdXlYaWNjaGwwQUhFalZGQ21X?=
 =?utf-8?B?bmI5RWZQYU1HS2VnWURTUjJaSzhuTXhCcTFacmpQdUVQY2tRUXYzUVplUDdY?=
 =?utf-8?B?RExFak0rLzlVa0hySlpidG8rYnIzUXZXM0t2STdqZklsYmxqRmt4cnM4SDBJ?=
 =?utf-8?B?Y1JQSUtWSi9pU1B1RTN6MitRZ2EzcUtrYTN5QTF4WWxJZ2diTU1Gb3l3NjVo?=
 =?utf-8?B?bGt3clJ1QkZLK2M4MjBlcVcwQnNORFR4SkV2Z3J0L0xRbXc1RHg1ZUwzZXJM?=
 =?utf-8?B?ZXlRY3NFczNuTDBjMmptTnYxL3lnNndLWUNmWkpZSHMwV3QwSjlwb3JxMFFJ?=
 =?utf-8?B?WWFCWUlhRm1NeU51Y3JQVXYzajkrZVpFbDZrU215QktvclhFNVVXYmlLbnpz?=
 =?utf-8?B?QnYzNndlOEpRUE1MOFA1b0hYWHlpQ1hROWtWcm8zV3lwR2tNczlORHBSM1NX?=
 =?utf-8?B?TklteFhwWG1tMlpXMngvQ1NraWJKWis1UFpPaHdNVjlvYTQ1bUYxdk1nS2hZ?=
 =?utf-8?B?WHZPQW9HNURnT3d2QkNublpxaEhIVGVDVFpFTVJGNHlMRzlKN0tlZHpRZXpD?=
 =?utf-8?B?Zm9PWE1HTk5GNVdmWDN6Tjc3cXM1cHVpTWtkMXVyVDk5RTlrNGVzaXR2bkUy?=
 =?utf-8?B?MHpnQXNZczZEQVdncUdkZFFHeUROK1pxQWpEZDEyR052WGIrN1d0eEZTaWJX?=
 =?utf-8?B?OVBaMEVHa3BBR0xMVFpzMElVaTBodzdFblhSbEVXMGpocXlmc21oR2ZiM2Za?=
 =?utf-8?B?bDlJUDhLaGhxMjQ5UnpvMU9tRi9PdmIxeU5oZjRMai9LSFRtODg1aTlqMEJR?=
 =?utf-8?B?UElZN2ZGdDA1a2NLUmZwa212Uzk2dnEwN3VoUkxHQk14aWxvc3gxSmhNL2pi?=
 =?utf-8?B?Q0M0Ui9oQ0MrL3NXRlQvM0Mra0w3eUxaRk5NTVhQWU5YSEE2Vk5FaW1CL1Fm?=
 =?utf-8?B?ZE1hOU9acTJSRTlDYmszYnkzNnNaVlZIdzRXYzI3WlozNzZDMGF0UU14RWk2?=
 =?utf-8?B?VDJ2UWhURTVWY1VneTZOVG1tdklQdUc4V3NjNS9SeFFWSjNmUjM5RkU5Nkhh?=
 =?utf-8?B?VncraS9GODkvZGQxNXUvZEhxR2Joc0JSZzdiVHo3bk9KOXh4bHFWVHpaRWli?=
 =?utf-8?B?dmZEUnF5LzJSMWY4KzBWS0tEWVpIb0s0L3RtckNFN3orTEdpUG5VV0JITzNC?=
 =?utf-8?B?WHViQ0x6RDF5TjlBRitkeEQ5dzBKc2dSRTNQQldZa1NzTldXaG0wQkZjMHFz?=
 =?utf-8?B?OU1iWTdwSld1MEg1SGRKR3JNblI2czlQdTl1SjNVVU93Z1JkSEFQZz09?=
X-Exchange-RoutingPolicyChecked: jYnG+gx5s+5iI+/IlIEYOvY2ww5pLmYHY1XUsYVHpWcWfseU+GbZbiiCRMGTM6Ed+mwOgfSJSkq8wvHXm0zxIBMpjknPQ4TR9Ua1fSs22nlc//CyJNHvRzvyl8eYPaeG4qZ/QpAzwRUHd9Ixjht/G96cn6oN332HnS0Ps9qGvp/00Vwa03pIBpO6GA0BxACU63P90Ao1QyZHpQwUdshz2IXjXkCCGz5/b83gVy8R5oT4REykdhAaLGNK3xM6Y0Mvwc9cux/SnJzM7H858BodMB5/3oxdfhOCdYPraqPsSXadvW/CkxflxrvZzS64jx68leXPi110IN9lTYNuea2ciw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2484daad-9a89-4a44-10ed-08de9f37ed02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 23:52:48.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/rUIuACi/sjIyWxpSGIcYpztOn9fRui5boMzosFXKRCXn8Wnt3hVHH7ShQtByAvuLXJ9C5Ju5HCq3ynaVr/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
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

On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
> TTM seems to be too eager to kick off reclaim while kwin is drawing
> 
> I've noticed that in 7.0-rc6, and since at least 6.17, kwin_wayland
> stalls in DRM ioctls to xe when the system is under memory pressure,
> causing missed frames, cursor-movement stutter, and general
> sluggishness. The root cause seems to be synchronous and asynchronous
> reclaim in ttm_pool_alloc_page as TTM tries, and fails, to allocate
> progressively lower-order pages in response to pool-cache misses when
> allocating graphics buffers.
> 
> Memory is fragmented enough that the compaction fails (as I can see in
> compact_fail and compact_stall in /proc/vmstat; extfrag says the normal
> pool is unusable for large allocations too). Additionally, compaction
> seems to be emptying the ttm pool, since page_pool in TTM debugfs
> reports all the buckets are empty while I'm seeing the
> kwin_wayland sluggishness.
> 
> In profiles, I see time dominated by copy_pages and clear_pages in the
> TTM paging code. kswapd runs constantly despite the system as a whole
> having plenty of free memory.
> 
> I can reproduce the problem on my 32GB-RAM X1C Gen 13 by booting with
> kernelcore=8G (not needed, but makes the repro happen sooner), running a
> find / >/dev/null (to fragment memory), and doing general web
> browsing. The stalls seem self-perpetuating once it gets started; it

I’ve been able to reproduce this as well (including on Google) using 10
tabs of the WebGL aquarium with 5k fish and 8GB of memory set on the
kernel command line. It is indeed a really evil feedback loop. The fix
is a bit more involved than what was discussed in this thread, but I
believe I have a proper solution. I’m putting the finishing touches on
it now and hope to post something by the end of the day.

Matt 

> persists even after killing the find. I've noticed this stall in
> ordinary use too, even without the kernelcore= zone tweak, but without
> kernelcore, it usually takes a while (hours?) after boot for memory to
> become fragmented enough that higher-order allocations fail.
> 
> The patch below fixes the issue for me. TBC, I'm not sure it's the
> _right_ fix, but it works for me. I'm guessing that even if the approach
> is right, a new module parameter isn't warranted.
> 
> With the patch below, when I set my new max_reclaim_order ttm module
> parameter to zero, the kwin_wayland stalls under memory pressure
> stop. (TBC, this setting inhibits sync or async reclaim except for
> order-zero pages.)  TTM allocation occurs in latency-critical paths
> (e.g. Wayland frame commit): do you think we _should_ reclaim here?
> 
> BTW, I also tried having xe pass a beneficial order of 9, but it didn't
> help: we end up doing a lot of compaction work below this order anyway.
> 
> Signed-off-by: Daniel Colascione <dancol@dancol.org>
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index c0d95559197c..fd255914c0d3 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -115,9 +115,13 @@ struct ttm_pool_tt_restore {
>  };
>  
>  static unsigned long page_pool_size;
> +static unsigned int max_reclaim_order;
>  
>  MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool");
>  module_param(page_pool_size, ulong, 0644);
> +MODULE_PARM_DESC(max_reclaim_order,
> +                "Maximum order that keeps upstream reclaim behavior");
> +module_param(max_reclaim_order, uint, 0644);
>  
>  static atomic_long_t allocated_pages;
>  
> @@ -146,16 +150,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>          * Mapping pages directly into an userspace process and calling
>          * put_page() on a TTM allocated page is illegal.
>          */
> -       if (order)
> +       if (order) {
>                 gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
>                         __GFP_THISNODE;
> -
> -       /*
> -        * Do not add latency to the allocation path for allocations orders
> -        * device tolds us do not bring them additional performance gains.
> -        */
> -       if (beneficial_order && order > beneficial_order)
> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +               if (beneficial_order && order > beneficial_order)
> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +               if (order > max_reclaim_order)
> +                       gfp_flags &= ~__GFP_RECLAIM;
> +       }
>  
>         if (!ttm_pool_uses_dma_alloc(pool)) {
>                 p = alloc_pages_node(pool->nid, gfp_flags, order);
