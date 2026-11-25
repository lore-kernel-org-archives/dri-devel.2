Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A9606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EFYU6n6z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k4prtWpy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42BD10FC47;
	Wed, 25 Nov 2026 18:35:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6B010FC47;
 Wed, 25 Nov 2026 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795631715; x=1827167715;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6OcgSp26b2ZPEoQzcVQyHsrgbOgD+NwCHfbDzOqDyy4=;
 b=EFYU6n6z9yLMZ51YUu5LAuyXQE4uEZL+HeaxFt6q+Ykys7424S4BdUwC
 SiSceta7Pr8l2wVZOkTpNQfo30g07YB9eUrXAdbGM3YEQ+YaoYtnNKNmN
 FP6pEc0N7Y2+MhBu1tkJPKHcH0NBNKaSYGcCOMSGv61UFRofVeoGd7+lO
 2VOEw5nGFdB0eg8E6fmV0oKPD51L3r7XZw98GEZly4QCZKAvBANcmnzPo
 KD/N9cpBuK0l/IEz+PmGnowCU+zGo8pgZed8Jy0VPiWDEKUbBHjsCPesy
 /TbuaxZW8sokzolk4jjxyOytd6DtmWx4ge/IGbtQBM1mMyHR8Hnwdq1CE Q==;
X-CSE-ConnectionGUID: R9/ayEz6Si6jNqGxZmNVIA==
X-CSE-MsgGUID: 2vD8eJdjQ6eKWeyiYF86sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4423638"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4423638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 09:30:42 -0800
X-CSE-ConnectionGUID: KldmS83ZTR2wjk6tKeDCng==
X-CSE-MsgGUID: xXTIEkRZTem6xC1N9COiyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12359809"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 09:30:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 09:30:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 09:30:41 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 09:30:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOdD8HI3zdZYxasBPXhvEO5NzIfgkn6iAgJC59glIzgEPFTdlcmB9sZ7DDgctLNW/h8tjMtpZnnnrtmZpkkN8XGmmOEAw/27p58rqoEfnXzfqEd95TOH2F/aY4SNWXP0aQq18ae63TVNWPSbrBlr6m+AZESJJ0/xg0w5nARClGFUyaPWkb+Vf//5ltU1lBWXlWHcOLyVvpt8/Ftbn7PyFbi7ZBn0+fVsg/UP5Bl6jJZzID8bw/dVZ5TATDQv0Bl5OUnFe5nN9HH4A3pL31NWyJHjoVuQW7jgtSdqe3YvRz47w8dWoT6uy0vnJyHef0RldzcGOAgnT0xHPfNY76+1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLzRwyeBykoIVsxxn9uk0/B/QtNBOnzGjfGTcxDQ/6k=;
 b=Lu6NDwvJplhKcjETicZg4ZoP/pgD3sYusNTcn+julyiLR/+raP3FpjAQEoWXBnMvEKx97yEkVyQ5y5NtlHORSLSVbmJG1bgcJ5hoI7boCCo9P+dHKzwtJ6CYVzCRHQXVIUSf7O+rG1iW+hB1Nn0La0JmxpbcXx3niijpWkfT52N27GJ9SzYqEpwaVp+Quyzf0q02s8+JhB8yY/aT0GkGE2DYX8J9JSIzSnyk8fkSYDo1Go6HhEKZRz5lkdIqF3oqeM3LrJNLixPc1QFCzF5mGVMXVam2+3iCocLXQzpSAkRg/nHCLuBeR1EavkSL/M/WgUSwZkvAi0XaNZ/LbHlbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLzRwyeBykoIVsxxn9uk0/B/QtNBOnzGjfGTcxDQ/6k=;
 b=k4prtWpySELpOjJR9MKyS276GhVlpQ21QtrbYF3brLwXEBdADEciPb7ABjFYzACOiOkQsIaWNPUEcMucl8TdFO3Cqdix0TyCVPeux6Os1kEax8d0cjlGwVVJcz8zpe4qDKtP9SbDDkNxLHPs8PPKSI3Ip8xu99G0kU+fpRUlKUc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 17:30:39 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:30:39 +0000
Date: Wed, 25 Nov 2026 09:30:37 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <tejas.upadhyay@intel.com>
Subject: Re: [PATCH] drm/xe/vm: Cancel pending rebind work before freeing the
 VM
