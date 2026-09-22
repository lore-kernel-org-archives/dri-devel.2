Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DECC982FD
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 02:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FE810E593;
	Tue, 22 Sep 2026 02:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d0/jt42C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46C910E19E;
 Tue, 22 Sep 2026 02:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790043758; x=1821579758;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KPobSDoZApe/FxLqHBNNP2+xD6XjNNh4mANZH/IkDy8=;
 b=d0/jt42Cyu8gIHSpHiSjg0xHlelbxPO37r8dIJLAouP0YKbQ8yUwppWf
 1k77NPdNCsDHVB7DdFt7LgW5paMtwsio22IoM+phV7eApTUN75nnWCC6u
 g5W1XYl64MknerFCD3cMyS0twymALKEml9f+jDJK7Hq1pTTbkuyxZTV9h
 8fgCuifffKGh7ZdC22UXDgR4zB8/LYIUYi8btd+tuMZIN6Y6IS169NkI+
 jxb4/2VuFpvUn2hDJcbXAhUn6EUkm34JfVn6Ze6fAZC5aQwOVFuAHXFKZ
 EKkda5png0hUp6G7JUvkWvjuPKCusWnv97C4OrfIHip1J8AuKQJ7Suv/9 g==;
X-CSE-ConnectionGUID: 1pmVaQCYTaaDEW+8wzLqRw==
X-CSE-MsgGUID: rl+0albpT/+ak3QpJ8YtFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101270766"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="101270766"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 19:22:37 -0700
X-CSE-ConnectionGUID: gchO2ekAQpGwIbfOxyjLwA==
X-CSE-MsgGUID: v/DGjo15TvaMpwewdq3ZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="277708036"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 19:22:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 19:22:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 19:22:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 19:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rnntl0TI9YOKfYEilS9EXz/rLet9a2xJgPhVED1AdnopWiOyKQ31dJfvh6A19uSn0h4z5f7sAhkgnsc86VwAj/GLelS4mSSGkzxOUXbEkKs9hfUMOxXHMd+q1LEgh2BcLB63WqanW3rY9xoZFXUpgaKDocOJAA9qVWFshNoYaUK9qZxGVo4SCyt8KIV0BO1A5IEm4HPgirqWcTXBEGdCVI//FjTiqKK/K+QJnThmiGv0CFJ46T43ZxSBQJVh75m42WxqzuLLzcU/fJ29fpVOs9ijovLB2dQzPYC1JpdV5w4syChuzVO0mGjCouxjULSUR8h9qGFdPtCb/QvpYuTxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX1msV1jd6NTQFRmfgcstsU8gCNnyFA/v4SG9ZGyx6s=;
 b=Ie5PRn6I7fBFU/87kN8wO4vJs+iNECBdXYCfVlYjNrx8685KiTkW53EBDK6ew2e/2/UMR6l8LPrQd/rqYx5vWNLHKQpyfjELmxvMwAJjY3bgvvVOLlrPbgk0tn8/Xyc998PJzfPZOc3mceOhhDiCbYOIWt09uHZ7/KAxT+wjtYKgh7wRa2UTIM73/pMx5ZEehXc61OvyckocAfBYNIGB7u0lQDdOzkrLc0MP7nW85YuU5bzLFO7Y8WCiM/JKvL8DuooLB4MeNc55DxlPKq241wK6vbCnL8sJP1gi6Ns3rmWkmma5cXANBIy0tMsrZOBsbUJKEGs7nkORfRE/iVlX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:22:32 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 02:22:31 +0000
