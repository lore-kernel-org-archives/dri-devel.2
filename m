Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F500C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF4C10F920;
	Tue, 15 Sep 2026 04:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="llKyyVHm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CF210F920;
 Tue, 15 Sep 2026 04:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789445393; x=1820981393;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eLB7DLLE2Q4HRMtIFZuO6fF5tgVS9PeiEL1RT0ujEkQ=;
 b=llKyyVHm0vcja1JjOZCeYxmSVnZzimtXpEmsHRxqKPZtW4QyCyIh/U3q
 f0IRfGO04Okon2NId0BP3BXJ9LbGl9zrflFC9TZ/x1pop5CIkzGLuL8vH
 I3PCl3vAhxe/g+S7/v4VmnEgvxPNNHf8dFhrI156zLRahKhj7KDlKswjC
 kza77xVha4c3rF/pCCfX9i+Vhq5D+m96R1SViDNaNRl8p2gLc84fFv3Bn
 OYsX11Zw1QV1SxRClz4lX4Wu3SmblPmKLpJfU0+zN2ArfPvPwsbP9BeDw
 ix/3lSj8Hjbk2j+ag59W65POBxK6jozcFw4+tLL4aK5n3t71+EbhMqSRq w==;
X-CSE-ConnectionGUID: GzzxpDGPSeqmeeOr2VJV9Q==
X-CSE-MsgGUID: uUIILqIsSk2Xx0beiWhsug==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89741345"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89741345"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:09:52 -0700
X-CSE-ConnectionGUID: 0qePmMrhS9OC2QjuPpGfyA==
X-CSE-MsgGUID: eSznanKbSlq22TbWi/Mj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1038676"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:09:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:09:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 21:09:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:09:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGqEnDV3ntdXN/Iacdl2vPpfZSd1EtyFUk4mcbGiD9rdYr+gPXXLZNTaTFmZCERv8bq20vSqBe1LkhbNwng/xMfKcoh+8Do7U4vEec0ySDxpRcJGhLD1Uqafm/SwPz99y/m+tIshD73SRjzOWontazHFUhPktIWsw9ILNg6KSa8FAhmmaRnxVMgtM+hRg8CL85KsfUiugaKMa8Q/u8OdpD+geLvtNzoL/2a02z9lkppHEhKgt9IuwhSedG9qB4jd+rtwJBrrBrk/HQrnLLBu0k5smuRBYPNDTmfGLJZP5gWwpvEnIihuv3AiQU8+BXI59W+cbMD2uiLSdHl/g1IX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqM6BdH/EBWCWk4QuFqntZc02FmaBiW/4pyCAEUM57U=;
 b=vk41H+3+n/cxtQe5Jf6zByN0rzPdH0nsceXcrkhuSQ8nhSG4IChy1GusCB7GhEG+lD5KJi86V6UhVJUIebtuDBizz48k7Kvy+mTCe17wO5kyVGbx/74jlJCSk27pJuEtd5a5R3OtRVMM2bsdlcrdjpPIM9QLwDS63w3pvqEntHx4B++gsZKBYktdeA5OsxgsBEo0Tlsb/+d/zdzuosyWP5088WV79rKCIUxXVw9PBZK7sIBg2Ph/KcfW3t6JMp+jMLSoz1CUIaHATVtkiUvXoHpIR6FtB+L421tqnf4dfCuNHzpXp4yY27XOch4o08MpU9tMO+TN7kbJj5uDH6R7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by LV2PR11MB232652.namprd11.prod.outlook.com (2603:10b6:408:417::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 04:09:48 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:09:44 +0000
Message-ID: <243c2dbe-3efa-480f-a6d4-d5ebab00d8ee@intel.com>
Date: Tue, 15 Sep 2026 09:39:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] drm/xe: Separate AER reset state from device wedging
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <rodrigo.vivi@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-3-arvind.yadav@intel.com>
 <3d75cfb6dd151ddb99eccec1e2712c80bfd334ef.camel@linux.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <3d75cfb6dd151ddb99eccec1e2712c80bfd334ef.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::6) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|LV2PR11MB232652:EE_
