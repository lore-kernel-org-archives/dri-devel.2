Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CAEC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7348A10E17D;
	Mon, 21 Sep 2026 17:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cV5//Twt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F7F10E0DD;
 Mon, 21 Sep 2026 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790011988; x=1821547988;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wQOD+FSVsxRlPmhLohxnR/1uoNGhEn/8ydX9bV5xdUA=;
 b=cV5//TwtL/4ErGaE7JHQ6gLTAVABMKBHY9mwnXp0oeAwlL9kiFCfuOHK
 BEas2u28LyL5MkcgTIytOAznBfMm6OP49oUKnodkwBRkg5dCDQN3XyYYJ
 OiAipLchxCCmYVo2YcauXm5G72IUZpw8ZxftV5ybcJB0icXgzNsVAu3uD
 13DMdnmzss5fLPpOzmeznJeaWMQcHMkgz45plSEO+48qfNSeBoVUwr7ra
 lLy/R0jSvhr2n3xsZySBZwFvm1p+02U23qpkdWpTYor2A6hFdjRtSU9C7
 uaYfPYZs8jwcLjntIitYn79b1FOzsoLJEmWxgcrN9epqg0wYFn4Lbjnej w==;
X-CSE-ConnectionGUID: lQyZvUL2TTaKQLXdnP5DtA==
X-CSE-MsgGUID: RiMgVOdOQ6+6RaEkVD32Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89686445"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="89686445"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 10:33:07 -0700
X-CSE-ConnectionGUID: S7ZYRnzxRZGIdK0UiD4qAA==
X-CSE-MsgGUID: CreJLXnoRpOADu2VMe434A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="298985674"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 10:33:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 10:33:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 10:33:06 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 10:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK1/RIs1XV5GjPHSSusBS8bUKuuA1zWGAX8ejkcVLb9TSVQTDIN/HfeUhN8fYVVnKisN1OUySRTyGO9Ly/FN3s1qhNzuE6zdqDDU54kjrRsN8If7LOxPLcET75b3gkWZpA0o9zHBALKcHsYCicuGF6HCSxeBVZNg3g8VdDOSTrPxgEZpYYbj54XG+vPsRfiKqFjE1Cmrj/Ah8B5iWo4zaM3k/VQM23rwNAFRlws5zAHC240Jhex+8xwBixUoEXLdUe+o35ATfvbe6AE8w7PkVDNwS1Gqwtq5TPRxR2cQT5+m/a9bzwmdzVVocosT4XvD2qbLyytEmwLG+tbP2ptwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQOD+FSVsxRlPmhLohxnR/1uoNGhEn/8ydX9bV5xdUA=;
 b=biU9niUu/uHYnuYqyJq3/iLO3Exia6WbBkxVttVjJ05pHH4qcO9KVcP+OnKVB7/weT2i/3hrMnjCAIe1r49lkK9NBoOkQ+a1Otf4lbIoURNUxp2kydwFHTWjWP50vKp5C+Je07ECo/hYU0ifsU2tNeX7DmDgNuXBfNnqdyVqi69a9emD/rQGeXXdDCfPNW3UUH9i5FEFoUtvQatLgCYvppuw1zu7URJ1YaPOXcAkmb4+3e9UKOcu3FojfshOF1GzecHUSe0AD+y3rWF8BF/OG0iQHTpa1MDm6wRJmV59IjN1Aknc2fADHZWmyoSVzfawRKFTxbvvrPbzo4BUY/oc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:33:03 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:33:03 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Thread-Topic: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Thread-Index: AQHdCOF1lbPxpopA/0itXMF8igkPpbZXtN2AgADdC4CAAE7mgICA67Eg
