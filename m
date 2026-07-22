Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B87C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A26210EE6B;
	Wed, 22 Jul 2026 17:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pqy7jvzf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A1B10E0C9;
 Wed, 22 Jul 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784741460; x=1816277460;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=k8CVVmY+MQRPAsrA9jIUoO38wY1Hm3rWoqXveC5/vw0=;
 b=Pqy7jvzfIGIynOO1it6D5VJdSWb7lgWQMfPPOE88gUcgr97uokLwtKfk
 9iczq2slw7VlY4q4BrvtvWT9LVT/uF/edsaenfIP1cOwCl0KI3r7C9Brq
 vkmhyOQ/b6m5wN7xGybEU5w84Y7KPqWyp3N80L5AkD4kMMUZ/jpnWghMs
 J9jz4B/qAqESUHWOs61HHyd8oJLCQsJr472Jerqqpyd6qoFed/GANIthg
 6GHOEaiJdaldj3zTAEHXREPDPPh2deFuySRkI7j6tz3+6JW5dfHXYyjBr
 iZAgXkuzaTlyQjXYrgx/HpUnyvNcmyDi8QR+H8yqbmRZmNA4p2UmSuUdX A==;
X-CSE-ConnectionGUID: vl7miBKwSQ+5StGMroBqUw==
X-CSE-MsgGUID: VJ2r6PqDSXiHhX2tz4sBig==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85330620"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="85330620"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 10:30:59 -0700
X-CSE-ConnectionGUID: GR+ifr9dSsS3tcg7qG0EzQ==
X-CSE-MsgGUID: Cp9WFHZfQ66wIaOEr2Tx8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="281443180"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 10:30:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:30:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 10:30:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjsehdVRBYt48Ms85NUwkYLKHGq69qxRCtIn/4n1gNTe6Z9aEY04DRzcZyueqvaQptbWAsx9UjXEjg9rQ7/pMRxzpbLAvnuSmoxdJOVBY9lEwcfo3DIi7Neg7BNOJquPDw0yF5bgoqCFViXMf7EL4DGMiA+t8kQifjhcf20QVhTmN/wyuyQGaqhoMTMaIzwn16S2IIIi2rrTLiwOI0yi/udFBGpOLtxWbP+nShxLh9NFP/b8wB3Jke6PScEA1eBSjoy6HKL7K2EDtoB71MaIYH21VqWnOwbffY8o6kpGXJO5w1MzIx70kafcc7J1hqlzFdACIBCUteO1IywEu7zAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYXq15BrAqlN+QZEZQ8dGCBXj4v1qrUz1Jyx3AdygL4=;
 b=JcWWjmEU8K3PfdmwR9URfOWrVFpnb2F6Bi35x9/JIhYEfPMTHObwyWnDaf8VuTGzaEqaTpDXlst2T2Sg27LbDINQ/oUdC5N8BhINUx7a00FY2MCAUowtwGU5lHZF5/yf8wVkvdVCPQy4n9vRhXsO8/xYA66qy0Ey+QeaDjEob3e6YmbCPlF/PqZsukolvDyQm2L0w+6vTe1IeNYPJuyjTil7PwHUjrnZt07GPtd0WreS175eBB9iw+0B1CkdcR4iBOLNTelIUZkhngMkQPdTnZtfTEXTgXTekhdYdNwcVhCxW8zeLvh/GyWPeJGEt4gOQYNPZObg7fCaXpiz2zPWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by IA1PR11MB8099.namprd11.prod.outlook.com (2603:10b6:208:448::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:30:55 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:30:54 +0000
Date: Wed, 22 Jul 2026 13:30:49 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Donald
 Hunter" <donald.hunter@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <dev@lankhorst.se>, <zachary.mckevitt@oss.qualcomm.com>,
 <riana.tauro@intel.com>, <michal.wajdeczko@intel.com>,
 <matthew.d.roper@intel.com>, <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v5 2/5] drm/ras: Introduce error threshold
