Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF91606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BsR4R4Dj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZljPWyvd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8710ECAB;
	Mon, 23 Nov 2026 23:34:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0669810E3BB;
 Mon, 23 Nov 2026 23:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795476841; x=1827012841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=sxeyVt9E+laZEQIgLzmOhtuN2x8o6sMEqaZPp96nR3U=;
 b=BsR4R4DjVdS/juQ1x5ry/zpUBibYJgkmPzwrr5BpklaGJfFFJoca1bTQ
 X8VT+VkGr2wYe5fyXR+5npCMc4llds1PHtpqp3033EzQtiAvvneYHhUxi
 b4Ci/jVxdRU6CE6fV7vNuJkwF8XmmV2uRUlgTnEt5FOHq28dxs73FE/+r
 tP6j7nvVA+TPUpHq3qHcvvMG5I2WewgwKkXl89Yom8APB0oZS5nL3lz0Y
 FJ78OEXJKjnOCHTPslzSMC28wCPuzELCs5kUP9jIrgAAPCf+XQG1duEGU
 21u8XnEk+3If/hXms1NXuk+Z2+9//cCsBXQBkKGoKBS9l0MOTp72h3aTG A==;
X-CSE-ConnectionGUID: ZxusSuLWT9qAyMeVj4olzg==
X-CSE-MsgGUID: SafGbFTLSPuxKkQvcKDdqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4194430"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4194430"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:51 -0800
X-CSE-ConnectionGUID: /nkWzWYqToOcPwKmQXpusw==
X-CSE-MsgGUID: DaMLvqgmQMWXIDVeQJXMMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11398719"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:51 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 15:33:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 15:33:50 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:33:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPvnu5oB1t6LVG8Kraolv5oU5gc/B/yaSRPFPe31tz4xJoZ8hI8ywPjGrUMFcRYRqLx4rZBugAbGGXGZ+vqbYjYQlqCjv5smnyw9RRoQRYyxC9mObiqAeHH2ONDgaNsZzUsuC8K4nU5ok4/wnW0ah4hBdonBas1KhrTBkL4MsPkxVQmMIX0dUqX28PzBIXq+mE08eg/tuFQ8VHmJatCMkK0wnMyIUAi/IXqxqE71IszGoQnwfheyWxeI2fQZ5f1xXWb3EvZd79wViU5s/GpiVheUmvOsoB1aeDjlovENXV7Vm984nDMQUQRlP439aRlAngrgrV0+ZMsiEYDuX1XnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EC/dQEPvwzah/bs9yeTHnpKkaOCwLH8YYcVHUNTiwk=;
 b=nzNei1mZzna1amTq71ZuM+j/BI4gqoXq3yovIRolPvT6z3WiJY8NffE7MYKMpPJgcD66uopBCjdosQpayJ6iYiPmL2BTEw881+KsZivVzVyZGoJcSwYWyYwT5dZJoB0MK/YDxQib4AQIUU2htBBgM0N1fxAWX7ouvHQLFJQ+uPmT9Ss9twSfbZFrpf+aA0rr/APt9tTp0cbKhupyM5dwAEPxloWOyBoTanKpviR2Gv8PhASy0Gj5Osw7jST8WZtqICFKYiFyD2+K0o+LnZ40U/A50Qwdjx0FRDpYvZ6hT4cXp9+nFPGMnnrAB8Vzf7fZ9EOutHEFwu8hkpzweu5N2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EC/dQEPvwzah/bs9yeTHnpKkaOCwLH8YYcVHUNTiwk=;
 b=ZljPWyvdUpzVsyaefq0RPAOYlrh6TkcVNk9KCeNJ/ClL5DDqxEhtun2L8nX5dxUAhkubw1jW7a70jmBUhJ3zQQUuYi1yipeLsjtIeniz7/uN5i+UcUItdVpYqEu4LGySxGn3W2M6fo33LSJHLx9Q12qb4VjNnyzptwpKPxbgzwU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 23:33:46 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 23:33:46 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 3/3] drm/ras: Keep nodes alive while netlink operations use
 them
