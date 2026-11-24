Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26C606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dhSlgQoM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gM9f64gD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F318E10F0D9;
	Tue, 24 Nov 2026 22:34:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A12E10E26A;
 Tue, 24 Nov 2026 22:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795559621; x=1827095621;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iUehM5WBP/88kRlYhfHpwc8ga0xEj0BInq9lNrlgLLk=;
 b=dhSlgQoMrAu7SbVJeYg4POAWQ/+kAB9W4DvxssOdnK+D1iqL8o+Y2D+W
 ZRAIUV3SCVryS3ArKTLIvaQNi3Ue4ws7wOjMNfxtxtJ5ZfWLAj/6bWjbr
 8i2uVflKgT9sRJ3GqHbog+6cgvzQPgRTRVZWfGD3DQ9pK0OvnTs41peKq
 9sOk+jj5I+tc0E2+eq6/TRU7VNoKrzMo4nVnzSks9AkW3Ywn3ulJhRw45
 Y8MhOL4G2TXfZ/eaoNREvvfvWySIMCmiJ8lsW5Zj9b/MAWvkioetlCLYu
 QowsbZM+04XNaWqeil5ybjnbkXt8/OppufVCB/qUrULQxcaTC8mcurb6i w==;
X-CSE-ConnectionGUID: /ceWdvJxTw21ZlXKgzYO2Q==
X-CSE-MsgGUID: 1y/7KOIhSUmnXmwAFG5S1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4412078"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4412078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:33:41 -0800
X-CSE-ConnectionGUID: sVsK1rwzQx+JH0M184db1w==
X-CSE-MsgGUID: tpOnZ6ZsRBW6E0ckZiy1ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11574485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:33:41 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 14:33:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 14:33:40 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 14:33:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSW6dppCRuW7dit7Dpu7BsZ1Ab8XdGX4bVQPNRj73IfSAlQTT+UA6qgzJ+HIxfflRnSSEkgEkIuhaFX4YtLPW7BsjswJwyI8gjPDyG0grkT6onFA4HIgScrS3J6JOy6gsboAVOpviV5mPfix2XhhxhYzSNAKkLITYpdzA6tKd+XFcYPJTK6DeWZ/9Jt4LIAHpML9MNdkn3XtnhPd0lWpxD4JJgW33gaOm45mFxzr5KLEMqwXA/Qld1UAZCrf26tRfVlYM9LtAcdETsZu/9ihTp/8i35UR7jP3x39OWM/MNKmue9aOdgrQ9Cs00E+pA0lu/mrWFv21o1tVZdurWSDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXA5f2ERIYJBZcHWFTdt+EDfPjILQnWs5R760Dail9k=;
 b=kQNKb1vW2UmtdMN0if0R93hetZqzW7uyWUvbd8WzvZlVz0zJGqvokcFLi1rYZFvB8ZozDsLstKxJm/GwRigjPbaXbpoNHPZ6owXMKRdeh/yPymqlUVHPHXgiE1aGxlb/ujL8ZRwAAVTZJY5jvkRlwI5LTFrjvt40jaGGwfo/0gRz/4qINVEalLegA4fXWn9Qh6zFOLvHzHZZtHTf0u5vREGml/9NNLlXYLp13A6OQDum0r9GbHamYqVB2OZ2ffY66TXGdJ3BnoxKc7HeO5+2Vk9ObJQV2Vd9N4Ju6GiK/l0QJC+ZzEJ2+CFxCj8KFPFJ6DnWv2lBVyjtzj8l5tislg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXA5f2ERIYJBZcHWFTdt+EDfPjILQnWs5R760Dail9k=;
 b=gM9f64gDDC1nuY6pNdGbU/Sc2TmbAaIYi6DgmUysgPZc7mumwN77kZ7LVNV+A3wyMlVcCNFlkMBSLnwGr3jvUnR4IcVF/dCA+ScmU4xmkm0YSzv4KnbELaAlcheGIDN+LoL2Kf74fz7w3zkDKZpyled4pxiF0bzBntQLd+d74p4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 22:33:38 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 22:33:38 +0000
