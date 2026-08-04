Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70883C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4FB10E0F5;
	Tue,  4 Aug 2026 04:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VW7zVkG5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199E110E0F5;
 Tue,  4 Aug 2026 04:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785818545; x=1817354545;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TcMIeWJuy7a8PMZ1MzzQxAIpgpYr0ozMk1pZZdkDE8c=;
 b=VW7zVkG52UTQRNFhnwWJjL8tlBva4O4lPYUCqRhR1M7aSx5zdQcJ4IN9
 IdGyXNOb+Y1gQwkwMukXMDUc5ft5ZTPiYXaNwMj38u01PxWSGRAyzBFf3
 4fTjR9EnADrtXV5VdKD/8W7G7ozjp2uEs9DzbfALWkdUM/avuZb2wAauk
 dnuZEu5OPO4JAqc6KNgQKTNhtZhJzW5Fa/rAi5TzCXVl+t6Fqm0qavhd8
 j+xT7AU5H9nkXEWzaAnyZ2HKXXTSF3cN/hnhv/43HDP8+mYpYFil31m8/
 PYcHa8oWYPbQTlWR81kxNLJgCsOHYcYeOmxHg/cXIkfYYrs3UKXwLsvwM g==;
X-CSE-ConnectionGUID: PLlxyHqSTCiU6xEpMmsQdw==
X-CSE-MsgGUID: CNTtnHq6Rm6EQFfm1p52gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97518315"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="97518315"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 21:42:25 -0700
X-CSE-ConnectionGUID: lHfiv1/TRES8KfJx+QFkVw==
X-CSE-MsgGUID: nJZ33VrjQVKbvUGpVgff/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="257075290"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 21:42:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 21:42:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 21:42:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 21:42:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI4InO+8fKmxLR+iq4OKbKBMjMcoNPMrwrAVt7Yazy4fSsSmJUu3bz5oVhgNpcZlcjzLNW+GEyYjkJaCYtj8K8r9g2r4+lpGm7myBzxLMdIAcNxHvNrSt+543fhb1IxlN94rQ/cH425hFafxS9vJbZQ4nopOMVfkQLvpzOglJTmmYKyFazmMBdSgHWl/mq55F3aEa5Vip0c3L0PdNEG5M0uR7WUnTfxcPQGFAbSBKo38Dlo2m32yf+481MZulb4g7zx2SG6C1Hrey8TRZQzUr+fu8uR34v+s8/xOcWHY9PF6FERBTomL8CPmTxN7JrONqYwZWHIhs1m3CpJT1KzU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnL+lmkipHOxt+N53D46WT2LqvkCgrZsu882OOgyvvw=;
 b=VEzK6eJ0Wx50ig4EkkfHYDG1pUbhZm+GLOwi1m7dHgpTT463bXQaLhVoe1ZUyuHc6LE7bF5sfIYtyMWhjqi/dt+1j37W/GnNlWiiMBWCQPXqGZXa8xUaJnJNyiVyzXjStKu+ovjDj4fB9SpwpqwohgEri1pBhQiw6AXd6UBwiEdN2b+NrPDgeDqBqX+g6GtLt0wIIhE1szvOEyIhNaAQWC44q6ktnw1x2MFa8GvXW82OIZEOOrpDfssg6/Uikd3m+Jxr3qL6rMEKt+E9ce3Ipxj6zozby8jreQhS+LdepES/2UECKoFLSLrg5othqlSNWPYU+viXXHogje6NGdrJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 04:42:20 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 04:42:19 +0000
