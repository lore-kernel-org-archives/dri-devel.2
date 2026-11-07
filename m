Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AB606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jYKT1EMF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C0310E4B8;
	Sat,  7 Nov 2026 05:02:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CD710E00C;
 Sat,  7 Nov 2026 05:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794027758; x=1825563758;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UFpJRVuOZfPm0tN98H5BdaOSozq1pvUyCIpOExb5oLo=;
 b=jYKT1EMF+wNL4irPVncKrsMITvLb+ocwhXHqR2miy/st6XCs2UMdmdg4
 zfTytR/TQTzJZktWTZ0CRbiUZGv6giD+OiAaMH5UXIYbpm782596FFry/
 WWPNB1w0nLR4En30xF87bHzB9PEDOAGufHukCDb1Hjt83gDQHg7JWN2C3
 J6D9fJV/w9n0NuIMj6cckrlXVK5gmxHl4H/iZerxh1VkAFSWUtII0L5pj
 j63c5TkxX+GxxI84Xp1v1gg4ZrCT7ILIjejKD0aostwoZScYCzp4iXdHd
 6Jk6UcYoQSrEiA++Utq/FsGsdrgnWtB2u3LazznhvSNH7Tz6z8b9yuQbq w==;
X-CSE-ConnectionGUID: rk6KfNPCSf6hxcRqGHAh/w==
X-CSE-MsgGUID: PT4WZvSMTladMb1FWKHDkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2733241"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2733241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:02:37 -0800
X-CSE-ConnectionGUID: BSUEGLCgRFmLapqjkLyyGQ==
X-CSE-MsgGUID: 7ZtifvdeSI2mUE03nXu4Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7778980"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:02:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:02:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 21:02:36 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:02:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOVAxfzfFpg2US/dF3OBFzE1ovvBI79L2xiT+StuvCI6Xgf1p7Bpk5+2PieW8sjvFdgJE+kyuQnWnuzcES4fyZiC7dkVEC6Ah6Frdkv624JrcBZNsWsDZdqBghiKTfGlj4OppVRXQPEu9v6W2Tl6TKKDSDLlaM8t7BYkwy32D6rWOf29jO3rdZwCkrb108r4b786rH3UK63YCLro7NtSwc4XHOOmJdpQjSLKHZ+TcAwbxGwK+BeWrgZHxlXyG10XYWCkWuZwnR79wfSe8HITHKMaM/MiLwm5Mju3a949rbCw2BkehF8u3nlcCA+lmR4FX5SbM3+cWX7p9W86TYIICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T4IGYmtGpBdhwnUJVGj7vewdKRa7PTcVeGGk0sP18U=;
 b=sGZSl+IH+nheZwhvAocFMHwTr9NbbuAx4jRPGAO7ch7AxG/Y3S6dsXrIB3q0fjXRjILnIX9iHEJTzmrcPRtTlRFyeyX1PEScShK53ME/sTUvS6MzP1uPMIpeT3uiOUDsMY0tqFHj6UbOg93f3R/cZLd2pvLQgVei0PPBNB5JjtNI0eNGdwrrPJaZEKVGCD1ZHhtwa/AuX/NKO03nllm5ba6ufouqMi1UoUaCWJsFCQhXJpSu6sGS2XfUD93eQHppRDxhhmjF1fxE9i51HeS1Gp/jtdUa4O0nFVow6mYr5MynWghioCMzNoFzpE+lKnz8LNiyZ6c1qDpf3xOdGxoWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 05:02:32 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 05:02:32 +0000
Date: Fri, 6 Nov 2026 21:02:29 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 16/33] drm/xe: Back off beneficial-order reclaim under
 defrag pressure
