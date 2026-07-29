Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB44C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885B210EBC2;
	Wed, 29 Jul 2026 12:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="le/9+ZRy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4A610EBBE;
 Wed, 29 Jul 2026 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785326778; x=1816862778;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=aIibFUiI+79e/5AdiWE7qe8ZM02UfCR+w98TK89Igkk=;
 b=le/9+ZRyltGzM1nYfNRff/2gIHLWThEoXosU/bcCw4UbMyxEjhEo+pKy
 2P0akkrpFY1nWg8Z6oPJTFvMtr+l+ewRCzVm+yTVxE392iSbN9ewH7pqe
 U5wqqucYRdwUmpBRJ4V2JVcLmPvsVdYZKk417tuvAYee77vC7XHLnMJN7
 hblc9AwBr8wUiO/mJ+qAsVha/fzULIT2OwzrbVnBFtkiYeFplHq86ktH0
 2ljLJTmIlObyvzPkvs9v0xClVI1ZndsW/QNPNiY459p3EI4A22LNblxyN
 djMi+EJEMe8aJtj8WRQEln5sN/mDih5lL9M/qbSDP4RgmYJGqNq2G3KVO w==;
X-CSE-ConnectionGUID: uhrgsVjTTdSEsl14aCvjLg==
X-CSE-MsgGUID: SDa6fzGETM6633E85FlRLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86120006"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="86120006"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:06:18 -0700
X-CSE-ConnectionGUID: eRGMrOcsRfiPLaoURjZklw==
X-CSE-MsgGUID: F3xfdWDoQDa5rgL0gNOE+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="265028882"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:06:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:06:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:06:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKC+HMub1H+ZaDA1VRLH5kYQ0DAbZi0LAUhAhg6nddOwfaths0zNLjvbG5NqcZIKfHtFMK0h82ybQzk9fzKTsu1Jq/Pw7/9wx3Hq232vMl7c7M6lnA5iUhXWvUoN8Mtq5qq5YNPFRa+2r++zrLLB0Xt/hC2QVunpB3QcPmj6sYardC3YzI546OprkjdXw+hFA2ltHmEX606Hz8amdf3YOzScKW8+Y8pd+Anm1vx+ADylj1Knd62Jpc1AYoDkZ8vdiBM9aQ1ZRvujX7OySpOMufB0EDuVlGV1Bqa0BFnIVBOoJZV1QGtmAspe2AOvtEOJTyZXHFupZMpSxINhnTQK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avg1mke6u+KRYT1VWdTnPT/cQI4cJ1193l6qLuFkF+0=;
 b=EjhqHzasYHmV3Bjq3MIVa8281/e/rC5dkP58onNUmnwNpihSQicZCPcFdItGWYRwy2VTJZI0F/TSyJV0tzecrJMlredklmJldwBSKBuDw8+0s4YcSuMlyGDIa87mVbVFKn6mrlN2Ih87OQ7VAgqhqhpn+0mkqj/A1Bp9T2xifdptEWGnE2WRZ54JZamD13gTK8ysFrVAu4yUjIxRXgOUcx/Gu9hdywaFtv+MhuDDSPURJfhrnBWSY7pgNp1gb14Okd7PLgprUANTaq2tyJdXw0JILgaY54xuNP068IV9VAiyk5Fb9GGJuCQ/FZjhzSnsRt6thYnTcGaFCxmTq5Ib4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 12:06:08 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 12:06:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jul 2026 14:07:16 +0200
