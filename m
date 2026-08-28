Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80972C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9F510F43F;
	Fri, 28 Aug 2026 16:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eaS2xZeT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D8C10F43E;
 Fri, 28 Aug 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787935753; x=1819471753;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=31XiSqiZMSS+zg6qh2hQQrftSz/aaeD4btOS9SeMzlI=;
 b=eaS2xZeT6XogZoAl67h86pLjb6DgN272RRFJVu4qqD7ucSLDczAK6aXu
 iqFvvkX33YyGesSLIBqjXiZ275EQQF7sAr3/n5p8jZ6WFEvsVr/QT1IEQ
 b61DFI++Pa7u7Ktuk1s9dEMfeqca3j2uDrHHes2AelhfnBrtkw+b2cXzy
 B5VOiO6iOsllKBDWEqVsnIfovF/gv1Bu3LVQq+aSAwcvrYYc8cgWzZW/i
 n1F2iJwTM5kKelV4p2mOZu1Nrtrb8HyYogT1TYPoUf8mGei8NUbt/p1Wx
 8fx+9hxTnFVZ96NI/bZMVLWbJ9uatmmLHEjp0tHQ/Ywjgf74OzcDVTaS6 w==;
X-CSE-ConnectionGUID: NWDHv8JhQ0yaRn4f8tyhrw==
X-CSE-MsgGUID: yAW+taVHSKCIbQrbKkKBsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88304144"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88304144"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 09:49:13 -0700
X-CSE-ConnectionGUID: QuEoJi/YSVeUSwA9M+M8Hg==
X-CSE-MsgGUID: /4ly+mmHS3qEsEEjyJPKIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="264970160"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 09:49:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:49:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 09:49:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGus7LStsiPLr0q6tJPpuOg86MWRIsQ9/AIb0hdw8NWNI/SRjn+y4oBb6QdDm+EbkkUpVbEWV2jAe1sMSii/095uuT7sFbG397Mn9p51d6KJwweRGIHAjz1H1oRHHixWGdm/6ll7XsMF+5T/yT4xXcAfvUrTsO0uE9ERguoYrrou4pRD4UsqI/zS0zH/UZhMREZZcy8xme8pj92BPNgt8uYNNQ/UoFw2b31RjAYsQ/lVu3qYfXzZb75Zu/RNg4McHV5sS0VtBR8J9+nEK9dFXhdEXWiPxiHmmtGtatwqVHwZHDjZlrXAD0+cAikgB9SrlMyMK64Sk66a3VHYWG1kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB1cZcs3TC3bK7jai0zEytpsWGZLwlqfaDJK32b2JV4=;
 b=eR7vgw7YOhGFF8agA/k4WvMMzwZlLfZrAYD1+QL2GnF9vEgpBP8frz7Pr4TIa90tW/U/l73NjgCNRxLjG4Gpqs0US0/skJ8CvAGL8EmzwQie0WTfW4+DC50/MsPwTdBryATTZyXBt4pmNBIg/Ohy+jaSKBX9qAqehDCyjJ72FsgexsUiDTr1t9wq/Db5riqhB5Jv3mGh3agSG7mlSX3aJeSxPyjl7+QFj4S8zhHYiP5gB6kRSf0H79Hpt+2JqOEUm6yz8DxPimvwY310TOnB5GvZY5wg9UuqFYljP0ZwsN1fOT3Ns0tuSULeQxvnlXyC+LIa/vIE0tYs0RMWsSPpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 16:49:08 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 16:49:08 +0000
Date: Fri, 28 Aug 2026 18:49:01 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 3/8] drm/i915/selftests: Use drm_* prints in selftest
 helpers
