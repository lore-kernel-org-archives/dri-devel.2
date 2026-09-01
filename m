Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC2C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4DB10E1F2;
	Tue,  1 Sep 2026 15:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XDBnOugX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E0210E597
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788276320; x=1819812320;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3PH07R2GmQUZ02NlJx7+prV4mtRorHSZJa8qj+lOWBg=;
 b=XDBnOugXEHDg/zW7FkZKzTPoVn4GnZHtLACCt2qwD2VsRpM2pOF7SnkT
 ihnQPiLA1148sINop07Yoj7ldyk1C75uhi1r0Kqa8j9uv33qBpbcr1LEq
 oyLNdhkjMkhTBqCen5eH8+4wB0rYgfMc6fUWdzKVMAzk/PwlmUDjN8+Nc
 JREE6SJqC84dptDS4M4Vt4V2SjN9IPrsoyo8UzantzfJITcc7saE4dOgX
 u+f2+U8b50gagwDgUojjKutYHULbrUcGMabnqkZVRwztFCDFT7mySi69T
 7xNWaXRe8mm87vxsUog9YqkUgE1gSnkEyrWX/U3hreJ36ByIir+iXjj71 w==;
X-CSE-ConnectionGUID: PVGRJLA8QX6+uYpAJHCvew==
X-CSE-MsgGUID: M1GcKluWTCaWQzNFunkbRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99870571"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="99870571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 08:25:19 -0700
X-CSE-ConnectionGUID: dlhwi4EaTJiKEcDYA/Pq4g==
X-CSE-MsgGUID: sOEIWoaGQiWgs/n2NCmqlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="262989720"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 08:25:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 08:25:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 08:25:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 08:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDveluN8ekPtwZwaaHoTCNvvpqm1eOL0a+kclE8i6oaONuvNgGv0GrvAz6p0MZ1fyIfY3YBsZ9Myu83w1bZp4IH6O9mP1Rs2Bf6efq7PBbEWvbxyMMgphJ1oD6l4cw4eZ9rVRpLcHszpMXfdUGY5DgiaMcvXDui1uRs9RkcpsPs+LoPzYCUZtpeDUHoikek6zAh2HZCZbTSgWF4w+llrGpDkX+T9xYGgJvDzP72cFkdnR8e09XxZ2qe0y5k6ObG+j3V+cJYR48/5o6zGYjKoHyLqpRqeU4IeUrsQJjWLhG9K1XsLAQ58SVBz/deHuJ+endUn+3wTvfPhaBCG0SYNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnTFLQXf/xRTc5X/4air+Sp/yTXb392Q2svXODC7XeU=;
 b=qjZyiHG6rUxhQyFVrTaB6q5jDw5gXjBzv5Zy55RwL3+WalUf6LNAd/YeMwKraJYUaTQLZqXE6r4KrUEjnBDWbDMlBI6AzEOEjmHOGwJd1LuVuoU6i0q1NOs1MmKDRBl+6RLARh/49P/7wsOyXQjcoXnNdzVlu37U99PJ8H7P6dNFjsIzpWqZUMXmKvIztCjcXUIT9rdiQN2PW1me5FDvDAiPVhqcFLhlN361kAJ9AAVvKouEzJkIIug+ok2K13E5wWmxtNTprmG9bdU19oKAq9ujvm++dQ6tja4HIQkZ1tW6ka0pgDvjS5eYM6VuS2wHmtqU8FVUgUwIVW6O1eqwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:25:14 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:25:14 +0000
