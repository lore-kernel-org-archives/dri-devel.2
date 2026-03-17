Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33502F33812
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A0E10E59C;
	Tue, 17 Mar 2026 08:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mFoAe3sD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5341010E59C;
 Tue, 17 Mar 2026 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773736029; x=1805272029;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ze1f1cZr0xbSuJmGT18h4vXqXGv6MW030KiKhXy77es=;
 b=mFoAe3sDMf/W5yL9+IIIuaeVvlUgeBfFFqutdN18rE6PgafHw6tnxew2
 6ZbM7d+qHD6Q+cbvElM8B9ytUwHKFB023vs9pyIa+giaVPjBewq51ZHsA
 0c1q+j7hEmK3IXIAuYjuU5NeygGpp/asZxOU4rMAQSiC+7uh87gnfpudw
 5keBrU/bmuNyDWl8tfFN7o4Qed99mpScx9dWNlIWA7zoFKhPaQf36x2yR
 RJaSrCsgmVL4+ook1n4XbztnMiDkT5Dl2V5FAjN2SJl1RsOS7ZXOLBr6G
 yZJAVcR1ecGRpZI6FzxmFAB4yz/dPnV0qCbwoDPVpxqCygXqnrRIIumWh Q==;
X-CSE-ConnectionGUID: 8PT7DKtLS8CGJWxljOFbig==
X-CSE-MsgGUID: NMYzstocR6qG1j+3d80/iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74840730"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74840730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:27:08 -0700
X-CSE-ConnectionGUID: H+ltW6dXTh6KrxzdiPz6wQ==
X-CSE-MsgGUID: XAMnuFW8SSaPSUZcj5PGZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="260100356"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:27:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 01:27:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 01:27:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 01:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+ieDr5stnJvwUf8P6DjE/RoX9TFC/5SxkrqxZRjYMe7mlkzSoTQAoJff7n3y2dTvZGn/O0XMq4iEpZQFLOk287GTKzO2gwFpOGMl5MfjGUTk1+T0v8sputRAZ9gDE2sHTMy9zEyTd+i2+sDxTpchFQn+AO2ksSgGSfRPv5evschgefyhHiepc2JtrGgsKvroAP0g5ccipFJrstVNIInsdof+elAIgHwbvPWCbiqyOZrFQyYAGyYwdVrejYp2H6quKxYDiBVdUyiqz7QipPdTMyPD6BK8pcHCfebyKFWorj63ib62BxL/wMeyo0JIOGq+lydYcd6GS3JH73s1PSGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJowOIKO7uHGEdJ4juMTBV3bq7l7uMzwP6/zEOoORNo=;
 b=QFxGJLw9SctdCzdAufjTzuz9+pbqyxSFuw0gyXbCNcrXwynODR/VmtRg953qlyJYdpEoQ141CT0JCSLe8rcUG2HskOafVyhim9i3mzZlrPrRUx/EFRhTKti1NVLBvXpSMJyMRwqk8d4aGjKO3yvIDujWlyGhGTjGNshkX+bLW/+Gnk5SeVxDSwY8H+fBUsPmT6z736lxp5W5W3JxhWx5SiC/zzTirdO5BdesL9NsA9SsUhmrDYPFgnwLSwnSILjfAYIHy8vdXWxyv56d7GgYA+1NWs/CZzKwbuZcjzMh+Imm2T63omVqDpDgM193bcl3/KVoB3s+KyoyewbupBiCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Tue, 17 Mar
 2026 08:26:58 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 08:26:58 +0000
