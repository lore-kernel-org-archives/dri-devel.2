Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF2CA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCD810E3BF;
	Thu,  1 Oct 2026 17:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LedGNxFG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C83710E3BA;
 Thu,  1 Oct 2026 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790875875; x=1822411875;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sJjmn8IA45CXX0GZ6CuC8g+NwQQDHjBFo3nZZvpjQLo=;
 b=LedGNxFGNhPRM4zzpvAUcvus34jzJskXIjauVcpGTeAP9Y2QUyziHyIH
 hFF0heNfv1Lj2CljW+y1HLV0awtmrJS8BYUdklK7C06qNnvsHQbTzhLcx
 I3GfWjGjahtjb/JPfbFtmP0AACpsFTZoOFoAe7T/Uc7ebcbNMl8PI/4Ue
 gPGAAls9qggxe3UFhyYko89yALNx2fwT3pfpAmB4hqyTdKCEwUWh994ZC
 ujudLvjj2Vl62hKbeq5s3kZM24KvSH5KxuLVquU2WiYUrzPJn1UwF3d9R
 JDmYZDKRTIC+NmQ/qTj3YLOBn0nKeVMDSjwXuWP+mrfA71a0j66T5rb5i g==;
X-CSE-ConnectionGUID: S3Xf/gseQDibF99n3bR4/A==
X-CSE-MsgGUID: W2AlTsX4Qx60sY2+QqUE6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="103018757"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="103018757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 10:31:14 -0700
X-CSE-ConnectionGUID: wcHrZOQLTCqbb8Tz/+Uiwg==
X-CSE-MsgGUID: XZdVs6ThTVOyx4IpC9VEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="276155861"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 10:31:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:31:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 10:31:12 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5h97MHFZO871AAt+d9CKuu4ieoxm/28bEKaV8/Q7c/Z+LPCQha4ChZZB9Aqz/HN71t1tsnCyVI2Sgb/AIjDtBQfg0vLQxlCpV+uDb5ZiPj36wBzgiZNbrwJmhj8RqsQgsyqaYJLFGrC8x0xC3klmi/nOJhImjaoJ8scDUirMIvURNP26nOuEkPxjl43YDg96cw55oPfhQnfOCVrHb5pejf3T5ZYrHE8GDSCZaD/4rT3qaWEvK0BTgmez9aOX2Hm8Zw77T6KHlP0z6I3WToUeOT+onC+avS/2kroCZk1cLV+vXt/XcFd0fxgNQc1QIGV579eBcPvJ6XZbtb/MnbNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQtA++fgeHdkMj/MA45zBtOd86ZXVA4jlFMBk8D3n/g=;
 b=HTKDT0ml8fZvJdQ2XPlSCffcbXumu7pjD6UA0H3SVmNLhpnnZysvJE0ateZgdQbbfivxf1cJK2Sb8AFUf23KRS2kLDwoV1B7qsRtC+sIkPZPC0HEhc0nD0sWr5GVV8J0MiOnZLO2rKgSj5cDvX0zB6DqL6LfHphNZdVYWzyNLU+mM6u+iqbrpdxAr8l2Z3v6DGp65KlQiGGxCZhzNtAN8zBjqKeMkxIqnKEDVgNjkwqKEFkeGBlhP4c2ga4AG5M7r9T+txZxHY4bYisLpHm8qvFRXakVxnpuP/ORK5MNAiCFnTIYHDX8cNR7I+CI+nczfmbnxrY/PjtObxXYsFW6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Thu, 1 Oct
 2026 17:31:07 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 17:31:07 +0000
