Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD49606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lACX3/AD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=EtG/+JqW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA7C10F116;
	Fri, 20 Nov 2026 06:03:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE12210FFD2;
 Fri, 20 Nov 2026 06:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795154587; x=1826690587;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=WP+2Mlt7DfJRuY5wkXZfwB8rCNqAbrj37loIQMHiwPA=;
 b=lACX3/ADq0aYSmbDWSaM11n39Z2wUdXbwfqUrl0AHmlmHoeNJSELAh4m
 N9ZD4ppYM1HYNcUhlI6GVMdbXFhti50dlk7DnX60l74iavSvs0cehkRXE
 9ANIg4CuXJClELFj3kki62urAKSzusEC0fkStiibc397mwEVQSY2idSQS
 Ryo+hSwBLPJy0BXIZk8i+kZFo4MR9RAhfjghkvNOeQ8x2mVIWX28PP/LR
 sJB2ddZ1/BapEYIft67+8C1KEjY1NzqKlDdMWksxhDyRAUo0AlQNrcpqx
 MCVAxsFBgGrcYkUrlOfUelJT1s8c8tqoFimpRQXBducfjAyo8qXo/ndUU A==;
X-CSE-ConnectionGUID: cybdwN6IRZGDr81abpTBNg==
X-CSE-MsgGUID: sUne8oVLSqmJogXZkcDjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3940687"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3940687"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 22:03:06 -0800
X-CSE-ConnectionGUID: feVwbzE6ThyZnQMVggXklQ==
X-CSE-MsgGUID: YpKklO4ZRKOSdh0GScBgLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10972105"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 22:03:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:03:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 22:03:04 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:03:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK09vNRdAx8mscu8U5001KjhiXkkxaNKC2OjNmKgUlwl5FPnLBexB0+HaULUaTHMwQ5LwMdmu6vpc4kAZoEAwUouJX3cu9JYuwh5mf/eCAhVs4rkpQEREhnC9kSITEHjR3BSDRB5UcUCsJMQ+z0OU39dG1UeQSjz9xOby8IXfJDt99UjHpqPBcyasBgYqbJ1b8ALt3ERYVk+Fo1jrCPGDlKe+uHspArpEYtEMyQdMV77trps3uI+6c6CIjERI3oFae643/9sTBiiyXFphUY2T7+t21sbU2xOoXJFB598yScC0q3iDuebmYPcNzMHcEbssIR+DBQk7QEsUW9Gynb9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCDXlTskNmQePH9OIUvmWbbI0mXe+VrmDrYE2WQM1Pk=;
 b=QPhUmpkEh1tXWDariqUNgBvi0qBID95RCt5L/q0Q4JnnFGb3xPRiXaRdUfC7PeXR2qqgtqytyKLcr++bFykaAL6SqxOa3xWiJ/4gkXtOWF2vB36/LVSJBr3dQia7drbUkHebLcRerRdyHqGvvP1rQMW57cwDaN1oHMPv9fJ1occvdCH1Vj6xMqbZH+1J/bUqXtmnl25mVcjSS6scLBV1Z0jr6cnwaQMx0ovB3tCd6d9wQXwsgw1pttXioYAagHigTze8/T+00PV7WGRqRImtMoSO1ofLNYGwrnxEybBc8cucg9wCNUlu5lXCiXptLVVTdbITp3QU6gQatj7XI1nI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCDXlTskNmQePH9OIUvmWbbI0mXe+VrmDrYE2WQM1Pk=;
 b=EtG/+JqWqKp7RzqAJjY9q5rTZhUQLm6ILCdjrPRYMZkGLGwKMSNxbUlUsuQAW3inE5u2WKowlFDeiudjz793EmcFFiayRT4oOmVOkh4InzfuMSlu8XuR2k+v5z3vj0FMKnJmb5XCW5/vnd/UcOTFO6o6axAuaTGa8Vi/h/AubUM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH8PR11MB9533.namprd11.prod.outlook.com (2603:10b6:510:39f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:03:00 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 06:02:58 +0000
Date: Thu, 19 Nov 2026 22:02:56 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 15/33] drm/xe: Track BOs backed at a sub-optimal page
 order
