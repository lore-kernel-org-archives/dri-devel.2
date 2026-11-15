Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368D606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M3L3WXbD;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NVjUzTAR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7553E10E057;
	Sun, 15 Nov 2026 15:53:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C850810E1C9;
 Sun, 15 Nov 2026 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794758024; x=1826294024;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TYK8Ztsc/yvaRUy2ocRhUfGKUz7H6PHyTS9hPmIUxkM=;
 b=M3L3WXbDU1xv35ihJ9rUmoWPlZ9uPhgKHiT91cn5yY+fwGZqx9rKr+3w
 tQ+o3OGsSBlK+6ohDkVhrMdVt6H/MuEV9FoBd/5E1M2GWhvS/nXZnWxyA
 +iwcOEgjXaNqHJSzAiFEtgjkq8Rbz8zHA97dTSb7Y5uChFPd2EqlztCDB
 et/mfc1JfT4ohMGAXeppoyCjznBf1f5P1xM6dNEwXoaIp2w4g+RyEh7sd
 WBAfhK5geS5NhUH+vM1Y3VpmD4M8MnS0cFdki+t90ljf6owyFta/xVZSq
 v0+Yv6gPV2aAXKTOQ1PSPNyEwmGYkDyGqL477ElsWbYWzqIwVkdnFaSYu Q==;
