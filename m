Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDAEC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6949710ECA6;
	Tue,  1 Sep 2026 11:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HS8Uc6FE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CB910E63B;
 Tue,  1 Sep 2026 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788263903; x=1819799903;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/HSoadtXTERaWiBCMoK/GVtMtuVggD8IDXi/IPfEj/g=;
 b=HS8Uc6FE0Nc2SWW83w5FbT7nltxo0vaiD89egePTNTXF8k6QXYYpS8eL
 on20gSWRPb/LrgZJTfy3YgZPUXvMPFtvRXyz0JHtN47bGG2htxhjqA5PL
 hCCRqsJPpUbW0UpG6kVo00AHetBJw2SKHXbYuSg8n/hq9PdrA6ijErRWp
 JVH0aBKhXNqpUieVjwaPIGFdM49XVqKsfsxpyhEgGVhBu8Nxr7UVMywo5
 xVRiaHM7+y5snvnLL/l4ppNmcOtSuOm9a8yXXtn7+N9FtlsKek1dGJEIC
 nymqtpCjckbgQ3RiL8UDePxKTK05AqjLwXk8++ci0wWHXlcIExp7d3hWM w==;
X-CSE-ConnectionGUID: pbNljcc4TOi6xHa+Splfbw==
X-CSE-MsgGUID: r8NYJaywQ7a57mz6+R+qbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88567637"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88567637"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 04:58:22 -0700
X-CSE-ConnectionGUID: ditK5dAuSkmsFXzUU8VGCA==
X-CSE-MsgGUID: xx56svqnSkCcyRYKsRcJqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="292586236"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 04:58:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 04:58:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 04:58:21 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 04:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5ToF8u/9tUWHn6dLFS9PBDx9rtktAW/9aOGwtXqXqBAhsuMBYYgBYMcN7porQ7HHBC98nPxJsfd5JvBTOtwJIxefYa+UNRYzM1B+0wLnp1Aapvuk4tWiL2FsUJMa8vLcAjpcupgWoVt+Uue9H5Vk2WQB+mi57qItjmGwss5gz9nfPgac2CY7uhE9mQkWLkR+NaEuBqY+vCrQMCEAHDWqN88uN0EJIGbqOc8wqTvoMCdE5NYxJMjrNvRlRVqXVHYhEP+KqQDE1kqeFTBtKFE/dsi/L2FmSAbLS+DgnHyt59AJKlvy+VfSYLxnG5i0NOnmUVuhnZ3/0A1bvjf0bvyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX1kR75t5PwoTc+lyDbtBWp+UfUfhQbvz9uYCfP6FP4=;
 b=aPevYrGqRFwmm+rQiP3QX4OLMm5QgdfgRbdTm5NrY/VAkvGY5K8DBYpfnyTtfIcrAv1rk8TuAx39UGwybCB7kU1boRYYVsF0dapUMIDKIwIf4L1kCat1txhg0WuFzdUeduGpXaBXrlLWw6rGDelo9rBPgDrYgx/upMLU/cWmqGkSvZviBbxBiJqaI/6+LPmeLlw+SgxsGGYDlKgDvADsP1U14+LvMeQLHY4hRojZYn6XsCvwZxUmcpF6qIPOQXQcECzoFI6sop2bKM9zZ/EmTTCmQjApMx/HagZymCE0Dx+bFI+dpyfOZ/dYKSxsZ77K7tktk8S0N2MiviaWdA6eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:58:17 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:58:17 +0000
Date: Tue, 1 Sep 2026 11:58:07 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 3/6] iommu/dma: Catch scatterlist length overflows
Message-ID: <i6vqmzifkewq4ryhwvldefkxdcxer2wkqgda3pewp2d3xloyva@un7hvq2vqs3l>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-4-krzysztof.karas@intel.com>
 <20260817101110.799001F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817101110.799001F000E9@smtp.kernel.org>
