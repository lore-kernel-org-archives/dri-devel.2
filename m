Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A0606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HYngZODA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7069010E00C;
	Sat,  7 Nov 2026 05:12:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F8410E00C;
 Sat,  7 Nov 2026 05:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794028373; x=1825564373;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=XAWmGFUXXiP3pC8tADj/wHMdstecJIKe0txhMXoJ1Ro=;
 b=HYngZODAFvD9bViKe1q7RGO22O/ppH+wBZkdLg1DxCpkKZikuC/HJCMD
 jPHHxavnOXZiQ7Cle8fdoi1TgKOcOJDxcMmh6DvkLTWgtON7yHXcD3MXE
 IqglodvptjAe5BxivsR1G4jKt7HvANv1fIjmdXWLvyfFyNeMOwn4bTDKt
 kT9AIb4zUKiQtSUHGgsUGJbHzCDQf/B/48hNHDutNZx5a2PE7JJh398jx
 1mSqYkxoHS32XVNyYA9Ndf4Pl7Owrz761P4VgUBAPQNrOUHxprtMIkKDB
 8tVoYqktdHfA0B7Su9Mpws2dnZjicWoKXCXi5W7W4fk4F6ElKuFQWiwhT A==;
X-CSE-ConnectionGUID: 2pd3bzzCRsi9xwEGxH3GbQ==
X-CSE-MsgGUID: YYaZXSGkSiqPEOFw4AH2hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2741691"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2741691"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:12:52 -0800
X-CSE-ConnectionGUID: W6VbIZraThihWmoDvkPe9g==
X-CSE-MsgGUID: DXAEMD6JStSESjm6zTE7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7763798"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:12:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:12:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 21:12:52 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:12:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQVtszOVjO2ALdj2Wn6V0c75b1yMMFGaH5iozjOD40jhOWgDz8x6EEmxcnyc+sMgnYI2/wSHaqw9t2TEQXklP3+/3dJ/ObtcX1bIC4e/FF+v7Y55Tj+zIOuF7/7yfkU4AL3jM2GaEVekx/XaYbHd2EzjR/Kgvd8556zPNPmJmK9ah1dZXpxbmMhSMH2vUOQlGlLqXlQtwThCjInmHcQGrDCRtOsCTJCxxXtIgaYmvKgrqEHWoynm+TV/jiFPHvnCt3ARaYCW+wL27ZankJRQR4t3pyKPq+j+G6z+O4+M5/7un1TMuWECp6NmoD9B7VqSP10Opf3YWx4DUqx1uYKhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHVaQaoq3ycvFhh2LfIp0eKo5SboudoZ1cKv1IsF0Ps=;
 b=xke1m+FkwNSZiuc+wDVdEsW1wpL8qVJEp9VNXA0EfqTsMVQM+Yrt1KgRlIZyH0EqG+DY9QlP4BDbCfonwFwkyk0C/QApbhKpmBey9Imevqt9IfiG2jbQHhr2x0wqtBOuzwZBYKkpEUOYopo45Ar/K/ZiKCb9KM1DTWMdO+oumPbHK0UIPgNIfJylRT077YLskRsV0boLcWi+OIzl7sNK3B8COffxhapt0WxDEXO9mH12+kdA6Lbuy9h11gmcvx1bsk9lOel4qwaDkAd9UZJxaNJ+kQGZHrK8VoAqNcGhcrimhyKlQKMWVWoamzrlYLRNxOhQ5UhYtl9sAomTq3cJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SA1PR11MB529852.namprd11.prod.outlook.com (2603:10b6:806:51a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 05:12:49 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 05:12:48 +0000
Date: Fri, 6 Nov 2026 21:12:46 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 18/33] drm/xe: Handle defrag moves in xe_bo_move()
Message-ID: <au6zTq7ophThShBO@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-19-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-19-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SA1PR11MB529852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8b0b64-6360-4cb9-c02e-08df3c8dc3df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|261021121427099003|261021123027099003|10067099003|261009223027099003|56012099006|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: U/nTicRNooei0nf+c6TDNWM5PcfoH16b4gRwoZIlKEmYWFTfH83zJMx6Eo+ZJuo2kmiAd78ZqLF/Mr7JTu6tb2tbOP8UDEmkkA80VasNEN3n4FlTdVWEjOekNGoQb8rR1PiQpZR8RqVZFJhIpUEXZ1Yh5pArNquTRw6qOHZQrhTSx7mqVPK6PRg7PGUNnbwGY4txqKmjL1fPnTSgdDdoJNN+jGXVjDIGla2muUyUxscPuygECqKpaRUygi2A9BhAGcPzVttf9xEi9F09ESDbZ5qXj8I55UE8O697+5H/uNIEBKrzVfsUxIYxyrqel8e7JiwlMh9csbUbcr7zNKTSS48HklgYplcO8R7ekDVq/TZuAXdveQDE/dbMhEtn4weWpYEa7T+g1W5yX5RZ42J+OPxQeiPJHa9xKg4zO34+pUQGdbDC5yaBKvRxDPul4R3fZgJCiVWCa1ZHEg6SGFSkLiCNEgOO/K9Zfi7kEasSLbZAsSgjSJFaoB6ACEfBTsdfEGePCA4C4wKYGmehHG88hwMk6GjVkiGfpT+N1HjVOxhfbTPynIc9cZx3bHKJa0jYLHbDc4j4h0oyC6tF/E4jalnFb+q6u0SC92B1Pri4EnOwnylZev0HCA5eXrWYShuxhVx8J1m8K+9WwvuswU46ivLh7j5II7budcdOXdnO2h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(56012099006)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vUWLcclt5Y22ku+us13psJeyGBmlKeGI0wL8eDRMr3sUstOu+FYWz+FbuQ?=
 =?iso-8859-1?Q?+viO3BhtLPDy/vr/eRQRCpJYQwlBFa0ZU/uT7bBg9mdQNON1Mb/gsZ98ZY?=
 =?iso-8859-1?Q?heK5w8yS4pa+dL/s2DTOHjxZU6/ivSk8HESrRorPO7hu8rAvj8tKMqkkfT?=
 =?iso-8859-1?Q?gFnNyy1dk1z5CQ4Mqx4D/FfSCk+Ct9OkkVU328IiDJe4Uu/TW/uMLHVgZn?=
 =?iso-8859-1?Q?Md83j1KqrQ92ECpeVl4gHbChUhav+B7+S71FzS1KBorLq2O/19pZ39f3JB?=
 =?iso-8859-1?Q?NYnkrm+Zw1aKINDKzuvkqppLKSsyIUSwSXqjlvKb1EVnG2pul6k/aPIwN5?=
 =?iso-8859-1?Q?Y0nRBIQHOwdN87kJrprlopV0Ah6ZnPa3cc+84xqspCyz3BLxf00v10MDrZ?=
 =?iso-8859-1?Q?0+eyoAcb3yxHpXRlkWvFqcjayLO1wqDuSCDOiEh6qO8o2PXyjIGNvPlrG3?=
 =?iso-8859-1?Q?wJsHUkAXg5Ksi8bqfK2a5Q/zlh74+VW0eT+bV9bNobn/82IjXCUywyQYjL?=
 =?iso-8859-1?Q?AWpNf1chWPcwluKI/6avkB9rAjL8Rrkq4FD7t9fsDYeIegHFYQ72ScJTHZ?=
 =?iso-8859-1?Q?lKma/wiNHlvPEf7Ojf9hvluPmOrxCb15FPk0B0UMjwODNZwoT9ieAqXmcx?=
 =?iso-8859-1?Q?5z4/DTuS0Ba3FyuwvA4XAxkujtY6DL26wx3rk2liLGV68kt8E+a+XWHTmu?=
 =?iso-8859-1?Q?dmkrrPCzyEtW/3yJhihA8qDyFZqtujUR3fSV3nEgI4q5U4SFtD5o885Xzo?=
 =?iso-8859-1?Q?OjKP9Gz/l16kFg0nps0JOigNPMpu7qXYU96or1oZ5EGIyZBbd0xkxCgaGL?=
 =?iso-8859-1?Q?Ltr4dccGvKa4Drgpz2FSabaZJrWQ3zXI7+2HtaoPhBZAJyG/tRYdUwN30d?=
 =?iso-8859-1?Q?t8hMsLkFQNqJsMlVyUH6ENWc/qvhUNhgasRi/YH6+JZdQKk9B0ks/QTBH3?=
 =?iso-8859-1?Q?BWoD2Fw68yWIsHBWkDsGQfst0/Hmo1u8yHEZXhNZnxEALsfrTUzMNJrl+/?=
 =?iso-8859-1?Q?QrFHyyU9jO5eXghaUXb/h+S/m8sJTDCFFVGHLx1ouEaQPlL7EoMdH+mjO4?=
 =?iso-8859-1?Q?NV/V3/mYaStfE4V+lO4XNzyHwB5Xb8y8rFH7dtvMIUZ6emLIWa0A1bfcVY?=
 =?iso-8859-1?Q?9yPyx8sEy/lJpaeUk9dO9DLmd6eK4JSeO2aKuVy00C5wNbJr61k33T+i34?=
 =?iso-8859-1?Q?jmr7BcBg+sU6jB+m9nBRNlQPDtDuARQbrgtZpem1zIJdAuOoEDi8eU8J0A?=
 =?iso-8859-1?Q?ZinupGrpnMxzO9nuoPEoeUxky/j3C/GgkQvRT/U6NgxpouXwEnp/ZrrMds?=
 =?iso-8859-1?Q?OdKCaSXxYecIA8n5oLvk3tuSELKW6sDffLIHobIb1ZQkess/h1DWvzjuA6?=
 =?iso-8859-1?Q?BRx9KRVq6XKEqmbspMGYKuRrB5lrI+LyY69sli0UnLDTOmAmyn/m3ynE+J?=
 =?iso-8859-1?Q?H6s6vJM7FGK2dIV4jFlSiVEJM/bJijS0H2l8UJ51MbJ10UuofGt0RXzLl3?=
 =?iso-8859-1?Q?8KAE3ik7tv69f5ZP4ovmEvcAOFlYEu9Thd+p36Di3YSsUa4fb3H6A8wQ0x?=
 =?iso-8859-1?Q?FsPLaoi+LNrS8pduPAS5jqnhM5ep8EZH+j0gE69ziU8u6wHK7/RZKIt/D5?=
 =?iso-8859-1?Q?k4ddSkf3EEK1q1Sz+SfuVu83FpvCPk1ZEj1c71v9t5ShG04/bJi20VWJtP?=
 =?iso-8859-1?Q?pdrpGvTmyzqpQfZR0utu+xD+pPOG0LsBIzGDc7noku09XcXWZLlkozO0Du?=
 =?iso-8859-1?Q?u0tF+OPV8R0Jk+rJ9nuUcmcsz+sA2dCGm8vD5J0veXteRaFN90Z7Alp3O0?=
 =?iso-8859-1?Q?FC6uQrHeTI8eYaQUuvtzZDzXKjkcxW8ZKtEyVTzK0PqgYlMzIXEH?=