Date: Mon, 23 Nov 2026 18:33:29 -0500
Message-ID: <20261123233326.2882114-8-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
References: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 593b38e6-02f4-417c-586f-08df49ba37fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261022075727099003|261021121427099003|261022113327099003|261021123027099003|261026121527099003|261026140227099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|261102130727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: QnTm+iWNOK8cDV33f2VlrX5yD84qCvY0e+Ivf6KwC9XWIqzcPAatGa6ZllwJjLsoBnrMPEJSv1GmVMa7MhGTF9UfFVKqFDJx0PYBdC3WxwBwP/RCtTXTVu1HWB6Mttiwwwo/Kk+bYpIZ88OhBAQnEpMHBvCe7F1iKBzFqUfV13vD5rPM2EMSmGgzj1HrHPP9FFT5nD3+9ra6qE9mobtS651d6GtAOC8LDLwdVFZkIkfIG9TlenCjHCKCnixIBnYYE8gv3vtCN2Ne9LgeIE3B4kDiyTCWJxKOhMqc4vXNKVCkHZgfYpNemlYd6KoVw53RhfZ219itz9HOuK4qODs0LPpHUU3x30Cx5/xZ++sxfEfCfiqv5uzqHXwYPkGmQ34//PlPcdHoUCqBS+7SBRQjD+F8Wmlza0uhZ5M5iOyhQ8fAnoIHwKwud8qTEgApiXvmS3f3+7d7oeUQabDjxG/2Egf5C331thMKoWWtYug4DlhdiEADeoSIET1hbHqY+U0F/b9hLoEEQwhGz4WFeBBkr7cLtImgx8ShmDIN5JuWDeLvV5/P5M1ZrnV9X1jsepdz5lvuj3ISwfOfLacSs+GXa7w5j9ZL8M00ZNKVTmHkmWhXUZjvGP7rY4SYAldXHZuKoFof8H4QL1u1CohR5QCO7LQs72+E7HZdoIYPsrrj8B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261022113327099003)(261021123027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261102130727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NSWTc4dlVVamh3MHRrTnVYek12NmY0UGc0Q1VVR1BBSVdQU3RqNHFXOGVH?=
 =?utf-8?B?SmtKN1hXMU9lU3ZpQnpuOFUzU1piRFFLdk5NUnB0alRPMjVPUjQyL2ZmaTR3?=
 =?utf-8?B?SVdQbSsza3pSK1BnUzBtYXpDalNNNDRSMUlkL2tuRnkyemlsVWE2OGUyM1Yv?=
 =?utf-8?B?SVN2eXpyUGxBUnRnZ2hUZVRzdkxCcDR6Wk1Pa25kY2t1ekdjRWxQZGk4OWZn?=
 =?utf-8?B?Rk11VkR5OVdZY3cvZm5rZXlRUkZPNWJrbHlyVnM3am5Pc09JQWs1TmVjRGlv?=
 =?utf-8?B?eDM3MjFCZmVVRitwcUtZR0tGc2NLNEZ5cERONHdBbGIrM09aSGEyKys4RXNR?=
 =?utf-8?B?UHMrSWt6ZlZTMTFmcU5pZVQyMWJ2aDhMUUVObEJPZlJkN3FoWlhZbzBsMmMv?=
 =?utf-8?B?ekFYZk9WR0xoRWd4TTFlUDFrbFdJei9NOG0vck9DM1ljNjBYcUV4YW0vZnYz?=
 =?utf-8?B?TGdvblRZQncrOFFpQ0x6MStUbTdkcXlQOXVTbGpLQjNLdVZxZjU5YW1vZWRG?=
 =?utf-8?B?UUJjUGlySzFlUFJGU0IrMWU5clF4S2xSM0Q3Szk3SkgxY1J6eWpySU9rSnVQ?=
 =?utf-8?B?ZWE0K2FBbFlQd25RR0JsYjViZm1UbzB2Z3M3ZksxUTlTSk14aWdIVm5FeTFn?=
 =?utf-8?B?UG51UldmckJzc0M1WkEwMnU0U0t2RW8yNzl0aEZNMUVzRSt4M0NEdk5xZkFT?=
 =?utf-8?B?RHhKbG1NaUJXYi9haW4ycDJ1M2hVSHQydGx3YW44cWVpRDIrY3ZncS9UcGJ2?=
 =?utf-8?B?TFhWTGg2YUY0cHJzLzlYaCtLSzBveVlJTXZSczFrem5QSnhsVVBLcmJrbTUy?=
 =?utf-8?B?L1F4M3U3UWtOYXBsOWNLb1ZQLzJUeWxBSWhBbGlhVm5NckN0WGROOTBieStG?=
 =?utf-8?B?aXI3MjhNaGtaaklKU00zV0NiN0pwNlFDRVBIS21xN1ZDMjBKRTZxNm9zcG1C?=
 =?utf-8?B?UTh1YkovbG9SRHlaOCswanlxQU41M29Fc0IzRENGWXo5SVdDQkh2RlpxWGhw?=
 =?utf-8?B?bUV0TThaK3BkVEFEMEErSUtkdUw0cVVMUzU5VkFiL005WVJHZzRBQldOc1kv?=
 =?utf-8?B?UEg2YUNwanIzWHA3U01RWlFGd0c1ZGE0OW9FYVozM1c4NlFyUWNhTU13d0xz?=
 =?utf-8?B?cEp1aWJMVXhtTkEyRkU0OTYxRWRERXF2alhwcTU4algyeHRVdG82VVM2Rmg5?=
 =?utf-8?B?emV6MjJ5bkZNS1VRak5LQzZmRk5URUZMTTIzRCt4Tkc5WmNiRzVBR05GQ2hC?=
 =?utf-8?B?ck5FV3dBNzRicm42eGpCaE1BdVVjdU0rOVNPZlJKR25MR1p2VHJ1dGEwN2VY?=
 =?utf-8?B?VXV3L1RDbm5mc3hpdWphWFJjU2dIL0lTK29oV2dFdXVLdy9BaWczamxXeFo4?=
 =?utf-8?B?dnFpRXhzYWpGMzd5b0ZXc05RNklhck5tazdBY1paVGpHa3RwQmtlUEtrUXZD?=
 =?utf-8?B?TlRpeDhLVGIxVllVdGt1YnlaSDV4L1dINnQ5L0FjUkVEUTNQT1JLVWZCWUlB?=
 =?utf-8?B?cFFmNlNMUFBYZHk4TlFPejJWa1B0bmYxcGRYMkY5NEZKVmRueGJOQTVoTWRK?=
 =?utf-8?B?VGNub1hIVkhoWFlWalIxL0RubkJaencybEwwT21YQTRHYW1adzd4MXB3eDVQ?=
 =?utf-8?B?WG1aVmkxOXE5NTVGbUZkUTA4WEJjMXVEejRXWlVUWExteWo4NXNZQmZwbnhr?=
 =?utf-8?B?Tk5yNlgwY3FCTjhpdncrbzZOdFlpR1k4RFpkN2k5T2ptRXNDQWsxS2pkVE90?=
 =?utf-8?B?YTF0Tm5rNjFQS09Cb2xhVTY1dDFYejdlSno0TnVodVpnNFVObFdiZENieHI2?=
 =?utf-8?B?ODh3VVlSVmRNOHl4ZzY2bW92aFpTQUxMbkFJK29zbWJabUhOeUI5R2xkb1Zv?=
 =?utf-8?B?MHhtcStEVlR4M2lsWWpFNFdmK3VYWEkyaVFKR3dBVlBjaFE4cHg3RVFzK2dP?=
 =?utf-8?B?UXVwRVBMaHIzckVOZkFna01SYk9xNEUwTnlvZTlRNEp6aExvRjl0UjVmWkFn?=
 =?utf-8?B?UnlWN1pVT1RZMDE3SlJWWTNvRVBpY3JrN0hvVkY2RlAvMDloR0JlVUdiSldW?=
 =?utf-8?B?eFFNT29WUkQzdVV4L1RmZlB5MEw2WmNPLzdoMFQ4TFBIaVNLYm0wQ0VWRi9G?=
 =?utf-8?B?bE9DT3NReXdsWVRoNXdNUHFWSjhyQXZWYjU3RWFqdWRYRTZSeTVFM3dzTkZT?=
 =?utf-8?B?bEZkSHNwUmpFQ1RicjZwcUNWTFd1QXNEUXY1MVhKeEdtRXpabTNOKzVQMmt1?=
 =?utf-8?B?WWN2T0JUenZvQkt5ZnJaU0Zic2F4S3dSTy9QeXdyZnBkR3FWQkJCYUVUUUEw?=
 =?utf-8?B?aEFhSWIrbitldzdLZXlESUVtVlJibVBubFpRSU0ydVBzQW1jLzJ4QT09?=
