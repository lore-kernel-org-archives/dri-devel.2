Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CCAC9831C
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE69A10F4A3;
	Thu, 24 Sep 2026 12:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cK3R2p4U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A61E10F49B;
 Thu, 24 Sep 2026 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251381; x=1821787381;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=cmQm1rxXD8Y/k94u6uus2ea+4UCA0rmHyYzrl4kL5SQ=;
 b=cK3R2p4UFJ0zPBL+ofkerxLqevsEtz13MlH2Lk9w+eTV9VIAeSQCWddO
 dyX5iLGzS74JSmY2wxCLyfBJwXn4VJn9roXKnbkpvezKTsLB8b5NPhwQd
 RIZbA/hlg1mHRmhdaI/W+RzfSs+z/hTdxzTH5B30qVHhUfgs+yVnd0a+1
 gpzqVt1VmblPRef1OYKIgQlGFjXgLTMOGiCmONsbW02vhG2TaWosM+Z7Y
 wAKfrc9/9IvrkvXDM4SZ+jy1WPZYXrIYBXqKqobfiQI2JyW0HdWiJYG8W
 hpI853l+If95qtKpHqDbg7O5KvO49U1V6ihdBrHS2W8WOcxqgBtAa7t5H g==;
X-CSE-ConnectionGUID: xeWPKSLkSxuX6670KEDvdw==
X-CSE-MsgGUID: v0D8CkLOSoyedFDcQrx33A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="94838181"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="94838181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:03:01 -0700
X-CSE-ConnectionGUID: HqduXYjuRuaCrDHihiNTyQ==
X-CSE-MsgGUID: MAc48xbARTKurauYcCDIjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="300272295"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:03:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:03:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:03:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=powE9a7OzW8ws6FfSE+FdUXpvwXiS/x/PtD/txIJaqD2PYCW6Vbfb14lEGdVETnJvb6f+ZzwcNmIriu33oEKULAZ2FR8j8jTPvCV20oYB5rKsSDILJCCF+D2e6t1Pqxp1mPNZz+AFR/URS1ZU/qpOObSkR46Ddt+Q5kB8mfNR5ekYfawenBfaBM24wKECskZ2sx9/YzXMD6DxNhN0yoUvV0pyvOCRGSfpbfRP0ZxJ94E5gHqu3rtqv53RavvAPVCTRJfjbbxNFpvO1MfTD9tF6Dn7e8jytueOiGmtetsMwh34I2q+tllktm3LuUjF0qwxrHZISmPe3O7Fm0NHu9qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz7ft7StO/UiPnVHE78RVP3pCJ2Ti7nI4yEwmc0EUuk=;
 b=FKobxv1nK7kS2IVvw4C1x5Qlhgf/y4JnSwdbnWvRaQrdR/GnZdiZNoFbI3+vCwDC+4M7B7UiaB+mpM9XS25aQXK8fnR0KTf+bQwtr9PeqajdAA3sGsNGFet+hlmy17pj+fhhQOOWO0uyzsjdp56O17HVNngKEiCH+Wa9FXMKeNA2OamweqgaRHBg8QDm0qBs6SHlNUV7XLAVsgz/gN0zx/WWon+f53TaB9ViagP+zlr2C0mIlKMwgN9HlMQjGds9qMEWvn7KHZdHjlK+QVyFAwidNcRcZXthkU6lkIkMOlXCij83jjnyV2FgNlr5ceCoIfLyIxC3NNV/V8waPQDz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:02:48 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:02:48 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 6/7] drm/i915/gt/selftests: Use gt_* prints in gt selftest
 helpers
