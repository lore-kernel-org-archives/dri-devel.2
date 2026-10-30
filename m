Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002F606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mtDTucYE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB8D112706;
	Fri, 30 Oct 2026 10:27:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6082810E594;
 Fri, 30 Oct 2026 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793356048; x=1824892048;
 h=content-transfer-encoding:date:message-id:to:cc:subject:
 from:references:in-reply-to:mime-version;
 bh=xKDv1hdyulrc/McoXXCkjZbjVQEn/U91wqhE/uuwdgo=;
 b=mtDTucYEFvAnBzn/Sg9zL8UC554KtnK0huJ7JZpyzwvFYdvOyJWesZXz
 /KRcfaWAOaMThZzhKqqmXcQXGYn23kuVzFP/LXACXCbAUGU9UDuvzqkmZ
 VF3kOFKcdqlJ7flTa/qBy1hxu9ipNXfY09j+X1JxuRs+YiMbk0Rc7pO79
 zO7H5ruptv2IdtGaw6K06//DwkYVik6JMDuXl4vYMA92LTxDQAz5TrLKx
 V1UaUnluhgnUto9xxHqdBa/WIfLwYO1B++o+SLmu6JiF373+qEz+v59f+
 WdqkelnWJBMQZeuBwgioqVlrpZ+lOK0/PQkBuPtLizldpl1DmtDm76w8j Q==;
X-CSE-ConnectionGUID: JxiJKvYpTmKufYFd2GNmBQ==
X-CSE-MsgGUID: IdBY3sAfRWOifjc2gYkj6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2147970"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2147970"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 03:27:28 -0700
X-CSE-ConnectionGUID: uySgdF4aSXugToZNgovHYg==
X-CSE-MsgGUID: 3ke//nC7Tqas2rZR+kqnMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7221196"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 03:27:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 03:27:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 03:27:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 03:27:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvuqD7G5rBmwzFV8nJjtO7HIXLW2PJCoyObbpexxesMBZKlBIxhhBooi+zPAwq9/2XE+YQJg/1GHcFOAWzLqy72H53Qto36HJ2FB7zrJmj0YajOaF2Gc7ow5s0CZ9PfEIWcWJtKmUXnCLfojUx0bP7vFs8Y96Ke0vtM2H/AZNr1XnpwJOEFbp+PCUlAQDLtMvFPInSdYBdi2MUpEUzljZZzg4MhuxzE1ZeIQyBJhKx2gXvk349Vm1AAltk1WK+oa6HRd6NYJXMdVEZeo3U8Q9ZdbXfhBEl6D1fy8/fpvhkbw8TpEt2w/ZgX5pK5eym15dzHuZYz7h3LA+qOT7FD0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfS6wYejZmJh6V9+1uD4tqvFeQa/lgRw5AIuVY1HQwk=;
 b=U/fe6uIfq0pXxy95kiUCF/6y3LPRg1LlzlGmRwRdeY7MH+AOaJTZNnDMP2jvcrNP0EvAouqMJ7dk62ZycBqb7tWTXy/NhdGvo1OnKO6HVD4NdyqKED5kGpexXw7CcGeLLQUmN+pbBLLi4hJb2yhbDGohrAWg/yUcrSM7SqIpXuRuj1GnQDYttdLXF3OL91n/EGVu0DaQ50A19S0itkEsFP/VsGif/hAKZmCgctSD4gyBiUw7nAhPxZZFG1nGN8rWQJJ6JSR9EKdotfcdH5KQC/DqSCdDk93qRF4kKdsO7rH9xdHY0XfWpxxUAMtu1WP81UcLag4Sss8nLVuAT7CaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 10:27:19 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 10:27:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2026 11:27:33 +0100