X-Exchange-RoutingPolicyChecked: W70MWTkKtnWiu+/1zJ91S7PUrIkiKyrlD76q2y4ShO3xCSSiCprCPLj2qVsl8QyScvpicSXiSbxtisr4SsKzt4g88ClFQHO896MixZFJg7kriUZLwM/VNPswVUQoi+aNh3yZ5TrhBpsh+8DIuv5l2eyN9YLw6unltHaCLWoZ6lTdRI9uQm8gGrVRojU1k/ynGMrc0q7pWqpGoL0CFoYj5+zWScmnCPsGM2Ed01PMAUFxBcCRMajox2cr+pH2BEldc3yYF/b8mX7YhqaMhESb2QEEX2gmbDYnqto4f9vZnUA06Z3lUv/Tdb1mBgPHK5rICQTT30YWYHZF8ATAuyJy6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 593b38e6-02f4-417c-586f-08df49ba37fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:33:46.3971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTCvGKW8t6qOMkFnTcK/n//IBx8U7VvyytvQAPnHONlAlgnLe3q6MK+ejN/yQKJWkfnxUY/d3QDW0v9Mhs/7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The netlink handlers look nodes up without holding anything, so
drm_ras_node_unregister() can return while a handler is still using the
node, and the driver then frees it.

Reference count the nodes: the xarray holds one reference, each lookup
takes another until it goes out of scope, and unregister drops the
xarray one and waits for the others. List-nodes only reads the nodes,
so it holds xa_lock instead.

