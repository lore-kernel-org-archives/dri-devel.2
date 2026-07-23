Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D313AC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240CA10F07C;
	Thu, 23 Jul 2026 10:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a0hKQCMB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF9810F074;
 Thu, 23 Jul 2026 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802364; x=1816338364;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=MlXJNbVpxiSBclPjX+K54HQT/ULpKXHh87RDjc9VZAg=;
 b=a0hKQCMBYc3v4vwgIF0FafzSCq+SoPOPjAhVFcI5s/w0bcXJ6coIYQDt
 TR65Xhp1mSZpmASnDNU1QwJGBT9+r1sPXgPXr10FsiP9K25j6VklvR7MO
 Y7SsrQVc8zfnpWvq+v8E4sYOT7grS8UBjE9WkHugAhSCx4RahEzPR17e0
 ShaiejWgqRPn9YISesGQG5al+8TwzApUfOOyaXZ/0TzsNZnWoE2TaNwSC
 h6jadb4NyEl9tiKu4ON6o1o5XURnkXXN0v1W38SFHrw4RrCGYxoQauQqJ
 nOWPyPl/dZzsvdvMtDoB9BLjNq8wkcEBj/kgDDE+PVWrVud2zP4N+++5l g==;
X-CSE-ConnectionGUID: AEXjcUTzSv2+kGkD0OKYRg==
X-CSE-MsgGUID: 8xYmlyZNQ02alorxJ2IpFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96970822"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96970822"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:04 -0700
X-CSE-ConnectionGUID: N5dVkgP0RwaJ4ZBWGArSUg==
X-CSE-MsgGUID: tGGuhvWwShKLM9EBMfA0PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254442008"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:26:02 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+bAqgO231lqayb4FHaxRI2lc4t9RiqSprd1qJHpbKdhTngE2FAb9FN1sAsXlMTuPSFAIhUuyeWGeApHoXzMxsGkoYrUSrrVbRMG3sAybeT5r/lbw4S//fNT+158VygjKmiTftZY50HpYg2XhmW4XHoA6WaljRFJJF2cjLEJIbcnLu85kpUzjUDn2qKyxU+WQD/ytj4FckH9csHCDKgpRwvKDVYYvaTr8lV8Jyt0Wka64NkMS/Ll8Wm1F5Uo7HGUUr0XARVN+josOXYfs7cY6Z8imDF6cStPSDfXft8du0n24i7Zb+Pc7iFHSwL5QMVUl26OzdH4EXwbvrPloISImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsUbm9YMHMS8pRPleUm6IbDK82YEod0eS/Tqwm7SQzU=;
 b=aCplCx/SxLW0QMy3jOUZSpNaEJHmr6f2Yj1gASVeUplT0rNg2HxYiQ9ZNQi9OL8MyGMl0J/mNxiOET5sAzNKlrpBJ+XmZpaJECHeZjWv8g3xoGJtx4BDY+DgVozovksQGhvKA7i6V6TRx3N855tqKnIFd6C8NnHy3cK5M1u2L7CsqaHRP+o6xjmZGAhKWjraoxJQ4tts2P0NPGpf414KyHu4J3H6FOPhkXKgNgUUJVDq2rWYLURhtW0I/HDD/idxwLZob11CYSpl5H/ckKEd4TglncOlZGzKU0wQPItS7ePmFPJajNGYjDVAOV8wYYsvchi+7QuVzjbwdG+fMZmjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:25:55 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:25:55 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 0/5] drivers: Improve memory management for large object
 allocations when i915/shmem is used with iommu
