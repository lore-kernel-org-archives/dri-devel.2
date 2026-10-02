Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A11CA5FCE
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 00:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89810E218;
	Fri,  2 Oct 2026 00:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lT10I5zs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3F810E1F5;
 Fri,  2 Oct 2026 00:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790899596; x=1822435596;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TFelHBoKKh2vNTUz3VKyjLgCoaofX7iMZBKrWPfNab0=;
 b=lT10I5zsVMwhQWWUUvGlXREnNznQ/VEYezp3gdoelFeaiBbG7+YtEbAK
 8ElP45jjVB3+R2O7znJDjIs86+CX7KzGdaGhfC5srhQQUIEGyoGJvDV41
 8b8c3FmQEajwfhhivO4HEnCpZxDml71QJh3pawcwhZ3BYB6rqsBWT6r32
 soslLYm5Z3dp6HG9JIJeCft5D3rMi4TVq6cSkM2FHA4IGBgp1oHE73qxA
 e6xCJW75sn/9fkhI9h4KSiv/YORjk7IlrTLGFX8fjpzD+X3yBLX33DPV1
 mrwTkvduV/T+5ubfZjakK4ae4kYwFDvMDdIU1HYSMXI4F7WqgyFZYgI9N w==;
X-CSE-ConnectionGUID: Tykm00BNRj61nAS36zH0PA==
X-CSE-MsgGUID: H/hE4fdRSZ+p3DZSx1+E4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="109155791"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="109155791"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 17:06:36 -0700
X-CSE-ConnectionGUID: CoiVXfoyQ3qRQYfU/uG1DQ==
X-CSE-MsgGUID: cPceU5+ETq2VV49hBfm6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="279885119"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 17:06:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:06:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 17:06:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU7GxtQhbsVY5v0t62s9LVzMrlC/imqEmNBZgOFhma7Id+pGWfiLrTUUE+Fd4PT52as+J8/mR1xwPcl2LLeaHYNF1AfkJ6oLI06aQ+Vbsmd2Z/COn8gZPDmBIyeGUgREyFWFZLO+0GQ8qHsCFhz4Nnn2lu0TorkpNFSiTN4ZtDNQ2yC8rLcvsl93GCK/X8nqywv54fmasPFOE8RWc4/diHUqmn8N5/ZHkDqOmpG3l0zO0J/h18vOl/aYzC68MzOqgC+3vTZo68H4QT2QMjKorW9KNLYIoCOa99Zz0d227mRdH38Jmmcxwh8aNesSkKW3xtffHuOR+PN6Ye+uI2i6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfrkflQhPViZU1sdP4rlBNcQb/W+bw8zBV42dfRRCQk=;
 b=Ui+D0u93EomqwnO5y+kMp9U5TFg8WY+wmwR5HoVQTduY2DX17whp+TQ/dZALE/7gq1VSuDN+wz5RtLlbVjxdGCRsscauMjTlMMp8sd8/OlOPIQu/3nijOYnpTu3MTladhoaYKcTH3za9oByCeljf9eXqrc0Ol8Svws+IcB9BfSQJpbBqI3yRdg1rt64E6IKmY/T/Nunzu5//HgMx7y85SPTeaphHYFX9UlF5ok9AGi/kCTJYm9AzfqO9p/LuPNmWAK5j/3wCUogvtVmaVIcI67TU7ANlZQXMzpG2BHZNKrqe0BLFS19brl9NN0GQQqXoC1oGRrPZdgskLotRbD3OHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 00:06:32 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 00:06:32 +0000
