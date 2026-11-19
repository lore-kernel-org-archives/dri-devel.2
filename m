Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC102606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ku5/g2Rn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Lr7Fmcuc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D465310ED03;
	Thu, 19 Nov 2026 21:39:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DF510ED03;
 Thu, 19 Nov 2026 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795124355; x=1826660355;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Re26GzHUi5nqz3QAcOxz9aW4rMcRPUdD825KB1GNOVo=;
 b=ku5/g2RnKO3XgtT9A/WqEilFj3Dv1jter9UauHYCSLLlbOquGQjkYauX
 MD8KJ0eELvNtBa8N0DaXFj+Hqbr8RgfaHD9e8pSxJJ3e0RNXynTzOC8zU
 hSwyoVrnet7XemEr91+oJnq1PXtluOUQgtE9iCDtUljcishvCJLvJEJaZ
 SH8/z1pYPT0MWWVNs2ysgtgY2InLSsTji1fsr1cIQdlUnl4uU2kCh0ZOx
 gqP0mee5tLy6o18MT1fouqzpbDwd0TjcvC9rii7dsHFJA8eQTPwULG6l3
 IQyXDJE5ugAZOPMh7G5RcynnsiNffoJZ424bRwhdyxdodf99uLBiesI/O w==;
X-CSE-ConnectionGUID: W0z9k2GDR8SRz+HhVmynaQ==
X-CSE-MsgGUID: /7XuDRpOQk6CAmTj34/4Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3889039"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3889039"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 13:39:14 -0800
X-CSE-ConnectionGUID: dhTO7XimSeml/gd0S3ikpQ==
X-CSE-MsgGUID: 0r+etWiHQq+sI+jPRfxOQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10429690"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 13:39:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 13:39:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 13:39:13 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 13:39:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLpXzst5aXA38qQtj4gixLWBVeGSRzK5fgtewlsp9bSKaMpabZRV/UVUztjF0gVMHs6ucz0Gioa930qjGaYd0aW7oekhF9WC9Q1ck3CpRmZKfwxX6CWCwvqihdcx/eXXLJU4BusG2O7ikPYexsA2j62padROOWBmxa83Hi7TYgkfzvqn1V8d4eIsBb1yVTY2CI9ALI47btooTh+bODmGZTafDbLFonsbbmr+TJFdljPG3vpPZoECKkKxvAAyR3LgkOj3h8VhxAab9bBvVdE8sD0VCKfHfLgLgIW3uhK/tYEBdkktZOy0HtNQtmsW5dY78lzELZBANZhl12HFrVV0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASd8c6FVUGyHXyJz0jKZFG1P/djVM9p+kbuFDAH71uk=;
 b=RsbbECOtDn9y84/tUBGziEwExytwxwFQKzvE5KuM1B9yktmYIQq4Lv2kxnFrIugYPT2jP9PCnhTlSURfLyl/Sd7UADqPxhC8lpMn+xjdrCTNBdz9BfKlNAZZ4ntCU9nDVHtKqyOwKvp4EIhaF89+Y7Py7YD18+EKr+OdmEwWrs5kME25EHoFz9EqGDL1bGs/vc6goYeis/DYO/smCLByNU52VhZiGuppuiD/29Go2hIdt8az/ShQNFWI2rtP8LueZT4au6mVf7AtuK0qV2QT5Nzpra4fL0gBbZCflyUj5dYQNkS/Ehqf+ywu5uh2ZV+GqKwyTJ+aZ2zhLFyfbPJ4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASd8c6FVUGyHXyJz0jKZFG1P/djVM9p+kbuFDAH71uk=;
 b=Lr7FmcucGy9yWRk7DOajs2YdyxqTBesmfS5Ccu+jMa+/jWOYL19hwzFSurLhkozRYP8DX1hsJHt5JNP5P1aSpF2qqQBDF12n3Dg7sUfU2chXhfZVTHOfX8884onYZxMoN+VkGi66Z+KO5JtvFIYGEmD2XfbDd/76KawI9fMN24U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 21:39:07 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 21:39:06 +0000
Date: Thu, 19 Nov 2026 13:39:04 -0800
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
Subject: Re: [PATCH v3 07/33] drm/ttm: Harvest beneficial-order pages on
 defragmentation moves
