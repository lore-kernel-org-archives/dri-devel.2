Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7DBC624CE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 00:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082E110E30D;
	Tue,  1 Sep 2026 00:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pwxly8Ls";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 934CF10E119;
 Tue,  1 Sep 2026 00:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788222384; x=1819758384;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=5Ex2XC3I2yN2ONk+QdFs4doAA4BvjTv+wPQoeZVKgx0=;
 b=Pwxly8LsGVJIG6hzKHleidYjxU0YvEWPOBRzTT0K6aT1YD9WxSe0pLP/
 J4wbriDMr3lsj5e0wEciiSRikSmV8ijI5ABURk0OynBEQqL0NVfwEuAOa
 MW1wrxOiBwiKv4DlaxFROrGRQ+BaBjrvqVy9+i5D+9K3Wly4KuqwIZ/2o
 amd9S8HnavrxLwsZqMj8QvWYQJxNgT9Aq0ZNTPggK7vHuBzxyTTDemcCC
 GWL3B7gGkg1eEoi8e+mwUFFfeivkQ1wvfKs9cUUFqBieb4762lwUeFwV4
 vmISVcsSpk5skszY5EFf9BoDpztA4MmoeoLz+kSPPYbGwSKpEqz8Oymo2 w==;
X-CSE-ConnectionGUID: yT4g0VzSSQGF+J/vGNi0iQ==
X-CSE-MsgGUID: pQi5p/kdQPam14AG7wrruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99992260"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="99992260"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 17:26:22 -0700
X-CSE-ConnectionGUID: uTsgLgfXRaijISUmALD8RA==
X-CSE-MsgGUID: 9A3HdEhSRMi0gHvNJQQlYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="268400711"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 17:26:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 17:26:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 17:26:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 17:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmhmzfhVKf8C5A2fhUFCWAT8g5ksjH2FolLLjUr/wgpiYP2hqI1c1OvHwGX3BRn/ZxWnsbmDRecfaHIeywXRDUlLgWEv6V5zZ4iAAoPYl6HoskvFrwjKNmcpzzZ5VdJVSGFOJzzfqoKGDhhB2El21z6jufYZVIPczhl3CTEmDMadyadR2ldJn9qTJXdoZu0qfya9e8xFschTNhfEAKnyopvMSCM1YGqaRuaLvl2q7rOc8MVpoxzHeX/iJY/rYdI34Ycb9O70K1OA4/2J4s4nlXg/mv0RBFQmq05S2JQWuyyOykDkVntGQ7CKvo8lQ7RRWlaHpn7lb3yNshy4EdmRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvmpGYz0x8wQ+N2DCiHjzwcgq1Q3op+ACW0tqIwCCBQ=;
 b=izK9ECEOCHHoYwgKSRpXexFf8Ma3a0CAvkpJ5w91XuVCQ9iAQ1RBPQcacTy32rW6yUt1iCy6REcreyYaO4vLUomjvye7uQJaLTXQjNGIf4bfzPWat3i7lAGLOCYhLaejdsHlzMvSjSwHCoUvHqaGzm8yQF78+tm/DpzbkvA4K9IQURtcKxViVWlHCGL7CidC093GDtdCV1NPp04PMfNa7c1m1fhHaqlGiJloJSv5hDrIApB098NRjpd4dnqF9jDYfLfP6lH7FQyGVZny+toPh1mYApAB8gGwMMqYF18Xgzz8pVkyzpcOkmCGsHMuX1xUTcXmBZdsAAWXYfJbDyIr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN0PR11MB6278.namprd11.prod.outlook.com (2603:10b6:208:3c2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:26:10 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 00:26:09 +0000
Date: Mon, 31 Aug 2026 17:26:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
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
Subject: [PULL] drm-xe-next
Message-ID: <apYbnrklyk6nNO7Q@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN0PR11MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 330e0e65-dc59-47ae-1d1a-08df07bf9ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: QvI6uoGB8492s7u/KXrjWOLkN9APbxu3bbK5kJAINhMucr0TDstJv3WviORF/BoDHXF9lD+7JuvsxR5j5Su8vX8YoGxyY/Hn3uky5mBc7GTkFBQO3r0d+WIy8wxVvZhfD0oLp7Gw5UyhjnzpHP4QjL2kKNFtzINtFxkceUZCrPF6o2k+tPGrE1c0zAx+rojA1efpK0YgZBg7V+6GhjpFSjXiHliwmC9PlcY31jlmDgKhSaArWCskYPP19oKzCxV5YPX9s81hyLn3/tSN1dluGJYf6vw1cNDhKrqtjDo9OiShLRZ001M70T7P8myl3GK5412Kl7qY1zE76qJivE7FIk+Rq4ld1LwT0P+Vr4ysEN9zCndjT0XoPi8fJatJ/UuGg6KXpTdWQUPYeAuplu+FTIjXNDh12jy82LKULhWnzkL0DJsNSZFvylf4y9++aT0ihbhEDUQU+gaBZUnunMvj3694N5nDWb7Td4pb10C+KB++96uY3m9iU4Ez41GNjRgsVWTfbib4xUwybp4EuDd7P/Ik905g6IHb1PrmacPBaI7t4pHQ/X9qFNwI1fyv4KkdC0cKeIs/7NUgPUAlJOKnHXPD3MhxCF8Ea/hxo2u02BRzc3lNaQg03RgAZ7Z3e5FZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdTTmNmYmVIV0JZUXhoVFliencreVpTS3o1ZVdsaVBqWnRzaFpEK3ZqdW8w?=
 =?utf-8?B?L2RVVWN4Nmp4RExFNlRZeFJSU2FrOC9qUEdCckt1MU9Rd201NjkyNTZjZ2g5?=
 =?utf-8?B?Z0U0NDkzSDlRc2EzNVVXVVZZVkdHV3Rob2RDekQvZ2RzMWN4c2NaWGJLSzM0?=
 =?utf-8?B?ZnpRU0tVSHBZNklydDBsSWlWbmhoTjN2cWdUZWZ6VDNTUk5kWkJJejluaXAr?=
 =?utf-8?B?cm0zdURLbXk2WDFobXAxTERvWCt6R1VQTkFtY2JzRlhLZTE1L25sdFVXbzU2?=
 =?utf-8?B?Zm9oQmtBK0t4ZzFCNTVFVkd1MVBvNUpkYjJxTi85VDJnZmpuTEc3ankrZFA2?=
 =?utf-8?B?UXZPZUFwQ0lDZzFHR1lacFRyRmVKYUZvMkZSR3pYaDVZbEl2b1hYL2l5TGFX?=
 =?utf-8?B?aFozODk0L1FRaER3WndpWEpIQ2ZnN294M3FiZ2N4ZW1MTHpsQjRwMTRrZHA1?=
 =?utf-8?B?dExTaTV0UjZJZTF4QkZhSjA0N1FuTy9hRDFRZytRMm1SUkRBbHJDVEVldHZI?=
 =?utf-8?B?QzJ6MUhWSVBLd1NZNUk4ZUY4YzB3WFVwME96QmdDaTl1dnRZKysxOGVBY09C?=
 =?utf-8?B?YXFhMS9jZTZLeEIwS2RPS3EyT1M1eXZFMGtxeDhoOTNPMHNXUFo1aVlKd2Fw?=
 =?utf-8?B?dm9mRTBRQXZrTys0aDhlM0JSRDBqRlI1R0lSSGtPai9Lb3QrNFYySGcvMU5V?=
 =?utf-8?B?S3VFeHQ5TUZDSEwrWWpVeURzU01mMjIrKytJWEZWbmNtWDlnTWliVnQyS29H?=
 =?utf-8?B?T2FFckpJZ2FBS254QTRxeW83YU1raTFBTXUwS01RaGpub2FMMnp0RlFzRzhj?=
 =?utf-8?B?bHdWREI1eEpQUHZwTGxrYVdhODlEK011WEhBZ29QYVBad1BhNTZnWWFqSFB3?=
 =?utf-8?B?SUlPbitaRUtVNkV4b1RCMmQ2K2VtZ1lJTFVSMVNZWkFxRUdKWjJ4SDlxb2NU?=
 =?utf-8?B?RnpNSDZrQ1B6K3VTelRIRVFrMVpsZTZkRXRQb0JLeGVKOVhYODdJVVhUaWUy?=
 =?utf-8?B?YXF5UHJVYVdFVEdrSktoVnFwSXVvcTZWRjh5QU5CMk4vak05b2NoZHhrc2tV?=
 =?utf-8?B?MjVBZzZhbVY3WkpIVEg1R1NCTTZyVTJvQmVPbXoySHQ3a1ZhWUlIRlBDOEIw?=
 =?utf-8?B?N3FndjhQeUQ1WnVZemJ5blRQaVhuU1FQZTlUcnVKYUFnQ3RBQVA5OXJ3Wk1U?=
 =?utf-8?B?SXdlb280ck8yTjhDZ05yc2c1elpRMkhDVGUzdzBPdzlOS2JyNzJrNEUrNVlY?=
 =?utf-8?B?dmFVQWhwcjl5bEhOUXBXTXpRSXlaNUlTR3FQVW1OMTNNZUJHRUhKMEd0TXRt?=
 =?utf-8?B?NTA0MnVreDB0TnVjclM1ZEFRVWk1eHRyQ3FmUTA1VFBnMmFySXM0Q0NiTThJ?=
 =?utf-8?B?M2JxOS9IUTBSZWZXZTBtNSthTXVwL2ZsRXNqeGtlU2ZsN0ZyNm45NGpqZHJW?=
 =?utf-8?B?c2ZOaVZOaElISkdVekVXdEVCWnhRYWJuMXhQOEpxWGRkdzdQN0NIVnpBV0J6?=
 =?utf-8?B?RFRwbnM0YlFDVC8ycHhDUmpCN1VOZ2FnM1NWS0paV2EyMnVOSmZUSEtxSmxK?=
 =?utf-8?B?NjhrampCdHRlTjZPU2FBd3k2WEllRHFvdENQN2hXUlR6ZUZsODZoODhJYW9v?=
 =?utf-8?B?ekZyUndaNFFNbHFEV3JuU0JsaDYrRzVCc3ByMzNvaTFNK2hSYU1GREUzMDl6?=
 =?utf-8?B?dFpaTXlPU2h1Nm1BRlNvMmliMHJ5ZFZ3QlBXMVMwcE5LSmYxKytRVnIwMGQ5?=
 =?utf-8?B?aE5SaC9GSHhJS0NSbDBmODJYMVJvbGZxNXJlbExycHNiYitLc3p1SEVLcUww?=
 =?utf-8?B?dWJSUVR1OXUwS1dmNEFaZDl2a09GQUNLeFhMeVZ3TTd3eDlwbE5iS3FCZmZJ?=
 =?utf-8?B?cjdsM0tiVndTNVUzU0syTm15VzBaaEEvaytkcmFqNDJpZFBjUHFqbmozdVJv?=
 =?utf-8?B?aWtHY2pkRnhDNkNPL3BDMHU1R3NKOCtkU3preEFudHpKYXBRMHFSWXkxQmpC?=
 =?utf-8?B?NkxaNTh4NVlDeEQ3OE05M3R6cEtmQ1N3Y2FYMDdveThWVnFRZk5ReVI4WDJ0?=
 =?utf-8?B?dERGYjhNZEVXaDRmSzlIZkd5OTdwUFYzSlQ0dFlHYjBvOG9oYzFkYzJTbkR0?=
 =?utf-8?B?cUJkYnlqd3ZSQnFPK2lPNWZSdU1Lc0FVd3FBdlVtZk9mS3lFeGRLVTZDVThx?=
 =?utf-8?B?dDJ5eDBpVmhxS2NqN1VubjVYQzlqbVdPMXA2TDFMZWtES2kwSi8zcFhFUnBV?=
 =?utf-8?B?NE83TUFjbkhPZ2FNcnhiK29vYUV0V0JFSCtEaDFHbEFmMEhoQzlUS0Q3QXRL?=
 =?utf-8?B?T3QyK1FYYmRQTGZqTzNPcUJwV1NpT0F2TUE0QWkxMTlxb3M3VHpGWmpQTlRn?=
 =?utf-8?Q?hcc5kK/7BEWqoEgA=3D?=
X-Exchange-RoutingPolicyChecked: viohhnr/X2LWVTjxGn2qSnh8p3uaJKLqZXVZgRl68Hz6PNiIqbwQMzkkLEj6O2X344muAsGN0/CxGVGH/ChI2uM2yneRv6F0m++fQ4hUZdqpeUpwwQI5zg8J8krkxrVuXGGpw6n3o0vpMXYvp9PrIc8309f76u66/kme/z6Zn2d/prVHIQqxmL9g5yNdhKmoxR5vMovGCZfuxGenhHwR7PAFCC0SFqxyDMym8TkFsOo4BRMdB014bnYXRvfWAuxCROyj7qnk5sMs3chqtw0DIMMGJJQVEBLn0omLl1waY/ZzTzpcByUdeSgiEun369eVT/LQTW7+zc2uOMJm6lGnqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 330e0e65-dc59-47ae-1d1a-08df07bf9ef1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:26:09.8695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFXGO1YCY9bnTaL1sV6XAx2GAEKZqm+Onbeesp2a20RDhtpq6g3kIFE2YjJLdn7/wqsNmlDc0pfcrSKz+OblUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6278
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

Here goes our first drm-xe-next pull towards 7.4.

Big things we have are: VF migration for multi-queue, parallel page
fault handling, various RAS features, and structured SIGID error
logging.

Matt

drm-xe-next-2026-08-31-1:
Cross-subsystem Changes:
- MAINTAINERS: Add entries for drm_ras (Rodrigo)
- alerts and controller enabling modifications (Heikki)

Core Changes:
- Introduce cold reset recovery method (Mallesh)
- Add drm_ras netlink error event support (Riana)
- Introduce error threshold to drm_ras (Raag)

Driver Changes:
- Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioctl (Lu)
- match argument naming with PCODE_DATAx (Grzelak)
- fix stale GGTT mappings on unmap (Tangudu)
- Introduce error threshold to drm_ras (Raag)
- Add debugfs knob to control GPGPU preemption granularity (Varun)
- fix vecs config for powergating info (Ashutosh)
- Read mailbox phase bit from hardware (Anoop)
- alerts and controller enabling modifications (Heikki)
- Use int instead of u32 for mailbox status (Umesh)
- Reject page faults from non-fault-mode scratch VMs (Arvind)
- Add CCS to the powergating info print (Balasubramani)
- Do not apply WA 14025883347 to media 3503 (Daniele)
- don't WARN on kernel job timeout when device already wedged (Nitin)
- handle exec queue teardown after hot-unplug (Nitin)
- Allow debugging PCI errors (Raag)
- Add structured SIGID error logging infrastructure (Wajdeczko, Rodrigo)
- Enable package and vram temperatures for CRI (Karthik)
- Introduce cold reset recovery method (Mallesh)
- fix error message in xe_migrate_sanity_test (Dan Carpenter)
- Add drm_ras netlink error event support (Riana)
- Fix a bug in pc_adjust_freq_bounds() (Vinay)
- Fix xe_device_probe() failure (Raag)
- Page fault cleanups (Wajdeczko)
- OA memory fixes (Linmao)
- document sentinel and make CTX_TIMESTAMP read TOCTOU-safe (Gajendra)
- Move has_drm_ras check to drm_ras layer (Raag)
- add termination on resume (Daniele)
- Add _locked variants of some config functions (Wajdeczko)
- Order ring writes before ring tail updates (Brost)
- Parallel page fault handling (Brost)
- handle CRI+ power interval encoding (Karthik)
- allocate UM queues in a separate UC BO (Jia)
- Fix boot-time ras error processing (Raag)
- VF migration for multi-queue (Niranjana)
- Apply RCS/CCS yield policy to SR-IOV VFs (Marcin)
- Fix memory leak in exec_queue_set_hang_replay_state (Winiarski)
- Use IBC v3 on PTL (Vinay)
- Reduce MERT debug log spam (Lukasz, Piotr)
- Validate sysctrl response (Raag)
- Changes for Xe3p_HPM media (Ashutosh)
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-08-31-1

for you to fetch changes up to cc467969646b9778c947bec1383fb3cdaada14d5:

  Merge drm/drm-next into drm-xe-next (2026-08-31 15:42:28 -0700)

----------------------------------------------------------------
Cross-subsystem Changes:
- MAINTAINERS: Add entries for drm_ras (Rodrigo)
- alerts and controller enabling modifications (Heikki)

Core Changes:
- Introduce cold reset recovery method (Mallesh)
- Add drm_ras netlink error event support (Riana)
- Introduce error threshold to drm_ras (Raag)

Driver Changes:
- Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioctl (Lu)
- match argument naming with PCODE_DATAx (Grzelak)
- fix stale GGTT mappings on unmap (Tangudu)
- Introduce error threshold to drm_ras (Raag)
- Add debugfs knob to control GPGPU preemption granularity (Varun)
- fix vecs config for powergating info (Ashutosh)
- Read mailbox phase bit from hardware (Anoop)
- alerts and controller enabling modifications (Heikki)
- Use int instead of u32 for mailbox status (Umesh)
- Reject page faults from non-fault-mode scratch VMs (Arvind)
- Add CCS to the powergating info print (Balasubramani)
- Do not apply WA 14025883347 to media 3503 (Daniele)
- don't WARN on kernel job timeout when device already wedged (Nitin)
- handle exec queue teardown after hot-unplug (Nitin)
- Allow debugging PCI errors (Raag)
- Add structured SIGID error logging infrastructure (Wajdeczko, Rodrigo)
- Enable package and vram temperatures for CRI (Karthik)
- Introduce cold reset recovery method (Mallesh)
- fix error message in xe_migrate_sanity_test (Dan Carpenter)
- Add drm_ras netlink error event support (Riana)
- Fix a bug in pc_adjust_freq_bounds() (Vinay)
- Fix xe_device_probe() failure (Raag)
- Page fault cleanups (Wajdeczko)
- OA memory fixes (Linmao)
- document sentinel and make CTX_TIMESTAMP read TOCTOU-safe (Gajendra)
- Move has_drm_ras check to drm_ras layer (Raag)
- add termination on resume (Daniele)
- Add _locked variants of some config functions (Wajdeczko)
- Order ring writes before ring tail updates (Brost)
- Parallel page fault handling (Brost)
- handle CRI+ power interval encoding (Karthik)
- allocate UM queues in a separate UC BO (Jia)
- Fix boot-time ras error processing (Raag)
- VF migration for multi-queue (Niranjana)
- Apply RCS/CCS yield policy to SR-IOV VFs (Marcin)
- Fix memory leak in exec_queue_set_hang_replay_state (Winiarski)
- Use IBC v3 on PTL (Vinay)
- Reduce MERT debug log spam (Lukasz, Piotr)
- Validate sysctrl response (Raag)
- Changes for Xe3p_HPM media (Ashutosh)

----------------------------------------------------------------
Anoop Vijay (1):
      drm/xe/sysctrl: Read mailbox phase bit from hardware

Arvind Yadav (1):
      drm/xe: Reject page faults from non-fault-mode scratch VMs

Ashutosh Dixit (3):
      drm/xe/mcr: Take vcs1/vecs1 into account for first media slice
      drm/xe/oa: Extend OAM unit hwe assignment for new dGfx
      drm/xe/xe_gt_idle: fix vecs config for powergating info

Balasubramani Vivekanandan (1):
      drm/xe/xe_gt_idle: Add CCS to the powergating info print

Dan Carpenter (1):
      drm/xe: tests: fix error message in xe_migrate_sanity_test()

Daniele Ceraolo Spurio (2):
      drm/xe/pxp: add termination on resume
      drm/xe: Do not apply WA 14025883347 to media 3503

Gajendra Uttamchand (1):
      drm/xe/lrc: document sentinel and make CTX_TIMESTAMP read TOCTOU-safe

Heikki Krogerus (3):
      i2c: designware: Global register definitions
      drm/xe/i2c: Fix the interrupt handling
      drm/xe/i2c: Keep the i2c controller always enabled

Jia Yao (3):
      drm/xe/guc_ads: allocate UM queues in a separate BO
      drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
      drm/xe/guc_ads: use uncached mapping for UM queue BO

Karthik Poosa (2):
      drm/xe/hwmon: handle CRI+ power interval encoding
      drm/xe/hwmon: Enable package and vram temperatures for CRI

Linmao Li (2):
      drm/xe/oa: Fix sync entry leak on OA config emit failure
      drm/xe/oa: Check managed mutex initialization errors

Lu Yao (1):
      drm/xe/oa: Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioctl()

Mallesh Koujalagi (5):
      drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
      drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
      drm/xe: Handle PUNIT errors by requesting cold-reset recovery
      drm/xe/ras: Use fault-inject to trigger cold-reset wedge
      drm/xe/log: Add structured SIGID error logging infrastructure

Marcin Bernatowicz (1):
      drm/xe/uc: Apply RCS/CCS yield policy to SR-IOV VFs

Matthew Brost (15):
      Merge drm/drm-next into drm-xe-next
      drm/xe: Fine grained page fault locking
      drm/xe: Allow prefetch-only VM bind IOCTLs to use VM read lock
      drm/xe: Thread prefetch of SVM ranges
      drm/xe: Use a single page-fault queue with multiple workers
      drm/xe: Add num_pf_work modparam
      drm/xe: Engine class and instance into a u8
      drm/xe: Track pagefault worker runtime
      drm/xe: Chain page faults via queue-resident cache to avoid fault storms
      drm/xe: Add pagefault chaining stats
      drm/xe: Add debugfs pagefault_info
      drm/xe: batch CT pagefault acks with periodic flush
      drm/xe: Track parallel page fault activity in GT stats
      drm/xe: Order ring writes before ring tail updates
      Merge drm/drm-next into drm-xe-next

Michal Wajdeczko (37):
      drm/xe/pf: Add _locked variant of the GGTT bulk config function
      drm/xe/pf: Add _locked variant of the contexts bulk config function
      drm/xe/pf: Add _locked variant of the doorbells bulk config function
      drm/xe: Use guard(spinlock_irqsave) in pagefault handler
      drm/xe: Remove redundant full pagefault queue check
      drm/xe: Introduce xe_any helpers
      drm/xe/log: Introduce structured component/location identifiers
      drm/xe/log: Add component/location decorations to dmesg
      drm/xe/log: Add SIGID log helpers for severity
      drm/xe/log: Add SIGID log helpers for location
      drm/xe/log: Add SIGID log helpers for location & severity
      drm/xe/log: Add SIGID log helpers for components
      drm/xe/log: Add SIGID log helpers for component & severity
      drm/xe/log: Add SIGID log helpers for errno-only
      drm/xe/log: Index all SIGID printk messages
      drm/xe/log: Add hardware error signatures
      drm/xe/log: Extend components list with hardware items
      drm/xe/ras: Check RAS and LOG component definitions
      drm/xe/kunit: Setup driver data in the test device
      drm/xe/tests: Add Kunit tests for xe_log
      drm/xe/tests: Add kunit tests for xe_any
      drm/xe: Report 'probe blocked' status using SIGID
      drm/xe: Report all probe errors using SIGID
      drm/xe/survivability: Report 'boot status' using SIGID
      drm/xe/survivability: Report sysfs failure in one place
      drm/xe/survivability: Report 'boot status' on sysfs failure
      drm/xe/survivability: Report 'Boot Mode enabled' status using SIGID
      drm/xe/survivability: Report 'Runtime Mode enabled' status using SIGID
      drm/xe: Report 'device wedged' errors using SIGID
      drm/xe/pcode: Report 'Mailbox failed' error using SIGID
      drm/xe/pcode: Report 'timeout, retrying' error using SIGID
      drm/xe/pcode: Report 'initialization timedout' error using SIGID
      drm/xe/guc: Report 'GuC mmio' errors using SIGID
      drm/xe/gt: Report 'reset failed' errors using SIGID
      drm/xe/gt: Report 'Fault response' pagefault error using SIGID
      drm/xe/gt: Report 'Queue full' pagefault error using SIGID
      drm/xe/pci: Report 'cannot re-enable' error using SIGID

Michał Grzelak (1):
      drm/xe/pcode: match argument naming with PCODE_DATAx

Michał Winiarski (2):
      drm/xe: Fix memory leak in exec_queue_set_hang_replay_state()
      drm/xe: Reject duplicated properties for EXEC_QUEUE_SET_PROPERTY

Niranjana Vishwanathapura (4):
      drm/xe: split VF pause into prepare and revert phases
      drm/xe/multi_queue: handle CGP_SYNC wait timeout during VF recovery
      drm/xe/multi_queue: track and recover lost CGP updates across VF migration
      drm/xe/multi_queue: replay dynamic CGP updates lost during VF migration

Nitin Gote (3):
      drm/xe/guc: rework exec queue teardown PM/unplug handling
      drm/xe: remove EXEC_QUEUE_FLAG_PERMANENT
      drm/xe: don't WARN on kernel job timeout when device already wedged

Piotr Piórkowski (2):
      drm/xe: Add dbg_ratelimited printk wrappers
      drm/xe/mert: Rate limit VF LMTT fault debug log

Raag Jadav (10):
      drm/xe/ras: Validate sysctrl response
      drm/xe/ras: Fix boot-time ras error processing
      drm/xe/drm_ras: Move has_drm_ras check to drm_ras layer
      drm/xe: Fix xe_device_probe() failure
      drm/xe/pci_error: Allow debugging PCI errors
      drm/ras: Cancel and free message on get counter failure
      drm/ras: Introduce error threshold
      drm/xe/ras: Add support for error threshold
      drm/xe/drm_ras: Wire up error threshold callbacks
      drm/xe/sysctrl: Reuse xe_sysctrl_create_command()

Riana Tauro (2):
      drm/drm_ras: Add drm_ras netlink error event
      drm/xe/xe_ras: Report correctable/uncorrectable error events to userspace

Rodrigo Vivi (1):
      MAINTAINERS: Add entries for drm_ras

Tangudu Tilak Tirumalesh (3):
      drm/xe/ggtt: fault on unmapped GGTT for multi-queue platforms
      drm/xe/tlb_inval: add xe_tlb_inval_ggtt_full() GGTT invalidation helper
      drm/xe/ggtt: invalidate engine GGTT TLBs for multi-queue GTs

Umesh Nerlige Ramappa (1):
      drm/xe/pcode: Use int instead of u32 for mailbox status

Varun Gupta (1):
      drm/xe: Add debugfs knob to control GPGPU preemption granularity

Vinay Belgaumkar (3):
      drm/xe: Use IBC v3 on PTL
      drm/xe: Add debugfs for IA/GT bias
      drm/xe: Fix a bug in pc_adjust_freq_bounds()

 Documentation/gpu/drm-ras.rst                 |  39 ++
 Documentation/gpu/drm-uapi.rst                |  93 +++-
 Documentation/gpu/xe/index.rst                |   1 +
 Documentation/gpu/xe/xe_sigid.rst             |  14 +
 Documentation/netlink/specs/drm_ras.yaml      |  80 +++
 MAINTAINERS                                   |  13 +
 drivers/gpu/drm/drm_drv.c                     |   2 +
 drivers/gpu/drm/drm_ras.c                     | 278 +++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  33 ++
 drivers/gpu/drm/drm_ras_nl.h                  |   8 +
 drivers/gpu/drm/xe/Makefile                   |   1 +
 drivers/gpu/drm/xe/abi/guc_actions_slpc_abi.h |   1 +
 drivers/gpu/drm/xe/abi/xe_log_abi.h           | 199 +++++++
 drivers/gpu/drm/xe/abi/xe_sigid_abi.h         | 172 +++++++
 drivers/gpu/drm/xe/display/xe_display_pcode.c |   4 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h          |   6 +
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h       |   2 +
 drivers/gpu/drm/xe/tests/Makefile             |   1 +
 drivers/gpu/drm/xe/tests/xe_any_kunit.c       | 213 ++++++++
 drivers/gpu/drm/xe/tests/xe_kunit_helpers.c   |   4 +
 drivers/gpu/drm/xe/tests/xe_log_kunit.c       | 553 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_any.h                   | 137 +++++
 drivers/gpu/drm/xe/xe_debugfs.c               |  15 +
 drivers/gpu/drm/xe/xe_debugfs.h               |   2 +
 drivers/gpu/drm/xe/xe_defaults.h              |   1 +
 drivers/gpu/drm/xe/xe_device.c                |  30 +-
 drivers/gpu/drm/xe/xe_device_types.h          |  23 +-
 drivers/gpu/drm/xe/xe_drm_ras.c               |  65 +++
 drivers/gpu/drm/xe/xe_drm_ras.h               |   3 +
 drivers/gpu/drm/xe/xe_exec_queue.c            |   6 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h      |  21 +-
 drivers/gpu/drm/xe/xe_ggtt.c                  |  74 ++-
 drivers/gpu/drm/xe/xe_gsc.c                   |   3 +-
 drivers/gpu/drm/xe/xe_gt.c                    |  13 +-
 drivers/gpu/drm/xe/xe_gt.h                    |  13 +
 drivers/gpu/drm/xe/xe_gt_debugfs.c            | 146 ++++++
 drivers/gpu/drm/xe/xe_gt_idle.c               |  45 +-
 drivers/gpu/drm/xe/xe_gt_printk.h             |   3 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c    | 191 ++++---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h    |   6 +
 drivers/gpu/drm/xe/xe_gt_sriov_printk.h       |   3 +
 drivers/gpu/drm/xe/xe_gt_stats.c              |   7 +
 drivers/gpu/drm/xe/xe_gt_stats_types.h        |  22 +
 drivers/gpu/drm/xe/xe_gt_types.h              |  29 ++
 drivers/gpu/drm/xe/xe_guc.c                   |  18 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                |  95 +++-
 drivers/gpu/drm/xe/xe_guc_ct.h                |  38 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h  |  32 +-
 drivers/gpu/drm/xe/xe_guc_pagefault.c         |  39 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                |  15 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            | 267 +++++++---
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c         |  29 ++
 drivers/gpu/drm/xe/xe_guc_types.h             |   6 +
 drivers/gpu/drm/xe/xe_hwmon.c                 |  88 ++--
 drivers/gpu/drm/xe/xe_i2c.c                   |  22 +-
 drivers/gpu/drm/xe/xe_i2c.h                   |   1 +
 drivers/gpu/drm/xe/xe_log.c                   | 235 +++++++++
 drivers/gpu/drm/xe/xe_log.h                   | 194 +++++++
 drivers/gpu/drm/xe/xe_lrc.c                   |  33 ++
 drivers/gpu/drm/xe/xe_mert.c                  |   2 +-
 drivers/gpu/drm/xe/xe_migrate.c               |   2 -
 drivers/gpu/drm/xe/xe_module.c                |   4 +
 drivers/gpu/drm/xe/xe_module.h                |   1 +
 drivers/gpu/drm/xe/xe_oa.c                    |  13 +-
 drivers/gpu/drm/xe/xe_pagefault.c             | 716 +++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_pagefault.h             |  74 +++
 drivers/gpu/drm/xe/xe_pagefault_types.h       | 114 +++-
 drivers/gpu/drm/xe/xe_pci.c                   |  32 +-
 drivers/gpu/drm/xe/xe_pci_error.c             |  13 +-
 drivers/gpu/drm/xe/xe_pcode.c                 |  27 +-
 drivers/gpu/drm/xe/xe_pcode.h                 |   2 +-
 drivers/gpu/drm/xe/xe_pm.c                    |   5 +
 drivers/gpu/drm/xe/xe_printk.h                |   3 +
 drivers/gpu/drm/xe/xe_pt.c                    |   6 +
 drivers/gpu/drm/xe/xe_pxp_submit.c            |   5 +-
 drivers/gpu/drm/xe/xe_ras.c                   | 236 ++++++++-
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  50 ++
 drivers/gpu/drm/xe/xe_sriov_printk.h          |   3 +
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c          |   1 -
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  85 +--
 drivers/gpu/drm/xe/xe_svm.c                   | 146 ++++--
 drivers/gpu/drm/xe/xe_svm.h                   |  59 ++-
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |  28 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 drivers/gpu/drm/xe/xe_tile_printk.h           |   3 +
 drivers/gpu/drm/xe/xe_tile_sriov_printk.h     |   3 +
 drivers/gpu/drm/xe/xe_tlb_inval.c             |  42 +-
 drivers/gpu/drm/xe/xe_tlb_inval.h             |   1 +
 drivers/gpu/drm/xe/xe_tlb_inval_types.h       |  10 +
 drivers/gpu/drm/xe/xe_userptr.c               |  19 +-
 drivers/gpu/drm/xe/xe_vm.c                    | 301 ++++++++---
 drivers/gpu/drm/xe/xe_vm_types.h              |  42 +-
 drivers/gpu/drm/xe/xe_wa.c                    |   4 +-
 include/drm/drm_device.h                      |   1 +
 include/drm/drm_ras.h                         |  34 ++
 include/uapi/drm/drm_ras.h                    |  18 +
 97 files changed, 5126 insertions(+), 672 deletions(-)
 create mode 100644 Documentation/gpu/xe/xe_sigid.rst
 create mode 100644 drivers/gpu/drm/xe/abi/xe_log_abi.h
 create mode 100644 drivers/gpu/drm/xe/abi/xe_sigid_abi.h
 create mode 100644 drivers/gpu/drm/xe/tests/xe_any_kunit.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_log_kunit.c
 create mode 100644 drivers/gpu/drm/xe/xe_any.h
 create mode 100644 drivers/gpu/drm/xe/xe_log.c
 create mode 100644 drivers/gpu/drm/xe/xe_log.h
