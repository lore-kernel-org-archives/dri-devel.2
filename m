Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15C6CD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7AB10E9BE;
	Tue, 12 May 2026 08:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BdSmvpKq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6F010E9B0;
 Tue, 12 May 2026 08:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778574610; x=1810110610;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=86U8gfTBbgWe2zjRsZKtws92VaDg3vdYuQr+RxYl1X4=;
 b=BdSmvpKq/nNGdfQqQpFpRxIAAVn7hQaAnbQa8+03jm026XlKV0Ookt4c
 aYSjOSeYcJQiU2eQfq5Uyg3igIfn9Hfe2i7AmkT6ktVjCengufDaAKrFe
 kfSm0iS7eRwFFJ9MwQyAtHS5MhtdvhCSEjWjRb8dXld+zxMFtXaqxG3W7
 K6nJKusC9ylHNfKuUyj4rvK1qokiwvZeFLcxCJaVc57oBZ3k86rq4JZYc
 6h687AdmFp365Y4pLVg6GxA81LVa33yqrwfetUkcOIxe3unnUyL7keE2k
 8seDqDQDXyb601lzAc1dy5n9d++hcSFUinJmqYp3uBPiE5ihp/k31r7aH w==;
X-CSE-ConnectionGUID: CQ1IWy0YRWy3OcX9kzWA/g==
X-CSE-MsgGUID: EtNx5PLSTGC8LMab4+evWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="67006028"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="67006028"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:30:09 -0700
X-CSE-ConnectionGUID: 79BDJ63bS8K5Y6D2Cz/oPw==
X-CSE-MsgGUID: a/519xW0Q8q8QCc+az3R6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242700424"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:30:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 01:30:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 01:30:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 01:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hep5oVRsd2rTzvgvv59+O+hG+cbg48b8J/9AyjM480rCIDxIK03z0kyADAE/pFsZhVltcItEcSFIazz0zFQkb3pkLhFS2/6BH0YQ4PdZ7WqyK+t2uH6oGfBcpJsfmoD0dpFv7DXrhrSh/Q9epTqbQAeRClkkDs82eh2H3OPl5hedHxQJCOV5bEbyI08PJ8XxZO8taW9bfNEV3YSACy+H2ENtv3MgWda4zdzUIof6TC/0qZwBKqdP+sZL2ziKpw0I+W9/WHyfo8LnXBai3Zmi9QRwQ/0Q43hL/KAdKNucpQuZABd4Hk28PRy+I/vvyilMA3/xB5D1fieXsfZXlVYvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqBFVjknzLNCw3RDJtKSbeXiqqkMUjk7RRAyROJ4E0s=;
 b=gOmfwhvqLcbFeG4PZ9uak2yEEMVaDDj+4uR3fmNi/2zh7MuJ823JMj+7LVR9bk+zt05oF/Zr/jXKu5ctwGbH0uiAfF2JgENt/uskHsFQFsxVin7rBaYk8XGSnT0KXxIrpLcL5i1V+33DATQhaykUXSyoMOAlAmKNu8t98yzzsw8sLBR30Hc+fuI7wqq26Y5Vq4gxTPhcnwzBhKUj7d4QDTkRASjVfFjLecKDUh2dMFVi6XNLgw7Y+0eA9NVfkprlUheK59baV+cQyPXeRUGmh016yWV84ofF5dtahpbR+5GEMF7yfcMWzjuvJWCbW65g/EBpS6owXqxtiTlDxWvpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:30:05 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:30:05 +0000
