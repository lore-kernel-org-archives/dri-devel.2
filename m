Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56710606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SbJkTVia;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=hKXoIhD/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13CD10E772;
	Tue, 24 Nov 2026 15:20:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C3510E898
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795533644; x=1827069644;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gvdLwn5nObDqdp31Ig9CMUaRkc8Kz9m/4mDAwvHTpnY=;
 b=SbJkTViaI7VIMdJ4y/yu3D2rLPJDPReKR/oC8NjgjYJ58apDXlrbiVL2
 siPk67w5ciWkkP/uO9LMjzxoqvPZ5M0UWxNR4lDA2om3M+kEBcknhb4tF
 AlL4m9kGJMmU2LH5puXgP28xvyK3iA7k47211yobcyMNSAn4pBvk8ejVB
 H5sCYPtyYhLRddDOPgNxxmRoSHctSdVdkx1nHj2RQDGppQZTTE4cjimU9
 FEGHgZs/YogKnuTClIsdZjetsvu469MkEmVQtFjCnAFDaUzuL0AHqs5ye
 b7VObO/xzWNbAfDHLq2d+zbGAJeDKrHNE1BUuuT4esMoGHeS1XpkVMb7P Q==;
X-CSE-ConnectionGUID: g6gNbjkZSGOx8myZDFLzEQ==
X-CSE-MsgGUID: 84nG6OldTzK2NigFbV56Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4429979"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4429979"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:20:43 -0800
X-CSE-ConnectionGUID: IbyXWcITSlmyey/upkTcSw==
X-CSE-MsgGUID: ickBjBIBQz2xen+6sOBfFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11793213"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:20:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:20:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 07:20:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx0pjlAulckCpJlQiGLW8BRAQUI54GSzS7uetg3IOGVcSW+MQSvMhwANK5GcA33fOiQI00SElQZrkQygA3+xrnM1O77sBD4WyUISiPGMMY6pt+HPV4eldh9GJVnp8tIPriQYJ7+CnjfD76MQMirjAYksAlW6xGEx0fHCPmrNTvEs00L4LrQGquKQd6GJqD+iuy+r4OyDzWucybdEtHBjdFzKCjKO26Mf2ae0CnlJYg56Oyo+tRrWgNIkrmQNpELMmCDMQBLaN3S6bA8etdhztgLEvu/0bK5IxX8nHps+6mYwr3+474OS0i4HdeWbaA2nfGsOqCdMVyg+BAiL4UdvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dfNNwwXWAwLtbHbkuCmj+Pi8RsKDyKV05Nh04K0fkE=;
 b=JzoJXyGHlWVb522fnNvzDE1u8s30QW+jfBMSocBWFZcp16yUrpAXX0cGlClfQMa3j/jVvMBe3EKHLkWlAhZHdooGUX8lIrcCv0sWicxIib+fOYs9eQ1S8PZXmNiSNWCcvD84PA/f+chyk1EUchsK9XJhP+9tjQWMjHyeoScGKj8OJP7slMHXTo6mVt9kZdDi7OaKFBhGhegkK4rLburUBSrz4y3RgUwB5hyVfB1EsjiQAzTS6HukBeGNqtG02PMBggxSISybcuvhUfFpdMCBbHiS0sq/MZJLHP5qjJmgj/nELSdDJMFrQvXUyj5VbbhFWRq/sEkL3q47iE4dNP9FLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dfNNwwXWAwLtbHbkuCmj+Pi8RsKDyKV05Nh04K0fkE=;
 b=hKXoIhD/x4WS7490HF/ilrkzeTU2XYpHqrKjMn2y1/BykzxuESRJUgBeYC5pUC/ByEL5TrUwEAhBbw4vfJ6g91cOMBKc1zLMLKbtYV/ANnfhVZHJ4HuepKHNYNaEk7hKhD+F7T80SPvHTaGbVj2IprTYgvcY/IUPqx8+xUceBls=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS7PR11MB8825.namprd11.prod.outlook.com (2603:10b6:8:255::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Tue, 24 Nov 2026 15:20:29 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 15:20:28 +0000
Date: Tue, 24 Nov 2026 10:20:24 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 1/4] drm/drm_ras: Reference-count nodes across netlink
 handlers
