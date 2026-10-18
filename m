Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C4CCF2C7
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 01:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B6A10E4C4;
	Sun, 18 Oct 2026 01:32:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EC410E4C4;
 Sun, 18 Oct 2026 01:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792287159; x=1823823159;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uW7+ZVl/t7f7SEFuHDInOgPExoJUrH2XfvTf9l8OPkM=;
 b=KLWpxhyhgv8mIVKNA+mIWkYIQ6G89+/TPI01RrMWfGE+F4oOMXpRk5Bb
 zkzsDB85ORMWJO/Ea2w2nV2UXnCaP9db9aKDZSOuyQs+WAiiPxjXWkkJ9
 4VeyAGc9cNArUM8kKQPFKO0aDIGRs+L7tmd3P6FCixChX3fMiARoho4f9
 8UmPoQwtmASJPiln/zgZaRy32pH+1ug9so1wjh8jMQMsOiIQ38RmyVZCq
 VHonSTQ8vpFlV6JljqECIER8iMmi2eQ6rqocw13oGKEO1ZG8wNM8ms6fq
 vNvL995F35bvthwNdiFbvW4WouOrjsosBqVIi3eXKPdHfBo1eaMaZhcZt w==;
X-CSE-ConnectionGUID: xjV+qyTeRtCyPXLeILKWiA==
X-CSE-MsgGUID: ilZSSTqMS56PRtNnAN1Fkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1003323"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1003323"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 18:32:38 -0700
X-CSE-ConnectionGUID: ak8aqfA5TzOHvwluPTxyrQ==
X-CSE-MsgGUID: 1uir0pfeT/qav9ptYBY65g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2513540"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 18:32:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 18:32:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 18:32:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 18:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvcfiGoyGiPunem6Q5rR53mWcAgsH+/Fp7uBjdfabzulsR3kJ421q2IA1KpoM01oiIEeVpTkhNYZ1f60JSAlLrwuVVP1ed0Nqu3ExAGDBQdbrwBu6W+b9fMsLFj+PQGZmjB+l8pzkadm/zKlZulAIukCP2kcedXB4PYZ4yRDXto5S0pmW/AadyAs3z8Jcug+IAcTQ8xaqlLXUDE0yn3EBr022yIP/P/UL7aZi6azFL6ZDl0AZgS8mS+nsu5JlNYC/82mcK8riyJwFPI3cOaYnv1UwF+mZ3UFOpSYsZS314I0eBwn21NexkUmOvohhPV22QA/36+dMMAvq0pfWO8akA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS7h40uU1SabQz7u55dahlfVQnS0AgXz0r1SQF1tido=;
 b=ghl5ScJsjnNXHeQFMOKWdIzpe8wl195qbmIJAqhxINEYlhJu1QZDDJvXPdAtKtbHivx2pF0POEP+mptk2pgghmbcPt5KL/X/EqHZzIcoswpXdI8CmCQvLa38Lo4kcpCa/fO3rwq+WPTafTF1epbmOcDJqoOLdI37HKqz0LIULgTTyBK/v582fM7sDgP1Oi1CxWZ2MTUFeibx+UqSuwPT0+DkcVwZUerrKtvc5VRxfhrml+iGsAzbSKix5ykdhzHAFhRyIMAGL76Xv/LuhrBH0OookJ8GE1RB6Hq9urXvR2mq51CG5K3LlpJ4O91WRWSPLYiroOlUL7Rtx+gur72MfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sun, 18 Oct
 2026 01:32:34 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 01:32:33 +0000
