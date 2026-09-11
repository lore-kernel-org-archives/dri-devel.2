Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC40C88E42
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B8710E352;
	Fri, 11 Sep 2026 06:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TNosTSdt";
	dkim-atps=neutral
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Fri, 11 Sep 2026 06:29:51 UTC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F88810E344;
 Fri, 11 Sep 2026 06:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789108192; x=1820644192;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b576ZdHAAqX8XbmOVl3fyKB/qbTcctqUOVKJFnlG48E=;
 b=TNosTSdtELpDgKegASnH0c6Z5xjEzG2jUZOc9FUVbqSMHwKMhb1aYes9
 1u1E1WENim5KH+ubA6wQi0nfobgONYZW1EGqSCP/2eG7qb/kKtQdqFoaq
 hgIbKfVHOukHWu/zVnojvGPySTd0zzkmsKSr/8xhSV1JeVYUU0VWbENuw
 jqhymgi/MfIhz7dBx6swhJQo4U8FQUvwz1TmDzigrNpgxUAScZL358QIi
 LhUEgTHF5NvkLUGTjCLrPYfT8G68ZDnxdWyKPhJSNCRlMnfwgQxzdFdJi
 8LKJa/LvWDxj3RRIfMMPlJC9Lr35l+5N/deCVxfjoBR78ir+4oK6qKibf A==;
X-CSE-ConnectionGUID: HNyx4bSkSeSEzzlZMhJykw==
X-CSE-MsgGUID: X0P7i9cZQIq0LWVlFMkrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="77981"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="77981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:22:45 -0700
X-CSE-ConnectionGUID: XkyUjnw2QsGW6QpjV13VBQ==
X-CSE-MsgGUID: wnU6Qz0YTYKQMj3TAKYlSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="265638177"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:22:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:22:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 23:22:43 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fctgJvf1S8LTQ6jib9bPAXCTTAlgV/Bnx03ktGOw9bdIY0EKEsx47VWoPlapllN4BiCSRS+yS2NbFEE6wU0xOIrGDm0/xLjJ0zyvMeYJ3iW/FsNNrm7IgigN6wX/rGWNejT6kuyqvKPBYMnjT+ViRtdrhqm0C/A0Z9y05e0WDFj1bErM/1XKKz3Wa+4C5My5aK+zawklctS7BxwW55X0w3PZQEUei/wRedlDZuMOynFEqKxKJg6W/BFkjzQyoC4tujKwHKTMtdXC/q7JbmiWDoTDxUwVn9nG9yMBtc2+ai4fyhW8wVFVoj8AipGAZyssfqbnzBDJM2KT4a9LBt8CwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdxrBjh5udJ7t50rUTbf2SYUPJfhH0xWaS1gzheehjM=;
 b=oBb4d3dseNuGT3a+JtcTwNVwvRSrrDbxTRbFQqmijt0nfrg8dUBMEnOoj4YCLj987Nn/X+grlcl05fyIcoCpa4BRSvY2bEtgT9Ju9wn1dZwJrNG8peM6/AZsD+PkoQS/+szrK+s9iLBaTUOjsFMmu0SrdVIIZxKjTOJSRAb/QGrBZHF6ErCp2BLg1g463VaOhyHuO6uRGvcmMw6ttDPs3/ljnKgPkCBxRjOvd/dE0bOpf2J+SzCvxlXJIJaWoYtA4Mb0nXFCs3UvY81AgUMapeUuFX6hY4DkcVd6ZIyqlK7e0qlKdTPcoTebb+Sb63RtwCx7R8TER8cslTt+d9/b3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:22:35 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:22:34 +0000
Date: Fri, 11 Sep 2026 06:22:24 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 1/7] drm/i915/shmem: Validate max_segment
Message-ID: <fzq4zvzcvwppodcvhpcjaionohusid5zaubkdfook3ebpqa42z@tad7klzdgwxl>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-2-krzysztof.karas@intel.com>
 <aqMmx08W0SHX8C1N@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aqMmx08W0SHX8C1N@zenone.zhora.eu>
