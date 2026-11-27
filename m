Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6F606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WdpBt4tm;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PxCNNhVU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B464E11228E;
	Fri, 27 Nov 2026 07:17:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15CD10E129;
 Fri, 27 Nov 2026 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795763823; x=1827299823;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A3AlCFJ5hMyaM88dfq63HkJrsG02Gmx50OtrIYeDxcE=;
 b=WdpBt4tmDLDCDZqaJARzJM+vwMWCvjLFK+EA3aMfiRoHL+YHyeMqiuIs
 wNr4tQJ1Af9nzLGISiVGO53oqJ97TMbsLmOd0245vZtDcMFdh8IVKl6Fo
 nwPkrVCtGh2FaH/UyViiZyMtTmwsSv/8YL+zH9ys+OGxL9CVW83DPc4lC
 f+4eUbO7mbBWBTuyDCCHpZ6ZydKnVT2mq2P7s5BsV1LDr41LPlql87XMF
 bPZFPIIeIdbR8A/fQDvVn3eYdUrIC3/c5Q15YrqZ0b0vjP0AABbpnpCam
 vWsZd5r+c2zSkeqdcCjeAuT37erk3vLQ/FWZ2oqa49shJErlyzua/r6xW Q==;
X-CSE-ConnectionGUID: a1zkeubRR5e+Z/PDdaADWg==
X-CSE-MsgGUID: eYxaRobySxKsO6BEnRKnbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4582079"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4582079"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:17:02 -0800
X-CSE-ConnectionGUID: lcTrG+mPQtSr57GLgzRDAg==
X-CSE-MsgGUID: ixqGVCTATEuU6H0tepnp/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="14366616"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:17:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:17:00 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 23:17:00 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdlDflZ2L3xL/J383+BhrqXU8LcA6QywQ2xRBl7sizgWy4e99LTsWPCBWPmyjj3ai0kWojnEK8/2Lb8sQP6ToUejxGlLEycaY0yu+9ZABwD48O7wDaJH09MikQjrhn4ix4O1OXnLc1l4dP4CM5vUaB92b8MZnDfFanmLoVQeCOxItP8Iqb0i1Qs/lybBJE3cdAtqYFmHtIN5DMlBGJ1j+cos24oO8R8h4EIXU6wggNwBHymxMrbt9zhIlYHZ80EDsRE56sHwNEf9eNjvpMpBk94H7bjf5tCdWzVnTY3o8F7kfrlfSfSZL56JY7/q1XdZU4d5R1taD78PIcGL24jsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJBewWZg1iPqtl+QQFM77p4zyQ1qD+st9vhxru3XrMg=;
 b=pcYL8fD1Tbl9C1soZHILQdm/dMyHM31w4KGea3bt5bAv2cYeM2dO0e9j8/D3NYaN9bH9yVhGYKVXLoxC4OMuUO33BrfZWvepXgyo600hWra7Smwvr5pGEuyHhpNz6OA/txIoTlx1u8HPjlfZ4xOjacFMYiyuwuW9k7WGHXEQUURInNL312jFAcan/qoCh0DqYjr8AQ6daVsq+6NpPssfpDzq0Ttf6fWYKoT09CgO7NZyGA2LXP+Lw0dQb/zKR3HCyR8NBMh4Ue7+VWrqz88XHNliyzpSJqdO1AS64NuGngmL9aTFzpDX0RpRAE5MYdag7upNBB6DdkvKXA9QZUoeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJBewWZg1iPqtl+QQFM77p4zyQ1qD+st9vhxru3XrMg=;
 b=PxCNNhVUgB5tNQz6e7B6GBv0vERkw4hJfHM18lTqogdU3bMyuh5jOApVdh64RcgQB1A5DT/fCAIgU75gBndaD1DuO5XgEav166JABLq+lBzENJcdBWtodYn9EGr/Gr2HcNoxJ7zznfqYCWyB39UoZQZFlHnF9lurqGqCYCThnkM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 07:16:55 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:16:55 +0000