Message-ID: <awcbPRYPCeNHsRGL@gsse-cloud1.jf.intel.com>
References: <20261125100744.1440957-1-arvind.yadav@intel.com>
 <awcK/Q6SifMWJNR1@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awcK/Q6SifMWJNR1@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CO1PR11MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe411cf-d916-4668-dfec-08df4b19d2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|4143699003|261021135927099003|56012099006|261021121427099003|11063799006|261028144727099003|261009223027099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: EqBvFv3dYbwwJTvWHzG0k2ZbF4m7O2cgWyNtMulVU3DV1Dq+kOGlZQFebc23vr97MkGOg4d3gF6VI7YLWrZPjm5zsMbNcElXyU4bJG1LfdGIfZ58lcdY+RgfAhe/iQWaZLbEmsAVdN9r3+0/EoPWX5TDCgjkVNxdBs0hDjE+g9v2NS7wAtsNp7ZiPKKaCaGzq0PmKk6ZW91+0K42poAJ7w90U9fx8wTaj9q64PjcaAkUiVs+ZCGq/zUCE3lmNRsxs5RvHyiFgvP6nKCFfwL0omMSGwkJmVq9UESAbulYNT4rHr97LYhvA+SgkCoWK2oqzabyZF+PRaW8nPWrgdF7RukW73dHSVwOtQBt+AWa8ZpOSepYtTngDLm3ifFEt9IYp3rczkjPHjQz9GRFxPoQ7ixfZO8aBXoKDc/WNoxEqw0hps+GTzSNP8wCdcNg0/G3ZeZlA98gvnmSRlMoDgCAQ/nSF6xzuQZcIR231fRwkjpnYUZMR7+yGLB5vFBDhOcEV/4+I9DbmgOZPKxLxmlxGKaM++3KVoqpohS+xtT82qOL/HF73ZZTxl8CyZnMmOIB4F6nzw3OgJOuwkBKTQ6S4ju5uzpnP6Jwy82pxEg9R//qwh2X9/MYP4dFbWT+BCLek2BbLy0Aw/p02/ZVzbWUxnriqnvwOsZllqrFMNVPVyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(4143699003)(261021135927099003)(56012099006)(261021121427099003)(11063799006)(261028144727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Werm2Ja/iTssLxXU1NQQWp0LPO/kFX/YvQ8d4NPU5dtStLKjxp67m4O7B5?=
 =?iso-8859-1?Q?bUcvx1saOoTgskGo9gOLy4w6iwx/fRwKAPhnbrJH5HkdkW0oWEzi+vsHHd?=
 =?iso-8859-1?Q?TvVt6UggPkZv0ZpWuDJfzwyNI6ZHUOtiw+p0DiXVRC2exxTjT5QXpeiA+s?=
 =?iso-8859-1?Q?3nxUzNMw0sZ5HH6p4YGgjMjgPrjQaCmR59/xnEtpz87czNH3nSGpaUuy/E?=
 =?iso-8859-1?Q?zxJC7tfMj6SmXlm8SV/+KZNhBEb9vON3mctuRbbZBzvHjauRbF5wu74lgn?=
 =?iso-8859-1?Q?v/soxSYLH0ObM2sj29waafjhG/KSX/ryKix8WvCkWb0gdDa3pheL1hXrUE?=
 =?iso-8859-1?Q?YVzyW6CP/xbtF7OvH3cQobXP5XwFOI1Njhn0XFfQEhPmug3Po6EdwFXA8D?=
 =?iso-8859-1?Q?Q9dbmhTQJe93EdUWC7+e1FHZMEM7ixnyMHi6UzkMxjxtx85HUKiHxfiN2y?=
 =?iso-8859-1?Q?9PCvMX2tBXrdLSDQnwJMfmuKIQ/JAmUcJmkuFHlqzUPQ3dz2Q2vOWG5FtW?=
 =?iso-8859-1?Q?W+/jekQ8WinHhbfeCiSHooAed+v9QowXWrC9F9VmK4qnlQNmpMu5uszxzx?=
 =?iso-8859-1?Q?RxvIOL62u/MtWnn3itKEzOzXI+1Fd7Ew6vEbtSlWFH29dOsXlOH0T58e7O?=
 =?iso-8859-1?Q?796/pAVRiz3GJUftTMFm4fZjHLepUoADc3VrHABS8tCgCA3RhhPaA0yHAh?=
 =?iso-8859-1?Q?3KQwaM83qHNrIpGaCse0nAVodYFvyzaZ6tu/gB9GqsmYddgkOTH0ukFji1?=
 =?iso-8859-1?Q?srqgiBWbPvOlLM04ex8cyX3eevGgk7cPr4eit47sLzYtj61DZYqH0bKyRf?=
 =?iso-8859-1?Q?cIiIBAYfPSTVvt6fqKBcbjrePU04dyfa9ABrYqMQqroNTNmLnGtagO5W7l?=
 =?iso-8859-1?Q?iI7mY1jI46rPDKD5Mtq/X6dA7P3lWF19uWsEaOV3YcVNN8UkJp/iJ8FXM4?=
 =?iso-8859-1?Q?/2xvziHLp2KoGIUaxvqV1xEtq6jpiFU23WeekOde4DH8qSEuLOyxkW64fl?=
 =?iso-8859-1?Q?r5rRxt/tX4O/pKxIb9yt/SNtKmfqxpMuBo1t/FJhyPH30VtKRx/YIvI0ct?=
 =?iso-8859-1?Q?CwJYdE/luUFtlUkNKetJrhOkg90lAFpG6qLbnk8839KNpfpZz6HPnY7lxu?=
 =?iso-8859-1?Q?APrb49/gqVR0PAdGgWU4dmB8TlV1ZR2133GzMgmVtxQI9+HI1O+xFlavDA?=
 =?iso-8859-1?Q?k7EMNVAxzI3J6J1E9O2s1xCkuntVyPDhL2ULwU3qCttzZ8nOQtHWEb02FK?=
 =?iso-8859-1?Q?w+AZ7dsAn8EH/dlcZ2CvlMqrwDfQwSOZoEc5l5SkOduK3UnMY8YGSYrZIZ?=
 =?iso-8859-1?Q?5GhIq6BMlWavTOKzJPH89j1eeJmZOKwscDJAcEWrSRWpoLm6cUAKfdBiCJ?=
 =?iso-8859-1?Q?mj16bWuInCmP6QBf4RZAmSs4/d5H48rYxYf8JBCx6z5l+FFP+xSlG8g7Xb?=
 =?iso-8859-1?Q?91LrSaoDa4MOFR6jmYVVei7HYUYs04cJcNR63Gtq1g2DZlrO4eacoHJkKz?=
 =?iso-8859-1?Q?YApPmIuV4FFCnUnM82k4sffDimt3Wh1pCapRQ/3Q6yz+dgzFAvPMFlEu5o?=
 =?iso-8859-1?Q?g+25lg2Snj7gWHr1mS5/kEAZZ8F+Bvm/UEyCInnUYLT70b+zL2ae3PNHFY?=
 =?iso-8859-1?Q?++bLcrk2mVTF7HDGye7kn2TDu2bSE3jAupHYk1hlgt7ADj5j+TzXwuxmg0?=
 =?iso-8859-1?Q?d9u8QmOQGF9U62sOK4aA/lLy34ib+cjyNj6bTF1WiBR2NuVPinYs+YWSDP?=
 =?iso-8859-1?Q?lE+EV4wfBIqnNyw2IsmIYC6v4osRF8W+bTloEmImLE7/iIvlf+RM7G+ta4?=
 =?iso-8859-1?Q?US5Xk+P7LPnZJ+GOuWzIrOA3X3JWo2U=3D?=
