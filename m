Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E24C61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121B810E4A0;
	Fri, 28 Aug 2026 10:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MhwtT8we";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A1C10E48F;
 Fri, 28 Aug 2026 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787911444; x=1819447444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZwC1fWAVIwemN+g8DZC9shxiwu5f4VAla2ZLid9Lei0=;
 b=MhwtT8weXnGQRMjP/OJA3BH5/uX0YyODicCQjQgy67PbfpsTUhj5MOSv
 d+ZxjDGprO/GEKSGzVcosb+KchZfD1qsBVTOJIgQtU26YBiEiz0606E8F
 otwotnBrkg4+hmvoXiVCpq+2+LHAzapo7OHUNNinM5SlgOPjgnuh41CE+
 TYliTzmo136g1ANKljeqJDcp3oQiAABA+QR7PDir+n93coswznY9e4w+T
 /qEqFiX6HYsYwEeqG5kenHbi3rRs665CGA7HApCe0HDCNgDaahsmDm3aY
 s+vboFzXEOJDZd14xUc1yznbYPomzg+FptUjnpBTPqGZzL3K2YcMv+32d Q==;
X-CSE-ConnectionGUID: YBvSLMePRfuEDjSANRNx/w==
X-CSE-MsgGUID: BgmsfjwVTtu+FTS8p41MTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92231314"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92231314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:03 -0700
X-CSE-ConnectionGUID: HD3dBcJXRE6zCfawh7zUkQ==
X-CSE-MsgGUID: AHWfqOUVS6iKG2EBtLH1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="261973051"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:04:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 03:04:02 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 03:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcKFrYvxnuwWj5B/hdlHB52HHwHC1qhx4IuATus300bjD9P0etq3H4u0c1byLGxeARTqvRt1Ogg5R16imhP18TGjfRa3kmWV+n6djHw1kADEl2Be06HzMjIJpLe4P8H2VzijW9G/1M0PPocIqfyfbjTSeihmffw5hSU5Mj95jujhFrOw5IfMEXKPh0wUEmWWJrCvOyqQwNWUvhw5AByZwanK74WUGXdIGlhcfmwknNEwFlubOdXmFErYUbW7hz+3ope5qq4dLtWaFTXr8KjwQalqpwnlfQQHz0c49M2vd77H2rG7v7+jPs8KRji7WYPNqtJBuq6VG/460QqvCWTVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKRmMejB3Uk5fwYU9WygDvTHii2RDY1j/7sdiFR705c=;
 b=hxNag8eUP5VGnnu6NcyvdEnz8Cu+XB4jI6U55tc/vWxSFauJx60IR0POa71TFIlcoLv2NhmpCcxIste0jsNQquzFzuhyNqEWF4xzdPudI8VPUBKUi29M7Hve6tRHX9yPfU9Nqq1vubw9CMAUwwpcMGByNYwtENv9P6Ps/asnD0zu8aX+0HbrBS0054/A1c+C8KL6zs4Y77/hkqtvaWY53jzXaflAkhtVOm0qgwi2m/NM/3gjJSGf6fMml0M6rNzCKqFmv0V+PVkG09hV+8yrV5zxJMiCDyxunxANbTtD0/OXKRb6r0oTdRyCIMpiyJg4UAzNG2Dir76E03o5vrWvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 10:04:00 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:03:59 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 1/8] drm/i915/selftest: Fix a typo in alloc_workqueue call
