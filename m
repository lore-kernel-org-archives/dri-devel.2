Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C380C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C341210EA94;
	Tue, 18 Aug 2026 09:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aGcNgRnl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F4110EA9B;
 Tue, 18 Aug 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047004; x=1818583004;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hBxl+zUAAE355yjVjPn15RpTYRYyCwk2Ii76kWQbKi4=;
 b=aGcNgRnlQQiSYGVRrXf+SH/Cei1698AlL+kj3PsMivYoZdn6FvjTitdF
 bybPIfyfUcaC4+4sj1CdxpZMVk2woGVio7mrZmW4O5KalhMYsCjyAp2fy
 Op2XkAKXxxyH7fOm8Z4+H9YqcWfCOfCvvM/Z2j8h8bFAHts2mMN56knLO
 buDSb/RKeEfCZqOd4hLTbOQkXQo7tf5FAuV4rnxR384aX76TbahHXA/wH
 LGRKedMaczN78p9yD1eEJu62d6EiXArkUGopW6FomQN6yD8QwF6E/Hp+8
 SWqNOGb771k6ZNqabEuRfhfJupIe27DEl8BCFTyg5ayCAEhHbIsP8Q1pn g==;
X-CSE-ConnectionGUID: xbZCJ9+gTXiJ11BFQhav0A==
X-CSE-MsgGUID: GPE5WSTyRqq/0m8ZuwU02g==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113076526"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="113076526"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:43 -0700
X-CSE-ConnectionGUID: GmVvkXrfQ82CPu6kw41jXw==
X-CSE-MsgGUID: +X1+TNLqQTST7wnjKsjqYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288687540"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdo5IsrM9USzhrWe/IvhiETIvSImETpltPzMUEwftD2/lSboTv80OIZK+2wpyXKLuyeleilSsAGUMG0KY7J7Q3v/ye0e5xPpOs/YAJE+T1Kqpjlvy+7mswVaS6mSPv0EoIkzLeCUkU6/4ZyTBCdZ9rmtyR2pyVxzOkcNR0FXmwNt3lkc8y/Y40ZmhEwBt36i8MeWYCOqoK/emq6JNIsTTTj6gb7rpXCoY3j2dsupiwFVwfdRzuZRawnOExqMMas4q2orMqJpbzLd8lh9eQx0DaejJYWXn1QFF4f6N1s8OT5HRguOgeqCFDtgO7oClepLdRL2F47p9p0jo0SLWLyYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WiFdt5zd+rBoY5qOPbuhTWCvjp3OXA9xvk+ILj6euI=;
 b=rXENU71zktE3aFlVhAYqZbrxFH60yvosLYS6F0RBDnGrPWzKEcg3MefjIuSecJ1edLLH3KX7/KgvASh62NvZJYr6ZE3q0TM+fQgX8b5zUBTCvwrpOGBihTGsUtzTraDL+hw78ACHELzmEuvmH0zTRKPQpVMNSPtblWRbQxos/c9P8aLbPr01f5pR3pR4WeK71OLRySA5XJ2GbedOXeXGUOFvlTafv58Ld58BP0w7xtaHJ4n9CgmE63igHzpz1R5xAZiYhGtfBdmbDPJ00ki91ilwbsvTCAB/i/r7WmT/YJsiKeLFViiSyVrMVpKg8bLrTRx9mbuGYoBWw2Hu+QnVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:40 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:38 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 2/8] drm/i915/selftest: Fix a typo in alloc_workqueue call
