Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542B606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NGJ2gcQT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F8E10E1A2;
	Mon,  9 Nov 2026 15:17:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A18210E1A2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794237435; x=1825773435;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/5Pu4fw7ApZwGXFpjzE47SoIY+DaX9FCsWFgJvfOpOA=;
 b=NGJ2gcQTyN90IxRKFBcfmjy+iOjtnJUpDgKRtRetvYN7NdeqGcxPuoFW
 0nEBZiI1FgAWWdTIV7N2udgzXnWYF9Y2tzsBhoW2P3YYAXQLG4rAWQKYq
 pLyORnsfvOeZJpYSQl2AWfMYTDGnGDoMVJ6SK9sUfvD4OQg7w6tRK6evK
 MoEHcUpHasCQi/s1IkhrBjw2U8lGgMnoIb7Om5n+llp6vvstrteSrl9rg
 kCtcx2LERvWuCVoghWkG/qcOXF330hSuXh8GV11kKx7qgto/ugG7kS18M
 e/xXRO40A94luj/J5kV5WQnk0pC3Q2Yd3JCyEb8n20SvQMp8IezzDshAe g==;
X-CSE-ConnectionGUID: biX9GUAzRcaxYr5MaQ5h5g==
X-CSE-MsgGUID: P6u38Z2RTFSJLmkzFNN8Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2858163"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2858163"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:17:14 -0800
X-CSE-ConnectionGUID: 6hMOjkp3SwSpMBdnwE1H2g==
X-CSE-MsgGUID: 3l9hH/W4SUizOJdWnYqaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8328328"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:17:15 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:17:14 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 07:17:14 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:17:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8Na/d0hrraZ0i+0VSqQDYKgf2m/vWObuLS8g/6qEPyydJmCpeGDerQQOCrXHPhDwZUxdODSfXfPTmOrmvU4ec2M5lm43uIreEANoXsxP/oEfDp4ySdDZs//kW452RErTKovoqTVV41xMQKTK3we5NNuHFzZ+cN134yVIKFTLURTaHW/cECtCqDPXenSVZmRiDJ9Os1ExTA4ZHoLHngzyStlm0Dpfte5TV+ZVfMwJ4s5iTcieRjXjth+LZeP8Kb4sm8PUH1KDi1R0sn7Cwa9AokWwvN0pofJcW2QmIqppUdbUQfSSORjNV9iAHArf85UHWxS3YA8AaBaqtfr5QywZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf9AR8PduF+0HxtIw7wZZbhAvqb/KQCJMo978CLO6Pk=;
 b=rdZIQMYw3vH3L2nfwVAg5CtjHAeEleqwmALpnWuTDV5NSbw780l2MIkktsoNBKNwX9+dwJsumaiXuct4TAnDlifkj7Co0yu6WOShD6ZLGK3Go7ldNVQ8VaN/hZUvOxb9/d6OkCi2xMDUtv8ZVK8Jm/pKXFK0BvTgJKkUVW1l7LzDxXyWnY1sKJEHQromlhj2f8VoEN/3HJ/toJABG5hdsxtuLM9oqZ/8JO7/Upxd92jSzXfvKhEiBfrHUUVEKigE0rqClLp/wojx4EDp2agRab4wZzmA7dxQUsO5C4ctE6K8JM+UR6X8UL1e9um0EiPCdYVWL7iPzQmnde/IzkD7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH3PPF7DB70F9CE.namprd11.prod.outlook.com (2603:10b6:518:1::d33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:17:10 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:17:09 +0000
Date: Mon, 9 Nov 2026 10:17:06 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <avHj8iqiqy-1aege@intel.com>
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
 <sashiko-outbox-203163@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-203163@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH3PPF7DB70F9CE:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be67631-7b83-40ec-a490-08df3e7485f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|10067099003|3023799007|4143699003|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261026140227099003|261026121527099003|261009221227099003|261009223327099003|261009220027099003|261009223027099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: BJv6QDwJx+baeTJnO13yNhqIwqnLozPrNNk/QCP1hosyfOW/AYJU3o6Aom7jKviAT7IJYJyRO/7UM2qwR3oeAdmnobKihqx7qWrVoY44QedE0VWb9qXk18zqAA+cZe3xYJdG8r6bzP3jrVKfufJw5YDBuVn6Eemog1jwAJN76QOJM1/O9YdhUbRcbc+usm0ZtxZyLVVIIeG32K/ekfvrSVufg3b/wrbeFQMCDa6vxaiuK9wZAyfPcf9igd8RtwAqGozTEcFFrUpO2XG4uNaVJJL6MQc8Xh2lm0g9MNGDI2cmvugl+fXYjuKUa2i2SzCUALGxqmNjdk/hqFbuBOg/t1gtS+By5BhA0q9Gm2if9TGc3NU8Ff75SayD9+274XuXL/LmHI1YNUQA1mJMshdpCMzGm7BjNzD/3+cRpBIn49oLUedDJVS0hh7MbLnBRzNGqYM9xsZn9MisklnAA06NBgPTdf+tNz3AfEc4yNpXbd3E4E9Qe52TI9S/3lO65B2kGUh1TLiB+h/LSbqBUObUh1TtM+RhxsfhZj5zJX6GHJ7bWIHYDlsV2mJeNTdnYcNrsiDkhqyJGTESiBhx09BWPxSfZsmcGXyqEdQj7+X4nio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261026121527099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nqMfxbGmUry15ok5cYOcTL3+n6eBFmr0N2r4AAPI9Sxp27pYLbFBOvFN1h?=
 =?iso-8859-1?Q?DXNyGXpZ+RzkakA3uQyWNqq+Kc1qSzOwrauqlG+0gNcouJV/AvCRoxr6lf?=
 =?iso-8859-1?Q?8T9cSVJ5iTv4XaD7chcUyIXHlTdKZ9JzMF71hqinPdcC5efYhmdhWCgY4B?=
 =?iso-8859-1?Q?9EtOf+IjE/11OUCW8oxdvWzcCRkN3a2CfRN0zcHdjMiJ5+TXPg502AI2Dd?=
 =?iso-8859-1?Q?BBiI1L/h4jBdimQnBJbRUJIpPjq7jJAtoSWIk41ypDS4wtVOaSyZAJ8SqP?=
 =?iso-8859-1?Q?78Cq4K8Ql3DgxA+K1ZYF2lfRRz4MKYACF5wbin9yMHv7qvHC7D8bc1kxPx?=
 =?iso-8859-1?Q?YGIR2tFaRtBwLsPyLUl4nl0N5Nftvxb3YcXcmGSbOpteKAskxb5/PJcqjf?=
 =?iso-8859-1?Q?CO0nXTsWVs4VcmMKsTJgCE6anzYpgPVJfoBf/H7sn7nlnqSslyGk6ZeMRR?=
 =?iso-8859-1?Q?5MwcyFFbrf3YEUUlQOWJIVJp7lot/em0dGeNlxFoe+2Zt/cGUYoXkfSWPz?=
 =?iso-8859-1?Q?teW7Ah1TcIrhxs5MDXZNljr6dPcXWkPu7ZEc8gjLx3xj79Z1r05WqFfzI+?=
 =?iso-8859-1?Q?jBJYmLmj6+oKWlAB4cDlWguGHH0IPmjaCI+fMSTNyoV51yj6aV5ojn9FxZ?=
 =?iso-8859-1?Q?LTrAmo2r+arnyzIBWfi2wJMufslVUgZvM2ypyQ7AKfG9xW+nXEqFwTLBbd?=
 =?iso-8859-1?Q?APyXKGxoQUUj4kWAsPxK6nArRnFKFWaVCfAj8DZooieSokEoHCf3FxG/5M?=
 =?iso-8859-1?Q?23pZjrUSElpt+DNkTKr8yZHxEO7coGNqY3KAwIxn06hdu1uAref87ghBBN?=
 =?iso-8859-1?Q?lOjqoMOazKHuXTVjLXkhTytW27oz5xlSLsC44RZ3UNA7HQBDeGY26Zuv58?=
 =?iso-8859-1?Q?azbHpNoVGetvYFWVjWZHzhd3a6Rmfh/s+Gi75V+EJR0PE158FC04B9DEhG?=
 =?iso-8859-1?Q?lo7pudepPwOQiqP06MOkuAboZo1Bs9l/GOLZIWaxtHpl6FKBxpIWoZ3xmz?=
 =?iso-8859-1?Q?yVKROQXxxG/Jdc38Mtx2Vv3x9BSdMlW6rX3Frdf2wjJwZuF8BRnA7uVxG9?=
 =?iso-8859-1?Q?xrSmuP4KVZViWpc9upfbdIAM9QaAf2op44IpvIKDgW/DY4AammydSSk9RQ?=
 =?iso-8859-1?Q?iXYfagHCwmDwF4YsVom7wnVyVnEb9K9eJBFVpkryoTri1ye2Ul8g/ukIv0?=
 =?iso-8859-1?Q?NtLewo+OfbISXI00k0oq2+qRwnA1pIAp9E1sr5b/iYxJUlWVzkUgM3DEPy?=
 =?iso-8859-1?Q?OsgPaWhMg0Xm82GOq9B90Yq1tIWyhkByaQ0OxgwA2Mq8DtnEF+MERDr/g0?=
 =?iso-8859-1?Q?jjwbk2hlp0BdkwTUcElc2og3dhAikORKJvmYtu31zvqXes3W/OS4We7ZBr?=
 =?iso-8859-1?Q?lIrj/pTmGSB/37pBgedCWLPC60FYGfvD9tHjrJ64HzPVUDEVrL5JbhIAJ2?=
 =?iso-8859-1?Q?G5QCMNYxD6+epLx+e7jVN/B22zeFyAjmCrN7ZRhvPQKnRo757SMSrg8ViB?=
 =?iso-8859-1?Q?wEPoBBKQkqrrRhtcMV5/1uQg0OVmNN/+nTJMI2Pcd0opOes53n071R1BSg?=
 =?iso-8859-1?Q?kAhGu8t+1KJCgRNi60o8NQFa3nKGgSFRpPPJijK8p0Jr5rToKmr1FhDbtE?=
 =?iso-8859-1?Q?qoudxzzN9kYlzzfLmDvUasgNXa0dyfxIxtQX//mu+6by2H7gvVauNcdFhq?=
 =?iso-8859-1?Q?L1a+CoSDD0RNfkthdxBXZixJ3iRAKr3ciTtIT5W9LfsB6WzRUYtO+0F8U/?=
 =?iso-8859-1?Q?0Ne94xnVUy484b7D6bG535EGxgFDTOObBJLmuJNC7yO+pqoDbUJDeIYLEe?=
 =?iso-8859-1?Q?QFEMMqI2wQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: kUyn9nDjEBTVE/IXoqzG1+kf45yinuJlGKsJLcBM03gg0v87iya4zgVUly/N7M28sNPooPk7Zazc3PIdrxDeRCOT5t2X2mtUlPev+jqBX4GqBK7fgVTjftg7FZcvxzK+h1rYekHlcTVIucAGijbss48LbKmz5fKf37eYXC1XjYQFp0Ig5ntPfYp7K4trUSqfYyaQYMhfKhMi3tJpxmLjf60r/LmzebVizExCKk4idu3TIYNPyBKpmhw4YEPLxRgj0eHTO1AoiR30g/ROpoisPE50LyrCAGVKQWpAMo4ve2sL+2Kzn3A7BmpSz6XpQKN0DAYQC9W4RwEU9iFG8g88tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be67631-7b83-40ec-a490-08df3e7485f5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:17:09.6703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrfbKd0Gg6ugjrYhBoy5ArIJML5y7aLi37n1mS6GwqR09K7JRIJ0cECK7JlMtG4nHkV6yxEeEICDcbcahUy/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7DB70F9CE
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 06:18:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] drm/drm_ras: unsynchronized xa_load() node lookup in telemetry
>   handlers
> - [Medium] drm/drm_ras: broken status handling and non-standard UAPI in
>   telemetry ops
> --
> 
> commit 136edf60d4fd4d79aaeb6f30bb50fe8f150aa0fe
> Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> 
> drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
> 
> This commit extends the DRM RAS Generic Netlink specification and driver
> interface with a telemetry node type and operations to list, read, and
> write device telemetry fields.
> 
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index a88fdab7a1c74..cf015bba020d0 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> [ ... ]
> > @@ -100,6 +100,34 @@ attribute-sets:
> >          name: error-value
> >          type: u32
> >          doc: Current value of the error counter.
> > +  -
> > +    name: telemetry-attrs
> > +    attributes:
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: >-
> > +             Unique identifier for the node.
> > +             Assigned dynamically by the DRM RAS core upon registration.
> > +      -
> > +        name: field
> > +        type: u32
> > +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> > +      -
> > +        name: field-name
> > +        type: string
> > +        doc:  Name of the telemetry field defined by the device's uAPI.
> > +      -
> > +        name: value
> > +        type: sint
> > +        doc: Value of telemetry field that was read/written.
> > +      -
> > +        name: status
> > +        type: s32
> > +        doc: >-
> > +             Status of the telemetry operation.
> > +             Populated by the device in response to the performed
> > +             telemetry operation. Errors may be hardware specific.
> >  
> >  operations:
> >    list:
> > @@ -198,6 +226,52 @@ operations:
> >              - node-id
> >              - error-id
> >              - error-threshold
> > +    -
> > +      name: telemetry-get
> > +      doc: Perform a read of the specified telemetry field.
> > +      attribute-set: telemetry-attrs
> > +      do:
> > +        pre: drm-ras-nl-pre-telemetry
> > +        request:
> > +          attributes:
> > +            - node-id
> > +            - field
> > +        reply:
> > +          attributes:
> > +            - value
> > +            - status
> > +      dump:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes: &telemetry-field-attrs
> > +            - field
> > +            - field-name
> > +    -
> > +      name: telemetry-set
> > +      doc: >-
> > +           Perform a write of the specified telemetry field.
> > +           Telemetry writes are device specific, and may be used to set
> > +           device limits or other capacities, for example.
> > +      attribute-set: telemetry-attrs
> > +      flags: [admin-perm]
> > +      do:
> > +        pre: drm-ras-nl-pre-telemetry
> > +        request:
> > +          attributes:
> > +            - node-id
> > +            - field
> > +            - value
> > +        reply:
> > +          attributes:
> > +            - status
> > +      dump:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes: *telemetry-field-attrs
> 
> [Severity: Medium]
> Does the telemetry Netlink UAPI and its status handling work as intended
> when a device reports an error?
> 
> In drm_ras_nl_telemetry_get_doit() and drm_ras_nl_telemetry_set_doit(), a
> non-zero return from node->telemetry_get() or node->telemetry_set() frees
> msg and returns immediately without serializing
> DRM_RAS_A_TELEMETRY_ATTRS_STATUS.  Conversely, if the callback returns 0
> with a non-zero status, drm_ras_nl_telemetry_get_doit() still serializes a
> zero DRM_RAS_A_TELEMETRY_ATTRS_VALUE alongside status and bypasses standard
> Netlink NLMSG_ERROR and extack reporting:
> 
> drivers/gpu/drm/drm_ras.c:drm_ras_nl_telemetry_get_doit() {
>     ...
> 	ret = node->telemetry_get(node, &field, &value, &status);
> 	if (ret) {
> 		nlmsg_free(msg);
> 		return ret;
> 	}
> 
> 	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
>     ...
> 	ret = nla_put_sint(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, value);
>     ...
> }
> 
> In addition, telemetry-set attaches a dump callback to a set command to
> enumerate writable fields, telemetry-get returns different objects in do
> ([value, status]) versus dump ([field, field-name]), and telemetry-attrs
> exposes board temperatures, voltages, power, and TDP limits as device-
> specific field IDs and unitless integers rather than through hwmon.
> 
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index 4f4777060a4e8..fda50563c4a54 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> [ ... ]
> > @@ -617,6 +644,285 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> > +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
> > +			     struct genl_info *info)
> > +{
> > +	struct drm_ras_node *node;
> > +	u32 node_id;
> > +
> > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	if (node->telemetry_pre)
> > +		return node->telemetry_pre(node);
> > +
> > +	return 0;
> > +}
> [ ... ]
> > +int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct drm_ras_node *node;
> > +	struct sk_buff *msg;
> > +	struct nlattr *hdr;
> > +	u32 node_id, field;
> > +	s32 status = 0;
> > +	s64 value = 0;
> > +	int ret = 0;
> > +
> > +	if (!info->attrs ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
> > +		return -EINVAL;
> > +
> > +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > +
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node || !node->telemetry_get)
> > +		return -ENOENT;
> > +
> > +	if (!telemetry_fields_contains(node->telemetry_fields_gettable, field))
> > +		return -EINVAL;
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(msg, info);
> > +	if (!hdr) {
> > +		nlmsg_free(msg);
> > +		return -EMSGSIZE;
> > +	}
> > +
> > +	ret = node->telemetry_get(node, &field, &value, &status);
> 
> [Severity: High]
> Can the unlocked xa_load() lookups in the telemetry handlers race with
> drm_ras_node_unregister() and cause a use-after-free?
> 
> drm_ras_nl_family sets .parallel_ops = true, and xa_load() only holds the
> RCU read lock during the XArray walk itself.  drm_ras_nl_pre_telemetry(),
> drm_ras_nl_telemetry_get_doit(), drm_ras_nl_telemetry_get_dumpit(),
> drm_ras_nl_telemetry_set_doit(), and drm_ras_nl_telemetry_set_dumpit() use
> the returned node pointer without holding a lock or reference across
> GFP_KERNEL allocations and sleeping driver callbacks, while
> drm_ras_node_unregister() only calls xa_erase() before the caller frees the
> node:
> 
> CPU0                                  CPU1
> drm_ras_nl_telemetry_get_doit()
>   node = xa_load(&drm_ras_xa, id);
>   genlmsg_new(..., GFP_KERNEL);
>                                       drm_ras_node_unregister(node)
>                                         xa_erase(&drm_ras_xa, node->id);
>                                       kfree(node);
>   node->telemetry_get(node, ...);  <-- use-after-free
> 
> Because drm_ras_nl_pre_telemetry() and the doit handlers also perform
> separate unlocked xa_load() calls instead of pinning the node in pre_doit
> and releasing it in post_doit, node_id can be unregistered and reallocated
> to a different node between the permission check and the operation.

Perhaps we should only do xa_load in the pre_doit and stash it with a put
in a post_doit?! or something like that?!...

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com?part=2
