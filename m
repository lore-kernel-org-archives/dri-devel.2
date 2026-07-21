Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC63C4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DC310E781;
	Tue, 21 Jul 2026 13:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Cd7dDg9M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E18D10E34C;
 Tue, 21 Jul 2026 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784640191; x=1816176191;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vc6rRKp6AHIi0C8qOcsyC692ijLsadixDH2Ga5QO/oM=;
 b=Cd7dDg9M/S8uTc9egYp394UhKyof0ssTtRjbDTyFSjoDN4mYYb7LT0cK
 7C55E73t9s00apMbGlsLLxwzdmGHDzOqQDQ5KBBiUCOimex4Pvdte6A0R
 L2gTje8wJSKUfo6P8kwO0jcg5FbCOg6gB6jjg9g0KHAvHcyQeczWVO+KM
 mGS0kE43p0gnzym0sqU42JG2alaEyDEUIHa6PcnETz3LSsY8nLRJv8gDV
 eQJ7HkxG4vBaJLtvGLCz/wV//6IgPQ5jN34C6Zo5/RICdQyc2nu3YhN/k
 VPROCZy3VbL1WfyvP/t3FhsTgigbfAl4JIjiv3CKmbO8XLda3DlJ22o0p w==;
X-CSE-ConnectionGUID: 745QgvD3Tw+rPGw+N5cAuw==
X-CSE-MsgGUID: HFdj51MqQrSnsrlcLCYhJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85333297"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85333297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 06:23:11 -0700
X-CSE-ConnectionGUID: 1ajlGteMQpqxP4ZCVbpehQ==
X-CSE-MsgGUID: FGZcjksOTgmx49Y54nt/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="254362702"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 06:23:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 06:23:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 06:23:10 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 06:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFv1uHwwFORlmYORhTBluc/P4sD67ROaRwqAm/5Eb0VfXm6QHajwHJ7cDj8L+kt/rvzTaWslz4x+8MhO9Wc63zKUS64kU39+aOvhcUDPz+ajxWluOn0VhZvkyHSAc53Qe/T3SfZ2loBmwlkE5KAlyH0VNXTSufcy4+23mfnIlrBpy/aAjyjTaARB/wZ7lsdTGMZqt8iqFeZVhI3oXd3IHc2shttQ9lelAXG8SQIA2FWVh3XvtK+H2EELlu7Z/Asp/qV3yLJdhqyn+oR/9zB8Hvbd9XlKWSnYla5Dyo4Ig9TdjMV0+h6zlt9ogAYl2u3QBG8r9EBSlOALtp5HHQJ9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a8Z01SToqqP+arQeY6Grhj/53+QQ931E/1jn6s3Vck=;
 b=va8Ab2HgZ7Urh9/7jN1FUj7NFP1sKmK7AzwyA1SOb0FVfsfLz0826B9F4mHWX8KuvEgMhGVgBDYmJ95I8ivn1jGPGIUntu/iSEhWX66Djl6dvYChh1eBWAo2O9569ekWY4nhrWXJurvsrW5NCEYS080gYQU5WnAbicvv20Sg1ZGuwVjDI4kazU4sdLFlwhqM2o+6rpa2t49rXKui303xxZNjs/maC5XsUINzypopLCmZAEDpPAAB9qDbAOCTfcascTF/+aM2DD+qszthDt0EvGLiEmEB+aDT/Xv4TQhY+EepNa5+gG6FEB67l74K3rXDDtnhGdPe1tG6GI2VAK8LhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Tue, 21 Jul 2026 13:23:06 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 13:23:06 +0000
