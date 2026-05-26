Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66933CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF31882B5;
	Tue, 26 May 2026 14:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z1hLwJN7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00BC10E695
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779805768; x=1811341768;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=ewHtTl27h+Q7fyfpUGyJcoIisqkPaE8LjX/dfe9qh1s=;
 b=Z1hLwJN7ASDueW/yLN7FBQxTqPJEETz+gMPEEL6YJiVfucVmkmEDqeMm
 AB2EURvOZQ/nYZdODNn99H7uX3dVFIY4E7rDK5T2HQGiV/6jFu1djprgY
 lXQ8eDmnGGqivW7GD30uvXSpS3+IqwqyMQvGEXDN8v6w43qQZFpIbfw8u
 RvWGPgM3h4XXPad2c1ZxhNWTLBKNyypxfFx9eubfFrtsy+VTqgL+1Mn9Q
 R/R7zhb8DDHVBrBiyM7gnMUB/PC1ZihUUz5gVL+l6G18Fyt+Dh5kkIRJo
 G+Fo4g+V5zQNQPtmBTfK5jd7RYsvxaj/kAmP90Mmm2EGswMagA/4E+2fq Q==;
X-CSE-ConnectionGUID: HfBFiIDcRZeD86zcTPElJQ==
X-CSE-MsgGUID: 3+pPcbojQ7+2bhZltZOpgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91310856"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="91310856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 07:29:27 -0700
X-CSE-ConnectionGUID: m/YGggkARzqgWFsponB7Hg==
X-CSE-MsgGUID: QTZIYhT3T/eSIw7TgYtttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="272268148"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 07:29:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 07:29:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 07:29:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 07:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yhcx6sKn+BOV9XDtBPlOcpDgC1Z+mj2Z0iLfBJQugf/wHPFV8+ELFRnvP0LK20YjNhToS5OWCZVJYHTVyuwsR63uhKA+h+ZBjDitHW5cV8T+D59RSqxT0u1gvEwwth7vpUWq0d7ZJhBPMYrqjIhqFSUE9gDksaM9m0fNS7Gch4JIbstchY0UF5t2PN5uJx2lejMFHjq8rKkyQDDyP4z1ySteoSa897P/eYXh8YeXE2J7ru24Zf/BYPP81QMtMUAuwo6tZ9udpuYQU+0OPXaO1varu3zkM7SrGnnlg++B1qZLVDeB5YbZOWtWm0RF0ordohYwqNyBA4bdjijvUciEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAwQVY/Srqa6cE1AqJUCO3NS2wOrCzOm4Fs1G77oKOA=;
 b=kE3Ilk3iego7uhPB+PmxVwwOSfzNfynk2Wfc4AWYzHIGTUZw4sfAd3/DfVlSxsZV1srdXn9iNEvT114l8fR8jIrpePrlhOL4bALIlOPZ3qTlVCeNgLkIvc6pHZ/NRcqVNwiNNqiIGlO8jSKWOaOq3KcLLfFnrNWKvFwLISs35QsGlMeYw5LVQgLOgink8xHSc0/AAtl0SdVeZ7hK4aeOlcP50KMLMuyL+ULAwqw0qFFOyL0WA+ENwD561prB/G9RuJ5IctkM4Q/rU3VJQCMzPq96frs/3cetvFDpVcaeUPJr3FiTkD4T53AJ8TB9d7cDQN9xl+78ejr+tZcpEsj+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:29:19 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 14:29:19 +0000
Date: Tue, 26 May 2026 22:29:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <dri-devel@lists.freedesktop.org>, <airlied@gmail.com>,
 <daniels@collabora.com>, <jani.nikula@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <pekka.paalanen@collabora.com>, <simona@ffwll.ch>, <tzimmermann@suse.de>,
 <ville.syrjala@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <oliver.sang@intel.com>
