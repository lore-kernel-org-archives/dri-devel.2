Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598960A383F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nL449bha;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lTiT6ZEL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54AE610EC41;
	Fri, 13 Nov 2026 15:47:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A364F10EC2D;
 Fri, 13 Nov 2026 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794584826; x=1826120826;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qksuHDHfqvaWSkE0zzyC0iTR3vYhglJ50L9si6bQLd0=;
 b=nL449bhaV/f4z/I1x66bgIP5TmqeS59HmAgPAlyHPXU3ZDgmca3bd5Y6
 9MxyTChWR2ZNcoKgAs/v43NhZG7jgk1TPeUj9RrlMk/n/qDLjnpwKq2LZ
 Pdh2V/zU49p4o1s+u0smTymURVWqHoLJ3A6Rnw5hkqMwaPtbgGg1QP4sT
 QGftuvJgnkQwR4UeVJqM8OIYLw6T8ARcS1A6tLCiFWLumRVDJ6EDhLTk4
 qUxPqRuPQNFGrzDpwiEJZShwhPtdg0Zaf5o2jk+cNAcsLrYivBVKSu6go
 WPo/CRxQca/YU8mEyHR3nBrWxQKjm8bVyo+wqqkMW0hH7Mu4/vSU9LZn6 w==;
X-CSE-ConnectionGUID: xUtj4lSkQQyh9XX6gUEwaQ==
X-CSE-MsgGUID: OLp6gaD2RJ+iFhXS1p53Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3491300"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3491300"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:47:06 -0800
X-CSE-ConnectionGUID: n11nJ3wKS7q720vpsGB70g==
X-CSE-MsgGUID: zU0ji6MjRtW+kcCPaZ2Ocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; d="scan'208";a="10731256"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:47:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 07:47:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 07:47:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 07:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMDDSU0ZSqaeMJCWI+Lmp30wXldYpwyR+jrAww1DYYIOqhxw24uShEYRq+lXibGCGRrHZMiu7kd9IXtBCa2s4CWUlS2T6OFuzjo+3U0UlDpXLSZxwehoXaqn7QuLaa5etoyVuL0pURSdPVLRS/pebXdy5r+HqGWxUbz3vzPSvejYJv+wzVVHWKL8AvHI8fizZOP91EfDTbkqflawTgAbViIgZLpGmxUe18U7W2zKCvSmp80RzqK26phetMmwWZtBFAUr7+0r2HpzfrBNm+dElc2J2TLHYw+tVZb1NXnPcfs+lftkCC+F/dPn/Zc6mm4jj6ORwd1bh6DIKIRq9+J9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kVMI3y5Wopt+06qjk28TYbURwxAsW5nWlfcSOgyxI4=;
 b=Dcf6pK91UlSLbJZmdO45giZtNkoVDAx+OfMsrs2ZfdJPHrIw+eN04e6ego6w9dXo16tnokYFhRqF+AsBKnmGDAC7eFMWi7XubFL0UgywNhk7Cn8rQaX6n3P6UjiPpgnACLakTs2PqfRdpOHT85bqZfajTgtwbF0GRdN58Tkl+NM3FfL1Yuo/KHlrqZz3A49XA/N44wng7qC3kz/bgZj1uUd4H/b+ZP9JxWjACq2YSooNSK6Jbyei2lm8zeIrDuH2Xy0ajQKuoAtJzhsyPzX9kF2KZqQHJMnPsDPjauaiMnY+irxz0AQvp8BnMGU0Mu3RgdbyCAZ9iXhbdOJQnewSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kVMI3y5Wopt+06qjk28TYbURwxAsW5nWlfcSOgyxI4=;
 b=lTiT6ZEL4HEG7Csr7ZM0YbX7DtBSwn7uA4zoXq3h8sRE+Ztxd2ki7QqBETrEvyAfMGnUJ4Hnpk3z6rob8DfOl/kLL2sNEzcxVYv05Fwy7naOMqBbXqZWhCGd9MVJREfs0t8j80IytqQnc8G4twQ91Hww8P1KZGw4M4GPXmsNvj0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CHXPR11MB9650.namprd11.prod.outlook.com (2603:10b6:610:2fb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 15:46:56 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 15:46:56 +0000
Date: Fri, 13 Nov 2026 07:46:53 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Changyul Lee <lcy8047@gmail.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Release the SVM prefetch ranges of unparsed ops
Message-ID: <avcw7dxdP17Hw2x+@gsse-cloud1.jf.intel.com>
References: <20261113044239.2185984-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113044239.2185984-1-lcy8047@gmail.com>
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CHXPR11MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: 186f2903-ba7a-4401-f347-08df419d585c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261102123227099003|11063799006|261021121427099003|261009223027099003|10067099003|261022105027099003|261021123027099003|261026121527099003|56012099006|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: wbks8fw45q5VyZ4bYjlVJqK8zj03cusZFna94PQDVOjDsS/bM1WfEgVyNFwnSK5WpUt6MtZF2OjVPAhss8ygDFNO7wxs8xbU3/jHkTRgwqM7CQjAabciilLoct+wgt4SYW+BsP5CxfeE727i2wwEmadx4YQNgo5rBj2LVETiKgBGHU2ytkiZhjwqsuOdCptfP6QGV1MO2QeBL3V2RLlM1t8DbQxvLo0upPzU+uO8yUcyT2Y8dqXtTu1/oc7vmmuRNUM9/SOcYOzl0b6IiJwEo07j7G8QcLOcP8jjSEZT0YAKS0s26mWWQWG++hY30eI1hTf1MznpmvqPbngiqSwbhSJGE/dp0nfIqXjxmZcqz0LCyJY9AQQm/bebOSF6ojW5hrqvhi99nlQmx10BafB3tEGsaWfdQESJOgUENHuv00+9Zj+TzUA3TdlJRy/8Ubk5gHBtsdryuzT2gRZpECh/3E6I7oGj9kKGcWNsJrL64Vu2Wez2LqWhcDK1qOHT9Wb4umipLmCM6MjH7a1KZirLxcYEgBEaf71nfhG4AOs/CMTU3fRM4l8Ztn5HHGE5n8JnIxBZuOiXIDU4MZ61gFDRIA4ioTiexBehSVnxxmKGfwk8gvxMIMXB8BPlQ99065BHE0L+HoCq0X90PpO1htlSrgUokbJCcQX5y1bd6Ctqyl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261102123227099003)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(261022105027099003)(261021123027099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iOpZOOl4zzcLZjfAW3TPFkUHJUADczvaHnQMROqLBeXNwBs1dvWjmryi2Y4W?=
 =?us-ascii?Q?BoXro4dE/mu913e1Nwf8NRBIll5CQTiUNAMTPFaAad0brJ+cQFefIzsN3/vi?=
 =?us-ascii?Q?PdmazbdX5WzMlTSM86cU7Y7nwAYf80lCoSyTPY8iFfZtZeN8Wl4Ku1HnZ7o+?=
 =?us-ascii?Q?RsF0DnzlOkPENHHJMzaQaBvARNMdAS4BETqbGMhzb4hpbjVVytneOImTgr0x?=
 =?us-ascii?Q?eJrIcmc6bbbrPX/tu+E3zYvkQxFPD3dYqeVSu2wBDZ7uPo/T+7/DP4uqbdTi?=
 =?us-ascii?Q?dA0eXg2segEWVnAwZGot/wx8ern3YwQFFtBKRFyeiwk4LPJHalOo5vZVGoMh?=
 =?us-ascii?Q?c23Hch6Di57B6SDHa+nYlPUCQxIyUNuCzG52jQNH7P4WlnqB2wLbO7oy4/QK?=
 =?us-ascii?Q?TbxIoYCk94b0VCdn02peSCBcS4iUurOQJhK9TMK3EoSF/J4XKwc4bY9r808i?=
 =?us-ascii?Q?McNQ/iPZOpGitRPWVzftAarAPiVLpYiym3V2zZgdk74Su7PTMa5NajYppdua?=
 =?us-ascii?Q?3DS2GUSUqdnz3nH683a9G2SdrhsM5BBf7ZXDMCgNB+fXM2YVpEpxqP/mSe6x?=
 =?us-ascii?Q?u9vd4m/4nuDjw3xL+f37cYRsSuIsabbLBGXe2Pb1X0mHi6fLe27ksC0bFKmn?=
 =?us-ascii?Q?RBtseIzqyM3D9oLCoqvh0rCl9ppGlvF0mFbAdtb0HMrxs160A65myR1Tump1?=
 =?us-ascii?Q?WIQj+BbEM0xeXZJuV+FOC2QU0/lCRd7WcF/KeEPov+zr5/svEunb+BXhbxEB?=
 =?us-ascii?Q?t9BwH1sKj8orNgNxPdsSzIuZU3tcQ1FLywy0bkrNGh6HQsGE99rtyn7xNDc9?=
 =?us-ascii?Q?vXH0kmPlDS8i1+sdq71RuQhOqMLf+602138IfWJuzlgvCbaR0NBesPnqWIox?=
 =?us-ascii?Q?6Vohu4nEZbxzOJlyFDVYb8IWzIeD/PWGQ7yxrF2YIvdqN+KZQt9NLcnFk96Y?=
 =?us-ascii?Q?bS0w+2NliYflahzgK5Dxn92gg3Q2rEKXj5rvFiftP0sEZ8REOxLtQ5jNR0WA?=
 =?us-ascii?Q?ifNeJlT2y/ScvwprcW6wCWokbPKJ0uqU7Ch6isyLQWBDm3S+m8SJDm4INzG7?=
 =?us-ascii?Q?Mv3x87zlriSg65H3nu89wHptfmhDlst7d1vnVR7nbPAysvJQcVB3fc9Q05Vy?=
 =?us-ascii?Q?XN0SThBrQavjBmzY9waYTj3AoBupabSrBUcHNeQh5v0bKZ4gq6Cu7QzFGEHL?=
 =?us-ascii?Q?wbkQi4WwoNCcS9BxHJYn/UROw9IfxH1mDuCSRfwK39lGryrbCyJix3IbGm4B?=
 =?us-ascii?Q?+pbt3meoMhKMus4r69822mBtEVRckzrTCogzSWyufYWIhKzwU7jQye0t58yC?=
 =?us-ascii?Q?nDS0H57mUqNRjZdSS6f58gGZ129W+/F6p4XWw6tAdrQUc52QDOmof5iz6EJ1?=
 =?us-ascii?Q?IECLyFc8iT3Udt8MGp5/DwjhYHukBx2ZvlLOexSGUThu9qMzCPcYTDrI4wwG?=
 =?us-ascii?Q?QO5SpBErCJDBfLF5Hn/xgiT5Eku+fBk1tR+EeV8ptLLGrCiRkNFW9TPOLMwJ?=
 =?us-ascii?Q?NTFhQ/L9GW/5+hPVs+0gKmJyo6IPBSzyRsgS3b7eGbgE9FvWd5oHIXeYs9/b?=
 =?us-ascii?Q?4HUymsBYmVe4jwoI9M9YP6OOz+unS70CZPNajGR1NqNRRcNH0Tj1bvg1uxEY?=
 =?us-ascii?Q?Eyoh/+QMS3fPvpkjbONfyTK6Tn4BZ3X+ceHx7gIFjMNdG7VvOlHNREmnoML+?=
 =?us-ascii?Q?Ur2Ms9+GvlPOAP+MarKlRDMD1dNGJqjPAnqoO5QsY+Mda6G+cktzjY1C5x87?=
 =?us-ascii?Q?0nthXAT3Fg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 5T1wOoD9n+T2DwyyqNg/afeRarbWTYBuzSdiPnDnO2aRebA4yCOT9M5X0QQfyHMQY/13miRA5SZ34/nABaYM6Le+HegsncshK0A92/Gyp5RdDS49PaK69OaTeKBcrx5Q7z8N+3ZMBdjTeeDeRf5WBCSlEBcx3AKLx1hfF3Qr67bUwKZ1WLOISRYt7LMgAnCfmz8rMg4gO9l+McDRhMGEdyYzcjoAqpZummM0gKXzU5Gw7w4UtTwwyQaSvg6B9AxraZbsPAxEm9icFf1fbZeN2sd9rQm38D2JxVrbBj/3CCxm7qgB0mKSQ6tCFdwVIsi7+9jJnYmwtSYYo8kZrbAY4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 186f2903-ba7a-4401-f347-08df419d585c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:46:55.9763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD3Zw8Veq27Blhbif3RYVr8y/qRtkBUKj21b58dBi4wSDU9QNtho2ko2oxYFWZHXy90O+qxKmv8uaS2J2sshzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9650
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

On Thu, Nov 12, 2026 at 11:42:39PM -0500, Changyul Lee wrote:
> vm_bind_ioctl_ops_create() stores SVM ranges, each with a reference, in
> op->prefetch_range.range for every PREFETCH op on a CPU address mirror
> VMA. xe_vma_ops_fini() releases them only for the ops on vops->list.
> When vm_bind_ioctl_ops_parse() fails, the ops after the failing one are
> never added to that list, and xe_vm_bind_ioctl() frees them with
> drm_gpuva_ops_free(), leaking their XArray nodes and range references.
> A PREFETCH that covers a userptr VMA and a CPU address mirror VMA after
> it does this when pinning the userptr pages fails.
> 
> Release the prefetch ranges of all ops before freeing them. Ranges
> already released through vops->list leave an empty XArray, which
> xe_vma_svm_prefetch_ranges_fini() skips.
> 

I believe I see the potential problem. I think this is right and safe
assuming xa_destroy is safe to be called twice which is appears to be.

Our CI will give use definitive answer which I have triggered your
behalf.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com> 

> Fixes: 09ba0a8f06cd ("drm/xe/svm: Implement prefetch support for SVM ranges")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> ---
> Found with a static analysis tool we are developing.
> 
> Compile-tested only, with x86_64_defconfig plus DRM_XE, DRM_XE_GPUSVM
> and W=1.
> 
>  drivers/gpu/drm/xe/xe_vm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d25de5652767..ee35ead79371 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -4208,8 +4208,10 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  		vm_bind_ioctl_ops_unwind(vm, ops, args->num_binds);
>  	xe_vma_ops_fini(&vops);
>  	for (i = args->num_binds - 1; i >= 0; --i)
> -		if (ops[i])
> +		if (ops[i]) {
> +			xe_svm_prefetch_gpuva_ops_fini(ops[i]);
>  			drm_gpuva_ops_free(&vm->gpuvm, ops[i]);
> +		}
>  free_syncs:
>  	if (err == -ENODATA)
>  		err = vm_bind_ioctl_signal_fences(vm, q, syncs, num_syncs);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.43.0
> 
