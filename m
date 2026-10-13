Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C556CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647CF10E714;
	Tue, 13 Oct 2026 04:38:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5252910E714
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791866293; x=1823402293;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RC3o6kzfN738FIz2i/3a/KSL8kzVNho2+zr7f77b2uY=;
 b=k1mp5+OeuRzyx9paclHUSLW+ngbkk4MbnvSKDb5md8e2KsmCL1PwcdpH
 0EGd5KhlUERNUOYf7wN3V0XA/VyCkfCGG+zNtEcxHnTVoUCJ83cSM0009
 pJ4n6rrZNcA/uwhy6ihtxwoD6xtbSg9eIi7+2j54TxxiLXcu2Xkw4FKiE
 4dYfa1G9yTNtxRsIVMDP9a+zqTB6K0b8kHNBoroxXkqAaaw3ZBbrO4Y6n
 qod13co9Okq2vJL20x/fXYy6sLUApesNX2mnkA13BQeM5zNhWIlrABaH5
 z8h/VH+0oMfRZdb4J8+1sOIxtmXFR0x056YgRfFQ0zeMv5EDmXnF12KAe A==;
X-CSE-ConnectionGUID: SDuYp7m/QCWMUr0JtW/O5g==
X-CSE-MsgGUID: LPMvbBXrSzipMKhV0N5uow==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="462301"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="462301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 21:38:12 -0700
X-CSE-ConnectionGUID: 4kyS6DFLTj6JmkqquCKLsA==
X-CSE-MsgGUID: JCWbwZ6oRZeQ+0CWMZQx6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1256888"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 21:38:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 21:38:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 21:38:09 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 21:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVi4jtUZC8OIxN0ojKUPnQ+RS2xeZj8UopVmopNhCX45gfxRB7xY74xgpdKxFH2FXqAOOK40V9YHqhuD9VzQ61VvtWMHTSo5whg/mAzLYq8H54PMXa4KQOIWXJaEI/dC9VOPxWvJAZshAqPP4O0lsRX1ntD5dlVbcrcl2AQ2DykiLF165Twg2LbN24/1LYfJda2FvZgi/6itSUfpps+jdypBAUo36Y1L9Q2JeAtGc7OJzucZYzfAY1WK9FtWUSHZ8yGheix82VJUuv2uPg4cWF8H2Vt8BuScUvaeHwZQIRZn268ICnDoGP5Ke43GxHL2s6+hizmCGoCmPuvcnimq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W4nH/b3JDrHxpox0YHBzgQKOLn/MAklwIliZixzH+4=;
 b=JNCYkTT3jLxk5BvX0LNeAa3mUfxjEn/sV4KumXwUZ544XpTO8+jS0elvltPGi1z6iXL+4BChC1F0eicslva/p6oRxUpwW9tcAs78LY8nkmYd2O7a4lov3YiUqcbBAng1oq2xh//YaQs/eshiPT47nw+hmAdUpJXLnKl8fFS7rrnu74MNyLbBhHBgVv0xoAtOuNstGo6vN0sy+SqnDdUOGj71E2vsw95BDtGmAcljfWBb+aTzz6zLMzkun2GWBKYscegEgTtw5y8dZIPMO24wP1gkYp2DSmWPcwLMHM//oxzXXseSApXkCh8Mm84kFV5xyhH/ZEdMkEUiN+ywVrxY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH3PPFC0CDE789E.namprd11.prod.outlook.com (2603:10b6:518:1::d49)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 04:38:05 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 04:38:05 +0000
