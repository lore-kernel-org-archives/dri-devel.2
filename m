Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6009C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1EF10E46C;
	Wed,  2 Sep 2026 05:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CDDZ/9QZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCF210E468;
 Wed,  2 Sep 2026 05:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788327659; x=1819863659;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zun/HW3AOBSL7G5qDe+jstqFZhj+fbUtJdD+0RJ6uuI=;
 b=CDDZ/9QZsrLtzmbIoKznJtH/S07rWvvSY0+jVWwQlKv9YGjSmILYN8B4
 EtIks8tdo5H7WUcoPUaS250nfUGUIqgNRyPfdTjK+oeVfyG6Fqtb52NGM
 j1Ufihf8w6WxEvHdGha9PYzdzwLvc77biyVcJsDMQEc4YHHYkX+0KZDxe
 GXDfPUkjrXBDx0PHhoK5U9sgEY7Ta2ad2XWn62PhJsjpCpa+dWf1Swx14
 suKovryWfnnopLKVeArsTGYmDd8BepHxm1h/haoEunsFxH0W5jxIRkdpP
 kBJ19e7PU4IPCR6I99BK7iS97bjaVN8pAPyvvIxaCGMkn6JK4biyk/QaK g==;
X-CSE-ConnectionGUID: wbeR5L13TxG7vbXSOsmgIw==
X-CSE-MsgGUID: HZmKWguDTby+ParFkGFhfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92593306"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92593306"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:40:59 -0700
X-CSE-ConnectionGUID: I0bqALSETLai9GRpJRp8/g==
X-CSE-MsgGUID: MhUBgF/QSOKRlk1WpUCidw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="274572374"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:40:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:40:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 22:40:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff0R95CSTeiXMKJFhj4gid0FkqwpPWJ2alg4FlO98Yk3W6sU9C4XXNZu7NnW5zPDTBFJPMDwY6IhExWAJrY/GVIsYcFQ/YfjvxZchazx/r4qOPDuldPBGocnzXfX+ih58l6QEcJlW1jrq6p6dvLgtktgmjlsiOIaHWic6Sgu1tK+Po1QX+6Xcqm1daKQCLo8NvfhoAiElYa9hJN1SbRDaRinudmJoRR6BbY2Er7NosNxUaS2+9XmMONZKJndyvZlK1wzCXenPrZLIQB8mhC/sZyVzIq9t/XzgNaY3/vAc+ddfMSAcKOk3OxFql7j0TDlrAzRnwa/rdLr20PMJ8urSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5f4kBQHn0vD4kPwkPus/3kAzPms1dylHwMy0uBT1PA=;
 b=jHxRIWtY+wlvx4e6X1+J2XRK093aN+HkR++CyFEllN27RJIkr9omWpWLBdBXdbbLkD6DK00UES7yigHFXlhn2bbhtTgAwfgXHXNE8azT4dK/ALLgN6zr6cicVDziHwzXiprZdU3pkGT4IbjYerBk4o4Dxc26vVb3X/GAIDPccmhnCWM9ZWaH73Ln9RbPcIjlv6L2thHODogWxuXPrqVxKSF4jvWBpA+EGUIz2Z/xFbu5znU0swmee8BpNoKZ3jNz+Qxtsf1bNDNqB4ehcPfxhD7/aAbfD9eykG2XWcTXPEeSFNCSIsNX7MTO8keiaCKodklMwngC6keI2ImL/AujmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:40:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:40:51 +0000
Date: Tue, 1 Sep 2026 22:40:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 04/13] drm/xe: Stop VM work when device I/O is blocked
Message-ID: <ape24NZ9/0tUV3ZH@gsse-cloud1.jf.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-5-arvind.yadav@intel.com>
 <apXqRXClcZThJovR@intel.com>
 <e1673532-3f31-4be2-ad35-0a998aaa9783@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1673532-3f31-4be2-ad35-0a998aaa9783@intel.com>