Message-ID: <av9seBmEpkJn6ubW@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-8-matthew.brost@intel.com>
 <avKDURZLW9pvCFvF@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avKDURZLW9pvCFvF@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac4d1da-f534-42c1-fd07-08df468589c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|366016|376014|261009223027099003|6133799003|18002099003|261009220027099003|261009223327099003|22082099003|261009221227099003|261009221727099003|56012099006|261026140227099003|11063799006|4143699003|261102130727099003|261026130827099003|261028144727099003|261102123227099003|261022075727099003|261021133027099003|261021135927099003|261021123027099003|261022105027099003|261026121527099003|261021130227099003|261022115727099003|261021121427099003|261026135527099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0iNdJi09NYRa5GizVLbBq8v7MmeSn9KYPIThEFZPuVYVxkZaUTwfpmkVymJXM6wNwAqwDHodrhGLH72mzIBM5k+s9iR01Ka+vmg+6QrxiNraY0Pq1ivCBgX5Ne6jpLwpRHTuk0CxbKeHYU580N7x1jcX4Tl/oaqA95PfOn1orugdW/R8LoNy57uJQLMrqQEmeiZe8t48Iy4O5jsLbW9xN37SXNPqOPGRAwDxY+c+hBztS5y7Iz1UPvB/D/2YwTXTr9uCYpjwzLio0CG1XbCLrDgsVZKsdsmOvm8UyYZI/Kg9E2kQfaEn8Wu3rT461Na7NXTkDPFckYG6iOWnP2v3d3F5XjoPBS79BUm+GqQNdf01+0zqP5MpGpcLqWcrgoVKfbCVk30J1KAYeTSiKOxdT7Xg2/yDryUrp3ecbEJo88aliYHUMvh1a1U9LDPCurPQCULs+xlVbno75SHirWQB/keJGb0+ajiu+k8GsrfFbG6wF2zT5IqEnbzAQmYgs7jtf7TiJN6dAlJCOSIuXQFYB05K9oSYupEKOmd+AWGZQJq427jDZTpt1jB7mOhxnbXsk6NdJhha396XVYx8+v62jao60FZo2tdGiHK7uLMz4qMEvV6ZrLf4HBjbTcfgtHTYH9x7dS5DG2uBvxDxnEsEqdDBiKoLJL3g5adXJT6tFMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(261009223027099003)(6133799003)(18002099003)(261009220027099003)(261009223327099003)(22082099003)(261009221227099003)(261009221727099003)(56012099006)(261026140227099003)(11063799006)(4143699003)(261102130727099003)(261026130827099003)(261028144727099003)(261102123227099003)(261022075727099003)(261021133027099003)(261021135927099003)(261021123027099003)(261022105027099003)(261026121527099003)(261021130227099003)(261022115727099003)(261021121427099003)(261026135527099003)(261022113327099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YM7QmBzcHI2uPHfnmYf4pNuPmvQdzhXIgotSrfnq/KZWHGCY3qcT65h5w1?=
 =?iso-8859-1?Q?uZxNzC/Zoc0yBCGL63UFQ5uUP37TVWGzBF278dGfuqh5dNcnE7AkC/TiT2?=
 =?iso-8859-1?Q?igCF1lVeVy00Z2MKpSkw+yOkD2R4DO/tgPx2O9u0W91nKWZetpeFOkZeAv?=
 =?iso-8859-1?Q?qQyh6U2kG7AO2y1BF0l+6X4LaDwaUaljDEcqluVlkJ85p++8SvQWltq2mu?=
 =?iso-8859-1?Q?hugxwGxeTymLXbKvALp9YiNVeDxVEYLhMisfF5dkU7fssMBQtxMaKesXZe?=
 =?iso-8859-1?Q?25Oc3F2da/3we6Sll0Sigc4P+9UOaoEQP2StDSSSNtRKd52REtxOYLKBRR?=
 =?iso-8859-1?Q?BUaqI3gnNPLx4inDumg3tutKU22amOQUxH8//ReDMg5rmjENQodj52Zlp9?=
 =?iso-8859-1?Q?APTKUXQpynTKSVQjN3gbbAivYKFQgPYXoWVt+akVQj4qZ/dFiWgvlapPmY?=
 =?iso-8859-1?Q?1n3e6Nt02SwQWw/619VYcnYC2dzD1KsfHjbTdBn1d6zOoeVYWvJvh6Bmr7?=
 =?iso-8859-1?Q?rifCVeiGSSaHijrCn8Mu0fwmu/G9RGc8f4tG56Q0Uq1MbaZRYh2EH9cJO3?=
 =?iso-8859-1?Q?4Z1VKs9VBwtbvoH5c+hvTA3xkDGHvBJAqdYc6ATswzK94tT2FvcI02MlO0?=
 =?iso-8859-1?Q?xed0cYfFTq9om+FVEtfutAJU4+cuQISZTVLbxxPplqNpQEr7z9bG9u2NC/?=
 =?iso-8859-1?Q?YyhROyPtIpPpYA55Xx4DPsse0jQ6cxf/30cprPGv6fjjngY6rWCnM9hpQF?=
 =?iso-8859-1?Q?FnRLY6e/7XxYRppPu2KiQZBFgwhge4UeOzsqljQDq2txuEqsflIXf5ahSv?=
 =?iso-8859-1?Q?by5s+Vrio/2+WVgZH4VMLHORoSx7jeUxbQEP/RT0Y5FtgVMe/Bj7mK3RhG?=
 =?iso-8859-1?Q?bEk5PmIv2XBURTanPHn3aZZssZxg/AXTzDVtLW2B/ov94i4Zxq3QAi4gMI?=
 =?iso-8859-1?Q?k7JVgC72/aNxP7z7B+j2ZbQqwjB7Plssw4h6/ExzA4SziN+6o+6I57ve8t?=
 =?iso-8859-1?Q?I+/RBD5UFsddNv0nxztqCtxOzRf0q/dlf9tcasznVjXmO+Fod6QeJ1ou8S?=
 =?iso-8859-1?Q?ixQufJSVidMSo/OoHRT4rUHvGWO6wdEaOzq8M7IF09ATd1wLOChtRKaIK/?=
 =?iso-8859-1?Q?pqz9Ur77iGATWTHg/xWHbLtSsSzwnZgdE8hpoi7QS2HnrUEnmaJ6syCfoZ?=
 =?iso-8859-1?Q?rOSj0fyYaNy68TbLIVqyN6kSJbK4lNdanSR9+MDtrlDw9HJHMCW4wiUhdX?=
 =?iso-8859-1?Q?smyCkSiU2cGYcD5IXvHlBav/xhKb1TXB5vOSlqu0ZDpk8zbAcnYm9yP5Wv?=
 =?iso-8859-1?Q?iorA63n0i6RPcur9rD7C0m9586EpEEgtjolXh6DQJM37SWkRZtTP9+azRa?=
 =?iso-8859-1?Q?pzdKdttE/WIJj0VXWL9/MMQkb8SsUnOX54cVwf2paMvfqy50gx8EqBkpfT?=
 =?iso-8859-1?Q?NrCMDufEnOPPurFYjEHmrWFGJaXHlDXkXbVQhFvZh2f03+WkliuHzjTjDw?=
 =?iso-8859-1?Q?Puz05drUW7/Tn+VS/IMTEvaQ//R87jaiBYnyXEBeDnmVhO+USw27WGUjwc?=
 =?iso-8859-1?Q?GIITw4JN86lNYecJnZx/9aIRT/3GqsaPDHvtRto71eVHj1o7DaJz2P/j+l?=
 =?iso-8859-1?Q?Vvb8IsaEN9V15mm6XODRgwbcmmDaiN+IoiEMQBh0WznElJkizMT5gJwECT?=
 =?iso-8859-1?Q?0f2tKXcgW06L8sdSPChnMtLL+jUzYdAyrGDukAi5eISaIiqQAJWakuO19x?=
 =?iso-8859-1?Q?vvuTpxl7tGHF8OCy2L7iB+rEexHextdIMRauNt23/Gr034HuPDfOyBzvWI?=
 =?iso-8859-1?Q?MmFU7gvJxg=3D=3D?=
X-Exchange-RoutingPolicyChecked: v+7Mycldi5lHrm4meWp4gzihJGQtfO3tT6XVPU5qkvXEcCdo03QXiyL2nxxzma5s5L6qzmrOJJRwiQm5q7sXYG8tNIgYmuHYbHy0UCreSIJOfII2BVoBo5YayxTA6tDvyZvLfGWFAcpe2ZHGiGaoqkuK6Gt1Fg0op+O6+s4q9dyZLYpwsyyCRb5PU/oLzLt9aUQS10UBk0zrVj236lk333ENh6IaIiTz74zEnXc5YzNv+cPsPeoRJZgCoy3q/WZk0tKl1AZhJz7dylkcLhtFE/F5FgoEOUnfgzWKTI1BoMecLY9w2tAWk/zu0Ev6zlrO1tsCIvQKzetDKOWAuTxanA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac4d1da-f534-42c1-fd07-08df468589c8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:39:06.8649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7sjRJ+8p7K2FuagA8hU4k5SPh5MM/3x/KrE4hWbf8YzmSd2KBLAeVjZOhwo43+6zjCDIpWL84eg6f9y+AupXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
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

On Mon, Nov 09, 2026 at 06:37:05PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:53PM -0700, Matthew Brost wrote:
> > A defragmentation move relocates a populated tt into a freshly allocated
> > one so that sub-beneficial-order chunks can be upgraded to the device's
> > beneficial order. Previously, if allocation could not complete entirely
> > at beneficial order, the move failed and all progress was discarded.
> > 
> > Instead, once allocation has successfully upgraded part of the object,
> > the remainder of the old tt is harvested to complete the new tt. Thread
> > the BO's old, still-populated tt into the page allocator via a new
> > ttm_operation_ctx::defrag_old_tt. While allocation is still proceeding,
> > any existing chunk already at (or above) the beneficial order is reused
> > directly instead of being reallocated. If allocation later has to fall
> > back below beneficial_order after making partial progress, the remainder
> > of the old tt is harvested instead of failing the move. This preserves
> > the beneficial-order upgrades already made while leaving the rest of the
> > object unchanged, allowing subsequent defragmentation attempts to make
> > additional forward progress.
> > 
> > Harvesting only borrows the pages; they remain owned by the old tt until
> > the move commits. This keeps every unwind path non-destructive: if the
> > (re)allocation or the move later fails, the new tt is torn down without
> > freeing the borrowed pages and the old tt is restored fully intact.
> > Ownership of the shared pages is transferred to the new tt only once the
> > move has committed. ttm_tt_defrag_disown_borrowed() implements both
> > directions of the transfer by clearing a tt's slots for every page it
> > shares with the other tt (same struct page at the same index), so that
> > tt's teardown leaves the shared pages alone and each page is freed
> > exactly once by its owner:
> > 
> > - on the alloc unwind and the failed-move paths, the new tt disowns the
> >  borrowed pages, leaving the old tt as the sole owner;
> > - on the successful-move paths (synchronous teardown and the pipelined
> >  ghost-object teardown), the old tt disowns the now-transferred pages,
> >  leaving the new tt as the sole owner.
> > 
> > Detecting shared pages by same-index struct page identity needs no extra
> > per-tt bookkeeping, since two distinct allocations never alias. This is
> > safe with drivers, such as Xe, that build their own per-tt sg table and
> > DMA-map it independently: each tt maps and unmaps its own sg, so sharing
> > the underlying pages between tts is DMA-clean.
> > 
> > This is a no-op unless ctx->defrag_old_tt is set, which only happens on a
> > defragmentation move.
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
> > 
> > ---
> > 
> > v3:
> > - Document the chunk-head invariant read by
> >   ttm_pool_harvest_remaining() (Sashiko)
> > ---
> > drivers/gpu/drm/ttm/ttm_bo.c      |  20 ++-
> > drivers/gpu/drm/ttm/ttm_bo_util.c |   5 +
> > drivers/gpu/drm/ttm/ttm_pool.c    | 235 ++++++++++++++++++++++++++++--
> > drivers/gpu/drm/ttm/ttm_tt.c      |  67 +++++++++
> > include/drm/ttm/ttm_bo.h          |  12 ++
> > include/drm/ttm/ttm_tt.h          |   2 +
> > 6 files changed, 328 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > index c1629b4c4f0f..ab2e637a017f 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -182,7 +182,14 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > 		}
> > 
> > 		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
> > +			/*
> > +			 * Let the page allocator harvest already
> > +			 * beneficial-order chunks out of the old tt to back
> > +			 * the new one, rather than reallocating them.
> > +			 */
> > +			ctx->defrag_old_tt = defrag_old_tt;
> > 			ret = ttm_bo_populate(bo, ctx);
> > +			ctx->defrag_old_tt = NULL;
> > 			if (ret) {
> > 				/*
> > 				 * Discharge the freshly allocated backing and
> > @@ -235,6 +242,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > 	}
> > 
> > 	if (bo->defrag_old_tt) {
> > +		/*
> > +		 * Successful defrag move: any pages the new tt borrowed from the
> > +		 * old tt are now owned by the new tt. Disown them from the old
> > +		 * tt before it is torn down so they are not freed.
> > +		 */
> > +		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
> > 		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
> > 		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
> > 		bo->defrag_old_tt = NULL;
> > @@ -245,7 +258,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > 
> > out_err:
> > 	if (bo->defrag_old_tt) {
> > -		/* Failed defrag move: restore the original backing. */
> > +		/*
> > +		 * Failed defrag move: drop any pages the new tt borrowed from
> > +		 * the old tt (still owned by the old tt) before destroying the
> > +		 * new tt, then restore the original backing.
> > +		 */
> > +		ttm_tt_defrag_disown_borrowed(bo->ttm, bo->defrag_old_tt);
> > 		ttm_bo_tt_destroy(bo);
> > 		bo->ttm = bo->defrag_old_tt;
> > 		bo->defrag_old_tt = NULL;
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index 771313162c8d..7cb718fc97c0 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -633,7 +633,12 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> > 		 * tt (the move's source) to the ghost so it is kept populated
> > 		 * until @fence signals and then unbound and destroyed, instead
> > 		 * of being torn down synchronously. @bo keeps its new tt.
> > +		 *
> > +		 * Any pages the new tt borrowed from the old tt are now owned by
> > +		 * the new tt; disown them from the old tt so the ghost teardown
> > +		 * leaves them alone.
> > 		 */
> > +		ttm_tt_defrag_disown_borrowed(bo->defrag_old_tt, bo->ttm);
> > 		ghost_obj->ttm = bo->defrag_old_tt;
> > 		ghost_obj->defrag_old_tt = NULL;
> > 		bo->defrag_old_tt = NULL;
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 2598d2f33767..52f5e64f05dd 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -792,6 +792,148 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
> > 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
> > }
> > 
> > +/*
> > + * Defragmentation page harvesting.
> > + *
> > + * A defrag move relocates a populated tt into a freshly allocated one in order
> > + * to upgrade sub-beneficial-order chunks to the device's beneficial order.
> > + * Chunks in the old tt (ctx->defrag_old_tt) that are ALREADY at the beneficial
> > + * order do not need to be reallocated: their physical pages can simply be
> > + * transferred ("harvested") into the new tt at the same offset, avoiding the
> > + * alloc/free churn that is significant for large buffers.
> > + *
> > + * Harvesting only borrows the pages: the new tt simply references the old tt's
> > + * pages, which remain owned by the old tt. This keeps the unwind paths simple -
> > + * if the (re)allocation or the move later fails, the new tt is torn down without
> > + * freeing the borrowed pages and the old tt is restored fully intact. Ownership
> > + * of the shared pages is transferred to the new tt only once the move has
> > + * committed, via ttm_tt_defrag_disown_borrowed() (see ttm_tt.c).
> > + */
> > +
> > +/*
> > + * Return the allocation order of the old tt chunk whose head sits at @off, or 0
> > + * if @off is not an old chunk head (it falls inside a chunk, or the slot is
> > + * empty / backed up). @cursor monotonically tracks the old chunk boundary and
> > + * must be advanced past every offset that has already been queried; a page
> > + * order may only be read from a chunk head page, hence the lazy walk.
> > + */
> > +static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
> > +					      struct ttm_tt *old_tt,
> > +					      pgoff_t off, pgoff_t *cursor)
> > +{
> > +	struct page *p;
> > +
> > +	while (*cursor < off) {
> > +		p = old_tt->pages[*cursor];
> > +		if (!p || ttm_backup_page_ptr_is_handle(p))
> > +			return 0;
> 
> Assisted-by: LLM
> 

Yes.

> ttm_backup_page_ptr_is_handle() is only check here, but not in the harvest
> function. Probably we won't endup with ptr_is_handle() case during defrag,
> but thisasymmetry makes it bit confusing.
> 

In Xe we only allow defrag in TT placement, so
ttm_backup_page_ptr_is_handle probably could be omitted here.

> > +		*cursor += 1UL << ttm_pool_page_order(pool, p);
> > +	}
> > +
> > +	if (*cursor != off)
> > +		return 0;
> > +
> > +	p = old_tt->pages[off];
> > +	if (!p || ttm_backup_page_ptr_is_handle(p))
> > +		return 0;
> > +
> > +	return ttm_pool_page_order(pool, p);
> > +}
> > +
> > +/*
> > + * Borrow an already beneficial-order chunk from the old tt into @alloc. The
> > + * pages stay owned by the old tt until the move commits.
> > + */
> > +static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
> > +				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
> > +{
> > +	pgoff_t nr = 1UL << order;
> > +	int r;
> > +
> > +	/*
> > +	 * A harvested chunk keeps the (same) bo's caching, so the deferred
> > +	 * caching range is consistent here; flush it before committing, exactly
> > +	 * like the caching-consistent path in ttm_pool_page_allocated().
> > +	 */
> > +	r = ttm_pool_apply_caching(alloc);
> > +	if (r)
> > +		return r;
> > +
> > +	/*
> > +	 * The borrowed chunk's page pointers (consecutive struct pages of one
> > +	 * compound allocation) and dma addresses already sit contiguously in
> > +	 * the old tt at @off. Copy the whole run with memcpy() instead of the
> > +	 * per-page increment loop in ttm_pool_allocated_page_commit(): for a
> > +	 * large defrag the borrowed pages dominate the new tt, so this turns
> > +	 * the populate fill from O(num_pages) individual stores into a handful
> > +	 * of bulk copies.
> > +	 */
> > +	memcpy(alloc->pages, &old_tt->pages[off], nr * sizeof(*alloc->pages));
> > +	alloc->pages += nr;
> > +	alloc->remaining_pages -= nr;
> > +
> > +	if (alloc->dma_addr) {
> > +		memcpy(alloc->dma_addr, &old_tt->dma_address[off],
> > +		       nr * sizeof(*alloc->dma_addr));
> > +		alloc->dma_addr += nr;
> > +	}
> > +
> > +	alloc->caching_divide = alloc->pages;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> > +				      struct ttm_tt *old_tt, pgoff_t off,
> > +				      struct ttm_pool_alloc_state *alloc)
> > +{
> > +	/*
> > +	 * @off is always an old-tt chunk head here, never a tail page, so
> > +	 * reading the per-chunk order below is safe. This holds because:
> > +	 *  - Old chunks are self-aligned: greedy largest-power-of-two fill
> > +	 *    places an order-k chunk at a 2^k-aligned offset, so any
> > +	 *    beneficial-order-aligned offset is a chunk boundary.
> > +	 *  - Fresh defrag allocations are capped at the beneficial order (see
> > +	 *    ttm_pool_iter_acquire_page()), so they advance @off in beneficial
> > +	 *    steps and never overshoot into the middle of a larger old chunk;
> > +	 *    super-beneficial old chunks are always harvested whole by
> > +	 *    ttm_pool_iter_reuse_old().
> > +	 *  - We are only reached once the defrag budget/prealloc is exhausted,
> > +	 *    which in the capped/prealloc config leaves @off beneficial-aligned
> > +	 *    (or, in the sub-beneficial tail, already walking old boundaries).
> > +	 */
> > +	while (alloc->remaining_pages) {
> > +		struct page *p = old_tt->pages[off];
> > +		unsigned int order = ttm_pool_page_order(pool, p);
> > +		pgoff_t nr = 1UL << order;
> > +		int r;
> > +
> > +		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
> > +		if (r)
> > +			return r;
> > +
> > +		off += nr;
> > +	}
> 
> The 'off' being always at chunk head is documented, but not checked/enforced
> in the code. Though currently, we won't have it otherwise, but tomorrow if

I don't know how to enforce this. p->private is the chunk order at the
head page only but an order of 0 is a valid value, i.e., I'm not sure
how to implement 'page is chunk head' in the current code.

> we do for some reason, it will go unnoticed. Probably worth adding a warning
> here.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
> > + * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
> > + * @TTM_POOL_ITER_RETRY: Loop state was adjusted (e.g. order lowered or a chunk
> > + *	harvested); re-enter the loop body for the next order.
> > + * @TTM_POOL_ITER_STOP: The allocation is complete; stop the loop.
> > + *
> > + * Phase helpers return one of these (>= 0) on success, or a negative errno on
> > + * failure (the caller then unwinds via error_free_all).
> > + */
> > +enum ttm_pool_iter_action {
> > +	TTM_POOL_ITER_FILL,
> > +	TTM_POOL_ITER_RETRY,
> > +	TTM_POOL_ITER_STOP,
> 
> NIT...STOP is really not needed here, RETRY will do as the loop is
> expected to end there. But it is fine.
>

Not following this - __ttm_pool_alloc look at TTM_POOL_ITER_RETRY vs
STOP.
 
> > +};
> > +
> > /**
> >  * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
> >  *
> > @@ -806,6 +948,7 @@ struct ttm_pool_alloc_iter {
> > 	const struct ttm_operation_ctx *ctx;
> > 	struct ttm_pool_alloc_state *alloc;
> > 	struct ttm_pool_tt_restore *restore;
> > +	struct ttm_tt *defrag_old_tt;
> > 	unsigned int beneficial_order;
> > 	gfp_t gfp_flags;
> > 
> > @@ -814,9 +957,50 @@ struct ttm_pool_alloc_iter {
> > 	enum ttm_caching page_caching;
> > 	bool allow_pools;
> > 	bool fail_beneficial;
> > +	unsigned int alloc_count;
> > +	pgoff_t old_cursor;
> > 	struct page *p;
> > };
> > 
> > +/*
> > + * Defrag move: reuse an already beneficial-order chunk from the old tt at this
> > + * offset rather than reallocating it. Harvest whatever order the old chunk has
> > + * (>= beneficial order), which may exceed the order the new tt would otherwise
> > + * pick. An order below beneficial_order is only reused for the unaligned tail
> > + * (where there is no benefit to reallocating). Only borrows the pages; the alloc
> > + * unwind path can drop them again.
> > + *
> > + * Returns TTM_POOL_ITER_RETRY when a chunk was harvested, TTM_POOL_ITER_FILL to
> > + * fall through to a fresh allocation, or a negative errno.
> > + */
> > +static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> > +{
> > +	unsigned int harvest_order;
> > +	pgoff_t off;
> > +	int r;
> > +
> > +	if (!it->defrag_old_tt || !it->beneficial_order)
> > +		return TTM_POOL_ITER_FILL;
> > +
> > +	off = it->tt->num_pages - it->alloc->remaining_pages;
> > +	harvest_order = ttm_pool_defrag_old_order(it->pool, it->defrag_old_tt,
> > +						  off, &it->old_cursor);
> > +
> > +	if (harvest_order < it->beneficial_order &&
> > +	    it->order >= it->beneficial_order)
> > +		return TTM_POOL_ITER_FILL;
> > +
> > +	it->order = harvest_order;
> > +	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
> > +	if (r)
> > +		return r;
> > +
> > +	it->page_caching = it->tt->caching;
> > +	it->allow_pools = true;
> > +
> > +	return TTM_POOL_ITER_RETRY;
> > +}
> > +
> > /*
> >  * Acquire a single page for the current order, leaving it in @it->p (NULL on
> >  * failure). Tries a same-order pool page, then a fresh system allocation. Fault
> > @@ -859,9 +1043,10 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > /*
> >  * The current order could not be satisfied. Lower it and retry, recording a
> >  * sub-optimal backing (so the driver can later re-defrag) when we drop below
> > - * the beneficial order.
> > + * the beneficial order. For a defrag move that has already made partial
> > + * progress, harvest the remaining old pages and stop instead.
> >  *
> > - * Returns 0 to retry the (lowered) order, or a negative errno.
> > + * Returns TTM_POOL_ITER_RETRY, TTM_POOL_ITER_STOP, or a negative errno.
> >  */
> > static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > {
> > @@ -871,16 +1056,24 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > 	if (!it->order)
> > 		return -ENOMEM;
> > 
> > -	/*
> > -	 * Failing to allocate at the device's beneficial order means we are
> > -	 * about to back this object with a sub-optimal (smaller order) set of
> > -	 * pages. Record it so the driver can later try to defragment the object
> > -	 * back to beneficial order.
> > -	 */
> > 	if (it->fail_beneficial || at_beneficial) {
> > 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > -		if (it->ctx->defrag)
> > +
> > +		if (it->alloc_count && it->defrag_old_tt) {
> > +			pgoff_t off = it->tt->num_pages -
> > +				      it->alloc->remaining_pages;
> > +			int r;
> > +
> > +			r = ttm_pool_harvest_remaining(it->pool,
> > +						       it->defrag_old_tt, off,
> > +						       it->alloc);
> > +			if (r)
> > +				return r;
> > +
> > +			return TTM_POOL_ITER_STOP;
> > +		} else if (it->defrag_old_tt) {
> > 			return -ENOMEM;
> > +		}
> > 	}
> > 
> > 	if (it->fail_beneficial)
> > @@ -890,7 +1083,7 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > 	it->page_caching = it->tt->caching;
> > 	it->allow_pools = true;
> > 
> > -	return 0;
> > +	return TTM_POOL_ITER_RETRY;
> > }
> > 
> > static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > @@ -904,6 +1097,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		.ctx = ctx,
> > 		.alloc = alloc,
> > 		.restore = restore,
> > +		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
> > 		.beneficial_order = ttm_pool_beneficial_order(pool),
> > 		.page_caching = tt->caching,
> > 		.allow_pools = true,
> > @@ -931,13 +1125,22 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> > 	     alloc->remaining_pages;
> > 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> > +		/* Reuse an already beneficial-order chunk from the old tt. */
> > +		r = ttm_pool_iter_reuse_old(&it);
> > +		if (r < 0)
> > +			goto error_free_all;
> > +		if (r == TTM_POOL_ITER_RETRY)
> > +			continue;
> > +
> > 		/* Acquire a page (pool / system) for this order. */
> > 		ttm_pool_iter_acquire_page(&it);
> > 		if (!it.p) {
> > 			r = ttm_pool_iter_lower_order(&it);
> > -			if (r)
> > +			if (r < 0)
> > 				goto error_free_all;
> > -			continue;
> > +			if (r == TTM_POOL_ITER_RETRY)
> > +				continue;
> > +			break;	/* TTM_POOL_ITER_STOP */
> > 		}
> > 
> > 		r = ttm_pool_page_allocated(pool, it.order, it.p,
> > @@ -951,6 +1154,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 			if (r)
> > 				goto error_free_all;
> > 		}
> > +
> > +		it.alloc_count++;
> > 	}
> > 
> > 	r = ttm_pool_apply_caching(alloc);
> > @@ -969,6 +1174,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	if (tt->restore)
> > 		return r;
> > 
> > +	/*
> > +	 * Drop any pages borrowed from the old tt during a defrag move: they are
> > +	 * still owned by the old tt and must not be freed here.
> > +	 */
> > +	ttm_tt_defrag_disown_borrowed(tt, it.defrag_old_tt);
> > +
> > 	caching_divide = alloc->caching_divide - tt->pages;
> > 	ttm_pool_free_range(pool, tt, tt->caching, 0, caching_divide);
> > 	ttm_pool_free_range(pool, tt, ttm_cached, caching_divide,
> > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> > index b645a1818184..2388ff794a59 100644
> > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > @@ -450,6 +450,73 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
> > }
> > EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_unpopulate);
> > 
> > +/**
> > + * ttm_tt_defrag_disown_borrowed() - Drop borrowed defrag pages from a tt
> > + * @tt: The tt to drop the borrowed page references from.
> > + * @src: The tt the pages may have been harvested from, or NULL.
> > + *
> > + * During a defragmentation move the freshly (re)allocated tt may harvest
> > + * already beneficial-order chunks from the BO's old tt, sharing the underlying
> > + * pages instead of reallocating them. Until the move commits these pages stay
> > + * owned by the old tt. Clearing a tt's slots for every page it shares with
> > + * @src (the same struct page at the same index) makes that tt's teardown leave
> > + * the shared pages alone, so they are freed exactly once by their owner.
> > + *
> > + * This is used both to unwind a failed defrag move (disown the borrowed pages
> > + * from the new tt, leaving the old tt intact) and to commit a successful one
> > + * (disown the now-transferred pages from the old tt, leaving them owned by the
> > + * new tt).
> > + */
> > +void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src)
> > +{
> > +	pgoff_t i = 0, run_start = 0;
> > +	bool in_run = false;
> > +
> > +	if (!tt || !src)
> > +		return;
> > +
> > +	/*
> > +	 * Borrowing happens at chunk granularity: a borrowed chunk shares the
> > +	 * same struct page on both tts across its whole allocation order, while
> > +	 * a non-borrowed chunk differs across its whole order. Stride by @src's
> > +	 * chunk order instead of walking every page, coalescing the borrowed
> > +	 * (matching) chunks into runs and clearing each run with a single
> > +	 * memset rather than a per-page store. @src is a fully populated,
> > +	 * non-dma_alloc tt (the defrag path), so its page order is recorded in
> > +	 * page->private and read via ttm_pool_page_order_nodma().
> > +	 */
> > +	while (i < tt->num_pages) {
> > +		struct page *sp = src->pages[i];
> > +		unsigned int order = sp ? ttm_pool_page_order_nodma(sp) : 0;
> 
> Here ttm_pool_page_order_nodma() is used where as in harvest funciton,
> ttm_pool_page_order() is used. Though it doesn't matter to Xe, this asymmetry
> makes it bit confusing.
> 

We don't have the pool here, hence we use ttm_pool_page_order_nodma.

Defrag isn't supported on dma_alloc pages, thus is safe.

Matt

> Niranjana
> 
> > +		pgoff_t nr = 1UL << order;
> > +
> > +		if (sp && tt->pages[i] == sp) {
> > +			if (!in_run) {
> > +				run_start = i;
> > +				in_run = true;
> > +			}
> > +		} else if (in_run) {
> > +			memset(&tt->pages[run_start], 0,
> > +			       (i - run_start) * sizeof(*tt->pages));
> > +			if (tt->dma_address)
> > +				memset(&tt->dma_address[run_start], 0,
> > +				       (i - run_start) *
> > +				       sizeof(*tt->dma_address));
> > +			in_run = false;
> > +		}
> > +
> > +		i += nr;
> > +	}
> > +
> > +	if (in_run) {
> > +		memset(&tt->pages[run_start], 0,
> > +		       (i - run_start) * sizeof(*tt->pages));
> > +		if (tt->dma_address)
> > +			memset(&tt->dma_address[run_start], 0,
> > +			       (i - run_start) * sizeof(*tt->dma_address));
> > +	}
> > +}
> > +
> > #ifdef CONFIG_DEBUG_FS
> > 
> > /* Test the shrinker functions and dump the result */
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index f4f8a8c29f04..fcaba5fb8bf7 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -211,6 +211,18 @@ struct ttm_operation_ctx {
> > 	 * order.
> > 	 */
> > 	bool defrag;
> > +	/**
> > +	 * @defrag_old_tt: During a defragmentation move, the bo's existing
> > +	 * (populated) tt that is being relocated. The page allocator may
> > +	 * harvest already beneficial-order chunks from this tt to back the new
> > +	 * tt instead of reallocating them, avoiding alloc/free churn for large
> > +	 * buffers. Harvested pages are only borrowed: they stay owned by
> > +	 * @defrag_old_tt until the move commits, at which point
> > +	 * ttm_tt_defrag_disown_borrowed() clears the old tt's slots for the
> > +	 * transferred pages so they are not freed when the old tt is torn down.
> > +	 * NULL for non-defrag operations.
> > +	 */
> > +	struct ttm_tt *defrag_old_tt;
> > 	/**
> > 	 * @resv: Reservation object to be used together with
> > 	 * @allow_res_evict.
> > diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> > index ce7533677d77..55c35bcf134d 100644
> > --- a/include/drm/ttm/ttm_tt.h
> > +++ b/include/drm/ttm/ttm_tt.h
> > @@ -284,6 +284,8 @@ int ttm_tt_populate(struct ttm_device *bdev, struct ttm_tt *ttm,
> >  */
> > void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm);
> > 
> > +void ttm_tt_defrag_disown_borrowed(struct ttm_tt *tt, const struct ttm_tt *src);
> > +
> > /**
> >  * ttm_tt_mark_for_clear - Mark pages for clearing on populate.
> >  *
> > -- 
> > 2.34.1
> > 
