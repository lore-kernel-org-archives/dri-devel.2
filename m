Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F17CDB466
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668F710E8DB;
	Tue, 23 Jun 2026 00:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gh8VSrDH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47B110E634;
 Tue, 23 Jun 2026 00:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782173384; x=1813709384;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QTuQQg19OvCPrO9ObxFxwjEvwM7koDCxhSVX5WQuDrM=;
 b=gh8VSrDH4ss8n2X8NpzzJZE6DETNUkivjTUiUnDkVrPnTJXUz1BXD2pG
 t0GzLKuvziRsDzxuiuk6wtcohvJKJpMa5kLxAD+ktijm3Y8Pk9OEDWJ6Y
 rsrWE2Okiq5wU/BIEx1sX1GTPSA0c5doxkw9blLV9oUimCJVWK09TwLvn
 mwdNfw8rbBE01s9uQXsMiHeizyxCqDH4QC9KAoQMIMCEDDW8FGGAbJH2+
 PaCiKVUTiQj6rNFjSkl34dnHvEFu6WA2wJTml89HF3XiA0HkxNQynALur
 Pas4UhUCIidNiS2AXqi5rgG0RGsWdQwLa8j1f6sOTplbC1FgZy5Rqx6YK Q==;
X-CSE-ConnectionGUID: Xsc5L0r0R5qfBqHZk+gJrg==
X-CSE-MsgGUID: jfKJVuZAQz+3ROw+dBfDJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82951885"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="82951885"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 17:09:43 -0700
X-CSE-ConnectionGUID: 9Hjoe44MSXytBBMXxjv4tQ==
X-CSE-MsgGUID: IDGgJJnORtSuFGOXrzA/Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="245223748"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 17:09:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 17:09:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 17:09:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 17:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVLSV69Hs0aG+J/tTr5nDB55ZivGRrLHzrvkA3z/HbnaTmIGt8jqOgSIEX3kXwZxTiedabCHVRa6bHcN0z03AeFG5fpjsAYyXRuiHp3wQ02Fu9vsZtu9BIMYzXz3Q6TSOi0qzwBVDNrZD4up1Im28Hx9vMvl2QQTCkr/JtVbCzJBMVZn/Vnxp+dNgUA3Paay72wdJoqmSEl5mUinxPyOCSki21g2ZCIhX2PrqTWVvlc4LIOFvZmDtyiz7W/bFL9iBWzfvP/tFBcenBxEM2dZtYSMxnhk/MfcVGia4QzRDIN8hxNANZHspyNbyaf6NqMedKlOTFuxRQkBHS/GIrRDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfyF9b37GXKg3n4TK6gov5hDAQTagJXi2PCca2i2Gn8=;
 b=mC/KJKBMsokWzGESn9h7NjSCPwCztPEcdOLRjy+5AvEJOc4qztFpvNCVo4LryNI4F/PfD4LhRMUogCO5M6fMDcWpp1fHZvdXGhf9U25PWgRh2rjirqIJXIa3rjYOWKvWl8BxOweqVZQ6duWLXsdxITNxKv8wutFJqgxIDXkIIg8L7xNp60mN6ga6Bt4T9ZIj2YNJKtt31cp8dPkhrg2Ym+TsN+fa4/3d7ssY0GjQYP43luR3bbGAsHO/jWnhBWKVT7ZctaJnvDuO+Ni6tkglBjL2/uz24/gWFUkM8dVCu7wY33aWEB3uJNs+2XY8o8dsK2p3uYJQDULbwiRTCUP6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Tue, 23 Jun
 2026 00:09:39 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 00:09:36 +0000
Date: Mon, 22 Jun 2026 17:09:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Chinner <dgc@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, "Qi
 Zheng" <zhengqi.arch@bytedance.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH v6 1/2] mm: Introduce opportunistic_compaction concept to
 vmscan and shrinkers