Date: Mon, 12 Oct 2026 21:38:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Max Zhen <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
Subject: Re: [PATCH V1] accel/amdxdna: Serialize HMM range faults on one umap
Message-ID: <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
References: <20261012203139.2573687-1-lizhi.hou@amd.com>
 <7a29937c-b591-40fc-95cf-021799ea52a7@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7a29937c-b591-40fc-95cf-021799ea52a7@amd.com>
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH3PPFC0CDE789E:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e61186-af42-4d92-5094-08df28e3c5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: eQN3dj+iKXfn+nXB5C9ceIB1EQ6NptA5KfqM9w+vMgjdhJLihnucvA+tqkqNvWIer3/mIp283j3/dz1mU4C8YcuiMZdzH+5vH7Q6xBcdRzvnql63X2Kwq3Cg7kFjnsE92gr45kxSxYezZUX7kRMhKjEnpKKj3nv/48YVmWjzomZiOFN5vSRMYMSZiWcdHCGzGPa0zV/LRNnGlr+F962DG0fuUWkfBVN8ijw5sn3GKbIqz7DHKWV1W5yUUKBnB13LdH4lEA+Lxj4/id1/pTHnFYHwdBHNl43NuejVDTn3e5IpG7ApZGvDe1YXz8Cazpyfqp+5bVEql2pEcGQZLqNi6MhOnrdb6akx+5ZgbIdFYq0RpZFoc04u9ZoqLXhllaJeZ/eXr02Uh2+1/Zrfxqbp4PBrzHwMD07Lk7TTgg+MWywATVWoBQyuWjeZTlYGiGCVaI7Ek9Wh9FlRsXCibDAsw9JcY1l6yDQVy3/kxVU/mtaLczOK6n1j5HWwNOChU8bq7sWzeBeeZUNBzfoma2frbkuXOVxCtcrtcYlg3GucKDYoHQxkKue5nkiN07IMNETu1MZIg+YXyKQgJeIHIt2QCROLRFE/Wq3P7I/R2he1fSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8/HqQn1X4NLRsFSMrK/acAKUFipB6TR0phOytIEKCroiz6KDgkRrE9TjOSP?=
 =?us-ascii?Q?+jqYRrm636V5uLEHbh19KDQngN5MJbysks73VScQauAhWVeCnNDzcXJ8tylI?=
 =?us-ascii?Q?QP4lfYl6wELZVXzP91wgN8oioCXtLdVJda/iedj4VkIuEPbcA5cxejC+OA3W?=
 =?us-ascii?Q?1WtUqJm8h4jmm1odyhYtsmBn2rFNqfKkq2oMEDxb/I3jTdu5Q2odcXPVjGAe?=
 =?us-ascii?Q?K9L82ElxsEjHHFCZUbzQuvZRy4PH2Mi8Lpss9mcLq8weGOZzd04l5RBz9q9K?=
 =?us-ascii?Q?MsIdDJl2/I6w3ZBfe4EGaCAB93fiGVYUboegKIfSwLOjvHyNjAanCIrE2qL9?=
 =?us-ascii?Q?6YWlyuaAYtLjQkMev2prSZ7gSD6FlbaE93R8ZSKXOGCQKZLyV68nM8ZZBHJu?=
 =?us-ascii?Q?cQ3J1jM4N0GPsFC2qmB1Gl5alJj6ezSQFB7rwsfADwjbOQ2xZC9ItIigcn9H?=
 =?us-ascii?Q?739+OLg9Mm+AUjATw5c5HbaQSPTi3+pAEYLgEJ/Ps7XN6IUxJykN9Szp93Bn?=
 =?us-ascii?Q?I2krOH3/Io8una88X5VlN/p/uowzha9DTackwybdewixFOYHUg1qZ/8WYY6D?=
 =?us-ascii?Q?bMBMc3OChBcSqnAG9s+fLuMQgw9QY+MVO4mgzwSI/X8sdlwABvGxJzKM/zWH?=
 =?us-ascii?Q?jTNfLi6aRJgVHZw2X5zIMOwEuBc9u+B6X1GIBHE2w2A+scRdkcEyWqC3N3YM?=
 =?us-ascii?Q?6xmMfhBtlLEIJPrZSTlVdOlaXNc+vF2CtZVWvuGlZybpPsSSHbZcsIRSoidp?=
 =?us-ascii?Q?Lot9FOFPPcVpcvuuKalUb2mhugi41pPCVOsFfu6LvaWoRFwVGNnlUekp5Oq/?=
 =?us-ascii?Q?rpX6Gi10cJx75AxnB/jPGgq4Y/I0Kx8Rs3eVF6coKnoUTsct4Gt/+OzltwSs?=
 =?us-ascii?Q?ucR8Z1X8rGwCVaX0b7ToiCFnrhJqDc8ngmCi3s3MTAhU2x9iMjr6ng+bGz34?=
 =?us-ascii?Q?g/celaADAFzpO7b95dI6RiN36Wo88HFigGXwbYny+aGDB6e9HsZ4QY7rfCHF?=
 =?us-ascii?Q?qdJTb0K2Omzq5LaDXoMghGhd1kUpfjpkOoi4bOa8jZfJC/LXchyLUQADmHxR?=
 =?us-ascii?Q?F4KkIk5rxsb+nMWrybnpNZsdBFC+E1jVqoJ0gsDd9df0fj8ESl6rNBSS0Y7D?=
 =?us-ascii?Q?VS/akd9JQOsoTqzuTYv0xwClVrJIoTMGa68/SJnhNy6q/1jZUGVx0xLF30Jk?=
 =?us-ascii?Q?pJ7Kv/yedyaBDf4vkN8BS2iAlvVamkoz+q3d4aOiZzdwHjk2A/9L4r/lxny4?=
 =?us-ascii?Q?F0g+LujC8lMG8EgRXWtNSN9sgcDIoFeQO7c+YEG78KxarnUoD/md9NNp1+Ey?=
 =?us-ascii?Q?Y4DbI727gZn1DUbqX01Rq4C9z+wREiuRaG2hgiodEqmCeio8orMkGv6xblsI?=
 =?us-ascii?Q?KhHmVHlGeRrvVccfDohQB75okxuQ14GCazrmE59BnGTQZ89bLJyRnsCFc91e?=
 =?us-ascii?Q?qDmQAzYS4AAZSNG1VPDRZPXrFx4jpOwPUamOCoKyF9ynQtgDTXXJ3K7pbnvl?=
 =?us-ascii?Q?Z3m5RDVSG0QdPL7MNDawjeofrTm/aseaq33EHZTz75gIjHvI14C2WlAXazCw?=
 =?us-ascii?Q?nPKBI1bwDD6BjUPG2JKcvD0V+IFGRvlKiRxBugwvIWBlkDHs2gCDC1rE/n5+?=
 =?us-ascii?Q?cU0+BvN10QlqJTsSN4cwBxAJQqTLc9Kc9w5X4ytiny8WeQQFmrB/lG7auCZo?=
 =?us-ascii?Q?1RRCNCiZOTg6kGcGdHdpYLI1RCoCZDROKG1GINNLqDfH5YBcabpBJs3bJxZC?=
 =?us-ascii?Q?wtoRu7B5Drd6iipE6diQGYfaaaJpuuA=3D?=
