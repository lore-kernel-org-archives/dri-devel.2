Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7B2F54ABA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A0D10E4E9;
	Tue, 24 Mar 2026 13:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gMILku+h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DD410E4E9;
 Tue, 24 Mar 2026 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774360339; x=1805896339;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=eI92LK/saqnNnIyJUDCXKAwan+LhNCxrS5j0HW40SJk=;
 b=gMILku+hYDQPvgX/eJSi6FZK/2S6vGICFYXIg70twaG6PFajq1Y9Yblx
 Z22przFvkrNHTkjp1VSrRdBH70TIGL0jY0Mjhytue3wRi0/YAbngtnTDb
 MPoSSDMpKZWtGCHSGjEo4AOJXeM2YUq8V6ZvLOGZFIqDfCrY+G4Nz6l2u
 JNvxDT6r8raxq4Q1Eb2m8968brtXl7ri4nYPU4K8dPXaBGULkQDonVdhg
 z4bRKQseJ2fI4FY/TZIUFIfxtf9CrWi/A+tGm8K/2KO3hjLjuuJcV/UcB
 SPye2lJiOgV8omxO7fPxknhuIMU7zxKpuEfJlENfaDz+PEsfLK5N5rS8p A==;
X-CSE-ConnectionGUID: SPs6mwsbT5O7pdBYmYdY1g==
X-CSE-MsgGUID: iIhKlnRsRdOKjyF2GCu6RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75090009"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75090009"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 06:52:18 -0700
X-CSE-ConnectionGUID: PeDQTILpTsyCm8xmKYldjA==
X-CSE-MsgGUID: 3WbdB24GQWukgjo4M2f2rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="247967155"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 06:52:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 06:52:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 06:52:17 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 06:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0U5L38wZ1decOl+bKkSPLg4L7KPvJd/WE1oRFgblzgoejK0hDnyLSPNbU5jixQpjN7UwgTwC3jMwS1mXPJRkdk3lYaHQMGl6rNyLWXhH4K+nCdeSIn8EXTt1QqqxuHX1q6yhPKb9oBUdfndKCcUgfhnnYjplUVcmEOZUBXQoF2qnn9ANAhYoRnTG+aYWTU2TCmf9T7k7YyKLqHMz5G1VaWcxQz+BMXZFFNiY73IHLcd8NSiiuzR3dGJHCuNgcFhdKR1wpkkMC5GseSdZlTf9wE01meVNfZrT32CDQYUfqAN3Lv+mjdyVgZz5KFrcaWgeC2nwFAQZRaO2Bj/EdJIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvTlm4mVtvr5OVrwXxUD+GFyh6mDwxMvVLgQMjHLUDU=;
 b=nQF2uKntoEVdBR06ot9bSn9OXaNAOwHody8XYiOBXlKcibXVfU2pYzkD8yBiP5iHM3O3f3Zm57h2Fio0YibZxEvVDOvqjc/7VxfwlM4nEjpYWtqESoOND2dJQz6DQA/e8n9VJrmtm0UwUQ1TJsTb4ocgKHYokCDVdtrUfuQPYLj43KyQ4RvToQDF4XMfs2QrjDEO/PdUSJRJm3PfP6nUEMHOFeqySmsEVQPGG7WsQxpcvfv7JK+K00fANOwT0gBx6yrdunjNbsGDJJdS5RwDbLhJq8NsBqq7gk/Yl1WkcpYVdUCUvHjDhglRyBLF8cQJ4ACTub6aMwX5Qrgs1nK0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Tue, 24 Mar
 2026 13:52:13 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 13:52:13 +0000
Date: Tue, 24 Mar 2026 09:52:07 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <mripard@kernel.org>,
 <matthew.brost@intel.com>, <riana.tauro@intel.com>, <andrealmeid@igalia.com>
