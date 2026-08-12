Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C9DC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 02:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D20E10E3BE;
	Wed, 12 Aug 2026 02:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UgSMmYat";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CB610E3BE;
 Wed, 12 Aug 2026 02:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786500586; x=1818036586;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tM6t0iPap2LhQQRLPLBvikbEWh5ugdIwmFjYiJPA2Lw=;
 b=UgSMmYatiJLq8p50jp8mNzx61fkusqYjWns71382TGWqhST3mjKZGgpa
 XIfFU360EUY+ZPJOOmeNxyMnC5N2AY0v1OsNpp4xuInJgH/Tid1Hffr43
 YbDhQzUGbr2OPETQqsQ2NbGXl7Ikdeck6GT94XAxQjbUS9HBnESLI3pFC
 hVcGQSqWMxjebsjHvGzPv/6FdG2O4c+LhziuwvKK+85qu+QRjPORnCk7X
 EeS6l7elvc5ULdRVAUJOLRccf1XZgZMmlyp9AX1o3/jTXZZvIxtwmy8Of
 u0dfUTTNh6GpsLmNRsO5X6ekho2iJsdbbai6fnBB7Di24m8AbEH1lWBNl Q==;
X-CSE-ConnectionGUID: lyGqOXVuSHiOE5VWKw/AlQ==
X-CSE-MsgGUID: 8wozpr+ORzu+rJ6S45c/Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="109833317"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="109833317"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 19:09:45 -0700
X-CSE-ConnectionGUID: 1K8c3dLaTGS37jJdxfQY7A==
X-CSE-MsgGUID: vROm2RkHQF+9BrhVWGq7jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="286926393"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 19:09:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 19:09:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 19:09:44 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 19:09:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK8nLzPnYRSBZv8Ve9Apk+6YY0R0nZkGJaXJ7+ncIVjTBCT/hRB1qbm+du/w7iMB9+lh+sDVoL5o4i+pnUUxvhV76c2FzlF5Ohh9UjUXCJiSu7y9GV7fMXL9iPHbzl11t28O5AdDU5uIy33ed+ylzgAxLwDmkKrya5RG93G1IWDbF4zk+EQ59nwWL3P6HmcWAa7Z1c7SvwZ4lmxMId3Jn5KIcUmVKI1olqRVOBZG9aUiSnNrtt6/2D2Egv+2Sm9CkK2BYEUhygaqVFG/hZyJfiqwhLhNFoCrdNgd13WUsdWpg17ttbOXCVUmMNoWKuTooiXt33GphYm0PRtLlGz2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNmMN0CzUEqKTx7ew+ZC4Pwx441L5W293em0A3GYR9E=;
 b=U65U9owobCllpBY394A3v549rmPAbcHDhNYkAdH2qYeVSYd24yYKK/MKCGytwstMh6YyxkngUFWq7JlqG6GOUcUFcLeKHZR46GyM1JEG7qvM6PRWwbaQqJEBK4x92eBpaQIsPR/L9oiJMAx6HCTH6Qal9q4aouR9qGNxVMFSwPh2HDTqZbsi8EGNQj0rypAOeEN49J4EszR06cMIKP0UKxvuLbmcRCNXSnxL6mPI/svVUIWFTcPg+V/+NiNmlIKlGrZBSPxoL1qGKJmJWvZo7EAXjSDPCUY1T5wOeQ2RsILWAtANaG+fwBZFcE7qqawWQ3PT35teHh2cFLsb3uvJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB9451.namprd11.prod.outlook.com (2603:10b6:8:261::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 02:09:37 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 02:09:36 +0000
Date: Tue, 11 Aug 2026 19:09:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
 <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
 <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aab5ab5-f41d-4aea-42b4-08def816c246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18096099006|10067099003|17096099006|5023799004|11063799006|4143699003|56012099006|6133799003|22082099003|3023799007|11146099003|18002099003;
X-Microsoft-Antispam-Message-Info: MDMTiKr+gCTmcNhSvweQcLToSxgcBlFqKexWM/wwkwGt3/SXe+hDH/a8CGn7OFrq9R9GDCQ+fP6ZRBB8I2IeDnAVnYYoVHb+dtcK1EuCy3W4HbaymxM5MbOUqqLievxZins1fpdTbJaKSrHLablO5FEUkw+u60b8DIpv9Q6SmdyFY8UfzGoFfRMcQ2JzBAFP6QJPLZE2XIobtLApGMAzkaC+wVM8qSjKWNzFY+vn0dnD5We6p7tyefg+Pqunadz41bomVrvnQx7xl3WSVtajaNKZh2tepr6//ku0gatqVuaxbpIh8EfbdKJ5UJ9/JcV9NZKx53r1jqcNPvtd/Y0wxjDbQLO2iVT5cPNq7qrz77BMf3kaGy58FzG0xVOAEDTcYmX0LYT71z89KUavNYw4CbTe2KEzdf4VBu40cn1gzeIxAX8v2L4Epf0hmq4lyEZnEAw5fWdmgErOaI0AVjEYxgzGkRmLGdaTWt1KwOAUC+1mkRtHnAyrDQRlSsN7WqdiskDUsDVkpqh9wLzMtkney0j4shLTxWOpHusLQ7OPkiMmxXkjoHE1VFLqSJ3HHIkKbig44UR7aYmkvefy6gsqZIhUL6DcibnGM+V2mKE9Z8fDY0hBXtrqyR0EGJqfGg20
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18096099006)(10067099003)(17096099006)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(3023799007)(11146099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4h5Vlb995YtpNn8hHO5ItTLGx+HydpgjQIhgGnovNSGClP3LQ3DEAOSGEBL?=
 =?us-ascii?Q?WsLqbnyuC10Ev6ULMLSP7HVUf9HykHwGoCrfXIlvtMxip5hbPHmThzj7Bb1P?=
 =?us-ascii?Q?Qr9i1voUuLCNVUpA0a+Y+dhfm2us5mAH3tWIjiM2MKOPleS40LIzsAAFX+Fd?=
 =?us-ascii?Q?Ms3gxqU/qR8s7WUd7tz3rrG3Y42UEgOKS3pZW12ZmqqkLcWrj04jJf8OMnyU?=
 =?us-ascii?Q?RpG9o9e/YyUpa428ndAJW8xXkLMqH2PrvOoYgpks9MuDwkAuo7hMa45s3nvf?=
 =?us-ascii?Q?BqCCj5TqABwkz+NmVcLZ7+BLVYVbfk1I4BgIuSscaOVbHbs+yuLiwjP7/o5i?=
 =?us-ascii?Q?ULzpqrH18MaBZ4MByMrLbk05MZlyvh1mGcJwRs5wlu83paZAlu6+6eMUsYF+?=
 =?us-ascii?Q?FoV01S8IvxKQzPHZQbcgaXp1lDMrQ5d11jpcxjDleci8WT62zljkqzRm/u8E?=
 =?us-ascii?Q?LO0TRpdF8WhnL3XBuZdp0OUVd4AIrbu533p+iwp5dGobQGd0DsyRysVvN4DQ?=
 =?us-ascii?Q?V/vDtpQYuc9kexzBGkrQpVBG00GeypaP50xXXaqcn2rKQC6PiZdQVKtcu2Zd?=
 =?us-ascii?Q?6bAJYFY5bE7IenQT22y0gZaBXkYDbjJ+GPVX4m+I4UJ+BfOXfJGxEi1TCGGe?=
 =?us-ascii?Q?jeFP2vOcekMOnYX4Y0CL41h3DdId6d4vdHhjgwWNWT/PjI7NDQXW+UOybIH1?=
 =?us-ascii?Q?iK7GHizGnUkbJGZa7dj+8d6fB+9O6YrIGfjiOMPWURnlUc+3+gDptO+TDIO2?=
 =?us-ascii?Q?vlSqy70nxdbA8/qhG/2Hh7DU91QEr25SZXr/ReIRPTIff0nOZxs6FffPADSv?=
 =?us-ascii?Q?VXYSjWoIwneSupKWAQkBxiKUo/PTkxDckX5608uFpYAEsMjTNzbSlNIhwq5H?=
 =?us-ascii?Q?LFTm8Ca8+2hiwLwsAsIXluPnGxEmtVSs8EwcML2ZHMuVpKXA+FAeIeBAg/Li?=
 =?us-ascii?Q?LJKNL/O/JZajf24NAF3xlKLTZjq0IwgxsD7G2F3VIKnadwpFBRXQC6EMHJTY?=
 =?us-ascii?Q?C6DgwAGrLB77eAJhEoW9yPtu+FgH5moqfOyphGUp4n5ddXioo9ORIAWBuDRy?=
 =?us-ascii?Q?LrXWpozYljZryqMbkVdwTsJA2RKbxqnoprmHj4S0UJW5zbjv3z0O8Y3fTSHC?=
 =?us-ascii?Q?+uGyu4mb7whVscUMlavy3leuB2kQqoquL61FGs/ob4cKANYdVUZMzffRTqle?=
 =?us-ascii?Q?5cbGo09nQRfuoDhNodeOwIUROevavqcDjfYFu2FzXGWsGmNDvU/XNiIn+rh3?=
 =?us-ascii?Q?92EIo96ucHA7E2+ugFRN8tBujMsPJEVts0ZpjsuQIX3kxlp/RIkhHe2uSnQt?=
 =?us-ascii?Q?nguWm8tOECMptaQPjaeHC305y/0qVB+VA4AWZwgM5BBuAhygUZNfKunbaKk5?=
 =?us-ascii?Q?bfpAbYkbz89W2xl0IY/H7uJOqR5nhrsGWEPUQCi/t3C2G1Mo/mReiezCtsw3?=
 =?us-ascii?Q?5lI/4zRbnRawPuYuZ4FI/wZxiExsFVHWNef4A8+N4fDkeBLHLiFmSCtYy0yT?=
 =?us-ascii?Q?ciBBAzcdrndhn491KDfC/Ml/gkm+/jiduiVEbjGdK4gG1i3/rap2hnj/4TOF?=
 =?us-ascii?Q?Fe12Mg42KvOSzufGu3ZNTo1pgiLhqLDWTRaie08lUIE6B9UFvrnzgP8DSnNj?=
 =?us-ascii?Q?4D2D2vk3tkk8T5ClEccOEbxFPwZTjG7rw951jKbhYJ3Yw9Hs6FLS3w0yDdGZ?=
 =?us-ascii?Q?VSEQu99kYMoFKo7j3HzYBzek3Qx8Tbgyx2YaWHChPGwphBWFlogdZSbnAMHP?=
 =?us-ascii?Q?vEn5q/T9CCg4QfB8q1Urs2sIKJKpfmU=3D?=
X-Exchange-RoutingPolicyChecked: WlqAfPYB45ViH//98YaBwWW8MITkKKpP1K1RPsl0Z/cGZQULc/bTZF+QIqkSzR196NePRqqyJ1KkE8roJQrJuus36J61so2ujmoSRTv3itniDUwBBnc9gmSPKBgE+Ccz1rCI0wkC/ayru56BiJ/9JB1TwxUBMM2zbyIS1IL1zF1z8ur6hJIzFP+y5MmxIlzUIaic9w17nSdeE59iOZbsk9MtmIUxwkAG3JBslowp9fOM4tR68TBxEsHtYZd2wXNulcHFkhApwAY4BslCdOrPjAKuRmPScg4zRFaFyUMAeRFFT0Igun4PX4PNjVTgD1pKoWQaoDBAmL9yNIl8oLBo1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aab5ab5-f41d-4aea-42b4-08def816c246
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:09:36.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7dCVd6p7GwTeap/okw7VPO6SXqvLNcqsrh3T1fGXru70WkwHspzhiw3ziNcbodL6/ApezVk4mKP83XUx517jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9451
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

On Sat, Aug 08, 2026 at 05:34:04PM +0800, Neil Zhong wrote:
> On Fri, Jul 31, 2026 at 11:00:49PM -0700, Matthew Brost wrote:
> > This actually roughly what downstream customers are carrying :).
> >
> > It is basically these 3 patches [9] [10] [11] implemented directly in
> > the Xe shrinker code to avoid touching the MM or TTM...
> >
> > Alas I got nack'd by someone outside my subsystem on this approach.
> >
> > I think if you use the reference patches above to implement a heuristic
> > in Xe, or come up with a similar one, it will likely solve this issue.
> >
> > Since you're on 6.18, you may also be missing some Xe/TTM changes
> > related to this problem that have already been merged into drm-tip.
> > There are a couple of one-line fixes that should help somewhat, but the
> > heuristic is what I think will actually address the root cause.
> >
> > As heads up, I've started looking at this again and pushing to get
> > something upstream as this at least 5th time someone or org has flagged
> > this as a problem. Any data you can provide will help us push towards a
> > solution.
> 
> Hi Matt,
> 

