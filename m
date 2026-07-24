Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47BC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22E910F2AD;
	Fri, 24 Jul 2026 04:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YWv+tNqY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7912E10F2AD;
 Fri, 24 Jul 2026 04:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784866708; x=1816402708;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1LtI6cwOwwaYMGy0dm/iotjFnhi1Aaz+b2aYD9Rz4MQ=;
 b=YWv+tNqYSe2w1LQH+SmgiZ2HpRZ483l0TZ8r+7Thw+Bqw6f8wD9Eot0H
 KYBjOj4xzL0JuHO//1Lc0wliCOUwUSw9LRn/lTziQ/cyRTIXE6GlpXCLB
 3D5N9jhY2Kt7fQ5pTTBGof05clVSq75ztuwf4J8qJrBiR3gM3Ds21W/2q
 Tf5E3q1+V6QLliv+fDQ1yg9eQYj1uherBIZbUulxDb0X9qRoAa8gw1Agp
 aUXi8gM7Zs1aNHhJ4p+tbYU2PpWEDAmiVci2YrzHUb2mipMiNyXwqo0Zu
 NEbRfQ7O7D5pz1R2ZPhUcsvrvqe0UNE1D3EhAdzE/dCEgbBHlHtO/pY1w g==;
X-CSE-ConnectionGUID: Ifp0/jCKS++arjZCFHiPYw==
X-CSE-MsgGUID: 3VGMl8TbQs2fnwYKDxCylA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84509365"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="84509365"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 21:18:27 -0700
X-CSE-ConnectionGUID: KPj4NgPwSsKof9eCTEz0aQ==
X-CSE-MsgGUID: 5aNxbmpSQICD0ZfCdsNlpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="262915616"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 21:18:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 21:18:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 21:18:26 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 21:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXuBTGtcX+u76qvCNNqHCwGZKrxJdljDfIxVGMp02SrFJNTzOCVtS9rAKgQD6NhoyZthmRSiSktXmFTguawBzusfvnQzeyGaZdGeHsRatsp4iokXVRISvthnonglK4myab+gSViwTsWmdqX2F+wog1C7QquDBdlWit+rW3uEq/moMQTbCqCFZzcezPTcMb5wplzlAPATMfEmRvTJt4fwAj6PQh77Knvsmb5WUs68HHM2DVBYhEC1BXMQXCvSdIlStdzqafQGGdiTfTB1AA7chS/CHNlX7rM7tnoy8u7F6rtEIn6ZX+dbpBmOltXFh5AEdf1qMyCIcuDDzwvDP+W4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaju38gkwO1b3Z7Cu6xCoAHUb6cnUwzJ+iO0kZahRAs=;
 b=GDzaYTMGVGM1g3croSkj/2YcEqBj9fzkphg21UoS+2AkcOpx1s6usuNpBCvK63LEzY7hvHS9Qa44w/B5/OA0ouiAKvgiPoT5MwJoRDT+GcQ+UxqQbhLdWqaY7QNVQnQqQneDtGYjVFsHzt1Hzk2W6/kDNBJZgBUBmeTfCQwTqaO0tc3lJxMITjWcHxLANhZrQtxyzbk7PNqSqyHqHZW/Mj9GklV/H9cSv9kOzBzNjWOvUmBfaJdvQtkbMh7CrRQLN+bP2AxQHwdQgglZQZn0TsCafh+r79HFGaL/g49VZ0Rhee97XAFmmU5LbLljSslTOo+x1Jt/W3IkpAtZfJgS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Fri, 24 Jul 2026 04:18:16 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 04:18:16 +0000
