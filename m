Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C86CC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7C010E501;
	Fri, 28 Aug 2026 18:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MfxVlU4+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B919510E04D;
 Fri, 28 Aug 2026 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787940416; x=1819476416;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=01zrEFw1An3NTSpy+OvbeEp5q9YFe5bAXbn9tiqi6GQ=;
 b=MfxVlU4++SmiUNi00THq2iRdVuEMH7ezJJsMJU8tooXO1L2OnzEKMc+g
 xs5fvvSsVsV04jrOgLi3il0qj0Av15sUNmXZzkuPqdhrEluRE5r/sT8eW
 7V0LUZbDuj7k8kZwChu05RRAgGGFOMh++o9bk1DRNBL2WMGCxjeO5+Qb9
 hP163IRw/FKLY04jy7VdoGVL00HcZR09nN/7wmZZhfspyNsqQWBcpP/KM
 xDaiOCkiw9QFHXfgJXyTLcE+Tat7sJLbu8+NUB0vsH81zvBR/86Qt0VYg
 3e0GqPM0eba1B3nOr9UMARC+iWq+GJ2/aeGzi8joXzlcvxkJAhtR5GL+s Q==;
X-CSE-ConnectionGUID: UYSfrCvGS3mYgFlTk7SzbA==
X-CSE-MsgGUID: sZyVI/ogSSajNqetiI6FoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="105980287"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="105980287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 11:06:53 -0700
X-CSE-ConnectionGUID: uxkDL938TkWnbSoTqRr9Cw==
X-CSE-MsgGUID: RQNcCR2CSm+6sjlf/skDcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="265635488"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 11:06:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 11:06:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 11:06:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 11:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ/Z9rTtVytytVKv660l50rXz1e/0k0omMzXrX0IzHYbhJzeN+QdQNk3GzQUhv+Celz+FwT+sbZWI/I+Cv0xJMse6++bOFbU2FTI9JKCGuCq+XygVhvSjZIuOXO3Wa2jhMpxzxYlJ/PYfKXrI2DOUQMwY1H85ycbjHUM7uuBkq5nhxt9q9wXKtKfV4DYa86j2R7Hd49GWXfMPe8DYu2TevJqQrW9/aiBKp2+mhz4tQ53QLFAXfLnriGxWR60IkMesICucnWeuD3sb2+Mjaiv72MUM5f/71/4HdwGfLGLGcLbRifwtCCLXqWbfB5q2RQN84SaSMAsH7liko+VucTJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik0I2k7aaOEdI0oJiWxk8+7wXyORjv2wYiSq7RPKevo=;
 b=E/uWDMAM6rVzZmf4FVtavV4nZpjnnKA0TXxeb2IxZoneiLlow2qo0/17m+UjfhTzeSwbWKl7eOCk22FmSD8R0IkPEQoTMJbvxnwddJxwcK6mnGLvOxSPhsNbZBAn4S/jnjuyJu+oNV8DsFpdCbMfUXmN3/p0xpd1dwn6lBJDeM22VMsJ+yUR2UnE5hvAeq21LgyBNUrPaHddFusFRtF86/cZ38vXXadrvevFknGxmJ2lHwoNi7D+muWX8SCaSuvptFndGSzHGmaYriM9dQ/O+QgCBzbx1S6/6y20KgETPAOzXECwaOkvTFiDQH6Zn0uY0WZkaoKPBohkcXg5CgHjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 18:06:47 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:06:47 +0000
Date: Fri, 28 Aug 2026 20:06:40 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 6/8] drm/i915/gt/selftests: Use drm_* prints in gt
 selftest helpers
