Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7760CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E03A10E3AD;
	Tue,  6 Oct 2026 13:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iAJVq+Fd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D94410E3AD;
 Tue,  6 Oct 2026 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791292639; x=1822828639;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0GLA4yWImMsRq/Awpf4QYjFLuvEEobTHqHFu7j1G+70=;
 b=iAJVq+FdT1geHPsNTRx3IeqiyEVhhuG6xE/AZlEHW2XMUQ2df4l1gm6o
 orkyATcBYLTI//q4ukMcvXeZ6ZsGIlaLgJt4SvElqvKuy8a5P/6GI1Bzn
 txWIuwA/AL05ps4QkaL2NJH5duILs6ZBOA/0Whi/c8Gv5Ds6QTywY1IzM
 b4FyuV/KRGO5mMAfkTP44XT0ftlWbytn1yU8zfc/M/hqEq8qmSwRwOdN4
 BovsUrnuLeW1sORwHvfwt9AuLHTa+2GPw2CdPdt+dtaX4StHBLBNTtLSL
 nqVtN3+DmjMcX+gD/NUaY/DVgdxI+x6BNm6yiG5qvEBIZTwY4jIeGR2Qo g==;
X-CSE-ConnectionGUID: l3FJ+GbhR7eU6g//pygmEA==
X-CSE-MsgGUID: vGK6UwFdTAu/uDzawhfvpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102651566"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102651566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 06:17:18 -0700
X-CSE-ConnectionGUID: 53K0haA4SLKTvvfugoRH9Q==
X-CSE-MsgGUID: kjcGpTULQh+NxVBYraEWAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285252455"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 06:17:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:17:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 06:17:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6RgnsUCdPEcrKxidR7fGLgty2yitd3M+tjNBp/lBT0kKteP03+QOoRi/6MwcL3ZeizT99GZl8ckvxgFJbmDUhHcwfv1HsOI1Av1r9NoYcLpJPX1+HqOzMQIb9SCQec8Dug3F9x7LXTYV+YsGUv8TsSVqID5fuJNHxVDmVNVp2Yd9wTHuBL+zcN0FrKKZsxSuzrH5LYoxtFgL1lHLca0vWL/MJFfuNMK2ZHxK/cFtOJWiyu+zcML0QTw8wIYktbpdxw7W5CkEFbiehGgeS6AtLku4YidEYfana3I+7UEj78Rsq6hawlHH5xPBBvRIXtCKas/E17b//DCkVLPuccy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eksLqiRDj+eyEn8YV4bTIfmYMya/a3wCf7mOhUB8OMQ=;
 b=ixOd8Ouoeih92cm93W56oY+1SgWWqW2H4DXucUArBGT3/kdXea6IiHyQEZ+TN1xVJp+5XH0ihg9Dl7KK+NOexCSPKe4laz+wu55mWST102ZFqzuVgSMvCAcE9jDpAL/6CYDXMAmdO/a9IbqP7Pgi0l0cOW78yCIXM7D7lCT8gtshSpMYWJ1bwfMK6TkoDP0+BUVhIJBXHDk0JXyN20VdpIllXxxx5242f37x4iIYis34IrZ7L6MJDtcIb3sFbOvTYA6Fwgbb+u3R1l96TOCvdabstsu98dkjbU29fOsvmKihTIsxiZrJSmhGp4CVQKSvvPZT5xJkenyXL01Cw+SQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 13:17:14 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 13:17:14 +0000
Date: Tue, 6 Oct 2026 09:16:58 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Raag Jadav <raag.jadav@intel.com>, Fan Wu <fanwu01@zju.edu.cn>,
 <lucas.demarchi@intel.com>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/i2c: cancel the client work on remove
