Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714F606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dfX/2iyT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CD310E8BF;
	Tue,  3 Nov 2026 22:39:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74B310E828
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793745554; x=1825281554;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IUfCtJ0/6P1B5WIv9QHIbG2j84OEghAZYOQHYPr3BAk=;
 b=dfX/2iyTuaK0Jpx4o9C+EYcQrSESnOBmHSNmxr8QQAY9HH60tUPzL/tC
 ifCL6H7AkyMyOUHpSLINABaE4uWtIJjj69uYvRARh2gUxHzyjE6K1SGYI
 +sVaIhhseBstkkU8cIEaCell3PI4DxStLZFmEF1Oo2md2qqQ+/n4q5Ksu
 g0HUFjKnTJY6lE2QY2d7KpDdUUOwRfvNmnlZrcpM0oLpcLVxJpR6g+Mrg
 3CSm8m0DlSEzA+lpGe6uiEWJjlmKJ3rIe5n2eCCgtleS4VWEHkFNE2DrN
 MTNksxsm6ZVK/fKzbMoXKwsmmdU15qDv/oEYTCjHqVLjDZQO6fxnCq4lX Q==;
X-CSE-ConnectionGUID: b21OMuTDQnmOn9eA82kd5w==
X-CSE-MsgGUID: sOndPDK6SWSx2oDCPBjObQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2590450"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2590450"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:39:12 -0800
X-CSE-ConnectionGUID: 8RXQv26eQniETE0pLp8EvA==
X-CSE-MsgGUID: XCNEzi/tRYyWmIJNYorKFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="8407791"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:39:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 14:39:11 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 14:39:11 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 14:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOZTkfn0CXq3WNYr5rwaQH0gnKM7D/DJVVzTjQdFeo3wCM97uV1C+Ymr1M7cSbaQvIPI90OmVICtHuldl7bfXcf0yVS1PljCBwdrdDLO+unUSNG7WQYDsl56/2/DLykwAqrlyxEK0fAh6cV7AcMrhlalF+MfDqLyXPBtSnq9Qbd+VrIL9oLTDMeLOvCFf4QCHFSYJVGn0IDKCyTDRWRVN0QOwML4yrdJ4CVNFeLhePVi7wYk5GnDbpTAcSq7xqRCk97Vx1e6i/3qbGH9NZIwLVWF9iDzqLsiym9j+8sL6cFrKmLOw1sZVuDbOG2Wu6Ih8/yaBiq45/mCxiUOCopHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mau/Ckf7IPMs/XKiENtgaDJJhQ9L5F38yiyg1ZSJns=;
 b=TQXN7WywHCGXIHHTCP+9xxlPp3rfvjWxEJbs0aPnlUiZaMyoi/Kr6tkmBRMllrsyfN82VVR1JW1jmCI9isAL18DkDYnL/NqGGCDLKyJHWo02F3LjdlIzLRpVa3Gj1Oft4szJje7MfV9ltDpTbnEDAJm5NZVDb0683HEi1TsEVHGG7Lna5Jqz6M3p6RNv62sEiLplnJcS+QIIryPeY4DeCLrMfO4uShNLqgy17UTyYGazjINKbLHVT2Y6M8z/90f+x1qiUPv0aorEpnYrJG+4st1O2vKK1l9IDcxJLzUPqnRlyosAPkcV1kAS4D+rzExPMkP7x4+ZlpjPGIqC35sibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DSVPR11MB9743.namprd11.prod.outlook.com (2603:10b6:8:34d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 22:39:08 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 22:39:08 +0000
Date: Tue, 3 Nov 2026 17:39:02 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, Mark Brown
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <aupihiB5RvfgB1lH@intel.com>
References: <aujZcJBUyQ7iX_PM@intel.com> <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org>
 <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DSVPR11MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ee388d-d749-4ce4-f441-08df39fb45b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|18002099003|4143699003|261022105027099003|56012099006|11063799006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261021121427099003|261021135927099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: P7DDDStPBtnspwWiY9CYqINB4vgS2HO8V5+nSanFWSHHy5EOS/UlFzX0JM/Oh21XstnBSifBqrQlaVlzY5VvmQdhc+dgLEVdLbtNAZJkY/pXSf5WwFBX1DLEvGfDJOjvVe4L7Ziv75a2D85PC/irKxD7BJgfSAbo0L8xzSyXWPBvB26UYWmbwquW8lM+Ld3WWI8jIYKiu61r98BDwJMrxdbyPf/dNNCF/9LmlI0qvh+1Nh05rVv0hp3Y5p+f+2PAxyGUMELbw3CyuTTR4LPEjtGUG1l57dv56thcuilDB+MhYe4K9faK7igRcymvCFJl3hqsUkrubNBe6fMZ+DwrLkuqpZ/HdMGQUCrQqYr9DmbfEs0T+SBPQ2iIK3kLpqlYh4FUv/K8OMM9xPuHc1abZ3N5eespUIi1jgxC71L+pcOV3BR5k+AGaPU6/ei1fNVRUCrvYjS4w3QoHcDNC02SvqHmHFvwo0uiqvtrNMGc9+2h047sK0hY2CAm5j3JAGMDUUT7h/u3CBD2saUT1yzNC4SOoGxChvSD3dSURjRfT4f7Qeuif5jEglNbl77kI7mhtnf+MDr/me3o7Z8xbTIgbHTk1mHJ1UYbs11biDokSiwdRzLIfTc0wvTn2IzuxOUl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261021121427099003)(261021135927099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ms8W4gKb4CCtIilG9+hhlclU2AhF0CsiPSX49Jfj4QSi8OztMEXt38w/+3Lc?=
 =?us-ascii?Q?+q1pM85iY6soVXTvxe2DNObNyFfWecWlARmQQ3AA82Gt+xRH/dB1j6o2b/g0?=
 =?us-ascii?Q?2x+TrUKBPH1wkUiHHn2kmay/MpyrkEjOKkGeXLIb+5ohaFJRFI8Vy79TMqTK?=
 =?us-ascii?Q?HiUkZ9SvBEYHZbWFcJwUc7GqvByZ3f5aX7kLiHg3yfkSanIBdHuWlUUZ9/tK?=
 =?us-ascii?Q?LaWftxiX+dgIrdil7ikv8X5XxGAU/NOfMdLkN8PKMFduHIzwrJ34r5tHWELO?=
 =?us-ascii?Q?t/prTOrE5t0LGimE7kdEH+kVo1Rz+f9sCfUU74GB0eB0/1L1nhbHHHbnXqIe?=
 =?us-ascii?Q?wIbddD1N+EIUGmu/Ckfv7Rb9tfvrjP8xewG9imod/+EmiN4AZE6JRvaItetC?=
 =?us-ascii?Q?KUF8z7ZSWtqme1SfyDDCCWmB+ws4v7KvUtueUMVmhs+/A1GkcBfdOiuv2HXs?=
 =?us-ascii?Q?bJ+1bD+QFZzOA7j0B4rZylU4+97XosToG9hoJK1ZiZA5TpxvG4Y/hvpurjGp?=
 =?us-ascii?Q?9+Ivqh8GfCCZxnycan0EJzUMhUXesltqZeP23xUhtg5fevhmLd6Fb2AfNmQm?=
 =?us-ascii?Q?bZT9s9VzZ8pFw6C3BdF4aCV0yFAt/Oa8Mk+CFnnfB8qBV6KRs5y50pt59/R5?=
 =?us-ascii?Q?f2VIkL3Y6WccSsrAD71am8/IhY/0ZdxJ4UF4j/kuE/a1W5NSj1k59chEX925?=
 =?us-ascii?Q?Z65imVMp1ndVJccBLUbWjoU1JXBA2BCCXo3GQMaEw4I1TUqZ9HmynJgnPSUr?=
 =?us-ascii?Q?Rq/Cjw4ej9PsE50NLG0dDiP0JbLhXo+8gwa1FcFybZwwaziS6gZAntSkjoi2?=
 =?us-ascii?Q?CddRdBvD7MfYGMbxIKzU2RbtChVfRPY3u4aYFG5GFEJXD5rFOyLnDr5Ekg+U?=
 =?us-ascii?Q?594Ty50y0LJn0w5+XEJeVexWcbFl78uyTp/xvKQMUy5MJBupuZWBEAl9ubV5?=
 =?us-ascii?Q?3BZjJxW2kZax85LE8WjHaPRlHhs/2l3BZ5wVdzFLqc1t2j3pPpyNgyA5FFrW?=
 =?us-ascii?Q?XDO4TByjQHBV4WK5QemfkV3pOsYiJYvx8vRZ/oVflBAgFjP/C0HsqawJ6CfW?=
 =?us-ascii?Q?IZHAxmF0CVvxuqpGia6cMOlmUesYuNy6DvGw1erqmgm4jLlc2jLDwwhXNcvl?=
 =?us-ascii?Q?oQcm58eBsREvO0A8ZekjtHBgZRV9xUf9DwDoSuY4DXJaILoQ+FSpiw5GEUKV?=
 =?us-ascii?Q?FL7NrB26OOVQLtaGJ2qOuyk3/3qDqCMxTIi9+5r5xwLJ4hJwg235IZGf2/ks?=
 =?us-ascii?Q?Bqkfx0RWQlGDH0dmKpkF4iyNn+O2+fa2C7dGISsrVpw6AeGKhA8x3cIqNh7L?=
 =?us-ascii?Q?Up0TlWhIWi5nGq+J+k9XZ5zIt4S8janTuG+Lvj7x7aBPPmOX898Xtk3osypa?=
 =?us-ascii?Q?bLmuC757BrGfwVKeln1weT9kv4cpan5hzyv9JHIFiQO7vHtA0/jjCb6gPUbY?=
 =?us-ascii?Q?UVEUIq1fib9ktEwD1kegDdChUtPO1YTrPLBYHU2ZBe11UtUMITeNJCHYEOO6?=
 =?us-ascii?Q?aKCfvGp5h8wl3Hl62EEq8F79tbbDqj/1CVPkufO9WZ940dD+8JoRCkVRQZHn?=
 =?us-ascii?Q?CrloSSUDdwdlTCNyKWOI0mOiPhllPZ/tMiw2MTfuWsxiwCJIuf+sdHQURwxK?=
 =?us-ascii?Q?RwNPGQEttu6k16/ajObHgSddUoIAl2CSen+EN95Z+uBLUcgtPpoh3AVcfHci?=
 =?us-ascii?Q?pD/kSBsbGCy3uaG5BtfkmMZ2EGTiYZR9zg7rkxjxQgKj3vB+dTnPcNA+K+UE?=
 =?us-ascii?Q?b5V4JQ6tgg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1gAjP7lEQpZ2kvkpaldJsgqPdWMBxBdi3hv21Iru9ZyedwivwWVAVSKxhH6Tb/I0gplobLp8ipSfKUn4K9Beq3c9nAW6JQUoCiPQo9mIuWdletrtO+vFUfG0D+kYbILl9QRRAg+f5mzd2ZJ4/KGdOYlOIQ8SOcJkdTbUNdsLuomXZwcxQaCmWGTpEvgZw1hYHTeKGJm04nZfaaOwgQlVY916jOchkyCdxLn9ujwycMK+eZhOorIlR8n2WnbMwJlteFNPbarLQW5cK1d8ym0zCNE3mAywJpEid2NGREllttSJ2uSR6LnDicj1qDeimdgPJSx3qwIKdw9nqtk/YJ70ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee388d-d749-4ce4-f441-08df39fb45b6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:39:08.1824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrGAzFmPWb6WWtXlCf15eszqXW7ofTMadHQzt4gyLZUw8fCVhk6NoElXF6/bvxiv4Z5m/lO6mLuqbgdQuNukBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9743
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 10:04:28PM +0100, Danilo Krummrich wrote:
> On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
> > On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
> >> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next merges
> >> $tree/for-linux-next, rather than $tree/$tree-next.
> >
> > For this to work we need:
> > 1. xe to create for-linux-next for-linux-next-fixes
> > 2. amd to create for-linux-next for-linux-next-fixes
> 
> Huh, I thought all the trees are doing this already. Well, that explains
> where the the problem comes from. :)
> 
> In any case, drm-misc, drm-rust and drm-intel already have for-linux-next and
> for-linux-next-fixes, and the implementation is generic. So, adding it to xe and
> amd is trivial.

