Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B08ECCF2E4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9896E10EC51;
	Mon, 19 Oct 2026 11:56:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815E010EC51;
 Mon, 19 Oct 2026 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792410989; x=1823946989;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x2wk57Rz55gXkL4F8R5LMsAT/xDDEQS2GB+NEeB2Tug=;
 b=BQPN33yoy30a7NgYjF3gxWtHC1LadfDDOiDvOXgeyHmjq7pSaZApIG3Z
 lVynjE6HHcjI9IPNx8GjMp4XZhOgu/wEpTtVv381VNCVxZEREuwDj2l2t
 MvwOV4ZUodEdejR1dvzL5KU40I/dJF1XPkMNLqqpgrvg+l8S7LmrCX+nd
 B/euLi4j8Mn0fyLDdnr6fX6n7E/DWa9mOMDpPvs+clLXn8irCF55A6nno
 2klYv3lBZCKBzgcUHAQ+Iy6HS8+VQGbl8AXBlfQIhoeBazTU2vEgxBZUx
 JS0w9lCoKcRmtRIG6jL/ZoZSTmNOk22wLyfkfu+cdhf0wFopYnvK+XwvB Q==;
X-CSE-ConnectionGUID: 2ga0NhGdQBKN5IsX9JKA9g==
X-CSE-MsgGUID: RApv4ZxcSSG5ndYnMxKQrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="993867"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="993867"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:56:29 -0700
X-CSE-ConnectionGUID: BCb1LphuT+Ca7fXDIHtz2A==
X-CSE-MsgGUID: YkM8dlQIQOOv8+/hZFKicw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2579361"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:56:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:56:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:56:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBJkTuZgN/ZQH49K05e/6RkOyvlLlxcFfvtOQQJh0iSeecKu3HeRPLQ4jME+GxWQJXMo/MfhtxFsZ6K4clY+1cqYzRl32ZbkZK2oaph4LBRP+nW686/rpe1V1e1FgtDNTAY/oKyCnpmD82E73+fw+rcQy+63iBnb3xRTAAp68fXaMwMbSslRr4fVIyvWC6newTCj5xoMVUqzsDHec5b4jYF3Q0KAwkiLBSX3ZGhPDpIb/0xZaSxiWnZ+yuKm5PdVrOo5ppGlJn7BomiCcn8OH/o7wx09rOPEBTQ/YfPgXSrYyJdk36YLqajM3fsueMDUbUcN6cfYrL81FAriH0W6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV9dv7UmsFfpaw4VeAw5W7+5geJrEbHKzidQ4bmxf14=;
 b=cXkePglqXIIpLY0RUVEMrGsJskBWfNJAezCXSQRMLNCX/1XzLndE+jIAJfBIbAl2kYh5G7pHezU4katTT7l9PfQN8u0SFlILHqykovslmQ+F6b/ynfLBAbqa60ZD4L2IYqut4tUvY8YkTX2Kz8zG7rlibD2BC5slKLcG4QkDDd0xA4Bx2mIvqoh6qnTFcvPctitjBurnmzxyCzXW6toAwC7tuaGQhEFJ6NlLmlqL1IXL4LpoJGIhy9NTiAGd14AKoAvsNlEF+zMXhdpDINK5uPMl4UeXzUS1ZzsAL8AHyxgm/U3Harpc9kewaEZ/tMyuI//ME9PYR5mCOtYBlPKVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by IA3PR11MB8894.namprd11.prod.outlook.com (2603:10b6:208:574::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:56:23 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:56:23 +0000
Date: Mon, 19 Oct 2026 07:56:17 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <tejas.upadhyay@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <riana.tauro@intel.com>,
 <raag.jadav@intel.com>, <joshua.santosh.ranjan@intel.com>,
 <ashwin.kumar.kulkarni@intel.com>, <pratik.bari@intel.com>,
 <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <jinzhou.su@amd.com>, <cesun102@amd.com>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
