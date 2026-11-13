Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15844606E56C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NXkI8+2X;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PS/yY/TK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C41510E32B;
	Fri, 13 Nov 2026 18:38:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9707810E072;
 Fri, 13 Nov 2026 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794595104; x=1826131104;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vdrWdZ35uRZ2lTvn5Rt0Uk2sGIHVRzB8UcD+vNEVP5E=;
 b=NXkI8+2Xjr0ZsVFaYWVrWduSXZIImGOMxV4cCFkIui+Yxe4c44XkAhUd
 diYrLPLZyZTEDmEeR2nPoqxc+7b9q3xTLBt0fbHrMY9R/Oo7xS/Jf3w1J
 MzXdvWj4sEGzd1f8LPfefNRtWzvCN4JHGJDlfqAgN41kUnK73nFB0T2MH
 02/+kEq0xcQ3pELF/xx/Ros2Z6FxAaSrCT7tbu9+S0LA0xi2xcNHgaQ1u
 FXdzgyU/UfAhtBq0fGMt7VAjcGCZdyKDP6klHBrbBt9mUkjAFSYp80dof
 kq8iApKxy7ZUHjfXcY8Ci0v1wmR1Ds5Y9yRihfW+x8S3HFOezBxjd7rWN w==;
X-CSE-ConnectionGUID: bIcV4F4SSD+pVKQwLAmvbA==
X-CSE-MsgGUID: CivBlygLT1qwg+aYFVgXoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3293754"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3293754"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:38:24 -0800
X-CSE-ConnectionGUID: 9gJiFU00RH6cXbKbhK222w==
X-CSE-MsgGUID: BPUgqQsKREW6fkMqbNQIZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8798155"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:38:24 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:38:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 10:38:23 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:38:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFCKuEOBWmhp34mHa4cKqPN/mFmZ/jwAKz3cUYHUwqJmbfLaBLWdr76d2j3KPOH5BpFUEIbxmAz0pkytI1cqKRESN7sJYZu9njxAD9CHzAdqcfcpyL9lpqTzSxU1tXH3TEoyILztig3top3x2MfyjAOcSI23u6Y3L4llzGgUtUvBFZ/zwiUm8pdjeZQiixqcPIipjkZZgMU3FpxaOuft2XZyAx4Kca4/JsfIxVm+JSCojkep36/I6Ho+SPpJVXtVv7Wj7V4rDDPJE7N2RqIiUTyODiz2hbKkueVyY63d0DsHKN0Si40SdVRAhYLYDM6LNx2ABiHtRoRoxAnYvpfyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrJtrTgSaN5RVP+vLSuhAinCQ4fBeTIqzrO89SOkw/U=;
 b=h5UbH0kosmpWL/dOyV+qcybTjMU8xLWH2V6tqFvsrhP4zE94O/9ugvjfkLbKpkvq18e8GrFTYmAlemqoOa14uRlbTULB6T7edcicDgfRT09vJWPcQM2H+AiWnmEJsozJ+cJSBlqiVQnw7ID7CsGRmI6oyQ/twagykw72Y97cMLIBzMCGWtNEM3yUIzqFo6adcOZ1bkHPryUMWfOlJ6GlOYICUYAFfqj/UuiP+fgu4C3lcLMO82AHJJZpoUYVgbNalFg0WOWOHhkQpoPMk6cvZiAFBvAGQ4Xpm03eKG5lkUv/sg1t0Na2731LKORgI2F/u8eVEZXiUrdhYJdM4CGRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrJtrTgSaN5RVP+vLSuhAinCQ4fBeTIqzrO89SOkw/U=;
 b=PS/yY/TKFwemhlxAg5XsQxW/qpwFLsvftI+HvVYKjMKI7l6jpZnLHw4dOavWOgE+89RpMWY8U6Du1nnb3MeTTkabicpYj3GL2jW/NEg94wMmO0K4jbwRM6wsZrKjX9W3D6A5fFH1S2/9Iehd0bMUo/nzsJ5/5ab/LCE5H9oxCOQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by CHBPR11MB782282.namprd11.prod.outlook.com (2603:10b6:610:401::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:37:06 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:37:05 +0000
Date: Fri, 13 Nov 2026 10:37:03 -0800
From: Matt Roper <matthew.d.roper@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Arnd Bergmann <arnd@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lucas De
 Marchi <demarchi@kernel.org>, Riana Tauro <riana.tauro@intel.com>, Arnd
 Bergmann <arnd@arndb.de>, Matthew Auld <matthew.auld@intel.com>, Shuicheng
 Lin <shuicheng.lin@intel.com>, Armin Wolf <W_Armin@gmx.de>, Zhanjun Dong
 <zhanjun.dong@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Piotr =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>, "Tejas
 Upadhyay" <tejas.upadhyay@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: xe: select configfs
Message-ID: <20261113183703.GC7214@mdroper-desk1>
References: <20261026102603.2045493-1-arnd@kernel.org>
 <avS7mZMrS7nQv_RK@intel.com> <20261113162212.GB7214@mdroper-desk1>
 <avdPvYEu-TBCbKTJ@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avdPvYEu-TBCbKTJ@intel.com>
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|CHBPR11MB782282:EE_
X-MS-Office365-Filtering-Correlation-Id: cee05ba1-5991-4b23-66d5-08df41b51de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|56012099006|5023799004|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261022113327099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GroNoYUcog1Z8TjpcPn+gdtOVjPviAWmelzSYGDgkHhG4oQvqAHFbHWBaSOsyGl4D/9fycokLsIGnaHfubxguewGU1cD75oDta2tMshImN+GUky8KFJO9sWD5zOW2xKuLjs/99pfVPrJwpAFcBnM4TsS2ZLkvXLgnQUAClIxgb3wIfBN5uwgNx7n+y1UGTyMgkSeoLGV7GVRNQj0j3ywlaGacAQkuP9xkG5qlIgbC3hh9Qh/L63Cq7j+oOs/UFL+tMVdpMjeQupfj/G4h3dFD1vmv27J7hsCGMEZMdI37dP6U0ePzNdMcjqGFkYelNRwm/WwbRiQgwP/0b3KdfplEiByI28stxxKR+F3+myZoilnCFm7hc2y1fhWsFGFx2EgaEKF97N6xi+DfCkQrda0MyiAWykDJd1UcJOrX+PWe79ODIahVHTYyjVFj9Aibufd/CgQ9h7Wz2c/dwVv2JCj5fGbW2S5gxDrxJK8kNdzNYu3nKsJBXCDGcnQg8Z/EN1tL7tH4te492/fftIy0gUhXTlpWHWnSvi/CeuGldu1rgBlxHJx0nNTDHGyNrZX0HPG2Yubtki/WbrZOFUNxDVwkOrNQpJLmo1rnq4ag32CLqC53OprW8mCF9OK6fr3k13xtxXFruZRKA4OKhCg9sfWOGhvlxPsKm/PBUOXPL2FAgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022113327099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2DR1m0uXNQIxxRdPcT+acrmDHpQJyxDLL6PCnu2QMu/5qi5WfFYNeRDBf/f?=
 =?us-ascii?Q?SF6F2GGf1ylFljPVoR5dSx3D3UmBPoZtdA4oQb9xOHxFAxP/Wqzm8KMNHhJH?=
 =?us-ascii?Q?seLidPgTvG/5Df5jj0wgcgpLDW+vY375sPi6QOwmEj2NAEsXM65TtPS5u6Zw?=
 =?us-ascii?Q?2r83ByYN+FH9Wffo1IzdPsBDaollW6lvsdtG2NAw85Elvtzu72FjDuREDJUy?=
 =?us-ascii?Q?FmmEK+vdmNwIpf8mDYOMnpHXywZ9AFqf73K9kbsDoesIqScQpTTexBsCa6wZ?=
 =?us-ascii?Q?ypCCBe6MySApNvGWPbe/ygZRE3jAB8/fqsFtcCge6f1A87LI5qnMml4t/bcD?=
 =?us-ascii?Q?+SmBOjf0S9fLRIkC2b7y7JehVf4Y/pR75MoxA9mJkuAxFY9P8K+gI+3UIgI9?=
 =?us-ascii?Q?TCAdGDUCyMDWjiHVVib1CNqezSDOBSNT5SnmDU6owuRSGtwRol5BeHXFl+h7?=
 =?us-ascii?Q?Up4Wc+NPK5sRRzoRa+tfAH/J1W36g2xQZ3qAalW7bFm0arQLKfyoAY4mXJtT?=
 =?us-ascii?Q?f0BXQBBFzxv64iCMZCpwWlppOyhNOo7VgoYvUeVwZam4G4FWmEh4RAQgGQmK?=
 =?us-ascii?Q?RQe/5Hh3RUxGjrpD4xixSLBvOCrUEM3dmC1smi3ORo57mZikRqFTZSPNQsay?=
 =?us-ascii?Q?G9TcLwz457lDxWYsddSB+q1cXdaaC5jQ5Yz8hRMLneXyDI22X9izVUMiDJhA?=
 =?us-ascii?Q?iUfJH4AebdvKMm/528P03151Up64+x/Yx1opsKCJmoSv9VXpPfIPF7NvQ4Lj?=
 =?us-ascii?Q?w7HP7U5FscxWMwNDwiS6f/NGHzELYQpFD8A58d9fzL1thCO05eZY8yea5JjU?=
 =?us-ascii?Q?WYQRs56CqcRvWgqbAsd0xFUrs1FffTOoVqQK37hZ3nwxgENIweVdIw3EDQDt?=
 =?us-ascii?Q?S1XbkgiafdSsYQCkASlTZtYCRDL9LdTRRqAQ/3ePk178hCXaYai29gZGMpv1?=
 =?us-ascii?Q?V8AkB+9c8DAkPSyYlWY7ujPoOGdswuI5MPFbhZ1DvxJfeDxCnd7Y/WhwmwDw?=
 =?us-ascii?Q?fchBICi1nmlZz95PIb/mG+Iy8WhsX3ZntV7zF1+ejd7quPhhLDjZjhLV3L3W?=
 =?us-ascii?Q?8ERNZBwCX0SdBEmh/kVUnUBL39og8Rd0fC6/dlH5afWCOsvt3Ilvx4fRv46g?=
 =?us-ascii?Q?63wFEwFAXFPXp+KVJ5UYyE+vtA8nCw7zNryK3NOx/pP+84gTaJwapRr64GkT?=
 =?us-ascii?Q?+Hq8/xTyB4yq9E8JIFSQ0l2vMVcYdN8XNsJPxFLgnXGkKOHckn0D2vOIosto?=
 =?us-ascii?Q?taAlJoRMfyCafa96a5IRkn6ELbkkJ7N69i0yWCFxIWn/GXeBYQTCAtBsDvD2?=
 =?us-ascii?Q?L4iwVZujweMSRZJQzJj/iJ7AX7udrv2XhwSgMxUXLZe7WkfHeVe2XXstMIgx?=
 =?us-ascii?Q?tPastHUWTYgusXpPcFzPVhrI2UXKOb2rkRO2eqeBSfxNu+xZoIB8Mzm/UIKT?=
 =?us-ascii?Q?hZsylvuQuFg/Kk7VuajvjU9nvrOUTqHahTToJoco5+75/CH0rSlENaZ3n8PH?=
 =?us-ascii?Q?PY8TMAdvi5mlTblIWl60tZKp3AMIqdO8U9nQJF1tFUZFbBKXS3Xrw/WupbSA?=
 =?us-ascii?Q?v3zBN/j8fuDxOiRU9z1Pwo0GHPY58XXzAFiShl0eK4wvEJipW6OQCJf7XpIm?=
 =?us-ascii?Q?thGwOm9sqR09PEAqrU8TzZgVzsc7B876q4iZxkU72RxDxzujzzZRW0I1V3pm?=
 =?us-ascii?Q?eCA4eTmugOBEuhBCQ4VuuMwr36WGzi/oFcFjWb46HfjZ/HNVtrPEE7r5ZrJ9?=
 =?us-ascii?Q?vWh/+Tefx0ckSAInCrtPcd+ASGe11Uk=3D?=
X-Exchange-RoutingPolicyChecked: mgO9cbp915h4b40/8OtU4Td/WuOWebccOdyYxPttt9x4wdwCDFkx2n0bAwcjPlFjbx5BATfdeVuLFiu0AVSjWtJ1UiUIVqkeRFXyadKanzAOhMxeEk0QHpKpUnbPqsbEKpQZn72odkMQjQIYXPH4zklMWa+wa3LeV7TKmy4TRbSNdJ8aeJZWJgndqk0xLdx303KGlvL6Su8Um/Ewhpyibr8zBLBi7ST/ClHAYvLeg+qvFFRp6hMG4OVPj2A42axfwlSmMEgmkmREeCMajIV8fN1UdHFW0UC9hho+SE6mU+kRd/R24ZA1sJWN6/+5ge8QIbNvwXMr810giZ3wy7+Bpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cee05ba1-5991-4b23-66d5-08df41b51de8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:37:05.8541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa3bD6a0TqXJFz/flwWZ/YPX3qicj8t+3CTwTVSobtOlsu/CdKU4JRPAEtp8s8hOmcDb/8wbad3/DmyGWgCF07n5u3cbBlN8HcIpxsWk51A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR11MB782282
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

On Fri, Nov 13, 2026 at 12:58:21PM -0500, Rodrigo Vivi wrote:
> On Fri, Nov 13, 2026 at 08:22:12AM -0800, Matt Roper wrote:
> > On Wed, Nov 11, 2026 at 02:01:45PM -0500, Rodrigo Vivi wrote:
> > > On Mon, Oct 26, 2026 at 11:25:50AM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > The original addition of configfs to xe missed a compile-time dependency,
> > > > which leads to a link failure when configfs is enabled as a loadable module:
> > > > 
> > > > ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
> > > > >>> referenced by xe_survivability_mode.c:224
> > > > >>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a
> > > > 
> > > > A recent workaround added a 'IS_REACHABLE()' check around the calls into
> > > > configfs, which makes it link in this configuration, but this is generally
> > > > a bad idea because it makes the actual behavior inconsistent and confusing
> > > > to users that expect configfs to work if both xe and configfs are enabled.
> > > > 
> > > > Use 'select CONFIGFS_FS' instead, like every other configfs user does,
> > > > and remove the unnecessary stub functions. There is little practical
> > > > difference here as anyone using XE graphics is likely to have a complex
> > > > configuration that already selects configfs anyway, and the link error
> > > > or the IS_REACHABLE() would only manifest during randconfig testing.
> > > > 
> > > > Fixes: 30499cbd7961 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
> > > > Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  drivers/gpu/drm/xe/Kconfig       |  1 +
> > > >  drivers/gpu/drm/xe/xe_configfs.h | 30 ------------------------------
> > > >  2 files changed, 1 insertion(+), 30 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> > > > index 4fc8abdc5cb6..b52a8dc28f97 100644
> > > > --- a/drivers/gpu/drm/xe/Kconfig
> > > > +++ b/drivers/gpu/drm/xe/Kconfig
> > > > @@ -11,6 +11,7 @@ config DRM_XE
> > > >  	# the shmem_readpage() which depends upon tmpfs
> > > >  	select SHMEM
> > > >  	select TMPFS
> > > > +	select CONFIGFS_FS
> > > 
> > > Perhaps another option would be what Jani had suggested:
> > > 
> > > config DRM_XE_CONFIGFS
> > > 	def_bool y
> > > 	depends on DRM_XE && CONFIGFS_FS
> > > 	depends on CONFIGFS_FS=y || DRM_XE=m
> > > 
> > > But anyway, we are depending more and more on the configfs for
> > > production choices. So, let's go with you select and close this
> > > for good.
> > 
> > I really don't think this patch was the way we wanted to go.
> > IS_REACHABLE was giving us exactly the behavior that we wanted,
> 
> But it caused other issues like reported in the commit msg of this patch.
> With the risk of other complications like Jani had pointed out earlier.

No, the existing code had already fixed the issue reported in the commit
message; this commit isn't fixing any further issues.  The justification
for this patch was "users who don't understand the reachability
implications of 'M' vs 'Y' might not get the behavior they expect if
they make mistakes while hand-modifying their config."  But that's just
user error; those exact configuration settings (Xe="Y" and configfs="M")
might have been precisely what some other user wanted.

> 
> > but now
> > we're getting behavior that we did not want.  Xe absolutely does not
> > depend on configfs in any way.  _If_ configfs is there we'll enable some
> > config options in it, but none of those are mandatory for our driver as
> > a whole.  We're perfectly happy to build and run without configfs if
> > it's not selected in the config.  We're also happy to build and run
> > without configfs functionality if the user wanted Xe built directly into
> > the kernel, but configfs was built as an unreachable module solely for
> > other non-Xe purposes.
> > 
> > While this change won't matter to 99% of the cases where someone is
> > running with a typical distro kernel, this is the kind of thing that
> > makes embedded users unhappy since they're very carefully managing their
> > configurations and we've taken away their ability to avoid configfs now.
> 
> I believe some other user could be angry as well for ending in a case
> where they need manual survivability mode to flash the firmware, but
> they don't have this option available because in his config this
> option was not reachable.

Kconfig lets users select the options they want.  If they accidentally
create a config that doesn't include the options they need (either
because they left them at 'N' or because they set them at 'M' to prevent
them from being accessible as part of the built-in drivers), then that's
their own mistake and they can correct it themselves.

