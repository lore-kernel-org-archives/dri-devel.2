Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB097606A333
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GtkW5Ozs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bCTXKWXP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D2510FDBA;
	Wed, 25 Nov 2026 16:45:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00AB10FDAB;
 Wed, 25 Nov 2026 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795625137; x=1827161137;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gG5GoYK/hG7HjXrtYz+GKVlH+mriu6YqixmrZg7PYTo=;
 b=GtkW5Ozs0b2fIXScg8Dy73B/24Qc0strl7bgTWvsH4J78jLU3zg/sF4B
 25iIhmjoFWJ+4dMlfwy992CAAcM7zOhp+BgCMnkBJRd8kLKa8sCLPhUZI
 6lYnxCOUzU7pYFaOfS14qDK7h4OWcpRtlVlcoq2WV0mSQa4ai1N6OvT6V
 md+VZmOGYj+gkbaatl0Wt957gX7SmDeKAsB9jXTLE4+QJGFzaxfr4LadC
 YOWQSISMiPgWze1T4Xx2tsZ6rwO7zUc18/i0UekuwIaQcdCHU+IbYi2OI
 geUeh7VW/NS8oFGMhWEghSM80MSi32OHJo62fAyfD2MwFzNVsWe/pLNQ1 g==;
X-CSE-ConnectionGUID: 3MoHYWKTQIGu5ZdWVmI66Q==
X-CSE-MsgGUID: fSja9V/XRbSE6lgcve+Vag==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4515221"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4515221"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 08:21:41 -0800
X-CSE-ConnectionGUID: xej3zHbpTb2W3LQptcrDZQ==
X-CSE-MsgGUID: eRnvhIKgSjOcpTeYYmaK2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12232781"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 08:21:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 08:21:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 08:21:26 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 08:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+5leklwHzUGNOLDHLMtb+7/efiJMLe7XPlMej+SaVKvng4AFpzZr1um3wOuy+qd/FwX2Xnomt06q4muRMA3bRywt4z0X2G7rMQZv7bJoZNHEK+cIuNDMSx1pmgICgc9ftirUlAfZGjChWXvS1+3aVFzyvabe4wa0mOomFhSR2HBgj3V6aPPu4nH0I1B1i5WTaBmYhztQwvTT5voQZ3TGZw0hE7ugWz8Gdwo627Ys4LdXDsCQGbSDBJ7gRum2I8tO8yzF63iHVNoEI6VsOh/Svo4323Z9jWwXeNQm9gtgp1yDsQUGfjm0322uzJwaqG4pl8oemMCNOSlXwv6MRrAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru3fGjTLeLqDLPoDF+MuMgy6L88j6uVdA42dNdvvBE8=;
 b=V+9HtaAhvo2SmdLLW+k4EDL1Pf4N5XWELAOCiXur6kgjHzlDlWupN2xyBB0+rBMucrJrb5MCGAOLg0SMDLHxHTZjIOruytX+dqFYiJLmzc+/RFrW8lTRt/jNkMvUNPO4mhVpq/2oIu5ARpD7suQk3VLK9GQ6iMPPKVTphjiRPtcCNAKY/Jk3JMBVI2OviSe7n5EO62RaRbQQLFEXf3qlgA/nfGOTLcqd1DvJnFWV6tbgzHQF/W6xyZ6Dvk1VCZ1rlELl57ZCqDMzJRPjRnwfL2UeSvav9tbnHLzIpLTnS1ZoevEOZQCiu9ORfGneiB+8b/kF38me48ulAMXVb9/v2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru3fGjTLeLqDLPoDF+MuMgy6L88j6uVdA42dNdvvBE8=;
 b=bCTXKWXPghFEE9cTAAd5xeMp4Agvt1U8wXkivHNlBjkZ1V7uVLUG6UlT9718cluS38NvZyT2GtSje+JekO6/aJZILR5kDSDBYmHcdD0XxTtFgd1/kT7iw+AOHzVSozBngoWfqvhYild31iOK1U1Fpg0Y9BNaZ2fEpb1SorFzt6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:21:20 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:21:20 +0000
