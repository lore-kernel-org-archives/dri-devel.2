Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2DBC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DFD10E328;
	Mon, 31 Aug 2026 18:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KC9NdzN8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040FD10E328;
 Mon, 31 Aug 2026 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788199800; x=1819735800;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=OUGgSm4EPa5n58sj7Aey9ZfZcxvYocF6bLoFMx4belg=;
 b=KC9NdzN8K65OKcNkInroKzRdYszY+pgkjz5RryuY7TvHMy0fO9fYhOEa
 nE8av588MOoB6DbqtEBzue0x9qTpQUmPL5AXWvENlniAPv27Bv482cXuo
 NqxcIKviOKdGiC0WyEuJAXdtPNq30tmoYzex07SaL+ccoroiXOd/8qGN7
 Dhc8W2ui/UxXEXgxmUS6+QRccAm1U9lH0Rn/UZNeSCdA3APNIqGnYQ00P
 i1M6qD7R607gq36gwLHtNqWOGeQ5WMHlG6O+VL+AI7iKXru851wNhK8pD
 u8hYDfBCnur4Vaq3XjOUWtI4di3ZbqKU2H8yLeYsK0B5Tv7v24hfieyON A==;
X-CSE-ConnectionGUID: rzSzSIC4To+jUn6UCLKUQA==
X-CSE-MsgGUID: GbWQc1FQQku/brutKCFxvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88542316"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88542316"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 11:10:00 -0700
X-CSE-ConnectionGUID: Zcgtv8zUQq6BzOzr0fyKKA==
X-CSE-MsgGUID: bUZxZOqkRh+2+dIREqUlCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="270780656"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 11:09:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 11:09:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 11:09:58 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 11:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GInqcVuGNnMoBtai5ewmWMHY/zXidE1qw7ZXhIJoKcehMym6tkzAItdP3VhIrw1j+2VF+MGxYodgBQ5KXP6kTBbyfsHl7Af6jhzZhDzVaVSRkzKPxWnB8ph0AtQDcYYc4H/EnR2KHKcdu4ilq7tXHRcoIyUrVQIeovYg7hMMKCa3dP85g7lcxZ2Dp6KZUpM/VEKlm/uMA8R4Q4V1/+3554BSPKY3ibj754c5pDoAdCh9xWb1WyHctqYyHdbtKh8iLQIUrhYEmnRUo9j35mwP6jp17mi9CGRf3oaHnW+OfsJp/b67kg8nGE6u/e+I+DaUDNlHqS+XT2plwJpeCQO+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpj/EAuWzHSdvEe+C27iOYzPKJ32hDfeItAAhMHq8oM=;
 b=jVD6EeDbdHV9F+IRIks161Zmf/XBwx3NKxBCOgOj58c87WZfGiO/sfLsaZfHauKr44WLvwWM6Tgt1jPrD5JXhwaoP8tLghruu1IQEsaHjXgVWNti2/qL3HgPSA9kXYGYwn9komaqtDE/NboD2jV8XjVg7lAj3yuxAg3PW6Zfnneg5/yEjAtR0nNB0aySGzhkXfeQ2ZIV6ok841Fyevidsj5h6C8jjHXtLbLUMDaAEqMCiu0z8W0WThydiR4EHim+zzHyZhwz9Q7I2DKWCRHBr4KiA5ItyNMJXJ0pmK6WbpIkyVf8xCE9MyUAwSc1SPJYX0iYbE423O/2lYkXP2d7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:09:54 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:09:54 +0000
Date: Mon, 31 Aug 2026 14:09:47 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Jinzhou Su <jinzhou.su@amd.com>, Ce Sun
 <cesun102@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Raag
 Jadav" <raag.jadav@intel.com>, Joshua Santhosh Ranjan
 <joshua.santosh.ranjan@intel.com>, Ashwin Kumar Kulkarni
 <ashwin.kumar.kulkarni@intel.com>, Pratik Bari <pratik.bari@intel.com>