In some embedded environments, there are very strict certification steps
that have to be applied to code built directly into the kernel, and
sometimes a bit more lee-way for the .ko's that may or may not get
loaded later.  If an embedded device knows they have no use for Xe's
configfs settings, they may not want configfs built into the kernel due
to the extra burdens that places on them.  There may be other drivers or
facilities that are not part of their critical path that are built as
modules, and having configfs also built as a .ko for those other areas
may be useful.  So Xe='Y' + configs='M' is a deliberate choice to match
a specialized environment.  But we've just broken that flexibility with
this change.

> 
> Soon SRIOV will be another production case that will depend on the configfs.
> I know, one might argue that we should then select only if SRIOV is enabled.
> 
> But I don't like the complication this is taking on a very simple thing.

I'd argue that this *isn't* a simple thing, even if throwing a 'select'
in the code and removing the stubs is easy for us as developers.  The
reality is that crafting a fine-tuned kernel config for some specific
purpose is always going to be a complex task.  Generic configs like
those provided by distros sidestep the complexity by including anything
that someone potentially might want, but if you're fine-tuning a config
then you really have to pay attention to all the dependencies and
consider exactly what you do or don't want included as builtin or
module.  It's easy to make mistakes, but that's always been the case if
you're hand-crafting a minimal kernel configuration.