Message-ID: <4dc38cbc-0b9d-4615-94be-2f07667b8248@intel.com>
Date: Tue, 12 May 2026 13:59:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
 <20260413133013.560239-9-mallesh.koujalagi@intel.com>
 <aec1wAFHMZyb9sFW@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <aec1wAFHMZyb9sFW@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::21) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|PH7PR11MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bc33ef-3814-4cf9-9df1-08deb000aafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: srJ6Mf/dTRgDW/SrXEmLzPvW2PT/eMY0xo96i+qfPGF5Nin5SEyUhANzFkpjaIVmN8ZYOgGDQBQDlyq1fw4VJaVu80tpet46DawCRe3+9xN1LBcGUY1L0w5hW86rWrwS52KKkMLfE8Lr4lgcLnUFZmNmoxmsmJO5Xy35CNl5Ynzm6m9YKEnjBxy+cH8Ouj9LGVLeU0+majhfiKG87uByDMqcHYHSjUwUl0oY2bNV6XJONeqUEo2A6FvPNjhaoFqc7E7IobbsTGiAZzOQJLBq1AGc5NGL6wB1SfiC/g9T6YRmmj4+WeAzWRDSTYfrIliqijNWxBYAhoDRlmPVDdIZkMjrfQ3huqmdoBi+h5rtkKxPXNUr+SVdCPsyNZXwjwilB5Pscc+qaomSp68p6PcqCYvSa9YlWN/WIWxe4hyZdo0/cYgEBw5Z2F2fV4lVBkRoEK7aFXXtluWqlxGwG8/mEi7H8292aS+/6ZfZ6OWT+TIDtAYZLaZWgPFitJmw8ZhViD4i1MZ7TsRoFHBZRAxASlrASOU9+CaC+IrJjXjxX43PwHYhIX1lfBpVqr8hXj360G9yHZFoHi4YOthyzT23q/aSR6vYr8TpAyxtIFcrVxo5owyXnqCg8GsYxnMRDQJj9wkIiOGSmakmUkFxEuTLucD3SUaUPbjsmcL+IZl3tJeNOWpn1uL5U/1Ad+T1Claw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NybThWa0M0UDlQTVArUGI0WUlVWnNCYnNid3J0dkJnYWdpSGpjU3c2MkxW?=
 =?utf-8?B?V1N4R1lhaVFjSmg1TlJaQXBMMGR6U3k0V1NCdXpyb0srWWRmZkhSNmtJbDgz?=
 =?utf-8?B?VkhnRDdNVmljS2ZmMngwejZNbXZuRTNqZDZWZlJ3aUF5VUhlWXpOT3ozMFhC?=
 =?utf-8?B?TFlFUkEzRWtKc1pXcHZWaGRaaTAyZHQ3cUJpd0hFbml6S3NNVnVESXZlUkta?=
 =?utf-8?B?NnFOUi8zOWFKUHQrNnBDTzV1RUpDYVN4bm4yWXVBR2sxYnV2YzJCZmEvNmdi?=
 =?utf-8?B?MjIzNFNiazNSbksra1FlMW8wYWYyYzhCSWhqN2owZklQd09Ea0VNQlNUNWdB?=
 =?utf-8?B?VWd2RExSTHB4VklhSW1uOFdWN24xbVJUeUY5M3VrOFNlSWcrNzlCTGZQdW1L?=
 =?utf-8?B?Sy9Td0R3RWVVK2pWVHpRVC9HVWVTekpDOTJoQktiSERLaEFOb1FuMmRpc2ZJ?=
 =?utf-8?B?ZUVDOFlON2ZabUZUNjJyczcxSERwQ0VtZUhqSzhMSW9MdytUWVZDbkNFajll?=
 =?utf-8?B?emdqV3I3VVZ5MHVIbUUzQkRDZ3BVd0pBcWhiNGkvd0dTY0Z3WlNFb2NoYXRO?=
 =?utf-8?B?a3RBa2FMVTNBMitKc3l3aEd5Rjl3SGo0RmJNVVpNS3lyWC9LV1N2aHRBeWxv?=
 =?utf-8?B?WVdHa2NjRHVHL1h2cFl5T2w3MUhqTFlydXBxU0tlTFJvajl4SEpwMGNWbUZB?=
 =?utf-8?B?WUFQbkFvR2dMajhENUlKQTBqZEZXNytJMXBjVmVlZ0tNYTJBdGdheVNsRDYy?=
 =?utf-8?B?QjJzN3g2NmxlQ1piL1RxaElWbjQ3eDBRWncvdnlIWXl6TUF2SWhjeDhEVGZz?=
 =?utf-8?B?TEFOM1IrMTk1VzRCUzdxMXlaTlFuZW1wQ2dkUExOTW9FSHlhZ2YvVlFJeTFP?=
 =?utf-8?B?R3lxQysvb3NWeUh4Y1VkVmRITHBBS1JnSEN0U2V2c0IxVUJ6ZlU3QVcrUjNw?=
 =?utf-8?B?b1laR0grRDMxQTM3dWNhTVlTTE1nV01Rb0JTM3N6WnE3NGkxNmRudnNjUkcx?=
 =?utf-8?B?R0hGbVhoOUVQQXN2ZkhuYzFjclowYTZIQTZzNEtPY2hkdk1STk1oOVJ3L0pY?=
 =?utf-8?B?dHIvYWVucFFKSytZaDFnaGRiZ3dTZFQwbC9rRno5Ykl5eDJkcG0vUWNkRUVF?=
 =?utf-8?B?emRoeUN6eTVWazdEcVhGZk91V2dXTExuTFM2eUZ2Q0VKUkJxY25idzBlV1hI?=
 =?utf-8?B?VWgyRU5rWUtpdG1EQUc3TU5SS2hGVUZjY1FBZmVDZWQwbmd3SEtINnZPa1Jt?=
 =?utf-8?B?VlN3RjdKUEJWS092OHpJMlE5ZU82ekcvSHA5MEFRQXVMWGhFMTljd3RaMCtB?=
 =?utf-8?B?MGtGc3Y5Qld4WFBRTXExMEF1dlJEMGlJSXJNdG1SWHdYTXYvSFBjamtUVHY5?=
 =?utf-8?B?RzJzNlVqSG5FV2N5Q2ZjOWF0dnNnTCtWbzhocWRxR3pFTUhiamJjVE5lTTRo?=
 =?utf-8?B?cHVKSTR3Y1dsVWRmYlVJYlVyd3Z5K3ZmZDc5VUlySWloekprTEkrM3NpZU9V?=
 =?utf-8?B?TDhOK1U4eUZtb0xpVXFTNUFCcHROL3FZVFZyUmVKK3RxbzBES0Mza3RaNllH?=
 =?utf-8?B?RG85U1VaSDYydllZcWV2S2c1T3JORGpJeUJxZFRwS0YzNUN3d0FDTUl4VThz?=
 =?utf-8?B?SEU1ZVNUTnZVNERzQ3J1OWxpK3hEb05yajdhc2F6Y25qUEhBbEczQVVpVjhS?=
 =?utf-8?B?Q0hlckdlenpZcjZBRytSak9xa1czTS9aWXNHZFUyYy9wY3plK0dvcFJoY0JS?=
 =?utf-8?B?QzdCYzJCVVg4VXh3Q05FTWVGUUNTc1FhQSs2ZGp2VmRmLzE3TTAyM3Z1RVVC?=
 =?utf-8?B?U3c2NWZ5ZCtYQkZXcTdrSjZmMGg4d2NuN2I1Z0NSY0Q3a01MZHhWZHJkUld2?=
 =?utf-8?B?Qm81UEJ5elc0NjBtc3BOczBqaG9JZDRxcFkxT2Y0TjQwa09tSzVrbVQveFh3?=
 =?utf-8?B?Wk1VZnp1U2VhM25SbTRDekM5NUtnejkvRmlSNzU0SEx6MXlMd2ZjeWNvV3hH?=
 =?utf-8?B?ZTYvYkRJK3pMM1V2NDRRWFpYNUZGckhHemFWWHRqNnZwOHc3SXUxVEU2NzdF?=
 =?utf-8?B?N0NDazFOdy9hOSttOXN1Q1drZU1vNlNENjdTcjVjUGpXVmVFZ3R3aUJVQW1K?=
 =?utf-8?B?RXFDaDMxd0VWV2t3YlFhQWpFYUZvcFViREg1YlQ2QitrREpjRGlFVmlIRlJr?=
 =?utf-8?B?TkprbGtOMnMzZ1BSL09aSFJROURIRFJtdUhiV1grYXpwRTYwVG1Uby9NcXM5?=
 =?utf-8?B?d0dTN25QZk4xbnhYTWtmVFhyYXZ0MXA2dFJuRUdaWmY5MmFiYm44YUdXemFs?=
 =?utf-8?B?My8xbzVPTlZFWU1RdzIydDNxYkhtaUd1R1JKNm9KTWJPbGNqSGhWLzFhQ1p0?=
 =?utf-8?Q?UwW75lOPtRQgumCU=3D?=