Message-ID: <07c92fc2-7022-4bee-bb54-6b4d6019939d@intel.com>
Date: Fri, 27 Nov 2026 12:46:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/ras: Add retired-pages node type
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Raag
 Jadav" <raag.jadav@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
References: <20261125190249.156217-4-rodrigo.vivi@intel.com>
 <20261125190249.156217-5-rodrigo.vivi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20261125190249.156217-5-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ5PPF44E8B88DF:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8dd066-11d6-4999-a3f1-08df4c566a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|6133799003|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003;
X-Microsoft-Antispam-Message-Info: NX1Ieg08m0MljFeVo38CKbZwTZ7R9Q59E/t+20ysZ9afJU0pyTgFxGFBFU5bZBGrpNIXE8Yf5E8Ei+iroXe7r/Fzc84fCyClBTIxiZ7sWoMxIopuGuSkfu8gP9U5PZ3NP9gzxodtm71sxy9BbfoCtCqqzLCmZdxpuKImIHmiJCnH+cm29gB5RzR2pieCijcPD5sDidLVrNasMq5QxprRmVxKPca/rHyCzYliLTSa0TD/3ljOg7fkudbyAgkfi7RfT+EhngwDubQcCD78YarTVtAqHbbzZL+MFaonmTFyXmhwxgteNe/mE1pjlvcRw+iRdDHHVJGsWBhT+6o7isVSyMacSa2oZEt1YVbRyzzNQYjQMw4JXb/vksz8C/xh+m9gNZuf/OZMvA4nGBxUR+biSZ2WxLLfrZJ9znzoj/RmDYe1uhiKodWMvFERcE7kJRtU+MYmHpWBXxrEqa8Fz1pFEXB06CPNh2sTf0STL+/RhoavaSU7IVHX2Qbeg3RfLbWH27jsytLgfJrlC6eXmTdN//SbaAjZDjRDQrWIOlQmaC8IM9N7ezQ4UKdNK3f06NyXpSMJJVuD+VVbrObbvWzAXIklvepsIvbLAK9ZiqqjswUTEQwO7S0NL1abuX1J0Lnzad6hXkIXd9bisWE/TaZ3z/POiSeX6h1JA3e/o/9zSgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBJT1pNWmVTRWNwWHlrcDhlMElockNzL09RUDkzYnI1aXhKNk1TTDFycVdN?=
 =?utf-8?B?NjJxWUUrZzA2dWhHVFNlbk4xNHhIS1kvU3Zid2ZwbnlCcWdSZ0JudzZBRnp1?=
 =?utf-8?B?TEw0M3RSNkZFcVVIaUtFc2Y4TDRnUTRMQkpKQm8xQWZxNkFwWm9GbnJnQnNp?=
 =?utf-8?B?cW4vUFhOMTVGbjhNMTFTNVo4QTdVS0F1dEFwTlByY0RzZnNvRVpNYlBHZVZr?=
 =?utf-8?B?MFdzUnpjSldVRW84eGNtSHhlSUh4ZmFJWkp6bjRxcjdKRnRSanRLdFlzL241?=
 =?utf-8?B?bnVtaE1sOXdKbyt3M1daOUw2eHg0bDVzdXJkVUdrR0plVC9nOWc3Q09nS3o1?=
 =?utf-8?B?L3JOSittYjNhMkFkYjJnR1M4RG9LMWp3aityb3diM0hBaTZIOTZVN3hyYkpr?=
 =?utf-8?B?a1N0aUxEcjBRRjkzZlFjTHRSTWdEb1JGSE1rSjhUVjZQQTVzZWU4OHZTT0cz?=
 =?utf-8?B?b1ZUSHUwdXBoc3dabUVCcU1LTks5SFNSY01EZm1jY0lIZXgyL245dWhKZEx1?=
 =?utf-8?B?aWgwSzA0TWwvWExmeGhsU2ZRYkhKWnlQYndQLzFyMCtKT0JteitlclAwcEZu?=
 =?utf-8?B?L2oremtQZTZkK2lBWHdMWlRkaWtQZEhQWXVTdFprWnhPTWNvSmQyREdHMnJO?=
 =?utf-8?B?S3BYT29DdmZXMktaem1CZG9mbVQ5a0JtVU1FZzFjMC96dUE4V2l5a3d3cytJ?=
 =?utf-8?B?RUZKbFY1dEM2Q0xZWnRUVTIrK3RFcjU3SGg1K0VWWE1hN3BPdC9hajVSMTNj?=
 =?utf-8?B?cWFvZUh3Y0IrZElQcjJOcmdmeUVUaWtzaG1KWnRFendUdk43bndNMUN4UjRN?=
 =?utf-8?B?dzFYRm5jSXJvckNOUTJMSXZVcTRSSlJHZGVuUTV5SUtzKzJUcTBqTHpWUDhF?=
 =?utf-8?B?cWg5RjdzcmJPRUVEeTAvYmVud1A5QVBneGpwZ21pNlFwWUlKK2hWWjNqRGli?=
 =?utf-8?B?eGlNM3RyRTd5UU81dDFQSlltZHp3WVZsalRpYmo5T0ZMRVBNNmZnV3ZRckZs?=
 =?utf-8?B?NHZrOWdmKy93R25Rbm1NWnNDZG5yY2s4V0RGd05IQWc2N2pnZG5ENk8wWG5v?=
 =?utf-8?B?TVJKd1VVQUI5cDFqcUlHNS9saVBkckdxTkdNc3djZ05mSzBkbE1ETGxRSXpk?=
 =?utf-8?B?d0tzQldpalF0YmJ4QlpucWNzcUhSaDQ4NEdQZEZMQmhWMFlJVkc2c0s0U2ZF?=
 =?utf-8?B?YkRTZXFQYXpIaWNMWFRobFFqb1EwT0tkZmtueXVFZDcvT2FtbUhoMjlTMGtC?=
 =?utf-8?B?OGtIckFRM1hERUZjS21yWSs2NFpuT2NPRUhVNWxWN3BYaVhhSVZiQzNPeE5o?=
 =?utf-8?B?QnBKVnRuYy9vUEttL2xWOWFpMmlIMDJMSytKNkZFaDUzekJLWXRKOXZWMS9k?=
 =?utf-8?B?RmpOVjB1bUlSQWUySHo2UWYyajUyRGYwcXRjU0RGc2QyTmNraUp4bS9aSllJ?=
 =?utf-8?B?NnhtT2Q5VGVFTlZ6RVpQeWYyWlhKbkkyQ2dBMW4rYkdoa3NudnJzRFpOSjZE?=
 =?utf-8?B?aTlSVFhkSXFHV3RvMmRsU1V4NlVhKzM2b3NyQ2dyNjM0aGJsRHArelUvWVA5?=
 =?utf-8?B?U1F5RlJJaHRkc1E2YXBuanBDdWVmYkpnU3FpN2pDOGR6eDBORUhKa3VLMlF6?=
 =?utf-8?B?NGJwNzZwekhPRUxTOERhRFFVLzExbGhRWlZoSHdMTzNmV1RuaW9CMDI2dzNq?=
 =?utf-8?B?TzNqS3RWaWJXcFhuSU9rS3JSZWwyeWllMzV6U1pHblhIeXltZVIyVVlPSDdl?=
 =?utf-8?B?b3I3bVVnZnJIcWNXM00rcjFxNDM1S3ZMNVo3cGlMUU1Wc2MrZVBLVHFPRXdC?=
 =?utf-8?B?WUJ6WnlFLzRERUxDUHBXejMvSnNGYlZnbHNBZFRNVjNaWUVMSWE5ZGwrU2Jt?=
 =?utf-8?B?QVVNYm8rM0hRTXZqQTQ2ekJqT2hsaUQ4UlZuUW1XVXNyMnN1QWQ2MUY0bE1P?=
 =?utf-8?B?b0FiYWJyY28zM2xtVndGTW5YcE5aeUJxbW1DaTVJSnlNSEY2UDc5cnNTVVdN?=
 =?utf-8?B?MGsrYmZ5dEdDT1hWWWhOV1ltS2EvaUM4c1hreFo0aVg0ME42dnlxNkVFU0xm?=
 =?utf-8?B?MFBQVW51VzBRYXZvZ2psR1hmVTVEMXBEenA0TmtRRG4wdDF5L05pMlp1WXU3?=
 =?utf-8?B?SlIxS2QxeGNLSmEzV3FLRExKazZ5cE4xdFJ1dXpZTmJlMUVVd21rbndIS0RO?=
 =?utf-8?B?QnFNWFVvRkZoYnhwVVd6dnVKZHpTMTMzd214NGpwaGNuY0pKQ3hkQyt2OWw1?=
 =?utf-8?B?UWt0SjQ4Wmxpc0ErUnN2VW8wWGFzWjUvZUt1bVNQNXpKcytWOUpGREUycTlL?=
 =?utf-8?B?WU96cUZFMXdVMUo3TWlnZnJZU3lWL2hoNHV6d01SZDRWeXRHZkVydz09?=
