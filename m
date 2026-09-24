Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84885C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D7410F49D;
	Thu, 24 Sep 2026 12:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kqq9SLNy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6A410F4B0;
 Thu, 24 Sep 2026 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251385; x=1821787385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=dX4FIoI1KaQ81Cop/oUv33DWzONsjBfqA8F6gD9c854=;
 b=kqq9SLNyikUc2+q761vraiPbZZ+t0ZPBmlDQ0N8adxuLPzNFxaVtuaFY
 E5qtQFFKNKTZj4PfE01YgFaUXvCsyj5econRtiSyVvB553gkYtRax2pPs
 K3Zo6alKnJHa5dFj2DLSgjn7O8qqjSB1E3eKLNDXVs+dVZI9tszwG0ULa
 9qTAfLkDW3ePc1OIHYzQ+7E4/FgPZZ6nXy+TpNGMehLHpEElHGiqUk1WC
 ALpuVeT+iXnUIF/0BZmW7p/+WAP3fUJB0bsF8BOv+evFVL0JDygkw1G56
 yv53PHtNyzqHKfQdBp1SYv0cjtAOs2XOitgyOgSZcCi3qbgs6l/7fSHoT Q==;
X-CSE-ConnectionGUID: 9r2sGDINSnW7Rn8t7i2ugw==
X-CSE-MsgGUID: B15XLkDZS/26nadviQ/mrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91123400"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="91123400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:50 -0700
X-CSE-ConnectionGUID: xsmrgoHDQVG9ne6DrHPRVQ==
X-CSE-MsgGUID: 0YkuetEwQmuPLLP+eXkOwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="270492633"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:02:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbbs0FE0jb0z7i6JsYJEY4JP8wL0Rv+SDIJj5OlJ5BZeVvDD5FBs9QPY9ATghAol7Y1o1pSCKzwSrGJZa90AWIbmMovMFEIqpU1gR8fdiFkc0a8Svy1J0gU4333rSXFECbEkGZH9376tpS4FXkcH4A480sewku0vhX6UHpyz+/PZmPRCRNowM+tQtXPoSsKfqIGvwmcvtO6RAY3F8XqkL8+0pjabUmQtGwMP22U+G5AXkZvPb2uRN1RLM2F3McvIEsMeO0X0qinfR1+cfZ2RK9BS/kA3Nwc5+2MLWz41aviLP+BWF4+o3Om4VpR2zy0QrfrYrj/YXI0A6n7doLBZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYHXLY9PgIah6HUjbFqlS1m8y8EZP2TwJtfuM23/M1E=;
 b=fd0CuqqqvFXIgKjJKPM2i5KPONkusBXkj1ugsNp8iBq9G29ufjFbEg5fZ8iP/6VXfrHPXk/zX01xrKex5yK/T6/lTeZgAPoqGbnYxd6jZHW7OxxlmqUar/XohrIRFQONORxohIcp68PldGIr+QKWDC4B3vfIJ5d2E9eLTmk6zTfFzcwhI6Qv8xElQK8pmoqxQDFukcOBGmuHWjOAAxfg0oUNsBUtx6Rhb98L3n3IyPO2TTqDDqdkvFRKaSwv2lvpatacU2ph5ZJX6E4WIxkL9A9lDBKbwxwGmGRKFkGB1RAPHrF3wlDhq1MEySJV3G7obZ0lq6S1r44zuxikO/v+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:02:31 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:02:31 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v4 2/7] drm/i915: Add i915_* printer macros