X-CSE-ConnectionGUID: bSsw9bBlShiWrJJ+yGl+gQ==
X-CSE-MsgGUID: fB8+lyADQWyGx1S8e9ehug==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3370023"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3370023"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 07:53:43 -0800
X-CSE-ConnectionGUID: EPpjUXw6TUGCBMYg68ySSQ==
X-CSE-MsgGUID: JznAibeETBa2LfQaDkFjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9600067"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 07:53:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 07:53:42 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 07:53:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 07:53:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arUgLO41cB+65FZbV0eXue4Z0Sm+OQlQ+00er8u5ESvHKj9zuSZmjfkqLwYWzb9vPUI//vOtU9ab9pW+Gj0VQJw1S4zEIHc6qK3mlrZgas9M2R7vc3fV6hMYk/6mk07EB074n+qaG7C43j40Kg84t5cNZQBjsvbGgklz+znNeD38MGc35lG1vDASb/bGP5YnGpxbkgYchALs8JLLGyHU7WuhJ0NjXgx0qnMF+rHf6peGJHXq7kshApotU0Zh5hBDvl2VSlx1F74Hbd+EKJQMMIofosczJ84AOD2DoVgnpFbmWaY5L0WKtfsKfWBTGIy8juyYWooQdWFW4/vL8xwtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Eo4but+tMxf4R6PNHoz9cnBV6HPdPEAkH5vJu1rAU=;
 b=t/ERDsT14FFSiuERH+3kAWwHWmCxDtMsodSOpFTZDlqSyFR5wMZmqdYZfCAG008MFMr3BBxtuWnIhepTFk8yOXl13OqorSCXWnGIdRPyeuiTG6+mvwEoDs6DH56a1lJAkdsUdA+yYFIg8AovTagda63ams8Hmo5/Ge1eejVACJ9GV327etMSbfDrcD8T+10DyfVc2Rt7GfeFY1sYTN+sEB7uUCMiXlXFwF0A1qKeMUdBN2qJ2OOJ2ZaZyJkVeepmRpCKif6l2DvMgWhiQdirsEKkj2rR/CdRzzJkBT9CErr5wsUH3+nH0NNgEgghE2jfodlEHNVODDXvPOMkwA5+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0Eo4but+tMxf4R6PNHoz9cnBV6HPdPEAkH5vJu1rAU=;
 b=NVjUzTARytCsLznwQ6l9ja3IfQuT4JjDN4F4MsNNowSeoz9Y6PAKu8I3QMiziDc7De7amIPMD0qoaRkhCBNEKylYVM0aT0l2ynLfVqARVqqWTE5u8AAkvOduadON+XV8FHn2srzM/6v6dlJQljCQ9Upup4QW7FBsiVJ8nrIFYbA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by CO1PR11MB4802.namprd11.prod.outlook.com (2603:10b6:303:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 15:53:33 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 15:53:33 +0000
Message-ID: <91f03c24-2bee-4872-bf09-ca54f81ccf50@intel.com>
Date: Sun, 15 Nov 2026 21:23:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 <dri-devel@lists.freedesktop.org>, William Palacek <William.Palacek@amd.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::16) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|CO1PR11MB4802:EE_
X-MS-Office365-Filtering-Correlation-Id: 7263dd65-c941-4890-9662-08df433099cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|5023799004|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|7136999003|18002099003|22082099003|11062099010;
X-Microsoft-Antispam-Message-Info: Yzoy4oL/JiEwbLcSdNXdvOGH7gXygWM12XrROi5iYgZTAn0FHM+aNHxeGGGziN4vPqE3zWL7fnUeGwgp+psnhMQIPND76Z8xtDSJHfMRuLVHcbWuVPol7T8bsigEuQoHXLV9X9khFH316ynmLLAACVjRk5FQPaOqWCOj+S2AJ19ABiUkqSqRlQXPaLIsfk/Sgyy/AsAj/tRMbYSZfWQ11J8wrYXtvznBymaMFTM8xF1gHYJhNqY/3tzIXO3KLzmL5RGE59mJ8tg1ZjmGVU9v6uK03K2tVZshb7Wa5LUsdzKBfvQm2D5/Xc455XEq2lUFyWcw83YVb+gHSEHGUrka3EYzPxwYJbpKi3oRg6p5d+mvhihG7bakppwsJuKSqUZUE9Oos0Lm4s5FmMDbTntEe677Vu2C/8ByxR/4M80JvjdICwVgMbNWriWBgTiF53r/G6y9fLSz50TeUirT1TypKg2WVz9I+BlZ7iJd3j0lYT/D93k9skEFr+0x5FbvyPh46XG9xYab+fXUnWkuT3TuW5+DyGwK0yuckNw5hK+/5UcMM2fi6Qx9i3SUNKAmDHpYWvf9g8o5sYRdULvcc8pUF673uTEZaDEc0NnlQw1/2nYbxjAo5OxMMGtkJTqzV3y2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(7136999003)(18002099003)(22082099003)(11062099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTh4ODRrYkorcFJGTnV1enlqZGFTam9NSVRmTWZpYlhTUmR3ckQvc0plQ0ZJ?=
 =?utf-8?B?bTF1NktjWXZrb3JxVC9nUUFWaWtqUVNWQ2k0UFNIV3QvcDdCSEVuTUwrQldw?=
 =?utf-8?B?U2F2ZWkzb0ZuWnQ4ZGRaay9yOGMydTJsNGZDSEk1UWpFM2VCOFFKcVZJZlBu?=
 =?utf-8?B?TUdGOTlNRkZYa0RrOVVmT1RKbGV0VU1lcUlGU2htWlNWUXh1RGlMWDN2OUh6?=
 =?utf-8?B?T3QwZzR3Yjc2enArSGcyQU9NT0ZxUkJzNUs0b3hENlFyTCtBaUxzdXBMdzNV?=
 =?utf-8?B?UVQwaFp1Mi96RkpBb253Z0dEenkzRTZjVW4vc3ZmVFV2Zm5DTXVWSWI1anIw?=
 =?utf-8?B?YnA1UVUvazJodzVJeWtzb3F3NElqVWtNM3Y2anlXQUl2UGxEWFlvbVNHK1Ju?=
 =?utf-8?B?OUQzNlBLaC9UcTRVdGFSUFFNRnYvSjNnQUVSNmk0eWkrU2ZxaWhXK2JwbS9Z?=
 =?utf-8?B?dHppUXNmT00vNi9xamN3Q0RUbk0rY2w0ZXVSNWUzdFhrbTJZaWFacjY4eUFX?=
 =?utf-8?B?eUFjNnJGUDdNSkJrbk1KenhiOGRaSzhRdW5ONkRiQTQrV1FRNU9lZDFOZDJ0?=
 =?utf-8?B?RGVKTU4zY0owNGR1d2RZN1h4RDRXUVdxL1JmcFFKL1J2NG1ZTGxFR3hTNDE5?=
 =?utf-8?B?SVlrSENqNG91QWN2dzZ4R3RKcGNYVnc1c2ljanRzemZHOVdtTHM1OHd5eDhu?=
 =?utf-8?B?VEFlT3pZbWVhWjFkeEpnMlJWcHdGK3RDeklCYXlkc1Bud0lQVEhUazJSaUov?=
 =?utf-8?B?SGxrUDZDd3BlYXQ3aEs1MUZneEhHTmZHc2R4UGxsV2NvUFpZRkNsMzFnbUlo?=
 =?utf-8?B?U0krMWlJSnNGWVN2NXpMVURmeVpTdm80WnFyYm5QQVdFb3IwTnJHWFVrZzEw?=
 =?utf-8?B?andXNkM4aGU2anV6OUZPenFydWt3UldPV3pXdUZPTll5aTUzV0lHNzhoSEhF?=
 =?utf-8?B?dktNQ2YzQnErUHErYnJFc1Q5UnY4REhORXZkQlh5cTc1VGZFc3phOUxpaFBS?=
 =?utf-8?B?elBubkRzZEV4MXdzVzRyZjNMUldnaWVHeloxQXBjMG1zY3QxQ3NxQzVzVnpC?=
 =?utf-8?B?VDJTdjlyUEtrbkZxRlFSZVhuQjBkbU50Zkp6Tmx1SjlrYTZ1eEYzV0FWRDJk?=
 =?utf-8?B?b1NkSmE0Skw2QTVPRkwyWGppSEVRQVZtdkZRNEUvTTd0VUJJZ1lQTDNMRTdi?=
 =?utf-8?B?ZFdTNjRzUmp1RGpnRHBaTTVld3F2VjZLR2N6aWIxVzZ3bVJXcFEwWkc2SFhC?=
 =?utf-8?B?dmNPWkhQVWM2YWhRTFowTjN0Y2tUZjdnNjcwN2hPU0JLMWVwb3ZqWHFJSFNX?=
 =?utf-8?B?RFJUMldNdkNKZGJvNGF1dXhBYVNaNHlLVFMreFdubmlPZElsdlhFZ1NHdmRt?=
 =?utf-8?B?eUJVa2J3VDFDYUgyQXo1bjRmcTBNM25uZ09qSTNOYTBMZlVzNk85cEt3MTEv?=
 =?utf-8?B?VVIzZFd0bVZYay9RWVZCVTV3eUFLbjNDUjN1ZHhJT3Zta2hGWHdqVnZzYmFo?=
 =?utf-8?B?MXM3OEVlSU9FYk5yckhsNW1iRXZsMi9QWW8xMVlrTmZyajdaWjdiMGptQ25U?=
 =?utf-8?B?QTdGNUgwck1XVlgzazdPQ3RuQ3BNaWlKd2RLc3F3Y3BwOUNwU3BUWmlZOGly?=
 =?utf-8?B?aFM5MXkyVFdQOTRyWTBSWWpOQ0hINll5Lzk2MlFhOUZLbElzV1pXanMwZ2VZ?=
 =?utf-8?B?SjZaaXdZOHJIelc1ajgrMUVSeEJGQWZQblFiLysyOU5Od1hCaXYwYjdHQ2Ju?=
 =?utf-8?B?eEdlWjZ0c1dSZDc5MjU5M2JmTllwcVVXdTJjQ1dhUlJNYng5Ym9ya3NrZDZ2?=
 =?utf-8?B?dHlBVmNDNkRlNXlEZUVoR1BLa2I2bHFrT0xkK1QvNTVOdFIzb3J1SEUxTFA5?=
 =?utf-8?B?d09zaSs3aGkrdnRQY1hFL0FzaUFKL05UK29JVUFSRzJOK3o0VGNCQS92d0s0?=
 =?utf-8?B?ZEw0S08wUC9sdWRrZE9Ybmt0djVQanRSSEVmMWM3MmFrUERtdWFOUUEydWli?=
 =?utf-8?B?SFBOOWJWRjNtUzJ3WEkxR0hwd0c2WTJ3Tmk0cnkxb25KN0JjTXd0RSt3MlZY?=
 =?utf-8?B?NXV0ME8rQlhuOVAzQnk4OExlWTNQNHBPaWNVZ242VXNIN1p5aHNVRmgybHBQ?=
 =?utf-8?B?RmdHaUZKMnJzeVlXdkdMWmYrTEdLVmV2VWN1MVNrRnR0VVNVNUhkTmtKVFo5?=
 =?utf-8?B?cjBwd3VPd1BWN2xROEtWdXh4bzVxcnhlUEczYlE4SjhDUXN0bHg0YU9sYkhV?=
 =?utf-8?B?Q3JycE1GZmpMcFk4dnJ2VWoyNFpHTHpQMUlKYjZWQlltbGxtUStLckNGb0gz?=
 =?utf-8?B?OUNHbkF0WTJtTEVKRnhSeHVBZUo0ZlR3S3RFMThaaCtKUVk2TDRBM1d6V29U?=
 =?utf-8?Q?uLnf4WoIE2VvXM78=3D?=
X-Exchange-RoutingPolicyChecked: bABEfwaSrrsGUlQma8qfPLn0eJqrBFYDlTer4uZvrDbg/VCJY4q2dZGw+oTUdGvweTXOFLUAM9NBQhTg2E7pYGaD0Q181klc1tYkQisQ0cOUGgAIRsIdZ4dOm0JykXfWH0FHVZUK6Q4JT2duWz02D4Jm+Bzk9+z/yKspOFMkMnWmLSdbM6Edg+7puydJm1s4lKvcsrJAsT2y56N+eYPx/Zo8cYGX+46vwKwsvvNX4dGeiHzTKqgC59OS/xLcjixtTVOZ0SH1kkk1oTIE9W0kcm/pIdfs1kPjfCFGAaT0Y2KRL//hdrrP3Y8eRyuWxu7vKRWDuTTbju+SEeAMah33dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7263dd65-c941-4890-9662-08df433099cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 15:53:32.9833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE6lJaCwJ2Cxdx4rEK6jGnNRLNBQed9du31Xou5mKusH/XflYZmeH7Ony+Trl05vl7tKji2j+ijARoxvxPcTIX1PiVFNtpIjL6r1M/bISlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4802
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


On 09-11-2026 12:10, Arunpravin Paneer Selvam wrote:
> Hi Sanjay,
>
> On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>> first, and descends every SPLIT block even when nothing below it is
>> free. Range allocations are placed top-down, so they pack below the
>> range end and each new one walks every block already allocated there:
>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>> lock.
>>
>> Track in each block the largest order of any FREE block in its subtree
>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
>> or freed, and skip subtrees that cannot satisfy the requested order.
>> Splitting needs no update of its own, as both children are marked free
>> right after and that propagates the new value up.
>> gpu_buddy_block_trim() detaches the block before freeing it, so updates
>> stop there while re-allocating inside it; recompute from the parent
>> once it is reattached.
>>
>> Skipped subtrees contain no FREE block of the requested order or
>> larger, so the old walk could neither split nor return anything there.
>> The remaining blocks are visited in the same order, so the selected
>> block and placement are unchanged.
> I am not receiving some of the emails you are. sending me. I think 
> there may be an issue with my mailbox, so I need to check that on my 
> side.
> William has also been working on improving the range-allocation 
> performance in drm_buddy. His patch is here:
>
> https://patchwork.freedesktop.org/patch/763478/
>
> Since both patches are trying to improve the same range-allocation 
> path, I would like to converge on a single upstream approach rather 
> than carry separate optimizations.
> I have put together a version based on William’s offset-sorted 
> free-tree approach, extending the search to be class-aware:
>
> https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9 
>
>
> With this approach, we can remove the buddy-tree DFS walk entirely. 
> Cleared blocks are located using the existing subtree_block_state 
> augmentation, and top-down placement comes directly from the 
> offset-sorted free trees, reducing the lookup to an O(log n) free-tree 
> search followed by a small bounded scan.
>
> @Sanjay, could you take a look at the version above? I think it would 
> be better to follow this approach upstream and create a patch with the 
> test cases around it.
I tested your WIP on our side (applied on current drm-tip, on top of
the merged two-pass guard).

BMG, CPU-visible BAR resized to 4GB, xe_pat@pt-caching-random-offsets:

   drm-tip                 ~48-51s
   drm-tip + my v4         ~0.7s
   drm-tip + your WIP      ~0.75s
  (drm-tip, full BAR       ~0.7s, range path not used)
So your version fixes the xe small-BAR case as well as v4 and looks good 
to me.
v4(already R-b/T-b by Joel) could go in first as the small fix and your
series replace the walk on top. Whichever you and Matt prefer.
>
> @William, could you also take a look at the version above? Hopefully 
> we can follow the same approach when porting this optimization to the 
> older dual-free-tree branch
> used by the ROCm versions you are targeting.
>
> Thanks,
>  Arun
>>
>> v4: (Matt A)
>> - Drop the update in mark_split(), the children being marked free
>>    updates the parent
>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>    only the final update from the parent propagates up
>> - Drop the order, is_allocated() and is_free() checks in
>>    __alloc_range_bias() that the pruning check now covers
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>>   include/linux/gpu_buddy.h |  7 +++++
>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 28cff97d57dc..93f70c98b235 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>> *gpu_block_alloc(struct gpu_buddy *mm,
>>       block->header = offset;
>>       block->header |= order;
>>       block->parent = parent;
>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>         RB_CLEAR_NODE(&block->rb);
>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>       RB_CLEAR_NODE(&block->rb);
>>   }
>>   +static void update_subtree_max_free_order(struct gpu_buddy_block 
>> *block)
>> +{
>> +    while (block) {
>> +        s8 max_free;
>> +
>> +        if (gpu_buddy_block_is_free(block))
>> +            max_free = gpu_buddy_block_order(block);
>> +        else if (gpu_buddy_block_is_split(block))
>> +            max_free = max(block->left->subtree_max_free_order,
>> + block->right->subtree_max_free_order);
>> +        else
>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>> +
>> +        if (block->subtree_max_free_order == max_free)
>> +            break;
>> +
>> +        block->subtree_max_free_order = max_free;
>> +        block = block->parent;
>> +    }
>> +}
>> +
>>   static void mark_allocated(struct gpu_buddy *mm,
>>                  struct gpu_buddy_block *block)
>>   {
>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void __mark_free(struct gpu_buddy *mm,
>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_insert(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void mark_free(struct gpu_buddy *mm,
>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>         size = round_down(size, chunk_size);
>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>> +
>>       mm->size = size;
>>       mm->avail = size;
>>       mm->chunk_size = chunk_size;
>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>             list_del(&block->tmp_link);
>>   -        if (gpu_buddy_block_order(block) < order)
>> +        if (block->subtree_max_free_order < (int)order)
>>               continue;
>>             block_start = gpu_buddy_block_offset(block);
>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           if (!overlaps(start, end, block_start, block_end))
>>               continue;
>>   -        if (gpu_buddy_block_is_allocated(block))
>> -            continue;
>> -
>>           if (block_start < start || block_end > end) {
>>               u64 adjusted_start = max(block_start, start);
>>               u64 adjusted_end = min(block_end, end);
>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   continue;
>>           }
>>   +        /* Not pruned at @order, so this block itself is FREE */
>>           if (contains(start, end, block_start, block_end) &&
>> -            order == gpu_buddy_block_order(block)) {
>> -            /*
>> -             * Find the free block within the range.
>> -             */
>> -            if (gpu_buddy_block_is_free(block))
>> -                return block;
>> -
>> -            continue;
>> -        }
>> +            order == gpu_buddy_block_order(block))
>> +            return block;
>>             if (!gpu_buddy_block_is_split(block)) {
>>               err = split_block(mm, block);
>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>                            gpu_buddy_block_offset(block),
>>                            gpu_buddy_block_size(mm, block));
>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>> GPU_BLOCK_DIRTY);
>> -    mm->avail += gpu_buddy_block_size(mm, block);
>> -
>> -    /* Prevent recursively freeing this node */
>> +    /*
>> +     * Detach the block to prevent recursively freeing this node, 
>> and to
>> +     * keep free-order updates from propagating above it until the trim
>> +     * is done.
>> +     */
>>       parent = block->parent;
>>       block->parent = NULL;
>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>> GPU_BLOCK_DIRTY);
>> +    mm->avail += gpu_buddy_block_size(mm, block);
>> +
>>       list_add(&block->tmp_link, &dfs);
>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       }
>>         block->parent = parent;
>> +    update_subtree_max_free_order(parent);
>>       return err;
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>> index ddc4eca84175..8037f5a0feb1 100644
>> --- a/include/linux/gpu_buddy.h
>> +++ b/include/linux/gpu_buddy.h
>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>       unsigned int subtree_max_alignment;
>>       struct list_head tmp_link;
>>       bool has_clear;
>> +    /*
>> +     * Largest order of any FREE block in this block's buddy 
>> subtree, or
>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>> +     */
>> +    s8 subtree_max_free_order;
>>   };
>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>> +
>>   /* Order-zero must be at least SZ_4K */
>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>
