Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A0EC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CCB10E660;
	Thu, 30 Jul 2026 07:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i8c42RrY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA74310E660
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785398074; x=1816934074;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=8P0+xYPkLH/zVQWuZXBKvL1VES6wbzesRBk52WoMsNc=;
 b=i8c42RrYN3/hewijgds8YG6ELp9I9ckA6VKPfN4hvDpw1Wa5J7LhTjeY
 a0JdvB1POEfakq5X0KIZLOjW3HUkX1WZoUrKFj4M6J9xOHyUwtg+ZYlTm
 81JJLvTWBLh2ru97i/dchbXQfbdw8LEKIe/BBiF/JQ3piMAisAzAe3yrR
 vivVhlWtmI1H1B/cg1PjoImOpKzUh3j4oqiQcP8um7FYp2pw5I47TRezi
 Q6HjxaFdvtfqK9lQIWzLfQtHwAlM5449HG3ihfvWF5U1Hh0stIYmmgtRz
 BPIx90tTsFZ5sEBWxk96BXJ8+/2S7rkaKkoXsxpak84M/Y9cSi44uxZ70 w==;
X-CSE-ConnectionGUID: GgZdQhvuRbOWKdp/8L9OsQ==
X-CSE-MsgGUID: 1UVi3OpuQXuOOw2eG7gOFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85137479"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="85137479"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:54:33 -0700
X-CSE-ConnectionGUID: EX+fF8ZWQluciUzBCMuGug==
X-CSE-MsgGUID: pA1+3ht3SsmjMRH8GeUIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="258991950"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:54:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:54:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 00:54:32 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjxwPXhKGdAfhVD0/CtR2vizZu3skUFrLC9Ziu8CaDBhMgaJk0xh99hQbRw/SeJ+pOQsHaSjYIDcaB1da3NWFORI7BmhOzeSiXV/AKcDfhoJUbdTbCUb49NbkEEwQ8ZeygSjGvxBXvPxiNl4DN/27n5YqGBXwH26kVvu0QuyF9Pm8v/DYtb9B4P6PxS+F3zYllZg/rAo20J2yJqaf4ToLw1xDHbQeP/gYNR64q8VJIeVHi74M9cLC7p4BOl+mVgGdERmDISb0YdsgrQfyYxjBwC0WHbdZ0MrGi8uOJOE20fhouHCzO2q/LJ1+KkwwF6W7UApE7BtCew41J40UFNYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FNAF038DpMb/yEcHrU42RA38H0R0QCSxeUNQPW7sM=;
 b=YT26wnpN/SmHJtCLsToHKXzgkVlO57bsq/BczJwiH4daoUYXlg3tQPj/3mZIXdsRrhFwgpiyeOjddFLk37xYpubkeE0GtK3aTcqPgtmzY0T812ad3HAj+tnzZtaZPontf/1W84sPNkK7oqRUHw53qApMpi55YEQjPReWnj+2yC0KbEbAce3WqohG54YrfFgBQhxoQUn57+bO5ofcrQDLO/Hj4+QXLdReIEFV0+Q4cGzk4eDH2Fk/1KOTktNNCKvgA4bjj8od5l9u5KObQEuNazgbEwHSNo8bQJcYGHZTmImeuE4/fNm0X2Yu1G4ZIAX6y5E/vRFmSEUQ4J0XsAliVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by EAYPR11MB9564.namprd11.prod.outlook.com (2603:10b6:303:2c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 07:54:29 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:54:29 +0000
Date: Thu, 30 Jul 2026 15:54:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Daniel Stone
 <daniels@collabora.com>, Pekka Paalanen <pekka.paalanen@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [drm]  860e748bdd:
 RIP:drm_mode_config_validate[drm]
Message-ID: <202607300914.d028cee3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|EAYPR11MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cd4636-c766-4944-fad0-08deee0fc866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|5023799004|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: hH1tDj0iGInf8wi3RIwway/9Ssu20sTylfRCgZq9pr/71JjOXFREwBlcZYAU5B8ZT9vsIwb1l2VzG7ch2dtcaI6RJDoGQpMSmgtoBK09d3Md5T9fGERmWJW+gNEDzAORkd4PTNmNYxHlOyYdJkckjdsb6ibHZIg8pGFouqmF0G2cSUnKV2BxsSMOOoSuYM+lwMcMORscN2Km5tl3FnhCjHRWVUo7tNug8i1WDnAJdnWllpBM8uTesVjm949Oya1wBZBMdCxw/9Mn1dXSwo5pxvZb5lGLPYlx2QYFr9m4Pe/adfwWdRP+26gW/WFeOOm5wvJbaxFQzGDcEOdavj2b1G0Ow2g+Jx+W1gglc/nalicKxB2j9mrAXE3w9NzAxDbahcwbDESNaR26iLifWUBRvgnr69RwkdWImhC5DWRi7r2dUKo3wpX+LD6scQeSRDO2ZXqVbCP9kJabpvarx07Q7uCYTik1BTf0QSS8CbdU5k64e4OWqUsc4t7tv7eNAQCkZiafluDm+K+KKtDFQQzwfkvPAWbUclMHLBPd30nhv8WIdo+dKfEo1seZ9Fbllg0KU76LabKvgtfK7fNo9UKu6yLm9GYXa+4Gft2dfWnHc3cyWf+B9KtaRvQYlESwn6lOCyIN9yBfCDe5Md744wSA62WAix5YfC8IB48Pj5y3TEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+8fwqH10weiWVzZ1gX384vNufTNcZGBRMOFgtdhkbHoSHzHpnvk0TmhATRm?=
 =?us-ascii?Q?29ITO7zaFRsQHOfFWZ28n76xwRH/Yvt3VBD9/eVG7We/OsVOHGVSg8mXdIqO?=
 =?us-ascii?Q?TLMHciN2spA6FjZXehDW/pGBwSednFPSjQ/Iq5Yje7qSsNFkCa3H8FcihN+I?=
 =?us-ascii?Q?RrFrfOfMov/dkO2jQX/fTbiAmzL1zBF6DivOkh4VC4Tgea//hB5TlhBFIxj6?=
 =?us-ascii?Q?5yKPtToD6ceO0q/s3T2Xtc7Gqsu4VMiDlkuu9sOWarBepy/G2a0MlBw6/4De?=
 =?us-ascii?Q?AMzRKc9HP6+gV310V4uS2eT4eEfaNiD+4qbRb5bVwwQeizhBMRUdGjZe2zfC?=
 =?us-ascii?Q?k4ZSQLZB/YYguwLopaVu5lOlsLy/0Pg32bkAbb1me6O7JxXIdTyQUmlEdYkl?=
 =?us-ascii?Q?vWNahL1fEhGUGtK08NQUz4jyJSikMJ8XRKIrSXPKtnev7vgacmkVvMd8ATQl?=
 =?us-ascii?Q?+fbGVd/0xg4/YPsnTbX/5R7DGKVyEQ5WAzT8vYBiu99vTxxBCIlKel+Xgp2W?=
 =?us-ascii?Q?zsWimTdNnKmieM7CaKdvYwYF1y+jrt11ypN1WkZ1gTZo6uBk/ZF6OcnKLhF+?=
 =?us-ascii?Q?CjbBFFS8JZ/5xJOAiUg3WHeFGhJg0hOPjHTdn9ZSdlRnH+4rV/iFqLrdX4rE?=
 =?us-ascii?Q?aV3rENLerZ7U0szg41sXDKdT+S7DtvGqXJk1RIb2oX6z8tdyB+nwaM2bQXSt?=
 =?us-ascii?Q?3Cwo+acHDuIMAMm1NLiZf/GyQ4qr056uS7BR7WV0lzsitTw9DlLbl1juVxc2?=
 =?us-ascii?Q?qK7qqDZZLpC8uGYhx17JOcf+nA0ZMpdRO8tRFOTC92kBeaIGZbPfg7bvDvFv?=
 =?us-ascii?Q?/jcHMeNMJCndhAXDQcVE4Y9K4fBYRMCMpQx1sa56mK0ZNxNAo9P19yZ2GlWd?=
 =?us-ascii?Q?+05ueDI3ML9GGPKsWE943IOjcd5b7dhf9Qjnt8azcSbIoUC0q7se2w26DvHe?=
 =?us-ascii?Q?Lw95xUAnfRnzgHNQwt2UsCLuMYF1BZ2j9dasNpVABe5qFSbUcDScbGu8323m?=
 =?us-ascii?Q?U/7au+BLiGU8Qid0VR9zvyqmZ8vxEpoXCJio8IQUWNKuaPhAhuL+cL2RmbQ8?=
 =?us-ascii?Q?jLa4ZnYOJ3QgnT5DTX0CsTq/LrWNbY0W4jhUnN0xroQoMYMhcZoiiFs64RjM?=
 =?us-ascii?Q?ciqWALQEFeoBHSh1KsrioLA8gQCViAOQmPgMmaHYE8FSZmIZKlagX7Rxr+Do?=
 =?us-ascii?Q?6zHwV268kvpZxZRlEJatf0f9nsMXmk5or6Ih6dNdK0bUDSxrrHkKrDCzPUrt?=
 =?us-ascii?Q?I9OnpGEb44CzyIuUoiBtH9JPHo+GMgDEaiMp2871Zy8OzuA6adKbaOJZplas?=
 =?us-ascii?Q?kCzJ1K7M5cZAYDMKbpA04uD43MiL7SH8ALxKa7A9IhmcTs/0TSR1FQWUx6wT?=
 =?us-ascii?Q?pIltgJHe1vjIV3nZJ0EVDZwvCNwsNO2vcgpZVrL8uJpzHfnc9szIuL1V+/H0?=
 =?us-ascii?Q?jEvjfewBlKYgS0OEZBTTRA0YX4TCjB4K2w3BuDH0IZTJWfZX2Exc19n+cirV?=
 =?us-ascii?Q?66x5dr0/W2lN6SBIMYgFgmPOuMou+2mxMRrHdH6JwpATYk8e5FknYf40QrMx?=
 =?us-ascii?Q?i8+KPeHRDeqFa3BKAJ94DNamNUwhHufDRePCbzr4Hj75/7BTjHq6lAhUUiJX?=
 =?us-ascii?Q?bOto+5DETMaBE0yGSCQY3E1iJAW0p2hPhseaJxuz7et6Q3hFCVmQp82MKbSW?=
 =?us-ascii?Q?OirmE7RzLWdjOJsezaw6ai+/rKllssCRKjVhu96Q7GDW6waShCKTepunPe+4?=
 =?us-ascii?Q?qYWlOQdePA=3D=3D?=
X-Exchange-RoutingPolicyChecked: NXXKk5/qqLFb8x3m90/r8pRFy3e7zngeusjY8lDHwqqovRweCiIJtUxRHT1koDhczLeG9nYpivvc+cET3yhhpS5u6nOhWN+mnMsGPejlmKzXP1rBRFx9mFms3uuLWT9GF95c9i46KVlqsk1HKkbEudwJzbfAeiaLuDJJ/eiuDzcJAh41K+0uKG8B/u/GyfWshItZluTyinBgE6Xx8L0r7c1ps+7vn1xBr0B3jbycgZkvwnRqMhdEARTVwe9KA5JjxOgfWk6lQ6tP8Kb74xK1TeG1bq+473Z5wV6uiB5feNg6Yy5p2RJiZbd0eTbZ+R4+AmfzXdEArfn+HJrIzW+WyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cd4636-c766-4944-fad0-08deee0fc866
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 07:54:28.9851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pKCH66u7gjAOqctoSGAMYSRHUrjmxI/5PUITVcKolTtW3csEBHvS0IcjkwTxfb7UEdeCAcS9aFKG7b2WvPRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9564
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

kernel test robot noticed "RIP:drm_mode_config_validate[drm]" on:

commit: 860e748bddcc9291cbdd23e801640aeeba30cc44 ("drm: ensure blend mode s=
upported if pixel format with alpha exposed")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master b4515cf4156356e8f4fe6e0fdc17f59adab9772f]

in testcase: igt
version: igt-x86_64-6d3784ab5-1_20260718
with following parameters:

	group: group-11



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 10 threads 1 sockets Intel(R) Core Ultra Series 3 @ 3.20GHz (=
Panther Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607300914.d028cee3-lkp@intel.co=
m



kern  :info  : [  115.169208] [   T1505] ------------[ cut here ]----------=
--
kern  :warn  : [  115.169247] [   T1505] [PLANE:35:plane-0] pixel format wi=
th alpha exposed but blend mode not setup
kern  :warn  : [  115.169251] [   T1505] WARNING: drivers/gpu/drm/drm_mode_=
config.c:872 at drm_mode_config_validate+0x9b7/0x12f0 [drm], CPU#3: vkms_co=
nfigfs/1505
kern  :warn  : [  115.169350] [   T1505] Modules linked in: vkms(+) drm_shm=
em_helper vmwgfx i915 intel_gtt amdgpu drm_buddy amdxcp drm_panel_backlight=
_quirks gpu_sched drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_displ=
ay_helper cec drm_client_lib drm_kms_helper btrfs libblake2b raid6_pq zstd_=
compress xor binfmt_misc snd_hda_intel snd_sof_pci_intel_ptl snd_sof_pci_in=
tel_lnl snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel snd=
_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_in=
tel_hda_mlink snd_sof_intel_hda soundwire_cadence snd_sof_pci snd_sof_xtens=
a_dsp snd_soc_sdw_utils snd_sof intel_rapl_msr intel_uncore_frequency intel=
_uncore_frequency_common snd_sof_utils x86_pkg_temp_thermal snd_hda_ext_cor=
e intel_powerclamp snd_hda_codec coretemp snd_hda_core snd_intel_dspcfg snd=
_intel_sdw_acpi kvm_intel snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_=
quirks soundwire_generic_allocation snd_soc_acpi snd_hwdep crc8 soundwire_b=
us kvm snd_soc_sdca snd_soc_core irqbypass spi_nor snd_compress mtd
kern  :warn  : [  115.169438] [   T1505]  i2c_designware_platform i2c_desig=
nware_core wmi_bmof snd_pcm intel_cstate mei_gsc_proxy pl2303 intel_th_gth =
intel_uncore snd_timer pcspkr i2c_i801 intel_th_pci snd spi_intel_pci proce=
ssor_thermal_device_pci video intel_th i2c_smbus spi_intel soundcore proces=
sor_thermal_device intel_pmc_core processor_thermal_wt_hint platform_temper=
ature_control processor_thermal_soc_slider int3403_thermal processor_therma=
l_rfim processor_thermal_rapl pmt_telemetry intel_rapl_common pmt_discovery=
 intel_hid processor_thermal_wt_req pmt_class int3400_thermal intel_lpss_pc=
i processor_thermal_power_floor acpi_tad wmi acpi_thermal_rel sparse_keymap=
 acpi_pad intel_pmc_ssram_telemetry thunderbolt mei_me processor_thermal_mb=
ox intel_pmc_pwrm_telemetry intel_lpss mei idma64 int340x_thermal_zone igen=
6_edac intel_vsec drm fuse
kern  :warn  : [  115.169555] [   T1505] CPU: 3 UID: 0 PID: 1505 Comm: vkms=
_configfs Not tainted 7.2.0-rc2+ #1 PREEMPT(lazy)
kern  :warn  : [  115.169566] [   T1505] Hardware name: Intel Corporation P=
anther Lake Client Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.3383.D10.=
2510222219 10/22/2025
kern  :warn  : [  115.169574] [   T1505] RIP: 0010:drm_mode_config_validate=
 (gpu/drm/drm_mode_config.c:872 (discriminator 1) gpu/drm/drm_mode_config.c=
:938 (discriminator 1)) drm
kern  :warn  : [  115.169628] [   T1505] Code: 8d 7d 50 49 8b 55 18 48 89 f=
8 48 c1 e8 03 42 0f b6 04 38 84 c0 74 08 3c 03 0f 8e 1c 07 00 00 48 8d 3d 4=
9 38 d7 ff 41 8b 75 50 <67> 48 0f b9 3a e9 5e fe ff ff 49 8d bc 24 b8 02 00=
 00 48 b8 00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8d 7d 50             	lea    0x50(%rbp),%edi
   3:	49 8b 55 18          	mov    0x18(%r13),%rdx
   7:	48 89 f8             	mov    %rdi,%rax
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
  13:	84 c0                	test   %al,%al
  15:	74 08                	je     0x1f
  17:	3c 03                	cmp    $0x3,%al
  19:	0f 8e 1c 07 00 00    	jle    0x73b
  1f:	48 8d 3d 49 38 d7 ff 	lea    -0x28c7b7(%rip),%rdi        # 0xffffffff=
ffd7386f
  26:	41 8b 75 50          	mov    0x50(%r13),%esi
  2a:*	67 48 0f b9 3a       	ud1    (%edx),%rdi		<-- trapping instruction
  2f:	e9 5e fe ff ff       	jmp    0xfffffffffffffe92
  34:	49 8d bc 24 b8 02 00 	lea    0x2b8(%r12),%rdi
  3b:	00=20
  3c:	48                   	rex.W
  3d:	b8                   	.byte 0xb8
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	67 48 0f b9 3a       	ud1    (%edx),%rdi
   5:	e9 5e fe ff ff       	jmp    0xfffffffffffffe68
   a:	49 8d bc 24 b8 02 00 	lea    0x2b8(%r12),%rdi
  11:	00=20
  12:	48                   	rex.W
  13:	b8                   	.byte 0xb8
	...
kern  :warn  : [  115.169639] [   T1505] RSP: 0018:ffffc90006047608 EFLAGS:=
 00010246
kern  :warn  : [  115.169648] [   T1505] RAX: 0000000000000000 RBX: ffffed1=
035930c14 RCX: 0000000000000001
kern  :warn  : [  115.169655] [   T1505] RDX: ffff88819f72f4e0 RSI: 0000000=
000000023 RDI: ffffffffc025ead0
kern  :warn  : [  115.169662] [   T1505] RBP: ffffed1035930c15 R08: 0000000=
000000001 R09: 0000000000000004
kern  :warn  : [  115.169668] [   T1505] R10: ffff88820ae8c278 R11: 0000000=
000000001 R12: ffff88820ae8c000
kern  :warn  : [  115.169675] [   T1505] R13: ffff8881ac986028 R14: 0000000=
000000000 R15: dffffc0000000000
kern  :warn  : [  115.169681] [   T1505] FS:  00007f9d6f97dc00(0000) GS:fff=
f8887ae227000(0000) knlGS:0000000000000000
kern  :warn  : [  115.169689] [   T1505] CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
kern  :warn  : [  115.169695] [   T1505] CR2: 00007ffc2d4d5c68 CR3: 0000000=
14675a006 CR4: 0000000108f72ef0
kern  :warn  : [  115.169702] [   T1505] PKRU: 55555554
kern  :warn  : [  115.169707] [   T1505] Call Trace:
kern  :warn  : [  115.169712] [   T1505]  <TASK>
kern  :warn  : [  115.169719] [   T1505] drm_dev_register (gpu/drm/drm_drv.=
c:1067) drm
kern  :warn  : [  115.169783] [   T1505] vkms_create (gpu/drm/vkms/vkms_drv=
.c:208) vkms
kern  :warn  : [  115.169866] [   T1505] vkms_init (gpu/drm/vkms/vkms_drv.c=
:74) vkms
kern  :warn  : [  115.169879] [   T1505]  ? __pfx_init_module (vkms.mod.c:?=
) vkms
kern  :warn  : [  115.169892] [   T1505]  do_one_initcall (main.c:1347)
kern  :warn  : [  115.169902] [   T1505]  ? __pfx_do_one_initcall (trace/ev=
ents/initcall.h:10)
kern  :warn  : [  115.169910] [   T1505]  ? kasan_save_track (kasan/common.=
c:78)
kern  :warn  : [  115.169918] [   T1505]  ? __kasan_kmalloc (kasan/common.c=
:398 kasan/common.c:415)
kern  :warn  : [  115.169925] [   T1505]  ? __kmalloc_cache_noprof (linux/k=
asan.h:263 slub.c:5515)
kern  :warn  : [  115.169933] [   T1505]  ? do_init_module (linux/slab.h:96=
9 module/main.c:3094)
kern  :warn  : [  115.169941] [   T1505]  ? kasan_unpoison (kasan/shadow.c:=
146 kasan/shadow.c:178)
kern  :warn  : [  115.169949] [   T1505]  do_init_module (module/main.c:310=
6)
kern  :warn  : [  115.169957] [   T1505]  ? __pfx_do_init_module (linux/lis=
t.h:226)
kern  :warn  : [  115.169965] [   T1505]  ? kfree (linux/kasan.h:235 slub.c=
:2705 slub.c:6405 slub.c:6720)
kern  :warn  : [  115.169972] [   T1505]  ? klp_module_coming (livepatch/co=
re.c:1321)
kern  :warn  : [  115.169980] [   T1505]  load_module (module/main.c:3580)
kern  :warn  : [  115.169988] [   T1505]  ? kernel_read_file (linux/instrum=
ented.h:112 linux/atomic/atomic-instrumented.h:435 linux/fs.h:2824 kernel_r=
ead_file.c:122)
kern  :warn  : [  115.169995] [   T1505]  ? __pfx_load_module (module/main.=
c:3014)
kern  :warn  : [  115.170002] [   T1505]  ? kasan_save_track (kasan/common.=
c:78)
kern  :warn  : [  115.170010] [   T1505]  init_module_from_file (module/mai=
n.c:3777)
kern  :warn  : [  115.170016] [   T1505]  ? __pfx_init_module_from_file (mo=
dule/main.c:3634)
kern  :warn  : [  115.170022] [   T1505]  ? __pfx___fsnotify_parent (notify=
/fsnotify.c:389 (discriminator 2))
kern  :warn  : [  115.170030] [   T1505]  ? do_sys_openat2 (linux/fs.h:2559=
 linux/fs.h:2561 open.c:1367)
kern  :warn  : [  115.170037] [   T1505]  ? _raw_spin_lock (linux/instrumen=
ted.h:55 linux/atomic/atomic-instrumented.h:1301 asm-generic/qspinlock.h:11=
1 linux/spinlock.h:187 linux/spinlock_api_smp.h:159 locking/spinlock.c:158)
kern  :warn  : [  115.170045] [   T1505]  ? __pfx__raw_spin_lock (locking/s=
pinlock.c:331)
kern  :warn  : [  115.170053] [   T1505]  idempotent_init_module (module/ma=
in.c:3789)
kern  :warn  : [  115.170059] [   T1505]  ? __pfx_idempotent_init_module (m=
odule/main.c:3778)
kern  :warn  : [  115.170066] [   T1505]  ? fdget (linux/instrumented.h:82 =
linux/atomic/atomic-instrumented.h:49 file.c:1194 file.c:1208)
kern  :warn  : [  115.170073] [   T1505]  ? security_capable (security.c:66=
0 (discriminator 8))
kern  :warn  : [  115.170081] [   T1505]  __x64_sys_finit_module (module/ma=
in.c:3815 module/main.c:3799 module/main.c:3799)
kern  :warn  : [  115.170087] [   T1505]  ? __x64_sys_pread64 (read_write.c=
:764 read_write.c:772 read_write.c:769 read_write.c:769)
kern  :warn  : [  115.170095] [   T1505]  do_syscall_64 (x86/entry/syscall_=
64.c:63 x86/entry/syscall_64.c:94)
kern  :warn  : [  115.170103] [   T1505]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [  115.170110] [   T1505]  ? ksys_read (read_write.c:716)
kern  :warn  : [  115.170117] [   T1505]  ? __pfx_ksys_read (read_write.c:7=
99)
kern  :warn  : [  115.170125] [   T1505]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [  115.170132] [   T1505]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [  115.170139] [   T1505]  ? __x64_sys_openat (open.c:1374 o=
pen.c:1390 open.c:1385 open.c:1385)
kern  :warn  : [  115.170146] [   T1505]  ? __pfx___x64_sys_openat (open.c:=
1378)
kern  :warn  : [  115.170153] [   T1505]  ? __pfx_ksys_read (read_write.c:7=
99)
kern  :warn  : [  115.170160] [   T1505]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [  115.170167] [   T1505]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [  115.170174] [   T1505]  ? do_syscall_64 (linux/randomize_=
kstack.h:57 x86/entry/syscall_64.c:92)
kern  :warn  : [  115.170181] [   T1505]  asm_fred_entrypoint_user (x86/ent=
ry/entry_64_fred.S:39)
kern  :warn  : [  115.170188] [   T1505] RIP: 0033:0x7f9d71cd37b9
kern  :warn  : [  115.170196] [   T1505] Code: ff c3 66 2e 0f 1f 84 00 00 0=
0 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c=
8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7=
 d8 64 89 01 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00=20
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping =
instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 27 66 0d 00 	mov    0xd6627(%rip),%rcx        # 0xd6661
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 27 66 0d 00 	mov    0xd6627(%rip),%rcx        # 0xd6637
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260730/202607300914.d028cee3-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

