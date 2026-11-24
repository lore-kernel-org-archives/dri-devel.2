Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FD606A683
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OreBbi5L;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PNIR7ney
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE6110F3E2;
	Tue, 24 Nov 2026 09:30:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5542610F3D5;
 Tue, 24 Nov 2026 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795512637; x=1827048637;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iV0VNu8rFj+m90VVMcttN8Ao6S+z7Oks5L9OpnAgFIo=;
 b=OreBbi5L8Xw2p50VBR6Zeq+yTdf0isCbLO3j1ddVaJJosdIMZ615MAPJ
 L6nRovguF3suFAYK0rV+sz/0dJJbs9hrY/ehq8u4HJM0qX41Zqi3bHplH
 NgQcxXf9niZq6yFNkX+zKIK6ohUWmdERL5NOjUeYD5vNeFITFqdppEH3z
 iJxshP2D2kTZxdtMW/DBlo+blkaoVB13mZeWBw+qtA7rPjJqTbYJjDRIP
 ZNHVu4eadcNGBvOgkDcKpU/H0hiuhpsq1dAgXZ0JzngtV0sVwkQyOOKTM
 1BEbPoWbLbAIHlLS6Myn7JwOsKhNXjIxSA6ZzIMrBfqse1x7iKfTLxu+n w==;