X-ClientProxiedBy: SJ0PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 1420dc13-5235-475b-0c5f-08df08b4bf80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k0iLYqxBxePW/ljpXm66c0bb85T62KjNIOW9qIzFjeq8Bx8Gmo5NBfXkZHG5zSi+yuJwkrCHzVGFv0sALOqngQwKUmnovDEZ1uw83JmK2yKcpuvkw1orNZDy4UJBiCPWXofYqxekJyfyIeUi7nR1NXwhqqymCm5WgfOmkWh4cC24JwOfw/eocdsouP2hXkGyST9ARjet9Tvg2tHpSlKKcN1q3Bj4ITvStd967o8O3W4oUsNkOvgyNynHk+Z77PMK0B4QYHuqUYRK12u/Ybt1Mgi0eE2SOb8l0FgGPNKG7qxeGi/kp43XHOl2/iqIzt5ZlYMi2Y7WlnpG1o8R+TXAksEkBzTPqrFrQvPQ8dwxtlvW8UvU3B4zBmvNj5Xz8mQxzqRZ/3qWfugvTKMVbZSS48VNhc2PWbzEXtPq+E0hlC51tgLBqhOwcQzrJjuNxx0yKpzbKIoBkKIxQHHJ8YA0P2R9LWtTIQXDuv5MBDMfiVaOoSrcVj84Y5so71YuKne6QUzOUkq9360O1E8SIDHdpaoiPpEjgZ5Hl5Bm00Q3CaIrznTTWqMD81L+nh6G9whOZHnTeSrECe9lAnwiAprt8ba7f7aBNBKQmgTpnIBozCHgp8iGvlxv9R1fi6OMJf+AbcmpSTG1/j1QHTAMgXeIKqH7e8EMn+FnrxiSMbI9ztg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Cl/MSXPUc90eJBB+OMn338BZTEBm0NrLxvl+MiNlGiUg/YVrs4KNtouf4E?=
 =?iso-8859-1?Q?z1SZ87Bm92auXMIGIsOle+8lOCmqauW2fDndowRGnWeMwt2MhBgrHigxiA?=
 =?iso-8859-1?Q?LVYtF3AyNqDc2FHNfOD86Pcl9UfxQhukdu0sRBEOH2iCOe3WrwyzI/9jmZ?=
 =?iso-8859-1?Q?83siLl49I8tAI52d+U6u7qWL1hddWHOJ2a12xeqWAqdkrcZgiZqq2yWd7N?=
 =?iso-8859-1?Q?gIqWyO9GlizlwXqOaJ6z07rz4KDzHi2sajRb+aSajxuDTC9vKBuOQtpFtc?=
 =?iso-8859-1?Q?oCpfEYbY76rbcJVq7KY/wOCeBF681dHvpolDXmPEXgmWcxhm/25h3nLE11?=
 =?iso-8859-1?Q?ZC/BKeIPluRDkLvcsGT1CnPsEtjAsyo4QUI0ucAxLikg0/lTbh9dtF4Exy?=
 =?iso-8859-1?Q?/08l+E8lP1myKls5OzjOKOsK6ifnKHX3vinuuSY12OfDJeipLqEaOlbGrq?=
 =?iso-8859-1?Q?d5i6h6uOrNaVAtL2U93ROd7RJYwKdfS0KaIuvCi5qqhBzdylrDGoPTvKMb?=
 =?iso-8859-1?Q?YmzSSP8FNOFqTwSiTvV28+3fT1C8yxMAWB+Gty2WrYZRqxe3/Kji6xmkex?=
 =?iso-8859-1?Q?MMx/WiwXDfrVSvYP4rPLplOKInY1Ink5+hDLOptt5BNKt7TeB1xYgN0M6S?=
 =?iso-8859-1?Q?veiZ4hsiX+PRQ2pkNNggH6nzelEy33SCCRqlciRxEEDtxzEq6/hnAVbaws?=
 =?iso-8859-1?Q?xjZlaMMWv5GdwB40Yv4cYxBJmmnawB4JtLH80cll3DDp3vhl7XlrE1ATtD?=
 =?iso-8859-1?Q?KNryAhTWYeySO3nC73zMbU5Fcv+56vJVRfDP5EUf5bUU43+mor67c8j3Qk?=
 =?iso-8859-1?Q?NsExWkbE/oqNbcxbUrvHbmGCJMy88AERKut9Wx3DZSTEmh4WoDgRiRybsP?=
 =?iso-8859-1?Q?aC9IHSxFj6g/jDuov9vcuxka8sUdYjewbKFNJb+7fRqN2p/KfUxkShpKPR?=
 =?iso-8859-1?Q?1j6wVFUU0MNQBb8sXYSBkxgiZyRRkvR2WJLQv2Ic4xAwruRHDN8zOrCbX8?=
 =?iso-8859-1?Q?uyzOiYkFukUpM4lvzn6hjYjccCXCsdboOxUmEcWuF1pKGHUM0uCz5S7F65?=
 =?iso-8859-1?Q?mMpkG0bW9D65Bbez4zU2PiIkdOWyVjxj0agJ5y9oNzF0ik3zeXf4l3vnP/?=
 =?iso-8859-1?Q?wr0RtZfZFhmIIyx+Wu8rRkvVVaSzx4DRLOyUm2DoDPrSrc/659xN8GxERg?=
 =?iso-8859-1?Q?ekP2ZECMy9JYNac8Tg9lK3X4MBH/PvX71iqUPMwOgulGckDCUItfhoUUaX?=
 =?iso-8859-1?Q?v7bRym5RlAOKItncHSr+hGmJMN4QAq4t7Sn61FiJdeI/YyMWS8R9JgliY7?=
 =?iso-8859-1?Q?45DB0gVWXsFbFX2TzW+WFHrsVB+vIbt61GjSOQ3DPhBBJtSQTOp0TQC5hL?=
 =?iso-8859-1?Q?0Ki2tj9YjIKwoM5D+ShV8LY12OSqRU5RfHGOPqxAWS+qiJ4tI74RaPDxOz?=
 =?iso-8859-1?Q?kTWPrDrYdXL8itKhIs3ajt5K5dxMckCMxmSVAE4cyMtCTwEB3AHv/tWFz4?=
 =?iso-8859-1?Q?n4ENr4Zcv014C3jEHs8aEhKnWhWFKjd5h2mxMEFTfziN759owR+gNDdrw+?=
 =?iso-8859-1?Q?UPc/qosl2OO6R885DIWhLMKPZIcF14Ku5Cyx1nrc1BcTOD+H5TspesRODi?=
 =?iso-8859-1?Q?APXi7DHL3gWX7Ek+dg1aF2wXBTA+dkUXguIpWoQCFrcPJU9AaOeh/1rW+d?=
 =?iso-8859-1?Q?nU7MLH4CYiC7wbEz4QML4eXDThH0bkjkwAMbQxClvMZTDbAv8b8LNct+YN?=
 =?iso-8859-1?Q?dszhyVNYc35hc+qWSo7WR4d+dBLr5oyWN93tb3JsicO44a6owqX/N8iKkr?=
 =?iso-8859-1?Q?kZg1rnCDF7h2v12dRwUqTrlTH0a22nw=3D?=
