Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB75CD1297
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 02:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C193D10F1D4;
	Thu, 30 Apr 2026 02:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DIl5IOCC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4BE10E045;
 Thu, 30 Apr 2026 02:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777516475; x=1809052475;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UWxzAQsYC4ZpCK5DWOqr96/qPqTzYVNVXDhCXXBm3VE=;
 b=DIl5IOCC5mSgfihkSyx6ErZ3zyQ0smpUE46gK7cctwK7FKTBKnkvEkBA
 nv+C9rSvr9IPdLIoDuny5a1iJe9te8f5rRViWlqtVo1BWrQHOhklBwzVr
 0K8fT40PLJT0Jp6SIaxS9YIRSnyA+fTjLbh+EP1+ZSEqi4dhlBuFrGMXa
 rlzpQ/8CbY5rZ3tLBehu1dPiGvzJwKH0QUvV+BJT1VSPFGezjUwHwmHVC
 xEXVrnZmeb3B7hJegQnJtNVQZaeTf8GSVsP/AANYrcaJ3WvHJUy73cNjH
 t8YfyeZMsNenKzzihPUcZ974gMvNCBD62vSXy0gvc8GlfndsLiktQTapp g==;
X-CSE-ConnectionGUID: cnDaEA3sTVul+as3jAOPSA==
X-CSE-MsgGUID: yYE3s/lKRBajyTx9SRq8gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89552401"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89552401"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 19:34:35 -0700
X-CSE-ConnectionGUID: p5wfFwY5Qdu/Lh8HRpMqHw==
X-CSE-MsgGUID: UoWrtCXrSsujDJtkrWlhsw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 19:34:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 19:34:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 19:34:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 19:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7o5Uu1z5pK4FpvSGuHFDia3yMdJLxsbilIpjslQcGFVBCgzSJ+KCENCxg6GyNRgW37D0XhVXBAdRld3xWUyhDPI1X7t7U2u0k53o0MRyftRzcBIjBcFcGApoMEDWHAq85PHUqTXzNz8Jz8sJiI1H3YoRmCokGtkjM3jG6A1y9vRQoN2e/407X96UbTcISQ78q6pY/dMvyLiqPC9X5jte9g1zw7QfSKTHb6iMrmcpqC0DKvTxhwl7H8vfuCEWdky9RyusCUbYbsE6+zROLi2mpbkyyDyMTP+h8Of+KgY7kO4njPLUAvrGQYPmozw4J2SiE0ryJIyqHHLYDka5K8bXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVtTjTUW+nLhEJHCZCHw6NSYigxr914622q8EmdiefE=;
 b=LrUArHUrQrjQ9/uWbb3IpVcilH75CN4wfwz8YT5k8PGPkA9Yziv7ZWlTRM+SL7KYoEeeW0eaORemICrZpLj+kaICMde2xfeuJnbEVENhNXJ7yLyRTBXxkHOY2fn8xA3kS3ucOmgAssqxbllbUvlmdFlGF7+o0Gj87/caW8cPbI9WneV3Mi056DUhxVeBRL8cHwKtrdo2HQsOVBfSnLbp4JiWMKcNYP2Z4A7E1rXCWvQh4DRr7teNoVrGl5OWVzDFiToLahc+sxmDkulE+joDHLIdlJbFQ7nacbk5BsnzuU3xJexCfK5cxuRgwH0ax43kGFMfsY0fEnjp8LNeUdqSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 02:34:31 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 02:34:31 +0000