Message-ID: <apHNWOs7VIkBHj6M@kniemiec-mobl1>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-7-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-7-krzysztof.karas@intel.com>
X-ClientProxiedBy: DB9PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::20) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|PH7PR11MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4e14f5-b09d-47e5-cd7a-08df052f2060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: Fj70IZALpe8rHKFlpBHO7HVD5gcpq2p4NcV22vITL9Odh0dBT8+/S7t1yymYL+baDgFjzpZ9mCglUgs/f74w38y5Yf40f8pJ5BJk55Yrg2eof1ksFVx8JXauOaOBAG8Q2AiY41zb7pzH4DEqYmmTI4uNndVILuyHLcT1GIh1wchbrJJAt6NbKd5rarNLjnnCHtylq8kowsx6BwC72HcfgUfII4IDHdH3OCDHKzbu2U28AbfWNUuKiMAwn5tLef4ofHWqx2OeLkqNS4QQ+XdMVwQNBDRwibKCRqoA2e9qlyF1lMliXZ4KV7yLpVUHMrcH9/XaQCjX6SfUjBgqa25wN/GLGJaNcF70/mRhmU76C8vuSwGEN7llvCyMG5tMsa/fl0v1rzRXBxvKM8xJ4BUdgn2Avs7PfLPBOKb495v/4/g2gOTTw8XRwMgy9jzAc8M+Mei6ICDy7AaUdKwL37uHSwoF4JRiPhGR9lNam8Kv2oX90ppRuDCy3po4puvgBxKUgoL0WWfmDhX+mkwAwl63R+krjK9YaAc9kOx7QW/MyChUnZ+ckSZCxjVaVBPxfSF2cfRfi0iXlmjAl0Moa/GUGcamw0dKRy+F8rjRMWNoVAsaULJTKbrMhzMPP0Hw46o42aLCHn3gMscJz0iJYLS5oiwhZUjiRLgQPXdNlzF19fY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhnSnhDUWhVWGxlMFBwQytjSDM5QjBwbmIxQ3FTMFdCR2V0UTZVRFJ2bGlT?=
 =?utf-8?B?VThvOCswa1Qyc2xLaVlJNTBkRXRVS2RZV0hSdEtBS3pXV3c2YWhFQVJEbjkw?=
 =?utf-8?B?bzZJTXpBOS91UUp5TWRqTExqTjF6b1J4K3ozUndHQzMxWnhmQkhRUCtiQnRz?=
 =?utf-8?B?TFZxNEROYWpKL0ovQ2xkRDFmSWNYenR6dUcwQmhPTDFjS2NpSlU4dDcybWZM?=
 =?utf-8?B?MHV5WXY3TzUxU1BjdURXcXVLZGUxaldVeU5vSm5VeGlud3BjSzk4OXdqeFgy?=
 =?utf-8?B?MndlSGJlTVdvcWV4WkliQ0p3dUxiRm8rUVdiZmJDZGsweGVxRzE4c0wyYVdN?=
 =?utf-8?B?d0hINHQ4aFVrNmtYSlNLdEdpRVoweW5iV25yTjVGcTdzVXJzYjFoQ1dnYUp4?=
 =?utf-8?B?dmZWdFR6QlgyZTcrMWpKdXlZdzN1Z2I1QlNrQlBqQmE1TGZkQ01waFZPT0Y1?=
 =?utf-8?B?Wk8ydisrdVV3QjhYNzBiWm9ROWlsRHlFdldGSHR4aS9ieFhuc2U1WDRxUFdp?=
 =?utf-8?B?OU5kcHlJbHZQUTZidUpFV3V0Y05KcEtFUzRXUlhOZXJnOTIzZU9MUkZkRFRH?=
 =?utf-8?B?ekE2OVRTQ1c2TGtiTllUZGlFeU1nNmJCeHVUc0dJYmx4ZzQvWDM4NlNWL1Rl?=
 =?utf-8?B?OGF3UUxHdHBFLzhzVSt3cEk4andNMmRuTzdDNXRyUEVpUnFZbFZwOFB5RXgz?=
 =?utf-8?B?YXRxUzR4KzMyeXpLVkszaDd5RDFnd21mVGJIWk9LNjU3NURWcklmZ3J3NWlS?=
 =?utf-8?B?YmJGa3p1ZCtaeEkyWHlrV1RWdnQ3SUkxSWhRZ2JISk9WeXlZQm4zdjV1MG5G?=
 =?utf-8?B?OTNYaVlUZVFyNFlpOU45engveWFYS1FVRHVCcVZDL09SWTF2bWg5Ym5yNkpa?=
 =?utf-8?B?V2JaMHAvbkwrUTdzV3RsbFZQUWFKUjBTUTBxem1iSC9JVkFma1pEbmxJdHFa?=
 =?utf-8?B?dFo4MUxMM0hpeWxTcFhBME5iRFczdmdUUDZ1RHkyQkp4ekNQTkdLOS9tUTlL?=
 =?utf-8?B?YzZ5ckxYWGJEODZBMzFsNGZDMHV6anB5dUJKRGNuYTd4S1J3emNUdnpkSU9G?=
 =?utf-8?B?RDJCbHdEM2t4WEZGSURSY3A0a0x5MEJ1ejI3Nks5OGlvNVZ1N1ROckExZHhB?=
 =?utf-8?B?MUpCZTArMmg2U3RBMXMwNlQvU2NWME9YeWFMVE1VSWt6dGxaaExmM3ZYVG9o?=
 =?utf-8?B?RnVXUjVqT3ZPSHRRcXRTM1Q4b1RhRVBGWlRseSs1OXJ5cC9mUytoTUdUQVBE?=
 =?utf-8?B?RXJ6K2tMcDVpMlZMV2ljSjlETFR0RURTaGNwWStiZCt1dkJyN0VGR1hQaWw1?=
 =?utf-8?B?alpmSDB1SUJOalBTdE1BWU9LSnErYzVhRC9TZm5iKzVBaDJrYWVBRG5jTWts?=
 =?utf-8?B?RjRpQm1zQmp3S0sza2RPVG80T2w1K3piaHJpZk1pMlNub0RTbE5hZGVEdFZN?=
 =?utf-8?B?TXd2SjBIblNiUG9EVzI4WlhaN3hCQUJEUHpFRkZmMFQ2MUtOZENTdWNlSkk1?=
 =?utf-8?B?dUNSZU93N20vMFN0YmV2VURIQm5aam1uek04L2RqVTVSbUxXcUIrSXZobzF2?=
 =?utf-8?B?N3NQeXNISzFpNUJORUUxUklrTm9xLzhwS1hwWE1oclU4ZTVHNXFoVjFGYVRB?=
 =?utf-8?B?TEJUeWd6K2M4VkhpVTVaRlE1UlRiRUx2WUR5SlZqYXdjcXlGQVVaWWVRaHFs?=
 =?utf-8?B?UzljV3dBTUJMVGNQQWJTSGhmUU5SMVBjMmZDOGJ4YW80UjFWU1NZRmRrQkVK?=
 =?utf-8?B?Qm5RSmpiM2NidVdlQitUdlljMG0wSjlzcHVGVjFudS9mNzVOUDd6bndCTjhQ?=
 =?utf-8?B?YVlpbkIvTjE4L1M3dTg3MmZncTUzL21ONk9BTTRZeXZYWDFTZE1yRStKOWd3?=
 =?utf-8?B?aTY5SmdqVEJ5QzN5ZGpOdmwzamJzZ0RmbXQ1ckRPQmJyanB0b25TK2RhOEhs?=
 =?utf-8?B?NEM3cDRTUDlpeXV3aXNRSFhKczYxY2FsTnM3eDFpVEp3bGl0N1BJbk1XazNG?=
 =?utf-8?B?QURXeDJUNDJUL0N5TkZMeklBVFVsM2U2SThTREowR2FINFQya2thK0NxRHVX?=
 =?utf-8?B?Ti9kRjhFc0hxZWsyb2I3eUg3aHdvd0VYSGJwOEN2UFB3bnE2Y2RCN090aWV1?=
 =?utf-8?B?QzYzTnphOUM3c2ZWa001WVZ0Y25NNFNkM2FDMkxaUDZFbnRVdjJ0b2YwZHl4?=
 =?utf-8?B?M3FQSTkwMWoxWU0vTjVFaG53S005K0J5WXhXR2ovaXd2a01WUFhpczNtY2J4?=
 =?utf-8?B?MnFESzJMakhCSC95R0dQMjYvak5VbEpGcEo3anRUdTA5UmxZZHJxLzVFUXQ1?=
 =?utf-8?B?YkFMRkUrc3AyVUQwL042NFl4RWF6SDdzbEkxTVo2YTZYRGpia1pZYWtEVERE?=
 =?utf-8?Q?XxJOWgdA7j1l+Wlo=3D?=
