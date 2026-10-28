Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55646606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k6eYoiZo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AD810FCC3;
	Wed, 28 Oct 2026 14:01:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEB010FCC2;
 Wed, 28 Oct 2026 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793196063; x=1824732063;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MJl+ksicmb+TdKGjiobJkhkBimJqhmXumCSCBdbwkzY=;
 b=k6eYoiZoGADqXyAiM2IDCbxIdT6J2zV8v9qvBG5WA3pk+bRyV1OhB3dn
 wy8rLvokHHRxxkwzu4Xs/3ggp9squ3cwiy45z3sfpwWJr6qPRgYc1kYiA
 rRhOrqp9tPrOrFtMO9XHIj+VggzPQjbKnBs9b48UinjhcZOMH8Ho89VNH
 a4Kw94NhP2Ty2OU7yrDdQJtZE6JqG//rgwoIi9cRmgdCpdXP78AzZ9xun
 hQMOR8bNCtln9sE4fEbR0K2zzAVY2H6pVvjAD2SPWB1bOE3GVEviqfH27
 eKkd/clxgrAYXllyQXGuW+CrWDdWJQbyZXqubyl0skxqOu9fUeXeYx962 Q==;
X-CSE-ConnectionGUID: mexZGcK8TRipAvSz7M5eSA==
X-CSE-MsgGUID: 3WLhOMBqTOKcxUvjhfHsJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1813567"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1813567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 07:01:01 -0700
X-CSE-ConnectionGUID: 9mBM5PX5TDSazq66OU2NrQ==
X-CSE-MsgGUID: UXEtla63R6+LbKY/amAiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5363015"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 07:01:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 07:00:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 07:00:59 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 07:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Thb67gdYFa9vGAYjkWVbM3n4mrtsXIkCZmpwAzcZm29ZOJya3PGmybjCsxnlv/clJfmLFfWbatSRkrd+bleHOnTXi+oU4Lk0SDrAy7RCMmKzgxYDH7K4Wmbrtm7g74PBKsvBWzkGd7Ji6SUtjO8gm+DSQpMX7yjFraQWeza6bWhgbxn/JLOxUEAnmbWrTqbFCEplhwD9nXxRxYqApG/nIQ/XALiv2syrmaY+KOSDEX4aSeb9xo0lSAYTyGboDW9AvGYf1ueRRgnUX9gyGVens9PuUNDnintGdCxf44xaQNux9Mf2fKxMEgNfwvQEljDC8SKI0odQMA+EWL+YyN4Ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfvw35x4sPGv9fbmso45kydGN1sLuuSHJOwRnfa3yZM=;
 b=s2trD1l7peDzghpwpjEUd3U2+XEb7D4EMKibqahh96/Y721ZfcutNy1av/aLM0q6DTii8khc/c09WITYOg4NJJ2B6WN42B+J4m7bYrSr3Z+ISMHCjhx57MZos6mktm3G/+WDFic0simN55Icxe47tV5xIjCDxagti05RhCn/xviD7pSehvY6960eLisf+SHVK2A4gmRBSLo2NfBYc9VwJy/YN0SMWPDqvbrz2RaSotMi+PSvanBcft4o1On6VXk6XaqEbErL3W903mJ9gkeOgmYmEuOvpcl5MPjrJs+TS9Cg9fUlRCwooiAUWc/o2lhMZTzWoCu7e/6hKwWnUsNfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:00:58 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:00:57 +0000
