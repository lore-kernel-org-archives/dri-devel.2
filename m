Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0419BC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE6710F367;
	Thu, 10 Sep 2026 08:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZHU7WoDq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF8B10F366;
 Thu, 10 Sep 2026 08:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789028022; x=1820564022;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=xN0IoqmYhQHNdyXxWgQAsbYRC+eadzs9MmD2BnpeALQ=;
 b=ZHU7WoDqwyaHXqxf+SSBcM771S8HibhBQnBJn0HJiK8gR8PpZl31mXId
 E3lGdxJOEjpUjl31cTSScyuWRm7DR1rU+OjMY2RgOMUpCjSPXRvkJiNly
 6Z0GsgBYzhBuLixJS5ARV8Wy4nE/Qj8RMxZrYfFJy0nkX+XRmodChhDit
 DV8wzrE2ZsqY/1lcAPWinIe8wvgrolPHDPJp4aDZ8pTV2/drRD2goBByH
 uHWRNgaL7B9EiwAabSR5swkHZvFaPatJlIOQXwbtzIwwrX+QRncKnv0GO
 ZOMRtdGzeCu74f241Az3SsEBIlOc4RP21S3fsVWTkN6IXFxfQnmfoseAa w==;
X-CSE-ConnectionGUID: ZCtgeoIDT+2SEQD0ONpn1w==
X-CSE-MsgGUID: 2kiI2qKpRn2Z34u8lGY7Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106839781"
X-IronPort-AV: E=Sophos;i="6.27,271,1787036400"; d="scan'208";a="106839781"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 01:13:41 -0700
X-CSE-ConnectionGUID: FZ2caSYuS0KJDA8pxdOxKg==
X-CSE-MsgGUID: JM70i5cNTGiUXFoxIvoY2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,271,1787036400"; d="scan'208";a="275713229"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 01:13:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 01:13:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 01:13:40 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 01:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmm0EQ22jnEPizmA39YDcWFAQFKyU6Ek5Fe5UyNXqBHbefN7pi2h0ZIyvJPfiEHy8FOHYs8Q9/XCrvWCnXHOWI4sGxsTq9iMKy5NHQ0jsYjwfeNjX59XPdWXqVaxW/aQTC8xn7lFgV4DKcUNoEv05/VY8JwpPXdgB6qjTtylbXLz6akihpoXkfrUzBBOGTsmm1neu5QDqQzW3Tqq0Z05FZqugHL75uWtS6h1jiV/UfydqLAYDeoHalmoHYdn/j1+ou90g7RmVvOoLEiWRy8K/+x+hLIwA0oT5aXmqT8+LxiP0Ov9YhIs2ISIhc+hWa1Jn1Nd4XkT8iIAUcC8zFkiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2RUFGNADyMuGdrjseoM15iX06maqgTkbEUSAIhl+i8=;
 b=pGTO29RUVdMoBUt1XAi3i0bbfgTZmdNjGBAWXX+37W/S2/tzYqh6W0bLeHJzBrbre9eGJpf4L2N2tS29Lr8u7mIJXR49dFMAKX99Y4Q9z6I21wWJgouTfNdXC+ONLnNxLUuZepHvywHIPjAyCZbGoUSTzvR8lY9igFLF+BA9xYHxgUVGwIP0B6MKIEplUCunN22rABeZD9Oi8AYbGO1fNBemcIfFLfIFxt8a0ThQgIJ4u1jQaFuWKRHwSez6y75/phC+B+T+aqnu5bzQvCbBYbApIb1daHcpqwHEGDFYASfRVbQQxmdZkUCIsIIU/FtU9Dy3+nYDhBdECUFNsgereA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:13:38 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 08:13:37 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH] drm/i915/gt: Unmask interrupts only when ACTIVE is true