Date: Thu, 24 Sep 2026 12:01:42 +0000
Message-ID: <20260924120147.1305127-3-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbfe945a-f0d9-415e-bc27-08df1a33b659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8OKgf8XjBdg3l6qd+InNNV4cp5g8tNQNS9crkQPegRFnBkKuqozarWw2VQURAqxlPrqapeD/TbhJkBtFS4BhaqJY4nKyX4EaqDOFeOmIZWqXILJfU4yvlLkTfuJHbqyiztqadnO/WL3GGswWbBCdWvXXzLlW8PTG6IJe9sRvXMlN8lQQeSas0Pe+lJ1gDSFHHgzDvakKQ03K8OlMtOMQsWgmhs7GZ1P3W/BwGd3gKzmpPpxBIoQOhYRNwBH9F6zKJvwK+n7NSmDVM7bSMvS0VZXhzoMsNU87Me4PPwXQbe1UmFCJjg98TrSjEyMcyiTf/v56hH0GCs7XSRIAQpBO0ULUYSKdbTxVzVBCrATMG3rBAf4mJTLVMg02hVjK1KxSMX3sN6KAOB9rBHCsloazUqoBcBBmiE0jiOrRt/jwjiWzqG5UcHZ9ayOBn1jpc4dAwuwVyTfRfhDf+R/3UWXHgko2Iqa0pJXNXDGSIk8c/pIHjK0AAMbFOaEyB2T+H7Q7Os8c5sRdNK56kHeZ1I4aQ8IA3CB6vPI7AnE6zstODgonmstwaCvF8ga30RRJxzJInMhkKUmFEsF/lFfGVOGNw1wcYyKXTA30hd9zmuIMIoSxB+9Qp5NJjcni4t5yQ3IpPyMBE+mT/bMEid7+rGvwMQifYIy537AjSfpL408hOHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm1jb2kwUTVtM2RyNDlxWiswaEZtdkc4UUVJZC9KZTdpMSs3OTVNZ1R1RGpu?=
 =?utf-8?B?R29ZZ0JkRzZyWnVBMU1IcVExL1JkNzJjNXAySHIrTGdjTzh5QVUzbUJhd2xU?=
 =?utf-8?B?RG9ueDR4d0ZzZzI1bTVPNXJvTm1IaWZKcDB0S1JMUWlnZ0RyQ3M0UVNUTWhK?=
 =?utf-8?B?T05DN1NzTGc1Y3QyeUtDU2tvM01LNytTUDVYaWQ0ZjJpdTZOY0toQTY2NUF1?=
 =?utf-8?B?eUxNK1NvRGZuVThsMW9MU0JwUGdERHc5V3dPUzZIMm5tcEEzVGJ4QjRlZHZC?=
 =?utf-8?B?TXpyVmw5UERGWi91UCtVRk5WcnR4M05Uei91SDIwa1RUZkJQS3VEbC8zc3hH?=
 =?utf-8?B?VGk4dDRkU0d0Kyt1bVRDT0lEUWdRdFdNWGkwQ1kvN0VsVkpqTC9aQlBDNmFh?=
 =?utf-8?B?QUcra0o0c1BRSWhPODBidUx0UzJhZXh6ZlN1bG9oMXBSMTA1U1h6cXRvbTBh?=
 =?utf-8?B?aUxYSkpnSUtxN2U5QzNJTjdVV2FRSHNOQnlFYU9KOTFWQ3g0OEYwcWIwbnlW?=
 =?utf-8?B?OGJxWlp6QmJUS1hDbVVROTJIUDZsS21EZlRTVDFVTWpER0loUWJ4VVU4eDJK?=
 =?utf-8?B?amZLRzhFRW1Nc2VrZnJTVWI3OFU0MGdXNXdINDlMZzkvdExIZ3NybnI4UVFi?=
 =?utf-8?B?RTl4V1VMWFpGamVsYnlVd0R2Q3RHS2N0Q1pWZzE4K3VMMk54T0l5c041Z0ZH?=
 =?utf-8?B?WTdId3R4cU9BYWlTNzYzZytnbFNxVGhiR1gweFFLMnh1NmVKNWIrSUdGV1RR?=
 =?utf-8?B?NVVNSm9vZSsvaUZSQUc3bnpGaHdQWDJMaFUzSUd6dEZGVHdDSkVsMkpZUWFK?=
 =?utf-8?B?eFdwdCtXajQ2bzVybkZucnpuSW1nMytrbkg3Y0duNVc4OUdqUGw1L1cyb1VK?=
 =?utf-8?B?M0hpbWZIc2h4NEhWM2tlbjZRN2daZ0V0QTNRUXFCLzZtbE1wR012MitBNmxj?=
 =?utf-8?B?aUw1RFVZM1hzN0hObVpzSHNpYm5JRkV5Q0xhdDc2T1hZWW50STRtMHpsVUQ0?=
 =?utf-8?B?MTdoYU1IbG5lTGY1UFNMMlM5dHY2dTBiYWlaaVJ1cHFjVjkrdmNucDRzclJX?=
 =?utf-8?B?R1NFRFNiQm5OTzBGcE1mbVRLYk00bytHMEFGNGVpYmFicTdtTVdaYTVQbm5n?=
 =?utf-8?B?Wi9pS1lOSVB4ZlZSY1lhdnBSVk1MbEZ0RFRKWWRtNWFGSjRPdzc3b0hTMi9Q?=
 =?utf-8?B?OExLaG51U0pyVGd6VWtkUHJkN3U0Y1ZmWUZIK2Z2VFZ3MTBJQ0RCV1Q5Vm1t?=
 =?utf-8?B?TWJndHZNK1cwYWNiNHZ6c3h5dXJYQVh5bkVLL29BRTlQMEZHM1VVbVJDMjZm?=
 =?utf-8?B?eXhGN2tUdDU5Z0hMVWRJbzVkZENzVkZISTBCZWRnWVc2S3dyQmVONWRjMFZo?=
 =?utf-8?B?ZXg3TlFPb0JDNkl1Wk1McW9jcTUvc3NpMmVRZFlKY2llQlZ3RmVRMnRkd1dy?=
 =?utf-8?B?dnBVV1dtVi83ZWJxU0xwSi9qREpEeTdIM2xzbmxQcVRxQXJvdFA1OUphY3dv?=
 =?utf-8?B?TVBKNHBmYmE0NThXT1hCMnM0MWJTRm1Ha1JxY08zMzFmL1pIdzlSbFBiSy8r?=
 =?utf-8?B?ZGFlRmw3Zit2L1JzSi9wNmVwWGxDUlVwdGkxNmw1SGtPMHRZeGZ2cllHVlBl?=
 =?utf-8?B?QzdRODJielkvOGlXRm5CN3J2dG5IaXJoVG45TktyRUdSczQ5cmc0Tjh5b3dY?=
 =?utf-8?B?N01TRmRLNTZMUzdQZyttQ095R1RLazFMdjArVGl0bm1tclBjdDFldWNXbTBq?=
 =?utf-8?B?aUwvWE4rS01pMFlsNFpIRGovTGg4aHUwM1RKUG52VkZuMnpzNzBLR3h6OU5G?=
 =?utf-8?B?d2JkOTM0cGpuOSszNnh1eFVTdjVxbnc4UmZsZUtOdTdBZXE5SnMzMUt2eEJ5?=
 =?utf-8?B?UDR4eEVBZ3I5YWRCZ1QxclgyUTVDNTh3QU8rdm14VnBXa3MydnNGaS80SjV4?=
 =?utf-8?B?OFZDUEdlWnBRRXFZQlRETmdVQ2RFYzlKQkxEaWpDVkNEK3NsU29JS20rQTBj?=
 =?utf-8?B?aXk1L3NFUHh3aGNBZm9WdW12YnlrMDBIV2pJWmZFaHNGVlRCNVhRVk45MjNS?=
 =?utf-8?B?eFYrSWxtZHkzbnRwbUpwUE1OWHRRc0RVeXBxQ1NIeklBYkM2cnpEbVBCaVRJ?=
 =?utf-8?B?bS9scnBoQVhGbTUvQ2g2YVk0SFJLYXlsOTIvZWJTTDIrdEhPQ3FQRm9EMXFo?=
 =?utf-8?B?SnJGUkl2RGRJUnRKVFR6L3ZpQVNqNUpPZ0cwUHU0bC9zYmJvaEV5WGxXdlRF?=
 =?utf-8?B?c2FoU0hxd0NUemZMdHF3N0ZzRzh0cnE1SzdxeGlXZ1VQamNYSkdhN0JYU1Vo?=
 =?utf-8?B?ZzdDWm5rV1RNT3FESDJsaEI1S1l4UmVlbU5tenJ4clpuOFlBaFZJN1lwNGE4?=
 =?utf-8?Q?GnWTRP37cz0pieZs=3D?=
