Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD634C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4256310E335;
	Thu, 16 Jul 2026 09:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RykWmbhT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0DC10E335;
 Thu, 16 Jul 2026 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195896; x=1815731896;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1pCRsvuLYey+3oGj+x00R1J3Nk+vx27EqzNKOkrclww=;
 b=RykWmbhTg5j03KSXM4ZXRAPblhWJwikZffgh0wtk3SbbRoKHY7OmrX99
 6scrydjoTg2uX1AOYP+qAeO/OckpHJY+gvuViMhF9Sa3LXwv3un6kKdiC
 s0KlaCBlcRpmtrVvYwAR/t912o53z3yHqsf9ZMcfWOJQBq21bPQx/eP+I
 p2adCo+/lvw/TPbIYPsaRyZyQO+hHDPbpJaLEj20hfPtZNhR/tHEUMWnM
 9lBlfgzwS0iINzZGwqyVdYbYOD+1wUMwNJi53fgiP8RyAxTNdfE0KCe4C
 xDkjiZRsmLT/kzaynsm1tEljPCeTjuaMHSpoauEkw0QpWxuIxDcGpDDar g==;
X-CSE-ConnectionGUID: iTw9pqmcQFyetOvzmjfpcA==
X-CSE-MsgGUID: tsj1HapQS1SOLR6biaHvhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96215714"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="96215714"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:58:16 -0700
X-CSE-ConnectionGUID: 2EJmKU1nQu6jpZCpDPo9TQ==
X-CSE-MsgGUID: 2ARI0SHwQ6yzqbi+2WlFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="252029108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:58:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 02:58:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 02:58:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 02:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSoWlrzCVEBtlfKOqsncXv6LYHf9CW8YpzMEV4OTJhhWfE5NJXySdgLW5RDlZTqBvnImci7UQx123/8X1oab1XCMClR1Fx9bVN3/JHsvy8w8aCXbCCoemIAIF0dGucVhHUGyr7xD85g/uCPMkeCKoCpby04frb1S+51dRHpvZqy3MkjRn9+WquLLGUZePn3RfwYou4ZqAy/SQ30xO+ES7usvFyR0ZutvS1WPrZErpjAHMxFFkG7rBPeBC+NFgVTTrZG2HFEmx9irNAFWVg4yVY/0mkOGPACtp93mRSJtN1HvdH6t8DIWt9rywW7g/6wyi0mNX+0+eh6ps0xiUDVbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb3pC+iIO5JGABYOh5qvEfnviqHivWC3NLkzbKC4zGI=;
 b=BbQfn32nleg2GdSUwdiHKxRHGI/QbAZ3B6yzbMLfe1RrgZqr45k2tPJ1Cjh4UxLLVfwWdY6P1gTuP1AWKJ51qMXIHfa1ameD7TXbwVpAWufBznHD6DkjFDPBmu3tjtxnVePuo0MBtAEu1tmW45D3mYhijwmXr1NqYUEGpj30u3kRC2we4hkalpcCPtsaKx8t31cf4MdnwO/ISWbrl7Rq6JgsKbM2ZrFAwXON2/5zybUL7KGSQhr85f1nfF/PIDmhp8l0OhpkJ0nar/HKUX94PPjxVoZXi5zwiBcTQfafocQ3QHCfGQCe3Bw6NCOqVy8yOZvqhXzXTrf5/cRMRju5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.11; Thu, 16 Jul 2026 09:58:11 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:58:11 +0000
