Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A60CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8547610E49B;
	Mon,  8 Jun 2026 16:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jAC9ZxdT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B1F10E49B;
 Mon,  8 Jun 2026 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780936478; x=1812472478;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=K1iCRAk3umWOFZM2ThvVXTz3YCpC2YDrb7uQU1/ISKA=;
 b=jAC9ZxdTZXft1zBlJ6MWL+zQmel2Dxi6Mon5TqE2XBb4W7nQYI3RHErm
 du3foSPct3QC9bK8ioMX/cZgmAkRM7DeSqqJHQ/oP3WWEy2Db9M+Fft0W
 i+QvRtHFBWe2rEcBLBZhSJq6pCF7MiRUUXdp9gRXQl1egNZ7pHIIUcr4I
 IM+okuHyw+qBARt0FUjYtJC0f0Ji/LH8OFC8eYfr97W1xP7J1x1rKS50I
 MQxGK4Skhba+bwwlEEkO1/6h39lW9B1qTPNqpEFqZCT/HyzfCCOV2dIMD
 hb/LwanTwKgoERWGPwJwnb+L1NebJyoYIehk9CvxUy/O7gVsv9u8aAgas Q==;
X-CSE-ConnectionGUID: fW5psJEYRCiqlDo/brNwSQ==
X-CSE-MsgGUID: kCRJs9vhTF+o4WXHieUo6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92785293"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="92785293"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:34:38 -0700
X-CSE-ConnectionGUID: +jTpAzDtRwSvaVOQwyONtg==
X-CSE-MsgGUID: An9DoaoTQzCBTxgMOB0fHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="249888312"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:34:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:34:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 09:34:37 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDb4T9XOOGd2Xb8m5nUCDC8LfYRnBIgH9TNdxb4yzOaGlk+GqwRVmOAIAI6gV184JvZS6bWK7580WDCDvId/5COIim2rfrO/iTaHCjXgk5GUJPHrIAJ4CT7HRxMhEWa7AJoo99RB8bpt5QRS4rJBEdwF8s5uH7occkbJggKCV9E1Qq0ZKToOX8ySYIlim9XAOuxx9zdkV0beBJ3BpPQSF5GHXd1gvHNoG2qP7VzTi2QItWvUqvkuHfOWz+lP3b7BWelrOzvg9OKQKA+rV7JM4IdOwKvffj76n4tvDnsqTajJv9elvx5/2DQOBkMtT0YKzLvoBb6aM420o0jqvwXK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZtbC+5wd6QuWzZGNGyp3w+se5aik1qngd7bMrOQVQE=;
 b=F7akdneVRCI7cd5GqdLNTZ6iUxYm3N2984mJtAQCOxemSBU8ErQf4XJp+U7JcUTEjxNnHLvuknUK2Hyzm84pHjXTXVs2ExC5WnDO7RS8gKyoUTwB+8PmOAOk8O2uuH12bp9aymIDXkXXHZstXURpXOQdK0Y9fC59z8+RGU9kkOXPvFr4Cm3VH0ppKKqZo7vahw5S+ncSaajbF3pr872htT9Ub+KypqB789kbR15D1+kocdWMKRciZEwFnGyO1PJHSMcOx0X2v/7fir84pukRIKseM69vVPxnkoQfUtJAZBDDzhdvJ79UTAp4N6NOHP0Z4kBKGsavB7tS6EFt01xpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 16:34:34 +0000
