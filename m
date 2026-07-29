Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0EEC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CF710EBA5;
	Wed, 29 Jul 2026 11:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VDlmVVQi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D6A10EBA5;
 Wed, 29 Jul 2026 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785325113; x=1816861113;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TtVwULc30+uMj1oZOISEVqUP6QGTE4kH2whBlUbU5A4=;
 b=VDlmVVQizxb6SuxrCVWaTs9J4NHoZqcgGNX2pgsYDK4KkpLGsoBSbqtM
 o/JcKus4QkevqWkcNesJ40k7LkRZ/RrJf0Od03cSMp1SCmh7lEYLOESyl
 UxOFOED2KdLTnbeYHWM+1uup7rvGdmlB8ffiwxtIcNgve9qFzf03V4oi7
 JvgoCiU1KjVGYnFf7U4mwram7O3HC5o/G4TnV+mJYFA9wwohwZCWEQUeV
 Roe18uDelSCSrw+1S3wZKBsJwX8sgWlZRZDJFO8ocaZQ7L+Gj33RRYjVu
 mv+mZ33zI/XFqwKu+9tMAXeMW5bAOwyzM6ON4ABYngaJCEdRLSkC//mkr Q==;
X-CSE-ConnectionGUID: NUg2RizaQ+azYzPxp44Xyg==
X-CSE-MsgGUID: /51ntFjbT/C+VzU4J5ZIUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85871049"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="85871049"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 04:38:33 -0700
X-CSE-ConnectionGUID: MXvY/FHJQpKAwD+KYRO7VQ==
X-CSE-MsgGUID: JgiugaZoSoygpztuRCNLJQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 04:38:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:38:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 04:38:31 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JodjV/lDkKw9Z2IC9Mi7dVctTpqrxlYHiDZvQWy5Mq/Uo8C6HvWMi6AGkAfB6/ULnKf+Y1SKjT4mDHhVGTU58DLh6CqZh514Budp6+Bwc8oL/0CSFf2ejRi0lwwVTv9vPtFfDywfTA5VFsCUquK1hm6LTcsATvGqmniBVJH2QF4n30K+wi43PsXXTPPaauecdaM9KEkWZ1CqYrIV8vFANYqw/g2x9LwaeZpyaws++TzmBSO/eC0XjVTkDBvwfd9oqydcE30sOex4rw8XQ/4ePWCSIZj6mHEUoxwa3SuoBH9JjP1u1diVMgTBZ6cZpA6cUAZWnmnK0XmEzQps3/O9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75xp7qk4CaT9lPtr69BoEgd7FWBhmFs/n/L8ZBmpcaU=;
 b=Bfp2nHkumxH42iemWChYHFmQcw501NY0SXAl9SASwvYdS/6Fs+jaYX2AjPSVBTbTvReoZIv88hZYd0vg2OqG8VMw0nHXf7cXZtyTmBw4PEM3xiPnHwdSjYq4882x+kwKXxuGnogVeG56FUB2e7ETtSinfva8Kx6RjoaSvJW5/Kp4iR5MH581/bxiSVpQjuSXleQXpr/Saya/tiOBeFQZwzvfvat2f6OWpJ/iAncCAKs3q6j6SDYojkKjADdOqCjAizwwGmiO6F9EmmQPNa+6oECMowc9Uk8JOpMz90uAJ70vGUM4n6VEWdUG4TQI2ypOmi/35u9GpUCx38kRqP86Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CY8PR11MB7799.namprd11.prod.outlook.com (2603:10b6:930:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 11:38:22 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 11:38:22 +0000
Date: Wed, 29 Jul 2026 11:38:12 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH] drm/i915/selftests: Disable live_pphwsp_runtime on
 graphics version 12
Message-ID: <6pv4katagxbfjq5osuskhmmtafybbfke5kj5e5kmgadz6f7mn4@52nhccdgryt2>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260721091615.2680038-1-krzysztof.karas@intel.com>
 <amIJMJ_CqJlTIdhL@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <amIJMJ_CqJlTIdhL@zenone.zhora.eu>
