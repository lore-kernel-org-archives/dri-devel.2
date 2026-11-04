Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06730606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K+4kILrH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC68210F92F;
	Wed,  4 Nov 2026 01:44:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF5610F92F;
 Wed,  4 Nov 2026 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793756656; x=1825292656;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zVswipBBqZjcT/WHnuCmWOhyJZgy1CNxzPqHwSQcdao=;
 b=K+4kILrHxXjW+yPNbVslQMlG8XYw9hUsruQIe0i3Sbg/tu9RcIVLi2yC
 hoha1tV7dmQINNlhZ8Y6yC/3SRLJo924czcZYax08U7fq8NFQw4SwyRon
 Xj2ExoTY8UL8JtptDFyBP1jl6WYh8Y9paGi/CERvD7B52KKqrB1YYjKAK
 vGLwjTOyQhrPeNb+hQzxJs4LjsBO/OXYzLym/GMXVs72tN1kHpSJfEaLl
 92ULqjpFuwIki2enJC1qPZMF2I7L2I3zxbLjwNPKVEqAtxblv+sX5HdvY
 7/hcDCR97nZimteFCbMHwWVa4HkQpdmSZqBknjCeqz/LYK3ByVGgMx6vG w==;
X-CSE-ConnectionGUID: hZKgvMjITaO94aCf+lV06w==
X-CSE-MsgGUID: u06ks1hPS4auYUlQx2HObQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2375943"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2375943"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:44:16 -0800
X-CSE-ConnectionGUID: ymmyMSOHSFC/lHO13NdrDA==
X-CSE-MsgGUID: bu4fM4PASjuysklkUqb6kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6695977"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:44:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:44:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 17:44:15 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:44:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8WCJMM/mVo1kksUC5WjGCFIPRQw0VHnMjShIxgMw6FnbXLjYIjHcalurL7qbaIVT87tWncz1S8WxTlWaxMCzxS3Hai93SMdTMDCCSw0M55+msJEG9JEbxdPFJlg8bpKaYGPt1ZbUyrGaHc/t9c9485cLX0EoDy1UFmPth7Wu0YmD3MeTB/GOW/9qe20xOppclNhE7n4ByVScWrp9FYDm6pLkzuww1ZxE8wjJkSnAve0CoFXooCVB1A6T+16tcBICGnPWYCTBEsIFYlYtycpeW77rqpQP3UQuQkqtdgdGFIBGd0o2z2Q5W7e8j9Fj7V7Illl/86LQSZx0+2x2dn3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0vOt+C+d1GjQLR70TlGFH6OpB5E8X1Dv3Y7JpLekm8=;
 b=uIB5CjWlTVQWXDwY3D3VQiir7BfrbyZPxHomXRbQm+FZfj3jDvxSaWCoaSneb6GoXYgySup2XrrSiNRbH7IzhP2HYSd97WJap88vUpYLFC5AeDhpYfQQrmvW+wVox3/KsGPlrfoIBlTTih2SxkPfmqX5/UUh4RRx3SVcljvSIT3rey3nY8v2BFZ1HvbCgwZDDxxqTNFYfhfEZYouj7KpwWV6uLzC53aPNgSCbRb1akZ4MkmDakvMi2yuShmhmQ5zcuSeobDdu9fPQKfcS8oaHixgD4m1WRV2a7Ko2G0hPCygKU3s3InlkIW6e54URqUO18vZOTohxrXbZEyeP1se5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 01:44:13 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 01:44:13 +0000
Date: Tue, 3 Nov 2026 17:44:10 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 14/33] drm/xe: Destroy page tables after unlinking all
 VMAs on VM close