Date: Sat, 17 Oct 2026 18:32:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Antonino Maniscalco
 <antomani103@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Message-ID: <atQhrkC+F5xgn4A5@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <DM7FMW8WTN5C.FSW38EU72RAI@kernel.org>
 <atQaohqqhgHArD/M@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atQaohqqhgHArD/M@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|DM4PR11MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaa299c-c6a9-4fb7-6976-08df2cb7aeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|18002099003|10067099003|22082099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9Cy5xSNCydBcdgkg8hm4LYMLz8jfIcE+okm3b5NoEihVWeIJqwUovLlb92MbTuPKHD3kxcw4fwsHcHAsOJlmsi5QRSUjh5Jy9tKJbWXDHiLVxEXPeSzr8vNGWjmmJ6wzYRWUh2Fkc8NTahkmIbn/nMtL/o6smxUgPBXEKV2bZs7/PIITPeypAEiC1896fhmrvizNFECWR6N3j7GhyzDRvHXyaxOZDXQ5mv+II/M7ADs1VZtu99N+SxbsX33r4eJuy436Sw5PVGk3faeXhKyS8w/zHCXQ6BHIs8A7kyp4SQzbP/6Ej5w4SnKpPnk2VP8a7Q3hY33q0dJ/V0NJz0h+jRWPnOUP58Yyc3p0BtUlTL+a0U6JE64kq+2e+QheJmhgftOqIdOnjiPEdS7vAyEFjx84itqi3IL/r0PJSKX85Y2vNwCafRdes74l8cnmWpSRD+QJws5W2Ap8C9ms/XVXjY64/SpKjJNp5ypkQh5O7Q3/KrRsJ9Nsd5eumDFuujEF2971BSnIxvYnDSLzIm3/URq0lxP2ekFrqwJGWbTEEth941t0g4X3qwGF3mnlILuZYUmwTXcHckaOvxehzZE6sPwW6CpiBC9GXwqlWZGCE3wfuxsvVqje4cT7XlRdQAfn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8RygJDnC25D/Dub2rSbV1Q/iIP7mjfFkY6mDSENgBdr30guMLIjKhlqgLgpe?=
 =?us-ascii?Q?fKv8SHLZSG3OcARuGtDJ96qW479qcpEUo29SZ1Sm1fNK76TxcZUhtr493XFZ?=
 =?us-ascii?Q?tQhvNkZHV3/6VVPORavJzutuYLVOZ5jVYI7zq9UbyrCpLwX666o3ceToFNbY?=
 =?us-ascii?Q?WOdrNGxkTE45gnxMOM9IyQoYaMKgiABZJEu/2JOIEPoaMoObZHokuXuLlxcN?=
 =?us-ascii?Q?UMbeoG9X1RH8Og0XLQ3VV6inoPjPmC3Nrp0ZmZGAGcl+cdMhXjQOYQ0zC30n?=
 =?us-ascii?Q?JRvIbdIdjh6A/lHVJvAfB23GBzVJkJ71j6PBAj4Bj++Wp3gDCn3d/UV3hR2X?=
 =?us-ascii?Q?LqKKeTm/ASH9jmq0Wk/SxwXFFELgIBZLNO1BK7Y/xK9o2PxaMhmEA7mD3CIK?=
 =?us-ascii?Q?460ZH2VnVRRxyWFyz77BU0Y/LwuQa5JjPdV4BtRDz1sBIvVAKQDAx8pEqNln?=
 =?us-ascii?Q?GRRUqFubsY2NH04SS3JW7/nYYx9XQEbc113PuBIyHvHFwr85l02ktgczf9aK?=
 =?us-ascii?Q?QqaZikRw7j/l3D2biDhYZsvOY7sPC59FKYDtdK65g0BYyAxK3DoJML7V2xSo?=
 =?us-ascii?Q?/2EKsItrEoMnWLpqf5Vd5lRkHD1R6ZimD+3HZmUisKmMdOemQBYC46ZGayIB?=
 =?us-ascii?Q?SuEBSKUDZ6H9b4xR7cTSlx1nWViSXUgXQo6mwIkmCa7Z5cYPG5OM4RIjjVU4?=
 =?us-ascii?Q?pYvrEeVN6HfSkdJp3UGTfP08i7DOeU+pcx1qwlCESUgj6dNsrf29uyFQ388/?=
 =?us-ascii?Q?AL1eVx2/ILgxT6nDGAXmFvn+6lahr9e1bymc9LxrlodWaJ0azr9ZDy7p1yRV?=
 =?us-ascii?Q?sf+KPnal6+zleZFyHXfcx2kv/71pW1BsAAfdklS5pITAtlr8RSUNe4nCa5pU?=
 =?us-ascii?Q?/TM26nDEzL1ltMZIbTelSIdqt/EWabBMR1eGIFJiza1S5LM84TJ583NW+LBw?=
 =?us-ascii?Q?Ab7HdqrPEoiaiMxwB55DPqJkjk/3J3igd6wbKdq3bicTUJ6NgO7WrHAm1e6F?=
 =?us-ascii?Q?KHqXuUaUOtZZbMLUhINiyW6icaorCz+tzoZesJuXNCMRr661l+QOsP2pNdRd?=
 =?us-ascii?Q?tRBhmikyuizl9X6WK2AGah7Xv8sAhF2T25lrf5AEF5t7eM5VviiKygx/yQMK?=
 =?us-ascii?Q?JQbE/O6vReVG0Mg8JTB+Egl3FYLS+aWLUJXiQvGlVqo/W82trzt4Lg9wM0AP?=
 =?us-ascii?Q?esrRTooFmvnL0FNZil7/0JoUsp9BAjyyO+n1XbojX7mHQuRYZvf2H5K9+t4T?=
 =?us-ascii?Q?k+ZphGKNWkZ1kWiXjSigBvSAS6kEq+ILF+mjBY41BIUAzIeA/cIyRWiYOAyB?=
 =?us-ascii?Q?dM3FMCfNvhx7I6w2wlt/kcW0aHhuvwqbfyi0624OzluVicGFCjf6/F4UdMpU?=
 =?us-ascii?Q?q4G+vcE0muhk/WRFOCZ9Vw9oRmfe7G7M2cl3BmU1Nm2HHU2oXJfO/d/l5Wr+?=
 =?us-ascii?Q?9pqOAr3mYzVv+v70fQkfvj/pyPIiNwXyw1SJw0T7AaTgMENAjAHXFMxPKJX+?=
 =?us-ascii?Q?Eaf7ZvTemLGTn3onTX25lpjDNIk6EwHZCIlq3RwE+767dwgKd7YY3edevYA8?=
 =?us-ascii?Q?LMNTEEZ7DF6sBWZZo71De8vg0W7iw+IwLZSVXN6jr+tJQsxfI/YHWPHx5Rrb?=
 =?us-ascii?Q?jwd+bijmBfJTHQBjSYdsLnhmpoy28hH+WlCZmwJNriAx2vnxYhUaASGmjOPP?=
 =?us-ascii?Q?fGZ0biR9D/9nk4NQnSLHdbH7X3EV+aP5VVFlqD6iB5AiAGCVZjb16h9x60o8?=
 =?us-ascii?Q?2kHaXnqQPg=3D=3D?=
