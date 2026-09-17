Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E57C982CC
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 00:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5884D10E118;
	Thu, 17 Sep 2026 00:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="etGFNq3x";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63D110E117;
 Thu, 17 Sep 2026 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789606479; x=1821142479;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=DsUDwdeWx0iv3DTcH/r80dGTCtDcX9omwWjdlT6WoMA=;
 b=etGFNq3xP6geWz8UcvBQNu7DAchLf8AaDNupiwUysLHlIZfdY2Nw8tdB
 +XzsK7n27+Pty1UbcfoMH7X3QCmR+DWB1m/+csGnv9XXEPs88X0aTelGo
 W8UdKBj+U+YEvYZFOwb1HIPQm5IZbVYyPt5LMEOaXFQdkSkUMneBSQPaj
 df6PJaje56SOpN3C8mEEzPXNHAJJXGj0QpcCyRblZcBq8/BjxbMt+DqTL
 /P6G5K4b8dvfw+vHH5v+2RYw6HT+bYxUPITGGPPgfes1BrulCKRx6q9Ht
 lWLtVAiXbKfd5kZpS1iLijBGasmlCVMnigUXIJG7rVnJN9AHcYnPpi46D A==;
X-CSE-ConnectionGUID: bIU08OKQTbqICXBACkUW1A==
X-CSE-MsgGUID: nEj/x1ofRWquCLNDKOpKRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88926989"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88926989"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 17:54:39 -0700
X-CSE-ConnectionGUID: sVh9d0fYQzGGVJPOXXh/rQ==
X-CSE-MsgGUID: i3Aj68M8Q1+TrUcjwFUhPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298581772"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 17:54:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 17:54:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 17:54:38 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 17:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAThZfWR2CgmMRxGBxjIFLJR+s+4UbsuLSsD5r3+AAf+GfZvv3/fRQ0Zm3hljyZqQExcg6K1k0yUyrbZgoz5dOyMN6+/iNq4UW9IFJDDpB6xdtjq/9aHqj6DV/2eQxDn9FQy7T7zBIrNN89wBegkajPPlAjWE5VK7SaKSpMYa5yK8Z1J+3IXmdRi4U3y0caL1hd1rIE8Csq2I962haQtNMfvKjwxgbsRbz37z5iKLVzayDgzM+CMA+LtjfBedc0bz1jWf+yXi+OC7jC8YWwpJ5h85g5zjRk+iudOlXZLJn5x8kxo1jpeEcAxhp3tUjzTLqWllKcEF/VsMhQqSh/Fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Dy2Oh92vmzFIDoQHSmUzp8uqbW3M3kbO2kU3EUZQwk=;
 b=DKhJtTdSdHWDo6W/rUsrZu5uJhVXOBbHTkFAVm5mn9kjfaAKDGiFCA/DaffoykZPmvD52f/on+GxOPyawLM+Qe3m8nh7Y/uDGZ5HvTAalL4QF3vpaWRZdOp3Y0D/O0MYWQ3OXLR0qfSkYTeTihJ1M8sMEU4a4QxNNmf10QzHh8/oaAVY0mEUAyIKOHE2xqtB9FYv8vs1TzZYjM0kIg3hKKXQIRLhd7yiXp85lqoT6ql1g9JKfSMDl4h/37JN+rjvAw3YKpznUUziggucmYT/DUajD/AdS0gKXaBz7uCL8h6IuP39OUKsu5juD6QV5XHCvqvDdQ/nZqh4XpuJeRSPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 00:54:31 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 00:54:31 +0000
Date: Wed, 16 Sep 2026 20:54:27 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Nikula, 
 Jani" <jani.nikula@intel.com>, "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Message-ID: <aqs6Q9D_JywZ65-z@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
 <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
 <aqnL7lUojj9jm8q_@intel.com>
 <6f8deb9d5f07feae11f35363e8b22d5ae606e63d.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f8deb9d5f07feae11f35363e8b22d5ae606e63d.camel@intel.com>
