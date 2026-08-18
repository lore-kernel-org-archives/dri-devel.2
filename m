Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93310C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED6510EAAD;
	Tue, 18 Aug 2026 10:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ixKVgjbo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6179E10EAAD;
 Tue, 18 Aug 2026 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047776; x=1818583776;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o7q6QUWiXEG7fSrSzjL5Pb7Uf6BpAhHao3JghC4WTTk=;
 b=ixKVgjboYVSNmuNvkCHIlHOe8bvnHEgZNnlgnabCdeGz8WK39p81czAj
 d6zXgwsqfbKKp2STui0AhnJEzlUuxHKNEFqy+0iTEZ3qxwg0e3Xv7XPr/
 AhMuUnYH5ODPBZsdXvpyXBKfO6DKkacum7ZKDXNU0ingshfM/pVaVXGZt
 HPTHJC9oIxgOizkiLyIwbJ2ByIBqSSN2jQsg1wDvwpeYXKV1WfJx7OkY+
 0vacWbAt4ORkqOQovfofwoThPRDo4i76DM0npQbmpF6QXVZmtcuIECEhG
 CUNP8PKRQXN/xKwAHS77lScJpuepwlaNH1z4DdX2XO/8rk0SBSyBtnX0l A==;
X-CSE-ConnectionGUID: zZ7BErVSS6e6Gr7/HJ7cRw==
X-CSE-MsgGUID: l3qn2208RpKSn0l8WOJDAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87451954"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87451954"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 03:09:36 -0700
X-CSE-ConnectionGUID: VbHxqAJfQD6FYNSo9iqyHw==
X-CSE-MsgGUID: YoP/KmYoSy+qYd++U42o1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268692394"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 03:09:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 03:09:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 03:09:34 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 03:09:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFdhTEIWTpvQHC0kOTVh0DUqIT1hlTsh+gBO5DLwgmcafG7s9rnGFnFkavIvvC1jOeJiL+oTHIy8AJViQjlZ0pivAKMwk2OOD4xbq8NTB13EVwNR0xuLMhFiEtAfaTwsXlCHCPauHHYiRmrDiYgDBD6tBtA8y+LvdtnP9WklKvk8TlYJpDgHC3Kp1IAKVwfPdtsfYTpaMN8w5tSSPTDnRXwyu4BOinfxNZGV0z4JMLAyBt56m4+KIBHgYV623aY+vzrB/zxpUdZWtpgnplJ6GYHLW+UjvleZPXVEOK8fiMx2V5KTJGi29gMX/2M/8iwPm+e8AogQhQBUoztgEIXqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HObVzYUhl+8o7XCdy4NaX1K/LKq04ledYmZI+VAWnAk=;
 b=sKFF4ENSa/cj6wz1oQLeSAgZaBZ2dKqTvcztTtk1PuSMbiX6s7SEvwqbtgQXUTWY0ET6EbMhsojfiMx5edODk0UA0MH++iJgdw+C04cBmtwgmfKzEKgnPUzAVJWJ6hJoXlfCM9lu8PgkGcd0C+vdfh5tppabXyqxET+7zPrrGHfAwapHA4jai9ne3PWLF04tD/IMsSPEIlLxmol+4v6htmtLVlyTK4W1h443xcAxesLmpwekEWpdQYDdPO0r7/6q64wKe2pniP/36gldbyjJxBaNvBDXYhTGtmCR48daJXQrZHoR1l9AqWMYfHRhKp0hvJPA2zLA8m/3xO3H1IaI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 10:09:32 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 10:09:32 +0000
Date: Tue, 18 Aug 2026 10:09:22 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 8/8] drm/i915/selftests: Use drm_* prints in selftest
 headers