> 
> > 
> > Also, as mentioned earlier in the threads, using 'select' on a
> > user-visible config option rather than a hidden option often causes
> > cascading problems down the road because it ignores any dependencies of
> > the option being selected (configfs in this case).  At the moment I
> > don't think configfs has any dependencies of its own, but if it gets
> > some down the road, this can cause problems.
> 
> I'm not strongly in favor of any approach, as long that it doesn't cause
> other issues and regressions. So, if someone want to try to bring this
> again, proving it is a good config combination solution that won't
> cause further issue I will be glad to accept.

There weren't any issues before this patch (except for hypothetical user
error), but now we've removed flexibility that was important to a
[small] subset of users.


Matt

> 
> Thanks,
> Rodrigo.
> 
> > 
> > 
> > Matt
> > 
> > > 
> > > I'm pushing this to drm-xe-next.
> > > 
> > > Thanks for the patch.
> > > 
> > > 
> > > >  	select DRM_BUDDY
> > > >  	select DRM_CLIENT_SELECTION
> > > >  	select DRM_KMS_HELPER
> > > > diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> > > > index 327b648944ff..d726800de26a 100644
> > > > --- a/drivers/gpu/drm/xe/xe_configfs.h
> > > > +++ b/drivers/gpu/drm/xe/xe_configfs.h
> > > > @@ -14,7 +14,6 @@
> > > >  
> > > >  struct pci_dev;
> > > >  
> > > > -#if IS_REACHABLE(CONFIG_CONFIGFS_FS)
> > > >  int xe_configfs_init(void);
> > > >  void xe_configfs_exit(void);
> > > >  void xe_configfs_check_device(struct pci_dev *pdev);
> > > > @@ -36,34 +35,5 @@ u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > > >  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
> > > >  bool xe_configfs_admin_only_pf(struct pci_dev *pdev);
> > > >  #endif
> > > > -#else
> > > > -static inline int xe_configfs_init(void) { return 0; }
> > > > -static inline void xe_configfs_exit(void) { }
> > > > -static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
> > > > -static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
> > > > -static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return true; }
> > > > -static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
> > > > -static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
> > > > -static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> > > > -static inline bool xe_configfs_get_enable_multi_queue(struct pci_dev *pdev) { return true; }
> > > > -static inline u32 xe_configfs_get_migrate_ulls_period_ms(struct pci_dev *pdev) { return 5; }
> > > > -static inline bool xe_configfs_get_disable_vram_page_offline(struct pci_dev *pdev) { return false; }
> > > > -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> > > > -						     enum xe_engine_class class,
> > > > -						     const u32 **cs) { return 0; }
> > > > -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > > > -						      enum xe_engine_class class,
> > > > -						      const u32 **cs) { return 0; }
> > > > -#ifdef CONFIG_PCI_IOV
> > > > -static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev)
> > > > -{
> > > > -	return xe_modparam.max_vfs;
> > > > -}
> > > > -static inline bool xe_configfs_admin_only_pf(struct pci_dev *pdev)
> > > > -{
> > > > -	return XE_DEFAULT_ADMIN_ONLY_PF;
> > > > -}
> > > > -#endif
> > > > -#endif
> > > >  
> > > >  #endif
> > > > -- 
> > > > 2.53.0
> > > > 
> > 
> > -- 
> > Matt Roper
> > Graphics Software Engineer
> > Linux GPU Platform Enablement
> > Intel Corporation

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