Message-ID: <apG60XZjsuykizlu@kniemiec-mobl1>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-4-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828100339.72304-4-krzysztof.karas@intel.com>
X-ClientProxiedBy: DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|SA1PR11MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2e6b72-281d-42e0-6eb8-08df052446fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: u2OI3+ip+cgSIdJw3TyNFwFpN4dM0/cKSrQvE9ZMv4NUKH9LBH/3or+aYdMITQOk7AgYQpii5+DtBsogiXmhr2bSrGaHoSCo/CfOQC45vmhufZmxTovS6kqZWoa05az4Mqq5o7DNIdVeCzoYeVn/Rvcq7mD4frB3nPnyYrHQIrMsKPVqUt86JLCLMZO85zLcPyorpGA98kSRKBMyXKgNItWigQ63aHocBPQLKNVaUV3y1zDMPwmZhZqy2h0lZqV0gHGaS/hWU321lVcVXBvau8kOhxwJj1wIo0Cn3XEFzwMfGzmnUnvXP31M/NVttlKk64Keplu/GEB5824GIJ4zDHxX9IYqRF/p2HrIrsn5dq5Yk8O1Sn33Xz/Y05xbXx+CbSKRXSZ6pM5Mv9JOE16qmPt75CrU+OOexUYjkP+gOi+0HOAIz+/woPgnSusWn2DR82IUdqam+mEmqEM9QwiCc4MVXOyME9CfZ/BGu/LoPT0VWDpYh4KBvBJG4c6JJ24C2I7mQo2TydJ7Jj1KKkGVv/nr4IvjdQ833xk2SlA4M76apBpSub/BUspTFkTYIZw6mukfhjlPDn/G1DE0JDBghc3QSzvq9LmY7dAToJgQG3CDemu5tl+/IJdS6QQMs25YiyhqMxLtHk+XQLJ/9Tw1EVFmwqGb/8SwuPK/7twVO5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUh4S1VFR0wxckRodzJUV0tHK1NETEtoemZXaWV4VDJjMDZERlZiUDAzbGth?=
 =?utf-8?B?OERGVkpCd2VhbTVKSjhLUjUyZU1pc1E0Tm1JaFU1NTN5UGhjbVZNM3pTb1JN?=
 =?utf-8?B?dEI2NFpPTnBPcGM4Z2pqN3NrakhFZjVDRnJUU2xidVU3akdWMGJpYVZNL3Ft?=
 =?utf-8?B?VlNxdUcyaFdYTlZtU2xrYWU0Q3BodTh5MjVWZC9URENJcWh1VEhPWXhheHVW?=
 =?utf-8?B?V0REdEJWckx1UUJjY2dQTmNsTGtVMDZ4M2FIb1JOMTBNWStFdEx2c2ZFamw3?=
 =?utf-8?B?L1o5ZlB2d01VUS9tZmxsR3dacG9mT1hzaXViUlVROVVVNGc1eHN2L1B0YUU2?=
 =?utf-8?B?R0p3SXVoV1ppZm1SVy9iZW1IODVsWVkrbHFJU1l3YlVoOU8wdWEwbk1nbnFo?=
 =?utf-8?B?VHF5a3ZINlpoNFA5WXAyaHkxSjJ2cVBKNHVXOTdBZkR1ZnVtU21Jb0hFOXVJ?=
 =?utf-8?B?RENXTFdqaHVIOThlMkhZYUNERllCY3RDRmcyMkdlTm5QTHE0RmtjOWo5OGhK?=
 =?utf-8?B?QzIrVGk5di9ac3FJWk9RL3dMUitaekE5cGp0NERxbHlYK3lHV1JpVmJCbFJp?=
 =?utf-8?B?dnZJNERhWndVMHRVZTljSjhPaDdmNXorWURzckRCWHYvU1pXS3cyby9hZ3FL?=
 =?utf-8?B?aGxjQ1dGbU8yZXRUNHVUNFVCaTQwaW0wSk1xRXc1alRDYWY0YzJXMGY5U2dp?=
 =?utf-8?B?SUhMUUtkdEpjd3ZHS1NiZjI4VEhCY3BpWGxMZEJlUXNSQVZ1V0pCTTQzWjdj?=
 =?utf-8?B?a2RDTUxMWDZUZmQrQzBHU3pzNW9vc3Zta05VbDhUVHdTZHI3UzhKL1A2alZM?=
 =?utf-8?B?eHgyUlR4YlB0RnA4c0IveURaUTh0ZWhXL3pFU1U0VElWZG03WlZPbm96V0Rj?=
 =?utf-8?B?UkFHNUZlS09wTGMzZDk1TUd6ZmVMY0JDQjY5ejA2UlQ4NnZrQ29zeWpvaDY0?=
 =?utf-8?B?dER6djVLWGxveEU0NmJvaEthMGloZlhhL0RJUmZocW1XRjNlcURtTXgyWUFy?=
 =?utf-8?B?Nnlna0dzZnBQbWRhSXRJNFBULzN1Tmp3U3lJV3hwRVZEemhyYUZlMEU5QWFa?=
 =?utf-8?B?WGUyWXhlVnYwbGMrdlJaN3hWMGcvamxhRVRqOXpaRGdTVHR1UGpJTXBaU244?=
 =?utf-8?B?U3pvUDgrMXM2cE45a1FSZFB2Z01ZcElqRnJRQlU4YW1icDh5eUtBK3VaZk1t?=
 =?utf-8?B?aUF3K1BhWnhwelF5WktrRXNkVThWaVY0S0hsSHpSOXh1QWt2U1hiVEZXSWpw?=
 =?utf-8?B?NUZwMENyWnV6aWNXREFDT1llam11blllTjZQamxEem1kR3Jxb0Iva2xtRENM?=
 =?utf-8?B?NUV2WDBuOHhQRDRWNzBkTFAyenpGQmdKbEJPaDA3YU11SnVtaENTZEFRZnJ0?=
 =?utf-8?B?bUtjTndtckNPMGx2RU1aNElYRHFKTDRaU1hLUzAySmdFMFBoZzFNTVRUSGhS?=
 =?utf-8?B?c1l1L2ZRaFA0OUttL0JVZ2ZXay9NejlXVTBhQm1qSGJHdisvb0J6b1ZIN2Zw?=
 =?utf-8?B?clllRjVhZktmVDVkZGdacDBCRlpGMFI4eEJlVzhkcUR2SFpMK1JrTml2RDJN?=
 =?utf-8?B?RUFCQ1RLWHpVOEZVSkpLN3Q3TXBuWGJyR2k0SldrOUJURkxZUVlnUXcyZDJw?=
 =?utf-8?B?TXNYSSswcG8rd1JpbFFUODkweVI0ck1sNDdkZno5QkxHNGxMNGN0NEdSME4w?=
 =?utf-8?B?V1U3L0U2QzRsbzVPMUVkSWNNVkwydzV3N0g3WExjYm5SWUdpU2ZIbTQxcVdz?=
 =?utf-8?B?dDJGUkNsRURISVJhSmZ4dnNNaEFSaXRnSUljd3NaTktXY2FNWHUzMXJIUVJR?=
 =?utf-8?B?WTV6WEhEVndLNkplTHppTnNRZGtnbXplU3JVaGdFcWRPYXpjcWxCT3Y4RHVm?=
 =?utf-8?B?QmcwRW1GUGhvcC93bXBWQmJYdnVjS2taK0ZKSzdsMEJveTZBYnlZOVc0c3VG?=
 =?utf-8?B?RDZ6TVhxNXVlZmNaVXVlTDRwaHNyVElmTDNva2VjenBkS1ROTHZFbkNxUlh5?=
 =?utf-8?B?Nm9MV0lYNWtYUUFtNXpRWW5TTHRtZzBvMlgxWkVTZTFKbk5CZVIrT3FDditS?=
 =?utf-8?B?VExKMXJkdUQyamQyZVhoMXBTQll2RHdaU1h6Tmdld09HUGJxRXBrTFZpUU9p?=
 =?utf-8?B?T3lVY0lZNzN6VWlSOEhKSjJGRUZlVHFhV2p4WlFETDRHR0NjQnF3RXRTTlU2?=
 =?utf-8?B?NjhCTkJzRnhGTGNycFlQS2pabW43SnpVek9YTTBNaDhlSlJ0R1FsNFlpTjZL?=
 =?utf-8?B?OXpBUFMvUy8zZEFZcG56dkRhTE42L0lGUy9JUW4wUk9nMHM2clI0QVNTdmdJ?=
 =?utf-8?B?TVB4RUNZd3YzNUVBbzJnUVBlYzN2Ry90eXN6UVdkRmVJdlNubFIweUdxelFU?=
 =?utf-8?Q?bPYhHSlTpmRbGjRc=3D?=
