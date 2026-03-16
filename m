Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235C1D58B09
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6C610E2BC;
	Mon, 16 Mar 2026 04:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Uw+tTkU5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85BB010E2B9;
 Mon, 16 Mar 2026 04:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773634504; x=1805170504;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=yUrCbbwWVbizDQuJWFTM2YX0l2JV8TloDYYlTdmSXgU=;
 b=Uw+tTkU5bNbfr5qwb+RyGbBm6UVEoRqH8BXXAgh62m8QDv/1ypAyoCaZ
 NYxo/sT+qPCl6dMrzSkKn9ASO8Ij8nebsOfwf1cTcJJ/nu1hrRCGFKb8L
 B1HFzQkM4Cs60nHkGf78Nneo+YUP728gB1AWjRPaGgi681bT+Qk2smyhd
 A6EACk+sF7My6MCjjVaSo5eQURoS8gtCOYZlCvMjGlgTe17XSl0HvV22Q
 n3ARAkmcNf7MNMp6/3HhqQlWeXsRHljLsMAKq5Tb9Rg8yJ4tcokSsPsHH
 o2Z4XIQNQzHQ+4lwhIieQhKxPXyGz8SRxiAPUbL5kOqdFY/ztfP2XHJsJ w==;
X-CSE-ConnectionGUID: OUdX1NRITvKQw++bwTBTpg==
X-CSE-MsgGUID: gvGEH4LfQNWaL7wBY1l/9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74759598"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74759598"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:15:03 -0700
X-CSE-ConnectionGUID: JXYtk90dRtuTgfTn/PleHg==
X-CSE-MsgGUID: ZzzqqmMXQLKaPfFRZHlqKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="224039395"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:15:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 21:15:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 21:15:02 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 21:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbPg3+DfIrLHwzUmlJGgGbemNrAf2jkor0bk+QNO8+NcWBDlO3Y0zHMJmvvpc6MEi28OzVuq5gqIf8NwqobwdpZLXKp9yZr/X8JtKu+88Ymvi/YKhzFceFltJZ5tvwpL5qD9buvPetShJEWV/a+owMdiNixmkA77Eae5GVdKDKeNYI7Kb0XfmqJPKxC16fTAGCOTpsmUg1hVPF/+OpYdbOpMl3tnPuSdD4+K5Ye/Vo6x3dmtXOXGvi2PJzHkitNAeIrHZ/BMNf5RklEQRRszhH3pCyn/GqhLrqdSfQ+nKyQNRSzBonvfkBZx8CilxRPeXgvA9Z8d7XUQ5LU5SFNlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0ZLKlryeWArZ5BP5GNzRRV9zsDK9LttFfwlsBkAZdc=;
 b=hTvWn9/r3O5OkvzmGc+d/6wvZMbIQC7PcOCH9T/8xtbAN02kJ0rUkULOVjfceyFpbNYMZmAGx2n5e05069Oem3UCKeHeaFsOfeUe0ZQwkXHy3SfXyG2Uqxjj0G3Lvald/4qGJX3iF/zlAW4u1MwAYsyEoBMO34/CAqvc2W8Bvr8vNNB0ZoHwn2xI44s/aPv8TRNpPuVWiRaYrEfNyJ3tfbABBmLFEyHcLA+R2HdUX4UCrzsHR9rb2EUwHk4/Kk6nojn4ZiOr3NEVbg6olMw/3ZEsS6Ouq7hBSt6eFTBbhw2ELdAIjOAhyCk5U6Zyfnw/pCwfXlXNelGfCHTboLbeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 04:14:55 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305%5]) with mapi id 15.20.9723.010; Mon, 16 Mar 2026
 04:14:55 +0000
Date: Sun, 15 Mar 2026 21:14:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <phasta@kernel.org>
CC: Boris Brezillon <boris.brezillon@collabora.com>, Chia-I Wu
 <olvaffe@gmail.com>, ML dri-devel <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, open list <linux-kernel@vger.kernel.org>,
 <tj@kernel.org>
