Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C93AC54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D21110E553;
	Tue, 28 Jul 2026 08:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NgdxawEc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBC710E543;
 Tue, 28 Jul 2026 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785227594; x=1816763594;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4hFIYPSIv8yi8aYLssaqGowler86RLxGCkLv4H+uhVg=;
 b=NgdxawEceV92pNwu2zTAa2LMtwpfUg+4cV3xsp//1hD6CfYDQ8wXifRx
 S4LhMizSrfCw2fen0WPme1FUsvJzvymZK4Q6bMOgufQ6CBPq5yz+mEMEj
 LQkF7TS3oRdYOqMxWb/UOWzqx8AKd8lsWQOqZRkgfegmy8Yaslny/pmD4
 otmiQ56P+V9KFsotrwTdO8ulH3jEprj9Y2yLG0XaFWxBGf+bIz+bg0Ehu
 d/XWeyq9qIbQSW2Uu5vnLMHkeIhbSVp1oU2aCK6HuPi+ty9CG9JJmTtOS
 x28pJmLDEW65mY6Ldblra9PwTjRP9YgT0OjsTrj/oguXtu3sUwlmvmseA w==;
X-CSE-ConnectionGUID: s7uMldYJSoSfYqYPijyZYA==
X-CSE-MsgGUID: JZqNEu0wSyqvdR8icyPAdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85889674"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85889674"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 01:33:14 -0700
X-CSE-ConnectionGUID: 4j5S9UEtSIKl0W2Ism9I9A==
X-CSE-MsgGUID: 3upGSxnGSAyzS3T3gdEqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="255335408"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 01:33:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 01:33:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 01:33:13 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 01:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8AXWVpnAxqpybDu3922ZkNWPgLPqIHhFh6COoZpy26zSxvlHc3wLVor21a4PaNHbbVI4OxuRpdlKJBjX9KdrHmXC5sDBfHNk/v7iv6jEq6IqKDdq6HkiWdfHstVcZn4cXESGYvRVHyDTZxBkd2eVARPOzagnn8sVY3U8/8c3lpHzLrFN6nxPTwiY2gXdcrf3bthLinKtBiC5qPgWoiE9zyL/SCUP0Mpdpt5KFnkuxbxMcqaosl3ROzTavwoFIO8d0+Jki2o8penmR16i/Gw8kmu6aX2QBYB00gGa6wuM+AZhpYUNailtoqv/fj0e/AxqeG5sWynhRSt80sGqXQnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL1LAU8Ohu1jcKKmhIfKe7AUcoLyvy5hiAlStLuh/zQ=;
 b=KPPtcWFO52iF5wM2TueKS6rwvGqLHLF2HwBV0eXEqb5er8HwDHK6XKletNOunQ3xwmistqNtczgpyncTWzulBQ6PRG8mgsAlSVmt5bLTy8LFEu63gmWsvQ2GbAKnVYoXP/PFYYwDhhp7Vl7Decw3PNjqqj9r2aHLDduQ1k+GUGFlRHurOogCN64AhN20pLVkCJPCeKXrOwRi0oKuWGebba8KNPvJECj9WD9HV0Q/o9+Y7Mr5nwhErvyFoD1ambqncQ3qyxmF9+6UgYmwUgiVFlKzue6QL66XZSy6NjKOmE/XuT8JJ/Pyo8HbzJ1UI7o7sFiziec6DVMX81CzoDbV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 08:33:10 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 08:33:10 +0000
