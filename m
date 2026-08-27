Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB3EC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99D210E63C;
	Thu, 27 Aug 2026 10:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hnB4Rer3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567DC10E63C;
 Thu, 27 Aug 2026 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787827199; x=1819363199;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o2SXyh4UruzbJAdFS3iLu4gJ/02/RPEI4btxUUqgZ/I=;
 b=hnB4Rer3HGzN0hoeDAfSF109gDq21Y2JqClfQASOKgzxNNB7TaJbPXjT
 VCWFg3l/U4IF5AILaZrflBtUyvJ5Yx2Rj3VpygkvPNQIgYEopQyDZAisS
 zjA7dsm+9Mggb92Szzal4CDRDHoANaHzri3qXLe99W1p/MGDyJVYCP73S
 nKpmJHygqgVgA+pCsVmUVEJib+LvG56O2BD85eWm+nsdxETVyexCRJ4ss
 xiUkI+B5f2Ejnj/qFprgltBNdRr1r0OP79GLTay8TRQnQ9GGkYZEc0+2Z
 VbFOeps0XahxV7k2PrVwnfiG0phyydQKzX3pRJEPhl4eNcduLj9BDzjdm Q==;
X-CSE-ConnectionGUID: f208levgS0+5fk+dHoTkIQ==
X-CSE-MsgGUID: jjw09OCrQbSkrzPmj1wa2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="99841294"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="99841294"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:39:59 -0700
X-CSE-ConnectionGUID: 2C+Gp4O3RDyP3zIHQWRSvA==
X-CSE-MsgGUID: ZJZn/A0aTGe2lujdEV8Zrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="297723486"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:39:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 03:39:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 03:39:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 03:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDUJvrPCcCPnjs0s5pEgoBLybJvWBeHkjt/MKcLIjGtZCS2yjzigOSLxOpv1YsOMCWeAOnJTrdblMo8AlkwBJy0UXOYIx7Gg09oIfdCfIRtsioIZ2GTKsIwUISKZMH+s53y3FLIiwgWTKkdXnkP8j2ChfeoqDmxwNf+/j1d2+5XZqj3CP8kdVmh3woPOmFGqKxBMAykbxKUvsHc7anjVlR3q7llukwJZIeD7ewWm33ERikhljgL+hGhJxf9KZDpqPb4q4jbW6Wp4dsPX/GxwLPNJosSWniVOQBVmasXzcWCDYH110HFsy0FX+/XzMLTA6V6PfCin3MOraXGKbNs2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgt62EnVqR8Vh20Gt+eep9ZnPB5bWH725T0LfHjrLeE=;
 b=BTaizsV2UHXklw7ADnLC+EHqW+iQC+QGquK0p3GOR9Y93PtmsbCeeB5672zH8Z2xT3GQ9dyP+qo1UUYZqhzb2n1SVhpNel58bYF4oNu4yVij6+zcfUVX9oBTLRk9dSelVwkDu5Sg5RL3NIz1Zij/vCZ7DFLX3/NsqFPezgIthCIu1OCGVk+szMkunFGQKhVFASXCw9acmvycRK73G9YigNSJJpF2iPStjDCpTg1zHyqytql1QmOING0O1doOFDVmKuvvawBIBrvBD5NqSzZ/+Na6AmteeOcfRUu8eflB7tKRuio8hGOXDKSWwbtrcjyLsuH1zW2WLZ2slbvXwRJkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by SJ5PPF1170C8165.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::810) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 10:39:50 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::5a5c:9c7a:cd1d:d687]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::5a5c:9c7a:cd1d:d687%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 10:39:50 +0000
