Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D82C5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A475710E0A5;
	Thu,  6 Aug 2026 12:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FlPHIRJF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2272C10E0A5;
 Thu,  6 Aug 2026 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786020955; x=1817556955;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=Vd7/AXiHYxJLISZH4SjKNoHfd+xkzg+suxg1BcPS5bA=;
 b=FlPHIRJFBOuDv2YC9YCSAuqIuaVVoRYrpQ4II/N1us7TZC80BxZhL9+a
 mhcUGNuQ9IUwPbnuqH1SzLs9489rh7bRaPAvNc58jHBJHZS2CYwGlr5iH
 EjRfTFI4m2kQqDdKY6J6vTGB4UjRzNzNutUar3yfIYuSw3WBZaaTAQm3p
 aAceWrk+vZ+hJb5nJL0epE5++t6oNGqqTxOefKzoOJU7fgNjU4B2mIvMs
 64n2Czk5NOciqay6JYtobSBY/3wHcPKzw7vNgV4cogWW5OJEiuciv7wtC
 8jOJfHL37kHFbYYl7GdEDztdjFue31GfZXZN4oz7JbWzwfpC3GB7TNpZy w==;
X-CSE-ConnectionGUID: jFLIqrBpT/S85lRx5fYiGA==
X-CSE-MsgGUID: InfsYAroTumFZ0EdkMudGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86624508"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86624508"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 05:55:54 -0700
X-CSE-ConnectionGUID: 6kSHPqVCSFOYvlzBm9D4Jg==
X-CSE-MsgGUID: NMwScCBbRMWmmqQ2c0BoLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="285480319"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 05:55:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 05:55:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 05:55:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 05:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C90oE+8givo7RWkUvJIg8jPt7y6oqgRV/z0YmtQPNcullx0zPgbHY8V4qx+Tp1pvBC9vyB2F2iBRH6HN8mQu7IZhTdchmMNsqimMU7W89BRKYcG2bbpFPj1tOHXHy9WYx05z7bQDKyt3GmGyoA4V6+IlNVVgfiBDvMSZ6A29gqf9GCMi2vYx5HdTQ6WNfuFEO+xkrrqOmtFvtAeA2frbnT/1dmxklLlWjXSj5sJrnCWk5LnzFU98+PgHF+u4OYdRuTT+mpvdcqrJ/r3hQr4CVMqGdiLE4gsuQJKFgG8upsGO0eOpNioMPJVE1fwpDozRfN8F/uy6Z96gUHG2KrnL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkkdyJ/zJHeK2w1vEuQ0CmCxaWBkHtGyugxTRc9YqdU=;
 b=UDq761hdUrm/y7Vcjm6wyjMtJHuLW1tCrEbtvsUIOfkFxlM/k6Rme4vnotFSkrv4Ta+o7VsZas13lBU4pSlnaMGOlfFwpMuf06jDtszalI/Z4gDN4/3x7O4Syz6u+ElIcJjB/YNr3cXN9IWx3dFw0B2W9h3t+2ssBWIvj8gCAXa8v+R5+SWxXTNwE2NEBVbZUID+7zvktNhra9eEBZxCzOHn/i547mfzJRuJn0pGgSDblKMlcaDh3seHZevJ/8zgx9EXkwwl8dx6UTUBRShyiOLhR3HCJ3Mzp02Kcau5jyafde3Mciqy5v0SyIng74Rmk8RZkJ8tD6eKxciwfvGoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 12:55:46 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 12:55:46 +0000