X-Exchange-RoutingPolicyChecked: bi5wgVUX9w+sT8CflymqoHjC+ab7rPBSnm+2JAYoRGZHffvVeGzEdFa+HXwdGya/iXyuRVFOjvdDxltCXMC4KG052qP26i+pIkq+JEsbZ5pzycQGrCu5fi/RKpronjZzeeBqPuVnhid3VgTya37yZ5u/NhmhtKu7dMRatAFFYoqvAXBU1bCQtrZi8VmY2NA3vmoQ3Cf21LOzQh99mkGbWxF9cdR8YeC8I7r725leEdkoO0VMuTRbqv1GzDooVrrPyyNHeJLRT+o67qNxxsrZELklVdfOSJgimpX3K2UU35xrmOJifvuWB0pK7y75123ZvUYg6ROVlM/c9Kzf1t2Avw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8dd066-11d6-4999-a3f1-08df4c566a80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:16:55.1489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/6FC9R2Y4Pg/VdJN9zpVoGZvECoSTqmjL1W+aUnoO0fj5nngL7AU2jT+KL36sFQsXQbGgcQud9rARZfkuUT5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26-11-2026 00:32, Rodrigo Vivi wrote:
> From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
>
> Add a retired-pages node type to drm-ras so drivers can report the
> memory pages they have taken out of service, with two operations:
>
>   - get-retired-pages: dump one entry per page with its address, size
>     and status (retired, pending or failed). The dump is flagged with
>     NLM_F_DUMP_INTR if the list changes while it is read.
>   - get-retired-pages-info: return the maximum number of pages that can
>     be retired.
>
> v3 (Rodrigo+LLM):
>   - Split the drm-ras core from the xe user.
>   - Flatten the page attributes and name the node type retired-pages
>     instead of retired-resources, avoiding the over-wrapping
>     anti-pattern pointed out by Jakub: the type-specific nest and the
>     resource-type enum are gone.
>   - Use uint for address, size and max-pages, no pad (Jakub).
>   - Start the status enum at 1.
>   - Move max-pages to its own do operation instead of a leading dump
>     entry.
>   - Set NLM_F_DUMP_INTR from a driver generation counter.
>   - Report unknown node IDs with NL_SET_BAD_ATTR.
>   - Removed deprecated Assisted-by tag.
>
> v4 (Rodrigo+LLM):
>   - Check the dump consistency once a page message is filled (Sashiko),
>     and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
>     not lost.
>   - Make the error-counter operations reject other node types (Sashiko).
>   - Hold a node reference in the new handlers (local Sashiko).
>   - Rebase on the telemetry node type, moving the type check of its
>     handlers into drm_ras_node_get().
>
> v5 (Rodrigo+LLM):
>   - Split the node and callback checks in the clear-error-counter doit,
>     and write the new handlers like the error-counter ones, with
>     put_node labels and an inline dump loop, for consistency (Riana).
>   - Drop node-id from the dump entries (Riana).
CC: Tejas
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Riana Tauro <riana.tauro@intel.com>
> Cc: Raag Jadav <raag.jadav@intel.com>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   Documentation/netlink/specs/drm_ras.yaml |  73 +++++++-
>   drivers/gpu/drm/drm_ras.c                | 228 +++++++++++++++++++++--
>   drivers/gpu/drm/drm_ras_nl.c             |  24 +++
>   drivers/gpu/drm/drm_ras_nl.h             |   4 +
>   include/drm/drm_ras.h                    |  49 +++++
>   include/uapi/drm/drm_ras.h               |  31 ++-
>   6 files changed, 385 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 0f1ceb705d3d..c217e52197e6 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,16 +16,28 @@ definitions:
>       type: enum
>       name: node-type
>       value-start: 1
> -    entries: [error-counter, telemetry]
> +    entries: [error-counter, telemetry, retired-pages]
>       doc: >-
>            Type of the node. The error-counter nodes expose reliability counters
> -         for a hardware/software component, and telemetry nodes expose an
> -         interface for reading and writing telemetry values to a device.
> +         for a hardware/software component, telemetry nodes expose an
> +         interface for reading and writing telemetry values to a device, and
> +         retired-pages nodes list the memory pages that have been taken out
> +         of service.
>     -
>       type: flags
>       name: telemetry-field-mode
>       entries: [read, write]
>       doc: Bitmask of access modes supported by a telemetry field.
> +  -
> +    type: enum
> +    name: retired-page-status
> +    value-start: 1
> +    entries: [retired, pending, failed]
> +    doc: >-
> +         Status of a retired page. retired means the page is reserved and out
> +         of service; pending means the retirement is queued but the
> +         reservation is not complete yet; failed means the reservation failed
> +         and the page may still be in use.

