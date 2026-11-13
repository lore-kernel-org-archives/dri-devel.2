Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA0606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RuDBFskV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ATFAr99m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF1D510E6EE;
	Fri, 13 Nov 2026 06:33:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85DE10E449;
 Fri, 13 Nov 2026 06:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794551601; x=1826087601;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=JoBFPbTf+dfHzZg8mNW7jXRrhvCg3xnTJeWwSr6O3nM=;
 b=RuDBFskVqmU0nhIe2ulQO55PPWH0QCK8QjyXv9KaNUg4O1debn8v9m4n
 6jDixHWFrTesfzt+I6vQ4NLvuEqRn0J8zPiLqHPxg0x46P/kDlrN7VFrs
 dsy8ukCqt7jsztkhg4A2L60tqmIhQ3SZ5j0qi+U5z37tQVO/8zgnEqV3w
 2TEFV//2Cpj1f1orIhbVe93UT5lEtO6GIdcQUtXDfunpbnj0fD/K3eRyN
 92ceGqxPcz9aSpsQ0U6zdF5PHIHIm50dGCBf8BFZAb2uQkown3k85xr//
 MgJohQ0i51vpkDGYkjNrUt4tWVYPMxr4z/todC9n/eJ2Y3GwexQ30+cI/ Q==;
X-CSE-ConnectionGUID: REcX49uWTxSEu8l1SighiQ==
X-CSE-MsgGUID: Xy4n/ADTQkiF8/zZu5S2iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3243449"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3243449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 22:33:20 -0800
X-CSE-ConnectionGUID: P2/IQ7iHT56UFYRzOOoOZw==
X-CSE-MsgGUID: 6MxeBPBnTMCiS2rteuAWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9159501"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 22:33:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 22:33:19 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 22:33:19 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 22:33:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynqGX2xFSReXgwu6SY3TYVzyVSTRrHjHpiy2/SXfalAO0dW3pRHWxvAeCJsSMr59Jd0QFpSwfsWMWeLqCZ25LUgFC2XTFKcPQ2Hhx4Ykbp36uVwrXBKXZvN3mOGgTfxQLHIyXP7BnegKwBpiahsZhqpvHFVmYi/U53GuxthEgl7WHxPwTBZ5NJuuOZ/f7kil6wMoW0S1SGZ66OYSIz2fmTBpBmV7QEm60a4CHPAwF6iMpc88t02bncX8OmxwJSG+cmvS0/vAREuuxPw91/ZYrmp9jE/Vz0DPTptUwCwBJ0ETzSbwogSTd/REFZqC7knBpBzGPvU75sXZBbyi2HKAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MLIFnNOlsrjMqz436WaD/u+NDjwT3JlsRXk042dQMc=;
 b=p3DGqnrgyII1RmLhcwScVdlKyHYcqIpd78ri529/A+OboMpi40PVGZq/iHFozLCTbbwn9ivWIE02k0AoWWqhayP9nSPQyLwauor+23WXnPuDF+q7ms1wa+3nLphiVkkNsuzaRFbAeQF76h9WAWCko04L0mpct/BGXDpG8GhfO/yudcIeUrDRIOjXKCPpYri6pgg6/+DIKDaTjaavpERfD1MjIs3kq9orqOeNzzG7ruZw2l9gG9X+G5j5JvilsMKW/MRcleGJSCHk/B4OEyFpRI6m2swhzhdDbaK3aQ5A4tPwa1ncGtKkb76PdU9ROTMIZCCRsybQHdh/U15WkS9b3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MLIFnNOlsrjMqz436WaD/u+NDjwT3JlsRXk042dQMc=;
 b=ATFAr99ma+7K6RUBKU7T5n2Rk3uEvgSoeKgfQ3m5cDYHw5Zv69Dwu38UxMr8Hdf5HaWaGzc5sfyL1OfefAkSmFktqgrvAbL2a9zXeOrjlXq07VkC0OwPvgA36o53A1ljH70MSjxzy8c9j4E1k7UjxX9iTHh7f0FdQPiGJER6iAE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 06:28:14 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 06:28:14 +0000
Date: Thu, 12 Nov 2026 22:28:12 -0800
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
Subject: Re: [PATCH v3 28/33] drm/xe: Use IOVA-based DMA mapping for eligible
 tt BOs
