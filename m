Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB69C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E9F10E1CC;
	Mon, 21 Sep 2026 05:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KVOzJddh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DE510E1CC;
 Mon, 21 Sep 2026 05:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789968609; x=1821504609;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+MTJvBcukuXwQGT4elsOdibY14XMHEPf4xFyab422Eo=;
 b=KVOzJddhNEF6oU8aaRCjgd7WpHMj4Xm9FicQNoBUtT5kA44vfzUPXQ9k
 TaniICsb8YmkbRZ6F+fLV2GEeQOiGeDFNjHXL6N5nH8DwQQ/DTlbB/5AR
 2IIyPN+sgiTDIbT9N+gxd9xsHwtEldkcktpRrVUoObtQp7sc7SBUnmWnl
 8NuoV/N4JgxNyUmTJgPn1fwbGSYfZAurxtJGLq4ExSrbif8g0IxJR2VH2
 jE4m3ro40aP14s8gF+A7s2Vxpk6mP8Rno6QPkEp6R6wt8+sNyojMxe5ZH
 iGYkHwFiVBiNPsF6h0FW6IDOGSw9El65sw/55/bCfNyLNItfP6qFAeSwW A==;
X-CSE-ConnectionGUID: eMAN20vyTMGUOso6nFiEcA==
X-CSE-MsgGUID: 7zRPEWQ+Ri6SNDcdU9WPgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90477438"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="90477438"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:30:08 -0700
X-CSE-ConnectionGUID: 8g0MomS0ROGLWOXNP40Khw==
X-CSE-MsgGUID: LxT9gfMCQViyGT3BIQTOrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="271643357"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:30:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 22:30:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 20 Sep 2026 22:30:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 22:30:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x80ofLXNhJXYpU4vvDZBE0W8KSiJyj65/wjcVEw7yj5kGG3Y2f7kyt2BwU0uzc4d6wuYmRWSxhoK/5IHJS58ceVVpwUZJ2XZuOKDTPTAOV0S6XLbVWb1MFhKj262S4+7zzOSSgq1tdUVjFSZ8aFAxZMRofusPIAD/tOYn8F+Up+8JboCJJIey4JHMo7QZIEllH61/oZnuGEgs5BAwmdk8NEw5E/cs1zQEbUQXvVvd6QnxzWN8K2UgRT/L1cWxlA697Mi+iXlmTv8iQb/Cb3Rw9LIkbaOEghfbfxjV+DeKcSRNZM3O4aGv+A+JlzHalZn/chDnanR5DX6mylMdhtmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0VEVza/N7hDPxMkDjmzj0Qau2WNcBJNk3WY/agiolI=;
 b=oRgp8EjkdpXSFy6tdUuw133vufd6i3cVgGnYcab/0p4K86sJhOjD2U011AP8cQ51AZyY7sdO8Jv4Yd2FSOlW9t7A2WdKQAkmHblQVZYVvi/WHSnK8vbjDCDKoFdgGbdXjuH/hGXruqPAN3Lkfij5Vn1as399i0rxKtD9edYuFHM7pPG38PwIMV1t47uEjAqDtxSCCRQuTb00wJyuUe6QY3iymW0MwLEp9b5WX2yyIzcqr3VmTIX7saPnCPaPd5K1Fw5zZ8DfVtlF6BJUwrlxCXfVUjRcoxW7cBnJ1nYIj6B8bOX7nRO2TvZ0y+SH5IELPGOo3IvKecWjGkMtUs3xKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:30:04 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:30:04 +0000
