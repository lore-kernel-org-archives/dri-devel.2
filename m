Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D88606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nemcV2FA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE8910E4C7;
	Mon,  9 Nov 2026 01:31:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A10010E4C7;
 Mon,  9 Nov 2026 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794187876; x=1825723876;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=9JIl8KWKFWgLkMQ98MbGCLVhG8lvI56AOtD0Ogm+LSE=;
 b=nemcV2FAaL1hiz7Uvbege9KSpdfUrAYYac+vLJVcqu8EF6qx1JAceoJH
 7WwSr7OtC5ERwTVEjQ5eFkIRhoMiHGZOU9RLVog0OHzesKX5af2lFFkJn
 r/CQk3VpSneRawQaD2hbtcoi07XtR5rGDuViQOgbgYyiK3idSX/0HFscT
 nmanQIcElh/R+SU4I5iGpsFsrUY3LhiLoagOZ5nYsMC7n3hCZvPMvLoDS
 V/fYVhc5gQ7+rAiE4HCS4fhApnp3gBf/Mj0+Qnn0yPOo//DkDsEHJf3Yn
 XFUGMMQf+PNiwN9Wb0oVk/pj3LJANJi9WSuZiGyslzNhH4WrQPkVEKLPM w==;
X-CSE-ConnectionGUID: Dsu19dRaTR678d6n1pnZAg==
X-CSE-MsgGUID: 7A8B9GsFSK+/iaz8WO5yHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2940620"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2940620"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 17:31:16 -0800
X-CSE-ConnectionGUID: aLREjqAfRrGSqDeC/TEoiA==
X-CSE-MsgGUID: 35ziJt0vQqWN3PzMhkVh5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="8091058"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 17:31:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 17:31:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 8 Nov 2026 17:31:14 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 17:31:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJq9Ji1tD8UZliyaBL0mQq82pyuvIknUGyF9lFgL98Xc6Fr+sOnJr3/V7Z16TFlN9hisi4hic5b7dbTrvO9ZyiXZxqatX1/PlbUB9Hgp0eK2pgfTdWIUPXLKizhc4QDLFnAEQ3Kl3Yz1pL1KLlYgczL9V8yiFRw/ilKP/eg6iz6robGFbQ4aCqWxGVvSpZ3R9xHG9kuMXWIRujKPzywb9P1MAGMy0AH6lO0l0CJzEbVyO+WC3LID3qEEmcUlSY3zRshQUSceSCek777dRajOSHrZP+gqzHoyP8nlAAKB5qvpoyF6C0Tx3bnpzgA1SYVS9n+ri6uIPi6vCanWaqV8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7I99l1TbfMrV4fqz1RlbSqZtsx2G6mEutKInT2zuKk=;
 b=ybyBMPdQOR7kkH8QhTGsMkeiOtwIPHcE+kUQAnOujntaCkk5BGO5M2sOPAa3FLMTVa2yi+zYq8HHxFX/0bgCdRSAmRezpgeu1AUb1HdLDpnIW+DEg67aNfxV4/uS/zVYaTJr3OU4DNbzcFhpov76JOImsrvw7bbe+exEBVTNMyCK/n/tyhQn+ccGFGrSAJsRDK8D9+wGRgoWTA58eVGjcDCnSc/TGLLc42A5EuuuQDd+Tl2xZFC+mriy7IY/cmYhoKNENxeoKKgGveOKSX6PEv/CPZ1Wwxi41qvOURXw3Scx9F1h8AHtYPig8n2MgeATxO06iZsMoy482VtSb+IIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 01:31:10 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 01:31:10 +0000
Date: Sun, 8 Nov 2026 17:31:07 -0800
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
Subject: Re: [PATCH v3 22/33] drm/xe: Add Kconfig.profile options for BO
 defrag configuration