Subject: Re: drm_sched run_job and scheduling latency
Message-ID: <abeDvIC6mzo77Wl6@lstrano-desk.jf.intel.com>
References: <CAPaKu7RbCtkz1BbX57+CebB2uepyCAi-3QzBy8BDGngCJ-Du0w@mail.gmail.com>
 <aajkqXZDGUFPlq1o@lstrano-desk.jf.intel.com>
 <20260305092711.20069ca1@fedora>
 <fa4a9c55792b0e79d94faa82085b693aa7feb989.camel@mailbox.org>
 <aalIbgi71svPQs3Z@lstrano-desk.jf.intel.com>
 <9949a2c27b2a1dc1cde10dbb89edec53411614b1.camel@mailbox.org>
 <abeBgAXU8eG8tddH@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abeBgAXU8eG8tddH@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: dedf1e3b-0513-4893-d827-08de83129416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NJsexTGIl9qdg/fwI+QNGE/i08OnKnZNtGuRsEJUXXXXG0z09mBFYFVgZsoxPdh9BsrQJuU9YBGWsyyZqXMXPc4nOFgQwuHcqp4S5r3/NuCqh0LRgNAj+sTeoyZF0nsUZsyRES6L9i1qxnB2Z9sPWIOL2unnqoIrna5OcnuZ6H+LNJ4o0FAeNXrG+InK474Pwl6XAcHxUDlylnc3WcTFVY/LcN2BT4xzkpdZIN6wnJa4s2W2B9Pv/ckQ062y/8NdJp/riq2GfvT+MSBgBzCH0lnHoWdYePdnZLB7vZPk3ZQzid8vi1wpf5+CcafE9MD6JeolSjVNZfy0r3LQeSaIeVy/9iUVigKYfH8vi+2HyV8deG37exBsmheW7R+2ChrJ7kDNpGWAyZwKSGSHQxHxFmex9nGSaG+cNJjQc56I4aGsLGxXYnS/m3KmHD+Z+sxpR0/OzMia8ypOXGDDQlYr+2xVX4/J521P8/XXPrsjlVb+ewdkVk2BwiXfRAQjInHMcls4YUlWsnsij3ExmOANl1gGX+jJJkul+m2TeqfT2AXHNoYKQwaQT5Bzlc3jo1Jg6x7NnRR0pJ5yax6ulHjrXykjEBiVKDVx53yl/WhcQmV+5nzH5WD33zCiasttSp1w9JmofyM19PnjS/y90+sOXC5nXpq9yDfrGiY66L8R6nhSddCVss6aloY7SSJoxLY4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJuMzZRQVFWMjNXSDRaVTJmTExQZWJHZ3hDeFJJVkI5bFBLdGxRQnUyVGR3?=
 =?utf-8?B?TURBTWJUS3N2bW5mVEpQUEZNVHJxaUZJekJsbGtLUkhqbVFhSTBZSzhiM2oy?=
 =?utf-8?B?Ylg5c0NrMG9ObjRlMUZXcVRnZGMrbWhIQWZqSEtCV1pEb3ZhVzFRRS9IZDFM?=
 =?utf-8?B?MnlhTXhUTkN3YTNReklqd0hJNENqeWVnTW5PWXhqK0JGTUZSWmRXWFRzR0Vk?=
 =?utf-8?B?OXN4WEx0N1l5eEpjaGpIeURGWWFQbkVITDZ4TFMyTjQycExpZXpKelJGMWVN?=
 =?utf-8?B?ZXNZU1BTdEYrQ0VwQjcrMjIyUWFaNVltYm5TODA1VmtXVWVPZjBtUmVLa2hh?=
 =?utf-8?B?QUdKcDIvL1ZjTy91cE9EKy9IZ2pYMkpIODdwa0VKeHhFZlZITnpoWUV0RUNJ?=
 =?utf-8?B?dUhiaGUxaStPWDV5bmYySFY2NTFNeW5BTU12dTdPOFI1NWswYWVmVlpWdFBv?=
 =?utf-8?B?cUJ0NERtaTltU3pMQ0FxdHJhVGZad0VHWXMwaUh0cndYeU5QNElXcjRuRzZn?=
 =?utf-8?B?blp6UUpQYy9hNTZCQ1daNmsxeHZQUjNMK2R6RUxLbHJrSDNRRVRaNFFwZ1lu?=
 =?utf-8?B?ZHJVbEZMeVo1ejRhZExoMmJWa3p3bS9HS1JBdFEwbDQwK0VhZWtQdjNKM3la?=
 =?utf-8?B?dnVoSkFtRXgzVzFSQzB0QVVZL1UxUU9RVGlHb0lOQk11QXhWZkN0Wk9CRlZS?=
 =?utf-8?B?WlFiYjYxY0d6Vlp5Q3htVS8rWmtsdkhmTVlsN2pPWW9pcE5jR1lNZ2FldDFP?=
 =?utf-8?B?UWJLSlNsbTIyc3hYME1pMHNKZ2gyN3FTditSUVlOaW5OYUNvZVdxWDhYaTlX?=
 =?utf-8?B?UjBJemcwOEdYUHZnWll4Y3paOWR5U0E3UG96dThtNHR4Y2piTVVONzA3Sm1O?=
 =?utf-8?B?aTJaVDZZN1N2WU1WRzl3QXdQLzFWQTVIYW5hYmFFTUdPQzhLWWswT0F2bTFM?=
 =?utf-8?B?WjNTalVENDZQZUEzQlBqZFMyTEtVSjlWMm9vbTAwMTlTaXlnOVJxemlpanRI?=
 =?utf-8?B?Tkw5aXNVY2tVVEw5RVEvbk9sQm9HNW5JQnRoR25oVlJmL3F4aXdxQnNqWWlN?=
 =?utf-8?B?MGt1eWR3VDc3elIxZlpqOEdkVDkwSVJ1cjE5aWIvbEdRL1B5THRtZGE1d3dZ?=
 =?utf-8?B?S0dTbFFPbE1RWnZuQjR3c1FXdSs0Z3UwOEJ1ZWVqZUtOS1NSMm1ZUXMrOTZ4?=
 =?utf-8?B?VWlGV0FCbUM0MUwzMVJZaVNLcnBhd05WbHY0SXVwVmEyNDNkUzkxOXBQZWsw?=
 =?utf-8?B?cWhwVUN0b1J1aGNWWFVnRVFTZ2xCbTVza091dEdvYzR5R3AzNVFveWtHZzlU?=
 =?utf-8?B?NG9VenlrTnhQSkNwd2thejdtOEYrVkwrM3dwMFlqUmM4UjVPRkc2UFRvUHBN?=
 =?utf-8?B?NWgybDZiOXRqL00yRHhaMnJZcWJpaDFMOFMwVzBzU2xTRWMrWlZ2TG0yZGtY?=
 =?utf-8?B?UmhGKzFkay9jUEJpUlBKV0U5Vlp6TGw5Ti9HUUR1UFdMWExHSjZjaGNaVHVB?=
 =?utf-8?B?K1dLKzA0WllnZVdmdmp2bmFMMUdZWVRnMU5qZmxZOWhobTFNT3hpa1NJRm9r?=
 =?utf-8?B?VjdMTWZ4UFpadFpxMi96cG5pdnZYL3V5Nm5zTnB6V3o2bXk0THowZ1VJb2pF?=
 =?utf-8?B?NnhiMjNySDJ2ZGthK2pYNURCM3czUGM3TWJTQVVMeEFveTM4K3l6bGU2Y1FS?=
 =?utf-8?B?L0U1M3QwaHl2amRzY1dUZGdCMUxFQXMyeEVhTlEyQkIwT200bk9HUnBIOWdv?=
 =?utf-8?B?ZXRkQWtET3l0OGJsRGFTSkI2UGhGUG5zN2hnbWdjano5Y1lZNU1vbmMyVVJ3?=
 =?utf-8?B?SFM0MS9EVnE2STIvUlV0MFp5eE1LNHQyaFpQYUJRWGtFTW1JTTBlb1FUa3gr?=
 =?utf-8?B?RzJPTllNaGZucUtIUnA5Y05oTlIrekZHMVA0aHpsbTcrSzFIMFgxaHlMM0w5?=
 =?utf-8?B?ZmE0TE9uSGNiMjNqeXVNNkRRZnNZZ2NFUGY0d3F2T0lzendHdWZZbkJOcmJw?=
 =?utf-8?B?N2JsY1hsaW5EY2tINmRZRWNWaDViSlgwZjczMWw1Q3N2WDVXSnEwcys4eHZU?=
 =?utf-8?B?cnZDVCtiUkx3Y3FCcWI3YTdiQmVyMmtra3NEeURFb0g0bU81SEJjbUQwUFBX?=
 =?utf-8?B?TGduOC94K0JOQXBaR3lIOS81clVZdjE3NEpOc1VETlZtVTFlMytRRzVLWXY5?=
 =?utf-8?B?YWFwTlZkandZU0gzYWZSVk1pUFp6SWpvWXVLK29XaTNENkNxbHBKczhmYW0r?=
 =?utf-8?B?R3FtT0JrZTdTMEo3YlFlQklqazQwbml2ZzF0L25OaFJ5MHppL0kvK2k1ckxF?=
 =?utf-8?B?bmUwTUFRbUozZ0YvcUtHM2VRendyanVDWTdELzB0S09aemptODB0cTJqNG1a?=
 =?utf-8?Q?Z3Pu/SAgl6EpFW1g=3D?=