Date: Tue, 17 Mar 2026 01:26:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Stone <daniels@collabora.com>, Alexandre Courbot
 <acourbot@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot Courtney
 <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a2e2e3-ab5c-4dd3-5f40-08de83fef493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2sDNFO65X4paoAIrq+CYS/edjCLQvmIIRcbRb48VeR0YBYg+49YIdRTTzPlzyWNrs6GhPYQ+4lofDmloQpuE12YgKvbtfjjinZoVrlRIMpWdUdslhLZ6vtbaDlomUB5leUjw+rQQv53bHYcIv9QZ4NTyYsc9eDTMDt2DbuhgfSKRHKy8LDkI12Tp7CtXcqrytkpaSvrFHWgTq4Cj53h4U2LQkpl4mx8zKd54QjRvyojD2c/2LKDIdRlz009YhvTVUJm6yiB21Kv5n0o2VL7DiVZ4L/Be4jJj0BJTabN56YiPa3G4uvGqFD/eMlahoDG3Fj70VK+gPj20ktcuAPf27N9es0Yk+lRnY/KqqwEMH9PW0GWQ/h9XEEtaDYIz/gh81fl44bg6wIu7tBIw1TziBI4DoLFn0g8R5FoVItmYaEs902gPdw63AleAaCq6E7ZL6ZASHBhYJnEmfOlPQ2LsbeSYYN23cwv+JWhvbwE9W/7IAjf3BAdf1Jamhj63FEYkxCwjSqLOLFsL7ChqpvxEFphM7IlhT/9HrXprqSGTxm6hkyLVWyw+mUMuAYTcslstVsNbs6e28kBpd1H0CLCnX2OqWDotajx+zzbQLLG8u0ybf+xV5HPWpmaSM3BfEoenguRD70EHwsPXf2bwaEJtHZPR8HKNf15EnwGiU8Lflcc7SIlfwXUMblPnSxZENr7+50Mp0RTklG9QhwuPqJAyznKaQzbd7YD6ykftn2uHmG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNXV3AxNmpJd0psVnBPZ3RVa2FMZldReGp1bVh2eXh5R1JVZTRKNSs3NDla?=
 =?utf-8?B?dnFnNWh0VlF3cllqWndPK0tXSUtqUUVNU2JxM3htMW5FVkVsckdrOXlNU2s4?=
 =?utf-8?B?ZDY1U0QwdDNFdFZ4akpBOTVWbFJjMW1uYnAza3VvTGJBUm8xMlFKR2ZPZEla?=
 =?utf-8?B?OHAzVGpMTG5xNldGZWZ0QmI5NGdlVTQ4N2lSb0ZiY2d3Q3pBaVMwdXlvZGhz?=
 =?utf-8?B?QUs4VHFKd2NySUs0dERnTlE3STBEV1RTNWN2enVvZHA5bWhEOXE2dE5xODNr?=
 =?utf-8?B?TjBleGlFTEdTSTU2c2U5aDBXekRhZi9NcXBYaFVIeUxBSU1sekZ1Z1JMYjQ4?=
 =?utf-8?B?SXhzeGxKMDNhUlpaakFYMGlmcEdWa1hzSHFKWHA0NVozWGlCSTc0ZWl2bDBy?=
 =?utf-8?B?MXpsNWc5TmdPQ2NoZXJIYUFtOWo3WkRlaEc5S1hxM1RXL1Rwemk4YXFXWklT?=
 =?utf-8?B?VFV5ODB5eCtCZUhKOUVFY1g0UUpJb0N5cTFaVUZzdXRod1Frc3NiSEJtc3lo?=
 =?utf-8?B?bzJ3OXJEUXgwclJ6UmViQUFPYUFpeDdXemlzQytKMEVyWGp6SmNkSXhkSUhO?=
 =?utf-8?B?ODU1bzNGVzJ2azFQZFc3NUhzWi9qaDVsVloya3Z6QjRlWmRISHpuMTBvZDVy?=
 =?utf-8?B?YitpcXV1SVZvMm1sOExSZGNYT3lxVnFwL0ptZk8wSnRBdFZwWW9mVzMreTlx?=
 =?utf-8?B?ZnFjYXNGM3gyeXlDK2xKYzVQdm5MbkNqUmMwRVNmUUVGVnpJYkVrZjUzRVVm?=
 =?utf-8?B?dFpmZ1QzcjJJaWNGVVlIZnhuU3B2aFlLMnVQRlZpNmZ5UFNabGJscjlLMDhX?=
 =?utf-8?B?V3RQRng3Qy9NbHlOTFJIWlp3Mi9kay84TEhJakF5U3cwTThRVkpBMEk3SlRL?=
 =?utf-8?B?TnQ4WTllMXZlSTFsVjZyUVBlSEFWUTFIbk9CblNQWHlBcGtiMmdSRkxCbE5Y?=
 =?utf-8?B?WW1FWjZvbHI5MUIyMENHOUM5VU5NNWdudldkM1FXTU9CNllESVNidVYxbXV4?=
 =?utf-8?B?R1pVc2tSaGxWSm1Ydk1yK2RVSUtkSWc2dFRLMDNIb3ZSeDNFMGJRdWJIRjVY?=
 =?utf-8?B?WFNVMjVoL2djTTNRVmlVdnRCaDlBY3FZQmt1dG5CdnlTZ1daNVlJU25QbkVP?=
 =?utf-8?B?bHAzdENQQzVteklFM1U3TEFvNW9JUktaM0NtSzl1NGI1Q1hITXZ0ZnVNRnpi?=
 =?utf-8?B?bVNOS1JOb1pJSVRuemFORUdsVndPZXNSb2YyVWh4ZVJPaFVtUVh0LzJKVVFH?=
 =?utf-8?B?WS9xY2xMZnZrSUNsZG52cTV4R244aWxSTUhEREgwN0pLYjZxaDN5QWoveXZC?=
 =?utf-8?B?N2YrdmlBTHFNSExsMVRxb2hDRyszTWhWR3RidDZaK2FzVXZkTVNheFF0L3pE?=
 =?utf-8?B?ajhpd0RBbjNTeUF0a28yMnZoT2wwM3IrL1l2QU5CbTNadFREVUF6eHZCdllu?=
 =?utf-8?B?WElPRCtmM1luRDNUeTZpOEpOR1p5UjdvYUtXaW5oTmJSMk5NcHl6a1BZNmJ1?=
 =?utf-8?B?VisraFFCdUdvMkhVZitjeXZOcjZ3MStReFc2eFh3M2JaSEttZmdVYzV5S2lG?=
 =?utf-8?B?ekVLMmRxTTdTM01abUQ0dWJwVlYxUEQ0MmU5Zmd5MDBLUkhOS2xxU2gzcGEw?=
 =?utf-8?B?S0N2RkhQcTUyeTdXTGVuNHFDb0lZSmIyWTh3WmNHekQ4SzNSbVRmeEVVMDU1?=
 =?utf-8?B?UVJ2WEQ3VTNWTmlHc1BjVEdMYlVRYjdHaFp6TXNYSVVPSXVLRk5SMFhmZTBP?=
 =?utf-8?B?c0RFWVh3TVY4R1lLbFJrRFcxNGEzUktEUVlZeldjdGF4NXptMUNQdUFETkNK?=
 =?utf-8?B?QzVma1p4N1V2cDhxQjRYajRmc3V1L3NXSXc4T28ySERhUEg2amd3SDdpcFdU?=
 =?utf-8?B?ZEllb0FNcDNEaWw4S3pYajE3Q0dldEJqUmwxZ053cmhRekM2S3BwZng2WWFC?=
 =?utf-8?B?T2NQdTdEMDd0OEU2ZWlXTUNNRHlwV2dSMUM0WUR6TmFheUJoNC9hb3lKNDdr?=
 =?utf-8?B?aVEzKzRKelpSc1Z1ZmU4Zm43QlFsWjJtSlNCYnIwYmY1ZDhUTi8xUTdmb0Mw?=
 =?utf-8?B?VWFDUDZwQk5rSFFjVzBZVmE1OFdVcmh6SFJKTkZ5M1l4UCtDK0YySUUrWjRx?=
 =?utf-8?B?RjFNTXZNa3VpQWErc1BzUUFnZFdLNHk4WWx4eUxocldYUzFWQkFFTjFGSitQ?=
 =?utf-8?B?OTYvb1FrSDduVHVjQ1d3WFVCOW94WUtxWGpxajlGeXpzMDFvUFhFQkhWbDVa?=
 =?utf-8?B?TUczNmVMWG9xZW9tY1oxeHdoUFdDMEsxU0dJcVJTOFM1NS9jZCsrS0x0T3E1?=
 =?utf-8?B?MkxDRUxWanpLSFhJVmN4SVEySWxSdXFGclNtamJZbG9RZ0VVcXZhdz09?=
