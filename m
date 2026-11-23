Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G7nMw1C2;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fIRKXxVr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8A410EEEC;
	Mon, 23 Nov 2026 15:08:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B29B10EEEC;
 Mon, 23 Nov 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795446503; x=1826982503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ifxFOW6+9w+DW+7Kx0XWO7iQXfqsnkZaDC8MYBGd0ZA=;
 b=G7nMw1C2cRRZikgoY9X5gt+j1m4s/nLekMFdhuwubrZa0/GyIdtnfAXP
 MzVoL5mXOkLtgteh3j0Fw1I4kH7myeTXuUhcw58KFMwo++iSErLe78qOq
 Z8TccSAzYtsv+O3GLbzay39BxvlB5qvSMCOQIqa9rxXFK3tlWovsqxfeD
 ZMdLDUzkd3FevsMPSSsBqzsFZ80JwDrpiYN8UZ9IZmB8cjPFehJdZsQdD
 qjGi3apuSOD1UKkTlRLZjT4/n6ElyQYCHjCLGFTz0K+kqa+AGh7y/cGnR
 ziPH0anBJYhMFibiYF+g7gzhwWLfrZ+1csa4iZ6U1yG91HPkn0U+xvvYJ Q==;
X-CSE-ConnectionGUID: Xd2KMltBTUyH3SB4MQR33Q==
X-CSE-MsgGUID: oQUqNVPOTS+UkS3OUiQEXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4152099"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4152099"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:08:22 -0800
X-CSE-ConnectionGUID: umn2EqffQ9CYc76SiLUrEw==
X-CSE-MsgGUID: KcHZlfPIQoGNBQ2EWctGpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11880018"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:08:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 07:08:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 07:08:21 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 07:08:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KchdDAdOhykMukkRc6n10WtEquuM4vGYRqPrLhoSDcP/XS8KAIfcWSXiescwWZW2ka8dN9CJ21Hj9ruT2VerT6iLieLWAm0L9S/UeN97I6UYSQeh4qg6WW1c+X4OEuALDztAVnVQcg2bWJYcpD7hOFcikAdlCRITOkJa0+hSYvq+WYN39YSASdP31R0ISNdCVy/+O2nWtgq+E6wYoXz/Vev6ouPD4l4uhP6Sja7V5PXstHunAyjG0YbCEZSuBgnVQ+813eLrkVgdu3BF4XUEkBW3U4ZWt/zy9fWlCULAaAkmFg0zVF1z0ccX8rB4O6k2IlAIVzL+91k6WQsM6LN60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrPah0JQnPKqlRRlhSmF9xyDWX1aTR/5vvCQZb2Ufac=;
 b=GLjpUNHLzfpcM3F4Y3onycu+w1Fdf5VdBXdurEY7VG5cLcV8yAPANcZ80dDycBS0qadqEMQSdhp3S3VW2DxQMfceN8oUVGGq+sHaQs+qDXG2IzF3igv666cIIGf+ADxSHlkoRmkGHr/1+15dPavy9Wy5FlZeKMr9weHLwSrmklVSdtaYwI8HaL9Qp9gSTfBr0JcF9oUSTo786gc/vjJVMK6V1uiPZUw2n9V98lmjGuYc2d4r3BWowbDnLGHfbpfcyGd6snviTcEbb8sa+Pq6WhHPvf78bH+ZCUfxkCmxB1tL6pMErY8VT0IdPJ2q55KnM3b3bTtGdNVt7iWUM7bvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrPah0JQnPKqlRRlhSmF9xyDWX1aTR/5vvCQZb2Ufac=;
 b=fIRKXxVrZtNBlKtXVX9t0LLGO42XNLI5wcx7XPxVsgJ4TSUPLk1U8x1bg2j8nvLYR3wwja3k6C6hihNx21dj2MD97kTTsknE1IDt8nbtI/Cu8l6U7goCbBMURztZXM4PRm+B059tp5Mot4pEzVWqPlgefiVsWahm1MkgAp1lTIk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 15:08:17 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 15:08:17 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 2/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Mon, 23 Nov 2026 10:08:09 -0500