Date: Wed, 29 Apr 2026 19:34:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <afK/tPgQsuk37pYF@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <afCCCuLglfi70Tgq@zenone.zhora.eu>
 <afCGGC6MUi1m-Ej5@zenone.zhora.eu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afCGGC6MUi1m-Ej5@zenone.zhora.eu>
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM6PR11MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c614bc-36cc-44cd-5e86-08dea6610269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mfi7J4L5CIHVtoZbrtQBJyNLqITG5XkabLhyEWHj7UX8CZuAfnIaUPTsGpuaHcwVQwXnJiGFlDcd+5+MiE51tzl9gtdKsCCPSpiAcNVtgRMmq+bYDbPLr3CGsta7Naxw9QeScYHzoiXOofFnSgLB/eOEfzUrYdo+Us3x3OyjYQyBZ29jY6PVf422PWAKndu2WSob3I08UITde7CwmyFKuyg4CkBdSVYwuf187BUnqfEnYcP560VY98pgVNC/HlBd2MBQ9FHiJ8F//rplYT/ijJtjSKxd8MgCvRAv5DqdqBAoENp8JMAxEr540EOFymQsfOMKSmelQA5d5sI5+jW0uCVrirfgVzpGsX8uEQgZqLjF+IBZjD3YGd9F/kbGO34LZqIvk9nRx9MHVc82kOzNuBer55NlnO+h3HU32BJq0fVOsXvFNzrnr18PPtyYXTym2Xw7C09IZZCXZyhZUhc3jCVz+wLDXgFnsJd9ITjjJI458o7z0+K16ao36lcMtPLmYjMBO+uLddmk5xnjkVvfUYWo6h717loEM4CZkJEuCsW5r71rzdyeaBGB185Dk7HWOUi8nY/9H86AtNacwIy/OizmtjRwepHCMShU7AIbHX4gH9bb8C/2/zWHdIfAV5SJq2eI1YYTCpFN7+XkkmKKvW7AoAVXl3ZsiL4aOupkgmUfUAiSqiHMG61u3j7yyNBAYjXlIvc/laAfUxkdYjzqHxJaOX/UxuZE6eKj0GrS/VQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keS3AXIJf14iPfqKXJ3mE0BX3pvzhVwKuMv4X+c1AMBAMwpbnzYcOjHt/krn?=
 =?us-ascii?Q?DVrTn6z6bmuKHoRQi5+39jCbowGxX9gKI6l1IIM2naneHfbRnlwjyNcIoYG9?=
 =?us-ascii?Q?5WTpHamjZHLxyDkTJeuOQlaspNM/FQzIPS0gB64XlScMEjKgKzxcbHQ1T8vn?=
 =?us-ascii?Q?jWOnbG8t8YId12EA1PniALqkexrxp+i7gzdQj/JeiekjxdXwWbMrW6OfA0Cq?=
 =?us-ascii?Q?XJHG+jmA2tNpE1kt4rdz3AO5qKhzfNshj50hDSyKI3N+uyqqepB+LfcUq0Qm?=
 =?us-ascii?Q?eawsZPXLymMuYbES3PQ4YLGvSUJe4SVuWHnAojq09NmL8uV9qrzoQYQ4f1iD?=
 =?us-ascii?Q?6kP3+Ift93frk0j6ltRvhdrVwc1WZh2FaKBIx/VM4c0pYFo4ZThQtZZj/yrr?=
 =?us-ascii?Q?taqjLzO+sAmDum36cAHHVqwhX9I9t5KHwyKD3uJQcPFo49SCLXcUcD0f+T5F?=
 =?us-ascii?Q?F9ej5NcyEqrAOMnRFuFL8VXqJvzzL6Fxz5dKmWXlVxdWPKbN+gLWyLi21DQV?=
 =?us-ascii?Q?AXpSV6hC2ZUwSc5o7HCG33ZnWKE58+HxvbNxuME19Cwtuc9q4z8Qpe7ayZ+K?=
 =?us-ascii?Q?FatiedF9sHPWrwMygWIZyla4oqih//66ALDrK44q5Lq97qXa8YrUy07yWLb/?=
 =?us-ascii?Q?XZoZhKdPjTDnc3j1gWzHFWKsCGEY6jGo09zKVdzc5C2jyXYjIGitJRMDFrcY?=
 =?us-ascii?Q?dDYC1ulO0+j+T4nHhaMSiwu5daZyH11B9DqmzfLpalzq5f3rzcQEiNSdHdbB?=
 =?us-ascii?Q?3ZJO8PehF4k+2ZODPrxpcfF3ZelkrgeTvZgH/TCngSFPNX7pq8Kc9cgjONo9?=
 =?us-ascii?Q?8IN/ysOoP1zEUBwpIpvlzhgiy4eR/Kg4s/s9O8zifyNhVW3H+zIS5sk4Ex3j?=
 =?us-ascii?Q?azkwG5yIirHPaIAw3iwBHWqMe5Sg5sj7EeUyUaKNXEf3jF7h2F8Vzb79hnT8?=
 =?us-ascii?Q?LSuqs++Ju7+VT0pFgs+vL+dldNAN4ffjCC9RwuGOzpb5zZKI050UVvXxhNTp?=
 =?us-ascii?Q?4J3/Gk1ZzUAF0QFvomFdcguMWCTcQtdbibp0Z8YcD226ycqRVOWQmuZ5Snjj?=
 =?us-ascii?Q?CPgYJ68k2o//Ocuj2Nh9mM4IDFYhz+byxY2B2Ai1F9zQvFp072Nk9XctuXSU?=
 =?us-ascii?Q?j8rmsOWjENQcNWqYvchVg4xEIeQNbGydYxgroAOhPqXPTpaaWoBw7y3nqdSX?=
 =?us-ascii?Q?opirql0EnHNVJzsEahlft7TbUhXdYUO5DXQhvE5ibNqyUb5VzWF7pIywiz1C?=
 =?us-ascii?Q?IDoGb7eaOlndjQAzboNzIcADwMUVcoSCItiym5CtUuKN8xQTWnrsi1rlljCs?=
 =?us-ascii?Q?Zj+HeJRRruP7WrCq/h0O+D4pC7v1N3L0NjA6yplCTTad1P2AYTjlzNBjK/y5?=
 =?us-ascii?Q?OLpTbBQ5GraaLfkJw7gSVdynsist8und8L4v8SwJwFgOmlFTlhPkvbyOGvMk?=
 =?us-ascii?Q?kOuXzOJ+jnAhn/kkEi6binLXewmufzq7i1jvCoLTsjf4vzJOibsoUF/BAqJR?=
 =?us-ascii?Q?PsuHK666K6UtXY66tJ4BEZGVf2Mt29iHrDGt+OUBbej3gTWy3aSGG0JZ1kB9?=
 =?us-ascii?Q?IilTsV9pmichODmLZdVt1G7QnCgtI1O2ztbGC9aE0PIJfSmOFBsF4Fxi5etY?=
 =?us-ascii?Q?lCKJeHQ1FR0EJiPuJ/jXNgzG6zNICxvz3VeIH2vx9dfC77jBjtZz8PFSppgx?=
 =?us-ascii?Q?uQJNXQQTF9BzbkIc+y/ZM0g5HJ+Xc+9gtoQgfDMGp956xIYKrJ5idUyqBzwk?=
 =?us-ascii?Q?3RJ3jg3FKCi1RsyjNmPKMx6Co1dLewA=3D?=