X-Exchange-RoutingPolicyChecked: Y+SIe5gLidLKjwbQRk7FIsEsWm1TScDj/MHxfOK+O2Ya+EEsJw2kay4hETys/IMlxq59gIqpEP4p9rVmT/uzhVo+DVG2jLmMJ5jzvy67dOHmnp+Z2GfNiCpXsOQXPYlMqS/LcKTvOLfH/ppy31oZuOmqjgXq0U5TnyXjDQuUkFqggHoJKGozt135UCY9W+QxlMm0twk7yQv3ijtswfg+0bb9HMa0tl+YUMaRcFVNQF25XHiUB0JiBUWBqio1RD6n2OUYXR/anbhlgxxDjx48BrsRBQNRuQFC6yGMUhTOVYNJZDoTcaoULokuYjmcOm9OHxmtmhz6gzZBzGmgTJIZkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bc33ef-3814-4cf9-9df1-08deb000aafd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:30:05.0934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaoWf3uuJmYFd32jKnKirG1rbUKM6LByS5BtUl8QzUem0Av9NfUq++ozruKM5MGgrCzLouVEEIBwMVcJEp2ZJ1QvJku2bJNz7WZo2f/eXbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8252
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


On 21-04-2026 02:00 pm, Raag Jadav wrote:
> On Mon, Apr 13, 2026 at 07:00:17PM +0530, Mallesh Koujalagi wrote:
>> When ``WEDGED=cold-reset`` is sent, it indicates a non-recoverable
> This looks like "cold-reset" should be able to recover it, so is it
> really non-recoverable? ;)
I'll revert it as per last rev.
>> device error, only a full power cycle can restore the device.
>>
>> v2:
>> - Add several instead of number to avoid update. (Jani)
>>
>> v3:
>> - Update document with generic scenario. (Riana)
>> - Consistent with terminology. (Raag)
>> - Remove already covered information.
>>
>> v4:
>> - Update doc. (Raag/Riana)
>> - Change commit message. (Raag)
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   Documentation/gpu/drm-uapi.rst | 60 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
>> index 579e87cb9ff7..0b87c8ed760d 100644
>> --- a/Documentation/gpu/drm-uapi.rst
>> +++ b/Documentation/gpu/drm-uapi.rst
>> @@ -418,7 +418,7 @@ needed.
>>   Recovery
>>   --------
>>   
>> -Current implementation defines four recovery methods, out of which, drivers
>> +Current implementation defines several recovery methods, out of which, drivers
>>   can use any one, multiple or none. Method(s) of choice will be sent in the
>>   uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
>>   more side-effects. See the section `Vendor Specific Recovery`_
>> @@ -435,6 +435,7 @@ following expectations.
>>       rebind          unbind + bind driver
>>       bus-reset       unbind + bus reset/re-enumeration + bind
>>       vendor-specific vendor specific recovery method
>> +    cold-reset      unbind + remove device + slot power cycle + rescan
> Do you need to unbind if you're already removing the device?
Yes, you are right, when we remove the device unbind is not required.
>
>>       unknown         consumer policy
>>       =============== ========================================
>>   
>> @@ -447,6 +448,14 @@ debug purpose in order to root cause the hang. This is useful because the first
>>   hang is usually the most critical one which can result in consequential hangs
>>   or complete wedging.
>>   
>> +Cold Reset Recovery
>> +-------------------
>> +
>> +When ``WEDGED=cold-reset`` is sent, it indicates a non-recoverable device error,
>> +only a full power cycle can restore the device.
> This was phrased much better in last rev, not sure why changed?
I'll revert it as per last rev.
>
>> +This method is used by devices that are plugged directly into the PCIe slot.
> ... which supports removing the power.
>
>>   Vendor Specific Recovery
>>   ------------------------
>>   
>> @@ -524,6 +533,55 @@ Recovery script::
>>       echo -n $DEVICE > $DRIVER/unbind
>>       echo -n $DEVICE > $DRIVER/bind
>>   
>> +Example - cold-reset
>> +--------------------
>> +
>> +Udev rule::
>> +
>> +    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", DEVPATH=="*/drm/card[0-9]",
>> +    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
>> +
>> +Recovery script::
>> +
>> +    #!/bin/sh
>> +
>> +    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
>> +
>> +    # Get device
>> +    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f /sys/$1)
>> +    DEVICE=$(basename $DEVPATH)
>> +
>> +    echo "Cold reset: $DEVICE"
>> +
>> +    # Try slot power reset first
>> +    SLOT=$(find /sys/bus/pci/slots/ -type l 2>/dev/null | while read slot; do
>> +	    ADDR=$(cat "$slot" 2>/dev/null)
>> +	    [ -n "$ADDR" ] && echo "$DEVICE" | grep -q "^$ADDR" && basename $(dirname "$slot") && break
>> +    done)
> This looks like too much is happening here, can we try to simplify a bit?
Sure
>
>> +    if [ -n "$SLOT" ]; then
>> +	echo "Using slot $SLOT"
>> +
>> +	# Unbind driver
>> +	[ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
>> +	echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 2>/dev/null
> Is this really needed?

It's nor required. I'll remove those lines.

Thanks,

-/Mallesh

>
> Raag
>
>> +	# Remove device
>> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
>> +
>> +	# Power cycle slot
>> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
>> +	sleep 2
>> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
>> +	sleep 1
>> +
>> +	# Rescan
>> +	echo 1 > /sys/bus/pci/rescan
>> +	echo "Done!"
>> +    else
>> +	echo "No slot found"
>> +    fi
>> +
>>   Customization
>>   -------------
>>   
>> -- 
>> 2.34.1
>>