X-Exchange-RoutingPolicyChecked: ET2Pp7LdXzptm8EX2Gdst9iuj0rIn+xO/D+IfCxOdmlxk5UEdCUbsmQL/AH5I/WGQAODqkQw+bffynFIsR4tLJeorVbSFrT7kIhkrWnmhmdX6scNooVpg027XLeBvtllFtezuebceMbIjZnmB8dLM5Onp23Kb2KH4LCKx46K28x6yQADIqeXQPfA60v93ccLrApVxZWmtuLrCswVxf0BeWIDciUzfLOXw4MBRCXFpTYljUItkw7hd1ROaScpNbbJemZSrObSPCgmU8gbIeRzZrsRjY4lmU0zbQKFutyHnQQwl7JaYx4o1IE2GHmKpQaoMrsuKYT1wJa+VtmnY89+4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a2e2e3-ab5c-4dd3-5f40-08de83fef493
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:26:58.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBCJAQXqT8uEHaJKWdvcjdO/TYLUL1k2ydiY1WAsoMAFVkSch6HhAMhnFlZ82cI6BgfH+okMDYe3niq4W+70HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
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

On Tue, Mar 17, 2026 at 08:17:27AM +0100, Miguel Ojeda wrote:
> On Tue, Mar 17, 2026 at 6:46 AM Matthew Brost <matthew.brost@intel.com> wrote:
> >
> > You can do RAII in C - see cleanup.h. Clear object lifetimes and
> > ownership are what is important. Disciplined coding is the only to do
> > this regardless of language. RAII doesn't help with help with bad object
> > models / ownership / lifetime models either.
> 