Message-ID: <ajnOvdbT5/J6q3IN@gsse-cloud1.jf.intel.com>
References: <20260617032218.1165929-1-matthew.brost@intel.com>
 <20260617032218.1165929-2-matthew.brost@intel.com>
 <ajnA83DxAFqeJ-sv@dread>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajnA83DxAFqeJ-sv@dread>
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a028e6-6fe4-4d3b-e0e5-08ded0bbb632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|22082099003|11063799006|56012099006|6133799003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: z07B+Jjl9hSo2fXFObUXj9FfTzkb61Vawm2mr8jvSw6gYKl5DaGPiGmqdJqyLNFm/9gE97BUQjBjlhLHd2o+ME2AMesbDVXqPQA4WWig0EksfWU4hhEvpMIHoHBkJBanukP5K8tjR1gApqRVii2FdCEYfK/V+9kNGGmUn7jpdN9Q6XPgcn1Re/uJAt5QRAJrT+U85cHgEtrqBeUPxcp7WYQ5/l6HsFxwxxushTLfrckcXPwFoOcxcACczPBeFiYRweiIroDy1IR71Fh+F/S+DrWRe95LXlKRyGWWlvV4q1eApSTLMZ8j6UMaqFbG9GbyYeRbsp6iNWcOCte9SjszSxE1Ux64YohS40lqaide6h1OX1BlBFPF/ML0SG4Lg5awcJEDY0ErioyTLfgwDQdQGVftwalTH5yj57eWfKyNOjMJh4A+/7j5NY4Fa5Gk2xaXxScxwwqs5Pzk/C77RFgT6h7x82Qpl9Pe7uNys92OQjKzcpZ6RPC9Mty0JKIIJBqrtoxxdCb0mF7fSXqMWWomFOeFRFTOzi00PsISKcnf+GV4ln/ff9XZpvEin3jFGrElAu7qcTbYqYkDWti/Rfohy3BTVJ6GCobLtmIIXEsjRYtFjIMLrJY5MvYiFCNXOnzSwzVZIABpKoeWiNFospXDzMf1OjEvWGJXmQkfgQsvhV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZlaWNYNHlYT0pQamE0UngydDdsWE1lRkVnclhtdkpkU1hGcFdhL1c2Ykxn?=
 =?utf-8?B?NDRCNEpDRWZyVkZYVS9DTzJHNE9uY2NlK0NKbW0rQjhaNW9oNFExYU4rRWEw?=
 =?utf-8?B?eFZza0dWUEV2ZUFmWGdyMmQ4WWhrR3VaeVdzRjZiRkpiTmp1M2lUN1BwQUVX?=
 =?utf-8?B?TVFIM3c4MUk3YjJPejYyTkZ2Tk1VaUNNTnQrM083cE43blZxdmduSWpBc1RN?=
 =?utf-8?B?TWxTd3l2S0JNRmtid3ozM0ZUZDVFWkRRTENoR3ZrbmhtUkJTR3gzSXh6NUZT?=
 =?utf-8?B?bTdTaTJRamd1N1U1UlJXcXlIK2pJQmVOa2Fwc0d2TGdwZjRIaFcwWUFXLzR6?=
 =?utf-8?B?c012ZkdkRkFPQzVhWGxBU3UvbmVDNXNqMUpzY0xBNlZjelhnNnlZM3pNQ201?=
 =?utf-8?B?enpKa2R2Nld5SUFEaXRZR3BJcVM3ZXBBbVBzWURxSXNOMDc0bHlWYUpqWGZI?=
 =?utf-8?B?RXBsdXN1Tmp6NW41eFM5UmpnZnViNFFRNmxJbXp1aVQrbDl3cjdPVTRXeVdM?=
 =?utf-8?B?YlE0WXNlT0o5VzhVc2RPYmpUN2hISmVlenVwMkJrWDcxcGdvRlNISVk3MWFL?=
 =?utf-8?B?bTNGS1NQY0VmSGdmeGxJTnk0SWhDdW5mUmljWmorQjlYbktVckhHc2NmeXNQ?=
 =?utf-8?B?RklocjljL3hER0ZSYlFDb0FuNGxCM2N2cEtFWmpic2lmeVJpQVdZTk5TUldK?=
 =?utf-8?B?eHdlTjg2dW96THo2bXZiYkJWbDI3UHpwMnlhMkJtQTM1SUM3TDlYNEZwSlB6?=
 =?utf-8?B?Sit5S1JrdTJZVFFjWnIrKzRwRlpaSVNZTktNL1NNWFNGT1B4VlJZcmVPTWc3?=
 =?utf-8?B?akM0aXZDM1RnMWI1TkhIdkFTVVVWMWk5WGtmSDRnTVBBR2NIQXMzS3RyNWtC?=
 =?utf-8?B?OWhwRkpzMStWNFU4MWdOaUppNi8zS0JhOWNtcG1WaU9xL3Q5SkhkRjJvM3Ix?=
 =?utf-8?B?L3hCcTBDTGpMSURXbXM4NWRwaHpUZGlEdkJSeWdvdUtBRExzdjdWN0hDTUoy?=
 =?utf-8?B?Z1prRzBIb01aOVV5WXV2ekFXaVZjUjVyRllCTGx2bExPZnZDbWNtVFlPVGF4?=
 =?utf-8?B?SUJjSkpNdHBDR1ZjdVB3cUpyZlF6WGsrRnk0VGdTNHJFZkFyeGp2emZGaGh4?=
 =?utf-8?B?TWhtWVBxRVNNTkZKMXp4bExRbVN5cVA5Z1hScUdmQnVocy84MzBhN0NUTlVN?=
 =?utf-8?B?OWxQZzQvZzJ0ZVo2OFAwNGJyczRiU2d5d1Jubk5tNnIxaG1kTFIrcW1YQkZy?=
 =?utf-8?B?NlBKd2grNGJ2eE44RzVuL2pFSlV1MXhzSUZvU2UvYnhlbkZaMkpBZGNoWVF5?=
 =?utf-8?B?Q3BTOG00ODI3bktYdW8zWnRITFVvNjZUdklQKzF4eHc2SjRMUmRYK0dzc2dq?=
 =?utf-8?B?VHhkOStDM01Cazd4UGJQeCszeE9tUmxNU1REWnIyaXRQTGRvdW5LamdjaDBt?=
 =?utf-8?B?bTJxSFcwejgrdXdjcTZ2WkpKbFg4RUMzUTV0V2lycVF5cmp3NHNUOXdJdDJz?=
 =?utf-8?B?WFRGV3NiYVpjOWEyd3B1b2htZVdUT2R1K29RaUl3Q0R6MHVycERpR09iTlVN?=
 =?utf-8?B?QUlzZC85RW9OZGdVeFdUQ1Y0bjROVVU0VDJaNmxoWW9ONXJwU1FvYzUwZm40?=
 =?utf-8?B?L3lnQ3g4dXl2Q2JSOXlUMzJpaFkwZ1pFWlA1YjcyU3lXc1ZHdElraVpBdUU5?=
 =?utf-8?B?RFRQT3lLL2NvTHk4SVRqb2diMEtzUU5LNDlKYkMzTFFCM0MxYzllZDc1cmk0?=
 =?utf-8?B?NU1BZStDWThFUGI3WDdEL1EzdzgrRFpqdlNGNTg3akxPR0JqRzhNOU5QYTNq?=
 =?utf-8?B?UCtsNUVVRzhKYWxERFArMjRpZjUyRFVCamJRN3hQZTF6cG5DemRmeHZqZGJ3?=
 =?utf-8?B?Tm44Q3NMQmp2Y2NBNVhGZEIzbEpoZkFxbG5OMGNzbTdnNDlESHNiNFVoQUts?=
 =?utf-8?B?OG9MNzhkSm5BU0R5WnZpV0NmcEZ3Y3FiQzNvUy9NZnUvNzJuVitBOXdKRVh3?=
 =?utf-8?B?K2t4dWtlZm5BY0oxcnBCRFl5VEJQM1Vnek1rUjJQSnNuNmgrMFNIN1pPT2J1?=
 =?utf-8?B?OGFnS2xlaXhkNm8xYWJzVWw0cU5FRGkreStieDE0azVsZ3I4clNadEpvMnlM?=
 =?utf-8?B?OHRPcTJCb3ZZM3ErdGNMRVM5elJROGgzTlZ2eEpTSTBueTFNalVXUjFTTy9i?=
 =?utf-8?B?NlFPYTNldStkSS9UcDU2Znl0NHFpaVVnN0FCOVRlNUdsUUJYWEF6RytuY25p?=
 =?utf-8?B?d3ZiN2FYZmZNSmVMeVRWZTZKWHFTL0dneStnTFVVS1MvN2U5RVVvUnBxSk5k?=
 =?utf-8?B?T2UyUmNjRlNmRE9hczhNQ0d4eDB1c0NlRkVVak1RaDB3ZTIreElQWHV6c1cw?=
 =?utf-8?Q?eE/S5jpdjtxNVpv8=3D?=
