Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFF606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LVJ5Vvbh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C8910E546;
	Mon, 19 Oct 2026 22:01:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF13910E546
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792447305; x=1823983305;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EatlyjGfnct7x2cVXeYBTbER5eXlU4G4cxD/irzys+Y=;
 b=LVJ5Vvbh6YzbuICqhTx5vCwm/btEaSMN29e711rgW4j3iZgECSF8UTjL
 H2YD3/GXj5HZNOpRUDBlE5Ja/lsa8W7erYDhISoGkOpWvxr5aQCnzXBRr
 RCtqbJLs7VWkZKICq9oIte/2sddJpP+LRgHNDA/ZZ67AE4LW3kw1Gw0OS
 2UTeNBM9hzj0Kf3RA/wC1cYmBHdonwPwTh18+zL8ukZjRb0uAkEsQn9w/
 3vIX1V2gS5AFkvvJP4H8NzaIZsmguizOtU9IwqB4inypIwUvpJwTQ7UV9
 4zE/EC+cXcK2ppaTdrQPdmZSAgcqdVTG0VfATB1F7d3IYuWu+5RCXpRH9 A==;
X-CSE-ConnectionGUID: 96AaJtycQqSDxgO51QrjtA==
X-CSE-MsgGUID: lzgtCtReQWO3lY4zzsxUWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1127824"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1127824"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 15:01:45 -0700
X-CSE-ConnectionGUID: CDw4F2TdSyqZzetAuDXLuQ==
X-CSE-MsgGUID: XciFigqoRG2ogTLGF112jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2955758"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 15:01:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:01:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 15:01:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYt3dKTF4poAHY6UT0QnzdyctWb/F3ZBitj12BBQ9P9h3PYWIYp/DBOX8bH6+C6AW92udOdiiQA/UrxYM3rna881Xbq0akseYvhACHzeYm6aPc5Z8RzLLOZHakPKGfxfbSEJPVVI5RLV5NDXQQUeNsB8Qfqn6+kwP8N0Tec7lyL68vJWpE8NagkczBnoDkuV/6fuv7hoqUVXhsWgAONm1KDCmQUp0/y8z0AZveE0T/jgRhoeXx52EekZkIyujPnOmiWddz+O5WUg/MTDox2O2bT7v7emdxka72dBDNjHs7NH/mXRO1tO+slFLMsgBOe1Di1fe4WHvCLhvzqIA9vQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyzubFVdyN4wWbnvShAz/5R46a/5QCHGa9F81QAB9Q0=;
 b=UvIwx+DicrWVRZ4lOV9w5NVRaYMYGAkcYnnzMG2COBbudTSoHeP0XBPBmONkZ3t2E4b1ABKXnjoe3dWk4u0bAsh8CW+FZlJe9IY9M+QI+flJX2bmwFz0x96ZcXjO3gVh4r3l8q/Up3XqbUcyFq/VM45cqG9691MvxaDA0r91+KBjJoaWeO1g71RSfWXQ3KPv8OyfApUWXGAPnRzopyHDIm7nSZxWbsh7wWmQlsm2llJ0mhJITqGFNNkainSzzleT/Q6KtKShOZseCBx5vXoaL6kOwffHih1kMKKiZWKuY/BhuYo8+ZdvwOKvP62xa7KOgLgESBvoGqU4VbPpiUGbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by IA4PR11MB9229.namprd11.prod.outlook.com (2603:10b6:208:563::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 22:00:05 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 22:00:05 +0000
Date: Mon, 19 Oct 2026 18:00:01 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Raag Jadav <raag.jadav@intel.com>, <dri-devel@lists.freedesktop.org>,
 <riana.tauro@intel.com>, <mallesh.koujalagi@intel.com>,
 <matthew.brost@intel.com>, <andrealmeid@igalia.com>
Subject: Re: [PATCH v1] drm: Log recovery method with wedged event
Message-ID: <ataS4fxcBQ0MUA5W@intel.com>
References: <20261019025853.140747-1-raag.jadav@intel.com>
 <8d50e095-0aa1-482c-b638-679232c8eb17@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d50e095-0aa1-482c-b638-679232c8eb17@amd.com>
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|IA4PR11MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 07832857-8b19-46a8-48e9-08df2e2c54e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 30VkP/znxDBJrsPEgtAKZ+zeEym1wS/K7hlo7lT4qd7987NwFo8mi+qwiL427GZM5qqrDYYMQp9ih+wDUO7i0/8Fs3GrxC9wiBPlIbuCLvX3U/ey4Zv4QWjFWDprEg1i5+RCzgZ5kyDRSlCICRHe4WZLYoGnLUM2yrt+AR4i23uhnsfb+nO3ewSSk1It/P3tkX7zBnZFBFfw4w+tek5nD4Gye46R4Stx7M8jxlGNnvXPfsV3s/MXDBIGFe5Zjl58ff+igcJd0Ac2I7lUCcG0DsPBcWTO/FxSRc4HdzPV3BCXLzBTSSrMcxgg2XGb5KETenD37iTLYmFHeSqcECjucmDAOve/Sp93+TIlJowHQnjcGO/l9ioq9YczS0j6LG8Pt8jcQkPZLl47iMIgKUot9gOQrWksUW8hSR4zvg3bS0SuvYg/RBWDSiCcbdLIzrZfP/XOw/tLsIJmdR8O0HO4LjRkqEFO0Hug6ufRxXz9+nTnfpIZhw4Mm8MP0LKsLvGC63msQOnJlVcpUpHbtdu6OtovdDpPJyYhLudGn1PP42qQfMTstfithuyNYyjmbl32xtrSVFbjvL2ArYKU2PIUhu9NC/cMhVzR1MAs1ysRk0GkjLThCX4DkHKQlDHmzVU6IZKayrcktflhlfLoR9pcGV6waM+uQrGXu98MEg/5I8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KovpGSSTDDf1lZzefa2g6lWPQWQNL9cx81IEfmS5lmQ0AqYuEXLU+QS1YQ?=
 =?iso-8859-1?Q?XiU/5lgIl+dYCN4ywx7drEr7d7lC95S0tSqxpLcnRDRyFVD4caWdJ4iqEL?=
 =?iso-8859-1?Q?G/70KoWuk3B3PFKaS0U7Nz7rNiL4QKTNWpJU13rlHvwnsbF0PycUwET85k?=
 =?iso-8859-1?Q?3YJDI/H4uHoFiTTkyRLYwzZig4p6twl63BDwpqAa9vLaggKe5EwpBg0NfN?=
 =?iso-8859-1?Q?C7QnI6fh34GwM2dP4eG+xg/IrTHyl1C/ijDIku3MisK5ksFiF4xzJ8uodG?=
 =?iso-8859-1?Q?2OdqrOX2NsHWzd+tZj8Ss+Oato/EswKY7Y+lm0fC/uH1gNwCZdPlSvUPU8?=
 =?iso-8859-1?Q?puTmUTC5thvfp4AIUroMDOLUGs1UmQxaPbazRyYh7CpDenroDSBE4YvfQ1?=
 =?iso-8859-1?Q?gd8RddHZ2rcxf8uZ5cZP/dTYxBTSzN/kPmRh6L0cVOAhIkQtOvoNy4WgAE?=
 =?iso-8859-1?Q?KsST9P+lblFT1H2LtKJlO1PFU6wD4X5u/eaDEPo3lAkZSFYKXyZp5XgMPT?=
 =?iso-8859-1?Q?2Nl9RdjFFTxQIAun1CgdM7COQyldtxkoq44JfuJgZ3zMheRdNGGhVBn6Uy?=
 =?iso-8859-1?Q?HUvzwEZ8IXWKc55AET+oE8hgoGvixAK4wpeAdAGsFuUvXYYijISL5/UuOz?=
 =?iso-8859-1?Q?4Ss1q5C9txEB4ja+zep795reiEJUm7lT6X+UIGD9IBbH59r+YHv9I80dfD?=
 =?iso-8859-1?Q?EGBX+kEAoaQlk3W9p66RXsK+ToyqSYF+IldbJ3BJAhAPfvzfMvFizsX5Hd?=
 =?iso-8859-1?Q?LbxIfG6sqwZbLKTV0wQtYUsOEJYpTrkKLMN4aOJ6EfWIfAlCDB9GtRygj+?=
 =?iso-8859-1?Q?xabHj5fbLWnzuchUu0BWfFc43ZMvVSSIDNvxBx3NMf6nuMRhJ0udsGhsGI?=
 =?iso-8859-1?Q?7qnkwXotUWCMZCaCkpMFKjECrRk00PTBG5HJhLT9uqWwjkVStsa6H8mqD0?=
 =?iso-8859-1?Q?yH3wLYjjoItEW7oTE/E/UnkcMkdBhMcxv55gYdZAg8QXKTHXG/Y4imjdp+?=
 =?iso-8859-1?Q?FMEJnfmbt3MCx62ZMNNvuQ/ViAkcieRs5oBPrD6JE9+XM+pYn3+bJ+8vuY?=
 =?iso-8859-1?Q?uDJYlLhc7kdJEHEcW0WA/cUrBcoaN3EwDKSY9yMrHPYvj72UQmgVL7VWMO?=
 =?iso-8859-1?Q?Ap+93+bJNcyw4logbKqmRKhDVuflP4lNeuP6iMULVLqrgQgXKpo5W8hTrf?=
 =?iso-8859-1?Q?Q0vvIfm0oyp4E2zGiufTsjJVlopwEi3RKsaVsIZ1ePa9iAcUMjXqQWqCSt?=
 =?iso-8859-1?Q?Fxe4fyaXaU19UfkXulpF7QRa1rRsDu2qifEDlvpCL0K2/Ko/Qshn4mSKnQ?=
 =?iso-8859-1?Q?mKfMmhezbaUHzo7M9nPLiofh6ujZyjH4FargRcPC4AP2nYjVMHDIieYk0Q?=
 =?iso-8859-1?Q?oMdNZyl03OcMrQe5a+3pKcgE2pZFpUzoRGIpLuOkytAN492xV2Nj0EYWcs?=
 =?iso-8859-1?Q?qkeKZHpENK96CXiVExiqouv8zKQaM1rlrIHP0D5sup4pZGA37gjHGr1pb7?=
 =?iso-8859-1?Q?anQVfNKnUmQK5/ZNV2tLZdIl5izq6iRKSd8UeWrpI31AR3bUP1MQor7xVS?=
 =?iso-8859-1?Q?sy0kFvPC8mP8mCa7tcqZIsh+7Y8I5wkj7IeUK1QcCvcnkFohP0QOiHXxvh?=
 =?iso-8859-1?Q?ledDVFgrXuDMcukkaH3k2Q75tAFFfNz7/A4hrqLcIfERkoJBhaOLCiQqJx?=
 =?iso-8859-1?Q?3/nXpU+jYi7i60g01py0qAnYim3KDZ3w/RR+wCr7kaXmhCfmuHehKN07YW?=
 =?iso-8859-1?Q?WXch91uH/mC30DNWv4LZEc9J1fHOwz39jN8pYfaDVhOTlPqMp0CtzFJ69w?=
 =?iso-8859-1?Q?o7yhgwIZzQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tJqpzgs+ZLZEtTvj29mp0YWMcpCyIzFSy18rH50ido+InXnQAU6hiUXfiunns/3DWSzRJuI5dZtboTyOuqT2rIZoD0S+cwc0ASu8zDJHPkRUwVn2QCL++nkfGbyU2FrDA4a2NGibfo3BBrIQNvIr05w9RnZ5Ws/3LGCxi3WbONL7KzwPAvDwJnpXzB9pCradrKSPfU0kTyj1nxWn7Bs+4cnLTeeJe++Tdk0R1PEJ3dLt0P2DQbQ+Xkdcebd7IqjlkxY/iZ9OBsCjxo/4cJL/TYYlRShbB0+OKa4dCJ4ET+FHgjSYMcuyGzUBRRxmpza09k7XdEU4BKr5wSDORew2OQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07832857-8b19-46a8-48e9-08df2e2c54e9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 22:00:05.0247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pS5j0/sBt9QEm1Gh0VKn2b3MyMzkGp9B990SKioM+HtJzxrNqEms5L7yY5hYeW1y/kgwX3zTC6FMwaNmfzm5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9229
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 04:29:35PM +0200, Christian König wrote:
> On 10/19/26 04:58, Raag Jadav wrote:
> > Currently, drm_dev_wedged_event() logs a basic message of device being
> > wedged, but doesn't print the recovery method used by the caller. Log it
> > for easier bug report analysis.
> 
> That sounds like a good idea to me.

+1

> 
> > While at it, as the device wedging is a catastrophic event, raise its log
> > level to drm_warn().
> 
> Device wedging is rarely something catastrophic but rather normal part of execution handling.
> 
> So I would rather object to that.

right, unless it has some option to differentiate the temporary wedge by the
cathastrofic one I'd also prefer to keep the info.

> 
> Regards,
> Christian.
> 
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >  drivers/gpu/drm/drm_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index cb53baa70995..1a1213f4235c 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -598,8 +598,8 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
> >  		/* Caller is unsure about recovery, do the best we can at this point. */
> >  		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
> >  
> > -	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> > -		 "but no recovery needed" : "needs recovery");
> > +	drm_warn(dev, "device wedged with method %#lx, %s\n", method,
> > +		 method == DRM_WEDGE_RECOVERY_NONE ? "no recovery needed" : "needs recovery");
> >  
> >  	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
> >  		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
> 