Date: Thu, 23 Jul 2026 10:25:37 +0000
Message-ID: <20260723102542.3245495-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|EAYPR11MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: 824bc85c-af77-4325-dacb-08dee8a4c71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: mJXXEMUQ64mGsZMDZ93UZqB8nTSx21b/HWmO2ZOiCqZmegrQXY9vySXLAlVXoJkM0NT3r902Jt3eTK0eyKTfa6xNpWYl2pBOp7ABxoe8PH8VJmGPdqbweju1shaRLPMSr3G1ArKd3YIO5OD26OJg/mp7+qnEviyp4cVf9j4Fq9+HCZTHUOk5rdZJ9/5i8yDZxTOmsQCbyMBoZ50TJI82qukmOe9xFHtoBjVkSHwxfy3kNyqbnxxo7l/pa9GElWN56OTufa8P/IBub1TlFse+bNO+/kaUhea9lrOlRBAKUsapX9aXEJf6KPoWj8UOR26O1PZJnGxaavCMjJT2SDwuIZkdJjeHfvWZkNBnVUZqIKL9/HT5RiFAcPUtJ54Vt5gb8uAynhgF5rmpvKdkTsTkAbLNy/3YFEgAlzrQm3T9S6tYY63mWMIhDpXl2ySY61Y1+BtxP2evZQIpc/OifldoYnERv5q2p+TxTWSCPP1GwYMJLCBphJ63zLscim04/dEh9ccoCI6OMUUxUvGn52Rpzqcr/u41pEukOEblY3+CuRLHd6EHLI3Qba9WZIIkKRhh32bipFXP33dhMgFzVvYCVcK3o576Z2vpr7djMMJ1Skss2Xm1ZQmw1Vt7PDSi7lCKWiKIkXRkaf20Fd0xnMinDm7taaNrFf5nP1z9oWAZGTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SRs0yiuUz94SDgEGgVT6DL0dEIJzw4vc6CPmcovpaXHz2rkmvATjx8JPOL1Q?=
 =?us-ascii?Q?RPDfiDcjNAt364Nb49voVwvrldJHq0bMftJxkWCvaKZQdN0aKs7Tgdntvhrf?=
 =?us-ascii?Q?fVdTOqDmbEUVtHdGBN0GH2/FHZ6kmzBz4+NJ4pqaCrsjJ87MA3LfXLYgiJGk?=
 =?us-ascii?Q?XgeeIB69gy5Q5MRpduIW4JpMQyp0urnUiSBDYxxcKTt8wAL5ub723jYjCllt?=
 =?us-ascii?Q?T/IQhJZmTeabcAk/+Vq30SgiJRcQQ2WTedSm5FlC5wPKghYdPFACIYy52MTN?=
 =?us-ascii?Q?rOKLTz8+haqUeGzqKZUnrFhgVOva11nlQwNPNiFkRkk+rs4xRHJ7bi1gZLRL?=
 =?us-ascii?Q?2u7P0lwPp/4lFeH8ILRc4NrXhBZeOrIZTJPIyMxF/jOBWhUmlLgtqLJRVs2o?=
 =?us-ascii?Q?z/5Jak9KpIXNoBtS35apUkok2zTOxj8gQaydKaF2bqAHGDJ1M+m/9mVjE3qz?=
 =?us-ascii?Q?D44+Cv/9TVjK5/vy0DRB0cujOwB7grCQBVUA0hJYGsUDiBuLI2Qrdp0bkFqa?=
 =?us-ascii?Q?2iIt3S3p/fbzbgOo7kKnUpcWypYQ4FzgWiY5jfffrts/1pKU2BqAgZcH2wH5?=
 =?us-ascii?Q?OVPiTdvwa7NxSsagYGXlQ598ZujEcAD01fZDRPhSbdS9NoPnNUsgJ6LS+AJH?=
 =?us-ascii?Q?2UZUElsNOqOj8pH0J0MS3RitegcIUTbKqFdb2wH9QvHvpZSKEJNk50zHalMC?=
 =?us-ascii?Q?wh/qzLVpoAhR4aIb6hAE23uQ+BKPnsP0KXuJjFDcPqxYzu+02zO4fSMLJTn+?=
 =?us-ascii?Q?NfBOhawL+7mbcS+DqmynWbcR/5a9cvPXt3V0yTbPhWbbIBgFhFkXHidSVFwI?=
 =?us-ascii?Q?G1zDqCKqEY0QMwkUT/bvHK9brZbVdFuuKgRnL/ZfCCi/jWjSoEKz+Md1uZBP?=
 =?us-ascii?Q?zMtOVMcpvHTmzzLX8tJxzRT12IiV6gRPUuh4rDKrTR4ihTcVa6Cd1RwfrDkM?=
 =?us-ascii?Q?TjFOFn3hPgzHZuQhP5jnE9kdLq9QwpoaUrNvHHW1vZP/NwedDZtbfZ9qlvyY?=
 =?us-ascii?Q?X5QTkCy3qUAbulseKSAFv7wOLRHgZujPWW1RE8N1pCW2NVWAa7vZEa/xkiLM?=
 =?us-ascii?Q?NIAhfBOshQ03Tjow2mN1XVDi2oIy5WCyeSE4ghtOR6U9rk0GJCiH80NPZe64?=
 =?us-ascii?Q?vW9PvjASAAfSXgbr3h3+CY0bUdAbL6uPIBLcpCEoRYgl4T034baqTdnDQHJE?=
 =?us-ascii?Q?o72G5qy98RA0th1ECfHYtpy/ix9C+mSscbCKPeXyJkBteOkmZ6MgHjdy4egN?=
 =?us-ascii?Q?hLCx5r3dH8kn1Kvqz9SuNfaW9iw4IxYMzRGnBjyikNzULVguK7e2EoPvArgz?=
 =?us-ascii?Q?L1d4x7zexUdRsM6vOi61ozj0jlcddh4Pt8iV/syls8FcQ7QG+QlfHLqamqL1?=
 =?us-ascii?Q?4ZOMq7xPe8poRDEKHT6X6VBtFS2P4Szi2X1BKYtvIQdpoZneQXpzmH9IuKXO?=
 =?us-ascii?Q?bKtIcU5CtNXd66NrOxyVXpOVHx4xooZUTZAmfCmsj29L+elBxkKSrCmgxVaA?=
 =?us-ascii?Q?kYdMpVc66NZzlm0Bcl7tvegLi4HoSf1G50mou9Frb/F0OpV5WdWaP2e3xOun?=
 =?us-ascii?Q?hoJ+3e1Oiu1JqcVf8Q2NU7nqTqFqiXWksXwcKrXDuQMzSZgL5UircGGDPQMP?=
 =?us-ascii?Q?3hoeRmmuW9z6qHZFlqwULcSVRomHcNJjJTM1+3Hr0djd4MWxHH9wOuUeGxPj?=
 =?us-ascii?Q?CSp0YwHNgZMLe3ke4KH6nEqmSqfR/IRmhAJ+vJi7g7hstqU7vFatyCqiqZgO?=
 =?us-ascii?Q?PNagF5AtP3VQuDFmzAfxuwYwCq9koyk=3D?=