Message-ID: <DKB1JMBPFCNM.2PUIUI31WOCHF@intel.com>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v4 2/5] iommu/dma: Catch scatterlist length overflows
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-3-krzysztof.karas@intel.com>
In-Reply-To: <20260723102542.3245495-3-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU2PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:10:232::26) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|CY5PR11MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 00074b76-e21e-4919-5720-08deed69c516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: VtA8gbj1Mbd7HcI2cocyOWpUx6c4D3PUkeFmxU20H0YkXhMDMjuTMJAz6wgXa4thHoGBMw9Ravu4Aht8o8+2GxPvdzle5OtZqhPQUzHrlPTQNMMTl45mXZ1yLf8gFzWeltGdBIM+vV92hvySEcK2jB9fsBpS0f0wBUUtE9bA6ut9M3BMrPRhghsjrQard+jSJ8zSzWorNg4X8/2c9CPr6xuWXnwndtC5n4r6juFYaFNJpCvv5z2ce6OiMKhTRxu7B2z5WQ6XuoA7pbteTycPOa+ZRyU1YsIeVTY3uROVekG075UqxzkiQihDUaP+D85/CiKMrmBI4DoVNJ/DU1ib3KxZeCjDw1MgETV4ZWFS8dxeLUmRVVAFK84Tg2HV47HLYosRSepm6/HU+u6JI57kJJ5bOiubzDM64/PrB/xivZLXiNhduO8WsyxI35m9DbCWNP4fg1GLLyZnH3USzBYyZTYLzPH6QOpUJTaGEp/SRVa3a1ufP3np/bXuqXHm4GrozXf8NkPP+J8atX2rf8rk3aEdCqLjUU/lIiHUaaIZeSxK9bOmPSHw63tJvf1fVwzv34vou4Lr1G6nNizsFcJwyF7DhJBGF97F29/yqEGH5PJ7fHKXjKHKS2BPh5ENnJNoSeLyjXw3VeeMSgF2DmoywlfFz9lJkibh3SnOskSrPIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6909.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clB0N0ZnMnJkeTl0WmltdHZydS9xdmdCaEpKS25YSUtOZzg4REZ3ODYwUFFC?=
 =?utf-8?B?UjIxVTRSK0dSdkZDSEZhQmpJL1g5SkJTU2tKd3FWOEYzMHErY1lDajV5Q05n?=
 =?utf-8?B?NjFsQlh2M0VodkQ2cXEwMkdFZVFlZlRVK29wbDN2dStmTGJlQmpnNmV6SlJt?=
 =?utf-8?B?OXlJU3NERjVKM0xyS1dHaHJ5b1N0VVhoVVk0a3FIKzNtWlI1dUx3WThodGMz?=
 =?utf-8?B?ZGlSUkFxbzVPc29rWXVCbnVFdEdLaGUrRzIxQnFtTHlIMlB5MWw1bE8yeFlT?=
 =?utf-8?B?NUZaaFpTVjJkUVYvbFZSMzhmV2FlNnE4RC9PajVrT2F3VEFZTzM4YVhYMjU5?=
 =?utf-8?B?dVRIclIreElQV3VVaW5rSG5haWxMcFh0MDFmcVk5c0RYS3UxdnN0R21SUDI3?=
 =?utf-8?B?YzViM0twNVZpNS9YQjlDUVpDU1NVem11bFZ3ZlR1OTIybExOa1JWcENWdGJi?=
 =?utf-8?B?NVFJYVNCdEZrMEtVbm1Vc1JNeUYwTlhsdENGU0dtZjlQNnB2L3pvYTg4bTJP?=
 =?utf-8?B?M3VkVkdnQ2xOdWJzQUk0S2RnSDVUakZXTVR2bDkvOGlOcy9DRDhPK3AxRU44?=
 =?utf-8?B?Y3p5M2x1Nk5UOWxtWkpCR01BMW1seHBRYVBYclhOb01RN01tTjgzNUxIQzBU?=
 =?utf-8?B?dGkzN1Jwck5hbU5qZVFDSlZGcU1BWG5sY2U2TFE1Z0pWYVkvdFFMTzR2WkZK?=
 =?utf-8?B?TDU5MFNwbHdudkpCY0VOSERUVzMvTHAzSnpBUkE5U2hXUkg1QnFmYmJkUHF5?=
 =?utf-8?B?bDBXWExLY2tvV3g2UjJnK0RoY0orV3FTdmNvT3JWLzVXaFVQS2h6ZFJ5bGJP?=
 =?utf-8?B?c0tybVJQMEVFWFR6U2w3UkJkcFF5N2NYVEs5MFVVdm5uOXYwU0w2MDZHQWRG?=
 =?utf-8?B?Vy9OMkxYdWVtMlhWNDR3UG00WW04VVo5Uy9pb3l6QmxGOCtnMVprSVVOMG5j?=
 =?utf-8?B?cjdtc0xUeFZCNUZ0cVUvL3QzN0xQV28yM1JxWEp6MWZhaXdRTW80Ukp3emlX?=
 =?utf-8?B?OG9zQis1UjJveUhMQ1B5aGMrdzZQSTA1b1dBbENsSDcwdWtldFRFNmMrWVZ2?=
 =?utf-8?B?dTZ3RjNKcWRJc2ljc25Wa0NUMXJrZVFUQU5lK0pqQmR6L2FQeGJQOVBRWCtP?=
 =?utf-8?B?MXR4cGllUWIyRm4vZEVsTkcvVE9jZFhnNlJqVVREWGkrTHkvTXJadzdsV2NY?=
 =?utf-8?B?S3BVTkFwUlZUUk1qbHg2QWhlNnR5dnQ5dW0yOEU2STM1V20yZFVLVWR5Mk9x?=
 =?utf-8?B?eGI0cG45aU56WHI5L0dpTGo2aUJKNU1zd1hRU1luNmxrQkxyaDdwc3ZPald6?=
 =?utf-8?B?RjZiYVQ1Mjl6L25yTXpldnZFaUwzZXBJb1UzVkdVSkloZlhmeFIxUGJaSFA3?=
 =?utf-8?B?L3dOVTFaRFVoUmlETmRIZ1UzRDd0c2c0NE5lVE1XM0d4bFdBOVZUY1FIRlpz?=
 =?utf-8?B?bzY0Ly90aDdNVy94RDZldFV1cytMNndvSUp2NWZVUkJNWXVKcDhIb2w4RkFW?=
 =?utf-8?B?ZjdMdkhHVkd4bTBsVzV4czhzNlEvTFdvd01nM3YxUmFvd0ZZQnhXalJ5OHRY?=
 =?utf-8?B?c3RwSUs5ODJ0OU5ISURKTVpyWGtzT3JoRG56Wm45SG93dmpWVFNGOVB3Tmgz?=
 =?utf-8?B?OTRoRnNUT3R3U25TQmxrTENoZ1UrUkVtUEgwWFE5RVd4eVVnZEJwSHkvdzha?=
 =?utf-8?B?WjlJdWxUVHFkb0xMNTBHREpZQWV5cmxXMHhBNG1tLzBwMVo1QUEwVkFnRkVp?=
 =?utf-8?B?enlKblZOVkU1UlRZcmp3WVk1bkFPZ1hMeFJoK2xEL2t6QTNGOXZvbkZxY0pB?=
 =?utf-8?B?ZlVtMlZEZGh4MFA4M2lJdnNXVTAwYzhZc2c4Z3RmRXYrTSt0SUtrbThJTDlK?=
 =?utf-8?B?akRRdUsxdmQ0WUJsRHYyTHdZTkxHenE1OHFVeXVGS2VITWxZaTRaRlhFaHNV?=
 =?utf-8?B?R0cza2hxcTg0QlNRTTNBWEtJY0pkZk9UZVVEWnd3T3hZRDZaQi9wNzFtaEZn?=
 =?utf-8?B?cHRrT0VNOXE3K0Y2TnBoa1p1ZHFmR01rN2VtQVFrVDV4OTBSckVQQVpSSjFR?=
 =?utf-8?B?QUFqeUVuNGdOYnlZeHFQMnhEWXpab2MxOXRxZnhtZ1ZPWlFoRCsxUkxEelp2?=
 =?utf-8?B?SHU5ZG82TWxHSkdlZGp5NnNuVEFBL3BBcmlVb1JHSXF3MHpMUGFuajdEODlx?=
 =?utf-8?B?eWgyTjlaKy83eVo4TWY3ZS9sdGUrMFF4UFZrNG9nZCtCY3Qyekd2U2JLNU1s?=
 =?utf-8?B?aVluZU1QS3VxMVM0WExSQTVaQ1VLSFFWZjJWN3ZhdGttcjNEeGIyTlF1RitG?=
 =?utf-8?B?QmxrUWlmcEtzRjI4YUhaQVNvTzdEWU1zN2FBbjhZUXVTKzlOUjhZMW41M2lw?=
 =?utf-8?Q?dYOYAK91dohqp3zg=3D?=
