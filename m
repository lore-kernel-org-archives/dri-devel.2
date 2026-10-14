Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6CFC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E69010EAB3;
	Wed, 14 Oct 2026 17:34:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F9D10EAB3;
 Wed, 14 Oct 2026 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791999287; x=1823535287;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=uGj8Nst/59TScKpGfagMXmar+MFbHQvoVoTiJJnWq0A=;
 b=NtxLe6PSLevHCahM4TSAA7EKAPM/ey7Dn/NBgxOWp4ED9Z2cC9yOa9Jm
 7swRwjNbTneVP7M+hHUMH12EBt5mdhXg04zxlPD2XTmt3VMVoQFL01gje
 o/QGftTbaW0UwxcgaVC6iy3H6pGUDeAcN57H9eMOUVQe3dyy/qMNtNVF/
 osjyX/PExiCUWRQpYxSX0FjIZNj91kfzMGCw6JDcF1/0Mr6ZMFBRXKVBa
 pMegewbRAQ1fX+aYlRhLBPuLrKRkhV+4Tqj0Khh6nDBwNRmK3k54dIgIZ
 qgogZuK2Wa6Ir2EKrHqMRF5xN294SSNiLkhMQkPjs+dU/jhcZYBhEl6tU g==;
X-CSE-ConnectionGUID: 2PBWMfQmQhSmg9eLpS2x/g==
X-CSE-MsgGUID: ZO0ugDT7R2OH0KkYXSjQww==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="742806"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="742806"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 10:34:46 -0700
X-CSE-ConnectionGUID: rtWebEFQRY6BplD4JAwsgg==
X-CSE-MsgGUID: 3DopomffQ5OdouEODznN/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1448545"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 10:34:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 10:34:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 10:34:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 10:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/ISm+4MXlp6Bvcnr1GgpznL3lYE78Ra1w6nCAUyAQGEnQe66OV6k/1QvC+kXVrBXyOGRvcbLbyNVgfxNlSJAN3Yf1+mrRmdfk6yGJoRxxOF8Zb5HgM8vMeu1rA7qXGSVYJdjXgiTDW1EeXGXmV9TQtzQ1Uu9ofLHfdNBniGqaFcQvDU50NVEKo3tAPf/ni0/SiA0yjFGjujRKkTbIPPtQu4xITQ366j8jXdB8mvwXJ1wyIyqknQsuhCyPKRkKT/qfMGbFB+5SNXYdPERqLr7szcW8XDX07Wjimg5KN52itV/sZm5CUb8127whaDWFBpdiuTNAyLa0g3iuetZZmkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJIgB1oiycgVB279C24by4AQ1diYbjEFd3CRc1VyaOc=;
 b=irt+SH60snhgNKdDwp/6HqoPruyiTTNExIbDloyPof1fYeqRGUpztj2SiuF5EVOB0XGY/VmiFFW1gkItPi9ywen3+5JgXKNuJmUXMnzJ5ZG6x4jkXbSvO6Y6NPFH5tnTfUy73PrfUiwtCzLP2oNCdVM/cEqN4LqUpioKVNoCuKEqdxS6rPYhFbhKnenynPGoDu1OLKQraItxAKPWENsqL9gLioReJ9VZSjnnPHRb1rpLFQz1GCA5UyygPpIMKwRo5qkhR/gNiKuPCQ8zlHy4gZFw6y4DzglMuqhFkhN8G/gLEQ5jUHa0lIuSQkkOcYgyWqlJ7xIVa5JYzUpLK/WdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 17:34:42 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:34:42 +0000
Date: Wed, 14 Oct 2026 10:34:40 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <matthew.brost@intel.com>
Subject: Re: [PATCH v2 0/6] drm: consolidate self-imported PRIME dma-buf
 detection
