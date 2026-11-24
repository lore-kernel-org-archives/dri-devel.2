Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391360A260A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KGcptpg2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jb/0ZFGb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A4F10E1BB;
	Tue, 24 Nov 2026 20:13:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9034E10E27E;
 Tue, 24 Nov 2026 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795551217; x=1827087217;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KOSMmCrFtI4p0y4M7ZhEcJBjw0OMFXSjWQo5yJ0cKe8=;
 b=KGcptpg2CvJ4pxKyK8Fb3tfM0PkD4U57ZuKuS5SGUyukp2IuyLrh4tWQ
 M1bhhNg0opAPuS+g9fHXgqVajKrhlj9RHbX30bEjJcaqpFJJ2Wg0C8VyN
 zW98VvIayEykcNeDUPR7HFwkWTtM+HWajTKLSMawBbrQXVJQLvZmxZo7F
 COsWWzU+M0Dxggs9sV8MhYGIYfRHp/nqNqvIzNVMTDwlvNSktWLvdcL9o
 XQlZJvrc+u1THgMtPTqqfcpEmJZBTcxt8fDfhBiGNQ4xFzmprYWjcjNdf
 LGu7zE1BchrlQa6toq0aGgsG4rI5xm1M6FTdaZ96L8hEjGQL9UvFwunHw A==;
X-CSE-ConnectionGUID: p3eFC1NcSKGiwDNZ3Bsefg==
X-CSE-MsgGUID: aDUvy3nHS5W1o6dVqN+Puw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4297482"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4297482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:13:37 -0800
X-CSE-ConnectionGUID: EvK2U4alSnKm+FhhMSJrFA==
X-CSE-MsgGUID: 6xaDG1cMTCmslx9GsI1aww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11985532"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:13:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:13:36 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:13:36 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:13:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN+HAl48X/ymUjkq/1esn5x0inJWRdbyJ13ePp2lfHl3aPOwnE7oiNXLSzON4E6wH8aR2I+Xrh6NcXUK3ogvpZfG1pFacP0oaHmqNyOBpOKKlgZrn09WXAz7HJEMtjJ2MHxqDqbrsTifPH1J9hgrQ6xKxIz8go26V36J4k1Nw9hN6yqd3Jjzn2dhr12FV3w8Lf4F7GpeG+z175eTt2a2mliyO6VmBdWlwYciksCwnLL0mNxB2svkvpIO/duH+3qLWzE4nQMC6obXltCwxl0fYVpJty/AUF7LuwHwrpmELOU1LwEQQ/qvWYChyYMgczI8X4urtQUsqG9EyHLDRpwUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+ivveOGBeG9ocCze5/ZYrHi6KL+ZyCKycn6aBDka+o=;
 b=Z50QrglWvM3kYcQTxjQsiJ6MmYNXdxQFS3ApbNTf9gkSlwldM8gA/TfiPSMmVMUbqZMlnMXnIDApeeA/ABQFdFxq48uN3PsyULEcPvb1m/+07gMZa/tcLFyU70QuQ3gJc5XSi+tQlIq2Lr/6wAMeSQM5qHwhdVpX0iAYWfjDsznlBJw0/2ve+38A1znbUkoEbkVakMrxJun9F+MqWEVk0xBw67bwnNYWEqKYb2HDpvQ8GBajUGr+Fb6RJkyzqIUycUBMHLeh3mHFVeAPpt829uoCshQNnTZwpm0NdNQET00n8gKzR8cuTZ38C4yzg3VZ2IUQcnEJOEboX47U4fl7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ivveOGBeG9ocCze5/ZYrHi6KL+ZyCKycn6aBDka+o=;
 b=jb/0ZFGbmry/wSlgTmqNThVKXKZn7pMruQjBruEX6cdTauTyY3YZFCSpdFsDrFTlXlH1sqs1lPvftHhXKXg8peK/Uu/6jROJXbprnn4T8x8GTsGwaplsI6qx5HVfjpUst6aH1v+GWlfeXa8jg7/J9MrwsDw40VDWkHhWyq3jwLc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 20:13:33 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:13:33 +0000
