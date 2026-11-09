Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060C606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RoehDnAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7224110F00A;
	Mon,  9 Nov 2026 04:34:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5317710F009;
 Mon,  9 Nov 2026 04:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794198865; x=1825734865;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=a5yAsM2ArfnJ82919SOECnhUtIe1OwnTp2CXvDgUU60=;
 b=RoehDnAOdyPwjoGKVgcyVCFi9CaMbqfh1XtseY4UtH+1fsV/fRqe72Ws
 O+xHb+TKHllF+TYynnw8GGE0bkoz9wEWl4KWCpV4bZ+rZ8LyS9XtjB7hI
 g7zlxAsPlj8Xitg4udAJg39Es9xX50BCCKOdSei9VCA7TMYAr8o57N2fa
 YVnjtpCpOVOYlnwmANucA9JBHzFwo5OYqKOgNu1nLrDqT3wew6S9Aenc5
 ucgRnJHoRu1PExW1uf9/G0h2kJfu0r7Ed1ntE2fwzpJaSpOiMZvLknnIL
 RKz+5wOX89Ujd1VvtABQwtPnQa9n6agfJhSkeq+phcuthxWmgQo5O/DdA w==;
X-CSE-ConnectionGUID: sl4+waZoQWWoTxvqGExsQg==
X-CSE-MsgGUID: A+XuicR0R2SnxK0HcZNwtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2819574"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2819574"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 20:34:24 -0800
X-CSE-ConnectionGUID: DkoXC/0+Qfitg6bQnqp0Gg==
X-CSE-MsgGUID: cDMfWOS6TmGMVPkZi32fXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7940071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 20:34:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 20:34:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 8 Nov 2026 20:34:24 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 20:34:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtU8O0Crd9kDD2rDkwDnnNeJiptqRdnEK+PZ2wGCNbivoS/s/ITKpdoCqn+d5C6ElaslXT6wRseWD/EBRt2KtqeoG9xN1B5vFXeNZtXkXCnyN762YOzvZN9K7kZEXljKuEsKoFx/F2Aeb3CVYGv9t81jy4RjIAcH4+hxjNqhphBaLoEc4bbuUfD5fy8fLV3XNEm7c2+VZWo8LtBh4AJuepe66Pm1wv4+EcHglatcvdtfWDAroOIJLcBQ9jUK/eAY2NDG5NCZAT2sWS+8luSdzyVdSktENDSSNt7GK+mjHCLPNxrJ9KqrHNivgHE2cqu0EStg8ZzyWJZ79O1V4LZveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdXyFIBxuV087j5YzfqQlOqvfr+ZGSU5Wqne6ftSAxM=;
 b=kd0XYc+k7TFbgVm+O9N99tupVGo/gCbToq117wUcPM1o2h0y8U0C1r0i+vzCYlUWWfVLOPEuGXyZ2r9ssitnjdItiE3YU/KN7Fc5abvPpoWqscTTxgo0l4g6dJF+1VjoFj2z9EyZtu6wC3U2QgsJA5xNmX2Ccdn6twiKE+eYK0SbefejyWZw+K7D6okKlBVxef+J8XsQ/h4m5aX/SXDZCmAlLmX89GVYd/tNfzQPaqWIElFRO7uc5LPnckqJ3qAG/9Ct15zaHIClkNKjZGAtBM6pr3yeuq9LFTkfjobyKkF2SZ7RirfJOOUI0ANxUBq42BuhO01iRWDKfeKNuXnMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CH3PR11MB196721.namprd11.prod.outlook.com (2603:10b6:610:364::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 04:34:22 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 04:34:21 +0000
Date: Sun, 8 Nov 2026 20:34:18 -0800
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
Subject: Re: [PATCH v3 24/33] drm/xe: Add defrag profiling tracepoints
Message-ID: <avFNSl7oIffZTPi8@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-25-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-25-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CH3PR11MB196721:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f8099b-78aa-4446-6147-08df3e1ab9be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: HAC7MKkGngzdZn8p0I/DQL8Av3OD6DL/DIM5VZXVexYztpIDS2PwXFYo9X9Eqd+qkiQgj5rC/AUX/+pTSdPvg59KBO3gEDgqDr2X2APQLHKNWE2/EwGD6SB1na14fgR41CnrICqZK1xxNgALVpohQH/bgTc2pLwvbnHe3M9kWgLNFxrfi1H12pHl9ZzUQ3XZcn6vzZ8ll9x9qJ8Qqkmj7UpiLlvG8tYmSXQU5Z8/15no/Z6LfR4eW66mPzupnjf9JgsUGPFAX0LRgZufOoZ2DF57JrhB1Qul2UVFd0+4OWftBw72vGXsNTSl1e+vHjo8vaxOYcZFSbb5S+psyXsvfke9HbilfrU8IvLoVzuJI0ITkoOvd1DBSg1IsnqR/F096BTthVxAbTVlbwIATPX4CI5X1p03OnZTVy9kYQxJ9Phgfysffi/kdCXo0Y0ueV3LwVHuSXxKUkMYOdMtSYAPtjVV3jlY7aykv4Q2l2CjnyG7VsJlUB2U1DXb2w36Fk+qkmf829GgB2Y9i8GZanFj9FuGPHlZjBl8hn1CxycDRRkDpBNhXGeXzXunkJqLRJvjhXvFZadYDM0N3M6idxkOS3yf2bmf7TigrE6QwtNHibEYtMabRogPwBDunniEO0WWXNWKDRufz55A2zbTU8tJPaC3dFTf7gVs2N+u1ln6m6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BUI9UQGb1vbxtGObGd6okkjCbvLKusFqkqAaBBmZtC1vHrtWdbQN77mMph?=
 =?iso-8859-1?Q?bgNfTs24Uc98eONFHaPp81t3e+M9j7ecMThLrGljO/UkM7DbzmmdsX27o+?=
 =?iso-8859-1?Q?7il3LgwDWNhEM41jvYG3pQXgkeMhvsm1pka0QsLi/NolW6m6HN3l+2kc27?=
 =?iso-8859-1?Q?ylqAnKHtxZ4hUlazOTKaimv0VyATxTvNFNUbKwV8fuIQ8I6EB44LPhhxXg?=
 =?iso-8859-1?Q?jmi1WAXW5k6UXuw7NyA+oYwRF8ciNCTbvxIey7UFui6hIhllJDqPrtvi0C?=
 =?iso-8859-1?Q?1Fhqkqh9IzQJ4Zu5Ta+0rR3AGTpnEcauwDTOUumE1N5EOc+ZAnzDr9FBul?=
 =?iso-8859-1?Q?82b7Eze3Cw36UIcZmNQY+w+/VJZv0E61UYGNHpStHqAzDum0P4IoqZ04SU?=
 =?iso-8859-1?Q?ENYkQIvOO2PW1amDhrlPTUtetoDkZio4woAhAu5FGvgx+dkTxhezHjJ8na?=
 =?iso-8859-1?Q?tbzo1Wd6RMUCoRy0A5CEJpAjjHFPeQuSn/T+owde6VuCuLZrPy5KvEEzup?=
 =?iso-8859-1?Q?88bLSN+srh8Ohbkm/UC/movanEXxQEvE/AeVhIevIBWLYl6bOvM6aqXay8?=
 =?iso-8859-1?Q?Mzvc/nJuyI+VZ4R0t3ooHtDd2EQz3TZfqktMdYPjku1nAujfg4twmMZ5xV?=
 =?iso-8859-1?Q?DDsjCqHpDYx482a1mE3ILGf/TocoeuIlKVaMuanUed+gZEwG0teV8EaI1S?=
 =?iso-8859-1?Q?HHUosH7f+3AEJT0xAGR/G+4+99zwwFo1CilQ8MjubamR0pG539hIXDYjqz?=
 =?iso-8859-1?Q?OE9AwJihaVp8nh7iHCAsv7xs2Avs01h3zirBxJ+xzFyu/2xGgq3lFWywcP?=
 =?iso-8859-1?Q?DFbQcw89Ye8AZJCFbfENTW38SPPSBrU/vlk5n9dhYXWrcnImM6pThgSiNm?=
 =?iso-8859-1?Q?nIjp7ck/RW2ak4d9Tv7EAOOnIvjY4b4xSbWBh4cJXH60MT7rEeuvdT8y5b?=
 =?iso-8859-1?Q?lzCJSlqWuWXECuT5GcX672XpmETQyjjCiH7SLO/uxJv55i5baB1UCj1mY+?=
 =?iso-8859-1?Q?J5fuDmh6FbDNuuzBo4CtUL48vbwGt2XLD/UdTamIAIVtXgRx+z7xg6YU48?=
 =?iso-8859-1?Q?eUlGUs/B8UW7N++DYN9drZjSDKV9BRtsNtOgnnKuowwrZDsTcB3fWSWv3F?=
 =?iso-8859-1?Q?col9Xz3ofhcIjyfaYo6yeldb+8T/FRy2R5U1r0cXyCazGd169oYi0enKVm?=
 =?iso-8859-1?Q?C7rAq+tOM3EgvFFboKv/EwYkJFlV6bW2ClgSIpV0wkmd0SXfWCFpI1kcgX?=
 =?iso-8859-1?Q?s21M3PRHSV61NQfzYjtsMFCkfHM0CGC1WtbJQck6zMMyDCBBVghK+oVWJj?=
 =?iso-8859-1?Q?7NOKhxJGx1fc+MNs7VQHPKzl1OZoLqElnsDFtbbDYbHIHU/554XbR5/upN?=
 =?iso-8859-1?Q?zQO9yaphBVrldn4WouvMMVYg84JN39xHXzVCnl+aaUPivT3tQlYbxRpjiq?=
 =?iso-8859-1?Q?k5sYjGPBFfTjRKo/juKVnfypQ4uZQEnMZZuhJaDU9dIMi+53eSdabcYKus?=
 =?iso-8859-1?Q?p4skiYBgRGnwhBel2c0E0bZd+TJsvzjIQu3a35ZkpjCkdvK3VqZePWvu5Z?=
 =?iso-8859-1?Q?MzYqeFj7zZMfXwqPHwEa8+HwgLPBFFwZwItmAu76bevFnnLh3VX6zYH/mP?=
 =?iso-8859-1?Q?la4pW9ITVoDL4ON0b/NplkPyYTE6JVLFELTYb+Xv74n+6BMJE+jlU7bP5O?=
 =?iso-8859-1?Q?KlY0HV2NmRP5C9BI7d0kjNN76euBgVljVMQr76FwqLkbWEaRxs+4GXg7xB?=
 =?iso-8859-1?Q?auYzaiw4LCPs/oLQ/qKLS4TmkxvgBeJilKNR8nMjkp8hhWMo4nJgWSRidu?=
 =?iso-8859-1?Q?4KxhyYaN3HaYp6sNiQ7CxQGGldUgt3eWOWy6RuFrhWVmjtB4MIKD?=
X-Exchange-RoutingPolicyChecked: BtpcfFqVADn5jbJ9gPtwdG6FNM4a7HV25F+ZWdJj/t7/N1GXioK0gb9gFsYCd7NmSAuGaTLlMn/+At4iypC8QYeY+g+qAU+XrcUd9FnTGAYX7H5Ev/6an2gUGC8u1qodQRWp1zFSHYvWWH9CA/eBg2LVT2M9azSBcIUbqVPgs4FV8vFtXMmltaLaZJoqv7wF26GByaUmAupNom/pKj2uPgB/tEjwg+PBEK4WWedqXR+cemulzluclFb9M26NuHS/K13aCQLt+AnfRG/Iv8hFvB2y8uqWGtfd8xz84mwwkwP38TuexMxW4Vpbs86CfvtttWnCd1VXcXr/lJY5J1GzTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f8099b-78aa-4446-6147-08df3e1ab9be
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 04:34:21.7730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv71sKL+nHEqSSEu0q6ZnOxhjMelP25lF9UZ11xko3xr354MJxjOH7hipm3/FCkzoqQlkq+041HPikxVk+vm/tKF/2eSGsZlnBiAocW3lW49yQU9ye1fvRBE+v+52LCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB196721
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

On Fri, Jul 10, 2026 at 07:56:10PM -0700, Matthew Brost wrote:
>Add two tracepoints to profile the page defragmentation worker:
>
> - xe_bo_defrag_worker: emitted on worker entry and exit with the
>   current defrag list count and the bytes processed in the run.
> - xe_bo_defrag_one: emitted per BO with the run budget, the prealloc
>   fill ratio (got/want) and the lock-held, lock-wait and prealloc
>   durations, plus the bytes consumed and the result.
>
>These break down the cost of a defrag attempt into its locked vs
>unlocked phases, making it possible to confirm that the expensive
>beneficial-order allocation and cpu cache mode change happen outside
>the BO dma-resv lock and that the residual lock-held time is copy-bound
>(with the tail dominated by lock-wait behind active rendering).
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
> - Move the ns-to-us division into TP_fast_assign() to avoid a 64-bit
>   divide in TP_printk() (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c       | 18 +++++++++-
> drivers/gpu/drm/xe/xe_trace_bo.h | 59 ++++++++++++++++++++++++++++++++
> 2 files changed, 76 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 8b89d34f37d4..25e5b72f870c 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -1263,7 +1263,9 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> 	struct ttm_placement placement;
> 	struct ttm_place place;
> 	enum ttm_caching tt_caching;
>-	unsigned int order, want = 0;
>+	unsigned int order, want = 0, got = 0;
>+	u64 lock_ns = 0, prealloc_ns = 0, lockwait_ns = 0;
>+	ktime_t t0;
> 	int ret = 0;
>
> 	*consumed = 0;
>@@ -1294,6 +1296,7 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
>
> 	/* Phase 2: preallocate outside the lock; */
> 	if (want) {
>+		t0 = ktime_get();
> 		ret = ttm_pool_prealloc_fill(pool, tt_caching, &pp, want);
> 		if (ret || !pp.count) {
> 			ret = ret ?: -ENOMEM;
>@@ -1301,12 +1304,16 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> 					 XE_GT_STATS_ID_DEFRAG_FAILED_COUNT, 1);
> 			goto out_err;
> 		}
>+		prealloc_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
> 	}
>
> 	/*
> 	 * Phase 3: re-take the lock, re-check, and validate using the prealloc.
> 	 */
>+	t0 = ktime_get();
> 	xe_bo_lock(bo, false);
>+	lockwait_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
>+	t0 = ktime_get();

Here only phase 3 locking is profiled. What about phase 1 locking?

Niranjana

>
> 	if (!xe_bo_needs_defrag(bo)) {
> 		xe_bo_defrag_remove(bo);
>@@ -1362,9 +1369,13 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
>
> unlock:
> 	xe_bo_unlock(bo);
>+	lock_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
>+	got = pp.used;
> out_err:
> 	ttm_pool_prealloc_fini(pool, &pp);
> out:
>+	trace_xe_bo_defrag_one(bo, budget, want, got, lock_ns, prealloc_ns,
>+			       lockwait_ns, *consumed, ret);
> 	return ret;
> }
>
>@@ -1396,6 +1407,9 @@ static void xe_bo_defrag_worker(struct work_struct *w)
> 		return;
> 	}
>
>+	trace_xe_bo_defrag_worker(xe, 0, atomic_read(&xe->mem.defrag.count),
>+				  true);
>+
> 	/*
> 	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
> 	 * backing per run rather than draining the whole list in one go. Only
>@@ -1503,6 +1517,8 @@ static void xe_bo_defrag_worker(struct work_struct *w)
>
> 	xe_pm_runtime_put(xe);
> 	drm_dev_exit(idx);
>+	trace_xe_bo_defrag_worker(xe, defrag_bytes,
>+				  atomic_read(&xe->mem.defrag.count), false);
> }
>
> static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
>index 86323cf3be2c..b159d37d39a1 100644
>--- a/drivers/gpu/drm/xe/xe_trace_bo.h
>+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
>@@ -85,6 +85,65 @@ TRACE_EVENT(xe_bo_move,
> 		      __get_str(new_placement_name), __get_str(device_id))
> );
>
>+TRACE_EVENT(xe_bo_defrag_worker,
>+	    TP_PROTO(struct xe_device *xe, u64 defrag_bytes, int count,
>+		     bool enter),
>+	    TP_ARGS(xe, defrag_bytes, count, enter),
>+	    TP_STRUCT__entry(
>+		     __string(dev, dev_name(xe->drm.dev))
>+		     __field(u64, defrag_bytes)
>+		     __field(int, count)
>+		     __field(bool, enter)
>+		     ),
>+	    TP_fast_assign(
>+		   __assign_str(dev);
>+		   __entry->defrag_bytes = defrag_bytes;
>+		   __entry->count = count;
>+		   __entry->enter = enter;
>+		   ),
>+	    TP_printk("dev=%s %s defrag_bytes=%llu count=%d",
>+		      __get_str(dev), __entry->enter ? "enter" : "exit",
>+		      __entry->defrag_bytes, __entry->count)
>+);
>+
>+TRACE_EVENT(xe_bo_defrag_one,
>+	    TP_PROTO(struct xe_bo *bo, u64 budget, unsigned int prealloc_want,
>+		     unsigned int prealloc_got, u64 lock_ns, u64 prealloc_ns,
>+		     u64 lockwait_ns, u64 consumed, int ret),
>+	    TP_ARGS(bo, budget, prealloc_want, prealloc_got, lock_ns,
>+		    prealloc_ns, lockwait_ns, consumed, ret),
>+	    TP_STRUCT__entry(
>+		     __string(dev, __dev_name_bo(bo))
>+		     __field(size_t, size)
>+		     __field(u64, budget)
>+		     __field(unsigned int, prealloc_want)
>+		     __field(unsigned int, prealloc_got)
>+		     __field(u64, lock_us)
>+		     __field(u64, prealloc_us)
>+		     __field(u64, lockwait_us)
>+		     __field(u64, consumed)
>+		     __field(int, ret)
>+		     ),
>+	    TP_fast_assign(
>+		   __assign_str(dev);
>+		   __entry->size = xe_bo_size(bo);
>+		   __entry->budget = budget;
>+		   __entry->prealloc_want = prealloc_want;
>+		   __entry->prealloc_got = prealloc_got;
>+		   __entry->lock_us = div_u64(lock_ns, 1000);
>+		   __entry->prealloc_us = div_u64(prealloc_ns, 1000);
>+		   __entry->lockwait_us = div_u64(lockwait_ns, 1000);
>+		   __entry->consumed = consumed;
>+		   __entry->ret = ret;
>+		   ),
>+	    TP_printk("dev=%s size=%zu budget=%llu prealloc=%u/%u lock_us=%llu lockwait_us=%llu prealloc_us=%llu consumed=%llu ret=%d",
>+		      __get_str(dev), __entry->size, __entry->budget,
>+		      __entry->prealloc_got, __entry->prealloc_want,
>+		      __entry->lock_us, __entry->lockwait_us,
>+		      __entry->prealloc_us, __entry->consumed,
>+		      __entry->ret)
>+);
>+
> DECLARE_EVENT_CLASS(xe_vma,
> 		    TP_PROTO(struct xe_vma *vma),
> 		    TP_ARGS(vma),
>-- 
>2.34.1
>
