Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67BCFB5EBE
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4033010E341;
	Tue, 17 Mar 2026 05:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g/UKmj/N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A3510E21C;
 Tue, 17 Mar 2026 05:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773724965; x=1805260965;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=4Ym3FWVuJrbXx/TBphuHig2GzIV+WMf4sCG7FS0FcNg=;
 b=g/UKmj/NaQo6Nh+lTdQuq+BOq848wHH/OF+jFvBGaBj1X78AzZjnkbz0
 yFATgvBe5F0q0plZMUsrWqvpWOQByYxM5DFlM7WRDlPGs50fZaPsWnPpC
 nTMZrj+6iHlNeU928637nkOgD3LSmsMpCiR8+ssqPd5curwHqLGMbpgQf
 zDKNj9JGGLjHcczklezSBKv9hPqPfPdYI0jXKCVzYoKkBBJb05l9PZjgW
 CmC4q4TpbJBC1SRrzpARFCOxDz1ZPO4jT34D8Pkada3tREGNwzQUMnyL0
 9YasRSAQ0FZ/VZciA4lM9DMw9ZHbo0RYfxlriKGEoTJBoCVSwoolw6AKx g==;
X-CSE-ConnectionGUID: 9RXZAxTvRCe2wnFuwU28MQ==
X-CSE-MsgGUID: 26VZeeIjQoydc+1atL/9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97358701"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="97358701"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 22:22:44 -0700
X-CSE-ConnectionGUID: h0LZKt0rS5i6F36qeLdOag==
X-CSE-MsgGUID: iBInV61eSw2EV7+6/M3xcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="252648286"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 22:22:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 22:22:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 22:22:42 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 22:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuLyR0bwsxi1coBmGgdCAFGeHsyOWPDlBLL5jkki1oYwEqWZ7jKM3+RA3gX7ke1snpRtoHxIIlAooZhxncMW5Sx3qewmYWjNKIwyDksmsguMVsXWEvgGpIEim1U7paiO4EvyvExto6cb/msKbuqb5U23fXTTMzbHESYRG4Y3LV0ovPIgnY+HFLlpUdQg/ycvFn+aYJdQoGc49Spvl4rO8TT5ixMBzvdeXbryUFI4//FLnMrHf8KYlWGkYacQIQmNJBlJxivcXRXUvohdK4J5c4RfJu30KJAB/BwZUz9aT9MRLSfAiaCz29gd24WZWpbBOJ4+aCOPlRhsBM/Ia3acAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upcghf/qt0ivWL8gYAYRvfohllFfiSaRqUldRXwO9IE=;
 b=U//8F9va9z72hje5OFBaw0ibqovZShlz78cF0Ezn30uKNz6BzlqhroXmzN9jd7UyVyOQ+RZa64//52G+2+8bFE+nPvBMwF2f2WzCxbajAU9JsSOmlkHFo0cmYH7jgNsNOBv/w6EyLUncFUBMQ1HFwpypcGf3m+sQIlOvYRgR5c6CIsFWMiP4PmHNfv6Pi8FsAwfcRNu4tSL745Bk343b/R/ojYVH1FcAC7dLbCGFrHPd1afwQpRDuBjpXa9ToYIZ9bNQANjOQxQB6rMwAOyyfgK7BKTEJZoXmCMOyD3HQCtttggIdBltT4xq1G6rpEs5ROWD3GeiErL+7k9cokbe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 05:22:34 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 05:22:34 +0000
