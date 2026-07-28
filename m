Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8079C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF6210E7FE;
	Tue, 28 Jul 2026 07:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m1liktZ8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D9110E7FE
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785224914; x=1816760914;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=71rFIONO0SRVcPvBinUkh8PbXk9FfWNuTwHhWzC9w0w=;
 b=m1liktZ8Aw31lVyJIiMh+FmcADKAFrMLzWZBuBRDtW5bXfE9Ht5mDk7P
 QgRsNbO6oVyfW+lxtTchlsfOVIsTebu10oUuGRWd5sU4ONIbT6yFlb/s7
 zccKHCrtV50GltMP4djCARDV2HAJOM1nua7dpVraFJ8srt2yymykm/GWo
 ffP/yiGx52tOfXWX3taGE4NyKmrdU/U653LyQrR7UVaMwecQFi59C7tL8
 Bi3/RZDimiM7SiND7Utw0D2Qn6CARa9ISqhdiU6LpMCizIPndfpXtmaOF
 a1958+nQO1xI39QvW2PyecyRfHzg2G2ZPrYaur12MRc3uHbCKIBBHZSOb Q==;
X-CSE-ConnectionGUID: R6f38kdbQsaFo7KgjSBJxg==
X-CSE-MsgGUID: bJxuJwg8Qt+8q/BGeQg1/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89624519"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="89624519"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 00:48:31 -0700
X-CSE-ConnectionGUID: evq78nqgSMaAGPyTZo1X0Q==
X-CSE-MsgGUID: It95924PQfqjpFXBcyiR3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="253307171"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 00:48:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 00:48:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 00:48:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 00:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZGejNS1pLNOfy6wYZbnSd5AS51wXOfoNafBB8e9HHnOmgwkt8Gtl68WhwJWDokIc9syHetXKjIKx9OsF+hREkbDDcj1xYseJzzorKtCLe/hW4zg784qj4vO9F7IU/kQ2eeUDFkJMpYKZ5ndsD8qosoAcmn5Z3/49oWtIZM/hlLLpFSXjU9ssZdg7rVemG7fGOrPBFMrmclbJg96qdjHCC7nb4FQW48CWcDGuweSSwQ1P4aCDUP22gLnRIk9z0WvGpvah2jRJijReLBNxgJ6DTzTLP9IvyjEl91AyFmRc5HUmrNAnarV280RwlBPGyJnex8FcMIUvtNYy9Gah3Tyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdT0pW8VShHev1zG4WQdbfJ5VUHPQ4odCm6HZkjOsNY=;
 b=bAyluCkFPAv4gDaNEC2kWuDW/xx3Fwb1qwFPhDgIqX/E8MlEbpXfElint3dgiYQpNbwI/Dqz14GEYgL37C2/r/qpQt6HAdW+01w1oU+9Aep+AqtPaggvjXC2YBNtQwzW+vTFAQBGmcKQNo3MzQmkZPHbP3BmTON2XU42GJb5yYKCT0Vg624m7nOzbROzljltz5a6R4AklWFgf7pJQSnMwAlXBlYsp3h7u5uYceM23CbqhLzwz0YOzi9BGLOP1PyAm7VhTWq9zpr/ApYJduMQcgNzafQqZdcDnGSIKdsIKbO388mStr37DYMsGP1s1prE7QgpSOI7pp0Qwf7712LbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 07:48:27 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0245.010; Tue, 28 Jul 2026
 07:48:27 +0000