Subject: Re: [PATCH v2 0/3] Update 'none' recovery method for DRM wedged event
Message-ID: <acKXBy3WXzrPERxm@intel.com>
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <aa_OxUm6vthhaorE@black.igk.intel.com>
 <acFJuRlHeJ8OyLi6@black.igk.intel.com>
 <5d2171ca-aa9b-4b8f-9ea3-eabb823ef2d6@amd.com>
 <acH4qEdJwwRApZ0t@black.igk.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acH4qEdJwwRApZ0t@black.igk.intel.com>
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SA3PR11MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 304abdd1-f36e-4bc1-417b-08de89ac8d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 9i8pjmPP7rKh7JdBk98SQ1/1IWjPqB9TXS7toJFh1EP19gbRSadbKYI/ECZJd+o1ucVhE0LDbDZ5BZ5AYwc0zCM/5p/5LZvp9tevOnv5PDgXSDJ9L3Xo0GQor++FtCX4Emrn4ie4L/m11dUwYOJJpdh0n1PyM64GuzjqRgIE1+1nCrmRRQYz0sCAMhwy3Bl0IPbbC2UnO/vs4zXSTX2T2m8xfLI8MNRlMGKG1X8Z4kX6cFhnSGxS2bAHQLKW/UlZ+Tgl0faHEFVKmcsIxCcTiaihfjhkyTB0Dh3JUpYrfgOqE7N/Cpp0fhjV8dI1eZlGwp4M8he9pRdoZHUP8AVF6OYw59eeSgO+VZ62UH+SYlSh5+U/yivlsQcxKI6PeuOIXHAgYm7Em7aQSNc2cKG2hiBwkulyOfNM2wlUeYnSfLmGFihgSxD8WOykBGQwdVDDNJKfEtTYpg/oLJI6VAEov+/KosgItj9yS6Hk7XGf+u/YYOOVcMivBz9wyxkfl99VIQMklj1Trqj/ABW/jzrkuZhM1QMgtn/UkcNH4fyLBd3khW87+XugRiWisdAqbLrSVHI6Ng6hGvuiHnpd7ZDfIlO68Bm42Rg91plW/RGdzsgU7OWZbzEKFAsMw7fLgX6SkvbXml1c+YZPW6UT+fcSyERh+J0fv5r4ezwQ3W+ZRxixFc6w2eD6vww7Xs6hhhEx8z6SNc9IeRWAUpnejWEmBVMP3Ic9r6M162qsqt7T0DE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tGZXyfrwBb9cTuu7/rlvvPD235YP7YeK0PysrqciGne/g5NQAv3XVC79ZT?=
 =?iso-8859-1?Q?Sn9Ic1ot2qQ40JnDyVDNFDFW2RYExRgpkK2u5Vvk2UavjLjz2/k+NyocSU?=
 =?iso-8859-1?Q?i+qH5LGr8e/kF3bEftW+HBPgUo47JtCGHUu+qFFFa4EmAvJesiBFYngO7F?=
 =?iso-8859-1?Q?JylrmpkGvvhxapTevYU85jYaxJBBBGsBNUAdkWfpZ+0Jr+kfqzO9Je2PJL?=
 =?iso-8859-1?Q?e0b3liEnbqC18bdTGUGrM+jbefmy6/CcNn0Hkcd6y2hLQ+TsS0gzduCJxt?=
 =?iso-8859-1?Q?QA8jNyx+xbDZqQwFEYogAKyo2gkAsv2O0vv5wi01zxjtlSngSmtMQMitqe?=
 =?iso-8859-1?Q?aWUW9rk1yv2xcjDxht7FdrzJeTuDDW1A5Ey+TvsK/ZJJk9b9AYXDJavGb7?=
 =?iso-8859-1?Q?ikLegdx1cawSkciY6pupP3uZZzlPrigUowfLq+b9RvgeIXapnwg4U+pq1W?=
 =?iso-8859-1?Q?CPqN+Y280C1w7zZLLW8+ECl9WMmkm0Dnt6AdkYabIymyhmHuZCA0ebr6Me?=
 =?iso-8859-1?Q?M5ifl/weDqd/OkIIax+qC91SfRy3HP7HAAmbnQc+/SdUR2BRVb3ZubUe02?=
 =?iso-8859-1?Q?+THIJA+xUYWWGr0sh75obuyABgh4wAlTsXxuFYfwDanCcu26z30WlqZy8t?=
 =?iso-8859-1?Q?LOfjuLMEYl06Ly74gaCHsdDbumbmsO9K6oI+fRCtOD7svxR7JHtc88EleT?=
 =?iso-8859-1?Q?9D7q2z6ZQU51nI12CkcnhC9YTwUVBaX/zY+n8JBAIIyVmxPlspOW6+bvgW?=
 =?iso-8859-1?Q?HGHAweYDa1VLIFMBHRMzBRJ5NhoObRhWuR2B2UprSbjwru9iCmSkNuBO9D?=
 =?iso-8859-1?Q?zbSLHeQnnnGOvVg/5w3PlbcYQLTkgAu9nTRYwjpMl0T+E4AV3k2EVTb52g?=
 =?iso-8859-1?Q?zwCeeOjVyKQGf+hbjKsdHLPS+CbPBDOLbiW3zvIHfDFTOT8MzNbB+VG34J?=
 =?iso-8859-1?Q?ZgjGes1YTpaMXu+rS5jzHlAYPmzgh7RY/joWXu/L8sGL4BhX+XFVWTd++R?=
 =?iso-8859-1?Q?hQe5vYWFNLAe2ELmZ1NaQc1guE/XErVm3NYuWq6CPgoR6rqGu8GsVGQa6i?=
 =?iso-8859-1?Q?JakWJSGfg/RAjwwucihdCVVDugf79ixeYGNrgIO+1wgLJdgPV3os4/LYi7?=
 =?iso-8859-1?Q?LiBy2WmaX/CAbbvMwWHiRfljq6MKmtf9bjL9LQl+8MIPcpHCqzMK5MJTcQ?=
 =?iso-8859-1?Q?w6f/1alXfthqbSBsvp1xJLCWYqcflwJUMy9p588UNGVgcz3cKjo70MJrzL?=
 =?iso-8859-1?Q?bPkKrjg2c6Da8C9yBeleoEYhYP+RX40gzO5JyW1x2Cj5ltt3mmUXi7o6Er?=
 =?iso-8859-1?Q?macPeM5AdzULh5hQt+1Q4TmWbh8byYBPtHZwVZODYxlQLMZ/Fzigs1W2iN?=
 =?iso-8859-1?Q?8Sx6fVG7mf5+DsbpT2B06xx1JXTziVebzrHvRG5D+UVuoJn6TqIDZGlBZS?=
 =?iso-8859-1?Q?ycTIxOF/jMImT6GIweOkMHl61i4TQKpGoCoLS24LNhf5WIE/hBOg0tw7ow?=
 =?iso-8859-1?Q?IA3nyrhQuzYDb/dOG4nFxrOWdFTNw5J+pDxDQyypZEdorADXh1v41xkQ4B?=
 =?iso-8859-1?Q?XtOxrsPxoocJ8Uxh1rwRFU5BK/2j3JBFiAQWV9wmpmSBdexReij0JEasEL?=
 =?iso-8859-1?Q?nD4ZQ4N+bMo65KcfEWv50E0NlYUkhp8Duf/EHniFaHlTSx5q7twlkRued7?=
 =?iso-8859-1?Q?W+G+QoOwC0SlR3JGKjcCsI6uTZPwMPkXUSA47uTeDwC1R5mbV+NFvEYmXR?=
 =?iso-8859-1?Q?U0uo/bI2Ie1ElcucvNutrg4RTXC6EUcXjRVRqARvrQcCrhDKV0auR3uyZ1?=
 =?iso-8859-1?Q?CTFhwlPZZQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: OZLCrvrF9//SW1C2ETJLjfKC2DjysowGvsRsGc02RMKB51S3gX+aDyScsW3gKaw4xeL2q0dfg7g2Ei7eDfiARYHbjJ9ri/kRzgYcmKn4VlLdezvvr356ieyS7q52TEL/Ckq/lkO7yJX7/TnpKU18eUBCNcIOfPcnOw5WFX6YmwQz72otDnC5Bc6XmzELXSazBPUFcyRMPP69SmROirIQHlKP7yD4gYhf2Kwldkmi1CPF4DdyM84BJkKC7h8SL40pbeP80fKRyF+JfxorbItOXz0+FpYcOg1RxrisJGw6TXBTIupEpxKLneip2om3xVia7CnEIS2SGKvWjHtbg46SiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 304abdd1-f36e-4bc1-417b-08de89ac8d1a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:52:13.1128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDcouZcRzG+cZTsc8sMWo0+BBTo6r2Vr49xLhfBz1+hvocPFJmJ/OfsmtGXNLGLYX/ED3z1cUK2HdoQnwOtCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
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