X-Exchange-RoutingPolicyChecked: jc0lBlm8tkH4xqAKP6Be7yG/8vRTa2ipYB6oyYGKIECFPxTCvtxKutsWq3RfwFXcQz8LLKzozWvUsSlY5YJebx+ZPk2MVICbAky7djy3MQda22tCtYRfeUw8GZHHlUy81pw9rsW3nRV+hNjwRZPc9YFkVitRFzvJ0OM0CZYg/LwDI8W9cbEeYWpXrhGvHRAv/1hQymiamHvIychAIUgBTBXX6lq/nYBXiCR18kGESPRw0lp6bGH8kOf3ba77dEdEQ4QgmwLS4Z/kyaP6DpJ9Fzpoz/4nVev2uieuoK3MMp2XYhes2H+5/wnI8eDNQmp7W0NiebiRvYC0JqJhKX1QpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfe945a-f0d9-415e-bc27-08df1a33b659
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:02:31.6259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BPig5pKbl0qvdXoLKb+0KhZZRIvRA1gku60NIFSvRQpJjQiMeysSOXo4tK0GY4ERGxdq5g6gl8X0x81mXyB+1YyGzyhwWoiyAzFfMVeXTM=
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

Add i915_* family of printer macros, following existing example
of gt_* and xe_* prints.

Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/i915_printk.h | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/i915_printk.h

