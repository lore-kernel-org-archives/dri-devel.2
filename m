Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC33CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1586510E11B;
	Wed, 14 Oct 2026 10:12:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B649D10E11B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791972743; x=1823508743;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ndDDgznY2NydoghEBbxrQOT97YgqUCrqNXGh6nhcG0o=;
 b=JRm3XHV9Knrg2v4o1nNoo5V2lMNz3/JdQ0ToiNv7Hy3NyTdMb74dg0Ip
 oteCHCER/2oHIL1QiFHpWMEKvgPhDngITdTNrWJvWOKGagRFEtXnnBb50
 qAeoJWlm1gkivboYDETqs4CVHBhf8y9fXB3RXu2UI72kVYMLW5ohrfhbp
 FPUVm1diuE4A+wLG/ETG8g8vx51LI1bmRoBEfeZtgfukzQm1vlA0Tiocx
 AyOg8qKbs41geFGIyFc0K0LLKSZRg4UvRYYbBHYbVstG/wIOutkfqry2B
 UMebqPJsIQKN+YLPSD8xoL0EKnXdEEuVHJcdlnOSUXUJwVqL+gV5k7SfU A==;
X-CSE-ConnectionGUID: i+Yky3rxQAKO7QhZNdKWbQ==
X-CSE-MsgGUID: dmqVYm5dTHedb0c2CsEQdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="616644"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="616644"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:12:23 -0700
X-CSE-ConnectionGUID: NZ+vMmKpQZKMtTzYtbpHUw==
X-CSE-MsgGUID: hflPH7PvTCWRHez42TczqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1316166"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:12:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:12:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:12:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS/2F+LZXKSPTOTgVt8ZSI6BvzRsMKf9i3KX4nUgJS5dPwBRcYqATLGqRzVTBK8LiSlrh4LAX+VmYO1ui/DJCT3Ghf8v9PJQ0//tG44wmkh3cw835W3pEzo3AAoWrY3QHLqA2XRreClMhGrXdwZNmv8OzPeQjoafjnOYWdlK3y7GZCpMVw7imIgMpbqUmm+Rfu34KtHZV1A1lltI/gq7ypFIyhKX1w0SgoKVjVrudOKb5EIWerNaP5t3qVnIKJ/OCdxRvbzrJqk+OIHpwuOVqei9X32J7YbJsyhS6DKonYhal5PCQaPYuBw/K0PZ/+HPqd3PG2lthMJJY55B+yO2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oma+mMccipX/ou59XNlD8OVwYYnnJuYW1U7d9uG1mkU=;
 b=k50WQBo5GkSx7aILBON7rMPGAvf6fpWtOeHs8vu1A3NS10Nn4lBdg2tNicpyWTfv5lfw0Igt+TTVXbWALp0OiSn4sthAwjqxXzVQ9PJyU4LyhcLCMrBKB5GtrvUvHvQLrEwUA5GeXgPsCRn5wYBB3kApr98FwD2Mk6eSwtZo+im13Qnm/rz//WdjXcrJ/eKca/guEmLH5AW7foh9LCZ13h+pAEIGIvrjW0bk3gt1b2U4KNxycEAd2yFfqdrzFSlj5IW/YsOhl2Tt2IY1JCPRH0KsAOh3C6KmSH23Z4FPr7okRDCJ6tL2rBEcgmGSYaxyG8omVK/oorApvSGDXyJcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by MN2PR11MB4727.namprd11.prod.outlook.com (2603:10b6:208:26f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Wed, 14 Oct
 2026 10:12:19 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:12:19 +0000
Date: Wed, 14 Oct 2026 03:12:16 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/gpusvm: use literal blocks for the indented code
 examples
