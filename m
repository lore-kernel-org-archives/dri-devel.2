Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B1EA7184
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9788510E7C3;
	Tue, 21 Apr 2026 05:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kI5h08FC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3A410E7B4;
 Tue, 21 Apr 2026 05:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776748101; x=1808284101;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZR4nIv97Le+FyyXeUvn5PY/IW1iiqNMdRtuW/ZZgLVA=;
 b=kI5h08FCwrP3UdAnX3C4XO+6e85Qfv9GdPv6zNRpc//Oep78t75SErEA
 E+ZOLsC0IFa3NnatqJmxu+izU6wEFA2IuAuYH5Hr1Bf3cG4r/PJ6vsw3V
 NUU5ohsDYgA2hieDwHeyjK64AnOR7pT09jOh0Znr1E3fidZsYcsttKYfN
 HQ8BBHQptDkEbskm5bK8du24AzH3H1oqonuozcRYvGlR+1QH4xB+n9P6H
 FMoRkX/q1+oHGwbimPOe22uIL7Epr52h5d6lwN9lsM4bLCyD8N3cHmVLf
 FirDiCvcNe116sN0EvrpBLrmQqkEFyYyMsyTCmwLXoBOhF1Kd0Ly4NWUI w==;
X-CSE-ConnectionGUID: WT2omzHrQsS6ZpGn/94KHw==
X-CSE-MsgGUID: auo/o2JbTx24ZnNmNELdkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77546968"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="77546968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 22:08:20 -0700
X-CSE-ConnectionGUID: bL7X1zowSKqrrCCQ0/V+FQ==
X-CSE-MsgGUID: kW2itVVlTD6YZPlRJjG9jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="236916396"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 22:08:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 22:08:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 22:08:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 22:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmQoJDT1aInjnj99j12IkgViJW/42wEn3XCLYlkZM+ZimC36o8MQzMEfpqMKzI3Rqh5BqQmMB+mwFQIis7mWWN4m/zBfh2mQ8LZVdNw5zOpZ2eFrIfMZ1lvVZhKI9sFKQCjyO3cBAeB9/v1jxAJG79uIsJT5yf3j+ZpOxXJ/WZIW2nKVMHs8owKGPTod3/qnIm4mn2Fq4/195prwL0ySmaMrokeWnE9k7FPJPvhZkVt3Cgm8eAPnq0UV9sanUquKzZrocywFdNHVen1enWn8Ow3bXYA4qv7FuEsRRwfmQnuPAJg9L6UiiCX/ek4KKHNQPiE+guz1UYdjEck7EqYoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0lv0K+L8LP6nc+90bfAUj1lLKEO7zBw4QnXQMhtSYk=;
 b=ipgluzPAxr5k7sSq3W8dx+k/R09iDEKmV4CiYa8ERhaapDU7l8Je6uroJMVs6Z2NsB88OwtpwQGr2Psh2p52UH1oOdL62228cz3qBhJdFdmihwhX2AaxI6TtiFM1VpGBHSJziD6+KAOaMgvKCIpwYxtEifTyiCjoA/b/k8YAaevbxRl/Qqefyj4F5LsUnhfjSykUR7C+nzU+lHrshrYdnp0hKxPZg5MZS/RevJSK2e4L1Jw+Pf6zLQyKBgKReI5aY2jcY9v1w42lq5iXoVYYAZfxP9xlMk4cb/dz7FNnCMYTGlaPxMvR9QCO+wMTPu2BRrgyjPFZ2a0c/My4F7L8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 05:08:09 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 05:08:09 +0000
