Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CA606A336
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DuhT4iao;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lpqPxnut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A2D10E0D0;
	Mon, 16 Nov 2026 01:02:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A88910E0D0;
 Mon, 16 Nov 2026 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794790952; x=1826326952;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0nAL0lEwShlyeTwz3Z0ivVqmmCmZAhU7IX3hD688alU=;
 b=DuhT4iaosGcg3lK5sVGHChNBczhToExe+AQjWAaFwHL2rwa8jzegA5f8
 dNNHaCsGLPsUfLJJqE3j+vN4/afhXPZwOg8y0wdxofhEOGKKIf0ttd0vm
 ipL1tUpdY//0VmOKhPIW3AqbY7g1G4sal0EqQVgGoOs/o73wllVPjqfER
 PKUmFJ6NZ7dXX6SfPlO1JLM1XMekFpF14ZEtJ8KsrBqu6qqFQP6gNX5wN
 fAIlZahkoin6WxbwtdFcdpaIE1rdOdYO2R2AeMZmDWXUOcM5xu+X+mVEa
 B73rJEqbJzxCAPY1wIWaAbsRuDAJ+hHxVqhqBdOaL2j9s2fPwiY+di+gK w==;
X-CSE-ConnectionGUID: AQMxXI57SsSi7LimuaHqUw==
X-CSE-MsgGUID: CBhdCdtCTZiQVyLzYhiNiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3558879"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3558879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:02:29 -0800
X-CSE-ConnectionGUID: TRUMyIaGS++v2pguy/b/LA==
X-CSE-MsgGUID: 8ckfye+BQe+6PqXLbLkv+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9761487"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:02:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 17:02:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 17:02:27 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 17:02:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh8pVxsYebga+IuZS5EdkKzJhGlANUKYvkLGnoBTqFgqme/FhFF0Q1NQ6fBZYWgP+1ZLMx2V89mShYd7L+37K5kEPlygv3RRxJNpjO97V+i5nfXsWZmmBcQn38FGBDePoe0a8okdz9CCaJJAnfChQHjij6WsyS7l6FYYGT/LodoGyZT367HOs5iUIHl/1+pCwQFTQDjuyiLxi6MfDoVYOP1oVjTuaO8s0dpkiqowKbwtG/UcUgdnrLu0Va/UbeoLB8xTldwjpjuxpKAho28la9Yp/ABo2ZvaBjaJOQrmnmZkttguBZEyWHnwtm2VawL5n4OVkjyFPwkCJMFWrRv97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU0eJ/4RY3RQ+GLqzABtIGExPU7FKtF5yPjamMxBq60=;
 b=PjRomKTAfNmxUGCpN0HpSSZ5ueQOHtfgI7KelPMRYIaySn9HUBRskVqHoUPAXltgXPxwfPoaGL5kcsaCQK+vQ+0WpZKhfHB01252G2Bwtm++cUpMqc54igH7+1wXz6VJvkUZ/zHUZFiY+xjGZv33YQorBsj/9AXYdywtRetGiXxM5+3gpCKdEY5e+dWsOETkgMNxVet1pEmQadBiRqSh62qQzI53+X9UVbuiRVQMwQyRVd7O19iVYisKQtak76l9sn1KRyrtFO95QfNCjsFuznBzNbhIZOdT6k8mnydoK7a76r30DOaJ25qlk/Oh+OI71jOZmGHr3cPX9ZbLeHwAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU0eJ/4RY3RQ+GLqzABtIGExPU7FKtF5yPjamMxBq60=;
 b=lpqPxnutYdWO0Vd74fpWiVW7Ji0P8bo+mEDIxtFjrzbMefEix2LXTa+6BsQ6aaYxsI4nsAa+pC8wjOcCWnCE+Za9nkyi7fa648tWIOEyqMaPqbmHuA/qOpFfkLjfEVPoYjntwgO8GLUFPvNC+n7GH/7y/j5ANPuxhafi59JbI3o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 01:01:27 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 01:01:27 +0000
Date: Sun, 15 Nov 2026 17:01:24 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 00/33] drm/ttm, drm/xe: Minimize dma-resv hold times
 and defragment sub-optimally backed BOs
