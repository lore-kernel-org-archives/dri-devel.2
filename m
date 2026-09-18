Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B9FC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC1710E41A;
	Fri, 18 Sep 2026 22:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NQQxehK/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E437610E1A1;
 Fri, 18 Sep 2026 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789771305; x=1821307305;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fwaErSavfgt1MZTR0fUmFIjh4nx/yThmyinqfPBR4lI=;
 b=NQQxehK/dakZVe45Ju1/7l6Z58HCUGjX82+kmIfw1iR84PRzcqnki2/V
 Vspbe4RCs2wVFOq7ebm6kK/NZAp1r1hiwKRy4X3qH5fnh9pvTm84AmGus
 n0us3p7lAwPKt96ixYHdItfTHf5VX4nAf2s0S4Q8XyW7X//R4Tc9PH6oG
 UsgETmCcTqnuHuvL1p5Sq9eTEUZAyORaiSXFF9AjnlbPH2rEMbDAC2y6j
 SJBeaQGxHsxRHCrHN6S0qNXjl5mad9ARSLJusvxOnncDJWWf2vysIp09p
 CUJr9jaOkT6csMRyuxh11toAfOGU0agKLUvECluN0HOZYjJRspftPn4Db w==;
X-CSE-ConnectionGUID: deFNAIPKQQewS0LiIOUeEg==
X-CSE-MsgGUID: sXT3bCPYT4C4kcu+4qEgnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="107810934"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="107810934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:41:45 -0700
X-CSE-ConnectionGUID: OvrmzTuhRleUs9re7cIxlw==
X-CSE-MsgGUID: Tag8cHzTRziNM6+KjM9wiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="271271415"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:41:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:41:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 15:41:44 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7tq7ht+n9C1cBr6iOrK2hjXuYmBsqsiz7H7SIra4ufYB0do2pHbD5YIb+0IOkBLP0RKt/rTxMyq0l8Aod0b6eKVKKG/LlItvYWONhfIUZwvIE0nCXo3LfnQF6hkVJ/x64st81Ssi4Z12VT3q+ER+kO5dAy1l6pNld2QtVqEhw9TK/CNyeFPusqmA4izFyemyp5gwIuwPk1QrdPQ0nO0aiwm+AxxUMov8kIQOoDHDQweeuctEJVSPzq1IKQZgFxS6qutf32ArqZzkO9HgQLWkM8t43w3hHqT9lcRBAq2gBWodBAXGtxXk+tBLwOpXActrgi3nvHDBfFdhgdYfXeCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPDeNFbpWMCHgLljT5wTGFDBtI/rDwjGtumu5lhTLdo=;
 b=C4qKLSZIL6wuN/3O+ixtZ0snLR8/sbfnqQ9YlpFd/dTYkQ/NOPAY5lEDiW+lKTrZIQvpUydxLygO/9xAiQRa/pdEuWraODJrv/u9DSHZ9FdNPoTGQ99n4oyM2IT96/0lPBQS5d5pvOvhX6NIKyLAaOEzAKFKPg2RXgvwSgR/+dwDsBrDVRJ1ZGRr4KDCE9JOKARZspfGIXfIvCc/6jqxzr0IGoAb45ah3vszVjGQHmut21/Wwsll2R1dDYmlWe0VphYZjkjJg0GHfYs8Ztv7LFyqx6qg55FOmkViAbjaEpJlpCC/2CDdfuu+RTsj73hZKwRsMIYA3i8Y89xL6HljYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 22:41:36 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 22:41:36 +0000
Date: Fri, 18 Sep 2026 15:41:34 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Arvind Yadav <arvind.yadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH 1/5] drm/xe: Hold a device reference across deferred VM
 destruction
