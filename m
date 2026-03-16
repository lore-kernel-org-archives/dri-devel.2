Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DF3F013FA
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3451410E4FB;
	Mon, 16 Mar 2026 22:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aIeDkFuz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0973710E4FB;
 Mon, 16 Mar 2026 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773699001; x=1805235001;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HricEa37rdMWGX5n7U5isM6qe4P2WHeIyYhsQcG3beA=;
 b=aIeDkFuzRB7GJV9DE0xNz1EERp3NcSu4mDCXUXqqmzOPb9cuzEiSgHyy
 OhLxRToGYm5bjYbL5NCgBJoS0vNutj1nBPOJwfbwa59+Alih67w1BKbKW
 Y9g+eI06Whl+3wtvQ26x9+w5CT8wU4eXrDwTKp6tlsN/nuxHVuP1F0pcJ
 N/HImsbUUtko2bNq45knDevj2eyfRAEdBM95OGmaypY2CrqQea4B9ktiY
 D6WUCkzuU4ShsxX1+bhiuCYyMNqsee2CLZqUqUTlEL5td117k6PKvPIW5
 jjdtZOMMOwOGEXx1ClIKDXyiEIRsIrRaHe76vj+b5CUyY8/KCsazyqwdK A==;
X-CSE-ConnectionGUID: yVvdNLFnTbixIO+yJrzl9w==
X-CSE-MsgGUID: eOEpMBKaTN+jaGtkaYnx1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86082099"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86082099"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 15:10:00 -0700
X-CSE-ConnectionGUID: 2UzmuC0iS/iNx3XEbaXBgA==
X-CSE-MsgGUID: 8afHfVZZS32J6JFWbJxUTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221302203"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 15:10:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 15:10:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 15:10:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 15:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyePbMiINyEculDYAO8dR1c4N9SqovicNholmY6Cf8gvzRUDLXPupp13ZYPoyI4EBubYlYVEqO7jjIJ0Qh4iodEMgQIjer5IbKPMt5zbS46dio8ZZw+3Hyoa9OES0MXz1OQP+aKUwrwyv8KczdycM3Ym9nYpQOtaJsoXkO06lyLjvDbINPXiPkZe8E/LOPl0OBpkU7LUVQ4eEjOfdCWznmVy5YuXjJh+5lDRWQfhfBDgo+huRRCkZKvG5UCaqgkG1kuNQly4RG0bHRToUTRDTrppewam8/R3WOq6AfsAjixx/HhP6sogIE4KLtoaPPuG/y/tue//VYX17H4MXxaqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MASYchQf/hUgvmlLiQ+HxXzWqxQgYniQy+fuKAsjzRI=;
 b=GnHujzxMslnybdRTyrQW+zY61qu7P3RpkrjKGmbuuZ+IrOavb4VhCZDyv+XCtDCcP+fawkYTIDzTpX3pXRZxYF1Ggg+Ai1+4CfiiJm4aSLxuKkAAPsl2v05Wf7IhB69FytO9M4BSzGIjowjBNq8KsWGBKByuYXBdpiL1bJCcfuxbqAgvkQR2Ao7adILyafq0I6r1cePkCkz5B8qFMvRZlslCJUoWltsjfZ2ZQq8UOGefeiMYW/uZrUQSQRQ38oNtkb2MCTrk1Q6lgqBe0LfElXbny4xTAmvCsOPVbPIVk7pGf8bhOPF4Wg1CeezU8u0Ej+7usFDrkDgNpzIQvGR9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 22:09:52 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%7]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 22:09:50 +0000
Date: Mon, 16 Mar 2026 15:09:48 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Dnyaneshwar Bhadane
 <dnyaneshwar.bhadane@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <llvm@lists.linux.dev>,
 <patches@lists.linux.dev>
Subject: Re: [PATCH] drm/xe: Fix format specifier for printing pointer
 differences