X-ClientProxiedBy: DUZPR01CA0222.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::29) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: e1898ea1-1637-4e0b-7a7b-08df0fcd1196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: bI38KTLEHpR2RhQa8Vpo5O0utgShPAW6AIhJwbfVQGHCISX900NjRhiiuTHgIhf87eXPRcJPsEDAkE3MDdpya1quJFhrwqHPT6oIyCGmMyLrpkVbsrACX2kS+11ovS0gSCUk/3sIVslcwD8Qe11SWg1sJtbrxbo/OSRkm4YiEFgC382zXYnfYKCSLQ8HMoeP79sQ6nVZ8sdccycr8kD5BBKY+Dk7dfykpplWZGS7eogNCaJsjJUELHqyhFmJmUkF5gR6pjh/H3R6MQSaAsnmDSUqq5mRPqwnO7iPmzYvs6QjWhrhgPJWG3YuLvo/odMcu9e6PHxwkmkck5m9fIXZSYfVa5xPhzcCfHGam+Fx/E74I526DYjO+dji42WR+dBxpdFHv1VA3uBirn6f6frkfqc52YgFtbYG61tPnlW/g4hZc3Wyhx5VvKCmYL7W2bPtd4ESwbBmhGPU3bEcUCvR/Pw17nv4obC8MVZV0n+HTEGYawi9HsavvlbuC1GdGiporfVWhqp/B39pYlQMDH5p23TQn+sIZAdEguIOposLaVeU8dIFDCEH1iD+uj2xeydflGE1u0A+KH9mDoNzmNUlmjT7iMwlbhoifkycxA/EOwV7pvNxISp42bjP8r3fwRUJt/WWgti5TAPJj+jXk0rhtNpCA/hsEgu1pmPwuXJG9Qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3EveURYVCsrb2FiakNjUUJtZ0RrdTJwc3VXc3pWYVJNMXRZalJKd1JuVjhU?=
 =?utf-8?B?UThIdjVEZ0h2Q1RORFgySXVJTlM0SVV6djB0bWR6WDhvK3luZ0lJQ0hFM0o4?=
 =?utf-8?B?Y01hSHBScEk4d29UNk5WdlNSUm1lbFZjbGZZckt3aDQza2RSSnNObEdLM1Yx?=
 =?utf-8?B?NU1oRHdTSEREaTF6Y2Y4K2R0ZkNLVE9KVGtzSjArVjhHZ2o5NkU3OXQ3eVU3?=
 =?utf-8?B?ZzhDSURicFM3VzlHQ0NQbGJuYUs0Z1V1dWg4eGpqOXZFREJqbFhOczJnRFFH?=
 =?utf-8?B?b0JJMkJXWlU3Z0cwUUFHaG5qNVg3NUoya2c5OEtxc0dpNEdJTlJkZjRNTUdy?=
 =?utf-8?B?WkxDcGpueXNQd0YvWTI3TmROK3JGSFd6ZHRTUXpWc005NzdHb3NIVEFoM2t1?=
 =?utf-8?B?d1AyY0ZzRjRXS0FHZEFXV00zczBKdmtWWTVyZUZYbUVzdDVmRmxOeVdoYy9Y?=
 =?utf-8?B?a0pPWFRHeFVWVStKVUl1Rm92RDZKL1I3UTJHWDFnV082bGluaWVsWVB6cFc5?=
 =?utf-8?B?RjVYeVBVVlkyTGFjbE10L1VNdmZIUWJDYTJEWTNvRUFFOXIra0ZJU1BXVHpY?=
 =?utf-8?B?NlVtRU11Njc4Z2hva3VURVB3ZnhRNG5vbCt4cFlHNDNLQ2xuUHVwc0RVY29s?=
 =?utf-8?B?emd2UnF3ejZpMGtwQzdqZjMxdEtuWElSeCttT3FXblBCRGdNNVIwTVloa3cw?=
 =?utf-8?B?YjVkelQxWVp6VTlDeVQ4ckN4TU5NczRKWXNLOXl0Y1MzeHRpbUUzNDBPSUZN?=
 =?utf-8?B?UEt4SktwT1VMckZNcnNrcGwzWkFWSmNIb1Y0OVVtNE14L1BlWUcvNTNON2sr?=
 =?utf-8?B?Z2cxZktnVjIrc2FaNVNFMUloV0VQd1pFb2JGOVJEbGx1bEltNExyTGtzaVht?=
 =?utf-8?B?NGdWaUhCa2RLWWNPNkg2amk3VGIxZ2ZTMVBpcnNYSitUTmRmZEkveXJYN1FO?=
 =?utf-8?B?UWRmWFliUGtKL2tRYWRNMmIxTTlGMlRQLysrd1hxbTRCYTQrNDFmVGgySEo0?=
 =?utf-8?B?U3pKdUJ5a25pK3ZkQVZzd2wyNCtBUlgzcXJVSXplbE95VU8rU1lXT3Mwb3JI?=
 =?utf-8?B?U0RsTGtrYzhwcFp1aUw1aDZQUEk1NFJwZHVZZk9udVlPL1dZejRiQ0l4d0U5?=
 =?utf-8?B?WkRlZjRpazJvM1NBdjZDU2crejlLbU5tVkNoV3NUMklZejVWTmx6K3V0bHRm?=
 =?utf-8?B?cGJkWENkNjhJMVJlVm9waFNIcXNpTm51azFRMU9PT1lIckkvTzlvcVRHSEpB?=
 =?utf-8?B?QnVMMklTQngvc0xEVlhydHliWGtyNU1US2NSY2ZpWEx4R0tySnIzMXdGSlJE?=
 =?utf-8?B?SlVYOU9DWVZScUsxWmYrS3JXc2h0VGhlclNiNWd6QyswOWhjL21rSW9rSzQy?=
 =?utf-8?B?K25PVUpqSys3elVjYStHeVFHZVFVWlJyazdZSDhIcEQ1czVDU2hISngya1B1?=
 =?utf-8?B?SjEyblcwL29XUyt2QVhHNFg2Uzd5VlpsRlBBYUk5SlU5UVhwTVVyQ3ZIL216?=
 =?utf-8?B?R3FrN0hwUGRaSXUzMzZRcGcwSndxeElDTG5EY2xIK3dHQURQQnNvVFB4aDd2?=
 =?utf-8?B?R281TnNFc2Nob0haOTEwWFV5N3FkVTRKOS9UWmsxRHh0dDk5Y2x3SVhRZ25J?=
 =?utf-8?B?Z2h4bGVNTnlzOVVSV0pLU29zNkZ6RTRaTEpqeEJuQm1FWnpYeHlOWjNqUURy?=
 =?utf-8?B?UENRbm5vVHhRMmZ3N3AvS1F0Ri82WG1EQmx1VWxHUzRydmpKQy9SbmFKVUZK?=
 =?utf-8?B?Qit1WXVHRkZPYkFHZCtLakZjTmJ2b2trLzVoRHQ4cU82MlRGalpydExHSXMw?=
 =?utf-8?B?Z2RTRWZIUHFzQllsNm5Fb0RHU2toMG1hcU1SSGExcnpTRkFYRm9lS1BIZTd2?=
 =?utf-8?B?UW9vNnFBaGUyanhhL0dzUjBEZjI0aGhsbEM1YzZuenRSZW1BeHlEeFhwUWtT?=
 =?utf-8?B?TVVsM1NLcFNTKzBCSzQ1WlhmcDl2REQyQklYRGtnWWlxa1g1alcweTc2Uk1a?=
 =?utf-8?B?Q1J5eUhvQ2YyM2xYSVF0TGFhM2lsVzE2SzdvbFNmcXc2by9LdFZwZ1ZRdkla?=
 =?utf-8?B?YmxWYWswaWpuOWZsWHkrZWJLaFMvOUY1M3JzNDhqdW9MZHhQVEgwS05mUjdI?=
 =?utf-8?B?dVdMM2JHNlJhajEvQ0lzZnRQYjRqbFhIQ0JJM1ZqTVA1aG00ZXNUbWtCMWpr?=
 =?utf-8?B?SC9kb3RwU2VQQUhSbmp0a01meTFCN3BLREdwU0ZKbjd4ZDdKM0dGbUpuOWQx?=
 =?utf-8?B?NnZLeXdEdDZDWkJVNjlZYkxKOWFYcmN1cTdrZXNjdENEUDRNZi9EQlV4bm1i?=
 =?utf-8?B?ZkQvem1MeTdEaGF1OVFaL3FFWTk2Qmthcm5BSk9IZFByU3YvU3hPdDNYQVpt?=
 =?utf-8?Q?FDoZa1Pybw0zwBok=3D?=
