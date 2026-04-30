Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E64EFF8864
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 03:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD7B10E094;
	Thu, 30 Apr 2026 03:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d/Ca83/x";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573E510E02D;
 Thu, 30 Apr 2026 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777518284; x=1809054284;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=egm9tiBT6q/gEpazkLZkrzaISsxE/n65d7mgzr7oxhk=;
 b=d/Ca83/xOm6lQH/VWW+X5MtqsOMSIy6/mNCBb9KYzOA6aC8+Bp0TXWe8
 ky41KvwDWLo4zAN+jqGvl9wURPGnU6fs0dcYZGbDR5zjmMU9XhiqizfMJ
 ETlPPF5mSM1cff9ROmkzYAmSBQYWFm1XUarvmRMcr8eD6HSBC8UOsGKbk
 iA2bq4AnJ/ESkEY7LXAdvfHCMJVgrFxDwKDTu5vUmlJXls0QBoJfmRuP3
 p87oIv0uQW7TarbdINrsXCiTmFPWg4TzmfYSsgaPZydQEPs3w3hN+hmHf
 F29yO86J01gARL389jB9pXVuZPMBFwpo6snJhyNkBt4koa1pxhRaA9mC/ A==;
X-CSE-ConnectionGUID: bEHT4RMvT2ahovEG/Z3Qwg==
X-CSE-MsgGUID: 7F1mEwLyQJ6jnUo7ohLLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78448722"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78448722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 20:04:42 -0700
X-CSE-ConnectionGUID: Rf56MRgFRlmk+xpXCbeFiQ==
X-CSE-MsgGUID: QE+Za7U0R++WU5F/T2mSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="230098265"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 20:04:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 20:04:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 20:04:41 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 20:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzj7dKw9NxDfjdcY3fngXfTlKDE4nxDOJzAwD+f3aareQHZtDydKuXzIpRL1Lo0T/EfqPcM64yYwPL1q86UHGzJ7RFKGkV8+p326N1AY7flFsLOae9xNbL1UmYrXKeicoVgRESszqTUE2JXfJa06nnxb5GtCuEKV4aD0CbY5BcnTWRwQ84FnVv4SEiEN2sfeD0nAe85nfkWMPZuKL3I4y6MZ3F8N5OMSCr430XHWIxMkmtoZrUfJbKajj1xHRAcwFmdR+N3+QNobdVlom8n4dXzPXTICz/eyl/sq5zBYyaQoguK6imLSjEk/mnhEip2bewyfa6rdoQmnf5siYawOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVjMRW12oKXfb8f0MxDhTEKsyzuLjFV7HYLAzvk7bXY=;
 b=aLNkJrj3ebNUrbsDOS3OsP8umuHa3fzjWbV97x9QV8xjgqF5nYT3fCzMDAJkaGIuu94+cPdLJ7oBzFVRtzuwE5rfPmyiZrrpLZWtbSemetsq5gweYXzXXrPxUecohzS8XtseJKpPbBY8kVOQdqLwuu5jBcE3iYPIfQQQgD+nCq43Aqn4qHVNTiFB8uaE9brbzgcCTUyiHzO5827AxK7SPNSPCyRG9YheHadavNc07ofzWnII9jq1+RX5Xe8i5y5Ewk7jm0pRHMZpDhL+0Y1mN8Pozz/coET8hfeJW6UXsITueccJ+wfbeU+zhsEdA7CgWACOSlkUFYS3RGztpLojrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 03:04:38 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 03:04:38 +0000
Date: Wed, 29 Apr 2026 20:04:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Honglei1" <honghuan@amd.com>
CC: Felix Kuehling <felix.kuehling@amd.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>, Honglei Huang <honglei1.huang@amd.com>,
 <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>,
 <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
