Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B720C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 20:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31D410FC70;
	Fri, 25 Sep 2026 20:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lGrPRzNi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B12810FC3B;
 Fri, 25 Sep 2026 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790367501; x=1821903501;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8nYsMNBj4L3ReABaog33NYzqWk3JFS/Z/36I8Qc2fsE=;
 b=lGrPRzNiKWxRIeDAQdbm5JRH43GncP7KeFp5VzAoIkBxEN79i1QmkzbX
 KhSGpPMX/uI4k4PWE+KkL40EGogGPjk0GL6+Rfxx9/rjIDP0OBISpcSxb
 Noaw15X+51KZ+Eo6DWF6+ztIDmhbVovVC7ynfXMmgksKIF29eB8bA1BBR
 mw3ZLV9ja63ocJuTfzKPd1QaiXgr2s22LH6KBw8cTa14YYop/RfOawufp
 47ux0OOomooUkP9VFvpAHGrFxedXFXHWNWfrQyOVVsdt3gr2cW+7HA+of
 n2vtNXyEOKxYaSlNlWMkTjBA/HbxzRJEw8aHO/sB/dndasxwEwSCUXbC2 Q==;
X-CSE-ConnectionGUID: lojvzow/RsOD3UrQ1r3tGg==
X-CSE-MsgGUID: dFnuRwyCRDqXzc2bFn2zfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="91180818"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="91180818"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 13:18:20 -0700
X-CSE-ConnectionGUID: 7E6ASCgKQ+m3LAw83IfJgg==
X-CSE-MsgGUID: cWxAMHJBSjuqkdm875GN5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="277612602"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 13:18:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 13:18:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 13:18:19 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 13:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epUy8OKg/m93+/GkIwfRozQYU9WivVxGge3+LhPaK2mriq4cX9GNbCS3o0jSH+8yNAcNeTUM3hbs2OCJgJy+B5wBSw62xJfmjk35oYejFGX+gFp3goto6Iq/g2rm1cDTboOTyZs13nanx8qT811jS9HiwWv+jpO7Y+qjEQJQSklcyW/in9L7XwdVW0Z1pexQOka2pVN4doTQe0DSmDLvYgQKi3Umgh/MAWnKWeo1/98GvNnlolIhL8OgU6XagJOYny0wFCzvFceeoY3Pnm0n4I6Li8S+vJQjFwJ4TJM282bB42V0ClNBKpXPlxnL26nbp+jxjJUQNb5zeUcoA4UVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maZsWI5ydvsOu63HJfTMGo8QwnruevchgHezJ6ic/Lg=;
 b=i4iKqzfMaaf5oGzZrdbcgCgvLkFGoHjqZy6eROgf2FW8q2m15lnNOc5Io6yIZKpIiYl8E4LAiczWWP6rakCtnhfCSYWHb9hZHxvDekzqkS9064eRcTi4L2OgcnA1zrWHfdtf5GWqMAtVxivX5JsZ9S4XFCxCiWU3SLyEk66LJXIq15IznD4LpKtrijX562WDixRFohQcatM35TSStpW3TEAxbRmGHR3rm6QQse3DzWvQQMkp0lBriJn23gSxsSTW3WGYf8SYqe7tzu7W+QYBvj6oNH0zK9lIKHMoUY+0VJQgt2aYp1XXiUBkCEbSSpi6DR2M5nTn4zPi6eR0HSxZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:18:16 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:18:16 +0000
Date: Fri, 25 Sep 2026 13:18:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v3 3/3] drm/xe: Route deferred xe_vma/xe_vm teardown off
 system_dfl_wq