Message-ID: <20261123150806.2266196-6-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
References: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae29b7f-aba2-4fee-e26d-08df49739a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|261009220027099003|261022105027099003|261021123027099003|261021121427099003|261009221727099003|261009223027099003|261022075727099003|261009221227099003|261009223327099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZN/LQxUFZ3m+cnkRpQ0rhMCCexsFfF5iwRvFsjy+jpKsvxcPo78yTDxifMdJfQ1Vd9r7SBayPomJHLAsrUI2Ef+289tSLAc83Ba0xWWANdm2/WngpQwuB7LlliVDq0W6s2bbRK0gk1xkx66ZGUaYl1/ApFGqMzs3x3PXdKkcpFscAP1woerSxqAxcjTGW36TZSe9whZalZDJO4xPP1t/mlQojnbNdBqXjxKvb6nV5sxhC8KaAylQjZsqT1PNccooM8Uf+tl3ZweY3XkdZPDPbje7JIHmdCMqs6exm+s0i5Gv2V4Nq15USXdn6GSMNvdXKrk57rNB5VPAwxDWfdHiP1jYeB4g/xC86T/pDeYZtvh82AYsASl2/NaRIn+RNsuPHO9imxF5Cj7g/RtS7sFzHtW/l4UHCaJ6foaZbqq3DbQJj7nab/jOv9hzOE8yVwyAKcGMYBnZ7fZbOyqVaSbGjEXHUKrVH5avlorWuY6EC8xD0NqDmHjHNAQf4QOrEF9RKlQ5HEDBibOGy/KBKwJ5zYZgMpu19wudTR9jNNaAAVuAyWKeA9UCBgPJ4QwMtHZAGG7SkKupyryLLuTtiA/PY3CxTn1Q0shKscgdPWFFOtBpRZW0AjXtC+2d05QwunVYkL1fBfjzLnpv/BZBbZx6JlzDZ68wQLoBxGkJEk5eReI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261009220027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009223027099003)(261022075727099003)(261009221227099003)(261009223327099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xx9XCU/yTef1HScpWpoB3YPLYSqdQMWgalXwsXiY5c38YgfsRu75vBVy7mqx?=
 =?us-ascii?Q?zyUEi4JBYCXLDOlN77/aoWV1laqeTzjYfEW3n8I1k2J0lO0BBaYs85PQrAcI?=
 =?us-ascii?Q?VYT6QFrq0LP4uTPGNcc0BxbMUShfbI6nyUWH7IDCUrZv5qA6qdY31KDiejiH?=
 =?us-ascii?Q?85COAzuNBzxXLvl8RKq0wS7rJn9V266TiMAAEkt6dBXexxBmVuH3NiVnZe9c?=
 =?us-ascii?Q?bNVsrHaut+UbQgD0VXvi1hgbGIPo2Mras1rmHGirNyEztYc9CH+m0jTyp5HC?=
 =?us-ascii?Q?xfGRx8xc++pcTNlOyZL8UPDSFor3xFI5XymxCIBR3vRQoNCrNx5xpNfxZHQU?=
 =?us-ascii?Q?CuJmQWD8HwldU6ZnmT9KzLfDkmOC3mHHyAi5q/BusQAT4sE+mBATVPZLbP9O?=
 =?us-ascii?Q?RaiGnBt3o8i9kT0blxZu33DE6TMUGcvCtFmqPjVzTT6ZRUjk4A8pCUe0Lc6E?=
 =?us-ascii?Q?D0blRbTXNMRH8VrsXbwtD0PuFN6gZVkeftX7Y42E1Rq82JcgRnV6MtcKIp2g?=
 =?us-ascii?Q?yuu6OkQjDTCs6MVPtxIXWPQtESdVIDejOBXPQFMj8NurfZrszSXNbs+M/ikq?=
 =?us-ascii?Q?erfiauzcf0XBVAymcpZ0pkz4JHMOkrvTadqHjHlitPQuGnGfPh1IJlRHqCiJ?=
 =?us-ascii?Q?zwfxovO+n7qCFKU86WjjXi+TinqzHZzi1L/ULCqyQJuwJ3rPeZKxi5piRle8?=
 =?us-ascii?Q?JkiWUPR7bNm3/U3bvKWM47H9kkJX67tki1tE6fPcf3p0bJlXgogdEPyqRLMy?=
 =?us-ascii?Q?yZ73SgTJa6XstE9LoWGuXHz9NHOToUmqT+037eRCoTeflX9fFlxC8MOPuY0G?=
 =?us-ascii?Q?oWhLAPn+ECEeGsOVaQpdJtT/PiQybmso+Av6pb977w4OVj3CZF0LgD1qmTL2?=
 =?us-ascii?Q?hapsxYrORso8xxB7Px6Kw7hdOrsYc6A1vYpLT5lGc2qsKBeU6vi49eaVjX0p?=
 =?us-ascii?Q?U9Ds7n9F5dc3a8L+q1odj+qNlNrdqQImwh8lGgFOxu/7eOEgH0F+LAhPnzNA?=
 =?us-ascii?Q?rz90Nxj/LRtSU2ymhIr3I9amOizLtIa/PB3PMNi6NIwLTAj/BTbbkcUMIZUn?=
 =?us-ascii?Q?3QzAaQ2eBn36k6VfHfJGFhZnQE50niJHNlFfx5KTrTV2qg/W3boMV8Gma3y4?=
 =?us-ascii?Q?mEMZI7OmMKJ/aTHOsMeibWfbFXpqD5/hJyuJ6t+ov8N9pWsComyuoJAP6iea?=
 =?us-ascii?Q?hhALtjpA1VlwYVwlRIrAUF6CwAqQUIjDleeccuGfYeCHtxBHk43GavKhM/P7?=
 =?us-ascii?Q?k9pBAjHWLc7itoG1Ii0BQIE2C84MT+TWitLtlzqwz1j1WAPp2nH1BdKw+uXJ?=
 =?us-ascii?Q?qIY2SgSqQ1J68czJaH2BmhRIsFAQkCNnRA/NFZ0b7O1I62noQYaSMsMIx3m9?=
 =?us-ascii?Q?iLI6Cr/4lNEiQ6Msf9sWuMmuUtKm8hBsuIIgWeYT4GzalXb+hNVhiwNcXlgR?=
 =?us-ascii?Q?5J7lgOzJXF29sfNPeIOJCyAjgBD1KViJUEF8XNo3uCRVUoBISoK8gFfCqyuI?=
 =?us-ascii?Q?kDB287A3tXb/BhtVHC6vGZZ0AgZRmEluyK6DHUnM30KAjLHWRu3RTi12nEgb?=
 =?us-ascii?Q?TWieTXssOlNDfAPwpbanZFZHqHv3zogDx+Ctct/NmDrNHZjg6tUtsCwF8RiY?=
 =?us-ascii?Q?47Zj3MgxN3AWV8jFuTlyJTYtH0xpbrvkAFxpdItOGDaRs/vt2cERpctoZzFg?=
 =?us-ascii?Q?o80J2OaWxfTm+HrQCvIib+ugu4qvxLX3WJ9GcCLWzovUrPEVXXjGLaGc4fkX?=
 =?us-ascii?Q?9UwiD7DmCw=3D=3D?=
X-Exchange-RoutingPolicyChecked: MOXyAaIuyTlVFnVKrtBzfmnUKn44LbGsU8/pcpfCzx4CIiTJdB0vW4PGWnbZ/i2P4DyPixTrnKYIy2VOffBYJtWj62WQRudYDHX7bKsUplm+pvfRz8jjpq6OgSQ3lYY+wbP5G7m/9IBIi5LrfNh1xbEDny7ks3GZBV5XLhUIwOfqc/olS5DrrdcLLI3/lxErdAWM4feU6Jp04iV6FH1+1F/M2sB4PylRxlTL3sWApe+QdkgezuqyXIpUGJiVHrhs4rzey/R0DKoSnHpavQL/5UK6i9DOoJYcQjQ3wMqFk88ZAG/tzQlfHLr786aCHRS+3Xtw+xi9FkRPnOkobA0WSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae29b7f-aba2-4fee-e26d-08df49739a49
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 15:08:17.0190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUly4g3TYz5SnU+PuRgSRl880F/1klG0BllODSKMasIhfiQwjPXRQjcnI34PXzreYPKHfz973dYhTkK5OQGmcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Retired VRAM pages are only visible through the vram_bad_pages debugfs
file today. Register a drm-ras retired-pages node so userspace gets
them, and the maximum number of pages that can be retired, through a
stable interface.

The page lists are walked under the VRAM manager lock, and a generation
counter on each manager lets drm-ras flag dumps that raced with a page
being added, retired or failing its reservation.

v3 (Rodrigo+LLM):
 - Use the drm-ras retired-pages node type, which replaces the nested
   retired-resources layout (Jakub).
 - Walk the lists under mgr->lock instead of RCU, which they are not
   protected by, and stop reading the buddy blocks (Sashiko).
 - Add a generation counter for interrupted dumps.
 - Keep the vram_bad_pages debugfs file for now.
 - Remove deprecated Assisted-by tag.

Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c            | 56 +++++++++++++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       | 72 +++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h       |  3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |  5 ++
 4 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7554803aae11..b4ace09f9772 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -12,6 +12,7 @@
 #include "xe_device_types.h"
 #include "xe_drm_ras.h"
 #include "xe_ras.h"
+#include "xe_ttm_vram_mgr.h"
 
 static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
 static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
@@ -230,6 +231,54 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+static int query_retired_page(struct drm_ras_node *node, u64 cursor,
+			      struct drm_ras_retired_page *page)
+{
+	return xe_ttm_vram_get_retired_page(node->priv, cursor, page);
+}
+
+static int query_retired_pages_info(struct drm_ras_node *node, u64 *max_pages)
+{
+	*max_pages = xe_ras_get_max_pages(node->priv);
+
+	return 0;
+}
+
+static int register_retired_pages_node(struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct drm_ras_node *node;
+	int ret;
+
+	/* Retired VRAM pages are only tracked on platforms with page offline */
+	if (xe->info.platform != XE_CRESCENTISLAND)
+		return 0;
+
+	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
+				      pci_domain_nr(pdev->bus), pdev->bus->number,
+				      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!node->device_name)
+		return -ENOMEM;
+
+	node->node_name = "vram-retired-pages";
+	node->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
+	node->query_retired_page = query_retired_page;
+	node->query_retired_pages_info = query_retired_pages_info;
+	node->priv = xe;
+
+	ret = drm_ras_node_register(node);
+	if (ret) {
+		cleanup_node_param(node);
+		return ret;
+	}
+
+	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+}
+
 /**
  * xe_drm_ras_event() - Report drm-ras error event to userspace
  * @xe: xe device structure
@@ -294,5 +343,12 @@ int xe_drm_ras_init(struct xe_device *xe)
 		return err;
 	}
 
+	err = register_retired_pages_node(xe);
+	if (err) {
+		drm_err(&xe->drm, "Failed to register DRM RAS retired pages node (%pe)\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 36d47de8b11b..6c1885a92f19 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -10,6 +10,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_buddy.h>
+#include <drm/drm_ras.h>
 #include <uapi/drm/xe_drm.h>
 
 #include <drm/ttm/ttm_placement.h>
@@ -240,13 +241,17 @@ static void xe_ttm_vram_retry_queued_pages(struct xe_ttm_vram_mgr *mgr)
 					    PAGE_SIZE, PAGE_SIZE, &pos->blocks,
 					    GPU_BUDDY_RANGE_ALLOCATION, NULL,
 					    &pos->used_visible_size)) {
-			pos->status = XE_PAGE_RESERVE_FAIL;
+			if (pos->status != XE_PAGE_RESERVE_FAIL) {
+				pos->status = XE_PAGE_RESERVE_FAIL;
+				mgr->retired_gen++;
+			}
 			continue;
 		}
 		--mgr->n_queued_pages;
 		list_del(&pos->queued_link);
 		++mgr->n_offlined_pages;
 		list_add(&pos->offlined_link, &mgr->offlined_pages);
+		mgr->retired_gen++;
 	}
 }
 
@@ -625,6 +630,68 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
 	return avail;
 }
 
+static void retired_page_update(struct drm_ras_retired_page *page, bool *found,
+				u64 cursor, u64 addr, enum drm_ras_retired_page_status status)
+{
+	if (addr < cursor || (*found && addr >= page->address))
+		return;
+
+	page->address = addr;
+	page->status = status;
+	*found = true;
+}
+
+/**
+ * xe_ttm_vram_get_retired_page - Get the next retired VRAM page
+ * @xe: xe device instance
+ * @cursor: lowest device address to consider
+ * @page: filled with the retired page that has the lowest address >= @cursor
+ *
+ * Return: 0 on success, -ENOENT if no retired page is at or above @cursor.
+ */
+int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
+				 struct drm_ras_retired_page *page)
+{
+	struct xe_ttm_vram_offline_resource *pos;
+	struct xe_tile *tile;
+	bool found = false;
+	u32 gen = 0;
+	u8 id;
+
+	for_each_tile(tile, xe, id) {
+		struct xe_vram_region *vr = tile->mem.vram;
+		struct ttm_resource_manager *man;
+		struct xe_ttm_vram_mgr *mgr;
+
+		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
+		if (!man || !vr)
+			continue;
+		mgr = to_xe_ttm_vram_mgr(man);
+
+		guard(mutex)(&mgr->lock);
+
+		gen += mgr->retired_gen;
+
+		list_for_each_entry(pos, &mgr->offlined_pages, offlined_link)
+			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
+					    DRM_RAS_RETIRED_PAGE_STATUS_RETIRED);
+
+		list_for_each_entry(pos, &mgr->queued_pages, queued_link)
+			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
+					    pos->status == XE_PAGE_RESERVE_FAIL ?
+					    DRM_RAS_RETIRED_PAGE_STATUS_FAILED :
+					    DRM_RAS_RETIRED_PAGE_STATUS_PENDING);
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	page->size = PAGE_SIZE;
+	page->generation = gen;
+
+	return 0;
+}
+
 static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
 {
 	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
@@ -825,6 +892,7 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
 			/* Queue free(to-be-purged) pages */
 			++vram_mgr->n_queued_pages;
 			list_add(&nentry->queued_link, &vram_mgr->queued_pages);
+			vram_mgr->retired_gen++;
 		} else {
 			/* Immediately offline unoccupied pages */
 			/* Queue free(to-be-reserved) pages */
@@ -839,10 +907,12 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
 					addr, ret);
 				++vram_mgr->n_queued_pages;
 				list_add(&nentry->queued_link, &vram_mgr->queued_pages);
