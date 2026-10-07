Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5686CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE33810E4B3;
	Wed,  7 Oct 2026 07:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zbynacva";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B52610E4B3;
 Wed,  7 Oct 2026 07:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791356626; x=1822892626;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c1ZyE2Q4+CCDTJOkkc8vHfi+UIbbCxgJVenzU7jHOqo=;
 b=ZbynacvanqAR7EYwk7nRJlqDWU1aqu2KVxHT7KovDqWPXtu5wyIrobYI
 LSsA0tThDzcZ5q4NjSLtcx3zxHpQ4G6VpSPBDAFiJ9qb8g8HvUpjGJQj/
 fHUUuDbxGDAbVdUiahem/OzYF6pz7h8nAD+3T+St4i7tKPAFve/AMxrow
 SX1C/HdBv/J/bznNUj1P25c/0lUhLhtwFQ1pmWvdank61SfGWz+x56oSk
 PlCGBfDTswWx9zwd8HLJY96axPOzlXtfUKHJlMDqAnNL7IOPP30hGs0Q8
 IXQ5oxJNXCzo04CYxl+ldOsJmRQyvOYKO2z3hpUyu2ipsskb6QzkZ74Ow A==;
X-CSE-ConnectionGUID: Kh5aoI22RQa8br42T472+g==
X-CSE-MsgGUID: vfTNCugdQZqaLmY+1hyX7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="114878"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="114878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 00:03:45 -0700
X-CSE-ConnectionGUID: +l0f4qI2R5ykTQGZUjzB0w==
X-CSE-MsgGUID: 5wTnBmtIThOxGBTTdzxsvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="305350627"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 00:03:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 00:03:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 00:03:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 00:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jggnYpQ/x3nKr8Bh2WsoajebQ2ft+3NyFIGmc1edlhWImXv2vwXnzfN4lWw20aRrqJylqD9dOKfm3InZ8vRXwKoOZvyrFBoKIysmX8BRO4PhB5aIR7MEU+DQAA4KlK78v7CaYzUkOJHV57f2oz4KCvX1XHksAK4UPKlgGbQq+3rUQd1VXu1/wIyBVACMJd+0IbpNgnSuCjM3w8GJE15h903rPRy5EB0G8VWSNPFIHYv6bl5/3PCridgFT2wTiFETvszBTJjQIRRnklOFDK2fiCvLHCca/oiALG9uuRHITi2MZKXQ7egsBVoVwWV/zAN0BErnP4IiWUojuLkaLok38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoUktHBSxHNZaI9OaQPHVAKkj9g23D4fjdF2+yJ8WPw=;
 b=Jhd3lmpuB2MF8hZ/qbyjlAS225Vp2B8QnOrnpuc/UjIAgVSDppSlcrz4KKJRTjC9PfimeNhusF2nJXRE/hI4sllD9cuvSakSlHrB/SXrmAKqgMUqkHbk/NzIbAXBYoiZZy9qh3JhOk8QOF7t0oAimbSTS4iw91/ATiYqlop4EWi/mYw0wDvN0Ern+R6fTQ8W3xiKbqPmJos7aQidVhVFEM2W6nCuG34ClhbURqb+Ba/lnk9IpCSgD5pHnUJ/nj4zJY68yvMW/8omVgVJYG39tKk4cJHt4UGe8xztfcMPgNJwLAi1x4iOk/X1mJr6kLcH1yZ0DOgkVSGYYmkCmMaqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:03:41 +0000
Received: from IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7]) by IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:03:40 +0000
Message-ID: <aa2fdbd7-4f8b-4313-aafc-22f9c6beb392@intel.com>
Date: Wed, 7 Oct 2026 12:33:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
To: Xaver Hugl <xaver.hugl@kde.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, <harry.wentland@amd.com>,
 <uma.shankar@intel.com>, <louis.chauvet@bootlin.com>,
 <naveen1.kumar@intel.com>, <ramya.krishna.yella@intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, Suraj Kandpal <suraj.kandpal@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
 <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
 <CAFZQkGzSkUZTodjUudhLsYtset=EqviZeqrfv6gj6XmG+ZJOPQ@mail.gmail.com>
 <636a3dc2-fe17-463e-806a-056818656692@suse.de>
 <CAFZQkGxYm_zBe69ecsOwhL7ftXVSPkTz5EUR_iXsAgLBVPd9NA@mail.gmail.com>