Message-ID: <auqN6iTlYUvPKKNJ@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-15-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20260711025619.2540575-15-matthew.brost@intel.com>
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CO1PR11MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ee2b60-588e-477c-d559-08df3a15208b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021123027099003|4143699003|11063799006|261009223027099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261102123227099003|261026140227099003|261028144727099003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ozeUAQ3rwcMDaK1Qh60VFOdHA0lNlhp8BzwkiO3qq65NfQaLjGNERi00XUUKRRQEQAPiqRtKk5qliMn38QnigKt4WZrBS2UH2duFHbF5mO4X7sfPR1cng7qRPGBgeSYQhI3zcrAQU9sWjBvuttoBuWpXrupuUcQCpRjO9z+K4NRsC1W+V+xyq1HG6zc+ETPXHW5kQKAKgdyyDXcTsoRxym7W0Hb9wzwbZ1wn8nzGTSoyxWNWPdtExkJbwNr6F68wXmTkOBMYyeVebScwGvr5dCjF9ng8u8QX8+v6dFk0xdTTdjkYiFUuaPcXJ/LAa+DXJyqPJoychmS/tkinabeGWQp+jOcQhi92A853//93bOYqsjp8GzMNioBeTs3bJaSzh0lyVKtWaTpGzYEYdMTmYv8EouCOgWBCmacH6KIxqaaTeVFIxrVk9qLX2x5G7R+vJ1N9fs6kxJVGhwUae1oplwMCrwSrPIPLVCRB0OFDai1L7D70ksICVn3UbkS4SyBEYNSwLRgyE77kCvu9YcGKIRNf5U9LCi+tRffqn7wQDMk1e1VY+Ue6FMJ6lt0H+a/dJnf2GHssRq1LqTrg1RYwOV5yKYx9gU/HwmcTN6Did4adxmlR3Cu7M2gdUuOjdxzJ/AX/mRWMK/DJWmB08NfaL3teKNWOcyBLqSKAWcpHHcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021123027099003)(4143699003)(11063799006)(261009223027099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/tgXCPiNvsKJC2dnaS9TByzd4Kj7VxhDY7Ug2HHM7XKykR/t7D5exUwEnMx?=
 =?us-ascii?Q?G+vHZTngGbwpF51RYC8HC09yZqKesSRr2wPhJiSSnprhopo4DikN0wpfFikm?=
 =?us-ascii?Q?3p2/jzOaIPCtsp1YUSLIS8bHkbqaQKeGlarj0OBKB9WjQ9wLwXZkMO/UTfwM?=
 =?us-ascii?Q?ed5Inq/6jJK9xfYntEX0ZVi+xxwS7/sL7Obw0Pn2eNuFL0An6xOjfSefXmlv?=
 =?us-ascii?Q?KRMEcxFPfrFRkwsYFMVcufDiBhmS8oVIIxrrlaOov4ZprrZRM7VuTRGO6Lty?=
 =?us-ascii?Q?cPP7/dLKuMi/nv+8aH8IAtx8AF8czIEFmXz02vSsES0WnM3Z73RdgCRZBTMq?=
 =?us-ascii?Q?HTP559tSXIDYLUqqE0mAFeH+0pQwyAxRB54OcQrOGa8XzF7ZsBANhZ/5Zcqs?=
 =?us-ascii?Q?nTd5qEMoPznNNBqQjaGY4tPQDwxRMi659fhWJdt6roa9Jgsve8v2zPBwyxZW?=
 =?us-ascii?Q?gzb0Ua57Qaf7HNRKJQt/uXqXpbLY3M3y4wFsybp7Xis6hIWF19SfJhlrAa4I?=
 =?us-ascii?Q?9pRvt/whxYXvK2vxPHGBGKxVuWApSlUrs89BmkCLiZnW5qCdBd79ZdQjQI3A?=
 =?us-ascii?Q?ca8tRW/DLm/8UdsbN5z4PuQDyxTVBeGkAjFbro2jUK1Zz9BclfxX6BirtxKM?=
 =?us-ascii?Q?NZFTb1bpHK0VR3Y89doE74+xJruASr1UtF9QTX8XYIum8EWuzAhsHzrCMibS?=
 =?us-ascii?Q?VZ1W93gsJPCCBuM4NO1g1t/p4eC0cmALZfX4BdbdS9DqJu58Wrm7+FfTdD6i?=
 =?us-ascii?Q?rdEkEIilimi5NuG8uxepn5wXaFBaZS2jC9gtYOZ3Tu/uMPjnjw+yxq3vihTC?=
 =?us-ascii?Q?2Cz9TcG/hjCEVj7SZu2LxiJ1d6iIkwDAvaxw6Yc29WlKA8Dnapm3mZwNBngE?=
 =?us-ascii?Q?i+cKCCNDGEW+8ucI6gBGZBAmbB/Areljf8Dtp57gg3fQZd1MjGImu70B4Ju6?=
 =?us-ascii?Q?UNmoaYu0KmmbNUZCmblFYj2zE9n7o7UY+sj7Ylq8qY8+kaTEZFaxkQOLBCV5?=
 =?us-ascii?Q?9RbfJpmUg9BIXFIdQPVSYAbV0nBWfGwTmfhe7XHR40jyZFLIZ+4iZLFleQug?=
 =?us-ascii?Q?PQbTwm/eLWiZu1MMopjR8yRlWWyKNwkairzukbjR+1OGNS9j8xZ5Ridt1xAt?=
 =?us-ascii?Q?KyGmEyTNNDQQ2GX5YanzoQcAp8Mz5Saa1Ys9yE4A0kRvy9bk/iz433R1lRFJ?=
 =?us-ascii?Q?MskhHv2ravxo2HWd2n/ozw7eLZCDK/4St0RW7JZP4utunNP9I3dGWBvJSxXk?=
 =?us-ascii?Q?W0RaQ9lLlHuzIDvE9CPskgQ5O5wdIryQGZn3S9cZnwOBealDTURMEWO9eE50?=
 =?us-ascii?Q?kKPypqfUt8xy9Mqkhhx0fIpnAiQ0P4nMDQwZModSgiCx66XcifnZKYEpF3Mx?=
 =?us-ascii?Q?Bu3hsBXzS/3vSqHkff3j9y+u0tQ4pLnHvOoHPraHnO2UAK/UKhw6NOIMFl6/?=
 =?us-ascii?Q?CHz52S9MZXgRzU69PDoCmws+6kSPURtXJNDJxx+XMTXR3EYiQ51x4p/Z9QP8?=
 =?us-ascii?Q?72/+LNHnV+0VLLrKFpzWfehRJNEDR2i9xdtcQ9Kv7Jtj53SH3yIerb8ecvjx?=
 =?us-ascii?Q?VMj+qkL5SxzSvW1xt3Q66GXuW2S2AwlxtRPgDOxJWB8/XN3RpZHsJvZ+UhG7?=
 =?us-ascii?Q?8YmO1loAi51meYePxZ/F8DfTrlU6JIWgZSG/3rAa9gSaE9FcSn1yvdkdFaLi?=
 =?us-ascii?Q?th726Q7m4jxRvwKUcMm0c90aqT7VIALH5AI3UMWnqKgPSBAEgkJDIyNnJ16B?=
 =?us-ascii?Q?qSn1aqDY3pYV6BZUwhHxZnlCApwckceF6QMVljuH3S1tfQdz2fw8?=
