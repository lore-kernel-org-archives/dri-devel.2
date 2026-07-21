Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8B0C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45D910E391;
	Tue, 21 Jul 2026 17:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CRUl7VpV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BF510E391;
 Tue, 21 Jul 2026 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784654919; x=1816190919;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gMDY7ElpIjraCOe4p9cegC4Ye7/eFnecS3/zCTW86OY=;
 b=CRUl7VpV01eYCfFuJv5lGQjZq78jnJ+ZEga6IQkl/jmz8UIRX8qWgmYR
 MiglzJBs4dJ3KhLueE98tbw/FcAmIGmvqi7rvs0SobBItawy5XHf3biBg
 GBJcHLRGyLbXkfwAxhLl7iKRgczMXh7zjKuXyjl06srNN4FxDryYTQ6w1
 mHhF7LsIPPz6Wr32POTcM0qKWWSQa3PTYxqzHBNab9qRBJ7aCE2Y2ION1
 scKLLps+qkYX6R7TvlEf/oxWPmFMXokrvxtR42rHcu2MwFsV7yuCH5nzI
 FG1PXCpHF0/ok6G7BxKyQVwoYinjGoLMrlc/YgNv3S64XjgtsiBzi7hoq Q==;
X-CSE-ConnectionGUID: qb3EQmSiRLC7wiofVthENg==
X-CSE-MsgGUID: Z/YYu2NSRB+ETdED3N6z1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96630991"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="96630991"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:28:38 -0700
X-CSE-ConnectionGUID: /quYJadaQ7SUv2eka6oKig==
X-CSE-MsgGUID: RK/Bpco9TGSwPeLcvmHdEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="261612394"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:28:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:28:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 10:28:37 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA86vUIDSYbPDyEzFAT6VjHY5wX476BGf9KuvCqRHZnG9ObUimnfoMBB/wu25reIBRwdv7iomqYhvy+Yze3cK5UdIFAmTlxIBR40mLuIDkhuO1+mhAb7SaOclVH6e44stKRIPPM4/aoBQanMUlZD7Qz/3GWP9I28W4L7gNe50GvPubxBjeXwggud7NRlGYom9BLmrFoupai1xR66OCsR33Rs2u0S5KfoMVWeLdKQdoZZbqOkylBOiaq5tzm2pPwsor5YgBgG+4aWvydeLFxH8iWWktkSFMMu6l52BPk+z+mUznn+hYKtWlyO80FGw8yv3unVFGMYTZ/q2QVBt51GbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkOlIfR8rN078x0nvw64NUQF0mSXW1dtVnUm86yWxCk=;
 b=rUJvpMDPv99e5o7KWxfBziMz/U/vhbE0zTv5l8fVev3z4GqKMVGKTkCO4C4ndAqBF8VzEa55uti9vfH1nod4+LkZBUO3ljTLfLqCigKJnd2tqFmjLzoQbOj9jR0weNzpCgyzG6H63QdWjeH4G6wp3RqS3PDDCvZC+7KtWwAGGSrsWBBRbAKatzNluTT+NIMIbQzFtVRi+mJf2pOKlOZUM1rOHwoUIlMz4vlin4CAPlUND3Rf+426p12ihSS4yMj+VNb+HP4YUpQGKeUen/GdwGvSCUim5WH1c8F4+XjvgjHB2MRJt8Q/BioBTXHinAdC32449Yds9PPwfFBORrZidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by DSWPR11MB9761.namprd11.prod.outlook.com (2603:10b6:8:356::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:28:28 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 17:28:28 +0000
Date: Tue, 21 Jul 2026 13:28:22 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <kernel-janitors@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/i915/bw: Fix spelling mistake "threshod" ->
 "threshold"
Message-ID: <al-sNhchV3BXIP35@intel.com>
References: <20260720161630.326016-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720161630.326016-1-colin.i.king@gmail.com>
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|DSWPR11MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 694a682b-dcfc-4734-3f8f-08dee74d79ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: xwA3puclSF/z0N20jcubVZ6BZtk68I1HGUAF1566XEvSjGgkTlXuCQsQyosv8fElOSeBzHynKaTWPsi11pJxOzpbEuuycBETN+8I4iOFMRPL8dJf6ioJOcSiFbisKNX3iFynbK6xeYKwpdSwjojyzANxhC2G/H0Mhb7mRwi8CoaV923Us6V0UI0ZUiZvJNcBat/gBNd4gw1XJJGjrWPBnOdgfpIN9Aslu07UntjcVvsHxVSDiFlp/00x++hVzhW1Ixj2iLA4t/6NuGQNSTHboFO4W9fmLSMM0HEoxjQKeTy7vXPW2nZ2n8PbURmQKyxFKWyHVIFOwBNCz9agVQDmiuRmHH5Q1mWM7nm3soSfGGx66+8UVnhIUiiBZbsqpmVz5iIy2U4UVfL6s1g4sIhcqHryZ+Pv7ANOGHygXRbEQraE1hWr5SjZ21YcNiMMX7F7IXuqVL0XO+ViLo81qeAXxoBQz4W2Gdba3eDfxXJxB7D75SRFb3I+TBKkQyvXh+gVKG8+UyrvY4ACxikYA5y7+Ed8AQVzoeTUwAvVnlbIfggO9wUIjja97X3q/r4XJtHcbu36aOmCY1ERgstWHORqUQ0c5v2sOwb+9tlhzWMzCDV/kLJr/I7ih4XlOqjwJOQFsmJDjfTROvpUOCGir/+OBs0jQ8XOnkKzwOfMSJNnhr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCCmnYLvqBzB/JpUHAGmE7xDhvNsdptYtQ5Bkca40wQsnkFW18EuzWXU+ujz?=
 =?us-ascii?Q?RqR2WqecjvvkF3dBxZVeH7ocmwninSmZvEWq3UJKJYZ0R5D2mScMdHc9H36o?=
 =?us-ascii?Q?FXwMAeJ9P5sVYORFyI3uFvN/t1XLbyxHp7ExnJNWNQNPV7Ss9QpDcoZhKCyI?=
 =?us-ascii?Q?jrWlAAIrI0ypKJ+j1WUMHBgro4DFRWidMHpnckfq+JHfPVyZQwqIQrwyaSoN?=
 =?us-ascii?Q?7/iccnUoE0l0M+ALtlCRX4Io7IMjyALd2bUi50zIlLopqP8x/YgpUju7qmT5?=
 =?us-ascii?Q?ps2JNSOXDPB9WpdTyJvT5kYSRsbHLTd6426DTvgmwisl4DsZI+XvtUczeiDQ?=
 =?us-ascii?Q?9sPT2zSOew7OtQdKwpRIriYrPRKvEtka1OMBYVKGmIV+AJWQ9nOCQ/pLcwiq?=
 =?us-ascii?Q?qu4E9skRmV+9iZ0OlsmnWxYq6bJPkxJpIPvX9XfwQi1oxrpmt3u0fkIGG1cr?=
 =?us-ascii?Q?mShVTZbqnyTQng1jkLyUct4YPHCcix38ts+HzwGlAMXHVHJIRIhXz1W3Fjkm?=
 =?us-ascii?Q?upVkdtNAhZy+WVhodW7nGIw4l7EvgmgB2q30DWvL/mcwbEfXDSWb1wuVH4qT?=
 =?us-ascii?Q?060BeCHTPXJeqjDlW1k4lI98GRlLO0gGkavrVOoq4ADMtm06jltYTIJ5yv9W?=
 =?us-ascii?Q?l0LNbUpffcSqeWsoKqH0q+s6zhSAKZZ2U5+y9tSxN3bSDBKGdZD7d/8oRsFG?=
 =?us-ascii?Q?gcuIsILcdktHm/7kcEVuOYEEoeUc/m8/HF1dqRAIdvXA1IqL0NKsKM6dZvUJ?=
 =?us-ascii?Q?Q6F12XwlsxlRaWQYjravtz/fuVV9cVA2sneWG09DcbilwoiTM2xx1lqkJdK9?=
 =?us-ascii?Q?t7b0fBOR4P/19xamD7+pxZHOHikFkEYsi4nLplKDsv6Lv/thJsQKaOUxO7Yj?=
 =?us-ascii?Q?5Kr0lbFYV81r/3D+xmzhJgumRPVgwdGgB6H9e0v8bZSyhpdOYYN0aooSx0jj?=
 =?us-ascii?Q?4ZEdOh5mlTQ6etHCnPJXmTIxrWPDepH4w07PMJbSDvwqCiYhWbc7k0HOhv8W?=
 =?us-ascii?Q?iNax/09ywvuOIkbW6qQUzj2fPvX8x3iQFhoqP/tXa9RDTfT6LiVaNqTKu/Br?=
 =?us-ascii?Q?GpFuLi2nO1WKsAlWX09hDzxCIojeFGI4HddG0JaemFdHS5K/iVMLsY+3fwXw?=
 =?us-ascii?Q?VDv2wE6k+P5xOoin+3kJhghnDkYW9s/0DPBuZxkoTzKKKd0W1qS02HsIPcBm?=
 =?us-ascii?Q?ZIqVIuh9tQPDzZp/BNGRAyzJfr4BcfV91e456gY7qk/p7SqDxjdgA856rbQF?=
 =?us-ascii?Q?7zLcTshCIH0pIEm+PbH0NNnJ+jHUkEYO7ITzSd2cKMMFDgPuQ7lnGbOtkjp4?=
 =?us-ascii?Q?eeg4j1TgV5rPSxtStTCopJr2nqsif6X33bMYKnF3aBbD5GbEczY88Bbx3r8e?=
 =?us-ascii?Q?2zAf0U7xjRuSz6zWX6XjTmsbzzQpqlzj1cw3CpeHuZm80yEAMPwzzQoxRpYe?=
 =?us-ascii?Q?vIC7FzvTznI790gjTvHEs+8k9NEHbOitY1IY8/eM0zO+cBalfOKrdkZbDV4L?=
 =?us-ascii?Q?BZnrLTlQkRxCzz3yt6xKDAsINZXMIAvLPLZ6U7xPhn6a6kbScl/v4tDn20nG?=
 =?us-ascii?Q?ULzwXbN37a221KRZzpxkQ8DLP57JF0df3ndVHxwWJ5dW6sbKbUjWmRil02/G?=
 =?us-ascii?Q?4bl69nVK34yexLg9Bf3G2ym4k/OezNoEWMklaXf7awftvVTw6DWSIVsH1EtN?=
 =?us-ascii?Q?YM9r4hukQstGtSgAA79Dy//jW6flpUc+gY9dIvf98Co72PNj+9Bw53xiyRS9?=
 =?us-ascii?Q?XRAAZ4pSpg=3D=3D?=
X-Exchange-RoutingPolicyChecked: diDIm1FAMgSOmx92VXw5j50Souq49XLClKJAbr2n8rrqi4eLktzunrB+9PmVy9S2BOsXBGMIVCvDj5raG10P8IF+I7ZkQvse9IpWHZcoc8x5tZ3ARB1klxO2i1Gf1/4USDM2l/wTbzXK8FXxLjn31df76uBH2072Z78ixYGdViRXYDCL+b2DglL7d8f8bkoh8LQ+yWLfiWcP3boWWjkxS9fKvBpo8Z6ivxraQjHo9kkR93Fn+9NMOXUDOOzyUx8oD0YJDqiNcfSclhTNGgehsT+qw0Ew7y5MsVZ0vpZ09JrbhtjxDZ+Vg/9nivBtY6lxjkimw5xsO83ryNseeBCURQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 694a682b-dcfc-4734-3f8f-08dee74d79ef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:28:28.0642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWLlzz4hlrfHEEwMLtoWJ0cg3M0dsXnkElURLk1v6u8/rDNn/sDqAXLpo9+2l2URrhjhGXNIiFhSWLWuCrhTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9761
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

On Mon, Jul 20, 2026 at 05:16:30PM +0100, Colin Ian King wrote:
> There is a spelling mistake in a drm_dbg_kms message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

pushed to drm-intel-next. Thanks for the patch.

Just a quick reminder, for i915 patches, next time, please send to intel-gfx@lists.freedesktop.org

> ---
>  drivers/gpu/drm/i915/display/intel_bw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
> index 546d5ccbe052..c71082852cfa 100644
> --- a/drivers/gpu/drm/i915/display/intel_bw.c
> +++ b/drivers/gpu/drm/i915/display/intel_bw.c
> @@ -625,7 +625,7 @@ static void xe3_add_peakbw_threshold(struct intel_display *display)
>  	for (int i = 0; i < ARRAY_SIZE(display->bw.max); i++)
>  		display->bw.max[i].deratedbw[qgv_points] = PEAK_BW_THRESHOLD;
>  
> -	drm_dbg_kms(display->drm, "An extra QGV point %d added for Peak bw threshod of %d\n",
> +	drm_dbg_kms(display->drm, "An extra QGV point %d added for Peak bw threshold of %d\n",
>  		    qgv_points, PEAK_BW_THRESHOLD);
>  }
>  
> -- 
> 2.53.0
> 