X-Exchange-RoutingPolicyChecked: smLeatEse+2uAuDLvJqztAdnO97Xvv4UEJA+5yKn/TFDmfI0v+T5IOceoKu2jNr37McHrlWT4teF6n1Z8x6MBUoHnxEzuJWv25Q5YfgedNXfDkmSga0gXLTpb3rDg0hpkha78gxRS+kmY9QYqS13XYz/4zkvsKGzRzvEWmPO3KNGBJ2qfF9wRVK4bHMHqEF9iDxx90zMBY5rL84Oc6HrnE9k0g8Q/pTwNprg8tNs9h8nNnGIm5HGPpwFrYGP7LkuNiDiyZi+OT8dSWA1rSrS6kW5aCg86mUtjWb/Crsn3TlP2DvfMlEQsa41y6cU/LPwbI53CoFjbvz/jyvwpzQSvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8b0b64-6360-4cb9-c02e-08df3c8dc3df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 05:12:48.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n7uF0ogu7+dgDP3HqqLmkIfpPmZWnIPrNP3YkpmFgh0mTzLliT+0xNkVrAxvcdrgdtYO5B3dR2K7HnOgEBR5Exg3Zn9C6hT9tXZGhla7jNImwIHRze1Fyj4WHhrR5ub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB529852
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