Date: Thu, 1 Oct 2026 10:31:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, David Airlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 0/5] drm/gpuvm: two pass locking for exec
Message-ID: <ar6Y1+fH0/w427ip@gsse-cloud1.jf.intel.com>
References: <20261001162001.3123877-1-matthew.brost@intel.com>
 <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
 <ar6VjOgZYGeTsc+M@gsse-cloud1.jf.intel.com>
 <DLTOCUDLX5ZR.2DUZPGUB9CAE2@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DLTOCUDLX5ZR.2DUZPGUB9CAE2@kernel.org>
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0e2567-c0b8-4b30-7bb8-08df1fe1c69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|7416014|366016|10067099003|18002099003|11063799006|4143699003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: m13AAizknI92YRJQfcgMpptkpsW0RQxxHSuiUc/VJ5+bSKa0yQo3ghthETqQ+LEFLrRjI0AYYTZahuuDXq/eTYeXMGViCGzxPBL0pfY86fMIjE5B8+HFej/tQDWoKHHWToIJK1sTEXG7Lb+ZcbYT0fnVVtOCu4KCeVhqvl1ZAKUjQKrNPV3eNPfKcfyLzqFwy/GZgycC8fDTcyfBZrYcQutX1Ko99n/LHeoP6qmMlPziMJq+CY9Y1oQNl4b4tqSZIb6kSOXbrOzrFhQ2k9NpxFrJ1XZZbVu28SRtnNuwvBe6U8lwfc5+R9yhfMocqfbiUvz74OB89Hs+wNrH9UIg3wXLohO63y+DyPLn7/xTe8eBVyZfxd/fdBDm427NKe87/EqcmyzWdcwHBRZ3Hbr3wkO98tBk6iQFm+oyGR5YMfPBaTbpXyUYpVFUuRBy0NKEl7JcCiHSNQ2WBkIt/DhNAENwp470J731dVI3Jz+rgg/GMufmS6qDNSz4+AV1BdiPZKq9qlg5xCtjesqVSNXPIKfxW9tUuocKDu+fnP6xE1Syqx07qZQwu55zg7khmHpHTCgDk9B+WESRYPVSSXmeI0TVwPqVTXPROKmKrILqz5qfsuL85vnWFgyAHspxd0zKS+seEuWEW6IViipzR5q9yjKClqrrHbMtW0XCLqI4yh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDqK5t3POp+n7a2bkA7xX+DAoWGNt4Mx4p7xC33e6uvwdQp/dcPNmX7b/T3v?=
 =?us-ascii?Q?uOPzEGc4kwkd3zuKTz3KnXBDzn9QOGUHY24L8i2GcG8nC4A27tz35PE/Ldod?=
 =?us-ascii?Q?SykAfqqXnytYTF0X6AufYzrvOCWOIT7UZOAz5FlxvtIlNvSiSzEUn8HKUfzE?=
 =?us-ascii?Q?wfVgMdxTuaVUkZ3GRbxyuzhWuE/CIYRYuRiA2qlT+iTXV2TTDkIYrtV+d+5b?=
 =?us-ascii?Q?kir5in9YzJO/5fp3gGLrclrSckWRQ0sY0I8hqWKgWO1zelxDhmd/tA4BB5Zb?=
 =?us-ascii?Q?wKr6JSYprxdRivFTp3Rv9jLUn7vMjrQAk/r97Ecen6hySkZMJzjK3RcgZm2d?=
 =?us-ascii?Q?ikIZwFRy+0aTvxAkK+zn/Wx62UEtWMaX1J6TKNDjw2S4WTJeK0frTy4kOska?=
 =?us-ascii?Q?4Irv7aWl5eN/qSHSCp+2eExIcl3jUyiFe/b0NJIExWoZ+3ozGXexAVGG6mWs?=
 =?us-ascii?Q?eQPibJuatyhc8loB85bw3jVkhad+ix6uytK2k/esFwswMdcLyXOSc8aOwi3A?=
 =?us-ascii?Q?AzPEZqOYeELiYhX+OSqGCLXki8DvjeAe2aTHZw4CG27DDsBhFCCpxMExornI?=
 =?us-ascii?Q?5gDjtaoc1pcorGOFNfwKYVnrTyzQm84tEcOKQBOw0peR2mJsAfYOaVEC5v57?=
 =?us-ascii?Q?rs80Y5xyQMTk5Mmjgf45YAwOtabIU0bWzIVcAVHqYrWVPNQ+zq2QeciAKYYO?=
 =?us-ascii?Q?ODzqgAEylo568zzPPyP/qb/mQ3/InLL1lNn0Yr1ylUOwQ5MOKLruRBDvNj3P?=
 =?us-ascii?Q?1BXIQIlWrTskXH1TzHu4rcklPm3HN4o1YBEFhCMIn6HMArU7hej2BU+boXF4?=
 =?us-ascii?Q?9TnJKcQK8vHjsiuXwCn8T7aGOVv1JyhkifXCgCyb0rkcOFm1Qjmxd4WpMQTX?=
 =?us-ascii?Q?djX2U/L+cZVezUuxhxaRAZzNgtzL6bKYmGQ4qXfSeLPr4pRqGge8Uarn8Y4p?=
 =?us-ascii?Q?33ZX7cz0NOEqIFvprH0TLvMJD0PdjovnuB/P6u9UjZFPxwebcs3EecmT+c/o?=
 =?us-ascii?Q?eiB/6yXqcOpYmfgHZh4XPUbZfI0jsvDZtppm8eW5Juk82hw8vuqC0z6hAcYf?=
 =?us-ascii?Q?3XiTKbE9pFVCecFrr17hHsRBfLyAinKG53WzwqpsM24zTivdbKAB1dQIu+N7?=
 =?us-ascii?Q?Pf1gqAbRcM38xPccdpU1d2+NUrngNkDJmPzaRHQI/D9NdvloMe9IoyB4a7TY?=
 =?us-ascii?Q?RwhldWTqGfepzav3Dti7CqWJ/AYAb99aWY+fUuuzMgyRjmOZ7MqyQiH7SF3N?=
 =?us-ascii?Q?3ohuVRD9apllpxer6MTiqGDLu+SHxiKKr0WaxTU5i1Day3ZnPAzWbnGTUp5O?=
 =?us-ascii?Q?uwM6TBnZ2GLOsM7aGQNwubah344Oq6nYoOEKx2Cnf4a9Et/OCInwRUvmUSJV?=
 =?us-ascii?Q?b/YTvc0G5d/dAWQ3WUXIIUSACVYCM1gYRCMCJwDom7oCErArNDTLXCloMpyn?=
 =?us-ascii?Q?8/srlrwxKfwnE7a2EY1IyrZvYEqhzmVKiNOzSMi7DiAzVqcHfiBBuc3QUUN7?=
 =?us-ascii?Q?snXnxtg5sRvZxCwz4ay8oY89x/JaBBWmpB0OqfDhGDZT2gNf+kJcWg5YqvG8?=
 =?us-ascii?Q?2d0SSmlAMOZJH2NggZ0Gs3kvxMRJAXKurNJ6JUbFlMjojhSAoW+xagYVLtLK?=
 =?us-ascii?Q?4Xm++KDDRlBow6MSW2MsXNkbn2UzHCAh3ZVFS3wQ4SW7CWWJW05BB9uMgMYP?=
 =?us-ascii?Q?pEWZ/daB4gMQgqT+47/69MVvT/f36Z6EILzSVetBI0Gxg9NlJUK5EU6ewAS/?=
 =?us-ascii?Q?VagmhFmm0Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: YNtfizdKNNSm71J8Y8uTRgEOFrZ9JxDm65kU4N7JJBI51Q5ODK6+ha6FEVm9CblbEMt2JjuGuYAVyIOLE8QbU2z/jsYBatrgdR0F+u2HQsGJI+H2b0m6uUBdjjvEZxf9S6r/MVjYbPis/QQs0U+UWW9/Dyq+Lfy2Ob0vnhZbC1AkjrP1yfrCluHe8c0z6lGwMAYJUz0emnWWwChqvhwEaOj4viOIrg+yJn1RREHCaGfzy6aoD+iJA8im+c/94fgR0A8XD2oZh4Ybu+Bj1PtYF25URHLOT+0vH8KeycDYu82p6ZN+QkAy3sOIKtKbBsyPBIaT6yUZ5mn9Grzyo3gSqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0e2567-c0b8-4b30-7bb8-08df1fe1c69b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:31:07.1221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j/sAfHcBJ2QlYtn6kAlpbdMY113RDNkfI3/bMQbHBWJ5YYGeWjJySzqxXomiZa8qWXSNRlFHO8qhBe0NRV/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
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