Message-ID: <as-9MFZcI9DR5HWI@nvishwa1-desk>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <d93fe93e-628c-4551-9907-9872c150e530@suse.de>
 <as54iEp-iqR0ZJWs@nvishwa1-desk>
 <6184d9de-0936-43ad-b9c9-496fc65212d9@suse.de>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6184d9de-0936-43ad-b9c9-496fc65212d9@suse.de>
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da38300-768e-4c56-d9ec-08df2a196e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|11063799006|261009223027099003|261009221227099003|10067099003|22082099003|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: Gs/CsmqnyXU8SIDdc5Tu9cFDsUApsjg4MojAn97rt1pDLN4dTdwU917zw/J7KwnXepF6gb5eHdB4njUlUarT45E/+9OJykbu82wUgrrtOPM9wgC7GGGmuFf7cvWUxzyn+nND/R+623DxNfDkGcYJzmofVTdRBH9rSQncOlWd1CTP72myv+VI8pJtD3Ab9+25CwgZpEms5OJKn+DSFHR0pBtt0iG+SBuaDRCQcQRAbNzu59kJHc/XdK7N9uSXm+T0KP3IOG2lYe8Ium2Eocrkn5Gn/BYTdA29oxCb93Gv2xQ5gV6wL0zFelmaHZdVtDX526ZJqzbZVVIuli5NoPXhUjco4R4z+X0LPGQoMwQ/JX3hGk27xKk41g+RdCF/nQ/zxJdFeCXvj/36R9PRvgA1iYsCHQue/7bSjdHDe1oByYKSqBgGzDROQmfNUgIewfw2VPVBY6IChOnhdNU7uCyUo3VjEY7Dhrb0jzSudtqRvP+4luRjq8S/wpSjIhWmpZULDUy20EzL59gN372m5P2/uYMygTYCyteGTVl22s2+x48MdIxtKkLIpcfc5tykHJekox1666jSgsLzpbBrt9pIBPshgBSGXx1LHDbfLUPIIFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(6133799003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jbAzBLWJgq4Ns7RERYODEskkxSGFZe5RHS+F3XkYBQeAL97OvCIOMY4xHf?=
 =?iso-8859-1?Q?b12APry8gIZ9kAXmVo7i6TOWxcPvrLBiPFSZA98yx58so2Fq3LihqB5qcE?=
 =?iso-8859-1?Q?xp8tcvV/Suyq59+ah1GYjEubpN6aP1r3gngduIWs771kDO37bifdkL1HzI?=
 =?iso-8859-1?Q?F0K+A3gRl6ncnwv+m1ErlwiaQU5oqZmrqXvexv/537yLSYdZzVQJWtknrw?=
 =?iso-8859-1?Q?FGn9B9+5WPveGEKonUN3MdC9GKbDJE4UrpAtQUcu96aaQMeJfw2Tq2oF14?=
 =?iso-8859-1?Q?ij8hFeF8xr95twbQvcyvMnxy6MCkG0wi+J2N1UufDqkdrYG5/ORU2YESaq?=
 =?iso-8859-1?Q?LEXkjN1O6UQH92gKbe1LM5qgJGeFsVLeOE8PMaFMYy49DbTznSsznmo7tH?=
 =?iso-8859-1?Q?Xj8PLDOBCSDgB6aJKNHb9+6g8ySdJgX7fXW9gv4j8ZCfkHur/zGE37WHCC?=
 =?iso-8859-1?Q?dimdviuO5fzM52xIFEvUuhrj8z0WjC4/zQsUBDvkzBWSD8TWd0YgCPPJqx?=
 =?iso-8859-1?Q?YUkMw3cA5Ufqru3t4u+LVpN/Q8vqeuRzoPhYMCG5g7fA5XhdbpYGqmuVCT?=
 =?iso-8859-1?Q?d1TCoThCYeLqJ1qXyuccngXUlT8bp04AuW2MCkqR+ZVkcueVP8/WFzSk7b?=
 =?iso-8859-1?Q?VWzVZ4qywSvlYLkwRWDZTze7VR6siL3IyaLHkYrA5aHmfHwaLVjvUzfWlX?=
 =?iso-8859-1?Q?bDolgz/mbc5Dw4xUzfx0Q4nQauw96F4w+DtOuTQV3cOA3TJO2iUFaH7kVK?=
 =?iso-8859-1?Q?YFKsnA61t0jAObbke8r9ottddZqOvqofKt0B3AHP4ioNGr7q++u9/Zts7l?=
 =?iso-8859-1?Q?VflYflAEFi2SsAmB55ckyXZe9Ful55JR62QjJ7OrRB/VKznlzkfSW7OH5N?=
 =?iso-8859-1?Q?YLfj18qMEWNxOTvBaaEIYdQhniIZ6Bz8wH+3Wx4wt+NpNbzTqsasVv1feu?=
 =?iso-8859-1?Q?/2f1hYtr2PFvkSD8caNvkXzD+ndrkT5BMZ86rC+2TyRWjivBI3E95layTR?=
 =?iso-8859-1?Q?zASx4d7S0YnTmE5dPWHzl7bkyCYP2TNmBJV9CnM4lghgYOE4snIbTzhWdi?=
 =?iso-8859-1?Q?KRi9j8+ks7jmgkR3DhcjocULcL8OIJJOwPBdYSqPmJKOXBy7WNkwhxg4HR?=
 =?iso-8859-1?Q?bGCnKX8ObEt5fbsKDYi9fEgBiHPGuhbPdawK/v0IUgv+fT9z3nHzSwqXB2?=
 =?iso-8859-1?Q?2nMy924lYLLhple8ey6TxVxyUFr+LYJJeXmjG8Zxy10tYhu7+R943Vl3Dm?=
 =?iso-8859-1?Q?LkyWnVF0ORD0XJpUdQUmFwstsfj20ctFbYjKNTqtaYW1N0u7oqSsza9FIl?=
 =?iso-8859-1?Q?04nTKijXFNhqrBQfSk7OWINQJ0BfZ65USy4XDeNGP9xGMbYiVbSTxQja3T?=
 =?iso-8859-1?Q?5YKtsIGf6XcudDdM6IlPZxv9vKtepOlBDCbBg82DnYDgj+txlPlXIhmGrN?=
 =?iso-8859-1?Q?gWodkcIqIUy8VEd/TyN/f4WvqU/J2S7v50b/l8zTHERYuqNqllTThOupSO?=
 =?iso-8859-1?Q?BYPPguMZLylSG1/tKoIGxlSBYKadCcc9lB2rWYXyvDfbMWQoLPtDukom13?=
 =?iso-8859-1?Q?e+ci2zsAJavud+lo1u8EXyqA0FSzlKyTOUU0BYZgTlcHEgbZNdmKg4XHbW?=
 =?iso-8859-1?Q?WrDOaUkWGQAyULF2yA6Fk5zlqBY7XSaIB3UW6YKTiXrGbCrEWcoRzW3lwc?=
 =?iso-8859-1?Q?qfYTahfxDteHE4U9aYCKIg1lI6MB57xZsZ0gm1je+tUwvOZh03ofDrmKNp?=
 =?iso-8859-1?Q?Mud2IclLS+jCAF8L/fZs47Xz9j7YTzUMQMu0MZ3n+IGatKgu7c87+VKPeO?=
 =?iso-8859-1?Q?n0tyY9sVSq5qb428GjfVdSTv5RwbZRo3EmrMFQzJPAmvdvtRUZYw?=
X-Exchange-RoutingPolicyChecked: Z6JWXqR0z57+ndXFQDkfCH/rYDEpMRXGF3p+aCjLQlUaFGmoS4BSalOLzlLdNY9Xlo2MFBPoYIrbLA9WzB5YcNlM0OitYuA5o7aKxDanczkBTyPV766g9GbYVjp5G5L5oWuX0Iqk5+29d1TzKs/9nyu37pl82y3E2if1D7MuSPwkFqp/iOBLNJgzX11zCMclOo2zMdH0tatKhpjy4gq959kBRQYtksnxw21hBMal/IV3SO0Nu+ECeOFQA3WabxWti8Qft/q2YSvoMZb9TTobQdsQ5ViQ4HixGjaXopv4t0djZRmX3XMF2Gg2dcGjtbZ11Hau4LI5WpCXs5vWRYes2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da38300-768e-4c56-d9ec-08df2a196e4f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:34:42.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epKAGbUHSOjJvKdAZpbDBQnzv4fBAfZPLKM+UPk2TDkdQ55oZsSKUW9jxGLv6rjwFM5Wmh/+6B7RoryHA2IUlarpZgFKPq0N+wmiVjSc/byZ54lZB06mEYdIEj1+IB8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
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

On Wed, Oct 14, 2026 at 09:31:00AM +0200, Thomas Zimmermann wrote:
>Hi
>
>Am 13.10.26 um 20:29 schrieb Niranjana Vishwanathapura:
>>On Tue, Oct 13, 2026 at 09:17:17AM +0200, Thomas Zimmermann wrote:
>>>Hi,
>>>
>>>I don't think we should merge this series.
>>>
>>>Testing for the functions struct is a hack, which we do because it 
>>>works in practice. We don't any other good identifier for the 
>>>source of the imported dma_buf. We want to hide this from the 
>>>outside world as much as possible. Putting it into an exported 
>>>interface goes in the wrong direction.
>>>
>>
>>Ok, I understand. Given it is just a utility function that is helpful
>>across drivers, would defining drm_gem_prime_self_import() as a static
>>inline helper in drm_prime.h is permissible?
>
>It's not about the EXPORT_SYMBOL. Please see my reply to Matthew for 
>details.
>
>I think it would be OK to do something like this in the header file:
>
>static inline bool __drm_gem_is_exported_dma_buf(dev, ops, dma_buf)
>{
>    /* do the prime test here, but with the given ops. */
>}
>
>Double-underscore prefix in symbols means 'implementation detail'. The 
>existing drm_gem_is_prime_exported_dma_buf() can be implemented on 
>top; existing callers should continue to use 
>drm_gem_prime_eported_dma_buf().  Other drivers can use the new helper 
>for the test, as they use the same logic internally.
>

drm_gem_is_prime_exported_dma_buf() do not take object reference.
The code duplicated in multliple drivers take object reference. So, we
need the helper routine to take object reference.

Niranjana

>Best regards
>Thomas
>
>
>>
>>Niranjana
>>
>>>Best regards
>>>Thomas
>>>
>>>
>>>Am 13.10.26 um 03:06 schrieb Niranjana Vishwanathapura:
>>>>Detecting that a PRIME dma-buf being imported was exported by the same
>>>>DRM device is a pattern currently open-coded in many drivers (compare
>>>>dma_buf->ops against the driver's own ops, check obj->dev == dev, then
>>>>return the GEM object with an extra reference). This series adds 
>>>>generic
>>>>helpers for it and converts several drivers to use them.
>>>>
>>>>Patch 1 adds drm_gem_prime_self_import(dev, dma_buf, ops): for a 
>>>>dma-buf
>>>>self-exported via the given ops, it returns the backing GEM object with
>>>>a reference, letting a driver short-circuit the generic PRIME 
>>>>import and
>>>>skip the extra dma-buf file reference. Patch 2 converts Xe to it.
>>>>
>>>>Patch 3 adds drm_gem_prime_dma_buf_to_gem(), a thin wrapper that 
>>>>uses the
>>>>core PRIME ops, and replaces the 
>>>>drm_gem_is_prime_exported_dma_buf() bool
>>>>predicate with it so the shmem importer resolves the object directly
>>>>(the sole caller already wanted the referenced object).
>>>>
>>>>Patches 4-6 convert panthor, panfrost and amdgpu to
>>>>drm_gem_prime_self_import(), removing the duplicated open-coded checks.
>>>>
>>>>No intended functional change.
>>>>
>>>>Assisted-by: GitHub-Copilot:claude-opus-4.8
>>>>Signed-off-by: Niranjana Vishwanathapura 
>>>><niranjana.vishwanathapura@intel.com>
>>>>
>>>>Farah Kassabri (2):
>>>>  drm/gem: add helper to detect self-imported PRIME dma-bufs
>>>>  drm/xe/dma-buf: Use drm helper to detect dma-buf self-import
>>>>
>>>>Niranjana Vishwanathapura (4):
>>>>  drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper
>>>>  drm/panthor: use drm_gem_prime_self_import() helper
>>>>  drm/panfrost: use drm_gem_prime_self_import() helper
>>>>  drm/amdgpu: use drm_gem_prime_self_import() helper
>>>>
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +---
>>>> drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 ++--
>>>> drivers/gpu/drm/drm_prime.c                 | 74 +++++++++++++++------
>>>> drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 +--
>>>> drivers/gpu/drm/panthor/panthor_gem.c       | 10 +--
>>>> drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++---
>>>> drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
>>>> include/drm/drm_prime.h                     |  8 ++-
>>>> 8 files changed, 91 insertions(+), 64 deletions(-)
>>>>
>>>
>>>-- 
>>>-- 
>>>Thomas Zimmermann
>>>Graphics Driver Developer
>>>SUSE Software Solutions Germany GmbH
>>>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>>
>>>
>
>-- 
>--
>Thomas Zimmermann
>Graphics Driver Developer
>SUSE Software Solutions Germany GmbH
>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>
>
