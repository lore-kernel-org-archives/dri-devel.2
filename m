Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85C606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSKc/V4a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OmT+q63b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540A710E066;
	Tue, 24 Nov 2026 16:24:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9BB10E066;
 Tue, 24 Nov 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795537455; x=1827073455;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=XesPGlR6VX7O0h7kxAX2ayWftulgM3nkNcYelLMvJgU=;
 b=eSKc/V4aW62iAKi209Uyq97NHQROIUTRrzb/2A7SkrXNlFpXLNmFcgmb
 agX3Rp6QEgVfTVzOwiIv8fWjW27SZuUbh8RxFYFXHPhJuOfJ/9i0Bpkd6
 fNxp70UkGZ3a6NM8EbhjwUTX2exUh1iMp/TmWi7fpZTw/DV/mIwUhv3pq
 m1hcAOZP7kBLYYB7FeVwjl4xgMorKqF/Y/CCWkS7Kp5+KPbKzBvInPMAJ
 eZbeoJrXaTRM2P4GDEwzqXr6ZDs86IewtSDvktOBU3JGSRpEZ2kfb29wU
 FZ7NYtunpYfHT1aNEW6slmfCNtnZsOY3YrdIeXp2BLJ0Duf1DP/yHg02W w==;
X-CSE-ConnectionGUID: hO/s77MiSPKO2Qyh/orkUA==
X-CSE-MsgGUID: tWI/fUtVSVaTuXDAfwiy/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4278553"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4278553"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 08:21:25 -0800
X-CSE-ConnectionGUID: 1ASdokBFTU2qEnJVUXGUiA==
X-CSE-MsgGUID: QXyO8RwcRMa+BZv5lCN7yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11488858"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 08:21:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 08:21:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 08:21:23 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 08:21:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6r4335/NkKRX4iE9bXLgjROt/Y8YQCslOofVZYvuqNvmr/EZP0t2X/unclJkv5wBu+2VwXyhM6737VsfZygUnD+RciSOIvwBzeXruXAjq+ASltXjsm5qK0EJuv+rMXf1oHcy4IdkkHEsr9yTFeyTH3DzrN02XI6/Qpt1T/Mg02wUuGoxefAwRwKy3CEpzXZFQb9+BUWSfeq1WzwAVsQ5nqi/qQ6r8Tgk3zbH0mh/eifilF40zMaqfWFILXVR2BzjqAgvW1I1ZPCyY9uKRtYAI09QGTvnUlQ9X99mp/Tsx5mfwldJ40kvUsLTv2UiCy9YDoB0Cudn2YeWk8mKYLl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/okcVuoAVcewN8MfoAWIGWS55IGyEzt4EtD7h2m5c0=;
 b=sd9+zf7cEdipca1ZT9uhuMHxgOcLDzNGoAgloaFBb0eo6bHCV2t/ZRy1WrHTbdVbkqjKrywSqx6HW3Xd+5S6BjGLFnTSYPkvdwkq5xQSobKKMmo1h2emYK1V2C+4q92R3iN66HLGBb7Ueact7Xeylsvrl/EjaQiNnVGhGcd9Qu2uCFZSZN78J3rlKEGpnrIp2Ilnvd1ebdKzwkOenU2bFMnkHBm+FQxGmJNLrUbdpMyrclhvch36bqRmrZ0pFgw8vm/3//PyEpdRU4HwvU/PJNbC7TivlB5+dT3D8YYdYD4QgDA9icQr3Czar60B1yAHZp36N/5LhOv+Zbx9I0RBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/okcVuoAVcewN8MfoAWIGWS55IGyEzt4EtD7h2m5c0=;
 b=OmT+q63bunlxib1f6ycwtmyvkA23ov17HnZ0/BO8dsiQSPwwzMIDr+CIFO2qvUmtgq0QEHiQOKrLF9x+/xF/w5f8EJjWH42dR8lW8h8OOgMulNLbRZ3vPk4b3XCpfvvEgt9TFzcex9isVr67hi0T2Ksb3GwWL9e+w36rdXga7Xk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 16:21:15 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:21:13 +0000
