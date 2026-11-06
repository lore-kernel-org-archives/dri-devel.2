Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CE606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nMYLoQYm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E1E10E084;
	Fri,  6 Nov 2026 02:56:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E1810E033;
 Fri,  6 Nov 2026 02:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793933764; x=1825469764;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=W6qUXRrxmEKGw0PuAzkKDT79uUPzFejZt1AHE0FskiM=;
 b=nMYLoQYmsg2BHWkGZqAUUG8BoD96sr/hxOj9COaMKZyYD57XrxUposwq
 248XWuT7Ao14Ne3582tp+W2ll1rQIEZBpAiMVC7gjKJmUtku9jopwum32
 20BKQqJydJ9kPqi/ZahqOx+4Yy0y5Qe/FiKQaE+HhY15opuP9XOG6Xi7h
 MeuGmjQiPW9baJlm7r5mg0sAJyiFEx7437Mr7/FxecPT5WrxDzmk/9heN
 azqIjdF+ppyWCvIIh7WRKuN4ROgY5zr9YVmUE1+lHHMFrydNMZJccsIEk
 JZMAAYZWro6NgoqOioDEqv5W1147FIwQuQ9Nhkbf06WJUqm8PCVt5nUeL A==;
X-CSE-ConnectionGUID: IW1VaFfGQOODkbsuIEsq0A==
X-CSE-MsgGUID: 7XBHqLCwTq6tlsQDLoE9Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2743568"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2743568"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:56:04 -0800
X-CSE-ConnectionGUID: iIm1v/eoSt+k43CTGwdjTw==
X-CSE-MsgGUID: eZGOcZOiSfONEhN6Cvm4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9046394"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:56:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:56:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:56:03 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:56:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPXnJAZtnaNwy+1jiDuBoNQ+Pjx7Yh2TbVKo7DeE+FdNx3xNJv+1qtqAfArEh4z9iYGbFxVBR6b5elUSWbzxWX4Nrnlxt2OoDDrhSU1h9WcgryoByHP9DlEL/s6paYmS/i5HfaNST5sFnHRam+MxC4SQe5vcejTK6FoQbU+SmSCaF91lxvqe4OC7XWudnAb4Q8RBErKXFR58UW6JIjKzot4qPibrsj2Lw3HOV4AsA1jjHYtyLY4IQLiwnSdTazYhw9i4K67IjGOhRCXK23A82NWXbplhHri3d2BrYy0HJ6AMe2Jbv4AKs2CA5HVnn+sgl9xwbnOgl4GLzvI691wR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u09mEVqDdBdUw+WB7txZp8QRnx4F72vjDv3ExgPffw=;
 b=FPM8pnifeh+WepB6P4fXGXp4M0ilSo/L8vajmz9diq8w4ToSkjQ86bQq+syN2Rh4gEBwDvMdYntQaXbl9QW6kej1ZayTMAayzdaIhd0KquiYxNVoCLGr4zNa1cfL+obwPPyjJveqpJvKenN/APTXJlCtZqqa2ffi8YdIAWlGkBkQ3qV2nB+wWkAuit2AeuoImtaDrvKyI2OAJHlO14cKMqCv0rXpQbg2YMuxvvMbYBDMJdflCbUiU80mR/Z6AR5LbieW954U1H0XC1AqZmsQzoYlGrTdSltaH7Qlab50JA5xaWp2lIY5S5a+OlG20nytvvhP4ww/3u/PMFwwcA4C0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by LV2PR11MB375110.namprd11.prod.outlook.com (2603:10b6:408:3a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:55:57 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 02:55:57 +0000
Date: Thu, 5 Nov 2026 18:55:55 -0800
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
Subject: Re: [PATCH v3 01/33] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
Message-ID: <au1Bu_sIxwAzxJkc@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-2-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-2-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|LV2PR11MB375110:EE_
X-MS-Office365-Filtering-Correlation-Id: edf7fb2c-24d1-4ef5-1aee-08df3bb17b3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261009220027099003|261028144727099003|261021123027099003|261009221727099003|261102123227099003|261021121427099003|261009223327099003|261022105027099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: LnrOIQD0cC1kz946oTVm2iweq7UJ+wlRQCVT8Y821E2UPSGG5z3N2az/cfL4b+LSiKKEM+97GQpvByzF0U1iSLVvlQFlPmiZzLZFPZF0/0dOGEVtyjKT8TghiYFegD0UUoDrgUchyqr/Nv465tw+E7jR9oEqmNFXqHCoGtzs7F4MWPPpu//BaAWuZvpZL3Ks9VC4Pp3XPVPXM4Pt4tkQ4oR6DgZ1IKat+Ttfb65nizhnajx2B4A285w63o3VkBQIxEYLm9zX6CaBBOk5bN496Se6VAOjz4exYS/1x8mA7ZYSmTHnvPrNDbEJ/sYVzDML6J+10f9yvVur5iBg5VjMIPX6qogjupiZ91MlOwTb6BNwMUlQ01QsLeG7yf3ahwOtfLpdDuRYuZLRAmp6GwfVTX8jUeUBB0j04e5i3ftIdXIbtxouv/UYEtDkLsf92s/apTAxZzyAOzflTWRSxTIhovswhqomQnEKz56RZDDu9U0ehEN259kw7JMUOpq+GhgffGj+5p6pkrBgHVodwpEvMMgqk88Y6lqz90G+TX37QHy/ahzAhCpYa7KKvPM/xqzLn/Ni0S5ReCPvJAYfysTlxHk8+DGcHcjLNVfDHXkKz8NFUpHTE0uid/w2FckXCEZuWzH6teN7e0gHTjaL5FHfMBk+4znViN/jEOb8QBEI4fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261009220027099003)(261028144727099003)(261021123027099003)(261009221727099003)(261102123227099003)(261021121427099003)(261009223327099003)(261022105027099003)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?llWe0IhXMZz4Ps9FrXkByVdRnkymqtpuyrXoK/6zTV5Bjqb5C6ygSvuQtY?=
 =?iso-8859-1?Q?xKUwRidiGU/JvTXXNM53woqdd8EXs8cq5zWnWcqNHAvENy6qRZ/rYwbBYU?=
 =?iso-8859-1?Q?0dUdIRJfe1OnWp5hURa6llm/ACcEzDMRweXW7pRVT6S980KqISTQWjeZld?=
 =?iso-8859-1?Q?ZAEcrSF8Zhf12W9ziuIZMiQuY5xP4zofbQGuCW7X+8ZvRV84a7GeMepsg0?=
 =?iso-8859-1?Q?Et5uS5BkK8+nQVtX0gW7HIwrv582zLuZtRmr4E2OmLloBmTQSykuww2xdd?=
 =?iso-8859-1?Q?TVslMSjjCbGkveSosRa8YD6LvRZ/i5azO6dt+0DSI9aewqJAOWmBwxIpii?=
 =?iso-8859-1?Q?DhNAqoX9Yw00P27kdan6c4GrwA1GPZu9jqajCQ0zwgTZTVat9huehvjlFl?=
 =?iso-8859-1?Q?e0NhPQREfxG5YcEUczeyfM4EodgNhHIq9EviSMLr+nHfCmA8Q3n+DnUC8C?=
 =?iso-8859-1?Q?Wn4VrHfnLpFxH4NT/Mr6OaAUXfvop3IZ6t1wCAIQf2C219BCefk8vWBejR?=
 =?iso-8859-1?Q?wrFK05PFLQcL5lC6BD2U9lROtZ6K8xACZ+PU02NgUF6OnRAObwvfEwwmuw?=
 =?iso-8859-1?Q?v7STaDnXBecPUJvovwWqu5h4XBEwBsyngP+N2XWuxIICpg/FQ6dqrAW4P5?=
 =?iso-8859-1?Q?mYDndzc50kv7fTlU8taj/SsWqDps9vEdkPnACbUSzLF3H3UiWPBTVXJjVs?=
 =?iso-8859-1?Q?/MeuUpIObT10xizt2DuqKZ95MDviexfTtmpThpl0uHGAjBXoD+/fbz2Y6I?=
 =?iso-8859-1?Q?HYqgv4m76VwCFGKxxyBgIooBR4gnNqKZZe9lyCELnTo3ZytNJDyIipEmHD?=
 =?iso-8859-1?Q?aVT5s52KWPCQsGtxM7i/PswXTKfpWfv1pSbuwiHLd3SVjI79uUKdQYSHnA?=
 =?iso-8859-1?Q?FCOSMlixM9mv1sYoYCJX/QorDbycEcx7asOXeYVuML219a+Hjt4bf2wOfE?=
 =?iso-8859-1?Q?gPNpwjoiOR1Us5z26yYIH9G9Y1eyjfqye7Vl1ogYMiJzsdHnAO5KYWxoXW?=
 =?iso-8859-1?Q?QJp/J3ke8CT8+aZjSu0xPARE4G14vKuba7tm5t8BNELCUkWZcuNiJNi8B+?=
 =?iso-8859-1?Q?Pgagv/DvRpHT/0G/HqKk77ZBa+3r4jtUlXUFdrEkPpIWQV2dBBqyFgLTBH?=
 =?iso-8859-1?Q?mEZILhNQzYWkV6O0GeBnfE8axknLC268TFKHIz0JBlZSkS2Bq6Ix9SlV35?=
 =?iso-8859-1?Q?Q4THLIvUJhO3XFsSkdjuLUdpQYoE0QXZ28Dd4gFO+1Dy+Pp1tPoFZAUQa8?=
 =?iso-8859-1?Q?nFnDJPit3j9e87aRCabsdJ9x54mWjKIUavkFVwoq9q6medFCIIrjq2M4X/?=
 =?iso-8859-1?Q?wUr8g5RKWUG4YVresCGAGfOVCREON6Ay3yCZYvFfjh8QG/jrawiHzknEt0?=
 =?iso-8859-1?Q?mpm0RHqqxuwKWxPA6I15YTnw/Evqs/lnGCF5C6UG/78VikjiFMxT7t7S7D?=
 =?iso-8859-1?Q?IJ/ClzbVwSoZFTbZKaL8MaGfr4ljyHXXoMYUpfSeWQJmS0xc3nrmteWeOb?=
 =?iso-8859-1?Q?8rabAQ3+yGEotwxuUtLanYAaMIMg2KibHFtf4N2lisk6vaflyEmyU+VPmn?=
 =?iso-8859-1?Q?pqG3BNbuxlMVjgo9SLc2gUqLyrW8boBfgoFQeTjT3z3+r9yUNRRweIoQZ/?=
 =?iso-8859-1?Q?of1SXrqKdz/lY4lB3+esaiaX0jvR75mF3qRjoEJaeTgNX22MAQw3kQHlq/?=
 =?iso-8859-1?Q?7ZUaK8UuaETZB+pMjU+c9b0V5RwJRwwaHEryr+jTTMlxqrHz7GsCXbQZVR?=
 =?iso-8859-1?Q?9S7BkWjOtMgpn+bvnxXHeuwllJBhYdNHyvaSSYcTLRcsZHga9OJrQhp/SE?=
 =?iso-8859-1?Q?zXIfC0FtPlnOn1DWySqYJms/4XAIhY95/xtaO4iYtOATsuFhsF49?=
X-Exchange-RoutingPolicyChecked: XCcNg3Y8qSZr6ft515ky1qn4RJ1yIAOlzKaPuMgXVOwHXcuAW4bvHBAYHjpqbaxzbnoXt7VkcBQN5jXYrNIGJv3GflsgaNSRFvbUrhI+GPOmRlelfcIzsW/mC0LtQFCkGWb+DO6T019uhg+6n2iBLFGyyMb6IRbWL3Ew+TR2ICnG2wo/HALuIgyD5YMq3BxONR7QVZtc1aMEQdYSxuBve9MY3rn1B7LDc5B602dNp+T9AfWHzTAiYPgYXbeK4zP399PeA8h+1vgtylAE+m6zwZjmuzoCrKrJ3lWQMXucD/RF289uJTdeKgOnmR+x4LHnGGbUscd6zhG4AQozKgf6Jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: edf7fb2c-24d1-4ef5-1aee-08df3bb17b3a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:55:57.3957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz4U0A0zYP2hNPMnR0cniDcmo8lh6sqJT7Yv8mAPUkvDH5Vf/5cOktO+FmPU2eEMFIoii3SAYurpOH52O21T6N+ouha/VU0YiN6xuCWp2b2PwNRJRQRpB8RBulT4q64g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB375110
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

On Fri, Jul 10, 2026 at 07:55:47PM -0700, Matthew Brost wrote:
>Allocating at the pool's beneficial order normally uses
>__GFP_RETRY_MAYFAIL to push hard for a contiguous high-order page. When
>beneficial-order allocations have recently been failing, this retry just
>burns CPU cycles in reclaim/compaction before falling back to a smaller
>order anyway.
>
>Add a beneficial_reclaim_backoff flag to struct ttm_operation_ctx and
>plumb it through to ttm_pool_alloc_page(). When set, the beneficial
>order is treated like the orders we already consider not worth stalling
>for: __GFP_RECLAIM is cleared so the allocation skips reclaim/compaction
>entirely, and the __GFP_NORETRY clearing / __GFP_RETRY_MAYFAIL promotion
>is skipped. Together this makes the allocator back off quickly to a
>smaller order instead of stalling.
>
>This is a no-op until a caller opts in.
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
> - Require a valid beneficial order before backing off reclaim in
>   ttm_pool_alloc_page() (Sashiko)

LGTM, though I need to take a deeper look at the patches that use this flag.

Niranjana

>---
> drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++----
> include/drm/ttm/ttm_bo.h       |  7 +++++++
> 2 files changed, 15 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index 3d5f2ae0a456..ab242ad4339e 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -145,7 +145,8 @@ static int ttm_pool_nid(struct ttm_pool *pool)
>
> /* Allocate pages of size 1 << order with the given gfp_flags */
> static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>-					unsigned int order)
>+					unsigned int order,
>+					bool beneficial_reclaim_backoff)
> {
> 	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
>@@ -165,10 +166,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> 	 * Do not add latency to the allocation path for allocations orders
> 	 * device tolds us do not bring them additional performance gains.
> 	 */
>-	if (order && beneficial_order && order != beneficial_order)
>+	if (order && beneficial_order &&
>+	    (beneficial_reclaim_backoff || order != beneficial_order))
> 		gfp_flags &= ~__GFP_RECLAIM;
>
>-	if (beneficial_order && order == beneficial_order) {
>+	if (!beneficial_reclaim_backoff &&
>+	    beneficial_order && order == beneficial_order) {
> 		gfp_flags &= ~__GFP_NORETRY;
> 		gfp_flags |= __GFP_RETRY_MAYFAIL;
> 	}
>@@ -814,7 +817,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		if (!p) {
> 			page_caching = ttm_cached;
> 			allow_pools = false;
>-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
>+			p = ttm_pool_alloc_page(pool, gfp_flags, order,
>+						ctx->beneficial_reclaim_backoff);
> 		}
> 		/* If that fails, lower the order if possible and retry. */
> 		if (!p) {
>diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>index 8310bc3d55f9..fd814b5cf535 100644
>--- a/include/drm/ttm/ttm_bo.h
>+++ b/include/drm/ttm/ttm_bo.h
>@@ -187,6 +187,13 @@ struct ttm_operation_ctx {
> 	 * when multiple BOs share the same reservation object @resv.
> 	 */
> 	bool allow_res_evict;
>+	/**
>+	 * @beneficial_reclaim_backoff: Back off from direct reclaim at the
>+	 * pool's beneficial order. Useful when beneficial-order allocation has
>+	 * recently been failing, to avoid burning CPU cycles in
>+	 * reclaim/compaction before falling back to a smaller order anyway.
>+	 */
>+	bool beneficial_reclaim_backoff;
> 	/**
> 	 * @resv: Reservation object to be used together with
> 	 * @allow_res_evict.
>-- 
>2.34.1
>
