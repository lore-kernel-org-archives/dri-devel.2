Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D4606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CC4v49IJ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=K/LDYHla
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245C4112074;
	Thu, 12 Nov 2026 12:12:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1255811206C;
 Thu, 12 Nov 2026 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794485558; x=1826021558;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LUcV4fncrzGa3h1ZR/aKe7JkVAmPrBCIqjdbjZ1C6Bw=;
 b=CC4v49IJskuXDivRn4z6X8OQOHHVe5mYJWXvR92fGuEaXB/JY+SS7RuE
 oO1evGbH7tLtoPX4LgrAuxvZLoP81ZUF2aQEVMBkxspRufN5xxzuqnUov
 eWe6jpW5Xe+or9GRLcrRKAfabUPbD8Go9C6s7VCsHIP/WdkuEHSzGHFA3
 dcACtizdWNq2nhEGjqO/HgZMJU3w3097ngiwKbNN1iQy2/sV61BJcPt5d
 t4e8cdUSmnLY88sWy9WbrqBE0OX6xmLdE/g1ujZsB0qGp9EX1FYN+MwWX
 15hK0m+HLcsV7VzyUf+kc2x+oA5rJtCmYhWpiz3Wi/oYjm5Rs+/v1yCjn A==;
X-CSE-ConnectionGUID: 3V7CranJSMycKF2QtSjXBw==
X-CSE-MsgGUID: JO5FCq3mRsSvsxRQ+xyihQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3178561"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3178561"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:12:37 -0800
X-CSE-ConnectionGUID: 5Hxh43DVSH6RAXw/+FqwsQ==
X-CSE-MsgGUID: 5PanFNvJQoGvdWFCr9uKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8539535"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:12:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:12:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 04:12:37 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:12:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmK6Byp1t+cXgmvWKDLsyXYiMRkq6lGJfhWrLwqAebvYK7H5CcusJMmJT6ako8U1w83v/+GXlnC5SwM95LVMt/a6lEqI79+0ihDbUsBg8n601bg4o47Rwt1KMdQmmfVG8SM3i+LIe7n/Fp761dKPeHsF7fBdhldEZ0skUJRR1VO/F7UpbG95Txpy62mpQCzop9X++WW+dyIy3F5yhqsSMixukyZPouyUnz/bO9NCYaRiv9dpwcfYwekGs7gdK5JLwDORwQ8FnU+cWISgHVkR8/Wy6DWjlwuTqeLCGRPIFXoYXhhddpsYepAdzpj7Et8ZO7pn0v+iRw8+a+i5dyG4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufRX19yp80tTy5TnuLcLcL669wsJ93O3QteeDL0yohs=;
 b=eE31h2T/f1BujSUsOohYZPHDI5Fy5dgt5STLxyI4Fm2LxfGFZahyjR1ktf0l2Y0ezEjfQZtOm9DS3jgk+vde1o77z3q4yqVvHBiu0iYRuy3OkM+qF/pAhjPohBLgT27yCQXdpnbi4eC6+ExYax0mrq77hoUTc2dde3VVGpBQy+O7xZ/Ea/N2v8eF9TZPGiPHH6KCPm2ymPAkTtSLuhW4+ZiRMS7GeDAy4LcUmCGYlU6XSZCAzzoWTNpb0OkRDvg4VqC0IQhoWQDGWlNQXJKOh5dIARcxtxDZycm2lyjHZgmG8PajI7PiQQ/HSCkeaGmdRDVSfBdcmYt73tpHjkwBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufRX19yp80tTy5TnuLcLcL669wsJ93O3QteeDL0yohs=;
 b=K/LDYHlaReYOa6VPrXqHAMxdZjy425VD9fcZHyrQbl68JSazSGeGwYbV7OcD1cydDBWeZlkio69LOCLsUdw1y5iufrq0TikhFGJRLGq2V9ZLqY/hIQZrOvMahGC6ZmHJA5ClUde4pmZS/zknnjHtejpmoXhFQiPp67DytXWxIjk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by CH3PR11MB691942.namprd11.prod.outlook.com (2603:10b6:610:34a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:12:34 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 12:12:34 +0000
Message-ID: <207127ce-60e1-43e1-a08f-11f3cfc61d3e@intel.com>
Date: Thu, 12 Nov 2026 17:42:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/xe: Defer VM teardown until exec queue cleanup
 completes
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-5-arvind.yadav@intel.com>
 <DS0PR11MB8718EB6E429A6194205C65B981762@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <DS0PR11MB8718EB6E429A6194205C65B981762@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|CH3PR11MB691942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8b3cad-b8d0-4f79-cd50-08df40b63bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102124527099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EDHHe0hj/3r8yPgYS+V6y2LWQV9dgg+6FowDgsbZxkOaZKY33V9W4X79tqvXEhWCcCiJV2V+idAW5eFmT8xxbtzNF9VIifdQOhepfuue8HZ5puElf0B67BPsN6SyXkSUGL8Uv/woeecbOA+6HgPYo4gdQA81QBZy65AH4adRriyiM5oq13vUPOgM0d4Rp1wjf4K0U9BMbK7Q4XDfpeyAn9r1sReOPbcd6XukR0OX4hd7UyiF982XTnCwJUP7m2KJ/0oQzHEYyblOtgJHlzanOgos9eq996756FjQDqXcURAqLpoUy+Iwww+SssPIUKGtrVGlZ3vH7aAl37vk4HHceU6pi4rohAai61LKTkap9Y3JIzaJ7z2kLy5qDgj0mz/HozMTWRI8v5STd4vqR8HBbdOJj1oARevmmcAgDldrplM+ie+vU9SeWr1yS4XDYCoqzoTG9Bmtxs2ktVZBzeX6kYqLvPlNXmN9YCAwygSNVBtIZakHwO21KU5BrJhSLA3Ls0fJxkLevFeHMt+Q2iqXT/tk0InWrS4Aie65RG2kgxcLyF7/IC1yRTTsQqBaSHYatbKP2yoF6bbfufbUxlq1+llFm6nNzYDiE8/0YMUeLN/43MCvRJwUZfcymsd6RCNtHIQg4gUDRkKJtA4Wxjf0EaP4fsFBiPrUgVO2ZEEpvSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102124527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFdZTjNhSnAvdnlDUkg1bFRxMjY4T0I2YVdOS3pmeTFETCtLejFqZGxJb3gr?=
 =?utf-8?B?MjJwOG5GWHpuODJ2RU5LMkpITWt2YXY2bFlacndZNUx4enVjWkIzSlhkSklM?=
 =?utf-8?B?Vm50aHc1L01NS2xBenU5U3V0UW9IVStHbFJ3WlhsMkswUndRSHJyRjBtU2hy?=
 =?utf-8?B?OXNCSmk2TnRsZ3VINW5Ca2QvYStORGhiRlJaL3A3VURENEcrd0xRZ251cnpH?=
 =?utf-8?B?aFlIQkNQSk9TY2JlM0Z6MHZ3NE5xY1NKeGVUbkM3ZFpRUnJJcjVHdnFFTzhU?=
 =?utf-8?B?bWtiWE1MV3ZnSHhlZitxVCtrWkROYnUyUHRsc0tBREg3SHBYeDBLek44QlhK?=
 =?utf-8?B?MmRqcWROcDZSYmp3YkhtWHlpa1pYRjdIa0NjcE9PUlVMbFVIQXREV05CY2lx?=
 =?utf-8?B?OEpNdGtUQlJpMTQ0aE9heDhvOWV5V25oNUxRN0tCWVdhM2FxUzBsR1FWTjZo?=
 =?utf-8?B?NklkaTl4RytKOGUrU0tPN1RmaWJMVjk5cjZYd3ZSaEtYME5Vb2o3TXhnR01q?=
 =?utf-8?B?WGsraUUxTnFqWjB2NXZlTE5yYS92OWwwdk9QQTh0dWY3SFdMNXlhSGc2TlVR?=
 =?utf-8?B?VUVBRTUwdUNLTzcvK01TV0JSclBQcHNRNG1BVnZtdEFzVndTejZ3Vm01eGhz?=
 =?utf-8?B?NldjTmUxbDNlOEpEMnJhWkNHKzI2WXhIYVVBZTdGTEFMdzB2SzRRRWVWZ2Nj?=
 =?utf-8?B?bnNEMytESDRaVFlsajliSkxIME5qN1N5K2xPSEUyUFdsdmduMGxPdkJqMzBZ?=
 =?utf-8?B?cWVsQVQwc3dlZWNTVHlrT0ZYMXhsWHZsaTFpb0hMZk9mNitkOFZsVnZZMEdN?=
 =?utf-8?B?aTVidmJKeGJLZUcrSmxPeDRBZHM4TmZMMW9tQ2tEcklBWEF3RDdQNnA4YlUx?=
 =?utf-8?B?K05ibGFCVTFzL3ZhSDdZTi9zTWRkUlp3UTJSb0xBYkUvWjlGMTBnVkNNRjAv?=
 =?utf-8?B?dG1ZcW1UckJ2WlBoSDMzTlJzUjVjYVlpcjVnR2V0ODFteEYzRzAwWHZTd01G?=
 =?utf-8?B?TUM4ak1IMWFkTE92TWNwRmNsM3gyVUZrWG8zZmlUY0hjYmZCZlhVMkhUOUlk?=
 =?utf-8?B?ZzRQMElYQy9ZdUQwaHRnU2pVRlBiS21mc0h1anpPN3N3KzM2a3Q3b3BYSDdY?=
 =?utf-8?B?aFJIbXo2YVlpWENJandwUTlTak1YTEVzeDJ6Zkw3aEE2MGtmZXFWUkZGUitn?=
 =?utf-8?B?bUVSb1BzMFl5NHpzRFpmZCtyaUVPaGFzQzVoYWFXVzI5THZXaEJBT0g4dm1F?=
 =?utf-8?B?dDFOZXh5d09iNmpraDc0Zi9LMjRneWt2Q0FNamlzWDNqNGVnKzM5NWpWc0Uy?=
 =?utf-8?B?RVpPWnBJNXFabytBbTNwVTFiNDhNa1R1ZTYzN0wvV0JLMkxnbm91MzhieWdw?=
 =?utf-8?B?QUt2L256TjRCNnZoVW9LVlpGcWVlSDhMNFFhcmcrcEFVSFR6THZBSTJVUmND?=
 =?utf-8?B?VUlsMUdCQ0FhR2RtZTFFcGVKOTByTzdaZ0JaSS9ER3lyc2RlMVJxN20vS1B1?=
 =?utf-8?B?Vm1LUU5wSmxIYytQNDVKQm1uY3IrSmcxMDhVbDgzMjRPQmdtaG1NcDZjSExW?=
 =?utf-8?B?b0lKSEpUa3JNdGNtVGRhaUo0ejVlN0t6djl1YWhPaFdnZkt0VHRrQXl2aEpk?=
 =?utf-8?B?d1ltM0NtTXV1eTVKcUVNZEJBKzg2a1QyYkZ4UDZ6LzIxVmd5cEJrSHhXMTE5?=
 =?utf-8?B?R3FSMlN4ZXlReHd0S1ZUZG5TOWpoME4zd0RnRk5XOHJTaVo4Y2w4bXIrVXBD?=
 =?utf-8?B?cExNM0swNFdUWEFubGtTOUcvMGlXelhmVkIya1djNDlLb0E2RGJzbGpMeUZh?=
 =?utf-8?B?MWlzanBuOVBMcUdxTDQxSytha1dvTnBEdFlwbDdsSSs4K3F4SWtKTWluc2lv?=
 =?utf-8?B?bGFNdGRYVk8xZjlBa2JEeWZCVlFndzZwd0E4R3RnQ2R5a21hN2ExT2tFSUNQ?=
 =?utf-8?B?ZTJ5dnhzU3JXK0l0TjRQYXdIMEtFS3d6WkRPajJjUGEzMUF2a0c0VFBzR2Ji?=
 =?utf-8?B?RHR1cEliZWVFYzVQQWFoVkIyWWRZU21pMmtkVWZKOEZveko4ZXBycEt6TnIx?=
 =?utf-8?B?ZVJJaEZnV3IrM3NrL2NjME83ZW9hci9VdE9NMmJBNU1RUVo5OUNKeWJyRGRJ?=
 =?utf-8?B?UDh2S2kzZENkYzlHMTc3ekFWTURCT1RtcTBHaGp4OGRVSnJOUDUxdDcrNXhM?=
 =?utf-8?B?Q2lBNFpvL2FNOWRQV1ZDbWJjc01Vd1hlOGhkU1k0K3BQYlNGR0k3M0tIZmZS?=
 =?utf-8?B?QzJMcCttcGFvdXBUMUV4TE95VUdmRktyRk0zMWhlUzJlTzkva1ZIYnZnaGFT?=
 =?utf-8?B?OFh1NTlNYUtLQVpJSENnZW1oSlRKcTJsZHlPWnNpMFRJMTZkVExHZz09?=
X-Exchange-RoutingPolicyChecked: pxkhveaZdDswQdVA95dHT5xrEaSpbjqCgxhVS2nLo1a4kuSprEeL8HzR4RJQMTosyXW9YVhzfT+ZuIf7A+SC+LWOu3ov0yCZqfOdjWPOjtCo0tf7AnopeYCe8Sv0aRKsDLBOX1iAtfiNBhZe72O0G5Z+QuBNG/Y4aVE9cCH7ulMDMWbZqkDLHVIJ8ojmkx3iwrpxatZKioziZ5x0mIrrpSQtNvJ9S6GaJK9KIltPVrWoqVBtIc3vkE+fHoVHxTR4vfFN1Mm0gf3tRyQuQUTRlrDoM7DpODskfbjl4YJfsvZ1vG2x5nahh1A2hPCqLg5Fjv4A+oOUJOjBBDlFGFRVSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b3cad-b8d0-4f79-cd50-08df40b63bd8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:12:34.5985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ohqgn8r187paY+YQcpr9lk3yQQ1zlcMTP2eAWtULbo67YKPQcMt9ZxG8DWN3brxcvK3cpn+T1fa7g4RmDIcJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB691942
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


On 06-11-2026 16:36, Upadhyay, Tejas wrote:
>
>> -----Original Message-----
>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Arvind
>> Yadav
>> Sent: 16 September 2026 15:24
>> To: intel-xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>> Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Brost, Matthew
>> <matthew.brost@intel.com>; Ghimiray, Himal Prasad
>> <himal.prasad.ghimiray@intel.com>; thomas.hellstrom@linux.intel.com
>> Subject: [PATCH 4/5] drm/xe: Defer VM teardown until exec queue cleanup
>> completes
>>
>> Exec queue destruction is asynchronous. Closing a VM immediately after killing
>> its queues can remove mappings before GuC cleanup has finished.
>>
>> Track the queues using each VM and keep the bind queue's user_vm reference
>> until final queue destruction. Start queue cleanup before removing the VM
>> mappings.
>>
>> The count includes VM-owned bind queues. Release the VM's references to
>> these queues before waiting for their asynchronous cleanup.
>>
>> During file close, use one five-second wait budget across all VMs.
>> If queues remain, defer VM close until the last queue is removed.
>> The existing runtime-PM reference remains held during this wait.
>>
>> VM destroy does not wait for queue cleanup. If user exec queues still reference
>> the VM, its mappings remain after the ioctl returns until those queues finish
>> cleanup. Userspace must destroy the remaining queue handles or close the
>> DRM file to release them.
>>
>> The five-second budget limits the new queue wait, not the lifetime of the
>> retained mappings. Recovery continues through the existing GuC reset and
>> teardown paths.
>>
>> Run deferred close and final VM destruction on the module-lifetime destroy
>> workqueue. Hold an extra VM reference until the close worker has released its
>> PM and unplug guards. Final VM destruction retains the device reference until
>> cleanup finishes.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device.c     |  21 +++-
>>   drivers/gpu/drm/xe/xe_exec_queue.c |  22 ++--
>>   drivers/gpu/drm/xe/xe_module.c     |   6 +-
>>   drivers/gpu/drm/xe/xe_vm.c         | 178 +++++++++++++++++++++++++----
>>   drivers/gpu/drm/xe/xe_vm.h         |   5 +
>>   drivers/gpu/drm/xe/xe_vm_types.h   |  15 +++
>>   6 files changed, 214 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>> index 954f0965deb8..8966a3bd6eac 100644
>> --- a/drivers/gpu/drm/xe/xe_device.c
>> +++ b/drivers/gpu/drm/xe/xe_device.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/aperture.h>
>>   #include <linux/delay.h>
>>   #include <linux/fault-inject.h>
>> +#include <linux/jiffies.h>
>>   #include <linux/units.h>
>>
>>   #include <drm/drm_client.h>
>> @@ -175,6 +176,8 @@ static void xe_file_close(struct drm_device *dev,
>> struct drm_file *file)
>>   	struct xe_file *xef = file->driver_priv;
>>   	struct xe_vm *vm;
>>   	struct xe_exec_queue *q;
>> +	bool close_deferred = false;
>> +	unsigned long deadline;
>>   	unsigned long idx;
>>
>>   	guard(xe_pm_runtime)(xe);
>> @@ -195,8 +198,24 @@ static void xe_file_close(struct drm_device *dev,
>> struct drm_file *file)
>>   		xe_exec_queue_kill(q);
>>   		xe_exec_queue_put(q);
>>   	}
>> +
>> +	/* Start all bind queue teardown before spending the shared wait
>> +budget. */
>>   	xa_for_each(&xef->vm.xa, idx, vm)
>> -		xe_vm_close_and_put(vm);
>> +		xe_vm_kill_bind_queues(vm);
>> +
>> +	deadline = jiffies + HZ * 5;
> Overall approach looks ok to me but I think this is more of testing driven setting. What is the basis of using this timeout? Also did we test zero wait, does it create memory crunch later?