Message-ID: <avat_NbhVqfLIyE7@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-29-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-29-matthew.brost@intel.com>
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CO1PR11MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: fbacd91d-aae5-43cf-4ed6-08df414f4bf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022113327099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Zv3gBwfAGULNA3MmEPpYSgm7CaqxJdcyO1CM7DLJLE9XtJRP5rwJuXvbeyxWPuaWnxjbOYslAkzywcQi8pOMDypb31GP/fmT2IuWNiuBh1ctg1a2dPraJpuOTYCSewd8jdBxH8ktGk9JwPCfsJejKN8qjzZwfPzemOr9aWbTvyjKNlXxqOCmjI/zITJ9zJe05oao1m1rvQSly7LIVojHWLEmFxYqPMjx8qt5O4BDSjeLeU+j0fHfkgeKXmdQXWphUPjq4rFj0Rztk+k6BQVyd7H1n58YZXnniZ9/Mvy9Nvp+leg3Mrl4sALv6o5v8uMwgSByODGkKNZWgN0r7QMEX8ije/WhF7koL61ongolaVGlt9qO176aFwz053yENQIzMU0RHuc7RadEacOFYk4G5SEaCJ8kUD7xIlGvDTzuN2zpQXNqeENDg4l6hBXf0fbqGggvEVFj46xTadEe9F2DVhiJLfa5Tu4FgT7SQkH6Mob8jEH1uol6eCPqhFK7Dg3Uzvp5ua5elardo0BmJKOj2nIW2TJ5IF+NQqSM9oT4WJAj1TjBKOKkjsV4jHrcrhpM6ikAP8AhOnVfHbwxYwYp184+dwLedKwOMrJRfQ+1SSFEvs8Kz2zxOMZ12PLoavpBEhc12smk4P2zqUik7SdvBtsQB7qRJnwQhCj34nHdaGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022113327099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Oxt6kebZvwfzYy0LkhG7/7v82mW08BRjwy5KVwifyKdb67gUFroWKq05D+?=
 =?iso-8859-1?Q?eM3vsRw4RYYUH4SmP0YODQY3rnKyGfI7uS0OU62gPO9iRa+RlSVV1AzlDm?=
 =?iso-8859-1?Q?DtLz3MHtqZ1rATBeNaJri8d1kIDxYB1Y5TEhZLrLgHh42hmnkP9DaKbrVJ?=
 =?iso-8859-1?Q?+g1BIRqCvuZHYD4K6VWDLl9NL+KL0hTnXESepBANJQRr+Z8Bs+sCwJi0bl?=
 =?iso-8859-1?Q?6JmPg7pKjYDkxVxf0RgT6m8snJn8F6pB5UHEB6WASIBB1qiIGDbNCugeGA?=
 =?iso-8859-1?Q?+BwnUVP2XjR13V+eM+RQr9ZFFltZlNp2yGRHBX9WoYgXfwheYQIQBRAtfp?=
 =?iso-8859-1?Q?1TuBHTwV2WlOkaFnBGYFV9avdbd5qsiNz5dwocKdB1uehNvHUt2Z9a1LU5?=
 =?iso-8859-1?Q?XmIw7Q9HsVR+JRq6UGaAHnL1eHigIfFZOmH+hYLuLhs5wxdBoggTUxEa+y?=
 =?iso-8859-1?Q?g2a1/QctQDu6MGNFWHlrZ3xJ3IY17iZKmEjhHvAUY9lFRplSkaLSu+9Q3K?=
 =?iso-8859-1?Q?BYfdXAujxAvDPB/HwkZ1Fh+zJrNBn1wShg5TYZ1AeymYXsBa77mi5RiAaX?=
 =?iso-8859-1?Q?9rLaep1oA7gN0PJWpYtk5QhQkDCvxUiM+MJZyP6ATVhBkTYt11E7tcdbQe?=
 =?iso-8859-1?Q?P+KLmHIG9zX8ZLHftBygxfzyF8HYxNSQ9V87F3tFV8+GG4Eb3qd4Z1tky2?=
 =?iso-8859-1?Q?LgU2/jrqaeICkrz4elpgRfofpbX+qpIcH9bvreTF3320eODpYTbPSZJWPa?=
 =?iso-8859-1?Q?3lUBRgqr8w1yb9aihvHa58ZDt4RGRT5XObzq/1g8YsPiJbl+9C6FTaAGA4?=
 =?iso-8859-1?Q?sRupD6Kr/QOmQQuaMD6kY4adi6wStDAmhIVjZsUy1G6AzN2QsgYNqDh7qu?=
 =?iso-8859-1?Q?rVmTOhWK9swxZZVE0+1w3IOTp5q9wALnPltstcDALLvwABF+zbKOWcIm6o?=
 =?iso-8859-1?Q?Q6caD0UgbV1vyBfUPhOasbMaCOGD6ffsKsF6yWwx8TIsZSRY7r7mpjo7lD?=
 =?iso-8859-1?Q?Q8I4K6XJOrlHsLiTnn7dfz2JmUrIjQd8b96BgaSr28LMbFwg04B5WUxO/F?=
 =?iso-8859-1?Q?NPn1NEHo4HzJXgp1OuQW7/12cGaF3E1/A9lvdEEAe8Hcetzo8bVx3jymzN?=
 =?iso-8859-1?Q?9EHhzrny+SVgj01+YQxdJVUrZnmsi7fzuCTU6v/89dVDdghPdPh83oZkPJ?=
 =?iso-8859-1?Q?gIKlfnQThXJ94ne4Hx+ileyzJyLk9EtkhdMmjbjiwyQztEfWB5ag7JyrTz?=
 =?iso-8859-1?Q?SxZM2LgBRgZTkA9MQa+FvskwYvvp4FA//oqiegeBh1CROGvogyn2aUZiuw?=
 =?iso-8859-1?Q?YRg8MHZkIFgyVgvnypM97rdr9ep9uNC67F87XItIswQTCYcpNAlrLQXkUa?=
 =?iso-8859-1?Q?jq+VLsOOIaJ1XBZXNlCf+94jj9Gid7hJdNCFwqdsbTYOGYEExvQ+ioK0iG?=
 =?iso-8859-1?Q?wY4LQi/IHfgpODLwmV0cSM7IZSwYMv45vdpoNii0it0vyQaTzASA6yXi9F?=
 =?iso-8859-1?Q?wjq8pNh7UmqltSJrq/rZ2siOrVnsfCdi6zDal0avitI0vqvDHM96SHONjU?=
 =?iso-8859-1?Q?9uedYIkh1OqaV2nfOkzXcPt8CX+WbY5D3+zuH6I5gjUSk8j7oYHcxA7VuL?=
 =?iso-8859-1?Q?fF8xjCppa6sK7bA4t8Ocym9JJHkx/Bqu7pdcGZokbetbCKoBzTNzQu4pdb?=
 =?iso-8859-1?Q?6zj8OVrcFVhwe+BAa1EDcXmQmashN14LZiyXn/HgLryUw+Wjlyo1XI4/rx?=
 =?iso-8859-1?Q?vzGnIOSudgdeLyUH5glK0HR2Ywd9mE26YjfSucfO67ABpU1iW+jDa8Bm+Z?=
 =?iso-8859-1?Q?llV3xsdFuaFmLHhNgfqPtT2iEnKaetKgraQqOMwa8CC4LSaTqyMT?=
