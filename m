Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B6FF588EF
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F02A10E708;
	Mon, 20 Apr 2026 16:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C5VCMC2m";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511510E6FF;
 Mon, 20 Apr 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776702264; x=1808238264;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+GBxIdsC1wPtnFewmQ368wV89v5Q4DY9uHPYkRiEcvc=;
 b=C5VCMC2mQjzEnFXQzggh4iyR0nzangF5nTGPT/jEPuMgD07TaGjZX0YW
 U8jKycWYRLtIm0EeXnGiz8FmLFBSgJfqLEJzwsnlTbxF1RgLCsAlir1eS
 lvUPNW3OdoNNUygHtfkJke/0SNa6X5dD7pfjh8kFgkfaT7afbLocRxfcM
 qex+t8fQuRQ2Wjc9W52FdY+RWdEpl3Wg46+mEXZCZMzI2CmoiOuXl5hIz
 hDkLfdBhI3xpfjdoq1KGfuKaZHEe8X6yGKHJze7ns7iSQpwBOWUAgwxoy
 qsurcxMmF0UiLXCktPFazSilVk3yghF4bCEOeiyBojJycktW0yQdwG6iO w==;
X-CSE-ConnectionGUID: gpeZBYZqTaallu6wF84I5w==
X-CSE-MsgGUID: PtQSgQcAT9yohBNPLjx0Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77497444"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="77497444"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:24:23 -0700
X-CSE-ConnectionGUID: ulrXTDtwQDCCyO8z6aw15g==
X-CSE-MsgGUID: Jv8ABOzcSJWnpBU9PcFO/g==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:24:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 09:24:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 09:24:21 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 09:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNFf+MjxCPeIiSblBkz6l9IEab2dXjOaPH1XkjGBNIpz6/W78UFE3i42yRh8huCrnv/xgPMNfGHT9pUx4YwfOpFdQYTvKl2vXqew7z80Y+ewKaCJBDhZfHOl29VvntSkgUnXAiTE4y4McuZNLNjH0tcpVLkPI1vnZglhRcAz3HwPQqXeAQTmgf0mz2qHlYM6Rm//uM0KCaBDq3D1lCUQd46G3l03AcOBqfRd+dGD3viEbo66Dp9Hh8ZZmbkv9cVU1UlfHozuy/6lausXanMV155G2Rp4Ss1EeqLbAxdd8uxaEtWvSDrYkgUIg95mTM4ujEXTZP+JywIu+jzkv9Q4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwbF/lrtixxFnytvZ3RxP33pHRm/C7mxZz3wW2dAprg=;
 b=FYNWxoZf41MAFAFi5A/RG7nXOAPz20+oIwxuZYIczAJ/4H/xvGl5aqQwQhxlQ1zOPeBEVzMeK70v8wb+yACqRyh3YXpOrxYpX5FHgdIGJWBoxW8wzZI9HBFSBa0eA/kVhbHMhrKph+xdkNGCeSwaZyyC36gDAPJ4tNRwKtTLSeonJKl3EAlOl7BJx8zOs35ghZqPNZsGDQawAGCoFe8hYguWcLbgwcYyOBMNCMIjPrpZCA9MNUzRbWKvg/lEmab6nA1wkTJQ4CCihtMa8k0GSti6SfFvweeLPnniAATfxcQpGy0L9+ERhqlLLNHOP5qlSJWrPVBEYpNagwiAjMIvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 16:24:18 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 16:24:18 +0000
Date: Mon, 20 Apr 2026 09:24:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>, Honghuan He
 <honghuan.he@amd.com>
Subject: Re: [RFC V3 11/12] drm/amdgpu: add SVM ioctl, garbage collector, and
 fault handler
