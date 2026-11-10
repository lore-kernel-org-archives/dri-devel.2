Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A6606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/tIIxHK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49DB10E539;
	Tue, 10 Nov 2026 02:37:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F7810E2A9;
 Tue, 10 Nov 2026 02:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794278238; x=1825814238;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=LXLV4NWThGKx35o7QJS+1aykrPeZPG822+w+WNyELXY=;
 b=B/tIIxHKwcF+S9Bpt2uqpm0rmsBKlRIuBHv83P8fTSHBNs7KIPrY3S56
 f/yJu8tWehg3EnQlT7n1Hpui72I9nWlDc03as5bW9+4/Gp7bfaWSrRrnH
 nlTm/wnIE4XOVN7OTpXxJYKLbK6rANzkc9dZmQ4KE+ShGrs8mpZbBDnlQ
 QrKAtl7IaQiPNFYWEg2I7x5nboYnFWJOTlQZghezrzXoKJtJf3FVT8mf1
 704iR4hc0o+q7Dgkep9Kc3w0yQXKSuE7OIF4pjJwv/UbF4SkzUnGO8atH
 zvsK7msoqOTsg5Om0dMom+xt1QeyHbiEVnZFK8QpJSD19o2Q3WUBMOILl w==;
X-CSE-ConnectionGUID: 8Il82v7zQtGv+t6TZU+rnw==
X-CSE-MsgGUID: ScPYtHVWQ9Svvmw/KTvRzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2902191"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2902191"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 18:37:18 -0800
X-CSE-ConnectionGUID: nwqTbnKVSmCrBEYA06lzuw==
X-CSE-MsgGUID: 25GKkvLiT6mfhodiUJFc4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8463425"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 18:37:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 18:37:16 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 18:37:16 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 18:37:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjXqYDbgClsOCwcE5nbnO/pYES0SoO127a4jXogs3JtN3stL6p3sazM+NrsibHvQLW3+tiuoLHR8se5o7qIUeXgztDdtTV5iyxmG6uK1o/fuOFVmI2FtE7kEVnOmGsLK2wSLNn0qTxHuI/SagALN42ZKANts8pVUyG04ZU96Dg/n9WoThnIRHRQDI5RRvyXrIXEM5hOlzWEwa1zcEfBsfqj7ePOWeWnkZ9iyrgcWeNHgUbklFywVxy3kVQezOktmqb85cPVk0768mZnQrtKTQ6BQU57HeQ7F3DSL3Ed8pRErKND3TTf8Rk8ImxVK7qGgVeVSkErNLi7e8FnIhUvINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2TKj6kYfJbgs5d9m55Q2v20hkwOOI7pNQ4NUl7CdvY=;
 b=fZv8cx1EHlK1IFNUX7kYpyHNfd4WRhimKS6arlXrkrsZF91MnzVSXEOHBVKFf5ZXlKP5kWVKifXSEwu5p+x0Ioz7snQz3eB4zHtNr95g2yvzxp2eS9dNPshlUotQalzLEy4mbWtr8zbCp4tOHtDZPaR30xCLMtDFBx8eo1In58vsAzMi+zypeNLrHKxTCheddzEdv1vDCpIqlyDZzmcWeJu39mXVoY1qhMXBHWxAUQYYGOJpB9uAqtfLzpVFpzVLm4jufYcewOQmHT1VGBZAO18HAebdc3Qwxq3gosXgvt1V5mrydXFr1LnCtmrlfH6blbfjLWhLP5BG75txaFJphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by LV2PR11MB489841.namprd11.prod.outlook.com (2603:10b6:408:416::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:37:08 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:37:08 +0000
Date: Mon, 9 Nov 2026 18:37:05 -0800
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
Subject: Re: [PATCH v3 07/33] drm/ttm: Harvest beneficial-order pages on
 defragmentation moves
Message-ID: <avKDURZLW9pvCFvF@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-8-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-8-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|LV2PR11MB489841:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f88d35-d027-4dd6-7ea5-08df3ed38393
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261021133027099003|261022115727099003|261009220027099003|261022113327099003|261026121527099003|261026140227099003|261021121427099003|261021130227099003|261021135927099003|261022105027099003|261021123027099003|56012099006|261026130827099003|261026135527099003|261009221227099003|261022075727099003|261028144727099003|261009223327099003|261009221727099003|261009223027099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: ufZlBNnYLeJ0zbYc1BcL7ABMzQCyL7VpxzocOdkD+K94vQ+/JqYsvglLdyYj25jpNBXVLSTRgjq9E0Mk6R/A+wVircLDxIUnXC9NfKd7z4I0indIN0333nyRpjTUfb7gNccAmtc0Yr3Vl7sSBBgDHRaDSsaZB4EgT8pTtg/59LwZye2/JAEjt/HDCW/DKOmq4B/pIBwZMp8ZG7StOujGOeWFiP+Oi1G9G4Pqwf+xqBi5QO8iZoGWXLXCF11dGj1jwoPxxfCpjG3MkgVpmpJq0ZooHy3Eb9uCcHmS+WtNQGAyaVb5W7KAwMu5+QXM8kuhE3+uTWt/Gg7qDzQTwGYnmn7q+ewfnFj/UHqSTB/n8spRHxXR0172BnRLbOVVCz7cAu/wxQm+eoos5p4TTiQ6ocGTO/nA2qUediuCdFiWuruW87aPvdeX6nYvnOod5Zmb9bgWuto5Vgi1kiYuMAWbjTaNb045OlvTGA72b7o2j+7WrXu0CD+bCHzAMFGQZQFHEdAmcpFI2ghjZHXQoVII55jHNo3cPPrsE+8LrypzP51V5xwmP2lwz7nUW5kbRTxoErxwUbLLWKDdphvpDX6oRLYBK9sJ65bfCbrsIOnQU8qZN60BhskHJv1BbcYuj75r8pFKgCe57xOaexU3gqpqPImXyLclanOGytyQevnN6VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261021133027099003)(261022115727099003)(261009220027099003)(261022113327099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021130227099003)(261021135927099003)(261022105027099003)(261021123027099003)(56012099006)(261026130827099003)(261026135527099003)(261009221227099003)(261022075727099003)(261028144727099003)(261009223327099003)(261009221727099003)(261009223027099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4pVO93Ky88KLCANXJ7MF7zQUH+FCPJH6PZY6Lq5aI8QgoFOtuJLWsX3llJ?=
 =?iso-8859-1?Q?GQLIeAIm+nZDBCth1ATpHA5HhiU0m7NrsvBHQNazRbtP5kZSLdYf1J+EhF?=
 =?iso-8859-1?Q?JdLY8TngOScAnq5mJCkBmnw5qkp/XcYhSjfkZJPYkXxDE1VIJ5g13jIFR6?=
 =?iso-8859-1?Q?8/5BDqFZSqy7BCK8CSwddUDtoDutagIFx98K/+KJ/cDjjba4EMfCkuYKrs?=
 =?iso-8859-1?Q?2WruVV6lGwBtIwG5BEeuU7JYlhhp5NLvstitDfL6lHqOhvwt5CEJM8w+nj?=
 =?iso-8859-1?Q?DC0o0ljiitN+BRUfsqqNe0MdW3Z2HB/2XId07+P/pvaBQCccOZVsl/DzSu?=
 =?iso-8859-1?Q?x+dX+COB17hoxWXjbxI2oBK0tE7s124WxYUaJ985W+SMzScGLLOnTolyO1?=
 =?iso-8859-1?Q?7RiznxDSPV1xDK2c0s6j43JP62KZhEMhhUWd1yxGKimYiFN5mXxVaNtu0j?=
 =?iso-8859-1?Q?9+TfFl9gdVas8Nx2viiJYr27aX/FVC5mhifBfrZzdS8DB/myRTFhvb0RfG?=
 =?iso-8859-1?Q?gFWhMGAUvDlYjtQTWrGt6fpQPhIuJEOeXRWTCXJjmlRH9vjIO6gqOBdBJd?=
 =?iso-8859-1?Q?/ooFdB89C/mM17IyVlf0TX3b4/fQrfT+wvfC4heYPONhprV1W7ZrBWp7cY?=
 =?iso-8859-1?Q?jrwrGRzqqWudXc2kbAzZ5ROyHm8kTBQHkDPIfGUQLQk/u/dFRgQww+GOBn?=
 =?iso-8859-1?Q?1RbS4pX+Z0B0rhOU+pCGZnUyGy3CYc3SYiKarduKeiGYZbbIjcn9RwNSJF?=
 =?iso-8859-1?Q?sO/Kk+2iS676jkYYVmJGL1P5xbJPJBIrFWDVQP6o8IQsrV4wb0KWp5CPT0?=
 =?iso-8859-1?Q?xpSQZvlahsRXygyXh6zhSB7ia0IyBObwttzk7vUrr6EdxWjjgZTX661VAl?=
 =?iso-8859-1?Q?cPlIU0aJwGFSDkC7aseLs+mCXZ1plfCLh76cR10RVDs3IBl7avuEfEm554?=
 =?iso-8859-1?Q?6InnfHmEP01WlcgyA8wUeDyKSBKfPtWgEofSZw8SJFcPTGCjxwHrJE31Fo?=
 =?iso-8859-1?Q?yiV+mvwK6Ed7p2fZ4eEAsbXkMxoymlrRskBEknbzWxe93ZWZTWOSytC1js?=
 =?iso-8859-1?Q?JqvtcPMf7xaKuQYbUKYkhRxq4TYCCSiW2PPxS+OOC4j4Dkt4sZCLgLbTMO?=
 =?iso-8859-1?Q?EsXhmnkfND3wi6KNCMcSpW4OBODeHb9zdD7fbCYQllCnP0n6gLXTJy39Kp?=
 =?iso-8859-1?Q?+JzarZI+gOdYUiWVaZETFxZBuRrWtm9WDoktsyYJ9Csjxz4AbpLKvc1oJ6?=
 =?iso-8859-1?Q?7ajvzZsuAfWzaS6DMtRyRkb3HuPu8JM+1Iia451OXaerO6KFOJCi9FwFKQ?=
 =?iso-8859-1?Q?G3Kf3USSExi2vJZM7JWwto7+YiIB69DjI56/OnO6oAtql4E1qf0j9zoi/b?=
 =?iso-8859-1?Q?LMNDhebWXlYzZHXyj/9rksjikmNEBwAINYLq3AMFTx7ZCQt+g52hjTSuke?=
 =?iso-8859-1?Q?IlXfJ9i73shO+DpLGk/dvuVscnfUqm4jW6uJD8siJ3M6xs0t6UQ12A1wdI?=
 =?iso-8859-1?Q?VwrRcmSdcFaAU8T4w4CtucO3Yk3od2wSi7KvjUuyZra5ErBRn+lP24hUU8?=
 =?iso-8859-1?Q?EN4iE8DTO8ZtfuhG3OMaEQRayYoIdhfMXFRE1VJPPu3ZxivR3D5sP+rvyi?=
 =?iso-8859-1?Q?5hJKcZSBRtz6LOlbLOh60EAs9JRUkUqgNLkRjlr3yrwv2a+ONVZIZ0w5cY?=
 =?iso-8859-1?Q?+JymMJb35+Egwmz2+GmO5pYsFiuNQKyyj321+oQjqh66nQmj5iOsAJDvSL?=
 =?iso-8859-1?Q?a3nuQLnZ8ocqKZrEVi97wRBtkgaO6ubxRbXNFmklOFqHo+VJbvnUUDQU49?=
 =?iso-8859-1?Q?7hM1JYAM0T+sd8y3xSXot615XcrCurx7jbbyQmap6+y6U+CDP3DR?=
X-Exchange-RoutingPolicyChecked: hQRLbzH1n38rTSHCOFf1SKUWzYiYOImkWhq96LgX0L13YB+QV/6aYAHf9/5oa+v5DZdIXEwJcIx+hWNXHvLwhnhO16ly78127mn8+zBOlopjRj7IhcBPcqv2aCVyEkeqIgB+OaGuVcloiQWFK4MWpfJ7LWFDi2NGeoJ0kMUX7WrldVlf8rDuxx+ZTMBjE1PlkqzEVbkuxkIDiGiT6easYYDo3X96B84LeVNU2ekiMR8aT03j2vw+fnDVBtcAb8hCbkJhsMzicpDNWZsBlZ42mYw/i2qLyfTDg7/xIvvlAH+TNsR5o+NxSPvPWv2a+Ip3NIdEzuvbSiWpv05HR09vZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f88d35-d027-4dd6-7ea5-08df3ed38393
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:37:07.9261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXhSs4aerQ5guZjnDNmn4EEyyEfNJgVSUwTPN9DxxdElpXKM3WJ+tyJ3ejHgDT6LMnDOIZQwVzjl9VdqkLTUtoGiTHMbcAl8kwwZVFLBFy1s6Tjaf/O4851nMb6UsDkn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB489841
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

On Fri, Jul 10, 2026 at 07:55:53PM -0700, Matthew Brost wrote:
>A defragmentation move relocates a populated tt into a freshly allocated
>one so that sub-beneficial-order chunks can be upgraded to the device's
>beneficial order. Previously, if allocation could not complete entirely
>at beneficial order, the move failed and all progress was discarded.
>
>Instead, once allocation has successfully upgraded part of the object,
>the remainder of the old tt is harvested to complete the new tt. Thread
>the BO's old, still-populated tt into the page allocator via a new
>ttm_operation_ctx::defrag_old_tt. While allocation is still proceeding,
>any existing chunk already at (or above) the beneficial order is reused
>directly instead of being reallocated. If allocation later has to fall
>back below beneficial_order after making partial progress, the remainder
>of the old tt is harvested instead of failing the move. This preserves
>the beneficial-order upgrades already made while leaving the rest of the
>object unchanged, allowing subsequent defragmentation attempts to make
>additional forward progress.
>
>Harvesting only borrows the pages; they remain owned by the old tt until
>the move commits. This keeps every unwind path non-destructive: if the
>(re)allocation or the move later fails, the new tt is torn down without
>freeing the borrowed pages and the old tt is restored fully intact.
>Ownership of the shared pages is transferred to the new tt only once the
>move has committed. ttm_tt_defrag_disown_borrowed() implements both
>directions of the transfer by clearing a tt's slots for every page it
>shares with the other tt (same struct page at the same index), so that
>tt's teardown leaves the shared pages alone and each page is freed
>exactly once by its owner:
>
>- on the alloc unwind and the failed-move paths, the new tt disowns the
>  borrowed pages, leaving the old tt as the sole owner;
>- on the successful-move paths (synchronous teardown and the pipelined
>  ghost-object teardown), the old tt disowns the now-transferred pages,
>  leaving the new tt as the sole owner.
>
>Detecting shared pages by same-index struct page identity needs no extra
>per-tt bookkeeping, since two distinct allocations never alias. This is
>safe with drivers, such as Xe, that build their own per-tt sg table and
>DMA-map it independently: each tt maps and unmaps its own sg, so sharing
>the underlying pages between tts is DMA-clean.
>
>This is a no-op unless ctx->defrag_old_tt is set, which only happens on a
>defragmentation move.
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
>
>---
>
>v3:
> - Document the chunk-head invariant read by
>   ttm_pool_harvest_remaining() (Sashiko)
>---
> drivers/gpu/drm/ttm/ttm_bo.c      |  20 ++-
> drivers/gpu/drm/ttm/ttm_bo_util.c |   5 +
> drivers/gpu/drm/ttm/ttm_pool.c    | 235 ++++++++++++++++++++++++++++--
> drivers/gpu/drm/ttm/ttm_tt.c      |  67 +++++++++
> include/drm/ttm/ttm_bo.h          |  12 ++
> include/drm/ttm/ttm_tt.h          |   2 +
> 6 files changed, 328 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>index c1629b4c4f0f..ab2e637a017f 100644
>--- a/drivers/gpu/drm/ttm/ttm_bo.c
>+++ b/drivers/gpu/drm/ttm/ttm_bo.c
>@@ -182,7 +182,14 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> 		}
>
> 		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
>+			/*
>+			 * Let the page allocator harvest already
>+			 * beneficial-order chunks out of the old tt to back
>+			 * the new one, rather than reallocating them.
>+			 */
>+			ctx->defrag_old_tt = defrag_old_tt;
> 			ret = ttm_bo_populate(bo, ctx);
>+			ctx->defrag_old_tt = NULL;
> 			if (ret) {
> 				/*
> 				 * Discharge the freshly allocated backing and
>@@ -235,6 +242,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> 	}
>
> 	if (bo->defrag_old_tt) {
>+		/*
>+		 * Successful defrag move: any pages the new tt borrowed from the
>+		 * old tt are now owned by the new tt. Disown them from the old
>+		 * tt before it is torn down so they are not freed.
>+		 */
>+		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
> 		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
> 		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
> 		bo->defrag_old_tt = NULL;
>@@ -245,7 +258,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>
> out_err:
> 	if (bo->defrag_old_tt) {
>-		/* Failed defrag move: restore the original backing. */
>+		/*
>+		 * Failed defrag move: drop any pages the new tt borrowed from
>+		 * the old tt (still owned by the old tt) before destroying the
>+		 * new tt, then restore the original backing.
>+		 */
>+		ttm_tt_defrag_disown_borrowed(bo->ttm, bo->defrag_old_tt);
> 		ttm_bo_tt_destroy(bo);
> 		bo->ttm = bo->defrag_old_tt;
> 		bo->defrag_old_tt = NULL;
>diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>index 771313162c8d..7cb718fc97c0 100644
>--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>@@ -633,7 +633,12 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> 		 * tt (the move's source) to the ghost so it is kept populated
> 		 * until @fence signals and then unbound and destroyed, instead
> 		 * of being torn down synchronously. @bo keeps its new tt.
>+		 *
>+		 * Any pages the new tt borrowed from the old tt are now owned by
>+		 * the new tt; disown them from the old tt so the ghost teardown
>+		 * leaves them alone.
> 		 */
>+		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
> 		ghost_obj->ttm = bo->defrag_old_tt;
> 		ghost_obj->defrag_old_tt = NULL;
> 		bo->defrag_old_tt = NULL;
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index 2598d2f33767..52f5e64f05dd 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -792,6 +792,148 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
> 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
> }
>
>+/*
>+ * Defragmentation page harvesting.
>+ *
>+ * A defrag move relocates a populated tt into a freshly allocated one in order
>+ * to upgrade sub-beneficial-order chunks to the device's beneficial order.
>+ * Chunks in the old tt (ctx->defrag_old_tt) that are ALREADY at the beneficial
>+ * order do not need to be reallocated: their physical pages can simply be
>+ * transferred ("harvested") into the new tt at the same offset, avoiding the
>+ * alloc/free churn that is significant for large buffers.
>+ *
>+ * Harvesting only borrows the pages: the new tt simply references the old tt's
>+ * pages, which remain owned by the old tt. This keeps the unwind paths simple -
>+ * if the (re)allocation or the move later fails, the new tt is torn down without
>+ * freeing the borrowed pages and the old tt is restored fully intact. Ownership
>+ * of the shared pages is transferred to the new tt only once the move has
>+ * committed, via ttm_tt_defrag_disown_borrowed() (see ttm_tt.c).
>+ */
>+
>+/*
>+ * Return the allocation order of the old tt chunk whose head sits at @off, or 0
>+ * if @off is not an old chunk head (it falls inside a chunk, or the slot is
>+ * empty / backed up). @cursor monotonically tracks the old chunk boundary and
>+ * must be advanced past every offset that has already been queried; a page
>+ * order may only be read from a chunk head page, hence the lazy walk.
>+ */
>+static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
>+					      struct ttm_tt *old_tt,
>+					      pgoff_t off, pgoff_t *cursor)
>+{
>+	struct page *p;
>+
>+	while (*cursor < off) {
>+		p = old_tt->pages[*cursor];
>+		if (!p || ttm_backup_page_ptr_is_handle(p))
>+			return 0;

Assisted-by: LLM

ttm_backup_page_ptr_is_handle() is only check here, but not in the harvest
function. Probably we won't endup with ptr_is_handle() case during defrag,
but thisasymmetry makes it bit confusing.

>+		*cursor += 1UL << ttm_pool_page_order(pool, p);
>+	}
>+
>+	if (*cursor != off)
>+		return 0;
>+
>+	p = old_tt->pages[off];
>+	if (!p || ttm_backup_page_ptr_is_handle(p))
>+		return 0;
>+
>+	return ttm_pool_page_order(pool, p);
>+}
>+
>+/*
>+ * Borrow an already beneficial-order chunk from the old tt into @alloc. The
>+ * pages stay owned by the old tt until the move commits.
>+ */
>+static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
>+				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
>+{
>+	pgoff_t nr = 1UL << order;
>+	int r;
>+
>+	/*
>+	 * A harvested chunk keeps the (same) bo's caching, so the deferred
>+	 * caching range is consistent here; flush it before committing, exactly
>+	 * like the caching-consistent path in ttm_pool_page_allocated().
>+	 */
>+	r = ttm_pool_apply_caching(alloc);
>+	if (r)
>+		return r;
>+
>+	/*
>+	 * The borrowed chunk's page pointers (consecutive struct pages of one
>+	 * compound allocation) and dma addresses already sit contiguously in
>+	 * the old tt at @off. Copy the whole run with memcpy() instead of the
>+	 * per-page increment loop in ttm_pool_allocated_page_commit(): for a
>+	 * large defrag the borrowed pages dominate the new tt, so this turns
>+	 * the populate fill from O(num_pages) individual stores into a handful
>+	 * of bulk copies.
>+	 */
>+	memcpy(alloc->pages, &old_tt->pages[off], nr * sizeof(*alloc->pages));
>+	alloc->pages += nr;
>+	alloc->remaining_pages -= nr;
>+
>+	if (alloc->dma_addr) {
>+		memcpy(alloc->dma_addr, &old_tt->dma_address[off],
>+		       nr * sizeof(*alloc->dma_addr));
>+		alloc->dma_addr += nr;
>+	}
>+
>+	alloc->caching_divide = alloc->pages;
>+
>+	return 0;
>+}
>+
>+static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
>+				      struct ttm_tt *old_tt, pgoff_t off,
>+				      struct ttm_pool_alloc_state *alloc)
>+{
>+	/*
>+	 * @off is always an old-tt chunk head here, never a tail page, so
>+	 * reading the per-chunk order below is safe. This holds because:
>+	 *  - Old chunks are self-aligned: greedy largest-power-of-two fill
>+	 *    places an order-k chunk at a 2^k-aligned offset, so any
>+	 *    beneficial-order-aligned offset is a chunk boundary.
>+	 *  - Fresh defrag allocations are capped at the beneficial order (see
>+	 *    ttm_pool_iter_acquire_page()), so they advance @off in beneficial
>+	 *    steps and never overshoot into the middle of a larger old chunk;
>+	 *    super-beneficial old chunks are always harvested whole by
>+	 *    ttm_pool_iter_reuse_old().
>+	 *  - We are only reached once the defrag budget/prealloc is exhausted,
>+	 *    which in the capped/prealloc config leaves @off beneficial-aligned
>+	 *    (or, in the sub-beneficial tail, already walking old boundaries).
>+	 */
>+	while (alloc->remaining_pages) {
>+		struct page *p = old_tt->pages[off];
>+		unsigned int order = ttm_pool_page_order(pool, p);
>+		pgoff_t nr = 1UL << order;
>+		int r;
>+
>+		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
>+		if (r)
>+			return r;
>+
>+		off += nr;
>+	}

The 'off' being always at chunk head is documented, but not checked/enforced
in the code. Though currently, we won't have it otherwise, but tomorrow if
we do for some reason, it will go unnoticed. Probably worth adding a warning
here.

>+
>+	return 0;
>+}
>+
>+/**
>+ * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
>+ * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
>+ * @TTM_POOL_ITER_RETRY: Loop state was adjusted (e.g. order lowered or a chunk
>+ *	harvested); re-enter the loop body for the next order.
>+ * @TTM_POOL_ITER_STOP: The allocation is complete; stop the loop.
>+ *
>+ * Phase helpers return one of these (>= 0) on success, or a negative errno on
>+ * failure (the caller then unwinds via error_free_all).
>+ */
>+enum ttm_pool_iter_action {
>+	TTM_POOL_ITER_FILL,
>+	TTM_POOL_ITER_RETRY,
>+	TTM_POOL_ITER_STOP,

NIT...STOP is really not needed here, RETRY will do as the loop is
expected to end there. But it is fine.

>+};
>+
> /**
>  * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
>  *
>@@ -806,6 +948,7 @@ struct ttm_pool_alloc_iter {
> 	const struct ttm_operation_ctx *ctx;
> 	struct ttm_pool_alloc_state *alloc;
> 	struct ttm_pool_tt_restore *restore;
>+	struct ttm_tt *defrag_old_tt;
> 	unsigned int beneficial_order;
> 	gfp_t gfp_flags;
>
>@@ -814,9 +957,50 @@ struct ttm_pool_alloc_iter {
> 	enum ttm_caching page_caching;
> 	bool allow_pools;
> 	bool fail_beneficial;
>+	unsigned int alloc_count;
>+	pgoff_t old_cursor;
> 	struct page *p;
> };
>
>+/*
>+ * Defrag move: reuse an already beneficial-order chunk from the old tt at this
>+ * offset rather than reallocating it. Harvest whatever order the old chunk has
>+ * (>= beneficial order), which may exceed the order the new tt would otherwise
>+ * pick. An order below beneficial_order is only reused for the unaligned tail
>+ * (where there is no benefit to reallocating). Only borrows the pages; the alloc
>+ * unwind path can drop them again.
>+ *
>+ * Returns TTM_POOL_ITER_RETRY when a chunk was harvested, TTM_POOL_ITER_FILL to
>+ * fall through to a fresh allocation, or a negative errno.
>+ */
>+static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
>+{
>+	unsigned int harvest_order;
>+	pgoff_t off;
>+	int r;
>+
>+	if (!it->defrag_old_tt || !it->beneficial_order)
>+		return TTM_POOL_ITER_FILL;
>+
>+	off = it->tt->num_pages - it->alloc->remaining_pages;
>+	harvest_order = ttm_pool_defrag_old_order(it->pool, it->defrag_old_tt,
>+						  off, &it->old_cursor);
>+
>+	if (harvest_order < it->beneficial_order &&
>+	    it->order >= it->beneficial_order)
>+		return TTM_POOL_ITER_FILL;
>+
>+	it->order = harvest_order;
>+	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
>+	if (r)
>+		return r;
>+
>+	it->page_caching = it->tt->caching;
>+	it->allow_pools = true;
>+
>+	return TTM_POOL_ITER_RETRY;
>+}
>+
> /*
>  * Acquire a single page for the current order, leaving it in @it->p (NULL on
>  * failure). Tries a same-order pool page, then a fresh system allocation. Fault
>@@ -859,9 +1043,10 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> /*
>  * The current order could not be satisfied. Lower it and retry, recording a
>  * sub-optimal backing (so the driver can later re-defrag) when we drop below
>- * the beneficial order.
>+ * the beneficial order. For a defrag move that has already made partial
>+ * progress, harvest the remaining old pages and stop instead.
>  *
>- * Returns 0 to retry the (lowered) order, or a negative errno.
>+ * Returns TTM_POOL_ITER_RETRY, TTM_POOL_ITER_STOP, or a negative errno.
>  */
> static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> {
>@@ -871,16 +1056,24 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> 	if (!it->order)
> 		return -ENOMEM;
>
>-	/*
>-	 * Failing to allocate at the device's beneficial order means we are
>-	 * about to back this object with a sub-optimal (smaller order) set of
>-	 * pages. Record it so the driver can later try to defragment the object
>-	 * back to beneficial order.
>-	 */
> 	if (it->fail_beneficial || at_beneficial) {
> 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>-		if (it->ctx->defrag)
>+
>+		if (it->alloc_count && it->defrag_old_tt) {
>+			pgoff_t off = it->tt->num_pages -
>+				      it->alloc->remaining_pages;
>+			int r;
>+
>+			r = ttm_pool_harvest_remaining(it->pool,
>+						       it->defrag_old_tt, off,
>+						       it->alloc);
>+			if (r)
>+				return r;
>+
>+			return TTM_POOL_ITER_STOP;
>+		} else if (it->defrag_old_tt) {
> 			return -ENOMEM;
>+		}
> 	}
>
> 	if (it->fail_beneficial)
>@@ -890,7 +1083,7 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> 	it->page_caching = it->tt->caching;
> 	it->allow_pools = true;
>
>-	return 0;
>+	return TTM_POOL_ITER_RETRY;
> }
>
> static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>@@ -904,6 +1097,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		.ctx = ctx,
> 		.alloc = alloc,
> 		.restore = restore,
>+		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
> 		.beneficial_order = ttm_pool_beneficial_order(pool),
> 		.page_caching = tt->caching,
> 		.allow_pools = true,
>@@ -931,13 +1125,22 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> 	     alloc->remaining_pages;
> 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
>+		/* Reuse an already beneficial-order chunk from the old tt. */
>+		r = ttm_pool_iter_reuse_old(&it);
>+		if (r < 0)
>+			goto error_free_all;
>+		if (r == TTM_POOL_ITER_RETRY)
>+			continue;
>+
> 		/* Acquire a page (pool / system) for this order. */
> 		ttm_pool_iter_acquire_page(&it);
> 		if (!it.p) {
> 			r = ttm_pool_iter_lower_order(&it);
>-			if (r)
>+			if (r < 0)
> 				goto error_free_all;
>-			continue;
>+			if (r == TTM_POOL_ITER_RETRY)
>+				continue;
>+			break;	/* TTM_POOL_ITER_STOP */
> 		}
>
> 		r = ttm_pool_page_allocated(pool, it.order, it.p,
>@@ -951,6 +1154,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 			if (r)
> 				goto error_free_all;
> 		}
>+
>+		it.alloc_count++;
> 	}
>
> 	r = ttm_pool_apply_caching(alloc);
>@@ -969,6 +1174,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	if (tt->restore)
> 		return r;
>
>+	/*
>+	 * Drop any pages borrowed from the old tt during a defrag move: they are
>+	 * still owned by the old tt and must not be freed here.
>+	 */
>+	ttm_tt_defrag_disown_borrowed(tt, it.defrag_old_tt);
>+
> 	caching_divide = alloc->caching_divide - tt->pages;
> 	ttm_pool_free_range(pool, tt, tt->caching, 0, caching_divide);
> 	ttm_pool_free_range(pool, tt, ttm_cached, caching_divide,
>diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
>index b645a1818184..2388ff794a59 100644
>--- a/drivers/gpu/drm/ttm/ttm_tt.c
>+++ b/drivers/gpu/drm/ttm/ttm_tt.c
>@@ -450,6 +450,73 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
> }
> EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_unpopulate);
>
>+/**
>+ * ttm_tt_defrag_disown_borrowed() - Drop borrowed defrag pages from a tt
>+ * @tt: The tt to drop the borrowed page references from.
>+ * @src: The tt the pages may have been harvested from, or NULL.
>+ *
>+ * During a defragmentation move the freshly (re)allocated tt may harvest
>+ * already beneficial-order chunks from the BO's old tt, sharing the underlying
>+ * pages instead of reallocating them. Until the move commits these pages stay
>+ * owned by the old tt. Clearing a tt's slots for every page it shares with
>+ * @src (the same struct page at the same index) makes that tt's teardown leave
>+ * the shared pages alone, so they are freed exactly once by their owner.
>+ *
>+ * This is used both to unwind a failed defrag move (disown the borrowed pages
>+ * from the new tt, leaving the old tt intact) and to commit a successful one
>+ * (disown the now-transferred pages from the old tt, leaving them owned by the
>+ * new tt).
>+ */
>+void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src)
>+{
>+	pgoff_t i = 0, run_start = 0;
>+	bool in_run = false;
>+
>+	if (!tt || !src)
>+		return;
>+
>+	/*
>+	 * Borrowing happens at chunk granularity: a borrowed chunk shares the
>+	 * same struct page on both tts across its whole allocation order, while
>+	 * a non-borrowed chunk differs across its whole order. Stride by @src's
>+	 * chunk order instead of walking every page, coalescing the borrowed
>+	 * (matching) chunks into runs and clearing each run with a single
>+	 * memset rather than a per-page store. @src is a fully populated,
>+	 * non-dma_alloc tt (the defrag path), so its page order is recorded in
>+	 * page->private and read via ttm_pool_page_order_nodma().
>+	 */
>+	while (i < tt->num_pages) {
>+		struct page *sp = src->pages[i];
>+		unsigned int order = sp ? ttm_pool_page_order_nodma(sp) : 0;

Here ttm_pool_page_order_nodma() is used where as in harvest funciton,
ttm_pool_page_order() is used. Though it doesn't matter to Xe, this asymmetry
makes it bit confusing.

Niranjana

>+		pgoff_t nr = 1UL << order;
>+
>+		if (sp && tt->pages[i] == sp) {
>+			if (!in_run) {
>+				run_start = i;
>+				in_run = true;
>+			}
>+		} else if (in_run) {
>+			memset(&tt->pages[run_start], 0,
>+			       (i - run_start) * sizeof(*tt->pages));
>+			if (tt->dma_address)
>+				memset(&tt->dma_address[run_start], 0,
>+				       (i - run_start) *
>+				       sizeof(*tt->dma_address));
>+			in_run = false;
>+		}
>+
>+		i += nr;
>+	}
>+
>+	if (in_run) {
>+		memset(&tt->pages[run_start], 0,
>+		       (i - run_start) * sizeof(*tt->pages));
>+		if (tt->dma_address)
>+			memset(&tt->dma_address[run_start], 0,
>+			       (i - run_start) * sizeof(*tt->dma_address));
>+	}
>+}
>+
> #ifdef CONFIG_DEBUG_FS
>
> /* Test the shrinker functions and dump the result */
>diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>index f4f8a8c29f04..fcaba5fb8bf7 100644
>--- a/include/drm/ttm/ttm_bo.h
>+++ b/include/drm/ttm/ttm_bo.h
>@@ -211,6 +211,18 @@ struct ttm_operation_ctx {
> 	 * order.
> 	 */
> 	bool defrag;
>+	/**
>+	 * @defrag_old_tt: During a defragmentation move, the bo's existing
>+	 * (populated) tt that is being relocated. The page allocator may
>+	 * harvest already beneficial-order chunks from this tt to back the new
>+	 * tt instead of reallocating them, avoiding alloc/free churn for large
>+	 * buffers. Harvested pages are only borrowed: they stay owned by
>+	 * @defrag_old_tt until the move commits, at which point
>+	 * ttm_tt_defrag_disown_borrowed() clears the old tt's slots for the
>+	 * transferred pages so they are not freed when the old tt is torn down.
>+	 * NULL for non-defrag operations.
>+	 */
>+	struct ttm_tt *defrag_old_tt;
> 	/**
> 	 * @resv: Reservation object to be used together with
> 	 * @allow_res_evict.
>diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
>index ce7533677d77..55c35bcf134d 100644
>--- a/include/drm/ttm/ttm_tt.h
>+++ b/include/drm/ttm/ttm_tt.h
>@@ -284,6 +284,8 @@ int ttm_tt_populate(struct ttm_device *bdev, struct ttm_tt *ttm,
>  */
> void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm);
>
>+void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src);
>+
> /**
>  * ttm_tt_mark_for_clear - Mark pages for clearing on populate.
>  *
>-- 
>2.34.1
>
