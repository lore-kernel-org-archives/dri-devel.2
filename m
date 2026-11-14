Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFCC606A333
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WMLmRIZO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DV4SKmoi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC9110E337;
	Sat, 14 Nov 2026 01:48:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4F310E337;
 Sat, 14 Nov 2026 01:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794620893; x=1826156893;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=i/55yvYJE+CEutyKpiz0n3cN1xAeLopAQyfsOiQ+jYs=;
 b=WMLmRIZODJxjAhWq64JHsiLXcCsXw4D6GzL8HQTCjfeq3ySweJcDjEIO
 7SfLQ2LoOfEO7/5nEpabGRL61Am1RijLPwNff+HMp/Tm/pId31YXZDURu
 GFBn1IrkMrVYWwivyFyF24S8yrUIb6gQ2yhU3R66jQ2e7kwaHdChsq+yr
 WvsRu61wJPfA1eOh5kg+06RFgzIPu7uG/y67f9K4HYT8exTcwDfr2zbt7
 adcilNCDKgCiQKnN0g2pzYb4gtMAiUUvOpDnol2uC7Z3bMLoQ2xrDk0ji
 x/bsk++1GEwXd7RBBKsaOiz+I/hRkDTz6AnP0znuqsw+Vytleg+ZifjkK Q==;
X-CSE-ConnectionGUID: e0NOnMcPR2G8QodPW3+N2g==
X-CSE-MsgGUID: 6QDnSX5CSwaJHMZX4dTPfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3326136"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3326136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:48:13 -0800
X-CSE-ConnectionGUID: JWeo1+IjRZebYZz+Y0AhYg==
X-CSE-MsgGUID: 5rPViCOIS32shGphggEB0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9218077"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:48:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 17:48:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 17:48:11 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 17:48:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNes+PYNE+XG24dzc5JpEXlGbMvH9/nIlbyu8yt+fsaWbxNwLn++02R24DcVx7ir5SC5Ccrlu83lKek1R1CW2aaIYt+AP5CiBqhJTZn6zK34/so0MyoEnFV+j/mF2T0a/yHRveTCHf9N/NBS35Vp8zhrlcOSRBWBXTm5wyM9mJtsSxdIdMOOyfNfOXR9D4/ov21QigVikZ8y6bRAHGVQKsBSkzULsFJsnycEJMnkzWTeev1o4KjHm4aXcesR4szG6Al2Tt0hJDk2W+X0BApGry4cF7hPc1MUWCFSz9IVgd6GOIau5evNl9rCD0O1Qs954RBIPlKoc72RpzF1mSZYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwJpNVSWHrVbpHhqkpDV0S9Gi0E4dwB0ogYz5+T6Ie0=;
 b=WfYCGMy+1sQ36q3el/XrgOHzCFzViZHPkVWwztQ83vt3Ya9vLBmJGH1ngN5+r4j3QbTdDq4NS1KA35gRyUlUJyfkboxiYM/ZbxhCgrQvzlbcNl1whIMxUEbxVo9/WAgbSGR4aS39xYsI1Y3VwFvG5eKD5SqKXU1E6cMsOQMzFFkq3JooB/9XA0zqy/5wgF1TgjcQ4W5kqI7t7cjqXi1zYJQFC90MwTn1ekh3BXLnbxHBigPviZsJ//YXGeptWsoe6/sRGzYvTEPlZmFgxYq7flwepa6AgGVmRgPl7yQ/D1njzkGt4fJFmHHMaHxrD/Qq7skcLYV2ZKIoCxCwWcwVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwJpNVSWHrVbpHhqkpDV0S9Gi0E4dwB0ogYz5+T6Ie0=;
 b=DV4SKmoiC9wL3Tk1FBY3+NAKJM0audxgw6XQWwCqx+HHLpOZQ6S1yhiLkNQleATpC+ButPtLeMYm/4pI2fsmlhMUp92Cn57NSTbJWGoV5c1grDZnJTZoIxtSi16UL5Sr+Shrl3b/3dXnUmn5EGM8RSXQqO6eN1PzcMff1kzBUa8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 01:48:03 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 01:48:02 +0000
Date: Fri, 13 Nov 2026 17:47:59 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 29/33] drm/xe: Add per-device dependency scheduler for
 IOVA defrag finalize