Message-ID: <918f2fc4-2aec-43a4-b52a-028011aa91b4@intel.com>
Date: Thu, 16 Jul 2026 15:27:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <aravind.iddamsetty@linux.intel.com>,
 <anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <kuba@kernel.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-8-riana.tauro@intel.com>
 <ak9yEyDF_tlJe-Rx@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <ak9yEyDF_tlJe-Rx@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DM4PR11MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8ec468-4575-448a-db4b-08dee320bee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|3023799007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1teGZ8e9hhnZ5UenCjq6y1q5H1/w0Q7RefcH6bMHwdtTBP5tcN5/oQk7FAjrCsEfGAqDB6bGvFRuR/IPoTyfx3lbsZ4Gm/MNZ+YjXokiU8kF3LurkNkmMZHewiUa902OBIBAPTjNckeWaZn4olULdijje8woPnf516ZGALGRQFZqZIr7bX/d+Ej2vt1Hd2K9NDXW4SgAsBnIy5nTPQBjwlJHA3LCXf/uJGRquxhM3UsviCfj0ANSSIFimi3KQKcHx16l5hXztVWprHWxq1lvxnHL3ceigH7NrnYobjWimkJ/lBYl/RSC+vZOxpvAAAjAFUdiqfpMzsxVPVXY73Y9ySKTCLIUrR5RezFy5qHMJqtugoeMVjSklSoGE/k0NdJ4rna5B7I72SeIb2V/8HdW/idsHMswuWlbadq1EYGekLD28Jhebg3gziy/f6O7NSE5u9RXBag55dPdKjN06rbhETeeSqc1g9xQYVkSCuA2QyslCPI97rOIu6HgKTrD5k6nNuqIsWEsZbgSUEVCY3tbeQIN2infu03DcQDdPrnA44Rep0CAdCp8FUPnx6dXWfbQWQluPizmAwxHyeliN9kAs8zB3ZQlqvcL9q+8bk/6S9ID3TZi3CAccQwRP1J2WFSAf3R6BJlW0ZBW8I0r5+T6EXlR18iW5VYm7FFTHRnl/t0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1NGSDdST1FKMFo3UnVnem9kSVNBVnp6OUNkVElBN3Z5RVJYZU5ZUzRDTlhG?=
 =?utf-8?B?S2IxSFhrSEJuMjVtd2RUeWswY3Y5OFRkV05sZ2MyMTFzVGM2V3U5Si94eFl4?=
 =?utf-8?B?TDFQbEQ1OWhjSUtTcXlLbVp3cXowRVRRUjNMdUlrd3NvQXN3U1ZuM2JlY20w?=
 =?utf-8?B?VTNtQkduNGtCQ2p3OHh3T0I4bnFUV2NWK2RGYWFPN1FuenNVay8ydkk4VXNr?=
 =?utf-8?B?aVJVeTJORTV0NmRFNVRJS1lWSTh0ZmtFNXY0ZkFESEZhbHl3c2Z1bEUwQkRn?=
 =?utf-8?B?Tzk2MlNXODU5SkpaQzY2eXNVM2ExUGNOUTk0Z2VuNnlMVVZqc1hSaUIwMm5v?=
 =?utf-8?B?TkFTVlp6MktPOFhVNWJFa3oyL1EwaU1Iay91eGhzVXF5Y3lXeVF6YVEzL0Zo?=
 =?utf-8?B?UTJzRUs0T1lueExtRTdMZis5cGFPWEI2aHBwbTNoM29ZTysySU1qQjNWMmor?=
 =?utf-8?B?NzJVSkdDNU5IT0EwZEpCQTZIdzkrNlFvYnZocmlqMVBhWVlmQjFXWGc2a3hU?=
 =?utf-8?B?cXlLVEtJeDZZK1R5UEpyOCtkN0tudGIvM3VkZ2JsdXpMWENJdjlmdS81cWZH?=
 =?utf-8?B?T3dsd0luekNyL3hLSkcxT2Q2bUN1cUhsR2pKRHBEdVA5M3NEOFdHK3lYTWFI?=
 =?utf-8?B?ZHl0aTV4TVF3clZaUXJDOWw0Lzg3YXQ3UGszZTZFQktjcElJaElKQm1xSjlh?=
 =?utf-8?B?cGxReGZ5NklFSndDZFRqTlNxdVM1d1F5SU9SSVJqQ1pkQStGU3NqdjBVMXVH?=
 =?utf-8?B?UXI0T3ZsSUhlTDFBL3I5ZjZzSlVjWTNsK0dTbzRIQUk1bE9sbkp0bVB6QzFY?=
 =?utf-8?B?UU9nSWNXY1o3SS91aEd4VlBXdG1Mc2xwdXVLeEJEdVVla3ZrenhvRW5ZWHRG?=
 =?utf-8?B?Yll2RUdnVUpFVGF2bGErNkhDNkx0dUg3QTJRaXpJbzQ2TFlGZ09VcnBBeTdt?=
 =?utf-8?B?d3hNaXpwQ1hwNmgrM3B2Ni9hanVOMHJ0VkxKK3RNREwyYXNCRlkyNENpOENi?=
 =?utf-8?B?NXNBZ3AyQWxiaHlERUpiWXhpTnduRG9qeit2UFhyM0QvMzN3M0VHNS9yeGJq?=
 =?utf-8?B?YXBodjQ1WDNjUDM4aytINmU5cTY3NE90V3RPeG0yV3ZCT2Y1dUtIV0FwZFhV?=
 =?utf-8?B?L1IrMkR0S01LdWsxc2pBTStyL0JlL0NLZ2haUHpRbVpNUUtuZDErTTdkdjJn?=
 =?utf-8?B?a3JWaUhrbHVNUzRzUmhaZGlXZ3NRNGxNdXVVMU1SK3VxQ3FhYTdaazIxWTdU?=
 =?utf-8?B?bVhQMmVucEpOQ0VsOVZhYUJjY3ZzZGVLNkNLQkJIRXRGTnN3akhGWWR5R2hE?=
 =?utf-8?B?bHc4Z1dFeW5sM0NMMk1YM05zM0RuMzdtbUVwazFsajdCRXozVXhVb29SMisx?=
 =?utf-8?B?Qmd4c09SRlgxMEZHQ3hHdjdyLytkSkpZNlZhT2ExRlk5VTQzM0NvazF3cndw?=
 =?utf-8?B?WldNbDNFM05UeFZoN29NTW10VlJXYXpXR1dXam1zY0VGSG9WbjFrRkZnRzlH?=
 =?utf-8?B?dDg2T0F1a255Sy91U0xtL3dWTWZqKzlwVmpFZkFFajdSbEZGbU14Nm85STBS?=
 =?utf-8?B?cXh5Vi9TMjgwY2RQeEk0QkhOeFFZck5sM201blpaenNnQ0ozVHlFZWZ3R3N5?=
 =?utf-8?B?ek01MlpQa0JXemJlZEdSZDFSZFpudEQ1U1BMSTZDbnBaMUpDbkVPeGpvZVE4?=
 =?utf-8?B?c1RZdUs5clZLVkhIZFpON05pcklubFZhc3FvSWw1cVZBL1NxWGVlSDNnVFYr?=
 =?utf-8?B?WGw3UFh2dC9WV2FQd3FseTBFaE5lNEtBZ0VtSk1CWkxuV2Nnbk5sOGt2Q0w0?=
 =?utf-8?B?Y1JHVklHb3V0ZGRvbE12djE3bnpORHpYOTZmdmNrdHkzSjZsNTlqejFRT012?=
 =?utf-8?B?ZGJ1WkV6RkhqOW1hcDlESm5ET1ErSVJFbkhlYXhOUnMxc2p3M0xacHdmd01r?=
 =?utf-8?B?YTlDNTM4WDdKeWRpa3JSa1hRRXh1dWY2SjY4OGpEY1Y0WmF5dVU1OEEzNlpq?=
 =?utf-8?B?L2tUQnd2R20zYVVOUDZBSTZYckNSL1NyZWhPK0dvZVVyNFU1N2MxKzJiMUJW?=
 =?utf-8?B?SVQ2TnREdVNWbjBSamlTbEhpc1FVVkk0a0FXc2lhbWo2TGMwV0xaNzE5Q0Rn?=
 =?utf-8?B?YmRhRWFsd3MxWFIwR3JXbFVLLzZrejRKYnVMOWNZd0tTSTFvSFNnVkZIeGdq?=
 =?utf-8?B?MGs0WnBUek9vY0NySlN0aUtFd2FOVHZKQVVxSkZOQjBqVmZSKzZLV2ZzeWds?=
 =?utf-8?B?Wm9qQlYrVUo4T2JVYlVrRlNVQlUreGVZdFFwa0U0RmxXVVhzaERmV3FzWHJa?=
 =?utf-8?B?dFIwM3VnV2FObXBQQ1ljb3ZoTE9sMEtJR0FpbGczOFEyQ1ZpMnhZUT09?=