Message-ID: <atYFYbLXfSIPLTzA@intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
 <20261016154913.1af64e88@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016154913.1af64e88@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|IA3PR11MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: cd265e95-8e6b-46ff-7d05-08df2dd7ff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Hqc9frZCfGzlvwh0G3cYFHzulm6uv5aLzTqzrZx435ivwXBW0ZV22mUKa3P9Aas3hgwARiedd9gg8dDQy12UBsy2doMEmzEjo0eoCiPVkobEd12cWfYgPCoop6WuNx2U+oo75GdsfUkdvcFhIH/iE2lPhgYJHPQo+DLYeqLkEUWQhTG+IxbgH9CxmlE6A+ZvXAW4kTTs3nLss2NZKXsBbjzNp4oEZpM7wfEAjf2LptOs0LYF2K2vcBMccrXbN4l3QJeRmxcc+blooUzsdr9wyrOnOmcPG+prxAIz5wLqX4BOeRdEEM8j5ShAjUwP9UH+0lE26u3sG3QImyqH7ksyk8yyAKz7HGPoWfdm1dqkzUUUAPA/WTXsCdQCHAcagOMln4HAvG7I3pH2mXzPOQjzmaN7d8d3y6OYZ7PQ/yPskc76N7K1W2lV6hrc3XEBB44JFQOC05B9bcVYedqbDB1DQcs2FNZIq+6lmuuUxSuJ+eMULGPh63kINv2cYBDgrfOvtmE+Bwwl+G2JbGLD9wKRX0n0epPZzpdZp6/qT37nuFSwId6BLpFj6e8IQ2Hzv2uYh66yTHOPTkoAhejSJrAtbc4vbiZdmAXjew88r5FZmfVepkTCV/A5KXht5yTkoqZqOEANBWSWo26bcUZ1k3007+dfC90RY1aTxyMy/IXjFso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8/ZQQuY312UgbiVUVKILMVqe+tDU3VntaokbnID+aEY/I8XhvfO8LHV9hml?=
 =?us-ascii?Q?xuEJmHB9uWmqkIT77FrM5s/s7fAAb5y6ejEh7m3VwXB8H8RYYqG7/kO0MOGv?=
 =?us-ascii?Q?F+C2Awsgx/YpFMbpoUHfu9wAqjgaR8k7R0dzIx/FBisfl0l6jDTyfGZ16a+E?=
 =?us-ascii?Q?dk2S10rwdW3jU2fz4OzLZ8/fXzuUQHubImPAIJFYfjpveQ7WMGpp6bFjN8h1?=
 =?us-ascii?Q?SyiUgxpVpKMMu0L5vqWh6t7eaSAtEwKr+gSBOuXZfUzm5BWEmuhwxszhNJ50?=
 =?us-ascii?Q?JMszGiiTHEYnJXlOosPt+PqsTxSfQeCX+yFBcVaeMs9aaTHxa+83+28cFeYo?=
 =?us-ascii?Q?TFejhcIp2J3mXKz2ppSPyu2WLeHefq2CK5seCzXlv8ESnFOf9PRzze/1HL34?=
 =?us-ascii?Q?s7NNuF9F0/FUdPubLKO7np3VDAE6Fd5kolI97zLptOAscZoSI1zQnCdMJt5T?=
 =?us-ascii?Q?8VBqdnflALPK9jx5XeFIAhBqEZuBkGBVcyFHVMkWqIDzQ9glzcFfE0+H41oa?=
 =?us-ascii?Q?jdBXNIfHB4x941kh+ABsZXk5TprdeiPLrsqrwh3NFAmGUrCy1iij8aHgNaO2?=
 =?us-ascii?Q?7qJcy8uVVG4hk6hhG+DS2jczi86uDPAhwygJ9PZVg7/9cmjknaXNiFUbvWig?=
 =?us-ascii?Q?dMsrTKWQqa227HIKioeRj3N0jrP2j1UNGeJPyJ3y3z4o0pD00ZsFPjzKdu8a?=
 =?us-ascii?Q?KAMW5k12qLFSvPyQh47cLeZJmKASpW+taNpJTgOIK2Uij2ml17K5C41dzJp1?=
 =?us-ascii?Q?TD0XqrYoF0HxgPbeEt9y7lgb9quZbUeFRcqr+748vtBeUv+bJHPjywBnegSx?=
 =?us-ascii?Q?j9LV+uX2XxnRBo66dvwjfY9VW9uxQtv4fMp9EeEafKg/uUfUjbmYOOYIMQfW?=
 =?us-ascii?Q?wlzhW3uNntGfbn+oZmnwIm1AgDurzSIdHke1eXCXWMGlqGh28rGxn4cJD/sB?=
 =?us-ascii?Q?b3LAAbmkakZbZfoWTN3v237unyFDdwGWAnHLsEX8lSwclEzmVpu6qh3ZjiXV?=
 =?us-ascii?Q?C+GSy5clvjZ8+IhwewPKZ0hkSVnEuvg4bFtKS3DntQcGnwxRxCZPkK8udNl6?=
 =?us-ascii?Q?Mxual31GKeAx0WnqlGcFybUonr1bkAIIx9HpeB/Wpnri+vNUOTwvqLNAWaAf?=
 =?us-ascii?Q?v2pUlyP/ECf91Xfowvx9RkSXcLkI/XaW5kv0BqXBOQtjlgYdSm0vBN9j3tZL?=
 =?us-ascii?Q?5xz75V+tqpO3TLq1/1Dh8Z59xJgQFGtm2Z83Jwx/VPYNLytrI+bM4tHVRZ49?=
 =?us-ascii?Q?uaRSwGuqJwJe0iiRNN/63Ue7m84hZWz+hiiur6ayY7COQ3Gm0dn2qNolSFdB?=
 =?us-ascii?Q?K3my6Ic5WwTbeiXc9h15wXbsgOgAugogUrbkjeoOqZzdmmpulMVokGekjgx3?=
 =?us-ascii?Q?43eDvvu6J/UHo48DipBCpawOgQpgIOXcYfQfln8kYzCiheLy/TIvYAZ5+qkY?=
 =?us-ascii?Q?/+Ej/ODkgIK5bPY6Vfc/RrnNm/PWKDVFtQ/XGVqIC48Rpry+LuP5t6YxLVt1?=
 =?us-ascii?Q?LGsGISUEJQnKNssRYP97nJUVNbOTi5nBykcKxvZQGDvjJxq8foZkeqa34B9y?=
 =?us-ascii?Q?hgbvHvSU1C/YT/EohrF1T9d7vAL5Z8IBVNu0hcM6EgFx3CtUn+lIBhdHzwGG?=
 =?us-ascii?Q?udRxlynfc0IN+g0wE/TslbsSgQ1oP1Pu16i1SbhaLeWDYW/tXyGVbHTXDsGa?=
 =?us-ascii?Q?tSnHSfFA4mhx0rGk5MISxWzrw6jcRPddFi55DpPPjgGmpibWZ6rWf5DD9qwS?=
 =?us-ascii?Q?VnrT4H9q3Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: NRqvDctNWTbC0mAEtl6rggPZ2/Wsh4IAznA8laSRivTnzUWyy2LpC3LGOG1P8jVK/gwyrybneZR0GA9agFBchE3gTk2i2wyLmBMSk3+H5y4gRh71WAJ5C7D/RtnxPBqFeQx8xfj1BIBqnspn/R+7vYP0b47mvHXdmPFVVGACNT6t0nrToVkj+QhI0wgNtTvO8dngmemAgaD9K62H8NrDJpnuea6HnvzjoKOPScLorByb04V/s28bsTPO7WdpV2DM6yCzzgh+kv7R+GACse60AKoTqhbOgN2PKJnpus/hi5r1f7e6kMiFtNe7X1LQST7tyOgKXvYNTBEUZOOgC13QGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd265e95-8e6b-46ff-7d05-08df2dd7ff22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:56:23.4835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGg1g93JHSD2tLcZis34x+TZT60Qj7Gdg0qmqmEbA0XAQxojLDl+iR/EihpQGB4xwDrIxhLpgSW6tAxHV7eUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8894
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

