Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C542CCF2C1
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 21:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931ED10E166;
	Fri, 16 Oct 2026 21:33:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8AE10E166
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 21:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792186378; x=1823722378;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Sso1Dco9+FLSiAE9x5H3m8mM1kxk0vCGX7lE+gdopyY=;
 b=j6/aTx13vk/klFFHBhFz6HrdeGE59xIyeZZMFd2gpvTpsRlYsTzR4MgJ
 q2d+NdFnTrwXyKk4LLu6kh45Gart/G7UG5ExWt0k4xI6zGQSoi5Qplszm
 4uo/Ta26O+ndxE38UetMsJckvJwnd7copBex18re+Z9SwvNJisK07HnmE
 ANip5aRjoNvKbyHTSj9zFZF9JYc5N5UkZ50oyRWoBKp2MFp8fUTJ6QgbY
 V/U2VxfsKaB0G7JdW3U+F9LvaQgj+gzfplRzkWsPQEa0hFJFI3EAd5Erg
 zmahCWTto2VS8f54+XcrFd2MvEhgbayuiqQeFUq6A2AxjNBI5lOQeuaDF w==;
X-CSE-ConnectionGUID: ptvsRKe+TLir57aorVFhIA==
X-CSE-MsgGUID: Rx2/zcezSByKUTC5SdI8CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="1078245"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1078245"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 14:32:57 -0700
X-CSE-ConnectionGUID: DpJOfx5rTqKlt3j56eq0aA==
X-CSE-MsgGUID: 93Fb7ITgSLOdUSaS4FsqHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2037664"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 14:32:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 14:32:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 14:32:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 14:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyUzziMgTHzCOGQsaePNYfzr9k69FyMeSTDPazp+epC/U3Ufft24HNS9eKaGEopErXgfHtcZlwKr1S2gWJisUlGN5x1Y56uKboqDLcNBWGmILFtGhlrmvdstttELarXilWSrLAnseDDeGDEWWQVK405ILvFtzS8j6ODyTCGEF3rHmSmVHhrlakdfyyIXI0VuRjT8ljYQgWXXOsJjh7Mhfkpg7ZuJUCFInhuhD/WCapnOIiLhMmEjlumvPGeWkt7Vthu9l+ddQ9lKcOg6hPVFf5w0r+co2HGgZCkLyLi/scwXeQv03EgB+CM8x3jpGNYSA6EXT6AlG3Ec6t8dropo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzfwjsLXY/FtaXCgDn8/dHxGVyBDgqgfmYYD6kzS4YY=;
 b=My3pF7P37UPOQ1rOSaGkk2LkMW52BwSTS/0Q/qcPpOppnOAGMMzNVe9YYjuMYt0O+25CmVpEmMcHtjPjkgBKhY5BVnZTmKeJ+BxyHIHWNb+Jc+wFspBHpAGSZQgg6lM3YXO1839KjQkLxQpmMDsJ8WiBR+WL1SkMcwYzVjFLZDYHaZiXklU2ORRM3+5IQUMvMC8rOK9YIdnUAo0QUOjYawlhLMsMk14VNKRRzVJZFiu5ZLL/i7qU/eL4wa6FVGRRZUPqlFpNsJ/SRjmh9nHQ+FGEfFPAVQzrNsgr1K9bCk36Wde60I3IPL3R3M+YiMosU2ZMp4Fpe4+CXOjPUfM4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by IA4PR11MB205273.namprd11.prod.outlook.com (2603:10b6:207:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 21:32:55 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 21:32:55 +0000
Date: Fri, 16 Oct 2026 17:32:50 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <atKYAkOE2FBIUryf@intel.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
 <as_v6iB__bh3cHm3@intel.com>
 <5869b931-4c5b-47a1-a81e-13123165e86f@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5869b931-4c5b-47a1-a81e-13123165e86f@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::26) To DM4PR11MB7181.namprd11.prod.outlook.com
 (2603:10b6:8:113::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|IA4PR11MB205273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8796f851-c973-4e09-544c-08df2bcd0a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261009221727099003|261009221227099003|261009223027099003|261009223327099003|261009220027099003|56012099006;
X-Microsoft-Antispam-Message-Info: CWiQK0xM/VHsrwHXkRG5x7qPwjhCjSboSpHbYXFG7ghgZU4R3gAtzWe2ZwTb4f4L5ws4J9/oCZeow2E1ok0lzqGpq64ICCohRCtJ9o1AV81yb/NROIJk7WISDJCSD3HmkNOmRhIpW0OYYKEOaLw680cdAAvr5ji4zt4rYXA5674VUzqhBYUhoqipzyx8jPZL9/1qMvxZir2EXuhZgUAzBp72aWf5q3oBWDtaDNZH2USWUxDl0UH7zL+VI0amyV7ahw3HXh7OX0NvKXxbr4EUOSAITXqOp+Ws5s/Gw9LtcuhBmkrjwE2GoqAt9ie/OQAwk70g3bdmCUEb8aMGwrAFg/G3vTbJ2giG4sXLHx+O6pBAgxVEp2l4nlY8QVUqs2vohtcUHa9O5vrv4Yr7q3jHlnFrA1Sp5HiO3mJrDUp4KO8UKWIUCLYCP7UxOkosA3Mu+mAoGtQSAgyVSQyGi3srI607SzQ3h89Y2mS4Ye9KJbPfH6A/GPnn5qIricaosLWoaUHxp/wf6C2zD9HIH+h2axVUJ0zm0rBC1zW2+5sEiHj33tYF/PKfLofA4EhLaCm3b9BWhvQ+B0Ytzcjsq3btCgX+lbBNKMmx4qhrJFFF5qowSmp/gSL/6rXMiBEiu6sVZHedrftHSLDFxUvygJ0Ry1C+XvTAY0F2r7M/slfSWCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009220027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVVMzyDamaocjL1Sxe2qEjXVf/EwlIpCs+xJMyR+urF8ZGbIdYS89TfyL5Hf?=
 =?us-ascii?Q?9vCpXLZjz0fhB3t9lL3pvvuCW2UkaTQxIK2H/oxCXCK1fGckfFJMNRMnGjj5?=
 =?us-ascii?Q?fYktoT2wB2/NxKdVEaAz1N/Ilk2g0/C6EmOV1w/i4ZTicYpRi6fX+dawkl81?=
 =?us-ascii?Q?pK4HjMi2+nq95WMMXrLCo8UalwP82jezblfvcT0SQM19yVj1DJNF8rmoMwBx?=
 =?us-ascii?Q?VCPvIkziakfMY8X+g4zmOyghKeaFfC6WH6/o5vv+wfV3fwnVgA69NzALbF8y?=
 =?us-ascii?Q?vBAXVWgBMTegqdnn6zAjiKQW97EZHWf+SKjKt09GaXyL11FcGhR7TsDM4JNj?=
 =?us-ascii?Q?Q2Pd7EKUEUpYV3J9knC0yb3zYyYwzhzYac4cXa77nCazHBUm8iz64rCNUtMa?=
 =?us-ascii?Q?f5HWIKLZkqO1DK2V2RDhTp8sNOix9Ng6wJop/r9lkZM8qCYtJ72dzeTg+f6k?=
 =?us-ascii?Q?gE2UbXncNntGjp4t0WHV/PVOtqkWTtgp5Wz2GUOK6esX+2Q6iKT83G1zshYn?=
 =?us-ascii?Q?3cItxn2+qsOQw54+6fx+HT2g25nlcZMwfiVd74Qd7eumjOXTfAkxUeTYir9+?=
 =?us-ascii?Q?O8oe56mghkcROxrb4fNgRLpMH9Pxv3p9zoUx3a/l2Tei9Yz19QxPsfAqHccM?=
 =?us-ascii?Q?8pghKko2PQETGGH6cymOLM02WjDVz6k5bqbFI0EqoejbSAW8W7PIpcoFi2BT?=
 =?us-ascii?Q?IyDJ32KXa6eM7OEjbK7dp7JiNSPGRod3BW00d9fKrJC9DMATJNN00VC/qn+t?=
 =?us-ascii?Q?lgFKjyPmiyDgIs1MMyBodlUJ40yt0s39SAl6VkhfsXffEenRCUUFfUlXWY2D?=
 =?us-ascii?Q?yC5k2pj4jPfhuGLtr1sixLE7emqGKs8I+ATOI+PKr3JY/H+BsZdrCSq5jWTx?=
 =?us-ascii?Q?MUHhQnaQRYKg61JsbzNbv9PTfERKUeSrnO8ygppL2sizo+jvWoi4z99V1wLg?=
 =?us-ascii?Q?8VzvC7QLpA+mgQqJt85JYR8rA8nD2uX73ULre6s/OfD6ZNRKTQ3GnAulfV0+?=
 =?us-ascii?Q?w45uQ28PvSyU2lF+29FMH5FzVC72qpqWcPRN/fuC/qpJDPPJkgOt3W/J788h?=
 =?us-ascii?Q?0S/oV2WYHwLC2kCq636p3gAdGLmfsyZ57J2qSojqwq/AcXDr7VQk9IMvZqvY?=
 =?us-ascii?Q?kVSyRRCctaWwhd+S8s8LDdKN/eAly061xgtiuRkQL6igdrpFvxx9692ibEf1?=
 =?us-ascii?Q?RyQrk5/YGI2dm0nzPOPkUBFWd4sBkSUf4xq0kT+0dz3XphHMnCidRgDbQZ7f?=
 =?us-ascii?Q?mwXWFu4wXlMHYz7jQsgIK8kQ0YCeWLMBaNCySkiRxvgm2C1LPIyTpdZJ4OMQ?=
 =?us-ascii?Q?/kYehRiSBFEFtznkUfdDO0brPfzg8EYW4FUspKJosHqP/G8Jm6b33Fz5FqlL?=
 =?us-ascii?Q?pwYoFZ9PrSQKjK4GVJDM7e1SPnmGpd0wPMYfTNnDCCRCC4km2RvZb3B/deg4?=
 =?us-ascii?Q?VpLQtdxOMLlfEEi43afmOxOo7RBjd2wMhQ0YR8K5Pg0rV7H190cCH1PLbLwS?=
 =?us-ascii?Q?jQJrF7LUJ7aPO8+g0ezegFyfAxZZzd5Ywp8oQgHBtJHMo6cuxvr/VLiWcgDh?=
 =?us-ascii?Q?BbyHaBDn+uTD+dewi4LEn1z+TPbxbVVkIAoa0g9Qs4qamsxiDqYHi8zZ9q45?=
 =?us-ascii?Q?zfLSKW2OUiIFwZwq6a3hogQ3hI9y5GOhoOKbxqeOKSYsJ6hvMyE5IaDC3yXg?=
 =?us-ascii?Q?DBcnm74cKEGon2cF8MGQo+swziQJkg/n3tk2tUl/jEsC/MUbX0B5QCFtZV7w?=
 =?us-ascii?Q?lncS+TZ8lw=3D=3D?=
X-Exchange-RoutingPolicyChecked: bEs18J3bWNDMjRbpT5j+SIaD2QdtY53wl2kPplTIV0GPBtjtZcbndkb4ZQogFcZg8v5CVEO4tDXxXlhmxj3gUwZaYlx+6C5QiAXTk1fZJDb8N69BiD6H/6VlCF4LZcM+/6TyDLC6aHZtk36eFqQoj0uTacZjpeD2hy35vWcsVw8Pfw37ztv2TIBVLFFxfN71e9QMuor3JN9vcI0SygXzjhi4q4FsscothRAzkjXrjD2Y0hC5OEUrrzba67IdlHJg8w1yX2vdWGXsRj1fWkXzeLOcT9h9Ri9pFJJIEXy3aogHTJYwLms9+cy3BJyUGNFiOIJ76ZaIh5TNvhqUbFJPiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8796f851-c973-4e09-544c-08df2bcd0a1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:32:55.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjLiL4iSp7URRTfAl72BKXLVtTQdZHkgka4hkYH8aPj98kyWsoY4kY14qx2cOBdbnqaHdbKsQvcf/8+0hfaxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB205273
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

On Fri, Oct 16, 2026 at 02:09:15PM -0600, Zack McKevitt wrote:
> 
> 
> On 10/14/2026 3:11 PM, Rodrigo Vivi wrote:
> > On Fri, Oct 09, 2026 at 10:31:51AM -0700, Zack McKevitt wrote:
> > > Add a new node type, attribute set, and doit function for performing
> > > telemetry read and write operations using the DRM RAS interface.
> > 
> > Hi Zack,
> > 
> > I'm glad to see more users of drm-ras and glad that the flexibility is paying of
> > 
> > > 
> > > Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > > ---
> > >   Documentation/netlink/specs/drm_ras.yaml |  55 ++++++-
> > >   drivers/gpu/drm/drm_ras.c                | 193 ++++++++++++++++++++++-
> > >   drivers/gpu/drm/drm_ras_nl.c             |  29 ++++
> > >   drivers/gpu/drm/drm_ras_nl.h             |   6 +
> > >   include/drm/drm_ras.h                    |  39 +++++
> > >   include/uapi/drm/drm_ras.h               |  14 ++
> > 
> > just to confirm, you used ynl to generate these most of these files right?
> > Please make sure to mention in the commit message so we are sure.
> > 
> 
> Correct, ill add a note in the commit in the v2.
> 
> > >   6 files changed, 327 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > > index a88fdab7a1c7..d558eb1cba3f 100644
> > > --- a/Documentation/netlink/specs/drm_ras.yaml
> > > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > > @@ -16,7 +16,7 @@ definitions:
> > >       type: enum
> > >       name: node-type
> > >       value-start: 1
> > > -    entries: [error-counter]
> > > +    entries: [error-counter, telemetry]
> > >       doc: >-
> > >            Type of the node. Currently, only error-counter nodes are
> > 
> > Please ensure that the doc is also updated.
> > 
> 
> Will do.
> 
> > >            supported, which expose reliability counters for a hardware/software
> > > @@ -100,6 +100,31 @@ attribute-sets:
> > >           name: error-value
> > >           type: u32
> > >           doc: Current value of the error counter.
> > > +  -
> > > +    name: telemetry-attrs
> > > +    attributes:
> > > +      -
> > > +        name: node-id
> > > +        type: u32
> > > +        doc: >-
> > > +             Unique identifier for the node.
> > > +             Assigned dynamically by the DRM RAS core upon registration.
> > > +      -
> > > +        name: field
> > > +        type: u32
> > > +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> > > +      -
> > > +        name: value
> > > +        type: u64
> > > +        doc: Value of telemetry field that was read/written.
> > > +      -
> > > +        name: status
> > > +        type: s32
> > > +        doc: Status of the telemetry operation.
> > 
> > is this status the hardware itself that is giving?
> > Please add some doc around it to help us understand the need and see if
> > is generic enough and mandatory vs optional.
> > 
> 
> Yes, it is a hardware status. I will add a more in depth doc for this in the
> next iteration.
> 
> > > +      -
> > > +        name: pad
> > > +        type: pad
> > > +        doc: Alignment padding used for 64-bit
> > >   operations:
> > >     list:
> > > @@ -198,6 +223,34 @@ operations:
> > >               - node-id
> > >               - error-id
> > >               - error-threshold
> > > +    -
> > > +      name: telemetry-read
> > 
> > should we do get_/set_ instead of read/write to align with the existing
> > entries?!
> > 
> 
> Sure, will do.
> 
> > > +      doc: Perform a read of the specified telemetry field.
> > > +      attribute-set: telemetry-attrs
> > > +      do:
> > > +        pre: drm-ras-nl-pre-telemetry
> > > +        request:
> > > +          attributes:
> > > +            - node-id
> > > +            - field
> > 
> > how do users know what field to read?
> > Why not a dump or at least a dump field for field discovery?
> > 
> 
> We define the set of fields for our devices in our uapi file qaic_accel.h,
> but I think a dump is probably a good idea here.
> 
> > > +        reply:
> > > +          attributes:
> > > +            - value
> > > +            - status
> > > +    -
> > > +      name: telemetry-write
> > > +      doc: Perform a write of the specified telemetry field.
> > 
> > what is a write telemetry operation?
> 
> Our device has certain fields that are writable, e.g.,
> QAIC_DEVINFO_THERMAL_WARNING_TEMP where the host is able to modify the
> device's thermal warning temperature threshold. These make up a small subset
> of telemetry fields.

I see... I believe this aligns well with the error-threshold...
perhaps we need a set/get threshold that is independent of your
actual telemetry get?!

> 
> > can we make this optional?
> > 
> 
> Sure, I will make it optional in the v2.
> 
> > even write is allowed without admin cap?
> > 
> 
> It seems like all of our existing writable telemetry fields should be
> restricted to admin cap only, so I will add the admin cap back in for this.
> 
> > > +      attribute-set: telemetry-attrs
> > > +      do:
> > > +        pre: drm-ras-nl-pre-telemetry
> > > +        request:
> > > +          attributes:
> > > +            - node-id
> > > +            - field
> > > +            - value
> > > +        reply:
> > > +          attributes:
> > > +            - status
> > >   mcast-groups:
> > >     list:
> > > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > > index b099eb67836e..b88293295cda 100644
> > > --- a/drivers/gpu/drm/drm_ras.c
> > > +++ b/drivers/gpu/drm/drm_ras.c
> > > @@ -53,6 +53,15 @@
> > >    * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> > >    *    Userspace must provide Node ID, Error ID and threshold to be set.
> > >    *
> > > + * 8. TELEMETRY_READ: Read a telemetry value.
> > > + *    Userspace must provide Node ID and telemetry field to be read.
> > > + *    Returns the status of the read and the value read (if valid).
> > > + *
> > > + * 9. TELEMETRY_WRITE: Write a telemetry value.
> > > + *    Userspace must provide Node ID, the telemetry field to write, and the value
> > > + *    to be written.
> > > + *    Returns the status of the write.
> > > + *
> > >    * Node registration:
> > >    *
> > >    * - drm_ras_node_register(): Registers a new node and assigns
> > > @@ -63,7 +72,6 @@
> > >    * Node type:
> > >    *
> > >    * - ERROR_COUNTER:
> > > - *     + Currently, only error counters are supported.
> > >    *     + The driver must implement the query_error_counter() callback to provide
> > >    *       the name and the value of the error counter.
> > >    *     + The driver must provide a error_counter_range.last value informing the
> > > @@ -81,6 +89,12 @@
> > >    *       that are raised by the hardware.
> > >    *     + The driver is responsible for error threshold bounds checking.
> > >    *
> > > + * - TELEMETRY:
> > > + *     + The driver must implement the telemetry_read() and telemetry_write()
> > > + *       callbacks.
> > > + *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
> > > + *       to enforce permissions checks on telemetry operations.
> > > + *
> > >    * Netlink handlers:
> > >    *
> > >    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> > > @@ -95,6 +109,12 @@
> > >    *   operation, fetching the error threshold of a specific counter.
> > >    * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> > >    *   operation, setting the error threshold of a specific counter.
> > > + * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE
> > > + *   pre_doit operation, returning 0 if valid.
> > > + * - drm_ras_nl_telemetry_read_doit(): Implements the TELEMETRY_READ doit operation,
> > > + *   invoking the driver's telemetry_read callback and returning the results.
> > > + * - drm_ras_nl_telemetry_write_doit(): Implements the TELEMETRY_WRITE doit operation,
> > > + *   invoking the driver's telemetry_write callback and returning the results.
> > >    */
> > >   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > > @@ -617,6 +637,156 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> > >   	return set_node_error_threshold(node_id, error_id, threshold);
> > >   }
> > > +/**
> > > + * drm_ras_nl_pre_telemetry - Enforce permission checks
> > > + * @ops: Generic netlink operations
> > > + * @skb: Netlink message buffer
> > > + * @info: Generic Netlink info containing attributes of the request
> > > + *
> > > + * Enforces a telemetry node's pre_doit conditions (if they exist).
> > > + *
> > > + * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
> > > + */
> > > +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
> > > +			     struct genl_info *info)
> > > +{
> > > +	struct drm_ras_node *node;
> > > +	u32 node_id;
> > > +
> > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > +	node = xa_load(&drm_ras_xa, node_id);
> > > +
> > > +	if (node->telemetry_pre)
> > > +		return node->telemetry_pre(node);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * drm_ras_nl_telemetry_read_doit() - Query a telemetry value
> > > + * @skb: Netlink message buffer
> > > + * @info: Generic Netlink info containing attributes of the request
> > > + *
> > > + * Extracts the telemetry field from the netlink attributes and
> > > + * reads that value from the device.
> > > + *
> > > + * Return: 0 on success, or negative errno on failure.
> > > + */
> > > +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info)
> > > +{
> > > +	struct drm_ras_node *node;
> > > +	struct sk_buff *msg;
> > > +	struct nlattr *hdr;
> > > +	u32 node_id, field;
> > > +	s32 status;
> > > +	u64 value;
> > > +	int ret;
> > > +
> > > +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
> > > +		return -EINVAL;
> > > +
> > > +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > +
> > > +	node = xa_load(&drm_ras_xa, node_id);
> > > +	if (!node || !node->telemetry_read)
> > > +		return -ENOENT;
> > > +
> > > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > > +	if (!msg)
> > > +		return -ENOMEM;
> > > +
> > > +	hdr = genlmsg_iput(msg, info);
> > > +	if (!hdr) {
> > > +		nlmsg_free(msg);
> > > +		return -EMSGSIZE;
> > > +	}
> > > +
> > > +	ret = node->telemetry_read(node, &field, &value, &status);
> > > +	if (ret) {
> > > +		nlmsg_free(msg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> > > +	if (ret) {
> > > +		genlmsg_cancel(msg, hdr);
> > > +		nlmsg_free(msg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = nla_put_64bit(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, sizeof(value),
> > > +			    &value, DRM_RAS_A_TELEMETRY_ATTRS_PAD);
> > > +	if (ret) {
> > > +		genlmsg_cancel(msg, hdr);
> > > +		nlmsg_free(msg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	genlmsg_end(msg, hdr);
> > > +
> > > +	return genlmsg_reply(msg, info);
> > > +}
> > > +
> > > +/**
> > > + * drm_ras_nl_telemetry_write_doit() - Write a telemetry value
> > > + * @skb: Netlink message buffer
> > > + * @info: Generic Netlink info containing attributes of the request
> > > + *
> > > + * Extracts the telemetry field and value to be written from the netlink
> > > + * attributes and writes that value to the specified field on the device.
> > > + *
> > > + * Return: 0 on success, or negative errno on failure.
> > > + */
> > > +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb, struct genl_info *info)
> > > +{
> > > +	struct drm_ras_node *node;
> > > +	struct sk_buff *msg;
> > > +	struct nlattr *hdr;
> > > +	u32 node_id, field;
> > > +	s32 status;
> > > +	u64 value;
> > > +	int ret;
> > > +
> > > +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
> > > +		return -EINVAL;
> > > +
> > > +	value = nla_get_u64(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
> > > +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > +
> > > +	node = xa_load(&drm_ras_xa, node_id);
> > > +	if (!node || !node->telemetry_read)
> > > +		return -ENOENT;
> > > +
> > > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > > +	if (!msg)
> > > +		return -ENOMEM;
> > > +
> > > +	hdr = genlmsg_iput(msg, info);
> > > +	if (!hdr) {
> > > +		nlmsg_free(msg);
> > > +		return -EMSGSIZE;
> > > +	}
> > > +
> > > +	ret = node->telemetry_write(node, &field, &value, &status);
> > > +	if (ret) {
> > > +		nlmsg_free(msg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> > > +	if (ret) {
> > > +		genlmsg_cancel(msg, hdr);
> > > +		nlmsg_free(msg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	genlmsg_end(msg, hdr);
> > > +
> > > +	return genlmsg_reply(msg, info);
> > > +}
> > > +
> > >   /**
> > >    * drm_ras_node_register() - Register a new RAS node
> > >    * @node: Node structure to register
> > > @@ -631,14 +801,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
> > >   	if (!node->device_name || !node->node_name)
> > >   		return -EINVAL;
> > > -	/* Currently, only Error Counter Endpoints are supported */
> > > -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> > > -		return -EINVAL;
> > > -
> > > -	/* Mandatory entries for Error Counter Node */
> > > -	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
> > > -	    (!node->error_counter_range.last || !node->query_error_counter))
> > > +	/* Currently, only Error Counter and Telemetry endpoints are supported */
> > > +	switch (node->type) {
> > > +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> > > +		/* Mandatory entries for Error Counter Node */
> > > +		if (!node->error_counter_range.last || !node->query_error_counter)
> > > +			return -EINVAL;
> > > +		break;
> > > +	case DRM_RAS_NODE_TYPE_TELEMETRY:
> > > +		/* Mandatory entries for Telemetry Node */
> > > +		if (!node->telemetry_read || !node->telemetry_write)
> > > +			return -EINVAL;
> > > +		break;
> > > +	default:
> > >   		return -EINVAL;
> > > +	}
> > >   	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
> > >   }
> > > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > > index ff0dc406c27c..4577bc1a333e 100644
> > > --- a/drivers/gpu/drm/drm_ras_nl.c
> > > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > > @@ -41,6 +41,19 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
> > >   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> > >   };
> > > +/* DRM_RAS_CMD_TELEMETRY_READ - do */
> > > +static const struct nla_policy drm_ras_telemetry_read_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
> > > +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
> > > +};
> > > +
> > > +/* DRM_RAS_CMD_TELEMETRY_WRITE - do */
> > > +static const struct nla_policy drm_ras_telemetry_write_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
> > > +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
> > > +	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_U64, },
> > > +};
> > > +
> > >   /* Ops table for drm_ras */
> > >   static const struct genl_split_ops drm_ras_nl_ops[] = {
> > >   	{
> > > @@ -83,6 +96,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> > >   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > >   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > >   	},
> > > +	{
> > > +		.cmd		= DRM_RAS_CMD_TELEMETRY_READ,
> > > +		.pre_doit	= drm_ras_nl_pre_telemetry,
> > > +		.doit		= drm_ras_nl_telemetry_read_doit,
> > > +		.policy		= drm_ras_telemetry_read_nl_policy,
> > > +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
> > > +		.flags		= GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd		= DRM_RAS_CMD_TELEMETRY_WRITE,
> > > +		.pre_doit	= drm_ras_nl_pre_telemetry,
> > > +		.doit		= drm_ras_nl_telemetry_write_doit,
> > > +		.policy		= drm_ras_telemetry_write_nl_policy,
> > > +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> > > +		.flags		= GENL_CMD_CAP_DO,
> > > +	},
> > >   };
> > >   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > > index 9aef097ea10f..4bdd7ed268a1 100644
> > > --- a/drivers/gpu/drm/drm_ras_nl.h
> > > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > > @@ -12,6 +12,9 @@
> > >   #include <uapi/drm/drm_ras.h>
> > > +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
> > > +			     struct sk_buff *skb, struct genl_info *info);
> > > +
> > >   int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
> > >   				 struct netlink_callback *cb);
> > >   int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> > > @@ -24,6 +27,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > >   					struct genl_info *info);
> > >   int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> > >   					struct genl_info *info);
> > > +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info);
> > > +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb,
> > > +				    struct genl_info *info);
> > >   enum {
> > >   	DRM_RAS_NLGRP_ERROR_REPORT,
> > > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > > index 1765a3130b09..2a2cdd44839d 100644
> > > --- a/include/drm/drm_ras.h
> > > +++ b/include/drm/drm_ras.h
> > > @@ -100,6 +100,45 @@ struct drm_ras_node {
> > >   	 */
> > >   	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> > > +	/**
> > > +	 * @telemetry_pre:
> > > +	 *
> > > +	 * This callback is used to enforce any pre_doit conditions necessary
> > > +	 * for telemetry. This is an optional callback for telemetry_node.
> > > +	 *
> > > +	 * Returns 0 on success, negative error code on failure.
> > > +	 */
> > > +	int (*telemetry_pre)(struct drm_ras_node *ep);
> > > +
> > > +	/**
> > > +	 * @telemetry_read:
> > > +	 *
> > > +	 * This callback is used for a drm-ras telemetry node to read a
> > > +	 * telemetry value. This is a mandatory callback for telemetry_node.
> > > +	 *
> > > +	 * The callback will read the desired device-specific field into value
> > > +	 * and update status corresponding to a device-specific error code.
> > > +	 *
> > > +	 * Returns 0 on success, negative error code on failure.
> > > +	 */
> > > +	int (*telemetry_read)(struct drm_ras_node *ep, u32 *field, u64 *value,
> > > +			      s32 *status);
> > > +
> > > +	/**
> > > +	 * @telemetry_write:
> > > +	 *
> > > +	 * This callback is used for a drm-ras telemetry node to write a
> > > +	 * telemetry value. This is a mandatory callback for telemetry_node.
> > > +	 *
> > > +	 * The callback will write the value to the desired device-specific
> > > +	 * field and update status corresponding to a device-specific error
> > > +	 * code.
> > > +	 *
> > > +	 * Returns 0 on success, negative error code on failure.
> > > +	 */
> > > +	int (*telemetry_write)(struct drm_ras_node *ep, u32 *field, u64 *value,
> > > +			       s32 *status);
> > > +
> > >   	/** @priv: Driver private data */
> > >   	void *priv;
> > >   };
> > > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > > index 2f832275ee6e..d39c78a9ed5a 100644
> > > --- a/include/uapi/drm/drm_ras.h
> > > +++ b/include/uapi/drm/drm_ras.h
> > > @@ -16,6 +16,7 @@
> > >    */
> > >   enum drm_ras_node_type {
> > >   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> > > +	DRM_RAS_NODE_TYPE_TELEMETRY,
> > >   };
> > >   enum {
> > > @@ -51,6 +52,17 @@ enum {
> > >   	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> > >   };
> > > +enum {
> > > +	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
> > > +	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
> > > +	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> > > +	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
> > > +	DRM_RAS_A_TELEMETRY_ATTRS_PAD,
> > > +
> > > +	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
> > > +	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
> > > +};
> > > +
> > >   enum {
> > >   	DRM_RAS_CMD_LIST_NODES = 1,
> > >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > > @@ -58,6 +70,8 @@ enum {
> > >   	DRM_RAS_CMD_ERROR_EVENT,
> > >   	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > >   	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > > +	DRM_RAS_CMD_TELEMETRY_READ,
> > > +	DRM_RAS_CMD_TELEMETRY_WRITE,
> > >   	__DRM_RAS_CMD_MAX,
> > >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> > > -- 
> > > 2.43.0
> > > 
> 
