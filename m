Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC5606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4Q6O6Lg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bolmAwqG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB7710E0EC;
	Tue, 24 Nov 2026 20:25:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C5610E0EC;
 Tue, 24 Nov 2026 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795551923; x=1827087923;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=4pbKYZMuF0wl/tKF2KmUQXqgCF6xDFzhCQxffoqP9G4=;
 b=k4Q6O6LgUZylKakwxTetySwTF/OPzjNW+BYjYQnl3BAa5jpwqVNhY3bo
 vw9pnCUk7zZIDNOy5wkBBpUP/w5N3cq+qiZh6P4l0eCLreIKhtl2zX9kT
 xgtNO0Pvh+6oP9CJ2oHsrPrWt5uAm5/TNRpyQFBYf5Pg8/h3E4LX00sVv
 6UjtfBUMAMOL65aV+95X2a0Ayy1iAFCKz4Ss9GaVchix3FAgSWAR7vG5b
 RGtdylem+lrFM+K6o2YJRMpwgYF1/oaEEL0ZWIrrLDes+hpLYq3TQCYYz
 kLJ8pUmj95shyEvSNklE0GScqzLd31lZ+riNRcvAWAApG5DqN1wcLQFVC g==;
X-CSE-ConnectionGUID: cGRmmZCKSR2fivaSzkOnsA==
X-CSE-MsgGUID: YRUqDQHMTTqKbARvhXTukg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4413934"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4413934"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:25:22 -0800
X-CSE-ConnectionGUID: 5snb+KINSJG+Pa+1GV/OaA==
X-CSE-MsgGUID: NAii23F5RzCCve1wbiU4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11651131"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:25:22 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:25:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:25:21 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4EtDxRuh07EA6Gyxj/dJwMV5no/+Xsi6uffWMleuCmQwFt0sR6AoTOm3/IFVUEEq7WVT5VW/urTQGg2Cwubc1lx2VCuZfPi/h4wUlglb+SZdTEDKHmaY+W5YuGdPdThWZHJaYKlJH5f/uwI/2fiFPoPsGA4LkMqFZ6hyFxiaZBKRhqypXt2VHYJMY4rn71UeYMdPjVb3UvW79A201+rqKz+b1WJh+ee5icVp0dLSe8Kz3moCkRa0psEoS/MWGYIs4pTUB9nTsbLT5FMKhgHfNQU8UtEdQiIftHaau++6jDWe5pbYmlTpKiwPb0xSlMd0hCLfpDcervpRF9m7LqRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqoKBtrxeIxpo1Cs2xDm0ZxNiRTp1vOQwnhTYcbdV5E=;
 b=zOIVXj8tLME97neIV1ygoz6TpFCPVLvwIWa0KxR0bLRhFFkVZClibcEYpt/RkOEM34ze73Mcuvz/HCt9fYz0qh96nhN0kg7Axc0olGYCsE46tw5M+VmDvy2NtPrihgfgBHaZb6DfL/AbKMVC1OJqMOqrKB0SHQRGIKpXb9ItQB1lUCCdZkxv5vlRXeAMsui6oNhTmwV1f2ffH3yjyRetIN34zY+Jk9qEHqc4IkN/WchsScfjbUelOXVlQRC9Fbn2xhzSAFN3pnVJKlNUXt04xFur1wOQKaGiGMGmoSTPXj6eudTbGZ5EsasXHS3yD7qnCIXt6lF+HUhv37Lv6Poktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqoKBtrxeIxpo1Cs2xDm0ZxNiRTp1vOQwnhTYcbdV5E=;
 b=bolmAwqGSlave8rHCpnwYb10vt+Lu/vEbavEp07Uvp8z21vI3Jf4k1tjEJz4xyRXFV3tt/gb+jT6LXsHnXDMwVYhkViK+coKfcwufzVjNkB5hTmlxzJTQvRnWfaecwvdcaYyoU89Cdg7Lz5V5xC3LKNN3SOmc12j/CBZAjldjUg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH8PR11MB794219.namprd11.prod.outlook.com (2603:10b6:610:37a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 20:25:17 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:25:16 +0000
Date: Tue, 24 Nov 2026 12:25:13 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
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
Message-ID: <awXyqUnYNi7ptTRX@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-23-matthew.brost@intel.com>
 <avEiW3AKOAi8Gy3C@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avEiW3AKOAi8Gy3C@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH8PR11MB794219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a572f38-1d95-4c15-6593-08df4a690d78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|376014|261026140227099003|261022075727099003|261102123227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|4143699003|5023799004|11063799006|10067099003|56012099006|260925021911599003|260925022911599003|260925021311599003|22082099003|261009220027099003|261009221227099003|261009223327099003|261009221727099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: r4IH0TxdIpyYERqHDqyMorVbUXaOmG8pPelWxpr6mb8MQD76082j66OkAC1SdrBOVky8WkcTpkoDP24OowzANrk0ToQG+jiZmSWT0XO5cLss1uQl69JjxYxmHnmsCeuiernL96CBws1N3mpiB6JUxn1sIVA7I3Yq5HIGWl+GbFnLRMfRNu8cqrdtsJ+IFlxsJhrje/lKHzHF4+9Y4aKB0guFrAv7r7g41/SjwyRPUxRxSxPmvPyQ8+LOWnFrQITf0z9TQRgbG5hr9b6UPE7/Od2OTNeMxNuZAkLxOmcnCswdF1HFUpBAyBPaPlsA5r7Y3JQBaYDjxut78PUdJnPOmuc3yYSkieaVq7uikpzRoBc3kDCeaV9YpuzjnYRTTr/7Crj/SYQSAmAAPyEiX6Ril6AGcTE6ZnUdSpLpSZ2A9tmYzsFUOyhCphDfU6lUi7gFqb0mlzOzcDZpYIjxf+fOHUsMQ15mZPhCOpjeS4FJ8CbbMa/d/tHCQibj4Atwh2bY1LQbjWSNkqbz/D5BDK2FGGSHyPtKKbxBHynzYEV6fVzp4pZ1GvsAuj+SshmM2kO+wQZKptCwecNKZOM+0qDdQNZQ/ZkvdPsigtykJyhfb9iVYsKyer40KPn3ZDEKn3HcyKbJe3mcEuL7URq928loHIdImgEd/xdVGB9/RM7uv9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(261026140227099003)(261022075727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(22082099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?B5XM1MXGOgyCZz5zo7DLba8AcHfThE5rXpo2SeRL2QEMYDPkwi6ch4MBS5?=
 =?iso-8859-1?Q?JbWBtxWlw0BP/+MPkVcvYk1saqo29s2KmvTrA4hARUg4EyI41Sx7ybhJ/Y?=
 =?iso-8859-1?Q?OnGVNd7+6C2csR0bgxh7bg+9vA9kh+PIBELprjIk7ZpOQz+JGNcr7v8Wmq?=
 =?iso-8859-1?Q?N4vpNdLks1y67480o4HDZBjmd1b+R69lHP9Qs4uTDKTt6HEvkVApPzLxua?=
 =?iso-8859-1?Q?r3uxLhcAvccgcHjWgS2oLlr8tRVony/ktCB9tYmbS+PNCRNjCi7Tl783kM?=
 =?iso-8859-1?Q?cuum3KfsMBxVuISuyDD7UbcNg9vJME55lNR1bmM+ZjWMsp3Qi5Nwy5pfqF?=
 =?iso-8859-1?Q?Gri7JfLhkmV8GEiacp3i0GfaCdzTYDwTkKeVzYFRu7IWDBFS2Yn26xBQjq?=
 =?iso-8859-1?Q?09De75m4a5AaOwS1jBglpEPZ8XAquXtbpKW0/xbLStPaArHoN8yjU3clxd?=
 =?iso-8859-1?Q?MhiiAJZcB3c7T0YeMmzK36d0Z3zzDMHv8vCQ5V+1ZC0RK/UvbmgGoKBkQY?=
 =?iso-8859-1?Q?tSCP8Aid1lDqQetU9ZraXqmpJNYsO7i8HP+ud38Bo9HRIzeeoFtxi0CwBH?=
 =?iso-8859-1?Q?bCHchy1yZtES/A16tdSjiTvk/27JSUbkuLG2BVxVHA5MjlZ8OEm+AzIfAv?=
 =?iso-8859-1?Q?FcgzprwYzRZrOj6WcUngKYLNkwf7Swe1b/VagTgI/LlWau803fh3Hvm7Cw?=
 =?iso-8859-1?Q?VAE8hpE4XDu2sd5mHALJ42+UOjKSNHK/7zXa3ZMNUydIxS1KgOZDFyV518?=
 =?iso-8859-1?Q?nksIuni3LNoutd8M2UkCVmKqHEtg6THqbIn3YsqWVefjnovLYeBuxh90QY?=
 =?iso-8859-1?Q?ME23BzRHKjeQxyLs9X922QU0AV7AaQgfDYBn1Cc8Cyg4uL97lmIsggBZOX?=
 =?iso-8859-1?Q?dFvmj5rlUtbJhJJwZhMMy8jE19DPJjkstbRMJXWZBvEVX0VxadMb+GATFO?=
 =?iso-8859-1?Q?Z24gzd7Be3n7Uoh/AHqu6ndI6uuzSrntcyAzanAucfARGrDFzIbTD9GUAm?=
 =?iso-8859-1?Q?vqXV5fpcDRcDRRsWtDJ0SuUxRuKLbtJPZAqHnU6DkAAiFxqYF/Zyavil+2?=
 =?iso-8859-1?Q?vmSEOJdmFxt3dtaelXtwlUAIZU/8GNfhox9D5XwF+s+dJYj9u5F1kN36jZ?=
 =?iso-8859-1?Q?uBnd2jLdIfpykINI6xJjfQV+b2HXIArVB8XgH3+ishq7BuAhPvkY4bRJ6O?=
 =?iso-8859-1?Q?ot08Nsn2ddDSIjrRcEAT3a0RkmdWcHQLLF7JoBxND50DrqhSm0zfdBvgJX?=
 =?iso-8859-1?Q?bKjjkBKpWOiIiDYjDraRXW18fPXZx92T+1IDf6TVYOR3ZMUTlF61Xp++81?=
 =?iso-8859-1?Q?rXDYgVomRsOq5ajl4vcHQL5pB+rCjKejbFGbc8pEhROctqFaRe5QVg8VJ1?=
 =?iso-8859-1?Q?d6ETB4e+owZzRjKOd/iNhF9eviAqA9p/dWqMgbyv42wCpOEVjbx3pOuyiQ?=
 =?iso-8859-1?Q?SI87VwW6wkB7gMInLlDaZU8VrKmv6VXSZC2kc8CATSqlTfl0jd5divopOZ?=
 =?iso-8859-1?Q?298cEgVsK87EIgIzkqV+DW145z6+A7oZ+jpjPnd8gU3fAbnc9kMBD+WnPC?=
 =?iso-8859-1?Q?9UUZFfwh644K4fSHIvkpDG+wCrjzLI87AGzOaFmO3NpFIAI7nXYgy4Rbx1?=
 =?iso-8859-1?Q?pe+CEYGMWtlAYXDnIe+bYH0fVFXi7YJ7TVVN4Zsea5SmkgqhyyngOtwDZh?=
 =?iso-8859-1?Q?sxlf09iKr0JBHbapUi4pFDubVXBTjSSBINo68VfT48CONKOOuWNJZMZfi9?=
 =?iso-8859-1?Q?LnrHi4Qbj7ORyt3U+axNeWFPwn3tC4XORlWh8CI9XUx52mtAe+NOP94Gcg?=
 =?iso-8859-1?Q?KL+xJ7XgxA=3D=3D?=
X-Exchange-RoutingPolicyChecked: LeLmEPB/qPklPnMdKKYwRXv+KCW+tl805IJIgR/B7wZ7nehZ78GtabYC+4AJPVFTMv6EIwO1D3fJCxIG45DvE8cfpSaSYYx4swehwOiuKCClfMVv+CfW7bfFLe8QW4JLp1mEFGRHObA/obEpP2OztFvUSMxhnvDIcZS4pZTO62A4qqbTqvApXkBdxrHszmCNgKXKEWvrMr4OAqPyOsDkkbiOSxwEv3oJMKCyADr3W4sa0MOTkSqftK+mPEvMIS276tfNMF2El1Jxu6aRd+3uIYkfGbqCZdUO7Hy6+CgVUgRgoUB3xkMlhjgQUJHb1ejb11vJBv0094F4PdfSy685Ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a572f38-1d95-4c15-6593-08df4a690d78
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:25:16.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAWUAOD0jiuHesZxqN9cJdYBVzox+AIveaNPA2UPG4sftgXTDOsiPgkVKC87/GQdPcZ5Y5j1NIen5HD6HeVfZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB794219
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

On Sun, Nov 08, 2026 at 05:31:07PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:08PM -0700, Matthew Brost wrote:
> > Add Kconfig.profile options to make XE_BO_DEFRAG_* defines configurable:
> > - DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD: Threshold for TTM reclaim
> >  backoff
> > - DRM_XE_BO_DEFRAG_SIZE_LIMIT: Maximum number of bytes to defrag per
> >  work run
> > - DRM_XE_BO_DEFRAG_INTERVAL_MS: Default delay before defrag worker runs
> > - DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS: Upper bound for defrag worker
> >  interval
> > 
> 
> Assisted-by: LLM
> 
> NIT...Would runtime knobs be useful than these compile time knobs?
> 

Yes, I think these will need to be made into runtime knobs. We'd still
have Kconfig for default though. 

> > Update xe_bo.c to use these Kconfig options as defaults via #ifdef
> > guards, maintaining backward compatibility with hardcoded values when
> > not configured.
> > 
> > Additionally, disable defrag completely when XE_BO_DEFRAG_SIZE_LIMIT is
> > set less than 2M by returning early from xe_bo_defrag_update() (and
> > xe_bo_defrag_remove()) so BOs are never added to the defrag list or the
> > worker kicked; xe_bo_defrag_add() and xe_bo_defrag_schedule() assert the
> > limit is at least 2M.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-haiku-4.5
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/Kconfig.profile | 40 ++++++++++++++++++++++++++++++
> > drivers/gpu/drm/xe/xe_bo.c         | 26 +++++++++++++++++++
> > 2 files changed, 66 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/Kconfig.profile b/drivers/gpu/drm/xe/Kconfig.profile
> > index e07517d120e0..e0aade41f53e 100644
> > --- a/drivers/gpu/drm/xe/Kconfig.profile
> > +++ b/drivers/gpu/drm/xe/Kconfig.profile
> > @@ -74,3 +74,43 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
> > 	  to apply to applicable user. For elevated user, all above MIN
> > 	  and MAX values will apply when this configuration is enable to
> > 	  apply limitation. By default limitation is applied.
> > +
> > +config DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
> > +	int "BO defrag reclaim backoff threshold"
> > +	default 2
> > +	range 1 1000
> 
> Is the value of 1 intended here? As mentioned in patch 16, this will
> reinforce the self backoff loop.
> 
> NIT...Also the max value of the range here and below seems too higher
> than the default value. Not sure if that is intended.
> 

This is getting dropped. As I mentioned in other patches I'm changing
this blindly turn off reclaim for all foreground allocations and only
allow the defragmenter to flip on reclaim. This is the desired behavior
for all client systems to avoid missing page flips at all costs.

> > +	help
> > +	  Once this many BOs are tracked on the device defrag list (i.e. were
> > +	  backed with a sub-optimal page order), request that the TTM pool backs
> > +	  off from aggressive reclaim at the beneficial order during populate,
> > +	  so that allocations make forward progress instead of stalling.
> > +
> > +config DRM_XE_BO_DEFRAG_SIZE_LIMIT
> > +	int "Maximum bytes to defrag per work run"
> > +	default 33554432
> > +	range 0 1073741824
> > +	help
> > +	  Maximum number of bytes the defrag worker will process in a single run
> > +	  before yielding and rescheduling itself. Set to less than large page
> > +	  size (2M) to disable defrag. A defrag move synchronously reallocates
> > +	  and re-copies a BO's backing store, which is not free. If a large
> > +	  number of BOs become eligible at once, processing them all in one
> > +	  worker run would hold things up for a long, unbounded stretch.
> > +	  Instead, cap the work done per run and requeue, spreading the defrag
> > +	  effort out over time.
> > +
> 
> The disable mechanism is confusing (0 to 2MB). May be add a separate runtime
> knob for enable/disable and change the range here to start from 2MB?
> 

Ok.

> > +config DRM_XE_BO_DEFRAG_INTERVAL_MS
> > +	int "Default delay before defrag worker run (ms)"
> > +	default 25
> > +	range 1 1000
> > +	help
> > +	  Default delay before (re)running the defrag worker, in milliseconds.
> > +
> > +config DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
> > +	int "Upper bound for defrag worker interval (ms)"
> > +	default 15000
> > +	range 100 1000000
> 
> The range here overlaps with that of DRM_XE_BO_DEFRAG_INTERVAL_MS and it
> accepts value lower than that of DRM_XE_BO_DEFRAG_INTERVAL_MS.
> 

It does but there isn't a way Kconfig to enforce this. If someone really
wants to compile with a broken Kconfig, IMO that is a user problem.

> > +	help
> > +	  Upper bound for the (exponentially backed off) defrag worker interval,
> > +	  in milliseconds, so repeated failures don't push the retry arbitrarily
> > +	  far out. 15000 ms = 15 seconds.
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 073d926ef9ac..0bdd1c920404 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -49,7 +49,11 @@
> >  * aggressive reclaim at the beneficial order during populate, so that
> >  * allocations make forward progress instead of stalling.
> >  */
> > +#ifdef CONFIG_DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
> > +#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	CONFIG_DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
> > +#else
> > #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
> > +#endif
> > 
> 
> Looks like The 'ifdef's are redundent here as the config params without any
> dependency take the default value and hence will always turn out to be true.
> 

This is existing style for everything in Kconfig.profile

e.g. Look at xe_hw_engine.h

> > /*
> >  * Maximum number of bytes of newly (re)allocated backing the defrag worker will
> > @@ -65,17 +69,31 @@
> >  * Only pages a move truly reallocates are charged; pages harvested from the old
> >  * backing are free, so an object larger than the budget is upgraded in
> >  * budget-sized slices across runs.
> > + *
> > + * Set to 0 to disable defrag completely.
> >  */
> > +#ifdef CONFIG_DRM_XE_BO_DEFRAG_SIZE_LIMIT
> > +#define XE_BO_DEFRAG_SIZE_LIMIT			CONFIG_DRM_XE_BO_DEFRAG_SIZE_LIMIT
> > +#else
> > #define XE_BO_DEFRAG_SIZE_LIMIT			SZ_32M
> > +#endif
> > 
> > /* Default delay before (re)running the defrag worker, in milliseconds. */
> > +#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
> > +#define XE_BO_DEFRAG_INTERVAL_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
> > +#else
> > #define XE_BO_DEFRAG_INTERVAL_MS		25
> > +#endif
> > 
> > /*
> >  * Upper bound for the (exponentially backed off) defrag worker interval, in
> >  * milliseconds, so repeated failures don't push the retry arbitrarily far out.
> >  */
> > +#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
> > +#define XE_BO_DEFRAG_INTERVAL_MAX_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
> > +#else
> > #define XE_BO_DEFRAG_INTERVAL_MAX_MS		15000	/* 15 seconds */
> > +#endif
> > 
> > static void xe_bo_defrag_worker(struct work_struct *w);
> > static void xe_place_from_ttm_type(u32 mem_type, struct ttm_place *place);
> > @@ -1126,6 +1144,7 @@ int xe_bo_defrag_init(struct xe_device *xe)
> > 
> > static void xe_bo_defrag_schedule(struct xe_device *xe)
> > {
> > +	xe_assert(xe, XE_BO_DEFRAG_SIZE_LIMIT >= SZ_2M);
> > 	schedule_delayed_work(&xe->mem.defrag.worker,
> > 			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
> > }
> > @@ -1152,6 +1171,7 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
> > 
> > 	xe_bo_assert_held(bo);
> > 	xe_assert(xe, xe_bo_needs_defrag(bo));
> > +	xe_assert(xe, XE_BO_DEFRAG_SIZE_LIMIT >= SZ_2M);
> 
> xe_bo_defrag_init_early and xe_bo_defrag_init still runs if defrag is
> disabled which can be avoided.
> 

I'd rather not special case the init functions as they are harmless to
run. Also if we switch runtime control of the defragmenter, you'd always
have to call the init.

Matt

> Niranjana
> 
> > 
> > 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
> > 		if (list_empty(&bo->defrag_link)) {
> > @@ -1185,6 +1205,9 @@ static void xe_bo_defrag_remove(struct xe_bo *bo)
> > {
> > 	xe_bo_assert_held(bo);
> > 
> > +	if (XE_BO_DEFRAG_SIZE_LIMIT < SZ_2M)
> > +		return;
> > +
> > 	if (list_empty(&bo->defrag_link))
> > 		return;
> > 
> > @@ -1204,6 +1227,9 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
> > {
> > 	xe_bo_assert_held(bo);
> > 
> > +	if (XE_BO_DEFRAG_SIZE_LIMIT < SZ_2M)
> > +		return;
> > +
> > 	if (xe_bo_needs_defrag(bo))
> > 		xe_bo_defrag_add(bo);
> > 	else
> > -- 
> > 2.34.1
> > 