Date: Mon, 16 Mar 2026 22:22:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <abjlFshfpJXCz8z8@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260316101601.464823ae@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316101601.464823ae@fedora>
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: 467e5026-1918-4c13-0ac6-08de83e5322b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: sEqQRhoRkrHbPXXVQjWV4AVkT6+ejwzP4yeHHFIEF2AKeTHT5cIsawf8j4QmjReB8H3KgynWwI87pJGAFx7nBdXzn56v6eBGq3gKYT8S+5UnLh9yb2ggp7HMKtLL/PLUf3IdP1uD8bbO2OnGVQ8RvkvQiBhy4gh6Q8uXkAc0cNajJgny99H8/qIQGBLjEpORBGnR5VIRAIW8jkF/zXqwWIrADyL3Y3auiV6BkmfJykDW129YXPii0G5/fkeXyUT9/FpKoIWKMWpF4Z1/G6VqpvBOpagFMtY5Bzu9sRhMRy/b07sIekxY9IX6znfRjxq5FftEweSolcyT/y8gBSP73KLhfeiZumraKL7PrsnKsAwSWPOoj7ftjZ8aTaJDcgU/TNLFu9mfK598n/EZ+4TB+xCoWjF4OPk1CMFax/hVaPlYu1nl4FQDdnxx68H1Lmc2Y9SqIEvMbW2tVpZ97hGbVFuhubOYOLXFFOm+SVLbUuDHuxEeSxGFhBlLOKFQ+GPnFMMPh1H9YQRF8gcs+nqi7SzU4Txna9NbPn05MYi/TGjfUcPuf6tCxo+StANxBd44rvKYcDTBxaK/XDazSmuXtqzeYAYL+RyO0hvl9ABmIm0V4x0qk6YYtbLstggpMHrr7Uw7fmtzlOdvCba+sQmkWevdO8rCWm0QA5xBGJv2EdVCK28N/FAZ1HRze4QWzVW6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmdoekdZdmV1VXpZcGpGSEhqU0k2aUozNjJ5Vjdram5WZ3pFTW9FQ1RRWnVa?=
 =?utf-8?B?dEovaFB0WERxK0hqSWdxZ3Qvbnllb1VSSTNJZ04xNTZ3SXltb1pHOXpoYzhL?=
 =?utf-8?B?YWVXeENXUnZqcUhkVjRwa21wYW5RMFlKV2lXQnloQmpPRklUbTJnQTY3bnNW?=
 =?utf-8?B?MDltNjk0SHpTeW9Fb1orQUdhSFlHeXNuNmtPMzV6Rm1hbnN5ZHVKMW5DZ0ly?=
 =?utf-8?B?S2RTSWFZZVJWR0d1UTZZTjZJbmUwK2h2bUo0QU1RWVRCTE5YTnkvSXhaV1lV?=
 =?utf-8?B?NmliWUVlZk9lbjBGWE1qMjJEcXQyRTI4RUYxSHV3UjcybUcrYnVpeTNtLzgy?=
 =?utf-8?B?Znd6dWVzK0o1bTJGcGM1c3Z6aVZtTVhIelhDRFY3LytjcDU1dVpPL0NaWXUr?=
 =?utf-8?B?bGFRUHpNa0w0TFJzQnE2YzdCaTQxclJxdEdpenFxV3JiZWhGNjhiekRhZ1l4?=
 =?utf-8?B?dFRoTmlvQmtrL1BJQWpqMm9meXA3OTErMndMVTBrWjlrTklyOU5aUW1JcUJS?=
 =?utf-8?B?VUd3MDBmTURITmtPKzhiN2ZCSzg5QjVZRUJ5c0J0T2JZWitVS0pxRThGdWNZ?=
 =?utf-8?B?WUtleVhHd3B3aG9icGx4NmtlQXlTc2w5NnAzZjRhbS9MY0VDZVVuTXFRbnRC?=
 =?utf-8?B?cmMzZ3pwT09UTkl5bzdWcEh6LzhJZmpUVkkvSGVmUEdWQzFJVkZUYkhDTFNy?=
 =?utf-8?B?ZkhINDR3VFU5bksvQm5HOWhKRnVaVnFXOWpUdGI4ZE8xb3lmT0FFMGc1Q0ZN?=
 =?utf-8?B?TlZnY2ZqazlaOWQrRTJVUVkzSEpUT1NCUkdmTHBqaW9RdVk4NWEwdWJCaGlU?=
 =?utf-8?B?YXF0L1lXQkQrdWsyQnNBWHZzRHQwbmhCOTVkMVUvSDhzcjJZTkxCNFRiLzYr?=
 =?utf-8?B?eGtXMmhSUEQrZ2pDZ0J5bUFybGlURVcxd2R3UjBpcWtCMmt2RHhLR3VmNXJQ?=
 =?utf-8?B?SEVYVkc1dm56OUdJdHZISVV6MFM5UHZ5dFA3a0lKQzZRclBidlZ4M2RmUVJk?=
 =?utf-8?B?QWQyZFhReHlqaE92UHlITGg0SXdFOEc5NXE5c1N6NlFzMUs0RjRCcGVrakYv?=
 =?utf-8?B?djhHN01mYXZKck0wWHZ6NjJQaUZ1VWQ1RDU1V2ozMzl1SHBuMytQTVRUNm5v?=
 =?utf-8?B?ZEUzR3J0TDBhZHhDd1JUWXN5L0tyOVpSaGgyMm9YTnYzRDVnSkltS2FaYlRk?=
 =?utf-8?B?blFQOWdNeWdzdFhpRElYN3RiSVRzQ2Y5R2twakNyOTB0U1lZL2tYNXNiZjZK?=
 =?utf-8?B?QzA1aEFudE5TTHYyQ0lPZ3AwR0VvYkhaMG1YQzZyRjJ5NG94Q21vNzZ6eHFN?=
 =?utf-8?B?ZHd4MWpaZE40V1VIa3l0TXRWdGlleTZqa0dncnJJNTlDUVVIbHpsUUZhdzVB?=
 =?utf-8?B?NzZsa1o4L0xaWkYvKzVGaG4wZ2ZyRGlVVkxxVE9pWDdLU09aUzBJQmtuRUJv?=
 =?utf-8?B?Q25nL2p4ZmZHczFVZzE0SGZBcXVXY2dlZk01aitIeDFKaFp4ODdKSW56OFZL?=
 =?utf-8?B?RjdFWkJDRytwbGptU2gyVVV0OGVWaTYzV0JJeWhyUmZIcDRHand3NWlCd1lS?=
 =?utf-8?B?U3R6TVRHYjArdi8zajNBYmh3VVkyS0hSMU05SE0yaVVZTk45ajNwdkJDZk5u?=
 =?utf-8?B?a0VxZ3pZSHU0aTVMQUMrY1AvdVBEQ3JYK0FzRzFNa01rT01JbXJmM2JqNExz?=
 =?utf-8?B?ME1BRnhoaUFVeHIza0NOZ1E3YWtYRi84d2J0VmRZUW5ZTlAxWnB1QjNtVmhn?=
 =?utf-8?B?TUJWOHNlZTJXNFpGLzRVQjFEOUZkOWtBSXNqY3JwR0xockxPcGZDZkxyQmNQ?=
 =?utf-8?B?OUxnaTVRaHNidGgrK1ErQWY3YmlVWFRXYjEwc0dHWVRyNldRRTc3bjEwSmlY?=
 =?utf-8?B?TG5tb3I3amlsR3F4SlF5T2k4RVZja2lXdldpRUdoVnI0dVQ3eHlSOU03NHVT?=
 =?utf-8?B?TkovNzJtRnVKSWlkVW1tY21NMUdEdWhXVFQ0Tm95NFJXcXhLVCsxY1ZGQm81?=
 =?utf-8?B?Y3l4bzJBNWVlL2hhRCtmaHNSM3VOSnBtSE03MEd5eFBjVzhoMHNPdFhTdkI3?=
 =?utf-8?B?NzVXeVo3U2pJTGRiTDhEbzcvdXl1SkNuNVIwb2RJSEgvSnlrZEoyWDhxMTU1?=
 =?utf-8?B?bkdZdW1LY1VKSTI0S2l5blZuUi91QVlqS21lREpKSjlwM2hscEM2T1dOQVhI?=
 =?utf-8?B?bGVVMVQ1N0hsYllDYjdqT2puSG4rR2hHL29SdU5BeE0rSnAzaGh3ZkMzREo5?=
 =?utf-8?B?Ulg4NHVKUGlnb2RIamVuS3NvTjVhdXh1cGMwU3BuNUhuMDNNMlNwNm40SFF2?=
 =?utf-8?B?WHJMWXNpcHZKenNNdHh1dnJWdUFSdURsSlM5YWtpbjh3SnUxTGl2STMwTEFU?=
 =?utf-8?Q?lYNtGId1CKd1+kTo=3D?=
