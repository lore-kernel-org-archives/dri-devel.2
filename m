Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8FFC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCF210EEE1;
	Thu, 23 Jul 2026 00:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F2/yV8LH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D10C10E4F5;
 Thu, 23 Jul 2026 00:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784766395; x=1816302395;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UHSTjiTJT7YpEj8tYZogzxuCjh1ngLZlCRO8PzGjgdY=;
 b=F2/yV8LHr0CjLMqJRjP4xW6rxM/2rAVYabMksPAyoVPvVtBfhiwh/rGS
 Qvqzu6NOcvZJwB73uIMU2183S1bxj5aFyaWPWiGy3iulfX89G87lBesTi
 MfcFnrDvz/RfB5Fhe2/wUzcmIY4jmOl/4m4+4ymQnPVuPYEB+D1c19o2a
 0ETw4ToGWmlu08DnvU8BC3jGrbemQORO0ThuSG8Eo7L4QBT801pGyRqEF
 /eKEXXQPwcud4ufOOZdN2daDBlz/IslhdiHXZbj0pixLOQmcxzP5Pf4Rn
 oMAGbQ1CtILc6c2TPrIl+EYq7spotteNTXThOHYmlyAbFkEBb2NmR5P9s w==;
X-CSE-ConnectionGUID: hVlwWxRaS0y01qFTOggMIg==
X-CSE-MsgGUID: JKMLzRHHQUaHmYOgkdFdrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102960727"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="102960727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 17:26:34 -0700
X-CSE-ConnectionGUID: 20jkOA1ZTryWAPtMXviGLA==
X-CSE-MsgGUID: fS71r8jeQ9C3i1hTOTimSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="256453407"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 17:26:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 17:26:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 17:26:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 17:26:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpZiJhVcd3WN03ULowWY4PvEPw7G+di9VTEErrAnfU9jsnhXn7qi7A5gfqoR5lbH+aayHJoESmfcu5lAurh0fgkUOeYGILLQ6FrmtvKUxCOBoDx9O3nagk1tfrexcmxYtQYT4+jGvsh8lMATMMbTdPnqJUmoqjkrNTBn6kxkn1o2objYgrDK8guFPWKu3yhITR41FpZ0BaPnFqxdzoLNFBkEpmJ1MNOM2w4+xkK/nU97qSRqccAg6zxjOq56Ob09owjJp5Yy5GaCdh/jlqOV1ekZH8pF7oxT5qSh0UExdo/Yk1B7ZNG0EktWNovsOsdcwbdpx9c+aM5h+RdM+VX8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XeHYj6DmebJUetvPK9vhiUoHw8IgLV/6mSP2LNtY2g=;
 b=NzEcaUIc65tBe54tnMD1Zo6oBxnbFNgALRzhnDF5fNGnMscwxQNwYbreGA/wN29LJVxHPoHj21c2UDUe2nYxfcMmzFQuTl5Dv3d82WlELf16IfcXF0aEdwUkMrrhoONsmP9+ENuiKpOxlZ2GpNPA2Csd/9OTsPPXm/FtvsySNq8d5WzrDkhZL63pvP+Bz2SU3R1F0Go2rVBkCrElSiFzX0slLm/VF1rS8E8hCiRuCRVVWWgR6nWI0JBtv+/r9mW0JKkIz5RP9oStvDHvS/uloMJClnKKE8RsPHMcRv1qpBgxmHyzwu3ee9azQN9IUMJBIIPSO6uh7On2crBpMUkHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH3PPFAC6BA7F25.namprd11.prod.outlook.com (2603:10b6:518:1::d42)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 00:26:31 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 00:26:31 +0000
Date: Wed, 22 Jul 2026 17:26:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing
 it in timeout paths
Message-ID: <amFftEnuIfPJKFPX@gsse-cloud1.jf.intel.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
 <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
 <amE+Ltrb8qKNKWd2@gsse-cloud1.jf.intel.com>
 <CAHBRX4HbDnpiEqgFauZNMWPq+Wtp6RhYYLKMW=zNbTphAB_xgw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4HbDnpiEqgFauZNMWPq+Wtp6RhYYLKMW=zNbTphAB_xgw@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH3PPFAC6BA7F25:EE_
