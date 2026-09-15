Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCACC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED42C10F900;
	Tue, 15 Sep 2026 04:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UV6uKMXL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFE310F2F3;
 Tue, 15 Sep 2026 04:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789445275; x=1820981275;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1F/XVagQW1P7Ht9CbgS5LzdHeIrkKIsawMHMDlYOf40=;
 b=UV6uKMXLfL7WfYN6mZ5rXU1Ei/PDI0nGKsFUnecbjULzKW+6EDzCfwn0
 pMxOuawTE3OKOISYFL94dM+yLwy9rQw96mbguLs57x6xf52wb6Le14TUU
 UK/sac72llyFkKmoJQgXvc35RmbfNthSRDJcv1pqW4Z4118sCKgJztsuo
 SvBbG1890p1RQ6krsw9fsy+OpsoVvs3/6ixD0gzq1JEcy5/6Qe6AynD/r
 326ZpjEUMOkxn5Nz83UYpXt1GkrtpDzKXrAaLiTcHvwWU8oVFfdMjHddD
 MbGxK6H18tXwxrhOnUMlxpC8KrxI0kDm/hxII0bq14JBUF4Q1G/258CCO g==;
X-CSE-ConnectionGUID: hII0NOBNTwCj9PPAvSlgYw==
X-CSE-MsgGUID: 7nYsk945RoSHi2ZuDItzKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89741213"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89741213"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:07:54 -0700
X-CSE-ConnectionGUID: NxbMy0JPRtSZANx0xRS6lQ==
X-CSE-MsgGUID: q0rI3uJ8RkGKV+I2kpiRyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1038434"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:07:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:07:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 21:07:53 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2UU0S42w0fAAAXDfE+dS0SqVOi2mxSDweDhOAy4Y03cCctDtxhqxsfgQ7D7rVV0+Y7hPQL/zBshd7icE5sNeUWivzK2S3Em5UK7rXSOLHwReGlBDuFOYczp5aUoxYGSWZGdfpV1Egy8kUggbfUrPBz5sMJeqMSTSQHnRtNprKNuzHtXHFyD2pnF6jaPIAGYQeSHrPWOWZwk5n0y9cEnzgjtazz5qV08TWz5BqVBD5HpBaVrj3uT7BH/ewIaDwzv1Oivna3hBnUs52ncEStZbrbiBTcA9G3z2Erw4SBfOi8JHpH947qGvutNY9A9ySaPhGtkS/J6VvAF59EbBos0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc9k755bwduGra1kgluZ8BojmCaalG/xbVYca2sxKmg=;
 b=hpDuRPdgEw1U17xt4cV8cAlybF8Mkg0nESX1+2tPsB6wZcXwQxOLW7yfZQYAhnChoLivB3VbXboU2hTvJdu6pRnATRpsxD2ns0Zi7csLIUGAgPu4Byvh+ep36Nlbm+xBFDlyJdPoQsB9IUW27Ryerqvd32EUHpWXVa5Mn/mTFfQ1+8kSkZb/zlshyz8QMaDrVmKWOcC6Y7NfzTvbFaFJB7tAjaKyz1dhcuMobWAx3CHXVAKuWVH2GYSASdtU+zYN2WkI8eOjcexlk3mKnt/3SLQBbUUL6XYmw8XNbTugnMn25OlSuXQgBXTXInKzKewW1v4slzUsHVo6JemXQZOa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by LV2PR11MB232652.namprd11.prod.outlook.com (2603:10b6:408:417::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 04:07:49 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:07:45 +0000
Message-ID: <dd731a05-be72-41c1-9516-d5a3adb450f5@intel.com>
Date: Tue, 15 Sep 2026 09:37:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] drm/xe: Stop VM work when device I/O is blocked
To: Matthew Brost <matthew.brost@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-5-arvind.yadav@intel.com>
 <apXqRXClcZThJovR@intel.com> <e1673532-3f31-4be2-ad35-0a998aaa9783@intel.com>
 <ape24NZ9/0tUV3ZH@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <ape24NZ9/0tUV3ZH@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|LV2PR11MB232652:EE_
