Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5FEC982D9
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C21210F060;
	Thu, 17 Sep 2026 18:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jiUb3T6K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5F210F05F;
 Thu, 17 Sep 2026 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789669877; x=1821205877;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=z9NgA413IGkOMzv7ysTOQ2RuxWdZMSf77GhYbpKK+yA=;
 b=jiUb3T6KL9R+gxiVG3u1mVMdrOyI0vXpyU6HevI1uRtKV+4YBs4ayaTX
 x8SAeg2PfbTI2PFgr7LoUSE8CFUNM84gTw0BiVme6LBrb5EmsKKFzruR4
 3B+9TtrGeW517jEoRYJ3wGhhgMEqAzimBk7/hBJ/k2Wm0HTk+yUhsucFw
 pq03WLn1KtKPOx7z2L5ebyj8S5Ra9w32miqXCMkere8j8B/7d1Z4VfT1a
 rM7yfrp6yd45/QhHvTNezN8OEzP1lnXAbWgBg5ScDDrIJuiva7ZUR2cGt
 btzBCxMoVqal79x/APQxgNcPyE3qDxxFna01vjtpZWQTqxkdNQlEiAfsw w==;
X-CSE-ConnectionGUID: 73HXGMzDS5qHnj+Gwv0ewg==
X-CSE-MsgGUID: fiIXF7KjSJapJhIOeu0Avw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="635522"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="635522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 11:31:15 -0700
X-CSE-ConnectionGUID: mnqpiX8LQ7SX5Yh902SnGA==
X-CSE-MsgGUID: IvkXgMtmTZmHuaTuCnyM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271304270"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 11:31:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:31:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:31:14 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4cs6URNWyBSoROKuBov3EtnaoX7unqG7X5PeKZFBJZqTi1gMbZ9yCrewl6YiW8GhBp0yOirULHQqlkRwhKar8uZ2Nq7qikFr6b5hn9cx2zloTGVo5YEm9DCeiYrfRRSQDBeukHQ8ynKCM8NUU6jlb07DNMsHedPfH7s2ya9VlbO/tEz8E8tR74f70wE3gW6O+FbvVCoD82cWYIEKGb9ok0KZZ0uoHZcye5g/HGJSxxHEWwp3QPMKM75RcXOONE2jLU5ZINUDXEuwK5/caI3bMl53PLqiZVYeGkMlJ9jMTVRD7oYJPC8jBdNRQlpzohyr6oyufM4yzScUupa0EcifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG9kayfvjl8m3o3cFHy/QDRLE3URiFW4iElSsofUpKM=;
 b=wh3Hs8gv68u7pMDR+S7Pb5/f/aCQaivZ4KHSckjh/QBstZ0sVyIzcrB7pmilsGRcc1uH0zpe3Mw+kJ5P559pK2GCZykav36KUkdhDHRMRaz7P1W/t4vP0zgMcWqsMwUOfjomRBaxJPtdWDmqEgI/t9cQANTtIX8SVXOd1hY50CMMjKQacOenOKjAUFZ9hfB8VPc7CHrx90NzwgmFg2ro7NJYU6xp4S0uthRmRTLxrEQr1iG+WkQegbI80PITRNAYZLKxmUtO+EWj01u7n+qegR9x4c2/iM2S+BdgdPj4TSD8BqtRngOj5NjEpGmbJOvc0pTGfHiwt9nAl1KuCC/u7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:31:08 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:31:08 +0000
Date: Thu, 17 Sep 2026 11:31:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 10/11] drm/gem: Use dynamic allocation for GEM object
 dma_resv