X-Exchange-RoutingPolicyChecked: wA6be+KCMTPB1VIDpl5if9Q2TjAte0a/F7ai2wBO7bbFPzM5HjL5S2aR27P6DdKvNw5HFuIpUG5hktJZfg12tbN1jSX89TCUGjhXVfOL10pXYb0S8ZsAqPSW4SlILwhv4UZuR4ebELP0YUkPPNV+GgTiwOYdRRygdL66r2zCfocu1jdvsCDGeLY63slQxdcsiL/AT4m20NlCeC6ZO0rg8GSOdNnKge0kvzzEtrRTTl+AMoHNDGDGzbMtPOwrJyzH4HXkXdfdO5LOKxSan/vixeDMxdt02B4YkjuYJSfLSOz4vmYArSi5IGNvzESYP6lBJTGcLC93xdxLp9L+GZcOMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e61186-af42-4d92-5094-08df28e3c5d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 04:38:05.2618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2n4vb14B009GG4Z3xpc43dAkK7Ip5JLi2bSak8rV/JZmRERaJAMgVV9P7QrnZE2dsPpNJssY9T/ZiTt5zux+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC0CDE789E
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

On Mon, Oct 12, 2026 at 09:10:15PM -0700, Max Zhen wrote:
> 
> 
> On 10/12/2026 Mon 13:31, Lizhi Hou wrote:
> > Two hardware contexts can submit jobs that use the same GEM object while
> > a user mapping is invalid. aie2_cmd_submit() drops the reservation and
> > notifier_lock before aie2_populate_range(), and that function takes a
> > reference on the first invalid umap without clearing invalid until the
> > fault returns. Both submissions then call
> > hmm_range_fault_unlocked_timeout() on the same struct hmm_range. That
> > structure is not safe for concurrent callers. The calls write
> > notifier_seq and hmm_pfns[] at the same time, so mmu_interval_read_retry()
> > can see the other call's sequence, miss an invalidation, and clear
> > invalid. The job is then pushed while the pages may already be gone.
> > Give each umap its own mutex and hold it from the fault through the retry
> > check and the store that clears invalid. notifier_lock is dropped before
> > this mutex is taken, and the fault drops mmap_lock before notifier_lock
> > is taken again.
> > 
> > Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>