Message-ID: <as9VgIkpCDQGbA6e@gsse-cloud1.jf.intel.com>
References: <20261014065153.1562717-1-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014065153.1562717-1-honghuan@amd.com>
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|MN2PR11MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 99078135-1304-4dc4-cfb4-08df29dba127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|261009221227099003|18002099003|22082099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ad6XDMBiMhVZqwsJIVLOlDys5kgYfmd8uDE4YFL2uNUd0owG5llLbZhsNqHA6DN3iheq5/xdW22snHRcFTY0mLKrTu3HGxkHQ1UKPdOo8jh58uQvif8wqN3UrlH/i0GKa2eLgEV7M16+JvDHXiESI7XbdJ8aY3524s2iaul+yinRV8yLLzNSr32ZgJrq+4hlMKRD8cbfcgJ8iBqTnTPRDXOSAap355GpFuavdJgLiCYlT50BFZYNdmSsosnrNCUmSq74feluBG+9cuRH/XrTjTYF/e3q6/VMMPvTGbxDbpPBujYkX5WVZeoJboBMOXXN55++96bfYak9TXhDEpWYSltP7l8kRyPuRZmYeBVen1G+ce4xbHZTu0ZPqxsB35ezdpmwZmKrOJX8YyrQbjUWwEigZyHh59LOiwCzEHg2+QTzQ1DGtQ0v0vssMK00twI5Hx9metT8O46tUmbZEwoFY4hF4xs6d6L0rltsB/gPWwTIGi6y7g94KfvEuvd77ItN0FsTUpdbvJ/l2gseOWvPoOEWkE6VptceMTFC1pTJYr3OipouD3C6PiUrM9NzWknMPNg/6jI+fhNs9vZDjUQkYVk5IBvtoBx2ld/5Wv20+lzGJ80as+/MkiE6Mp1aFHHP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(261009221227099003)(18002099003)(22082099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ae5iwRwQs4XHcSX7nGLKqtqS/N5NBxtsVv0sofhTuugt4+kF3jsPrhetovuN?=
 =?us-ascii?Q?wCG11LyBdEE5yqBZvaZ56KG2WcCNskmnElxgAX7DQI2No/XuaUno5i7YQF7Q?=
 =?us-ascii?Q?tzUrIkM7y3tEqDxlWoclxPTwcbgKOk7JwcVA0CuhgBVjcjL4eCqgOUpiH7+2?=
 =?us-ascii?Q?T1QPIkFgze5hT9I+R3OYE+rSxXfLV1sAaugKHnsei9catIxkxahbEsaMiaXo?=
 =?us-ascii?Q?5r78jSANbjNY+Ala3ojuMXkrGsm1Tq9KxnfuNfSF/OCgKEa9xzEf1xeEUIhF?=
 =?us-ascii?Q?ZhxeipNJBeGbDUqrtJV+JtEaBZnjIDmDgt/Cl9LyWs2BtVRdO1YD29d1NM/U?=
 =?us-ascii?Q?JPP53Bpw+HldAn8rprXrBAPxorvILqULOlYHbLvWLKuFzf1sdsv3Ull19mCv?=
 =?us-ascii?Q?8fpCIfVWddY9Q/cgUz9+iElzPzZ1X6YnLDHHWl7xUaNYy/upWrh5UqnHO4XX?=
 =?us-ascii?Q?t3YHx/THLUfCKUwDky+NEAIuge9MX9jSssz+IEB2B0dVcynJWMJ3oNwu8Joc?=
 =?us-ascii?Q?kQbsS+tr/TacnWmb5ij+lokKl0gXmSU2paMGBU2P7FKJvpxK7MvR9FFkMIAY?=
 =?us-ascii?Q?kQfLV7xbb4PvNKRo3aZQxMDRYO6BksZJqyVsyR9OiaP2W0w1HO5sYIr3HC33?=
 =?us-ascii?Q?+lCK9eC4WSjSCuohiX0soqv7LXB3Cxaet8opRv0TrE3PxzJVrOse3jsc/lB2?=
 =?us-ascii?Q?lKArndRXNQphB2FhTLtrudt6clbQMJxRFA/8oLUmIt4TEueOzatFIpHcVqWK?=
 =?us-ascii?Q?W+OP9TNTfO8rwW+9R/emcldJ28NsKbu5zuK7Ci1C+2c7kDjueEkq5C3jPeuQ?=
 =?us-ascii?Q?zwm6Swwno8EiMCaYd5eCpq9I65ALpx3cGHZCGcM+dfkCdhItKshkhOmSNP0w?=
 =?us-ascii?Q?7Yv40Fy2eZ6gdre9bZtsPIwyl1wP2sJ2bpyrGdGMxGc46F3i+bv0iqeqtwPq?=
 =?us-ascii?Q?glsoqtCfrrDZJLXykYYG00wkXpGGzt865GZBtkdd83Ie+wnrcZMileqckdg6?=
 =?us-ascii?Q?HLyogowjKPX15KgIWA1vtmXognH3QmTkn3EuMBGdlnB4Dv7sk5PGRoaetmqo?=
 =?us-ascii?Q?xTZ57vkztv86O4lixWqLozrQwvMTkJse9P3GyzjiNPAr5Yh9loLB7DlyQORV?=
 =?us-ascii?Q?eWcyXZLuLcHjpanyvhO5RHRr/ztA9M7HSCV1dK+0ROVQNncDn4ksLXxfYqMC?=
 =?us-ascii?Q?36euhJQZkq9uIfC+zpm5KdgQajkk6kX+zbH5cFeeLFuo6RJnyH96mQ2iPMVm?=
 =?us-ascii?Q?NeDolBHjuMEb+3zxhh51gUmSD+fiA9fRCCgA4kB72nWzGgkcc91/JxRTE+B4?=
 =?us-ascii?Q?iMXe5uX6N+3OmLO2gnBR8ug4IXr8Nrj/N20lxZBMpmMmqHB7ySkL6Sa8I223?=
 =?us-ascii?Q?sgTJp3ReZ0OTtTbVPZZMeCSMaLpw+aYcGGSed5f4p4TMIDvIq9WxfUefmeYS?=
 =?us-ascii?Q?WWejSV9oCMYAbRaCB/V+QjNENKwNJPq6wF/m2Qw0Vrm5lj4Sms3MHNIwmGHa?=
 =?us-ascii?Q?NQHTTHlHnDn/tzEiVqkELL2Vf2rai8mi7eLQnDRj6CqgaOx6wTtk83Ggh4GR?=
 =?us-ascii?Q?Gu4by6J8r6JOwI0aWfrA0Z3ZPa1cRDxh4VohgSwAJQBN09klWJuvQ+wtR2m+?=
 =?us-ascii?Q?7A67yEjWGXH72Y46ttuJbIU2BrZLdSaaAmuE/uhaO5miYatp455hfLHSp0cF?=
 =?us-ascii?Q?OUoDYTyh+sNEVuEOoexqBM/4ZbEmISKMk/KzZLh97koixrYK6EfV5k02fkST?=
 =?us-ascii?Q?3VzelbNnqg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 3yV4FmZxGDh792qYYSglP0kJkRoTthN2brH5Rp7dq69Cn5Kd/YVy3PJ0NF7Ykgd4s0+L6FvFY9XHSQTtnhKj9G6H1ktSrXxe9QGD4yI1Ry0Dszyh4XC/zi+uS+hx4XIeoix8qhpqSwst1ECXebRVA49qRlzXaBIRnnbXL9fRl71bG30lcG+ODp/MhQk1YZFcB2PIbik46iOnziMWauk5K+XmyA+CM0KavzCAkzJFhHHAkb6PC2pYJlQBFjpmvAi2JRVnJZPeGiD+0izbIBCQpQK0NnurkUC3b6NXwbI2kVuDQHo2zRhUd00RccCDE7l1s7mnR7bP5vRqhGXb1D/xWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99078135-1304-4dc4-cfb4-08df29dba127
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:12:18.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQAfRsrnJCIM0ua/9x1+NtWfCaoEJ6NCu/+thCmzk1qcOBLsB7iVrF6fS7vbQgbceAyOAIVrKD05CWVTr2cMxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4727
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

On Wed, Oct 14, 2026 at 02:51:53PM +0800, Honglei Huang wrote:
> kernel-doc only recognises ".. code-block::" at column 0 of the comment.
> The two examples under "- Pages:" are indented inside a list item, so
> kernel-doc treated them as prose and rewrote "&drange->inline_pages",
> "&range->notifier" and "&ctx" into :c:type: cross references. The
> injected backticks then make Sphinx fail to lex the block as C.
> 
> Use a plain "::" literal block, which kernel-doc accepts at any
> indentation. Syntax colouring is lost, but keeping ".. code-block:: c"
> would mean lifting both examples out of the list item.
> 
> Fixes: cc2a6cbd6823 ("drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages")

Hmm, I why Intel's CI didn't catch this - we typically build kernel doc
but perhaps we are building gpusvm. Let me check on this.

Anyways thanks for the fix:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610100125.d4Kk60aL-lkp@intel.com/
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b6c9d3a07dc..7b166bcb0d1 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -67,9 +67,7 @@
>   *	sit in contiguous memory so a single drm_gpusvm_range_set_unmapped()
>   *	can mark them all. A driver can keep one instance inline for the single
>   *	device case and switch to a heap array only when more devices join,
> - *	e.g.:
> - *
> - *	.. code-block:: c
> + *	e.g.::
>   *
>   *		struct driver_range {
>   *			struct drm_gpusvm_range base;
> @@ -99,9 +97,7 @@
>   *	The 1:1 examples below pass @num_pages == 1 and &drange->pages. In the
>   *	N:1 case the driver instead passes the whole array and its count, so a
>   *	single call faults the CPU range once and DMA maps it for every owning
> - *	drm_device, e.g.:
> - *
> - *	.. code-block:: c
> + *	drm_device, e.g.::
>   *
>   *		// GPU fault handler: one fault, one DMA mapping per device
>   *		err = drm_gpusvm_get_pages(gpusvm, driver_pages(drange),
> 
> base-commit: 34081b8bbbbfb9adbe04f764f718de04df23a84a
> -- 
> 2.34.1
> 
