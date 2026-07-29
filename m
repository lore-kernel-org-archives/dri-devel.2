Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD8CC54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5412810EBDC;
	Wed, 29 Jul 2026 12:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GytMEedG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CFE10EBC9;
 Wed, 29 Jul 2026 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785328504; x=1816864504;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=myps6O1CRaSSk7WLJ/yzAA01pEwuEpNy2mPQexIQNJQ=;
 b=GytMEedGVJAb1VwUCrap4gRDAWKrbkyfkJPzoeIf8DgU5BitgO777V8a
 y5PdxnOysx1Q4S5/yDqD8xPZ5/VNJU5bx049ucPNT8GWWL8QTIsCwPYDc
 KhLz9jeuAVQZnNuBZOOTCBTmKuq/9H3CSFba33ytLjGjN5WYNA0bJtw3p
 4jTihwYL48pagF5t6ZuZ5jq7oMGSlLeWK5G1Lr9VXit+qBQ8m7nkx9Bmg
 qcYMAa3evvg4n+JuYi7K4DL2QN3x7FmbS9G+H0S4pTJHavtwnMEXXqeZf
 pJ44WXX0A8j3+8mKF77PodV8ynZ3HgftNTXqdrZG1n7QV341A1x/Zpa9+ g==;
X-CSE-ConnectionGUID: w9OydyGiTQ2gJyYuwE16xA==
X-CSE-MsgGUID: NoDPtSAeRai/oqYxYeiaEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85785124"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="85785124"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:35:03 -0700
X-CSE-ConnectionGUID: Na09TKJBQRixtcZgBEf3tA==
X-CSE-MsgGUID: 2d+1UYrzQj2kv4E1ZcwfyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="263496616"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:35:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:35:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 05:35:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.10)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 05:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiE4RUoMkHtcvWQkcfSYI+tOF0O7b6JbN7HvpikgmYTWTC6204t/Ip5Pea6JSSVI/365e9Pu/IxpgOAo8I/FIB5L2IdPwA2GmR+RBPJ04oO2k2lyD2U1NxIrPqcz7mtZjpsmnIrxSX417fZj9QQIPYtAm80tnlhCLRdzPUrs/1Ldb9bre/SA1egQT9BTmGAV9EciQFtuSDKHLyU8sUCRx9ybvLdDHZh8PNqIgDFFkliz/J++2MWrsONOVSf30mja4SPxwQxvQf/AYVCRuTCZZQoqRjEN4Wr7IaaGlOsmbTkSxv41QU5Osztq4vpbISH23hmRPWlXvkIVSwTOAKqN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1LT4HPC/PH50by+H4Mx5vXMSEEV/MAqBDan8o6uMnw=;
 b=dU8g/eb9BA7GnqXtZ6aWHQJ1jWimZaS9FknPIbQ+COE7+3X7jHEra8LgXxy+8WlHxYgknUMCyXsUBZE232af6AHqxmlU8kqsfzohCom0S88NmXwC9O+a4tC7zK2w6WrBEvmrAArdp36gStXqsnmXNNvvmczQ1EgOtH2hBmwrlXurM1PBicBBJBVsbi48F+a3NDp/hRTWOS7oz84o8RR2NW+PMwaRilo/rurDqF+dITMtbsXbBuQond6G68gPF3otJFZImYNP03MrmO6J78VxgGgMxgjEq+o473E/4HY1n46SHihOs0UDrsNy9ZoOSNIlO6EHeW2+hgUycTNf3A3/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 by SN7PR11MB7492.namprd11.prod.outlook.com (2603:10b6:806:347::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:34:59 +0000
Received: from SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b]) by SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 12:34:59 +0000
Message-ID: <408fa0d1-e4d8-49f1-a5e7-c52b205f6673@intel.com>
Date: Wed, 29 Jul 2026 18:04:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/dp: Read the PCON max FRL bandwidth only for HDMI
 DFPs
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
CC: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Imre
 Deak" <imre.deak@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260610193825.2933-1-alexander.kaplan@sms-medipool.de>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260610193825.2933-1-alexander.kaplan@sms-medipool.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0320.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::7) To SA3PR11MB7554.namprd11.prod.outlook.com
 (2603:10b6:806:315::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7554:EE_|SN7PR11MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: be94305d-b75c-4c02-1f17-08deed6dcda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: x2CCHSMtRTrofz0PiUVJ/K+Pcu98DA3IFVbrpTUY8+llXZP6qm0hH85ZhuIOP9zMc6w1/wMleT0eHrffk65mcO+7E8AZWZt1qGESgmWj4+eSfEr8ep15Gil2Dmzme9XPZcjMohjuRdy/Fh98DkasfscyXEb4FNRzae7+mtJhZTLxNR0e3gZLvHZay2HCpeUJpQdm5dbKt57H23EuBWuF2EZ6ul6BmBfY9a2mOjOl5No83G6uSt6MCnH7lx9/AZHYqKjVoRe0TAE17xQrqPxKuEIVdG0VleAi659cKa+dqdD5GLIeSr5dbXmwSDfgT1wdEu9DxvP1z+fq4q6dAReIZsxU9fDd5/yLow2B1mfB5/7N9Ne8s24rcLl3B+bmgTAIBe7Pf9mYBt5gS8YioWJeBsveG9Ssv9a7bnuAQnEsZNCLaXJk9mjiQHsBux3EqsnDsWhuZ/GmXhjWoL1TuK0CJdfBTp0dgP1l4oolq6dPdf2IObElwPmsx6voGRyn1SisYMGm8sJXm8Uxqss7kRIo4prLiYCyWAuaCRYuvB3rSAsjSFyAOPBkSE20eG3RFdBTNLbn35B4lySYldeEDSnLHYNAHXjHdLiHHrGqnHfEZAVRzNsQ41RKiTvXcnG05WBFBQp4y+jDZkqO5Xu0MvtsuOX+RPkE7+r0e+UmwEG0taM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB7554.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Rqc3ZDd2JUT1RhQkZZVDYxLzNHN0JhVkxpa3NmeEdBa1B2eFJIUFB1My9D?=
 =?utf-8?B?cVEzSDhZVEZNU3ZBWVJHUzB2L3NqdUxwN05MVzZpM3ZwUjlVZkIvRkdmVDdw?=
 =?utf-8?B?RkJwNU16OFdRRUN2L21iTjZpUU9GR2pCbXJiVnNIOWNqWWw3a1V2L2NPMTVT?=
 =?utf-8?B?SUxuZGZKS2dWM0E1VDhNZi9NNjNrUDhoeW5iQ0xnRXZWbjdzRzQyVFFTaGhv?=
 =?utf-8?B?clAwaU5ra2ljYTkzbUFvTUxseWJwdmppVWJzOXBEMEhJSE1uckZseFp5U1Q5?=
 =?utf-8?B?cmFOY0RSK09pejRGL2grRXk4NXpmNTZ1b1RVNXhKWXkvRkJGTHN3bE45VHhJ?=
 =?utf-8?B?SlA4Z0d0eEFPREUyRkJzQjVNV2xPdGxTblJxZHBuZWE1Wjc2ZlpqUEhCK1Zq?=
 =?utf-8?B?UEhUZmh2QXRSMVMxTXZVRndkVnl0K3dGbmUydWNobjVIeXV1eVl5T3BGS0Qr?=
 =?utf-8?B?M01WOW5FWFV2Y3NqVlJ0MDljd3pnTkFCVERjREh0bzhvVnhVQXcyMFBUTktn?=
 =?utf-8?B?MnVhYnRBMmExbEtoK0JsQ0pYWXVPNDZyUDV5WW5oaFZvV25oeC9UdWxrSm94?=
 =?utf-8?B?djU1SUdWVVFBYm4vREVML0t3TVJpQVRLUW5EUVpmdnEzVnlwREVEUlh6d2xY?=
 =?utf-8?B?bGhqZjhnVUZ3YStOeU41aHJ6dGNMbXNXSVRKUjJjQVdIV3NGby93WEsvRUk5?=
 =?utf-8?B?SXVvWTg3WlVhRDRHb3dZa0MyRU8vMVB2ci8zMmRXYjBWR0lCSzI0MkhEaHUz?=
 =?utf-8?B?SmlxUXhqdm92bUpYR0ljNzJ5SXZkcnVacTBVWDNmTUFCOG0zaHBsZmQrdGRJ?=
 =?utf-8?B?WkxmdTRNTWZpNVdpbGpwU05Qc1ZDQWpqTzl6L1dLdG4rNjBwMnpQUnpuY0tC?=
 =?utf-8?B?YVhtYlNibnRIZHgway93ay9pQk1TdHJSZzVXbDBOWWQxV092ZStLV1Q5RHNp?=
 =?utf-8?B?Q1dQZG9GYzBXbTFIL2VOaGRDYkp1MDVkdjNqV3ZwcEhzQU5CdWJkK1RRaXhS?=
 =?utf-8?B?K2dLRTRkOEtQYllBNzV4T3FJekR1MVRZY3JVNE54bnROeE5pQ0JqMzRpQ0NU?=
 =?utf-8?B?cWVoeXdpUkRxb2ZSNUlMM2s1Q0lHQmM5YkdpY2VLVUt0bXMveGR5RnoxTWgx?=
 =?utf-8?B?dVNDMUtGbzd2cGxBSWdMT3N4WWxPTG4yWmVTK1RkWGVpejY0YWFnM2dzbXMv?=
 =?utf-8?B?QVRwY25wbVhkOUhqNE44Z0p5cWhabG1rZzluUFZDaHd1eExadktqR2VNQmpi?=
 =?utf-8?B?dXU4WWZPRUFsRlMySFgzcFltcEh2WGJXblVMME5Pdm9pUHZ3Z1cvRXBWamx3?=
 =?utf-8?B?K3Z6OUh2VzdHanZTeEUwTWRBRnh2Wlh4eU44S2IrK2Y3ZllHQkxoQWtvWmhM?=
 =?utf-8?B?cFkzNWRuZkZEM2UzVWZoNTVHK3lOTXhiaHdKVkNrYUVLUE1iR0pkK0taRTZu?=
 =?utf-8?B?QjlRQmphWkJGeGhTQjQ1djBhWDdGTlRnMEdvRkh6UzlONk85dStXbGpkcWFD?=
 =?utf-8?B?b3d6eUdLYXpjaERMSjQyOGJ2WDVrK1Y1dkNTamI2UzFkdkQ3SXBYNGxseEJF?=
 =?utf-8?B?WVZhUTArV1AycXc0TkdnREQ5RlkyS3F4NnJjRG5JWmRZZUgxRURsWitMRnJT?=
 =?utf-8?B?Mi9mMFdGZlpNNFZBRnZIQ0pFTWUwcWdaTXpVdk9aQWFlSTNqRUliV0p2cnpk?=
 =?utf-8?B?WEw3RGhmQzRZZkJDcGF0UktubFlMRWZJVzJLVU5CNFMyc3dZcHdNMEs2S09F?=
 =?utf-8?B?cmhiRkZVUFdZZWlLc1pxenltWTdsK04xZjRHclBtZ2ljWmduZDExMWJiaDN4?=
 =?utf-8?B?RmtQWFg3bXJ1RTcxS09STFk1dlNYTTNmNmdqaXMvdW1aZm9sVWpFdlBsS0Jk?=
 =?utf-8?B?NHM1OElJQ3UwaDFIeDZRM04zTHAxNHkzc1NzSmsrQ2ZKc0NkdlJtUXBpcjgx?=
 =?utf-8?B?UmxwL0FFd0hxUjZYSXR6VW9MUENjSlVQMkZCR0cyYVBqSzUxUWVWcDNKS1VY?=
 =?utf-8?B?Vko0Wi9aQkVJNWZJNDQ5R3dybU1RT01kOWVXS3puM0hzSEtBMWg3T043QmN6?=
 =?utf-8?B?TzdHMm1Gb0Z4OEdwTzE1cUx6aFJ0b04xS0t3dTd4OVdDWFBBUjAxWE5xQ21i?=
 =?utf-8?B?bmNRSU9oMGFlOWJQNWxUY3VWdktqR09VSWFBYWNEYXpob3MxcWNRUWxUTnoz?=
 =?utf-8?B?RVJ0M3drL0dJVFVVOWxReW9rbVZhMHg2UVJZbk9VbFpWamQvU040bU4vSlcv?=
 =?utf-8?B?ZGY0ZVNIVWx0WFFNaFNSWWQvVTFZZDNwd0FrZVNpTUpnYmtndm0wamI1aFdi?=
 =?utf-8?B?YzY2MFdxNjY2WU1QUE1zOVgvZFljM2l3YkJUNm5LWFZoWTk4cSs1bHRGOXd1?=
 =?utf-8?Q?iyS1Nqf5Y8GBJ7lw=3D?=
X-Exchange-RoutingPolicyChecked: e6CeqQi/8IGP2xYKhpMMWrcTTypFX9Rlatm8OQqMzCnpqz1+KhVT2ZIMLYCH7PJJB46Y+EevQZH/08ODXAsfID/91dWZla6kuY2jSmV24Y4Ehp2N/h7tiZqcy+bwQLnlTIUJDp1WX2G/kQYRZaQebRLEz6lrvJnkckYASwF4alyBP70NfteoQelXD5b/jFDmQZrSgGi5Whsd1lCseZvj4V+i7c9MKsaLshDnxKpJ64boqUDxYbXPspJJsBxS4pWGruVVT1X5gQrgTzH0FXATYqE0ddXm1HAnZq4RWsMt9VI2Ywsm6hFNgHBEowEQnW3R7DnX/v0df2IBzAXVdXOFGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: be94305d-b75c-4c02-1f17-08deed6dcda8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7554.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:34:59.2047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kM2J2GI7GcB4a1H9P7q3O97cSeUOByK4AqNY9vxubUSmB1apXGZp2+hn88HhALEr3YrbHChHQrdOIky2duFsWCoJWlvrKFhmbjHiv9gi4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7492
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


On 6/11/2026 1:08 AM, Alexander Kaplan wrote:
> The PCON max FRL bandwidth field lives in byte 2 of the DFP Detailed
> Capability Info (DPCD 0x82 for the first DFP).
> The DP standard defines the meaning of descriptor bytes 1-3 strictly
> per DFP type, and for a DisplayPort type DFP all of them are
> reserved, with "read all 0s" semantics (DP v2.0, section 2.12.3,
> Table 2-183).
> The FRL bandwidth field is an HDMI DFP extension added by the VESA
> DP-to-HDMI PCON specification.
> drm_dp_get_pcon_max_frl_bw() however parses the byte without checking
> the DFP type, the branch presence or DETAILED_CAP_INFO_AVAILABLE.
> Without the latter the port descriptors are one byte wide and
> port_cap[2] is not even the right register.
>
> All neighbouring helpers parsing the same descriptor are scoped by
> the DFP type already, see for instance drm_dp_downstream_max_bpc()
> reading the same byte and returning 0 for a DP type DFP.
> amdgpu's DC parses the field only for HDMI(/DP++) detailed types as
> well.
>
> This is not theoretical.
> A Synaptics VMM7100 based USB-C to HDMI adapter with a macOS targeted
> firmware advertises a DisplayPort type DFP with the type byte
> replicated across the whole descriptor (08 08 08 08).
> i915 decodes that as "PCON limited to 18 Gbps FRL" and prunes every
> mode above ~750 MHz dotclock, including all the 4k@100/120 modes the
> sink EDID offers, while macOS drives 4k@120 through the same adapter
> just fine via DP DSC (and amdgpu's type-scoped parser would ignore
> the bogus field as well).
>
> Only parse the field for an HDMI DFP behind a DPCD 1.1+ branch
> device that reports detailed cap info, matching the type-scoped
> field layout of the spec and the rest of the helpers.
>
> Fixes: ce32a6239de6 ("drm/dp_helper: Add Helpers for FRL Link Training support for DP-HDMI2.1 PCON")
> Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>

Thanks for the patch.

Added : Cc: <stable@vger.kernel.org> # v5.12+ and pushed to drm-misc-fixes.


Regards,

Ankit



> ---
> v2: add an explicit DPCD_REV check like the neighbouring helpers
>      have (Ville)
> v1: https://lore.kernel.org/r/20260610174819.6258-1-alexander.kaplan@sms-medipool.de
>
> This patch is part of a set of independent fixes for the USB-C to DP
> to HDMI 2.1 protocol converter (PCON) path, found and verified on an
> ASUS NUC 16 Pro (Panther Lake, xe) with Synaptics VMM7100 based
> adapters.
> Each part stands on its own and can be merged independently.
> The other parts:
> [1] https://lore.kernel.org/r/20260610174413.5881-1-alexander.kaplan@sms-medipool.de
> [2] https://lore.kernel.org/r/20260610174807.6231-1-alexander.kaplan@sms-medipool.de
>   drivers/gpu/drm/display/drm_dp_helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 9c31e14cc413..e623ccb4c1d8 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3686,6 +3686,18 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>   	int bw;
>   	u8 buf;
>   
> +	if (!drm_dp_is_branch(dpcd))
> +		return 0;
> +
> +	if (dpcd[DP_DPCD_REV] < 0x11)
> +		return 0;
> +
> +	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) == 0)
> +		return 0;
> +
> +	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) != DP_DS_PORT_TYPE_HDMI)
> +		return 0;
> +
>   	buf = port_cap[2];
>   	bw = buf & DP_PCON_MAX_FRL_BW;
>   