Message-ID: <asT0yrAaAFThUudZ@intel.com>
References: <20260928013030.612592-1-fanwu01@zju.edu.cn>
 <artYHzEMGPu26x3r@black.igk.intel.com>
 <ar5hcBKGhZDcNSKz@black.igk.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ar5hcBKGhZDcNSKz@black.igk.intel.com>
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|PH7PR11MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e6a3e3-6051-4ab9-e27d-08df23ac2264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oXheRPZvBai52tZiujvf+GJmf7Wh3O9Cbw3MuhCezG2GW9P9eNiCR5LNBd4PpvliFR00otQUJ2Zb1QDVCXvKVuH4RW8qn34uthqkreiz+aVVF+5ddiB/JWcDDlCZkNZMiCiWKDehcTQso8Z5VzCHJslSFlAs0oeNh8hyjyrwzIwJ7QPsY6uz6Bdho4rptGKSFUaOrYWMjkNamPMwouu00WcnKI4iPmGuVLb7zN5ImxQhmqJUUzRO9APKIOWG+9sGz1ZdyWeg5cPNYBW6/zz2AvQqKoPpQ+CDj80d+jKQhEUA0c84UYCXI36YK5XLKoQLvDM5E4mv56NexN87lRk1URrn94gnKZFZN499zWxRDUVzF5vyEdfKrCv9APoilr+7dyNh1sejR9jXHLKJuFrjvm6u5P4ltZpxjUH//aTvFNNpeFyHViqUp20TEJlJ0FdC0nuwOnYSPGVhqflgBjgfMfXjv9214IRNcRwJLYH04TPB3qdp4oU3oC1o9HWPr/aeW4rzHX9mBgeZnHVL6O2hG5L6Rym8tWf+V6d615eO/lESWLsmkUgR0g1kPcfgc58Mc7lJRT5lIgRnXmsH/oVncnXpT8ZDFNcphZmXaWD/cpnKZGclzaLB69BQJOk9kYSN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3yPKp64PebFPkVdeUDE5hgjPiid6jWzXH+xyzrRBpJq69KqY/nOtcTJbTYQ?=
 =?us-ascii?Q?yVjwZaqC9Dr/tWFMOnXypKXWQIrRxb8CV5xQ06VAhdxN4VTHw+jHNqLYnYmh?=
 =?us-ascii?Q?pEhY+xyEv1R2vqC1zAXG6LELlDI7pMwDl2KPyA58b6MFnVgDsV6hq6vjIiGf?=
 =?us-ascii?Q?5V2RvpRL3o4uKgmL8CW0cerJtTPNc6km+oSkqH0QFM8NIW1MCuUESd5b0Pi1?=
 =?us-ascii?Q?bHOlPtitICANVgLGqyhJ0yyIFVcZEi5NRCL9r/USixtM7YKFmoaNmnAgD+7z?=
 =?us-ascii?Q?WINrzt7+QubE1sM/7U02o7aLtZUENqApf+TZfQt0uzK77BcXic8rwzXhQwt4?=
 =?us-ascii?Q?1BWA1FChu9rftSDKSbUaqa0+dTxvTTL1t86eMFcgVhIh72nruo3/II0GeS/6?=
 =?us-ascii?Q?ctK8ttx2YM3yXapALvbPQeY29x5eBKGU7abk5pVA/Qbgtr9XlZmYebu3sgdP?=
 =?us-ascii?Q?CA8/c8WhROuMrV8gyxrWGkw/BrhVyTSiIZYNRIO6nUGr79uMHbIHMGp/iKzr?=
 =?us-ascii?Q?pFhv3gTx4QxZ35Ps9GxK1Zs1A6Dy6OmEO+FzuP3u1+TAx7iXisAoNBT4RTD8?=
 =?us-ascii?Q?wyb+mwp06qtA6jwpYSLs1fGs9gGfCFpl6OJXm/PHNtid3WkIQjZWbbPEcr9V?=
 =?us-ascii?Q?gNI3htWuvd7sO7P0HfLpZi8E+MV0BytUFXKJ2X86hysSeXfA5B+kruFXfZYT?=
 =?us-ascii?Q?aasqaSWMVXqTX6xxHfchFT3oMGvmVimU0XVaTl0BSvK0KYJLPMvuml1RGhK5?=
 =?us-ascii?Q?PchmSP5VzKKfP4ZTblSjq29ejyeLTNQcgYgp5CUh5Q+/Axhyqzzqte3OtIzB?=
 =?us-ascii?Q?o8QrQSs24TvOcMDS6gYxm3ELpGQMXxbhz7h3ob5E49jNMrwa0zLNV+/wrnnI?=
 =?us-ascii?Q?bY54cshO2U65TXsj3pzuj5okc+z+LOieLC988yj5+jL+2tl5YNL6KVPh5cFS?=
 =?us-ascii?Q?kQtw4gRAbOW1KpmyIgOSa1Z8muU/c5GtI1+j4UwxQVsyQWGX2Y4IYPg1w2DC?=
 =?us-ascii?Q?18hQZQq+ukF06Xgktsd8aXZSmgssTSwjXDAzsybeqBdG104FmbhsD1RdE3zq?=
 =?us-ascii?Q?oTTXRf7CH4Z0yRge9U73DMwyvaEkbwBDLOhtwuDiGW6aklEMjeu6vpWSnPWU?=
 =?us-ascii?Q?zkzbeAL3yAa2Hv3tJtb2xFiahBX6q2JJwxTqYrLVYmEGnEWMzfqn2O09U3xJ?=
 =?us-ascii?Q?Gry9RppmZd3SJ6C5Fm+V5yAemp82GjiSeK2hIKKwYKrX/Y6B56+vcd4WxXLO?=
 =?us-ascii?Q?W03xgvxxBg40CRhi4PGw9OzKmoEe+HGCXWkMFzy20HhqR4A7mPHb9RfKrJpb?=
 =?us-ascii?Q?bxfZVhiMoSXnWRUzPDYMN8N5jQZ8b2BcQMh/dPlHmTRgwjoe53knSeq1PpRj?=
 =?us-ascii?Q?6WHYUjfaVguw2vbNBHuyl48El1n9JBH9/rRKHcIeCj0jFrFB2LDQSXOt/isV?=
 =?us-ascii?Q?LV2w5rtmvN5Gt9PNXgBlTUwFaTeyu8RTCRxds1x0cGTCpSw77axvUp4kmf/h?=
 =?us-ascii?Q?qimEpvcXW89PAA+oB6AsfjbHDTSVcKtdvOfVEip48/tUqoyYb7d7JVi9+yHa?=
 =?us-ascii?Q?WhtHnv7m2ttxrezuNNOATk75GimQsHQDizd8LtoSUXdmtyK1NQbGOLLNXonR?=
 =?us-ascii?Q?TwLBf38Xj9fAuG9kfNiNVsDPI3W3gYcg/jM05fwn/Fj/P/Lk8Isyo2h2O8T0?=
 =?us-ascii?Q?2NlyZLkI6cpJcMRK6Ay665L3abUgqxjbQVJIv2+6sA3PGKonYEfH84VU7v89?=
 =?us-ascii?Q?LCMadEJsz5Ad6g3ifxzWEZ1qYgDmMmU=3D?=
