Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCECC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC40310ED9D;
	Wed,  2 Sep 2026 09:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IpPIuJd0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F35E10EAAB;
 Wed,  2 Sep 2026 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788342888; x=1819878888;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+UvqlXiWNmIu2B6l7QmPXPY4I6zyAqlCtD9F0J4ao6g=;
 b=IpPIuJd058dCVb05s1V4egzAZ+B85yXEWhESJQP9xhc/MbNUemIOmp+P
 eL8ERHWFPJaM3Epr0YNUaEi0s/O8WcaLNh7z+Dug9yA3NFIA1f8dp9wg4
 OHgHcPGQrFHFniF6D/LT9f+zxJbWJt8D3vVW4z2CWmdmK7r4nluprXkTK
 y+zVhw8stj3oZwXxFKd5QY3lM2jAtXYC1WPjjlWGnA8T0Sx+5pSPHOX4V
 qp7C1Q64TCaX25t6GKbjVlrCnja7QeIE/oYYJyC7m488VprjexQyfDJ0D
 aVURn4jF2sxcPdIugP1PhFn21SRDjDP75LvGmCO43bRrzPgd1//P+Uvhs Q==;
X-CSE-ConnectionGUID: dPww1pBPRf+AXHTiGuESBQ==
X-CSE-MsgGUID: EPfJnlmQQFman0x2CxcFfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99394287"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="99394287"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:54:48 -0700
X-CSE-ConnectionGUID: 0I3eLWyHQPalO0jmuMYegw==
X-CSE-MsgGUID: GGCZ5QmQTaukAZasMUQuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="271329403"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:54:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 02:54:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 02:54:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 02:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9MOyV8Fmq3wKAGTCg77BrOzB+eNufj+IEj/tzZjFjvLVonMry6qJfeYiasX1ozluek7yLYv7pTZ+ll6E2n4qoOzKKiZ653e0G6aM9M6o7Vcd0sDLmFg4U8QCaAGElfeuYSRYnH8BhBDLioF8kWvfM3N9NnTUt/DM1UMlnm1KngXJ0nzwXDbAhzMvi7VvluJOl/0EvvasYBoDki+RO+c9BXp7FxO9dFMaQkOpYbWrPPHkL5f0QNG3cEhmq2t3cm/pJ8u/csOiSi2UMBG20yP4ErBLgp7axHgH+mFYlwdcYy1W2dCRgukHR32hR0ReXZbfrKSHWCQUCDfbKZyFERQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJbNhTV08e4gevrPh1D+5AmwRmAFwQ7nSXGmukqyza4=;
 b=Amwt3NhVm0PsEaxmp96li6KArXolOBMAY2X49laPzm20g8kZ3RlmlV5Z8CdLEawPss8qT/B2o5dmZwyQQ/EJQcGRUDIF4tZ1fXvoZjNH5ZycM8iuo+0x2WIN+7qH9qccgsXBoGLeswJADqGs9V3C5oVutDljW3At4F6qCYfXvQT6uQ419iM/dePpqmDazcUjyEfhtCVOP3QMf2VNbxbWm/4UObhbVJ/5o1mglbI9Fpgc5Td7Jl08+QQE/hGbhnExHiyrqsUQtp2083m2zFw6vHSwE1yL+lMMqqTvl2cD6WS/n/bq/cqk5W8CUO0RCChbm8s1zDynZIk0vxV+vjwevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:54:37 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:54:37 +0000
Date: Wed, 2 Sep 2026 11:54:28 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti
 <andi.shyti@linux.intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 <dri-devel@lists.freedesktop.org>, <igt-dev@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915/selftests: Wait longer for request to start
