Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCD9C88E42
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB7C10E361;
	Fri, 11 Sep 2026 06:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QeACrA/7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7891110E351;
 Fri, 11 Sep 2026 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789107542; x=1820643542;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hk/4uY4VPHOHhGw61hw5z235BM9butyAd1YIqsrpUc0=;
 b=QeACrA/7tfy40dLEcHGJfzfdcY8QUD1D9wLMn80mvcJsFBx41giYgxU8
 K8Hw5xM1GZAdff2hDd6eH2W4x58HAVB8dCNxvvWlS363vwHhw6sI6+hvl
 DhB2RPlllNSBBcNqbn+nnIg97ArZFuUVoFjvZQzMJa2Efls+8YZw3Tk03
 9IV41joL96jKVG3x7DEYEO8AcEyF8C+JWiuakIoykynyPq3pH7NXoMDJ4
 ETgZ0ysXQJfymVeMQoyaM2N0gUuaRqs9YddUMVS5COTw81UguIuELV4YZ
 zoQheie1ZdC9yvYOPKTsaxhuo4j2eYvwOzK0FxCz/S7PSMx8L15Kp1OiN w==;
X-CSE-ConnectionGUID: OBXx681vQL6rCvX2VX54gw==
X-CSE-MsgGUID: kSq/gFq8S9OCI7u4504FXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89606642"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89606642"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:19:02 -0700
X-CSE-ConnectionGUID: gpuuQmTiR2uz/xqXVmnKFA==
X-CSE-MsgGUID: MVSzaUbNSPWEkU59RZCyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="275979574"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:19:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:19:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 23:19:00 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDoAF6bo4O1rHNZ9xZVePvN3vYMbtz1xulHVNUqAGJjouZXhkYQMQDve9m9WgHSbJj4Sl27PUPB5W7uaL3kV62JosmGqYiXwmKrbTC2kvcFjZHT/NxzkjqerOX12GDDsyMtbuqeONF1jzmwqh3gu0XF/APwemnwuDnBOTKTMUtiv2X81yPN46u1pF7Zjf4aAO25hEO1+c2KrknwRdobKdrSJpVKA5D4No3qq0YMjjLSB5AQvgCZ8SZdUGgWT2T2aBt+KwStfuu+Uf5hEfoIN4P77gtiSE+VwUKsQc0D/TCyt9e9qLTVAgpsKztYje0bN8xaUeRHx6aos+5+yWfj46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Sq8Oy3KCgN1VQ6Cv63v3Qa3ie0gbAS02LUOiZULs8=;
 b=dPtI/vOF+lDdZ468EK855qUdgd6vnzmsU0NT+usdjghnBJ/b/hFqa2kUrBqI3C6UPUzcvtVr/KdBsAg78HrD5fj1CIUzr3twq1HN1GeKn3TvvlDqQvgNK9xKYzYNvkh+Uuv6qsrmfUQq8SQqfdjYEFcKVBVhyPloTnaU7e3aQENGHaEGtcU8SM9TxLeCvDlzB/1oevicrBBrNPouA99QJzsP9w8X42JPDXy7GBELfinO2m9DLPe7tQmzEUHxrBQPavM9geHzRew6ps02yhCWXN6QPZBv02NMoaiCjr3t7qdL2bIZ6s21MvcfNAoFpbvLwd6gIwxo1s0FZ7a2ScW4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:18:52 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:18:52 +0000
Date: Fri, 11 Sep 2026 06:18:42 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 6/7] drm/i915/gem: Read and shrink memory in a
 separate function
Message-ID: <rm72pezw5fwt3merkd6zyeyk2npnmroh6luo6gyn3fj2dvfy4v@nmyogt2etwm5>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-7-krzysztof.karas@intel.com>
 <aqMvCTIzLcshkVCA@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aqMvCTIzLcshkVCA@zenone.zhora.eu>