Content-Language: en-US
From: "Murthy, Arun R" <arun.r.murthy@intel.com>
In-Reply-To: <CAFZQkGxYm_zBe69ecsOwhL7ftXVSPkTz5EUR_iXsAgLBVPd9NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::12) To IA0PR11MB7307.namprd11.prod.outlook.com
 (2603:10b6:208:437::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7307:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 625796c0-25d3-48bb-f16e-08df24411de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 5qwHi/v9RqWkE/5z47xrLj9ZZPMMog8WnMRHZX1tuThKYIe1MhbLlfuN04wSckoEqlpeCdUbjHKNlIYE+gaiSNyILos2RgNjqVcKUs0kLUWw/eGX3DHKhhx75IL74O7iG/YzTvwl7W1fCR6CaNuLHYgA1EXB09Wm2U9WU7mut6Dk1CUukm4lTyi503yMr9qXOXEf9qAfM5P9qTjX90syEBJgA94PqCTkTxyf0QdUdJb3TGXTcHaLStv5vjuOY0BU155jtBGm8/vyzVdayMNI868XgbK6dC6lPRqgprfD67ePs8ZZEnZ7bIkddHWXcbwh3yMegEepx4rMJq9GRGEJSLdlecx7uGTnhxno4Gnu6x6svtqHk+qMz5Vu8zKBP9q1DUMiSdzKZu6SINY/Cy1QSkpoESMHzgqfqh2gWJ29UaC757jDX+Fh0U25hp8sG+428kD7FVhVGZWco1vQkTlApukhCazysh6hpCwpT5qmR0gfZOpfmZaBat8EndCt7tvJi5jxvx7ZIJBHVBXwhcSrT1EV9cAj5nErHF2a2+obqfiDeqkjmV2RKNAZuJXSwFYbxJc4zcfYP3iFpWI9/mcP9zHbGu9cX22yl3/5h8LJ91/KZLrHnAktlUw4zrzFfeWWjoOEyl+GR82ErOqfuQs42nK8tHSf03KDmOgU7wak+w8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7307.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdHVmQzYkUxWnFwcFA1WXBLTFV6TlBBOE5haWVpSkhPNWMrRDRrZExsR0ow?=
 =?utf-8?B?WTIzcDVtK1VjNDhvUmE4cFhzSjZXNmhTMmJqQ3dhSzg1RHJ0Z0NZb1VrV2pF?=
 =?utf-8?B?K1NDZjdMUmRTOUZrRDZwbUhvQ1gyOUJEeHMwemFIa2JIdUVKcE16WXJWemti?=
 =?utf-8?B?WG5wcG5lT0dBdVRtMCs5TzlqREhzTngydjZDaVo0UzZHNEJEYjBHdlpuYzJk?=
 =?utf-8?B?ZzNRc29xUmJOUDZpWjNtZ2Q5eEtYcE9DQzZFU2psNWdlTG9VeWRuVVE4dnRT?=
 =?utf-8?B?WG1BY2l6SEhjSjQxS0MycEVHa0NmTm9saTNXOExDRWtnb21BMk50ZWVBMlQ4?=
 =?utf-8?B?TWx1Z3M5aHU2K1JRUExqcWxtMFBXZnZ3MkZDWjhJdzJLRUhLaUwvZGdmVjV4?=
 =?utf-8?B?eHNzcFI3bGlzNk1qcXZlTGVGM1I0dXRCQkhmQ1JrRmNoRVRXcERjMk5XM3Ir?=
 =?utf-8?B?b3N4cWhYL1VoTGg1SFZTZkJJSVp3bktEbmFZWktaUWtJNnc5Sy8xd3FkcGJz?=
 =?utf-8?B?V3N2V1BXQVhhakJoZzZFcnp4VnI4a2lkWWtYcXFCNFdCUytZc0VrQmsvM3VC?=
 =?utf-8?B?Mzd1UFJPbXJkV3VNWFZiYWx3b2ppYnI5NkN3QThsd2d3UHZwYUl1UytQVnBs?=
 =?utf-8?B?NU5PT3VlWFB6MWUzMmozTHBrNWRPMUJ5Qkp3WDFVZ1A0WGtmWEZRSlMvRThM?=
 =?utf-8?B?aWZ4eFpENWxFT2Q4YWFOVFZGdHpGa3c2dHZPVUpRd29ORHA1c0RkU3NLVnIx?=
 =?utf-8?B?cUtxdDFiQ1RhZktuV2xyR2FWaVBhSW5CRnJhMk0rcmxTVTJ4b2Q2YnJjbmNp?=
 =?utf-8?B?azUyT1pIM3BrZlluT3FyTkR4dVZVVFdhTmcyWldtQklqQVZCa08vT3Z0Zjht?=
 =?utf-8?B?elA0Qy9seGVISHFSZWg3MVVoVXBRZFJ1UEdaUEUreExKNStEU1AxRWJQNEd6?=
 =?utf-8?B?ZVc5Z0lKL2g4S2Zobm85Rk8yb291TWtjY2NDOGNRejczR3EwdjZhSjkvS3Bp?=
 =?utf-8?B?eVFCSzMvT0s3RjRXNlZ0c3pQOW9wb01MZVk4MmMzcG1qaERvSWtzVnJpU0l4?=
 =?utf-8?B?Z3NocFhqdmZHbmU2bC9qZjNaT3hzMXJzN1djZnVFSUdnb095ZENxWE1YdmlO?=
 =?utf-8?B?QUkvcm5WbzYwSlpkMytoUWJ2MHlyYUdITXdFQUJMamlzcExkdWdHK2JmRXNm?=
 =?utf-8?B?QUM5dGo1dFk4bk1UN25DV3dVNDVVa05KOHR6NW0wWFl5cUovakUrMWh2eUwv?=
 =?utf-8?B?Zytab3g2N3RFQjZmYlV2MzdFMFdRN3FLdFBXa0RUUUg2cVNpYlZjRjE4ck9G?=
 =?utf-8?B?bVhQbWl0Y05BdTkwNEdWa09SSzFsRWE1QkpLSkQ0RFBCZzAvYUVCV0hpTjdL?=
 =?utf-8?B?Zzk4Y01td1lRMjNMeDVhdG5LdjVHMVhnVkxEcDg1cS9jV1pRQlkrMGI5d3h0?=
 =?utf-8?B?OW9CaEt0RlZPOFhRS1MvYjhlRk8wdC9wN1hmbXRSWjA5aTNCWWFqdHB6dm05?=
 =?utf-8?B?d0dZbFdsL0xLZURFTy91MmV2MGIrdi9Lc2pjNlhUZml1b1BXNElaZVFCT1lt?=
 =?utf-8?B?MGtWeG9KNkNVWXJsYlpGK1JPaGF1elJRZmMycE4zNFZFZlNnNHBXZlphdmJu?=
 =?utf-8?B?cCtYdkF4VkZlR3ZGU0ZXNEhLVWJwOG5xdFQzTzJnai9WM0dKVWZqV1JIa1px?=
 =?utf-8?B?aFlaZDlMTmRBNWJNMk5RZmU2VDhHV0ZlbHhhS3hDd3ZXYkNtb0xWbTFNcE5D?=
 =?utf-8?B?a2VrRUVsdTJ3N0c0cUVjTjFXd3ZqQlBTTHdtT3NZelZJL0I5S3FFN2dtT04w?=
 =?utf-8?B?ZjF6WGpwQ3AvdUJNNzFrd3lBeDFoaG5DTkw2bktmN2pnNnRaUmN5Vk1HZ0M0?=
 =?utf-8?B?NUFSenp5dU81WXBQU0NrU0VNRFZ5eHhOejdyNjZCd1V3OVZWc0NGWFNibTBp?=
 =?utf-8?B?b2RIeHl6dzdZRXhhcEIrbUgrV3dhcUgxN1h4TEtRR3BKQW1CT3RPaUcxMUg5?=
 =?utf-8?B?YmhBZ0J5TGl1enJMejlaTVVHNjIxVDM3VnVNVVp0ZDJsQXNSc1djTlRGT1ln?=
 =?utf-8?B?ai8vSnZGa1pHU2FpWDV6TFI1OW44V1NGV2YxZkVwZXVzOXFkTHdndlVNUEpI?=
 =?utf-8?B?V2RIcFB0UGNwdkFJc1B0U2hqdVczQXBjV1l4QUJrN0xXTUhLOFFvV0RWM3Nq?=
 =?utf-8?B?bFEwMDNGMHFrendlay93QWd5TC82RFlZWUZFQ21xb3lLc0FPbXB6T0Z6dXlW?=
 =?utf-8?B?T0dqWEtnQkkrMjJ6aVVNNC9RbUU4dlo0Mk82R3hKemMyNG5yU2RyUktMM2E3?=
 =?utf-8?B?dkRnNDRxWnpSdENZVEJvVDdGZ2p4bDgrVmpDWTY1WVVHL0EwMlZIdz09?=
X-Exchange-RoutingPolicyChecked: JjzJYxL5kAlsrem8xG4rhKIne6Dx+ATBqGPapykuw68koyFQuJYejYNoWrP90VsR3IJvX00O7z3O6OcGsuqUepNFZnTk1KJw/Kc5m0fl7Qr3ngLFYG7ISaG/GCq50sUtKUR09Bcxin/wpSBItiUQz9bN70Bn77zXNlGGbCk64XBZXoEIvBWZibvzEMAxx5yRAHnomPryiAvQzZqh4oKGoNS+zTVW8rpy7JZCcoDUucymIM3ExMSUgmuz+zo+BIRX0dXGf98u9H6qchnWPgkJfb7VNACm9+3Fy1rK7MJf56K5fMifTre/5sxFUlwCxeNDeUcy/IogldRd7s75sxNV5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 625796c0-25d3-48bb-f16e-08df24411de6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:03:40.7237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4Y2+61LqnyejdRhO5QGDlezFRZRDSxSmw4KRHyeG73+e89LqnUOOgKYBTBjfRB0k/fZvFn+wKqE3mEUaBWDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
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

On 05-10-2026 19:30, Xaver Hugl wrote:
>> That's not a policy decision. User space is free to do what ever it
>> wants.  What I have in mind is a hint from the kernel what to do next.
> There's a lot of different ways a commit could be fixed, and telling
> the compositor things like "turn off this plane" wouldn't give the
> compositor any actionable choices except giving up or exactly
> following the hint.
>
> If you meant much higher level things like
> - reduce scanout bandwidth
> - reduce connector bandwidth on this connector
> - do a modeset
>
> that's exactly what the proposed API does.
>
> I don't think there's a middle ground between the two, KMS is too
> complex for that.
>
>>>>> + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
>>>>> + *                                  enabled, invalid falg, page_flip event
>>>>> + *                                  with test-only, etc)
>>>> I've seen this being used in the i915 patch for a async flip.  Could
>>>> mean anything there (format, driver specifics).
>>> Its purpose is to catch anything that the compositor is supposed to
>>> know it can't do - using unsupported formats, invalid combinations of
>>> properties (crtc active=1 without a connector), that sort of thing. It
>>> should never be anything driver specific though.
>> I don't see how this could be useful except for the prototype that come
>> with this series.  It's so broad in meaning that it's almost meaningless.
> It's useful because it tells the compositor that the failure is caused
> by an implementation error in the compositor, instead of some driver
> or hardware limitation. It doesn't need to be meaningful outside of
> that, a developer later debugging what went wrong can use the error
> string to figure it out.
>
>> And error codes don't have to be driver specific to be meaningful. I
>> already brought up DRM's mode-status code as example. They are not
>> specific to any mode, display or hardware. Yet they clearly state what
>> went wrong with the mode.
> I think that only works because the mode isn't specific to any display
> or hardware. Atomic commit failures are often specific to some
> combination of driver, GPU and display.
>
>> You could to this with detailed and precise error codes plus the object
>> on which it failed.
> They can never be detailed enough to exactly pinpoint specific edge
> cases, unless you give literally every single return path in every
> driver an individual error code. I don't think that is feasible (and
> then that error code would be uAPI).
>
Yes at cases of error where driver feels that a change in the 
drm_mode_object/property can overcome the failure will be reported.
>> Filename + line is even worse.  None of this is even close to stable.
>> I'll nak this as much as possible.
> That's the point? It's supposed to be not stable, so it doesn't become uAPI.
Even I feel that expose kernel file name and line number is unnecessary 
for the user log. We anyway have this in dmesg and will be debugged upon.
>> I also don't buy the argument about diving through kernel sources. Not
>> doing that should be the goal here because it is what we currently do.
> I don't think that's something you can ever fully get around. Just the
> very hardware specific error cases alone make it impossible.

To differentiate the hardware specific error we have SPEC_VIOLATION 
error code for which compositor may not be able to take corrective 
measurement. Compositor upon getting this should look for alternative 
such as software/gpu composition.  Logging this will have debugging in 
the kernel.

Thanks and Regards,
Arun R Murthy
--------------------

> - Xaver