X-Exchange-RoutingPolicyChecked: g/U6foB1zWoZm7DZTdkBvNzP+0PIykLp1HYfuxPPOILKWsaduA2w88EIKItD6HjLi5nEo7UfyctMhuMG/uZjiiGgAaRttpFBJ8q7dUrbPbKao/g0vHML+lxsx4xmRNUUvZtkzwTWL3PMJdPtcGbmISr1cciZ8vL7uKUJaMs+Kh8qI2I7mrV0nduZQoSU5XVfFz6cHKHbic2bBz0FzkuziA/lFqT0qdtzcICTPEc5RP1pVA4pho8I1D6Z1uVziQXK3Mq+uYGDqTyrvOeAGUh7tgEwMuG5xdyKAqKuwvLNMpoORx34Q6u6VOuekyC+Fg+6y25OOsIOvObUyPL12kx71w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00074b76-e21e-4919-5720-08deed69c516
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:06:06.9734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU67gVm/DdFH+RtH9pTcccfW5S+Pz2QkMTh20PsoIGU1MnL9a17DDtom2dlQg/i8YdtN2EdE2+X/YPSaGW1rv3QRKKFSPf3dKlHJwaOuE4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6391
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

Hi,
On Thu Jul 23, 2026 at 12:25 PM CEST, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses only one
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>  1) silently wrapping the value
>  2) smaller than desired mappings produced by iommu_map_sg
>  3) leaving mapped bytes in memory (no iommu_unmap)
>
> Address this issue by adding overflow detection for scatterlist
> length field.
>
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v4:
>  * Added value wrap check before s->length assignment (Robin);
>
>  drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..3ca3196a41b0 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -21,6 +21,7 @@
>  #include <linux/iommu-dma.h>
>  #include <linux/iova.h>
>  #include <linux/irq.h>
> +#include <linux/limits.h>
>  #include <linux/list_sort.h>
>  #include <linux/memremap.h>
>  #include <linux/mm.h>
> @@ -1477,6 +1478,12 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		sg_dma_len(s) =3D s_length;
>  		s->offset -=3D s_iova_off;
>  		s_length =3D iova_align(iovad, s_length + s_iova_off);
> +		if ((s_length & UINT_MAX) =3D=3D 0) {
Might be better to go with =C2=A0s_length > UINT_MAX=C2=A0. Right now it's =
64 &
32, so only the lower bits count. Or just ignore this comment  it if
it's intended.

--=20
Best regards,
Sebastian

