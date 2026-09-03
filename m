Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91107C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E2310F651;
	Thu,  3 Sep 2026 15:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NPe94qbb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1DF10E433;
 Thu,  3 Sep 2026 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788450377; x=1819986377;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=owtWWGEQsFdGZLFUHq5FooG/mbim3QLEn5JiLeLfAkc=;
 b=NPe94qbb4GAiCy+gpXum6TEBpkkyqOD6805f8U1xVaihraDPn01H4qPv
 KxLvayPXh/+9hYwyK0M7yNlVgRVj618NLlRIOHIbIxr7BWhAq1fC3r2B7
 PF3Yi2mpMpO0MCEaGomQB4sOhtCnYXgC2NvawFvnhfe6FgY4XAfoytpK2
 BrCC6Tk/8HWEm4KU2OfI+UzB9rPmIxrHhjQ07/3mSJoBXZEWh8gUurjk+
 2PjqZFIMCzTcAoWeY5ILClQWyo0l5O7XHVjPJfo4g6eybb3enSaCFk19q
 ZP+uE7SLxfn10uVZ2OafWlPoHdFG6S5vtto+ymt95yfTdtHRU/TVqW/FS Q==;
X-CSE-ConnectionGUID: 2FoR1+PEQ7iIw3SvtUlMSg==
X-CSE-MsgGUID: yPWp94nxTxC4A7XI8u5/ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88970768"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88970768"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 08:46:16 -0700
X-CSE-ConnectionGUID: VwxZuZPLSZWYtcfsxpYBzA==
X-CSE-MsgGUID: TE/cTzr5TRyLCtOzSv4V8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273909390"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 08:46:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:46:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 08:46:15 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyuUKVp2k5h6xCcS56tVS90vv9xMWyxUQ+ODrXwJNAKTquZvkE8gbRHAjODNJX3O1PU6IGOUaqA9WIVPo9bQsrFGCmMl5Q45J2p+ikG724OXAuhlhQG2kXvC1VstSsP8ffGK69x4UQd1Ctv1uMdAayExKS40c/LYUgRcqFCOmDncSTalimdgHe4Ll97UN/29JICnuK6buTw4LYTA8NWIFcMBMbhcrbjge+bUpBNtNZFEGo1Y90QQlMZROUVMR4BOIlEvrfFQ87stMGZaR7JVf5QHR6BKnOpirRBBQ9KEQb9/J/SP2mg+9TG956tzZaXtQp0XvbTyBNMn6+i+qvriSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+34gBbsW25XbClY472nwySzmoFEp3PJa3dcQGlqJy8=;
 b=OyMy4npQQF4Cw4tQCyGkEfnqbGSob9fdhaPAIuV8sNjZ3wvEvpKIDiFGC/Kr/x5tiMr5fAVWWUN8jkCHKgm6OMnOsbGz1jbnO4t53bfPOyjjfTKWO2lnXFLwmvP++rkvAbADlMl/iZT3+SFAVHNSSDtFfJx+LBBEo9s6A9v3o75LfyofH3vTHQZqSrqtyGjS0W99oOvK5VcIBDwm/bZqXO+MGh+rnYE89Tdp/k/K2Qt4q9EM43PrFYIdzkB911aSH+TCHUPb7r2sw2c4HGBTzW8zPvGhat3QvQhNXWCiWwZ0ad6bRXvDSeSf0AZ50cp4i7a6fRXr7aJRW/lD2P/sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:46:01 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:46:01 +0000