X-Exchange-RoutingPolicyChecked: pWiz+McPJ3t1tkpdUTCAc/xyZMT0esUj7gSeSpu6Py9yFwThZKpzloZRIcibeN2W1A4ByxktzyG5qcwGvdf95yLQJcEqK9XE5hnfw0W0Rk3Yp8xxnQTEdUbCsdo1RtVKLHoSAXZy+uBlTbY+kxJJ7v7aI/sgyXVEgMQDJcgGQyOs+V9DmWR6/mfhdAFI2eIszOPaRT05s/tlbzYNhDKWjM+5/H+E3ZDcQS/7+3bZJ/ocBvzbFut9bBXfjzaMs8n3mC9KikZ2VI3R3Wvr/NuaQoKh27c0uePpdThiZ9B3AanAyILjmZorSuOJEAyIVw0cYUJevjC8KbVVPeqJ1ASHkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbacd91d-aae5-43cf-4ed6-08df414f4bf3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 06:28:14.3548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzcAVJvV34H+eE9BoTseyDaOC92vCIVUym+dfnl2hBxg/Sc6jBPocXXBriq+6QwdF7DYSf6cPaaKEFSVGgR41mCNeOg8neW274fsVhP6DRfyHjxgUxwgNQlr9aSO1Y8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
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

