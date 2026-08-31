Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8E2C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A37C10E62C;
	Mon, 31 Aug 2026 20:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L21ODPKb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A9610E20B;
 Mon, 31 Aug 2026 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788208255; x=1819744255;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8IYor+RXcjxzghUtZX7kNiLsLLpWzEOI/SttYkfKlbQ=;
 b=L21ODPKbq/TmUsgdCrAXP4OPe+wrsJHMhfcOkCiRb8HpKcCbUmPV1mlC
 Q2iB+0O0Hku5QxOcVhkLBee5TrFJitGJKZ2zhcIAQDK9IU9UjFfdxWpMu
 nJ/YY9/rzj3Eee90wLBfHwPNRmuv5I4J7dENJebwWK+cKWUvhcaNhPQj5
 qPufZ5WGBDIHf2icG6nWXDBUfliL8pCJmLUtTHHZS1LuscXxEDE7tv/SH
 twNh/D5JqgS3Evo+sqTzn+WKBv/k52AJMifn6wtCaOKrxpEZ1g5awSNP3
 NUjVNtkGoFsjP5YQ8LHkGv1FOD1O6CV973TOSUUMICavtoKIJ9+qb/nBA w==;
X-CSE-ConnectionGUID: 50YL+jsETpizN0EOugr15A==
X-CSE-MsgGUID: F7f5OKHhRLSFHdHaODCMFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92491784"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="92491784"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:30:55 -0700
X-CSE-ConnectionGUID: h3FHO94wR6aM6CJZNEJSYg==
X-CSE-MsgGUID: b6sM7EU0RpiVF07CtO68tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="264606988"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:30:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:30:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 13:30:54 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2HcdDBJGe4FoMPnp7zNeIGt0l+0D3uJVK6wVQR6b+1+En0lViScVbBbv1W5ZS3D9mvhf/MKluJgFi2UE+/ZzTZWpiI02yjypSlCsW+1jwghMzTK6gCRotjoV91Z6fagvlPzVSL3M/AlP2wZ1isUBJCHWBERPCxfYFbgerLgcXnHi2fAV4VL/oZkWY4lzj/iY3GS0DE78vsvDY09qOl1hjuku5lZgjsoi18CaaxQX2j1hn2vIhoC73kQYBlSMFYTb/nBDlpNivx7v543kF5T0OpCPJFnXrMycc9JbyMR4Zp/LpIOJ6dOeW1YpI1gghUZ7VGi78NELJCuZ1tiw5hKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RpL8FsqxdfDdWtQE7qoP/dQYTGBWOKX4e20NJKUvIE=;
 b=si3j3ieJT/2qcpQrJRw4IQsvPsmwoaE+GWDhJN3N50znL3CY2JOoIIbTXI4zWNQIlEqf5pK/1lSak0jtWf1Fc08cpDMqNBAAoBwjBlng5OUP5CKMRPWNM+ezQbUCHcTypk9KM385d5KCs6A12jbE7PZSc7Gu1tGX6vqynQujgOvUg16g/nqddoIgk7Cxsb8fH+uTVPDZHQb+qs4oRJVYxW9LoY8PogeEvKdxmm+ESJ6dpalRzqWiTbGAZH5ZFDDdaCfuaR7X1pjWgxTqdS5X/NjftsybLy15mUUg4I+XYUj2k0GnK8sWCtn7aKgcWVFAhbeDlOS+9//TvljFF3aBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:30:50 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 20:30:50 +0000