X-ClientProxiedBy: DUZPR01CA0265.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: dce1eefe-040e-4327-28f0-08df08204f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 030CH8h1AUtEkME8rZEIZNB5tViVXazbrBfn1lEO+CtmSOvyrvjFk3bsjNRahOE4OdNrlrEU5eIgks8DYCb2mfuUEf4rcj4YTC1KEW52fVfnSOjKAJ82mZEa/pR01EpDKoB4EgleHKAzGMUXEiSNuB96Oei8BebjlSXJUYyg4yty4wQYFABW6lssnetpqW/DV178VMOXaGf8S6ZwSNjU1UKQUd/++BLoSpcE3p++yi0m2c6GsCOducCeQ25JYNfwpqrP7oHdLD/Lz/pxHrx/dDNsVPHUF67loEi5IK2Trvg13R5y5me004zvhTyHkn6wqIEX2AUwPANK++hjdfCR9CV5i+wc9FuPzBIQnVQhngYGuFtzEiBgAilEp6vFp4Zagw6mEq00f6BruOsQZtpeDkSc+Tn6b7bc4hlq6XxhCf3Atd8VaKIokQQKd0zeNE1OzH40axOZkDDTIN4RFRLqO63TecppOrd5iYAXr8J4Wnz7byjvxvV7nU1JmdXu21Vu6f6weZY91Zu+6fR/a2QFdvXs4YZWsH7HYDm5DgAxhGGY1YXqinh4mc+898tKp7pG9t8/XMtDMun0/pTMeeqR+ECt14BJhlOiwox7jHzkQJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFJcXpQWXo4U09YZUM5M05EdEhSVU4wOUdJTTQrTFVGUjFGNkpYck1kS3N1?=
 =?utf-8?B?M2dUK3hyajlmSVQzQ3diOGFzSlZYSndoa2QzYkJtc0xZLzhzQ2hHeHRxOUlC?=
 =?utf-8?B?N2diYlp5OEJoSzdrYVM1ZDRCVzY0cWIwaEs4WlF5Z1IvOE9hWU8zSm9tL1JV?=
 =?utf-8?B?VTlFTVRwMmNWNjhkRXRpeVFhTEZzalVoK3VrR3VwMlhrT1R3aVh4dkdBY0w3?=
 =?utf-8?B?SEJwdUUwYWJwcG1JeUlzOEo5b2JISWsrSU9Ec1hLb0dFc3lwSSsyTzV6RXRJ?=
 =?utf-8?B?RHpYMThuZ2Z2YkNzemUyMjJ1OFkvOEt1cnpPNkltK0tvUEZZa2E2YWVOcVJi?=
 =?utf-8?B?cng3T28zOE5PeXU1UjBGanhpQkVwbkhETGhLeVIxaXJXR1RYMWo1S01OUVNS?=
 =?utf-8?B?dzRqcUpLQjVqelBaZHRjWmNKNDc5UlhybU40dUsxbElsUjBVRmlrWmh1N1dI?=
 =?utf-8?B?bVFNdW9SbFRCVW5xQ3o3b0tKcGpqQzVPOFlwRCtVRkFqT2FtWUZEYk11bFFX?=
 =?utf-8?B?SGF5VFdpQlBvTUhzemxaUCtlb2dqWnVBNjJZM3RaTUdDRFdhc2E3RmJsRHly?=
 =?utf-8?B?eklmZmtQS3ZhaS9hV2JMdXQyWUxDWk1PeEdTY25PeWJrSlBaLzJWZjhEbFJj?=
 =?utf-8?B?VXpoUEVqUlVYcjEyQmpDdFVsYlFjbUlybXgyb1pudWxJMGh2TXpWc3JwVXBa?=
 =?utf-8?B?V1Y4QlpHMi9wWGVpM2N6eDdwM211Tlg4a1JMZkcxUzI1NUYyTXg4bUpPWDd6?=
 =?utf-8?B?endSS28xRFp1cDNkWDBqQWJwK0k2cDZjQkdITTBEV29XM3NOTWtVdXdyMEI0?=
 =?utf-8?B?NS8wNHVGTVQ2S1VDNGlrbFRvYUFqbmV3dU1QUEZUR0p3UHd3alN1VEVEekJa?=
 =?utf-8?B?M21jZ2hLVjBVb1oyNTN4Tk5sVFBLSVJ5ZHlUVlpZWmZJaUdyUkNpYVB5OGVO?=
 =?utf-8?B?UVNaaFhZWHBLaUhoTUtRcDJkZllIUEM5d2hGUXNEK2orYnB2MDdMTE9hdllN?=
 =?utf-8?B?NVRBZkcwU3pSVW44dDkwM1hjcjZXK2x4bVZhUkxHa1NyN0tCNEQ2UFFQSzhk?=
 =?utf-8?B?VGZqKzJXS3h2WC9MNW1XUkM3RnFEM09IbFFWZUV4ekZtdlErUG5FbktwQUFk?=
 =?utf-8?B?d1J3ZHFXdDc3djhIUmxjNWJHNkdKd2FQcTh6c3Fac1ZuWkpKeHFqNmVXUGMw?=
 =?utf-8?B?dy9WeGk1S1NGdzdHckpIckxMd2ZUdWYzWHE1ODRNRi91a3JBQ1pnZG9JWnox?=
 =?utf-8?B?NEJ2bHEvWGU1THFYTjd1SUtURzlseWVvS1pDME1sTGc1V1ZrVm1sYWdacHFP?=
 =?utf-8?B?MXVWNTd6aCtsdkFzUzZXQXpyajgrWmdSWTlaeFlFb240aXlESjB3Tjk2aWN0?=
 =?utf-8?B?dkNSdy9seDNBWHc2cWlVRzEveFFCc1l5U1V2SFVJbzY0YThRcWNFZU01QVAv?=
 =?utf-8?B?dG9CdllseHYvSUdrOWFmN2dESjUyUVhHUjBmZ3h1WTFxWFdZZllDVXdzRGdK?=
 =?utf-8?B?ZkJRd1pyS0xSOFZNUm9UTWk2UDJ0OW5mOCt5bmc2Vy95TnIzbDRLM1R0OG5i?=
 =?utf-8?B?aUZ0TlBmSDF1c21aQzBrQ0ozRkFTOW1VUU9VZlZtNFgzWEpMSWFCSHFaVUJZ?=
 =?utf-8?B?aUxWcy9OUWU4VTRYREJYSzVxNHBJSUFIdlAvSXo3TzZ5MUIycnlMRFdzeEJj?=
 =?utf-8?B?UmU3Vk00ekpkZGVJTitaUllGRmF6VmVCMzFVb0lrZElkMmw3TXhGdE13eUxJ?=
 =?utf-8?B?ZUY0RXMvbUNpSXVlaUJRSlhuWlNLclhHRkhFMXFJamoyUjA2M0c5U21KRjl2?=
 =?utf-8?B?VE5jTEpKZ044ZmNJbWhsc1NBMUNQV1BuTFVrQ2ZlSjF0QmRMTkxGc3Y2Y0lh?=
 =?utf-8?B?S3RydUtHekgzSHhrQzRTelh2WWt0RnpwVXJxSWtYOG40dGNEMWd0Vk9vR3Vn?=
 =?utf-8?B?TEMxMEg5SzJsQ05zNzIyNmRtZytqQTFaZzlWWC9TMTFjUlR2elNmSUdLR0VT?=
 =?utf-8?B?eEJrZjlJa1FvNHNpKythVDRyelNKNnVNTlNvaVpvY1hGQzdxMEJsM3JNS3dH?=
 =?utf-8?B?eDgwUkJaTnM4OHo2SkpiQy9uR1MzdHYya0QvUkhQRDd2UTlTNmU2V1JJdVFB?=
 =?utf-8?B?Sjl2bXB3eFFsTFEzS0tEV3AwM281UEN2ODdSd3U4TkJCYkE5MTlUMHFoZ3B0?=
 =?utf-8?B?UXFxM3ZqcXJTYjdPbFhQeWNUYU1XKzN1Um5nUk5GNjFEK2QxUlZER2hVdWtG?=
 =?utf-8?B?OWJGL29BNStTZ0hpNkhZaDNIeXpkdjI0UHdOSnhpYXl0WUVuZWJyRi84UHFp?=
 =?utf-8?B?UlhaTGk0WjVTM0NxekwzMUlVT2lkdUlJSWFyVFRSVkUvN1k4VHFkU3UvSEVt?=
 =?utf-8?Q?NEo2R5E13zX37mUg=3D?=
