Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC3EC54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B14C10E671;
	Thu, 30 Jul 2026 09:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H1Eq5SiP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EA110E671
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785405535; x=1816941535;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=mFZMcEAFYMFy0JKizY7KV7BXGfc2m3zn7Ki/ToCU6YM=;
 b=H1Eq5SiPLKbOjBntSpB9u/CClVwp8ytoC10onSod3301GmOz6KUXwi8I
 +8G4+PZZAklY8ql76xVdj5JWmrCOkKpGp0nMZ1PSwmXA7qu1vWiBHePMe
 LnxhFEb7a8vyDEKxntC6OnEFnpSReDUrRRZbwwLmbIUkt449s97CEDalt
 tc0gdx4Ops0/jIMJn66ep35Rzq/cOuuDBdDHozjHvNPFdWk8jj65R8EkS
 7E5iR+f0AzaXrFSVnrkRrEO6g5MZlfv3TXsmfhiVejQ33acSddQdlAant
 K5JVLHlJD9nu596+s2hXNa8f8g1ssYnK3ZdSks6wY749BAR5YY3Rz9aMh Q==;
X-CSE-ConnectionGUID: /H5EYAjxTbyqkT4B21JmUA==
X-CSE-MsgGUID: v3sS9vd4TtaiHEBRliRI6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89907941"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208,217";a="89907941"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:58:55 -0700
X-CSE-ConnectionGUID: Y4GCskFdTxOWT+NIUQPj4Q==
X-CSE-MsgGUID: ooxOjzpBS6SrESTV8scVug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
 d="scan'208,217";a="258480019"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:58:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:58:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 02:58:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7TuPQ5k91R9Ne5ncQRXIp6Ci+RpXC2MpV6fu8cw4t/kbStxufOJsZQ5flFNxDLCgz/k6nUdTqdpP3iB2zL7ppsUIhIC5XFNvx/mvr8jAAg2s4e1ThQvBU4Mkcpd4qBFmINiatvBpN7/KlWPdWGOAsDJI2JW0lmly46q3CVBK9jGTRqqRBun5wy9INgbcq9A0ROHLPAIaYrgxHCt24sMH8HtaJ50unKokOoSs6loPUheS2I7T+U7GAxNPbmnP4AayIeyzVOjifjZiXmM0QOkqFZIar1HSqPrmFv7mBQiAX3iyERdjhiXmGOTZymjl9ZTzBHRTbTSAGymCS1eOyhGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohdvx3YsAA+D16YLGIhsAwHb5VF4wlRwHF87Cv9RXLA=;
 b=HrKIG6+OtSII6kXSM38gG3cJ6N1lZDjZ3c3d/IPviwqfAImX8G7yyVvmUdPxyUIJ2PpBg3e/3tyIV5G1njH3xr3zgcS9fuiJBgSOl1CnwwxILEnBmKWU/0JtNs7bl26AWdQNvep3E0UpMTNnMHbsmG2mpKFQIJKEWHbAbp4lTHSllSbRBam4xP7P45TJfk+sEmiPIizQa23GDZi2vttiicQPdvasHVBvoe8JLQgfSRDE0aixh+YDM2a4f8YC9UmtEa+B5SlrAU2+emkb3IpWuEXutaoN4b80eEdvD634pQbfH+73zA1QcusWNXLqeSmYQ2uwLS7P5bWKp1uYFkCyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by SABPR11MB9964.namprd11.prod.outlook.com (2603:10b6:806:50c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 09:58:45 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 09:58:45 +0000
Content-Type: multipart/alternative;
 boundary="------------h0EIP2tcT5XSRbvzw6XtSjwJ"
Message-ID: <c518ef81-61b7-4e95-a196-02fd2c6c2e2a@intel.com>
Date: Thu, 30 Jul 2026 15:28:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/drv: Convert wedged event string building to
 seq_buf
To: Jani Nikula <jani.nikula@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
References: <20260728140630.891508-2-mallesh.koujalagi@intel.com>
 <ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com>
X-ClientProxiedBy: MA5PR01CA0287.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::19) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|SABPR11MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3fd976-e6ab-44b1-242b-08deee212499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kj/nF2syToQnz5xP/1JZHLEvbc0e/9RHlw9R7FojWO7EZD7Tt5rFMoD7MORDgGiDxvC8UqPov1ud7RUyDGGpJ2a+kpzk6ECciSDW+ZNFT+kGsULL5foKzdcjVqngEtzvx0JHpkPzH+Y+u13nWqr1zy/cFDldTbvZiaDFjunXDd8dHUt3NDTXaiXpExJ7XAzJHY5QKGO8gAqkR+HeIaI9oFRXmhjEGGAL5NIA9hi7TH27yUVtc/o0d9uYU+4rGTjhoZgV2heX1JDL0R3zxLlg6xJP0wlWFydMIbovPIIZ5Cihh92j0JLGhHwV8qU0NuNxVadpOo4j6r2hkiPCFjKtmD7dTnC0wgN8lGtcujTVZE2zdVtFqUbgT2H3hP4Vfg71Oj/fe73uNxxbZV1pjwM5aZeZU/52vdkFwa7zgFpbGD3gQop9CTTHGvYrMsTH1IHrD2AD1N1lqvBGeMYcsene0lvPYKQbUlb9yNZqQxeNHiWmnq9CyjfBoBEXCeiuKYoqv0m34dJEGxM+Q0vAHw9eErzYySb6mL7IcXRG7pjefN4wHmGuipw9WhAOeyfJm1yLhsgOsTHB6i/gfj8dMY0bFBLHNiK1/VBZQ1EXFxA70l6MV4NDxksPVZM8kiPovYnBSh80S7s+fzIj59afe/YgjYUdiaHXn2unq7PAdO0Sb2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRYaGpTVXRFcU43OGZ3ODh6Y2F4bWtLcVhjYTM1OUpyaWl5RE9pU3V2QVlt?=
 =?utf-8?B?eXYyelpISkJ1QkI3NGRiU1A4Q1VRVUczeFB3UGFUTVRMbUtQRS9PblBYSlk4?=
 =?utf-8?B?UE1ZcUNhTWZnbXVCQll2dENZRjFtcTcwZXlpN3FaNlRKTXpCRjhBdzBHZzE4?=
 =?utf-8?B?Q3NtWDVsKytybkRRN0JkMTh2SFhaWmx0M1BzaEZsNUx5S1h4dGNlZDIyam1k?=
 =?utf-8?B?YjFBdGpyUEJRNkRwOG1nK1BIaTdDN0o0ek11VTZuaHN3cTJ2YTZOVHh0TnYv?=
 =?utf-8?B?a3pqWUxrejBmbUY2QVA2TUFvdW9oUm1ONnBVb0FSbFhlbkNRZnZMQTZuWlpD?=
 =?utf-8?B?djJvUzVXZ0c5dHVVN1Bib0JHSnBVTStHZEdvbUdSV0NXdVBsSklEVlVRY3Jq?=
 =?utf-8?B?STd2ckpZR1ZJTWpDamFWSUM3VkpIYmt4OUFpN3JBa2ZOOStpUUxZYUt2YU5o?=
 =?utf-8?B?dkFjcnZnUTRlRWJiRk5wZE9Hc3ZodjBGMnJ3K0xrWkxmcWRKZjdzNVBtanh3?=
 =?utf-8?B?bEc5WXVaeGZ1NXQvc0o4Y05FbUs2Nk1pNEVkaUswNWZyVzV5TnpQN0RlTTUr?=
 =?utf-8?B?VUN1ZVd5c3J5dE5DbmZDOWJhWDF6U0xETCs5Y3RnMTQySUtua2lCZTVQQ2or?=
 =?utf-8?B?WllNMzljWkJLSnRhdVdnVk9HMU9KZHFRTm1nVjZVbFQ4SWdTcUtMUy9iMHZT?=
 =?utf-8?B?L2R0VUJveFVrZ1BtK0RBZGJGZDlnSkZkVC9yNkg1dnN3bEZjYjJBS2VLT1FR?=
 =?utf-8?B?R0wwSnYxTDBrSFYwY3poOWxhZk5hbmlBTkJ6cHhLOU45SzBCc2NQbWQ4Rmdv?=
 =?utf-8?B?Q3MvS1dVNllsWm5laVRidFdRRDVocHMyVHZHaGl4Y2Yzd0F1QkdJQjRKSHlO?=
 =?utf-8?B?M1pvSlFKWEZIbHVKWEVPLzFTUEY3VHdLclZLT2Q0MElhZTVWV0VSL1Z5WjVN?=
 =?utf-8?B?WCticnJLNDRlN0Qrd2JvYjhKNzR4MnhlK1Joc1JSMVZXeXpKOXhnY0VINmtX?=
 =?utf-8?B?S25BSENjam0ySlVKN01OTkdid0pCRW9XZkM2NE84UDkzdU0yWkg2TlVEejVn?=
 =?utf-8?B?bEFrUHYwVW9hVXgrVWFXQnRkTjhYcnhYSUlRQlF4aHdlc1BmMFJYVTFFUkti?=
 =?utf-8?B?a1plZDk2MmsvbmR0SlFFbE5yK2hySU5FalRleDZRQlVhanlRQVR3c3BRMC9V?=
 =?utf-8?B?ZExrNlhQaXBsT0JOcG9tdFpZcm43L3VndVJYWGJmRHZZK0FpaE1MazF6OVhh?=
 =?utf-8?B?dUZ6U0JQS2U2K3hKQTM5YktscFh0OXJZT1FvNlk2UzF1L3hPVGplb2FiK0hQ?=
 =?utf-8?B?eXVTWWpQbjlWQm5yVHovTjlTdTRrKzNnVm91ZmZXTmZWd3FLU05pWE9nemd1?=
 =?utf-8?B?RHpYZzY4WlZFSkNmOUhBUkdRYUZ3elhkSFdtZGphYVBNaWx6VFJub1RCSDk1?=
 =?utf-8?B?dXkxNnVKdmUvNGowNU1SOUlXTzJDUTMzMktreExCS2FnZlNnZHAxbHJwRWV3?=
 =?utf-8?B?UUJ6Q0psdk1xNjNYY1Nnd01SdWhpSHUvV3p5VFBheFRSM2p6M1F0LzV6aWpK?=
 =?utf-8?B?OU1ldmM4eDgrK2hLSzhvSkNGQ2hvMTFkc1RFQTJRRXJza2RUN3VkUHMxOWZx?=
 =?utf-8?B?cGgydHUvTHdtRGhEb0FXRTBVOEg0bW4wRmJvbFpzOEIyTmUxY0E0MGZTa3ZT?=
 =?utf-8?B?TGRFS3ZWOTZYTGhNMERjMmRBaXdZWWJOMDhsVmVqRVZGSHpGb1RzNVRvbTRo?=
 =?utf-8?B?ZFVWWiswWExBamo4cVl0OE85dGwrMElxSk53a1B5QVRLQmNSaVVRSlBhZVg3?=
 =?utf-8?B?ZjZoQXZYZm9sVUZmTzZ5QWFnbjFzK0c5d1BhY3ZJTzJWYTBwNE5xQTNwMjhJ?=
 =?utf-8?B?dGEyVWVtQlF4dGRoOUFoeEZmejNzK3AvR1hqeXV5M1h6MzlWVW5SdkQ5ZURM?=
 =?utf-8?B?aVRYVnZBU1dHWVBMdjNyK2ZydFc1bmVlT005ZHRDNGZRRlhSM1FTeUpick0v?=
 =?utf-8?B?VUJ2V0pENkdqUzcxaC9ZY2VBRWhnVTMzLzhiSE1CNGRsZWlUcTgvWmZhNzg2?=
 =?utf-8?B?RVNKcCtMTFVLSjdDVkNVMHB2TWx5YWF6emZpdnZsU2NFTEEyY0NieDY5VFRO?=
 =?utf-8?B?d3FOMGJOVzdQM1FTZUVQQmplS0VpVUt2dUQ0a2xVUUNoVTlWM2RTSkxlRjgv?=
 =?utf-8?B?ZUJpcHRzVVBJMFdaZklpbzZ2Yk9CVC9ablFneERKcnc5UStFYmJKeE9RT0RD?=
 =?utf-8?B?T0k4TkEzZ1pEK0g3TjJnWk40VEJZeGxVTjFSWGRRdWwwYTcyRlA1dGxKbGJL?=
 =?utf-8?B?cWpQYmt6U3RoeEFKSGhYdUlWSHdaYVRsYkIrOU16cEwrMUxqb0VMMnlERzJi?=
 =?utf-8?Q?wbEidC1K02PW3Shg=3D?=