Date: Tue, 24 Nov 2026 12:13:30 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 21/33] drm/xe: Add defrag GT stats
Message-ID: <awXv6i0XOixBYI5l@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-22-matthew.brost@intel.com>
 <avEdhk66ta4lHZlj@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avEdhk66ta4lHZlj@nvishwa1-desk>
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH0PR11MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1ef32e-091e-4700-af35-08df4a676a3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|261009223027099003|22082099003|18002099003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: vkjBGTMv9yE0ekiA8qWLnpclKpNWltMZK8JjmcLnMkoTRGD2yImsHdHqSvlD20ZPBnSsuk8T/qVMd6KcboZowEeeW+4sY0vzo70TD5xAmkP/OVgFe+e7xBI+Piyh8HvbUpaELR/tOEKT8W7tMBjpv8gnejgVX93mYbz3NPYkNxwYQbaclDhREDheN7MWbaphmcyUlKqbYic7dsKEs1XAbmx3OnNr1+SNUjiZxBnqw4OcTX0tCZ8k/NhSyaBgNIXDkNeQ8EBUixKC9gY735/TWd6O2YKrPaVToWcO8rGlz1GGOocczgJjYYT0wgOuZDx5zzgYHUQf3PXMus4DRdXveU8ons8p5vtxnJmzYHMBii2w70oe0/BRf4HWCOk+joAcM96yQ9Pnjj4EwPD1J8a1KcHIH143FaOHr+A7TD5qgo8EuOE77lxS7sxAlTeGHPDrpLIjUkP0EIobnZboS+HhELvOyfPy4TWhF4ZPdozV/3YGwrP8hpgy/+JUZ030rIQa6/1hiJPaVrkRBsluiNBWGCsBQrcRAoKtpWBFG3OUwY0KVwnis+INsC4vIYYisr1Ggf9823Pe990TTN9OO9MTzNFTc7tl26rjhVBPA0T5BW36DLdi6ZNXOuHX+9FMfruvosoATN41A0Y71oQSxgCD7RjQ+j7L76autroFZJMzDJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(261009223027099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8y2YWxED+V7TqMspTVUPVVSeeL0VzFGEmRXN8ZI9/+1rw7OWj0syWLjzxk?=
 =?iso-8859-1?Q?o1nEnPg63uIu2s+8GSgiq99+k0P6395oINu7eP8X5DD2IJsoBmm/oRNcWX?=
 =?iso-8859-1?Q?fmKpSYqxfPxiXYlO5rmgm5DeOvzATsyd01GbXD7GcJ6QbuWYL4kFODMKYL?=
 =?iso-8859-1?Q?9dincksrwrKaqOxReZsXkz072PkAvrGRDXIgRQ841BatBqysI1Acm0MJ1p?=
 =?iso-8859-1?Q?MX3WyD3Kl4rFBDqsQGV94mnBTMFDxPc1aFoJa5JgMJremYZlv2zg3W3ZBN?=
 =?iso-8859-1?Q?5igpVYkud5zrqwk7KDM36jvDHYurWLjjG+8YCrUzTbf/Kiya5GC0H91H2k?=
 =?iso-8859-1?Q?scVnCLJ+oCI8NpERo0JN26cTmmBPkTUyuvU5t6r0oGojWmuvM9cuVMhwhm?=
 =?iso-8859-1?Q?YSNrTf3WR9o32x+qJfvUt+lOp+Uob4B8ksXdOMex/5nZW3heNLyUx4VxyM?=
 =?iso-8859-1?Q?BemzHtAm8KO40WG7fnqqDAWKRLbqj2BSJEIm3S3nCiHUPZoB+eXiqDwsLQ?=
 =?iso-8859-1?Q?2qDoI52dHrn8lMZLXc/Gg7L4kIX+eH9EhhM7X+VDUUS1EB1HBuOUYxDaPs?=
 =?iso-8859-1?Q?9UnDjBnGAQu/XM2bL3FRtTIE+q/AcILbtMkLXLzuY4JZeJvNrJGmeTaz7J?=
 =?iso-8859-1?Q?z7EuyNA7TPUQ/ZuJIhSewMEiCY4+86qdBYcUqhM25gu6nRmX0qYmI3m69u?=
 =?iso-8859-1?Q?wr/9qYPlfAXjD/RHweikjiYLxJqcKnRUcMctz7g0d1JikAh58UF4s8oEPm?=
 =?iso-8859-1?Q?nuqaztBTd3j9elygzWfEenSkSSHUzY2zvhuYZQUh9CD1BBafIUzkhWY3aO?=
 =?iso-8859-1?Q?qOPOuFNWNVMZZOJVoEssIMs3VBHS17GM703NxSlFPbQw/CtYLK5BxwUzHt?=
 =?iso-8859-1?Q?kIxboXO+ADEFCnGPXkU+DytG3nKabGRHhNAjesEmnDZ2iWGxngh3sZjrkW?=
 =?iso-8859-1?Q?kA45KZWfPbl+P5s5uG2M9iGFhdbr3mbmskhKnprpGPAKgZsZ8NcZjHTUZV?=
 =?iso-8859-1?Q?dy1L8utxpY6JjDxZUvZL4fNTXLsGPRqI2srme+o+m31JMxBhk8aIuuThbk?=
 =?iso-8859-1?Q?TFId/ePWui9NPXMi8oJnj4xVzzMkmcOf3SHk/MiIUhamqdZ+51fAR323im?=
 =?iso-8859-1?Q?S4SWqsiNsN1XcaFVGwf0BYnxKZc8lFgUZK0EBbuJiYYMbkUboZWYvj0zA1?=
 =?iso-8859-1?Q?YEEs05MuoqOgWZhOJHMAfqne1gSGgwpgnciYYxy5GfghOhCUVyUnnOK5Tu?=
 =?iso-8859-1?Q?mC+WWYQGPQI+t2spT48eYCS09c9BPY7CUMpBaohwjoo2aGwAkA2Or0f7w6?=
 =?iso-8859-1?Q?0V2r13ki5xHJ/uy4W/O74LsgScFlVvd3uCZQhyUTFa0DtxYbUU6DsFJ089?=
 =?iso-8859-1?Q?tADw98r+yqRggEf39x/+6vNG6NlF0BsHpWcMMu10Ol1RtSwluT/u3XUU9P?=
 =?iso-8859-1?Q?6ZI5E3lorRPnuPDT1aN6o3dg3xx7X6OjkNzsHQ3+9JYft0RuzPgIMIt8uS?=
 =?iso-8859-1?Q?oAUsk4xN9Z8jLoBQ0L8dIlYPG2Jw1K3pIGLQPyyQ1IUxIYsVWY7GAvC+SL?=
 =?iso-8859-1?Q?g7Bnh2ccHRkSdu7VXwbD3+PEm7DL/o8ZY1SeY3MSrRHAWHRR2kQeAi4+Ae?=
 =?iso-8859-1?Q?ChtprGKRgK7iiclestIPT1M+1IHb718BzKpJlGU2MKHGSOoE7ec9PyBRjd?=
 =?iso-8859-1?Q?PM3NIzP/lLQYn6NfeD84USkblydmZwL3ODv3t1Bp+BP9CnUXMZydJLwTzM?=
 =?iso-8859-1?Q?rzucoVkkTDWL2IoAzzVPHAz7JJYibVEYWB1KsZo5CO4yBj/aJMRM4wk67k?=
 =?iso-8859-1?Q?Un6Ym3bX2w=3D=3D?=
X-Exchange-RoutingPolicyChecked: f26E7fw++m2zwoCIDMGn18gVCXrRvnCO5LWcFykFOf6Un9of8qgIOHVf91r2eYUjgG9Rzc+Qullqtgjd3Olbbl1f8c4buJxPfQX7d/cSv7qwPIMrwHivRmAE27+idGgedi74K2EGgq7pAgUH+0zslLI7g/jqmPkzBz5fSo1fFj6k9Zir9UQbmEIu/W5JlnRE9Un4PzIaPT9OErx20P2oLaEu3gsZLr+ejOquQroXF3mYZOazpACgx83EaXcOfjwnAOJmeG9LYVia28wyMn3LoqrR8d+dkjXEHNA+5TNCSJ1eX2tgCKQW8GBtQKDMf2RPzgEyaHyBbnMS/+KPI1Rk0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1ef32e-091e-4700-af35-08df4a676a3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:13:33.6515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzLjSNf0rYjSeN93NGPEb+sO8NKcL0/XVLWf4E4D0//rp0kLy0brjMBOwv/sZfi+Gp1pH4NJ/3IF6fsf5+DBxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
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

On Sun, Nov 08, 2026 at 05:10:30PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:07PM -0700, Matthew Brost wrote:
> > Add observability for the page defragmentation worker.
> > 
> > Introduce four primary-GT statistics counters: defrag_added_count
> > (BOs queued onto the defrag list after being backed at a sub-optimal
> > page order), defrag_success_count (BOs fully re-backed at the beneficial
> > order), defrag_partial_success_count (BOs only partially re-backed at the
> > beneficial order) defrag_failed_count (attempts that failed and left the
> > BO on its original backing) and defrag_mb_moved. The
> > ineligible/already-removed fast path is intentionally not counted as
> > either success or failure.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_bo.c             | 18 +++++++++++++++++-
> > drivers/gpu/drm/xe/xe_gt_stats.c       |  5 +++++
> > drivers/gpu/drm/xe/xe_gt_stats_types.h | 17 +++++++++++++++++
> > 3 files changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 907cfa57481f..073d926ef9ac 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -26,6 +26,7 @@
> > #include "xe_dma_buf.h"
> > #include "xe_drm_client.h"
> > #include "xe_ggtt.h"
> > +#include "xe_gt_stats.h"
> > #include "xe_map.h"
> > #include "xe_migrate.h"
> > #include "xe_pat.h"
> > @@ -1160,6 +1161,8 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
> > 				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> > 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
> > 			atomic_inc(&xe->mem.defrag.count);
> > +			xe_gt_stats_incr(xe_root_mmio_gt(xe),
> > +					 XE_GT_STATS_ID_DEFRAG_ADDED_COUNT, 1);
> 
> Assisted-by: LLM
> 

Yes.

> I am not sure if ADDED_COUNT is much helpful here. But BOs added here can get silently
> dropped. Also, a silently dropped BO can get re-added.
> 

That is in fact true and if you run the xe_defrag IGT this happens a
lot. I personally find this one useful and so has the ALOS team.

> Perhaps a better count would be a 'defrag_pending byte guage'? Also, probably make it
> not-resettable so that it gives the current state of fragmentation.
> 

I think for something like that debugfs would be the better choice
rather than GT stats - e.g., Take spin_lock walk the defrag list and
which shows the current state. This is a different patch though but
probably worth adding.

> > 		}
> > 	}
> > 
> > @@ -1274,8 +1277,21 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> > 	xe_dbg(xe, "Defrag attempt on BO size=%zu: ret=%pe consumed=%llu\n",
> > 	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
> > 
> > -	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
> > +	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm)) {
> > 		*needs_more = true;
> > +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> > +				 XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
> > +				 1);
> > +	} else {
> > +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> > +				 ret ? XE_GT_STATS_ID_DEFRAG_FAILED_COUNT :
> > +				       XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT, 1);
> > +	}
> > +
> > +	if (!ret)
> > +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> > +				 XE_GT_STATS_ID_DEFRAG_MB_MOVED,
> > +				 *consumed >> 20);
> 
> This will truncate the size which can accumulate over multiple BOs and the size
> here will be significantly off from real size that is moved.
> 