Date: Thu, 1 Oct 2026 17:06:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, Antonino Maniscalco
 <antomani103@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>, "Lyude
 Paul" <lyude@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Message-ID: <ar71hn8WpDHD8cHH@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001220632.3190896-8-matthew.brost@intel.com>
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ0PR11MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 279f415b-5f2d-41d1-dda0-08df201903cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Rsomq6O7qoMf8aaDAM/BupeT7STp9IcT8xaHJePBDmxR09SCiN+7KQ/tL67WtAtKMy/pmxoWpgbd8sO7mbH2C/HAgyBhWZb21lK4muMX2m3HccdaX7pAj/hVxHrvcKbnPJNRO/31cAnsHuiMorajaHKUsfIXU0tV3/avA+xu8sXBgBWDf2GsojA348JwNKUCckl2BgZ6vsWrOokOQxIIab/J76pKOVxELhEgHK8nvzSFeIcLndZptwZS3y/osQAUJBe1TOxJEvo8hdk5vJTLPwwdPerqj+l3qf0V3IOwjo/X/jUzjAaw9/awU/y739v4cshjY8zn8XuPsfMHd+2MHiGKJ9xu6QforexiG3ipHQ3miEmvgBquloAWIDTJSICpqHFSXSeWBynFVk8E4qlVcYShQd1rSRSax83AsX5JBUGmeTVQb3Gob/hSOR95b16ufV4ySig1kioScM6UJhpuLV8PWIlzFR3qoF8Xv/7Ip6TguGzNCzwVW/Fgpbf3/8A3UZykY0iArxd/HEu2VC83uCFIHUM7Eo2mEaGouVaVr2TiyBJfH1Nsq6HSNpqr4vFHXjaGbIQuAIsT0vcolB1VAjb0PjMFl987ez39vIHqlNRSfe2nje81hqgZoH0LuN9HXGpfc3rX5WRVQtM2PlhUwQ5FWffUbjnhVnGJDyXlqe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IMI7RTmhaU9HHvXpeVwsZ9341SeiT5J0ONFg3BCnVwH0LEXBX6UxTe3iyi?=
 =?iso-8859-1?Q?ZF0B8hS+9uTJoW6XU2v1uX2cUIfWjABQLIEUS/bJJ2rY508worbYnFuvps?=
 =?iso-8859-1?Q?qLyJEkY0JD7AX012gHFLt8Vg9uJoiVYmkREc6n6/dxXhYz1iHgVdF2slgv?=
 =?iso-8859-1?Q?LHwmbc/H8Q24ke4Bjm6Wnf3UQu88GuQQosTAeZKrJn+SaGE0tQuMksMGmb?=
 =?iso-8859-1?Q?3uPIt10ZfTeoLvJSX2GFGqpUQWtytyu5HcyNFjxI0rwGzB4Z35RXLH7945?=
 =?iso-8859-1?Q?My2nCmKAT76GKoDflLKBoON7tQ9l9zQmKIAHJP6nLvfKua64LEJDeu093m?=
 =?iso-8859-1?Q?AtLYbL29HFcZd5RYV3bACCFjaLfkFC5ER+kvE+G1MrkWOXJWAk5U7EjGkH?=
 =?iso-8859-1?Q?YGkgiOAvrJzaRgBIQLb1RbDgFdRkXXl4Hiw4k1uOnzhb9qLtO9lgf70DRQ?=
 =?iso-8859-1?Q?F64+ih1kqVXOVcyuLM/KxNAnXZvLJBqjHk964osW+No/75FnC+usBqb+oB?=
 =?iso-8859-1?Q?k7WRbJQOV9gIH32pqwymLJaUeN5sYH3upS9qF3YVE3R/bPYG7vRWLfiOxR?=
 =?iso-8859-1?Q?tWhZsfxnqzHmIQC6M9dnH0dskKbBQ0Ok9i9O4X5voB0Hs8Hmq9F87kAswv?=
 =?iso-8859-1?Q?cod4VX70lV3lgYK8llJFsTBe56NBbEgZ5FfERMt1sMI0B8g7lFlnCQlRHb?=
 =?iso-8859-1?Q?4XA8xy2rN4PJgaX9l68f80zoC4XhTvk4QnRgqKxysNGFMaWUb2B7N6MJXa?=
 =?iso-8859-1?Q?VC1leEvZW/Uqz9Ej8clRvMt9lfWi7Ctv69firGLztCELi5srbDOAkg+u1H?=
 =?iso-8859-1?Q?ioDYKan0jIPNLh0Y1fQ9fc0MnvGzTO0SEZkIpJ5mG02vXI6ad1ovCsaOyP?=
 =?iso-8859-1?Q?dLnKRzraSz+HPrD/Y7YIxCTtSUciL0+DGMqPENJCjvUMfPKkr5SDIdLgud?=
 =?iso-8859-1?Q?ribUE/Tc8G95IqB1uwJJmUJ1nysY0p0zg/UG+13aQvw8L41aaOl2X+f9RF?=
 =?iso-8859-1?Q?zqhXeiCT0kc39ZW4PUt/j1IoZpdeX1UASktRLbddGK7gcv5k9uUd5LbRKi?=
 =?iso-8859-1?Q?qR/WnWOh0GhsMEK9lv8zpQCMVrMmExkdyZh9UuZcN7eUVo1dHRQ4vqldv1?=
 =?iso-8859-1?Q?SmSuWWMNuiVTuUD+Y4BsrLd7iwSBsJi6XBzPi9iQmLDL7JjPP6aNLc0e/g?=
 =?iso-8859-1?Q?YwITCnSfFCj08pKIXNDp6OCu40SJN8bzetWa5J938UPr/prH4o8dIa4OKi?=
 =?iso-8859-1?Q?dAGYusCE6yz6ac/udYUsrtVMkm7YXQAx01+CxMSqbNcfqLSulkMXDBYG51?=
 =?iso-8859-1?Q?atmmEq3gGIRlzU2gLTup3+0trpuXZj/IQ08oeC1vZmBYQTbEdEWvJXE/Tf?=
 =?iso-8859-1?Q?7SZ6tgNNy1rHR99FGTlR8HkYC7X1guHKpJEtY1qp9A6bLK2XxvQoyQ7ngd?=
 =?iso-8859-1?Q?fqU/3Bq9bi7lzcteD3MqItuwBMpH19AARSTWX3ue3MhbKTOjm18lp1qZbL?=
 =?iso-8859-1?Q?nL+Egbg9jHPFqehLts1pPvs3whpnC9/Xl9yt4kXIDonSC7nUxB6qB/YAAb?=
 =?iso-8859-1?Q?t6YyLV91tKMqPqAUkIgQjdS8ymV/FaretUbO5bS//naS2w1XjCmj2ZyFqR?=
 =?iso-8859-1?Q?R+Y/E3ycHdCFK7ZamviJr+jOBlecQZvUn11SLl37+t2vVjLdVhlXtRGuei?=
 =?iso-8859-1?Q?UzHBFnCYzFhje7NemrThR7aQb3xTexfPtvqFbDtOH6E+E/H2Or7O69RY9G?=
 =?iso-8859-1?Q?xyqlraTxbn6e+BpdDjnFrcylQDtaABBdSZuXGklFs3ka4soo5HYv7LOAuu?=
 =?iso-8859-1?Q?APPxWJ0WEyVk5r1LQbT4I9SNfQ6hZnI=3D?=
