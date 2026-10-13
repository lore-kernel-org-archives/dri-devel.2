Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419FACA9EC5
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8DA10E724;
	Tue, 13 Oct 2026 01:38:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4040910E717;
 Tue, 13 Oct 2026 01:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791855527; x=1823391527;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=T6CA4AG7kTb0jVYy3fbvLjWeZ8E0Aroz/tgtN/KsmbQ=;
 b=gs1Rbz9Kb4OkLg2E7rtDCMY8nl4pSnECabnWTCC0d6vahePz95UPoGgj
 lllXsE+rD7gwadbwCjaDj18KyBXFbHJZwWj0c6kxuEgRw5Cu5zi6rexf5
 mpNzAQXQcKZI7q21TTfBmmQ5+ox6VbLgb0DEMH7i2YuhKXGGIEAnMTwdE
 1izSrr6NDjvm+ZkMg9xh3MYUZkXNCTLIn/F8VoqwsJz594ZaIGqLKMcLw
 h9NiZRiWKLpiJAxpn3z0QaA2RgixNZ1b6KHAVUxraMepzQK17fp7Qt1Wo
 9q2nN8TXrDs8J+Apn7S9n08ghtcOU8Pv2IofwyjSmAEsrqsSmBJ46p1Oy A==;
X-CSE-ConnectionGUID: dKcuwl93T2SzIUaKDfqBug==
X-CSE-MsgGUID: USK99xF5TviNa6KajlkMwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="471468"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="471468"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:38:46 -0700
X-CSE-ConnectionGUID: JeZjxUdETCSqg5B+undTEg==
X-CSE-MsgGUID: 8qfE+bbJQ0C/uM9+TsTCRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1043321"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:38:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 18:38:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 18:38:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 18:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtYA6L4Og6CP92Vt91qZXkMAce0xdjLQc/zZH3kmLffuiC0MY5uNH9kvYrZD2WBDWqfSne6vtGUPbJFu3ShlMAUKhoduh+RhsEP1duWFAVo207sL/ZAKaG62XrOxgEpmnsULfNws3z7WoA8elDgKtt/jC1nvqe8PtLU5S3hnLO7MysGMqvnrI+11SfkH3pqN+Xc1QqBW0TaeCXpsD5z3yh4+RbVW/yBMfG3BF6mgkI6SnfcqSj6PBlLM5X9Xy2bbN0xl4Jwlmezsk27wDf0K8X3iHW8XcsulZcMsaCyOJQ1NO2hDFa8eOxAO/ntQgrzvmaRuOy/qHlle0LGmgixY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMPszNRi007r2uE5wXcrm8oSSz1aqf8A6TlnwMkNTjU=;
 b=ird+q+ysc/Zec5I7zXotc5JUiahYUdNBQdvtSssWuaSuu885uBDr8As5pFWZVZMApb680O5r129m30NuHjTVjhPS4K8bhNwMa1FPCJNZfyM5TuT1g4uTQYK3uN0qFWH7577eOVTtQKFCH6JLzJ+2JaL27CcsZSaLwNZVo9KW6gbEvvNrBzyRj6ciDqXeZ7Okp4qx9Q03ej2excuBUontn9EIFszHwe+RpTnFveV+HFQymVuw0yNDXbzMIfPKNzM9PunW2jxty/0g28rstO0VSK5mkDJao1b4TPpus7/ccuYiHL7VW12wIMbfMF7lFQtoeu5ejapkRZWKsiuVBeu5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:38:37 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 01:38:37 +0000
Date: Mon, 12 Oct 2026 18:38:34 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/6] drm: consolidate self-imported PRIME dma-buf
 detection
