Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D421CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D577E10E6E3;
	Wed, 10 Jun 2026 03:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BGDkYfa4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C0610E6E0;
 Wed, 10 Jun 2026 03:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781063735; x=1812599735;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HTGXhtYUeSM3D5oQH9Xs/zU+9v3XPxo5PwnK3gZ6Vd4=;
 b=BGDkYfa4ox5A/6i4dNu6zXVzG0E0z+UfvEQR2+eIlSQrI/6hEftBEJi9
 vj4fcy1VAElTsXFZ1zQknRUvp9h6j0Ot1XrrvkF/i9vfNsUf0+vLz0MgM
 ilJtNEkrHAPDnIH5+UIqQEK/F2KpDAiWovm1IDNYEM/M7GDvNJI/m/k/0
 hjVs2jVq2rGLiIoLAPB1J18RD/pqk3A9VRL6fIxVDcigvzXnjMJQ67nNA
 udlsrwJLgfdRVnkEZX3uh9YA4mLk5rh0BlDtQ/uibZzecqX3By82lD0f+
 op6XZX9DnXnReYHNXw/wGhE0rWPv+eSaFlMxE4bWysx70IXyOTOYgM2rI g==;
X-CSE-ConnectionGUID: 699TYEXsSXWfjvOq39PrXQ==
X-CSE-MsgGUID: W0+J8WpARKi7Jzv5BsD8mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81824681"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81824681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 20:55:35 -0700
X-CSE-ConnectionGUID: LywtU4XPSw+QPDpl2zDyOQ==
X-CSE-MsgGUID: yFqb7W+4ShyAx+p/8fnv5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="276238399"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 20:55:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 20:55:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 20:55:34 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 20:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAZMtTi+iL2899rn+PLLyUCfWUB52IkMUUK3WEYWkqUPwiTuJ4eCv88LgjhexYX8LEVZbFey36jM1bIiFscsjE+LZePGTLwkL2EByPF51MXg555s3r04G/tdgrznESIO5ayMiPJzBnYNUxGFSqIHsMmoMW1WKBuIYhKMoJHlzsb0dCpvXmdKhckUb+KqlX3btdL2WTMJkwDYrMBQyckf06f3Exs5A4BXFbRzqboJ+6qkzUnb4ipXxrlUhMPnFabbWnRINZHHRHHn0AcJLzNjT1g0D0e4e/ZXbzRmgz8DtPiVQQJ/Rnx0HXFbx7zv3yN3WhIwQO7R5kJlGNKiK95lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XrobpT43QC7YbM3hmXJ6v5o4iyjiTzXDhDjAPssrzY=;
 b=mbKD+r/RLE4QCLrUkQYUNwfBScrhBM4T1NgD+RlDRyASQFGK95pdZ5ka7D4dOjSvbrr4gRqRHeI2r1zbZmeSBuptNtycgpodmG/hR+Tr8GalqF3aCeAu1oPzGno1kJm3Ay557KIBP5D/Ek7SrrAXSYr0C4jDe5zVz8i5jWM/BSg41UuJ0tYaOrHJU78tzNgKRc8sQ4mXbsxZWrIuKNdQUj0Sbjga2LWHFQBeGzoI/Odg/IzTCjnGQ0k3273ORtAtuuB6S2nw6kDLwp66GYRkwzDdCjiBuauGsSZ/DwCGhBsKCNttpigvccEjnMh7hV4QOKjJzlBV6maWnHdP5wP5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH3PPF179F31853.namprd11.prod.outlook.com (2603:10b6:518:1::d0b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 03:55:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 03:55:30 +0000
Date: Tue, 9 Jun 2026 20:55:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: Re: [RFC 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Message-ID: <aijgLr5HvqJcdYvz@gsse-cloud1.jf.intel.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603065620.2555316-2-honglei1.huang@amd.com>
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH3PPF179F31853:EE_
X-MS-Office365-Filtering-Correlation-Id: a52d8ba4-8387-4471-4996-08dec6a41d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ExZDCE3GaFfG/xAaxex4n4qkDkeCx6zJ1g2ggBlcQf3iFY/cpXFkjqKlOM5OoFsVqLLOV1biiIydqe2gyNMrM94PshfZ6Il30RDQAmwtc1vKfntqgzz5j2zTrwDFokCcFfpUmiush9wium0QIBXT5xanfxFeuC5Sq6ZrQx4rBZkMzSnMNHIly2qWgFpJ9OVL3nzlG4GjAP00FgksxiTNQm6xNqVfCUkryaGC6fcb8PC4W081YUFtWvHTYZysPDV8CRDFq91ZGEhetYGwrYWRHEJnx+A4sbPrW/Tnk+CkZzHh7siI+J+Mpg3GVTgutPxNKXEC9tRNxirPBRRs0/VW1r8Y/asZmmS4Kl7cuF8BryGE3/Vdmv2g9c2STWWy3MsVTLO4oSo63BzNpQiUsltzTE8R2nbzpBjVH88MCpYm8cgdtSVvlUynC1poiFYAwOgAjRxGH+KVuRwl41ZIFJklYajGLZtkguFTeBZuKTjh7YFLXCnlT/BOyk8nuIAUYaUXMe7vAnMiBE13ZK+JvchakpAsYxIVaAaggeOaPXAIai3soceyzILkvGuSJGXzE5a1CDKGO4ZBmf1eHaQbQiGgz4Nu6pKkxjI7a+euFJGg1D7++ZOO0tgCVxuhJu4SxEcLzg1pdLbBQcdgAVJaPyQlHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkpydm1CQTNGcFNTOEY0SCt2TGp2NUtadEFydC9TTm1rbzV4M1l2Uk1OWElj?=
 =?utf-8?B?STRidGQ5bmVOdFBVTkc3aDYrZ0w4NzlUZkQ5WlRvTzhwdVREbWRBekV5MzZq?=
 =?utf-8?B?eitEbXQ5M0xFQlh5UzhGTW5GanVlMVVMOHpGYk1QeE0raE9wOURFcENqODAy?=
 =?utf-8?B?UW9DdTY1bDYyNXBVeExERGpsQTh3RU41c3hjbDh2aTNQTEtQNk83MFpkY2FI?=
 =?utf-8?B?U2Jsam9uOG0vUWtyQ1lRc3ZRZzBURUZMRFk5bGY2L2RraGZGSHJTK3dHU3Rv?=
 =?utf-8?B?c1ErNHc1SVFrcTlMYWpDdGZaYU5IekpTYWNpeU55c2k3QzQ4dTI1Z1Y2RkVL?=
 =?utf-8?B?SDUxU3Q3VFRnTUYrTUg2bDlLVHdWRERoUXR2aTlTS0lYbDZrK051TEt0Zlg0?=
 =?utf-8?B?cGRJQVJuY0lPY1dlRkxNNXdjZ1hldFBONEEvY3pqaUQvdFNsVjljRVJ4Vkhw?=
 =?utf-8?B?MFJRNjU2RGlOaGZGSk9QU0FCc1hkeG1HNEtRYmVLQWNXNWlpV1VDTGdDbmkx?=
 =?utf-8?B?Z0JuZ05BbXIrTU5RNzJpejUrSVh1QWoxN1BCaVlsaVR2d0t6eEIwcEdLVW5X?=
 =?utf-8?B?eWFtYmdmeDlWZVdiK2pMaUhnUmZPaEllb1E4KzRCZncreW9QSFlnTlQ3U3lz?=
 =?utf-8?B?b1R5WmJhWmlPemhOdzNTWklxdUlrMkJuaVpnQk5ERmh4bk5lSTN1dERVQmVU?=
 =?utf-8?B?eGdNdVRoUElJc3RnQU1jWUwyQnA2YXFzaUZKNzQ1K3JVdGFIdVM3Q09jcE8w?=
 =?utf-8?B?TzNvNWFHQXRQMXZuQkQvQmZWQW1nWlNYeitvMTBveUJYbHUyVkZPemh0TWVM?=
 =?utf-8?B?UDhScy9MeE91bER5YXNhRTY5b2lKalpTbU00QVZ3bjNNVHYwYi91dEc4YWd2?=
 =?utf-8?B?SytkUlU1TWhIUENyWXN0cEw2T2tMSlMvbHNDZ25GbUJaZm9zelpoZzFTQWV4?=
 =?utf-8?B?RUcwR2RTNjhGK3VSYVlXTnBXT0pxaVlaRTFaTFBPeWU2Zkxhbmc1YlBveFhT?=
 =?utf-8?B?ZVB1cys1OTZjU20wZGI3KzRueC9BLzdhclV6dTVIWWpiOHpNWjB1dkI5Zkgz?=
 =?utf-8?B?NFpkNzFXOStVL1Rha1pVMXJtajZ3cmp3U1NQT2phVENjSTUyNzh0ZUZlT3hm?=
 =?utf-8?B?Q05HZjRDL2gwT3Z6ZE1TUjJWZklDREZCNG9hTVJBVjh2VW0zNHk2V1FLTmta?=
 =?utf-8?B?UFVSOVFjZEJRNUFnQTcxVWtidTlkZXBLUjhUT1BGeW1pQUx5QWo4WUthVDhn?=
 =?utf-8?B?UHBpcUl6eFZiZFlyWThPQU5vS3I2M05wZnAvMjZRZmZkZjVUSFBOQlNOc2ZE?=
 =?utf-8?B?a3QzcEYrSWJQR2ozaDZEZmloekhkMjczTmQyQVkrQ1c0STRHZ1k0VEpCL3Fq?=
 =?utf-8?B?QWRRZDI0WFlPOGZYbGFCK1FXd2prOWd1cWVOZ244SFZTa2V2UzV5MTJjQ0tS?=
 =?utf-8?B?clR2UW5FWWR3d3E1SThvaWNyMzFJcGpUSStzM094OVljU0FXOXh3bVlqQ2NB?=
 =?utf-8?B?NHFIbU1BYWhBM0tOemhjOG53SFRzNjJKUCtoQ2hoUW0rTGpFT053NUxibmtS?=
 =?utf-8?B?S0owc3VwUU5RczNsSDFYUVd2Q0xBQjVKMzNuZm9kaWFUUy8vS0ZVUUhxTmps?=
 =?utf-8?B?Z3oybDFoTXhUSmtKVkxsbEpHeFZnQXVuaDF0bVhuSlRBOVlJZW5WU0NvRlBO?=
 =?utf-8?B?R3dGamZiYkRVUUpROGRraThkc1orN2Rad0szaHFRN2g1VUhkSk1lZzYwMTh2?=
 =?utf-8?B?cTlhVG5mdEtWVnZTa3RuVEFnc3lpTU9KRmpZTk9OT09Gc09GQkVscmN4MUE3?=
 =?utf-8?B?a1dFU2NRWEtzZFJtMWp6V3lmSUJKdDBqUXMyQVlDdEpqcFJQME1qYnhhT054?=
 =?utf-8?B?VWxicURBSExNZHhadUFiOFkyVzB0c3BNSTFsMVdoRXhySTVmOEhObk9VVm5t?=
 =?utf-8?B?Y1ZjaHo3eThubDBiMU9wUnBFaGNpekNpZ3lOcWVYWDE4OGw1SDdRd2tZd2Iw?=
 =?utf-8?B?UmhzbHhZbWxQNDdCelp6VmlTWjNDc0FCeWRiWUhMakkxRS9kK29INlVrVWYr?=
 =?utf-8?B?OFhUajlRWXZaY1BGMmNaK2pMdWU4VnczbjhYN2xzb2M5OUVZNzlielBib2xS?=
 =?utf-8?B?QTFDVkRMV2ZMdmdEbHE4UHMxWjN1WlBUdnJ3cVVvOTdVRzZHYXI4eGlQWmxB?=
 =?utf-8?B?T1dtanVpY1ZPemRjR3pxZ3d3Y0Z2TmJpOURFWVhXcWhBaFZDcEhkeU1LZEM4?=
 =?utf-8?B?L3FNYTBMbkI2Ymd2YnJDcnhwMFNiV0tKT3dKT1RVZGlhVWdhRDR6NXVRODZX?=
 =?utf-8?B?MFBGN2xlL01odUh1UU9zNjFzK1dZdlNoSktlRWhuWU5nNmJuNmltZz09?=
X-Exchange-RoutingPolicyChecked: jYM94zfPSJ9WGv5ANGCv0KxoA7pxhCDTOKuz5lVVYd4RGJB3/US8zPGUMVCOBUZGspoXU9IZ+GAQsyO00mmgnllyqkFhVxxZsgqrXxVGtNpeCmho0moCQayC5oXM+3k0c8Co8UlWrUqbiicMFiDLzfe9aa9yC1MDujX4F0PxY/TjjcfTGrLdZBeUdYMVtLsHZe3vlfPKqfzd9KL2XUGjC7K73blZZXGmerszeAyDbNZJqIVCecSYDYSQty9Xv6WQnOMrywsPtO50cVWEaDDu97nZGzC4ogFgB/TKgz+lahCkQ6R/T7tECbj9TF1w76imDlcKskcIizgy6DYHcdV0pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a52d8ba4-8387-4471-4996-08dec6a41d44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:55:30.2942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uu28JAeTkj/G+ffeopgoCTl1FjHE0YmlK5siB/AwGMDipfFshOOkylsppfJpQ25+xukA6ydhTDz0iii56s+bog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF179F31853
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

On Wed, Jun 03, 2026 at 02:56:16PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> drm_gpusvm_pages_flags currently mixes two status:
>   - MM / virtual-address state: whether the range has been (partially)
>     unmapped by the Linux MM, these follow the lifetime of the VMA and
>     are a single per VA range fact.
>   - Device mapping state: has_devmem_pages and has_dma_mapping,
>     which describe the current page mapping status held by device
>     itself.
> 
> Keeping both on the pages object blurs the semantics of the
> abstraction of pages and VA range. So move the MM state falgs onto the
> range, and keep drm_gpusvm_pages_flags strictly for mapping state.
> 
>   - Introduce drm_gpusvm_range_flags { migrate_devmem, unmapped,
>     partial_unmap } on drm_gpusvm_range.
>   - Shrink drm_gpusvm_pages_flags to just has_devmem_pages and
>     has_dma_mapping.
> 
> Side effect: drivers now need to check unmap flages in driver it self
> to avoid handling the unmapped pages.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 11 +++--------
>  drivers/gpu/drm/xe/xe_svm.c  | 11 +++++++----
>  include/drm/drm_gpusvm.h     | 28 +++++++++++++++++++++-------
>  3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aed..6000d587cf2 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -641,7 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>  	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>  	INIT_LIST_HEAD(&range->entry);
>  	range->pages.notifier_seq = LONG_MAX;
> -	range->pages.flags.migrate_devmem = migrate_devmem ? 1 : 0;
> +	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>  
>  	return range;
>  }
> @@ -1470,11 +1470,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	drm_gpusvm_notifier_lock(gpusvm);
>  
>  	flags.__flags = svm_pages->flags.__flags;
> -	if (flags.unmapped) {
> -		drm_gpusvm_notifier_unlock(gpusvm);
> -		err = -EFAULT;
> -		goto err_free;
> -	}
>  
>  	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
>  		drm_gpusvm_notifier_unlock(gpusvm);
> @@ -1794,10 +1789,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>  {
>  	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
>  
> -	range->pages.flags.unmapped = true;
> +	range->flags.unmapped = true;
>  	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>  	    drm_gpusvm_range_end(range) > mmu_range->end)
> -		range->pages.flags.partial_unmap = true;
> +		range->flags.partial_unmap = true;
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
>  
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index e1651e70c8f..3acfddb7c5b 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -166,7 +166,7 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
>  	range_debug(range, "NOTIFIER");
>  
>  	/* Skip if already unmapped or if no binding exist */
> -	if (range->base.pages.flags.unmapped || !range->tile_present)
> +	if (range->base.flags.unmapped || !range->tile_present)
>  		return 0;
>  
>  	range_debug(range, "NOTIFIER - EXECUTE");
> @@ -1136,7 +1136,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>  	struct xe_vm *vm = range_to_vm(&range->base);
>  	u64 range_size = xe_svm_range_size(range);
>  
> -	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
> +	if (!range->base.flags.migrate_devmem || !dpagemap)
>  		return false;
>  
>  	xe_assert(vm->xe, IS_DGFX(vm->xe));
> @@ -1248,7 +1248,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  
>  	xe_svm_range_fault_count_stats_incr(gt, range);
>  
> -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
> +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
>  		err = -EACCES;
>  		goto out;
>  	}
> @@ -1507,6 +1507,9 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>  {
>  	int err = 0;
>  
> +	if (READ_ONCE(range->base.flags.unmapped))
> +		return -EFAULT;
> +

This is the compile error I encountered when I pulled the code—READ_ONCE
isn’t valid for bitfields.

Beyond that, there is a reason why unmapped was checked in get_pages()
under the notifier lock: it’s the only way to ensure that the pages
being mapped are valid at the time of mapping, or to determine whether
get_pages() should abort. The HMM locking documentation [1] (sort of)
describes this in some detail.

Since this didn’t compile and exposed the bug, I put together a quick
fix here [2]. The basic idea is to mirror unmapped in the page flags and
update drm_gpusvm_range_set_unmapped() to accept an array of pages,
updating the unmapped flags in those pages as well. This also allows us
to retain the unmapped check in get_pages() under the notifier lock.

I’m not sure how you plan to store the pages in the AMD driver, but if
it’s an array, this approach should work for you. Let me know what you
think.

Matt

[1] https://elixir.bootlin.com/linux/v7.0.11/source/Documentation/mm/hmm.rst#L193
[2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177

>  	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
>  	if (err == -EOPNOTSUPP) {
>  		range_debug(range, "PAGE FAULT - EVICT PAGES");
> @@ -1623,7 +1626,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
>  	int err, retries = 1;
>  	bool write_locked = false;
>  
> -	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrate_devmem);
> +	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devmem);
>  	range_debug(range, "ALLOCATE VRAM");
>  
>  	migration_state = drm_gpusvm_scan_mm(&range->base,
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 8a4d7134a9a..3dba4b9516f 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -109,9 +109,6 @@ struct drm_gpusvm_notifier {
>  /**
>   * struct drm_gpusvm_pages_flags - Structure representing a GPU SVM pages flags
>   *
> - * @migrate_devmem: Flag indicating whether the pages can be migrated to device memory
> - * @unmapped: Flag indicating if the pages has been unmapped
> - * @partial_unmap: Flag indicating if the pages has been partially unmapped
>   * @has_devmem_pages: Flag indicating if the pages has devmem pages
>   * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
>   * @__flags: Flags for pages in u16 form (used for READ_ONCE)
> @@ -119,11 +116,7 @@ struct drm_gpusvm_notifier {
>  struct drm_gpusvm_pages_flags {
>  	union {
>  		struct {
> -			/* All flags below must be set upon creation */
> -			u16 migrate_devmem : 1;
>  			/* All flags below must be set / cleared under notifier lock */
> -			u16 unmapped : 1;
> -			u16 partial_unmap : 1;
>  			u16 has_devmem_pages : 1;
>  			u16 has_dma_mapping : 1;
>  		};
> @@ -151,6 +144,25 @@ struct drm_gpusvm_pages {
>  	struct drm_gpusvm_pages_flags flags;
>  };
>  
> +/**
> + * struct drm_gpusvm_range_flags - Range-level GPU SVM flags
> + *
> + * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
> + * @unmapped: Flag indicating if the range has been unmapped
> + * @partial_unmap: Flag indicating if the range has been partially unmapped
> + * @__flags: All flags in u16 form (used for READ_ONCE)
> + */
> +struct drm_gpusvm_range_flags {
> +	union {
> +		struct {
> +			u16 migrate_devmem	: 1;
> +			u16 unmapped		: 1;
> +			u16 partial_unmap	: 1;
> +		};
> +		u16 __flags;
> +	};
> +};
> +
>  /**
>   * struct drm_gpusvm_range - Structure representing a GPU SVM range
>   *
> @@ -160,6 +172,7 @@ struct drm_gpusvm_pages {
>   * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>   * @entry: List entry to fast interval tree traversal
>   * @pages: The pages for this range.
> + * @flags: Flags for range see &struct drm_gpusvm_range_flags
>   *
>   * This structure represents a GPU SVM range used for tracking memory ranges
>   * mapped in a DRM device.
> @@ -171,6 +184,7 @@ struct drm_gpusvm_range {
>  	struct interval_tree_node itree;
>  	struct list_head entry;
>  	struct drm_gpusvm_pages pages;
> +	struct drm_gpusvm_range_flags flags;
>  };
>  
>  /**
> -- 
> 2.34.1
> 