X-MS-Office365-Filtering-Correlation-Id: e398f655-719a-4f16-1355-08df12df2c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jqHczyVxQmehp/v2WlAHGboeVLgVNNZMHQJ6A34Dud1hU+mhKMdOrc8vmb1QB30KgGjfs1BVPS5e6k6eDt49YXyGYBsZpsiizvsbLdaG67ViUN5dAJxsoqQ64cTdRHWLC2XQba+3hD65oQanjq7FD6QGBBasuRKIiRH8awp7InL4Y0qqi/W8nfE/hhPGz/eTF1DLeBWwhnpcfEBDFy+mj05aodf6VX/XsTFUG5ws2nu+iS7evky31MvAN97P2bBolJYxSNpN9+JshTN34xN4cn9i91ICMM72zG2ICZmJ/wq6KwV/dqkj8k73UjfhByqnsRYbqpvxsy5gA31NX5OzWyvrH2K6wOylgWn3pBfFKqVz0oluM8wYY7p2hthmoF5G1YJ7mCf9gP6G4M7TM1A9Ja21Ae6UGLxMTxWB9iPaZJYZ0vng9ZJ3QK9CErRsfxqVmJ8n8JabgzWXBPeoxN5CcIilLftMYOHMzdTm2fVWFe/+GNJcJQp6/i2lhkV2EKm2N60Lqn5NDNW8bWqshbDsqKLXVwz/kJG08l/PLrZBlN4oRaUx3qK/2pfFK9W7Uuz/AkxnOb46KPuoFSsGbCMFClyhcXx/M64b4orYB7rvYqy8LE8FQTfSWn96m1QdkxB+exxZg1LFdOv2kAGNmgIsY5Nn/cD9P1cKvKWQ0Kf1pW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K29KeVEzcjdnZU1rd01EQ1ZaOE01T0oyczFZZFJvSUI1ekFUZU8wRXhrZ1ht?=
 =?utf-8?B?b0dvbERZd1k3ZkMvR3JMOVNDdWxray9qSStLN2MvVVdrc3JZS2V2Qkt0SnRS?=
 =?utf-8?B?NHJReGdWY2lZSkZiNVJnVDRIalZnMS93QUtzK0VPWEY5T1A5VFo3a05Td1pV?=
 =?utf-8?B?emRVUENWc0NHd08wWUZsbWRjT0g2THVUWU94UGxzQ1d1YkRPZFZab2NrT3dF?=
 =?utf-8?B?UVI0WTF2M0VpQzlxcTNRdC85aVdMYUxGYkd2ZnlhZ2daaWZaVXhIemM5RU9j?=
 =?utf-8?B?cS9hblQwMWRuZFVlanBkTGgvREtqMmcyRmRMcTRWYS9WSGhkaFNvMjdEcExz?=
 =?utf-8?B?SjZkeWdKN2RBbll2RTRHamhIQWk3WW8rSTh5blp5MkNEemVwWTBFRitpYXpu?=
 =?utf-8?B?VzMrY2l3dUk5bDMxYUJLNEd4Qlc5aXRQdEN6ZndReHlpanI1Wk1NQ1FJMjhS?=
 =?utf-8?B?VjdwWCthNEVjYlpBWWNLRitSZHlNbVV6ZUJncUppNUViQlBSMGpSOHVzSml5?=
 =?utf-8?B?Q3kyN0QraFAzOTgwUm5HWDVMK3lEb3F6eGhpVlJGOGU4S3BNREVaSTVPYldq?=
 =?utf-8?B?S1lDdjkxUTM5UURsNURvdGZhenl2UGtiUjMwUW1jU1NqZGlQK3pnMkRZd2Z3?=
 =?utf-8?B?Z3NWUzAyL1p0QzFkcmlCYnkvRGNOSGhrTmhZZzJjWkxBcTBHcTQySjhLS29R?=
 =?utf-8?B?SUZ5bFpvbmdpSVhrRzJtckxBc2hlbUE1cG5JOWdicFJOTGgyRlJaWGtQR0g0?=
 =?utf-8?B?S0k4cEFvYk53NGhnNnFFL2xJOWoxcWsrR202S2llSHExUmVyUHdzL0V0OTlk?=
 =?utf-8?B?aVBKMzNnM21MMjJJNWJZY21QSE5LZVQxSE1xQnZHN1RqdW1TVk9BVTl6Mm1u?=
 =?utf-8?B?QVpIVG5rUFlSeGQ2NkgwazJOZDRtQ21mUXFoUXZWSnRkV2FvMEV1WCt6eXRa?=
 =?utf-8?B?ajd2VnNzUjRrRmJ0RHFuWnJCditzdDZZZEt2bjBSMkhmVWZ0bDcvRlpTUEd6?=
 =?utf-8?B?aXB1NEptNGoyNkRvWWk0T2tXRjJnMDJXYlg0VTdPeEZMQ0htbWE1c0t5QklY?=
 =?utf-8?B?LzNXRWhtR2loYWV0OGFtK0ZyVk1YZVE3UlNENUdlelJCcUl1d3V2LzVGejdK?=
 =?utf-8?B?V0JDOS84S1JoT1ZEQzhDQjNMRWJsTGwzdlJZdmc3T2RuOVF5NGU2dXUycjRB?=
 =?utf-8?B?ZnlZRjdzUFdESUJoVSs3czNnK0FFNXNudGNEbDFKd0dSTGVvMDRhL2VGYnZU?=
 =?utf-8?B?aVo2Y3BqRktFeVJvLzNaL2txcWVISFpKNTJzS2tKQ2J3QWpQekx2VUNiaThV?=
 =?utf-8?B?M0hRTnk0ZklFbFcxVVduUHBTK3hwaDh1Q3Y4RmlZSi9CeGxXb2NmaU1NbnFM?=
 =?utf-8?B?ZVJFa25BOUZWUmd0UnVUZjVFOE5vcFFMczVRQnZPQmxoUG9tQnAyaFFiU3hm?=
 =?utf-8?B?bW90YzZNcHo2R2hwN25Ocm5rNTcxd251b1FzSnRma0RiNmFqdDNjWS9ZRUNE?=
 =?utf-8?B?RWNHcC9sVm9lczFYYkltUmdlajZyOWllc3FmS2YrS3NYOWZ3TUtxRytUM0w2?=
 =?utf-8?B?eS9oaWxvTW9pOEJWNFZibVVXOHpGYThwaStFWXBIZzZudDZkMjc3bEJnbmY3?=
 =?utf-8?B?d3Y2K1hGY3RTaUdNMHhNMkU4aHJqejJPN0dFN0FCc2o0Yi96S2pNYjFlWGNk?=
 =?utf-8?B?c0pTVU9WNHVGUytQRnhLTEZqZWNRVUY0Z0VoRHhPVGh4RlpLRWhZMEhVOEU5?=
 =?utf-8?B?OWVKakw1bTA5cTlqYUJsN3R1VG5jcXhydTl1NzFobnFnUDRiMWsycktYNmR0?=
 =?utf-8?B?eW9UYjRRbG5FK2MyZ3FZNEpIQmlXYTlRZVd4NjZ4Mnl4WXdhT3d4NHMrMWFs?=
 =?utf-8?B?Y1BiTFU3MzZxZzhRb3QzT1ZwVVpMUzhHbW1uUksvdmJkR0lOZVAydEtRcjdY?=
 =?utf-8?B?MUMwRjVtai9xS0lDVHA4SlBCYVptQWsrT0dxS3hNbHRUYUNLYzE2UTFTS2Mr?=
 =?utf-8?B?UmVsK3dUMzNiVGgwankySlBxRlgybHJkVlh2c29MSjd4RkxOSEEySU9Sb2E4?=
 =?utf-8?B?RkJxZ29zQTJEMGZVM3VaUW95dHdEemRQdUt4eU9qSW1JR2VGVFNoN1BCd0RM?=
 =?utf-8?B?MVNkc3U0ZnZZTVJobHkzcktqQmg3U1JVV2tzUkpiTWRyZ3dGejV5dElaYXg3?=
 =?utf-8?B?RzZwTDVnVXU1N3VKNVRtVGltYWR4eVovQ0ZERUtyR0tWdjRacjF1VmtoaWJk?=
 =?utf-8?B?TDBldlQ5alpiT09tT2dvQ2JFKy9OWldESEJpcm5nbGVjMUw0dXJpN1JxS0k1?=
 =?utf-8?B?ZGVicllXZGZ4ZlZFRzBLejNwa2IrU29zakV2UStGbzNCeldHS2dMQT09?=