Message-ID: <c770a90a-a6e3-4a8e-bf40-541f8c1e6512@intel.com>
Date: Tue, 4 Aug 2026 10:12:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/pagemap: Prevent double migration of device pages
To: Matthew Brost <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
References: <20260803092553.4117408-1-arvind.yadav@intel.com>
 <anDT86fV1Xbq6fkc@gsse-cloud1.jf.intel.com>
 <anDV8wqPd8G8rIW/@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <anDV8wqPd8G8rIW/@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::10) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dac7bc6-860e-4dd0-7154-08def1e2c46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: g9HWaepoYX7zHvN2CmmtGKcAWIVw1+KIidUhsudUzEvtwHOZF40ky3JAWxaHTg/WFkbWYTwre9mmiRk3iu8dQJy673uQgo+8eYh6ZNEdhn5/bmESw3LYZKQMb4RZjUzBhTuuZhQpj0FI9nCtIIHvZbbirZv54yphyst+WcxqYikdh6w7K+3S9tBU5eoZfSmpat6ofsOs5TZ+hoqqBHEgT1qMVk/gmKOJID2vXRzCvqtM4p4QE9zCMcVdaZo48O+urF2umX94BWgJooIMgzKgp/JvveKT+zZsaIx2lUBsrKkYiGOA3MxYIVrw7RXXYhavwpNtm2FNRufFoNWlVm91uddy+wdcn7ri6Mivx3GchAhGI4ybpzI6hJBX8Cj7EocpG+ET8x9JSoaD3ql3tLw3/07iaFZCVmhFPbvM75IaHPeODMiN9OKrpP0wZQTiwvGIHGhu2R6KIoIPuiLKWMdksM7ZkZ2y5Ts0bcTqmUTP0q6x14DDORCFxfF7WSKHnjOjXaubvBFeqwU+AXNPIrUgY2jZh54ZbYCPGmGs4RArw5P8N/H6sooqfq74UNXcLVibQx6umZ0zyjtE6WkJP7p2KEGF0DUrI5yrwe49ZOBTyBlA28+NpXCqbQmiW+ObK/zjcQhLxxeUOy0RyDKzZdVmSQ7aTOHomaVH+1swvK7A0FQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGovdDMyTlFLZlhNU0NSd09Zd0dkeHhiRFB0cVA3ZG55ckhhNWNkNEFONmxi?=
 =?utf-8?B?TmZyMDVMUm1VMG5BdnI4Zk1VUVZXdHNoeVh3TW9Za3ZJSnNqYkF2VC9tK01j?=
 =?utf-8?B?NGsrVnZKYTVpckhheDlBUDlBajM2d21mcE1XMllXRjNreVpTZlA3OXRreGE3?=
 =?utf-8?B?MXV1QzZHT2FuUllFSjRibE1heGlrSXZUY0xpSXRnMG96eHlScld5YkpNaFFi?=
 =?utf-8?B?cnV6RUI4NDRMeHA1Yk0yZWhLV0p5ZFhqUGNXR3IwcmZsNnlEejVXSHpucHV6?=
 =?utf-8?B?K1lhbDRuaXhZdVh2S1VJNjVYOHpOamkyNDFVNWwvMGMwS1o0R3Z5N0x1d0F3?=
 =?utf-8?B?WTU4eW5SYThpSFZOMG1La3I3V25xNE1BcmZqSmZpaUZhVDh1OUsrbkRxbHhx?=
 =?utf-8?B?N1dIMER6MmlXUTdWdlNXYUFxVU5yRVBaZ2ZvNXc4U0NiNVQxVENDQ0Fadndu?=
 =?utf-8?B?OGhlSXZkTStla21BUW5iZTBsUmsydlRLSFMyTjRkK1MzTjRrWitlOURsaE5W?=
 =?utf-8?B?Znpka0V0TUxCOGk2c01PTkwrSEt4bHJSbEZ5THJTeGQ2ZExya2hCTVpacVBQ?=
 =?utf-8?B?bmpRQ01HZkJmOEZ1MlZieU5hQnBWTDZlcUNtUkNuaEdIR2xuU3pGdjJKSlBp?=
 =?utf-8?B?ZEhRaVdTK2lsckpqeDRzMDlUZTB6djVVNTQxcDhMSjFwZFZHMzI2RW9DcGdR?=
 =?utf-8?B?bFNMc250bW4zTEl4blVtcTdmaGI2ZURvTXBWT3NidVNPZ2VmZkJkdk1NN1ZJ?=
 =?utf-8?B?dFlteFhNTWNwTzROYS9VTG41VWxkcGVqeXd2ekM4ejNvb09oN0FhT0V6N0JH?=
 =?utf-8?B?M09rZHVFZmVtd1FCdWJIOVNQTm5tOWxTaktvR3NsOVMvOGk1VVBtWW1JZGw3?=
 =?utf-8?B?MDY0RjNNUk03ZE1WSkI5SVI0bTIwKzBadUl2NW1rWVkwU0UwWGZQckRrdXU2?=
 =?utf-8?B?ejNyUFBNWHJoeVE2OFhBK09VN1B1SW9ibk1CZVorRDdDMHIzNDBiSnR4ZWUv?=
 =?utf-8?B?eUJMZVJYRmFSWElCVHJybWVaSEFwV1EwdkVKT25YcHJYQXBmQit2eU5NTkFk?=
 =?utf-8?B?MFMzL3gwMjRwckJBeE1MNHIwUW5NbldXcis4T2tzRWxwRkVWMUs5NFYwZlJY?=
 =?utf-8?B?WDVpLzBoV3BONmRHOVh2eEY5allyTUdEYmtoL3UxTnJNcTYydmhtL1dJZHBq?=
 =?utf-8?B?K3JOOTlSNURrekpaSlBSTUNYdVp1SG5LNXRkanpTV3lNUm85VG1zR2o2bTMv?=
 =?utf-8?B?YVl0d25qUUVuNFRONkVsWU1pZFZ6TTBsSTJGZTBqZnJxcGFrK2p0S2RFZVJP?=
 =?utf-8?B?dCtFYXN3ZzVZRTNyZUc2WHVZOXRXNDdWdHdnM2RXNHc0WWJuSjYvbHZaVmxN?=
 =?utf-8?B?NWJ6aW16VFFnUE1YQ2h0Lys0VnlDdDlURXUzNG1VR0ttbXQ1amp1WkQ2cXNo?=
 =?utf-8?B?M0tQV2FzdW9vKzd2Y3dUNFpyVElzbUs5RExHYkZVYXJnOVhNeTRLUG0yTmRq?=
 =?utf-8?B?NFV6aTdpd3d3bk93SjducUkxdzV0czRQSWM1ckRyazdRekFadmZyTmc3MjFy?=
 =?utf-8?B?c29tSGJ1SloyS0RPcTFSSElpRWtKQkVkSW9hbGpaUmNKbXNBMm5xNUpYTXBx?=
 =?utf-8?B?d0QvMlBDdy9KVUUrN1JHWWFpYUZlQ1YrUEo2emVFOHJjbXJBNmRra3JaeE53?=
 =?utf-8?B?UXZIMHUydjVlOUdSZDE1VTZGeEpVSGl3N3UxSHZ2Z3FSdHA0SERtWUR0NFo0?=
 =?utf-8?B?dGhRaVNmUE16Y2Nvc0NVeDhvWWxLQndUSEZ6K3pIaEZMUzNyWnZvY0pybUNJ?=
 =?utf-8?B?bGJqbGFJQ0NOUmxKN0s2d24rMTZSK0FaR0Q4MUJIQjIwRVNyWURjVUh0cXU1?=
 =?utf-8?B?Vnk5azVKN09MS2lST2dnZTJPOTRmYTEwaU5YRW5iaWNvR2FVb2hmMUYwRlJC?=
 =?utf-8?B?WUd2Y3pRQ2ZhMk9WdW5DL3REek9GRUkwV2JyVVhVeEh2bHkrV0NHMDBXTXNF?=
 =?utf-8?B?bUVCOVZ1NlRZUE1PQ2lpMExidzg5T3BzVmRDeWNsNXhiOVkyZUZHVkR3TnJq?=
 =?utf-8?B?UmRQWkc0R21JeFFaM1F6djNOd1VYZmw4eFpIaEU0NXA3UFRwcmZiamNlWVd3?=
 =?utf-8?B?MC84U3JvbWFJK0pFQm1GZSs5YnlpVnltZ0dISnhzdnByWWYrNGp0aUxmMlNx?=
 =?utf-8?B?azE3WTA3VnFXWW9sb1A4YTM5TVRFMGtTT29pKzdCMGc0OGlpOVVOQnFkU1FI?=
 =?utf-8?B?RmoxdHdQWExzUGYwRkZzdXRHRTlNZ3U3NWlIYVFFMjVXQVkwUVB4WGhmY1BH?=
 =?utf-8?B?dDcwdjMwWC9DaE11Zk4rS3R5dTl5RFRGRVFtLzZaQkNSVWExNk4zUT09?=
