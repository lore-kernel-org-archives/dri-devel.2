Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA501C531D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE17E10E59D;
	Thu, 23 Jul 2026 14:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KqKhH2xN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB73610E59D;
 Thu, 23 Jul 2026 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784815421; x=1816351421;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wyUYXsuT/jThEd6ql2enQlRtqdhwWtudyuUQN3fSDbk=;
 b=KqKhH2xN9lX60om2MRfhbx2Ags8xK4yoLGPOhGA3+hw4/ynOB7A8BEVI
 kVeGEnDLqIWqR42WxQsZujywDDQN31GYvC1AdhNk0ZPsJBi8dS+mUyC1N
 Sr+Ah/gUvgmlqEqtB4bToWMhYJ5GjKojTW5say9QDA217NiXFDsvY2dgY
 U4f7slpwLceCD9tgFGzC12suBhnaKBLlNCKBFvNvYo9AmjVt5RmBBQksE
 9IbxOXGqb8MPQchGEG5DPJ/t2BB9LDe8VA/j/bPLZ3tTjuSOa9/swub+K
 AbcTS0I9wWbSqPMdYXzE9u4Ji/arbqDtwpmvZRJ7uKc66wNaL9V7vDICf A==;
X-CSE-ConnectionGUID: w6BhH1gcQ125HqbYqbKhGg==
X-CSE-MsgGUID: JsCtohAJTVmo4F3hoZwubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85560099"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85560099"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:03:41 -0700
X-CSE-ConnectionGUID: px8Z2dPBSXW7ShcllBl9FA==
X-CSE-MsgGUID: eon6B95lQDyUXZwkTqxfoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="256613176"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:03:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 07:03:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 07:03:39 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 07:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bon2ASqkpRYCrNULUeGV+4vnvb9dtxpwTxK89JfDrtl2owU9adc0Z4xjC6gwzoNHhIx5+jWjG+VQ8BX+wp0SjU3nWzNuFsMILjY49TO/G/xYQPk0sH5y7DSkLrcI43MxO6yt3qVNwheCYtbS0mYhHvXDTXUsUQ9Rrp9y+U3NFlXeYCLY8ce4p+3CVVRWb0HVhTpCQI5cHBUpq+VPEZqENYQ4vxiJmTFPz7c7n52iltmQUNVFJijVN8GjgHNhl1bT6I5tq8kk0Ufr6iAl+VEfOrWdhA2Onoq3HnAjH5eueG3d/Yc8RKRMwg5DPtjjfA+1biTVvn8H0NrbaPepYRH+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bkmNWR8NJrTQsYvg01UZeKcqrxVgz+Sa6RLtmthpVc=;
 b=HntVZ86JqAe3BNb3wv/xjL56PLe4+Rbib2s4mOMCwrPgse7dh3kyoV3uNikXUpWrQU/8ttsbnqdlXJc0Duo8sfCTrJYinFw7mc+HwfwBzgIA9BScOagqEnxgvN4fCKzwgh4VVrc1scvv7TnvP8bEztKxBJql3n6zQw2Vjtlw8RGux86W2IUIaBtikeBWp0O2Q99og5DKVja4PuTqXtVAxV26STgdgvUSbtRRP3vOroeYweZ3tKC8Eg0NVGfdvLB+jW/remlBT6yw8Z5oMg25dci6nm3/2A9kdBOb5yv0Bn1s8M2II5BTihlH/O0G0WiBit/Bsooiu2GPRILnPNosHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 14:03:34 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 14:03:34 +0000