X-ClientProxiedBy: DU2PR04CA0282.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::17) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dda674-be38-48a4-1904-08df0fcc8ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: w2JjISF5QYbjvQWgzSsML26mOsjs/6fWpDbA+PDpRujl4DXoBDF0xuY/cmxkFm3QmxzyToHGyujNWmCakG21Zz62g+Pnik6MjU7oMvUK5Rc19RTveMMdiSHRFkPw6eMQzWH2dgSuAD8QCL5ODn1O5w78dABMD2/2AoK0DaCh8+tB9uE7q9p+ZMRL+sa0DsyQzeKx0e8Jxvtdlz1TdRuR+MybI0L1G/dMB2dt0P36/9cjSNyM8yG4lv9B2Hb48OXxm+2cxEXkfcaZRhCoRG+Lwm8PwwAXKCea4lEPa/aSVgHSPf3S6xILM+lamTE39iOgacJe03lL6xz0Prjlf9zPXFa+5RRXf/QUe3nhyLjeU1k06tPqt682i4y2DOJrwdLepxsCohgVzSabi2PT8YmjZA2I749nOmzPUFfZ46eJkpz3s8LxoQM6lggnCInotRuMNnisYMs42zJ4BEoQs0nBxKRNgvD6hmU+rjCBpJD98Lj2XG5K5QTh14449Bb35TAA/M9SXjTZkCmdfdFtVyCQcnIckHmVE+GRo70RliyPvFsIA3QuAvhZmadfCbV7EVUOeHHT3oGJUsxmuhMucE1/Su5HWmhCDcqHfTyZAch42blN61V4DRxiFktnvJP25kE3xK7CrCbjb9gsOp8hCCPFVmJamNFFk5Jy3HY6ZA5zN1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNGaUJ5djRza3hrM09aSXpiUUhnRGgzOVhhaEg5SWs2RWlqa283SHY5L055?=
 =?utf-8?B?YTA4TGpkUzRHVktKZnZ2MjlKaXpyaHRsOE1KLzBzeWxRSzFzenp1RnUyVGJQ?=
 =?utf-8?B?Z3ZDODdRWjBNTHRpUHRVc0VOMTUzNnZaVERPQVY4ek1hcVFWckYxUTI3YnV5?=
 =?utf-8?B?aUNnMnFyN1RPc01nN0pmRm1BOEFzcEpvY3Nad21pejNzeVVEOWhzR1lLcS95?=
 =?utf-8?B?STQ1bWhNdURYSWtvaVBuQ0ZlazE3dXBNVnQ3djRIeWdMTzl5OCtuTGh6RHd1?=
 =?utf-8?B?NjBUaWttbHZMd0d2Y3JXQ29CNkpoRXdRSnpUZklIbXVmNXJaZjM1a1VFYTZq?=
 =?utf-8?B?QzRaQWgyTENvcE5oY2ZSNnpabnhJcG8xNGgwME1SOGpNTjdSSGVqay9UOWVS?=
 =?utf-8?B?RElMV3VWUzRyY0JUU3ZKSjZCdUdxcWI0SVlSQTFjd0d6dXhpcjk3V0tUU0tr?=
 =?utf-8?B?UlAxZnVCR2ZoVTRwRStuN3VEdE11cjB0ellHZ1pPQTlITjhJRFRhRWpjQWI4?=
 =?utf-8?B?OEZRc2hPU21CMzU2WVV0cG9iNG9TT25pSHJjWUZna0VoQzlaZnNVdGcxOHVG?=
 =?utf-8?B?eU42UTRsVE94TFAxc2ppVHZ1Z0k2L1N1eVhkRW1Ec2dQekQzSVk0dS9pdEk1?=
 =?utf-8?B?djNJWkJkUDNMd0ZGSE9ab3Y3RkFaeHp2bXZwSVRuMWY5L1Zqek10YS9FbmtX?=
 =?utf-8?B?UnB1REdUam91QnNETTRqdDZ3aDQvTC8wWDIrZkJ6SitaamdJNkJFVGd6WFJu?=
 =?utf-8?B?M1pNSDJkTjJMTkcvWU1PL2RYSWFkd0x5ZTUxcUdEVWdjVFBGamRUa0R5eE1o?=
 =?utf-8?B?OFpxUXV3M01hbkRRTno3L3llWW9EZDVqanhJSU83VWxidkpuRnZQTVdqQ0Va?=
 =?utf-8?B?aEhJNnFDQUd0VkFua0UxWmkrWkFkZFU2NCtMWE9rSmVweUpCdUpjaFlHbVlD?=
 =?utf-8?B?UG16cFpFOTRBV0hGRDVxVXJQaFBjVVJKY3l0ZlN4NFRpNW9nOHFaRHliYzJv?=
 =?utf-8?B?ZVpLdmZ2RjhKc3hJQm5lUERqVHViemJnN2tPTWFQVEtKSXYyZzFTRjk1QUpt?=
 =?utf-8?B?Qm9BNDUrT0hhalhFOXA5TXVFRDc0a29ySzBiUTh1bi9DUDJ4dHdrZVo4cWxT?=
 =?utf-8?B?UjhwaXpoejREWFFPZTNtVEpBMUx1cTJheGJJY3dyT200MkZRVFhLNlo4U3Ft?=
 =?utf-8?B?clhZWWNlckxGdjdFZllUYTlHVnZ6MUV6TzkwWTNMWEhEOE1obnA5cEVMRERS?=
 =?utf-8?B?cVMwdlVYWEwxRUJWR3JPclBMYTdqRllITkJvLzN0aDViRnhjZ3Q5ZUJ5d3Vv?=
 =?utf-8?B?TmZ5UHhBNXo3ZWlmTGwxMStXbktMOXgweHhPUmY3ZVBRM2RMbkZYUnQzYnp6?=
 =?utf-8?B?cG9oeUxYN1VSK2lEbGF2L1REdmhOWVltdEIvaUVLRkZadnlMZ2QzelNRa3Fa?=
 =?utf-8?B?UDhSSTFBRTl3UWtFOS9lNmY0ZFVHdndMOWpqRDRsenBnWWVwZ0FKblVPVnBO?=
 =?utf-8?B?UjlkSU9HSThMZ0JCUXE0SjVyMkVBeW55SDd4MzFXQTRCMmlvbEhFd1kyZUJC?=
 =?utf-8?B?R0VUclFOQnJObm03Q1NKU2NPMnFWM3paUGltM3ZIN0NuSlczWmJkTU0wNHVU?=
 =?utf-8?B?dVJqMkVCazJBeTFkMHNqeVNLK0VZMGpmdUV3MnNnZ3FPQWxraVJhRWtZdmd1?=
 =?utf-8?B?QzBLSXJRSVJkdHV1US9CZEg4QWVTK2hKanoya241N0UyaUNpN0p1YU0yZXFj?=
 =?utf-8?B?eS85azdOMC9ZOVR5VHNjbUR0YmNac1FybE8vTVBPK2NaRWZwUlBocGFoN0RF?=
 =?utf-8?B?VjdzN0VIVEZSM0xCWU1Uc2htSlE3MzB0R1ZpbHJwT0taOTJGSFRTYzJENjh6?=
 =?utf-8?B?c0cxaW54L3BNMFVVd1dtbkxqUnJ5U1FoSThsYmxQY1dqNWhkUlBjU3RiU0JB?=
 =?utf-8?B?eDZ4MGpDQWFFd0tzVTdZMjJ2UlExWlRGK08zejdFVUtoRDlZVFNiRnFxclI4?=
 =?utf-8?B?dEZGMjFZM2R6aEVTc2xSbkJGaktiSTFVNlI0VnY1UFg2VXRDdEFIZHNUOFRp?=
 =?utf-8?B?ZC96SXdZcERZNFpxWDhoSmYzNVRJVFh1SnNReVJib2hJN0FDWWpyQkJPOUUw?=
 =?utf-8?B?QTNuL2NqUGJWclNUUHhEV3FJd2V4UWF4cFMrWk9UbGJrWGdTQitsWFJESnFV?=
 =?utf-8?B?TEJTVmU0VDREdVJ2NGFyQS8yazlSMHNPMTRGWjVWaUg5TE9CQlVlYTFsR0xh?=
 =?utf-8?B?blpOcmV5a28wOVlkMVRsbTVzc1orNktEY2ErUmRKU1d0SU44RlZMMlNhd0VX?=
 =?utf-8?B?RkxocWo0ZkRhQ3FuQ0ZlVFZJU0ZsNVhEbStvTm5BZmMxUFNnSnpiNXg2dzM3?=
 =?utf-8?Q?seB8jIdm4VqgA3xI=3D?=
