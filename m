Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5018DEBFD1C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7EF010E388;
	Mon, 13 Apr 2026 08:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aP6JWqQS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3825F10E386;
 Mon, 13 Apr 2026 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776070669; x=1807606669;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JBe/t7cyaQbvDhBUmryp++Cr8HVOC4NQh/i+K9ArlCw=;
 b=aP6JWqQSjCx1HkxrZDKuvEfJ++Sfti7WP5TE/e6Pt/rHjZjfD7fJo5Ln
 lLP4SM2sY+FniP9cOcrA2z+Mniu0fm9AWpZUgE5CqM9ZSRyr41CQyLhh0
 lCBIZ+55rrzgeopjQh/61CAokm7RpIKoLl8Ma+BmslxDzIHRRVlGTmhFf
 Fko56bLGjwFX/74lS+fNNT49kp5T4iBniQQ7u8lxGoL0ZBFME1U+8Qswf
 Vb4CPmAzzqo/Xgfam47P3eBmxE8RyBxBvwZS4EtgSAnLW2LkP8LR0DFmz
 IkUk2NJyGKRmmTLy/nstiSLGY2EX4uWVcGlyvz54oKoU5p/FuHv6LWyVR g==;
X-CSE-ConnectionGUID: LsBOa9MdQs6RRTa+yYs0Lg==
X-CSE-MsgGUID: LdeRlml2TcOGu6pn/4A29Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76709808"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="76709808"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 01:57:48 -0700
X-CSE-ConnectionGUID: COyY9oLZSSeyGOj2r5Uedg==
X-CSE-MsgGUID: affnUhCNTiCbt5eCWJXHZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="228693933"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 01:57:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 01:57:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 01:57:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 01:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei24vgIapeA+jqJk1Od2vdrEKUPfkU8b6xmzVEqLbHJ0mIgLHlW2dy4C9cz2IgEZADgd1/AGlLgAVTQio8qmGHeDWZLWfjKrfmO1RFNJjVsqsss6EOezUikU9LEQN9+h3A5XlFLTPeBk2+qEhhcwu7RHVb+qFjuoiIxIejAG6o37LeYy78NRlGLPC8R49GV/1ITVvwrg7MJGImxpQg+xvOtg/eXrYp8cyQC/81EiudJT49mxrsn++hxzlqOt9kYQBhgHfsjrSOfpfS5Xdh5W3MVmlolcSkXYA7Sdv7MhWIMGRrd8wy476KZjwbR+5/K1l0nNI1xQiIlJTW9PHa80eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgB211tPAXbEWRwMDPmGIigBNK4zqeufD6Uol38mFRQ=;
 b=JwPDKFFv0Z4vwJGvOG5Y/X1UqXjcVjflpHt7ENL0ohylWBZrADyvzXktY0n05U8aLS9QCSF+KCsRgGY9snUO2FEIJ7duZiCwtKJ2BwTqixMcdrL7pFlvRIclloJrJWXVioQs4s4lRTOmv/VUj7tyZGIDydZaUPoDmEhhyZQzexBrZim8JGzctFBJA5B4xYEwObJ8oRV63TPUqAr+pdqE1tCejks1c2Y3IPHrzxjNDUycHRr6rvm5My64qgOuWG/Qt+xFore6302ZswV0ooptAM6Nbrt6NXJd2XckCaxd3D14QEPqbJ+mq1gqzsLVFcu0C3UbshO9b21/PATxNkOOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:57:44 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:57:43 +0000
