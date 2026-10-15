Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E70CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2C3112348;
	Thu, 15 Oct 2026 13:53:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C8310E270;
 Thu, 15 Oct 2026 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792072421; x=1823608421;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ix6DkFsKhULjVT463HTZwXDMYO6YWUtCUOAnDmzshqI=;
 b=JrHObGsNVBQZGkfR7XFRQZbRoXYf4esejYFEDWv7nLvR5da1pXZ9woka
 BiFAxbivU7PqIQ6bdVoceFQOg9cbBkfOYjxba0DtpYZhfgQ8YNtM9k7UJ
 6n3hSAYBZ4nnowY3wS9ONgvVVaoGvNEMEBkJPLhwCijEZ0OjG7AMQagU8
 YfItQNh+BcSWaGTvkrxH7x1jvhvfS8c6n/kebVZw11NTN1/rKWxUb0K3j
 X4+ATP1UnLprdXDURJtHDNqEhpW4nvomhZCgHOTZY/5hk+2lZ6ZBcThqt
 nxdkoe6/A/SUuSKZNW6wwngp5Sa0LDnudi17S7G93LaCJe/jIbSjb+f8M w==;
X-CSE-ConnectionGUID: nN6VWrIjQ3Saa7DiHJP0Kw==
X-CSE-MsgGUID: 0uj1XEdkScqflhGwpixIAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="945307"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="945307"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:53:41 -0700
X-CSE-ConnectionGUID: JQrYzc9aToy2+SwsLoZAIg==
X-CSE-MsgGUID: pWRkB9BkSg+T3BDGjdJSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1609366"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:53:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:53:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 06:53:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZl6VJ/wEFXP4k7KfD9BylZDPyeDUHJHA/amrW9DXfDZ63tera+Ybhz6bIgU4weA6iMEK9cfN6xfW1wRBybC80aC90e5mLgt7AohGXM58jjkVl4hzlWmVMRAB3EAug2CY0pZQS5z+fAzd23gn1I2eZGAgXAdRzsHB8XOHa27+ASjhqxvdEIb+0iLU/A6PrZN3oGEdqmtf3pWCCRSgjIiG/0FDZoBkKHsCMUdvBT3DwT0XqR+v0DjT04pCbufhWzfYXOSTI/f+QLDVqMLTpzj2jQs98BenhVc63bRPgBsFY006L7bGMU/Xo2xnmBXrkwkTDN2Il1Ep6t5imV/Kgfy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H55FFTN+RuBjEuvPveaTYTyxkvhwx75c7EdaVKJFAWQ=;
 b=A2yVaN9iQh29sZa9fxQJz9nc12m2AlVi1HmhH43c5ik23iKOWlSQGSbV3WkBRq7ZcaAKmr3P1dybxkVdH7dsFIQvvl+vEuTo/hKUB+tcO8ZKBwOriIsUQKBWKFdAYxOPb7FNKpDLrpXgNBS/AyPTC26oJToe6I9ILTP9kqHx9rU9J7HIZWfxzhbMhW2162kHiCYfbCac6NPVGFq60zepV4oUHMIe0nS4meRJx5dDXEMUv80SBnVnTfaTaqzjDzGuzz4rct7rLGnIKH6jmrOLTXZ0u2IAjUcJmLC0UO8Yt8zqSDBMbqU/h/aFpU7lPOoJWjPLWYPgwK98BiQhVJNOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 13:53:36 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:53:36 +0000