X-Exchange-RoutingPolicyChecked: jcGvktvAWOmV+4/dk7b++mUxHpfLIkQhtWbaY4Myo/1UVE8XyIJS8MQU86+5mUSHvCDNP5HJZtDhGQCbQpdAyIbaFM7YdAuck17kx9l1ZXJq8iA97ingK51BrN7MqGkia25pVzcKloZVyezdgMlcRTA0fyy+nBUMGg+zLuFv9Cng29P5DGR1vHqNrSSUd4B/2C2q1NoCQg41Z1m2jAZnEaA8Pd6s1svfPEvAcQd2k8PXTUbHkZZTtzVgW8aJgJtxkokYWS6U2bIQGeOE21itXcH0AHS0ifWvJ9QKFSQ6+dmswx0HxlSU2Dq+TCfjN8iSo/SIK8MY5niyqGQPwyJzlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e1898ea1-1637-4e0b-7a7b-08df0fcd1196
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:22:34.8602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeLfjX8p5IAuy6R6OliOtosTJa1S2uHAYplo7nWdhBZhi9qoYCpaLBIwkMdZsuRDbq7M51VnViR+SfV1FgoSUyaputxx2dbOwYbXbCKKucw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
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

Hi Andi,

On 2026-09-10 at 23:55:34 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> > +	if (max_segment < PAGE_SIZE)
> > +		return -EINVAL;
> 
> should we also check here whether max_segment is page-aligned? I
> think the loop coming later assumes that. If max_segment is not
> aligned nr_pages can be == 0, right?
I'll address that along with your other comments on the series
in v7 (+ the iommu patch is going to be separated).

Thanks for looking at this!

> 
> Andi

-- 
Best Regards,
Krzysztof