X-Exchange-RoutingPolicyChecked: HZyd26v+b5Q6r6UyO1H/aLwagR8vQ2FukpBn8y1SeMjpGbtKq9mC4/5I0IucCdfhRNzo71+QnMwdn/hXl8wBEC1E1hbOD/KYicuQ74ugfJ+U/Z1QVk1v9i/RGlNFxOZRS/7C2BM9T7gi75OpwHIw8T+JFEaX4OfeCUwUSLdYc9TaWwE07D+kP3aeWdgpsobXsFXc4uC4fDgt8Gzcf/TWZwcNxpJHDowhszXSR/FAdr6N2A/kwNME5bSe8FBjU+5MMkMeBSMc/Kn+j2bh9UeBCFA/f1YwMU1CDa/cVjCKcBJfPlwanAlRAOWEcUwz5loDIbLDZqOS7o10T4cdEVLCZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a028e6-6fe4-4d3b-e0e5-08ded0bbb632
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:09:36.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apz9zJFmls/2CIoK0isAEKMInlkeN7D+03lKdcj/zgi2gXc0R6vwK2y3az+EjFcYLlY03QdWxJg2h8gLEtB0Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
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

On Tue, Jun 23, 2026 at 09:10:43AM +1000, Dave Chinner wrote:
> On Tue, Jun 16, 2026 at 08:22:17PM -0700, Matthew Brost wrote:
> > High-order allocations using __GFP_NORETRY or __GFP_RETRY_MAYFAIL
> > are often opportunistic attempts to satisfy fragmentation-sensitive
> > allocations rather than indications of severe memory pressure. In these
> > cases, reclaim may invoke shrinkers that aggressively destroy working
> > sets even though reclaim is unlikely to materially improve the
> > allocation outcome.
> > 
> > Some shrinkers manage expensive backing or migration operations where
> > reclaim can result in substantial working set disruption despite the
> > system having sufficient free memory overall. This is particularly
> > visible in fragmentation-heavy workloads where reclaim repeatedly tears
> > down active state while kswapd attempts to satisfy higher-order
> > allocations.
> > 
> > Introduce an opportunistic_compaction hint in shrink_control that allows
> > kswapd to communicate when reclaim originates from a high-order
> > allocation context that may be fragmentation driven rather than true
> > memory pressure. Shrinkers may use this hint to avoid destructive
> > working set reclaim while still participating normally during order-0
> > or stronger reclaim conditions.