Message-ID: <as2Lmp0A5EwH2OC8@gsse-cloud1.jf.intel.com>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA1PR11MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: c48ae997-f83f-4892-94cc-08df28cab356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009221227099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: iX8LqXI7LiNEk2FM8whNvEJe5+c5ySxk9oEYPCrUjuGub+uqMkHrgux2aGc9n4kEgjunavV4B1TUzkxJUCAx5fj26W3SauC0uZzubuyMK34WJb+mHYl4CHZAyvmYgIoUpuZHue9tMn4LOiqvjXxEzV3b5+tLgc5WBL7a701vUOCHxkcsGMnV6x3H2hZJblGz4s1S0reBcrQEOioKqLgu6rJ0PPhapZbhyYVQPpJU7AbYBpVvpyg7owCbVxu53rOyxaqLTeWjGsihMniU9N4e07ljevGurWKMDxDBOryo5eccNaC5POzs3tC15p7eTqqmi+Ko8OA1CDENhPQg5ni8+mxahKLP0RwjUjjuW1ZaHQ+zJlIB9R8RuCwMohlfpNibnR0kEcFfTq3rRVjoxw0DhlmxJN3XIOv9Rxw+SusIL5yV4nBg3/xn5ZXFDcct6p5zm+asEBTTMxzN4aoMtXH99YUtxAutknlE35UbIbFSpSNUXT95mDV98i3yB1yqTwayZ5QRGj0qu6NzyAQgUxLNDCI8dX5MmEZN3CM0TRtC1hMCMb35WSC7ril1UtfQosR0awUNZSKscbfqn6Cjg5lmN7CrLlsOQtmZO/xxU6b0PJGHdAPVbMicWfCSqusKm0w5Yh6mAjiJiFRDJxPtQh/dJlbGXfSnhQCXQ5YfGVpf6iY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009221227099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7KHGt+3JP41HzI36g2eMnWIFiTXw54pS/aSM5ukSmZ/qKIlggI5HIz0TC8+?=
 =?us-ascii?Q?+kk0VXymYyqZtJSlLpECDwPkd3XKWN9hwsJKNdZx3MnTyu42LkBtww7wcPff?=
 =?us-ascii?Q?C/yu4/O2XS6NnGwKh4GNLTvlyM4kOAOh4PY2Veh9yHlWkaXPpQhrEE/rwjeF?=
 =?us-ascii?Q?Dsiaj7xqTqi3E5Nui/eEnn9vSYB2hnrD+OGqfXVVLkX/xOlRmKA30UUEpZPE?=
 =?us-ascii?Q?cN+Wwd70rKHl189DQjDoudvgv1eE72E/in7yRwA2WHLgbV1VaKWkSthApJ6Q?=
 =?us-ascii?Q?tlVipXIrykk5TqXazEMElgwN/PKTrUyRryAZuku4O1C+yEkwBbwMSvX4KuN1?=
 =?us-ascii?Q?sN/EXT+3isIt3vnZackcQkQF7VjnA/wLl1ltGXeHHYZqFVNE4yQSLpIfaNaZ?=
 =?us-ascii?Q?OQeUa/N6NN9Z6ulr2Nd9e3RG1An3WCg2ilsIDUB+GpJemdfnbAWk2xTly9zp?=
 =?us-ascii?Q?Y3/peDLrlHRsYi44tOrQNVMwUeadQDaboPAb+GnqoDBFhL7lD2El8OSMU85/?=
 =?us-ascii?Q?oYSM+tP8dTYteo/iHwQ30p9ZRjZI5Yrsy2OWUK2qriG6bNMwI4HRLzuGioY1?=
 =?us-ascii?Q?r9PV2ehGH+2LPR86cCD3nSMkq0E8rpY9UYgyX+GQ7ALoYVQtPcjJMAegGrx7?=
 =?us-ascii?Q?0/mnffDo72/6Lz5EWGWBkxE3lp0aCjHR1Ly/w/xLJAV49+2ov1tmgEDZ4YEk?=
 =?us-ascii?Q?tn+8J+uF4dGHFasnm1U+Zu0iYKRKDSmp++xgRFkHYeQeUX7U3lGoQxDmZJgx?=
 =?us-ascii?Q?9n3QQExEgIC8iD+pOV0X+o19kgfmN1iHE8KAJhkxaZERoJqQTUe/AetguSJh?=
 =?us-ascii?Q?G+K9P2JPtIWbcKFtdwbzrruzkD/a43HHW9JzYBvX4t1qw3Dt4nZbZaf4kxJ+?=
 =?us-ascii?Q?mm9TCbLu6BwPt7jsSnkIcOCBDoJ03byBSqbd5fW3ttsUmT2fYbqr/ZRpo4TA?=
 =?us-ascii?Q?YH1sA6UqStW3VA8tWTmT8aauXkWGQrhfXk+EvNkSsSDhyRIqABPQ5quj+T2j?=
 =?us-ascii?Q?hLbuM8Q3jpItWslbPeI6esZaRQrnoStFlGaDa+OHlOfUxKe5gf2th6hxmujH?=
 =?us-ascii?Q?lWLTTTcmI2e81qGNhMnppplV71i44/0A3oCiO4LYl6onxNasIRlTvKZ/sk7d?=
 =?us-ascii?Q?I3FCkL+HkVYthtxfh2TthUiAghuyts0EhwE69H5/BSTM7tBRNlf+TZD8e3w5?=
 =?us-ascii?Q?9QSn3JjWqeO3wzq2M2EjFCjJ+0LC5pncB0wjxAJrw+CAI6Dky1RkGmxhcWbq?=
 =?us-ascii?Q?P21eHaDJjk9yTatHpcUpthTSFneapgQ0GBKo3cuMwutrGaVOP4RG2DtBbf8f?=
 =?us-ascii?Q?uYnRkrLS19r6OuPPQDohOfG0AkNRRSlwUYGjJHVVq2WCbuNhiQQEoDTLvlZo?=
 =?us-ascii?Q?5qcBF41LeQfVlhLhYpJdjIkVE43pj3XfDQcxN09I38JzID7RBL+0RWd028vs?=
 =?us-ascii?Q?a4LSED9qH6LF+91Cqw+yZCTclYHAijc/rw1JDNDdpH9YiVsT3tDDv3OJ2psx?=
 =?us-ascii?Q?inM2q1MSebUYukqOksSOp1XHVbqcoEOtZ2DLSV+8EsvyCgU8i92QbuAjpL+l?=
 =?us-ascii?Q?xChpxDmCZcoP+ek3NOVWJ+xlfvzIfeIg90r9DycGvv3BpPlpKJ/B2VU+phHR?=
 =?us-ascii?Q?JWavPxnY/PavB/Dv8XrOlNtQ/aqVwJuGgVRTD+9lId6kTgTzmef7B2rLn/A+?=
 =?us-ascii?Q?uAQ+Y84dXiG+y7ZLA3AxvGJbgdSBM7dzM1rFk5wKP85FjYPKjmyGt3El1A8C?=
 =?us-ascii?Q?I/JXtTXwf+FeQZjweuqDsGQ6omdtQu0=3D?=