Date: Mon, 20 Apr 2026 22:08:05 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: "Huang, Honglei1" <honghuan@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
Message-ID: <aecGNdso+EB/Aip5@gsse-cloud1.jf.intel.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
 <e494689d-f126-4be8-8337-f04be1abd12a@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e494689d-f126-4be8-8337-f04be1abd12a@amd.com>
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a11584-380c-4619-6b54-08de9f63fa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8h79sX9BdRqz3XA2uOjiZ1xR920Rx1DsbXYfjMgu3D0WvstobPVKviNWzcka9fwYTmAVej8MRhGALvuTzo8tsxxB9Muuj9yhzekMI5DlIMloA6P62aOLWpAwsooq4hiaOocDG4iZ67Hm54Rx3uqLF1DwciK5cCUMaICnN8et2IHjXINIgwZPd5nHMp3Weh2QIjIzluao76vHGt+HZ5ZX2v/d0E50s2l+1k0RswwvGjlYsgDjxzU2TbhzT/uuEnYNYy3nQ00eUqRxyHXjeBrdFkkuRD8fcRLIVmemkKkEPsEg9r6A2n/8Ny96kgQV9WvKOONAzNvO+LoTpHu5nqQc34NZtlF70LS0P5ZbXABNyp810sB14FOTfEYohAI++SlSjZPiOcsXK6seDtRW6F5ismPKsVtaTkOyME4/hgc6FvUa2nySmWxau60AFZniFHVwnI8nY7L7QNgsABus5J3eRWygHP0Ke+VzGjcYuTNdBmTHZncBNogjuxq7gEhkuBFjo2eEJHFS3OzElehcdqnGIOJ0/myvfJRqJspboSF4vHUIS+yRfuwrdQGgnw3/xwTwdxhCfCSMQ2sZDb6LILMWBmnafYGsq0JWXLOH6QXea4BQq5kPzyplkvpzKOrLenFGNnFhtJ4XJpsmr82y6frcifaxdxxRoHQ9DUqXeAjWYAlHq8UqzzZkmcn+Q/C8SWer8x3LLuBbMKiPcY9NM4ORuBVkczOm08Ce/g6GcWCRsXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9Rai9EMUxXNERlZDZiRHNDWUl3VXNsMXdGdHIvb0JpNk4vSDFROXR3OVlP?=
 =?utf-8?B?Rjl3Ty9FWk1RbW44UHBZdjlvc2FsMlB2aHgwTTZHSzZIVlRJSU1ZbmlYVWhX?=
 =?utf-8?B?Z0Mwb1gxbGRTcjZnKzVEZVNvbS8ycng3d3g2K3QxSlJraDZXVDRWMHpxcWJa?=
 =?utf-8?B?TzQwSDMva0VGZkVISExwSnR6ZDIyNi9ENkllNzdQZFladm5JelRBS1pEajlL?=
 =?utf-8?B?d1FPdmxKZW5qaWwyRTk0S2ZZK3g2NG9KbDIzR1ZYR09aWDlJZ01xUmlSNE81?=
 =?utf-8?B?L0hsSWRsTzIxKzFHeWxDTERYbjNGc3JwcHBidXNSK1ZBU20xVm5ZQXpHejhD?=
 =?utf-8?B?NWp1S0gvem1xUmxUUVQwanVseEpBR0dSSzZldU5Db1pMOFV1WE9PWXg2ckJR?=
 =?utf-8?B?dEhnOTZGT3R2ZGRqTitOQmk3cXFkQlR6VGpFUS9LbHVTZmd0WTZHZ2pYZkov?=
 =?utf-8?B?NElIM0t4QmVCTGlhSUUzVnUwdHhSL1lSbkJ0aFY4Vzl2cm05VUJGcHh2UTRU?=
 =?utf-8?B?M0lKN0hTa3dLbkFOZGVoNGtyOUVYQzVnSzZzUHhPUnNsTGRmSzlWVVpaVnk2?=
 =?utf-8?B?YXpkL0doaUdKejB1aFY1QUxJYnlMaTNvSmhBa2p3TXlsUGxveWs4Zy9tOFFD?=
 =?utf-8?B?MC9CUkUwQ1BHanZZd3o1alBPUk96eWorWDJTY2lSSWw5eEQvR0VWN1B6U3E1?=
 =?utf-8?B?S0lYY3h0L2RvYVRObE03Wm5FOWJVbnNpVld5R0c0dHhvaUJSb0tqWERFeVRH?=
 =?utf-8?B?bFRpNUQweVdVa0VFdVFPTGxYRjNyTTZNcGp3V3hEOHRoeGdia1cwbmNpWm44?=
 =?utf-8?B?MzAzS3RyRXFRSjY0a2c3K3FMTk0xVzVMRFJEUVhoVGlIMWlNKzJlR3E5T0lM?=
 =?utf-8?B?QjF4L2IxUmZ0dFNqU2dOTC96QThCeWVHcDE1MFl0eUxQanczNUZIOFVRS1ZV?=
 =?utf-8?B?YmRlMklZd2tZeFJwcmdZTytaNExUc2tNMC9FVzVSUjJhK3FzRk81MVNLRXMz?=
 =?utf-8?B?MXdETld3M21PTEFWeVdRUHhic3JWMU9rV29rcWVOWUlSeFdscGF5K3BoYWpK?=
 =?utf-8?B?aWR1Uk5ZUGN6Y21FOFhpUjVlcVdQWU9KTGJMWDV3QWdVS2lBUFo1cVRhR1g0?=
 =?utf-8?B?aDVpWUhUUWVmNVN2citrdHBwYWU5TzBIT2tXN2U4Kzlzd3FZRmY2VUhwOEtX?=
 =?utf-8?B?cWFCTVhoMTJqdlQ1VXdpR0pRN2F5Y1V1eG90ZzJGOXllTDlBZ0laNXNLODVM?=
 =?utf-8?B?dFlwczZvTEtCWGNITUNvS0NhellsMWdWV2hLVSsyNVdNckxrTnZKUlpjNG95?=
 =?utf-8?B?U1BMdUptbnNlZlpFOUFvNXc5b0hjVkpXaURVc2lNaVRUSmZRL0U0S01neHRQ?=
 =?utf-8?B?YWh0aThpNDEwdkNrOFIwaVR2aEhodTdzRjJvTU1vK1FZOU96WnpTbDVneHlN?=
 =?utf-8?B?U3JaSTFxQTdOWCt4VTNielptcm1aREpkSXFCc0l0VVRMVlNpRHcrUXZWb3NV?=
 =?utf-8?B?c3ZhbEdWZEN0aU1uTk4zRFo1OGZ2TVVEZnEwR2tnQ25ra0Q0aTRsMEZHMXpj?=
 =?utf-8?B?OGJqRVppK05nYW52OC9PQlBTSDBMUjAzKzF0eDFGWEszMHhoSGE0a2d4WXJi?=
 =?utf-8?B?SWhaZ0RvY1hKVGJ4MHJQMHVnVnRxeGZBUXhJYXpJYit6RThBN01NRWtuSkxs?=
 =?utf-8?B?SzEyNngrOWwvdUI1a29xTC85MnREazBadisxVGczQytIaWVzRktHZ0wvQTVQ?=
 =?utf-8?B?UmhiTTdZYUVqYjVCYkJPTHF3VmVqUWpRTmVhWWpMVnpscWhzb2pKSW0ramds?=
 =?utf-8?B?c1pkTjhmb1Y3QjlPZWJtbmIvejFkMWVnRkdpazNyeVpPNlcwbWdTYnhidmV1?=
 =?utf-8?B?aHlzYVV5Y1I0bkFhblR6UFhMZ1dDVzVOZmNuOEJCbHBVS0RIRE83VGtYQmJI?=
 =?utf-8?B?ZVpFRUpubTMvT3YzTEc0d2xPd0h0NFdRR01oQWsvNzkzaEl2dUVDSENTckpS?=
 =?utf-8?B?QXRFTXU4dXZ5MHovTW5YNDlxK0JYTmQyMmZKTjNoaHN5Z3BnOFZVUWRVYms3?=
 =?utf-8?B?OGh2RUFIMnNWVExRV2NiTm5VUEZNN3g0ZGpHYkFPVVJzbWVVKzhjOVl0QS9T?=
 =?utf-8?B?Z3dBbVcvV1hpbmRkRTBoMzlNZjZISFdoZWczV2pwdk1qRzdXTUdqUmoxSk5h?=
 =?utf-8?B?Tkp3bjFKcS95Q0J5OWhmcWZRU2xtd1huMG80WFJIK0ZkWjhDaW11Z0wvZy9p?=
 =?utf-8?B?ZmNZV01uNmM3WUtzZHhFWk12eWI5VUtySmY1NFBjRGtsK3VTOFk2TWhIZ2VZ?=
 =?utf-8?B?cVFRQWxDT0twZWhOSDVTVVRiTW0yemR3SmI2eTU1VjZ2OUZmNWo4QT09?=
