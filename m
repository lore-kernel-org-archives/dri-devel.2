Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8847FC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A429610E192;
	Tue, 25 Aug 2026 11:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eLUdp6dO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D180410E192
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787657944; x=1819193944;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ug/MiE+Vjb9CAzVaVUDfOxyCs4kNGZSEqVSl/AwJuao=;
 b=eLUdp6dObqNkfRepBltnGEeHV2w2umx6wVmU20CRaVR4fqvS/HdyFRAk
 tLU+rgr07fB9ZDsrgcpg54jEEXhDFTKyFczF08ZnlU4wzBiLI50W1Kl0v
 D58u+le66y9RB0TSgfBmYSVlbn5oSP+42JdAm58HJ6DWr6bFaJnj0H0jp
 c9BSd5sFEZTqhXlocPAIT+F4ySwoSTjvyf/OtMYz92b7IeLFVtL2yePXM
 SlJZ0sbjGnP/dskJyorx6tDE1J3XGYX3H+Ei+jwC1378b1uE0E8T/QALK
 wQvUGh2SbPGjiu+Yyv8F20CukWnEsgy7SFm/MNzA/HndIO01My9dDQSCk w==;
X-CSE-ConnectionGUID: dyGDsiWBQzuIMoPcAqPXoA==
X-CSE-MsgGUID: xrqfJd5STLCCxx8UMJPrMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88144142"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88144142"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 04:32:40 -0700
X-CSE-ConnectionGUID: qCKS26TGSAerB1rq+MtXug==
X-CSE-MsgGUID: 5+qjnVQoQ+Stlk19h26I1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="267305568"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 04:32:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 04:32:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 04:32:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 04:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcp9t2g2zUsI9BcUiAmOoRFbgQAV5GU8/I7a42FWfKvU3AyztQbsTnUZ/au2gO94no3bAVRWegMceG1/sjcgGbtvcJkMHXDUuGuQznjHnXrYqHIKpL6rrKkHzM+XGMGuz6Y77nQYs3Ab99NwJwDLF3R3R1HqglApNtUdEyz0laOSbk/dA7b20OdcxfcrCUR0eGbVXBBm/mFdVTNLe/jIY/30PD29lHeVM8UKTVqiybZzW/i9iDMJ/DKMwFc0tgMvED32KdOsukvFWWuw8F5RsNE1xNZIVH9EQj4a0VIBUnvclNLCNqugFLRBI/l+jcRfojnPG5S6Nmn1tcaIY9hloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgFFOkXx9pGnbugaSza/J1HyFayPAYUZyeDRwNlVudA=;
 b=S35IFiIcQTz1SrM9dAMOYN52r0qDV2GDY+yWLySu3E2f+xg9L+9VKD7KuSV21WN+PaNv23pD+6PU2XNFrgEgZLfpA2rjoWWBJ8766eoQGY4B3/MJntIZuX59OGoVhaAS3XM/7PrKEvnF1JVscU4inYU0IBsor53gl40YulezGY7uaJOVERG4lkI3Oz5Uttd88UEPZxd71KjY/PDpjoPeng1l/dYatJXQR/E3YzKHCIdNTqH9/YrMLjyv5Jt9XOtA+IB/5c+U8lX0eDqkGztlSfJdT1CgzVwAfxculglA5AyQy+VxdQaLpkH7wg66KkXONxzbFzBZc4oYAWKsyGAhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 11:32:31 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 11:32:31 +0000
Date: Tue, 25 Aug 2026 13:32:18 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Maarten Lankhorst <dev@lankhorst.se>, "Andi
 Shyti" <andi.shyti@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