Message-ID: <aeZTLi3yoZ1ADnDO@gsse-cloud1.jf.intel.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
 <20260420131307.1816671-12-honglei1.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420131307.1816671-12-honglei1.huang@amd.com>
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: c65ed81e-eaab-43da-a4f0-08de9ef94566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gmaSgX6ZOeexNTvcvu9id0TartXhnnBBesgin+3EkYaVLJir5xMhaDG/mlUnvSbPi2s+Q8YD5IRiAeZYUQfnFrIaGbzgjhKOqJu8hzcN5bqdTZlCEtrLAx0Z9a+nagsF3tiH2uN5ff3dz7j22R329mDnwZrPhj/PPfm9BWKSV+vC3YujjknmE7ckmg/kyq6I/3SxsOuVF/bRBLtp0smFuPUOdO5IO1BE15tIfprJ5+8w79Pov7df4swTEgCk/xFi8u+tEXMhKILcH36YzJPW3NINWGqrHbfs86/siqh5qt2jOJGPGWwtAFUuvMl4nHwbZ0mbKiXm2Hp1Pidt//Ad0M+9xHvE5uOAqQ0B4PkaSdwCC4ZzvzHFO8nGRURXV+MmsN6oIJWuLgzNwIQu6thfK2KcdlbVF96b8za13wrytWbNs6U6Rn6S5TsqywPsvJ6Y7WsP0xIGaJ/dLhXFoUJzRx3SOENx4lasovzdDgcanB43RrmbCwR3SCRLBWY6FwcvNbdR5zb8KHyLhjDLzJYGt1kMOs2do9L2rr6SwBv5VUodDaewOtXzrb1T4WBDBS0MJAdU7Xc6B5RpQ1Qy6RzQ8ZdFqfPDFUbfjMk+ONaMz9DIGvTHyODPhfuotDlzuWktsqUAuuRNZN2Q5gIebXDw8x4yWYQFI9ANVnBx6lcHxtiwn0ebmUwIxyyAWOlB2mQI6eWbmyUj+RqVh9KHGDO/k9pckHWycv2SldVCpUzHEUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18096099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3JCK2VsMUtzSEVSakc2ZW5IaUxUVmJnZjR3dktQdE9wUjhSZTNyb3ZRam1m?=
 =?utf-8?B?MGhJV1pndVFLRmZ1L3N0R2VkNDUrbDQxRlMzOUQzbGc4TzhLSmtob2xrVzhy?=
 =?utf-8?B?S3YxVkx3c0NLbHpQbFFvejVjVDBGQlZiTzE5cFdnYzFOZkRWNEZvOCthVkl2?=
 =?utf-8?B?RXZpMGNaUjNKMW9zcUs4SmY4WFFNUUpTNHEzVGVBUytBb3ltMVBBU0dGM1NP?=
 =?utf-8?B?My9rRmJ5UENmdkgzNGhBT3RTQldUUW1FelRud2l2bFF0dmd0REtZOE5EQkN3?=
 =?utf-8?B?RDNXNzl3ZS9PakE0WGJtYWV6bVA1VHVjeUwrWFR2dXg0bkpybXpyRlJJSnE3?=
 =?utf-8?B?YjBpT1lrUHZXVW1HRnkxTzE1RU5vNnZxT0JxZDlzemg5ekkvb0FxL01ZK0Vh?=
 =?utf-8?B?eXk0WTA1cU9MK2o2UUxudlZOVFFSTkRTTDc2Ym13N3lmM3VIN29EODJoNXpU?=
 =?utf-8?B?MDhDTXorZEpvSy9YaUNIVU5GRUllNVZHUFVKbEQ2d25OWTdWWjJpWWtFajFt?=
 =?utf-8?B?TTB3SDAvc2E4RG9wM2tHV2JHWVRGUnA2S201UnJQelhVaStJSnd6bDBjcyt6?=
 =?utf-8?B?NkIxYjRBUWJYdk1mZ2todFc2b29CdWcrNm9PSGhla21uamdrRnY4VjhOOXFu?=
 =?utf-8?B?RG5YTlBnUTIzbUp1b05pa2kzNXdmcDJpS3NwU1l3cExEUjZEVXRhS2dVR0Qx?=
 =?utf-8?B?MXBwK2w1K212NmVFUEhKNmwrVVhCTTNlSGFkTG04b0dBWmRpZUpzL2dzemYr?=
 =?utf-8?B?ZWZjS3J1VngzZFBDNmNYd2FwSmhRWTFOK0dIZXdteHBEMDg2enVEYWh3aGJY?=
 =?utf-8?B?ZE5KTHZhL2w3NHArWVlGdGc4cnMzRDJzZFV6RCtpWFczNkFJRlpTUXoveHVw?=
 =?utf-8?B?MmR0YkNMWXAxcnBobXN1WDdkR003K3hHY0xRTzJSdGFHVEJCWVJZMys2UVA2?=
 =?utf-8?B?SlNuUU5tdGNPTTB6YXNtbmljd3JlZEQzTGZtUmVSR2UreTBtamRJRHNRdlc1?=
 =?utf-8?B?TW9jbTJXRXVqeGNwWnRGVUp5TEhmb0d3RnF4cEgxNGordjdhd3AzTWhMSzIr?=
 =?utf-8?B?cU82OTdGeitwQjFZSkJhV1FXVW5LOVYyZ3JDUWhZRFlweUVKTDBGQzM1cjJz?=
 =?utf-8?B?dkl4UmdyUWIzalJ0WjhWcXFmdXhlNXAwZWpwamhjbXRZL3dTaFBab2ZDa0xh?=
 =?utf-8?B?Q3J0SlpXZC9CcUF1eUh0Wk1XWFJxUERna253eTRlNFZkVFJ0eWFML2FjRDhZ?=
 =?utf-8?B?NUlhNUsvbDU5cXQ1WlFFWURBVGRpNUtCcGJkM0NjVWtPenU4Qng4TWJPSTBZ?=
 =?utf-8?B?MWVTQjBaTnJ2ZXNaNjZPZUhFS1d3SllkenlCVDJ3U1BORE1TNGJVY0hEYzR1?=
 =?utf-8?B?cG41SmpzNTFWYXVCcXkySTRLY3FTRTZlWHJmYmJWMG1vRElKRzF0c052Y3VL?=
 =?utf-8?B?aWZ1ekhIb0xmT0JWR1J4T2txNzV1UHZNSzRQcGhqa2R4Mld4bzUrVFFIQVRX?=
 =?utf-8?B?R2x1V2RFTTN2L1JPMGhrUlNkWWhVL0tOYkhWM1psZ25jdkJoUWZzUkRCdE42?=
 =?utf-8?B?MWlqUldtZ3ZFWXZoczJZdHZPZ2FTSHZaS0wxQW9sYm40Q25ZRDZac2NzL3Bk?=
 =?utf-8?B?V2ZQNC9JSU96akNIRkhVWHcrems4SmhpS0l0NzVBT0VNZmRGdVh5d21BRWhu?=
 =?utf-8?B?MFYvTENMR0VPQ096S3FxcjZEcmkwbWV2UW5yUmJHNWVOUjlHOUVHMnlZK250?=
 =?utf-8?B?dDJCQ1Y0dzg2YSs1NEVGMUJic3RNYkR6K3gzVXJmZXdvWHZGckgrTWRKNWh6?=
 =?utf-8?B?eWNZeWpkTVhEZ1NxOEx2RjIxdjJtaldVTEt4Tnh4QUxva2NjL1MvT25peUlz?=
 =?utf-8?B?VmRaL3I4YlBVUXUyRk4yb1ZHb2wxbENTVlBCZkc5U2lrQXdrOEQ4eVROd29D?=
 =?utf-8?B?VTB2R3NhTDQ2K29iNTJoR0duMVRoTXFtb1orQVNKZUlYMTRua0JJQTJQanRh?=
 =?utf-8?B?TkF3dDNRVzYwRmFuYzh4cHRGY2JzaXNJbHhMVG05UDRRQUlNR2dYRmFwLzNU?=
 =?utf-8?B?dWpKR0ZRQXpnT2RvVDM3eG1xZHBJRkdVQ242UEJqWHUrWWYxV0hraE9rSVUr?=
 =?utf-8?B?QlVmTko0QXhoQkNxNWx2MUszOXlmQmQyd1Mya0pQVnR5clVqc093eW15dHZ4?=
 =?utf-8?B?RkNONVZCVjNTaSt1VHAzYytpVDg4YkZpNmJEMWxRRHJEaHpRYmovdkZCaWtK?=
 =?utf-8?B?Yk5XYjRIMXFKYzhHVWF0dDNyODFTbCt6QlZoY21XWUphOTMxM2dKZUQ1SEF6?=
 =?utf-8?B?K2JuY2F1UDNXZzdUK0RLblpzRWMybStKb3NFVkdjY3F3cjJxZ3QxUT09?=