Date: Sun, 20 Sep 2026 22:30:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Message-ID: <arDA2pUYH7uoUpE2@gsse-cloud1.jf.intel.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
 <20260917163553.1742580-3-talesam@gmail.com>
 <aq214e+ia3nHVrKB@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq214e+ia3nHVrKB@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 98edc0c0-cad5-43cf-c50b-08df17a163f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gR+yK5xWb1vWfmTKkAeUxIIdBghTZkyR4wlr6ZKzh7XFnlPpxCyq0/muPSF+JAq6Q4H297JqrKKpsXG3/XgeX8icozXJMJJZ3U16ZsiFtJNRbsl30klWbthOpBe2ZE1KE2gx6XLWP7/4vTWsZiMF5fz8Z0yHYlJMIfsqCL7hV07mzGvYsXCUmUMEkEWC4GYkuLb4M6QYMEfHbmhU7v3JGt3Be32VVIlgXE0V26xgr6X96WEkqnSRiDloge0VMLlEYHbWVGv9WJ9U93Z90u+quEOU8PjFQLij9PbKEyuyvxepmhRCEXWWU5PVJ9ggAa49MI58ZGG9ogyH9bcZeDNaVNgu2SDKo4JYuXWYo8xDy8P2ExfPLdFMhQg0CmYTfzp/1YpRMAvzzQfDc1fphP4YKOHqlQC8ExNEwaiz/Ko7nK9JmJ9Wqm751DAnwGs4CQ053M6dpIZPaejdNpLhZ4a0+iX7DVYVSl2Rt1zSDRTlS7iiEurIxilvA1X1ZS+Jd2BoFGDlUGTqeoL+aLdOI/0A9vuFcULIHEHAAX+fAl2VwwkHgni7AlDrFQKDZg3xfDnbZimTChyPjcTSnz3Vgi6rtzRos2b/eoArDYthWWoV2FIOsSqbVJEw819whk+/JQqq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?efCE+6QRdoPZiMEbE32eNf08J1wX9T0TlxixRXghR0IyEIFYEX6my9EHps?=
 =?iso-8859-1?Q?A/Jqj4XoSDjDTDn/rUNUcJAQ5zR5pbD8uopvPNIRWk9hpEKKItrkY6lsy5?=
 =?iso-8859-1?Q?V+pDxljpzouSfQQgoxaIKECmzC4Q0DDH0M+m5tZwEUuVdl3dXqWX4U6hYR?=
 =?iso-8859-1?Q?ZFffGPU+fPrJTwDIZUtQBlpNRu4cU4tfRT8HIcXFyN3GgJ20WYVd4oHARy?=
 =?iso-8859-1?Q?c2kgnHJBnAB1wjLPcEpqH2hX10zMbwkCJL53VW/JxHvGHzDVEAX9doarEi?=
 =?iso-8859-1?Q?p5FL0ZtxguvI28MHetvOr6ZQBo1tcxV3U7T9ddwmdFIlOncexIwlexE7PJ?=
 =?iso-8859-1?Q?ntOAxbNwste84Xrz1ycj4u9/qtJKrvhNBcSM6x0c5SF+ejiCn7hvOtKeTm?=
 =?iso-8859-1?Q?Qid/qb+0O++Ti/szZ+fXLMXw1lbyVKeJ5P08i+72yZvpi3HqCesK+HvtwN?=
 =?iso-8859-1?Q?WjI8ETA0yBcDbjqIYGeOG5AOArzlXmiH8noLOW9eCwv8U0NfGqp/RECFr7?=
 =?iso-8859-1?Q?H2f1+1avX84acXF/N+cUBkXd6wMd8jEN0ITPpbdEeUZpMcXYK8/ytx/XuN?=
 =?iso-8859-1?Q?9R8nSLTBwvD9+HMU+9E5/CDE4I+3ynGRNfVB8McggX3nhExHrE4+F2yxN9?=
 =?iso-8859-1?Q?dfPoMrXmuZWXqQYHyHeCQ2nwRpXei7iXV6ORpxVdQQIR8QEB/XnOT1qjR/?=
 =?iso-8859-1?Q?E6LAhVifxsNCHxasaOF6/CUf7YnuSpjYB0e105XhbBrnmQc5drWMrcmvse?=
 =?iso-8859-1?Q?vOBisGNNKoY0Zi5LuCdhXTC4HCdLsUiomGo694kiEOdRj7qUQC0LHhALGt?=
 =?iso-8859-1?Q?Sl79iVTW1EF59u+GKE97rt4pVd08kDf7qZC8XFYjh21fLxx4zdylYcxoPy?=
 =?iso-8859-1?Q?5rzZerkisdD8gCk87hiJj+HTx/jvXnveJs5GZDie/JqLRtwPoJOE8vnzuV?=
 =?iso-8859-1?Q?4XMAyvo/e/m7ytsYPZJa8xGLGgrc8nmD6xJZ9EoGxDUE68KiTJACMs7dm1?=
 =?iso-8859-1?Q?GDr4MHa8bFeKxHHDkXhhOXTR0BeKdtIpUfdxVujX/v83olJIonCP42/sAF?=
 =?iso-8859-1?Q?ZPfSERifZNmLDl/Lm50SfmCRkKFcr/q7f5Zee/H7ctU+NDtsVhj5kr07l3?=
 =?iso-8859-1?Q?ESZz+9cYoNUILXibswZEHlicP3VmhC0WJ0+TnJg9IrYz+nR7sxqbuQmcJ/?=
 =?iso-8859-1?Q?0azhelrlNqWHPSvFQwtdaAEq8v/YG/eeuCAg3bvHyMtVpDBhp8hoQ3zldm?=
 =?iso-8859-1?Q?1BSzwhGqprC9/B4vJYfOq1vfpfyljiXCv4+2ZB5MOzug5nR555jk8ji0SB?=
 =?iso-8859-1?Q?6F+YPAFaT6k0KapJVQOK7QgHzZX2mZTPKU+2nRIz5oAKGFWBPgWloR7lrK?=
 =?iso-8859-1?Q?4vxUjRzsryzk4BLkrt21FHbJw8LDG0xrHX76Az0x7x+LUJxtBN+u77Q53m?=
 =?iso-8859-1?Q?w5L7n3Tf+4S/9wxF/9EztpwzZ0lUGVqONGWlaLg1Fz19MNfDrpDD8zTwmc?=
 =?iso-8859-1?Q?/T+bO6V8VBx1oLi3U65TJcMXgnADGZp4FpcWl0zFtP7kZPvDAW5euKBGfA?=
 =?iso-8859-1?Q?N0f1kFHsM0jk9KjW0B09Nti5tH1RzS8RL43104YhcNux/2DH43oWUVLhsq?=
 =?iso-8859-1?Q?cQBxnsibbZD/b9B8/pxq/g0FzUA73ouvAQIUpO09DPFGk3+CRXthWoIPyy?=
 =?iso-8859-1?Q?XoecX1XYHyM5pfqQ0megHYiOlGRO509tuGTu31+Jqqjbxp8kaSryfVybMk?=
 =?iso-8859-1?Q?doYGtli0MOW0/lf19bgwcvMAUo6zwDw7kncbChM1qj5ZRDp9XTFv8HWfdH?=
 =?iso-8859-1?Q?ZpS8aLeJLQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: qg3n/l605uTHTn77HLOAAhbsNEV0X+3QPU1reGYBKL1Y5jKBg//RjQWnPmeolghEPRVMmS3QjRiwr/37FKbol02JqDdNzG/2/or07Nooahvsw4xHcVeTcQjEu678ZnnGuebg/kRKtimbcyxUcOQZIkfYSFVg19LrTSIeknfBLlUTi1o+oFld0AgH68mF8XwzEgLgO3N+CFTe5n33NpZ+MT222tbZCeVfdYX/ZN3j+XMZI/e2VWeBp9GFO7iR7qH9eO+aHleb++HDlNQR48JNZORYrG6ko6duSp2z63Y+yfKdVOBs3ATCjORMElRi/6WleqqgxUeBAxsHox5apJsOOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98edc0c0-cad5-43cf-c50b-08df17a163f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:30:04.6096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jt1KUVxxNuKuvqzdfbMExu8JYhzsCBycuMj2JDmsbffe4bFt2l6AS0UmrgI+co+VTACLC+fWMP4OoAhjQTRjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
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