Message-ID: <afLGw7CTYgCVvVIW@gsse-cloud1.jf.intel.com>
References: <acRgr7QwdULsn6G2@gsse-cloud1>
 <d2fddc5d-2628-47e3-95c5-874b3a0466be@amd.com>
 <5fb57768-35b9-4e48-8178-2e1760a93aed@amd.com>
 <aem++OfFRJqHAPTG@gsse-cloud1.jf.intel.com>
 <aenH0REel7/enRi+@gsse-cloud1.jf.intel.com>
 <812102ac-906b-4fbf-bc8c-1881493a3eca@amd.com>
 <aep/S6m7vG5K7Ra9@gsse-cloud1.jf.intel.com>
 <79e9730b-80b5-4517-9942-fb6ec1569276@amd.com>
 <66a7efd4-8ec9-47af-b6c4-5be25459a474@amd.com>
 <9b4e3f7c-5d32-4b7b-a270-703325926f86@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b4e3f7c-5d32-4b7b-a270-703325926f86@amd.com>
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0464e6ec-0983-497f-c8b7-08dea665372b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RuELZH6F+Nm+FoDTmxJ9OmXsjswEyYh16pP4VF5M9Vl9MdGUJr+Qlfu2mdRB5YrEMoqkLb/MvdCt1BXHUIHDps3aisEeFLb70wJgeVwQc1M0CKYh0HZeJ2q2S6NWPBD7k2cZa6jG4/4mI6LTAO94aKlwiCIhfg9teDI+dw888VRGhUi41xk+554niGkYOzVxF7VqJjUnKUq9yzSSG43lNFOlE1djKVB5Jb57vLBLUH8rRB5AXQS/4shWcI0iKPfrmyPjFuQEJn4AcnjGJ/dfvR33mmtETswzL8A8hI7sN5k1Zl7Sci0+M+A13ffIyR5RjLg82NTJc9cGQ+YO4bqbX37q0Yj0wgM6axwJB5BBRSsSMG1tFQPRvTCEaVabClb7aHN7gMIfstKa+eq2aYUphXVccczNRIx1F+dG7giKGvRCDvKCFkqEdzLg3FdeiE06NgxEwxcSI99MTlNRsFHXuc88g1RVnRaZ5M32Mzx6PovC8Uk2sMegTsj8Hc4HEx2oPVQvHD/TYcFXKeqBLEVIUQ/FH9WzefoWDP32YFGwzW8HM+2KTqz5ZjLWJGjEo2MSNMiKd/DUEs7Uf4SPr3N+HLI3weSwTjAfPjdLKZU4e47EvudNjDqah2NCRNxFCO/XOllj5oOWtdN6okNEiEqjW9I6Ith4QV5bBr3++yAR3W4YsRaM0v7Q/SS/6lxUS6GI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVPRTlRRkFwRnZ4Y2M3Y3FkYk9PWld6YUJaM09zSFo2NklxMjhmTTNERFlq?=
 =?utf-8?B?Kzcwaks0RDRzQkRER3hVYmxFc0d6dnU2aWdkUmRma0pwOGcxeXIrbG40L0FO?=
 =?utf-8?B?bE1zM1UydWZpZUtGRmtWK1RONHZ6ci8rYjl3emF2cUJheThWWGxITkhFd1J5?=
 =?utf-8?B?Vk4wSjl3S1ZyOTVjeGs0bE5PdjE3bFlOdFZxSWg0bHhqU3pqUktVY3dTU0gz?=
 =?utf-8?B?dmZHUFUvNVUwbTZzblY2TG5teXY0VUs2NXo0eWtmUGsyWEtRMzRFRXNoUXNV?=
 =?utf-8?B?WVZLeHpBb05JWG8rV0lvelI1RHRaUHoxNmFrZDZoMTR0L1pkQ3FuYklHeVFu?=
 =?utf-8?B?c01hYVc1Z3JDbFhKK1dVZm91dldnSU4yNnBzYWFaSXFYMDk2RStoWkdDTjZs?=
 =?utf-8?B?ZFBEdXpnaloxQzdXdmRaeFFkbFJZVW0vbXdpTkwvd0FYbFRsMitwUnBKMXZy?=
 =?utf-8?B?aExKYlVUdUI5ZVhrS1A5TTBpMTJ2WTd0Mmc4RVdLNHl3blVNUWtVY1JRSDIr?=
 =?utf-8?B?VzUvc0tDbVl5Umt0QnBOUSs1ZExrYUNSdG9uMU8zT29PS0xtTjBVMFkrblJS?=
 =?utf-8?B?STVXVzVGcFdPZE92RkdCZHJacFRERDJ4WEJYdW5SQ1R3ckVpcm5CeDI1SE15?=
 =?utf-8?B?UXlqODN1clVNeW5GYWU1eDcvSWJXbEdNN3hFZm1XOXBpRXpjMGlpTEtROVNs?=
 =?utf-8?B?dDdvYTlnbHVXMnVxaEs1aTNZTWdWME0rb0xQQWRwS1J0Q0pzTkt6bHN5MEJV?=
 =?utf-8?B?ZjZ2dUxzN3lwWVdKd2huOW5URnorL0IvcHEzWGtkL3pVQldRV0txSWE0czRr?=
 =?utf-8?B?NmZtby83WFBwNkdmZmY5N08yU1NFZ29pVzc1OTJEQ2haRUJ0cTVjay94LytN?=
 =?utf-8?B?eUV3UVo1SHF0UUkzSWNFU1BpRDFoSVB3My94OWdOOW9JN0Nic3hqc0VUMUEw?=
 =?utf-8?B?dktoYzJDSlpDNmdxRnFaa0lCVEY2b04raDBMOU5TQVQvczkxTll6ckZlaWtR?=
 =?utf-8?B?MVp4UElYalZ1L2RNRDlvbFNoSzhrSHloMHdXalZVejIyZUxrMmhzQUNUUkN5?=
 =?utf-8?B?WDdYeFdjREI3WGxBQ2VzZWdYZ3doKzA5b0tGUXFPZVhpb2VkdjIxLzdmQ3ly?=
 =?utf-8?B?aWxJakYyeFlCTkV2OU5pWXd4cUt0eENlY2xUbVIrRGhpZEdZT0VVbkQ1WUg0?=
 =?utf-8?B?aldyaWgweUZzMmo4UGxwNUN4OVJRTGN3alhGOHQzY3NxK3YwOEpGQmtTeStl?=
 =?utf-8?B?ZnJBQ21rYnRhbXlrN28rUGozWktvT28vbENLQXQxQ1NTZXpqcktXMkRUQjVJ?=
 =?utf-8?B?VFh1KzUyZW5hVFZ3clhFZFhqandLUU41ZEkvVUJVbzNlRHRvc3ZXSlpZaGc1?=
 =?utf-8?B?eW1YRXRZSlFpWnlUbnF1WWtxTlFpZU9SV0dhUmZDZFQ0aXg4QnN5YWVNQmZm?=
 =?utf-8?B?am4rRXhHKzFLQVFueDVDTUY3djNHRjlGOGFqTStwcHVsR2tRMmwxNklIZWZL?=
 =?utf-8?B?cHI3WmxGcVJDV3pSR0tYeWVhT2RlK1JXa3dBblNrSGdQcW5LNmRsZGY5ZWtY?=
 =?utf-8?B?RlBrQTlxUFg3eW8wdk05QVhMYXozNXlYSUUyaXJDc1RaMGJlL24yT1lrdndP?=
 =?utf-8?B?UlBHVVZPMWk2MFNhRjEzdzFtRjNrTlA1RHdWRm83eWEzUUpZeDhTZDh2aWc0?=
 =?utf-8?B?VlF2RS9lRFhCWVRoWGszQkJueWNWVWozbkUycjhZcjF6TE9qRzIvbkd6eU83?=
 =?utf-8?B?T2hURXRZd2JORXF1QnhtV1RaVUVvQ05heXpmYlBnMG9hSlh1TFMrdUVtSE1C?=
 =?utf-8?B?WWlpWks3UG9lNVdYek1RMmhsNDhseUNIN2twZVkrSG1PdVl0akc2aXNHZEFF?=
 =?utf-8?B?RkV3cVRvS3pZMk1SbGxHeW9rSUpvaE9XWUpTYVUvNTZmcVNDVzdiUVIzN0d2?=
 =?utf-8?B?emxsYlFmeGdxSVVVWG1YOE94dDdzcXFLQUo4YWVmT3l6NE9qNklxaDBVUU9O?=
 =?utf-8?B?SFNHSDlnN1JxbVZsUDZTTUUrOXNQVGRmeCs5VHlDVVkwWVN3c0ZLdDFjTnh6?=
 =?utf-8?B?WXBwb0J0cXk1aEhFUEJXekdLalpES0djZFZLRFB3ajVDZFV0ZHc0NWpkU1hC?=
 =?utf-8?B?d1BhOEFpU3JkbklwSmpjMzloU1JKZWtlS2c0M0gyNXZZWGZia1NseGtzamNT?=
 =?utf-8?B?TEFKM09LVkVpd1VWa0U2OXVDcVdXUDZPbURxbS9ia0V0dTl1UGtGdnA4VENJ?=
 =?utf-8?B?TWhmVGpJVmdaTlNMR0NXTlhLd2JLUmNzNnh1NE9xM3lpQXV4OVpRN2dMRjgz?=
 =?utf-8?B?TW14Q3JxdUlrUHltclZiUmxKN09MeHpQU3E5L0FtNWRTUDBJMXNrdz09?=
