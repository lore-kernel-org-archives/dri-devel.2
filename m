Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A502C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB17A10F6DF;
	Thu, 24 Sep 2026 17:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n3828H+R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5644810F6DE;
 Thu, 24 Sep 2026 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790272729; x=1821808729;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iCFeoA26BLA2p4SLWo7jGd1TYZjLXhWQ6t1wXzvTonw=;
 b=n3828H+RU0uIBE/oyWf0BgevMWSvzWKTHtUfr0j4sY7VIN/4aT+WYAFT
 2h7HOrsDM1Hn4PArnuRHrMtYeRHxUWSKtnSCUFLo/C8Vm7mupU25dVdMZ
 O86aKM5NcxSnYGZVR2pcoKkdUFFtA5SwgXvAOHByqO3zhcP8bnCRWdhz9
 CKEFn49qVHrVnrfuM3DgCnPzokJq1pPrkJGb0Cn2iZtcUNCCEZAE32FB5
 jAuG03gDKLmMC/faEmZWGLw2QzcPxUp4kZFHvhE3XEkLtSNC2iqmJl67f
 AXDz/HVo5v/2rgJ6sq7vy0+lywIZRHgIC5YtnFVrBC9b1NbskGI0LFDZG w==;
X-CSE-ConnectionGUID: RMEbtwyaT3So2FzOUL5UIg==
X-CSE-MsgGUID: F2Dc+F3uTqOj/p686iEi8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89825353"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="89825353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 10:58:49 -0700
X-CSE-ConnectionGUID: +kviFSEHQ2iiZ9ByFYOXBA==
X-CSE-MsgGUID: VmeBowlqQ32NCCwU7wFSpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="277861530"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 10:58:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 10:58:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 10:58:48 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 10:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFoxZ1+GTnqGnVRb/Ci7uUI+cV7WRhioy/8k+6af+ISw3WqgztGLdi/X4JAW9/cK8L/VmSxGCpiQzDTUkdzh36ADbON+JfGRiPHks26+mv0N6g46oiqxQj7AW+fOrXyCazPGRbnGayQtf5Or8UfuT7Zx8UOLg/ESx9TTDDGqjU3K4VDMZ64X5dZLdkCSY1b26M5wI5oI1WszfZcHMmRk+4K+NezOixlg4mH6GpFmdt+dC77GSEw0NVMpTvZFJIUQ3nESptIrqjA3fSQKKGNb5DiwCk7JRcvZrqP74R1gY18X7GoLu60dcVL8zR3fxI4vdUFMvzjlQHQfzUm1Onwung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnG/8ibfTFg2ugiuMDXLXNBe6RIL9/E7D1yrZOBPrwc=;
 b=hw8fyI2Hvl/jNMJuR9jTXUvPQQAec2oxshOEP/VcHDoS92N/yQzlgLDSJZXBoQzWJYjRkbpIxpBksGMED/plINKSPaH5+JNsVF0Jtu4B340ncZSxy2p2JZpMmYwK5R7uXkrGG4ThCDElNJhag1LyddR8o9flHgPm9+BoKZnbX5Nq5fVH28GiSbGHKthhSKrOA5O8chLr0BMd9CAbcwA33jPVQUHoyxq3tSmDn1E/pJpFT9H4c+MikSKAEtoSwK1o2kmo6hBs3YNeLN0LKlez+d7vIhjT14wHA11mFZBgU8X6UFKzamoNOm/I3n6/FKVSdKhy7qHZKwCaXOcq+t89Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by CYXPR11MB8756.namprd11.prod.outlook.com (2603:10b6:930:d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:58:38 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 17:58:38 +0000
Message-ID: <8536813a-0506-45f8-9ea5-e9d9e4feed69@intel.com>
Date: Thu, 24 Sep 2026 10:58:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Matt Roper
 <matthew.d.roper@intel.com>
CC: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>
References: <20260630225349.984AB1F000E9@smtp.kernel.org>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179014632773.19856.4107893493544612438@jlahtine-mobl>
 <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179018246485.152778.2589066724213973485@jlahtine-mobl>
 <6e40b68c-bbfa-47b6-81e9-5076738d0abd@intel.com>
 <20260923202952.GA730830@mdroper-desk1.amr.corp.intel.com>
 <8e01832b-4a94-4f0b-86c3-71664d22a326@intel.com>
 <179023451637.16584.7933241196219120051@jlahtine-mobl>
Content-Language: en-US
From: "Yao, Jia" <jia.yao@intel.com>
In-Reply-To: <179023451637.16584.7933241196219120051@jlahtine-mobl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To PH8PR11MB8040.namprd11.prod.outlook.com
 (2603:10b6:510:238::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8040:EE_|CYXPR11MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: a1145ca2-ef08-4cab-9d57-08df1a6575d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|42112799006|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: +E1/MY4IJ0hH5WBXBLAqO8vnbEQZ96iAZbXATL1tdg3l2XSAQR5BpNndxsTPCGdHuhoH53tGnvxQO3EZVV9NuJnhMTtSRa+/PcJYmHd/nq9/z1gwOjrkuDFdBsN5B3N8T3hVk74LcQGoBoZ0TGZ5nDOVCNRR0URnaz1VsIsPvVfIQClb3q90tGppyufmYOHLqoG4ALWjYhnh705aSZ5lLlW7FdiIiy1v8Wj4AodqFMffZ3LAFgUj1flAcNpXCi8HAZu1U2vYlusZwpqY7SLs/kdhDG7PWimFafqpb+8FaeW/dO7uMlcG23p/9G7wBAWq/NLrzpknOP/vpv6TPrAQ0uxyNTaWbVxpWyN5XU1pUDkABMnhWWAr34I1FiebaayVUZQmIjbariU/kDjm9uQIyoAwN6hYyKS04dttnmndj0YEUF3ySlWOHHc5pwkbBZ2NJvX+x1h0+7Mt9a4k6uOZxtG6WFx70TuO6bnlvWK+GSnhw2oHAglice81yZTmqSnUTYPGlRRdl0hCVaLN1KrbtD/1JxnsAJtJKCMgueY+a0cZuUH6MTj61S4+lHdItxZ1hfZuLsGxMFLV7ft4VhjLrwvCVa3rzpFZ/TmMKep0L9Y3qLAvOlQfLNuyvhNYqPJdR6ZeNoqFKHzHX3Rn/p/Vq8+TrpcUYZNXBDrTQRYftgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(42112799006)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pKOTE4clNVV04vOGNJdWlGcHdFVVMwcDVhS0R6cG83SXByY3RsNmtJYWpP?=
 =?utf-8?B?YWJkK3pyVGtMT0YyVU41QnNjOE5VQityc3VjRGRWWmpybFNKTHAyU0lxbEp0?=
 =?utf-8?B?bnhGSytoR2xmTEtOSHRyNCsyMFFocHBLK0l0U0lUSGk4VWg5eUk4UzNUb3ox?=
 =?utf-8?B?OHl0dVNEWWNuQ2xnK28yc0crU3BuZGczSlIrdUUvUGc2amNoenZudzVVR3du?=
 =?utf-8?B?aitWRldORjd1Qjh6OVFoN2VmSFc4RlcwYit0Q1JESDUwa2h0MVV3U0ZwSlJn?=
 =?utf-8?B?VlNLazZIVWN4RTl1WE5xTTBidjFlRmlpdmdLVmkwaXVyNEtLdy9FenNkTElC?=
 =?utf-8?B?ZkVtczdNZ1J1bVVVcWZPb0twOGowTzhwRHVVZVR2NVh6SEZjZXRIMUFpeVFu?=
 =?utf-8?B?TTY0UEJDRTNIdjdrWFJSM3VEYTRlQlJheE5HcHhVZ1J2bjgxQWpzVzhRbHlu?=
 =?utf-8?B?ZmRPc3ZNVzBYUXN1OC9jRU5RVjNaWStkTjVwNldUbzFxS25tWlZlZnpBOFIy?=
 =?utf-8?B?dEFPVTBsR1pCalJ1bXpGSzdEaFBUMDVubWxaQlNTZXhsalRNbFBhT25mTlVH?=
 =?utf-8?B?ZGJscmNlKzdCRS9UcjBrcnErRnJCZTJDOUx0WXc0T0VrZk1yL0ZIdHRqbXNa?=
 =?utf-8?B?alp3NU03NVB0UzNHcUkreXlLbHhsdXcwKzlla2NncFlYMXBnS0ZFSEIyMzdJ?=
 =?utf-8?B?bkY3dmFEc2FWOEo1UlZhbUYwK2FzaVJOM2tacnRiajZUdEJYT09ITmFQTENZ?=
 =?utf-8?B?SlZyM0NFWDJvL3JONENQL3VzZGdVWDd0M3dFVnNWVFhZcWNnOFVHN3BqL1hi?=
 =?utf-8?B?VTY5TktTbDZiWVBHeDBIRUU3aHg3dnZ4RklMdVIzUUxMOFgyaSt5MVgvS0pM?=
 =?utf-8?B?QWRpWEQwQ0liRVlzT1lkak5RenBkZFF1NmYvTG5rQm1IZWhSQWVVN2t6TzVT?=
 =?utf-8?B?cUNTS2tCd0ZkUytkaVhJQkdjdTVlQ3JwSmxubVU1TlpWWDhKb01WWTlzMzRp?=
 =?utf-8?B?azRpOWpJb1o0VmpoLzlpMnlVd09ZK1hEdU9VbGhMYzNDZUkvNnBxYitya1I3?=
 =?utf-8?B?aC9QcDRMQ1JIdUVMMURkKytsOVI3OGJmVmhNdDhNcWdNY3BIOGdaaHdEaUZK?=
 =?utf-8?B?b0hvK29OdUF5YmdKSkFmT1dGdWs2Y1VuU3gxUG94dWdDYzlwNVhnaFhQY2Q2?=
 =?utf-8?B?Y3VkUTREbTcwdmNYNDJIVlU2eXRoMS82M3lnK1JNYk5jOUtZMEdPWDZLU3E3?=
 =?utf-8?B?QkxVN2J1QWk5Z3l3eGNvcnR2L2ZUQVVYWVVWek5JV2t0bVJmRm1nVlNzM2tl?=
 =?utf-8?B?dHFNTzJYa2tBVmppdXN3TmVaMWFhSEVUbmtRTnJlUisyYnAyZkJpR1hqK3VQ?=
 =?utf-8?B?eVNOSjlMRkg3R1JrMk9mUkU3VmJubGNhRm9YRldzbWRCZW1tSmhWK3ErZnY1?=
 =?utf-8?B?a04yOUN1ai9zbXhpeDNDTTRSZWJWdlZYcDZPZ2MwTVhtOUxTcXkveDRnNGRK?=
 =?utf-8?B?ODlSd0I2eDlLdmVEQjRvK1FCdndsRVdoRExqdWVuOU00U0Z2bkh0TGRoRFdG?=
 =?utf-8?B?ZjRLR1Jsa3NwYnJEY0VKd1dySW1pSXN0TDVNWFZUYzZzK0FXSjNTb3VVS1FJ?=
 =?utf-8?B?TWdQMFJtdXhsVmIvTjhiN3JTM3lZZkRlK2U3QmhUeE1WN3orUm1yMW9ZQkJ2?=
 =?utf-8?B?d0lIVkhkQjVZV004cm9XUlU2cWRoM0NaSTF3Zmh6RFNtcTBkYU40UUNSTi9k?=
 =?utf-8?B?REZwQkc5eTlSaVRjRVZZR3FjWS9qa1hHV1FtZUxyQmM5ZndtbWJQK1h4My9N?=
 =?utf-8?B?R2tKV2s5L1NDdTlobEdiVFVlS0N4ckxwbzlCYnpTaktiY2I4eXZ2YzAvdWtn?=
 =?utf-8?B?cDhneEtKdUZoWVRIOWNUQi8ybGI4UEZlTHNOcG90NDFQYzBZUDZHR0hlanB0?=
 =?utf-8?B?bURYNlZ2cHlCTXQ2VG9UMVdBU3dTOG5NQ05UYnVWMm45eDloWEFTOTA1ZFFt?=
 =?utf-8?B?ZG5GTmFNSk5JS2VDYTBwbEZBYVNaTTI0QXpiRnhhVDhxalhleUY1eXJNOUtV?=
 =?utf-8?B?YkVxS3pzZU9nTms3bGZ5ckp5TVBvOUNIUFNtaU1ZbFVFNDl6RnZwaSs5RzJq?=
 =?utf-8?B?T09mcGZEcVFkaWNKOFlPd3VqVXE2UExWTHJCU2VnbFBwMVpHK3lRd0pSTllK?=
 =?utf-8?B?L1VXMzh0eG5UWCtCR0tubFp2N0VhSkZsMkJqMHdRSDNxa1JZVU1nT1NwSlox?=
 =?utf-8?B?V09xMHpKRnJBZCtERTkyN3hVSk0wZXVIZzlDajVOMkxhd1NCdE5Dc1lmR0RC?=
 =?utf-8?B?VC9qZ0YrV20yRzZpSVFob2xsTVRjQS9Kd2t0WnNmMlY5V2ZtZ3FRZz09?=
X-Exchange-RoutingPolicyChecked: RU0HmTsvU9Yg50c1+5lLOuwfzm42hroGBpjH8wcXz8vN1ZOP8nIF2esNlYXQqW2iROQatrLdmbCZy2WJAb8EdFlI6loJf8S00poimszpMuefT8yz0VFB+OPv2wiLKo8JYl7DCdrZHxSnHS08LgBxXXQ7to5iJqr2eAGKG+ZoEp91D7yLX2X3HDEGvAaOxEVuR6ZDOIwG40XCXyIycjvSc+QmQdAfSQoGUioYlLG6HFfvctnvVYV4TafM/0MledLuVxjMA/Y1zPKmxF1K2+WgkMgRZmuPXUt0kaZiJKbhJQiHYMgCxQ8k5/NCvxveSSGE67a1iVaARU0NDuXYz5wYOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1145ca2-ef08-4cab-9d57-08df1a6575d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:58:38.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBDxfe5/j/HnNTU+1Lo8t7+piPcRqy3IVtrhWWP7At6P7FLXDVF1pjpmyD5M5fm6C2OJ4PVjH/bncoUFASss8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8756
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


On 9/24/2026 12:21 AM, Joonas Lahtinen wrote:
> Quoting Yao, Jia (2026-09-24 00:20:51)
>> On 9/23/2026 1:29 PM, Matt Roper wrote:
>>> On Wed, Sep 23, 2026 at 11:06:56AM -0700, Yao, Jia wrote:
>>>> On 9/23/2026 9:54 AM, Joonas Lahtinen wrote:
>>>>> Quoting Yao, Jia (2026-09-23 19:01:32)
>>>>>> Hi @Joonas Lahtinen,
>>>>>>
>>>>>> When shifting from WA option #2 to option #1,    removing a global setting ->   adding a per-context setting.  We thought it was a per-context operation.  However, due to the "weakest link" effect, this remains a global operation.
>>>>>> Thus, making it per-client has no effect either.  Containers will interfere with each other.
>>>>> They would not. On the impacted SKU, the RCS and CCS at any given time
>>>>> can only run workloads with matching address space. Those workloads must
>>>>> originate from the same DRM client as there is no address space sharing
>>>>> across DRM clients implemented in i915.
>>>>>
>>>>> It's only when multi-CCS SKU would need the same W/A, we would need
>>>>> further scheduling decision to ensure 2 CCS workloads are not competing
>>>>> for the global setting.
>>>>>
>>>>> With per DRM client enforcement, both RCS and CCS should be able to
>>>>> write the global setting without a conflict. And when a context from new
>>>>> DRM client is scheduled it, it should be able to program the global
>>>>> value to its liking as the same address space limitation guarantees the
>>>>> other workloads are not in the HW anymore.
>>>>>
>>>>> Regards, Joonas
>>>> I understand the benefit of address-space isolation.
>>>>
>>>> However, The bit 15 appears to be a global register rather than an
>>>> address-space-specific state.
>>> That's why we're doing the special dance with INDIRECT_CTX --- by
>>> re-writing the register on every context switch, we've somewhat turned a
>>> global register into a per-context register.
>>>
>>> If it were possible for two completely unrelated contexts to be running
>>> at the same time (e.g., one on RCS and one on CCS), then we'd wind up
>>> with a case where:
>>>
>>>    * LRC A switches in on engine X and sets the register the way it wants
>>>    * LRC B switches in on engine Y and changes the register to the other
>>>      setting, even though LRC A is still running in parallel
>>>
>>> But fortunately that's not possible on DG2-G11.  On that platform
>>> there's only a single CCS engine (so no possibility for conflicts
>>> between, for example, CCS0 and CCS1).  And there's also another
>>> workaround (implemented in the GuC's scheduler) that ensures that the
>>> RCS and CCS engines are only allowed to run concurrently for LRCs that
>>> have the same address space.  If you try to run two unrelated contexts
>>> at the same on the RCS and CCS, then they'll run sequentially rather
>>> than in parallel.
>>>
>>>
>>> Matt
>> I see. However, if the GuC scheduler already guarantees that workloads
>> from different address spaces are serialized, why don't we use a per-VM
>> (per-address-space) setting instead of a per-client one?
> That is a possibility, that was one of the early suggestions.
>
> However per-VM level control is not foreseen at this time. So we
> probably should still enforce all VMs within DRM client to match.
>
> It all boils down what leads to the most simple implementation.
>
> Regards, Joonas

Agreed, let's go with per-client.

I will do indirectly setting it at DRM client level by first created 
context.
>> Thanks,
>>
>> Jia
>>
>>>> If the register itself is not address-space isolated,
>>>>
>>>> I'm struggling to see how address-space isolation alone resolves the
>>>> concern.
>>>>
>>>> Thanks,
>>>>
>>>> Jia
>>>>
>>>>>> Thanks,
>>>>>> Jia
>>>>>>> -----Original Message-----
>>>>>>> From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>>>>>> Sent: Tuesday, September 22, 2026 11:52 PM
>>>>>>> To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
>>>>>>> reviews@lists.linux.dev
>>>>>>> Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; Roper,
>>>>>>> Matthew D <matthew.d.roper@intel.com>; Tvrtko Ursulin
>>>>>>> <tursulin@ursulin.net>
>>>>>>> Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
>>>>>>> Wa_22013059131
>>>>>>>
>>>>>>> Quoting Yao, Jia (2026-09-22 17:34:08)
>>>>>>>> Hi @Joonas Lahtinen,
>>>>>>>>
>>>>>>>> For RCS -> UNSET
>>>>>>>> For CCS
>>>>>>>> 1. Old compute runtime -> UNSET
>>>>>>>> 2. New compute runtime -> USER
>>>>>>>>
>>>>>>>> If we take there's only one compute runtime version, and priority USER >
>>>>>>> UNSET?  Where's the conflict come from?
>>>>>>>
>>>>>>> See below.
>>>>>>>
>>>>>>>> But if we take there's more than one compute runtime version, and their
>>>>>>> priority is equal,  UNSET can cover USER,  USER can cover UNSET,  even with
>>>>>>> two clients they could cover each other.
>>>>>>>
>>>>>>> I didn't follow this part. How does the priority come into play?
>>>>>>>
>>>>>>> We have to keep switching the mode as the DRM clients come and go.
>>>>>>>
>>>>>>>> We should take it easy.
>>>>>>>> Once we reached USER, set by new compute, we should latch it, for the WA
>>>>>>> has been implemented by USER.
>>>>>>>
>>>>>>> That won't work. If you are running two different containers, you may have
>>>>>>> different compute runtime versions. Also, Mesa can be submitting to CCS too
>>>>>>> for async compute, AFAIK.
>>>>>>>
>>>>>>> To properly cover things, we should make it into per DRM-client setting and
>>>>>>> switch the mode accordingly when different DRM client is run.
>>>>>>>
>>>>>>> And for the given SKU with only one CCS, as explained earlier, it should be
>>>>>>> already guaranteed that two different DRM clients are not active on the
>>>>>>> hardware at the same time due to the address space mathing requirement
>>>>>>> between RCS and CCS.
>>>>>>>
>>>>>>> If this needs to be extended to multi CCS SKUs, then it'd be a bigger
>>>>>>> implementation effort.
>>>>>>>
>>>>>>> Regards, Joonas
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Jia
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>>>>>>>> Sent: Monday, September 21, 2026 11:47 PM
>>>>>>>>> To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
>>>>>>>>> reviews@lists.linux.dev
>>>>>>>>> Cc: dri-devel@lists.freedesktop.org;
>>>>>>>>> intel-gfx@lists.freedesktop.org; Roper, Matthew D
>>>>>>>>> <matthew.d.roper@intel.com>; Tvrtko Ursulin <tursulin@ursulin.net>
>>>>>>>>> Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
>>>>>>>>> Wa_22013059131
>>>>>>>>>
>>>>>>>>> Quoting Yao, Jia (2026-09-21 20:33:03)
>>>>>>>>>> Hi @Lahtinen, Joonas,
>>>>>>>>>>
>>>>>>>>>> The key is LSC_CHICKEN_BIT_0 is a global register.
>>>>>>>>>>
>>>>>>>>>> Even we use per-client,  we should consider the following cases:
>>>>>>>>>>
>>>>>>>>>> 1. Should conflicting configurations within a client be rejected?
>>>>>>>>>> I recommend the first setting should be latched.
>>>>>>>>>    From uAPI perspective it would be simpler to set this at the DRM
>>>>>>>>> client level at once. However we don't seem to have such uAPI in
>>>>>>>>> active use currently (all
>>>>>>>>> drm_noop) so you'd have to compare the complexity between indirectly
>>>>>>>>> setting it at DRM client level by first created context or adding
>>>>>>>>> such an uAPI to set it explicitly per client.
>>>>>>>>>
>>>>>>>>>> 2. Should conflicting configurations across different clients be rejected?
>>>>>>>>>> I think the latter setting can cover previous one.
>>>>>>>>> DRM clients need to be indepenent from the driver perspective, we
>>>>>>>>> can't do that.
>>>>>>>>>
>>>>>>>>> The whole point of making it per DRM client is that given the
>>>>>>>>> impacted SKU only has 1 CCS engine. We have the address space
>>>>>>>>> matching requirement between CCS and RCS, so when both CCS and RCS
>>>>>>>>> are running, we know they belong to the same DRM client and thus
>>>>>>>>> they will not conflict with the WA mode. And if only one of them is
>>>>>>>>> running, there can be no conflict either as it's just one context.
>>>>>>>>>
>>>>>>>>>> Even like this, still can't cover all the race condition.
>>>>>>>>> Which race conditions do you think would remain? We definitely have
>>>>>>>>> to eliminate any race conditions to land this.
>>>>>>>>>
>>>>>>>>> Regards, Joonas