On Fri, Sep 18, 2026 at 03:06:25PM -0700, Matthew Brost wrote:
> On Thu, Sep 17, 2026 at 01:35:52PM -0300, Tales A. Mendonça wrote:
> > When a TLB invalidation fence times out we log the timeout, but if the
> > ack for that seqno later shows up there is no record of it, making it
> > impossible to tell from logs whether the ack was lost forever or merely
> > (very) late.
> > 
> > Track the most recent timed out seqno and log how late its ack arrives,
> > relative to both the original request and the moment the fence was
> > signaled with -ETIME.
> > 
> > On ARL with GuC 70.53.0 this shows the acks are never lost: they
> > consistently arrive ~2.3s after the request, tens of milliseconds after
> > the TDR has already signaled the fence:
> > 
> >   TLB invalidation fence timeout, seqno=10992 recv=10991
> >   TLB invalidation late ack: seqno=10992 recv=10992,
> >     request-to-ack=2314ms, timeout-to-ack=45ms
> > 
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> 
> I would give this an RB but my colleagues have done a bunch of work on
> SIGID and I haven't been involved at all, so I need some help here.
> 

I discussed with my colleagues - the we agree the TLB component should
hook into SIGID for logging but we will do this as a follow up on top of
this change.

So this is:
Reviewed-by: Matthew Brost <matthew.brost@intel.com> 