X-Exchange-RoutingPolicyChecked: 5MbiyU+rjwcsJtDdYMLVPoarqZp7QyMAbPcoVWGWI6m9HQUjX+KwE/rCU8ngKO9ZN8pt2uPYpa4f/FyRHv+Q2DJQ3C3MJqPZJSECYR9HRSCxZRnycEMsmdmi4VhcoVVnXhvn6svx4FjXKBic0pKlihvGRR6PcXM+2gvakjB31X8PTghuN1ES7DdjVMWrabVUw6Zn2wIDxjGBpw+Txd89HaJbOyDBtYC2glvmOiL5WKHRr0vLgCbpYZz3h5aGzA70EE+P/DQWnew+e9VsiAViO9mxLXHQA47InMZVDCFaRDUofWliyKhXm+gPuPa9rjR5xKF/0SVJvrYurDc2E1qZ8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2e6b72-281d-42e0-6eb8-08df052446fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:49:07.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4hQP5WAeI7m03DlNA+AUaCoFWGGpjbcA98pEQhN0l80jk4gkvxRaSnQyqFWgpM/ABmstCa9j+A1uHaKz48Q5hU02qw4/DmiugyQrSmHlyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
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

Hi Krzysztof,

On 2026-08-28 at 10:03:34 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/selftests/i915_active.c         | 12 +++++++-----
>  drivers/gpu/drm/i915/selftests/igt_flush_test.c      |  7 +++++--
>  drivers/gpu/drm/i915/selftests/igt_live_test.c       |  6 +++---
>  drivers/gpu/drm/i915/selftests/igt_reset.c           |  5 ++++-
>  .../gpu/drm/i915/selftests/intel_scheduler_helpers.c |  8 ++++++--
>  drivers/gpu/drm/i915/selftests/mock_gem_device.c     |  4 +++-
>  6 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
> index 9fea2fabeac4..79b55df1e71a 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_active.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_active.c
> @@ -115,7 +115,7 @@ __live_active_setup(struct drm_i915_private *i915)
>  			err = i915_active_add_request(&active->base, rq);
>  		i915_request_add(rq);
>  		if (err) {
> -			pr_err("Failed to track active ref!\n");
> +			drm_err(&i915->drm, "Failed to track active ref!\n");
>  			break;
>  		}
>  
> @@ -124,12 +124,13 @@ __live_active_setup(struct drm_i915_private *i915)
>  
>  	i915_active_release(&active->base);
>  	if (READ_ONCE(active->retired) && count) {
> -		pr_err("i915_active retired before submission!\n");
> +		drm_err(&i915->drm, "i915_active retired before submission!\n");
>  		err = -EINVAL;
>  	}
>  	if (atomic_read(&active->base.count) != count) {
> -		pr_err("i915_active not tracking all requests, found %d, expected %d\n",
> -		       atomic_read(&active->base.count), count);
> +		drm_err(&i915->drm,
> +			"i915_active not tracking all requests, found %d, expected %d\n",
> +			atomic_read(&active->base.count), count);
>  		err = -EINVAL;
>  	}
>  
> @@ -236,7 +237,8 @@ static int live_active_barrier(void *arg)
>  
>  	__i915_active_wait(&active->base, TASK_UNINTERRUPTIBLE);
>  	if (!READ_ONCE(active->retired)) {
> -		pr_err("i915_active not retired after flushing barriers!\n");
> +		drm_err(&i915->drm,
> +			"i915_active not retired after flushing barriers!\n");
>  		err = -EINVAL;
>  	}
>  
> diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.c b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
> index c383d31d46b0..86164d1258c6 100644
> --- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
> +++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
> @@ -7,6 +7,8 @@
>  #include "gt/intel_gt.h"
>  #include "gt/intel_gt_requests.h"
>  
> +#include <drm/drm_print.h>
> +