Message-ID: <0e842368-3bbf-436e-839d-cc7fec29b0cb@intel.com>
Date: Tue, 21 Jul 2026 18:52:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events to
 userspace
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
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
 <al8v2STXTiMhp5C5@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <al8v2STXTiMhp5C5@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA1PR11MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 987cf004-71ba-4ef1-9673-08dee72b333e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OJCOOqQwJFll2hBRRXkDi/sLpjFrTEuY+C4cIzdFKdLPDmSx1HGCblOvav/PpXydPk+v4GIEuNQZoCaxvsNgu0FXC/quVpiioSfAld9vWdffXIzA5abdvS2IhzT7wvafgah6e0IS8eTB7cSfTMajWzF7HAiGjoA8R5kG3zxVfRD9Pr0yI78BQq6WLx1OonkbelJvUx6aQN+8eLG6TWZAUY8tSDgMVRFesgyuIAujOASz5BWBCMZBMUunbpJJEVCAjQGIuZsBEsYql4a8i0FXiOcBz3muDMO7yqoPmKfNzp52ZJJ1dD5zCvOl1MozYLsUYVhdgOxO74FI5thfajYHukzULCZlBvXq8dW8b7peVQmdvI8YW2bsoO6qAYgwTS/t0FFs8rcgDiuee7AGJqXnY8IC6+z2REGB9wYufj3W87hiK7IiZpo+BFzl07QxyTUn6X9wL6Y/WE9HMKyzyyLkCb62NatbT3G9lN8UrsODsEI9SkN6RifHsKGrRo8om2EsGtTgZvN2CO++ppUV4b79ixWstoN4/3eyAMbbTX22T2LeGNnzSTjeDnIiahKxc9ZHPBxxaRSBZf113X73TTfK7oN5jpLjwrbEqEVWk7oG4aH+iLQ2HQDqU5UbSbDqpL8v5ZOYqMehGn8kDAsC9E0IOOXOVna+Lag8vT9wwpIysh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bks4UkQ1R1NOVXBJTklsdStLNzc4WVFoN2FBYWRZM3UrL3BBa25KNHp4T1Mw?=
 =?utf-8?B?T2gzS0lYUEhONFVrdkR3YzVPc3RtMmpiQnluWXkva2NHTGRWSjdSMUY4VFdV?=
 =?utf-8?B?NGEvcWZWYlhkTDRzVlcvVmF4eEVBT1M2eVZkbnNTeWJGUFpteGlCMXRWdzZW?=
 =?utf-8?B?bWZQdmVDeDFhWEZrY3lUY0d6SEdoWHV1dWZWcWVhZkt2NFlOYmFibnVQL1du?=
 =?utf-8?B?eHlJbkc0WlJ3NnZjRTNhUTk1aVRDc1BhOWlYY0Fkak1XbVRWN0E0cGdjVkl1?=
 =?utf-8?B?RGNwWk1vQXlicVZ0ZE51SkFZZnhJNW5tNkZHampENXFsT25rMFFVZEVOTUtC?=
 =?utf-8?B?d1BuZUlWREpuYWJJNFhEVWZSNSs0d1I1eE82YWNERGxTNThYai9QY2hJQnVP?=
 =?utf-8?B?MmNKR2pBaE9iWWw1RzFuenA0ZVZqcXh1Z0FsM3JSeDExTmpROFBaM0c4NkhU?=
 =?utf-8?B?aE9qd0F5QXVyeDJJbGN6dlp2WE1vcERQbDVPR0oyRmJKaEUwR1Z6MU9XdjJJ?=
 =?utf-8?B?Vk1wUjBzVDIzcHArLzhzVzlVNjd2SDVTbFg3UDhMTTkrNGFOUGdXdEd4cFgw?=
 =?utf-8?B?SFd4anh0Q1JhMTlDenBxbzJVU0NHaGtiY2wwT05KbVVNQndDaWN0bE5zSmFm?=
 =?utf-8?B?ODRSQzJRVGVmaFJhZUJuV05NRFRkc1Vac0x3U1BwVHNLdTdWTW91V3d4UFFK?=
 =?utf-8?B?Q29mYXorcXNja3FYdnQyR0xCRitUUDZvTkFhWmxTMmxaVHhQKzVpS1Jxc0kz?=
 =?utf-8?B?QlhsYWtVY3VXRzFINnoxZjhCYmJneXMvMkZVK3oxZlg5QVJvSUdSMDIrWkpQ?=
 =?utf-8?B?bHNIZUErOVprNGRBR3h4b1hOOHdRektmbFQvSkMyNDFNTU5TT2RMb2JsMFBY?=
 =?utf-8?B?UFdZc3FsU1BiZlZWVStvZ0dLRUxaWUlLZjBtd21iZWtIS29DS21nVXFpcFJq?=
 =?utf-8?B?T2hTSXU1WW5Zbnp5ejRyajdVa2k4TU0zK2doRm1KeTBjRjAxenhmOVJzZ1hw?=
 =?utf-8?B?U2tEQUJiMFdQZXc4Vnhud1V2aGo3dkgvUjhUZmtuMEEzTnBmbjBQUndpaEVx?=
 =?utf-8?B?cGd1QkZ3TVZobmpyQVdtY0JjNmJPMERlVFMzZDMxQVVkbWtpVEoweUJVVC9C?=
 =?utf-8?B?ZWprNU8xc0dtU1M3bjh1NTdsazFzc2NaalcrSjllKzI1eFRKVnczYldYeW9w?=
 =?utf-8?B?U1FjM1prVW0raXI5YnlwUjd1NGpMajJFcW8wVjBUT25RZFloK3ZlRmJWNE5W?=
 =?utf-8?B?SWJMUDU4Wi9RYUFkNTdDYkFTcFZMWEJiZGJCRTFHdWM2RGJNanNFOU9sU1Fr?=
 =?utf-8?B?WU5GaFFZL1ozaUZjYjBxdmt0UFRHbUJzaytlUFRYM0VmbUUvaDBiMEFqQW1J?=
 =?utf-8?B?elZRbkEwSktSamVHUCs3LzhwUFlNeEJtck5JM2RoZjF1dVZjNDVnS2JhKzE2?=
 =?utf-8?B?b0ZvNWlWTy9uSjVQak5tNlI0SmJCSVYxWENLUjBydUc2SytvR3lkZkVNVVdl?=
 =?utf-8?B?RXJRVkxlNVMwOXlIMWlFVHdnYzZNWUZIV0hWMTZoQ0p0bDhpWThadWF3SDdQ?=
 =?utf-8?B?SmFTMklzUXZBZmE5UDdyeFE5dW53SHg5VHY2dDhYVFRCSkgrbVNJTmEyTVly?=
 =?utf-8?B?U1hrYnVxZHdhSmNXQWtKaVpBd09hL3JCdlEvTmpvKzdpZUYwQkdvaGlIanhz?=
 =?utf-8?B?RGVnZ2RkV3dWdUpRTkxhRmVCN1p1NXpEVGFNdGxTRi9zalVzQXYrSmZ2bFN1?=
 =?utf-8?B?SkRWc1NDbG00bk5BcE1BVUxjYjcwcE5HNFZUdVg4RzJDN3YxVzZXOXkvc1A3?=
 =?utf-8?B?aUlBZEtMbjV3cS8wRDljbVM2QnZtcC9lZml0T0JQSmE3SUJLM2lXamdWd2NG?=
 =?utf-8?B?SXFES3gzcFhVVEd3OTdDRHFkWE9VOTN5M29zeG02MTk5R0pXMXp6aFhGTnVH?=
 =?utf-8?B?SnAvYWNyWWU3aS9FL1MvNkpHWTViT05FdmNZMEJwTlBpKzY3VThQa2VXNDh0?=
 =?utf-8?B?K3JMSWdaVFdiNS9ETDAvc0kvSWxmSTg4dmhaSVVWR01Zc1QzYy9RVFI1ZHlX?=
 =?utf-8?B?MWY2SmNtZGtQYmdram9zYmROblloTkpSUG9iOFMxcW4xWHYzTlJ5cVZSNHJG?=
 =?utf-8?B?ckZvNlh3L2VjNzVwSEdhNGxpajF6UHQxOFQwZXRNSHFTR3pGT3VnSjZTVkI4?=
 =?utf-8?B?TUZsUTJlejIyVy91cEIxcXJ0YVFyekQ2TGxRcUd6bk5zc1FwSG1YR0tUVTF0?=
 =?utf-8?B?c1Exdm1XdFh1amRvRFZoaU1uakRPVkdvWjdqZzlKdEIyZXhiNTFUTm96VzY2?=
 =?utf-8?B?dThEaGVxeW9zOGlIaGMyYnJzL2U5RWFsUVJQRVN0cS9mR01oVExLdz09?=