Subject: Re: [RFC] drm/xe: Expose retired VRAM pages via drm-ras
Message-ID: <apXDa759PsTggOK5@intel.com>
References: <20260831133843.1076705-1-aravind.iddamsetty@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831133843.1076705-1-aravind.iddamsetty@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|LV2PR11MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5a8042-eeb6-472c-acb8-08df078b0f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|921020|22082099003|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 2gvJbdN2JKiwcaUb+WmOeWisYZqp/CyBH70Pr5frPcydJkJlfMkP9WP7hs7PlORbfZsMhaUcvlDoNxCbMYXazBxMFoH0Jb96veieHa1ZP9y2HR50+ACUUEDDRZaigw4yiIJlC/wKK5V+6KjadkgQ+BHyPnBbjE+f5xz/1MHHU3r51SebHpQQ4Fq3scwdsvSoeyEQPYtAlyYr3djaRoaHnDNVGsR2BflsTZuaAb188Ij99+tbwf1fM/eRrC4LpZokDBxIeHqJ6bgyuzhIRoiOTQNnkK2bEwzc6SsIdhb+/ti1zT6LV1g0vJcrvEFCmKOPKHISnn5LxYhcke0sV0Jsz8OdcV1VzhaiNNUkqZon8O8m7/FxjQEu45lUsgD2jektdUEdTeBse3/XY+xPoLLfu+n86sHdTVzfppq88bSwra16GKLRwirySmZrHtTH4O6TRuCqb4ZuEHDPwmWcJ8YrdjHl6o9KOeeWprgPlF/vIlsfRdKId2JeqLfkzRczvHD5PKIqdzlRgEycksDJnX26oiwbka6KaGTouusIv8xalzZmygjfD2HFes9A/o/FhkqOdLenclam3hJPtQtHm+AZafdrn3DGU7oOScHpimlnpKHRNNs1yZ/FlSx+BDRuXNs7BLgXjgT6EGDSqCpXSJjZawviTyJPuRpPt4BLGdXsquZ3/MQkbPq4qsuYSwtEC2PHKDytoN60q+6YfsFw24r/bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlXbUZia2h3OFdzZWNzTGFMK0xMbmRIQzlWN2JxbTN6WmNjUkdCQk8yYTR4?=
 =?utf-8?B?SHExeDhtREErRFJGMmNMN2w1eE55enlMQmdLd2o1RGJBS0ZjNVVIRnZxaFZj?=
 =?utf-8?B?WndPWmprSTdXcDAzY0JJKzFESGMvRnYyZlhIWk13am15ODRrNXVKazFtVVJX?=
 =?utf-8?B?M20zZkZwV1VlWHJGWFBtbVlkNURrZ1N1dVFuOHhaV3V3d2lRQitBR2ZOb3pl?=
 =?utf-8?B?RzZucW82cDNOempEYlFjWlBLWjVRKzMrQU5rcCtMb0h4K2RkSS9UVmFrNzZS?=
 =?utf-8?B?Lzl2aWpkSjRIVENSSVBlTlp0UW5NMjFrQ2xzVnF5dmhONXdxMlQwVVVXR1d5?=
 =?utf-8?B?YXpESFQrVzVDdUVpa1pkZFM1UGdJOUVMREtwT1dESUY4anlDeHFwWlNXdDhX?=
 =?utf-8?B?Y01lMWVPTkhjUlFzRzB6aDlpamhoRGhVaVZtdEpzdldCc25NSU13aExLbFND?=
 =?utf-8?B?YUd4RHo5NVMvRklNZ0xRV1R2U2lmaGZWQnpnNWdIUkxJOEEvR2RrcEE3ZTlk?=
 =?utf-8?B?N3ArN01QWVZia2EyV2NXR0V2bWI3MnhQdmlZb3FDbDFKMTBYclZIT2V0aFlo?=
 =?utf-8?B?QjJCeU51R1dYNDFiKzgrM2dUbThMdnZvR2FtSmVvajlONGtnRzByT2IxV2hG?=
 =?utf-8?B?eDJKbHliTUJEaUdqZE5HZVV1dkJhVWxMd1JJMzh3aXRYZlljTnZIZFBJY25w?=
 =?utf-8?B?K2lKbGJwTStVQ2J6MjNTVXI1ZVQ1RTV4dU8xSVR1Tm9Xbm5FT2Y5OWpTbWtI?=
 =?utf-8?B?aXE3Q2Q2Wjc4aGJDN2ZLR1NIL3BDd2RCbW44NXZEbllqYlROWjdpcWZzUXM2?=
 =?utf-8?B?SFhXNkp2clZQUkVZODRVelo3Zmo1cG95SXJkRFBES2JUdGZ0VHNOYUROaU9u?=
 =?utf-8?B?WE1aOTltQlBKd1lKbWJ3T0h1eGw3NFBuUkF6ZW5tYVRhS3JFQ2ZxcE1KRGt2?=
 =?utf-8?B?Q0VyM1pmclB3ZERkZHRhSmxLNkt6VWFDQW1oYTByQTh3TVp2bVhxdTBTUVlU?=
 =?utf-8?B?Y0hFYWV3WWQ1amZCelExU1VOSndXeFRkTWJJWGUwZHVZM2lON2I3cURqQ0lC?=
 =?utf-8?B?c1hyRDRJOVlTZjlMM2xET0JoY2J3UjhwdDk2K3J1UUpXSHE4aDVzazdXaTVE?=
 =?utf-8?B?VFhnd2M1ditIRVZFV2NqRUZVbmt1azhqN0JibWJwdk5aS0M3TU1KdFRzdTZ6?=
 =?utf-8?B?Nm1WQ2E2cm9oZDh2VGhSZDlQNG1rWWozMDg2RGl4RXFsd1VXSFBCM2RGK095?=
 =?utf-8?B?QUsxUXV3alRhQ1lkUy9vdGZwK1hTMHgwa1BzaGdIZWE5ZU9YbE1WM29hN1Qx?=
 =?utf-8?B?dGVVNU9jU3JSN0pOeEEvUGdveG90WHFrdkUwTzhib2o5bWVLZFNVbjZnaXo0?=
 =?utf-8?B?ajlMd3ByZDVOYUVzSVRoa0RIMFBkaDgzZGRrazRzcEQzWjZXaWV2TUh2a291?=
 =?utf-8?B?bkVaREFLQjZPNHJJSDhXZVNKL25PaTJLRThROG1PVGt6Z2d0c1pKL0NNT2g2?=
 =?utf-8?B?aHBBcWU2YVhjOWtXVzRGdG5ZelBsdUJwSkxtNFM3ZmpGbk9LQ0RsZzRmSmNl?=
 =?utf-8?B?dUlQbTJNWGFVODhBYjExaEZxelJVSm9nYVJlLzUvMXB4NmQ2c3NWaVJPdkNn?=
 =?utf-8?B?bFNucDhkMnhDRDVIbkREUmdIeTY0SjRxcWU4elo3WUxYRlZXVUpVa0lGdmR5?=
 =?utf-8?B?MHBvZlZHZXJXVUpMWGY1T0MvdC9qeVRFYnBRYVZaZWkwaXQ1ZW9rTEVFRWE2?=
 =?utf-8?B?TmhRMnUvekNlUERNbFRJV2hJSTgxbzhrUzVXUS9zam53RHBlUVVXdm11R0FQ?=
 =?utf-8?B?V2Z6dVVLcDg4UkJzUmZaYjhOQU1mRE1Dc0FwTVR2dW92d3lxR0trbzlJQjNO?=
 =?utf-8?B?N1Q5SmNLZmltWjlPUmlrRmlLbnI2b2pPTlIyTUJGbWYvUTE1bVJRcFh2dGdk?=
 =?utf-8?B?Z0Eyb290ZHlQT0FPMEI1MTYvakNFTnR2c2NyN2JaQWF0c3RwSzkxcjRHbndW?=
 =?utf-8?B?Mjc4dDBEK2s3Zm54Y24xajFJdEFidlY2blhtVTVTU2wxWlU0YUFmTlhPTVJQ?=
 =?utf-8?B?YXlDRnVSYWVpRmFnK21YYW5GSXhnRDFuYkxTRlAzRnMwUnAxOEtyRDRrL1hK?=
 =?utf-8?B?cGdMZGVMZTM0blhEbG9SZUhyZlp0aUJpR2dVUUFISFBrZDFmOUNHalY1L1h0?=
 =?utf-8?B?RkNvcXRGQUozZjcvb2p5V1ZUOW5FL3l3R0dJTVRtK0xhaUJiNVAwODl1N0Vy?=
 =?utf-8?B?Z3BhUWdYZlBRaTJpU0NpaU9kb2NENUhtcjVOamZQUDJiSlA0QU5sckNaVUtk?=
 =?utf-8?B?ME1Cb2s0VTNmTDJGLzh5NW9xejdUQ0RPUWx2NzNaWlg4M2MrRForZz09?=
