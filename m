Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TgS8kZjU;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Hw2tobHM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D893F10F4DA;
	Tue, 24 Nov 2026 11:51:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA7C10E86E;
 Tue, 24 Nov 2026 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795521050; x=1827057050;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=ExJb5yz3eNKE5K27JJjEzf/Cy/6jhuPvDsL1jsK288g=;
 b=TgS8kZjU3lbiebmrgEFtxLVFzolFN/GpqMlcJS6RJ8ZxHbiG9YZyUxbL
 NVIj7qlF+FnFv91lUY+vxZlQH+4ugAQfGC4aTsJXtZtdOYHg5oAEcxrVv
 vA4RsBlexMV0VI7c9i2UzV+TTsSDfQJYreLpxJL9vDyqPmsDjWQii2/lm
 79YIxlevyjFSQGaY0pYNglX+1B4sj/6yi5STc/bT2EIMO09uN+NYBonIz
 JmDCRNjFw7vM4xT6Q756sKa2FPmzvyKexPfC6xTA730Oef8G7jcDBr5vq
 cbrSll4zMYA85o0KLcr6mJW81kdQeQwQRjuwr7GsIQ1rKXFemJdW7RE6x w==;
X-CSE-ConnectionGUID: PrEvdB6ETgKmHzVtMExRUw==
X-CSE-MsgGUID: GkrXethQTSuZEHMgxSHwFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4372624"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4372624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:50:49 -0800
X-CSE-ConnectionGUID: 9nWHFyA9R8Sg5sue9V0wHg==
X-CSE-MsgGUID: QpEBiZP/R1Ss0MQ1/h5YOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11425967"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:50:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:50:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:50:48 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEito+4/PteS6wV0OHksrvwL49HsltfbN5w+z5YWUXEO5WAGovJr5+tc9SJw5lBwz7J8IJITAS/buMrcsrW4ogSoBhRtPy0LhTcyW6trI/H/msysjgllClfAGrWiKMW7hlwH5Y7UctTpR+no1x1tHkPExQ1ZzIsH1epIzieDVHQh9Yv2M1jTV0h7cYX0autlYR8pmWeDRVDkcb6zwLoaafDBUXr5r54zeEiAjc+DHp28sPSDiQs8nttdZ8VHxFMqZxw0cU7t7jRsnbZhxRZIWZvVnCI9EoudgH7atJ7FgHvzh96fgu5XKUVMmQvZ3f24fec9Gy0KMX2wyZkyLVgOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExJb5yz3eNKE5K27JJjEzf/Cy/6jhuPvDsL1jsK288g=;
 b=Ypt1A96sQZAjvD1tL8ICPylQxKPg43z8MTFXwHOnlIaIJaYIi2q0PPPYlFTpeiRqDFx81c1ojkjcKS3qvlZGitvyr/xdnFUrF54WugRB7bvaernIrqqOOakkIE3cJgQVb4aYMt6ad6YoO6fdojYkNvdpvybqWw/21bEkVgP7rNySyCejPppldoILFAQdQHm9v3HbHc2XNqopI53U1u8K9tX4CTVzvoDJG04BKobltHruk7uN1SMVJNCrteFQXntnhTql9OLqPdMlV0fTE61d3T3F0/k+BDyG4+2IXYlxkrHA83X9G92CRtH6r9EMpQqTqcky2hld80mjmOSeP4YzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExJb5yz3eNKE5K27JJjEzf/Cy/6jhuPvDsL1jsK288g=;
 b=Hw2tobHMjmsXjKPytVqtMqFfdLmigiw5QSTMB+0Gr4O/eUJpdshQ4VQwOtqxVaeaXeQuvtAxV6har5kerg41zktBoOCyLb0vXOUB40W3Wko/MCxPpLpyYvc7s8jNhR/qT0015hm+rNCbziMK14w0XKF8AqlIpKl4BZiCOCSz6X8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Tue, 24 Nov 2026 11:50:45 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:50:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:50:46 +0100