X-MS-Office365-Filtering-Correlation-Id: 905f4759-c315-47b0-da05-08df12dee5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qYtSIicF0bi3HK68efMP/vR6HnHPkYiTwcmVkOqzmwV3ZbfzED7AxMOCl9oj57T058jkSC5X/Oh6oG4CgKC7Sfg5Pu0Jjv4xxxZ3i1p4HdfNBC8GQA47f1dmzA2VghCfFhKrPgixZ8wMXCE5RqMD59M+jTfGJd8CtFixkuWuwdnTE1mUGXLdyCv9Ou90ih08GQNerxmKjIIy7zNT93mieU80ZNx8Oy3Nh8Rs9Jgg/HCSGR19WdZHlLWuU3MCD2pw8Gxg48LOC7Y9jSeNTjyBGlYr5F7n74RuL/jT9MKEu7DL3C4Kk52szVQvbabvXqZ2pzm3ZV+Ift8JidHv9h31ajX6nxtT93ssbiWmQWUSztAk6azvlMKfzKZYigX/KQZMoyPU4Hxxq3e1y3/zZuVTWkn4jUYbP1JbDPZVA71yWkeLT6zyE3a49mS8CBAtf0KkcApUFsqV5qj8ugPcqYMbn9qJxZZJhfX0UGUaGZnTNy8vy1UQAaY8yYhzy7Z+YUqsEqU8wa6TyDIgO/ZFSGpgt77tBZqWoOh9AKWmtHN5XIphuBmd6dAJGgvZjg/3oNwGgOIhiN4yTI9+Y3xaf+TQRF9VoXMb6/qwCr+7lypXvSqr0Aj/oYOXmPr9cfTj0NlAKwxvzl65c6Z6dZnqPGeuAS9wkyjP9TgQ7T05ffU2nWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3h6MEJNNnoyK3QyRzRPZWlvZml5d1dqd1RMOW5FSjJYSWJHL2xYbllMTU5w?=
 =?utf-8?B?clA5SEc3bDJQdUpkSDlqZ2hSNldxTlBoaWgyeWtnYmVSdjZxYktQMlR5OCtH?=
 =?utf-8?B?TWJjUExabnBDcWZLalNMV2NjUkxMVFk4ekJ2UXg3bWdMWTU5TzUzZ0c1SEFH?=
 =?utf-8?B?SThRRzhFTjdDemUzY1dlNENvaExKejZWamxtNXByZER0QitKWm5hTTJkSkJ1?=
 =?utf-8?B?MTYyTjFIRDRBbjUyTnJ2M2pmeGdNVHFnQW0zc3pMb3dUOEV1QXJZWlFnUWRj?=
 =?utf-8?B?SUw2VWRaRFdqVCtmL3Z1RFhwblowblp5NzZlZGptbkNoQko5MEpCdVY0Sk4z?=
 =?utf-8?B?WjM4Y29QWEhUU0YxZmVnbVp1ZGhqYW56UGQ0SGdkNkNvQUsxMkx5dngzOTkz?=
 =?utf-8?B?cjRJaUhGN29sRkc4cnJmaXlYZVZ3UmJnaitYVWxPYkpRRkRQZnNwNGhtRXB6?=
 =?utf-8?B?R1BJQU9sM0dqek5FMnpFcENZakp1dmwxUVBGdWVYR3VrbEk5bTdKUVNPU3J4?=
 =?utf-8?B?MWxLVHQ3bzlnTEZzNlNBQU44aEswRkZCMGhMUUhXdWNPMVJQQ05mWWkvdm9P?=
 =?utf-8?B?Q0Z1Z1ptcjZlMjlJY0wramtZWU02bjVrbkNVZjRhNEVEZS9vcDJUN041ZzJz?=
 =?utf-8?B?Q3dxYVQ3a2s1NmVKdVY0eXRnOHNOUmJXTGhmRHoxYXpTaEtuaXh6NFBkMFo3?=
 =?utf-8?B?Uk9Db3EydGdUbnpBYkdYTE1Tb3BWdkMzYm55V20yV0QrUW5sSEFyWW1KMy95?=
 =?utf-8?B?NlVYOTkzMkxHK2lkVS84UjBwaWpONEdlMmZzbm9rN2piaTJTSzUwWlh4YUpC?=
 =?utf-8?B?RFVtL0twanVlTGNyTXgrd0ZJQ0lSeGFyYUJBMlpmcXl6cUJmbGNKQXNLN3li?=
 =?utf-8?B?LzVYbVplUXQyTjZ4U0NCd0d6WlBEdUR6bXYwWmpqd0R3Szc3TWdsWFBiK05S?=
 =?utf-8?B?VFdiUy9sckhUY1duUEgxNmFQTW5vUVQ0TkovVHdTOGN0aGdrVEZPSlBuMUlJ?=
 =?utf-8?B?UHBld2pYdjcrQUNHVDhDTTRWNktMUmxQQWNqK3dxVGdNK3pCNno5OFgxNndK?=
 =?utf-8?B?U1k2WnBhcFJ1dFhhMEMyMG9meEYyMFY1Nm5HeGVqbzZibmhCUmRCM0xDcHZm?=
 =?utf-8?B?eVdSUW13ZEp5WmQwaVZGTVV5SXE4WEMzaExvWS80OVhydUs1eEc5R3llSmtz?=
 =?utf-8?B?Z3ZxZmV6b2M5OE9vNHFwVy9LWXRjNjA1b1ZjcVg3cW1jakxybFdBS1lKdUIy?=
 =?utf-8?B?Z1RqTlM0VTRiSmpicFNEWHJPREplYTR0b2NIcHZyYjlaOS85bnBLVzduQTRu?=
 =?utf-8?B?dlFGbTBFMW4vOHBkYVdzakZlRVNCQTRnS2owUjh6UWI2bkN1MlQ3SWdmMTNZ?=
 =?utf-8?B?UUVhWkVLVnRMY1FWVmhGL2l6cExOQVJjMFVObDFFakpaVERFVDJBSXVOd0ow?=
 =?utf-8?B?cStMR1RjL2Rac2YvUnFzVEZSQWpITkI5M1F1MFJncUJrcWp4VkM0c081S3N3?=
 =?utf-8?B?Y2VjM28zajJXellpelI4ZkpLOUg1TFVCdngxODdxQUI5YWk3QVVabGhFSitO?=
 =?utf-8?B?SHNjYzdZWlphUERNZEZGY01nSTRsRzA0S3N3RUg3SjhXL0lCL2RjSWVIYU9m?=
 =?utf-8?B?Vm5ITk01YXBuMUkrRlZMWHo5OHprVHJkVXVzZmlhQ1Z0anBVbHh2YzdUSjFU?=
 =?utf-8?B?OStaMjhUK0lmYno5WE1pT1VSV04xKzQ5V2N6TUN4RTg1Qlo3OUtUU0l3eFdn?=
 =?utf-8?B?cFl1dVVyWGQ2WCt6Z1c2MGxqRkFmS3FjWDBUcHUvR0JiQkppazVVL3greW9Z?=
 =?utf-8?B?WVN6dWhNOEowdEVsMUZ2RW5tYlRQY1FrUnNPa0JJM05xT0FDZnhxa3BvNXhv?=
 =?utf-8?B?UkNOWFd0bUVsTnIzS1NpNU1DVitMd21uQVlCWVQ3R3Nmd2xpVFluSTJLbGZN?=
 =?utf-8?B?TmxEaFMyeGhLWkNQQUI1Vm9ZK25WU2ZlQkgycWJFQWdJbjdJWGZuL3pQRDNT?=
 =?utf-8?B?S2dDMHY5VTQ3Q1F0ODZOMXpvbXU2ZVQxZG5CUVpBV1R1UW1BSEVVSHlSaTRL?=
 =?utf-8?B?UGhjclRpVVJLanhickU1TGFjTFRwZnJ0Q2I1b0xpMkhjSU5hWUFZYmd5Q1dD?=
 =?utf-8?B?U2JMNStwSTVnVXhmUHpWY2NiTFQ3dE51R09oN2pRZk5WZjgwQ1dOKzZlaytT?=
 =?utf-8?B?a0dRL0F1ZWd2MUpBN08vOEZTVDNxVFpnRGNCdjM3RmQ5UFNVcnMrZncyYVhq?=
 =?utf-8?B?YkRtRDg5QlN3Z040U2tCNE1kNzhEakpCQUhBNEpYT3VZMXMxQ3puZ3kxVVNx?=
 =?utf-8?B?UzFZeDJsSys0MFJTS0dTbWhjTXloRUtER1F5QXdwVU9HV0d5cE1PQT09?=
