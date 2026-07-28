Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F5C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2110D10E806;
	Tue, 28 Jul 2026 08:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRIMyZN2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA0210E806
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOM+z5vLV14OqCiFuD521q0C7cXo9n1RCE8DCVVC135OxwzSCXULRYfi9EJfhhA+tIBshDdRciwuUyvLeNYj6XpfAwNFxdHaqhQrN5W394wjhn2oetLtQKMiQZmhSfrhcBSHYrQd+8WmiKoKkz4SKbJ74DzTBA/HMJZv2B/TPZuJXyUrcMEh0zGp1IRtTZAWaqySHqX3EL7zNHZUb2vf8+r1OfDpFKl9QBOlXy46CqMlpYsND4zliGMNMi+PvTaKdwcYDE3Kk+iN5CI0LwcrVXulBO5O4VcXRuKmC74P4JYyZ5kX7wAaURwyaNQ7bxPuvxC2bkc3j4yYNLrexptqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbwpMYilAIYyfG64FqUtWGTrshaErYaTnjFSMLQ1TGI=;
 b=Zm3akefCMLZGoMD8sNjBc4ACjnQPC9Aefwq+/zfncCWZk+gFDeEdpWArTlpVrmc7a1q9a1Z//8iZ6+dr+IwbRqliPJC1XK3rdOXnPzABigzZR6V563cWPZJuOVyvDWOtB54iwk3UymMTMZNstvX137XUyXbqeCq80YPKz5oaC2ikfLSZWw5Cbk0yB7J4Rwgl8LJl0WqpSornnjUJe7mGQDqap4BB93Gk026QolNhRqqcbHHyaFNV+vOXmJ610sUF4ebXwDYG1cCJxlztWFNQOa6Ih23QkVZ0XggjwkrNWMa3ZF9pl+oX10qbnGgj90XPswflwgCtZDRZxy7wqQkT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbwpMYilAIYyfG64FqUtWGTrshaErYaTnjFSMLQ1TGI=;
 b=jRIMyZN2/IA61naFvKKbeeyi0GzpMkEvYu4zrxwyGJpSaOZA7tnR24vW6/gVsjioxc92cH6u8luZ5oEP/c3a+IQa/NRHPQzW8SC1FdlgfYPqdtylZCL5WjBbLdK+7cXB5ORcbYiXQrG1aEF3kVCBv2UlXp9JVhO+gRoFJl5fWRc7UB6GB7QrJt6tiGf8djMedFpQ1HAvo/XjDNgoW0rEt/wIRa3I2idHbGC7cdh0QOIC4SeVBQzljf4xoOrdNhL46zDvXEiOGgNem0yRGgfHm0VMkr5SCGxeK8qX4I597v8ZV73eiC30UjqpJKyX54kSAw3LpfA/z+A/JkZT17DeLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Tue, 28 Jul 2026 08:01:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 08:01:04 +0000
