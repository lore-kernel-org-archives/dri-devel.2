Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D68CC531D2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E3710F160;
	Thu, 23 Jul 2026 14:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LSf0br0z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C8810F157;
 Thu, 23 Jul 2026 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784817403; x=1816353403;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0rB2jcLCIHUMTAr4P70YcQe3vACkfGoFkKk8XgI2Nw4=;
 b=LSf0br0zeLm6T80RNFXxZQlzZ9OfNLwPl6jOhzPEn/LCJYxHBcEvgT3X
 1txKdzjBT8jbfEo2BcG8aQwnkmIcuZBuK628QD/qfJwNg6J8KDZvLiedZ
 QEDHIl8vosgflCmjfpX4lKuNedJaMs7jK+8I/5OZQy/LGFpdpyRyZuh4l
 T8bPbxmaR2lKmv1z70fWZUHITZPAVQo1KUtB3OSTbNNDEDCzELSB+8AkM
 SaEF2sWc17AE+IA3eV2gRw9tL/hbN+wKetGMlwzB7OWrIRgXQZ0bgaJmI
 TznEvdkuQh/PYRvviUxH03MJykt/c8xHWDkmH0puuDk3Mc8WB+/ddpuM1 w==;
X-CSE-ConnectionGUID: mq27gjXMRketVRBKCkSGFg==
X-CSE-MsgGUID: 3Hdn1S8lRN+lH7vGVAYw6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="103020102"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="103020102"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:36:42 -0700
X-CSE-ConnectionGUID: yMxXowsfSSay+8XWErG3zA==
X-CSE-MsgGUID: gcKw2LvURX6tLc6QqV0kDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="256624912"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:36:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 07:36:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 07:36:41 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 07:36:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ9ix45fvlZKyLagz9TV2/0UxAIA5cMrntNWiAOYTU4MHTLhXeKJddbklz353Xg0LIaeEFh2L/3abiUf24+KkEknYLYHwnZg+skCJdCPAPEkKTkNMVN7UVZhAT9DmK5tg/OsGvn/YZen3iVutEOX4pmoIs+RfvyIHKQM3TadjEgt3EYCLHRsXQIhmFYqj0zZ9hFQx67TUiVMC4jGEOcuCuHHNfVM3zcn3waDEKwRXymDQR4tqRHR1pPJdPVdjWCLsX7npUzL5pHMPYk2s5uK31qUBE2r+YqAwQRRjsMUfoBZ1G9hUu20cke9x0fc6XbxpWxdgHRuto5EIf3YLZT/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHIz6a+DUMdYe7tjU01FoWTJ0wMexN/UvEjYUIAxWYU=;
 b=q3C0yllxzzSsIjCLWQOGYOdSDgQbspHi0x9fkfpEqrb0omXQ+KJrp8+LAegvoMsFYIueXAqSNPmdkgChybkhmvrC1zirSyEcGEqpfk9GkHSf3Jd7uWraXGcJEPIePhE6ee4gO/8c9crddlk1WHjpaDJHyvKY1A7stji+ghhc54Wp4IfytCW+h42qUemDdeYjV0CkbpUAX48OMkmHPyTZL4RPWnEAOdWKu7+31KE7X5leKGMKuXWVNuJjz/kg5hxXi2BpJVnj/FiTMpWzko7c7r5kFsXFswVbaN7EZgcFoJB9cKHB9EnRDU4HuZmkaTxAWwauROfZ9HSOk6zpqD09fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB9477.namprd11.prod.outlook.com (2603:10b6:8:290::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Thu, 23 Jul 2026 14:36:38 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 14:36:38 +0000
Message-ID: <a5eb582c-f063-4730-8015-da59079a258e@intel.com>
Date: Thu, 23 Jul 2026 20:06:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] drm/drm_ras: Add drm_ras netlink error event
To: <rodrigo.vivi@intel.com>, <aravind.iddamsetty@linux.intel.com>
CC: <anshuman.gupta@intel.com>, <joonas.lahtinen@linux.intel.com>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <raag.jadav@intel.com>, <maarten.lankhorst@linux.intel.com>,
 <mallesh.koujalagi@intel.com>, <soham.purkait@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, <kuba@kernel.org>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-5-riana.tauro@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260722094134.3036087-5-riana.tauro@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0296.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb00847-d4be-44ae-2356-08dee8c7cdea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: odPOqdC/f2puKfMq/sl349+QG65qJFOSTArWvtOyh2Gen/gmhwOC/hfJjm6+wyXhbncvloskaeHSS+FtlhFbs/eMVN74nDZJqFQGib1ibpun1KJUNJ1SD8NlutukiVCbXQQvrYG5g0fiZ0qhFlElFPLVVAndduOAEk0moXw/1wu64fEaEejm5Eb4W660bp9VguB8isLl7gQpCH1UF6OLRmPTNHFTBZiW3lLoBxZnQGZK2VeIg2MvJHcYhHJqsmPNsLXvI2WJCeACg3ht/Rg5rqEQ4CUSLGwMuMNQ2eie2RFJ0dRuBEcn9YTBcSI6P/Czm8xZ0DjzuZEgDnC5QZHYK+CVGChzq5i8RxYnjzsKTF9TeqgncvZ6EvzrkOJ9oZaR0ug9TVfY7O1htfs9kx67/s1v4TxBVUxyvExe2A5iW3bqF+VJxWcuQZfwV1853aTtwSLCEFSCu9qsDCCHpLPisXYMnjeCUwKsm7c9f3hll8Kstt6f9jxp0nnKh8BME9YigDA11XfubhIzq0HMLUYDSd5zuf0jc8NRBMMUz+LARGP4ABf2AKtgTONq14+TVc644tfReo/LdmhwWtA+SpKn2aDre5/cTl7jUEHodtjdc5kbsK6R6SjXkUPb4aSdwVQ6ECwRMCGEHbVPyjGbGXH4tSpXQlJezmyLCVLiImko9d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXd0dnN2RzNwWmYyWDRoNWxMbThMQWdGS3NLRk9aOCs4MXZCcmdXdzNkenhX?=
 =?utf-8?B?RXRtK2dxdFZydDNLTHlxOWRtUWo1dU9RZndMM0hveGZ1bFJBY2szVmtKRmhi?=
 =?utf-8?B?dnB5ckxCbjFsNXVoSkl1T0dGYWcxdDdIcEtRK21xYjhoU29yUml0aUtmNFJY?=
 =?utf-8?B?UTlZK1JaTlBrSTM2YU01SGlXNVJwWkRqN2NMUUozTmlEN09VcVd4elNxTVY3?=
 =?utf-8?B?dXYwVDFIdDQrbTlLR28yb3U0M2JxSlhreVJXR3hTVlJpV0RUN2pQUjRMRmpn?=
 =?utf-8?B?NUZTNmJyTXhVN3l1eUpobno0WnVpYU5Yek5ZOGNEdDRwczdZYVdxa2VobU1H?=
 =?utf-8?B?dFVsMk9pNGhvZlF5OHE4Zncvd2xNN3lSYW82c3VBRUY0T1pqYjRiYlY0SG5W?=
 =?utf-8?B?RjBVUmZhb2NaQkFvUEtMQWIvT0pkV1RtU0tuSXI3allyTy9QQnpQVDBCWnVu?=
 =?utf-8?B?RkM3cng0VFBBTVQ2QjFza0kxU1FKbklBM21pTVZqSUxQbFpMbjYvQ3J6RUJC?=
 =?utf-8?B?aVF5eVBJSnJyZS9OcHpIVkFMQ0VZam1PU2tRWE1jaWRWdS9OV0lTZ2lQUzRI?=
 =?utf-8?B?SS9pZlIycFNQK2ZjUVU2bXd0all3dFhNbSt2UUZsZGptVE5ZUXU1Z0J6eEU2?=
 =?utf-8?B?ZFBJTGNDd3RtekZTbE8zN0E5TXNPaEtIS2VFbDRZSWJERDFHV3BjUnFTSlAw?=
 =?utf-8?B?SmJGSWVpKzJhVjlXMnVGQWt3RzdpWFBEYjd1Z1hwMVJadU1uQ2hncFNGNUZ3?=
 =?utf-8?B?NmcvMVIzekFna1hnRndJUHI1MGMrOFY2QlZCNTMxTGY2ZDZRbXRPN011WHlY?=
 =?utf-8?B?STVORnNsdUdEejJMMHF1YXVFOXJEUURGSC9kemtHVGk3eUlTWUpJaGh6R3R1?=
 =?utf-8?B?NmtzcEpMU3VHZ3NkOGRnUHFiSERqREFzcWFEaGorVWxjbG92ZGRTdlZQdXhD?=
 =?utf-8?B?a29qZCtIbFdUNWlXeSt3NksvOGlxMzh2YnFQRENRcmxzWFZZcjZaSjhXS0dH?=
 =?utf-8?B?NUNTSUljbnhPTXY5YzZ4enU1MFBuVTNWV1pkUi9wd2lkRTdvUW93YnJ2Vlp6?=
 =?utf-8?B?aWFVbmh6U1NwNEJNTlp1WVMrQ2FsMTltTVd2Szl2WkIxeCtBTUY3OWFvQXdE?=
 =?utf-8?B?Sll1d2gwZ252TnFjQ1pGS2pCdC9UcTNxeDZSUlpvZ250N05SWHEvakxqYmFD?=
 =?utf-8?B?N0ZubnNSWG9RK1NjSk9sdWdMNDFZN2FZV1QyMW5hRjVUVlZiSi9sZXU3aHJv?=
 =?utf-8?B?clRXY1ZtWmlldERnaXFXWlZKaW8zMDYrS1ZXUzZLZ3c0Wkw2QVhRb3ZZb1Ir?=
 =?utf-8?B?dWxTaVFXSGFZcDVBR1JTR2RXc1A5SEV5T3F5UGYwRGFlUXFDRFZDSnhVSFgz?=
 =?utf-8?B?THVrbmVVRzhYK0pjUUVyODVRbzludzd1a0oyUzdxdGU4RzBNcnY0akRyb1lD?=
 =?utf-8?B?QnJETDJxSEQvcDBpaVJNYm96cnZxVlhGQmdZVElFV2ZWMzMyaWh5SFRiUU9X?=
 =?utf-8?B?ZklSUy81TWFReFRWWUkxa3BiejMzWGNLS0ZuVUJCQzlYdlhOQXhwR0ZsY2Yv?=
 =?utf-8?B?U0dvOXdUbVRNc01qKzZYcWF1U0w4TzYxcnV6TERhbWgycFhaSlF3dDJCRGNv?=
 =?utf-8?B?TG9BOXIyVVFaNENuRFR6LzhEVEdPNnF2ZkVvQVdybURvNVM3eS9kcDJiS0pH?=
 =?utf-8?B?UVAyVkpOaXNZbmtoNGlFc0R1dUppKzdwdzZGRkFhRTg5NjRLRGVBUVlTUm5Z?=
 =?utf-8?B?d0oyRENPbjVRR2xsZ05OazVQS0t4MDNES2tJajJhY3B4aVg5YUVMMkZzNE9k?=
 =?utf-8?B?VGlSc280aU5zUnQ5Qk16M1paMmRrRitQeFdiMDl6ZzFFV1U2QXVid2E1d1BP?=
 =?utf-8?B?aFg2ZmZZZVR2SjMvWDNsbmNmOVRoUld0U1RDb2ZLZXRvekpMOXZibXpnajRu?=
 =?utf-8?B?SlR0blRpTFRrNUhSSHlYZk10K2ltdVVtclhSUkFHeGVVQ3JMTTFzMlkxdi8z?=
 =?utf-8?B?MUcvYm1SakNTVm5PMHIwblZnYXFhcWR0OG43NXl2d0t5UUpENDJ3c3hSSC9a?=
 =?utf-8?B?Ui82UjhQT1FLNnZ2RVhHekhnRjc5UTI3ZGZCVXd3bUJaakMvdVdBM2R1eDVE?=
 =?utf-8?B?T056SjdjL2tWc0NCb0VqUHJGbndRNmtibW1tVmtsbHdYMGpBZmQwZXhld1kr?=
 =?utf-8?B?SWNVSTVkSlhPWGhERjlsRlM5NVBPdXQydW4vZGRwR2J1RjZKZlFZRkljbHN0?=
 =?utf-8?B?cmFpVFlTdWNlaFpFMGo5Q2ZUWFRiZHJTRkQ3dUhENXQzNUVFR1Bkb1FFSjY4?=
 =?utf-8?B?ZlZlUWdtVTBxM1k0dWZRUzh2YWFmTTFiWFVqV1lmQTlZeFM1UUZkQT09?=