X-Exchange-RoutingPolicyChecked: XVj0zMj6pyU93Ik1s8ezZQK7wOnG0nHA9d3P8xi1njRepmBveaAitcQKMmd4Qhm5q0XNMbLveuGQJTXHuumgAaXkx5W4FSEyUKwnQ9BtZwH1/4DWWiskudtfl9lXT1Hzd9BUPefzk8JJSUs+3MCOF9sIEI5boiO2k83igd7PigM5X4Geq8OqLMw1pLg73sTlzwzXgTcvGJoCLrfDcEGTWoWcsHkkrMLMVTLls2keF5UkCN+GozCcuuXeAi+xTOdnBf1rCwB+onjAgcv+ELz/4ka7BBDBJ5H+cTAyUhxGBuAO9/1DBV+8wMPI5YGZ4/5EzfZs3XsYeS0CSjfvbiSWbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 467e5026-1918-4c13-0ac6-08de83e5322b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:22:34.7133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ughAcquVGy19gLvT8wh5dDXV4bluk7q/YtahdTRm9Q2dHEJNEb22WSC0obcUnSa5yy04bUPHriTnZR2M7f9+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
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

On Mon, Mar 16, 2026 at 10:16:01AM +0100, Boris Brezillon wrote:
> Hi Matthew,
> 
> On Sun, 15 Mar 2026 21:32:45 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > Diverging requirements between GPU drivers using firmware scheduling
> > and those using hardware scheduling have shown that drm_gpu_scheduler is
> > no longer sufficient for firmware-scheduled GPU drivers. The technical
> > debt, lack of memory-safety guarantees, absence of clear object-lifetime
> > rules, and numerous driver-specific hacks have rendered
> > drm_gpu_scheduler unmaintainable. It is time for a fresh design for
> > firmware-scheduled GPU drivers—one that addresses all of the
> > aforementioned shortcomings.
> > 
> > Add drm_dep, a lightweight GPU submission queue intended as a
> > replacement for drm_gpu_scheduler for firmware-managed GPU schedulers
> > (e.g. Xe, Panthor, AMDXDNA, PVR, Nouveau, Nova). Unlike
> > drm_gpu_scheduler, which separates the scheduler (drm_gpu_scheduler)
> > from the queue (drm_sched_entity) into two objects requiring external
> > coordination, drm_dep merges both roles into a single struct
> > drm_dep_queue. This eliminates the N:1 entity-to-scheduler mapping
> > that is unnecessary for firmware schedulers which manage their own
> > run-lists internally.
> > 
> > Unlike drm_gpu_scheduler, which relies on external locking and lifetime
> > management by the driver, drm_dep uses reference counting (kref) on both
> > queues and jobs to guarantee object lifetime safety. A job holds a queue
> > reference from init until its last put, and the queue holds a job reference
> > from dispatch until the put_job worker runs. This makes use-after-free
> > impossible even when completion arrives from IRQ context or concurrent
> > teardown is in flight.
> > 
> > The core objects are:
> > 
> >   struct drm_dep_queue - a per-context submission queue owning an
> >     ordered submit workqueue, a TDR timeout workqueue, an SPSC job
> >     queue, and a pending-job list. Reference counted; drivers can embed
> >     it and provide a .release vfunc for RCU-safe teardown.
> 
> First of, I like this idea, and actually think we should have done that
> from the start rather than trying to bend drm_sched to meet our