X-Exchange-RoutingPolicyChecked: OMkA+rhQhlvzJhJbfHpSAWfioAoazV94WEO/TBTe/Vh4ZN/xwxsWCMkhAKxEUaZ64Ld0ghRUobyNwOXwC4ocTXvcxOgX9fJCUOaHS5fDa6BtLz9gSgKA9zxrjf1bDcWIb1YQ5c9lqZaXG1rDq98GRbJH1vwkaIAdn5/kuyXK9V1PsAv/hKh98V/UWcWwZkZd4xzv9uzh1KjhTcm9ON71iCs5GPB6wCaxkWCiA+iw+S3QLS8kbt0Z6P4yIT2IUVbnjF/u9lq7RuFRozSQgYp4rnS/Dc/x5hrba9duttgRtYDlX0DgSt0yyDUtAaJpsAiG15DdmceKZbwGgihrHc9btQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3fd976-e6ab-44b1-242b-08deee212499
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:58:45.4723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BV9B7Y7gRwkTrgUyX0+skaslnR0wY/iU0C1C0kKZn6teaMBlLG+U6lJoynRLuw8V0u30oOgYRqSabyJ31V6KmEp1w8zg7zPjUxQp4R+bBiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9964
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

--------------h0EIP2tcT5XSRbvzw6XtSjwJ
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 28-07-2026 11:26 pm, Jani Nikula wrote:
> On Tue, 28 Jul 2026, Mallesh Koujalagi<mallesh.koujalagi@intel.com> wrote:
>> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
>> The original scnprintf()-based loop required a manual pre-flight
>> bounds check.
>>
>> Replace the manual bookkeeping with seq_buf, which tracks overflow
>> internally. seq_buf_printf() writes each "method," token into the
>> buffer, and seq_buf_has_overflowed() detects truncation immediately
>> after the write that caused it — using drm_WARN_ONCE() to report it.
>>
>> On overflow, len retains the position of the last
>> successful write, so the trailing comma is stripped cleanly without
>> including any partial method name in the uevent payload.
>>
>> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
>> Signed-off-by: Mallesh Koujalagi<mallesh.koujalagi@intel.com>
>> ---
>> v2:
>> - Add proper logic to handle recovery string. (Raag)
>>
>> v3:
>> - Convert manual bounds check to seq_buf. (Jani Nikula)
>> - Use drm_WARN_ONCE() instead of drm_WARN_ON() for overflow. (Raag)
>> ---
>>   drivers/gpu/drm/drm_drv.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index e51ed959da89..6a5e3fa1350c 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/mount.h>
>>   #include <linux/pseudo_fs.h>
>>   #include <linux/sched.h>
>> +#include <linux/seq_buf.h>
>>   #include <linux/slab.h>
>>   #include <linux/sprintf.h>
>>   #include <linux/srcu.h>
>> @@ -578,15 +579,22 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>>   	char *envp[] = { event_string, NULL, NULL, NULL };
>>   	const char *recovery = NULL;
>>   	unsigned int len, opt;
>> +	struct seq_buf buf;
>>   
>> -	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
>> +	seq_buf_init(&buf, event_string, sizeof(event_string));
> See DECLARE_SEQ_BUF(). Remove event_string altogether (or make that the
> seq_buf name).
Sure!
>> +	seq_buf_puts(&buf, "WEDGED=");
>> +	len = seq_buf_used(&buf);
> Why do you need to keep len around?