I hate cut off in thteads.

> "Ownership", "lifetimes" and being "disciplined" *is* what Rust helps
> with. That is the whole point (even if there are other advantages).
> 

I get it — you’re a Rust zealot. You can do this in C and enforce the
rules quite well.

RAII cannot describe ownership transfers of refs, nor can it express who
owns what in multi-threaded components, as far as I know. Ref-tracking
and ownership need to be explicit.

I’m not going to reply to Rust vs C comments in this thread. If you want
to talk about ownership, lifetimes, dma-fence enforcement, and teardown
guarantees, sure.

If you want to build on top of a component that’s been tested on a
production driver, great — please join in. If you want to figure out all
the pitfalls yourself, well… have fun.

Matt

> Yes, the cleanup attribute is nice, but even the whole `CLASS` thing
> is meant to simplify code. Simplifying code does reduce bugs in
> general, but it doesn't solve anything fundamental. Even if we had C++
> and full-fledged smart pointers and so on, it doesn't improve
> meaningfully the situation -- one can still mess things up very easily
> with them.
> 
> And yes, sanitizers and lockdep and runtime solutions that require to
> trigger paths are amazing, but not anywhere close to enforcing
> something statically.
> 
> The fact that `unsafe` exists doesn't mean "Rust doesn't solve
> anything". Quite the opposite: the goal is to provide safe
> abstractions where possible, i.e. we minimize the need for `unsafe`.
> And for the cases where there is no other way around it, the toolchain
> will force you to write an explanation for your `unsafe` usage. Then
> maintainers and reviewers will have to agree with your argument for
> it.
> 
> In particular, it is not something that gets routinely (and
> implicitly) used every second line like we do in C.
> 
> Cheers,
> Miguel