X-Exchange-RoutingPolicyChecked: BigDPcSB2YDRVsOE2wnK92EiNcnk07Y8pJ4TVDyM039UaXgcacJJXIwQvm9dUTJtbulb5iUDuOgeeDWOWwWijx/JTjq+sZIR3f2vRET7iO8Shz++Q1lzMfMzxiu4TKD7yViX7wJ+8854zCQjiyI45g2YQbOIp5tlav6hyhAidzp+sNaFIoJftn48Bi7CqriM5pnxvqPvaWjQ9DLgumc3FWMgw0w710gT1UTDuFKOW6SBr0Hto0ej/bY7UBtUPlpbW5CPQcGeXhWKGgPnMProEm4eaht2khUdS1DoL+b7TXli4wy6ARnqKLDEwLnAgM2C36DipS1394puY5UHZ6LpHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 279f415b-5f2d-41d1-dda0-08df201903cd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 00:06:32.2274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2rPLqn+yZbUNArxXQBe9EdkiUGI1ETPdeouc0U8Io7pAbPgo73gHrWOyjAvu26uaFw9w66BgQ4k0+yp2X/g+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
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

On Thu, Oct 01, 2026 at 03:06:31PM -0700, Matthew Brost wrote:
> nouveau creates its drm_gpuvm without DRM_GPUVM_RESV_PROTECTED, so the
> extobj and evicted lists are protected by internal spinlocks. Every
> nouveau path but three already touches them with the VM's resv held:
> drm_gpuvm_exec_lock() and drm_gpuvm_validate() on exec, and TTM moves of
> private BOs, which share the VM's resv. The remaining three are:
> 
>  - nouveau_uvmm_bind_job_submit() adds the vm_bo of a MAP op to the
>    extobj list holding no resv at all. Move that into
>    bind_lock_validate(), which now locks the VM's resv as well.
> 
>  - bind_link_gpuvas() unlinks the GPUVAs of UNMAP and REMAP ops, which
>    can drop the last reference of their vm_bo. It runs within the bind
>    job's drm_exec transaction, which the above makes hold the VM's resv.
> 
>  - nouveau_uvmm_bind_job_cleanup() and nouveau_uvmm_fini() can drop the
>    last reference of a vm_bo holding only the object's resv. Lock the
>    VM's resv along with it, through a new
>    nouveau_uvmm_lock_vm_and_obj().
> 
> The bind job's fence now always lands in the VM's resv, as BOOKKEEP.
> This already happened whenever a bind job mapped a private BO.
> 
> With that the internal spinlocks buy nothing, so set
> DRM_GPUVM_RESV_PROTECTED. This is also what two-pass locking in
> drm_gpuvm requires, which a following patch makes use of.
> 
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> Cc: Antonino Maniscalco <antomani103@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Assisted-by: LLM
> ---
> v3:
>  - New patch (Danilo)
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 49 ++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index 2026fe6b48c6..dae612e56d91 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1187,6 +1187,27 @@ bind_validate_region(struct nouveau_job *job)
>  	return 0;
>  }
>  
> +/*
> + * Lock the VM's common dma-resv together with the one of @obj, as needed to
> + * drop what may be the last reference of a &drm_gpuvm_bo.
> + */
> +static void
> +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_exec *exec,
> +			     struct drm_gem_object *obj)
> +{
> +	int ret;
> +
> +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> +	drm_exec_until_all_locked(exec) {
> +		ret = drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
> +		if (!ret)
> +			ret = drm_exec_lock_obj(exec, obj);
> +		drm_exec_retry_on_contention(exec);
> +		if (drm_WARN_ON(uvmm->base.drm, ret))

Sashiko flagged that -ENOMEM is a possible return from drm_exec_lock_obj
if a kmalloc fails and that is correct.

My plan is to change this and open coded WW transaction which can't
fail.

Not going to post now as I don't want to spam the list.

Matt

> +			break;
> +	}
> +}
> +
>  static void
>  bind_link_gpuvas(struct bind_job_op *bop)
>  {
> @@ -1224,12 +1245,24 @@ bind_lock_validate(struct nouveau_job *job, struct drm_exec *exec,
>  		   unsigned int num_fences)
>  {
>  	struct nouveau_uvmm_bind_job *bind_job = to_uvmm_bind_job(job);
> +	struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(job->cli);
>  	struct bind_job_op *op;
>  	int ret;
>  
> +	/* The VM's dma-resv protects its extobj and evicted lists, and must be
> +	 * held by bind_link_gpuvas() in case it drops the last reference of a
> +	 * &drm_gpuvm_bo.
> +	 */
> +	ret = drm_gpuvm_prepare_vm(&uvmm->base, exec, num_fences);
> +	if (ret)
> +		return ret;
> +
>  	list_for_each_op(op, &bind_job->ops) {
>  		struct drm_gpuva_op *va_op;
>  
> +		if (op->op == OP_MAP)
> +			drm_gpuvm_bo_extobj_add(op->vm_bo);
> +
>  		if (!op->ops)
>  			continue;
>  
> @@ -1288,8 +1321,6 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
>  			dma_resv_unlock(obj->resv);
>  			if (IS_ERR(op->vm_bo))
>  				return PTR_ERR(op->vm_bo);
> -
> -			drm_gpuvm_bo_extobj_add(op->vm_bo);
>  		}
>  
>  		ret = bind_validate_op(job, op);
> @@ -1603,9 +1634,11 @@ nouveau_uvmm_bind_job_cleanup(struct nouveau_job *job)
>  			drm_gpuva_ops_free(&uvmm->base, op->ops);
>  
>  		if (!IS_ERR_OR_NULL(op->vm_bo)) {
> -			dma_resv_lock(obj->resv, NULL);
> +			struct drm_exec exec;
> +
> +			nouveau_uvmm_lock_vm_and_obj(uvmm, &exec, obj);
>  			drm_gpuvm_bo_put(op->vm_bo);
> -			dma_resv_unlock(obj->resv);
> +			drm_exec_fini(&exec);
>  		}
>  
>  		if (obj)
> @@ -1941,7 +1974,8 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
>  	mt_init_flags(&uvmm->region_mt, MT_FLAGS_LOCK_EXTERN);
>  	mt_set_external_lock(&uvmm->region_mt, &uvmm->mutex);
>  
> -	drm_gpuvm_init(&uvmm->base, cli->name, 0, drm, r_obj,
> +	drm_gpuvm_init(&uvmm->base, cli->name, DRM_GPUVM_RESV_PROTECTED,
> +		       drm, r_obj,
>  		       NOUVEAU_VA_SPACE_START,
>  		       NOUVEAU_VA_SPACE_END,
>  		       init->kernel_managed_addr,
> @@ -1978,6 +2012,7 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
>  	struct nouveau_uvma_region *reg;
>  	struct nouveau_cli *cli = uvmm->vmm.cli;
>  	struct drm_gpuva *va, *next;
> +	struct drm_exec exec;
>  
>  	nouveau_uvmm_lock(uvmm);
>  	drm_gpuvm_for_each_va_safe(va, next, &uvmm->base) {
> @@ -1989,9 +2024,9 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
>  
>  		drm_gpuva_remove(va);
>  
> -		dma_resv_lock(obj->resv, NULL);
> +		nouveau_uvmm_lock_vm_and_obj(uvmm, &exec, obj);
>  		drm_gpuva_unlink(va);
> -		dma_resv_unlock(obj->resv);
> +		drm_exec_fini(&exec);
>  
>  		nouveau_uvma_unmap(uvma);
>  		nouveau_uvma_vmm_put(uvma);
> -- 
> 2.34.1
> 
