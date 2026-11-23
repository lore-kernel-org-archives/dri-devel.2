Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB6606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ik6zvLOH;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LsDoCdw7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE0110E44D;
	Mon, 23 Nov 2026 07:47:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650E410E1A1;
 Mon, 23 Nov 2026 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795420029; x=1826956029;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y/qsw+EEhc9sdcbYlzgtu3EkkEWwl6HMO5HASuyMMYo=;
 b=ik6zvLOHMjkZBhRGMaI/PzIADceFzfsyX2ESaDxISV5Ichbe+CcJ2L0n
 r272p789R3ps94Q9c6Wvv1eZagjzZ90vsxgnC1b62ccY23bzpLOfINOpi
 OocVcZg/W8CEbblM45VumBYH2OSei22z7DPiFpKQBmz9aegdxs4sjyI28
 ve2PuVcB9xbKdurLU81A9nYLYZsM1ZFosPuQA5/znAngNza3ZU9xGnqva
 LbUQV3ROXwZKPojAqXa9iYJR/tW9VPtaWevp7SHUX9SVFDZNxWtzF4iJm
 LNmwgGZKCSisaAGZSIozmfV1GEhUrayVmlaSh/ZhitvOv2goORNrRGH3+ g==;
X-CSE-ConnectionGUID: Q71PdVs4S8CTWMqjF8EWHw==
X-CSE-MsgGUID: YeSy0lheTROpQfzjiZFdPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4115223"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4115223"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:47:08 -0800
X-CSE-ConnectionGUID: +cZ/NtNVSgSyUHSN0ZmsNw==
X-CSE-MsgGUID: WPtF652zT76imd+S/A1Ybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11534651"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:47:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:47:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:47:07 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:47:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6TndOr23UifY2XHW0uxCOotSSEKXyplrlcVSvOfbJv6C2SlmW0/HF5dZ65vZOzRemT15PM7ioy1cwqXGKgfrlBTLNAP+1PgV7dDEzNfjQ806KuOzZEINs3hEkRQeTS+cdgx5d3Cytog3tJxxUNsQJZLC6bj4sm34ya2pvoPWtJliandj2rE1rcF/mq6uJnl+57YTHC9iXkYNL8+p9P2EFt9GjwkgV/H1Yd4bM44PjemB/gT1G/fARvjwhmoqZHZCwNjDJm8I2gMgkBXgXZgThe5Ag4lbNr4R35FsQuhwMzZ6sJdFtfBTJ0WntxztcY84t2MLmmyr5zZRljQX467Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI3gkDcWK7yQ5EYEUgzzPHkPZ9YGKIEvqmCwQdH/KW8=;
 b=YELv2z6d5OLepHiliMlV/RQdZuwpTUyoi5/h/3XLeWdhDyY7H5vajcN2GJbBm0fYO9pwZnt0ZqW56kHlZcJbAIO6qAcbWIONfMvwoREEv1ivJJ74lD4JA5azi0YUxnC80/GsG/F2WKyVyj0pv7Bk+Wc5+bqBvtP+X8WZcDvrFeIEZw+5HHJw39H8XM+Tqha2YRtoxBgk/Ml1pQMSElToziBxAvm3X87stO/OzmuVvTKh9LYJw4ozloDUKtNJeIojhOSgsMyyp7hveK0mhvYgAqgTB0+x0L3+0GoHURldFeUE+8tk3ojNDiZgKLSKAiKUJcyIVqAXVGXfvdr81JqKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3gkDcWK7yQ5EYEUgzzPHkPZ9YGKIEvqmCwQdH/KW8=;
 b=LsDoCdw738UmYalyqE6iIYE4FZaTki3K4kE2uQ4Ys+/TCtEurR34FNEQWUo3iXcnDUfgssuGqvz2UGbMwQmdrYCclBEb8gaS89lvelq04UCS7IUS4d0uV379fRJKYtRi2QTgXjxicR6CQTXBGaP3t7KkoLgLLsCkE7UycFKPQ98=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by DS7PR11MB7737.namprd11.prod.outlook.com
 (2603:10b6:8:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:47:04 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:47:04 +0000
Message-ID: <c8086d32-a9c4-4188-8d6c-5f05eddecc61@intel.com>
Date: Mon, 23 Nov 2026 13:16:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/atomic: Add the state->checked WARN to colorop
 state
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
References: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|DS7PR11MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c7eb62-dcf3-4b66-bab2-08df4935f74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261022105027099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: kZDvwtpgOw57I4yTeX5Z4wojCH+OkB53igV9HNqdkTvx29g9iixivKU/fbueD5MBGbdIi1j6yma4mzzE8yZXCXvhMHWLtSAN+zNAnLML6/TIHqABe6QliG3mnyz5WCdPExxwZ6BQ5B56S9hWMothL88ApSY47s6TRRsa2F410iA9b2SeZHRk9aWWmieitCbAAyN15Jsqv83DTvZYbKOSOzjcTDrzC58tYZYAc5CbkL2thJ4zVquVEm5zKyUkQXW0RjwfNrqeGscaRVeRSyxlkMvEyDFv+27VgCWD6bt1qeLXKyDjUK8nOZgjKQADF6+oCkwNlEgu0ps3qhK9KsTuJJhKC6K8/yPR1n9ns2PNRb3PKU7KzrQ8rOV/M3Nkq1iFci3dNSKgQ0SEL/jTsemzV8/4STTD20DpGXO298DXnjFJMFKlYUP1zhMM8bKlj81fQg9WHr2Z4BXUvM1dHAXWknjeV6tPgPwwDHapO+obZ43pnKH9WZv9M1y7ZBn/l0ZC418g8Yp8caw5RduDKW5ShrzHApRPHVS8+SVBi2L9N3jvCsBfot7OK5ffZujpZYea12+Zco5w+BnTnYSCnW0TeeE+PnUZv55FjV0VFRk6wNCMKpvE+Fy/YlR2cx6kQ9GbemOmjhPBmmIa+9bBcWPfZ3EwN3SKhEGioOTw0AYuQf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LY0PR11MB357627.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNLSUFrbU1icFBWR1VjYm9KSkJCakI3NzlXSTc1MjNITWxqOHk3amg2WTRR?=
 =?utf-8?B?Z0tNUDZ0b1BVLzJaSDFmZ1RrSXBVTDJ4THFEL24ybjhlNVFCUUxXTzdxUzNT?=
 =?utf-8?B?VzJmQVc3aWpDY3ZmWXNORHZLVXM2KzNXMUlKQ3dZTmhseHZZOFMyR1l6MG5B?=
 =?utf-8?B?Q2RVWU0wSVFpZThNV2w5Tk5aSjE3eXpEa3cxV3BJQnBtOHFUcVUxY01MYzhs?=
 =?utf-8?B?WnhjZ2lNRkhseVpTL3hkRWl5QU1EbFIrbTBJbEJlRThRdjM3NXZudlp6UnE3?=
 =?utf-8?B?bzhvOUVkK1g4bGw0ZnhDdzJrRXJtNEpPTlh2U0w4eTJWU0dUOExjRUMwWjJY?=
 =?utf-8?B?M0lPSTQzYTRYdVVpR1V1QWZYQVVwWkcrQnlJT3FPQmdCYTczSmdTRjV4NHk1?=
 =?utf-8?B?NCtLRGl6ZzJ1MkhDU0xBdldEZkJnN2l4Zlh4SU8wbnJ3Y0JOWjdDMXd5TDlE?=
 =?utf-8?B?QWwveWYxVE85cE1tV0ZHdnJyYUMrWjBSNFJINjVnOHNPZSt6T1F1VE53YmtF?=
 =?utf-8?B?NE1WckxXTDBzdGpCRXl3MXJIN1djZGNsNWc1d29TUUZFVTV2VnFUT25WeWow?=
 =?utf-8?B?TVB2SWhpNlRBV2xQQzRtSnh5NnluVHhKQ0RjUkZHYWJQRXlGY01aQVFuZ0Ix?=
 =?utf-8?B?RmNzS0xwTlA1UlZ3NzJ4V3Fpajl4TnluZ2FkcUpHcTdKVEM0djRrdG9VdlBK?=
 =?utf-8?B?blQyRTJqa01HbWF4UTk0WGtjNmIwU1FGd1hpVUE0bytLMWFzSEx1cjVJcEwv?=
 =?utf-8?B?bURiYzExelFqUVNDMzlTOGNWTStWV2pnWDFDREl1bUVIMVFjNXpQYnNqdnJB?=
 =?utf-8?B?NFBzVld0VWNxZytrWlBzR2krQ1NCUWhnTEpia1FRZnlPTkppdEt4VGdDQjdu?=
 =?utf-8?B?a3UrRmltSnUwR0NWQjFHSmoraWI5aGRMUlpXaThGTzdYc3dqSmQ2OTBSSEZY?=
 =?utf-8?B?YWthSVJIYUZKWGNhYTlvK0dsK3d1K1Z0Z3dSZkt5RHBkdmtudHF5QkNOUFFw?=
 =?utf-8?B?R1VaQy81VS9FcldVV2ZiK3J2R25pd2JhT3ZBenNjR0szdnVUUE4xNDFBakFu?=
 =?utf-8?B?bWcwT2ZEazRnalJ3THUvcWJZelBSUExLR0YzczBWUTE2MU5QMnh5SXQzbTJu?=
 =?utf-8?B?VFV4SG9heHJ2MCt4a1J0OFI3QWgwVjBEYmk2ZmgycFBCaCtZLzcrQmdPMFBo?=
 =?utf-8?B?K1BERWxTdVV5V2RjM2ZNaWl4dE52RVkyWjlTQTJBTkpyY1dYMHZ6a1NiV25w?=
 =?utf-8?B?YXVMSHZpdHRkWm1mUTdiL3VEd1FIdHNnbEZrZzlTVStqSlRsL2ZYWnlwYVdS?=
 =?utf-8?B?bHNBYTMwWjdXcmpCWEZSemhzL2g0Ni9oV292d0YzWmJPMS82c2RkSkpLRUsr?=
 =?utf-8?B?aFpSa0QyaHVIdXd2eGcraGRHd0x2Q2JBWDJkTW0wajRpQzRRZ2sya3JyRVZ3?=
 =?utf-8?B?MmpycUlOZEdxc1VOL3VqRTJ4dzFFTmR5WFFqQnBBUXY1WlB3RjZGWHR4SmI3?=
 =?utf-8?B?TEF6K1p4OUpIQ0ZQYTZqUlZtU1FuZi80empOa1RoY0tsYjNVa09mZkZOSm44?=
 =?utf-8?B?TVhZRHpFN1RveEI1b0lwQlVIK0tIL3NkNGs5ZmZhZVhOWHhkb2dOcUh6ckdV?=
 =?utf-8?B?NjVZSGpaK2Z4WnR1aGJuMWFDa3NHblVlblVlajBnVElJRjlVNkhyTWNUcnFI?=
 =?utf-8?B?dE1BTTFEVC8vTUlzWDVqbXJlQVRHUEFkbUFXb2tHRUtnNXFReVV2bXZzaHdV?=
 =?utf-8?B?OVJVQ09pQm5CR25jeEtJOTRVbE9vTU1Jc3R2bEx0NGQ3RnRzaDBicTBqQmcr?=
 =?utf-8?B?bkVXRUhWOTcyVkRBYXBFVHFIcVVGcmliT1VpWDUvYVV4c1RmQlBsQzQwRUJh?=
 =?utf-8?B?UllnN3liWmwzT2toYmFhWUlSTGMzc1dnRlVEdHQ5RHJLTmhnMVNncUhQMGh6?=
 =?utf-8?B?aXl2WjNhR3diNHNhcGl2RWxmQ1pTKzlRaFZMeUkvbWpWOTVLc2FzOGFtYXBu?=
 =?utf-8?B?b244dEx1V0JoZkM0SGh3MDQ3SXlsS0NFSVArZzlnMzM5T2Y4VEtTUHdHZlYz?=
 =?utf-8?B?cG9NczNsSTYrRHQraVBmN0x5R2xRS1FFRi9FSENhL2x1NFBmKzQ5aUp2NmRs?=
 =?utf-8?B?V25ST25GQUR4OVd4S2FCeU1nSWtkanRHbXNlNU9KR3lIVUpzTnpGNllGbkxv?=
 =?utf-8?B?UEVBYzRJZUo2aTBvVDdqWWdwcnk0NG8xdElZZlE2UUV3RGliVm5lUlE5YlBq?=
 =?utf-8?B?dXJSblNDS0k1Q211WE5DSnpFcHhDK0lXb1RoekFraVFyZGVDNVE4QVl5TTJs?=
 =?utf-8?B?ZE5ZS1NyUko1UXV4VTl5UXh4Q3Q5YmJzVnBJWEgrRURaV2d3ZDl4QlNhcnc3?=
 =?utf-8?Q?WqNzMQ4+ZNefkKeo=3D?=
X-Exchange-RoutingPolicyChecked: LI5CQW08Ebz17DhfQhDAkBoDXsx7vPAe6N9d/reA9ioEt50TkyRxpF3KWQUnKt3yP4+DBQ+8H4QGi32JPp2HcDcGniaDPYIGMPTB882EbZkUErTI1chMpz+qoVpR9GXmC+vxl1RtX95Cb84DF4zYqRVS5++WEEOqdNuEWM0XaRB5ItPrsq3JebXNu8WpxDq1Ftgq7VFwYbpue63xKHyDDUWSjbOkzgpOgp+U8NW/DM+eiOIvgO7H/HN9QMR8zqHUSFWsjmXptSHYxH3+L3chUmZcUYmSjDw3P8A/uIx7IUgFKWzxFtiOXpzWMy2bUdR58BZGf8jgal4R9Xs2tnrEHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c7eb62-dcf3-4b66-bab2-08df4935f74a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:47:04.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLKnpfEnx52THW2pP3ZBA2KDVQKNKWt1/CHeWKJRGsxtRssCffcxV2F78VcT4cxKbjsuM98wdF2/9WOrZOn8d+iCCobvlitgXPkitEHSk9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
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



On 11/20/2026 5:14 AM, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> drm_atomic_get_colorop_state() didn't get the memo on
> commit 0a0e79a2d9ed ("drm/atomic: WARN about invalid
> drm_foo_get_state() usage"). Add the missing warning.
> 

LGTM
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>   drivers/gpu/drm/drm_atomic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 81591173265d..b0843e5a9e4d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -742,6 +742,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   	struct drm_colorop_state *colorop_state;
>   
>   	WARN_ON(!state->acquire_ctx);
> +	drm_WARN_ON(state->dev, state->checked);
>   
>   	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
>   	if (colorop_state)