Message-ID: <DMI3NXGAIUXR.2X9SS2F3OTOGY@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH] drm/i915/gt: Use VCS instead of VECS for GuC error
 capture on Gen 12
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
X-Mailer: aerc 0.22.0
References: <20261030083948.131717-1-krzysztof.karas@intel.com>
In-Reply-To: <20261030083948.131717-1-krzysztof.karas@intel.com>
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|PH7PR11MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b96f11-a33e-4662-d2da-08df3670600e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|5023799004|261009223027099003|56012099006|261026121527099003|261026140227099003|10067099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|22082099003|18002099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 6bVrdcTSEWr/tqcjyHLceZRW2AHIwYpMOtdcR4XmLT3bdGTGuHRBsee5uuFAvRzunAr4poEMOMgL5gSCb4C7eop9gGb73h4bGK3GOyWaJWchTPDel3h2bnQGu+fUrJjbh6rM2ULms2s9G5UQWsnRGETaiML8aqvpDBZIgLe7XtGFGRhO4VuQlHhcAUqOyw+iOnoBg+xIHRyOUyaNqaBR5KIT3wc98iie9YLV6vFaQzG89sFs/6uOmt2VOakjWEtECyHlkHbNjfkhmzS/yy9qJOXoEda7M3Imz/GGGRpi4O5oBi2nzE3APp1oka4z68DGIyKrEP3rseElVBE7pH02NTvqsp+kmbu4oPSMCaqJeDwXRTSiyqWbuHzce9YRcGjDVYhnDkRU5WOjH1jnrWj/1vqceC7J0XJPtQBUM45s+xO7gpBRw3GgV5dBnKRsz2DWe+KFzSipJoyL67DBRYIPn1Y+YJKOOxRltt21KCdCeiQATjuX4UYM7xUTzvY1WMne2x9Qjbmrcrng5GhJYLJAzY3uBL0mE6TdTVgFU4q6x4+qp4qg5WA/5pRsoMcAnec4wFqasv6i/iqaaP5beEIk/n+hhBcBryMAgYvuo+wLYzN8ryUTDalug1KvmhbRd+2C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(5023799004)(261009223027099003)(56012099006)(261026121527099003)(261026140227099003)(10067099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(22082099003)(18002099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hHMGVuQkhVQW15UkQvanAvOGlmYU8zL0FYVGhzdkhUVjRKTlZscktWRkoz?=
 =?utf-8?B?WEFHa1FYMHhhNnYxdE9GMnpKM3JDMjhIWjhUVTY1azNiSno0amZFWEMzMzh0?=
 =?utf-8?B?dHVUakk2eFo1UnR1K0hzRDRFM2xhbmpTUFpXaFdUOEZUVFd1V01YNzAzUUxY?=
 =?utf-8?B?NDkxQkwveGZsUUU4TmwzR1J6YjBmVFdXUndMZzBkclpMczF5WnNpbXM5Z2RC?=
 =?utf-8?B?d2NSYk9venVld2NPSis5eGV2N3pqU3gxL01RYnhsajlrZk96bzQrdTFFUkx3?=
 =?utf-8?B?N1V5NTFrVlZVaTNUbnhSRE0ydWZWMytSWjVrZU5rWlRFKzFZZ202NHNzWWc0?=
 =?utf-8?B?RWo0NTRabS9tWUtZNkpvQndud3hXTWhqeGpyUm9CVEV4UEhsYUhkdG51Yjda?=
 =?utf-8?B?SlZvSnFGcmVrWVp5UXJibjJ2bnFZeGs1TEhoMjJSYnI3M1lWZ1VLSUt6MmR0?=
 =?utf-8?B?bXhRd1VucGlVMGJmdGNJK1VhTmZ6QlVZNzZPWklFemhIYzkvNCszVmdQaVI3?=
 =?utf-8?B?cGd3MENXZ2ZVSkpoYkxiOHhwdTlrYlEraWEzaVA0SDJVb2pzK244OXJ0azFK?=
 =?utf-8?B?UVBvdEVOK012VmIxWFdKUTc5citXSE1seEM0R1NCeFJnblk1bHlqTm5teTJm?=
 =?utf-8?B?TEl0bUozTXVFaTA5UDFMd1NsTThPa1Z4V2lCd3VaV0g1My81Y0RtRGRCRDdo?=
 =?utf-8?B?MURUSnIzUHQrRTJQUzRucElQRnRJRDdwWS8rVGd4NTA4cVJLNkNZaElFMzJ4?=
 =?utf-8?B?WWJYRkZuejltR2oxY3ZlaWVDSnJuYmNoVktqTWNBSFdCaWhoQUVxalZPUzd2?=
 =?utf-8?B?RGNlRWxpMnRYTnJyUXcyTlZ6RHBuMVJKM3hMRjExb3ZYWC9BWDM1cDQzajdF?=
 =?utf-8?B?dEpKN2NJeVk5bkVYUGdidWVUQXFveGVScDdxY3ZjZ1dZTFhjZ0w5Q201YU9O?=
 =?utf-8?B?b096ZHllNFUrYzZPNU9Mc3Q0bjlISWQ1aDJEVWk2cU01Rmp2cm9BNFRaV1RS?=
 =?utf-8?B?WDkyUlR6OFlTTmI4MG5jU2s1ckhxeXJkVjljSTNUOWE2L2RqZmJxVGk2Ym5m?=
 =?utf-8?B?QlA1djVKZGRWU1BtV1hIMXlsemFXRkw5Y2VUdlJ2SGt6R1RNZXhobWp4aEFE?=
 =?utf-8?B?TEU1ZzRmTCtIQ0s1K2xLZzJKTjNITVZ0WmhKeVo4bVdjV2t3b1QzMWtwNDNH?=
 =?utf-8?B?eTNuKzNQdm5ZbUhvMFd5RGpaaDNMcks2elRjUzZ5dEtXUzZrYjFYL1dNU1g4?=
 =?utf-8?B?UU1RL1VSQ1huTDJEV01QNU5RNlJBR01kd0Z6aHM2eXZVLzJyaWppSjRSVFJQ?=
 =?utf-8?B?c0VKVE1va1N2MDk2ZGNPdFpVVXgwZ2NwVDdBWWRTdlZZbHFxTnkyVHorb0pR?=
 =?utf-8?B?VjZLV3ZtUjlNWjRHbXFPS0tHdlo1dlY2QXJQcjQ5UExVWExJMTV3Mi9xditx?=
 =?utf-8?B?QjVRYmhvSldFZTU5cTRCaFlqQ2dJeUdTTTVWUlJUTm1Ta0dOb3NtQlZYaUZX?=
 =?utf-8?B?dFMvQWh6bkFvU3ZDMXVsQ094NkcyVEZweERqaDFsbm52Rk02Y2Q0K0FmWVJT?=
 =?utf-8?B?MnFnbmE4bHlBcU5RZkdFUm93Y1RTY05kZlk3U1FiOVlmajZXL2hOOVArM09N?=
 =?utf-8?B?aENXOU9ORGxCekw2RFpjR2d4Z0tiZ2NEODNhYlFCWi8wdTNLQk5PdENnRk9Z?=
 =?utf-8?B?VmJ3dmVpcnlqK2diYzJ0YkhsUTNZaUZNQzVhTm5NTE83T0k4UVVsSmhnY0N1?=
 =?utf-8?B?cVRPcmtoWlhHNmFMOGtZaDgxcEp6c3FENVlTdWZTODl5NjN0U2VoZjhjUG5H?=
 =?utf-8?B?cXp3ZExMY2ZTaDNlSVdCeWdkQmRHejlXYXQ4OURBeVlLdjc5MGtsVEVabzhJ?=
 =?utf-8?B?bXUyeWNzaUZJTUNtemd1djdFdmZ0TW1JUjJrL1orM0tqTUFPTXIzU2dQY0Z0?=
 =?utf-8?B?dFFZK0RWTTVyWTBZMENCcDYzeHlEdDg1WFVvMCthVmRqdGxvRjYya2MrRjFt?=
 =?utf-8?B?a0twanA0Y0VhMVJiNGplT1FYRTRKZFhmRXBjRUdZb0F1WUk1L2l4ZWtnYlhZ?=
 =?utf-8?B?UkljZFBkSUhZeGhEdzFpSy9QT0tkUElVSHhQd0Qva3BVRmhudlBRTE9scWtS?=
 =?utf-8?B?Zm44UitCN2hQaE5FOWgraWxhZndIbm9DZ0MvcmdzQjdtRXRtWDJqQzNFY3k4?=
 =?utf-8?B?Zm5xWG5tSVkyWXlpMXVaZXNkS3cwUkdpdnNrc00wL3NmWm8rdTByRnJhZG9B?=
 =?utf-8?B?TmxMcDZ5NXFwaXJabVRvYktvSklpekZIUnp0WHlMMzEzK3E2eEpieGp4d0Na?=
 =?utf-8?B?dzJUY3JzRDdXUEhCVmFTeWdIWnBSSEUwcW8vNEJIUmV2eHRJS0Q0S1p1QXYx?=
 =?utf-8?Q?fmc7P634r77bf7jM=3D?=
X-Exchange-RoutingPolicyChecked: uSirOZVQBfCGpMgKwbVJBnpatNfaaUaAZMtUhS8+r5M5NCZMT9hcVxPoyiB10kNEkYdh9yAUkDPevG5XJ2SOgw4fWAPKCebiSKDkr3qgsmUT+sL4s033mjr7312/0pxxdskkuNnmOpsIbNpLRUfWi2EvctWsPxVQNiVgkiPisJBRJ2kk65nYAJp4xKZxMP35t9yR7rOEohyv32APkPX36KO6o7Me0HryaxvWY9Lts95wp1r0Ldtg7H/uV9LD8I8lPOaRGtK7gCz0OfW6MZMwLVjZpeMVLrpwh3nU0D0RCMtOHRh5QNeKA9W7LY+hRcUVVUhiu8FhBJ8SeE5E6TSKTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b96f11-a33e-4662-d2da-08df3670600e
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:27:18.6566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fyt8Ud/QLDojQu08J9his7r4jxApEc+UYdZ22s0nWIbvnIKhsik/4fr2z8tvj2/wMfuEfT3pzPFcLqcuZuBD6SEMakpYSNrVf/MLC89qqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On Fri Oct 30, 2026 at 9:39 AM CET, Krzysztof Karas wrote:
> Initial, empty XE_LPD register list for Video-Enhance class was
> introduced in [1] until [2] filled it out with debug SFC_DONE
> entries, but it was never explained in any of those commits why
> using those registers for VECS class specifically was chosen.
> Furthermore, in current testing it leads to failures [3], as
> gem_exec_capture@capture@vecs0-smem runs report partial captures
> on DG1, DG2 and MTL [4].
>
> SFC_DONE resides in the VD forcewake domain and is available
> only when the corresponding VCS engine is present (explanation
> from [5]), but XE_LP capture table currently associates these
> registers with VIDEOENHANCE. Move them to the VIDEO class so GuC
> requests them for the class tied to VCS availability.
>
> [1] commit 24492514ccbd
>     ("drm/i915/guc: Update GuC ADS size for error capture lists")
> [2] commit 8b72c21618de
>     ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
> [3] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16904
> [4] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=3Digt@=
gem_exec_capture@capture@vecs0-smem
> [5] commit 24d032e2359e
>     ("drm/i915: Only access SFC_DONE when media domain is not fused off")
>
> Fixes: 8b72c21618de ("drm/i915/guc: Add XE_LP static registers for GuC er=
ror capture.")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> I could not verify when exactly the issue started happening,
> because:
> A) all recent reports are red on DG1, DG2 and MTL,
> B) checking for "partial-capture" in IGT [6] was introduced way
>    later than the driver code asking for SFC_DONE registers.
> I assume it has been present for at least a few months, if not
> from the very beginning.
>
> From empirical experiments, I was able to identify the classes
> that report "partial-capture" during the test: VIDEOENHANCE and
> BLITTER, while RENDER_COMPUTE, VIDEO and GSC_OTHER report
> "full-capture" for SFC_DONE registers. I simply changed the
> class of xe_lp_vec_class_regs inside
> "static const struct __guc_mmio_reg_descr_group xe_lp_lists[]"
> and ran the complete "capture" subtest mentioned above, so this
> change should not (fingers crossed) explode anything.
>
> [6] commit 93d3b0e28d7d
>     ("tests/intel/gem_exec_capture: Check for partial register captures")
> ---
>  drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu=
/drm/i915/gt/uc/intel_guc_capture.c
> index 865b61057566d..bbf5188ae46cd 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> @@ -187,9 +187,9 @@ static const struct __guc_mmio_reg_descr_group xe_lp_=
lists[] =3D {
>  	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
>  	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CL=
ASS_RENDER_COMPUTE),
>  	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_RENDER_COMPUTE),
> -	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEO),
> +	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_C=
LASS_VIDEO),
Now the naming is inconsistent: xe_lp_vec_class_regs is CLASS_VIDEO,
not CLASS_VIDEOENHANCE as its name suggests.

--=20
Best regards,
Sebastian

