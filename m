Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3780AC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE0C10E658;
	Fri,  3 Jul 2026 18:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bvZrKcUE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470E410E652;
 Fri,  3 Jul 2026 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783103036; x=1814639036;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FnporP5lNs211HtuuS6Tc5m5W/Bs2VuwYT6h5+Abb7s=;
 b=bvZrKcUE/y4IYgTwbuBRKYzulfN42/l+D/blRVlShUYFk8URnkfFi8Of
 IoTHHlbHV1FzVuCzEq5be075OJ6cTIdJIv+oH4FNRL87BdQcEFlxm0Z16
 SP2lTL0Bih/Of2Lb2PL6btO4DvyDv7r8PZE/SSbXE74st8RB5wwYX+GK6
 RL0EVATHmUJSY3ywad/iyLrN3l4akK/dHlaKN/HwdQ0ER4vi9rIC7MTgR
 13rHXPgUa8CBLQvIQp3FIIXy9xC49fOB3HCyn38Rq7xEBohi73U/dTATB
 kelzDNCgeeL78ZLHrU5PMHVwu+nYi44c9RiJ/coYKqyJo18Gu43JUeysY A==;
X-CSE-ConnectionGUID: wk41m86KSHW63cWON83LIA==
X-CSE-MsgGUID: 16Y+2AkZTYWNKNBlFfnjaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="106650972"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="106650972"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 11:23:56 -0700
X-CSE-ConnectionGUID: 51/HR9G/R+aePW9uUWOYuA==
X-CSE-MsgGUID: 436OwJrXTe2q0nOP7ZHiBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="252107276"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 11:23:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 11:23:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 11:23:55 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 11:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emGpvtyLhswycK4r+R4wAEDjCcNazNx07opsDsbD0zF4aCpLIKmqKFSFnt8+uHof/3yRd99OX++ZajVdaKm67aDv/Ou+EhULV7nqOX0EIMFdsu4L8/gOjsKp1tPXm84aG/6SpWptOnqJAAMiLy4yJY0a4LdWvZ0EkMsCwcSBadNpr7HhH5R0dD9GbpQHovPr3+tlkvF5Bd/jPuwLWlYFOdAISQuSubgqtkPGdrRb/QQ2fYE1i66nmI2ijP+9IzeqaH9GWiQKUNm7k+aMRlr6kvahS6Nk5vqCIr/Q4ZvqNq6dk+hrDTBl3vrTNuDkg65ubfpT+zYNxxUf4xbnk9yAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmV1ECmdPYnq2eC+Z84/XZpeiKpz3bjHYdtsmvCBwcM=;
 b=owfq8AM80g7gsv22eEhnjTtls/L29Kd/okq8CUmWGndj3hc+H2HmBoQrDiXqmiME7Ye/yb20PRbCV6VsKz+jOekccSJ01+JmbnidTo7rzS2ord6UezKpnaU69mBI5sZ1ypHWU67YhLeDhYD/+es40AsL197T/DCR0Zushz5jOHQL9gMIt2BfNTNW9UhpSiUVKTy0KnXGIkuqu3/Yxor4loqYRKn/xILreMgVYl7qkVkUNX7/c2d3YNRzMvkC2+yKaouejFsgGhw6vv8xRsTsg9tuXLDmCZmhN17jJixUssmB/7clWwLj5irWJtKPllBpMId88c0422Yvn+kUJlOeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 18:23:47 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 18:23:47 +0000
Date: Fri, 3 Jul 2026 14:23:44 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Anas Khan <anxkhn28@gmail.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Lucas De
 Marchi" <demarchi@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: remove duplicate <kunit/test-bug.h> include
