Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE49BCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5756B10EF29;
	Thu, 11 Jun 2026 13:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AKRglGZ4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980F610E7A8;
 Thu, 11 Jun 2026 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781185587; x=1812721587;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xr1Vtgdl1KYgBCPmVTLWQJroFN5Vjv2SSGIapLUaOPI=;
 b=AKRglGZ4NUm5N3vpsohalSRgvkL6AEnb2AzFXc/pnpoce9O4L02SRsWc
 lYPMUnzyt//htl4+dE6lG6AesTegnNwNI0r5p+D0QdsqnjT8VtKzJV16C
 0lZclPTiaFrWR9xQfeQrpDu8Df03SGGBZXTNiEpmsIa1qQ4z7h4d16sUK
 2qQ45EZn66ISoPCiRA8R8+j3CxnYsAJHKh3mx+n9RENAj9ptyyEpUhD6N
 RAvq1uWfAfrRfW+zCKwt+7gB7aZ7lZRLUvluOhvxTU3lJ0UmYIYcUy71C
 D0pUXeZ6myBUFHtReukmmOEEVsHmZzKG+kputOPeiuzg42J5u0uZioKUm A==;
X-CSE-ConnectionGUID: 5Jjk+0tQTNiZgq3Va4MWMw==
X-CSE-MsgGUID: 3gQpyY+pRO+iGvPqsJxm6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99574010"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="99574010"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 06:46:25 -0700
X-CSE-ConnectionGUID: v/ZYqII/S1KN58YDf/019g==
X-CSE-MsgGUID: Oj+V9k3SQGCrRX8VGvUDEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="250767070"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 06:46:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 06:46:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 06:46:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 06:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B51nU8hoY0AWJH96Iu1+Tk/P/uLGo6/UQf0ecPWDsMfuJVCT7nsXodehz8kiad2Sxo14Q4k5WjsMMwY3hO8oaIxeLQCVX5SGJU6dp1g76WxGQaEXnXWUoQwWMIJgerkQ3mzyXyu/2UCIj2MDMuXDWxBS4Bhz9y/LuNF4XnNsoK6enzzc1ApN/7kYcwgLhgJTzQceDJNYa81O59iR5qDFRM/rIaI2lV1HFUKg2CyLE0ESsu6YQQF6fCCmJBMzuNTl45lWebqKhOEcR9iF6S0mFD5OqwT4AEztWR+/tebcI2IJEjoBQjNUj87Qj/pBw09QA02hXMpUoJpa0gtxKz7DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgdjhrHylazbLbtKwxoVrL6+1/gPJLQbVgc9uiDJVD8=;
 b=akpH8FRyrNlk3X58+Xqhf7sji4V310yq4lsV9Qi0U1LLCFsPeLdKAdDeZvLKt6U7q9LXJiaYgRNhEuxbzjDa/8IpYKrNrbhhRg4b5MY6IVDQQXo3yQE1R9RzL2qcM5bLEZO3k8bo2NbTpVC4AZnzLYDO0MPtyPwYx71vw3mCqByGFqYuGyjdH8tbxvCGnO0b1qJDnRJ0rmjuXWW5fvl6mvvsHtQmtyUQV/XGxhw+sfFpLSIE7EuoVXffutCY9wQy05rLLa/1oJRHt2T2BzVOTz7KpD8cGbGlwpac0Pcj0qH4aGp9VZ/yK6Gh4mLpFyqtzllpldjx4zm2yUxtxSRuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 13:46:20 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 13:46:19 +0000
Date: Thu, 11 Jun 2026 09:46:14 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Maarten Lankhorst
 <dev@lankhorst.se>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>