X-Exchange-RoutingPolicyChecked: K4VpLQP6m7KFbX0dqxN3VTjkPHs5AaiZn9Btgkf4i8VqpqZGcL5vUtldk0X17tJw02A5KZ53oxi9leV0/uxROqnOfq2l8mEFrZKvTbYdNP5eTSOnd7I2HOsETQIgtmqaX3gdqHOn8ohUjdB8ywTNbhVppz6JQpvStrPXI617bCzUwLC36xlEudbhMaseeDHxlCtZVwcHOGUCbyHpAy9ROomTe9pQoJhUfl8PQfSkQR8i8IVorcmmVBT8UJyO1Ww/1BXL16jrkWwu6o3AWgmY2zZCnevvKgtaz5UffZGaxpQonRj+fahWs712DDdn6f58brNXfx1XrK5l/RRhxOPYDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ed81e-eaab-43da-a4f0-08de9ef94566
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:24:18.3847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRUODkENJqB7/MuSsbSEntlT3c5q46iAaY10fk9XaCtpOrH7kD4pTGT58y4ESOnlZUYicUEpfA3Aw+PurmeVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
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

On Mon, Apr 20, 2026 at 09:13:06PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Add the ioctl entry point and garbage collector to amdgpu_svm.c,
> and introduce amdgpu_svm_fault.c and amdgpu_svm_fault.h as a
> dedicated fault handler module.
> 
> Ioctl (amdgpu_svm.c):
> - amdgpu_svm_copy_attrs(): copy and validate user attribute array
>   from userspace with size and alignment checks
> - amdgpu_gem_svm_ioctl(): handle DRM_AMDGPU_GEM_SVM dispatching
>   to SET_ATTR or GET_ATTR with copy_to_user for GET results
> 
> Garbage collector (amdgpu_svm.c):
> - amdgpu_svm_garbage_collector(): dequeue and remove GC-listed
>   ranges under svm_lock, clear corresponding attributes
> - amdgpu_svm_range_clean_queue(): batch cleanup for dequeued
>   work items
> - amdgpu_svm_garbage_collector_work_func(): GC work handler
> - amdgpu_svm_gc_init/fini/flush(): lifecycle management for
>   the GC workqueue
> 
> Fault handler (amdgpu_svm_fault.c):
> - AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING: 2ms dedup threshold
> - amdgpu_svm_range_get_unregistered_attrs(): derive default
>   attributes for faulting addresses without explicit registration,
>   using VMA properties and GPU IP capabilities
> - svm_check_fault_allowed(): validate fault access against
>   attribute permissions and read-only enforcement
> - amdgpu_svm_range_map_fault(): core fault mapping that finds or
>   creates a gpusvm range, gets pages, maps into GPU page tables,
>   retries on -EAGAIN up to 3 times
> - amdgpu_svm_handle_fault(): main entry called from
>   amdgpu_vm_handle_fault(). Looks up SVM by PASID, acquires
>   mmap_read_lock and svm_lock, runs garbage collector, resolves
>   attributes from the tree or derives defaults, uses timestamp
>   deduplication to skip stale faults, dispatches to map_fault
> 
> Fault header (amdgpu_svm_fault.h):
> - Forward declarations and amdgpu_svm_handle_fault() prototype
> 
> Signed-off-by: Honghuan He <honghuan.he@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 149 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 ++
>  3 files changed, 556 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
> index 5fbed9b9f..a672deede 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
> @@ -316,3 +316,152 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>  	return vm->svm != NULL;
>  }
>  
> +static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
> +					   struct drm_amdgpu_svm_attribute **attrs,
> +					   size_t *size)
> +{
> +	if (!args->nattr || args->nattr > AMDGPU_SVM_MAX_ATTRS)
> +		return -EINVAL;
> +	if (!args->attrs_ptr)
> +		return -EINVAL;
> +
> +	*size = args->nattr * sizeof(**attrs);
> +	*attrs = memdup_user(u64_to_user_ptr(args->attrs_ptr), *size);
> +
> +	return PTR_ERR_OR_ZERO(*attrs);
> +}
> +
> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm)
> +{
> +	int ret;
> +	struct amdgpu_svm_range_op_ctx op_ctx;
> +
> +	lockdep_assert_held_write(&svm->svm_lock);
> +
> +	spin_lock(&svm->work_lock);
> +	while (amdgpu_svm_range_dequeue_locked(svm, &svm->gc.list, &op_ctx)) {
> +		spin_unlock(&svm->work_lock);
> +
> +		if (UNMAP_WORK(op_ctx.pending_ops)) {
> +			ret = amdgpu_svm_attr_clear_pages(
> +				svm->attr_tree, op_ctx.start_page, op_ctx.last_page);
> +			if (ret)
> +				return ret;
> +
> +			drm_gpusvm_range_remove(&svm->gpusvm,
> +						&op_ctx.range->base);
> +		}
> +
> +		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
> +		spin_lock(&svm->work_lock);
> +	}
> +	spin_unlock(&svm->work_lock);
> +	return 0;
> +}
> +
> +void
> +amdgpu_svm_range_clean_queue(struct amdgpu_svm *svm,
> +			     struct list_head *work_list)
> +{
> +	struct amdgpu_svm_range_op_ctx op_ctx;
> +
> +	spin_lock(&svm->work_lock);
> +	while (amdgpu_svm_range_dequeue_locked(svm, work_list,
> +				    &op_ctx)) {
> +		spin_unlock(&svm->work_lock);
> +		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
> +		spin_lock(&svm->work_lock);
> +	}
> +	spin_unlock(&svm->work_lock);
> +}
> +
> +static void amdgpu_svm_garbage_collector_work_func(struct work_struct *w)
> +{
> +	struct amdgpu_svm_gc *gc = container_of(w, struct amdgpu_svm_gc, work);
> +	struct amdgpu_svm *svm = container_of(gc, struct amdgpu_svm, gc);
> +
> +	down_write(&svm->svm_lock);
> +	amdgpu_svm_garbage_collector(svm);
> +	up_write(&svm->svm_lock);
> +}
> +
> +int amdgpu_svm_gc_init(struct amdgpu_svm *svm)
> +{
> +	svm->gc.wq = alloc_workqueue(AMDGPU_SVM_GC_WQ_NAME,
> +					WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
> +	if (!svm->gc.wq)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&svm->gc.list);
> +	INIT_WORK(&svm->gc.work, amdgpu_svm_garbage_collector_work_func);
> +
> +	return 0;
> +}
> +
> +void amdgpu_svm_gc_fini(struct amdgpu_svm *svm)
> +{
> +	flush_work(&svm->gc.work);
> +	amdgpu_svm_range_clean_queue(svm, &svm->gc.list);
> +	destroy_workqueue(svm->gc.wq);
> +	svm->gc.wq = NULL;
> +}
> +
> +void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
> +{
> +	flush_work(&svm->gc.work);
> +}
> +
> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct drm_amdgpu_gem_svm *args = data;
> +	struct drm_amdgpu_svm_attribute *attrs = NULL;
> +	struct amdgpu_vm *vm;
> +	size_t attrs_size = 0;
> +	int ret = 0;
> +
> +	AMDGPU_SVM_TRACE("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n",
> +			 args->operation, args->start_addr, args->start_addr + args->size,
> +			 args->size, args->nattr);
> +
> +	vm = &fpriv->vm;
> +	if (!amdgpu_svm_is_enabled(vm)) {
> +		ret = amdgpu_svm_init(adev, vm);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((args->start_addr & ~PAGE_MASK) || (args->size & ~PAGE_MASK))
> +		return -EINVAL;
> +
> +	if (!args->start_addr || !args->size)
> +		return -EINVAL;
> +
> +	ret = amdgpu_svm_copy_attrs(args, &attrs, &attrs_size);
> +	if (ret)
> +		return ret;
> +
> +	switch (args->operation) {
> +	case AMDGPU_SVM_OP_SET_ATTR:
> +		ret = amdgpu_svm_set_attr(vm, args->start_addr, args->size,
> +					 args->nattr, attrs);
> +		break;
> +	case AMDGPU_SVM_OP_GET_ATTR:
> +		ret = amdgpu_svm_get_attr(vm, args->start_addr, args->size,
> +					 args->nattr, attrs);
> +		if (!ret && copy_to_user(u64_to_user_ptr(args->attrs_ptr),
> +					 attrs, attrs_size))
> +			ret = -EFAULT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	kvfree(attrs);
> +	return ret;
> +}
> +
> +#endif /* CONFIG_DRM_AMDGPU_SVM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
> new file mode 100644
> index 000000000..968fb402b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
> @@ -0,0 +1,368 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu_svm.h"
> +#include "amdgpu_svm_attr.h"
> +#include "amdgpu_svm_fault.h"
> +#include "amdgpu_svm_range.h"
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_gmc.h"
> +#include "amdgpu_ih.h"
> +
> +#include <drm/drm_exec.h>
> +#include <drm/drm_gpusvm.h>
> +
> +#include <linux/delay.h>
> +#include <linux/mm.h>
> +#include <linux/sched/mm.h>
> +
> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> +
> +#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
> +
> +static int amdgpu_svm_range_get_unregistered_attrs(struct amdgpu_svm *svm,
> +					    unsigned long fault_addr,
> +					    unsigned long attr_start_page,
> +					    unsigned long attr_last_page,
> +					    struct amdgpu_svm_attr_range **out)
> +{
> +	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
> +	struct amdgpu_svm_attr_range *range;
> +	struct amdgpu_svm_attrs attrs;
> +	struct mm_struct *mm = svm->gpusvm.mm;
> +	struct vm_area_struct *vma;
> +	unsigned long fault_page = fault_addr >> PAGE_SHIFT;
> +	unsigned long start_page, last_page;
> +	unsigned long vma_start_page, vma_last_page;
> +
> +	amdgpu_svm_attr_set_default(svm, &attrs);
> +
> +	mmap_read_lock(mm);
> +
> +	vma = amdgpu_svm_check_vma(mm, fault_addr);
> +	if (IS_ERR(vma)) {
> +		mmap_read_unlock(mm);
> +		AMDGPU_SVM_ERR("get_unregistered_attrs: invalid VMA for fault_addr=0x%lx\n",
> +		       fault_addr);
> +		return PTR_ERR(vma);
> +	}
> +	vma_start_page = vma->vm_start >> PAGE_SHIFT;
> +	vma_last_page = (vma->vm_end >> PAGE_SHIFT) - 1;
> +
> +	if (vma_is_initial_heap(vma) || vma_is_initial_stack(vma))
> +		attrs.preferred_loc = AMDGPU_SVM_LOCATION_SYSMEM;
> +
> +	mmap_read_unlock(mm);
> +
> +	start_page = max(vma_start_page,
> +		    (unsigned long)ALIGN_DOWN(fault_page, 1UL << attrs.granularity));
> +	last_page = min(vma_last_page,
> +		   (unsigned long)ALIGN(fault_page + 1, 1UL << attrs.granularity) - 1);
> +
> +	start_page = max(start_page, attr_start_page);
> +	last_page = min(last_page, attr_last_page);
> +
> +	mutex_lock(&attr_tree->lock);
> +	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &attrs);
> +	if (!range) {
> +		mutex_unlock(&attr_tree->lock);
> +		return -ENOMEM;
> +	}
> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +	mutex_unlock(&attr_tree->lock);
> +
> +	AMDGPU_SVM_TRACE(
> +		"Created unregistered range for fault_addr=0x%lx: attr range=[0x%lx-0x%lx] size: 0x%lx attrs={preferred_loc=%d, prefetch_loc=%d, flags=0x%x, granularity=%u, access=%u}\n",
> +		fault_addr, amdgpu_svm_attr_start_page(range),
> +		amdgpu_svm_attr_last_page(range) + 1,
> +		amdgpu_svm_attr_last_page(range) -
> +			amdgpu_svm_attr_start_page(range) + 1,
> +		range->attrs.preferred_loc, range->attrs.prefetch_loc,
> +		range->attrs.flags, range->attrs.granularity,
> +		range->attrs.access);
> +
> +	*out = range;
> +	return 0;
> +}
> +
> +static int svm_check_fault_allowed(struct amdgpu_svm *svm,
> +				   unsigned long fault_addr, bool write_fault)
> +{
> +	struct mm_struct *mm = svm->gpusvm.mm;
> +	struct vm_area_struct *vma;
> +	unsigned long requested = VM_READ;
> +	int ret = 0;
> +
> +	if (write_fault)
> +		requested |= VM_WRITE;
> +
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, fault_addr);
> +	if (vma && (vma->vm_flags & requested) != requested) {
> +		AMDGPU_SVM_ERR("fault addr 0x%lx no %s permission\n",
> +			 fault_addr, write_fault ? "write" : "read");
> +		ret = -EPERM;
> +	}
> +	mmap_read_unlock(mm);
> +
> +	return ret;
> +}
> +
> +static int amdgpu_svm_range_map_fault(struct amdgpu_svm *svm,
> +			       unsigned long fault_addr,
> +			       const struct amdgpu_svm_attr_range *attr_range,
> +			       bool write_fault)
> +{
> +	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
> +	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
> +	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
> +	devmem_possible = false; /* TODO: add migration */
> +	struct drm_gpusvm_ctx map_ctx = {
> +		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
> +		.devmem_possible = devmem_possible,
> +		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
> +		.devmem_only = need_vram_migration && devmem_possible,
> +		.timeslice_ms = need_vram_migration && devmem_possible ? 5 : 0,
> +	};
> +	struct amdgpu_svm_range *range;
> +	ktime_t timestamp = ktime_get_boottime();
> +	uint64_t range_pte_flags;
> +	int retry_count = 3;
> +	int ret;
> +
> +	lockdep_assert_held_write(&svm->svm_lock);
> +	WARN_ON(!svm->xnack_enabled);
> +
> +retry:
> +	ret = amdgpu_svm_garbage_collector(svm);
> +	if (ret) {
> +		AMDGPU_SVM_ERR(
> +			"fault garbage collector failed: ret=%d, fault_addr=0x%lx\n",
> +			ret, fault_addr);
> +		return ret;
> +	}
> +
> +	ret = svm_check_fault_allowed(svm, fault_addr, write_fault);
> +	if (ret)
> +		return ret;
> +
> +	range = amdgpu_svm_range_find_or_insert(svm, fault_addr,
> +						 attr_range, &map_ctx);
> +	if (IS_ERR(range)) {
> +		ret = PTR_ERR(range);
> +		AMDGPU_SVM_ERR("map_fault: range_find_or_insert failed: fault=0x%lx ret=%d\n",
> +				 fault_addr, ret);
> +		/*
> +		 * -EINVAL: fault_addr out of gpusvm range, or no chunk size
> +		 *          fits within VMA/notifier/attr_range bounds.
> +		 * -EFAULT: mmget_not_zero failed.
> +		 * -ENOENT: No VMA at fault_addr.
> +		 * -ENOMEM: Notifier or range allocation failed.
> +		 */

Just a drive-by comment: as we’re getting to multiple users of GPU SVM,
and each driver is making decisions based on the error codes returned by
the common layer, it may be time to update the GPU SVM kernel
documentation to clearly define what each return code means for every
call.

There may also be some inconsistency in the return codes due to the
ad-hoc nature of how this evolved. If we need to clean up any return
values, this is probably something we should do now—before we end up in
a situation where we change a return value and then have to fix multiple
drivers.

Please let us know if, while you’re working in this area, you notice any
GPU SVM return values that don’t make sense or could use adjustment.

Matt

> +		if (ret == -EFAULT || ret == -ENOENT) {
> +			AMDGPU_SVM_ERR("no vma or mm is dying: 0x%lx, ret=%d\n",
> +					 fault_addr, ret);
> +			ret = 0;
> +		}
> +
> +		return ret;
> +	}
> +
> +	if (ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,
> +					 AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
> +		AMDGPU_SVM_TRACE("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
> +				 fault_addr, drm_gpusvm_range_start(&range->base),
> +				 drm_gpusvm_range_end(&range->base));
> +		goto out;
> +	}
> +
> +	range_pte_flags = amdgpu_svm_range_attr_pte_flags(
> +					svm, attrs, map_ctx.read_only);
> +
> +	if (!(write_fault && map_ctx.read_only) &&
> +	    amdgpu_svm_range_is_valid(svm, range, attrs, range_pte_flags)) {
> +		AMDGPU_SVM_TRACE("valid range, skip: fault=0x%lx range=[0x%lx-0x%lx)\n",
> +				 fault_addr, drm_gpusvm_range_start(&range->base),
> +				 drm_gpusvm_range_end(&range->base));
> +		goto out;
> +	}
> +
> +	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT");
> +	/* TODO: add migration*/
> +
> +	AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
> +	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
> +	if (ret == -EOPNOTSUPP || ret == -EFAULT) {
> +		/*
> +		* -EOPNOTSUPP  Mixed page types within range.
> +		* -EFAULT      (a) mm is dying.
> +		*              (b) range was unmapped.
> +		*              (c) DMA mapping failed.
> +		*              (d) devmem_only requested but system page encountered.
> +		*              (e) hmm_range_fault: no VMA, page fault error, bad pte/pmd.
> +		* -EBUSY       HMM retry loop timed out.
> +		* -ENOMEM      PFN or DMA address array allocation failed.
> +		* -EINVAL      hmm_range_fault: invalid VMA type.
> +		*/
> +		map_ctx.timeslice_ms <<= 1;
> +		if (!map_ctx.devmem_only && --retry_count > 0) {
> +			AMDGPU_SVM_ERR("start retry: get_pages failed with %d, retries_left=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
> +					 ret, retry_count, fault_addr,
> +					 drm_gpusvm_range_start(&range->base),
> +					 drm_gpusvm_range_end(&range->base));
> +			goto retry;
> +		} else {
> +			AMDGPU_SVM_ERR("map_fault: get_pages failed with %d, devmem fallback allowed, but no devmem pages: fault=0x%lx range=[0x%lx-0x%lx)\n",
> +					 ret, fault_addr, drm_gpusvm_range_start(&range->base),
> +					 drm_gpusvm_range_end(&range->base));
> +		}
> +	}
> +
> +	if (ret == -EPERM) {
> +		AMDGPU_SVM_ERR("get_pages -EPERM: fault=0x%lx range=[0x%lx-0x%lx)\n",
> +			       fault_addr, drm_gpusvm_range_start(&range->base),
> +				       drm_gpusvm_range_end(&range->base));
> +		return ret;
> +	}
> +
> +	if (ret) {
> +		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - FAIL PAGE COLLECT");
> +		goto out;
> +	}
> +
> +	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - GPU MAP");
> +
> +	ret = amdgpu_svm_range_update_mapping(svm, range,
> +					      range_pte_flags, attrs->flags,
> +					      false, false, false);
> +
> +	if (ret)
> +		goto err_out;
> +
> +out:
> +	return 0;
> +
> +err_out:
> +	if (ret == -EAGAIN && --retry_count > 0) {
> +		map_ctx.timeslice_ms <<= 1;
> +		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - RETRY GPU MAP");
> +		goto retry;
> +	}
> +
> +	return ret;
> +}
> +
> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> +			    uint64_t fault_addr, uint64_t ts,
> +			    bool write_fault)
> +{
> +	struct amdgpu_svm *svm;
> +	struct amdgpu_svm_attr_range *attr_range;
> +	unsigned long attr_start_page, attr_last_page;
> +	unsigned long fault_page;
> +	uint64_t ckpt;
> +	int ret;
> +
> +	fault_addr = fault_addr << PAGE_SHIFT;
> +	fault_page = fault_addr >> PAGE_SHIFT;
> +
> +	svm = amdgpu_svm_lookup_by_pasid(adev, pasid);
> +	if (!svm) {
> +		AMDGPU_SVM_ERR("handle_fault: no SVM context for pasid %u\n", pasid);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (atomic_read(&svm->exiting)) {
> +		AMDGPU_SVM_ERR("handle_fault: SVM context is exiting for pasid %u\n", pasid);
> +		ret = -EAGAIN;
> +		goto out_put;
> +	}
> +
> +	if (!svm->xnack_enabled) {
> +		AMDGPU_SVM_ERR("handle_fault: SVM context does not have xnack enabled for pasid %u\n", pasid);
> +		ret = -EOPNOTSUPP;
> +		goto out_put;
> +	}
> +
> +	ckpt = READ_ONCE(svm->checkpoint_ts);
> +	if (ckpt != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
> +			AMDGPU_SVM_TRACE(
> +			"handle_fault: draining stale retry fault, drop fault 0x%llx ts=%llu checkpoint=%llu\n",
> +				fault_addr, ts, ckpt);
> +			amdgpu_gmc_filter_faults_remove(
> +				adev, fault_addr >> PAGE_SHIFT, pasid);
> +			ret = 0;
> +			goto out_put;
> +		} else {
> +			WRITE_ONCE(svm->checkpoint_ts, 0);
> +		}
> +	}
> +
> +	down_write(&svm->svm_lock);
> +
> +retry:
> +	mutex_lock(&svm->attr_tree->lock);
> +	attr_range = amdgpu_svm_attr_get_bounds_locked(svm->attr_tree,
> +						       fault_page,
> +						       &attr_start_page, &attr_last_page);
> +	mutex_unlock(&svm->attr_tree->lock);
> +	if (!attr_range) {
> +		ret = amdgpu_svm_range_get_unregistered_attrs(svm, fault_addr,
> +							      attr_start_page,
> +							      attr_last_page,
> +							      &attr_range);
> +		if (ret) {
> +			if (ret == -EFAULT)
> +				goto out_no_vma;
> +			goto out_unlock;
> +		}
> +	}
> +	ret = amdgpu_svm_range_map_fault(svm, fault_addr, attr_range,
> +					 write_fault);
> +
> +	if (ret == -EAGAIN) {
> +		AMDGPU_SVM_ERR("handle_fault: got -EAGAIN: fault=0x%llx\n",
> +			       fault_addr);
> +		amdgpu_gmc_filter_faults_remove(adev, fault_addr>>PAGE_SHIFT, pasid);
> +		goto retry;
> +	}
> +
> +	goto out_unlock;
> +
> +out_no_vma:
> +	AMDGPU_SVM_ERR("handle_fault: no VMA for fault=0x%llx (stale retry or GPU NULL deref)\n",
> +		 fault_addr);
> +	ret = 0;
> +
> +out_unlock:
> +	up_write(&svm->svm_lock);
> +
> +out_put:
> +	amdgpu_svm_put(svm);
> +	return ret;
> +}
> +
> +#endif /* CONFIG_DRM_AMDGPU_SVM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
> new file mode 100644
> index 000000000..1c8f6c15e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_SVM_FAULT_H__
> +#define __AMDGPU_SVM_FAULT_H__
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_device;
> +struct amdgpu_svm;
> +struct amdgpu_svm_attr_range;
> +struct amdgpu_svm_attrs;
> +
> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> +			    uint64_t fault_addr, uint64_t ts,
> +			    bool write_fault);
> +
> +#endif /* __AMDGPU_SVM_FAULT_H__ */
> -- 
> 2.34.1
> 