X-Exchange-RoutingPolicyChecked: 1Ga7QFtyl6gSO1cGbomSAJhjleigc02TjHnpk6EtEoK36AGiofu6FE3z/TLujAlKrF5+uXpgqAUy/BZqk7MfwNapb57po/6cfoYGSVn67+sCVMsDk3bTeFWjTxFVttxKAuDYFOgs4xnO/ZlZOqi73Duhw2BEP5iFNCzSAkXwrbrN/c9+4LCYbAKMynnlmoLmbuXVnIxw0alHcVG5Z7zOhaV5syJeTZ0U+bt7A4kqUR/dvfN8vAo3xb19gl5sNgdGVHNXfX+pnDNL2rZLu6KUWKnJQadJfy2cFoK0Ol8ltXt/FSsbSS6Xs9Nf89n34km8uU4Q7b7l3XO+uPYhO1KB/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1420dc13-5235-475b-0c5f-08df08b4bf80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:40:51.1643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fsxvOkfZR/8I6crhEqyv0gtYUWgi8DIrlgj6zEwCldH3/mW6aZ0qvqTzxGBA7hviJd54eNUXanXbRLfVIpjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
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

On Tue, Sep 01, 2026 at 02:41:44PM +0530, Yadav, Arvind wrote:
> 
> On 01-09-2026 02:25, Rodrigo Vivi wrote:
> > On Thu, Aug 27, 2026 at 03:47:52PM +0530, Arvind Yadav wrote:
> > > SVM fault handling and VM rebind work may still run when PCI error
> > > recovery starts or the device becomes permanently wedged. This work can
> > > validate BOs, update page tables or submit migration work after device
> > > I/O has been blocked.
> > > 
> > > Stop SVM fault handling, pagemap population, device-memory copies and
> > > preempt rebind work when device I/O is blocked.
> > > 
> > > SVM invalidation still performs its software cleanup. Do not warn when
> > > TLB invalidation returns -ECANCELED because hardware access is blocked.
> > > 
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_svm.c | 21 ++++++++++++++++++++-
> > >   drivers/gpu/drm/xe/xe_vm.c  | 16 ++++++++++++++++
> > >   2 files changed, 36 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > > index 627a741293d5..9e78131bfa39 100644
> > > --- a/drivers/gpu/drm/xe/xe_svm.c
> > > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > > @@ -11,6 +11,7 @@
> > >   #include <drm/drm_pagemap_util.h>
> > >   #include "xe_bo.h"
> > > +#include "xe_device.h"
> > >   #include "xe_exec_queue_types.h"
> > >   #include "xe_gt_stats.h"
> > >   #include "xe_migrate.h"
> > > @@ -288,8 +289,11 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
> > >   	err = xe_tlb_inval_range_tilemask_submit(xe, vm->usm.asid, adj_start, adj_end,
> > >   						 tile_mask, &batch);
> > > -	if (!WARN_ON_ONCE(err))
> > > +	if (!err)
> > >   		xe_tlb_inval_batch_wait(&batch);
> > > +	else if (!(err == -ECANCELED &&
> > > +		   xe_device_io_blocked(xe)))
> > > +		WARN_ON_ONCE(err);
> > if (!err)
> >          xe_tlb_inval_batch_wait(&batch);
> > else
> >          WARN_ON_ONCE(err != -ECANCELED ||
> >                       !xe_device_io_blocked(xe));
> 
> 
> Noted.
> 
> Thanks,
> Arvind
> 
> > 
> > >   range_notifier_event_end:
> > >   	r = first;
> > > @@ -631,6 +635,11 @@ static int xe_svm_copy(struct page **pages,
> > >   		}
> > >   		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
> > > +		if (vr && xe_device_io_blocked(xe)) {
> > > +			err = -ECANCELED;
> > > +			goto err_out;
> > > +		}
> > > +