X-Exchange-RoutingPolicyChecked: IQINz6hJBmEpPJqfp+6Ng5ECqhHGNoNT6NqooXg0Zhn5RUjZ27GzQ20JORWR98sEakF/fEDmT+HCOo/WFZYtTEEZdUM3D8QUC8rwioAvTatywFKLRh2Bwf4Hzyn6Yi0MSV6hfjMa76e5yEwpeKZdHb5Up5x6z9sTjAyqB4UhG11glmG02FIGQBgbzrS7hkJkzgY1yxx9Fr0VXQAzFNiR71dmltjt86TjfFOOIBmNcLREy+2b9LfDOX0dvzwl57kS5PjTDBkSx3jXIBjb+qsa5hNZ3cC0sNHqEMHHVPWtwDeVPgukjSACD9PvxWYIkDpe1U4eXZ1YhFOLRgoOtlPfng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe411cf-d916-4668-dfec-08df4b19d2d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:30:39.4387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fMg94IWz5aCrG46R2+Q9gdpR8XX/bQn06oNPyAVF19h+2rkrpzM/3onWO9O5hhQutk2qZolCRzbLziXdJB+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
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

On Wed, Nov 25, 2026 at 08:21:17AM -0800, Matthew Brost wrote:
> On Wed, Nov 25, 2026 at 03:37:44PM +0530, Arvind Yadav wrote:
> > vm_destroy_work_func() runs on xe->destroy_wq and flushes rebind work
> > on xe->ordered_wq. The destroy queue has WQ_MEM_RECLAIM, but the
> > ordered queue has no rescuer. The kernel warns because this wait can
> > stall memory reclaim.
> > 
> > The VM is already closed, so a pending rebind would return immediately.
> > Use cancel_work_sync() to cancel pending work and wait for a running
> > rebind to finish before freeing the VM.
> > 
> > [  727.067318] ------------[ cut here ]------------
> > [  727.067552] workqueue: WQ_MEM_RECLAIM xe-destroy-wq:vm_destroy_work_func [xe] is flushing !WQ_MEM_RECLAIM xe-ordered-wq:preempt_rebind_work_func [xe]