Message-ID: <ave9z-W4iDPYeYyY@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-30-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-30-matthew.brost@intel.com>
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 803c755d-e6e2-4b0f-ec22-08df41f151ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261026140227099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: XFrF/rRcF7jSYUonz9uL1nOr2Xapfv4nw9LfVz679DaD2Fwu+62vsa7DnNkZjTevsSO7c+vpTl602kjTlkWfBhun1LvGwq8poiyEpA9sT2QtYUmr2VwFYX7Fyqm9Mrn2YRMZ3fX/LCr0eu8X5rJGvirPUjFvtlmWQuQwAWtNo4S+kmSBcMAxjQWkP2AdfZ12ExR5ApqeG2acbkTAEXE93kbEkRq6hbAGEXFe9Hl3gLqlbnoqAftD3UjTUanRdXalI6XWD0ztMfTzZnS94OT0dmfwHjXPipeSb7b776WvgHDJrkUsLNa1sAlBqtgW/pBj+r6/1KjuunHwdgsoiaDro5aFAaAVUSpHP3fXbh3WC9/Dy6M6cYVXLZhbsczTlrCfKs7dOyW2qadPi040SJrMS4KQab53ARpXajDfXF6vW248JDJwkvoiJL5diduV/JQoaJUvE4iQBKJFDtYRYb13XJN5WP4qaf6qgsFKp2/sebo7QXQcgX3jMqRg7fCRAyBGx3GmTts2Jn8ayhe3DD2cUmzhdKW15G+kiTvBjlORqm5BbtnsGCLUmauysrbZw7Y3kIwyx7USdItcfyhi/jD8WgOj19s6y0YF+i9g6hHZL75Z7OSbwHHZM0f8kfvdCxIFxF5jRQMU7NvMdQdP674l5I2433gh4MAgsiCAaS09vzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?23b/wmzO6oTlwpCjC5/vShpGivSy0uXCW0szKju/imoR5g0B+S8tpdE6hd?=
 =?iso-8859-1?Q?Zu5dD2t+vjdJkhewrqbepc2Jgu/QuFd6OKwgQVGy0K0JhMe7yTh9oTvhtV?=
 =?iso-8859-1?Q?E1QkOxkdO4Ruq8gfvbTQ9pvJY1zsXmfN7srpgsP/mWf/3kKA/KPGiRtZh2?=
 =?iso-8859-1?Q?i18rd1yyggLCLn/+JYhSZUS40Nlv4acC57to/oF1n4OpwoJtzl3UgugTR7?=
 =?iso-8859-1?Q?3MfzProfyAVfF+Hba+N6fvcBW761cjygRrkyqEwztNbJ3+oXi6G3MA7+XP?=
 =?iso-8859-1?Q?MrUAwDiMS7UhKZd0U3Q9L2nCgfggsnV+Jsypdh7P/oHxLjwQmcLbweLEyC?=
 =?iso-8859-1?Q?L7S0s2V8r9VC6zGnjCsbey4M87cYfOEXJ968oChdOMIuFgdgZF5QRuXHVL?=
 =?iso-8859-1?Q?MAGsw9Ve8/fzEwG4HNNJQdVtUCC/DLR1H76SWRSEXj6o6PACMYSFetxlGK?=
 =?iso-8859-1?Q?Xmb9iGrYszeyOAZD3gju7Qp7A/GOO54CpVp8g/RuxrHurMqiPzzbL80/lT?=
 =?iso-8859-1?Q?aTcRVGFPHZzr2vxJzp5TX9eRxPir8HpTx02Fjo+VbD9vVDTGj9GF9zoi3K?=
 =?iso-8859-1?Q?vl78pFhxxzINFg0rAWnMwg72xkJTe9QiqBPJLQkfqcVxrGfsebe/XUeoeS?=
 =?iso-8859-1?Q?JEDbpkPIC4kcY6qkpMLPhUkLOyNcsFNkCXejdIgmri5N3L42HZGf8BFhbl?=
 =?iso-8859-1?Q?IG7yyxm29FS2rTv3FrEpUsEbS8HeGHE1FhwIa6C8lxIjf2w2QByOw58uXt?=
 =?iso-8859-1?Q?cQVs/x8kRZD7WcXzrB5a/AI0pOxSYOVg++l9k6HszyAIClzjwRlnWwcQpd?=
 =?iso-8859-1?Q?eVtlQ8pAjpxd9LwQXl7ApOUBSkdDNzG1Kebk124/HRSAvRGQGnfEQGOqJB?=
 =?iso-8859-1?Q?BGSHqvF+l/7nSHlokzlWqmL2MLazGih+qPpktepUsjvChRvvbobwqKciip?=
 =?iso-8859-1?Q?q0o21JlesnqaWE7GTu5db8QdKjtuIIWsl9CwYvyQRv/EwlX4HupH3YOOOL?=
 =?iso-8859-1?Q?UHb7qNWvGE2kjGTO6kOQY7/LPgjLCAC+VNg/JCLBUl+jpkU+2+3HKfFD2m?=
 =?iso-8859-1?Q?qW7ixmKeOFiIbfQTg5sR0FvyO7bFLzRhV802yw5fAbwt2NcKr6sprBvg9b?=
 =?iso-8859-1?Q?/hwNplHD9XMdfyjU7IcLDn2XKK9mazawU2fuih7Q40o8dpKuaFm7GqLcV6?=
 =?iso-8859-1?Q?dqtbkIvFtDmeKMN2O+mFwLDST3CREXFjnhGKV7l4+BX5Yvz6aX96t+UL1x?=
 =?iso-8859-1?Q?COvKHY8ItAyOzQCgkX/NO/GgwqHRUB6FXWPyeUFf7nwLYr3iblBwwBRsb1?=
 =?iso-8859-1?Q?QlS5WgbGHGtAu/nkiL7lYh6aUj8GZrAjMEP7gjv2nqvXu/3LHF4YBUTBJb?=
 =?iso-8859-1?Q?+NEsT6a+SH1ij78wwQy4iLIZ9vmIPAV54iRSVbbFO4uA+jwK4hVjzU0acP?=
 =?iso-8859-1?Q?agMUDETWn2SnBDLFG/22mA0WpIQhhttylIBC9Lrm5dcMQZXSNn1IivyM6I?=
 =?iso-8859-1?Q?0qW46h/dmCs5vMGa9sDQ9VXCtYLmU3YOvSXRl1ucjl/uscQCOUh8R9kDQZ?=
 =?iso-8859-1?Q?nEkzl83MJn4ZGRqeT+uWiUmiPXbD6N5LvyiMRcKWLnVVQxpILuVgh9Flb9?=
 =?iso-8859-1?Q?Nlqdeu1AxryOZejkQb4JQh3EwVHeHytoM5By5ZZM4Nh42Xm/LnRBy4Sapz?=
 =?iso-8859-1?Q?WnV2YS1PfQJxpGXBGJkfOx1aRaxxOauV3WsxB2zNKiTB+264bzG1XtUFFo?=
 =?iso-8859-1?Q?m41X6KTjRPGgjdQilSxD7TAotfD7MBGL1L8LyyF61S4AnAecMbV6KxL0/M?=
 =?iso-8859-1?Q?yWufFTSkgc6+5+wvecswqAP2GmIl2jToMZHn6pxCU1clxHjMZBqa?=