Message-ID: <avEiW3AKOAi8Gy3C@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-23-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-23-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DS7PR11MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c6b9cc-d182-438e-d5cb-08df3e012248
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|260925022911599003|260925021911599003|260925021311599003|5023799004|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Jr9v/1Q5WaCuXjc7MBM861QEzgYun0Ni2aIlT0zT1C1nm0AH2KhE/VvzaHetqx+lbYw+bfm6tNYPPdDHavdnFt2KcEgboo5zFC3Qeg8ItSAqOW/+2LSgLkuItPdUbYVnV7nJIkMPTT0b3X6i30b7WE/AEUJNk9btG6T5YsrVD2ORk5Oo9hg81iK5YkK3w1SEPmAh2rdC/O51XUk36gC8jtBouqoU0p26DHSCa4DoJatb2u1JNh1M9J78kQx4nxrgV6LbVgI5C4dYhOaZuvUKNUP4pUU0vHDySGJgrJuDZgbYQsRTE5cY4NC/UmFPFZ4WNeCB1Td/F/XMLfprn27UorVkjSWplIZVQD3EhPH44QVakV5Vgz65uuJYuJusU+R3WxsqaoQ8WcPPP0AVWm7MEOFvCoyaD3vOQHTmoldJaS3dX3sd5hlsaexgurnLQI/TUGsQT5I8EY4dUNejDE3W/IxncHQpCBmwlRLQIs9FVFg/X3AmTRS0RVFSFjBhPSPGnX4o2+5+uzyU4N6dxRzjL4xKmaJIfEOMFuxdMVdluhGnDr8bizYuWR4sVOUF6EirXO7HK3gWuSmZkrmIUI2VM0IfO6iUTzhDukV6PvgDTieW2HaR60mhy5Si/aZNuoninYLVOrCJopgzaWImDBTUsoVx0K6OtSHpSGV1rmqmmL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hZYGzxdoFq9ou6CP7g8YUqDV1n9pklRBMqiKbUnWtLXjTAbUgXuBXuDyZS?=
 =?iso-8859-1?Q?nR9LaUGnrZmNktMxCnAdUvqWMQz7ey1ONJzxn4Z/C4cGehQW9raouM4hdG?=
 =?iso-8859-1?Q?rjuRZnpG8OOsrdiEFTejlBU8nohMNGGv15yMjUcMsDcNni3/4uvmL0FKLh?=
 =?iso-8859-1?Q?OyVH9oMDetGFb4hmahqLtBhGgvkFZ8eFEYtBDonXC4iCqnHIUsQewc6Gt9?=
 =?iso-8859-1?Q?iCs+kkecRQ9YkMfLVFyp1nqeTWg8wCwA4gWXXOiYjQ9mocRt3DJrG/k1gZ?=
 =?iso-8859-1?Q?+p/vbnpkEIS/1VbxyzKBtQ6yAOk0gLlkUYUnFXC1s9kcmKffizEL9a0eNT?=
 =?iso-8859-1?Q?PkYkxmkgyKNhxS2/oS2FYC6TMRQRghalbZRujDfU84ESbWAyiHx0mwwkA9?=
 =?iso-8859-1?Q?ZXD0fZ+FvLqFmf6Cqvs5rxeWd5qvAnkMofBWX7bVpdgM2N+e1D9omsLWBQ?=
 =?iso-8859-1?Q?MSjA/rRo4AXNfTjGSklLuP4Fnhy+eUSH8u3k0iR9G20eO80MYieEePvSsb?=
 =?iso-8859-1?Q?gWxNaY4YyekuA1Nmowkmphqa+Rxq97KqyUVLW8VQylkKiIppMcXTWns0sN?=
 =?iso-8859-1?Q?77GBJxI4WsmqJ6kxyW/gTOc249isjOI93oBi1AFex4OqMppazQd5WDZFwP?=
 =?iso-8859-1?Q?65SV6wNpS5a1WwPJzl+nkEF8ABc0zwCC13LpNKbKdCdt/Wcob4j2HAcfk3?=
 =?iso-8859-1?Q?6aA0zCAXhbFu1wUNmM1wjhXOVnhYSuDg1BJ4WUkz7nJxjqXZW0SbLQJYZ+?=
 =?iso-8859-1?Q?84KCpYMGILW+/ko20AzTKDoc5jkbxbflcBYZqNJ3f0u4UV4EtPRYezfpT4?=
 =?iso-8859-1?Q?4QbiScM2Wye0Ylx88rc/sezsgy+qJ8rO2Erp6pr7vF06kcV2+ou+9nj38j?=
 =?iso-8859-1?Q?/cnqroTdApD4KpKw/eIZ5uJa1OIzDrp6eezlZmx87c15j4rCg9Cv1DT8HL?=
 =?iso-8859-1?Q?KWs//Py/xDYz8j6UZAxAGDeAgEIv1m1Mf4TPpYXmxM9u+bh/y+yf9Ax6sV?=
 =?iso-8859-1?Q?j9cy9kpawGjI0vYQh5HpEhcb/Rd++NMqHlDzvb2GXX28wC/Fzld3L6w4me?=
 =?iso-8859-1?Q?H63QiN5V3kL1ObIYoBWeu81JWeBmZfmuREn3dNeMjB/Tbq1eYQ8KVX8tM7?=
 =?iso-8859-1?Q?UX31nCnVKIZOBkGGj4ATMzoPvkN6YrhiQ7EwCNKy94eUWkmpPK2XzvWGZg?=
 =?iso-8859-1?Q?HwvYhl7epvhmGrxE9Hm2XIRa97IZt005dsTHrqmXc+1ZB6UoQs0IO2ESVD?=
 =?iso-8859-1?Q?cyg3eT6Pn5pF7dOzVYmMV6RfUe4ufAh42+GEtFH4WybIaF8/Nx8abghRVV?=
 =?iso-8859-1?Q?tdWCacaePPzYi6AYzUYKiBvqSdEIhA/s8miBuRhWFwmCvmjtINC2wxDZpN?=
 =?iso-8859-1?Q?yYNgY9ib+oGKLfL1DjsNcFZCeIyLOnBrYwF3ZyzTPtSN5iUOb1XKclkiYl?=
 =?iso-8859-1?Q?dUu0y3ObsdHD056FBtRtQfc+/H0INQxJNlYr3lC4sUTyTaTINod+NX/bNH?=
 =?iso-8859-1?Q?J37BuZCtrCns0Avbqg3Oxvm4SuUkfWfkkGph8nyuI2cZ4+0k5GIuScnr3K?=
 =?iso-8859-1?Q?DxsDnZvEy4aQDzXiaxBQc4pqSvLou9Ef/Bg47GC9Nk90WSM4ggx/ZR8vBs?=
 =?iso-8859-1?Q?lpnpN2skmOi8dtAlKqicrQ8RD7coHOP+xhKh2TmLlZwxjvUngnJdCk1lnC?=
 =?iso-8859-1?Q?xSGubrXNe2DEeQ/l517IR/gd2XgNaaVAFIMkOaPk4DCJWGxcmWcC4JFB0F?=
 =?iso-8859-1?Q?9Hp1qOie2XR7VwsYMaSD0EIFF1GelybgkkFpvjjHs3Oq2YS/XY8yZaND2N?=
 =?iso-8859-1?Q?aDSERO54Ki3WAx4XQ/fhxTtq3CiszdhODgbSLIUn6N70vOQytuJK?=