X-Exchange-RoutingPolicyChecked: rJU4g0RWmCREcQe3Te37jPqvyi+r0lskFUFoNn98R8sN6HoUbyAQHKz8OoEoqr2+3uOmtb6tmDjk783Vw2CjA7L3Kik0oi1UbNKr+r+KqMkrPMYg14FfzOIir50MT1pQy4R5pBWMKmGk6hmBZfI0a0hUaKeJnM4CWZzL3Z/5iET2K7RzviNzBkEpxLf4O6H1ovt3HYK4wi6us3EXrU4C1OiWTiqal/i5yhfpo0/xKfTo1yFHOFl2dWzY6b3kjoioRRS5QkJ9X0Tosaz2iE5/9+oCmGc+xXr2yvm/1+Y+jNB512EN3fbx8/0Lh3GHJsLo6VpgCwGbX9rWb1IY+iw4wA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf1e3b-0513-4893-d827-08de83129416
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 04:14:55.2402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVHQsuuMX53MNbKKYUCziAoCOPB6lmeyZK74/MRDA9W/VaVmjLqWf5267sg8jUX21N+9jD1VitA2N7DqOAcUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
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

On Sun, Mar 15, 2026 at 09:05:20PM -0700, Matthew Brost wrote:
> On Thu, Mar 05, 2026 at 10:47:32AM +0100, Philipp Stanner wrote:
> 