Date: Wed, 25 Nov 2026 08:21:17 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <tejas.upadhyay@intel.com>
Subject: Re: [PATCH] drm/xe/vm: Cancel pending rebind work before freeing the
 VM
Message-ID: <awcK/Q6SifMWJNR1@gsse-cloud1.jf.intel.com>
References: <20261125100744.1440957-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125100744.1440957-1-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1993d779-090c-46e2-ff48-08df4b102388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|18002099003|22082099003|10067099003|261102123227099003|56012099006|11063799006|261026121527099003|261021123027099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 6Tgyxkvq5YHEKUd3mmKP6VifgKR83Zlikzr1gbLi3/fgOGYr+WC5FbOb/YCyBDjf31/wmcji06LRD4pcA5NWVYiwMQajOG3Q8iz7Z8qJWl8PVkQd/uX9c5U6iFVTF4YyzUuK2u6Fl9XHaSOfoIlsB47V9G5UZXDcghOGGJVMyUtOKDsrZ8fqJecNJzTIff72EjU5mx+LKUeu0xm5YosyJSXLRX2uss47vwy+EDknG6hBjDB2VqXizRR/1+DpfkFuJzICPcIeQdj4sdwliWbpLqvzJTKMbU+2cD/yoY0DoTxfDKiGCHQJGhkwtglxaGXMLJ7RS/XnWJy9Mp3OWJq5YuYh+CdK6CEy3uEueVbFjDPxYvyVB9xVKe/yKLNNCqYFBWJzMyxaNsEDHeglCcpf7OQt99zVFbsAHo9yWYX911X2pxh065X3Bp7Osf40AJ9ovsn/eDITS7yffWFTyijWJ3VghqdU9wANxIIHNuJ6hnPAp2oEuEWUyERMiv4LMoOkVqBTsCG8tqoDK4a7Kpl0BTfQ1ejF42+MWD2V4Ore2nZMbswUv+0wGVgBwdMLYaq6gtY1Lqf6EVztdVb62AmdqBsOsa9eI/OLJ+cUn6ICakarwGwoWD9XkpnmzzDqoT7BDGKyh4lbdVRlnGM8xn7GXTGQ9PJnfJ3zY9tR6a26PF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(18002099003)(22082099003)(10067099003)(261102123227099003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GYBE+YwKEqd4RbSM24Ey+YOyhrxt7R2lCT69i+QQ0f4PJBokq0SNJLivsp?=
 =?iso-8859-1?Q?IBnkliT+561Iq7crFQO+W/GzvlqBZw3Op1xPNz7EJLBvqhR/lwbT3PnVmn?=
 =?iso-8859-1?Q?wVqP7ARYtK+KzKJDsBUU6SMPbqyiZXAxJVo1Wy2y2YpsCGJ9L1joNHou/M?=
 =?iso-8859-1?Q?lUmBBMpY8jjwQZrhoBo2ZRmo0SwEP/7naSSlsu2/zbvDm/yzOYncj/EFtG?=
 =?iso-8859-1?Q?IrrrAew0iuDnWfSXAKTHndZ52qmSAzBFHZuYQ5GCnCiIbKz1FC6zcvEj19?=
 =?iso-8859-1?Q?DkB/DeBImzsHTmlOeC8fzsYFpOyZAJxtvZdj+h6c6bWIRCUVinDigCHqYM?=
 =?iso-8859-1?Q?Zyia2UEQPSmGw9J5wWxbMaLsU0qHMpUs7G7VbbJROjRX08/4Sp5T0EO/VX?=
 =?iso-8859-1?Q?q9HfpyZfdJsCwXjgRbTww1OHzQgdNp7oHtRUiKDj/M3WUKP1IUuJHrZ9/G?=
 =?iso-8859-1?Q?hRhDSfJPvAE1Hndt6H0pLNAVFfmXXIpulvmXl9+Ja0QkTwgcLe+tyxPHVd?=
 =?iso-8859-1?Q?RxQXWUqS9Kz/i7O43dKNuib3jm7pvHfdlWg0n4lXtIjinu6b0L5bxbVyHy?=
 =?iso-8859-1?Q?PnoYcwMJY3GMAwKlyrV8kM/rcsrlVYfldNPCMWnKuRuuppzfBYXTCVklYG?=
 =?iso-8859-1?Q?ZJ+AlevjuQDqOLurJjSiUaapuDrrvEAbM0Xhn24bJyDVtEtw9shxC2YDOj?=
 =?iso-8859-1?Q?t5NVCL3y1dG//QCk4TDd0BrvJ3JvMoD4NtflCmCmfsuXOnjG/IwdG4tQxD?=
 =?iso-8859-1?Q?xmvDSaO7aX9NpSFvbCgABzQFLGv62QvrdFo/Q/cWyU+9v0tbqYyo5/eY7g?=
 =?iso-8859-1?Q?suRFQSlkFZNUYZQ9JQSn3w9e+ggGJf4Qi0LcLNM4SYuGQ51uDfO69Kedua?=
 =?iso-8859-1?Q?FOhIJsBaz5vciEP8OOHovIImavZD4uP0m0+88Tpkdqsc7eiz+QMN/CvmIL?=
 =?iso-8859-1?Q?XprT4Ai6/wqyVXHSbrS5A55xOnfhYcKtrxmtw994C95ETl+Xp1lsw+CI+x?=
 =?iso-8859-1?Q?bt5xroHMSF37rQyzHSKuk1anZwcq9HTU/G2AZz9f1UpRcK46hSq1leYtAQ?=
 =?iso-8859-1?Q?6/23CMKUmTL3qKyaDfAEW/vlRIu0aPAkczXK/p3u9tFRhxims1bMcWsrO3?=
 =?iso-8859-1?Q?tMWaWrtwE0ZUuROuMCiDyWwrUHreosVZSbw5VhIKJdMu2YeWRDxkqzBU/c?=
 =?iso-8859-1?Q?be3vDAP3EJn6ZxHUXk4Ia8jGj8WTjw4LaV+97dPWCP9JEx0gQs9g/EDU7i?=
 =?iso-8859-1?Q?KPuLxhfu82zwkiFoc5/JtfLxuaoGcGrVYZjCugbeT79Jaqu/wfsDAgYuo+?=
 =?iso-8859-1?Q?PIz3pIZrlrKNbO8QCqV0CustN222QOxrLezlt0Qn0G7NmfmESPBCoANgKC?=
 =?iso-8859-1?Q?5q6Eo3wH9RaTVccEgF3Ni02kXnaAXDY+nfPNReGhRY+w6Xdgv3peUqPgJe?=
 =?iso-8859-1?Q?SxFhPKP18vTgoTbF2lQ6FK1A9EOdjx67nZp0Ao2AhTQ/X74mp50bEVwAZp?=
 =?iso-8859-1?Q?JcKqxhWHJ77QNfRQkMS8vcSyRF7UyDAlCNAGbfk5DIPVPQLDmLnnPVcXS9?=
 =?iso-8859-1?Q?csFb0xTZHMtbMi6FRicO+wWtI10QjzwstyN57b3X9rOyYSuusT/A1TufbL?=
 =?iso-8859-1?Q?SpJtFD5j6TUSgWS2c7JaLFXGiKLIvxvVatmYaKEK3IDvSoTgQngaV+j55Y?=
 =?iso-8859-1?Q?WO6hRV1PqIIUKaWWlz9cAyY+08Pp68MOtqVTLZUzccMfnP9oLvAulRdhnu?=
 =?iso-8859-1?Q?7gnijhsxOIHW3m2/Y2oKOyH7g/kX7+WsoFHUlQBavVODcti+A3aRVCOARM?=
 =?iso-8859-1?Q?0FJbgUpoBtfjgGsVJpm+F23PlMQFkGw=3D?=
X-Exchange-RoutingPolicyChecked: GF5wZ3i8YnbzmG80LsktJBd/izhRKwPoXYejIIululLr70j1KrKyBQBR72gmObdIWsv1l24pMEcBwiEEuxAH1orurw0kBj5L+wE9QnHgdGZYpcY7xrB6kA5OV/Up7S1RbbdqCzxk/mV/5rgNp5MSS1EH+R4zDhrE2VuP5zqiXaRnmiPlqtXwN41+nLaBCGpQMrm2dImn8Fw+25MHK56fvszDLU5bLFg48b4/eDzu3Sq+8/D8sXsU14HuguCQgyh0TToQmcSqsg76kA4h0iZlPT0Qy5SqpOtUtAEDxGozU+Mf978q4Kbh+m+dhvFieVEU0nIjUDhJrDGRxLvRSbvzRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993d779-090c-46e2-ff48-08df4b102388
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:21:19.9097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTwhtHa4TBhDTM2e7ZfOex2UaLQhOGhaxSNOVEILgxALNlnOAGtbFuKgqCbxrigu1fhccKRG8GttxdiUeBWNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 03:37:44PM +0530, Arvind Yadav wrote:
> vm_destroy_work_func() runs on xe->destroy_wq and flushes rebind work
> on xe->ordered_wq. The destroy queue has WQ_MEM_RECLAIM, but the
> ordered queue has no rescuer. The kernel warns because this wait can
> stall memory reclaim.
> 
> The VM is already closed, so a pending rebind would return immediately.
> Use cancel_work_sync() to cancel pending work and wait for a running
> rebind to finish before freeing the VM.
> 
> [  727.067318] ------------[ cut here ]------------
> [  727.067552] workqueue: WQ_MEM_RECLAIM xe-destroy-wq:vm_destroy_work_func [xe] is flushing !WQ_MEM_RECLAIM xe-ordered-wq:preempt_rebind_work_func [xe]
> [  727.067726] WARNING: kernel/workqueue.c:4043 at check_flush_dependency.part.0+0xd9/0x110, CPU#1: kworker/1:0/33641
> [  727.067876] Workqueue: xe-destroy-wq vm_destroy_work_func [xe]
> [  727.067963] Call Trace:
> [  727.067964]  <TASK>
> [  727.067967]  __flush_work+0x44b/0x660
> [  727.067970]  ? __lock_acquire+0x584/0x29c0
> [  727.067974]  ? lock_is_held_type+0xa3/0x130
> [  727.067980]  flush_work+0x28/0x40
> [  727.067982]  vm_destroy_work_func+0x1a9/0x350 [xe]
> [  727.068061]  ? lock_release+0xd0/0x2c0
> [  727.068065]  process_one_work+0x2ad/0x890
> [  727.068071]  worker_thread+0x200/0x3f0
> [  727.068074]  ? __pfx_worker_thread+0x10/0x10
> [  727.068077]  kthread+0x113/0x150
> [  727.068079]  ? __pfx_kthread+0x10/0x10
> [  727.068081]  ret_from_fork+0x3bf/0x470
> [  727.068085]  ? __pfx_kthread+0x10/0x10
> [  727.068087]  ret_from_fork_asm+0x1a/0x30
> [  727.068096]  </TASK>
> [  727.068108] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 61e18525023a ("drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index dd855876f571..2ba99c083db8 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2091,7 +2091,7 @@ static void vm_destroy_work_func(struct work_struct *w)
>  	xe_assert(xe, !vm->size);
>  
>  	if (xe_vm_in_preempt_fence_mode(vm))
> -		flush_work(&vm->preempt.rebind_work);
> +		cancel_work_sync(&vm->preempt.rebind_work);

disable_work_sync ?

Matt

>  
>  	mutex_destroy(&vm->snap_mutex);
>  
> -- 
> 2.43.0
> 