Message-ID: <vn6eganavz42ezpi35nywzvuastw42jpxonbvcxw4i6df7yrd5@aavczwq2gh6d>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-9-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260818095624.3254368-9-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU2P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::30) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: bae00718-34a2-48e4-845b-08defd10cc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Rv10o5AqW6936YAvXLLRdHCwv71f/s19nvCr/FOLw/1x8NvEFCTtU71kYtUIk5/XLBFexn2jWDBjAQdN7CosZgC6Z3u2YIeVFZ4CljkMGb9lG7zUEOo3lsFM5wSVCsQSt1Mn014ReAc3Ind7CrljmOXBYNbUaj3N7leouxRkmVNokfxRsv7pAsLpMJ3ZubbSymdovpuxl1HZppSEiU16PHMV3dJVfaFU4Efni0Nz2PkJM4/VSD9o+CWfi5ChQo5xopThr26VhYIdrDEC9yG//fnskXYoIRhL3h52nWIkiUPcZy3xrBVkvoQG8DyE19eFTJauCI4e1RfBH6wpucbhmc2SB+8/tc+AvkaHf/D+Z68SbyVSR132OcESkkqTTjjdrgRGWzf+8xNuKz6GEJc0mOzQhbg8+HUZcro29JzPHqUwRhVar4NqDm6GY15Es01isIpKBkZZBKP7f0N7wqRRraMDfvbNv6NfVcBKeSHAY/6QvDOD7IMk6PkUjFbFWn063yqJ5YC6zeJK94Vf/c241HeR03lH47Mmjal7S/ucLdr/MCbUnk+BwwXtQJ2HbR/bEIdU9rIWOqcRLdSbqUeKa1bgaJ+4Ltk7yMCWPeIRz6oDi79WePhgP/E1WWijoWFKWsob1DPLa6/OlEbU9w9b8ZBR9AQ6Ta962EKP9elQz4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJzSTIyVVVYczZ6M280ZzM3bHRNWXRWNkd3TXU5K3lyeGE4MWZCdWJaM2t5?=
 =?utf-8?B?VTBFOWJvVUhvWnFBQU1vUVlLSmdZalh6QVJYY1d2SUhuU0ZvMUN1MXRxbkI5?=
 =?utf-8?B?Ykh0Z0FBeXhoQW1jUGxEdSsvRnVYWG1wMHkvT3RmU21FejdCMFY1WHhPS3JM?=
 =?utf-8?B?Rkl0UmhQSmVwcms0VWJBRUN4a25CRmhSeFZNNTdzU0U0bkhBMFJYV0JsVFY4?=
 =?utf-8?B?Vit4QlprRUV5aW9JT1JRalhteSsrVjBWM2ZHSUhQQUZLYVYxWFR2LzJ6VDYx?=
 =?utf-8?B?MURxNU8yOW5CK2ZaeWZvSUdOZW9GZ1l1b3BKa2xIWFg5UHQwaEo0Vkd4S1A3?=
 =?utf-8?B?NVB2L3V0NFREa0xNaEpXTkdSYkFPSko3YjdLeHJSckVMY2xnNnFkaFVUbktm?=
 =?utf-8?B?K1drNFlkYnkrTHE1ZkRtNS9JckdCR04rYTBKMmhYNTllanNvRXdsaTBlTFlK?=
 =?utf-8?B?TkRuSnpvRFRkWmQ0K1M1NjBrbzhxSEh3OW9weHJDL1dGM1VoZk5peGRXTU5B?=
 =?utf-8?B?SHhXamRjNkhhQ0d4WitoNVFJMWI3UFB3Q3d6b1RDMHJtUzFnbWlnNE9NbUY4?=
 =?utf-8?B?cE9LaHVoWW5WakVDYUlDN2FoSWtlcWdCSmZTSWcrc091RzlHUmluTWRBVy9y?=
 =?utf-8?B?MytBdXdCKytMekkrNUdmeWVNcnp2WUdZM0s1QTNDcXF4UjNVZGJJRlF6alN3?=
 =?utf-8?B?QW9EYjFQNVdrN0h3Wk9jLy9PSmNXaGVZSkFBbkIyYzRzQVdwZW0wRnFlY3Ay?=
 =?utf-8?B?b3ViSXh3YXI1aTl2WG5lc2hMUUNqdHFkQmxxdzA3dXh2dllQZzM0OGN0RUIx?=
 =?utf-8?B?cHY3ZTUzUkV3WUNGZUcyNWFZUDhCOWFuL211b3BVRkdFODhocmN3R3g3Yitm?=
 =?utf-8?B?UGcwSHBJSGxmd2ZYaHl0SHZnWU1EQ20zeTBXTDByT25GbEdhUStQVm1lVk1O?=
 =?utf-8?B?TVNtUlloWlJNNXI4TFFpZmRiY09tWmR6U0xaVXRSM09MNjZZTk5pME5FTjlB?=
 =?utf-8?B?cUc3dnRhd0JMalJzejNWRThiUUZCRFJiS1R1Z2JHaC9SMmp6UUQ4VHJaZHpR?=
 =?utf-8?B?VmNKNVMydkpOOGhtNlE4ZTNkVE9vMXdRcnN3ZnRWTlVqYVZSU1hCQWFrZ2l4?=
 =?utf-8?B?LzNuR01YUGNRbU1Hb1g3UmV0SXE4RzNralI3NjNaWXVEWnNRd0Z2U2h4aFQ4?=
 =?utf-8?B?bkZtL24rRlRoc05oKzEraWo3VTNpaUNLSHVveEZsQUppWFNuclNjR3RCVE84?=
 =?utf-8?B?dDltelBUdk9FZThSSUN2M0RLRWszS0U2ajhRN0h0U3BMVlBSTG1OL25wWUJO?=
 =?utf-8?B?QzYvUjd3M3JyUGZxc2s4RzRHTnVsbWNtcDZzMUhpVnRVOGhGc3pEekg5b0xL?=
 =?utf-8?B?bTkzbEo5K2M0NHk0R1dWOE9UWm4zZUZsRk80VGEvRk8xYTB5WndUL3hwVXVr?=
 =?utf-8?B?b2p5UE9STFlmODE3a3JsV1E4SDNjd3d0ckJzMlh6elNMc3RhS0hqZWQxdm5z?=
 =?utf-8?B?bzBvbjE2MzVKbUJuejVCUXBvQkxkTHg5dExVWkR6bFVzVWFhdEZBcGRwb2Q3?=
 =?utf-8?B?TXBXV2RSWHRXaHM0NXQ3QkZETWE4Q09iS212RUZkTCtMRVRNZFdYa1FidUo5?=
 =?utf-8?B?QkpZVkJITjl6b29uU254ZzdMdnpJWFVSUTBJUHBOZ1VDV0ZSTXVYOXJtQ2hp?=
 =?utf-8?B?enVlckx0OXdIUlF4WlN1N3RLYjJnVFJKSUxEN2hUalJYd3c1SHIrT1h1b2p1?=
 =?utf-8?B?Y2VKQk9BV1ZpeGw2YzVSNzl0b3pDVkgyUlU1NHlzWnAycnA4ZXJQRjR6YjVl?=
 =?utf-8?B?eFI2d1BFRFFMTUsvZEFqS3UzQnFLektIdEZHRXdWSDU3UEFVWWM1N3JuUEE2?=
 =?utf-8?B?TmEySThwRWNkRUd0SFoxVFRTQ1NuNkx4OU5RdXJpZW15b2tjajhiUk9mZVVX?=
 =?utf-8?B?SWhlU3ZnMWtnenprRFg5eTRZcUFYTEtTS0wvQW0vdGpsejVNTStRclJxcldG?=
 =?utf-8?B?UmxlTjJyNVNVYXVBWGlEeG54cUM0eXJHS21yc0pITU9maGtTSURFb1RBUnFZ?=
 =?utf-8?B?UEw0TlQ0aG53THpSWGs5NTRjTzRlVkhBaEh6aFFsbVljZ2d6K0tZaFlTdExs?=
 =?utf-8?B?REZ2YThzL2kxVFpndEVPVHg4U0h3WjMxUm93am5EeW1va1BXMkl3S2tubFc2?=
 =?utf-8?B?S2pnNnpqd1h6WnQ2OWl2cnBEUTk3cWZEZ0ZZMzdPTURzeFE1TXppRUp3R1o0?=
 =?utf-8?B?K293WkNPa2xMN0xHdlFZRVlBdzFtOWhEVVN4b2dLUWhOUzJGTGRuVTFxd1Iw?=
 =?utf-8?B?MHZiQjVFZ2hsajIxdFJNTzl2Yjg1OVhyS2JyaHBPbS9ERmdkZjNrTkl5bm1m?=
 =?utf-8?Q?hM924B3vV1p+ZXA0=3D?=