Date: Thu, 6 Aug 2026 08:55:39 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-fixes
Message-ID: <anSESyrwICYHvZ59@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 977f14a4-38ee-4dc6-d2a8-08def3ba0870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ZIxmuHqPX1TDeu3p74Mis1RL1e5qKgIXzs4B0tXjFsFuw0Mt3s4KAzXNRy4iNQkd+ccPwLW5voBmyMGeO6cdSAue6WTzUk6gg/LT69PEGq6LDRNj9HBPRHnMKCbEBqIgwErBKl1dTwPu96ddXw4w+owL7qMcCutYWmu/dywcnXMWniEAukuPc6PbCE/WkFeXfn/tPO5zDqzXyrRfhkyV5eAFSIYw3sSLO7CGLSn9urorA7NiQwqapAvJhUn9wZplLji50zoIk7JQ3NaBfWQK5tWNxHHnsx+zzRt88p01SXoq5bxXljVZNte35+AqZ/bxdTjlKzPFNRE7BakcM/LYxF2E06dhjpP+EnqbHuIcLaQdhPSi3M2JykFZRX/3V3XdhwuvEfnahEljws0zGXqZiYy+MCggOWPvHZykTM8f0zXRp30yeJaZ0+Mc9CdMu093f3e5UYO12jxZAUjKydGh6JA7bCO7lopzUNkpSli67CVEy/wCetIy8DVlMHdNwWhOY5a3wgONzhPXWMleJHLtox31xteeX3lJ6JPY4Bs5ojI1jhvvCxHqZgC7Xs93mDdWkMP+3RYQSLSKGM5J0HfZBq1CMMDDKr3/U9bbX7jRDWrrddFL265AnlOQr190oFmfciodTT9fnDEbgRjk7XNLxD53G7PLBI32tl87KdmZK6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0kwMXFJVzdmTGxOT0lNSWE3Z05md3NmOGJrZFFIZ052YVF2ZEd0UFl4TmU2?=
 =?utf-8?B?V2RtQ3FDcmNyekhVYS90cEpDbXJVZTZIeDJXbnhPQjUrMXdqYkp5Vm5NY0cy?=
 =?utf-8?B?RkprSkdmcXZja256RXNpVytiajE1NUhDRCtGUkZFTWRIT3ZYM2NzNU10Znh0?=
 =?utf-8?B?d3B6MDdnY2l6V2cyM216b3pDU3hlTUQvOFpNTkd3ZmcxVzM5SzdwV1E5N0Uz?=
 =?utf-8?B?UE5IaldZQnV3MUtJVE8rdUtuK2JSNDhpd3RPUWlmZlpqeS9Wb1AybFdwWHhJ?=
 =?utf-8?B?T1hpU3N4SEZESEZFb2pQYmR3ZHU0SVdKVStlV3Z5V2VGMEdFVklTY2VKanFZ?=
 =?utf-8?B?Y1NxMnc0M3JqT0t4RkptbXFOQm1XcDdmNDBRREVLUkxTVFFPMVlQUXVvWWd6?=
 =?utf-8?B?Z1JFMm1tTlBRUFlSd0w3WEJ6V1FCakdJMVVtdEdDN2ptQTY0T0Q1aEhlNVlj?=
 =?utf-8?B?em1hTEM1Mk5jUU1iUjVvZy93bEgxT3F5TTFaUGhMUGd5TjZ5ejg5NHJGRDJJ?=
 =?utf-8?B?blZhVE44VGE4d0lYVmx5ZjMzMHVPYm1lS0dFeUxtNFF5OThGQ3kvbHFhVFRN?=
 =?utf-8?B?WlRYcDFSb2tpZ3RtYTNIVkZuN0wwbmJWV3RLNDhNTDQvUVZFWlhEeDFuNVBh?=
 =?utf-8?B?ZnMxaitNUVAxNEF1Njk2b0NLanpqK0hialVFQldzQnc0NWFwcWhESDYxaStZ?=
 =?utf-8?B?eUhSaWNpUE51dW5qWlVNSk9BdXg2SmVGZVBMdS9JYzZORzVMa25qWUhtZWd3?=
 =?utf-8?B?RnpEVHdZLy9NZDBFMHRMNGlNakVGMVZEUHRSak1vN2JMOVZCTDZ6MUNkazZi?=
 =?utf-8?B?WTV5U0Y3TG9QSm9RQVcrZS9vRzUzY1Q3THNMei9HMTVNVjRlYndYQW5jekho?=
 =?utf-8?B?NUx6ZFlXZ2RwZHlVdEdJUkVBMGZ5d093dk8zQUNUM2RhVGh5UmlNN21KNUpn?=
 =?utf-8?B?ZWJrN0ozcHlDUW1LYWozMEpJeVpqWFlFK1ROaU9qZzlFOWx0QWQ3RSsrZDhC?=
 =?utf-8?B?amJPVGdwM2drYVVtUTN1NnlzZU8vOURqMDBqMDJQN0t0aGpMWmxXR1BGQjVE?=
 =?utf-8?B?a3BrVU1QazBOTmptVGZmSkNpQjlKckYyc2d4U1RtMXRnR1hTbGtUWllRM3NY?=
 =?utf-8?B?RjlCR3dNOGRZREt6ZXA1cldnTk1kVlYxWUpwOEs5V245cnM3ODhvbEZRM0tM?=
 =?utf-8?B?akZ4b0JRazBuM2tVa2xPMytyS2pxSGVPOVRaektlNzVLUjhvU1RlT0FJL2N5?=
 =?utf-8?B?c3JGQndCZVFjRXBsYk9lblRXakx5UC9hRUtWZW80a3BWbGhZYzcwMitlT25Q?=
 =?utf-8?B?d1lKWjNEZ2FkVmNGRkZDTUd6T0FLdkN0TmUwU0RHWGZGNEcxUkh0emNsdzhB?=
 =?utf-8?B?Y3JKVXVBdEZvSS83Z0RocG0vbnBtRHA5YmpIN3ZkK1VmYXB4SjRlcVh5Zmdw?=
 =?utf-8?B?UHVwN1Jjai91K1FpOE0zZUllaElqRVhwWjZaa3VRdUxsRTVJNDc3dDBFNHUv?=
 =?utf-8?B?MzFJT294aWJYVzJQSG5lZnBhQUt2VkxkZUl5Qnl0VXgwdWwyQW9JQjBJVDV3?=
 =?utf-8?B?bU1CcjRObHhuWTc3MTd2eEFFbnBOMG1xN2s1TGRCazYwckl4cUhTZ2IreEVD?=
 =?utf-8?B?Ym9JZjJRaFBaU0xTL3Nldkt5RmFhMU94WTloVVRjdHIrN2JNSHo1K3JTWHla?=
 =?utf-8?B?UzhmZGJSVUg3bU11T2ExTDYvNm5Pcko0NW9iMjViL1B4TkVCVjRkYVIzSEdM?=
 =?utf-8?B?S3YycjZzdGJPL1hSbThzL3BGeE1YK3pOQlpLQXZhSURuZ29BQVh5dDdwYUxU?=
 =?utf-8?B?MHJEYW5tanBMdEJvWmd0ZHZUbWpjZEFldDU5NDdZVVZtakJiRGNMcERkMHdF?=
 =?utf-8?B?QzhDOUw2K3B1RTYrK1FKbTdDVk5vY1lPQi9Cd3NEQnJnNnB0Ujk4S1hQRnYz?=
 =?utf-8?B?WGNTYm40eHdYMHdFYXlVOExBeCszUGFvTThsbXoxaE1kb1RLc3JVWmxpajdQ?=
 =?utf-8?B?TTNpS2g5WGMrTmJKSHlyVG9nVWtiMm1aNHZqYTYrcHZ1SktDMTZsTHZnV2VF?=
 =?utf-8?B?b2krODZ0eFhwSWFHNXk2TGJzcWt4T1ZjaWpBTEs1T1hRN01jcmphZnRaV2U5?=
 =?utf-8?B?YU0xOUw5RG9XM21YcnZ4d0xzc0N5MnVLeGxWRUJCckxsYVo4bDdiMXF6NVJK?=
 =?utf-8?B?d0lwZldEaDBlNjF5Z1FTb1h2bHN1QjN4ajBVQTREUjdyaW1jR1dBWXBxcFZU?=
 =?utf-8?B?WEJOOThQaDg1dUNROGZNempqb2J4WlpHSTBkR24rUFV1ek1aaFpDNXlQa1Yv?=
 =?utf-8?B?RWdYOStkaWdrelhvSXlkMWNkeGZodERldzF5VUVReEpNRTBSNnlRUT09?=
