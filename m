Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69553F327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C2810E7F6;
	Tue, 21 Apr 2026 06:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ltjzDpF6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43A510E18A;
 Tue, 21 Apr 2026 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776754107; x=1808290107;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=jntq7l86u+XHKCPrVNDpPg7bNacQYudJ99WBvXo6w2E=;
 b=ltjzDpF6unqvWmhEACpuxTPd69iORnqnqOtHseKKpcKBLAXswwfUvbSR
 TY4AOIw3ZCiNs0bbUi1Pk3FvdeYwkXwMDayKmckj3OpmhvOwROaOABw3A
 3wAWbH8SUgzRQWAh3uSgYReOMcwW0veFPrBu5bEWIG+uAWVzK3dptumRg
 7qncQU+FHDOgd51IAQ1VAYBf0wuyabuhuiClxDJxDpWAntd5flCWsONTI
 +ngUmJpwiDUiU2sKnkVgNN5AoX7h1lrYBUQu9P8YqoMLwC7Rx8hargHKV
 edKyjaidR4FK7ohlNYRXb+LI1ol7blFpFhrnLvSu7geUIdFQqdHuYD7Zh w==;
X-CSE-ConnectionGUID: t4p/G+OCQ4uSj8fHmfJ4zQ==
X-CSE-MsgGUID: l5w1Ap+bS4OT4mwL9ZUj0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77750909"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="77750909"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 23:48:26 -0700
X-CSE-ConnectionGUID: 84K4MQ4jSrK5i8fJsg8kWQ==
X-CSE-MsgGUID: sGyfSFYFQ8mcQ7ivGnzkjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="231856555"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 23:48:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 23:48:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 23:48:26 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 23:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcL2yM4407cOc282ox7KmMOaacK6sdroGqLbQpve5jpQGq4TW+aPQt02B5bgQDm2KfDi7/2rEmpD1uEXkAZicWeAkbVfIOWl5nAHre3QeS8d4aXebd3rpB4BuBWWlVs89jumpjBXZKtFhGKTkxPhxP9tBLTYIrPL0JtIwuhpFeKDrnPKTPt14125zrTjDbBJ8+w6mkaJRxkwl4WPmo5HSQJl+sMdma9+Nj62kGAxlXuZQMXExEkzrJ6ES8fnQfji4NKZWYlCpafUpzCrsIOR5d75nJmPMMjnJnOq9zvwBLL1BlWf0TXMwvD2k8PcWCzoTDWy/LCmCKXIEoslMfZwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk76ZWHjZifuonub0NgahH0ZPYc7qDzaSr1VE5OvNNI=;
 b=EJvCm3rGWRb5DQcR9evuPRRNb3LZzky/BaLKTtsvJ0kEhdmCP2Y+UI16IVGEHi5gaidYojigh5War+JUqcnOuk0mAXz72MfOJ6OVC7OYHvqiCwLrj8Xk+0a9dIqAIkknp2xt0Ofac9ByTcxfJQ5tBkrXY4mi6grciRzOPntAwW2uoSasuWbxV9vZnWLhpQ5GIb0Pe9/mVkt8SmrtqTteFGxtC9KwIyeww8TTpwML5bJlCVsI8QMH5VwcCaVSQ1ie6KhN2jXwgdsZmSDLNtqttqKgLy/bTk3Q41xuPnXRttCJ/rf4c2+idNktmjNhR+8F9eYz1DD+z3rONBDxKBrMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 IA3PR11MB9207.namprd11.prod.outlook.com (2603:10b6:208:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 21 Apr
 2026 06:48:22 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:48:22 +0000
Date: Mon, 20 Apr 2026 23:48:19 -0700
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
Message-ID: <aecds3CWc99E1p6q@gsse-cloud1.jf.intel.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
 <e494689d-f126-4be8-8337-f04be1abd12a@amd.com>
 <aecGNdso+EB/Aip5@gsse-cloud1.jf.intel.com>
 <3d19f4c4-5173-4879-b2ee-7bdfb8aeee53@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d19f4c4-5173-4879-b2ee-7bdfb8aeee53@amd.com>
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|IA3PR11MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: ded61410-cb88-4ecf-8b89-08de9f71fadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9cQBW3sGPNt0D8le830MbGl7D6qPAFyqtTGlZdQvY0zc5YsuMSCrPUL1l/Pay0BN5iK2ro/S9qKCApMVCOA9xFqCMSJwkj0hy7Sh+xyZoyD/MZNsCeoR3EJFw6v8OCjiM8tbktj8EV9WbSM/17oJsDunsAmoE0sxRcMwufYS0lTFIZDbterykI9NPr2QSlE1TL7mZrMkrNlnwcOkmQEkhFuf8JmKesBTEMjcqEjUhE+WNn9LEPPEqErmioSzCEK8OQojBs37U1oaxHnaUOLlAP8uS1XfKcg7beyZYzOND7+DxQaIa3tqCXrLQo23GRXNiLHqz1K0Kn3yBu3WUPJe5NY6IClTF8FIr0K7YPeeocBT9Lav9am98exWqPXEtWbxGvsLyprMuxQ+yxWpv2HTouaqdcRslG683jF9bNgQYUtyoTBAsffKMr297+Yh6rUZCuNID90XAuvfP9bF12h3JDbRgxjVElBr50yHA6P+3lWHudSo1GvL/aTNeErtKux1QPAWCFKclDBoY3I1dPs+v+9T6WZCu+5mR4gw5afi1x/mYSGHFp37YhzpB5N0TokIteuIwoZSa+n2IAL7PkFqs08piMe3UJQ81NPooucRHbCr95/QG5gnY2iX+exaGQ4NGmphTays8RniKMTFSSb/8cNprw6aQ+7EG1nypmCHNkFIQZabhT7/CWKD30uzUJVo2fVyJYBdWEsgDBQtd6ypqAGISr+f3KI4g3kELdLWRR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emg1MUhteDRUWUh6aWpVMy81WnFBTDZDUkxwejg3YnZrN1hMaEp0aFpLM1Jq?=
 =?utf-8?B?RXlaQkx1TjFQV01xYVEya3luQUpYclI0bThYRnZ4RWVwRUFqZWRCNStGRmNt?=
 =?utf-8?B?dnFodk9LT3MreUcwTzVtSldoNU1yMXE1U0NSZ1NxRi9uZUs2VGJMR3MrMXVD?=
 =?utf-8?B?Q0ZoWTQrdnFRRHptLzJKYlVVNTdOWTR6eU50R0cvYk5CWHFkYkV4Sm9LWmU1?=
 =?utf-8?B?b1dCZVRUM3JYUEhQWGVWRGNXMzJ6dHdkZzhKdzRVUFd1eURQeldnUkl4R0Y1?=
 =?utf-8?B?aGQxbUhTakdsdkZKWHlQTXlsdmswVkhwS3hBMUdaV1M0U2pvUThBWjNFVkd4?=
 =?utf-8?B?ay9UZnlIaWhBY1psVi8zZ1QzYUwybXhoVnZlcXMxTVo2V3VuUE5QcmJiQjVm?=
 =?utf-8?B?SExIVW1HZE5kVXBjWFNGTVRKNlpqdWtIN1ZSSWI4bEVZWEttNzdGRTlNazdv?=
 =?utf-8?B?WmgvaVl2d3JWWDBjVWRBM1NiMFYvV2NhM0FBbGY4SEFXN1puNngvaDlGMk5x?=
 =?utf-8?B?MUQzaVNHdHBEUWJ5amgwZnROUFhzNGtmb3FwaE01VFFYUmVqeHAycHVqV0FU?=
 =?utf-8?B?ZXlJMGp1RURvWSsvcytlTVIyWGt4VVRzNjRCWENmeXEvNE9Wanl2TllnK0Vt?=
 =?utf-8?B?ZXpwbWNtY3pycTE1Z0JhRmFDYi9rSFRDcGVhYWwwaXNncGdhbzFObStUNnFa?=
 =?utf-8?B?azZxTzFDckVSdmp6NEpHSE0rSGkzcmpwcXdRL2EweTc3YTdYSzBueDRYR2xK?=
 =?utf-8?B?NVlybGZyS3dsaGhNWTlOSTBXMGNkOURMQWJ4bWoyb251YUc1Q2pzclUyaW9j?=
 =?utf-8?B?aFVFNks2TFRwUGUwbnlhVk5zT3dYUnhYOVhqeGMwVzBqbjRTM2p3aFV1cWdJ?=
 =?utf-8?B?T29xMGpjcVhPMVVnTThPakJOM1MwMWl2NjZ2MnNHMENIdmJtUFdYdE51Z3B6?=
 =?utf-8?B?U2VFVjh5UWduRzRQaysyL3BwTmlxdGVCMVpnejRtbEJnVnliVVhuK0d3L3dn?=
 =?utf-8?B?NDh5Nk1IV2pwV2pWWExRbVdwTFhhREdyeGN1UFlUdFlOMk1LV1ZEeFEwOTV4?=
 =?utf-8?B?cnNaVVBjM0FaN2lWcE5UKzZhejJmWlhTS2pFY2RpU0lDUkFsNGo3V1ZLSzdN?=
 =?utf-8?B?OTlvWlBUdVUzVEhTYzQ3MjkrOUtJbjIxckxpR0JiWDdUaHRpYkNWMWZ0VytW?=
 =?utf-8?B?TFhQTXJHZEUrRVNFVnFnWVJBMWptaDNIZUZQVjAxZllEZGtMTGRnYWVIQnNN?=
 =?utf-8?B?MzI4QUJiaDB2TzRDM0NCM0t0SkFreWlWUFZXSjZjMGM4UG43NkFkTnYvajd5?=
 =?utf-8?B?TjJlTXMyYlNBeWcyVTVLQzlReUhnd1RuMml4WnpqZy9rd0xGcXJhVzBiREho?=
 =?utf-8?B?U2NmVVhDR1VMVDRsM1lHUWZqbzE1c3FwMVpSd29aVEJXaGFoMldTUUNxdVFS?=
 =?utf-8?B?MEUxR0RKekdBTWR3SFE0VVAvQ2dyK0d4RzFPRGNLYlZtV2xwMlJZU1hWOVk5?=
 =?utf-8?B?aUJ2UlYxZ3NJaEcwNkRhS2xFRndmTm9nUEtodEZ5YnZvbkJITEZBVUdoaWEz?=
 =?utf-8?B?a0xkVm5tWENta2R0ZDd3OGVDRDN4aHJ4MkZsQlN2dk5oS2luRUNseVNjSlha?=
 =?utf-8?B?cW5iaHFrb1N6T0FrY0xUN1FXbmU0YXFwbkxCdFRycENlRlJkRDR3SmlYdHFZ?=
 =?utf-8?B?aWFSaG9EMTc4cHVYYWw3RFBqb0RnckFvcUlLUHBvTFV6aHNBY2RCTjQ2Y1dv?=
 =?utf-8?B?ZDNXWGJndThMbzZQNFZsZzFMQ3IrTVF6UzlBU3NFKzc2eVBJblplNTR3eGZ3?=
 =?utf-8?B?R1VKbnlQM0FLSElCVFNtNDMzWFBXL25OMWpYNHhLRE94aE96cTNURFNqNzlL?=
 =?utf-8?B?TWduUW15dXhoNjd6R01GNE1UcEl2R3JIaXlUR0pDWXdvZUNycHZTS28xSE9k?=
 =?utf-8?B?dVBZZVI5TklGUCs3SXh6UkRpTjhpSUc1R2k5L2Z0YnZBQ3ZHUndtek1tdGpK?=
 =?utf-8?B?aTJzMkRQbG51VUFYSWc1LzYzQWIvYWlsZ3ZUNUJzYVZWRGNGdzhzOWVJQklF?=
 =?utf-8?B?Qy9JazFpTmdxVmlOTktsZEZqdzV0SkhtNW1ySkZ3OWEyaFF0RnVjUkpPczFH?=
 =?utf-8?B?M0hTVzV2ZWU1OWtKY3ZEdEVwWUduTWtwT1FRNXk0WCtvR1RhRTFGZ0ZwN2lx?=
 =?utf-8?B?c3ZzUjVqd0dIam5Id05XRWRjNHlMZVZ0bzZwdDM2NytZajR2Mk1jai9ZZUhD?=
 =?utf-8?B?VlJlaVA0SkM5VE5yNE5nWkVic3Y0UGFTTW5FRmFJNERwK2RmWGxxd3I3ekc0?=
 =?utf-8?B?TlhPbC9RbFhaK0M3eFFnaU1LNERvbDlGck5QSmZXam1tM3VnNTB1UT09?=
X-Exchange-RoutingPolicyChecked: N3ZEiL8QnTAp7s6ze7LFueD4i7l0v+6HQiqn10zt8uI0mQ1APwbhjx5eTS+XSFy7+nwvyQ6XLvU3aPh3TV+2TICKqN+yug0Jiuz5cSktCNNH0ZlejaALm91/16wh4M8LnPtNZDhJkpS/7IehwTWqOpbdfTCFOHjkwQoaU4XA8ipRweH+r8YBICDnn7Jz+dk3H8nlRxnlh8rsCT7dPbCc6MXNetguey6TBhjx+1y0YkRIwb94nPMYl4vn6IlfBiph7FXjdw387PDhcyd/H1Yf3/CUqYPcjy2RuP3c17GNqjwn9zZSTYpqbuvNsTs9H1TkhE5/YoeO2g9PdXbqk2SnDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ded61410-cb88-4ecf-8b89-08de9f71fadd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:48:22.3975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu1IU72um9ty3yi4NVzkWu5v2aGPFGkj9EDwAVEPgKRPGpDIjCYnTzBAZNhTFTjyUKabxDDg+s4NQc92uS6yJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9207
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

On Tue, Apr 21, 2026 at 08:19:54AM +0200, Christian König wrote:
> On 4/21/26 07:08, Matthew Brost wrote:
> > On Mon, Apr 20, 2026 at 08:07:38PM +0200, Christian König wrote:
> >> On 4/20/26 18:06, Matthew Brost wrote:
> >>> On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
> >>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
> >>>>> On 4/20/2026 8:15 PM, Christian König wrote:
> ...
> >> Either you set the information per-device and then each device only gets the information if it needs to migrate the page to it's own local memory or you have global information.
> >>
> >> So why does a device fd needs to know about remote pgmap?
> >>
> > 
> > Simplest example:
> > 
> > Devices A and B. The user sets the preferred placement to Device A.
> > Device B faults first, and Device B moves memory to Device A via remote
> > pull and can access locally via P2P, scale-up, etc. Avoid a double
> > bounce once Device A faults.
> 
> So you basically tell the device as soon as you want to access this VA please push the underlying memory away to a different device?
> 

Yes. GPU SVM supports remote pulls.

> I didn't thought that would be a valid use case. As far as I can see the only thing you avoid is updating your page tables on the faulting device twice.
>

TBH, I’m unsure if this will happen in practice, but it also seems
entirely possible. Computers are asynchronous, have random thread
stalls, etc., so out-of-order from expected access isn’t far-fetched.

No on 'updating your page tables twice' being only bad thing.

In my example, let’s say Device B moves memory to itself initially. Then
Device A faults and tries to move the memory to itself.  

Bad things:
 - Two copies (one from sys->Device B, then Device B -> A)
 - Device B faults again after move to Device A - this stalls B's
   execution pipeline

Matt

> Thanks for the explanation, that was absolutely not obvious. Going to discuss that with the team on the next meeting.
> 
> Christian.
> 
> > 
> > Matt