Message-ID: <aqwx6hfbD+LsNy/3@gsse-cloud1.jf.intel.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
 <20260903134408.105317-11-christian.koenig@amd.com>
 <aqId4079/mXgWMgh@gsse-cloud1.jf.intel.com>
 <05684d1e-1785-4166-aa26-e11b17c3c9e0@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05684d1e-1785-4166-aa26-e11b17c3c9e0@amd.com>
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f32ca5-8f1f-4a0a-2aef-08df14e9d777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Jwj3Ury3acMNNZJO6HcSbhp5gbCgzHGQlqRuWdq36/HKg5Fnd/oL22dPGtCURF/bsLQxepV7qVoRJZB5Hi7SKnL8dMPkNkcOB0Kb+Z0DOHgW8AcxXup9xR+wFqrPA28ypbKQz4hcCyNrA3BD0rvulbIQegUZYZqO8RtXExaMLA2N/kEQpV5zCtbSSd2J9rnb3GzvyxGKkvjgwAt0CK82ZaKc5TzmrwNVHHPjk2AgjrTQ340YMk51hl4RjzuydOq5B+HgJuye1VQhr7x1Zrrdbjx0JXnlslLJrtO+SmtSTYPkbsr5fKv2NZyxZN4ppWQ/iUCQdZZiJX8DQ4tY+L8jO2FfWizvOZCpQeMx+XCxk8FEtTHAtuvKq23NVCHuIeNpGlNExPSCkRpaKU7HCncIFBHrWD5p8NC5WF5D7CDIGxJYdXRa76Us82hezGK7lSdJU/MA+zhdiGMrQWediA4qoRtVRwprjrSUQSOyYfDEyEti4e1B9EtaD0dNW5ezgZ3ADMTDwqhgHQNwDCvHQnFqPr8RAWsKtgGwwY9JGs3rVwDIGept4Nbmy0jA+XGLGRZxLSQO7JBE1g7q00W98ub5fmG2xf0an/EXFRE21F27fKAaMTRRA63W4Hqy920uO5vWVTEivktMoYRAcfZa7hoVBfhofqBlJg7lP00T1oROBh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qYe2+UxEfOyoxBKtERvKYFN/L7HQxxTZUfNhCFQzuUxOtykpeASHDtJHHs?=
 =?iso-8859-1?Q?/QxN+UZlN4P6aW1FKwygmAWbcLBV9EDZGNLrgatSOQevwivMxi0dyHWIBb?=
 =?iso-8859-1?Q?ASm78yO4CYd6kKYkpALYITJF6AC+rt8tmrXzPIUYgv2aYTuN8BE5TKT3Y3?=
 =?iso-8859-1?Q?T0MV97WfFpC3L1O94L0DGTQX+o6p+oRCwZs7iPvibEn+IwDucUtbF00Vle?=
 =?iso-8859-1?Q?3Yz4Z94KBqLXKXR+bYGMfagECMm0Ml+PNN3efhr4z7E3dJUSDlury+PgzC?=
 =?iso-8859-1?Q?DEKWNtmq3mTkDKqs++NzVGWt38RpAmuZBJ6n2l3goZfx94ufFpcpgt6wB6?=
 =?iso-8859-1?Q?naH13EM8EfYwVE+QSz+cIBjewgcQ6E14McKZi3pSjnh8bq3+bhKJKDzMoJ?=
 =?iso-8859-1?Q?uJaTOeGvraE6mExMroe7bmftu+Qvz3p4HnIzAKOqLkW07vhL7R7tHWBvxw?=
 =?iso-8859-1?Q?Yhlos/3llqorWY0S9rcPX5xdHxR4CQApv+gWAdFX5QPFeLLqtamJqqjbdI?=
 =?iso-8859-1?Q?k5jEZMOQ8LYrlla5MtFDA3GaB/b/XOWeg8kU9RMUpjS5pMAGPzZQibZuhj?=
 =?iso-8859-1?Q?ZT/ZW2oNTbCjtc1W5YHyasdB2YgnNicn0MtdHz/SC/EPNHVGvB57TXslll?=
 =?iso-8859-1?Q?lCx/HamIjnZommQXKg2kGmSQtGxFeavIW9p0Cz/QLG6W/10Uj8a070j+E2?=
 =?iso-8859-1?Q?4GvUPuE3xPax1vemWcwrkOrhHcP0u1ufTaNZZKydPz7jzz/BcnMrdWO2w+?=
 =?iso-8859-1?Q?K/YIhzYheeghxd1KOXVD6lmZdAOnt9NF7rfBaTCt554xTVXV1M+JwBhV6L?=
 =?iso-8859-1?Q?GGZEDpTihKIbRQHvN58I0Ox1BEBW4XIutfx9F8B9m9PUg6ZsY0Q5gWKlyE?=
 =?iso-8859-1?Q?DHbtQMxO2csruVpCee2qCYLd2AzVKtUNyJFHxxosg3fNdI2+90koZyo9bH?=
 =?iso-8859-1?Q?92rD9yGG2GZ8zH6/3t7a5lPWBwJFfQlg6GrbymU79xOUySNWu1OAY5vZGE?=
 =?iso-8859-1?Q?wEpYr9o+9b2X9T0Zkn7ZB3V1JXr/qeAp3Wh/KRLNWsyVZCQBf8jLg3o4hF?=
 =?iso-8859-1?Q?rscFNP366HCP3mrZDcRvprueDSyFImSJfs+hnXrEPAYoRWf4zkUM5RmdJl?=
 =?iso-8859-1?Q?dgFncD6ZwQbNNC2htJYNFbUa7Fnnsc60QnP8DLw1NIW1s92h323GjTNV+4?=
 =?iso-8859-1?Q?ZOh7+SSK/X+MfXDrf+EB/Fd7LT/WynhUdMjVTmFf4G3p7t2CpRON6VdBkx?=
 =?iso-8859-1?Q?mLHPG3LoNsWQg3NpkEw0S+UcdLibsJjmHpoX5/p0wjzHckQLH88Y3b1lYY?=
 =?iso-8859-1?Q?DbZHs2LBnYXRfhu1xazFnuKqlzP1gWicGH/hTmz/hGPoTogSAn6Yve25ay?=
 =?iso-8859-1?Q?q46YLweEJJAfX014XgtCRUZHQ/FKVZ+3tQrILg1xlyAtYp2gnhHCLGsDW0?=
 =?iso-8859-1?Q?kLHDuPsxn3ZJrOVaEVHRpvkh7WtQfCi7f5z3C61R6e78QzRCbIBbR4I6VW?=
 =?iso-8859-1?Q?DYnr338yPKlA6xj6vcMVq2UtqpdxVEpNFn7OTQXoFZ9NqKhTPdSXX7C4Xl?=
 =?iso-8859-1?Q?Ekp/jCdrskIsjXK8tFd0Kxcs/L9nNHKdTPCRJ8LdqVbc4okg5DtOPPHH0N?=
 =?iso-8859-1?Q?FK5eXkALJcr5KxnrSFEqmuIYzvn7UfdsiXwOhck1oSqy7WghtpFvtf7fot?=
 =?iso-8859-1?Q?4RNlchOSibMT2KlUOPAWDGxx83ckpV/rEzmZo6qccVSF1YH+krDwLm4tpV?=
 =?iso-8859-1?Q?tJzde1/9e/MaOx3ahjGZ252bQ/1r4Dp1RSLSbFG1MOw7Qv4vgtU4kt8M6v?=
 =?iso-8859-1?Q?tXe/7AUNOw=3D=3D?=
