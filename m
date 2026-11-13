Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08049606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lK+bSTO9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ghsfeD56
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FDD112570;
	Fri, 13 Nov 2026 18:33:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97726112570;
 Fri, 13 Nov 2026 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794594807; x=1826130807;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EYtFynSogGYn6GW9vZwAfraUxh7hvWvQYqHlUj1jbm4=;
 b=lK+bSTO9eqQlLDjWqQYLPU4/oyRfBCREZnC5Opr0Tj//w33QAnYunLJP
 +W4htV5BHhOieMH8o9AajqQ3ulQXVlV1e6KYT7i0eO5tthkXtAwWVkn0n
 tWOJ7H9QAr6kltiISnL9auti1Xl8TDO19eKpCyjVg+T5k8VOZRbv9wPfS
 /i8IUShQWM0QzRH0fW3Czdm1wASexfnHWUgq9aeL1VKHiJghVkVFFvily
 9J2z9h6yiCtEnHpLrknx9Dz9aFqBmxnSbCXFTotgpAeyqN3WiEpqXWBAF
 vGZ9YaBB5+bpKB7BsQHWRumh3iScBoZepR/iQSgmp08cHbPhwUdiYNqw/ g==;
X-CSE-ConnectionGUID: A8oGvtTLRe2IfS4lQKWxrg==
X-CSE-MsgGUID: ASgXA01TSSyJQMxvWcSCUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3421453"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3421453"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:33:00 -0800
X-CSE-ConnectionGUID: CZndmrQ+S+GXsxzeSXtK+Q==
X-CSE-MsgGUID: meYJLBF5QSGbP/agsWVAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8907306"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:33:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:32:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 10:32:59 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:32:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDOpDt0/rjyjxPlr2j3pjxEB1AsW5xbS2iEWtTUAxQnPsDkS7HaiJFD7jSsRK43x2kR17kxRQjORBPK9VBy8PATOw1revy9slttnPwnenB32K5F7V1nItJUquE7fige/SZ+9XXU0G7YttUoDwr8yPv/sMHevzWIesOUbwloRVpKLLUbcjGM7yCJmbpm2oBhPGcG3hXXST5mHRLlUx4BmGR+bilTqoAuTwEy8GSi/MXJOafgaZe7f5CLnA89+0BVfsW7yse6phZ1kjs6LdiJ/TI0Kdfq/pPslJs6R22kw1DBIi3ZQgENmIb97LPqtVoa9dQus/wPLLA9bJt4G6bCnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz00V3csZZ+gd8EquNGQSmNQi2ifgzKl5l7Ry5D1c9M=;
 b=NZpHN1JRGHtEUdc4cp8qab0iZj8o/bkokKoEIoSz5ZVN9UesjnXhTzQQVo10aRKuYXiOJYh63CW95VOKzoL5CXErCAiXsjs0x4fQoP/VKmwe/Mp9V8qocSaj0y+Sd7jRkig5jn+IMVY/uv3qi1NlZ2pvA7vx8r9xbMbV+0btKwr/vqp5Ycz2aX81cN/tagm7CVX0RC1CarxD9bW45dNBCZ7EEL7cjfSWxuSt1fsVC/i+eq0M55N4AZjx8LixOJY/pbEaLqTDdvoAAdEh1EAsbvhXVAawy6iXnTEmsd5zO+rF/dm/w0PDKFm3ZBGtgsOnKY5JBgsrp+uGrgmQBGgqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz00V3csZZ+gd8EquNGQSmNQi2ifgzKl5l7Ry5D1c9M=;
 b=ghsfeD56vAVRV13+pEp382xl41zzHqfTzK27yXIRZnzk5ZpmhyALOeZm+arr8Pu/dllpytG1NtFo/gM+7v20gTGfzNxBIoChdf07BQWShhdhPUi2OhnMj2Gbz4Phv1GzK54QRDUiwgLwA6NJAvf7E56GSz9NwWgEAfSE/nkD3ts=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Fri, 13 Nov 2026 18:27:37 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 18:27:36 +0000
Date: Fri, 13 Nov 2026 10:27:34 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <tejas.upadhyay@intel.com>
Subject: Re: [PATCH] drm/xe: Account for exec queue cleanup after handle
 allocation fails