X-Exchange-RoutingPolicyChecked: N0NJKcmRq7WcTg4ojCEwMA/nvP9ba+Z48+k4nfxNWMtpx2S1eYBc6sBIZDHXv3dqgK+eMC8qNpNtFVLSNYOZYpuLOff1oeRi832apA7udltiDheGKsd7D3SrVF8+DY1CTDHDKHiYjPcs/kddPkOABm+QiI/q8l4mt0xtUr8AeJDPfd6E2DtKO19avMDC2OvCph0YgkxQIAnh2GkoYOABiSFdJOSXxlwKpCfI+80eFGk3qzx8EXxVpUbbi6KWNuIw48jWtJEQbyEymmMr3ZbPzi1dUQFXfeOE5ZxLMBd8QNbOt7dNH3vWKvEN0SNdcVoiacnXmZYy0cx+7b+KzbFq2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 987cf004-71ba-4ef1-9673-08dee72b333e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 13:23:06.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlWn0J1ZRFt3IgrOWE2v1ainNsQgdpNb4k+U0T3LOWTfd2liuGMGWftv+D8emGDdTw9d9CmH9hsNsaVEKeeo/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
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


On 21-07-2026 14:07, Raag Jadav wrote:
> On Mon, Jul 20, 2026 at 01:52:11PM +0530, Riana Tauro wrote:
>> When an interrupt is received indicating that error counter has crossed
>> its threshold, read the current counter value and deliver a drm_ras error
>> event to userspace for each affected component.
>>
>> To avoid sending duplicate events when the same component appears multiple
>> times in the response. Send the error-event once per component.
> ...
>
>> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
>> +{
>> +	struct xe_drm_ras *ras = &xe->ras;
>> +	struct xe_drm_ras_counter *info;
>> +	struct drm_ras_node *node;
>> +	int ret;
>> +
>> +	/* Event is supported only if drm_ras is enabled */
>> +	if (!xe->info.has_drm_ras)
>> +		return;
>> +
>> +	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {
> IIUC this is error_id and should be validated against first/last counter
> range in drm_ras layer (similar to registration code).

This should be done before because we are accessing the nodes here.
The nodes anyway won't be available in xe_drm_ras if not registered with 
drm_ras.



>
>> +		drm_warn(&xe->drm, "unsupported component %u\n", component);
>> +		return;
>> +	}
>> +
>> +	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
>> +		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
>> +		return;
>> +	}
>> +
>> +	node = &ras->node[severity];
>> +	info = ras->info[severity];
>> +
>> +	if (!info || !info[component].name)
>> +		return;
>> +
>> +	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
>> +	if (ret)
>> +		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
>> +				    info[component].name, error_severity[severity]);
>> +}
> ...
>
>> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
>> +{
>> +	struct xe_ras_error_class counter = {0};
>> +	u8 drm_severity, drm_component;
>> +	u32 value;
>> +	int ret;
>> +
>> +	counter.common.severity = severity;
>> +	counter.common.component = component;
>> +
>> +	ret = get_counter(xe, &counter, &value);
>> +	if (ret)
>> +		return;
>> +
>> +	drm_severity = xe_to_drm_ras_severity(severity);
>> +	drm_component = xe_to_drm_ras_component(component);
>> +
>> +	xe_drm_ras_event(xe, drm_component, drm_severity, value);
>> +}
> This entire function can be dropped. See below.