Yes. Tvrtko actually suggested this years ago, and in my naïveté I
rejected it. I’m eating my hat here.

> FW-assisted scheduling model. That's also the direction me and Danilo
> have been pushing for for the new JobQueue stuff in rust, so I'm glad
> to see some consensus here.
> 
> Now, let's start with the usual naming nitpick :D => can't we find a
> better prefix than "drm_dep"? I think I get where "dep" comes from (the
> logic mostly takes care of job deps, and acts as a FIFO otherwise, no
> real scheduling involved). It's kinda okay for drm_dep_queue, even
> though, according to the description you've made, jobs seem to stay in
> that queue even after their deps are met, which, IMHO, is a bit
> confusing: dep_queue sounds like a queue in which jobs are placed until
> their deps are met, and then the job moves to some other queue.
> 
> It gets worse for drm_dep_job, which sounds like a dep-only job, rather
> than a job that's queued to the drm_dep_queue. Same goes for
> drm_dep_fence, which I find super confusing. What this one does is just
> proxy the driver fence to provide proper isolation between GPU drivers
> and fence observers (other drivers).
> 
> Since this new model is primarily designed for hardware that have
> FW-assisted scheduling, how about drm_fw_queue, drm_fw_job,
> drm_fw_job_fence?

We can bikeshed — I’m open to other names, but I believe hardware
scheduling can be built quite cleanly on top of this, so drm_fw_*
doesn’t really work either. Check out a hardware-scheduler PoC built
(today) on top of this in [1].