Date: Mon, 31 Aug 2026 16:30:46 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
CC: Arvind Yadav <arvind.yadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 01/13] drm/xe/irq: Always free requested IRQs on uninstall
Message-ID: <apXkdp7NevBnD572@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-2-arvind.yadav@intel.com>
 <be78bbde-0cc7-4be2-ad69-1801a8d73d48@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be78bbde-0cc7-4be2-ad69-1801a8d73d48@intel.com>
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ece59da-dac8-4f66-ebae-08df079ebf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JJCvGXZtBq63lcQFMs/jrpuOHHODbTksI4ngle7mniohGilVcu2YisnaaLM+RqKLDoblPhDVMDpsGheybTg4hC67VVppC3DDQCvsNBnHd6nPMk/LU0mgQpTDei9xj2zAF+POnuE7+UNL7MANZ+OLGzl31zoTkbbbi2JFUJobbHfIxuMvHRTARB1CrCDbzNWbAWJMC6qAVsQ+sOqLLGBuUM1eAxo7f2nyZSeY1sgjXmaYWO0euEMcqXi2qEhcG9Z5gyY0cKUf47iyX3boUqgTjrMtmpVDOnyTQgbmmO0A/2MGd1XOHLBkDYgvNDY/EoKor3VOyMMH3dJjjHRM7LjebCSx/Ari86oBd6YW3nkTVzGVDAJhbgUslqr+LTivkhIVUVfS1khOWS36pE4N4hBNOpoFRh5ehA6vwxL+ArnHWpATsol5Hd7/PkX+uopLzbaba/ZcEkgmtjw6Hp1JpotS7iSHEzSbqgZ+UjLLd9Hl6s4KU6u6muT/0uAQ/g1EJ3Yuj9nVm1EmNzXR2otiursdStf7fzMoU2efcLxUibuuFF2PkJpOAq0+ZBX63xF4Uz5V4eW2WC/zNqMyZpHg05HHs4xmUMcWZTEklcOO316gDVaCznRF0mzA1a1kdMZAUUo3kTmKi7CdcfcP9Zdytkt9y7Ik9+y0UwfY9cbMeKoePrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JYuATR0lVezXiis4sq0mPaoKl8ke/CxtWnsJPw9ECvcztu/2iPK4+FJa4F?=
 =?iso-8859-1?Q?U5Gn/2HALPMkLyLyMXE+LN9d6mTUMkzBa2cVsU2Yic7FXilEfoOk32ogJo?=
 =?iso-8859-1?Q?V0FpB+I83WNC2fpKzviXlJh8xzK9Q7QYTCBHhGjBM7QENN9Py4wpW4azal?=
 =?iso-8859-1?Q?pX2cKk1MbMYgEsZer2UQX0vDuoOvOnqfb/gY6Rhmf34SBizTVoT/VzzlV9?=
 =?iso-8859-1?Q?t2rT6vZFkKHER+rxyXw5vIxs+PAmnPPkdeWMbxZXmpFQ378Wu2fKHEPZwa?=
 =?iso-8859-1?Q?gZ/jd7Pcj8KdQkcsI9tivswvlXQD0k3mNQErkFCS4KrhzvuuthZOlG2GSj?=
 =?iso-8859-1?Q?UV4l/9wJ9QkbzhIrTTxF3UamalIJwMWhm8eQAEoy3yoq8Yp5vn+fo7Ards?=
 =?iso-8859-1?Q?po/TiYW+XAMQ+d+MiXjagZn5olkJ8dyzBHoJvZ3g0TIwIPKIoKgJpavhu6?=
 =?iso-8859-1?Q?u+4auNDVV7xqT4cVfv7RTwFPoSuT8IGuNIaFWuFCiV9FxrqnfroIVePvrm?=
 =?iso-8859-1?Q?dgt/YUaDgRtkjELWYrTsuoBkc/l30PL/mGaVPhq8ViZScE4jZtTQG8u0cK?=
 =?iso-8859-1?Q?QuljgrpkQL7H/4ThqJeZHOR4wJ2LuSkXzVNWvJELBrhh3iFPfJk64BJjBB?=
 =?iso-8859-1?Q?dX1L9kSjMSsm/CSnfc6haUOgSJaliaVYRewa+5N+8WsZ13rUlbBUVSt1Cu?=
 =?iso-8859-1?Q?ljCw5BaTrRUJM77/dkGmubD7QvCFDujTTxdigQALk9tKp5qtdjwoquRJ02?=
 =?iso-8859-1?Q?AZ8YEBtwUXu+UbOkIttAtxYG/m13EB5WnSI5uiM81uvAks+ZRUlVywZMvf?=
 =?iso-8859-1?Q?DixY4XwDpkNN5QLPJaKKYARcpLJekR5ZXVCVUEYkbWCIyNPkQPNnUevaXa?=
 =?iso-8859-1?Q?EQyog56dwrGEAQFy03AeKMmjpMivbJcVcBfqDA9fkuh28a/OywVa2JcFXB?=
 =?iso-8859-1?Q?a99F0244feXUXG1tM4U7Mr2HvKg/HhdsaIM2eqwM+M5R5gTJJbMVNrAsIi?=
 =?iso-8859-1?Q?CyP3kk5KMuFuX3c3KJ+eSuiGUAoUTgQERk67SaHJ9jbvl46/6K+BCfP2D1?=
 =?iso-8859-1?Q?J/S5yTWnj9PIIBl/dnBytptINpI2cL74euloPTiRKbLN9+lUKN0EvETJw2?=
 =?iso-8859-1?Q?Q7OUnEmCHAYNFirPPzPc4i5fDeIz3r6ffFN/Ip5nP29s7WHT7/LTnOuNpi?=
 =?iso-8859-1?Q?/eEWxbu8MLkoJSNxXns4mh/k/i9cnM9OQEHefHZGzJwmXbtxWWes/V/mEZ?=
 =?iso-8859-1?Q?d0JPYfDmuRIk9mqK1wEOneAK0yTo0FgPoVIlinL9sZ757Z9kweNIcO9Xf8?=
 =?iso-8859-1?Q?BMy+uKm2CeQV34DujMUpX8UiPY4W7m/UBvghnjH2qI0Zv8rpWkjI/1g/Et?=
 =?iso-8859-1?Q?fYQ9qzdGo5DxFv6VX6Nk1YNAAzZfYSaIDwtCDPYhB9I42ZIcMX40HP8BHA?=
 =?iso-8859-1?Q?hxfi0roQ7D5VU5K8od8HRWudliQ+SjihX/+7y+QSAdC7YV1gs3mA2W26ul?=
 =?iso-8859-1?Q?ly30/JFe5+Q4cwxM++a/lG8eNlkWhX4izf9vXQjBBEvqqs2R7oYgbl5jYQ?=
 =?iso-8859-1?Q?5oeLyxjYEt/DoHrXRIi4UA0SMBmVGZF9+KnjvHAnOyZIZv3Q+g6ZTFBvX1?=
 =?iso-8859-1?Q?t8Cy9wv7kgPp/4YkHSnruWMWTVaf79NDJJmrS4VH3BfChduiMzv6vUaA+U?=
 =?iso-8859-1?Q?kCQRmpoPxcy0J74Itrd3v+u34rqQb/EvMgHxzJyB6m/iUPt9nDew2lh6Lk?=
 =?iso-8859-1?Q?Tvrm3OrFbRgKpTKb0fQ9WdKQZ01WR+kkEMu/tGRD+E1bIR8RtRasoxpP7o?=
 =?iso-8859-1?Q?s7JTBUK98g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1NrZNuYZL71F4p3vR1cl59j3Waz21m+agGzkIzD5PQi1hwjOvmxl/JRkNxzl+rHxZhijEbtWQAP7nKzRIOmVhfjgqEKdgYfqw9bdeFli2y4NCuZQYCUEncNUuCFYOJrYC+3xRrUZ/WC1X5kr2ZbAfOkcolx65tl5jOD2lNAR7YKdWYk0+MVwDE4cWM/9ihDTDxXNg5JwUHqSq0e5i24OU9g+/XIJbgOKQEl0vyX7iUDfI+EMFL9vu2Fc2i3GQDIMDiDk6Wo+ZFBUSUEmw7isD1r960eP0wlRlwVbzpftLgVqr+BKHOTtIws2RV9SvipTtkLgSj8VbNO25YDnjZfXYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ece59da-dac8-4f66-ebae-08df079ebf2e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:30:50.7097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR1C1TAQIgpJY9q6X/NWDPTY7lP9dIiX+inzl+BtKh+g1Q1gvdJylvTl81OXjtpvWpzVjjTxbwEHZp3M/LEazw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
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