X-CSE-ConnectionGUID: P2USGozJTkKeWPa2ZOnclQ==
X-CSE-MsgGUID: wmbe0WZhRxepzMV1XndzgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4248650"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4248650"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 01:30:36 -0800
X-CSE-ConnectionGUID: ulmleZCWRIWEIecv8bUMCQ==
X-CSE-MsgGUID: PmO8uzTgQTy0TYQjZrPmeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11639369"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 01:30:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 01:30:35 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 01:30:35 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 01:30:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdDJiQQ1z9SsFmRJZb2Fvs9vbUYWv01bhaWbiC4lC5uLJjnLO+kA2gWJWju6mxsVDU69D/W2+eJ4UldjBSA/J0AvIBb/9jrySQEU1CZT47NyyM74QB7oGXVofy06d7e7hiC52cPXp8u2PYeVNF/7R+g4wqxNfwubtyppst7VnEw9tBZ/5/bHMpozLEINdcb9q7d5hmyy2kqYgzS6LljalVpZpG315q/3z7tQol4Uga0+Mx9y1bjjViCuirFjNHTxk1mUM35OUCoFWo5fn1+AezPMKmfavHjjS06wWeZ6ltzGiyEDPQLkDEEE+GAOe8dvd6x4G/M/qLZt+Tp6Iyr4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq2iOSp2VhegdZiNZJIIEFH3YwWtPuimUjXQy1/jT0M=;
 b=kX6o7PPU0/JdSw0WdGoTjFHkjoyaaI9nfb4LD+s0prcJvvnDUTJiQdnrTGQmYPG4e68M+N/WQfaLE8IsHZvv1Ykc3MnFh37/ReYMPZNAL4dyeqvu1+SSRngB9HzuUwEOjdJgsowijwtNIquoEA05EywDXDUGR0340lycb2y34Io/0Y78qx8VpKbeben7K19Laoz1uzp2owg1wrDk6pI2nIYxE3zGbBAhMHDVyzZMR1L1vmlVc+Z7uIM2k/Y/UVOtGHfHHHTyyn5SbDuvDXMm4ndkl2bh4QU8YNg669YjtmNuM4WTW7q0kzu+0eN8B2aP7XD9rdrIndtWjp/TEWji/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq2iOSp2VhegdZiNZJIIEFH3YwWtPuimUjXQy1/jT0M=;
 b=PNIR7neyR46ciFUvNR891zSlx9qJduW8JnHCwvzfSxdnRYBBpsEJ5BGRXHykPCjDuN6IfaQRoy5AIdZ+32Y/4VGV1G6V/GbK0M78k8LfEsymvB9EIwpduCmb+sAbXRCcoMPOvEnmWT+rqnGt/vGM3c8cDXLG65KrK9+nUbb4E2I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB137813.namprd11.prod.outlook.com (2603:10b6:8:4ee::10)
 by DS6PR11MB989080.namprd11.prod.outlook.com (2603:10b6:8:46b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 09:30:33 +0000
Received: from DS0PR11MB137813.namprd11.prod.outlook.com
 ([fe80::d45a:3300:62e5:fb3a]) by DS0PR11MB137813.namprd11.prod.outlook.com
 ([fe80::d45a:3300:62e5:fb3a%4]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 09:30:33 +0000
Date: Tue, 24 Nov 2026 09:30:23 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2] drm/i915/gt: Adjust usage of SFC_DONE registers on
 Gen 12
Message-ID: <flhrxxaqjyiptk4t3kruaiuun3qwg3i7kt3ti6rprgxqw3qhha@iug4lpjvneyt>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20261105071426.1159739-1-krzysztof.karas@intel.com>
 <dae37984a779ec00c72497ca7bf116dd38b3da43.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dae37984a779ec00c72497ca7bf116dd38b3da43.camel@linux.intel.com>
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To DS0PR11MB137813.namprd11.prod.outlook.com
 (2603:10b6:8:4ee::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB137813:EE_|DS6PR11MB989080:EE_
X-MS-Office365-Filtering-Correlation-Id: c0634591-ddf3-40d7-70c9-08df4a0d967f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261022075727099003|261028144727099003|261022105027099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vXxpCf1+dRlr052fBhZ6FNRRE0sOwNquqtaRyTjBDyPccjP+s3QJhmcCD7tIPU6ZnLZz84X600qxsBl2xjSVHyNiynGq5xdwN2jC/7FQAPNL2y2zmnB1uCcTI6Nk7/4a0vMfwb/DqqSQuJraWXBwsu9bq4KscrNkoFUsqNEQlQaEoG9CIBYSFqYrm58gml3YobRBLimFAjwxg1AhQ4ZITzu6A98xurItJyEqknaoC89ZIjQYIj3n+Adn83fAgg0eDcHh0GcmVXx91pdyEnjgkLBIhEDJDWGAwdH8nI/ckqP5PL3olYcEZ4MniEz+MUhP1xTG0Q/I6INC8Jc1hi6LXzPcrI8JDM9jrC+pxzC9QkaOtww1G4T2E5A/3toxvk3T9lVqaTVJCh87XDnXDIYfbosrfkuGF5MHiakQNtA4l3POwv81/XGvxVGZiRZrBku+Kuca+K0J0VBM/4D2LALAYQHuovHlXGk/+/YnIJj826D/4eN4wgCev/5tTvxH2ltDUJIqDY/g4m3YWwaoDo2AK3NvH58kGHOp2R7Ccixm3bT8fMo9hjt1rbrERc6VFQJwG3+scna1JZuDkAe9OB+gSEk9eO5AUlF+kPnCGkIlmD8D2+L8eARv8IhTqOMoyd74
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB137813.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REdYRTFEUjRLZ1JoVlVQNERLai9tcjd5QW9rV1MwS0I3amQralIxL1hsc2c5?=
 =?utf-8?B?UWo5ODdDSTRLTm5XdXgzeDVzR1V5ZGMyNTQxTGhicnJtSmdERzFmaXFLNmlR?=
 =?utf-8?B?RHpaaFhIK1pNOCtQUjFpVTNpMi9WWCtpTmNmTnFwWWZQTXhBLzhlbWRudzNx?=
 =?utf-8?B?S3N4N05vSFAwWnhOSGFtTXh0ME5jeWFDYWp1Ui81dXdnKzhoM01JVDErVHhP?=
 =?utf-8?B?M2ZjTlhBdmZ4TzRndUZLdGp2SmZhWGxVRU5GSEk5OHJXbi8xbEFQaURQbXdo?=
 =?utf-8?B?c2hzR2x1enRsNXVqVndhVmVmR0pSczhFVVE1dzA2TjVFUHpOMzBQdmcvQjBl?=
 =?utf-8?B?RW5pWVllY3ltTFZCWjZlV3IvUGVSYWlqaVljODBZM2VWeTFaSitVd2l4MytS?=
 =?utf-8?B?TXdDTy80enFMTUhsQ0lWeUdGa3o5SE01WDNXUXdjTGVYRnJkSHVybWRkYTRF?=
 =?utf-8?B?MjhJMUFHYklxWG1ENkhtSWhkQnNXWHhBeEZ2MENJaUFFaW1adGtWUnBjTkZY?=
 =?utf-8?B?UXdCSmNuMjhmZVV4UUR2aEN4bTlFTkFGUUpseTdvclBncUtRWW5hWHBXYmIr?=
 =?utf-8?B?MnRQeE1SOWRUY004cHovMTBobnpJS1ZpMk5Wb1A4cG9zeEdoc2FJS1ZwTzJz?=
 =?utf-8?B?RGpwMFZ0UWlVYU5Zd2YrTEIwSWFNZjZyNWNJdUF3eGtBYzMzU2VYZE5wc2pk?=
 =?utf-8?B?Tzk2L0pqanlQUEtPWGgwQ0E0V2JGRUJBM2pLVVBHWFIrWHpaT0RjUDRNYnNX?=
 =?utf-8?B?dHc3OWkzVTlDM3BsQWMwdi8yajNUQ0Nzd3lXZlhCeWhKSEdhSGo5YTViY1Bo?=
 =?utf-8?B?d1RmS2ozUWc3ZjNTZGV6RlJGeHZxNUhLZVFJQ3FUbDV6OTV5RE5KUDRQL0Jv?=
 =?utf-8?B?cDBFS2Ywc24ya2tIRFR0V3I1TFNrWHlYQU1iN2JpZ2tIRUI1alJrcExyK2x6?=
 =?utf-8?B?YjVReEl0b3JSenRicjQ2U0JEYzZsNzExU3BxblNXa2dYV2VlN2dkOE9lZ3Vy?=
 =?utf-8?B?VHI0cHJEaktZR21CRlo2cVI0bVFlTVpaTXFUSW1rT1dwT0RibHpvYU5lUXpz?=
 =?utf-8?B?MnlJT3F3emIyZTlIbWtkL0ZQQTdHd2FpUVNHWEZyVXY0TDdRVTBWTjBrMkZJ?=
 =?utf-8?B?Sm5GMUFjN2IvTmIyV3BWSnprYlJadzVzbThpNVl6K0hkcDVlQlowK0VOcGRG?=
 =?utf-8?B?ZndGbFhLMExMVWE2aVROVFVkR0psaDZncGxCZWloZ0ZEMjBKV2RoMXMyZWp2?=
 =?utf-8?B?c0dreDhONVNKdHlXOFlKZnZlWm43ajdBSWxabjBXTlJTOEt1SDAybVQxVFJ2?=
 =?utf-8?B?VzdualB5T2loUUFtTEduS0tzYnJZM09rTWNIVkFyRFc2bnZ3S0JrZDJOMkdY?=
 =?utf-8?B?dUEvQ3UxaXN2RjN2SG5LYmFCeWtMUGFmK2NtTmNqRFpZM2Voa3RGT2VQSk50?=
 =?utf-8?B?RmROVVVLSXM3V0ZleEhMeHFEcTNoTDJMc29sN2FhbnBBVjhuTTg3TzVRdGxM?=
 =?utf-8?B?Z1ZvOERDeDhLK2xzWktMdHBqNDR6cXBVVkJRQlQzbXFNWUZUR1JCYnQrZDJm?=
 =?utf-8?B?OXJhMm9iTGh4REp1aVFEWjZWWnh0bVFLMjhoNlpvRmNzYU0xbWY2dTdFTlZz?=
 =?utf-8?B?UlFSZzdRSFFNVEVaU09yclNickpycW1wMUdhVVJXSnFkMXd1eVZYYWdjNUll?=
 =?utf-8?B?by92cThodHhyMmRIcGRrV04wUm54eDAzd1pxOHBBNlBRY29nNmd1cG4wN2l5?=
 =?utf-8?B?U0RoemVzRlQ0WDhQODZRTlpLcHhXVUJvUjUvMGxrWnFFNUdWRkl3WFFVSTF6?=
 =?utf-8?B?M0NjaXF3NEZFTVBXNVk5SWhkOTVWR3d2cGh4eGJwYUhWUGl0L3VBVE42eVBV?=
 =?utf-8?B?a0ZHRktabTlIMlFtdzhDUmplUW9TdXpOOVRxZEJEZ09rMEtWOTZISi9FenMw?=
 =?utf-8?B?RHYxZk5OQk1rY240empURnFvNTduSlIwSFZUWXU2SWZxUVlyZGtOSmJZWTJn?=
 =?utf-8?B?Z0J0YXJvcnVWaVpKVkl1UXZEWXV5K3Zla0N6NjRpZjQ3WnhhMHVpUlpZSVRt?=
 =?utf-8?B?YjFyL1NHTkdYTWdJK0JCTFZPTjFNN1VkdFMxTzE1ZlhSYTk0QW0wUmFGNFIr?=
 =?utf-8?B?eW1EbllxWGpBTFVRcTZRR1ZGSTZNS2pmVURqVGllVnkvVi80Tjl2U3FVOE02?=
 =?utf-8?B?T0JaMTBJU0NNOU9zKytKVXFYZW9lK2M2bGtzckpFV1pFcmgwRFIwVzd2Rk9N?=
 =?utf-8?B?OWlrckUxaG54YWJxN1dKVXVDc3BEY1ZTNll3UUdjUWh0Znd5cUJSMmdNZVJk?=
 =?utf-8?B?Nm80RnB2aUNtTEV6dGlQM2xqZWNpdDZXaWhzTmV1am5DaDVvREplajZpazRW?=
 =?utf-8?Q?cxhhgc9tBS143Jbo=3D?=
X-Exchange-RoutingPolicyChecked: VOEhqFZil1hyEoY/bJ5nG8ceoNFp4YH5GF+RDBuTu4rW4BWFlEEHsjCSvGEls7nE2FJQU7diGRzeIVeaLk5CbK7CNbI4K6AnpkN6tiZ15kMnGljtopGesYrss0e2rQ8zBYdnF6nh/LlRtxDRXMfMCMtiDIVAP8LxHpwYncY4bMG6ZETRIS/2tEZR3iEg0xrm9k2RTdjfG9zX6O1ijru59RD4kZjCDoz8gnCPy/NGElrPYsDWfyILX91mXRQkSsXMwSyf14gwaVzlepUKOVJIADnyQdnMMjCK0FzUlCgwJ4flMPuSxepFiP0v8MnylybsE/9Ws5OJy7KJFFts3DYjew==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0634591-ddf3-40d7-70c9-08df4a0d967f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB137813.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:30:33.0840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iag1IMXULjqgx+FqfugQi3dZ2C5KWyQiHaJo5nfT3tvvAPVfzwogqugbn30xThe18oI+cqwXeSfbE8rWVLM6DMm+bnrQzv8wAHqtlqTgQmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB989080
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

Hi Janusz,

On 2026-11-12 at 12:23:08 +0100, Janusz Krzysztofik wrote:
> Hi Krzysztof,
> 
> On Thu, 2026-11-05 at 07:14 +0000, Krzysztof Karas wrote:
> > Initial, empty XE_LPD register list for Video-Enhance class was
> > introduced in [1] until [2] filled it out with debug SFC_DONE
> > entries, but it was never explained in any of those commits why
> > using those registers for VECS class specifically was chosen.
> > Furthermore, currently, it is seen as a regression [3].
> > 
> > Currently, gem_exec_capture@capture@vecs0-smem runs report
> > partial captures on DG1, DG2 and MTL [4].
> > SFC_DONE resides in the VD forcewake domain and is available
> > only when the corresponding VCS engine is present (explanation
> > from [5]), but XE_LP capture table currently associates these
> > registers with VIDEOENHANCE.
> > 
> > Furthermore, GuC firmware supports SFC_DONE registers in error
> > capture only for MTL platforms, DG1/DG2 are not included, which
> > was confirmed with experimentation and offline discussion with
> > GuC side.
> 
> Since that's highly GuC related, I think you should also Cc: / ask for 
> review someone from GuC integration developers team directly, e.g., 
> Daniele Ceraolo Spurio, Alan Previn or Umesh Nerlige Ramappa, maybe
> others, not only i915 core.
Good point. I have a v2 brewing, will include them in the
recipient list.

> 
> Thanks,
> Janusz
> 
> > 
> > Make a new list of register lists for MTL and use SFC_DONE
> > entries only when that platform is detected. For DG1/DG2 pass
> > an empty list for VECS class.
> > 
> > [1] commit 24492514ccbd
> >     ("drm/i915/guc: Update GuC ADS size for error capture lists")
> > [2] commit 8b72c21618de
> >     ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
> > [3] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16904
> > [4] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=igt@gem_exec_capture@capture@vecs0-smem
> > [5] commit 24d032e2359e
> >     ("drm/i915: Only access SFC_DONE when media domain is not fused off")
> > 
> > Fixes: 8b72c21618de ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> > v2:
> >  * Changed commit title (was "drm/i915/gt: Use VCS instead of
> >    VECS for GuC error capture on Gen 12") and commit
> >    description;
> >  * Enabled SFC_DONE on MTL's VCS engines and disabled these
> >    registers on DG1/DG2;
> >  * Added a new list for MTL;
> >  * Renamed relevant objects vec -> vc.
> > 
> > I could not verify when exactly the issue started happening,
> > because:
> > A) all recent reports are red on DG1, DG2 and MTL,
> > B) checking for "partial-capture" in IGT [6] was introduced way
> >    later than the driver code asking for SFC_DONE registers.
> > I assume it has been present for at least a few months, if not
> > from the very beginning.
> > 
> > [6] commit 93d3b0e28d7d
> >     ("tests/intel/gem_exec_capture: Check for partial register captures")
> > ---
> >  .../gpu/drm/i915/gt/uc/intel_guc_capture.c    | 33 +++++++++++++++----
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> > index 865b61057566..88e6d706210c 100644
> > --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> > +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> > @@ -88,7 +88,7 @@
> >  	{ GEN12_SC_INSTDONE_EXTRA,  0,      0, "GEN12_SC_INSTDONE_EXTRA" }, \
> >  	{ GEN12_SC_INSTDONE_EXTRA2, 0,      0, "GEN12_SC_INSTDONE_EXTRA2" }
> >  
> > -#define COMMON_GEN12BASE_VEC \
> > +#define COMMON_GEN12BASE_VC \
> >  	{ GEN12_SFC_DONE(0),        0,      0, "SFC_DONE[0]" }, \
> >  	{ GEN12_SFC_DONE(1),        0,      0, "SFC_DONE[1]" }, \
> >  	{ GEN12_SFC_DONE(2),        0,      0, "SFC_DONE[2]" }, \
> > @@ -117,9 +117,9 @@ static const struct __guc_mmio_reg_descr gen8_vd_inst_regs[] = {
> >  	COMMON_BASE_ENGINE_INSTANCE,
> >  };
> >  
> > -/* XE_LP Video Enhancement Per-Class */
> > -static const struct __guc_mmio_reg_descr xe_lp_vec_class_regs[] = {
> > -	COMMON_GEN12BASE_VEC,
> > +/* XE_LP Video Per-Class */
> > +static const struct __guc_mmio_reg_descr xe_lp_vc_class_regs[] = {
> > +	COMMON_GEN12BASE_VC,
> >  };
> >  
> >  /* GEN8+ Video Enhancement Per-Engine-Instance */
> > @@ -189,7 +189,22 @@ static const struct __guc_mmio_reg_descr_group xe_lp_lists[] = {
> >  	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
> >  	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEO),
> >  	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEO),
> > -	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
> > +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
> > +	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
> > +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_BLITTER),
> > +	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_BLITTER),
> > +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_GSC_OTHER),
> > +	MAKE_REGLIST(xe_lp_gsc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_GSC_OTHER),
> > +	{}
> > +};
> > +
> > +static const struct __guc_mmio_reg_descr_group mtl_lists[] = {
> > +	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
> > +	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
> > +	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
> > +	MAKE_REGLIST(xe_lp_vc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEO),
> > +	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEO),
> > +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
> >  	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
> >  	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_BLITTER),
> >  	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_BLITTER),
> > @@ -354,7 +369,13 @@ guc_capture_get_device_reglist(struct intel_guc *guc)
> >  	struct drm_i915_private *i915 = guc_to_i915(guc);
> >  	const struct __guc_mmio_reg_descr_group *lists;
> >  
> > -	if (GRAPHICS_VER(i915) >= 12)
> > +	if (IS_METEORLAKE(i915))
> > +		/**
> > +		 * MTL is the only member of Gen 12 with SFC_DONE registers supported by
> > +		 * error capture in GuC firmware, so use a separate list of registers there.
> > +		 */
> > +		lists = mtl_lists;
> > +	else if (GRAPHICS_VER(i915) >= 12)
> >  		lists = xe_lp_lists;
> >  	else
> >  		lists = gen8_lists;

-- 
Best Regards,
Krzysztof
