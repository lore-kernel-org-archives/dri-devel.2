Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BD5C624D1
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3790110E17A;
	Tue,  1 Sep 2026 10:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hghitp6T";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E19110E17A;
 Tue,  1 Sep 2026 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788257086; x=1819793086;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vs9/k4C7P9Rh/BUR81N3NFBREeI2U50UVSL70ZyCIA0=;
 b=hghitp6TKGx84mHnP3gloEz9k37b5x6/3/6sg7ZkSEzB+xrLLTqsL1jY
 jrjgHvre38YvJwvxSTsPXnM13weciZLhR7d2rv89goY2pCU+MaVV6L6GK
 5y2gbHhovVliuQON2q30npknkLom7BpbcI66gEsW52uw+d5AawBnIvrvm
 KupsYnMD0/L7SN5RYjRQSqRK1fg2ONkiPybeIUNFWbxNgcHSPCcB4+sV0
 Az3q7IiLc2+RNPcDynBuWTYFIVu9RPG0/nYdKvuFrDOOrqdfvIxK58zo1
 k7VhFiEGpxVfLaYr9u/QN4LkGRe4s9i5oQYM1KRIU1+9rqdscBdwiKN4+ g==;
X-CSE-ConnectionGUID: ZGE0f3u6TpKXOSbUkftnZQ==
X-CSE-MsgGUID: qUq6WAKfQRanvuN/yQLaJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="111451061"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="111451061"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 03:04:45 -0700
X-CSE-ConnectionGUID: g/Knhpa8RG6cL5hMv+mhsQ==
X-CSE-MsgGUID: pu9MVfi/SzCvnQaOWF/lJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="265335206"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 03:04:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 03:04:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 03:04:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 03:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl+Hb4udMnUdP32pmHKD8Bige8YXes4bXeV3ha8ttjWQZZMZoOy9vrmYXypaUx3uvxQu5LnHe/xf2f0Oe8cj6nfwRh5CwQfTqQSY1yKO9N04Yo4MGJnmgeVcSL3In7At3mnab3P3n2pladKvo/zkOPq7vE86NelIsQ+1Q8zVfUBpzKPCz+DFwk9UBgoju48sCxiNmJjejgRXH364hfAzzLgVC8XremFf84gaezhkxI0nek4EgRfZzeiscoVlzCcHipw3Je108nLh5I9MNWEDjtpFGQXnjW2AirimZNdP4cWUyAQdPRPkJJ4aKVQHQXCPW2aD2Ofbc7Tt7/ZeXWi6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmab0TB/e2QUHusE4r5scSZNKGso5f8G8yZ43/JN160=;
 b=tAGn6cKkWRpFUTkp8B//1fGo19397c1w8BoBfpTw/m/hDchDAxyhAEEaMOtCCrk/lHxMblHb5NNkeMZu6/nkmrcverOr+vRcML91R3SMGZdjV2aBIjlXtnpRWM++18rFBTsHu98wI85gDAOD1y1xurv7KrFdkkUSy2mPmDaNFOvmby0aGSnqSecPTafI+BzwHdR7SeBr4dh/2YaZbkuaYcENz2963kRveK+si3KokLK5BD6LQLACTwOF+X+knODAmKp2HiWK61CMb5A6iVPjtHPe/5U3KFsHaOXZjWjoK5/Ww3tRub0fhgznd4RfPcIGcE3/cDzmazfH9nC/qv6QRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 1 Sep 2026
 10:04:37 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:04:37 +0000
