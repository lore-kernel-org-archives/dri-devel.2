Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19011606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ezp15Dt6;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k0lQ6fBK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D2B10E22C;
	Sat, 14 Nov 2026 08:26:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B6110E16F;
 Sat, 14 Nov 2026 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794644760; x=1826180760;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lxXQZ2sv85Cn/MRgwCKz+k/n1WnMo+IEwNZ6dELIjJw=;
 b=ezp15Dt6yxmTRUR8CpepemRN5twEVgGQ4Hwx+CBtpSD22lGqTeUyQTzj
 erJWkOtfb3phHBnrmI0Ai7E2YMWBKLvjpJd9031J7xm9XVm3OXgvv1gCj
 AkCfrlV44tetac3/c5EABlk1YRIjZhNZleFsfrIBhugUTq/LOCceYTLaK
 tHsfYFTxzSaM63ZC0wsubxKP2vLYfzBP8oMDW8rQelMt29Zr0q5n+krdW
 sVRlcGfrECklj2k5yRSyMXc/8dgnEsSZIDu4aLdkJgT5C+qYwhDIDpeJ1
 mgh9Iy4p1uMVLdIT2sRFRtowSXGb9TytgOxhMZL2ekNUOanpTrnw3gFdq Q==;
X-CSE-ConnectionGUID: kNeyJOBiQeeyHwaiAiSTkw==
X-CSE-MsgGUID: 8qA0gH50Qhe18PPTIOBCNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3457847"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3457847"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2026 00:26:00 -0800
X-CSE-ConnectionGUID: XlZBhvWIQ+mh+ct3e8d4yA==
X-CSE-MsgGUID: LTqXeK4WQVeBMZ8qQrpvLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="8955120"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2026 00:26:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 14 Nov 2026 00:25:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 14 Nov 2026 00:25:59 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 14 Nov 2026 00:25:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwNzNN74+J32Iic36YCGm1JYBmVG8fXqSAm0M5skwCFBZHYjfFEzcyF1xYad+7aP1iaJ4AarCKjpvhFr2cTv1EaV62me3fLYXQws0fDyCh48ivcmRFCYOXTMAHr0xoSHaWYUVULNLaf/oy/C1R1iZ6AukAYsF051e5WvrmS4Dy85w8aq4zI7i9u8KE+a+1suJP5f7j6KUMDxix/fMdSiHgOvPpRavF2ZSgafWDGqn9Y5l7yknp7OqC2rwpgaa7QkV0QbvUzUWMOQoAl+kOHOXTIRvoFbdqb57MsKw1NW17oJyBbAITejaNKEW2YRvuQrcZNqVw0xJxNFYWBCiJJqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj9/WoYBlJV/HxdPj8uoPQe6c5+HnQJs71aguPBtF7w=;
 b=mp+2g85rtdH/DuiYkZsiahQQLhOT6rWqkl/JXW+nEIfi0NWl0KialESfmNhTSfNkuta6MLBfk4ksleHkXIJxUpYFhA9+roF81BeENeWbk9dglk1FT69yGhGEF90uFWDr+G3V/13B9C6AayODKUtPRu9R3HND4VSoptoBsQldbBpf25RkfG1/hQ2nCDlXlj594Tk00v+SqfAkWvrZeSmMk95Uf+eYxel41WgzVv24ML0Xk9QJEf6wox9kopotvr00nN20F6mLRlG52w+sMmggKq1jdzlC8+Pxp0YLY1vGeTBDt0vy6TGTH1j9US4UisRlFJ6s69yKKh+k+GTaqt4TiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj9/WoYBlJV/HxdPj8uoPQe6c5+HnQJs71aguPBtF7w=;
 b=k0lQ6fBKGQsDW6tcvGKKWhkBieSaZPJgqzv7Niku5pSq/ltLFBRM/+UkZewYf7Sj+BPc1ESYoBjJIwWFUqjk9oXKXo71Pf8ip1Y6jMNUpIis/Ot0hEUyllmZzT0lz6hKYi9/rZQcId9oECQSQ8/QilZALkzdwMTdPoibtelTbwg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by LV2PR11MB719417.namprd11.prod.outlook.com (2603:10b6:408:413::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Sat, 14 Nov
 2026 08:25:56 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%6]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 08:25:56 +0000