Message-ID: <6dfea798-e3cf-4669-b5fc-cd8112d7dd13@intel.com>
Date: Tue, 28 Jul 2026 13:18:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <sashiko-reviews@lists.linux.dev>
CC: <dri-devel@lists.freedesktop.org>, Riana Tauro <riana.tauro@intel.com>,
 <mallesh.koujalagi@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
 <20260720101815.526813-8-mallesh.koujalagi@intel.com>
 <20260720104816.51BD11F00A3A@smtp.kernel.org> <al-udBqjgYOGgzja@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <al-udBqjgYOGgzja@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::19) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|DM4PR11MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e4a791-b2ef-45b7-0068-08deec7c9c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JLrIg5ikpwxI4lvhsPNnur/8ObNG08f2DYSJhr0bhgBX2t7PeHJbMokUe04cPwONt7lVXs1ctm64zU7GS9zRmgcu/tJYb0q04Za8EBL79RFhONMRgVdcSiNgXHwTFUM2bqrFlYssVLxc5fbStyDTTUdhSiClLKWCM4BrbrmC8imTTECi8vmeKhqJzs/B2OM8IQHd/TtTSz2WHlf7s6UEphDEez+FxdJxrd1vY7c2Ug2zANBGUUntqXMRjAXzjJU21O+qAK1XmxKaNO6uhAdakqhHUCi/NZFz0O8QZYe/jAdcE8Yn8m3TizkoNESUyUJgxPqg5mt6fi3aUusSLkkB/bfhtUf8HF7LDOUbD802LppVaWWboOPjD/xR2QdJnYzatpMzgR8ozUHQGaCihZEoSYNL5Imde1mkHsGgFUK8P5GHetXv/EwoE06Z1/1idPAEGVRiYloUBiv4cO0z8CUQ/ZhcqzD0WhZm3+KKBzTZlDQ4Cc6xrgroG5cYpdvWNZvbW59MtaYWIfwyI8PU/dZNGmTAvLEmNhKmY+4ZFLS8dJeQ0n8fc8fQfoBU7LFd485neQoePw4WTdOMQaGFFu70kP5VgRnjdk3A+0577eB1eWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktILzFFOERIK2VVQjJoRFRldmJGbTAwb1liWTNpZzNIYzZvcTFYY1FPNkxW?=
 =?utf-8?B?ekNjcFFoUW9Tc2VBcndnY2VJYWVVcFR2eTNHSXdRUkdvaFdJVVdIZU9QY1Rz?=
 =?utf-8?B?cjFPS1c2UVBadGtTNnBMUmZXcnIxamlWUlg5SlZRbXBnUC9URGg1ZG1SSUpp?=
 =?utf-8?B?alhiNVJPRVN1MExqMzh1c09KZmFweXcrNHZGUVdBT3kxVlJCbVZCMFRXNjVR?=
 =?utf-8?B?dUJNaU01dWVxaUhBN3VrVHZmeVR3eVFXUWlMallHVGFqNnlHU0t6VjJEYjBt?=
 =?utf-8?B?UlZEbG04UDBQbi9yM0VidFZnTy9SNEpaUzJCaTJua05lRW92RytaQlg3Qzg0?=
 =?utf-8?B?YXlaOUx5bWV2UjFNYWV6TTdYby9GV3dLcjcxZUp0dnFiUWhrL2tDa1hJK00z?=
 =?utf-8?B?QUxkN0Z1WjNLby9sc0R1U0NwcmlCVUR2SjIyZXAvY1V4Yld5NmprQkl3YXF3?=
 =?utf-8?B?bjV3VHUzNlJyTjRzN1g4dk5WVmMwR290M1VYREh1cjJlRHFmbEJna2U5Si9Q?=
 =?utf-8?B?R0FQZ2M1aDJxV1JkKzVxMEYyNllyOWNCZWUyYWE1U0g1b2huc3NPdHFGZS9U?=
 =?utf-8?B?QVZvRnpGL2d4alUveVNobWx6TUtNbUpNN3dzeml0TW5jL1JtWFpPWjhLSm5i?=
 =?utf-8?B?b05wSHBQT1oramovQ3BHY3FicCtneFJESWxkYlhWakVwc3pZZTlZaEdtUGdw?=
 =?utf-8?B?a3ZkZ2cyd2hZOWxUZGtrZUlMeHJpK1JFRHZ5c3Y3ZWZHRnVRUXl1V04xWjZ0?=
 =?utf-8?B?a2dUZ2s5Syt2U0ZGZGdIdU1pYTU5VGtSSExuWGlmZ1pBSFFuQm5iOVRvb3Ji?=
 =?utf-8?B?ZFZJK0hyamlhbDRCOUZlUTZoczdneGdZS2thc0k3aG5HMkN1Vnp5N2pyZ1Z6?=
 =?utf-8?B?UkswYzg0RjM1Y3lTMURRWHNpcjUvZG1mMytWdkZiN3JBNmI4SHpTK3VReW1u?=
 =?utf-8?B?MnV1NGJOVHdvTDZJTTJJVDAxcWQxVklVOUVRUFpIMEVMTUphSTlOdGRzbFhk?=
 =?utf-8?B?MzU4ejlQV1prWUtXV0VwNXFhNXJEbzUxS1Y1UkxkRDg1c3N4bUJMTnFTTzBJ?=
 =?utf-8?B?THRoNWNyQ3dUS3BLOXFCTDBPSWw5TDB2NHdEL0NNMHhjSlc4ZmFITTJ6UXp1?=
 =?utf-8?B?TEJsSmlhc0w3ajVtZkkyd0NMYXp3VTc5ZXZIRkQzVlZSUDgzTVhpVWdzT2RX?=
 =?utf-8?B?Y2Z1dlg4YWdQbFl2UXFOVGFrdzVVV0hIb2prRW84V0pNMldLSEtBV3EyVkRE?=
 =?utf-8?B?Tm9kQmtNMWtWMjg4TmRzQ2FrU2w5cEpqQTMrQlViK1BlcVA3Z1A2V08zS05I?=
 =?utf-8?B?NDVCNUo4c0J0U3lacHk3RWc4L3ZBUHBqUW5wdmV6dzR1ekV0TExyK2d3MU1H?=
 =?utf-8?B?cnFRK2E4a2dxK3JxdUJtdU5PS3NqTTRxd1ZzWlFLK2JXeFRJeEFHM2g0ZEwx?=
 =?utf-8?B?UWFLTDR0aVNNWkh4NlVZdlNSZHFPWW5xM2lxTTI2aXJ5dTlDalQ5b1dRNDl6?=
 =?utf-8?B?S25zRmZGdmVCd0VLSE9MeXMybnFvMW9PYjBjK2JXNzNKNFJVeldOeS9MVXdB?=
 =?utf-8?B?YWUyUDkwYXlKMmVRR1dtV2k1a0FTbG1GMmtsa1g3dmhzVGIydklTcU9GY2dy?=
 =?utf-8?B?ZzF3R1ZHNzNoSGdLYTJSdElYcVRaSzFMQXFnWDc1VFBjZk9WTWtvOHl2RHN4?=
 =?utf-8?B?Mnk2WkpJcGMzMFIzdWkveW9peTk5S0thS2MwRTVPS0V0OCs0NnpLcms5dkhi?=
 =?utf-8?B?Q2xlNHA5NVk4bXJpRyszZUlEV1MwdnEwUzNDN0k5TUdtZkZBTGZBVjA0dXJG?=
 =?utf-8?B?UnIwUGw1UFFyNTRVNGNvdVFXWUJhd2ZYU3lEanI0SEczeHNabng5aVljSi9m?=
 =?utf-8?B?TGxxMngxVEN1cEEvb0Q2MUV4blhQazk4dzFUUkZzOGEzYTRNRElEelpZUlIv?=
 =?utf-8?B?VEk4dEw2V2xlWUJXRWlhSittQ1R1MWtPR2RxOUpwbXFoYk1ROWUvYXVJT2FO?=
 =?utf-8?B?QlpSb0lRMXRzeFhXbi94ZFZpYkk2ZnNSYjZsbVBBdy9FN0I4TU9ZeHk2ZGVy?=
 =?utf-8?B?UEdhT2pHUFRNUTVVZnFkS0dJSkhaVzBCOWg4eTVuQ2NoVVpZSWdkWWFmQ0dO?=
 =?utf-8?B?NmZqcDA0bkJ3U004Ym9BS1EyVWRTc1A1WlUyVkNRbmxTa1JjZTQ5WHhyL3Bs?=
 =?utf-8?B?RnJ4S2w4czRiRjBPUUpQQmxRMzMzMWVMOE9EU1NRczVmZ2V2Tms3b2ljblJI?=
 =?utf-8?B?RFRhdzlYMlM0ekw5bytTcGhSME5FN3pZSXJKRTk0SzI4K28vTGlpRlFCaEoy?=
 =?utf-8?B?UWpObDlMNTNGNE1ob2FLVTRpbzl3YkgwZHM2Y0lUY1JISEtPbE5hMDN6U0Rj?=
 =?utf-8?Q?GLbPbhGWsjQYvDGc=3D?=
