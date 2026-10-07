Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C0BCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D2510EB26;
	Wed,  7 Oct 2026 13:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dKymt0pw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3643E10E20C;
 Wed,  7 Oct 2026 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791381343; x=1822917343;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=AjWufgt/0faSPljdSKXMs5EZ9pIRZhUionClS/nM+Eg=;
 b=dKymt0pwdDK6lD+3boGsYfpnjME5lqvz9HnnkP0gGak7ln0yBTT4A7aU
 jCCpd9SxJg0ck84jB7sQ1jOuHYZODsv6S/hQCoo1CeU2s5SygejtPgZ+k
 ye6BLA2PrtbR8KpL9UcbL4wyZwRFNVrut3kWy/Npg9icvNkt+rZMVIPqD
 sQwEwzv57KQh3z9oe3wtnBBjTRNUnQBFvPbLRgb4UUlI0HeJOZ0GjP8zW
 lRdxZ3tvfmbha22/79DT/r0nF5rkInOCQRI6dJ6tnDSUBIb6Wlen9WdGC
 r+K47EJenMtJWaPCdakPx56PDjM6+IfuHCPLat+LOegRQzbbh1QLq2TJA w==;
X-CSE-ConnectionGUID: FZcJD9miR9SVylXad/EpuA==
X-CSE-MsgGUID: v9htIltHSk2n1qCx8S1OlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="28201"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="28201"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 06:55:39 -0700
X-CSE-ConnectionGUID: QcysvM/vQZiTE+M0W8s2Fw==
X-CSE-MsgGUID: RpTpwojcSvWG5pxAO4H9tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="275230731"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 06:55:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:55:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 06:55:34 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftyntNsxXbKS1Xr0vA7Ou28cYSwsN5XNBIjfgIBJc419gzHNo8kWWaWTCt1H5lbXAN25Zs6iTQ81haB5PuYVGKI5jxHMB1Xq0LQL79X+4W2096BlUVG2R6xpvW0X3hG7SSzvu4SGIwI10w216hFHAPyjCmZCKbltLM6KC/IIR/vOc5OoNQ5cHpZpqfncBE3sjXxofxP/mfjM12pua8U7gfClAT3WFbUkUywNl0gNWHRXrOj7lOSgMQIifa1mnxvM8ZGgOBF3eeBrrqyxyf7p3MzrurHtAi868HIqU1DamaIcFxX9s/Dk5DEWoJWCozuKDuIF2K4rJdcfPPpZHM8Kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrcF9uJPTJLxqGVUc8Q+0W5tu0BKm63/NfHVk7XZ44o=;
 b=N3nra2aKYJlYigJaFI4LGJVqzdV7CJ5el+wve3pozR4u3zqsA3wXcadWUQ2mkmqqiDBrI8xbJmOUcuUHQjzemWglzjwlHK6aEt9PjNSxYnfU32AkV1F2T3ZqFAZCZOb4bMzreL9LlURoY0nmRdNx1aGjsewNy9LZlzVaOVT3vncMNx6isYl576vXvkHno1FMfBULQ+3bGuFGDH70m+MWBu/CRtXGEMVdpz0dRBweFpaEaoo0i2nfWJJhe5EZpz1nSlDCJ+lj/xeyODiYaPYL4Mk18hbSLAr2mbpbrbCOcCH6prwfwmoHOpImWzKeoZho9jx4AGI3IXMjt2oFGTYERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by SA3PR11MB318319.namprd11.prod.outlook.com (2603:10b6:806:588::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 13:55:31 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 13:55:31 +0000
Date: Wed, 7 Oct 2026 09:55:10 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <tejas.upadhyay@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <riana.tauro@intel.com>,
 <raag.jadav@intel.com>, <joshua.santosh.ranjan@intel.com>,
 <ashwin.kumar.kulkarni@intel.com>, <pratik.bari@intel.com>,
 <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <jinzhou.su@amd.com>, <cesun102@amd.com>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
Message-ID: <asZPPlQBsXtuTVNB@intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
 <4bafcf67-c10e-4083-8ded-3275466f5de2@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bafcf67-c10e-4083-8ded-3275466f5de2@amd.com>
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|SA3PR11MB318319:EE_
X-MS-Office365-Filtering-Correlation-Id: a74126c4-83f1-4a36-d01f-08df247aa656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|260925021911599003|260925021311599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: gM29QAqQ4cS9wX2c2OtD+MzhTQ4dA81+PFy3O9+FU9QRwwwTXvdo1gKVqby/IGdNLngLNif3brntGRKaGN0QRw0ogb7VvqEzcWRbUY7auoGGer00QBd2OPprgm9dPpISDanc7n407zY8z5KKZM7e3PP44YVnTpyCQBHB5C7X/dCXmRRoR6a28OJLKx0nHgUSfC50BEwv9EBLsZUjbHQWM0k5/GQj0C0b4SwHfSGdWyiMyf8ZHchYN8Vk7GK/iapqi4wrxLHese4/LW0otN1QltDPj8Vgh6NlXugXIWd3sNi0aedBO4e36oRBG/XsVK8D/63ruxhOzcmcZgNOKgVOJ9CHzq4PionlYvJ2r/e3ixsFefZRkNTJxa2zaIIJoS0is/7evflqcFywfFGYIasWl3KgvSHh3IZ1TdooTzkc+wo4cxlfttQDum7dC9wed+bIVJQm2L5UHhsb5jqn+I3fgSnW8GMWQDP1w36XgZf/9EJLfV22E9YYDUg/9wtHAbmYJDpL3wrqa4yujWYWETtACjPkrz/uWrj8pwWE8zzygoiFaiznJeI/ekkO7VIIM28pOns3hckdIRPK/6jVHkAgJxja+/VJaQTwNrQJ7INknXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/9JPkQ8Rc9BaxrrIeWVmrvrK9KtCMdIFzjQzIxCL7mefBGbQ9f+KZK+CBr?=
 =?iso-8859-1?Q?meLTZPXZGHSP42MhTesRHPUvc26Mi2h5VePq1btxN0+XNpCr8ZoUBIjbRb?=
 =?iso-8859-1?Q?GumNY/Juh/ELBP11mkeCadhAkAMZ83Gz10gC6Ay618TkeQM3R8bQPAq9MW?=
 =?iso-8859-1?Q?TMk4OO6efYNSGhPkfoIm00BDx/Q7Ee7drBN0ELYmTTG12x1k3IMiBiSQ8E?=
 =?iso-8859-1?Q?rYDXa7jlfNAH1evKR3rEmf/UeRzP08oYU2ei2kNdqWCdPpb/Q1urx8FV04?=
 =?iso-8859-1?Q?Moa87txRT9/wMHM3VwkwQFjm76aZrQsrhuuAwtwH0H5JLNP2l8PZUOsPtW?=
 =?iso-8859-1?Q?PL7roNdk6eAdIadgQP8awJ6qeu2SBRWTy8gOBP9asZDDp/6o4Jxje46j6B?=
 =?iso-8859-1?Q?R9hpKjssWEsaACwZoWjHRrcuf730QZg+adHiQTzt5dvsLAnVob2UuGSRXi?=
 =?iso-8859-1?Q?D+T1eAT2D12HqCwPQITVSDILEHkZKNeR5MpITOJMGaymJsQBfFEFPGUSro?=
 =?iso-8859-1?Q?IotYMQFLVxvN33HgafNMGPL+abGl+rXyzWBekwn+Zn8/rOGX6mIlBd1kWl?=
 =?iso-8859-1?Q?5EmsmML6dl17/f5aW3zLM2Ij9Ct0kBz/yB8Efs4nYSpVqvn2knhuIHKlgm?=
 =?iso-8859-1?Q?naXV3H/e3FJW4x/aPkuscts/yBuUmCWMXTANRlPfWJJRH8n3W6vtW0Sq7T?=
 =?iso-8859-1?Q?Z3p5PavDi/cw71P2q3P20SP3PpJzeusHeKaq8TBB8xnmZzurSZSeGc5tgL?=
 =?iso-8859-1?Q?L3iUkSbw/M0bc2wv3IRERm0xFCJACY0j3o7+qdMk7HPuCmF0r018wabJsC?=
 =?iso-8859-1?Q?yaeMU9quDmUXdr7wjFVD7/3G5++v2ZCyn352g5dBTa8bg3KIpzYv0ndF3+?=
 =?iso-8859-1?Q?8Uo32ctnX2Zw/kwW04qMSJGu6ORgzuULFmRDLVGbIGIGza5tp/id1oakDs?=
 =?iso-8859-1?Q?7JD+RFYF8h8gCaseXF2+uCIj5ZFk5dZo2lJRtnqxjxmvl5SEyMohRUvA5I?=
 =?iso-8859-1?Q?7R+H5m8TaitINvO9ilXxtT+VIjfJgGdtfNXlIm7WLCIiy6n0PIWzNR05ml?=
 =?iso-8859-1?Q?C8F0kq/FWiFPgDYJB1s7/csoNjX2oxfVKl8498M1cQY4RYoo3lSGe2p7Sd?=
 =?iso-8859-1?Q?BIgKmHpWOtNmqpxFq0kgtPBWfCOQBXzoQ0EaUOg00iqaDfwQEG+gMsBw09?=
 =?iso-8859-1?Q?Ml+MBAerLECs2doruRO2Z7/SAeeV6NlTvwkj/PvI7rsJOvuiitWdVFc7nu?=
 =?iso-8859-1?Q?BvZliw3DLJjCsgEihsR0YH1HuLf+qO1pxx4Sv+bKU1IXyl7hSFOmY72fwb?=
 =?iso-8859-1?Q?n9jyNQSS7L3R1bRa5w9xkOGCzHa68gcWYkDZMsgmbkwb0IELQCBas4pFou?=
 =?iso-8859-1?Q?QnTZkgNx8+DM2lpCKQhmNg2GoNue/Zd8CwOyPostRSrMAddDc4reWYdtpG?=
 =?iso-8859-1?Q?y7MneciavBe1zeF2pbS9s+se9hmE+C07gT5DdTh4gN34lRwVJZVmU4u0cw?=
 =?iso-8859-1?Q?mlT5VSvim6SlLbsL6zsj59kxASfECs9nCGZ+FoCBix9Hp0+0Hyf4RoB8/B?=
 =?iso-8859-1?Q?zzZEbHveSnDnSX7KfQE5R8Rqq6W2ymRm++uWTB1bN5NcxGZEFqzlDjZR2L?=
 =?iso-8859-1?Q?+YwGDobSsrIJ8/K0oSqBe3aBfxr4BzLlt8ftnx45Atb2B1e7/xyM71Jghp?=
 =?iso-8859-1?Q?WKdfo6jsqIUpmStveqVYb4Dq9be9nGODuO6h8bmPI9HWjbiUcnCRfoslcE?=
 =?iso-8859-1?Q?UN1ft9RDD+/tws8iJ+WkjlhVSkhf2ZOULIzxiqomLwOYhPVZxd74yDoe4d?=
 =?iso-8859-1?Q?kH7T+q1FTG7PCHr5Mp0OQflwSs4W64s=3D?=
X-Exchange-RoutingPolicyChecked: ASGQInSLHUjPqh5H12IPQE7LMYnpx/T35qHxXVrU5ri4OcORnMxK1ILXIsuqeIbtFvC0ZudxrW+ivdZPjRqcyFt1m3+iOb84WyibdVaPhOKUCAhno0oufh/+U7JrbFr/6Sa39kFl7c6I3ZSlDDc5p4xnRXOno59QIOvvwYptJL69qtIelr9MBAwNXHH1ARDfs8JS2UtRqLHqp0Z50jzZENouEkKnA3iMGpm1C9h8f8iVdOcBr9mKbAicfLtAiGEAEqlA4ZJjzn9MHa2Eh81b+nUdzH7J68CzD6nU9dLyNzRaLkn2OyUJNWUrHcGygTmQO9m4y+HQwRAX4sAKE5UZ5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a74126c4-83f1-4a36-d01f-08df247aa656
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:55:31.4314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs4e5SHQV8J9JcJGSuVy9fceeYpEntAQEotSNEJ+sCR3WGt/bjLgmWGTfBr51+Z+YrUgB9jgkPcktUOk2Ke/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB318319
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

On Wed, Oct 07, 2026 at 11:28:03AM +0200, Christian König wrote:
> On 10/7/26 10:03, Aravind Iddamsetty wrote:
> > The memory page offlining support tracks bad VRAM pages and currently
> > only exposes them through debugfs (vram_bad_pages), which is not a
> > stable ABI. Add a proper userspace interface using the drm-ras
> > generic netlink family.
> 
> Oh, why in the world are you using netlink for that?

Well, that came from a rough consensus at LPC BoF 4 years ago:
https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html

And a series of news and patches that evolved through these years:
https://lwn.net/Articles/947134/

> 
> In almost all cases (except maybe udev) using netlink has proven to be a bad idea.

I honestly understand you very much.
When Intel used gen netlink for PVC's iaf/xe-link fabric I tried to push back
(back in 2018, or 2019 iirc)

When I saw this netlink conclusions and first patches I also didn't like it much
but I was in a kind of disagree and commit mode.

But as I had to jump in to help with the review and refactoring, I noticed the
bit netlink refactor during these years and the yaml declaration, generation
and tooling and I started liking it.

> 
> Why aren't RAS errors just exposed through sysfs and/or udev?

Well, I honestly never liked the sysfs for the errors anyway, this is the main
reason I was in the disagree and commit mode. I didn't have anything better to
offer.

sysfs for error reporting is a horrible choice. It gets polluted and messed
pretty quickly. It is also not an interface that you can use alone, you
immediately need an alternative for reporting up like uevents. So, you end
up with errors declared in multiple places, filesystem and file names that
are messed, ugly.

But that we are talking for error only. We have several other needs.
Like this new case of the memory page offline. Our first attempt was
the sysfs for this case as well. But sysfs rules forbids multiple values
in a single file. I know, there are some cases doing it, but they are
running against sysfs rules of 1 file - 1 entry.

So, sysfs cannot provide a interface where you need multiple information
in a race free manner. So, I don't see another good alternative for
this memory page offline, but I would be glad to hear suggestions.

Thanks,
Rodrigo.

> 
> Regards,
> Christian.
> 
> > 
> > Introduce a new node type DRM_RAS_NODE_TYPE_RETIRED_RESOURCES which
> > enumerates hardware resources that have been permanently taken out of
> > service. Each node reports a single resource type, identified by its
> > node-name, so the resource type is implied by the node rather than
> > carried per entry. The per-entry payload stays extensible: each entry
> > carries a single type-specific nested attribute, so future resource
> > types can be added without touching existing consumers. VRAM pages are
> > the first supported type, reported via the vram-page nest as
> > {address, size, status} where status is one of retired/pending/failed.
> > 
> > A single operation is added on the node:
> >  - GET_RETIRED_RESOURCES: dump the resources retired on the node. The
> >    dump opens with a leading capacity summary entry (max-pages
> >    inside the vram-page nest, i.e. the maximum number of pages that
> >    can be offlined, with no address/size/status), followed by one
> >    entry per retired resource. Userspace derives the retired/queued
> >    counts by counting entries.
> > 
> > The netlink interface is described by the YAML spec
> > Documentation/netlink/specs/drm_ras.yaml. The following files are
> > generated from that spec with tools/net/ynl/ynl-regen.sh and must not
> > be edited by hand:
> >  - include/uapi/drm/drm_ras.h        (uapi attribute/command enums)
> >  - drivers/gpu/drm/drm_ras_nl.c      (generated policy and op table)
> >  - drivers/gpu/drm/drm_ras_nl.h      (generated declarations)
> > 
> > Eg:
> > $ sudo ./tools/net/ynl/pyynl/cli.py \
> >      --spec Documentation/netlink/specs/drm_ras.yaml \
> >      --dump list-nodes
> > 
> > [{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name':'correctable-errors',
> >  'node-type': 'error-counter'},
> >  {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name':'uncorrectable-errors
> > ', 'node-type': 'error-counter'},
> >  {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name':'vram-retired-pages',
> >  'node-type': 'retired-resources'}]
> > 
> > $ sudo ./tools/net/ynl/pyynl/cli.py --spec \
> > Documentation/netlink/specs/drm_ras.yaml  --dump  get-retired-resources \
> > --json '{"node-id": 2}'
> > 
> > [{'node-id': 2, 'vram-page': {'max-pages': 100}},
> >  {'node-id': 2, 'vram-page': {'address': 12807041024, 'size': 4096,
> >  'status': 'retired'}},
> >  {'node-id': 2, 'vram-page': {'address': 12809400320, 'size': 4096,
> >  'status': 'retired'}}]
> > 
> > The first entry is the capacity summary (max-pages); subsequent entries
> > are the retired pages.
> > 
> > v2:
> >  - Drop the per-entry resource-type discriminator attribute; the type is
> >    now implied by the node (node-name), which reports a single type.
> >  - Fold all VRAM-page fields, including the retirement status, into the
> >    vram-page nested attribute; the top-level entry is just
> >    {node-id, vram-page}. (Rodrigo)
> >  - Drop the separate GET_RETIRED_RESOURCES_INFO operation. The capacity
> >    (max-pages) is now emitted as a leading summary entry inside
> >    GET_RETIRED_RESOURCES (max-pages in the vram-page nest, no status);
> >    offlined/queued counts are derived by counting entries.
> > 
> > Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Riana Tauro <riana.tauro@intel.com>
> > Cc: Raag Jadav <raag.jadav@intel.com>
> > Cc: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>
> > Cc: Ashwin Kumar Kulkarni <ashwin.kumar.kulkarni@intel.com>
> > Cc: Pratik Bari <pratik.bari@intel.com>
> > 
> > Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > Assisted-by: Copilot:claude-opus-4.8
> > ---
> >  Documentation/netlink/specs/drm_ras.yaml |  91 +++++++++++-
> >  drivers/gpu/drm/drm_ras.c                | 174 ++++++++++++++++++++++-
> >  drivers/gpu/drm/drm_ras_nl.c             |  12 ++
> >  drivers/gpu/drm/drm_ras_nl.h             |   2 +
> >  drivers/gpu/drm/xe/xe_drm_ras.c          |  77 ++++++++++
> >  drivers/gpu/drm/xe/xe_drm_ras_types.h    |   3 +
> >  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     | 119 ++++++++++++++++
> >  drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   3 +
> >  include/drm/drm_ras.h                    |  74 ++++++++++
> >  include/uapi/drm/drm_ras.h               |  48 ++++++-
> >  10 files changed, 592 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index 4c2ac9a1ba3f..42ab1cceaea7 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -16,11 +16,34 @@ definitions:
> >      type: enum
> >      name: node-type
> >      value-start: 1
> > -    entries: [error-counter]
> > +    entries: [error-counter, retired-resources]
> >      doc: >-
> > -         Type of the node. Currently, only error-counter nodes are
> > -         supported, which expose reliability counters for a hardware/software
> > -         component.
> > +         Type of the node.
> > +         error-counter nodes expose reliability counters for a
> > +         hardware/software component. retired-resources nodes enumerate
> > +         hardware resources (e.g. VRAM pages) that have been permanently
> > +         taken out of service.
> > +  -
> > +    type: enum
> > +    name: retired-resource-status
> > +    value-start: 0
> > +    entries: [retired, pending, failed]
> > +    doc: >-
> > +         Status of a retired resource entry. retired means the resource is
> > +         permanently reserved and out of service; pending means retirement is
> > +         queued but the reservation is not yet complete; failed means the
> > +         reservation failed and the resource may still be in use.
> > +  -
> > +    type: enum
> > +    name: retired-resource-type
> > +    value-start: 1
> > +    entries: [vram-page]
> > +    doc: >-
> > +         Type of a retired resource entry. The type selects which type-specific
> > +         nested attribute is present. New hardware resource types can be added
> > +         here, each carrying its own nested attribute set, without affecting
> > +         existing types. vram-page describes a VRAM page by device address and
> > +         size.
> >  
> >  attribute-sets:
> >    -
> > @@ -100,6 +123,45 @@ attribute-sets:
> >          name: error-value
> >          type: u32
> >          doc: Current value of the error counter.
> > +  -
> > +    name: retired-resource-attrs
> > +    attributes:
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: Node ID targeted by this retired resource operation.
> > +      -
> > +        name: vram-page
> > +        type: nest
> > +        nested-attributes: vram-page-attrs
> > +        doc: >-
> > +             Type-specific payload. The resource type is identified by the
> > +             node (its node-name); each node reports a single resource type.
> > +  -
> > +    name: vram-page-attrs
> > +    attributes:
> > +      -
> > +        name: address
> > +        type: u64
> > +        doc: Device address of the retired VRAM page (e.g. DPA).
> > +      -
> > +        name: size
> > +        type: u64
> > +        doc: Size of the retired VRAM page in bytes.
> > +      -
> > +        name: max-pages
> > +        type: u32
> > +        doc: >-
> > +             Maximum VRAM pages that can be retired. Present only in the
> > +             leading summary entry of the dump (no address/size/status).
> > +      -
> > +        name: status
> > +        type: u32
> > +        doc: Retirement status of the retired VRAM page.
> > +        enum: retired-resource-status
> > +      -
> > +        name: pad
> > +        type: pad
> >  
> >  operations:
> >    list:
> > @@ -199,6 +261,27 @@ operations:
> >              - node-id
> >              - error-id
> >              - error-threshold
> > +    -
> > +      name: get-retired-resources
> > +      doc: >-
> > +           Enumerate the resources (e.g. VRAM pages) that a retired-resources
> > +           node has taken out of service. The dump begins with a leading
> > +           capacity summary entry (max-pages, with no address/size/status),
> > +           followed by one entry per retired resource (address, size and a
> > +           retirement status). The resource type is identified by the node
> > +           (its node-name); each node reports a single type. User space
> > +           derives the retired/queued counts by counting entries, and must
> > +           obtain the node ID from list-nodes first.
> > +      attribute-set: retired-resource-attrs
> > +      flags: [admin-perm]
> > +      dump:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes:
> > +            - node-id
> > +            - vram-page
> >  
> >  mcast-groups:
> >    list:
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index b099eb67836e..46ee897a13c9 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -63,7 +63,6 @@
> >   * Node type:
> >   *
> >   * - ERROR_COUNTER:
> > - *     + Currently, only error counters are supported.
> >   *     + The driver must implement the query_error_counter() callback to provide
> >   *       the name and the value of the error counter.
> >   *     + The driver must provide a error_counter_range.last value informing the
> > @@ -81,6 +80,13 @@
> >   *       that are raised by the hardware.
> >   *     + The driver is responsible for error threshold bounds checking.
> >   *
> > + * - RETIRED_RESOURCES:
> > + *     + Enumerates hardware resources (e.g. VRAM pages) permanently taken out
> > + *       of service.
> > + *     + The driver must implement the query_retired_resource() callback, which
> > + *       is called with an incrementing index and returns -ENOENT once the last
> > + *       entry has been reported.
> > + *
> >   * Netlink handlers:
> >   *
> >   * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> > @@ -95,6 +101,9 @@
> >   *   operation, fetching the error threshold of a specific counter.
> >   * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> >   *   operation, setting the error threshold of a specific counter.
> > + * - drm_ras_nl_get_retired_resources_dumpit(): Implements the
> > + *   GET_RETIRED_RESOURCES dumpit operation, enumerating retired resources of a
> > + *   specific node.
> >   */
> >  
> >  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > @@ -105,6 +114,10 @@ static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> >  struct drm_ras_ctx {
> >  	/* Which xarray id to restart the dump from */
> >  	unsigned long restart;
> > +	/* Ordering-key cursor for retired-resource dumps (inclusive lower bound) */
> > +	u64 cursor;
> > +	/* Whether the leading retired-resource summary has been emitted */
> > +	bool summary_sent;
> >  };
> >  
> >  /**
> > @@ -564,6 +577,148 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >  	return node->clear_error_counter(node, error_id);
> >  }
> >  
> > +static int msg_put_retired_resource(struct sk_buff *skb, u32 node_id,
> > +				    const struct drm_ras_retired_resource *res)
> > +{
> > +	struct nlattr *nest;
> > +
> > +	if (nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID, node_id))
> > +		return -EMSGSIZE;
> > +
> > +	/* Type is implied by the node (its node_name); it selects the nest. */
> > +	switch (res->type) {
> > +	case DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE:
> > +		nest = nla_nest_start(skb,
> > +				      DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE);
> > +		if (!nest)
> > +			return -EMSGSIZE;
> > +
> > +		if (res->is_summary) {
> > +			/* Leading capacity summary: max retirable pages. */
> > +			if (nla_put_u32(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_MAX_PAGES,
> > +					res->vram_page.max_pages)) {
> > +				nla_nest_cancel(skb, nest);
> > +				return -EMSGSIZE;
> > +			}
> > +		} else if (nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS,
> > +					     res->vram_page.address,
> > +					     DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
> > +			   nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
> > +					     res->vram_page.size,
> > +					     DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
> > +			   nla_put_u32(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_STATUS,
> > +				       res->status)) {
> > +			nla_nest_cancel(skb, nest);
> > +			return -EMSGSIZE;
> > +		}
> > +
> > +		nla_nest_end(skb, nest);
> > +		break;
> > +	default:
> > +		/* Unknown type: only the common node-id is reported. */
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * drm_ras_nl_get_retired_resources_dumpit() - Dump retired resources of a node
> > + * @skb: Netlink message buffer
> > + * @cb: Callback context for multi-part dumps
> > + *
> > + * Iterates over all retired resources of a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES
> > + * node and appends their attributes to the given netlink message buffer. The
> > + * dump opens with an optional leading type-specific capacity summary (e.g. the
> > + * maximum retirable page count), followed by one entry per retired resource;
> > + * each resource entry carries a status plus one type-specific nested attribute
> > + * selected by the node's type. Uses @cb->ctx to store an ordering-key cursor
> > + * so multi-part dumps resume by key rather than position, staying correct if
> > + * the list changes concurrently between message parts.
> > + *
> > + * Return: 0 if all entries fit in @skb, number of bytes added to @skb if
> > + *          the buffer filled up (requires multi-part continuation), or
> > + *          a negative error code on failure.
> > + */
> > +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> > +					    struct netlink_callback *cb)
> > +{
> > +	const struct genl_info *info = genl_info_dump(cb);
> > +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> > +	struct drm_ras_retired_resource res;
> > +	struct drm_ras_node *node;
> > +	struct nlattr *hdr;
> > +	u32 node_id;
> > +	u64 cursor;
> > +	int ret = 0;
> > +
> > +	if (!info->attrs ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID]);
> > +
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_RESOURCES ||
> > +	    !node->query_retired_resource)
> > +		return -ENOENT;
> > +
> > +	/* Leading type-specific capacity summary (e.g. max pages), emitted once. */
> > +	if (!ctx->summary_sent && node->query_retired_summary) {
> > +		memset(&res, 0, sizeof(res));
> > +		ret = node->query_retired_summary(node, &res);
> > +		if (ret == 0) {
> > +			hdr = genlmsg_iput(skb, info);
> > +			if (!hdr)
> > +				return -EMSGSIZE;   /* retry summary next part */
> > +			ret = msg_put_retired_resource(skb, node_id, &res);
> > +			if (ret) {
> > +				genlmsg_cancel(skb, hdr);
> > +				return ret;
> > +			}
> > +			genlmsg_end(skb, hdr);
> > +		} else if (ret != -ENOENT) {
> > +			return ret;
> > +		}
> > +		ctx->summary_sent = true;
> > +	}
> > +
> > +	cursor = ctx->cursor;
> > +	for (;;) {
> > +		memset(&res, 0, sizeof(res));
> > +		ret = node->query_retired_resource(node, cursor, &res);
> > +		/* -ENOENT marks the end of the list. */
> > +		if (ret == -ENOENT) {
> > +			ret = 0;
> > +			break;
> > +		}
> > +		if (ret)
> > +			return ret;
> > +
> > +		hdr = genlmsg_iput(skb, info);
> > +		if (!hdr) {
> > +			ret = -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		ret = msg_put_retired_resource(skb, node_id, &res);
> > +		if (ret) {
> > +			genlmsg_cancel(skb, hdr);
> > +			break;
> > +		}
> > +
> > +		genlmsg_end(skb, hdr);
> > +		/* Advance past this entry; keys are unique. */
> > +		cursor = res.key + 1;
> > +	}
> > +
> > +	/* On buffer-full the current entry was not emitted; resume at it. */
> > +	if (ret == -EMSGSIZE)
> > +		ctx->cursor = cursor;
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> >   * @skb: Netlink message buffer
> > @@ -631,15 +786,24 @@ int drm_ras_node_register(struct drm_ras_node *node)
> >  	if (!node->device_name || !node->node_name)
> >  		return -EINVAL;
> >  
> > -	/* Currently, only Error Counter Endpoints are supported */
> > -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> > -		return -EINVAL;
> > -
> >  	/* Mandatory entries for Error Counter Node */
> >  	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
> >  	    (!node->error_counter_range.last || !node->query_error_counter))
> >  		return -EINVAL;
> >  
> > +	/* Mandatory entries for Retired Resources Node */
> > +	if (node->type == DRM_RAS_NODE_TYPE_RETIRED_RESOURCES &&
> > +	    !node->query_retired_resource)
> > +		return -EINVAL;
> > +
> > +	switch (node->type) {
> > +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> > +	case DRM_RAS_NODE_TYPE_RETIRED_RESOURCES:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> >  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
> >  }
> >  EXPORT_SYMBOL(drm_ras_node_register);
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index c9f5e0ceb3b5..2f23f5681fa4 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -41,6 +41,11 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
> >  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> >  };
> >  
> > +/* DRM_RAS_CMD_GET_RETIRED_RESOURCES - dump */
> > +static const struct nla_policy drm_ras_get_retired_resources_nl_policy[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID + 1] = {
> > +	[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +};
> > +
> >  /* Ops table for drm_ras */
> >  static const struct genl_split_ops drm_ras_nl_ops[] = {
> >  	{
> > @@ -83,6 +88,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> >  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> >  	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_RESOURCES,
> > +		.dumpit		= drm_ras_nl_get_retired_resources_dumpit,
> > +		.policy		= drm_ras_get_retired_resources_nl_policy,
> > +		.maxattr	= DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> > +	},
> >  };
> >  
> >  static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index 9aef097ea10f..96b0fe017ea8 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -24,6 +24,8 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> >  					struct genl_info *info);
> >  int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> >  					struct genl_info *info);
> > +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> > +					    struct netlink_callback *cb);
> >  
> >  enum {
> >  	DRM_RAS_NLGRP_ERROR_REPORT,
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> > index 7f3695707611..fba58e9eb7e0 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> > @@ -12,6 +12,7 @@
> >  #include "xe_device_types.h"
> >  #include "xe_drm_ras.h"
> >  #include "xe_ras.h"
> > +#include "xe_ttm_vram_mgr.h"
> >  
> >  static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
> >  static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
> > @@ -188,6 +189,75 @@ static void cleanup_node(struct drm_device *drm, void *node)
> >  	cleanup_node_param(node);
> >  }
> >  
> > +static int query_retired_resource(struct drm_ras_node *node, u64 cursor,
> > +				  struct drm_ras_retired_resource *res)
> > +{
> > +	struct xe_device *xe = node->priv;
> > +	int ret;
> > +
> > +	ret = xe_ttm_vram_get_retired_page(xe, cursor, &res->vram_page.address,
> > +					   &res->vram_page.size, &res->status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
> > +	res->key = res->vram_page.address;
> > +
> > +	return 0;
> > +}
> > +
> > +static int query_retired_summary(struct drm_ras_node *node,
> > +				 struct drm_ras_retired_resource *res)
> > +{
> > +	struct xe_device *xe = node->priv;
> > +
> > +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
> > +	res->is_summary = 1;
> > +	res->vram_page.max_pages = xe_ttm_vram_get_max_bad_pages(xe);
> > +
> > +	return 0;
> > +}
> > +
> > +static int register_retired_node(struct xe_device *xe)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> > +	struct xe_drm_ras *ras = &xe->ras;
> > +	struct drm_ras_node *node;
> > +	const char *device_name;
> > +	int ret;
> > +
> > +	/* Retired VRAM pages are only tracked on platforms with page offline */
> > +	if (xe->info.platform != XE_CRESCENTISLAND)
> > +		return 0;
> > +
> > +	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
> > +	if (!node)
> > +		return -ENOMEM;
> > +
> > +	device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
> > +				pci_domain_nr(pdev->bus), pdev->bus->number,
> > +				PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> > +	if (!device_name)
> > +		return -ENOMEM;
> > +
> > +	node->device_name = device_name;
> > +	node->node_name = "vram-retired-pages";
> > +	node->type = DRM_RAS_NODE_TYPE_RETIRED_RESOURCES;
> > +	node->query_retired_resource = query_retired_resource;
> > +	node->query_retired_summary = query_retired_summary;
> > +	node->priv = xe;
> > +
> > +	ret = drm_ras_node_register(node);
> > +	if (ret) {
> > +		cleanup_node_param(node);
> > +		return ret;
> > +	}
> > +
> > +	ras->retired_node = node;
> > +
> > +	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> > +}
> > +
> >  static int register_nodes(struct xe_device *xe)
> >  {
> >  	struct xe_drm_ras *ras = &xe->ras;
> > @@ -279,5 +349,12 @@ int xe_drm_ras_init(struct xe_device *xe)
> >  		return err;
> >  	}
> >  
> > +	err = register_retired_node(xe);
> > +	if (err) {
> > +		drm_err(&xe->drm, "Failed to register DRM RAS retired node (%pe)\n",
> > +			ERR_PTR(err));
> > +		return err;
> > +	}
> > +
> >  	return 0;
> >  }
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras_types.h b/drivers/gpu/drm/xe/xe_drm_ras_types.h
> > index 0be218ba2db7..186024640f87 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras_types.h
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras_types.h
> > @@ -41,6 +41,9 @@ struct xe_drm_ras {
> >  	/** @node: DRM RAS node */
> >  	struct drm_ras_node *node;
> >  
> > +	/** @retired_node: DRM RAS retired-resources node for VRAM bad pages */
> > +	struct drm_ras_node *retired_node;
> > +
> >  	/** @info: info array for all types of errors */
> >  	struct xe_drm_ras_counter *info[DRM_XE_RAS_ERR_SEV_MAX];
> >  
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > index 9a514d983e90..b56b543a56a2 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > @@ -15,6 +15,8 @@
> >  #include <drm/ttm/ttm_placement.h>
> >  #include <drm/ttm/ttm_range_manager.h>
> >  
> > +#include <uapi/drm/drm_ras.h>
> > +
> >  #include "regs/xe_regs.h"
> >  #include "xe_bo.h"
> >  #include "xe_configfs.h"
> > @@ -624,6 +626,123 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
> >  	return avail;
> >  }
> >  
> > +/**
> > + * xe_ttm_vram_get_retired_page - Fetch the next retired VRAM page by address
> > + * @xe: xe device instance
> > + * @min_addr: inclusive lower bound; return the page with the smallest DPA >=
> > + *            this value
> > + * @addr: output, device physical address (DPA) of the page
> > + * @size: output, size of the page in bytes
> > + * @status: output, retirement status (enum drm_ras_retired_resource_status)
> > + *
> > + * Scans the offlined and queued page lists across all tiles and returns the
> > + * entry with the smallest DPA that is >= @min_addr. Because retired pages have
> > + * unique addresses, iterating with @min_addr = previous_addr + 1 walks every
> > + * entry in a stable address order, which is robust against concurrent
> > + * insertion or removal between calls. Intended to back the drm-ras
> > + * retired-resources node enumeration.
> > + *
> > + * Return: 0 on success, -ENOENT when no page has a DPA >= @min_addr.
> > + */
> > +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> > +				 u64 *addr, u64 *size, u32 *status)
> > +{
> > +	struct xe_ttm_vram_offline_resource *pos;
> > +	struct ttm_resource_manager *man;
> > +	struct gpu_buddy_block *block;
> > +	struct xe_ttm_vram_mgr *mgr;
> > +	u64 best_addr = 0, best_size = 0;
> > +	struct xe_tile *tile;
> > +	u32 best_status = 0;
> > +	bool found = false;
> > +	u8 id;
> > +
> > +	for_each_tile(tile, xe, id) {
> > +		struct xe_vram_region *vr = tile->mem.vram;
> > +		u64 a, s;
> > +
> > +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> > +		if (!man || !vr)
> > +			continue;
> > +		mgr = to_xe_ttm_vram_mgr(man);
> > +
> > +		rcu_read_lock();
> > +
> > +		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {
> > +			block = list_first_entry_or_null(&pos->blocks,
> > +							 struct gpu_buddy_block, link);
> > +			if (block) {
> > +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
> > +				s = gpu_buddy_block_size(&mgr->mm, block);
> > +			} else {
> > +				a = pos->addr + vr->dpa_base;
> > +				s = SZ_4K;
> > +			}
> > +
> > +			if (a >= min_addr && (!found || a < best_addr)) {
> > +				best_addr = a;
> > +				best_size = s;
> > +				best_status = DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED;
> > +				found = true;
> > +			}
> > +		}
> > +
> > +		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
> > +			block = list_first_entry_or_null(&pos->blocks,
> > +							 struct gpu_buddy_block, link);
> > +			if (block) {
> > +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
> > +				s = gpu_buddy_block_size(&mgr->mm, block);
> > +			} else {
> > +				a = pos->addr + vr->dpa_base;
> > +				s = SZ_4K;
> > +			}
> > +
> > +			if (a >= min_addr && (!found || a < best_addr)) {
> > +				best_addr = a;
> > +				best_size = s;
> > +				best_status = pos->status == XE_PAGE_RESERVE_FAIL ?
> > +					      DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED :
> > +					      DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING;
> > +				found = true;
> > +			}
> > +		}
> > +
> > +		rcu_read_unlock();
> > +	}
> > +
> > +	if (!found)
> > +		return -ENOENT;
> > +
> > +	*addr = best_addr;
> > +	*size = best_size;
> > +	*status = best_status;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xe_ttm_vram_get_max_bad_pages - Fetch the FW-provided max offline page count
> > + * @xe: xe device instance
> > + *
> > + * Returns the static maximum number of VRAM pages that can be offlined, as
> > + * provided by FW at init. Intended to back the drm-ras retired-resources
> > + * capacity summary. Read from the root (VRAM0) manager; the value is a static
> > + * device-wide count.
> > + *
> > + * Return: max offline page count, or 0 if VRAM is not present.
> > + */
> > +u32 xe_ttm_vram_get_max_bad_pages(struct xe_device *xe)
> > +{
> > +	struct ttm_resource_manager *man;
> > +
> > +	man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0);
> > +	if (!man)
> > +		return 0;
> > +
> > +	return to_xe_ttm_vram_mgr(man)->max_pages;
> > +}
> > +
> >  static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
> >  {
> >  	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> > index d77f067d197b..70fae023d6a3 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> > @@ -33,6 +33,9 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
> >  			  u64 *used, u64 *used_visible);
> >  int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
> >  int xe_ttm_vram_inject_fault(struct xe_device *xe);
> > +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> > +				 u64 *addr, u64 *size, u32 *status);
> > +u32 xe_ttm_vram_get_max_bad_pages(struct xe_device *xe);
> >  
> >  static inline struct xe_ttm_vram_mgr_resource *
> >  to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 1765a3130b09..38953f8f3012 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -10,6 +10,42 @@
> >  
> >  #include <uapi/drm/drm_ras.h>
> >  
> > +/**
> > + * struct drm_ras_retired_resource - A single retired resource entry
> > + *
> > + * Describes one hardware resource that has been taken out of service and is
> > + * reported by a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. @type selects which
> > + * member of the anonymous union is valid, allowing new hardware resource types
> > + * to be added without changing the common fields. When @is_summary is set the
> > + * entry is a leading, type-specific capacity summary (e.g. max retirable
> > + * pages) rather than an individual retired resource.
> > + */
> > +struct drm_ras_retired_resource {
> > +	/** @type: Resource type (enum drm_ras_retired_resource_type). */
> > +	__u32 type;
> > +	/** @status: Retirement status (enum drm_ras_retired_resource_status). */
> > +	__u32 status;
> > +	/**
> > +	 * @key: Opaque, driver-assigned ordering key for this entry. drm-ras
> > +	 * uses it only to advance the dump cursor; entries must be enumerable
> > +	 * in strictly increasing @key order and keys must be unique.
> > +	 */
> > +	__u64 key;
> > +	/** @is_summary: entry reports type capacity, not a retired resource. */
> > +	__u8 is_summary;
> > +	union {
> > +		/** @vram_page: Valid when @type is VRAM_PAGE. */
> > +		struct {
> > +			/** @vram_page.address: Device address (e.g. DPA). */
> > +			__u64 address;
> > +			/** @vram_page.size: Size in bytes. */
> > +			__u64 size;
> > +			/** @vram_page.max_pages: max retirable pages; summary only. */
> > +			__u32 max_pages;
> > +		} vram_page;
> > +	};
> > +};
> > +
> >  /**
> >   * struct drm_ras_node - A DRM RAS Node
> >   */
> > @@ -100,6 +136,44 @@ struct drm_ras_node {
> >  	 */
> >  	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> >  
> > +	/**
> > +	 * @query_retired_resource:
> > +	 *
> > +	 * This callback is used by drm-ras to enumerate retired resources of a
> > +	 * %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. It is called with @cursor
> > +	 * and must return the next entry whose ordering key is greater than or
> > +	 * equal to @cursor, setting @res->key to that entry's key. drm-ras
> > +	 * resumes multi-part dumps from the returned key, so enumeration stays
> > +	 * correct across concurrent insertion or removal.
> > +	 *
> > +	 * The @query_retired_resource is a mandatory callback for
> > +	 * retired-resources nodes.
> > +	 *
> > +	 * Returns: 0 on success,
> > +	 *          -ENOENT when no entry has a key >= @cursor, used as an
> > +	 *                  indication that enumeration is complete.
> > +	 *          Other negative values on errors that should terminate the
> > +	 *          netlink query.
> > +	 */
> > +	int (*query_retired_resource)(struct drm_ras_node *node, u64 cursor,
> > +				      struct drm_ras_retired_resource *res);
> > +
> > +	/**
> > +	 * @query_retired_summary:
> > +	 *
> > +	 * This optional callback fills a leading, type-specific capacity summary
> > +	 * for a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node (e.g. the maximum
> > +	 * number of retirable pages). drm-ras emits it as the first entry of the
> > +	 * retired-resources dump. The driver must set @res->is_summary, @res->type
> > +	 * and the type-specific summary fields (e.g. vram_page.max_pages).
> > +	 *
> > +	 * Returns: 0 on success,
> > +	 *          -ENOENT if the node has no summary to report,
> > +	 *          other negative values on errors that terminate the query.
> > +	 */
> > +	int (*query_retired_summary)(struct drm_ras_node *node,
> > +				     struct drm_ras_retired_resource *res);
> > +
> >  	/** @priv: Driver private data */
> >  	void *priv;
> >  };
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 2f832275ee6e..64a7a7feb610 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -11,11 +11,35 @@
> >  #define DRM_RAS_FAMILY_VERSION	1
> >  
> >  /*
> > - * Type of the node. Currently, only error-counter nodes are supported, which
> > - * expose reliability counters for a hardware/software component.
> > + * Type of the node. error-counter nodes expose reliability counters for a
> > + * hardware/software component. retired-resources nodes enumerate hardware
> > + * resources (e.g. VRAM pages) that have been permanently taken out of service.
> >   */
> >  enum drm_ras_node_type {
> >  	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> > +	DRM_RAS_NODE_TYPE_RETIRED_RESOURCES,
> > +};
> > +
> > +/*
> > + * Status of a retired resource entry. retired means the resource is
> > + * permanently reserved and out of service; pending means retirement is queued
> > + * but the reservation is not yet complete; failed means the reservation failed
> > + * and the resource may still be in use.
> > + */
> > +enum drm_ras_retired_resource_status {
> > +	DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED,
> > +	DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING,
> > +	DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED,
> > +};
> > +
> > +/*
> > + * Type of a retired resource entry. The type selects which type-specific
> > + * nested attribute is present. New hardware resource types can be added here,
> > + * each carrying its own nested attribute set, without affecting existing
> > + * types. vram-page describes a VRAM page by device address and size.
> > + */
> > +enum drm_ras_retired_resource_type {
> > +	DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE = 1,
> >  };
> >  
> >  enum {
> > @@ -51,6 +75,25 @@ enum {
> >  	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> >  };
> >  
> > +enum {
> > +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID = 1,
> > +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE,
> > +
> > +	__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX,
> > +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX - 1)
> > +};
> > +
> > +enum {
> > +	DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS = 1,
> > +	DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
> > +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX_PAGES,
> > +	DRM_RAS_A_VRAM_PAGE_ATTRS_STATUS,
> > +	DRM_RAS_A_VRAM_PAGE_ATTRS_PAD,
> > +
> > +	__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX,
> > +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX = (__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX - 1)
> > +};
> > +
> >  enum {
> >  	DRM_RAS_CMD_LIST_NODES = 1,
> >  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > @@ -58,6 +101,7 @@ enum {
> >  	DRM_RAS_CMD_ERROR_EVENT,
> >  	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> >  	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > +	DRM_RAS_CMD_GET_RETIRED_RESOURCES,
> >  
> >  	__DRM_RAS_CMD_MAX,
> >  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> 
