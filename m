Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640BCC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5CF10F353;
	Thu, 13 Aug 2026 13:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PgtBFc+F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4669910F339;
 Thu, 13 Aug 2026 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786628677; x=1818164677;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=PRMwe0soJEjpvub1AUr93tv0pG11EpfvkzR6c0luHcc=;
 b=PgtBFc+F/w2E6Ye8EltEVNZIEL4z0wu9mQnuL5W76DSmsgwPaHW65Hz6
 3woHuaNf8zKa901AhRntTaT5xaXdXW9IhHSDLEBfctbYJl++b7acB4k+D
 Mc+4O5blSFMwlEez/Uc+7JOEZohyt64WBNOF0Q5xW+cudjcNfIHM+0BOW
 m7Mu1Rfw3DaZp98oBjk/f7sNrbLpVNxKhRwj2FoMDueeeMNl58HhlXZYZ
 lzsALqO3DQAtJTZ10HY7S5iedhu3QaBazyy30jrSUlkXqv4TGra4NxkXS
 wLF5L0e+f2vZy6w5DHEiOlvZfub/f3gviB23gH/BWpRaLg5fW6737Dja/ Q==;
X-CSE-ConnectionGUID: ioDN+60pTd+mnIDmPom2yQ==
X-CSE-MsgGUID: lH5GjIOcQsKtjcbXhvavMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87275822"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87275822"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:44:33 -0700
X-CSE-ConnectionGUID: NBpYhKlERSmcSVGQ2O7Yog==
X-CSE-MsgGUID: /wyzA+ebR1eowShHAXuJBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="257722543"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:44:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:44:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:44:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKoyZz/xSYFuN5VrR/jYdoVlJZHERPctoWhzEQf0M3r3ji520NXgPEpadMSYbwnE2crqopOR0+AesbQiScohezQ2iuxKjL1aCPfJbJ+i9GsCJ7OebNkmMVspUt3yZQMj1JDoBUXqOgdU6w/da7111ARvlNpb2WMwNoRKaAob5val50cLgvdQ49lG1cy9adC1esVql20rIQiZpvfp7EJIUfcV0W+78KsM/1LBqnYYFHV43wb5DF7UhPMQ2o7kowjEMw1Jc07NHxyHd2jNgmsXSs+xE8RAbAivy04lg/sQzlM8SQXgCMXxVeahpRz57yssofj6DkGZIDh4UCLivWNHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7flMM4b2y7PFSn4rK4dVtoDs2+KhG0pzzkLzYiwgTU=;
 b=bqdkYV3rXXUIYkwTzWYQnDbqx2uccf+5epl4MZOy8BAGUSCCCVzRyS48VSzP2IfbdKEaHFPnpTFoeun+t3U1tlZ5dgIzSQvH5WeRKplZbGcmSqSrfgNhcY/csrn8DjZmlVBhC0fhxb/XTfq2HS7Hpb+IreWspi8gfPytRH+xz3CSVrVBTtb8hpxyafSQzsWeu6fdDxmSkDVhAKmhxag5JI4weCCPyHIjuOqSnzNySBO973YvedNPZD5sQcs2OkW7Oyefnzj4meRVWfs7bWWPJbaTbvK7xLcQnwzGjs9q7Uvc3NxWvx2v1ErxcylEf7ufh6zUmO7M3h681TAQ26eZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:44:27 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:44:26 +0000