Message-ID: <a7455f4f-ba66-40b6-9de7-9ad95a99c941@intel.com>
Date: Mon, 13 Apr 2026 10:57:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, Ashutosh Dixit
 <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260409154423.2499340-4-satyanarayana.k.v.p@intel.com>
 <20260409154423.2499340-5-satyanarayana.k.v.p@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260409154423.2499340-5-satyanarayana.k.v.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::13) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: b3afd5d6-6d85-446b-e666-08de993ab9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 3wajkv0nV8VdZ6glE9ho/GjQedzD3stexwDzg5MOmXi8HJ8tYCYdrHXMDvB7Bw/tI4biaKPRzDH1MBVk3aIVP7eDduxgLAeIWVuURbWEVrO0k9dfszFQJlhvUxnSmClLMHbVmdTFw/zsfFHDli/hWzfttiEcl9GmUPqZ1n+lnDsNm60FDaJ5JiwdqcP8GMZUq07TSGexHryQg7MEEx2oZ6mcK+h7OSrcsSSsiS3U9r2MrwgYZqtqp4kK8FDawuQ927KUxj2DEBMM3pz/WAh4yR64vQLqOtuZxUozRVnjsW4WJt1fM9r2/Ng2w79VJD3xpwWYLnAsZRX889U6nkfLf6Xk2NUeAlUz82lqY4olvsO+H0wap7C5/1EqF8DWg0ohXNKz/jtZEzSr9RKnvl9E4pFdeNBg+quoF+L2xbyqXHilZV56atVwM+oQ6aKiN0dJeNSMxyPSsIihDOFFEB5oSxzdWzGQIXraTHkFUk+i+Ag/4kGPM/10wTxuyvEQWvo/jxz1Zs82r3j8MNBqbT5anMcvw++2VuPjiV5C5idvECVGd7JyjwQDljjocGstnb6fweD8GFG4HJbWTRzRj7oUEOajqykTe6pM3NI+1BlDkEDgjvDd0IVnT+TA9XohIIbwAazBTmPVmKlYcejTveymZ09zrvEW+qTn1HyA2YbvdtkR0ujJgC191wip/deY43PCFlWyu+faoRl/Lg8G/TOVY26HF9p6LFDMhNGMD768g8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6011.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtxUHd6Y280M3ROK0dZWWlRajB1ZCtFRzJvRk9pSEkyWFExUWhicGhMNEQr?=
 =?utf-8?B?VVNpanRsWk1BeTVnRFJ2Mnl5VzlBLytMNFhUV2JmbVBXYWZoY1hoelFlMENw?=
 =?utf-8?B?K2M4TTBWNTVOZUVHb1BZTm5BdXpSbkJpWDNvTmxhdXVRWTFDUWFvUnN5MEdV?=
 =?utf-8?B?Zm9Ga0thbnRaRFBXTTdsQjhJbUV4QXpEVFhneXRlQlpZN1RNSWJFd3BaZEw0?=
 =?utf-8?B?NXEzeUlPZWkwd2V2b2ZxTHRlL2pXaUNtLzRJRVAzZ0h4WDFhMHIxUG5YR3hB?=
 =?utf-8?B?UkFJdGZWSmVJMlRpZ3RhTXpEc3ZFMkFVejRVekRLSTBjcC9RMTZTUVJmT3hz?=
 =?utf-8?B?bk9kN1hQN09Pai9OR0w0RFlrYlVUdkJ3YU9FZmFma2o4VDJ0UkF5by9GTDdx?=
 =?utf-8?B?aXdEendaQ1UxTU5UdS8vZ3NTOENDQVJHTk1zVENCMkNYc3YvMTBvckt6NDFB?=
 =?utf-8?B?UVA5U1BhbW9MN3Q3Z2p2UW16UTZDNTZPenBuYU5rSkVWcUpxNE9FSWR2WS91?=
 =?utf-8?B?SHRnZnFMZnI2MWdqaFhpeWc0TmpqaGg1L0ViZklUMnQyWk5WUmNmVnFNZ2VD?=
 =?utf-8?B?ZnNxTGJmV2V1a2pGcXI3SGQxQVE5K2tEdmJpbFJlVGZRZjZQaCtlWmJDWGFt?=
 =?utf-8?B?MlMwanltN2ZNbW9lUkV6djRTcnlTYUVqY3ZjQWJIMHdDWGhiMENqejJMVE02?=
 =?utf-8?B?NklPb05kTTlWU2F1Z2hRT2xqUGdCNnN5ZzAwQmU4ZHpyQnZqeG1EaTljQUdt?=
 =?utf-8?B?U0ZYUDNaQVJ4bDNyc1dGdWZVTlZ4VWVJS0prY2dablZWQWhmdmRPVGM0KzJ1?=
 =?utf-8?B?YzFxejc0UmN1ZlprTmxqMDIxd2tmYXdBWG9vOXowU3RMMUZweDJaVFF4bURo?=
 =?utf-8?B?MU9jenFrbXF5bGxKRXA5ZmhWbTFtZ3VCVUNUVmpCWmpaTUdlR1JIVFgwMnFM?=
 =?utf-8?B?aDdnVjNnZ1FjeHVmZkhkUjVIRHArWHdxeFdsN0IxVTk3ZEF2bzJxdzhYTTBX?=
 =?utf-8?B?NFFPa1ArQmIwSlJVSnZPc1lvL29oR293OEFmekk4YTBFeFB0Kys5bklMeFVx?=
 =?utf-8?B?WmdsOHpIT1R0ZzUwVUl4b3J2MDAxUWtrUnV0U3F4cHFXOFprM0JTcmgzUW1n?=
 =?utf-8?B?UmRzWW8rdXRmTG5DV0dpMHZGeE82N2hHZDZhZjYvaEJrbzdsMFpRTEpjK2o4?=
 =?utf-8?B?Qk5PT0s1MVZsMmluNVE2dmQySGJrS2JaQ2tycnR2Q0RhVExvaHFsRERDeUhz?=
 =?utf-8?B?RjgvVC8wazUreEZ5cFQrZi9CRUNvdWx4elBKMEFFeWszTHBLTXZWcnFTWklk?=
 =?utf-8?B?enB3aFdudEdkOXJrdFNHWW5FSnJ1VjUza1NOcytWWTQ3L2RvaEtuRXYwVHdS?=
 =?utf-8?B?YlZzYkdidEN0a0c3cUZ1SWJrdU1leWVGTlpWZXMrWnp1b0hxd0dqRjJNRTEy?=
 =?utf-8?B?Z1lQOXVQMWpuKzJBRGpuVmhVclFKVFdXRVdqR20rVFl2Q01Sc2dIZjVmQUpH?=
 =?utf-8?B?SmN4b21Gd3htSHBkRk5mVDhJMWZ3aTJrbzBhZVNuVUU1eHpjeVdEUmtiZS9L?=
 =?utf-8?B?U3g3WDY0bk40TCthTWE2R0t0M1V4UWxKZmRpYUk1VnpldmgxQW0wcG5vSWFX?=
 =?utf-8?B?RmlOcXJXbkhQV1I1WGtvM1FWVDYra21vMlhBcVZVK2R6TWdDdDUzWG5MTUhB?=
 =?utf-8?B?Uld0YjByTUwwY2JndDV2bDVVZk84U2tIWkZiR21TcWJNdFRMV3QrWmZPNzRL?=
 =?utf-8?B?ZGVEN0h1bWJlNVBBRExkSHI4b1lTTHorR25iNjJxR3ZpNmpaSDY2dHlpcjVz?=
 =?utf-8?B?WFBFbFBqNnNHS1QydVFuZnBGOXQ0UmRsZ1BqQnNVejFvSDI1cVRZNFdHVk5L?=
 =?utf-8?B?bU5seXRyWmtMbHRzUE56TWZjSS9aenY3YzRNZzdhN2MvVUwvc0puNXE3aC93?=
 =?utf-8?B?VlVzWXYydmlOTkh0UXZRUHZXRG9ZNDhwN1dsOC85WnFWTEJ2cGJBR3VmSjVI?=
 =?utf-8?B?WWVVRDUrcW9QT296WjhFcllRU1p0ZUN4Q3BTdUdIMmxDdDlmbFR3MndMQjRo?=
 =?utf-8?B?Q2RCL21RRm1HL3BqQ25Oa1FDU24yYVlsblNHWGp5WTNRbmVocWhMYVRjdWtq?=
 =?utf-8?B?NkFmU2g3RHgwRVo4N1N4Q0ExNEZxNnZjWmd1SzNNRVVZaFZCM0ZteWtyNnFX?=
 =?utf-8?B?R0VhbGJERHJWNnNKU3dIRDlCc2N0UE8zTDZEMDg0WG1OZlpDZVBMLyt4S0hP?=
 =?utf-8?B?NnZ3a1lVY0w0ZmdtMnd0YzZLOFpsTWpyQ0Fud2xoMDJTRTRWQ2lDZmtFYXFL?=
 =?utf-8?B?ZWtIMm5jK01BWVVaejNQZloxUTRjaE50QmdwWlV6UE4xamF6ZHRhWENmTHB0?=
 =?utf-8?Q?ugSajDDCRFzZPLQ8=3D?=