X-Exchange-RoutingPolicyChecked: K7wqn4PGwdX6CkA5KI/OaW6cBk+eWKoMDjh90lSvgRkU9Vo12tKmZjUehH/mXu/Srl3V/UOyLLOV3Du+2H/QoGsAwqhbNHeipIDGIIS0+3/3zFa4xdHiLQNpxPpFwXE72Hph91z4HmmI+NKV9RQ7xydUBFI/Y0Nn/IAHrtiVYqk67X8GB0wjLSSZJSBEwCU6ETCOdBRuG+aVAzymKk+L31h4b+oBCXH2ZFTX5kkvPcz0hByYitYkmbc22BMDbaM/lzBDujZGZVIMcWFQMW8ANCqNeFOgrmj3e1RNvFY4ZAjvH50x1SmK6sRP/pz2GX2UV4BrJNOh5jKrPwxxO0xzmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dce1eefe-040e-4327-28f0-08df08204f32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:58:17.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR20MlxECT06IXdhlq+mY6AU/SQd50L452iTyZFO2LQjVbb9sGQX/u/x/hQFbrWkHznHkgkTh6smPUBXSlVYOuuzCWWDYx4MiIm4Z4dV3UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
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

Hello,

On 2026-08-17 at 10:11:10 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Error path `out_restore_sg` corrupts unprocessed elements of reused scatterlists.
> - [High] Accumulator `iova_len` silently overflows on 32-bit systems for mappings exceeding 4GB.
> --
> 
> --- Patch [3]: [PATCH v5 3/6] iommu/dma: Catch scatterlist length overflows ---
> commit 955c8f50877d1e47058e0056fd63e5f20f4d62b9
> Author: Krzysztof Karas <krzysztof.karas@intel.com>
> Subject: iommu/dma: Catch scatterlist length overflows
> 
> This commit introduces overflow detection for scatterlist length fields to
> prevent silent wrapping when very large mappings use only one scatterlist.
> It adds check_add_overflow() and overflows_type() checks to
> iommu_dma_map_sg(), failing early if limits are exceeded.
> 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 9a07eb39336eb..61cb64bcbd3cc 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> [ ... ]
> > @@ -1476,7 +1478,22 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		sg_dma_address(s) = s_iova_off;
> >  		sg_dma_len(s) = s_length;
> >  		s->offset -= s_iova_off;
> > -		s_length = iova_align(iovad, s_length + s_iova_off);
> > +
> > +		if (check_add_overflow(s_length, s_iova_off, &s_length_tmp)) {
> > +			ret = -EOVERFLOW;
> > +			goto out_restore_sg;
> > +		}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but these newly added early return
> paths make it much more likely to trigger a pre-existing issue in
> __invalidate_sg().
> 
> If a driver reuses a scatterlist without calling sg_init_table(), and the
> subsequent mapping fails here during element iteration, __invalidate_sg() will
> loop over all elements rather than just the processed ones.
> 
> For unvisited elements, sg_dma_address(s) retains the stale IOVA from a
> previous mapping. __invalidate_sg() erroneously adds this stale IOVA to
> s->offset:
> 
> drivers/iommu/dma-iommu.c:__invalidate_sg() {
>     ...
>     if (sg_dma_address(s) != DMA_MAPPING_ERROR)
>         s->offset += sg_dma_address(s);
>     ...
> }
> 
> Will this corrupted offset lead to wild physical address calculations in
> sg_phys() upon retry or buffer access, resulting in arbitrary DMA memory
> corruption?
Fixing this issue is outside the scope of this patch series and
will be addressed separately.

