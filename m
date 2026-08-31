Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38C0C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C6910EAF7;
	Mon, 31 Aug 2026 21:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JKb9exBm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288DE10EAF7;
 Mon, 31 Aug 2026 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788210015; x=1819746015;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=WVxwP790gIqBEUbZ3UVNvMNHTQP3JW0UU5UhqVVjhW4=;
 b=JKb9exBmneDAb8wZIANXwKVcsD9xZuHdkPrtKOk2ZIURr72++tBGWwH8
 Pj6iODTawrecyhe+SZjrNbARHxOeEu/iAOfSNj7Aa/BCso3Y/ZAjmeZNT
 Xy5e5Q0zQKsYjovmkymDR49p9M+d2uBmmlC2DqS57oiQM3LlMU0pLabMs
 AETUPp7T7cYeGa3irbpIuwHE494IaTGvDP4q12obNpMLkBLixWVF6ZvSx
 JNmw7Y5TYRkslvukN54KWV6UjnQUzMwWefZFBdGTxzchKbUibdLRXoVME
 NPYbuoA3hM7W45Y+0puoPFIeUfrljRpCfOgNMZ3wKD2DrF9guuNfjnS80 Q==;
X-CSE-ConnectionGUID: mMTZJY+FRhSm5F6oLg4eWg==
X-CSE-MsgGUID: gQd2sv1FR7a4l2/UdvmBVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88479362"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88479362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:00:14 -0700
X-CSE-ConnectionGUID: BctxdqxKTO+NvSlTCchDKQ==
X-CSE-MsgGUID: TyIaeGlGTrO6fQ3Kvlyh1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="268948376"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:00:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:00:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:00:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/fqFKnJeuq4nnEoDaVBYmVDgguJo3xZBNo0AlQLTWKp8gaJoNhI1k9E0y/azxGj4TdnxbxrWc/2ls8jSgT7KQTNcxNsri6UI5FT8RZnJoPHlujUoNbXmhTvOdXP7phTQDUFVvpzCaCOk37cE3EpD5U7rotvh0v7BdmVP+uI5Xj1QPjxKzHZzOKAoktwy/F5xYnHWiUBhwf3ISW8TX+OV2bRimZm8MPniIe7Ziv0VQqbQGDONe4PUwWaWQhHyq/dWI/oQwjMxfyc0GBjFMluYJTgh5l5CZJm1PNRtmAawungSdvJBr+hGSm0rID5Dya0qsnyEtiLkOn2ohPeoiGnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhn2fYHPvXi8OsPF5b1F8BuxEmmRlNRqqdahMZi7eA8=;
 b=N4bHhlV5Ycs8onWBQn/hnjgziFAgaECB4Y5aql/KV5DWZLy3wm+f+r6dNpFLwEvHAmOSm5bZngRKPmBYvDZ+epI4PciElpUuyo0FX1BNK0LyYRQIXYrsSHcjyx/H8HiHarjH0IrwjZ9n0g8gmU6DZvpYyazgXXLQseWKVgXN+Nzwr6093Raxz0OwGTrgvxrmUDqwVOZHj6DbLYqqngVEYjuEv/uthrW/bGX7TkdiXpD11ONvMjSRnDQC5Q9MYcvhx8A6r4Br4U3NHEwvnZhMs9KqvppO1FSY/0ZTv/YVGBtdcXjaF5XCbt/oEwGHBxEmirAntJ2wZya1BImd3MBP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:00:10 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:00:09 +0000
Date: Mon, 31 Aug 2026 17:00:05 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 12/13] drm/xe: Skip PM notifier preparation for wedged
 devices