X-MS-Office365-Filtering-Correlation-Id: 333cea8b-2ad3-4a8e-cb01-08dee8510b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|13003099007|6133799003|5023799004|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /1BIvS7eNEC4MoalqhbEFw1p3o0hmmF5em7JvNcZzV5PAqM6Qr679cfI1vXDU6LEyv+3qovZgs4y5G+JGiBmJPOGJtaxgNMNHAi/ILMLYnfL4EirReqvTJlEIhN8ZMrfSGbAfzPwnt7hKUYboO7ic0/5+/Ujsi/iG3IqglX9uBEe80opT1zdec7lC3dylDq2gHy0ih4BLWNYEmKZBgcmLHFbVqD1oDBjLM1ORXjjrFDfmDyYppugaE/6kWZed37ZAqAYGV0fOCZ4ft3G1aRtVsWMlUiOhOodfEMJaLS8zGb6LCi9UHpPwi+bhJt5PZ/5X++HoY0PU/ZO4zYu0sqG4K9u18Rs5oPIgKtZZkuVaa1bsvXNU/P/GXSS0kUDmXy4RFoIoSYzi/oYkg2f2mUJHRiFZWjEVbupwcJgaD9DtpnVlgA+fmNfkDkI7YTUCvletfhIVXa/aZAMu/9vrfXjr5bbNdGolrGy+CysLHLL6gUncZDWcO6SB0QiKg1T6GbhWZRXhqaZL22wHpAXyZYZ1APTRnsXh3y24ELfvXPo4uS89wtuDN44NUSiBRsgwhX2maSNM/ivwy3JIkMPtbCkNM6+vdB+E7J1ixaDImspiPrHPclDYF33K/OTVAxVyDBW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(13003099007)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QxgItWafiNa0L7JN6SEHjv3HJU4BCt51vAqIQXjxGTCNtb9nkUC0FkBupo?=
 =?iso-8859-1?Q?Irgwo/k8nVfqU+ZttfMHR6TJ/KeRIYK6n67bl6/I2e/S+ivqvzuwr+ubDw?=
 =?iso-8859-1?Q?oujATEX8MAzm7cPphSiZDH9wNyq5SfQOGAnq2L+bDTG3fc7ql1HV4SjN9G?=
 =?iso-8859-1?Q?fbRWZxfe/yN59fQQrYhO6yHu1dLARhsnM0xqC4WV5M7lWmR5YWKzBWxAU/?=
 =?iso-8859-1?Q?UvHrTCqA6VIvDP1EYVurQknzAmotCrjndC0SfinqgGnHOvWE36kndRvfnz?=
 =?iso-8859-1?Q?4w567d5jnlIbZKnzZB2eDRYbUGlfweFywc06Vu//QpReZzlJVvgQAOGwUd?=
 =?iso-8859-1?Q?i7yCPGrVYyPRqXAqcgPGgD3wjAnZesYpN/fw+d1exybUBfpYBztjxfT7wH?=
 =?iso-8859-1?Q?18lVT/eNSTQUO+t5SJm1rHCIa5KOsZUfQUz8B7Uc0KXfl+amSh6KYpH5/+?=
 =?iso-8859-1?Q?rTQX9KPZE5/T9DwvkjpF7aJ3+tVHieCpTQdFneglgva5ckmhq69ZErXJP6?=
 =?iso-8859-1?Q?JzD8/s+221JHQbZQ7tx7u0Nb92khT5RYSUXICLVgnIHvzGmY1W+PNw5ZHt?=
 =?iso-8859-1?Q?EV2UCy+JjSXOQrDxDk7yR+78gLZh3oVgorF93D91C0CRIuj5DhTnHad0kW?=
 =?iso-8859-1?Q?Q3AW72SO5AYZ+GlxQmh7jcwi0CjpKqESFLNqvcLAIeBnN2WC686RoG6R7q?=
 =?iso-8859-1?Q?TyMW5FN0jof6+Zns4mohEzdFwdjGF4GYzsr9y8pnp2UnS1I4YRIgbM3mOO?=
 =?iso-8859-1?Q?LqcJVbY6g1xc0sLSIJMiaOcRztV0K15WfRIDcVH17DNkHaGxGg57rDX7xL?=
 =?iso-8859-1?Q?ZRsKd1+xBGw0/yNiDCa4iCvWoVGatH2bUW8vI/6flZVkg8DvPPiJfXMw0V?=
 =?iso-8859-1?Q?cP+OMRGpuK0WncvYX14ScIyPQ9J9J4Yx8MlgBDydlPtZiJo/xX2UahwEm7?=
 =?iso-8859-1?Q?cIebU7K1Gsd4vqu4uNYI9MU8w4MeFWLMqSlMMPiIi86QSHtYiZtUMQj5BM?=
 =?iso-8859-1?Q?qp+i7OOczeD+CeP4oFrZNm9cXordT6+FWBMs3zgk3z9q5Uk5r2BPsNvbAu?=
 =?iso-8859-1?Q?8KrOe88FqPqtv2nT7vj+h1IVh1X6u5bLMhcgAYpPjLOTZSl6nXo6TVOwtU?=
 =?iso-8859-1?Q?0ITqZEoTueUqyNAHRG6RlYrDJTH8m6ShZNfWOh2iXS/vzZnBACImOn6i2h?=
 =?iso-8859-1?Q?2mDdyrN7NuIhqTMaa/zAurwXBwShbNku1bJayC/uDOjcbQHzbzxsZD0wog?=
 =?iso-8859-1?Q?aEoL88qpYpN6i4SguiIxq1thtlgJi1WRBqLJ7ckdlCc5+jTuXqLuN6bXpT?=
 =?iso-8859-1?Q?80EnF13Ep4yuXkfY15u3FCqHL2GuTO9EXYPVPQjGbi+QsnUuOn/q489PJW?=
 =?iso-8859-1?Q?7YygoptbtS4Ekr4Z01fz9/n1D2STi5wB5RKu93XksRkpw3oIBIV12DuKNE?=
 =?iso-8859-1?Q?uUzbtsmetQV2Y+LuGflXa/zks0ecAKMLxVmscj9UP3ph+uwtoGSzNlpwpt?=
 =?iso-8859-1?Q?yk3RoFHMtyp/IXn6nE86KRHc0BFXkBor9vvjCk80AI+I47xGVML3zrHFay?=
 =?iso-8859-1?Q?IOEu0Qe1lnJQFSPif3SOGnR9ZxxudkAOZpTzZ6BQ47c4Jf0LdZf/Hx+C0w?=
 =?iso-8859-1?Q?W+N74PgHhasd1AzaGuf0Z1sqlEcs1Mpccxn3zLRWiyeTUSRYtde4ITxyTC?=
 =?iso-8859-1?Q?FU3stYi7WLAVzbxxLrm+/7Qix0CpGIWzllgQ6JdtBNGP88S3fO9kZARpqz?=
 =?iso-8859-1?Q?IsY6I2uWXXIswL8byXLSEs2rbiu1t1kFsoV5PxvbTmssezMD5T4Rym0/Nc?=
 =?iso-8859-1?Q?3+MP5yMyTA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QVzM9RmbAt3VO/bqe6Q7cXt8jT1Hf3UlsNXii0BLSpvoZWlQ7fByeLn8iH1OMAQrCpHlr0oCWwnCpoa5tUhxedRFAXn05iMEkQ8oNuiYtTFXYsmRAlvaRBdRdXaPNSopmUbRx2Ma7UYyvGIahiwKmnf24IASa1i3slTab+5Fq1cStcnHu5E7OtwMvo/xEVfLSbG5VuOtfqufeP1K16ANsyjrL4mfPd+iJBsbKOGfNgJLKITLhjIjYtmvmsOdErjcivwGMc7bULKTMZ7lXI5Rfj+9lK/PZ9v6Mru99s4Ai44nZQNmhZ/2/RxQaWjGOttRL4M+/MgmlzvSpsGJ0RzSSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 333cea8b-2ad3-4a8e-cb01-08dee8510b17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 00:26:31.0804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9UJSPUaQDEjuQn/F4TPxw7bpd29qE+xIgh957I1S7r2pKPLgS6SlgnnlbBpaCpsJd73JF32vv0IrybhRJ5ouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAC6BA7F25
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