Message-ID: <awWrOMrRHFpOF00l@intel.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117233442.407877-2-zachary.mckevitt@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS7PR11MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0678649f-0fd5-4be8-af79-08df4a3e78c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261102130727099003|261026140227099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261022113327099003|261028144727099003|261021123027099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: kxZStUGFZFc/FKmMX0vPB7pzwPyXFmRi+wc7iGGoUYl205pIlaMPFf1GPtHMu0kBLFe0/q0uUQSIRoRFQ2fN/BGdZwD/QXL6vpUM5B/kAkuMMYvx+Ly+ZZHmnqn06EQSckdR18CIwIVv5+RdQoyntVympd3701UEtM23pIe+iP98hFJyYDYuT0mqdV7F/PKJW5gjuAM2LXMwAaLRT5M+ZtsN0N/p6BafBtm9/QJyoJ2f1wa9r/8Krr2wuDDrcaML7FXV5nwb6IVjoSpbziGTuwxIha4Wdd/nE+ULOWcHbe9UPEjuVSXQZiJZugZUixB2IE3PzuhZ6uihCypvHwl4bd79LA4/sbNL9Y5MSOPz/7739n8YGI7Vak6gxSShc0w+uqP6QqkiiqO6FVWhhNXlOEj2ujyPSLvwamlBsNaRf2JWi8bw0k33Z43TAc6fP+xOiHeWaR3BwgjCo+xEM8OLOOo/vV7GVWP634lu89fMeaJBEky904s4zftTtaeEiiqlo4vQM9R2bGjPQmBvfr+oJk1D/V85SRKYvI0mirAFpVCqFmPELqVOG8jFX5aGIN5YuO1pLhq3XD9XFp/ag83X+RAeY9ec+9Dt83+G9i5jNPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261102130727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261022113327099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Kn/69B0tieOHClHpGcJh29hPytKEjL+xvPsUw10GEe2FJtwbVTz3QOQ+iK?=
 =?iso-8859-1?Q?QjrzCVhhmm+jED31xIQcNZMh8HfL7Gml7ZVGMzpFTc7NHoh/j0x1tTo1sJ?=
 =?iso-8859-1?Q?HiKwoUmx4lhk/hM6XrQf0o+n9Wicn+Iixplw06/y4Z+mU0Tx5ImrmYYafH?=
 =?iso-8859-1?Q?ojvFOog+CiQx+/qW3+v4maylyp0E4kWFOyJsqBaEiOad5vEeUxDAdhaF2x?=
 =?iso-8859-1?Q?fhAPpQ4sCwr4h/cZGRPWKf4s1xNTGdp4FMZ0XYgPDsBqpMkSKTNex83ayC?=
 =?iso-8859-1?Q?mynKpVJ9fhqjXlJFkh8vLW7+bHLXseWHFlbwa94dgR75/3YeKYdy3LV3TQ?=
 =?iso-8859-1?Q?HQH4e3Ra3f6dNFncTXgkTUT7uYLAKsJ2OrCezT4qaSWBBAmzxCI5FPc7om?=
 =?iso-8859-1?Q?0865RMngbzf5nR3gK8jxr0XdAiT1qYB2aaYAgalDBtYcAKjI8Wf/u36E5f?=
 =?iso-8859-1?Q?ZVjG88v3x9AKLr6fJwb854Y0dtaLmuxCP9C89r21uxEet9lmf0gGSXQU1q?=
 =?iso-8859-1?Q?ExM7lYO38yPL9OQxFmCkVoI8BzqnJglrFEFwQ+2cJ0LganwlOrPKGFfH96?=
 =?iso-8859-1?Q?rKxM6ITWr/jlLLmGq7LO9mKts2kofBGz+4IVR9zYCODskL7AdG6tydxH7C?=
 =?iso-8859-1?Q?8SNpWznHquwqGuwgjzlZ5cF+kUWnT5KI/n4KoApRdQEzYOqAWV9qBnlNyV?=
 =?iso-8859-1?Q?It2IIas3R2ulIB2cq7xt8rJhl63EMC0AUxFskRYDLDRsltYT4r/LLoNb5S?=
 =?iso-8859-1?Q?2SsJJSSUGHcA42/Dz4+xVQ7lRbm2udGi3uFzeGoI/Hg3YqI2je3NIQTJ0f?=
 =?iso-8859-1?Q?G88tmDXSLHfChxgP3owvqRcxw+Zx1Xxf/j+692VY8QnqfqBkzJHTSPdF35?=
 =?iso-8859-1?Q?i1zPWKhSH2DtjX2KrLd22p3R6ky08CC2lchs7DgmcxRcgKcQsxIIalMoE6?=
 =?iso-8859-1?Q?/ukQS/H2O5CYKInUNhziB+xwMUafSYeT/fxTVTIPYBV3YOjvx85E6CflU6?=
 =?iso-8859-1?Q?VQTmNMfVcO7Uo5MKcZ1xgP79Wjy9BLZ1LFcdNo+vpPP1OM0qU4bW0hV5Hp?=
 =?iso-8859-1?Q?3w2O/FPY5Jh9CV38hvt1dqHN8+y8KeiefVOCW5FKT6m4cBx4es6eJeMxXn?=
 =?iso-8859-1?Q?PaawpIJzEfgJfdycozNWjNFzi+raNPsoqre2sPs7iYEDJSavxng9nR8oyw?=
 =?iso-8859-1?Q?pYrkFyxXVpx8NJfT7rguBF5i0qKqDZsnNc1BFMd56XtqTmnSwoYiL7baZN?=
 =?iso-8859-1?Q?cwjMdXh9JQFBsDH3UsjVPVSk4qYW/j1tCGJyJhsW4U17ur3fGcGODSHzFC?=
 =?iso-8859-1?Q?/0oM6tCoTz8yQ/OwskFt8Y0rtxVG9+BMjr1NPYBIBkfP+j8Bm5d0Jig78b?=
 =?iso-8859-1?Q?/vCUsO/i9k4wm2IYwcLEOeScuHW3KzUHTU3rI241J+2vE4xpc6VUMVljH3?=
 =?iso-8859-1?Q?+20xG4nB+gIr0D0j9b5hCkP5Zfcr8h7SLtWLtaUhzgXnINMRukmEf7xIVW?=
 =?iso-8859-1?Q?mJKQ5/xYBt9fGY7XhB6LDroIaPGPoGhfjbM4vAFnhWrQ5HO2EyI0DZtiY+?=
 =?iso-8859-1?Q?ge+wFug8PHengqfZKbZUG2iLgOMe3QsaRl5U7wyI7qcGJOr6tg8l67TC6C?=
 =?iso-8859-1?Q?LQ0Xnx6v2+tsLDckjd1193vcCiXVT4zG30V5jqWvg1YJuTYz18sphoeCLh?=
 =?iso-8859-1?Q?ur3FNMDuU5lxk5GrU7BAueERUOXVoOEGVbAm/5w633YQXeZjWqUCrpk68v?=
 =?iso-8859-1?Q?c1PrpY5JZdtNrLMYkaQ05FJlxzkjKr96i8pgmL0KNSaM30Jql95ySm4E9Q?=
 =?iso-8859-1?Q?ynXoegPJWA=3D=3D?=