Message-ID: <apXrVcABmFQbBQOX@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-13-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101801.1247654-13-arvind.yadav@intel.com>
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd2fb86-c5cc-40d8-a2d5-08df07a2d786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: KkAYiWd/7Lks4FhQTBdU/YIX0JbXDxaIureJ37FJIf6YpmTlQiSBThsUF+bqjDAadSVIrO911mE67GXhb0JTmJMhr8gpQuuM0jLEq7XiWKh4dQcfndAXssPF+NpOnAdd6iJIixtoUgVQD2dMrKkHsuXwN07E9pvxvvRDReweYw6zmMpoHrRQrdXjA1BZEBt5ZDKGNizrQMGlv752R7jPVMvAHbjYh715TGjz7r2rmId5xcsUTgrjJ9LB7AE2/ggmuTXujyVwrq9VcPDpRqRGdNHHD+d8AHaE19Gk9MqzTpvmsoOEdSM/4vHL+TWeYGdFMmGuYBPBXTdZxgYLquGA7RtOSwkRfPoFet1QHH2gGV3qRJLNxT+HqNJrjJgoFbHSmiF8EhNexPUxJ5c3bP8y/XW9I7cJ0IWKymm7fDWnZApMKpfoEKtQ5OnWgEsBRllY2WHaNrDax5xvcgKAWMRvzfJ2WJt9nrFpvvq+gxA1xTkuLsNtMvIufF2gYI5Kyze8pYcAKdyrChZv1uyZfbyY4wfw7X4liUienMFgsrgg2E9/ghbTMVudaqiaomkqRljlwvxCnnfYH7XB2PiJLiQ5ewTtW5bR6q5fy8eum6dfSwIpx/4/UaQxf7nLt8QJnJfLCkBrsDmqmPPzBmdDL+HkI7rQHFY1N+SiCKYvGQnkA5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SWfU8p8RGcAY12khp8Ua1xuOXt3AMFp2C8G4vi7Ze5s6hX5PlrMUHiSdjN?=
 =?iso-8859-1?Q?x2ZCfB2ICzDFOyKcEekIXfprWlYOEZn18hrVF3kbDEC9FoOaVp85LprH+E?=
 =?iso-8859-1?Q?BiB5eEJPaLJXIiAuv368lsQnUhJvVLlKnYlmTVjSURnAKMQd1Jb+qwup5e?=
 =?iso-8859-1?Q?GdC5+c0gQYXtsex+tErZe4jcQ6oVUUl2xX6dnJPlwjSwW3RpouuOjOcAWg?=
 =?iso-8859-1?Q?1pkJQzFeu8e41ojgwEwlxG3Ie8nnAyIj1wQ5beNkNeU/WgS2+hxaygZCls?=
 =?iso-8859-1?Q?36oewDTvVAFUVv0AvWDBfkuprSrF39fMdJAaW2B0JfiUtsbLbXHmc/Z0W8?=
 =?iso-8859-1?Q?nqP98h+NtqwEbZTvhyRDJrm9rkq8yZSoZezog+/1539aweQAmQFmjUWEPc?=
 =?iso-8859-1?Q?PSJ4QByvdArNUJYvmhQ8aCD5WLz/tzUtyBPWxU+uFHpDmYSqPT/NJQcHD1?=
 =?iso-8859-1?Q?Ukerm6siKReESwCj8gz67383Y2VX5Tpb+rti0NSFqkZBYYaWfRkYtQ/Wie?=
 =?iso-8859-1?Q?I9q1VOyAqfAVRjncUhYOWx/jj59nQ+oVafJmpFMV0n202iUrmXsKnCAHiZ?=
 =?iso-8859-1?Q?pZHO/9ZCSYkOuxWH3LKv446SNtKcsqUfT9iMVMNZ4arhc3hW+XeeW95mwe?=
 =?iso-8859-1?Q?JKVVg6QYMdcOTFpVYEb3soMLDKKFQeHyp6uXjOHX7mdmzU4yJfk1kcJMrZ?=
 =?iso-8859-1?Q?8obk2um/6LnKzkwtbWnFASEbotXeG/cQCK2pvJhHVL2CCkDPCupJGHT4WE?=
 =?iso-8859-1?Q?OvmXZiQnaMIJmRDeTY9wPn1BNnaISUmvwGLezd35pvsxcgyMDLIpgwenpH?=
 =?iso-8859-1?Q?bB65WtKhz7rM53+a1/nONn0GYxg20dQki+tDnxwvJG3TEI0Je95o1omT3L?=
 =?iso-8859-1?Q?mDdBT1gzP7qEnYopR6UTLc7+0ma9vTOEGcdjhqRMC8oQH6UMiQEDVnkLWu?=
 =?iso-8859-1?Q?Fwxux0D0NWHqFQWnkg5v9cZu3PoAROJgglUcyNDnPZtP52OVsj0gEMWgIV?=
 =?iso-8859-1?Q?hFKhreI8TWVpsQvsb9PgK3yrWYi07Zr4ObwySrC34MxPefku3HJwbNfoFu?=
 =?iso-8859-1?Q?wUZuoxbSoM44C3O4Dxq0munfRHyBtqN7UexRwrokGUtgx1iK1EUZSEhqlQ?=
 =?iso-8859-1?Q?4mS4FRZSmBE4nTnupm784/ku4GJ9MxnNl2+ONnasoStGTKPzbvQPk06l91?=
 =?iso-8859-1?Q?dhfQIbymQNf75hshd12+P2Ir3SrpWb+SeqZtJwcniSxlKNHxDQ2fY1PY1a?=
 =?iso-8859-1?Q?74TO240xVDkQ4KZtaKIy6XWzryXVtQHsGsRLBZPxar2UBj0cJTgaoZv07M?=
 =?iso-8859-1?Q?52UViPKrTLabwDkzPEhZHzcmRflUfWRdLvbe+QWS/NGW1xmd/vHwChel75?=
 =?iso-8859-1?Q?tki5qVmaq7aY+jpwbvwpYogb0yWp0AKbGBTAMXrKVGsORj6JxGAN1Nkxo7?=
 =?iso-8859-1?Q?i0IxdCj16r8El5dSW4KKGNcefZxnhFtNb0t5bDTR11UKkA6AT2rOTycQIZ?=
 =?iso-8859-1?Q?gJdXnKrl9zX03fAtvr3YPQs4ua5RkYmXx28qtxhCC0SpUhYXcb0yFTERVv?=
 =?iso-8859-1?Q?+yv9xaILxmQBBXcG7Fjk9INNRgxMHeQ2MPbhA3UnM9Bjv6lNXIbcUWdQMz?=
 =?iso-8859-1?Q?uR6DGmrjNUc0IfvM3LPsWVqMr4E9FuJFBQqsWzNdh3Y3megdZeJpK/RH1M?=
 =?iso-8859-1?Q?AuakLxancx7QF583NJ6Iad5IIjFi7AxsamzgrSV8WYpeAxAlJ834p1fjcQ?=
 =?iso-8859-1?Q?Qf+OhCPS+85PjYv4F2cxD4X5kdMNGduWpChIDQp1jYrjOxnoS06xhSmSja?=
 =?iso-8859-1?Q?v1edcR4SWA=3D=3D?=