Message-ID: <avpV5E1PgH3YKzwk@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DS0PR11MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ac48b1-b295-4c8d-56ca-08df437d242f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 44HCP+s9JkSUaGAAgRBMjHubEalXej4o/fjNoPPHGtfV+j8sYpeoJ9T5p21KEBqdbj+fy6NB+jF2s0irFEXS0LPpRjpnj6fPVmNvpU4rrz/hJIWzjjEG9Xay0+yYPBNkBVrBW+0qit1xVQr3XEfhD4JRtmWBjFU2T5oeR8Nil+rdPkkFdUbR1UI3RYLbyWJajN0q9Yg165ircIlzXbaaxGjBTrXLputgn1CLgPGp1McvJRTUcXyeu7PTh9VVCXbwR912xo9EyefXVw6jB8IsryUb8UI7mTV2wF+ls8p3OiV7FpN7+x/GQR/jaH8t7/9JjhGUwJaQUHvhlUiFbGvxduxDeyvycFhqkE8W2en8Yr+jAp9jSMG9YfoIziV/uU4opzvsJ4Q+bF9LV3sSeJhp9upsdSNmDq6WA4/23ZFqy6LOcvp3i4r8xEhLXPzvOofrCBXQ2gN4+a9BxD49cgn3lyIz15hG1am/E9EemX0IPPMJcYZ4mCcvKJgGZSMSjVU1pWIA6YV3yHzCr6xjW70bKkSgrSrrO99QrpjST9jZFFxN98+OSXF1zLV6vPwRJxlRSiSd7oV9jSR6x3jU/wdp+U6z9Nw5epyPONtx/rn5Z58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CEicS0vzPVZg/4AAM2mmMSaZBr6eUhSpOTdSZeAfnl4qJGNpeymyccAXGR?=
 =?iso-8859-1?Q?83kSkG6QCVFSqGvalFI23ui9eoliMEPxbJhmYtvUfZhZCOqw5fMrDOZ5ha?=
 =?iso-8859-1?Q?7xRO0Ov6j2hrnuUMPxfRVUq2p1lgm9GTKz46/kClRXTpC1XJuZWfgEJ/5/?=
 =?iso-8859-1?Q?81GE7htHoWu+97pVqEC22k5bsbJ3lLMMDvDO4diXQF9mm6648qhV0pzo0B?=
 =?iso-8859-1?Q?43YQDaEyPy6HEFWeSMdFzV8hZdI8Ru11OsSOUr5S0olOhN8vRAUWxwG2qg?=
 =?iso-8859-1?Q?AoPaZaz4J/RATM0D0Bq45Tzmrm4dIluAGbhC0nwb2yan0qlwdOrBApgIHt?=
 =?iso-8859-1?Q?ygEL6l6V3gBYBAP56ZUsuxXpr1qZ2woUeNrNSGDvPfmMgGRZNgGS68c64G?=
 =?iso-8859-1?Q?nFhK2gJhKskeUFaoFyrh0qKOzhSQ7otqoMZ3xDxZcsy4njafy+Cvo3JDoC?=
 =?iso-8859-1?Q?xlTz7P4ixvUWeB1tbvQJGSbJJjmG6hB6RJzl5F6iN31dDp16nV6THEuorc?=
 =?iso-8859-1?Q?4oMC9Grbj3doWupOZbqhaZQrIxp360zCmJWvXKiV55dM2fmkxK1BBL2ido?=
 =?iso-8859-1?Q?HEzE5vBO7BvyqREYnciq2yiWGDt2wKvPL1ceFREWu8Alf+59viHCtJwI08?=
 =?iso-8859-1?Q?YDPvctGGCXXZmF3xOFtD8NOuJINrIWqiyZFq+X9HwrJAk/J9RtH8fkPmvp?=
 =?iso-8859-1?Q?ozCTqJy1QRK+ckCGPt47axDlAdGSdxcY8zOqlKtxgkh+oRRNDYbkJHDkt5?=
 =?iso-8859-1?Q?8W7dFk8qXtamR9xk0KBeJBXsZ0fJ4dJzGyK/VnLSzsx/cRk26iYXKMpoVf?=
 =?iso-8859-1?Q?+2M++SIgh0Ht8Iz+Hm5c9RvWS2OzBQRCDVABaShH8smMMqh/vocaggHrAv?=
 =?iso-8859-1?Q?BHGoeM1oDNKuOohkIZHXJ4fIHXhszxki48s/j1C7W/GDjnQjz8D9wKo+AM?=
 =?iso-8859-1?Q?HITcofI1vfJ5wjMGOXz+6CwLSuD9mYAmd3jCjvunRYaaTd4CREWkYA/fhf?=
 =?iso-8859-1?Q?WwIsgFCf+s+9E6gOmZd6GfVudgBDqKzi6jtWiQAEbip8q6gCz4bK/0FSvo?=
 =?iso-8859-1?Q?CR/axW86ECqbAypjupdfzK2TjWD5k7VaclJhwLjXjhP57jCc1tx9PC14v8?=
 =?iso-8859-1?Q?0jmOXrzlL2RdNqOqtJFaKWy4X8+AxkGoa5CGVxNH62O5smY9gh0jsFQrqw?=
 =?iso-8859-1?Q?AubEhl1kaqClmlWteNew3j72IsRrCxbzK6mWuqqo/2WCJ7pDivkNW+F+Qx?=
 =?iso-8859-1?Q?x6/hc+olDi0wJoGbQhqguCTrvsa2rABdvBGQRw5YqWECegl20fqTu3Pd0N?=
 =?iso-8859-1?Q?Q4qzaGCv53Pb2I9KfJ8k9ks0+ogZeId9xz9wVpf9dt7RWbhMPZOEAZCFOJ?=
 =?iso-8859-1?Q?7k/DHDos0MogmMhxAMQbiGzHL2sZNnSYEh0KI1P33Cuv8mCubXR+Y38L5Z?=
 =?iso-8859-1?Q?ynousGGYAlf0Sou/MixorP/9UDUW3h5KT6Yhl5YIJ74whyjfzNncHg+9HK?=
 =?iso-8859-1?Q?riPGi5f3fc7DUn2a9488SGFLVq6T51ubm3HxvKl8JVjgwVBMQCxnASMHrk?=
 =?iso-8859-1?Q?Gz1CU/pmoTWBwR/Fzw65Oa7bZfp7TrXHJ09cESU05Gj0f8qE5SMJdnHgSz?=
 =?iso-8859-1?Q?ZmyvITUAAiUqtMRshall+QQHf1mOZUtt42nVvUkIQ6sN7oEmEWtp5GlCw/?=
 =?iso-8859-1?Q?KD59ytlAnCmbkrY1aCTwsM5saaI7nsLQD8d8W6M11Mvx/NnT23d9UhkKHd?=
 =?iso-8859-1?Q?OqPmdBI7ZlOX1amjbsOjwDl92iuAVWHfq8LP0B9EPTxDTZ09VBouTxRGa8?=
 =?iso-8859-1?Q?rYeq2bME2uBAHFkiEzkNAS8UHxXCOa2kCc63R10DjifPzKgO97ol?=