Message-ID: <1545d0ab-16d6-4f6c-a26b-445f6d8fde9d@intel.com>
Date: Tue, 28 Jul 2026 14:02:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit
 error handler
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <karthik.poosa@intel.com>, <sk.anirban@intel.com>, <raag.jadav@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-10-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260724100302.706685-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0311.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::17) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 141b0fe2-26a9-4888-deae-08deec82db30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iojFuxyfGskYPPOBXKkWRDJ05XB3quKWRMJgqGV60w5DqH7loExSiQbIIadFiNqdQaBm2w9Uny2kRqn2tZ1+ZRnRcvaLeYxbOSh1WqZoLLLkSse0h6t/TfXHq2bRg30EN1rxemefjva5m3DBejuHl9Nr/P1veBQbBkiCC0rBHgf+N9htpOEl+/qXyrH81Bp5Ev7sv64Bk1epqgWgqTpch6OSy3AqVFiwna6WncWPIrpV2PVcL1SwSU4+gHjUePsJ3x8NxrMW1ucU+yzZQbjNEbzTZS3xlRPhj4i1pBpYbNR6j5lsblC/XtGPTPtaMwiZsnFcQ9FL+YHEEegvVE/bxHz+EagibgI0EuRZFIpytdU8K+uHKVNbGajrOM5b0Wjpf6Nfy8sX74lodjCV0b5NqdO1qT82KPYC5iOyz0FzbOyNJEWIC21KVs6eq6rjrt8FBRNckZjJvptAJpJps77kbXa0tIqUEqOMoBFgNNyWSQ7y9EJH3Wti1qiDOqZEeWUQiPkWygVevpFEoJ6I6pKKFOYQPWyqshJUM9AsRV/z7OE49GzofhMUjwh6Y7drZLBL9st0FlTynG/KaEMhuqOdBPCeuj42zFT2vgygPWiQMPL8vk4hyz/Cv5fZZf7au3n0UbdABHjBZIO/QXf0NHg3NS0vOBEfFAF8uCIeAP4+5uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGYyYUJZOGNaVVlNRWlDN2g4akZnNUtmNW5Ralhsdmg1OW9WL2VsNzFVNjFO?=
 =?utf-8?B?V2hob0lVYjNJZVZDUlB3dU4rU2h4WCtXenZBcmZBVGJDYmwyODN5R0Y5SlZr?=
 =?utf-8?B?VzBCVHVkT1N6MFJlTWYwalJRTXhGaUt0V0xoaFNNejMvbDdIM2hqckU1aHV6?=
 =?utf-8?B?b29yQ3lqcy83TUJJYUNMbllFWVdXd3dlS3YzZWIyY3JtaWhDK012U3ZBUkRn?=
 =?utf-8?B?VTdqYXRQcW01ZmpSU2puSHhPeG9iN1VvYmJxK1NEYURJVDVRMUlQQ2V1aGN4?=
 =?utf-8?B?SzlSd3k3TnpvSjNXVklmUGJOTlc5VmNxeDQvZ3FPbk1yaUFaNC9oWjNIckU5?=
 =?utf-8?B?ZHdBNVFlTU9aS2VEeFBhZmdUUnJZUkNDMzFWUCtHK25OVjQyNEE3TTgxT3J6?=
 =?utf-8?B?RjRzamhKSlc1N2dqSWJmQSt5MkdUT3hXL1ZGN1I3QWh5ZThzTXhJRWtyb3RN?=
 =?utf-8?B?eGpJcDJ3WVdDQXVBbmV5cFIwa3hyUEh1Zmc3bkRIVGxnMjRYSUpEVWd3cHY5?=
 =?utf-8?B?a25RdXZLTnZRME42d29OeS80VS81QzRqRGpYYWl6eEJUbkxWT3F0YVBFaHhh?=
 =?utf-8?B?Z1VDdmFhTEpyMFplWDBUd2EyQzRxRHVjVGdrMm9KNE14OUVzWlo4Z3ZqRlU1?=
 =?utf-8?B?MVlQbFB4SWVaZXVCZ2NkOHBjd2ptSUJQQy9wUGhtSmFZV1V2bHFURHZ4QTRS?=
 =?utf-8?B?Z2hCTEMzcWxGUUVkNmxTRmpWZ2hXVG1RU2tPZ0ZhUmJ4Mm9FY2Z0TEVHOGoz?=
 =?utf-8?B?YTFOVGNyclh0UUFtZS9aN1hqaUhJYUZoTHE1KzFidWZMc2RMTm1pUEwvVFR3?=
 =?utf-8?B?UzNLdHF4T0NYZExLMG9qRWxnTFJHTlBTbE5TUksxWVpCa0hTMTBjOG50YlRN?=
 =?utf-8?B?WmZMWjBXU3MwSWxkckU0aVUzOXNKNXQ2ME5tSUtDelRUMHN5bHA4V1hDamhO?=
 =?utf-8?B?YmkvenphdEUwRHdQU1dPemhIU3lBYlR1cW95cVhMVXFsWTd5OWV3OVlsUVlN?=
 =?utf-8?B?enhMTnZjOU9lTVBtL3dDNjdMTTFnSmJ6RWxJOUx2eXNhSDlXRm1STlFXZ2dx?=
 =?utf-8?B?SFg3TkJ6MFR2RFlJZWpGTW1nTXVPR3ZUTElKR3dHVVF5RmsyV3ZTQ3dpTGVk?=
 =?utf-8?B?a0VNaWxyaFJUdlJ5MGgzSFNLMlMvYXB3ZE1zSGdzS3VqMnVoYkQvWWkram5i?=
 =?utf-8?B?WW5JS0hqRzVpZHlmMkZSa29jNjVvQnlFSGdmK1QxeUtUYmI4NEFGY1NDU2o0?=
 =?utf-8?B?clg1b2FUTDc3K051bzF2NExJQ0llVUM3TWpUaEE4WmswTzFRSGpJUURVNStp?=
 =?utf-8?B?Q3E2eWxsQk9SeUtCTnorMGZ4OEluRHcrZFlqdkFzV0xhUCszSmp5VHBCY0wy?=
 =?utf-8?B?L1pjbzV4M3hZVnFXUW4xekc1NUlhNE5QdENxWDk1TTJ2RUIrK2JtYzJidlBX?=
 =?utf-8?B?S1c5MVlWZVZadnZzT0ZmZkoybnhWRE9nRm9ITmVEdXhlZ24zZnB4TGUwR3A1?=
 =?utf-8?B?Q3UyU2JsMUJuSFF3QkM1dHZRVkp1dDR3dTRHdUJoS2MvSXk2TW8rUW1zUHRT?=
 =?utf-8?B?c3MweXo2cFNiajZPWHRhYTViVDliOWJLUjhVWTFsY0ZEYWdleC91OTBFMU5z?=
 =?utf-8?B?Y3paenFsYTR3MGU2Tm5rMHE4QWRJTGN4K3BIeXpqN2FIdnVvRC9OSmxkZGIv?=
 =?utf-8?B?ZG5SU2tCdThRT1gvMjJFb1podXI5dmJIRkpPbXZtS3Bsb3lPN1h0d1M5RDFI?=
 =?utf-8?B?VCtBa3p3QjUrTVhESTJsNllkTEh2UkV4cDVCVVVFUjFjeWNnNEN5eTR4T1ls?=
 =?utf-8?B?aVQzQzNJYkM3bzRNeFhOV3IvZXRTTzVIcmlmbGdoSnE4UksvNEFTN2thZHZ5?=
 =?utf-8?B?NnkrL0NiOHdaQ0ZRdTBzT3R6cDVleWJjQkE5SFZ6U0xlOXlxM0N0NGMwTSt2?=
 =?utf-8?B?SVB0QmF4ZHYrSjQvQXVGazVEWmZwTkV5dHE5ZXYyTEFDTlpsekYxS3ludmEv?=
 =?utf-8?B?bWJpVjFVcHJmZTVMWE1BNnVKVWVNSDR5R2huRGQ2bGl0K05vcDA1TXlEUG16?=
 =?utf-8?B?bXQzdnkwNHVPb05MSXlDVkkwWWI0cVlCS1dBb3IrVHN4WVFySGd3aU83SDlH?=
 =?utf-8?B?bnlZS09HZzVqdlpYM1h1a2pvaW9iTFJab0ZSaGt3RVJxL3d6M216TlJFZ1BN?=
 =?utf-8?B?NTA4cU0rQUxWOXFlRzFBSW04Umd4RkVxTUk3QURtcHZWbEV5MDZCU0RaZUNM?=
 =?utf-8?B?Mm9MMmx3MlNpZUJYR3VMb1FyZWpiZEhxbHN5S2VYN0RuVHVEcFc0aFI2Y2VG?=
 =?utf-8?B?RkdFbk55R0N0c3ZsY01ZUks4NTR5ZHJSSlBjYjQzWjBHbGJKcnBpUT09?=