Date: Tue, 18 Aug 2026 09:56:18 +0000
Message-ID: <20260818095624.3254368-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818095624.3254368-1-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::6) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 432a4c0f-64f6-4da7-ba3b-08defd0efea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: RJJoNMB4wmeIVnItpIKBfgXd1t+OmW3ZbqKJhilDfyp/AO7dRRINI1Z2toxvwb1cbGXpsJ/044pnapI6XGOXW+aggadEhl9R2PnlrIlzEIa2zJM2krRHCyg2c/6VkpcdLto3gm9Hbm2AMZHaOTZK1dlTPh7oww9+CXdY/spDW6i13U9Ih15w8tngN1YlfP6dwnra/jNBgvACERjIZBPYze2fR5RmY8nn6d+rQsqpQGCOxGCqorew8XRMuVHUA86bUawXouRMRRDPp29p7tN+OHStwryihozjO77C8wuCy3zwPrJxlGxYx6ouPBt0vFln8vogzIXRuLwQKvxYMJboctIbORQKMWz4KuH1bFl4DRoONAjqzQZS50MPOqVXspQdh/fq/MlMxZdGHZ7SvxF88xFNEL+qx/jQMKGxfomxP0Dm89Vapy6F45QH4/6A5p+Pq7tJ33o81G8sNtEprWkcVOI7br2ftlanz7BxEETG9qv51MNO12ipSkQUB80e++JrI2W4gIHGOaa2nERriwu5tU1HvvNbzKXT66EsGv3GJdfEIvXcfh1YRlCTfuhLmChXTgai0htMpg2vMqH+p4wyf25rvjE5PxF0ez4pXpT2PTBKp4D/YPylZvIAU7XJWD7elBxs3VZGFZUiRSU84P2owVvTQIVgYCy+5NamddIVRF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0ueOrwQHsGLzegn4dfDFWB9GR3pbM6AT8V32brhJXadptIY3D1KNwODK+EO?=
 =?us-ascii?Q?HukqXkFlK81ZPPOP15TyiaJAZiq3rX1eBHiy2kgRQxLqI1UZsqmSadqRvvL4?=
 =?us-ascii?Q?9wPVjacZNGjziK0sTogNrUV3o3vPWZgSfcJ8T4bHaMLVutOIhV3iDQBiLGfL?=
 =?us-ascii?Q?OTwquX5DUGt9IOOKzerYVj5ef/mxeEGJ0TvJUJo0lr/P5DHsxMLECPBVCM49?=
 =?us-ascii?Q?vqpTJG9hnAk7pX2abeB1LFExSHYo+C2VPawFSoPdXRv5XVnbKAS/FpNQGYPm?=
 =?us-ascii?Q?jLwEIbglt2Weyy5xr3fD3kN2nc7V7Ri21E6UqLqxmaAzNF+YgqmrVtCpVxvT?=
 =?us-ascii?Q?pncsbh70s4SS7LfFUlyvUQo+fLjPWmQ6MRj46j36BTrZqtWeriFgwFPMxK9z?=
 =?us-ascii?Q?jA1Qq6mSS7YFxdwyC0rIBWGDOGzXamKibjHCYGVsix02bFWenleb+X5hyZx6?=
 =?us-ascii?Q?5PHm2cmnrt2BnSqKtYureNse4tl909/7wzT4TCKFnRJnDUUD3KHcqNxfe5TU?=
 =?us-ascii?Q?plRUvIjXtuYSlISgvwWh5eyms9xZgVo6c7OXgQKy55FMVecHIv24L+77FMLl?=
 =?us-ascii?Q?fi/+MuwZcqL+OBBq0C+yQ9SvJ0Z41rie4CIIlKZgN2yQ8CbsaviIkAHQWHbs?=
 =?us-ascii?Q?sIgKHzKOwv9M3PF/c4N8TzygRO4ApCcGwQLKo2gGvSQ+PjMjBcSBtuLUxboV?=
 =?us-ascii?Q?t2Q16eOXE42mUztB4cVc7Fh83mTxgoWqB5elEScNvyZQg3A4Yxcyfn4c8Gkl?=
 =?us-ascii?Q?eeB8pFXzNUSf6oRPv7PcQyVFKLS1rKaxlbAqHC3Ts5OcfJ1dltlVcM62tw0E?=
 =?us-ascii?Q?JrDQ4ixUEhhspKdhHUjk0pJ+g24qFTMAXW6gi2wS9h6p+qrXUYC98vBJtBLj?=
 =?us-ascii?Q?6+wwhH62fPfSM35K+chy6gGYK5cBldwA+T7eDZTMBVuE802BPvC8E5m0bXy8?=
 =?us-ascii?Q?X3OhtEyFYYmERYNBLKRDthMgIHyyNFYStWwxuENlYGjY0VNNRet3prqgBLp3?=
 =?us-ascii?Q?qceIJJd2bPJUbHa+aLS5Re24wFvO97DuA5wkFKuPHCSndCSU967qm0uiBCMA?=
 =?us-ascii?Q?BNt880T1m8hpyxCCMJuR6vHYVraBr3yQzOX0iqSfZNbdnjqnlF8T1BbFWrcU?=
 =?us-ascii?Q?4SGLFPwMx+feu/V0ta+rQRr9tlIBq637JTGYR46FEPWSHZ78ON7g0NssGdry?=
 =?us-ascii?Q?me+JMIucu0UxSP6Ue4bQGCllH47DQTxaNSp+8J8bY5HdtqCHHQ88KUXxTlqK?=
 =?us-ascii?Q?O5wYnmCimzGZcztdnIAaI2UVsXjUohj52qQtc0MA/qfxJ4KejEeO5x2B8uP+?=
 =?us-ascii?Q?874wjEdBx298dAGz1YkQeggJcMRIoZWqmhfbxAuvqhu7IiipbX2sAiRWotMu?=
 =?us-ascii?Q?1W0ujZs1+RiAtWMME/9BRNz1SaaEjKJrnonZqoiu75mGuZqwxkC108ZIE9af?=
 =?us-ascii?Q?kdxMildax6RFs9b1X3Jhv5CP+NM60SQrKF6s+pjPhxAG93EGxMb6MScYWhJS?=
 =?us-ascii?Q?pHfpZ/29RAs8Xn4ZKgur8YsYb0ryQhsvXaqSRW1ygxHMRa5I/CAcA4XS9F6w?=
 =?us-ascii?Q?hS35VW7h9oqKtJ1Vm5trbiLuK/WtKiRsQkHECfiQ89JFYXwtevYnoLhcxqoz?=
 =?us-ascii?Q?S020lZkh8BWC2tR9d7JXvtiP4R3BTZpvMwjCjARqOQV6R/m4w8WiUZ8sRWUt?=
 =?us-ascii?Q?xQF9JfM+02IpeYl56OKCAlplNwGVq/8+3J9y07favPr20TGZ0Y3shBwuWwFn?=
 =?us-ascii?Q?aGqHC15vv3PhYmp9zI0/fJnU6I0HOjs=3D?=
