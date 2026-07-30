Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE59C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCA410E193;
	Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EM0pdxUN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31F310E188;
 Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785420821; x=1816956821;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0pOjNBpC9tMZS/5I2LWu9ktrKO0ZSnr4FMpPw6/dLvE=;
 b=EM0pdxUNP4q7UG1sQZxXnUQK+XuSOjlKq0PEtPepo3o6Lx3Unhtspi8p
 mA9DSOZD8c+u7hgijzAf8XeOj/DIcpfJlRz51v4gvHLPTTk02ziuBi89y
 EGus4WDnzxofuzKx0XJsI6/LIztKPJqk2uvUKUGw47nbDdpAw5Lq04oMu
 saZRo7plJ3sIvPUuxT0+lYvfJQ4R6YIh6cwSelsWBJas46WonROVOa1Ul
 7FvOtCPI0xjtrzDukjASbLwwWuTGKFxtgrncOSac2b2XqDf1iqH02DDj0
 Qi2NTiGnDEld/EzKsGPI2mbe1VT1grwf/Wp6w28BfQZjrfk3zY/nWI90V g==;
X-CSE-ConnectionGUID: /CM/5BViTXKS23ivM6UxaA==
X-CSE-MsgGUID: JifzcNm1S4uzu81iNRp6ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86230159"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="86230159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 07:13:40 -0700
X-CSE-ConnectionGUID: kJ6uaKOLT5C+BhjANO38+A==
X-CSE-MsgGUID: JVoCc1ZbT1GX0yB7/xYAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="259741669"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 07:13:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 07:13:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 07:13:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 07:13:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1+CiA2wKBX6SX6vhRjKSLSQcNmFdEM8jvRn/MserUFixk3T9ULDjnAuPGPR/8AzASPPlBxROjbLSdQ8jMJ5VsfuwJ9ZDfcaWBh+wBjL4elk3XWc7xBdYg/WDhU7xRZR0TPUtktGOmnxK++M/XZGvW9gxGyBOywzgEzAKz/guiUxL9pvDd/Qat3kfXuIl7JA65ZPP9G3UY4f7RIxneg9DXG0N0vWWW2wr52OUi/gBg/KYtcwe34WyIf2KUdH5noWFIwZisqTLO+PegJj2nrPExEb7ssQfhQdTqG/7KFS9PLF0nIbsLFmYXOB5DTjMojb8XH2nTdO49Ylu5u+nomcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1DRqdhCRzRr+1Of1FZCgjgyOyrlNC0yiE91dnM8oqQ=;
 b=uEf0Z9NPafV2dB5FnCeHAf9rb6EpPmPpVT/ihOP6skSf+qZMoYdsnNn7PsZfsgKeYikU08bBasp0ZH//yDGTVodh5Ek7rthUSwpYGXNfNVBnoTC2ImqdUxlrshdLvhSDaIHIgauqLPZPohXoE+H9dmO478bXTHvHPPZiIKiSHinGp7WzHayQb2OoR4LPJroVZWaIpPHyrcXe1wAvoB25XQaBjEarsn4oVUr0Lc0Ej6DzJT/2WkzPzD6EYT8YU8xJIZ/2aQlE+Ekpeoy1WwvsAn+0T5B7di3nv/oSFzESKW6Mb/8ZgI0gMS2aNSo1KjXwi9Y2hypJZJu3fHNL0F6lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 14:13:36 +0000
