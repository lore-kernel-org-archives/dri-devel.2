Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39554606A331
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GmdNidIf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C49610F6A0;
	Wed, 11 Nov 2026 07:32:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE6D10EE77;
 Wed, 11 Nov 2026 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794382330; x=1825918330;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5BjkJrXnW3ndlg8S9HTyoxQ2H91c+oW+T0fypYVv/c8=;
 b=GmdNidIfvjnJETVp4+RAvY2dfuBKIndqw5jAFg0lxCYPNzxnKMykwehg
 sdM8PBehs81sS6+T14zoY7GmasoXp3D7UeiInfFG9pD+2NkT9T7TKjMox
 3GCqsvmQrKs1wal5wepuTHFRWE+Y+WQgu1C/iXkj8KJdspMkIFzGba4n/
 wKlS8h8sTuPzNjRVsPyDV/1s1NH3NqV7XfnaMzo+eRGX21dCAu82PI70G
 gTR5kffXBaHujkyIx5ez1Po1tHoCtgUcDJNjl+wA/MJkCJz4rnJnWorpS
 eM6HnVHU3Z4jL0Culu0MEO9iB3pKwWnfnHSWoATt6PaLcbEZSdjG8kTim g==;
X-CSE-ConnectionGUID: H2oT7kXUQAKsHvLTNyUIUA==
X-CSE-MsgGUID: 9n7r6a2QTAOu5AXQU98Gcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3154422"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3154422"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 23:32:03 -0800
X-CSE-ConnectionGUID: BoWNBE27Qx2kU8jSpLyqDA==
X-CSE-MsgGUID: g90RGX2dTJSDKeCnsE6nIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8393329"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 23:32:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:32:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 23:32:00 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:32:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZMdltaGHL50W3O1/hS3RKHeERFQmgV4QdtJVuNO/1CoAmNEx3RGf7eYswf8XofSZkSQCnKBu7lEXBhEtdV8ACWP8gqG6qeMpPNuVvrnhCy3nEMgFK0fLBJru9HBirSFhId3S8lIEkrgDHt2F3b86fdYESlH4JqA2uBtlvr2YWRW5WaDJ9qeRgQAq7Dt4ZOdrpQJEKXyLh/ynqoU2TXsaiFQDpHXqTXzY6wWRCGWfXWIlsJ6EhEFy9ITBioQzDp6r+wfYP517Vv5RIKWm0TWqxCIoZOwfyYC9eb/2XQcFgsmWMna1PQ1X1KMA0ahDH8GjIIbHcmD7mNdamJImCptlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVEc+2VW/DYSATb4QB1eCAgqWagAchG+3WjtbF+C+fs=;
 b=EZKI0ppR8TQf8h+Q2eb11WWm/IF3A6QlIgrAWaAM6B7ProLCjGHUOBiw4R/JD4LnTNCdcoVSbSYgBwfO/v3wLSdm/MC/p1rVoVU4kltzaZq4woD4dSHJhPhyflCDGOcVOpUWv8QIyHtbZ3g/OQQcTC75vQQnWkFEIQ4LqSFwxGdeX+sSLC6+Xvkpf74Go5sROVnepumdehu68rz1kCi4PbYT9UjFeSeCx+lewmHtWWIGV904b5nr1RvRtgTHGlSfOoiiuM2ekmW3K+g7AvccSaHdKdmDXa+ARDlFaIcqg1EIW8jcYxPkUy/SMU1eRHu0mql6nX1IeQcYB63W5B5h6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 07:31:56 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 07:31:56 +0000
Date: Tue, 10 Nov 2026 23:31:53 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 10/33] drm/ttm: Add full out-of-lock preallocation for
 ttm_pool_alloc()