|len is kept as the end of the last complete entry, not as an append 
cursor.
On overflow I use it to roll back to the last known-good comma and 
NUL-terminate there,
avoiding a partially written recovery method in the uevent string.|

>
>>   
>>   	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
>>   		recovery = drm_get_wedge_recovery(opt);
>>   		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>>   			break;
>>   
>> -		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
>> +		seq_buf_printf(&buf, "%s,", recovery);
>> +		if (drm_WARN_ONCE(dev, seq_buf_has_overflowed(&buf),
>> +				  "WEDGED event string truncated\n"))
>> +			break;
> Nah, you can keep printing to seq_buf, and only check at the end once
> instead of looping.

Agreed!, will update next revision.

Thanks,

-/Mallesh

>> +		len = seq_buf_used(&buf);
>>   	}
>>   
>>   	if (recovery)
--------------h0EIP2tcT5XSRbvzw6XtSjwJ
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 28-07-2026 11:26 pm, Jani Nikula
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com">
      <pre wrap="" class="moz-quote-pre">On Tue, 28 Jul 2026, Mallesh Koujalagi <a class="moz-txt-link-rfc2396E" href="mailto:mallesh.koujalagi@intel.com">&lt;mallesh.koujalagi@intel.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
The original scnprintf()-based loop required a manual pre-flight
bounds check.

