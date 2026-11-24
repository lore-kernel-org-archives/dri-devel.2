Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EDE606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bSRVSEwi;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WmnaBxBI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C4E10F10B;
	Tue, 24 Nov 2026 22:29:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42D810F0D9;
 Tue, 24 Nov 2026 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795559381; x=1827095381;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=e46/a2ru0eFwK0y5CYHfv7gL+49xMduB7XcFIY4SGCc=;
 b=bSRVSEwi74YsJC9sHbQSIQsCCDLmhxDMfBYTVD6QTRDdZIbb5L67hNB0
 HzZyoPuAuMrO4jpMXy9nUQv9hq+CGcV8i8ipu2LMrxRJzqiH3jxc/sMS7
 WXkfu+mR/tGGCSOYHq1Y1yVGkMbhwtqT6ycolNyT8hi5VenBkozcBycKE
 qv026tdHmc/HtWv9MGsk+vC1Hqtx0qD7G660Nj6V1oNbSw2MzonLTJn5b
 TQ88qj//Qgurw4MyFamQTXEeRsf8O0rDZCDJuw5GbVrLPygGa8AuUzNtB
 hYvlMYz0QjRpMCo/+c6aFos5PGdiiB2TJ8C9umeJbZLzGaphx1cuVJ2Db A==;
X-CSE-ConnectionGUID: 94FnHXF9Q3OLqeuoVAsHxg==
X-CSE-MsgGUID: ZP/nOCz5SdyJlqiZyKsmIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306957"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306957"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:29:40 -0800
X-CSE-ConnectionGUID: OY9pkUTFSTihsx/1kivRkg==
X-CSE-MsgGUID: iXBmBqFqSRGFE3ErGq7HKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="13475700"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:29:40 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 14:29:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 14:29:39 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 14:29:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjhWDdU5dHFu7fky9scvO6Db8eEGjB+RnauKbYmRLx3gIcz7N0cjEWEawhTaxbhz/f5oWbrMCV1v9yTaCvX2a+TYLu+Pz099XrQC/VKUrmErOgKCk8k1tuAkK7aOh2KwGU1bPatk5FO+Z/8lVX38x1ZmrxmMPr/MBYwolRJCGSw1hXRpufiEnMCCHG16u5IW2cCV0tjh5n2l5XhJaF1SlBSCVPNbXLUR2T4GRRbhKXYdncOV5JYsIqpSC+uhNyt/s6vMeA4Rjxhcsijb0QNg+a9wjlGlgopq6FuB8iPG1JMNIynBGF0CiGtv0vN7AaVvWsMFz/Ib7jcZtLQSyS5Ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIBdspffYgQ4UFdwiux/xtk2t15pc3vU1vkHMB7E7do=;
 b=try8B953JnnegNxpawOUJSLD5CQTWwIBjG4xlUb6R4aJLW7KB1NkhXhcuSuBnnRn3Xz9UBoMEqei3wn9UUv0NjJv5zz71pxCiuHKrmN+lzcaXIWOVxUs4FsxHrhTaBI3baaOGaFHcD6O8ZrImX61lrWCah4jTsQmsuGCd4Q9PtuQuu/qQYSpezvWOqvRyH22TyLmlQe5EY4Y7EiOIU08pNLzj+kukSoGeEAKhbT+FT8tPU+zxacRgm8oxZ7G0iF+TsPMIa3kCjQFQxz3+/noBzFm67G3zrmY69OTubEvApPMILu3Ry9E2eB/Hr7FsJ0yRs/HqcVCUoyLCkJNsjbX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIBdspffYgQ4UFdwiux/xtk2t15pc3vU1vkHMB7E7do=;
 b=WmnaBxBIv8PgTZAdmAk6HTclU2bnqboFpgBgf47haJotNsgdJw6b6zxHCDrdUfW4XmG/JroUDFeSyhyKBFMhxgwoghSA87XomYDY+RukiMTuOKFvoVCvmNcRM/gC1LJshHlv0H2ROQce9atr8GsRwOGuRXA3SDVLA1P0Rn5wy4s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 22:29:36 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 22:29:36 +0000