X-Exchange-RoutingPolicyChecked: 0P9/Z+rJ55qHrbkYHj7lUTSOt2pDzPCh7w1IS2CF5EwKyEtY1DHYPCt2fZ+aik0HUoeXyO5Va7SyXgTrWVOhOMph2jjLaitestfrDPrYZBCWR5IYUiQBFeMDD1R/OGChBLpyhv4XlRBkmctevY01o1G1btMG1lGK51pGxGDMMBEliuoZk3HSVMulebAQteeku4j1Hw+zfTuOSzl4cPfI/Gu5GRCfO7XMQvuOG2pr6Mip7wiSEvMdDYDSBK4oYinMADWhxx8+FTUtVkIvbnmmplOABQoKYGPGqmWLz5jZgkWdKa5EJYbRaOXfc+rQ7lCLKNb+Zpg7mCAe9+QxI1RW+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 905f4759-c315-47b0-da05-08df12dee5c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:07:45.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K75wl02XPi+3xvGxqASvQzZ+IXu92PG/HMe/V0N9OWWcAINVRcGhUdLCKpB54qEgI58Hdfq2npiXStHkyhLJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB232652
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


On 02-09-2026 11:10, Matthew Brost wrote:
> On Tue, Sep 01, 2026 at 02:41:44PM +0530, Yadav, Arvind wrote:
>> On 01-09-2026 02:25, Rodrigo Vivi wrote:
>>> On Thu, Aug 27, 2026 at 03:47:52PM +0530, Arvind Yadav wrote:
>>>> SVM fault handling and VM rebind work may still run when PCI error
>>>> recovery starts or the device becomes permanently wedged. This work can
>>>> validate BOs, update page tables or submit migration work after device
>>>> I/O has been blocked.
>>>>
>>>> Stop SVM fault handling, pagemap population, device-memory copies and
>>>> preempt rebind work when device I/O is blocked.
>>>>
>>>> SVM invalidation still performs its software cleanup. Do not warn when
>>>> TLB invalidation returns -ECANCELED because hardware access is blocked.
>>>>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>> Assisted-by: Claude:claude-opus-4-8
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/xe/xe_svm.c | 21 ++++++++++++++++++++-
>>>>    drivers/gpu/drm/xe/xe_vm.c  | 16 ++++++++++++++++
>>>>    2 files changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>>>> index 627a741293d5..9e78131bfa39 100644
>>>> --- a/drivers/gpu/drm/xe/xe_svm.c
>>>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>>>> @@ -11,6 +11,7 @@
>>>>    #include <drm/drm_pagemap_util.h>
>>>>    #include "xe_bo.h"
>>>> +#include "xe_device.h"
>>>>    #include "xe_exec_queue_types.h"
>>>>    #include "xe_gt_stats.h"
>>>>    #include "xe_migrate.h"
>>>> @@ -288,8 +289,11 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
>>>>    	err = xe_tlb_inval_range_tilemask_submit(xe, vm->usm.asid, adj_start, adj_end,
>>>>    						 tile_mask, &batch);
>>>> -	if (!WARN_ON_ONCE(err))
>>>> +	if (!err)
>>>>    		xe_tlb_inval_batch_wait(&batch);
>>>> +	else if (!(err == -ECANCELED &&
>>>> +		   xe_device_io_blocked(xe)))
>>>> +		WARN_ON_ONCE(err);
>>> if (!err)
>>>           xe_tlb_inval_batch_wait(&batch);
>>> else
>>>           WARN_ON_ONCE(err != -ECANCELED ||
>>>                        !xe_device_io_blocked(xe));
>>
>> Noted.
>>
>> Thanks,
>> Arvind
>>
>>>>    range_notifier_event_end:
>>>>    	r = first;
>>>> @@ -631,6 +635,11 @@ static int xe_svm_copy(struct page **pages,
>>>>    		}
>>>>    		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
>>>> +		if (vr && xe_device_io_blocked(xe)) {
>>>> +			err = -ECANCELED;
>>>> +			goto err_out;
>>>> +		}
>>>> +
> Again a toctou given this state can immediately change.
>
> Unless I'm missing something - my answer is basically no, likely for the
> entire series unless this is a non-toctou check as otherwise we just have a
> bunch of weakly ordered checks throughout the driver which don't
> actually protect anything.


