Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C17C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CABA10EEE8;
	Tue,  1 Sep 2026 19:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VD83drDH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7339A10EEE4;
 Tue,  1 Sep 2026 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788292679; x=1819828679;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HtYf75zePNU6dKJQO57aEpLHIbgttSzHjTp2Px+2kUY=;
 b=VD83drDHvdCqMEAgebGfAdv6Rjc4fOp68hsPgarefsPBPs0ZCCNA03bc
 t2Y7r3Mx7XjrCGMeeqrVULJhu/W4Wqc1ZFnB2JJSSqUAzzGrbQfk1bbMl
 /8SaMvlKF9wuZwORFfwWFW5pdWCzz5tCl6HN03LE6MOgbTPzCW55Qe4Ds
 8aOnhwi+d7jazCb6L8MqZJdVa/Oskg+X4k4dMLbfpo+FjhFsCJNzGS6aw
 BdLkaBZKcO70HoIzi/FVaZus1iTvwW5fhC1/gJFo6n3R9JUnmRiuFTAQU
 7THDNmIF06kP+SDbcamNnr+Qup6ZKsaCIrMvWRsmjNFHR+Jp7THjTDcMk g==;
X-CSE-ConnectionGUID: vdJhRtocQ++FGDdGJtX9yw==
X-CSE-MsgGUID: xopwpzGHTxKkUcRFVx2rbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106108735"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="106108735"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 12:57:58 -0700
X-CSE-ConnectionGUID: 9TJmbCWySSmRcHWB0ulBoA==
X-CSE-MsgGUID: efgcQNXdRPyflX5dHtzSIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="265952357"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 12:57:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 12:57:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 12:57:56 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 12:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGkVSdAej7xJj8SVU9RFZnfjWjpI+Je/rkH0h+lPf8SREBImNiNyAPsLx3kyKuU/q3s8KAZeEwZ13c2Y+ExdkiphWPi/rMbVDtW/Y7uNjc49piaCC8vqrSjo7wc4g1FMUHQqwMKpUm6zKaGkPwGa9u+OGytKcXnzidSUcQja0vWmg6sNgzyRj+Kj2/4scZJ4k41CDDAmCECTgt8Th1WCiJWDfcUKFr/A1G69tFlyEFBeP/VB6wDBkB0stQesnOZxYezv9ihpWoK8XJm93FE8AYUg+JnYIV5ZaJ50QjFeGEkeX9Wz4IOwA5XtM2t4xH7qaP8UxcLiKnsC3bhF5/BhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxBxXhpxV5LqBQ1cjb+Ym4qMdQcFrP0HWFv7SKrkqdE=;
 b=AKd9V0iqDSaCW/LGOeXWdD2WOoYKBTyLwVECpTj45Kvgwso90/pnpZGa7WSn9VIec9xp6WO/W4AYbWGkDVLxEyW8SElP78ElVoe7gyZrgdUwWyIsQj+mEjuskn3QwbGHaPh3Nffh/qInvEBjij2XkWlB81k1/o5mSHwaJDZxa+iiLw/mpbjwnP3MVa9oAsQGNruBD+wFcBNeVFzuonVN9o/qFXUSR/rw25BIWbik7LI+74NuC+p47OPUpC0Ko6ZlRSGGjuZwSia+gi0Xa/B5nj5pI/l6SNd5Wg99vJAosfebqmFlJVLEdysEnZIrN87/i9+2U+c1otIbJ9LDev2m9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:57:54 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:57:53 +0000
Date: Tue, 1 Sep 2026 12:57:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/4] drm/gpusvm: let drm_gpusvm_get_pages() map an
 array of pages