Date: Thu, 23 Jul 2026 10:03:27 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
Subject: Re: [PATCH v11 0/3] Introduce cold reset recovery method
Message-ID: <amIfL_ZS7HamPImW@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
 <amHzsHmNSH84SZ92@black.igk.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amHzsHmNSH84SZ92@black.igk.intel.com>
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d89a769-89dc-4c9d-4b7f-08dee8c32f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hdtJfW/yx2zkYHuLSk0gPY/VUr1NyctPKh8malyADm/q+SwyBrF+aFbPDhavOD06IhKXZV1jZT/hcFx6jLQlGaUlzJp9QUo0CKMTM0BvcR42ptMJevpMD0GmpOLPDtTj123CpbKAPA/uw63wFTX0TAPkxuw0izXsb8fZJTw2H3/MQvEKE9RAl8oqopsvNFJunxERiYpFAdRlSEjuUZVlDG9lse9VfiODrA57+481hJD8fDZ1zw7N6u/PiEc6sRbqKpBta9OU9FXkxgBQsZjKgRtdwZ1lwWfxWOU20q/j6tI7wWP0Hwa/O//D7sENaqxr4rljxy0a2ohwHAn3JTwWQxiqMxzSrAgqk/iY1IvOBXQ05OUqlau83P7BWXDyQjX7/zQj9d5u0KJBnjtk6i5qIsbUw5CjPQ0O43UoeGLP8wJmmHlo/wtfHhH50OAG8jKVzCSzCTAgcA9taCDb7hV/vFuq6sB1vQ7uojiOf/Ifd2AaiaDPs5uU7U3t7XgPHE0sKyA2VCeDPKUpSwHD8FyupZzm2W8NSm3w675nOVQuk+GtrRy+eO9vcNho3DqawIVxOMjvNNtfghHwItnyx9p9J33ysO9HHxD93LAmmpWkQXd+m4AZEKYxmmUgIwFxTiFR1hI8zUVCmwqpT4b3gxBu0xvViIlQTPrAhR126LhuE2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RNf/gnYpPo7tg+v3Yfhh2yS2hunDHzNsZy7d/JISPpZrhp7MA1TkYRlg13?=
 =?iso-8859-1?Q?oiNffbqb6lcQDcSU9NjJsxYn8HxWxJYEXfu64gpxcPb8KeKIYKYH72uf13?=
 =?iso-8859-1?Q?Imu3GUyIY90XwFEmailPBIIww/1DBsr7qUWKbjk0PaI3p0dFMpRvt6bJsz?=
 =?iso-8859-1?Q?nVCtaqye62d4HVcsnHLCpo4LYYJpBYQQxqHo3kF2UK4OVkXwTEWaQAJ1w2?=
 =?iso-8859-1?Q?mEW+Zj0n+ejh4t6aQKTviODFBY1G7sTTcb1tVheb+QmTXJGVLwnpPWdTuC?=
 =?iso-8859-1?Q?5N2cJGa4JzSkAK0/YBOfN8uuIIjWAonFJCuuqxAt4I2Zk9SxAKgJUAaBi/?=
 =?iso-8859-1?Q?tk1rD0o5wgD0CDN4tUMboXyjPZTMZNjVj+ehZADapdJERDYQkiAO/zhYuC?=
 =?iso-8859-1?Q?tCQTw/sKhg3aTLo3shPl6ERSs1ztWuH6BmPbvTPBWfxiJ2+Q7hWNV/AoZ1?=
 =?iso-8859-1?Q?ybNYNl7CL0V7h18i0yeE3vxL08FaM3KNDFBgNOWWPpzQRLvLltUQ4jHafZ?=
 =?iso-8859-1?Q?L1yK2fwTc0r5Rop0Whh3anjq9DDQo/QvrIPCWvjLkZ77Rt4wfnaYu5Jj1H?=
 =?iso-8859-1?Q?oqc4Ob6Oln9qY1x1DFxnnT93WIJfC4UFx1oj6JxuC4V9lMri9vcMbF79vj?=
 =?iso-8859-1?Q?4w8ov6NVmQwXuR0HAh8mxVjpXXFCYKiEp8Oq1NS+2GJ0jlkTmDg/QvBpz5?=
 =?iso-8859-1?Q?Fb8RiGFgI1FnP579/ZnF9gJvXwV6WEUYXbTlH/BgJou2kiWTlgEsvywLny?=
 =?iso-8859-1?Q?FMSAL4xVfXTWpH7iVei2SJwhm4n8q9ZtxJeNMSOU2PwAmPiFg0KbzfdO7b?=
 =?iso-8859-1?Q?GzKOniQCoa5p+VXwPLbtdChPLJz7JCiJyRAFO8IeqyqwC0OSUHLpmlPm7Z?=
 =?iso-8859-1?Q?sqYKb787LXRxB5KMY5zrJy0g1+zq4rLnoh6TNEgyriocMXUZi9Rki+lHJj?=
 =?iso-8859-1?Q?diXf8a188gKhFlrisr9jh+2Fb/DcGLjyrgTjBoMt+Jee95f08LYwKsNoxD?=
 =?iso-8859-1?Q?qZT7AB+NZCyZA3Ko72Sy7QWlpaWxBa6KrZv8i4cTuaAUwKZHZWCJTNIn0j?=
 =?iso-8859-1?Q?rlzxA4HU5Z3uDJh2z3dN2iDovtxUP1R2a3DguRxiyb2pJStcSyaMNtsPqc?=
 =?iso-8859-1?Q?B8CHYuHdWH7y4NqP9hNxK9HeZk3JkJgx40vBbjh3wQCQKDBHAsHENELUo+?=
 =?iso-8859-1?Q?YktzYG7NAOamsbvCheuG7MV/G7Met1oA9LietewFgoUsNaCvkQwN+wTPlu?=
 =?iso-8859-1?Q?ShSwHLLOLe9xkN9TyaHaYyH71xABq2Bg2n5owffp0UoIYPgK77HdSdFUyB?=
 =?iso-8859-1?Q?9kU1QDKja8eH8DmmkxgpT0BHDmK7IrlL+PagAtD0gwYvODoeto1L9tezyO?=
 =?iso-8859-1?Q?1cv/ThxbmB6UJ+USECowadP9BADLPCgVxgIXL1JKmR2+mA6hBVyiJUHnCx?=
 =?iso-8859-1?Q?3DXkjw12B6r8EtWKWTullCqMgvL8skK5N4H1Y0Oq58LFJMizIQrsbeRwlW?=
 =?iso-8859-1?Q?OSTozQd6U4be7iG4EZMHFLwAr9H0fUtvNy3kIV2Z/RH1TAIns4i5QpesbQ?=
 =?iso-8859-1?Q?+XSoRMWMTTMXZQOD79PvIwW8ZWXPBDcE8sTDK2VybDD6cxVE4loPNTWXgV?=
 =?iso-8859-1?Q?pDyZlYvnvb1mbITM5nhgdbcQDHQF5gpTTiLMNNMTSi95T0Cy/eQ2Rp1Ypp?=
 =?iso-8859-1?Q?cQXTUGL6HhwQvTijMIIG1Wixsce9aTn0KP59r4WbUeJmhEHosx9Pl5yMet?=
 =?iso-8859-1?Q?8G07NyaCOGbnV4VbgMlXffKeP9/6eN3soifdFbQoJuHnWOGjEL/qUgfCmx?=
 =?iso-8859-1?Q?4FBDQTAqPg=3D=3D?=