X-Exchange-RoutingPolicyChecked: Fzdt3PLOuu0SrTzlVkKGjVb8lvKZBJvAXllwRYMter9F4cxDSfiAMBnQihKUzbKPr/ZL0rAPfTh12FlWkLIQg5CYgT6IPyDCP5N41CAdtwiKqhRUz1chW/4V4bqIrNNxdPup8arysEuI6/QVypGUlB5VBu9fbczNoy3EEwV+apIGxWTf+lu3YbNSzIN9jVMu33fRVreZ7FUQnLqcAwAdVfPR2cQ005DncdBjYteMkNkUMSr7uCAERorrHlaz33Ni/Pwawc9naPdXGIQ9SVXgRT2pVnrO4bfcCArcYJgjep3T8YukxKm6TnBe1IabINydeFi3O9rTLzdoruaLkex3eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e6a3e3-6051-4ab9-e27d-08df23ac2264
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:17:13.9304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHAQxFhfQDVUVNydObldAEQruy0F4wVdiScsiAlv0CjQ7bj6ObhMpCZbDweFINxICYTmmZ37NHVyycdH34xh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
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

On Thu, Oct 01, 2026 at 03:34:40PM +0200, Heikki Krogerus wrote:
> On Tue, Sep 29, 2026 at 08:18:07AM +0200, Raag Jadav wrote:
> > + Heikki to comment on this.
> > 
> > On Mon, Sep 28, 2026 at 01:30:30AM +0000, Fan Wu wrote:
> > > xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
> > > schedules i2c->work when the adapter is registered under the xe I2C
> > > platform device, and xe_i2c_client_work() then instantiates the AMC
> > > client device on that adapter.
> > > 
> > > xe_i2c_remove() tears down the AMC, unregisters the client devices,
> > > the bus notifier and the adapter platform device, but it never drains
> > > i2c->work. A work item that is still queued or running when the
> > > adapter is unregistered dereferences i2c->adapter in
> > > i2c_new_client_device() after platform_device_unregister() has
> > > released the adapter. The work item is also embedded in the
> > > devm-allocated struct xe_i2c, so a work item still queued after the
> > > drm device devm unwind frees that allocation runs its callback on
> > > freed memory.
> > > 
> > > The bus notifier is the only thing that schedules this work, and it is
> > > unregistered after the client devices. An instance that is still queued
> > > when the teardown runs can therefore write
> > > i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
> > > clearing the same array, and an AMC client it instantiates late is only
> > > cleaned up by the adapter's own child sweep in i2c_del_adapter().
> > > 
> > > Move bus_unregister_notifier() in front of the client teardown loop
> > > and cancel the work right after it, so no new instance can be
> > > scheduled and a queued instance is drained before the client array is
> > > touched. A running instance still finds a live adapter, since the
> > > adapter is unregistered later.
> > > 
> > > This issue was found by an in-house static analysis tool.
> > > 
> > > Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> > > Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Codex:gpt-5.6
> > > Co-developed-by: Song Li <songl@zju.edu.cn>
> > > Signed-off-by: Song Li <songl@zju.edu.cn>
> > > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> 
> LGTM
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