Message-ID: <akf-MOs-gKIcGQ-9@intel.com>
References: <20260702112820.34675-1-anxkhn28@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702112820.34675-1-anxkhn28@gmail.com>
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH8PR11MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb5c8bd-74c8-4b1d-c0fd-08ded93038e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vCTT7OoFoEpAWhSTfzlHHZPB0vg+Em1xlNYsQWOyHur8eM/da9AReJWHRnnf/K3NcfbbIzf49tAAy38R2y0S6uim41cyOda8CNpvLsSdHbbbodNPiwhM0YjpRj4hmd5bXDXo0qZ7svi+qWlrqF5CxmVmkPH4BCDWnL1gKj9xIZgxLD61re396h8tZ2yUxKVaaF8kBXGaQ76dil9a95a7j9i5GgGUnaEWSIudAfZ+b4B2ukv5830CIz3WRINrCZOfbtq33uTfJc0oxIOamAPYFV05CTayZ8UJ+n2eRsjGC3JqwgMDCozRb7uUPJ/nwulVpAxSAvI4so4vUIBGqhK3CqqCya3nN3ampgV51nof1F84AwOmMQhdIqN9H2qZPEyKfutGTodpnOez4ZbQ9s9zzMMo6h7z1dExVl+bo1kfAbQGzmCya48UM/wnjm/FfUZKc1HlEcR4XjM2r5Od/oY+EaLezhOozZStd+VXEJck1xhkr8YSfyGoX/Lb4qplS88zjNqiKipVO1LWnpqma93XVH/NizylZhKx7FW3Si6xB6qxuqtOQPFyw92k3R4X9q6sbSxNeDeN9MRzvoOTZaGpOqR+MX8tu1OnnrvtKcHZK9Pnbi7tb/a0unwKVyYTtUemEOS0ge4sASuwCD2CseA/JhyV2/uGEIwShpPwbqfgWo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bG4AgiH0CCPBWW30zFW7JFDXyLcGdLrCcNxBNjWT0o6YcQtuTQ2rsoWAk0Qg?=
 =?us-ascii?Q?GK0vQoFAOvuT5fMS4tc0xH1JXoxBpCV9nmkej2k8xT97hgZXYgqQkQSAJGTc?=
 =?us-ascii?Q?vu12/MFf6dgzVUBe9DLWvxCQmWgMrkY6cA1GZ8bdzuSFLsh/pO/2910mPhIj?=
 =?us-ascii?Q?K1UeH4gDWhc3Ks5yS2CnJCHQbGGseDjEMRDF+rb1sJvUCTQl/dG3BVJM7B5J?=
 =?us-ascii?Q?l+mW1Tmo6OaxLq2cCZ/6iDNhJAyVmRBLvclxt9wUxM4CGcopbmuU8mYyjbAj?=
 =?us-ascii?Q?SmEKJhmCl4wuk9jI1lB6bPUMIC1l7kiCuD/cugRYhyAkwQ29Jt6O/7ctz2a5?=
 =?us-ascii?Q?EIB6rM1EeCjL2QXdUgK4i4+vtzOBgxjjSyLxH/bwSfTD+Tx47/gh2SwQiytO?=
 =?us-ascii?Q?HFXFI+mgsAGqKXGKmJRgT5Pm9aQS/jprC2XV44rxxVQxjiycV6jaV0FjhdIV?=
 =?us-ascii?Q?zr302JezUkARJgk3sV0I/NZRTlZ0gfyHTWZ4paF+qJk+awiSjW64UMVI1JzI?=
 =?us-ascii?Q?UZCBtEUPIBRf6Yln9xCcpfpNA6HNbv5pbJzc4JVgii3oP3+9kgO6+r6eyUQL?=
 =?us-ascii?Q?oc9eHVZN9wfu2iFl3BgGogmisaxSapja6z8VMlLKflDVv2PGjGePIYzLJ2Cs?=
 =?us-ascii?Q?k8gveAZEIUwCl5s5fFKAtt2XUzK5s+8gQK3xSoNyb63vpLZLiNSNXoSLI1AV?=
 =?us-ascii?Q?mNpRvt7keQzCl5SCDoUaeCRfZ9Wxm430Nr3U0Obkfk5KpUBDADIDUfpKz33s?=
 =?us-ascii?Q?aHzewdnYN+sxvt6tQYkSnPGER2Daa/+d/2O4RyIkOJx9zozWr/I8ggkF9B99?=
 =?us-ascii?Q?yGcZQFvdmvN1vjr+f+p12rWj5aCuH/GslNJ8GcjBNhqO05tmF9ahsQkRwEUA?=
 =?us-ascii?Q?5bdcKGJFTqBQub0Qaa2CSIkDSG9gmfMylbOMHJvaT47Ey/+wELU+eevbDz1s?=
 =?us-ascii?Q?oRlngOUnrZo31Cz6aS1E7oZNFN/7BUBIKulIyLPqDxevzOZhG1+XBADyEsXo?=
 =?us-ascii?Q?keSexsuG4nbGvngv6FlfpJinFrhIW9B1zlCuZrjaUb+WPVbQetDx6HRJ0PqA?=
 =?us-ascii?Q?JV6ui/vTlGJ33Z9FzwytqYH4iuEonjbeB3LodXL8nLxamaTn71lpEiReZkbN?=
 =?us-ascii?Q?wFJGFhJ/1njtvMqSOQ6Lf4MhNcXlx2W+/Ina7GPGVTBV5/8a+eSy/2vrl/9/?=
 =?us-ascii?Q?Z3+QQdVvHIXI/LeS0552hl0EKyaxzHH4t5PSB0DyQWP+I/OHrRA0gwExAHiy?=
 =?us-ascii?Q?AafJedo8GwnwlS16fCdUYPmAeFcHeDVzX9i4N7cB4hDV1qKMMsd6NmqvAi8u?=
 =?us-ascii?Q?Pek2SWtgw1wr9S1y7aYD2KoMJUnYSTKwIzcMwkycV717JunWQpKghRPcXlnp?=
 =?us-ascii?Q?7C8SMW0eqJqTSVbLIu8/k/oaQfE07n4z9junZOcAjyZsCS9lb8KML4vMXUNR?=
 =?us-ascii?Q?PWlrQ+QqR1Ynu4cTh0OQa/EQX0HtCObGeW96wSzLBEzV4k+33p+uJvputmLL?=
 =?us-ascii?Q?8k4xV5qN9zibQ52RCRGWj4XML2yyrJcQQUlRFxkB593P+0oOto5LvK7cJ2lt?=
 =?us-ascii?Q?zKvbBuVLm3NmAmj0coyaC2o5UUxRwwi28Ib4QmrSvp8UhdAhDEODmmnvg8/E?=
 =?us-ascii?Q?7OrWh1rZw9dU8LykxByoqCKNzEI8tbls3yXDRjgiXrjB21O88zals2apR+LZ?=
 =?us-ascii?Q?KA5SF7spgsUiBJPV9psET99zyFQmHfsePe66Li0Yg813xjslJN7vJYxWUcgu?=
 =?us-ascii?Q?4rn0PDiFJQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: g2mXbjZZzk3gyYE/fwglO2uEtaVShouZ9KK8GLaiUrS9ucZJSqM6QvgAG6aCjUY1QU3j4Aw+/3rUAnvKXZpS7JyAZrzLmVxsXVfehoIpG9XJNyUQJDDdqts9sKs6j3BGNxUHuX68dlwNXWOcTbdyGKSS8MUHJy02p5blmRfqyyd2VkroK6OO5I6EjIrFhI/VXP89B/6FVgZk3P0QNQHiwkfyKKGK2BSXnmLxJVYpcTG/opU6++Ttwcd37RgSoE0rm2RVFSSSbCcPY3JeNjBEDg6SNS/H6k8l+GDCyS5w+uRvOl0c5xbV/OcPlTMA7eZK4xk4XDP5QaOz4+9ik2bUwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb5c8bd-74c8-4b1d-c0fd-08ded93038e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:23:47.0379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkgiWLkr8HXt3sYXI7KdHFJLhFPnHfMb8/NOKxW9pKX4l9wOAlWFKOPx9F0Uqaau5SSuj/fV3Lr7dWbs9kdfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
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

On Thu, Jul 02, 2026 at 04:58:20PM +0530, Anas Khan wrote:
> xe_pci.c includes <kunit/test-bug.h> twice, separated only by the
> <kunit/test.h> include. Drop the redundant second include; this is a
> non-functional cleanup flagged by scripts/checkincludes.pl.
> 
> Fixes: 6cad22853cb8 ("drm/xe/kunit: Add stub to read_gmdid")
> Signed-off-by: Anas Khan <anxkhn28@gmail.com>
> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
> index 9240aff779da..c2c686aed1cb 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -9,7 +9,6 @@
>  
>  #include <kunit/test-bug.h>
>  #include <kunit/test.h>
> -#include <kunit/test-bug.h>

Thanks for the patch, pushed  to drm-xe-next

>  #include <kunit/visibility.h>
>  
>  #define PLATFORM_CASE(platform__, graphics_step__)					\
> -- 
> 2.54.0
> 