X-Exchange-RoutingPolicyChecked: IG4FBCWiOqwHC5Pvpf4F88INs2twsMzktqNXDbCqcqEUix3+ve9L0h4IorCBnINPZhLFVoZkqvRfnHbYF4R111sQibSZ5Y7QMYeGyugBwEVJSXfwdYh0ie57KhzBhlaT0736B+w9LLhcQ9X0wnLTaSosscSIJwrwVaLq2T86G7/ZUm9WRDC0/GH/GWIGyn4GxZGS2JTu8IHjpPZtQqGYWoS1nH8Y5LVX7f9fEdBhzsPnOlU8pcMhXzFml+l5+gFhZnFdEC+O0gUxcLLj711imXDL//BSlgVQHU1JrPHUNhqL8sWJGqv/fnu98i5cdtFkWvTpgI7AU5oW5iFl5w3BKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 824bc85c-af77-4325-dacb-08dee8a4c71d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:25:54.9761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waHx3S7cUQSyo4pbkuR4R+E+0NDwkcx6upFJxn9AdJ92VwcpowtXGSkAerc0ciFJzmlFUWLvkerCEZT9uKV/0Xhpg8RcakShr7FiXVae908=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9969
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

It was observed that allocating large objects via i915 driver
(igt-gpu-tools/tests/gem_exec_big/single) the folios and their
pages were not handled properly leading to buffer corruptions
during relocations.
Furthermore, using iommu driver in this context would leave
residual mappings in memory that could not be released, hogging
available RAM even after the process ended.

Krzysztof Karas (5):
  drm/i915/gem: Count mapped pages in a folio
  iommu/dma: Catch scatterlist length overflows
  drm/i915/gem: Pull out size validation into a separate function
  drm/i915/gem: Read and shrink memory in a separate function
  drm/i915/gem: Remove iterator and use while loop

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 178 ++++++++++++++--------
 drivers/iommu/dma-iommu.c                 |  20 ++-
 2 files changed, 133 insertions(+), 65 deletions(-)

-- 
2.34.1