X-Exchange-RoutingPolicyChecked: i6LpSbg27spJQ1WmgTcnC/o6Nc3FHis+pmqXz8U3lyggvh7jIpWhfRaxmMTsIESxUSsHfwLZww8wOsfEoDJFkFMe96YyKFW70bnsnCiLwfiljvaWzP0f5PpjZFmXaCLsDigLJUMXw8a4lGMK7qHPwVKEZmOBYlEA0afgd+h3dGMhkSHojIjfyQyZhKLsPt6DJ15/cc5fcRzWGnDxGYrbMpLDaN1dLycgtMkbtbleD2/BGzvHjGe/iGWOodLpPN68phH4qIuDAlfpiEWDOs6q3IJo5QP0ZRZMUqJpDup80OmuTd6oQDbT9xFn5xvOVjX8xmjt1OaWTXKJ/kOhM412VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac48b1-b295-4c8d-56ca-08df437d242f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 01:01:26.9416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ve5swCPy0JRGhJJIK4uHjhrmY12Js1pCWXsD0nxQT0a5w1TiF91Z7oWft7NTd5xRdRfYpl6Hl9moa5rVp4+B5RlO1dqqHoFHPOJt9KjHamueG/cOIvQ5XLdnD6hsLlmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:55:46PM -0700, Matthew Brost wrote:
>The overarching goal of this series is to keep user-facing IOCTLs snappy
>by holding the BO dma-resv lock for the shortest possible time, and to
>push the expensive, best-effort work - page (re)allocation, DMA mapping
>and placement fixups - into the background or out of the locked critical
>section entirely.
>
>Two related mechanisms fall out of that goal:
>
> - Out-of-lock backing. Page allocation and DMA mapping are the dominant
>   cost of gem_create and of BO moves, and doing them under the dma-resv
>   lock serializes otherwise-independent clients. This series preallocates
>   the backing pages (and, where applicable, builds the DMA/IOVA mapping)
>   outside the lock, then transfers the result into the BO under a brief
>   lock hold. The user gets a fast IOCTL return; the heavy lifting happens
>   without contending the reservation.
>
> - Page defragmentation. A BO allocated under memory pressure keeps its
>   scattered, sub-optimally-ordered backing for its entire lifetime,
>   costing TLB efficiency forever. TTM grows the plumbing to track
>   order-failure and to re-back a populated BO in place at the beneficial
>   order, and Xe wires up a background delayed worker that promotes such
>   BOs on the GPU once memory is available again - again, off the hot
>   path and without stalling the submitting thread.
>
>Since v1 [1] the series has grown considerably. The bulk of the new
>material is a direct result of profiling: once the defragmenter was in
>place, the remaining dma-resv hold times and the per-BO
>allocation/mapping costs showed up clearly, which motivated the
>out-of-lock preallocation, the IOVA-based mapping path, and the amdgpu
>counterpart. Rather than land the defragmenter alone, v2 folds in these
>optimizations since they share the same infrastructure and the same
>"hold dma-resv briefly, fix up in the background" architecture.
>
>The series is organized in sections rather than described patch by patch:
>
> - Patches 1-10 (drm/ttm): core TTM preparation - order-failure tracking,
>   the defragmentation move, reclaim backoff, and out-of-lock page
>   preallocation plumbing.
> - Patches 11-14: other dependent drm/gpusvm and drm/xe patches this
>   series builds on (DMA-mapping accounting, per-order DMA stats, async
>   L2 flush, and a VM-teardown ordering fix).
> - Patches 15-23 (drm/xe): the page defragmenter itself - BO tracking,
>   the on-GPU defrag copy, xe_bo_move() handling, and the background
>   worker with its stats and configuration.
> - Patches 24-25 (drm/xe): out-of-lock system BO backing preallocation
>   in gem_create, moving page allocation out of the dma-resv lock.
> - Patches 26-32 (drm/xe): IOVA-based DMA mapping optimizations, building
>   and finalizing the mapping outside the lock.
> - Patch 33 (drm/amdgpu): the equivalent out-of-lock system BO
>   preallocation for amdgpu, exercising the shared TTM plumbing.
>