On Wed, Jul 22, 2026 at 08:28:54PM -0300, Tales A. Mendonça wrote:
> Hi Matt,
> 
> Thanks for the detailed look - and you're right about the framing.
> Later instrumentation on this system (sampling G2H CTB head/tail in
> the TDR *before* the flush) refuted the lost-wakeup theory from my
> commit message: in every observed timeout (30+ events across two ARL
> machines, 7d51 and 7dd1) the CTB is empty at timeout time (head ==

What about the H2G CT?

> tail, 0 pending dwords), and the ack lands 5-475ms (median ~22ms)
> later via the normal path. So the flush recovers nothing - the ack
> simply hasn't been posted yet by the GuC at that point. The stall
> appears to be firmware-side (GuC 70.53.0); I'm preparing a report with
> the full data.
> 
> That also means I agree with dropping this patch, and the data is
> consistent with your suspicion that LNL_FLUSH_WORK papers over nothing
> here.
> 
> I'll test your series from
> https://patchwork.freedesktop.org/series/170939/ on both ARL machines
> (daily-driver workloads that reproduce the timeouts at ~1.5/h) and
> report back.
> 

Another thing to look at is getting a devcoredump on a TLB invalidation
timeout. I thought we supported xe_devcoredump() without a queue or job,
but I guess we never got around to doing that. If we had the CT state
and GuC log, that would at least give us some hints about what is going
on. It would probably be worthwhile to add something like
xe_devcoredump_gt(gt) to Xe to help debug hangs that are unrelated to
queues or jobs.