X-Exchange-RoutingPolicyChecked: Lbqb2dUQG+g+IZpK3KDlhjMTacxbE4hyR+QZoZjdaHJF49wDL/XxtLz1FOdgvbV0xndEH5hAMcCv81CLe9wzSmlRpFueCfXUHGWtWxGv6CnXWMioivgvH9UC6CYrXDOqZvGSxeLdsnhwcbTScmrmICBMOTBL2Ubee3TbY74RaCXg3DuHpQRj0V9OYR0ZsRkQ7d4vvYg4mV4i+EyOYnvSW2YjdbGZlhzWjqi+2KXYulEv6iy7bLp+2dF6QYRCsqGxi8SfKYwUPS8LAPMye673ROJCJx2FLTLS+L+sa7m5kpfFJUOgm2o3xwNzr/tPW+LUZ85rAf8oyxfFl1fPaG6RvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c6b9cc-d182-438e-d5cb-08df3e012248
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 01:31:10.2962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86s7xNDzYg6x2wXWo5FDUaiAvcOYvPU8R+GZanh/G3Sfma9jccGbcPcqRVYJ8QN32n7N6GJsogsgtedgbx9mPasMzDrMHIb+W6KO/j0ZAL+9WLKCFYvFDLYu8dI+t5DT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
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