X-Exchange-RoutingPolicyChecked: lO5Sev8umUL+wMxpMMTwLqB3+nr0/LBhMEjCcFx2APsRNYxQyTRnDAIAK52ZPQzoemWcQqXbmo0nSmDWigb522QAoqKfAiNVenIlJCulX5gLK64pGM2/Nhdu6zUseWeCa4E4MgUZIQkeRhdTm+u1rBYtzCR+HPyVfbBZpKhpjSa9PwYIqMjRBA971C4Mgbqb3nix8+LsT3zzwvtxG5agA3pvoDUxQvLD+IsWQhpdsse52kvJF4T7R9Cb2VCIMsNpe22U+9OTER2HlxFZDttgrv5U0Cs9HMT8W1oYA+29KkNWC6o8GG+zp5Z6YevDm4h416vaIQamD1+DwkTwQfIKdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 432a4c0f-64f6-4da7-ba3b-08defd0efea2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:37.9353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRoChprjrgVa9k+LK3tZW2cXPIPSN9zf6potdE6esrlE79ySaNb7V5DWb/BgCluHYoKFGVwK3A/u0G4v5iWkLdHMaFYk/Su35ZOPXQHSqng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
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

Replace "i1915-selftest" with "i915-selftest".

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index 462704e575f5..b8dc30f81bf0 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -528,7 +528,7 @@ static int test_ipc(void *arg)
 	struct workqueue_struct *wq;
 	int ret = 0;
 
-	wq = alloc_workqueue("i1915-selftest", WQ_PERCPU, 0);
+	wq = alloc_workqueue("i915-selftest", WQ_PERCPU, 0);
 	if (wq == NULL)
 		return -ENOMEM;
 
-- 
2.34.1