I used 5 seconds to match the existing GuC enable/disable wait budget. 
The wait ends earlier if cleanup finishes. I have not tested zero wait 
yet. I can test update the result.
We have test it under repeated close and VRAM pressure. It did not 
created any memory crunch till now.

>
>> +	xa_for_each(&xef->vm.xa, idx, vm) {
>> +		unsigned long now = jiffies;
>> +		unsigned long timeout =
>> +			time_before(now, deadline) ? deadline - now : 0;
>> +
>> +		close_deferred |=
>> +			xe_vm_close_and_put_deferred(vm, timeout);
>> +	}
>> +
>> +	if (close_deferred)
>> +		drm_dbg(&xe->drm,
>> +			"VM teardown deferred while exec queues are being
>> stopped\n");
> What if queue never return/stuck or something?


If queue cleanup never finishes, the VM mappings remain allocated. The 
timeout only bounds the close wait. I will check that reset, wedge and 
device removal release all tracked queues. Any path that leaves a queue 
behind needs fixing.


Thanks,
Arvind

>
> Tejas
>>   	scoped_guard(mutex, &xef->mmio_gem.lock) {
>>   		if (xef->mmio_gem.pci_barrier) {
>> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c
>> b/drivers/gpu/drm/xe/xe_exec_queue.c
>> index e63559a2f582..82407dddfbbe 100644
>> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
>> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
>> @@ -154,9 +154,16 @@ static void __xe_exec_queue_free(struct
>> xe_exec_queue *q)
>>
>>   	if (q->vm) {
>>   		xe_vm_remove_exec_queue(q->vm, q);
>> +		if (q->vm->xef)
>> +			xe_vm_remove_close_queue(q->vm);
>>   		xe_vm_put(q->vm);
>>   	}
>>
>> +	if (q->user_vm) {
>> +		xe_vm_remove_close_queue(q->user_vm);
>> +		xe_vm_put(q->user_vm);
>> +	}
>> +
>>   	if (q->xef)
>>   		xe_file_put(q->xef);
>>
>> @@ -250,8 +257,12 @@ static struct xe_exec_queue
>> *__xe_exec_queue_alloc(struct xe_device *xe,
>>   		}
>>   	}
>>
>> -	if (vm)
>> +	if (vm) {
>>   		q->vm = xe_vm_get(vm);
>> +		/* vm->xef stays unchanged until final VM destruction. */
>> +		if (vm->xef)
>> +			xe_vm_add_close_queue(vm);
>> +	}
>>
>>   	if (extensions) {
>>   		/*
>> @@ -617,8 +628,10 @@ struct xe_exec_queue
>> *xe_exec_queue_create_bind(struct xe_device *xe,
>>   			return ERR_PTR(err);
>>   		}
>>
>> -		if (user_vm)
>> +		if (user_vm) {
>>   			q->user_vm = xe_vm_get(user_vm);
>> +			xe_vm_add_close_queue(user_vm);
>> +		}
>>   	}
>>
>>   	return q;
>> @@ -657,11 +670,6 @@ void xe_exec_queue_destroy(struct kref *ref)
>>   			xe_exec_queue_put(eq);
>>   	}
>>
>> -	if (q->user_vm) {
>> -		xe_vm_put(q->user_vm);
>> -		q->user_vm = NULL;
>> -	}
>> -
>>   	q->ops->destroy(q);
>>   }
>>
>> diff --git a/drivers/gpu/drm/xe/xe_module.c
>> b/drivers/gpu/drm/xe/xe_module.c index 4bc28dfc1992..4e500156ed9b
>> 100644
>> --- a/drivers/gpu/drm/xe/xe_module.c
>> +++ b/drivers/gpu/drm/xe/xe_module.c
>> @@ -114,9 +114,9 @@ static void xe_destroy_wq_module_exit(void)
>>    * xe_destroy_wq_queue() - Queue work on the destroy workqueue
>>    * @work: work item to queue
>>    *
>> - * The destroy workqueue has module lifetime and is used for GuC exec queue
>> - * teardown that can outlive a single xe_device. SVM pagemap destroy uses
>> the
>> - * per-device xe->destroy_wq instead.
>> + * Queue and VM cleanup can drop the last DRM device reference. This
>> + workqueue
>> + * has module lifetime so device teardown cannot destroy a worker's own
>> queue.
>> + * SVM pagemap destroy uses the per-device xe->destroy_wq instead.
>>    *
>>    * Return: %true if @work was queued, %false if it was already pending.
>>    */
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c index
>> 5d0b616a27b3..152540a4741b 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -29,6 +29,7 @@
>>   #include "xe_exec_queue.h"
>>   #include "xe_gt.h"
>>   #include "xe_migrate.h"
>> +#include "xe_module.h"
>>   #include "xe_pat.h"
>>   #include "xe_pm.h"
>>   #include "xe_preempt_fence.h"
>> @@ -1558,6 +1559,7 @@ static const struct xe_pt_ops xelp_pt_ops = {
>>   	.pde_encode_bo = xelp_pde_encode_bo,
>>   };
>>
>> +static void vm_close_work_func(struct work_struct *w);
>>   static void vm_destroy_work_func(struct work_struct *w);
>>
>>   /**
>> @@ -1701,6 +1703,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe,
>> u32 flags, struct xe_file *xef)
>>   	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>>
>>   	INIT_WORK(&vm->destroy_work, vm_destroy_work_func);
>> +	atomic_set(&vm->close.num_exec_queues, 0);
>> +	init_waitqueue_head(&vm->close.wq);
>> +	spin_lock_init(&vm->close.lock);
>> +	INIT_WORK(&vm->close.work, vm_close_work_func);
>>
>>   	INIT_LIST_HEAD(&vm->preempt.exec_queues);
>>   	for (id = 0; id < XE_MAX_TILES_PER_DEVICE * XE_MAX_GT_PER_TILE;
>> ++id) @@ -1948,25 +1954,7 @@ void xe_vm_close_and_put(struct xe_vm
>> *vm)
>>   	if (xe_vm_in_fault_mode(vm))
>>   		xe_svm_close(vm);
>>
>> -	down_write(&vm->lock);
>> -	for_each_tile(tile, xe, id) {
>> -		if (vm->q[id]) {
>> -			int i;
>> -
>> -			xe_exec_queue_last_fence_put(vm->q[id], vm);
>> -			for_each_tlb_inval(i)
>> -				xe_exec_queue_tlb_inval_last_fence_put(vm-
>>> q[id], vm, i);
>> -		}
>> -	}
>> -	up_write(&vm->lock);
>> -
>> -	for_each_tile(tile, xe, id) {
>> -		if (vm->q[id]) {
>> -			xe_exec_queue_kill(vm->q[id]);
>> -			xe_exec_queue_put(vm->q[id]);
>> -			vm->q[id] = NULL;
>> -		}
>> -	}
>> +	xe_vm_kill_bind_queues(vm);
>>
>>   	down_write(&vm->lock);
>>   	xe_vm_lock(vm, false);
>> @@ -2038,6 +2026,148 @@ void xe_vm_close_and_put(struct xe_vm *vm)
>>   	xe_vm_put(vm);
>>   }
>>
>> +static void vm_close_work_func(struct work_struct *w) {
>> +	struct xe_vm *vm = container_of(w, struct xe_vm, close.work);
>> +	struct xe_device *xe = vm->xe;
>> +	int idx;
>> +
>> +	/* Keep the VM and device alive until the PM and unplug guards
>> unwind. */
>> +	xe_vm_get(vm);
>> +
>> +	if (drm_dev_enter(&xe->drm, &idx)) {
>> +		xe_pm_runtime_get(xe);
>> +		xe_vm_close_and_put(vm);
>> +		xe_pm_runtime_put(xe);
>> +		drm_dev_exit(idx);
>> +	} else {
>> +		/*
>> +		 * The device is gone. Drop the VM without a runtime PM
>> reference.
>> +		 * xe_vm_close() guards its own register access.
>> +		 */
>> +		xe_vm_close_and_put(vm);
>> +	}
>> +
>> +	xe_vm_put(vm);
>> +}
>> +
>> +/**
>> + * xe_vm_kill_bind_queues() - Kill and release the VM bind queues
>> + * @vm: The VM whose bind queues should be stopped
>> + *
>> + * Callers must serialize teardown of @vm. Later calls are harmless
>> +because
>> + * the first call clears the VM bind queue pointers.
>> + */
>> +void xe_vm_kill_bind_queues(struct xe_vm *vm) {
>> +	struct xe_device *xe = vm->xe;
>> +	struct xe_tile *tile;
>> +	u8 id;
>> +
>> +	down_write(&vm->lock);
>> +	for_each_tile(tile, xe, id) {
>> +		if (vm->q[id]) {
>> +			int i;
>> +
>> +			xe_exec_queue_last_fence_put(vm->q[id], vm);
>> +			for_each_tlb_inval(i)
>> +				xe_exec_queue_tlb_inval_last_fence_put(vm-
>>> q[id],
>> +								       vm, i);
>> +		}
>> +	}
>> +	up_write(&vm->lock);
>> +
>> +	for_each_tile(tile, xe, id) {
>> +		if (vm->q[id]) {
>> +			xe_exec_queue_kill(vm->q[id]);
>> +			xe_exec_queue_put(vm->q[id]);
>> +			vm->q[id] = NULL;
>> +		}
>> +	}
>> +}
>> +
>> +/**
>> + * xe_vm_add_close_queue() - Track an exec queue using the VM
>> + * @vm: The VM used by the exec queue
>> + *
>> + * The queue is tracked until its asynchronous destruction completes.
>> + */
>> +void xe_vm_add_close_queue(struct xe_vm *vm) {
>> +	atomic_inc(&vm->close.num_exec_queues);
>> +}
>> +
>> +/**
>> + * xe_vm_remove_close_queue() - Stop tracking an exec queue
>> + * @vm: The VM used by the exec queue
>> + *
>> + * If this is the last tracked queue and VM close was deferred,
>> +schedule
>> + * the deferred VM close.
>> + */
>> +void xe_vm_remove_close_queue(struct xe_vm *vm) {
>> +	bool queue_close = false;
>> +
>> +	if (!atomic_dec_and_test(&vm->close.num_exec_queues))
>> +		return;
>> +
>> +	wake_up_all(&vm->close.wq);
>> +
>> +	spin_lock(&vm->close.lock);
>> +	if (vm->close.deferred) {
>> +		vm->close.deferred = false;
>> +		queue_close = true;
>> +	}
>> +	spin_unlock(&vm->close.lock);
>> +
>> +	if (queue_close)
>> +		xe_destroy_wq_queue(&vm->close.work);
>> +}
>> +
>> +/**
>> + * xe_vm_close_and_put_deferred() - Close a VM immediately or defer the
>> +close
>> + * @vm: The VM reference to consume
>> + * @timeout: Maximum time to wait for VM queues, in jiffies
>> + *
>> + * The VM must already be marked closing, and callers must serialize
>> teardown.
>> + * Release the VM-owned bind queues before waiting for queue cleanup.
>> +Callers
>> + * may release them earlier to start cleanup for several VMs before waiting.
>> + *
>> + * If queues remain after @timeout, keep the mappings and finish VM
>> +close
>> + * after the last tracked queue is freed. This consumes the caller's VM
>> + * reference on both the immediate and deferred paths.
>> + *
>> + * Return: %true if VM close was deferred, or %false if it completed now.
>> + */
>> +bool xe_vm_close_and_put_deferred(struct xe_vm *vm, unsigned long
>> +timeout) {
>> +	bool queue_close = false;
>> +
>> +	/* Drop VM-owned queue references before waiting for their final
>> free. */
>> +	xe_vm_kill_bind_queues(vm);
>> +
>> +	if (!atomic_read(&vm->close.num_exec_queues) ||
>> +	    wait_event_timeout(vm->close.wq,
>> +			       !atomic_read(&vm->close.num_exec_queues),
>> +			       timeout)) {
>> +		xe_vm_close_and_put(vm);
>> +		return false;
>> +	}
>> +
>> +	spin_lock(&vm->close.lock);
>> +	vm->close.deferred = true;
>> +	if (!atomic_read(&vm->close.num_exec_queues)) {
>> +		vm->close.deferred = false;
>> +		queue_close = true;
>> +	}
>> +	spin_unlock(&vm->close.lock);
>> +
>> +	if (queue_close)
>> +		xe_destroy_wq_queue(&vm->close.work);
>> +
>> +	return true;
>> +}
>> +
>>   static void vm_destroy_work_func(struct work_struct *w)  {
>>   	struct xe_vm *vm =
>> @@ -2083,8 +2213,7 @@ static void xe_vm_free(struct drm_gpuvm
>> *gpuvm)
>>   	 */
>>   	drm_dev_get(&vm->xe->drm);
>>
>> -	/* To destroy the VM we need to be able to sleep */
>> -	queue_work(system_dfl_wq, &vm->destroy_work);
>> +	xe_destroy_wq_queue(&vm->destroy_work);
>>   }
>>
>>   struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id) @@ -2230,7
>> +2359,12 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
>>
>>   	if (!err) {
>>   		xe_vm_close_start(vm);
>> -		xe_vm_close_and_put(vm);
>> +
>> +		/*
>> +		 * User exec queues can outlive the VM handle. Do not wait for
>> +		 * queues which this ioctl does not destroy.
>> +		 */
>> +		xe_vm_close_and_put_deferred(vm, 0);
>>   	}
>>
>>   	return err;
>> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h index
>> 70456ffe27e2..efa427651c47 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.h
>> +++ b/drivers/gpu/drm/xe/xe_vm.h
>> @@ -221,6 +221,11 @@ int xe_vm_get_property_ioctl(struct drm_device
>> *dev, void *data,
>>
>>   void xe_vm_close_and_put(struct xe_vm *vm);  void
>> xe_vm_close_start(struct xe_vm *vm);
>> +bool xe_vm_close_and_put_deferred(struct xe_vm *vm, unsigned long
>> +timeout); void xe_vm_kill_bind_queues(struct xe_vm *vm);
>> +
>> +void xe_vm_add_close_queue(struct xe_vm *vm); void
>> +xe_vm_remove_close_queue(struct xe_vm *vm);
>>
>>   static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)  { diff --git
>> a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
>> index 16b051a0cf10..a3802f4fd00b 100644
>> --- a/drivers/gpu/drm/xe/xe_vm_types.h
>> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/kref.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/scatterlist.h>
>> +#include <linux/wait.h>
>>
>>   #include "xe_device_types.h"
>>   #include "xe_pt_types.h"
>> @@ -314,6 +315,20 @@ struct xe_vm {
>>   	 */
>>   	struct work_struct destroy_work;
>>
>> +	/** @close: State used to defer VM teardown until exec queues are
>> gone. */
>> +	struct {
>> +		/** @close.num_exec_queues: Queues which can access this
>> VM. */
>> +		atomic_t num_exec_queues;
>> +		/** @close.wq: Waitqueue for exec queue teardown. */
>> +		wait_queue_head_t wq;
>> +		/** @close.lock: Protects deferred and work scheduling. */
>> +		spinlock_t lock;
>> +		/** @close.deferred: VM close is waiting for queue teardown.
>> */
>> +		bool deferred;
>> +		/** @close.work: Completes a deferred VM close. */
>> +		struct work_struct work;
>> +	} close;
>> +
>>   	/**
>>   	 * @rftree: range fence tree to track updates to page table structure.
>>   	 * Used to implement conflict tracking between independent bind
>> engines.
>> --
>> 2.43.0