Date: Tue, 24 Nov 2026 14:29:34 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <sanjay.kumar.yadav@intel.com>,
 <tejas.upadhyay@intel.com>, <daniel.charles@intel.com>
Subject: Re: [PATCH v3 0/3] drm/xe: Fix VM teardown and migration queue
 recovery
Message-ID: <awYPzpyv1A7siSAD@gsse-cloud1.jf.intel.com>
References: <20261116062804.1242511-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116062804.1242511-1-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e761001-72ed-4521-6d60-08df4a7a6bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261009223027099003|18002099003|22082099003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 4/lN+qOohRg8I99zOsn46xIbL6hTf+UWhKsY7VJnA9Y4pxGm7bOV63Amk1ABWdixW5pzcHa9WwJRz/01Ln01TG97D+beNphP/iHfCOTDI4q86fMEbKEchf0XMAVE3Pv11i8JcU1VzF+3jDcZ6tfpfXAHuEs69phDN/GBgRNxFCw/TuHXwuXpG2847QUt3ZsDv292FSKyQ5e6RVr4/GHkmKG5HdcU2WeWRed4r0VPlYY3xTg5JJVmLdcMQTYthzBm0Bn7fFQiy+JL7Ocz4AkzCsQ2inKbuQHfjlHrynCLqTdTljQ09L+L/IL3dDwo9Pd381Eo70O62eGAIN5COtAsn/z0OYdEOAF0A1M1tUfqFx+mQoevo1Qw7Jg7aXIaTU8+IfDXtpwChj5jXJeM2H1Q7K0pZondVITSOKG2h4AJGj7lhLjf5vX0blK5Nf/00jy2igseqtNsbMf6x+Wasr7/M6AJTP0mOMJXHs4rGCeKyXxaHsvGjO07ge81/ZQ/CuetFFHKewO/GBcbSUwJj6RWSQeXmTwbZWWXtyfIDUvE9MstlK2fgBhU9UQXSzk/I8nFlDabz38DqzibeXZtCqgIr91SewZThvuso0ECHpY1yts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261009223027099003)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?333qZfAh8c/R8qo2gvuAlq8Ce11FN+hKNzJv3ismscVeuuKD5R2Fn6vQABbu?=
 =?us-ascii?Q?KO8bFJLnICsFbjRZe84UMCGYmCtS4nQTnqgzRhSivGKLu/r2t7KydeJ7TgL+?=
 =?us-ascii?Q?zQ2m2Bjupc19IxlAjY+6XyjErGWZtjPvVr91SCQymT5S/KLrM9fqJAxtLWaT?=
 =?us-ascii?Q?uIhUVl79cXkRO+i3HTMiNYIsrbj/SMVV+QWcvcgvhCWHJNebzHKDSZilaPjj?=
 =?us-ascii?Q?yoC9VeanTnF26DF3OLYp4KnTcALw0W7ux/+qL/C9aNshBOx9DbfGnU9yqqgP?=
 =?us-ascii?Q?9GuXE5LK8oAHyHOhtU5hRC26PBiqgpf69j0JrMWfonqPBB/JseV35MPfKt4K?=
 =?us-ascii?Q?/any/cOMzQCfI3ZRV9WFYm18DoR51eskSiMpk3Hdc08JRjhQhb/YdMYYVEXL?=
 =?us-ascii?Q?Jj6Sr2vYtorNeOujXPrvfj8qFFG556C7EYzjmB8P/hMt3Dni+2W6anIWI+9L?=
 =?us-ascii?Q?pKbbU6Ftwy76JIxS3u8pla6/ipI7u5ENplrEzxa9tnL7/UEpVssfQi38KSZl?=
 =?us-ascii?Q?KigXvWv8AX2CBNv70e34dhvBV6Dy/lJSjXK7kGL3HpaW3uR41q9yVh+rdUqK?=
 =?us-ascii?Q?WzVXO+IMDDtyisxz2BdFwGD/xE17JRFU/lUcJJaIo/C81YosAwnMtQjgNptS?=
 =?us-ascii?Q?DJk4vhosWXnERYLiUdMhcDyeom/so2UlWR34wW2JBTfec/UWb3m/pSRtCvNe?=
 =?us-ascii?Q?tjX3Z+AEr/xeSC2bxYUacbIM2W9lqjayg1b+VKRdjCN2zythOJgyb4oycCcg?=
 =?us-ascii?Q?3UhNq3QwCqu9sf1CPtahkI/U01oGXJaTTeSrKnXxoitlPgNp7/614ZsOUR1q?=
 =?us-ascii?Q?1uKsVG4TJFvJ4wy00bfFO9Qe2xzG4pQMWTNbh/RuwWSIbRPLdZ17vPdHMRsV?=
 =?us-ascii?Q?hlqrS/HXjp0jeb8ZU0/nz7WcN8Q/1Vb9aAlSvqmq6TNQSs6qYR2UGz/9KGcb?=
 =?us-ascii?Q?TpX7jGho/IHtQJFmK+1ZA23J9P/P9vLmxKzkqLixb94t+z/e1SvER2671auc?=
 =?us-ascii?Q?9wA782lnXeodcJ/ek7ePODxRl0EWoK9I7JjFiz6sRg6o51B7IUSeQLihMCaY?=
 =?us-ascii?Q?pwGWgeeQXb8u51kzjlviCKNQiCOM0T46scZckWfTKVYpysG+doTCoacpRsKi?=
 =?us-ascii?Q?cvNKycFDICEmAmlQYaj4ywwa6ESDBmJYB6dyvUKBwxiEhPkKFcp5ffzfUwQn?=
 =?us-ascii?Q?OL4W0/TsrqiuhOh5UjcnT5Kd8xWeOK9RPjvwmg1WhcZwIGRQ3kbSKmGLGzHI?=
 =?us-ascii?Q?xxhyYtPSdDrdRcqEl42XriuHZBQMGaURoBJ3uLAI4+vX9lMf3/jzE3xfcjU3?=
 =?us-ascii?Q?VWYYfJTosTq1wE4DrOEmW6FG27LudLoKK8/rpD/BAn8SUvhlRbNhoQIKb9UE?=
 =?us-ascii?Q?7mzW+hFTc1R/wsjb6UWUr+jF3psHfwhkCID7m4k378bmM2FJrtWSQj6wjH7U?=
 =?us-ascii?Q?GvIIz0xieELV/Mlq5PH9WIVCfPUcqJSDaN1gYp3lnpljfHW9VAgw4CyytFD4?=
 =?us-ascii?Q?N5QqK9Xm/CpmOaXOox1cePr5i0SpjFzAIphEcAW6NWLM1HSoNACTJ46sV6ew?=
 =?us-ascii?Q?9UEoduknJZ3vvuUOQ+fO4oUdMeBNWHJDq5gatE3zxqsid9XgI+9o0m8EeAE1?=
 =?us-ascii?Q?noatBVmkKYJ5jM7mw5kWSH5xF8WYP9liduIlvJMkyGGB4WOvt1GmjP8CpUZD?=
 =?us-ascii?Q?oxktIL/mzhUTsX5Tb8+OYSSFJ/H66+71/MOK4Fy7OELUZxMoq/tj21LUYztx?=
 =?us-ascii?Q?of5G5/zIt3xvQCme3wgi1Av/oBokCgU=3D?=