Date: Thu, 24 Sep 2026 12:01:46 +0000
Message-ID: <20260924120147.1305127-7-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924120147.1305127-1-krzysztof.karas@intel.com>
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: d569957a-447b-4051-9358-08df1a33bf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eIU++XcCUzk9S1ox8PiQVY4p17azyA792i2p8RliUwOyXxKxEHW/BdJ17i1JEo/oq5tG+XhsTX1i1asywWnXCFVO1g6O8IhjQ284f9utAp+EYES5kp05EkcMBufohJmtGrAp1xZ+oIAvkJ0Q1VfHGBZNuLYUnBffMidUPDp+iW84X0JJGSEZLyKH0fzfQ6hctamBzZNk5IKxQHFQFFZ4A1I+/JRd0MRDg2LriwTAc5TboEygbGwzfmZS1iPCsnI+Dxk6hS37vOlLSjCLtUESU5cUqriOfK0rkPq7hEM3+na0hsbdKkPvtXM340in+F1bDaoYoPaHqPUDpD9B2DT/XeMhR+qR96BCSnOB7C0fA34/fraxvgwjaoROAbe7lGggXknmS+62OMpjPDAqeMKLMOvDZfKwCeV3fe+oziU1TzCInGsvmHTeXyyJh/ZUk3MBEJ3SGi7l7tcHzES4R+8gIN0WzJIMeZcGfogzx3U+J1M1JsqWM033WVOmZg57yoBamAviz5C0Q7y3+asHitL3xhE5nkzx9Qq2D+JlRSTBnCN2xCUoqusdk0EJv6wynplxt1aEavZyIDky9ryYGc95tMVs4Nz/ARC/aueMryfHqH8XpkLHFwXhT4+IRPWsIlQztX2DY+qyoCiiwhfV1r6wKTr2XiQLNu3dLikl9DmuHQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmJlbXM2UVZuRnF2dStmSHpSYTcveDRWMGRwOVA3djFjeTZpQXVaVkNUdnBp?=
 =?utf-8?B?OXdaNXJJMHFIbWZqYkhCenpWTmVPRE5JZWo2ajFQS05rb3NHQ3RZSDFEZFhS?=
 =?utf-8?B?S3laaUpzNjlMT2xhSkg5K0ZGSEpmbUE0OU9aanNMUkhZVGM0NUliV1hZeFgv?=
 =?utf-8?B?a3ZLeG1XenhjRXlqTytON3lEcnRVNElmaWpFYXdrZVJYeENIdVJ6bjhMRmps?=
 =?utf-8?B?aVM0eW11VE0wU0NKb0pndkVxVkhHS01HQU1aUCtTWEpXcWFFZ1IzTkw4M01m?=
 =?utf-8?B?c2xOSUd6TkhQUk80VUVEdXphaVV3YkpVam50WGZaMEtibXBDaGE4WUk1ZGlQ?=
 =?utf-8?B?OW44QkZmbjVvdmlqei8wWjVpZEowMlRXYVVJaHBwbkx2SDMyL3RadnRCOUk0?=
 =?utf-8?B?TEkyOG1EN1FSUndCc0gySEI1cGNrY2gvUEVYNFNUdUJPTVBOVlU4MDRMbWdM?=
 =?utf-8?B?NWRUeFBNd0RBQmxQTnNKMEYvQVhHNUIzOTFmT3ZldVJDaVE4V0VyT3FJZ3ZW?=
 =?utf-8?B?bXNEejA4bzI1ODVmQmt5ckZEaWkvR3cxK2RkLzc4bjZ6NjFyZC9IN0JGYktj?=
 =?utf-8?B?dXBWK2Q4d281UHhkZ3Qrd083ZHBUbUJrZlB5eFdRVVBBOWxLWTMvMWJIaUMz?=
 =?utf-8?B?YzNWWEQ1TjFZZVJrbWYzc0wzczh4TmtyU0JlR1pOT3ZNZjExUW1RRnpjS3Ro?=
 =?utf-8?B?anl2NEc4M2drS0dEUkVWTFA0QVRVT0FtU0RGY1FwS1Fsazd4Ni9vVE1FU2kr?=
 =?utf-8?B?M2daY0FvQUM4R056SUpJOFdOU1ZJRlBhZ1FYOEVOeC9QUXdkcHdnUUk3Rjdm?=
 =?utf-8?B?Zmgyd1VsbDluUkZtZ2xpYkFveVJDS0RvSnUzOVlDRzF1bVpSVkZscjVoQjhh?=
 =?utf-8?B?L2pLOWV1VnZFSU82ZXBuaEwwTmNCVFUyYWorSDZKRFpKT1N2UkozWmNOeG9k?=
 =?utf-8?B?OGRHczYzTVBhODNXZGtyNm4wSHhoSGFhd1RuekdSNmdDQ0FJT3lNRnBuMHpH?=
 =?utf-8?B?RFpCRzhsSFpDMmhTRU5ocVhtV3lib1VTYXRqS01KeGpMWnZtMmx3b0RyMGs0?=
 =?utf-8?B?dklBVkNYUEhPdVRhNU9IMFd4N09WMGFoTDNLTWV3Skh1aHFFY1A5UEVUUFhF?=
 =?utf-8?B?Ykc5QmVCRFRhcmd0cXlrRGhWaitFRmF2WTBsTVZxdXlnSmgwakVkU3FXMnRr?=
 =?utf-8?B?Z1JMZGhIOXU0Z0RPY003Rm5rZndCQ3NsOHNid3BqZ20vYyttVEIzd2tnQ3Nu?=
 =?utf-8?B?dy9Scy9CRXV1MGprdnJQWURMYVBOMm43di9keWhKbS9xK0JheEJLcHFYQjV5?=
 =?utf-8?B?OVZUTmdVWGtQdEdnNVRTMmltZGVYcGZ3UmQweUh3UjI5blZSOUxLNTBzQVk3?=
 =?utf-8?B?UFJpT0JFNk5pYjZkTlV6WTduQ3lZTTFsMzJyaW1aRWU3MURmY0VKaGJ1ZTVk?=
 =?utf-8?B?K0dHMGVRZGtHdFVpb1RQTmdUSHJPRnhTVnhrVmlRamV1WTVLOEZGbDlBQzFj?=
 =?utf-8?B?OHZYUDVMMHFWSjBYWVZLSE50NjVQVWZncVM1TkVjUXhiazB3UCtNWUJuT21W?=
 =?utf-8?B?UFNwMG90NDhuOGY1VnlWVjZMUnRyeklqT0Y4S3oyMzVmQmMyWTRPVFdyWVVx?=
 =?utf-8?B?ZEw0N0N5K0lHSFh1czl2OGpsNnFmdjIwNmV3T2VOVmZ0K1Q5YW83ZDdKQjJI?=
 =?utf-8?B?dHRUZzRORGVJVVF1dzZxaDJxd2xmaWJhbmtZanp5amZFbjVoZXJVcXZxaCt3?=
 =?utf-8?B?VFVSQ3k4dytmMTUwVW9WV2l4Z0N2VXBuRUtXR2Rja2YvMmxGUmUwVW9CNDRa?=
 =?utf-8?B?Z0xhaFBIeWpZaGt0cEFOd2txWWFNNmM2ZTdBQytUa2wrd0Rzb1RkQ1krMWEv?=
 =?utf-8?B?cC9CelZFZVF3MjdYbVhXSWRNVkdYN0ZSRUxrdTl0clVYNmNRM1p1R2o3TTZM?=
 =?utf-8?B?ZXE4YTMwS1EycWdIK3hZU3piYTJsa0RTZnFYdGRhZnVtVEtCeFRlVDI0TmRB?=
 =?utf-8?B?UCtNOXcra1VFRjk4RjcvWjJWbmRETUlUOExWajFPTDNvTDFuUkFpVDJxVjZ0?=
 =?utf-8?B?RTQxQjU2TkxpamVDbkNHSUdZVHhqYStCRVFxbWxLclowaEliMklDZjZIVTNZ?=
 =?utf-8?B?V0JWakZPdzhuVjMrMG10c2Y5Rk5QdTZLSXdKTTVDTVh5RFVOTFBGUkVnZ09Z?=
 =?utf-8?B?azBSYUJuVnNoUllNRXExM1lTZGRXaHl2SzVwNEVvRmR2RWFPanR0L3F3cmhk?=
 =?utf-8?B?Y01DZC9NbUlTbE9admNORENjcVNTMUZseDhkdEJ4U2VZWVJ6QjZheVFXeFVt?=
 =?utf-8?B?KzMyVVB6SitWN2dJRFIwZDNjWlVtekNZaloreS9vNkR3bTZ1UGMra204RzFT?=
 =?utf-8?Q?qXv3a7QaLcyupr+w=3D?=
