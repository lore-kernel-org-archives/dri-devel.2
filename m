Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06038C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BDC10F150;
	Wed, 12 Aug 2026 22:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Lb5pS8bq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E7210F150;
 Wed, 12 Aug 2026 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786573527; x=1818109527;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=958hl3FjjG0FBbDFDCDxzW1yx2rdgyfGdUgU3T5nUTI=;
 b=Lb5pS8bqWMz7eR+LzQyV3jh1yybwMopSbzR9imFSumjVVta03mC51iFZ
 URXTCTtitc4vfD2aahwXYsEYeIscanG2F65t5HWT9u7MS+iikSkNmduOX
 pUBXqBOOE0s/XdjDt+S7BU1KIGeGGnBIUC1I5tp8qh3rd8ZbraTVbHoR0
 7b9/r9jBCu1txPx20B/LQ0unwYIu73OHaM1rSl7dpZBYHltb8yrKcjDpp
 CpoUtWO4ICXzSstN7nDlRcyc35d9QrMHNTJTvhkwTvq51+vDe9e/W8Aok
 C5WeRgIV4GkbuzgSHafJiOkWfJvoc+X+5E+OsPhmn6oLW5+LYBk1QMIh3 Q==;
X-CSE-ConnectionGUID: AzKVkoLqQpam/9DeDUw+xQ==
X-CSE-MsgGUID: TzjSAo6lTjCjJPsyyAfpsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87161431"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="87161431"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 15:25:27 -0700
X-CSE-ConnectionGUID: TKJenOqoSbmM0plKNM3zOw==
X-CSE-MsgGUID: MBZQvv7KTmenSvu77WNOBQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 15:25:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:25:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:25:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5fzEM80893p0glHVil2VQkNyGE1hfx20EDOlXjOyeXjPvNUJNEBUtSVYUIesI4vMe/84WPQ1gnyHuJ+/q7ibu+/s6e7sCgd/vMkl1tkA4QRIJRBy70RtwoyylWrmYbBGNKDM5ZC8W3ok3cEitc3yaXiAndrw0Vzbv2gYOqnw6066g1YhMxW8ilulnm78rP7yerkdbuPdGKkGJ9Xxt+fDPeTR5VxFZFOyXjb5+nif3XPr+W8GNsMyKp3lCCvXXTkEBson4fCGofRFC3Zle6jFS6YPY0Qx00Mijp3wtHZtljwfK8mq/wcWICI/zA2QBbAmpQzXgw+jU+E9hazEISASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S/PnxNLP6WSLBDkykMogkZBIX5/TGRV92ADdxu9zEM=;
 b=FN05xoqUhHvSkYsZSi1R3F1VqMhtCVO5Tv9jzqDFP2DX7lRguZg04KDxnYnfNZCm00CNLZ6xm8mjGVc6nvqxkNXM545T0kohoLcp7Z8k0Iz9BMDb4mCQIJZp9wcMytSZQfYB1gxlp1GJMtH3AO6EHp7XIZLIEBP1hLEWj06xNBu/cnE2uzbz/z4dYsLZcz9RXPfrrByN7CrBylI8gVWn1Al0J7SVifJjMdZeJetYyQ57KlU+36BadHQTaa1iC0PimRB2aG2LKBu2rgkGFgEYG+ptlK7jWx7FrykFfae3LAZMp53jzPfapXWUgYBZLO48L8bIWC/LXtlEjTMrB075lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PPF96964A2A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 22:25:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 22:25:22 +0000