Message-ID: <aq2+HkGwXhv4UUlp@gsse-cloud1.jf.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-2-arvind.yadav@intel.com>
 <aqyueX3xWoVJ6P8b@gsse-cloud1.jf.intel.com>
 <2b196d015b37329cd6eda25c565c83c5e5f77a7f.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b196d015b37329cd6eda25c565c83c5e5f77a7f.camel@linux.intel.com>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: cc30135c-6cf5-43f9-d079-08df15d5ff3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|6133799003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K7EST24JnVM72PzPYMYrZnp9KbHF64/LvRT+aw3tEjuNmJyO/NlKiHh513dO7rirVBvaNDJ79zp/xH08CP7f8B0Z+1tgs2q/PRXblcT7Y4OIghKnlmQ25EWnUbQI6vFcvcXzXazwh/MzF1me68Z/JPhmkQmjiBvltEtkgd2MqSP+8jk9fGJSWkNjt4mOSFbPcb5xxt81vizB8UdroWQxnh0QLidhx9lNsd2Dxk5pzjYFBAY+2xjor9zBHSblwUFL+Ha7Bw9fY24iKsVusg9FnH2NcYafURT+jWtjLS4mgf0XII32G3DR4/hbAOaPMXCGuYoMdHVliUWjH60XY9UKWhcVeGF5M64DeWjZARhpebj5C3zcyP0BLSGMwACzC2/slJeYwktMlPw7AJ/LD8EZyfrAh9WVFg5v0PyMotVfOd/n/n0SHfrHqMWqhG6kyd4ohleiAKgCs/cfjTqHXODxxPNr5SGc5nSYojnBBJblkK5QtMEpKGu2yCI2tcDaBEnt7Bm6mFGhaB5YFnFJaa1cEuyIyiAHNMuqlDSRVWEnFPZwrO37+wD3rKPYlLZ2XSGcfOZIjbyyRnkUGWrOrjiiMn+HcL2tXyeP7ZF5vebqnwcMfIUQeTQqhIVQLUv0lRI3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gp921PeDw80tRqQlaCpbB+8FPTLYVZ7zaNch9bHaLNu/m22bYC0czyQrAe?=
 =?iso-8859-1?Q?NUFGplC7I2a5XPbDYkqUkaSe53a2aPkXbNgNVqSn9sbP/zV6FgYNtRRF4l?=
 =?iso-8859-1?Q?qAKZp477CS9oGderg8vEc3rvBLs+DWSuqmr2IghDrlWmj0vT05HpWnpb4n?=
 =?iso-8859-1?Q?ZbxRg2j3nQMwg1f0807YSqVCDetNZ/HfKmAooat3yIfezeCTFF5Gol6wR3?=
 =?iso-8859-1?Q?bNdfk/vLe/i1gVLFlbTnS/a+bO1imC6hHMddvkWp5Lf0I0g7XeMmCUoMHy?=
 =?iso-8859-1?Q?8BKwG1+y5lgTVyLbiCwG443hZwcR6pP+Ja/on/uAHggvpJaqujehuq2yOz?=
 =?iso-8859-1?Q?mJgIH9F9He3YwMeRuc++baASj4Q3ItBvHaZaeJIt9oZkQ6Jf2XMol1IPit?=
 =?iso-8859-1?Q?J6MMZS1VoEuVadUE7OlxcFNG+Vjc7HykV7UuZXq2KJTIGuUBy6HEzn8nYP?=
 =?iso-8859-1?Q?z6/a5+IVWlGPKUsQ7/nb0FdX8KZYXQ12rNH34tg/0Dmcei2YzTGdLqaisW?=
 =?iso-8859-1?Q?SZBTQYeMbnfUBVhy0qTFpQ1DeG+ZQNCTxtpI/F2YMXroNv1oNCc1nwwB7w?=
 =?iso-8859-1?Q?nGPkz5u+gvu4AMRUP8zVQ5kEfwdpYST8s+D+kecSQCVZmDCI4yyx4OmLZQ?=
 =?iso-8859-1?Q?T7hK9CdZNBpquPmTYavlM1FCEO1WwsX8byVFY1rmbyqSMqkDZUNyxAVe0Z?=
 =?iso-8859-1?Q?e5WnJVyyOHUnA5I97tuNbglW7kSiabUKtHX/godEyJDuw3oTSJ6oEqgBQR?=
 =?iso-8859-1?Q?5Gh7XW4KzzF5EBYP9pLu14AJIJEtGf9q0dRvX5xGOlGTaqGmCdxLAqJOl4?=
 =?iso-8859-1?Q?ahEGf3gKLMXs+zrY6OwxtTOY9lA9/Mdb+jVFC+oCkAP0A0/YEq6ntgtZUv?=
 =?iso-8859-1?Q?+uck37QjzbBFLmOR1S2u/tKgzcPUuxowZoRuGRthPp476bLp0FjZaf1K7s?=
 =?iso-8859-1?Q?gv/q6RxhG7swnp3ICvoQy/P3sI+CIsA0BSQI3+cgH1/dm5lI/oc7vbd1pX?=
 =?iso-8859-1?Q?ciswd4rZaT6N2uTeBdlmf5oeSzB2Id2zejSjovJSCGgZSQo6PWvrlQuzeK?=
 =?iso-8859-1?Q?VKu/QN5yJfk4MZ3fs7a6dWiYQHJmd+RUtiMhex88a29JRXKpQZ+G6a2FiQ?=
 =?iso-8859-1?Q?Z7XvlaqFeiVKTQRktTGPXSm/xEWcTbrXc6NZVZnTwZoS/nIEjXYx7AbmZf?=
 =?iso-8859-1?Q?s3D7D/VcZT7DphzLVTmh/Dg5ETgbcYfzzdL+YoyP1zHVoW+kfU9HUK1pH1?=
 =?iso-8859-1?Q?KuWPIxk9UAK/nhPg/5+B+C3M93qT7DoSQCWj5la0lw0U0FTTPunPxYtaPD?=
 =?iso-8859-1?Q?tcy3cwBTLeM1I2s/+ivus7QVRJPexR4jcD4Ds12Id0mhLEphB+orYGqoPX?=
 =?iso-8859-1?Q?Ixap+xGuMvx2Lvi/QspGyr+lTNQQtX/JM6MWC3YzKWs594V7oyIEhbWk9J?=
 =?iso-8859-1?Q?Tmo1/pObGsFVcLTEAzS88+PBVY0pY41iNyDsJYr+HH0n10ht2qLWBmdgih?=
 =?iso-8859-1?Q?XbqAS9wcltSP/hSNvB9yeenOVGOflnxRq9c5a40uI/xxXfthxpfLFl3dfs?=
 =?iso-8859-1?Q?mRmjZ6SLSK8L9Tz0i1dY6Eo60Ff6yjajuHefccWg2yRXln/vIzUBHeIoaL?=
 =?iso-8859-1?Q?IM2jH/Igz22/4AYcP7HQVb+df8qCR4Z6L5OxRB22UxxS+ttv7jAIXjpKsK?=
 =?iso-8859-1?Q?rlqo1D6K/vq8QxwkqZnj5t522Gep4s8c7XoYfi8YxlPK/5QXPNlcCa6xsN?=
 =?iso-8859-1?Q?uFX5l8VC6kQoqtLlRhoFdXzHT3RlSLjGAAmbIo4L8mqHnRl5hyN0OFzWCF?=
 =?iso-8859-1?Q?59L6HdprvotgWLjfV36e94La4UiD9pM=3D?=