Message-ID: <avdWloP416vGgEgT@gsse-cloud1.jf.intel.com>
References: <20261113065437.249640-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113065437.249640-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f6c78b-c3a1-4b4f-a73c-08df41b3cabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: TlEgoGPYrCDTa21PoHnrDQFKazQHPw3rU3DKgunbcPsJ0zD2CtnLRxgBzliRoxTp3cB8Zkrn7W/wQaljjkcZ09XJdj9WZFomTjFFoanZnn4iS5IiCdGnTvJCSZ12DQy1/+4N5jr92h1N2jRQ2z4Gn1ZYvJEZBGlmEzF2y5SKAQsbMPx8iw3JsGCCuyX38mFKW02RfP4BVLnUl3rJNtLsLDr7ICX6sj0qTtu/935PFvmpCRW5E1mUc8OlzmH529OkBKu2JwDHLd3BkqVRYMsOx/UW6x5980K0tshkKY9aLmiRkLfOwSVMWNhUplyol3QxhXj/70Cu0Cmqy4ggB610zxRb9xxprBdQe+eIUOb7hx9HovvdT9hSQzQixVZTDa6/iIwCkL05qfdCBydvKITlbvD1rf64uqdcnPdew4ILhdp+6O2hjlYEjoOwj6kjtEbqw9cyTYQPwt+NZNz3wGk3ZONmn4yc5alqjMxCAzO68mHK0cVs9/KUHkceM3CPZIBdgvw6tVN3S5QU64FJ3MYBWT2wLJTG6Cq8nHeNQkSmiVc+HBO4cjGLHRrSiFs+/Uc1qiaKZt0qIBVJN/I632AvDqZOb1hU8YKCBsKZ2zCJYxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AR61/3km3uVUOOyrvZueXokgwU6YFL19YmGtb9R+NeV4xaNqUlTOmxJw2n?=
 =?iso-8859-1?Q?JbOewwtw3o1tNH++fGOsQixg+Nbekk5Gu1NaF5aF334U1dizznr6qYlYYF?=
 =?iso-8859-1?Q?fbnUJCL5P1pzShFgbgGbIkfoxViiUzqtkBkODI/7wQPUpJ5SrVPOJITxGF?=
 =?iso-8859-1?Q?gqU05WhYDlyFFXeLdYkdbj0u5fF/RguO+Ok+r573ihpitcW6OM+wcC0RNj?=
 =?iso-8859-1?Q?XaSGQYzXzYYm4gb/fLWxq+vrK1ePotamawip80zgtTHl0ZAsg8no4b1Aub?=
 =?iso-8859-1?Q?WKaddAPL5JwTPwpPqjnvwQPZ16f9ojnBrLL+01DnGalI0wpJ/1umKYb389?=
 =?iso-8859-1?Q?mtQvwzA4LhHZk82MXULzTRgsyRK4sJav9NBCuaF3gIa9EwzpY9JdBRLiXh?=
 =?iso-8859-1?Q?K0As15GGjSqDS+MW9vPNNfVG5YkMyugQ6cnhEoYzD5jugohrCZSeS1TE8l?=
 =?iso-8859-1?Q?mwYNE+Pf2mFbqI03vomCn0ezsVJoD9avEoVij/U/OMver0zcscofFgR7eM?=
 =?iso-8859-1?Q?t2Kf3OiDrQhQvRRMqGO8EfHnfJKu0OVjihUjU9ZMjdFe0jF4nvYdH+0x7Z?=
 =?iso-8859-1?Q?c3v+nLrFgGKmhArZi05mFOmfUJz5478+hVpj+jmzmFEmNTncdwdN4QTGlr?=
 =?iso-8859-1?Q?zGQ4eqbvt2cH6k2DAlJv0rHFUnNzPA/+uydo5cb3vYoDl7hnK0jYZIMb49?=
 =?iso-8859-1?Q?q9KHQiYFDcddE9kJuCZQn5KVqqcLlG/AusCtIXoqxaCsE3O7eZ6Mg/gvnD?=
 =?iso-8859-1?Q?UscTGjQLrpbqYYP/w/+gnRhtFoNBLaM7W0UPrb5jglGS1cq+O2D/5Y+vEl?=
 =?iso-8859-1?Q?sS0MIptHOpM9rHLz7r0joGLzFDn6MhHTCObvdtSs6wQVK7h30g2Ucai+0G?=
 =?iso-8859-1?Q?Xicb+zmrX7YbFw0LtpRRVn27xEs0QvkMsP+Llf73KoyioLEximH4CQfSG9?=
 =?iso-8859-1?Q?ZD7QlEDGFfd5XCZPTYVVbGC/XGnwxoUG3MBoZmZLCiFUUrcY8zsGvpd+U2?=
 =?iso-8859-1?Q?d+Y1AZGvSAjSuFzh8TD0lF0twryOqcYthYQJkk6p8K9YUN9NbKzOoP8N7u?=
 =?iso-8859-1?Q?2ROOibcnMcAD1R88pqfNJtlYi+GBI7uP6xzRi1Y4a/3aaZPxqqTMgDJU/j?=
 =?iso-8859-1?Q?FWCafT9pwmFWrrIAAj8Zb8ddUVNU7cOWkYG8HgD5V8VuJHVEh9L3ZurbnK?=
 =?iso-8859-1?Q?yIyzjyvM+TAkl6iHSi5FXKgACBFgQFw5Xx+PaJY1SbCcwtIJVFPDKWvvgR?=
 =?iso-8859-1?Q?iz+H4sAEXkmn592AI3wCAz3oR/R9cY3vRUWzSxKjWmTb3ctfFq1YJPxWa8?=
 =?iso-8859-1?Q?aJcarLY0vDU0gl3zdr2SMAbBB24L9jJlZ33rxpjSULraD7+OqoJyscaQha?=
 =?iso-8859-1?Q?3arjq5w6ErTivxFFNHe+GBWHA3XbypG4M2L8Gxie/Ngq1n83ajDepuAqy0?=
 =?iso-8859-1?Q?GVSoUUNahw1xOh6Wpe1pvgLWtsuJ8a1jinYQqNWunAM6EaMnRHh9rD7cth?=
 =?iso-8859-1?Q?YfpiYdPEQFUQpTc2+hb2G2eIUAsPQUn4MBGySz89ADo2eUdKVY5Dm2VRPV?=
 =?iso-8859-1?Q?jXfVrtlCBHe8e2OWHaHKubQuGyMZq0iy4TcHPFNBfDDE+m6AmCit3fmXgz?=
 =?iso-8859-1?Q?lGPWTqSOMxYog0GXYSRZZ0mLl+8+jvKokfZtTiB4H3KD0Wn38WvTnzpSzp?=
 =?iso-8859-1?Q?c8aosBFBtvBA28GjOffbyBtzd2e+HhOpxcKh5CJRw1kXDQSfUZdKbYw3YQ?=
 =?iso-8859-1?Q?pl2GuuxMWlRJMzNuLKrcIVqy4WljSlMIZadAqXIFthjhNSwvAyQFzRaW3s?=
 =?iso-8859-1?Q?4jY0bRpBHw=3D=3D?=
