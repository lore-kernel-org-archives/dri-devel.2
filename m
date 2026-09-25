Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2804C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259AC10E116;
	Fri, 25 Sep 2026 18:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IE3k7n0t";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA9110E116
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790359979; x=1821895979;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YgENZVczTTjU8KGSK6meaCEsOqTPTEc76QlyRFSeywM=;
 b=IE3k7n0tyCZffGQPzsr95PjmslL+4BmAbaKNWc6wtLqv7P5pWbLqbfsI
 io2hlxh+G4qIV24EfANE1PLUl/AGHlFyoi2VMyVtOFPM9tk736XsUXpnJ
 jQUWGdJnEROdCZU4iehu5RNntDyZr+1nYWaPpYK5hjf6hA+05GFy1vy6u
 keQz0EBr2fK+lyWWNTPSjHw4oaZXy0pIM5A5jgeSS7ZZEinFsO5RmMDRQ
 tZJXVyrB/j6L6z59OEQHSHDbfO4xIYdhCV8KDiLm/3i1NYbwYW6dcqB64
 WocyS11v8aSR2B69Fl+LXh2TPc3Ca7QQf/+UISRI4CAjOaE5f5nMuBs0O w==;
X-CSE-ConnectionGUID: i9J+uBeYQFynuErNnPHLQA==
X-CSE-MsgGUID: vUFpixBnRu+TYJ8TR+FYxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="78711986"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="78711986"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 11:12:58 -0700
X-CSE-ConnectionGUID: tJm0tG9HRu+F2rUVxfrtnA==
X-CSE-MsgGUID: c6qoZjrSSt+JOu8CeUSYVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="279113399"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 11:12:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 11:12:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 11:12:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 11:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6+53/i6IburKnO5rS6NTsVZnyTfQXc0yWtFehOwHqQP97a8OiltKwyH/FfNAdRRpECyCMdYFqZsCWw2+CKjVEiclEwCuxfpxC/KENEcleckzC8+ANNm0IoIkNawc9GM5jYgvfKeyi8p/xyL9KJB5FoB7mXhfAptklVEBA2dVvXL9lu6vr7bV5NdnQKMie2xrCcqbiemSzvDGCXkQ9yUNzwQ5Do/AmiiJzqEtfUOFqZwrHJbxPIgIDUQwNoV1I0+RBqJv9HUIZmlpYEPeZ7NsWia2oRoOdCFij/A8eRwWjhOlOhI1F8I7EB9HVGcYh4ptaoR7A0ZEzsK3tJhYfIBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAlmy3gTuT44JoCsIjeGJfPD6oqCvQPLdLPJfTFtOso=;
 b=waMOjDu7DEmQ64/U+EBbD4t1f9bIOejfodkWAMBP4OyFGevdKkpdSxeKnYQ9u+HMGum09kQiERwaAOdpa17hC799GQ/ZaiC2Rd+ADPWrK0lV2AlZ1TCUPoZHISMX70RwDO1+9VdFnKHCo4J8pIAq05mjWNPcN0R7c83ZsB+ZMNYWoGgxUx6GvJJbMS8Lcya4ABU8umcfh49aEsRqWYBidIBLpqmyL1R+3+Oavmxj9HgNUSKjtP3JJiYUZFxVzQeNWFUK7QYaPqwq0v1w6x7H2GN4xSVFgr1Otr9HupuTJQXC9+DWGy/1sK6Lqhp39u8xe5+cCR7OisXp1m+PPQk6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:12:48 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:12:48 +0000
