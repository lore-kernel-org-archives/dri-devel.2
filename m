Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BE606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ceUlrJPL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131C10EE77;
	Wed, 11 Nov 2026 07:36:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0268610E55B;
 Wed, 11 Nov 2026 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794382600; x=1825918600;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=y2m7M7MPGgOHpjMlc4yU1URcb3lesDZ9GuOz7GE9Vog=;
 b=ceUlrJPLy7UXwPoKMZ8Q9Gql0MGkt9pmxkkRGp1L8ibzjMMEhoAk5ZqA
 1puTwIP3NTNe7KU7GNDuJn+9eR2m3FND8GDhI1sCvKFGCFmB0i9rjRgZ5
 DQBWTMlW+9lFXIp5NQwwcc0KMsk9VWZwfNwL5s+30H+aZZKgFNaHLO2F3
 zBym/jbNjgkOUs+Xa3n8x5zdwWkmKGdGQgxo9EZlpKCvcShP7jAxjcbtM
 BSDDAealILR9x6FgI6eiD56Mu5SQUE3iv3eFqnpQLMYZfb8JlFKFlGjVn
 jluEqojdc0CDamCZkDwoXpOQFqceb+zasPCm0k2eBcemsqrIzFTWCqDjf w==;
X-CSE-ConnectionGUID: cshdvmTJRgKz7+4ceMDpzA==
X-CSE-MsgGUID: h/9Ib6/MTzigYSrwTdW8eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3031432"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3031432"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 23:36:39 -0800
X-CSE-ConnectionGUID: x6uxAYk1RP65HHQrmxty6A==
X-CSE-MsgGUID: PaF7vHfhRPSEUGH9L5LAEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8688708"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 23:36:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:36:38 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 23:36:38 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:36:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC1CwSKpnKHV2OuVJfI1okdPSE58rOug8TW+UvBAHzCEns+SOLPQn8AOo/DCHaoI01vHa4/P+Kd9APFcfRqC+YanBWcngLiALOYeDkVlzVAy79SLMelkbgtRIDw4dkrGjaYGzm2vDppKN7KX9DeLooR+klzbfTWuu+8gKqZQkcWoSPiWqXt5Fj6HT75uBPO383rPi9TlEMflhVHZDTUbw6OxQUaGH8mdjt6h9qWJIx1Iozdxo4cBvCVROmyTeHZFffBKVE7oE+l/yfFTJJpdiSET3sk8d8rfO4BE0lrwTUSLFkU9YvClE01xCFUXWfslW1rwD8X2M8eIXRNu3m+1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNElsgpHOXja1g4bvLwsZQZf/ABVo4xBW7aCFWzm1rE=;
 b=w/hujwQrKB/15azhoWMMg19sDP8ota7gkguBV1YH1UGwz6tYjpAHLecGoQLoMiZD1OyNDqZuGcML5eWXOGmvOndvwTOHWmFu48nSX63SYTivKmK+T7nvnPMS95DZmG5J8OHb3RW4Vw7P+/SzwhOP06oxyJdun9RtDwjFTTGGdz4tPmzOSsJFtbS1zUigoKxCy/KEq8bgU58BYucqHuYqQyfP3AtyJN3RlmvNyniR7sWZXGDgGjcewTGCcR+vworoM/4ZMXdbhpq+iB2L2II3Ky7g5aEJ8cIbOcPPcIbP8eAlpLB7kMSU1fUgABKGJaPaS/piS2T6nsX1TRTquUWA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 07:36:26 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 07:36:26 +0000
Date: Tue, 10 Nov 2026 23:36:24 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 25/33] drm/xe: Preallocate system BO backing outside
 the dma-resv lock
