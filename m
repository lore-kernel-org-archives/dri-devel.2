Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C072606A331
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJ8tV6bo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E7D10E72B;
	Mon,  2 Nov 2026 22:17:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B70710E724;
 Mon,  2 Nov 2026 22:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793657859; x=1825193859;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1f5dpbVrPCBYfSSkpEYPuthuBip8H1lleg3oVsTu+wk=;
 b=eJ8tV6boA7jxYNHqKdo0QH7L2QNtheVItZF+aX2U7FID+W5OisQg+oV2
 Ou6jR72mTc/jQ/FyeSSqEaEdSFvZ6M+W/pImunlpTWSUR/u+t81VgSvFl
 VqLC1er4AHngu44jpf4Lob+sJToANvXlj5RiauQSedzO5su8IG1yQa8K9
 JgeUEHrL1XIPf3qc6iclG2NKd9evSHmWUbdmEsVNRBwMn78hGupLFV3vs
 Acl0qe4cLMBo6ZROZOUSvG8a9AY2jn5BWC0TnA5fn8Hx0+i357qvnfNwb
 OvNAkvT5dIHIzKVWkgazR7egbg750GqHdxuVlgF4DegymWvu12s+/iAA5 w==;
X-CSE-ConnectionGUID: NMFt0q0zQJisP6auUHpomg==
X-CSE-MsgGUID: /TMd5cNaSJGTjxQSoBADAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2266778"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2266778"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:17:39 -0800
X-CSE-ConnectionGUID: zIri87NORFq0x44tDoXsRQ==
X-CSE-MsgGUID: ZG+ehHJJSuSlkdnt15rYxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6331326"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:17:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 14:17:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 14:17:37 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 14:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f33tjyNkxWGI1DWO908DntxRHLlRHGLjPfn+qBoWWH/KPFunT5SxyFjdTFDRLBHL0SfTubIJ2Tg4k5OrjLplDySUL/QHdTsL3wsikVxfVhKgCeDqigrseXa3ypJLXJtNA9iBu2+iT62QQPHcyMEhhFbtboWOiCn8GO+SEdhcmGBAqrMXsNu+Bba/i/0bs9gEnM7d4qNKaAclV4utKgs7B5uh5fSJbacz88FgfSWL0+B9l2P7mchasQaJ6sjEOdb43JjRd1398sqIGciZtlilhRKxVJpRzRhwi55vdar6ilJfFHCiE4wMiJKDjFl8hRDfGf/YLOXjnfHMMMFceQdpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjmayXvY535CP9bhioCaIloVqMZXnUk3E6AlCsEpX9E=;
 b=Qcw+VXh/e+rc+UkLXh9BxmVHaKZzCBNAwEaMaj0rSP6YrSAJw8nWnkaawXuXk4uqVpM7oVbi7EByjxrM7QwuLPzr0TeOQwnCbRFctoKwxEF7rw1MBHuyH7tdbbUuijDkpEwtdj4QZLrWcvDd9w+WYfzVD8HTgdJx3l36H6Mipe1f2C2xPsiR+y6x79lhbu5aaiIkoO2sbmeEkQuoAjnvSPatWhG9DUYYnwRIeEt6H902VbutWEPVmS89n/Hs3n0pywO4twrCnrvbJUD09sGbf7VBy/9xy6Uik2h9YF481up+guGyGBZagDUfiG3ENGpLP0mHYw763kSdIMDMJfY5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 22:17:32 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 22:17:31 +0000