X-Exchange-RoutingPolicyChecked: XHtVV4TLhWGDFVEye5WKuekxewAQNoBHAhH656Rq43nkDgmGv53v8mJU0aU1ElH6b/Btf8Omah7njIxNu26muO3ISjHhY9DPlbq/nEDsn6Wr54J1rLMlkgGLKDj9GC9qYH3VKAIF5wrPIlygxEwhiw1U00fwhb/fFlSkQgHmu66yZm+mfyN1xl1D3PhuETSCghhdH/3q+Yo38bwECewmHEodtMrHNAuG2h+ayyY1I9MG6EZwt4IYbaX5nUifFShcK9IDW1ObVwLSsHo7kjc9C0FVkFk2FaA5kyYhBlyI2Nn2Hi1m52ASsEuNtQh71USpEjUZ63irWnvIcHVsNHoWQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f6c78b-c3a1-4b4f-a73c-08df41b3cabd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:27:36.8161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9DlXHmsSGAjycBbs5JFh43K+FUkrauXOq/XwPAZPkBfNlX42Gg0nH/8dSRlz6/E3Kig6wpgm1+Oy+koO7c4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 12:24:36PM +0530, Arvind Yadav wrote:
> xe_exec_queue_create_ioctl() assigns q->xef before allocating the
> userspace handle. If xa_alloc() fails, queue finalization decrements
> pending_removal even though the queue was never removed from the
> xarray and the counter was never incremented.
> 
> This can leave pending_removal negative and block fdinfo readers
> waiting for it to reach zero.
> 
> Increment pending_removal before unwinding the failed allocation.
> The existing finalization path balances the increment.
> 
> Fixes: 0fd4380c050d ("drm/xe: Wait on killed exec queues")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Assisted-by: LLM
> Closes: https://sashiko.dev/#/bug/linux-0e3ad548-c571-43d0-bf6b-00ed4771bd7a
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec_queue.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
> index 7ade915c59a8..39d99d6d418c 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -1471,8 +1471,14 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  
>  	/* user id alloc must always be last in ioctl to prevent UAF */
>  	err = xa_alloc(&xef->exec_queue.xa, &id, q, xa_limit_32b, GFP_KERNEL);

What about moving the xa_alloc above setting 'q->xef' and calling
xe_vm_add_exec_queue?

Matt

> -	if (err)
> +	if (err) {
> +		/*
> +		 * q->xef is already set, so xe_exec_queue_fini() will
> +		 * decrement pending_removal even without an xarray entry.
> +		 */
> +		atomic_inc(&xef->exec_queue.pending_removal);
>  		goto del_hw_engine_group;
> +	}
>  
>  	args->exec_queue_id = id;
>  
> -- 
> 2.43.0
> 