Message-ID: <apcuPwxjBs8HPv3x@gsse-cloud1.jf.intel.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-4-honghuan@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901090100.2024933-4-honghuan@amd.com>
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: eeaa976e-02bf-41c7-6a12-08df08634f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OkvSj7B6RPgjZpouyDdeAkg1Wr894Z3814HKF8BSCi73QyHIPEoAW9sNVFGWlmDK53Vc6WuqDJZPfKjoe5/kCDeO/8AhNZf9QhnTZF36I9padxL+yBiEj6Ix1gm4kF54KEmvQlzWz9X13xx7KE+++9E0CogZxoa0BVIGAWIrIPeuNJbZOFhiT9gXoIDhdkAnp0dXE+TQfChwerAI573T9oo7dm/j0WdNhuAwOrVhacgj0w+zwMYjgLibSpSUBPMllhpR1UMzRuc4q0v0jH6Heyp4bUujgp5sVpUm3xbCXe2sszHeIZ2VZYyvezZLBrwCJyyekswy4tcJeDMaIA5pYOiPxqomSVa4olH+en/nZE1PhqocFeMEQULl2jIkZDvJHldYGlf0bGvQ/TCuJcfmS9wkLfUb/nNNx3HyOdvTaGamU4SOZMPJ6HXfbIMjUWRDWZ3i7U/0atR696l5XuhbanaF2c7xpVqc8wmUiYgNvGBwt9YNdrMoogw6N+8GjoYdtEObnt7PExCSdgoD+KH2MOBqzYfjLB8Bz4VyPNt+jdnRXRdpxvqp6RN6MaK+TulcDmZ+Q1lnDVdnmI1t1dPoDV6uf2QXAOJUGcR4HvvPnsvSBzDbzh1EevkOluMk8EKkTh4ToMA0CW2nu+Z2dApHe1j8xjcW1QAlQ4/Nh2r6cxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0XcLdXjSaGeUuaKNYtdPgs4gXkmtwuAaxJ9C3dSpKTKmS2r6inab84YOr+?=
 =?iso-8859-1?Q?FnRAAPO/87jWS22k4oLgFqo0Gh3DwVwdi8AOeSElbb0of/7uqc2Lyux9FD?=
 =?iso-8859-1?Q?4h/rONnUmzkEHqm9NcD7KaOBL3c8EB29ytW1geb5bwVuqGVsIgxcU8+AXR?=
 =?iso-8859-1?Q?k6LPn698yBCASl/qjPhCWfzaoa6Xlac9ciPRCAupGMhWVMi4B2woB7MSKy?=
 =?iso-8859-1?Q?oIZGE3QIOHuSSWQi0yjMhmYwnma/yWGV1Bf2VgXiUgDrDeqsf5KOt96BQ1?=
 =?iso-8859-1?Q?1kALGpAQP2NFGDTqN2Dcw81dlb7kUMw4Oxph9OAZoepvfS2TVvlCdD4S/a?=
 =?iso-8859-1?Q?gXvl02hZjVUr9hSQd9K9pCKx96BkQsSBDOwz+Xae7hiWR+TwqZOnS/B0Tw?=
 =?iso-8859-1?Q?ja0xIwZz/srEYM3oCqAE7eRQCoHfviJS/DU6uQU548uuTyZwlTiwItGPCH?=
 =?iso-8859-1?Q?hxo/OpFRpAXZidwShDtnyyk9ocCYX3/kLGwd45LH5I0eMg232rQN7bSYxT?=
 =?iso-8859-1?Q?l8tUgqxYURc4MJv3BSjV3uJJnuwUJiAHa/jkGQ6+JQLzojXd1she5FWfjw?=
 =?iso-8859-1?Q?c00zgtELwdnYaKblysurF5nKNK6tcptViq3BL5+nNgsQ9fn7F2Xsuihent?=
 =?iso-8859-1?Q?8Pq2Xmco4X3euQXYY+8MAL7oj6/X3TSl00vMGMOnpEDkv2T13iZjchxmjc?=
 =?iso-8859-1?Q?DBeviS52s9KQ7HgYdJWm+oqmDU8i1E4nFUrXtWqnYa5qy/ICC5x+lJjJ7E?=
 =?iso-8859-1?Q?NLj4LHPPrAW6Vs++NPCRx+3zROWYbk/UrTW3bkJpF1+j549/iip44uo5vK?=
 =?iso-8859-1?Q?36EaPokEmb6YtxrEYAcdKmN81ihBLYICWf91PN7YNwBR7gwDID98WnxqXG?=
 =?iso-8859-1?Q?Ppd/TezneJ6Qk8yAqkQ1NZaxGdIabz6O6MYnDTU2MBvTKLC56O7kDxGL5r?=
 =?iso-8859-1?Q?fTqnR5wiHmTrLZ9q+k/3YX+My75LrUxRoCr+7y3xcNaRrsXdxlfSsk55YL?=
 =?iso-8859-1?Q?IX0s1gnC9eCkL2AgFtHigNMYwpwWCFNPG2NboZDNRJuijzmYE6uVHgMBzq?=
 =?iso-8859-1?Q?8oeXK9RcLFyanAswDQM5DQDPkl32DZqP1w+NRpxCIYYEoPBrE+XBGPllm5?=
 =?iso-8859-1?Q?q0oTTp84/jk3XWh/iSVT1z6qseoqvSF7Szi/3W1jMUAuyhlSX5b+vHexyD?=
 =?iso-8859-1?Q?cE9XP+D8dlW3kEk9EMI/Fn+DinCNRhi2+Y7qJyFRt4sNKBQmOcekQTukOw?=
 =?iso-8859-1?Q?CWS25Pf0xJE8T6mP3vx4GWmJjZ0XCwhuyjFWz25tx0Q7hLJRgswvvVVL+N?=
 =?iso-8859-1?Q?nupz1ASqu5Ha74up799H5Xv9BYDH4WTfcEi/MzvYE0hcszZzNBBrd770B2?=
 =?iso-8859-1?Q?bVe6h2qm163Hcb1Rzb/M4tKVxx5PyopLW+Bfs4F4L5HHqbOOBjzowxkBIl?=
 =?iso-8859-1?Q?pF9VKS/Phj5Bg+NBwfSWTjKbG1Hc6TFQi1P2GK547W1EOgrcpVRFQHytas?=
 =?iso-8859-1?Q?7P+9Q7v8otItHK8/MFS6JBjGilTX0NloRaTbs8FJJdL7UARq3dw3nJB8vl?=
 =?iso-8859-1?Q?NYFx1GFYOgsiUumIzVZ0Sa2UW27m7ESIjm7goDNFkqnflDLGIRDFEVO1ig?=
 =?iso-8859-1?Q?f4RtmU+VwdRv8CTWlXznvsWSyPMqszv4Ts8AuZBjPwP4GflWshYoUte7zz?=
 =?iso-8859-1?Q?OcqmJLn/1KeMp5Vo1B0vacmehku8qkkiqKpEDXgC6jKPO+iRnUG+R/4m/C?=
 =?iso-8859-1?Q?KWMPeCIwhClRsq3cFIoQdDxYe6D8/0eDmXG5t7U1L2bbp+vM+J1QtFBh/c?=
 =?iso-8859-1?Q?XmHQ0TC6o4iqgknHz4LPueAyls/WuC0=3D?=