X-Exchange-RoutingPolicyChecked: dey0ER5DENG59xbFH0nhBtbR4MsRNzkOmgYOzKs3nbjAOMoV+lCa4xoJaSFB2FU/ygGrLCXydQt4jNqUGmgk6Xe+N6DZbqH//BBLrIbxhxdGwwuBIVg2nTlTpZxQyEfwhUwKlT44LUVBETwayF6SFGRmRH2RNMHiiMtYC1CTgHn9miG3xUH0Igv+B8p2S+T2VqckwrGtc4RDZaODZgP3Cw827+ufk47g1rnALeGOmBMgW7GGCqtHpRIUMF/C16lmemyDwbyI9Zyx+no20o2wbA/xKjy7yGxPsfINGbM5N06QxxPy7F5eqxPxjWMppt7mOVQP1CLhFF/nYHSB8RGcaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c614bc-36cc-44cd-5e86-08dea6610269
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:34:31.6876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XzN5JBA4xeu8LJMueKUrjgKUZNJUpCEA+Pfir0DSQz1LBt6yP15yyl1eTu5wF0OTeyqY8t7i7lCVGkKObmwJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
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

On Tue, Apr 28, 2026 at 12:05:13PM +0200, Andi Shyti wrote:
> > > +	if (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2)
> > > +		return true;
> > > +
> > > +	return false;
> 
> P.S.: If you want, this can also be written:
> 
> 	return (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2);
> 

Indeed.

Matt

> > > +}