Message-ID: <avQZ6cCNt2H8vBtG@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-11-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-11-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9139f771-6f48-4c78-f6da-08df3fc5dd18
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261102130727099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: r+BvDJ1N5NRFURlFnBATxv+b1L53F3hT3mLVMutZqcpwp7Gk3xwj9Pg+CoNvcPi6Xe0I1ujnXnacBcoCp0t9QKb7tSNeh5vLNxybFD1zgnNAWFrIRQoVXVFyZ0elDFMqRvePrXZm0oDX6Ukcus7OYHYOCrLnB5q+/vQz1oLAe02matgejJGLNqAQSR/aEo4bDSFXWI2rsccCG2iSDVW/B3mio5wvGAxPj7G/3GfSBH3RN6z0Q2Zcqzfnvp8FjG2oh1F93V9KO/dLHY0Zc1wN6qxrsyvcK/k6jSkEZvMkIunJ3hAwj1fjETa/1p3jkqUkodDMCecCLkdZPjavM83zCZrRW/yTPmbqNhL6ob53L2WmcZr+o2bE0GwZrDKfTJe7Ig8YKYKI1d/V0JJsELkxCB9O529see5MNJP3hBpk5hfiDVwkhdLAfKfVvpPhVH1xI2oVCDAd4Oybnrnpir7wGSENSpDec2bubsfecAobgtfk5OH/Oh+23Jy0GqytrLPSqdcMnYg8mn4fSHXkbuWkY1RQLA1WNiZYKFo26Vu5NX2Pl7+xRHRumWLoGGQ2wUaCiQDubUbJMhmGmpgDB86eOITe4IpxrHlzY3HNyibEvqPjzg56pHGhCUByRIwyGi2GiL0DvuczK1JHYTj7VW0E/QDlNDker2+GRKFVM+ejNUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261102130727099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zeZF9zUE9NPmYup3gkU6IpxW9LS8HLdAZVK5OXQ847pOv9OQHNAmC7bgqw?=
 =?iso-8859-1?Q?CxfR/OcIJ7j0pBgadnmjq6WZCx+kaQqLS/yk+0OjDiKEIBwlTe8dy6JHpm?=
 =?iso-8859-1?Q?T00LeGGcLfaCgOZXQXaRZ8nRyKTSnQ3ZuU/MgtwOYr1aMCEJGmjr4NLgUy?=
 =?iso-8859-1?Q?YDglTj5xr1kkqsoiJ/qNXIjNtHrMlj6YJdfkFYBMBII5j92WqqwVYLZCTR?=
 =?iso-8859-1?Q?Thg9h9sc5InaDO5yQr4D8ZE5vtsLLa9AFC60Rdj87y2j3hLjmWF8czYOSl?=
 =?iso-8859-1?Q?kb6wFRfbbpMy/zWZgIn/ulZqHuKbk9z6T5IsrYwa+iNhwSBQkb86LqyPfy?=
 =?iso-8859-1?Q?Jfr9MVoEsNBNfsTjPHLJevZ/8/N2cEQzewiKQTzDaRfjsgNrPejwzipJdm?=
 =?iso-8859-1?Q?R/I3NWiZVPfJXLFCNEw1h+iP1RA8pak35LWF9DlwYldq1/CjTGiG2nmFPk?=
 =?iso-8859-1?Q?Hl4sTbsEMnCzCw2IQjPJM7bSf/eAKwdHuHg00nOIITRYhPzgavldzVioxo?=
 =?iso-8859-1?Q?NZ3NTlN4hz6KKeTAALpgIeGbiSxnRYYHbJ39YnGkNSgnUPpGt0ghqUDb24?=
 =?iso-8859-1?Q?0FkZVQb8bpv8Kf/t3CCR+EPYqee9AwbgnitNK8i34HXV/7GZI7KhbJnL6C?=
 =?iso-8859-1?Q?ScSTAa54vFih/XoJkZjOaXdklcgqp+qU+LRr/ovj8hlbwzo9dcVlzmxjHP?=
 =?iso-8859-1?Q?Cy2gJZhN+nbRoeSIJbo4x550zKIwLVPkauzA2cUflgmnRyYFuTA0v9rGW0?=
 =?iso-8859-1?Q?YwI2HW1OIjwa6cGVYkMPIW6qzm2IowtzWlUgdVrkBCkjGjCfel1U7eRJGo?=
 =?iso-8859-1?Q?7UlV7i4zrQAoOK8phS+utb0F2Nyv5rm/xJf1E42LwvRHI3b/IKH9CWkuLv?=
 =?iso-8859-1?Q?pJVk4OIBsCpnWAvXuXd1dHzOyD5WwjwgVn6ITuHuNF292+JjT2K28ov9ap?=
 =?iso-8859-1?Q?i7fZdFtRK2/nTzeEYuHKdDkey9odVI2VXEcRUwbz9QBY2e8DOc38fzc9Zm?=
 =?iso-8859-1?Q?DAi7w3/mMq+RJ71sJ0dUzvH0GMwoLhD5eeuSSTsbD+yTI4o4vncMhxEKCk?=
 =?iso-8859-1?Q?WSzZ2P8xLKOW1mH2v25hThkpWvAZhHkc9LtD/tgw1GyP8FJ+Wu3lAd0YAy?=
 =?iso-8859-1?Q?USzFKzW2nTp23cMeRrkYIfsq9rRMX5w/eEd6EhutHn7kTFscEfcYzNWN0z?=
 =?iso-8859-1?Q?//FEPfsaO9FRMSBAYhJJ3mTGfhMaElSOOcQYP6TBdrFIUrcAcDoB3OkDVn?=
 =?iso-8859-1?Q?4cGDG2QSzFoLh8JkcchsxwJuqTMeweJTtQowRlSfD5z3pp+R0dGR7eyF4g?=
 =?iso-8859-1?Q?VmedVfV+Lxq37HRan21HPUCGH5fa6g5oa4/glPQfSR9fMQtJqIs/KXPD8Q?=
 =?iso-8859-1?Q?6LLVYNgobqm9fMKWhuWIrr9frDfxSaPjdQYHyQ4wzVkbel+t/r2XZXn1v/?=
 =?iso-8859-1?Q?3XboOXXsilH4l99EtVom/QOjkEpLiNC2TDHRfc/T+biO1/O3Db4Y9BhxRF?=
 =?iso-8859-1?Q?oHOQgblru/3DrbZ+qWnKpHGi7IYibP3HKYlMtBi5QYknSyAUk4IMiKYqa3?=
 =?iso-8859-1?Q?UCj18P0sY/Nbek2Lryf/6p1SBnIfFXrjWZQy9ehG3zw1rZmK+xqyCDJjUL?=
 =?iso-8859-1?Q?Ozh3k1le1rM+88mRzjgABt+k/6EFPKVjbF5qHFVTYaxFIIQX369VWtRI+k?=
 =?iso-8859-1?Q?Pi+eG165ZDcU3GRiYMtAzcQnp3JiPjZ+Kzj22gshJCVvcF4RJjrY6fBlVj?=
 =?iso-8859-1?Q?JKhXV9BUlYkqBqrBjDrL6qkkssQlQfb2q0QdldnYRHvFHLFeCPeQUqeUSn?=
 =?iso-8859-1?Q?U2ogXVxRQ7A5HUcbbXiANpD9A45/mPVfcgisMTHK4570dxAvxhdS?=
