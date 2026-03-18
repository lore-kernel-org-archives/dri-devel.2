Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3303810854BE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8967410E723;
	Wed, 18 Mar 2026 09:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KzMt7IMZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829A010E0B6;
 Wed, 18 Mar 2026 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773825704; x=1805361704;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4lt1ncOyaALeGT5IG4tqRcB/LG6LQf9MjdStj61slKw=;
 b=KzMt7IMZL7Hocsd9uBHCTsLIjtICcJYXgRgPEixlhKtJgsa1M+kTUiVR
 8m9XMDzqz9sdgee9otdQNNVOYKmb3KzJFgxv9K5+XOb2u2e5/0v8X6BhP
 eP0ZD/KX+f273fYAGwWuFA183H8lX6YaIoBloBtReLedbfzon7nAwEGOD
 JSZbFWrB8HcT9hkYp8LnKf3ZQdvq0wiUa+QSW0ynJcu2xxh8ODSqa9VYH
 v5BQfNn+tvSKeZoVCwDk8XH7eDymW9MOfU2pW0kaGtaYRTnCDQt4qlTzw
 9NcT1KNJA+XAPAySExIvr3V2++dwjVhpI9GGLnW3/M4kikzxKfGWNSz19 A==;
X-CSE-ConnectionGUID: QERz4ZDGSs2XdXNPNZSJdA==
X-CSE-MsgGUID: wsz0ubLsTNK1mxNyjDrwdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85571290"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="85571290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:21:43 -0700
X-CSE-ConnectionGUID: ipavuSSWRoC5iEr8uXSZPw==
X-CSE-MsgGUID: hT82G8TnRby/4wyYXDD9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218616810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:21:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:21:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 02:21:42 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYsbG0wdJXyJ/qgtdJNWliAVaKkXl0SAjbEtAjpUna+YPAJNv8WhTkXhajY5qs946sp23jK8aVKKkLNGts0/+YOyXYbRuE5Q5W53kG1Mw+GP0I3/DgXU0u9+F8TXTo9i/ezyG+zjE3LUK85BHm5ZUhCoMN4W4GzsvQcmUT3RBjnv4tdBbNvHxGoyVoRyl+Zyb5EfwKD1t19IKEZOlDD2wQio9Tc9jRG8GtZb8qCE56LN8Rsv6452MhWoSnmv8sVdlaLeTtoYjWhBgkMb/341QmVsGBgCxucRE3l4r0Bzd1EDmvyyuRs92Eqq8V8YYMkXLjOBb6wB9B9k2u2/V+Lx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGqoTTLoyChAgwYFBPBOL7Vzt9NgBNT4YbIat2BpLj4=;
 b=SldFN4uCsyps3Dh9GpqAkmw29FshFGApjObuXCLjme/HToj5l88I/rJcuo9CmN/ErMF01Qe36sm9WyJGJK59y+6xTGkbvbLZQGF8zcPMm8Uc8QCwtVr0p3aBlfaEwSeoZG0jEU+nzR0nKucVT81G/CksqDOQTb+8ocFD82XmonS3vEn/z9+y+lpCylISPyaBlHxUxkJjHwqaK5T+PaenYY9vM2rVuUb+OecrianHTrkzB4rvlXZFmbHRUWbf3p9jJmflMJsOMbWbsXS6IkDlYK5l+2zPBsuAPtTBkrz6kL1suSjDeMEADQtnX5c3746K8zkm4wXBduyt8n7HQCRWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH3PPFBA2AA2BA3.namprd11.prod.outlook.com (2603:10b6:518:1::d46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 09:21:39 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:21:39 +0000
Message-ID: <9c04afcc-cf00-4dfb-b358-414da5c13f4b@intel.com>
Date: Wed, 18 Mar 2026 14:51:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_atomic: duplicate colorop states if plane color
 pipeline in use
To: Melissa Wen <mwen@igalia.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <contact@emersion.fr>, <harry.wentland@amd.com>,
 <alex.hung@amd.com>, <sebastian.wick@redhat.com>, <daniels@collabora.com>
CC: Uma Shankar <uma.shankar@intel.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
References: <20260316210055.234498-1-mwen@igalia.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260316210055.234498-1-mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|PH3PPFBA2AA2BA3:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6ffc10-9654-4b41-6b25-08de84cfc27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|921020|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bP2nLIh52FQxwMLLStj8yfWa55Wnfuyj2xZ90KTRgbzFKGpui7c1z3Z+SoEkE5CoK8BrLDFe+4CFzz1689QgXHblfnZhNjXIxB4qWoyEkyEuNV748++Ei9Bi2BH+odG4zTWeaFIZ4CU1WDLyqIUcVHjCOLwn8NH7jr9QuXor8s1/KGcNfRA+5CaKAP+H18W705EFhNsAK3Y3s17R7UVPnSiWn88Mjw5csNS4Ax+5aTZD+9oBcRA8r/bIMjexfm67q81pj2go5wZD1j8jaAZV7rl12+miyDqYJ4PuGHq92E2630DxcC2Q/bTmHWrswADw1nPHjTQxH/EhIvr0144LH92TbibyauLmkCJa/RciifZf7YY9mTBxzmX9F1VOuSSqrFOPbWAUdZLpYghE/tuEycJr+TyHULdabInu5UHVl2fLBElUSJUiH/0ouLcD4UMYdASsu/Xef4G1LlJwWHTNTwWuysgC0vkzy4HFedY+at86PZHmf2uVRVIQDTsbTc/MqYe8UhurBHUFad3vh4qn6W+foXv7zqv4dIqW/wSyNrKvHOFhAE/wUqyG7Pjddy6eC0EVqt2ZAgazkWJCX5JjOs4aEHfven2dSt4plUKNpO6/TzH4fdfUj1I1/pF8fsAKBENCasKftoV1919S27QusdCcT0FlCN3NdUtU8XuDz75gW8YmfmDf5MgdBOoO9dHGFCEzcAwpzjuU3Vo3U+ul3GcbkvLyvdjTsV9HAYFdtr6W6DszrtWbXRZMWc/fAo/jm/duNyfzpN76L529UBhxrG3NDFs1a0h+c6H3pmUM4kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjV6Smhld2hDZUpNVk9UVU8wZHFwZnU2Wm9FaXlsS0FudWIzWGtTc0g4TW9T?=
 =?utf-8?B?cVQ1d29xOFBhME11Q0lQYWpnOTExT0toQVZxbUdGQWczOVY3cjgwVjVzdzRq?=
 =?utf-8?B?OWZNczhGaWtFQUhEbm5VVnRHcjVJY3VweUlYZEZNNWROV0VWcXBJTDQ4NEJo?=
 =?utf-8?B?bHpPaFBpQ3BYNlNCdW0zQTJEcWJyMmpXMHVwWjUwWW9aS2M2aFNoWUdQNHFI?=
 =?utf-8?B?alNPQ3VuVE83S1REL3JUY3B4RVVpeCtBMWtwWVcrQ1kweGN2alhoZlNpa05K?=
 =?utf-8?B?cVE1c0l2VjN0a0tCY0hCLy80RzVnVU1TeldKaFpXV3dkTjVWQ3hacHAveTAx?=
 =?utf-8?B?U2hSc0R5a29GNkNhUFZYSlBQWjltMmZpM2d4OGFCTWpBZ2FyTDkrMlhIeTQw?=
 =?utf-8?B?RmppYWxROUFtOHNMREttOVc2S3hPRUFpc2U1L3ovdHl5VWtMYllEeWxzalRn?=
 =?utf-8?B?L3RPQ08vVk1aQ3N2NkVzeHl2OTMvaDEyVFpHT2htRUtjRVM3aGJiNDlrV1R3?=
 =?utf-8?B?SThtUVh4UXVCOTdrcUl1SitKcU5ZOW1lTjl1cnd5cHFldTZ3TlQ4Ry8yQktm?=
 =?utf-8?B?ZTRUVWRjMkh4aU4vSldoLzk4cWVzUWhWcnpjZ1gyQTQreWdKcURQempmL3N4?=
 =?utf-8?B?VlgzR21nbFRlVW1JdWtmVEZBRlA4L01tZnRHN080YmNJY3luTlRtT0lDdjM3?=
 =?utf-8?B?Y1ZBSFBJNHdYV3JBSkJUSWFtRHRLQ0Z4SkQvUnBiSkpnNGlwOUNtc2dUUG1H?=
 =?utf-8?B?Rk5yWWJlVjdlckNyaXhyS2lrT0ZYdUhNRTdTaHYyOEkrRDdKQit5YzVMUHdn?=
 =?utf-8?B?QUQ1MmFNMUNTV2NtSlpjdWlOcGRqUzRGZ0E3Vk1UaUcrV2QyOWhJYkpDaDZx?=
 =?utf-8?B?SUtoWW9OSVZydWVOYnV0YklHK1FFUDFDRUo1cUJVWXIrSzZ5bk9QVytYcE9X?=
 =?utf-8?B?TklzK21UQWtJRTlBWDk2TEpwVmlydlVjL1V4d2RHa28rM281WkhEK3RwU3pr?=
 =?utf-8?B?MFNhd1hXOC9SU1B3RjBrWnFqbWhtT2wwTTF0NUg4WXVNbWw5aXppdXFnQjlp?=
 =?utf-8?B?TTI1Yks1aUp6ZUh0WEJwYTl4a3RsWUVZRkI5TFAwU3NRYi9JR3grV0IrNGdy?=
 =?utf-8?B?T28wUUdnTy91ekZQbnBwcWNsS3Jyd2g1UXdVZHc3L3B1Zi9lc3IwWFdnb2Ro?=
 =?utf-8?B?a284ZXdPcHBPcnAzRkE0M2I3NHVDVlZabERQRk1NZWFXcUNhaGVwWDhHNFI4?=
 =?utf-8?B?ck4vQm9VVjVuN1pBaHF6aEI1ZGxyNzZNVEJBbWFsVWYwQnBYZDZVV2NXcDBy?=
 =?utf-8?B?a0hzbVZabmVwY3cweE5ZV2o5Zmw2b3pteU9LcnpLRVIzaFlqWnVOaHc1c1o5?=
 =?utf-8?B?M1BmUXBIdHAvUEs1dXdJbjdkM3FSMkZUb2Yza1JzZHl5dFlGSStQZS9wVmFs?=
 =?utf-8?B?UlRxWXlsSXhDL2t6T3Z2UlM4U2JmNFlCK2tvelRQZng0ZUdSRklJYUlVWFVo?=
 =?utf-8?B?RUJmTkt5SDFrUEthVkJPNjZHT2IyUVpQOURuc3VzTDRKdVFsNkJTMSt5NndH?=
 =?utf-8?B?TWVsYjF0c3Nwckh0bGZhOUVJV3JQRkRVTTVqblVkZ09uVjM5SDVpZHJNUElE?=
 =?utf-8?B?aHlRb0tHYmEwQUsvdE1qUHQ4SVVQQkZuamVQczJVVVVYU0piU2lsVVZYSDI4?=
 =?utf-8?B?QUZCcSsycktMM1o3OVNxa3RQRXJCNXE0L0RIVDVmY1h6MDVhWWtxUVdiRkp3?=
 =?utf-8?B?R3o4MzVDb2hKb3RaV0t3U0hkSGN5QS96SXZ4N3NqeHVsUklXSzZwU0tXL3ZV?=
 =?utf-8?B?bVZJcEZhcndCVHU3d2JNRTJCcDM0SGlTUVdHL0FjbldJci92NFNHSVJRNndm?=
 =?utf-8?B?VlhlQm9vcCs1RHl1NldjbnhtSVJpQy9CS0M2ZWRlNlBxUkc2YjdvYU5nL29X?=
 =?utf-8?B?bjV6TElxdGwvT1diRGgwWS9oaG81OVlZbDRjOStNNVJiMlhzM1BZUFJhQ0Rh?=
 =?utf-8?B?Smp5T2N2aFptUVlTdG1xZUM2eHo1L1VCQjJiaU1Ga1JDQlJvOWNrS3dxZEhs?=
 =?utf-8?B?Vkp6T0NPNEZLZmI1RjJOaTMxbUhCVXF1ZWU0Sk8vUEdiZlgyOXplRGZDQUFR?=
 =?utf-8?B?blNoeXB3dzAyemZuemNRUU1TK1g0SXk0LzBGb285dFRSa2xIeUJKampSdVJh?=
 =?utf-8?B?NjczbGRKVWhNOE1mOVZhWnBFWWorUkMveXlZa2F4WlJmMU1mL0FwbkROeHkz?=
 =?utf-8?B?S29kL0VaS1FQUkFxdlJLb1RRMG56TktNVGMxQXUyWG9Sc0ovcklJd1ZrMFox?=
 =?utf-8?B?ZW1sVzZuVzM4NGpWRFBkLysvajhwcWVQYzI4bEU2b2tENFY1dzRrdWNwRE9T?=
 =?utf-8?Q?+lYu781Wde93Ncms=3D?=
X-Exchange-RoutingPolicyChecked: GB8WZzNqSdSeCf+M8lOJmIg7wNyzIfRveuFkqvsdOH2JOsTTmxEvasi3+Rn0nZQSNKZ4uNzKmmzhuZmw1wbH/sOvYnW1Cacp9kZG/UIc//pjRdrHCnOX/Ez9ej8b+BU8qn88kLquTErAGP3tFJ7jV5MDTGJm+ZTZGtuvJSvAy7eCQz9a1hBnZ7FLB0zgZYfoigXCyG8EesXz2JIAoO653SlwFb1oq58FtaNm5mIZNzLyQRIur+Z6Ki1m9eik3C4a0mWN4i6OBS2vlPCrWgT2a3xgmnWFuZHw3F2spUalvum7BK+HMmKkzOM8WsYEVpIrVQX0C/YF/2aBvpFvS/fgMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6ffc10-9654-4b41-6b25-08de84cfc27a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:21:39.3074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ak7nB+FyPIWnVeiU/fxQuP1VewvGYEXyU1FvzdrOn7nasBa+JVNVyK+Z3TXpDEozz7O218CxSOe6ebp476NrjJnp+UMyld9tf6fjaY2NWIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA2AA2BA3
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



On 3/17/2026 2:22 AM, Melissa Wen wrote:
> For suspend/resume to work correctly, do for colorop state the same we
> do for plane/crtc/connector states: duplicate the state of colorops in a
> color pipeline if it's in use by a given plane when suspending and
> restore cached colorop states when resuming.
> 
> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
> 
> Hi,
> 
> I've been working on making gamescope use KMS plane color API, instead
> of AMD driver-specific color properties [1] and I found this issue
> during Steam Deck suspend/resume process.
> 
> Initially I thought I should also set plane color_mgmt_changed to make
> AMD driver reprogram the color state, but looks like it's not needed
> (still testing). Therefore, I think the change here is enough to fix it.
> 
> It applies on top of drm-misc-next and is inspired by commit
> 6955d6bca053 ("drm/atomic: Add affected colorops with affected planes").
> 
> [1] https://github.com/ValveSoftware/gamescope/pull/2113
> 
>   drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
>   include/drm/drm_atomic.h            |  3 ++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 26953ed6b53e..683a0e207f71 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3751,6 +3751,13 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   			err = PTR_ERR(plane_state);
>   			goto free;
>   		}
> +
> +		if (plane_state->color_pipeline) {
> +			err = drm_atomic_add_affected_colorops(state, plane);
> +			if (err)
> +				goto free;
> +		}
> +
>   	}
>   
>   	drm_connector_list_iter_begin(dev, &conn_iter);
> @@ -3856,6 +3863,8 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>   	int i, ret;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *new_colorop_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc *crtc;
> @@ -3866,6 +3875,9 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>   	for_each_new_plane_in_state(state, plane, new_plane_state, i)
>   		state->planes[i].old_state = plane->state;
>   
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
> +		state->colorops[i].old_state = colorop->state;
> +

Nit: Just to maintain the object hierarchy this could be moved above planes.

>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
>   		state->crtcs[i].old_state = crtc->state;
>   
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 0b1b32bcd2bd..96fd32a3e92c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1102,7 +1102,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   		for_each_if ((__state)->colorops[__i].ptr &&		\
>   			     ((colorop) = (__state)->colorops[__i].ptr,	\
>   			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
> -			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
> +			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
> +			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
>

Perhaps this should move to a separate patch.

Otherwise, the changes LGTM.

Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>


>   /**
>    * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update

