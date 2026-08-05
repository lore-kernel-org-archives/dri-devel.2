Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3FCC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0608210EFC0;
	Wed,  5 Aug 2026 19:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d8q26Q3+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF4A10E228;
 Wed,  5 Aug 2026 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785959318; x=1817495318;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KdN69YZJQlnap+mvNKQ2JqluG1lbeY22Em41/rcElyg=;
 b=d8q26Q3+ilUOvKrugnNmBG+tUe70AMyotarFtwhhX5I3rI/sce7YzhUS
 XPnCj/OHOUissorRb48ORMVceDIXSFtaaASgT1svLwvm8hx70b10jrSzD
 SOQ/c/r5h37x2URKUGd9uzfiWxo7iu5eZdxWrtZtCGlSOrQjK/RMqeveQ
 nnivFdmck1nD1lE0FmUBr6JFJRYeuKVpMJsdsuVvWsIiIW1yFB3L0tXFu
 0keldsMuYtFpAIySh43fWXxbZJRQ2zj2etfpSu9AYWUktedy+89t1horl
 OsA38c78f6H/l+6xS7NtUWaVMGiBbTFfTXMPENIFJf9mP+dhtzzOSiFkM w==;
X-CSE-ConnectionGUID: KBuSBbofSIq30pUVHfCHzQ==
X-CSE-MsgGUID: Z4d8LBbdSwKdJjaA+xYqOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90361597"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="90361597"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:48:37 -0700
X-CSE-ConnectionGUID: 5pFvWlYWQAK58BUmuQrmZg==
X-CSE-MsgGUID: GIu1KLJVRJC3we4B7lXdkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="261957415"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:48:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 12:48:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 12:48:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 12:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNU319h5hxrxWpKXV2y2fcdNuUhcLWYkcriBdIXSU6ozQHsdXc9ZWHTJlhtEAo8vijjB7TeorxJDas8YFvyXLIZBj/ua4kq59TEmEzX0M4OM1StkfQX2JvENc7khwTeL4qgfDCf46kHRhZtEKQD/AML0UDp+GGDH4Ex70WkS5M1W6T0IT7NShohXgZmDTJ5VUUBIsG13Y4KW7iokP6VGO9uehOtwWW3b2LdeSzAI/D8MLgQF564ivi061l2R482xOq8of2IxetiuSPUkbE6C/l8TmktO722zHGn7ca2Q1tZK3NqLBLG78Kbw6THx7VBJRt1PhTukwsU0pEHTdBPcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxvshK0jBLt6o4AFkL0c4VG4ilXLod2aneQ3TauU+98=;
 b=PpllB9PLkJg8OpCFH/nt6xrx3pjNstzcp3ffPT3KVO4ghweHtX+JGH6Kra95mdnWZFOjhzH2v9mRqNYcCJT3dBX/7UmxpIGBWe7wVtPAmxMrMEE53Fpe2+dpzz0Ijgi3QNlILJGla5ucUIGb3IUoeXiPAiZ/NbyoeUcxGMhZqEZ8//0j8xOC0VaYhDXNxe+pafB40pGMj0i/BBv786l1/214LCVHkMxl4yn/4lwmcOgZDnelX8AqOjbvBz0wwGsvHOWlzG3Fd5E/CefYcl9bL9HsEDqG/r4d7cN84VqZOj3B/59gr+Q1+grqiE8DBWGh1+TzIWlrHJlw8nd3PhKXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CY8PR11MB6964.namprd11.prod.outlook.com (2603:10b6:930:57::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 19:48:32 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 19:48:32 +0000
Date: Wed, 5 Aug 2026 15:48:26 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
Subject: Re: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit
 error handler