Message-ID: <ao1hIejAdBPKUHFW@kniemiec-mobl1>
References: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
X-ClientProxiedBy: DU7PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::17) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: 92af4ab6-54f8-41de-b055-08df029c8ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CFNdLgBNrzx4sfZYp506W9ZmjdbeMNvvuh696WFCAAJa/7dJAKyyhQakdWmXKZDpP6Ksx2HdHygYQmxPCHSQJtr9A++mvRdj2r7nw0zv5IVzMvQeVz8e8p5Ta2/DbgvZdyi8vxzcC0slOtylDQPAne9ZDA9y+vxtbndNqe+E9+lZ+MB0zf6zULyVFVnr2+wT8/NujDAFNDOESvveTdveTRszEvg9nPehuXEkNZ0/hgglXW/FR9UzCL6nSNud2mQk0rHByoCAi/t6NnXslywU4XWKFDC9WABgePrBpX0/EVP8CSDWRDejCuGWFcDULlA+eqIkqIOrSVWxq0bcfWC2Zp3+c+Qk2ortfQlpA74mCJnh2dFYcl8C9E/x6CLNpXBYVYanQZFr8eaJaw5F2Cc6aqtNvhj23S9c7jwiz4Ac1kUzHYvYxGcdLO8n0Bgwlz+qPwxP0svuPL5vLxgniGDK77JcQ9wbiRPGSNfFFyoFgzTL6XoM77DRYCbFMF364ny0XH5vqgkG/03bMaFSUjeFRACTQg8n0C4GXcLJeAZpDYRtWVD05zsxq1DPOxqDKUgE1HSQ5dngmuvjjAS1Tme+9wrm3Zf5gQqdyNUEPweU6Tlqi+Fzms6oqvUYy+WDPfPtTOx/xU1YiBlguPGm5DhnNXq1/4sAm6kX4grLlHTwelY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3IrU0cwQ25ha3VVMk5KOEJCb0VGV013VU5zL0UxZTNsWjljb3pibkFES1lM?=
 =?utf-8?B?Q001bUlwNVdka1c3UzlnN3BocVhMM2w1R3lWQm1WbzlaSU9YTldLcTRjaUFY?=
 =?utf-8?B?b3NBMDlIaWRZbFdDK1hpa3dnd3pyZ1c1VWcxL3dzYk1yM0prNERIampjeEwy?=
 =?utf-8?B?bTlTNUtOY2pMbWxBa3hWSWNYRjNtdmVuMmt2azRjcFF0ZlV3NHc4a29iM1hC?=
 =?utf-8?B?K3JEQXN6R3IwL0Q0cVd0UnhJTUZONHBPYjNMSFdHTVhMemJ1cGtHWDZPa1Zk?=
 =?utf-8?B?RXlPQUR0MXBXZVl3K3B1aXV4dWY4SlBsUHFKUmtBOWlxa0xvUmI4TVRGU0Z4?=
 =?utf-8?B?VWFZcmRCQnByaVIrZ01ZVnVVTTVQM1FWQVdzdXo5K2lJZ2oxelVVM2VRMXY0?=
 =?utf-8?B?RHBZUy9KNk9GNUdqVFVuVnl6L2I4d0RnUDhDK2hxNFVNdC8xNDNXYUg3RWVt?=
 =?utf-8?B?M0FyL213NkZTekp1UUpiRWhBcVk3THhHcE1XQWpla0dheG5XNU1MWUo1dFB1?=
 =?utf-8?B?bDIwd0lPakhZZFk0bXZSWFExK1FRZlZ5ZmpGeTJib0F0bWdTK2V6UGF3Ri8x?=
 =?utf-8?B?UzBwME5RMGRzMVFoQWFtdmFLbitqUnBjemRyZGF5T0lJSWZrNTRqc1AyN2gr?=
 =?utf-8?B?RFJYVm5hR3lYSE1HckxGLzBuSXhjV01yTGNnRnNaN0VkYjdHL3RzUDR4Vk1O?=
 =?utf-8?B?NGpoVWRWYUNqdlAyYTZMcGthLzQwc2ZTK0VLWEtDSWFhOWdtbWRzRWZzZXBt?=
 =?utf-8?B?WHBXcS9RbWZadU5CanFvUWRodkg2TWVhck1qeTNNU2d5eTNsNkQ5T1FkbWRG?=
 =?utf-8?B?bHk1b2YvUzJWVjN2eFlNbE5tRS9xWXdjbzRlZHdPNEd1N0lqR3kvc3ZYNkZY?=
 =?utf-8?B?U1FiQVNWQlBYcnA4ek9TV3NjaFJQWk1FTDFuZzM2NFJoYUhhTGZac2o3SGJV?=
 =?utf-8?B?OFIvY1VrTmNnTHd1Y1BHSitqWmpIQlJmN0JyTnJPQ0MxdHV5aW0veEtQYnJJ?=
 =?utf-8?B?eUQzSWEzZ3hFTmhqUGo2Z21FTGVYVm9PWVludHhJNjdBbWUyZlovYXJmMlRX?=
 =?utf-8?B?bDJxTDBrQ2xhK2EvVng3T3BZSUM1eFhIeUZBZ0s5MkVXTUZDbFh5bEV6ZU05?=
 =?utf-8?B?TTczVUhQUXVpenAyTVFkNjB0dDFLakJ3MGpHTE9yOFRWT2drR3lUUmgrTWVI?=
 =?utf-8?B?Yk4vM1Y5bXpBUENuVEhTYWE3V2xnaTNhNDZtMEdiMlNkYlcrRXF0a0srVTUw?=
 =?utf-8?B?bDkvbTFpbDBNdzgxUTlGUkRLN21rZjNydE8vcDI3WTByM01mcmdnTHMvWmlv?=
 =?utf-8?B?UkpTT3BJT3Y3dVFiQUNhWXlqVnhaVnBDUjBJWUZzY3JpcURKbVdzQnpwSU5o?=
 =?utf-8?B?ek5iYjlGeUlXWU5xV3dLUDVacGtmcU42T0VTNTEzTjJzRVFhU0ZnZGlDcnAw?=
 =?utf-8?B?azV1RlhOOHljR3ZXMkp6K1QxVHFyUzNycEVFSkZySVo0L3dWVHo3OGdUUW9B?=
 =?utf-8?B?Y3FPUVJ0MW5vS2VKMFNLVXZuY3NIRGUydUFYdGs4emVvTGcrSjR0RFdWY0pq?=
 =?utf-8?B?dk1Wc0U4RDhRNVFTeExESkl0RmlIcExSTDNGUkVHZzhVOTVqeEhNcVQ5NWZU?=
 =?utf-8?B?aTdIdkxwWkN4dU5aZkd2RDRrekVWcmQxZlFBUFAzUFJjL0x6bUpvMkU1L2VE?=
 =?utf-8?B?Y0hUNis3Z1NEUytkQWovV0xLbElZQlpPdno4QzhkZFQ4S0o3Z2JoN053Ymg2?=
 =?utf-8?B?NzcreXJrVkRDZ05leVVtdWpOMnJKVTFSWEI0Qk1teSt5bHBlcjNab0xRV0l3?=
 =?utf-8?B?aXRHMmhaZWtIV0g1bVlIQXhhUGRVcklMK2NVMTVnM3pFRjhualF1Qk5sOTl4?=
 =?utf-8?B?MVhwcmVpeENMajAzMVRpYlM0a0REM0pITExzbHdZSzZSSkI5TjEvVWxxaEJj?=
 =?utf-8?B?SkRGc1phV1VXQWl2YVNzOGFNUWZ5alYydGVmN1ZDL0JucTFZWVJXL3A0bXll?=
 =?utf-8?B?V201bDdxVlE0QUFRMVVaOHJlU1RybDQ4ajJibkFZQmwyYlM3QWlwOVJsSWpS?=
 =?utf-8?B?L21SUHhQWnh3bEljR1FIWHRoZHJUMXFaUGNCRjJVZ3J5TU1TOHhQRzZTSEdT?=
 =?utf-8?B?WXNCZVpaMVFKcFhwZGx4TG9oWjV0cG4vOUEvTGpia1VUQWh0Lzk2em9HMEll?=
 =?utf-8?B?Mm51QkpVT05QYnA1b0pMaVB6bWExM2x5dWRLZEtSV21oeW5xZ3o2K3pzcHRS?=
 =?utf-8?B?RGdMVGo3TmFuamdSQ1JubjZ1SnB6aGtEQjN6WGVCWEhqSC83MnYwR0xwUEph?=
 =?utf-8?B?ZTJ2YkZWYzB1eEJ2cExQRHNRbERaWFNhT0RpZTRlenhPeFU2TW5YaFJUMnow?=
 =?utf-8?Q?vG8WMqUSiotQhNIg=3D?=