X-Exchange-RoutingPolicyChecked: jIfzwSrubTOA/A/7arls7a0nuAxcqwyMavSiXWAdN6qWGOL4OhaDVVvJrEkEUjRO9SUfTvsb/jy0nRuKBjr31iZja4nYiTJzTUeok/DIeA7fncC8y4Vozt7nR9xEdQIbGcyZGkpgqAaLuXrXm0QhsvusSYttPUGVTXrfM1ev8X0XmW2od/OOOwHbYlcErIDDD9hDCMy6Ad8UTrDg1DZXZVR6VgB/K5v3zLFEuYL3rCL9ttO9QV/Nc6HTndKrvtNk4JRvoVyPq0i/z2GrdaMaNNHBIBWYQV24xUA/aKsIE5p5yx1a3/U5yH1r296nJJ4iSo0PPlTn+FjhB8CPgyIQ/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f32ca5-8f1f-4a0a-2aef-08df14e9d777
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:31:08.6832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czWD5kUjs5+vFOzDg0BsR654DDQBYbrEb9LWQ0+sjGLOtjNnSl7V42SNyb0HvqEm+66hs3p3+Qxt8QY2WXODTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
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

On Thu, Sep 17, 2026 at 08:19:50PM +0200, Christian König wrote:
> 
> 
> On 9/10/26 05:02, Matthew Brost wrote:
> > On Thu, Sep 03, 2026 at 03:28:05PM +0200, Christian König wrote:
> >> Remove the embedded dma_resv (_resv) from struct drm_gem_object and use
> >> dynamically allocated reservations instead. This change aligns with the
> >> new reference counted dma_resv infrastructure and reduces the size of
> >> drm_gem_object.
> >>
> >> In drm_gem_private_object_init(), when no external resv is provided,
> >> allocate a new dma_resv using dma_resv_alloc() instead of initializing
> >> the embedded _resv field. This allows proper error handling if the
> >> allocation fails, returning -ENOMEM to the caller.
> >>
> >> The corresponding cleanup in drm_gem_private_object_fini() is simplified
> >> to only put the resv pointer, removing the redundant put on _resv.
> >>
> >> For TTM buffer objects, add an individual_resv field to track the
> >> dynamically allocated reservation object for proper cleanup during
> >> destruction. This ensures we can distinguish between shared and
> >> individual reservations when freeing resources.
> >>
> >> This change builds on the previous work to make drm_gem_private_object_init()
> >> return an error code, now utilizing that capability to handle allocation
> >> failures properly.
> >>
> >> Signed-off-by: Christian König <christian.koenig@amd.com>
> >> Assisted-by: Claude:Sonnet 4
> >> ---
> >>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 12 ++---
> >>  drivers/gpu/drm/drm_gem.c                     |  9 ++--
> >>  drivers/gpu/drm/i915/gem/i915_gem_object.c    |  1 -
> >>  drivers/gpu/drm/nouveau/nouveau_bo.c          |  3 --
> >>  .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
> >>  drivers/gpu/drm/ttm/ttm_bo.c                  | 26 ++++++-----
> >>  drivers/gpu/drm/ttm/ttm_bo_util.c             | 44 +++++++++++++------
> >>  drivers/gpu/drm/xe/xe_bo.c                    |  8 ++--
> >>  include/drm/drm_gem.h                         |  9 ----
> >>  include/drm/ttm/ttm_bo.h                      |  2 +
> >>  11 files changed, 65 insertions(+), 53 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >> index 20831dbebc31..a168083edab2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >> @@ -397,7 +397,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
> >>   */
> >>  void amdgpu_amdkfd_remove_all_eviction_fences(struct amdgpu_bo *bo)
> >>  {
> >> -	struct dma_resv *resv = &bo->tbo.base._resv;
> >> +	struct dma_resv *resv = bo->tbo.individual_resv;
> >>  	struct dma_fence *fence, *stub;
> >>  	struct dma_resv_iter cursor;
> >>  
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> index 6c5182d54f7d..026821f6da7c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> @@ -1319,7 +1319,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
> >>  	 * So when this locking here fails something is wrong with the reference
> >>  	 * counting.
> >>  	 */
> >> -	if (WARN_ON_ONCE(!dma_resv_trylock(&bo->base._resv)))
> >> +	if (WARN_ON_ONCE(!dma_resv_trylock(bo->individual_resv)))
> >>  		return;
> >>  
> >>  	amdgpu_amdkfd_remove_all_eviction_fences(abo);
> >> @@ -1329,22 +1329,22 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
> >>  	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
> >>  		goto out;
> >>  
> >> -	r = dma_resv_reserve_fences(&bo->base._resv, 1);
> >> +	r = dma_resv_reserve_fences(bo->individual_resv, 1);
> >>  	if (r)
> >>  		goto out;
> >>  
> >>  	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
> >> -				    abo, &bo->base._resv, &fence,
> >> -				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
> >> +				    abo, bo->individual_resv, &fence, false,
> >> +				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
> >>  	if (WARN_ON(r))
> >>  		goto out;
> >>  
> >>  	amdgpu_vram_mgr_set_cleared(bo->resource);
> >> -	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
> >> +	dma_resv_add_fence(bo->individual_resv, fence, DMA_RESV_USAGE_KERNEL);
> >>  	dma_fence_put(fence);
> >>  
> >>  out:
> >> -	dma_resv_unlock(&bo->base._resv);
> >> +	dma_resv_unlock(bo->individual_resv);
> >>  }
> >>  
> >>  /**
> >> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> >> index d2ce18bbddea..480391df556d 100644
> >> --- a/drivers/gpu/drm/drm_gem.c
> >> +++ b/drivers/gpu/drm/drm_gem.c
> >> @@ -235,9 +235,11 @@ int drm_gem_private_object_init(struct drm_device *dev,
> >>  	obj->handle_count = 0;
> >>  	obj->size = size;
> >>  	mutex_init(&obj->gpuva.lock);
> >> -	dma_resv_init(&obj->_resv);
> >> -	if (!obj->resv)
> >> -		obj->resv = dma_resv_get(&obj->_resv);
> >> +	if (!obj->resv) {
> >> +		obj->resv = dma_resv_alloc();
> >> +		if (!obj->resv)
> >> +			return -ENOMEM;
> >> +	}
> >>  
> >>  	drm_gem_gpuva_init(obj);
> >>  
> >> @@ -259,7 +261,6 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
> >>  	WARN_ON(obj->dma_buf);
> >>  
> >>  	dma_resv_put(obj->resv);
> >> -	dma_resv_put(&obj->_resv);
> >>  	mutex_destroy(&obj->gpuva.lock);
> >>  }
> >>  EXPORT_SYMBOL(drm_gem_private_object_fini);
> >> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> >> index 3f37b0cbb70f..1c73f15d0315 100644
> >> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> >> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> >> @@ -90,7 +90,6 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
> >>  void i915_gem_object_free(struct drm_i915_gem_object *obj)
> >>  {
> >>  	dma_resv_put(obj->base.resv);
> >> -	dma_resv_put(&obj->base._resv);
> >>  	return kmem_cache_free(slab_objects, obj);
> >>  }
> >>  
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> index 67c9d32f4f27..65e1f0c2f984 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> @@ -159,8 +159,6 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
> >>  			drm_gem_object_put(nvbo->r_obj);
> >>  
> >>  		drm_gem_object_release(&bo->base);
> >> -	} else {
> >> -		dma_resv_put(&bo->base._resv);
> >>  	}
> >>  
> >>  	kfree(nvbo);
> >> @@ -385,7 +383,6 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
> >>  		return PTR_ERR(nvbo);
> >>  
> >>  	nvbo->bo.base.size = size;
> >> -	dma_resv_init(&nvbo->bo.base._resv);
> >>  	drm_vma_node_reset(&nvbo->bo.base.vma_node);
> >>  
> >>  	/* This must be called before ttm_bo_init_reserved(). Subsequent
> >> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >> index e0ecadccccf8..4559352e7115 100644
> >> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> >> @@ -640,7 +640,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
> >>  	KUNIT_EXPECT_EQ(test, ctx.bytes_moved, 0);
> >>  
> >>  	if (bo->type != ttm_bo_type_sg)
> >> -		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->base._resv);
> >> +		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->individual_resv);
> >>  
> >>  	/* Make sure we have an idle object at this point */
> >>  	dma_resv_wait_timeout(bo->base.resv, usage, false, MAX_SCHEDULE_TIMEOUT);
> >> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> >> index 999c24251fb7..ecb5f55a0dd1 100644
> >> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> >> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> >> @@ -193,13 +193,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
> >>  {
> >>  	int r;
> >>  
> >> -	if (bo->base.resv == &bo->base._resv)
> >> +	if (bo->base.resv == bo->individual_resv)
> >>  		return 0;
> >>  
> >> -	BUG_ON(!dma_resv_trylock(&bo->base._resv));
> >> +	BUG_ON(!dma_resv_trylock(bo->individual_resv));
> >>  
> >> -	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
> >> -	dma_resv_unlock(&bo->base._resv);
> >> +	r = dma_resv_copy_fences(bo->individual_resv, bo->base.resv);
> >> +	dma_resv_unlock(bo->individual_resv);
> >>  	if (r)
> >>  		return r;
> >>  
> >> @@ -209,7 +209,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
> >>  		 * the resv object while holding the lru_lock.
> >>  		 */
> >>  		spin_lock(&bo->bdev->lru_lock);
> >> -		drm_gem_object_set_resv(&bo->base, &bo->base._resv);
> >> +		drm_gem_object_set_resv(&bo->base, bo->individual_resv);
> >>  		spin_unlock(&bo->bdev->lru_lock);
> >>  	}
> >>  
> >> @@ -218,7 +218,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
> >>  
> >>  static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
> >>  {
> >> -	struct dma_resv *resv = &bo->base._resv;
> >> +	struct dma_resv *resv = bo->individual_resv;
> >>  	struct dma_resv_iter cursor;
> >>  	struct dma_fence *fence;
> >>  
> >> @@ -238,8 +238,8 @@ static void ttm_bo_delayed_delete(struct work_struct *work)
> >>  
> >>  	bo = container_of(work, typeof(*bo), delayed_delete);
> >>  
> >> -	dma_resv_wait_timeout(&bo->base._resv, DMA_RESV_USAGE_BOOKKEEP, false,
> >> -			      MAX_SCHEDULE_TIMEOUT);
> >> +	dma_resv_wait_timeout(bo->individual_resv, DMA_RESV_USAGE_BOOKKEEP,
> >> +			      false, MAX_SCHEDULE_TIMEOUT);
> >>  	dma_resv_lock(bo->base.resv, NULL);
> >>  	ttm_bo_cleanup_memtype_use(bo);
> >>  	dma_resv_unlock(bo->base.resv);
> >> @@ -273,7 +273,7 @@ static void ttm_bo_release(struct kref *kref)
> >>  		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
> >>  		ttm_mem_io_free(bdev, bo->resource);
> >>  
> >> -		if (!dma_resv_test_signaled(&bo->base._resv,
> >> +		if (!dma_resv_test_signaled(bo->individual_resv,
> >>  					    DMA_RESV_USAGE_BOOKKEEP) ||
> >>  		    (want_init_on_free() && (bo->ttm != NULL)) ||
> >>  		    bo->type == ttm_bo_type_sg ||
> >> @@ -316,6 +316,8 @@ static void ttm_bo_release(struct kref *kref)
> >>  	}
> >>  
> >>  	atomic_dec(&ttm_glob.bo_count);
> >> +	dma_resv_put(bo->individual_resv);
> >> +	bo->individual_resv = NULL;
> > 
> > individual_resv is set to NULL.
> > 
> >>  	bo->destroy(bo);
> > 
> > vfunc ->destroy() called and this the only call site.
> > 
> >>  }
> >>  
> >> @@ -1197,7 +1199,11 @@ int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
> >>  	bo->pin_count = 0;
> >>  	bo->sg = sg;
> >>  	bo->bulk_move = NULL;
> >> -	drm_gem_object_set_resv(&bo->base, resv ?: &bo->base._resv);
> >> +
> >> +	/* Save the original resv object before overwriting it */
> >> +	bo->individual_resv = dma_resv_get(bo->base.resv);
> >> +	if (resv)
> >> +		drm_gem_object_set_resv(&bo->base, resv);
> >>  	atomic_inc(&ttm_glob.bo_count);
> >>  
> >>  	/*
> >> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> >> index e080ce60933e..e39448a5015e 100644
> >> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> >> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> >> @@ -208,7 +208,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
> > 
> > This is the vfunc ->destroy() for transfer destroys.
> > 
> >>  
> >>  	fbo = container_of(bo, struct ttm_transfer_obj, base);
> >>  	dma_resv_put(fbo->base.base.resv);
> >> -	dma_resv_put(&fbo->base.base._resv);
> >> +	dma_resv_put(fbo->base.individual_resv);
> > 
> > fbo->base.individual_resv should always be NULL per above comments.
> > 
> > Not functionally incorrect as dma_resv_put has a NULL check, but this
> > confused me in my analysis of the refcounting.
> > 
> > Can we either delete this or WARN_ON_ONCE(fbo->base.individual_resv) to
> > future proof this?
> 
> Good point, I just though better save than sorry here but that is indeed not needed.
> 
> Any other comments/reviews on that series? If not I'm going to send it out once more to a wider audience.
> 

Overall, this looks good to me, and it actually addresses a couple of
memory-safety issues in Xe by ensuring that the shared dma-resv does not
disappear underneath BOs that are sharing the VM's dma-resv. Once this
lands, I think we can drop those workarounds.

Getting all the way through this review is still on my backlog, but I'll
try to finish it over the next couple of days.

In the meantime, I would resend the series so Sashiko can take another
run at it. For some reason, the latest version didn'tt get a Sashiko
run. Sashiko is very good at spotting memory-safety issues, and if
the review comes back reasonably clean, I would lean toward merging the
next revision and if there is any fallout in bugs we will have several
months to close on any issues before it gets into a release.

Matt

> Thanks,
> Christian.
> 
> > 
> > Otherwise Xe, TTM, and DRM changes LGTM.
> > 
> > Matt
> > 
> >>  	ttm_bo_put(fbo->bo);
> >>  	kfree(fbo);
> >>  }
> >> @@ -238,12 +238,23 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
> >>  	if (!fbo)
> >>  		return -ENOMEM;
> >>  
> >> -	fbo->base = *bo;
> >>  
> >>  	/**
> >>  	 * Fix up members that we shouldn't copy directly:
> >>  	 * TODO: Explicit member copy would probably be better here.
> >>  	 */
> >> +	fbo->base = *bo;
> >> +
> >> +	fbo->base.individual_resv = dma_resv_alloc();
> >> +	if (!fbo->base.individual_resv) {
> >> +		ret = -ENOMEM;
> >> +		goto error_free;
> >> +	}
> >> +
> >> +	if (bo->type != ttm_bo_type_sg)
> >> +		fbo->base.base.resv = dma_resv_get(fbo->base.individual_resv);
> >> +	else
> >> +		dma_resv_get(fbo->base.base.resv);
> >>  
> >>  	atomic_inc(&ttm_glob.bo_count);
> >>  	drm_vma_node_reset(&fbo->base.base.vma_node);
> >> @@ -251,19 +262,16 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
> >>  	kref_init(&fbo->base.kref);
> >>  	fbo->base.destroy = &ttm_transfered_destroy;
> >>  	fbo->base.pin_count = 0;
> >> -	if (bo->type != ttm_bo_type_sg)
> >> -		fbo->base.base.resv = &fbo->base.base._resv;
> >>  
> >> -	dma_resv_init(&fbo->base.base._resv);
> >>  	fbo->base.base.dev = NULL;
> >> -	ret = dma_resv_trylock(&fbo->base.base._resv);
> >> +	ret = dma_resv_trylock(fbo->base.individual_resv);
> >>  	WARN_ON(!ret);
> >>  
> >> -	ret = dma_resv_reserve_fences(&fbo->base.base._resv, TTM_NUM_MOVE_FENCES);
> >> +	ret = dma_resv_reserve_fences(fbo->base.individual_resv,
> >> +				      TTM_NUM_MOVE_FENCES);
> >>  	if (ret) {
> >> -		dma_resv_unlock(&fbo->base.base._resv);
> >> -		kfree(fbo);
> >> -		return ret;
> >> +		dma_resv_unlock(fbo->base.individual_resv);
> >> +		goto error_unref;
> >>  	}
> >>  
> >>  	if (fbo->base.resource) {
> >> @@ -281,6 +289,14 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
> >>  
> >>  	*new_obj = &fbo->base;
> >>  	return 0;
> >> +
> >> +error_unref:
> >> +	dma_resv_put(fbo->base.individual_resv);
> >> +	dma_resv_put(fbo->base.base.resv);
> >> +
> >> +error_free:
> >> +	kfree(fbo);
> >> +	return ret;
> >>  }
> >>  
> >>  /**
> >> @@ -618,7 +634,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	dma_resv_add_fence(&ghost_obj->base._resv, fence,
> >> +	dma_resv_add_fence(ghost_obj->individual_resv, fence,
> >>  			   DMA_RESV_USAGE_KERNEL);
> >>  
> >>  	/**
> >> @@ -632,7 +648,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> >>  	else
> >>  		bo->ttm = NULL;
> >>  
> >> -	dma_resv_unlock(&ghost_obj->base._resv);
> >> +	dma_resv_unlock(ghost_obj->individual_resv);
> >>  	ttm_bo_put(ghost_obj);
> >>  	return 0;
> >>  }
> >> @@ -802,14 +818,14 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
> >>  	if (ret)
> >>  		goto error_destroy_tt;
> >>  
> >> -	ret = dma_resv_copy_fences(&ghost->base._resv, bo->base.resv);
> >> +	ret = dma_resv_copy_fences(ghost->individual_resv, bo->base.resv);
> >>  	/* Last resort, wait for the BO to be idle when we are OOM */
> >>  	if (ret) {
> >>  		dma_resv_wait_timeout(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
> >>  				      false, MAX_SCHEDULE_TIMEOUT);
> >>  	}
> >>  
> >> -	dma_resv_unlock(&ghost->base._resv);
> >> +	dma_resv_unlock(ghost->individual_resv);
> >>  	ttm_bo_put(ghost);
> >>  	bo->ttm = ttm;
> >>  	return 0;
> >> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> >> index 6df7ef07ec0b..422fe4bddf00 100644
> >> --- a/drivers/gpu/drm/xe/xe_bo.c
> >> +++ b/drivers/gpu/drm/xe/xe_bo.c
> >> @@ -1660,7 +1660,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
> >>  	 * always succeed here, as long as we hold the lru lock.
> >>  	 */
> >>  	spin_lock(&ttm_bo->bdev->lru_lock);
> >> -	locked = dma_resv_trylock(&ttm_bo->base._resv);
> >> +	locked = dma_resv_trylock(ttm_bo->individual_resv);
> >>  	spin_unlock(&ttm_bo->bdev->lru_lock);
> >>  	xe_assert(xe, locked);
> >>  
> >> @@ -1689,14 +1689,14 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
> >>  	 * TODO: Don't do this for external bos once we scrub them after
> >>  	 * unbind.
> >>  	 */
> >> -	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
> >> +	dma_resv_for_each_fence(&cursor, ttm_bo->individual_resv,
> >>  				DMA_RESV_USAGE_BOOKKEEP, fence) {
> >>  		if (xe_fence_is_xe_preempt(fence) &&
> >>  		    !dma_fence_is_signaled(fence)) {
> >>  			if (!replacement)
> >>  				replacement = dma_fence_get_stub();
> >>  
> >> -			dma_resv_replace_fences(&ttm_bo->base._resv,
> >> +			dma_resv_replace_fences(ttm_bo->individual_resv,
> >>  						fence->context,
> >>  						replacement,
> >>  						DMA_RESV_USAGE_BOOKKEEP);
> >> @@ -1704,7 +1704,7 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
> >>  	}
> >>  	dma_fence_put(replacement);
> >>  
> >> -	dma_resv_unlock(&ttm_bo->base._resv);
> >> +	dma_resv_unlock(ttm_bo->individual_resv);
> >>  }
> >>  
> >>  static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
> >> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> >> index f889232e8525..8aed680bfca2 100644
> >> --- a/include/drm/drm_gem.h
> >> +++ b/include/drm/drm_gem.h
> >> @@ -385,15 +385,6 @@ struct drm_gem_object {
> >>  	 */
> >>  	struct dma_resv *resv;
> >>  
> >> -	/**
> >> -	 * @_resv:
> >> -	 *
> >> -	 * A reservation object for this GEM object.
> >> -	 *
> >> -	 * This is unused for imported GEM objects.
> >> -	 */
> >> -	struct dma_resv _resv;
> >> -
> >>  	/**
> >>  	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
> >>  	 *
> >> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> >> index 32791c4db2a9..f132caa9647f 100644
> >> --- a/include/drm/ttm/ttm_bo.h
> >> +++ b/include/drm/ttm/ttm_bo.h
> >> @@ -77,6 +77,7 @@ enum ttm_bo_type {
> >>   * @bdev: Pointer to the buffer object device structure.
> >>   * @type: The bo type.
> >>   * @page_alignment: Page alignment.
> >> + * @individual_resv: Individual resv for destruction
> >>   * @destroy: Destruction function. If NULL, kfree is used.
> >>   * @kref: Reference count of this buffer object. When this refcount reaches
> >>   * zero, the object is destroyed or put on the delayed delete list.
> >> @@ -107,6 +108,7 @@ struct ttm_buffer_object {
> >>  	struct ttm_device *bdev;
> >>  	enum ttm_bo_type type;
> >>  	uint32_t page_alignment;
> >> +	struct dma_resv *individual_resv;
> >>  	void (*destroy) (struct ttm_buffer_object *);
> >>  
> >>  	/*
> >> -- 
> >> 2.43.0
> >>
> 