Message-ID: <b90560f0-dbd7-4cf3-a413-2c6beada9d8d@intel.com>
Date: Sat, 14 Nov 2026 13:55:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Account for exec queue cleanup after handle
 allocation fails
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <tejas.upadhyay@intel.com>
References: <20261113065437.249640-1-arvind.yadav@intel.com>
 <avdWloP416vGgEgT@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <avdWloP416vGgEgT@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0199.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::12) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|LV2PR11MB719417:EE_
X-MS-Office365-Filtering-Correlation-Id: 42003f6b-dcd7-4f33-fcd5-08df4228e793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: KlPjcavYNJOHTP6/cePTJMy3vimgntvZxq6OyMSNIVnzqJshPSj5SRoir1sU4q8W3JIBiLZodFDls9yIw3LoNaJXd97IwLb992TkNgt/ipaFbG8rmF8tPro60vvsvRSsxPjywTYF2BnPhW9E7j8moESh3DVKtMEA4sRXqh0xFsg1P2Ipf7PP82I2IJe4Ch3+/IRgvCXesNSoFIFZbdyIb3e6uNkYtWQQdysDJmQiRIZlGJYPDnOiH0TVlcOm02sAxe/eKIKVztaoR62DPbO6eyfp8B50OdRz8xR67EyT8VYaw/Y6sDhS6Rd46UJ0l6xR9zATU2VZWb+9cxwYLknhWTKoGqS4OD4lK9pAe23uEDi89pgDHzhBq7MVY7DvY7iBrg7R9GuvqrSVReADzyONQKQzofVZ6QXojKpds+7GDISIiDViHnI77ol9Ui/dFDjOFuKVf/HH4A72vgP/Bftn9J4pE1byL6Ee+QeqQhCVDzWkS5GXJBt8NrO7J0YujfVdCeXS7uLE8Aua3WHBpsFbhCQ6M/apfK7JcQHyXZ0rn0TCYXJV6i5ykF7bXt1vV1/A/9F3nWDYpoeVcko3H7E8YWqKEl8ilrAYVUY8pCL1rwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJiSmRKUGpGWWozczBqdGU1OUpVakNBbXNuL2F5c3JsYnNaUVAvblVJcE5n?=
 =?utf-8?B?WUtNMFZBcVV0REhYcUdmWVRSaGo3OExLWkhoZjZNMnVCVEw5THI1WXNsaGZl?=
 =?utf-8?B?YW9oWFJ1NHVrc0lJZlVnSVV1alUydWpqcFdtMlpHbVQ5N050b0tnY1l3V3A2?=
 =?utf-8?B?QnY1b1ExV2ZaalN2RjdOYnBIVm1lc04yeFVEZmIwMkx2R0Rzc3VaZWpHL0I4?=
 =?utf-8?B?NGZkTkpHWGNNeUhPdkowZXRVbWdudlozMnhtMnJCQUZSSE16RktycnNkS05C?=
 =?utf-8?B?MHd1azFwRDN1dGk4Sm9Mams2R3lFV0lzVjgvalBablhQKzcwcWRucDU0ZVBT?=
 =?utf-8?B?blhZUDZyQ25BTE81QUZsaGxhQWgraWlsMjUxR01GTG9jMGRLTW5Wcjg5c2dK?=
 =?utf-8?B?MDh1eGQxa2h0cDlYVFYxcHdIZGtRZ2REcWNBYTJDNlFBcVpEVnI2eVRJejgv?=
 =?utf-8?B?TkNmbldvMCsvNXF1TUUvK1I5UzZoQk1yRjR0YjM5c1FoN1BqUmZjQlVLYmFB?=
 =?utf-8?B?am01NXFIMDZvKzJzUXhTblM3Y0FHSUQ1ZGpmYTlGbFhrbGI1TjNqcWt1RTcr?=
 =?utf-8?B?eVZxTEtMQVdOc1JWVVFWSFNCbFNOWjc1ejVpUElDUUNPZ1YxVld6dW0yUTds?=
 =?utf-8?B?ekVGTUwvTnoybWZjcDdXUXhMMklISEUvdTRWNnJjVHNCcUZ4RkE1b00xVmcv?=
 =?utf-8?B?S0g5dGV6VnRCUzV4T3BPaFdpUjZ1KzQ1S25FaFBONkdpcnV2MVFuVm1IbUNS?=
 =?utf-8?B?eURqVk9YQm1CRW5CakROT1dKa1dia2txaXpFZFc1b2M5eDg0U1lxZGZlVFRq?=
 =?utf-8?B?Tjd6dTNGcWtQUUxOd3Jnak1FbUtoMS9OUW43dEcrRHFOZy81eW5BbjBDb0lX?=
 =?utf-8?B?a2hNaGdPZllyKzk1RW56V1JNWDFOQTRPY1dnVmtaUVVEcXIySlptWk95SG04?=
 =?utf-8?B?SnVWYTRzMnZlc2RKRWFJNmhMdWNQMmpDb1cvTnQ2NERJSE5WRFlkYUt0d0N5?=
 =?utf-8?B?S0RqVEdZZ1JYZGNFS1JiVGc5UzhZdGJTL0ZoejJ1aDJ1WXNOYWFUZ0k2ZTNN?=
 =?utf-8?B?cjUvWXJ5U1NRbkpyNFhhNmV5VUNrVTBYVXJ3SFl4UWNNVFhXdW14VjdJeUFi?=
 =?utf-8?B?OTZoZlFmN1lLTFM5aTBuNkRxZXN1Y0phOFNlQUN0YTZXSXBTa2VUVXpvcktL?=
 =?utf-8?B?RHNidUR2cTVhd2pod1JhekExL3h1ZXdxc1BRQjdMQ2Y2dmk3bWwwdDAvS0dD?=
 =?utf-8?B?MC9DOC9aV1ZPVnRNRVcySFBIekVZQWg3ZHZ1VDFoTGYvRjlsc2w0WVN0SzVP?=
 =?utf-8?B?N2RpaklNZll0YTc4SU50NXB1RHpxdUlqSTBoVHNPaEtwRnVvZ1pTS2J1bCs4?=
 =?utf-8?B?NUh1MGJnbUF6QzNTVjllc2dERGx5MzRJNEd4UVJQVzRBRnp1OUxBMUMwWXRB?=
 =?utf-8?B?UVhPcHNaZEdORmVneDJXMVJheTROeHJ3ZTUyYmtKQ1l5eCtLSHUzN0xMdmp0?=
 =?utf-8?B?TUUxWTJCY1VId1JrSUJTcFVhbGI4cXlkZzYwWWNQZTd6SVhQbzhCNWlwaGJN?=
 =?utf-8?B?TEtSNjVtRlg2WG1qNnVJNUtCekJSaFJwdGwzbVdLU3ZidHRhWXlkNFRkUUNp?=
 =?utf-8?B?OGtQMUZST2ZlUUJVSkJPdWI4QkJZOUcvejhjV2dtRXlXWmpNYnBZSnVJeHBu?=
 =?utf-8?B?Q1Jmd0dMR1B1Z2NncXFwWklPbnE5eWk1RHR1d3psOWNxQk5HZS9ja2w1RXJC?=
 =?utf-8?B?b1MzTU1VKzZ5VHZ3cS81U0hTOGZYcFNKVkZubklETG04c0RtNjhOS0dGNnQw?=
 =?utf-8?B?WUk1TVA2WkV5b2w1VytBdEZMYzkxdEc1Rk5nREhqUCtsNmN1TGxMcmRtMHlX?=
 =?utf-8?B?UWhBckd4TStvQ2V4d2ZxQ2tuUnhBLzNtT1RUSGdsNjdZUy9pakR1TDYwY2Fl?=
 =?utf-8?B?b0t6NjFQWDZ2OEhnM3oxdjNReUlwSG1aSEtMUXRuZyswVEZXak94ek8vU3ZK?=
 =?utf-8?B?ejBwUGxxNFBQaGR4NEg1ZmUwUzduZndRUHd2N2JTRVUrRTZVSXczY20wVEMy?=
 =?utf-8?B?bW5sbDZxZGNETUlWaTh0VnE3Nk4ycmRWRk8zZDVnK0w4SXY1MENlSjR0UWVN?=
 =?utf-8?B?UWVxZ3VvSEhBTndjRWh4Z1lPb3ovSEJMcmlzQnQ2TGtVakRPRW10VDRTN20y?=
 =?utf-8?B?dGRnbVRsaTh5d09yemhKd2wzZVkwUDJLb0pmSitJUUJRdUJZaThoLzRBc1d0?=
 =?utf-8?B?bXhzZHNYSktHaHYwMkt6MjE5elRNU3BmaWdqTmRIRnpLUnk2VGppVkxqQU96?=
 =?utf-8?B?QmYyZ3lNS2VBeFBUUEZTTW9PcnIrZmlZRE5OeHB1d0RkWlI4MWhCUT09?=