Message-ID: <anOTis8W8jdihD2i@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-10-mallesh.koujalagi@intel.com>
 <amkCDzvNVZOXNz9N@intel.com>
 <e1cb0cca-c1b6-4c95-b2dc-2f23535befe6@intel.com>
 <46dc1b3c-2d5b-45c3-bb37-e9f639c95884@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46dc1b3c-2d5b-45c3-bb37-e9f639c95884@intel.com>
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CY8PR11MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 160e8c66-ab7d-49df-9800-08def32a87a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: isTCn2EPa6cj62G9e+v/aaFb3xP91SRUasL1ZAagot7VbAARaEZFxWwL/otnx6hj2Q9WnBdluHNiVFUDUecbvpC2dkV9GoxKAQ9bhPfl2MVEhD++Aaf6kh8kkb81LhVv82wve8uletiqktjZuQLu/c2vb3uHZp+f0ZBSBLQIh9+6QPHmuybwnfbB567ML6qWegX/nUImC78TOSK1qJ6YgIc9s56cqllO6MG7BQe96uZD7mpnXNrx5NDcWrbVawKE6KsRuPDszbgSVL3acF3Q5AGSojB1R4kh1VTCDqlp3V6wRBeZEnGWcE9IU3QcolY2f07YwARGmHZZZKFwGjRytplKa/QyqsHd/aZb4unI+Uoqoyzoj8cHhoI7L3F2mixpMKjrsArwoa+GMzII8Kf3TS56KVc6RMyz+1dC+bf65Oqwf52W2ztJPWU/RuyOEpN2QBZdYZ/14BVFIiNNB4RlXqceY7vDWlTJ2ti4DBnIHcLwVXffsKkEglDlJvjdnAS/HLknMXvyGz7BINw+1hq7fuT95J7sYCRCEPfWytavm7x4o9vHjqrHB3Np6sse2AKQ2jWfFRwsADM1DPv4Vp7iU93XoSJSty5iMtOO7o7qeG4ZJkcyOBgM1rvDlpvMvpy20XtVknTi65zcxEQyvavwox5APt7WVyxel/LFvuiI6h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZmHLQquYqh5RzKnG3MKBI3lxDY3ZxD0xC10eD2MLrPACYUGr3DP4kGcCw0?=
 =?iso-8859-1?Q?Ilb1zyxunpguYwHtkdR21UcOEfegCxYxkpjwZ+4uvWnnZcxk9ucfxQ0JiA?=
 =?iso-8859-1?Q?exhZ9SOkiqeQPYMtMqVju0EuscpQ+9bOtLDwCKn4vrifqFYFAS0yIzT5ls?=
 =?iso-8859-1?Q?7pNGtMJkZFK2FecM+dQXqO4Y+cWWQZwWilRJNH6IVSITSkmU0R+jWT3ICu?=
 =?iso-8859-1?Q?gKGJGKaX0WoEXUAg9y98siatg9mUR14C7Ii6FeZjppSYMD8Cr5jzHZvO2X?=
 =?iso-8859-1?Q?xeW7TKAirpmSK3/s09d4xdnfuLDPs9Pm0ssRpQXKdvISVSkwvi77li0bvq?=
 =?iso-8859-1?Q?c5flSAuUE8zsjTrcm2JJcZ0kj36WVxHACH82hMUKcz0KBiTFyHnaKhGPo/?=
 =?iso-8859-1?Q?nOI7flulWUUNF5z1w1Qz+5gEDzCGZFT6TrGaYZCm5uKtFGlxdhvojQ385W?=
 =?iso-8859-1?Q?OLT6oSERpc+sVWokZYfMLvbsbVzI+lYyntHzkWViOf9D6UjrgA1rUpzVPX?=
 =?iso-8859-1?Q?h7A3U2Fnzr5zRfp7FJqER4wFHFtOWxrCpHTRGlFhoxUYh9LpWW5GdvEriH?=
 =?iso-8859-1?Q?Sucgf+ZNFYn1/tgbw9peVeYrCwxeMFnL8VTuPzGzzfg3BZyablzXFY+hBw?=
 =?iso-8859-1?Q?0lQfap9MXVt2y/GZt4cZf+/FrOdFO2Ig1gIKI1IOlsAthAh62uTlFkRW+T?=
 =?iso-8859-1?Q?lxc4nox5kkpn+Jzt+3ANV+UwH5bt3t0Lg2HK8E33bxmwTLuoF1BwbUfwrE?=
 =?iso-8859-1?Q?FqPWZrP4DVpadIJh8tkXNPc6LelB2xk28A3Yeq7dPD6ItfidMFj0Xpjd3u?=
 =?iso-8859-1?Q?4AiTe0juSE4Qqs8fkQEB7o8qV2LFSuSVMF22nUz7Yls2qGRncgx1Ra0TTX?=
 =?iso-8859-1?Q?Y9wRimdGaUes+JDE+vk/IqWZs2m3WnyRdhDMSv8YjuiUF70h14zCYDJMa5?=
 =?iso-8859-1?Q?HzG8vKw5qpXBdSiliEVbzk7kHYCuVCsN7LbehThC3VGQNNy31zk9Uk3UWS?=
 =?iso-8859-1?Q?Ni1Muglr+mKo7Mp+IyDUdIoVeH6UzQX9WWkKS8GK/2K/0BS634OO2U0lNd?=
 =?iso-8859-1?Q?ziBPzkOiTn0njOigWOLSSfT26icoaTYn2VyH1E9ghd4yK/uTQtkdlov8WQ?=
 =?iso-8859-1?Q?XV9KNjESrTrzyD0orsLmaWqWLFG/mCCYYRFFKASHhjE462shxgS0JnBSjx?=
 =?iso-8859-1?Q?laLzD1AdbmRPbMaFL7k4XCJMNtQDPYh+PIzp2D59a6XIcuFocjtTpVWXfu?=
 =?iso-8859-1?Q?/l+/7ko0rEC2xFh+z6YwTo5mEf2XaaDrF2zlc8LaSYa3UfQ1DYOk1cDkF1?=
 =?iso-8859-1?Q?+F6L9wjxMdPamMzYmNHPu2OSZr+iNLOh7DCThITd7Iz80KNp4Rh1DeuYkJ?=
 =?iso-8859-1?Q?HRxQa5WHjTSM2NE3fMzSjVxuCDBXDDOfjyMU7fmM81wf/L7WxkfrIYjZ4l?=
 =?iso-8859-1?Q?LUIoDqIWqduiZKff4OoTiAdyilFRkfPW7KAoMFhQyS6xG4qHJ4QeII5dAM?=
 =?iso-8859-1?Q?lC+GMJ4bfh9Oin3wSQbRwsaC5Q+ivDH7oRVxvTKzIwjE35/pa7kbd2lfVo?=
 =?iso-8859-1?Q?ADS2gjUCjpI9nzv+LKGuGQsnzzKmC35C5qIGgjmkAK/o3UVj7tGxxYn6pb?=
 =?iso-8859-1?Q?w1jYOIdMKfbvw679YN/xtyncfxeKbm8IfCVIqTjt14WvdfjF8I+lQB+MSo?=
 =?iso-8859-1?Q?1KpZ86i8zKihUvh/x+K/U+8I3innTE30ufgp+rTzKnZLcBIWsdc60k77Qk?=
 =?iso-8859-1?Q?YzE2qO7bq1Z/ofRa36Q7IGhJzqXc0+Uvcqh+qpPSw6ljiZDHT8jmWQNdt1?=
 =?iso-8859-1?Q?hN9mU+xqDA=3D=3D?=