X-Exchange-RoutingPolicyChecked: MZHVw46RaWKuX5r/sNoT8QSO+yXEDdq+Dww3IuqZ17C1WfqCwIA1PLmB1zKVI644llBR9od8wHcwN3tO4cp9mRuYuvB3V3tPB8gD+3uihHpepseaoAwRX2lTRg8AnR6DgsvUGkLeShMA/vODGYrdkNE54eJh7PQw0B/CAvahc9eghdOO+vdmm6Dwb9Io96/TAKuM4c5dQkOAiCYjsof8NARrcu1zb3DEwtxFx/BZwkC4awTWYG/49xoKbZhDy6Ka2iL+NGBzrPtxqu3tOaBXb/3lHbgkqBThMEpfEfz3RW+/xK5tBcP9W85yGqo4FwSAMk2JzxFfJqQR/p6kzi5Arw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0678649f-0fd5-4be8-af79-08df4a3e78c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:20:28.7543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYUjKYr0tRMLFU/618tXC8cNnOBboU8DwW+OBqe+0GRy3w5eootwPf14XWh8pEarsZwne9S0AcdeG8gLFr+E3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8825
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

On Tue, Nov 17, 2026 at 03:34:31PM -0800, Zack McKevitt wrote:
> The drm_ras generic netlink family sets .parallel_ops = true, so its
> handlers can run concurrently with each other and with
> drm_ras_node_unregister(). Every handler looks a node up with a bare
> xa_load() and then dereferences the returned pointer across GFP_KERNEL
> allocations and sleeping driver callbacks, while drm_ras_node_unregister()
> only calls xa_erase() and the driver frees the node immediately afterwards.
> xa_load() only holds the RCU read lock for the duration of the walk, so the
> node can be unregistered and freed while a handler is still using it.
> 
> Give each node a reference count. A node holds one reference for being
> registered; drm_ras_node_get()/drm_ras_node_get_next() take an additional
> reference under the xarray lock, which serialises them against the
> xa_erase() in drm_ras_node_unregister() so the bump can never race with the
> free. Handlers drop their reference with drm_ras_node_put() once they are
> done touching the node. drm_ras_node_unregister() removes the node from
> the xarray, drops the registration reference and waits for any in-flight
> handler to drop theirs before returning, so the driver can still free the
> node as soon as unregister() returns.
> 
> drm_ras_nl_error_event() is left unchanged: it is called by the driver with
> its own node, whose lifetime the caller already guarantees.
> 
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