We don't need to drop function. It's cleaner to have it in the function
than repeating it twice.

>
>>   static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
>>   {
>>   	struct xe_ras_compute_error *error_info = (void *)arr->details;
>> @@ -312,8 +364,10 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>>   	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
>>   	struct xe_ras_error_class *errors = pending->counters;
>>   	u32 id, ncounters = pending->ncounters;
>> +	u8 sent = 0;
>>   
>>   	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
>> +	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
>>   	xe_device_assert_mem_access(xe);
>>   
>>   	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
>> @@ -327,8 +381,21 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>>   		severity = errors[id].common.severity;
>>   		component = errors[id].common.component;
>>   
>> +		if (severity != XE_RAS_SEV_CORRECTABLE) {
>> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
>> +				severity);
> Sanity checks are good, but I think this needs to be extended a bit.
> I have something[1] more robust, feel free to reuse.
>
> [1] https://lore.kernel.org/intel-xe/20260721082953.640497-1-raag.jadav@intel.com

Agreed. I'll drop the checks. We can merge [1] first.
We can drop the drm checks above also if [1] is merged.

Will remove all checks and resend a new version.

>
>> +			continue;
>> +		}
>> +
>>   		xe_warn(xe, "[RAS]: %s %s detected\n",
>>   			comp_to_str(component), sev_to_str(severity));
>> +
>> +		/* Send event once per component */
>> +		if (sent & BIT(component))
>> +			continue;
>> +		sent |= BIT(component);
> With [1] in place you can just get_counter(&counter) and drm_ras_event()
> directly.

Same as above. Better to retain function.

Thanks
Riana


>
> Raag
>
>> +		ras_send_error_event(xe, severity, component);
>>   	}
>>   }
>>   
>> -- 
>> 2.47.1
>>