On Fri, Jul 10, 2026 at 07:56:14PM -0700, Matthew Brost wrote:
>Add support for mapping a ttm_tt's pages using the IOVA-based DMA API
>(dma_iova_try_alloc()/link()/sync()/unlink()/free()) as an alternative
>to the scatter-gather list. An IOVA mapping is a single contiguous DMA
>range, which is cheaper to walk and program than an sg list.
>
>Whether the IOVA API can be used depends on the IOMMU mode, so the
>decision is made once per tt at xe_ttm_tt_create() time and recorded in
>struct xe_ttm_tt::use_iova. To keep the scope limited, only device BOs
>that are not GGTT-mapped are eligible: dma-buf imports manage their own
>mapping and GGTT bindings are programmed directly from the sg list.
>dma_iova_try_alloc() may still fail, in which case the tt transparently
>falls back to the sg list, which remains the default.
>
>The IOVA reservation is allocated at tt creation and freed at tt
>destroy. xe_tt_map_iova() links the tt pages (coalescing physically
>contiguous runs) and syncs the IOTLB; xe_tt_unmap_iova() unlinks them
>but keeps the reservation so the tt can be remapped without
>re-allocating IOVA space. xe_tt_map()/xe_tt_unmap() dispatch between the
>IOVA and sg backends, and xe_bo_dma_unmap_pinned() learns about the IOVA
>case.
>
>Consumers that walked the sg list via xe_res_first_sg(xe_bo_sg()) now go
>through the new xe_res_first_tt() helper, which initializes either an
>IOVA cursor (xe_res_first_iova()) or an sg cursor depending on the tt's
>mapping mode.
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
> drivers/gpu/drm/xe/tests/xe_migrate.c |   6 +-
> drivers/gpu/drm/xe/xe_bo.c            | 239 ++++++++++++++++++++++++--
> drivers/gpu/drm/xe/xe_bo.h            |   5 +-
> drivers/gpu/drm/xe/xe_ggtt.c          |   2 +-
> drivers/gpu/drm/xe/xe_migrate.c       |  14 +-
> drivers/gpu/drm/xe/xe_pt.c            |   2 +-
> 6 files changed, 237 insertions(+), 31 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
>index 41de648b2c86..119134e67c89 100644
>--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
>@@ -253,7 +253,7 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test,
> 	if (xe_bo_is_vram(pt))
> 		xe_res_first(pt->ttm.resource, 0, xe_bo_size(pt), &src_it);
> 	else
>-		xe_res_first_sg(xe_bo_sg(pt), 0, xe_bo_size(pt), &src_it);
>+		xe_res_first_tt(pt->ttm.ttm, 0, xe_bo_size(pt), &src_it);
>
> 	emit_pte(m, bb, NUM_KERNEL_PDE - 1, xe_bo_is_vram(pt), false,
> 		 &src_it, XE_PAGE_SIZE, pt->ttm.resource);
>@@ -385,12 +385,12 @@ static struct dma_fence *blt_copy(struct xe_tile *tile,
> 	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
>
> 	if (!src_is_vram)
>-		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
>+		xe_res_first_tt(src_bo->ttm.ttm, 0, size, &src_it);
> 	else
> 		xe_res_first(src, 0, size, &src_it);
>
> 	if (!dst_is_vram)
>-		xe_res_first_sg(xe_bo_sg(dst_bo), 0, size, &dst_it);
>+		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
> 	else
> 		xe_res_first(dst, 0, size, &dst_it);
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index caf5aa0bab53..d54e69aefeba 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -6,6 +6,7 @@
> #include "xe_bo.h"
>
> #include <linux/dma-buf.h>
>+#include <linux/dma-mapping.h>
> #include <linux/nospec.h>
>
> #include <drm/drm_drv.h>
>@@ -15,6 +16,7 @@
> #include <drm/ttm/ttm_backup.h>
> #include <drm/ttm/ttm_device.h>
> #include <drm/ttm/ttm_placement.h>
>+#include <drm/ttm/ttm_pool.h>
> #include <drm/ttm/ttm_tt.h>
> #include <uapi/drm/xe_drm.h>
>
>@@ -420,6 +422,32 @@ struct xe_ttm_tt {
> 	struct ttm_tt ttm;
> 	struct sg_table sgt;
> 	struct sg_table *sg;
>+	/**
>+	 * @iova: IOVA state describing the single contiguous IOVA mapping of
>+	 * the tt pages. Only valid when @use_iova is true.
>+	 */
>+	struct dma_iova_state iova;
>+	/**
>+	 * @use_iova: Whether this tt is DMA mapped using the IOVA-based DMA
>+	 * API instead of a scatter-gather list. Decided once at tt creation
>+	 * time and stable for the lifetime of the tt.
>+	 */
>+	bool use_iova;
>+	/**
>+	 * @iova_linked: Whether the tt pages are currently linked into the
>+	 * IOVA mapping. Only meaningful when @use_iova is true.
>+	 */
>+	bool iova_linked;
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+	/**
>+	 * @iova_dma_pages: Per-order count of DMA-mapped pages this tt
>+	 * accounted into xe->mem.dma_mapped_pages[] for its IOVA mapping,
>+	 * recorded at link time so the unlink can apply an exactly matching
>+	 * decrement without re-walking tt->pages (which TTM may mutate, e.g.
>+	 * during defrag). Counter ownership stays isolated in xe_bo.c.
>+	 */
>+	unsigned long iova_dma_pages[NR_PAGE_ORDERS];
>+#endif
> 	/** @purgeable: Whether the content of the pages of @ttm is purgeable. */
> 	bool purgeable;
> };
>@@ -468,6 +496,52 @@ static void xe_tt_account_dma_pages(struct xe_device *xe,
> }
> #endif
>
>+/*
>+ * xe_tt_account_iova_add - account one freshly linked IOVA folio
>+ * @xe: the xe device
>+ * @xe_tt: the xe_ttm_tt being mapped
>+ * @order: page order of the linked folio
>+ *
>+ * Add the folio's 2^order pages to xe->mem.dma_mapped_pages[order] and record
>+ * the same amount in @xe_tt so xe_tt_unaccount_iova() can later subtract an
>+ * exactly matching count without re-walking tt->pages.
>+ */
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+static void xe_tt_account_iova_add(struct xe_device *xe,
>+				   struct xe_ttm_tt *xe_tt, unsigned int order)
>+{
>+	unsigned long chunk = 1UL << order;
>+
>+	xe_tt->iova_dma_pages[order] += chunk;
>+	atomic_long_add(chunk, &xe->mem.dma_mapped_pages[order]);
>+}
>+
>+static void xe_tt_unaccount_iova(struct xe_device *xe,
>+				 struct xe_ttm_tt *xe_tt)
>+{
>+	unsigned int order;
>+
>+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
>+		unsigned long pages = xe_tt->iova_dma_pages[order];
>+
>+		if (pages) {
>+			atomic_long_sub(pages, &xe->mem.dma_mapped_pages[order]);
>+			xe_tt->iova_dma_pages[order] = 0;
>+		}
>+	}
>+}
>+#else
>+static void xe_tt_account_iova_add(struct xe_device *xe,
>+				   struct xe_ttm_tt *xe_tt, unsigned int order)
>+{
>+}
>+
>+static void xe_tt_unaccount_iova(struct xe_device *xe,
>+				 struct xe_ttm_tt *xe_tt)
>+{
>+}
>+#endif