Subject: Re: [PATCH v3 2/2] drm: ensure blend mode supported if alpha exposed
Message-ID: <202605262216.c4670030-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260518175429.80615-3-leandro.ribeiro@collabora.com>
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH0PR11MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c68c58-5909-4bad-b4ec-08debb332be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|3023799007|6133799003|11063799006|5023799004|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HRt9Vf8d4CzH60RZ3Uu3q7ChHfJkgeFsJ6dIyO3KbqGD1EF5YvbO3ko1eg4SvfXNGpzXZiGFY6jEZ6kVt2pNjF3zKbeDdR0TZGtQaTTKmeVs00hqAc1MLpC2XAZ0yUqxRTh5aXuJ4IDlWTOni+/148r9hGZDofaetaeiqRAxQ5ocGeXGxRXq1LyLjLsr88lPIasAJiBYZYYIxptP5xMNtjmxqFP1ElqM1JSrJaMXyDdydylM012ADWzWLZFz3danr0mP81Q2xxKsT8LyM7ng1/9SyWVJpis1FMIaXrt3rOdCgIRJWR2KgKu71IaraawC9uIaXs5WrWWU6VbInwO+OsfdJbPXHf0QEl5E5mj7SwPzFg3MZMxzIuWDTd09qYr1sPsKDPZ04FeVYP24ZOO4z//ZMUYd1b+S0AEhgzwfVBu+CSL/dsqJjF7473SFhReohBA+I3rERJJ2jYKyOshFccDFnd07nvfkcmrBz3OWQhdKzT98QM37NEDzkkauV51K+7sc3SNbZM/iCkX1mKYrVMSbGeZebuHLy0IPPZ5MQA2JvWZi6H85mr58ag1Oq5p7EGKzamvfK260KUVQoGV9F44L6wK7hkCQ3aVEK4iZUtpt+CkXTqZiy3e3x2cXKuIBdL4CK5asebNwWAB4JboVWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(3023799007)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQ8cJYorzEJwvS6Zlzr8RmBaCmT0cC/5NtOac95OoIZMuPfgmoYFDUuQLNb+?=
 =?us-ascii?Q?GrKIMuLtLabqYbtbjlBtDgu0yFeIg11hxeyixu2uLitQkBK7zXsa81SgGgyP?=
 =?us-ascii?Q?hXc1hlHsqowj+6PVY5ZwEObR6aD9sT5pTXs3IeixfrbEKT51If3yM9epQ+1S?=
 =?us-ascii?Q?ws3FdgfExRmS15vgO3JRKVsaAsNUeMN6Xh5JAgxG7IV5IJOcgsBTf5fyGnbA?=
 =?us-ascii?Q?FoQZYZD0nNIjJu9FUi8OnUmEeKZYhQ1NWLLKzHujuH9uXmjDgT9PcrKFvkaz?=
 =?us-ascii?Q?IGJF5IMYmslYP4up1QbbXkOAliUDsmHx1Y07gfE1Gg+Pow5c1s9/vSltqac0?=
 =?us-ascii?Q?NI0011BJBisuGNslATJpf8ILpKDWewU96D3SvUs5krv9LUtRAlYE8r7f3rZt?=
 =?us-ascii?Q?vCs7AUXBkmhWSCz1ucZXYuTEiol/XVXei9C6+8B0q3d5TU5+Bj3r2SO5HwyI?=
 =?us-ascii?Q?/AoJttYpuonit8qrIm+IqHRpSqwKs1ftZachMfIjebAInvk3tDzSAMrcuCmJ?=
 =?us-ascii?Q?+T9rsJlyk3nAHc5dZZvx5xO/Pj6LcQvzEYX0tFMB2jqbVxro5M8UfB3nvN1K?=
 =?us-ascii?Q?5o/hgTpLT8SM8poDxzpd1TSazKTJe1SYXZz1vyV05aiC9unyPs1w3rRzbJ8n?=
 =?us-ascii?Q?4wwCg7fa6ADijG31r9wB6FfrFGz6um0l6zCXewnl3zT6WpsaVjlRY545nKVC?=
 =?us-ascii?Q?mGnXpZ9OiuZxwm5oZ0nYof7OrBeZ3YcCtWHMtYJTmcvKzoVFHH49UY8/qtRr?=
 =?us-ascii?Q?wMFPTcD4JLwbSroKuZRmm7SqokKwO5P6CunSr8Nam/L+IqbRyCC0Qs4R9FVv?=
 =?us-ascii?Q?LamOiZm7QSd0zcFTOeJQo0d/GzGK7fHIQqhpteR/4Q70IpdAqeSP2D2xWzA3?=
 =?us-ascii?Q?nDT1UQvCNC/8tPdGOO/Z+D7kpZGpORKCUi1a2TxkWzMWkXllKGXMkeVpAoX5?=
 =?us-ascii?Q?yyNLTvCU7pZkZj07ww98pvn2rnKmZuiSgdYZGZMTGi9uD3IkkfShAWxwfAHM?=
 =?us-ascii?Q?HNaAWKdvothhws9olsEYNA9zENZmlSm/H3aoYT98m9IaSZ5B0Y5KIlu2W4Fd?=
 =?us-ascii?Q?GUx2hJsdc+Coe6Iy+KhJ3NQhkH/0Qq70MS1w3Y1Slb644YsLjYFF0aERt2pQ?=
 =?us-ascii?Q?6xZ6FERR5V9KdwLXaeA85HKOeC5xKK+WsKRZ1QqNsSH99DzUyjXC1MMz/L/5?=
 =?us-ascii?Q?AHJ3+Q5X8BRI+Y4nSy9S1YxBnaTgrIPpggzEZy9Y4FSJk4uFIwFC6LYR96vU?=
 =?us-ascii?Q?euPUrezhI/P+bbBN2e93PwSjKOtwTsIdaRpWXiT2zndnhTvpRhwyd4JhM6MM?=
 =?us-ascii?Q?9ncVH7k6qsPs3LpHwQ1+JGR3F9QaUbi9hwoi4I8pW+g4dkKGPMOZHxjjRjCJ?=
 =?us-ascii?Q?bGuaJiGIIHHyYug2NwDWtgqOSPpyn4fYxiE5M8GAY7vVX9WthpmLEpjqAfz/?=
 =?us-ascii?Q?/NEBdYDc71wXQZP2DN8W0Q4Q0twRMaCOhamMe1kVLBeOIgrdGjwiQeU0pxGh?=
 =?us-ascii?Q?eFjr/a+WkIj6bWS2/B4cu+++kCPY3UDvOvgIHupnuJ0k0FBMLUB6pHSczeai?=
 =?us-ascii?Q?edCkZWH4yL2VYrKu0u/INiIgzo/Or/kLogy13q6TCdpABodaaMiWPoDusP6k?=
 =?us-ascii?Q?6Vy9Nph4+yCJg55N0DQ4hQDoCZ79INv1omPrrfvtaIC2/d5zjZ4D95X5FPO3?=
 =?us-ascii?Q?HpChsiAB5yRMOMQ00kn1UMGwM0R9OfHT0vz9Hfb1iJJZSRu+z8gc6J+AqsiV?=
 =?us-ascii?Q?GM2edBB0xQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: o6yZr2m8tlDcBPu5vFVVhLNm6Ng/DhbCslwA/oyhzO4TUANPRWT+sTO5v6s0JmzkGmMFafBunsCSXviky++Ez7L5BD4+rha4IJLqFXHwHV32CgP2viSGlXTjgMhf4Ww8jH4FN9z5QOk+/HHwPWXD9WvXAPsflitQ9Gf/DqS0b/sBbqUjNuflm38ztc7eHj5v5Fr7wsOOWF3wHEcZrFqSKGHRPvEUp381G7f+9t1IA6d1iX1Q9OJn5EEg9ZID6janEug17Y76j5aOKN13jLs44zCum8B5V2fg9+OSqGPrX9jZ0cazgm+IHtCvKSFNLpSZSgg4WX0imUCgMvwn7BtOsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c68c58-5909-4bad-b4ec-08debb332be5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:29:19.1006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6u7mbVJt/MIXBclVdgNWUP/cCDvVSXb8NX3rf0RZXAoCBYdNTpw3wTXoGTFn7Xvl1qFQww+fRy64RObgMlw2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
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