Date: Tue, 28 Jul 2026 18:00:59 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Message-ID: <amhdA35CcMD_uY2f@nvdebian.thelocal>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org>
X-ClientProxiedBy: SY5P282CA0074.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: e98c8f3f-aee8-498b-4825-08deec7e5f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v5RnSZyZdqPbFYaVhJlY9+Fem03vk8t05eAe6QbXS0PzYeLXPidgw/JtP3v3FPXxpi4howD6gANiZn/Vu/qFKKcfpE4PnlmhY2zCYyJ7TiWT2CpAzPDo7XkE19dYxe9uKO2st2pseEXxahmncadO5KG/vtyJlJxx/pfN1CWJ4CUTLnogbDIi3Zv8cZa4+fjqT6nHE6Mtlea4723icWSfYcIC7ZkYVw6Cj4zuL9L0Um86zP1bKM5Ntur2Zypnz68vJhHbtHf9gz5lU+HhDV1nTPGTEvN/HDEbbCq7Y31mjvHHMfNEqXIpm9z8QIG9Mj301jWMKivB2PW1kI/LMG7klM7B8GGM8WmzqySCM9Mu6yxjmh8F5+u01U8zZS+n4iVmcayVStshd3P/Nk0HdLir3ebnLq6xTgZ2uKj9LryRn1fKt5X4Tau298vjIvaNiewVDPm6YxtYM7LNhjaMNSz0nSlgu2UJqMy1LuwwYoAR6IGmDpcQ6evS2waA/LHG/UcuoU9JEB0ihssFP1Y7sWm15xt00B8kpsRga0Ie7Jj9QSbXbn7+XxzdzAPNJ7R4pSqNh0ROXh1U65fomI55E45I+xDZQ0EYF2/dMAtcszmmhCi/JTjtoGtWkzMyYgIAybAIP6Rfgs2pjyyUrSxGx2aTdHGaP66myN98MXgC5Yki3TA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVgPQpB9NI8OGSvEmqL/Lv1uF0tt9JEfIAP1U6K62YbmlXFxORE9HxczOihR?=
 =?us-ascii?Q?NQzOBXj3lxXsPMIHZ4igikeg4YliMn7fmoMrG8UB0HIfjNBYTKW/PtpbVmdy?=
 =?us-ascii?Q?cZaW1HoiNo2PGo50q1QzDv0fb/f3Bg/qp6bdH/pnkjDS+AzDwVFtTzcru1bW?=
 =?us-ascii?Q?20uUnSW7wQzk6bOgcBACwyEasb/9gxxQbQrPnDRi4uaaaVuj+JjPpF856GEJ?=
 =?us-ascii?Q?bA6Y/+XdRu3Od9mDJ6DXePWWULgu1QbWzYx1M9wFUVQu8CWbgT07V4VgzN9K?=
 =?us-ascii?Q?q+omcepMNISEh2xPZWK5jJpSsvhP9iuGzOtBDlV8sgbYw6EdsGBo1QrVzYTJ?=
 =?us-ascii?Q?xJ/IUG8lgXFuMBQXYCqOzEabc3LafXvmRtnIqnE+mUcaYZkzfj/FNPiYBM5r?=
 =?us-ascii?Q?B0x6gWeK1O+VndHZIQr82tWhQxPoCx58BaoqeBVFyIdlpe3uCwn1yBIPWnHy?=
 =?us-ascii?Q?5qEyRqaBGr7xXpmLFMEbOoeOaydV9ZZOGnNcVficHd6whuegn66+NvsC4pMg?=
 =?us-ascii?Q?caUUmx5FkLOzUOEKlpLyEDaIg80AkBiKNVF4GtPPkOCvlYsxPeHVB4/pjf36?=
 =?us-ascii?Q?6Ki9FGkjiHKAmPjLRD+rxhXFPeb3YuBw4hmJD4ZFnqt1VCAEftBD5t+WFGmV?=
 =?us-ascii?Q?kIqd+/F6LH6s6mhqTTHlWd97H2ZLGBC2DvzfVRwLrQhcKQA15RKLN8OXYRBQ?=
 =?us-ascii?Q?/rdiZ3l/hY0NOVk5waCrqGqFWlnxWhnm9BK6DJ7mNdAM9N8bqA25AhqUtKnf?=
 =?us-ascii?Q?+iXWi6Re37k+BtRC231pcN5zywAQ/W2aYeOzDL1kU0SWtTrZS869T6DHK96R?=
 =?us-ascii?Q?o/qGEI2OlsII6vaCV4imCDlopRFIsXdhQR0TISFyLM/c/DsIcqow+oj2DO3O?=
 =?us-ascii?Q?4KrYlrrkQmAAkLDSdV2civUTpk8N140H+5xd6IHrEjY+Sbk8BXX0bzHiQuTq?=
 =?us-ascii?Q?+cIyULDwtwWSRvIJD03BxQhi6dFqFn8bJcnOgr1vP0B7NlPRhq2ar3XMBENV?=
 =?us-ascii?Q?Jz2MpYnTNjjj+TNSQijvcF4jgwDbfK35s+WAwHexV1A9k+ZXbjGi+rN7p+mv?=
 =?us-ascii?Q?YuhKUgrClR5HCWXJn0kCq92zXkKXHgjiombO5/mbHzGwJv4/u4L/2LT3LEGO?=
 =?us-ascii?Q?M9csZT/CDRMrJ08d7RPxAPHYIH4Io+5xh6uA9iBb3mSKgmslnXt2avF2hh6t?=
 =?us-ascii?Q?aFOLWh522buEEHkjS2EiYJW1kmgUDQYyDksNKm0oKzKw7F1Sfv/EjpF30Jgi?=
 =?us-ascii?Q?OsBH+gAdgKcW/U/O9XJqWUrhnZRsNyEoqWfdsp4uUf419IzD9kpqH2JDs6Ip?=
 =?us-ascii?Q?EqrtdRchKccVay7HzkGcKM3MGReatycNPJzhKDR48Ckvmsu1ZQIBU2ABTPj8?=
 =?us-ascii?Q?ae9ofC/BSBW4Z1UqeJ24kDhTRHwmu9OIVvlJYLOyJgRRXqukAjQvl3wuL7Hk?=
 =?us-ascii?Q?x43VXdRCCRcSqwTyvjnDeDMwLmYaUtdnR3xEQjpMX1ZH3aHOn6dxvaUiHvYt?=
 =?us-ascii?Q?eNgmg2Y+gDMXB2OfYVLyZR3ED/oJmf+6+32YlqB56XHxNoG9BKsNQVLhzVfD?=
 =?us-ascii?Q?E6u7eVzQS2/Vnpgt3t4SELzAL+qTOo/q0jksZRFf7qxkF8V2eE2Lr+5qrigz?=
 =?us-ascii?Q?+Novwiw+DkjM8oSXcmdNuMeAtbbLaed2/TNvhnejn/0yzIF5Paww71xuCkTC?=
 =?us-ascii?Q?bUiAabu/KM5poMGkouKM5IRTImYOEuU7dGUuK+VqEQUjJG9WxMnE+4EkzDUi?=
 =?us-ascii?Q?sA7WVED9Mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98c8f3f-aee8-498b-4825-08deec7e5f7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 08:01:04.7831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emoefr7Nd20s72oCdcUnJcZD3NVBeNc8O64vOn35HHN0XxQgpeDZpXXpyRBO18cgdZs83Ogq4i+w99ovCDoNAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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

