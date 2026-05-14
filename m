Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A2CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183AD10F269;
	Thu, 14 May 2026 15:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mHcAgym2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FBB10F269
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778772239; x=1810308239;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ImIA5Z16UGQqSrwNO9xbMHze6YtKzyqPQUTig5qB//A=;
 b=mHcAgym2rFeg86zHg4HJZcdUC0ZNyoKVS/r4C7knbiPORBXTLCV+b2mv
 T3x1mwagnTkxle/agKzdm2Hn2hNlsP2MZdfB3WRLloPenjrGyWbre7Vr/
 uN6lRkyngfDw08BTRzIhNgQRfCtg6PmpChJ+qnjv7+wMPA3Xt6jdanz7Y
 jl+or/NXxPbdBsnQyeHXG10EGnj/KwmPnv28VGwFMJyqDRWB1iudFOSq0
 f1+uWBBacfkb3SE/5z3D8+UdP+C3DBgfoUoY8EL7QFFsCZg5adk/sf09/
 BQUvm0usIbe4AU5Psh2dG8hbiIBtKGoRdSNV0mNMKjQS2d9HPcjfZreWW A==;
X-CSE-ConnectionGUID: ylbwzuHYSo2duUedxiJUOw==
X-CSE-MsgGUID: VbCh7oavSzW0wb9nvZxtiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90410410"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90410410"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 08:23:56 -0700
X-CSE-ConnectionGUID: BOgdAtkBRzi1Lz48UNhtNA==
X-CSE-MsgGUID: GD4atR1fQ1itquSCxZrLBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="238668881"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 08:23:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 08:23:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 08:23:49 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 08:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9j5spdhQSc96WaEIqrze78iwCeF1dyiut69Z1/pmj+q+SaylR4r8ICe80Vcx2IdTyEzYO365+J+NzP8c35u/HISJ2bTEvZkgKn8lBjprLd7oM5B1OBgkqz3mw3pJcbUPINaqSI8df7e0l7q47s97CYQ+x/VFAC5rNndoB8cgIxbFfkNKO938txEO8hfRHUOU60qnc0tH9XG5Bfi176zXZqDqeskVyi60UizCVbMWZqVcSaCbyCeM50t+eXq+nq4kvyYmMFSG6IecUxNNUxwdeB0Ys0OPLDt7a8GVB39yPNTyxFBtjWk+wwY+CQtdgcY7Iuytuq1cib8MEWdE1GBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9rwp/fWtm96ZJetO9B4kk4T3gfbvgrOr1Pg+O3jigY=;
 b=RFJZgLx7l3xB64Uj5v3M80Ng+yfZEBtfnfVaA+jCpPLRUZmEKHtgrBDG1ZeEcdS+p9RDgcGV3w5WnsDTsn2M6ryjEwvedkcSfgOFvXNcH4opuSFPPZNSxsvbDNhNT6a4lEh58rHdxpVIeITeokTLhQera5dd6VkJzVSUfdYvv2YgCOYSJYm0Tj5eldtkdTdLYzHrkZs/xNTR3R6uUPPe0hdI4qBFTJZVqXLU9TSlmDNDhZF9hakVsg7JUB2AgvZWHp+faWunLCWDLrVB0Bn9RlZzFZY9M0ilwG3B3DGLRg+7erfT8Ln6kVl0dyovyXagUV+QobOXDtULPSnhX6TZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 15:23:46 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9913.012; Thu, 14 May 2026
 15:23:46 +0000