Date: Tue, 1 Sep 2026 11:25:06 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Sinyuk <ksinyuk@kernel.org>, <dri-devel@lists.freedesktop.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Francois Dugast
 <francois.dugast@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <apbuUsS_3RVbB5vh@intel.com>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260826093222.GC42790@unreal>
 <fabric-leon-reply.1787844400.ksinyuk@kernel.org>
 <20260827170911.GG42790@unreal> <apGzqP6cEZ1miNmR@intel.com>
 <20260901110120.GJ24140@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901110120.GJ24140@unreal>
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 493e9ae0-8bfe-47a4-d8ee-08df083d3843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Zh2i13YwijzwUtMOnsIlU16K0cHecdP/WNWwtVnJsQtQcMuXShSWpe+EXZfXWfO8MYaFHBNF47GHV5DUFksq+3RVZtEEW7/iWDyT3mUInY0VV7lhdzP03DyscqBNY3PWQ8tPOFYIWijo2bNyn1J+Wvhv1vjeMoJWsoHwwVCz/2Dx2GqlrjZqLmYrsGKk/uPtUSGLswWFquD5Ukrrt7gBDq+N3w+6yRfGlOI1jNOZAhs+L0XQyIjYEvqNKCuVD3hiTiAp4TjRKPRyu7/SGVytba9H4kikJWaMr7z/kboMWlRW/WVBIGABqmK0P3k+OM1oAmcNGyYppGp0vIUDKZj7vfCqKEYzy83okB6LQpylY1LCdTPegY8odoQ1/1D2HnajDgoOjgb6ieXTddygtLAYgNIJLZnUgh+uvbP7EzBBbVT1sdQNdzlj18hl/gaHLF7lnxfg3I57HFlS2LV/6pJuxEyvlV7pu+8xRy+ADy6y+edmuizzAY10rKkvSDJIMNlHht/XL+4TajgUHStWbcPa3BITRbzjB9jTEl+eA5XR6RIW2jRiJ9eLjoB/ADihji6RlksmoltM/elaIE5Fh1WxMO6I3LufT/mecBe5ZEIS8ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uPIhHAUxv62tj3Q8F4Lz9PBoo2XLG7utVg10awMgdFaci3Flh2DqQl2QGGf4?=
 =?us-ascii?Q?f0SIQRht1iojMICLx4B5Zmpqi+ez2nqP8RyzSqNKuZyxG+YoFVXMjAteeiPV?=
 =?us-ascii?Q?y3b1KXSNUQior0tllOpIIklAQaESrcEbMRQxLARp0WmMc0uZNbneEOe75AoE?=
 =?us-ascii?Q?brkcCJ+ANLnoIMI8SGRKiJNClh1/UtcFUcNn4GXqWG0aB7pfQced2HPCp37t?=
 =?us-ascii?Q?xDyyahM3ZjhtV5AGnzoAXN+20ztDpkqBn0mxI57vn5jCOITR3+un53vX0iQ/?=
 =?us-ascii?Q?FrKgw3To9+VX5HorUDM5T+RgXn4/GIXHgf1Mumy91tByXgNA7Ed7hC1wHiW/?=
 =?us-ascii?Q?a9U7gfY7PYvUCC79n2fG2gS/xDSlmlbIaSPwsMvYIu+Jy27whK2wMin2Q09g?=
 =?us-ascii?Q?5ZitIwTDxFmr3q+bhUYsTIGGOhQzD3KjQyReHl+QtXoR4QebMMwGG1JeJG5e?=
 =?us-ascii?Q?bl0ziQ6brB0tmSsgDbzX1CBLfmSsoEJKQz7cAL9oFDosEXmzeU7QjSnz1ZRF?=
 =?us-ascii?Q?XAqNPc8liYF0ASsTjdY0V0vDatUKlnmy0JaYIrb0PBz6NeAe289s2YpjNChe?=
 =?us-ascii?Q?WGq1Sw0kPDhGkEsJdj6Jy4Yu7HMe5ykovy7Q608wsdeppsmzRT+JDzEwjXz/?=
 =?us-ascii?Q?BQGCqpiHqweViXVFtIR21zTEskitIAzhQ3wQQszRLBKwqIuB3+/mz+1pngpa?=
 =?us-ascii?Q?365TwrfocfzlUZHbk84KdC6fEKrPcLaAkDTLxvFHhT7XOHaVi5rsdTSIJWu1?=
 =?us-ascii?Q?APnU2sjP179CVDTh/okZyP+SVZUgyzQWs1eJN+LBVpRZeDkcOw6/4Cbc/NNJ?=
 =?us-ascii?Q?hTVmMz5Lii/CdBM6MRKob0jyLGF/wjiX3x3jUcnKSF9JdJ1I4Qqhmj64bgxa?=
 =?us-ascii?Q?J3dSjNIexy2TaQf7S46YhPwpDyjSFFETXJJN82IjSzo2dBV/AHbCyD7QwTTM?=
 =?us-ascii?Q?kMp0vtwEuu04W3lEwUtPE6XOXDIOniUipVnXo1WEAIxH0Ata6F5DOSf6XQGr?=
 =?us-ascii?Q?8++nMwzT8x+/cY5uS8Mq2FloBGDgtEoAGiw3MsonhKjlHnah5Yri/Mm9nSce?=
 =?us-ascii?Q?jqogG8sP2KHRmxXsNaOgoTBW2e35GQubYUde7o8VqAdjPoaJC11aFgbwRsiZ?=
 =?us-ascii?Q?6s1Pv7l6pyIUMFh3WmOrZkPbYSfJ+TfEp75W3CIrnKIJzHyAhk0nQlRNW2qi?=
 =?us-ascii?Q?ac7kNxgYfhFehqPigEEajobGQrT7Dj5b/MAfUIiyjyGyji+EB2y/hrwKvk5/?=
 =?us-ascii?Q?RAqmfvL09uT4sclZq1i8un51PkHuaYwcd42Dh+attGGdVqgpjgW/EcocR284?=
 =?us-ascii?Q?/9S/Fu46KqPd3zrs/3Y1Sd/tIVgcWo8n0YlHXrRSc62JRPVos4sQr7VRgVsw?=
 =?us-ascii?Q?366Z3oHb66785aX32FZvAqiMhhIs15D2hQKOHpSZF7RUEaFDAvU6LPHPyvG/?=
 =?us-ascii?Q?lY3jPYZNoWF3BHeL/j9kYoiu3IJVOvoZN2gVytYWp070wnMNX/OB6KvzLRGT?=
 =?us-ascii?Q?4T8G+9A8b8J88Mawts7sBwiLSrQdlDs+MThu7yDaKNcpFuH7eR+pRQm/tyRk?=
 =?us-ascii?Q?MhGIYxYIoOcuiaiyO0ffmkTOWKtZ7skaRLW8X6/miCsaAssWTtkyU0pU1AHJ?=
 =?us-ascii?Q?+mmr3bDIAagxlvJN0a6DilHjQ7+k3CXEqnOmq5bWlqvsaw8p6rLzCYrgJxV3?=
 =?us-ascii?Q?JAj7aAIlriQEkDsLnmj6vJDCsHR1qrOs+jeJdaGtAXoeKZfDXUnC/Bu4uaoq?=
 =?us-ascii?Q?pku8BthHDw=3D=3D?=