Message-ID: <au6w5cfqYazBEGNx@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-17-matthew.brost@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-17-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 907f3e5f-af41-4edc-803e-08df3c8c5452
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: sU1GVQQoxhfcFx59qxLDZDCIjTz2XGYMFXnsIBcIdne+fDgQh0bjH4eM+X9JubCLF29+CI2RFdydYjqfIvMHmYU+E+HQIGCp+YP6yiHNhDyMYFqUY3ati3oT/BU2DZ1Vyj4lfRfOyP3FVOcllU28uz5iDgod9GHDpI4NVLo4sWjX9GVSs+OAWmwsq0MVd9KBjsbqq1cOKLrOx8LdxpMR6u2tfkdOj9R2s+n9WjibNkRBNohaXep6MkH05dBBtoo7j93TSIR3zsnjtiRZYChZAKEhypZ+9iIHOyXCbbX+PYu68LHFx99Kb80ShKGIJEDmqyJrxGVLMlWCgfvN8cv7GvuRG/ds85mO4GIXSk1SC7OJ1qDvPBmdo2tL/ufTF+Hm1JR4/0CelqxLqHQJp/OqHZs82gVD0LUsX7CbsMdS8VZqvGNKnUZ18J7yVW0YFpa6PtSGDsM+09yqObelnfXs/hANS3DZUyyTJudakRhrkAZbplRbxsoFylYgO21LUpP8sZnuZERU8X0M9nDbUPiIKHiN1J4gGBxkW6lo4Y/A/U4TYo3UOVrvLT4jt5Rir7Rb5oaVqxHMt0QmKFHNnW32w6oq9Y027IXDLvsSUAHpRC55xTwHfpxwaoWMwpBhc+3/loFNhbQzLOm0g0NxxuRUbLn6wdmPPRN4tLNvrpqXVwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JQVGFpaUozZUZJNUpuUTRzZG9YRzlZSDQ0dG1zSHVtdGl3Q2ZuRDN3V3A2?=
 =?utf-8?B?VlRSdngzQkhmTHdlRHpNTzdURVJONTJMc2tsbzAyRE1IY3p4aDhhdXJ4SURa?=
 =?utf-8?B?UHJVTmJzQmpTU05uSjFoNWZCSnc0QWliUXhOZ3FzV0tsRTN0UVk2Y0JvNGEz?=
 =?utf-8?B?Z3ZRYWwvM1UyejZjTWV5dVY3R21YUDZ6NEFBRU11UHBJdEFOVERMR2NTMDZQ?=
 =?utf-8?B?ZkRwME0vWjRHZmpUYVQ3ZXAwV2dzRWZrYkZJWlgvNU8zRk9KWk40dEFJRmhI?=
 =?utf-8?B?Sy9tYXBzRTN2NFNCZ29GVVAwYnFGMHAvK1BQUDVMVU1zMGhkUEwwczB1SnpO?=
 =?utf-8?B?cWQ1eW9qY0lRUkpmeEc5bEkvM21BQ1RVVzl1bmd3djdlVXd2NU53K3ZDOU9p?=
 =?utf-8?B?aU1oK2loNWZWR2FaNEw3cGU1Qm9jbWJDTGNDL1gwZExkUzRBaW9kbXlwQU9O?=
 =?utf-8?B?RXpaOTRkSkFHdGpoTlpWN0dkUmlpRnBsTUIyeTIxR0xENm1SaDJqTlgyc2ln?=
 =?utf-8?B?UVNMWXd0TmJCRHlTY3ZkakVGYjkzU1VvN2phcmV5NTU1dzR4WEw5Sng5ejAz?=
 =?utf-8?B?T013WVVDSXB2UVFsRlR5d1FMaUxoeSs4NGp3K0NRR2g2b3hwY2Y0K1hlSlFS?=
 =?utf-8?B?a2t4V2pocTM3QzIyTStMc1NGNmloYWJFc3N5OXRCU1d5dWc1UncvWWFuZGpS?=
 =?utf-8?B?ZFRENUdTMzk4Y0JPYjhsUWpBYkp3djJMR2JYMWlzUDRsUG5BaWdVOHpHQmYv?=
 =?utf-8?B?V1kxWDFaZWRrVytnRUZ5YzYyTFF1dXlXY29tc0VHT3pBbjlJS05ZQ3ArVkZp?=
 =?utf-8?B?WE9vUHhoNjg2blc5U2xLbkRiYzdOYzVUd2M2ZXV1SzFsckhVeHFpNzRlQ1Zr?=
 =?utf-8?B?cVB4ekFZS3RwMnpvN0x6UU9tMGZtRVVnUWhsQWN2S0ZBMGIwSFI3blIydHlJ?=
 =?utf-8?B?RUtJb25QVHRUTnJacVFLd3M5TVYrVmlDMEtDTVBBWlZ6Yks3UitIUndSbGhK?=
 =?utf-8?B?N1ZhS3VFckRGZ0kyTWtLendJbk9jUkhrQjk3eGh1OHU2L0JpSVBDRXBWcXBu?=
 =?utf-8?B?SnFaU3RpKzFJL2VvZ1RCTFR4cm1MaStHUWxmZzdHZm91bWRpRnhoWHVlZFRp?=
 =?utf-8?B?SUJGSzJtQUFCUHhrU0lxS0ROV284OHN0Qk9oSmtYelJYc0xkTEd6YW9ITVIx?=
 =?utf-8?B?RXRXY2EvSmljVHE3M2kyd09SQU5CREJUbGprOUVNU1QyR0V5bUR4dW91TzdM?=
 =?utf-8?B?QlE5RXQzWEcxNndOdXQ0em9ZVnBSeDg5blp1eVUzVzRxNXFyVGY4VVI1cmQr?=
 =?utf-8?B?bCt0SG5XdmFaSlBzYkxPUzRRZUl0YjJBSkJ5SDhraC82cDd2S1B5NmU1aHJl?=
 =?utf-8?B?RWpZUVJoNS9xYTc5cVpyeS9KV3pBdHBxSjc1VEpxUDFQQ1hZOXgrUDg1Q1A1?=
 =?utf-8?B?aXlWaFR4UmwyNklzYWxpNjhkanlhMThqYmVwa25UTW1FTWNyZitVcFBxV1Rz?=
 =?utf-8?B?T29HV1VhU0dBSjlhK0dKTGY5WWNKdnhqTVZGMlM3c3A3MVhxb3c4VEFsdHBr?=
 =?utf-8?B?bzVYcUF5b2d5WWpBOU1Hb01PN09oL0s0dFRhT3BmQVYrd3liMTRtVDBxMnNG?=
 =?utf-8?B?SmlsR0RNUk5SSjVsbzNjOWVqODhrRkNmTVJFaW93YkpVWDAxdzNxUjYwOFda?=
 =?utf-8?B?S1BtYktwai9pOEQydytyNWdkaGhWbGlWTHp1SGU5NEFSdXhieU52dzlPalhV?=
 =?utf-8?B?Z2JsVDM5QndPWVlaTVowcVQ0VVNXS09POVYrSG1EOU9kL0xxZVJ2K0J0bCtB?=
 =?utf-8?B?Q0RzZ0h3RHQyNWNqOHA5Q1RSempYZDRaaUhNVHhEcTg3anZCdWppYk5qR1A3?=
 =?utf-8?B?THYwZDdtTjhySjM5b0c0UjJ3Vm83cGtVRDNrOEFnMFdxamNXRS9KV1hJNjNV?=
 =?utf-8?B?NG8zRGMxTmZmKzhMeHlreHQvK0NUS0c1VG40eHRjZDN3RjR1TE85TEpOem90?=
 =?utf-8?B?Sk9oNm5QYVVjeGVYVmNpNXpRSmgxcGZVenVQc21HSFVwMExCeFdvVXhaVkNY?=
 =?utf-8?B?Um9rNmhzb29QenF5MC9vc2F1S1kzdjl1WUMwYnZQWEREMnRsd3RrSTZUM0dX?=
 =?utf-8?B?MWFMUDdrL2loV1cvbHJHQjZOL0JLaGZ2d0gzZFR5dTQwaTNqVWJKNkZkaVBO?=
 =?utf-8?B?UlVFbWwxZHh0ZmdFeDNWdGRpRlFGaWc1cDhxeHVmQjdaSE5Pa0ttclpVSlVQ?=
 =?utf-8?B?UGJ3NGkxZmt1cjFTY2RJT09tdUJVMGFTREwyUGlYbkFRWVRyd25vNW9SZFF5?=
 =?utf-8?B?WkNsUnJRNUJlNE9GWUJSK0pmNGk4czlEa3dYaTNVMS80RU5VYnVFc3pTT3Ny?=
 =?utf-8?Q?YR/3Uca4KKObRteUveTv5L9SoQCYdt3OkIB8G?=