Date: Mon, 21 Sep 2026 19:22:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 3/3] drm/xe: Implement Wa_22016122933
Message-ID: <arHmZQfRNx9fNoZI@gsse-cloud1.jf.intel.com>
References: <20260921182121.308217-1-talesam@gmail.com>
 <20260921182121.308217-4-talesam@gmail.com>
 <arF8Fbk7evath6oT@gsse-cloud1.jf.intel.com>
 <CAHBRX4EhVxJ8VeWYpfdZDpY0TRdwV-P4Ebtn6QmN=gYNWPgA+A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4EhVxJ8VeWYpfdZDpY0TRdwV-P4Ebtn6QmN=gYNWPgA+A@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 054aa3d9-9edd-44a6-8ed8-08df18505b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: CUbmurdwfBQVlrlAQ7C0NPh224WicTtsiMH2IqY/dnc82UtxTIwzpylGB+V22HXiH1AQpgl7hpmSZewwclizcCftBL4DS3Lt2MjcAVSiDt0Xi1SMF2MS0V8leYM+1rCzPYd4SAORvWKL/R/5sMfFy7p7R3hNSX3OMAZgM1VqVDo2nNjfBviPI69JIESrzQl3ZZgFiacN168Y0cIXm0I4qh3Fn2Af/EI78tJ6mZUlle0cxBsR1gYYmHEAzo+6elxcTu37oSs75LoGyD/N8tlVi7vYBMyKZwF22Z4uVnRwEL56grIPTZVM7y2Bi5NZBH8X9BqGDzZP8BLbcBdzZjceEa6ZuyPfZiTYlu6PpIHRrEjkAqGqAn/Wx/MgqL3UM7bZJW1gtnGLpjAWSuy/WeM9a/aTMI0k6m3RBSFttoqYfJh5AiPz9gz/SiKxPJbXMRxU4ScBxAOLo4LVSmxXk+k7gW7ddGBjR08CpTSzeyrr0tukkth50zDPSln897BuR2mpdlFMh9G1EVhz0Rmw9vtqkr8SdHX/sNoDJYkWxffgBBrJEMu5buXf0+ZjOyU1uyDtiMmUkMd0E+1xZU/nUuNjJVDhJM/Vpr5Tm/fqlIlKEM5bVFmAOgpMKV7OsFgLjwkf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+DhzSBekpckw4xwlcO750MPpzwYTl8cDq4XISEoIJcbSDrhANLcPMgWsM4?=
 =?iso-8859-1?Q?wikfKbl2iiWCzJuwTtROlr+iW3ZzmaofX5TOmc8kdZSiUcREXvIycd/Kpq?=
 =?iso-8859-1?Q?lzM5Ea0kcmN49FAlZXdZwF+byEu1fS51vLIczO7LUxKvrMJpEsmEMefmdO?=
 =?iso-8859-1?Q?4EtmWB+j0QL6GUEKwsJKKCF6UGwdUHZdcg18gyXuMZoMEvZdXaVjQgAj4w?=
 =?iso-8859-1?Q?SwjCbVGjl4sUW8H1tWYtXyjDGe++hoxS/aGkn2czZGi/Crmjj+5AXDmw4L?=
 =?iso-8859-1?Q?na1/zIQ3cSboR6G08ZdTCCg5xsa3i1r8BqASB75ddqSN7ODtK8wTAPtu8o?=
 =?iso-8859-1?Q?e69ir+/ZosRfxK62suvm9WT5JmYl24ukEuTX4OxysfZQhrdHDHVY2/+KqI?=
 =?iso-8859-1?Q?k44siojTW/JRTvHYGITYbX7y8BhAnFz4uZJmFqv/RfBsqCEOIbf90+yu+j?=
 =?iso-8859-1?Q?60e+lEZAGcz3D6v/LkNZ0M4mkXK+zUeKUl7VH7LtZnt7ijmQ1a6m4225s8?=
 =?iso-8859-1?Q?SuBOZ/7wdNgD3i91PH13zOXFpOq9fKomhLzz9+AhaCURjnEcRuVV1CpBYD?=
 =?iso-8859-1?Q?8uaqJMAk5A9skirKCVfLOsVsqx8qQxszEyJ4trD82LoILKrLIMAJve2dDG?=
 =?iso-8859-1?Q?y6xf52n1Ub3I7VctG8QigfQAPkuCwVVTXNnEmQWCU/eg0XPCv3iXPOwsnL?=
 =?iso-8859-1?Q?4vODpKt34r+Dof27GyN3CoJKIuXqnuowBvVMObcyOEP92VlLRpkTuq0BIj?=
 =?iso-8859-1?Q?ltLU6qe5Ytr1Rx39aMLWUk/QcwHXP+Oq9DbEs3HqQ7YbAnxQzqkLcpMNB1?=
 =?iso-8859-1?Q?8RLnrvF0KoTG0tI1rJBIUVTvCT03kFGq98lYHun4M9PeNncTs2S3c6mlQ9?=
 =?iso-8859-1?Q?WBLwSERlnmQdqHaDy9wutPoHkKOm954zldvMxYFzs7ylA/55qEustB2g7o?=
 =?iso-8859-1?Q?ACPcQmke4fJq7tKuuGnBaekfHIr3czFnBfYL5BzgCLH4WhVbDnyHhN4GeE?=
 =?iso-8859-1?Q?GvKMEYuXUD7RZXbZuQigisAix6Hiibh4b34y1PzDXLHoF6/9PvzxCkJDNN?=
 =?iso-8859-1?Q?J+2BCYjoe28eRgPOC/9mR4yu/F5fYqJJMf9Nk+MU6m7DB2SVJc73Z+1Q0y?=
 =?iso-8859-1?Q?D3YlWu7autzNgFahTalWhhMAPEQQNGZoWocTA3TFnKCONOCpeIBnPeYl12?=
 =?iso-8859-1?Q?c3oZPZzNLPEi8KYU2Lu2xbVhdzR8bIyffR0DJMkt6T3DUvxf4HPeymPRCD?=
 =?iso-8859-1?Q?JbCiO7ORXWoGvLO2mBFr8wXCh7PE6PcV9KnMxzrN/xjhXbMu1SD5YC7Ku0?=
 =?iso-8859-1?Q?TJ2KH4k/rJIA5EH/rJ0VRfiHZ+Yi7Q7u+jK6+15qUdh2ahoOjNSYj86+yH?=
 =?iso-8859-1?Q?P1JAneF2lKI3jUvItCFy/77xmhlS0jhcCsDt33zikfavhqI6S/vVzU5yU7?=
 =?iso-8859-1?Q?cW4V4n0Q2FViFZJ5IS0EbgPNfwqCCcvOJdTc9yxAvtlYvgkcx3IQSW+c7A?=
 =?iso-8859-1?Q?N2KISjvAiY2JJBLsr+2a0kLbRf/pNHOLca6Iao8uaZf+Re8uSuNg+aKUpV?=
 =?iso-8859-1?Q?6DafHNND0DdEJmkeO2JIxUT/tg8UZmppVAzfWi0webKw322354PvyIg+Pf?=
 =?iso-8859-1?Q?midi6fHDdugVmc4uWRdMPacj4SvyPABVM0QTHjaoT3iQC3E+Bkx30g1oq1?=
 =?iso-8859-1?Q?DvhXcXfkcCN3W3nfiizHAn6YbUtToFpeN8VFgJ9ElQ8NMY/JdnBsusy9Nv?=
 =?iso-8859-1?Q?UsCmgV6YRUJNC+eSjFgrSs7wS0BXMsaPd74PZ4I7ClbM4dzV9wCeSNU/I8?=
 =?iso-8859-1?Q?ztw8on+njw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 2Xoh1dYTrfsFMyQaIOzLQuAF9UcDPCVPNIfpn/ggtMpbg6md/kd1By3YLyplHPuP3jhA8BORQQPwMyDM75/3HkrBR9RGThdZFTjeazsNxSQxUAYIZDM42h4gQh3UM8dif3b4NEscJupb2ibD06GPfMgRKXTqFwFbBReyWug8IF1ispm9UpEr6X4uiajEHXM2s7KoipaFMo2Cx4YsLm1uTiijyKEDZW6CcUsWeA0TB9clTssjhshJONbgJtM3P56Ti46qswHzb2eP0B6XB3fwKCPgrsZ3irOzilSeAA2/VwYmLqPD1Yn8+32JQ+FOauRXxsyxlpxZe+77QrEI1aQpYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 054aa3d9-9edd-44a6-8ed8-08df18505b4a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:22:31.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bJSIPF4JZ/k+KaDrjPSA05j+QnOfUAS7vBvI1OQoLZ26u8O1MBrJx7+26Lje9b4I1XHnQJPuaKacZ9+iiD19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
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

