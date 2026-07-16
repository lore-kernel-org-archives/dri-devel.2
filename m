Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A45FC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF8D10E77A;
	Thu, 16 Jul 2026 13:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UJSqnAUb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B4810E77A;
 Thu, 16 Jul 2026 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784207277; x=1815743277;
 h=content-transfer-encoding:date:message-id:subject:from:
 to:cc:references:in-reply-to:mime-version;
 bh=8lo1QOBnnmmhBU+rt3aXdhtL5OOj71jkatdRyOS/MdA=;
 b=UJSqnAUbzhbYyxvagEx+vlG+ZX3ux1qx1JO0zQ8iQ8pzgJV6McDS2Zkk
 yK2EPvK8OU/jf/NFbEUyb7ilxKsHeUT2IGSOYhGHvaLJr6tiIWLvWMAT0
 vQSOy5JmKENQ8TyANih+scw5rLLnacfCt06jxOwCc4+DrbhPObdA+tRh7
 BV/Nn7CSylNH6XuF+31ly89OCKjOv985+C1HJNAJvowurBWcBrliKwPb6
 Ps4btGvpRUByMuqnee7zOE5oGG5hLedwwezQeynGHxum2ESSsvD23x0vh
 TxzZrN87Sc/+IpDcM9XSh2G7VcgSUkveaxmziS5y1hyVpVz+WMBVqvnHz w==;
X-CSE-ConnectionGUID: rRaCXKa/T3OJSZaShENaBQ==
X-CSE-MsgGUID: 7tujjAuARgKi4M2AdGxklA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84720238"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84720238"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 06:07:56 -0700
X-CSE-ConnectionGUID: DCz5lCC3Qy+CGzT/U1zNIA==
X-CSE-MsgGUID: hbckEluSQQ2TECbtS7ltGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="250135702"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 06:07:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:06:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 06:06:44 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7U+x8AC7YEd807oph6bxcz4dbx/eVjE5d83iF6dMMB56noCenM/wEP3+d+ZC4Iq0svq8ovyLqvMETWnV4OFwyDrw+09hcib5OW0tR0TMnRy2j96Bz0YEe1eAnmcpebed8yc7fGswzy5T4MVnzV0m4xtnCRdWimgFnL1sD8IAO5+a7oHZ3mxFZMqcz1CNdksiI5rZEMV0me3yL3R4jSBJM+IVVAnxmdbdDRsUg2AZwj3iO4ueRguPzJUUwsuXhMleOyt5B5/e8Szya+HH/C/ERdKzlpZUPARCR4LdqPAmX08p6+szd2iR2rXsnZ3c8O37Qf9X4PvLXNTCpTtXsifcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lo1QOBnnmmhBU+rt3aXdhtL5OOj71jkatdRyOS/MdA=;
 b=yKXAWcDptA7Zb7+F00C80bVtdG99hU8PhJ9Gm4yOJqKN67dW6a35siEz2Vqh0vgSWSLPBXOhTLUUhllaxlWZLSg7ZelL8AuaereDOjKevv2LS4aUGT7KEIOdM1JwAj54BThyxDk1pgQWQyTCUhEZBcgtmSmOAxqaatrD0Q93TFdOIjtXSpPCIC1hnUv/7iUuqILbkY2/H2B6fmkeoXipgUs+/+8VdABjTYD8vwEFhv1I6A4bTToSqydhB77CB9z/Rt6VCXGCCShaEuA3GKpfaN3R+p3L7B7v07JltAXeCQ7Xjy+qSOqOAZvig2az5WtQZIj5JeaBExJ2BPZ0+IK6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:06:26 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:06:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Jul 2026 15:07:22 +0200