X-Exchange-RoutingPolicyChecked: bxnrQ/WpGK+xopMdP8nPg4LEKNiEYrbqO0R+u71q7o/Vo5bT97/zvf8Ml/nc2iMFN07VgKfs36uO22jnHiSayh/hyDIADnRhjwWtjQx+259Zy4QH3nAqrZKd6ojbdkZP7iGZN/GKy8zj1X/kS2Oy+tcv2xVtDek+wXD5drknAxPhFq/454hyy1l3bulK0e3C6Gz+asCveVI2SviATFpZAdCLTaBBNbk2pLlE9jIbYYcwyfhAD3PzdNcjZf8QgwtEcBRJAuDnCVC+uMLdfju+nc7CbEjY7wxI9EB7CPlinyTNzYP53aH80E1gZFxCur/gdoAl2K1fzogvpa34Xmvqiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8ec468-4575-448a-db4b-08dee320bee1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:58:11.5924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GUB6vd2MUAgFNvyc7KYOJ1Ej49fxSrdq0RARbgQ5SQsw/PTJli0qnBjf/AwblcXMlvK0sDqMPFzbjgp7yT9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
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


On 09-07-2026 15:34, Raag Jadav wrote:
> On Wed, Jul 01, 2026 at 03:14:13PM +0530, Riana Tauro wrote:
>> Add error-event support for Correctable errors in CRI. Report an error
>> event to userspace for every component that has crossed the threshold on
>> receiving an interrupt.
> ...
>
>> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
>> +{
>> +	u8 drm_severity, drm_component;
>> +	u32 value;
>> +	int ret;
>> +
>> +	drm_severity = xe_to_drm_ras_severity(severity);
>> +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
>> +		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);
> This is uapi and not coming from sysctrl, so the message is a bit
> misleading. But if at all it needs validation, it should be done in
> drm_ras layer.

