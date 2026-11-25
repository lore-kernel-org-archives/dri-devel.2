Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61E606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WgL8AKux;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Q7ibJogl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CEF10E8EB;
	Wed, 25 Nov 2026 19:00:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFD510E004;
 Wed, 25 Nov 2026 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795633189; x=1827169189;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EIuNTycPoRrfxJs+SIgj3OrrUWv8tkji75otvzFoKoI=;
 b=WgL8AKuxE9Qf7fBz1YeHZM8XrrHM6gbL5V5SM83BOUX0vWRKVSdhX8UX
 +Lng4P08y2DQjvvp4vNdaQQ/d03bSg1G1kTR6y4k/E73TGP6FHIEjSemH
 0isH6BV6y4e6mRkm/I7RGT6vE+15l09WS1uj0PPVCd6CjPw6hLRAAs+Us
 f5kvPoZKLSRqrt0c14a7iCy22Gy+y17ZNSdiuQ7WK46on4FC0cz8Jtz4K
 daFMqk50MDeqNd60ML3xqfyq+vn/0lRnOyb6NZIl5K5JtlijIGHezLj2F
 vccAriPCXZpMK4K3VYYTfGofDe5i1NxvZtrkNvAi55Tu8UACNWxIsnWtT Q==;
X-CSE-ConnectionGUID: EH21vZz3SwS70j22Uz4Xog==
X-CSE-MsgGUID: r5+/QwvRSrWoS0fAP0Zi9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4421801"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4421801"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 10:59:49 -0800
X-CSE-ConnectionGUID: MaYQbLoyQlCxklXHgECmiw==
X-CSE-MsgGUID: eyd1GsLBSuCZUR+GnoyPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="11930965"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 10:59:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 10:59:48 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 10:59:48 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 10:59:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQL9zgDslxZYu+cKpjtzIIVH2HdfByMYSIebFILco1q/14NqEqn5bpiWwHiQQIaojJzLOx1aZfaeRdhac0uV84UC3OqffwI0KXpX6HWKW+NMjpOccopnSwVYq9/GHj6FaLQSwOrB0hvKF+pYm4yc/w8GH5yzRtGHy6fXyM9DyPGUE58b2ZW2RtHmfRCmnygtWfziPvhsYVpgOZ/EpVPAiJL/Z81y/yTs4cgk1mHK7YlwtRpMfgQcMck3/PapYoFAE9CYunLyk2ttCNYqv9S3DvTIEJFqTGJINtbP1NQCUWotyp9ffXF8HkeLySu0zq03bvWzARhOZxe11AhVl2PDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6tPT7In7vkt8HASFxuLaV0Xfj3COiP+CIyIi8Quywo=;
 b=yIPkuZGsll1PcgL4efxz+snTlqoAoEyKXwUupvTpr7oDlVs6HrUYiE3XtlwMGQtTfS67haXAXcqpnOFYwEn2ktTpC6r1Z7fg59+A9Rs+xjLa86EhzMkh6yurDTS2gnpJfskKDgQEnBmdWLG3hi29lp7BpZcR5haCrxA7/9fSkSN2wSbe6spehkx8iUCC35cujiliqd7aExZC/pAUv1nX6iq0iR27ydwfAeGVFp/la7RPOKNIBLHW5vbhIFDiVfGkSiGWtQOGK5qUUwSt1Wo51a15DElH/009kGSwfxZ1riugyxwcsFcBQ/vKO1Dt1yv1mLkbMnsY3rzJzUAsRZxgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6tPT7In7vkt8HASFxuLaV0Xfj3COiP+CIyIi8Quywo=;
 b=Q7ibJoglt23SB+Bxq9H9jQ2hjA164k++PWE0x3IZ3RDENxI3+dk6hsGq7haVxDm1blAxeAfNkA+k0OPa2E+qFO80IOGrhPTcQxpMg9Sogx38T5vOFXNTrZvQlDag9rgzsYWKOKYwrEz4IsPAyE+5eXT255cbRqeUaeHhzChOzxY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 18:59:35 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 18:59:35 +0000