Message-ID: <av/ikBSLnX7XpIlu@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-16-matthew.brost@intel.com>
 <au6tzuytWiqiqRUM@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au6tzuytWiqiqRUM@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH8PR11MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3b6a0f-765e-47c3-5854-08df46cbed7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|261009223027099003|261021121427099003|261102123227099003|56012099006|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: neujXqV6YPQQfFanrxpVJc/2OxYbNLwmtscBKp4cufnTbAICCiYz8bGtgB/bE8j6KjaqToqkP5+i2W6YtfRpTU6XtEXl9G9C4F2BhrRVO+FulAGrO56HfLFMGO0Ty2VXTgeC2jC20UseBgkXf6hVNey9/sZzr8CV+jnqf5xYHjGDwyLfaG5+qVq1jSDe7/R1qGymQmect0feOSXTBo97Y9Ztpk5R+kqqIVkKkDMT+4e731m++l0FQSi3ul/E1OGwfyEgwWPfUQBUVgbBSMwTRYoFoJhbjzye3yqcbse5XJyetw/ERUWd2ruNWYif9cOhUYkrMvA9EnvrBjtdjy/rmfa4F/12i5B0m8OKsmyS8IOXhWRiqfTEKBx+ZCfmsTnSnR07EYu6sYKXjtG2fqun+VpCHXfVTDioS+/ylGTYfc7cre/p/fbOuKJLJXzdskFzHijpJPL2DYdOEWbBWlKlR0PPOZLWUnxzjthM53PlzgLh+p1olAC/Os/Pm4Fpk3oI7b3IOJeDc29Kte0igZgbRMyKUntay3kEj+cZkAv7Atr7Kicu0/Dd70hKuXgsksCOIGCwLrVWk6dVBCptKcyP2/k0tElYlrRHRQLlW6L8qH4LXjJEu4w5nqMmjp0AIx1/tCpt1pysW4Xqxvxtn0d30jWSN/73Iu79e0eHxJDao+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CUhFW3TANQxafmwZxjismCwY3NAhYt7ESRw8lnl79k6d6Tj9GLnifn41HQ?=
 =?iso-8859-1?Q?41SJlq0ZvVKGQK56pyzuaoQgWt//P7wlYjnsp0jbIONu8A2Uj5cG148KFj?=
 =?iso-8859-1?Q?CfKSJaD3NAy8tOvl6Apx1ausgf/fMGYu0tZHWfeluJ9Zh6ZF8fJwVkzcdY?=
 =?iso-8859-1?Q?J1k7MSzRXeqepMJuPZRBpw4S70QiKA3F4fxCtThtKb31sRFI/VMYyYE8mM?=
 =?iso-8859-1?Q?RD95sndKlb7xx7TUTubthoYTaAQrtEnLfIxuWfNIcgwJgVdAYF7/ISkQsm?=
 =?iso-8859-1?Q?UjrZuANCgok0bouFwrT6HW4rwa8clpZfr27hFiHwYIHzeMTas6db/hXzrM?=
 =?iso-8859-1?Q?ZsaImysjt7mHW6Xo318Jrseh7Zs3OHXowR1b26D9jQYXyc5TOIQofN2QPy?=
 =?iso-8859-1?Q?25Ip9gM8wow5e5OcG3v+hxkH4uw1xoh5vEV//GgdAjDHO41hadNi1SQJLr?=
 =?iso-8859-1?Q?OzpTQ/uwIwGsPnKu+XPMBzMVib34GYNdFvsZrOWLyfz8+BRercTbyMQwFa?=
 =?iso-8859-1?Q?jVZ3OKh0TzpcfK/obzyqmDGCxxZYHvudu0ICnPRSkSlCoGz+89QmFKLkL5?=
 =?iso-8859-1?Q?7QMvP7VdIf8mwl0mYgzMB5fho0cWZHlqZkhVSEpERGAaiXrVofKfKZ06EJ?=
 =?iso-8859-1?Q?RrCmD1PD/y91fepkNL4SfU9zco9jb+gnX43Z45AeXq8NYzGUw0qKUp4jZD?=
 =?iso-8859-1?Q?wIKp50M8YR9S3oon5Nc90cDOv5AlMVLKWToH4bWr/xeN4AGi9IaSwOZnk8?=
 =?iso-8859-1?Q?a5AdYYCokfbqOqfWIYUyS/Zb630eLXZeEGi0ek6CnGqzOeNWNlwW5F/b95?=
 =?iso-8859-1?Q?evoiiYRk1i/NF01lUuVvyWLhuOguTlejQpzVy4UcDPv4c8QTLWrc7nsagU?=
 =?iso-8859-1?Q?Jk5E2CyVdZxDDxx7NA2te46oBbJ3t85PhTFAKU5simS3Xsz/h8rVJ3P+hT?=
 =?iso-8859-1?Q?1wT+2m2x66IHd0vj6+6eoBCk1fbB1iM2ZPjJwoJMHIFJFTPsXonKpfM1D7?=
 =?iso-8859-1?Q?s1UzdSmIKtKzpvJbcXls6UtzPa1jY5A2h/lCK4NiatVy1h4LjFXX9WX1qF?=
 =?iso-8859-1?Q?DsoPaTV4CzlRfob8TUGFUzN3v/yyXoIvV7cTMVoPU4AXBGISOX3ndhpQVz?=
 =?iso-8859-1?Q?yOONUMgCCm7FxQyWXJEaMx/+8ZiueQ0mbRDeOJASEwD5w5EUdEuALg8Fjh?=
 =?iso-8859-1?Q?2dXn8SLZcMX2E81VDy4e+GTkCou9+rLtOYsa3yiZwdN+UGpcWP9c5pGAb5?=
 =?iso-8859-1?Q?QKsxzUekACsbdNhgjKsyO0WnIpM7YnJye5vE6LPnujD6YGW9XJIEdhtYId?=
 =?iso-8859-1?Q?7CB+fxcJ2kw389KQkU6/uHw4y/MlmXItMEBaxTm2vUkkKo9JOqICY0gV3Q?=
 =?iso-8859-1?Q?fXiJN+IehOgvk3gYa83TBm2eP0YoEiwCGDi+VkzRDtd9UOIQQLnzZEdTjT?=
 =?iso-8859-1?Q?1FYo00g7NMlj7ECsXsNb6wVE626D7F+MPrZxPbLFSl7G2T/XtNHAUJSrXn?=
 =?iso-8859-1?Q?h9DONnMFb1zFMs38tw9Vmty6ps38tfBhupT0zSuhIn8srsUXisVUqmOMn7?=
 =?iso-8859-1?Q?LhVzJfTqmgV58JmNwsgR2rL3qDy6M6LSVKp7+C6FHABn5UCF+cKkzFuIsc?=
 =?iso-8859-1?Q?xGQ5QB4tYrx/KegwXBSYv6KxGv6RPkJSNdLPu2HLPF4zCV4MPLkuKfjQN1?=
 =?iso-8859-1?Q?KovOOKnoDyaIQ3HYssw6KrAx8qapuEcwzoPF2Q7lQ4ypNOtBBTrikoxKW5?=
 =?iso-8859-1?Q?cYX3s4nienjuzdPh89VYM5mIbAdTb6k42+NgVWScqDG6pm8sZm8tJ3ShV+?=
 =?iso-8859-1?Q?srVG428wHuCIh0TfkbLV9KxoSRg0dQA=3D?=