drm_ras_nl_error_event() gets the node from the driver, so the driver
must stop reporting events on a node before unregistering it. Document
that.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 62 +++++++++++++++++++++++++++++++--------
 include/drm/drm_ras.h     |  8 +++++
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index f561604e7e96..550ca7d54cd1 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -3,6 +3,7 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -107,6 +108,31 @@ struct drm_ras_ctx {
 	unsigned long restart;
 };
 
+static void drm_ras_node_release(struct kref *ref)
+{
+	complete(&container_of(ref, struct drm_ras_node, ref)->released);
+}
+
+static void drm_ras_node_put(struct drm_ras_node *node)
+{
+	kref_put(&node->ref, drm_ras_node_release);
+}
+
+DEFINE_FREE(drm_ras_node_put, struct drm_ras_node *, if (_T) drm_ras_node_put(_T))
+
+static struct drm_ras_node *drm_ras_node_get(u32 id)
+{
+	struct drm_ras_node *node;
+
+	xa_lock(&drm_ras_xa);
+	node = xa_load(&drm_ras_xa, id);
+	if (node)
+		kref_get(&node->ref);
+	xa_unlock(&drm_ras_xa);
+
+	return node;
+}
+
 /**
  * drm_ras_nl_list_nodes_dumpit() - Dump all registered RAS nodes
  * @skb: Netlink message buffer
@@ -132,6 +158,8 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	unsigned long id;
 	int ret = 0;
 
+	xa_lock(&drm_ras_xa);
+
 	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
 		hdr = genlmsg_iput(skb, info);
 		if (!hdr) {
@@ -169,6 +197,8 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 		genlmsg_end(skb, hdr);
 	}
 
+	xa_unlock(&drm_ras_xa);
+
 	if (ret == -EMSGSIZE)
 		ctx->restart = id;
 
@@ -178,9 +208,9 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 static int get_node_error_counter(u32 node_id, u32 error_id,
 				  const char **name, u32 *value)
 {
-	struct drm_ras_node *node;
+	struct drm_ras_node *node __free(drm_ras_node_put) = NULL;
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node || !node->query_error_counter)
 		return -ENOENT;
 
@@ -193,9 +223,9 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 
 static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
 {
-	struct drm_ras_node *node;
+	struct drm_ras_node *node __free(drm_ras_node_put) = NULL;
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node)
 		return -ENOENT;
 
@@ -210,9 +240,9 @@ static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name
 
 static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
 {
-	struct drm_ras_node *node;
+	struct drm_ras_node *node __free(drm_ras_node_put) = NULL;
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node)
 		return -ENOENT;
 
@@ -374,7 +404,8 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
  *
  * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
  *          netns, which is unbounded work; callers in interrupt handlers
- *          or other atomic context must defer event.
+ *          or other atomic context must defer event. Must not race
+ *          with drm_ras_node_unregister() for @node.
  *
  * Return: 0 on success, or negative errno on failure.
  */