You mean in the ras_event function?  The parameters to this function are 
coming from sysctrl.
So added sysctrl flag


>
>> +		return;
>> +	}
>> +
>> +	drm_component = xe_to_drm_ras_component(component);
>> +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
>> +		xe_warn(xe, "sysctrl: unexpected component %u\n", component);
> Ditto.
>
>> +		return;
>> +	}
>> +
>> +	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);
> No, instead of converting back and forth just do get_counter() using
> sysctrl values and send_event() afterwards.

The reason for using this is to avoid unnecessary churn of moving the 
get counter above or use forward declaration.
Yeah i can use that too directly.

>> +	if (ret)
>> +		return;
>> +
>> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
>> +}
>> +
>>   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>>   				      struct xe_sysctrl_event_response *response)
>>   {
>>   	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
>>   	struct xe_ras_error_class *errors = pending->counters;
>>   	u32 id, ncounters = pending->ncounters;
>> +	u8 sent = 0;
>>   
>>   	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
>> +	BUILD_BUG_ON(XE_RAS_COMP_MAX > (BITS_PER_BYTE * sizeof(sent)));
> I prefer it the other way around. Also, have you tried using BITS_PER_TYPE()?
>
> 	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX));

Will try this

>
>>   	xe_device_assert_mem_access(xe);
>>   
>>   	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
>> @@ -154,6 +211,24 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>>   
>>   		xe_warn(xe, "[RAS]: %s %s detected\n",
>>   			comp_to_str(component), sev_to_str(severity));
>> +
>> +		if (severity != XE_RAS_SEV_CORRECTABLE) {
>> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
>> +				severity);
> This should be before "detected" log above.

okay

>
>> +			continue;
>> +		}
>> +
>> +		if (component >= XE_RAS_COMP_MAX) {
>> +			xe_warn(xe, "sysctrl: unexpected component %u\n", component);
> Ditto. Also, use xx_to_str() in both cases or don't but be consistent.
>

It will only display not supported. Will remove the string in both.

Thanks
Riana

>
> Raag
>
>> +			continue;
>> +		}
>> +
>> +		/* Send event once per component */
>> +		if (sent & BIT(component))
>> +			continue;
>> +		sent |= BIT(component);
>> +
>> +		ras_send_error_event(xe, severity, component);
>>   	}
>>   }
>>   
>> -- 
>> 2.47.1
>>