Message-ID: <avQa-BlJQMKkoI4k@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-26-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-26-matthew.brost@intel.com>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ecd933-6077-469e-b500-08df3fc67e34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261102124527099003|261009221227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ltdxS1SeP5gsWy5nIgpaQyPVkSSy+GjEsVMfmcF8zuMasdTCkxGpWwJNQwOdbEMpZXBQlaB8nXxqxqWiUGxFConkwUaBAOegP/mIzHzGDtMwyfeyzD/mbGzkp0GVebXQwL14TE9pzmwwDU6LVH1pXZw/9OF9VcEPAOgvRPgkkOJxsjocyZTszd3JsZ6Ci+R+7Ku/HEAl5vqFU/gONmpYho40xbaFORWpTtOutH/K97775aMT5XsAhRvQ2cco+QJtqZFemyBTVfucef3qM+CHY2o80Om04KC1EqzoOtWnx60bs3rpRVIRXHNFjd2CjcOO6cg1CROJo9t2NRt6qSp3L5zSyiaz5bDlYYMxyi8oCP6+KSWbDOH4oSp54+CbdxM5PbNSBuLfj+xJiBZRfSUbImd8JnoYoONBU75KvSPV3Y1KAL7iKxCt9+wCnJ+je6ShwHDeHGI7lwQeqLZl+fJehPV1aUoWSdbq67I4l4m5A2evsl6+dfkAMrKPLo0jcpCEg/F5bZ7z+/8dvhXplZeROKsDua62c8pqpPpLE9Ii+9TRsuuJHih2C8dIFNQna48ikIp59ck4yALbQaL58s2X4fjrHkHmaamobZu2ypSYmCiRuEiJU4NqGNp1pvXzyAeBDq4XDMxjBHpkrBwlETvREyjmnhXmvZ779WKMw4Are3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261102124527099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DRap5XsCT67wt3mxqKMVBWiH3UUr2s+0rvAYP0kyXhiYHqhFECNy7VlbMa?=
 =?iso-8859-1?Q?s2+nFSNOk0u+UpzV5JQEJiiU1MG/ldAoBkiL8o3/uqjSTJfh1fRrcwyQlK?=
 =?iso-8859-1?Q?ob81mx7kAB+VXpOfYVBKLLUsY6jJec45UNRES/JPtWXk25fKS2QCXH5Hxr?=
 =?iso-8859-1?Q?WaNmRXiu7jxkAva8H7a3BhZHgRFlvpLJxMqbWOFjqblQ89VizPvtu73iGg?=
 =?iso-8859-1?Q?ozMIiL51NrwuOyzSFeCMhN1w5Kjqt8TZya5fxv3K8HFaltzEtyBii1fzsE?=
 =?iso-8859-1?Q?Q4I6jbQkB1/Q5mFowT7+/IgkUxWSjpAhpREePad9uaESe2EYfAuBw0x3L0?=
 =?iso-8859-1?Q?QYPZ0MvGHXVbvb1dPMXgqqv1pcfv6lURv5tdl4wvme4ahfRlf5XKdA5SgM?=
 =?iso-8859-1?Q?qByl7uo2/N2440v79XdIkysOkVpoxKokJAdHasKVapQ2A/pEIgFM6CcKS3?=
 =?iso-8859-1?Q?gDFWBPq5/GubS4IrDrRniLWUVUbTn2CVs+8Y9orvM11GoA5L/xN4TkliHz?=
 =?iso-8859-1?Q?UjAeQZpAKsgy53YPESn7ii7HiWmoiGhEwvCooUiWSBA4h37yRaI8dMu5Jv?=
 =?iso-8859-1?Q?j1uuRTVLTQwgjAIOS/4wzVkyMPQY3MYDkAeu/kFiDSXyUVzKJ1KWb2L0ol?=
 =?iso-8859-1?Q?yUNyrtoqJf38yg4iu7vQ+q45003fOXqxolVspL4Ir9jR4uTlS1QwTL+kdv?=
 =?iso-8859-1?Q?uZeM3+PPxKP5gGbC8VKLdC19/I6Aj49MKhPCdouCCQMZPpZCO8B1kXsz+P?=
 =?iso-8859-1?Q?yVRsRTTD/lD+4TfJklmc95ORtHTFs1tg0JuryKJM2k5i/KyT1Vp8aT6VKZ?=
 =?iso-8859-1?Q?LgZZWm0e54SAK4cEaLPhZIAleeQtKEsZPYeJes4gQKu4Tck94paUgwx9lu?=
 =?iso-8859-1?Q?awqMt6KuYjBX0Nr8Mh8zj/ahiz+EeklzsoXG3W9HgsMMSFiyKDU4Vw8reZ?=
 =?iso-8859-1?Q?ehgWbJ59vhUnT6EyxKOqLJUgi9h3W9Au+XAKWn5uorJRm5S/Xrx7ZHEwJc?=
 =?iso-8859-1?Q?rA7WTNq7RQlQVbCm8swey5TFGWe9ZhrUJ9OmQP5UMU0Y4QFzoNeGGTEJTL?=
 =?iso-8859-1?Q?7J0TWPANP2TT3CbInB8/wywVu2r1M8nAZiCpEPNf2igYS1NoPg0eBpBkdf?=
 =?iso-8859-1?Q?ihkIK0WN7446lXJ7Ot55M7cnvFqNS6xBqLsJJvurE2Q/EjgVM6WxVw0xa/?=
 =?iso-8859-1?Q?4OZocPa4iSFUfOoI9t+uU3qLkAorAQD4+uQ+z4RZotM0zblUTV/wxYb71K?=
 =?iso-8859-1?Q?ArH8kJmEA+7Ok7+JrFh/ROKBE4jayo2HK8f8nSXQGHz2GM93HZk6hjyxM2?=
 =?iso-8859-1?Q?I72sjsJLHNypfpbb+RROvows9HMbQwwN64V/4CDfh6E7rx9GWwky0N8HZj?=
 =?iso-8859-1?Q?nMex1PpHQOOlZQTObYp0XJZHTkVATYLqtVX1QdSaPChrgz08/w4r9vEYZW?=
 =?iso-8859-1?Q?697/HOjh/A6ALF+SMHDK6ErQz6g03gi5H6k3XV/45xVNS0UAzBwjWMlFLY?=
 =?iso-8859-1?Q?/H+aqSwP2Hlo4sLPlbIXoAMww9D5aPjD+2/AQ5/KtwncGor9xemIFXh6Yn?=
 =?iso-8859-1?Q?uej9cnGUh6bGePCtQVrm/hP6WAbZHUIuJxXVKO4yqUCGmcmoKppNmOC2cc?=
 =?iso-8859-1?Q?E1RzvWdZ4i16FhdeQZrt0rqJWVJiSQfXtbteeWqXB+bLBuvh3VnFD0czzg?=
 =?iso-8859-1?Q?ut7ktpCHqFNLdYHx9jpVUfnk8rcC5XQhYZvAUejAtPLwKItqn7sPaUMS/Q?=
 =?iso-8859-1?Q?Kgnu8y6HnEGGiLQR5lI601muXsgWdcsctR7NngEkjAgHqQGNE8fezwrzk3?=
 =?iso-8859-1?Q?FfBtvPgNr16UawIP9LYP3baZHrw0MW5R+Oya2pG9iH5I+QVHvgSz?=
