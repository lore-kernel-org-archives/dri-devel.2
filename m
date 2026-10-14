Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F9CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AFF10EB1C;
	Wed, 14 Oct 2026 21:11:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0B810EB1C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 21:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792012280; x=1823548280;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0ZZLFG2phBF8qZijCTAFU3Mx8Eq8DM+LCqNHsRp1eYM=;
 b=g52W31y6XJJbP76wlLeXQ/AlgNCzu0wPgjfJ2PoNpqZKD/QddpiiAwsr
 S7FbhH4LqcR/VyKOJ51YJ41x7uFy98I0lTdMLm71p5u0BJwDj+qORFMQi
 r/h2qdnpjAYnOl6XQFO0DngBcRTjKCP6EAIZaTvkzZP7RoyEO6gnMeTn4
 RNAHay55iGzhV2+CwEoscoL5Z+v9xurW6VhugohWoBEklvRtqAWtCy3oq
 o2V9pgpdscxvZJ8Kf8+JWlwtf1R9yuJdAilGkgrnRVQHvg4MUSLrZdXFn
 xmL6gZnurt5np3noYHbyOyIGnRdx2/cklMrfxEA0IF4vHVMvlVjAi/lLA Q==;
X-CSE-ConnectionGUID: 3XCCJ1jJRoeB06bHaJ4tcA==
X-CSE-MsgGUID: 2HiIL0uuR/+TXUv8DtMXjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="672347"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="672347"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:11:19 -0700
X-CSE-ConnectionGUID: QWIqAkXJQtqVX/VM1mS/qA==
X-CSE-MsgGUID: xtqIsdG1RwiB1a72OdFaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1634598"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:11:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:11:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:11:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:11:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/d9F+pbC190fvXsjF0ENpTW5hJLrGoMfYW6xNVcAULxaa3rUTX+dft2ELYSiEEIHJvQRKQESQKaxC6MZWkBBC13TnNYLayTf9BU0xEKHHIBh/cdIKkSHX3djw3exkpJfNE+xNY+nEdhnjd6BxOy/7ZiwFoLjRWCQybXIcVZUbIVHGdi0oATvfGmBLEhhihWckSVO3mbQkLSz5mX2zqVZKUc07hN26Sd/IroAw9y5vYeyNYH/aLFezibCDE3NsazV4Ue05dyIKaIxETF7zFB1vaykNbE/X3KEeixNLV7qoA5OmejDP8+7RAcJ28gfKinpyBLObaDSCayWQTtID9ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KXW8umTMdfGi0v2BIkWbaoIZJqo0HnnJRLivO/3zs8=;
 b=rSe3SfgeZpVkgzyaaB/ScE2NprX9qTS6DWDC0SspG4Hsu39Qzpp8C4QexTsoMR3a2Yknct9Sr7aLM4GY5TADl13mkBv9tqQ+PKJ4rjd4x1me/IoCoidWrUsM6yzSyO+r2B+rrTGFCqfDwbv8jQMup8F6U9mtV+9UkBpVYvdS/zfL5LKC4zXzlWL9mnlREiodlmf0ByZsgKDJW17slj3mF4+dbVEHxl53+YitumHCrsOKVEER09x5qIbIahQU0e3AtUpFSjQa2HWHq0m9GMonoPa9Diam0mHIqDsDd2sLdncXam6gyqidbV8GEgMEn+TdTZ8cOqIk0hvO0plN6sZLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by CH3PR11MB525758.namprd11.prod.outlook.com (2603:10b6:610:34d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 21:11:12 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 21:11:12 +0000
Date: Wed, 14 Oct 2026 17:11:06 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <as_v6iB__bh3cHm3@intel.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|CH3PR11MB525758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a97225b-dde4-4ead-a5e2-08df2a37ac6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|22082099003|10067099003|18002099003|261009221727099003|11063799006|261009223327099003|261009221227099003|261009220027099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: wrGre8a7tXHWMktA8eiL7RZstbSGpki5cCHSDkbF37MjQdmSLYrqifmjt27/jWu4tQ/nyDEbaPXUP1Ta2iVoL/iI/HjAIrrVWcYge6MhkvLUZmokrDQI4Gkayknk6dCl49iJFmZ65TJwREMMUBA+h/Ul856WBs5fgVihg5tpb0Yd/HZxyPwbRDG60gxQHsEYKH+nkANEpEg2W1Tm+4duJLTLwT+c+8DG/zc4Yarfs9eIStkUdDcnenOXe6HjTLcCsXxOyJgKBZAJefXZ8XdTwTq+piaq6RbH+nCab4uMqWVMSQS0nPzEvn/IN+HYddhq/i771f/MqNd5/sewwwXeyp+OOF+RkkN1H5Jso1tIIjwM1S36kIrOcj7qp31i2Z1LuaAUCZoeXPmlgAX9iInpSRYXZHWeDV6++oMMSgOpGlBkG7J8D8XpK9dPjBVssm1jkh+hC6RViIOsypxoOqRW/2JpGXNcItayVGSV/o7nyWEuuiImggLWcrOGi7HcnXrN6mjSJN+qlMogqD+CRFHeOx5urVyPpJiOj74hSc3cql52Y13qI653kUC8dM1yO2jGHwxMO0RPLgh/IEKnLoziqJg2Q8AP3uX9ILgZ+HfTROLCWrteOrt0/zBeUYU95nydpsQRqh0l/R0zrT42U54gJ9laAri7OVz1gG+woz9BJRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(261009221727099003)(11063799006)(261009223327099003)(261009221227099003)(261009220027099003)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TwjjQIMjsOCSZhPZdTQe21YS3rnKvG5NOFN5szH6uQhZ1YXIrzjm7bvncVE?=
 =?us-ascii?Q?jJf5D9iAZZZsVWuYHvw19TZ0uvQjeoVq0abrnCQyuAmvzHm0PMa+Tvac+HGP?=
 =?us-ascii?Q?6VVQ1XzDOEfwshn7IFAnBMeINew+U/DzyYBNtWrXri4yoxXP+iRBI/KkO+vL?=
 =?us-ascii?Q?cbHcYbCgXXeqdqBwqkvi+SBWhmpbb/LYJOLLPhdZjRAg/sByrCV/08mlbDjm?=
 =?us-ascii?Q?oEZNmUrLLf1WZ77TBYaRF3WYDFK/PpSGu6+Fq+UT3rGUdAcEjnuUNJcxWIlI?=
 =?us-ascii?Q?w4zZ+i/000OUMpC4RtIkv8XnN/7nBcsxKT48KPzEajmtbgyCCQleZOvXwlXt?=
 =?us-ascii?Q?bDDe45CoUoVhKzlj4RBos6Q7XA2Uz/MQn83TVIon9hPCUpvcFWMAFjc4qOj/?=
 =?us-ascii?Q?mUxReG4AZVI1FAU/cnmjdrhKUmm2CRvr+Y8mQbnQ4AgzhhfIdhPHwe/bqSED?=
 =?us-ascii?Q?3jgTjxJ8KE7IU4cn+hgzFV4QQoHKbX6p/Fm5Ak/EFizruZBWn96vwEARKZdA?=
 =?us-ascii?Q?cVrRYu005N9S1WV8hIIUcrxaVWNw+mbhIsH8+hC3sZmlb/ITApX/s5K4aOmI?=
 =?us-ascii?Q?gCE4n5ffiOb7VTLue1y9YBhCW1/e9zl864F6b/v/pyjF4kfFynwycWPB0xHQ?=
 =?us-ascii?Q?yAwLKMdS6brI6AU5KrmFOYRpBU5wZAbDDB6SEv4FS+WqHNv4O3cUvzBS/O0/?=
 =?us-ascii?Q?GAJsvUlLV4ytQH5ZNYawB5JaNu5JkJKQMhpgh4SZIMdK1lo2+2jHgunzGmeb?=
 =?us-ascii?Q?8LaGDOid2zQoFMLmBwddKpSp8r4IEs5mniyyPOZsTTqPc2I909rSibIn+Tvm?=
 =?us-ascii?Q?7OIz3t8Z1zGICm6JkqNz/TzqVXm13KteOqbw0LgfWrKJzIbxlDLu9Qi+7j6J?=
 =?us-ascii?Q?33brY/94LtJO8T0Vn+hjFRqI6sACjYo6lrq7EEvQr3RG9xZro36e5856mjSy?=
 =?us-ascii?Q?52MSxMxuL/PIRGzMZEBS8Qd4NJlwKh4rnO2Kk+LYhZyAcHIsy3qSQM1x0lVF?=
 =?us-ascii?Q?I/5WBU6Bh+IoOO1zTqYOe/j2mTLFs6Q0zNq4xj3gkn6JmJ7A0gcW2oAZ2wZm?=
 =?us-ascii?Q?VOaz7zA5CsiEHEwBxAv1/RZ4g4KF5QotTzKC6BdAXveKw0LNxE7WE8YyQa4G?=
 =?us-ascii?Q?91gtDGnLOoyVIJWXtptQnk2CmITrpSDD0RspeKAmc0FJj1xPRIWEtEcSLb8c?=
 =?us-ascii?Q?k1T4soQ+4pVqhGiEwqpQDqpsTq/sXMVh/0jXtsLQFzKBmeYKdiyqS45kGa84?=
 =?us-ascii?Q?8pgqUfk8bphEb/Rcx5yrQh9BiNO3trb4A/CCnNCp//RDUXV41VNptFnhdGKI?=
 =?us-ascii?Q?Rinn/UWTLIuxKqneL09WoECL4yKJVtRNJytJGefE+srUKrv2UqR92T2PCVhi?=
 =?us-ascii?Q?jbitpA3YeN+4Bm7sVPVdiirD40mpRk0HdCcIpapCxHj3D4N7y6jx6t20lqLe?=
 =?us-ascii?Q?+wbDsjJiyu0l0oZKJGtsGCJH1gv+2jkmEchEWLlZUY/bkYbpxDRXICdrYmXp?=
 =?us-ascii?Q?GWBPUI44q0FPO8V0yS+FAGKlQuXok3Ydc2zMxWiYriNqyaAoOqUEGZR3NIze?=
 =?us-ascii?Q?+6viFX3aOHSgE2WYlMswcxFbJlWUUABHLPMzYMvUtAZHpxugUmiHBiShbqbj?=
 =?us-ascii?Q?fx4iFNscobbJAKeXq2iMU66H3AuCoYjMUSuNQ5dZQ2FiKdcCVjwI9avnnP52?=
 =?us-ascii?Q?dX7Be2wvj/5qorL0HmpORkXA2Tx1KGvcXztXhzesg6JHTskan7n/htnHCWD0?=
 =?us-ascii?Q?QMDHcy7BAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 5gBfyccgDg8lqCNzwBT6kWs6MZ7OaaGe0JP8QkFaUmBfLsUtI+P4OyvFydq6nTDsnrBM6ozvwcffuo1aFAqv4nyk9WCrk1t9bvNe/aPZAKNAmLZbbS5hIFfvv5vEnwSxpiOmnKONQPBILGdQ5vozsNRuSYb9hWybLox8eoOi3AE/UZ2QwgC4SJINDBGfSpkkdnInqaxcN+VkhhJEOW+KuCXAXoq1hOwANB6UGdR4koEVqnoYQOAmTJEArEqMYoUnBRuHahLmaL65SpGX1rnMyY84Nf4eXyRSg69WqaID/HLyJTsbj+vMLoQ3ZD86JzJ7Svx9UMIgfoWvEIPweOdh9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a97225b-dde4-4ead-a5e2-08df2a37ac6a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:11:11.8656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olug/t4z8xVp6FlMeo4t0bWuVNh3o8mCT7d70A1cov0z8NvU9HuE8l76/CY03Dn37xZI1wmYinDaQr4rgKkbmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB525758
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

On Fri, Oct 09, 2026 at 10:31:51AM -0700, Zack McKevitt wrote:
> Add a new node type, attribute set, and doit function for performing
> telemetry read and write operations using the DRM RAS interface.

Hi Zack,

I'm glad to see more users of drm-ras and glad that the flexibility is paying of

> 
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> ---
>  Documentation/netlink/specs/drm_ras.yaml |  55 ++++++-
>  drivers/gpu/drm/drm_ras.c                | 193 ++++++++++++++++++++++-
>  drivers/gpu/drm/drm_ras_nl.c             |  29 ++++
>  drivers/gpu/drm/drm_ras_nl.h             |   6 +
>  include/drm/drm_ras.h                    |  39 +++++
>  include/uapi/drm/drm_ras.h               |  14 ++

just to confirm, you used ynl to generate these most of these files right?
Please make sure to mention in the commit message so we are sure.

>  6 files changed, 327 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index a88fdab7a1c7..d558eb1cba3f 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,7 +16,7 @@ definitions:
>      type: enum
>      name: node-type
>      value-start: 1
> -    entries: [error-counter]
> +    entries: [error-counter, telemetry]
>      doc: >-
>           Type of the node. Currently, only error-counter nodes are

Please ensure that the doc is also updated.

>           supported, which expose reliability counters for a hardware/software
> @@ -100,6 +100,31 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: >-
> +             Unique identifier for the node.
> +             Assigned dynamically by the DRM RAS core upon registration.
> +      -
> +        name: field
> +        type: u32
> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> +      -
> +        name: value
> +        type: u64
> +        doc: Value of telemetry field that was read/written.
> +      -
> +        name: status
> +        type: s32
> +        doc: Status of the telemetry operation.

is this status the hardware itself that is giving?
Please add some doc around it to help us understand the need and see if
is generic enough and mandatory vs optional.

> +      -
> +        name: pad
> +        type: pad
> +        doc: Alignment padding used for 64-bit
>  
>  operations:
>    list:
> @@ -198,6 +223,34 @@ operations:
>              - node-id
>              - error-id
>              - error-threshold
> +    -
> +      name: telemetry-read

should we do get_/set_ instead of read/write to align with the existing
entries?!

> +      doc: Perform a read of the specified telemetry field.
> +      attribute-set: telemetry-attrs
> +      do:
> +        pre: drm-ras-nl-pre-telemetry
> +        request:
> +          attributes:
> +            - node-id
> +            - field

how do users know what field to read?
Why not a dump or at least a dump field for field discovery?

> +        reply:
> +          attributes:
> +            - value
> +            - status
> +    -
> +      name: telemetry-write
> +      doc: Perform a write of the specified telemetry field.

what is a write telemetry operation?
can we make this optional?

even write is allowed without admin cap?

> +      attribute-set: telemetry-attrs
> +      do:
> +        pre: drm-ras-nl-pre-telemetry
> +        request:
> +          attributes:
> +            - node-id
> +            - field
> +            - value
> +        reply:
> +          attributes:
> +            - status
>  
>  mcast-groups:
>    list:
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b099eb67836e..b88293295cda 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -53,6 +53,15 @@
>   * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
>   *    Userspace must provide Node ID, Error ID and threshold to be set.
>   *
> + * 8. TELEMETRY_READ: Read a telemetry value.
> + *    Userspace must provide Node ID and telemetry field to be read.
> + *    Returns the status of the read and the value read (if valid).
> + *
> + * 9. TELEMETRY_WRITE: Write a telemetry value.
> + *    Userspace must provide Node ID, the telemetry field to write, and the value
> + *    to be written.
> + *    Returns the status of the write.
> + *
>   * Node registration:
>   *
>   * - drm_ras_node_register(): Registers a new node and assigns
> @@ -63,7 +72,6 @@
>   * Node type:
>   *
>   * - ERROR_COUNTER:
> - *     + Currently, only error counters are supported.
>   *     + The driver must implement the query_error_counter() callback to provide
>   *       the name and the value of the error counter.
>   *     + The driver must provide a error_counter_range.last value informing the
> @@ -81,6 +89,12 @@
>   *       that are raised by the hardware.
>   *     + The driver is responsible for error threshold bounds checking.
>   *
> + * - TELEMETRY:
> + *     + The driver must implement the telemetry_read() and telemetry_write()
> + *       callbacks.
> + *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
> + *       to enforce permissions checks on telemetry operations.
> + *
>   * Netlink handlers:
>   *
>   * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> @@ -95,6 +109,12 @@
>   *   operation, fetching the error threshold of a specific counter.
>   * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
>   *   operation, setting the error threshold of a specific counter.
> + * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE
> + *   pre_doit operation, returning 0 if valid.
> + * - drm_ras_nl_telemetry_read_doit(): Implements the TELEMETRY_READ doit operation,
> + *   invoking the driver's telemetry_read callback and returning the results.
> + * - drm_ras_nl_telemetry_write_doit(): Implements the TELEMETRY_WRITE doit operation,
> + *   invoking the driver's telemetry_write callback and returning the results.
>   */
>  
>  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -617,6 +637,156 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>  	return set_node_error_threshold(node_id, error_id, threshold);
>  }
>  
> +/**
> + * drm_ras_nl_pre_telemetry - Enforce permission checks
> + * @ops: Generic netlink operations
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Enforces a telemetry node's pre_doit conditions (if they exist).
> + *
> + * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
> + */
> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
> +			     struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	u32 node_id;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +	node = xa_load(&drm_ras_xa, node_id);
> +
> +	if (node->telemetry_pre)
> +		return node->telemetry_pre(node);
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_ras_nl_telemetry_read_doit() - Query a telemetry value
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the telemetry field from the netlink attributes and
> + * reads that value from the device.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status;
> +	u64 value;
> +	int ret;
> +
> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
> +		return -EINVAL;
> +
> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_read)
> +		return -ENOENT;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret = node->telemetry_read(node, &field, &value, &status);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = nla_put_64bit(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, sizeof(value),
> +			    &value, DRM_RAS_A_TELEMETRY_ATTRS_PAD);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +}
> +
> +/**
> + * drm_ras_nl_telemetry_write_doit() - Write a telemetry value
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the telemetry field and value to be written from the netlink
> + * attributes and writes that value to the specified field on the device.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status;
> +	u64 value;
> +	int ret;
> +
> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
> +		return -EINVAL;
> +
> +	value = nla_get_u64(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_read)
> +		return -ENOENT;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret = node->telemetry_write(node, &field, &value, &status);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +}
> +
>  /**
>   * drm_ras_node_register() - Register a new RAS node
>   * @node: Node structure to register
> @@ -631,14 +801,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
>  	if (!node->device_name || !node->node_name)
>  		return -EINVAL;
>  
> -	/* Currently, only Error Counter Endpoints are supported */
> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> -		return -EINVAL;
> -
> -	/* Mandatory entries for Error Counter Node */
> -	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
> -	    (!node->error_counter_range.last || !node->query_error_counter))
> +	/* Currently, only Error Counter and Telemetry endpoints are supported */
> +	switch (node->type) {
> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> +		/* Mandatory entries for Error Counter Node */
> +		if (!node->error_counter_range.last || !node->query_error_counter)
> +			return -EINVAL;
> +		break;
> +	case DRM_RAS_NODE_TYPE_TELEMETRY:
> +		/* Mandatory entries for Telemetry Node */
> +		if (!node->telemetry_read || !node->telemetry_write)
> +			return -EINVAL;
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
>  
>  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>  }
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index ff0dc406c27c..4577bc1a333e 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -41,6 +41,19 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
>  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
>  };
>  
> +/* DRM_RAS_CMD_TELEMETRY_READ - do */
> +static const struct nla_policy drm_ras_telemetry_read_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_TELEMETRY_WRITE - do */
> +static const struct nla_policy drm_ras_telemetry_write_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
> +	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_U64, },
> +};
> +
>  /* Ops table for drm_ras */
>  static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	{
> @@ -83,6 +96,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= DRM_RAS_CMD_TELEMETRY_READ,
> +		.pre_doit	= drm_ras_nl_pre_telemetry,
> +		.doit		= drm_ras_nl_telemetry_read_doit,
> +		.policy		= drm_ras_telemetry_read_nl_policy,
> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_TELEMETRY_WRITE,
> +		.pre_doit	= drm_ras_nl_pre_telemetry,
> +		.doit		= drm_ras_nl_telemetry_write_doit,
> +		.policy		= drm_ras_telemetry_write_nl_policy,
> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
>  };
>  
>  static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 9aef097ea10f..4bdd7ed268a1 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -12,6 +12,9 @@
>  
>  #include <uapi/drm/drm_ras.h>
>  
> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
> +			     struct sk_buff *skb, struct genl_info *info);
> +
>  int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>  				 struct netlink_callback *cb);
>  int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> @@ -24,6 +27,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>  					struct genl_info *info);
>  int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
>  					struct genl_info *info);
> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info);
> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb,
> +				    struct genl_info *info);
>  
>  enum {
>  	DRM_RAS_NLGRP_ERROR_REPORT,
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 1765a3130b09..2a2cdd44839d 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -100,6 +100,45 @@ struct drm_ras_node {
>  	 */
>  	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
>  
> +	/**
> +	 * @telemetry_pre:
> +	 *
> +	 * This callback is used to enforce any pre_doit conditions necessary
> +	 * for telemetry. This is an optional callback for telemetry_node.
> +	 *
> +	 * Returns 0 on success, negative error code on failure.
> +	 */
> +	int (*telemetry_pre)(struct drm_ras_node *ep);
> +
> +	/**
> +	 * @telemetry_read:
> +	 *
> +	 * This callback is used for a drm-ras telemetry node to read a
> +	 * telemetry value. This is a mandatory callback for telemetry_node.
> +	 *
> +	 * The callback will read the desired device-specific field into value
> +	 * and update status corresponding to a device-specific error code.
> +	 *
> +	 * Returns 0 on success, negative error code on failure.
> +	 */
> +	int (*telemetry_read)(struct drm_ras_node *ep, u32 *field, u64 *value,
> +			      s32 *status);
> +
> +	/**
> +	 * @telemetry_write:
> +	 *
> +	 * This callback is used for a drm-ras telemetry node to write a
> +	 * telemetry value. This is a mandatory callback for telemetry_node.
> +	 *
> +	 * The callback will write the value to the desired device-specific
> +	 * field and update status corresponding to a device-specific error
> +	 * code.
> +	 *
> +	 * Returns 0 on success, negative error code on failure.
> +	 */
> +	int (*telemetry_write)(struct drm_ras_node *ep, u32 *field, u64 *value,
> +			       s32 *status);
> +
>  	/** @priv: Driver private data */
>  	void *priv;
>  };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 2f832275ee6e..d39c78a9ed5a 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -16,6 +16,7 @@
>   */
>  enum drm_ras_node_type {
>  	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> +	DRM_RAS_NODE_TYPE_TELEMETRY,
>  };
>  
>  enum {
> @@ -51,6 +52,17 @@ enum {
>  	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>  };
>  
> +enum {
> +	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
> +	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> +	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
> +	DRM_RAS_A_TELEMETRY_ATTRS_PAD,
> +
> +	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
> +	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
> +};
> +
>  enum {
>  	DRM_RAS_CMD_LIST_NODES = 1,
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> @@ -58,6 +70,8 @@ enum {
>  	DRM_RAS_CMD_ERROR_EVENT,
>  	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>  	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_TELEMETRY_READ,
> +	DRM_RAS_CMD_TELEMETRY_WRITE,
>  
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> -- 
> 2.43.0
> 