On Tue, Mar 24, 2026 at 03:36:24AM +0100, Raag Jadav wrote:
> On Mon, Mar 23, 2026 at 03:11:58PM +0100, Christian König wrote:
> > On 3/23/26 15:10, Raag Jadav wrote:
> > > On Tue, Mar 10, 2026 at 08:56:58AM +0100, Raag Jadav wrote:
> > >> On Thu, Mar 05, 2026 at 06:36:46PM +0530, Raag Jadav wrote:
> > >>> Currently 'none' recovery method for wedged event expects no explicit
> > >>> recovery from userspace consumer but it expects driver to have reset
> > >>> the device, which may not always be the case. Update documentation and
> > >>> log to reflect this expectation.
> > >>
> > >> Anything I can do to move this forward?
> > 
> > Invent some tech to clone certain people so that we have more reviewers.
> 
> If this allows my clones to also review my patches, I fully support this :)
> 
> > > Ping.
> > 
> > I will take a look now.
> 
> Thank you, I think it's safe to land through drm-misc (if anyone has access).

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

But it is not applying cleanly on drm-misc-next.

drm-misc maintainers, could you please do a backmerge of drm-next?

Or ack these patches to go through drm-xe-next

> 
> Raag
> 
> > >>> v2: Rephrase documentation (Rodrigo)
> > >>>
> > >>> Raag Jadav (3):
> > >>>   drm/doc: Update documentation for 'none' recovery method
> > >>>   drm: Update log for 'none' recovery method
> > >>>   drm/xe: Send 'none' recovery method for
> > >>>     XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET
> > >>>
> > >>>  Documentation/gpu/drm-uapi.rst | 14 +++++++-------
> > >>>  drivers/gpu/drm/drm_drv.c      |  2 +-
> > >>>  drivers/gpu/drm/xe/xe_device.c |  9 ++++++++-
> > >>>  3 files changed, 16 insertions(+), 9 deletions(-)
> > >>>
> > >>> -- 
> > >>> 2.43.0
> > >>>
> > 