X-Exchange-RoutingPolicyChecked: rEQejKNYPAe5ZH+zTpV34zSRv7IRCH8C2fZD/izfsovKIMRvll/OyZPG9SrW4QXuMsSFvudLY4XRWdW43+W1iFhc9TfXjwu4enZ6VIqtXZZJ2R5iG2pG2NHoXYSMoAt512JACMBCSAr1iGFyamcVtZ0ermfbtFWzyQYEYsAS+XEz+WFTPfyKWs3sWB5/bs1qJDRDBp5l1kGrdi+yNysh5tso8Vz2FvZrZ2+JzSTbl5xRCm7416FhrdWZQK116sQPEn27YqyXwBTAD1ln5B/WiMQoS3cRd3v37d0AFdU2GUfv4FfpDd/JYGpz0SYjzvGayLCiVNsnpp2mDD6ktRqAKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb00847-d4be-44ae-2356-08dee8c7cdea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:36:38.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6tTIRoZLcRNSJYWUpidu2YmFVINBJ44ruoco6C0VUtbZwPMVWw9qCCctCX/JZU/vcxeTKcTujYw2GGiTIkiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9477
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


@Rodrigo The sashiko comments are resolved and has been tested with 
multiple namespaces using docker.
Sashiko review is now clear with a pre-existing issue that is being 
fixed in another patch
[PATCH v5 1/5] drm/ras: Cancel and free message on get counter failure - 
Raag Jadav