Replace the manual bookkeeping with seq_buf, which tracks overflow
internally. seq_buf_printf() writes each &quot;method,&quot; token into the
buffer, and seq_buf_has_overflowed() detects truncation immediately
after the write that caused it — using drm_WARN_ONCE() to report it.

On overflow, len retains the position of the last
successful write, so the trailing comma is stripped cleanly without
including any partial method name in the uevent payload.

Fixes: b7cf9f4ac1b8 (&quot;drm: Introduce device wedged event&quot;)
Signed-off-by: Mallesh Koujalagi <a class="moz-txt-link-rfc2396E" href="mailto:mallesh.koujalagi@intel.com">&lt;mallesh.koujalagi@intel.com&gt;</a>
---
v2:
- Add proper logic to handle recovery string. (Raag)

v3:
- Convert manual bounds check to seq_buf. (Jani Nikula)
- Use drm_WARN_ONCE() instead of drm_WARN_ON() for overflow. (Raag)
---
 drivers/gpu/drm/drm_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e51ed959da89..6a5e3fa1350c 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -36,6 +36,7 @@
 #include &lt;linux/mount.h&gt;
 #include &lt;linux/pseudo_fs.h&gt;
 #include &lt;linux/sched.h&gt;
+#include &lt;linux/seq_buf.h&gt;
 #include &lt;linux/slab.h&gt;
 #include &lt;linux/sprintf.h&gt;
 #include &lt;linux/srcu.h&gt;