X-Exchange-RoutingPolicyChecked: iRAcmMmaO1iXwFyA6WXzTEmviQRSP7bNXbOn/b/A3uGSCdWesxFUC8yx2jzf9/ZfRmisEisIgPCjxNm0Dc2Tq6BZEO3lOglnDpZ+Bo5rTsqczovMaOZcAqTBsau2KGm7sUfKbrPZKemny6VhYx1SfUH0efTBuwrrvMWQe01ieZxUciTTkU4cK1H5BXdM0w9lhvj3AACZfIDLng6K6AbOaL7b01kciBe36ep5/IguINTTep0A9pDG9tC9ogiAhik4nyKDs/tqc1mIv2Ro/duuAvDTzBzLGVQ+aCACIpsEbiChkGkyVzCSx+xQ2BWmun3B2eHE/Ij4ytARP3Hofh6AQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 803c755d-e6e2-4b0f-ec22-08df41f151ac
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 01:48:02.4805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PBphEg4vfNLWTV7uLAk7FL64C/X7rRxiAgWTPT+yvrejT8cTgE4hjED5lrg8KSj3aMOaUkV9JgZqwr2YuP3S406puPnFKggUW4G1PIvZX4SIt3M5kC0/1hJk0thcQEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:56:15PM -0700, Matthew Brost wrote:
>A future patch performs the destination DMA mapping of a defrag move in
>two stages when the BO is IOVA mapped: a temporary contiguous mapping of
>just tht changed pages used for the GPU copy, followed by a post-copy
>finalize stet that tears that mapping down and links the new backing
>into the (transferred) IOVA reservation. The finalize step must run only
>after the GPU copy it depends on has completed, so it is dispatched as
>an xe_dep_job,