Date: Thu, 10 Sep 2026 08:13:29 +0000
Message-ID: <20260910081329.3300417-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::25) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 2514f5c7-fa46-40fe-2511-08df0f136a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 3j+0Dg58EUUpLf/4PwVJ7pxsjlT5Opsk2r7UA1biZ1Lt8SAblJsBMipCDTnhk+ABUnhT29j+rpbxlyES0KuVOmZTp21GJSx4U2OLLjQZxsoidQ8YAAyfSCfq871WrRzjForqhpwWbC/yFEJEdttTBwVQsJjmPsI2u4zBG7BC7OKo8zx6nHSGi7d3prAb5yHPPxZuwi5w9Zncs49Io78DwVTxo2FNK7O+MOx4zbYBPrfM4mhWnD/fjhepDQVwAlud0DGuLKBNeTp1mh0lvktMjVJUwyjfN8vgi8lkv3EOKFFbY5BpjqL/xlupNywiETb2bbbthb0/fQd4K/P0XNg6EufIgNIDGs8TDdQSQ5mbUbwzdOgk2XjyivZ8xRCjlvR23SkF7/BnrRRU0VAdDQXuTxVMiwdIOYABzdJC37FMBtoCXo3ES4lsGAw/vras7dgpEyeZ+HT/AF1NICe3jKKxk9iDJD/kRCnedQa5VUR6KZS1/3VrITPHPlVXMNZ3lf7kLuYIVa+W1Kv/gaG5UNvDltc8NcGbI0LzIhIWo8FkzAI2E+JeOYZwd+bLT8TfP8IOwR8pMcDcc9/Go5OS++fk21qcUOpX4mUT+h1367aVotSc1CG4N1A7hDMykWnPO5vF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LrRSxq5hKTygREeGXrzb56e2nJ1GL2Ve5wqT7/vY6hZ66ku8QcaClc8oLB5E?=
 =?us-ascii?Q?Zs0P2UnMJ4SLTJriIXw0IoqF4pLInwZokAnzQ9gJErr813HmjYQ4aVG0VX0P?=
 =?us-ascii?Q?75LA4eA1ePqr8D8N7C9k6VZsRjYzsuUDKVFVPORoVsMf2zeFAFJyAveMU1Yz?=
 =?us-ascii?Q?Y6xJYq6pWuavr2EXmdZowf3xPATjEBUGJcHkrKec/PF218HA2MAb1c5tSgve?=
 =?us-ascii?Q?2NFdYixzWNdKMgDGdvcjavEIdJTWZ7P69tLwk2rkims+wL5VMej9nkygcLIv?=
 =?us-ascii?Q?a+I2pGk2w3kKzuMhU5cctLTBy7Mj6xHMdFhqjRa3D/ljSce5ZpK0Pm/sZaZY?=
 =?us-ascii?Q?A6mXnFVzlS8KUpuVAhVlxdQrSwBIQk+aWjPkGaB4+0eJCgqhgavcyLIgJndH?=
 =?us-ascii?Q?rE9LdyPcTGg6NMUHmQFK+E6yPZvPXSm7U9bsy7Z2rgPYjBUqpmxOCEeDMIad?=
 =?us-ascii?Q?syPvZaC4RyhP9C2dbEh5zuMKCtuDxWSG/HlCK7aUklvtt0jYMginu3xRwRtd?=
 =?us-ascii?Q?vT5bt93d25/8OIaOC4o01QP5n33v1JkrHpBJiuNZD44jORjaFhPotvlMzJUD?=
 =?us-ascii?Q?7F1Z6Db3Pu1roRWji24zaD0QDa//JLSPvavrhVCecn6AWi1qSqE69qgXYXzM?=
 =?us-ascii?Q?N8PZCyHq+47ClkaAEIit4rnKQHY/2DWkVp8XEjuzw6UwVc5FzHepHPM2788A?=
 =?us-ascii?Q?oKYLdAB/pcpSNUh0d/ORZ9+bN+gr1YeIz0mKxTdJtcmaY72NlnZTAsRzcPVY?=
 =?us-ascii?Q?+ku9aj5PV+4P0eK1i+K7TvBvhlI64hvu/mNtT5h2cv/mOuzCY8Jh/yFhVpzi?=
 =?us-ascii?Q?B0PSyV4ZH//gLM4zLQS1TePN8T1YKal2JOEg6Aw7910sskUCbz9WMdCsT/hM?=
 =?us-ascii?Q?d7jckPytdPNa0E7V4GXfOSbTu/AaHk5EsFuQN5oJFY+nLirmBCvBmBxE8AVA?=
 =?us-ascii?Q?ufNuyciaLDYM1cTCz4iUZk2Fib2SYFm8ClZGdMgV7ZvCGrIdSa/q2xnJAAlN?=
 =?us-ascii?Q?RxVlPYIiF9BAJUHJlK8cL4+bbqUh1v1gv5d26Ysd8kiLDbRcWCTWZvuEp2yW?=
 =?us-ascii?Q?DeIHimP8J4RarOH1Sxvhx53uxWQexA74CmIania+DV6eXEK1VcL3SIZZUvtY?=
 =?us-ascii?Q?lKd1DbGHvZznG+JaRBQycsyAU6/AqRwsx63k2IQXg3DwCcHZoK38Ahcg1Pci?=
 =?us-ascii?Q?sqsxWJnuG+iqsNNDwwtydrNUIfgZj5HB+gi/pISXbxke89IX67Ll0MjX0b5d?=
 =?us-ascii?Q?VmeteJPEj55SBaZ+eRrTsXiWlZOBzFGTPYekkqckg6hhGoqT37aUnSrZGvRI?=
 =?us-ascii?Q?s1epeO8DWEPinuxhDGme1GZip3G62gwx7EtParsVyQHNe04Er/6vAOqIP+om?=
 =?us-ascii?Q?lnR+s0ObvnVT7YjYo6N1+OSTTBkgrAq2tuawSJNCqLetOlN71KCdXow1n9jy?=
 =?us-ascii?Q?6BDy9rSls/7fKfP0byjXrcn0e0o4sZZZ2Y+KnVStebXkkecSdDcj9+bwbiY/?=
 =?us-ascii?Q?37iOILE2vhZOJqn9/HB8ug7KxMinUFEpbSnhc/evUueetgsWyYiNYbowM5Fq?=
 =?us-ascii?Q?u+hFMrQQPgWRsfos9RYeAyDEiUsyS8jk19KnNJx4AblDfb+OwsIMbxApVmRF?=
 =?us-ascii?Q?J8K3sADXrD7y8fp5h1+fuqbR2OLTzUl6iFojAUIFxZo3QVoMfuWkoxZ+0vg2?=
 =?us-ascii?Q?03aOpobxhGWpMts1WNgxqmpv8vEcc6WPdWibQcFF/XkY7tE2FXY8u27cqJ9U?=
 =?us-ascii?Q?VVTiN8afBgRE7ZUTfmwW6HUm3SB0k2U=3D?=