> 
> [ ... ]
> > @@ -1493,7 +1510,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		 *   time through here (i.e. before it has a meaningful value).
> >  		 */
> >  		if (pad_len && pad_len < s_length - 1) {
> > -			prev->length += pad_len;
> > +			unsigned int new_prev_len;
> > +			/*
> > +			 * For large mappings spanning multiple GBs we
> > +			 * may not be able to fit all needed padding into
> > +			 * sg->length.
> > +			 */
> > +			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
> > +				ret = -EOVERFLOW;
> > +				goto out_restore_sg;
> > +			}
> > +
> > +			prev->length = new_prev_len;
> >  			iova_len += pad_len;
> 
> [Severity: High]
> This is a pre-existing issue, but since the patch addresses scatterlist length
> overflows, could iova_len silently overflow here on 32-bit systems for
> mappings exceeding 4GB?
Changing this is outside of the scope of this series and this
patch already got r-b from Robin without this check, so it is
not desired.

> 
> If the size_t iova_len accumulator wraps around when adding pad_len or
> s_length, it would lead to an undersized IOVA allocation. iommu_map_sg()
> would then map the full physical memory range, overrunning the allocated IOVA
> space and corrupting IOMMU page tables.
> 
> Should there be overflow checks for iova_len accumulation as well?
> 
> >  		}
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817095648.2438192-1-krzysztof.karas@intel.com?part=3

-- 
Best Regards,
Krzysztof