kernel test robot noticed "RIP:drm_client_sysrq_unregister[drm]" on:

commit: 45cd1cd31c81786e8c8965e6b7304bef6a3e3965 ("[PATCH v3 2/2] drm: ensure blend mode supported if alpha exposed")
url: https://github.com/intel-lab-lkp/linux/commits/Leandro-Ribeiro/drm-drm_blend-allow-blend-mode-property-without-PREMULTI/20260519-021047
patch link: https://lore.kernel.org/all/20260518175429.80615-3-leandro.ribeiro@collabora.com/
patch subject: [PATCH v3 2/2] drm: ensure blend mode supported if alpha exposed

in testcase: mdadm-selftests
version: mdadm-selftests-x86_64-3822896a-1_20251102
with following parameters:

	disk: 1HDD
	test_prefix: 19repair-does-not-destroy



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605262216.c4670030-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260526/202605262216.c4670030-lkp@intel.com


[   36.308085][  T190] i915 0000:00:02.0: [drm] *ERROR* [PLANE:47:cursor A] pixel format with alpha exposed but blend mode not setup
[   36.321077][  T190] i915 0000:00:02.0: [drm] *ERROR* [PLANE:66:cursor B] pixel format with alpha exposed but blend mode not setup
0m] Reached targ[   36.333998][   T65] ata1.00: Enabling discard_zeroes_data
[   36.370146][  T190] i915 0000:00:02.0: [drm] drm_WARN_ON(list_empty(&dev->client_sysrq_list))
[   36.370160][  T190] WARNING: drivers/gpu/drm/drm_client_sysrq.c:58 at drm_client_sysrq_unregister+0x1e2/0x2b0 [drm], CPU#2: (udev-worker)/190
[   36.392616][  T190] Modules linked in: sd_mod snd_hda_codec_alc269 sg kvm_intel snd_hda_codec_realtek_lib snd_hda_scodec_component i915(+) snd_hda_codec_generic kvm dell_wmi snd_hda_intel dell_smbios snd_hda_codec dell_wmi_descriptor intel_gtt irqbypass sparse_keymap drm_buddy snd_hda_core rapl ahci ttm snd_intel_dspcfg intel_cstate rfkill i2c_i801 snd_intel_sdw_acpi libahci drm_display_helper dcdbas mei_wdt snd_hwdep i2c_smbus intel_uncore pcspkr snd_pcm cec mei_me drm_client_lib lpc_ich snd_timer mei libata drm_kms_helper snd video wmi soundcore fuse drm nfnetlink
[   36.443051][  T190] CPU: 2 UID: 0 PID: 190 Comm: (udev-worker) Tainted: G S                  7.1.0-rc2+ #1 PREEMPT(lazy) 
[   36.454086][  T190] Tainted: [S]=CPU_OUT_OF_SPEC
[   36.458763][  T190] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[   36.466765][  T190] RIP: 0010:drm_client_sysrq_unregister+0x1ec/0x2b0 [drm]
[   36.473974][  T190] Code: 85 a3 00 00 00 48 8b 6b 50 48 85 ed 74 26 48 89 df e8 e8 18 bc c2 48 89 c6 48 8d 3d 0e 56 d3 ff 48 c7 c1 e0 5d 2a c0 48 89 ea <67> 48 0f b9 3a e9 54 ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 89
[   36.493547][  T190] RSP: 0018:ffffc90000abf1d0 EFLAGS: 00010246
[   36.499552][  T190] RAX: ffffffffc207c6e0 RBX: ffff88810fed00d0 RCX: ffffffffc02a5de0
[   36.507486][  T190] RDX: ffff88810db42240 RSI: ffffffffc207c6e0 RDI: ffffffffc020a400
[   36.515390][  T190] RBP: ffff88810db42240 R08: 0000000000000001 R09: fffff52000157e2f
[   36.523305][  T190] R10: ffffc90000abf17f R11: 0000000000000001 R12: 1ffff92000157e4b
[   36.531216][  T190] R13: ffff888116810038 R14: ffff888116810c58 R15: 00000000ffffffea
[   36.539120][  T190] FS:  00007ff6e25fc9c0(0000) GS:ffff8884223cc000(0000) knlGS:0000000000000000
[   36.548002][  T190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.554507][  T190] CR2: 00007ff6e3131c70 CR3: 000000040da52001 CR4: 00000000001726f0
[   36.562414][  T190] Call Trace:
[   36.565612][  T190]  <TASK>
[   36.568470][  T190]  drm_dev_unregister+0x43/0x2b0 [drm]
[   36.574035][  T190]  i915_driver_probe.cold+0xd4/0x108 [i915]
[   36.581149][  T190]  ? __pfx_i915_driver_probe+0x10/0x10 [i915]
[   36.587859][  T190]  ? drm_privacy_screen_get+0x2bf/0x370 [drm]
[   36.594026][  T190]  ? intel_display_driver_probe_defer+0x41/0x70 [i915]
[   36.601922][  T190]  ? i915_pci_probe+0x2a9/0x3b0 [i915]
[   36.608026][  T190]  ? __pfx_i915_pci_probe+0x10/0x10 [i915]
[   36.614474][  T190]  local_pci_probe+0xdb/0x1b0
[   36.619092][  T190]  pci_call_probe+0x153/0x4f0
[   36.623705][  T190]  ? down_write+0xc0/0x170
[   36.628046][  T190]  ? __pfx_pci_call_probe+0x10/0x10
[   36.633180][  T190]  ? __pfx__raw_spin_lock+0x10/0x10
[   36.638320][  T190]  ? pci_assign_irq+0x80/0x2f0
[   36.643007][  T190]  ? pci_match_device+0x3ac/0x630
[   36.647958][  T190]  ? kernfs_create_link+0x164/0x230
[   36.653123][  T190]  pci_device_probe+0x175/0x2f0
[   36.657952][  T190]  call_driver_probe+0x62/0x1f0
[   36.662783][  T190]  really_probe+0x197/0x770
[   36.667229][  T190]  __driver_probe_device+0x1ca/0x3f0
[   36.672429][  T190]  driver_probe_device+0x4a/0x130
[   36.677407][  T190]  __driver_attach+0x194/0x4f0
[   36.682128][  T190]  ? __pfx___driver_attach+0x10/0x10
[   36.687355][  T190]  bus_for_each_dev+0xef/0x170
[   36.692062][  T190]  ? kasan_unpoison+0x40/0x70
[   36.696664][  T190]  ? __pfx_bus_for_each_dev+0x10/0x10
[   36.701958][  T190]  ? __kasan_slab_alloc+0x2f/0x70
[   36.706899][  T190]  ? klist_add_tail+0x132/0x270
[   36.711671][  T190]  bus_add_driver+0x2a7/0x4f0
[   36.716275][  T190]  driver_register+0x1a1/0x370
[   36.720958][  T190]  i915_init+0x57/0x160 [i915]
[   36.726406][  T190]  ? __pfx_i915_init+0x10/0x10 [i915]
[   36.732468][  T190]  do_one_initcall+0x8d/0x3f0
[   36.737064][  T190]  ? __pfx_do_one_initcall+0x10/0x10
[   36.742271][  T190]  ? memset_orig+0x84/0xb0
[   36.746610][  T190]  ? kasan_unpoison+0x40/0x70
[   36.751214][  T190]  do_init_module+0x281/0x870
[   36.755830][  T190]  ? __pfx_do_init_module+0x10/0x10
[   36.760954][  T190]  ? kfree+0x195/0x430
[   36.764954][  T190]  ? klp_module_coming+0x210/0x2f0
[   36.769992][  T190]  load_module+0x1667/0x1fb0
[   36.774509][  T190]  ? kernel_read_file+0x3d6/0x870
[   36.779461][  T190]  ? __pfx_load_module+0x10/0x10
[   36.784319][  T190]  init_module_from_file+0x157/0x1b0
[   36.789524][  T190]  ? __pfx_init_module_from_file+0x10/0x10
[   36.795243][  T190]  ? __pfx_vfs_read+0x10/0x10
[   36.799855][  T190]  ? _raw_spin_lock+0x80/0xf0
[   36.804459][  T190]  ? __pfx__raw_spin_lock+0x10/0x10
[   36.809596][  T190]  ? __x64_sys_pread64+0x18d/0x1f0
[   36.814641][  T190]  idempotent_init_module+0x21c/0x770
[   36.819932][  T190]  ? __pfx_idempotent_init_module+0x10/0x10
[   36.825745][  T190]  ? fdget+0x54/0x3b0
[   36.829663][  T190]  ? security_capable+0x35/0xf0
[   36.834444][  T190]  __x64_sys_finit_module+0xca/0x170
[   36.839650][  T190]  do_syscall_64+0xdf/0x570
[   36.844078][  T190]  ? _raw_spin_lock+0x80/0xf0
[   36.848684][  T190]  ? kasan_save_track+0x10/0x30
[   36.853460][  T190]  ? __x64_sys_openat+0x104/0x1f0
[   36.858405][  T190]  ? put_unused_fd+0x104/0x1f0
[   36.863095][  T190]  ? __pfx___x64_sys_openat+0x10/0x10
[   36.868395][  T190]  ? do_sys_openat2+0xeb/0x170
[   36.873076][  T190]  ? seccomp_run_filters+0xb5/0x4f0
[   36.878194][  T190]  ? do_syscall_64+0x116/0x570
[   36.882882][  T190]  ? __seccomp_filter+0x22d/0xbf0
[   36.887848][  T190]  ? __x64_sys_openat+0x104/0x1f0
[   36.892842][  T190]  ? __pfx___seccomp_filter+0x10/0x10
[   36.898133][  T190]  ? security_capable+0x35/0xf0
[   36.902904][  T190]  ? do_syscall_64+0x116/0x570
[   36.907580][  T190]  ? do_syscall_64+0x94/0x570
[   36.912175][  T190]  ? irqentry_exit+0x3d/0x530
[   36.916772][  T190]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   36.922603][  T190] RIP: 0033:0x7ff6e3158779
[   36.926944][  T190] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[   36.946501][  T190] RSP: 002b:00007fff7aae0e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   36.954835][  T190] RAX: ffffffffffffffda RBX: 000055cc60482540 RCX: 00007ff6e3158779
[   36.962812][  T190] RDX: 0000000000000000 RSI: 00007ff6e195e44d RDI: 000000000000001c
[   36.970709][  T190] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055cc6043e1e0
[   36.978618][  T190] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff6e195e44d
[   36.986506][  T190] R13: 0000000000020000 R14: 000055cc6047ee40 R15: 0000000000000000
[   36.994404][  T190]  </TASK>
[   36.997339][  T190] ---[ end trace 0000000000000000 ]---
[   37.005688][   T65]  sda: sda1 sda2
[   37.009989][   T65] sd 0:0:0:0: [sda] Attached SCSI disk
[   37.071483][   T69]  sdb: sdb1 sdb2 sdb3 sdb4
[   37.077745][   T69] sd 2:0:0:0: [sdb] Attached SCSI disk
[   37.117310][   T21] intel_rapl_common: Found RAPL domain package
[   37.124147][   T21] intel_rapl_common: Found RAPL domain core
[   37.129992][   T21] intel_rapl_common: Found RAPL domain uncore
[   37.136203][   T21] intel_rapl_common: Found RAPL domain dram
[   37.142081][   T21] intel_rapl_common: package-0:package:long_term locked by BIOS
[   37.149636][   T21] intel_rapl_common: package-0:package:short_term locked by BIOS
[   37.159446][  T520] xor: automatically using best checksumming function   avx       
[   37.172690][  T520] raid6: skipped pq benchmark and selected avx2x4
[   37.179019][  T520] raid6: using avx2x2 recovery algorithm
[   37.233537][  T190] ------------[ cut here ]------------
[   37.238941][  T190] WARNING: drivers/gpu/drm/drm_mode_config.c:551 at drm_mode_config_cleanup+0x709/0x970 [drm], CPU#0: (udev-worker)/190
[   37.251547][  T190] Modules linked in: libblake2b zstd_compress raid6_pq xor intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod snd_hda_codec_alc269 sg kvm_intel snd_hda_codec_realtek_lib snd_hda_scodec_component i915(+) snd_hda_codec_generic kvm dell_wmi snd_hda_intel dell_smbios snd_hda_codec dell_wmi_descriptor intel_gtt irqbypass sparse_keymap drm_buddy snd_hda_core rapl ahci ttm snd_intel_dspcfg intel_cstate rfkill i2c_i801 snd_intel_sdw_acpi libahci drm_display_helper dcdbas mei_wdt snd_hwdep i2c_smbus intel_uncore pcspkr snd_pcm cec mei_me drm_client_lib lpc_ich snd_timer mei libata drm_kms_helper snd video wmi soundcore fuse drm nfnetlink
[   37.312666][  T190] CPU: 0 UID: 0 PID: 190 Comm: (udev-worker) Tainted: G S      W           7.1.0-rc2+ #1 PREEMPT(lazy) 
[   37.323948][  T190] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   37.329713][  T190] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[   37.337905][  T190] RIP: 0010:drm_mode_config_cleanup+0x709/0x970 [drm]
[   37.344776][  T190] Code: 84 24 c8 00 00 00 65 48 2b 05 cb 74 4d c7 0f 85 3a 02 00 00 48 81 c4 d0 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b 49 bd 00 00 00 00 00 fc ff df 48 89 de 48 89 ef e8 a0 8e fa
[   37.364363][  T190] RSP: 0018:ffffc90000abf110 EFLAGS: 00010287
[   37.370385][  T190] RAX: ffff88815b67a020 RBX: ffffc90000abf140 RCX: 1ffff92000157e0d
[   37.378322][  T190] RDX: 1ffff11022d02047 RSI: fffff52000157de8 RDI: ffffc90000abf070
[   37.386226][  T190] RBP: ffff888116810000 R08: 0000000000000001 R09: fffff52000157dd4
[   37.394141][  T190] R10: 0000000000000003 R11: 0000000000000007 R12: ffff888116810278
[   37.402055][  T190] R13: ffff888116810238 R14: ffff888116810278 R15: dffffc0000000000
[   37.409967][  T190] FS:  00007ff6e25fc9c0(0000) GS:ffff8884222cc000(0000) knlGS:0000000000000000
[   37.418849][  T190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.425372][  T190] CR2: 00007ff6e30b0000 CR3: 000000040da52003 CR4: 00000000001726f0
[   37.433291][  T190] Call Trace:
[   37.436512][  T190]  <TASK>
[   37.439393][  T190]  ? __pfx_drm_mode_config_cleanup+0x10/0x10 [drm]
[   37.446075][  T190]  ? kfree+0x195/0x430
[   37.450092][  T190]  ? intel_atomic_global_obj_cleanup+0x29e/0x530 [i915]
[   37.458027][  T190]  intel_display_driver_remove_noirq+0xc2/0x230 [i915]
[   37.465889][  T190]  i915_driver_probe+0x935/0x9f0 [i915]
[   37.472388][  T190]  ? __pfx_i915_driver_probe+0x10/0x10 [i915]
[   37.479405][  T190]  ? drm_privacy_screen_get+0x2bf/0x370 [drm]
[   37.485609][  T190]  ? intel_display_driver_probe_defer+0x41/0x70 [i915]
[   37.493583][  T190]  ? i915_pci_probe+0x2a9/0x3b0 [i915]
[   37.500188][  T190]  ? __pfx_i915_pci_probe+0x10/0x10 [i915]
[   37.507004][  T190]  local_pci_probe+0xdb/0x1b0
[   37.511650][  T190]  pci_call_probe+0x153/0x4f0
[   37.516275][  T190]  ? down_write+0xc0/0x170
[   37.520636][  T190]  ? __pfx_pci_call_probe+0x10/0x10
[   37.525783][  T190]  ? __pfx__raw_spin_lock+0x10/0x10
[   37.530930][  T190]  ? pci_assign_irq+0x80/0x2f0
[   37.535637][  T190]  ? pci_match_device+0x3ac/0x630
[   37.540612][  T190]  ? kernfs_create_link+0x164/0x230
[   37.545776][  T190]  pci_device_probe+0x175/0x2f0
[   37.550578][  T190]  call_driver_probe+0x62/0x1f0
[   37.555390][  T190]  really_probe+0x197/0x770
[   37.559846][  T190]  __driver_probe_device+0x1ca/0x3f0
[   37.565083][  T190]  driver_probe_device+0x4a/0x130
[   37.570058][  T190]  __driver_attach+0x194/0x4f0
[   37.574779][  T190]  ? __pfx___driver_attach+0x10/0x10
[   37.580011][  T190]  bus_for_each_dev+0xef/0x170
[   37.584726][  T190]  ? kasan_unpoison+0x40/0x70
[   37.589352][  T190]  ? __pfx_bus_for_each_dev+0x10/0x10
[   37.594675][  T190]  ? __kasan_slab_alloc+0x2f/0x70
[   37.599647][  T190]  ? klist_add_tail+0x132/0x270
[   37.604487][  T190]  bus_add_driver+0x2a7/0x4f0
[   37.609107][  T190]  driver_register+0x1a1/0x370
[   37.613853][  T190]  i915_init+0x57/0x160 [i915]
[   37.619564][  T190]  ? __pfx_i915_init+0x10/0x10 [i915]
[   37.625860][  T190]  do_one_initcall+0x8d/0x3f0
[   37.630498][  T190]  ? __pfx_do_one_initcall+0x10/0x10
[   37.635732][  T190]  ? memset_orig+0x84/0xb0
[   37.640108][  T190]  ? kasan_unpoison+0x40/0x70
[   37.644749][  T190]  do_init_module+0x281/0x870
[   37.649381][  T190]  ? __pfx_do_init_module+0x10/0x10
[   37.654530][  T190]  ? kfree+0x195/0x430
[   37.658546][  T190]  ? klp_module_coming+0x210/0x2f0
[   37.663620][  T190]  load_module+0x1667/0x1fb0
[   37.668176][  T190]  ? kernel_read_file+0x3d6/0x870
[   37.673155][  T190]  ? __pfx_load_module+0x10/0x10
[   37.678076][  T190]  init_module_from_file+0x157/0x1b0
[   37.683314][  T190]  ? __pfx_init_module_from_file+0x10/0x10
[   37.689091][  T190]  ? __pfx_vfs_read+0x10/0x10
[   37.693734][  T190]  ? _raw_spin_lock+0x80/0xf0
[   37.698364][  T190]  ? __pfx__raw_spin_lock+0x10/0x10
[   37.703536][  T190]  ? __x64_sys_pread64+0x18d/0x1f0
[   37.708609][  T190]  idempotent_init_module+0x21c/0x770
[   37.713938][  T190]  ? __pfx_idempotent_init_module+0x10/0x10
[   37.719795][  T190]  ? fdget+0x54/0x3b0
[   37.723712][  T190]  ? security_capable+0x35/0xf0
[   37.728512][  T190]  __x64_sys_finit_module+0xca/0x170
[   37.733736][  T190]  do_syscall_64+0xdf/0x570
[   37.738181][  T190]  ? _raw_spin_lock+0x80/0xf0
[   37.742810][  T190]  ? kasan_save_track+0x10/0x30
[   37.747601][  T190]  ? __x64_sys_openat+0x104/0x1f0
[   37.752567][  T190]  ? put_unused_fd+0x104/0x1f0
[   37.757275][  T190]  ? __pfx___x64_sys_openat+0x10/0x10
[   37.762592][  T190]  ? do_sys_openat2+0xeb/0x170
[   37.767312][  T190]  ? seccomp_run_filters+0xb5/0x4f0
[   37.772455][  T190]  ? do_syscall_64+0x116/0x570
[   37.777165][  T190]  ? __seccomp_filter+0x22d/0xbf0
[   37.782131][  T190]  ? __x64_sys_openat+0x104/0x1f0
[   37.787102][  T190]  ? __pfx___seccomp_filter+0x10/0x10
[   37.792422][  T190]  ? security_capable+0x35/0xf0
[   37.797224][  T190]  ? do_syscall_64+0x116/0x570
[   37.801922][  T190]  ? do_syscall_64+0x94/0x570
[   37.806529][  T190]  ? irqentry_exit+0x3d/0x530
[   37.811144][  T190]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   37.816984][  T190] RIP: 0033:0x7ff6e3158779
[   37.821337][  T190] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[   37.840933][  T190] RSP: 002b:00007fff7aae0e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   37.849295][  T190] RAX: ffffffffffffffda RBX: 000055cc60482540 RCX: 00007ff6e3158779
[   37.857259][  T190] RDX: 0000000000000000 RSI: 00007ff6e195e44d RDI: 000000000000001c
[   37.865197][  T190] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055cc6043e1e0
[   37.873157][  T190] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff6e195e44d
[   37.881096][  T190] R13: 0000000000020000 R14: 000055cc6047ee40 R15: 0000000000000000
[   37.889023][  T190]  </TASK>
[   37.891991][  T190] ---[ end trace 0000000000000000 ]---
[   37.897469][  T190] [drm:drm_mode_config_cleanup [drm]] *ERROR* connector VGA-1 leaked!
[   37.932701][  T520] Btrfs loaded, zoned=yes, fsverity=yes
[   38.011268][  T190] i915 0000:00:02.0: [drm] *ERROR* Device initialization failed (-22)
[   38.019369][  T190] i915 0000:00:02.0: probe with driver i915 failed with error -22
[   38.027343][   T91] ------------[ cut here ]------------
[   38.032748][   T91] ida_free called for id=0 which is not allocated.
[   38.039189][   T91] WARNING: lib/idr.c:594 at ida_free+0x161/0x230, CPU#1: kworker/1:1/91
[   38.047468][   T91] Modules linked in: btrfs libblake2b zstd_compress raid6_pq xor intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod snd_hda_codec_alc269 sg kvm_intel snd_hda_codec_realtek_lib snd_hda_scodec_component i915(+) snd_hda_codec_generic kvm dell_wmi snd_hda_intel dell_smbios snd_hda_codec dell_wmi_descriptor intel_gtt irqbypass sparse_keymap drm_buddy snd_hda_core rapl ahci ttm snd_intel_dspcfg intel_cstate rfkill i2c_i801 snd_intel_sdw_acpi libahci drm_display_helper dcdbas mei_wdt snd_hwdep i2c_smbus intel_uncore pcspkr snd_pcm cec mei_me drm_client_lib lpc_ich snd_timer mei libata drm_kms_helper snd video wmi soundcore fuse drm nfnetlink
[   38.108723][   T91] CPU: 1 UID: 0 PID: 91 Comm: kworker/1:1 Tainted: G S      W           7.1.0-rc2+ #1 PREEMPT(lazy) 
[   38.119510][   T91] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   38.125066][   T91] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[   38.133066][   T91] Workqueue: events drm_connector_free_work_fn [drm]
[   38.139866][   T91] RIP: 0010:ida_free+0x163/0x230
[   38.144741][   T91] Code: 24 28 31 f6 e8 fe 15 08 00 e9 a1 00 00 00 41 83 fe 3e 76 5e 48 8b 7c 24 28 4c 89 ee e8 e6 98 0b 00 48 8d 3d 4f 29 53 02 89 ee <67> 48 0f b9 3a 48 b8 00 00 00 00 00 fc ff df 48 01 c3 c7 03 00 00
[   38.164311][   T91] RSP: 0018:ffffc9000067fb98 EFLAGS: 00010286
[   38.170307][   T91] RAX: 0000000000000000 RBX: 1ffff920000cff74 RCX: 1ffff920000cff7b
[   38.178238][   T91] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff868934c0
[   38.186154][   T91] RBP: 0000000000000000 R08: 0000000000000001 R09: fffff520000cff67
[   38.194064][   T91] R10: 0000000000000003 R11: 0000000000000005 R12: 0000000000000000
[   38.201972][   T91] R13: 0000000000000246 R14: 0000000000000000 R15: ffffc9000067fbc0
[   38.209890][   T91] FS:  0000000000000000(0000) GS:ffff88842234c000(0000) knlGS:0000000000000000
[   38.218765][   T91] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.225293][   T91] CR2: 00007fb72fb563d8 CR3: 000000040da52001 CR4: 00000000001726f0
[   38.233206][   T91] Call Trace:
[   38.236416][   T91]  <TASK>
[   38.239283][   T91]  ? __pfx_ida_free+0x10/0x10
[   38.243915][   T91]  ? radix_tree_delete_item+0x90/0x1b0
[   38.249312][   T91]  ? __pfx_radix_tree_delete_item+0x10/0x10
[   38.255168][   T91]  drm_connector_cleanup+0x514/0xdb0 [drm]
[   38.261104][   T91]  intel_connector_destroy+0x4b/0xb0 [i915]
[   38.267981][   T91]  drm_connector_free_work_fn+0xcd/0x130 [drm]
[   38.274222][   T91]  process_one_work+0x6b4/0x1030
[   38.279109][   T91]  ? __pfx_drm_connector_free_work_fn+0x10/0x10 [drm]
[   38.285980][   T91]  ? assign_work+0x131/0x3f0
[   38.290496][   T91]  worker_thread+0x51d/0xdb0
[   38.295024][   T91]  ? __kthread_parkme+0xb1/0x1f0
[   38.299898][   T91]  ? __pfx_worker_thread+0x10/0x10
[   38.304942][   T91]  ? __pfx_worker_thread+0x10/0x10
[   38.309999][   T91]  kthread+0x353/0x470
[   38.314007][   T91]  ? recalc_sigpending+0x159/0x1f0
[   38.319056][   T91]  ? __pfx_kthread+0x10/0x10
[   38.323578][   T91]  ret_from_fork+0x32f/0x670
[   38.328099][   T91]  ? __pfx_ret_from_fork+0x10/0x10
[   38.333155][   T91]  ? switch_fpu+0x15/0x1f0
[   38.337516][   T91]  ? __switch_to+0x508/0xe70
[   38.342041][   T91]  ? __switch_to_asm+0x33/0x70
[   38.346751][   T91]  ? __pfx_kthread+0x10/0x10
[   38.351274][   T91]  ret_from_fork_asm+0x1a/0x30
[   38.355988][   T91]  </TASK>
[   38.358932][   T91] ---[ end trace 0000000000000000 ]---
[   38.364377][   T91] ------------[ cut here ]------------
[   38.369776][   T91] refcount_t: underflow; use-after-free.
[   38.375568][   T91] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xa9/0xf0, CPU#1: kworker/1:1/91
[   38.385356][   T91] Modules linked in: btrfs libblake2b zstd_compress raid6_pq xor intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod snd_hda_codec_alc269 sg kvm_intel snd_hda_codec_realtek_lib snd_hda_scodec_component i915(+) snd_hda_codec_generic kvm dell_wmi snd_hda_intel dell_smbios snd_hda_codec dell_wmi_descriptor intel_gtt irqbypass sparse_keymap drm_buddy snd_hda_core rapl ahci ttm snd_intel_dspcfg intel_cstate rfkill i2c_i801 snd_intel_sdw_acpi libahci drm_display_helper dcdbas mei_wdt snd_hwdep i2c_smbus intel_uncore pcspkr snd_pcm cec mei_me drm_client_lib lpc_ich snd_timer mei libata drm_kms_helper snd video wmi soundcore fuse drm nfnetlink
[   38.446718][   T91] CPU: 1 UID: 0 PID: 91 Comm: kworker/1:1 Tainted: G S      W           7.1.0-rc2+ #1 PREEMPT(lazy) 
[   38.457641][   T91] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   38.463327][   T91] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[   38.471341][   T91] Workqueue: events drm_connector_free_work_fn [drm]
[   38.478149][   T91] RIP: 0010:refcount_warn_saturate+0xa9/0xf0
[   38.484071][   T91] Code: cd a4 e7 03 67 48 0f b9 3a 5b 5d c3 cc cc cc cc 48 8d 3d ca a4 e7 03 67 48 0f b9 3a 5b 5d c3 cc cc cc cc 48 8d 3d c7 a4 e7 03 <67> 48 0f b9 3a 5b 5d c3 cc cc cc cc 48 8d 3d c4 a4 e7 03 67 48 0f
[   38.503658][   T91] RSP: 0018:ffffc9000067fc30 EFLAGS: 00010246
[   38.509667][   T91] RAX: 0000000000000003 RBX: ffff88815b67a050 RCX: ffffffff82a08aa1
[   38.517584][   T91] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff86883000
[   38.525488][   T91] RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed102b6cf40a
[   38.533393][   T91] R10: ffff88815b67a053 R11: 0000000000000005 R12: ffff888116810000
[   38.541298][   T91] R13: ffff88815b67a028 R14: ffff888116810220 R15: ffff88810d8b2800
[   38.549204][   T91] FS:  0000000000000000(0000) GS:ffff88842234c000(0000) knlGS:0000000000000000
[   38.558075][   T91] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.564597][   T91] CR2: 00007fb72fb563d8 CR3: 000000040da52001 CR4: 00000000001726f0
[   38.572532][   T91] Call Trace:
[   38.575746][   T91]  <TASK>
[   38.578607][   T91]  __drm_atomic_helper_connector_destroy_state+0x59/0x170 [drm_kms_helper]
[   38.587210][   T91]  drm_atomic_helper_connector_destroy_state+0x11/0x30 [drm_kms_helper]
[   38.595555][   T91]  drm_connector_cleanup+0x86d/0xdb0 [drm]
[   38.601480][   T91]  intel_connector_destroy+0x4b/0xb0 [i915]
[   38.608401][   T91]  drm_connector_free_work_fn+0xcd/0x130 [drm]
[   38.614668][   T91]  process_one_work+0x6b4/0x1030
[   38.619544][   T91]  ? __pfx_drm_connector_free_work_fn+0x10/0x10 [drm]
[   38.626419][   T91]  ? assign_work+0x131/0x3f0
[   38.630952][   T91]  worker_thread+0x51d/0xdb0
[   38.635491][   T91]  ? __kthread_parkme+0xb1/0x1f0
[   38.640369][   T91]  ? __pfx_worker_thread+0x10/0x10
[   38.645413][   T91]  ? __pfx_worker_thread+0x10/0x10
[   38.650453][   T91]  kthread+0x353/0x470
[   38.654447][   T91]  ? recalc_sigpending+0x159/0x1f0
[   38.659490][   T91]  ? __pfx_kthread+0x10/0x10
[   38.664011][   T91]  ret_from_fork+0x32f/0x670
[   38.668541][   T91]  ? __pfx_ret_from_fork+0x10/0x10
[   38.673590][   T91]  ? switch_fpu+0x15/0x1f0
[   38.677940][   T91]  ? __switch_to+0x508/0xe70
[   38.682462][   T91]  ? __switch_to_asm+0x33/0x70
[   38.687168][   T91]  ? __pfx_kthread+0x10/0x10
[   38.691689][   T91]  ret_from_fork_asm+0x1a/0x30
[   38.696395][   T91]  </TASK>
[   38.699344][   T91] ---[ end trace 0000000000000000 ]---


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