Date: Tue, 24 Nov 2026 08:21:10 -0800
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
Subject: Re: [PATCH v3 19/33] drm/xe: Skip self-copies for borrowed pages on
 defrag moves
Message-ID: <awW5dgh6xO71QupN@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-20-matthew.brost@intel.com>
 <avKcnNcgR_e0mXNN@nvishwa1-desk>
 <awW2mDswIkDpHO6F@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awW2mDswIkDpHO6F@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0f4835-a4cc-46c2-599d-08df4a46f515
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|3023799007|11063799006|5023799004|56012099006|4143699003|261022105027099003|261028144727099003|261022075727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: sKdXiRCMARx1r4QStUsXEwm2xFttK/OaF1fTUzFbVAgXE+ThnzFBZjSvPnLaXGd36Lim4JpenA5o3EbuxhKRUYwn/b2vFI3xjccykHd8PcggyvwMPUhtS6nzlBZ+51kJSixBZOBJYbSZBFrIM0vg2db6jF1Z9/5bgdGAMoI6kO0S0EDNTVyAvU0vfNLzaqnwUXnxTAs+SfsBhnZ/k5iCS99M5P9O6UM5Qb3fUVuqAam35w2KVs8+ThGAmQVadDBQ34C8PVgoOT1pVR/rwYvbDwz1U7hkOXMLkaqx+PlilRLf7Cl9FG/55i0Z6p239mIvHfTp1r4T1cCfqk1eNC8wT/LpX0fOX1AKFjmOuF8nmzXRPhUsfVI/XNWugnJxXKV6zb36jZrJJu8th9RI4blO+CUi91KC9zcGj3xnEMgjg5rWr2v8jbJTn769PwbxfPmr+bfY73CIbhvFSXaIKOuF2lnm2uxwq1cMGzt15k64caV4WOwNjXpwyLKvA6loMFt4MjfuQzgXiSp12OKSsX7YSiUYdJWvdzfc2W6QzwkrA54cUp4u/5RDbmDEGX6gdPotDBbHKbFfOPHV9rtOBIju5HgK1gjtcQ4gapboVkGWBkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(5023799004)(56012099006)(4143699003)(261022105027099003)(261028144727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0av0yBUpUpKyxXcb/AlSmJ4W+JaTEQekU8f/TSUVSjc8iidqqpQr3/LTpf?=
 =?iso-8859-1?Q?kPwcN5a2aQSSxdtjtkkfS5Hqrq9iYSRShux7doR8Aq+O5yA6V58ZySHmsV?=
 =?iso-8859-1?Q?owyKlROAGW616FrN+CDTWQI0md7+wxgZ8iBENkgfJyyYBhrlQABF+VANlH?=
 =?iso-8859-1?Q?e3Zwxnek5gblNhCrj5eonXBhfglw6lHy9QYv0DxLD2ju2VvGC8zcxjw11+?=
 =?iso-8859-1?Q?/teUFY8PjOldump5PsvkCP1313u5xCFba2Epn9Q3xlU+0Smi1jPk2z7+1B?=
 =?iso-8859-1?Q?fnYcpZWYLkn8LFKHfbgWzJFt/NKTyIm7RbETKnqOHTKdeK+YRnGEhOVpsh?=
 =?iso-8859-1?Q?A8zX7PMciE4QQMrG6kYvzyrJbKCXu9yI4ZjGiOH5Xr8sJ7A250UwdsMH24?=
 =?iso-8859-1?Q?Bdn9+Egpl6S5f3XC3cEjqNFC62eILZHXPayYgwuVFkZasQnjXQ26zKZGxE?=
 =?iso-8859-1?Q?Nk9gAxsXxszMnYPxnBMlHtItfRk/qzZx2v+nR24GOLzfhd4mz9k/NgaPSg?=
 =?iso-8859-1?Q?b3ABiB4df+kjeUHsw2uXykkC19B94uvLiOCDlRNrB2tGaw8qhjr9nfgIRf?=
 =?iso-8859-1?Q?u1gDnzXc0Jb+4aR9WTr9vpdJP32QoSk+UVlLzV+6ipQuzNxa7hZKJOGsDI?=
 =?iso-8859-1?Q?SMqRanMnM8cAaKkHtbxGGqUKd9KwCZCoKl0XacxME+2q2pjnpooiIvr/ow?=
 =?iso-8859-1?Q?QQgWFeRGbAPnKHyCObQhznJdKvTHS0gTWyB1OPDiMFwxZKJMUhNUffWjbi?=
 =?iso-8859-1?Q?35wCIFVp5W5H+iI9zlHR7/PQrcjHXlIuNzoub8uzsEJuVQBnYJG7Bmw+rP?=
 =?iso-8859-1?Q?0UGGemzAe/KuchHrXHZmgzlkQjZ4dVtv5AVRN5A5o2dkyRfPXiIErYaR+m?=
 =?iso-8859-1?Q?VICXCsOjRcQLtZZY3AbgISZlmiK0bYVUQqzkc4ivDW4lIsa0tqNzuyI4nX?=
 =?iso-8859-1?Q?Jen3iwWoOXmNf1JWieTEBl6DXkGWd7W64npU+rt/zlfrJ40T9n3BL+OB/F?=
 =?iso-8859-1?Q?w+JwKo+4zom67Ys1raZ18fmMRSbrquvJ9IVJyWuR7vJFm7IfvTu3JExu77?=
 =?iso-8859-1?Q?NJ29fAnjxAIq0Emb2c7xHzakhZ0//PRCv1ijTTEcVNyKNRGE4Ox7xhr7lc?=
 =?iso-8859-1?Q?2boWA8B3smp21DiDyOc3tHZL+eVuSU3AS0WjQAxBTZ3FgQLiNXqUo/5mk/?=
 =?iso-8859-1?Q?CN3Pg7JhAPDDJpx7dkll+kztOwDlE6DqEbbDZq7HGAGmmagaBCwffqAMlN?=
 =?iso-8859-1?Q?5E8ydG400Mu/yEd0hwJNmjv4rXl/q68bm8luDb12G+/OiaeT5N4+U+n5XV?=
 =?iso-8859-1?Q?Wie/mfXZ7tmTHURuPA0s0AxevTy1TU0bGWGtvAdULu5FyVnV4I/vGYUmvs?=
 =?iso-8859-1?Q?OiCT/wXfBza+To5nKXLr+YHoBtedbGyLvTSrPnAuyTZR+52lR4Bkbn5fop?=
 =?iso-8859-1?Q?tOGs+/fttvQYnqCAtq1xGCKxKEeq884cqhO4udSHNVsfut/KjnojyExoiF?=
 =?iso-8859-1?Q?XiTw0ZJwBVCYzxRI6fH2UdaZzPAp0AP1hO5I46uiMkRyQ8zj3kz2/DfDe+?=
 =?iso-8859-1?Q?yI6HKhvSa4at2JSnkARlK8MixCcFCrQQ3MRXiMEtxCpSJ1wp1NMTnYR4cX?=
 =?iso-8859-1?Q?5+JTWZ7G+kayprpY6mqiui9j1vTOQc7kX4awNjqdMubEija2u/UMENfETz?=
 =?iso-8859-1?Q?UMGCwubeyTOi0TBygtcd2zXE3Q9NIDxrCLCzaY4ykQIDQWOuNRh7OBNFSK?=
 =?iso-8859-1?Q?eTRfeua8w4RdbXQ6VGfyuOnq84a7H2UZmS3siwzUn/jWky6MNlNPjSv/CM?=
 =?iso-8859-1?Q?1jkNxII0Rw=3D=3D?=
X-Exchange-RoutingPolicyChecked: cJc1X2+8PLwaLefrCK4zBV8tb6ct2VjQJV/1RojRUJzNeBmlyGwBcu7Sa5flNzm75x/bsM64u8B3sxqmjjUPwm4oW1UvUPNdgtdEak1/9ZkvwJb2uX679yiLxnmo9IWq26UQo9bGZlLOfVVPKRADHlg57OG/JXSSrBTYKbzKtZQ83+lnXuPo1ny9GYgqULXPmLnJ+Tq4L9RP7Cf9NmxwvrZ3FGV7Mxm5gGDLBZaEj4MI19MLWrzBcHnarBBmmStl6wOAU1Izq1Vd2GN++4i6IXTlojRGGp+XNgdZHh3T7SsSdb00YlgEibPdeRQ2nUX53qi3xUMn6Jc6x39xsho1LQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f4835-a4cc-46c2-599d-08df4a46f515
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:21:13.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aZ7jwkEpsop0a2Yn22m5RsgMeLKVe9u1gPPODIzGB7GwjDntZZo7ZTNbgbtqiOhsPRqw2Q5YPfPJZgacS1XwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
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

On Tue, Nov 24, 2026 at 08:08:56AM -0800, Matthew Brost wrote:
> On Mon, Nov 09, 2026 at 08:25:00PM -0800, Niranjana Vishwanathapura wrote:
> > On Fri, Jul 10, 2026 at 07:56:05PM -0700, Matthew Brost wrote:
> > > A defrag move may harvest already beneficial-order chunks from the old
> > > tt, so the freshly reallocated backing borrows (references) some of the
> > > same physical pages. For those pages the source and destination GPU
> > > mappings alias the same memory, making the data blit a pointless
> > > self-copy.
> > > 
> > > Pass the source (old) tt into __xe_migrate_copy() instead of just its sg
> > > table, so the data pass can compare the src and dst tt page arrays at the
> > > matching offset and only blit runs of pages that actually differ. A new
> > > emit_copy_chunks() helper walks each L0 chunk, skips borrowed-page runs,
> > > and coalesces contiguous to-copy pages into a single emit_copy(). It runs
> > > twice per chunk: once with a NULL batch buffer to count the blits for
> > > batch sizing, then again to emit them.
> > > 
> > > When an entire L0 chunk turns out to be borrowed, skip it outright: no
> > > batch buffer is allocated and no GPU commands are issued, the cursors are
> > > just advanced past the chunk. If every chunk of the move is borrowed the
> > > copy is a complete no-op, so hand back a signaled stub fence.
> > > 
> > > The comparison is a cheap per-page pointer test (src page != dst page)
> > > that coalesces contiguous to-copy pages into a single blit. PTEs are
> > > still emitted for partially borrowed chunks, since that setup is cheap and
> > > only the data copies are worth skipping. Only the defrag data pass is
> > > affected; the separate CCS pass still migrates all aux state.
> > > 
> > > Since the Xe tt sg lives in the xe_ttm_tt subclass rather than the base
> > > ttm_tt, add an xe_tt_sg() helper to fetch it from a struct ttm_tt.
> > > 
> > > Cc: Carlos Santa <carlos.santa@intel.com>
> > > Cc: Ryan Neph <ryanneph@google.com>
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > 
> > > ----
> > > 
> > > v3:
> > > - Fix start_page page-shift and blit pitch for src-natural to
> > >   dst-packed copies (Sashiko)
> > > ---
> > > drivers/gpu/drm/xe/xe_bo.c      |  22 +++++-
> > > drivers/gpu/drm/xe/xe_bo.h      |   2 +
> > > drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
> > > drivers/gpu/drm/xe/xe_migrate.h |   3 +-
> > > 4 files changed, 142 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > > index bdcc9bed5d36..7f6ee9b8d12e 100644
> > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > @@ -473,6 +473,22 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
> > > 	return xe_tt->sg;
> > > }
> > > 
> > > +/**
> > > + * xe_tt_sg() - Return the DMA scatter-gather table backing a ttm_tt.
> > > + * @tt: The ttm_tt to query.
> > > + *
> > > + * Like xe_bo_sg(), but takes the ttm_tt directly. Used by the defrag copy
> > > + * path which needs the old (source) tt's sg table without a backing xe_bo.
> > > + *
> > > + * Return: The sg table, or NULL if the tt is not currently mapped.
> > > + */
> > > +struct sg_table *xe_tt_sg(struct ttm_tt *tt)
> > > +{
> > > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > > +
> > > +	return xe_tt->sg;
> > > +}
> > 
> > Assisted-by: LLM
> > 
> 
> Yes.
> 
> > xe_tt->sg can be potentially NULL (though probably not in current usecase).
> > Probably an explicit assert better?
> >
> 
> Sashiko consisently tells asserts like that are useless and an assert
> pops and then you immediately NULL ptr deref. I tend to agree with that
> line of thinking.
> 
> > > +
> > > /*
> > >  * Account ttm pages against the device shrinker's shrinkable and
> > >  * purgeable counts.
> > > @@ -1290,11 +1306,9 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > > 
> > > 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
> > > 	} else if (ttm_bo->defrag_old_tt) {
> > > -		struct xe_ttm_tt *old_xe_tt =
> > > -			container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
> > > -
> > > 		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
> > > -					       old_xe_tt->sg, handle_system_ccs);
> > > +					       ttm_bo->defrag_old_tt,
> > > +					       handle_system_ccs);
> > > 	} else {
> > > 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
> > > 					handle_system_ccs);
> > > diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> > > index 4186cb51af87..32211016a722 100644
> > > --- a/drivers/gpu/drm/xe/xe_bo.h
> > > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > > @@ -110,6 +110,7 @@ enum xe_madv_purgeable_state {
> > > };
> > > 
> > > struct sg_table;
> > > +struct ttm_tt;
> > > 
> > > struct xe_bo *xe_bo_alloc(void);
> > > void xe_bo_free(struct xe_bo *bo);
> > > @@ -547,6 +548,7 @@ void xe_bo_dev_init(struct xe_bo_dev *bo_device);
> > > void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
> > > 
> > > struct sg_table *xe_bo_sg(struct xe_bo *bo);
> > > +struct sg_table *xe_tt_sg(struct ttm_tt *tt);
> > > 
> > > /*
> > >  * xe_sg_segment_size() - Provides upper limit for sg segment size.
> > > diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> > > index 305c6e1942fb..9990a7144a9f 100644
> > > --- a/drivers/gpu/drm/xe/xe_migrate.c
> > > +++ b/drivers/gpu/drm/xe/xe_migrate.c
> > > @@ -811,6 +811,63 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
> > > 		emit_xy_fast_copy(gt, bb, src_ofs, dst_ofs, size, pitch);
> > > }
> > > 
> > > +/*
> > > + * emit_copy_chunks() - Emit the data blits for one defrag L0 chunk, skipping
> > > + * borrowed pages.
> > > + * @gt: The GT.
> > > + * @bb: The batch buffer to emit into, or NULL to only count the blits needed.
> > > + * @src_L0_ofs: GPU offset of the source pages mapped for this L0 chunk.
> > > + * @dst_L0_ofs: GPU offset of the destination pages mapped for this L0 chunk.
> > > + * @src_L0: Byte size of the L0 chunk (page aligned).
> > > + * @src_tt: Source (old) tt providing the page pointers.
> > > + * @dst_tt: Destination (new) tt providing the page pointers.
> > > + * @start_page: Page offset of this L0 chunk within the tt page arrays.
> > > + *
> > > + * A defragmentation move may harvest already beneficial-order chunks from the
> > > + * old tt, so the new tt references (borrows) some of the same physical pages.
> > > + * For those pages the source and destination GPU mappings alias the same
> > > + * memory and the data blit is a pointless self-copy. Walk the L0 chunk and
> > > + * only blit runs of pages that actually differ (src page != dst page),
> > > + * coalescing contiguous to-copy pages into a single blit.
> > > + *
> > > + * Return: The number of blits emitted (or that would be emitted when @bb is
> > > + * NULL).
> > > + */
> > > +static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
> > > +			    u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
> > > +			    struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
> > > +			    pgoff_t start_page)
> > > +{
> > 
> > emit_copy() doesn't have L0 in parameter names. Probably it is worth keeping
> > it consistent here also?
> > 
> 
> Sure.
> 
> > > +	u32 npages = src_L0 >> PAGE_SHIFT;
> > > +	u32 i = 0, nblits = 0;
> > > +
> > > +	while (i < npages) {
> > > +		u32 run = 0;
> > > +
> > > +		/* Skip a run of borrowed pages (src and dst alias). */
> > > +		if (src_tt->pages[start_page + i] ==
> > > +		    dst_tt->pages[start_page + i]) {
> > > +			i++;
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Coalesce a run of pages that actually need copying. */
> > > +		while (i + run < npages &&
> > > +		       src_tt->pages[start_page + i + run] !=
> > > +		       dst_tt->pages[start_page + i + run])
> > > +			run++;
> > > +
> > > +		if (bb)
> > > +			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
> > > +				  dst_L0_ofs + (u64)i * PAGE_SIZE,
> > > +				  run * PAGE_SIZE, XE_PAGE_SIZE);
> > > +		nblits++;
> > > +		i += run;
> > > +	}
> > > +
> > > +	return nblits;
> > > +}
> > 
> > Would it be good or possible to have similar counterpart for emit_copy_ccs()?
> >
> 
> I didn't do that as CCS ratio is 1/512 (iirc) of BO size thus not time
> critical. e.g., 1G buffer with a 32M defrag is 32M + 2M CCS copy.
> 