Date: Mon, 21 Sep 2026 17:33:03 +0000
Message-ID: <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
In-Reply-To: <178292444166.273574.16738251742448073960@jlahtine-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|SA1PR11MB8278:EE_
x-ms-office365-filtering-correlation-id: 1e59f5dd-077d-4c4d-f0c3-08df180663dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|42112799006|376014|10067099003|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: ieZbmq1tICKm56xgE7O6E/hKfLdfZtVLJfrpnfSIZJM5pUxh3mu10SV3zzFDyf02jTlmfIoghKlguLynWtm+coYE+KrQ4YcnfLE4zx6fDEKCibdoFAtWveQgM69a+vnoKh/5LGU9wGpVNfiq0/N5VZtiZjDknDtm9LaU/NB7rATRqmT7mogZbYSQcv9Ko0LPIiaxFiVJcoqLojVdRb+IrT3kDvyPKh2luXU9dGWW/4uoIFHJ0VbfPrNXAJT64QlstfU9CLqeBKnlwsh6hfGrKqUaNnw7r+UnLqmCgMCait790oK70rC0eXYic7bc0bLUibpmwafTHNv5NWzAzp9ZCUqZVGJJj8ZCL2gadgSpdvAjQO0ECKI/R2Ej9T/JEmAtaYLBYq5NPZYlflmFdils9iN2hYhJQ9mh+nB6OO6ryvzj0600WBZvpLsr+pOzy+0kUWklssCbJDpXt0KDDvZnb9EFoYjxYDWyIuyefBk04oF3QmyiNBPG5GaJFw6gLsKIfc0oAvfdMl6DRb2iCgfHtPCJqAp82z8g4Zf5VZvWHpWcz8UHPQTf6AnIAIZAjmQIlHEpoHHxLQMjFoQl84v8F0tX+sZNyWsJJrlnnF4pkeTukDvnq9pTNjG+oKDlD2ehMPRmBImEKK0SqLq9NQyzI2UM5Vgo4EqnK1BcjJdFqjo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(42112799006)(376014)(10067099003)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anIxM2psYmVIa25RaUxPUERGckljcDIyYm5qV1RETk5NZ3UySWtLV0sxMGhN?=
 =?utf-8?B?VUdjLytJYWR6Q2QwSmFJWjk2aG14TFRZRWxNcG9GU2t1ejhXc3ZsTjUzNUhU?=
 =?utf-8?B?eWowL2t2NExQdi9XWXNPVldCeDBXcUxMMFYwS3BJZUdtTXBBVWttS0hXMnVo?=
 =?utf-8?B?NzFrQ1BhRllSNStLTjdCaERJdks1clFrS1dPMERDRHJEa3FDYkZ5NTRZdkZB?=
 =?utf-8?B?c01wNTJ6MkxvRDI4Q0h0K1FBY0RsUEFZNlZCZjNjc09CWnBPeXkyYzhCL1FP?=
 =?utf-8?B?ZmFrYTlwL1craEV6Vmcwa0w2Z2QwQVhWTllFTHBQRDdkZUhTU2xwT29tWGQw?=
 =?utf-8?B?dVFrVjhoOGxUcDk4eERFaWIxWEtCeEJQckx0OEt1NUdoUEkrOUhESjRXOHFu?=
 =?utf-8?B?YSt2QVFxMytlSWZPa084eWhRQTBFQnBDNlZYVVpPK2RRcFVEYnBFRjMxd3hE?=
 =?utf-8?B?ZTZCb1QrZDRweXVMeUQya21wS2VlUXFGZkc2dTI3YXpCaTVtQ3BqYmtVSUsr?=
 =?utf-8?B?amhHTDVoMStpS080S05ibUtJZGFWbi9EYTNSWTlIQmR0SDZHK3dqelllNGJN?=
 =?utf-8?B?M1EwNGwvT0ppVEFQeDVhdEFyZnlGVkJwQlJ2a2lRcUhKWE9oNUlicTJrRldU?=
 =?utf-8?B?eWduTHltaXBWelJzZ2oxbDNXWWZEcGFrdlZmdmdDVW9HUk9ZZ0ZRSVhNelpq?=
 =?utf-8?B?LytwVDFLUVM1UWsxb0N2anRkZ2pFVlNRdkVVaEFjTFV5S1JFMnJsaFlzR0h6?=
 =?utf-8?B?bExxRFYreHpvOEk4TFZRdHB1S0R0ZXNWWGhXdm9Nd2pKQWI4VitOZkY3OWcw?=
 =?utf-8?B?RVRlL3I2bE1pcGNiWk9sZ1VHaFpEVkdDQUhHbzg0T05EQU0xd1NBY3pVcjM5?=
 =?utf-8?B?WXJUeXRtelZiQ1ZmdHl2U3RiMlRSKzdNYzhWWHJJWEFUY0p4eG5Uano3OE83?=
 =?utf-8?B?dHg0U2EvcjdWN2FIWmxoaDkxblVMZUtFLys1YjFqWnBsNXNUdGxjUXhuWkVm?=
 =?utf-8?B?d1VJQ1lXZi9mNlYwQUVTdUk1YU9xV3p5ZS9Hc1RlWHhNU3J0RjZEUnozbzUw?=
 =?utf-8?B?cnJFb2c3eGZ1YlFCMkZmS01WTW92SWQ0eVd6YjJDU3VPYU52WUNvUytJT1dV?=
 =?utf-8?B?MXVSeU9KRXV3UkhLWC9FcFVNaU1DMjJaRDBhajhFMHZ6VjdVSGhDdWxlQnZR?=
 =?utf-8?B?TmdFOTRmeHRMYmU5TzhSUzNDNWlwc0NDY1ZMNC93WU8ya1Zxb3dhcWUyaE5B?=
 =?utf-8?B?V3YvNklGaWlWQ1N4SVFGdHF2a0NtVnM3enRsaVhOVitCTEdaR0pmRG0vNUMw?=
 =?utf-8?B?MW42eEVQdlVOQ0xEQ2k3YlV6T1ErWExPTlF5a0VoTnhodTl2am02MVVYcDVs?=
 =?utf-8?B?QmhVdC80bndFTkJtMWVlcGd6eTZnaFpHN1JNR3lkWHc1VHB3WTg2Y3hDMERV?=
 =?utf-8?B?YW50MzI4S2hzZEo0cFgrK2lFOGJqSlh2cktkdjlXaWNTNHZ3eFd4K2E1K0Ja?=
 =?utf-8?B?Njd2aGhEb1lhQVdvb2x6Q0VUTGhtSTdGMkM2MFM4RVdST3Rxc3duczZ1bWwv?=
 =?utf-8?B?Yi9aN085Z3p1UzZ6cGJ5SHdOZVFZMmU4NThXV2xVK0h0bWxWUE5tcXMzYm5V?=
 =?utf-8?B?N1RFZkZnaUc3djg5L1JJL2QzUlFPSUtyYzBmcGUybG1VMkduUGtUakZFT1R1?=
 =?utf-8?B?TkNTWExIZFZ0OFVSdjRZUzF4S3YvcFY4K3FFdldYVFhYV1piZ3RtaGdtSzNW?=
 =?utf-8?B?OVhXRUJTRnFVbCtnblY5MlRHZFE5eW9ueGtpTEk0WE0rUnIvbDlId2xQSDJX?=
 =?utf-8?B?d3oyczJuMk5vZlFqMFJYejRaLzBqVXBwQ1VMSXNCdEFRMFc2Q0pVSkpUbHRM?=
 =?utf-8?B?RVNNZ2hPWDFFMk9PVkxKYTBvTExQOEZsTGZwN2ZpUW1scU1EcWtRU2ZKM0tJ?=
 =?utf-8?B?UUxvQU4zbnJSbjUrVExCdGsrTmNGVGU3Vlk0MUh6bGJMUTRkUXV6NktuNXJF?=
 =?utf-8?B?TXUvbVJ4anFZaURZejhiclZBMXkxck52VXBYdTI1WVpnQmJYMEV3Ris5bVRp?=
 =?utf-8?B?RTlIcHNtOWNCSE5VNTJvV3FDTENOcmEzbmhEbHlIYjZIaXZic2MzaEY0bk1T?=
 =?utf-8?B?ZjFtVmlFUll1a2dWQzZJWHdDREZQKytLTVduZGdXQ05OUnF2S3ZVMnY4eUFy?=
 =?utf-8?B?MS9BZC9jb2ZZblVEUXdoS1JBRlFHUHZJaktKR21nYlZqTHZKa1FVekdwUExB?=
 =?utf-8?B?OE5WTWdHTjJOV09nQm5neFpSeW0xbDZ4Wm9EUzdDelArL1EzcFM4QVdUUFJv?=
 =?utf-8?Q?d73+n3HV5JzC5lXVet?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xrrmuqV4KBzsc2Gb6HPMd+PmetYwr5CfILyDiUUhN787GTZTg2JCIO8ZezDL1FyR68FRA5Xnj8SySF8rOiYeeqzkVxE3TrdlmpW0XXKFE1d5ewxoYxEvmPMVumymaXbkoPAahkkfakeWmT34HqP+YzkkXqNoD5IYq2F/zuxsbZqk+qtKiix/3l9yeF4KBKxHqVRCuWimkgS/Djl0wLRMJbAxuHrqHIertCny+jNF2zs/j/BNYQxhkAc7PhZVL4y+rTejxoVM211PwXjroyma1NqVYrvZhtHKR3CX6M6I8Jbxdvx8uLn5h++Lnhok/GsOOHN8kCf1LFRwRl+BOsYpiw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e59f5dd-077d-4c4d-f0c3-08df180663dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 17:33:03.3849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6CgbYXHQSOJ2npuPXHq7GMLSknnNN9caSjdtwljeME3/k5kVuivNsgDux6fISYbIN5hX8AKL1nRkhGtUhK9MxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278
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

