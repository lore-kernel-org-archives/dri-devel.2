Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30542C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7B510E4DE;
	Tue,  8 Sep 2026 20:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KMN+p+3p";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A2710E4DE;
 Tue,  8 Sep 2026 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788898587; x=1820434587;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=PB3ue5OgdJ56Ae+z6i7b0gwf9o9MgueuNCdv1V9U/UQ=;
 b=KMN+p+3pnLVvaJZfkpIvdUD2rdUEuMU7FNa7rUTU7Wz9canoBBR8XUQk
 CTuuYdMNDaZs28/2/gEq7JeXZSC1FKMZ12RI/KtLtnTSc8zxtE1SOC0hX
 ElXByTL9iRHuen2Dygg+qHa/1AbI8yt8P+vgYXkKSIIgfomF0ow1Wrlcm
 YaZcg6N3GFyTdanfbviL3Ii1Qq7wYQTM8cCnGLx8RssimF2QpXiA5ETSb
 ANkoNRZu2a1FCe1WmkFtDe4bCnIVQ4ymW7JR6GhzlWA245/aYMpFt0dXa
 V0l3y13hC3Mcar6ZGtDWeIOJ2jeo8mjvl+cpXeuSEJ6rgHpa001yFC3NW g==;
X-CSE-ConnectionGUID: jGcTBso9SUm5ZjnBNApWqw==
X-CSE-MsgGUID: sJ01vCi9TQS4Hzjg6eOb4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89518722"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89518722"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 13:16:27 -0700
X-CSE-ConnectionGUID: gxL/7oYfTO6kT/K4lCxzUw==
X-CSE-MsgGUID: XrqC2naeQPKTkpWIVnihKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="309361427"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 13:16:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 13:16:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 13:16:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 13:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZqi30ZMU1qCGDoDEk5FDqkELdzFQkMbY9vjwPEDy/KHuxrvEw2sIH4UrA2rD9wbp72Tvsm4EaXWl87qMQkVfoK20J3Nea97Hzt8JKQOMRfrp8G5c0Iqa7O5C2d3Xozpx5qZ67/Y+PuhwAFsNu0rZW9zFNLBx6Dvou1V+6XgQTkQHhh53zIsdqTU+kX06TZkw1JRqWlZVcrph6mOXlvxEUHvSoI2CNwTcrzfjBiAAOvvZO+UGeIcNrkvd4/OiMxXAqM8g6MtGDKoI9AixapqEc1Fk/qGdR+6rJ69gwmK3+3THGuC9f8tXPRjZTr96sFfcnsl7g+QJKUqaqo8vERo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr8uvdqDzi8wWcA27K5q7CcikEGZtsv7z24RwQP9XVw=;
 b=jGbuDxfW2EKJlU86OxQuBXT7ae5g2Re7HRm20X41LJYHAlYGz1IjInsP3nmFRcSWioz89VNApZA6OQnJyUlTg3vjagvZtiIUV9FW7SMmIWvDEbOgAeF5nakXOWhOjQ9CcimFa2rAIOd8vHtVwKqzKyJy/cnlmmvtXgA/kWdeJqaUERSVLbCVe7ljuk4cfsCOr0C4BfhUK19UuprQliRZSiFFQDdXBFo2HMWB4UtFi6c6aca3n0mVBHq47Y4YZOVcHZVpF8XF5BZyGP/CR826z9oGvFBmCqOK7agdRF2RJKsVuApFH/UKap1moS3c4kRLaVbqOCV0niqmFbMjlLLIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA3PR11MB8967.namprd11.prod.outlook.com (2603:10b6:208:574::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 20:16:22 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:16:22 +0000
Date: Tue, 8 Sep 2026 13:16:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v8 1/3] drm: Add drm_work_fence helper
Message-ID: <aqBtFDnjT4HwM+12@gsse-cloud1.jf.intel.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-2-srinivasan.shanmugam@amd.com>
 <20260908085840.57CFB1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908085840.57CFB1F00A3D@smtp.kernel.org>
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA3PR11MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4187d6-4149-4c4c-4b34-08df0de60d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ji4hv0cz98L2tJhj4QVWI1Fh578O1ESjg9kUn5K8XtYmXxNyQsmM3iU5BUrN4Otp5k1CRHL8X9Rfou0Qy0VCoURXK40uBqO/jcO6ExuvrG3X0Xt4Wh+BIjuLRpXYYaH1LZgc9TEmcKbq+uOrNikSczSbA1mVyESabN0xYL8udRH8ZhueJPurIFbNG/qwEdNFv8sY12hDF9RSfHHxAn3UcydFDWmKdyIEHhpYJKuwr3NkmD3du12ihAKvZWHEujBvZQmXIC9BpM3cUnAHqMMgzH+N7wCZ3Jk6g9rZJmYHHB5tnyBQXnpBBotdnVQ9O9ZAvgdWFzXZdMY+Vi1+Viw5GX283tjGVlnvNycY75FGrYA/scdesCXcbR89n9x/RF26xqdHHS9N3eiCygV+DmRCfZvEmmFx7QsBs5HYJuD/DVLkrdQp0/HbAwfKBH5qY5RhsB/78zkbjCY6SEtKrfQixKc3wbofsPH0MjUGpZLNy19RvRfyEdKGPVHBAqqKqnyrANP+6OWOBHrK6alnNUummnvEPzyt6ItTDZYvz64EZ1RoELxoO8fHU6UHBBdzZOEtTFwe3uV0vKEl4k4tVkAIQ1WHkgy7D1u7ZohZ4EQXlD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWd1bmRzekk5U1NnN2diSzdwRWdwWTVjZzJGLzV6ZitVakIxdlpKTnZlZ2pZ?=
 =?utf-8?B?WkRzWlJodXl5bWhMblRZQnhCaUNzemxESmI4dW1WNER0Ui9TZmJ4cWdtRDJF?=
 =?utf-8?B?TGF4bzd6d0tzZXRuU0pzUGV5Zk03VGNoQ21ERTJicWtlV0UweWQyWlV2bFNt?=
 =?utf-8?B?ZkZrN2hkRjRDOHMyTjNzMjVLQi9VcSs1aUg3RzZLZWVXUWhSK013azdHSVAy?=
 =?utf-8?B?dzl3RDRNR1BvblpHY3ptYnptQ0pHMUQzWWxBK0llMUNSWGJBNHJ4TUxYNlNU?=
 =?utf-8?B?VjhWMzNUa2dxYXB1ZS9WcVgyVnprakgrUi9oNnRCYlZUd0piSlY1c0pVYVNo?=
 =?utf-8?B?QjI1NDZBZitaaGl0Q0p4ZGkvZkhENVdLODFVNU4wSDlYNkNycWk3d3o0MzZp?=
 =?utf-8?B?TkF5a2dFcU5NalRCemI0THc4SVMyQXRldXU1dXNkNm5hOXBKdUlBcVlXMlhC?=
 =?utf-8?B?c0hJLzlKM1M5Smt3VmJFbDEwNHREVTQzWjVrWHA3SDU0K2NocUtxREFIWGRR?=
 =?utf-8?B?VGd3M3ozU2xhRW1nbVNJOUNCQm1OcUxvekdiRnZzVHRkQjJVQW5KRURGemw2?=
 =?utf-8?B?TW9RYlFIVlJ1Zkp5b25jSmFUWDRQZkJ1WmtreGVBN0lhQ0VmTTdJTndDZEdm?=
 =?utf-8?B?YWZMZVZrVzFZOWM5TUtQOVBFL2tZT0kzSlFXd0M2NGpMM3BralFSdGlHMVpv?=
 =?utf-8?B?YnBmTFB1WU41d3lyc1JBQ0cxRDV0dFdoYU0xTWVZcm9YN1dzbzBQMzFWc01m?=
 =?utf-8?B?ZDd0TlBCdmVNcC9uTmJvNzhray9jeEFNbmxaNWJrSEo1V3FOK29hdmN2dkZi?=
 =?utf-8?B?UHRPaDd1REhFSHc5Q1lhRnQwbktJMnRmTmFQU2FJWE1WMEMyMVJSQWtrTXFL?=
 =?utf-8?B?d1c4RERYWGV5RmxuOW1hUS9wT3pxNElldSswcjFkVzhENkdNRFNYTEt2Vm1V?=
 =?utf-8?B?SHZjd1FQVWY4b1JFVkcrS1lZMjdDWkhTdSthMGpHcmlLUDdYWGNlb3NUY3Yr?=
 =?utf-8?B?Y295a292Mk5GWk4xWW9XdzNWZ2w2L0p6NTM5dEVvNHlrZHFRa1k4VFUzdXVj?=
 =?utf-8?B?a0JINEh6Sm1oNTdaZUZHbUROTTNrcGZhbkRXZWVOVzE3N2ZDNkEyK29uVnRV?=
 =?utf-8?B?M2pQNEpuN2FGenNScHNNMmZ1TEw4cHRWaXVtMnREY3htYmNyL1F1Q2l3REVW?=
 =?utf-8?B?MFhYMHlkMnd4TjZYMjd6UlNtdXZVa3BtTGlVZUx0QUZ5a2xrU0d1aWtoQ3ZY?=
 =?utf-8?B?bXBJamZvek5SUnZVTUpnOFBubGViQkNuaXFKdXAwVDkxU3FGMHNCOUtCdjdP?=
 =?utf-8?B?RzZmUmp4N3NWc2ZkTGtCMWN3Q2s2NTBSblVqZitnZFNEQlhWRTgxSnludzQ5?=
 =?utf-8?B?SGk0ZmIwM05GUXp4bkQyUjNjUGZDMnBzelZ5aUdvTThUT3RBOGpQVkFqKytw?=
 =?utf-8?B?OGRyVnNSWDZMTE9YV2NYWmpvRUFrZnMva1k5YytNY05sUVBiMEc2WWtyQ1pL?=
 =?utf-8?B?RkQ5ZlFrUy8yREVabXRhYzVIMUE1a2tqYkY2d0I5S3dvejBROElrak9CU1o5?=
 =?utf-8?B?N2R4L1gzeXNHZ1RaN1BpOUNqSkhsZEhlOFljZEJKbk1qV0t0SmdtNjVNbGF3?=
 =?utf-8?B?MWNYNXVzVzBmQytFQWgvQjM1TEcrM0tOSFVNb2Nzd3NsM3l1TzJ0R2Nmc01O?=
 =?utf-8?B?VXFaeVIvOWJWU01HS0F5RmNzWnIwUU93SGk1Y0g5Tkppdjd3bm5IeXpNNDdy?=
 =?utf-8?B?QlNra1RZMEVEYnpyTkFBelVJSUxxRVB0TkJBRHZKVHBOejNIcjNydVhRSmk3?=
 =?utf-8?B?YWhRYlhDZUFXcWNNbFJ1VzJPUS9JVTJ1M3dCb2c4OUx4MFB6RWVTUjVlSUtk?=
 =?utf-8?B?U3R4RkhnZGpUcFpWallsaW1rK0dqRXg0LzZObWpocUpCUG9LL1lDRFJzWG5K?=
 =?utf-8?B?cWd4cTc3VGFsQkRYcFBNNWVJVnVvajFMc0c5eUVqeEtWRTc3N0JXeGtaY3lC?=
 =?utf-8?B?cnNPdHZuN2NCcVRoNjI5RFFmQ1B3TVJLcDdyMjFIWU5IWmREbDMrVFFTQTRl?=
 =?utf-8?B?aHZ6cm0vZjhUN0wrVmk4U0FzeW91c2ZvaFhXYllSL3hobVpta1JhZjh2aDFS?=
 =?utf-8?B?MGM0anJqT2ZFRkIzQmlWVVVkZUVIZ1pDaHNnRS9jZnlkTk9UNmpUbUlHVTJH?=
 =?utf-8?B?S2c3RE9acWM4WFFiMHFxclVaUGV0N1hORE5BdlNPSjBNK3B5MXM2VVhlK1V3?=
 =?utf-8?B?TGdrck4vVzF4YzVORjdadFV6dG50dEVWVEdOa2ZtbmorK1lCWmhOUUp5ZHkx?=
 =?utf-8?B?RUR6OEhWTWU0ZVcrRS94U3BoZDJNMWQ4MzFOU2Zlby9OUnEzeU00ZTUxUi8w?=
 =?utf-8?Q?V7EOG35j9m9cDomM=3D?=