Message-ID: <6d36e1fd-362b-49fe-acb5-954daaf415bc@intel.com>
Date: Wed, 28 Oct 2026 19:30:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/xe: Mark VMs as closing before queue cleanup
To: Arvind Yadav <arvind.yadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <rodrigo.vivi@intel.com>, <matthew.brost@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
References: <20261028122125.3772832-1-arvind.yadav@intel.com>
 <20261028122125.3772832-4-arvind.yadav@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <20261028122125.3772832-4-arvind.yadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|DS4PPFAC42FDD50:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a9fe5d-bd58-4320-1286-08df34fbe406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|260925022911599003|260925021311599003|260925021911599003|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SwCQZsvWzyRtVyTxEXpcrUiHS1c4omdPqwsZEWDum9W35N/N+Bu8LJpgGPU7vCeatKARuHLDgXKEa4XUUuhq6k6CnoUk9YNFjytONtmgaw6jv0tcRwOACAiHZlChABbD/3M0jOCEOkSV46aLFRZgoJ3lp7cJwSO5VBBMDOvoikQvdfu7NFJa3gAfEeZKasXOqJ4SvcuM6t+rwDv7TbVA4HVnIVW63CGVxSPePtcZyUN546xErK+Ge0SgcVeB5n/eGzN1luF2d8pDyH+opf5nEzIYwTUFnuGusfnxVKXAFUyWezFV2/KT4RXKbVKSCnTq9L2EKbpXslu+PsjIrBk/S71xLDe239JwoQ7vB2Gc+hT9UxAzxBOvcfxr9v3pUhb114IyCm072wC9tw8yO2t8RlkOr7lgMR0u/2lQLM3/ZiVOVi9pGLJIGKMOuaMUXPOZzRPFGWpiBTYjkaP+hTR/0f3yPhU3uAcajh8fB9HzXtcg5trltauq0J1bbW/+GyKuviS9quqAprA7w/vfzbuARtf6P8BvOZ2+rrJeR1DGAgXyMO8/cGHjHxLP49NPHGvwwBF3YYKP4VGVWfG5MXx4QUqZEe83mA5KpL01CLyHXdbJQM85ntDBkAjYJ0FAsjqhBLCjVOrkm9PEhybDa8/UE7EpyqqlM4NO3InZkDd46cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBmZlNaaWsxK3dxVlV5NGxRcXU1VG5yRWFxUzY3MlF5RkExQmJTQnhXTnNh?=
 =?utf-8?B?UkVTeXB1dkFaNHpIWGtibTJXcVBmZ2RRczdhV1BDZk5wS0lldE1Da0pzWmQ1?=
 =?utf-8?B?dWVPdlVlanF6OWFOMXFuNkVjWnpIWWExTyt3a21JME1kelAwbVUvbklSaDNC?=
 =?utf-8?B?blpib01nVU1GbUtsNXJoaTRGa2p1MkZhU3JQcE4ralIyLzBsUnpqK04rQnFD?=
 =?utf-8?B?WUZFNEI5MFhMeHp6ajI1NzBONkxINm4rblFudHkxWlpGUUl5MllBSGJ0aHJR?=
 =?utf-8?B?WTA4VE12cmVFZ2s5UHhWd3N1ZzRjVUlmZ0NvZlJDTFNaa1FGTDNMTmdSVnlq?=
 =?utf-8?B?MDQ2SDFUdlRvckNGcnR5a1lFa1RIVE5KS1RsaXdLbGZMMmgrSmFFR0Z5WFYz?=
 =?utf-8?B?VWEra1RHWVg1S3NBYW5vTVo4UDd3SFVDNnJJWFVkTEZzVGNTNFRUdkMyNnQv?=
 =?utf-8?B?M2xLVmNUU3ZOV2k2OW9xUXlkNDN4VTl3VFBpbHRsSHBKbDEvMEdZcUxUMkNw?=
 =?utf-8?B?Mko2OEttZVlIcjRMRlhWdVZmQmJhNmp6ZUE0Q2pOMWE2ek5XRzI4bDQ1eHZ1?=
 =?utf-8?B?R1BuQW1SOFpBc04wRFh4bU9VQ2VpQVpzdjRjY1FBaGkra3Brc0xHMTZpUHZK?=
 =?utf-8?B?VjZNWVRuMWp5MHMxOVNHOWNaWXd0Z2NlcEVPaTlRTXNxN0djWjhhRlZXNnhG?=
 =?utf-8?B?UWg0UnhIUUl1dFJJRjJEWFhmV21aVzdVY3BkbC9pTk1hcGoxRFM5WFZhajdO?=
 =?utf-8?B?cDR6UDVhMUtPaGZPZ0VJSkVzaU5XNDZFNGlCWVRkYnJHTUpIclp2Nzk0Z1ZI?=
 =?utf-8?B?K2dGdmlvVitlRjUzdG5EenlkeWVmRUl4ZFE1SEc3UDhYcTRvaVFCNC9zVGtM?=
 =?utf-8?B?Smx1K2ZLMERBMHlhckd4ZUN1d1IyVmFXRHlSTnZzdE1yRUZ3Q0tsWU1zU0Ez?=
 =?utf-8?B?ZmtJVmZyVVA4cWZFSGVuLzc3MndUSXNvM2dPQTJDbWkrR1h5N21HR3ZPMXlk?=
 =?utf-8?B?RmNITnNITDRLSU5IMTRyY1BPenh5RHBHL2hMMHB4M3ZuRmJtYTEzTTJTY0Nj?=
 =?utf-8?B?b0lqU1lWRkRpdjJUYTR3c0lXWmVpWXZWU1RvcWxlNWFRaWZTdkZHaVZ3STQ4?=
 =?utf-8?B?YWtwdE91T2RITHg1dWtPcnhjTzJlY1Y2aTNxT1F5c3Nwak1pa215bk5xRy95?=
 =?utf-8?B?V2EvVnBSbEI5V2E1QkYzb1dOYW9CSDFoNFUyRkVkVG5UZFNBS0RlUS93Mk1v?=
 =?utf-8?B?QnQrRlh3RVlHTkRGTHNSNi9WN25UU1R5WFQ1aVVFY0pBVC9TaHl0NVl3L3Zj?=
 =?utf-8?B?ZlllOW1HSG5FZXB1K3dZNlRESThhT2JxWjN2OXBZZHdlVEZHMHR5WW9oYWRU?=
 =?utf-8?B?NTFtZDhyand6V3hYUllJNUZqc0xWQVhxQmlMaVNpZGRqK3dqcmptbm9NZkFp?=
 =?utf-8?B?Q2JOUHRCSE5vV0FyU0lITWs0enFDTGRTZGtlZTdFV294Q3hTeGtXV3FDZHhD?=
 =?utf-8?B?NGdQSUhYWDVVZUY3NlMwZnZNMHF0b1hTVUthdHVGV3lIVDdHSk5Ldy85NDgx?=
 =?utf-8?B?SHI2ZFRjWi8xZ1lVWW96cER1OVJSZ1FjTFJHUlR5TXNITWFZU1NNNnUwQlFZ?=
 =?utf-8?B?VE1kdFZ2UUNoaXVRRE9tTUJ4dG9OSUtJR3IwTlV3UU02Z3pLV2R3S3MwUnFn?=
 =?utf-8?B?eHUwMEFJcG9RRW81YVFiNFEvcnlVKzdORTE4Tmwya1ZWem5rUStzeVVZT3c1?=
 =?utf-8?B?U1BFcm90S0RBSXlGT3BNVjJJNWpYeHFCWGcweDl1N3E4bTMwZ0Y2Wk9WYVZC?=
 =?utf-8?B?elpXV1Z6eEtvdE94RDlHVUI4a0FCb2tPR21CaTFyQUJDbEFkQ3ErSU9SMzFS?=
 =?utf-8?B?MC9PZFRCTTdSZTA4bDU4REwrZ3NwaVZva0hPRzlBR2R4VlJZWWg0MmdYTHlE?=
 =?utf-8?B?c285cnJIbzFmN1lxMjBhYXc4RW5ZTkpHMmRQVGNHTFVNWXRmTGpsS0lYMmNu?=
 =?utf-8?B?MXprTmRSZGVQbXg1bDdnaHVYbnhRNXVRcUM5LzU2Kyszck84MnVPdit4QlA3?=
 =?utf-8?B?TkZSWXRnRi9pdzExTHNicEhycHdZcE9tOGJkblJzMW1YZXpjWnIwQUNJUGta?=
 =?utf-8?B?WFRIa2l5M2xaejRYemI2cFhWa2xsS09MNFJXS1ZwT01wcXZpMFgvd2FvN3NZ?=
 =?utf-8?B?OXJQZ01FUUNXTWozVEQvRlB5ZGZOaC9Cd2wveWxsd3krNlowVXppaUlKNnhV?=
 =?utf-8?B?ZGpmZ1VGR3Yya2E3SThnODhoQjVabGVibmd6U2lHZ3pCMFVUVnlmdUZMQU1l?=
 =?utf-8?B?T0xyZGUwTmU1K05acWplNW5GR3B0Q1E5RXR6akFjeEowd0J4TndOUERNSlhz?=
 =?utf-8?Q?qW83gg/f55qdIHg0=3D?=