X-Exchange-RoutingPolicyChecked: XTcScJYx1e2ihsNs2GTOudLCORSnePYeGNCXCkQllh5bq5rO1qeDEHO4LFFhaPVVpHvFgSZOvoXPDGl9TBD4L8I3yFhEOt+PAhclCzCy/dvVptLkcOJb3QPd/j059pQ+nk4RtIuyElmYHNBzLuMrYrAD9zb13kA+pTsDkncbMmVfjyQEu/QGGYArORUM8n0R12UhhlohrQMkOJvHrFz7u9JJu4+gZg6jlUNypGN+q3ahWI1JW9FqKy7MGPnDR2kB4iUisiXRbZ5GjamxJRZAcOgPnjSvhh92wf6IYhjqfE34lSkQq3whLqfOaukX0S4S15HNcZSYybZ2u6oBQHWKaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92af4ab6-54f8-41de-b055-08df029c8ce8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:32:31.4982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUxu8oal/ycfNDcFtnWqrp0l+MNuTXKGYeByLIy3cvDS4fHg4EQxUDNws2ZJK+tbxbK09h7f6p+6DK5URUBFUn0zLpNTYqrm7GQaGEEUgU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
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

Hi Geert,

On 2026-08-24 at 17:12:30 +0200, Geert Uytterhoeven wrote:
> Enabling a (modular) test should not silently enable additional kernel
> functionality, as that may increase the attack vector for a product.
> 