X-Exchange-RoutingPolicyChecked: hVL93b1XV6op8qztQ37qj+SiXv1MiKAeWVG6nuNGaHGq1F+LggJJx3NaGAzKjaypz539WJeSy/gzZHgTScPntq0KR5LA3AAHpZO1WzSy7MFQDdfSh3xVIH4vPGUUlIv4Pi5D21jlY9m5GOs8u2efHc+md7G+rHtmPi4gcAEjGd4+/NkfrCk3qWlXQVxUmjtIsOCmmo9ERaaxmBuqSqoPt2IWVllP5VcLowpBHuRCqOFUqsx6Xt3AIIr7QRxx1jvqmvev/vaS+7IddwiVFhPifYuYkcIQX6o6X99jfc7oFTZrnfa6YOj4WppSxAw3Ry7g2bBT/U70k/H6pNSztfTreg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5a8042-eeb6-472c-acb8-08df078b0f07
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:09:54.7435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPyRmqSqwecF43dEF6pxtqrjf4ouFAn84OPp6InV59NzS8GEy8GiBrfmSUuWc3GZPS6qlchVCtMpIE7XIst5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
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


Ccing AMD folks...

AMD folks, I understand you have your sysfs for your 'uniras' in
production and already using your sysfs entries. But I would appreciate
if you guys can take a look to this drm-ras proposed API for the
memory page offline RAS related entry. Perhaps this is something that
you might want to align in the future. So, it would be good to design
something that is generic or flexible enough.

On Mon, Aug 31, 2026 at 07:08:43PM +0530, Aravind Iddamsetty wrote:

For a bit of context to AMD folks, I blocked Intel attempt to create
a sysfs for the memory page offlining feature because it was breaking
the sysfs rules and using a mixed fancy formatting.

That solution apparently was inspired by the AMD's gpu_vram_bad_pages
where each record is  0x%08x : 0x%08x : %1s\n  — three different types
with decorative  :  separators. That's the "fancy formatting" clause.
And it's ASCII text stuffed into a binary attribute, so it gets neither
benefit: not parseable as a blob, not compliant as text.

The rule for reference:
Documentation/filesystems/sysfs.rst:

"""
Attributes should be ASCII text files, preferably with only one value per file.
It is noted that it may not be efficient to contain only one value per file, so
it is socially acceptable to express an array of values of the same type.

Mixing types, expressing multiple lines of data, and doing fancy formatting of
data is heavily frowned upon. Doing these things may get you publicly humiliated
and your code rewritten without notice.
"""

> The memory page offlining support tracks bad VRAM pages and currently
> only exposes them through debugfs (vram_bad_pages), which is not a
> stable ABI. Add a proper userspace interface on top of it using the
> drm-ras generic netlink family.

After considering every other API and placement for this infrastructure,
I agree that the drm-ras netlink is the one that aligns better wit the
need of the mem page offline flows and semantics.

But I have a few doubts about some of the choices below.

> 
> Introduce a new node type DRM_RAS_NODE_TYPE_RETIRED_RESOURCES which
> enumerates hardware resources that have been permanently taken out of
> service. The node type is designed to be extensible: each entry carries
> a resource-type discriminator plus a type-specific nested attribute, so
> future resource types can be added without touching existing consumers.
> VRAM pages are the first supported type, reported via the vram-page nest
> as {address, size} with a retirement status
> (retired/pending/failed).

I understand that your goal of creating this retired-resources is to
make this generic and easy to extend.
And this aligns with the goal and original design of the drm-ras itself,
which is be extensible by definition from day 0.

However, I'm afraid that in this case here I couldn't think of other
kind of 'resources' that we would want to 'retire' at runtime. So,
I'm afraid that this is forcing the user-space to go one extra level without
a good reason.

What about a new drm-ras node that is simply 'bad-vram-pages' or even better:
'memory-offline' ?!