Received: from PH8PR11MB8287.namprd11.prod.outlook.com
 ([fe80::a0e5:e99c:ee7b:620a]) by PH8PR11MB8287.namprd11.prod.outlook.com
 ([fe80::a0e5:e99c:ee7b:620a%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:34:34 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, "Vitaly
 Prosyak" <vitaly.prosyak@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Gustavo Sousa
 <gustavo.sousa@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Build of drm-tip broken possibly by commit 40396ffdf612
Date: Mon, 8 Jun 2026 13:34:31 -0300
Message-ID: <87y0gpj8iw.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To PH8PR11MB8287.namprd11.prod.outlook.com
 (2603:10b6:510:1c7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8287:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3796873e-2d0e-49d9-d6a8-08dec57bd29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099006|18002099003; 
X-Microsoft-Antispam-Message-Info: tJVbFVk8jMuSjc9zferN7p4yX211LyNBCTZKOiQ1Df5kVuCyoZsglx9HE2A74ryTOtqpzKzA81njq3WlSAVFtMu7qvzlGdsCyzG5eM4JWHNKy41TCZnDBssTyVyhIyEleqDtayYQV5gF5g5mX6iGxA1huUWrhrD5JLvWe07IZzCQkNz/NRmjIUluXt+WEfx8mCXDrEszh1K5XVHZJwC68FR+ZuaQCqTZMzFw2MpCrw8B96J0zwWh0s4H11GhOZ5qlso6CGLmUC/1VEqe65aZzibVsf/d1LY0x215r5tRSkrDndFSzIbx5GWxyxy8DNEMkNYW2CqzVTKqEYHcY+Cbg4+snNvunN1/I+ya8Y78pHBn7pQ0wQ8cv7C9U3nD+XgDWNPTUATmDZxbAnp3qBABROnctZ/5vKqHfRnu8lMPIyhBFhh5WhNKI7O/KjT0USSOFqp8TCF8qpiuzv4A7dek+PB9CmrQWkvqBiars07scIjcFdPH5pCjChoPsnxiXwYz2H3MoV53Y6DE8Jv28NqQd0x1kd8o5taFRc7dnfjrslxeIXSHm1wGegzzrvZjwYZy51tIovuoaNtWOvL4hgW1rIbcY1++pQQRbM35JBpvQxje+QghOaxD6gTYHh1vXW4YfUy9VF5k6vE0aTh7euPSiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8287.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ncnYAvMqqHxoxaO3XUxHU/0V6suvxAXacMzxNsQRfArvnjGPmcKXOrWBnU/z?=
 =?us-ascii?Q?fmaMKorRIf/ncG8niff2450InWOK2udCEon9syDD7qcLFfIamocSfr5Nfx1T?=
 =?us-ascii?Q?xi4n3H7ujpi4k+l5VuBn1hnqXq19l9CPwK8CrOa3SzyXlD2ysf/Unj3mAYZ7?=
 =?us-ascii?Q?K4iSKEPmw3R1phoMp7m4gDUHOg1vGQm7pnCzgdG1BvBv9X6cLjOs7fGmE992?=
 =?us-ascii?Q?tFnsER88tfaFVdUnStS8PSMigtvhiyhX7WrlAAnoSyvqhBOlF8mW10cFNaxh?=
 =?us-ascii?Q?0kp2wGrPgXJJN7f/pCWyNP3pGvNNblPWKjgZtWZ9QDcNtF3V9X87JntqqD6S?=
 =?us-ascii?Q?SAWwiFbk3YYCVUIo1hXoDCwOh8Ex9hGaVeEQuQii9Usp9ug8pV7OZf4nkljG?=
 =?us-ascii?Q?iW/pfI9SokxeITp6zWWR8k5oYZEO9XBBCLZRSanAR148qCfbjK0a33hQU+tN?=
 =?us-ascii?Q?+l7HFovH5GVT506rtm22vANp5n97J6rzqx3Fxln/Ej26xlIlRi2FE5Xc6sEq?=
 =?us-ascii?Q?oj/U5wHPw25P/6Gt9/EeVYlxkCiftlQaW1rSdVPOk5HwJWzhJJMxwsd4Rv9L?=
 =?us-ascii?Q?X0UN5GN5qKV6DTEXzd5uAUH4xJ74pSve/moazJEyBILW5I5UCLgRk5/G7pM2?=
 =?us-ascii?Q?nv2q9ChZYNx7we3BYCHba0xgHPXb9mNUVvRTvCM0GwWBS8pa4bOUfeahH/57?=
 =?us-ascii?Q?TmVZWkdsVF/cAbZCOqTLJuU5V/8QHqXMdaiGj2IHkSR3C+N88FymV7f2oaGt?=
 =?us-ascii?Q?q/Fn2SYuro+SIUwe1V3LoQ3oUDfv7Xyc6+f/NW8+UgAal4aimzRg38wBxKfc?=
 =?us-ascii?Q?5mBtpnMZGCJYXqIhqFmC8FETPJrEh20C9TfAWTznYog03kY/eRtWPjLfMXpm?=
 =?us-ascii?Q?7ldjryb/5IUAtIJsHdjrjC5M1YZBJWqjZiXVSNLBpupm3danLzCZPGW48YTx?=
 =?us-ascii?Q?582rIaDJXCbS11W/0k3l6Z+vfcRj+fsTPf0exXD44cRrHPyZdVRtyIMghW30?=
 =?us-ascii?Q?+T5URW1zMnwaJhIBpSuOsQ+EpZ+EdsTMm5EQkuL1kFXQK3zmTCEo9oUwRZC0?=
 =?us-ascii?Q?ecnojRrHg9R6yLfQpGS3s4putK/BKKJvqiJ5+XJFvpHKmZF0ODcbApqrkLA4?=
 =?us-ascii?Q?/fCzuSDv7cBH+DDOqjEMFb2A7g4j+eLVQpd4RpDQ/0QVGTc7bRGK7i7kfMHV?=
 =?us-ascii?Q?4PXSFHywPj+KYP5cSuHThkmsQg/K2teuR1c/A2OrflaamulZcRKexX2f5iTs?=
 =?us-ascii?Q?m3tQIOoXmliVB+FpmLvwaffJ3OdmXH1+kVkaOpxwvLaLcsdQMOrMQx5T50dg?=
 =?us-ascii?Q?YB5viVtJ3qGFHvXwwVjcNI/hVru5iWTGOO8L6yBPLzpDeT6twRF0rit1dya9?=
 =?us-ascii?Q?B7Xy0v6hggmeZwKgZWsMh4SGmq4kCEHcZ0rmWDK/v6qvaqZE1kq7FkPYduwc?=
 =?us-ascii?Q?39FyUXmZNm/ucsDpGNlfbvYfFYnXid/KxMH9GMG7qYntrrFBZmUcqc1IWK3h?=
 =?us-ascii?Q?XB5NDUFK5sJRSu5b3doo0QGhoOoqihGb9t/ajlmMLGNmgJrEWGQiSRYh0yoR?=
 =?us-ascii?Q?JuPOxp74WWzfEDR85vWTeAa+xj+Nt0JHZGDQK9PiVuSB2g5t6p+qFkKV+QqP?=
 =?us-ascii?Q?1zMEP4PdLtfMUc/IrmwOXu3IRhnGikR7X7x47ZI7+Yw23XVOy98S2Ceu4aT9?=
 =?us-ascii?Q?FYXlUQ2Jqq5+9IDZule7N+S7eNihG9AH8CKz5ZDw90HCbR3FM15uIia3mHi9?=
 =?us-ascii?Q?0ZNJOSclvA=3D=3D?=
X-Exchange-RoutingPolicyChecked: PNZ7B5wuDySFK68OtQKx/GPtKF5fIPtqRzzKjCtYdgxHGMHN0wQzPxu/UMghyEBGAw2tu89Gif52fVNy8tLz3bAS7LYeofSW2Jp9VwwrRbEATLl0EjdgYlm3y2J8M8eGXyrZg/m4qqyZeSyNkoCeeMqfCbaG0owRVIs3Ry4LYMMZRkiEO62rdnFfta+lSklZ32qoxHOdCNJKbUCFUDwoJBp4QRQtOJlUgJYukpD5+2YGdpwMJB714ZOuSYyfWmj9ofMYAxT3H+nnVwG+n8/rsfQOiCsd5Y0OQioUuhZjrXta9+l9DmbYUPbZIe5XA8bIFEJH7ob4rI6oAgKSMAQM4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3796873e-2d0e-49d9-d6a8-08dec57bd29b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8287.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:34:34.0162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAyQWcPN7LMWsVb2YusOdg+YNO2GHXw+9dZKHd1ZX10uv17tPRcJrFe3+1giy2pHgFuw0i0z2k8d/n/H1xa19w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
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


Hey, folks.

I noticed that local build of drm-tip is broken for me.  The commit
causing the build failure seems to be 40396ffdf612 ("drm/amdgpu: restart
the CS if some parts of the VM are still invalidated").  Reverting it
fixes the build for me, but quite likely reverting is not the right fix
here, so I'm sending this note to let the experts do the right thing :-)

That's likely unrelated, but I'm using Intel Xe CI's config[1] in my
local build.

[1] https://gitlab.freedesktop.org/drm/xe/ci/-/blob/main/kernel/kconfig

--
Gustavo Sousa