Message-ID: <arbXBmprEiRY6fXR@gsse-cloud1.jf.intel.com>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <20260925133335.149679-4-thomas.hellstrom@linux.intel.com>
 <arbR+2Sxc9snuKSM@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arbR+2Sxc9snuKSM@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 7881e0a3-524a-43fe-c824-08df1b42220e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Efndq3q5V9OC14NuGUCXusskyWVi50vKXfWwTQNZdvnsdTlcsxkkwE7RyV4y746afzMJVomQuWWGYA0msyC4/tpddlo5s5AB59bBQMXbOBOSbJdD4MPkyEHJooOgmk8xjXGQbBsYZqt5blGPprXaszuuUBNp/p/4Q01CVQaLazX2D6AUpSMUhUxgzDe6q/LAgg9H5Cx8/x2bAXVT19i1oq1uuyMZRB70iXz0NFIKkGqWlChn+rILyS1bfRIj3f/DinYIPf3hdrOGpf3rqENr0g8d/1ctPta0WtWPUQXt8Wx3tilbHSeJNDGJjXa1T8awEi9H0pQFFAtSFQu1n7zQzI9ldP6I6HQWHD45mfndgUEIWP1YLbugXKuQx0O3GzsxI7ojUZ3n2awrWnjVvsuK31FjjtSITsRgPl/crvrIbPEY5hAjFCKTcxwDr71ULCsRBSsjijGrkz3WiSSehj71iihk9P5MsAKNMEldVYLi/0J+fpgdrDEjLS/i8vxD6NDnxsuU7V6NsF97ndNo6lb5HytLqm6ehyVmyparLNHLeoxj3dc6g3mO+ppRBPbB7CN71CNkMyrw2l39uoyMAZqaQ8tpkQBOhmF1ztf+5ry1d3rSbjCHrnfXPpNrAUPnT6ptjEGjVJPY3wReOUmMldrMbqrbelUqc9uILk1xsmz/twM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Fb39C6uW/131iegqJG3Fio6qAOkkH9R7l75aXjJpAh4uOZ0BPtuxbb8U23?=
 =?iso-8859-1?Q?xlVWjWBP/5k/0LTiBXDucfxlVtTgxdRIEpRH/i9HcD9KYd0s44r0NOI1q8?=
 =?iso-8859-1?Q?89Z4jMGnBmF2kbswjoAcEmZHJN6DCE6f7XtGDEX3nxSoVNp8G0BzC/AS1X?=
 =?iso-8859-1?Q?+hDLPV/thS83+z7eYI1OsKugXeay0nZwHu3/JysQiXfYlC+l33cU4qf89a?=
 =?iso-8859-1?Q?t+HxdT9HEyz9ejhyhr9Vci98eLrOB58ASv0vq6M0EJr8ugCTPnQV/rb5wT?=
 =?iso-8859-1?Q?VP7GCET+vZIgS6TV7N/LWwx9E8O0Ukn2GrtvCEvKupgtw41G1xgVGuqWSN?=
 =?iso-8859-1?Q?O0iJyuK2Kxxj6YoX2PBwlauCmIn4Yrt7W/Dpzz9MCjffEznk+pfnOTZbMD?=
 =?iso-8859-1?Q?wkQOgvogNer5Dtb+RgNLLQeHxEgfmy3khe+OTyrLiBmR1R4/v631teTfV5?=
 =?iso-8859-1?Q?I4HLMQ/vW7qp79t72s96A0OcKTdyEG9xowy7QGaSCWlB6PhedY7mgKGsBu?=
 =?iso-8859-1?Q?4dRw3XcpUeYKZ2+2MziCC+II/rN2Xt5ib7mAB8Wc0GMqJRXedJdoRoVEEL?=
 =?iso-8859-1?Q?YGEIefxDAUZwR7K69ZFJCgn05yJnN0mydmA/S3rbEknYhIpzDGDaMOrLwh?=
 =?iso-8859-1?Q?HOmHLYVkyG7tjPq0ggvlSPNerRB7siJTFXmVaquBhljmt6agqm7FFkvWN8?=
 =?iso-8859-1?Q?x3J+b5DwY4Bn+7pdU5tAe1l+EqOWN6BoujiG/0Y9QksBcTR/NDpRPA+OFC?=
 =?iso-8859-1?Q?VLdtLaDAz7V5X83GnAeZkW679djGcbfQUflq136qceFQBdbxYnfKs/nbdR?=
 =?iso-8859-1?Q?xGOiQS1E7fH0cuqPr5fGuSa15B+cuUWB7jsBbF0y1T0k//iiQgqDoxxCpy?=
 =?iso-8859-1?Q?Bwh29VizV64B1Zxxrqdgf6oTw8ZbnKAA7cbUO5MxpXj3htByafz9hVTW3d?=
 =?iso-8859-1?Q?5+lag/wlebW2353cu66pJFhjjJmTgFh2VJ0Faow24o50YMOSQvlf9IhycW?=
 =?iso-8859-1?Q?zYJP9cxIFJ0i8J+adeMlrsyut344Kb0U3YwC1JMyyBhAUqigpY9d5MuTE3?=
 =?iso-8859-1?Q?tBG2aizqoVBJG3gOzF+zwiKN12lg1X96eoxMN+pXCFtiXeIbJByijtGDDD?=
 =?iso-8859-1?Q?hZkLdzDb1QY3KApIT0wxPpbKPCX2WhHwuK7Dk+rttccbROEFElAlr9QDF2?=
 =?iso-8859-1?Q?O9vR3Mm88/QsWfeXRejWYGaY/YqSXVQt1uCKLiqXA+/ctAt5mCLBzTnwcn?=
 =?iso-8859-1?Q?STGevk95TEH82Wirf40pAAWzNNexglLNS5q8Oz1+nSPM4lEmctjiwOt7e1?=
 =?iso-8859-1?Q?MiSTiA1hg29IaLpryh2ffu+d8Pv+/xPQGPpXiJiN1ghKZMtnNMwoxbREnq?=
 =?iso-8859-1?Q?5sWkycfK58wY74h3v9/BRwHxiHWB3x+dWkbcZPE3BlWaqz6Kv3fWC8pWVI?=
 =?iso-8859-1?Q?1iD9Q3i/20AfoAVhrPrV5LojynwD2nz6SyoSqYhqpdmO6s8FRgzLRNcxrx?=
 =?iso-8859-1?Q?KfvUGuTCoCtYMXAk7Gf/ihoNLnSPEepmncJ5+eTj7EYXUMEowOAzLv5dy8?=
 =?iso-8859-1?Q?mWy6Cdp357cdXYCecFcDA1xMEzb9OSSP+YCk4REyurBxXp+YvDu+umyr0L?=
 =?iso-8859-1?Q?CAnPMM7WgsMFWMUseXA2vlP+RGKJM3CrPROVU7UIgw3aL/DuNfPgKufWd+?=
 =?iso-8859-1?Q?okWwkUKuUs3zIHBHNDe+YyPoTgNHwPvQzYv6OyKDgkqejCbXXRViXHKBVX?=
 =?iso-8859-1?Q?VH83wcPd112TTcym4ce4WSo6il3SwXTMqK/PL//Bl57vWyhA/38LVobroA?=
 =?iso-8859-1?Q?IEwS5GqSkaBv+5nv7ke2OSVwLAr1r+0=3D?=
