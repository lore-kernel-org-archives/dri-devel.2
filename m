Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55312C982DE
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 03:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1266010E02D;
	Sat, 19 Sep 2026 03:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m0/ZQ5oO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3BC10E4BC
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 03:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789788582; x=1821324582;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qbYYpuvaYZd2LG46CDvItQVm5OyWUNC855eyHhV0AgY=;
 b=m0/ZQ5oONVAy8AUbU23oGDBjrn7EyejDgiSgjiKGPk/KfcK7eTsUywU3
 7FlPCSGYRluQwZiOBAZC+QtI4E8FodnPvKjYy7ySevOFqxcJwDz591M+W
 25F3cQ0Ht5U6qjDmZjegOrUaBrMMLJNL9KZlVG1GL/bee1J2976LSAqNL
 Vnlex5hx7VBPYdTfESqis4ReMGsOLEfOz0oxn4FzNYUnQ9bviHkz/w1fd
 udV15FoSStbDRI6pQy7uVHss8rZqp0JZ6EGh1w7Hs0zhkodgTI6TtLUhR
 oiSZETsyJ0iCjxEvvrFLvFZFlBmNFxuDf/QJAGE5Pc5l4OfRKKP+uPZpc A==;
X-CSE-ConnectionGUID: gezb4JLFQt+IoRFd321csQ==
X-CSE-MsgGUID: eP01YOUhRya84v655QuLWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="825345"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="825345"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 20:29:41 -0700
X-CSE-ConnectionGUID: wZxWykLTSju1MzKxf08pqA==
X-CSE-MsgGUID: MpGG5BVrSJGIEk09X4zqHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="299776845"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 20:29:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 20:29:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 20:29:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 20:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPahSaq1Ju7RhU1Zez3saEhpNWbVNqGlknvZr1DGm5CzzlqIlCH47PTA2nsxi24GpuY0WylCM1v8hVr3oW73l3mwFc+rVLjr8NmeEmEYOj1HWprz8XkUQF2avrVIixUXidQVx9eIjAQvtfuNMWD9nhKXZHQma1ZfBzGburxBXOFieiq3RjQMpDQGGdGBYTBz11+yrlhuQiB3fIqwcRLhtVSPkNhgnf39rebNfx9RB5UouNw0rTs0EFRSQMXRMZ4cr22FiO5eBrOH7ko7TrzFmdXkO0FenE5Gg4fBnsxAbqplfNz52blLLbVTGofp2Be5QTm59P7W7R87XhFmYi8O7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCE3f9D7wAbgB2oFIcI+tcZBI3fsRabet+APm+/7O7k=;
 b=rjvrROcscYXbmJPTre0iFS/DMvfvR3yzDoRuPMNdhYfc4Y51J3qXBMhFP+FZ5QPUEej+yU1d/Eggk5dWr1ETHmkcvmh7xFGzz5UQSkUp2IvxorL4Ce/A+aIPLM09nI06dz7dlIOAW09lEocWzdZzdnoQ5liSYmNkoljH27z4LlU1OCHDQGaMRAIS3B0RIHzQisGyWK24lQJDDALXD0JE5rSePmtJoywBY/i4Yf1HGcwtAIbittbhX9jjlfA7w+cv4ZKUUXptfuPTRowU3ri/qenQISZ0Y8oXoQndW3NrqXCQZ7QxhD4Eg3QGJV/U6cr9iOctWoVhMzEfVmKdhC072Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 03:29:38 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::942f:90a0:fade:3848]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::942f:90a0:fade:3848%4]) with mapi id 15.21.0406.007; Sat, 19 Sep 2026
 03:29:38 +0000
Message-ID: <8cbe67b5-76e2-4984-a147-9b2739ebf881@intel.com>
Date: Sat, 19 Sep 2026 08:59:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/pagemap: Prevent CPU stalls during unbounded
 pagemap teardown
To: Matthew Brost <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <arvind.yadav@intel.com>, <himal.prasad.ghimiray@intel.com>
References: <20260918081320.30389-2-varun.gupta@intel.com>
 <aq23+Efl++F++ako@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Gupta, Varun" <varun.gupta@intel.com>