X-Exchange-RoutingPolicyChecked: XHkSlItb8ZhRpjOAEtoHOnaSMD7ZjE+pgyu8IfNvc8cHXUJndDatfT7so8gSmf8stRB0jNDrwBUmQAfV3hT8356zqUdxkFv8AMJvj2Ll65H7Ie1ZIrPTC1qDx4T1vj4a64GMEuoWl35xrOTtPzv5/UQ9mdff/3jh1XbjC3MERh2ky62V0oRmsoHwQ8X0sALtVxeb4XglXnir8MtvwFywuIQOQJnQuHgVaUDGWlRarwEDvCeAwdmhaxRFhpsNAcdv2MUZzMi7RS6tbu3t8MG7WRi2q08IJWuGNTIRqILTpDMhh4lIAEyCLrWrQSfTZ3ZAyL+FwZ4uYwiyQjPlvur+iQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 160e8c66-ab7d-49df-9800-08def32a87a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:48:32.4634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7bZKxgfqdx9Y71J3lRZ5Qi8rTHw0te5X5dPT3Agb/XdU4RosuTKrZJ8Ghi1MpOFXxFfSslh7+rLA5rgEbfYsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
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

On Tue, Aug 04, 2026 at 01:33:18PM +0530, Mallesh, Koujalagi wrote:
> 
> On 30-07-2026 12:56 pm, Mallesh, Koujalagi wrote:
> > 
> > On 29-07-2026 12:55 am, Rodrigo Vivi wrote:
> > > On Fri, Jul 24, 2026 at 03:33:07PM +0530, Mallesh Koujalagi wrote:
> > > > Use fault-inject framework to trigger punit_error_handler()
> > > > for testing.
> > > > 
> > > > Usage:
> > > >    echo 100 > .../inject_punit_error/probability
> > > >    echo 1   > .../inject_punit_error/times
> > > > 
> > > > Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> > > > ---
> > > >   drivers/gpu/drm/xe/xe_debugfs.c |  4 ++++
> > > >   drivers/gpu/drm/xe/xe_debugfs.h |  2 ++
> > > >   drivers/gpu/drm/xe/xe_ras.c     | 17 +++++++++++++++++
> > > >   3 files changed, 23 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_debugfs.c
> > > > b/drivers/gpu/drm/xe/xe_debugfs.c
> > > > index 5a3877fcb0f0..5599d493feca 100644
> > > > --- a/drivers/gpu/drm/xe/xe_debugfs.c
> > > > +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> > > > @@ -42,6 +42,7 @@
> > > >     DECLARE_FAULT_ATTR(gt_reset_failure);
> > > >   DECLARE_FAULT_ATTR(inject_csc_hw_error);
> > > > +DECLARE_FAULT_ATTR(inject_punit_error);
> > > >     static bool csc_hw_error_available(struct xe_device *xe)
> > > >   {
> > > > @@ -62,6 +63,8 @@ static struct {
> > > >       { .name = "inject_csc_hw_error",
> > > >         .attr = &inject_csc_hw_error,
> > > >         .is_visible = csc_hw_error_available },
> > > > +    { .name = "inject_punit_error",
> > > > +      .attr = &inject_punit_error },
> > > >   };
> > > >     /*
> > > > @@ -76,6 +79,7 @@ bool xe_fault_##name(void)                \
> > > >     FAULT_ACTION(gt_reset, gt_reset_failure)
> > > >   FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
> > > > +FAULT_ACTION(punit_error, inject_punit_error)
> > > >     static void xe_fault_inject_debugfs_register(struct xe_device *xe,
> > > >                            struct dentry *root)
> > > > diff --git a/drivers/gpu/drm/xe/xe_debugfs.h
> > > > b/drivers/gpu/drm/xe/xe_debugfs.h
> > > > index cd56f7442b99..dd57914dd4f2 100644
> > > > --- a/drivers/gpu/drm/xe/xe_debugfs.h
> > > > +++ b/drivers/gpu/drm/xe/xe_debugfs.h
> > > > @@ -13,10 +13,12 @@ struct xe_device;
> > > >   #ifdef CONFIG_DEBUG_FS
> > > >   bool xe_fault_gt_reset(void);
> > > >   bool xe_fault_csc_hw_error(void);
> > > > +bool xe_fault_punit_error(void);
> > > >   void xe_debugfs_register(struct xe_device *xe);
> > > >   #else
> > > >   static inline bool xe_fault_gt_reset(void) { return false; }
> > > >   static inline bool xe_fault_csc_hw_error(void) { return false; }
> > > > +static inline bool xe_fault_punit_error(void) { return false; }
> > > >   static inline void xe_debugfs_register(struct xe_device *xe) { }
> > > >   #endif
> > > >   diff --git a/drivers/gpu/drm/xe/xe_ras.c
> > > > b/drivers/gpu/drm/xe/xe_ras.c
> > > > index 92b4181026cb..da06c16cf7ed 100644
> > > > --- a/drivers/gpu/drm/xe/xe_ras.c
> > > > +++ b/drivers/gpu/drm/xe/xe_ras.c
> > > > @@ -3,6 +3,7 @@
> > > >    * Copyright © 2026 Intel Corporation
> > > >    */
> > > >   +#include "xe_debugfs.h"
> > > >   #include "xe_device.h"
> > > >   #include "xe_drm_ras.h"
> > > >   #include "xe_pm.h"
> > > > @@ -391,6 +392,22 @@ enum xe_ras_recovery_action
> > > > xe_ras_process_errors(struct xe_device *xe)
> > > >       size_t rlen;
> > > >       int ret;
> > > >   +    /*
> > > > +     * Only allow the injected PUNIT error once the DRM device
> > > > is registered.
> > > That entirely defeats the purpose! :)
> > > 
> > > Sashiko identified this corner case so I asked you to ensure that
> > > this is covered
> > > and to prove that you should provide a fault-inject with test case.
> > > 
> > > But then you are skipping exactly the corner case. That makes
> > > absolutely no sense.
> > 
> > You are absolutely right!! Guarding the injection with
> > xe->drm.registered was the wrong approach.
> > 
> > The correct fix is structural, we are splitting xe_ras_init function
> > into xe_ras_init_early() (keep all bookkeeping) and
> > 
> > xe_ras_init() (called after  drm_dev_register in which
> > xe_ras_process_errors now lives).
> > 
> > 
> > Thanks,
> > 
> > -/Mallesh
> > 
> Sashiko corner case issue is addressed with patch: https://gitlab.freedesktop.org/drm/tip/-/commit/20bc4883c7c0e28c3ba6c76ccc279486c349dd3e
> 
> Do we still need this patch? Please let me know anything else I need to
> address here.

At least resend the series so Sashiko can check with the new base.

But I would still prefer if you send that in a way that that case
can actually be validated, not behind some strange checks but
pure fault-inject.

> 
> Thanks,
> 
> -/Mallesh
> 
> > > > +     * xe_ras_process_errors() also runs during probe (via
> > > > xe_ras_init()), before
> > > > +     * drm_dev_register() calls device_add() on the DRM minor's
> > > > kdev. At that
> > > > +     * point kdev->kobj.parent is not yet linked into the sysfs
> > > > hierarchy, so
> > > > +     * kobject_get_path() returns "/card0" instead of the real
> > > > sysfs path.
> > > > +     * drm_dev_wedged_event() would then emit a KOBJ_CHANGE
> > > > uevent with a wrong
> > > > +     * DEVPATH that udev cannot resolve, silently dropping the
> > > > event and leaving
> > > > +     * the cold-reset recovery broken.
> > > > +     */
> > > > +    if (xe->drm.registered && xe_fault_punit_error()) {
> > > > +        xe_err(xe, "[RAS]: PUNIT error injected\n");
> > > > +        punit_error_handler(xe);
> > > > +        return XE_RAS_RECOVERY_ACTION_DISCONNECT;
> > > > +    }
> > > > +
> > > >       if (!xe->info.has_sysctrl)
> > > >           return XE_RAS_RECOVERY_ACTION_RESET;
> > > >   --
> > > > 2.48.1
> > > > 