On Fri, Jul 10, 2026 at 07:56:08PM -0700, Matthew Brost wrote:
>Add Kconfig.profile options to make XE_BO_DEFRAG_* defines configurable:
>- DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD: Threshold for TTM reclaim
>  backoff
>- DRM_XE_BO_DEFRAG_SIZE_LIMIT: Maximum number of bytes to defrag per
>  work run
>- DRM_XE_BO_DEFRAG_INTERVAL_MS: Default delay before defrag worker runs
>- DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS: Upper bound for defrag worker
>  interval
>

Assisted-by: LLM

NIT...Would runtime knobs be useful than these compile time knobs?

>Update xe_bo.c to use these Kconfig options as defaults via #ifdef
>guards, maintaining backward compatibility with hardcoded values when
>not configured.
>
>Additionally, disable defrag completely when XE_BO_DEFRAG_SIZE_LIMIT is
>set less than 2M by returning early from xe_bo_defrag_update() (and
>xe_bo_defrag_remove()) so BOs are never added to the defrag list or the
>worker kicked; xe_bo_defrag_add() and xe_bo_defrag_schedule() assert the
>limit is at least 2M.
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
>Assisted-by: GitHub_Copilot:claude-haiku-4.5
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/Kconfig.profile | 40 ++++++++++++++++++++++++++++++
> drivers/gpu/drm/xe/xe_bo.c         | 26 +++++++++++++++++++
> 2 files changed, 66 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/Kconfig.profile b/drivers/gpu/drm/xe/Kconfig.profile
>index e07517d120e0..e0aade41f53e 100644
>--- a/drivers/gpu/drm/xe/Kconfig.profile
>+++ b/drivers/gpu/drm/xe/Kconfig.profile
>@@ -74,3 +74,43 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
> 	  to apply to applicable user. For elevated user, all above MIN
> 	  and MAX values will apply when this configuration is enable to
> 	  apply limitation. By default limitation is applied.
>+
>+config DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
>+	int "BO defrag reclaim backoff threshold"
>+	default 2
>+	range 1 1000

Is the value of 1 intended here? As mentioned in patch 16, this will
reinforce the self backoff loop.

NIT...Also the max value of the range here and below seems too higher
than the default value. Not sure if that is intended.

>+	help
>+	  Once this many BOs are tracked on the device defrag list (i.e. were
>+	  backed with a sub-optimal page order), request that the TTM pool backs
>+	  off from aggressive reclaim at the beneficial order during populate,
>+	  so that allocations make forward progress instead of stalling.
>+
>+config DRM_XE_BO_DEFRAG_SIZE_LIMIT
>+	int "Maximum bytes to defrag per work run"
>+	default 33554432
>+	range 0 1073741824
>+	help
>+	  Maximum number of bytes the defrag worker will process in a single run
>+	  before yielding and rescheduling itself. Set to less than large page
>+	  size (2M) to disable defrag. A defrag move synchronously reallocates
>+	  and re-copies a BO's backing store, which is not free. If a large
>+	  number of BOs become eligible at once, processing them all in one
>+	  worker run would hold things up for a long, unbounded stretch.
>+	  Instead, cap the work done per run and requeue, spreading the defrag
>+	  effort out over time.
>+

The disable mechanism is confusing (0 to 2MB). May be add a separate runtime
knob for enable/disable and change the range here to start from 2MB?

>+config DRM_XE_BO_DEFRAG_INTERVAL_MS
>+	int "Default delay before defrag worker run (ms)"
>+	default 25
>+	range 1 1000
>+	help
>+	  Default delay before (re)running the defrag worker, in milliseconds.
>+
>+config DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
>+	int "Upper bound for defrag worker interval (ms)"
>+	default 15000
>+	range 100 1000000