Date: Thu, 14 May 2026 11:23:41 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/gem: Remove unneeded ret check in change handle ioctl
Message-ID: <agXo_e9O-nKJ5H-D@intel.com>
References: <20260511142540.2989187-1-jonathan.cavitt@intel.com>
 <agXnRdDmtGvIsmot@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <agXnRdDmtGvIsmot@intel.com>
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae936a-abc4-490e-88d8-08deb1ccca30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: Y+GZzOZLk5ZAwU9IpQZkrhbAuKWY2ualB+uObMEFRTMMZc3+FqFT1gDf3eLI6zVKos9zcSSr2DMzvoWhfPKYeguqJxuh2xtwr2y8Ttwv6O6kI35dgWLn/6wEszXkybkuUvkgnZjY0aS5jqnNV2siTr/7MqiWrs/rzzf7yw28bnPHv5jUdtMDclMOV55LVO1DZRqmvJLifAvkUFBiYQhwcrGiZ/BK4VAQC44S6CqH0ihZhDKQy3v/eDSEoXMZr8KzzhtMEZqjQke8omMh/FndXCOPmFMmmE48cm1MW3+mbDThmdinriS4+BfDxYi5Vqmi74zzUrzVaqLHnOSfzlmRXze0Gez4q+hqYtHZYkVxH14Se1EQVXkouGpYBrPxnnpjH62VIRepLw8pyNRZA6nfN/zAogrC0crctlWmvAZZgbra/W8BPVGimiYsuzvk+BakCAFaH/7DO01Tdpp/mp0r1ZfYKu0JOrMalsGmIovea9KpHhRoWhhwW0tztxP6LtOcGQ+67/G0Qnhfr5P/exhXLfuog3+9rqcdJuI+eByFFYDZnCeBXf85OOESMhuiskkDopXh5lnLFBU6NTmx+Bc7cDCuoPFd8dBVfY5ogzvk4gf7XYFQlWs23KZrWLnOZg0Huuuqkq05ZS+ENrL9PrhNIJsZaMnbTUPMSUzmeLeBlgOSH7oOv8/VYRqrm6Px3AHU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJhvNBEV5LMSHOGC1Rz+e/5+7mHI/rUo19fXeBKSVddt49tRUX43nmYeHEd3?=
 =?us-ascii?Q?ddIsurud6B97LGxKZ65bWmrt6xaz3UsXrrpyZ9ev3m9mNVUXuUS534JXPzaH?=
 =?us-ascii?Q?csxY2z6pj0LcrVKcZEBcWriNEACePuIzcEF4p+M/lcQ7wM5XNY0qYr1Pikqq?=
 =?us-ascii?Q?1guBLDniP1z+ZtUL7VFHwkbMzIPjiSnRHMCLnGLoGq+OFrcwr9E3q7qjWfEG?=
 =?us-ascii?Q?80wpl5a5fRrrCt1Yllxt/tL8N5jCmCYAAkDS1cv2lZTq4/H3FIvjpBpJxThv?=
 =?us-ascii?Q?FetketBVY43RUSo+SXp5c6Hn8PopDowCLrqfSv4OWu+ZEZDvxdQI30SEt0qs?=
 =?us-ascii?Q?aM+WAp1QCfd2SRcpDjmlyCuWfVofjw1P+SLIFHsf6df08eGu/P8VBnT9JC/n?=
 =?us-ascii?Q?OMQHexiX2/Ws3WueiKmHwcMbwwrHypf34A7k4xuClvY19Me42dQJslla3/No?=
 =?us-ascii?Q?R79vSFyKhrtn/a3IRzQ0CdD8bRuoeoLjhyYYTsQM603G1XQsj1o6PepiaR1I?=
 =?us-ascii?Q?rKq0AJ5YRhALe7eF7cbM5aSoQLuAGodxtPvxgTsy6//I8RGUy6aWzb2DxQBd?=
 =?us-ascii?Q?u53e17FO++9TThVOCCUdSkGrv2O6Yfy1zmJ73PKrhIkmYA8QWo+qdeuK6pZU?=
 =?us-ascii?Q?4bVHilkpo5qIqr/sisDTzWo344X73rpj3RU/kvIHrsemvLaxUsQoWmwY7RiY?=
 =?us-ascii?Q?SzRyVvoCXUBotBMW7CXPFN8Et9fU/Fk8k1DY/JGZVfZ+kQCgxPlN4wQ4mXGg?=
 =?us-ascii?Q?A20XUOeoovRusSyhXtpu1tthAjN7ycjx98XzG8zpEhArDDNYR5iwYfUurR4p?=
 =?us-ascii?Q?mEe35a818UEUgaNQMjwTi4JrL6Zc1FjkHcy5XlBwpfSQDS3s7GigAY2BSxl0?=
 =?us-ascii?Q?Pn/DrKIPLhI4AxdIzI57suSFD+HxLwiyg1UVT92yln0hdv+bf2iKOiXeYzRu?=
 =?us-ascii?Q?1O4hRC328mhiJAhanDFo1edY+zzh+yRdIjh4/yNVaXN0U2OsMHjdLutRYWFd?=
 =?us-ascii?Q?IHHM7o7Tw4L7ChqieBAx57ATZiZuX+Vr/L9gWrZCE5YcYtER2LsfKbm6L6FS?=
 =?us-ascii?Q?a2To1hw96RtffYr/WTPa32E0a2OY5GhK+MoDvlpxoBkw0PyqJPBk6uzmWEN8?=
 =?us-ascii?Q?tdbf+T7R14nYykPKNrsWnNtThfBUfi9kvTy4slO9yLvxlFfbbwtkNe1scP7g?=
 =?us-ascii?Q?xageND+Ldat+bHhcw/+XC/Bm/4vlKfk+rZEcg7ZBqaje1KhFtj0FQwVxyNi4?=
 =?us-ascii?Q?s35XzfGkm9vNVaVKmdKR+EquisJ+jg5NPhbItqdVVdlT9tAk6oCshOGjvtU0?=
 =?us-ascii?Q?J/qbhw0hQGFBMmDnU5DuayeNyRm+l0vRScbzum/OhRZryI8crUhs84BepDvQ?=
 =?us-ascii?Q?2UonBIUWglBncMopvKTKBRM1+a/zJXgxqz3bp9jV2/spnK6ziB049VcHjvpw?=
 =?us-ascii?Q?hy39vxmkl3atEEE24WgX5DdSMHdgHc2MG9hEucgvmmkrw9tfKxXvStEJJ186?=
 =?us-ascii?Q?utzN5hDPN5/3g7myGJ30O1I6XlCasK085QQL5mRk01qR2N9T6BiZqNFsB3jn?=
 =?us-ascii?Q?p2Oeado4B9Pq/qbk+kNnALbRt/pVzRccpJLUbQZGDjv7Wz293djWXct5Oq+L?=
 =?us-ascii?Q?D8bGzV8epMqbhVs4eNDjYRUI5HDcqFY7G1eqSgZxZcW82acO1iYmQRqsmDDn?=
 =?us-ascii?Q?VmHsHn4t9xS/leO1uHZjLmSgoMm8tZXLnOvL27plW8Jqb40JNp0i4fdBpTJS?=
 =?us-ascii?Q?e1AHXGQ+MA=3D=3D?=