I'm not following. Consumed is the number of newly pruned bytes, thus
the total number of bytes copied on the migrate queue. A single BO can
prune in anywhere from 2M to DRM_XE_BO_DEFRAG_SIZE_LIMIT per
xe_bo_defrag_one call when !ret is true.

I use these stats all the time and they seem accurate.

> > 
> > unlock:
> > 	xe_bo_unlock(bo);
> > diff --git a/drivers/gpu/drm/xe/xe_gt_stats.c b/drivers/gpu/drm/xe/xe_gt_stats.c
> > index 789397514f3e..68e60d9500c8 100644
> > --- a/drivers/gpu/drm/xe/xe_gt_stats.c
> > +++ b/drivers/gpu/drm/xe/xe_gt_stats.c
> > @@ -154,6 +154,11 @@ static const char *const stat_description[__XE_GT_STATS_NUM_IDS] = {
> > 	DEF_STAT_STR(PRL_2M_ENTRY_COUNT, "prl_2m_entry_count"),
> > 	DEF_STAT_STR(PRL_ISSUED_COUNT, "prl_issued_count"),
> > 	DEF_STAT_STR(PRL_ABORTED_COUNT, "prl_aborted_count"),
> > +	DEF_STAT_STR(DEFRAG_ADDED_COUNT, "defrag_added_count"),
> > +	DEF_STAT_STR(DEFRAG_SUCCESS_COUNT, "defrag_success_count"),
> > +	DEF_STAT_STR(DEFRAG_PARTIAL_SUCCESS_COUNT, "defrag_partial_success_count"),
> > +	DEF_STAT_STR(DEFRAG_FAILED_COUNT, "defrag_failed_count"),
> > +	DEF_STAT_STR(DEFRAG_MB_MOVED, "defrag_mb_moved"),
> > };
> > 
> > /**
> > diff --git a/drivers/gpu/drm/xe/xe_gt_stats_types.h b/drivers/gpu/drm/xe/xe_gt_stats_types.h
> > index 425491bed6c4..c42b494390f8 100644
> > --- a/drivers/gpu/drm/xe/xe_gt_stats_types.h
> > +++ b/drivers/gpu/drm/xe/xe_gt_stats_types.h
> > @@ -122,6 +122,18 @@
> >  * @XE_GT_STATS_ID_PRL_ABORTED_COUNT: Times the page reclaim process was
> >  *   aborted.
> >  *
> > + * @XE_GT_STATS_ID_DEFRAG_ADDED_COUNT: Times a buffer object was added to the
> > + *   page defragmentation list after being backed at a sub-optimal page order.
> > + * @XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT: Times the defrag worker successfully
> > + *   re-backed a buffer object at the beneficial page order.
> > + * @XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT: Times the defrag worker
> > + *   partially re-backed a buffer object at the beneficial page order.
> > + * @XE_GT_STATS_ID_DEFRAG_FAILED_COUNT: Times the defrag worker failed to
> > + *   re-back a buffer object at the beneficial page order.
> > + * @XE_GT_STATS_ID_DEFRAG_MB_MOVED: Data (MiB) actually (re)allocated while
> > + *   re-backing buffer objects at the beneficial page order. Chunks borrowed
> > + *   from the old backing for free are not counted.
> > + *
> 
> NIT...all GTs applied to root GT, which is fine, but probably update stats documentation?
> 

Yes, let me add that.

> >  * @__XE_GT_STATS_NUM_IDS: Number of valid IDs; not a real counter.
> >  *
> >  * See Documentation/gpu/xe/xe_gt_stats.rst.
> > @@ -181,6 +193,11 @@ enum xe_gt_stats_id {
> > 	XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT,
> > 	XE_GT_STATS_ID_PRL_ISSUED_COUNT,
> > 	XE_GT_STATS_ID_PRL_ABORTED_COUNT,
> > +	XE_GT_STATS_ID_DEFRAG_ADDED_COUNT,
> > +	XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT,
> > +	XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
> > +	XE_GT_STATS_ID_DEFRAG_FAILED_COUNT,
> > +	XE_GT_STATS_ID_DEFRAG_MB_MOVED,
> 
> NIT...Few other counts that might be helpful are,
> - defrag failure reason (DEFRAG_FAILED_BUSY/ENOMEM)

I practice ENOMEM is really the way it can fail (e.g., we ask the core
for 2M page with aggresive reclaim flags and it fails). So not sure if
this is really useful.

> - time cost of defrag (DEFRAG_US)

This is tricky one. What would DEFRAG_US measure here? The time to
allocate memory (e.g., reclaim time), the time to prune in memory under
dma-resv, or the copy job time?

You can figure out all the above via ftrace and that how I profiled /
tuned the implementation + how I believe the ALOS team if proving this
works / tuning Kconfig options so we don't miss page flips on a defrag.

> - 'removed_without_defrag' so that 'MB_MOVED + removed_without_defrag + defrag_pending'
>   is the total suboptimal size added to defrag list.

Removed without a defrag is probably useful and perhaps a total of
suboptimal bytes added could be helpful too. Let me add those.

Matt

> 
> Niranjana
> 
> > 	/* must be the last entry */
> > 	__XE_GT_STATS_NUM_IDS,
> > };
> > -- 
> > 2.34.1
> > 