X-Exchange-RoutingPolicyChecked: 3w+dqAOIx4hpDapf0eQH0sAl4fZjJQSNOcylahA3dIzouVcZieyETaiVdO19jucHLVkf6xrE0B9DuHWhZntMAyAHJNOAwI3YKgASdJd4KV62NW6K26UoNJPhf3DpXTi1REk2O8iVky9xISEkPmB1V1lL1cXIJf3/3dKDw55UV0xY2iv6SLrP1ITX4heJm4trXIrdCNWp2Hdqn/CsAD0QAWglx2KL+lWh+o7O3tIrmY+M/TT6711n1xpGLku2wNz19uSMt19UaSAlKc59bNdn1II+9yw5x2riFiUo8Hgdpvq3mmQunzrK8gJCnp5BqC63AR9CzRr0O0+FsaFPIdOo/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2514f5c7-fa46-40fe-2511-08df0f136a53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:13:37.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLKhZPFFubG6mfAKrq+d/at/PAW1ytEpfFoZzFs8Ql7To0CzM7lFCd9jGtUrg3I+mGwuAXO8io75CFJeY3jeXz8PVXl4U52j7rbNUYI6Nr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
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

There is a small race window between intel_rps_boost() reading
a stale ACTIVE state and queuing rps->work, where ACTIVE may be
changed via asynchronous calls triggered by wakeref drop.
This means that rps_work() could be triggered after the GT has
been parked, so unmasking RPS PM interrupts would happen without
holding PM wakelock. This sequence of events may be observed
during live_rc6_ctx_wa() selftest:

1) live_rc6_ctx_wa()
   -> intel_engine_pm_put()
      -> wakeref_put()