+				vram_mgr->retired_gen++;
 				return 0;
 			}
 			++vram_mgr->n_offlined_pages;
 			list_add(&nentry->offlined_link, &vram_mgr->offlined_pages);
+			vram_mgr->retired_gen++;
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
index d77f067d197b..91147385718c 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
@@ -9,6 +9,7 @@
 #include "xe_ttm_vram_mgr_types.h"
 
 enum dma_data_direction;
+struct drm_ras_retired_page;
 struct xe_device;
 struct xe_tile;
 struct xe_vram_region;
@@ -33,6 +34,8 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
 			  u64 *used, u64 *used_visible);
 int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
 int xe_ttm_vram_inject_fault(struct xe_device *xe);
+int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
+				 struct drm_ras_retired_page *page);
 
 static inline struct xe_ttm_vram_mgr_resource *
 to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
index 4a2cd27a5b61..6a49ee8b09ef 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
@@ -27,6 +27,11 @@ struct xe_ttm_vram_mgr {
 	struct list_head queued_pages;
 	/** @n_queued_pages: Number of queued pages */
 	u16 n_queued_pages;
+	/**
+	 * @retired_gen: Changed whenever @offlined_pages or @queued_pages
+	 * change. Protected by @lock.
+	 */
+	u32 retired_gen;
 	/** @visible_size: Probed size of the CPU visible portion */
 	u64 visible_size;
 	/** @visible_avail: CPU visible portion still unallocated */
-- 
2.56.0

