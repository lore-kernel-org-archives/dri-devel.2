Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAA2C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3B010E554;
	Fri, 14 Aug 2026 08:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N/rzZuLR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A373D10E554;
 Fri, 14 Aug 2026 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786696622; x=1818232622;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YNAxx7Jff66O5nggd7juy9WiVXYqvGiGf8I8YUAUed8=;
 b=N/rzZuLRo5ddEHxPWLqe12NYFayba2EO5mChZTRqldSvLhTPuHVOtMGs
 5lyTZUIs7/0RjTQgPCVwbWqKuwDVyGit+huU5ZzJ1O54I0O9p4YpeldyY
 f/NiK5fvdbc2w+LpV92EFD2+LKE//RlIrgZ2SWu5b9dnRebSasEnvyyCS
 cOTOSCDmc6Xvmva/bW7h5gqLxqvaa1mvFB7qFkXpPp+s+LTDX5D+ENH2u
 rGL7SWZuC7ptRl6zWO51ELb3vMlZxwvQCY7p3hKjsQMuTiW4ieV9h5qPg
 XSn0y+ybP/m2PE0+wvMbbZDyQA1QB08NiOscuONZUOb32pVL5dnBoAmdL A==;
X-CSE-ConnectionGUID: Hev/2OTpRE6JX4PpBj3eVQ==
X-CSE-MsgGUID: xWHRszqWQAWkSPoeIBv5Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104658040"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="104658040"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 01:37:01 -0700
X-CSE-ConnectionGUID: P+dkKhfUQruhUmwppMLXfg==
X-CSE-MsgGUID: DcHFLgeYTSWyPMsAZqOTwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="261524116"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 01:37:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 01:37:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 01:37:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 01:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRUhyPjk6216OnvRTodrV4e0EVmGCtCNZ3H1UpoijfADLoI/tb+5SiOMn3hLmCxRadaOD9xQfVtaM0ubUvT3jDWLHS/TxmP+YEtX1o7yMsBPCcZHJDgJnRb6tXSWod4FgOOMRJCHlaVu6hQLRIBG2X1lPFZ5B8JogqGDsgkvrngCEKfyl21+woL2/ARPiqeSw4ZVi+AlXhFm/KPN0Km2QHS2oROz5mjv0PoKrZpCj5iQ8jKfmED2s0TDzIGrewdr/pxaHl5xkxVCV1FgGx5ag8pJLJboSiw+kr2w/JUP97XtmCnAzuZc7yOHxAp6Yi420ZoLGeK9gT1HoRJ/8tcKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vntNoQ2PbcNRoN4UAia2nluaMIrpwwwiS2wjVwwrfAw=;
 b=hw5tbbBJNDT4E9idqi6JOJYUjnXkF0GsDTAkkEgjnC4dTSs0XfI3UrIUIilVCAawPPrciUVeXwK9vUdEhS217ttVXWDLtnCigdBTNDvUqM607XUS3rsnCvERNPHTKwI/HWHvfnGIQsZ/xb45jPPOGXB0+B6zuvem4n5hPYY1iIo3/uSxcx+aYWca9mEfi+5runU+XbGOBd/HhZRzMx4IXnpB4YqAD1sX/EN2iR5+b3QOzNUkv/Y1IAt9DD3jyULtPjPXTzYbZHQRNJOBlzC/zlkLQ/uvH1L9YogksdbZg0cZNEAC+kqF7WbImRgED3Rdsn0sRKq4gxriaAQmB1PCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 08:36:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 08:36:51 +0000