Message-ID: <amD-SVMRhA0SsW1t@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722034228.662746-3-raag.jadav@intel.com>
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|IA1PR11MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 33670bda-1c1b-4abb-146a-08dee816fbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: EoYi28L5FVPP5hQSa9K+ttVsnUJAtu0v/AQZz2bM/2PUUp/vP5JUmYzrHTouQD+EDPvs45D9ayam+hHRBfxSjRGxb+cy+FT86QGz3cS+eKts8Sf3SILZU42pXkj8C+3ZT56yPvyX/WyxHm7TVWoNnzh2Axmxtipz6huLiZFLklKFo8BWXlxX8k/xJv5zzMWCxxlpItVSr95sr+WlNZRIeQjg5ZcS5lReOHyxwT9WyyVnhvowkN9c4tROwQSssS4HrZzwuh9Iti1MWCm2RrCpweqvGnKe3EjvMiHFch01l+ztGCC9nWeNcrWEnBgu+QoeMt3dsP85Wckaegk6ehtZ/idO9aDAAj6Js3542A4dT/zF5qd8nTXJpaxgzgN5lkWa+18QDNRdQjrLeJNYTqe9TDqMPqPCyl5VKDiHCJJAGWpZZkbaFPlaQriurtDgtLxdgibHVSSTVoljeetnLlnWm7POsT/NcWTlazcDEv0BTtbaAOOb1tkIiYQsz2M79aqKFOc3sqAozs8cgLameKEend5ZJYZKaXA80IapZtS8HlKDPC3R6tcIZkH+SWI2htB6Ff8IV6EYnpLvI6KTr7DfRBuqCkp56+gem/Je3R0aCEpoldoLW54Zo3xxebz+qO6nT5JpCORF5XIVD6f83DRAocVJ0OsYGbT8VuxBunRVft0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wc9+zgOXUNl+yJZSqRZxyCYuCXoV2sxU8UrhyN0ZAwIeX5V8joLNdG2oohCw?=
 =?us-ascii?Q?Q9ofXuyevTzDG6HozaW4X/Se5DRdj7GfSkNfZIZnfN3ZFHNRSgPU/2VnDmJf?=
 =?us-ascii?Q?V9pcAD1299823nDp2MNOlxcFlLyqmRn36fBRgTpEOQHmzszR5rdfGbpDsNqA?=
 =?us-ascii?Q?xbrwNVtapn0sMSqyq1rvIbFss0t6xa/FSDkC3TZUPbTbOcXMldG30Av+DTo/?=
 =?us-ascii?Q?Ljfs0KbxRUb/WWWknaGITfYfsNR22Ap9Zhe6foaH4ymnlAUTt8Z640ILg079?=
 =?us-ascii?Q?cMOMEBKL0oHG8P/Vl+jsFUL1Xa/IjfjyMwyDjViMUwRQ5GgKfwYJ2bV9Ddqe?=
 =?us-ascii?Q?Qt6SsQXwjQkj9XYB9kBLB7P31qyiWJPv4NurUHOSoGBbA9tb0P9o4TwcyHgA?=
 =?us-ascii?Q?/Q0NP1CvfoLc00Ofdw9pLMKQ8RQUMdb2gpQo/f3qFHihTiwsVvsqhzIn1DGn?=
 =?us-ascii?Q?CjgAgXdG4a1x5vf8ycTLv142UTB4T5JqeQJK7rbrfYB8SxuXrDmBeGepd8Uf?=
 =?us-ascii?Q?yg+HXsnXOgm3UWpl8DMoy/9w9fICBFb/GvY1/rMVwd5Hgj8WwYKM+a9xtdK9?=
 =?us-ascii?Q?pn5Y0noEwgkLCkZCHy7w0qPmSbxpnESkYeMe+gbK+oI0qYC5Phq+8LeB6INz?=
 =?us-ascii?Q?tcxbV1wmuiGPtmkQD+SlPJ786/j0pnCPs9dbeXkDAj6cYB4V27r8bho33mUq?=
 =?us-ascii?Q?nPnVRs1V/8t5wLWREUJjmVb08c+NZhEDzJVepYyHszMud2nfnhiHV7KA7HKZ?=
 =?us-ascii?Q?TxDqvu6YOVkA/zbGGFHAUFGr89FIZwhtlqsNDn3eYuwazNJh++1MpYkhtA/E?=
 =?us-ascii?Q?QeYEXJWJE38FWy4TQ8pOIapbO2uF2pIuMV7MJrHuAurqiwTUCMehbyr8oNCs?=
 =?us-ascii?Q?AnJvddDvzooFZjqYbGF6l5oEp0pqnWvyUPcuWogJagcuYs9tHNyHDlWFe+29?=
 =?us-ascii?Q?hTnaPsVZ/SN9V5BVgu44iyFXggjfgmXWW9NyuoWYv82GMHLUKiIqX6/Trt43?=
 =?us-ascii?Q?3qP+FRRu1/7u37Gy+K6E5RoeOlWKW/W+4eYFaFwlcXwm21jFc8SifrQcZmRu?=
 =?us-ascii?Q?FP9pTrjkSQU4wKeKgYAEAJY0TPsPYFcLlthNO8xzRkEPzOcdYzGxHbg3Aa+4?=
 =?us-ascii?Q?jdFWJDhCwI5NNYyMhZwTDLfIaIFOA5/ozySi/ZvSFxPCVm1hQqVWB+KWSWup?=
 =?us-ascii?Q?ApC0DHtEptNlSh0WgIovWFCPhFB24yIZlJttlwWiQpbh6pQe9RxQ/aqWZja0?=
 =?us-ascii?Q?qqMzV+HDy5tVHUWh+sQ+ToXgAGWYd/ZeCGBhIgZQjViY6TpdRjklV95w6l+X?=
 =?us-ascii?Q?V3Bws1l3aYge1SEKN05RM49TVMSt0vxOYYUkItGsfpD1yOIxNKQRFeg4idqZ?=
 =?us-ascii?Q?3RaV996yXhQPSVY2uWFNeQenA/u+2soFKgPbYJvlAPZPLhCGkVrDJRO1Hdek?=
 =?us-ascii?Q?JluAjgrbNlKNCzk+Dp3WdPVxNh3PfoMnYTJPjAhCDrnvyDiwg7jBVVsZdVOw?=
 =?us-ascii?Q?Qbty2AqS4arV26wN95Dz0296qoFgru8/NNCduaCVnodLMzY5iB1fitYG8tfZ?=
 =?us-ascii?Q?6e1pGWKBbDgrfG6rFhRgEEGh+9FWzynKxQaJ5lpQEJnUaVfgV6I6Q6Qno5iG?=
 =?us-ascii?Q?LZQHE3kWqrjAob5lZxir8XC0rP53tdja38CMll977+7zmDirYY2zBlpD33Ap?=
 =?us-ascii?Q?J+ZTlVCncnALQ04+ndhNaGdMMn6EePVJ6vXmOWCPQgsg5uIEzL38Xvb4Fc1A?=
 =?us-ascii?Q?UfQjKYShXA=3D=3D?=