X-Exchange-RoutingPolicyChecked: y8PR/85/30M1fYzkWzFfMAu+gfGv0f+CFnJ380PhwGxj71VwkBhZA1CLnc2Z6fDJfFxo8Yuy5SpAzJivgD4+6CPNzBSVTOw0r2vSyM0EVQo6ud2Ikeq2H8uZlQ8k70LrCpCI/F/lpA3EV8SlrBlyXKbeWXFIRkeP/EVrxjzEurBv/YbRWxSjOYWALSvX4XnL3ii6tUiqgw6wWIJOwMZuKoo15as90g2u4xt0t/uioRmCFisfLqNuJj+2mmoSjNss0Ui6b21OhMnDItV1GuBfgpAbbXgUJ4tsySMfzELNXWvALgc+3sAN+1w164vrzS8pAxWFk/iBFc8QOK9ISRxpUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc30135c-6cf5-43f9-d079-08df15d5ff3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 22:41:36.5888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvKBNtNhhyORRDkZrjCGXFFR8tDqafInWxk8xryspNWO6HUmGybB46KYcU1SenaHhyIvThTKq53f0XYiN6/fzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
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

On Fri, Sep 18, 2026 at 09:22:53AM +0200, Thomas Hellström wrote:
> On Thu, 2026-09-17 at 20:22 -0700, Matthew Brost wrote:
> > On Wed, Sep 16, 2026 at 03:23:33PM +0530, Arvind Yadav wrote:
> > > xe_vm_free() is the drm_gpuvm vm_free callback. It hands the final
> > > teardown to vm_destroy_work_func() on a workqueue and returns.
> > > 
> > > drm_gpuvm_free() drops its device reference immediately after the
> > > callback returns:
> > > 
> > > 	gpuvm->ops->vm_free(gpuvm);
> > > 	drm_dev_put(drm);
> > > 
> > > vm_destroy_work_func() then keeps using device state:
> > > xe_pm_runtime_put()
> > > for an LR mode VM, ttm_lru_bulk_move_fini() on xe->ttm, and the
> > > tile
> > > iteration. If the freed VM held the last device reference, the work
> > > runs
> > > against a released xe_device.
> > > 
> > > Take a device reference in xe_vm_free() and drop it once
> > > vm_destroy_work_func() has finished using the device.
> > > 
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > 
> > This is a fix, IMO. Ideally, we should probably push the delayed-
> > destroy
> > semantics into gpuvm if they are really needed. I'm also questioning
> > whether the VM destroy worker is actually required. This dates back
> > to
> > the very early days of Xe, and I doubt we've ever revisited whether
> > it
> > is necessary.
> > 
> > Let's follow up with one of the following:
> > - Introduce async destroy in gpuvm and have it own the
> > drm_dev_get/put.
> > - Drop delayed destroy entirely in Xe.
> 
> We need to keep in mind that the drm file keeps a reference on the Xe
> module. So once the last close() callback has executed, the module can