Message-ID: <20260316220948.GH52346@mdroper-desk1.amr.corp.intel.com>
References: <20260316-drm-xe-fix-32-bit-wformat-ptrdiff-v1-1-0108b10b2b6b@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260316-drm-xe-fix-32-bit-wformat-ptrdiff-v1-1-0108b10b2b6b@kernel.org>
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|MN2PR11MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c7200a-9a68-4f9a-2933-08de83a8be76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 0RsuDNvRFnG5oMXr/fKMyrJNqOHvz1B6Y7rhy6n8deLs/bcMWwpb1AIFjMoHddjIkZiQr8znoR+B2V6kuKh/muifKY4UEZlauXqit1IdGcorrlR1uWN2814bbjXeAtuHyHb7BQXTC5cs+Yd37niW/Vl7dPIeTeFuQrC4U5GCkivchJ5TdJPGDW5wROnNYmN9oouC/HvsS6aid0nVx2SSLBX5uVLhw1nQVURxGTkHlXLPuGhDamcii0yiTD+jioE8jfg3zLTNcA+FkTZdk7yWhFv8ZwCd3pgv3lhZNb7xdrf/Qhy9TLCkuJk2XWv1cVK1RnYhn+c34C4Q2m3SxOa4CiJpCiXCSmALbxHrW0tnke26HsKgnVXy/fs7/4zOW1SmAWQbUI4VN0nb+ER9AnkZy8V6RRWLPBXx8j+WYngdk7XSuqaRibEpqFvfAjtMV0Zv2gHLwN/Y4gfZg5IdLaTbE0bVnaZ/92bQQUqSZvn7/CbyF110yXg4sRE+VIy7JTiSdgbG14YJ4UCYlvpfFKzQKMJ0nkIA1naSxvGifRHRh819MjVaLPqY+uVOBFVrB3HiV8Fi+fkE16c9UUSPqsPSuTHzSZIJKD9r4Zb3AXXze1ofW4KQ6GEboY5+46P32G+vqvrf99KDEL4ay4yxgg2ugNOyo3qQX9iuQHoJc8cjCq8I8wppoSH9ltIauPAsZkPExtNpVa35AqtJv4FQq31QRJzqRQ9fQAE2opb6Q8YDKhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/jWtVnnzygLkSTWB/I1wKaHp/t3N7HKnU2MqeXK7OwvmdT/I+4zPz6f1Ea9?=
 =?us-ascii?Q?+BdNuFBb1AjQrxP35AG9VyOS5NnkK1sxrmF7//30cFcclozPh8hQQ4Lzav3W?=
 =?us-ascii?Q?oEjd+4Tb39nDK3OutSc6xGSUhZPtFt3mBmx69qMEVHBEukC2oWhY1dr3uMpk?=
 =?us-ascii?Q?fvClcTSXRvjhLwOWlMjKh9kQQ1AqHTA5cuEJcnZDY9ftZ+dwDwbTXiXdni/Q?=
 =?us-ascii?Q?0owV1+QwSZN1etbjzOizkuMPITeZRwMWMaeA5hgbhmT3T0e01ZhIkXMJy5TS?=
 =?us-ascii?Q?Cia0vy6tfVW/Z0kk5YeTVGjfX/TGr+xLwtlkZQNq5sgfiNAdXtqXnJ7QCeEY?=
 =?us-ascii?Q?ZoedKH0BP9Yi4o07grgN5X6RA2w+qn9KVXcJIVp1Iih25BDYwlp3wg1L78pZ?=
 =?us-ascii?Q?qmFJ/k+HSRN+jIpTBVyx1q/j8K+PMhFaTnBzoN9lK0oVdT94TkFgpV2YuU/s?=
 =?us-ascii?Q?CzTwK3tZS13QlU0eobnasIrK5OmvDKsWnqKaqn+YNUgf0D/ZawMvQkvFJA7K?=
 =?us-ascii?Q?mpAjHlhFH9CqbMHwgqlWPPTQ6juCF7VHrwlsT6pcWlOZ2ImhV+6k+YCLeOCW?=
 =?us-ascii?Q?D0CiArUP7GjvyRK2dbhROD0KvWcjbKh4Zg1je467qqrEQRbjyTmmf1kq4o3T?=
 =?us-ascii?Q?SqvzWxpdUNytQ8kBEBZd3tjvnKf5l5fydRMBrakZQRjA5/B4FXlxid6W2gZE?=
 =?us-ascii?Q?fb5LQs56/eFbdbfLS1b+lxeL+fIvPYnX58F9Iap2Ai6Beno0q+pY4KXgjB/M?=
 =?us-ascii?Q?PN7cr0UmCDQWyQyuhsrJgjtv1antrSWEy0qx5UlmIfgV6vQz1rk1jQDvr4BV?=
 =?us-ascii?Q?032skTzF8SIThJQiXd+H4l3lXvTXJNNv0MqjcWtirE01nmD5VHgnihfmsb1E?=
 =?us-ascii?Q?KvxKjhV+im2e3ksqSWgwpncjCGulixjsV/Tv+1PRWA++5lJ1Y2EkHrl3nfFq?=
 =?us-ascii?Q?cdxgsG5EGG3eziyB8SS8N5NtPcDb/ucz9w+/To8iMQkdX4SrSpe5ll7KNAKG?=
 =?us-ascii?Q?NsmQE5WcqOnHz9t32aqr3R6jY0shYbspbtmSig7idAqLwmRYivAmm0qjb+13?=
 =?us-ascii?Q?ahBiZE3HCHDuOwD1BGuQeNA36J+h4yqIZmRhvyUiX3/a8Ej/pY45q1jeFRc/?=
 =?us-ascii?Q?dIWxxJ27CXl6cDZNr6eUZUBfNOq6uLeHlHiVfaW5Ny0DY5TBFeYIR7qjqlyW?=
 =?us-ascii?Q?bDOGXefFOGZOHHSjh0mQZuWlf9EmCP4gbtIGlRxHGV300MN8ZcQDVB9gR8pT?=
 =?us-ascii?Q?LjgykiHy2XJscKH+G5v8Gx8OsMn7fxaLXh2O0fa5MgDSPTv+X27Ocu8/KJu6?=
 =?us-ascii?Q?NaCACQN0Mqf1Srz0E9CZtQOqGqkaykGcxBs9lyBo9KA7PVqtNzepK9pZKl1q?=
 =?us-ascii?Q?t0YYwG+c4eqK8JUULqFfllNULL9ZRO+ltZzVpjVxeS3FHJLJlcbCHRqSTEw5?=
 =?us-ascii?Q?gPwwPTbsyO2VNluehqazbPkxHkxpa7JD7l9Gv/XmNjUYaDhhMigHpM+soatn?=
 =?us-ascii?Q?M9t82JMolPeIeR7fcqAgD9ctNGdxozzyvPKBuRGpIT402oeoMh9v28x2JqxT?=
 =?us-ascii?Q?skPOKuIIsi0eeuJS0DEdx0YpaPAsCM7K5GKh9Lr+5PA+mfg7FUQ0ZGZ2ixcD?=
 =?us-ascii?Q?DI+EwWNtmgRcm0ddkYlv7q1D6RVnyAI0KwpbV3oz5nJTJlUWt6epBJpqHEsW?=
 =?us-ascii?Q?NbJXiIaokvRSxI7ebuNFFBU7Vfvl8smSQUaymjfsg5E/iKebYAUc1Kce8Dxx?=
 =?us-ascii?Q?vsMtcjl91IFZioo8pZBwyzaLeStx8k4=3D?=