Subject: Re: drm: xe: Kernel-submitted job timed out
Message-ID: <aiq8JsfasY5jAT0u@intel.com>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <aig/tZU1lL/Zo69y@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aig/tZU1lL/Zo69y@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d55416-136b-4400-7d11-08dec7bfd108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|4143699003|3023799007|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: KSeULcUVb1uLhOq6FoPabUCW0vo5aI/oHXX8IR89ehAyhqgOapdyj1iflaxCBedTNuOVWqe5Q9leS7uv3TCVYIJRRxMANjKGG/lkLxkJjNHoNTkk43st4C1ei7cQGErmGNtDzLBG9ETEO4LQic96mVJjA8tEmmHnNaiVZ/5G6ZMWjE5mIcbc52ea6rGg7msO2zsLLzwDMZbZ9vZqX+rWrspkifVqlnMGG8t2eXgrvy8KQd9iJyyNVnGRCrZSWmczx5H424Wb37KBA1frg59+pzupXtHOaJ8r2InGyv0Qdtaq38aijAm05ruFC7PwcHDY6jDXYxVl6IOTYBm21Zn7yIUv81MkCfyVZqBREI6pV5o7vSg7sA+RQlTthehcmjy7Z5iCeqZSJLxopstiSrasmY+Vd0jkiO/C9dR1r847cDXuALUz81ZyEYQsEG+xk5idViO7j5qo+OeYHjn6xd1vuGI9ksZxXyT9dkCRVcin/BglFnUBz72BgeHkF7cEEWTi6AA+Uj5t6t4BLTyyeuxufRKodwN+Q2f3tciBJq2XLE6QCp3CbVYmNNuP+GAvqho0/KRL+0BzLPW8Hg2Km21BVIC1QFPkgkLiZq8WkKx5BxBcpIvLBcgji3UjwAfaXoVzZTHT7oZryTD+JAXTMipbL5O2aL31UVbNpzGYgFlk7Z7toHDcskKKNw8W8d4v0y4/G1kbEE6snP3Q5s3XBdrJcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(4143699003)(3023799007)(6133799003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJuck5CL0M2aFlMa0xqMXlwK0hYRXVkaDNsVE43ZXRFS1BycDhiUXp4UzV6?=
 =?utf-8?B?OFpPZlBLbjZONkQ4YlNHS01aSTBVdkMwL2Z1WHRxcFhCSlJPOWRzOFFvbmEz?=
 =?utf-8?B?NmxSRU5mVklzazBNWEVrcG5JK25VZ1ZuU3YreWZiMitnMzF5RFcraVpzKzVu?=
 =?utf-8?B?c09SRnNQdENzblV5TTAwWnBjN1BLeml2ODdtbU1HckYxNS9IRi9MVDQ4a0c5?=
 =?utf-8?B?K3BTZDYwNnVocjZ5Z3pLdFpPOWk5ZGhDVlJhemlveThQNHYweFlvQTNOQ2lU?=
 =?utf-8?B?UEcwR1ppSERmeDZpb1RSMnN1NmdYbWJ4WnlmRDNhbHQ3YmJWMm1wL3JKYnFa?=
 =?utf-8?B?d3dLWXdGallRY1JvN1VkbTVvZzQ1ckcyMUhUa0ZtNCs3dk9tdFBUTVk3Tzd0?=
 =?utf-8?B?UjBwdjdIMzJqakF6TXl2VHhoSHdxUld6UUZxdVNGZjlTQ0NaOEo2bmpvMTFF?=
 =?utf-8?B?dXFaWHhJOUtlcTN5OExYbmNqMTVDOVJ3TnJtajFyWXFNWVAxQnZpUlp0K1pv?=
 =?utf-8?B?Mzh3dlMwRkY2QnpXbm9ZcE5ubmRVa1lGdWZzTFBQdFQ4ZERBcHlFVmNTRGNR?=
 =?utf-8?B?Q2x4L3RMb1VsajBxOCsxd0V4bE5mSVJTL0tQUWp0UU1vbHhvbzhtU3pTSThj?=
 =?utf-8?B?Mmw5a3NCT1djYjFUSmk0bFVlUmRLcmQrSzdhRmFZQ2t1ZEwrcDlTWE43aXk1?=
 =?utf-8?B?WTBzaURqdGFaU202TWZHOFJOLzIyTllZZGxmQ2JJdnhCNjBLVHdwa2ExYTk1?=
 =?utf-8?B?YXN5UTZVeFZJWitabnZtMFN5bVNFSUFPKzJ0MEJreFdiVTJMamhENFd1a1lU?=
 =?utf-8?B?NVpvc3crcjZwRjAxaXBhNWp0OHMvYisrR3lHNzJhd1hpM1pHT3lIRnBoUFlB?=
 =?utf-8?B?bFBIU0RJZDlySVJVRXBtMndSMFp6T1dSZ0wzYmk3dHRSOEE0a0U2bGlLYXIx?=
 =?utf-8?B?bHBCd2RlSmsyVklrQWh4WG5TN3pYZzNXMHAwTFVKSWRqRmRIVUlLYmhteXZC?=
 =?utf-8?B?Ym5jWGdNQ0d5WHhucS9wN1FrWGdQbStDaW4wY2VvR3NlR0Y2TnVQcS9TbnNp?=
 =?utf-8?B?RTRPUjZ5aUJaL0l6bnZZVGxiUHpvOSsrM0tpQmNqMTM1cERCOWFXYlNHamYw?=
 =?utf-8?B?bVRrSm93S1FYQnJWMkhFTVFtRVFIUXdrU3liSUlpNWNmNXNVSjJUZWpubHpj?=
 =?utf-8?B?Tk9TUkJhb0pweGF4K2E0anpGTjJkTzl5RGFIVmhEVE5IZmNpRG1Ia0g5Z2Rw?=
 =?utf-8?B?QndUKzVHeG81VkZBUS83b2REbEhnaHYzYkpSN25PSXg0KzRWVHlJL3JkeFZu?=
 =?utf-8?B?UXVDQlpCR1dEVThlUTN3WmVQVGhhRHB5OFNHbHdGRHJCMUVDV0RIWWQ1blFT?=
 =?utf-8?B?WVhYdFJSMjRXckNOQXRlSDFOcmQ0TDEyVEQ1OWZUTk1yWEk4c3E4Sk9wNzBD?=
 =?utf-8?B?ejkwZkNEN2g2bHVKTG4zdXlQcUpVdTVpeGt0WC9YZUdHbUU2OXlKUnR3UW13?=
 =?utf-8?B?aVJCOXhHUXQraUViSTRoZlJ5VnRRL295eWFmaHU1UW52YkFnTDRtTE93a3Bk?=
 =?utf-8?B?NW9FQTJvV0luL0tjaVExaFBQZTN3SlhabjhBSysyb0I3SUlPZGJVRmVyamY1?=
 =?utf-8?B?bXozcWk3alRsRGMxS0J1Q2NwRzlnbjFEaVdMVHdUUjEvUDhvOHNaUmN5aXph?=
 =?utf-8?B?emNTc043c2Q0MkpsZ0NGeTllb0prdUozWG5NWi80aEFWN0xYczdNcGhzK1I2?=
 =?utf-8?B?TGV1aU9XODA1Vk5rUm5IVEVrYzZIdlNhS2dpZkw0QkplY0xsNHlVRHF3eGVX?=
 =?utf-8?B?Rk5GbWx0NWdrMWZQeHZLVWFpRUNTL2RZTUprRFZxNFhFRnAxSUVyTGFRS2la?=
 =?utf-8?B?VDhvR05rK3RXOXJhT3JxV2JpVDZqMkoxYTFWS29VU3ZDak1IQUxJUVpudUJr?=
 =?utf-8?B?SjQ2LzRYZ0kwS2VLN0Iyd2tScXc0d0VubWRBeDdtbHk0cXdibEdqS1htR2Yx?=
 =?utf-8?B?MUt6N3RoTWlxYXBOb0NVVTZORm9XRzBaRTNENmU1aDF3WEhNaHhOS2Yrb1BF?=
 =?utf-8?B?V3JIU0J0RGFRTm5NVTFjaEJQRkJ2QTAzWnByWHh3MlJrQjhMTy9GYzVVSmVi?=
 =?utf-8?B?WWM4Y0ZZbUR4VnpEeHFoVVQwaEFIK29iSnJUMDB2Q2x6WHJya0hWeGhnT1Fo?=
 =?utf-8?B?NElIUzhyalpqalZWWmdmczZCRWNvOU8zRWpSZXY3NmhYNlpnVXRCczBKOGpS?=
 =?utf-8?B?VGxDcGxYTEM2V20rVHBVZUdSaU9ndURiQ3ZNNU9Jek5sNVlrRkZtQ00zTHl3?=
 =?utf-8?B?eXZCdGZzanJ0aDViQTRMK0EySzB2eXVUbHptRzdsMHMvc3E5clZIZz09?=
X-Exchange-RoutingPolicyChecked: j7wERhKKJC/YWFGm5QEF0f0B20yzAOJCUKNR+1dSiMseFStuDMObzYYzxZ+rD38bSgAd+eeLZESlF/pyuvFI8WBIcTcSzPSvl7HhTXKwOCPrClb7/PLb4+n/W2gLSFuGfLr+J/pCVQzQ15SlskQbxhlijzyAJAnwCZdjjrLI5+7637WFJttL+zYpEniaQNGprk8WZaPkcmTqv1lVd23zpYVheJB9TIMU6zyz/pGJml2gIf6UH4HbULnRzhcUy0RhUdMBs626Ete7ujYVrnBM4NGrT6TUBGjfEr8oEG0spZIWp0JAWilnNjHoGyTbZddJRhrNrtaEvu3rQraygDJ8lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d55416-136b-4400-7d11-08dec7bfd108
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:46:19.7392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGHAxgLTaiijz3C22LaUSSR49600kRUJUdhIV4oDC1rfaLsaPIad3wRTrBcvO4+BF0H4jRwjNBCRNJzs8B4waA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
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

On Tue, Jun 09, 2026 at 09:30:45AM -0700, Matthew Brost wrote:
> On Sat, May 23, 2026 at 07:48:49AM -0700, Linus Torvalds wrote:
> > On Sat, May 23, 2026 at 1:29 AM Maarten Lankhorst <dev@lankhorst.se> wrote:
> > >
> > > Does it happen more frequently when loading VRAM intensive programs?
> > 
> > Well, "more frequently" is hard to say since it's happened twice, but
> > this time it certainly happened when launching a new program.
> > 
> > This time it was a markdown viewer.
> > 
> > I wouldn't expect that to be particularly VRAM-intensive, but hey,
> > since I run with two 6k monitors, I suspect *anything* with big
> > windows will chew up a few hundred megs of VRAM just for the frame
> > buffer side.
> > 
> > It's a B50 Pro, so it's a discrete card with 16GB on card.
> > 
> > I have no memory of what it might have been back a few months ago. But
> > I would expect it to be all the usual stuff - ten terminals, a web
> > browser with a dozen tabs, and whatever gnome and wayland do, and then
> > the occasional random other thing.
> > 
> >              Linus
> 
> I’ve also intermittently seen kernel job timeouts during my development
> over the last several months. It truly seems random—on some Linux builds
> it happens somewhat frequently when running internal tests, while on
> others it disappears, only to show up again in a different build.
> 
> I’ve also seen cases where a kernel timed-out job loops indefinitely,
> though I haven’t investigated fixing that part. However, Rodrigo just
> posted a series that should at least address that issue, allowing us to
> focus on root-causing why kernel jobs are timing out in the first place.

Yeap, commit ("drm/xe: fix job timeout recovery for unstarted jobs and kernel queues") [1]
merged on drm-xe-next and on the way for this week's fixes PR won't solve what
caused the initial GPU hang, but it should make the reset more robust and
avoid getting the machine frozen/lock-up. So, the next time you got the hang
you could continue using the machine and getting the devcoredump so we can
debug the hang itself.

[1] https://lore.kernel.org/all/20260610152548.404575-3-rodrigo.vivi@intel.com/

> 
> Matt