X-Exchange-RoutingPolicyChecked: AYwH6JkGk8V6EjvfwWnOFVAGfDsIMXw5HtnOBaSefxKjL3Rz9twsFs2jC6VB5tolxAN96AgCJQvoBleEaE9q6xoL56BzABjDhqG5hIoTgHaY32tX8P92FW7hXIOjUZOcZpG7lIYJl6700sTng/5zUI+C2da9iRV3Vg9MoxtTq7O4sNm38cx1fD5rJ/B1XrjY3IH3ypRz6YVhqCnke5qYP9u024dq9BMGhkcCn8XGsjcA3TXClUk/wuT7Z2+75e1H5Uv2io5opPObWuLiA53jiLUaX+UGsDIFu7e+MhffOgQnGYaKfdxHr9XI1Ew+0I4z8bYwxLAPIUjCkJV0jnCknQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e761001-72ed-4521-6d60-08df4a7a6bad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 22:29:36.4960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLuW85v88sXiqNVhO0LEaNDrce+q1zM5iWceNCAYOVErSFCz9TOe08FFm5LStV/Yc67/nK4xrdPnYMQqPSAQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
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

On Mon, Nov 16, 2026 at 11:58:01AM +0530, Arvind Yadav wrote:
> Exec queue destruction is asynchronous, and user queues can outlive
> the VM handle. Closing the VM before those queues finish cleanup can
> remove mappings that are still in use.
> 
> This series marks the VM as closing to reject new work, then keeps
> its mappings until the tracked queues are freed. It also holds a
> device reference across final VM destruction.
> 
> File close keeps the existing synchronous scheduling-disable wait.
> There is no additional wait for the queue count to reach zero.
> If tracked queues remain, VM close is deferred until their cleanup
> completes.
> 
> User bind jobs are allowed to drain during file close and queue
> destroy. The VM-owned bind queue is not counted and remains alive
> until xe_vm_close() has waited for pending BOOKKEEP fences.
> 
> This series is based on the FD close cleanup changes in [1].
> 
> [1] https://patchwork.freedesktop.org/series/175996/
> 
> Changes in v2:

Why is this series needed after [1]?

Sure a user can close a VM while queues are active but that is largely a
user space bug that I don't think we really need to worry about.

[1] is a FD close (ctrl-c, segfault, i.e., somewhat normal flows).

Matt 

> - Reduce the series to four patches following review.
> - Run deferred VM close and final VM destruction on the
>   module-lifetime destroy workqueue.
> - Use a shared queue-wait budget during file close and defer teardown
>   when queues remain.
> 
> Changes in v3:
> - Rebase on the "FD close cleanup for XE" series and reduce this series
>   to three patches.
> - Move the module-lifetime workqueue change into patch 1 to avoid
>   self-deadlock when the worker drops the last device reference.
> - Check VM state before acknowledging cached faults and hold vm->lock
>   through successful reply submission.
> - Preserve the original fault details for errors detected before
>   acknowledgment and report failed prefetches.
> - Reject exec requests on closing VMs before userptr pinning,
>   out-sync signaling and rebind.
> - Use zero wait on file close and document that internal bind queue
>   cleanup can also defer VM teardown.
> - Let user bind jobs drain in the exec queue destroy ioctl.
> - Count user bind queues under vm->lock before VM close can proceed.
> - Track whether a user bind queue owns a close count and balance it
>   during final queue destruction.
> - Make xe_vm_kill_bind_queues() static and remove the unused wait header.
> 
> Arvind Yadav (3):
>   drm/xe: Hold a device reference across deferred VM destruction
>   drm/xe: Mark VMs as closing before queue cleanup
>   drm/xe: Defer VM teardown until exec queue cleanup completes
> 
>  drivers/gpu/drm/xe/xe_device.c           |  26 ++-
>  drivers/gpu/drm/xe/xe_exec.c             |   9 ++
>  drivers/gpu/drm/xe/xe_exec_queue.c       |  39 ++++-
>  drivers/gpu/drm/xe/xe_exec_queue_types.h |  11 ++
>  drivers/gpu/drm/xe/xe_pagefault.c        |  87 +++++++++--
>  drivers/gpu/drm/xe/xe_svm.c              |   3 +-
>  drivers/gpu/drm/xe/xe_vm.c               | 191 ++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_vm.h               |  13 +-
>  drivers/gpu/drm/xe/xe_vm_types.h         |  17 ++
>  drivers/gpu/drm/xe/xe_wait_user_fence.c  |   5 +
>  10 files changed, 355 insertions(+), 46 deletions(-)
> 
> -- 
> 2.43.0
> 