What vector? What product, exactly? As far as I know buddy allocator code is
currently loaded when a) loading a drm driver (which would need that code
to function anyway) and/or b) loading the kunit test for the buddy allocator,
which would need that code to function anyway. And AFAIK neither are
built unconditionally into the kernel. So the amount of potential vuln
surface is not exposed beyond what is reasonably required for the system to
function as intended.

If you've found a concrete bug/exploit/"attack vector" utilizing buddy code,
then please address that directly.

> Fix this by reverting the select to a dependency.

The way drm kunit tests do it is by select-ing the appropriate
functionality out of the available ones, with "broad" depends-ons for
DRM and such (say "depends on DRM\n\n select DRM_BUDDY"). DRM_BUDDY,
for example, is not directly selectable in .config, as it's meant to be
selected automatically if a module uses it.

This is also the case for drivers, with Xe having depends on DRM and
then like 40 lines of selects for specific functionality, same for i915,
amdgpu, so on.

Now, my understanding is that GPU_BUDDY is also not meant to be selectable
directly by the user, but rather implicitly by modules that need it. It has
nothing that needs actual input from the end user/sysadmin, either a module
needs it and builds it, or it doesn't and it doesn't build it.

The only conditional code I could find depending on CONFIG_GPU_BUDDY is in
rust where the gpu and buddy modules are exposed in the kernel crate only if
the config is selected, but I'm pretty sure it's just how they handle what
we do in Makefiles for modules with obj-{CONFIG_SOMETHING}; and some renames
of variables/functions also for rust. But no behavioral changes depending
on GPU_BUDDY.

So I see no reason to enable the end user to select GPU_BUDDY or not, I'd
just let it be an implicit dependency. It's not really a big fat broad
option like CONFIG_DRM so I'd just treat it like one of those specific
functionality ones due to how similar it is to those.

Then Kconfig for tests has to "select" instead of "depends on" because
there's otherwise no way for it to load buddy, which it needs to function.

> Make sure the GPU
> buddy allocator can be tested without enabling another driver that uses
> DRM_BUDDY by making GPU_BUDDY visible if KUNIT is enabled.
> 

This was the case even without your patch, and was the entire point of
8fe3fc37564920ae mentioned in Fixes. The kunit test kernel can be built with
a rather minimal .kunitconfig (included in the gpu/tests directory). So
it only loads whatever kunit_tool would load, plus CONFIG_KUNIT, plus
CONFIG_GPU_BUDDY_KUNIT_TEST, plus (implicitly, which I discussed above)
CONFIG_GPU_BUDDY. It doesn't load DRM_BUDDY at all (which was the bug
being fixed in that commit, you used to be forced to load it, now you
aren't)

> The page based buddy allocator for GPU memory is only used by DRM.
> Hence add a dependency on DRM to GPU_BUDDY, to prevent asking the user
> about this code when configuring a kernel without DRM support.
> 

It seems to be *technically* true, however, the entire point of moving the
buddy allocator outside the DRM directory is to expose it to other non-DRM
drivers, so the lack of dependency is kind of by design.

The change was rather anticipatory, but it was clearly well reviewed and
sent by a Joel, a nova-core dev, I assume it's gonna be needed at least
by them at one point or another.

If, say, nova decides to use the "communal" buddy allocator (if it
doesn't do it already, I only briefly skimmed it looking for kernel::gpu)
then the DRM dependency from this patch would have to be reverted (yet
again). Maybe moving the buddy allocator up from DRM should have been done
along with the first non-DRM user and only then, but it just didn't go that
way.


If the issue is that this option is too annoying during make or in
menuconfig, then I don't think this is the way to address it.


> Fixes: 8fe3fc37564920ae ("gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
> index 3bcf08260d73a782..d881ab6f7a006a3b 100644
> --- a/drivers/gpu/Kconfig
> +++ b/drivers/gpu/Kconfig
> @@ -1,14 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  config GPU_BUDDY
> -       bool
> +       bool "Page based buddy allocator for GPU memory" if KUNIT
> +       depends on DRM || COMPILE_TEST

What's the justification for COMPILE_TEST here? It might be needed but
you didn't explain why or mention it in the patch description at all.

>         help
>           A page based buddy allocator for GPU memory.
>  
>  config GPU_BUDDY_KUNIT_TEST
>         tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> -       select GPU_BUDDY
> +       depends on GPU_BUDDY
>         default KUNIT_ALL_TESTS
>         help
>           KUnit tests for the GPU buddy allocator.
> -- 
> 2.43.0
> 

Thanks
Krzysztof