Message-ID: <be78bbde-0cc7-4be2-ad69-1801a8d73d48@intel.com>
Date: Thu, 27 Aug 2026 16:09:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/xe/irq: Always free requested IRQs on uninstall
To: Arvind Yadav <arvind.yadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-2-arvind.yadav@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20260827101801.1247654-2-arvind.yadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0356.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::12) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|SJ5PPF1170C8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b265dd2-c09e-474c-9f2f-08df04278542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EWhuv3oNOJQmen2Tyen258nO3/Sg109UFszH7DwK3NSAkWpHuPho2s7ZoFGSISliwaoRNb4dvNjIutp/AKeJuQKkltKM/ZXx0hHTxVwiCwRkeadqzMZ4kDT4elPQca+7iwnxqfdcbhVwQND6s39o8iP2P+W8wsOeNjpan42GTeXiWQrUVqaUaZ1vEvESALNNKBfEXF4Jd6TKNk0MvlXdCCSLxAdpo7g5AMkE9loNwhW1j1ID5l3xga8OMAkEJ4s6VLG9yPQmMkpx5asvvlYLhc0b/707kMu8oj/KQ1nu8iUVSbw2NlRGNH0pPd9iSLtgYFvTHJ2TKAnuA4afqrwk9ds9qO8DAId0wKUf0ly29r7uWEA9f7jjvrdWLTaBSeMv4Dxy6L4X7SZhBQkeBEe0L6sSANjX9NznEVvv4/wDEH7SWhc2pGsv968ItpYLL2geTdVDWMX8JBRa4uB4eBy9fCCqGXh9AwZTA9guv5ge8lcFNBsQBcJj00KT8ggiBIrZL0oc05xYLWhUQSHtbygI11h8tNzNyc8xOrt0TnukGDL1u06OxpqnU+2FVLLl2HNBEbEV6fd2mFhFpUDjG3mP3co6K8TKzUu5bCiFQ/JkCg7GlO/JC5KYq3ow+wAnYFnx4zwmieHF5Rtwguc740Mu/7ZQOXUbsswYrfaLJN7H6Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF691668CDD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThDMDYrK0wxaVZUWThHN01OUGJOd3R0Q09YeGF0VldWSHRKa2tTYjAvV3da?=
 =?utf-8?B?a1J4OGg4T2VxQk1vZVhRNHRuV3pQUnhPTmJQR012VzNIQWt3Vm5yNnp3bXls?=
 =?utf-8?B?OThKLzhwckxiZmt1N1RhMlNnbDRvelhVTUttSmR6ZkdkUmNEcGg3V1l3TElk?=
 =?utf-8?B?dmdKRE13bWhEd1Joa3RlZFkxT216eXBLamd3Y3ozZGUyUWZVOUNFdHhDUFda?=
 =?utf-8?B?SUpqWHA4VXZReWl4UllROVAzbFdMdDZZdnR5cmdaQXFvakM3ZSsxZ0JnMWFj?=
 =?utf-8?B?dHJWcnBLaTEyeDB6VWhibUxBUGRhYUVwK1dmZU9DYThOODZRUUxqWDNQNCtT?=
 =?utf-8?B?ZTlMZy9MT2JFSXRITmU2S3hpc1VvYjYzUjJJRklZM0pES0lYSEhpMGdSWkFi?=
 =?utf-8?B?d1F6elU5N2ZzaG4rMHZtZFc0OHBKRTYwWko3ZStlZUpFcGVPZlVLRHNkUlZv?=
 =?utf-8?B?ZU4rdG5xeVJ3RVhXR05xM1RObHJFRHNtem41clp2ZytjZ2JYQ01MNjQ4SkZo?=
 =?utf-8?B?UUYvekRiMDJ0TlJnS3RKSi92VUZvbzFab0lWVzZpUEd4eU1UckU1N21KQXlH?=
 =?utf-8?B?RXptYUJPWmtiOHdsTEpiRnB5MzMwMStVZWNaeTUrZ21sbEp3TXdtdm0vZ2tO?=
 =?utf-8?B?Snd6TC9VajJOQ0JVVi9mRXMvOXNxYnpDbVNDMk51QitTUXlHUDVGYUhKaFRY?=
 =?utf-8?B?TUJJVldLbWNjcVdIbk11elVDK3JHRkRLTkgwN2RuK1dMZTdMejZMVFFRQnU0?=
 =?utf-8?B?TUJrUSt5ZWZUS2hLbW9JODNRUzZreU01OUJTdkQ3VHhwbDBsU1ZOd0FCWUxt?=
 =?utf-8?B?T1NnNnk5Q3gxOHFpdUEybE9CZlZ4eStPVWViVUlNQSs3bFNhTnlZeGJDeWIv?=
 =?utf-8?B?cW5KQzdQYjJxbmtYUEFyejNYTmlNbXh5YWZjMEFNZVpmYWQvRzVtaXZneml2?=
 =?utf-8?B?b3BEcDVvTDhWT0Q3NWxSQlNaZDNQaVVpVWg0cVZXMVQrODIzK1JraVBjdjRj?=
 =?utf-8?B?KzhnVCtEWjIyamlrb2x0WW42Ry9lUW91NkhhL2w0VkxyQy82L1NNSUp2U1M5?=
 =?utf-8?B?dk9PNCsvZjhLLzAzdUgxbnFEYzJqNWNHaEhCWk5hZE5ybTFUQm9YSDA4QzFB?=
 =?utf-8?B?Z0lkOU1ab1hISjBzNkdyNExGbkR6Z0ZJZVR0cHNaUW9laVFvY3VoQ0lCRXpM?=
 =?utf-8?B?R1RzZS9VeGxjL2x1SGNuVThJTGFGS09BQWpTenNqZUQrNXNjaU1aQkU5RXZX?=
 =?utf-8?B?cHlyeVgzTWFBK2tGWm44N3cvc1M4aDdDeHBycnBNNlhWRnVXRjVNWU9mT2hW?=
 =?utf-8?B?MUlPbTFRMG5aUUJEKzAzaW1tNXlNaDRsdXVwbElDaEJ2QWZ1TlB4b1d2NTNq?=
 =?utf-8?B?UnJneDNkTUYwUkFPRGRjMVdqelZvTmdSSnJTSkkxRTVhUm55OHlUcW0zcGYx?=
 =?utf-8?B?Z2lNQ1diSk9KRm9EdGhPMjFxbkdvckw5TkpmM3NXemtXMlkzMG5PczJ2RmI3?=
 =?utf-8?B?VGdPWDZid3ZqU0hkeEdvT002TWFpUi9WYjBkUHlBT3VOZ1VjVkc3dGFoVmZR?=
 =?utf-8?B?QThFL3VzemN3REtVQmhnTmJFYStkRjh6UWI0SVNLQUVJRFhyREwrMnhlaFlT?=
 =?utf-8?B?NlB6aGNsQ3hEN01MSWErNTgyVUVaZmVyMTBjTExMV2Q4NXB1akdTeEVGdzE4?=
 =?utf-8?B?dk1MbFRwM1dFVlhDQzdzOXpxaGErUGpIYmhWdW5hZDYyVk4vdHluVE5MME9m?=
 =?utf-8?B?NlE3Y3FrdjJtWWcwVXQyczdtTlg3UlFNbUJHTk1KOXY4bURBMjJHdDFCTng3?=
 =?utf-8?B?dHJ6RUNVdHErdWwza0xsN3RGNWdxcEVMRXRnWVhaUHpBcWxPaVc2ZFI2NlJ3?=
 =?utf-8?B?bnMwUkVKTllRU1NkMlozVHpQRUJXa3lzNlV6eG56eGpKVHdOZFJzNjV6U3U1?=
 =?utf-8?B?eFYvMFVBR0k1VXdYbWJ3VG56RDdPMm1EcEZFdzdNOXB1U1N5ZnZ1QW1vRVZu?=
 =?utf-8?B?b0VUTTA5Zkg3VlRmSnFrTG5YNjk3UzVXUW9jNFZSdUdzVCtaeUJVWUdwZ3RV?=
 =?utf-8?B?Q0UrNUF5di9maFFaMUU2UW9Za1piNjBpcXBJRlBoUklhZVMzMG5SNHdhQlV0?=
 =?utf-8?B?a3FsbXJWOHA3Y0FvMGppU3kwRGlPTEhqYzVnQzUxdHU5WTRMZzZRdUJyUUQ1?=
 =?utf-8?B?aGZoUHIvN1l1d2NRMkRNb1o2NVgwREx2bjZwQ3dSelplNUxvczRlci9CUm9Z?=
 =?utf-8?B?cVQ3VitWdFRaeTBrZ05IdVRxK0hvbzlHb0VzZ2d0bVNXVkVIUUN6TEVWdGxn?=
 =?utf-8?B?eWJrV3hZekhoVCtYUnFDd1pwSzFpVlpUcG1UVmxQY1hkNUJhY2o0UEpXTzVS?=
 =?utf-8?Q?VC7FM+f1HCWve0bs=3D?=