Date: Fri, 14 Aug 2026 01:36:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <an7ToMvEA/0n8ONf@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
 <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
 <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
 <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
 <B6F23642F2B2211D+20260812082850.60737-1-neil.zhong@ugreen.com>
 <an5t/XpRTAIuR6j5@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an5t/XpRTAIuR6j5@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 209240ab-c4cb-4478-e2a8-08def9df2ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|17096099006|18096099006|6133799003|11146099003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: O6dSTwV23TFuJQruMRCFadG7OXwVHWvShjI2dXoZ3H3fPdJzcUX09fe/VLqevaLjT/sDNnUkw/pQbf2EP8Al2l14oWny1qGG82xQs5vq18NlM8ZWJRs12tzlTfuPRsNqu9nbuyswj64vF/UTDhiOI0bnTR01hdKkLXa2SzTfbltb8D8D8WaAcxjWQUZDBQg9KPf7a5y8xtvWXBMVLCvV801j9/3wIIC2IO3sESD8nBq0On90e2ODBONsudsSlLnAWnC9bw8MMYClHqurhL0xdymiNcbuBMd/+fLWHGUaG/86izF+4IKVKmSePb//Z5mXOpT4ixvsiEBrNGmGMHF7yKyVr7lbFUCl/zDE7gzGDXeiwlGq/tjvVQhxcSi93GxKj9MjPv0y118q5gs0VypBojv70qOobi60qCW7p0Bj2GlMY5frHEL157NrbwBKVEqVmVsVFlub0XVvyME6q5GIkVT3S3M3gep/Ox+qr6SBTohDUcte3TELRtVeIa//1Z/pB9NajsED/htpdB8sYjfItPpAz5Ezpc6ZvyNU5pdJOucKCP6+jUC0B6A9BsMsHzlv/pFWLEYwuKSZaPDRWZzZJN0D4TclEs8bJtrLuPzgvRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(17096099006)(18096099006)(6133799003)(11146099003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CDRQTcAb3bHgZfK5q1a+G0XbgqLtf1e61eWQak1SLGCZss2dsA/miFNXyC?=
 =?iso-8859-1?Q?9AM2awPJl5QTmMmGXp6ACBavSzW275zK094iHDLlc40dUcSM8T4K+Yf+9S?=
 =?iso-8859-1?Q?km0kaOio58ckp29NgfxBXOJFmwfjlODBfv4BvHrewA3S0fab49JO732wWq?=
 =?iso-8859-1?Q?WLghM0IWfuNFvZNm10egmJNTbLJaApgNhlxCxHCSfH7bFK7gfJJUDRH/KY?=
 =?iso-8859-1?Q?VnKGaxNqtm2ztSqIdjYE4dlAd3tXHwsbLKxHLJWpUnQaNsPIAggpE6uAG5?=
 =?iso-8859-1?Q?Yc6SDsa5RsL+PHxeIzy35blNZ73j2+wrV6g5EHPGqwEVlofPrNjwx3VBjx?=
 =?iso-8859-1?Q?woeEcVOVglLtsHC8L8cUi5CBEwCsIE2qBhMEO4ZLr+jU12GMjNNgNsJ7M1?=
 =?iso-8859-1?Q?/cGw1ze76CD4Pt/dMXjDdA2BN/AXzT1hWpIi8wwr62SLyG2uwNYadSaxt4?=
 =?iso-8859-1?Q?qR4pTMdPrvYTaDK75SN7Jigk6LQeN94hU2kP9XjRPh8V2JlcdK2q6iW3nn?=
 =?iso-8859-1?Q?96ZRHO79Uaa46GEdLQgpGDKe+ojaCqafBuRKi7YDu7We3zXHNknduqUn3n?=
 =?iso-8859-1?Q?bog8A96CncecoRkfBhh9ICNXZ3jXgbG/V16eatQeRyWF4w9nyhNs5QJdMy?=
 =?iso-8859-1?Q?KDe111hrawYgYnRpOzeaMmbB/7F+/IDT2htdBsqIty2WGUKEIaZFltXyDH?=
 =?iso-8859-1?Q?xVcXyR2XqQAwb987+XN+Z4yE7YEhQTCux7j/8kHdjKkdEhcSS7P/5Z5c14?=
 =?iso-8859-1?Q?DQeH7X6iyWOTgVXk+F4aU4JLf63RLD1qscETKHtROv9JLMTXFXHeCyXGs9?=
 =?iso-8859-1?Q?jPfEshKDphbB3v7spl0alZiyhUw6xj+bBxbdjuHqs7+fSNSho3G25O4ISi?=
 =?iso-8859-1?Q?29BODc1E2olagu+MZ8h/s0bm4rkjqJ+JMvaqI7lpunNCtt3TQ2ZB0xF6WX?=
 =?iso-8859-1?Q?UUmMVXeFF3rXC0fsvJyoCT/ZmHbK1FFhiaFCty4+UtRrruKOmcbV0zg3pf?=
 =?iso-8859-1?Q?zMBFxZBnxyMQQN88caqfEWFw/NCnBNU5R36lne8lhhYq2PBRKoMiSnJzy3?=
 =?iso-8859-1?Q?CqYorRwJtvCqwJaf03ePZO2tgdD7mbnNFq2mlvB8yJf719Q1wWHE1182hJ?=
 =?iso-8859-1?Q?QSLFGDb0RFpKbvNkRuilf6NRIKkLvA91/gM3Q11GJeyr3LUO+xjiAc/kjN?=
 =?iso-8859-1?Q?GKcMuizhb2YLKLHQrj6O7A9cvITtKrXd0t5ngHDWRCofBampP6OsBiB6gW?=
 =?iso-8859-1?Q?dIJfC4Q4fbjkwGh+wTAwctf95RmYy5JhSolFagxDuKcceop0EK84buoedv?=
 =?iso-8859-1?Q?dfVbKfsNhsLAMz2EgC4nrnP/5XgJ11kyHjfEMijMGExzlLtROo0W5dKkyf?=
 =?iso-8859-1?Q?YUTIJ/EUqExnyiOeNmH9mvafKwN315r7Vn2n0upprdZIpPbYdDGpQA2xDB?=
 =?iso-8859-1?Q?z9Lh+1rlnGEA8R5OVuQ+6tznyFDEtPpmoT8dIuLmbjyAqNd6C/P/gNgNmN?=
 =?iso-8859-1?Q?ffsRGFAjVC11UhoLphmIIMtudzrApYZynuURA3gq2CkO3xR2VYrGgjv5z+?=
 =?iso-8859-1?Q?PP7xojg3yScFisl3bVGrExItyex25CONxSXv43zLNAWLqsNTVtKazYr2vt?=
 =?iso-8859-1?Q?Gt6y3enkXY5RbTJICY5RWW4xht03FHuySlcr25sE2OmDwDt5dvtsz5oYSx?=
 =?iso-8859-1?Q?o3SVX9kipUS9yw0plkbmWXb56w423HNz9naPQOckw9Ksgdi66Bawheb6EZ?=
 =?iso-8859-1?Q?6ZH0j6tivmQDzOwBwLvYoqQ67To6E9frE63meQ4GgbhBNp1syeaa38zSIp?=
 =?iso-8859-1?Q?yxxK3MLNYUGh4pLluxRrFiBEC/LazNs=3D?=