Yikes, so drm_dev_get won't prevent the module from unloading? Different
issue, right?

> typically be unloaded, causing execution UAF. It's therefore not really
> recommended to keep file-related structures around with a refcount
> after close.
> 
> Device references however typically don't necessarily keep the module
> pinned. I had a series to fix this for xe only, (Got stalled) [1], but
> in general we should be careful about leaking that assumption into DRM
> code.
> 

So what is the fix here? I believe gpuvm has a drm_dev_ ref and it async
teardown which breaks drm_dev_ assumption. I don't see an issue with
this patch or my suggest follow up.

> [1] https://patchwork.freedesktop.org/series/163298/

Should we push on this? I don't really see an issue with series as long
as 'rmmod xe' works if display isn't holding a module ref.

Matt

> 
> Thanks,
> Thomas
> 
> 
> > 
> > As a temporary fix that can be backported, this looks good to me, so
> > with a Fixes tag:
> > 
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_vm.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > b/drivers/gpu/drm/xe/xe_vm.c
> > > index efa5ff6cc823..264bdab75de2 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -2054,12 +2054,21 @@ static void vm_destroy_work_func(struct
> > > work_struct *w)
> > >  		xe_file_put(vm->xef);
> > >  
> > >  	kfree(vm);
> > > +
> > > +	drm_dev_put(&xe->drm);
> > >  }
> > >  
> > >  static void xe_vm_free(struct drm_gpuvm *gpuvm)
> > >  {
> > >  	struct xe_vm *vm = container_of(gpuvm, struct xe_vm,
> > > gpuvm);
> > >  
> > > +	/*
> > > +	 * drm_gpuvm drops its device reference as soon as this
> > > callback
> > > +	 * returns, but vm_destroy_work_func() still uses device
> > > state. Hold a
> > > +	 * reference across the deferred work.
> > > +	 */
> > > +	drm_dev_get(&vm->xe->drm);
> > > +
> > >  	/* To destroy the VM we need to be able to sleep */
> > >  	queue_work(system_dfl_wq, &vm->destroy_work);
> > >  }
> > > -- 
> > > 2.43.0
> > > 