X-Exchange-RoutingPolicyChecked: swN8N/A6+Va5IBYQrdxppf2+ma45XDBcMKUdfQVBG87Yl2dnpCGzmUJE6mf5AyPBlglZ/XCaPz+xvjjazVXIf+o0BRSFZKREobfw9Q9p6NgRPEy6rHo8iLlpmDp3FZ3Za8ZCTdueZsddPXUx2zZtWdK0JRWwnj48+tOJqVXj0ObfVaEFqL4wzWHWtVZ0WkcYYilesoH/2+Rs8GucFJwEhM72m0n1XqoTa+ndFNSXmGWlnGGrblg24yGKKApX5noCzuQC5DKN4XgPM7WKqh1z4EoGbgFD0JB1V73oONoW4x5tivFurXjs9ZUpcPZ1F9xm0tW0IwOpWBYqVbsbBpWlEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4187d6-4149-4c4c-4b34-08df0de60d43
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:16:22.7607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c39gpeQlfXVejFCAOPNrGr46hGSGkYmj8u5qQKnoyyg0cGVECJqu4KVWjC+er2jaD9vBrFoYzhReavps+GQC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8967
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

On Tue, Sep 08, 2026 at 08:58:39AM +0000, sashiko-bot@kernel.org wrote:

All of this looks right. So I believe the solution is:

