Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FB606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jo5GT0wW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Oyq1m9hH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8011110E68D;
	Mon, 23 Nov 2026 08:13:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFE310E684;
 Mon, 23 Nov 2026 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795421584; x=1826957584;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n7wlzf4m4FKCoswGR6Vd8rjI+zGJi3bAYu855uH4bM8=;
 b=jo5GT0wW45FDP50j6bRavajnSlztEbAFS/T0MFKoFjc8kReKoTH+sRP6
 AXfjeJiQLVIVknBQ58JtMMKpkVS/tepl7CvxxoY7LE3NyLRgP/C1QeHxS
 UHSDpAHKmkdQeaBg2Za6MWrQb2Dvfr2EQH9jeJJUZc1vAh331P0NdPWv7
 VM9Z/s4vKgx2SIX7frLtTb0ybmg8sDcNzQz7Qs5qtRZwsoPs8GFJFlSii
 NPEgk4UCQNQox33qxx2elFXH64KTeLyCTyf13xolPRfzGRtoKyRQ0gYMq
 bp0w5qfOTQUFbo2wLRuh91ewnejztAl1FXN4QgkG754PXx3LUCa1S4H7v A==;
X-CSE-ConnectionGUID: xenuKXeATLy+TklTfoVbUA==
X-CSE-MsgGUID: /Uwm8BqAT32OpGD0JqEcbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4228804"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4228804"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:13:03 -0800
X-CSE-ConnectionGUID: P3+iJe2MSouRCBlRhyDquQ==
X-CSE-MsgGUID: PozxDhewTOmnj1curXQBUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11111150"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:13:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 00:13:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 00:13:02 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 00:13:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcMAjTxJaxWKYhzVNAKxZ876f5aLHo9aGhmcJhBHyGIgSOZhsdaUxmyIsGqFEl6G+dLI4cXfA7lpaGK2lv+nxpVYQsooJwp9YXEU0erPEM+1ge+Ub1X7HB4uDQ/Ns4u0MQM2Ce03vx9coZOXHlBJYoh04lOlACrjNZMSThPQx+uS5DGrqfuP5H1sOYx3ePSkuOtZyXlGMvrWGI0gega/i0YBfS0P/F3zZcTzQPG2Fz1rPrizdNvnApf/RU7CSnucY4GpfO95R4/McNAW0GQToWRgMVE+HN9xrv7XBKCOGOBkqVrJJ421LMfATj1qXnysF1LGetlpO0t15AJy3KTlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yyyl2drGi0li9oIdOZKgPU0UyeHqhRiRFmRWomKvag=;
 b=dPG+JRFGz5K7Hlef7gm11JsqD2zn6qh2jAP3ksFKx/qfBx5v+1GumnUxzAAXpnUu78ff5MHdeToiwGAjMPPRGCHD19ufyRaqR87IGHELfF2tH8Vz1ZrVSOA0LB9Pdi2ByuDhbofOc9CjL70j5qCgnmCbSqh1SvsFmCF/ycIWeyTRc0jOJ+Eao41BOBAFmvus968ghcj/U3rJEZWUaiX1M9GBfxv/It1OZ1LWg9m3/1laeg+frFNKbjts4b3WtlgDEEq0U7uNRPtn7zNBfOs7NvdC5jic/g8Zbl95Z9QV0WS46UaN9PE9+j1o5KbnwXaRFjg321oxlvBYnVN/4X0aNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yyyl2drGi0li9oIdOZKgPU0UyeHqhRiRFmRWomKvag=;
 b=Oyq1m9hH+PMsnwbWuIpnfQ1/Zj8dKlAOvokRRmuj1EigUGUN1dXrGDsd9vSJFJ0dmuKmfjB0cv6Rc8f1Rz1V4E92VE3YSnWPIIs8KPJkHbA/65xSou7V38leeoDMMT8rHzgmPuAPAKtpPWSf1TZ4BRpuVdyf64UUBIQgxcFmEhY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Mon, 23 Nov 2026 08:12:58 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:12:58 +0000