I was browsing dri-devel and this hmm interaction annoyed me enough to
ask my AI to fix this and converge properly on a DRM framework:

https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/local_dev/amd_hmm_cleanup

Improper HMM or abuse affects the entire kernel, hence we should
converge.

Please consider the AI suggestions (last 3 patches) instead of open
coding this.

Matt

> > ---
> >   drivers/accel/amdxdna/aie2_ctx.c    | 7 ++++++-
> >   drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
> >   drivers/accel/amdxdna/amdxdna_gem.h | 1 +
> >   3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> > index d927c8c9d557..4db67a789c34 100644
> > --- a/drivers/accel/amdxdna/aie2_ctx.c
> > +++ b/drivers/accel/amdxdna/aie2_ctx.c
> > @@ -1155,19 +1155,24 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
> >   		return -EFAULT;
> >   	}
> > +	mutex_lock(&mapp->lock);
> >   	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
> > -	if (ret)
> > +	if (ret) {
> > +		mutex_unlock(&mapp->lock);
> >   		goto put_mm;
> > +	}
> >   	down_write(&xdna->notifier_lock);
> >   	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
> >   		up_write(&xdna->notifier_lock);
> > +		mutex_unlock(&mapp->lock);
> >   		amdxdna_umap_put(mapp);
> >   		mmput(mm);
> >   		goto again;
> >   	}
> >   	mapp->invalid = false;
> >   	up_write(&xdna->notifier_lock);
> > +	mutex_unlock(&mapp->lock);
> >   	amdxdna_umap_put(mapp);
> >   	mmput(mm);
> >   	goto again;
> > diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> > index f14484bc31ec..37bfa5058095 100644
> > --- a/drivers/accel/amdxdna/amdxdna_gem.c
> > +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> > @@ -318,6 +318,7 @@ static void amdxdna_umap_release(struct kref *ref)
> >   	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
> >   	mmu_interval_notifier_remove(&mapp->notifier);
> > +	mutex_destroy(&mapp->lock);
> >   	kvfree(mapp->range.hmm_pfns);
> >   	kfree(mapp);
> >   }
> > @@ -402,6 +403,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
> >   		goto free_pfns;
> >   	}
> > +	mutex_init(&mapp->lock);
> >   	down_write(&xdna->notifier_lock);
> >   	if (list_empty(&abo->mem.umap_list))
> >   		abo->mem.uva = addr;
> > diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> > index 9b4aa21a37c9..456a537eb68c 100644
> > --- a/drivers/accel/amdxdna/amdxdna_gem.h
> > +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> > @@ -19,6 +19,7 @@ struct amdxdna_umap {
> >   	struct kref			refcnt;
> >   	bool				invalid;
> >   	bool				unmapped;
> > +	struct mutex			lock; /* protect range */
> >   };
> >   struct amdxdna_mem {
> 