X-Exchange-RoutingPolicyChecked: bIcMs0AGCA1rDQb55TSH6+iCw+reoRQhScOTkCoCRMqlp5UA4bIFRQ0jl976dZr3G00d0+fSr39+BuXYu/97OrfbtvS3whNdYzWXxhUUgSlelLlhmhViDRpV7fAlFbu81Fsw3VrihybomQd8sgZiKQraP6nDD2u6ymTCY2jBXAglyttSnJF+ehMCU/Ta4L0F3wStTbm1tg21yxV37vxKqT3H/cTsxOYuYJZyT8yC03oCFn56qSSBwr8qzac+16pYpt36ywELNECsjEym5Qu41yKfah+Y0/1NHthoMp+wzvUxbk7qSF50n/vBXX5rA3j+ZgZOPqWRew1FcYLjCcflzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9139f771-6f48-4c78-f6da-08df3fc5dd18
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:31:56.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRfoaZJW8CXG/tYbzaltwXEWK9StBMmXBjHbeOrMQjKaALT7OLs6VPqysddpGYEA6GF1vFneEWslKxWul6YG7lsktFwaQ6cPtX7+ddQkO+jndMEiDpxwgdOWe0DIrgYN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:55:56PM -0700, Matthew Brost wrote:
>ttm_pool_prealloc_fill() lets a driver preallocate beneficial-order pages
>outside the dma-resv lock for a defragmentation move, so the high-order
>allocations that may stall in reclaim/compaction happen off the critical
>section.  That bag is deliberately partial: it holds only interchangeable
>beneficial-order chunks and the allocator consumes it opportunistically,
>falling back to in-line allocation for everything else.
>
>An ordinary populate of a system-memory buffer object has the same
>problem - the whole backing is allocated under the dma-resv lock - but no
>way to move it out of the critical section, because the existing bag does
>not cover sub-beneficial orders and does not describe a full tt.
>
>Add a "full" flavour of the same preallocation mechanism:
>
>  - struct ttm_pool_prealloc gains a @full flag.  In full mode the bag is
>    an ordered tiling of an entire tt at mixed orders (pool pages
>    included), rather than a set of interchangeable beneficial-order
>    chunks.  The per-chunk order is recorded on the page itself and read
>    back at consume time, so no parallel order array is needed.
>
>  - ttm_pool_prealloc_fill_full() allocates the whole backing for a tt of
>    @num_pages pages up front, mirroring the in-line allocator's order
>    walk (highest order first, capped by the remaining page count).  It
>    reuses the existing unlocked helpers (ttm_pool_prealloc_gfp(),
>    ttm_pool_set_caching()) via a new ttm_pool_take_page() helper that
>    tries a same-order pool page before a fresh system allocation.
>
>  - ttm_pool_prealloc_fini() frees any unconsumed tail at each chunk's own
>    order when @full.
>
>  - ttm_pool_prealloc_fill_full() takes a @beneficial_reclaim_backoff
>    argument, plumbed to ttm_pool_alloc_page(), that lets the caller
>    allocate higher-order chunks without aggressive reclaim/compaction.
>    This suits a driver that upgrades suboptimal pages to beneficial order
>    in place later (e.g. via a background defragmenter) and so has no need
>    to stall the user context reclaiming for contiguity up front.
>
>  - __ttm_pool_alloc() consumes a full bag with a single early branch in
>    ttm_pool_iter_acquire_page(): install the next chunk as-is (order
>    taken from the page) and return; once the best-effort bag is drained
>    the loop falls through to normal in-line allocation.  The defrag
>    harvest and reuse-old phases are inert here as there is no
>    defrag_old_tt.
>
>Like the defrag bag, this is best-effort: a short fill is fine (the pool
>allocates the shortfall in-line) and DMA-alloc pools are unsupported
>(caching is applied on the kernel mapping).  No functional change for
>existing users; the new fill routine has no in-tree caller yet.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/ttm/ttm_pool.c | 232 ++++++++++++++++++++++++++++++++-
> include/drm/ttm/ttm_bo.h       |  19 +--
> include/drm/ttm/ttm_pool.h     |  27 +++-
> 3 files changed, 258 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index da7d132c8297..4746f5d8cd7e 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -1046,6 +1046,7 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> 	pp->caching = tt_caching;
> 	pp->count = 0;
> 	pp->used = 0;
>+	pp->full = false;
>
> 	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
> 	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
>@@ -1102,6 +1103,187 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> }
> EXPORT_SYMBOL(ttm_pool_prealloc_fill);
>
>+/*
>+ * Acquire a single *@order chunk, trying a same-order pool page first (already
>+ * carries @caching) then a fresh system allocation (write-back). Runs unlocked.
>+ * When @beneficial_reclaim_backoff is set, higher-order system allocations skip
>+ * aggressive reclaim/compaction (see ttm_pool_alloc_page()).
>+ *
>+ * A fresh system page is write-back and needs the tt's caching applied later in
>+ * bulk; *@need_caching is set true for it and false for a (pre-cached) pool
>+ * page.
>+ *
>+ * On a genuine failure *@order is left untouched (the caller lowers it by one
>+ * and retries). Fault injection instead pretends allocation at (or above) the
>+ * beneficial order failed and lowers *@order to the beneficial order, so the
>+ * caller's next attempt lands below it - mirroring the in-line acquire path's
>+ * fail_beneficial jump and exercising the beneficial_order_failed tracking
>+ * without driving the system into real fragmentation.
>+ *
>+ * Returns NULL if no page of *@order could be obtained.
>+ */
>+static struct page *ttm_pool_take_page(struct ttm_pool *pool,
>+				       enum ttm_caching caching,
>+				       unsigned int *order, gfp_t gfp,
>+				       bool *need_caching,
>+				       bool beneficial_reclaim_backoff)
>+{
>+	unsigned int beneficial = ttm_pool_beneficial_order(pool);
>+	struct ttm_pool_type *pt;
>+	struct page *p;
>+
>+	*need_caching = false;
>+
>+	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && beneficial &&
>+	    *order >= beneficial &&
>+	    should_fail(&beneficial_order_fault_inject, 1)) {
>+		*order = beneficial;
>+		return NULL;
>+	}
>+
>+	pt = ttm_pool_select_type(pool, caching, *order);
>+	if (pt) {
>+		p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
>+		if (p)
>+			return p;	/* pool page already carries @caching */
>+	}
>+
>+	p = ttm_pool_alloc_page(pool, gfp, *order, beneficial_reclaim_backoff);
>+	if (!p)
>+		return NULL;
>+
>+	/* Fresh system page is write-back; caller applies @caching in bulk. */
>+	*need_caching = true;
>+	return p;
>+}
>+
>+/**
>+ * ttm_pool_prealloc_fill_full() - Preallocate a whole tt's backing outside any
>+ * lock
>+ * @pool: The pool to allocate from.
>+ * @tt_caching: The requested cpu-caching for the pages allocated.
>+ * @pp: Prealloc bag to fill; marked @full and tiled with mixed-order chunks.
>+ * @num_pages: Number of 4K pages the tt needs backed.
>+ *
>+ * Unlike ttm_pool_prealloc_fill() (which parks a bag of interchangeable
>+ * beneficial-order defrag chunks), this allocates the ENTIRE backing for a tt
>+ * of @num_pages pages up front, at whatever mix of orders is available (pool
>+ * pages included), so that the subsequent __ttm_pool_alloc() under the dma-resv
>+ * lock merely installs the pages without stalling in reclaim/compaction. The
>+ * chunk orders mirror the in-line allocator's order walk; each chunk's order is
>+ * recorded on the page itself and read back at consume time.
>+ *
>+ * May sleep/reclaim freely as it runs unlocked. When
>+ * @beneficial_reclaim_backoff is set, higher-order chunks are taken without
>+ * aggressive reclaim/compaction: the caller relies on a background
>+ * defragmenter to upgrade to beneficial-order pages in place later, so there
>+ * is no need to stall the user context reclaiming for contiguity here. A short
>+ * fill is fine: the pool falls back to in-line allocation for the shortfall.
>+ * DMA-alloc pools are not supported (the bag stays empty). Returns 0 (release
>+ * with ttm_pool_prealloc_fini()).
>+ */
>+int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
>+				enum ttm_caching tt_caching,
>+				struct ttm_pool_prealloc *pp,
>+				unsigned int num_pages,
>+				bool beneficial_reclaim_backoff)
>+{
>+	gfp_t gfp = ttm_pool_prealloc_gfp(pool) | __GFP_ZERO |
>+		__GFP_RETRY_MAYFAIL | __GFP_NOWARN;

Assisted-by: LLM

__GFP_RETRY_MAYFAIL is bit confusing here as as ttm_pool_alloc_page()
is expected to suppy it (patch 1). I see that only applies to
beneficial order, but here we have mixed-order and hence it is set
here. May be add some documentation to clarify it?

>+	unsigned int highest = MAX_PAGE_ORDER;
>+	unsigned int remaining = num_pages;
>+	struct page **cpages = NULL;
>+	unsigned int ncpages = 0;
>+	int r;
>+
>+	pp->pages = NULL;
>+	pp->order = 0;
>+	pp->caching = tt_caching;
>+	pp->count = 0;
>+	pp->used = 0;
>+	pp->full = true;
>+
>+	/* Caching is applied on the kernel mapping, so DMA-alloc is unsupported. */
>+	if (!num_pages || ttm_pool_uses_dma_alloc(pool))
>+		return 0;
>+
>+	/* Worst case is one order-0 chunk per page. */
>+	pp->pages = kvzalloc_objs(*pp->pages, num_pages);
>+	if (!pp->pages)
>+		return 0;
>+
>+	/*
>+	 * Fresh write-back chunks get their caching changed in a single
>+	 * set_pages_array_*() after the fill; collect their constituent pages
>+	 * into an unpacked scratch array (one entry per 4K page) since the
>+	 * packed bag holds mixed-order chunks. Cached tts and pool pages need
>+	 * no change (and non-x86 handles caching at map time).
>+	 */
>+	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
>+		cpages = kvzalloc_objs(*cpages, num_pages);

Same comment as in patch 9.
cpages is tansient memory and unlike patch 9, it is not bounded by 'budget' here.
may be it can be avoided altogether by using a one static 4k page in the
pool and flush it with set_pages_array*() as and when it fills up?

>+		if (!cpages) {
>+			kvfree(pp->pages);
>+			pp->pages = NULL;
>+			return 0;
>+		}
>+	}
>+
>+	while (remaining) {
>+		unsigned int order = min_t(unsigned int, highest,
>+					   __fls(remaining));
>+		bool need_caching;
>+		struct page *p;
>+
>+		for (;;) {
>+			p = ttm_pool_take_page(pool, tt_caching, &order, gfp,
>+					       &need_caching,
>+					       beneficial_reclaim_backoff);
>+			if (p)
>+				break;
>+			if (!order)
>+				goto apply_caching;	/* short fill */
>+			/*
>+			 * Genuine failure: retry one order down. A fault
>+			 * injection lowered @order to the beneficial order
>+			 * above, so this drops it below - landing on a
>+			 * sub-optimal (defrag-worthy) chunk.
>+			 */
>+			order--;
>+		}
>+
>+		pp->pages[pp->count++] = p;
>+		if (cpages && need_caching)
>+			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
>+							order);
>+		remaining -= 1u << order;
>+		highest = order;
>+	}
>+
>+apply_caching:
>+	/*
>+	 * Apply the requested caching to every collected page in one shot. On
>+	 * failure the pages' caching is indeterminate, so drop the whole bag
>+	 * (freeing restores write-back) and let the consumer allocate in-line.
>+	 */
>+	r = ttm_pool_prealloc_apply_caching(tt_caching, cpages, ncpages);
>+	kvfree(cpages);
>+	if (r) {
>+		unsigned int i;
>+
>+		for (i = 0; i < pp->count; i++) {
>+			struct page *p = pp->pages[i];
>+
>+			ttm_pool_free_page(pool, tt_caching,
>+					   ttm_pool_page_order_nodma(p), p,
>+					   false);
>+		}
>+		pp->count = 0;
>+	}
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL(ttm_pool_prealloc_fill_full);