X-Exchange-RoutingPolicyChecked: By5MBylU2k1Aa+Pa9Vu7oozsVzize9rDG/stns+f7hqmpNIBj98IGZwzSr0I4TPrJNPxKJ6DlHOLca7kMOxt4dUR7j6qlBCIy9YgQ5kFMPAaIwIyNBrTeHj+u6+D3Ivlpz1zrMUEljACgAnEBhpSdArgELmFS8WGMDCzcc+h4RfW/DaXiVkcWr2uVPtVnBr/rI/7e6rP4ekvjxJkRnFOb1bLbNS+nET9OALuGxkdalrIiYz0MdUXzpBZuo/B6ikrgMxeTt38EEZXuSn+WO86UeoqOP+Of0zJXBXTd0oqPDu6V4bDXmmEyOJ9ywa0M+d+faRF3WANUKro1BLX5kbFMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 209240ab-c4cb-4478-e2a8-08def9df2ffc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:36:51.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUXZkhTf87f1xs+2Vl+pZ6GRmqLXZYLGKVPw3Bq0y4cVJMdaz2WbLHZXB06d7M1WMxjk7tPRUJBGK8KgpIWQSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
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

On Thu, Aug 13, 2026 at 06:23:09PM -0700, Matthew Brost wrote:
> On Wed, Aug 12, 2026 at 04:28:47PM +0800, Neil Zhong wrote:
> > Hi Matt,
> > 
> > > Can you give me instructions on how to recreate this on our end and your
> > > machine, memory details? I have a bunch of various reproducers which I
> > > have been using for shrinker work and the more the better.
> > 
> > Yes. The test system and workload are as follows.
> > 
> >   - Panther Lake iGPU using shared system memory
> >   - 8 GiB installed memory; /proc/meminfo reports 7,723,392 KiB
> >   - 4 KiB base pages
> >   - four zram swap devices, 3,858,416 KiB in total
> >   - Linux 6.18.15, x86_64, PREEMPT_DYNAMIC
> >   - X11 fullscreen output at 3840x2160 and 60 Hz
> >   - a 3840x2160, 60 fps, HEVC HDR video played continuously in a loop
> > 
> > The player uses hardware decoding. Each decoded frame is imported through
> > DMA-BUF and processed by libplacebo/OpenGL for HDR tone mapping before
> > presentation. It calls glFlush() for every rendered frame. During steady
> > playback, the player accounts for about 1.85 GiB of logical Xe BO
> > allocation, including about 672 MiB reported as shared.
> > 
> > The player is not currently public. However, an equivalent pipeline should
> 
> This will become a problem if we introduce a uAPI, as we need an
> open-source consumer of that uAPI. Fortunately, it looks like we are
> already moving toward pinning uAPIs for several other reasons as well.
> 
> > reproduce the condition if it keeps the decoded surfaces, HDR intermediate
> > render targets and presentation surfaces alive, rather than creating a
> > small synthetic BO set. 
> > 
> > No additional memory-pressure tool was used for the first reproduction.
> > I start the video, let its working set reach steady state, and then capture
> > ten minutes while playback continues. On the 8 GiB system, the priority-only
> > run had MemAvailable between 2.89 and 3.15 GiB, while 97.8% of kswapd wakeups
> > were for order-10 allocations. Thus this reproduces without forcing an
> 
> We have upstream fixes for the order-10 allocations to avoid triggering
> reclaim for anything other than order-0 or order-9 allocations. I shared
> that patch in a previous reply, and it is probably worth pulling in as a
> mitigation, plus the core MM series.
> 
> > order-0 shortage.
> > 
> > I collected the trace with:
> > 
> >   sudo ./capture_xe_memory_churn.sh \
> >           -t 600 \
> >           -s 0.2 \
> >           -o ./xe-memory-churn
> > 
> > `-t 600` records ten minutes. `-t 0` can instead be used to record until
> > Ctrl-C. The 0.2 second option is only the /proc and TTM-pool sampling
> > interval; ftrace events are recorded continuously.
> > 
> > The player also logs one line after each frame submission in this form:
> > 
> >   gl_sw_submit_frame timing: ... Flush=123.456 ms
> > 
> > The log prefix contains the wall-clock timestamp. An equivalent reproducer
> > can record the time immediately after glFlush() returns and the measured
> > duration. The trace script inserts a wall-clock epoch marker into a
> > mono_raw ftrace stream so that the two timelines can be aligned.
> > 
> > The figures in my previous email came from the 6.18.15 kernel with [9]-[13]
> > backported, the fragmentation check applied to direct reclaim as well, and
> > the high-plus-min watermark experiment described there. The default-device
> > watermark capture used vm.min_free_kbytes=131072. The follow-up used 50000;
> > the workload and trace procedure were otherwise unchanged.
> > 
> > > Also a quick write up how you extracted these numbers from reproducer so
> > > I can recreate on my end.
> > 
> > The capture script creates temporary entry and return kprobes for:
> > 
> >   ttm_tt_backup()
> >   ttm_tt_restore()
> >   ttm_pool_alloc()
> >   ttm_pool_free()
> >   ttm_pool_shrink()
> > 
> > It also traces the Xe shrinker, TTM restore and cache-attribute functions,
> > kswapd and direct-reclaim events, compaction, and allocation
> > fragmentation.
> > 
> > At ttm_tt_backup() entry, the probe records the ttm_tt pointer and
> > num_pages. At return, it records the positive return value, which is the
> > number of pages actually backed up. I sum those successful return values,
> > not the requested page count, when reporting backup volume. A later
> > ttm_tt_restore() is matched to the most recent successful backup using the
> > same ttm_tt pointer. That provides per-object backup-to-restore latency and
> > repeated-cycle counts.
> > 
> > The byte-volume calculation is:
> > 
> >   backup bytes = sum(successful backup return pages) * PAGE_SIZE
> >   restore bytes = sum(num_pages for matched restores) * PAGE_SIZE
> > 
> > The reported backup-plus-restore volume is the sum of those two values.
> > It is cumulative migration/copy traffic, not resident memory and not net
> > memory freed. A shmem backup remains resident system memory unless those
> > shmem pages are subsequently swapped out.
> > 
> > > This customer, in particular, utilizes priority bands to express this
> > > heuristic (e.g., the compositor is the highest priority, any
> > > non-privileged UI-related content is normal priority, and everything
> > > else is low priority).
> > 
> > I think priority bands are useful for relative reclaim ordering, but they
> > do not by themselves express the guarantee needed here.
> > 
> > Consider a system with one large GPU workload. If nearly all reclaimable
> > BOs belong to that client and are placed in the high-priority band, the low
> > bands will contain few or no candidates. When enough memory is requested,
> > the shrinker must eventually enter the high band. In that case, high
> > priority delays reclaim but does not prevent it. The priority-only test
> > showed exactly this limitation: over ten minutes there were 6,743
> > successful backups and 6,693 restores, with 157 Flush calls over 16.667 ms
> > and a maximum Flush of 494.434 ms.
> > 
> > I am not suggesting that every BO of a high-priority client should be
> > unreclaimable. Whether reclaim is acceptable depends on the workload, and
> > the kernel cannot infer that semantic from WC, VM-bound state, client count
> > or BO size alone. For example, the driver-visible behavior of these two
> > workloads can look very similar:
> > 
> >   1. Foreground 4K60 HDR playback. Its active decoded surfaces, HDR render
> >      targets and presentation surfaces have a 16.667 ms deadline. Backing
> >      them up and restoring them causes an immediate and clearly visible
> >      product failure. These BOs should avoid eviction and shrinking while
> >      they are part of the active visual pipeline.
> > 
> >   2. Background image recognition or classification. Its BOs have no
> >      presentation deadline. Reclaiming them under system memory pressure
> >      is reasonable, even if the job later has to reconstruct its working
> >      set.
> 
> In this case, do you have two VMs sharing BOs? If the foreground and
> background tasks share a single VM, it does not matter which BOs are
> shrunk or restored because, when a VM is validated during an exec IOCTL,
> all BOs mapped within that VM are restored.
> 
> I assume that in this case you are using two VMs that share buffers as
> needed via dma-buf. Is that correct? If not, pinning is not going to
> help unless the pinned set includes everything.
> 
> > 
> > Priority bands cannot distinguish those cases if both clients assign their
> 
> Assuming there are two VMs here, set your foreground queue's priority to
> NORMAL and your background task queue's priority to LOW. (Alternatively,
> if the foreground task has CAP_SYS_ADMIN privileges, you could set it to
> HIGH, etc.) This should cause the background BOs to be shrunk rather
> than the foreground BOs.
>  
> There is another problem in Xe when VMs share BOs. The way a VM is
> locked and validated during exec IOCTLs can cause cross-VM lock
> contention get stuck behing shrinking. This issue exists regardless of
> whether a priority-based solution or pinning is used.
>  
> For example, assume there are two VMs, one for the foreground workload
> and one for the background workload. We correctly evict the background
> BOs when needed, and some set of dma-buf buffers is shared between the
> two VMs. Below a flow that shows a contention problem:
> 
> 1. a private BO from background is shrunk
> 2. background exec IOCTL
> 	2.1. grab all dma-resv locks (including some shared with
> 	     foreground)
> 	2.2. restore shunk BO
> 	2.3. submit GPU job
> 3. foreground exec IOCTL (in parallel with 2)
> 	3.1 grab all dma-resv locks (including some shared with
> 	    background)
> 	3.2. submit GPU job
> 
> In this example 3.1 can get stuck behind 2.2 (an unrelated restore),
> thus 3 can miss a presentation deadline.
> 
> We likely need our Xe IOCTL and GPUVM code to be smart enough to perform
> multiple lock-and-validate passes. For example, we could initially lock
> only the eviction set, validate everything, and then repeat the process
> until the eviction set is empty. Only after that would we lock and
> validate everything else.
> 
> This is an existing problem that really needs to be fixed. I'll probably
> take a look at addressing it.
> 

Here is an attempt at fixing the cross-VM issue:

https://patchwork.freedesktop.org/series/172205/

Matt

> > current working set a high relative priority. This is why I think the
> > business semantic has to come from userspace. Priority bands can remain the
> > general ordering mechanism, while a separate, explicit and bounded
> > NO_SHRINK or latency-critical mark protects only the BOs in an active visual
> > pipeline. The mark should be removed as soon as a surface leaves that
> > working set.
> > 
> > > To be clear - this would be an addition to fixes discussed above, right?
> > 
> > Yes. I see explicit workload-semantic protection as an addition to the
> > core MM fragmentation/shrinker fixes and the Xe/TTM priority bands, not a
> > replacement for either. I agree that testing series 168651 together with
> > the priority bands is still useful for general working-set preservation.
> > It can reduce accidental reclaim, while an accounted NO_SHRINK contract
> > handles the smaller set for which a missed presentation deadline is not an
> > acceptable reclaim tradeoff.
> 
> I don't think anyone is opposed to pinning if we can get the right
> permission control in place (most likely cgroups).
> 
> Matt
> 
> > 
> > Thanks,
> > Neil