Again a toctou given this state can immediately change.

Unless I'm missing something - my answer is basically no, likely for the
entire series unless this is a non-toctou check as otherwise we just have a
bunch of weakly ordered checks throughout the driver which don't
actually protect anything.

Matt

> > >   		/*
> > >   		 * CPU page and device page valid, capture physical address on
> > >   		 * first device page, check if physical contiguous on subsequent
> > > @@ -1125,6 +1134,11 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
> > >   	if (!drm_dev_enter(&xe->drm, &idx))
> > >   		return -ENODEV;
> > > +	if (xe_device_io_blocked(xe)) {
> > > +		err = -ECANCELED;
> > > +		goto out_drm;
> > > +	}
> > > +
> > >   	xe_pm_runtime_get(xe);
> > >   	xe_validation_guard(&vctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
> > > @@ -1165,6 +1179,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
> > >   		xe_bo_put(bo);
> > >   	}
> > >   	xe_pm_runtime_put(xe);
> > > +
> > > +out_drm:
> > >   	drm_dev_exit(idx);
> > >   	return err;
> > > @@ -1301,6 +1317,9 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> > >   		drm_gpusvm_range_put(&range->base);
> > >   	}
> > > +	if (xe_device_io_blocked(vm->xe))
> > > +		return -ECANCELED;
> > > +
> > >   	/* Always process UNMAPs first so view SVM ranges is current */
> > >   	err = xe_svm_garbage_collector(vm);
> > >   	if (err)
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index 19b3d0be7928..0cee5306fb9c 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -497,6 +497,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
> > >   	}
> > >   retry:
> > > +	if (xe_device_io_blocked(vm->xe)) {
> > > +		err = 0;
> > > +		goto out_unlock_outer;
> > > +	}
> > > +
> > >   	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_rebind_worker(vm)) {
> > >   		up_write(&vm->lock);
> > >   		/* We don't actually block but don't make progress. */
> > > @@ -518,6 +523,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
> > >   	drm_exec_until_all_locked(&exec) {
> > >   		bool done = false;
> > > +		if (xe_device_io_blocked(vm->xe)) {
> > > +			xe_validation_ctx_fini(&ctx);
> > > +			err = 0;
> > > +			goto out_unlock_outer;
> > > +		}
> > > +
> > >   		err = xe_preempt_work_begin(&exec, vm, &done);
> > >   		drm_exec_retry_on_contention(&exec);
> > >   		xe_validation_retry_on_oom(&ctx, &err);
> > > @@ -531,6 +542,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
> > >   	if (err)
> > >   		goto out_unlock;
> > > +	if (xe_device_io_blocked(vm->xe)) {
> > > +		err = 0;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > >   	xe_vm_set_validation_exec(vm, &exec);
> > >   	err = xe_vm_rebind(vm, true);
> > >   	xe_vm_set_validation_exec(vm, NULL);
> > > -- 
> > > 2.43.0
> > > 