X-Exchange-RoutingPolicyChecked: gQ3VI4XvjPtiUhAT0IeTHFDaoGv1NHmfScIYZvH89HX5+QJFAK9XojHYNMq4vPhqU5SeklZ4TSAlFXUz0YJPytPF9lBMAADjMkboMfQSVU/7DcY91MlwjNESJ4Tq6lChHqSXe6H7+2PG7FOLklmHqFpyY7DWkIdq3zl0mhgCtuWIIPF069llmbh3N0ixNW7iFzOZrfTD30UBmR3UryWc2+dJl2o6TQol+q6CpYo0B5DDi+uib7/LKdv+8v0xcN2kbGz9HhMqsLh6iweBTU8pe4nhKRDBay/nWA20qslVG5bWQiAjLSXx8l6LFGp8fmZyIsH5Tf9V0p3niGaF79TOrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464e6ec-0983-497f-c8b7-08dea665372b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 03:04:38.1894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJEwCiFP+WnAa/z4Qvx+6HovyfdmQDvDsUmhgun9P55Dyc1fHzvuQUe1QwQzy9ZSpx7EtpQfBLWII5uba8K+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
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

On Tue, Apr 28, 2026 at 10:23:18AM +0800, Huang, Honglei1 wrote:
> 
> 
> On 4/28/2026 4:00 AM, Felix Kuehling wrote:
> > 
> > On 2026-04-24 06:43, Huang, Honglei1 wrote:
> > > 
> > > 
> > > On 4/24/2026 4:21 AM, Matthew Brost wrote:
> > > > On Thu, Apr 23, 2026 at 07:03:52PM +0800, Huang, Honglei1 wrote:
> > > > > 
> > > > > 
> > > > > On 4/23/2026 3:18 PM, Matthew Brost wrote:
> > > > > ...
> > > > > > > > > > > > This clarifies a lot. This is
> > > > > > > > > > > > what we’d call in Xe “preemption
> > > > > > > > > > > > fence”
> > > > > > > > > > > > mode for a VM. Anytime memory is
> > > > > > > > > > > > moved, we trigger a GPU
> > > > > > > > > > > > preemption and
> > > > > > > > > > > > resume. We don’t actually
> > > > > > > > > > > > support SVM in this case;
> > > > > > > > > > > > instead, we use
> > > > > > > > > > > > “userptr binds,” which are built on gpusvm for page
> > > > > > > > > > > > collection. However,
> > > > > > > > > > > > we don’t support migrating memory to the device—though we could.
> > > > > > > > > > > > 
> > > > > > > > > > > > I’d look at how we converted
> > > > > > > > > > > > 'userptr' to be based on GPU SVM
> > > > > > > > > > > > [2]. In
> > > > > > > > > > > > this case, don’t maintain a range tree, as those—as you
> > > > > > > > > > > > suggest—are more
> > > > > > > > > > > > of an on-demand fault driver
> > > > > > > > > > > > concern. Instead, just embed
> > > > > > > > > > > > 'struct
> > > > > > > > > > > > drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
> > > > > > > > > > > > 
> > > > > > > > > > > > We could extend this to support migrating 'userptr', but we
> > > > > > > > > > > > just haven’t
> > > > > > > > > > > > done that yet—this may be what you want to do in “XNACK off..
> > > > > > > > > > > > 
> > > > > > > > > > > > [2] https://patchwork.freedesktop.org/series/146553/
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Actually we need to swith the xnack mode between on and off, so
> > > > > > > > > > > in xnack off
> > > > > > > > > > > mode, the driver operats in "implicit  prefetch mode". This may
> > > > > > > > > > > be due to
> > > > > > > > > > > compatibility with older hardware
> > > > > > > > > > > and the need for UMD runtime. We
> > > > > > > > > > > will
> > > > > > > > > > > further discuss the handling method under xnack off internally.
> > > > > > > > > > > 
> > > > > > > > 
> > > > > > > > Hi Matt,
> > > > > > > > 
> > > > > > > > I studied the xe_userptr code and the conversion series [2] you
> > > > > > > > pointed to.
> > > > > > > > 
> > > > > > > > I have a question that:
> > > > > > > > Would it be possible to reuse drm_gpusvm_range
> > > > > > > > to handle the hardware
> > > > > > > > without gpu fault feature(xnack off mode).
> > > > > > > 
> > > > > > > That’s not how we’ve done it. We embedded
> > > > > > > drm_gpusvm_pages into our VMA
> > > > > > > structure and then attached a notifier. The notifier attachment is
> > > > > > > open-coded on the Xe side, and this could be normalized and opened up
> > > > > > > for common driver use cases.
> > > > > 
> > > > > The way in xe_userptr likes the implementation in kfd_svm:
> > > > > embeded physical
> > > > > pages into structure and attach same size notifier.
> > > > > But kfd_svm is an implementation of SVM semantics, which
> > > > > supports partial
> > > > > unmap, doesn't need explicitly delete userptr ioctl calling
> > > > > when remove ,
> > > > > and doesn't need a explicitly userptr flag when creating.
> > > > > And actually there is also a existing implementation for
> > > > > userptr semantics
> > > > > in amdgpu kfd: KFD_IOC_ALLOC_MEM_FLAGS_USERPTR.
> > > > > If the no gpu fault mode can not use the drm gpu svm fram
> > > > > work, use the same
> > > > > way for xe_userptr, it seems like doing the duplicate work.
> > > > > 
> > > > > I think the core gap is we are trying to use the drmgpu_svm
> > > > > to implement a
> > > > > SVM semantics driver for no gpu fault hardware instead of
> > > > > userptr semantics.
> > > > > 
> > > > > > > 
> > > > > > > The problem with reusing drm_gpusvm_range directly is that a VMA may
> > > > > > > span multiple gpusvm notifiers—i.e., it can be
> > > > > > > larger than the notifier
> > > > > > > size. Of course, we could rework this as well.
> > > > > 
> > > > > So the "VMA spans multiple gpusvm notifiers" concern: I'd
> > > > > like to clarify
> > > > > that this is not actually a blocker for amdgpu's XNACK-off
> > > > > path, because
> > > > > amdgpu does not try to represent one user ioctl virtual
> > > > > address interval as
> > > > > a single drm_gpusvm_range.
> > > > > 
> > > > > we walk the attr interval and call drm_gpusvm_range_find_or_insert()
> > > > > repeatedly, letting gpusvm pick chunk aligned ranges bounded by
> > > > > notifier_size. One ioctl interval will create N chunk sized ranges.
> > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Sorry for the double reply—I just glanced at the latest
> > > > > > series. I don’t
> > > > > > think creating a range per page of the userptr is desirable. While it
> > > > > > would work, from a time-complexity point of view I don’t think this is
> > > > > > ideal.
> > > > > > 
> > > > > > The issue with spans across multiple notifiers is real, though.
> > > > > > 
> > > > > > My rough idea would be:
> > > > > > 
> > > > > > - Give drivers an interface to create larger ranges.
> > > > > 
> > > > > So maybe we do not need to create larger ranges if we call
> > > > > drm_gpusvm_range_find_or_insert() repeatedly.
> > > > > 
> > > > 
> > > > That will be functional, but consider it from a time-complexity point of
> > > > view.
> > > > 
> > > > Multiple ranges increase the time complexity of range-tree searches.
> > > > This isn’t a huge deal, but it will show up to some extent.
> > > > 
> > > > Multiple ranges will also slow down DMA mapping and migration. We
> > > > switched over to the dma_iova_alloc/link/unlink/sync uAPI here [1].
> > > > While dma_iova_link is a relatively fast radix-tree walk, the allocation
> > > > and sync steps are where things get expensive. Therefore, it is
> > > > advantageous to perform these steps as few times as possible. For
> > > > example, if your SVM buffer is 512MB, instead of doing these steps 256
> > > > times, you do them once. The same logic applies to the migrate_vma_*
> > > > functions—they are quite expensive, so doing them in a single shot is
> > > > significantly faster.
> > > > 
> > > > The same applies to invalidations. If you can invalidate a large range
> > > > in a single shot, it will be faster. Although the logic in the notifier
> > > > should be able to zap multiple ranges in one shot (Xe does this), having
> > > > to DMA-unmap a single large range will still be faster than multiple
> > > > smaller DMA unmaps.
> > > > 
> > > > The TL;DR is if your driver knows size of SVM allocation upfront (e.g.,
> > > > an IOCTL tells you the size) it makes more sense to use a single large
> > > > struct (either embedded drm_gpusvm_pages into a VMA or we figure out an
> > > > interface to insert large ranges / notifiers).
> > > > 
> > > > [1] https://patchwork.freedesktop.org/series/160587/
> > > > 
> > > > > > 
> > > > > > - If the range fits inside a single notifier’s size → done.
> > > > > > 
> > > > > > - If the range spans multiple notifier sizes → round up to a power of
> > > > > >     two and create a larger notifier. This may overlap with existing
> > > > > >     notifiers, which is likely fine given that interval trees support
> > > > > >     overlaps (?). We’d need to double-check and test
> > > > > > this. If overlapping
> > > > > >     notifiers are not acceptable, we’d need some
> > > > > > heavy-handed notifier merge
> > > > > >     logic—it will be complicated, but isolated, so once
> > > > > > we get it right
> > > > > >     everyone can use it.
> > > > > 
> > > > > If we call drm_gpusvm_range_find_or_insert() repeatedly the
> > > > > drmgpu_svm will
> > > > > create the corresponding notifier correctly as far as I can see.
> > > > > 
> > > > 
> > > > I agree this will be functional but not ideal. You can always start the
> > > > approach you have here and optimize it later by adding the required
> > > > support in GPU SVM.
> > > > 
> > > 
> > > Hi Matt,
> > > 
> > > Really thanks for your information, this really helps a lot!
> > > 
> > > 
> > > Hi Christian, Felix,
> > > 
> > > According to the discussion with Matt on the previous thread, I'd
> > > like to align with you on the XNACK off direction before start to
> > > the series.
> > > 
> > > According to the information form Matt:
> > > when the allocation size is known doing one big operation is
> > > significantly faster than doing many small ranges, because
> > > the allocation and sync steps are where things get expensive.
> > > Doing them in a single shot is significantly faster, especially in the
> > > situlation of xnack off mode, which needs pre fault and pre map in
> > > ioctl, and the size is known.
> > > 
> > > It is confirmed that repeatedly calling
> > > drm_gpusvm_range_find_or_insert() is
> > > functional, and suggested we land it first and optimize later by adding
> > > large range support in GPU SVM core. That motivates the two phase
> > > plan below.
> > > 
> > > Phase 1
> > > - Reuse drm_gpusvm_range for XNACK-off, one ioctl interval is split
> > > by drm_gpusvm_range_find_or_insert() into
> > >   N chunk-sized ranges bounded by notifier_size, same mechanism as
> > > the fault path.
> > > - populate all ranges at ioctl / submit time instead of on fault.
> > > - Invalidation -> GPU queue stop -> rebind/restore the pages and gpu
> > > map ->restore queue
> > > 
> > > Phase 2:
> > > Add a large range / large notifier insert interface in GPU SVM core
> > > so one ioctl interval maps to a single range to improve efficiency.
> > > This needs modify the drmgpu_svm frame work.
> > > 
> > > May I know your thoughts on this plan?
> > 
> > I think drm_gpusvm_range_find_or_insert already has all the parameters
> > necessary to allocate larger notifiers and ranges. All it would take is
> > maybe adding a flag in drm_gpusvm_ctx to request larger range allocation
> > instead of arbitrary chunking.