X-Exchange-RoutingPolicyChecked: gpjz43sH2saZ1ak26mWXIPoRN/iV2U8Y+5zV0imaT+w8KRxHBVskkN2rp6iFxnjbViS+yFV/3iC+xTs9B/52SGUR1hwIDLLtrb8gw1ibl4bOTXXEuOrqgslvAH3OdRrpkuyeqhCE6m4Qw9lq2TdOOy6Bzr5u97BuYBEF4UG/Hpi63QDEZHyroPoNcdiq3clqlQyyJlS3nPduLJlKf82qGu+UQ3CZ39ys/MNEhkaG4MxwEH0MwyqnlzhajIaezTg25idJ95kwydwXR8Am0z5ohgGA898OosYBIVAOZpDRCII5RCZvKyZYIEJvPOH1YLhdRKPdJm4H6rzQMghSpIzgEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b265dd2-c09e-474c-9f2f-08df04278542
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 10:39:49.9356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqZw5BjcHPFNJCnzncYTHCB7SfdU164atGvdkOxJGMG87j7yKXuNuLQbvkpUNMcn4SSFwIRDV7riKwfEqOnK+c0hzuGNQTCnn3vQFV5nCnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1170C8165
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



On 27-08-2026 15:47, Arvind Yadav wrote:
> xe_irq_suspend() clears irq.enabled after disabling and synchronizing the
> interrupts. irq_uninstall() currently returns when that flag is clear, so
> a suspended device can skip free_irq() during teardown.
> 
> The managed uninstall action is registered only after the IRQ request
> succeeds. Reset the interrupt registers only when interrupts are still
> enabled, but always free the requested IRQs.
> 
> Fixes: 4d79a1266d4c ("drm/xe: Make irq enabled flag atomic")

Fixes seems incorrect, the early return was even before the change.

> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_irq.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> index 9e49e2241da4..d314993b14a1 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -786,10 +786,8 @@ static void irq_uninstall(void *arg)
>   {
>   	struct xe_device *xe = arg;
>   
> -	if (!atomic_xchg(&xe->irq.enabled, 0))
> -		return;
> -
> -	xe_irq_reset(xe);
> +	if (atomic_xchg(&xe->irq.enabled, 0))
> +		xe_irq_reset(xe);

Patch looks correct. With correct fixes-tag:

Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>


>   
>   	if (xe_device_has_msix(xe))
>   		xe_irq_msix_free(xe);