- s/cancel_work_/disable_work_
- In drm_work_fence_queue if queue_work returns false, call drm_work_fence_put()

Matt

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Race conditions in dma-fence signaling and callback addition allow deferred work to be queued after cancellation completes, leading to Use-After-Free.
> --
> 
> commit 43b8d6b8cd3ff463894478af19fe890e4879d181
> Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Subject: drm: Add drm_work_fence helper
> 
> GPU drivers often need to queue work when a dma-fence signals
> because certain operations (copy_to_user, eventfd_signal, memory
> allocation) cannot run in IRQ context. This helper handles the
> dma-fence-callback-to-workqueue pattern.
> 
> > diff --git a/drivers/gpu/drm/drm_work_fence.c b/drivers/gpu/drm/drm_work_fence.c
> > index 0000000000000..ac66ba129ffff
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_work_fence.c
> [ ... ]
> > +static void drm_work_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
> > +{
> > +	struct drm_work_fence *wfence =
> > +		container_of(cb, struct drm_work_fence, cb);
> > +
> > +	drm_work_fence_queue(wfence);
> > +	/* Single ref: wfence->fence released in drm_work_fence_destroy(). */
> > +}
> 
> [Severity: Critical]
> Does this callback execution leave a race window?
> 
> The callback in drm_work_fence_cb() executes asynchronously. Between its
> execution and the call to queue_work(), there appears to be no state indicating
> to cancel_work_sync() that the work is active.
> 
> [ ... ]
> > +int drm_work_fence_add_callback(struct drm_work_fence *wfence,
> > +				struct dma_fence *fence)
> > +{
> > +	int err;
> > +
> > +	drm_work_fence_get(wfence);
> > +	wfence->fence = fence;	/* transfer caller's ref — single ref, no get */
> > +
> > +	err = dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
> > +	if (err == -ENOENT) {
> > +		drm_work_fence_queue(wfence);
> > +		err = 0;
> 
> [Severity: Critical]
> Does this -ENOENT fast path also contain the same race window?
> 
> If drm_work_fence_cancel_sync() is called by a teardown thread just before
> drm_work_fence_queue() is executed here, it seems cancel_work_sync() could
> fail to wait for the work to finish.
> 
> [ ... ]
> > +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
> > +{
> > +	if (drm_work_fence_cancel(wfence))
> > +		return;
> > +	if (cancel_work_sync(&wfence->work))
> > +		drm_work_fence_put(wfence);
> > +}
> 
> [Severity: Critical]
> Could this logic lead to a use-after-free regression during teardown?
> 
> This function seems to assume that if the callback is not in the list, either
> the work is already pending/running, or the work has finished. It appears to
> ignore the window where the work is about to be queued but is not yet pending.
> 
> Can this sequence occur when an unprivileged userspace application concurrently
> signals a fence and destroys the context?
> 
> CPU1 (signaling thread or -ENOENT path)
> Removes callback from the list, then executes drm_work_fence_cb() but is
> preempted before calling queue_work().
> 
> CPU2 (teardown thread) sees this in drm_work_fence_cancel_sync():
>     if (drm_work_fence_cancel(wfence))
>         // Returns false because callback is not in the list
> 
>     if (cancel_work_sync(&wfence->work))
>         // Returns false immediately because work hasn't been queued yet
> 
> Function returns, allowing the driver to tear down resources.
> 
> CPU1 resumes:
> Calls queue_work(), and the worker executes, accessing the freed driver
> resources.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908084627.352535-1-srinivasan.shanmugam@amd.com?part=1