diff --git a/drivers/gpu/drm/i915/i915_printk.h b/drivers/gpu/drm/i915/i915_printk.h
new file mode 100644
index 000000000000..5bbbe604cae8
--- /dev/null
+++ b/drivers/gpu/drm/i915/i915_printk.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _I915_PRINTK_H_
+#define _I915_PRINTK_H_
+
+#include <drm/drm_print.h>
+
+#define i915_printk(_i915, _level, _fmt, ...) \
+	drm_##_level(&(_i915)->drm, _fmt, ## __VA_ARGS__)
+
+#define i915_err(_i915, _fmt, ...) \
+	i915_printk((_i915), err, _fmt, ##__VA_ARGS__)
+
+#define i915_err_once(_i915, _fmt, ...) \
+	i915_printk((_i915), err_once, _fmt, ##__VA_ARGS__)
+
+#define i915_err_ratelimited(_i915, _fmt, ...) \
+	i915_printk((_i915), err_ratelimited, _fmt, ##__VA_ARGS__)
+
+#define i915_warn(_i915, _fmt, ...) \
+	i915_printk((_i915), warn, _fmt, ##__VA_ARGS__)
+
+#define i915_notice(_i915, _fmt, ...) \
+	i915_printk((_i915), notice, _fmt, ##__VA_ARGS__)
+
+#define i915_info(_i915, _fmt, ...) \
+	i915_printk((_i915), info, _fmt, ##__VA_ARGS__)
+
+#define i915_dbg(_i915, _fmt, ...) \
+	i915_printk((_i915), dbg, _fmt, ##__VA_ARGS__)
+
+#define i915_dbg_ratelimited(_i915, _fmt, ...) \
+	i915_printk((_i915), dbg_ratelimited, _fmt, ##__VA_ARGS__)
+
+#define i915_WARN_type(_i915, _type, _condition, _fmt, ...) \
+	drm_WARN##_type(&(_i915)->drm, _condition, _fmt, ## __VA_ARGS__)
+
+#define i915_WARN(_i915, _condition, _fmt, ...) \
+	i915_WARN_type((_i915), _condition, __I915_PRINTK_FMT((_i915), _fmt, ## __VA_ARGS__))
+
+#define i915_WARN_ONCE(_i915, _condition, _fmt, ...) \
+	i915_WARN_type((_i915), _ONCE, _condition, __I915_PRINTK_FMT((_i915), _fmt, ## __VA_ARGS__))
+
+#define i915_WARN_ON(_i915, _condition) \
+	i915_WARN((_i915), _condition, "%s(%s)", "WARN_ON", __stringify(_condition))
+
+#define i915_WARN_ON_ONCE(_i915, _condition) \
+	i915_WARN_ONCE((_i915), _condition, "%s(%s)", "WARN_ON_ONCE", __stringify(_condition))
+
+#endif
-- 
2.34.1