X-Exchange-RoutingPolicyChecked: g9niC4Mwg4Xxj4gx/tlocjqJKv2eHdTATe4a2gJZb66+5KuWqRCbYYTcrQdj9WbGAi4aXS7tcOL+B1fBkuKUUhQNGsfn5NWmVyvtUeHmeUZs0jOZvOkfdcYEqnfQZhO/854HP+vR1d8DGvNNHwyxGQSuza0qzPhwRqFwdCbU1TnyU3BSrhNMTchRSfpdm1ZNQr039YyJaQvAKLE7u9uG/KpT8TXAJudtFLChCbFF9dmh4D/ZvCf1ZfuabMkY/p1CnKB6i/m+kgD9hIiQLIdraJNVg1RaZqf4KJksWtieN9Y0hK+TQ+OvurqzxlUIyoxbhegIQEC719TA5C7jKTgMjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bae00718-34a2-48e4-845b-08defd10cc1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 10:09:31.9734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGIMJw2iVJ39atfgt8pqkQPfh4PJlGWjo0a1sGExy0CsC5h6SBPHLPGtorF4VlDIL08+YkkC9hs7LYqOkFf5i2EOdkTPKg1od9J0pz5/Yzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
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

Hi,

This last patch got mangled on my end. It should be:

[PATCH v2 8/8] drm/i915/selftests: Use drm_* prints in selftest
 headers