X-Exchange-RoutingPolicyChecked: zSNkD5TfvZs+sG5jWWEP0zLWlqYyw+Es7f19vgRCAW5ly0l/RaeGzAZ+pzp8SF1mkaaTX9X+cpbOWNvM9GjnRmakVFaT9hzRNFAWuPoHQtEw9EXxYf77qG+7ABDywVuDRdSRzcgGIHNKSalRCXSjN5+Hjs7k+HhMKjKIalWVOgyrZr/wD+wBD1AGTax/hILmfjasXkRPF3EzL/VwLm/kpzWXvpannsDwsptADc0fa0sv1P3knr0u9rETmw1w+xULS8STAhN0y3JbWZGeGBa18N2vEv2RaZYTRI0NuLweU1aDXzlBg5r4En//j6WG3uMbMWvPTOrf59tfWf4nLU4tkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c48ae997-f83f-4892-94cc-08df28cab356
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:38:36.9435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqWG9IVxFU6yKwMKfkihx8tRkgEe+9so+Lg/9Ckz6z4SK8I+LxNJTZ6AWAtwRRkriOXMSfzYTJpGCrM+CdmLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
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

On Mon, Oct 12, 2026 at 06:06:12PM -0700, Niranjana Vishwanathapura wrote:
> Detecting that a PRIME dma-buf being imported was exported by the same
> DRM device is a pattern currently open-coded in many drivers (compare
> dma_buf->ops against the driver's own ops, check obj->dev == dev, then
> return the GEM object with an extra reference). This series adds generic
> helpers for it and converts several drivers to use them.
> 
> Patch 1 adds drm_gem_prime_self_import(dev, dma_buf, ops): for a dma-buf
> self-exported via the given ops, it returns the backing GEM object with
> a reference, letting a driver short-circuit the generic PRIME import and
> skip the extra dma-buf file reference. Patch 2 converts Xe to it.
> 
> Patch 3 adds drm_gem_prime_dma_buf_to_gem(), a thin wrapper that uses the
> core PRIME ops, and replaces the drm_gem_is_prime_exported_dma_buf() bool
> predicate with it so the shmem importer resolves the object directly
> (the sole caller already wanted the referenced object).
> 
> Patches 4-6 convert panthor, panfrost and amdgpu to
> drm_gem_prime_self_import(), removing the duplicated open-coded checks.
> 
> No intended functional change.
> 
> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> 
> Farah Kassabri (2):
>   drm/gem: add helper to detect self-imported PRIME dma-bufs
>   drm/xe/dma-buf: Use drm helper to detect dma-buf self-import
> 
> Niranjana Vishwanathapura (4):
>   drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper

For the other driver patches:

Acked-by: Matthew Brost <matthew.brost@intel.com>

I'll leave the RB's to individual maintainers.

>   drm/panthor: use drm_gem_prime_self_import() helper
>   drm/panfrost: use drm_gem_prime_self_import() helper
>   drm/amdgpu: use drm_gem_prime_self_import() helper
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +---
>  drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 ++--
>  drivers/gpu/drm/drm_prime.c                 | 74 +++++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 +--
>  drivers/gpu/drm/panthor/panthor_gem.c       | 10 +--
>  drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++---
>  drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
>  include/drm/drm_prime.h                     |  8 ++-
>  8 files changed, 91 insertions(+), 64 deletions(-)
> 
> -- 
> 2.43.0
> 