SGkgQExhaHRpbmVuLCBKb29uYXMsDQoNClRoZSBrZXkgaXMgTFNDX0NISUNLRU5fQklUXzAgaXMg
YSBnbG9iYWwgcmVnaXN0ZXIuDQoNCkV2ZW4gd2UgdXNlIHBlci1jbGllbnQsICB3ZSBzaG91bGQg
Y29uc2lkZXIgdGhlIGZvbGxvd2luZyBjYXNlczoNCg0KMS4gU2hvdWxkIGNvbmZsaWN0aW5nIGNv
bmZpZ3VyYXRpb25zIHdpdGhpbiBhIGNsaWVudCBiZSByZWplY3RlZD8gICAgICAgICAgICAgICAg
ICAgICAgIEkgcmVjb21tZW5kIHRoZSBmaXJzdCBzZXR0aW5nIHNob3VsZCBiZSBsYXRjaGVkLg0K
Mi4gU2hvdWxkIGNvbmZsaWN0aW5nIGNvbmZpZ3VyYXRpb25zIGFjcm9zcyBkaWZmZXJlbnQgY2xp
ZW50cyBiZSByZWplY3RlZD8gICAgICAgIEkgdGhpbmsgdGhlIGxhdHRlciBzZXR0aW5nIGNhbiBj
b3ZlciBwcmV2aW91cyBvbmUuDQoNCkV2ZW4gbGlrZSB0aGlzLCBzdGlsbCBjYW4ndCBjb3ZlciBh
bGwgdGhlIHJhY2UgY29uZGl0aW9uLg0KDQpUaGFua3MsDQpKaWENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb29uYXMgTGFodGluZW4gPGpvb25hcy5sYWh0aW5lbkBs
aW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxLCAyMDI2IDk6NDcgQU0N
Cj4gVG86IFlhbywgSmlhIDxqaWEueWFvQGludGVsLmNvbT47IHNhc2hpa28tYm90QGtlcm5lbC5v
cmc7IHNhc2hpa28tDQo+IHJldmlld3NAbGlzdHMubGludXguZGV2DQo+IENjOiBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBS
b3BlciwNCj4gTWF0dGhldyBEIDxtYXR0aGV3LmQucm9wZXJAaW50ZWwuY29tPjsgVHZydGtvIFVy
c3VsaW4NCj4gPHR1cnN1bGluQHVyc3VsaW4ubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5
XSBkcm0vaTkxNS9kZzI6IEFkZCBwZXItY29udGV4dCBjb250cm9sIGZvcg0KPiBXYV8yMjAxMzA1
OTEzMQ0KPiANCj4gKCsgaW50ZWwtZ2Z4IGZvciByZWFsIHRoaXMgdGltZSkNCj4gDQo+IFF1b3Rp
bmcgSm9vbmFzIExhaHRpbmVuICgyMDI2LTA3LTAxIDE1OjA0OjU3KQ0KPiA+ICgrIGludGVsLWdm
eCwgTWF0dCBhbmQgVHZydGtvKQ0KPiA+DQo+ID4gUXVvdGluZyBzYXNoaWtvLWJvdEBrZXJuZWwu
b3JnICgyMDI2LTA3LTAxIDAxOjUzOjQ5KQ0KPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRy
aWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMSBwb3RlbnRpYWwNCj4gaXNzdWUocykg
dG8gY29uc2lkZXI6DQo+ID4gPiAtIFtIaWdoXSBEeW5hbWljYWxseSBtb2RpZnlpbmcgdGhlIGds
b2JhbGx5IHNoYXJlZCBNQ1IgcmVnaXN0ZXINCj4gTFNDX0NISUNLRU5fQklUXzAgcGVyLWNvbnRl
eHQgY2F1c2VzIGEgcmFjZSBjb25kaXRpb24gd2hlbiBjb250ZXh0cw0KPiBleGVjdXRlIGNvbmN1
cnJlbnRseSBvbiBkaWZmZXJlbnQgZW5naW5lcywgbGVhZGluZyB0byBMMyBjYWNoZSBzdGF0ZSBj
b3JydXB0aW9uDQo+IGFuZCBHUFUgaGFuZ3MuDQo+ID4gPiAtLQ0KPiA+ID4NCj4gPiA+IGNvbW1p
dCBhYTU1NTRjNTcxZmQ2ZWE1MGI0YjFkMTA3ZDBiYTI3ZWVhZTE4YTdjDQo+ID4gPiBBdXRob3I6
IEppYSBZYW8gPGppYS55YW9AaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IGRybS9pOTE1L2RnMjog
QWRkIHBlci1jb250ZXh0IGNvbnRyb2wgZm9yIFdhXzIyMDEzMDU5MTMxDQo+ID4gPg0KPiA+ID4g
VGhpcyBjb21taXQgaW50cm9kdWNlcyBhIHBlci1jb250ZXh0IG9wdC1vdXQgZm9yIFdhXzIyMDEz
MDU5MTMxIG9uDQo+ID4gPiBERzItRzExIHBsYXRmb3JtcywgYWxsb3dpbmcgdXNlcnNwYWNlIHRv
IG1hbmFnZSBMU0NfQ0hJQ0tFTl9CSVRfMCBiaXQNCj4gMTUgaXRzZWxmLg0KPiA+ID4gSXQgYXBw
bGllcyB0aGlzIHdvcmthcm91bmQgY29uZGl0aW9uYWxseSBkdXJpbmcgaW5kaXJlY3QgY29udGV4
dA0KPiA+ID4gYmF0Y2hidWZmZXIgZXhlY3V0aW9uIHJhdGhlciB0aGFuIGdsb2JhbGx5IGF0IGVu
Z2luZSBpbml0Lg0KPiA+ID4NCj4gPiA+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9j
b21wdXRlLXJ1bnRpbWUvcHVsbC85MTkNCj4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9scmMuYw0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2d0L2ludGVsX2xyYy5jDQo+ID4gPiA+IGluZGV4IDE0N2QyMjkwNzk2MGIuLmEzNTYw
MWU2ZjFlOTAgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2lu
dGVsX2xyYy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2xy
Yy5jDQo+ID4gPg0KPiA+ID4gWyAuLi4gXQ0KPiA+ID4NCj4gPiA+ID4gQEAgLTEzNDgsNiArMTM0
OCwzNyBAQCBnZW4xMl9pbnZhbGlkYXRlX3N0YXRlX2NhY2hlKHUzMiAqY3MpDQo+ID4gPiA+ICAg
ICAgIHJldHVybiBjczsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gK3N0YXRpYyB1MzIg
Kg0KPiA+ID4gPiArZGcyX2cxMV9lbWl0X3dhXzIyMDEzMDU5MTMxKGNvbnN0IHN0cnVjdCBpbnRl
bF9jb250ZXh0ICpjZSwgdTMyDQo+ID4gPiA+ICsqY3MpIHsNCj4gPiA+ID4gKyAgICAgLyoNCj4g
PiA+ID4gKyAgICAgICogV2hpbGUgcmUtd3JpdGluZyBMU0NfQ0hJQ0tFTl9CSVRfMCBmb3IgV2Ff
MjIwMTMwNTkxMzEsIHRoZQ0KPiA+ID4gPiArICAgICAgKiBvdGhlciBiaXRzIG9mIHRoZSByZWdp
c3RlciB3aWxsIGFsc28gZ2V0IG92ZXJ3cml0dGVuLiAgVGhlDQo+ID4gPiA+ICsgICAgICAqIGhh
cmR3YXJlIGRlZmF1bHQgZm9yIGFsbCBvdGhlciBiaXRzIGlzIDAsIGJ1dCBhbnkgd29ya2Fyb3Vu
ZHMNCj4gPiA+ID4gKyAgICAgICogdGhhdCBhZGp1c3QgdGhlIG90aGVyIGJpdHMgaW4gdGhlIGxv
d2VyIGR3b3JkIG9mIHRoZSByZWdpc3Rlcg0KPiA+ID4gPiArICAgICAgKiBhbHNvIG5lZWQgdG8g
YmUgcmUtYXBwbGllZCBoZXJlLiAgQXQgdGhlIG1vbWVudCB0aGF0J3MganVzdA0KPiA+ID4gPiAr
ICAgICAgKiBXYV8yMjAxNDIyNjEyNywgd2hpY2ggaXMgYWx3YXlzIHNldCBmb3IgREcyLUcxMSBw
bGF0Zm9ybXMuDQo+ID4gPiA+ICsgICAgICAqLw0KPiA+ID4gPiArICAgICB1MzIgdmFsID0gRElT
QUJMRV9EOF9EMTZfQ09BU0xFU0NFOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIC8qDQo+ID4g
PiA+ICsgICAgICAqIFdhXzIyMDEzMDU5MTMxOiBvbmx5IHNldA0KPiBGT1JDRV8xX1NVQl9NRVNT
QUdFX1BFUl9GUkFHTUVOVCBmb3INCj4gPiA+ID4gKyAgICAgICogdXNlcnNwYWNlIGNvbnRleHRz
IHRoYXQgaGF2ZSBub3Qgb3B0ZWQgb3V0LiAgS2VybmVsLWludGVybmFsDQo+ID4gPiA+ICsgICAg
ICAqIGNvbnRleHRzIChnZW1fY29udGV4dCA9PSBOVUxMKSBuZXZlciBydW4gc2hhZGVyIHdvcmts
b2FkcyB0aGF0DQo+ID4gPiA+ICsgICAgICAqIHJlcXVpcmUgdGhpcyB3b3JrYXJvdW5kLCBzbyBz
a2lwIHRoZW0gdW5jb25kaXRpb25hbGx5Lg0KPiA+ID4gPiArICAgICAgKi8NCj4gPiA+ID4gKyAg
ICAgaWYgKHJjdV9hY2Nlc3NfcG9pbnRlcihjZS0+Z2VtX2NvbnRleHQpICYmDQo+ID4gPiA+ICsg
ICAgICAgICAhdGVzdF9iaXQoQ09OVEVYVF9XQV8yMjAxMzA1OTEzMSwgJmNlLT5mbGFncykpIHsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICB2YWwgfD0gRk9SQ0VfMV9TVUJfTUVTU0FHRV9QRVJfRlJB
R01FTlQ7DQo+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4NCj4gPiA+IFtTZXZlcml0
eTogSGlnaF0NCj4gPiA+IERvZXMgZHluYW1pY2FsbHkgbW9kaWZ5aW5nIExTQ19DSElDS0VOX0JJ
VF8wIHBlci1jb250ZXh0IGNhdXNlIGENCj4gPiA+IHJhY2UgY29uZGl0aW9uIHdoZW4gY29udGV4
dHMgZXhlY3V0ZSBjb25jdXJyZW50bHkgb24gZGlmZmVyZW50IGVuZ2luZXM/DQo+ID4gPg0KPiA+
ID4gTFNDX0NISUNLRU5fQklUXzAgaXMgYSBnbG9iYWxseSBzaGFyZWQgTUNSIHJlZ2lzdGVyIGFm
ZmVjdGluZyB0aGUgTDMNCj4gPiA+IGNhY2hlLCB3aGljaCBpcyBzaGFyZWQgYWNyb3NzIGFsbCBy
ZW5kZXIgYW5kIGNvbXB1dGUgZW5naW5lcyBvbiBERzIuDQo+ID4gPiBNb2RpZnlpbmcgaXQgdmlh
IE1JX0xPQURfUkVHSVNURVJfSU1NIGJyb2FkY2FzdHMgdGhlIGNoYW5nZSB0byBhbGwgTDMNCj4g
YmFua3MuDQo+ID4gPg0KPiA+ID4gSWYgQ29udGV4dCBBICh3aGljaCByZXF1aXJlcyB0aGUgd29y
a2Fyb3VuZCkgcnVucyBvbiBSQ1MwLCBhbmQNCj4gPiA+IENvbnRleHQgQiAod2hpY2ggb3B0cyBv
dXQpIHN3aXRjaGVzIGluIG9uIENDUzAsIENDUzAncyBjb250ZXh0DQo+ID4gPiBzd2l0Y2ggZXhl
Y3V0ZXMgdGhpcyBpbmRpcmVjdCBiYXRjaGJ1ZmZlciBhbmQgY2xlYXJzIGJpdCAxNQ0KPiA+ID4g
Z2xvYmFsbHkuIFRoaXMgY291bGQgZHluYW1pY2FsbHkgYWx0ZXIgdGhlIHN0YXRlIGZvciBDb250
ZXh0IEEgb24NCj4gPiA+IFJDUzAsIHBvdGVudGlhbGx5IGRpc2FibGluZyB0aGUgd29ya2Fyb3Vu
ZCBhbmQgY2F1c2luZyBhIEdQVSBoYW5nLg0KPiA+DQo+ID4gVGhlIGZhY3QgdGhhdCB3ZSBleHBl
Y3QgY29tcHV0ZSBhbmQgTWVzYSB0byBhbGlnbiBhY3Jvc3MgdGhlaXIgb3duDQo+ID4gY29udGV4
dHMgc2hhcmluZyBzaW5nbGUgYWRkcmVzcyBzcGFjZSB0b2RheSBpcyBvbmUgdGhpbmcsIGJ1dCBJ
IHRoaW5rDQo+ID4gd2Ugc2hvdWxkIGJlIGVuZm9yY2luZyB0aGF0LiBDdXJyZW50bHkgbm90aGlu
ZyBwcmV2ZW50aW5nIFJDUyBhbmQgQ0NTDQo+ID4gc2hhcmluZyBvbmUgYWRkcmVzcyBzcGFjZSBm
cm9tIGZpZ2h0aW5nIG92ZXIgdGhlIHZhcmlhYmxlLg0KPiA+DQo+ID4gVGhpcyBtYWtlcyBtZSBk
b3VidCBpZiBtb2RlbGxpbmcgdGhpcyBhcyBhIHBlci1jb250ZXh0IHZhcmlhYmxlIHdhcw0KPiA+
IHRoZSByaWdodCBjaG9pY2UuDQo+ID4NCj4gPiBNYXliZSB3ZSBzaG91bGQgaW5zdGVhZCBiZSBt
YWtpbmcgaXQgRFJNIGNsaWVudCB3aWRlIHByb3BlcnR5IGFuZA0KPiA+IGluaGVyaXRpbmcgaXQg
dG8gYWxsIGNvbnRleHRzPw0KPiA+DQo+ID4gUmVnYXJkcywgSm9vbmFzDQo+ID4NCj4gPiA+DQo+
ID4gPiA+ICsgICAgICpjcysrID0gTUlfTE9BRF9SRUdJU1RFUl9JTU0oMSk7DQo+ID4gPiA+ICsg
ICAgICpjcysrID0gaTkxNV9tbWlvX3JlZ19vZmZzZXQoTFNDX0NISUNLRU5fQklUXzApOw0KPiA+
ID4gPiArICAgICAqY3MrKyA9IHZhbDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICByZXR1cm4g
Y3M7DQo+ID4gPiA+ICt9DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IFNhc2hpa28gQUkgcmV2aWV3
IMK3DQo+ID4gPiBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA2MzAyMjM5NDYu
MjEwNzM4Mi0xLQ0KPiBqaWEueWFvQGludGUNCj4gPiA+IGwuY29tP3BhcnQ9MQ0K