X-Exchange-RoutingPolicyChecked: rvorhpZd8SkO01rEp4c9vEFMsEQK4Nm9m4NgRuiHY7WW0mxDqxPDtDMDUhIBR/pNgU0ZqE1fxd8fMhL1MXFLifvrnuQesWSuGUK+NeMGUrTuPPPMBIdu+t8n0rERj/TFEKAMQBP38gYeW9wwuN0fsm2upEGMkvzX0yPIFxOGjyT0WUvBgyHd+HPTbFZQ8NDt2lmdhgE64Q10qumBtQfTHnYkMYucbR2PMitFb/RSTqG/z0lMpaSedMbUxF//AnrWh2dzt9FtNoCbDouQmAdYnwfFx3iVYhiiTC2s2yXDBhFcj5Dx0FK0yEMH5eUHrPB7sZZkiw0ruiW9ohoMsPGepQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42003f6b-dcd7-4f33-fcd5-08df4228e793
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 08:25:56.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwrYz34R4eMwDXMC5cE/oUF3nuWCxXdvn5nNbNL0mSKwlP6hNI7G/yux5apJ8XMv7t9cGgqe4ABJr2fPgsLnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB719417
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


On 13-11-2026 23:57, Matthew Brost wrote:
> On Fri, Nov 13, 2026 at 12:24:36PM +0530, Arvind Yadav wrote:
>> xe_exec_queue_create_ioctl() assigns q->xef before allocating the
>> userspace handle. If xa_alloc() fails, queue finalization decrements
>> pending_removal even though the queue was never removed from the
>> xarray and the counter was never incremented.
>>
>> This can leave pending_removal negative and block fdinfo readers
>> waiting for it to reach zero.
>>
>> Increment pending_removal before unwinding the failed allocation.
>> The existing finalization path balances the increment.
>>
>> Fixes: 0fd4380c050d ("drm/xe: Wait on killed exec queues")
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>> Assisted-by: LLM
>> Closes: https://sashiko.dev/#/bug/linux-0e3ad548-c571-43d0-bf6b-00ed4771bd7a
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_exec_queue.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
>> index 7ade915c59a8..39d99d6d418c 100644
>> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
>> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
>> @@ -1471,8 +1471,14 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>>   
>>   	/* user id alloc must always be last in ioctl to prevent UAF */
>>   	err = xa_alloc(&xef->exec_queue.xa, &id, q, xa_limit_32b, GFP_KERNEL);
> What about moving the xa_alloc above setting 'q->xef' and calling
> xe_vm_add_exec_queue?


My concern is that xa_alloc() makes q visible to other threads sharing 
the file. If a concurrent destroy occurs with a ID, q could be freed 
before we set q->xef or call xe_vm_add_exec_queue() and this will lead 
to a potential UAF.


Thanks,
Arvind

>
> Matt
>
>> -	if (err)
>> +	if (err) {
>> +		/*
>> +		 * q->xef is already set, so xe_exec_queue_fini() will
>> +		 * decrement pending_removal even without an xarray entry.
>> +		 */
>> +		atomic_inc(&xef->exec_queue.pending_removal);
>>   		goto del_hw_engine_group;
>> +	}
>>   
>>   	args->exec_queue_id = id;
>>   
>> -- 
>> 2.43.0
>>