On Thu, Oct 01, 2026 at 07:23:49PM +0200, Danilo Krummrich wrote:
> On Thu Oct 1, 2026 at 7:17 PM CEST, Matthew Brost wrote:
> > On Thu, Oct 01, 2026 at 06:43:13PM +0200, Danilo Krummrich wrote:
> >> On Thu Oct 1, 2026 at 6:19 PM CEST, Matthew Brost wrote:
> >> >   drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
> >> 
> >> That's great! But the title suggests there are other VMs without this?
> >> 
> >
> > What exactly are you asking?
> 
> In my feedback from v1 I mentioned that having the feature for
> DRM_GPUVM_RESV_PROTECTED only is unfortunate and that I think that we could get
> rid of !DRM_GPUVM_RESV_PROTECTED entirely.
> 

Ah, okay, I clearly missed that. I use Patchwork to scan for feedback
because my inbox is a zoo, and for some reason this didn't show up in
Xe's Patchwork instance.

I see that you sent me a link, so let me take a look and reply. It was
obviously never my intent to ignore feedback.

> MSM and nouveau are the only users of !DRM_GPUVM_RESV_PROTECTED, and I mentioned
> in v1 that I'm happy to have a look at this after LPC. I.e. scanning the patch
> titles of v2 only, this looked like it was referring to this.

I'll be LPC too, so perhaps if we need to bottom out on anything there
we can discuss. Merging isn't pressing, as this won't make 7.4 window
anyways.

Matt