Thanks for all the details here, very helpful.

> Thanks. I tested [9]-[13] on the same machine and the fragmentation
> heuristic does reduce the frequency of the problem. However, after these
> tests I would like to clarify my actual requirement, since my previous
> watermark-based proposal did not express it correctly.
> 
> For BOs that belong to a latency-critical visual processing working set,
> I think userspace should be able to mark them as non-shrinkable, and Xe
> should not back them up under any memory-reclaim condition while that mark
> is held. This would be a hard residency contract, not another reclaim
> priority or a fragmentation hint.

This is roughly what customers have indicated to us for laptop-type
products: anything displayed on the screen should avoid eviction or
shrinking at all costs. This series came out of that discussion:

https://patchwork.freedesktop.org/series/170454/

This customer, in particular, utilizes priority bands to express this
heuristic (e.g., the compositor is the highest priority, any
non-privileged UI-related content is normal priority, and everything
else is low priority). I'm not sure if stock distros do anything like
this.

Pinning would take this even further, allowing the compositor (or anyone
really) to effectively say, "Don't shrink this".

> 
> Why a hard contract is useful for visual workloads
> --------------------------------------------------
> 
> The reproducer is continuous 4K60 HDR playback. Every decoded frame is

Can you give me instructions on how to recreate this on our end and your
machine, memory details? I have a bunch of various reproducers which I
have been using for shrinker work and the more the better.