On Thu, Aug 27, 2026 at 04:09:41PM +0530, Ghimiray, Himal Prasad wrote:
> 
> 
> On 27-08-2026 15:47, Arvind Yadav wrote:
> > xe_irq_suspend() clears irq.enabled after disabling and synchronizing the
> > interrupts. irq_uninstall() currently returns when that flag is clear, so
> > a suspended device can skip free_irq() during teardown.
> > 
> > The managed uninstall action is registered only after the IRQ request
> > succeeds. Reset the interrupt registers only when interrupts are still
> > enabled, but always free the requested IRQs.
> > 
> > Fixes: 4d79a1266d4c ("drm/xe: Make irq enabled flag atomic")
> 
> Fixes seems incorrect, the early return was even before the change.

right, apparently since the very beginning:

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")

(I hate to use this initial as fixes nowadays, but it is the right one...)

> 
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_irq.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> > index 9e49e2241da4..d314993b14a1 100644
> > --- a/drivers/gpu/drm/xe/xe_irq.c
> > +++ b/drivers/gpu/drm/xe/xe_irq.c
> > @@ -786,10 +786,8 @@ static void irq_uninstall(void *arg)
> >   {
> >   	struct xe_device *xe = arg;
> > -	if (!atomic_xchg(&xe->irq.enabled, 0))
> > -		return;
> > -
> > -	xe_irq_reset(xe);
> > +	if (atomic_xchg(&xe->irq.enabled, 0))
> > +		xe_irq_reset(xe);
> 
> Patch looks correct. With correct fixes-tag:
> 
> Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> 
> 
> >   	if (xe_device_has_msix(xe))
> >   		xe_irq_msix_free(xe);
> 