Date: Fri, 28 Aug 2026 10:03:32 +0000
Message-ID: <20260828100339.72304-2-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828100339.72304-1-krzysztof.karas@intel.com>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI6PEPF0000022C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e5) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: efd23343-cfa8-470b-9dae-08df04ebae22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: oheAJQGymyanDDGCpNPGgAKI2aEm7JcRDzjMda7J2JWd/znieRLWM2pRZRqJPkwCwfqiK7W6c8BFGBHqOZb/KfIdySXYesyGQccmha7xB9MYWaVE817Lfa4fGtwIWVlM1egsBzpxjiC6npg60ArUTbqOD1jOzdT2T9K3mEgte9w40zDCZIxtmzmr37Q8r8krHFMtRJ8xcsGHB0UNNt5GCuClYhqET+2WuJvA36EUGxLoow20YyYG07RRUnxIYjnJkHFNCJ1E1OBIZXi6J71QHagm4kZzfJuls9FmiucbOcKUKHM+cteNn1q9CV/1pTr4Ve64++KOdbSdTzcVVajAIzy2F4/HFcKTVaKiAUUQbtn4ip7f0ucXToMI6ea4hT3tCNe02ntANqQ/skL2N7Y6tfqVSuAspjpjdUXtAAqqMjOfc3rNIe/sFZllhXtcPicdC34uwWTcCx4eXMnW8Fhf0QLa8jKCKq5alPmdL/Kl2eweacFY6P4j2LtuqbKMEoAwTqSAxMkO4R7K2kOixTJ5xmluEC9NmMj6vBuvq/Rn9p/kFZTzh1bULjkBipytEWW/5jXAx+W2vPd3/xCBdibNJg4gsqPSkEzDFzITRXp9yA3w28/mXsfWeD3tMiDbbWcNKN0XaoLFThYh/t+gaiZWo5mdD58kOA3BE4cwF56HgdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71Yfwvym9zJDkN21GR21Vp7cx7ylLYecU1nMDwgeePVUEIz7vQHf3+hK/iw0?=
 =?us-ascii?Q?EhQzBR28/A53bv66Axf37wYa1souhiPdVYpoOb86DcLMztdh1sLVZLwjou3Y?=
 =?us-ascii?Q?U2OuuQdaVVDvUNzTTfmgNNgVMmMdcb0VLzRmMmmBCm0iCY7itJX6qI/sdph6?=
 =?us-ascii?Q?4Kfqvda/ajanpmbkClpmpMXgVRT0JTvpuCx5FGPhmX3QMc4+h6zXDsDUMOEI?=
 =?us-ascii?Q?KAi1/Kj0IFFbukW0hLOMRpSG+52clfXRUMOD24CJKP2oLTTBHkwdk/EOjzw8?=
 =?us-ascii?Q?x/e+w48jNmHgpWPOVmEus8P3NWqSTgm8yrOAivgQHOjeTlAhajAkZjPoGUfv?=
 =?us-ascii?Q?7RiZkQA32TO4knxS5Y0kD4uFMUKbCIgc0jnaSlehnfiU0QHReQj66Bd/oOUk?=
 =?us-ascii?Q?1kyKbfHUDrD8WPRgFPzUlS20nh/P2ndUhmulD5/xyfB2fjWnFvksw18bSZfw?=
 =?us-ascii?Q?WWKD2gnwbETMKTHy51mvX2Id4A7/If3FrfLuIPDwokS1OR7szhq6pWW/ZQTn?=
 =?us-ascii?Q?tXqBRnnlyHVKLKoxv6V7JnGfW1SxQUX1UBsnLYn5NTkwn970FLqjz3KHuX8Y?=
 =?us-ascii?Q?IUE/26CJurHBdnErzZTbq6I1p7hMBauHmaWn26P3G5aaqaKpiaYUn6h/qigN?=
 =?us-ascii?Q?yJae1xtpaSapF5QTb3Gw1294GzlfsnVRyHQD1xxSRLH/SCMx8KiCunKsUmS0?=
 =?us-ascii?Q?BjTuHTxh88NySFZdcPvhxkHal+lMV6ceVsHlFEyLEZbw6hDlW6XdRFePwp5d?=
 =?us-ascii?Q?5JL1x56+synIlYW+RdZA5jNyd55RRyXW5bbC6UUlagiqZMoT7nbhiH4ixyu3?=
 =?us-ascii?Q?fmim+z5niwUKDnD74Y1cqT546UQ9+VDj+fW68eeFqJu4zzxlXVhfxVpkm8Qk?=
 =?us-ascii?Q?GP5ZnSMzd0M7tM+A44nji18rR58TDXQJ5KeIO+e2Ee3G63neKIDNl/dRVGg+?=
 =?us-ascii?Q?//vKdG0bDLda1lZyHbw0DJXiKrOkCwMXASr/N48UfiJRnaNBaXJ5A6jBgOst?=
 =?us-ascii?Q?KEjcMXIdUKxbF+RCTbcVaOEjZkNhDxRgbV74AOVuF6a4N2ffSXAunGZdRcLP?=
 =?us-ascii?Q?AW3eR8tePayC+3LfC79qjkdbEFy+q3fOHyNfyUeSeQ9QSlh1H29ETmoYloE/?=
 =?us-ascii?Q?Zvl2i0yW9Ps9iOyP1Uc+xwqU1tfEOKT3z61uwWDxRdILEDrLZ1UkD47y4IYf?=
 =?us-ascii?Q?ZAcP0L0YR13d9jDSAEB//VQE/eIU9cjYm677wBtDpzmJjvbWbeXJLfIV1uxr?=
 =?us-ascii?Q?OQknci744JmHHTEPDou7ENeAeM6SYovNVSH6BpGsK6YPMkt7JjtF8cS/yPRV?=
 =?us-ascii?Q?dsrkRGGm8a0nRphS203dc7e7w4r/v649Qp1NMHtUxXX08+ZfJPwnKbNRumFC?=
 =?us-ascii?Q?kBnWqUGnPovm0Rbz/TBRo0pjJ7tmBxdD1az5jmE7iAY0MYv9cq1IqcLd0IQP?=
 =?us-ascii?Q?6gvEHicEi2twgF9p62YoLL8+74QHZmGS5wTezV7wniG2wfF9aYOZ/8J21dcx?=
 =?us-ascii?Q?EMG8dl4yi4X3noatu5UPx04ShSQphiSIP3LGS01G2BW7CLgSd+bLN7sTAhWt?=
 =?us-ascii?Q?YGIB7BZmHYdxnO2Zw4FhdsmKFMQTehtx7B72ukmDEhukH7cOz1I6BdKWZBgy?=
 =?us-ascii?Q?QPwYhi2GoWLFyFIL4L0CN8vihJtrIBmiSPF8G/dkA5MvzyVGWzWULdnlLjAR?=
 =?us-ascii?Q?89lLC/6T14mzPRO5Vksd8F28EwGQbJyYCxBFKn8XHWRkCvJ671XCufqKxPyv?=
 =?us-ascii?Q?r42ttsEjk1w+JYiBjC695q5E1M8NYgo=3D?=