@@ -451,7 +482,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 {
 	const struct genl_info *info = genl_info_dump(cb);
 	struct drm_ras_ctx *ctx = (void *)cb->ctx;
-	struct drm_ras_node *node;
+	struct drm_ras_node *node __free(drm_ras_node_put) = NULL;
 	struct nlattr *hdr;
 	const char *error_name;
 	u32 node_id, error_id, value;
@@ -462,7 +493,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node)
 		return -ENOENT;
 
@@ -544,7 +575,7 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct drm_ras_node *node;
+	struct drm_ras_node *node __free(drm_ras_node_put) = NULL;
 	u32 node_id, error_id;
 
 	if (!info->attrs ||
@@ -555,7 +586,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node || !node->clear_error_counter)
 		return -ENOENT;
 
@@ -642,6 +673,9 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	    (!node->error_counter_range.last || !node->query_error_counter))
 		return -EINVAL;
 
+	kref_init(&node->ref);
+	init_completion(&node->released);
+
 	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
 }
 EXPORT_SYMBOL(drm_ras_node_register);
@@ -650,10 +684,14 @@ EXPORT_SYMBOL(drm_ras_node_register);
  * drm_ras_node_unregister() - Unregister a previously registered node
  * @node: Node structure to unregister
  *
- * Removes the given node from the global node xarray using its ID.
+ * Removes the given node from the global node xarray using its ID, and waits
+ * for the netlink operations still using it. The caller must have stopped
+ * calling drm_ras_nl_error_event() for @node.
  */
 void drm_ras_node_unregister(struct drm_ras_node *node)
 {
 	xa_erase(&drm_ras_xa, node->id);
+	drm_ras_node_put(node);
+	wait_for_completion(&node->released);
 }
 EXPORT_SYMBOL(drm_ras_node_unregister);
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 1765a3130b09..cadca07aeb64 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -6,6 +6,8 @@
 #ifndef __DRM_RAS_H__
 #define __DRM_RAS_H__
 
+#include <linux/completion.h>
+#include <linux/kref.h>
 #include <linux/types.h>
 
 #include <uapi/drm/drm_ras.h>
@@ -102,6 +104,12 @@ struct drm_ras_node {
 
 	/** @priv: Driver private data */
 	void *priv;
+
+	/** @ref: Reference count, private to drm-ras. */
+	struct kref ref;
+
+	/** @released: Completed when the last reference is dropped, private to drm-ras. */
+	struct completion released;
 };
 
 struct drm_device;
-- 
2.56.0