X-Exchange-RoutingPolicyChecked: oVgiM1bY6plCluqibMVoTGylaKjuqWDyrQ/m+IEf+688pbAqMPSsNZS5a8vFHjfDCNChFYrLnEy4+PXV3dN84123MfgQCUK2QJ1rMWAh7bJr45xfvZmiN5C93M9mEqbXo+J09zXYZ3dE0+j+6+2C4ZLCWnBw7DPTsWAwV1lrlHSXwH9MpvxVirl3l0fsszKEMhbMzQWNwyICpsxaKTtZArIhljzPusFdYb/xXezLo+C1jhYMCnA/vSwl11Q8YJevRknLFdWr12hC14bGT3YsHrcyhRQz/ny7VH6SaCWeY7lOk7qmwZ7lX3i7qvvPubM+/7kZNh257KzOwrlSGXAzGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaa976e-02bf-41c7-6a12-08df08634f7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:57:53.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vRfAi82k2fhE7hXJnvKfzSeFecy33PyT6md3RqRt6KM1rfpf5SCYnXXAswiQc0pwXljuUiRXrKOU/DpibCwBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
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

On Tue, Sep 01, 2026 at 05:00:59PM +0800, Honglei Huang wrote:
> With the N:1 drm_gpusvm_pages layout, one CPU range mirrored on several
> drm_devices, the caller had to invoke get_pages() once per device and
> repeat the HMM fault every time.
> 
> Make get_pages() take a contiguous array of drm_gpusvm_pages plus a
> count: fault once, then DMA map each instance by
> drm_gpusvm_dma_map_pages() under a single read_retry gate. xe range and
> userptr callers are updated.
> 
> Document the N:1 array usage in the Overview, showing how get_pages()
> and drm_gpusvm_range_set_unmapped() take the whole array and its count
> while the unmap and free paths stay per-instance.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c    | 141 ++++++++++++++++++++++++--------
>  drivers/gpu/drm/xe/xe_svm.c     |   2 +-
>  drivers/gpu/drm/xe/xe_userptr.c |   2 +-
>  include/drm/drm_gpusvm.h        |   1 +
>  4 files changed, 108 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 89c3061d8ef..810f801a9f7 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -80,6 +80,13 @@
>   *			};
>   *		};
>   *
> + *		static struct drm_gpusvm_pages *
> + *		driver_pages(struct driver_range *drange)
> + *		{
> + *			return drange->num_pages == 1 ? &drange->inline_pages :
> + *							drange->pages;
> + *		}
> + *
>   *	In the N:1 case the driver allocates the pages array with a zeroing
>   *	allocator (e.g. kcalloc(num_pages, ...)), initialises each entry with
>   *	drm_gpusvm_init_pages(), and frees each entry with
> @@ -89,6 +96,28 @@
>   *	Each drm_gpusvm_pages must be zero-initialised and initialised with
>   *	drm_gpusvm_init_pages(), called once per entry.
>   *
> + *	The 1:1 examples below pass @num_pages == 1 and &drange->pages. In the
> + *	N:1 case the driver instead passes the whole array and its count, so a
> + *	single call faults the CPU range once and DMA maps it for every owning
> + *	drm_device, e.g.:
> + *
> + *	.. code-block:: c
> + *
> + *		// GPU fault handler: one fault, one DMA mapping per device
> + *		err = drm_gpusvm_get_pages(gpusvm, driver_pages(drange),
> + *					   drange->num_pages, gpusvm->mm,
> + *					   &range->notifier->notifier,
> + *					   drm_gpusvm_range_start(range),
> + *					   drm_gpusvm_range_end(range), &ctx);
> + *
> + *		// Notifier callback: mark every instance unmapped in one call
> + *		drm_gpusvm_range_set_unmapped(range, driver_pages(drange),
> + *					      drange->num_pages, mmu_range);
> + *
> + *	The unmap and free paths stay per-instance: iterate @num_pages over
> + *	driver_pages(drange) and call drm_gpusvm_unmap_pages() /
> + *	drm_gpusvm_free_pages() for each entry.
> + *
>   * - Operations:
>   *	Define the interface for driver-specific GPU SVM operations such as
>   *	range allocation, notifier allocation, and invalidations.
> @@ -232,7 +261,7 @@
>   *				goto retry;
>   *		}
>   *
> - *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
> + *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages, 1,
>   *					   gpusvm->mm, &range->notifier->notifier,
>   *					   drm_gpusvm_range_start(range),
>   *					   drm_gpusvm_range_end(range), &ctx);
> @@ -1417,25 +1446,34 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>  /**
>   * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>   * @gpusvm: Pointer to the GPU SVM structure
> - * @svm_pages: Pointer to the GPU SVM pages structure
> + * @svm_pages: Array of GPU SVM pages structures
> + * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
>   *
> - * This function determines if a GPU SVM pages are valid. Expected be called
> + * This function determines if every GPU SVM pages instance is valid, dropping
> + * the stale dma_addr array of any instance which is not. Expected be called
>   * without holding gpusvm->notifier_lock.
>   *
> - * Return: True if GPU SVM pages are valid, False otherwise
> + * Return: True if all GPU SVM pages are valid, False otherwise
>   */
>  static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
> -					    struct drm_gpusvm_pages *svm_pages)
> +					    struct drm_gpusvm_pages *svm_pages,
> +					    unsigned int num_pages)
>  {
> -	bool pages_valid;
> +	bool pages_valid = true;
> +	unsigned int p;
>  
> -	if (!svm_pages->dma_addr)
> -		return false;
> +	for (p = 0; p < num_pages; ++p) {
> +		if (!svm_pages[p].dma_addr)
> +			return false;
> +	}
>  
>  	drm_gpusvm_notifier_lock(gpusvm);
> -	pages_valid = drm_gpusvm_pages_valid(gpusvm, svm_pages);
> -	if (!pages_valid)
> -		__drm_gpusvm_free_pages(gpusvm, svm_pages);
> +	for (p = 0; p < num_pages; ++p) {
> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
> +			continue;
> +		__drm_gpusvm_free_pages(gpusvm, &svm_pages[p]);
> +		pages_valid = false;
> +	}
>  	drm_gpusvm_notifier_unlock(gpusvm);
>  
>  	return pages_valid;
> @@ -1451,8 +1489,9 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>   * @dma_dir: DMA data direction for the mappings
>   *
>   * Map the faulted @pfns into @svm_pages for DMA access through its owning
> - * drm_device. Must be called under the notifier lock. On failure this unwinds
> - * the partial mapping of this instance before returning.
> + * drm_device. Must be called under the notifier lock and only for an instance
> + * without a live mapping. On failure this unwinds the partial mapping of this
> + * instance before returning.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -1475,6 +1514,9 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>  
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
> +	*state = (struct dma_iova_state){};
> +	svm_pages->state_offset = 0;
> +
>  	flags.__flags = svm_pages->flags.__flags;
>  
>  	for (i = 0, j = 0; i < npages; ++j) {
> @@ -1603,20 +1645,29 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>  /**
>   * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>   * @gpusvm: Pointer to the GPU SVM structure
> - * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
> + * @svm_pages: Array of SVM pages instances to populate with dma addresses
> + * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
>   * @mm: The mm corresponding to the CPU range
>   * @notifier: The corresponding notifier for the given CPU range
>   * @pages_start: Start CPU address for the pages
>   * @pages_end: End CPU address for the pages (exclusive)
>   * @ctx: GPU SVM context
>   *
> - * This function gets and maps pages for CPU range and ensures they are
> - * mapped for DMA access.
> + * This function gets and maps pages for a CPU range and ensures they are
> + * mapped for DMA access. The HMM fault for the CPU range is performed once,
> + * the DMA mapping by drm_gpusvm_dma_map_pages() is then done per instance,
> + * one per owning drm_device. The retry against notifier races is kept here
> + * in common code so drivers never open code it.
> + * The common 1:1 case passes @num_pages == 1.
> + *
> + * On error the instances mapped before the failing one stay mapped, so the
> + * caller must unmap and free every instance regardless of the return value.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
> +			 unsigned int num_pages,
>  			 struct mm_struct *mm,
>  			 struct mmu_interval_notifier *notifier,
>  			 unsigned long pages_start, unsigned long pages_end,
> @@ -1638,9 +1689,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	int err = 0;
>  	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
>  							   DMA_BIDIRECTIONAL;
> +	unsigned int p;
>  
> -	if (!svm_pages->drm)
> -		return -EINVAL;
> +	for (p = 0; p < num_pages; ++p)
> +		if (!svm_pages[p].drm)
> +			return -EINVAL;
>  
>  retry:
>  	remaining = timeout - jiffies;
> @@ -1649,7 +1702,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		return -EBUSY;
>  
>  	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> -	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
> +
> +	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
>  		goto set_seqno;
>  
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> @@ -1667,18 +1721,17 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	if (err)
>  		goto err_free;
>  
> -	if (!svm_pages->dma_addr) {
> -		svm_pages->dma_addr =
> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
> -		if (!svm_pages->dma_addr) {
> +	for (p = 0; p < num_pages; ++p) {
> +		if (svm_pages[p].dma_addr)
> +			continue;
> +		svm_pages[p].dma_addr =
> +			kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> +		if (!svm_pages[p].dma_addr) {
>  			err = -ENOMEM;
>  			goto err_free;
>  		}
>  	}
>  
> -	svm_pages->state = (struct dma_iova_state){};
> -	svm_pages->state_offset = 0;
> -
>  	/*
>  	 * Perform all dma mappings under the notifier lock to not
>  	 * access freed pages. A notifier will either block on
> @@ -1686,10 +1739,12 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	 */
>  	drm_gpusvm_notifier_lock(gpusvm);
>  
> -	if (svm_pages->flags.unmapped) {
> -		drm_gpusvm_notifier_unlock(gpusvm);
> -		err = -EFAULT;
> -		goto err_free;
> +	for (p = 0; p < num_pages; ++p) {
> +		if (svm_pages[p].flags.unmapped) {
> +			drm_gpusvm_notifier_unlock(gpusvm);
> +			err = -EFAULT;
> +			goto err_free;
> +		}

I believe, given how the notifiers work, that checking
`svm_pages[0].flags.unmapped` is actually sufficient. It's a
micro-optimization, so I'm fine with it either way.
 
>  	}
>  
>  	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
> @@ -1698,15 +1753,29 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		goto retry;
>  	}
>  
> -	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
> -				       dma_dir);
> -	drm_gpusvm_notifier_unlock(gpusvm);
> -	if (err)
> -		goto err_free;
> +	for (p = 0; p < num_pages; ++p) {
> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
> +			continue;
>  
> +		err = drm_gpusvm_dma_map_pages(gpusvm, &svm_pages[p], pfns,
> +					       npages, ctx, dma_dir);

One thing that is different here is that if `drm_gpusvm_dma_map_pages()`
fails, say at `p == 1`, then `p[0]` will already contain valid DMA
mappings. I think this is actually fine, though, because the existing
cleanup paths will eventually release those mappings one way or another.
 
That said, it's probably worth confirming this through a code-path audit
and adding a comment here explaining why this is safe.
 
Again, Sashiko didn't run on this patch, and it would be good to get a
run before merging this series.

Matt

> +		if (err) {
> +			/*
> +			 * The failing instance was unwound by the helper. Keep
> +			 * the ones mapped earlier: the -EAGAIN retry reuses
> +			 * them, and the driver unmaps every instance with the
> +			 * range on the other error paths.
> +			 */
> +			drm_gpusvm_notifier_unlock(gpusvm);
> +			goto err_free;
> +		}
> +	}
> +
> +	drm_gpusvm_notifier_unlock(gpusvm);
>  	kvfree(pfns);
>  set_seqno:
> -	svm_pages->notifier_seq = hmm_range.notifier_seq;
> +	for (p = 0; p < num_pages; ++p)
> +		svm_pages[p].notifier_seq = hmm_range.notifier_seq;
>  
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 627a741293d..1c7793d8caa 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -1598,7 +1598,7 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>  
>  	lockdep_assert_held(&range->lock);
>  
> -	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
> +	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages, 1,
>  				   vm->svm.gpusvm.mm,
>  				   &range->base.notifier->notifier,
>  				   drm_gpusvm_range_start(&range->base),
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 90ac141fc12..9c1dac0fce6 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -91,7 +91,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
>  	if (vma->gpuva.flags & XE_VMA_DESTROYED)
>  		return 0;
>  
> -	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
> +	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages, 1,
>  				    uvma->userptr.notifier.mm,
>  				    &uvma->userptr.notifier,
>  				    xe_vma_userptr(vma),
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index b7d987bf76a..d2b6f3d2b84 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -324,6 +324,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>  
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
> +			 unsigned int num_pages,
>  			 struct mm_struct *mm,
>  			 struct mmu_interval_notifier *notifier,
>  			 unsigned long pages_start, unsigned long pages_end,
> -- 
> 2.34.1
> 
