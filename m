Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571F606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bteDf3j6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=HO5GUpN9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF7C10E66C;
	Thu, 19 Nov 2026 03:47:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9EE10E1EA;
 Thu, 19 Nov 2026 03:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795060060; x=1826596060;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7XgdFiyQcY+ZlIPq6ptzu6dZpAbkFn9GN9EqRKJwvw0=;
 b=bteDf3j6LOhHT+uJ5DtwvKCx7TxHf7S9a7JltCpx8QKhpgNVrKCkBkeR
 EY5UsL1icMvsHSghgCoK+MupxtG7ryyJitowQ2PUJyHWp2YmIOk+qx3cp
 KSpjV7HmMwgtKqmFMXH2vJ7ndV+mG5yTaxvJ1YzNzeguD7lMLalgRGmZA
 eAXkDBKstoLnqbjS1ng8U7PsurJrOTgzQCdaosSb/k91SrHD3qrjjJVhf
 XTRaqYJKWND2R81VWAgAdYGsRErFN9tz+He9ACAy2TeEklIeeRA0NSOPg
 pgoKZzREcbWp+vQcVkunweYA7HsicEcIHiVbG/HZ30hI0w0q3/0s3Kfxv w==;
X-CSE-ConnectionGUID: i7CqseTwTfSZtIFgjIMs2g==
X-CSE-MsgGUID: MskZ/jI3Q6uSWxEHw9d4Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3905630"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3905630"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 19:47:38 -0800
X-CSE-ConnectionGUID: YA8oQv9VSG6/pmG8uvdHHA==
X-CSE-MsgGUID: tu4pdVdtTcGCaOd02eI4Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10711940"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 19:47:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 19:47:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 19:47:37 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 19:47:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW7Y+kZrYj8yyDVQHbxnJXddh9NDdHr+S+9D237grnGS52M9eTZb5z1SLVN7dZ35DjGpEVr8wQ1QuB9LpsalyklQwWSUDyf51ZjEZloO9yNNUkjUCht/jD6n8NzrASKvm6sW5ZrxoQVffptZX6RSC7OJSRr1ux8Gegf7usg/wzhMZHhRs+9lSVa44QwN4GQTsPVCe8TGMZrFUaUFk3ZEBYHhZgx8jxHQgCwn7uiLxcv5oBnYzmE27qtxPPW4x6uH3dNbVWsLVG7F1vXMoCSRGuHtGS1O/BvaN+wBPLbSxxgou0EtoU5FsmAi5l663vgHpzTf019vObK0iyEcXYjTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWM6QQLV2ql9PuyapmcIcW1bNmWxOeSGRBN3zXWg6oY=;
 b=d6MC1uIBh9PizcgPcihtBhyWwBMtOQlJPPMcuR7QEzQ6ArJ3vdJgR3c7gozlq9/qPlbfgw0ZzZc2fXaU8ICc+0+b2Ey8xBXoi9V4Aj6paDP1XsbMEveStmOM7a2CP6xexEYIW/HhsYXhtMvp/S0kI5H/la6ZYK0zlyFmC8h6DdMhXW94+TiuCjBeWUcgAS6yfWrjSTC2ieeocZV3Gb7kkXdDVqrgy21iHPAcnFfOcgfSTfPWOtJTPK/VGcR2+ZpvtiQCUqNCOpptBNa8IkSX943pRfbxbp6RfNG0Aj5HVimEZkfQY9silTuEnVdRykwrdSjKYABtCZ/7AUaIHupoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWM6QQLV2ql9PuyapmcIcW1bNmWxOeSGRBN3zXWg6oY=;
 b=HO5GUpN9yrK6PO+BbQH0FjoKzIc1CkX/vQJwSKRHaVy51xzWZ2dLLCLbN6sDxdgCjHzDArDkF6OsjYkunjTWdnsYMQeY/H1WL+lRJM/XFXwTc96xUK4VWGFZxqyxVD4NVHKqwbQbv16yoejySrDJgmegzccSKDNzrMvt3fIeAf4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH3PR11MB677380.namprd11.prod.outlook.com (2603:10b6:610:363::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.17; Thu, 19 Nov
 2026 03:47:15 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 03:47:15 +0000
Date: Wed, 18 Nov 2026 19:47:12 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: "Summers, Stuart" <stuart.summers@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Yadav,
 Arvind" <arvind.yadav@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>, "Upadhyay, Tejas"
 <tejas.upadhyay@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm/xe/guc: Do not trigger TDR from the memory CAT error
 handler
Message-ID: <av5xQK24zmMYCEv3@gsse-cloud1.jf.intel.com>
References: <20261116102020.1567127-1-arvind.yadav@intel.com>
 <04c50600f64b0798c62f92995aa36bb0f56c434e.camel@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04c50600f64b0798c62f92995aa36bb0f56c434e.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH3PR11MB677380:EE_
X-MS-Office365-Filtering-Correlation-Id: 17efe3e8-1630-4f62-2407-08df45efccfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: gP7eX06aG3xWxFvWwJvNdwpm6F7XvEUoUaGs9QzVxn2e61E7hmOYJITg6HUbHPAnuY1PXrBRDeJjTsLZPifpc9R7KeXNM8luufSBvYNohjA8owoth/oCWmSrBdMHlLtvpzDB51KLeY5Pn7zVDAqc+IvMWlKbxdejIkA41Iur+6n5I/InGyg6lNSUPkDivJiSTHcIcCvlOx07gNVWKA5LAExo/yoD1sh17HUDHzPP5Qh34WZCzCMZa4NbodGZ4qcgpnENq6Mm0FsqsZOYTGSeALad0bfF/jgOfMK64FKyodleeEbzAuUD15l9vBJTYf7S/ZmSBVKULGkH0+7Tl8F+SEizEU0L8HZTovhC2aQlNjzzz1MqJTDh1KLp2TTNyRVHDE8FWyltU9n7Sd9A+9OhExlY164pRHxO/yJ51cMRtssETjx4BZsFFth5cyPTWr6HN7wm4gUK75m96pCPqJxgg5wcGD/ZjxQJ+JT+na/4US7sXG4I7qr2viCywJ7n7AA3AzCI3lLKcYvx9nd6xbq8UUO3AYV3DeK8+QyuQYqQix7VeDX0Scxcw0oUVwD+66zDsw1Gr/YEp8GuOtP15N7g61Dgyc/slcT+9e37WE5phcdplTVT0DjelcVnSr7niRXEEhTB04qSKi/1qsM7ZQvRJ9iW8RgjpklbS7noVADuJiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M4kPZ4ZGlgV7MnMP6goBe0MpFGRoJtph4fJ/4xy00jAx8TBGWmEWu1cP/t?=
 =?iso-8859-1?Q?nDqOXsOThidMxHjG/Pizbiwu9ezTPv5fPxpqugEJqc9ofyQyo9IHiqYist?=
 =?iso-8859-1?Q?FJwLY52LMKr2cP0CcjG5qJPDAZ4ClpvpF2h8xtHjljsJAMgX4oBYB3FrrP?=
 =?iso-8859-1?Q?MooEbe9S0AUJm2cLRNPM6jiReVm/84QMU9o86TSkdBfMmQY8mVeTTtaTCo?=
 =?iso-8859-1?Q?AFlZWLDDL2ZoOhhV+qh50OMSS1iTus9OiKI0PKKglfGWXEcjemSWKnGe04?=
 =?iso-8859-1?Q?qRaW8ZbP4xcv0zK/dqvgjvVfLHvFxNBY7AkKFOLh11oEfAzhkAkvlzE1r0?=
 =?iso-8859-1?Q?mNdUlZvvcZKGvwoVpAiPpo4csawjBmQCXnDTIxwC7nT8VpYVMx6KDMBgzX?=
 =?iso-8859-1?Q?UWZuhDEJNrgqRTXACZKevIH1kVSd7Qp5IetrcqzXUc59DzluGThcbsSvgQ?=
 =?iso-8859-1?Q?xocRsIznvaj6sGp5nP6y2xid5T0JlTC/YtWda27ii7j/tE82FxS7goBA8q?=
 =?iso-8859-1?Q?6ErzZAlwQg4s3Ow/XFB6MmjpVqwGJJhGQaMz2kJPYCZXga43A0DwmF3L4S?=
 =?iso-8859-1?Q?d/dIhKATnSBdyd2FtiHT+7FkRiwBzl3NYdro+FceUJ7PODBN2EgzpoGVlw?=
 =?iso-8859-1?Q?7Ot23sfl/bs0H0SMsMWPlpczG32Ul/2G9vpYkG8GHhhRTzyfEHiL7BpdVq?=
 =?iso-8859-1?Q?sgE1jdeCi6r76dMOExWiyB/uIWa1Fw5qINaGP1E1zZ21LAIfvca/DsUCxH?=
 =?iso-8859-1?Q?BIsNmUeYMQxSJHRWddJmmKX4zQJcBMroEA2fIo+9LBrlCdlcPd0c7Ia2C2?=
 =?iso-8859-1?Q?GiMhQcNQmGCPvPSK7CJNVUy80y3SyocSVzjMkKSqRGHzavtPn3RDScMSy2?=
 =?iso-8859-1?Q?997/tW27Q/u3t6STUqitzEGv4+N7Yv/F8FIbldWLdWF3buR4onybOgtDVt?=
 =?iso-8859-1?Q?mfNk5CfPIhBPhcEIkpFoqpt0T5AyxiS9wI4Ahikl8ksOyyMoDCKCeMoEzt?=
 =?iso-8859-1?Q?n1CawMY21VknWP9HbSnrJ/8APNK4bWeqJucLMmJmsy0rBPLrtq69Fme7qd?=
 =?iso-8859-1?Q?hSMrwymgvspHBANJZ+lHVCVp+KXsBV+Lklz0753ObxBCFjlxwrTG8IWgMk?=
 =?iso-8859-1?Q?dLGSh6NAnyTqM5uVBaEstSJqE3JWdMQNKQdTho//4vsmiZTnGEBougdFVR?=
 =?iso-8859-1?Q?Dy/qqF51Du5o6o23/EvqM2jxBQVBzxB1hTXAs29AUScsqS+jRlbeHbmQxH?=
 =?iso-8859-1?Q?diX/ccW2/gxidqLFpE1mPfdl6x3yRDQGJqEtJ/A021ScjqPfrzAWro31O7?=
 =?iso-8859-1?Q?3YGwjhMnRrNkCZBw3ai6TCYso1dZGSIMRvVgwEr5jmzX7IEFAdLcUhpAwL?=
 =?iso-8859-1?Q?lsxOoPdplvrAirU+Wh9qenPSM5pa5iT0KtuedjeYfr0TKYem1a1xCHybkb?=
 =?iso-8859-1?Q?XAAP4I9SByMjHz5bi7J+xEK/6ahNQD8DU8AwLU4ejSetu0CEfWYf13juvt?=
 =?iso-8859-1?Q?G1L3pFu/4zJMrczHuUzN6atkhrb98FrCFTLbfdnwWSi9ZFujbXR4A5hkpi?=
 =?iso-8859-1?Q?cQ8/PsQN/Iyv8B8mQPvBjB1GrfzorbXRj/PxpXDiotTNBlLYSBpaQaV16F?=
 =?iso-8859-1?Q?ZPve0XtlcgSfNLZ3+ov0Lwvq1jvnz4IOxqXQ8DNRinHpk0whMKk8zkIWi7?=
 =?iso-8859-1?Q?DzfcvDOeAOkVuRe3OxTD9SDknNM3GbFc2n65XhNzRxqyQy5nRcx78URIn/?=
 =?iso-8859-1?Q?LTk/fG2mhx6ChYgqjwCBxFyxTKYJ44RsU8E9RNCoRJGBe12mdSWJL7r5z4?=
 =?iso-8859-1?Q?mnINTcqHtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: l+1l6hBPGK212aXF2oIvJIwC8MU00NwEQ0DzxO3iwFU8UV5/Vv/Frgr6PuExleVZIkz6Qjcp7moI5YqYqvIfQhLJ4pokhqhLjNQJ5worXdBLz6S7yWLr2hCzoJyiZM0IGwFzT0EN00mOE+DT9pqT8vJdDp26D7SJJIADQfTzBx/B+aLTqVjouTZyBg41jKm7LvdcuuCZk7IulUsAoTjoju6LoAu4nu3fiK8ytOSa/3bfH+mBbJtYGLdITFq2Ycd4/oVS/bDb/9jUz6gPur4kMI7+munZOlGxtH39pduqvJ1SgEOnR3dGtKjphmg1c3cFOSWzpzpkPiOOwc4nyYNxuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17efe3e8-1630-4f62-2407-08df45efccfd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:47:15.0922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+xyZANzDYxb+Zkdy3gWh2RnhBDCGwROZMB8BMQHXhBrrsarZ4DC+go6knHdHfOnN7OqKjKJQzsVjO7svW4JGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB677380
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:38:30PM -0700, Summers, Stuart wrote:
> On Mon, 2026-11-16 at 15:50 +0530, Arvind Yadav wrote:
> > The memory CAT error handler uses the same cleanup path as the
> > context-reset handler. This immediately triggers the TDR, which can
> > send a scheduling-disable request before the context-reset
> > notification
> > arrives.

So as below - a CAT error is immediately followed by an engine reset
G2H?

> > 
> > On a BMG dGPU, an early disable after a CCS memory CAT error is
> > associated with subsequent contexts being enabled but never starting
> > work. Recovery occurs later when a scheduling-disable timeout
> > triggers
> > a GT reset.
> > 
> > Separate waking user-fence waiters from triggering the TDR. On a
> > memory
> > CAT notification, mark the queue reset and wake waiters without
> > starting
> > the TDR. Keep the existing cleanup triggered by the context-reset
> > notification.
> > 
> > Leave the uncorrectable-error and CGP context-error paths unchanged.
> > 
> > Tested on a BMG dGPU using a standalone SYCL reproducer with two
> > separate processes.
> > 
> > The first process submits a kernel that reads an unmapped GPU
> > address,
> > causing a page fault followed by a memory CAT error. It then calls
> > abort() without waiting for the kernel to finish.
> > 
> > After that process exits, a second process, called "victim", starts.
> > It submits a simple kernel that writes 7 to a device allocation,
> > copies the value back to the CPU and checks the result.
> > 
> > Without the patch, the victim can hang and reach its 60-second
> > userspace timeout. With the patch, the victim completed and returned
> > the expected value in all tested rounds where the first process
> > triggered
> > the fault.
> > 
> > Recovery without a context-reset notification still needs
> > confirmation,
> > particularly for LR queues, which have no normal finite job timeout.
> > Independent queue-kill and cleanup paths are unchanged.
> > 
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> > Assisted-by: LLM

Fixes: ...

> > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> 
> This isn't right... I'm not clear on what problem we're trying to solve
> here. Is it that the engine reset happening after CAT error is taking

I'm little unclear too. I haven't looked in depth - but are we saying
every CAT error is also followed by an engine reset? iirc - that is some
GuC klv option. If we always get a CAT error + engine reset G2H - this
patch is generally ok, but TBH as with Stuart I'm a little confused what
exactly the problem is here but Arvind appears to have data back to this
up, perhaps a GuC or HW quirk. Assuming this some quirk, I'd say we get
in this into the GuC spec if has programming flows section.

> too long? And where is the schedule disable originating? If it's part

The schedule disable originates from the TDR.

> of the TDR that means we likely want to re-arrange the TDR sequence
> rather than just skip it.

Well the TDR can't signal any fences (this is the job of TDR) until a
schedule disable returns to avoid any possible memory corruption which
infinitely worse than a long hang as that can take down the OS.

> 
> Engine reset is required after a CAT error to recover and the driver is
> doing that as part of this flow (vs an engine reset due to a preemption
> failure which originates from GuC and the driver just reacts to that).

Right, iirc we always get a engine reset after CAT error - but my
assumption was schedule disable from the TDR was the source of the
engine reset, not from the CAT error.

So TL;DR, I think this patch is fine with a bit more explaination and
possible GuC spec follow up.

Matt

> 
> Thanks,
> Stuart
> 
> > ---
> >  drivers/gpu/drm/xe/xe_guc_submit.c | 50 ++++++++++++++++++++++------
> > --
> >  1 file changed, 37 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c
> > b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index d76f125f9c3a..aa382634a235 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -557,17 +557,39 @@ static bool vf_recovery(struct xe_guc *guc)
> >         return xe_gt_recovery_pending(guc_to_gt(guc));
> >  }
> >  
> > -static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue
> > *q)
> > +static void xe_guc_exec_queue_wake_ufence(struct xe_exec_queue *q)
> >  {
> >         struct xe_guc *guc = exec_queue_to_guc(q);
> >         struct xe_device *xe = guc_to_xe(guc);
> >  
> >         /** to wakeup xe_wait_user_fence ioctl if exec queue is reset
> > */
> >         wake_up_all(&xe->ufence_wq);
> > +}
> > +
> > +static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue
> > *q)
> > +{
> > +       xe_guc_exec_queue_wake_ufence(q);
> >  
> >         xe_sched_tdr_queue_imm(&q->guc->sched);
> >  }
> >  
> > +/*
> > + * Allow callers to wake user-fence waiters without triggering the
> > TDR.
> > + * The memory CAT handler uses this to avoid starting cleanup before
> > + * the context-reset notification arrives.
> > + */
> > +static void xe_queue_trigger_cleanup_for_reset(struct xe_exec_queue
> > *q,
> > +                                              bool trigger_tdr)
> > +{
> > +       if (exec_queue_banned(q))
> > +               return;
> > +
> > +       if (trigger_tdr)
> > +               xe_guc_exec_queue_trigger_cleanup(q);
> > +       else
> > +               xe_guc_exec_queue_wake_ufence(q);
> > +}
> > +
> >  static void xe_guc_exec_queue_group_stop(struct xe_exec_queue *q)
> >  {
> >         struct xe_exec_queue *primary =
> > xe_exec_queue_multi_queue_primary(q);
> > @@ -653,7 +675,8 @@ static void
> > xe_guc_exec_queue_group_trigger_cleanup(struct xe_exec_queue *q)
> >         mutex_unlock(&group->list_lock);
> >  }
> >  
> > -static void xe_guc_exec_queue_reset_trigger_cleanup(struct
> > xe_exec_queue *q)
> > +static void xe_guc_exec_queue_reset_trigger_cleanup(struct
> > xe_exec_queue *q,
> > +                                                   bool trigger_tdr)
> >  {
> >         if (xe_exec_queue_is_multi_queue(q)) {
> >                 struct xe_exec_queue *primary =
> > xe_exec_queue_multi_queue_primary(q);
> > @@ -664,20 +687,17 @@ static void
> > xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue *q)
> >                 WRITE_ONCE(group->banned, true);
> >  
> >                 set_exec_queue_reset(primary);
> > -               if (!exec_queue_banned(primary))
> > -                       xe_guc_exec_queue_trigger_cleanup(primary);
> > +               xe_queue_trigger_cleanup_for_reset(primary,
> > trigger_tdr);
> >  
> >                 mutex_lock(&group->list_lock);
> >                 list_for_each_entry(eq, &group->list,
> > multi_queue.link) {
> >                         set_exec_queue_reset(eq);
> > -                       if (!exec_queue_banned(eq))
> > -
> >                                xe_guc_exec_queue_trigger_cleanup(eq);
> > +                       xe_queue_trigger_cleanup_for_reset(eq,
> > trigger_tdr);
> >                 }
> >                 mutex_unlock(&group->list_lock);
> >         } else {
> >                 set_exec_queue_reset(q);
> > -               if (!exec_queue_banned(q))
> > -                       xe_guc_exec_queue_trigger_cleanup(q);
> > +               xe_queue_trigger_cleanup_for_reset(q, trigger_tdr);
> >         }
> >  }
> >  
> > @@ -3523,7 +3543,7 @@ int xe_guc_exec_queue_reset_handler(struct
> > xe_guc *guc, u32 *msg, u32 len)
> >          * jobs by setting timeout of the job to the minimum value
> > kicking
> >          * guc_exec_queue_timedout_job.
> >          */
> > -       xe_guc_exec_queue_reset_trigger_cleanup(q);
> > +       xe_guc_exec_queue_reset_trigger_cleanup(q, true);
> >  
> >         return 0;
> >  }
> > @@ -3601,8 +3621,12 @@ int
> > xe_guc_exec_queue_memory_cat_error_handler(struct xe_guc *guc, u32
> > *msg,
> >  
> >         trace_xe_exec_queue_memory_cat_error(q);
> >  
> > -       /* Treat the same as engine reset */
> > -       xe_guc_exec_queue_reset_trigger_cleanup(q);
> > +       /*
> > +        * Starting the TDR here can send a scheduling-disable
> > request before
> > +        * the context-reset notification arrives. Mark the queue
> > reset and
> > +        * wake user-fence waiters, leaving that notification to
> > trigger cleanup.
> > +        */
> > +       xe_guc_exec_queue_reset_trigger_cleanup(q, false);
> >  
> >         return 0;
> >  }
> > @@ -3644,7 +3668,7 @@ int xe_guc_uncorrectable_error_handler(struct
> > xe_guc *guc, u32 *msg, u32 len)
> >         trace_xe_guc_uncorrectable_error(q);
> >  
> >         /* Treat the same as engine reset */
> > -       xe_guc_exec_queue_reset_trigger_cleanup(q);
> > +       xe_guc_exec_queue_reset_trigger_cleanup(q, true);
> >  
> >         return 0;
> >  }
> > @@ -3696,7 +3720,7 @@ int
> > xe_guc_exec_queue_cgp_context_error_handler(struct xe_guc *guc, u32
> > *msg,
> >         trace_xe_exec_queue_cgp_context_error(q);
> >  
> >         /* Treat the same as engine reset */
> > -       xe_guc_exec_queue_reset_trigger_cleanup(q);
> > +       xe_guc_exec_queue_reset_trigger_cleanup(q, true);
> >  
> >         return 0;
> >  }
> 