Date: Thu, 3 Sep 2026 11:45:56 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-intel-next
Message-ID: <apmWNIUJ5lmsvNzc@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 0273447c-9311-4fc6-00e0-08df09d27484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NT3sG5Z4lXsDd08G4In5BDyU5IHY+IeUleHd1w2pbw7ZDz4yFGhlj+gn2Df9g4DtnJKDmY93GhOYKa9pBT/kZnTUiSBG3uGwuadCT14Gfy79kxK2ifPt58NU8u8m2PtfII75RHobJrKcqbsQfyJLC1xcZr0avTYkKGbtMqTWTUCet68q5CAptEei+/XoLC3PQTe4MGqNfrpR8VkUVVGvrd/rAw8hSq6gLCEHgndz4npla1gZsFtzwlkdXCyoRwrH+4XVJDH+AZldtT4+13ZcPl1UJBXHGfiOllJXwzj/lYpAEAJ75nGZRcr5lHaSNiOB9uUtUqPau9qftIW/5GSVcXAldtsoyHjjuC8xSbv9tKAyxDtKgkDBvDUJWAzSWhVntZrKGjtdrljdJwYWr/klfdNHIXPIbIiOZy7mhioyXsH03TVZfALLLcfyXjdc1bCijj8NMYaIGjjNQsx0o9bMR8GDlVS2DI7BNbm05nuE098x0HlFf1KK1QMJz0kj/DkKlAOIa1/7yY/Ag276dXWmJadyQjYyCH9NdzQLrnstqTjXBSokX3VF9orP+9HFvidttKq+SwbWGHdGVq6w5cIPdshd6LH+dbqmyuMHJ7ZcMpkwqD/1GVgbCTdcmk5EQaZA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHI3Y1V5ZzNZRFd5TytkbVNPY1ZXaGZzRG55NjEyNnhzcDJ3QUhsa3pGcVVS?=
 =?utf-8?B?cmd6WmJOTzNtb1RaUnlVbStjVUlrSkpRYW54SWpseUtQREtxZ1V4VFNsRnZv?=
 =?utf-8?B?VHE1L3dCTWRxYjFEUXNNY2tQOUFhU0RpRFNrNVV3bjFYalFMMHE1TllWaFRL?=
 =?utf-8?B?Q1c4dnRPM0UxK2g0aWJ4YmNscEU5T0tIUlpxdkdvdjdYam0yY3ZMZVQrb282?=
 =?utf-8?B?N3B6TXFtY0hjY0xUUGRZZ1QyckJUN2lqWnp0eXVxbEZXbmlLWHJtTHlVNS9I?=
 =?utf-8?B?Q0ZxRW5PUlYzWWNOKzdmdzBQWHpMc1NmcnVnSkJZMXN4cXZGVlh0UEkyUEF2?=
 =?utf-8?B?OWwyU0NXMzkzY00rcGlOUVNQczRnMGF2YTBiUEN3ajBxNzE3WGxrS2ZYVk4y?=
 =?utf-8?B?REtKdTc1cHFwbE5QTkFIZXByUmg5bHkwWVZkak42M2NrREdReHJOa1UzZEhi?=
 =?utf-8?B?bTBwWklZenFtcHBnZi9DRkdlUFQxclRFS2FjdzdsekNmYkxKR1MxbG9Ublpi?=
 =?utf-8?B?c0R3bHhPWW1HVFpHSXNpM3puS25wL0c5UkY1aE1aM0w1bmc1MmZ0dklJeVpU?=
 =?utf-8?B?Q0t0TWxaTHpXSWFzWWRVbzlXZXRtK1l6ald3bUxZdUxGQmdvSktKQ1RXUmZv?=
 =?utf-8?B?OW43TGt0S0FqaE9rUkhQK2xvSStndm5uS3ppVHZNNEZOUTlOdkZFYlhKNU5G?=
 =?utf-8?B?SExpQ0oxVkhiMlVFckFrQWthcUMxVDJlSEgzTFNzZXAwNzJ3b2pUM25JK1I0?=
 =?utf-8?B?N0tWeVhCVHhrVkwvTlNxbjZ4dXlDNjlBazdDT3JuM3BKeWk3NU9IVkh3dnlT?=
 =?utf-8?B?S09GQWFUalJPeG54NVBiVlhpMmZIOEcxMDMxNlJpMnZxTVBxL0tmM0RLTktB?=
 =?utf-8?B?WVN5WXRvcDRMYnFZNGMzd3R1clI0aDBNVUpXdTd2dHhLUDByK2N6TFFNSkpn?=
 =?utf-8?B?ejdPTWxBejBHL1p2SFRnZm9Mc2dmRXlwbHhmVUF1cEJyWnZsVmtjOE1KOFBl?=
 =?utf-8?B?UENUODVIQjFWblc5ZEJtZE91cVFBZ0ovOFNwNy8wc3I3aUlRUjB6Vy8xdFlr?=
 =?utf-8?B?ZURaZ2RkbFlpeVFaS1FlWlhhYzNHUElCREF5bktnZkNNb2x4dUQ5Y2wvZ0lB?=
 =?utf-8?B?dlZvSmNnSmhoM25rM04wSHI2Y2RNdFNaTnJVaGpHSzM4RTVLa2RHMVRBUFMx?=
 =?utf-8?B?N2JRNFlPR2NlU3Bma1NCYUpEYlNRV0FhSWJGYyt2Myt4VGNBMDdSMk84Tktl?=
 =?utf-8?B?T0pXMXkvWEpNY1BYQ2RyNHVrNnVOSVM0SjNYczNkK2d3b244NVphY1FJWWtr?=
 =?utf-8?B?eVM1Q05TdUhCaE9Ya0lXOXpVQitQMW1QNHl0SmV0N01nbWFzVC93dGNOTDRx?=
 =?utf-8?B?Q21DS2d4bjhIcU1JQ3djUmxOTERqL1lDUHJMUEJKSWhDRGU4b28rWEZEMVgy?=
 =?utf-8?B?UFU5dVRJL3dndkRpaDFtTDhQRkdrREJCd0twMTRIZW1kM2VZZXVweXZUbGhS?=
 =?utf-8?B?bXB6L0xIb3l6VUtxQ0FZMDQzNFkxZnV2WWNHd2R5NEd2bldHcUFsL1R6UlI1?=
 =?utf-8?B?cEhKVW9ScmxMNlc3cEdjZHVHMUkxU3lMdFhCcFNNelpkUHpCd204NkpTS0Zu?=
 =?utf-8?B?cTUySWtWMFZIcjczc3R5NW1Da1lkS1BpanVPZFJqVlNiRkE3ejFYMFgyWHh2?=
 =?utf-8?B?LzhSWkhrbVdSYnBadU8ydWlDanZjeE1nZ2UyVDIwZC93eDJmQmtFL3VPMUZy?=
 =?utf-8?B?Y3RoaHhDdE5oeXlySXIwdXpybk9rNWtiNkc0TmRZM0ZSdmhCQjZ4UkhWTEVZ?=
 =?utf-8?B?NS9tUE45UnpxUEdUcEpoYUhKYVVZd1FkR3hPNHh2R05DNWpQenhhQmFUa3dl?=
 =?utf-8?B?QmVQM2RrQm8vQnJTbXhYTURNUDRpUllZMTZHd0ZkcWpKZTlJZ3pzN0lKM3U3?=
 =?utf-8?B?SGhLcE9nZ0RQcTMvSGJBZWp5VFVtWnBPNzFaZEQvangxZDhmS2tObnlFaVpw?=
 =?utf-8?B?YURuWnNPVGQ4L242SG5Oa0pCMC9meTRvdHJLSVFwVDhScUIxbmRSSEtOSFd5?=
 =?utf-8?B?Ymg3NjdhVXFza2lPRWdqTzU3SjN4cHlvTTlxcVJwNEcybWp6RFpWMzM0RDkr?=
 =?utf-8?B?NWo3UG9vcmlkMnlNQk1XOFNZWmJvVVd4dzFGUGtOL0dVbHI0SUxvWWU0V1ZX?=
 =?utf-8?B?Vis0WWROakZFdEdRRm81ZnQxQ3Q0ekwxQi9odkNVamhqV1lPcU8vRUZVNWty?=
 =?utf-8?B?MnJwV0NFcTdadU9zTVIwbjh3dTcvRXlHK2JWQTNjNzZGMHFhTXNEejlvb3Vr?=
 =?utf-8?B?eiticlNtSTZvSGhlMm1sZjJ4cys4eTlyekVaL1IzWHZZdS95QnVFQT09?=