This overrides the series that I had sent yesterday...
I'm sorry for the delay here...

> ---
>  drivers/gpu/drm/drm_ras.c | 239 +++++++++++++++++++++++++++++---------
>  include/drm/drm_ras.h     |  16 +++
>  2 files changed, 201 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b099eb67836e..75e3403ca71b 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -3,9 +3,11 @@
>   * Copyright © 2026 Intel Corporation
>   */
>  
> +#include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/netdevice.h>
> +#include <linux/refcount.h>
>  #include <linux/xarray.h>
>  #include <net/genetlink.h>
>  
> @@ -60,6 +62,21 @@
>   * - drm_ras_node_unregister(): Removes a previously registered
>   *   node from the xarray.
>   *
> + * Node lifetime:
> + *
> + * The &drm_ras_nl_family uses &genl_family.parallel_ops, so netlink
> + * handlers may run concurrently with each other and with
> + * drm_ras_node_unregister(). Node memory is owned by the driver, which
> + * typically frees it right after drm_ras_node_unregister() returns. To make
> + * this safe, every handler looks a node up with drm_ras_node_get(), which
> + * takes a reference under the xarray lock, and drops it with
> + * drm_ras_node_put() once it is done touching the node. A node holds one
> + * reference for being registered; drm_ras_node_unregister() removes the node
> + * from the xarray (so no new lookups can find it), drops that registration
> + * reference, and then waits for any in-flight handlers to drop theirs before
> + * returning. The driver may therefore free the node as soon as
> + * drm_ras_node_unregister() returns.
> + *
>   * Node type:
>   *
>   * - ERROR_COUNTER:
> @@ -107,6 +124,75 @@ struct drm_ras_ctx {
>  	unsigned long restart;
>  };
>  
> +/**
> + * drm_ras_node_get() - Look up a RAS node by ID and take a reference
> + * @node_id: ID of the node to look up
> + *
> + * Looks the node up in the global xarray and, if found, takes a reference to
> + * it so that it cannot be freed while the caller is using it. The lookup and
> + * the reference bump happen under the xarray lock, which serialises them
> + * against the xa_erase() in drm_ras_node_unregister(): a node that is still
> + * present in the xarray is guaranteed to still hold its registration
> + * reference, so the bump can never operate on freed memory.
> + *
> + * The caller must drop the returned reference with drm_ras_node_put().
> + *
> + * Return: the referenced node, or NULL if no node with @node_id is registered.
> + */
> +static struct drm_ras_node *drm_ras_node_get(u32 node_id)
> +{
> +	struct drm_ras_node *node;
> +
> +	xa_lock(&drm_ras_xa);
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (node)
> +		refcount_inc(&node->ref);
> +	xa_unlock(&drm_ras_xa);
> +
> +	return node;
> +}
> +
> +/**
> + * drm_ras_node_get_next() - Take a reference on the next registered RAS node
> + * @next: in/out cursor; on entry the first ID to consider, on return the ID of
> + *        the node whose reference was taken
> + *
> + * Iterator counterpart of drm_ras_node_get() used by the LIST_NODES dump.
> + * Finds the first node with an ID at or above *@next, takes a reference to it
> + * under the xarray lock and reports its ID back in *@next.
> + *
> + * The caller must drop the returned reference with drm_ras_node_put().
> + *
> + * Return: the referenced node, or NULL if no further node is registered.
> + */
> +static struct drm_ras_node *drm_ras_node_get_next(unsigned long *next)
> +{
> +	struct drm_ras_node *node;
> +
> +	xa_lock(&drm_ras_xa);
> +	node = xa_find(&drm_ras_xa, next, ULONG_MAX, XA_PRESENT);
> +	if (node)
> +		refcount_inc(&node->ref);
> +	xa_unlock(&drm_ras_xa);
> +
> +	return node;
> +}
> +
> +/**
> + * drm_ras_node_put() - Drop a reference taken on a RAS node
> + * @node: node to drop a reference on, may be NULL
> + *
> + * Drops a reference previously taken by drm_ras_node_get() or
> + * drm_ras_node_get_next(). When the last reference (including the registration
> + * reference dropped by drm_ras_node_unregister()) goes away, the waiter in
> + * drm_ras_node_unregister() is woken so the driver can free the node.
> + */
> +static void drm_ras_node_put(struct drm_ras_node *node)
> +{
> +	if (node && refcount_dec_and_test(&node->ref))
> +		complete(&node->unregistered);
> +}
> +
>  /**
>   * drm_ras_nl_list_nodes_dumpit() - Dump all registered RAS nodes
>   * @skb: Netlink message buffer
> @@ -129,44 +215,45 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>  	struct drm_ras_ctx *ctx = (void *)cb->ctx;
>  	struct drm_ras_node *node;
>  	struct nlattr *hdr;
> -	unsigned long id;
> -	int ret;
> +	unsigned long id = ctx->restart;
> +	int ret = 0;
>  
> -	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
> +	while ((node = drm_ras_node_get_next(&id))) {
>  		hdr = genlmsg_iput(skb, info);
>  		if (!hdr) {
>  			ret = -EMSGSIZE;
> +			drm_ras_node_put(node);
>  			break;
>  		}
>  
>  		ret = nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_ID, node->id);
> -		if (ret) {
> -			genlmsg_cancel(skb, hdr);
> -			break;
> -		}
> +		if (ret)
> +			goto cancel;
>  
>  		ret = nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
>  				     node->device_name);
> -		if (ret) {
> -			genlmsg_cancel(skb, hdr);
> -			break;
> -		}
> +		if (ret)
> +			goto cancel;
>  
>  		ret = nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_NODE_NAME,
>  				     node->node_name);
> -		if (ret) {
> -			genlmsg_cancel(skb, hdr);
> -			break;
> -		}
> +		if (ret)
> +			goto cancel;
>  
>  		ret = nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_TYPE,
>  				  node->type);
> -		if (ret) {
> -			genlmsg_cancel(skb, hdr);
> -			break;
> -		}
> +		if (ret)
> +			goto cancel;
>  
>  		genlmsg_end(skb, hdr);
> +		drm_ras_node_put(node);
> +		id++;
> +		continue;
> +
> +cancel:
> +		genlmsg_cancel(skb, hdr);
> +		drm_ras_node_put(node);
> +		break;
>  	}
>  
>  	if (ret == -EMSGSIZE)
> @@ -175,13 +262,10 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>  	return ret;
>  }
>  
> -static int get_node_error_counter(u32 node_id, u32 error_id,
> +static int get_node_error_counter(struct drm_ras_node *node, u32 error_id,
>  				  const char **name, u32 *value)
>  {
> -	struct drm_ras_node *node;
> -
> -	node = xa_load(&drm_ras_xa, node_id);
> -	if (!node || !node->query_error_counter)
> +	if (!node->query_error_counter)
>  		return -ENOENT;
>  
>  	if (error_id < node->error_counter_range.first ||
> @@ -191,14 +275,9 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>  	return node->query_error_counter(node, error_id, name, value);
>  }
>  
> -static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
> +static int get_node_error_threshold(struct drm_ras_node *node, u32 error_id,
> +				    const char **name, u32 *threshold)
>  {
> -	struct drm_ras_node *node;
> -
> -	node = xa_load(&drm_ras_xa, node_id);
> -	if (!node)
> -		return -ENOENT;
> -
>  	if (!node->query_error_threshold)
>  		return -EOPNOTSUPP;
>  
> @@ -208,14 +287,8 @@ static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name
>  	return node->query_error_threshold(node, error_id, name, threshold);
>  }
>  
> -static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> +static int set_node_error_threshold(struct drm_ras_node *node, u32 error_id, u32 threshold)
>  {
> -	struct drm_ras_node *node;
> -
> -	node = xa_load(&drm_ras_xa, node_id);
> -	if (!node)
> -		return -ENOENT;
> -
>  	if (!node->set_error_threshold)
>  		return -EOPNOTSUPP;
>  
> @@ -290,15 +363,22 @@ static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *er
>  static int doit_reply_value(struct genl_info *info, u32 node_id,
>  			    u32 error_id)
>  {
> +	struct drm_ras_node *node;
>  	struct sk_buff *msg;
>  	struct nlattr *hdr;
>  	const char *error_name;
>  	u32 value;
>  	int ret;
>  
> +	node = drm_ras_node_get(node_id);
> +	if (!node)
> +		return -ENOENT;
> +
>  	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> -	if (!msg)
> -		return -ENOMEM;
> +	if (!msg) {
> +		ret = -ENOMEM;
> +		goto put_node;
> +	}
>  
>  	hdr = genlmsg_iput(msg, info);
>  	if (!hdr) {
> @@ -306,7 +386,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>  		goto free_msg;
>  	}
>  
> -	ret = get_node_error_counter(node_id, error_id,
> +	ret = get_node_error_counter(node, error_id,
>  				     &error_name, &value);
>  	if (ret)
>  		goto cancel_msg;
> @@ -317,26 +397,37 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>  
>  	genlmsg_end(msg, hdr);
>  
> +	drm_ras_node_put(node);
> +
>  	return genlmsg_reply(msg, info);
>  
>  cancel_msg:
>  	genlmsg_cancel(msg, hdr);
>  free_msg:
>  	nlmsg_free(msg);
> +put_node:
> +	drm_ras_node_put(node);
>  	return ret;
>  }
>  
>  static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
>  {
>  	const char *error_name;
> +	struct drm_ras_node *node;
>  	struct sk_buff *msg;
>  	struct nlattr *hdr;
>  	u32 threshold;
>  	int ret;
>  
> +	node = drm_ras_node_get(node_id);
> +	if (!node)
> +		return -ENOENT;
> +
>  	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> -	if (!msg)
> -		return -ENOMEM;
> +	if (!msg) {
> +		ret = -ENOMEM;
> +		goto put_node;
> +	}
>  
>  	hdr = genlmsg_iput(msg, info);
>  	if (!hdr) {
> @@ -344,7 +435,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>  		goto free_msg;
>  	}
>  
> -	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> +	ret = get_node_error_threshold(node, error_id, &error_name, &threshold);
>  	if (ret)
>  		goto cancel_msg;
>  
> @@ -354,12 +445,16 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>  
>  	genlmsg_end(msg, hdr);
>  
> +	drm_ras_node_put(node);
> +
>  	return genlmsg_reply(msg, info);
>  
>  cancel_msg:
>  	genlmsg_cancel(msg, hdr);
>  free_msg:
>  	nlmsg_free(msg);
> +put_node:
> +	drm_ras_node_put(node);
>  	return ret;
>  }
>  
> @@ -372,6 +467,10 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>   *
>   * Report an error-event to userspace using the error-report multicast group.
>   *
> + * The caller owns @node and must guarantee it stays alive for the duration of
> + * this call (it is the driver's own node), so no additional reference is taken
> + * here.
> + *
>   * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
>   *          netns, which is unbounded work; callers in interrupt handlers
>   *          or other atomic context must defer event.
> @@ -455,21 +554,21 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  	struct nlattr *hdr;
>  	const char *error_name;
>  	u32 node_id, error_id, value;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID))
>  		return -EINVAL;
>  
>  	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>  
> -	node = xa_load(&drm_ras_xa, node_id);
> +	node = drm_ras_node_get(node_id);
>  	if (!node)
>  		return -ENOENT;
>  
>  	for (error_id = max(node->error_counter_range.first, ctx->restart);
>  	     error_id <= node->error_counter_range.last;
>  	     error_id++) {
> -		ret = get_node_error_counter(node_id, error_id,
> +		ret = get_node_error_counter(node, error_id,
>  					     &error_name, &value);
>  		/*
>  		 * For non-contiguous range, driver return -ENOENT as indication
> @@ -478,7 +577,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  		if (ret == -ENOENT)
>  			continue;
>  		if (ret)
> -			return ret;
> +			break;
>  
>  		hdr = genlmsg_iput(skb, info);
>  
> @@ -499,6 +598,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  	if (ret == -EMSGSIZE)
>  		ctx->restart = error_id;
>  
> +	drm_ras_node_put(node);
> +
>  	return ret;
>  }
>  
> @@ -544,6 +645,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  {
>  	struct drm_ras_node *node;
>  	u32 node_id, error_id;
> +	int ret;
>  
>  	if (!info->attrs ||
>  	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> @@ -553,15 +655,23 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>  	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>  
> -	node = xa_load(&drm_ras_xa, node_id);
> -	if (!node || !node->clear_error_counter)
> +	node = drm_ras_node_get(node_id);
> +	if (!node || !node->clear_error_counter) {
> +		drm_ras_node_put(node);
>  		return -ENOENT;
> +	}
>  
>  	if (error_id < node->error_counter_range.first ||
> -	    error_id > node->error_counter_range.last)
> +	    error_id > node->error_counter_range.last) {
> +		drm_ras_node_put(node);
>  		return -EINVAL;
> +	}
>  
> -	return node->clear_error_counter(node, error_id);
> +	ret = node->clear_error_counter(node, error_id);
> +
> +	drm_ras_node_put(node);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -602,7 +712,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>   */
>  int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> +	struct drm_ras_node *node;
>  	u32 node_id, error_id, threshold;
> +	int ret;
>  
>  	if (!info->attrs ||
>  	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> @@ -614,7 +726,15 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>  	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>  	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
>  
> -	return set_node_error_threshold(node_id, error_id, threshold);
> +	node = drm_ras_node_get(node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	ret = set_node_error_threshold(node, error_id, threshold);
> +
> +	drm_ras_node_put(node);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -640,6 +760,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
>  	    (!node->error_counter_range.last || !node->query_error_counter))
>  		return -EINVAL;
>  
> +	/* One reference is held for being registered in the xarray */
> +	refcount_set(&node->ref, 1);
> +	init_completion(&node->unregistered);
> +
>  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL(drm_ras_node_register);
> @@ -648,10 +772,17 @@ EXPORT_SYMBOL(drm_ras_node_register);
>   * drm_ras_node_unregister() - Unregister a previously registered node
>   * @node: Node structure to unregister
>   *
> - * Removes the given node from the global node xarray using its ID.
> + * Removes the given node from the global node xarray using its ID and waits
> + * for any netlink handler that may still be using it to finish. Once this
> + * returns, no handler holds a reference to @node and the caller may free it.
>   */
>  void drm_ras_node_unregister(struct drm_ras_node *node)
>  {
> +	/* Remove from the xarray so no new lookup can find the node */
>  	xa_erase(&drm_ras_xa, node->id);
> +
> +	/* Drop the registration reference and wait for in-flight handlers */
> +	drm_ras_node_put(node);
> +	wait_for_completion(&node->unregistered);
>  }
>  EXPORT_SYMBOL(drm_ras_node_unregister);
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 1765a3130b09..449509c36355 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -6,6 +6,8 @@
>  #ifndef __DRM_RAS_H__
>  #define __DRM_RAS_H__
>  
> +#include <linux/completion.h>
> +#include <linux/refcount.h>
>  #include <linux/types.h>
>  
>  #include <uapi/drm/drm_ras.h>
> @@ -102,6 +104,20 @@ struct drm_ras_node {
>  
>  	/** @priv: Driver private data */
>  	void *priv;
> +
> +	/* private: Internal drm_ras bookkeeping, drivers must not touch. */
> +
> +	/*
> +	 * @ref: One reference is held while the node is registered in the
> +	 * xarray; netlink handlers take an additional reference across their
> +	 * use of the node. See drm_ras_node_get()/drm_ras_node_put().
> +	 */
> +	refcount_t ref;
> +	/*
> +	 * @unregistered: Completed when the last reference is dropped, so
> +	 * drm_ras_node_unregister() can wait for in-flight handlers.
> +	 */
> +	struct completion unregistered;
>  };
>  
>  struct drm_device;
> -- 
> 2.43.0
> 