Assisted-by: LLM

NIT...minor types 'tht', 'stet' and trailing comma.

>
>Add a per-device xe_dep_scheduler dedicated to these finalize jobs,
>created in xe_bo_defrag_init() (after the migrate contexts are up) and
>torn down in xe_bo_defrag_fini(). No users yet; the job itself is added
>in a later patch.
>
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
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c           | 15 +++++++++++++++
> drivers/gpu/drm/xe/xe_device_types.h | 10 ++++++++++
> 2 files changed, 25 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index d54e69aefeba..c5022c16411f 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -25,6 +25,7 @@
> #include <trace/events/gpu_mem.h>
>
> #include "xe_device.h"
>+#include "xe_dep_scheduler.h"
> #include "xe_dma_buf.h"
> #include "xe_drm_client.h"
> #include "xe_ggtt.h"
>@@ -1306,6 +1307,10 @@ static void xe_bo_defrag_fini(void *arg)
> 	struct xe_device *xe = arg;
>
> 	disable_delayed_work_sync(&xe->mem.defrag.worker);
>+	if (xe->mem.defrag.iova_sched) {
>+		xe_dep_scheduler_fini(xe->mem.defrag.iova_sched);

LLM suggests adding drm_sched_entity_flush() after calling
disable_delayed_work_sync() but before calling xe_dep_scheduler_fini().

>+		xe->mem.defrag.iova_sched = NULL;
>+	}
> }
>
> /**
>@@ -1342,6 +1347,16 @@ void xe_bo_defrag_init_early(struct xe_device *xe)
>  */
> int xe_bo_defrag_init(struct xe_device *xe)
> {
>+#define XE_BO_MAX_IOVA_DEFRAG_JOBS	16	/* Picking a reasonable value */
>+	struct xe_dep_scheduler *iova_sched;
>+
>+	iova_sched = xe_dep_scheduler_create(xe, NULL, "xe_iova_defrag",
>+					     XE_BO_MAX_IOVA_DEFRAG_JOBS);

Should we be creating this only if IOMMU is enabled (IOVA supported)
and defragmentation is enabled?

>+	if (IS_ERR(iova_sched))
>+		return PTR_ERR(iova_sched);

returning early here skips registering xe_bo_defrag_fini. Though it is
unlikely that defrag worker getting scheduled by this time, it is
probably still good to register xe_bo_defrag_fini to ensure worker
is stopped.

Niranjana

>+	xe->mem.defrag.iova_sched = iova_sched;
>+#undef XE_BO_MAX_IOVA_DEFRAG_JOBS
>+
> 	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
> }
>
>diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>index 6e68add4d652..b55d549d5e30 100644
>--- a/drivers/gpu/drm/xe/xe_device_types.h
>+++ b/drivers/gpu/drm/xe/xe_device_types.h
>@@ -38,6 +38,7 @@
>
> struct drm_pagemap_shrinker;
> struct intel_display;
>+struct xe_dep_scheduler;
> struct intel_dg_nvm_dev;
> struct xe_ggtt;
> struct xe_i2c;
>@@ -325,6 +326,15 @@ struct xe_device {
> 			 * @mem.defrag.worker, in milliseconds.
> 			 */
> 			unsigned int interval_ms;
>+			/**
>+			 * @mem.defrag.iova_sched: Dependency scheduler used to
>+			 * run the post-copy IOVA finalize job for defrag moves
>+			 * of IOVA-mapped BOs. The job tears down the temporary
>+			 * copy-step IOVA mapping and links the new backing into
>+			 * the (transferred) reservation once the GPU copy that
>+			 * its dependencies gate has completed.
>+			 */
>+			struct xe_dep_scheduler *iova_sched;
> 		} defrag;
> 	} mem;
>
>-- 
>2.34.1
>