Actuaully I forgot a CCS version is required when the IOVA mapping is partial.

So this patch actually add this functionality but only flipped on when
the IOVA mappin is partial:

https://patchwork.freedesktop.org/patch/739373/?series=170216&rev=2

Matt

> > > +
> > > static u64 xe_migrate_batch_base(struct xe_migrate *m, bool usm)
> > > {
> > > 	return usm ? m->usm_batch_base_ofs : m->batch_base_ofs;
> > > @@ -865,13 +922,15 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
> > >  * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
> > >  * compression PAT index for the data copy.
> > >  * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
> > > - * two distinct page sets (old @src_sg pages -> new pages). The data blit is
> > > + * two distinct page sets (old @src_tt pages -> new pages). The data blit is
> > >  * skipped (the data was copied by the @defrag_copy pass) and both the source
> > >  * and destination data pages are mapped with the compression PAT so the aux
> > >  * state is copied indirect -> indirect.
> > >  * @defrag_copy: Defrag move pass that copies the data pages between two
> > > - * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
> > > - * aux state. The data pages are mapped without the compression PAT so the
> > > + * distinct page sets (old @src_tt pages -> new pages) without touching the CCS
> > > + * aux state. Pages the new tt borrowed from @src_tt (harvested already
> > > + * beneficial-order chunks) alias the same memory on both sides and are skipped.
> > > + * The data pages are mapped without the compression PAT so the
> > >  * (possibly compressed) bytes are copied verbatim rather than being
> > >  * decompressed and recompressed, and no CCS aux copy is appended; the aux
> > >  * state is migrated separately by the @defrag_ccs pass. The two passes need
> > > @@ -889,7 +948,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 					   struct xe_bo *dst_bo,
> > > 					   struct ttm_resource *src,
> > > 					   struct ttm_resource *dst,
> > > -					   struct sg_table *src_sg,
> > > +					   struct ttm_tt *src_tt,
> > > 					   struct xe_migrate_copy_flags flags)
> > > {
> > > 	struct xe_gt *gt = m->tile->primary_gt;
> > > @@ -914,6 +973,14 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 		!flags.defrag_copy;
> > > 	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
> > > 		!flags.defrag_ccs && !flags.defrag_copy;
> > > +	/*
> > > +	 * On the defrag data pass the new (destination) tt may have borrowed
> > > +	 * already beneficial-order pages from the old (source) tt, so skip the
> > > +	 * self-copy for any page they share. Compare the tt page arrays at the
> > > +	 * matching offset.
> > > +	 */
> > > +	struct ttm_tt *dst_tt = dst_bo->ttm.ttm;
> > > +	bool skip_borrowed = flags.defrag_copy && src_tt && dst_tt;
> > 
> > I think for our case src_tt and and dst_tt check is redundant here as they will
> > always be set for defrag_copy. May be add an assert instead of checking?
> > 
> 
> I think that right but will have to double check this true on HW.
> 
> Matt
> 
> > Niranjana
> > 
> > > 
> > > 	/*
> > > 	 * For decompression operation, always use the compression PAT index.
> > > @@ -926,7 +993,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 
> > > 	/*
> > > 	 * The defrag CCS pass migrates the aux state from the old pages
> > > -	 * (@src_sg) to the new pages with both sides accessed indirectly, so
> > > +	 * (@src_tt) to the new pages with both sides accessed indirectly, so
> > > 	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
> > > 	 */
> > > 
> > > @@ -938,7 +1005,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 		return ERR_PTR(-EINVAL);
> > > 
> > > 	if (!src_is_vram)
> > > -		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
> > > +		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo), 0, size, &src_it);
> > > 	else
> > > 		xe_res_first(src, 0, size, &src_it);
> > > 	if (!dst_is_vram)
> > > @@ -947,7 +1014,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 		xe_res_first(dst, 0, size, &dst_it);
> > > 
> > > 	if (copy_system_ccs)
> > > -		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
> > > +		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo),
> > > 				xe_bo_ccs_pages_start(src_bo),
> > > 				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> > > 				&ccs_it);
> > > @@ -961,6 +1028,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 		u64 ccs_ofs, ccs_size;
> > > 		u32 ccs_pt;
> > > 		u32 pte_flags;
> > > +		pgoff_t start_page = (xe_bo_size(src_bo) - size) >> PAGE_SHIFT;
> > > +		u32 ndata_blits = 1;
> > > 
> > > 		bool usm = xe->info.has_usm;
> > > 		u32 avail_pts = max_mem_transfer_per_pass(xe) / LEVEL0_PAGE_TABLE_ENCODE_SIZE;
> > > @@ -998,9 +1067,30 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 			xe_assert(xe, IS_ALIGNED(ccs_it.start, PAGE_SIZE));
> > > 		}
> > > 
> > > -		/* Add copy commands size here */
> > > +		/*
> > > +		 * Add copy commands size here. On the defrag data pass the blit
> > > +		 * is split into one command per run of non-borrowed pages, so
> > > +		 * size for the number of runs actually needed.
> > > +		 */
> > > +		if (skip_borrowed)
> > > +			ndata_blits = emit_copy_chunks(gt, NULL, 0, 0, src_L0,
> > > +						       src_tt, dst_tt, start_page);
> > > +
> > > +		/*
> > > +		 * If every page in this chunk was borrowed there is nothing to
> > > +		 * copy: don't build a batch or issue any GPU commands, just
> > > +		 * advance the cursors past the chunk. The non-vram tt cursors
> > > +		 * would otherwise be advanced by emit_pte().
> > > +		 */
> > > +		if (skip_borrowed && !ndata_blits) {
> > > +			xe_res_next(&src_it, src_L0);
> > > +			xe_res_next(&dst_it, src_L0);
> > > +			size -= src_L0;
> > > +			continue;
> > > +		}
> > > +
> > > 		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
> > > -			       emit_copy_cmd_len(xe)) +
> > > +			       ndata_blits * emit_copy_cmd_len(xe)) +
> > > 			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
> > > 
> > > 		bb = xe_bb_new(gt, batch_size, usm);
> > > @@ -1029,7 +1119,10 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
> > > 		update_idx = bb->len;
> > > 
> > > -		if (!flags.copy_only_ccs && !flags.defrag_ccs)
> > > +		if (skip_borrowed)
> > > +			emit_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0,
> > > +					 src_tt, dst_tt, start_page);
> > > +		else if (!flags.copy_only_ccs && !flags.defrag_ccs)
> > > 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
> > > 
> > > 		if (needs_ccs_emit)
> > > @@ -1088,6 +1181,14 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > 		return ERR_PTR(err);
> > > 	}
> > > 
> > > +	/*
> > > +	 * Every chunk of a defrag data pass may have been borrowed (nothing
> > > +	 * copied), leaving no job and a NULL fence. Hand back a signaled stub
> > > +	 * so callers always get a valid fence to wait on.
> > > +	 */
> > > +	if (!fence)
> > > +		return dma_fence_get_stub();
> > > +
> > > 	return fence;
> > > }
> > > 
> > > @@ -1129,18 +1230,21 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> > >  * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
> > >  * @src: The source TTM resource (the old backing).
> > >  * @dst: The dst TTM resource (the freshly reallocated backing).
> > > - * @src_sg: Scatter-gather table of the source (old) backing pages.
> > > + * @src_tt: The source (old) backing tt, providing both the scatter-gather
> > > + * table and page pointers of the old pages.
> > >  * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
> > >  *
> > >  * Used by the defrag path where a single BO has its backing reallocated at a
> > >  * more beneficial page order. The contents are relocated from the old pages
> > > - * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
> > > + * (@src_tt) to the new pages (the BO's current backing) entirely on the GPU,
> > >  * in up to two passes:
> > >  *
> > >  *  - Data pass (always): copy the data pages verbatim. The pages are mapped
> > >  *    without the compression PAT, so the (possibly compressed) bytes are copied
> > >  *    as-is rather than being decompressed and recompressed, and no CCS aux copy
> > > - *    is appended.
> > > + *    is appended. Pages the new backing borrowed from @src_tt (harvested
> > > + *    already beneficial-order chunks) alias the same memory on both sides and
> > > + *    are skipped.
> > >  *
> > >  *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
> > >  *    and new data pages are mapped with the compression PAT so the copy engine
> > > @@ -1159,11 +1263,11 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > > 					 struct xe_bo *bo,
> > > 					 struct ttm_resource *src,
> > > 					 struct ttm_resource *dst,
> > > -					 struct sg_table *src_sg,
> > > +					 struct ttm_tt *src_tt,
> > > 					 bool need_ccs)
> > > {
> > > 	struct dma_fence *fence2, *fence =
> > > -		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> > > +		__xe_migrate_copy(m, bo, bo, src, dst, src_tt,
> > > 				  (struct xe_migrate_copy_flags) {
> > > 					 .defrag_copy = true,
> > > 					 });
> > > @@ -1171,7 +1275,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > > 	if (IS_ERR(fence) || !need_ccs)
> > > 		return fence;
> > > 
> > > -	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> > > +	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
> > > 				   (struct xe_migrate_copy_flags) {
> > > 				   .defrag_ccs = true,
> > > 				   });
> > > diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
> > > index e4f996942a6d..4094ea1c19c1 100644
> > > --- a/drivers/gpu/drm/xe/xe_migrate.h
> > > +++ b/drivers/gpu/drm/xe/xe_migrate.h
> > > @@ -13,6 +13,7 @@ struct drm_pagemap_addr;
> > > struct iosys_map;
> > > struct sg_table;
> > > struct ttm_resource;
> > > +struct ttm_tt;
> > > 
> > > struct xe_bo;
> > > struct xe_gt;
> > > @@ -137,7 +138,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > > 					 struct xe_bo *bo,
> > > 					 struct ttm_resource *src,
> > > 					 struct ttm_resource *dst,
> > > -					 struct sg_table *src_sg,
> > > +					 struct ttm_tt *src_tt,
> > > 					 bool need_ccs);
> > > 
> > > struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> > > -- 
> > > 2.34.1
> > > 