> imported through DMA-BUF and processed by libplacebo/OpenGL for HDR tone
> mapping before presentation. The active BO set contains decoded video
> surfaces, intermediate render targets and presentation-related surfaces.
> 

DMA-BUF in priority series moves to the prior band that is least likely
to be shrunk.

> At 60 Hz the complete frame interval is 16.667 ms. If glFlush() is blocked
> for longer than this, the application misses at least one presentation
> deadline. Repeated missed deadlines are perceived directly as dropped
> frames or visible stutter. A 100-500 ms reclaim/restore storm is an
> obvious freeze, even if the system eventually recovers and its average
> throughput looks normal.
> 
> Fence-idle is not equivalent to cold for this workload. A video surface
> can have no active fence in the small gap between two frames and still be
> part of the application's current visual working set. The next frame can
> need the same BO immediately.
> 

Ok, I think I see a potential problem here with priorities. If, for
example, a buffer is assigned a priority indicating that it is unlikely
to be evicted but has no active fences, it could be chosen for shrinking
before buffers whose priorities indicate "shrink this first" if those
buffers have active fences.

> The trace demonstrates exactly this case. In one sequence, kswapd
> completed backup of an 8,208-page BO and the rendering thread started
> restoring the exact same ttm_tt about 33 microseconds later. The kernel
> copied about 32 MiB to shmem, dropped the WC pages, then immediately had
> to allocate pages, copy the data back and reapply WC.
> 
> In the ten-minute default-watermark capture:
> 
>   successful ttm_tt_backup:                 4,853
>   ttm_tt_restore:                           4,810
>   minimum backup+restore copy traffic: 50,436.105 MiB
>   Flush > 16.667 ms:                         209
>   Flush > 100 ms:                             65
>   maximum trace-aligned Flush:           223.195 ms

