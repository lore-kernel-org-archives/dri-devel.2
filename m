Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303A0C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5FC10EBE7;
	Tue,  4 Aug 2026 21:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ug6nr2PH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD9A10E114;
 Tue,  4 Aug 2026 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785878864; x=1817414864;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1tL3zG6qybDbeEAPkiBIvMItJScwjFGKro/lenxIgQ8=;
 b=Ug6nr2PHJX4/BgPNDHT4ZZ8eOn9eWo/xRa99SVavY0G2b/2SYS0sDcLh
 /47r+OJJpXR9ZH4wqOp1JoiBta6pVX11RgGGFfjMCEFTha3ExFD7zF17e
 /KwTvrcsIg282ZSxRpaEpNg2l53wwfFmuGl9gPl3sCx06MGUzTa+NNsoM
 b6wfXDAeoiiUXzqzMfO839skD+EYnvPFCnYB6j4O/qCtz63rLaNMcgKTJ
 Gn3tZNZBUSQrLYjj+3Jdx+/x0X5BOG6npU9dFBlYOXy4QloN1tS0Kn2q9
 zwWRwrmd2HcTfJZ4/NOvB/QY/QP2bB9N7ASfRom4pZE5jd8Ji3/mByxmp Q==;
X-CSE-ConnectionGUID: H1Lbs49mSeeVNHZzveJG+A==
X-CSE-MsgGUID: NjYirXTJS/O5zUlLtDz/kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86319560"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86319560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:27:43 -0700
X-CSE-ConnectionGUID: kxEABhEsSWy0JmfwRLw3BA==
X-CSE-MsgGUID: f3/BEuYJT7CmXPfYCm/N2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="265116707"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:27:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:27:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 14:27:42 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we8WX/Woo1a4LRTgkuKVGVvaLWLkZiHfGzCaLKZhZHpUY6YS/zg4bEnccfNhM4LIi8boLFiFNmmOIfkLxvUYFrSryseEhNovAB7pDM3IfWTwH9kWdeXEQA/roONonnYXF0x/qqX5aZFQvfvDdaoST4FfBOtrHJZp7wgnG2s7mRTe7CReIdfoKxZpH604zA71MxPh0bq63bU2yqTyP2CU59MsCSuMxreYT3yxKophurN4WGSVKeOnhWyHVmHpUtL5ELEDqOu8ruW+k7mSvlBlGRRBZDuAH/Mmv9WbgiNsp1GJl4NEFBLQNdCc2078gDZScM+7lBvC7U19CTLF802h0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHHthmybSNxaf13gMKXugJaQfzGNIDNEFooP9fvWfnI=;
 b=p9ad/hIQ3Ymfdjxt8onF7rVmNrYSUL9j1/NsXbEcX7+bOqd47nUpHT94gGff7Cr/NYV4Xc72KCez1c7EmYzFxqjvjoFNoPSkiPMiwuSpFbWnzZ0T/KD4steKgeEaqhVkJqj0PULs6syFN3vZoDBT+wSCf2eavy1xO6th9TwLQHlLerc2symsggO92UJjQs9XQnQ15EZF4mCn/4euqdb22F07jWkW2WbQme/opHixRHTrccIMLB/CCpmiyo1ItnRDKYj7VkvuOlKBrwJB2aMxnERh+gqTrUyADXIHCT8MY0LJaTm4uq09/TxlrDa/gACsjY+E++RJclPc+775lovQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8211.namprd11.prod.outlook.com (2603:10b6:610:15f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:27:39 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 21:27:39 +0000
Date: Tue, 4 Aug 2026 14:27:36 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Summers, Stuart" <stuart.summers@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
 "talesam@gmail.com" <talesam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 <julia.filipchuk@intel.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Message-ID: <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92560a-25f9-4f5d-51e6-08def26f35e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|56012099006|3023799007|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: bCSM08iz3jCyzQq0Otq0LRGaZSNsVhzjsDgPW0lLdA+I+zF59gqM5mCxaLoQMBIND5OqRvHWlag1MpxvkIHzfP0AVfcv0+ECeinNfjU9ooE9oM0YC9U6fW0zkv/wcGwRA8N3nd0gqHxvrhWM3Uqph9MolO77AOUaYHqGIB1JUZnap1shFcsUNFprvnfTzPpNxh/RR07whiTkDCBAZ0yLKi2Aro84q7MgDWMuDYlZ9DlzAUOOIVyrnG39XhpBzqeljZMo8d2nNZOAAbVLZ/WrD3e2djN21rCjhQ5VOXl14s/4FNq7F4EDtVB0AqPXHhPUEbiA6qnI6Ybx+rCPShmOeRPDPAneBKSDx3cZV/y/Wj/lcJr8WkPJALh541MzLHqrHEjocwt+KE7M9MfvYovCOlBCe3TV82FQ8Sc1KRuChYSTknBFByHaJi1ntq59D0h5IRc/yYUQQMdGFHhhSa5cP5fEM52TTmW+URoYqV/UWz6MS6LvYJRc3DkAzPmJ7Z/9vJEW5Z2RNKY4N0nz02SKd1PxuI4XjaakeuGS9K5Lvq/cqhy436V/kPRVYC92WpM+V7/4efi5L+yo/27RDTHjZlE4e+AJoP21061Qn0ZebWRFvGOPbHQg2j1Cy5gj+Zu7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(4143699003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5pVsFRhlHGcYW57rg+EWKyx6yjKrra6YsDyj955eRnQQ42frflBw05PDM4?=
 =?iso-8859-1?Q?JfefeG5G4e5MSmI2mwqszUqBrmKfF9+qihNNZvXAcEfklzW1pLsTlTcb9S?=
 =?iso-8859-1?Q?Ki4kVQltCQ6AJOmGjPiBBHJWxfpwatVyZZKGTgNLLQt6W5pndCBHAChNIR?=
 =?iso-8859-1?Q?HApT6OnH5D3zsUSgp6nXLzC1Bu3wx8teU7WfuGzgQLpRlkU87mc/MLlmzh?=
 =?iso-8859-1?Q?uK60R8Qeh0dxaQ/BdU1EdAMAeQzI0gI3lfmK1qXtEVLfNKaAty3by2BdkJ?=
 =?iso-8859-1?Q?Wz5L5NUbXkq0nNKd4xuo5StcfyGP6f0xO4Ysd3uJ+W5wFKd8nbmpwOIkH6?=
 =?iso-8859-1?Q?S+022TEGBr1kGbkqxIMitDzUb3rgSS0JX3rRqfiIIL5Ce1IARjiAp47SJN?=
 =?iso-8859-1?Q?8Zakhxk8pqsZLWTD4rFa/dJ1D1KA/yDyl/oDtr6zkRywB5WuYiLDKR/M/A?=
 =?iso-8859-1?Q?HZDLDPRCu8TOBQVAYkVyNhBiGzGadgCYpdRfx1FEo8lxUf21M2msodRJGM?=
 =?iso-8859-1?Q?DhVwj6XxzG6akYdAufzbxFl1a94v60y03O6Q4Z19Q2UX9TOuhAfn2IpfzA?=
 =?iso-8859-1?Q?4mzOhWUXUKff00R4FRAhT56hNSXmrgDNj3dH9pLMyxtSQNdOAJmakAwZSE?=
 =?iso-8859-1?Q?ZkC3nsjPCgncahe2HOPene0Lj57v//mlyUPcxdZplldHQYy9LiXePcvqIA?=
 =?iso-8859-1?Q?J07jgW+FmFLpeiopFd7797GeaTXyUB40sCD+n1BBdxY7YUcKMYup1vvmdT?=
 =?iso-8859-1?Q?HBHP1H+/7qooEWYOzhvVUvHxrvu0hAXQlGsxvytwli+4ckgF9UsazB8yEp?=
 =?iso-8859-1?Q?Dz+wTGbdvrf+7jtDS3fnmnF2o+8vdV208+CditKJM00Y9prrA7BFHV2mvk?=
 =?iso-8859-1?Q?jxbhfLRGoTM+TuTUZN7czINOcfERt9NkBdajotdesnEPUSiyVUNFIxfT0R?=
 =?iso-8859-1?Q?WKAd7NcVDClpJDd+DjBvF3b1/nGS3fxm4mpL6c1OxORUJukWZATm3sjjKE?=
 =?iso-8859-1?Q?V4jdtC5KAqoBe/6d9BOho3WCcokZ+Kg+kk/cfMDNqTEdRkLKFm+q3IVmNh?=
 =?iso-8859-1?Q?Ag8nSy4Hwj11ER0BGR/So9zYy36UXdm6CBwe9FjOVGmzDkG9AM5WbBABpT?=
 =?iso-8859-1?Q?FVvYNDkYUNAm6NL+VzV1OF908L5/EyLC5Klnlw4JKzglpCD/RgDFZqf3mI?=
 =?iso-8859-1?Q?xy0UORkXIA/B29BAlDLl/2xH/wVqkyAs8HY7UN+KldeInVSMgIdqhl1ejQ?=
 =?iso-8859-1?Q?zoa5w2Pmk0z2JPjfBV8t97dHs1HbCB+tH0HHwlJudEADQDHdWVdC1BThq2?=
 =?iso-8859-1?Q?5r0tYMM0vbqIeDKC5MPmoHCUi8J3oOO9dBW5Q5GsrOb25upCG/xDPbz8zu?=
 =?iso-8859-1?Q?fHVFEDR/DvTU3PSxfsP6Hi6MTxIK7JjKzXhG675lhwXDF5LFZasuQM5IwJ?=
 =?iso-8859-1?Q?F200zdKBrECxAz9BBq4sRBEoolav/Gr2hQPGlXuASOoKYDRYWj1ibXWxev?=
 =?iso-8859-1?Q?iSdYXWYXkG4o86v1mZHHJEqVD72smL/12e6KvkIuuGi+erxTfHszI9W3vY?=
 =?iso-8859-1?Q?IXXSoHW2bZqdaAWpVJCuc7QOFwsVvuvxRefoJxPQsYbch24v6C9Tcod6kA?=
 =?iso-8859-1?Q?m5iw7wTiGF43kpNSvMU+NMvV3x4owVXiAn4yrvxA4uOfASCPzLhln3TivV?=
 =?iso-8859-1?Q?tadflrZBAZBEEDM9PMIDQ3IRdjoM/UeXOgHRyOQedXoA5jpoQq7d1V/X6Z?=
 =?iso-8859-1?Q?L/KDJL/6G1E6QhRbIHZXnUK2LfFgy7HT7HYTFRAj6eXHVjksAPt1Bgt1Oa?=
 =?iso-8859-1?Q?7cbyx4wo7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: pwn+r6Pr1/tjAb59++DBBEyIelm4qNTXGUWRlCusy2RCQ+QgnoXUQ/esISnFnq7ptBbRGEvkNN8E2Tpro7XDtGjc6BGfSD2IAg07G/o3Tg1L+wuWQ+C1qSHaX4wfpoVf8VbJPWefNCJIqejHlvCu8oOqYd6ubmZ8ThbcYMdPibAT2yalXh3jxK+koRb0qYQZyn3sKoxy/YcbpfrmEtlTU5MgNOB3TL9FxJiT+qMljHotn25qV9GTp7U58NS33Lwnj9kmbT2Z09x1tfz669J6ZCc0jz6LHxx2F4YloovdMNxMR98u1P+67VLrph1o9KXSPxFBNgOPEcOypV5VnB7ZMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92560a-25f9-4f5d-51e6-08def26f35e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:27:39.3953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 882FohmRx6a1QipvvYLRXauYy4yfIkGsWymBahCnMchOK3LdRSQAwpSUd6vjWI26Yjoab6A8qG16JLdtZ2NKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8211
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

On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendonça wrote:
> > Hi,
> > 
> > This series is a follow-up to the TLB invalidation ack stall I have
> > been debugging on ARL, tracked in:
> > 
> >   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > 
> > Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 and
> > 7dd1 machines here, plus an independent Arc Pro 130T report on the
> > issue above), TLB invalidation acks intermittently stall for ~2.3s.
> > The H2G request is consumed from the CTB immediately and the G2H CTB
> > is empty the whole time - the firmware simply does not send the ack
> > until much later. The fence timeout fires at 2.25s and the ack lands
> > tens of ms after it. Userspace blocked on the invalidation
> > (compositor
> > buffer unmaps etc.) hitches for the full window.
> 
> Firstly, thanks for the patch!
> 
> I haven't looked in to all the details of the sighting you were
> debugging, but we have had similar issues that were fixed in a later
> GuC version. I think around 70.60.0? It might be worth trying on
> something later than that to see if that helps... (+Daniele)
> 

I think this would require an AR on our end to make a new firmware
version available.

The upstream repo only has 70.53.0 available for ARL [1] (iirc, ARL
aliases to MTL for firmware). (+Julia too).

Presumably, the GuC changelogs should indicate whether an issue related
this has been fixed. If so, we need to update all GuC versions across
both i915 and Xe.

[1] https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915/mtl_guc_70.bin?ref_type=heads

> > 
> > Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has no
> 
> Is there a reason we don't just re-use the main xe_devcoredump()?
>

This is my suggestion: the main devcoredump infrastructure is job-based,
so it cannot be used for hangs that are not associated with a job.

In my opinion, this is a gap on our end. Introducing something like
`xe_devcoredump_gt()`, which can be used for non-job-based hangs (e.g.,
TLB invalidation timeouts like those addressed in this series, or more
generally any GuC protocol hang), makes sense to me.

I haven't looked at the patch yet, but at a high level, adding
`xe_devcoredump_gt()` seems like a reasonable approach.

> > exec queue or job to blame - leaves a devcoredump with the GuC log
> > and
> > CT state behind (Matt suggested capturing devcoredumps when we
> > discussed the issue; devcoredumps from both machines are attached to
> > the issue above).
> > 
> > Patch 2 logs when the ack for a timed out invalidation finally
> > arrives. This is what established that the acks are late rather than
> > lost.
> > 
> > Patch 3 is the RFC part: a delayed work that pokes the GuC (status
> > register read, CT flush, doorbell ring) every 250ms while an ack is
> > overdue. On my machines this converts the guaranteed 2.3s stall into
> 
> I'm a little worried we're just papering over something here that needs
> to be addressed in GuC, particularly around GT going to sleep or
> something around the time we're expecting a response, so the pings on
> registers might be prematurely waking things up which is something we'd
> want to happen in GuC, not the KMD.
> 

In general, I agree with this. We should avoid papering over the issue
and instead fix it properly in the GuC. That said, this workaround
provides a pretty strong data point, since it appears to get the TLB
invalidation unstuck.

Matt

> Thanks,
> Stuart
> 
> > a
> > sub-500ms hiccup for the majority of occurrences; a minority of
> > severe
> > episodes ignore 8-9 consecutive doorbells, which points at the GuC
> > firmware being internally blocked for the whole window. Full data on
> > the issue. I am happy to rework the approach (different delay,
> > tying it to the G2H handler, dropping the status read, etc.) - mainly
> > I would like the firmware side investigated, since no host-side poke
> > can fix the severe cases.
> > 
> > Based on drm-tip. Tested for several days on both ARL machines under
> > desktop and VM-heavy workloads.
> > 
> > Thanks,
> > Tales
> > 
> > Tales A. Mendonça (3):
> >   drm/xe: Capture devcoredump on TLB invalidation timeout
> >   drm/xe: Log when a timed out TLB invalidation ack finally arrives
> >   drm/xe: Kick GuC while TLB invalidation acks are overdue
> > 
> >  drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> >  drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> >  drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
> > +++++++++++++++++++++++-
> >  drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> >  4 files changed, 243 insertions(+), 4 deletions(-)
> > 
> 
