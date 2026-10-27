Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F5606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kctk8DaK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B0610E4B2;
	Tue, 27 Oct 2026 20:44:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E043210E4B2;
 Tue, 27 Oct 2026 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793133851; x=1824669851;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=rmfZBo1ZISQm7laT7OdGah1WfyI79W2BhzNao5JPz9Q=;
 b=Kctk8DaKHMZB9NCgG3jFVOD2ppTbImZKomNJQCVSor0bvvHt7gTSdhoT
 RGg1673jOgxYmLc55V/UmpQxfuOlkcwMSMlDke2G/AJ4gWHF7NupkTMsM
 ZYkr0UllVBnwEwDBMUkwZbfUiANfHi6KU/HL/lviVQzvlO2DtLelrS1CZ
 v84E+5gOwOqYhT7rHRsUHXCzzBkbz2tSD6fiyaxQPuN6dfApPdC0TQgPM
 RfyIO89BMZ8YzaLkSgTXmDh45GnnLGWzmtIpizMfn8JR3XkmeZDhs2daK
 b6E+oho1f9j1jZWjrcVmbE/er8g2VyvYNTwc5szw8F6Gm9kwGMPlpBuFv w==;
X-CSE-ConnectionGUID: u51wI61uRxKqmZ7TT8VCuw==
X-CSE-MsgGUID: sG4MTWRASf+RoGVyCAD25g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1746370"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1746370"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:44:11 -0700
X-CSE-ConnectionGUID: xZv3rYz/SpS4nA5rUVfpaQ==
X-CSE-MsgGUID: AAmwwwQ0RY27bEdxjw638w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6482881"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:44:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 13:44:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 13:44:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 13:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMmU5GGtqOdAabGBWyAzzowQguwoJHOJJX5X3GeHMD/1kG96U5E7KxPTOfXBiVDk9b04MHzThNW2TP8JTsdbHkUBFXX9caY20KpRTSlXQX7v+aJaCCO6jniUCmsDJdmUMiDAXUBWXIyhGZichz4EZyIXBaVeHNw2JWwhsFfGtm12YLSp7ytp2ResNml9EnuDOx6OR5twdQmwJWl+rOPtlqnrDZtRwmr7KM4G2FwTbiOhgkZ5AVHAQXEpy3llbZDylFkXVImQnkbik8rNcNO+Z0b8Td0tDcT3jCVBKC0LgVOZdlT/drlr/YQvvZnnZI389xRn28F4Rq1zRr645PNeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TglmxUjbJ5Pgtb3aDGyh/116qqywCdBMNJMAdJcX0p8=;
 b=rkdbutMUlHjdKnur6MYbr0SYJcL5ZR5/7s1RAoyexiVKbXmpXvy9nOhq3Z0ESjiZoG4E6QZ1Wh/OeTxwGzr5gsAnTHIUBWe9Na8s/SVevqpcCfqWgFqCJaWmmI/PZk3o27sLCFO1E0H/4Gnz8/hpWEbBT3STIu586uwpweuesX5x8+pTV0yn2f5jPGGSyXeZZrcekpSLHccUaj9tYHjsU7HxXWGZaX6lRutaMl0WigBeA55Xor6XJiOfTGbXvgfRVnQ8/9CZxRYgrWR7fcFypIaS8k67UaY4rTFGIwpLeRy8zm8+GfGCcoPfWAsKeQal+Y9ZJyfU7X6KudYq6iJQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS0PR11MB8667.namprd11.prod.outlook.com (2603:10b6:8:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:44:07 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:44:07 +0000
Date: Tue, 27 Oct 2026 13:44:05 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm/xe/svm: Take write access only for GC attribute resets
Message-ID: <auENFUKFEcjZorM6@gsse-cloud1.jf.intel.com>
References: <20261026122045.2709500-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026122045.2709500-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS0PR11MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5a1ce0-4138-4186-9ecb-08df346b0b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|261026121527099003|18002099003|3023799007|56012099006|11063799006|10067099003|261009220027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261022105027099003|261022075727099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 5K85323gGGVB/T8/eKX2zrVgvEvWD5Qq4bm8O165XWsPO6h2RPP6CaQpUNlDL8K8lpQTENvE7JPrXkMDanoi1jQmsUEEDkt5pB0mfUkqwYYjW5Hipi2p7p5l/clWddbzyMd0qmFgUlgj7LeK3n0e9HIvQPzaOO36T2Sy8s7Phw3svL7RQVZoGgLMlT/x5fuBtEVmNHRGkFzTFHEB9Ku1MfwgMmM8OruQ48JYxum+yAaBEwP+JEzpViq3j6fZDhT+xGrB8XikMhuR+313+/q6AvPyWuf4SpzFdss5DrJzXOwEKX7OPxVgQg4bTC6Gh55Cn51V5K16p/a2C9LIkqgMfUQ3XvtugQVUPgVPGGZezkboq/2cnjDAHoxp6aiRR67/toxQWTXOBI3sf4qEd25OTiNjafkcKMIj4C/vhfj4P/r4d2DuWLnDeOi3WEPmxVMWwTELSP6Nj8y/heLuCdcI1IRgEd5oBqCD4/aH1fHgp8ta1F/MeJggeoCqNPFv9kVoE1wrgYJLfF/soW/MhIuucSxUaLtiZAgRFn1JdxgsTwux9QTCuUWg8e2lJ7jC3IigFJGjpJcGlF7jYg9ZIDTAPiAMwh8Wp1xJd6sXnpt80SWJgdqh/4tg1ap9SLOXTisU1blfQ/ifz6ZkVIr1j/YHHLq+QY40MqmW4anzn4RnlAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(261026121527099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(261009220027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HwEI8f7iDtdqXIJBf0njjJ1bE5rWiEgDwPK5A23T3Vyb51G6nVbUPCYFEh?=
 =?iso-8859-1?Q?OZfN7z71dMdTBcCl6pxATnpUnvEHvKwVeh7R+ISC8hQyMhD49Q2FRUDfcj?=
 =?iso-8859-1?Q?vhl/akLEyOQp1ZQdUDl/O62a4xRjSsIuqxcipQ+qgEt6qrhyoQfyhqL3R6?=
 =?iso-8859-1?Q?R4U1xJPeGsIT88afkl7JCAK30t+5aZnP6ZxHMmjc/3siC7ORk1yvkinOW4?=
 =?iso-8859-1?Q?Bo21ZIF/UV3+SEFBEwIVkrQAAFg4+UPCADdXApQoCLqsU2jA3RqLoBjEsu?=
 =?iso-8859-1?Q?voOLN68kHEYkYhbuEZCtSxrL55zyeZ2dtZtcdp3G84EM8ZVSqFAd2Lu1ki?=
 =?iso-8859-1?Q?XjOnOVwU+vtUeGNbhmqwzqmnjFHlm3vBeolFi4vEOj9bz3FTXColMNCzEj?=
 =?iso-8859-1?Q?hLZOsNJ97hlwzy+mvCAc8MS7DExo3ibcNtd0vsp4oiR6Z0lHEGwL/Y0KYV?=
 =?iso-8859-1?Q?O4B2BAoLWpqRHUctZcv82wwhAi0WInW58vc01/koHb048Gu5Fw81dHbLMh?=
 =?iso-8859-1?Q?AZxAQ8/T5aMbVAZQet5B5IOKd4hhY+sQqwRtbHy4xoHObEZmev7e7dMPnJ?=
 =?iso-8859-1?Q?8oqolk0p0T9OrR8zEKSDCIf0ItQXf+xWWjoFDjIVR8En3h3xtNUpzGB5Ku?=
 =?iso-8859-1?Q?oaBhHrFPQKLE9JTIxbBFavLATiAKHkV4oGQi5XeJGMMoBIzkabYndMfKkc?=
 =?iso-8859-1?Q?+E5GDco1hcVwmgbFo87/PCN9sUizVXqoOf7ovyUbZL9m38NQzpSuN968i/?=
 =?iso-8859-1?Q?sPIBV+XSrE3WzR+H+KkKDaBG+ngKPl90AJ/e35wNF+4QyQy2jAEQaiVETi?=
 =?iso-8859-1?Q?yT82YsHDUOp+12RIv5y0NxAU7FayxpLeJ0ncjQOg/NCFgJic8rd7zPTu4V?=
 =?iso-8859-1?Q?UbiPLlCqy3PsKKTonq+3e/7aXgAvzt2wZXms54s6bh37YYU0cTS17ODvAW?=
 =?iso-8859-1?Q?d0yQFFS/MxXTAKnyx684tNXQdwuNJ4MkI0IQKJLP6qzcp4gcjlnfn0pTcA?=
 =?iso-8859-1?Q?NWOZvy/OXzE9VW8UeGSAkX/bAjQE+Ls9NlvD5g5I6Iikxs5rmlnK4uMV1j?=
 =?iso-8859-1?Q?EVzsCUDOoHUciMo8dYStDNh3RiN2l0YVQ+jACIt+hvA6TP+b4uLQsz1Fap?=
 =?iso-8859-1?Q?gYiBfAaqa23wx3MmbBLUMY0CZPvlGRSzgJwe7d56H0LRvtnKi6UF19YiQ1?=
 =?iso-8859-1?Q?F0fG7Hvq07QE3jgb9gtUgsSKJOF4TDFNPGNYegYweOoD5RQR7KEQuCWNRU?=
 =?iso-8859-1?Q?oAszirq3dKBwtH3/MOblELgN3r9H4ToN2YFlY9kDs8I1xS7wx4sAqghyui?=
 =?iso-8859-1?Q?IawwmHlk7C7vVNri0Mu3IW5u0viNfB/odGcc7wbXEISPN0qcADe/5QzY5b?=
 =?iso-8859-1?Q?UO3+YV0wdqLVQ7qwRKNRr8wpeKgNWa/E1u9UUx7nnlnXRRGGnqyPSVSd3x?=
 =?iso-8859-1?Q?fiyEjiaNwYiyY5OggX8GFpuLdOp6/nvAB+HK9fEmPQUwZSRvKK1m68b484?=
 =?iso-8859-1?Q?S+vtCDAJAS1CDZFdaIpaUFmOadboINr8GbNPuQAIOGQGVj+PHMzKm5h/ej?=
 =?iso-8859-1?Q?u8rN3DPrfj1REcFXxakfPYEGjslHueqVWON7n/29nkImQb/l8wAVlzeujF?=
 =?iso-8859-1?Q?F+SxzN9fjLr4ImT6N1Q6hlXfgLZe8CgKlyhNISMXwwe3qfDQzpV339sEkZ?=
 =?iso-8859-1?Q?VVO0oZNEQOjP4HJqC/Dl+J4jAh84LXED/lXOebKSnHQdOC1b0DZ6OFpvWj?=
 =?iso-8859-1?Q?V7WkZLMDpcnz4CpcqQRck4G9Bj6yUaB8/cOGjC/4PMofLviA8TmGwNx0XX?=
 =?iso-8859-1?Q?AmE+Oy+Rpw=3D=3D?=
X-Exchange-RoutingPolicyChecked: fdOW9cs/Rhbu69+qwttOHmZ9oQL5lLIqxiOHfu57nWKoslqEIfBEE6vMpmwkV6KDjZgSUkL3pxkAtsotrZKDUv7iDw+rHu/DZeml/Nuv5g0jSWIhHryLlWiRKTz4XNPvMLcFZg49BHvyOuAz0Y7MM1eUNfu2crcCcD/rx2aFQXFoIr3rH7QnyGIrnY80d0AEwDdheBLWE0H3w6Nqgt3ZEGT0xDu2zELFXouAXkFaz6oD6akNwes7dD34/1/k4OUNDAu8fFPPVLGwYhx57zRTOSqWbZ7JgS3kB9EPVI+Kb8+7VBP36WoCgJ4GOoKNhAxqhgI+d3sZ5u5xjPJOOMBWfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5a1ce0-4138-4186-9ecb-08df346b0b79
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:44:07.0222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVRwIphbjW7sBWwxQAMa7CzQ4HYJCvG4ROOOLb67CvnOm+XpNbiRERbROjxkQqUUHm81/eEmkykUdzWkmpv6oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8667
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 05:50:45PM +0530, Arvind Yadav wrote:
> Fault service holds vm->lock for read while using a VMA. SVM garbage
> collection also runs under the read lock and can reset AUTORESET
> attributes. The reset can split or merge VMAs and immediately free a
> VMA that another fault worker is still using. The GC mutex serializes

I'll have to think about this one for a bit but quick thought:

Can we use some ref counting (e.g., add a VMA ref count) rather than
changing the locking?

Matt

> collectors but does not protect VMA readers.
> 
> Keep backing collection under read access when no attribute change is
> needed. Defer ranges requiring a reset and return -EAGAIN so the caller
> can release its read-side state and collect with write access.
> 
> In fault service, discard the old VMA pointer before releasing the read
> lock. After acquiring write access, recheck VM state and collect the
> queued ranges. Downgrade to read and repeat VMA lookup, permission checks
> and advice-dependent setup.
> 
> Drain GC under the existing write lock before madvise, bind and attribute
> query. Require write access for VMA changes while retaining parallel
> fault service when no reset is needed.
> 
> [ 2163.042338] ==================================================================
> [ 2163.042353] BUG: KASAN: slab-use-after-free in __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> [ 2163.042815] Read of size 8 at addr ffff88813f879b70 by task kworker/u65:3/3115
> 
> [ 2163.042834] CPU: 0 UID: 0 PID: 3115 Comm: kworker/u65:3 Kdump: loaded Tainted: G S      W  O        7.3.0-lgci-xe-svm-22oct #16 PREEMPT(full)
> [ 2163.042841] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
> [ 2163.042842] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1002 03/31/2023
> [ 2163.042845] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
> [ 2163.043326] Call Trace:
> [ 2163.043327]  <TASK>
> [ 2163.043330]  dump_stack_lvl+0x91/0xf0
> [ 2163.043336]  print_report+0xd1/0x610
> [ 2163.043340]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> [ 2163.043825]  ? __virt_addr_valid+0x1b2/0x350
> [ 2163.043831]  ? kasan_complete_mode_report_info+0x6a/0x210
> [ 2163.043836]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> [ 2163.044340]  kasan_report+0xa3/0xe0
> [ 2163.044344]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> [ 2163.044881]  __asan_load8+0x8b/0xe0
> [ 2163.044885]  __xe_svm_handle_pagefault+0x297/0x1460 [xe]
> [ 2163.045456]  ? lock_acquire+0x1b0/0x320
> [ 2163.045461]  ? xe_vm_find_overlapping_vma+0x88/0x310 [xe]
> [ 2163.046072]  ? __pfx___xe_svm_handle_pagefault+0x10/0x10 [xe]
> [ 2163.046679]  ? rcu_is_watching+0x21/0x60
> [ 2163.046684]  ? __mutex_lock+0x1172/0x18b0
> [ 2163.046690]  ? find_held_lock+0x31/0x90
> [ 2163.046696]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
> [ 2163.047273]  ? __kasan_check_write+0x14/0x30
> [ 2163.047278]  ? __mutex_unlock_slowpath+0x10f/0x660
> [ 2163.047285]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
> [ 2163.047295]  ? mutex_unlock+0x12/0x20
> [ 2163.047299]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
> [ 2163.047844]  xe_svm_handle_pagefault+0x5c/0x140 [xe]
> [ 2163.048355]  xe_pagefault_queue_work+0x19ad/0x2450 [xe]
> [ 2163.048843]  process_one_work+0x5ae/0xdd0
> [ 2163.048847]  ? __lock_acquire+0x58a/0x2820
> [ 2163.048850]  ? __schedule+0x22a6/0x3670
> [ 2163.048858]  ? __pfx_process_one_work+0x10/0x10
> [ 2163.048866]  ? __pfx_xe_pagefault_queue_work+0x10/0x10 [xe]
> [ 2163.049345]  ? assign_work+0xe4/0x1d0
> [ 2163.049350]  worker_thread+0x3b4/0x6a0
> [ 2163.049357]  ? __pfx_worker_thread+0x10/0x10
> [ 2163.049361]  kthread+0x204/0x250
> [ 2163.049364]  ? kthread+0xf1/0x250
> [ 2163.049369]  ? __pfx_kthread+0x10/0x10
> [ 2163.049372]  ret_from_fork+0x465/0x6a0
> [ 2163.049377]  ? __pfx_ret_from_fork+0x10/0x10
> [ 2163.049381]  ? __switch_to+0x26f/0x740
> [ 2163.049386]  ? __pfx_kthread+0x10/0x10
> [ 2163.049390]  ret_from_fork_asm+0x1a/0x30
> [ 2163.049399]  </TASK>
> 
> [ 2163.049654] Allocated by task 522570:
> [ 2163.049662]  kasan_save_stack+0x26/0x60
> [ 2163.049668]  kasan_save_track+0x14/0x40
> [ 2163.049672]  kasan_save_alloc_info+0x37/0x60
> [ 2163.049677]  __kasan_kmalloc+0xc3/0xd0
> [ 2163.049681]  __kmalloc_cache_noprof+0x2b4/0x6c0
> [ 2163.049686]  xe_vma_create+0xe3/0xe60 [xe]
> [ 2163.050170]  new_vma+0x416/0x540 [xe]
> [ 2163.050654]  vm_bind_ioctl_ops_parse+0xc3e/0x1110 [xe]
> [ 2163.051139]  xe_vm_alloc_vma+0x243/0xd60 [xe]
> [ 2163.051623]  xe_vm_alloc_madvise_vma+0x92/0xd0 [xe]
> [ 2163.052107]  xe_vm_madvise_ioctl+0x783/0x14f0 [xe]
> [ 2163.052591]  drm_ioctl_kernel+0x143/0x200
> [ 2163.052597]  drm_ioctl+0x419/0x790
> [ 2163.052600]  xe_drm_ioctl+0x9e/0xf0 [xe]
> [ 2163.053074]  __x64_sys_ioctl+0xd5/0x130
> [ 2163.053079]  x64_sys_call+0x2b5/0x27e0
> [ 2163.053084]  do_syscall_64+0xef/0x6c0
> [ 2163.053088]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [ 2163.053098] Freed by task 17929:
> [ 2163.053105]  kasan_save_stack+0x26/0x60
> [ 2163.053110]  kasan_save_track+0x14/0x40
> [ 2163.053114]  kasan_save_free_info+0x3b/0x60
> [ 2163.053118]  __kasan_slab_free+0x6f/0xa0
> [ 2163.053123]  kfree+0x2bb/0x600
> [ 2163.053127]  xe_vma_free+0x5a/0x70 [xe]
> [ 2163.053610]  xe_vma_destroy_late+0xae/0xf0 [xe]
> [ 2163.054093]  xe_vma_destroy+0xda/0xf20 [xe]
> [ 2163.054576]  xe_vm_alloc_vma+0x304/0xd60 [xe]
> [ 2163.055059]  xe_vm_alloc_cpu_addr_mirror_vma+0x8f/0xd0 [xe]
> [ 2163.055543]  xe_svm_garbage_collector+0x388/0x5d0 [xe]
> [ 2163.056028]  xe_svm_garbage_collector_work_func+0x2a/0x40 [xe]
> [ 2163.056512]  process_one_work+0x5ae/0xdd0
> [ 2163.056517]  worker_thread+0x3b4/0x6a0
> [ 2163.056521]  kthread+0x204/0x250
> [ 2163.056525]  ret_from_fork+0x465/0x6a0
> [ 2163.056530]  ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 941bcc1a4bbf ("drm/xe: Fine grained page fault locking")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Assisted-by: LLM
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pagefault.c  |  37 +++++-
>  drivers/gpu/drm/xe/xe_svm.c        | 179 ++++++++++++++++++++++-------
>  drivers/gpu/drm/xe/xe_svm.h        |   8 ++
>  drivers/gpu/drm/xe/xe_vm.c         |  54 +++++----
>  drivers/gpu/drm/xe/xe_vm_madvise.c |   5 +
>  5 files changed, 212 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 5247321c805e..9e1377df9d01 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -270,8 +270,9 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>  	struct xe_device *xe = gt_to_xe(gt);
>  	struct xe_vm *vm;
>  	struct xe_vma *vma = NULL;
> +	enum xe_pagefault_error error;
>  	int err;
> -	bool atomic;
> +	bool atomic, svm_relookup = false;
>  	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>  
>  	/* Producer flagged this fault to be nacked */
> @@ -297,10 +298,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>  		goto unlock_vm;
>  	}
>  
> +lookup_vma:
>  	vma = xe_vm_find_vma_by_addr(vm, xe_pagefault_addr(pf));
>  	if (!vma) {
>  		err = -EINVAL;
> -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
> +		xe_pagefault_set_error(pf, svm_relookup ?
> +				       XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND :
> +				       XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
>  		goto unlock_vm;
>  	}
>  
> @@ -313,11 +317,36 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>  
>  	atomic = xe_pagefault_access_is_atomic(pf->consumer.access_type);
>  
> -	if (xe_vma_is_cpu_addr_mirror(vma))
> +	if (xe_vma_is_cpu_addr_mirror(vma)) {
>  		err = xe_svm_handle_pagefault(vm, vma, pf, gt,
>  					      xe_pagefault_addr(pf), atomic);
> -	else
> +		if (err == -EAGAIN) {
> +			/* GC needs to change VMAs. Drop all read-side state. */
> +			vma = NULL;
> +			up_read(&vm->lock);
> +			down_write(&vm->lock);
> +
> +			if (xe_vm_is_closed(vm)) {
> +				err = -ENOENT;
> +				error = XE_PAGEFAULT_ERROR_VM_CLOSED;
> +			} else {
> +				err = xe_svm_garbage_collect(vm);
> +				error = XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR;
> +			}
> +
> +			downgrade_write(&vm->lock);
> +			if (err) {
> +				xe_pagefault_set_error(pf, error);
> +				goto unlock_vm;
> +			}
> +
> +			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
> +			svm_relookup = true;
> +			goto lookup_vma;
> +		}
> +	} else {
>  		err = xe_pagefault_handle_vma(gt, vma, pf, atomic);
> +	}
>  
>  unlock_vm:
>  	if (err)
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index bc6902b5bf57..d19cb0c4b154 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -356,12 +356,36 @@ static void xe_vma_set_default_attributes(struct xe_vma *vma)
>  	xe_vma_mem_attr_copy(&vma->attr, &default_attr);
>  }
>  
> +/* vm->lock keeps the VMA and its attributes stable during this check. */
> +static bool xe_svm_range_needs_attr_reset(struct xe_vm *vm, u64 start)
> +{
> +	struct xe_vma *vma;
> +	u64 end;
> +
> +	lockdep_assert_held(&vm->lock);
> +
> +	vma = xe_vm_find_vma_by_addr(vm, start);
> +	if (!vma || !(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
> +		return false;
> +
> +	if (!xe_vma_has_default_mem_attrs(vma))
> +		return true;
> +
> +	start = xe_vma_start(vma);
> +	end = xe_vma_end(vma);
> +	xe_vm_find_cpu_addr_mirror_vma_range(vm, &start, &end);
> +
> +	return start != xe_vma_start(vma) || end != xe_vma_end(vma);
> +}
> +
>  static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
>  {
>  	struct xe_vma *vma;
>  	bool has_default_attr;
>  	int err;
>  
> +	lockdep_assert_held_write(&vm->lock);
> +
>  	vma = xe_vm_find_vma_by_addr(vm, start);
>  	if (!vma)
>  		return -EINVAL;
> @@ -397,70 +421,134 @@ static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
>  		return err;
>  	}
>  
> -	/*
> -	 * On call from xe_svm_handle_pagefault original VMA might be changed
> -	 * signal this to lookup for VMA again.
> -	 */
> -	return -EAGAIN;
> +	return 0;
>  }
>  
> -static int xe_svm_garbage_collector(struct xe_vm *vm)
> +/*
> + * With reset_attrs false, defer ranges requiring a VMA change and return
> + * -EAGAIN after collecting the remaining ready ranges in the batch. The
> + * caller must release all read-side state before collecting them with
> + * vm->lock held for write.
> + */
> +static int xe_svm_garbage_collector(struct xe_vm *vm, bool reset_attrs)
>  {
>  	struct xe_svm_range *range;
> -	u64 range_start;
> -	u64 range_end;
> -	int err, ret = 0;
> +	LIST_HEAD(pending);
> +	LIST_HEAD(deferred);
> +	u64 range_start, range_end;
> +	bool needs_reset;
> +	int err = 0, ret = 0;
>  
>  	lockdep_assert_held(&vm->lock);
> +	if (reset_attrs)
> +		lockdep_assert_held_write(&vm->lock);
>  
>  	if (xe_vm_is_closed_or_banned(vm))
>  		return -ENOENT;
>  
>  	guard(mutex)(&vm->svm.garbage_collector.lock);
>  
> +	/* Process a finite batch, excluding events queued during this pass. */
> +	spin_lock(&vm->svm.garbage_collector.list_lock);
> +	if (list_empty(&vm->svm.garbage_collector.range_list)) {
> +		spin_unlock(&vm->svm.garbage_collector.list_lock);
> +		return 0;
> +	}
> +	list_splice_init(&vm->svm.garbage_collector.range_list, &pending);
> +	spin_unlock(&vm->svm.garbage_collector.list_lock);
> +
>  	for (;;) {
>  		spin_lock(&vm->svm.garbage_collector.list_lock);
> -		range = list_first_entry_or_null(&vm->svm.garbage_collector.range_list,
> -						 typeof(*range),
> +		range = list_first_entry_or_null(&pending, typeof(*range),
>  						 garbage_collector_link);
> -		if (!range)
> +		if (!range) {
> +			spin_unlock(&vm->svm.garbage_collector.list_lock);
>  			break;
> +		}
>  
>  		range_start = xe_svm_range_start(range);
>  		range_end = xe_svm_range_end(range);
> -
>  		list_del(&range->garbage_collector_link);
>  		spin_unlock(&vm->svm.garbage_collector.list_lock);
>  
> +		/*
> +		 * Keep the backing range alive until its attributes can be
> +		 * reset. The GC mutex excludes other collectors and explicit
> +		 * range removal requires vm->lock for write.
> +		 */
> +		needs_reset = xe_svm_range_needs_attr_reset(vm, range_start);
> +		if (needs_reset && !reset_attrs) {
> +			spin_lock(&vm->svm.garbage_collector.list_lock);
> +			list_add_tail(&range->garbage_collector_link, &deferred);
> +			spin_unlock(&vm->svm.garbage_collector.list_lock);
> +			ret = -EAGAIN;
> +			continue;
> +		}
> +
>  		err = __xe_svm_garbage_collector(vm, range);
>  		if (err) {
>  			drm_warn(&vm->xe->drm,
>  				 "Garbage collection failed: %pe\n",
>  				 ERR_PTR(err));
> +			/* Leave the failed range in the tree for VM teardown. */
>  			xe_vm_kill(vm, true);
> -			return err;
> +			goto out;
>  		}
>  
> -		err = xe_svm_range_set_default_attr(vm, range_start, range_end);
> -		if (err) {
> -			if (err == -EAGAIN)
> -				ret = -EAGAIN;
> -			else
> -				return err;
> +		if (needs_reset) {
> +			err = xe_svm_range_set_default_attr(vm, range_start, range_end);
> +			if (err)
> +				goto out;
>  		}
>  	}
> +
> +out:
> +	/* Restore ranges not yet processed, including deferred resets. */
> +	spin_lock(&vm->svm.garbage_collector.list_lock);
> +	list_splice_tail_init(&pending, &vm->svm.garbage_collector.range_list);
> +	list_splice_tail_init(&deferred, &vm->svm.garbage_collector.range_list);
>  	spin_unlock(&vm->svm.garbage_collector.list_lock);
>  
> -	return ret;
> +	return err ?: ret;
> +}
> +
> +/**
> + * xe_svm_garbage_collect() - Collect SVM ranges and reset their attributes
> + * @vm: The VM, with vm->lock held for write.
> + *
> + * Process one batch of queued ranges, including attribute resets. Ranges
> + * queued during this pass are left for a later collection.
> + *
> + * Call before changing advice or bindings, or querying attributes, so the
> + * batch is reset before applying new advice or reporting attributes.
> + * No VMA pointer may be retained across this call.
> + *
> + * Return: 0 on success, negative error code on error.
> + */
> +int xe_svm_garbage_collect(struct xe_vm *vm)
> +{
> +	lockdep_assert_held_write(&vm->lock);
> +
> +	if (!xe_vm_in_fault_mode(vm))
> +		return 0;
> +
> +	return xe_svm_garbage_collector(vm, true);
>  }
>  
>  static void xe_svm_garbage_collector_work_func(struct work_struct *w)
>  {
>  	struct xe_vm *vm = container_of(w, struct xe_vm,
>  					svm.garbage_collector.work);
> +	int err = 0;
>  
> -	guard(rwsem_read)(&vm->lock);
> -	xe_svm_garbage_collector(vm);
> +	scoped_guard(rwsem_read, &vm->lock)
> +		err = xe_svm_garbage_collector(vm, false);
> +
> +	if (err != -EAGAIN)
> +		return;
> +
> +	guard(rwsem_write)(&vm->lock);
> +	xe_svm_garbage_collect(vm);
>  }
>  
>  #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
> @@ -1302,13 +1390,15 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  	if (range) {
>  		mutex_unlock(&range->lock);
>  		drm_gpusvm_range_put(&range->base);
> -	}
>  
> -	/* Always process UNMAPs first so view SVM ranges is current */
> -	err = xe_svm_garbage_collector(vm);
> -	if (err) {
> -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
> -		return err;
> +		/* The caller collected before the initial service attempt. */
> +		err = xe_svm_garbage_collector(vm, false);
> +		if (err) {
> +			if (err != -EAGAIN)
> +				xe_pagefault_set_error(pf,
> +						      XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
> +			return err;
> +		}
>  	}
>  
>  	dpagemap = ctx.devmem_only ? xe_tile_local_pagemap(tile) :
> @@ -1468,14 +1558,28 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>   * Create GPU bindings for a SVM page fault. Optionally migrate to device
>   * memory.
>   *
> - * Return: 0 on success, negative error code on error.
> + * The caller must hold vm->lock for read. On -EAGAIN, discard @vma before
> + * releasing that lock. Collect with write access, then repeat VMA lookup
> + * and permission checks before retrying.
> + *
> + * Return: 0 on success, -EAGAIN if the caller must collect with write
> + * access and repeat VMA lookup, or another negative error code on error.
>   */
>  int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  			    struct xe_pagefault *pf, struct xe_gt *gt,
>  			    u64 fault_addr, bool atomic)
>  {
>  	int need_vram, ret;
> -retry:
> +
> +	/* Consume older UNMAPs before reading advice or building the context. */
> +	ret = xe_svm_garbage_collector(vm, false);
> +	if (ret) {
> +		if (ret != -EAGAIN)
> +			xe_pagefault_set_error(pf,
> +					       XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
> +		return ret;
> +	}
> +
>  	need_vram = xe_vma_need_vram_for_atomic(vm->xe, vma, atomic);
>  	if (need_vram < 0) {
>  		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_NEEDS_VRAM_CHECK);
> @@ -1485,18 +1589,9 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  	ret =  __xe_svm_handle_pagefault(vm, vma, pf, gt, fault_addr,
>  					 need_vram ? true : false);
>  	if (ret == -EAGAIN) {
> -		/*
> -		 * Retry once on -EAGAIN to re-lookup the VMA, as the original VMA
> -		 * may have been split by xe_svm_range_set_default_attr.
> -		 */
> -		vma = xe_vm_find_vma_by_addr(vm, fault_addr);
> -		if (!vma) {
> -			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND);
> -			return -EINVAL;
> -		}
> -
> +		/* Retry from the caller after collecting with write access. */
>  		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
> -		goto retry;
> +		return ret;
>  	}
>  	if (ret && xe_pagefault_get_error(pf) == XE_PAGEFAULT_ERROR_NONE)
>  		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_SERVICE_FAILED);
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index ffc1cc808102..523213a8cd26 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -109,6 +109,8 @@ void xe_svm_fini(struct xe_vm *vm);
>  
>  void xe_svm_close(struct xe_vm *vm);
>  
> +int xe_svm_garbage_collect(struct xe_vm *vm);
> +
>  int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  			    struct xe_pagefault *pf, struct xe_gt *gt,
>  			    u64 fault_addr, bool atomic);
> @@ -316,6 +318,12 @@ void xe_svm_close(struct xe_vm *vm)
>  {
>  }
>  
> +static inline
> +int xe_svm_garbage_collect(struct xe_vm *vm)
> +{
> +	return 0;
> +}
> +
>  static inline
>  int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  			    struct xe_pagefault *pf, struct xe_gt *gt,
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d12365b11186..6afe6f1be1d4 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1308,19 +1308,12 @@ static void vma_destroy_cb(struct dma_fence *fence,
>  	xe_destroy_wq_queue(&vma->destroy_work);
>  }
>  
> -static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
> -{
> -	lockdep_assert(lockdep_is_held_type(&vm->lock, 0) ||
> -		       (lockdep_is_held_type(&vm->lock, 1) &&
> -			lockdep_is_held_type(&vm->svm.garbage_collector.lock, 0)));
> -}
> -
>  static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
>  {
>  	struct xe_vm *vm = xe_vma_vm(vma);
>  	struct xe_bo *bo = xe_vma_bo(vma);
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  	xe_assert(vm->xe, list_empty(&vma->combined_links.destroy));
>  
>  	if (xe_vma_is_userptr(vma)) {
> @@ -1416,7 +1409,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
>  	int err;
>  
>  	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	mutex_lock(&vm->snap_mutex);
>  	err = drm_gpuva_insert(&vm->gpuvm, &vma->gpuva);
> @@ -1429,7 +1422,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
>  static void xe_vm_remove_vma(struct xe_vm *vm, struct xe_vma *vma)
>  {
>  	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	mutex_lock(&vm->snap_mutex);
>  	drm_gpuva_remove(&vma->gpuva);
> @@ -2267,7 +2260,7 @@ static int xe_vm_query_vmas(struct xe_vm *vm, u64 start, u64 end)
>  	struct drm_gpuva *gpuva;
>  	u32 num_vmas = 0;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held(&vm->lock);
>  	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end)
>  		num_vmas++;
>  
> @@ -2280,7 +2273,7 @@ static int get_mem_attrs(struct xe_vm *vm, u32 *num_vmas, u64 start,
>  	struct drm_gpuva *gpuva;
>  	int i = 0;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held(&vm->lock);
>  
>  	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end) {
>  		struct xe_vma *vma = gpuva_to_vma(gpuva);
> @@ -2330,6 +2323,12 @@ int xe_vm_query_vmas_attrs_ioctl(struct drm_device *dev, void *data, struct drm_
>  	if (err)
>  		goto put_vm;
>  
> +	if (!xe_vm_is_closed_or_banned(vm)) {
> +		err = xe_svm_garbage_collect(vm);
> +		if (err)
> +			goto unlock_vm;
> +	}
> +
>  	attrs_user = u64_to_user_ptr(args->vector_of_mem_attr);
>  
>  	if (args->num_mem_ranges == 0 && !attrs_user) {
> @@ -2487,7 +2486,7 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
>  	u64 range_end = addr + range;
>  	int err;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	vm_dbg(&vm->xe->drm,
>  	       "op=%d, addr=0x%016llx, range=0x%016llx, bo_offset_or_userptr=0x%016llx",
> @@ -2694,7 +2693,7 @@ static struct xe_vma *new_vma(struct xe_vm *vm, struct drm_gpuva_op_map *op,
>  	struct xe_vma *vma;
>  	int err = 0;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	if (bo) {
>  		err = 0;
> @@ -2795,7 +2794,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>  
>  	switch (op->base.op) {
>  	case DRM_GPUVA_OP_MAP:
> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> +		lockdep_assert_held_write(&vm->lock);
>  
>  		err |= xe_vm_insert_vma(vm, op->map.vma);
>  		if (!err)
> @@ -2806,7 +2805,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>  		u8 tile_present =
>  			gpuva_to_vma(op->base.remap.unmap->va)->tile_present;
>  
> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> +		lockdep_assert_held_write(&vm->lock);
>  
>  		prep_vma_destroy(vm, gpuva_to_vma(op->base.remap.unmap->va),
>  				 true);
> @@ -2842,7 +2841,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>  		break;
>  	}
>  	case DRM_GPUVA_OP_UNMAP:
> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> +		lockdep_assert_held_write(&vm->lock);
>  
>  		prep_vma_destroy(vm, gpuva_to_vma(op->base.unmap.va), true);
>  		op->flags |= XE_VMA_OP_COMMITTED;
> @@ -2889,7 +2888,7 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
>  	u8 id, tile_mask = 0;
>  	int err = 0;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	for_each_tile(tile, vm->xe, id)
>  		tile_mask |= 0x1 << id;
> @@ -3072,7 +3071,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>  
>  	switch (op->base.op) {
>  	case DRM_GPUVA_OP_MAP:
> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> +		lockdep_assert_held_write(&vm->lock);
>  
>  		if (op->map.vma) {
>  			prep_vma_destroy(vm, op->map.vma, post_commit);
> @@ -3083,7 +3082,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>  	{
>  		struct xe_vma *vma = gpuva_to_vma(op->base.unmap.va);
>  
> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> +		lockdep_assert_held_write(&vm->lock);
>  
>  		if (vma) {
>  			xe_svm_notifier_lock(vm);
> @@ -3098,7 +3097,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>  	{
>  		struct xe_vma *vma = gpuva_to_vma(op->base.remap.unmap->va);
>  
> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
> +		lockdep_assert_held_write(&vm->lock);
>  
>  		if (op->remap.prev) {
>  			prep_vma_destroy(vm, op->remap.prev, prev_post_commit);
> @@ -4092,6 +4091,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  		goto release_vm_lock;
>  	}
>  
> +	/* Consume queued resets before replacing VMAs. */
> +	err = xe_svm_garbage_collect(vm);
> +	if (err)
> +		goto release_vm_lock;
> +
>  	for (i = 0; i < args->num_binds; ++i) {
>  		u64 range = bind_ops[i].range;
>  		u64 addr = bind_ops[i].addr;
> @@ -4907,7 +4911,7 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
>  	u16 default_pat;
>  	int err;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	if (is_madvise)
>  		ops = drm_gpuvm_madvise_ops_create(&vm->gpuvm, map_req);
> @@ -5041,7 +5045,7 @@ int xe_vm_alloc_madvise_vma(struct xe_vm *vm, uint64_t start, uint64_t range)
>  		.map.va.range = range,
>  	};
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	vm_dbg(&vm->xe->drm, "MADVISE_OPS_CREATE: addr=0x%016llx, size=0x%016llx", start, range);
>  
> @@ -5073,7 +5077,7 @@ void xe_vm_find_cpu_addr_mirror_vma_range(struct xe_vm *vm, u64 *start, u64 *end
>  {
>  	struct xe_vma *prev, *next;
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held(&vm->lock);
>  
>  	if (*start >= SZ_4K) {
>  		prev = xe_vm_find_vma_by_addr(vm, *start - SZ_4K);
> @@ -5105,7 +5109,7 @@ int xe_vm_alloc_cpu_addr_mirror_vma(struct xe_vm *vm, uint64_t start, uint64_t r
>  		.map.va.range = range,
>  	};
>  
> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
> +	lockdep_assert_held_write(&vm->lock);
>  
>  	vm_dbg(&vm->xe->drm, "CPU_ADDR_MIRROR_VMA_OPS_CREATE: addr=0x%016llx, size=0x%016llx",
>  	       start, range);
> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
> index 5c7aefc641ee..1af5e79bbfd3 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
> @@ -638,6 +638,11 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>  		goto unlock_vm;
>  	}
>  
> +	/* Consume queued resets before publishing new advice. */
> +	err = xe_svm_garbage_collect(vm);
> +	if (err)
> +		goto unlock_vm;
> +
>  	err = xe_madvise_details_init(vm, args, &details);
>  	if (err)
>  		goto unlock_vm;
> -- 
> 2.43.0
> 