Message-ID: <0b60e943-6890-4cb4-a64e-147890d75b9b@intel.com>
Date: Fri, 24 Jul 2026 09:48:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] drm/drm_ras: Add drm_ras netlink error event
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <raag.jadav@intel.com>
CC: <aravind.iddamsetty@linux.intel.com>, <anshuman.gupta@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
 <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, <kuba@kernel.org>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-5-riana.tauro@intel.com>
 <a5eb582c-f063-4730-8015-da59079a258e@intel.com> <amJCnyvuxcMtXxYL@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <amJCnyvuxcMtXxYL@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0343.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::17) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 98edfc02-94ca-47e0-4460-08dee93a95a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: rEuh1NOYS1uIEIJkfb7YGbah4nLHw8+tDpES7LJDGtMOCQP9mOU/WuSfBauTItHNBST0RtuPohorJ6OmdjNToEi/a1OfSywfFaWMb1XvVRj1Pe6CdsPtbidl9sNHZwjCh21xMbok4J3RUR8464cC9C4BpDb4VkOZyNplLMAGBQqEmbUoVWj6JQCKz4+FH47VJAoHgpBc2xXJkhkxlxlUS/PyoyPSOkZA7o3zXNnzVPJNeNOG9wZVDV+9YGoS/AVAOarqum0esoGjfmeLW6rvS83MvHvEGEgxyRrweol8qVIgkkNwkOj6gvdUi4PtwcUpY0HHlks4xuYvTOx068iD1r0G4Yrmb+eGJnoyGfOmpo6nloADYwsihkFjfjHPCkHtvlUNNG0NTZBHPYxEiml9AjsVyks5r1qAQRvsY9z2IKeN8JYTqDSzhkrD+vf3Er7nV52upG/WDtRiAPrYBwkqmz3A5wYJ7Lyw0cjz+4I5evZzrB0T9i4cTMQeEYMqQ6pqrapdjAS2YSRH5c0lPStyARiu7Fxl2y2X5oEqT4BldZZPvu9swWnfG4wJBLQ4aydcyU/mMBzm3Zllcr9OkVgwYJ5uEy+h84RnXvmTX+daKfYzULESCdiAdlxRE85wVSDdH31mqX7gVFXppBkxjxpSVqJg6qWWOpZH3B4AR1yR3xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alRadW81SU53ekxQTmpBNmFERWVmTVVVMy9laE9aN2NIVVNkSk1UL3R5ME55?=
 =?utf-8?B?Uy9ZNFhPY2FyYjNRdmZnU0ZuQlNRSW5ZelovZEg5cHJ3N1ltaHJXcytmRFNN?=
 =?utf-8?B?UlNiWThzNVppQzhXUXd6K3k5bHE1ZGxlY0UvZnBwVnd3aUZIUW5LdXpyZjZN?=
 =?utf-8?B?WFg5Y0dnbFFJQzMvYUNUdmNIUGtiaFI1d2xIaWZTaHhOekorcFFtWG91ZitZ?=
 =?utf-8?B?ekVPdFBKR0FnL2lpOUNZRURWZ3BlZCtYajVKKzFqSS9sZEYxamRqd2Fxc3Fp?=
 =?utf-8?B?M1M0SVZEVTFvKzVaZHpFNmllUURvK3dXZDd2dlRRcEtvaDM0UFAxeFM2NTRt?=
 =?utf-8?B?a3RLK05DSjh4cThJUTVUUXVSN2dFMVhsR1NrMUtoTXFWZVIxOVJzZ1YvdmVU?=
 =?utf-8?B?MkFkcXJHRCtuNkFwLzhtanVxRm9mVTh2Tmx4Sk1PTkY4aStRaSsrY1dNMVlT?=
 =?utf-8?B?akVna2NKNHprYklZcjB3OG9hM2tIcVN3bldXRmkzem9uY1BuVkU5cVN4K1BT?=
 =?utf-8?B?U3RPMitEQlAyYUx6eEFXM1pJMU91TjJtVEVSV2xFcnFpbmFFdVJwQzdlcGw5?=
 =?utf-8?B?V2M1dXZtTFNDMENidmx6NmdEcTBodlZ3YW5HamZkYStJS2p0MUxyaVdZaDRa?=
 =?utf-8?B?QjJoQkY5WFIzc2hoNThnQXl1UFU5ZGlSR3I4ZHlqSmV6dm5OYk9EZmJuRDBq?=
 =?utf-8?B?KzJWbTNyblV2cjRic0xucWt5dE9mZWNTdTErU1BHOVhGU2dDZnZSQUVBWHBw?=
 =?utf-8?B?Zkt5VXo3bW01QXJWeW9uYnN2WUlMUzRJM2czRHhsNStkU2V6MGp1REFPR1VW?=
 =?utf-8?B?SG43L2Vqcy8wd1VCNWkzeEtoQjlsVm5DUXNoL3MwbHkxNEZrcThBamNRazM5?=
 =?utf-8?B?dmI0bk5tdm45NkFEMklaNG5LclUraEhSd3cySXVzT01mcVVVcWxnUFczQWV1?=
 =?utf-8?B?Rm1rMWpyeHJtUmh6V3VKdDNZd20yTWtiRG43aGkraXM4Q3dpUlMzbERUL1Vk?=
 =?utf-8?B?U2ZXNEQyNFFBSy9TelZVL3kwdW91Znh6RURGeUNVb3lCSzdXd0doVmVhaWU4?=
 =?utf-8?B?YmoxTEVQdzNraml0Zk95VGUrZCs5Znhxbm95YXpZcVMyVTBPRUxOWVRxZEx3?=
 =?utf-8?B?QVlaMW1qQ2hDaEVjTzgxNFoxUVljclRFWDNRNGpDdW14Ymd3WkNXQzBReEVO?=
 =?utf-8?B?SnJZVlBqbmpaMDg1a29wRGFBVCtadXpUSG10REdOK1BieS9oWER2c05ua04y?=
 =?utf-8?B?OFRLcDBiNm5OSzF1QlpNWkl1SWhvK1ZHalFJSjFRKzA0eGhvMHd5MnU0dmZk?=
 =?utf-8?B?SkVZd25vLy8wbjJGZFYvRWpTdUJqQ1A5M1FnQzJYMTMyckFlSUtTdkZVWHRJ?=
 =?utf-8?B?Uy9rTWloNitidkwybHhGUkZVaXR3ZUcvc05IRm14NStFd2djLzJ3Q250eWtw?=
 =?utf-8?B?Q2FmTVdpNUxTTWtyZnVjM1cvL3ZiblM2SHJONnlQazNTdXNROUlJa2RJemdC?=
 =?utf-8?B?TnFwb0ZPVEVMT1JSREZDaWRyQzY3cDFvOGxiTFlYdmdBRjJjcCtwaUhObjZI?=
 =?utf-8?B?bHBFTk9vY0VkbEs1RVZUbTNURC8wbWptQUU4R3FrVDhsVWNGYkQ0VW8zZWZK?=
 =?utf-8?B?UTJGYVQxR3drYmszNFVRbFZzT3RkZDFCcHk4a1VrbUNjZVlNcGlla2loc2dv?=
 =?utf-8?B?RXV6NUxCZGN6WkJwbCtRc3ZuLzFXMW5GSHU1N3Q0MkpQcmV2Z1FwbWhhMWFN?=
 =?utf-8?B?Z3ZPd2N0MWhPcEwwWFVLcG9XRjFTdi9tT0gwakY2cGtBVFo1Y0pHVTkvbWlC?=
 =?utf-8?B?ZU90MURKcWNqNnhXbXh0RW5LT3BWNUViclNYN25kR216ekJrM08wdmcraUM1?=
 =?utf-8?B?aGx6alZHZW5FMUsxbEFaZFdaTW9oZUVSOERVK3BGRlV6Nm9aVDJQSWI1cjlJ?=
 =?utf-8?B?R0pNNUs0b2w2K040Q3R3V3B1aGgxeFBUSEZqTHJxMU1LbHdzYndlckFQOENM?=
 =?utf-8?B?eXRaK0JSUUFTVmkrR2NEd2doNmM5RnBxUlZGT3NSRVU0M0RWVDlicjgwRkxz?=
 =?utf-8?B?T2dTaFZnVEk2MXpvZ0ZXWXR5aG9zdlFWdC96aHNtbFAxY3J6SEtmZ0NQZWxa?=
 =?utf-8?B?YWZDb3Jra2tRNjhsOTEvNzFvK0FuSi9UeG85MGo3Vk1oUzdrWDl1SjYxbE5I?=
 =?utf-8?B?ZDJaQ3NJejRma1ZPdEdITXh0UWZnZnJ4QzNINjJ0N3gzUTJGaW5qaDMwL2Ey?=
 =?utf-8?B?RGxYUjJUalBUZzgzVllmTW9xZHA4TG5qUVFwVGdwSWxMVWNXeUJ2MkVGSzlQ?=
 =?utf-8?B?dDJKbU50dzZTQzNQVmVnUFhEakhyRDZDQ1lsODBQZWFwKzFXTWZJdz09?=