X-Exchange-RoutingPolicyChecked: iT8RHxBEKWiTvd2o13/qzVxVqkGfrdJJZaYQP3QWlH7LItvK25bTBw5VldseuBo94txHAo2wcXCb/h8wG6T01wDqeZa1UHJ7YipCjSw6aIf7OK+75Canr45gvFOtxu1GbvD31Sse+51w45R0OKOlMFGzR1sxdufth8w9jQEGaPU3ncIjbja9FRYx2XBcvKn3ZwpCXCphRs/6vlCcO/8faf/uAaCMLRZx6LxRm2fH1AXfiLqRNGAimcgAuaRCuFnCq1K4iZdWo96H6UD3+/dS1twMIor85f9B09QeVtSpAKvVqsscpe9hpevs1BQy9Je4aiIJXVja0VoB9LdBV3vU2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 493e9ae0-8bfe-47a4-d8ee-08df083d3843
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:25:14.3706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw01j81Dvd1LCcJveO2prur57Ie/Pd+XhtlEujZPapBSlPCPkj4nfha/FLQ7BudOhd7CV1tt+t3Pu9M3bEO96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
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

On Tue, Sep 01, 2026 at 02:01:20PM +0300, Leon Romanovsky wrote:
> On Fri, Aug 28, 2026 at 12:13:28PM -0400, Rodrigo Vivi wrote:
> > On Thu, Aug 27, 2026 at 08:09:11PM +0300, Leon Romanovsky wrote:
> > > On Wed, Aug 26, 2026 at 06:38:58PM +0300, Konstantin Sinyuk wrote:
> > > > On Wed, Aug 26, 2026 at 12:32:22PM +0300, Leon Romanovsky wrote:
> 
> <...>
> 
> > > The wording alone is not sufficient. Your proposal should be backed by
> > > real devices representing different architectures from different
> > > vendors.
> > 
> > Future Intel (and other vendors) hardware will include UALink.
> 
> I guess that, like most of us, you are not authorized to discuss or
> comment on Intel's non-public roadmap. Can you point to any public
> commitment from Intel to implement UALink in its devices?

That's the only public support commitment you will find for now:

https://ualinkconsortium.org/blog/intel-supports-ualink-for-scale-up-networking-829/

as an active member of the consortium
https://ualinkconsortium.org/members/

> 
> I couldn't find one.
> 
> <...>
> 
> > > The current proposal is based on a single implementation, which is
> > > unlikely to be ported to this new framework in the foreseeable future.
> > > The amdgpu xGMI implementation already exposes the required UAPI through
> > > sysfs and would need very strong incentives to abandon its "legacy"
> > > users in favor of this new netlink interface.
> > > 
> > > The last new subsystem I am aware of was introduced with implementations
> > > from three different vendors to demonstrate its robustness. You should
> > > probably aim for a similar level of coverage here.
> > 
> > If we wait 3 different devices to show-up before we can start discussing
> > a common API, then it might be way too late.
> > 
> > But of course, we can definitely move this netlink as is to inside
> > drivers/gpu/drm/xe and call it xe_fabric and if someone else is interested
> > in join effort we move that outside.
> 
> We are not talking about "waiting for", but about "being backed by".
> The general kernel rule is that the second implementation is responsible
> for consolidating the code. XE appears to be that second implementation.

Again, this is an RFC, not a merge request. The goal is to do it right
from beginning rather than facing years of churn after things are already
implemented so differently by downstream solutions.

> 
> Thanks
> 
> 
> > 
> > Thanks,
> > Rodrigo.
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Thanks,
> > > >  Konstantin.