X-Exchange-RoutingPolicyChecked: BeTPgwuT0aO0yAPJg6OkauNlnS8jkjCxU8oW+PH0wWBwjsTGTTNUiX3RqHNEEg9ZPge9NVLdAzvLkRZhE2njkByYJ6gNwTSC9FAIpPb0ywwmYOgIZsCUXU4h9o5E8yOVwHVanOXJaUuuUP/zZpXqFIwC6Su8/zCJbEtrUdq7FSJ3uKbH+tQKVe1kxHQ5RjVUJJzvl6VAFZBkJnU2yLW5s0Dj6dfUXquFlBMHeDKAyNBq43hBDrcR9yOqYtmPlkon2UEoGihfH6XwM2OVm0chGBtCc8mz17dRpEzzGqB0mFihDOM+YyfT5eyrrVWWn/p6V3RAODxQfAK1u126DSb3Wg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3afd5d6-6d85-446b-e666-08de993ab9a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:57:43.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ueha7kPQcCOd3RGcfzNmjA1fUhlXiTWJIx7xU6aIM8AQB9HnEZkkpkp7rmhc4vLU0L+08J8YbujmGBO9AxvHFV+klkZlKCbRsAd81h3t9bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
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



On 4/9/2026 5:44 PM, Satyanarayana K V P wrote:
> When a PF is configured in admin-only mode, it is intended for management
> only and must not expose workload-facing capabilities to userspace.
> 
> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY and
> XE_OBSERVATION, and suppress capability-bearing query payloads so that
> the userspace cannot discover execution-related device details in this
> mode.
> 
> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