Date: Thu, 15 Oct 2026 06:53:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@google.com>
Subject: Re: [PATCH 2/2] RFC: drm/xe: Prevent pinned_link double add
Message-ID: <atDa3ZTjuaZcjlwG@gsse-cloud1.jf.intel.com>
References: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
 <20261006175741.3582911-2-fnu.vishwanatha@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006175741.3582911-2-fnu.vishwanatha@intel.com>
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aadf49-1f7a-41b9-73c6-08df2ac3b546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|22082099003|18002099003|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: MMNY77IXe3ELUJpDDt2eEtDnWPYGPiaUFk0avQXVHGiLWtt4eJdg5c72MtU7ojsIHhjnUjJkk5Kpgva8RDVf+6FqEeK4ewwzBbv9SzBoJqDh/Ok5TXdm0XCYCJrCihbbzx06ISw5+qHguim9sTAwitBOpiICQbGnu53Xv5vqWdQCTroEwekDoSmnoTCYZ14/9TC7Lhz0O3ijz2zF15vYqa41vPArLUTAaJnpHffcbtnm6D77e3fY+6XsqzmguNcYJm99mlzTOeRATOl2jl4TbXS6w2VxFJ/NTEKKJcEreqAPFkiuVlPVadiPWtx6rwUxfWj4UTNFc1tY7UcXRqoO5Qaf9q8KjW47p2wIWqefwkDfkqtvAF1Ec1vUpZB57gH2bI+LkQUUrczT9qA3yAn8UV1yXn7CaLpULLOscGk73BmVsj6jQmimL4pMKawNGRzbRfBzEpoUag7eYcJgcLABkHINw7SgA/p1VxWVpbwqRbRylTaUTfNnS1E7E2Kx7oWOQq3cyBaaJSC+Yf+3J6k70xXc3IWUlQ8YvaNWjdTuQ9CDIUnDicER0Kx9fsAgQMT9V2pQ9aovQUu87sGx27r+cZ4S3Z0e86ce1/wgHn0B4SPp1DGx9XGdd7HySsbaGjTnHZ+mT/Pvbt8LSnPcX2dQ/d2VcKjQkp2bG/cUZqaHn4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGxnbGFRSUY5SlFNc21DMllsSUo1ODdlRExFU1JSUjJqZzdMTSs4SDQycisx?=
 =?utf-8?B?TzJMTEI5Y0RTT284ZHNZRUp3V3NzSDJhVm1VTkR4YzhTV1NYTzdsdjlpakZM?=
 =?utf-8?B?SHUyNnF6QnlFQmhZTjJPV0hBbEx1QTN1RGFBdkJkTFBvanVWVk9FTG9QVTB6?=
 =?utf-8?B?UjFZN2UyeGQ0TkdTQUluOEpRSWxEQ2Y3bVpEbTgydTFmaURGbkhVcUQveUZi?=
 =?utf-8?B?UUNjV1U0Qm9GNDkzOUxBcVRSQVBZbHFUZHNVejNQMjFwQmVyNVNrZjRZbDVT?=
 =?utf-8?B?TnRDRTdFb0RUUUMwMS9QSXZ5UXl2V1gyNmZrdWFQb0N3T0FvNmhRd0NrUkJF?=
 =?utf-8?B?VVJlb2dFOHhnU0l2cmVVUXI1TU5nWnRTWHpsSHdsQ2pFWitpZURNeU15eks2?=
 =?utf-8?B?NDVETzhOUzJ0NitQUkVZTHNMTTVUWjFsYWZkWlpVNkdiSXdVenF2RnFiNDIr?=
 =?utf-8?B?R0JUcnVLaS9XWFQrYjdPVFR2Uisxc2JUYW05S2RQbi9ETElPT0tKd3dOdkx1?=
 =?utf-8?B?MEI4VTZoUXdWbjQyTnJjOFZ4RHBVenpBK2tlRFh3TVFFYVAvbXZ0UlMrZGw4?=
 =?utf-8?B?YkhLN3FMYjNQZm1hU0sxRWhEWUxvc2wwaW82OEpaS1p3UCtHbHZFd2xaWmZ1?=
 =?utf-8?B?YXVnbmswcjlHUm1odGZZMUEzRDBQRFdkRkw0WDd3UHJnbnRvWEY3bUY2WjV3?=
 =?utf-8?B?dnNWYTBUb1llVGVqZ1Z3OFZlZUpUdUUrRnFRUEtSWjhyb1BGSUh1RTRkMHlQ?=
 =?utf-8?B?bHFaLytUanZRbm93enJUU1cyc1I4RmxQQjhQYVg0Qm1HRWxyaEJBZXRHRjBP?=
 =?utf-8?B?QzZwVXRtR252b3NsQXFRSXlUSFJCNm9wUmlVZnlMbXVncWR4R2VRYlNVcXZ1?=
 =?utf-8?B?ejdwU0p1Tm42OVU0S1RyMU1tTFJsS0NCcURzUlg2cVQ1NUNFMEYycml2aWlG?=
 =?utf-8?B?Q3ZLa0FQaWUrYlEyZG00R0dwMXhYUVdJNE0vR0hJQTNzb3FIOHNObk9KOHRR?=
 =?utf-8?B?R0NENTR2aDhSZVZiNTlUOGhXazFpMmxmVHFHbzBjbUcxZWUvYzdIWkNxSnlR?=
 =?utf-8?B?cTJWbC9ZbmdMWkJZbTZRZy9DYk4zeXVTKy84c3k1NkorYnNLUGl1WjkvTEFn?=
 =?utf-8?B?UnViWmZWNUh3NmNKYzZTVkpEQ2RQN0NxSVN4TmdENWRoNDk5OE16aWdSWXps?=
 =?utf-8?B?SVVnK3orOXlaa3BERENySHZIdmpRUE96MFVOMkVxcEJuMkw1OTNzZHBEUGJX?=
 =?utf-8?B?UGh4TkpNRHZxZkIvWWJwN1Z1RnlEWENWcHNSemN4Y25LSEo4Z0JDWVBBZUJM?=
 =?utf-8?B?ZXBJY05mZ09qMmRoSWtBVWJ1L1cxQ1JYS1Z3dmdBMTZKSGhKRC9oK1RMb2wy?=
 =?utf-8?B?SEhTVXlRRHhtMlZCbWVlWGlNeXdkRWFhOEJ5L3doWTdGMVJ0bkM2QlBWZEN6?=
 =?utf-8?B?YnF1TkJabUkwZDdWYmJpMTNHNXRCdHNieFhORHJpQkZISzQ3OEhwNC8zM2pB?=
 =?utf-8?B?anUrTWloRm9pdC9qbUc4WndvNzlQSHROQlRKaXNXVFlNOUVWZUhMeU00Rk9S?=
 =?utf-8?B?UUg4eGhwTDhyUkprVHpVMGFBaWIyaXdmMURaenZQQk9BbjY1RUFHWmZhR3pq?=
 =?utf-8?B?Q0JZNER6bkNXMmdtYk5JNWVZWUx5SmZlT0c2Q0ZLTm83WDZjOUxqcjVYcnVY?=
 =?utf-8?B?OUxPeHhxQ2c1UmJhcVNqT084SnBCVnU1N29MZ0laUVc5djlLRHNsbVpoQzVN?=
 =?utf-8?B?RzB6dFBlbmk5QUpSTGk0NWxXbVZQNnI5cStDaDdlQ3RIRHJxdXMvVmRIWXlm?=
 =?utf-8?B?VUxGS3FodWpwSm1zUkFrVDI1NU5uNXNOemVLVU5qNmQweG9sNTlmQzhGQjRn?=
 =?utf-8?B?Q2VOQVV4NzJuS3RZOW9QRks5aXFKWkhJejZiRFJ0Rjhpei9BMkhCZStYMHBP?=
 =?utf-8?B?OVhxNFExd3UwdVNreEtDbW4vRnQ5bkp5QmtVU3YxU3BTZ3ZrMDg5QUJneWpN?=
 =?utf-8?B?cmpKNEVkakcwVHZ1RXROSnlQSFFUU002RDVsQm9XZDZ5SnRORWtjblc0dXd3?=
 =?utf-8?B?cXN4TlJhRHYvWW8rd3R4OFNDREltTXRTZkxDQ21JTWFTeDFNNCsxU1E5c3JT?=
 =?utf-8?B?ZTd2TTQvRUdiNVRrUDRNUzlKWEIvSGV5NU5PMVVWczIrTWdseDFWZ2hwcDdS?=
 =?utf-8?B?N1V5bVFsVVRWM3VxbVVKS3Q3NDVSUXVZem14OGN4bWtSUkFCUDZ4Mm11Qnh6?=
 =?utf-8?B?bkJsa21RdTNYUjEvTlNKTlBvSkNoQzhEeGE4b1g3R1U3STA3TTFxT1dScjJ5?=
 =?utf-8?B?bUVTb1Y2NnAxT1lSdzFXdE9RSkJlaFZ2djlsdUtxYjVlakZ1M0tqZz09?=
