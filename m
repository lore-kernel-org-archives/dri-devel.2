Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HG1WLzBZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C2510E7DB;
	Fri, 27 Nov 2026 18:41:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F52410E622;
 Fri, 27 Nov 2026 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795804888; x=1827340888;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ed4veqq8JGPo38e0zn/TVKlIXUidjkeHc8+2avNHoGw=;
 b=HG1WLzBZ8zL6hIgC/iMutxZ9i4lIiTcsN3/6O8QP9t+Z/I8guDutXhtl
 /DZ2U5wRwDQ2zI/2R873w9it5bPYdlLy4WCJRVuRyDlYSZ38gZcu1PQXN
 O/+Igb7r3lOYVXWl67c8LTE35hT0L73OOEWGT/VHdq4IX8OXScIAMv+2O
 ixPVdSOJxna/UaYivovJZqU+F6INZJe1FT3A/PSQVw7dHPovo4y5mSMIN
 +J0LiQeblzyuxZHB1EwN7U1VCq6cm1sQmx3ygaYD/PkhXyBPxq8wpkuXu
 B+bxLQIkgGcHQNSh1y5lJaocL/YkZP9bzDiAAJn0gxqK4kr1N1aW2dqs+ g==;
X-CSE-ConnectionGUID: zW+ze/c0Qxy+0maKqde8rA==
X-CSE-MsgGUID: 4Pmy+lnnQq610n3WxhbOKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4573676"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4573676"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:41:28 -0800
X-CSE-ConnectionGUID: j579AVAVTieJqPZy7PS5Qw==
X-CSE-MsgGUID: g7ONQ5iLSKCMPNGx0wxSLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12234043"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:41:27 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:41:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:41:26 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:41:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K13yStv3fv86q4REjPA0Y2UvN73yU0W5obLWSvpsvyMPoywMF3R5h6ZtGaRpMutZW9GtfXPgaQwBBihrx+W/g8jY3AqRX4iRzZMKuXlZjfXKwt1k571fIHh4beswcxxgNVL6kRd9oJxLP9p+tjy+qC3pPbnbbEKoSY7WYAtfZ+Vs+CB74ReMB9XlKSBzIwLUbA2wkUJ6hSkiIQVXy2iD8uuMoUxav7cxlyzP1hsPy/qmTmj7XlmkJDZc9dxGlY4n1pJjo7VyteeFYbL+PHVxYYh7tXrPD5/ITt1Phma6dtQZfkteifMMoO0SxSszWFDJMlxvlD8YFl/OrJwe29v3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHfdh9CU6xtHwtJhGZ1EyeJmASE2HXc+sZpJl3XAMgk=;
 b=ypnPLHZFCOWnqQIwKMjGXLWH9WKhjSGtRBTyMjZf62fJiqRJLgrUDHRM+qLOU3ucWmOUrf5zikiELTLcagjoF+yH7zp4o5+UCeo9POrxL7zNlNWCrn0bCEvsoBGp3Dhu4qqOxD9bXE7iRv7+U5eEOlXbcWqo6Vp/ABJyFYfjh4lyDzlXows5aSovC1Fi/ohJx5LtBJtv7KtALKCHxkaI0k72uH6L5t8RXGlFQ/yD+K0Wm6plFQ1Guz/0HrQAh0HCqxfTBolWWaZHGOQRW/9rI4bugfbsk+fnCXAHLad8ww2Ckx2M70xjf7wAhXcrcEkojW3mRVpb5Fa1tOd2DmDmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:41:22 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:41:21 +0000