On Fri, Jul 10, 2026 at 07:56:04PM -0700, Matthew Brost wrote:
>Teach xe_bo_move() to service a defrag move, where TTM reallocates a
>BO's backing at the device's beneficial order and hands the old, still
>populated tt to the move via the BO's defrag_old_tt.
>
>A defrag move always has existing contents to copy, so force
>move_lacks_source false and fall through the XE_PL_TT -> XE_PL_TT no-op
>shortcut so the copy path runs. The relocation is performed entirely on
>the GPU via xe_migrate_copy_defrag(), reading the old pages from the
>stashed tt's sg table and writing the freshly reallocated backing.
>
>Both copy passes run in order on the same migrate queue and are captured
>by the returned fence, so the teardown is pipelined via
>ttm_bo_move_accel_cleanup(): the old tt is handed to a ghost object and
>only unpopulated and freed once the fence signals, so the move need not
>block. The VF CCS attach/detach handling is extended to treat a defrag
>move (ctx->defrag) like the XE_PL_SYSTEM <-> XE_PL_TT transitions it
>mirrors.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c | 24 ++++++++++++++++++++----
> 1 file changed, 20 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 02395968d613..bdcc9bed5d36 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -1170,6 +1170,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
> 					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
>
>+	/*
>+	 * A defrag move always copies the existing contents from the stashed
>+	 * old tt into the freshly (re)allocated backing.
>+	 */
>+	if (ttm_bo->defrag_old_tt)
>+		move_lacks_source = false;
>+
> 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
> 		(!ttm && ttm_bo->type == ttm_bo_type_device);
>
>@@ -1206,9 +1213,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 	/*
> 	 * Failed multi-hop where the old_mem is still marked as
> 	 * TTM_PL_FLAG_TEMPORARY, should just be a dummy move.
>+	 *
>+	 * For a defrag move the old and new tt differ, so fallthrough to the
>+	 * copy path instead of treating it as a no-op.
> 	 */
> 	if (old_mem_type == XE_PL_TT &&
>-	    new_mem->mem_type == XE_PL_TT) {
>+	    new_mem->mem_type == XE_PL_TT && !ttm_bo->defrag_old_tt) {
> 		ttm_bo_move_null(ttm_bo, new_mem);
> 		goto out;
> 	}
>@@ -1279,6 +1289,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 			flags |= XE_MIGRATE_CLEAR_FLAG_CCS_DATA;
>
> 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
>+	} else if (ttm_bo->defrag_old_tt) {
>+		struct xe_ttm_tt *old_xe_tt =
>+			container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
>+
>+		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
>+					       old_xe_tt->sg, handle_system_ccs);
> 	} else {
> 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
> 					handle_system_ccs);
>@@ -1315,13 +1331,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 	 * BBs from BO as it is no longer needed.
> 	 */
> 	if (IS_VF_CCS_READY(xe) && old_mem_type == XE_PL_TT &&
>-	    new_mem->mem_type == XE_PL_SYSTEM)
>+	    (new_mem->mem_type == XE_PL_SYSTEM || ctx->defrag))
> 		xe_sriov_vf_ccs_detach_bo(bo);
>
> 	if (IS_VF_CCS_READY(xe) &&
> 	    ((move_lacks_source && new_mem->mem_type == XE_PL_TT) ||
>-	     (old_mem_type == XE_PL_SYSTEM && new_mem->mem_type == XE_PL_TT)) &&
>-	    handle_system_ccs)
>+	     ((old_mem_type == XE_PL_SYSTEM || ctx->defrag) &&
>+	      new_mem->mem_type == XE_PL_TT)) && handle_system_ccs)
> 		ret = xe_sriov_vf_ccs_attach_bo(bo);

Assisted-by: LLM

Looks like code has changed in drm-tip and sriov_vf_ccs_attach/detach changes here
needs to be rebased.

There are also some sashiko reported bugs around this sriov_vf_ccs_attach_bo which
looks legitimate (like move() function returning earlier in error case while move
is in progress).

Niranjana

>
> out:
>-- 
>2.34.1
>