Message-ID: <DK00OJM95532.WUNTR7EC2NFK@intel.com>
Subject: Re: [PATCH v2 0/2] DRM device registration fixes
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>
CC: Krzysztof Karas <krzysztof.karas@intel.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
X-Mailer: aerc 0.21.0
References: <20260716120018.20406-2-krzysztof.niemiec@intel.com>
In-Reply-To: <20260716120018.20406-2-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DUZP191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::29) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 09da5b08-b953-4bf4-5fb1-08dee33b0b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|6133799003|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MtpFOPQk+WYtPTLN8YHHbKz3FRaeSa8TECm5hJ36LwjfrMccFuzOksse3SBQgeL1hmISMtSblTtSg4A/liqBojZyKZXKqny1LG8/IO40poJtPXZN+k/uSM4zoWDp3uF0ECZC5+JrP9wLl9sbLEcfauEtAfQV6YMoZ30uDiC5/eVHIm7My3Q0OI2ZpuuIVvFts3yylgWPpCnjCHuNXLSLXfi3OSlB4nnZz8NCcVaVo4ulMLGuE4b/F2o2Xkh2fehcldETCfCXJE0e97fhApXIBEsUlyGuoRdkgtR7vTaSyFna+tydBPsvVYugkf1uVyg582/Y5R0aYoG/bGcPUmHeoG0TAFrty6eheB0QmZ2jw1URV8mw6SKyK270UDAgzbyXlW1XI6q0hIHs2PKyhtl1S4P/MVBDjVx3lbyU63sP3/KuV2B+pjPLHYst4+5PbpdgO+R8nM4aR2ZDKBV0ra7K/pk6dpnQSgFR4QjCajSRtLQuv05ruHeDulT7uiXdpjICK13H62N6haN9KtvZtQwFueN5hDQtfTwHN9EheLbdYxZEJKk9Ih5bQD9szXBOs7VUPKZRjISVYLVEo/qwpiRexMK869NzOUh8H84vCY6wqzhNoOZgBnVYgCsWgfVmwrXqw8ndkdAArNf9aZny6QRuIKKdaYrfOilUdgA5sRXtIP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6909.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFjZU13RnQ4dlRqblM2N3kybm9vbDd3V2NCRXFkS0gvNEFCY0dnMEFuNDlS?=
 =?utf-8?B?WjdxOEpzRUpNOUt1RXcvbFF5djh4TkxwWjBjaWwyeHMzVHljUVIzNlRZdFNo?=
 =?utf-8?B?UEprb2Y2MG11ekZDRWIzMlgvV2NSalVpVlFxSEdkK3BHUHRQcEg3bjZFYkhV?=
 =?utf-8?B?QnRkY3BpVUpUbkNYcks4K1JyTXVmWlJmTE1LZHE3QVl0cnRvL3lqTVpxRDA5?=
 =?utf-8?B?WG1ZcDI5bnZsT0xCdm5YN0hHOWd2STNNZTI2dTZiKzd4ZTdQUlZERnNkSE9s?=
 =?utf-8?B?NkwrZUYvT2NXZHQ1Mm9wMllqRDNMTkx6TWNRdzZ4VFZsQjAzVkQ1TXV3NTFC?=
 =?utf-8?B?TklqWHU0Q2VIbG5LUXBUNFBDNW1VVVVyTlo3YUUrYTUvek1FRTRjajdqWURw?=
 =?utf-8?B?ZlovZHlwTTNTa2JpUzJVR1p5WVdVMTJNNXgrL1VKQVkweloxS0JDWmRsNVg1?=
 =?utf-8?B?QUFCZ051bWdHR3RMenhyQlVjVVI3SHFFMmMvaXdLYnN5UzNnUEEvdWRDVjcy?=
 =?utf-8?B?cUhIekx2cmZMNGRINWFadlNibnA1RmpoeTM3RFErL2x1L01JbFd6WU1lY0lQ?=
 =?utf-8?B?N1dTQzhya1FqRkJHU2N4aVZocGxEaWlOSmRRS3pLeldzY2laVklMeFlYU2xJ?=
 =?utf-8?B?L0ZqSGgyakNpOUlmSEJrZ1V5RHNWUDJuWDJhUFV5akd1RWR1K0tEOVFmcUJE?=
 =?utf-8?B?Y3NmTkpsUWQwTE56Z2JGL1ZEaTEzNkI1dnQyQ2gzNVNkbUF6Y2lWVW1tM0hl?=
 =?utf-8?B?MHhyQTVlMDJjT1VPTUNxTTJvRDg1Y3BINVQzQkZSUCtyQ3FwOWZRYWt1L1cw?=
 =?utf-8?B?LzMwQmJwNGY3TSswYVpRMjRCWHJHOWw2L1RWZHVUQmxzNlZqTlhEcXhVcDlj?=
 =?utf-8?B?ZFZDTkE4TWNpTUJ3aEhIbHliTHp1SDZEN1c0TXdIMzNPN1BSQWsxeVJ4RnZN?=
 =?utf-8?B?UkQ5dTBmdzcrRTNFRTV5cG9SRC9ONk9mK0diaUlSRGxqSGZyM2VIUDZCOW9P?=
 =?utf-8?B?UEdKeE1Yd0FLZFFzTnVYWnNWL1hrb0d5SnBXNXluV2lsYjVZd2hlVTNaNkhj?=
 =?utf-8?B?TCs3VU00QS9KYzZqWGN0ckVQaFlsLzJhaU9QMllkQmk5c1VucTAvRURoc3N4?=
 =?utf-8?B?Z1ZNYlpvaFUzUklwaVJYc2xweklNM1pnOVY0bnVnK1VGTm9Od1Q3aXNTbTE0?=
 =?utf-8?B?WjZpSFF1Ti90anRCdk0rR1BybjU4cG5DUWoxcWFtMHdIczIyRkVEODJWVVZ1?=
 =?utf-8?B?ZW5Ta1ErWFpldDEzcVI3bkJvZnRpL2xLVnpVMjIrMVE1RUQyUG84eWZYa0Y3?=
 =?utf-8?B?RkJmWGNDSmsvVW9NOGRuQXE3ei9xK1RjWDl2MWNaWVlwbDRMaks3UlZVcUJt?=
 =?utf-8?B?YjJSUTFuYWJLcWttemk3S0dqNFREaXBKOGZLUFV5ZFczUHBqT2NuMjlsdGtx?=
 =?utf-8?B?RFhiY2xvTllpZHdrN213UWN5SktkRC9JT3VhajB1eEpvVk5LN1BoeDFuajND?=
 =?utf-8?B?NFRqMmlXR1h5Wi96c1RqdG5BUmt0cXRwVVhpcnpXeUpSK01XZis4QmwxcTVJ?=
 =?utf-8?B?OFlaaVp0L2lzSGcvK0FadHluZk1tTE8yUEphMXgyRE9TNk1icS9CdkV2c1VD?=
 =?utf-8?B?cS81dUQ3MzVlTmlDNFcrNnprenR1amRjUjd4aDhWWERqM3lzcys1dWc5cStK?=
 =?utf-8?B?SGlmYXVvMmlIWXF5d0RGQVJCRUZJdEx3S2E4ejhza3NFVEd6eTdWYmxWdE5v?=
 =?utf-8?B?TTlvSkpZWHZjcldPVXFrTVNGSzUyVWJsYXJ0blNhclRmQUpobWgzdnlRNE9S?=
 =?utf-8?B?Zk02ZlRQMXIwVkV2cmkwMDE1a0NkOUgwK3hQVHZiL3JLK3VpdkprYU96U1ZC?=
 =?utf-8?B?RWZQaS9zK2VCVXFJK1RBK0tqOGF4YnIrdTJqWFp6K0J2VFd4NmJyYmJZalZh?=
 =?utf-8?B?K3VCeThFRDYvUzdidzRrYzh3MTJPYmVZSExvNjF4d0RwRlAwL3FiK1NTZjJF?=
 =?utf-8?B?SXdIN2lEZU1zYTVRQWZyYm5sSkpZNndENmtMWi9WZ3MySHlhb1VQb3dVYThK?=
 =?utf-8?B?bEllYUdsaFRJTHZzeStZT1pNci9HNXNzSlkxc05JcEQvVjRxdE5DNStqek1s?=
 =?utf-8?B?NE9WaTZzNU5iOWtTSVVjNG8rbGVjajByc2grK3Fwc0haN3B1UlVCNXdUSllu?=
 =?utf-8?B?em1mMDROU2JrQTJpVGxLaGc2bUlWcTV1U3k0bGdTWENJTmtma3E3enJiVGp6?=
 =?utf-8?B?SnV5MXpMWnpvZTVEZWJZVjNmc2ZsZHRMZjdtS2lPbm5DaVBMaVI2Szhtell1?=
 =?utf-8?B?dDVlQ2FBVEg2dkVRRkJpSmpjZEZHQ2s3eEIwbDFYM1o0cDJkbEp6Z0FPUEM1?=
 =?utf-8?Q?r2KlF+bRVmraee9E=3D?=