Agreed.  I will rework the series to block new access and drain active 
hardware users before reset or wedge.


Thanks,
Arvind

>
> Matt
>
>>>>    		/*
>>>>    		 * CPU page and device page valid, capture physical address on
>>>>    		 * first device page, check if physical contiguous on subsequent
>>>> @@ -1125,6 +1134,11 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>>>>    	if (!drm_dev_enter(&xe->drm, &idx))
>>>>    		return -ENODEV;
>>>> +	if (xe_device_io_blocked(xe)) {
>>>> +		err = -ECANCELED;
>>>> +		goto out_drm;
>>>> +	}
>>>> +
>>>>    	xe_pm_runtime_get(xe);
>>>>    	xe_validation_guard(&vctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
>>>> @@ -1165,6 +1179,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>>>>    		xe_bo_put(bo);
>>>>    	}
>>>>    	xe_pm_runtime_put(xe);
>>>> +
>>>> +out_drm:
>>>>    	drm_dev_exit(idx);
>>>>    	return err;
>>>> @@ -1301,6 +1317,9 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>    		drm_gpusvm_range_put(&range->base);
>>>>    	}
>>>> +	if (xe_device_io_blocked(vm->xe))
>>>> +		return -ECANCELED;
>>>> +
>>>>    	/* Always process UNMAPs first so view SVM ranges is current */
>>>>    	err = xe_svm_garbage_collector(vm);
>>>>    	if (err)
>>>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>>>> index 19b3d0be7928..0cee5306fb9c 100644
>>>> --- a/drivers/gpu/drm/xe/xe_vm.c
>>>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>>>> @@ -497,6 +497,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>>>>    	}
>>>>    retry:
>>>> +	if (xe_device_io_blocked(vm->xe)) {
>>>> +		err = 0;
>>>> +		goto out_unlock_outer;
>>>> +	}
>>>> +
>>>>    	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_rebind_worker(vm)) {
>>>>    		up_write(&vm->lock);
>>>>    		/* We don't actually block but don't make progress. */
>>>> @@ -518,6 +523,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
>>>>    	drm_exec_until_all_locked(&exec) {
>>>>    		bool done = false;
>>>> +		if (xe_device_io_blocked(vm->xe)) {
>>>> +			xe_validation_ctx_fini(&ctx);
>>>> +			err = 0;
>>>> +			goto out_unlock_outer;
>>>> +		}
>>>> +
>>>>    		err = xe_preempt_work_begin(&exec, vm, &done);
>>>>    		drm_exec_retry_on_contention(&exec);
>>>>    		xe_validation_retry_on_oom(&ctx, &err);
>>>> @@ -531,6 +542,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>>>>    	if (err)
>>>>    		goto out_unlock;
>>>> +	if (xe_device_io_blocked(vm->xe)) {
>>>> +		err = 0;
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>>    	xe_vm_set_validation_exec(vm, &exec);
>>>>    	err = xe_vm_rebind(vm, true);
>>>>    	xe_vm_set_validation_exec(vm, NULL);
>>>> -- 
>>>> 2.43.0
>>>>