@@ -578,15 +579,22 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 	char *envp[] = { event_string, NULL, NULL, NULL };
 	const char *recovery = NULL;
 	unsigned int len, opt;
+	struct seq_buf buf;
 
-	len = scnprintf(event_string, sizeof(event_string), &quot;%s&quot;, &quot;WEDGED=&quot;);
+	seq_buf_init(&amp;buf, event_string, sizeof(event_string));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
See DECLARE_SEQ_BUF(). Remove event_string altogether (or make that the
seq_buf name).
</pre>
    </blockquote>
    Sure!
    <blockquote type="cite" cite="mid:ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	seq_buf_puts(&amp;buf, &quot;WEDGED=&quot;);
+	len = seq_buf_used(&amp;buf);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Why do you need to keep len around?</pre>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style></p>
    <p><code>len is kept as the end of the last complete entry, not as
        an append cursor.&nbsp;<br>
        On overflow I use it to roll back to the last known-good comma
        and NUL-terminate there,&nbsp;<br>
        avoiding a partially written recovery method in the uevent
        string.</code></p>
    <blockquote type="cite" cite="mid:ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	for_each_set_bit(opt, &amp;method, BITS_PER_TYPE(method)) {
 		recovery = drm_get_wedge_recovery(opt);
 		if (drm_WARN_ONCE(dev, !recovery, &quot;invalid recovery method %u\n&quot;, opt))
 			break;
 
-		len += scnprintf(event_string + len, sizeof(event_string) - len, &quot;%s,&quot;, recovery);
+		seq_buf_printf(&amp;buf, &quot;%s,&quot;, recovery);
+		if (drm_WARN_ONCE(dev, seq_buf_has_overflowed(&amp;buf),
+				  &quot;WEDGED event string truncated\n&quot;))
+			break;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Nah, you can keep printing to seq_buf, and only check at the end once
instead of looping.
</pre>
    </blockquote>
    <p>Agreed!, will update next revision.</p>
    <p>Thanks,</p>
    <p>-/Mallesh</p>
    <blockquote type="cite" cite="mid:ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		len = seq_buf_used(&amp;buf);
 	}
 
 	if (recovery)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------h0EIP2tcT5XSRbvzw6XtSjwJ--
