Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40170CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8A610EBFA;
	Thu, 15 Oct 2026 13:37:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B832010EBFA;
 Thu, 15 Oct 2026 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792071462; x=1823607462;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8eg5/b/LkKfW7Otpo5C2ybjYmgScvb+8xE6UT3ynFT0=;
 b=H629Y4dQ42lpC26eAJWjJWimVPiLmCr+tpgKPOUiMyD5yTKDcX0dRfMP
 XcUHCE06k5amzJRDtpgp+xLe/QgZ//y/XNtsImmr4kGTEdZ9zT8QMyCQD
 HnShffitQiq0gJCBdW/qZHgJIRqA3ALQhUlcQD2jdHLVGWugKgOinEwxb
 tK3F6J+oIoB5euPSSxALvjpuaA29hw4JhwDJgAfuD+ZuXA1PH24fkaeoW
 E7vHgLVmJjEg7ywvgw1wltIR5muJwOVARStsu5ia6oNBX5I428+lvZS+7
 T/JbzI1Gw6XAms+cfKx9VTiSw8TOAQq1PSWYWyUb26g0IKdibbFGZ13HZ g==;
X-CSE-ConnectionGUID: VSBf+UejSiqiup1XwSqYSg==
X-CSE-MsgGUID: AQS7PijXQZaaHsxBKwUC4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="841963"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="841963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:37:42 -0700
X-CSE-ConnectionGUID: u4fmBVzqSHmDPABtk91yTg==
X-CSE-MsgGUID: ul4amQoJTGW6yI4kxreC2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2167315"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:37:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:37:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 06:37:25 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpuJWIMuTLD9Bkcb8ny+4c6adC3QCKgfQMeRp8G+wSbsHAjpHckda44s8dNzA5NVZpLfcGundCYU57KNWY6XeoX/NCyiJhMuGsTsPJ0P9j4Vc6mXW+XVBYcIx6UiaJo63j1RXhkN7h8/yWqmdRfGbMXVtsfYPJf8gY9ENdCAGi2dm8p1ArFUhbkYpvA1yr5UX3FtbixFI6yIJV9VNiT1YABzPfS1wxO4O1a7r2Y8dX9XAIYVsXf2ML9pajLjZogHynAdi4A57udV+vBEW7LRzOTuzMxiJZLEpn+MH0K0IU5wpqfNq83RupwaU2TaD6Oy4yuvEIBxChrsCMH2Ke5B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8IAhlI598vJA5eB13wMZdMjjP3ADEtqf3iqgf0QvYg=;
 b=q3s76fY8OvUWG/LwAZMBdUyCy4kKGRPhM5cxooZfaP0Wvjt2fDXPm8GqSt7Hut5OL1FrunZM2wqp3RJFE4OCEglSn+ZdMLT6jnAaZju3oRHgR/+n5DHBA5vgjflMiXtbCREKzQApRII2uYvH0CuqIQQQ6fhUVJiSBzBMZ0HqX0hewO3/9NGpkuB6i+6Fdmvyoq3BaszTG0wDOM1vmahV+Kftd7kem34ixxg6XKcc3qa5om469gTYgK3G88uEpDWyatXW7qg+sFQgjtKY9Hv+s3QSkelMb9eL/T9UTD0tw63QjAigEIUOKX5Yr/7H3lhmcTHXCNb4/Jl7hQD3qt5L3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by LV4PR11MB9515.namprd11.prod.outlook.com (2603:10b6:408:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:37:22 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 13:37:22 +0000
Date: Thu, 15 Oct 2026 09:37:18 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 <dri-devel@lists.freedesktop.org>
CC: Jani Nikula <jani.nikula@linux.intel.com>, intel-gfx
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: Nasty console and xe driver interactions
Message-ID: <atDXDlI-EhrA791a@intel.com>
References: <5e79d3c0-5b2c-4e6c-ba38-3b723daf7109@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e79d3c0-5b2c-4e6c-ba38-3b723daf7109@intel.com>
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To DM4PR11MB7181.namprd11.prod.outlook.com
 (2603:10b6:8:113::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|LV4PR11MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b310a94-e203-4ba0-878b-08df2ac170e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rWR1RHJtL6+CkuJJp923f1pfGMz9wylCbyBP8/UEHH/U+Ind/YBjE0aC0cs/4EIYry6ZX2WdROQc7KlSUIIIb69ZNxuyVzm0pkcZ9VX4Sxc+qZNpWOq04I270pTIX2Qt/QvMtlby9xscwPjBIoxRoIY0ibbYPvzJxAICc9YUIzuMMkHXhLOhvwQb557sgdciesvDMuC6TQNfGv4vZTlzQrEoS7oi+kscJk0+V0govMrThFz5hZYxIe6UgRgJA5cI4j0ytgfaH2uRZp8sB9gMy8ZC9MinfoSqQCYh4Ziip9lQbZoSXzWJTyVXhbzNr0qvnbxiTgsguNaQCgEvvohcysFm8zcO23qruGXcbtNYOK4yMJcyA9v3ZABbmHpVWrTxNvC5Ta0HiwXS5jKvNbFt+W28ZT3QM/ts05DHQJG1fJ8mdtXeYpFrSJUuI3vJfs/KVs1hb21d8zePzbUUCP5MBINbLxckwENucrQTI/gd8OF63cLeavWbcYmdFyWbpu0C2w5er9KHcwAV3WFRXhrGkXmhLVyfdSGeS1BAaQdXCTi6hlF/W/P6ztJlBKisD5zex1h79S8ERbNLZAoetv62epzMt3+jk8qp5krUDcpNU1d8gwujiXqk1XiptOlLP5zh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9YYkSDrVzqNYilhxVUOxS9brxXyseb71QnnFI0Tagl4F8D6VvjwcE/Q1vcp?=
 =?us-ascii?Q?OETXnPzzJ43kI86780aE5NjuMxPtw+9dWZModDrfQvpU/cFPespX59xqPN70?=
 =?us-ascii?Q?ET+1LGFg66QkQQX/PH9lejF4IrUQi3PVuFaL77bXS8ArWTFQpL/3aR/Zz5cv?=
 =?us-ascii?Q?Z1eiqUjeR1erb25Qd73wUCJRRNIYjp257bu/LbMazxffnNvkXFMktmINA5zy?=
 =?us-ascii?Q?+QqL72jF1V2K+WStqM9qLW/WQ8maEcIg9V5RJF6FJv4OnnhCEO8H1zmS483P?=
 =?us-ascii?Q?81OZDV42/zgwMxnMSR+Dv4QOx7RtXvUVwBMKMzSNKrOSx/kuzcWf4n3md6Ki?=
 =?us-ascii?Q?obVx6BlalPJEkE4LqqhrGNVIYwSHM3QDhByWWCO5t6ZfqwHUfvxV2OCvynXO?=
 =?us-ascii?Q?oYDQTbJRAeTh9fKbjc+Ntb3khZCrf3dTIzMoZdqEoH1MfS20ROCT5era+099?=
 =?us-ascii?Q?sfwh2MpKArvIr9aB6u+24A5RRcPMEcXjwG3GxuEZAJ3o0yF1BiUGhCayA7ex?=
 =?us-ascii?Q?+I1hMm+t+2hj5GxTp19H8hi6tIXcQ6R5Aggxk3EbfgiIbjIUZ6QcoT4djDVb?=
 =?us-ascii?Q?Y/S2Xic7zWhvEtfdb9AIPYDj67KzdF6qlqh2gx01FC81Byds046NVzsKbyff?=
 =?us-ascii?Q?nOWD7t3Z43G+TWzKTw8c6acn2B5/nSP745AHw4LsXW65UX31/+e3WH4JXK7E?=
 =?us-ascii?Q?VKzIZiJPD7y45GBT16SjYFqWxbTzgqz8xLSiNyg1SI2I40K9NgaTE1ndNyk8?=
 =?us-ascii?Q?rrEMpWy1MVYd91nqQJPyFjjbH8B5gj+HdzsqJla8xx8qevYSMuPVlN6ACduR?=
 =?us-ascii?Q?1/zeDmS2TdikS2Fp801ZQr5SA3FOEf46kFC6umq+t+Vm5KREFBwvu3DpX6lW?=
 =?us-ascii?Q?KJdsA+cM0ERmWSJNNHE+bJ2qCs481bgD6FRuC5rcWWaqgNIRVQ/xJnC5Rf8Z?=
 =?us-ascii?Q?RJbiWzY1gq4Brri5ANmzMsBemfW4yJ1svlGSbXOUn7ubuB22xVst7qvDdTvC?=
 =?us-ascii?Q?ltnEih3DMM9FawdzA/in5MGTMPYud/n5QzXlAMRlBnVQwr446bu7+JXHzJL5?=
 =?us-ascii?Q?MJMLu8KhRnnOo+Az9wBhuCIvcRro+0GVfjSY9FlQyy335WMzMJVrVT59SyFj?=
 =?us-ascii?Q?PwUvCWkopW8KtISfa6X0v1RxHVzaDwXsOqefgrD3DnyHhZMSnesXjcHWmc2R?=
 =?us-ascii?Q?1eBzG/xyieKdpWGvX/z1tkrEHa7YfghjSifhQ77ZdaqVQyVEZu7Xsl8r+l2g?=
 =?us-ascii?Q?LEfAr73ePIsoy1ADS1FyYWHELTrhoY2D56K2WT0WbdDQ/TkE/tSXfdbnAEOQ?=
 =?us-ascii?Q?7Gd2fYOT8w/m8kAOLiYcWvXp/dVBy+BjkzxpGyQAt2oXPvSNV10gIHsWlEZI?=
 =?us-ascii?Q?wYkHBtdeUYedAO8PamEekYLGHQadf/EN2o+JdlAE3kNatiMZAgYg4KN5/9UE?=
 =?us-ascii?Q?i33LAwW9EzXjF79mXQQo9Zyd8tCNYKGq0h7TtTVcnmKz3OSwwP3M4d6JdpPH?=
 =?us-ascii?Q?gW0u9Pwx/ZwxP7+yBdVW38IKiatMtzeLhjemUy3hDVQBBxKl56N4RfZNOeI2?=
 =?us-ascii?Q?08UDUqZzxn+bfzQPnm78IfOQp0Hgkf72g/IhBXRRdnX3n9ZJtezkLoxgWaJz?=
 =?us-ascii?Q?iQx4ts14AC2U8vwiA1zmJ+wj6B2+AJ+0aOKdAMBdBxgTPwyxTZZzSh87cG1o?=
 =?us-ascii?Q?yTQJCTJspCvXUT2vjPosrqiBXU57ne0y4+dkq86hRrwWF3EC9hCWUxTCgwRg?=
 =?us-ascii?Q?VMlIesndMQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: U6S+MUyYDyUuxA4C8zkVJrWzCdZJtNcHT6G1I/ayCzF8wI18phjyKaY5Zpe1olhTxh+QOi7kVSUoBx+N0atlvjypzZH4doHiVc9ZPCyJEwcNU2BWC9lFf2xN4+8hDQKoSqZ9jJEDdrrh5AzgsNdzaTWjdjl3KdwCh0PDSjXqsUWR45pw7FfINrqrJxzh8jrkJ1P+lL6LN7MfycSPD+Mf3Zdd/I0HJehGfyr2UPJV5FFmF/kUIqkjZezmgOgjymFlSl62hFEt8fRstl+drzHFagKRqyV/ALC8zvYxpxZg9J9kaYzdjdfwQd7dfF2iWL+++qdJuY+1mv9yhFwnXYkEUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b310a94-e203-4ba0-878b-08df2ac170e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:37:22.3352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds9u0zbWcnRTTLHGdBBXV8BgEEzX1TKui9tgiOs5sXypH3jwUwiCzHSrCiuaKawqmqPx3t4clCLuv9I/YEVYqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9515
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

On Wed, Oct 14, 2026 at 04:04:18PM -0700, Dave Hansen wrote:
> I've got a custom kernel that has CONFIG_DRM_XE=y. I moved a disk from
> an old NUC to a new Panther Lake one, and from it being SATA-attached to
> USB-attached.
> 
> The new system was hanging after GRUB:
> 
> 	Loading Linux ...
> 	Loading initial ramdisk ...
> 	<nothing>
> 
> Turns out, the root cause of the boot hang was my USB adapter needing a
> rootdelay=15. But it took me a couple of hours, and a USB debug cable to
> figure it out. Why?
> 
> Because the xe driver was falling over itself and presumably sabotaging
> the firmware framebuffer in the process:
> 
> > [    1.505387] xe 0000:00:02.0: vgaarb: deactivate vga console
> > [    1.507298] xe 0000:00:02.0: [drm] Running in SR-IOV PF mode
> > [    1.512831] xe 0000:00:02.0: [drm] Tile0: GT0: GuC firmware xe/ptl_guc_70.bin not found
> > [    1.512873] xe 0000:00:02.0: [drm] Tile0: GT0: GuC firmware(s) can be downloaded from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> > [    1.512881] xe 0000:00:02.0: [drm] *ERROR* Tile0: GT0: Failed to initialize uC (-ENOENT)
> > [    1.512894] xe 0000:00:02.0: probe with driver xe failed with error -2
> 
> So instead of getting a nice message about my root disk problems, I just
> got a hang after GRUB. Basically, missing XE firmware results in a
> system which is undebuggable for normal humans*.
> 
> There seem to have been similar issues in the past:
> 
> > https://lore.kernel.org/lkml/20251229215906.3688205-1-zack.rusin@broadcom.com/

Cc: dri-devel
Cc: Zack

This definitely looks the right overall solution to the failed probe.
So the VGA can be put back.

> 
> Any chance that could be looked at again? This was a pretty insidious
> failure mode.
> 
>  * Normal humans don't have USB debug cables lying around

Agree. and mandatory FW or initramfs/initrd flows also don't help.

So, perhaps what could be done in this specific case while we don't have
the proper one is something like trying to pre-fetch the mandatory fw.
Before we steal the fb. Something like:

(Untested warning)

https://github.com/rodrigovivi/linux/commit/5589d2883a604d52e89f44620e16d16c7fd278e8