Also a quick write up how you extracted these numbers from reproducer so
I can recreate on my end.

> 
> Of 4,791 restores matched to the same preceding backup, 4,279 happened
> within 100 ms and 4,753 within one second. kswapd0 performed 4,839 of the
> 4,853 backups, while the player's rendering thread performed most of the
> restores. Of the 209 Flush calls over one frame interval, 205 contained
> ttm_tt_restore() and all 209 contained set_pages_array_wc().
> 
> This is not useful recovery of cold memory. It is destruction and
> immediate reconstruction of the visible working set.
> 

Yes, indeed. We really don't want to destroy a working set unless the
core system genuinely needs memory and doing so is the only option.
Even then, there may be parts of the working set that simply cannot be
shrunk, as you are suggesting.

> What the heuristic test showed
> ------------------------------
> 
> I backported [9]-[13], extended the fragmentation check to direct reclaim,
> and tested a `high + min` watermark threshold. In a follow-up run with the
> same kernel, video and playback configuration, I set vm.min_free_kbytes to
> 50000. This lowered the Normal-zone `high + min` threshold from about
> 379.8 MiB to 255.1 MiB.
> 
> With the lower threshold, the fragmentation helper returned true more
> often and Xe working-set churn fell by about 90%:
> 
>   successful ttm_tt_backup:        4,853 -> 443
>   ttm_tt_restore:                  4,810 -> 435
>   Flush > 16.667 ms:                 209 -> 19
>   Flush > 100 ms:                     65 -> 3
> 
> This confirms that preventing working-set backup prevents the visual
> stalls. It does not make the individual restore path cheaper. When the
> heuristic still allowed a storm, the maximum Flush was 191.655 ms and
> contained 25 restores and 23 WC conversions.
> 
> I do not think tuning global watermarks is the right solution. More