X-Exchange-RoutingPolicyChecked: N9wwykdbRFI/1vLJZvrHH0IjKcPSl8l7kcmSGJruD2l9RPIiLaskVWSpxFsuBMA+vgQLFqdJZ3eJrTk1pGFAUW2B517j3tI8eQPJ0Yuqfj/Sw5C8+fCRVen80Xc1Qn2mJM1V9VokJdMfW4deCpLUC9CLGkynOzqaOHI59zyyK6ulyrtuxo/LesgmhTVCQ3Uom8Xpx6mzypZxxOcQCdjG8J+c7hvlf4guAOtkvSaHA88MOSrzH8psTsU1nrji/pYzPbPnBwVYYPllJ2FsDvSo0aDpCJOklDRoGSSjPiO6fozSy/+i2B4MZLemohUYmrbeq/BY8iCmZ2y9TenLxQU/Ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33670bda-1c1b-4abb-146a-08dee816fbbb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:30:54.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6maGL6lKA7QPpVVlNfw7D7qCeQOHpX8R14VRghmd3fAHi50fkPbQl42Vo8wH6VkvWfuPXp+NEfylYjHYHJkuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
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

On Wed, Jul 22, 2026 at 09:11:12AM +0530, Raag Jadav wrote:
> Add get-error-threshold and set-error-threshold command support which
> allows querying/setting error threshold of the counter. Threshold in RAS
> context means the number of errors the hardware is expected to accumulate
> before it raises them to software. This is to have a fine grained control
> over error notifications that are raised by the hardware.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> ---
> v2: Document threshold definition (Riana)
>     Return -EOPNOTSUPP on threshold callbacks absence (Riana)
>     Cancel and free genlmsg on failure (Riana)
>     Document threshold bounds checking responsibility (Riana)
> v3: Move documentation from yaml to rst file (Riana)
>     s/value/threshold (Riana)
>     Use goto for error handling (Riana)
> v4: Clarify 0 threshold expectations (Riana)
>     Drop redundant wrapping (Riana)
> v5: Drop redundant documentation (Riana)
>     Aesthetic adjustment (Riana)
> ---
>  Documentation/gpu/drm-ras.rst            |  18 +++
>  Documentation/netlink/specs/drm_ras.yaml |  32 +++++