On Mon, Sep 21, 2026 at 05:18:46PM -0300, Tales A. Mendonça wrote:
> On Mon, Sep 21, 2026 at 11:48:00AM -0700, Matthew Brost wrote:
> > One thing the i915 WA does that isn't present here is if non-dGPU the
> > LRC is marked UC - see __lrc_alloc_state in the i915.
> >
> > Is that needed? AFAIK the GuC only reads the LRC though and all LRC
> > write are issued from hardware, so maybe the i915 application of this
> > W/A isn't correct? The fact you are not seeing hangs with this suggests
> > this part of thw W/A isn't needed.
> 
> I left it out deliberately, and I think your reading is right.
> 
> For the record on the i915 side: that marking only happens in the shmem
> fallback in __lrc_alloc_state(), after i915_gem_object_create_lmem()
> fails. On MTL/ARL there is no lmem, so it is the path always taken and
> the WA is effectively unconditional there.
> 
> What the erratum produces is the CPU reading a stale cache line for
> memory the GuC has written. That is exactly the pattern for the CTBs,
> the GuC log, ADS, SLPC and the engine activity buffers - GuC writes,
> CPU reads - and those are what this patch covers. The LRC does not fit
> it: the writes come from hardware context save and the GuC reads it.
> 
> One caveat on my own evidence, though: six weeks with no stalls only
> shows that leaving the LRC cached does not produce the TLB ack stall.
> If stale LRC content were a real problem it would presumably show up as
> bad context state rather than a delayed ack, and I have not been looking
> for that. So I would call it supported rather than proven.
> 
> If you would rather have parity with i915 anyway, I am happy to add it,