Thanks for the input - this is a tough problem.

> 
> To be honest, this seems like another "push a hint through to the XE
> shrinker" mechanism under a different name. You seem so focused on
> fixing the XE reproducer that the -systemic problem- that -any-
> high-order folio demand causes is not being acknowleged.
> 

I'm not exactly sure I agree here. Communicating via __GFP_NORETRY or
__GFP_RETRY_MAYFAIL with a higher order implies that the caller can
handle higher-order allocation failures, so the shrinker shouldn’t try
too hard to obtain a large page (e.g., evict a working set). I agree
that Xe is currently the only shrinker making use of this, but other
shrinkers could also hook into it. This information simply isn’t
available today.

> e.g. we use high-order folios extensively in the page cache these
> days, and there are -many- cases where memory compaction driven by
> high-order demand cause significant performance regressions for page
> cache performance. To date, every single person who has wanted to
> fix the problem they are seeing has effectively attempted to -turn
> off compaction- via GFP flags.

So does that mean they clear __GFP_RECLAIM?

That isn't really what in DRM or Xe. In former case we have pools of
lower order pages in TTM not in use that can be shrunk, potentially
freeing multiple lower orders pages so a higher order page formed, and
the later possible BOs (sets of pages) in Xe marked as purgable (not is
in working set) which can also be shrunk. Other DRM drivers have purging
concepts too.