X-ClientProxiedBy: BN9PR03CA0874.namprd03.prod.outlook.com
 (2603:10b6:408:13c::9) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 46608388-16b0-458b-1692-08df14563b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2gh4ZcJ0t/hMH21thmZvGH2FqC+KRhjHho/iTw44hDsf1w5MuGyrVjK9XXz9zOxbkJvmDNfUDz6dw1WvgsQuj4FSy4pESEvQcL7/ieBbfvK43YE+JopQ5wjRqDtkdLZcpNwAr6AmM3LgCAo0GaMElA41tXE2c90NCdXj1iycNaIm6TgoZPXSWe0aOYbmYbzaVcIaD59ilz7l1eJUqUK1q/BWE4MTxFba09rWUSkn4GM/Ur8Z34NrLwkPRhtv8yDSyH6qGk8HumTLXQ5nt1kGKw9AjCWE/WfBMZ+t600QuX6C5wRf7SSW3dG2lb5U+IMHuOOuTf2G1vfWUSCddF1gxSjgAD6+GjZ/nXh5VoHt8okHVLmO9T4uEhb/HoPfN42upRt2wpJTxJ4kVA3NTWhPn6AFzxaR9IP7hbqeu0z56fYJ21TQDBO7PWmpGoPPIVnwNLfuHoRI3n5oSy0socA2QwBW2yXGjQU7YhOrrIjqskHb+Z9IcwFtQ5S7+H7kh+cXYrq3ugMn9bDFCcl8uMWZDxkdPBoKfhORSWt2KASatAlbT8o1TzLWVdcdUR8g5BfksM9LzAWsYK/f+E6qJcsFiYffmPfDZNKFqZIf7rJ357ydctodX65OOF6y0RmKouZdhwqfmT7tVCMcAey2n3XDnKk7tHqgD0d4+Y63SMb0b+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0N2SEtLZ1lpUjhqTmdKTk0xWUprOE1ZU3VMazJxVkFFVzB2YnNGazFHQ3JF?=
 =?utf-8?B?ajU5MVJEd0YwSktjVldmWWlLNzdidFh2UitCb1FMblFNVlE2WCtvM1cxWGhF?=
 =?utf-8?B?aDg5Zkt1SjM3WEhCRTB5NFBzSWtna05ScVlMaU5LeDM3WlBpVEVPTGRKa21O?=
 =?utf-8?B?RFZUaHRSc2RTRzJaU1hwNFBPV29nSHZ1NHBobHRJNlNaajhDd1cya09KNmpR?=
 =?utf-8?B?TGFrbFFiWDZzNTVoMEUwZHhtOGQ3SjVpckJKQ2RKeU42SHFBR1J4VnNJdDRw?=
 =?utf-8?B?Z1dlMlBiTTlxWlgvUG1xUFJybkhIVVFtVUIrYVo1NWFMNGNlTFczSnZPR1Nn?=
 =?utf-8?B?N0gxalZITnprTHoxRE9IOFp4RHplSnhQZ3NLV29mYno4a1ZWR0E3bTFUTDZH?=
 =?utf-8?B?cEMzaEYwelpMSUVRSzMzeTVqZFRTSHZTd3huYWE0QW84aU1BaXdiY2ZvSTJE?=
 =?utf-8?B?TXY0WTNPTndscXNMYlpQN2NuOHB0ZEpXZndxMkZURms0aUVIZnpqNXJOeEEw?=
 =?utf-8?B?RW5tdlh2eFJ4MFBnMjFUdnVJTEpEOWhKcHB5Q2p0L2ZPYnYyOCtuODdSN3Z6?=
 =?utf-8?B?NTVIcDI1SC81eEI3VzF2TTJoMjRROHhuMDRINXVjVGxhdXEyMnY3V3dqR3Jn?=
 =?utf-8?B?TFJUM2VHckI2Mm9BdHRjbi9aZXdVZndGb3lsRzZ5Tmg4UzBnajV5QWR5MHhL?=
 =?utf-8?B?clEyWXpXL2hrK2lKQWg2MXZHOWVoZDRjbnY3eCs3bWRIcFJzOWI0R3cyWG9h?=
 =?utf-8?B?TlhnM1BsaEp2Q0Q4QkgxVXlaelRqMGZ4dGxMQWwrV1JiTmRGU1Y1Q1VreVRM?=
 =?utf-8?B?SUhlc3AyNVpJa1VyNElSSFVrY0prVGRDd3ZWYlVyWUE3YmNjdkxTYkJVb2Rv?=
 =?utf-8?B?U1FvM0VNbnlJT2dncTE2VHpvMnVBTEdrejJDWmcrYml4N0MvYlpVT2Q1Mml3?=
 =?utf-8?B?SlJVV04xb2p5T3hCKytFR3hnWFVFV3BpU2UzWkVsaHpYTmVkUTdSQllLS0Yr?=
 =?utf-8?B?VDRuWWg5UVU5YUNUMEFxWmY1elAxYitKZFpzK3VzOHBBVFkySE1NdHI0MVBi?=
 =?utf-8?B?MlQ2eisxT2dqWHo3V1ZRWERJQlkyeTRFYXZGUDRJaXhSZTVtdVgrVERDVXh3?=
 =?utf-8?B?T2NERU92YTE3ZG5vT0FlVW9kVnVwUVpMbUJwRW81azZQQ29wNGRrOThZb1Bv?=
 =?utf-8?B?M3NERXUzQzk1bnhiYWNib3R3TGdPQ3kxWVMvNXFtSDhyVi9OSFJLeVE4NGhD?=
 =?utf-8?B?ci9mVjAwdWtWZVVlZGpSZmtsamRxaytiMVB1ejZ4clJjbUp2eHhTeWtzU3hZ?=
 =?utf-8?B?aWkvdEpyYS9hMG1wQmd5aGwyQlB2RWdac2NKY3UxdEUrOHpaZkhLVFhUYnJE?=
 =?utf-8?B?SmdlNCs3a1VFWlNIclgrMGlFYzV3akhhM1g2TWJRY0NKbmFnc2FVUlRJQllB?=
 =?utf-8?B?TjdXR3ZwRUNRZHFNeitabFlQdnJoU3N3dk5aZ2toT2ovQXJVQnUyUHlxaEMx?=
 =?utf-8?B?YU9KaVVwUHBjN1VjcEEwcU91ZnJPMzBZQmtZL1JqR1Q5OVp6L20yb1NiS1dw?=
 =?utf-8?B?WkxhSkRFcVVHUEk2VUNHVHRVK1paTXYzdmlPZU92YkNoTzJ1WEtXNTl6TXVY?=
 =?utf-8?B?cEszSllhK1JkSmk5MitpRFpRK3hvNDRlTDVPN1A2WjZwN1EwWUhHQkxTTWFZ?=
 =?utf-8?B?NFVTSzRQeklGMEtFVmFCNWlLM0Z3a0JjNWY4WDM2YU5UcHlQcnpJcStwZ3ZP?=
 =?utf-8?B?cm1pdWFHbFI3ZXlSSlZhdlhHQVZybVJmdlFzdDh1RUxhenBSNCtGK1Z2SEVo?=
 =?utf-8?B?aE4vOStzNE9DUW9WTCtUWXpLd2tHU3BBeWMwcW9wUTlURjFXQ2k2eEoyaUNM?=
 =?utf-8?B?dTBFM0MwcjA2TWhFTjc1OVhWTWJ5bTVESklBa0xWdG1za2ovTnkwbWFwRE9k?=
 =?utf-8?B?UGV2QW15cmtpaXB1cXhJRHdMVFZPTjZ4OXJhQnBwbDBHYm16bnMwdjhVd3Fp?=
 =?utf-8?B?NlJmV2FYeXZGOTBZWWVGblJXR2lQTjJ4WEgvVDFFdTh2NEtGVzVyelJZeG5h?=
 =?utf-8?B?TCsyY0tWbFlQb2ZEKy84RHdZSUduYkV5cWdsVFFMOHVjVEFxYTNFa29qMkwx?=
 =?utf-8?B?WURQZEpTR0gwdzl3Y0oxLzRjaTh2d2orWE1JYzFOYzkrdXZJYkc3aytNaUZm?=
 =?utf-8?B?MHBkR1pxVHVERWw5V1E2Wmg4MUg4eXlNdm8wbFY1dnA5U082ajljZll0em0x?=
 =?utf-8?B?VjdxZDNCNEpWZ1VBeTRpVFdRakFVOEdlTjBsVGhQeEd3ZElLT2dkb21JcW5R?=
 =?utf-8?B?YWhrbDlJdWt6dmNMZlNScW52MEQrd0U5Wm5OSXZXakR5YjR2SCtYUT09?=