Date: Thu, 13 Aug 2026 09:44:22 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
Subject: Re: [PATCH v13 0/4] Introduce cold reset recovery method
Message-ID: <an3KNgWyfgxy_8Yd@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CH3PR11MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b601a0d-cfc1-4bc2-12f7-08def940fdf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gLURPqGaU/41/VS1j4Z4aDqef23gJf2/vym273UtqJqOnym0H7LZCO/Axv8VDEI8vQf6nCW0qeFc6enWx6U/+6Pr1k0jR2HypuMkI4p2LvHl6HkEyofNbxf24WP2r+9VFya2sXP1gmnBGIEu32i30gAJPXhshHXRE5c4hT2U5DHyGSMn8pgdbdIMQHe9vHBNRYX/jC2yjFxQEB9YOppdjjlGPdjgcUNiLP7bEqlxH9IfkVuDUKq1Nw3iRiDTz/hpRtf4/EjGJFgPSZsnUqmN6fOwm2J2iBEd0EStHF7QSgMbCOrYi6QnxfuAZLs0gmR1I/Fs9ExAHufZ77peZ0PYvhy4vGHIMuMUEEHh56q+YtYEj/NhJEYuu+eTYYzsE0p9O/vw8vg0WW/WRrvQpkGz4iWIkXZd3m6vdQ7QsB9wxIhNMj46g/MwobiDKBocBgC+L0fOnHBb3JxrbIWaLSCJDVW04Gp9rX7ZWbcOC3fRfF2e1nZMt/TBpz9S9rkcWn7kwN9adK6OX1sM7StOYGk0wnDIwzWBmCJLdG4iNcdKwkEmPTfxkSnMnKLafX/JhyvxWQWd1VOvunTALCyCjRlmVeBVzLzmSCICBA4uR7FVHv0pgH3tLp174IIkb0bMglUVZx09BFpH8efSDNIsp6odj7isTjEdcalwZFmONTnYlWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?C2vw1k++qsFloxJUQRF5/PzS7DK6PkJG9xhd6FrDzP2H0p6S/XQv57Z5Cp?=
 =?iso-8859-1?Q?QvptQvHDU00m0FzfDMYC8+YjRugFG8tAkjXIPXrU6lwdVspAKQcvIL0FjV?=
 =?iso-8859-1?Q?OGjw+KdQNrHQdjaCVy4HTgU76Tk6FSC/o/9uivpOa5XGE03jAF9YA86hM/?=
 =?iso-8859-1?Q?bALlNtdiOEVeBY5NWYUtiBvqLP/kbyrLX+CRe8kimFuYzY/tAq1xdsgK3+?=
 =?iso-8859-1?Q?4VKUyNiD9n48txvAiw3gslZUNCZ4gXQprOjaWxyb9luKKOWAJ99MRTuaJ6?=
 =?iso-8859-1?Q?YRFAeCR6aDrICGMyO3ITh0PC0htJtfZ+Diy8U5jIE9gKEn3QG5ftFv6HU1?=
 =?iso-8859-1?Q?U7BGn65ln9cCZK94YYGCKeqmJAlV70ZzP72GZH+AyhpZXFNt/q3It8WWXk?=
 =?iso-8859-1?Q?QuMC9/ZlCZiIAwBXBgPl32XkjIK+MHWJlb1oUwMh457MqC/ePWFaMUMRsr?=
 =?iso-8859-1?Q?uHNube0H9Vy2xJociafT6RMl65Sov6Uh7by3QILjLoleT+/FVKGiz+mhiX?=
 =?iso-8859-1?Q?1+kBSlIBK0nscjV1+XJH6P74dLkKbcMpiMMlSbak7iEtUT8YjPtnw9AXuK?=
 =?iso-8859-1?Q?appf2j1hM1bxoleRyfLXhl6Px6fOv0asypXKzBd7xKm+gC6wO6akCa28Ut?=
 =?iso-8859-1?Q?nSzFBNvzQ/oOU6Y1AWqxy3b0oOTWtrWj1uQFERHUg0rfAVSi7SL/lHk/i7?=
 =?iso-8859-1?Q?woiPHC0whx2dyJt65lVQk8KwpxveXNNEihfxQMME4MqGgBtQ+DUkWtSAqP?=
 =?iso-8859-1?Q?QV/KR+Z0idepgyPOyaK21FhzUpCtHprmtUgYUSeQ38JW3Q+J2YgfXnS0gl?=
 =?iso-8859-1?Q?8aWirGSMbJiGEyI+9Ch8mtc6/E9xiwp2My3BiySVqSb0YbnqzpUQENWkUu?=
 =?iso-8859-1?Q?LQtXXJkL21Vo8nXmMDLSaC0SaqP0I6Bc+ID2dW/RW2xuQ6hyroiNlvAaPb?=
 =?iso-8859-1?Q?eMQWVulBtoFlSJdaGKGrES52e2NMF/tJ7DU/bQoGM9gVrQz8s9erJw3pYz?=
 =?iso-8859-1?Q?ZClU/NOE6haOij0hWTwVIFGzivO5awM14CxOb0lcfy8bADvRZXDqxKJMNu?=
 =?iso-8859-1?Q?9IWIvNBfITtgB8KFTdbsj/YG6LK2BnJyoZ3wxwPtDbh7/mX+0OHDk/LsMk?=
 =?iso-8859-1?Q?xmf7jWRkfpsPiKD/EpU5rDKd8mWxWqVS/XM/g+KloO/AM8Sa7hv0cHRNf/?=
 =?iso-8859-1?Q?zI6YWHl/SCW9WAfa12G/MipUIs1tM6tUHeRn2O8hLuChAklFgel/957q2k?=
 =?iso-8859-1?Q?VzQETEfI0qTn8Xyf1NblL4fVVuLPHHm3S+vKkkHQ8nEBWJlAjd4bW+1ZpY?=
 =?iso-8859-1?Q?SzouVHypTKeSJQ7s7t631NR69evhtedzWbicyKb0dgLtBbu3XbjK/lWj+W?=
 =?iso-8859-1?Q?C56XYA2vhha7SUHhfaACQvOsCw+4nY4vGRbLeEveLeKAK/4Oi5G5tIMHsg?=
 =?iso-8859-1?Q?QwvEKoLqRF2LdY/Gk9A6sC7AL53ynVNo5J8kSOnHVxCsUVIfuHTJSKxoBO?=
 =?iso-8859-1?Q?Kvetr3FzTLZgoAYlxLLoTn7QoNCXCAuX32V2ilheAd/a0y167FFU7O54of?=
 =?iso-8859-1?Q?WUXeGSgi0XvtcVBix3niKU8SebYaZeuvbWDVVMlwHLXXzw+9HU2zguhKzJ?=
 =?iso-8859-1?Q?D6v2omvlSpxWaAus4FFoE/hl1/7JWV31bkEYIOT86/kTdrG2WxdzyQH2ZJ?=
 =?iso-8859-1?Q?RyH/fGQ5YyNDmCS/yqUDLgsTlsFMUi4wUY4kIeMC3bNOphUltGJyCO08ZF?=
 =?iso-8859-1?Q?S+HEpA9STSH7qghYkBTK2k16QpGYXTcK5bPlg8EHdhO7wwtlHSc4ba0Gwi?=
 =?iso-8859-1?Q?y6lki6Ze2g=3D=3D?=
