Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B297F483DD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7099410E177;
	Mon, 23 Mar 2026 17:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Lc+nOQzD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7616010E177;
 Mon, 23 Mar 2026 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774287073; x=1805823073;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=l2/debKP3xZ1S2+uOZU1pq116y6bhhWh1SkzHDH6Odk=;
 b=Lc+nOQzDdIFGszH9EIzqrrL6cyislSZt1C4Z9oa0JnZL1/3cjlXHlf9/
 Fixrz0ZrfENgXfOLp213b3sIIsLAzNS7Nj4nVjKNTSe0Lqio1ETFKXr6t
 SyzDkI10VIrTEJaSaI6ofhFaumVduUE5bD30hiB/xz8AeXyzsR4n7rN0R
 sVXIagTVxI6rAfSjI2QKdpO4x0ja6bk7VUZXLHiL6XllKR7pvFK16U5Ns
 VYgJITnBQURxQe6WF4B+2BRMLe9nY3edZtf/VTucKecX6+8eAPA3vu4h/
 +LmQreaoIqHOpHO1/SSqoR/jjwtppS7NHwLkymTn22A7BLHOyYsHg7cEZ A==;
X-CSE-ConnectionGUID: zS63fonrRI6I9iDEKl+Kmw==
X-CSE-MsgGUID: JRPyslXwTsGFyCYqr+0uMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75174661"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75174661"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:31:12 -0700
X-CSE-ConnectionGUID: 6MifdQjsRAiTmMoV8zAVww==
X-CSE-MsgGUID: okylxcEnQBWyXaduVNHy0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="221253298"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:31:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:31:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:31:11 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsAgPyNmRr5MIlsA0XSTQNEyGHxue6LGNHYz1OPtl2nVzR8loK6SaX3aD6SokaQsfwUlCc8lKNkmcJOStGs/v8J/4aZMEgMuijqrH9K38/If92R5St1EF/f5iteaAc1PqgG5vkKnUZl3e2NNXjg1c46odsk1nucl8svrgHRl24baZF4faMQrK7hKLQVWVsi7ARyDSEkOdbY6nRxds3hZ39UwF9/8k9AWTm3CGTJi/ssZ6ULNViTjlrP3NikGbo9cGneZbVCfo7RPDLZwJFrPiew/UvoQok0cKEgZALc2B+EVGxuU6bDU96uqATIT2zSScPDZvIB/Iyn9AqSBu0hHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZMSpsaiRBl0IzecoJIlOr8A1F8ea0LiubCGYJW1/Oo=;
 b=N+sBT7s6IVo08O+ql5OKMe3mofOvMhk6XjaDBnvBkIxNRmvFrwBFPO+tmPViiwUSgP8tDmGkiNymA/iLIMwNlKo4/3adeS4gPTJOvg9CcQUB8uVmwoKtGW+ZDhSArz+oLfIy+HDFcRBK8tL72ZLQHpervqDSa3XxG2zsa1jPartBmbhZKm/sbJ5LWo3YT/mUJX6cQiPSPacjJuj0P+17DRxMSs6/aNK+Y0XvEjaaMDfunwDshFbXGccRZk4o7NEp0SBrx1GdbXcuVf+xHG+hgAZ9iu8GrDT51vcYZEJ2lqGqlDszLDDpWnEYLQlqDSrDD8Wh0DpAux0vCJKcBTcWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ2PR11MB8322.namprd11.prod.outlook.com (2603:10b6:a03:549::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:31:07 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 17:31:07 +0000
Date: Mon, 23 Mar 2026 10:31:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Stone <daniels@collabora.com>, Alexandre Courbot
 <acourbot@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot Courtney
 <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acF41mM66Gh7m4vS@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
 <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
 <CANiq72=gHArzFS=SkiZyPpEfSL+0AcU3ifKRnwfEyet42662PA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=gHArzFS=SkiZyPpEfSL+0AcU3ifKRnwfEyet42662PA@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ2PR11MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1d4488-ad12-4242-56b0-08de8901f79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 60ZBtoO41wRtPqpxLgW/GxoSmQ1tXm9Ji0kbUWKt5wDO9zEhfV81JoRBBnrn66mVJn8W6AW3Ip14x43HwWyoRNdHH9v1K7gwxZteLqz2M1f6NhvyDTPlVbnwWTR7m6xnWCDFLyiXUhIW0YSO5l9DQWJxrg1h8pEHz79kI+3jK83MbRh6l3+Rz1+t/7xJM3fWmHSEhKtZSbUuys47nw05G1KC7Ir3VeJUCpnd93IDkWvBz8fazHSaxqjIEJk4Uc3AvIbubMbly0HLv8PGwFUjXZYYcbzrB7mJmUoGO0Mjc11nu+Phoj7a0GHs6Ez8fIh1+NLKAhxOBYFfc3VMDkJGle8s0PVgwWrxkQIjriWJxXFTXj7g1cx3C6vXB0w2q69s8mR76gVuhkpTkGzOgM9XxYiJakT78tV8lK0CPNmjJbf+1w0d36dIyiOFB8qXErHscrBFrN93IOMEqflUqeiVPEUeKQpy67xa+S0/floclobVxZD1+ifT2fWsokG9+0rTNwGNHrIgRCb1YaTH6oVjl4F+oywY9b4hbZ4ZM1jRAVGhxjjg9L2Z9OzcO1j65jqUAi21KxFZ9895V3NYPXV1NjObe4IQ+SQwuWXH3dDpvHxBj3NlR7L4AoeFGpIcUresEmDWVyfrnRwmsRnFywhejn4kTu9FgsncafFoExT+8nrL23u7Hqx+S8EVe+OFDhudqxVLRlRnkqmxrQBUVwL06gssXABPdcOlczOLMkjDZ2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdVbkdYa2JhdWVkNFRncFRWNnlWVWhIRW1sZFdsU0RRdk5NY1FXSjBDTzlT?=
 =?utf-8?B?dGFkcVlhMXBtL3lrWFF0bXYwcjFVWXhVTWdSdjJwSXFMdDczei9NeXlFTnRy?=
 =?utf-8?B?ZmFGaHN6Y2ZlT2xhTlFGSVZDSkY2MlNMV2NIWDZkandYdXhwVSsxaDROTmFi?=
 =?utf-8?B?R2RmblZEcHp5eW5JODdyazUzbXlGT0hmbEEvc3VwblUrbjZRUnBVL2xQQllN?=
 =?utf-8?B?c2x5eGNCcnFKa1BiVm9jeTNhK1VES3pxV1RXcjBxRE9tYm01aVRiVmRRRTly?=
 =?utf-8?B?MDM3RlpFSXRETUwydEJDUDMrWHVzU2R2dzlUY1Nubk5tWDRYV0NTRjlyYzZC?=
 =?utf-8?B?Y2dWeFNMRUVzSGhxeFp3VkpjekhKV280R3BNcEdUaDBXRmEwbjRNRnIvWFZu?=
 =?utf-8?B?ZmZHSnFQNURLMnJ5ckg1akJGZGF4K0RqYzJCc1EzYjF6OU1KM2QzOHVLNWZ5?=
 =?utf-8?B?WldvUzlGeWNGVkJZUitlSHhVVmxJMTY0RkV4ZVAwbktUejZONTk2MS9BK3FJ?=
 =?utf-8?B?SWNCYzUrb09meEhkTGdBdU4zZnRpbGZOSUdmS2owY0RJZ01yL2VWcXo0cTlI?=
 =?utf-8?B?YndRenAvb1F5akVlVXJlZWUyblRvVWVWVDZyRjFQbWNWc2xPRHFtSGR6cHZT?=
 =?utf-8?B?RkNXTjFrNTY4SGZrUy9hTEVxMlkrNks3WEVUbVVUMnBvU2RXN1ErWW1PbE9K?=
 =?utf-8?B?Sms5TDIzRjZEd1BkWUNiSGJwZzlNVFJNU1VlOGtUUDRsSC9CVTRPMUZIZWFr?=
 =?utf-8?B?Tk80cUxtVzI0UTNydFB6MTdSQklxM1ZnN1FBZ2ZGcE92RXhTeFo0ekxRRjgr?=
 =?utf-8?B?ak5YYnRIVnpxUnArQVEwczM0U0ZkS09TTUR2OG90KzczZWd3bFRhUGREdDZZ?=
 =?utf-8?B?NmR5eEN5UU9RT3FxTi9CVEFIZ3F3c3lXWUZCS0o5dlVBYXArbjJhNUdOSDFB?=
 =?utf-8?B?ZmpBRzljbi9GNFZKNDBtdlpBc1VkNmVtaVZ1QlpEN256bjQ2ZUY2Zy9wL2pI?=
 =?utf-8?B?SVJ2WEhZamgxUVNId290TGkyelAxTUMvRDhqOWUyQXdsdkRndXgrTjNxWWx4?=
 =?utf-8?B?WjBiYlkyKzRyZWpKTXloakhGZ0NsclhTdFRsUTNPY2UrYVcxUkFRN09nYTJm?=
 =?utf-8?B?eU9TeUc1ZWhKeFRFa0MxK1g4RjhlWk54VUtaM29wM1UxTjhZemtwczB5eWpG?=
 =?utf-8?B?bFFJZlQ4ZE1XR1lxbkRJaEFJQUdwVmJ6OXNsU3RsQ3NlOWxZKzh5OFdZVTVN?=
 =?utf-8?B?S09Wck9pRGo1VG1IWkxXcnhTblJBVzhGbXpGYWExZjFFdm9ydDlBMlNjK1Vz?=
 =?utf-8?B?S09zNUtYN0JIQm9mcno0ME95MTk3WTJoYTJHOFJnaHZPN00yWkFQbzRlUFps?=
 =?utf-8?B?OFVrK1dYbzZiT2JGQm0xK0NkMmcvc3RYV2JsQkFQRkdlZEEwSXZncVBMcHVl?=
 =?utf-8?B?M29GeTR6OTgwaC9VVi9Fb05BdkVzY2U4cHdEekg5NHNVM2ZwSGlQQjUyenBX?=
 =?utf-8?B?eXh2WFI2eVJPQVo3dXY4cDMyU3Z2Y2JLd1FnbUtDUFIyWmtpVTgwY0J6T3I4?=
 =?utf-8?B?ZlZkZEpFamo0ZHRYZGp6dTI4LzVFMjhseDVVM1phR3NDNys0MlV3UGN6TFBl?=
 =?utf-8?B?WERMNi9udjZ1YkdxVFpnczJuVkx6TjBxVXhOQjhRMFFkZ3I1M1QrdHpTREdp?=
 =?utf-8?B?K2NQeWlGdmN6Y0F0VGFSdnUxMDMrNUw4UUFJYTBXVGRscCt4R3FmZ3kzQ00y?=
 =?utf-8?B?ZGN1TDM5c1BlM2hDZkNjcldPZ2RFL2JTd0xHNXFnMTRwckdadWJpYVFPWkxG?=
 =?utf-8?B?ejc1aU1hK01ZWWNJTjI2T3BQTDdiaHhpQTd3aDNPMFdwZyszZktJWTM2VUI2?=
 =?utf-8?B?NU4zci9YczJmMlZwZ2Q5RmpnSEcyUjRDejMweXJmdVVROEZvNGVBZE9TSUpk?=
 =?utf-8?B?d3J6MWI0TXpQa3ZiL1phdXROY090UStXUDRnNmlTUnpMbTM1OUhRN09BSHBO?=
 =?utf-8?B?SlBLZ3lLREF2S1FqcXhkTFE2U0FGY1dWdU83T1dFUkNETy9rS3JocUt5QTY0?=
 =?utf-8?B?a1ptUDRseGpXM3FZQTJRQld6YUR0WVdrWlRJS2RvWlEwVzFkTmErU1Zua3h1?=
 =?utf-8?B?OUlPTWJqVVRjS0gwdGVzRXJ1Q0RtSWJubTQ1ajc4WW55RHJmNGd5Zmh6Rldx?=
 =?utf-8?B?ZU5GSysvQ09lQzhWQlNXRS9VdFNXTm5JRFFIRXJNWlZSREJqZjNpYlc5L1Jx?=
 =?utf-8?B?dExIV3ZoRGFsZDBJK2dzZFhCaUhPR1l6NkU0Q1NoejdrYXA2TTVnOWdRT0xk?=
 =?utf-8?B?OGdCTFV2ZmRXOTVCL1BkbHBjci95WHM5RkhHSkN4RmFpSHRUT2pGQT09?=
X-Exchange-RoutingPolicyChecked: M/Md7SKnF8JCjvFtyxS7IYj5AmImxygpkVHboiMDxQ6Td4grabF8paOS5c6v4fRjKJ/1IKJkFudDdNyPWvKcO7KnA6Xw0JQSq4biZqd3QIwzwR9x9IXp6DMJ28oWlGpYgWX8OKhAgSsmFoFDGGD9UJEJIY2JbQmKRHhgdbOtHA+fV8+ga8diX8ycnq4Q78Akm5E+TY9si+CRWvq86iNTnOFaKPmXmaeAgTH/aFgNVRC3pk51es+jrr8XD3mbHhMPH2PIml4urFDx+aQz+og89A1IlO1DeRBv/kVVnR9Ip3WtQJFuGfrq4bLkqXXX52xsDmPq73cEn2ph9JSvGdUuJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d4488-ad12-4242-56b0-08de8901f79b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:31:07.6727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXiGlIGWPNXrN02XOfNalDPO33dt7XI8CAwQbGMHYQXgc0xB2xlyWbSJRRC3D7uiaZ42TIdK9nueyzsZxQQldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8322
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

On Tue, Mar 17, 2026 at 08:41:24PM +0100, Miguel Ojeda wrote:
> On Tue, Mar 17, 2026 at 9:27 AM Matthew Brost <matthew.brost@intel.com> wrote:
> >
> > I hate cut off in thteads.
> >
> > I get it — you’re a Rust zealot.
> 
> Cut off? Zealot?
> 

I appologize here I shouldn't type when I get annoyed. This the 2nd
comment that pointing out difference between C and Rust which really
wasn't direction I have hoping this thread would take.

> Look, I got the email in my inbox, so I skimmed it to understand why I
> got it and why the Rust list was Cc'd. I happened to notice your
> (quite surprising) claims about Rust, so I decided to reply to a
> couple of those, since I proposed Rust for the kernel.
> 

Again my mistake.

> How is that a cut off and how does that make a maintainer a zealot?
> 
> Anyway, my understanding is that we agreed that the cleanup attribute
> in C doesn't enforce much of anything. We also agreed that it is
> important to think about ownership and lifetimes and to enforce the
> rules and to be disciplined. All good so far.
> 
> Now, what I said is simply that Rust fundamentally improves the
> situation -- C "RAII" not doing so is not comparable. For instance,
> that statically enforcing things is a meaningful improvement over
> runtime approaches (which generally require to trigger an issue, and
> which in some cases are not suitable for production settings).
> 

I agree the static checking in Rust is a very nice feature.

> Really, I just said Rust would help with things you already stated you
> care about. And nobody claims "Rust solves everything" as you stated.
> So I don't see zealots here, and insulting others doesn't help your
> argument.

I know, appologize.

Matt

> 
> Cheers,
> Miguel