X-Exchange-RoutingPolicyChecked: 0s8VrWmBqH80ZDpBXeISki1mVx06JAKjiHvjGaS64nrtnPAT7RVef1ddqGLSwqu43uZiTOxqyv2VEIGe3pv/JpmcP4E9qAVFdT+wg9nKsRP6aoPpd2CulaNR3uquJjq08ET91fLD5HFUhTEZ0NyxLBOeav7yQAb45p7rBTE9zbVTFcIEtzz7cW83pqHNt2gNwzHNTBU5VTpT55mFzHlv4pa3PdiruwMPBGk9+mK5+x1E23hdi8t9xDNqBCoTwRxd6pC+VEcYLqz0yjLUpU4Iw4wek1N7VXxkJGgdoYY3LuJ113xKjphVJpwvM5IH9H/1HJa4ruDpxwLE2XdAj0TU5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7881e0a3-524a-43fe-c824-08df1b42220e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:18:16.4403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoAC5XlabQyg94zxXSEuaNVVCw0JFcfc/Brv1ZPV/iT2d0YrCpzuOx/w2vfF8gAo+GjLYCHKzaSNJ6mYT8CPQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
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

On Fri, Sep 25, 2026 at 12:56:43PM -0700, Matthew Brost wrote:
> On Fri, Sep 25, 2026 at 03:33:35PM +0200, Thomas Hellström wrote:
> > xe_vma_destroy() can defer the final teardown of a struct xe_vma to a
> > dma_fence completion callback (vma_destroy_cb()), and xe_vm_free() (the
> > drm_gpuvm_ops.vm_free callback) always defers struct xe_vm teardown to
> > a work item, since destroying a VM needs to sleep. Both used to queue
> > their work on system_dfl_wq, a global, kernel-wide workqueue that xe
> > has no control over and never waits on during module unload.
> > 
> > drm_gpuvm_free() drops its drm_device reference immediately after
> > calling xe_vm_free(), without waiting for the deferred work to run.
> > The same applies one level down: whichever xe_vma or xe_vm reference
> > happens to be the last one can trigger this chain from a dma_fence
> > callback that may fire at an arbitrary time, including after the
> > owning file has already been closed and its own module reference
> > dropped. Since nothing tracks or waits for work queued on
> > system_dfl_wq, `rmmod xe` could succeed and free the module's text
> > while vma_destroy_work_func() or vm_destroy_work_func() is still
> > queued or running on it, jumping into freed code.
> > 
> > Fix this by queueing this work on xe_destroy_wq instead, the existing
> > module-lifetime workqueue already used for GuC exec queue teardown.
> > Unlike a per-device workqueue, this requires no dereference of a
> > struct xe_device that may already be gone by the time a deferred
> > callback fires, and unlike system_dfl_wq it is guaranteed to be
> > drained by xe_destroy_wq_module_exit() before the module is unloaded,
> > following the drm_pagemap_dev_hold()/unhold_work precedent of using a
> > workqueue that is waited on at module unload rather than a bare module
> > reference. The previous commit's reordering of xe_destroy_wq_exit()
> > to run after xe_device_exit() guarantees that xe_destroy_wq is only
> > torn down once the device-count has reached zero, i.e. after any
> > xe_vma or xe_vm whose teardown queues work here has already dropped
> > its drm_device reference and thus already queued that work.
> > 
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: LLM
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_module.c | 6 ++++--
> >  drivers/gpu/drm/xe/xe_vm.c     | 5 +++--
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> > index c61bd33546f2..897724cb5cfb 100644
> > --- a/drivers/gpu/drm/xe/xe_module.c
> > +++ b/drivers/gpu/drm/xe/xe_module.c
> > @@ -114,8 +114,10 @@ static void xe_destroy_wq_module_exit(void)
> >   * xe_destroy_wq_queue() - Queue work on the destroy workqueue
> >   * @work: work item to queue
> >   *
> > - * The destroy workqueue has module lifetime and is used for GuC exec queue
> > - * teardown that can outlive a single xe_device. SVM pagemap destroy uses the
> > + * The destroy workqueue has module lifetime, and is guaranteed to outlive
> > + * any xe_device, and to be drained before the module is unloaded. It is used
> > + * for GuC exec queue and xe_vm/xe_vma teardown that can be deferred past the
> > + * lifetime of the xe_device that triggered it. SVM pagemap destroy uses the
> >   * per-device xe->destroy_wq instead.
> >   *
> >   * Return: %true if @work was queued, %false if it was already pending.
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 390da884c727..ee369e6c3b28 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -29,6 +29,7 @@
> >  #include "xe_exec_queue.h"
> >  #include "xe_gt.h"
> >  #include "xe_migrate.h"
> > +#include "xe_module.h"
> >  #include "xe_pagefault.h"
> >  #include "xe_pat.h"
> >  #include "xe_pm.h"
> > @@ -1249,7 +1250,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
> >  	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
> >  
> >  	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
> > -	queue_work(system_dfl_wq, &vma->destroy_work);
> > +	xe_destroy_wq_queue(&vma->destroy_work);
> >  }
> >  
> >  static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
> > @@ -2059,7 +2060,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
> >  	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
> >  
> >  	/* To destroy the VM we need to be able to sleep */
> > -	queue_work(system_dfl_wq, &vm->destroy_work);
> > +	xe_destroy_wq_queue(&vm->destroy_work);
> 
> Actually this is still unsafe, right?
> 
> destroy_work touches vm->xe which could be gone after gpuvm drops
> potentially the final drm_dev_put, right?
> 

Ignore this - we flush this queue before destorying any device.

Matt

> Matt 
> 
> >  }
> >  
> >  struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
> > -- 
> > 2.55.0
> > 
