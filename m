Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA478C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E2B10E61A;
	Tue, 15 Sep 2026 22:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jQ1Ue/cv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFF210E60D;
 Tue, 15 Sep 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789509762; x=1821045762;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=grFHafpHLlWDj+KGz3r1NkKFKnJcfBDMvcDdmReh0Z8=;
 b=jQ1Ue/cvI7e8qONkBOSBq3JPCMu8bfaJPpY8tIo7iJtdkcm6z5iwaGDx
 0JA4UtLEybSki2DQjzPum/wBBpeMDPwnxNjei1B2ZIA4rbg1oyjnj3MRD
 ue+O+o2XwxsMT7QoU/ZNNcUOa3aRgYIRM707K0zEiWyQGDTJVqoC6bkod
 FD+cjuYri5LRguw3Er6uGieCP1cPcYgMVIR7nR2J7ustYjgwKZSq3qkv8
 AOQo9pUpya09lL1q4XwLO2iDRGc9sP/idF+vFdqeUw3dhhk3EvmQGRZmp
 AvY5Ptan2ZjT6XVKH3i3ae3Qm4XRotUZwMbBA9NWKVdwqDNNFhYQYzoIs Q==;
X-CSE-ConnectionGUID: r9xZ2qJAQAyG43lLFaqleQ==
X-CSE-MsgGUID: TEclYtKzRoKk6ZBTrWRTEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92392831"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92392831"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 15:02:42 -0700
X-CSE-ConnectionGUID: 1ALTtZCxRuOFJbxGB7j+Bw==
X-CSE-MsgGUID: vtE+2cSjSgezgP3JY8IT4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298198831"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 15:02:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 15:02:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 15:02:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 15:02:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUfpMP6XuZKuuY5B3VLcFhkjm3l3Mp+n9iEHNMDo5d6tXo/RlyFKnE/2DN+Gx1tlhIIS3XwTq+5MxpHFl6QaownMrKzjf4GGXnber+yGKIgI0jq6vF3log21PhSdEtk90Dwjj3fp9y2FheG3JhATHnsuI6QcVPDMemoUsH4Bmssu38Oef1/lcRtYJifY5pyw2twObbt8soT9jm3d6FqGQmGMGMdMImIHQBO9Wcf1dRe2PINboKFyptQmoDKYmCPD9ASDzT9tgXcF1m/j2gcLpkGEIlZsxKSoM+Sh5+4xIUmeVfmgeLpGQLw3xEEEhdG7kKjGhc/tQXWwIOi3o5SNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGCCNUBL0K3IeZ66T47v3tKJZX1k+nUwndroroNVrC0=;
 b=APW9Yt3g8HxUyaeQJkzwyIqQYkAzJQewH3PbkAfDLWo+ONOnmLGkBsFiiBkigYRN8ts3xKYUSFvme2zvlUg7f7Y+DubTkguADamAx/wrlwD610KsMqGaDLwPhbGT3ni2/F1P9bae1Y1jAVwl0m2eUd0/4WrdgxdFeOsDcl2322KySy3qzwZMmSoUg2v2nD93nVhQ9/sEaNdyAzIm+O4wxtug5XSolLtSbD1KnyQuLKICi2d5OWAbKyuQRAVRfNzE0w8OzBQ1kOiKnsr0iVsYliTDXpnTIVFlwYtvD3afr2nfU3S7P848Xq0DrJLXN28sZFc1Axr70MT7JLE1fOz2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by CH8PR11MB9457.namprd11.prod.outlook.com (2603:10b6:610:2c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 22:02:36 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 22:02:36 +0000
Date: Tue, 15 Sep 2026 18:02:29 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Armin
 Wolf" <W_Armin@gmx.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "hansg@kernel.org" <hansg@kernel.org>, "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux@weissschuh.net"
 <linux@weissschuh.net>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "patrik.r.jakobsson@gmail.com" <patrik.r.jakobsson@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "joonas.lahtinen@linux.intel.com"
 <joonas.lahtinen@linux.intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
Message-ID: <aqnAdfovLmD2O3wQ@intel.com>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
 <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11976ed3784675ad241646287a909286a42675a8@intel.com>
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|CH8PR11MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6a3c81-9896-48df-3139-08df13750d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1DkzVH+NazjgRhVl+1PB4kDZRKEVaMMDTBe1UlCjA4N6yhIe+qkvUnjuM5s7ZFgGc2bv2N1nT/4kvPCZkcthyyPwc6SyKsuqkkLiuve/ordnXbqEiEtIZndmI1PQ2FmHOXNHHC+LDosjHrrWcTHDbWIZPCJ3JjuzmBc92EexuyM4c6otpdH/dMdbLMpe8pyY47fiuO6LaqQUgtXaqRTaCBbp1g+dJAHyGpxHf4G1VDwewdzNc6WXRm4BWrFUfS7ohwNLUQf8gj4ES+rN9g6sxzMXICB45dmujqBq88ITOXmMq7cdmTcFk4H2Liij0w2dIhH/1HOGCAMKkQH4KS/k/bPRY0HRlbGh2KYiid+E6EeJTFkX7kHpkXuECCwvKCqeuNcAB2BTPsfEyyNHR9Etqznnp4e33h9my9TQs5zzKA3ipbsf4fM8HCfd/YcclQAfsBVjoRmb4A6Zn2RI+srb8ixdDy/iOTt0/8SNnAIn+5dq3EcbynXv+Mrl5pPw5H2hvSUf/9cnRGX0LOV3kvxCtjSabF30eLLWjJu3nnCMRCugJayLeN9MuStXQN10q3YGM6oVPp5e3i+0F74rMyiZNuENDpl6wN3mhpbMd8z+F/rOxQWbppD+j+1cLUIPStRgrTZzZP2QdbEkcoCEqgb4TZEqKr8A/W5fDq+lRmBVhpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IiIPdq0L2tYEC3TdaQml7TwvdNmQFnl6j0UaxIXBx8IAifkWGIQn13QH2k?=
 =?iso-8859-1?Q?TmnLf4+iHUFg19iZgp/D97qKKKc2jX/dUDk0bnXfnSe/2gR+3V4K9oeL0N?=
 =?iso-8859-1?Q?wdU0W3823m9LuXzVFUSYkJ4I/pInKcF0w1Ba/Bxv79eixZlZOKS4QCpeVS?=
 =?iso-8859-1?Q?95ZRl5MbZ//9Gl+CPgsnZXtpDUPzZRelntcmXQp7/uXtwHGd8OSIM7ElbW?=
 =?iso-8859-1?Q?At+Sw0so++O/SP04scJtvsmsnHG7yE5g6vUX+GmRj/THkqG5MLxSHfvy06?=
 =?iso-8859-1?Q?QURmLhD2N7d704jU4LZcCnujtg0g3ihPrxvT1/Dbno3Grkc7FGJwjgYoF2?=
 =?iso-8859-1?Q?slOeb+PQlzXTzKslDkgbzsmOfAhOaqlcZ7ag57Ea5iIfog0ZyjJNNnFa9b?=
 =?iso-8859-1?Q?O0tSH1noaLBpGAIdYRHGMgKjQAhmDwNvzXuS9kQcniL6wQI1QwhNowiBRa?=
 =?iso-8859-1?Q?hYZ2nN4a0TAE28Luihuq+OdA/8RqZDzRmPsMucChH7sgd229NagcUHSct2?=
 =?iso-8859-1?Q?q5qMjb6WtrxK0NzK1ROGF5kJwLbZQzvHA8nqdRhf9+1WUoAgl5gCGjl1y6?=
 =?iso-8859-1?Q?RhwkXDc94FWM9O3/RdCejjp49v5SHg6/ot91TFV+/IRMFZ9E0fIh345Og2?=
 =?iso-8859-1?Q?Hp4ofMWMWGZD3Kgb5uMHsKg2tU0TKAyrBXUU2dOXhER6ZdnufygmdpAkyR?=
 =?iso-8859-1?Q?bYPZtC0VGbv/GLJXje4Xgdzaplg80c0y8u1835448FXBm5637+IzhxlP+m?=
 =?iso-8859-1?Q?EpcY3mdcmjquhVvW4+sD5xRmrvz+hv/s2wzFrwuazG0kEkjRHNPeac0kgV?=
 =?iso-8859-1?Q?OKBb3aGcLrziH1jzeHMmdSduys1nYN+gf1TtzsS3I7AfpMW9zNNrTpNdgs?=
 =?iso-8859-1?Q?BfVeFGDzekplL0vArW8goJTKg+mru7j8JsPhNZTR5hMjTmLklfaEuRqSCC?=
 =?iso-8859-1?Q?FoJ+8iiDr9W5GMLY+zYbVsbIhznvGoJF7r/dhMgo5F6L4hl7LSfCGM6Pjg?=
 =?iso-8859-1?Q?UzyF+bglp09wzAFRmoVfq/D1oC/cWc0DnETpJrWbxYWc2JKtATqYRKEwpP?=
 =?iso-8859-1?Q?URlhEI0dlI+hBgBJsueFQG+w3kuZ2OnEGWlPvjrLr5R/LJrexbuLeZ03MX?=
 =?iso-8859-1?Q?66spoVPUqGPg+3SBlvgNktl++PvyxWmNApUsjdP9j2yvMpl0Mm8WAdzLeX?=
 =?iso-8859-1?Q?rjCMifGA4OBScbTEN7XyhwA/OM5frNP2Fb1FABFUlFGRAHZGsiRrQGWM3i?=
 =?iso-8859-1?Q?5xhQWUjPkQ4wd7v78bt1MTjwlI7OmDddUgQ0TnD0MczidE/3fhBsUwdw3o?=
 =?iso-8859-1?Q?zZaQuBNymIqVaB2YTRu4w7oIqvUkW/jlup7k/B2KNWUYds5XNeaOrPMZgL?=
 =?iso-8859-1?Q?GfApVzpZDuD73uiWRVmRhdx4dy/MbFvQcSfMwuJUOdvebdlB6N3m0bSOL9?=
 =?iso-8859-1?Q?Zr3E82yI67cAFJyPexXsY+5ibOIb0i7vq/Sg0GIqIZpGjAJ+a0JXPOoLII?=
 =?iso-8859-1?Q?qPHBkrUkhWYf+AMJ1AYZVzEZw4NKNfpoGUg7Gi3bBYtbhNfWkhosqDrfGv?=
 =?iso-8859-1?Q?RTpsJaOL7XdWxzmzpdwmitkQr3KEB8So5r/qNre3c2cruDfSLtDwzVGZEA?=
 =?iso-8859-1?Q?CBCeoRw8YIvcdr1MJFDWWkLrGRI+0kiBJhoIcyLDZ1UNZuHiOEaJiNe7HF?=
 =?iso-8859-1?Q?jqduQES1xlP1VGBr0cKb65P4q4Nfh99TejOXtLI/AMNknEW3RM/iF/SQYi?=
 =?iso-8859-1?Q?VLKdbpF54p8K8qPBAYLQyVmP+Y0qDJjJWprX9v11s4XXaVv3ickm0aImDw?=
 =?iso-8859-1?Q?P2Ls8/eRkg=3D=3D?=
X-Exchange-RoutingPolicyChecked: dkjHo6tihsuJz3oCVgB+ezvDtJq7SI3kuAYmozCPkb98EaVQNOsn+KtzJOTy3dS2cUf9VKcb7gdVifyv61MeEIkGvayunMxLFqu2uyWSgJfPQw0WEX2G0haxH0YQMIhQIZ0cCTRhh/UIEIrrPeQR1g6w5WY5/RsIx44um//9OpBo+HI6iKrOkCC80Ps2rCIhIxf+7EAnfWjTOU9JedFn9n3CJA4wxlY6BGpxMTzNFTzPIMfz5//rs8al6JAkKJ5V1mXL3+Ny+wPn28cFVx+KejdAeFFOaZkjIWg1Hr8Jg08Ghq3YIzGH/0wN1VxooWd0BNX8tioZFUMqqsjqC5zMDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6a3c81-9896-48df-3139-08df13750d2c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:02:36.5424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84YrauZ7MLGrG4qx0FI/53P02EjAkOasrjFnOK6Px9t7Z9ixd1DwRh5kH0tOKn5xiUtF4Cka5AJ3Ax715JAKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9457
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

On Tue, Sep 15, 2026 at 03:31:29PM +0300, Jani Nikula wrote:
> On Tue, 15 Sep 2026, Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > GPU people heads up!!
> >
> > On Wed, 2 Sep 2026, Armin Wolf wrote:
> >
> >> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
> >> 
> >> > Public
> >> > 
> >> > > -----Original Message-----
> >> > > From: Armin Wolf <W_Armin@gmx.de>
> >> > > Sent: Thursday, July 23, 2026 11:00 PM
> >> > > To: hansg@kernel.org; ilpo.jarvinen@linux.intel.com
> >> > > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> > > linux@weissschuh.net; rafael@kernel.org; lenb@kernel.org; linux-
> >> > > acpi@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>;
> >> > > Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.com;
> >> > > simona@ffwll.ch; amd-gfx@lists.freedesktop.org; dri-
> >> > > devel@lists.freedesktop.org; patrik.r.jakobsson@gmail.com;
> >> > > maarten.lankhorst@linux.intel.com; mripard@kernel.org;
> >> > > tzimmermann@suse.de; jani.nikula@linux.intel.com;
> >> > > joonas.lahtinen@linux.intel.com; rodrigo.vivi@intel.com;
> >> > > tursulin@ursulin.net; intel-gfx@lists.freedesktop.org;
> >> > > matthew.brost@intel.com; thomas.hellstrom@linux.intel.com; intel-
> >> > > xe@lists.freedesktop.org
> >> > > Subject: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
> >> > > nvidia_wmi_ec_supported()
> >> > > 
> >> > > The WMI-ACPI driver now supports architectures other than x86.
> >> > > Remove the CONFIG_X86 handling from video-detect and the associated
> >> > > drivers to simplify the resulting code.
> >> > > 
> >> > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >> > > ---
> >> > >   drivers/acpi/Kconfig               | 2 +-
> >> > >   drivers/acpi/video_detect.c        | 8 --------
> >> > >   drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
> >> > >   drivers/gpu/drm/gma500/Kconfig     | 1 -
> >> > >   drivers/gpu/drm/i915/Kconfig       | 1 -
> >> > >   drivers/gpu/drm/radeon/Kconfig     | 4 +---
> >> > >   drivers/gpu/drm/xe/Kconfig         | 5 ++---
> >> > >   drivers/platform/loongarch/Kconfig | 1 +
> >> > >   8 files changed, 6 insertions(+), 20 deletions(-)
> >> > > 
> >> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
> >> > > f165d14cf61a..cc1e58fa664b 100644
> >> > > --- a/drivers/acpi/Kconfig
> >> > > +++ b/drivers/acpi/Kconfig
> >> > > @@ -224,7 +224,7 @@ config ACPI_VIDEO
> >> > >        tristate "Video"
> >> > >        depends on BACKLIGHT_CLASS_DEVICE
> >> > >        depends on INPUT
> >> > > -     depends on ACPI_WMI || !X86
> >> > > +     depends on ACPI_WMI
> >> > >        select THERMAL
> >> > >        help
> >> > >          This driver implements the ACPI Extensions For Display Adapters
> >> > > diff
> >> > > --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c index
> >> > > 458efa4fe9d4..af9280b244f1 100644
> >> > > --- a/drivers/acpi/video_detect.c
> >> > > +++ b/drivers/acpi/video_detect.c
> >> > > @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context,
> >> > > void **rv)
> >> > >        return AE_OK;
> >> > >   }
> >> > > 
> >> > > -/* This depends on ACPI_WMI which is X86 only */ -#ifdef CONFIG_X86
> >> > > static bool nvidia_wmi_ec_supported(void)  {
> >> > >        struct wmi_brightness_args args = {
> >> > > @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
> >> > >         */
> >> > >        return args.ret == WMI_BRIGHTNESS_SOURCE_EC;  } -#else -static bool
> >> > > nvidia_wmi_ec_supported(void) -{
> >> > > -     return false;
> >> > > -}
> >> > > -#endif
> >> > > 
> >> > >   /* Force to use vendor driver when the ACPI device is known to be
> >> > >    * buggy */
> >> > > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> >> > > b/drivers/gpu/drm/amd/amdgpu/Kconfig
> >> > > index 12e4a41bf1f0..50305630f533 100644
> >> > > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> >> > > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> >> > > @@ -30,9 +30,7 @@ config DRM_AMDGPU
> >> > >        # ACPI_VIDEO's dependencies must also be selected.
> >> > >        select INPUT if ACPI
> >> > >        select ACPI_VIDEO if ACPI
> >> > > -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> >> > > -     select X86_PLATFORM_DEVICES if ACPI && X86
> >> > The change below makes sense, but this one looks like it should remain
> >> > unless X86_PLATFORM_DEVICES is handled some other way?
> >> > 
> >> > Alex
> >> 
> >> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary because
> >> ACPI-WMI depended on it in the past.
> >> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymore.
> >
> > Hi all,
> >
> > Could more GPU people besides Alex take a look on this. I'd want to make 
> > progress with this series within this cycle but would prefer to have Acks 
> > from GPU side.
> 
> I share the same concern with Alex. It seems to me we could now end up
> with x86 configurations without X86_PLATFORM_DEVICES, which handle
> e.g. backlight on a lot of platforms.
> 
> I think the safer option might be to go for:
> 
> 	depends on X86_PLATFORM_DEVICES || !X86

I also fail to see what is wrong with current xe's version
that is getting dropped below:

depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)