X-Exchange-RoutingPolicyChecked: oclKvi8JGTZ8qybJS9TuBZbSrKxx2YVMgFF0QWkwmCryyxRLSyLzn55chhPUQduZGwdT4UObbKgOT8Y80eNyaCZ5fMmSwt/jxKfDXAyyXZDUMN4DdpRU0VMbHTbht9qyWEhsnPvGj30B0xxUzClC1RMeBVtAAXd5SUQbZQ8t8gmBHD/dO3RIc2TcVWDjWiq9PMFACzqW/i2TU+eque2zdGZhBQg0dCT/vleTPNtBgO4elz7dy4Um0sZwGtA1B9TibD2uHV/9Zq7VnqpEhN92yvf7ffOA1HETlAommwQU2z89GT5Bhiza2alggtn7dijA7Ae5PEGPNUjlVOitFv2YZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09da5b08-b953-4bf4-5fb1-08dee33b0b2c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:06:26.4556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D37/9yJZ8rj7/ilKvrVMRyT5MOCMIuEtK6kORE6sUipXBoR1TFrzwhQmc+AHh/jzJo8oVeXGGzz16nN8wl0HS1XlBs8uF9tgQkNbloFvJiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
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

On Thu Jul 16, 2026 at 2:00 PM CEST, Krzysztof Niemiec wrote:
> This series contains patches pertaining the drm_dev_register() and
> drm_dev_unregister() functions. Turns out drm_dev_register() doesn't
> properly unwind its effects in the error path, causing confusion and
> bugs.
>
> Additionally, a related patch for i915 is bundled, as i915 mistakenly
> calls drm_dev_unregister() in the error path triggered by failing
> drm_dev_register(), which on one hand introduced a WARN_ON() in
> drm_client_sysrq_unregister(), caused by calling it without a previous
> _register() (as it was skipped in drm_dev_register()); but on the other
> hand silenced yet another WARN_ON() later on in the error path in
> drm_mode_config_cleanup(). With the other patch, the driver can just
> handle the error from drm_dev_register() cleanly without calling
> drm_dev_unregister(). This is explained in detail in both the patches.
As has been said, you could reorder the patches. Other than that LGTM.
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