Received: from SA2PR11MB5082.namprd11.prod.outlook.com
 ([fe80::96a1:ce7b:b3b4:6026]) by SA2PR11MB5082.namprd11.prod.outlook.com
 ([fe80::96a1:ce7b:b3b4:6026%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 14:13:36 +0000
Date: Thu, 30 Jul 2026 10:13:32 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jerome Tollet <jerome.tollet@gmail.com>
CC: <jani.nikula@linux.intel.com>, <ankit.k.nautiyal@intel.com>,
 <ville.syrjala@linux.intel.com>, <arun.r.murthy@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: Question about drm-intel-next vs drm-intel-next-fixes for HDMI
 scrambling patch
Message-ID: <amtcDFjbZ4w_OeNG@intel.com>
References: <20260729161606.81668-1-jerome.tollet@gmail.com>
 <20260730033607.17136-1-jerome.tollet@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260730033607.17136-1-jerome.tollet@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To SA2PR11MB5082.namprd11.prod.outlook.com
 (2603:10b6:806:115::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5082:EE_|PH8PR11MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 995e33d9-5f75-44aa-071e-08deee44bed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yqOW9brjJq+kQf7V9qayQMWBon6AlGLYKSwuRBq6k32MWAARxDguuC0vn6piQ4l+dhTe4ikty/seG7V/CHmmPYPVfubQ3YFZY0PZC506LLx8SrE305H/lSJTv7KuGbxtV5BsxyvtGNwFI5EM3X+IkyEn2/WGyYsyQGnVYOcw+Pg6u1I3VSvwvuTYMwLFe4Y1AgFq3BVPVhlVcIa5lfJ8HV6KUl1NyZfaD8dpBprTBz4cp9AROSCUhS4CqbvR0WyP2zUV8Z+gjJCJgpie6ek36nFdX8HYw3szxGf13Rw10iVlb0OE2uwGKMXvtHY+AytcJpTcdK+Wd2ijeHH+ZYn+eDaFcx/V4Kq7WDZUjXyEHCMY3Am54j269bhJb9IpdY2rzLA5XX+rlj4H0P03xjD3YHinLIvPXIdnQo4gjBgxx9frKroIg2iOT7UqIrIdPzKTaYLRxBZZENOjVE7X0gRby5+gMqVX1LXwM2MtE6RTkRUtWB8as2MPZvJ8VefPDLM7V6hb1pSMKAsBrX+sJVuPEo8plGixFlvbb3gvtpj6i4I9LJBniaKOINWStHhDxoutERi2Yoo+liG6bB5IxKr5xDos7KQQiAog6n5Vthd8FM/huy8GTBDyCY1mpKIYQnIKS+N/JhhEs2A4CN0QlJV6ADPJ4q/5KIPzJnwK/RZw2Mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR11MB5082.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5z5CnrMITVsUbx+qXnDQu5uDmmEzaOh3qUV9JkGUI8XeJYknLiArSAquY1iJ?=
 =?us-ascii?Q?c7UVKG9ULWboeWsvJRwtp2HmFkXWm/O7YBfdmxNxTNeEmyrGtULDNBzf5Iqn?=
 =?us-ascii?Q?Kjl4VoTdVPWOroZe7bB1FYrFcmgwB0qh4xj00wCxuubGuXqvAVWbDklb9iHs?=
 =?us-ascii?Q?tjfZVwBRKAo+Muu5obfoToviVP9E7mqxNtZ5k4XAxEg5JnUlOIGq4mnJktjm?=
 =?us-ascii?Q?WFEA2oHPfR29yxMonlXuZ/O2HCvIwB7nLqgxMlNryZrsO+lxRzoQZQ40s2eX?=
 =?us-ascii?Q?Q5x/hw+DCKY8/oEvHi+Wd9+nEP2bBiqHxXsB9sbX2rl435WOEDnJE1NCPBZD?=
 =?us-ascii?Q?oefcozY5hKfu5+nfDhbFRF1GoKLSN3c/6mFh5pzNAef3qoIcTnoa0d3s2LFE?=
 =?us-ascii?Q?NjUZ5Hbxtc20HQAD2h98dC9dqwl92lg4V9cjNAO889gMNrJFFV5pGM1m6C6/?=
 =?us-ascii?Q?/0VxC4b8FEklnk2jw649g3n15bNGt6A8IuJ3DR7SgHdsox34jbhHQ8ELBSr/?=
 =?us-ascii?Q?fkG/Sh6j32jk8AdOi1lgtUWzFFwJeFKQx7XxZPb2o5bYfuyjGPZAadNOmai4?=
 =?us-ascii?Q?ITFYHfbpmVo1zps8Z4YnvYiLjlftqM8CM+8/RtBT60PiaIumk/nFbEBVKuwp?=
 =?us-ascii?Q?s2nfZPfsaF5Eae3TSama8an5GI7buNvFfSLn/7/tfNwnuA8Sl0IxhwSXPz24?=
 =?us-ascii?Q?2GcZkQa/BMkcNsUX0jY1WxDr8EvBNBBaPSH92HGgWnnzet6nLjNP1frn1frr?=
 =?us-ascii?Q?Qtu3fTicQcdCGGERUNIZOecW/Kv42LdU/RRiA5GKyw0t87bKFq5qd31B+Ko5?=
 =?us-ascii?Q?zM3yo/wjDzvH789QnxmcpPbP34usSIpIrNYcwnqfG8waLRoK9QOEFAQvBOfP?=
 =?us-ascii?Q?NIJtIpuK+L+qhkF0poRhKbHU//wx13dBZStECOg9dPWUCcJyNXZe+9KgH5Bp?=
 =?us-ascii?Q?/54yv4Lr6z0JtnLYYISXvHtHqJvHUkYit3FnDQsCCHfdOFw4mDCNkU24FRHI?=
 =?us-ascii?Q?sJEkEqOFC3ttRZbLz4naqCvqjF7hw59+3J4jReyENwqyMZkFs0yiuVFP+ASb?=
 =?us-ascii?Q?/Z8i6xYAO3PGspoKuLkcF1keZKilkyTJp9pE7kEdYqhYlrhRzs3zeWbXg2w+?=
 =?us-ascii?Q?wFlBDpkD4QZhEj4iWKrGk6c95ks0rE7+18oZAD/zgqvymicBfyLoKG80Up54?=
 =?us-ascii?Q?DVH4vsxopqJp3FQ5I5xmhCRvSA7qTFRjteoU/xRToNBvSzCuv+rapnZyeDWd?=
 =?us-ascii?Q?dTYZDvuUbY9M+JO+lAMWLecFp0ZK2j8JNoFuPDnx2E78Rf87er5/35v7tIGg?=
 =?us-ascii?Q?iTnnh94MXuX4ioTd7S91UQ16w9xDNM0G18ho+C+CS3frf2F6/c2CmJ9ylBH4?=
 =?us-ascii?Q?Xe/ZACJ+X6hTB8WoVFNVwfLHMXcIxypPL6wSRMI4AXmC8PgYexCxfSarnMf9?=
 =?us-ascii?Q?Fnxizhb+SKsCtS3N86EWXiU3NMiIbWNit8NaCR+Yb7EmrYoLF4bCtLF7b7l0?=
 =?us-ascii?Q?Zpc2m34czZh/iKTWL6roci6nRYcnvwhv8zrqskdtQTeajk51uKmGWmVmX5rz?=
 =?us-ascii?Q?s3S5SKQxWS9YLsArXDsEArxeUwgV4g5G15n3pVYeDXpUF/drQrXrarXvTz7U?=
 =?us-ascii?Q?wfEHWlPeqYTiH4c8RNMY446C609wMC1juAY8ctyYsCmYlntDMvW7OgRhD51U?=
 =?us-ascii?Q?Ej8gV8jVTvrNZChxlTUFXVRAqmARUShWDK+ZuVQpvixlzAn/DuU1he3my0eN?=
 =?us-ascii?Q?GnUepC9ODQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: hbitsjsdkuch8BlwXQ+WpCPXNHMTTIueuQrMuN0nIjhzK3iCK2gek+T2kO1ZlK/PKeq+6DMK8ladOQWVHzhwGZdwL+YUPHHiNBXVMVvcsSxsSPP+gy/ft1EZ3iTu5CTDb11WPE7FCZhx0sWprnLMYKa0LTj2t6a/HXEZf0fhHnz0hZIlc5WUw1/HiA0p6svI+CagphrLc0PTW9sZY9HXp+IqYyZFH+c1hzZjR2r7s+fTXKuDFCFjCvqHp2kuiMYRGS54+gLlH3wdD2JCj5juTEp1mRpXDM5wUUuKao7JQjHOR4ouwK9NPLrubDV784DzH+XMoGxS7nZQgcUJZ1qydg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 995e33d9-5f75-44aa-071e-08deee44bed6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5082.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:13:36.7130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPyArfXtwznwmSFFw/IajdZn4JEgKgQjnsDYqgzRpGtYXLE5s7pzTvfKgsa3iDbXxu6wcucJMzQNHhtT/f13cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
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

On Thu, Jul 30, 2026 at 05:36:07AM +0200, Jerome Tollet wrote:
> Hi Jani,
> 
> Thanks, this clarifies the process.
> 
> I understand that the patch was applied to drm-intel-next first, but since it
> had neither a Fixes: nor a Cc: stable@vger.kernel.org trailer, it was not
> selected for drm-intel-fixes.
> 
> Since the patch fixes 4K@60Hz failures on some HDMI 2.0 sinks, and has passed
> CI and review, would you consider it appropriate to cherry-pick it into
> drm-intel-fixes for Linux 7.2, or should it remain targeted at Linux 7.3?

I will pick this up and send towards the 7.2

Do you agree that a proper fixes tag for this patch should be:

Fixes: 15953637886d ("drm/i915: enable scrambling")

?

If so I will manually add it while picking up for fixes.

Thanks,
Rodrigo.

> 
> I am happy to provide any additional testing or information if needed.
> 
> Thanks,
> Jerome