> 
> Two operations are added on the node:
>  - GET_RETIRED_RESOURCES: dump the list of retired resources.
>  - GET_RETIRED_RESOURCES_INFO: dump per-type limits and occupancy
>    (max/offlined/queued counts), e.g. the FW-provided maximum number of
>    pages that can be offlined.
> 
> Eg:
> $ sudo ./tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/drm_ras.yaml \
>      --dump list-nodes
> 
> [{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name':'correctable-errors', 'node-type': 'error-counter'},
>  {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name':'uncorrectable-errors', 'node-type': 'error-counter'},
>  {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name':'vram-retired-pages', 'node-type': 'retired-resources'}]
> 
> $ sudo ./tools/net/ynl/pyynl/cli.py --spec \
> Documentation/netlink/specs/drm_ras.yaml  --dump  get-retired-resources \
> --json '{"node-id": 2}'
> 
> [{'node-id': 2, 'status': 'retired', 'type': 'vram-page', 'vram-page': {'address': 12807041024, 'size': 4096}}]

I'm confused here, isn't status such as 'retired' a per-page attribute?
Why isn't it inside the vram-page itself?

$ sudo ynl --dump get-memory-offline --json '{"node-id": 2}'

[{'node-id': 2,
  'page': [{'address': 12807041024, 'size': 4096,  'status': 'offlined'},
           {'address': 12807045120, 'size': 4096,  'status': 'offlined'},
           {'address': 12812345344, 'size': 4096,  'status': 'pending'},
           {'address': 12898765312, 'size': 65536, 'status': 'failed'}]}]


Although I doubt we would get different page sizes here, I believe this is
generic and matches better with AMD's current sysfs needs.


> 
> $ sudo ./tools/net/ynl/pyynl/cli.py --spec \
> Documentation/netlink/specs/drm_ras.yaml  --dump \
> get-retired-resources-info --json '{"node-id": 2}'
> 
> [{'max-count': 100, 'node-id': 2, 'offlined-count': 1, 'queued-count': 0, 'type': 'vram-page'}]
> 
> This change is built on top of and depends on the memory page offline
> patch series [1]
> 
> [1] https://lore.kernel.org/all/20260831064942.315720-17-tejas.upadhyay@intel.com/
> 
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Riana Tauro <riana.tauro@intel.com>
> Cc: Raag Jadav <raag.jadav@intel.com>
> Cc: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>
> Cc: Ashwin Kumar Kulkarni <ashwin.kumar.kulkarni@intel.com>
> Cc: Pratik Bari <pratik.bari@intel.com>
> 
> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Assisted-by: Copilot:claude-opus-4.8
> 
> ---
>  Documentation/netlink/specs/drm_ras.yaml | 131 +++++++++++++-
>  drivers/gpu/drm/drm_ras.c                | 221 ++++++++++++++++++++++-
>  drivers/gpu/drm/drm_ras_nl.c             |  24 +++
>  drivers/gpu/drm/drm_ras_nl.h             |   4 +
>  drivers/gpu/drm/xe/xe_drm_ras.c          |  81 +++++++++
>  drivers/gpu/drm/xe/xe_drm_ras_types.h    |   3 +
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     | 134 ++++++++++++++
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   5 +
>  include/drm/drm_ras.h                    |  87 +++++++++
>  include/uapi/drm/drm_ras.h               |  63 ++++++-
>  10 files changed, 742 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml

Btw, this doesn't apply on recent drm-tip. There were some changes to this spec
merged recently. Please do a v2 in a recent drm-tip/

> index 8aed3d4515e5..37fe297eeb2e 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,11 +16,34 @@ definitions:
>      type: enum
>      name: node-type
>      value-start: 1
> -    entries: [error-counter]
> +    entries: [error-counter, retired-resources]
>      doc: >-
> -         Type of the node. Currently, only error-counter nodes are
> -         supported, which expose reliability counters for a hardware/software
> -         component.
> +         Type of the node.
> +         error-counter nodes expose reliability counters for a
> +         hardware/software component. retired-resources nodes enumerate
> +         hardware resources (e.g. VRAM pages) that have been permanently
> +         taken out of service.
> +  -
> +    type: enum
> +    name: retired-resource-status
> +    value-start: 0
> +    entries: [retired, pending, failed]
> +    doc: >-
> +         Status of a retired resource entry. retired means the resource is
> +         permanently reserved and out of service; pending means retirement is
> +         queued but the reservation is not yet complete; failed means the
> +         reservation failed and the resource may still be in use.
> +  -
> +    type: enum
> +    name: retired-resource-type
> +    value-start: 1
> +    entries: [vram-page]
> +    doc: >-
> +         Type of a retired resource entry. The type selects which type-specific
> +         nested attribute is present. New hardware resource types can be added
> +         here, each carrying its own nested attribute set, without affecting
> +         existing types. vram-page describes a VRAM page by device address and
> +         size.
>  
>  attribute-sets:
>    -
> @@ -96,6 +119,66 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: retired-resource-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this retired resource operation.
> +      -
> +        name: type
> +        type: u32
> +        doc: Type of the retired resource, selects the type-specific nest.
> +        enum: retired-resource-type
> +      -
> +        name: status
> +        type: u32
> +        doc: Retirement status of the resource.
> +        enum: retired-resource-status
> +      -
> +        name: vram-page
> +        type: nest
> +        nested-attributes: vram-page-attrs
> +        doc: Type-specific payload present when type is vram-page.
> +  -
> +    name: vram-page-attrs
> +    attributes:
> +      -
> +        name: address
> +        type: u64
> +        doc: Device address of the retired VRAM page (e.g. DPA).
> +      -
> +        name: size
> +        type: u64
> +        doc: Size of the retired VRAM page in bytes.
> +      -
> +        name: pad
> +        type: pad
> +  -
> +    name: retired-resource-info-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this retired resource info operation.
> +      -
> +        name: type
> +        type: u32
> +        doc: Resource type this info entry describes.
> +        enum: retired-resource-type
> +      -
> +        name: max-count
> +        type: u32
> +        doc: Maximum resources of this type that can be retired.
> +      -
> +        name: offlined-count
> +        type: u32
> +        doc: Resources of this type currently retired and out of service.
> +      -
> +        name: queued-count
> +        type: u32
> +        doc: Resources of this type queued for retirement (pending or failed).
>  
>  operations:
>    list:
> @@ -167,6 +250,46 @@ operations:
>            - error-id
>            - error-name
>            - error-value
> +    -
> +      name: get-retired-resources
> +      doc: >-
> +           Enumerate the resources (e.g. VRAM pages) that a retired-resources
> +           node has taken out of service. Each entry includes a type, a
> +           retirement status and one type-specific nested attribute selected by
> +           the type. User space must obtain the node ID from list-nodes first.
> +      attribute-set: retired-resource-attrs
> +      flags: [admin-perm]
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes:
> +            - node-id
> +            - type
> +            - status
> +            - vram-page
> +    -
> +      name: get-retired-resources-info
> +      doc: >-
> +           Enumerate per-type retired resource limits and current occupancy for
> +           a retired-resources node: for each resource type the node tracks, the
> +           maximum number of resources that can be retired and the current
> +           retired and queued counts. User space must obtain the node ID from
> +           list-nodes first.
> +      attribute-set: retired-resource-info-attrs
> +      flags: [admin-perm]
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes:
> +            - node-id
> +            - type
> +            - max-count
> +            - offlined-count
> +            - queued-count
>  
>  mcast-groups:
>    list:
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 39155fb514de..a708fec7b68f 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -56,7 +56,6 @@
>   * Node type:
>   *
>   * - ERROR_COUNTER:
> - *     + Currently, only error counters are supported.
>   *     + The driver must implement the query_error_counter() callback to provide
>   *       the name and the value of the error counter.
>   *     + The driver must provide a error_counter_range.last value informing the
> @@ -67,6 +66,13 @@
>   *       driver must return -ENOENT to the query_error_counter as an indication
>   *       that the ID should be skipped and not listed in the netlink API.
>   *
> + * - RETIRED_RESOURCES:
> + *     + Enumerates hardware resources (e.g. VRAM pages) permanently taken out
> + *       of service.
> + *     + The driver must implement the query_retired_resource() callback, which
> + *       is called with an incrementing index and returns -ENOENT once the last
> + *       entry has been reported.
> + *
>   * Netlink handlers:
>   *
>   * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> @@ -77,6 +83,9 @@
>   *   operation, fetching a counter value from a specific node.
>   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
>   *   operation, clearing a counter value from a specific node.
> + * - drm_ras_nl_get_retired_resources_dumpit(): Implements the
> + *   GET_RETIRED_RESOURCES dumpit operation, enumerating retired resources of a
> + *   specific node.
>   */
>  
>  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -87,6 +96,8 @@ static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>  struct drm_ras_ctx {
>  	/* Which xarray id to restart the dump from */
>  	unsigned long restart;
> +	/* Ordering-key cursor for retired-resource dumps (inclusive lower bound) */
> +	u64 cursor;
>  };
>  
>  /**
> @@ -456,6 +467,197 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  	return node->clear_error_counter(node, error_id);
>  }
>  
> +static int msg_put_retired_resource(struct sk_buff *skb, u32 node_id,
> +				    const struct drm_ras_retired_resource *res)
> +{
> +	struct nlattr *nest;
> +
> +	if (nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID, node_id) ||
> +	    nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_TYPE, res->type) ||
> +	    nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_STATUS, res->status))
> +		return -EMSGSIZE;
> +
> +	switch (res->type) {
> +	case DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE:
> +		nest = nla_nest_start(skb,
> +				      DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE);
> +		if (!nest)
> +			return -EMSGSIZE;
> +
> +		if (nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS,
> +				      res->vram_page.address,
> +				      DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
> +		    nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
> +				      res->vram_page.size,
> +				      DRM_RAS_A_VRAM_PAGE_ATTRS_PAD)) {
> +			nla_nest_cancel(skb, nest);
> +			return -EMSGSIZE;
> +		}
> +
> +		nla_nest_end(skb, nest);
> +		break;
> +	default:
> +		/* Unknown type: common attributes were still reported. */
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_ras_nl_get_retired_resources_dumpit() - Dump retired resources of a node
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Iterates over all retired resources of a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES
> + * node and appends their attributes to the given netlink message buffer. Each
> + * entry carries a common type and status, plus one type-specific nested
> + * attribute selected by the type. Uses @cb->ctx to store an ordering-key cursor
> + * so multi-part dumps resume by key rather than position, staying correct if
> + * the list changes concurrently between message parts.
> + *
> + * Return: 0 if all entries fit in @skb, number of bytes added to @skb if
> + *          the buffer filled up (requires multi-part continuation), or
> + *          a negative error code on failure.
> + */
> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> +					    struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> +	struct drm_ras_retired_resource res;
> +	struct drm_ras_node *node;
> +	struct nlattr *hdr;
> +	u32 node_id;
> +	u64 cursor;
> +	int ret = 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_RESOURCES ||
> +	    !node->query_retired_resource)
> +		return -ENOENT;
> +
> +	cursor = ctx->cursor;
> +	for (;;) {
> +		memset(&res, 0, sizeof(res));
> +		ret = node->query_retired_resource(node, cursor, &res);
> +		/* -ENOENT marks the end of the list. */
> +		if (ret == -ENOENT) {
> +			ret = 0;
> +			break;
> +		}
> +		if (ret)
> +			return ret;
> +
> +		hdr = genlmsg_iput(skb, info);
> +		if (!hdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = msg_put_retired_resource(skb, node_id, &res);
> +		if (ret) {
> +			genlmsg_cancel(skb, hdr);
> +			break;
> +		}
> +
> +		genlmsg_end(skb, hdr);
> +		/* Advance past this entry; keys are unique. */
> +		cursor = res.key + 1;
> +	}
> +
> +	/* On buffer-full the current entry was not emitted; resume at it. */
> +	if (ret == -EMSGSIZE)
> +		ctx->cursor = cursor;
> +
> +	return ret;
> +}
> +
> +/**
> + * drm_ras_nl_get_retired_resources_info_dumpit() - Dump node retired limits
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Reports per-type limits and current occupancy for a
> + * %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. Each entry carries the resource
> + * type, the maximum number of resources of that type that can be retired, and
> + * the current retired and queued counts. A node that tracks several resource
> + * types reports one entry per type. Uses @cb->ctx to track the next type index
> + * in case the buffer fills up, allowing multi-part dump support.
> + *
> + * Return: 0 if all entries fit in @skb, number of bytes added to @skb if
> + *          the buffer filled up (requires multi-part continuation), or
> + *          a negative error code on failure.
> + */
> +int drm_ras_nl_get_retired_resources_info_dumpit(struct sk_buff *skb,
> +						 struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> +	struct drm_ras_retired_info rinfo;
> +	struct drm_ras_node *node;
> +	struct nlattr *hdr;
> +	u32 node_id, index;
> +	int ret = 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_RESOURCES ||
> +	    !node->query_retired_info)
> +		return -ENOENT;
> +
> +	for (index = ctx->restart; ; index++) {
> +		memset(&rinfo, 0, sizeof(rinfo));
> +		ret = node->query_retired_info(node, index, &rinfo);
> +		/* -ENOENT marks the end of the type list. */
> +		if (ret == -ENOENT) {
> +			ret = 0;
> +			break;
> +		}
> +		if (ret)
> +			return ret;
> +
> +		hdr = genlmsg_iput(skb, info);
> +		if (!hdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		if (nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID,
> +				node_id) ||
> +		    nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_TYPE,
> +				rinfo.type) ||
> +		    nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_MAX_COUNT,
> +				rinfo.max_count) ||
> +		    nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_OFFLINED_COUNT,
> +				rinfo.offlined_count) ||
> +		    nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_QUEUED_COUNT,
> +				rinfo.queued_count)) {
> +			genlmsg_cancel(skb, hdr);
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		genlmsg_end(skb, hdr);
> +	}
> +
> +	if (ret == -EMSGSIZE)
> +		ctx->restart = index;
> +
> +	return ret;
> +}
> +
>  /**
>   * drm_ras_node_register() - Register a new RAS node
>   * @node: Node structure to register
> @@ -470,15 +672,24 @@ int drm_ras_node_register(struct drm_ras_node *node)
>  	if (!node->device_name || !node->node_name)
>  		return -EINVAL;
>  
> -	/* Currently, only Error Counter Endpoints are supported */
> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> -		return -EINVAL;
> -
>  	/* Mandatory entries for Error Counter Node */
>  	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
>  	    (!node->error_counter_range.last || !node->query_error_counter))
>  		return -EINVAL;
>  
> +	/* Mandatory entries for Retired Resources Node */
> +	if (node->type == DRM_RAS_NODE_TYPE_RETIRED_RESOURCES &&
> +	    !node->query_retired_resource)
> +		return -EINVAL;
> +
> +	switch (node->type) {
> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> +	case DRM_RAS_NODE_TYPE_RETIRED_RESOURCES:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL(drm_ras_node_register);
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index 9d3123cc9f9c..b194d065ec48 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,16 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
>  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>  };
>  
> +/* DRM_RAS_CMD_GET_RETIRED_RESOURCES - dump */
> +static const struct nla_policy drm_ras_get_retired_resources_nl_policy[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_GET_RETIRED_RESOURCES_INFO - dump */
> +static const struct nla_policy drm_ras_get_retired_resources_info_nl_policy[DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
>  /* Ops table for drm_ras */
>  static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	{
> @@ -56,6 +66,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_RESOURCES,
> +		.dumpit		= drm_ras_nl_get_retired_resources_dumpit,
> +		.policy		= drm_ras_get_retired_resources_nl_policy,
> +		.maxattr	= DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_RESOURCES_INFO,
> +		.dumpit		= drm_ras_nl_get_retired_resources_info_dumpit,
> +		.policy		= drm_ras_get_retired_resources_info_nl_policy,
> +		.maxattr	= DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +	},
>  };
>  
>  static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 03ec275aca92..c46f2b4a6e8a 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  					struct netlink_callback *cb);
>  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  					struct genl_info *info);
> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> +					    struct netlink_callback *cb);
> +int drm_ras_nl_get_retired_resources_info_dumpit(struct sk_buff *skb,
> +						 struct netlink_callback *cb);
>  
>  enum {
>  	DRM_RAS_NLGRP_ERROR_REPORT,
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index 78184b6ea7d4..11ddd12a42e2 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -12,6 +12,7 @@
>  #include "xe_device_types.h"
>  #include "xe_drm_ras.h"
>  #include "xe_ras.h"
> +#include "xe_ttm_vram_mgr.h"
>  
>  static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
>  static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
> @@ -154,6 +155,79 @@ static void cleanup_node(struct drm_device *drm, void *node)
>  	cleanup_node_param(node);
>  }
>  
> +static int query_retired_resource(struct drm_ras_node *node, u64 cursor,
> +				  struct drm_ras_retired_resource *res)
> +{
> +	struct xe_device *xe = node->priv;
> +	int ret;
> +
> +	ret = xe_ttm_vram_get_retired_page(xe, cursor, &res->vram_page.address,
> +					   &res->vram_page.size, &res->status);
> +	if (ret)
> +		return ret;
> +
> +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
> +	res->key = res->vram_page.address;
> +
> +	return 0;
> +}
> +
> +static int query_retired_info(struct drm_ras_node *node, u32 index,
> +			      struct drm_ras_retired_info *info)
> +{
> +	struct xe_device *xe = node->priv;
> +
> +	/* This node currently tracks a single resource type: VRAM pages. */
> +	if (index > 0)
> +		return -ENOENT;
> +
> +	info->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
> +	xe_ttm_vram_get_retired_info(xe, &info->max_count, &info->offlined_count,
> +				     &info->queued_count);
> +
> +	return 0;
> +}
> +
> +static int register_retired_node(struct xe_device *xe)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct drm_ras_node *node;
> +	const char *device_name;
> +	int ret;
> +
> +	/* Retired VRAM pages are only tracked on platforms with page offline */
> +	if (xe->info.platform != XE_CRESCENTISLAND)
> +		return 0;
> +
> +	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
> +				pci_domain_nr(pdev->bus), pdev->bus->number,
> +				PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +	if (!device_name)
> +		return -ENOMEM;
> +
> +	node->device_name = device_name;
> +	node->node_name = "vram-retired-pages";
> +	node->type = DRM_RAS_NODE_TYPE_RETIRED_RESOURCES;
> +	node->query_retired_resource = query_retired_resource;
> +	node->query_retired_info = query_retired_info;
> +	node->priv = xe;
> +
> +	ret = drm_ras_node_register(node);
> +	if (ret) {
> +		cleanup_node_param(node);
> +		return ret;
> +	}
> +
> +	ras->retired_node = node;
> +
> +	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> +}
> +
>  static int register_nodes(struct xe_device *xe)
>  {
>  	struct xe_drm_ras *ras = &xe->ras;
> @@ -245,5 +319,12 @@ int xe_drm_ras_init(struct xe_device *xe)
>  		return err;
>  	}
>  
> +	err = register_retired_node(xe);
> +	if (err) {
> +		drm_err(&xe->drm, "Failed to register DRM RAS retired node (%pe)\n",
> +			ERR_PTR(err));
> +		return err;
> +	}
> +
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras_types.h b/drivers/gpu/drm/xe/xe_drm_ras_types.h
> index 83899cf04793..e1bdb7edd0e1 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_drm_ras_types.h
> @@ -41,6 +41,9 @@ struct xe_drm_ras {
>  	/** @node: DRM RAS node */
>  	struct drm_ras_node *node;
>  
> +	/** @retired_node: DRM RAS retired-resources node for VRAM bad pages */
> +	struct drm_ras_node *retired_node;
> +
>  	/** @info: info array for all types of errors */
>  	struct xe_drm_ras_counter *info[DRM_XE_RAS_ERR_SEV_MAX];
>  
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index c54ad017725f..bc2fa43009f4 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -15,6 +15,8 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_range_manager.h>
>  
> +#include <uapi/drm/drm_ras.h>
> +
>  #include "regs/xe_regs.h"
>  #include "xe_bo.h"
>  #include "xe_configfs.h"
> @@ -581,6 +583,138 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
>  	return avail;
>  }
>  
> +/**
> + * xe_ttm_vram_get_retired_page - Fetch the next retired VRAM page by address
> + * @xe: xe device instance
> + * @min_addr: inclusive lower bound; return the page with the smallest DPA >=
> + *            this value
> + * @addr: output, device physical address (DPA) of the page
> + * @size: output, size of the page in bytes
> + * @status: output, retirement status (enum drm_ras_retired_resource_status)
> + *
> + * Scans the offlined and queued page lists across all tiles and returns the
> + * entry with the smallest DPA that is >= @min_addr. Because retired pages have
> + * unique addresses, iterating with @min_addr = previous_addr + 1 walks every
> + * entry in a stable address order, which is robust against concurrent
> + * insertion or removal between calls. Intended to back the drm-ras
> + * retired-resources node enumeration.
> + *
> + * Return: 0 on success, -ENOENT when no page has a DPA >= @min_addr.
> + */
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> +				 u64 *addr, u64 *size, u32 *status)
> +{
> +	struct xe_ttm_vram_offline_resource *pos;
> +	struct ttm_resource_manager *man;
> +	struct gpu_buddy_block *block;
> +	struct xe_ttm_vram_mgr *mgr;
> +	u64 best_addr = 0, best_size = 0;
> +	struct xe_tile *tile;
> +	u32 best_status = 0;
> +	bool found = false;
> +	u8 id;
> +
> +	for_each_tile(tile, xe, id) {
> +		struct xe_vram_region *vr = tile->mem.vram;
> +		u64 a, s;
> +
> +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> +		if (!man || !vr)
> +			continue;
> +		mgr = to_xe_ttm_vram_mgr(man);
> +
> +		rcu_read_lock();
> +
> +		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {
> +			block = list_first_entry_or_null(&pos->blocks,
> +							 struct gpu_buddy_block, link);
> +			if (block) {
> +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
> +				s = gpu_buddy_block_size(&mgr->mm, block);
> +			} else {
> +				a = pos->addr + vr->dpa_base;
> +				s = SZ_4K;
> +			}
> +
> +			if (a >= min_addr && (!found || a < best_addr)) {
> +				best_addr = a;
> +				best_size = s;
> +				best_status = DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED;
> +				found = true;
> +			}
> +		}
> +
> +		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
> +			block = list_first_entry_or_null(&pos->blocks,
> +							 struct gpu_buddy_block, link);
> +			if (block) {
> +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
> +				s = gpu_buddy_block_size(&mgr->mm, block);
> +			} else {
> +				a = pos->addr + vr->dpa_base;
> +				s = SZ_4K;
> +			}
> +
> +			if (a >= min_addr && (!found || a < best_addr)) {
> +				best_addr = a;
> +				best_size = s;
> +				best_status = pos->status == XE_PAGE_RESERVE_FAIL ?
> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED :
> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING;
> +				found = true;
> +			}
> +		}
> +
> +		rcu_read_unlock();
> +	}
> +
> +	if (!found)
> +		return -ENOENT;
> +
> +	*addr = best_addr;
> +	*size = best_size;
> +	*status = best_status;
> +
> +	return 0;
> +}
> +
> +/**
> + * xe_ttm_vram_get_retired_info - Fetch device-wide retired page limits/counts
> + * @xe: xe device instance
> + * @max: output, maximum pages that can be offlined (summed across tiles)
> + * @offlined: output, pages currently retired (summed across tiles)
> + * @queued: output, pages queued for retirement (summed across tiles)
> + *
> + * Aggregates the per-tile VRAM offline limits and occupancy. Intended to back
> + * the drm-ras retired-resources info query.
> + */
> +void xe_ttm_vram_get_retired_info(struct xe_device *xe, u32 *max,
> +				  u32 *offlined, u32 *queued)
> +{
> +	struct ttm_resource_manager *man;
> +	struct xe_ttm_vram_mgr *mgr;
> +	struct xe_tile *tile;
> +	u32 m = 0, o = 0, q = 0;
> +	u8 id;
> +
> +	for_each_tile(tile, xe, id) {
> +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> +		if (!man || !tile->mem.vram)
> +			continue;
> +		mgr = to_xe_ttm_vram_mgr(man);
> +
> +		scoped_guard(mutex, &mgr->lock) {
> +			m += mgr->max_pages;

This is awkward. You document the max_count as the maximum that can be retired,
but you are actually counting how many are retired at a given point.

> +			o += mgr->n_offlined_pages;
> +			q += mgr->n_queued_pages;


You should probably have a single function that gets all the entries and
the count. Otherwise you might have inconsistencies in the information.

info command followed by dump can show different discrepant information...

perhaps we could even delete the info command entirely and only use the dump?

> +		}
> +	}
> +
> +	*max = m;
> +	*offlined = o;
> +	*queued = q;
> +}
> +
>  static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
>  {
>  	u32	q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> index 8878e36292b2..9f849ee40e5b 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> @@ -35,6 +35,11 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
>  int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
>  int xe_ttm_vram_inject_fault(struct xe_device *xe);
>  void xe_ttm_vram_debugfs_init(struct xe_device *xe, struct dentry *root);
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> +				 u64 *addr, u64 *size, u32 *status);
> +void xe_ttm_vram_get_retired_info(struct xe_device *xe, u32 *max,
> +				  u32 *offlined, u32 *queued);
> +
>  static inline struct xe_ttm_vram_mgr_resource *
>  to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
>  {
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index ee2caa0edc6f..024f6a08c079 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -10,6 +10,54 @@
>  
>  #include <uapi/drm/drm_ras.h>
>  
> +/**
> + * struct drm_ras_retired_resource - A single retired resource entry
> + *
> + * Describes one hardware resource that has been taken out of service and is
> + * reported by a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. @type selects which
> + * member of the anonymous union is valid, allowing new hardware resource types
> + * to be added without changing the common fields.
> + */
> +struct drm_ras_retired_resource {
> +	/** @type: Resource type (enum drm_ras_retired_resource_type). */
> +	__u32 type;
> +	/** @status: Retirement status (enum drm_ras_retired_resource_status). */
> +	__u32 status;
> +	/**
> +	 * @key: Opaque, driver-assigned ordering key for this entry. drm-ras
> +	 * uses it only to advance the dump cursor; entries must be enumerable
> +	 * in strictly increasing @key order and keys must be unique.
> +	 */
> +	__u64 key;
> +	union {
> +		/** @vram_page: Valid when @type is VRAM_PAGE. */
> +		struct {
> +			/** @vram_page.address: Device address (e.g. DPA). */
> +			__u64 address;
> +			/** @vram_page.size: Size in bytes. */
> +			__u64 size;
> +		} vram_page;
> +	};
> +};
> +
> +/**
> + * struct drm_ras_retired_info - Per-type retired resource limits and counts
> + *
> + * Reported by a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node to describe the
> + * capacity and current occupancy of one resource type. A node that tracks
> + * several resource types reports one entry per type.
> + */
> +struct drm_ras_retired_info {
> +	/** @type: Resource type (enum drm_ras_retired_resource_type). */
> +	__u32 type;
> +	/** @max_count: Maximum resources of @type that can be retired. */
> +	__u32 max_count;
> +	/** @offlined_count: Resources of @type currently retired. */
> +	__u32 offlined_count;
> +	/** @queued_count: Resources of @type queued (pending or failed). */
> +	__u32 queued_count;
> +};
> +
>  /**
>   * struct drm_ras_node - A DRM RAS Node
>   */
> @@ -71,6 +119,45 @@ struct drm_ras_node {
>  	 */
>  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>  
> +	/**
> +	 * @query_retired_resource:
> +	 *
> +	 * This callback is used by drm-ras to enumerate retired resources of a
> +	 * %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. It is called with @cursor
> +	 * and must return the next entry whose ordering key is greater than or
> +	 * equal to @cursor, setting @res->key to that entry's key. drm-ras
> +	 * resumes multi-part dumps from the returned key, so enumeration stays
> +	 * correct across concurrent insertion or removal.
> +	 *
> +	 * The @query_retired_resource is a mandatory callback for
> +	 * retired-resources nodes.
> +	 *
> +	 * Returns: 0 on success,
> +	 *          -ENOENT when no entry has a key >= @cursor, used as an
> +	 *                  indication that enumeration is complete.
> +	 *          Other negative values on errors that should terminate the
> +	 *          netlink query.
> +	 */
> +	int (*query_retired_resource)(struct drm_ras_node *node, u64 cursor,
> +				      struct drm_ras_retired_resource *res);
> +
> +	/**
> +	 * @query_retired_info:
> +	 *
> +	 * This optional callback is used by drm-ras to report per-type limits
> +	 * and current occupancy for a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node.
> +	 * It is called with @index starting at 0 and incrementing until the
> +	 * driver returns -ENOENT, allowing one entry per resource type.
> +	 *
> +	 * Returns: 0 on success,
> +	 *          -ENOENT when @index is past the last type, used as an
> +	 *                  indication that enumeration is complete.
> +	 *          Other negative values on errors that should terminate the
> +	 *          netlink query.
> +	 */
> +	int (*query_retired_info)(struct drm_ras_node *node, u32 index,
> +				  struct drm_ras_retired_info *info);
> +
>  	/** @priv: Driver private data */
>  	void *priv;
>  };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index eab8231aa87c..de6f6dd3ffa9 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h

you are auto-generating these with the ynl commands right? please make sure
to mention that in the commit message just to be sure.

Thanks,
Rodrigo.

> @@ -11,11 +11,38 @@
>  #define DRM_RAS_FAMILY_VERSION	1
>  
>  /*
> - * Type of the node. Currently, only error-counter nodes are supported, which
> - * expose reliability counters for a hardware/software component.
> + * Type of the node.
> + *  - error-counter nodes expose reliability counters for a
> + *    hardware/software component.
> + *  - retired-resources nodes enumerate hardware resources (e.g. VRAM pages)
> + *    that have been permanently taken out of service.
>   */
>  enum drm_ras_node_type {
>  	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> +	DRM_RAS_NODE_TYPE_RETIRED_RESOURCES,
> +};
> +
> +/*
> + * Status of a retired resource entry reported by a retired-resources node.
> + *  - retired: resource is permanently reserved and out of service.
> + *  - pending: retirement is queued but reservation is not yet complete.
> + *  - failed:  reservation of the resource failed and it may still be in use.
> + */
> +enum drm_ras_retired_resource_status {
> +	DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED = 0,
> +	DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING,
> +	DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED,
> +};
> +
> +/*
> + * Type of a retired resource entry. The type selects which type-specific
> + * nested attribute is present in a retired-resource entry. New hardware
> + * resource types can be added here, each carrying its own nested attribute
> + * set, without affecting existing types.
> + *  - vram-page: a VRAM page identified by device address and size.
> + */
> +enum drm_ras_retired_resource_type {
> +	DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE = 1,
>  };
>  
>  enum {
> @@ -50,11 +77,43 @@ enum {
>  	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>  };
>  
> +enum {
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_TYPE,
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_STATUS,
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE,
> +
> +	__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX,
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX - 1)
> +};
> +
> +enum {
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS = 1,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_PAD,
> +
> +	__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX = (__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX - 1)
> +};
> +
> +enum {
> +	DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_TYPE,
> +	DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_MAX_COUNT,
> +	DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_OFFLINED_COUNT,
> +	DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_QUEUED_COUNT,
> +
> +	__DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_MAX,
> +	DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_MAX = (__DRM_RAS_A_RETIRED_RESOURCE_INFO_ATTRS_MAX - 1)
> +};
> +
>  enum {
>  	DRM_RAS_CMD_LIST_NODES = 1,
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
>  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>  	DRM_RAS_CMD_ERROR_EVENT,
> +	DRM_RAS_CMD_GET_RETIRED_RESOURCES,
> +	DRM_RAS_CMD_GET_RETIRED_RESOURCES_INFO,
>  
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> -- 
> 2.25.1
> 