X-Exchange-RoutingPolicyChecked: yQLiUtYtv8noayqaJZ15fTIc/mueZTOU9O3Ghp8xKjb4CbGRJcwJVhZKF56pnbi9oFY347r3Al1XC7FRPoSomHi62vecKgWwCw9lK5tFAyrybXZ2dxXT/YYDhae/cDtJRfXmV7Xf2f4mG1oDz1olo6r28zZLh7QwPW/h1Umk/LkAR3bPDATuUxV3OsuiaXblmNwyEFAX1vzpvxs3imdGiL0r8yddnjVz8RlofvcWmX/twtpj4A0brs8nUXgMed398MnXOtjcI6lWU5VHzXXylUizoAz4Dits/sgqeFcxZedWNvhQGdlVk/K5hKb5YofBQCDip2RKxb9AbTDQUKm4VQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aadf49-1f7a-41b9-73c6-08df2ac3b546
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:53:35.9623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l91lQ9QBxIx86HOugSyVirvZNUGdMY4/1chpgMLPQxFBDV4IX1XYWb/nRwJjJtwEN6TGM+wrGcR16M3ngCQ1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
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

On Tue, Oct 06, 2026 at 10:57:41AM -0700, FNU VISHWANATHA wrote:
> From: Kornel Dulęba <korneld@google.com>
> 
> When running CtsCameraTestCases on a memory constrained, 4GB device the
> following list corruption oops was consistently observed:
> 
> list_del corruption. prev->next should be ffff9ebe1ce42ea8, but was ffff9ebdf741fea8. (prev=ffff9ebe1ce43aa8)
> 
> After adding printfs in multiple places it was concluded that
> bo->pinned_link was already a part of a list when xe_bo_pin_external
> tried adding it to xe->pinned.late.external.
> To fix this add a list_empty check and a WARN_ONCE in case the list is
> in fact not empty.
> With this addition the CtsCameraTestCases can now complete with no
> kernel crashes.
> 
> Test: atest CtsCameraTestCases
> Signed-off-by: Kornel Dulęba <korneld@google.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index c5989db950f7..cc5a4ff64791 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -2762,7 +2762,14 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
>  		}
>  
>  		spin_lock(&xe->pinned.lock);
> -		list_add_tail(&bo->pinned_link, &xe->pinned.late.external);

Like in first patch - I'd rather have a 'xe_assert(xe,
list_empty(&bo->pinned_link)' here as any other state is a bug.

Again if it pops, we then case down why this occuring rather than
papering over.

Again file gitlab with details so we can assist.

Matt

> +		if (list_empty(&bo->pinned_link)) {
> +			list_add_tail(&bo->pinned_link,
> +				      &xe->pinned.late.external);
> +		} else {
> +			WARN_ONCE(true,
> +				  "pinned_link already added to a list, bo->ttm.pin_count: %d\n",
> +				  bo->ttm.pin_count);
> +		}
>  		spin_unlock(&xe->pinned.lock);
>  	}
>  
> -- 
> 2.34.1
> 