Date: Wed, 12 Aug 2026 15:25:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <anzy0DLsktBtTKqF@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
 <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
 <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
 <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PPF96964A2A1:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fba6bf-bc27-4c03-48cc-08def8c09979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|17096099006|11063799006|5023799004|18096099006|3023799007|11146099003|22082099003|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: LF7BqufDjTdrCzkulB9EOR0ZKZqWvYVRLLhHW7B3woTtQZu6+O0rOswCrtOQCCjoeooLExb/rZX0oXX4l64dzc0O9HW0OduJtvuJHACPVsl+c/W131KD8mXETcEv+6A4jzvxnJBdys4mswxakHwvvCgTN8XDChbIKyYFJi59BLPEV+J1OjPQoId3g2eevtqqfTaieW6yrJQcZB4QY+hT1c4zI+8QoPNFHcsuUPbnqx7ofiVbQKIkqq789cPGEeYejvxeT0svqY7fFmK9L1XIvgZZ2ojekcUladb2xO6y+W77tv71+T+Yf3WI9whdLJJlM8XZ9jq2YEzW611SaVArUoTFNYCJ4BM+UCJbMsSeqaY0gQiKSwVGQoaABSMeFXT07orDjM+eya4KBVgAPz2UGMEzYLjx5q/nafiicuNWVmnxy2fMvllYiWfBpC8f6qPoZNNNVqdiGi8Wuj+YMtzuqsbMuCIJjWH94YnzXmTqIPisjKgB8aNaBziZbWzLirmjTYX1khsj5ix8BZPn/77+FPmX3nLdoRy1TZx9r2wiRHQwGba4XS+Sw/JTVMAm98yy66NHVoiOjvU90YTNpBO/7/N+AcFe/9zAFxldsWxT5x6veAOfDAPGVJm88O+XeKS5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(17096099006)(11063799006)(5023799004)(18096099006)(3023799007)(11146099003)(22082099003)(18002099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3nMo31xrBzJRtRlXxsKv6vTJZshPUN3jcYtZSn2skY5ohKTp52BkbkvC2c?=
 =?iso-8859-1?Q?nUPVWPNQu/rBdtlVOn+YNApdngdXTr5K9h7yMSE6zxoLQwTTQhM0hieSxi?=
 =?iso-8859-1?Q?2WduANyVUvVf7HgwkXWTOGwwaZqHRiDXtl3tbGl71mNhdnv/G60HVG2Sym?=
 =?iso-8859-1?Q?iAD0NLljR55YT5ZduHUWq00Ecb8jPtjp14ApVA1wfr06nHWiqiKaz0FQPr?=
 =?iso-8859-1?Q?+Skt42II9lnRSDi/y85snHPQeUJouZSQIECwlIRxoqv0wdKYOiNs1jw7v9?=
 =?iso-8859-1?Q?Aswj2Lq6np1rhtPqB69SJJXHMh43cg9wc5T0wMfoGYfC9WG8Tg5IItyf5b?=
 =?iso-8859-1?Q?xxUc+RTFvA7DW95G670HzN2aYRoxNjHmWJoired/YEsGaZmU4k0Cg4Rh00?=
 =?iso-8859-1?Q?D1uDEkfnbju9UF/r07fXywpZr/OswKmt6HwV1KjUYoTVhFPX0WBlUh8zM8?=
 =?iso-8859-1?Q?gHtdiBBIni7nQ4dCwYWxKRzTAppTXDTVf6TLepJaF0YOXMZeDzaki47RSG?=
 =?iso-8859-1?Q?a0i9hgII7LgT5PjtfOlFSCFJ4L7iv41JdI/e7+RYI+qggckTh15mfsGOGY?=
 =?iso-8859-1?Q?49HVV5fc7/V8dBkcQk7reISMTZT+vhohDzE6Zv+vCq9QtRSZj9T0/ndxuE?=
 =?iso-8859-1?Q?/X4HG1pysNC/Yj+oVjZRdg9CZVVCwnTap0ljo5jEQMlxSMMTTO6fO1KHCk?=
 =?iso-8859-1?Q?mPY/l+0CCtizAEWuYvVoKK46/grARJU4wMcDf9zNMZp7oHPPcqKuu7DNb8?=
 =?iso-8859-1?Q?xWcGRGqXncu80NY1Njqq6RSFuifLs32OWe8JhzFPvpRy0RNrLWjkENkclh?=
 =?iso-8859-1?Q?PHKO2Tc29zQ0rS6ZrEAa9bkXeYH75uDhZXhNmXT8eHZJ/1Z11HaMTf7ybM?=
 =?iso-8859-1?Q?l2UZ+uLVJIkvLnHQQXKN9eqPTkUI1qCvIPiy48EjKbZpmoGSeTqKMhxlVq?=
 =?iso-8859-1?Q?T4vbaflqCOUELIGx3SIKdT092ySOIo1YPtkriNLi3odgtdi0MDy2Hxbqcr?=
 =?iso-8859-1?Q?sTRKaWJSyn0lh3ngq1ZA7Z0d0+NmFBkAVGy/pjVW39H01LMOySi/XQzbSd?=
 =?iso-8859-1?Q?mul1w7TswurEBxePX2Qlb9U6K0FlAW9NFV7l6zkiaMEiLdCfowhnp54PUs?=
 =?iso-8859-1?Q?TUjxwE0fCfLUbJQl8uhlerk/ejaRtn/VHwQXyuxHSnX5TSRngK6kHM1398?=
 =?iso-8859-1?Q?TVoZ5rBs2OCImf+3FTnK2CHlj9CysDorw2N3Ev46shRBIGNBd4lF7S5b/Y?=
 =?iso-8859-1?Q?CHn1O3DzX0PVLpsyupjDDkNq8O6GPRSegQDHPi7GoiCw0S2I+NTk6e94Fz?=
 =?iso-8859-1?Q?C/OQmJoKNQDk72Pe9U0hecv6p4TZvTrTIYy4BWXfx9s5PvuuT0RkrjQd5T?=
 =?iso-8859-1?Q?XMFeD1rT0NO4ovv3odMVgzdYWyi2Tpt1reC9mZn6R4XPOIaQgdevkks9vK?=
 =?iso-8859-1?Q?GDcPgE38x3uLmieU2FzIPL6GNmKWNsH3Zns2XEk2fHfZz+VsAKwWI64gRr?=
 =?iso-8859-1?Q?su+Ne95hMfK/s1fkJ0M9pEuiXE2Pz/DHIeb59cucZ5MOdV9Qv10anQT9nf?=
 =?iso-8859-1?Q?oOnzs/mTKToeR2bK5+dkOUfWnVZjv9UULsSRFfa8s8udGWoC2G1+KFK9eu?=
 =?iso-8859-1?Q?elksMuJ1JiozlbTThPOWnXrmz+u5aMEiT/lYfP9nS+hV3sVR/hFDm7ukiw?=
 =?iso-8859-1?Q?bJzy9gW/sul5NVFKfvfq8hrY5Mvl4PlzcXiEv1OnO8F1ITPsaON+u3T/wx?=
 =?iso-8859-1?Q?9chWPlagoh3mbap8LHGYCjeILyWXwS/RTYkO3fYjLsn/AyLayU/nZ0ljKk?=
 =?iso-8859-1?Q?+Esnos0OrNNsYK+veei4Gz6HszNQ2/I=3D?=
X-Exchange-RoutingPolicyChecked: SIA8eHynGIqP0Mr3JVbDngFr6ES6znbTA3KvBVtJ/rX2vDxZdxdXkUaVd2P4CxjEaSTrgIqL5czaZ4JD6cBup2ahbaAocQCEJQoQuK9f+0f6SizJ+ErbXNFS9qvonag0qbJ7zI8sngEqywCQVUBgkvxTxippEsr+srUC5v8APS0AUURQvnug2vi2wyEQfloQx/mN8smPP2sdDGbE72bpGlPfXJo9UIG0oQ28566oKXIX4XOZcu9hvZZPmaMA3i+oD16BMQt8wHzbUrKDe00KW62ePe/F1VsBAgwDOqbmMoT1Yl2EvQ861IQ6I8Z+t5aJ2CqdfbzCjGHEmfP6E6zqRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fba6bf-bc27-4c03-48cc-08def8c09979
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:25:22.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D45Op1T0yZaeMpWfiAcVGJBc+5c7S8ByDFVIy+u3BqaRlb1fzuq1vTuSUzg5PNXbKhzd60zaUuVY2LNb+smXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF96964A2A1
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

On Tue, Aug 11, 2026 at 07:09:33PM -0700, Matthew Brost wrote:
> On Sat, Aug 08, 2026 at 05:34:04PM +0800, Neil Zhong wrote:
> > On Fri, Jul 31, 2026 at 11:00:49PM -0700, Matthew Brost wrote:
> > > This actually roughly what downstream customers are carrying :).
> > >
> > > It is basically these 3 patches [9] [10] [11] implemented directly in
> > > the Xe shrinker code to avoid touching the MM or TTM...
> > >
> > > Alas I got nack'd by someone outside my subsystem on this approach.
> > >
> > > I think if you use the reference patches above to implement a heuristic
> > > in Xe, or come up with a similar one, it will likely solve this issue.
> > >
> > > Since you're on 6.18, you may also be missing some Xe/TTM changes
> > > related to this problem that have already been merged into drm-tip.
> > > There are a couple of one-line fixes that should help somewhat, but the
> > > heuristic is what I think will actually address the root cause.
> > >
> > > As heads up, I've started looking at this again and pushing to get
> > > something upstream as this at least 5th time someone or org has flagged
> > > this as a problem. Any data you can provide will help us push towards a
> > > solution.
> > 
> > Hi Matt,
> > 
> 
> Thanks for all the details here, very helpful.
> 
> > Thanks. I tested [9]-[13] on the same machine and the fragmentation
> > heuristic does reduce the frequency of the problem. However, after these
> > tests I would like to clarify my actual requirement, since my previous
> > watermark-based proposal did not express it correctly.
> > 
> > For BOs that belong to a latency-critical visual processing working set,
> > I think userspace should be able to mark them as non-shrinkable, and Xe
> > should not back them up under any memory-reclaim condition while that mark
> > is held. This would be a hard residency contract, not another reclaim
> > priority or a fragmentation hint.
> 
> This is roughly what customers have indicated to us for laptop-type
> products: anything displayed on the screen should avoid eviction or
> shrinking at all costs. This series came out of that discussion:
> 
> https://patchwork.freedesktop.org/series/170454/
> 
> This customer, in particular, utilizes priority bands to express this
> heuristic (e.g., the compositor is the highest priority, any
> non-privileged UI-related content is normal priority, and everything
> else is low priority). I'm not sure if stock distros do anything like
> this.
> 
> Pinning would take this even further, allowing the compositor (or anyone
> really) to effectively say, "Don't shrink this".
> 
> > 
> > Why a hard contract is useful for visual workloads
> > --------------------------------------------------
> > 
> > The reproducer is continuous 4K60 HDR playback. Every decoded frame is
> 
> Can you give me instructions on how to recreate this on our end and your
> machine, memory details? I have a bunch of various reproducers which I
> have been using for shrinker work and the more the better.
> 
> > imported through DMA-BUF and processed by libplacebo/OpenGL for HDR tone
> > mapping before presentation. The active BO set contains decoded video
> > surfaces, intermediate render targets and presentation-related surfaces.
> > 
> 
> DMA-BUF in priority series moves to the prior band that is least likely
> to be shrunk.
> 
> > At 60 Hz the complete frame interval is 16.667 ms. If glFlush() is blocked
> > for longer than this, the application misses at least one presentation
> > deadline. Repeated missed deadlines are perceived directly as dropped
> > frames or visible stutter. A 100-500 ms reclaim/restore storm is an
> > obvious freeze, even if the system eventually recovers and its average
> > throughput looks normal.
> > 
> > Fence-idle is not equivalent to cold for this workload. A video surface
> > can have no active fence in the small gap between two frames and still be
> > part of the application's current visual working set. The next frame can
> > need the same BO immediately.
> > 
> 
> Ok, I think I see a potential problem here with priorities. If, for
> example, a buffer is assigned a priority indicating that it is unlikely
> to be evicted but has no active fences, it could be chosen for shrinking
> before buffers whose priorities indicate "shrink this first" if those
> buffers have active fences.
> 
> > The trace demonstrates exactly this case. In one sequence, kswapd
> > completed backup of an 8,208-page BO and the rendering thread started
> > restoring the exact same ttm_tt about 33 microseconds later. The kernel
> > copied about 32 MiB to shmem, dropped the WC pages, then immediately had
> > to allocate pages, copy the data back and reapply WC.
> > 
> > In the ten-minute default-watermark capture:
> > 
> >   successful ttm_tt_backup:                 4,853
> >   ttm_tt_restore:                           4,810
> >   minimum backup+restore copy traffic: 50,436.105 MiB
> >   Flush > 16.667 ms:                         209
> >   Flush > 100 ms:                             65
> >   maximum trace-aligned Flush:           223.195 ms
> 
> Also a quick write up how you extracted these numbers from reproducer so
> I can recreate on my end.
> 
> > 
> > Of 4,791 restores matched to the same preceding backup, 4,279 happened
> > within 100 ms and 4,753 within one second. kswapd0 performed 4,839 of the
> > 4,853 backups, while the player's rendering thread performed most of the
> > restores. Of the 209 Flush calls over one frame interval, 205 contained
> > ttm_tt_restore() and all 209 contained set_pages_array_wc().
> > 
> > This is not useful recovery of cold memory. It is destruction and
> > immediate reconstruction of the visible working set.
> > 
> 
> Yes, indeed. We really don't want to destroy a working set unless the
> core system genuinely needs memory and doing so is the only option.
> Even then, there may be parts of the working set that simply cannot be
> shrunk, as you are suggesting.
> 
> > What the heuristic test showed
> > ------------------------------
> > 
> > I backported [9]-[13], extended the fragmentation check to direct reclaim,
> > and tested a `high + min` watermark threshold. In a follow-up run with the
> > same kernel, video and playback configuration, I set vm.min_free_kbytes to
> > 50000. This lowered the Normal-zone `high + min` threshold from about
> > 379.8 MiB to 255.1 MiB.
> > 
> > With the lower threshold, the fragmentation helper returned true more
> > often and Xe working-set churn fell by about 90%:
> > 
> >   successful ttm_tt_backup:        4,853 -> 443
> >   ttm_tt_restore:                  4,810 -> 435
> >   Flush > 16.667 ms:                 209 -> 19
> >   Flush > 100 ms:                     65 -> 3
> > 
> > This confirms that preventing working-set backup prevents the visual
> > stalls. It does not make the individual restore path cheaper. When the
> > heuristic still allowed a storm, the maximum Flush was 191.655 ms and
> > contained 25 restores and 23 WC conversions.
> > 
> > I do not think tuning global watermarks is the right solution. More
> 
> Nor do I. [9]-[13] were Xe replacement for what is IMO a proper solution
> in the core MM: https://patchwork.freedesktop.org/series/168651/ I'm
> pushing on this patch a bit more with the core MM maintainers and have
> another shrinker locally that is semi-related to this as well.
> 
> I guess I'd like numbers with the patch above + priority bands to see if
> that is enough prevent working set shrinking of valuable buffers +
> spikes in flush times.
> 
> > importantly, I no longer think that protection for explicitly identified
> > visual BOs should depend on whether reclaim was caused by fragmentation
> > or genuine low memory. Once userspace has declared a bounded set as
> > presentation-critical, violating that residency guarantee produces an
> > immediate and user-visible failure.
> > 
> 
> To be clear - this would be an addition to fixes discussed above, right?
> 
> > Possible explicit marking mechanism
> > -----------------------------------
> > 
> > Could Xe provide an opt-in, mlock-like mechanism for this purpose?
> >
> 
> Yes, we could implement something like this, but we'd need buy-in across
> the entire stack (i.e., from user space as well). I'll run this by the
> internal team too to see if anyone can immediately poke holes in it,
> because I don't currently see any obvious issues.
>  
> > One possible interface would be a new DRM_IOCTL_XE_MADVISE VMA attribute,
> > for example DRM_XE_VMA_ATTR_RECLAIM_POLICY, with states similar to:
> > 
> >   DRM_XE_VMA_RECLAIM_DEFAULT
> >   DRM_XE_VMA_RECLAIM_NO_SHRINK
> 
> This seems like a reasonable API.
> 
> > 
> > NO_SHRINK would mean that the backing BO is excluded from the Xe shrinker
> > while at least one protected VMA holds the attribute. Userspace would set
> > it when a video/render surface enters the active visual pipeline and clear
> > it after the surface leaves that working set. Unbind, VM destruction or
> > file close would also release the holder automatically.
> > 
> > For a BO shared by multiple VMAs, Xe could maintain a BO-level
> > no_shrink_count, similar to the holder accounting already used for
> > purgeable state. The shrinker would skip a BO with a non-zero count. I
> > would prefer a separate shrinker-specific count rather than exposing TTM
> > pin_count, because pinning also affects placement and migration, which is
> > broader than the requested guarantee.
> > 
> > The existing WILLNEED state does not provide this contract: it prevents
> > purging of the contents, but the non-purge shrinker may still back up and
> > unpopulate the BO. It also cannot simply be redefined because WILLNEED is
> > the default state for all VMAs. SCANOUT is not sufficient either, since
> > many HDR intermediate and imported video surfaces are not scanout BOs.
> > 
> > I understand that an unprivileged client must not be allowed to make an
> > unbounded amount of memory unreclaimable. Like mlock, this could be
> > controlled by an explicit per-file, per-client or cgroup byte limit, and
> 
> I think we could just hook into mlock accounting. There is an exported
> function for exactly this purpose:
> 
> https://elixir.bootlin.com/linux/v7.1.7/source/mm/util.c#L549
> 