X-Exchange-RoutingPolicyChecked: Oq0yOb4YTg/8/dUykhzhwDFNXjGBndj/b7GHYKdxhsxaQhzArrsIUV2Y5L20mwvi1CsohFOh+mihA0MQ95Rxj9TpPzvtpT4xILfQX/C/2hZnevKwSwqLRAGmCRwd95nwH1kxuUsBAvB90jrgiqHPqTWteEBOHNH8prS9EtHlLaXDbNM7NtG9WxME0Py9kNdT+OCF9H1PG9b1mFwk9q22DDZ6WPtibCugUlm1701J9SzuX7AP/Ok6H5VxTiKOM3P0HSMAOZHHUnUN4JJO4deSNGL/QMRW1iFN+MBkPlhCei15Y9+ERbpk9qDR9ZwmAu1U3+lRjp9C3eNG9Dxmi7Euyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a9fe5d-bd58-4320-1286-08df34fbe406
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:00:57.7988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjFz60UkJriARmXv43upsHDpGVFusrs0OcMdLjTNkLIvZxWIFB7LAID4thvAx7/qX2lgxq3k0OoSNjPYjU7P6bq4uzRqO26VNh9QlfZh0vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
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


On 28-10-2026 17:51, Arvind Yadav wrote:
> Queue cleanup is asynchronous. New VM work can therefore race with file
> close or VM destroy while cleanup is starting.
>
> Add a closing state and set it before starting queue cleanup. Treat a
> closing VM as unavailable for new exec, bind, rebind and page-fault work.
>
> Keep vm->size valid while the VM is closing so SVM invalidation can still
> drain existing mappings.
>
> Also reject page faults on banned VMs, which cannot resume execution.
>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: LLM
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Tested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device.c    |  4 ++++
>   drivers/gpu/drm/xe/xe_pagefault.c |  2 +-
>   drivers/gpu/drm/xe/xe_svm.c       |  3 ++-
>   drivers/gpu/drm/xe/xe_vm.c        | 18 +++++++++++++++++-
>   drivers/gpu/drm/xe/xe_vm.h        |  9 ++++++++-
>   drivers/gpu/drm/xe/xe_vm_types.h  |  1 +
>   6 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index d3bb42e4d0d7..7b4913d7665d 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -181,6 +181,10 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
>   
>   	guard(xe_pm_runtime)(xe);
>   
> +	/* Block new VM work before starting asynchronous queue teardown. */
> +	xa_for_each(&xef->vm.xa, idx, vm)
> +		xe_vm_close_start(vm);
> +
>   	/*
>   	 * No need for exec_queue.lock here as there is no contention for it
>   	 * when FD is closing as IOCTLs presumably can't be modifying the
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 5247321c805e..e1363bfbfbd9 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -291,7 +291,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>   
>   	down_read(&vm->lock);
>   
> -	if (xe_vm_is_closed(vm)) {
> +	if (xe_vm_is_closed_or_banned(vm)) {
>   		err = -ENOENT;
>   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VM_CLOSED);
>   		goto unlock_vm;
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 909a602d091e..3b71d9636296 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -219,7 +219,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
>   
>   	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
>   			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
> -	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
> +	if (!xe_vm_is_closed(vm) && !xe_vm_is_closing(vm) &&
> +	    mmu_range->event == MMU_NOTIFY_UNMAP)
>   		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
>   						   mmu_range);
>   }
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index a1a4eaf3165f..6e548fd8a809 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1975,6 +1975,20 @@ static void xe_vm_close(struct xe_vm *vm)
>   		drm_dev_exit(idx);
>   }
>   
> +void xe_vm_close_start(struct xe_vm *vm)
> +{
> +	down_write(&vm->lock);
> +	if (xe_vm_in_fault_mode(vm))
> +		xe_svm_notifier_lock(vm);
> +
> +	/* Keep size valid so SVM invalidation still performs its full drain. */
> +	vm->flags |= XE_VM_FLAG_CLOSING;
> +
> +	if (xe_vm_in_fault_mode(vm))
> +		xe_svm_notifier_unlock(vm);
> +	up_write(&vm->lock);
> +}
> +
>   void xe_vm_close_and_put(struct xe_vm *vm)
>   {
>   	LIST_HEAD(contested);
> @@ -2268,8 +2282,10 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
>   		xa_erase(&xef->vm.xa, args->vm_id);
>   	mutex_unlock(&xef->vm.lock);
>   
> -	if (!err)
> +	if (!err) {
> +		xe_vm_close_start(vm);
>   		xe_vm_close_and_put(vm);
> +	}
>   
>   	return err;
>   }
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index 351d08b3b378..a8b33cb2b559 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -59,6 +59,11 @@ static inline bool xe_vm_is_closed(struct xe_vm *vm)
>   	return !vm->size;
>   }
>   
> +static inline bool xe_vm_is_closing(struct xe_vm *vm)
> +{
> +	return vm->flags & XE_VM_FLAG_CLOSING;
> +}
> +
>   static inline bool xe_vm_is_banned(struct xe_vm *vm)
>   {
>   	return vm->flags & XE_VM_FLAG_BANNED;
> @@ -67,7 +72,8 @@ static inline bool xe_vm_is_banned(struct xe_vm *vm)
>   static inline bool xe_vm_is_closed_or_banned(struct xe_vm *vm)
>   {
>   	lockdep_assert_held(&vm->lock);
> -	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm);
> +	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm) ||
> +		xe_vm_is_closing(vm);
>   }
>   
>   struct xe_vma *
> @@ -214,6 +220,7 @@ int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
>   			     struct drm_file *file);
>   
>   void xe_vm_close_and_put(struct xe_vm *vm);
> +void xe_vm_close_start(struct xe_vm *vm);
>   
>   static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
>   {
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index fb9305124679..6ca9ef9d0c0b 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -286,6 +286,7 @@ struct xe_vm {
>   #define XE_VM_FLAG_SET_TILE_ID(tile)	FIELD_PREP(GENMASK(7, 6), (tile)->id)
>   #define XE_VM_FLAG_GSC			BIT(8)
>   #define XE_VM_FLAG_NO_VM_OVERCOMMIT     BIT(9)
> +#define XE_VM_FLAG_CLOSING		BIT(10)
>   	unsigned long flags;
>   
>   	/**