X-Exchange-RoutingPolicyChecked: LwXQYaEN6dfUFXorLAPAyXSvwzKVstTBNyV/XLAMloKhCpHphr1wGmVnnIdnCUF5BrdVb5sDZza32qWWHtE7yPKGoyw9GEemxNfqdWXR/utvfy325ReIV9BqagUOyIGm0bOnzOD6+84sysFRNYHKtYWsDw+TnWVJDKOkFhY4wX26eXPWeYMCA7ujJWOIDQeI5QXeaA15LwtKXSsHl3m0esr/GbKsrUlJdaFU6db/s8Q3+Xgf3iW0WH7YJEGXUjWaCDP6dBAl7vX7obZVnavy4gqX8vyCg4eGHpp+e9YeNTWMcIjwBnFjCwG6z06DZ7WAMt+jVbfIznFXDNpvBr8XCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f14a4-38ee-4dc6-d2a8-08def3ba0870
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:55:46.5873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0+vu2loF0eituDk6LzKxqrc32NdCgpoYLNPm0fMi+ODN3OT8qYdM726ulP/Zhxfeov8cIwIcU4nBLNO2XPh+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
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

Hi Dave and Sima,

Only a couple drm-xe-fixes this round, and no drm-intel-fixes this week.

Thanks,
Rodrigo.

drm-xe-fixes-2026-08-06:
- Fix memory leak in exec_queue_set_hang_replay_state (Michal)
- Apply RCS/CCS yield policy to SR-IOV VFs (Marcin)
The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-08-06

for you to fetch changes up to d1643db3b037b57f2af7f85c3821d6fe69c492f6:

  drm/xe/uc: Apply RCS/CCS yield policy to SR-IOV VFs (2026-08-04 13:52:23 -0400)

----------------------------------------------------------------
- Fix memory leak in exec_queue_set_hang_replay_state (Michal)
- Apply RCS/CCS yield policy to SR-IOV VFs (Marcin)

----------------------------------------------------------------
Marcin Bernatowicz (1):
      drm/xe/uc: Apply RCS/CCS yield policy to SR-IOV VFs

Michał Winiarski (1):
      drm/xe: Fix memory leak in exec_queue_set_hang_replay_state()

 drivers/gpu/drm/xe/xe_exec_queue.c | 3 +++
 drivers/gpu/drm/xe/xe_uc.c         | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)