Jakub and other net maintainers, ack on getting this through drm trees?

>  drivers/gpu/drm/drm_ras.c                | 158 +++++++++++++++++++++++
>  drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
>  drivers/gpu/drm/drm_ras_nl.h             |   4 +
>  include/drm/drm_ras.h                    |  29 +++++
>  include/uapi/drm/drm_ras.h               |   3 +
>  7 files changed, 271 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 83c21853b74b..2718f8aee09d 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -56,6 +56,10 @@ User space tools can:
>    ``node-id`` and ``error-id`` as parameters.
>  * Clear specific error counters with the ``clear-error-counter`` command, using both
>    ``node-id`` and ``error-id`` as parameters.
> +* Query specific error counter threshold with the ``get-error-threshold`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
> +* Set specific error counter threshold with the ``set-error-threshold`` command, using
> +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
>  
>  YAML-based Interface
>  --------------------
> @@ -111,3 +115,17 @@ Example: Clear an error counter for a given node
>  
>      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>      None
> +
> +Example: Query error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> +
> +Example: Set error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..9cf7f9cde242 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,10 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the requested error counter.
> +      -
> +        name: error-threshold
> +        type: u32
> +        doc: Error threshold of the counter.
>  
>  operations:
>    list:
> @@ -124,3 +128,31 @@ operations:
>        do:
>          request:
>            attributes: *id-attrs
> +    -
> +      name: get-error-threshold
> +      doc: >-
> +           Retrieve error threshold of a given counter.
> +           The response includes the id, the name, and current threshold
> +           of the counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes: *id-attrs
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-threshold
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set error threshold of a given counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 467a169026fc..9a7b3d2acd25 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,13 @@
>   *    Userspace must provide Node ID, Error ID.
>   *    Clears specific error counter of a node if supported.
>   *
> + * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> + *    Userspace must provide Node ID and Error ID.
> + *    Returns the error threshold of a specific counter.
> + *
> + * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> + *    Userspace must provide Node ID, Error ID and threshold to be set.
> + *
>   * Node registration:
>   *
>   * - drm_ras_node_register(): Registers a new node and assigns
> @@ -61,6 +68,13 @@
>   *     + The error counters in the driver doesn't need to be contiguous, but the
>   *       driver must return -ENOENT to the query_error_counter as an indication
>   *       that the ID should be skipped and not listed in the netlink API.
> + *     + The driver can optionally implement query_error_threshold() and
> + *       set_error_threshold() callbacks to facilitate getting/setting error
> + *       threshold of the counter. Threshold in RAS context means the number of
> + *       errors the hardware is expected to accumulate before it raises them to
> + *       software. This is to have a fine grained control over error notifications
> + *       that are raised by the hardware.
> + *     + The driver is responsible for error threshold bounds checking.
>   *
>   * Netlink handlers:
>   *
> @@ -72,6 +86,10 @@
>   *   operation, fetching a counter value from a specific node.
>   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
>   *   operation, clearing a counter value from a specific node.
> + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> + *   operation, fetching the error threshold of a specific counter.
> + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> + *   operation, setting the error threshold of a specific counter.
>   */
>  
>  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -168,6 +186,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>  	return node->query_error_counter(node, error_id, name, value);
>  }
>  
> +static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, threshold);
> +}
> +
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, threshold);
> +}
> +
>  static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>  			   const char *error_name, u32 value)
>  {
> @@ -186,6 +238,22 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>  			   value);
>  }
>  
> +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
> +			       u32 threshold)
> +{
> +	int ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
> +}
> +
>  static int doit_reply_value(struct genl_info *info, u32 node_id,
>  			    u32 error_id)
>  {
> @@ -225,6 +293,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>  	return ret;
>  }
>  
> +static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
> +{
> +	const char *error_name;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 threshold;
> +	int ret;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		ret = -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
>  /**
>   * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>   * @skb: Netlink message buffer
> @@ -358,6 +463,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  	return node->clear_error_counter(node, error_id);
>  }
>  
> +/**
> + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID and Error ID from the netlink attributes and retrieves
> + * the error threshold of the corresponding counter. Sends the result back to
> + * the requesting user via the standard Genl reply.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +
> +	return doit_reply_threshold(info, node_id, error_id);
> +}
> +
> +/**
> + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID, Error ID and threshold from the netlink attributes and
> + * sets the error threshold of the corresponding counter.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u32 node_id, error_id, threshold;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> +
> +	return set_node_error_threshold(node_id, error_id, threshold);
> +}
> +
>  /**
>   * drm_ras_node_register() - Register a new RAS node
>   * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..02e8e5054d05 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
>  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>  };
>  
> +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> +};
> +
>  /* Ops table for drm_ras */
>  static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	{
> @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_get_error_threshold_doit,
> +		.policy		= drm_ras_get_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_set_error_threshold_doit,
> +		.policy		= drm_ras_set_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>  };
>  
>  struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..57b1e647d833 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  					struct netlink_callback *cb);
>  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  					struct genl_info *info);
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>  
>  extern struct genl_family drm_ras_nl_family;
>  
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 0beede3ddc4e..b1fa87975cc5 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -71,6 +71,35 @@ struct drm_ras_node {
>  	 */
>  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>  
> +	/**
> +	 * @query_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to query error threshold of a
> +	 * specific counter.
> +	 *
> +	 * Driver should expect query_error_threshold() to be called with
> +	 * error_id from `error_counter_range.first` to
> +	 * `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> +				     u32 *threshold);
> +
> +	/**
> +	 * @set_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to set error threshold of a specific
> +	 * counter.
> +	 *
> +	 * Driver should expect set_error_threshold() to be called with error_id
> +	 * from `error_counter_range.first` to `error_counter_range.last`.
> +	 * Driver is responsible for error threshold bounds checking.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> +
>  	/** @priv: Driver private data */
>  	void *priv;
>  };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..27c68956495f 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -33,6 +33,7 @@ enum {
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>  
>  	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> @@ -42,6 +43,8 @@ enum {
>  	DRM_RAS_CMD_LIST_NODES = 1,
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
>  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>  
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> -- 
> 2.43.0
> 