Date: Fri, 25 Sep 2026 14:12:25 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Sinyuk <ksinyuk@kernel.org>, <dri-devel@lists.freedesktop.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Francois Dugast
 <francois.dugast@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ilia Levi
 <ilia.levi@intel.com>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <ara5iTl7bmgWbPW9@intel.com>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260921131911.532d81f4@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921131911.532d81f4@kernel.org>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SN7PR11MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 80446e72-dc39-4857-0364-08df1b309a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: gw6lyc0G4SXfiSY7yhQgHlO/eSqw4p4TMgHF4rgspx07eKSQGhdL7YBBpyhtMO0Qns/QCkHdcBwPAHJTnWduEhz7mm9NIC4jhlB5tlKY7V6vQhAFHcJ/0D7B/KF/ueaRf+zfgVqjpDlfl89iqxB1hduV+ScQHb+y2Ve87KT7wdZThZFv2shbQM0FIzwAt66saOsxy5RScYnqrsI9QJbuLw0L5S3iqrDxu0NQHru7e9PeBUlgI1ZWHvTjHWRProTQDpxFFd0nVIatP4GsJLbbztu85CXd4O5xPPUjBkzisKUqZxDihITNnbuTpxP3RbtMxgwXwipk3RcHp0z8uKpqlEE8bh7f2YLNPVvYH/SQAOtZx1qJUxz5ghi6BgNTEO5lQdpi1GAVKQNqcD/9yC9S86yqUZYw7zGhcrVIzFomBdRpTNHHH9W0G64g4IlvVsCyCyLTEdxXfJIhgspAyltoPjkyB0q35d7m3ZZCkINHqxAsZaqwXsJnADl7ajz7mz18ixorplgUyeatYC1TmdRBMdbLI78pMiY7TWZDymXT8Pnzy2Qa54noZfdBGEbfURMxKhqxleq/Gtxn//pFHxLqP8WELY4JXoczcOV70LRyhSr+rt7Pd2O5R5Q6yUo8NL5XwxWF4sTkwsOp/yIxqDXLFi+nJtRmkxRh5kkNsssUVzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NWMT6u/rH5jLioUs1h0Syk742qVeFUmC6HWM69fX1ZFxKj9ITF3qcY1mJOv?=
 =?us-ascii?Q?rUinlB/6jWUn2SpS8idmnvX8iI9yowSwTP81VLSqlYb2fmvx+9bbZSzU64kU?=
 =?us-ascii?Q?GQgdyudEBO2HpH8ioXdPmm1JFV+lTdO89ReNjeixoCpztP1mCvQEVI6Yuren?=
 =?us-ascii?Q?pUxKFf7vAexjuD6Cf/M+QwgSJvQkC2xLeuP3tTbrqgcexQSpGxxMStSZK6l3?=
 =?us-ascii?Q?tDpQ+P9LoskWuOag5iOWG8wFQTIHFiQ7TIMtSU43D4ZagthRkVxe7QLt2/4w?=
 =?us-ascii?Q?sRHBWvEaH8hVjKB7UhcR0AFUABm9X2O70N02nvthoUoRxI4UGunChUdRGBYA?=
 =?us-ascii?Q?/gCZgPCqTeUimF21YJwSt/QR6IoWCTwO1MheE+xflMT3ResMp+Vz+LNtoxkE?=
 =?us-ascii?Q?WVwRWbYNrQtbMSneYWiRiNaeSyKEBF4gSAo9LpCDOH2VRJ5fpJQ/4KZDurjN?=
 =?us-ascii?Q?zAc5e3ctfprUtJX5G6PoCydOgASeL5bwKwJj3/pIi81Se9NYWjkeg2Zm9VKp?=
 =?us-ascii?Q?04p1fQ+ddgx+PZiBKvnSxY9MUSaHMbAfizj8jbWoyKltCYOmk2YkaDcyW5LZ?=
 =?us-ascii?Q?+NmMR9ftUT2eMYUxAtvk/wNNPkpLO1ex9RC1tvhqX4477vFrD4uMN/dgCKjY?=
 =?us-ascii?Q?PP+//FRJZ7n/6rlL5TuxSh4UxIDUtB/P0EitQpFgward6RYSNU4AEgUUyL5Z?=
 =?us-ascii?Q?/Ia+93R/CeZmhHR0r/iOtbblLCvn6K35McJb1ruYQkMczVvTYALJD4Zv0KMm?=
 =?us-ascii?Q?iOBc38cEPLn2+v1JcfDxbWGqDPKghic/FOGRBtRR1lNQLAJmRUD7WAcbuEFy?=
 =?us-ascii?Q?srqsz3IMy9CbhDS0QkcgIOmwrZkxiCwvkF7rE6nJZnBfRQRw1bryXxNeGFTR?=
 =?us-ascii?Q?OO/chhkWwzXWaQddN4wle2EYmL2O7JNPTGvfAcNNI40ZRwnFvw+k4f4QZkPx?=
 =?us-ascii?Q?MFE5NwE7JMWlGMgG9LpKp4FpNZjt/y2h5mQ8mKoqZXQpoUf6NT14EWAeWIIj?=
 =?us-ascii?Q?3CurP6Y07w4ICp19E6PTAaQDkotFsysbLYayxaORGB4+RzRTMm1KmEtdCnno?=
 =?us-ascii?Q?OV5JcRyfW52YsuvyMbP/x0kI+W1A5ODvkMQzBRquVrusJ5o+JRHeEmjDVvwT?=
 =?us-ascii?Q?Nah25FX0gFka7Uod9N1l4g9aFUAfj/SmuejSPQBxDCwvfJMSB0b9UP45NREc?=
 =?us-ascii?Q?0pv3zpvLN7I+UyiFPB49Gc9mVpL4ffh+8zqHtga2uI67v/fQ7KK+fmfbmfHV?=
 =?us-ascii?Q?vA6Q+y1UpGBcp5Zdej4igZMWQiNnDDc7f4MdvjEV86L8uvRxTFkskCysRQXZ?=
 =?us-ascii?Q?+r5WYA70TlLZeLyLehENo1fKsNLLwXjy2kyTS6UlZZJ32v2bQIHvfFq3n3yE?=
 =?us-ascii?Q?gcEDqYwggY5Il34AUGokpYWfMHTQtBB1RAeInnuf8P3Fk6XO9PZwdS4ecIuJ?=
 =?us-ascii?Q?RZsIYWqPKx9diWN40utBxdrpTySEfnmkv3PolMZgHjs98n9g6VdET9aOdE3I?=
 =?us-ascii?Q?DCvGwga3vxIaWRaTzGs7SX2bT+8pfUIP5UwQQWKMaTvAFup/YYWM+BBjRgZP?=
 =?us-ascii?Q?aUKD2Ev35PjKkNa2WN/KeenqIJ9FZrPtPRQQx9WwPw6Ua/R8hlQwdOJ7oJ/B?=
 =?us-ascii?Q?mnDrACY+L/dQRUrqMAkzXXquR8XDgwZ1LDKqpP9lsePlq5O/aGvcoeKiPuHT?=
 =?us-ascii?Q?iwqx7MGT5lyqp0R8/+IZlYzz3+4W/WMqPtXZechWATB/yZgC/FqYvnEDZ3GH?=
 =?us-ascii?Q?yjJMmc1G/A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1SkpQC73U6h94CNz8WXHnpR67cyWY1xol/6ViZGx52u/8UR+mIKs0DfGu1ORNprv/bZJNha5/jPBFSWIadVBF0LT8QJKgPuNjnBAC7qla+0//J7tIvjFbJfBQVrAeVOoOS6nZhAO+T0wB7Afu+6Fvy3v8VAX9I/71a21wOUhJOvsIeZlGpCDMppQVnK3EDMW/InoQeq5Ir3WgnxWgUq0UrG3dOXBFf4Or1PCaf329Vt/qvoGuDTnpy4S7fXi3+I0Em864LW7qmmSvh6cehvHc1qaWVSIAg82VZU6Hp2IkVLkRU+9k+PdO+NFLl5QHKv9F5FhR4K3P4N4v1PqrOlWvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80446e72-dc39-4857-0364-08df1b309a6a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:12:47.9846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TPKXxYV3/uyeL/g5qnJ0uSNEFNWICxofyQ3aXDyQWHg9aXeSmuOuOfR2mxP1O7M+28ViX4gfcsbd2ykcndnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
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

On Mon, Sep 21, 2026 at 01:19:11PM -0700, Jakub Kicinski wrote:
> On Mon, 24 Aug 2026 11:09:28 +0300 Konstantin Sinyuk wrote:
> >   2. Are the Generic Netlink semantics, including dump consistency,
> >      notifications and optional port statistics, aligned with YNL
> >      expectations?
> 
> > 39 files changed, 13189 insertions(+)
> 
> Networking is absolutely flooded with AI generated patches.
> Including long term contributors excreting huge unreviewed
> code dumps :/ We have absolutely no time to help other subsystems.
> Please do not use Netlink going forward, sorry.

Hi Jakub,

I do understand the feeling here :(

But I do hope that you reconsider your position here. We had such a great
experience with the drm-ras using the netlink and I was really hoping that
we could just reproduce the same experience here.

Netlink is such an incredible API.

Would it help if I take the maintainership of this drm-fabric netlink
along with the drm-ras one, ensuring the same consistent and clean usage?

Thanks,
Rodrigo.