YNL allows per enum member description and would also put the description
in the uapi header next to each member which would be cleaner

>   
>   attribute-sets:
>     -
> @@ -140,6 +152,30 @@ attribute-sets:
>           doc: >-
>                Bitmask of access modes (read/write) supported by the
>                telemetry field.
> +  -
> +    name: retired-page-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this retired pages operation.
> +      -
> +        name: address
> +        type: uint
> +        doc: Device address of the retired page.
> +      -
> +        name: size
> +        type: uint
> +        doc: Size of the retired page in bytes.
> +      -
> +        name: status
> +        type: u32
> +        doc: Retirement status of the page.
> +        enum: retired-page-status
> +      -
> +        name: max-pages
> +        type: uint
> +        doc: Maximum number of pages that can be retired on this node.

Nit: 'on this node' can be removed since it only defines attributes here.

>   
>   operations:
>     list:
> @@ -287,6 +323,37 @@ operations:
>               - field
>               - field-name
>               - mode
> +    -
> +      name: get-retired-pages
> +      doc: >-
> +           Retrieve the pages retired on a retired-pages node, one entry per
> +           page. The dump is flagged as interrupted if the list changes while
> +           it is being read.
> +      attribute-set: retired-page-attrs
> +      flags: [admin-perm]

Do we need admin permission for this?

> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes:
> +            - address
> +            - size
> +            - status
> +    -
> +      name: get-retired-pages-info
> +      doc: >-
> +           Retrieve the retired page limits of a retired-pages node.

Nit: %s/limits/info. Would allow other drivers to add additional 
attributes if required.

> +      attribute-set: retired-page-attrs
> +      flags: [admin-perm]

Same.

> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes:
> +            - node-id

Why do we need node-id for this response?

> +            - max-pages
>   
>   mcast-groups:
>     list:
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 82fcc766b84b..26505a7e4f0f 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -69,6 +69,14 @@
>    *     Each field contains the uAPI defined enum string, its numerical value,
>    *     and its mode bitmask, which encodes read/write capabilities.
>    *
> + * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
> + *     Userspace must provide Node ID.
> + *     Returns one entry per page with its address, size and status.
> + *
> + * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
> + *     Userspace must provide Node ID.
> + *     Returns the maximum number of pages that can be retired.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -121,6 +129,13 @@
>    *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
>    *       to enforce permissions checks on telemetry operations.
>    *
> + * - RETIRED_PAGES:
> + *     + The driver must implement the query_retired_page() callback, returning
> + *       the retired page with the lowest address at or above a cursor, and
> + *       -ENOENT when there is none.
> + *     + The driver can implement query_retired_pages_info() to report the
> + *       maximum number of pages that can be retired.
> + *
>    * Netlink handlers:
>    *
>    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> @@ -147,6 +162,10 @@
>    * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
>    *   dumpit operation, enumerating all telemetry fields and their supported
>    *   access modes for a telemetry node.
> + * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
> + *   operation, listing the retired pages of a specific node.
> + * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
> + *   doit operation, fetching the retired page limits of a specific node.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -162,6 +181,8 @@ struct drm_ras_ctx {
>   	unsigned long restart;
>   	/* Node targeted by a telemetry get/set doit */
>   	struct drm_ras_node *node;
> +	/* Which retired page address to restart the dump from */
> +	u64 cursor;
>   };
>   
>   static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> @@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
>   /**
>    * drm_ras_node_get() - Look up a RAS node by ID and take a reference
>    * @node_id: ID of the node to look up
> + * @type: Expected type of the node
>    *
>    * Looks the node up in the global xarray and, if found, takes a reference to
>    * it so that it cannot be freed while the caller is using it. The lookup and
> @@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
>    *
>    * The caller must drop the returned reference with drm_ras_node_put().
>    *
> - * Return: the referenced node, or NULL if no node with @node_id is registered.
> + * Return: the referenced node, or NULL if no node of @type with @node_id is
> + * registered.
>    */
> -static struct drm_ras_node *drm_ras_node_get(u32 node_id)
> +static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)