Date: Fri, 27 Nov 2026 13:41:18 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v6 1/3] drm/ras: Check the node type in node lookups
Message-ID: <awnOzncCb2GwQ178@intel.com>
References: <20261127181750.806528-5-rodrigo.vivi@intel.com>
 <20261127181750.806528-6-rodrigo.vivi@intel.com>
 <sashiko-outbox-238067@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-238067@kernel.org>
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::33) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|LV8PR11MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 1669660e-eac7-4f0e-c23b-08df4cb60808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|11063799006|261009223027099003|18002099003|22082099003|10067099003|56012099006|261026140227099003|261028144727099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: zNljPtgxmVhQfvtI11A0RtpOINH3S+vajP8k8eqBZaqsd6AiV5h16780LFpgrCQ2G5MLiM+Se+25TueaB0IQlKnY5NgBS93I5YDmMrEVs+cgBLx4op7iF6G3aXk1ITzL2zQfUqxdr9wJEXKAvUBl0vokxdlV8MdegOo8nw+cjkgai4sABcbuwaCl0gE0z8+UBE75b+GqbosBU78IretdG7w9cnX7JoGgrEaBlmBBtU2d/Tjx3uQJBw05SLFrhN7shpO6ssra7iKI2x5gigjJIaqUOn984cLomjxaUs+rHgFaDJzwrRYZ6narhFw3RxhviqJixUKzXuWGgFEDann2tuZBHo/qs/bs8p9gfpDFita6G9YDkKwNGkQ2kCg0jkxKJja4f4J0ZDBUUJ5TBrzvHxoOAVYT6r2nPA4uSLsI3/RvV6sD9xhFbAfEATuAmrsuiGi691kRWm58Ix32cVnCdG8b5I4gx9NUEJ4XpP8hlxFA+HuMVlAKlP5LqipyYiPHTvkRDYxIdJKApR2HpvPG1BP9fiaFQx9fhjYz85rZscBUpfF+W+O8L8WXPM9qdXvQmz85vx4gOoio941bCeNVJaFazwL+iM4MyDLwnbazHUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?R/H4fQ4DHZl25rqRQlGFZDXxDDipq1pBIYX4fGjzYxmgRDT5E0dQbCZlHM?=
 =?iso-8859-1?Q?ZZRGPBdML0Aj1e7HY6yD/VW8Ch28QJUqejpF7dWHIOJ8AEUA1YgBoWpZyL?=
 =?iso-8859-1?Q?5Gr9g0gjyuGyaryeYG0oRAUJw8/yjXHzA7Z+vm6jmM0yJsEytyIlvqF44B?=
 =?iso-8859-1?Q?kcsmocBE+H/j8VuchF7jtNm74X1q0/3acDwAYT0KLr6Tqrna22tkSGo8OR?=
 =?iso-8859-1?Q?1MzKxr2oIo2wyumrfU3NPfAZwU49j+0BH86jwqao6V6bQ2nB3RO9MIIZNk?=
 =?iso-8859-1?Q?HuJC4nK8vXEaza+453rhSOegR8P5PClGQAVvH9wZn11LMnST5wtjLpIo89?=
 =?iso-8859-1?Q?R0RwZ3e3txhN64Pg6u3hCIjV0ueFoDN4BmYuxNgSfZMCgU3DZT/vGJISYc?=
 =?iso-8859-1?Q?HY0weWxhVzwtT5yQinr98SGD0WDLS5JHxQpUOMde7D1XwArJ0jDWkxB0Cm?=
 =?iso-8859-1?Q?68w76uAwpbjGB66zpfoWKZ659kRNON8e9Qzzj+RrgpgAFLQf+fHPGiT9yy?=
 =?iso-8859-1?Q?HsnKHTeikETW+3Tiw+6Ak/zggNFkHLariuBeeZX/idMPsx60mzGzEsHtU6?=
 =?iso-8859-1?Q?FG+4Pw94Zro65B0/slS2Xda3AavOrRKfc1tQDzIMrrIteD7lboDzNZXY/P?=
 =?iso-8859-1?Q?OyN61hiTIH8DkWNZ+mru/PSoGJWycJqY1jEHHFMkay1kmilO7MMZ8hzuhN?=
 =?iso-8859-1?Q?8dOXI7kwjkHBdnGJd6catM7HciqnNjCr3ODOemvDZ/iJNwfuoEJazQSCmp?=
 =?iso-8859-1?Q?tfjoUZSxg3cTsgs3HfVZjIDSN4wo42Haenj+y/DiE8q4h5oR4HknQAF+wb?=
 =?iso-8859-1?Q?usDHanFVkwnTPOvP989xyNWFnIVlov+NKylHANkcKKdh26L9J6tiruGEHr?=
 =?iso-8859-1?Q?oXIEVIu2ekZc5LrRz77lfls8qjEdTfLTDv1ba1ysTthrPzF2g0smamibex?=
 =?iso-8859-1?Q?B6EoXGB9MQrLMMcisgRccdO76IjkgJULWyjawOGCYkv6Vi3TDhpr7AuwPn?=
 =?iso-8859-1?Q?VgHiTj8VUBLjB1otRYol0SjDw7rqJUN4B9iby6Mmj56/DwB6s3fDF32kAi?=
 =?iso-8859-1?Q?p9ITwY0rROI29w245Stp5iieNZFB3YSxxKe/0TSu3k1Y0EHbnS/zqJZZDz?=
 =?iso-8859-1?Q?qUwFai4caoEQeRvHpqVfYWvnGmX6NX4zLFLxkmJjfQhKoifancd9krdobd?=
 =?iso-8859-1?Q?oYD1A5jcgLulkntA5gAPzyFZatcw0T/AEVKxvsfym4V8UoeYyhJBpc+TZa?=
 =?iso-8859-1?Q?KHJuTymSKnF73Hz8OPfMxvWfhmOebUtho1Ksjq6SRn/o/gjZ+fsoPlVe3O?=
 =?iso-8859-1?Q?Ls3SqheeuAg6dYaVLNp2GqQBtXRjJQ2GyTLQZdPMEl+b1PvRo8GxzqGnOy?=
 =?iso-8859-1?Q?bLGEkIgrGskprPzY+XmIhpH/95WIGjJrDw/K4k34KvDtjry2Fg9VX2xJ0G?=
 =?iso-8859-1?Q?Op1OdZ4gO5rIIx4g7gxhPfrP9HgTGQv8OD29lJTq+1zm8YN6J/T/Vn4+id?=
 =?iso-8859-1?Q?OcRSOn2Yfk+4od2JQkmyfxKcBfsf8jKun8XtM154evdkxLeyu4jbFieb7E?=
 =?iso-8859-1?Q?Yvwj7m/ageDlwgSpx8M48U+9y76O08FtQZRJO+CHXwZXyOfIqZK7Bacskc?=
 =?iso-8859-1?Q?7h9TVaq5INy4HdaHxZUIM1NUQ24F/Bu9LbkTDosHoiZS0XcwQLXguAElvm?=
 =?iso-8859-1?Q?6lelKRJr+6INNsx6VFM+epC2BuWUigY7IO80XwX/Li4dpeySyhiRdyM39m?=
 =?iso-8859-1?Q?h0orT4dEd4DISxApYG1SK4J3xD8Z8FYNBYYHFgzDxuIc1VNJcfH4GCzAhJ?=
 =?iso-8859-1?Q?p+pgO1Mwng=3D=3D?=