Assisted-by: LLM

NIT..As mentioned in patch 12, I am not sure if CONFIG_DEBUG_FS is the
right config for this. May be XE_DEBUG would be better?

>+
> static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> {
> 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>@@ -514,28 +588,129 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
> 	}
> }
>
>-struct sg_table *xe_bo_sg(struct xe_bo *bo)
>+/*
>+ * xe_tt_map_iova - DMA map a tt using the IOVA-based DMA API.
>+ *
>+ * Link all of the tt's pages into the IOVA range reserved at tt creation
>+ * time, one folio at a time, and sync the IOTLB once at the end. The IOVA
>+ * reservation itself is kept across map/unmap cycles and only released when
>+ * the tt is destroyed.
>+ */
>+static int xe_tt_map_iova(struct xe_device *xe, struct ttm_tt *tt)
> {
>-	struct ttm_tt *tt = bo->ttm.ttm;
> 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>+	struct device *dev = xe->drm.dev;
>+	unsigned long num_pages = tt->num_pages;
>+	unsigned long i = 0;
>+	size_t mapped = 0;
>+	int ret;
>+
>+	if (xe_tt->iova_linked)
>+		return 0;
>+
>+	while (i < num_pages) {
>+		struct page *page = tt->pages[i];
>+		unsigned int order = ttm_pool_page_order_nodma(page);
>+		size_t len = PAGE_SIZE << order;

NIT...as ttm_pool_page_order_nodma() is works only at chunk head
(where order is stored in page->private), it should be fine.
But if we ever endup here for pages[i] other than chunk head, it
would become hard to debug. Is there a way we can assert for that here?

>+
>+		ret = dma_iova_link(dev, &xe_tt->iova, page_to_phys(page),
>+				    mapped, len, DMA_BIDIRECTIONAL,
>+				    DMA_ATTR_SKIP_CPU_SYNC);
>+		if (ret)
>+			goto err_unlink;
>
>-	return xe_tt->sg;
>+		xe_tt_account_iova_add(xe, xe_tt, order);
>+		mapped += len;
>+		i += 1UL << order;
>+	}
>+
>+	ret = dma_iova_sync(dev, &xe_tt->iova, 0, mapped);
>+	if (ret)
>+		goto err_unlink;
>+
>+	xe_tt->iova_linked = true;
>+	return 0;
>+
>+err_unlink:
>+	if (mapped) {
>+		dma_iova_unlink(dev, &xe_tt->iova, 0, mapped,
>+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
>+		xe_tt_unaccount_iova(xe, xe_tt);
>+	}
>+	return ret;
> }
>
>-/**
>- * xe_tt_sg() - Return the DMA scatter-gather table backing a ttm_tt.
>- * @tt: The ttm_tt to query.
>+/*
>+ * xe_tt_unmap_iova - Unlink a tt's pages from its IOVA mapping.
>  *
>- * Like xe_bo_sg(), but takes the ttm_tt directly. Used by the defrag copy
>- * path which needs the old (source) tt's sg table without a backing xe_bo.
>+ * Unlink the pages but keep the IOVA reservation so the tt can be remapped
>+ * later without re-allocating IOVA space.
>+ */
>+static void xe_tt_unmap_iova(struct xe_device *xe, struct ttm_tt *tt)
>+{
>+	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>+
>+	if (xe_tt->iova_linked) {
>+		/*
>+		 * Unmap with attrs 0 (matching the sg unmap path) so that the
>+		 * CPU copy-back sync is performed for non-coherent or bounced
>+		 * (SWIOTLB) mappings, even though the link was done with
>+		 * DMA_ATTR_SKIP_CPU_SYNC.
>+		 */
>+		dma_iova_unlink(xe->drm.dev, &xe_tt->iova, 0,
>+				dma_iova_size(&xe_tt->iova),
>+				DMA_BIDIRECTIONAL, 0);
>+		xe_tt_unaccount_iova(xe, xe_tt);
>+		xe_tt->iova_linked = false;
>+	}
>+}
>+
>+/*
>+ * xe_tt_map - DMA map a tt, using IOVA when available and sg otherwise.
>+ */
>+static int xe_tt_map(struct xe_device *xe, struct ttm_tt *tt)
>+{
>+	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>+
>+	if (xe_tt->use_iova)
>+		return xe_tt_map_iova(xe, tt);
>+
>+	return xe_tt_map_sg(xe, tt);
>+}
>+
>+/*
>+ * xe_tt_unmap - Undo xe_tt_map().
>+ */
>+static void xe_tt_unmap(struct xe_device *xe, struct ttm_tt *tt)
>+{
>+	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>+
>+	if (xe_tt->use_iova)
>+		xe_tt_unmap_iova(xe, tt);
>+	else
>+		xe_tt_unmap_sg(xe, tt);
>+}
>+
>+/**
>+ * xe_res_first_tt() - Initialize a resource cursor over a ttm_tt's DMA mapping.
>+ * @tt: The ttm_tt to walk.
>+ * @start: Start of the range, in bytes.
>+ * @size: Size of the range, in bytes.
>+ * @cur: The cursor to initialize.
>  *
>- * Return: The sg table, or NULL if the tt is not currently mapped.
>+ * Initialize @cur to walk the DMA addresses backing @tt, transparently
>+ * handling both the IOVA-based mapping (single contiguous range) and the
>+ * scatter-gather list fallback.
>  */
>-struct sg_table *xe_tt_sg(struct ttm_tt *tt)
>+void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
>+		     struct xe_res_cursor *cur)
> {
> 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>
>-	return xe_tt->sg;
>+	if (xe_tt->use_iova)
>+		xe_res_first_iova(&xe_tt->iova, start, size, cur);
>+	else
>+		xe_res_first_sg(xe_tt->sg, start, size, cur);
> }
>
> /*
>@@ -651,6 +826,21 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
> 		}
> 	}
>
>+	/*
>+	 * Eligible BOs are DMA mapped using the IOVA-based DMA API, which
>+	 * yields a single contiguous IOVA range instead of a scatter-gather
>+	 * list. Only device BOs that are not GGTT-mapped qualify: dma-buf
>+	 * imports manage their own mapping and GGTT bindings are programmed
>+	 * directly from the sg list. dma_iova_try_alloc() may still fail
>+	 * depending on the IOMMU mode, in which case we transparently fall
>+	 * back to the sg list. The reservation lives for the tt's lifetime.
>+	 */
>+	if (ttm_bo->type != ttm_bo_type_sg &&
>+	    !(bo->flags & (XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_ALL)) &&
>+	    dma_iova_try_alloc(xe->drm.dev, &xe_tt->iova, 0,
>+			       (size_t)tt->num_pages << PAGE_SHIFT))
>+		xe_tt->use_iova = true;