X-Exchange-RoutingPolicyChecked: z6qWPCPjhs6wwjOsyEiwoVtiYnOTBGAdggXtSAxGyd5s9L8jJyhh4mBXoumV2CD/LOZvSWMS+2F/X2uwSCGQHauZ6cMu6KqofoYsf9ThmupP0uytcfQyas3GCpIsTtizzQj/7FO1RH6038uYYUIe3QdXkrAfijbvsFL65wBz/oVDzhQtyvp6XjOOdOehzEh/QNcJUZif+fLfEtKssqZOOPxDt47FTODXGsn1NncxxoEVd9bd2hd+eAwcJy2113hjRn8swNNKeBwOQvcVcH6cskv3tIofRkZYDv31sczK+w7+j18jY4oSmi5TExkdfW+/GGFp/7UY55UNF8BSGrjYRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e398f655-719a-4f16-1355-08df12df2c22
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:09:44.0526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqzoQybyxBIQOG/stRZyKIQV8taMQeVLJNfg9EiydqbMOjHnZy0uHP2FY7/kAJct4WBT41VmxaOy3tUPW/6vTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB232652
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


On 10-09-2026 15:37, Thomas Hellström wrote:
> On Thu, 2026-08-27 at 15:47 +0530, Arvind Yadav wrote:
>> PCI error recovery currently uses xe->wedged.flag to block driver
>> access. This mixes a temporary AER reset with a permanent device
>> wedge.
>>
>> If the device wedges during AER recovery, the wedge is not seen as
>> the
>> first transition. The AER resume callback may then clear the flag and
>> make the permanently wedged device appear usable again.
>>
>> Keep the old device blocked while slot reset removes it, and block
>> the
>> new device until the AER resume callback.
>>
>> The old AER path took a runtime PM reference to balance
>> xe_device_wedged_fini(), which drops one when wedged.flag is set. AER
>> no
>> longer sets that flag, so keeping the Xe-owned reference would leak
>> it.
>> pcie_do_recovery() holds a PCI-core runtime PM reference across the
>> error_detected, slot_reset and resume callbacks.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_bo.c            |  2 +-
>>   drivers/gpu/drm/xe/xe_device.c        |  4 ++--
>>   drivers/gpu/drm/xe/xe_device.h        | 12 ++++++++++++
>>   drivers/gpu/drm/xe/xe_guc_ct.c        |  4 ++--
>>   drivers/gpu/drm/xe/xe_guc_pc.c        | 10 +++++-----
>>   drivers/gpu/drm/xe/xe_guc_rc.c        |  4 ++--
>>   drivers/gpu/drm/xe/xe_guc_submit.c    |  8 ++++++--
>>   drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  8 +++++++-
>>   drivers/gpu/drm/xe/xe_pci_error.c     | 22 +++++++++++-----------
>>   drivers/gpu/drm/xe/xe_sriov_pf.c      |  2 +-
>>   10 files changed, 49 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> index dde309821237..b86cd6030ed6 100644
>> --- a/drivers/gpu/drm/xe/xe_bo.c
>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>> @@ -2094,7 +2094,7 @@ static vm_fault_t xe_bo_cpu_fault(struct
>> vm_fault *vmf)
>>   	int err = 0;
>>   	int idx;
>>   
>> -	if (xe_device_wedged(xe) || !drm_dev_enter(&xe->drm, &idx))
>> +	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm,
>> &idx))
>>   		return ttm_bo_vm_dummy_page(vmf, vmf->vma-
>>> vm_page_prot);
>>   
>>   	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
>> diff --git a/drivers/gpu/drm/xe/xe_device.c
>> b/drivers/gpu/drm/xe/xe_device.c
>> index 74d566693dfd..a92e90acdf0d 100644
>> --- a/drivers/gpu/drm/xe/xe_device.c
>> +++ b/drivers/gpu/drm/xe/xe_device.c
>> @@ -225,7 +225,7 @@ static long xe_drm_ioctl(struct file *file,
>> unsigned int cmd, unsigned long arg)
>>   	struct xe_device *xe = to_xe_device(file_priv->minor->dev);
>>   	long ret;
>>   
>> -	if (xe_device_wedged(xe))
>> +	if (xe_device_io_blocked(xe))
>>   		return -ECANCELED;
>>   
>>   	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
>> @@ -243,7 +243,7 @@ static long xe_drm_compat_ioctl(struct file
>> *file, unsigned int cmd, unsigned lo
>>   	struct xe_device *xe = to_xe_device(file_priv->minor->dev);
>>   	long ret;
>>   
>> -	if (xe_device_wedged(xe))
>> +	if (xe_device_io_blocked(xe))
>>   		return -ECANCELED;
>>   
>>   	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
>> diff --git a/drivers/gpu/drm/xe/xe_device.h
>> b/drivers/gpu/drm/xe/xe_device.h
>> index 6c4cfaebc44a..a3f876c60d76 100644
>> --- a/drivers/gpu/drm/xe/xe_device.h
>> +++ b/drivers/gpu/drm/xe/xe_device.h
>> @@ -212,6 +212,18 @@ static inline bool xe_device_wedged(struct
>> xe_device *xe)
>>   	return atomic_read(&xe->wedged.flag);
>>   }
>>   
>> +/*
>> + * Return true when device access must be blocked either permanently
>> because
>> + * the device is wedged or temporarily while PCI error recovery is
>> running.
>> + *
>> + * Do not use this helper for one-way wedged-device decisions such
>> as DMA
>> + * isolation, IRQ resume suppression or recovery-method reporting.
>> + */
>> +static inline bool xe_device_io_blocked(struct xe_device *xe)
>> +{
>> +	return xe_device_wedged(xe) || xe_device_is_in_reset(xe);
>> +}
>> +
>>   #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
>>   static inline bool xe_debug_page_size_supported(struct xe_device
>> *xe)
>>   {
>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c
>> b/drivers/gpu/drm/xe/xe_guc_ct.c
>> index 5c4733da385c..3c3fe4928fa2 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>> @@ -1062,7 +1062,7 @@ static int __guc_ct_send_locked(struct
>> xe_guc_ct *ct, const u32 *action,
>>   	xe_gt_assert(gt, g2h_len || !num_g2h);
>>   	lockdep_assert_held(&ct->lock);
>>   
>> -	if (xe_device_wedged(ct_to_xe(ct))) {
>> +	if (xe_device_io_blocked(ct_to_xe(ct))) {
>>   		ret = -ENOTRECOVERABLE;
>>   		goto out;
>>   	}
>> @@ -1813,7 +1813,7 @@ static int g2h_read(struct xe_guc_ct *ct, u32
>> *msg, bool fast_path)
>>   	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
>>   	lockdep_assert_held(&ct->fast_lock);
>>   
>> -	if (xe_device_wedged(xe))
>> +	if (xe_device_io_blocked(xe))
>>   		return -ENOTRECOVERABLE;
>>   
>>   	if (ct->state == XE_GUC_CT_STATE_DISABLED)
>> diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c
>> b/drivers/gpu/drm/xe/xe_guc_pc.c
>> index 097b075bd89a..9fe397296dc4 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_pc.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_pc.c
>> @@ -188,7 +188,7 @@ static int pc_action_reset(struct xe_guc_pc *pc)
>>   	int ret;
>>   
>>   	ret = xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
>> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>>   		xe_gt_err(pc_to_gt(pc), "GuC PC reset failed:
>> %pe\n",
>>   			  ERR_PTR(ret));
>>   
>> @@ -212,7 +212,7 @@ static int pc_action_query_task_state(struct
>> xe_guc_pc *pc)
>>   
>>   	/* Blocking here to ensure the results are ready before
>> reading them */
>>   	ret = xe_guc_ct_send_block(ct, action, ARRAY_SIZE(action));
>> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>>   		xe_gt_err(pc_to_gt(pc), "GuC PC query task state
>> failed: %pe\n",
>>   			  ERR_PTR(ret));
>>   
>> @@ -235,7 +235,7 @@ static int pc_action_set_param(struct xe_guc_pc
>> *pc, u8 id, u32 value)
>>   		return -EAGAIN;
>>   
>>   	ret = xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
>> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>>   		xe_gt_err(pc_to_gt(pc), "GuC PC set param[%u]=%u
>> failed: %pe\n",
>>   			  id, value, ERR_PTR(ret));
>>   
>> @@ -257,7 +257,7 @@ static int pc_action_unset_param(struct xe_guc_pc
>> *pc, u8 id)
>>   		return -EAGAIN;
>>   
>>   	ret = xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
>> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret == -
>> ECANCELED))
>>   		xe_gt_err(pc_to_gt(pc), "GuC PC unset param failed:
>> %pe",
>>   			  ERR_PTR(ret));
>>   
>> @@ -1357,7 +1357,7 @@ static void xe_guc_pc_fini_hw(void *arg)
>>   	struct xe_guc_pc *pc = arg;
>>   	struct xe_device *xe = pc_to_xe(pc);
>>   
>> -	if (xe_device_wedged(xe))
>> +	if (xe_device_io_blocked(xe))
>>   		return;
>>   
>>   	xe_guc_pc_stop(pc);
>> diff --git a/drivers/gpu/drm/xe/xe_guc_rc.c
>> b/drivers/gpu/drm/xe/xe_guc_rc.c
>> index 99fa127b261f..eb5ec443f7ee 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_rc.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_rc.c
>> @@ -40,7 +40,7 @@ static int guc_action_setup_gucrc(struct xe_guc
>> *guc, u32 control)
>>   	int ret;
>>   
>>   	ret = xe_guc_ct_send(&guc->ct, action, ARRAY_SIZE(action),
>> 0, 0);
>> -	if (ret && !(xe_device_wedged(guc_to_xe(guc)) && ret == -
>> ECANCELED))
>> +	if (ret && !(xe_device_io_blocked(guc_to_xe(guc)) && ret ==
>> -ECANCELED))
>>   		xe_gt_err(guc_to_gt(guc),
>>   			  "GuC RC setup %s(%u) failed (%pe)\n",
>>   			   control == GUCRC_HOST_CONTROL ?
>> "HOST_CONTROL" :
>> @@ -73,7 +73,7 @@ static void xe_guc_rc_fini_hw(void *arg)
>>   	struct xe_device *xe = guc_to_xe(guc);
>>   	struct xe_gt *gt = guc_to_gt(guc);
>>   
>> -	if (xe_device_wedged(xe))
>> +	if (xe_device_io_blocked(xe))
>>   		return;
>>   
>>   	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c
>> b/drivers/gpu/drm/xe/xe_guc_submit.c
>> index 99d8c807ff05..a307af458cf8 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>> @@ -2452,7 +2452,7 @@ static int
>> guc_exec_queue_wait_suspend_done(struct xe_exec_queue *q, bool blocki
>>   						       WAIT_COND, HZ
>> * 5);
>>   	}
>>   
>> -	if (!blocking && vf_recovery(guc) && !xe_device_wedged(xe))
>> +	if (!blocking && vf_recovery(guc) &&
>> !xe_device_io_blocked(xe))
>>   		return -EAGAIN;
>>   
>>   	if (!ret)
>> @@ -2694,7 +2694,11 @@ int xe_guc_submit_reset_prepare(struct xe_guc
>> *guc)
>>   
>>   void xe_guc_submit_reset_wait(struct xe_guc *guc)
>>   {
>> -	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
>> +	/*
>> +	 * AER sets in_reset before declaring the GT wedged, which
>> wakes this
>> +	 * waitqueue.
>> +	 */
>> +	wait_event(guc->ct.wq, xe_device_io_blocked(guc_to_xe(guc))
>> ||
>>   		   !xe_guc_read_stopped(guc));
>>   }
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
>> b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
>> index 046d0655122f..646e13671cd9 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
>> @@ -34,6 +34,9 @@ static int send_tlb_inval(struct xe_guc *guc, const
>> u32 *action, int len)
>>   
>>   	xe_gt_assert(gt, action[1]);	/* Seqno */
>>   
>> +	if (xe_device_io_blocked(guc_to_xe(guc)))
>> +		return -ECANCELED;
>> +
>>   	xe_gt_stats_incr(gt, XE_GT_STATS_ID_TLB_INVAL, 1);
>>   	return xe_guc_ct_send(&guc->ct, action, len,
>>   			      G2H_LEN_DW_TLB_INVALIDATE, 1);
>> @@ -69,6 +72,9 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval
>> *tlb_inval, u32 seqno)
>>   	 * signals waiters.
>>   	 */
>>   
>> +	if (xe_device_io_blocked(xe))
>> +		return -ECANCELED;
>> +
>>   	if (xe_guc_ct_enabled(&guc->ct) && guc-
>>> submission_state.enabled) {
>>   		u32 action[] = {
>>   			XE_GUC_ACTION_TLB_INVALIDATION,
>> @@ -77,7 +83,7 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval
>> *tlb_inval, u32 seqno)
>>   		};
>>   
>>   		return send_tlb_inval(guc, action,
>> ARRAY_SIZE(action));
>> -	} else if (xe_device_uc_enabled(xe) &&
>> !xe_device_wedged(xe)) {
>> +	} else if (xe_device_uc_enabled(xe)) {
>>   		struct xe_mmio *mmio = &gt->mmio;
>>   
>>   		if (IS_SRIOV_VF(xe))
>> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c
>> b/drivers/gpu/drm/xe/xe_pci_error.c
>> index 79ce0c671549..d82256d8721f 100644
>> --- a/drivers/gpu/drm/xe/xe_pci_error.c
>> +++ b/drivers/gpu/drm/xe/xe_pci_error.c
>> @@ -9,7 +9,6 @@
>>   #include "xe_gt.h"
>>   #include "xe_log.h"
>>   #include "xe_pci.h"
>> -#include "xe_pm.h"
>>   #include "xe_printk.h"
>>   #include "xe_ras.h"
>>   #include "xe_survivability_mode.h"
>> @@ -20,14 +19,15 @@ static void prepare_device_for_reset(struct
>> pci_dev *pdev)
>>   	struct xe_gt *gt;
>>   	u8 id;
>>   
>> +
>>   	/*
>> -	 * Wedge the device to prevent userspace access but do not
>> send the uevent.
>> -	 * xe_device_wedged_fini() releases runtime pm if wedged
>> flag is set, so acquire a runtime
>> -	 * pm reference to avoid underflow.
>> +	 * Block device access while PCI error recovery is in
>> progress.
>> +	 *
>> +	 * The old runtime PM reference balanced
>> xe_device_wedged_fini() while
>> +	 * AER set wedged.flag. AER no longer sets that flag, and
>> +	 * pcie_do_recovery() holds its own runtime PM reference
>> across the
>> +	 * recovery callbacks.
> This is an in-code comment describing what this patch is doing. A
> future code reader has no idea what "The old runtime PM reference" is.
> Please keep comments involving the old pre-patch code in the commit
> message.


Thanks for the review.

Agreed. I will keep the old runtime PM details in the commit message. 
and the comment will only describe the current behavior.


Thanks,
Arvind

>
>
>>   	 */
>> -	if (!atomic_xchg(&xe->wedged.flag, 1))
>> -		xe_pm_runtime_get_noresume(xe);
>> -
>>   	xe_device_set_in_reset(xe);
>>   
>>   	for_each_gt(gt, xe, id)
>> @@ -116,7 +116,6 @@ static pci_ers_result_t
>> xe_pci_error_slot_reset(struct pci_dev *pdev)
>>   	 * TODO: optimize by re-initializing only the hardware state
>> and re-creating
>>   	 * kernel BOs.
>>   	 */
>> -	xe_device_clear_in_reset(xe);
>>   	pdev->driver->remove(pdev);
>>   	devres_release_group(&pdev->dev, xe->devres_group);
>>   
>> @@ -125,8 +124,8 @@ static pci_ers_result_t
>> xe_pci_error_slot_reset(struct pci_dev *pdev)
>>   
>>   	xe = pdev_to_xe_device(pdev);
>>   
>> -	/* Wedge the device to prevent I/O operations till the
>> resume callback */
>> -	atomic_set(&xe->wedged.flag, 1);
>> +	/* Block the new instance until the resume callback. */
>> +	xe_device_set_in_reset(xe);
>>   
>>   	return PCI_ERS_RESULT_RECOVERED;
>>   }
>> @@ -137,7 +136,8 @@ static void xe_pci_error_resume(struct pci_dev
>> *pdev)
>>   
>>   	xe_info(xe, "PCI error: resume\n");
>>   
>> -	atomic_set(&xe->wedged.flag, 0);
>> +	/* Resume I/O operations. */
>> +	xe_device_clear_in_reset(xe);
>>   }
>>   
>>   const struct pci_error_handlers xe_pci_error_handlers = {
>> diff --git a/drivers/gpu/drm/xe/xe_sriov_pf.c
>> b/drivers/gpu/drm/xe/xe_sriov_pf.c
>> index 33bd754d138f..568b7ed7c380 100644
>> --- a/drivers/gpu/drm/xe/xe_sriov_pf.c
>> +++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
>> @@ -157,7 +157,7 @@ int xe_sriov_pf_wait_ready(struct xe_device *xe)
>>   	unsigned int id;
>>   	int err;
>>   
>> -	if (xe_device_wedged(xe))
>> +	if (xe_device_io_blocked(xe))
>>   		return -ECANCELED;
>>   
>>   	for_each_gt(gt, xe, id) {
>
> /Thomas