X-Exchange-RoutingPolicyChecked: UD8sEln9LxYZI+QhIB68Mo3zVjbiUKDG4Sjc7YzcUK+zBrRiarOoue5RmHLWJdZQZH2urMwZTr1xABJ20yOTHjmjCCcweyWM01LYj2qGCD9bqOLz5a2vJ20ufS2elAYXHiIYt54t009c2BAog49lto5eZCBL4rg7ZMYS4vjyyC0oAUWmy9/IWa8vTgmL3VYeRS7M1S3InXcWWu3OmEplCwTqI/zhoUUEFSdLf6NgQG1IXomf+SZyG5JoMofIpoMHopcnY2b2O2gCyxNrxdCX1WKPGxmIUKYfTIhYNuPs8ameXuhQUdw5RAq/nyLuxQtbx8G8LL+jpYkf2xdLhO87HQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ecd933-6077-469e-b500-08df3fc67e34
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:36:26.4994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bSZXlEr22eaCvupKSiv06vWKOX2lIb4vuze0M7sYguupKinyaO3vTazXuDa5sdb0BltKoWKjyQ/PY4FePcasbsH2tS6cIImIoFiQlm6ze2xZJ6sN/KKzNUAeGo+FWVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
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

On Fri, Jul 10, 2026 at 07:56:11PM -0700, Matthew Brost wrote:
>xe_gem_create_ioctl() populates a buffer object's backing store inside
>xe_validation_guard(), i.e. under the dma-resv lock.  For a system-memory
>buffer that means the whole page allocation - potentially stalling in
>reclaim or compaction - happens in the critical section, holding the
>reservation and blocking anything that contends on it.
>
>Use the TTM full-preallocation mechanism to move that work out of the
>lock.  For a system-only, non-deferred user BO, allocate the entire tt
>backing up front, before entering the validation guard, and hand the bag
>down to the populate so it merely installs the pages:
>
>  - Thread an optional struct ttm_pool_prealloc through xe_bo_create_user()
>    -> __xe_bo_create_locked() -> xe_bo_init_locked(), which stashes it in
>    ttm_operation_ctx::prealloc.  All other callers pass NULL.
>
>  - In xe_gem_create_ioctl(), for XE_BO_FLAG_SYSTEM BOs that are not VRAM,
>    stolen or deferred-backing, call ttm_pool_prealloc_fill_full() before
>    the guard and ttm_pool_prealloc_fini() after it.  The bag size covers
>    both the data pages and the appended CCS backup pages, matching the tt
>    layout in xe_ttm_tt_create(), and the caching mirrors the same path.
>
>The fill is best-effort: on a short fill (or if it is skipped) the pool
>allocates the remainder in-line as before, so this is purely an
>optimisation with no behavioural change to the created BO.  fini() only
>releases the unconsumed tail, so it is safe on every success, error and
>OOM-retry path (consumed pages are owned by the tt).
>
>The fill requests reclaim backoff for higher-order chunks
>(@beneficial_reclaim_backoff): Xe runs a background defragmenter that
>upgrades suboptimal pages to beneficial order in place, so there is no
>need to stall this user context reclaiming/compacting for contiguity.
>
>To size the preallocation before the xe_bo exists, factor the CCS-pages
>decision in xe_bo_needs_ccs_pages() into a parameterised helper,
>__xe_bo_needs_ccs_pages(), and query it directly from the ioctl.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>
>---
>
>v3:
> - Preallocate only when the backing fits the available TT space
>   (Sashiko)
>---
> drivers/gpu/drm/xe/tests/xe_bo.c      |   8 +-
> drivers/gpu/drm/xe/tests/xe_dma_buf.c |   2 +-
> drivers/gpu/drm/xe/tests/xe_migrate.c |   6 +-
> drivers/gpu/drm/xe/xe_bo.c            | 139 +++++++++++++++++++++-----
> drivers/gpu/drm/xe/xe_bo.h            |   8 +-
> drivers/gpu/drm/xe/xe_dma_buf.c       |   2 +-
> 6 files changed, 128 insertions(+), 37 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
>index 49c95ed67d7e..78781317b420 100644
>--- a/drivers/gpu/drm/xe/tests/xe_bo.c
>+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
>@@ -141,7 +141,7 @@ static void ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
> 		kunit_info(test, "Testing system memory\n");
>
> 	bo = xe_bo_create_user(xe, NULL, SZ_1M, DRM_XE_GEM_CPU_CACHING_WC,
>-			       bo_flags, exec);
>+			       bo_flags, NULL, exec);
> 	if (IS_ERR(bo)) {
> 		KUNIT_FAIL(test, "Failed to create bo.\n");
> 		return;
>@@ -220,7 +220,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
> 		xe_vm_lock(vm, false);
> 		bo = xe_bo_create_user(xe, vm, 0x10000,
> 				       DRM_XE_GEM_CPU_CACHING_WC,
>-				       bo_flags, exec);
>+				       bo_flags, NULL, exec);
> 		xe_vm_unlock(vm);
> 		if (IS_ERR(bo)) {
> 			KUNIT_FAIL(test, "bo create err=%pe\n", bo);
>@@ -229,7 +229,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
>
> 		external = xe_bo_create_user(xe, NULL, 0x10000,
> 					     DRM_XE_GEM_CPU_CACHING_WC,
>-					     bo_flags, NULL);
>+					     bo_flags, NULL, NULL);
> 		if (IS_ERR(external)) {
> 			KUNIT_FAIL(test, "external bo create err=%pe\n", external);
> 			goto cleanup_bo;
>@@ -494,7 +494,7 @@ static int shrink_test_run_device(struct xe_device *xe)
> 		/* We can create bos using WC caching here. But it is slower. */
> 		bo = xe_bo_create_user(xe, NULL, XE_BO_SHRINK_SIZE,
> 				       DRM_XE_GEM_CPU_CACHING_WB,
>-				       XE_BO_FLAG_SYSTEM, NULL);
>+				       XE_BO_FLAG_SYSTEM, NULL, NULL);
> 		if (IS_ERR(bo)) {
> 			if (bo != ERR_PTR(-ENOMEM) && bo != ERR_PTR(-ENOSPC) &&
> 			    bo != ERR_PTR(-EINTR) && bo != ERR_PTR(-ERESTARTSYS))
>diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
>index 0be8440b3976..e4fdc247c0c7 100644
>--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
>+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
>@@ -127,7 +127,7 @@ static void xe_test_dmabuf_import_same_driver(struct xe_device *xe)
>
> 	kunit_info(test, "running %s\n", __func__);
> 	bo = xe_bo_create_user(xe, NULL, size, DRM_XE_GEM_CPU_CACHING_WC,
>-			       params->mem_mask, NULL);
>+			       params->mem_mask, NULL, NULL);
> 	if (IS_ERR(bo)) {
> 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
> 			   PTR_ERR(bo));
>diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
>index 3c1be809be82..41de648b2c86 100644
>--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
>@@ -647,7 +647,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
> 				   DRM_XE_GEM_CPU_CACHING_WC,
> 				   XE_BO_FLAG_SYSTEM |
> 				   XE_BO_FLAG_NEEDS_CPU_ACCESS |
>-				   XE_BO_FLAG_PINNED, NULL);
>+				   XE_BO_FLAG_PINNED, NULL, NULL);
>
> 	if (IS_ERR(sys_bo)) {
> 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
>@@ -673,7 +673,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
> 	ccs_bo = xe_bo_create_user(xe, NULL, SZ_4M,
> 				   DRM_XE_GEM_CPU_CACHING_WC,
> 				   bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
>-				   XE_BO_FLAG_PINNED, NULL);
>+				   XE_BO_FLAG_PINNED, NULL, NULL);
>
> 	if (IS_ERR(ccs_bo)) {
> 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
>@@ -698,7 +698,7 @@ static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *til
> 	vram_bo = xe_bo_create_user(xe, NULL, SZ_4M,
> 				    DRM_XE_GEM_CPU_CACHING_WC,
> 				    bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS |
>-				    XE_BO_FLAG_PINNED, NULL);
>+				    XE_BO_FLAG_PINNED, NULL, NULL);
> 	if (IS_ERR(vram_bo)) {
> 		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
> 			   PTR_ERR(vram_bo));
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 25e5b72f870c..a646a72122d4 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -1948,7 +1948,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
> 		backup = xe_bo_init_locked(xe, NULL, NULL, bo->ttm.base.resv, NULL, xe_bo_size(bo),
> 					   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
> 					   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
>-					   XE_BO_FLAG_PINNED, &exec);
>+					   XE_BO_FLAG_PINNED, NULL, &exec);
> 		if (IS_ERR(backup)) {
> 			drm_exec_retry_on_contention(&exec);
> 			ret = PTR_ERR(backup);
>@@ -2089,7 +2089,7 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
> 						   xe_bo_size(bo),
> 						   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
> 						   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
>-						   XE_BO_FLAG_PINNED, &exec);
>+						   XE_BO_FLAG_PINNED, NULL, &exec);
> 			if (IS_ERR(backup)) {
> 				drm_exec_retry_on_contention(&exec);
> 				ret = PTR_ERR(backup);
>@@ -2884,6 +2884,8 @@ void xe_bo_free(struct xe_bo *bo)
>  * @cpu_caching: The cpu caching used for system memory backing store.
>  * @type: The TTM buffer object type.
>  * @flags: XE_BO_FLAG_ flags.
>+ * @prealloc: Optional pages preallocated outside the dma-resv lock to back the
>+ * bo (see ttm_operation_ctx::prealloc), or NULL.
>  * @exec: The drm_exec transaction to use for exhaustive eviction.
>  *
>  * Initialize or create an xe buffer object. On failure, any allocated buffer
>@@ -2895,12 +2897,14 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
> 				struct xe_tile *tile, struct dma_resv *resv,
> 				struct ttm_lru_bulk_move *bulk, size_t size,
> 				u16 cpu_caching, enum ttm_bo_type type,
>-				u32 flags, struct drm_exec *exec)
>+				u32 flags, struct ttm_pool_prealloc *prealloc,
>+				struct drm_exec *exec)
> {
> 	struct ttm_operation_ctx ctx = {
> 		.interruptible = true,
> 		.no_wait_gpu = false,
> 		.gfp_retry_mayfail = true,
>+		.prealloc = prealloc,
> 	};
> 	struct ttm_placement *placement;
> 	uint32_t alignment;
>@@ -3077,7 +3081,8 @@ __xe_bo_create_locked(struct xe_device *xe,
> 		      struct xe_tile *tile, struct xe_vm *vm,
> 		      size_t size, u64 start, u64 end,
> 		      u16 cpu_caching, enum ttm_bo_type type, u32 flags,
>-		      u64 alignment, struct drm_exec *exec)
>+		      u64 alignment, struct ttm_pool_prealloc *prealloc,
>+		      struct drm_exec *exec)
> {
> 	struct xe_bo *bo = NULL;
> 	int err;
>@@ -3102,7 +3107,7 @@ __xe_bo_create_locked(struct xe_device *xe,
> 			       vm && !xe_vm_in_fault_mode(vm) &&
> 			       flags & XE_BO_FLAG_USER ?
> 			       &vm->lru_bulk_move : NULL, size,
>-			       cpu_caching, type, flags, exec);
>+			       cpu_caching, type, flags, prealloc, exec);
> 	if (IS_ERR(bo))
> 		return bo;
>
>@@ -3177,7 +3182,7 @@ struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
> 				  struct drm_exec *exec)
> {
> 	return __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL, 0, type,
>-				     flags, 0, exec);
>+				     flags, 0, NULL, exec);
> }
>
> static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *tile,
>@@ -3193,7 +3198,7 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
> 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = intr},
> 			    ret) {
> 		bo = __xe_bo_create_locked(xe, tile, NULL, size, 0, ~0ULL,
>-					   cpu_caching, type, flags, alignment, &exec);
>+					   cpu_caching, type, flags, alignment, NULL, &exec);
> 		drm_exec_retry_on_contention(&exec);
> 		if (IS_ERR(bo)) {
> 			ret = PTR_ERR(bo);
>@@ -3213,6 +3218,9 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
>  * @size: The storage size to use for the bo.
>  * @cpu_caching: The caching mode to be used for system backing store.
>  * @flags: XE_BO_FLAG_ flags.
>+ * @prealloc: Optional pages preallocated outside the dma-resv lock to back the
>+ * bo (see ttm_operation_ctx::prealloc), or NULL. Only consumed on the locked
>+ * (@vm or @exec) path.
>  * @exec: The drm_exec transaction to use for exhaustive eviction, or NULL
>  * if such a transaction should be initiated by the call.
>  *
>@@ -3223,7 +3231,8 @@ static struct xe_bo *xe_bo_create_novm(struct xe_device *xe, struct xe_tile *til
> struct xe_bo *xe_bo_create_user(struct xe_device *xe,
> 				struct xe_vm *vm, size_t size,
> 				u16 cpu_caching,
>-				u32 flags, struct drm_exec *exec)
>+				u32 flags, struct ttm_pool_prealloc *prealloc,
>+				struct drm_exec *exec)
> {
> 	struct xe_bo *bo;
>
>@@ -3233,7 +3242,7 @@ struct xe_bo *xe_bo_create_user(struct xe_device *xe,
> 		xe_assert(xe, exec);
> 		bo = __xe_bo_create_locked(xe, NULL, vm, size, 0, ~0ULL,
> 					   cpu_caching, ttm_bo_type_device,
>-					   flags, 0, exec);
>+					   flags, 0, prealloc, exec);
> 		if (!IS_ERR(bo))
> 			xe_bo_unlock_vm_held(bo);
> 	} else {
>@@ -3272,7 +3281,7 @@ struct xe_bo *xe_bo_create_pin_range_novm(struct xe_device *xe, struct xe_tile *
>
> 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
> 		bo = __xe_bo_create_locked(xe, tile, NULL, size, start, end,
>-					   0, type, flags, 0, &exec);
>+					   0, type, flags, 0, NULL, &exec);
> 		if (IS_ERR(bo)) {
> 			drm_exec_retry_on_contention(&exec);
> 			err = PTR_ERR(bo);
>@@ -3311,7 +3320,7 @@ static struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
>
> 	bo = __xe_bo_create_locked(xe, tile, vm, size, start, end, 0, type,
> 				   flags | XE_BO_FLAG_NEEDS_CPU_ACCESS | XE_BO_FLAG_PINNED,
>-				   alignment, exec);
>+				   alignment, NULL, exec);
> 	if (IS_ERR(bo))
> 		return bo;
>
>@@ -3926,6 +3935,10 @@ static int gem_create_user_extensions(struct xe_device *xe, struct xe_bo *bo,
> 	return 0;
> }
>
>+static bool __xe_bo_needs_ccs_pages(struct xe_device *xe,
>+				    enum ttm_bo_type type, u32 flags,
>+				    u16 cpu_caching);
>+
> int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 			struct drm_file *file)
> {
>@@ -3936,6 +3949,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 	struct drm_exec exec;
> 	struct xe_vm *vm = NULL;
> 	struct xe_bo *bo;
>+	struct ttm_pool_prealloc prealloc = {};
>+	bool have_prealloc = false;
> 	unsigned int bo_flags;
> 	u32 handle;
> 	int err;
>@@ -4018,6 +4033,64 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 			return -ENOENT;
> 	}
>
>+	/*
>+	 * For system-only BOs, preallocate the whole backing outside the
>+	 * dma-resv lock so the populate under the validation guard does not
>+	 * stall in reclaim/compaction. The caching mirrors the system-BO path
>+	 * in xe_ttm_tt_create(); the pool falls back to in-line allocation for
>+	 * any shortfall, so a failed fill is harmless.
>+	 */
>+	if ((bo_flags & XE_BO_FLAG_SYSTEM) &&
>+	    !(bo_flags & (XE_BO_FLAG_DEFER_BACKING | XE_BO_FLAG_VRAM_MASK |
>+			  XE_BO_FLAG_STOLEN))) {
>+		struct ttm_resource_manager *tt_man =
>+			ttm_manager_type(&xe->ttm, XE_PL_TT);
>+		enum ttm_caching caching = ttm_cached;
>+		unsigned long num_pages = args->size >> PAGE_SHIFT;
>+
>+		if (!IS_DGFX(xe) &&
>+		    args->cpu_caching == DRM_XE_GEM_CPU_CACHING_WC)
>+			caching = ttm_write_combined;
>+
>+		/*
>+		 * Cover the CCS backup pages appended to the tt (see
>+		 * xe_ttm_tt_create()) so the whole tt is preallocated.
>+		 */
>+		if (__xe_bo_needs_ccs_pages(xe, ttm_bo_type_device, bo_flags,
>+					    args->cpu_caching))
>+			num_pages += DIV_ROUND_UP(xe_device_ccs_bytes(xe,
>+								      args->size),
>+						  PAGE_SIZE);
>+
>+		/*
>+		 * Only prealloc when the backing fits the currently-available
>+		 * TT space (manager size minus current usage). This skips the
>+		 * up-front reclaim/compaction both for over-large,
>+		 * user-controlled sizes and when TT is already near full; the
>+		 * populate under the validation guard handles those cases.
>+		 */
>+		if (tt_man) {
>+			u64 used = ttm_resource_manager_usage(tt_man);
>+			u64 shift_size = tt_man->size << PAGE_SHIFT;
>+			u64 avail = shift_size > used ? shift_size - used : 0;
>+
>+			if ((u64)num_pages << PAGE_SHIFT <= avail) {
>+				/*
>+				 * Back off aggressive reclaim/compaction for
>+				 * higher-order chunks here: Xe runs a background
>+				 * defragmenter that upgrades suboptimal pages to
>+				 * beneficial order in place later, so there is no
>+				 * need to stall this user context reclaiming for
>+				 * contiguity.
>+				 */
>+				ttm_pool_prealloc_fill_full(&xe->ttm.pool,
>+							    caching, &prealloc,
>+							    num_pages, true);
>+				have_prealloc = true;
>+			}
>+		}
>+	}
>+

May be extract this new code block into a separte static function?

Niranjana

> 	err = 0;
> 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {.interruptible = true},
> 			    err) {
>@@ -4028,7 +4101,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 				break;
> 		}
> 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
>-				       bo_flags, &exec);
>+				       bo_flags, have_prealloc ? &prealloc : NULL,
>+				       &exec);
> 		drm_exec_retry_on_contention(&exec);
> 		if (IS_ERR(bo)) {
> 			err = PTR_ERR(bo);
>@@ -4036,6 +4110,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> 			break;
> 		}
> 	}
>+	if (have_prealloc)
>+		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
> 	if (err)
> 		goto out_vm;
>
>@@ -4331,21 +4407,19 @@ int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec)
> 	return 0;
> }
>
>-/**
>- * xe_bo_needs_ccs_pages - Whether a bo needs to back up CCS pages when
>- * placed in system memory.
>- * @bo: The xe_bo
>- *
>- * Return: true if extra pages need to be allocated, false otherwise.
>+/*
>+ * Whether a bo with the given attributes needs to back up CCS pages when placed
>+ * in system memory. Split out so callers can query before the xe_bo exists (see
>+ * xe_gem_create_ioctl() preallocation).
>  */
>-bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
>+static bool __xe_bo_needs_ccs_pages(struct xe_device *xe,
>+				    enum ttm_bo_type type, u32 flags,
>+				    u16 cpu_caching)
> {
>-	struct xe_device *xe = xe_bo_device(bo);
>-
> 	if (GRAPHICS_VER(xe) >= 20 && IS_DGFX(xe))
> 		return false;
>
>-	if (!xe_device_has_flat_ccs(xe) || bo->ttm.type != ttm_bo_type_device)
>+	if (!xe_device_has_flat_ccs(xe) || type != ttm_bo_type_device)
> 		return false;
>
> 	/* On discrete GPUs, if the GPU can access this buffer from
>@@ -4353,24 +4427,37 @@ bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
> 	 * can't be used since there's no CCS storage associated with
> 	 * non-VRAM addresses.
> 	 */
>-	if (IS_DGFX(xe) && (bo->flags & XE_BO_FLAG_SYSTEM))
>+	if (IS_DGFX(xe) && (flags & XE_BO_FLAG_SYSTEM))
> 		return false;
>
> 	/* Check if userspace explicitly requested no compression */
>-	if (bo->flags & XE_BO_FLAG_NO_COMPRESSION)
>+	if (flags & XE_BO_FLAG_NO_COMPRESSION)
> 		return false;
>
> 	/*
> 	 * For WB (Write-Back) CPU caching mode, check if the device
> 	 * supports WB compression with coherency.
> 	 */
>-	if (bo->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB &&
>+	if (cpu_caching == DRM_XE_GEM_CPU_CACHING_WB &&
> 	    xe->pat.idx[XE_CACHE_WB_COMPRESSION] == XE_PAT_INVALID_IDX)
> 		return false;
>
> 	return true;
> }
>
>+/**
>+ * xe_bo_needs_ccs_pages - Whether a bo needs to back up CCS pages when
>+ * placed in system memory.
>+ * @bo: The xe_bo
>+ *
>+ * Return: true if extra pages need to be allocated, false otherwise.
>+ */
>+bool xe_bo_needs_ccs_pages(struct xe_bo *bo)
>+{
>+	return __xe_bo_needs_ccs_pages(xe_bo_device(bo), bo->ttm.type,
>+				       bo->flags, bo->cpu_caching);
>+}
>+
> /**
>  * __xe_bo_release_dummy() - Dummy kref release function
>  * @kref: The embedded struct kref.
>@@ -4477,7 +4564,7 @@ int xe_bo_dumb_create(struct drm_file *file_priv,
> 			       DRM_XE_GEM_CPU_CACHING_WC,
> 			       XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
> 			       XE_BO_FLAG_FORCE_WC |
>-			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>+			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL, NULL);
> 	if (IS_ERR(bo))
> 		return PTR_ERR(bo);
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>index 38d50f8122cb..18fcccd082b7 100644
>--- a/drivers/gpu/drm/xe/xe_bo.h
>+++ b/drivers/gpu/drm/xe/xe_bo.h
>@@ -111,6 +111,7 @@ enum xe_madv_purgeable_state {
>
> struct sg_table;
> struct ttm_tt;
>+struct ttm_pool_prealloc;
>
> struct xe_bo *xe_bo_alloc(void);
> void xe_bo_free(struct xe_bo *bo);
>@@ -119,13 +120,16 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
> 				struct xe_tile *tile, struct dma_resv *resv,
> 				struct ttm_lru_bulk_move *bulk, size_t size,
> 				u16 cpu_caching, enum ttm_bo_type type,
>-				u32 flags, struct drm_exec *exec);
>+				u32 flags, struct ttm_pool_prealloc *prealloc,
>+				struct drm_exec *exec);
> struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
> 				  struct xe_vm *vm, size_t size,
> 				  enum ttm_bo_type type, u32 flags,
> 				  struct drm_exec *exec);
> struct xe_bo *xe_bo_create_user(struct xe_device *xe, struct xe_vm *vm, size_t size,
>-				u16 cpu_caching, u32 flags, struct drm_exec *exec);
>+				u16 cpu_caching, u32 flags,
>+				struct ttm_pool_prealloc *prealloc,
>+				struct drm_exec *exec);
> struct xe_bo *xe_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
> 				   struct xe_vm *vm, size_t size,
> 				   enum ttm_bo_type type, u32 flags,
>diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
>index 8a920e58245c..ec947d86a1ce 100644
>--- a/drivers/gpu/drm/xe/xe_dma_buf.c
>+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>@@ -302,7 +302,7 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>
> 		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
> 				       0, /* Will require 1way or 2way for vm_bind */
>-				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
>+				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, NULL, &exec);
> 		drm_exec_retry_on_contention(&exec);
> 		if (IS_ERR(bo)) {
> 			ret = PTR_ERR(bo);
>-- 
>2.34.1
>