On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
> > diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> > index 3ca90ed9d2bb..cb13fba6b952 100644
> > --- a/include/uapi/drm/nova_drm.h
> > +++ b/include/uapi/drm/nova_drm.h
> > @@ -25,6 +25,39 @@ extern "C" {
> >   */
> >  #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
> >  
> > +enum drm_nova_chipid {
> 
> It seems trivial, but let's add at least some documentation.

No, good idea.

> For instance, what's valid for userspace to extract from this? Given chipid is a
> composed value, is userspace e.g. allowed to make assumptions on extracting the
> architecture? Or is this something we want to expose separately and tell
> userspace that the chipid is an opaque value identifying a specific chip only?

I _think_ it makes sense for this to just be an opaque value, but it's a good
question that I should probably try and get some internal feedback on as well.
Reading the arch would then be a separate parameter.

> > +	/* Turing */
> > +	NOVA_DRM_CHIPID_TU102 = 0x162,
> > +	NOVA_DRM_CHIPID_TU104 = 0x164,
> > +	NOVA_DRM_CHIPID_TU106 = 0x166,
> > +	NOVA_DRM_CHIPID_TU117 = 0x167,
> > +	NOVA_DRM_CHIPID_TU116 = 0x168,
> > +	/* Ampere */
> > +	NOVA_DRM_CHIPID_GA100 = 0x170,
> > +	NOVA_DRM_CHIPID_GA102 = 0x172,
> > +	NOVA_DRM_CHIPID_GA103 = 0x173,
> > +	NOVA_DRM_CHIPID_GA104 = 0x174,
> > +	NOVA_DRM_CHIPID_GA106 = 0x176,
> > +	NOVA_DRM_CHIPID_GA107 = 0x177,
> > +	/* Hopper */
> > +	NOVA_DRM_CHIPID_GH100 = 0x180,
> > +	/* Ada */
> > +	NOVA_DRM_CHIPID_AD102 = 0x192,
> > +	NOVA_DRM_CHIPID_AD103 = 0x193,
> > +	NOVA_DRM_CHIPID_AD104 = 0x194,
> > +	NOVA_DRM_CHIPID_AD106 = 0x196,
> > +	NOVA_DRM_CHIPID_AD107 = 0x197,
> > +	/* Blackwell GB10x */
> > +	NOVA_DRM_CHIPID_GB100 = 0x1a0,
> > +	NOVA_DRM_CHIPID_GB102 = 0x1a2,
> > +	/* Blackwell GB20x */
> > +	NOVA_DRM_CHIPID_GB202 = 0x1b2,
> > +	NOVA_DRM_CHIPID_GB203 = 0x1b3,
> > +	NOVA_DRM_CHIPID_GB205 = 0x1b5,
> > +	NOVA_DRM_CHIPID_GB206 = 0x1b6,
> > +	NOVA_DRM_CHIPID_GB207 = 0x1b7,
> > +};