X-Exchange-RoutingPolicyChecked: d4IRRR4rmxbARlKsmW1jf38T5lSwE9cVAm/ta7BFaSXk0ELmTZF48z2ePoN46VigqtZesBGYVzDc0UQnGivbydBjM2p/m3xvOefA8k0sRKGlaBlAVZhuI8zSNuQWWyL8wdvKjTrK86KwDvsDgun22D0evjMGi9K6K40iPb4AJHMuUTD2v1kKEKh/eQgPE7GH0aEpoD6wtk2Hql2HfDQj+XLJhRTwrrCYXmN4MgdDlTFek3rArOixQJwdwqeK9p+SgNP8zmzvx0xFxnCK/YzP/3TAm3cfsst16KoLBVsuGKBGYsenu4eNo1uGIY0QEUmTtrRSTzB8I+oCjb2NkNQxEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaa299c-c6a9-4fb7-6976-08df2cb7aeda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 01:32:33.5588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojCzw9aqzTJgVI08EQmVSFPvDLHcyo7wF1IislCYPfXI0gdHnW4LGF17QogJrQA49HtMxCw8tzz3Qwe4SsIibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
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

On Sat, Oct 17, 2026 at 06:02:26PM -0700, Matthew Brost wrote:
> On Sat, Oct 17, 2026 at 11:31:06PM +0200, Danilo Krummrich wrote:
> > On Fri Oct 2, 2026 at 12:06 AM CEST, Matthew Brost wrote:
> > > @@ -1187,6 +1187,27 @@ bind_validate_region(struct nouveau_job *job)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * Lock the VM's common dma-resv together with the one of @obj, as needed to
> > > + * drop what may be the last reference of a &drm_gpuvm_bo.
> > > + */
> > > +static void
> > > +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_exec *exec,
> > > +			     struct drm_gem_object *obj)
> > > +{
> > > +	int ret;
> > > +
> > > +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> > > +	drm_exec_until_all_locked(exec) {
> > > +		ret = drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
> > > +		if (!ret)
> > > +			ret = drm_exec_lock_obj(exec, obj);
> > 
> > What happens if we reach this with ENOMEM? In such a case we may return without
> 
> Right, valid issue. Sashiko flagged this too.
> 
> Originally, I thought we would need to open-code the WW transaction, but
> instead I ended up fixing drm_exec [1].
> 
> So I think we should merge [1] and run the MSM and Nouveau work in a
> no-failure mode.
> 
> One thing I'd add is an assert(!ret) if Nouveau has support for that
> (see xe_assert.h for what we do in Xe so our CI can catch things we
> believe are impossible). I suppose the open-coded version would be a
> WARN_ON() or WARN_ON_ONCE().
> 
> Also likey a BUILD_BUG_ON(2 <= DRM_EXEC_INLINE_OBJECTS).
> 

Ugh, logic inversion.

Rather:

BUILD_BUG_ON(2 > DRM_EXEC_INLINE_OBJECTS)

Matt

> Let me know if you want me to respin with these changes.
> 
> Matt 
> 
> [1] https://patchwork.freedesktop.org/series/175390/
> 
> > any locks being held and nouveau would just continue calling into function that
> > expect locks to be held and hence produced UB, right?
> > 
> > (I think there is a similar case in MSM, but it was pre-existing, so I picked all
> > other patches.)
> > 
> > > +		drm_exec_retry_on_contention(exec);
> > > +		if (drm_WARN_ON(uvmm->base.drm, ret))
> > > +			break;
> > > +	}
> > > +}