X-Exchange-RoutingPolicyChecked: jCv+V+GX/g/9Shy3qFpCeKvb6H2ZpcT1SWzp3Wse9x4sxdT1whfNJtFbDQul2LOnUR6FUZrk9zt9O0W9S2nf+yQohHpJAZ6Hi6Di55+Yfi86dZPEJeoe39s6UdqpYdO1iP3zAGINVsCXpcOQJKGdHiHY7zLaSLHjK8i3kXN8snL7fv9/2/F1Cwyc8DnuvwE0YacdxTDgiieLzlXesnIko1Y5WUHl0gPvvAsCvj6zr9WCHLtLLD0svml6JXnI706sKwODkJqYokOly5Y7K3seooSCIrD1rUKYuDqLncEPOJ0AfsmkD8Mq2MxxiDQ52YwwY/gm3JEQwdL2YEWQauIjNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98edfc02-94ca-47e0-4460-08dee93a95a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:18:16.5582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn/IY6vcbXVs8w4UIKHvMFFifmeRtNkxOAXmvuCNPhG4KZ+xmIOKUuIcXjkuirGvCZYRPcy8X6ndPbKgZtX3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
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


On 23-07-2026 22:04, Rodrigo Vivi wrote:
> On Thu, Jul 23, 2026 at 08:06:22PM +0530, Tauro, Riana wrote:
>> @Rodrigo The sashiko comments are resolved and has been tested with multiple
>> namespaces using docker.
>> Sashiko review is now clear with a pre-existing issue that is being fixed in
>> another patch
>> [PATCH v5 1/5] drm/ras: Cancel and free message on get counter failure -
>> Raag Jadav
>>
>> <https://lore.kernel.org/intel-xe/20260722034228.662746-2-raag.jadav@intel.com/>Let
>> me know if this looks good
> Yeap, this is okay. On this one I just had the feeling that Raag had changed
> his mind and asked further changes after the put the rv-b.
>
> Perhaps we should resend a clean history and then we use that to ask
> for the appropriate acks

