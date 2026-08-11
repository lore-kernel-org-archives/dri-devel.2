Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E922C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3683B10E3A1;
	Tue, 11 Aug 2026 20:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XkcgdCRw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9D210E3A1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786479138; x=1818015138;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Z0NvpcMDlJuIm3M87W1ZjmY4yKaolD4abXcGxEhQGPo=;
 b=XkcgdCRwjCcTNOCtlRARB7SjGXTkfg7uEoxC8QKBNFRUsJTQji92WeJV
 wmocFoZGfqfAio9qTOxlh9fQljxqI52hO9uIMNMesiKeUXomClPWmZ45x
 h/XuvvAj23k3WUr+AJT6sPIGf0tYnqku8IUMQWgoZ3x0AbvaS5TZUlsGa
 r7AnUINZFR5IwHCqZyVo+tUbaUs729Dmj7Tmtpi5bBiIcimixDZp4LVU/
 RonbeYn2/zwuZVPBwIym9FwoCilrqdd+kqWMwfozbARYzCUrhaFKXEItt
 fOC6GrEhyJ/l8+QexVi5NUTUMfLAw060eF+ZcFgk7fjoMJl33IDx+MQQm A==;
X-CSE-ConnectionGUID: CgN+MZ/fTG2t2j1cZ0Y0WQ==
X-CSE-MsgGUID: x/5H1NwmQ7GbBtLteN8VwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86781698"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="86781698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 13:12:17 -0700
X-CSE-ConnectionGUID: 4OcZAl+pS1KbO/mqrCSFGQ==
X-CSE-MsgGUID: p9mOIyQgRsK/OnldGOzLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="262115000"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 13:12:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 13:12:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 13:12:16 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 13:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDH7jrwqZLhnP4fpL8OrdXl+zpryrduRcKqgt+XBViT61EE5vtEo3uK/Sl8JipwPEiu3L2fHoyRiVu74RrSWyoyLVGQWEt1euCnxVkD2ukhiwQb3wmPdmqm9x5e2S7GoqdBY0x1J3dXdtYwFT6rIQ6KPmdGl6HYtSx944znUAVgsj6OYZKusAMVdTMmaib3YKRWoQkFFTM7R47JBl2dYljaG2z6mUBBAT50UElyTZo9H2geTBEAo+2irtNLl9liEAaGXbkGOXj4InzMBoDI7ZCpYIX94b4+6fdfylbK4aA3Rla5TIiqFRyIf588Rc0q0su+fq3hylIK4/IUJM7k2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBb5zy98CoVuYZoz4AkrNgx8AbJtjppCftmNdfh6+3Q=;
 b=ePE09CovxeZ+yonnRt7azSuTbaOwk0p7XZG6cSSt7ytlYR5OXbY+woVYbhLZD3NhV8ya8SweVgjIsfM0byF15QCajVNy8frlMROz2zbmIxoEOnPMr8kPitjGF7I17v5gwQ5bEFbBOtwJz4oS2c5iLOHGDaUBt2Xu1Ud5ZQ26qvJ0CMFKobT8Hy89uG62lEUaRberdNYNxF7PcQCOEw+Rut/tvbM88E+AH3Ke9jauuTZ2UfAhOztllCDbQIQ1Nk1mMEjZMglYoEBC+fYl79rjZK+1/qVVCuNNwU/CrrfJxFBttBxJmL3KJtFZ8a2iEaoxPOXajRJf5MockG4iItNJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 20:12:14 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 20:12:14 +0000
Date: Tue, 11 Aug 2026 16:12:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Simona Vetter <simona@ffwll.ch>, "David
 Airlie" <airlied@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Riana Tauro <riana.tauro@intel.com>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for drm_ras