<https://lore.kernel.org/intel-xe/20260722034228.662746-2-raag.jadav@intel.com/>Let 
me know if this looks good

Thanks
Riana

On 22-07-2026 15:11, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-report' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
>
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-report' to receive 'error-event'
> notifications.
>
> Usage:
>
> $ sudo ynl --family drm_ras --subscribe error-report
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: remove redundant initialization
>      remove unnecessary space
>      use ynl in commit message and doc (Raag)
>      simplify doc for error-event attrs
>
> v3: rename error-notify to error-report
>      Replace notify with report across the file (Raag)
>
> v4: send event to all network namespaces (Sashiko)
>      remove has_listeners check
>
> v5: add context in function for choosing GFP_KERNEL (Sashiko)
>      add additional checks for node registration, range checks (Raag)
> ---
>   Documentation/gpu/drm-ras.rst            |  21 +++++
>   Documentation/netlink/specs/drm_ras.yaml |  48 +++++++++++
>   drivers/gpu/drm/drm_ras.c                | 101 +++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             |   6 ++
>   drivers/gpu/drm/drm_ras_nl.h             |   4 +
>   include/drm/drm_ras.h                    |   5 ++
>   include/uapi/drm/drm_ras.h               |  15 ++++
>   7 files changed, 200 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 83c21853b74b..406e4c49bac1 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -56,6 +56,7 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
>   
>   YAML-based Interface
>   --------------------
> @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
>   
>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>       None
> +
> +Example: Subscribe to ``error-report`` multicast group
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --output-json --subscribe error-report
> +
> +.. code-block:: json
> +
> +    {
> +        "name": "error-event",
> +        "msg": {
> +            "device-name": "0000:03:00.0",
> +            "node-id": 1,
> +            "node-name": "uncorrectable-errors",
> +            "error-id": 1,
> +            "error-name": "error_name1",
> +            "error-value": 1
> +        }
> +    }
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..8aed3d4515e5 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,33 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the requested error counter.
> +  -
> +    name: error-event-attrs
> +    attributes:
> +      -
> +        name: device-name
> +        type: string
> +        doc: Device (PCI BDF, UUID) that reported the error.
> +      -
> +        name: node-id
> +        type: u32
> +        doc: ID of the node that reported the error.
> +      -
> +        name: node-name
> +        type: string
> +        doc: Name of the node that reported the error.
> +      -
> +        name: error-id
> +        type: u32
> +        doc: ID of the error counter.
> +      -
> +        name: error-name
> +        type: string
> +        doc: Name of the error.
> +      -
> +        name: error-value
> +        type: u32
> +        doc: Current value of the error counter.
>   
>   operations:
>     list:
> @@ -124,3 +151,24 @@ operations:
>         do:
>           request:
>             attributes: *id-attrs
> +    -
> +      name: error-event
> +      doc: >-
> +           Report an error event to userspace.
> +           The event includes the device, node and error information
> +           of the error that triggered the event.
> +      attribute-set: error-event-attrs
> +      mcgrp: error-report
> +      event:
> +        attributes:
> +          - device-name
> +          - node-id
> +          - node-name
> +          - error-id
> +          - error-name
> +          - error-value
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: error-report
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394..39155fb514de 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,11 @@
>    *    Userspace must provide Node ID, Error ID.
>    *    Clears specific error counter of a node if supported.
>    *
> + * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
> + *
> + * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
> + *    and error information that triggered the event.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>   			   value);
>   }
>   
> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
> +				     u32 error_id, const char *error_name, u32 value)
> +{
> +	int ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
> +}
> +
>   static int doit_reply_value(struct genl_info *info, u32 node_id,
>   			    u32 error_id)
>   {
> @@ -222,6 +255,74 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   	return genlmsg_reply(msg, info);
>   }
>   
> +/**
> + * drm_ras_nl_error_event() - Report an error event
> + * @node: Node structure
> + * @error_id: ID of the error
> + * @error_name: Name of the error
> + * @value: Value of the error counter
> + *
> + * Report an error-event to userspace using the error-report multicast group.
> + *
> + * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
> + *          netns, which is unbounded work; callers in interrupt handlers
> + *          or other atomic context must defer event.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> +			   u32 value)
> +{
> +	struct genl_info info;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	int ret;
> +
> +	if (!node || !error_name)
> +		return -EINVAL;
> +
> +	/* Check the node is currently registered */
> +	if (xa_load(&drm_ras_xa, node->id) != node)
> +		return -ENOENT;
> +
> +	/* Currently only Error Counter events are supported */
> +	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> +		return -EOPNOTSUPP;
> +
> +	/* Check the error ID is within the valid range */
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, &info);
> +	if (!hdr) {
> +		ret = -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast_allns(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT);
> +
> +	return 0;
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_ras_nl_error_event);
> +
>   /**
>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>    * @skb: Netlink message buffer
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..9d3123cc9f9c 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	},
>   };
>   
> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> +	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
> +};
> +
>   struct genl_family drm_ras_nl_family __ro_after_init = {
>   	.name		= DRM_RAS_FAMILY_NAME,
>   	.version	= DRM_RAS_FAMILY_VERSION,
> @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
>   	.module		= THIS_MODULE,
>   	.split_ops	= drm_ras_nl_ops,
>   	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
> +	.mcgrps		= drm_ras_nl_mcgrps,
> +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
>   };
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..03ec275aca92 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   					struct genl_info *info);
>   
> +enum {
> +	DRM_RAS_NLGRP_ERROR_REPORT,
> +};
> +
>   extern struct genl_family drm_ras_nl_family;
>   
>   #endif /* _LINUX_DRM_RAS_GEN_H */
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 0beede3ddc4e..ee2caa0edc6f 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -80,9 +80,14 @@ struct drm_device;
>   #if IS_ENABLED(CONFIG_DRM_RAS)
>   int drm_ras_node_register(struct drm_ras_node *node);
>   void drm_ras_node_unregister(struct drm_ras_node *node);
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> +			   u32 value);
>   #else
>   static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
>   static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
> +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
> +					 const char *error_name, u32 value)
> +{ return 0; }
>   #endif
>   
>   #endif
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..eab8231aa87c 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -38,13 +38,28 @@ enum {
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>   };
>   
> +enum {
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
> +
> +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> +};
> +
>   enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_ERROR_EVENT,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>   };
>   
> +#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
> +
>   #endif /* _UAPI_LINUX_DRM_RAS_H */