Nor do I. [9]-[13] were Xe replacement for what is IMO a proper solution
in the core MM: https://patchwork.freedesktop.org/series/168651/ I'm
pushing on this patch a bit more with the core MM maintainers and have
another shrinker locally that is semi-related to this as well.

I guess I'd like numbers with the patch above + priority bands to see if
that is enough prevent working set shrinking of valuable buffers +
spikes in flush times.

> importantly, I no longer think that protection for explicitly identified
> visual BOs should depend on whether reclaim was caused by fragmentation
> or genuine low memory. Once userspace has declared a bounded set as
> presentation-critical, violating that residency guarantee produces an
> immediate and user-visible failure.
> 

To be clear - this would be an addition to fixes discussed above, right?

> Possible explicit marking mechanism
> -----------------------------------
> 
> Could Xe provide an opt-in, mlock-like mechanism for this purpose?
>

Yes, we could implement something like this, but we'd need buy-in across
the entire stack (i.e., from user space as well). I'll run this by the
internal team too to see if anyone can immediately poke holes in it,
because I don't currently see any obvious issues.
 
> One possible interface would be a new DRM_IOCTL_XE_MADVISE VMA attribute,
> for example DRM_XE_VMA_ATTR_RECLAIM_POLICY, with states similar to:
> 
>   DRM_XE_VMA_RECLAIM_DEFAULT
>   DRM_XE_VMA_RECLAIM_NO_SHRINK

This seems like a reasonable API.