X-Exchange-RoutingPolicyChecked: vuzDqY1au10AL8iUeiwLnjkGTyTsw84qHe3MWl0770GbmgyRMIVu1KA8fzGKtXnIVxhueiPq3/XojOdYOgY+QimN6AwdkhyPTNodMSI62Su8P+svOsXyp9cfTKYpitFnog69ogSYeqMnv1ndq+/QI8/0tqbAcE+3EobwocO+T44M9htHXqgkE5kP85/z0Tml+TiVt2/DlbJuc3kJVzowB+yP2ruc/MWQoNMpWWKRKjiwMrpnwQDLVv7HGrt6urxCy01Wr9+u6EkW5uTKrNBxJFO8Hp/56OMzjh1HOjopr5XwTYxhetx3YnuyYxnoQoRNNc7SJaJOsrAnsYx4TC5wlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0273447c-9311-4fc6-00e0-08df09d27484
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 15:46:01.6128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HR0IbZeJw10Nd2GUJ4No5Lllo2qUHuzJ5wVxcXEKEdha0KQKa1jcOWC6meS6HWKPJCppZwJ6o4gV64Fc1z2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
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

Hi Dave and Sima,

Here goes our first drm-intel PR towards 7.4.

Thanks,
Rodrigo.

drm-intel-next-2026-09-03:
Xe related:
 - Some clean-ups around drm/xe/display (Jani)