It has lot of code common with ttm_pool_prealloc_fill(). May be extract common
code to separate function/s?

>+
> /**
>  * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
>  * @pool: The pool the pages came from.
>@@ -1111,9 +1293,13 @@ void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
> {
> 	unsigned int i;
>
>-	for (i = pp->used; i < pp->count; ++i)
>-		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
>-				   false);
>+	for (i = pp->used; i < pp->count; ++i) {
>+		struct page *p = pp->pages[i];
>+		unsigned int order = pp->full ?
>+			ttm_pool_page_order_nodma(p) : pp->order;
>+
>+		ttm_pool_free_page(pool, pp->caching, order, p, false);
>+	}
> 	kvfree(pp->pages);
> 	pp->pages = NULL;
> 	pp->count = 0;
>@@ -1251,9 +1437,10 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
>
> /*
>  * Acquire a single page for the current order, leaving it in @it->p (NULL on
>- * failure). Tries, in order: a beneficial-order page preallocated outside the
>- * dma-resv lock (defrag), a same-order pool page, then a fresh system
>- * allocation. Fault injection can force the beneficial-order paths to "fail".
>+ * failure). Tries, in order: a chunk from a full out-of-lock prealloc (populate
>+ * of the whole tt), a beneficial-order page preallocated outside the dma-resv
>+ * lock (defrag), a same-order pool page, then a fresh system allocation. Fault
>+ * injection can force the beneficial-order paths to "fail".
>  */
> static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> {
>@@ -1262,6 +1449,39 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
>
> 	it->p = NULL;
>
>+	/*
>+	 * Full prealloc: the entire backing was allocated (pool + system, at
>+	 * mixed orders) outside the dma-resv lock. Install the next chunk as-is,
>+	 * taking its order from the page. Falls through to in-line allocation
>+	 * once the best-effort bag is drained.
>+	 */
>+	if (pp && pp->full && pp->used < pp->count) {
>+		it->fail_beneficial = false;
>+		it->p = pp->pages[pp->used++];
>+		it->order = ttm_pool_page_order_nodma(it->p);
>+		it->page_caching = it->tt->caching;

Same comment as in 23.
We should ensure caching has not changed here after prefill
(ie., pp->caching == it->tt->caching). Though it is not expected to change
in gem_create_ioctl call (unlike defragmentation case of patch 23),
probably it is still better to check to ensure TTM prealloc() and
pool_alloc_page() interfaces work correctly together?

>+
>+		/*
>+		 * The full prealloc tiles at whatever orders were available
>+		 * without stalling in reclaim. A sub-beneficial chunk only
>+		 * means a sub-optimal backing (defrag-worthy) when it sits in a
>+		 * beneficial-order aligned region that fully fits in the tt -
>+		 * that region could have been a beneficial-order page. A low
>+		 * order in the unaligned trailing tail is expected and must not
>+		 * flag the tt (mirrors ttm_pool_harvest_remaining()).
>+		 */
>+		if (it->beneficial_order && it->order < it->beneficial_order) {
>+			pgoff_t bnr = 1UL << it->beneficial_order;
>+			pgoff_t off = it->tt->num_pages -
>+				      it->alloc->remaining_pages;
>+
>+			if (round_down(off, bnr) + bnr <= it->tt->num_pages)
>+				it->tt->page_flags |=
>+					TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>+		}
>+		return;
>+	}
>+
> 	/*
> 	 * Fault injection: pretend allocation at (or above) the device's
> 	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
>diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>index a80304f179ba..52ec7e5c0d2d 100644
>--- a/include/drm/ttm/ttm_bo.h
>+++ b/include/drm/ttm/ttm_bo.h
>@@ -238,14 +238,17 @@ struct ttm_operation_ctx {
> 	 */
> 	s64 defrag_bytes_remaining;
> 	/**
>-	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
>-	 * move. The pool allocator consumes these instead of allocating fresh
>-	 * beneficial-order pages under the lock, moving the (potentially
>-	 * reclaim/compaction stalling) high-order allocations out of the
>-	 * critical section. NULL means allocate in-line as usual. The pool
>-	 * silently falls back to in-line allocation for any shortfall. The
>-	 * allocator consumes it for beneficial-order chunks of any populate;
>-	 * drivers only set it for a defrag move.
>+	 * @prealloc: Pages preallocated outside the dma-resv lock. The pool
>+	 * allocator consumes these instead of allocating under the lock, moving
>+	 * the (potentially reclaim/compaction stalling) allocations out of the
>+	 * critical section. NULL means allocate in-line as usual. Two flavours,
>+	 * distinguished by ttm_pool_prealloc::full:
>+	 *   - defrag bag (full=false): a bag of interchangeable beneficial-order
>+	 *     chunks consumed only for beneficial-order chunks of a defrag move.
>+	 *   - full tiling (full=true): the entire backing of the tt, at mixed
>+	 *     orders, consumed for every chunk of an ordinary populate.
>+	 * The allocator silently falls back to in-line allocation for any
>+	 * shortfall.
> 	 */
> 	struct ttm_pool_prealloc *prealloc;
> 	/**
>diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
>index 71670350eb15..777d5aa08f6a 100644
>--- a/include/drm/ttm/ttm_pool.h
>+++ b/include/drm/ttm/ttm_pool.h
>@@ -83,18 +83,27 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
>
> /**
>  * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
>- * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
>- *         short); each entry is the head page of a 1 << @order chunk.
>- * @order: Page order of every preallocated chunk.
>+ * @pages: Array of @count preallocated chunks; each entry is the head page of a
>+ *         chunk. In defrag mode every chunk is @order pages; in @full mode the
>+ *         chunks tile a whole tt at mixed orders and the per-chunk order is read
>+ *         back from the page itself.
>+ * @order: Page order of every preallocated chunk (defrag mode only; 0 in @full
>+ *         mode where each chunk carries its own order).
>  * @caching: CPU caching applied to the pages, so leftovers can be restored
>  *           to write-back before being freed.
>  * @count: Number of valid entries in @pages.
>  * @used: Number of entries already consumed by the pool allocator.
>+ * @full: When set the bag holds a full, mixed-order tiling of an entire tt
>+ *        (produced by ttm_pool_prealloc_fill_full()) rather than a bag of
>+ *        interchangeable beneficial-order defrag chunks. The pool allocator
>+ *        then drains the bag in order for every populate, taking each chunk's
>+ *        order from the page, and falls back to in-line allocation only for any
>+ *        shortfall.
>  *
>  * Defrag pages are interchangeable, so only a count of beneficial-order chunks
>- * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
>- * __ttm_pool_alloc() drains it; any unused tail is released by
>- * ttm_pool_prealloc_fini().
>+ * is needed. ttm_pool_prealloc_fill() / ttm_pool_prealloc_fill_full() populate
>+ * this outside the lock and __ttm_pool_alloc() drains it; any unused tail is
>+ * released by ttm_pool_prealloc_fini().
>  */
> struct ttm_pool_prealloc {
> 	struct page **pages;
>@@ -102,10 +111,16 @@ struct ttm_pool_prealloc {
> 	enum ttm_caching caching;
> 	unsigned int count;
> 	unsigned int used;
>+	bool full;
> };
>
> int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> 			   struct ttm_pool_prealloc *pp, unsigned int count);
>+int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
>+				enum ttm_caching tt_caching,
>+				struct ttm_pool_prealloc *pp,
>+				unsigned int num_pages,
>+				bool beneficial_reclaim_backoff);
> void ttm_pool_prealloc_fini(struct ttm_pool *pool,
> 			    struct ttm_pool_prealloc *pp);
> unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
>-- 
>2.34.1
>