Move away from generic pr prints to device context aware drm
versions.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/i915_selftest.h          |  1 +
 .../gpu/drm/i915/selftests/i915_selftest.c    | 46 ++++++++++---------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index e29ca298e7eb..2e7155eff752 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -29,6 +29,7 @@
 #define STACK_MAGIC	0xdeadbeef
 
 struct pci_dev;
+struct drm_device;
 struct drm_i915_private;
 
 struct i915_selftest {
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 3adcfdab75ae..6792669dae46 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -23,6 +23,8 @@
 
 #include <linux/random.h>
 
+#include <drm/drm_print.h>
+
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_regs.h"
@@ -41,13 +43,13 @@ struct i915_selftest i915_selftest __read_mostly = {
 
 int i915_mock_sanitycheck(void)
 {
-	pr_info(DRIVER_NAME ": %s() - ok!\n", __func__);
+	drm_info(NULL, "%s() - ok!\n", __func__);
 	return 0;
 }
 
 int i915_live_sanitycheck(struct drm_i915_private *i915)
 {
-	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
+	drm_info(&i915->drm, "%s() - ok!\n", __func__);
 	return 0;
 }
 
@@ -154,7 +156,7 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
 				     timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
+		drm_warn(&i915->drm, "Timed out waiting for gsc_proxy_completion!\n");
 }
 
 static void
@@ -178,10 +180,10 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
 
 	if (need_to_wait &&
 	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
-		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
+		drm_warn(&i915->drm, "Timed out waiting for huc load via GSC!\n");
 }
 
-static struct mm_struct *get_selftest_mm(int u_pid_nr)
+static struct mm_struct *get_selftest_mm(const struct drm_device *drm, int u_pid_nr)
 {
 	struct task_struct *task = NULL;
 	struct mm_struct *mm = NULL;
@@ -192,19 +194,19 @@ static struct mm_struct *get_selftest_mm(int u_pid_nr)
 
 	u_pid = find_get_pid(u_pid_nr);
 	if (!u_pid) {
-		pr_warn("Could not find PID: %d\n", u_pid_nr);
+		drm_warn(drm, "Could not find PID: %d\n", u_pid_nr);
 		return NULL;
 	}
 
 	task = get_pid_task(u_pid, PIDTYPE_PID);
 	put_pid(u_pid);
 	if (!task) {
-		pr_warn("Could not find task for PID: %d\n", u_pid_nr);
+		drm_warn(drm, "Could not find task for PID: %d\n", u_pid_nr);
 		return NULL;
 	}
 
 	if (task->flags & PF_KTHREAD) {
-		pr_warn("Task not in userspace: %d\n", u_pid_nr);
+		drm_warn(drm, "Task not in userspace: %d\n", u_pid_nr);
 		put_task_struct(task);
 		return NULL;
 	}
@@ -212,7 +214,7 @@ static struct mm_struct *get_selftest_mm(int u_pid_nr)
 	mm = get_task_mm(task);
 	put_task_struct(task);
 	if (!mm) {
-		pr_warn("Could not find address space of task with PID: %d\n", u_pid_nr);
+		drm_warn(drm, "Could not find address space of task with PID: %d\n", u_pid_nr);
 		return NULL;
 	}
 
@@ -224,6 +226,8 @@ static int __run_selftests(const char *name,
 			   unsigned int count,
 			   void *data)
 {
+	struct drm_i915_private *i915 = data;
+	struct drm_device *drm = i915 ? &i915->drm : NULL;
 	struct mm_struct *mm = NULL;
 	int u_pid_nr = -1;
 	int err = 0;
@@ -241,8 +245,8 @@ static int __run_selftests(const char *name,
 
 	set_default_test_all(st, count);
 
-	pr_info(DRIVER_NAME ": Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
-		name, i915_selftest.random_seed, i915_selftest.timeout_ms);
+	drm_info(drm, "Performing %s selftests with st_random_seed=0x%x st_timeout=%u\n",
+		 name, i915_selftest.random_seed, i915_selftest.timeout_ms);
 
 	/*
 	 * If we are running in a kthread on a multi NUMA system and the user passed
@@ -250,13 +254,13 @@ static int __run_selftests(const char *name,
 	 * to prepare a safe environment for the mmap selftests.
 	 */
 	if (!current->mm && u_pid_nr > 0) {
-		mm = get_selftest_mm(u_pid_nr);
+		mm = get_selftest_mm(drm, u_pid_nr);
 		if (mm) {
 			kthread_use_mm(mm);
 			if (unlikely(!current->mm)) {
 				mmput(mm);
 				mm = NULL;
-				pr_warn("Could not set mm as current->mm\n");
+				drm_warn(drm, "Could not set mm as current->mm\n");
 			}
 		}
 	}
@@ -275,7 +279,7 @@ static int __run_selftests(const char *name,
 			return -EINTR;
 		}
 
-		pr_info(DRIVER_NAME ": Running %s\n", st->name);
+		drm_info(drm, "Running %s\n", st->name);
 		if (data)
 			err = st->live(data);
 		else
@@ -495,6 +499,8 @@ int __i915_subtests(const char *caller,
 		    unsigned int count,
 		    void *data)
 {
+	struct drm_i915_private *i915 = data;
+	struct drm_device *drm = i915 ? &i915->drm : NULL;
 	int err;
 
 	for (; count--; st++) {
@@ -507,18 +513,16 @@ int __i915_subtests(const char *caller,
 
 		err = setup(data);
 		if (err) {
-			pr_err(DRIVER_NAME "/%s: setup failed for %s\n",
-			       caller, st->name);
+			drm_err(drm, "%s: setup failed for %s\n", caller, st->name);
 			return err;
 		}
 
-		pr_info(DRIVER_NAME ": Running %s/%s\n", caller, st->name);
+		drm_info(drm, "Running %s/%s\n", caller, st->name);
 		GEM_TRACE("Running %s/%s\n", caller, st->name);
 
 		err = teardown(st->func(data), data);
 		if (err && err != -EINTR) {
-			pr_err(DRIVER_NAME "/%s: %s failed with error %d\n",
-			       caller, st->name, err);
+			drm_err(drm, "%s: %s failed with error %d\n", caller, st->name, err);
 			return err;
 		}
 	}
@@ -557,7 +561,7 @@ void igt_hexdump(const void *buf, size_t len)
 
 		if (prev && !memcmp(prev, buf + pos, rowsize)) {
 			if (!skip) {
-				pr_info("*\n");
+				drm_info(NULL, "*\n");
 				skip = true;
 			}
 			continue;
@@ -567,7 +571,7 @@ void igt_hexdump(const void *buf, size_t len)
 						rowsize, sizeof(u32),
 						line, sizeof(line),
 						false) >= sizeof(line));
-		pr_info("[%04zx] %s\n", pos, line);
+		drm_info(NULL, "[%04zx] %s\n", pos, line);
 
 		prev = buf + pos;
 		skip = false;
-- 
2.34.1


Sorry for the noise.

-- 
Best Regards,
Krzysztof