Message-ID: <anuCGPAUpJTs7Ztz@intel.com>
References: <20260805094949.536651-2-rodrigo.vivi@intel.com>
 <anMeN5B8LbaM41jz@black.igk.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <anMeN5B8LbaM41jz@black.igk.intel.com>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SA1PR11MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: d83f8778-9985-49b1-832f-08def7e4d5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|13003099007|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LS4HRNhyZPkQbTKOAxf+hMrKpTDO3ECdEz5/BWkS3/pCZ/w3qpjVE5vdsU6tHxVnZXr2gXoBx9bDnN+XJRxEerCPSlskbIf4RYu8I2SNJy+2KhDFNtaOgSL5SYKKXIbQ0LSRXzovbj4xPF1/NjQyTRoQavY6FmRH+ZoOVBp14Q8QH1W2LQGq38b/M5eEpYli6omSAzfJqa8lubxaj1hTbLacDYo5G93cbYfWSoffUUSXPvekGInG/2yjlnVPGikwVdObH3BZenynU2tL9rKzPM2X1L4SdbPA7VrPTxoKwi6eplqcNK3KpMIutIifySlSbZHaQdYV6BkWUYoaluGcYL8bwlrwVEv6sqrwFP9YhGjecoD2Abk5DLEig9ebtGId4TyrGD4RiyPiQzgGqxiOzfyAdqFUoqxgx0iPz9PJ1qk7Vx6XlA3Fviay2yac6MX4vbCvZfAISgcml6QIRIdmP7/eWxH5H5fx2lQ1kq87aM4o3QDFPJ/vp2zm57nWiE3dhOOI4oOAyjtyi0H69TGkp/57/QP0C1TnUu03bxSsfSUWbNSI6++H0tyLLiwDVdqqg4j3YwZx/i4H4+Pzi4CzcjP3MF75CsYnzsiYsWWUCTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExHqGdxQSHPKtq7wNqMtnUrRO3an+8AKS2K+NLhhfQICTWDS+ffAEDKHgv93?=
 =?us-ascii?Q?lenpinp3RYRQrGMda+Rhq/3y5Bbkdb9woViD6N7Vr0XM4w4A/FL9uZtNRAyD?=
 =?us-ascii?Q?2tau/q4nbowezLWnzSoAdHJlHriTGJ6v9E0+YKa/6mAQIsCuBq8Ei7ZyUOQ9?=
 =?us-ascii?Q?NEpRSf8bCrRn4yoOKtVjJz4anf3dNON9vQG8gJ6D+fhR6fDUZ0sMNyq8zbAU?=
 =?us-ascii?Q?7x0VJMTkdaxybUiSEClMOxQM807gET97Kc5daQ8ZGgBu1efkeHL4QI/o1UMO?=
 =?us-ascii?Q?50UWlUhfSFyOpi63RqfREFI/WUI1hbtRBZUkEZEH4mzDFGX/TQaEU57SFj4F?=
 =?us-ascii?Q?XIwQYF5szTXwXj/KD2tfoKjk60LVeyMmwikPRKaVqSmcWA0CUWfcT9/b1UG+?=
 =?us-ascii?Q?zY7sbcFlid5gxNTCj6sSFb7BWeTMZpQgmsPPmoiU3eCl4Lg4eHJ9n2h8Dls2?=
 =?us-ascii?Q?sxAZkwPqCu4Bz29XpCiYbl0n4WH+gu92AOVJkj35vpYDRARMaFDMvAnKmqzc?=
 =?us-ascii?Q?VFPkMYhoefdwlCwHee6ty0/gHI0wYc03JtN+qNcZ0neN5PGy9AjDbg+zAjhG?=
 =?us-ascii?Q?CwHD7EoPIZzkZtoqQaEUD8YURsmhCb2nHB0jcgWZiQW+hjGTfWTaz0f9Abw4?=
 =?us-ascii?Q?6/frmEMzadARA+58vXIg8UCcjxngFBSDMOmwUcQUgFLYAXW1FfXqRr/b6z8s?=
 =?us-ascii?Q?BAlryFDcmKJa/VHZOsSTQwn7o/tbSZgDSA8AFNRDADkDz5LKeXJsZm723nve?=
 =?us-ascii?Q?eWqtFJNUT/eUFHHTqAHbM/V9jznaKuJXRGR21Qoxknc+YPewQYBwD0y04CMP?=
 =?us-ascii?Q?W754fcSCTOc+kinyYJ2f2QbMelOyJjckpJ7TaiYJ31htsEuth/hD3r6FL2ft?=
 =?us-ascii?Q?2/O/AKbJoifUML98hh2ufNkePkOEMMvoD+CV/SEkNcj6wZoitsfIIO63z3tw?=
 =?us-ascii?Q?Lnxi0XOMy7j84hezh7RjuGB0y0Ao8sSA1tBp2avR50vPCy9wBdnc+QUT3qBO?=
 =?us-ascii?Q?7DxrplrXGaDbv3cjIiCG7gOAPNR77fU2beYoXhiyn97YjPR/fwsuLizMDU/Z?=
 =?us-ascii?Q?djd176J/j4MdIKJX2xviwy30DqM+Cj1Ea4pPORqdZf07HVXd5+r3UngD2Z+E?=
 =?us-ascii?Q?D+kEYO1eF21HeH1ZjPXkJgDZPNMXxwsAfQzEVmSPf9ah1AlO4FZWcsY+hma/?=
 =?us-ascii?Q?fmmS8NrgAa4Qofoqj57y/MNS05DGy8YDrkxd5vp7yWnooykiwUtnDwO0iFQ6?=
 =?us-ascii?Q?S1qoqfh/FtEZ6W68ssdAuSd5Tx4rCR6iLNfTjVyJd4bV4hsUmHz+p4HIxTaF?=
 =?us-ascii?Q?EeB7nQS+cUCKyo/U0gPXsviavuIiYGX0BJszmJqmyqz83vjFvNajOJcuGD4t?=
 =?us-ascii?Q?6DY5aaDrHLUadKCySpx7vxK2JkBqPeutoIZrC5+F1bJbtmbg8Wdfbx8C7MpH?=
 =?us-ascii?Q?DuQhKmLuG/vcVtaeZbDGQcWm0ao938tSjAwQWm0XFgYD1uOA+2cyY/n5WSFr?=
 =?us-ascii?Q?ulnQ2uWM0sj8mpXA40O7Ew51eRUAFpzeLd9pzqYV+xKG788FNUoubZXzEDB6?=
 =?us-ascii?Q?4xaQfhMTgYtwrZn6oCPD2Ahw9D/LSZFPuJxjpY7ruS/D8tUQDQJ5bxzOpRtw?=
 =?us-ascii?Q?8xXQxaKeGJO/lmPjjHEFskGrZH3rIp90w5lpX4NLs4AesFEdxx4olqSBl/Pa?=
 =?us-ascii?Q?M74lbA3y06U3LIk+jYin+FucVl9QR7EuGLlliKtdx3s060GuOAjRdjDyaBuq?=
 =?us-ascii?Q?xvw5lLWeYA=3D=3D?=