X-Exchange-RoutingPolicyChecked: oArMYz31MmduQT3RpALNpER3579RdXFSFJFMgR0rJbHoOJPm9Lnl6/R1Qkxb5lwNkLxfxbCeFqVKgULUyuJQJhbxu6SSmhdFnYm7CmeQvOkLU6mencO3uCQR4MSol/kSOuKk7B2rNtVs/Irdk2FNsQ0GMwbldfdgmVJ7Ttb82ZLNI58UKahx/vFbtXJeCDYSZj2gX38NI4S5xjWrsIHGLzOQoMqpq3ZIO/TzYl86KdTq+gYEEJsj9K26Q4NalZrkk5ZRrwsChRin6C0IBpNCzL4z8EWjVNWn7oZHz+prIlcoWazPD1W2iVmnKQ5+cVXkZsBavvu5UKyFE3rBGAZKVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a11584-380c-4619-6b54-08de9f63fa9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 05:08:08.9853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYTuyR00GMznuyFGSQ0LZ6oFvE6HxJu1UBqFlUZnvfSuc7epyoSnRYSh7Tc0N+9K5jInwoNv38s/u167b9u3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
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

On Mon, Apr 20, 2026 at 08:07:38PM +0200, Christian König wrote:
> On 4/20/26 18:06, Matthew Brost wrote:
> > On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
> >> On 4/20/26 15:30, Huang, Honglei1 wrote:
> >>> On 4/20/2026 8:15 PM, Christian König wrote:
> >>>>
> >>>>
> >>>> On 4/20/26 14:07, Honglei Huang wrote:
> >>>>> From: Honglei Huang <honghuan@amd.com>
> >>>>>
> >>>>> Add amdgpu drm SVM API definitions built on the
> >>>>> DRM GPUSVM framework.
> >>>>>
> >>>>> This includes:
> >>>>> - DRM_AMDGPU_GEM_SVM ioctl
> >>>>> - AMDGPU_SVM_FLAG_* flags
> >>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
> >>>>> - AMDGPU_SVM_ATTR_* attribute types
> >>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
> >>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
> >>>>>
> >>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> >>>>> ---
> >>>>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
> >>>>>   1 file changed, 39 insertions(+)
> >>>>>
> >>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> >>>>> index 406a42be4..bed71ed9b 100644
> >>>>> --- a/include/uapi/drm/amdgpu_drm.h
> >>>>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>>>> @@ -58,6 +58,7 @@ extern "C" {
> >>>>>   #define DRM_AMDGPU_USERQ_SIGNAL        0x17
> >>>>>   #define DRM_AMDGPU_USERQ_WAIT        0x18
> >>>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> >>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
> >>>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>>>> @@ -79,6 +80,7 @@ extern "C" {
> >>>>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
> >>>>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> >>>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> >>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
> >>>>>     /**
> >>>>>    * DOC: memory domains
> >>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
> >>>>>       __u64 matrix[12];
> >>>>>   };
> >>>>>   +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
> >>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
> >>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
> >>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
> >>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
> >>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
> >>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
> >>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
> >>>>> +
> >>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
> >>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
> >>>>> +
> >>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
> >>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
> >>>>
> >>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
> >>>>
> >>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
> >>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
> >>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
> >>>>
> >>>> Why are those separate attributes? What is the difference between those?
> >>>
> >>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
> >>>
> >>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
> >>> it can not migrate, GPU only can access it in the initial place.
> >>
> >> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
> >>
> >> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
> >>
> >>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
> >>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
> >>>>
> >>>> Why is that separated into set and clear flags?
> >>>
> >>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
> >>
> >> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
> >>
> >> As far as I can see just a SET_FLAGS should be sufficient.
> >>
> >>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
> >>>>> +
> >>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
> >>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
> >>>>
> >>>> No location for device local memory?
> >>>
> >>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
> > 
> > I have no stake in AMD’s uAPI, but I can at least explain how Xe’s uAPI
> > works here—and admittedly, it’s somewhat goofy.
> > 
> > 0 == device-local memory, with first-touch placement on whichever
> > device/tile touches the memory first
> > 
> > -1 == system memory
> > 
> > ≥ 0 == a render-node FD (which could refer to a local or remote device),
> > paired with a region instance to extract the pgmap for the desired
> > placement
> > 
> > I believe the reason this isn’t fully FD-based is that the compute UMD
> > team wasn’t keen on exporting every pgmap as an FD, though that was
> > something that had been considered.
> 
> That absolutely doesn't make sense to me at all.
> 
> > 
> >>
> >> Absolute clear NAK for that approach. This interface is per FD!
> >>
> >> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
> >>
> >> We also need to make sure that setting attributes for different devices doesn't affect each other.
> > 
> > We landed on the conclusion that it is undefined behavior if different
> > render FDs—or more specifically, VMs across devices within the same SVM
> > address space—set different madvise attributes. I believe this was at
> > Sima's suggestion.
> > 
> > From the UMD point of view, every madvise call therefore becomes:
> > 
> > for_each_fd_vm
> > 	set_madvise_attributes
> > 
> > This choice was made to keep madvise attributes local to the per-device
> > VM structure, rather than introducing some form of cross-device shared
> > storage.
> > 
> > A misbehaving user can absolutely shoot themselves in the foot, but at
> > worst this only ends up corrupting behavior within their own process
> > shared across devices.
> 
> Yeah that makes totally sense.
> 
> As far as I can see the two interfaces contradict each other.
> 

No.

> Either you set the information per-device and then each device only gets the information if it needs to migrate the page to it's own local memory or you have global information.
> 
> So why does a device fd needs to know about remote pgmap?
> 

Simplest example:

Devices A and B. The user sets the preferred placement to Device A.
Device B faults first, and Device B moves memory to Device A via remote
pull and can access locally via P2P, scale-up, etc. Avoid a double
bounce once Device A faults.

Matt

> Thanks,
> Christian.
> 
> > 
> > Matt
> > 
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>>>
> >>>>> +
> >>>>> +struct drm_amdgpu_svm_attribute {
> >>>>> +    __u32 type;
> >>>>> +    __u32 value;
> >>>>> +};
> >>>>> +
> >>>>> +struct drm_amdgpu_gem_svm {
> >>>>> +    __u64 start_addr;
> >>>>> +    __u64 size;
> >>>>> +    __u32 operation;
> >>>>> +    __u32 nattr;
> >>>>> +    __u64 attrs_ptr;
> >>>>> +};
> >>>>
> >>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
> >>>>
> >>>> And we usually use unions in this header to separate the input from the output parameters.
> >>>
> >>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
> >>>
> >>> Regards,
> >>> Honglei
> >>>
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> +
> >>>>>   #if defined(__cplusplus)
> >>>>>   }
> >>>>>   #endif
> >>>>
> >>>
> >>
> 