> 
> NO_SHRINK would mean that the backing BO is excluded from the Xe shrinker
> while at least one protected VMA holds the attribute. Userspace would set
> it when a video/render surface enters the active visual pipeline and clear
> it after the surface leaves that working set. Unbind, VM destruction or
> file close would also release the holder automatically.
> 
> For a BO shared by multiple VMAs, Xe could maintain a BO-level
> no_shrink_count, similar to the holder accounting already used for
> purgeable state. The shrinker would skip a BO with a non-zero count. I
> would prefer a separate shrinker-specific count rather than exposing TTM
> pin_count, because pinning also affects placement and migration, which is
> broader than the requested guarantee.
> 
> The existing WILLNEED state does not provide this contract: it prevents
> purging of the contents, but the non-purge shrinker may still back up and
> unpopulate the BO. It also cannot simply be redefined because WILLNEED is
> the default state for all VMAs. SCANOUT is not sufficient either, since
> many HDR intermediate and imported video surfaces are not scanout BOs.
> 
> I understand that an unprivileged client must not be allowed to make an
> unbounded amount of memory unreclaimable. Like mlock, this could be
> controlled by an explicit per-file, per-client or cgroup byte limit, and

I think we could just hook into mlock accounting. There is an exported
function for exactly this purpose:

https://elixir.bootlin.com/linux/v7.1.7/source/mm/util.c#L549

You'd have to deal with multiple VMAs (from the same or different MMs in
a dma-buf) aliasing the same BO and ensure that accounting remains
consistent everywhere, but it shouldn't be too difficult. We already
have this problem WILLNEED/WONTNEED and solved it.

Ofc, this only works for system memory buffers so we'd some VRAM type
accounting too. iirc Thomas was working on cgroups for that part in a
slightly different context though.

> possibly by a privilege check. If the requested protected set exceeds the
> configured limit, the madvise should fail rather than silently accepting
> the mark and later violating it under pressure. The application or system
> service would then decide which visual surfaces to protect or release.
> 
> Within that bounded contract, however, I think NO_SHRINK should remain a
> hard guarantee even in genuine low-memory reclaim. Under pressure the
> kernel may reclaim unmarked BOs and other memory, reject additional
> NO_SHRINK requests, or require the application/service to release part of
> its protected set. Backing up an already accepted presentation-critical
> BO and stalling a frame by hundreds of milliseconds defeats the purpose
> of the interface.
> 
> For comparison, my original workaround approximated such a hard contract
> by excluding VM-bound WC BOs from non-purge shrinking. In a 21-minute
> capture, no XE_EXEC, VM_BIND or DMA-BUF ioctl exceeded the 16.7 ms frame
> interval; their maxima were 348 us, 136 us and 20 us. The call rate of
> set_pages_array_wc fell to 0.179/s. That automatic VM-bound WC rule is too
> broad, but an explicit and bounded userspace mark could provide the same
> latency guarantee only for the BOs that actually need it.
> 
> Would an explicit, bounded NO_SHRINK/latency-critical VMA attribute be a
> reasonable Xe UAPI direction? If so, I can prototype the BO holder
> accounting and shrinker exclusion, then modify the video/Mesa path to mark
> only the active visual working set and collect another strict A/B trace.

No issue if you want to prototype this, but as mentioned above, this
would require buy-in from user space (which is not under my control) and
at least one other person on the KMD team (most likely Thomas). So I
can't guarantee that it won't be rejected by someone. 

Matt

> [9] https://patchwork.freedesktop.org/patch/720030/?series=165329&rev=1
> [10] https://patchwork.freedesktop.org/patch/720036/?series=165329&rev=1
> [11] https://patchwork.freedesktop.org/patch/720031/?series=165329&rev=1
> [12] https://patchwork.freedesktop.org/patch/732698/?series=168466&rev=1
> [13] https://patchwork.freedesktop.org/patch/732420/?series=168389&rev=1
> 
> Thanks,
> Neil