That said, as Matt R. mentioned in an earlier patch, we don't officially
support ARL on Xe, so our bandwidth to help here is limited. In other
words, if you're hitting a platform-unsupported-specific bug, we may or
may not be able to investigate it.

Matt

>  Thanks,
>  Tales
> 
> Em qua., 22 de jul. de 2026 às 19:03, Matthew Brost
> <matthew.brost@intel.com> escreveu:
> >
> > On Wed, Jul 22, 2026 at 02:10:18PM -0700, Matthew Brost wrote:
> > > On Tue, Jul 21, 2026 at 09:46:53PM -0300, Tales A. Mendonça wrote:
> > > > Timeout-recovery paths flush the G2H worker to pick up a response that
> > > > may have been posted by the GuC but not yet processed:
> > > >
> > > >  - guc_ct_send_recv() after the 1s wait for a G2H response fails
> > > >  - the TLB invalidation backend's .flush() hook, called by
> > > >    xe_tlb_inval_fence_timeout() before declaring a fence timed out
> > > >
> > > > However flush_work() on a work item that is neither queued nor running
> > > > is a no-op. If the GUC2HOST interrupt for the response was lost or
> > >
> > > GUC2HOST messages getting lost are a different issue and would be
> > > catastrophic for a variety of reasons. I'd like to dig into that if it
> > > occurs on a POR platform (i.e., LNL+).
> > >
> > > > coalesced, the G2H worker was never queued: the flush does not read the
> > > > G2H CTB and the response sits there unprocessed until an unrelated G2H
> > > > interrupt arrives. For TLB invalidations this results in
> > > >
> > > >   TLB invalidation fence timeout, seqno=N recv=N-1
> > > >
> > > > with the fence force-signalled with -ETIME even though the ack may
> > > > already be present in the CTB. Observed sporadically on ARL-H under CPU
> > > > load, always with recv == seqno - 1 and self-recovering on the next G2H
> > > > interrupt, which is consistent with a lost wakeup rather than a
> > > > GuC-side failure.
> > > >
> > > > Add xe_guc_ct_flush_g2h(), which queues the worker before flushing it,
> > > > guaranteeing the flush always drains the CTB, and use it in both
> > > > timeout paths. A spurious worker run is safe: g2h_read() returns no
> > > > data under fast_lock, and receive_g2h() copes with runtime-PM state and
> > > > disabled CT communication.
> > > >
> > > > After this change the fence-timeout error only fires when the ack is
> > > > genuinely absent from the CTB, making the message a reliable indicator
> > > > of a GuC-side stall.
> > > >
> > > > Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++++++++++++++++++-
> > > >  drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
> > > >  drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  2 +-
> > > >  3 files changed, 24 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> > > > index fe70c0fd85c..11a05c2b8c7 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> > > > @@ -1377,7 +1377,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
> > > >  wait_again:
> > > >     ret = wait_event_timeout(ct->g2h_fence_wq, READ_ONCE(g2h_fence.done), HZ);
> > > >     if (!ret) {
> > > > -           LNL_FLUSH_WORK(&ct->g2h_worker);
> > > > +           xe_guc_ct_flush_g2h(ct);
> > > >             if (READ_ONCE(g2h_fence.done)) {
> > > >                     xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
> > > >                                g2h_fence.seqno, action[0]);
> > > > @@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct *w)
> > > >     receive_g2h(ct);
> > > >  }
> > > >
> > > > +/**
> > > > + * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
> > > > + * @ct: GuC CT object
> > > > + *
> > > > + * The GUC2HOST interrupt for a G2H message may be lost or coalesced. When
> > > > + * that happens the G2H worker is never queued and flushing it is a no-op
> > > > + * that does not read the G2H CTB, leaving messages the GuC has already
> > > > + * posted unprocessed until the next interrupt arrives. Queue the worker
> > > > + * before flushing it so the flush always drains the G2H CTB. A spurious
> > > > + * worker run is safe: it returns without side effects if the CTB is empty
> > > > + * or CT communication is disabled.
> > > > + */
> > > > +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
> > > > +{
> > > > +   if (!xe_guc_ct_enabled(ct))
> > > > +           return;
> > > > +
> > > > +   queue_work(ct->g2h_wq, &ct->g2h_worker);
> > >
> > > If the original queued work gets lost or is never submitted, then there
> > > is a bug somewhere else in the kernel, as mentioned above.
> > >
> > > As for the flush part, yes, it's possible that this could take a while
> > > if the scheduler goes out to lunch, but it shouldn't happen with a
> > > sufficiently large timeout. Have you tried making the GuC CT worker high
> > > priority? We could also consider making the G2H handlers RT once those
> > > land upstream.
> > >
> > > In general, I'm quite unhappy with the existing LNL_FLUSH_WORK, and we
> > > never determined the root cause of the original issue. In retrospect, we
> > > probably should never have merged that code. Looking at it now, the LNL
> > > flush code isn't even scoped to LNL, which makes this even worse than I
> > > initially thought, as it can paper over bugs. I'm going to post a patch
> > > to scope the existing workaround to LNL and earlier platforms (or maybe
> > > just removing it completely) and see what happens in our CI over the
> > > next several months before it makes its way into a kernel release.
> > >
> > > With that said, the patch as proposed is a no from me. If you want to
> > > pursue my suggestion of scoping this change to LNL and earlier
> > > platforms, we can discuss that separately.
> >
> > This is roughly what I had in mind:
> >
> > https://patchwork.freedesktop.org/series/170939/
> >
> > Compile tested only, so if you could give it try and see what pops up, I
> > think that would be helpful. Fell free to use the code in anyway and
> > give me feedback.
> >
> > Matt
> >
> > >
> > > Matt
> > >
> > > > +   flush_work(&ct->g2h_worker);
> > > > +}
> > > > +
> > > >  static struct xe_guc_ct_snapshot *guc_ct_snapshot_alloc(struct xe_guc_ct *ct, bool atomic,
> > > >                                                     bool want_ctb)
> > > >  {
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
> > > > index 767365a33de..4e0338953f1 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_ct.h
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_ct.h
> > > > @@ -22,6 +22,7 @@ void xe_guc_ct_runtime_suspend(struct xe_guc_ct *ct);
> > > >  void xe_guc_ct_stop(struct xe_guc_ct *ct);
> > > >  void xe_guc_ct_flush_and_stop(struct xe_guc_ct *ct);
> > > >  void xe_guc_ct_fast_path(struct xe_guc_ct *ct);
> > > > +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct);
> > > >
> > > >  struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_ct *ct);
> > > >  void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot, struct drm_printer *p);
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > > > index 046d0655122..91960dc4ba9 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > > > @@ -327,7 +327,7 @@ static void tlb_inval_flush(struct xe_tlb_inval *tlb_inval)
> > > >  {
> > > >     struct xe_guc *guc = tlb_inval->private;
> > > >
> > > > -   LNL_FLUSH_WORK(&guc->ct.g2h_worker);
> > > > +   xe_guc_ct_flush_g2h(&guc->ct);
> > > >  }
> > > >
> > > >  static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
> > > > --
> > > > 2.55.0
> > > >
> 
> 
> 
> -- 
> Com os cumprimentos,
> 
> Tales A. Mendonça
> talesam.org
> communitybig.org