X-Exchange-RoutingPolicyChecked: k2RLe7A6UYQc3BjEpQ13ws5P4lfmMxmyfEIV8COTwexz1XWKczcqsBkdfZn/NEdJWOpVvsouC8nB9GaV9azH0A5Q4NmKOPU1+BTF8ma3iHl0AAnfLrG7p3bO1qz9atESSFD+rPDE4vexhtoy5GKFiN+W7zF7dTdK1+WNQ9d4DGaS+L0BTpp0XcV83c//OirVMfnP3MK4oK5af5Kx2PXLMBOGu2jCxT/0P4ZMdODM5fQkAhw3WlsJHfYah3x9CMkv8CGooAEi/zkvmR+WizNf4yuo71zl49/NlimZaAQPiF0DEX5YAZYtYwQxROrC2wsX9c5wiKYOsVENj46oLBrfKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e4a791-b2ef-45b7-0068-08deec7c9c59
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 07:48:27.7854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQz937ZmaLYg26FfM99SxVWtnbCsyAfiJp7rjGKN16/hS0WIZyE44+l1p1qi10wdBXb6gwySdOYUJEYY0HDQ8V0pMKfQJGZCXYi3t3F5uhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
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


On 21-07-2026 11:07 pm, Rodrigo Vivi wrote:
> On Mon, Jul 20, 2026 at 10:48:15AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] Calling `xe_device_declare_wedged()` during early driver probe fails to notify userspace because the DRM device is not yet registered in sysfs.
>> --
>>
>> --- Patch [3]: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting cold-reset recovery ---
>> commit e4801339581daca0be0db10f90d94f25e72cfa52
>> Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>>
>> drm/xe: Handle PUNIT errors by requesting cold-reset recovery
>>
>> When PUNIT (power management unit) errors are detected that persist across
>> warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
>> and notify userspace that a complete device power cycle is required to
>> restore normal operation.
>>
>>> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
>>> index a31e06b8aa67a..92b4181026cbe 100644
>>> --- a/drivers/gpu/drm/xe/xe_ras.c
>>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>> [ ... ]
>>> @@ -236,6 +236,12 @@ static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
>>>   	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>>>   }
>>>   
>>> +static void punit_error_handler(struct xe_device *xe)
>>> +{
>>> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>>> +	xe_device_declare_wedged(xe);
>>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> [Severity: High]
>> Does calling xe_device_declare_wedged() here fail to notify userspace when
>> triggered during early driver probe?
>>
>> If a PUNIT error is present at driver load, the call chain is:
>>
>> xe_device_probe()
>>    xe_ras_init()
>>      xe_ras_process_errors()
>>        handle_soc_internal_errors()
>>          punit_error_handler()
>>            xe_device_declare_wedged()
>>              drm_dev_wedged_event()
>>
>> Since drm_dev_register() has not yet been called at this stage of the probe
>> path, the sysfs directory for the DRM device does not exist, and the KOBJ_ADD
>> event has not been emitted.
>>
>> Consequently, userspace (e.g., udev) will likely drop or ignore the KOBJ_CHANGE
>> uevent emitted by drm_dev_wedged_event().
>>
>> Will this cause the device to finish probe successfully but leave userspace
>> unaware of the wedged state, breaking the automated cold reset recovery
>> mechanism?
> Mallesh, could you please add a fault-inject test to this flow here and
> ensure that we are indeed getting the notification we are willing to get?
>
> It looks that right now we are really never getting the uevent that we
> are willing to get.
>
> Thanks,
> Rodrigo.

In boot-time punit error, the device goes into boot survivability mode

and never reaches the punit_error_handler() → xe_device_declare_wedged() 
path before drm_dev_register().

Because of this, the dropped uevent scenario does not actually occur in 
practice.

Thanks,

-/Mallesh


>>> +}
>>> +
>>>   static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_error_array *arr)
>>>   {
>>>   	struct xe_ras_soc_error *info = (void *)arr->details;
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260720101815.526813-5-mallesh.koujalagi@intel.com?part=3