Agreed.

> 
> > 3. All maintainers to agree to move their -next-fixes on the same day that
> > they are sending the last PR. Or have a new dim sub-command dim final-pr
> 
> That's what drm-misc, drm-rust and drm-intel promise, yes.

Well, 
https://drm.pages.freedesktop.org/maintainer-tools/maintainer/maintainer-drm-intel.html#drm-intel-next-fixes

We promise 'after' not at the same time, nor right-after.
We never specified how much after. I was always doing this on the next week,
or even couple weeks later.

So, I can tell that when I'm handling the drm-intel-next-fixes I was not
doing it right after. So, we certainly had leaks from drm-intel-next, at
least during my rounds for sure.

Right, we just found the other source of the issue and that points back to me
again, I know :)

Oh, we have another complication in the -intel part.
we have a separate drm-intel-gt-next but the -next-fixes and -fixes are just
one. And the maintainers taking care of the -next -gt-next and -next-fixes are
3 different people each round. :(

> 
> Something like dim request-pull --final seems like a reasonable helper to me.

I like the --final option. Except that this doesn't work for -intel and we would
need a different blackout mechanism there.

> 
> > 4. Instrument dim to have this secondary reconstructed tree instead of the
> > implemented chop.
> 
> I think for this part isn't different; tip/for-linux-next just merges one or the
> other.

But it is a new pass... The current proposal here is still a single pass and
it chops/derive the drm-for-linux-next in the middle of the pass.

For a separate one you need the second pass that is the merge of the drm-next
with all the individual for-linux-next* ones.

> 
> > 5. Prepare every committer to deal with this extra build time and extra
> > conflict resolution.
> 
> Which extra build time and conflict resolution? You have two tip trees in either
> case, no? One that contains $tree/$tree-next and one that doesn't.

In the second pass you can get duplicated or different conflicts.

> 
> > I honestly prefer the simple chop solution. But it would be okay by me
> > if you take the lead and implement the dim changes for this flow.
> 
> I don't mind doing this. :)
> 
> >> I.e. the ultimate source of what is linux-next material remains to be $tree.
> >> 
> >> In general, I think that this is more accurate and probably less error prone
> >
> > I would argue the other way around.
> >
> > The reason that we are seeing so much escapes from next-next into linux-next
> > might be exactly by the fact that the blackout right now depends on 2 separate
> > actions to help simultaneously (last PR + rebase of -next-fixes). What most
> > of us are not doing.
> 
> Interesting, why is that? It seems to work perfectly fine in drm-misc, drm-rust
> and drm-intel.
> 
> The only thing maintainers need to do is push $tree-next to $tree-next-fixes at
> the cutoff. The rest is automatically handled by dim already.

> 
> >> For instance, let's say a tree closes (i.e. tags the last -next tag of the
> >> cycle) a few days before -rc6, it could happen that subsequent commits to
> >> $tree-next still appear in linux-next because tip still picks them up until
> >> after -rc6. So, after -rc6 those commits (that were in linux-next for a few
> >> days) would disappear from linux-next again.
> >> 
> >> Not that big of a deal, but technically they didn't even belong in linux-next
> >> for only a few days.
> >
> > But well, this is a good catch and a bug on the current proposal indeed.
> > Should we move that to -rc5 to -rc1? We just need to ensure that everyone
> > have at least 1 PR after -rc5 and we are all aligned.
> >
> > The only caveat is that patches landing in drivers-next during -rc5/-rc6 will
> > take a few days more to propagate, but it shouldn't be the end of the world.
> > It is still a couple weeks before the merge-window.
> >
> >> 
> >> If we kept $tree/for-linux-next, tip would never pick those commits up, because
> >> a tree that closed a few days before -rc6 would already have switched
> >> $tree/for-linux-next to $tree/$tree-next-fixes.
> >
> > Well, if you don't move your -next-fixes at the same time of your last PR
> > you are leaking that as well. And this is happening.
> 
> Where is this happening?

Mark complains for a while of the number of escapes of next-next into linux-next.
Perhaps the current flow is only working well for -misc and -rust.

> 
> > At least now we know why it is happening (besides xe and amd sending
> > straight from -next instead of having the -for-linux-next branches).
> 
> I think if xe and amd would have those branches there'd not be a problem to
> begin with.
> 
> But independent of that, I think it is nice to give the "fully merge conflict
> resolved thing" to Mark. :)

yes, that's the goal. Reduce conflict's for him and stop the 'leaks'.

Thanks,
Rodrigo.