I guess using mlock accounting for pinning has been discussed in the past
and was ultimately rejected because it is susceptible to fork-bomb attacks,
which can result in all SRAM being pinned. Thomas has a write-up with more
details that he can perhaps share, but I think the community direction of a
pinning uAPI is reasonable. However, we likely need cgroup-based pinning
limits.
 
Dave has a series implementing cgroups for SRAM here [1], and we'd likely
need to extend this to support pinning limits as well. Likewise, the VRAM
controller would also need pinning limits.

Matt

[1] https://patchwork.freedesktop.org/series/169824/

> You'd have to deal with multiple VMAs (from the same or different MMs in
> a dma-buf) aliasing the same BO and ensure that accounting remains
> consistent everywhere, but it shouldn't be too difficult. We already
> have this problem WILLNEED/WONTNEED and solved it.
> 
> Ofc, this only works for system memory buffers so we'd some VRAM type
> accounting too. iirc Thomas was working on cgroups for that part in a
> slightly different context though.
> 
> > possibly by a privilege check. If the requested protected set exceeds the
> > configured limit, the madvise should fail rather than silently accepting
> > the mark and later violating it under pressure. The application or system
> > service would then decide which visual surfaces to protect or release.
> > 
> > Within that bounded contract, however, I think NO_SHRINK should remain a
> > hard guarantee even in genuine low-memory reclaim. Under pressure the
> > kernel may reclaim unmarked BOs and other memory, reject additional
> > NO_SHRINK requests, or require the application/service to release part of
> > its protected set. Backing up an already accepted presentation-critical
> > BO and stalling a frame by hundreds of milliseconds defeats the purpose
> > of the interface.
> > 
> > For comparison, my original workaround approximated such a hard contract
> > by excluding VM-bound WC BOs from non-purge shrinking. In a 21-minute
> > capture, no XE_EXEC, VM_BIND or DMA-BUF ioctl exceeded the 16.7 ms frame
> > interval; their maxima were 348 us, 136 us and 20 us. The call rate of
> > set_pages_array_wc fell to 0.179/s. That automatic VM-bound WC rule is too
> > broad, but an explicit and bounded userspace mark could provide the same
> > latency guarantee only for the BOs that actually need it.
> > 
> > Would an explicit, bounded NO_SHRINK/latency-critical VMA attribute be a
> > reasonable Xe UAPI direction? If so, I can prototype the BO holder
> > accounting and shrinker exclusion, then modify the video/Mesa path to mark
> > only the active visual working set and collect another strict A/B trace.
> 
> No issue if you want to prototype this, but as mentioned above, this
> would require buy-in from user space (which is not under my control) and
> at least one other person on the KMD team (most likely Thomas). So I
> can't guarantee that it won't be rejected by someone. 
> 
> Matt
> 
> > [9] https://patchwork.freedesktop.org/patch/720030/?series=165329&rev=1
> > [10] https://patchwork.freedesktop.org/patch/720036/?series=165329&rev=1
> > [11] https://patchwork.freedesktop.org/patch/720031/?series=165329&rev=1
> > [12] https://patchwork.freedesktop.org/patch/732698/?series=168466&rev=1
> > [13] https://patchwork.freedesktop.org/patch/732420/?series=168389&rev=1
> > 
> > Thanks,
> > Neil