Message-ID: <apfrVeVRjese772i@kniemiec-mobl1>
References: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
X-ClientProxiedBy: DU7PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::17) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a0ecef-1543-45ef-e0ad-08df08d832eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SIGcDoTyCprmm2jGaIRRloLvNcjia64JL9K4hwDWLzqqn7UfWsCvOapOBLGWRkxcZSmu5h0cMw3NGQP8CuljZ/E83jI9iGZ374Lk/A9ZQV5LtV9W2ohkJ1E+ErsMotdLQ2HoIM3guopN5Kno1yJy7tVOzU4jvYAwy1LSddpyB04cYOWZXWy6ZVqS1k+xJhABgJLISL+WOUsFt4McpO/JnvEG7ZxQpQBUqiR1AcxO0DWGs58CvCu0iPOphemej0VG6udIuzPdInOg5CfmaLkJZzwTLqjqBX45TtWcu53atVoFfO510q2pptX7fKYN/FJadYDpjChhhn4Z2vluuIivzKodBpzJymMu/sWyl5Bi0qZvOYhKXb0RB4ZvQNx5l4OEaU/UA4sssSZPKTPr/j3CLMZFlmpT505ZQZIyp2ztQkO02X8sATzTxxd9JCggB3Yy73Z4scuLQnUCFWnZiZ5wKa0ZGiE/DVAZ0sN8VK9JAFk+oDTfpLRmzYpGOzcMdDZChEdjB7HkKwm10x9ZJB2dqdyE10naFJrOCYt1KasW3XAeL/G//vOrxkeG8AWTdiqlcHYbjiFbJCa9y8nmpStua5yddkEJ5iCaY35wy5bPOMk/IUe9NM5aQ4r/KNx035CwRiadk314ExWbac32Y7nSCJLRcv6quSy0KUx8XQ3Rj88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVplNjVRUHZBM0IyUDdVUmFOYVJmT0lwei9zZEpoT01odXZmNFp0UUJvdVA3?=
 =?utf-8?B?OE9oZWZYdDBtcjYyZXkwbGp5TEd5ZDJyQlFSUWZpaUljWGVLdWdkU0xmbkh3?=
 =?utf-8?B?eUJ3ME9Ca3dRaGhvb1N3RDVVc21aaW9TRTVpMHRJTUtyYndvTHp5NWVKUnor?=
 =?utf-8?B?Y3c5RU9nRXNHUmxCQkQxdnhLeldWUzNYdFBZZ0JjSDNzUjd3c3I1MG1wL282?=
 =?utf-8?B?bXF4RDU2WjFsdVYvS1ltL2hjenQ5MWlJbXJxbFBVOEx3SklyTklYQ1ZMQXJm?=
 =?utf-8?B?WTZaeWp3NDhBNCtTQm5QZ25yckZhOUpOc0FybFVOU25oNG5lWEMrSitHaU1M?=
 =?utf-8?B?TkYzM3EvRWM1enlrUjhhbTBhWGhSZnJMWEZZRXk3R1RPQWdNdkdtaDFULzBu?=
 =?utf-8?B?MDZhZ3dObzdjYnVCOURkR3RWd2w2MlJQdFpNR3htVG1RWXJQeEtCZzhVTlo5?=
 =?utf-8?B?b280MDVGZ1lCQmdtWmo2YVBOcVN1MCtvWStzdXorVVpHblVKb2puVFFOdW0w?=
 =?utf-8?B?SzY4TGp4Z2xxK0IxMjZrMmk0eHFhd1FDTmw5SjRQaldoTUxUTVRJaFdlcVVz?=
 =?utf-8?B?bmdUY2hESGdXbDBKVExRalR3NmlXTzRwOHlzWnRJK2NPa3JySmFtOTRWVDdq?=
 =?utf-8?B?NTZHeC83WE11VmFFaEg5YVEwM3VKcjAxRjJ3bFV5N2hqWkVEMVYwUW5TeVZS?=
 =?utf-8?B?Nm4va1grb0F4ZDRTaEdRVFBxUFpoZzVvd2dYT0oxK3g3VTFsU0g3MUg3M0ZV?=
 =?utf-8?B?RURLY282ZUFKRFdZVHMyVFlQV2NQZnhLaDVDNXVwM3dGdjRNT1R0Smt1Tlpm?=
 =?utf-8?B?NWdFVXV1ZGh6cGNFRVEvS0xNdGM5ekxYdFZTVjZTMkR1c0FacFkyWjdld2tu?=
 =?utf-8?B?NGNZR3RzMnZjZ2MwMjlZUEZDMk9ML2VzV3J3TmZpN0hGME4yU2g1bU5nZStX?=
 =?utf-8?B?WFU0VTZaY3ArdDBKR1JxRnNvVHJqV3U5RHBuTXlMQjRjUUF3Nld0RC9KdThz?=
 =?utf-8?B?RHBpeUhEYWFsTTQ4dmMvZVE5eEJPdThNVC8xbTBLZ0RybGRtVDlMU0ZiY1hn?=
 =?utf-8?B?S3ZWa2F2bFJyOC81bk5NSHRBYllCQlRpZjAwTVBEeEI1UHVJV1dmNW9tYVU2?=
 =?utf-8?B?MDZxSXVVclh5d3ZTbC9wVzdnOU16TUdTa21NbzRLTklkQUlYbWQrRE1BWWV6?=
 =?utf-8?B?djlwS1Q2K3hvUDFNOTNRVkZYVnFINU91cWYzVkMwNjRIeTJobzgyQ3hrSnVK?=
 =?utf-8?B?YWtqZDBpWUdYMFFhTFd3TmJLam1aZitOa2swTHF3WjcyWUlhb0JHQXFnNG93?=
 =?utf-8?B?cHpqU3Jtait2SE9BRzM1SmlCN3FNVzNiRHhhWklTa05MdkpZYVc0TnM3elNU?=
 =?utf-8?B?UTE4c0wzOFZNUm9qcXNVM2RrNDZoWlAvTjFBZUhpYUxoT0JybGFCemhCMG9R?=
 =?utf-8?B?Y2JDYW1vZC9IbTFyM1M2WnU1WHNSRGc4L0R4VWhhNi9xYWpIbUgxeXlDcjVQ?=
 =?utf-8?B?WnozYlV6cEsyQ3c1bUEwYnV3LysrRk90aUMxbklCOHN4Vy80ZDgwSEk1eTI0?=
 =?utf-8?B?Sk42SlA4ekc5WmdhZXFGc0p3ZWQwZHU1UzhCdzlmYllqUG9CZm9Cb2d0TE9M?=
 =?utf-8?B?STJZZVpEZmlENDI1TnpRLzgwUDlJTHE4RUtONFJJL204c0pucGhtU2tsSFN6?=
 =?utf-8?B?WStCZWhRVG1IcWdEeSsxeWtjSy8yTVhqYUp6bmd6Wkl6Qi9PWUpQLzVkclJS?=
 =?utf-8?B?eWhyVTZ6ZFlYMVljcm5SYnJNcyt5LzNGMHA1N0NCVDZKaFlqVUVpeUhweWNJ?=
 =?utf-8?B?N0NGejdiekt0VFFFbDF4SWU0TzgwOVZBbHY5TG12WnVDV1pSLzcxZEN3dXQz?=
 =?utf-8?B?eDdlcC9VNEgyRmlCSGhzQm9HNGNReWJXSnhwbW9Hc0tnNFZrVlR4cnVpY0Y3?=
 =?utf-8?B?K2VhMm9ZYWlTNmJwYVgvdnNVZjZud3JocHVVb0lTaDVzblgxZUZ6cGVNdldy?=
 =?utf-8?B?QVBLUTIvcXdhcEIyWHZVMXJOU1FualErdDd4Tmk1TFdIUmlSNUFMRGloTnlO?=
 =?utf-8?B?MnlBWDgwVWNKcVE1MFJNWXRjSUFiTUJGcE9wa1hxMUlab05COHY0N1hTQVpy?=
 =?utf-8?B?aTFPM1AwSEM5aC9BaXlPY1psN3ppQjdlQmVwQ0Z4NU9YcXk2QUdHZFUxaFRu?=
 =?utf-8?B?dENrdmU0TkIyWGdKTFB3NDhlYUVaYThNV09Bc0dueWc0T09KRWx6SmpBTVZZ?=
 =?utf-8?B?MlUxci9GVmZPdW1hWTgrVVhhOGhleVFRVElwdUEyY3lheW9WUk1MSkJFK05T?=
 =?utf-8?B?dWZ2eHp1cWlBKzgyNnlWVVRjV1I3RVdrY1B2TG9FNWxJYXFHbHVOQ2V1cDFk?=
 =?utf-8?Q?WXVlq44nOERuk6yo=3D?=