> 
> in all of the cases that select/depend on X86_PLATFORM_DEVICES in drm.
> 
> The alternative is to find out, and handle the fallout, if any.
> 
> 
> BR,
> Jani.
> 
> 
> >
> >> > > -     select ACPI_WMI if ACPI && X86
> >> > > +     select ACPI_WMI if ACPI
> >> > >        help
> >> > >          Choose this option if you have a recent AMD Radeon graphics card.
> >> > > 
> >> > > diff --git a/drivers/gpu/drm/gma500/Kconfig
> >> > > b/drivers/gpu/drm/gma500/Kconfig index a2acaa699dd5..dc4c56638819
> >> > > 100644
> >> > > --- a/drivers/gpu/drm/gma500/Kconfig
> >> > > +++ b/drivers/gpu/drm/gma500/Kconfig
> >> > > @@ -11,7 +11,6 @@ config DRM_GMA500
> >> > >        select ACPI_VIDEO if ACPI
> >> > >        select BACKLIGHT_CLASS_DEVICE if ACPI
> >> > >        select INPUT if ACPI
> >> > > -     select X86_PLATFORM_DEVICES if ACPI
> >> > >        select ACPI_WMI if ACPI
> >> > >        help
> >> > >          Say yes for an experimental 2D KMS framebuffer driver for the
> >> > > diff --
> >> > > git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig index
> >> > > 5e939004b646..71426b9c91f0 100644
> >> > > --- a/drivers/gpu/drm/i915/Kconfig
> >> > > +++ b/drivers/gpu/drm/i915/Kconfig
> >> > > @@ -28,7 +28,6 @@ config DRM_I915
> >> > >        # but for select to work, need to select ACPI_VIDEO's dependencies,
> >> > > ick
> >> > >        select BACKLIGHT_CLASS_DEVICE if ACPI
> >> > >        select INPUT if ACPI
> >> > > -     select X86_PLATFORM_DEVICES if ACPI
> >> > >        select ACPI_WMI if ACPI
> >> > >        select ACPI_VIDEO if ACPI
> >> > >        select SYNC_FILE
> >> > > diff --git a/drivers/gpu/drm/radeon/Kconfig
> >> > > b/drivers/gpu/drm/radeon/Kconfig index c479f0c0dd5c..3cd70aef770e
> >> > > 100644
> >> > > --- a/drivers/gpu/drm/radeon/Kconfig
> >> > > +++ b/drivers/gpu/drm/radeon/Kconfig
> >> > > @@ -25,9 +25,7 @@ config DRM_RADEON
> >> > >        # ACPI_VIDEO's dependencies must also be selected.
> >> > >        select INPUT if ACPI
> >> > >        select ACPI_VIDEO if ACPI
> >> > > -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> >> > > -     select X86_PLATFORM_DEVICES if ACPI && X86
> >> > > -     select ACPI_WMI if ACPI && X86
> >> > > +     select ACPI_WMI if ACPI
> >> > >        help
> >> > >          Choose this option if you have an ATI Radeon graphics card.
> >> > > There
> >> > >          are both PCI and AGP versions.  You don't need to choose this to
> >> > > diff -
> >> > > -git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig index
> >> > > 4d7dcaff2b91..502c7b3c1f16 100644
> >> > > --- a/drivers/gpu/drm/xe/Kconfig
> >> > > +++ b/drivers/gpu/drm/xe/Kconfig
> >> > > @@ -4,7 +4,6 @@ config DRM_XE
> >> > >        depends on DRM && PCI
> >> > >        depends on KUNIT || !KUNIT
> >> > >        depends on INTEL_VSEC || !INTEL_VSEC
> >> > > -     depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
> >> > >        depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
> >> > >        select INTERVAL_TREE
> >> > >        # we need shmfs for the swappable backing store, and in particular
> >> > > @@ -29,8 +28,8 @@ config DRM_XE
> >> > >        # but for select to work, need to select ACPI_VIDEO's dependencies,
> >> > > ick
> >> > >        select BACKLIGHT_CLASS_DEVICE if ACPI
> >> > >        select INPUT if ACPI
> >> > > -     select ACPI_VIDEO if X86 && ACPI
> >> > > -     select ACPI_WMI if X86 && ACPI
> >> > > +     select ACPI_VIDEO if ACPI
> >> > > +     select ACPI_WMI if ACPI
> >> > >        select SYNC_FILE
> >> > >        select CRC32
> >> > >        select SND_HDA_I915 if SND_HDA_CORE
> >> > > diff --git a/drivers/platform/loongarch/Kconfig
> >> > > b/drivers/platform/loongarch/Kconfig
> >> > > index 447528797d07..db7833842142 100644
> >> > > --- a/drivers/platform/loongarch/Kconfig
> >> > > +++ b/drivers/platform/loongarch/Kconfig
> >> > > @@ -23,6 +23,7 @@ config LOONGSON_LAPTOP
> >> > >        depends on INPUT
> >> > >        depends on MACH_LOONGSON64
> >> > >        select ACPI_VIDEO
> >> > > +     select ACPI_WMI
> >> > >        select INPUT_SPARSEKMAP
> >> > >        default y
> >> > >        help
> >> > > --
> >> > > 2.39.5
> >> > 
> >> 
> 
> -- 
> Jani Nikula, Intel