> > ---
> >  drivers/gpu/drm/xe/xe_tlb_inval.c       | 19 +++++++++++++++++++
> >  drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
> >  2 files changed, 36 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> > index 7a0c04fac60..7047a347551 100644
> > --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> > +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> > @@ -14,6 +14,7 @@
> >  #include "xe_guc_tlb_inval.h"
> >  #include "xe_mmio.h"
> >  #include "xe_pm.h"
> > +#include "xe_printk.h"
> >  #include "xe_tlb_inval.h"
> >  #include "xe_trace.h"
> >  
> > @@ -99,6 +100,11 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
> >  			fence->seqno, tlb_inval->seqno_recv);
> >  
> >  		timedout_seqno = fence->seqno;
> > +		if (!tlb_inval->timedout_seqno) {
> > +			tlb_inval->timedout_seqno = fence->seqno;
> > +			tlb_inval->timedout_inval_time = fence->inval_time;
> > +			tlb_inval->timedout_time = ktime_get();
> > +		}
> >  
> >  		fence->base.error = -ETIME;
> >  		xe_tlb_inval_fence_signal(fence);
> > @@ -227,6 +233,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
> >  	else
> >  		pending_seqno = tlb_inval->seqno - 1;
> >  	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
> > +	tlb_inval->timedout_seqno = 0;
> >  
> >  	list_for_each_entry_safe(fence, next,
> >  				 &tlb_inval->pending_fences, link)
> > @@ -454,6 +461,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
> >  
> >  	WRITE_ONCE(tlb_inval->seqno_recv, seqno);
> >  
> > +	if (tlb_inval->timedout_seqno &&
> > +	    xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->timedout_seqno)) {
> > +		ktime_t now = ktime_get();
> > +
> > +		xe_warn(xe,
> > +			"TLB invalidation late ack: seqno=%d recv=%d, request-to-ack=%lldms, timeout-to-ack=%lldms",
> > +			tlb_inval->timedout_seqno, seqno,
> > +			ktime_ms_delta(now, tlb_inval->timedout_inval_time),
> > +			ktime_ms_delta(now, tlb_inval->timedout_time));
> 
> Should this be some type SIGID message?
> 
> Matt
> 
> > +		tlb_inval->timedout_seqno = 0;
> > +	}
> > +
> >  	list_for_each_entry_safe(fence, next,
> >  				 &tlb_inval->pending_fences, link) {
> >  		trace_xe_tlb_inval_fence_recv(xe, fence);
> > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> > index d77be1aedc9..80d2019fa20 100644
> > --- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> > +++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> > @@ -112,6 +112,23 @@ struct xe_tlb_inval {
> >  	 * @pending_lock: protects @pending_fences and updating @seqno_recv.
> >  	 */
> >  	spinlock_t pending_lock;
> > +	/**
> > +	 * @timedout_seqno: seqno of the most recent timed out TLB
> > +	 * invalidation, 0 if none. Used to measure how late the ack for a
> > +	 * timed out invalidation actually arrives. Protected by
> > +	 * @pending_lock.
> > +	 */
> > +	int timedout_seqno;
> > +	/**
> > +	 * @timedout_inval_time: request time of @timedout_seqno. Protected by
> > +	 * @pending_lock.
> > +	 */
> > +	ktime_t timedout_inval_time;
> > +	/**
> > +	 * @timedout_time: time @timedout_seqno was signaled with -ETIME.
> > +	 * Protected by @pending_lock.
> > +	 */
> > +	ktime_t timedout_time;
> >  	/**
> >  	 * @fence_tdr: schedules a delayed call to xe_tlb_fence_timeout after
> >  	 * the timeout interval is over.
> > -- 
> > 2.55.0
> > 