X-ClientProxiedBy: DB9PR05CA0008.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CY8PR11MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 577a8c71-220a-403a-c0c8-08deed65e502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: HJx+7o4ziphpN107ASmqm2yFdcJVYyESz5WGNVPShCuo8fRXL1KaQKYptTsb8bOGe6V00ZJKxH8fHTfxhZeL8X759AkgSdwU9WPN9qjDf8/RZ6LaimtwIL8XYZf9dyKJFuJWUoLsGq9sekgA13Uaej81mh1xS9T+3lYzsc/wJ2uTArNFVhwsZ2GU+l16Ya2uBRqaCF60TUH6wqFTG8ndJRWqRrwr7uVw/MUZopvJLu/m42XodLofzBZ3JrbrNmJ2RQTQZre1km/p672nToJ6QNb96DNWonqWJVw7ibSqA+1sTwicBBYlwx0NVPrfAg22Nniuw066uq5eWmuu15x1PmVt2f1jxrUvJOVdS1ri5hcMnHHOKa5l+EPGp8VB2/kVgoLWfR3OBbXQwNccuU781vvaJh5wtLG6pja94ehf/xnjsOp/GfSvxF9gmtw6J/+4R0lXxuqt8BpC9xggnwpjol+Ba9eyVbwm+lYsbPEBmJo0WEGSeetLkhBUdCKmMWDZ1IFT6/vxtUaeBdljbzADj2wv2PZZ0z9Y91O6h1uFt10CLAbnONVRWlKv43ozFrQRO6tMcmR71uZIaPhCWtcIdLA19smuwzHAVwTL/PUrD8x8MFT7qBlsMHQ827CTEEXW89w5ahTaTxbfEdCDmhb/A2DKKMH7oZjb8kuH8PEbe/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2doZS9qZldPQWdKYWVyVE0wRjNLbzM1Y2oxdFNLTHRZaGFlbERqY2Zra1JZ?=
 =?utf-8?B?ODNINk96b1NuVGtWd3lWc0tubnNlQ0JKalllQjhTbGhqQnF6UzF0dDNCbGZk?=
 =?utf-8?B?VnY2bU5HbGIwbGpWdkxDUU56ZXpxb3NuVlpPMFJjaEtzRjVaZ3E2ZnRNM25q?=
 =?utf-8?B?UC9QK3ViRUpGTTRJNkh2L1ZaT0ZuQVczeTFSTFhaQTJzNDRac0dOUHAyRUhk?=
 =?utf-8?B?Q3VFRXhLUHdtSFkrMEhGbndYQTREMjJmZ2hUUjJmUE9GaHdTYmwzSmQyL3FL?=
 =?utf-8?B?dVBiVFZNbmsrRFZzeklSUm43NHRxSlZjbWFDVFE0TC94S1ZoSUhBeVUxWkht?=
 =?utf-8?B?REpaRmpIVjVnNEdEd0tDckJEbWpVaG1kQmFrZW9lTkQwNFhtRGhSbTIyTmtY?=
 =?utf-8?B?ZUpIVzFXS0FyY0VneEdIVjRMTzNuUkgxc0Y5YytiZ1VKUmpKbmlzK3dEd0xM?=
 =?utf-8?B?NGRRWFhYQU1xSHl3a1M3eHVRRGUvNEZqYlgyMzJjWkJJZ0FTaThCblB1bDZq?=
 =?utf-8?B?KzZ6YURaTGgyOFllVWtIVzRmZ1NpaWR4NXBLV0tNSFNObkpFZFFwVTBOOUUy?=
 =?utf-8?B?NnUzKytoRnF0ZzJUS05sMGJLMDgyUGd6NnJ3Z3U3blg0YVJkKzVoMXFzME1n?=
 =?utf-8?B?RCs3NklDN2xVVjZQbW1rR2l6VGlhSnJra2hxbkEwODRieHUrS2piaFZZbmRL?=
 =?utf-8?B?bFRUMWU3YVU3UVl2dnU3QXh5WnlyME9mNjBib0hWei9mV3Y3VHBCQUduemxY?=
 =?utf-8?B?b01qZE4yYlFjR0ZwbW45SDRPSXhlMEYwWFlPUndRM3dHSWRIQk96L1dkekl2?=
 =?utf-8?B?ZTBDd2ZvR0hVSGNWNGdOeHNIREVjZjFnUU81UUNJSkhNWGtUeDczdm5naEdH?=
 =?utf-8?B?NVczYlN1UWNRbXlmZ1lnVGVGRTgrV083N3o4MkUvN2dhUDdFUS9ZYnRvVk9M?=
 =?utf-8?B?aWxBQkhaVTMvYjZxeDJSbFRweU4zMWE5QWtXWlg4c3pvelNiWk5vSmNELzk5?=
 =?utf-8?B?T3U0RFBNZldqZnAyODhJV0NQWnlnREF1NFJyekZwODVRdTUzNEVUN2ZXSC8x?=
 =?utf-8?B?a1YyV1BJVmVUNWRoNndBLzI3SitVV09rYXRZNWwzbTYrOUdwdmMyUFBhYzVU?=
 =?utf-8?B?RE1GaXVhZEVSV0JKZU5kVndwMDlncGRJNnVHeGhYYkErU2V6SWRtTTl1OS8z?=
 =?utf-8?B?azdBUlN4dGxVNHhUUFE2YVpxbC9TV2MwUFk5WGRTcmFUNTVCaHQwTnVyeXlp?=
 =?utf-8?B?OFhHVWFqZGNxMnVNVGUyM0JoeE9kTTlKYzNpazlWUWhQbDdxSUJ6Y0QyZXhn?=
 =?utf-8?B?dXpWV0E3VnVPbkprY3pSSlI0KzJ3R1R5SlNjQVNmbGlTamJJQkdYMXpMV2FG?=
 =?utf-8?B?UVBQZUhJMFAvT2dqczZpNHV2Z1cvckN2VkloNGtNRTdId2luL2xRQXNXMzls?=
 =?utf-8?B?K292d3Y1b1RwSndVMEdrRWIyRVRVUzZtRDIyU0tPVnVCMWFxT0lzdWpnWWVa?=
 =?utf-8?B?bWdvV0VrV2piUHRPVzVlSWpzQVN4N0ZPZnZxSFkvOWswZ0pDMGVPcFVhcUFN?=
 =?utf-8?B?b2NQekJmaC8raGFxSjRjZFRSUExES1dqaElqRm9vRENJVitLVUNlMjVzMk1n?=
 =?utf-8?B?TDVrODJMWCtwS2s4VjhoeGwwdTBTKzFYMGVhZG5pSEZ6RnBnanRFTTVESmwr?=
 =?utf-8?B?RUdLbERUWnpFenA4Q094My9WRTZVVFF3QTNFczg2ZWhMQnVtZU9RSmpmekl4?=
 =?utf-8?B?Qy83MWduV2pEK01pSHRtblZLSHZwcmI4Nll4MGlDNXVGR2FicWZXY2NpVEFT?=
 =?utf-8?B?TG1YMjFDU3BBUUJtR3VCbHc5MmFuVUJNUzVEV2FLelpha1N3NGw1dXFXZ2dL?=
 =?utf-8?B?WHlZMDdxZDJRb1FIUDlRRVVKRWZXTTlwUWZjUzNiYWt3SCs0eHFlRGlBUW5O?=
 =?utf-8?B?UDlGdWVyWWNvV25hcHZDWkF3anBKaHVqUXppTjhJc09oOGQ1U0F0Yk44ejZ6?=
 =?utf-8?B?Wk5kemhhU1RHSHN0WW9BZ2d5M2tZSXRMZEcrd1BQeUJ6UkdPdzZzdHBIbUp1?=
 =?utf-8?B?dVRXdXF4SUZDMEwraExlMENIcmFlNS9iRC84UlpPUkp0VG8zTVdra0MrdFVl?=
 =?utf-8?B?dnQ5dCtDRWRWdlkxdTJOZDB6bHR3Um1ZTHRRUEFJbFVRS3Nkc0lEZUlKKzVx?=
 =?utf-8?B?aGNrOUlBekM2b2xKaERJWWRuMVVwSUNmNUtmeFpYRVhTZG1ETW1HRFVkbVJa?=
 =?utf-8?B?aTNmais1c0Z1Z1A4ejllRGlPdjV5bmZGN1ZJU25vazJ0OTREQVpFbkFvUms1?=
 =?utf-8?B?QWFBVld2ZDd1aXVnL2gxcEY0bHFmN0F6LzBsZVBkS0p4Wm43cUt2ZE50ODQ0?=
 =?utf-8?Q?k4dY4gLiw7kpdrfo=3D?=