Raag's comments were on the xe patch (mostly nits) not the drm-ras event 
patch.
Sure will clean up the revision history and resend it

Thanks
Riana

>> Thanks
>> Riana
>>
>> On 22-07-2026 15:11, Riana Tauro wrote:
>>> Define a new netlink event 'error-event' and a new multicast group
>>> 'error-report' in drm_ras. Each event contains device name, node and
>>> error information to identify the error triggering the event.
>>>
>>> Add drm_ras_nl_error_event() to trigger an event from the driver.
>>> Userspace must subscribe to 'error-report' to receive 'error-event'
>>> notifications.
>>>
>>> Usage:
>>>
>>> $ sudo ynl --family drm_ras --subscribe error-report
>>>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>>> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>>> ---
>>> v2: remove redundant initialization
>>>       remove unnecessary space
>>>       use ynl in commit message and doc (Raag)
>>>       simplify doc for error-event attrs
>>>
>>> v3: rename error-notify to error-report
>>>       Replace notify with report across the file (Raag)
>>>
>>> v4: send event to all network namespaces (Sashiko)
>>>       remove has_listeners check
>>>
>>> v5: add context in function for choosing GFP_KERNEL (Sashiko)
>>>       add additional checks for node registration, range checks (Raag)
>>> ---
>>>    Documentation/gpu/drm-ras.rst            |  21 +++++
>>>    Documentation/netlink/specs/drm_ras.yaml |  48 +++++++++++
>>>    drivers/gpu/drm/drm_ras.c                | 101 +++++++++++++++++++++++
>>>    drivers/gpu/drm/drm_ras_nl.c             |   6 ++
>>>    drivers/gpu/drm/drm_ras_nl.h             |   4 +
>>>    include/drm/drm_ras.h                    |   5 ++
>>>    include/uapi/drm/drm_ras.h               |  15 ++++
>>>    7 files changed, 200 insertions(+)
>>>
>>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
>>> index 83c21853b74b..406e4c49bac1 100644
>>> --- a/Documentation/gpu/drm-ras.rst
>>> +++ b/Documentation/gpu/drm-ras.rst
>>> @@ -56,6 +56,7 @@ User space tools can:
>>>      ``node-id`` and ``error-id`` as parameters.
>>>    * Clear specific error counters with the ``clear-error-counter`` command, using both
>>>      ``node-id`` and ``error-id`` as parameters.
>>> +* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
>>>    YAML-based Interface
>>>    --------------------
>>> @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
>>>        sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>>>        None
>>> +
>>> +Example: Subscribe to ``error-report`` multicast group
>>> +
>>> +.. code-block:: bash
>>> +
>>> +    sudo ynl --family drm_ras --output-json --subscribe error-report
>>> +
>>> +.. code-block:: json
>>> +
>>> +    {
>>> +        "name": "error-event",
>>> +        "msg": {
>>> +            "device-name": "0000:03:00.0",
>>> +            "node-id": 1,
>>> +            "node-name": "uncorrectable-errors",
>>> +            "error-id": 1,
>>> +            "error-name": "error_name1",
>>> +            "error-value": 1
>>> +        }
>>> +    }
>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>>> index e113056f8c01..8aed3d4515e5 100644
>>> --- a/Documentation/netlink/specs/drm_ras.yaml
>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>> @@ -69,6 +69,33 @@ attribute-sets:
>>>            name: error-value
>>>            type: u32
>>>            doc: Current value of the requested error counter.
>>> +  -
>>> +    name: error-event-attrs
>>> +    attributes:
>>> +      -
>>> +        name: device-name
>>> +        type: string
>>> +        doc: Device (PCI BDF, UUID) that reported the error.
>>> +      -
>>> +        name: node-id
>>> +        type: u32
>>> +        doc: ID of the node that reported the error.
>>> +      -
>>> +        name: node-name
>>> +        type: string
>>> +        doc: Name of the node that reported the error.
>>> +      -
>>> +        name: error-id
>>> +        type: u32
>>> +        doc: ID of the error counter.
>>> +      -
>>> +        name: error-name
>>> +        type: string
>>> +        doc: Name of the error.
>>> +      -
>>> +        name: error-value
>>> +        type: u32
>>> +        doc: Current value of the error counter.
>>>    operations:
>>>      list:
>>> @@ -124,3 +151,24 @@ operations:
>>>          do:
>>>            request:
>>>              attributes: *id-attrs
>>> +    -
>>> +      name: error-event
>>> +      doc: >-
>>> +           Report an error event to userspace.
>>> +           The event includes the device, node and error information
>>> +           of the error that triggered the event.
>>> +      attribute-set: error-event-attrs
>>> +      mcgrp: error-report
>>> +      event:
>>> +        attributes:
>>> +          - device-name
>>> +          - node-id
>>> +          - node-name
>>> +          - error-id
>>> +          - error-name
>>> +          - error-value
>>> +
>>> +mcast-groups:
>>> +  list:
>>> +    -
>>> +      name: error-report
>>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>>> index d6eab29a1394..39155fb514de 100644
>>> --- a/drivers/gpu/drm/drm_ras.c
>>> +++ b/drivers/gpu/drm/drm_ras.c
>>> @@ -41,6 +41,11 @@
>>>     *    Userspace must provide Node ID, Error ID.
>>>     *    Clears specific error counter of a node if supported.
>>>     *
>>> + * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
>>> + *
>>> + * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
>>> + *    and error information that triggered the event.
>>> + *
>>>     * Node registration:
>>>     *
>>>     * - drm_ras_node_register(): Registers a new node and assigns
>>> @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>>>    			   value);
>>>    }
>>> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
>>> +				     u32 error_id, const char *error_name, u32 value)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
>>> +}
>>> +
>>>    static int doit_reply_value(struct genl_info *info, u32 node_id,
>>>    			    u32 error_id)
>>>    {
>>> @@ -222,6 +255,74 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>>>    	return genlmsg_reply(msg, info);
>>>    }
>>> +/**
>>> + * drm_ras_nl_error_event() - Report an error event
>>> + * @node: Node structure
>>> + * @error_id: ID of the error
>>> + * @error_name: Name of the error
>>> + * @value: Value of the error counter
>>> + *
>>> + * Report an error-event to userspace using the error-report multicast group.
>>> + *
>>> + * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
>>> + *          netns, which is unbounded work; callers in interrupt handlers
>>> + *          or other atomic context must defer event.
>>> + *
>>> + * Return: 0 on success, or negative errno on failure.
>>> + */
>>> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
>>> +			   u32 value)
>>> +{
>>> +	struct genl_info info;
>>> +	struct sk_buff *msg;
>>> +	struct nlattr *hdr;
>>> +	int ret;
>>> +
>>> +	if (!node || !error_name)
>>> +		return -EINVAL;
>>> +
>>> +	/* Check the node is currently registered */
>>> +	if (xa_load(&drm_ras_xa, node->id) != node)
>>> +		return -ENOENT;
>>> +
>>> +	/* Currently only Error Counter events are supported */
>>> +	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	/* Check the error ID is within the valid range */
>>> +	if (error_id < node->error_counter_range.first ||
>>> +	    error_id > node->error_counter_range.last)
>>> +		return -EINVAL;
>>> +
>>> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
>>> +
>>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>> +	if (!msg)
>>> +		return -ENOMEM;
>>> +
>>> +	hdr = genlmsg_iput(msg, &info);
>>> +	if (!hdr) {
>>> +		ret = -EMSGSIZE;
>>> +		goto free_msg;
>>> +	}
>>> +
>>> +	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
>>> +	if (ret)
>>> +		goto cancel_msg;
>>> +
>>> +	genlmsg_end(msg, hdr);
>>> +	genlmsg_multicast_allns(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT);
>>> +
>>> +	return 0;
>>> +
>>> +cancel_msg:
>>> +	genlmsg_cancel(msg, hdr);
>>> +free_msg:
>>> +	nlmsg_free(msg);
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL(drm_ras_nl_error_event);
>>> +
>>>    /**
>>>     * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>>>     * @skb: Netlink message buffer
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>>> index dea1c1b2494e..9d3123cc9f9c 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.c
>>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>>> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>    	},
>>>    };
>>> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>>> +	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
>>> +};
>>> +
>>>    struct genl_family drm_ras_nl_family __ro_after_init = {
>>>    	.name		= DRM_RAS_FAMILY_NAME,
>>>    	.version	= DRM_RAS_FAMILY_VERSION,
>>> @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
>>>    	.module		= THIS_MODULE,
>>>    	.split_ops	= drm_ras_nl_ops,
>>>    	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
>>> +	.mcgrps		= drm_ras_nl_mcgrps,
>>> +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
>>>    };
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>>> index a398643572a5..03ec275aca92 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.h
>>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>>> @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>>    int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>>    					struct genl_info *info);
>>> +enum {
>>> +	DRM_RAS_NLGRP_ERROR_REPORT,
>>> +};
>>> +
>>>    extern struct genl_family drm_ras_nl_family;
>>>    #endif /* _LINUX_DRM_RAS_GEN_H */
>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>> index 0beede3ddc4e..ee2caa0edc6f 100644
>>> --- a/include/drm/drm_ras.h
>>> +++ b/include/drm/drm_ras.h
>>> @@ -80,9 +80,14 @@ struct drm_device;
>>>    #if IS_ENABLED(CONFIG_DRM_RAS)
>>>    int drm_ras_node_register(struct drm_ras_node *node);
>>>    void drm_ras_node_unregister(struct drm_ras_node *node);
>>> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
>>> +			   u32 value);
>>>    #else
>>>    static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
>>>    static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
>>> +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
>>> +					 const char *error_name, u32 value)
>>> +{ return 0; }
>>>    #endif
>>>    #endif
>>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>>> index 218a3ee86805..eab8231aa87c 100644
>>> --- a/include/uapi/drm/drm_ras.h
>>> +++ b/include/uapi/drm/drm_ras.h
>>> @@ -38,13 +38,28 @@ enum {
>>>    	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>>>    };
>>> +enum {
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
>>> +
>>> +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
>>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>>> +};
>>> +
>>>    enum {
>>>    	DRM_RAS_CMD_LIST_NODES = 1,
>>>    	DRM_RAS_CMD_GET_ERROR_COUNTER,
>>>    	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>> +	DRM_RAS_CMD_ERROR_EVENT,
>>>    	__DRM_RAS_CMD_MAX,
>>>    	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>>>    };
>>> +#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
>>> +
>>>    #endif /* _UAPI_LINUX_DRM_RAS_H */