Message-ID: <12176ea6-8664-4056-99d0-7fcfa2aba247@intel.com>
Date: Mon, 23 Nov 2026 13:42:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Koujalagi Mallesh
 <mallesh.koujalagi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <tejas.upadhyay@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <raag.jadav@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <pratik.bari@intel.com>, <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, <jinzhou.su@amd.com>, <cesun102@amd.com>,
 <lijo.lazar@amd.com>, <alexander.deucher@amd.com>, <christian.koenig@amd.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
 <as_2tO2jfQV764qC@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <as_2tO2jfQV764qC@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0308.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::6) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 188d3034-d92a-4dce-ac53-08df4939956a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261102130727099003|11063799006|4143699003|56012099006|10067099003|260925021911599003|260925021311599003|260925022911599003|261009221727099003|261009223327099003|261009220027099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: vA/GzhR5tvGIPm2FWVyB9cap+OT/G/u8GyenvulwVTfL1/GGIP/EFJdamtPr5+pre73e2rYssLMioyFWP1ahZtFE+dbTfZtVgOeOBs8DOWEw+5f6fo347larzCoDnjz4gfDeTTVA1arAKO65wyaLmK3hult38W/g8N59+C35LNKMwD4sXFEpDDlK6pcxyUwtsHjOhGGXLxLguNX2Xw1pkInVedSP1EEVydwVqDxV1veUVCM5JTEkMFqZ9kDHxbtZ0OnGiReMr3w/A40Ey5OyS+B6nj5Q+GrIYGns1QhLm7bejI68A9sl5QRxb6BMF2hPVATtulDaH4XnpWQJOL1wru87lHmEXuKLSLqIltwS2Kixc7bMlyxiuEItzYGb5KtNjYVlhZjfpmShjOYtXTYNfXlpsbyCB9Ij0uWMxwdTbQZz7ySrQ9RK7g5V8Lls4MyK3C3KRMWm1HBbtD/EIGEMKjG1n0RvvV2ZAjfuGAK0p34tXF3yCA0EAqn9wlUSuRPI3r86vpBJmV+28FV6IAw2sC/grRHslMxxwQZLiLpG7/b46gpVim8QTOX7X1ZB2Rg32GQxEudn7CWK+BAEt4H8ud/Isr/hcFud8i5xhKXHkAm5/BiilI8Rzx4xlNKW/b+T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102130727099003)(11063799006)(4143699003)(56012099006)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(261009221727099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V29WejBNQ3h2TlY3cXdRVzZFVHRLQ0xSWTJPR0lwV0lYYWhyMlV1RmpPUTlB?=
 =?utf-8?B?bi9vSFBETnRmZWNFem40MndmODFzVit0NTdCdnllUSt5UDlMK0h1cm9rbFU2?=
 =?utf-8?B?WEVLZlZJNGxzdUNURnd6aVBjV1VwbDI5R2prTEFxald1TllNaXVEU3BkRmtB?=
 =?utf-8?B?SE94VFByOS8vTkttZktBWkNrNFNaanlQZnpCN2c1YWVpU2lEb1VrRnY1a1JK?=
 =?utf-8?B?WlBSeVhiYWEvcERSQ0JLZlk5V09WRmNrRTZvb1kxSEdQWStFQkxRa2NSdFNp?=
 =?utf-8?B?VXFoL0xEVVRTM3YxVFVubjAyUCs1Z05CTVkvUTNSUVJhY2IyQ1EwczZnQUd5?=
 =?utf-8?B?cURjUm0xcGhHYUJBUnZTc05LZXI5eDdVa1gvd2JWaFo5d0FFMVFyOEZRdWMy?=
 =?utf-8?B?OTBBdGtjL3dTZDFPcEQrMktzUHFsZE9wbXJ0Z1EwMXQzTjhwTURPbXl2VG1v?=
 =?utf-8?B?dHVpYnEyVzM2MlZkSHFtSDQybU9mNW9sNHhLRjBLZExjeVRKMlBpTzUwQnNt?=
 =?utf-8?B?UEl3Y08zMnRIK1ord05od1NjU25tRzVJb0s4MSt1Qk90YU5nSHZXYzg5Z253?=
 =?utf-8?B?emNldk95N25zTWlrSUxiTm85bm8va2srWWFRaEU2WmM5cjZnRC85Y2RnUUlj?=
 =?utf-8?B?a1lvRHMxTis4SkJNL3B0cDkvSWJnbEIrN09LNUhvNVVPaEVueE1wYVU4UW5o?=
 =?utf-8?B?bUtCbmlIOU1tY3RSVE0vbFVmR0hjV1EydG5aY2c3dmgvY3N1SWZSL2syOFVp?=
 =?utf-8?B?amhZWDNISnRqemVVWVVmK00zWkM3TDc5aEdIbmFTcDdDUzJrZ0dFUWp4U2Fj?=
 =?utf-8?B?TjlmbS9kZGUvQ3JsZCtjb1NuZUVCdkxYTDNlTnFwN1BVbWdlbUk2aUNCSUlT?=
 =?utf-8?B?VGZ6UTV4RXhMcVJOT2lXWjZnaDA3bmIyd1Z4Mnk1VDBYbXZlNHp4RmRiOERG?=
 =?utf-8?B?VW96M3d6dkZaV3k4QnRPWFNST29mcGxTYnMxUGU1SjArNFFxUzIzMWRveDhK?=
 =?utf-8?B?V1FHWnZJemVCR3F6bmN5aXhyckhkaG9MU1VMZU1OWmtKSnJ0SGhEdnpPc3FU?=
 =?utf-8?B?S1QreWhFbTVzL2VkcDJia05SWWdQemZFVnpyaVVOeXFyRW9veXpsSk8yQVZG?=
 =?utf-8?B?Ti96ek9EKzhvYngyaE5rUDYxWTh2RGYycE5FVndBWWtUTEVQeVZuTk5XaXFv?=
 =?utf-8?B?TVJidjlURUFEZzZtSW52SjUzYldNem1teU1STUZVYWFWaGs5YVBJYmR0NktR?=
 =?utf-8?B?cm1TT3IvZTFnTmhOVXVDQXBYTHZ0dWxxTG53MEd2aFl2cmtOZ3d1ekE2WVVn?=
 =?utf-8?B?MnZOSWRjSHhTV252bVlPd21ibm5ObUdEY056NEVWL3ZzSm1DSmRUWlhtcisz?=
 =?utf-8?B?YW9CRWJTY3Vlc0tGRUZOV1F5bnNGcitDbmlqc3pLTjNpTThkN0laek53dXdC?=
 =?utf-8?B?WXQzSWNLeU50b0FwWmFEVkhydmZ4aHFpZzJQVmcxcnJxMEU5bzlQbTVDdzUw?=
 =?utf-8?B?M0phazJJUUNIdFJOZ3RiMnFmSW80d0w4V1pHR2tTa3phYXFybjlYcnRxMExi?=
 =?utf-8?B?emUwUWxmWUFRR3JaLzNkWVQvalZROVB2bGhHaUN3TzB2UDl6QWZLMXJZL1ZZ?=
 =?utf-8?B?YWc3Z08rSHRoTnB4MUFjZ0pMeis2VGZtSWtvajdwc2pHc1VsZmN2b3Zyczkr?=
 =?utf-8?B?WWRIbTlvZVdOVDVhMXFDSVpQQ0c1UDRQcWpIUndyZGhLMW5GUnhFT253Znox?=
 =?utf-8?B?aVZja2VJb3hzR21CUGV5Z0FSQzc4U0VyVmtTRmNxcTNuam1yQ2VMVmZYYm1t?=
 =?utf-8?B?bmRFaXZlSW5VYVd6bHV5cDJxQUEzai9mbnlQdUJqaXJPeTl0ME9UNStsc29q?=
 =?utf-8?B?ZnNiMndNdEhoTHZwcHh1WHEwNWt0ZVZ6a3NpYTdZM2dtY3MvalhQWjlvbkc2?=
 =?utf-8?B?TC80T0t1Q1Q5OVkxbktudk1tOTBldmI5emdPNmdHWDRjeXRXQnFpa2tHVnFB?=
 =?utf-8?B?MG51WmZUMW8xNFBmSWhReENPSlJoRCtuNGRqSjh3NGhvWWl0QUxmQ0J5Yytm?=
 =?utf-8?B?NFE2SmFrM0pFLzg1RFJMakVxNzNBOXAvbGQ0ZUk1Rkl3MmFFRmY0SnBsRmVq?=
 =?utf-8?B?SlVaQXhUc2tnUFJMOUU2bko3WjByUnNHSWc1L1NnTjFtYUZMa0xQeHJSVVNH?=
 =?utf-8?B?WVZvOStkSG4xWGJxNlBEK1hYZkdqZDhJYkRZeksxRXVKdzBvaXI5c201T0M4?=
 =?utf-8?B?U3pCaFQzYjl0SlQ5Zm5UK2YwNmhtbGZtQVF5ZVVHV2hYNmxKdmhxUHFzYjY0?=
 =?utf-8?B?bys4QTZjblA5ZXg5dU8wMUpLZ25JOW8vL1ZhYWN3VUdOZnhweStFdz09?=
X-Exchange-RoutingPolicyChecked: Cy3cGCOejfBaRfS7OKoosKmPq60V0DNC0vRq6lXMcHlkZZ7ruJDJu44EI5s4dov8f6zCBV+08Xab1zROHNU3JNS7qdnhCcQPh2eZ+P19rDI5IwjAbcyVSxtRwDXffOSrk+KEDl60zGywXB6QruUuFpm+Xj2+HCRNnNqZQGuA+sHFxKbxKfLYSv4uX4Ciu9Lwcg+DRXf33CaIc0QTgDaj4YmdoRcEzUJYpGD4bt9JL1ktbGMFYIql+7VE0qwn4WQ6CDwK1t/8hhf8xQYVb+smz0uS/9C0MUM8qev/yYN7Cu2wWtp5ZFipbjdsVRItWHrKdSm42vYZ3MpDQkni8gl+jQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 188d3034-d92a-4dce-ac53-08df4939956a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:12:58.3210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaYeSyUxAh+XkFG4/lILXICwYC0RuBM8tVXQcTmt2rYZkhZ5VL6TEQtcp6IIM9LtDTmIAAe2GhCNVfDCORaj/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
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


On 15-10-2026 03:10, Rodrigo Vivi wrote:
> On Wed, Oct 07, 2026 at 01:33:53PM +0530, Aravind Iddamsetty wrote:
>> The memory page offlining support tracks bad VRAM pages and currently
>> only exposes them through debugfs (vram_bad_pages), which is not a
>> stable ABI. Add a proper userspace interface using the drm-ras
>> generic netlink family.
>>
>> Introduce a new node type DRM_RAS_NODE_TYPE_RETIRED_RESOURCES which
>> enumerates hardware resources that have been permanently taken out of
>> service. Each node reports a single resource type, identified by its
>> node-name, so the resource type is implied by the node rather than
>> carried per entry. The per-entry payload stays extensible: each entry
>> carries a single type-specific nested attribute, so future resource
>> types can be added without touching existing consumers. VRAM pages are
>> the first supported type, reported via the vram-page nest as
>> {address, size, status} where status is one of retired/pending/failed.
>>
>> A single operation is added on the node:
>>   - GET_RETIRED_RESOURCES: dump the resources retired on the node. The
>>     dump opens with a leading capacity summary entry (max-pages
>>     inside the vram-page nest, i.e. the maximum number of pages that
>>     can be offlined, with no address/size/status), followed by one
>>     entry per retired resource. Userspace derives the retired/queued
>>     counts by counting entries.
>>
>> The netlink interface is described by the YAML spec
>> Documentation/netlink/specs/drm_ras.yaml. The following files are
>> generated from that spec with tools/net/ynl/ynl-regen.sh and must not
>> be edited by hand:
>>   - include/uapi/drm/drm_ras.h        (uapi attribute/command enums)
>>   - drivers/gpu/drm/drm_ras_nl.c      (generated policy and op table)
>>   - drivers/gpu/drm/drm_ras_nl.h      (generated declarations)
>>
>> Eg:
>> $ sudo ./tools/net/ynl/pyynl/cli.py \
>>       --spec Documentation/netlink/specs/drm_ras.yaml \
>>       --dump list-nodes
>>
>> [{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name':'correctable-errors',
>>   'node-type': 'error-counter'},
>>   {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name':'uncorrectable-errors
>> ', 'node-type': 'error-counter'},
>>   {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name':'vram-retired-pages',
>>   'node-type': 'retired-resources'}]
>>
>> $ sudo ./tools/net/ynl/pyynl/cli.py --spec \
>> Documentation/netlink/specs/drm_ras.yaml  --dump  get-retired-resources \
>> --json '{"node-id": 2}'
>>
>> [{'node-id': 2, 'vram-page': {'max-pages': 100}},
>>   {'node-id': 2, 'vram-page': {'address': 12807041024, 'size': 4096,
>>   'status': 'retired'}},
>>   {'node-id': 2, 'vram-page': {'address': 12809400320, 'size': 4096,
>>   'status': 'retired'}}]

We should also add device-name in case of multiple cards and the 
resource type

> I wonder if we shouldn't make the max-page a separate do function instead
> of making this 0 entry different from the rest of the dump...

Agreed, we should have a different function for max pages

>> The first entry is the capacity summary (max-pages); subsequent entries
>> are the retired pages.
>>
>> v2:
>>   - Drop the per-entry resource-type discriminator attribute; the type is
>>     now implied by the node (node-name), which reports a single type.
>>   - Fold all VRAM-page fields, including the retirement status, into the
>>     vram-page nested attribute; the top-level entry is just
>>     {node-id, vram-page}. (Rodrigo)
>>   - Drop the separate GET_RETIRED_RESOURCES_INFO operation. The capacity
>>     (max-pages) is now emitted as a leading summary entry inside
>>     GET_RETIRED_RESOURCES (max-pages in the vram-page nest, no status);
>>     offlined/queued counts are derived by counting entries.
>>
>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Riana Tauro <riana.tauro@intel.com>
>> Cc: Raag Jadav <raag.jadav@intel.com>
>> Cc: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>
>> Cc: Ashwin Kumar Kulkarni <ashwin.kumar.kulkarni@intel.com>
>> Cc: Pratik Bari <pratik.bari@intel.com>
>>
>> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
>> Assisted-by: Copilot:claude-opus-4.8
>> ---
>>   Documentation/netlink/specs/drm_ras.yaml |  91 +++++++++++-
>>   drivers/gpu/drm/drm_ras.c                | 174 ++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_ras_nl.c             |  12 ++
>>   drivers/gpu/drm/drm_ras_nl.h             |   2 +
>>   drivers/gpu/drm/xe/xe_drm_ras.c          |  77 ++++++++++
>>   drivers/gpu/drm/xe/xe_drm_ras_types.h    |   3 +
>>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     | 119 ++++++++++++++++
>>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   3 +
>>   include/drm/drm_ras.h                    |  74 ++++++++++
>>   include/uapi/drm/drm_ras.h               |  48 ++++++-
>>   10 files changed, 592 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>> index 4c2ac9a1ba3f..42ab1cceaea7 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -16,11 +16,34 @@ definitions:
>>       type: enum
>>       name: node-type
>>       value-start: 1
>> -    entries: [error-counter]
>> +    entries: [error-counter, retired-resources]
>>       doc: >-
>> -         Type of the node. Currently, only error-counter nodes are
>> -         supported, which expose reliability counters for a hardware/software
>> -         component.
>> +         Type of the node.
>> +         error-counter nodes expose reliability counters for a
>> +         hardware/software component. retired-resources nodes enumerate
>> +         hardware resources (e.g. VRAM pages) that have been permanently
>> +         taken out of service.
>> +  -
>> +    type: enum
>> +    name: retired-resource-status
>> +    value-start: 0
> perhaps we should start at 1 like node-type so a zeroed default value
> is not valid?!
>
>> +    entries: [retired, pending, failed]
>> +    doc: >-
>> +         Status of a retired resource entry. retired means the resource is
>> +         permanently reserved and out of service; pending means retirement is
>> +         queued but the reservation is not yet complete; failed means the
>> +         reservation failed and the resource may still be in use.

we can have some resources only retired for a particular duration or 
till another indication.
  Do we need a separate status for temporary or can we re-use retired 
for such cases?

>> +  -
>> +    type: enum
>> +    name: retired-resource-type
>> +    value-start: 1
>> +    entries: [vram-page]
>> +    doc: >-
>> +         Type of a retired resource entry. The type selects which type-specific
>> +         nested attribute is present. New hardware resource types can be added
>> +         here, each carrying its own nested attribute set, without affecting
>> +         existing types. vram-page describes a VRAM page by device address and
>> +         size.
> Deserves documentation saying that this is for future extensibility, while
> for now the only supported type is vram-page, like we did with the type...
>
>>   
>>   attribute-sets:
>>     -
>> @@ -100,6 +123,45 @@ attribute-sets:
>>           name: error-value
>>           type: u32
>>           doc: Current value of the error counter.
>> +  -
>> +    name: retired-resource-attrs
>> +    attributes:
>> +      -
>> +        name: node-id
>> +        type: u32
>> +        doc: Node ID targeted by this retired resource operation.
>> +      -
>> +        name: vram-page
>> +        type: nest
>> +        nested-attributes: vram-page-attrs
>> +        doc: >-
>> +             Type-specific payload. The resource type is identified by the
>> +             node (its node-name); each node reports a single resource type.

Do we need this set?

>> +  -
>> +    name: vram-page-attrs
>> +    attributes:
>> +      -
>> +        name: address
>> +        type: u64
>> +        doc: Device address of the retired VRAM page (e.g. DPA).
>> +      -
>> +        name: size
>> +        type: u64
>> +        doc: Size of the retired VRAM page in bytes.
>> +      -
>> +        name: max-pages
>> +        type: u32
>> +        doc: >-
>> +             Maximum VRAM pages that can be retired. Present only in the
>> +             leading summary entry of the dump (no address/size/status).
>> +      -
>> +        name: status
>> +        type: u32
>> +        doc: Retirement status of the retired VRAM page.
>> +        enum: retired-resource-status
>> +      -
>> +        name: pad
>> +        type: pad
>>   
>>   operations:
>>     list:
>> @@ -199,6 +261,27 @@ operations:
>>               - node-id
>>               - error-id
>>               - error-threshold
>> +    -
>> +      name: get-retired-resources
>> +      doc: >-
>> +           Enumerate the resources (e.g. VRAM pages) that a retired-resources
>> +           node has taken out of service. The dump begins with a leading
>> +           capacity summary entry (max-pages, with no address/size/status),
>> +           followed by one entry per retired resource (address, size and a
>> +           retirement status). The resource type is identified by the node
>> +           (its node-name); each node reports a single type. User space
>> +           derives the retired/queued counts by counting entries, and must
>> +           obtain the node ID from list-nodes first.
>> +      attribute-set: retired-resource-attrs
>> +      flags: [admin-perm]
>> +      dump:
>> +        request:
>> +          attributes:
>> +            - node-id
>> +        reply:
>> +          attributes:
>> +            - node-id
>> +            - vram-page

How can this be reused for other resources if the response has a 
specific type?
Shouldn't it be generic or the function name different?

Thanks
Riana


>>   
>>   mcast-groups:
>>     list:
>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>> index b099eb67836e..46ee897a13c9 100644
>> --- a/drivers/gpu/drm/drm_ras.c
>> +++ b/drivers/gpu/drm/drm_ras.c
>> @@ -63,7 +63,6 @@
>>    * Node type:
>>    *
>>    * - ERROR_COUNTER:
>> - *     + Currently, only error counters are supported.
>>    *     + The driver must implement the query_error_counter() callback to provide
>>    *       the name and the value of the error counter.
>>    *     + The driver must provide a error_counter_range.last value informing the
>> @@ -81,6 +80,13 @@
>>    *       that are raised by the hardware.
>>    *     + The driver is responsible for error threshold bounds checking.
>>    *
>> + * - RETIRED_RESOURCES:
>> + *     + Enumerates hardware resources (e.g. VRAM pages) permanently taken out
>> + *       of service.
>> + *     + The driver must implement the query_retired_resource() callback, which
>> + *       is called with an incrementing index and returns -ENOENT once the last
>> + *       entry has been reported.
>> + *
>>    * Netlink handlers:
>>    *
>>    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
>> @@ -95,6 +101,9 @@
>>    *   operation, fetching the error threshold of a specific counter.
>>    * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
>>    *   operation, setting the error threshold of a specific counter.
>> + * - drm_ras_nl_get_retired_resources_dumpit(): Implements the
>> + *   GET_RETIRED_RESOURCES dumpit operation, enumerating retired resources of a
>> + *   specific node.
>>    */
>>   
>>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>> @@ -105,6 +114,10 @@ static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>>   struct drm_ras_ctx {
>>   	/* Which xarray id to restart the dump from */
>>   	unsigned long restart;
>> +	/* Ordering-key cursor for retired-resource dumps (inclusive lower bound) */
>> +	u64 cursor;
>> +	/* Whether the leading retired-resource summary has been emitted */
>> +	bool summary_sent;
>>   };
>>   
>>   /**
>> @@ -564,6 +577,148 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>   	return node->clear_error_counter(node, error_id);
>>   }
>>   
>> +static int msg_put_retired_resource(struct sk_buff *skb, u32 node_id,
>> +				    const struct drm_ras_retired_resource *res)
>> +{
>> +	struct nlattr *nest;
>> +
>> +	if (nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID, node_id))
>> +		return -EMSGSIZE;
>> +
>> +	/* Type is implied by the node (its node_name); it selects the nest. */
>> +	switch (res->type) {
>> +	case DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE:
>> +		nest = nla_nest_start(skb,
>> +				      DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE);
>> +		if (!nest)
>> +			return -EMSGSIZE;
>> +
>> +		if (res->is_summary) {
>> +			/* Leading capacity summary: max retirable pages. */
>> +			if (nla_put_u32(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_MAX_PAGES,
>> +					res->vram_page.max_pages)) {
>> +				nla_nest_cancel(skb, nest);
>> +				return -EMSGSIZE;
>> +			}
>> +		} else if (nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS,
>> +					     res->vram_page.address,
>> +					     DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
>> +			   nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
>> +					     res->vram_page.size,
>> +					     DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
>> +			   nla_put_u32(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_STATUS,
>> +				       res->status)) {
>> +			nla_nest_cancel(skb, nest);
>> +			return -EMSGSIZE;
>> +		}
>> +
>> +		nla_nest_end(skb, nest);
>> +		break;
>> +	default:
>> +		/* Unknown type: only the common node-id is reported. */
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * drm_ras_nl_get_retired_resources_dumpit() - Dump retired resources of a node
>> + * @skb: Netlink message buffer
>> + * @cb: Callback context for multi-part dumps
>> + *
>> + * Iterates over all retired resources of a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES
>> + * node and appends their attributes to the given netlink message buffer. The
>> + * dump opens with an optional leading type-specific capacity summary (e.g. the
>> + * maximum retirable page count), followed by one entry per retired resource;
>> + * each resource entry carries a status plus one type-specific nested attribute
>> + * selected by the node's type. Uses @cb->ctx to store an ordering-key cursor
>> + * so multi-part dumps resume by key rather than position, staying correct if
>> + * the list changes concurrently between message parts.
>> + *
>> + * Return: 0 if all entries fit in @skb, number of bytes added to @skb if
>> + *          the buffer filled up (requires multi-part continuation), or
>> + *          a negative error code on failure.
>> + */
>> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
>> +					    struct netlink_callback *cb)
>> +{
>> +	const struct genl_info *info = genl_info_dump(cb);
>> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
>> +	struct drm_ras_retired_resource res;
>> +	struct drm_ras_node *node;
>> +	struct nlattr *hdr;
>> +	u32 node_id;
>> +	u64 cursor;
>> +	int ret = 0;
>> +
>> +	if (!info->attrs ||
>> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID))
>> +		return -EINVAL;
>> +
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID]);
>> +
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_RESOURCES ||
>> +	    !node->query_retired_resource)
>> +		return -ENOENT;
>> +
>> +	/* Leading type-specific capacity summary (e.g. max pages), emitted once. */
>> +	if (!ctx->summary_sent && node->query_retired_summary) {
>> +		memset(&res, 0, sizeof(res));
>> +		ret = node->query_retired_summary(node, &res);
>> +		if (ret == 0) {
>> +			hdr = genlmsg_iput(skb, info);
>> +			if (!hdr)
>> +				return -EMSGSIZE;   /* retry summary next part */
>> +			ret = msg_put_retired_resource(skb, node_id, &res);
>> +			if (ret) {
>> +				genlmsg_cancel(skb, hdr);
>> +				return ret;
>> +			}
>> +			genlmsg_end(skb, hdr);
>> +		} else if (ret != -ENOENT) {
>> +			return ret;
>> +		}
>> +		ctx->summary_sent = true;
>> +	}
>> +
>> +	cursor = ctx->cursor;
>> +	for (;;) {
>> +		memset(&res, 0, sizeof(res));
>> +		ret = node->query_retired_resource(node, cursor, &res);
> According to https://raw.githubusercontent.com/masoncl/review-prompts/refs/heads/main/kernel/subsystem/netlink.md
>
> ## Dumps
>
> - If iteration during a dump may skip or repeat objects (e.g. due to lockless
>    data structures), set `NLM_F_DUMP_INTR` on the affected message(s).
>    This is normally implemented by maintaining a generation counter and
>    recording it in `netlink_callback.seq`.
>
>
> so, it looks like our list can change between dump parts...
>
> we should take a look into nl_dump_check_consistent() and cb->seq users
>
> could you please check this?
>
>> +		/* -ENOENT marks the end of the list. */
>> +		if (ret == -ENOENT) {
>> +			ret = 0;
>> +			break;
>> +		}
>> +		if (ret)
>> +			return ret;
>> +
>> +		hdr = genlmsg_iput(skb, info);
>> +		if (!hdr) {
>> +			ret = -EMSGSIZE;
>> +			break;
>> +		}
>> +
>> +		ret = msg_put_retired_resource(skb, node_id, &res);
>> +		if (ret) {
>> +			genlmsg_cancel(skb, hdr);
>> +			break;
>> +		}
>> +
>> +		genlmsg_end(skb, hdr);
>> +		/* Advance past this entry; keys are unique. */
>> +		cursor = res.key + 1;
>> +	}
>> +
>> +	/* On buffer-full the current entry was not emitted; resume at it. */
>> +	if (ret == -EMSGSIZE)
>> +		ctx->cursor = cursor;
>> +
>> +	return ret;
>> +}
>> +
>>   /**
>>    * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
>>    * @skb: Netlink message buffer
>> @@ -631,15 +786,24 @@ int drm_ras_node_register(struct drm_ras_node *node)
>>   	if (!node->device_name || !node->node_name)
>>   		return -EINVAL;
>>   
>> -	/* Currently, only Error Counter Endpoints are supported */
>> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
>> -		return -EINVAL;
>> -
>>   	/* Mandatory entries for Error Counter Node */
>>   	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
>>   	    (!node->error_counter_range.last || !node->query_error_counter))
>>   		return -EINVAL;
>>   
>> +	/* Mandatory entries for Retired Resources Node */
>> +	if (node->type == DRM_RAS_NODE_TYPE_RETIRED_RESOURCES &&
>> +	    !node->query_retired_resource)
>> +		return -EINVAL;
>> +
>> +	switch (node->type) {
>> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
>> +	case DRM_RAS_NODE_TYPE_RETIRED_RESOURCES:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>>   	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>>   }
>>   EXPORT_SYMBOL(drm_ras_node_register);
>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>> index c9f5e0ceb3b5..2f23f5681fa4 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.c
>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>> @@ -41,6 +41,11 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
>>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
>>   };
>>   
>> +/* DRM_RAS_CMD_GET_RETIRED_RESOURCES - dump */
>> +static const struct nla_policy drm_ras_get_retired_resources_nl_policy[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID + 1] = {
>> +	[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID] = { .type = NLA_U32, },
>> +};
>> +
>>   /* Ops table for drm_ras */
>>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   	{
>> @@ -83,6 +88,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>   	},
>> +	{
>> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_RESOURCES,
>> +		.dumpit		= drm_ras_nl_get_retired_resources_dumpit,
>> +		.policy		= drm_ras_get_retired_resources_nl_policy,
>> +		.maxattr	= DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID,
>> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>> +	},
>>   };
>>   
>>   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>> index 9aef097ea10f..96b0fe017ea8 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.h
>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>> @@ -24,6 +24,8 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>>   int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
>> +					    struct netlink_callback *cb);
>>   
>>   enum {
>>   	DRM_RAS_NLGRP_ERROR_REPORT,
>> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
>> index 7f3695707611..fba58e9eb7e0 100644
>> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
>> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
>> @@ -12,6 +12,7 @@
>>   #include "xe_device_types.h"
>>   #include "xe_drm_ras.h"
>>   #include "xe_ras.h"
>> +#include "xe_ttm_vram_mgr.h"
>>   
>>   static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
>>   static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
>> @@ -188,6 +189,75 @@ static void cleanup_node(struct drm_device *drm, void *node)
>>   	cleanup_node_param(node);
>>   }
>>   
>> +static int query_retired_resource(struct drm_ras_node *node, u64 cursor,
>> +				  struct drm_ras_retired_resource *res)
>> +{
>> +	struct xe_device *xe = node->priv;
>> +	int ret;
>> +
>> +	ret = xe_ttm_vram_get_retired_page(xe, cursor, &res->vram_page.address,
>> +					   &res->vram_page.size, &res->status);
>> +	if (ret)
>> +		return ret;
>> +
>> +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
>> +	res->key = res->vram_page.address;
>> +
>> +	return 0;
>> +}
>> +
>> +static int query_retired_summary(struct drm_ras_node *node,
>> +				 struct drm_ras_retired_resource *res)
>> +{
>> +	struct xe_device *xe = node->priv;
>> +
>> +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
>> +	res->is_summary = 1;
>> +	res->vram_page.max_pages = xe_ttm_vram_get_max_bad_pages(xe);
>> +
>> +	return 0;
>> +}
>> +
>> +static int register_retired_node(struct xe_device *xe)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> +	struct xe_drm_ras *ras = &xe->ras;
>> +	struct drm_ras_node *node;
>> +	const char *device_name;
>> +	int ret;
>> +
>> +	/* Retired VRAM pages are only tracked on platforms with page offline */
>> +	if (xe->info.platform != XE_CRESCENTISLAND)
>> +		return 0;
>> +
>> +	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return -ENOMEM;
>> +
>> +	device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
>> +				pci_domain_nr(pdev->bus), pdev->bus->number,
>> +				PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +	if (!device_name)
>> +		return -ENOMEM;
>> +
>> +	node->device_name = device_name;
>> +	node->node_name = "vram-retired-pages";
>> +	node->type = DRM_RAS_NODE_TYPE_RETIRED_RESOURCES;
>> +	node->query_retired_resource = query_retired_resource;
>> +	node->query_retired_summary = query_retired_summary;
>> +	node->priv = xe;
>> +
>> +	ret = drm_ras_node_register(node);
>> +	if (ret) {
>> +		cleanup_node_param(node);
>> +		return ret;
>> +	}
>> +
>> +	ras->retired_node = node;
>> +
>> +	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
>> +}
>> +
>>   static int register_nodes(struct xe_device *xe)
>>   {
>>   	struct xe_drm_ras *ras = &xe->ras;
>> @@ -279,5 +349,12 @@ int xe_drm_ras_init(struct xe_device *xe)
>>   		return err;
>>   	}
>>   
>> +	err = register_retired_node(xe);
>> +	if (err) {
>> +		drm_err(&xe->drm, "Failed to register DRM RAS retired node (%pe)\n",
>> +			ERR_PTR(err));
>> +		return err;
>> +	}
>> +
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_drm_ras_types.h b/drivers/gpu/drm/xe/xe_drm_ras_types.h
>> index 0be218ba2db7..186024640f87 100644
>> --- a/drivers/gpu/drm/xe/xe_drm_ras_types.h
>> +++ b/drivers/gpu/drm/xe/xe_drm_ras_types.h
>> @@ -41,6 +41,9 @@ struct xe_drm_ras {
>>   	/** @node: DRM RAS node */
>>   	struct drm_ras_node *node;
>>   
>> +	/** @retired_node: DRM RAS retired-resources node for VRAM bad pages */
>> +	struct drm_ras_node *retired_node;
>> +
>>   	/** @info: info array for all types of errors */
>>   	struct xe_drm_ras_counter *info[DRM_XE_RAS_ERR_SEV_MAX];
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>> index 9a514d983e90..b56b543a56a2 100644
>> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>> @@ -15,6 +15,8 @@
>>   #include <drm/ttm/ttm_placement.h>
>>   #include <drm/ttm/ttm_range_manager.h>
>>   
>> +#include <uapi/drm/drm_ras.h>
>> +
>>   #include "regs/xe_regs.h"
>>   #include "xe_bo.h"
>>   #include "xe_configfs.h"
>> @@ -624,6 +626,123 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
>>   	return avail;
>>   }
>>   
>> +/**
>> + * xe_ttm_vram_get_retired_page - Fetch the next retired VRAM page by address
>> + * @xe: xe device instance
>> + * @min_addr: inclusive lower bound; return the page with the smallest DPA >=
>> + *            this value
>> + * @addr: output, device physical address (DPA) of the page
>> + * @size: output, size of the page in bytes
>> + * @status: output, retirement status (enum drm_ras_retired_resource_status)
>> + *
>> + * Scans the offlined and queued page lists across all tiles and returns the
>> + * entry with the smallest DPA that is >= @min_addr. Because retired pages have
>> + * unique addresses, iterating with @min_addr = previous_addr + 1 walks every
>> + * entry in a stable address order, which is robust against concurrent
>> + * insertion or removal between calls. Intended to back the drm-ras
>> + * retired-resources node enumeration.
>> + *
>> + * Return: 0 on success, -ENOENT when no page has a DPA >= @min_addr.
>> + */
>> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
>> +				 u64 *addr, u64 *size, u32 *status)
>> +{
>> +	struct xe_ttm_vram_offline_resource *pos;
>> +	struct ttm_resource_manager *man;
>> +	struct gpu_buddy_block *block;
>> +	struct xe_ttm_vram_mgr *mgr;
>> +	u64 best_addr = 0, best_size = 0;
>> +	struct xe_tile *tile;
>> +	u32 best_status = 0;
>> +	bool found = false;
>> +	u8 id;
>> +
>> +	for_each_tile(tile, xe, id) {
>> +		struct xe_vram_region *vr = tile->mem.vram;
>> +		u64 a, s;
>> +
>> +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
>> +		if (!man || !vr)
>> +			continue;
>> +		mgr = to_xe_ttm_vram_mgr(man);
>> +
>> +		rcu_read_lock();
>> +
>> +		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {
>> +			block = list_first_entry_or_null(&pos->blocks,
>> +							 struct gpu_buddy_block, link);
>> +			if (block) {
>> +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
>> +				s = gpu_buddy_block_size(&mgr->mm, block);
>> +			} else {
>> +				a = pos->addr + vr->dpa_base;
>> +				s = SZ_4K;
>> +			}
>> +
>> +			if (a >= min_addr && (!found || a < best_addr)) {
>> +				best_addr = a;
>> +				best_size = s;
>> +				best_status = DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED;
>> +				found = true;
>> +			}
>> +		}
>> +
>> +		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
>> +			block = list_first_entry_or_null(&pos->blocks,
>> +							 struct gpu_buddy_block, link);
>> +			if (block) {
>> +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
>> +				s = gpu_buddy_block_size(&mgr->mm, block);
>> +			} else {
>> +				a = pos->addr + vr->dpa_base;
>> +				s = SZ_4K;
>> +			}
>> +
>> +			if (a >= min_addr && (!found || a < best_addr)) {
>> +				best_addr = a;
>> +				best_size = s;
>> +				best_status = pos->status == XE_PAGE_RESERVE_FAIL ?
>> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED :
>> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING;
>> +				found = true;
>> +			}
>> +		}
>> +
>> +		rcu_read_unlock();
>> +	}
>> +
>> +	if (!found)
>> +		return -ENOENT;
>> +
>> +	*addr = best_addr;
>> +	*size = best_size;
>> +	*status = best_status;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * xe_ttm_vram_get_max_bad_pages - Fetch the FW-provided max offline page count
>> + * @xe: xe device instance
>> + *
>> + * Returns the static maximum number of VRAM pages that can be offlined, as
>> + * provided by FW at init. Intended to back the drm-ras retired-resources
>> + * capacity summary. Read from the root (VRAM0) manager; the value is a static
>> + * device-wide count.
>> + *
>> + * Return: max offline page count, or 0 if VRAM is not present.
>> + */
>> +u32 xe_ttm_vram_get_max_bad_pages(struct xe_device *xe)
>> +{
>> +	struct ttm_resource_manager *man;
>> +
>> +	man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0);
>> +	if (!man)
>> +		return 0;
>> +
>> +	return to_xe_ttm_vram_mgr(man)->max_pages;
>> +}
>> +
>>   static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
>>   {
>>   	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
>> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
>> index d77f067d197b..70fae023d6a3 100644
>> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
>> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
>> @@ -33,6 +33,9 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
>>   			  u64 *used, u64 *used_visible);
>>   int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
>>   int xe_ttm_vram_inject_fault(struct xe_device *xe);
>> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
>> +				 u64 *addr, u64 *size, u32 *status);
>> +u32 xe_ttm_vram_get_max_bad_pages(struct xe_device *xe);
>>   
>>   static inline struct xe_ttm_vram_mgr_resource *
>>   to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index 1765a3130b09..38953f8f3012 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -10,6 +10,42 @@
>>   
>>   #include <uapi/drm/drm_ras.h>
>>   
>> +/**
>> + * struct drm_ras_retired_resource - A single retired resource entry
>> + *
>> + * Describes one hardware resource that has been taken out of service and is
>> + * reported by a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. @type selects which
>> + * member of the anonymous union is valid, allowing new hardware resource types
>> + * to be added without changing the common fields. When @is_summary is set the
>> + * entry is a leading, type-specific capacity summary (e.g. max retirable
>> + * pages) rather than an individual retired resource.
>> + */
>> +struct drm_ras_retired_resource {
>> +	/** @type: Resource type (enum drm_ras_retired_resource_type). */
>> +	__u32 type;
>> +	/** @status: Retirement status (enum drm_ras_retired_resource_status). */
>> +	__u32 status;
>> +	/**
>> +	 * @key: Opaque, driver-assigned ordering key for this entry. drm-ras
>> +	 * uses it only to advance the dump cursor; entries must be enumerable
>> +	 * in strictly increasing @key order and keys must be unique.
>> +	 */
>> +	__u64 key;
>> +	/** @is_summary: entry reports type capacity, not a retired resource. */
>> +	__u8 is_summary;
>> +	union {
>> +		/** @vram_page: Valid when @type is VRAM_PAGE. */
>> +		struct {
>> +			/** @vram_page.address: Device address (e.g. DPA). */
>> +			__u64 address;
>> +			/** @vram_page.size: Size in bytes. */
>> +			__u64 size;
>> +			/** @vram_page.max_pages: max retirable pages; summary only. */
>> +			__u32 max_pages;
>> +		} vram_page;
>> +	};
>> +};
>> +
>>   /**
>>    * struct drm_ras_node - A DRM RAS Node
>>    */
>> @@ -100,6 +136,44 @@ struct drm_ras_node {
>>   	 */
>>   	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
>>   
>> +	/**
>> +	 * @query_retired_resource:
>> +	 *
>> +	 * This callback is used by drm-ras to enumerate retired resources of a
>> +	 * %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. It is called with @cursor
>> +	 * and must return the next entry whose ordering key is greater than or
>> +	 * equal to @cursor, setting @res->key to that entry's key. drm-ras
>> +	 * resumes multi-part dumps from the returned key, so enumeration stays
>> +	 * correct across concurrent insertion or removal.
>> +	 *
>> +	 * The @query_retired_resource is a mandatory callback for
>> +	 * retired-resources nodes.
>> +	 *
>> +	 * Returns: 0 on success,
>> +	 *          -ENOENT when no entry has a key >= @cursor, used as an
>> +	 *                  indication that enumeration is complete.
>> +	 *          Other negative values on errors that should terminate the
>> +	 *          netlink query.
>> +	 */
>> +	int (*query_retired_resource)(struct drm_ras_node *node, u64 cursor,
>> +				      struct drm_ras_retired_resource *res);
>> +
>> +	/**
>> +	 * @query_retired_summary:
>> +	 *
>> +	 * This optional callback fills a leading, type-specific capacity summary
>> +	 * for a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node (e.g. the maximum
>> +	 * number of retirable pages). drm-ras emits it as the first entry of the
>> +	 * retired-resources dump. The driver must set @res->is_summary, @res->type
>> +	 * and the type-specific summary fields (e.g. vram_page.max_pages).
>> +	 *
>> +	 * Returns: 0 on success,
>> +	 *          -ENOENT if the node has no summary to report,
>> +	 *          other negative values on errors that terminate the query.
>> +	 */
>> +	int (*query_retired_summary)(struct drm_ras_node *node,
>> +				     struct drm_ras_retired_resource *res);
>> +
>>   	/** @priv: Driver private data */
>>   	void *priv;
>>   };
>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>> index 2f832275ee6e..64a7a7feb610 100644
>> --- a/include/uapi/drm/drm_ras.h
>> +++ b/include/uapi/drm/drm_ras.h
>> @@ -11,11 +11,35 @@
>>   #define DRM_RAS_FAMILY_VERSION	1
>>   
>>   /*
>> - * Type of the node. Currently, only error-counter nodes are supported, which
>> - * expose reliability counters for a hardware/software component.
>> + * Type of the node. error-counter nodes expose reliability counters for a
>> + * hardware/software component. retired-resources nodes enumerate hardware
>> + * resources (e.g. VRAM pages) that have been permanently taken out of service.
>>    */
>>   enum drm_ras_node_type {
>>   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
>> +	DRM_RAS_NODE_TYPE_RETIRED_RESOURCES,
>> +};
>> +
>> +/*
>> + * Status of a retired resource entry. retired means the resource is
>> + * permanently reserved and out of service; pending means retirement is queued
>> + * but the reservation is not yet complete; failed means the reservation failed
>> + * and the resource may still be in use.
>> + */
>> +enum drm_ras_retired_resource_status {
>> +	DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED,
>> +	DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING,
>> +	DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED,
>> +};
>> +
>> +/*
>> + * Type of a retired resource entry. The type selects which type-specific
>> + * nested attribute is present. New hardware resource types can be added here,
>> + * each carrying its own nested attribute set, without affecting existing
>> + * types. vram-page describes a VRAM page by device address and size.
>> + */
>> +enum drm_ras_retired_resource_type {
>> +	DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE = 1,
>>   };
>>   
>>   enum {
>> @@ -51,6 +75,25 @@ enum {
>>   	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>>   };
>>   
>> +enum {
>> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID = 1,
>> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE,
>> +
>> +	__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX,
>> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX - 1)
>> +};
>> +
>> +enum {
>> +	DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS = 1,
>> +	DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
>> +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX_PAGES,
>> +	DRM_RAS_A_VRAM_PAGE_ATTRS_STATUS,
>> +	DRM_RAS_A_VRAM_PAGE_ATTRS_PAD,
>> +
>> +	__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX,
>> +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX = (__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX - 1)
>> +};
>> +
>>   enum {
>>   	DRM_RAS_CMD_LIST_NODES = 1,
>>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>> @@ -58,6 +101,7 @@ enum {
>>   	DRM_RAS_CMD_ERROR_EVENT,
>>   	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>>   	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>> +	DRM_RAS_CMD_GET_RETIRED_RESOURCES,
>>   
>>   	__DRM_RAS_CMD_MAX,
>>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>> -- 
>> 2.25.1
>>