> 
> ---
> V10 -> V11:
> - Moved xe_device_is_admin_only() definition for !CONFIG_PCI_IOV option
> as per review comments (Michal).
> - Fixed some more generic review comments (Michal).
> 
> V9 -> V10:
> - Moved some parts of admin_only_pf mode under CONFIG_PCI_IOV config
> option (Michal).
> - Updated commit message.
> 
> V8 -> V9:
> - Memory regions are skipped in case of admin_only_pf mode (Michal)
> - removed .dumb_create, .dumb_map_offset and .show_fdinfo device specific
> operations in admin-only mode (Michal).
> 
> V7 -> V8:
> - Fixed issues reported by CI.Hooks
> - Updated commit message (Ashutosh)
> - Removed gem_prime_import from admin_only_driver structure (Michal)
> 
> V6 -> V7:
> - Allowed xe_observation_ioctl as well with admin-only PF (Ashutosh,
> Michal).
> - Updated commit message with steps to enable admin-only mode (Rodrigo).
> 
> V5 -> V6:
> - Updated commit message.
> - Return number of engines and memory regions as zero instead of
> returning query size as zero (Michal Wajdeczko).
> - Allow all other query IOCTLs excepts query_engines and
> query_mem_regions (Michal Wajdeczko).
> 
> V4 -> V5:
> - Updated commit message (Matt B).
> - Introduced new driver_admin_only_pf structure (Michal Wajdeczko).
> - Updated all query configs (Michal Wajdeczko).
> - Renamed xe_device_is_admin_only() to xe_device_is_admin_only_pf()
> - Fixed other review comments (Michal Wajdeczko).
> 
> V3 -> V4:
> - Suppressed device capabilities in admin-only PF mode. (Wajdeczko)
> 
> V2 -> V3:
> - Introduced new helper function xe_debugfs_create_files() to create
> debugfs entries based on admin_only_pf mode or normal mode.
> 
> V1 -> V2:
> - Rebased to latest drm-tip.
> - Update update_minor_dev() to debugfs_minor_dev().
> ---
>  drivers/gpu/drm/xe/xe_device.c    | 57 ++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_device.h    |  9 +++++
>  drivers/gpu/drm/xe/xe_hw_engine.c |  3 ++
>  drivers/gpu/drm/xe/xe_query.c     |  7 ++++
>  4 files changed, 72 insertions(+), 4 deletions(-)
> 