On Fri, Oct 16, 2026 at 03:49:13PM -0700, Jakub Kicinski wrote:
> On Wed,  7 Oct 2026 13:33:53 +0530 Aravind Iddamsetty wrote:
> > +  -
> > +    name: retired-resource-attrs
> > +    attributes:
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: Node ID targeted by this retired resource operation.
> > +      -
> > +        name: vram-page
> > +        type: nest
> > +        nested-attributes: vram-page-attrs
> 
> why wrap attrs in a nest? Are you planning to add other resource types
> (than a page)? It's a common anti-pattern in Netlink to over-wrap stuff.

we should indeed remove the wrap and have only the page info.

> 
> > +        doc: >-
> > +             Type-specific payload. The resource type is identified by the
> > +             node (its node-name); each node reports a single resource type.
> > +  -
> > +    name: vram-page-attrs
> > +    attributes:
> > +      -
> > +        name: address
> > +        type: u64
> > +        doc: Device address of the retired VRAM page (e.g. DPA).
> > +      -
> > +        name: size
> > +        type: u64
> 
> prefer uint
> 
> > +        doc: Size of the retired VRAM page in bytes.
> > +      -
> > +        name: max-pages
> > +        type: u32
> > +        doc: >-
> > +             Maximum VRAM pages that can be retired. Present only in the
> > +             leading summary entry of the dump (no address/size/status).
> > +      -
> > +        name: status
> > +        type: u32
> > +        doc: Retirement status of the retired VRAM page.
> > +        enum: retired-resource-status
> > +      -
> > +        name: pad
> > +        type: pad
> 
> And then you won't need pad

I noticed this in the review prompts, but I have some reservations here.
We know for sure our value is always u64 because it is our hw definition.
I don't see a good reason why not use the exact size that matches our hw.