Shouldn't we be allocating 2M aligned iova here by passing 2M to 'phys'
instead of 0? We need both 2M aligned iova and 2M aligned physical address
(beneficial order) which defragmentation expected to provide by benefecial
order, right?

Niranjana

>+
> 	return tt;
> }
>
>@@ -700,7 +890,7 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> 	    !(tt->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE))
> 		return;
>
>-	xe_tt_unmap_sg(xe, tt);
>+	xe_tt_unmap(xe, tt);
>
> 	ttm_pool_free(&ttm_dev->pool, tt);
> 	xe_ttm_tt_account_subtract(xe, tt);
>@@ -709,6 +899,19 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
>
> static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> {
>+	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>+
>+	/*
>+	 * Release the IOVA reservation made in xe_ttm_tt_create(). The pages
>+	 * must already have been unlinked by xe_tt_unmap().
>+	 */
>+	if (xe_tt->use_iova) {
>+		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
>+
>+		xe_assert(xe, !xe_tt->iova_linked);
>+		dma_iova_free(xe->drm.dev, &xe_tt->iova);
>+	}
>+
> 	ttm_tt_fini(tt);
> 	kfree(tt);
> }
>@@ -1557,7 +1760,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 	/* Bo creation path, moving to system or TT. */
> 	if ((!old_mem && ttm) && !handle_system_ccs) {
> 		if (new_mem->mem_type == XE_PL_TT)
>-			ret = xe_tt_map_sg(xe, ttm);
>+			ret = xe_tt_map(xe, ttm);
> 		if (!ret)
> 			ttm_bo_move_null(ttm_bo, new_mem);
> 		goto out;
>@@ -1587,7 +1790,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 		(!ttm && ttm_bo->type == ttm_bo_type_device);
>
> 	if (new_mem->mem_type == XE_PL_TT) {
>-		ret = xe_tt_map_sg(xe, ttm);
>+		ret = xe_tt_map(xe, ttm);
> 		if (ret)
> 			goto out;
> 	}
>@@ -1757,7 +1960,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 		if (IS_VF_CCS_READY(xe))
> 			xe_sriov_vf_ccs_detach_bo(bo);
>
>-		xe_tt_unmap_sg(xe, ttm_bo->ttm);
>+		xe_tt_unmap(xe, ttm_bo->ttm);
> 	}
>
> 	xe_bo_defrag_update(bo);
>@@ -1785,7 +1988,7 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
> 		if (lret)
> 			return lret;
>
>-		xe_tt_unmap_sg(xe, bo->ttm);
>+		xe_tt_unmap(xe, bo->ttm);
> 		ttm_bo_move_null(bo, new_resource);
> 	}
>
>@@ -2212,6 +2415,8 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
> 						 DMA_BIDIRECTIONAL);
> 			ttm_bo->sg = NULL;
> 			xe_tt->sg = NULL;
>+		} else if (xe_tt->use_iova) {
>+			xe_tt_unmap_iova(ttm_to_xe_device(ttm_bo->bdev), tt);
> 		} else if (xe_tt->sg) {
> 			dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
> 					  xe_tt->sg,
>@@ -3779,7 +3984,7 @@ dma_addr_t __xe_bo_addr(struct xe_bo *bo, u64 offset, size_t page_size)
> 	if (!xe_bo_is_vram(bo) && !xe_bo_is_stolen(bo)) {
> 		xe_assert(xe, bo->ttm.ttm);
>
>-		xe_res_first_sg(xe_bo_sg(bo), page << PAGE_SHIFT,
>+		xe_res_first_tt(bo->ttm.ttm, page << PAGE_SHIFT,
> 				page_size, &cur);
> 		return xe_res_dma(&cur) + offset;
> 	} else {
>diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>index 18fcccd082b7..3e2eaefecb8f 100644
>--- a/drivers/gpu/drm/xe/xe_bo.h
>+++ b/drivers/gpu/drm/xe/xe_bo.h
>@@ -552,8 +552,9 @@ void xe_bo_dev_init(struct xe_bo_dev *bo_device);
>
> void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
>
>-struct sg_table *xe_bo_sg(struct xe_bo *bo);
>-struct sg_table *xe_tt_sg(struct ttm_tt *tt);
>+struct xe_res_cursor;
>+void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
>+		     struct xe_res_cursor *cur);
>
> /*
>  * xe_sg_segment_size() - Provides upper limit for sg segment size.
>diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
>index 8ec23862477f..4084bc183e06 100644
>--- a/drivers/gpu/drm/xe/xe_ggtt.c
>+++ b/drivers/gpu/drm/xe/xe_ggtt.c
>@@ -699,7 +699,7 @@ static void xe_ggtt_map_bo(struct xe_ggtt *ggtt, struct xe_ggtt_node *node,
> 	if (!xe_bo_is_vram(bo) && !xe_bo_is_stolen(bo)) {
> 		xe_assert(xe_bo_device(bo), bo->ttm.ttm);
>
>-		for (xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &cur);
>+		for (xe_res_first_tt(bo->ttm.ttm, 0, xe_bo_size(bo), &cur);
> 		     cur.remaining; xe_res_next(&cur, XE_PAGE_SIZE))
> 			ggtt->pt_ops->ggtt_set_pte(ggtt, end - cur.remaining,
> 						   pte | xe_res_dma(&cur));
>diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>index 9990a7144a9f..666c715a9067 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/xe_migrate.c
>@@ -1005,16 +1005,16 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		return ERR_PTR(-EINVAL);
>
> 	if (!src_is_vram)
>-		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo), 0, size, &src_it);
>+		xe_res_first_tt(src_tt ? src_tt : src_bo->ttm.ttm, 0, size, &src_it);
> 	else
> 		xe_res_first(src, 0, size, &src_it);
> 	if (!dst_is_vram)
>-		xe_res_first_sg(xe_bo_sg(dst_bo), 0, size, &dst_it);
>+		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
> 	else
> 		xe_res_first(dst, 0, size, &dst_it);
>
> 	if (copy_system_ccs)
>-		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo),
>+		xe_res_first_tt(src_tt ? src_tt : src_bo->ttm.ttm,
> 				xe_bo_ccs_pages_start(src_bo),
> 				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> 				&ccs_it);
>@@ -1383,9 +1383,9 @@ int xe_migrate_ccs_rw_copy(struct xe_tile *tile, struct xe_exec_queue *q,
>
> 	ctx = &xe->sriov.vf.ccs.contexts[read_write];
>
>-	xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
>+	xe_res_first_tt(src_bo->ttm.ttm, 0, size, &src_it);
>
>-	xe_res_first_sg(xe_bo_sg(src_bo), xe_bo_ccs_pages_start(src_bo),
>+	xe_res_first_tt(src_bo->ttm.ttm, xe_bo_ccs_pages_start(src_bo),
> 			PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> 			&ccs_it);
>
>@@ -1588,7 +1588,7 @@ struct dma_fence *xe_migrate_vram_copy_chunk(struct xe_bo *vram_bo, u64 vram_off
> 	xe_assert(xe, !range_overflows(sysmem_offset, size, (u64)sysmem_bo->ttm.base.size));
>
> 	xe_res_first(vram, vram_offset, size, &vram_it);
>-	xe_res_first_sg(xe_bo_sg(sysmem_bo), sysmem_offset, size, &sysmem_it);
>+	xe_res_first_tt(sysmem_bo->ttm.ttm, sysmem_offset, size, &sysmem_it);
>
> 	while (size) {
> 		u32 pte_flags = PTE_UPDATE_FLAG_IS_VRAM;
>@@ -1800,7 +1800,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
> 		clear_only_system_ccs = true;
>
> 	if (!clear_vram)
>-		xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &src_it);
>+		xe_res_first_tt(bo->ttm.ttm, 0, xe_bo_size(bo), &src_it);
> 	else
> 		xe_res_first(src, 0, xe_bo_size(bo), &src_it);
>
>diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
>index 7111b5d0f6aa..185d15fb0a97 100644
>--- a/drivers/gpu/drm/xe/xe_pt.c
>+++ b/drivers/gpu/drm/xe/xe_pt.c
>@@ -797,7 +797,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
> 			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
> 				     xe_vma_size(vma), &curs);
> 		else
>-			xe_res_first_sg(xe_bo_sg(bo), xe_vma_bo_offset(vma),
>+			xe_res_first_tt(bo->ttm.ttm, xe_vma_bo_offset(vma),
> 					xe_vma_size(vma), &curs);
> 	} else if (!range) {
> 		curs.size = xe_vma_size(vma);
>-- 
>2.34.1
>