X-Exchange-RoutingPolicyChecked: jLsM7K/kD6kt9Z5LGY4wNI5xeoRMwI2OKPzw23qm+nDZ2QL31D9u+xqK46xqa2HvXEP/2ZyYCOnXUw/L4gHz3SAFdrznyLravayooU6gtrNNlmCMzS4kjCriVYbUSnr5vsuvFSZFixybeBoZ87F9xKRAcpJIQ6B95lvZqdf4NGe9RBbLf+Fdc50EukBCjBR4SiEaLaA1BecQtvXDw4B9Hudif1oIXM5JWVc1Ts0tQ8GlkfRHCUoxLLPeQ+WEVlOcvnIHUNNdqKM2P4nQrJVjBx9Ukf64oLAaxv4aYvCgy/hFr07u1kubdv39kfwib6jRJgwvWWaAkl6wW3i+sKeoLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1669660e-eac7-4f0e-c23b-08df4cb60808
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:41:21.4052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHwOUFbz8AaAGB+9PMvhs412SCvUBq0037v8FfGCm0aL6hqTi3ZiD+zP1Jt0xoZBBfIEIrgm8rycAIulNoRRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 06:24:46PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/ras: missing Fixes trailer for node type check in
>   drm_ras_node_get()

addressed.

> --
> 
> commit 9258f81bad25ef1d7e2f5db2a77f4c65a38c081f
> Author: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> > drm/ras: Check the node type in node lookups
> >
> > drm_ras_node_get() returns a node of any type. The telemetry handlers
> > check the type themselves, but the error-counter ones do not, so an
> > error-counter operation on a telemetry node fails with -EOPNOTSUPP or
> > walks its empty counter range, instead of reporting -ENOENT.
> >
> > Pass the expected type to drm_ras_node_get(), so a node of another
> > type is not found, and drop the type checks of the telemetry handlers.
> >
> > Suggested-by: Riana Tauro <riana.tauro@intel.com>
> > Acked-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> [Severity: Low]
> Since commit c95c93b6e26c ("drm/drm_ras: Extend DRM RAS interface to
> include telemetry nodes") allowed telemetry nodes in drm_ras_xa without
> checking node->type in the error-counter handlers, should this include a
> Fixes tag?
> 
>   Fixes: c95c93b6e26c ("drm/drm_ras: Extend DRM RAS interface to include telemetry nodes")

b4-shazam shall pick this directly, but anyway already added to my copy of the
patches if I resend/respin is needed:

https://github.com/rodrigovivi/linux/commits/xe-ras-retired-pages-v6

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261127181750.806528-5-rodrigo.vivi@intel.com?part=1