X-Exchange-RoutingPolicyChecked: ZgprCA38ns7EVAqXd1hSinYSOrWlnuFtt0/+ar0aXMyrWahPyR8exltpjrTMJAwTBHyz1XEpnJsvvc0A2zorBL4oeiHHqGdInuAajA8OmPp99r9XeDLoi2rCzjTZ6mLIFpnCZm6IUEc+HI01zSCBrW0vcf5RdS3O8Fps4tcZv/QAyDZTktf+SqopiF5qoJqVn2OGH7CqR+pqxOsO6HU16aA0ZMOPwe6ZJZnDcWuAIYbrjTJMe08BEm6LusS4zxDkwz2knziSsjrIsam8CXs9pFDp+qsKZHyEB6ri0qR845z5wphEfyOvg1rtePqb4Y8YQWVJkC0lQATu/jWXg5j7jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46608388-16b0-458b-1692-08df14563b66
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 00:54:30.9851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/uwSJhD+gzr0pPLbeK45ruPrT7ushZOn9TZdCZaiEOi6YQUBcvxjpi/cpupZ2zVGzGfsFXYtdxx58Tp0unf1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
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

On Wed, Sep 16, 2026 at 07:10:11PM +0000, Teres Alexis, Alan Previn wrote:
> On Tue, 2026-09-15 at 18:51 -0400, Vivi, Rodrigo wrote:
> > On Tue, Sep 15, 2026 at 04:00:54PM +0000, Teres Alexis, Alan Previn wrote:
> > > On Tue, 2026-09-15 at 10:34 +0300, Nikula, Jani wrote:
> > > > On Mon, 14 Sep 2026, Alan Previn <alan.previn.teres.alexis@intel.com> wrote:
> > > alan:snip
> > > > >  int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val, u32 timeout_us,
> > > > > -		   u32 *out_val, bool atomic)
> > > > > +		   u32 *out_val)
> > > > >  {
> > > > > -	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atomic, true);
> > > > > +	u32 read;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = poll_timeout_us(read = xe_mmio_read32(mmio, reg), (read & mask) == val,
> > > > > +			      10, timeout_us, false);
> > > > 
> > > > You probably do need to let the callers pass in the wait too. 10 us wait
> > > > with a long timeout is going to be pretty bad.
> > 
> > agreed
> > 
> > > > 
> > > > 
> > > alan: okay - perhaps i can make every caller pass in a polling-wait thats a fraction of their wait time.
> > > (as a starting point since i dont know what's the expected behavior of every caller).
> > > so perhaps something like "timeout_us << 4" (i.e. 1/16th) but pass in 10 us if its anything smaller than that
> > > (i.e. smaller than 16 usec).
> > 
> > I think we might be complicating this too much..
> > 
> > what about something simpler like:
> > 
> > #define XE_MMIO_WAIT_MAX_BACKOFF_US   1000
> > 
> > ...
> > -             wait <<= 1;
> > +             wait = min_t(s64, wait << 1, XE_MMIO_WAIT_MAX_BACKOFF_US);
> > 
> > 
> 
> alan: i dont understand your this comment on the increasing the "wait by x2" in the loop after agreeing with Jani on the earlier statement.

What I agreed with Jani was that a hardcoded 10us poll interval against
a 2s timeout is bad. That was all.

> Some historical context:
> 
>  1. current baseline code it stands to day IS in violation of linux rules for how to use those sleep/delay functions

right, and I believe that this single line change is enough to fix this
violation.

The problem is that we double wait every loop 10, 20, 40, 80 … 20480, 40960 and
never stops doubling. udelay() is only legal up to ~5000us (perhaps 1000?!),
so once the doubling passes that, we're breaking the rule.

Same on the sleeping side: it ends up asking usleep_range() to sleep 1.3 s,
which is not what that function is for.

The one line just stops the doubling at 1000us:

wait = min_t(s64, wait << 1, 1000);

After that, the wait can be 10, 20, 40 … up to 1000, and then it stays at
1000 forever. It can never reach 20480 or 1300000.

So the illegal value never gets passed to udelay() or usleep_range() — ever.

>  2. my initial revs on fixing this was to minimize the changes so its not complicated by simply fixing the code in place.

I believe this simple line alings with your v1, but just simpler.

>  3. Jani said we really should use the proper linux kernel helpers: poll_timeout_us / poll_timeout_us_atomic.
>  4. Those helpers have the "timeout_us" and the "intra-loop-wait-us" period. I hardcoded to 10 usec.
> 	- Jani said i should not hardcode and ensure all up-the-stack callers of the xe_mmio_wait32 function passes in the intra-wait-loop
> value. 
> 	- Then you (Rodrigo) agreed with his request but go on to propose going back to exponential 2x intra-wait-loop.
> 		- but that contradicts Jani's request u agreed to and also that means we implement the intra-wait-loop? (i.e. dont use the
> proper linux helper?)

sorry for not being clear on my previous response. Perhaps we have a cleaner
end code with the poll_timeout_us and poll_timeout_us_atomic indeed.

Then perhaps we have this single fixes patch and do other attempts in get
cleaner loops?

Thanks,
Rodrigo.

> 
>  ...alan
> 
> 
> > Also the Fixes tag is not the right one... the bug was there before...
> > 
> > > 
> > > ...alan
> 