X-Exchange-RoutingPolicyChecked: voZAhpjTBeiDgtJHUiSs8CgUnB+DiEX28nVH40rMQXgAr6r3vYA+XJA1tgTxHrebAxeEIPh9DFwLr0cQreATJjXrC30X2e0urd+a34uqN9mrujNczFrM/YgtgQohwiTjkd2y8sIbPHNry3mE2yVxW0sDzaQbW7+KZiHW74BSDeXlqU/Yd5gbuf7NbOTwj5T6WyN9vt9dfCPYVdCmxEVf4qISY1DUDxXe3eOCEZUk7XklZ7iblYLo0h8Pu/bilZPZpoJDDTEDigOW94Rxu0WimMsGC47qxDfjD4JlxP/wYbU/nKCVlPe3wOeXXP/A90TkqlIUluoMMdUpWO7EvYCAyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 907f3e5f-af41-4edc-803e-08df3c8c5452
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 05:02:31.9695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrCpbKg9wgkEDeVXeO6CGz3LsTt/w5pWFO2Z28Mn6jkvyyv0ilkquoT3XYim4ZYRfjfnB+yJ7fuM80WDPDNgoNslN2C+QDnoqlqQ6QrTGqagF0FbfO7xOGMeJ0QPh6GE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
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

On Fri, Jul 10, 2026 at 07:56:02PM -0700, Matthew Brost wrote:
>Once a meaningful number of BOs are already tracked as being backed at a
>sub-optimal order, continuing to push hard for beneficial-order pages
>during populate mostly wastes time in reclaim/compaction.
>
>In xe_ttm_tt_populate(), set ctx->beneficial_reclaim_backoff when the
>device defrag count reaches XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD (2)
>so the TTM pool backs off and allocations make forward progress. The
>deferred defrag pass is responsible for upgrading these objects to
>beneficial order later.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index ff324caab6da..02395968d613 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -41,6 +41,14 @@
> #include "xe_vm.h"
> #include "xe_vram_types.h"
>
>+/*
>+ * Once this many BOs are tracked on the device defrag list (i.e. were backed
>+ * with a sub-optimal page order), request that the TTM pool backs off from
>+ * aggressive reclaim at the beneficial order during populate, so that
>+ * allocations make forward progress instead of stalling.
>+ */
>+#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
>+
> const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
> 	[XE_PL_SYSTEM] = "system",
> 	[XE_PL_TT] = "gtt",
>@@ -598,6 +606,12 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
> 	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
> 		err = ttm_tt_restore(ttm_dev, tt, ctx);

Assisted-by: LLM

Don't we need to to backoff in restore path also? If it is intentional,
probably add a comment?

> 	} else {
>+		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
>+
>+		if (atomic_read(&xe->mem.defrag.count) >=
>+		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
>+			ctx->beneficial_reclaim_backoff = true;
>+

- beneficial_reclaim_backoff is not cleared if count comes below
threshold. If the same ctx is used for multiple BOs, they all
will backoff even when count has moved below threshold.

- Looks like self-reinforcing feedback loop causes spike in backoff.

count ≥ 2 → backoff on → new populates land sub-optimal → BENEFICIAL_ORDER_FAILED
→ added to defrag list → count stays ≥ 2 → backoff stays on → ...

Is it intentional? If so, may be a comment explaining it would be helpful?

- Will there be any value is heuristically adjusting threshold instead
of using static value (2)?

Niranjana

> 		ttm_tt_clear_backed_up(tt);
> 		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
> 	}
>-- 
>2.34.1
>