X-Exchange-RoutingPolicyChecked: lfpcB8ay0p1zgegARzPA6IxghQAxHYMgZarra5evCJFh/p2hdCzjr55J3T4QoS3pMlrSbtFoD8oCAUS5bwW+vZCcy7Wjfiqos9aJQcWMgrv3BG7HIt19XixKGnFjsaoa6MtWPPeYW44IttTb05mlf129/KxDclf15uE0f8MCAseFRJoNxN3kQ/xpzAcioM34Zd9CmBp6uXC1gWNMnCCRbBAg6jPd+OOUO1+/3vb/2Dmu6fGSrGwSTQ0f9KQDuTHF7MDdpx/ZcMCD372yozw0mO+I0CKr4yCAKVOC94793apyp6gv4yR567hmcdiAlTNdb1/Hwg+84H+7gFr5hWpSTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: efd23343-cfa8-470b-9dae-08df04ebae22
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:03:59.9307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxi06GggSL0qgRHiEnwpLrEZFmueUxydqg8M36GWNHF7sd3PoQY4I10WUo3AHsfBAX923WR26tce3a3Lt5h+gyP+DRIkJlpfeyJU1ARbjN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
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

The workqueue created by test_ipc() was named "i1915-selftest"
instead of "i915-selftest". Correct the driver name in the
workqueue name.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index 6a305322e30d..ecb2d718f6a6 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -526,7 +526,7 @@ static int test_ipc(void *arg)
 	struct workqueue_struct *wq;
 	int ret = 0;
 
-	wq = alloc_workqueue("i1915-selftest", WQ_PERCPU, 0);
+	wq = alloc_workqueue("i915-selftest", WQ_PERCPU, 0);
 	if (wq == NULL)
 		return -ENOMEM;
 
-- 
2.34.1