Can you please split this into its own patch. Making the node-get type aware
makes changes to existing code paths and is not specific to retired pages.
We can have this part of the same series but as a different patch.

>   {
>   	struct drm_ras_node *node;
>   
>   	xa_lock(&drm_ras_xa);
>   	node = xa_load(&drm_ras_xa, node_id);
> -	if (node)
> +	if (node && node->type == type)
>   		refcount_inc(&node->ref);
> +	else
> +		node = NULL;
>   	xa_unlock(&drm_ras_xa);
>   
>   	return node;
> @@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   	u32 value;
>   	int ret;
>   
> -	node = drm_ras_node_get(node_id);
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>   	if (!node)
>   		return -ENOENT;
>   
> @@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>   	u32 threshold;
>   	int ret;
>   
> -	node = drm_ras_node_get(node_id);
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>   	if (!node)
>   		return -ENOENT;
>   
> @@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   
>   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>   
> -	node = drm_ras_node_get(node_id);
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>   	if (!node)
>   		return -ENOENT;
>   
> @@ -699,20 +724,24 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>   
> -	node = drm_ras_node_get(node_id);
> -	if (!node || !node->clear_error_counter) {
> -		drm_ras_node_put(node);
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> +	if (!node)
>   		return -ENOENT;
> +
> +	if (!node->clear_error_counter) {
> +		ret = -ENOENT;
> +		goto put_node;
>   	}
>   
>   	if (error_id < node->error_counter_range.first ||
>   	    error_id > node->error_counter_range.last) {
> -		drm_ras_node_put(node);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto put_node;
>   	}
>   
>   	ret = node->clear_error_counter(node, error_id);
>   
> +put_node:
>   	drm_ras_node_put(node);
>   
>   	return ret;
> @@ -770,7 +799,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>   	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
>   
> -	node = drm_ras_node_get(node_id);
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>   	if (!node)
>   		return -ENOENT;
>   
> @@ -781,6 +810,166 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>   	return ret;
>   }
>   
> +static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
> +{
> +	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
> +	struct drm_ras_node *node;
> +
> +	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
> +	if (!node)
> +		NL_SET_BAD_ATTR(info->extack, attr);
> +
> +	return node;
> +}
> +
> +static int msg_put_retired_page(struct sk_buff *msg,
> +				const struct drm_ras_retired_page *page)
> +{
> +	int ret;
> +
> +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
> +}
> +
> +/**
> + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Appends one message per retired page, in increasing address order. The
> + * dump resumes from the next address after a buffer overflow, and is flagged
> + * with %NLM_F_DUMP_INTR if the list changed between messages.
> + *
> + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
> + *         (requires multi-part continuation), or a negative error code on
> + *         failure.
> + */
> +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> +					struct netlink_callback *cb)