X-Exchange-RoutingPolicyChecked: sAS7nTbfis24xaW07hgfkVUPcbMaT0wSSnKXd1T/NlktAP6wgoXaGboEGB4sVnZQDnj4t74z1RgsYymZAPLFPNFMtEid1t8+4JdUf3XwXsoN35tBc0izWv/tT+5/A6Cr0A2ORejGi+eSjR4oFKbGLmsyxhO5zhi+akMLCPWUJ9KwKtNsSL2L1oQ91R16VJrQpGuXa+W0KVvVKeMRcyQG29EPUPHZuQIg2ToY0tOqrnvr+cpWDCcxAVWqqwRo68OJYH+zZe81T/snoO0Wx+OBkH+Bugga3FFPk9bYPQuVwFpfPN0MKXtO5UYQHa2knYzAVWPivosgM9VWQRHK9b1V+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 141b0fe2-26a9-4888-deae-08deec82db30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 08:33:10.4101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB3E3hGS9zQ3unMKTMIroUMAPhY5rrPNTaqaz2EUm6/g2fduykI3m7NbQjh8P6GFOjdGpxOSWNIwC/0pjL5tbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
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

Hi Mallesh

On 24-07-2026 15:33, Mallesh Koujalagi wrote:
> Use fault-inject framework to trigger punit_error_handler()
> for testing.
>
> Usage:
>    echo 100 > .../inject_punit_error/probability
>    echo 1   > .../inject_punit_error/times