X-Exchange-RoutingPolicyChecked: CFgCn9ndDzJu1DxacnHDgYQKEAcUM59/0Ut7xjVv1w/IpS1wvLNQMUoZhWa0IablDwVeJcfRg7gMCHblwcKI/v5HuJUx6G9ofFOZr1Xn3DC5fbvPDN+23GYrhC4oWaQyvevak4nv+ACBQ0J3fjzYC5eRhcnPKHwO325uihlwS+0FExsiEtPqW8r78vhMeNYtNyTRov91vBtKKy6LxjAN7QHfoIl06ENhSWodVXd6TcqkRtxvNk7M86PbF4W7QYgvJyrJnliGR4fKmtWR45IETnvEq8KrhGEa2GlVppCEiKcaq7pi5wGtS92wdunBuqD8vLWC9Pts4dd+fhizfAy25A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d89a769-89dc-4c9d-4b7f-08dee8c32f20
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:03:34.4324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRuMEjbQy4onxcaJ9q1BbRn6ZOFVxKHSnb05z00O9+Mb1Ks+4PjCKPjZ75MfBdN+Qb8tnueMNWRuCpFmJORVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
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

On Thu, Jul 23, 2026 at 12:57:52PM +0200, Raag Jadav wrote:
> On Mon, Jul 20, 2026 at 03:48:16PM +0530, Mallesh Koujalagi wrote:
> > Add support for handling errors that require a complete
> > device power cycle (cold reset) to recover.
> > 
> > Certain error conditions leave the device in a persistent hardware
> > error state that cannot be cleared through existing recovery mechanisms
> > such as driver reload or PCIe reset. In these cases, functionality can
> > only be restored by performing a cold reset.
> > 
> > To support this, the series introduces a new DRM wedging recovery
> > method, DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)). When a device is wedged
> > with this method, the DRM core notifies userspace via a uevent that a cold
> > reset is required. This allows userspace to take appropriate action to
> > power-cycle the device.
> 
> This one looks like to good to go.

I don't think so. Sashiko had identified that this path of cold reset
won't be actually reached in the probe. I asked the introduction
of a fault-inject test case so we can ensure that we do hit this case.

> 
> Chris? André? Can you please help review so we can merge it?

That aside, after we ensure the path is hit, we want to keep this
cold reset one.
So, the ack is already welcomed and needed.

Thanks,
Rodrigo.

> 
> Raag