pushed to drm-xe-next after passing CI.

thank you all

> 
> > > ---
> > > 
> > > Changes in v3:
> > > - rebase onto drm-xe-next, after "drm/xe/i2c: Disable IRQ on unbind"
> > > - discussion: Link: above points at the v2 thread
> > > - unregister the bus notifier before the client teardown loop and
> > >   cancel the work before the loop as well: v2 cancelled the work only
> > >   after the loop, so an event arriving during the loop could still
> > >   schedule the work to race with the array teardown and leak a freshly
> > >   instantiated AMC client
> > >  drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> > > index f4f3819..b82caaf 100644
> > > --- a/drivers/gpu/drm/xe/xe_i2c.c
> > > +++ b/drivers/gpu/drm/xe/xe_i2c.c
> > > @@ -324,12 +324,15 @@ static void xe_i2c_remove(void *data)
> > >  	xe_i2c_irq_reset(xe);
> > >  	xe_amc_exit(i2c);
> > >  
> > > +	/* Stop the notifier from arming the client work before teardown. */
> > > +	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> > > +	cancel_work_sync(&i2c->work);
> > > +
> > >  	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
> > >  		i2c_unregister_device(i2c->client[i]);
> > >  		i2c->client[i] = NULL;
> > >  	}
> > >  
> > > -	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> > >  	xe_i2c_unregister_adapter(i2c);
> > >  	xe->i2c = NULL;
> > >  }
> > > 
> 
> -- 
> heikki