X-Exchange-RoutingPolicyChecked: kulb4X8tcuEn7c+1mSwKkxaon+tqp7nzwJmp8uoS8jZpMREAQ5gpDiUkwONdUwaUSWLWcNk9gaqxS3c5Enni2Akhi236l9cytL53JxVvQGLFin2GO64vG/KTAAf1+mz4T5Zn3WR67mFJaQDMZdWD1koySFnaCJs/q/qd3/nDw8gigAuA0Y2N3iILrePOMs7hwHBCX2zs2qTX0+/YWFV0dm0rvGHiHNRyh5Mk0YAdm/vVF4kO+kdXCWIRHrEjwq8VBYE3h437BWQwEdacc9phM5f4DcvgtRvnXt1l3IC6xQ1krod9FCeQj9OBjboETRlfjactvKasGsTNyWDEetiChA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd2fb86-c5cc-40d8-a2d5-08df07a2d786
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:00:09.5358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+ICG3vZh/xCZFC7iksmoa6yBv4WRJG6+gqPAFceriVzd3SOtcxy/0FmC3cugeVay5rg+vDhACzTvi9+Tu0IAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
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

On Thu, Aug 27, 2026 at 03:48:00PM +0530, Arvind Yadav wrote:
> The system PM notifier runs before the PCI suspend callback and may evict
> BOs or submit migration work. This work must not start after the device
> has been declared wedged.
> 
> Skip PM preparation for a wedged device. Track whether preparation ran
> so the post callback only performs matching cleanup and releases the
> runtime PM reference when needed.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device_types.h |  2 ++
>  drivers/gpu/drm/xe/xe_pm.c           | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 508ba3872e72..c9dc417878e7 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -471,6 +471,8 @@ struct xe_device {
>  
>  	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
>  	struct notifier_block pm_notifier;
> +	/** @pm_notifier_active: PM notifier prepare work was performed */
> +	bool pm_notifier_active;
>  	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
>  	struct completion pm_block;
>  	/** @rebind_resume_list: List of wq items to kick on resume. */
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 720e083cd279..dd7fd170bc94 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -457,9 +457,14 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>  	{
>  		struct xe_validation_ctx ctx;
>  
> +		/* Do not start PM preparation after a wedge is declared. */
> +		if (xe_device_wedged(xe))
> +			break;

perhaps we need to return NOTIFY_BAD ?!

> +
>  		reinit_completion(&xe->pm_block);
>  		xe_pm_block_begin_signalling();
>  		xe_pm_runtime_get(xe);
> +		xe->pm_notifier_active = true;
>  		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
>  					     (struct xe_val_flags) {.exclusive = true});
>  		err = xe_bo_evict_all_user(xe);
> @@ -480,6 +485,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>  	}
>  	case PM_POST_HIBERNATION:
>  	case PM_POST_SUSPEND:
> +		if (!xe->pm_notifier_active)
> +			break;
> +
> +		xe->pm_notifier_active = false;
> +
>  		complete_all(&xe->pm_block);
>  		xe_pm_wake_rebind_workers(xe);
>  		xe_bo_notifier_unprepare_all_pinned(xe);
> -- 
> 2.43.0
> 