I’m not very familiar with what other shrinkers or subsystems want, but
presumably other shrinkers have pools or caches that aren’t currently in
use, where they can say, “OK, I’ll give these pages up for opportunistic
compaction, but I won’t give up my working set.” Of course, as mentioned
above, if someone else explicitly requests large pages by avoiding
__GFP_NORETRY and __GFP_RETRY_MAYFAIL, the shrinker should then give up
its working set.

> 
> I've even done that myself inside XFS to work around kvmalloc()
> issues with a lack of GFP_NOFAIL support and doing costly high order
> allocations that fail and trigger compaction before falling back to
> vmalloc().  However, these issues have since been fixed in the
> kvmalloc() code, such that it now does the right thing for most
> calling contexts (i.e. tries high-order kmalloc() without triggering
> compaction, then fall back to GFP_NOFAIL vmalloc()). This has made
> kvmalloc() more performant and better behaved for -all users-, not
> just XFS.
> 
> This is not sustainable - we need compaction to be robust and
> performant in the face of high-order folio demands, regardless of
> what subsystem is generating the demand.
> 
> So with that in mind, let me paraphrase the comment in the second
> patch in the Xe shrinker implementation:
> 
> "Shrinker reclaim is based on implementation specific object sizes
> so it is unlikely to ever acheive contiguous page reclaim in a
> manner that will measurably improve compaction rates."
> 

This might be slightly misworded—what I really mean is that I don’t want
to give up my working set for higher-order allocations that are allowed
to fail, but I do want to give up my cache.

> You also say:
> 
> > No functional changes are introduced for existing shrinkers.
> 
> Consider how many shrinkable caches the general statement above
> applies to, and then think about the fundamental impedence mismatch
> between the affected shrinkable caches and what this patch actually
> fixes.
> 

Yes, as mentioned above, I’m only addressing Xe here, and I agree that
this is likely an issue. Do you know of other shrinkers that have pools
or caches which can be shrunk under the conditions I’m introducing here,
but also have a working set they would prefer not to give up? If so, a
link on elixir.bootlin.com would be helpful so I can take a look. I’ll
also try to go through other shrinkers myself.

> For example, what happens to slab-based caches if the XE cache is being
> excessively reclaimed under high-order page demand? e.g. the slab-based
> cache may have tens of objects per page and holds a system-level
> performance critical working set of objects. How do these caches
> handle the excessive reclaim demand being generated by compaction
> thrashing?
> 
> Yup, they don't.
> 

Agree.

> In the case of filesystem caches, the "reclaim and repopulate"
> pattern you describe causing the XE perf problems causes internal
> slab cache fragmentation. Not only does this not improve compaction
> rates, it also results in more memory fragmentation because slab
> pages get pinned by a small number of long lived objects and they
> won't get freed until the cache is largely emptied.  IOWs, things
> get -even worse- from a memory fragmentation POV when compaction
> thrashing causes the working set of a high-object-count-per-page
> slab cache to thrash....
> 

Got a link to the code which you are referring to?