Date: Tue, 24 Nov 2026 14:33:35 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <sanjay.kumar.yadav@intel.com>,
 <tejas.upadhyay@intel.com>, <daniel.charles@intel.com>
Subject: Re: [PATCH v3 2/3] drm/xe: Mark VMs as closing before queue cleanup
Message-ID: <awYQv/VS6uOZ9ls0@gsse-cloud1.jf.intel.com>
References: <20261116062804.1242511-1-arvind.yadav@intel.com>
 <20261116062804.1242511-3-arvind.yadav@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261116062804.1242511-3-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 884d7ea6-c339-4402-151d-08df4a7afb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261009223027099003|18002099003|22082099003|260925021311599003|260925022911599003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|260925021911599003|10067099003;
X-Microsoft-Antispam-Message-Info: UkJyE8a2ZNyLvEBHVIeAWx7wYG+Ir2tK0Vr+NEAzIbWWGGyRoHXsFkSFW2q+dbrMh6kblR74PZTUQv8Tb0yGgpwU9eIjlgLtO0C6OVqNOik+Z870emWO8BBmgmCEpwl88m1y5me4X6x/lpoUufZtebFnmvEmzWe3DQat17ql2+Evy8R9IdNzJVn7CxWcWLVuYVACEQw/xOaG4kmAgHj4qFslYawDA4K9gOniGyflZJYBpVzr1mxL8e1FpMqzNoFPa2pjLDLyeJmCbe5rez5Fm/of34+0pZGk+7Oxf8gd7WbUulbBivUMNdkYGDg7hy0HWoqpujJjoDlW1/JAyvVWlBOX2fkw4pcL0ngyTwckA7093ij6c1RX/BwzMlYUIjMed3rGUlI4Mz0gW1F0Fu1y/SBB91kHKVwmRxf11mzuS7wmKPIO74uB7zVbIRiwN0skC0L+0hhHWS9jMTkWbShdE9pxUzZS3cnp5W3+HjyJH7/4DaueHvZt3LCmrhPnZhIqSIiID1+O1f5gC+5h18Ry4Ad5KCAImoYVi+SWQhyPvT3ybioMi1b+Yxt/g9u/fVWXH3gowkwz1OHWItChMtOzrP43IkVaINYKgkiVEnc6JewAHTOW4jKfbZzjNV34hDE8VVHhKW4qM4Q7gtVuQLqF/n26yEnf0zOISt/AiuaH/us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261009223027099003)(18002099003)(22082099003)(260925021311599003)(260925022911599003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(260925021911599003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?z3Ki6+RkzLu57bJfi1hAPt71mO2YTTYGmgvPqWBYZ3SpMwDtsVKEpu6jiB?=
 =?iso-8859-1?Q?gNxpQkhzEQxTbCp1oIF6EdcwtSbU168grd478DBvUUmMKss2nssv7Pi/fz?=
 =?iso-8859-1?Q?X9a4Dw2GCRDoY3CXeDdRiVFmIZBFqu5lPVCO1Fx2iQhcRxt5IxNUR5RdFS?=
 =?iso-8859-1?Q?iKUAclJEryHlYoJyX7eqqIs1lKMosgUnFPQxNMXGL7K6Z9QMz2bTOWuzCl?=
 =?iso-8859-1?Q?QxOAt4zEPoGw91G/d1asM5kSGF/pQZbUlC60a7wgwqtDnTALBThghFuXBQ?=
 =?iso-8859-1?Q?isOX+nI9QR1AYP6LBX+ZZVjGOWUu6+riQ+7moyD683q976l6ucW7ar47Lz?=
 =?iso-8859-1?Q?Izg2wII86XO43YyEeNNxP53OHSdLplkiqWXs+mOtrPffUTH49XdrI90O8k?=
 =?iso-8859-1?Q?HOdPPSkmCYi/dtNXS4jaqJCDdwTCpZY5n6NgSM5jn7Y8Y38F+TLDY4vCuK?=
 =?iso-8859-1?Q?1dy2gNZXELBUk/8Y+7idY8vLNyqqzwK8NyXZkVrGVcVa6T4abao2chfYpS?=
 =?iso-8859-1?Q?q7QJxcvgNBBczt6Z6ICsPVktwxrYii6oZBtXhxn/1iNvE6lQM7KdL0B0vI?=
 =?iso-8859-1?Q?JpDyW+MuMpHccWPqcWI7cVXuAiwSiDmmatjakldiH0IslADAZXf5lYAkG8?=
 =?iso-8859-1?Q?1esDhTcMn4MgYMRP1qw2StD57dMa9vqmeLRdU7tnmH1SRdNOJuVVdkIDGC?=
 =?iso-8859-1?Q?oJZxsHkBaa6ZnA38adVs/1LPEqjA5dc7d64k23RSLKK3lckKmbMQRRvI1M?=
 =?iso-8859-1?Q?9ZXDsLlpUr/VhG8Kkml0JiCz9zUnO2AYht/H0uCDmLkz2UohKDig3eCYRF?=
 =?iso-8859-1?Q?XF/bQfIR/HdcR5pUhaFE6NYVniFdxoM3EoCVu5kca1L/KB3uC+9cHXz3Eg?=
 =?iso-8859-1?Q?Pe0Rueh00LXf7jzV5+kCaiQFcd/VH7mSiPG5EdtiLUIQ2Tmx4rjqd/FOEs?=
 =?iso-8859-1?Q?xWvm8zeDTwk3TD2+KBW4EM3qUVFN7rKqA6WXgAFQWWsCX0HEGA5MpO5nzA?=
 =?iso-8859-1?Q?d/0fZahrVVlJqtHaekhJQDcKkahQ2DkvqPdeaeVSqOHRo8OJoOU+2H4IYF?=
 =?iso-8859-1?Q?Mxv4XqjhiAbSaKu3WTrlV09pUmyoD9jOalewizh0WW/giOvyGBrPkIw6DR?=
 =?iso-8859-1?Q?Uk1Rn4vBCvcWVHEKUJHkp8dDXFwgE47ej9l8Bv2twNc0M26ovyMKl7Ym9O?=
 =?iso-8859-1?Q?nZz+sAUlonRsm6NL1kOkI2mlavIUTFylfZ5LBo4sRxZLkA2ilaqFlfPwsF?=
 =?iso-8859-1?Q?EUH4rTIawOd5K8HZ2nbsW/ZAOQi3rP+vRWZGhKP42zmG8dDSczm9aPiT2M?=
 =?iso-8859-1?Q?7gowPsJi7KgVpfmUb0Np/r7XszuUjyqW/PyJezSO7xmNYpbVR7LCA6HHGr?=
 =?iso-8859-1?Q?qvijXRZdZ542MBmieykP9VWvx4SiVRm4P6UlJKmN6+YhX3Hv0uR0fnIkAQ?=
 =?iso-8859-1?Q?YFJolo2Z+UorpuFx9XwxEyP8C6s8uLrTU66djWFWCwYJLdKofUcEkYFCAi?=
 =?iso-8859-1?Q?WyqG7M0RkDmjrZJ0fG4nA4TyVsxCv6eJqJKC/RrullvtOWPBVmO4sxql58?=
 =?iso-8859-1?Q?XJXKrH9rf2lKl4sSdKroltDGs5DuaQYt4qQ2rDpaCB78SZk+2eFM8MuQds?=
 =?iso-8859-1?Q?9KE1l1Zgdmh7oLRzlvkdmEpoLlx8MsEiedbGY4A062PqAHBBarvySNSrV5?=
 =?iso-8859-1?Q?aWtNaaHHisIPAVeZ3SeGeVrNCb+l8fCb2uVtGGirpozh3XOtIZPrCA8Y6i?=
 =?iso-8859-1?Q?a/S04W29msl2oUel2q7B+WcECSB5qtBeZgJvVkttXHg9p6hW+0CUZXgU/y?=
 =?iso-8859-1?Q?PJnAwESsxl3KspYsfm7krF4z+k31lkA=3D?=
X-Exchange-RoutingPolicyChecked: DhIQ2hEYtf2YgmpYRzVCWwg0EthndueMfvz4AYa9t/RM4/UJSU4D34sL4bFk0Q/lKHhrb6XX07y2G9G3S1PV22grIrW7IXLONstq+G4cW6/2tVOtw/ZEpGqWgVL4oVyx2oQRsX66QABW0AbihoI79+H/EB5/HaPUF1s9Iuhg0SdtO4xpmzBO8NCJGvQAaTAqgBH6Md2GEHiVzaZgydClkKrOjrcEz1TS565FS1SVbZfiH9coW9DV4FC6t1jsVeDN/Y09Og22BDlqCVfCSOsG4xPqJSbkQXINwLx4DsGyVuyoZKLB+k+NPDLzpIZPyOtQbbHmVxUtYuVfrX0g3QN/eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 884d7ea6-c339-4402-151d-08df4a7afb9e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 22:33:37.9262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXYAoXs8m2x0eAsS1VgitSRbFb8fTrDVerTW3MLSj6PBsVHTYFXORv93yR0I6AnaJi6+FCWAk9Qy2ASkc0baLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
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

On Mon, Nov 16, 2026 at 11:58:03AM +0530, Arvind Yadav wrote:
> Queue cleanup is asynchronous. VM work can still run while file close
> or VM destroy is stopping the queues.
> 
> Add a CLOSING state and set it before queue cleanup starts. Reject
> new exec, bind, rebind and page-fault work on closing VMs without
> removing their mappings yet.
> 
> Cached faults bypass xe_pagefault_service(), so also check VM state
> at the common acknowledgment path. Hold vm->lock for read through
> successful reply submission to serialize it with the closing
> transition. Invalidate the local cache when that check fails.
> 
> Keep vm->size valid so SVM invalidation can still drain existing
> mappings, but stop adding new SVM garbage-collector work once close
> starts. Also reject page faults on banned VMs.
> 
> v3:
> - Check VM state before replying to cached and chained faults (Tejas).
> - Hold vm->lock through successful reply submission and invalidate
>   the local cache when the VM lookup or state check fails. (Sashiko)
> - Report faults rejected by the final VM-state check. (Sashiko)
> - Preserve the original fault details when service replaces them with
>   the resolved range. (Sashiko)
> - Account for failed prefetches and invalidate the local cache on failure.
>   (Sashiko)
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Daniel Charles <daniel.charles@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Assisted-by: LLM
> Tested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device.c    |  4 ++
>  drivers/gpu/drm/xe/xe_pagefault.c | 87 ++++++++++++++++++++++++++-----

I really, really dislike the changes to xe_pagefault.c.

The code reads terribly. This will have to be reworked but in general
I'm confused why any changes are needed in xe_pagefault.c - can you
explain?

Matt 

>  drivers/gpu/drm/xe/xe_svm.c       |  3 +-
>  drivers/gpu/drm/xe/xe_vm.c        | 18 ++++++-
>  drivers/gpu/drm/xe/xe_vm.h        |  9 +++-
>  drivers/gpu/drm/xe/xe_vm_types.h  |  1 +
>  6 files changed, 105 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index f3c71f91c4a9..383afb2993a6 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -181,6 +181,10 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
>  
>  	guard(xe_pm_runtime)(xe);
>  
> +	/* Block new VM work before starting asynchronous queue teardown. */
> +	xa_for_each(&xef->vm.xa, idx, vm)
> +		xe_vm_close_start(vm);
> +
>  	/*
>  	 * No need for exec_queue.lock here as there is no contention for it
>  	 * when FD is closing as IOCTLs presumably can't be modifying the
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 98cce0f12b12..f70dadcf4bd8 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -291,7 +291,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>  
>  	down_read(&vm->lock);
>  
> -	if (xe_vm_is_closed(vm)) {
> +	if (xe_vm_is_closed_or_banned(vm)) {
>  		err = -ENOENT;
>  		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VM_CLOSED);
>  		goto unlock_vm;
> @@ -678,32 +678,37 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>  
>  	while (xe_pagefault_queue_pop(pf_queue, &pf, pf_work->id)) {
>  		const struct xe_pagefault_ops *ops = pf->producer.ops;
> +		struct xe_vm *ack_vm = NULL;
>  		void *private = pf->producer.private;
>  		struct xe_gt *gt = pf->gt;
>  		u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
> +		struct xe_pagefault original = {
> +			.gt = gt,
> +			.consumer = {
> +				.page_addr = pf->consumer.page_addr,
> +				.access_type = pf->consumer.access_type,
> +				.fault_type_level = pf->consumer.fault_type_level,
> +				.engine_class_instance =
> +					pf->consumer.engine_class_instance,
> +				.id = pf->consumer.id,
> +			},
> +			/* Error reporting uses the producer callback and message. */
> +			.producer = pf->producer,
> +		};
> +		struct xe_pagefault *report_pf = pf;
>  		int err = 0;
>  		bool invalidated = false;
> +		bool cache_hit = false;
>  
>  		/* Last fault same address, ack immediately */
>  		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
> -			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
> +			cache_hit = true;
>  			goto ack_fault;
>  		}
>  
>  		err = xe_pagefault_service(pf);
>  
> -		if (err) {
> -			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
> -				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
> -				xe_pagefault_cache_start_invalidate(cache_start);
> -				xe_pagefault_print(pf);
> -				xe_log_err_info(pf->gt, PAGEFAULT, err, "Unsuccessful response\n");
> -			} else {
> -				xe_gt_stats_incr(pf->gt, XE_GT_STATS_ID_INVALID_PREFETCH_PAGEFAULT_COUNT, 1);
> -				xe_gt_dbg(pf->gt, "Prefetch Fault response: Unsuccessful %pe\n",
> -					  ERR_PTR(err));
> -			}
> -		} else {
> +		if (!err) {
>  			/* Cache valid fault locally */
>  			cache_start = xe_pagefault_start_addr(pf);
>  			cache_end = xe_pagefault_end_addr(pf);
> @@ -711,6 +716,55 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>  		}
>  
>  ack_fault:
> +		/*
> +		 * Cache hits bypass fault service. Serialize successful replies
> +		 * with VM close, including replies to matching chained faults.
> +		 * Take vm->lock before ack_fault_begin() takes the CT lock and
> +		 * hold it until ack_fault_end() flushes the reply batch.
> +		 */
> +		if (!err) {
> +			/*
> +			 * Successful service may replace the fault fields with
> +			 * the resolved range. Use the original fields to report
> +			 * a failure detected here. Do not restore the live entry,
> +			 * which also contains queue state and chain links.
> +			 */
> +			report_pf = &original;
> +			ack_vm = xe_pagefault_asid_to_vm(report_pf, asid);
> +			if (IS_ERR(ack_vm)) {
> +				err = PTR_ERR(ack_vm);
> +				ack_vm = NULL;
> +			} else {
> +				down_read(&ack_vm->lock);
> +				if (xe_vm_is_closed_or_banned(ack_vm)) {
> +					xe_pagefault_set_error(report_pf,
> +							       XE_PAGEFAULT_ERROR_VM_CLOSED);
> +					err = -ENOENT;
> +					up_read(&ack_vm->lock);
> +					xe_vm_put(ack_vm);
> +					ack_vm = NULL;
> +				}
> +			}
> +		}
> +
> +		if (err) {
> +			xe_pagefault_cache_start_invalidate(cache_start);
> +			if (!(report_pf->consumer.access_type &
> +			      XE_PAGEFAULT_ACCESS_PREFETCH)) {
> +				xe_pagefault_save_to_vm(xe, report_pf);
> +				xe_pagefault_print(report_pf);
> +				xe_log_err_info(gt, PAGEFAULT, err,
> +						"Unsuccessful response\n");
> +			} else {
> +				xe_gt_stats_incr(gt,
> +						 XE_GT_STATS_ID_INVALID_PREFETCH_PAGEFAULT_COUNT, 1);
> +				xe_gt_dbg(gt, "Prefetch Fault response: Unsuccessful %pe\n",
> +					  ERR_PTR(err));
> +			}
> +		} else if (cache_hit) {
> +			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
> +		}
> +
>  		xe_assert(xe, pf->consumer.alloc_state ==
>  			  XE_PAGEFAULT_ALLOC_STATE_ACTIVE);
>  		xe_assert(xe, pf == pf_work->cache.pf);
> @@ -752,6 +806,11 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>  		}
>  		ops->ack_fault_end(private);
>  
> +		if (ack_vm) {
> +			up_read(&ack_vm->lock);
> +			xe_vm_put(ack_vm);
> +		}
> +
>  		if (time_after(jiffies, threshold)) {
>  			queue_work(xe->usm.pagefault_wq, w);
>  			break;
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index bc6902b5bf57..62ccb2fe6f8f 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -219,7 +219,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
>  
>  	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
>  			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
> -	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
> +	if (!xe_vm_is_closed(vm) && !xe_vm_is_closing(vm) &&
> +	    mmu_range->event == MMU_NOTIFY_UNMAP)
>  		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
>  						   mmu_range);
>  }
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 12afb3363e79..e6e53912448f 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1976,6 +1976,20 @@ static void xe_vm_close(struct xe_vm *vm)
>  		drm_dev_exit(idx);
>  }
>  
> +void xe_vm_close_start(struct xe_vm *vm)
> +{
> +	down_write(&vm->lock);
> +	if (xe_vm_in_fault_mode(vm))
> +		xe_svm_notifier_lock(vm);
> +
> +	/* Keep size valid so SVM invalidation still performs its full drain. */
> +	vm->flags |= XE_VM_FLAG_CLOSING;
> +
> +	if (xe_vm_in_fault_mode(vm))
> +		xe_svm_notifier_unlock(vm);
> +	up_write(&vm->lock);
> +}
> +
>  void xe_vm_close_and_put(struct xe_vm *vm)
>  {
>  	LIST_HEAD(contested);
> @@ -2273,8 +2287,10 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
>  		xa_erase(&xef->vm.xa, args->vm_id);
>  	mutex_unlock(&xef->vm.lock);
>  
> -	if (!err)
> +	if (!err) {
> +		xe_vm_close_start(vm);
>  		xe_vm_close_and_put(vm);
> +	}
>  
>  	return err;
>  }
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index b1c5f940bcc5..c90c9dc1351c 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -59,6 +59,11 @@ static inline bool xe_vm_is_closed(struct xe_vm *vm)
>  	return !vm->size;
>  }
>  
> +static inline bool xe_vm_is_closing(struct xe_vm *vm)
> +{
> +	return vm->flags & XE_VM_FLAG_CLOSING;
> +}
> +
>  static inline bool xe_vm_is_banned(struct xe_vm *vm)
>  {
>  	return vm->flags & XE_VM_FLAG_BANNED;
> @@ -67,7 +72,8 @@ static inline bool xe_vm_is_banned(struct xe_vm *vm)
>  static inline bool xe_vm_is_closed_or_banned(struct xe_vm *vm)
>  {
>  	lockdep_assert_held(&vm->lock);
> -	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm);
> +	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm) ||
> +		xe_vm_is_closing(vm);
>  }
>  
>  struct xe_vma *
> @@ -214,6 +220,7 @@ int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
>  			     struct drm_file *file);
>  
>  void xe_vm_close_and_put(struct xe_vm *vm);
> +void xe_vm_close_start(struct xe_vm *vm);
>  
>  static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
>  {
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index fb9305124679..6ca9ef9d0c0b 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -286,6 +286,7 @@ struct xe_vm {
>  #define XE_VM_FLAG_SET_TILE_ID(tile)	FIELD_PREP(GENMASK(7, 6), (tile)->id)
>  #define XE_VM_FLAG_GSC			BIT(8)
>  #define XE_VM_FLAG_NO_VM_OVERCOMMIT     BIT(9)
> +#define XE_VM_FLAG_CLOSING		BIT(10)
>  	unsigned long flags;
>  
>  	/**
> -- 
> 2.43.0
> 