Date: Wed, 25 Nov 2026 13:59:32 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] drm/ras: Add retired-pages node type
Message-ID: <awcwFHXV25lieJic@intel.com>
References: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
 <20261124203833.3618507-5-rodrigo.vivi@intel.com>
 <90a912c9-2936-49c9-bdce-1267825f1678@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90a912c9-2936-49c9-bdce-1267825f1678@intel.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|PH7PR11MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b948b8f-0933-4520-0e0d-08df4b263f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|261022075727099003|261022113327099003|261022105027099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: paS4LGJqnOa1DJF10FWuFYf7gzN+xMpivXnMuvpum5kd13sUtsdPAX7EX3BTln4JD/YTlW5mFplMTpsAR4pcMr5E9cXTgE4mbrbTZzm9C064Jzi/xghxRNr3rCrju+sNIALzYNRyvL58mkQA3Jkm0oIA+4TBr84ljX12Dv+o3RQHynKwybdLdQvoeKjEvRrRmRYmTmie5Q9GdKa4uZiyq9mHTVUltARfT7ughIVYuwzEbhbFpXpqAHFiab0d+nKOBjJbnP5RqPde9NssoRbQKcKSHhMTXvMMgPexMD6qAiLECZN7+AclBktSK8hoXFPXUyNQGqrWMfxY0OWTq2+8IIPA7znAHLEIvuwHUrDeFDWV2ti/iXrLhryeKTrXoWbTzElkVAbhRnw4Y6h/mLCphAJGOkdfSFWk+8b9RS0eYDn5ShsGQX1Z+pT6QIokIMWdazckx2sOYVb60ew3kPqgsp4kd7X6FoX/N8Bi5oBvRgZe+rIhLYH6VI1JQJea/0GbmoAvIonYLAcuy0U7osbUXJHhSPG/FcLOA+LvmFcMMYA76ivt2FXFT5N1s6W5TJ/L2LiwmfQAbNv8eIPi+wMUjB+0RSVV+wWhMq5/u50BgBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261022075727099003)(261022113327099003)(261022105027099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MAhQ3wpjq5yf1fIZAGeBruaKp+nAYF1m2N4jLFIE99xUmyqz7K3botQlfR?=
 =?iso-8859-1?Q?C30fSoNRnMJwN41DWS9eyJMYZK4DF7bjpyY7hkJz/J019rdzmYvG71AyXN?=
 =?iso-8859-1?Q?XL4BU8CgbZoB2dJg6VnKZ7Y8o8AI4mz8S8cSc1LcwnFlsvX6NizMoJTTrw?=
 =?iso-8859-1?Q?I2d3ol4ERbzrgcv68KcsFVxjaoWBB5P8LqTPkH7uorN4Np2BtHOGagJhok?=
 =?iso-8859-1?Q?itO0QIcT7iDlZcTKkLMk5cT0foQhyM6S/CDG0Lo/sBgT9CBi47jlrgkiJB?=
 =?iso-8859-1?Q?1ZaaTS1Fc53ZsNM3ZUcqY1xzTcy5waiEx3rHJbkVedlDxBBIojNDgkAc+3?=
 =?iso-8859-1?Q?yFEKd6gSAvdeUN1oGADz7i3lZTPMzC8o9fTI7e/HH/5clZhJrzInoJbWLt?=
 =?iso-8859-1?Q?SWW/wNau8QZWx/f0x9JwHOmpPnRwp4SEgZ3FhV3tU7NtaQHW9NVTvc0t1x?=
 =?iso-8859-1?Q?VZZ+hEvnY7W70Ka1rc4lt6rwTTZxS7sIafH/p9NKhapJIiRw79QWJvxhJx?=
 =?iso-8859-1?Q?MnrTgjxFP+6Wr/0rRe6PY/GRW3TYB/y+Rs4k1Cm5AZzZe8y97iTAFDck7C?=
 =?iso-8859-1?Q?8FCculnc8h90jmg2+7xrxX0RGNDPYDNPCgt86N6ZN2CUWoDlBVbptCuy2m?=
 =?iso-8859-1?Q?wZjFEbgR1uSO2ptWwLYd58BQNdMqvGP28sjSlZ3NDS7f/7rsgp6IHK/4pe?=
 =?iso-8859-1?Q?z+yXd5qZ9Sy2CJrhznz+ygJOZbCE9DyWrvb5s+wNP0B+9Ykw0XAomA14BS?=
 =?iso-8859-1?Q?ey6diUiSsIGdd9L8npy5nkdADnw9ACO7DJNjwNXnv7dBHllYnzmF53u4g8?=
 =?iso-8859-1?Q?Y+lvA/xB33uneiiULziGIGXXGpcpkJqZ1gPp/xHJXXfpCwWoqO8drU6JAY?=
 =?iso-8859-1?Q?ZIRnH3ToagbLt175pJrLsQB1onnBhZLPJESbJZOnZ5ZDcnjX3UB07RgNUM?=
 =?iso-8859-1?Q?gTOCQHyk/PDblhW49EVpccb1enhLXsDKw+349xVbrOGznXAfBnoP4VvrSR?=
 =?iso-8859-1?Q?Mp1WBl7eDze28W+sj5oXSv87Mz6DogCwpgV//Of8WGgnQEwa69+Y+f9lAO?=
 =?iso-8859-1?Q?2O0LdO5qnRoD8RMpOrToVehtFyFNuZVTIyMf8DNAFq7gsHw+KpeD4auUF8?=
 =?iso-8859-1?Q?IAQwDMlg5kHUaZPy2oosZQdWnaL1MW+UbM0Nm1crkYN5l1EUUycrTYgSIG?=
 =?iso-8859-1?Q?SvovYtiwzVs9lG6wQiEZVFssuzkbtZfhdIOWcmav/ExQxg9pN8H8sPcvlC?=
 =?iso-8859-1?Q?SdlzkbnNjjBuuHpHm5q+kNwR4+5o80oZ78bFdIi21TF18VKZJZC9tdvNJ+?=
 =?iso-8859-1?Q?SIKkJQIG02sXoNLcq9jQ0SlzVC7RlALFY7qbBbUdJ5uHSpcCfp6hReUc9r?=
 =?iso-8859-1?Q?FlPYwNmMkm1YnxyRRVoiFJukj+BES/qQqlnQlDLqhSfZWHpU+qo59OnOdu?=
 =?iso-8859-1?Q?e6Rh08cExtYjwoEaaDVzhNmIX4RJziySQESYA2hIrs+BNNF73vc7ezjlJJ?=
 =?iso-8859-1?Q?s38T7eORpYuxlizECJ8c5fGLSoLPApuzqSpit/QevxQ+OwbUdmFXvWzSk2?=
 =?iso-8859-1?Q?ELHOVJVzTjIsOuVUWPmhPzSBQIE5yxE48NzwROkr0hdi264w8lHubSM0zN?=
 =?iso-8859-1?Q?L93bf7EXayumKICNMPckQip5iEsM351uOXsYVLdIjwIs0bFyrQlYVmJ3T3?=
 =?iso-8859-1?Q?lqx3UyLLCn9HUbi8kEF/mecitJ4tRGlomALi5mj3+mVb/saxAwqsYmb7M8?=
 =?iso-8859-1?Q?moT67/aOHks707SPwbWfR+ntM70DTluAnqBSwwMMdqpWFq1075EiPHPkJl?=
 =?iso-8859-1?Q?QwtIsrPxlA=3D=3D?=
X-Exchange-RoutingPolicyChecked: jgl4gjTUK1FR3UlKl8WrASHzV61gk8fUaFyxwBsw9n8l5KpxPFI+MN3kVwF9uBsswxXJUD59ZeI06TNhnBCB2NxCwOWgGSZzXO7oJSiWX4MEBh7eY7lggvekzH3FgDyRWnjNjab653NDcSRvMi1eZnrprSS6TbBdxg/nZ8Q50S5jJKxMDuNngrqvJeb7YJm4KYPGWPYgJvdLJoAXmcQHkFpmDs7hnARIcs6Arim7eBbarYfp96AiPnyYMy2F3YVSSDG5+EPv1C1qXR6KbVk1rrqeV9Q1U3LZDgvhfc8QjG1XdqoeR/XDgVjjobenyq41EiI6dJRQ+N+Zuzv9/uZ6Ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b948b8f-0933-4520-0e0d-08df4b263f6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:59:35.7716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYIYVZGfK/7HuC/bwFP7Itwq5aFEeiF8nGYl1BQfSnm2fYjMNXcoX7viEhld6mMTZcSFXqg9ldd3zxYCZqmQIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 04:45:38PM +0530, Tauro, Riana wrote:
> Hi Rodrigo
> 
> On 25-11-2026 02:08, Rodrigo Vivi wrote:
> > From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > 
> > Add a retired-pages node type to drm-ras so drivers can report the
> > memory pages they have taken out of service, with two operations:
> > 
> >   - get-retired-pages: dump one entry per page with its address, size
> >     and status (retired, pending or failed). The dump is flagged with
> >     NLM_F_DUMP_INTR if the list changes while it is read.
> >   - get-retired-pages-info: return the maximum number of pages that can
> >     be retired.
> > 
> > v3 (Rodrigo+LLM):
> >   - Split the drm-ras core from the xe user.
> >   - Flatten the page attributes and name the node type retired-pages
> >     instead of retired-resources, avoiding the over-wrapping
> >     anti-pattern pointed out by Jakub: the type-specific nest and the
> >     resource-type enum are gone.
> >   - Use uint for address, size and max-pages, no pad (Jakub).
> >   - Start the status enum at 1.
> >   - Move max-pages to its own do operation instead of a leading dump
> >     entry.
> >   - Set NLM_F_DUMP_INTR from a driver generation counter.
> >   - Report unknown node IDs with NL_SET_BAD_ATTR.
> >   - Removed deprecated Assisted-by tag.
> > 
> > v4 (Rodrigo+LLM):
> >   - Check the dump consistency once a page message is filled (Sashiko),
> >     and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
> >     not lost.
> >   - Make the error-counter operations reject other node types (Sashiko).
> >   - Hold a node reference in the new handlers (local Sashiko).
> >   - Rebase on the telemetry node type, moving the type check of its
> >     handlers into drm_ras_node_get().
> > 
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Riana Tauro <riana.tauro@intel.com>
> > Cc: Raag Jadav <raag.jadav@intel.com>
> > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> > Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >   Documentation/netlink/specs/drm_ras.yaml |  74 +++++++-
> >   drivers/gpu/drm/drm_ras.c                | 226 +++++++++++++++++++++--
> >   drivers/gpu/drm/drm_ras_nl.c             |  24 +++
> >   drivers/gpu/drm/drm_ras_nl.h             |   4 +
> >   include/drm/drm_ras.h                    |  49 +++++
> >   include/uapi/drm/drm_ras.h               |  31 +++-
> >   6 files changed, 388 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index 0f1ceb705d3d..bc17d22e2156 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -16,16 +16,28 @@ definitions:
> >       type: enum
> >       name: node-type
> >       value-start: 1
> > -    entries: [error-counter, telemetry]
> > +    entries: [error-counter, telemetry, retired-pages]
> >       doc: >-
> >            Type of the node. The error-counter nodes expose reliability counters
> > -         for a hardware/software component, and telemetry nodes expose an
> > -         interface for reading and writing telemetry values to a device.
> > +         for a hardware/software component, telemetry nodes expose an
> > +         interface for reading and writing telemetry values to a device, and
> > +         retired-pages nodes list the memory pages that have been taken out
> > +         of service.
> 
> 
> I noticed the node type was changed.
> Earlier reviews mentioned reusing the node for other resources, such as
> fabric
> https://patchwork.freedesktop.org/patch/749454/?series=173066&rev=1
> Could you please help understand why this was changed? Are we not re-using
> it?

avoiding the anti-pattern issue raised by Jakub.

Reusing it needed a resource specific nest and a resource type enum,
which is the over-wrapping Jakub pointed out. Fabric would not have
addresses and sizes anyway, so it fits better as its own node type,
and the node type enum can grow without breaking anything.

> 
> >     -
> >       type: flags
> >       name: telemetry-field-mode
> >       entries: [read, write]
> >       doc: Bitmask of access modes supported by a telemetry field.
> > +  -
> > +    type: enum
> > +    name: retired-page-status
> > +    value-start: 1
> > +    entries: [retired, pending, failed]
> > +    doc: >-
> > +         Status of a retired page. retired means the page is reserved and out
> > +         of service; pending means the retirement is queued but the
> > +         reservation is not complete yet; failed means the reservation failed
> > +         and the page may still be in use.
> >   attribute-sets:
> >     -
> > @@ -140,6 +152,30 @@ attribute-sets:
> >           doc: >-
> >                Bitmask of access modes (read/write) supported by the
> >                telemetry field.
> > +  -
> > +    name: retired-page-attrs
> > +    attributes:
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: Node ID targeted by this retired pages operation.
> > +      -
> > +        name: address
> > +        type: uint
> > +        doc: Device address of the retired page.
> > +      -
> > +        name: size
> > +        type: uint
> > +        doc: Size of the retired page in bytes.
> > +      -
> > +        name: status
> > +        type: u32
> > +        doc: Retirement status of the page.
> > +        enum: retired-page-status
> > +      -
> > +        name: max-pages
> > +        type: uint
> > +        doc: Maximum number of pages that can be retired on this node.
> >   operations:
> >     list:
> > @@ -287,6 +323,38 @@ operations:
> >               - field
> >               - field-name
> >               - mode
> > +    -
> > +      name: get-retired-pages
> > +      doc: >-
> > +           Retrieve the pages retired on a retired-pages node, one entry per
> > +           page. The dump is flagged as interrupted if the list changes while
> > +           it is being read.
> > +      attribute-set: retired-page-attrs
> > +      flags: [admin-perm]
> > +      dump:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes:
> 
> Nit:For large number of pages, size and node-id would be repetitive

v5 drops node-id from the dump entries, like the error-counter dump.
The size stays per page, so a node can report pages of different
sizes, if a device ever retires memory at more than one granularity.

> 
> > +            - node-id
> > +            - address
> > +            - size
> > +            - status
> > +    -
> > +      name: get-retired-pages-info
> 
> max-pages since it's not generic ? Or maybe we can add size as part of info
> since it will remain same per node.

With the size per page, the info is only max-pages for now, and the
operation can grow if more node limits come up.

> 
> > +      doc: >-
> > +           Retrieve the retired page limits of a retired-pages node.
> > +      attribute-set: retired-page-attrs
> > +      flags: [admin-perm]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes:
> > +            - node-id
> > +            - max-pages
> >   mcast-groups:
> >     list:
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index 82fcc766b84b..b6e203448d22 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -69,6 +69,14 @@
> >    *     Each field contains the uAPI defined enum string, its numerical value,
> >    *     and its mode bitmask, which encodes read/write capabilities.
> >    *
> > + * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
> > + *     Userspace must provide Node ID.
> > + *     Returns one entry per page with its address, size and status.
> > + *
> > + * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
> > + *     Userspace must provide Node ID.
> > + *     Returns the maximum number of pages that can be retired.
> > + *
> >    * Node registration:
> >    *
> >    * - drm_ras_node_register(): Registers a new node and assigns
> > @@ -121,6 +129,13 @@
> >    *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
> >    *       to enforce permissions checks on telemetry operations.
> >    *
> > + * - RETIRED_PAGES:
> > + *     + The driver must implement the query_retired_page() callback, returning
> > + *       the retired page with the lowest address at or above a cursor, and
> > + *       -ENOENT when there is none.
> 
> With many retired pages (say 10,000 or more), the dump calls into the driver
> once per page.
>  From a quick look, the driver walks over the list to find lowest address
> and for such large number
> of pages would cause a noticeable delay
> Wouldn't it be better to take a snapshot?

I'd like to get the basic support in first.

Anyway, the list is limited by max-pages the firmware can track,
so it is not an issue in practice.
Also, if we ever have that many bad pages we have bigger problems
than the dump time.

So, the v5 that I'm about to send won't include that, but anyway the
patch with the snapshot is ready and tested, for a follow-up:
https://github.com/rodrigovivi/linux/commits/xe-ras-retired-pages-snapshot

Thanks,
Rodrigo.

> 
> Thanks
> Riana
> 
> > + *     + The driver can implement query_retired_pages_info() to report the
> > + *       maximum number of pages that can be retired.
> > + *
> >    * Netlink handlers:
> >    *
> >    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> > @@ -147,6 +162,10 @@
> >    * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
> >    *   dumpit operation, enumerating all telemetry fields and their supported
> >    *   access modes for a telemetry node.
> > + * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
> > + *   operation, listing the retired pages of a specific node.
> > + * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
> > + *   doit operation, fetching the retired page limits of a specific node.
> >    */
> >   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > @@ -162,6 +181,8 @@ struct drm_ras_ctx {
> >   	unsigned long restart;
> >   	/* Node targeted by a telemetry get/set doit */
> >   	struct drm_ras_node *node;
> > +	/* Which retired page address to restart the dump from */
> > +	u64 cursor;
> >   };
> >   static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> > @@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> >   /**
> >    * drm_ras_node_get() - Look up a RAS node by ID and take a reference
> >    * @node_id: ID of the node to look up
> > + * @type: Expected type of the node
> >    *
> >    * Looks the node up in the global xarray and, if found, takes a reference to
> >    * it so that it cannot be freed while the caller is using it. The lookup and
> > @@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> >    *
> >    * The caller must drop the returned reference with drm_ras_node_put().
> >    *
> > - * Return: the referenced node, or NULL if no node with @node_id is registered.
> > + * Return: the referenced node, or NULL if no node of @type with @node_id is
> > + * registered.
> >    */
> > -static struct drm_ras_node *drm_ras_node_get(u32 node_id)
> > +static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
> >   {
> >   	struct drm_ras_node *node;
> >   	xa_lock(&drm_ras_xa);
> >   	node = xa_load(&drm_ras_xa, node_id);
> > -	if (node)
> > +	if (node && node->type == type)
> >   		refcount_inc(&node->ref);
> > +	else
> > +		node = NULL;
> >   	xa_unlock(&drm_ras_xa);
> >   	return node;
> > @@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> >   	u32 value;
> >   	int ret;
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
> >   	u32 threshold;
> >   	int ret;
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -699,7 +724,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> >   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node || !node->clear_error_counter) {
> >   		drm_ras_node_put(node);
> >   		return -ENOENT;
> > @@ -770,7 +795,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> >   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> >   	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -781,6 +806,176 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> >   	return ret;
> >   }
> > +static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
> > +{
> > +	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
> > +	struct drm_ras_node *node;
> > +
> > +	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
> > +	if (!node)
> > +		NL_SET_BAD_ATTR(info->extack, attr);
> > +
> > +	return node;
> > +}
> > +
> > +static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
> > +				const struct drm_ras_retired_page *page)
> > +{
> > +	int ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
> > +}
> > +
> > +static int dump_retired_pages(struct sk_buff *skb, struct netlink_callback *cb,
> > +			      struct drm_ras_node *node)
> > +{
> > +	const struct genl_info *info = genl_info_dump(cb);
> > +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> > +	struct drm_ras_retired_page page;
> > +	void *hdr;
> > +	int ret;
> > +
> > +	for (;;) {
> > +		ret = node->query_retired_page(node, ctx->cursor, &page);
> > +		if (ret && ret != -ENOENT)
> > +			return ret;
> > +
> > +		/* Never zero, so the first message is checked as well */
> > +		cb->seq = page.generation + 1;
> > +		if (ret == -ENOENT)
> > +			return 0;
> > +
> > +		hdr = genlmsg_iput(skb, info);
> > +		if (!hdr)
> > +			return -EMSGSIZE;
> > +
> > +		ret = msg_put_retired_page(skb, node->id, &page);
> > +		if (ret) {
> > +			genlmsg_cancel(skb, hdr);
> > +			return ret;
> > +		}
> > +
> > +		genl_dump_check_consistent(cb, hdr);
> > +
> > +		genlmsg_end(skb, hdr);
> > +		ctx->cursor = page.address + 1;
> > +	}
> > +}
> > +
> > +/**
> > + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
> > + * @skb: Netlink message buffer
> > + * @cb: Callback context for multi-part dumps
> > + *
> > + * Appends one message per retired page, in increasing address order. The
> > + * dump resumes from the next address after a buffer overflow, and is flagged
> > + * with %NLM_F_DUMP_INTR if the list changed between messages.
> > + *
> > + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
> > + *         (requires multi-part continuation), or a negative error code on
> > + *         failure.
> > + */
> > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > +					struct netlink_callback *cb)
> > +{
> > +	const struct genl_info *info = genl_info_dump(cb);
> > +	struct drm_ras_node *node;
> > +	int ret;
> > +
> > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node = get_retired_pages_node(info);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	ret = dump_retired_pages(skb, cb, node);
> > +	drm_ras_node_put(node);
> > +
> > +	return ret;
> > +}
> > +
> > +static int doit_reply_retired_pages_info(struct genl_info *info, struct drm_ras_node *node)
> > +{
> > +	struct sk_buff *msg;
> > +	u64 max_pages;
> > +	void *hdr;
> > +	int ret;
> > +
> > +	if (!node->query_retired_pages_info)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = node->query_retired_pages_info(node, &max_pages);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(msg, info);
> > +	if (!hdr) {
> > +		ret = -EMSGSIZE;
> > +		goto free_msg;
> > +	}
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	genlmsg_end(msg, hdr);
> > +
> > +	return genlmsg_reply(msg, info);
> > +
> > +cancel_msg:
> > +	genlmsg_cancel(msg, hdr);
> > +free_msg:
> > +	nlmsg_free(msg);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
> > + * @skb: Netlink message buffer
> > + * @info: Generic Netlink info containing attributes of the request
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> > +					   struct genl_info *info)
> > +{
> > +	struct drm_ras_node *node;
> > +	int ret;
> > +
> > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node = get_retired_pages_node(info);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	ret = doit_reply_retired_pages_info(info, node);
> > +	drm_ras_node_put(node);
> > +
> > +	return ret;
> > +}
> > +
> >   /**
> >    * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
> >    * @ops: Generic netlink operations
> > @@ -808,10 +1003,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
> >   		return -EINVAL;
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -	node = drm_ras_node_get(node_id);
> > -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> > +	if (!node) {
> >   		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -		drm_ras_node_put(node);
> >   		return -ENOENT;
> >   	}
> > @@ -892,10 +1086,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -	node = drm_ras_node_get(node_id);
> > -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> > +	if (!node) {
> >   		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -		drm_ras_node_put(node);
> >   		return -ENOENT;
> >   	}
> > @@ -1100,7 +1293,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
> >   	if (!node->device_name || !node->node_name)
> >   		return -EINVAL;
> > -	/* Currently, only Error Counter and Telemetry endpoints are supported */
> >   	switch (node->type) {
> >   	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> >   		/* Mandatory entries for Error Counter Node */
> > @@ -1112,6 +1304,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
> >   		if (!node->telemetry_get || !node->telemetry_fields)
> >   			return -EINVAL;
> >   		break;
> > +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
> > +		if (!node->query_retired_page)
> > +			return -EINVAL;
> > +		break;
> >   	default:
> >   		return -EINVAL;
> >   	}
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index 589c6445eff7..c56220205876 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
> >   	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> >   };
> > +/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
> > +static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> > +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +};
> > +
> > +/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
> > +static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> > +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +};
> > +
> >   /* Ops table for drm_ras */
> >   static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   	{
> > @@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
> >   		.flags		= GENL_CMD_CAP_DUMP,
> >   	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
> > +		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
> > +		.policy		= drm_ras_get_retired_pages_nl_policy,
> > +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> > +	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> > +		.doit		= drm_ras_nl_get_retired_pages_info_doit,
> > +		.policy		= drm_ras_get_retired_pages_info_nl_policy,
> > +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> >   };
> >   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index 7a1cba70fd50..880b0c2befe3 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
> >   int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
> >   int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
> >   					    struct netlink_callback *cb);
> > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > +					struct netlink_callback *cb);
> > +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> > +					   struct genl_info *info);
> >   enum {
> >   	DRM_RAS_NLGRP_ERROR_REPORT,
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 76bdcc6f96a5..5c3900a53278 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
> >   	u32 mode;
> >   };
> > +/**
> > + * struct drm_ras_retired_page - A retired page reported by a driver
> > + */
> > +struct drm_ras_retired_page {
> > +	/** @address: Device address of the page. */
> > +	u64 address;
> > +	/** @size: Size of the page in bytes. */
> > +	u64 size;
> > +	/** @status: Retirement status (enum drm_ras_retired_page_status). */
> > +	enum drm_ras_retired_page_status status;
> > +	/**
> > +	 * @generation: Generation of the retired page list, changed by the
> > +	 * driver whenever a page is added, removed or changes status.
> > +	 */
> > +	u32 generation;
> > +};
> > +
> >   /**
> >    * struct drm_ras_node - A DRM RAS Node
> >    */
> > @@ -184,6 +201,38 @@ struct drm_ras_node {
> >   	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
> >   			     s64 *status);
> > +	/* Retired-Pages Related Callbacks */
> > +
> > +	/**
> > +	 * @query_retired_page:
> > +	 *
> > +	 * This callback is used by drm-ras to list the retired pages of a node.
> > +	 * It must fill @page with the retired page that has the lowest address
> > +	 * greater than or equal to @cursor. @page->generation must be set even
> > +	 * when no page is found.
> > +	 *
> > +	 * The @query_retired_page is a mandatory callback for
> > +	 * retired_pages_node.
> > +	 *
> > +	 * Returns: 0 on success,
> > +	 *          -ENOENT when no page is at or above @cursor, which ends the
> > +	 *                  list.
> > +	 *          Other negative values on errors that should terminate the
> > +	 *          netlink query.
> > +	 */
> > +	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
> > +				  struct drm_ras_retired_page *page);
> > +
> > +	/**
> > +	 * @query_retired_pages_info:
> > +	 *
> > +	 * This callback is used by drm-ras to query the maximum number of pages
> > +	 * that can be retired on a node.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
> > +
> >   	/** @priv: Driver private data */
> >   	void *priv;
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 56e0588af5d5..e7f2da18cc4c 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -12,12 +12,14 @@
> >   /*
> >    * Type of the node. The error-counter nodes expose reliability counters for a
> > - * hardware/software component, and telemetry nodes expose an interface for
> > - * reading and writing telemetry values to a device.
> > + * hardware/software component, telemetry nodes expose an interface for reading
> > + * and writing telemetry values to a device, and retired-pages nodes list the
> > + * memory pages that have been taken out of service.
> >    */
> >   enum drm_ras_node_type {
> >   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> >   	DRM_RAS_NODE_TYPE_TELEMETRY,
> > +	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
> >   };
> >   /*
> > @@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
> >   	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
> >   };
> > +/*
> > + * Status of a retired page. retired means the page is reserved and out of
> > + * service; pending means the retirement is queued but the reservation is not
> > + * complete yet; failed means the reservation failed and the page may still be
> > + * in use.
> > + */
> > +enum drm_ras_retired_page_status {
> > +	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
> > +	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
> > +	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
> > +};
> > +
> >   enum {
> >   	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
> >   	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
> > @@ -73,6 +87,17 @@ enum {
> >   	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
> >   };
> > +enum {
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
> > +
> > +	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
> > +};
> > +
> >   enum {
> >   	DRM_RAS_CMD_LIST_NODES = 1,
> >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > @@ -83,6 +108,8 @@ enum {
> >   	DRM_RAS_CMD_TELEMETRY_GET,
> >   	DRM_RAS_CMD_TELEMETRY_SET,
> >   	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
> > +	DRM_RAS_CMD_GET_RETIRED_PAGES,
> > +	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> >   	__DRM_RAS_CMD_MAX,
> >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