That seems like a problem similar to another issue in DRM/Xe. We found
that the process of shrinking actually drove fragmentation by splitting
folios down to order-0 and then backing pages up one at a time. I have a
separate fix in flight for that.

Could the filesystem detect these hints and avoid shrinking in a way
that causes fragmentation? Alternatively, could it perform shrinking in
a way that doesn’t shatter folios, or detect long-lived objects so it
understands that shrinking isn’t going to help reduce fragmentation?

> This isn't isolated to individual subsystem thrashing.  If we run a
> file-based workload that generates high-order folio demand and hence

What GFP flags are typical used for file-based workloads?

> compaction (e.g copy tens of GB of files between two XFS, ext4 or
> btrfs filesystems), that will -also- trash the Xe working set via
> the shrinker being hammered by memory compaction try to free up
> contiguous pages for the page cache.
>

I could see this.

> Similarly, if we run a Xe workload that generates sustained high
> order folio demand, that will trash the working set in the dentry
> and inode caches and any other shrinkable slab-based cache.
> 

I could also see this but DRM / Xe will set __GFP_NORETRY or
__GFP_RETRY_MAYFAIL on higer-orders so those caches should be able to
not trash its working set if looked for this hint. 

> Hence the abstracted case of the problem we need to solve is this:
> shrinker reclaim is based on x-byte objects is extremely unlikely to
> acheive contiguous page reclaim in a manner that will measurably
> improve compaction rates.
> 
> This is a problem that has to be addresses by the high level
> infrastructure level, not worked around by individual shrinkers.
> 
> IMO, compaction shouldn't trigger shrinkers unless the shrinkers are
> specifically flagged as being able to release contiguous pages of
> memory in short order. I don't think there's very many shrinkable
> caches that even hold a significant quantity of objects larger than
> a single page, so it's clearly questionable as to whether compaction
> based reclaim should run shrinker reclaim to begin with.
> 

Yes, sort of do this in Xe by changing '->count_objects' based on the
hint.

> i.e. a subsystem that can track high order folios in a shrinkable
> cache should probably have a "->compaction_scan()" method that is
> run directly from compaction context to try to free high order

When you say “compaction context,” which parts of the code are you
referring to? I’d like to explore this option, but I need a bit more
context.

> folios. This provides a direct opt-in mechanism for a subsystem, and
> it allows subsystems that can track low- and high- order objects
> independently to efficiently free objects in a way that will help
> improve compaction rates without impacting the entire working set of
> objects in the cache.


Does this help if, for example, the cache is holding onto two order-8
folios that could be freed and merged, while the caller really wants an
order-9 folio? This seems like a possible scenario in caches and is
certainly true in TTM pools.

> 
> IOWs, this patch to inform kswapd about it's trigger (doesn't it
> already have a "reason" parameter, though?) is likely a necessary
> part of the solution - we don't want kswapd running shrinkers if it
> has been triggered to reclaim pages for compaction. This patch would
> allows kswapd to elide normal shrinker passes when it has been woken
> purely for compaction purposes. Given that the compaction code would
> be running the high-order reclaim capable shrinkers itself, this
> would avoid trashing the working set of most shrinkable caches -by
> default- under high order allocation demand....
>

I’m trying to parse this—are you suggesting that, one way or another, we
introduce a heuristic where shrinkers can act on a hint (whether it’s
what I have here or a new ->compaction_scan() vfunc), and then attempt
to fix all shrinkers in this series? I’m open to trying to fix other
shrinkers as well. Do you have any particular ones in mind? I count
around 45 shrinkers in Linux, so it’s unlikely I can fix every single
one, though or all shrinkers need to be fixed.

On a side note, I just noticed that struct shrinker has count_objects
and scan_objects as individual vfuncs rather than using a const struct
shrinker_ops *ops. Should we change that? The latter seems cleaner and
is typically how things are done in Linux.

Matt
 
> -Dave.
> -- 
> Dave Chinner
> dgc@kernel.org