Same nit as in the previous patch with the drm includes going before ""
i915 specific includes.

Rest LGTM to so far

>  #include "i915_drv.h"
>  #include "i915_selftest.h"
>  
> @@ -35,8 +37,9 @@ int igt_flush_test(struct drm_i915_private *i915)
>  
>  		/* 2x longest preempt timeout, experimentally determined */
>  		if (intel_gt_wait_for_idle(gt, HZ * timeout_ms / 500) == -ETIME) {
> -			pr_err("%pS timed out, cancelling all further testing.\n",
> -			       __builtin_return_address(0));
> +			drm_err(&gt->i915->drm,
> +				"%pS timed out, cancelling all further testing.\n",
> +				__builtin_return_address(0));
>  
>  			GEM_TRACE("%pS timed out.\n",
>  				  __builtin_return_address(0));
> diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.c b/drivers/gpu/drm/i915/selftests/igt_live_test.c
> index 7d41874a49c5..c1fbd98d3164 100644
> --- a/drivers/gpu/drm/i915/selftests/igt_live_test.c
> +++ b/drivers/gpu/drm/i915/selftests/igt_live_test.c
> @@ -59,9 +59,9 @@ int igt_live_test_end(struct igt_live_test *t)
>  		return -EIO;
>  
>  	if (t->reset_global != i915_reset_count(&i915->gpu_error)) {
> -		pr_err("%s(%s): GPU was reset %d times!\n",
> -		       t->func, t->name,
> -		       i915_reset_count(&i915->gpu_error) - t->reset_global);
> +		drm_err(&i915->drm, "%s(%s): GPU was reset %d times!\n",
> +			t->func, t->name,
> +			i915_reset_count(&i915->gpu_error) - t->reset_global);
>  		return -EIO;
>  	}
>  
> diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.c b/drivers/gpu/drm/i915/selftests/igt_reset.c
> index a2838c65f8a5..7902ed9ad339 100644
> --- a/drivers/gpu/drm/i915/selftests/igt_reset.c
> +++ b/drivers/gpu/drm/i915/selftests/igt_reset.c
> @@ -4,6 +4,8 @@
>   * Copyright © 2018 Intel Corporation
>   */
>  
> +#include <drm/drm_print.h>
> +
>  #include "igt_reset.h"
>  
>  #include "gt/intel_engine.h"
> @@ -16,7 +18,8 @@ void igt_global_reset_lock(struct intel_gt *gt)
>  	struct intel_engine_cs *engine;
>  	enum intel_engine_id id;
>  
> -	pr_debug("%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
> +	drm_dbg(&gt->i915->drm, "%s: current gpu_error=%08lx\n", __func__,
> +		gt->reset.flags);
>  
>  	while (test_and_set_bit(I915_RESET_BACKOFF, &gt->reset.flags))
>  		wait_event(gt->reset.queue,
> diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
> index e14ac0ab1314..83f66fe4a9d5 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
> @@ -5,6 +5,8 @@
>  
>  #include <linux/jiffies.h>
>  
> +#include <drm/drm_print.h>
> +
>  //#include "gt/intel_engine_user.h"
>  #include "gt/intel_gt.h"
>  #include "i915_drv.h"
> @@ -24,7 +26,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
>  	for_each_engine(engine, gt, id)
>  		return engine;
>  
> -	pr_err("No valid engine found!\n");
> +	drm_err(&gt->i915->drm, "No valid engine found!\n");
>  	return NULL;
>  }
>  
> @@ -60,7 +62,9 @@ int intel_selftest_modify_policy(struct intel_engine_cs *engine,
>  		break;
>  
>  	default:
> -		pr_err("Invalid scheduler policy modification type: %d!\n", modify_type);
> +		drm_err(&engine->i915->drm,
> +			"Invalid scheduler policy modification type: %d!\n",
> +			modify_type);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
> index 796c9b070e41..c0dadcd961bb 100644
> --- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
> +++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
> @@ -169,7 +169,9 @@ struct drm_i915_private *mock_gem_device(void)
>  	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
>  				  struct drm_i915_private, drm);
>  	if (IS_ERR(i915)) {
> -		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
> +		dev_err(&pdev->dev,
> +			"Failed to allocate mock GEM device: err=%ld\n",
> +			PTR_ERR(i915));
>  		devres_release_group(&pdev->dev, NULL);
>  		put_device(&pdev->dev);
>  
> -- 
> 2.34.1
> 