Yes, I agree this a completely reasonable direction. Something like
override 'chunks' with a direct placement + size and then figure out the
notifier install algorithm in gpusvm layer - again this only gets tricky
if a direct placement spans multiple notifiers.

Matt

> > 
> > I agree this could be done as a second phase and is mostly work in the
> > drm_gpusvm code.
> 
> 
> Really thanks for the reply, will implement the large range feature
> according your suggestion.
> 
> Regards,
> Honglei
> 
> > 
> > Regards,
> >    Felix
> > 
> > 
> > > 
> > > Regards,
> > > Honglei
> > > 
> > > 
> > > > Matt
> > > > 
> > > > > Regards,
> > > > > Honglei
> > > > > 
> > > > > > 
> > > > > > - Finally, make sure that individual userptr pages can reside at any
> > > > > >     location.
> > > > > > 
> > > > > > Over conversely:
> > > > > > 
> > > > > > - Normalize embedding of drm_gpusvm_pages in VMA structs + notifier
> > > > > >     creation
> > > > > > 
> > > > > > - Make sure that individual userptr pages can reside at any location.
> > > > > 
> > > > > > 
> > > > > > Both options actually sound really similar after typing this out.
> > > > > > 
> > > > > > Matt
> > > > > > 
> > > > > > > So either way, the Xe userptr + gpusvm
> > > > > > > implementation should be refined
> > > > > > > further for common driver use.
> > > > > > > 
> > > > > > > > 
> > > > > > > > Reusing drm_gpusvm_range for the XNACK-off case would simplify our
> > > > > > > > implementation considerably, it already provides large page chunk
> > > > > > > > optimization, can reuse the existing migration infrastructure.
> > > > > > > > 
> > > > > > > > Building these on top of a standalone drm_gpusvm_pages
> > > > > > > > would mean reimplementing much of what the range
> > > > > > > > layer already offers.
> > > > > > > > It would also let us keep a single code path for both XNACK modes,
> > > > > > > > which reduces maintenance burden and avoids behavioral difference.
> > > > > > > > 
> > > > > > > > Would this direction be acceptable, or do you
> > > > > > > > see concerns with reusing
> > > > > > > > the range infrastructure for the no-fault case?
> > > > > > > > 
> > > > > > > 
> > > > > > > If you prefer something like insert a range exactly
> > > > > > > here + create range
> > > > > > > + notifier I think that completely reasonable direction and Xe would
> > > > > > > likely switch over to using this.
> > > > > > > 
> > > > > > > I guess my only concern is sub-userptr migration. We are trending
> > > > > > > towards allowing userptrs to being migrated either
> > > > > > > via prefetch IOCTLs
> > > > > > > or access counters on the GPU side - access counter
> > > > > > > we'd likely a single
> > > > > > > 2M page at time migration within the userptr.
> > > > > > > get_pages() supports mixed
> > > > > > > mappings between VRAM + system but likely needs some
> > > > > > > more work to really
> > > > > > > make this complete though.
> > > > > > > 
> > > > > > > Matt
> > > > > > > > Regards,
> > > > > > > > Honglei
> > > > > ...
> > > > > 
> > > > > 
> > > 
> 
