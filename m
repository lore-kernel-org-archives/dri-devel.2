Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276BBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8356E10E50F;
	Mon, 12 Oct 2026 14:22:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994C710E129;
 Mon, 12 Oct 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791814943; x=1823350943;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Lh3Uxd+EBAuUWoz7HyYmmm3JtbiMzdLbxfcTUntx4lk=;
 b=jnd0a2ZDfs/VDZEfELLHmMWrbKXyAkVh9Wj0I1VvxVu9shKm6HUnpYRN
 8gh4vV1Lj4K5wZep/Wwct8woOQT3v5jFTkGt0XUlB9xwxh9tk3YUKIcMG
 MBc1Mi7INXLxXixDE8bs8XPJyIIQ2y8Dv3Xg0K4X+reVr6l/LokIZnn93
 nTmWQA2zArpNMV+H7lwaX4E3LSD7EtG5Vfa+Ds3jzmxytfn8S1+sR/E+D
 E7zl+NJh9pV/P8VpCpUzccrmvAwOR8FsFPRWFDFx9wD7Ndv15mSGCYHDh
 jgUuHU/+ACTG/gHAw2CFQ4hVOSIzl90FTzs/kkjK1GOJ4WtDwZcmVudF0 Q==;
X-CSE-ConnectionGUID: BfBOXX9XSl2FkYV6H59OmQ==
X-CSE-MsgGUID: +5YduLvATRmobeRkcvOJ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="418191"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="418191"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 07:22:22 -0700
X-CSE-ConnectionGUID: kXLD56vZTB+2Q733ruw20w==
X-CSE-MsgGUID: uOad9NsKS2uO2HQJc4tJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1098698"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 07:22:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 07:22:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 07:22:18 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 07:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsMUll2x/56n85cxjp+oSyNzxbIT84m3wbjAYLc4EXM6kp2eKdQjeQFWpkXOFyzOT/LDqw1OZ0H2uOjx/W+xj6GWeXy1M7h1Lp0nMbdEm9voRGwSe2t18+R8GrDt6kwNduhtF+4g5Z4FijzJmPbsVbP4MyPT8CRglMad9j35UK1fKOYVpBttj9ZyTFGfRaOuFkEqk9uAgp066TQ8Ts6F4r3Vr/3wGcvOU6EsSaA1cfO1U6g1dvPflX+iHCXTndzwIx9DPKBlN2365EhVgHpABR19BaCK2x+stIrpd8FQLXS+7q2HsX1Af9qMvBLwwZqhD+2wO+SX/djNkuQKChjwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gpwBDNoohCTL+1ayIxNYGsTYFazRnxHGaoCkMjzWLw=;
 b=SnQPC6R0NPNwRU+vyLZFbhZYgWIH8BpnnYNorxvsLMBAVrTqKukvLYwpLYwfjNT8eobW6v0UXJR1xEhGZwSfCbFHuwCKTRSfmvKw5O7vojaQ4MarnzW5GHDlX/2u6Mxoo4S4goJ2eM3XJ2+8vIJt8OhqMphOCJYEdmSYBZLTKr8EwwnQUgjrZtMIU5W4zncgnL0SptYt6ndW5ALO1cC+dkWpuoOLjquNdfK8qAgffOsCUo/fF+fEadbWD0OtIVklFK1R357GtDpI5HjG+uDsVMMn11uBm+o6ixmm65SumE+l+dXYwbBBwEkZAO7cAM7f9ipvdQOR9JUlAd4IZ2D+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by SA3PR11MB984635.namprd11.prod.outlook.com (2603:10b6:806:5a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 14:22:17 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0472.016; Mon, 12 Oct 2026
 14:22:16 +0000
Date: Mon, 12 Oct 2026 07:22:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Liviu Dudau <liviu.dudau@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Alice Ryhl <aliceryhl@google.com>, Anna Maniscalco
 <anna.maniscalco2000@gmail.com>, Antonino Maniscalco <antomani103@gmail.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, David Airlie
 <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Lyude Paul
 <lyude@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, Maxime Ripard
 <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "Sean
 Paul" <sean@poorly.run>, Shuah Khan <skhan@linuxfoundation.org>, Simona
 Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Message-ID: <asztFRIQU12ZzGCW@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <asUm6j1GD6yxeBvy@e142607>
 <aszqfCemcNPebrgZ@gsse-cloud1.jf.intel.com>
 <DM2X9C32YMZD.S3DK3U1MEY80@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM2X9C32YMZD.S3DK3U1MEY80@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|SA3PR11MB984635:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed1ee6a-04f4-4ab7-a3e6-08df286c37c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LEVfrNz98ICPSJb4z1CqM9uIl3Zltq7islBtgsXla63NikBrMAMCpa512IeQAONpu5FfTtKc1d/yVF+4N47mGjZ2vBRHfCtyl6Zx0v2PdjkIj0K43TTawQMju2uqmJwfo4ras0YqeOG1fJ8tVrzIc+Te3X48ZLvAcLhSj/C+MEUdtfbAH3mXqyt4GFJuITndXJrn81XAxypEvWnSyZBS5p89ip4t/APM/oiSejB/x5yIHy+kQ4c69hvOAl15dLVCspawI+w+dUBn0JWbofqxoWxqDjvRnR9aQON35+bi2Iq2U5+IPlHpvBMf7neMXawTEtQslH/mI1eA6cA367WZvSOGxb71YttuGhFtWDE6PIrYYdmItmBCAfrV+0azMvbWxJPsQ64GC7W6oZkhnEZom45lV5ukcE5W9MFosURkATeVdkGY0zeSQl9O+VT+rwhAAh0gN1e0OQw9g/IzaxIWDQecFnW6lT+19pfbmnpJb03Jcuh6MUiDbkYZwZJkfshaj3SdeEgZQXHvRdY5fRn+qjUkk30BrEoUF7UIhCXOXRmeXXaecpcD5xughPHesq+XHfBOXfp4p0mtyFsNAYvJc8dE6Co/0NAfhsijQM4I0KvRhMqXS8x94A2TOCpeCaLPbePiFzImlAsL6I8spmKLuf6DDqUs3oe2+LWNN3YY0cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Umjmvp5+ETQI1WumC1Twui48sz7zA+jiqXbwGtss0rkySh49BofPPbkdCXtb?=
 =?us-ascii?Q?mjchKkdjd7EGzGq/q3kHEnFDvpP7c0l2CdTvyPiO/NGLiD9ZAR0ysqytEwtK?=
 =?us-ascii?Q?ONYytmyWDIwFlF+iYABfqlFPHd8l2/DOh3kPH9GTQwIlhsyxH0cPOtPDiKBA?=
 =?us-ascii?Q?aqm2vYUSYIHaJqHr1Y8QoFr/xcuuqFbybTaUOI5X9CzC/BCnv1LLrZvyhiJl?=
 =?us-ascii?Q?yhpwfg/SOneo7k0CvFWn5bR5MYdHizrKmdsAjTdWCPYJ7FujNSOQj3t/tBbb?=
 =?us-ascii?Q?1sh8qZJDdXwrPzliv1cLulljWHR+ECiy+QTNvxj42TNQRjjxziCsGL4skc68?=
 =?us-ascii?Q?bhD3MPmblNr8+9FZx3j7TmHrFpTH9SumE80aUC0KbrgDE6XWesh9CjnlBprH?=
 =?us-ascii?Q?Z7G4NUz1b7L8NEj1CekuIPs/XzjCgGcJ27/o0hXg4TDslFdMZv1D/Uue6C7l?=
 =?us-ascii?Q?T+YdCvXO8/qW50g1BXNDwNgfO70BBmpZCbhPZg4ORCk8Z4ujgDwF1B/9tjAn?=
 =?us-ascii?Q?848WjMjlSrBgPQIGLGj1gdvEF0Ctsv9bXvfcJ8woFM771nyV0EKFTCQB5VCo?=
 =?us-ascii?Q?fXeBIokEopYZP7C0v1HY9L/f2h966ZSS/69DyBYDa4odEhlj7Lt6E4lti+vO?=
 =?us-ascii?Q?ree+RDqhp5ZgLKUbyMLit/Lb1jZFp2IZNGMfnD4Xsf31o1A96AgyXFqg9EOU?=
 =?us-ascii?Q?z2CRh2GAMyz+A76mYlZTDjivrdLaWpRUQYJdPMBhZfVIxlsYIOMTU8NMF6D9?=
 =?us-ascii?Q?a1xR8vw4APpmIbaCP0QQjDPi4Wkkn3+DXi89C16Sg1wEJm7sXKoFKtxNhpLT?=
 =?us-ascii?Q?LkH+Im91+gex/Lm6eGJDQtVYKMYruoXuvrHDg4TEqqlUz5FkYIPuDbcTXFI/?=
 =?us-ascii?Q?E5V+HkrsDE4cg6XDJ6UvxqYhHsZge2tIEWiyyxbTScSH6hVwCxIDbSyQDTKq?=
 =?us-ascii?Q?CsZL+N4tOwGGPdkryg6xps1fjMGKSVHO1pCzSVy6B06OZLUbZDO5wgSNTBxV?=
 =?us-ascii?Q?z4VB4jhaZ1zKALPD9+xQ0nVry8J3YposP5lNfJo+mtf3pJi27tOj5THu6zKZ?=
 =?us-ascii?Q?sfLAl3BgNZ4r1Qk+4vqQ4vMZQ7gaiReWAiIFr6y0u4LFGa+c/CmD6/s+WZXh?=
 =?us-ascii?Q?V5kF+N2ZnicpuEGRNhsh8x+85awANnF24IIl0rOT/oOyPj/3llJa8lk0y5Hm?=
 =?us-ascii?Q?lJ98kb8wyijpZqb7BHjg19lemsDhv/IriKv4LEdht8SGeDkA8EF4UZxwdeiS?=
 =?us-ascii?Q?89lh7bMV/SWSTBuOPagGYfS9wqfao8BQiyU2KqR5UmMRlfnv+pKaWYo42CBJ?=
 =?us-ascii?Q?VTFviWu6G799inovQrMGI5rjTRZaeDoX5ZHn3rVkyilU69Sz4CQoS0/BXKwD?=
 =?us-ascii?Q?TZFBDsC06MI84w+3L38RNhosL7Q978/hXR7ReUNZOk9Q0ZKkViHL1sbBHecS?=
 =?us-ascii?Q?VeYjkzg8vS72vlAPKZo+CWWaQU7Ia9R6ZtkPd+wUrq1wkn5r5HIg3nWo8OVd?=
 =?us-ascii?Q?QlQKYicvxDYD64nYq2zzzzL/wXjhwD7rJ2x5UkLXdWuI++B705mhmh8QQJws?=
 =?us-ascii?Q?3U3jPLhkCpQS+JHz9STiuOgVaTY1kN+lpKvvOYa74xVF/FQE2U57MNpzo4lO?=
 =?us-ascii?Q?Cb1S+jyVdjUjbgFCfYIAbk3hOiigBd3DbQ16y/kSYH8wcnAfNOYD6nqBVFG5?=
 =?us-ascii?Q?oRK91+OOVP2PJ9kThfYQb74wU4ujjY5fYH3KKjGj+vcMr64pgwupYEANfiEQ?=
 =?us-ascii?Q?YXiGJ7Aw0g=3D=3D?=
X-Exchange-RoutingPolicyChecked: AYlr48WPae42au/bnKxwyYA6HOCcveRVLesZUWKVwUBO/MDQSD9MIpdgSd9rJb1a97TINGdfFiJezyRl8/9Y+w2rX7+DX4q4w8W/0sPuNGesD8kHG3mpRUyZNZ/DWyZ0vdeDqKKcCfQmryuvV9rc617MNGnq2iNJ2mzinb2Am+X58M/P+qdbZ8rP0Q+NkQJS9MhqpIZr7y6TQkzWYJkHWbxzagbTHRL2LTNQ6Dxq+fZDA9yrv17SB/6jWmqvIHiFv+grBanmVogLIP6LTTVnye1sElyjolWHCqXWGRhtaPMOnvD8zngguB9+5FytpKY2gGVoUdOGxSkqWTWc52TxQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed1ee6a-04f4-4ab7-a3e6-08df286c37c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:22:16.8502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7UdtC8/4zqelcmRbvKZvdn1Ib4JnT0N2rAQ8Dcm7dcWFL2yk2tBxs98Voen/oWt3u2TizqSFRJOBkxz3qLwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB984635
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

On Mon, Oct 12, 2026 at 04:16:23PM +0200, Danilo Krummrich wrote:
> On Mon Oct 12, 2026 at 4:11 PM CEST, Matthew Brost wrote:
> > Danilo - correct me if I'm wrong but in prior rev one of your dislikes
> > was some drivers using DRM_GPUVM_RESV_PROTECTED and others not (msm,
> > Nouveau), thus I have both fixed in this series as it was quite easy +
> > using two pass gpuvm.
> >
> > So Danilo didn't contribute, rather suggested.
> 
> That's all correct, feel free to add a Suggested-by tag if you like. I will get
> back to this series soon, thanks for tackling this!

+1. This has suddenly become a priority for my company over the last
week, so please let me know when I can start merging the pieces.

My plan would be to merge the baseline GPUVM patch through drm-misc,
wait for it to propagate to drm_next (at least for Xe), and then have
the individual driver maintainers merge their respective pieces.

> 
> > Also in a follow up we should probably rip out
> > non-DRM_GPUVM_RESV_PROTECTED support as I believe all drivers will now
> > use this.
> 
> Yes, that'd be great, I already added this to my list. But feel free to send a
> follow-up if you want. :)

No problem picking that up but let's get this series in first and once
everyone is in drm-tip do an audit and rip non-DRM_GPUVM_RESV_PROTECTED
out.

Matt

> 
> Thanks,
> Danilo