Date: Tue, 1 Sep 2026 03:04:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v6 1/4] drm: Add drm_work_fence helper
Message-ID: <apajM61BSLfujphS@gsse-cloud1.jf.intel.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <apXiUtrKHlSaw6Yc@gsse-cloud1.jf.intel.com>
 <IA0PR12MB8208A6F1D70E8154A951012C90A82@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA0PR12MB8208A6F1D70E8154A951012C90A82@IA0PR12MB8208.namprd12.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0326.namprd04.prod.outlook.com
 (2603:10b6:303:82::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d720deb-a06d-4986-02d9-08df08106e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|4143699003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3jLbGb3eRiMG0OA4ag+yr0bi8lC5f6epH/K/eX5gThSPH5QPGT/05DB0RS4GfcTZNT4ASS7vve4/hXeqy2NjVyEeNk2x3kH+5Km37/wW4w/w4+ov6eqOmGx1F7QEsJHH43zoIzvgsVqozRfYok5M9HhRnaiVBXHfn95rdHW1N5rCQNrdlqeK1wETYYPkvb4IPH3lt4t3uSHsg2SuIumfvXrwEQ0X3eRjQLOlrQ4MYHoJScW0Weh4EgmuPMKHBJ03Q8j3LCRwLxaBJ9nyC6IJb2nLEok8KuZG6j5HXPC7n20SZKBm7rhZp1NbKHJbrsRrwUfQbwXiG+6D2IB47vmYYO5Mg7TpQrHMso6P6oaTeyWwvACqsJSFgMXWyR37eolI8c49NS4ZdBH/HZWxLENQD02xZwhRsDHwcWfCAszsfkIT4KyUvqvewyQPu8/Hc3ITZ8GJ+lLimm27ubCMSGfUbFXyhVhMy94fk5DO40s/YUbkdyBssNM7+O3oCaYJ0VyNKEWQjr+IcvulXAJkWfwrxrnSqiSeKdkZfKzj+EaJpg1K9xx6QtX+HW1lTLx6HDjOgIJaIHKAacVnWSz5llZaPi0NgfYlGzCVxgFyDI4jVFJmICm3awmxcDfAIBB3BeIx8ogenCE8WqVStfcIHSgL61aiS6vysmzs4sYQEL/9wQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhaZnZzNk1NZnhiYzRJRm43WU40dXZiVUpkbThRWTVxZ1pTWmtXR0FxcHIr?=
 =?utf-8?B?ZHc2WWlWckI4SFVYaGtHV1BLblVFME9vWE4rUTF5dEI4N2haQ1BkU3dzS1Q4?=
 =?utf-8?B?OWZ5dmFyTUQ4YVVpS1E5SC9EUU5NTzNjOFhiK1IxTDh2NVZyL0FpUHBtREtC?=
 =?utf-8?B?cXM2Y2QwUnlLclJPZmUvbjh5QVRuRXc2S2NFc1VWOFJIMXhoNmZnNEhBcy9J?=
 =?utf-8?B?K0FMcDlDdExFMTcweXk4c3V5a3VTZHJSZjFqWnJINlNvOUlKRXhQNytrWkF6?=
 =?utf-8?B?endPRnFhTzhncWtOb0licW94QnhIbzBlN3hXQkkzY0Q0WFhydXZFK0RQZWg4?=
 =?utf-8?B?aTJXaTh1YkhYUUdnYkN2eHI5Tk1LbzBmL1pEV0w1WFgxdlpjNENCNTZXOEdp?=
 =?utf-8?B?Ui85TGhnZyt1RUQ4cjlTdWdoUFFreFg2WDMrQWZId2l1ZGYydGFtU0V5eGd4?=
 =?utf-8?B?dVVKSGpPS1EzbGFURE9CSnhrMDdKRkVhSHk4Q2VISkFNQitJUks2NUZURG44?=
 =?utf-8?B?eDBSMkhHcEpLTWJ4eUJCNzB2SHhwdkxCOUlvbjhYc0J1enMwS2VnSVhjNWsz?=
 =?utf-8?B?eG9HODZKYncxdHJ4ODRsSnhXY1Z1dHNYYkE4TFJkOXVtbmlYZHdjZU4wYm5w?=
 =?utf-8?B?S3VjbmphZStHblZ4ZVJpUkY2TGNYQWhuNFI3bnpnNjVEUklUSlNlbzRzeTZE?=
 =?utf-8?B?SkF3N0VjWjAwcDk1bmJGU1lwWjl1WnNiV2ZyNmphTitNaCtCWHAxdSt0Y0RS?=
 =?utf-8?B?bTlZVWJRMURveTRqanBvQWdMZUUySmIwYVlxZFYvc0wxRzlkQ2I4L1ZqM3VU?=
 =?utf-8?B?c1BHcFV0eDg2eWZEclRHNzBKQzdxUlB5RkNUNmJXWEd2WFJwSm5yYndxNTU0?=
 =?utf-8?B?dHpMdzB3aldvTXdSUTJ1N1R5ZHoxNTI2YXFoZEZ1aTg3TXBvM0YxM3F3Z1FY?=
 =?utf-8?B?UkQ0eUk1VTVMVHlwSUp1K1kzbjg4NXF6QmdzV1V0eGRBbVRVbnZQS2Q3cWZN?=
 =?utf-8?B?U2RkbkRtdVF0STNEclFhVnNFQ1NobzdmNUpTdXE1V0QwY0IrUVl4a1IweFo5?=
 =?utf-8?B?KzZFYkpiby9paHZrMEVIT0xJZEFOcDhML2hUcC9rWFh6NlpqZldMbEppUzAx?=
 =?utf-8?B?VVFlMmp4cWIxOUh1ekZ6NkJpVWZReWE0d1pqdEVONzZWZVZPR2k0R0YyblZQ?=
 =?utf-8?B?RG5zZFpjS0RrcW1YMFhqREV0K2dyL1pUVWl0dEtXOHh3cW50cHJuREdKanBT?=
 =?utf-8?B?dlEvcWFBQWZ6UnpISHdaUTF0WWx2djJZYWZYdE1lWVFVMW9MZFAreUhEbDln?=
 =?utf-8?B?b0R3MUZSS1oweHV3T3J4TzlmYUZ0NU5pMHNmWlNaMHJtcUxuYzR4V0tkRXJ6?=
 =?utf-8?B?aHo3Y2xyb25ZL1lld0c0bmVYWjVjUlFpYkIzMU1yaXdWZDVNRXNYTDQ0WTVs?=
 =?utf-8?B?QmE5NFFPRmZoeE14cDUyc0dITEwvMTI4UjJncTRvdG9hNmt2TlVRVUx0Z2RR?=
 =?utf-8?B?WFlMN1RoblhGc3FwRlkvYUxTaHJ6dmFDN1BFbTMwMlgvZ3F0b3JldDV1WXBx?=
 =?utf-8?B?OENYZk5seDhvRHBaODc2aGxJc3JVOCtMNjZKWEJOK2syd1o0ZloyVDVHNkRG?=
 =?utf-8?B?M0JRQjNsZC9zQWNYNU5WcytSa09CRzhkZldxVDdVODIvdmh1QVA1bVkzT2Fm?=
 =?utf-8?B?dGZGOFFtZ1hxbmVUMFQzU2lUSFpLQVBOd25xSDdkK2pJejhqOWY2a0wwM2Fl?=
 =?utf-8?B?Qk9VNFduc2ZvN21DNVp1RmhTZEtHanVyZzFrOGFFVndsYkwwZ1BxOUREQUd2?=
 =?utf-8?B?S2NpWEJCUnBKOVVjUjBTc1N6dkVsTDQ1eEdZNDh3ZnFOeU5FK0tpQnBmRkRZ?=
 =?utf-8?B?aFIvRVFpQmNhdDBUaUpJMFdUN1BzWWNBc1FjMFpyYXFzU3VaZHcxbW96U2pa?=
 =?utf-8?B?VzNHY25qQnNKcU45VFVwTGVDWlIrRy8zWmk0clUwQ3l1K05ZYzFxeFliY1Rs?=
 =?utf-8?B?ZU5Fd3poSTlXbDUydUs0WkVmT0VtVnFKc2dDNVM2WjQwdVlxQmVTdGU0bjBX?=
 =?utf-8?B?V1diMFV1QWdHb2ZOTGliNlIvVGQva2pzdWpKVDdJcXBWWVhrNEZlb3pkSEJD?=
 =?utf-8?B?TTEvMHlrWXExdzhhTFJiVkt1VDZDdjVhd3h0UlhhSzBFYm81eW1xSmsrRUF0?=
 =?utf-8?B?VFlyVHdBVHY1aURIVkplSFQ1RytFeGdyQytDK29iZEZJbEJMMXFGaSt5RU5q?=
 =?utf-8?B?MW1reXlSN25JSisrYVlVUU5qOXlSR0FxclROUEt3TllvNmR5ZkZiZVhReGQr?=
 =?utf-8?B?aGpzOG5VcVd5ZzVNZXU4S3NUUUwvNE9iWEx1RGZsa2VvRDZiQWhkdjJWbVpR?=
 =?utf-8?Q?IYFIwnN6ElcWv2iw=3D?=
X-Exchange-RoutingPolicyChecked: BEnrUUY3h0B0UWTOEgeOTbc67PKE0cXTNQMTWlxYhnj5y4aD6AyfPvO+ne5AKv8RNXfOjAgv5FGZHZ9tsGNfoCKcPlxIba7R4+pS24DKQy2v/OCUK20WGtivfUt3MLgHfNGQTjaR8cNgzHuV0/YjmYeQMAlkrPQvo69aTLyRgX3fb0rxkVaxa8K3zVtXiUCd4h6y3JONVoxl7pnzBhMp9+LeVDbnh7CTWCD6Ael7z7wFkogoTChhF5yuz9qe/axLiUxfsZIj+ZwMQwg4Zn3OFPGHDRhD47UQItRzYETmhxnkErlT2GrG4lcMNJN+zIW4wcf8GrYlOzCs3x7Ucbi/jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d720deb-a06d-4986-02d9-08df08106e7b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:04:37.7756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61HIvJL9HW4myjXHIIqiMVmh3v7DcX5OEB+l/uHS7CMcJFA1mZvFGDoqzTBhPvE+o8qX1wrtBZLvQiTUyyF0Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
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

On Tue, Sep 01, 2026 at 07:39:40AM +0000, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> > -----Original Message-----
> > From: Matthew Brost <matthew.brost@intel.com>
> > Sent: Tuesday, September 1, 2026 1:52 AM
> > To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>; dri-
> > devel@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Koenig, Christian
> > <Christian.Koenig@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; Maarten
> > Lankhorst <maarten.lankhorst@linux.intel.com>
> > Subject: Re: [PATCH v6 1/4] drm: Add drm_work_fence helper
> >
> > On Mon, Aug 31, 2026 at 07:15:36PM +0530, Srinivasan Shanmugam wrote:
> > > GPU drivers often need to queue work when a dma-fence signals because
> > > certain operations (copy_to_user, eventfd_signal, memory
> > > allocation) cannot run in IRQ context. This pattern is currently
> > > open-coded in multiple drivers.
> > >
> > > Introduce drm_work_fence — an embeddable base structure that handles
> > > the dma-fence-callback-to-workqueue pattern in one place. Drivers
> > > embed this in their own structure and implement ops->work() for the
> > > deferred work and ops->destroy() for cleanup.
> > >
> > > The helper manages:
> > >  - kref lifetime
> > >  - dma-fence callback registration
> > >  - workqueue dispatch on fence signal
> > >  - safe cancellation before driver teardown
> > >
> > > For work that additionally requires borrowing the process MM via
> > > kthread_use_mm(), see drm_user_fence which builds on top of this.
> > >
> > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Christian König <christian.koenig@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > > ---
> > >  drivers/gpu/drm/Makefile         |   1 +
> > >  drivers/gpu/drm/drm_work_fence.c | 195
> > +++++++++++++++++++++++++++++++
> > >  include/drm/drm_work_fence.h     |  76 ++++++++++++
> > >  3 files changed, 272 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/drm_work_fence.c  create mode
> > > 100644 include/drm/drm_work_fence.h
> > >
> > > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile index
> > > e97faabcd783..c5be8e80d0c8 100644
> > > --- a/drivers/gpu/drm/Makefile
> > > +++ b/drivers/gpu/drm/Makefile
> > > @@ -72,6 +72,7 @@ drm-y := \
> > >     drm_vblank.o \
> > >     drm_vblank_work.o \
> > >     drm_vma_manager.o \
> > > +   drm_work_fence.o \
> > >     drm_writeback.o
> > >  drm-$(CONFIG_DRM_CLIENT) += \
> > >     drm_client.o \
> > > diff --git a/drivers/gpu/drm/drm_work_fence.c
> > > b/drivers/gpu/drm/drm_work_fence.c
> > > new file mode 100644
> > > index 000000000000..9f6b779d0fe9
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/drm_work_fence.c
> > > @@ -0,0 +1,195 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * Copyright © 2024 The Linux Foundation
> > > + *
> > > + * Common DRM work fence helper.
> > > + *
> > > + * When a GPU dma-fence signals, drivers often need to perform work
> > > +that
> > > + * cannot run in IRQ context (e.g., memory allocation, copy_to_user,
> > > + * eventfd_signal). This helper queues a work item when a dma-fence
> > > + * signals, allowing that work to run safely in a workqueue context.
> > > + *
> > > + * NOTE: This helper consumes dma_fences but CANNOT implement
> > > + * dma_fence_ops. Work items queued here may sleep; dma_fence_ops
> > > + * callbacks are called under the fence spinlock and must not sleep.
> > > + *
> > > + * For work that additionally requires accessing userspace memory via
> > > + * kthread_use_mm(), see drm_user_fence which builds on top of this.
> > > + */
> > > +
> > > +#include <linux/workqueue.h>
> > > +
> > > +#include <drm/drm_work_fence.h>
> > > +
> > > +static void drm_work_fence_destroy(struct kref *kref) {
> > > +   struct drm_work_fence *wfence =
> > > +           container_of(kref, struct drm_work_fence, refcount);
> > > +
> > > +   if (wfence->fence)
> > > +           dma_fence_put(wfence->fence);
> > > +
> > > +   wfence->ops->destroy(wfence);
> >
> > I'd invert these for safety in case destroy wants to looks at the fence, admittedly
> > that would be an odd use case.
> >
> > So...
> >
> >       struct drm_work_fence *wfence =
> >               container_of(kref, struct drm_work_fence, refcount);
> >       struct dma_fence *fence = wfence->fence;
> >
> >       wfence->ops->destroy(wfence);
> >       dma_fence_put(fence);   /* this has a NULL check */
> >
> >
> > > +}
> > > +
> > > +/**
> > > + * drm_work_fence_get - Acquire a reference to a work fence
> > > + * @wfence: work fence
> > > + */
> > > +void drm_work_fence_get(struct drm_work_fence *wfence) {
> > > +   kref_get(&wfence->refcount);
> > > +}
> > > +EXPORT_SYMBOL_GPL(drm_work_fence_get);
> > > +
> > > +/**
> > > + * drm_work_fence_put - Release a reference to a work fence
> > > + * @wfence: work fence
> > > + */
> > > +void drm_work_fence_put(struct drm_work_fence *wfence) {
> > > +   kref_put(&wfence->refcount, drm_work_fence_destroy); }
> > > +EXPORT_SYMBOL_GPL(drm_work_fence_put);
> > > +
> > > +static void drm_work_fence_work(struct work_struct *w) {
> > > +   struct drm_work_fence *wfence =
> > > +           container_of(w, struct drm_work_fence, work);
> > > +
> > > +   wfence->ops->work(wfence);
> > > +   drm_work_fence_put(wfence);
> > > +}
> > > +
> > > +static void drm_work_fence_cb(struct dma_fence *fence, struct
> > > +dma_fence_cb *cb) {
> > > +   struct drm_work_fence *wfence =
> > > +           container_of(cb, struct drm_work_fence, cb);
> > > +
> > > +   queue_work(wfence->wq, &wfence->work);
> > > +   /*
> > > +    * Put the transferred reference from add_callback. The stored
> > > +    * reference in wfence->fence is released in drm_work_fence_destroy().
> > > +    */
> > > +   dma_fence_put(fence);
> > > +}
> > > +
> > > +/**
> > > + * drm_work_fence_init - Initialize a work fence
> > > + * @wfence: work fence to initialize
> > > + * @wq: workqueue to run the worker on (must be ordered if sequencing
> > > +matters)
> > > + * @ops: driver operations
> > > + */
> > > +void drm_work_fence_init(struct drm_work_fence *wfence,
> > > +                    struct workqueue_struct *wq,
> > > +                    const struct drm_work_fence_ops *ops) {
> > > +   kref_init(&wfence->refcount);
> > > +   wfence->wq = wq;
> > > +   wfence->ops = ops;
> > > +   wfence->fence = NULL;
> > > +   INIT_WORK(&wfence->work, drm_work_fence_work); }
> > > +EXPORT_SYMBOL_GPL(drm_work_fence_init);
> > > +
> > > +/**
> > > + * drm_work_fence_add_callback - Attach a work fence to a dma-fence
> > > + * @wfence: work fence
> > > + * @fence: dma-fence to watch; ownership of this reference is transferred
> > > + *         to the callback — caller must NOT put it afterward.
> >
> > This isn't right. It is perfectly reasonable for caller to hold more than 1 reference to
> > @fence, thus put it again. It consumes a single reference @fence on success or
> > failure - that is it.
> >
> > > + *
> > > + * When @fence signals, a work item is queued that calls ops->work().
> > > + * If @fence has already signaled, the work item is queued immediately.
> > > + *
> > > + * An additional reference to @fence is stored internally in @wfence
> > > + to
> > > + * allow drm_work_fence_cancel() to be called safely without the
> > > + caller
> > > + * needing to hold a separate fence reference.
> > > + *
> >
> > Ideally get rid of double ref count on @fence. I don't think above reasoning justifies
> > the needed for a double ref on the fence. I'd tie exactly one refernece @fence which
> > is attached to lifetime of @wfence (i.e., drop the dma_fence_put in
> > drm_work_fence_cb).
> >
> > > + * On any return value the caller's fence reference is consumed.
> > > + *
> >
> > I'd mention regardless of success or fail, a reference to drm_work_fence is
> > consumed too.
> >
> > > + * Return: 0 on success, negative errno on error.
> > > + */
> > > +int drm_work_fence_add_callback(struct drm_work_fence *wfence,
> > > +                           struct dma_fence *fence)
> > > +{
> > > +   int err;
> > > +
> > > +   drm_work_fence_get(wfence);
> > > +   wfence->fence = dma_fence_get(fence);
> > > +
> > > +   err = dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
> > > +   if (err == -ENOENT) {
> > > +           queue_work(wfence->wq, &wfence->work);
> > > +           dma_fence_put(fence);
> >
> > Keep the implementation in one place?
> >
> > drm_work_fence_work(&wfence->work);

This is a bad suggestion actually, I was a bit distracted I guess - you
can't directly execute the worker at least in Xe as
drm_work_fence_add_callback is called holding the dma-resv lock and copy
to user can take mmap_read lock and we'd insert.

> 
> Hi Matt,
> 
> Thanks for your feedbacks once again!,
> 
> For the ENOENT path — I'm planning to extract a small shared helper:
> 
>     static void drm_work_fence_queue(struct drm_work_fence *wfence)
>     {
>         queue_work(wfence->wq, &wfence->work);
>     }
> 
> and call it from both drm_work_fence_cb() and the ENOENT path in
> add_callback(). This keeps the implementation in one place while
> preserving async execution.
> 

Yes, basically whatever drm_work_fence_cb does, stick into a helper and
call it here so if implementation diverges for the CB, we only have to
change it in one place.

Matt


> May I kno pls, is that what you had in mind, or did you mean something different?
> 
> Thanks,
> Srini