I didn't read the stack trace, but this patch, or switching to
disable_work_sync(), probably won't help.
cancel_work_sync()/disable_work_sync() can still block if the rebind
workqueue is running, and I think the same warning would still appear
(though I'm not 100% sure)/

Maybe the better question is why xe-destroy-wq is marked with
WQ_MEM_RECLAIM. Sure, it frees memory, but it isn't in the DMA-fencing
path, which I think is the actual hard requirement for marking a
workqueue with WQ_MEM_RECLAIM. So perhaps we should just drop
WQ_MEM_RECLAIM from xe-destroy-wq?

Also, I think s/flush_work()/disable_work_sync()/ is technically still
the right code change, but I wouldn't consider it a fix.

Matt

> > [  727.067726] WARNING: kernel/workqueue.c:4043 at check_flush_dependency.part.0+0xd9/0x110, CPU#1: kworker/1:0/33641
> > [  727.067876] Workqueue: xe-destroy-wq vm_destroy_work_func [xe]
> > [  727.067963] Call Trace:
> > [  727.067964]  <TASK>
> > [  727.067967]  __flush_work+0x44b/0x660
> > [  727.067970]  ? __lock_acquire+0x584/0x29c0
> > [  727.067974]  ? lock_is_held_type+0xa3/0x130
> > [  727.067980]  flush_work+0x28/0x40
> > [  727.067982]  vm_destroy_work_func+0x1a9/0x350 [xe]
> > [  727.068061]  ? lock_release+0xd0/0x2c0
> > [  727.068065]  process_one_work+0x2ad/0x890
> > [  727.068071]  worker_thread+0x200/0x3f0
> > [  727.068074]  ? __pfx_worker_thread+0x10/0x10
> > [  727.068077]  kthread+0x113/0x150
> > [  727.068079]  ? __pfx_kthread+0x10/0x10
> > [  727.068081]  ret_from_fork+0x3bf/0x470
> > [  727.068085]  ? __pfx_kthread+0x10/0x10
> > [  727.068087]  ret_from_fork_asm+0x1a/0x30
> > [  727.068096]  </TASK>
> > [  727.068108] ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 61e18525023a ("drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_vm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index dd855876f571..2ba99c083db8 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -2091,7 +2091,7 @@ static void vm_destroy_work_func(struct work_struct *w)
> >  	xe_assert(xe, !vm->size);
> >  
> >  	if (xe_vm_in_preempt_fence_mode(vm))
> > -		flush_work(&vm->preempt.rebind_work);
> > +		cancel_work_sync(&vm->preempt.rebind_work);
> 
> disable_work_sync ?
> 
> Matt
> 
> >  
> >  	mutex_destroy(&vm->snap_mutex);
> >  
> > -- 
> > 2.43.0
> > 