The range here overlaps with that of DRM_XE_BO_DEFRAG_INTERVAL_MS and it
accepts value lower than that of DRM_XE_BO_DEFRAG_INTERVAL_MS.

>+	help
>+	  Upper bound for the (exponentially backed off) defrag worker interval,
>+	  in milliseconds, so repeated failures don't push the retry arbitrarily
>+	  far out. 15000 ms = 15 seconds.
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 073d926ef9ac..0bdd1c920404 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -49,7 +49,11 @@
>  * aggressive reclaim at the beneficial order during populate, so that
>  * allocations make forward progress instead of stalling.
>  */
>+#ifdef CONFIG_DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
>+#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	CONFIG_DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
>+#else
> #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
>+#endif
>

Looks like The 'ifdef's are redundent here as the config params without any
dependency take the default value and hence will always turn out to be true.

> /*
>  * Maximum number of bytes of newly (re)allocated backing the defrag worker will
>@@ -65,17 +69,31 @@
>  * Only pages a move truly reallocates are charged; pages harvested from the old
>  * backing are free, so an object larger than the budget is upgraded in
>  * budget-sized slices across runs.
>+ *
>+ * Set to 0 to disable defrag completely.
>  */
>+#ifdef CONFIG_DRM_XE_BO_DEFRAG_SIZE_LIMIT
>+#define XE_BO_DEFRAG_SIZE_LIMIT			CONFIG_DRM_XE_BO_DEFRAG_SIZE_LIMIT
>+#else
> #define XE_BO_DEFRAG_SIZE_LIMIT			SZ_32M
>+#endif
>
> /* Default delay before (re)running the defrag worker, in milliseconds. */
>+#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
>+#define XE_BO_DEFRAG_INTERVAL_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
>+#else
> #define XE_BO_DEFRAG_INTERVAL_MS		25
>+#endif
>
> /*
>  * Upper bound for the (exponentially backed off) defrag worker interval, in
>  * milliseconds, so repeated failures don't push the retry arbitrarily far out.
>  */
>+#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
>+#define XE_BO_DEFRAG_INTERVAL_MAX_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
>+#else
> #define XE_BO_DEFRAG_INTERVAL_MAX_MS		15000	/* 15 seconds */
>+#endif
>
> static void xe_bo_defrag_worker(struct work_struct *w);
> static void xe_place_from_ttm_type(u32 mem_type, struct ttm_place *place);
>@@ -1126,6 +1144,7 @@ int xe_bo_defrag_init(struct xe_device *xe)
>
> static void xe_bo_defrag_schedule(struct xe_device *xe)
> {
>+	xe_assert(xe, XE_BO_DEFRAG_SIZE_LIMIT >= SZ_2M);
> 	schedule_delayed_work(&xe->mem.defrag.worker,
> 			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
> }
>@@ -1152,6 +1171,7 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
>
> 	xe_bo_assert_held(bo);
> 	xe_assert(xe, xe_bo_needs_defrag(bo));
>+	xe_assert(xe, XE_BO_DEFRAG_SIZE_LIMIT >= SZ_2M);

xe_bo_defrag_init_early and xe_bo_defrag_init still runs if defrag is
disabled which can be avoided.

Niranjana

>
> 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
> 		if (list_empty(&bo->defrag_link)) {
>@@ -1185,6 +1205,9 @@ static void xe_bo_defrag_remove(struct xe_bo *bo)
> {
> 	xe_bo_assert_held(bo);
>
>+	if (XE_BO_DEFRAG_SIZE_LIMIT < SZ_2M)
>+		return;
>+
> 	if (list_empty(&bo->defrag_link))
> 		return;
>
>@@ -1204,6 +1227,9 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
> {
> 	xe_bo_assert_held(bo);
>
>+	if (XE_BO_DEFRAG_SIZE_LIMIT < SZ_2M)
>+		return;
>+
> 	if (xe_bo_needs_defrag(bo))
> 		xe_bo_defrag_add(bo);
> 	else
>-- 
>2.34.1
>