X-Exchange-RoutingPolicyChecked: HqSVZQVFbwDdV0RwJO7j5jIoMQWKOrwvc112yiovbf9HkCOAiI/+RolEsp50pHXyVYKTJMF0my/FHW5MF2Z59ZLdvpMx9qmKxeJFWqjwAPkwpaMs9MKKDirqt3jL4y4cUsO+ENPO6qhH8XYAVfl9vchvJzlaGt2jTXzYQLxz2eeVbwTHLypENlAY+defOFLnnhdlDAOe1R/6ReLTJIlSta1AWF3DiNIllrF04ZRAOtHLUXNw4TIhCcC8Y9fl+DaoD3TAtgUtbOkUrw/2ajHstI9Q5hj7k8yO2js0E2EYa0YyCskBtDcn4nSlBeFGoV21D7ddu4Vhr7NJncr30XItOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae936a-abc4-490e-88d8-08deb1ccca30
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 15:23:45.9736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lu4H8DJHZjJ9Q1yIHS4NrM7bZoHvGb9ceHoIfhKy6LL70Ex11gZp+ulDaFRbsFVuqVRebjNZ46z3CxRPQm47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
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

On Thu, May 14, 2026 at 11:16:21AM -0400, Rodrigo Vivi wrote:
> On Mon, May 11, 2026 at 10:25:40PM +0800, Jonathan Cavitt wrote:
> > Remove the "if (ret < 0)" branch after idr_replace in
> > drm_gem_change_handle_ioctl.  It is unused, as in the only place we
> > modify the return value between there and the previous return value
> > check, we also immediately jump to out_unlock, bypassing the check
> > entirely.
> > 
> > Issue caught by static analysis.
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

It doesn't apply in drm-misc branches yet because it doesn't yet
have the culprit patch that caused this code.

That is only part of drm-fixes:

5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")

I believe this patch here can wait this culprit patch to get propagated
through a backmerge/rebase...

> 
> > 
> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > ---
> >  drivers/gpu/drm/drm_gem.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index abc8e41d6652..110bc5a58862 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1067,9 +1067,6 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
> >  
> >  	spin_unlock(&file_priv->table_lock);
> >  
> > -	if (ret < 0)
> > -		goto out_unlock;
> > -
> >  	if (obj->dma_buf) {
> >  		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> >  					       handle);
> > -- 
> > 2.53.0
> > 