Display in general:
 - Regular clean-ups (Jani)
 - Enable CMRR (Content Match Refresh Rate) in fixed-RR VRR path (Mitul)
 - Switch DG2 Multi-protocol PLL (MPLLB) to the DPLL framework (Mika)
 - DP-HDMI PCON DSC fixes (Ankit)
 - Remove duplicated call introduced by a bad cherry-pick (Chaitanya)
 - Limit invalid joiner combinations harder (Jani)
 - Fix value being written to DDI_CLK_VALFREQ (Suraj)
 - Harden some bit-shifting operations (Luca)
 - Clear SEL_FETCH_PLANE_CTL on plane disable (Nemesa)
 - Update CURSOR_BUF/WM masks (Suraj)
 - CDCLK related fixes and refactor specially around PCODE interaction (Ville)
 - Reduce clock_gating interface between core and display (Luca)
 - Gate UHBR SST SDP splitting on sink capability (Mitul)
 - Enable joiner cursor fast updates (Nemesa)
 - Cear the Panel Replay error status register (Jake)
 - Add HDMI TMDS audio bandwidth check (Chaitanya)
 - Reset use_flipq when duplicating crtc state (Mika)

Beyond display:
 - Guard against NULL driver_data (Deepanshu)
 - Rename GEN6_PCODE_DATA to match spec (Michal)