Message-Id: <DN3F39P6CKKK.5V16V1SLPG98@intel.com>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?utf-8?q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v8 1/6] drm/i915/shmem: Validate max_segment
From: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-2-krzysztof.karas@intel.com>
In-Reply-To: <20261109113758.1491891-2-krzysztof.karas@intel.com>
X-ClientProxiedBy: VIUP296CA0074.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::17) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c941ce-ad93-45af-a9ef-08df4a212c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|4143699003|56012099006|261021121427099003|261102123227099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bh5HdQmb+rIqNQAeh0ZwkIFxnZI9pEwJhmu1qV6HgVbVSYH17kJZ39jbF1PG1PAtJAh483PRycaE2GPaSGT0lhakOYx4x/wjDhKLWDiqPVHiOe23zWGLlL9l1fvJm7NEJUz7YBEmo7KJ4ze4+RthvClZkauE+LAWUA79y3cvvVC5tOxx5oIlWkxU0mx1NBscbFfdTsofL1Oo8SLjwsbIH91S33GEVIlQ1UDTfMsLmZW5HpgW06vB37R3i63Vbvj0WydfcibzIoKzGqRW9RxQrp+gYE82Tk9Y1kJaL7SfN+XDIW89kpYLFs80JDQEPvxaN5dS0WF9Xwlp8dp0biaMN+5O2zb5IXV0eVprs54ZnsuMVZeHhV6NFuFAxKbnZjBb/lcWiralF3XQ1xoHW6WvWOfFU+lven82Rd47Ra5PmVyGUZRErbB+YKm82lCYvb4tM+cxOA3evQPm49BnlQRhk7MVSFXjl1Nh6w63N2jEcHqlgl5QuWkWMnZe47R9a9wF3nrDVRazzN7WRdN/NTDibxnuSuVUrd1kFBhN0IM8PYa0dd1oGBSW0zM0ymdb1GMFvjeYCfD8JW02ODG1WGIic1hsyPWVImOWZh2XhEHGLkk84EqN4aqhvxkihKDw0U9R5GQOpXM+k68Y0ogSutjJnZW68lVY8QyZkeS/naGh15s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(261021121427099003)(261102123227099003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkxQV05XalZsdktxZ3NkeGh0cVovbUN0NThZTnpnNkRYQmp0R0VlbG1kbDhr?=
 =?utf-8?B?QUZHYVV3aWk5NnpIUHc4VSsvZkxrNzZTSkVZa29iMEVUbkJYM1dpYkhEd2xH?=
 =?utf-8?B?OXZ0M2pKaDg1aUZGV0JLRDVLYStwVTNvNEVTNmNYdHRvanVDc3NvM3J1Q05W?=
 =?utf-8?B?cTg0dU9hYjRvUCsva0tnQnRQRGJSZWZ2Z0hmbkJxdFRtRnpsaEIwTGN5Mi82?=
 =?utf-8?B?aGMrUWV2QmhTSEJaUk12WWhUTXZ0Z3Q2VUs2M0kxWm14SzU4SVhKV0dRWGR2?=
 =?utf-8?B?UzFEc1ZRZFlEUWRDZ0dqT2Ewd1BCNnVLMm5ndzkyNk1VZHZOYThYZ3BabzJ1?=
 =?utf-8?B?bzdYSUxuelRnYVZJTUhJeE4zTHJKbTNzaTZNby9lbTFwSGlVdDVNVDMxZnIw?=
 =?utf-8?B?ZTMwOFBRaEM3Tjh2SGt3REpJRmg4SHJTbHdtNEV2Z25KeCtvR05wRlluaEZm?=
 =?utf-8?B?cDZPQ1BQSjkzVktrNEpoVVRZMVhFbHNOVjdYa3FYRUJnZWhNN1MwNFcvakhh?=
 =?utf-8?B?UzdCUEhmNXJTcWVMaGI5ZzY5UFFSdFcwOXNRb0tlMVdBeWRFNDdPUTMzdXor?=
 =?utf-8?B?aUNlYTdYcXhIV3BtWk01TXNEN25IU3JYUFdTQy84czlsbmhmOGdpUDNVc21j?=
 =?utf-8?B?b29wWWU5Tnc2K29jSU1tSm5zSE5uYzkyaWJVUStqMzhlTlJtcnU3WkNCUGsr?=
 =?utf-8?B?YUprUFgzcDNSeDRPYTMrc3ZyLzIyaDVXNE9hN3FLQVhwZ081Rk1kOVlZNXdy?=
 =?utf-8?B?RTlsRXc3ZmhuWEN2RFdrek9odjdtcWJ5eGtTaUs3VGRmQXRzMW5kUHBpY2hH?=
 =?utf-8?B?dGVRaGtVUkhWcDhlZ01yQmhjVnhod21FUDh6a0ovbmJQcUVzUklUNFBKeXVm?=
 =?utf-8?B?cUp2dmF2R1hqdmtsbE44ZEZqb3pQNmpsYklCWWFOSVFUMTh3SFJOUWhYWGVw?=
 =?utf-8?B?SXdLWFVXcTRjSVIwekJkbHdkWlhKYTliSFJ1R3FpVVJldDFBN1BXMjdGK2Zn?=
 =?utf-8?B?MmFPbjlldkx3N0NXamdZVWFvNTd5QXdWZW41dVJFREFBdDZ1ZXYzNVAwQ0E2?=
 =?utf-8?B?ZDFSdkxhRGpMbDlmU01JNllDc3JzSWorM29qNXA0SlZISjJhTy90MHJVMk9P?=
 =?utf-8?B?c203eXo1TVNid0JwWndiWm51RzVhVmF0V3hDdjd4ZW5KdnV6SjBLL2xwakRt?=
 =?utf-8?B?ckVVeTFQOW9jblZNdzVKQXZpSjkxMjcxa09qUVFPQzdpNGhHNkYrNXAxdnBW?=
 =?utf-8?B?SnBkenFXUDVnelFxRDF0cCtHUmNNbmt3N2hPbmZxa2lFU2VIMXI5aExFUlJU?=
 =?utf-8?B?cUFYbWFZdlhnMXY1TmdMZ2Y4SkxSVGFjRVVMSFFlYUlDNlE4S3ZIcU1RL3RC?=
 =?utf-8?B?M1NLS2NOekk1S0xsTDE2OUZGSG1LY0hOTjFVZ1JURXdLd0hpR1JYY1REbU56?=
 =?utf-8?B?RmhhditJQ3FZaHRKMmpnUVhXcThURGFSRjlQZ3JYOCtqdElwTC9mVENISzZU?=
 =?utf-8?B?cGQ5YmdHT0I1Slp1dFl6UDBORy96K21qNUdPLzBMdlhlYi9mVERuYVZxaXpM?=
 =?utf-8?B?NE9ZR0hleWs3cU9oeHVzY2FKUTBoRnIwYXJFTVZ4L0JrcFdNWjZTTHhVazRn?=
 =?utf-8?B?ODdtU25jWVh4a1VEN0tCKzk3ZHJtcFBCL2ZnUjhIOHlCK1dDSThXZzdiajY4?=
 =?utf-8?B?Lys4VXc0bWVaRnFWMURicVRERW9ZUmtyYk41QWgyYUZZeTNPRmkwRVRvTExi?=
 =?utf-8?B?ZjhYbGhuNHMrOVc1U2xJNXE3cTlCRUw2bEVZZ1RiblVOT2xmb2Mybi83NjVz?=
 =?utf-8?B?STRlTk85djBVYUtqcFZNSUFweEorTEtrVWlINWhudHFCOVhYYmV3TU5QUWVW?=
 =?utf-8?B?YTk3Q2lkUmFSVnNWY2NOR3B2WWV4M0pCbnZYclk4UDIySjZuZ2FnTmMxL21P?=
 =?utf-8?B?YWN3U2U5dmU0ZHpJRDd5dmRIRTdjcEVZQ2dyY2JpMnpCdEYzcHg1YStoS0lG?=
 =?utf-8?B?c2k2VFVsalJFZXpDQkZHMEdJVXBtYWtvbmdYMG56enFSWWU5MDFJcGFGbTkv?=
 =?utf-8?B?eUZQZzg3WkVaMkRwejBKVm5pdGszb21WMkRrSi9MZTVxYnpMWC8vVUJ2UUxj?=
 =?utf-8?B?RHRneDBYYVFDREZsWmkyejU4VjBhYnlzanNRdWhTYzRtc0N1dE9GUG9XSUQ2?=
 =?utf-8?B?UENKNHZUeUcwZnlzQ1lCclc3RzlMU2xXMnVvLy94bjdiMzc5WU40QzV2SVQw?=
 =?utf-8?B?MU5Bdlh0SXpkRVUwRG5yMmU0dWJUWlNqbHpjODlsYTB6MTFOS2dRK0Q5MVVj?=
 =?utf-8?B?THFjMXF4YTI4TWlSRDY4ZDBHQTJCSFp5VjFtRktPelBDK3Rrem13Vmp1UEI3?=
 =?utf-8?Q?fOldvfA00srne7lM=3D?=
X-Exchange-RoutingPolicyChecked: hEl+3DqoOUBHcs0ScNJHzTpWE3s7g1nwefo3aoZ3jp0b0o0BCI5D1jypyqGM/rmLKmubHywZSo3B9BisAeBqy4cPxyp6rvRUFL4BbvMTmptTZCGTKyteJ0p84QegyMQ1PV2XUPcrH9tBx9s3KVFEa/9Q8HN9eQvoqbDFqLYI1ynYMcHwKw7B29ut8LjwlrcTjuE76V8sribXuuO1APaVa/lt+Gy8W6CDqbxx6pHtWpsQ1YChX7lJwCWppCniR0c78pxszteiEj7/i8CVQgCBxlOxBhtzJuo5VAQoQgzi0vJ9cILOU+XRW9w/EZmthO/R2dw7NPNOyBmmgJfadmGmug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c941ce-ad93-45af-a9ef-08df4a212c98
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:50:45.3428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eABL8wn50vOLxMqQviR5TLxx+fcxI9aJd+wQM/H3kOmmWDc4Bst994EyZqllimIvVXrkznpsVZoUA+4m1nCt1VCEk+N0x7jIy4lAJVvdG5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 12:37 PM CET, Krzysztof Karas wrote:
> There is nothing preventing user of shmem_sg_alloc_table() from
> passing max_segment smaller than PAGE_SIZE, which would result
> in nr_pages =3D max_segment / PAGE_SIZE =3D=3D 0 and cause a
> non-terminating loop.
>
> Suggested-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