X-Exchange-RoutingPolicyChecked: c6Uooz+mkbFFOHtjNaLxyfKczMkAP28MzgwpN0j/PuERWI9K9lUP2vEsYZOi/7/rV1PSt2MVSC1IJ17I9aYy+8Rps+YCLO86rPgkDJnlvLhmLuJVHUpj6C4S0+exkUFtO7xJ/S6kbn+xmJjvshtD7knWvqiDu5b09j9nVXfpXNZkh+xf0ur0VQB2ISTAC7BWS/9cMLLV0Au2E/hiTUiHUDxSFXGcFcwNKK2i3frB14YGQiRt9GhLzbeh2GfZO0OmEKo7k+1Mxs+xBS4ECYDu5hbTO6Yf0f4awqFm1VcwrwQeEsNupe+D6HSQ8GlKKW6HX/0AZE5REOGw6u4qn2eC6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dac7bc6-860e-4dd0-7154-08def1e2c46e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 04:42:19.7584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1e7X3cvfq9fVRelxD5FgC3ZCbWKI6f3hMqDd9Ioi+APBA5yOXfOyhpQzFPN7y1RHdallDoFvuIKq6+qsrB2hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
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


On 03-08-2026 23:24, Matthew Brost wrote:
> On Mon, Aug 03, 2026 at 10:46:27AM -0700, Matthew Brost wrote:
>> On Mon, Aug 03, 2026 at 02:55:53PM +0530, Arvind Yadav wrote:
>>> A device page migrated to system memory by a CPU fault can remain
>>> referenced for a short time after migration completes. During this
>>> window, the raw-PFN eviction path can select the same device PFN and
>>> migrate it again.
>>>
>> So is the race a CPU immediately followed by an evict?