X-Exchange-RoutingPolicyChecked: A+ZoqsTxE55+a8ugxK8ONLrgspiM9/6GtbyXMV96Os5L7lBEWkFYYLaevRsEzmEDSl7NaEOWiIZXfP0WIKWG+OOe/9+gs0h+xZbYn1k+00Siv2ZWXt40B1PoGCwMBOswLR21P4xjLN4G1n3J3qO2wSJMNdnNBjORDoQU/SqrzFXArJX6K+IWZxZkWpmXVLnaQa1He/QaW6hi7a8tuNknQJ0F40o+8k4KkMMGl9xIkK3UunNILR1BXvEuHhU92NdEPuYMSZp4ew4jk5xIlYdn2dkmHFFGu59ccPGrpWrrbH3HfkTM87KPbhiSwGg0kmaDCGY2hQKysj8wQNoRAuxpsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b601a0d-cfc1-4bc2-12f7-08def940fdf0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:44:26.9347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZPAfqewNEbxix7zofzT1OPeSHp0XIa1/aLhWFm97zKJ+2oMxEmX6APdvAWOoXlcsWWQWGQda+oEaJQ6OWT52w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
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

On Wed, Aug 05, 2026 at 12:41:53PM +0530, Mallesh Koujalagi wrote:
> Add support for handling errors that require a complete
> device power cycle (cold reset) to recover.
> 
> Certain error conditions leave the device in a persistent hardware
> error state that cannot be cleared through existing recovery mechanisms
> such as driver reload or PCIe reset. In these cases, functionality can
> only be restored by performing a cold reset.
> 
> To support this, the series introduces a new DRM wedging recovery
> method, DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)). When a device is wedged
> with this method, the DRM core notifies userspace via a uevent that a cold
> reset is required. This allows userspace to take appropriate action to
> power-cycle the device.
> 
> Example uevent received:
>   SUBSYSTEM=drm
>   WEDGED=cold-reset
>   DEVPATH=/devices/.../drm/card0
> 
> v2:
> - Add use case: Handling errors from power management unit,
>   which requires a complete power cycle to
>   recover. (Christian)
> - Add several instead of number to avoid update. (Jani)
> 
> v3:
> - Update any scenario that requires cold-reset. (Riana)
> - Update document with generic scenario. (Riana)
> - Consistent with terminology. (Raag)
> - Remove already covered information.
> - Use PUNIT instead of PMU. (Riana)
> - Use consistent wordingi.
> - Remove log. (Raag)
> 
> v4:
> - Rename cold reset to power cyclce. (Raag)
> - Update doc. (Raag/Riana)
> - Change commit message. (Raag)
> - Make function static. (Raag)
> 
> v5:
> - Make it consistent with consumer expectations. (Raag)
> - Update commit message.
> - Remove unbind.
> - Simplify cold-reset script.
> - Remove kdoc for static function.
> - Remove xe_ prefix for static function.
> 
> v6:
> - Drop "last resort" wording. (Riana)
> - Look up the hotplug slot in DEVPATH instead of scanning
>   every PCI slot on the system. (Raag)
> - Drop arbitrary sleep values from the example script.
> - Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
> - Check Slot Implemented bit before reading Slot Capabilities, per
>   PCIe spec. (Riana)
> - Add debug log.
> 
> v7:
> - Update recovery script. (Raag)
> - Handle surprise link down event properly. (Aravind/Riana)
> - Update commit message. (Riana)
> - Correct log message.
> 
> v8:
> - Add rescan instead of reset. (Raag)
> - Use find_usp_dev() in punit_error_handler() function.
> 
> v9:
> - Remove unwanted header. (Sashiko)
> - Removed #ifdef CONFIG_PCIEAER. (Riana)
> - Used pci_find_ext_capability() instead of usp->aer_cap.
> - Clear the PCI_ERR_UNC_SURPDN status bit (W1C) after
>   reset complete. (Lukas Wunner)
> - Use pci_clear_and_set_config_dword() helper.
> 
> v10:
> - Rebase.
> - Fix column width. (Sashiko)
> 
> v11:
> - Make udev rules in single line. (Sashiko)
> 
> v12:
> - Trigger punit handler using fault-inject.
> 
> v13:
> - Rebase.
> - Rename inject_punit_error to wedge_cold_reset. (Riana)
> - Sashiko corner case issue addressed with
>   commit 20bc4883c7c0 ("drm/xe/ras: Fix boot-time ras error processing").

pushed to drm-xe-next, thanks for the patch, reviews and acks

> 
> Cc: André Almeida <andrealmeid@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Mallesh Koujalagi (4):
>   drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
>   drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
>   drm/xe: Handle PUNIT errors by requesting cold-reset recovery
>   drm/xe/ras: Use fault-inject to trigger cold-reset wedge
> 
>  Documentation/gpu/drm-uapi.rst  | 93 +++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/drm_drv.c       |  2 +
>  drivers/gpu/drm/xe/xe_debugfs.c |  4 ++
>  drivers/gpu/drm/xe/xe_debugfs.h |  2 +
>  drivers/gpu/drm/xe/xe_ras.c     | 15 +++++-
>  include/drm/drm_device.h        |  1 +
>  6 files changed, 111 insertions(+), 6 deletions(-)
> 
> -- 
> 2.48.1
> 