In-Reply-To: <aq23+Efl++F++ako@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::10) To BL1PR11MB5366.namprd11.prod.outlook.com
 (2603:10b6:208:31c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5366:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: e611be4c-a42b-4e48-84ef-08df15fe3ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 87Twzzw+JhmApnb6EB3XumO4qX73WcoiUE4lRcdsvDOgSbX04z5aSS0ep3kyWSZ260I7WRzg+Fo7QpWTJyq1SKIKqSs0+T6I0LZjbZzMeiINmI/OJEWAlegJT8khT1IOGA0kDMw6YgMrkUnRiStLvk86KDhFLrcpYgNaWYeYXCMdsWXwMUEas6VYmaQhScjb0+WHZ6fKpbbkVi401w5i6CRx44oDtcrGJG9BYOJrnG1pZl4nGwgbCQSviJlz5fSnf49gWmqb9J2vXUSxMZ2p+p3BYBYuuChImGQFnydTowk+NLCwinQRZo/CJTx3tvgBAzBdta1WBqez1EEUVw/WPxwjQ2SW1SGNRdThORPHMPGXi4aekDlJbzv6O4lz5LOP1B/EE86z9ohvdHZs5Nub6hDD4XGv5UVMiNc4DitB97mmTlY99TuPXzK6ueuF+aLZth6OKpfan9ufOtNb114GPxv1slK2cGruWT6Mi36mYjDexpyLsVHLXMbiOCaiNWlrRFKVbfGDQUYfxCn7/ES/yL779l89HOKg+cbHM3Rk3juCdOg3hEfXPpB4pI9ovCRLEW3teq9wTuyU/3eR4tRkgTRbr1U+QkZBDN3eZ660Ef1zWSg5a3e8kR5+vCgPMFIm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFwTHR3Szg4T0piK3FxbDFDVitXSUYxY3M4MEpkeG5wOTlYbFYwcnE2eDEz?=
 =?utf-8?B?dElCalAwWFo2Qk1Zc0NvTlk1UjB6NWl1OHAzOU5yTzJJeEdQVUZwWGhtMnVi?=
 =?utf-8?B?R0VVK05wYVY4VE5rQmpZOTFnZ05MallxUW91TVh0MnRNS2hzUHkybHhkSmFa?=
 =?utf-8?B?czNucjQraHhVNnF6c1gyRENQd0NSQXpTTWc4K2lFNUtSRGxQK0R5RmRWQXo3?=
 =?utf-8?B?QVNMcmhsblovUUxVZi9qUURpWWhPQzhzOVJkVC80MnBuZHA3UjJlWWJqY0xw?=
 =?utf-8?B?NytRdmUrZGlhV1lzcytLbUs4NTZUemlqQ3EwbUpEaVprTGlwUlhaTnFXbUxn?=
 =?utf-8?B?djZqU2JjdE1EWGFQR05XcTRWeFJJM3Z1TjhkRjZCTUc2bmlDOXdVUVVmWDlY?=
 =?utf-8?B?bzBPZ2V6Y2RnbGpEYkErVkJwOE5NRWxJdkxoMWcyVXhFcjZCSkxMNjc3SFBv?=
 =?utf-8?B?UHVVMmxlNHBQdWJNL1BKV0UzV3lWVUQyVHFGQXJnMUFSRG9Mb292Tzg4eFJL?=
 =?utf-8?B?b2t4NnFBd3dPTVMrRVpEZDFjMEZZRFNycm5IbEQvWW1DZ3BLVjdnbVozNHNv?=
 =?utf-8?B?ZFhoY3FJNEIyMEs4OFRkR0RqVUdwL0lXV3dwQXlMRDJ6TnljTC9FZ1lGTmNa?=
 =?utf-8?B?QmwwZU9zdEFFZWdRbjBYQ01teHl6WXFKTmx6UE5FSmluc2xVYy91T3NiTWtJ?=
 =?utf-8?B?RjBMeGhlbm40MXpVUVptbks0bys2b3VTR05ldTllRzRjR29QaXZxS3c0MnFB?=
 =?utf-8?B?WjB2cGNrOVl5M1BrNTQrZWwrR2dJbmNkRWY3akdTcmROSG04dkh1Mnc2MVVm?=
 =?utf-8?B?dkt3cE1TNkJWZHVNY2c4K2ZlNkc0K2sxb0Y5K2xuamIrK2RWSElFUjhjVzVU?=
 =?utf-8?B?ZzhzSUc4cnZoVm93cVcvSHd4NzNKTWdRT3ZHU1doWW9ubkZpTXArMnVhZlk5?=
 =?utf-8?B?c3FLY21RVGoreDJWUEY3VXpXMnlaL2hMbjRaWHd4NTVkMlVuMmk1Y2RPRDFI?=
 =?utf-8?B?YWg4Q1hVQ0RQUkpkQ3V2ZEV3QVM1dnVFVm44V3J1UkVIbXVCQSsxMFpNV2t4?=
 =?utf-8?B?TlhBSnhkK2NmeGpEdmRBa0N1VUs1UkZQMDR5VE1RdVRBR2tZOFFEOUtLQUxL?=
 =?utf-8?B?cUkxVlFxaEd4S1BncnRqaVlGYnRvQzUvU3NIUjB0YVFoUnBnay82SHo2UDVw?=
 =?utf-8?B?RVhwMUpBTFRyYmZOemdxUWh4VnY5Y091bUQ2VzlRYmhqVkFuVk9JRDlkb0Mz?=
 =?utf-8?B?YjQzK2NLMjVqVzBoSktPYThRd05Oc2FSTnlKM2d3UmpMdXR3WkdxbGlnNlNv?=
 =?utf-8?B?R2svak1LZ25wUlduTEJkTlVhYUV0aWFFNmM0QTkzWnNWajhVQW9YVjR2OXQ5?=
 =?utf-8?B?SVkrNzFvalJnaytBOEZMOTRwSktIdmZ1VExZRjFhUlVpV3dTM1dxTjdGajVZ?=
 =?utf-8?B?ZW1rM2JqbWRNVnhQVWtVR3FSRDNKekhMbXFkM2ZFaVpnMkgycEQ5WWw4OWFj?=
 =?utf-8?B?dGFvMVdGQ2wrSUpTOXhzK3JJVm92dHB2ajlKQkYySzJkMWpyVFd0TzRGdndq?=
 =?utf-8?B?N3JCQkpJMEkxeXZla0RQK0h6bUZLV3dkRkt3WWtudllkREJsZXBGWGNWWDNh?=
 =?utf-8?B?d2t3RzMxZkNRbEV6Wk1NMnpsK2JBS1pxYnJGYjQwdmJCZjRMaHM4dVJiY2ds?=
 =?utf-8?B?VlBXUDFVZmlxaFBOTHNDdlVzLzZqYU43ckoyOEVWMkwvZFF6WnNpbWwrc0ND?=
 =?utf-8?B?b2twcXVzWitXWFFXY1hrVkM3QVZ5bWxTc2g0VkpQN0d3dm91SkROQ1J2UVB6?=
 =?utf-8?B?eUFSYXJXdzYrNGw2Y1g5NmxhM09WMEpLcjBoK0Mrb3p4WERaYmlnVXRIdEVU?=
 =?utf-8?B?UnBXVEFVSkZHWW55WHV3RjMxZVlWRFJacmdOamZnSUROUHhqMVRyS3Ixdm8w?=
 =?utf-8?B?ZzFXTERVaUt3K2Z0ajFBZUYyVHB2RTJjUi9nbmhqeXc0RnlXaDVGNUMxMldl?=
 =?utf-8?B?d3FPbUZHNGVreG5ORkRmczJlZGtBS1hJcTMxWWZvMitvZW1UUUdCM2JyaHUr?=
 =?utf-8?B?dUk3c2xDZGk1QkxDK21wWjJFZWhQR3RtUjM2Y2lKbGJmN3ozci9QWWVTSzhO?=
 =?utf-8?B?L3R4VnhpSkRzNVkzUk5NMTFKWmFnTHNyYmc2TE16cDhaYmlNSUtDK2kyTmJi?=
 =?utf-8?B?dFVkdVU2SStpOVg1Z2llUnp1UTAzYU1iTUswTWJsVkw0UzBzcCtEdEtlOUtF?=
 =?utf-8?B?RUxzK1FQMVlpL0hDQkRkQnQzYkNKZkk4ZVAzUU9TN0pXazFqYVcxSTc0WCto?=
 =?utf-8?B?dkRhd2hGeThmaDVWR1RVM1pzN3d1czZnN2J5U1dWZGZ1RkExOENXUT09?=
X-Exchange-RoutingPolicyChecked: BOVzxchnL2o8+21pySVhrQx6GKJBKdhUT+QfR0Utet1UoKWEiNZeErOP5jRq3HPHB7bzZ+bMoQR1Y0/cVKjjmxKd96DgBLvaWwQP4wVAa1WlN7mGyKCr9TVe1lhueVNhQdZ2j7m+Uz6arcgosNmGw3Vis9GpJNx9LPffSefTDiMPCiudmYsiXCe515hAHcxYjXXuEsX8BFmWK2Q12H2ljjl0IOBTkIquOVx0C0gdkugVvmEiiWEBjgSVc4tUEqyUT4uPbYPA0TVzXhVPrK2BPOrL+zQoHR5/MILipKQ1KF7gD6E8gURoK/3YWeOhuj+jEfjn8msmp+bIUGC/qzebqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e611be4c-a42b-4e48-84ef-08df15fe3ba0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 03:29:38.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INCJ6AWs86izhPhMDhLaG81qEwO2+psqEi1tcbBqzUL7FUyFPshVq7HhngLRabDduTb9/5kCvGl0OOq3QFCJVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
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


On 19-Sep-26 3:45 AM, Matthew Brost wrote:
> On Fri, Sep 18, 2026 at 01:43:21PM +0530, Varun Gupta wrote:
>> drm_pagemap_dev_unhold_work() processes an unbatched llist of pagemaps
>> on the system workqueue. This creates potential latency traps during
>> heavy teardown cycles due to two compounding factors:
>>
>> 1. The loop contains a per-item drm_dbg() trace. If dynamic debug is
>> enabled on a slow serial console, synchronous print latency scales
>> linearly with the batch size and can block worker execution.
>> 2. The llist can accumulate large batches during intensive unmap
>> operations, monopolizing worker resources without yielding.
>>
>> This causes below log warning:
>> "workqueue: drm_pagemap_dev_unhold_work [drm_gpusvm_helper] hogged CPU
>> for >10000us 19 times, consider switching to WQ_UNBOUND"
>>
>> Fix this by implementing a latency mitigation strategy:
>> - Move the teardown work to system_unbound_wq to avoid tying up
>>    per-CPU bound worker pools.
>> - Add cond_resched() inside the teardown loop to yield the CPU during
>>    large batch teardowns, ensuring system responsiveness.
>> - Convert the drm_dbg() trace to drm_dbg_ratelimited() to mitigate
>>    serial console bottlenecks while preserving debuggability.
>>
>> v2:
>>    - Changed workqueue from deprecated system_unbound_wq to system_dfl_wq.
>>      (Arvind Yadav)
>>
>> Fixes: a26084328ac4 ("drm/pagemap, drm/xe: Manage drm_pagemap provider lifetimes")
>> Reviewed-by: Arvind Yadav <arvind.yadav@intel.com>
>> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> Did this patch break our CI [1] [2]? Varun can you take a look at a
> follow up or work with CI so this isn't flagged?
>
> Thanks,
> Matt
>
> [1] https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-174512v1/bat-bmg-2/igt@xe_exec_fault_mode@twice-basic.html
> [2] https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-174512v1/bat-bmg-vm/igt@xe_exec_system_allocator@many-execqueues-free.html
Thanks for pointing out Matt, will talk to someone from CI, if they 
cannot handle at their end,
I'll send a follow-up changing it back to drm_dbg.

Varun

>> ---
>>   drivers/gpu/drm/drm_pagemap.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
>> index 892b325fa99b..0867bfbde5c5 100644
>> --- a/drivers/gpu/drm/drm_pagemap.c
>> +++ b/drivers/gpu/drm/drm_pagemap.c
>> @@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
>>   	dpagemap->dev_hold = NULL;
>>   	drm_pagemap_shrinker_add(dpagemap);
>>   	llist_add(&dev_hold->link, &drm_pagemap_unhold_list);
>> -	schedule_work(&drm_pagemap_work);
>> +	queue_work(system_dfl_wq, &drm_pagemap_work);
>>   	/*
>>   	 * Here, either the provider device is still alive, since if called from
>>   	 * page_free(), the caller is holding a reference on the dev_pagemap,
>> @@ -1009,10 +1009,11 @@ static void drm_pagemap_dev_unhold_work(struct work_struct *work)
>>   		struct drm_device *drm = dev_hold->drm;
>>   		struct module *module = drm->driver->fops->owner;
>>   
>> -		drm_dbg(drm, "Releasing reference on provider device and module.\n");
>> +		drm_dbg_ratelimited(drm, "Releasing reference on provider device and module.\n");
>>   		drm_dev_put(drm);
>>   		module_put(module);
>>   		kfree(dev_hold);
>> +		cond_resched();
>>   	}
>>   }
>>   
>> -- 
>> 2.43.0
>>