X-Exchange-RoutingPolicyChecked: 3X7wCs9dB0qVQzB1zR7I4bn5VvPE8G3LXp7tf6oloNJ3VrLvC7XcRTSRpOe9n/msiEbXXCnwCRv4OBBF9Lvz66tcjFu+E1h/BoamD2xYFPZ7cSHMFDz6WE/Y2P8AbytlB1ABW+6AYAL5DO1TtouFJyKmYBBUjrdXFg/4kICc6/oMkX8lPw83yZ0luqSF8XoVHc9tyWNXsNcRROild8RDBr+SyEUbdTTrql8SCAzAGjXEamPMHeywb+RxlrfzJRxl+bkAtD7YYHPHSNXP2wBQ/3W3Y/M7Xj77l5Eh0b2pPgQqZH0d9h/4ZCfrzo5J6P8Quq/uRUVC0rkzRLGQcS95ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: d569957a-447b-4051-9358-08df1a33bf81
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:02:46.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u35hCdPvvhT/1S+sJnMjvNAAv+iahRitSL5YJRUOgwrgDrBx2yjBnR+IqRJIXcqpVRvzp+aXui6c9Niub5bGgZV+1nEoZKrx7yni9qW8cI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
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

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with device and the tile it came from.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
- drop a stray blank line in selftest_llc.c (Andi Shyti);
- fix include ordering nit (Krzysztof Niemiec);

 .../drm/i915/gt/selftest_engine_heartbeat.c   |  7 +++---
 drivers/gpu/drm/i915/gt/selftest_llc.c        | 25 ++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index b893a8fde895..1164dd4aea11 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -7,6 +7,7 @@
 
 #include "i915_drv.h"
 
