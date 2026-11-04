Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CB606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gaa//FfL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D50A10F055;
	Wed,  4 Nov 2026 09:09:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA9B10E857;
 Wed,  4 Nov 2026 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793783362; x=1825319362;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=mWFmE3KujgJ11WBX2wWivkPxjJAVDx/QCDNPoZtP168=;
 b=gaa//FfLk1I7AIeGjx6gc33VDkThbixx3IkN08haX0izdKA7iQijGN7w
 yjsdxECIjwrvICAMIWbHsVag+Ijzt4QoJ4voffkTs5jSAia/2lOurYQkz
 uYR+son/7wSpLxlsvUelWSVytNhXpalVrnyBtMMBvNFkGqiIp6N8h5W00
 RF0rGij1ayQYePsvInGOvv8qziDNu7orPg43MEJ3+pYy80NXc/rGmGFGi
 UAryeFoMhboNpkm5Xcf4R4YDji5dT9W6R4pE1fE471r2dl7VtRKg1jdUD
 bYL1db+nkbdmR/nJ9QQmkaLlRMmIu6RmHkxGiSZ9tx7t/CcaAsUNJV46T Q==;
X-CSE-ConnectionGUID: sVE9Etw1SS+pg6rdOJK+sA==
X-CSE-MsgGUID: 5W6s4AxGR5yRgvEWKp/YTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2431311"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; d="scan'208,217";a="2431311"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:09:22 -0800
X-CSE-ConnectionGUID: ELcAv+jpSoaqfzizigdGtg==
X-CSE-MsgGUID: DO9m4D8oTJOoAuOCLc5XAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; d="scan'208,217";a="6486930"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:09:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:09:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 01:09:20 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6pAxYUEUTpSbafstKGaDG+Ch2L7soT0ZtbGA26ifP+kAeqL2IIfY1VCtKbIkwwvXze6WAEAhHiQvWAS8lQRlarVJh+vanAj8HRcc19jPgGscRrgFu0OaiGlvmos0XMt2pUqzGuGN9r8XFtm7KI4DgOABF5t7jG1XAUr1w9z2pSUwgvPP+/zBfJnqwmOdJV4CJMXvljHCfBL2G97PlsZrwFoRLeq2EH0qk3MZMAdsKL8B+oKHbclDVHvU+sgkVjzAkwblmkvGLMQM64OsD7zeBIutlEO0szqkh9/DNTzbnDfjieE2cv1qMkXsmfoHWREz4RGsjwQI0ZGCQN+TOtFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x42a7W5l6ZxQ+wp1xcnaOmsyX8S1jy2fpU+2H6YN9vw=;
 b=kSzemg1db/nbF/RvqW0F/FdIsQWq6hXX+zzwFKr5g3RZCU77Amwot3dArex5tp/SUKr5znrwINNIbmT0rK/KN3cmcznQEy5S0ymYYCFuzCt9uhVrLn7LEkcVlwnd6g5yuhAEn2CMu/77AVmHm6vcu0TQPSBqX/mRBM4e1dCcTXQf+wfX4UYwmoiMr5Fy85Cq0Qkacw1oxjlnDNyuWYk/90RFx6JR7DrmDSAifdio1/nrpHyhnqsbdfPrMgkgK9CUOhPIYY7ICsRDgRsf11wFk1CMo7Kpr59GFTAfJe5brCg/JDd1ULemxOXWX37JH1aIrQaxkf1vgqbqvr32oWGMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV0PR11MB9792.namprd11.prod.outlook.com (2603:10b6:408:385::5)
 by DS7PR11MB9449.namprd11.prod.outlook.com (2603:10b6:8:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:09:17 +0000
Received: from LV0PR11MB9792.namprd11.prod.outlook.com
 ([fe80::1b1f:d9a8:ce76:e9d8]) by LV0PR11MB9792.namprd11.prod.outlook.com
 ([fe80::1b1f:d9a8:ce76:e9d8%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 09:09:16 +0000
Content-Type: multipart/alternative;
 boundary="------------cjX9UgPMKZY7AZSh2gg8onUj"
Message-ID: <3db89536-4adc-4b97-bf7d-cf1f466da1cc@intel.com>
Date: Wed, 4 Nov 2026 14:39:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Matt Roper <matthew.d.roper@intel.com>, 
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>
References: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
X-ClientProxiedBy: MA5P287CA0113.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::13) To LV0PR11MB9792.namprd11.prod.outlook.com
 (2603:10b6:408:385::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR11MB9792:EE_|DS7PR11MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: a11c5600-c43b-4887-5406-08df3a534d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|8096899003|261009221227099003|56012099006|261009220027099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261009221727099003|261009223027099003|261009223327099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: STqcZT9ekIfD8+qNmDv6qjMKJEs2/FISGMRWseoBCnpTrF2PNbmvAXt+0+l4qPOJhFKIKDiYuPh38xt90lhOEJpFfbt7RlEm2kusCjpDNkGfDp4AtFGIisA84aUoAbgHXYLk1f9Ub6otFYMy8YZ8263BiXRfOpDIUGEeg84K4RJvK2yXOWhIxO3W1WU+RNQ60B/yS/z5YWFFV9OaSRe3qAOCrdF9IZz0QQ5UTZ/KmZ1ynDpTmhrMI3axcEOSpDjMND3uD8xNbRfMxIYgP/+0H5SZqfHwGa0E7AjLBti+IewUv6yGpGuJmE00g9ykr4RCa8yNNfSRO61Uw0zVGGYzVVh4dVMlAsveR0a+GRAprQJi6DrEAUOJSvfgkC2EkV+KqhbJWIeiXLFJufA0mPDvP7x9RQiS9NTuZmli7brbJ7X2jN+K4PBpKAKUp1PrOi3zwMFxSPt+LkFLEP7yDLSJeTRTAV0Evf1AOivOjSkaRtH+ODKC3WKd2Px7S/PNFwapNIw0tS7vKMsQdukEaMxH8INxDu77n3lT7PjkgCqMciMe6MTC+wwM2HmU4vjvXTSnWJyuVO8J80LuQ9b4W4OKCeCjwTnicXNYi8KqGxOAWBhAYH7Bc5Btm/tQFhsfSY8YDDE8cE/JAPcjrugGKpRO+hBJGFMAyk2HIbGz1s8hMQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR11MB9792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(8096899003)(261009221227099003)(56012099006)(261009220027099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009223027099003)(261009223327099003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJ4VHk4VTRKZUFVMEVaYnAwdzhNcE1FVnJVYXFhK1lJVTNERm1veHAvK3Q2?=
 =?utf-8?B?TVZaWlRxVnlIRTJaeWtzMDJnTTlOS1p4M1pvZmQ5Y1RyY1pjalYvUmFSeHhZ?=
 =?utf-8?B?dkNjNFdibjlkY2RqYjVvTEJWK3pyTVArZGxxWU1nYlliZTgydTdHY20wclc0?=
 =?utf-8?B?U0pzb3FxSjhpekh1NERFRGJDR2MxOVM3dWhVdHhLTC83bmNwbTM4aGZHZzV1?=
 =?utf-8?B?aHlVZjcvU3BLanF0UW5Rc1kzcG5tbm5oc1I2SVhSajlSWUxZRDYzWTRDaHNF?=
 =?utf-8?B?eEFiemhPSkZEeTRkZTlURFFtYzk1SjZqaVRCMC9sckpmL1g4bDU3TjB0MEdE?=
 =?utf-8?B?VWpGTk42WWFKVUpHOGk4SG1LT2xpSmFLNHN4R01BZ1l3UUNrdFovaHZkNDhw?=
 =?utf-8?B?akl3WG9XZXE1K2N3OGhiMzRxVTY3UlZIQUJnblhpRzJrZzd0b0JNbTdQZHV1?=
 =?utf-8?B?eUMzSksrUkVobUlLWDRVL1Vvb0lzSXkvWDVlMFBnMjVJaEVyUkNYemhZUzh6?=
 =?utf-8?B?NWpHR01TTGtkeXBRYURxYnUzaytrT0FxQjVVa1hlR3JVTjdPSHFBYVlpeDc5?=
 =?utf-8?B?R1BpcmZsczdtcHFuRTMvRkp4eUhtYkZMMi9vVXUwWHdVMlpJVlcyeS92UnJ0?=
 =?utf-8?B?VmVkS3NtOC9oQXp1Z1ZjYXBmWFlEenp6WEV3bnJER1M3REZ6WENBMGZFRzNv?=
 =?utf-8?B?VHY5QnJldG1TVmxoR1FuSnhYQm9JdWM5SzNwcTdzZEpxR09XYVdhd21iWmo4?=
 =?utf-8?B?ei9EMFQ5UkUyeUViNzhoejlNaFNDYjRhaDVRR0pzZjN5MmpudzZvbXJ6QTBF?=
 =?utf-8?B?OE8rTFRMRG14QnpSR3RhZUZ4UUlnZk4xQ2pjaitUeTVEc3dmL1BHU2srb0w3?=
 =?utf-8?B?UkFTTHhYeERnOFhMYXFLTHEyS2t3Yllobk4vTE9oMytVcXlxQUh0bEZrN1dN?=
 =?utf-8?B?NTl6eHdrandGMWd5bElSUHVESVpWWllVbVR0WkNtQTdNVXBSdzg3UksxSW5v?=
 =?utf-8?B?WVU5NGNZY3JvUy9uU1NnVnk1VjVLU0VvUkEyM2I5cXNCK2RPandOYVpaR2I2?=
 =?utf-8?B?bXZVeitobGxGT29qcGhCTlpQTGl5YStZUWZtV24wYXIrL3ozc0dzWit2Zkg4?=
 =?utf-8?B?MUUwQStSR0tnbTd6M0FOVjZwalZjNUgvcGRNaC9xQnZMZ3dQQVJvOW9IYlZF?=
 =?utf-8?B?MVluaStZNk5ud25ablR6STNKK0NmKzJ6TnpOazlXbFFZQUxTd0tSbHQ4MHpi?=
 =?utf-8?B?U1huMEZmOGxxUnBTZEM4emczVU5XRDE3eG5LTWpBTFRRT01HdFlnUldSY1lR?=
 =?utf-8?B?bC9uYS9DMHY1MEM2aVkvMlRWcSt5TzArbEZrczdUSGlHcUJSazFDejBsT2x3?=
 =?utf-8?B?bTZaenVkRVpuMW5LUHFmNC92a0Yvd2pjdzhzMGtuVXdzM2xnSjdIL0FnTkVO?=
 =?utf-8?B?SWpLb3lSOUlxL0sxSlVMYkQ0NXkxdFJhWVdET0FxRURHMHZGcE5oUi9yYnAv?=
 =?utf-8?B?M01nd1ZqNy9rNnBCeW5UTUthWDBWUVgyVXZUcXV3WjBjV2t2cXR5YWxkRmUv?=
 =?utf-8?B?MDFiNlF6Y2hQbUplNGlrcWxldnFPc1crbGJpZjk4Wk9sR3c5TkZWL2RzYnhq?=
 =?utf-8?B?MVJYQ0ZyS0ZwVENjY0ZTMlVhS3dnZlM5UFhKWWtqMTBMUWtiVVAvTkl0QjVY?=
 =?utf-8?B?WFg0MW9pQ0swcHhsSnlnYWtMZ1hPS3BhVGRvYnAydWlTYmVyK3UyZDlnZ21k?=
 =?utf-8?B?VE85eVZnYTJZS2ZJdTV6d2JteXhiM0NQWFVYa0tOWkRHQ3RiWHkweWZ3blJp?=
 =?utf-8?B?bkY4aktUT3d5RGEza1dOS2M2L2lUKzYzQ216NSswcG1EQlBpZTZVWWJlSHRK?=
 =?utf-8?B?SjcrcUJXZTNUN0kyR3NZZVNSVVBselk4a2RHYVFtWEVPaEFqRDZxS1IrdUZY?=
 =?utf-8?B?djhaT2g0OVhDdzV6VW5Wc1dCZG94Ky9mNFFwL2pPMVZhWmZVTWp6RVFNYUJF?=
 =?utf-8?B?SkFjamczUm1pSUJTQ0NkRU5WWm9rNm9lZEU1TWVVZWdDemNkNkZmL20vOVNq?=
 =?utf-8?B?dGNXSzhrVVdnYXNsYWl3cldRKzZvTmYyZnJxS3BEOElKVFhMUHRwNWx4Zjh0?=
 =?utf-8?B?TGZkaEs5OC95U3VxK3BFN01WZ29nT1NrcksvdWV3L0NMMkNkYWdJZklyT2ZL?=
 =?utf-8?B?RzVMVFd4UzhSVGF3K0tHZ2wwaVlRZGU2MmFZT2tSbytDNjh3ZlgwL2lxMEJN?=
 =?utf-8?B?enZoVy9rdkJRQXFtdkEvaDNlaXdncnJPK0YvMVZzdTBEK0xEL2V0T29MS1lR?=
 =?utf-8?B?Wm5zUGFyYzhYb1RTYmNZUWJ4K2VHNkRqNmtRQWhXZ1JPTmpSK04xZz09?=
X-Exchange-RoutingPolicyChecked: 3pVqxgO7ANmitAWeCWixz9DwRGnmIQek5WbsNMq29pueyRHYKn+3NmGgFMqPR7Sa6C2QgyCoHDndXORGUCYhTxTF2SwAYIsOoICZ26k5wH8U2HxtMO9znjbMF9j3a9DtrrzuyUTy5cmTNdRF65EGMUOBIIR+lbdSNSwsQmoxSbPyRue99t4SJ+t9b37/sMK+VzJQPOzaYjkQM0eFQBMl/b0NkDKsIRphxeAGNSP0QLIXG3E8KNopt0OLxOMbe07sxxbLL7PK/n9klBeowkvov3l421ZAxbwjAcBHfklZprkd0c2lmOtQRULqvTZcgSaH2JyGsFudkrcEnQQqLEKx5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a11c5600-c43b-4887-5406-08df3a534d74
X-MS-Exchange-CrossTenant-AuthSource: LV0PR11MB9792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:09:16.6856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P/RvBwlua7kIoIqF0bf5Nj4Ll/jTHkhx9s7h6WdC31kjOvXD0wrVX80kQ37L+/GHWPUOICltRLyk9NC4Xsj0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9449
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------cjX9UgPMKZY7AZSh2gg8onUj
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 30-10-2026 22:47, Alan Previn wrote:
> When user requests to enter survivabilty via configfs, or if
> check_boot_failure is hit inside xe_survivability_mode_is_requested,
> no indication is published. This patch adds some awareness in dmesg.
>
>   v3 : Limit message to xe_survivability_mode_is_requested. (Riana)
>   v2 : Remove / modify messages to reflect underlying behavior. (Sashiko)
>
> Signed-off-by: Alan Previn<alan.previn.teres.alexis@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_survivability_mode.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
> index d73cdad0b3a9..344b402eb728 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.c
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
> @@ -413,13 +413,19 @@ bool xe_survivability_mode_is_requested(struct xe_device *xe)
>   
>   	survivability_mode = xe_configfs_get_survivability_mode(pdev);
>   	/* Enable survivability mode if set via configfs */
> -	if (survivability_mode)
> +	if (survivability_mode) {
> +		xe_log_info(xe, SURVIVABILITY, "Boot mode requested.");


No meaningful information here, so xe_info() is sufficient.

Thanks,
Badal

>   		return true;
> +	}
>   
>   	data = xe_mmio_read32(mmio, PCODE_SCRATCH(0));
>   	survivability->boot_status = REG_FIELD_GET(BOOT_STATUS, data);
>   
> -	return check_boot_failure(xe);
> +	if (check_boot_failure(xe)) {
> +		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
> +		return true;
> +	}
> +	return false;
>   }
>   
>   /**
>
> base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
--------------cjX9UgPMKZY7AZSh2gg8onUj
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-10-2026 22:47, Alan Previn wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261030171738.674775-2-alan.previn.teres.alexis@intel.com">
      <pre wrap="" class="moz-quote-pre">When user requests to enter survivabilty via configfs, or if
check_boot_failure is hit inside xe_survivability_mode_is_requested,
no indication is published. This patch adds some awareness in dmesg.

 v3 : Limit message to xe_survivability_mode_is_requested. (Riana)
 v2 : Remove / modify messages to reflect underlying behavior. (Sashiko)

Signed-off-by: Alan Previn <a class="moz-txt-link-rfc2396E" href="mailto:alan.previn.teres.alexis@intel.com">&lt;alan.previn.teres.alexis@intel.com&gt;</a>
---
 drivers/gpu/drm/xe/xe_survivability_mode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
index d73cdad0b3a9..344b402eb728 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.c
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
@@ -413,13 +413,19 @@ bool xe_survivability_mode_is_requested(struct xe_device *xe)
 
 	survivability_mode = xe_configfs_get_survivability_mode(pdev);
 	/* Enable survivability mode if set via configfs */
-	if (survivability_mode)
+	if (survivability_mode) {
+		xe_log_info(xe, SURVIVABILITY, &quot;Boot mode requested.&quot;);</pre>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px"><br>
      </div>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>No meaningful information here, so xe_info() is sufficient.</p>
    <p>Thanks,<br>
      Badal</p>
    <blockquote type="cite" cite="mid:20261030171738.674775-2-alan.previn.teres.alexis@intel.com">
      <pre wrap="" class="moz-quote-pre">
 		return true;
+	}
 
 	data = xe_mmio_read32(mmio, PCODE_SCRATCH(0));
 	survivability-&gt;boot_status = REG_FIELD_GET(BOOT_STATUS, data);
 
-	return check_boot_failure(xe);
+	if (check_boot_failure(xe)) {
+		xe_log_err_fatal(pdev, SURVIVABILITY, 0, &quot;Boot Mode enabled!\n&quot;);
+		return true;
+	}
+	return false;
 }
 
 /**

base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
</pre>
    </blockquote>
  </body>
</html>

--------------cjX9UgPMKZY7AZSh2gg8onUj--