That is up to i915 maintainers, but in general I'd say if not broken in
i915, don't touch it. Feel free to post a post there though but out of
scope for an Xe change. 

> but as a separate patch, so it can be dropped on its own if it turns
> out to be unnecessary.
> 
> On how the current scope was chosen: the engine activity buffers were
> not in v2. Navon found that gap by A/B testing on his own ARL and
> measuring stale busyness stats, and they went in for v3. So the list is
> what the hardware demonstrated it needs rather than a port of the i915
> list.
> 

For this patch:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Tales
> 
> Em seg., 21 de set. de 2026 às 15:48, Matthew Brost
> <matthew.brost@intel.com> escreveu:
> >
> > On Mon, Sep 21, 2026 at 03:21:21PM -0300, Tales A. Mendonça wrote:
> > > On platforms with a standalone media GT and media version 13.00
> > > (MTL/ARL), memory shared between the CPU and the media GT's GuC must
> > > not be mapped cached on the CPU side: the CPU can otherwise read stale
> > > cache lines for data the GuC has already written.
> > >
> > > i915 implements this as Wa_22016122933 (see
> > > intel_gt_needs_wa_22016122933(), used by intel_guc_allocate_vma() and
> > > intel_gt_coherent_map_type()); xe never inherited it.
> > >
> > > The visible symptom on ARL is TLB invalidation acks stalling for a
> > > near-constant ~2.3s: the GuC writes the G2H ack in time, but the CPU
> > > keeps reading a stale (empty) view of the G2H CTB until the line is
> > > naturally evicted, so the fence timeout at 2.25s fires first. GuC log
> > > decode confirmed all invalidations were handled promptly by the
> > > firmware, and only the media GT was affected. See Link for the full
> > > investigation (three machines affected: 7d51, 7dd1, Arc Pro 130T).
> > >
> > > Making the mapping coherent instead of uncached does not help: with a
> > > GGTT PAT entry repurposed to WB|COH_2WAY the driver comes up and the
> > > media GT GuC runs, but the stalls remain (request-to-ack 2290ms).
> > > Uncached really is required here. Note that 2-way coherency is not
> > > normally reachable from a GGTT PTE (only 2 PAT bits), so that
> > > experiment needed a modified PAT table and may not reflect a supported
> > > configuration.
> > >
> > > Add the OOB workaround scoped like i915 (media version 13.00, media GT
> > > only - MEDIA_VERSION() OOB rules only match the media GT on standalone
> > > media platforms) and apply XE_BO_FLAG_NEEDS_UC to the GuC-shared
> > > allocations the CPU reads from: the CTBs, the GuC log, ADS, the SLPC
> > > shared data and the engine activity buffers. hwconfig and the G2G
> > > buffer are allocated on the primary GT only, where the workaround does
> > > not apply.
> > >
> > > Note that XE_BO_FLAG_NEEDS_UC drives both the CPU mapping (uncached)
> > > and the GGTT cache mode (XE_CACHE_NONE instead of XE_CACHE_WB), which is
> > > stricter than i915: i915 documents the workaround as WC on the CPU side
> > > and UC on the GPU side. A CPU-WC variant with the GGTT side kept at
> > > XE_CACHE_NONE was measured to be equally effective, but expressing it
> > > would require either a new BO flag or decoupling the GGTT cache-mode
> > > selection from XE_BO_FLAG_NEEDS_UC - simply swapping in
> > > XE_BO_FLAG_FORCE_WC silently relaxes the GPU side back to WB and the
> > > stalls return. The stricter mapping is kept here since it is the tested
> > > configuration and no throughput difference between the two was
> > > measurable; the extra plumbing can be added later if parity with i915 is
> > > preferred.
> > >
> > > Scope is limited to the GuC-shared allocations, which is where the
> > > failures were observed. i915 additionally covers media-GT LRC/ring
> > > state; extending xe to match can be done as a follow-up if wanted.
> > >
> > > Validation on two ARL machines (7d51 and 7dd1): before, 20-60 TLB
> > > invalidation ack stalls per day, every day, for weeks, on every kernel
> > > and on two GuC firmware versions (70.53.0 and 70.72.1). After: zero
> > > stalls in six weeks of combined runtime, over 10M TLB invalidations
> > > processed under the same workloads, across kernels 7.1.6, 7.1.8 and
> > > 7.2. The 7dd1 machine, which could not survive a day of media
> > > workloads on xe without a platform freeze, has been running xe full
> > > time since 11 August, including days with heavy video transcoding,
> > > with zero stalls and zero freezes.
> > >
> > > The coherency experiment, the CPU-WC measurements and the engine
> > > activity coverage gap were found by Navon John Lukose while A/B
> > > testing v2 on an ARL 7d51.
> > >
> > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > > Suggested-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> > > Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> > > Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_guc.c                 | 16 ++++++++++++++++
> > >  drivers/gpu/drm/xe/xe_guc.h                 |  2 ++
> > >  drivers/gpu/drm/xe/xe_guc_ads.c             |  3 ++-
> > >  drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++++--
> > >  drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++++--
> > >  drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++++--
> > >  drivers/gpu/drm/xe/xe_guc_pc.c              |  3 ++-
> > >  drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
> >
> > One thing the i915 WA does that isn't present here is if non-dGPU the
> > LRC is marked UC - see __lrc_alloc_state in the i915.
> >
> > Is that needed? AFIAK the GuC only reads the LRC though and all LRC
> > write are issued from hardware, so maybe the i915 application of this
> > W/A isn't correct? The fact you are not seeing hangs with this suggests
> > this part of thw W/A isn't needed.
> >
> > Matt
> >
> > >  8 files changed, 36 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > > index c7f8bbd4cb9..3ab4cb9e496 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > > @@ -1469,6 +1469,22 @@ int xe_guc_suspend(struct xe_guc *guc)
> > >       return 0;
> > >  }
> > >
> > > +/**
> > > + * xe_guc_bo_wa_flags - Extra BO flags for memory shared with the GuC
> > > + * @gt: the &xe_gt whose GuC the buffer will be shared with
> > > + *
> > > + * Wa_22016122933: on the standalone media GT, memory shared between the
> > > + * CPU and the GuC must not be mapped cached on the CPU side, otherwise
> > > + * the CPU can read stale data written by the GuC (e.g. G2H CTB writes)
> > > + * for multiple seconds.
> > > + *
> > > + * Return: additional XE_BO_FLAG_* to use when allocating GuC-shared memory
> > > + */
> > > +u32 xe_guc_bo_wa_flags(struct xe_gt *gt)
> > > +{
> > > +     return XE_GT_WA(gt, 22016122933) ? XE_BO_FLAG_NEEDS_UC : 0;
> > > +}
> > > +
> > >  void xe_guc_notify(struct xe_guc *guc)
> > >  {
> > >       struct xe_gt *gt = guc_to_gt(guc);
> > > diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> > > index 61e3ee19a59..c4eca40d69c 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc.h
> > > +++ b/drivers/gpu/drm/xe/xe_guc.h
> > > @@ -30,6 +30,7 @@
> > >       xe_guc_fw_version_at_least((guc), MAKE_GUC_VER_ARGS(ver))
> > >
> > >  struct drm_printer;
> > > +struct xe_gt;
> > >
> > >  void xe_guc_comm_init_early(struct xe_guc *guc);
> > >  int xe_guc_init_noalloc(struct xe_guc *guc);
> > > @@ -45,6 +46,7 @@ void xe_guc_runtime_suspend(struct xe_guc *guc);
> > >  void xe_guc_runtime_resume(struct xe_guc *guc);
> > >  int xe_guc_suspend(struct xe_guc *guc);
> > >  int xe_guc_softreset(struct xe_guc *guc);
> > > +u32 xe_guc_bo_wa_flags(struct xe_gt *gt);
> > >  void xe_guc_notify(struct xe_guc *guc);
> > >  int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
> > >  int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > index ff8eee3831a..abc7266fc6f 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > @@ -435,7 +435,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
> > >                                         XE_BO_FLAG_SYSTEM |
> > >                                         XE_BO_FLAG_GGTT |
> > >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > > +                                       xe_guc_bo_wa_flags(gt));
> > >       if (IS_ERR(bo))
> > >               return PTR_ERR(bo);
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> > > index 5c4733da385..5c393aa29de 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> > > @@ -376,7 +376,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
> > >                                         XE_BO_FLAG_SYSTEM |
> > >                                         XE_BO_FLAG_GGTT |
> > >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > > +                                       xe_guc_bo_wa_flags(gt));
> > >       if (IS_ERR(bo))
> > >               return PTR_ERR(bo);
> > >
> > > @@ -386,7 +387,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
> > >                                         XE_BO_FLAG_SYSTEM |
> > >                                         XE_BO_FLAG_GGTT |
> > >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > > +                                       xe_guc_bo_wa_flags(gt));
> > >       if (IS_ERR(bo))
> > >               return PTR_ERR(bo);
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_engine_activity.c b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> > > index a782be57caa..729ce8ac140 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> > > @@ -97,7 +97,8 @@ static int allocate_engine_activity_buffers(struct xe_guc *guc,
> > >
> > >       metadata_bo = xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(metadata_size),
> > >                                               ttm_bo_type_kernel, XE_BO_FLAG_SYSTEM |
> > > -                                             XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE,
> > > +                                             XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE |
> > > +                                             xe_guc_bo_wa_flags(gt),
> > >                                               false);
> > >
> > >       if (IS_ERR(metadata_bo))
> > > @@ -105,7 +106,8 @@ static int allocate_engine_activity_buffers(struct xe_guc *guc,
> > >
> > >       bo = xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(size),
> > >                                      ttm_bo_type_kernel, XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> > > -                                    XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE, false);
> > > +                                    XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE |
> > > +                                    xe_guc_bo_wa_flags(gt), false);
> > >
> > >       if (IS_ERR(bo)) {
> > >               xe_bo_unpin_map_no_vm(metadata_bo);
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> > > index 538d4df0f7a..7d006268ce9 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_log.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> > > @@ -17,6 +17,7 @@
> > >  #include "xe_force_wake.h"
> > >  #include "xe_gt_printk.h"
> > >  #include "xe_gt_types.h"
> > > +#include "xe_guc.h"
> > >  #include "xe_map.h"
> > >  #include "xe_mmio.h"
> > >  #include "xe_module.h"
> > > @@ -624,14 +625,16 @@ void xe_guc_log_print_lfd(struct xe_guc_log *log, struct drm_printer *p)
> > >  int xe_guc_log_init(struct xe_guc_log *log)
> > >  {
> > >       struct xe_device *xe = log_to_xe(log);
> > > -     struct xe_tile *tile = gt_to_tile(log_to_gt(log));
> > > +     struct xe_gt *gt = log_to_gt(log);
> > > +     struct xe_tile *tile = gt_to_tile(gt);
> > >       struct xe_bo *bo;
> > >
> > >       bo = xe_managed_bo_create_pin_map(xe, tile, GUC_LOG_SIZE,
> > >                                         XE_BO_FLAG_SYSTEM |
> > >                                         XE_BO_FLAG_GGTT |
> > >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > > +                                       xe_guc_bo_wa_flags(gt));
> > >       if (IS_ERR(bo))
> > >               return PTR_ERR(bo);
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
> > > index 097b075bd89..e0105222a2c 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_pc.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_pc.c
> > > @@ -1391,7 +1391,8 @@ int xe_guc_pc_init(struct xe_guc_pc *pc)
> > >                                         XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> > >                                         XE_BO_FLAG_GGTT |
> > >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > > +                                       xe_guc_bo_wa_flags(gt));
> > >       if (IS_ERR(bo))
> > >               return PTR_ERR(bo);
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> > > index dd69ad07f7a..30958b26a1d 100644
> > > --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> > > +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> > > @@ -14,6 +14,7 @@
> > >  16017236439  PLATFORM(PVC)
> > >  14019821291  MEDIA_VERSION_RANGE(1300, 2000)
> > >  14015076503  MEDIA_VERSION(1300)
> > > +22016122933  MEDIA_VERSION(1300)
> > >  14018913170  GRAPHICS_VERSION_RANGE(1270, 1274)
> > >               MEDIA_VERSION(1300)
> > >               PLATFORM(DG2)
> > > --
> > > 2.55.0
> > >
> 
> 
> 
> -- 
> Com os cumprimentos,
> 
> Tales A. Mendonça
> talesam.org
> communitybig.org