Obviously this was intended as a private communication — I hit the wrong
button. I apologize to anyone I offended here.

Matt

> Off the list... I don’t think airing our personal attacks publicly is a
> good look. I’m going to be blunt here in an effort to help you.
> 
> > On Thu, 2026-03-05 at 01:10 -0800, Matthew Brost wrote:
> > > On Thu, Mar 05, 2026 at 09:38:16AM +0100, Philipp Stanner wrote:
> > > > On Thu, 2026-03-05 at 09:27 +0100, Boris Brezillon wrote:
> > > > 
> > > > > 
> > 
> > […]
> > 
> > > > > Honestly, I'm not thrilled by this fast-path/call-run_job-directly idea
> > > > > you're describing. There's just so many things we can forget that would
> > > > > lead to races/ordering issues that will end up being hard to trigger and
> > > > > debug.
> > > > > 
> > > > 
> > > > +1
> > > > 
> > > > I'm not thrilled either. More like the opposite of thrilled actually.
> > > > 
> > > > Even if we could get that to work. This is more of a maintainability
> > > > issue.
> > > > 
> > > > The scheduler is full of insane performance hacks for this or that
> > > > driver. Lockless accesses, a special lockless queue only used by that
> > > > one party in the kernel (a lockless queue which is nowadays, after N
> > > > reworks, being used with a lock. Ah well).
> > > > 
> > > 
> > > This is not relevant to this discussion—see below. In general, I agree
> > > that the lockless tricks in the scheduler are not great, nor is the fact
> > > that the scheduler became a dumping ground for driver-specific features.
> > > But again, that is not what we’re talking about here—see below.
> > > 
> > > > In the past discussions Danilo and I made it clear that more major
> > > > features in _new_ patch series aimed at getting merged into drm/sched
> > > > must be preceded by cleanup work to address some of the scheduler's
> > > > major problems.
> > > 
> > > Ah, we've moved to dictatorship quickly. Noted.
> > 
> > I prefer the term "benevolent presidency" /s
> > 
> > Or even better: s/dictatorship/accountability enforcement.
> > 
> 
> It’s very hard to take this seriously when I reply to threads saying
> something breaks dma-fence rules and the response is, “what are
> dma-fence rules?” Or I read through the jobqueue thread and see you
> asking why a dma-fence would come from anywhere other than your own
> driver — that’s the entire point of dma-fence; it’s a cross-driver
> contract. I could go on, but I’d encourage you to take a hard look at
> your understanding of DRM, and whether your responses — to me and to
> others — are backed by the necessary technical knowledge.
> 
> Even better — what first annoyed me was your XDC presentation. You gave
> an example of my driver modifying the pending list without a lock while
> scheduling was stopped, and claimed you fixed a bug. That was not a bug
> - Xe would explode if it was as we test our code. The pending list can
> be modified without a lock if scheduling is stopped. I almost grabbed
> the mic to correct you. Yes, it’s a layering violation, but presenting
> it aa a bug shows a clear lack of understanding.
> 
> > How does it come that everyone is here and ready so quickly when it
> 
> I’ve suggested ideas to fix DRM sched (refcounting, clear teardown
> flows), but they were immediately met with resistance — typically from
> Christian with you agreeing. My willingness to fight with Christian is
> low; I really don’t need another person to argue with.
> 
> > comes to new use cases and features, yet I never saw anyone except for
> > Tvrtko and Maíra investing even 15 minutes to write a simple patch to
> > address some of the *various* significant issues in that code base?
> > 
> > You were on CC on all discussions we've had here for the last years
> > afair, but I rarely saw you participate. And you know what it's like:
> 
> I’ll admit I’m busy with many other things, so my bandwidth is limited.
> But again, if I chime in and explain how I solved something in Xe (e.g.,
> refcounting) and it’s met with resistance, I’ll likely move on — I’ve
> already solved it, and I’ll just let you fail (see cancel_job).
> 
> > who doesn't speak up silently agrees in open source.
> > 
> > But tell me one thing, if you can be so kind:
> > 
> 
> I'm glad you asked this, and it inspired me to fix this, more below [1].
> 
> > What is your theory why drm/sched came to be in such horrible shape?
> 
> drm/sched was ported from AMDGPU into common code. It carried many
> AMDGPU-specific hacks, had no object-lifetime model thought out as a
> common component, and included teardown nightmares that “worked,” but
> other drivers immediately had to work around. With Christian involved —
> who is notoriously hostile — everyone did their best to paper over
> issues driver-side rather than get into fights and fix things properly.
> Asahi Linux publicly aired grievances about this situation years ago.
> 
> > What circumstances, what human behavioral patterns have caused this?
> > 
> 
> See above.
> 
> > The DRM subsystem has a bad reputation regarding stability among Linux
> > users, as far as I have sensed. How can we do better?
> > 
> 
> Write sane code and test it. fwiw, Google shared a doc with me
> indicating that Xe has unprecedented stability, and to be honest, when I
> first wrote Xe I barely knew what I was doing — but I did know how to
> test. I’ve since cleaned up most of my mistakes though.
> 
> So how can we do better... We can [1].
> 
> I started on [1] after you asking what the problems in DRM sched - which
> got me thinking about what it would look like if we took the good parts
> (stop/start control plane, dependency tracking, ordering, finished
> fences, etc.), dropped the bad parts (no object-lifetime model, no
> refcounting, overly complex queue teardown, messy fence manipulation,
> hardware-scheduling baggage, lack of annotations, etc.), and wrote
> something that addresses all of these problems from the start
> specifically for firmware-scheduling models.
> 
> It turns out pretty good.
> 
> Main patch [2].
> 
> Xe is fully converted, tested, and working. AMDXNDA and Panthor are
> compiling. Nouveau and PVR seem like good candidates to convert as well.
> Rust bindings are also possible given the clear object model with
> refcounting and well-defined object lifetimes.
> 
> Thinking further, hardware schedulers should be able to be implemented
> on top of this by embedding the objects in [2] and layering a
> backend/API on top.
> 
> Let me know if you have any feedback (off-list) before I share this
> publicly. So far, Dave, Sima, Danilo, and the other Xe maintainers have
> been looped in.
> 
> Matt
> 
> [1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/tree/local_dev/new_scheduler.post?ref_type=heads
> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/0538a3bc2a3b562dc0427a5922958189e0be8271
> 
> > > 
> > > > 
> > > 
> > > I can't say I agree with either of you here.
> > > 
> > > In about an hour, I seemingly have a bypass path working in DRM sched +
> > > Xe, and my diff is:
> > > 
> > > 108 insertions(+), 31 deletions(-)
> > 
> > LOC is a bad metric for complexity.
> > 
> > > 
> > > About 40 lines of the insertions are kernel-doc, so I'm not buying that
> > > this is a maintenance issue or a major feature - it is literally a
> > > single new function.
> > > 
> > > I understand a bypass path can create issues—for example, on certain
> > > queues in Xe I definitely can't use the bypass path, so Xe simply
> > > wouldn’t use it in those cases. This is the driver's choice to use or
> > > not. If a driver doesn't know how to use the scheduler, well, that’s on
> > > the driver. Providing a simple, documented function as a fast path
> > > really isn't some crazy idea.
> > 
> > We're effectively talking about a deviation from the default submission
> > mechanism, and all that seems to be desired for a luxury feature.
> > 
> > Then you end up with two submission mechanisms, whose correctness in
> > the future relies on someone remembering what the background was, why
> > it was added, and what the rules are..
> > 
> > The current scheduler rules are / were often not even documented, and
> > sometimes even Christian took a few weeks to remember again why
> > something had been added – and whether it can now be removed again or
> > not.
> > 
> > > 
> > > The alternative—asking for RT workqueues or changing the design to use
> > > kthread_worker—actually is.
> > > 
> > > > That's especially true if it's features aimed at performance buffs.
> > > > 
> > > 
> > > With the above mindset, I'm actually very confused why this series [1]
> > > would even be considered as this order of magnitude greater in
> > > complexity than my suggestion here.
> > > 
> > > Matt
> > > 
> > > [1] https://patchwork.freedesktop.org/series/159025/ 
> > 
> > The discussions about Tvrtko's CFS series were precisely the point
> > where Danilo brought up that after this can be merged, future rework of
> > the scheduler must focus on addressing some of the pending fundamental
> > issues.
> > 
> > The background is that Tvrtko has worked on that series already for
> > well over a year, it actually simplifies some things in the sense of
> > removing unused code (obviously it's a complex series, no argument
> > about that), and we agreed on XDC that this can be merged. So this is a
> > question of fairness to the contributor.
> > 
> > But at one point you have to finally draw a line. No one will ever
> > address major scheduler issues unless we demand it. Even very
> > experienced devs usually prefer to hack around the central design
> > issues in their drivers instead of fixing the shared infrastructure.
> > 
> > 
> > P.