The following changes since commit f0cabcc880aba3f05ca59d735f6d166b7fceca80:

  drm/i915/fbc: No surface size restrictions from LNL onwards (2026-07-24 11:48:36 +0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-next-2026-09-03

for you to fetch changes up to 0d63d6fc993b1fb97e314f435bdefbf0ccd947bd:

  drm/i915/display: Reset use_flipq when duplicating crtc state (2026-09-03 10:17:54 +0300)

----------------------------------------------------------------
Xe related:
 - Some clean-ups around drm/xe/display (Jani)

Display in general:
 - Regular clean-ups (Jani)
 - Enable CMRR (Content Match Refresh Rate) in fixed-RR VRR path (Mitul)
 - Switch DG2 Multi-protocol PLL (MPLLB) to the DPLL framework (Mika)
 - DP-HDMI PCON DSC fixes (Ankit)
 - Remove duplicated call introduced by a bad cherry-pick (Chaitanya)
 - Limit invalid joiner combinations harder (Jani)
 - Fix value being written to DDI_CLK_VALFREQ (Suraj)
 - Harden some bit-shifting operations (Luca)
 - Clear SEL_FETCH_PLANE_CTL on plane disable (Nemesa)
 - Update CURSOR_BUF/WM masks (Suraj)
 - CDCLK related fixes and refactor specially around PCODE interaction (Ville)
 - Reduce clock_gating interface between core and display (Luca)
 - Gate UHBR SST SDP splitting on sink capability (Mitul)
 - Enable joiner cursor fast updates (Nemesa)
 - Cear the Panel Replay error status register (Jake)
 - Add HDMI TMDS audio bandwidth check (Chaitanya)
 - Reset use_flipq when duplicating crtc state (Mika)

Beyond display:
 - Guard against NULL driver_data (Deepanshu)
 - Rename GEN6_PCODE_DATA to match spec (Michal)

----------------------------------------------------------------
Ankit Nautiyal (5):
      drm/i915/hdmi: Use correct type for output_format parameter
      drm/i915/display: Generalize intel_hdmi_dsc_get_num_slices helper
      drm/i915/{dp,hdmi}: Pass bpc in intel_hdmi_dsc_get_bpp
      drm/i915/hdmi: Add helper to get max FRL rate for an HDMI sink
      drm/i915/dp: Use helpers for getting max FRL rate

Chaitanya Kumar Borah (3):
      drm/i915/dp_mst: Remove duplicate intel_pfit_compute_config() call
      drm/i915/hdmi: Move audio compute config after format selection
      drm/i915/audio: Prune ELD SADs based on HDMI audio bandwidth

Deepanshu Kartikey (1):
      drm/i915: Guard against NULL driver_data in i915_pci_probe()

Jake Steinman (1):
      drm/i915/psr: clear the Panel Replay error status register

Jani Nikula (11):
      drm/xe/display: remove unnecessary includes
      drm/i915/dpt: remove unused include
      drm/{i915,xe}/display: move transient data flush call to display parent interface
      drm/xe/display: drop redundant intel_hpd_poll_fini() call
      drm/xe/display: drop redundant intel_hdcp_component_fini() call
      drm/xe/display: drop redundant intel_audio_deinit() call
      drm/{i915,xe}/display: add core workaround query to display parent interface
      drm/i915/display: Limit max joined dotclock on joiner pipes available
      drm/i915/dp: Limit for_each_joiner_candidate() on joiner pipes available
      drm/i915/dp: Limit compute config joining to pipes that can actually join
      drm/i915/debugfs: Reject invalid force_joined_pipes harder

Luca Coelho (7):
      drm/i915/display: harden masks in HSW_AUD_PIN_ELD_CP_VLD macros
      drm/i915/display: harden shifts in ICL_DPCLKA_CFGCR0_DDI_CLK_SEL macros
      drm/i915/display: harden shift in intel_ddi_compute_config_late()
      drm/i915/display: remove unnecessary PHY_NONE definition
      drm/i915/display: consolidate Gen9 clock gating initialization
      drm/i915/display: consolidate remaining clock gating initialization
      drm/i915/display: remove unnecessary clock_gating include from intel_display.c

Michał Grzelak (1):
      drm/i915/pcode: rename GEN6_PCODE_DATA to match spec

Mika Kahola (5):
      drm/i915/display: Split out DG2 MPLLB enable helper
      drm/i915/display: Add DG2 MPLLB DPLL manager support
      drm/i915/display: Prepare DG2 DDI and compute paths for DPLL framework
      drm/i915/display: Switch DG2 to use DPLL framework
      drm/i915/display: Reset use_flipq when duplicating crtc state

Mitul Golani (11):
      drm/i915/psr: Do not enable PSR2 when CMRR is enabled
      drm/i915/vrr: Restrict CMRR enable condition to VRR-TG-default platforms
      drm/i915/vrr: Add per-CRTC vrr/cmrr debugfs control
      drm/i915/vrr: Update AS_SDP target_rr_divider based on CMRR config request
      drm/i915/display: Move CMRR crtc_state members under VRR
      drm/i915/vrr: Compute CMRR fractional timings generically
      drm/i915/vrr: Latch CMRR ratio via atomic commit on debugfs write
      drm/i915/vrr: Program CMRR enable/disable from transcoder timings
      drm/i915/vrr: Dump CMRR state in the crtc state dump
      drm/i915/vrr: Enable CMRR
      drm/i915/dp: Gate UHBR SST SDP splitting on sink capability

Nemesa Garg (6):
      drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable
      drm/i915/cursor: Check joiner cursor commit status
      drm/i915/cursor: Add helper to update cursor plane
      drm/i915/cursor: Handle secondary cursor state
      drm/i915/cursor: Program secondary cursor planes
      drm/i915/cursor: Allow joiner cursor fast path update

Suraj Kandpal (4):
      drm/i915/ddi: add helper to compute DDI clock frequency
      drm/i915/cx0: program DDI_CLK_VALFREQ with DDI clock frequency
      drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency
      drm/i915/xe3p_lpd: Update CURSOR_BUF/WM masks

Ville Syrjälä (17):
      drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
      drm/i915/cdclk: Introduce has_cd2x_pipe_select()
      drm/i915/cdclk: Fix dg2_power_well_count() return type
      drm/i915/cdclk: Don't bail if pcode post nofify fails
      drm/i915/cdclk: Pass CDCLK in MHz to pcode on DG2
      drm/i915/cdclk: Do the DG2 CDCLK/pipe power well notify properly
      drm/i915/cdclk: Notify DG2 pcode about pipe power wells regardless of CDCLK
      drm/i915/cdclk: Stop forcing voltage level to 3 all the time on DG2
      drm/i915/cdclk: Drop pointless platform check from bxt_set_cdclk()
      drm/i915/cdclk: s/intel_/dg2_/ for DG2 specific stuff
      drm/i915/cdclk: Unify the pcode pre/post notify in bxt_set_cdclk()
      drm/i915/cdclk: Unify pcode related debugs
      drm/i915/cdclk: Extract bdw_cdclk_pcode_{pre,post}_notify()
      drm/i915/cdclk: Extract skl_cdclk_pcode_{pre,post}_notify()
      drm/i915/cdclk: Extract bxt_cdclk_pcode_{pre,post}_notify()
      drm/i915/cdclk: Introduce CDCLK .{pre,post}_notify() vfuncs
      drm/i915/cdclk: Hoist intel_cdclk_{pre,post}_notify() calls upwards

 drivers/gpu/drm/i915/display/intel_atomic.c        |   1 +
 drivers/gpu/drm/i915/display/intel_audio.c         | 153 ++++++++
 drivers/gpu/drm/i915/display/intel_audio_regs.h    |  16 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         | 334 +++++++++--------
 drivers/gpu/drm/i915/display/intel_cmtg.c          |   2 +-
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |   3 +
 drivers/gpu/drm/i915/display/intel_cursor.c        | 311 ++++++++++++----
 drivers/gpu/drm/i915/display/intel_cursor_regs.h   |   8 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |   5 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  47 ++-
 drivers/gpu/drm/i915/display/intel_ddi.h           |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |  76 +++-
 drivers/gpu/drm/i915/display/intel_display.h       |   3 +-
 .../drm/i915/display/intel_display_clock_gating.c  |  67 +++-
 .../drm/i915/display/intel_display_clock_gating.h  |  16 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |  21 +-
 .../drm/i915/display/intel_display_power_well.c    |   6 +-
 drivers/gpu/drm/i915/display/intel_display_regs.h  |  18 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |  19 +-
 drivers/gpu/drm/i915/display/intel_display_wa.c    |   4 +-
 drivers/gpu/drm/i915/display/intel_display_wa.h    |   9 -
 drivers/gpu/drm/i915/display/intel_dp.c            |  96 +++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   8 +-
 drivers/gpu/drm/i915/display/intel_dpll.c          |  22 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      | 221 +++++++++++-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |  22 ++
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |   3 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  53 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |  11 +-
 drivers/gpu/drm/i915/display/intel_hti.c           |   3 -
 drivers/gpu/drm/i915/display/intel_lt_phy.c        |   6 +-
 .../gpu/drm/i915/display/intel_modeset_verify.c    |   1 -
 drivers/gpu/drm/i915/display/intel_parent.c        |  10 +-
 drivers/gpu/drm/i915/display/intel_parent.h        |   3 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  18 +-
 drivers/gpu/drm/i915/display/intel_snps_phy.c      |  60 +---
 drivers/gpu/drm/i915/display/intel_snps_phy.h      |   2 +
 drivers/gpu/drm/i915/display/intel_tdf.h           |  25 --
 drivers/gpu/drm/i915/display/intel_vrr.c           | 395 ++++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_vrr.h           |   2 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  15 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   2 +-
 drivers/gpu/drm/i915/i915_dpt.c                    |   1 -
 drivers/gpu/drm/i915/i915_pci.c                    |   3 +
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +-
 drivers/gpu/drm/i915/intel_clock_gating.c          |  30 +-
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c        |   2 +-
 drivers/gpu/drm/i915/intel_pcode.c                 |  14 +-
 drivers/gpu/drm/i915/intel_pcode.h                 |   2 +-
 drivers/gpu/drm/xe/Makefile                        |   3 +-
 drivers/gpu/drm/xe/display/xe_display.c            |  22 +-
 drivers/gpu/drm/xe/display/xe_display_rpm.c        |   2 -
 drivers/gpu/drm/xe/display/xe_display_wa.c         |  13 +-
 drivers/gpu/drm/xe/display/xe_display_wa.h         |   9 +
 drivers/gpu/drm/xe/display/xe_tdf.c                |  15 -
 include/drm/intel/display_parent_interface.h       |  15 +-
 56 files changed, 1591 insertions(+), 640 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/display/intel_tdf.h
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_wa.h
 delete mode 100644 drivers/gpu/drm/xe/display/xe_tdf.c