Date: Mon, 2 Nov 2026 14:17:29 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 3/3] drm/xe: Add a minimum age gate to the shrinker
Message-ID: <aukL+QV8PRV3C5Qo@gsse-cloud1.jf.intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-4-matthew.brost@intel.com>
 <bff778512e4c9a9abde641a23b98514309509d56.camel@linux.intel.com>
 <auUJNoo1ZpzBevGR@gsse-cloud1.jf.intel.com>
 <4a195bb607e70abb00bf8be322e3bb55540a9b62.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a195bb607e70abb00bf8be322e3bb55540a9b62.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH3PR11MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a667e9-7e40-4b4c-123e-08df392f16b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|261102123227099003|6133799003|18002099003|22082099003|261102130727099003|5023799004|56012099006|4143699003|11063799006|261022115727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261021123027099003|261026121527099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: fH/P16e2sfD94JFUXWY3R62ho3xfnqtp7YE7/uWte6thIbyl8T0F3THJY0dr23D2BhwRICvcO5svKz9BZFpe9JNuujDdyF0gdcQ94BbKJLe0B5lUSN3VwSlQhnyh340JLy0xnS1gfNFVl4Yv93/of9+81vTOSD0q2KVCMYHFUru3I58haxeFxae3SAhX63x0FEiga7N54WhOQREBhHZHw0xHMpnuTTiquLuPusAb8pe5xqlFuunuzWetNJyGBiA+g2Ku9eoA4hsrmHEr8QHTGJSP7TTCkRE6LRV1RJMeT/efA+cboSAtXXg+cd7v8l8oacqK6SVcOZb4uC3Kx83tV5vfRCPhn93iujZwgv7chW2NUjkjMuIZ8rdyUr6DttCYFic3+b8veyeNOLi5BCIKhD+t24yiSSm+UCsCGFaKPpcPZvAZ1N2JEcsongvB5uoxQvOj0dIakZhCEqTND1+Kc1rSvInjNoeHScDCmYOOoHs322qka/PkqWCSXj3QqS9skwFPwU+Nv1L6fHrIIwvIRzYSVVLt1gHh5OUGlCfn4rEI0JhgNZLmYW+Vb94Go6GqOttnOlAkQazM0s2eHwTZzbyYCAEcvaDmozqHvoO8NAwo7Vt+XAV9Jy6Up3xqkpSxS6291xsREjwaZ/nCPJBTMr7du8mS+aB9t3wRHHs++KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(261102123227099003)(6133799003)(18002099003)(22082099003)(261102130727099003)(5023799004)(56012099006)(4143699003)(11063799006)(261022115727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261021123027099003)(261026121527099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YvC1GUrLStlfM7qvUpHQACOTww5Pm0C+22LBl0ZI88O9JeU7wv7sCxqpcS?=
 =?iso-8859-1?Q?J7TyuHMg/Vq/0iHA5mZhwBHHeEVanOvFOxSgy7t91/WjdK6LCar8f8JQHv?=
 =?iso-8859-1?Q?QosLmiNCmDIamrNn/qnVlORrNx0boSUzGNfvEhuvftwqxW/n/x9sw4Nqn8?=
 =?iso-8859-1?Q?LjSgvdfAkwbHfpypaFIlEidu4xhljunLBmCpyhNinOSYXzQH9wMluTr2w8?=
 =?iso-8859-1?Q?dHAgunZ0CA2ARoJ4qyfClcBCEJljbEKaxTNYiCggX6Fxuoms4qqzd4IRLl?=
 =?iso-8859-1?Q?H4dLgtXAQHD324Y37pnxKRumdK8QKmIdBpDQ7RFz4l+I0ocorN3tsBxknW?=
 =?iso-8859-1?Q?R+wPuhZsXbXoDpcLpylD5kWpPb0jQ0wkd4Xh3OTzsxcMt9sa+Py7ShR/nW?=
 =?iso-8859-1?Q?Llfq2ypfSc3UJ+75+eMrwkxgv4Mypd/r+2gnHziA3ehv5ZDlxAJ+wz/n+W?=
 =?iso-8859-1?Q?QbKd2P1BkbOwxu/TJJ9JVR0ifC6awjPN2L92Yi3FyDy3M39eeNA1fbPkw+?=
 =?iso-8859-1?Q?Bp34BZ4tfJBxGduq1b5DTZCqsEtJaeuKHM+49hI7LqJIbBU7YcVpC1eDM2?=
 =?iso-8859-1?Q?YwKK48VADDWmsoJYH/nPrH23GvysIxphqwO2yT3n9FYGDl+LNKbLmsd8Dv?=
 =?iso-8859-1?Q?cHcPf40UFrbGKHDxneg8LhMZTg7RvG8Cqq7CjxLvac+7rdd9PCAywkeCGy?=
 =?iso-8859-1?Q?8qZcKc4LHxRR/FJSBo0AOBr+SkipY7OrEKtmeBlSjghP8bWHzamOrZnUwP?=
 =?iso-8859-1?Q?RPmcF51Pqjqb4x9prJNqKFwyc87dEYnEaVtNTiPlrjJc/hLlgkI5dT2pyl?=
 =?iso-8859-1?Q?Mv9lbBvwdk3BarDSPwp0yOZfirBR/Ly1XezwRW5quFBWypiI6ylkQejstT?=
 =?iso-8859-1?Q?JlRZb3m3OjGw9ruhf8IIXw0jr4scf9wHm+zn4avjVMkoPL8D5+k72dp+el?=
 =?iso-8859-1?Q?g6g6TaZ40cl+SCVrRuDARNyK70vGCkQGzgkrFxv50PCY2Vfei8hgrrUUdK?=
 =?iso-8859-1?Q?im5gqxhSIX2PO/oFUkRdce0PBhaMxfeu/obIPIzksWpv0l9MIG+8fA81T9?=
 =?iso-8859-1?Q?9aZzuf4QK/I7mwJH5MSR+zkTWAxWrbMTuJacdlkP6sy2GOxnToLwi4sJO/?=
 =?iso-8859-1?Q?Oz0/qy1vGBGDx1xYA8quLdzl/9kAfsaYlap/5kvoHPcI1dsQ5GZPYNkPPR?=
 =?iso-8859-1?Q?LjTMBPixJVYl9rwWKMT3thWhVjNjO7beTOsF/UVEh8S/ZkdjkdSkfw9Hre?=
 =?iso-8859-1?Q?Q/LJH78W5f3RF5f6BVgjcqXUy6EGtLD5Anl6ok1ZUGwuimTaY1iT8UO9sA?=
 =?iso-8859-1?Q?GJstN5N9H7sPgdEfj9MOCaodmg4k5KsDEZmkvJ/PEymnkcL98FQ8nrhX5j?=
 =?iso-8859-1?Q?zlgqavnVHPl3oDitqaG7WD3pE8MPmG5Gg1IsK3BrlQXrizZJbFnqVB9sM1?=
 =?iso-8859-1?Q?azraZ9Vl2J/aM80KnzAGUTofYxIfOBmtufGIDF2KtO5OU8JNBKFqrKKNQS?=
 =?iso-8859-1?Q?bHeS/0n+jYBPbiRoEqrfc2hIfCBwECwZXvvoPF9ThBVrFFoIZsHUxyS2tG?=
 =?iso-8859-1?Q?SEDouI3bfChi4YU/Oo1XvrOO6QTsWDwbciyM5ZUhXS8Win0tQTLqzzQoji?=
 =?iso-8859-1?Q?jtnmvt2P0MErqXccFdHDvMEcNYZ9c8fAt9NFMFwGv3SFz4mrV7gOypSWL8?=
 =?iso-8859-1?Q?VGso3I3KH4HdhMDH61LETQNZUlW4Tx8eNKocZFuUk/PGra3tQls4x1Qpjx?=
 =?iso-8859-1?Q?rhg5EXqfK1kxIbA0ldwOL0NoMQQOgahkWqRJRZAFY/J7n7RfEZSHR7qjwS?=
 =?iso-8859-1?Q?IWz+B9VEeQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: q4nihY/bb3O0xx1OjEx37xA5T11NkATUCcn/3GAHc9kxQtEPMktuNVgrkOhOAfmoqiEc7amrEE7+JEtdBEP/eGXhZMeqh8uKqxT0NrNXRyUf1Tm/2y6pgaFnHsbHcfLFz+Q/UQxXzKyMO5ZFmmxlnpeYZloGgbEH6FiELmJepCWBmNkRzp4yV8ySAzWqvQLZVhbyJRAc8sJXj4EqIDa3NQJv9uR8nELfKNxt/+wnX836gLRYuJPczqZUmWtqcH31PYHtPurPHRCERiWMra44U5t4A/ek2IpTgVdxO9jSb9HDy7ks8IqdicpD9b0umujK7gKBUwlCZAkMHpG0QZV2qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a667e9-7e40-4b4c-123e-08df392f16b3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 22:17:31.9018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B0dU07UrNKOpQxiszHgmwNOUA2STKcJ0jsf204qLbfTdssgStxQK/sP9hygY76zBW/IChm7MiCyL70bupES1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
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

On Mon, Nov 02, 2026 at 11:41:13AM +0100, Thomas Hellström wrote:
> On Fri, 2026-10-30 at 14:16 -0700, Matthew Brost wrote:
> > On Fri, Oct 30, 2026 at 04:17:20PM +0100, Thomas Hellström wrote:
> > > On Tue, 2026-10-27 at 15:49 -0700, Matthew Brost wrote:
> > > > Backing up a BO costs a GPU blit plus a page copy, and if the BO
> > > > is
> > > > part
> > > > of an active working set it is faulted straight back in on the
> > > > next
> > > > exec.
> > > > Evicting a BO that was used moments ago is therefore almost
> > > > always a
> > > > loss, yet the shrinker has no notion of recency beyond LRU order.
> > > > 
> > > > Timestamp BOs wherever their LRU position is updated, and read
> > > > the
> > > > stamp
> > > > back from whatever owns that position. A BO in a VM's bulk move
> > > > is
> > > > anchored inside its range, so it is aged by the VM-wide stamp
> > > > taken
> > > > in
> > > > xe_vm_bump_lru() alongside the bulk move itself. Any other BO
> > > > carries
> > > > its own, stamped there too and on a successful move into TT in
> > > > xe_bo_move(), where ttm_resource_alloc() has already placed the
> > > > new
> > > > resource at the LRU tail.
> > > > 
> > > > Add a per-device shrinker_min_age_ms sysfs attribute, defaulting
> > > > to
> > > > CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS (0, disabled). While set, the
> > > > shrinker
> > > > won't back up BOs younger than the delay. Each LRU priority is
> > > > roughly
> > > > age ordered, so the gate is applied per priority:
> > > > xe_shrinker_count()
> > > > snoops the first shrinkable BO of each priority and reports
> > > > nothing
> > > > only
> > > > if all of them are young, and the backup walk skips to the next
> > > > priority
> > > > at the first young BO, both as a backstop for the count sample
> > > > and so
> > > > a
> > > > hot priority doesn't shield colder BOs in another one.
> > > > 
> > > > Only BOs this shrinker would actually back up have a say. BOs in
> > > > XE_PL_SYSTEM, which are not GPU mapped and hence not part of a
> > > > working
> > > > set, and BOs xe_bo_shrink() rejects outright are never young.
> > > > Purgeable
> > > > BOs and those advised DONTNEED are neither: they are dropped
> > > > rather
> > > > than
> > > > backed up and accounted to the purgeable shrinker, so they are
> > > > never
> > > > young and the count snoop skips their XE_BO_PRIORITY_LOW band
> > > > entirely.
> > > > 
> > > > The gate is hard and applies at every reclaim priority, so a
> > > > working
> > > > set
> > > > kept younger than the delay is never backed up and can lead to
> > > > OOM.
> > > > This
> > > > is deliberate, and why it is off by default.
> > > 
> > > For completeness, Perhaps add to the commit message that
> > > the plan is to follow up with an OOM notifier?
> > > 
> > 
> > That is a possible option. Another idea I had was if we can get the
> > priority exported from the shrinker core - we have a config knob that
> > says 'at this priority or greater', shrink BOs which have been used
> > recently.
> > 
> > > I also wonder what happens during the PM notifier preparing for
> > > suspend
> > > on DGFX, Does that move mark bos accessed, hence possibly blocked
> > > by
> > > the shrinker at suspend time?
> > > 
> > 
> > I haven't tried this on DGFX, can give it try but this off by
> > default.
> > 
> > I'm also a little confused by this - does the shrinker run at suspend
> > time? I thought once the memory in ram a hiberation image in created
> > from the that - i.e., there isn't a requirement the BOs to get shrunk
> > into shmem.
> 
> The problem occurs when evicting VRAM to system memory during the pm
> notifier. If system fills up then the shrinker kicks in. But if that
> eviction from VRAM to system doesn't bump LRU / update timestamps then
> that is not a problem.
> 
> For hibernation I'm not sure whether whether we actually see backup
> shrinking, since it requires __GFP_FS and __GFP_IO for writeback, and I
> think those are turned off during hibernation shrinking.
> 
> 
> > 
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > ---
> > > >  drivers/gpu/drm/xe/Kconfig.profile   |  15 +++
> > > >  drivers/gpu/drm/xe/xe_bo.c           |  83 ++++++++++++++
> > > >  drivers/gpu/drm/xe/xe_bo.h           |   5 +
> > > >  drivers/gpu/drm/xe/xe_bo_types.h     |   8 ++
> > > >  drivers/gpu/drm/xe/xe_device_sysfs.c |  35 ++++++
> > > >  drivers/gpu/drm/xe/xe_pagefault.c    |   2 +-
> > > >  drivers/gpu/drm/xe/xe_shrinker.c     | 164
> > > > +++++++++++++++++++++++++--
> > > >  drivers/gpu/drm/xe/xe_shrinker.h     |   3 +
> > > >  drivers/gpu/drm/xe/xe_vm.c           |   4 +-
> > > >  drivers/gpu/drm/xe/xe_vm_types.h     |   8 ++
> > > >  10 files changed, 316 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/Kconfig.profile
> > > > b/drivers/gpu/drm/xe/Kconfig.profile
> > > > index 23045ed2aa94..dd3985e502b8 100644
> > > > --- a/drivers/gpu/drm/xe/Kconfig.profile
> > > > +++ b/drivers/gpu/drm/xe/Kconfig.profile
> > > > @@ -74,6 +74,7 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
> > > >  	  to apply to applicable user. For elevated user, all
> > > > above
> > > > MIN
> > > >  	  and MAX values will apply when this configuration is
> > > > enable to
> > > >  	  apply limitation. By default limitation is applied.
> > > > +
> > > >  config DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS
> > > >  	int "Default seeks value of the non-purgeable bo
> > > > shrinker"
> > > >  	default 8
> > > > @@ -86,3 +87,17 @@ config DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS
> > > >  	  reclaim pressure on non-purgeable buffer objects,
> > > > which
> > > > need
> > > >  	  GPU idling and writeback to be reclaimed, in favour of
> > > > purgeable
> > > >  	  ones and other kernel caches.
> > > > +
> > > > +config DRM_XE_SHRINKER_MIN_AGE_MS
> > > > +	int "Default minimum BO age before shrinker backup (ms)"
> > > > +	default 0
> > > > +	range 0 1000000
> > > > +	help
> > > > +	  Default for the per-device shrinker_min_age_ms sysfs
> > > > attribute. The
> > > > +	  shrinker won't back up a BO that was moved into TT, or
> > > > bumped on the
> > > > +	  LRU by an exec, less than this many milliseconds ago.
> > > > BOs
> > > > already
> > > > +	  evicted to system memory are not part of a working set
> > > > and
> > > > are
> > > > +	  never protected. This applies at every reclaim
> > > > priority: a
> > > > working
> > > > +	  set kept younger than this is never backed up and can
> > > > cause OOM.
> > > > +	  Only set if that risk is preferred over thrashing a
> > > > hot
> > > > working
> > > > +	  set. 0 disables.
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > > > b/drivers/gpu/drm/xe/xe_bo.c
> > > > index 42a6aa1a2e4a..a4c0c6284a24 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > @@ -1357,9 +1357,92 @@ static int xe_bo_move(struct
> > > > ttm_buffer_object
> > > > *ttm_bo, bool evict,
> > > >  		xe_tt_unmap_sg(xe, ttm_bo->ttm);
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * ttm_resource_alloc() already placed the new resource
> > > > at
> > > > the tail of
> > > > +	 * its LRU, or of @bo's bulk move, so only record when
> > > > that
> > > > happened.
> > > > +	 */
> > > > +	if (!ret && ttm_bo->resource && ttm_bo->resource-
> > > > >mem_type
> > > > == XE_PL_TT)
> > > > +		WRITE_ONCE(bo->lru_stamp, jiffies);
> > > > +
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +/**
> > > > + * xe_bo_bump_lru_locked() - Bump a BO on the LRU and stamp its
> > > > last
> > > > use
> > > > + * @bo: The buffer object, reserved by the caller.
> > > > + *
> > > > + * Move @bo to the tail of its LRU and record the time for the
> > > > shrinker's
> > > > + * minimum age gate. Only meaningful for BOs outside a bulk
> > > > move,
> > > > since a
> > > > + * BO in one is anchored inside its range and is bumped, and
> > > > aged,
> > > > with it.
> > > > + * The caller must hold the device LRU lock.
> > > > + */
> > > > +void xe_bo_bump_lru_locked(struct xe_bo *bo)
> > > > +{
> > > > +	WRITE_ONCE(bo->lru_stamp, jiffies);
> > > > +	ttm_bo_move_to_lru_tail(&bo->ttm);
> > > > +}
> > > > +
> > > > +/**
> > > > + * xe_bo_shrink_backup_candidate() - Whether the shrinker may
> > > > back
> > > > up a BO
> > > > + * @bo: The TTM buffer object, reserved by the caller.
> > > > + *
> > > > + * A BO is a backup candidate if backing it up is the only way
> > > > to
> > > > reclaim it.
> > > > + * BOs advised DONTNEED, which sit at XE_BO_PRIORITY_LOW, and
> > > > purgeable ones
> > > > + * are not: their pages are simply dropped, which is cheap, and
> > > > they
> > > > are
> > > > + * accounted to the purgeable shrinker. Neither are the BOs
> > > > xe_bo_shrink()
> > > > + * hands to xe_bo_shrink_purge() outright: ghost BOs, which
> > > > aren't
> > > > xe BOs,
> > > > + * and BOs already freed and waiting to be reaped. Nor are BOs
> > > > whose
> > > > tt
> > > > + * isn't TTM_TT_FLAG_EXTERNAL_MAPPABLE, which xe_bo_shrink()
> > > > rejects.
> > > > + *
> > > > + * Return: true if @bo would be backed up by a non-purge shrink
> > > > pass.
> > > > + */
> > > > +bool xe_bo_shrink_backup_candidate(struct ttm_buffer_object *bo)
> > > > +{
> > > > +	struct xe_ttm_tt *xe_tt;
> > > > +
> > > > +	if (!xe_bo_is_xe_bo(bo) || !kref_read(&bo-
> > > > >base.refcount) ||
> > > > !bo->ttm ||
> > > > +	    !(bo->ttm->page_flags &
> > > > TTM_TT_FLAG_EXTERNAL_MAPPABLE)
> > > > > > 
> > > > +	    bo->priority <= XE_BO_PRIORITY_LOW)
> > > > +		return false;
> > > > +
> > > > +	xe_tt = container_of(bo->ttm, struct xe_ttm_tt, ttm);
> > > > +
> > > > +	return !xe_tt->purgeable;
> > > > +}
> > > > +
> > > > +/**
> > > > + * xe_bo_shrink_too_young() - Whether a BO was used too recently
> > > > to
> > > > shrink
> > > > + * @bo: The TTM buffer object, reserved by the caller.
> > > > + * @min_age: Minimum age in jiffies. 0 disables the check.
> > > > + *
> > > > + * The age is taken from whatever owns @bo's LRU position:
> > > > &xe_vm.lru_stamp
> > > > + * if @bo rides along with a VM's bulk move, its own
> > > > &xe_bo.lru_stamp if not.
> > > > + *
> > > > + * BOs that the shrink walk would not back up anyway are never
> > > > considered
> > > > + * young, see xe_bo_shrink_backup_candidate(). Neither are BOs
> > > > in
> > > > + * XE_PL_SYSTEM: they are not GPU mapped, hence not part of a
> > > > working set,
> > > > + * and must be moved back to TT, refreshing the stamp, before
> > > > use.
> > > > + *
> > > > + * Return: true if @bo was touched less than @min_age jiffies
> > > > ago.
> > > > + */
> > > > +bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo,
> > > > unsigned
> > > > long min_age)
> > > > +{
> > > > +	struct xe_bo *xe_bo;
> > > > +	unsigned long stamp;
> > > > +
> > > > +	if (!min_age || bo->resource->mem_type == XE_PL_SYSTEM
> > > > ||
> > > > +	    !xe_bo_shrink_backup_candidate(bo))
> > > > +		return false;
> > > > +
> > > > +	xe_bo = ttm_to_xe_bo(bo);
> > > > +	if (bo->bulk_move && xe_bo->vm)
> > > > +		stamp = READ_ONCE(xe_bo->vm->lru_stamp);
> > > > +	else
> > > > +		stamp = READ_ONCE(xe_bo->lru_stamp);
> > > > +
> > > > +	return stamp && time_before(jiffies, stamp + min_age);
> > > > +}
> > > > +
> > > >  static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
> > > >  			       struct ttm_buffer_object *bo,
> > > >  			       unsigned long *scanned)
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo.h
> > > > b/drivers/gpu/drm/xe/xe_bo.h
> > > > index 77b3a02e9b8e..65d4c638e8d8 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo.h
> > > > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > > > @@ -623,6 +623,11 @@ struct xe_bo_shrink_flags {
> > > >  	u32 writeback : 1;
> > > >  };
> > > >  
> > > > +void xe_bo_bump_lru_locked(struct xe_bo *bo);
> > > > +
> > > > +bool xe_bo_shrink_backup_candidate(struct ttm_buffer_object
> > > > *bo);
> > > > +bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo,
> > > > unsigned
> > > > long min_age);
> > > > +
> > > >  long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct
> > > > ttm_buffer_object *bo,
> > > >  		  const struct xe_bo_shrink_flags flags,
> > > >  		  unsigned long *scanned);
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> > > > b/drivers/gpu/drm/xe/xe_bo_types.h
> > > > index 0265fb314c77..f63b668c7134 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo_types.h
> > > > +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> > > > @@ -49,6 +49,14 @@ struct xe_bo {
> > > >  	u32 flags;
> > > >  	/** @vm: VM this BO is attached to, for extobj this will
> > > > be
> > > > NULL */
> > > >  	struct xe_vm *vm;
> > > > +	/**
> > > > +	 * @lru_stamp: jiffies at the last LRU bump, done on a
> > > > move
> > > > into TT
> > > > +	 * and at exec time. Only describes the LRU position of
> > > > a BO
> > > > outside
> > > > +	 * a bulk move; BOs in one are aged by &xe_vm.lru_stamp
> > > > instead.
> > > > +	 * Consulted by the shrinker's minimum age gate.
> > > > Accessed
> > > > with
> > > > +	 * READ_ONCE()/WRITE_ONCE().
> > > > +	 */
> > > > +	unsigned long lru_stamp;
> > > >  	/**
> > > >  	 * @q: Queue this BO is attached to, mostly for LRC BO,
> > > > NULL
> > > > otherwise.
> > > >  	 * Protected by the BO dma_resv: readers must hold it
> > > > across
> > > > both the
> > > > diff --git a/drivers/gpu/drm/xe/xe_device_sysfs.c
> > > > b/drivers/gpu/drm/xe/xe_device_sysfs.c
> > > > index ff5d25dd867c..26b1f71ed522 100644
> > > > --- a/drivers/gpu/drm/xe/xe_device_sysfs.c
> > > > +++ b/drivers/gpu/drm/xe/xe_device_sysfs.c
> > > > @@ -38,6 +38,12 @@
> > > >   * reclaimed by the shrinker. Higher values reduce reclaim
> > > > pressure
> > > > on
> > > >   * non-purgeable buffer objects. Valid values are 1 to 64.
> > > > Defaults
> > > > to
> > > >   * CONFIG_DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS.
> > > > + *
> > > > + * shrinker_min_age_ms - Report/change the minimum time, in ms,
> > > > since a BO was
> > > > + * last moved to TT or bumped on the LRU by an exec before the
> > > > shrinker may
> > > > + * back it up. BOs evicted to system memory are never protected.
> > > > Defaults to
> > > > + * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, 0 disables. This applies
> > > > at
> > > > every
> > > > + * reclaim priority, so a non-zero value can lead to OOM.
> > > >   */
> > > >  
> > > >  static ssize_t
> > > > @@ -331,8 +337,37 @@ shrinker_non_purgeable_seeks_store(struct
> > > > device
> > > > *dev,
> > > >  
> > > >  static DEVICE_ATTR_RW(shrinker_non_purgeable_seeks);
> > > >  
> > > > +static ssize_t
> > > > +shrinker_min_age_ms_show(struct device *dev, struct
> > > > device_attribute
> > > > *attr,
> > > > +			 char *buf)
> > > > +{
> > > > +	struct xe_device *xe =
> > > > pdev_to_xe_device(to_pci_dev(dev));
> > > > +
> > > > +	return sysfs_emit(buf, "%u\n",
> > > > xe_shrinker_min_age_ms(xe-
> > > > > mem.shrinker));
> > > > +}
> > > > +
> > > > +static ssize_t
> > > > +shrinker_min_age_ms_store(struct device *dev, struct
> > > > device_attribute *attr,
> > > > +			  const char *buff, size_t count)
> > > > +{
> > > > +	struct xe_device *xe =
> > > > pdev_to_xe_device(to_pci_dev(dev));
> > > > +	unsigned int ms;
> > > > +	int ret;
> > > > +
> > > > +	ret = kstrtouint(buff, 0, &ms);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	xe_shrinker_set_min_age_ms(xe->mem.shrinker, ms);
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RW(shrinker_min_age_ms);
> > > > +
> > > >  static struct attribute *shrinker_attrs[] = {
> > > >  	&dev_attr_shrinker_non_purgeable_seeks.attr,
> > > > +	&dev_attr_shrinker_min_age_ms.attr,
> > > >  	NULL
> > > >  };
> > > >  
> > > > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c
> > > > b/drivers/gpu/drm/xe/xe_pagefault.c
> > > > index 6828f81df50e..895866d639f8 100644
> > > > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > > > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > > > @@ -226,7 +226,7 @@ static int xe_pagefault_handle_vma(struct
> > > > xe_gt
> > > > *gt, struct xe_vma *vma,
> > > >  
> > > >  			if (bo) {
> > > >  				scoped_guard(spinlock, &vm->xe-
> > > > > ttm.lru_lock)
> > > > -
> > > > 					ttm_bo_move_to_lru_tail(&bo-
> > > > > ttm);
> > > > +					xe_bo_bump_lru_locked(bo
> > > > );
> > > >  			}
> > > >  		}
> > > >  		xe_validation_ctx_fini(&ctx);
> > > > diff --git a/drivers/gpu/drm/xe/xe_shrinker.c
> > > > b/drivers/gpu/drm/xe/xe_shrinker.c
> > > > index c86455ea08d1..64e5e684f591 100644
> > > > --- a/drivers/gpu/drm/xe/xe_shrinker.c
> > > > +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> > > > @@ -39,6 +39,8 @@
> > > >   * @shrink: Pointer to the mm shrinker handling non-purgeable
> > > > (shrinkable) objects.
> > > >   * @purge_shrink: Pointer to the mm shrinker handling purgeable
> > > > objects.
> > > >   * @pm_worker: Worker to wake up the device if required.
> > > > + * @min_age_ms: Minimum BO age before backup, in ms. 0 disables.
> > > > Defaults to
> > > > + * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, overridable through sysfs.
> > > >   */
> > > >  struct xe_shrinker {
> > > >  	struct xe_device *xe;
> > > > @@ -50,6 +52,7 @@ struct xe_shrinker {
> > > >  	struct shrinker *shrink;
> > > >  	struct shrinker *purge_shrink;
> > > >  	struct work_struct pm_worker;
> > > > +	unsigned int min_age_ms;
> > > >  };
> > > >  
> > > >  static struct xe_shrinker *to_xe_shrinker(struct shrinker
> > > > *shrink)
> > > > @@ -104,6 +107,7 @@ static void xe_shrinker_runtime_pm_put(struct
> > > > xe_shrinker *shrinker, bool runtim
> > > >  static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
> > > >  			      struct ttm_operation_ctx *ctx,
> > > >  			      const struct xe_bo_shrink_flags
> > > > flags,
> > > > +			      unsigned long min_age,
> > > >  			      unsigned long to_scan, unsigned
> > > > long
> > > > *scanned,
> > > >  			      unsigned long *freed)
> > > >  {
> > > > @@ -136,6 +140,16 @@ static int __xe_shrinker_walk(struct
> > > > xe_shrinker
> > > > *shrinker,
> > > >  			if (flags.purge && ttm_bo->priority >
> > > > XE_BO_PRIORITY_LOW)
> > > >  				break;
> > > >  
> > > > +			/*
> > > > +			 * Each LRU priority is roughly age
> > > > ordered,
> > > > so the
> > > > +			 * rest of this priority is most likely
> > > > young too.
> > > > +			 * Move on to the next priority.
> > > > +			 */
> > > > +			if (xe_bo_shrink_too_young(ttm_bo,
> > > > min_age))
> > > > {
> > > > +				ttm_bo_lru_cursor_skip_priority(
> > > > &cur
> > > > s);
> > > > +				continue;
> > > > +			}
> > > > +
> > > >  			if (!ttm_bo_shrink_suitable(ttm_bo,
> > > > ctx))
> > > >  				continue;
> > > >  
> > > > @@ -171,6 +185,7 @@ static int __xe_shrinker_walk(struct
> > > > xe_shrinker
> > > > *shrinker,
> > > >  static int xe_shrinker_walk(struct xe_shrinker *shrinker,
> > > >  			    struct ttm_operation_ctx *ctx,
> > > >  			    const struct xe_bo_shrink_flags
> > > > flags,
> > > > +			    unsigned long min_age,
> > > >  			    unsigned long to_scan, unsigned long
> > > > *scanned,
> > > >  			    unsigned long *freed)
> > > >  {
> > > > @@ -180,26 +195,126 @@ static int xe_shrinker_walk(struct
> > > > xe_shrinker
> > > > *shrinker,
> > > >  
> > > >  	swap(no_wait_gpu, ctx->no_wait_gpu);
> > > >  	save_flags.writeback = false;
> > > > -	ret = __xe_shrinker_walk(shrinker, ctx, save_flags,
> > > > to_scan,
> > > > scanned,
> > > > -				 freed);
> > > > +	ret = __xe_shrinker_walk(shrinker, ctx, save_flags,
> > > > min_age,
> > > > +				 to_scan, scanned, freed);
> > > >  	swap(no_wait_gpu, ctx->no_wait_gpu);
> > > >  	if (ret || *scanned >= to_scan)
> > > >  		return ret;
> > > >  
> > > >  	if (!ctx->no_wait_gpu) {
> > > > -		ret = __xe_shrinker_walk(shrinker, ctx,
> > > > save_flags,
> > > > to_scan, scanned,
> > > > -					 freed);
> > > > +		ret = __xe_shrinker_walk(shrinker, ctx,
> > > > save_flags,
> > > > min_age,
> > > > +					 to_scan, scanned,
> > > > freed);
> > > >  		if (ret || *scanned >= to_scan)
> > > >  			return ret;
> > > >  	}
> > > >  
> > > >  	if (flags.writeback)
> > > > -		ret = __xe_shrinker_walk(shrinker, ctx, flags,
> > > > to_scan, scanned,
> > > > -					 freed);
> > > > +		ret = __xe_shrinker_walk(shrinker, ctx, flags,
> > > > min_age,
> > > > +					 to_scan, scanned,
> > > > freed);
> > > >  
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +/**
> > > > + * DOC: Shrinker minimum age
> > > > + *
> > > > + * The per-device shrinker_min_age_ms sysfs attribute,
> > > > defaulting to
> > > > + * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, protects recently used BOs
> > > > from backup.
> > > > + * A BO's age is taken from whatever owns its position on the
> > > > LRU,
> > > > and is
> > > > + * stamped wherever that position is updated: the VM-wide stamp
> > > > for
> > > > a BO
> > > > + * riding along with a VM's bulk move, bumped on exec in
> > > > xe_vm_bump_lru(),
> > > > + * its own stamp otherwise, bumped there as well and on a move
> > > > into
> > > > TT in
> > > > + * xe_bo_move(). BOs in XE_PL_SYSTEM are never young: they are
> > > > not
> > > > GPU
> > > > + * mapped, so not part of a working set, and will be stamped
> > > > again
> > > > when
> > > > + * moved back to TT for use.
> > > > + *
> > > > + * The gate is applied per LRU priority, each of which is
> > > > roughly
> > > > age
> > > > + * ordered. xe_shrinker_count() snoops the first shrinkable BO
> > > > of
> > > > each
> > > > + * priority on each TT-backed LRU. Only if all of them are young
> > > > does it stop
> > > > + * reporting shrinkable pages; anything else, including reaching
> > > > no
> > > > verdict
> > > > + * at all, lets it report. The backup walk in xe_shrinker_scan()
> > > > skips to the
> > > > + * next priority at the first young BO, as a backstop since the
> > > > count snoop
> > > > + * is only a sample. A hot priority thus doesn't shield colder
> > > > BOs
> > > > in another
> > > > + * priority. BOs that aren't backed up anyway have no say either
> > > > way: those
> > > > + * in XE_PL_SYSTEM are never young, and purgeable and DONTNEED
> > > > ones,
> > > > which
> > > > + * belong to the purgeable shrinker, are ignored by the snoop
> > > > entirely.
> > > > + *
> > > > + * The gate is hard and applies at every reclaim priority. A
> > > > working
> > > > set kept
> > > > + * younger than the delay is never backed up, which can lead to
> > > > OOM.
> > > > This is
> > > > + * intended for users who prefer that risk over thrashing a hot
> > > > working set,
> > > > + * hence it is disabled by default.
> > > > + */
> > > > +static unsigned long xe_shrinker_min_age(struct xe_shrinker
> > > > *shrinker)
> > > > +{
> > > > +	unsigned int ms = READ_ONCE(shrinker->min_age_ms);
> > > > +
> > > > +	return ms ? msecs_to_jiffies(ms) : 0;
> > > > +}
> > > > +
> > > > +/* Max shrink-unsuitable BOs to skip per LRU before giving up
> > > > the
> > > > snoop. */
> > > > +#define XE_SHRINKER_SNOOP_MAX	16
> > > > +
> > > > +/*
> > > > + * Whether the first BO of every priority on every TT-backed LRU
> > > > that this
> > > > + * shrinker would back up is younger than @min_age. BOs are
> > > > trylocked through
> > > > + * the reserved LRU walker since their tt may be torn down while
> > > > still on the
> > > > + * LRU. Contended BOs are skipped by the walker, and may be all
> > > > of
> > > > them. If no
> > > > + * verdict can be reached, because nothing was inspected or the
> > > > snoop budget
> > > > + * ran out, report not young and leave it to the scan side
> > > > check.
> > > > + */
> > > > +static bool xe_shrinker_lru_young(struct xe_shrinker *shrinker,
> > > > +				  unsigned long min_age)
> > > > +{
> > > > +	struct ttm_operation_ctx ctx = {
> > > > +		.interruptible = false,
> > > > +		.no_wait_gpu = false,
> > > > +	};
> > > > +	struct xe_device *xe = shrinker->xe;
> > > > +	unsigned int mem_type;
> > > > +	bool young = false;
> > > > +
> > > > +	for (mem_type = XE_PL_SYSTEM; mem_type <= XE_PL_TT;
> > > > ++mem_type) {
> > > > +		struct ttm_resource_manager *man =
> > > > ttm_manager_type(&xe->ttm, mem_type);
> > > > +		struct ttm_bo_lru_cursor curs;
> > > > +		struct ttm_buffer_object *ttm_bo;
> > > > +		struct ttm_lru_walk_arg arg = {
> > > > +			.ctx = &ctx,
> > > > +			.trylock_only = true,
> > > > +		};
> > > > +		unsigned int budget = XE_SHRINKER_SNOOP_MAX;
> > > > +
> > > > +		if (!man || !man->use_tt)
> > > > +			continue;
> > > > +
> > > > +		ttm_bo_lru_for_each_reserved_guarded(&curs, man,
> > > > &arg, ttm_bo) {
> > > > +			/*
> > > > +			 * Nothing in the DONTNEED band is
> > > > backed
> > > > up, and it
> > > > +			 * is accounted to the purgeable
> > > > shrinker,
> > > > so it has
> > > > +			 * no say here. Skip the whole band in
> > > > one
> > > > go.
> > > > +			 */
> > > > +			if (ttm_bo->priority <=
> > > > XE_BO_PRIORITY_LOW)
> > > > {
> > > > +				ttm_bo_lru_cursor_skip_priority(
> > > > &cur
> > > > s);
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			if (!ttm_bo_shrink_suitable(ttm_bo,
> > > > &ctx) ||
> > > > +			   
> > > > !xe_bo_shrink_backup_candidate(ttm_bo))
> > > > {
> > > > +				if (!--budget)
> > > > +					return false;
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			if (!xe_bo_shrink_too_young(ttm_bo,
> > > > min_age))
> > > > +				return false;
> > > > +
> > > > +			young = true;
> > > > +			ttm_bo_lru_cursor_skip_priority(&curs);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return young;
> > > > +}
> > > > +
> > > >  static unsigned long
> > > >  xe_shrinker_count_purgeable(struct shrinker *shrink, struct
> > > > shrink_control *sc)
> > > >  {
> > > > @@ -239,7 +354,7 @@ static unsigned long
> > > >  xe_shrinker_count(struct shrinker *shrink, struct shrink_control
> > > > *sc)
> > > >  {
> > > >  	struct xe_shrinker *shrinker = to_xe_shrinker(shrink);
> > > > -	unsigned long num_pages;
> > > > +	unsigned long num_pages, min_age;
> > > >  	bool can_backup = !!(sc->gfp_mask & __GFP_FS);
> > > >  
> > > >  	if (!can_backup)
> > > > @@ -263,6 +378,10 @@ xe_shrinker_count(struct shrinker *shrink,
> > > > struct shrink_control *sc)
> > > >  
> > > >  	write_unlock(&shrinker->lock);
> > > >  
> > > > +	min_age = xe_shrinker_min_age(shrinker);
> > > > +	if (num_pages && min_age &&
> > > > xe_shrinker_lru_young(shrinker,
> > > > min_age))
> > > > +		return SHRINK_EMPTY;
> > > > +
> > > >  	return num_pages ? num_pages : SHRINK_EMPTY;
> > > >  }
> > > >  
> > > > @@ -297,7 +416,8 @@ static unsigned long
> > > > xe_shrinker_scan_purgeable(struct shrinker *shrink,
> > > >  		.purge = true,
> > > >  	};
> > > >  
> > > > -	xe_shrinker_walk(shrinker, &ctx, shrink_flags,
> > > > nr_to_scan,
> > > > &nr_scanned, &freed);
> > > > +	xe_shrinker_walk(shrinker, &ctx, shrink_flags, 0,
> > > > nr_to_scan, &nr_scanned,
> > > > +			 &freed);
> > > >  
> > > >  	sc->nr_scanned = nr_scanned;
> > > >  
> > > > @@ -322,7 +442,9 @@ static unsigned long xe_shrinker_scan(struct
> > > > shrinker *shrink, struct shrink_con
> > > >  	/* Might need runtime PM to access backed-up or CCS-
> > > > compressed data. */
> > > >  	runtime_pm = xe_shrinker_runtime_pm_get(shrinker);
> > > >  
> > > > -	xe_shrinker_walk(shrinker, &ctx, shrink_flags,
> > > > nr_to_scan,
> > > > &nr_scanned, &freed);
> > > > +	xe_shrinker_walk(shrinker, &ctx, shrink_flags,
> > > > +			 xe_shrinker_min_age(shrinker),
> > > > nr_to_scan,
> > > > &nr_scanned,
> > > > +			 &freed);
> > > >  
> > > >  	sc->nr_scanned = nr_scanned;
> > > >  	xe_shrinker_runtime_pm_put(shrinker, runtime_pm);
> > > > @@ -387,6 +509,29 @@ int
> > > > xe_shrinker_set_non_purgeable_seeks(struct
> > > > xe_shrinker *shrinker,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +/**
> > > > + * xe_shrinker_min_age_ms() - Get the shrinker minimum BO age
> > > > + * @shrinker: Pointer to the struct xe_shrinker.
> > > > + *
> > > > + * Return: Minimum age, in ms, a BO must reach before it may be
> > > > backed up.
> > > > + */
> > > > +unsigned int xe_shrinker_min_age_ms(struct xe_shrinker
> > > > *shrinker)
> > > > +{
> > > > +	return READ_ONCE(shrinker->min_age_ms);
> > > > +}
> > > > +
> > > > +/**
> > > > + * xe_shrinker_set_min_age_ms() - Set the shrinker minimum BO
> > > > age
> > > > + * @shrinker: Pointer to the struct xe_shrinker.
> > > > + * @ms: Minimum age, in ms. 0 disables the gate.
> > > > + *
> > > > + * See DOC: Shrinker minimum age. A non-zero value can lead to
> > > > OOM.
> > > > + */
> > > > +void xe_shrinker_set_min_age_ms(struct xe_shrinker *shrinker,
> > > > unsigned int ms)
> > > > +{
> > > > +	WRITE_ONCE(shrinker->min_age_ms, ms);
> > > > +}
> > > > +
> > > >  /**
> > > >   * xe_shrinker_create() - Create an xe per-device shrinker
> > > >   * @xe: Pointer to the xe device.
> > > > @@ -415,6 +560,7 @@ int xe_shrinker_create(struct xe_device *xe)
> > > >  
> > > >  	INIT_WORK(&shrinker->pm_worker, xe_shrinker_pm);
> > > >  	shrinker->xe = xe;
> > > > +	shrinker->min_age_ms =
> > > > CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS;
> > > >  	rwlock_init(&shrinker->lock);
> > > >  
> > > >  	shrinker->purge_shrink->count_objects =
> > > > xe_shrinker_count_purgeable;
> > > > diff --git a/drivers/gpu/drm/xe/xe_shrinker.h
> > > > b/drivers/gpu/drm/xe/xe_shrinker.h
> > > > index 4b3c73689619..586d7772bd58 100644
> > > > --- a/drivers/gpu/drm/xe/xe_shrinker.h
> > > > +++ b/drivers/gpu/drm/xe/xe_shrinker.h
> > > > @@ -18,4 +18,7 @@ int xe_shrinker_non_purgeable_seeks(struct
> > > > xe_shrinker *shrinker);
> > > >  int xe_shrinker_set_non_purgeable_seeks(struct xe_shrinker
> > > > *shrinker,
> > > >  					unsigned int seeks);
> > > >  
> > > > +unsigned int xe_shrinker_min_age_ms(struct xe_shrinker
> > > > *shrinker);
> > > > +void xe_shrinker_set_min_age_ms(struct xe_shrinker *shrinker,
> > > > unsigned int ms);
> > > > +
> > > >  #endif
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > > b/drivers/gpu/drm/xe/xe_vm.c
> > > > index 86c3b4fd232f..583c55b7f97d 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > @@ -463,13 +463,15 @@ void xe_vm_bump_lru(struct xe_vm *vm,
> > > > struct
> > > > drm_exec *exec)
> > > >  	spinlock_t *lru_lock = &vm->xe->ttm.lru_lock;
> > > >  	struct drm_gem_object *obj;
> > > >  
> > > > +	WRITE_ONCE(vm->lru_stamp, jiffies);
> > > > +
> > > >  	spin_lock(lru_lock);
> > > >  	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
> > > >  	drm_exec_for_each_locked_object(exec, obj) {
> > > >  		if (!drm_gpuvm_is_extobj(&vm->gpuvm, obj))
> > > >  			continue;
> > > >  
> > > > -		ttm_bo_move_to_lru_tail(&gem_to_xe_bo(obj)-
> > > > >ttm);
> > > > +		xe_bo_bump_lru_locked(gem_to_xe_bo(obj));
> > > >  		cond_resched_lock(lru_lock);
> > > >  	}
> > > >  	spin_unlock(lru_lock);
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm_types.h
> > > > b/drivers/gpu/drm/xe/xe_vm_types.h
> > > > index fb9305124679..046505a285e9 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm_types.h
> > > > +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> > > > @@ -267,6 +267,14 @@ struct xe_vm {
> > > >  	/** @lru_bulk_move: Bulk LRU move list for this VM's BOs
> > > > */
> > > >  	struct ttm_lru_bulk_move lru_bulk_move;
> > > >  
> > > > +	/**
> > > > +	 * @lru_stamp: jiffies at the last xe_vm_bump_lru(),
> > > > which
> > > > is where
> > > > +	 * @lru_bulk_move is moved to the LRU tail. Ages every
> > > > BO in
> > > > that
> > > > +	 * bulk move for the shrinker's minimum age gate.
> > > > Accessed
> > > > with
> > > > +	 * READ_ONCE()/WRITE_ONCE().
> > > > +	 */
> > > > +	unsigned long lru_stamp;
> > > 
> > > Isn't the bo resv / vm resv always held then this is accessed?
> > > 
> > 
> > xe_bo_shrink_too_young is the lockless read side.
> 
> Hm. To me it looks like all accesses have the bo resv held, eliminating
> the need for READ_ONCE() / WRITE_ONCE(), and xe_bo_shrink_too_young()
> also requires resv? 
> 

I think you are right, let me drop the READ_ONCE/WRITE_ONCE + add lock
annotations to xe_bo_shrink_too_young.

> Also another thing that came up is that during a pagefault, for a vm
> bo, the code timestamps the bo (which IMO is correct), but the shrinker
> reads the vm timestamp and never picks up the bo timestamp. I believe
> the shrinker should pick the younger of the two.
> 

In the case of page faults bo->bulk_move will be NULL so BO's timestamp
is always read.

Matt

> Thanks,
> Thomas
> 
> 
> > 
> > Matt
> >  
> > > Thanks,
> > > Thomas
> > > 
> > > 
> > > 
> > > > +
> > > >  	u64 size;
> > > >  
> > > >  	struct xe_pt *pt_root[XE_MAX_TILES_PER_DEVICE];