X-Exchange-RoutingPolicyChecked: YcYhQOc5Sw6CLAFJnEpVxeJ5oamyuTRR/BTas+zzL0EbGcrL+yR+62JYJVQkhSx8oWzhDkgaQ3u88b84O+ZVbqYgOETKDFQ3YiMcf6g6BygQ8IUJvmKuXeldzbZh61mL2z2ZWVsaXmNwYzYnrCLm4i09qb8nkKryfj5gef7+lqxINGwDcTSciKy7dQgWFFNrB0SxGkilgt1HVttZjES+guluw4p4DeqZFirNQvCNb+JfHbWGBGAz5ixN6/bi8o9eV8Ne9oi/3aUm9hM60L7BJaDtjudI1IK5N1Be1LMmmVduSpywcXvIsTRAPpgbrbcHr2ESw1mPtlW9qIn5scTKIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3b6a0f-765e-47c3-5854-08df46cbed7d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:02:58.8042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiuHu8RuMyAjyHj2IGIkS8mSQBTTsfaD9qPRrxoigR9lQtltJLPz5ygOBohG9KIWMw2bW8IDnfqqLjQtMv9f1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9533
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

On Fri, Nov 06, 2026 at 08:49:18PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:01PM -0700, Matthew Brost wrote:
> > Add per-device tracking of BOs whose backing TT pages were allocated
> > below the pool's beneficial order, as reported by the
> > TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag (read via
> > ttm_tt_is_beneficial_order_failed()). These BOs are future candidates for
> > a defragmentation pass that reallocates their pages at the beneficial
> > order.
> > 
> > Add a mem.defrag sub-struct (lock, list, atomic count) to struct
> > xe_device and a defrag_link to struct xe_bo, initialised at BO create
> > and device init. Membership is updated from xe_bo_move() via
> > xe_bo_defrag_update(): a BO is added when it is a populated, needed,
> > non-pinned ttm_bo_type_device object flagged
> > TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED, and removed otherwise. BOs are also
> > removed on pin, on purge, moved to dontneed, and at destroy.
> > 
> > Only ttm_bo_type_device BOs are tracked.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_bo.c           | 115 +++++++++++++++++++++++++++
> > drivers/gpu/drm/xe/xe_bo.h           |   1 +
> > drivers/gpu/drm/xe/xe_bo_types.h     |   6 ++
> > drivers/gpu/drm/xe/xe_device.c       |   2 +
> > drivers/gpu/drm/xe/xe_device_types.h |  19 +++++
> > 5 files changed, 143 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 4ee48cdc02ac..ff324caab6da 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -926,6 +926,9 @@ static void xe_bo_set_purgeable_shrinker(struct xe_bo *bo,
> > 	}
> > }
> > 
> > +static void xe_bo_defrag_update(struct xe_bo *bo);
> > +static void xe_bo_defrag_remove(struct xe_bo *bo);
> > +
> > /**
> >  * xe_bo_set_purgeable_state() - Set BO purgeable state with validation
> >  * @bo: Buffer object
> > @@ -954,6 +957,7 @@ void xe_bo_set_purgeable_state(struct xe_bo *bo,
> > 
> > 	bo->purgeable.state = new_state;
> > 	xe_bo_set_purgeable_shrinker(bo, new_state);
> > +	xe_bo_defrag_update(bo);
> > }
> > 
> > /**
> > @@ -1003,9 +1007,100 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
> > 	/* Commit the state transition only once invalidation was queued */
> > 	xe_bo_set_purgeable_state(bo, XE_MADV_PURGEABLE_PURGED);
> > 
> > +	/*
> > +	 * The backing store is gone, so the BO no longer needs defrag. Drop it
> > +	 * from the defrag list here so the count stays accurate even for purge
> > +	 * paths that don't pass through xe_bo_move() (e.g. swap_notify).
> > +	 */
> > +	xe_bo_defrag_remove(bo);
> > +
> > 	return 0;
> > }
> > 
> > +/**
> > + * xe_bo_defrag_init_early() - Initialize the device defrag BO tracking
> > + * @xe: The xe device
> > + *
> > + * Initialize the list, lock and count used to track BOs whose backing TT
> > + * pages were allocated at a sub-optimal order.
> > + */
> > +void xe_bo_defrag_init_early(struct xe_device *xe)
> > +{
> > +	spin_lock_init(&xe->mem.defrag.lock);
> > +	INIT_LIST_HEAD(&xe->mem.defrag.list);
> > +	atomic_set(&xe->mem.defrag.count, 0);
> > +}
> > +
> > +static bool xe_bo_needs_defrag(struct xe_bo *bo)
> > +{
> > +	struct ttm_buffer_object *ttm_bo = &bo->ttm;
> > +	struct ttm_tt *tt = ttm_bo->ttm;
> > +
> > +	xe_bo_assert_held(bo);
> > +
> > +	return ttm_bo->type == ttm_bo_type_device && tt &&
> > +		!xe_bo_madv_is_dontneed(bo) &&
> > +		ttm_tt_is_populated(tt) &&
> > +		ttm_tt_is_beneficial_order_failed(tt) &&
> > +		ttm_bo->resource && ttm_bo->resource->mem_type == XE_PL_TT &&
> > +		!xe_bo_is_pinned(bo);
> > +}
> > +
> > +static void xe_bo_defrag_add(struct xe_bo *bo)
> > +{
> > +	struct xe_device *xe = xe_bo_device(bo);
> > +
> > +	xe_bo_assert_held(bo);
> > +	xe_assert(xe, xe_bo_needs_defrag(bo));
> > +
> > +	scoped_guard(spinlock, &xe->mem.defrag.lock) {
> > +		if (list_empty(&bo->defrag_link)) {
> > +			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
> > +			atomic_inc(&xe->mem.defrag.count);
> > +		}
> > +	}
> > +}
> > +
> > +static void __xe_bo_defrag_remove(struct xe_bo *bo)
> > +{
> > +	struct xe_device *xe = xe_bo_device(bo);
> > +
> > +	guard(spinlock)(&xe->mem.defrag.lock);
> > +	if (!list_empty(&bo->defrag_link)) {
> > +		list_del_init(&bo->defrag_link);
> > +		atomic_dec(&xe->mem.defrag.count);
> > +	}
> > +}
> 
> Assisted-by: LLM
> 