X-Exchange-RoutingPolicyChecked: J2gvgV4XbKsnudeX3bb5v20x1R9MRD9RNQyVNSaAT/fu0v1TaCD7x+Dyj4SMmWkH2tX42nX6ZZaAzSTNTFI0bkVYQzOUfC562vyctKAcj4t7ZNykfANvrq0karzk0McBTlP9hKdbJOB/fZfe9pJH/tpFMdGfu6541p0KfFsf3N/yd0Z2sD90bRqTX7PY7htNH4125MBwG+CAFY+3K6TwXlCVsE9sQRaw/0Ij5QgJJX3EhAEClg6oLlpngBpfXlIoJ9W47TDHr0jPraFUXyICEIkqDHDLHZIJ1mr1xQ6l8XSZkYIHKVerzKU26SSZG7HXviPvTgEIRNWUJ5fEpJkYpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a0ecef-1543-45ef-e0ad-08df08d832eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:54:37.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WACNmiFC2r/qK9RKiDEnZH9vxNNCduGL9KSzIuSHrcPVHPKRlTBZ1l+s3zRQs5CNqvKfQ9FYgzOqpXGUQfPkMITneKqiSJIaiQ5E4JP09NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
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

On 2026-08-31 at 11:33:08 +0200, Janusz Krzysztofik wrote:
> CI extreamly sporadically (five times over last six mohths) reported
> failures of igt@i915_selftest@live@hangcheck on ARL-S machines.  The
> selftest was timing out while waiting up to 1 second for a request
> supposed to trigger a GPU hang to be started.  It occurred possible to
> reproduce this issue manually by running the selftest in a loop for a
> few hours.
> 
> Among results from 5 occurrences reported by CI so far, and two manual
> reproductions, two of them contained messages that suggested a
> posssibility of the awaited request to actually start soon after
> timeout.  With the timeout extended from 1 to 2 seconds, it occurred no
> longer possible to trigger the failure, even when running the test in a
> loop for 10, then for 12 hours, on the same machine where it was failing
> before in 2-3 hours.
> 
> Assume the conditions that prevented the hang requests to start within 1
> second were always transient, and 2 seconds is sufficient for those
> requests to start effectively on machines in the CI environment.  Fix
> the issue by using that value as the timeout.
> 

What's the median request start time under usual conditions? It's
interesting to me why a timeout of 1s doesn't capture all occurences but
2s seems to do so. If the usual start time is on the order of few
hundred ms, then it's very possible maybe 90% of requests start within
1s and CI just exposes the 10% via large numbers. But if the start time
is usually ~10ms or ~1ms, is there some slowpath that triggers from time to
time that is expected to take on the order of ~100ms or ~1s? Or maybe a
scheduling, or power issue?

This patch does no harm and gets CI scripts to shut up about an otherwise
working test. But there is a world where the CI fails are exposing some
very subtle bug (though I sincerely doubt it's any urgent or worth going
out of your way to fix)

Otherwise with the Krzysztof Karas's comments about commit log:

Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Thanks
Krzysztof