X-Exchange-RoutingPolicyChecked: oVn0QPAWujWMZwUAbZ6dIleezWfD4+GgeOB+ZJ3Z3QdQmtiIi6/LTx5Ly2RglBI4xzvkEgKZm184a4gf2/PSh8aeY1Kt8Gat7pH55MhI5HekHUZWtwv9q1j90K45Olxn8fCFQNg68lCbr5VtBquaBOKvfNz+OTPwKcMnsuHtJDxGAVa2ovCvQvIslcEQdv4Nsf0DibwttTO8hvszvKfAZlCEntwjFKtPv3FOVOuJbswMCLj0LWZc5rs/GgVPKSYaq+Wa+qVOzuAz5qDm4KJQIbEbjhj+n4fjD8hu6TzW5bK6iYg27WX2/hdzcNhB3ysnxjggKdO+ZrwhrxzGgkoZ7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 577a8c71-220a-403a-c0c8-08deed65e502
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:38:22.6765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qf4l/p5kczvN4NaFCbVeTXsGwL7PF+2dP5tK0/KidaIthCIEODKFndgwZ5mq5XOyB5Fakl3va7F1FRdLlnMBzH7wSWfzAPTVS1JviFW7CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7799
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

Hi Andi,

On 2026-07-23 at 14:31:19 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> On Tue, Jul 21, 2026 at 09:16:15AM +0000, Krzysztof Karas wrote:
> > When a context is saved and then restored, the timer delta is
> > calculated using signed 32 bit arithmetic on hardware written
> > value to PPHWSP/LRC image and previously stored value, which use
> > unsigned types. This difference may become negative for version
> > 12, due to hardware quirk on these platforms. This in turn,
> > would cause -EOVERFLOW to be thrown inside live_pphwsp_runtime
> > test.
> 
> do we have any details on this hardware quirk?
Yeah, there was HSD #16010904313 written for Gen 12. Since you
already mentioned this off-list, we could add this annotation to
the commit message and skip re-sending another patch version.

-- 
Best Regards,
Krzysztof