X-Exchange-RoutingPolicyChecked: Yc3HHoJFST9rTY0QsI0eGu+as+j+WWlm2ia82/41bgf2x36ISe3X3Tt94QLi81d5PYgu6bhNEZM8UmMs43ISZWa5MhEou60XkZuVaOVwdUATuBvbhzI9ncGY/aAx1xkiz/hOhRUco0wXUmcN3/6ZYLS85J3AlOfsl8fAYfusEv9vFh7E7S/ZI+0AcrLzujzKvJomZwTJ3lmKN+6cKE2Ujqf+IyywscR4P6JCOE5pula2N9F8H/ouN7mUuC8uq4f2KaTvrbkfjXojRXmUIcRDsiliqPGQ/oT840z7+2NweEUt9lsgwcaAKTc/RIe0LvclwOKKZRkAn3mhFoLvDmP2iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ee2b60-588e-477c-d559-08df3a15208b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 01:44:13.3337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlXBWu+Joti9lYI4EO/h1ffIHNCFF3BsqXrAPjLtED7htDtPQiYs7zV3iW14KpC94eJlABS2R8lVjTy9rIiFYDo/CemsgK0STV0T3na2MlEUe1YD91eebaeiaDeP30Zo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
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

On Fri, Jul 10, 2026 at 07:56:00PM -0700, Matthew Brost wrote:
>xe_vm_close_and_put() freed the VM's page-table roots via
>xe_vm_pt_destroy() before destroying the "contested" VMAs - those backed
>by external (shared) BOs, which are deferred to xe_vma_destroy_unlocked()
>because unlinking them requires taking the external BO's dma-resv lock
>(via drm_exec), not vm->lock.
>
>Until such a VMA is unlinked it remains reachable from its BO through
>drm_gem_for_each_gpuvm_bo(). A concurrent BO move that only holds the
>BO's dma-resv lock - TTM eviction, the shrinker, or the defrag worker -
>calls xe_bo_move_notify() -> xe_bo_trigger_rebind() ->
>xe_vm_invalidate_vma() -> xe_pt_zap_ptes(), which dereferences
>vm->pt_root[tile->id]. With the page tables already freed this is a
>use-after-free / NULL dereference, e.g.:
>
>  Oops: general protection fault [...] kernel NULL pointer dereference
>  RIP: xe_pt_zap_ptes+0x7c [xe]
>  Call Trace:
>   xe_vm_invalidate_vma_submit+0x64/0x130 [xe]
>   xe_vm_invalidate_vma+0x27/0x60 [xe]
>   xe_bo_move_notify+0x1e7/0x3d0 [xe]
>   xe_bo_move+0x62d/0x1620 [xe]
>   ttm_bo_handle_move_mem+0x243/0x330 [ttm]
>   ttm_bo_validate+0xb4/0x1a0 [ttm]
>
>The race is not closable with a flag or a NULL pt_root check in the
>invalidate path: the freeing side holds only vm->lock while the walker
>holds only the BO's resv, so there is no common lock to serialise on.
>
>Fix the ordering instead: destroy the page tables only after every VMA -
>including the contested external-BO VMAs - has been unlinked. Once the
>contested loop completes no BO can reach a VMA of this VM, so freeing the
>page tables (under vm->lock, to satisfy xe_vm_assert_held()) is safe.
>xe_vm_free_scratch() still runs before the free as it reads
>pt_root[]->level.
>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Looks like this change is already merged with below commit
"drm/xe/vm: nuke PTs only after unlinking contested VMAs"