X-Exchange-RoutingPolicyChecked: HHne+XQKAC8LKb24oPzLLwIK7auScKjCJZKYJy7xLL+FHXx0StcjKfYGFhue7Iofz+SKlNkglqn0nIiLEE81QgQMMnmWxX2MqQM502MfQmwcHVnlRgbxY1ST4no+jKx1xrcjNnw+sSHkUcUg0tKZH/l7r5ZtK5rTIRGB4Be2966mnEXA+g0XQ9qbFK5voFaYyIB/Pwe8GV+AZxmU+eqyg4B3qb4RbcQq2jPHTToad9mm/n/mRY8xVcapygFqkNw+QbmxQ+Wh+zK4PRTg/Dex4KBY4qQnGW3o6Hbh34AOwfLZaU88rCvmDnQIcMmNM6AMdQN7nZPBJf8RWRlxJA+qXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c7200a-9a68-4f9a-2933-08de83a8be76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 22:09:50.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or7GhDflDPJ5E+bOzbnFo1uHlHn5XaUxfpeKhW88VidwqPiD15aOqDTEnw4di5zxNIbnQd7bN0+7le5Kqr2fN961eh1NRMETFkpl/DZnDks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
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

On Mon, Mar 16, 2026 at 02:54:22PM -0700, Nathan Chancellor wrote:
> GCC and clang warn (or error with CONFIG_WERROR=y / W=e) several times
> when targeting 32-bit platforms along the lines of
> 
>   drivers/gpu/drm/xe/xe_lrc.c: In function 'dump_mi_command':
>   drivers/gpu/drm/xe/xe_lrc.c:1921:40: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'int' [-Werror=format=]
>    1921 |                 drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
>         |                                    ~~~~^
>         |                                        |
>         |                                        long unsigned int
>         |                                    %#5x
>    1922 |                            dw - num_noop - start, inst_header, num_noop);
>         |                            ~~~~~~~~~~~~~~~~~~~~~
>         |                                          |
>         |                                          int
> 
>   drivers/gpu/drm/xe/xe_lrc.c:1922:7: error: format specifies type 'unsigned long' but the argument has type '__ptrdiff_t' (aka 'int') [-Werror,-Wformat]
>    1921 |                 drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
>         |                                    ~~~~~
>         |                                    %#5tx
>    1922 |                            dw - num_noop - start, inst_header, num_noop);
>         |                            ^~~~~~~~~~~~~~~~~~~~~
> 
> Use the '%tx' specifier for printing pointer differences, which clears
> up the warnings for 32-bit platforms while introducing no regressions
> for 64-bit platforms.
> 
> Fixes: 65fcf19cb36b ("drm/xe: Include running dword offset in default_lrc dumps")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_lrc.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 7fb59386d1c5..31d57d8ec051 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1918,17 +1918,17 @@ static int dump_mi_command(struct drm_printer *p,
>  		while (num_noop < remaining_dw &&
>  		       (*(++dw) & REG_GENMASK(31, 23)) == MI_NOOP)
>  			num_noop++;
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] MI_NOOP (%d dwords)\n",
>  			   dw - num_noop - start, inst_header, num_noop);
>  		return num_noop;
>  
>  	case MI_TOPOLOGY_FILTER:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_TOPOLOGY_FILTER\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] MI_TOPOLOGY_FILTER\n",
>  			   dw - start, inst_header);
>  		return 1;
>  
>  	case MI_BATCH_BUFFER_END:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_BATCH_BUFFER_END\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] MI_BATCH_BUFFER_END\n",
>  			   dw - start, inst_header);
>  		/* Return 'remaining_dw' to consume the rest of the LRC */
>  		return remaining_dw;
> @@ -1943,35 +1943,35 @@ static int dump_mi_command(struct drm_printer *p,
>  
>  	switch (inst_header & MI_OPCODE) {
>  	case MI_LOAD_REGISTER_IMM:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_LOAD_REGISTER_IMM: %d regs\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] MI_LOAD_REGISTER_IMM: %d regs\n",
>  			   dw - start, inst_header, (numdw - 1) / 2);
>  		for (int i = 1; i < numdw; i += 2)
> -			drm_printf(p, "LRC[%#5lx]  =  - %#6x = %#010x\n",
> +			drm_printf(p, "LRC[%#5tx]  =  - %#6x = %#010x\n",
>  				   &dw[i] - start, dw[i], dw[i + 1]);
>  		return numdw;
>  
>  	case MI_LOAD_REGISTER_MEM & MI_OPCODE:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_LOAD_REGISTER_MEM: %s%s\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] MI_LOAD_REGISTER_MEM: %s%s\n",
>  			   dw - start, inst_header,
>  			   dw[0] & MI_LRI_LRM_CS_MMIO ? "CS_MMIO " : "",
>  			   dw[0] & MI_LRM_USE_GGTT ? "USE_GGTT " : "");
>  		if (numdw == 4)
> -			drm_printf(p, "LRC[%#5lx]  =  - %#6x = %#010llx\n",
> +			drm_printf(p, "LRC[%#5tx]  =  - %#6x = %#010llx\n",
>  				   dw - start,
>  				   dw[1], ((u64)(dw[3]) << 32 | (u64)(dw[2])));
>  		else
> -			drm_printf(p, "LRC[%#5lx]  =  - %*ph (%s)\n",
> +			drm_printf(p, "LRC[%#5tx]  =  - %*ph (%s)\n",
>  				   dw - start, (int)sizeof(u32) * (numdw - 1),
>  				   dw + 1, numdw < 4 ? "truncated" : "malformed");
>  		return numdw;
>  
>  	case MI_FORCE_WAKEUP:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_FORCE_WAKEUP\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] MI_FORCE_WAKEUP\n",
>  			   dw - start, inst_header);
>  		return numdw;
>  
>  	default:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown MI opcode %#x, likely %d dwords\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] unknown MI opcode %#x, likely %d dwords\n",
>  			   dw - start, inst_header, opcode, numdw);
>  		return numdw;
>  	}
> @@ -1998,12 +1998,12 @@ static int dump_gfxpipe_command(struct drm_printer *p,
>  	switch (*dw & GFXPIPE_MATCH_MASK) {
>  #define MATCH(cmd) \
>  	case cmd: \
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] " #cmd " (%d dwords)\n", \
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] " #cmd " (%d dwords)\n", \
>  			   dw - start, *dw, numdw); \
>  		return numdw
>  #define MATCH3D(cmd) \
>  	case CMD_##cmd: \
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] " #cmd " (%d dwords)\n", \
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] " #cmd " (%d dwords)\n", \
>  			   dw - start, *dw, numdw); \
>  		return numdw
>  
> @@ -2136,7 +2136,7 @@ static int dump_gfxpipe_command(struct drm_printer *p,
>  	MATCH3D(3DSTATE_SLICE_TABLE_STATE_POINTER_2);
>  
>  	default:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown GFXPIPE command (pipeline=%#x, opcode=%#x, subopcode=%#x), likely %d dwords\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] unknown GFXPIPE command (pipeline=%#x, opcode=%#x, subopcode=%#x), likely %d dwords\n",
>  			   dw - start, *dw, pipeline, opcode, subopcode, numdw);
>  		return numdw;
>  	}
> @@ -2162,7 +2162,7 @@ static int dump_gfx_state_command(struct drm_printer *p,
>  	MATCH(STATE_WRITE_INLINE);
>  
>  	default:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown GFX_STATE command (opcode=%#x), likely %d dwords\n",
> +		drm_printf(p, "LRC[%#5tx]  =  [%#010x] unknown GFX_STATE command (opcode=%#x), likely %d dwords\n",
>  			   dw - start, *dw, opcode, numdw);
>  		return numdw;
>  	}
> @@ -2197,7 +2197,7 @@ void xe_lrc_dump_default(struct drm_printer *p,
>  			num_dw = dump_gfx_state_command(p, gt, start, dw, remaining_dw);
>  		} else {
>  			num_dw = min(instr_dw(*dw), remaining_dw);
> -			drm_printf(p, "LRC[%#5lx]  =  [%#10x] Unknown instruction of type %#x, likely %d dwords\n",
> +			drm_printf(p, "LRC[%#5tx]  =  [%#10x] Unknown instruction of type %#x, likely %d dwords\n",
>  				   dw - start,
>  				   *dw, REG_FIELD_GET(XE_INSTR_CMD_TYPE, *dw),
>  				   num_dw);
> 
> ---
> base-commit: 1b12096b4bc5177d685ae098fdb90260ffd5db6b
> change-id: 20260316-drm-xe-fix-32-bit-wformat-ptrdiff-a5f4f8483ec3
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