Since the function changes. Have reviewed the github.
In v6, can you please make changes to this patch instead of a third 
patch since the entire
implementation changes. Its tough to review the third patch only from 
github.

> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> +	struct drm_ras_retired_page page;
> +	struct drm_ras_node *node;
> +	void *hdr;
> +	int ret;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node = get_retired_pages_node(info);
> +	if (!node)
> +		return -ENOENT;
> +
> +	for (;;) {
> +		ret = node->query_retired_page(node, ctx->cursor, &page);
> +		if (ret && ret != -ENOENT)
> +			break;
> +
> +		/* Never zero, so the first message is checked as well */
> +		cb->seq = page.generation + 1;
> +		if (ret == -ENOENT) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		hdr = genlmsg_iput(skb, info);
> +		if (!hdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = msg_put_retired_page(skb, &page);
> +		if (ret) {
> +			genlmsg_cancel(skb, hdr);
> +			break;
> +		}
> +
> +		genl_dump_check_consistent(cb, hdr);
> +
> +		genlmsg_end(skb, hdr);
> +		ctx->cursor = page.address + 1;
> +	}
> +
> +	drm_ras_node_put(node);
> +
> +	return ret;
> +}
> +
> +/**
> + * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> +					   struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	u64 max_pages;
> +	void *hdr;

Rest of the file uses nlattr

> +	int ret;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node = get_retired_pages_node(info);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_retired_pages_info) {
> +		ret = -EOPNOTSUPP;
> +		goto put_node;
> +	}
> +
> +	ret = node->query_retired_pages_info(node, &max_pages);
> +	if (ret)
> +		goto put_node;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg) {
> +		ret = -ENOMEM;
> +		goto put_node;
> +	}
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		ret = -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	drm_ras_node_put(node);
> +
> +	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +put_node:
> +	drm_ras_node_put(node);
> +	return ret;
> +}
> +
>   /**
>    * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
>    * @ops: Generic netlink operations
> @@ -808,10 +997,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
>   		return -EINVAL;
>   
>   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> -	node = drm_ras_node_get(node_id);
> -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> +	if (!node) {
>   		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> -		drm_ras_node_put(node);
>   		return -ENOENT;
>   	}
>   
> @@ -892,10 +1080,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
>   
>   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>   
> -	node = drm_ras_node_get(node_id);
> -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> +	if (!node) {
>   		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> -		drm_ras_node_put(node);
>   		return -ENOENT;
>   	}
>   
> @@ -1100,7 +1287,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
>   	if (!node->device_name || !node->node_name)
>   		return -EINVAL;
>   
> -	/* Currently, only Error Counter and Telemetry endpoints are supported */
>   	switch (node->type) {
>   	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
>   		/* Mandatory entries for Error Counter Node */
> @@ -1112,6 +1298,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
>   		if (!node->telemetry_get || !node->telemetry_fields)
>   			return -EINVAL;
>   		break;
> +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
> +		if (!node->query_retired_page)
> +			return -EINVAL;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index 589c6445eff7..c56220205876 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
>   	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
> +static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
> +static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
>   		.flags		= GENL_CMD_CAP_DUMP,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
> +		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
> +		.policy		= drm_ras_get_retired_pages_nl_policy,
> +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> +		.doit		= drm_ras_nl_get_retired_pages_info_doit,
> +		.policy		= drm_ras_get_retired_pages_info_nl_policy,
> +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 7a1cba70fd50..880b0c2befe3 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
>   int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
>   int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
>   					    struct netlink_callback *cb);
> +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> +					struct netlink_callback *cb);
> +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> +					   struct genl_info *info);
>   
>   enum {
>   	DRM_RAS_NLGRP_ERROR_REPORT,
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 76bdcc6f96a5..5c3900a53278 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
>   	u32 mode;
>   };
>   
> +/**
> + * struct drm_ras_retired_page - A retired page reported by a driver
> + */
> +struct drm_ras_retired_page {
> +	/** @address: Device address of the page. */
> +	u64 address;
> +	/** @size: Size of the page in bytes. */
> +	u64 size;
> +	/** @status: Retirement status (enum drm_ras_retired_page_status). */
> +	enum drm_ras_retired_page_status status;
> +	/**
> +	 * @generation: Generation of the retired page list, changed by the
> +	 * driver whenever a page is added, removed or changes status.
> +	 */
> +	u32 generation;
> +};
> +
>   /**
>    * struct drm_ras_node - A DRM RAS Node
>    */
> @@ -184,6 +201,38 @@ struct drm_ras_node {
>   	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
>   			     s64 *status);
>   
> +	/* Retired-Pages Related Callbacks */
> +
> +	/**
> +	 * @query_retired_page:
> +	 *
> +	 * This callback is used by drm-ras to list the retired pages of a node.
> +	 * It must fill @page with the retired page that has the lowest address
> +	 * greater than or equal to @cursor. @page->generation must be set even
> +	 * when no page is found.
> +	 *
> +	 * The @query_retired_page is a mandatory callback for
> +	 * retired_pages_node.
> +	 *
> +	 * Returns: 0 on success,
> +	 *          -ENOENT when no page is at or above @cursor, which ends the
> +	 *                  list.
> +	 *          Other negative values on errors that should terminate the
> +	 *          netlink query.
> +	 */
> +	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
> +				  struct drm_ras_retired_page *page);
> +
> +	/**
> +	 * @query_retired_pages_info:
> +	 *
> +	 * This callback is used by drm-ras to query the maximum number of pages

query the info.  The parameter also should be a generic struct instead 
of max pages if
any other driver wants to add extra parameters.

Thanks
Riana


> +	 * that can be retired on a node.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
> +
>   	/** @priv: Driver private data */
>   	void *priv;
>   
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 56e0588af5d5..e7f2da18cc4c 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -12,12 +12,14 @@
>   
>   /*
>    * Type of the node. The error-counter nodes expose reliability counters for a
> - * hardware/software component, and telemetry nodes expose an interface for
> - * reading and writing telemetry values to a device.
> + * hardware/software component, telemetry nodes expose an interface for reading
> + * and writing telemetry values to a device, and retired-pages nodes list the
> + * memory pages that have been taken out of service.
>    */
>   enum drm_ras_node_type {
>   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
>   	DRM_RAS_NODE_TYPE_TELEMETRY,
> +	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
>   };
>   
>   /*
> @@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
>   	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
>   };
>   
> +/*
> + * Status of a retired page. retired means the page is reserved and out of
> + * service; pending means the retirement is queued but the reservation is not
> + * complete yet; failed means the reservation failed and the page may still be
> + * in use.
> + */
> +enum drm_ras_retired_page_status {
> +	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
> +	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
> +	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
> +};
> +
>   enum {
>   	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
>   	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
> @@ -73,6 +87,17 @@ enum {
>   	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
>   };
>   
> +enum {
> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
> +
> +	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
> +};
> +
>   enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> @@ -83,6 +108,8 @@ enum {
>   	DRM_RAS_CMD_TELEMETRY_GET,
>   	DRM_RAS_CMD_TELEMETRY_SET,
>   	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
> +	DRM_RAS_CMD_GET_RETIRED_PAGES,
> +	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