ASYNC1) wakeref_put() callback
          -> __engine_park()
             -> intel_gt_pm_put_async()
                -> intel_gt_pm_put_async_untracked()
                   -> intel_wakeref_put_async()

ASYNC2) wakeref_put_async() callback
          -> __gt_park()
             -> intel_rps_park()
                -> intel_rps_clear_active() [clear ACTIVE]
                WITH INTERRUPTS:
                -> rps_disable_interrupts()
                   -> cancel_work_sync(rps->work)
                   -> rps_reset_interrupts() [rps->pm_iir = 0]
                WITHOUT INTERRUPTS (TIMER mode):
                -> rps_stop_timer()
                   -> cancel_work_sync(rps->work)

2) live_rc6_ctx_wa()
   -> intel_gt_wait_for_idle()
      -> intel_gt_retire_requests_timeout()
         -> dma_fence_wait_timeout()
            -> ops->wait() [i915_fence_wait()]
               -> i915_request_wait_timeout()
                  -> intel_rps_boost()
                     -> intel_rps_is_active() [check ACTIVE]
                        [OPEN RACE WINDOW]
                     -> queue_work(rps->work)
         -> retire_requests()
            -> i915_request_retire()
               -> intel_rps_dec_waiters() [from 1 to 0]

If ASYNC1 and ASYNC2 would execute during [OPEN RACE WINDOW],
then:

3) rps_work() executes from the workqueue and may satisfy
   "(!pm_iir && !client_boost)" test (in TIMER mode rps->pm_iir
   is zeroed by an earlier rps_work() call or never gets a new
   value after previous intel_rps_unpark() event), so it jumps
   to "out" label, bypassing intel_rps_is_active() guard and
   executes gen6_gt_pm_unmask_irq();

4) GT is parked and runtime PM wakelock is dropped, so only
   a raw reference in __gt_park() ->
   intel_display_power_put_async() remains for 100ms, then the
   MMIO write in gen6_gt_pm_unmask_irq() detects missing
   wakelock via assert_rpm_wakelock_held() and emits
   "RPM wakelock ref not held during HW access" tainting kernel.

Commit 3e7abf814193 ("drm/i915: Extract GT render power state management")
dropped the "if (rps->interrupts_enabled)" guard that
gen6_pm_rps_work() had around this unmask in i915_irq.c.
INTEL_RPS_ACTIVE brackets the same window, since it is set in
intel_rps_unpark() before rps_enable_interrupts() and
rps_start_timer() and cleared in intel_rps_park() before
rps_stop_timer() and rps_disable_interrupts().

Skip unmasking when RPS is no longer active (reaching unmask
operation is independent of INTERRUPT mode). This does not
prevent RPS operation from resuming on the next unpark.
In interrupt mode, intel_rps_unpark() calls
rps_enable_interrupts(), which enables and unmasks the PM
interrupts. In timer mode, it calls rps_start_timer(),
restarting periodic engine-busyness evaluation. The timer
generates software RPS events and queues rps_work() directly,
independently of PM interrupt delivery. Neither mode requires
the late worker to unmask interrupts while the GT is parked

Fixes: 3e7abf814193 ("drm/i915: Extract GT render power state management")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16562
Cc: <stable@vger.kernel.org> # v5.5+
Assisted-by: GitHub-Copilot:claude-opus-5
Assisted-by: GitHub-Copilot:gpt-6-astra
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_rps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_rps.c b/drivers/gpu/drm/i915/gt/intel_rps.c
index a33b19c04737a..0f9b4f1dd3cb6 100644
--- a/drivers/gpu/drm/i915/gt/intel_rps.c
+++ b/drivers/gpu/drm/i915/gt/intel_rps.c
@@ -1904,7 +1904,8 @@ static void rps_work(struct work_struct *work)
 
 out:
 	spin_lock_irq(gt->irq_lock);
-	gen6_gt_pm_unmask_irq(gt, rps->pm_events);
+	if (intel_rps_is_active(rps))
+		gen6_gt_pm_unmask_irq(gt, rps->pm_events);
 	spin_unlock_irq(gt->irq_lock);
 }
 
-- 
2.34.1