+#include "intel_gt_print.h"
 #include "intel_gt_requests.h"
 #include "i915_selftest.h"
 #include "selftest_engine_heartbeat.h"
@@ -202,7 +203,7 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (!delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat not running\n",
+		gt_err(engine->gt, "%s: heartbeat not running\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_pm;
@@ -215,14 +216,14 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat still running\n",
+		gt_err(engine->gt, "%s: heartbeat still running\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_beat;
 	}
 
 	if (READ_ONCE(engine->heartbeat.systole)) {
-		pr_err("%s: heartbeat still allocated\n",
+		gt_err(engine->gt, "%s: heartbeat still allocated\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_beat;
diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
index 779fadcec7c4..71ea688be154 100644
--- a/drivers/gpu/drm/i915/gt/selftest_llc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_llc.c
@@ -3,6 +3,7 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include "intel_gt_print.h"
 #include "selftest_llc.h"
 #include "intel_rps.h"
 
@@ -22,8 +23,8 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 	for (gpu_freq = consts.min_gpu_freq;
 	     gpu_freq <= consts.max_gpu_freq;
 	     gpu_freq++) {
+		u32 scaler = GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1;
 		struct intel_rps *rps = &llc_to_gt(llc)->rps;
-
 		unsigned int ia_freq, ring_freq, found;
 		u32 val;
 
@@ -32,17 +33,21 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 		val = gpu_freq;
 		if (snb_pcode_read(llc_to_gt(llc)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 				   &val, NULL)) {
-			pr_err("Failed to read freq table[%d], range [%d, %d]\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq);
+			gt_err(llc_to_gt(llc),
+			       "Failed to read freq table[%d], range [%d, %d]\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq);
 			err = -ENXIO;
 			break;
 		}
 
 		found = (val >> 0) & 0xff;
 		if (found != ia_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
+			gt_err(llc_to_gt(llc),
+			       "Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq,
+			       intel_gpu_freq(rps, gpu_freq * scaler),
 			       found, ia_freq);
 			err = -EINVAL;
 			break;
@@ -50,9 +55,11 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 
 		found = (val >> 8) & 0xff;
 		if (found != ring_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
+			gt_err(llc_to_gt(llc),
+			       "Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq,
+			       intel_gpu_freq(rps, gpu_freq * scaler),
 			       found, ring_freq);
 			err = -EINVAL;
 			break;
-- 
2.34.1