X-Exchange-RoutingPolicyChecked: nIOPESmID8VYSpJro9hwf/0eSElJa3ypfP+lOO1LxZphOjR+Qvma526sPwR+IHwnUIAsHgS2SAHiCw3Oo7fXsJEYMLlZmy1MIKyxEdB8tN7W9/6D289YoGyvQ5gohnZmQSZHY9f0rM3hZ7XvBJUyqrnw2Ul4uMe7gMjJGtklI2vyzFACed1Fyf2KC1mTFPCnQezEZ2UvlAWx6X4iMN2WO9gNriynUfrgCDO9DCc7/oj+4sXSVleOuf9pMehGmhiAGGEpClpUKIbSLKLtlTbPjxEGgV1hUDU/NM/IdY+2Dkxp4YDaQPRWZwv9BPj2+4F6oiAFrx65YKSgCeWoYwYRRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4e14f5-b09d-47e5-cd7a-08df052f2060
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:06:47.6159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4Qd31pjNaufT1CGZCxh6lq+ZoVKi726sCLHWLKi0WO53zw4QSUErF51RC9JNXKceRDIet4pTC/e19oTx/JYRctaZnvhFeiQd1CoAZGI5FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7643
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

Hi Krzysztof,

On 2026-08-28 at 10:03:37 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  .../drm/i915/gt/selftest_engine_heartbeat.c   | 13 +++++----
>  drivers/gpu/drm/i915/gt/selftest_llc.c        | 29 ++++++++++++-------
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> index b893a8fde895..d26441ee837b 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> @@ -195,6 +195,7 @@ static int live_idle_pulse(void *arg)
>  
>  static int __live_heartbeat_off(struct intel_engine_cs *engine)
>  {
> +	struct drm_i915_private *i915 = engine->i915;
>  	int err;
>  
>  	intel_engine_pm_get(engine);
> @@ -202,8 +203,8 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
>  	engine->serial++;
>  	flush_delayed_work(&engine->heartbeat.work);
>  	if (!delayed_work_pending(&engine->heartbeat.work)) {
> -		pr_err("%s: heartbeat not running\n",
> -		       engine->name);
> +		drm_err(&i915->drm, "%s: heartbeat not running\n",
> +			engine->name);
>  		err = -EINVAL;
>  		goto err_pm;
>  	}
> @@ -215,15 +216,15 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
>  	engine->serial++;
>  	flush_delayed_work(&engine->heartbeat.work);
>  	if (delayed_work_pending(&engine->heartbeat.work)) {
> -		pr_err("%s: heartbeat still running\n",
> -		       engine->name);
> +		drm_err(&i915->drm, "%s: heartbeat still running\n",
> +			engine->name);
>  		err = -EINVAL;
>  		goto err_beat;
>  	}
>  
>  	if (READ_ONCE(engine->heartbeat.systole)) {
> -		pr_err("%s: heartbeat still allocated\n",
> -		       engine->name);
> +		drm_err(&i915->drm, "%s: heartbeat still allocated\n",
> +			engine->name);
>  		err = -EINVAL;
>  		goto err_beat;
>  	}
> diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
> index 779fadcec7c4..17a86e876f9f 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_llc.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_llc.c
> @@ -6,6 +6,8 @@
>  #include "selftest_llc.h"
>  #include "intel_rps.h"
>  
> +#include <drm/drm_print.h>
> +

Include nit, rest looks okay to me

Thanks
Krzysztof