I think it would be better to have this as wedged fault injection 
instead of punit,
This fault injection is only sending a wedged uevent.

We could combine both wedged (cold_reset for punit and vendor_specific 
for csc) into one
if there is a better way to do it.  But that could be seperate patch.

Thanks
Riana

>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_debugfs.c |  4 ++++
>   drivers/gpu/drm/xe/xe_debugfs.h |  2 ++
>   drivers/gpu/drm/xe/xe_ras.c     | 17 +++++++++++++++++
>   3 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> index 5a3877fcb0f0..5599d493feca 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -42,6 +42,7 @@
>   
>   DECLARE_FAULT_ATTR(gt_reset_failure);
>   DECLARE_FAULT_ATTR(inject_csc_hw_error);
> +DECLARE_FAULT_ATTR(inject_punit_error);
>   
>   static bool csc_hw_error_available(struct xe_device *xe)
>   {
> @@ -62,6 +63,8 @@ static struct {
>   	{ .name = "inject_csc_hw_error",
>   	  .attr = &inject_csc_hw_error,
>   	  .is_visible = csc_hw_error_available },
> +	{ .name = "inject_punit_error",
> +	  .attr = &inject_punit_error },
>   };
>   
>   /*
> @@ -76,6 +79,7 @@ bool xe_fault_##name(void)				\
>   
>   FAULT_ACTION(gt_reset, gt_reset_failure)
>   FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
> +FAULT_ACTION(punit_error, inject_punit_error)
>   
>   static void xe_fault_inject_debugfs_register(struct xe_device *xe,
>   					     struct dentry *root)
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.h b/drivers/gpu/drm/xe/xe_debugfs.h
> index cd56f7442b99..dd57914dd4f2 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.h
> +++ b/drivers/gpu/drm/xe/xe_debugfs.h
> @@ -13,10 +13,12 @@ struct xe_device;
>   #ifdef CONFIG_DEBUG_FS
>   bool xe_fault_gt_reset(void);
>   bool xe_fault_csc_hw_error(void);
> +bool xe_fault_punit_error(void);
>   void xe_debugfs_register(struct xe_device *xe);
>   #else
>   static inline bool xe_fault_gt_reset(void) { return false; }
>   static inline bool xe_fault_csc_hw_error(void) { return false; }
> +static inline bool xe_fault_punit_error(void) { return false; }
>   static inline void xe_debugfs_register(struct xe_device *xe) { }
>   #endif
>   
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 92b4181026cb..da06c16cf7ed 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -3,6 +3,7 @@
>    * Copyright © 2026 Intel Corporation
>    */
>   
> +#include "xe_debugfs.h"
>   #include "xe_device.h"
>   #include "xe_drm_ras.h"
>   #include "xe_pm.h"
> @@ -391,6 +392,22 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>   	size_t rlen;
>   	int ret;
>   
> +	/*
> +	 * Only allow the injected PUNIT error once the DRM device is registered.
> +	 * xe_ras_process_errors() also runs during probe (via xe_ras_init()), before
> +	 * drm_dev_register() calls device_add() on the DRM minor's kdev. At that
> +	 * point kdev->kobj.parent is not yet linked into the sysfs hierarchy, so
> +	 * kobject_get_path() returns "/card0" instead of the real sysfs path.
> +	 * drm_dev_wedged_event() would then emit a KOBJ_CHANGE uevent with a wrong
> +	 * DEVPATH that udev cannot resolve, silently dropping the event and leaving
> +	 * the cold-reset recovery broken.
> +	 */
> +	if (xe->drm.registered && xe_fault_punit_error()) {
> +		xe_err(xe, "[RAS]: PUNIT error injected\n");
> +		punit_error_handler(xe);
> +		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
> +	}
> +
>   	if (!xe->info.has_sysctrl)
>   		return XE_RAS_RECOVERY_ACTION_RESET;
>   