[1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/22c8aa993b5c9e4ad0c312af2f3e032273d20966

> 
> > 
> >   struct drm_dep_job - a single unit of GPU work. Drivers embed this
> >     and provide a .release vfunc. Jobs carry an xarray of input
> >     dma_fence dependencies and produce a drm_dep_fence as their
> >     finished fence.
> > 
> >   struct drm_dep_fence - a dma_fence subclass wrapping an optional
> >     parent hardware fence. The finished fence is armed (sequence
> >     number assigned) before submission and signals when the hardware
> >     fence signals (or immediately on synchronous completion).
> > 
> > Job lifecycle:
> >   1. drm_dep_job_init() - allocate and initialise; job acquires a
> >      queue reference.
> >   2. drm_dep_job_add_dependency() and friends - register input fences;
> >      duplicates from the same context are deduplicated.
> >   3. drm_dep_job_arm() - assign sequence number, obtain finished fence.
> >   4. drm_dep_job_push() - submit to queue.
> > 
> > Submission paths under queue lock:
> >   - Bypass path: if DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set, the
> >     SPSC queue is empty, no dependencies are pending, and credits are
> >     available, the job is dispatched inline on the calling thread.
> 
> I've yet to look at the code, but I must admit I'm less worried about
> this fast path if it's part of a new model restricted to FW-assisted
> scheduling. I keep thinking we're not entirely covered for so called
> real-time GPU contexts that might have jobs that are not dep-free, and
> if we're going for something new, I'd really like us to consider that
> case from the start (maybe investigate if kthread_work[er] can be used
> as a replacement for workqueues, if RT priority on workqueues is not an
> option).
> 

I mostly agree, and I’ll look into whether kthread_work is better
suited—if that’s the right model, it should be done up front.

But can you give a use case for real-time GPU contexts that are not
dep-free? I personally don’t know of one.

> >   - Queued path: job is pushed onto the SPSC queue and the run_job
> >     worker is kicked. The worker resolves remaining dependencies
> >     (installing wakeup callbacks for unresolved fences) before calling
> >     ops->run_job().
> > 
> > Credit-based throttling prevents hardware overflow: each job declares
> > a credit cost at init time; dispatch is deferred until sufficient
> > credits are available.
> > 
> > Timeout Detection and Recovery (TDR): a per-queue delayed work item
> > fires when the head pending job exceeds q->job.timeout jiffies, calling
> > ops->timedout_job(). drm_dep_queue_trigger_timeout() forces immediate
> > expiry for device teardown.
> > 
> > IRQ-safe completion: queues flagged DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE
> > allow drm_dep_job_done() to be called from hardirq context (e.g. a
> > dma_fence callback). Dependency cleanup is deferred to process context
> > after ops->run_job() returns to avoid calling xa_destroy() from IRQ.
> > 
> > Zombie-state guard: workers use kref_get_unless_zero() on entry and
> > bail immediately if the queue refcount has already reached zero and
> > async teardown is in flight, preventing use-after-free.
> > 
> > Teardown is always deferred to a module-private workqueue (dep_free_wq)
> > so that destroy_workqueue() is never called from within one of the
> > queue's own workers. Each queue holds a drm_dev_get() reference on its
> > owning struct drm_device, released as the final step of teardown via
> > drm_dev_put(). This prevents the driver module from being unloaded
> > while any queue is still alive without requiring a separate drain API.
> 
> Thanks for posting this RFC. I'll try to have a closer look at the code
> in the coming days, but given the diffstat, it might take me a bit of
> time...


I understand — I’m a firehose when I get started. Hopefully a sane one,
though.

Matt

> 
> Regards,
> 
> Boris