X-Exchange-RoutingPolicyChecked: n6UPG7alSB/dUQsORRaTmfjI4XgtB3cFyHUh6IccPvWyiL/Il/3DmGhakquJZUMbyCdNeV9eaTtHHXCxI7HWscFAC+DSl3qwDB1FwlS9Q31Y8xugJMWHtQ+za0Q4JJa+MRyhdSEMdRK0FnFevIW893WlY3d6trAwz1I5sAr8wOz4bY7BjfQi0g2anbxhAFR/u3ZaweQymsYZtD9Qb4af8UNUtN7wOlPaB4tIHnJ5FYTSIMNHZhiX7WJieQGbq+PleCSZN+vrUkw0PSFRk965fq5XxUfBJdSlJCZfHB4wCoVNZLauTdu1abbrd24v4sUkJxKrWS6dblWEfgp/44NSmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d83f8778-9985-49b1-832f-08def7e4d5ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 20:12:14.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6Vmsq6+q0wAoKz/ecYqV2uJVBbP7EJ1a8gnDqcZ5GXtfzEwHiU22CCh4ZHBTeTRjiiebdDtxafVSH5k9pbYVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
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

On Wed, Aug 05, 2026 at 01:27:51PM +0200, Raag Jadav wrote:
> On Wed, Aug 05, 2026 at 05:49:50AM -0400, Rodrigo Vivi wrote:
> > DRM RAS interface provides a standardized way for GPU/accelerator
> > drivers to expose error counters and other reliability nodes to
> > user space via Generic Netlink.
> > 
> > Since this is cross-driver infrastructure carrying its own uAPI, add a
> > dedicated MAINTAINERS entry covering the implementation, headers,
> > netlink spec and documentation, maintained through drm-misc.
> > 
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: David Airlie <airlied@redhat.com>
> > Cc: Donald Hunter <donald.hunter@gmail.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Raag Jadav <raag.jadav@intel.com>
> > Cc: Riana Tauro <riana.tauro@intel.com>
> > Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >  MAINTAINERS | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5114e6db7307..51be7ad24528 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9039,6 +9039,19 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> >  F:	drivers/gpu/drm/drm_privacy_screen*
> >  F:	include/drm/drm_privacy_screen*
> >  
> > +DRM RAS
> > +M:	Raag Jadav <raag.jadav@intel.com>
> 
> This one should be 'R' and not 'M'.

Okay, I will adjust that.

> 
> Raag
> 
> > +M:	Riana Tauro <riana.tauro@intel.com>
> > +M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> > +R:	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > +L:	dri-devel@lists.freedesktop.org
> > +S:	Supported
> > +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > +F:	Documentation/netlink/specs/drm_ras.yaml

Net maintainers, ack?

> > +F:	Documentation/gpu/drm-ras.rst
> > +F:	drivers/gpu/drm/drm_ras*
> > +F:	include/drm/drm_ras*
> > +
> >  DRM TTM SUBSYSTEM
> >  M:	Christian Koenig <christian.koenig@amd.com>
> >  M:	Huang Rui <ray.huang@amd.com>
> > -- 
> > 2.55.0
> > 