Yes.

> NIT...probably worth adding a comment saying this version
> can be called without holding bo dma-resv lock?
> 

It should be self documenting with lockdep but can add this.

> > +
> > +static void xe_bo_defrag_remove(struct xe_bo *bo)
> > +{
> > +	xe_bo_assert_held(bo);
> > +
> > +	if (list_empty(&bo->defrag_link))
> > +		return;
> > +
> > +	__xe_bo_defrag_remove(bo);
> > +}
> > +
> > +/**
> > + * xe_bo_defrag_update() - Update defrag list membership for a BO
> > + * @bo: The buffer object
> > + *
> > + * Add @bo to the device defrag list when it is a ttm_bo_type_device BO resident
> > + * in XE_PL_TT with a populated TT whose pages were allocated at a sub-optimal
> > + * order (ttm_tt_is_beneficial_order_failed()) and it isn't pinned. Otherwise
> > + * ensure it is removed from the list.
> > + */
> > +static void xe_bo_defrag_update(struct xe_bo *bo)
> > +{
> > +	xe_bo_assert_held(bo);
> > +
> > +	if (xe_bo_needs_defrag(bo))
> > +		xe_bo_defrag_add(bo);
> > +	else
> > +		xe_bo_defrag_remove(bo);
> > +}
> > +
> > static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 		      struct ttm_operation_ctx *ctx,
> > 		      struct ttm_resource *new_mem,
> > @@ -1231,6 +1326,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 		xe_tt_unmap_sg(xe, ttm_bo->ttm);
> > 	}
> > 
> > +	xe_bo_defrag_update(bo);
> > +
> > 	return ret;
> > }
> > 
> > @@ -1267,6 +1364,15 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
> > 	if (lret > 0) {
> > 		xe_ttm_tt_account_subtract(xe, bo->ttm);
> > 		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
> > +
> > +		/*
> > +		 * The pages are gone, so a tracked BO no longer needs defrag.
> > +		 * This shrinker purge path frees pages without going through
> > +		 * xe_bo_move(), so drop any stale defrag list entry here. Ghost
> > +		 * bos are never tracked, so guard for real xe bos.
> > +		 */
> > +		if (xe_bo_is_xe_bo(bo))
> > +			xe_bo_defrag_remove(ttm_to_xe_bo(bo));
> > 	}
> > 
> > 	return lret;
> > @@ -1909,6 +2015,8 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
> > 		list_del(&bo->vram_userfault_link);
> > 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
> > 
> > +	__xe_bo_defrag_remove(bo);
> > +
> > 	kfree(bo);
> > }
> > 
> > @@ -2414,6 +2522,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
> > 	bo->ttm.base.funcs = &xe_gem_object_funcs;
> > 	bo->ttm.priority = XE_BO_PRIORITY_NORMAL;
> > 	INIT_LIST_HEAD(&bo->pinned_link);
> > +	INIT_LIST_HEAD(&bo->defrag_link);
> > #ifdef CONFIG_PROC_FS
> > 	INIT_LIST_HEAD(&bo->client_link);
> > #endif
> > @@ -3020,6 +3129,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
> > 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> > 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
> > 
> > +	xe_bo_defrag_remove(bo);
> > +
> > 	/*
> > 	 * FIXME: If we always use the reserve / unreserve functions for locking
> > 	 * we do not need this.
> > @@ -3078,6 +3189,8 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
> > 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> > 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
> > 
> > +	xe_bo_defrag_remove(bo);
> > +
> > 	/*
> > 	 * FIXME: If we always use the reserve / unreserve functions for locking
> > 	 * we do not need this.
> > @@ -3113,6 +3226,7 @@ void xe_bo_unpin_external(struct xe_bo *bo)
> > 	ttm_bo_unpin(&bo->ttm);
> > 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> > 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
> > +	xe_bo_defrag_update(bo);
> > 
> > 	/*
> > 	 * FIXME: If we always use the reserve / unreserve functions for locking
> > @@ -3145,6 +3259,7 @@ void xe_bo_unpin(struct xe_bo *bo)
> > 	ttm_bo_unpin(&bo->ttm);
> > 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> > 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
> > +	xe_bo_defrag_update(bo);
> > }
> 
> Looks like list update needs to be called from 2 other places,
> 
> 1. ttm_bo_populate() getting called from CPU fault path and from TTM fault
>    never calls xe_bo_defrag_update().

Yes. We also need to strip out reclaim flags in CPU fault path as this a
foreground op.

> 2. In xe_bo_shrink() if ttm_bo_shrink() returns >0 value. This will inflate
>    the defrag.count value.
> 

This routes through ttm_bo_validate which ends up in xe_bo_move so I
think this case is covered.

> > 
> > /**
> > diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> > index 6340317f7d2e..4186cb51af87 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > @@ -224,6 +224,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec);
> > int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
> > void xe_bo_unpin_external(struct xe_bo *bo);
> > void xe_bo_unpin(struct xe_bo *bo);
> > +void xe_bo_defrag_init_early(struct xe_device *xe);
> > int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
> > 		   struct drm_exec *exec);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
> > index fcc63ae3f455..9eea9ab380e5 100644
> > --- a/drivers/gpu/drm/xe/xe_bo_types.h
> > +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> > @@ -54,6 +54,12 @@ struct xe_bo {
> > 	struct ttm_bo_kmap_obj kmap;
> > 	/** @pinned_link: link to present / evicted list of pinned BO */
> > 	struct list_head pinned_link;
> > +	/**
> > +	 * @defrag_link: link into @xe_device.mem.defrag.list for BOs whose
> > +	 * backing TT pages were allocated at a sub-optimal order. Protected by
> > +	 * @xe_device.mem.defrag.lock.
> > +	 */
> > +	struct list_head defrag_link;
> > #ifdef CONFIG_PROC_FS
> > 	/**
> > 	 * @client: @xe_drm_client which created the bo
> > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> > index 97cc2d185e45..bb93425a5c70 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -607,6 +607,8 @@ int xe_device_init_early(struct xe_device *xe)
> > 	if (err)
> > 		return err;
> > 
> > +	xe_bo_defrag_init_early(xe);
> > +
> > 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
> > 						       WQ_MEM_RECLAIM);
> > 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> > index 95e7cea91cbf..9e6244d8f41b 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -296,6 +296,25 @@ struct xe_device {
> > 		 */
> > 		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
> > #endif
> > +		/**
> > +		 * @mem.defrag: Tracking of BOs whose backing TT pages were
> > +		 * allocated at a sub-optimal (smaller than beneficial) order.
> > +		 *
> > +		 * Such BOs are candidates for a future defragmentation pass that
> > +		 * tries to reallocate their pages at the device's beneficial
> > +		 * order. Only ttm_bo_type_device BOs are tracked.
> > +		 */
> > +		struct {
> > +			/** @mem.defrag.lock: Protects @mem.defrag.list. */
> > +			spinlock_t lock;
> > +			/** @mem.defrag.list: List of struct xe_bo defrag_link. */
> > +			struct list_head list;
> > +			/**
> > +			 * @mem.defrag.count: Number of BOs currently on
> > +			 * @mem.defrag.list.
> > +			 */
> > +			atomic_t count;
> 
> NIT...Not sure if we need it to be atomic. Count is only used in patch 16 and
> usage is approximation anyhow (doesn't guarantee anything as list lenght can
> be changing).

Right - incr / decr are protected by the spin lock along with the list.

I think count might actually be able to be dropped as target has slighly
moved - foreground just never does reclaim, thus
XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD / count isn't needed.

Matt

> 
> Niranjana
> 
> > +		} defrag;
> > 	} mem;
> > 
> > 	/** @sriov: device level virtualization data */
> > -- 
> > 2.34.1
> > 