Assisted-by: LLM

All components in the patch series seems to be essential, but probably
below ordering of the features along with how much incremental benefit
they offer would have been easier to follow.

1. dma_iova usage
2. out-of-lock preallocation
3. Defragmentation support

Just a thought, not a suggestion to change.

LLM also suggests a light compaction (with __GFP_KSWAPD_RECLAIM) in
between the backoff and heavy reclaim (RETRY_MAYFAIL), mainly for the
gem_create preallocation. Not sure how much real value it adds though.

Niranjana

>Testing
>=======
>
> - 3D benchmarks on Ubuntu and on Android, with memory intentionally
>   fragmented by a separate program at launch (plus beneficial-order
>   error injection). BOs are initially backed at a sub-optimal order and
>   scores start lower; the background defrag worker then promotes the
>   backing to the beneficial order and scores climb back in line with the
>   unfragmented baseline.
> - IGT:
>   https://patchwork.freedesktop.org/patch/739052/?series=170046&rev=2
>
>Matt
>
>v3:
> - Fix valid raised raised by Sashiko on v2 [2]
>
>[1] https://patchwork.freedesktop.org/series/169053/
>[2] https://sashiko.dev/#/patchset/20260710215442.2444235-1-matthew.brost%40intel.com
>
>Cc: amd-gfx@lists.freedesktop.org
>Cc: Alex Deucher <alexander.deucher@amd.com>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
>Matthew Brost (31):
>  drm/ttm/pool: Allow backing off reclaim at the beneficial order
>  drm/ttm/pool: Add ttm_pool_page_order_nodma() helper
>  drm/ttm: Record sub-optimal page order allocations in ttm_tt
>  drm/ttm: Introduce ttm_pool_alloc_iter for __ttm_pool_alloc()
>  drm/ttm: Support defragmentation moves
>  drm/ttm: Add fault injection for beneficial-order allocation failures
>  drm/ttm: Harvest beneficial-order pages on defragmentation moves
>  drm/ttm: Bound page (re)allocation per defragmentation move
>  drm/ttm: Preallocate beneficial-order defrag pages outside the lock
>  drm/ttm: Add full out-of-lock preallocation for ttm_pool_alloc()
>  drm/xe: Flush L2 asynchronously in xe_bo_trigger_rebind()
>  drm/xe: Destroy page tables after unlinking all VMAs on VM close
>  drm/xe: Track BOs backed at a sub-optimal page order
>  drm/xe: Back off beneficial-order reclaim under defrag pressure
>  drm/xe: Add xe_migrate_copy_defrag() for on-GPU defrag copies
>  drm/xe: Handle defrag moves in xe_bo_move()
>  drm/xe: Skip self-copies for borrowed pages on defrag moves
>  drm/xe: Add a page defragmentation worker
>  drm/xe: Add defrag GT stats
>  drm/xe: Add Kconfig.profile options for BO defrag configuration
>  drm/xe: Defrag using out-of-lock page preallocation
>  drm/xe: Add defrag profiling tracepoints
>  drm/xe: Preallocate system BO backing outside the dma-resv lock
>  drm/xe: Add tracepoint for xe_gem_create_ioctl
>  drm/xe: Add IOVA-based xe_res_cursor variant
>  drm/xe: Use IOVA-based DMA mapping for eligible tt BOs
>  drm/xe: Add per-device dependency scheduler for IOVA defrag finalize
>  drm/xe: Add packed copy-step IOVA mapping for defrag
>  drm/xe: Blit src-natural to dst-packed for defrag-IOVA copies
>  drm/xe: Finalize defrag-IOVA moves with post-copy job
>  drm/amdgpu: Preallocate system BO pages outside the reservation lock
>
>Thomas Hellström (2):
>  drm/gpusvm: Add a DMA-mapping accounting callback
>  drm/xe: Add debugfs stats for DMA-mapped pages per order
>
> .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    4 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   73 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |    5 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    3 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    4 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   39 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    3 +
> drivers/gpu/drm/drm_gpusvm.c                  |   17 +-
> drivers/gpu/drm/ttm/ttm_bo.c                  |  118 +-
> drivers/gpu/drm/ttm/ttm_bo_util.c             |   21 +-
> drivers/gpu/drm/ttm/ttm_pool.c                |  947 ++++++++-
> drivers/gpu/drm/ttm/ttm_tt.c                  |   67 +
> drivers/gpu/drm/xe/Kconfig.profile            |   40 +
> drivers/gpu/drm/xe/tests/xe_bo.c              |    8 +-
> drivers/gpu/drm/xe/tests/xe_dma_buf.c         |    2 +-
> drivers/gpu/drm/xe/tests/xe_migrate.c         |   12 +-
> drivers/gpu/drm/xe/xe_bo.c                    | 1699 ++++++++++++++++-
> drivers/gpu/drm/xe/xe_bo.h                    |   15 +-
> drivers/gpu/drm/xe/xe_bo_types.h              |    6 +
> drivers/gpu/drm/xe/xe_debugfs.c               |   26 +
> drivers/gpu/drm/xe/xe_device.c                |   41 +
> drivers/gpu/drm/xe/xe_device_types.h          |   57 +
> drivers/gpu/drm/xe/xe_dma_buf.c               |    2 +-
> drivers/gpu/drm/xe/xe_ggtt.c                  |    2 +-
> drivers/gpu/drm/xe/xe_gt_stats.c              |    5 +
> drivers/gpu/drm/xe/xe_gt_stats_types.h        |   17 +
> drivers/gpu/drm/xe/xe_migrate.c               |  531 +++++-
> drivers/gpu/drm/xe/xe_migrate.h               |   17 +
> drivers/gpu/drm/xe/xe_pt.c                    |    2 +-
> drivers/gpu/drm/xe/xe_res_cursor.h            |   56 +-
> drivers/gpu/drm/xe/xe_svm.c                   |   44 +-
> drivers/gpu/drm/xe/xe_svm.h                   |    4 +-
> drivers/gpu/drm/xe/xe_trace_bo.h              |   90 +
> drivers/gpu/drm/xe/xe_userptr.c               |   63 +
> drivers/gpu/drm/xe/xe_userptr.h               |    1 +
> drivers/gpu/drm/xe/xe_vm.c                    |  149 +-
> drivers/gpu/drm/xe/xe_vm.h                    |    5 +
> include/drm/drm_gpusvm.h                      |   19 +
> include/drm/ttm/ttm_bo.h                      |   64 +
> include/drm/ttm/ttm_pool.h                    |   46 +
> include/drm/ttm/ttm_tt.h                      |   43 +-
> 42 files changed, 4179 insertions(+), 190 deletions(-)
>
>-- 
>2.34.1
>