So, needs to be dropped in this series.

Niranjana

>---
> drivers/gpu/drm/xe/xe_vm.c | 24 ++++++++++++++++--------
> 1 file changed, 16 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>index 4557a8a4d270..9f55d22cb985 100644
>--- a/drivers/gpu/drm/xe/xe_vm.c
>+++ b/drivers/gpu/drm/xe/xe_vm.c
>@@ -1934,15 +1934,7 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> 		vma->gpuva.flags |= XE_VMA_DESTROYED;
> 	}
>
>-	/*
>-	 * All vm operations will add shared fences to resv.
>-	 * The only exception is eviction for a shared object,
>-	 * but even so, the unbind when evicted would still
>-	 * install a fence to resv. Hence it's safe to
>-	 * destroy the pagetables immediately.
>-	 */
> 	xe_vm_free_scratch(vm);
>-	xe_vm_pt_destroy(vm);
> 	xe_vm_unlock(vm);
>
> 	/*
>@@ -1956,6 +1948,22 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> 		xe_vma_destroy_unlocked(vma);
> 	}
>
>+	/*
>+	 * Destroy the page tables only after every VMA has been unlinked. The
>+	 * contested (external-BO) VMAs above are unlinked from their BO under
>+	 * the BO's dma-resv lock, not vm->lock, so they can still be reached
>+	 * via drm_gem_for_each_gpuvm_bo() by a concurrent BO move (eviction,
>+	 * shrinker or the defrag worker) that only holds the BO's resv. Such a
>+	 * move calls xe_vm_invalidate_vma() -> xe_pt_zap_ptes(), which
>+	 * dereferences vm->pt_root[]; freeing the page tables while those VMAs
>+	 * are still linked is a use-after-free. All vm operations add shared
>+	 * fences to the resv (eviction of a shared object still installs an
>+	 * unbind fence), so no GPU work outlives this point.
>+	 */
>+	xe_vm_lock(vm, false);
>+	xe_vm_pt_destroy(vm);
>+	xe_vm_unlock(vm);
>+
> 	xe_svm_fini(vm);
>
> 	up_write(&vm->lock);
>-- 
>2.34.1
>