Yes. The CPU-fault migration completes first, then eviction selects the 
same device folio before its remaining reference is dropped.

>>
>>> The first migration has already moved the memcg charge away from the
>>> source folio. Migrating that source again can create an uncharged system
>>> folio. Adding such a folio to the LRU can spin indefinitely in
>>> folio_lruvec_lock_irqsave(), resulting in a soft lockup and an RCU stall.
>>>
>> Do you have stack trace of this lockup? It would be good include that in
>> this commit message.


Yes, I have the trace. I will add in next version.

>>
>>> Track successfully migrated device PFNs in drm_pagemap_zdd for the
>>> lifetime of the device-mapping generation.
>>>
>>> Record successful migrations in both the CPU-fault and raw-PFN eviction
>>> paths.
>>>
>>> Make raw-PFN eviction skip retired PFNs, preventing an already migrated
>>> device page from being handed to the migration path a second time.
>>>
>>> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Cc: Maxime Ripard <mripard@kernel.org>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Assisted-by: Claude:claude-opus-4-8
>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>>> ---
>>>   drivers/gpu/drm/drm_pagemap.c | 188 +++++++++++++++++++++++++++++++++-
>>>   1 file changed, 186 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
>>> index 7a056592ac66..f7040fc0dea6 100644
>>> --- a/drivers/gpu/drm/drm_pagemap.c
>>> +++ b/drivers/gpu/drm/drm_pagemap.c
>>> @@ -7,6 +7,7 @@
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/migrate.h>
>>>   #include <linux/pagemap.h>
>>> +#include <linux/xarray.h>
>>>   #include <drm/drm_drv.h>
>>>   #include <drm/drm_pagemap.h>
>>>   #include <drm/drm_pagemap_util.h>
>>> @@ -66,6 +67,8 @@
>>>    * @refcount: Reference count for the zdd
>>>    * @devmem_allocation: device memory allocation
>>>    * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
>>> + * @retired: Device PFNs already migrated to RAM. Entries remain until this
>>> + * mapping generation is destroyed.
>>>    *
>>>    * This structure serves as a generic wrapper installed in
>>>    * page->zone_device_data. It provides infrastructure for looking up a device
>>> @@ -78,6 +81,7 @@ struct drm_pagemap_zdd {
>>>   	struct kref refcount;
>>>   	struct drm_pagemap_devmem *devmem_allocation;
>>>   	struct drm_pagemap *dpagemap;
>>> +	struct xarray retired;
>> I don't think an xarray is the right data structure here, given that
>> load/store operations are slower than direct memory loads and stores.
>>
>> The CPU fault path is about as critical a code path as we can get, so I
>> think it needs to be highly optimized.
>>
>> I believe a bitmap [1] is the right data structure.
>>
>> include/linux/bitmap.h
>>
>> I'd suggest using an embedded bitmap here, sized based on the ZDD size.
>>
>> For example:
>>
>> /* last member */
>> unsigned long retire_map[];
>>   
>> Show more lines
>> 4K, 64K -> length 1
>> 2M -> length 8
>>
>> Lastly, the only bits that are ever checked are those corresponding to
>> the folio order. For example, if the folio order is 9, only bit 0 is set
>> and checked, and the check loop increments based on the folio order.


Agreed. I will replace the XArray with an embedded bitmap sized for the 
ZDD allocation and remove the reservation helpers.

>>>   };
>>>   
>>>   /**
>>> @@ -101,6 +105,7 @@ drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
>>>   	kref_init(&zdd->refcount);
>>>   	zdd->devmem_allocation = NULL;
>>>   	zdd->dpagemap = drm_pagemap_get(dpagemap);
>>> +	xa_init(&zdd->retired);
>>>   
>>>   	return zdd;
>>>   }
>>> @@ -137,6 +142,7 @@ static void drm_pagemap_zdd_destroy(struct kref *ref)
>>>   		if (devmem->ops->devmem_release)
>>>   			devmem->ops->devmem_release(devmem);
>>>   	}
>>> +	xa_destroy(&zdd->retired);
>>>   	kfree(zdd);
>>>   	drm_pagemap_put(dpagemap);
>>>   }
>>> @@ -1102,12 +1108,169 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>>>   }
>>>   EXPORT_SYMBOL(drm_pagemap_put);
>>>   
>>> +/**
>>> + * drm_pagemap_is_devmem_page() - Is @page a drm_pagemap device page
>>> + * @page: The page to test
>>> + *
>>> + * Return: true for device-private or device-coherent pages, which carry a
>>> + * struct drm_pagemap_zdd in their zone_device_data.
>>> + */
>>> +static bool drm_pagemap_is_devmem_page(const struct page *page)
>>> +{
>>> +	return is_device_private_page(page) || is_device_coherent_page(page);
>>> +}
>>> +
>>> +static void
>>> +drm_pagemap_release_retired_reservations(unsigned long *src_pfns,
>>> +					 unsigned long npages)
>>> +{
>> This function won't be needed with above.


Noted,

>>
>>> +	unsigned long i = 0;
>>> +
>>> +	while (i < npages) {
>>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>>> +		struct drm_pagemap_zdd *zdd;
>>> +		struct folio *folio;
>>> +		unsigned long pfn, nr, j;
>>> +
>>> +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
>>> +		    !drm_pagemap_is_devmem_page(page)) {
>>> +			i++;
>>> +			continue;
>>> +		}
>>> +
>>> +		folio = page_folio(page);
>>> +		zdd = drm_pagemap_page_zone_device_data(page);
>>> +		pfn = folio_pfn(folio);
>>> +		nr = folio_nr_pages(folio);
>>> +
>>> +		for (j = 0; j < nr; j++)
>>> +			xa_release(&zdd->retired, pfn + j);
>>> +
>>> +		i += nr;
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * drm_pagemap_reserve_retired_pages() - Pre-reserve retirement slots
>>> + * @src_pfns: migrate_vma source array after migrate_vma_setup()
>>> + * @npages: number of entries in @src_pfns
>>> + *
>>> + * Reserve every base PFN because migration may split a large source
>>> + * folio. Recording the result must not allocate.
>>> + */
>>> +static int drm_pagemap_reserve_retired_pages(unsigned long *src_pfns,
>>> +					     unsigned long npages)
>> This function won't be needed.


Noted,

>>
>>> +{
>> This function will look something like:
>>
>> 	unsigned long i = 0;
>> 	int err;
>>
>> 	while (i < npages) {
>> 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>> 		struct folio *folio;
>> 		struct drm_pagemap_zdd *zdd;
>> 		unsigned long pfn, nr;
>>
>> 		if (!page || !drm_pagemap_is_devmem_page(page))
>> 			continue;
>>
>> 		folio = page_folio(page);
>> 		nr = folio_nr_pages(folio);
>>
>> 		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
>> 			i += nr;
>> 			continue;
>> 		}
>>
>> 		zdd = drm_pagemap_page_zone_device_data(page);
>> 		bitmap_set(zdd->retire_map, i, 1);
>> 		i += nr;
>> 	}
>>
>> 	return 0;
> ^^^
>
> Opps, copy paste error. This function isn't needed and the above snippet
> is for the function below (include there in previous reply).


Noted,

>
>>> +	unsigned long i = 0;
>>> +	int err;
>>> +
>>> +	while (i < npages) {
>>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>>> +		struct drm_pagemap_zdd *zdd;
>>> +		unsigned long pfn, nr, k;
>>> +
>>> +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
>>> +		    !drm_pagemap_is_devmem_page(page)) {
>>> +			i++;
>>> +			continue;
>>> +		}
>>> +
>>> +		zdd = drm_pagemap_page_zone_device_data(page);
>>> +		pfn = folio_pfn(page_folio(page));
>>> +		nr = folio_nr_pages(page_folio(page));
>>> +
>>> +		for (k = 0; k < nr; k++) {
>>> +			err = xa_reserve(&zdd->retired, pfn + k, GFP_KERNEL);
>>> +			if (err) {
>>> +				drm_pagemap_release_retired_reservations(src_pfns,
>>> +									 npages);
>>> +				return err;
>>> +			}
>>> +		}
>>> +
>>> +		i += nr;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * drm_pagemap_retire_migrated_pages() - Retire CPU-migrated device PFNs
>>> + * @src_pfns: migrate_vma source array, valid after migrate_vma_pages()
>>> + * @npages: number of entries in @src_pfns
>>> + *
>>> + * Record successful migrations before finalize unlocks the sources.
>>> + * Release reservations for pages that were not migrated.
>>> + */
>>> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
>>> +					      unsigned long npages)
>>> +{
>>> +	unsigned long i = 0;
>>> +
>>
>> This function will look something like:
>>
>> 	unsigned long i = 0;
>> 	int err;
>>
>> 	while (i < npages) {
>> 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>> 		struct folio *folio;
>> 		struct drm_pagemap_zdd *zdd;
>> 		unsigned long pfn, nr;
>>
>> 		if (!page || !drm_pagemap_is_devmem_page(page))
>> 			continue;
>>
>> 		folio = page_folio(page);
>> 		nr = folio_nr_pages(folio);
>>
>> 		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
>> 			i += nr;
>> 			continue;
>> 		}
>>
>> 		zdd = drm_pagemap_page_zone_device_data(page);
>> 		WARN_ON_ONCE(__test_and_set_bit(i, zdd->retire_map));		
>> 		i += nr;
>> 	}
>>
>> 	return 0;
>>
>>
>>
>>> +	while (i < npages) {
>>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>>> +		struct drm_pagemap_zdd *zdd;
>>> +		unsigned long pfn, nr, k;
>>> +		bool migrated;
>>> +
>>> +		if (!page || !drm_pagemap_is_devmem_page(page)) {
>>> +			i++;
>>> +			continue;
>>> +		}
>>> +
>>> +		zdd = drm_pagemap_page_zone_device_data(page);
>>> +		pfn = folio_pfn(page_folio(page));
>>> +		nr = folio_nr_pages(page_folio(page));
>>> +		migrated = src_pfns[i] & MIGRATE_PFN_MIGRATE;
>>> +
>>> +		/* Keep later folio splits covered. */
>>> +		for (k = 0; k < nr; k++) {
>>> +			if (migrated)
>>> +				WARN_ON_ONCE(xa_err(xa_store(&zdd->retired,
>>> +							     pfn + k,
>>> +							     xa_mk_value(1),
>>> +							     GFP_NOWAIT)));
>>> +			else
>>> +				xa_release(&zdd->retired, pfn + k);
>>> +		}
>>> +
>>> +		i += nr;
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
>>> + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
>>> + * @npages: number of entries in @src_pfns
>>> + *
>>> + * Skip source PFNs already migrated to RAM by either migration path.
>>> + */
>>> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
>>> +					   unsigned long npages)
>>> +{
>>> +	unsigned long i;
>>> +
>>> +	for (i = 0; i < npages; i++) {
>>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>>> +		struct drm_pagemap_zdd *zdd;
>>> +
>>> +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
>>> +		    !drm_pagemap_is_devmem_page(page))
>>> +			continue;
>>> +
>>> +		zdd = drm_pagemap_page_zone_device_data(page);
>>> +		if (xa_load(&zdd->retired, folio_pfn(page_folio(page))))
>> if (__test_and_set_bit(i, zdd->retire_map))
>>
>>> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> Iterate based on nr.


Agreed on iterating by folio order. I will use test_bit() here and set 
the bit only after successful migration, so a failed migration is not 
left falsely retired.

Thanks,
Arvind

>>
>> Matt
>>
>>> +	}
>>> +}
>>> +
>>>   /**
>>>    * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
>>>    * @devmem_allocation: Pointer to the device memory allocation
>>>    *
>>> - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
>>> - * migration done via migrate_device_* functions.
>>> + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
>>> + * migrate_device_* helpers and does not require the mmap lock. Device
>>> + * PFNs already migrated by a CPU fault are skipped.
>>>    *
>>>    * Return: 0 on success, negative error code on failure.
>>>    */
>>> @@ -1149,6 +1312,17 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>>>   	if (err)
>>>   		goto err_free;
>>>   
>>> +	drm_pagemap_skip_retired_pages(src, npages);
>>> +
>>> +	/*
>>> +	 * Reserve retirement entries before migration so recording successful
>>> +	 * PFNs cannot fail. Otherwise, a retry could select and migrate the same
>>> +	 * PFN again.
>>> +	 */
>>> +	err = drm_pagemap_reserve_retired_pages(src, npages);
>>> +	if (err)
>>> +		goto err_finalize;
>>> +
>>>   	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>>>   						   src, dst, 0);
>>>   	if (err || !mpages)
>>> @@ -1179,6 +1353,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>>>   	if (err)
>>>   		drm_pagemap_migration_unlock_put_pages(npages, dst);
>>>   	migrate_device_pages(src, dst, npages);
>>> +	drm_pagemap_retire_migrated_pages(src, npages);
>>>   	migrate_device_finalize(src, dst, npages);
>>>   	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>>>   					DMA_FROM_DEVICE, &state);
>>> @@ -1276,6 +1451,14 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>>>   	if (!migrate.cpages)
>>>   		goto err_free;
>>>   
>>> +	/*
>>> +	 * Reserve retirement entries before migration so recording successful
>>> +	 * PFNs cannot fail. On failure, finalize can still restore the sources.
>>> +	 */
>>> +	err = drm_pagemap_reserve_retired_pages(migrate.src, npages);
>>> +	if (err)
>>> +		goto err_finalize;
>>> +
>>>   	ops = zdd->devmem_allocation->ops;
>>>   	dev = zdd->devmem_allocation->dev;
>>>   
>>> @@ -1309,6 +1492,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>>>   	if (err)
>>>   		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>>>   	migrate_vma_pages(&migrate);
>>> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>>>   	migrate_vma_finalize(&migrate);
>>>   	if (dev)
>>>   		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
>>> -- 
>>> 2.43.0
>>>