X-Exchange-RoutingPolicyChecked: YjQLHF3OMWhhdQgKpVXRQMKn0umRLKVrLriDjGYxbHduv8BsigB96KG53Hb7MRQZ6BW2dKlvQNPCBQWQcTJEi3LUtg/kI4IMGoTBLwPZPBQz6RATxRUY8ttEGgft4HSFDc/tB/K2OUb8Zcgm8RPU1FFQ3vx0GZHNZyE1o1KdQNve/hcdwUyGm0DEEt/T0JJ6bue56l1cIQ32LSyt9KH/XtQFtal1a0krnw8csck/NUov3opFh4WVtcrj2w3ykBtANG0Km0NEpgHPZxwPlumEXAO9/Oq7ytpiVu6ebf5mFhkZ/uphM1NtHplotrWvZJxRXrMIjFriwo+Dnlxpa2yx7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dda674-be38-48a4-1904-08df0fcc8ce4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:18:52.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1gEQ0zAP8Ym7uc7SOIWhS8oFoucuKMIlIHnOREeN2ZTHE6G7K9aE7yB3TzqvoDLKhEsUxALt1DV2aojl8adH1w0xHCwai3owh7bPu1lX1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
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

Hi Andi,

On 2026-09-11 at 00:30:58 +0200, Andi Shyti wrote:
> On Wed, Sep 02, 2026 at 08:25:24AM +0000, Krzysztof Karas wrote:
> > Continue unloading shmem_sg_alloc_table by placing reading
> > folios and shrink call into a new helper.
> > Make the code a bit more reader-friendly by removing moving
> 
> "by removing moving"?
Nice catch, it slipped through all my automated spell checks :)

> 
> > over structure elements and replacing it with a sequence of
> > instructions.
> > 
> > Assisted-by: GitHub Copilot:claude-opus-5
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> 
> Looks correct to me:
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Thank you!

> 
> Thanks,
> Andi

-- 
Best Regards,
Krzysztof
