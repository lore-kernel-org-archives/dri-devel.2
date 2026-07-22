Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F48C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 22:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1611010E507;
	Wed, 22 Jul 2026 22:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b/cHtrbR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC75010E4F8;
 Wed, 22 Jul 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784757816; x=1816293816;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=OO2IEQf5hhQGWVMrtu5Le3S9cE3Zae12eSze/s8q5r0=;
 b=b/cHtrbRBY//fgO9lH8zR2zUgKLIp3Y1QkeucOB3XYMN5ckuq+nb7pKl
 plwJ3x6JIiUmV/QLkIhZGlH10E14/W3/LQfIEzgC9bFA5lcE08j9kUdD9
 70ecSOgdHKiwblE1pj/zWQtimgiTLNrezC805RN5GkVBfngF8xpvjtT3u
 tlEBRuk+Wx2HbwfbvDlHNlt6TXS8KiV/rG4dhiD5Ap38jK6Pd6V9aQxCc
 KcK2WN6KaphIxLPwbh0a68kuC+OJ8s3aBrUkLJXxpShPj03v5qhkJFp/h
 mwJQ3WuiomLK4jBa0jn0Rbnz96mlNMJaBgmG/EeYkJgyMEH1TDsLoCNsJ g==;
X-CSE-ConnectionGUID: SMSk83olRzCxdmyzagbSzw==
X-CSE-MsgGUID: /zLX29VGSBKlrajvkqP3Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87946911"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="87946911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 15:03:36 -0700
X-CSE-ConnectionGUID: OuJVAGaoQe2a85FDyBjvrQ==
X-CSE-MsgGUID: 36BI8oXjQYq7ygIC3QB+4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="262546091"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 15:03:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 15:03:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 15:03:35 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 15:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2pDPOSjzvExHbutghkBFLoQhXvnd3IWVRt/MNisi7b6Ejn2FoVZ7RL42Sz2aQeq3vUhDkp9LHrQ42vU43MJePDqmqyannj4JEr8/CsXwZlfqlIKeFxxfPKYZD7ETY3gY41U96ypB9x7gMRHpYg5cPRYwhKCgGLV+hRvxplEKx0hYai5HxL8rZNScu0oub827MXMdSUStLtdAFOp30oewmWCDyhhm+RnUFLY56mk+3RYV9uWyIVlHPSmbkp4BUdeIcV3Q8eH7XbGqHsqJr088yxHoTmIQcjQIfiViojj4Cs/TiWpvDBzRZNmJEEWyQmjnPicMCplhIb6I8w3DLIscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX8FhcscMerLUF1wige9UbgQfQAwuOCBt1Ws8Qqn8gM=;
 b=W6O08/l5dbfFGxDKgc3qxNXq7TKjE4wfTh3SBZtR1v7g1TgqN3Es8J6IHLhWBOv/0pj6fROVxj5s5PCIc17ZkAgy7vxKAeXZe6bItv3aLMpUgVvsOxV5HBDjQZszgJcACUweex6O7z/SHmVHnHmv+oQSeNwIfqpkCZV6k9F0Ia0pa+nYOf6bIweVx9JbBMFw8PeBN7bA6EZulApjzwmhl3pwGYPN0QDK6uBL/aDA2yr644dXaSJ0f3q4MZjQlX1EAgFkDvYflyW0JSdOT6BZ3XDS/6nmOR2nqkwjwTtADVe5jhsq1VuvlHjE7YxpNyUVBPkdptGYCrL4jPwLKgDWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:03:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:03:29 +0000
Date: Wed, 22 Jul 2026 15:03:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing
 it in timeout paths
Message-ID: <amE+Ltrb8qKNKWd2@gsse-cloud1.jf.intel.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
 <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 489be35d-6a14-40d8-6285-08dee83d0fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qOcyggXfcym8JApjU+xRt1FBpkNNmNfHctTrEPOVBR/CHbD4Qob7AilaNmEsohnyqpkmkOA8FwOR1Ie92ZvmKHwx9t6mv6ROYWnw7ldHdQsfiIlOBbTtJu+W25Ev2Ij7mRu1TexXKIfpF2J59F84ii4/1iZmmZB9bsx1AMa1NNLI01ZqqU/A66/MZgAE953x5FSPlZo97nIs6+64w9yi+S2PXx+oelTR0JnRLyR/vbbXmaOg8HCje2xKD8mOSIqK4146Z0YuSwBSZanxaaOqv4ONn+gZuwTHVEmqs8Iv+l3Jc23XhnQmcuCO9H3DB6ZTDv+kf+exTpXylTWlKbeoEHVG8rcoh2qo5b5MTeHgDth8XCI0YdFKzXEN6ygqIg0K1VzZU5r5V5WNz0JdE3zah0cvdMvM7f3/gTHbp2wazZhQ6/9t+uKvdWdM8UrbwMAg+dD/5wpIyvwdCRn3iqOwy/L2PUElcN8S5eEgoXjygXzZerkeNKUcXMs++dofngOjWdcl90OK1k1d9X7+YKxZFsyXa1m4yrG+y9bbRNzHly8YB34QjOnXGltwY45tBkJZsQHIRj1w73xqvoVjEFQUZFLj7t0t0uet92OxelueeDAOfGVW8ewWQwZtUxKXGrwE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9PoM4c7LcmayXLwlW8sgTNso/V4GnARmdzC9iOHi8kJ+tw6Jrc+FPI/4aB?=
 =?iso-8859-1?Q?TerNEQDZKxu08O27+o+fDWnWnxMBSW1AGeAD2kzQpqlqzXJVs4H3RQxm7v?=
 =?iso-8859-1?Q?h+9xx2A3f9DmmSO+80AeNY/8WXtIahTDNjAG6IdMAsAQLtuO/5KS6QySgh?=
 =?iso-8859-1?Q?ZmE3wIWcg7cCHs6aXH5n2v2AnBf3+USXHtnUiS0L9pDBzGRqlwBso0IddH?=
 =?iso-8859-1?Q?BKRD+FT6EW2DqtO/8oPj2KUomUfIm3vor23wBjXJUPoOTGt7OHvsC5r49y?=
 =?iso-8859-1?Q?zmxLmtQsvAd7WRFP2gBMlP3z7ihkrqnFB+M2kyInSSo7E19ytUkiOtmhk1?=
 =?iso-8859-1?Q?LRODdWoOIJ8Ytv47s3vdYhzeGqXNW80E7pZP8+vsFKP/bWdYDlRvKt2Z9d?=
 =?iso-8859-1?Q?lM44Jt3k3FbhEFmr7SyfF+3YdKun7xRWB13zfU9VLKpdxcQYhUePcaTJxQ?=
 =?iso-8859-1?Q?Z0WWiXJ8B3iicJa+1YfdTmxXUsrAq34DQznNdvG2UijGPVjLKY+RhkXtPP?=
 =?iso-8859-1?Q?FQ3Otc05zhhxv9Krkr4gDgzbH9aeejh8pEgrW7EYRASZuNJAHf23YAQGTo?=
 =?iso-8859-1?Q?+HiQex1h4CX3+jWhLJ7mOJZ+WFUEhBcS1GidBPY43xgwjtz7H66aWYZOpe?=
 =?iso-8859-1?Q?5yOVDUnMqj4hVD/6ZOqVYupVRHyy4fZWvAAJqSUYuPTSr9PlZxbP8Thqlv?=
 =?iso-8859-1?Q?5Td2nmKoJAuLvX2k36SPUTLMVSx8S1a/3QZDWWvwpwqtKSkhDSiMKrvwQe?=
 =?iso-8859-1?Q?WeBEyMAGt+aQGzJMY5pJcttZjuwJB4EhgBag4CLKcBQUBxzGWvcNw6mtUd?=
 =?iso-8859-1?Q?yAoG2ZLmDXs0b2sAcNnwKx1tTxS2Pgqx9X6yEF/yxuUdqgKG8XnsPxFlEa?=
 =?iso-8859-1?Q?BtQitmSDzxBWU5WkdrWMTiFRXe9hf8F7CE6fXPZpYYN7qarYl/pMm4Bp8J?=
 =?iso-8859-1?Q?K6zhu/1h2i0IPEBV2EyiHFQ8zfxSsmTV+LnBXjKqN8n5RmsJmuzzT8332w?=
 =?iso-8859-1?Q?yM8bl5mL5Qs5golUn/HtygsG95AcB4Bu463JkH9QePGdaxtKv887d0TqFk?=
 =?iso-8859-1?Q?nBYzwSZkAb7CKGd1LhaAnmM3Qb7z3gpkbiaPLgNABOJ8aPYLnR68L9L3Yy?=
 =?iso-8859-1?Q?vv8jyFWbeV1ukKvvvrxNciKXm29y3rgwF05kKCo1CaZjh3SLocFF5GHEUO?=
 =?iso-8859-1?Q?4GhSiRmF8JFghYc4bYtQS+WL/BxJrMRjknF8cLuOMK1pQqLIdJXsa2+gVo?=
 =?iso-8859-1?Q?C8reCrAQd7z2xtaVnGSqkFCMl9X2vHCYISp9oZKl/OS+o34luIU6z/7U/O?=
 =?iso-8859-1?Q?81RRAYJsNM3HmXzHexHe/yXBcSbvVeVqSiD6o2o1nqfn2tl5yy3f9A4bk2?=
 =?iso-8859-1?Q?azkXj0Ejl6Jisfbi9xPKKnvtP6YEwM61eTXPwfy0/jGUluSPRAVdiUV72f?=
 =?iso-8859-1?Q?cgr+q9LFVuEf3T/8uq2nU3WBpXdkFLbTTaxiJFWXVLOQhkjXdFP7iD+hlo?=
 =?iso-8859-1?Q?n7+8F/+HaV57US6VNF7WqZGsUB74pmWAXdM1QH58UVIRmZAZxOesBL/HCM?=
 =?iso-8859-1?Q?v3hZmz0bZoKyY9RFfT548Ll4urX7WPNklr9wzeDF4kiwJX6wwBRI4v9bum?=
 =?iso-8859-1?Q?W0x5ckjPAYG3JUmUn3CkTAg16OeZxqV3jM/sNWbH4C0TPCAwEMZoO6+qM3?=
 =?iso-8859-1?Q?2G+nQ0iuK4L/n/zulr1bbJgHEmSnInQ/TwHTS3JGatb1GUVi5dBsB/6u++?=
 =?iso-8859-1?Q?jhpWdxhrvXJQ8fJbWNh7CFs69OBq+gjWHMPPxzkAMYquPPs01NwqAfIDYx?=
 =?iso-8859-1?Q?xD0kWx2r6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: ojs8YMWDa0NPqmqgZ1wwjkyby9yFRS0nGGIMNEU+sqmqoCPoJePoQye9Kds0ToQzyGBxQisUp9pnBCzkjaYV7eLQTb47SubQnu7LGgCKAa5CbVf5LV1FjI9QLc8629nDl0cSTGUHbfdeAJZVI12aJWFNjxwdSbeTulKhxYQ3JdL84tvxmfcYtsU31VVUgb7JnxUlRjQDs1HE49UH6vnSScFol5HtcQdbJyaDEitbhmiecW5bViEy+7ExmGDg1myvJVrVE79hmgipDLDt7a4+uecIchrJNcKBusw8XTo7mDUJEFrXowG85r3B9Xqpc0nn/5DRylEBzWsB2WZWJzgX/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 489be35d-6a14-40d8-6285-08dee83d0fdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:03:29.5635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Tp5dNZ3Zx+jeFusuV0BYjlacZR+MsKQynFfP/I4IDBW7SQ/xBFgWNrz7fCr8Huwu1zUVeM3/GNA6XxNNF6Ikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
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

On Wed, Jul 22, 2026 at 02:10:18PM -0700, Matthew Brost wrote:
> On Tue, Jul 21, 2026 at 09:46:53PM -0300, Tales A. Mendonça wrote:
> > Timeout-recovery paths flush the G2H worker to pick up a response that
> > may have been posted by the GuC but not yet processed:
> > 
> >  - guc_ct_send_recv() after the 1s wait for a G2H response fails
> >  - the TLB invalidation backend's .flush() hook, called by
> >    xe_tlb_inval_fence_timeout() before declaring a fence timed out
> > 
> > However flush_work() on a work item that is neither queued nor running
> > is a no-op. If the GUC2HOST interrupt for the response was lost or
> 
> GUC2HOST messages getting lost are a different issue and would be
> catastrophic for a variety of reasons. I'd like to dig into that if it
> occurs on a POR platform (i.e., LNL+).
> 
> > coalesced, the G2H worker was never queued: the flush does not read the
> > G2H CTB and the response sits there unprocessed until an unrelated G2H
> > interrupt arrives. For TLB invalidations this results in
> > 
> >   TLB invalidation fence timeout, seqno=N recv=N-1
> > 
> > with the fence force-signalled with -ETIME even though the ack may
> > already be present in the CTB. Observed sporadically on ARL-H under CPU
> > load, always with recv == seqno - 1 and self-recovering on the next G2H
> > interrupt, which is consistent with a lost wakeup rather than a
> > GuC-side failure.
> > 
> > Add xe_guc_ct_flush_g2h(), which queues the worker before flushing it,
> > guaranteeing the flush always drains the CTB, and use it in both
> > timeout paths. A spurious worker run is safe: g2h_read() returns no
> > data under fast_lock, and receive_g2h() copes with runtime-PM state and
> > disabled CT communication.
> > 
> > After this change the fence-timeout error only fires when the ack is
> > genuinely absent from the CTB, making the message a reliable indicator
> > of a GuC-side stall.
> > 
> > Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> > ---
> >  drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++++++++++++++++++-
> >  drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
> >  drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  2 +-
> >  3 files changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> > index fe70c0fd85c..11a05c2b8c7 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> > @@ -1377,7 +1377,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
> >  wait_again:
> >  	ret = wait_event_timeout(ct->g2h_fence_wq, READ_ONCE(g2h_fence.done), HZ);
> >  	if (!ret) {
> > -		LNL_FLUSH_WORK(&ct->g2h_worker);
> > +		xe_guc_ct_flush_g2h(ct);
> >  		if (READ_ONCE(g2h_fence.done)) {
> >  			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
> >  				   g2h_fence.seqno, action[0]);
> > @@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct *w)
> >  	receive_g2h(ct);
> >  }
> >  
> > +/**
> > + * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
> > + * @ct: GuC CT object
> > + *
> > + * The GUC2HOST interrupt for a G2H message may be lost or coalesced. When
> > + * that happens the G2H worker is never queued and flushing it is a no-op
> > + * that does not read the G2H CTB, leaving messages the GuC has already
> > + * posted unprocessed until the next interrupt arrives. Queue the worker
> > + * before flushing it so the flush always drains the G2H CTB. A spurious
> > + * worker run is safe: it returns without side effects if the CTB is empty
> > + * or CT communication is disabled.
> > + */
> > +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
> > +{
> > +	if (!xe_guc_ct_enabled(ct))
> > +		return;
> > +
> > +	queue_work(ct->g2h_wq, &ct->g2h_worker);
> 
> If the original queued work gets lost or is never submitted, then there
> is a bug somewhere else in the kernel, as mentioned above.
> 
> As for the flush part, yes, it's possible that this could take a while
> if the scheduler goes out to lunch, but it shouldn't happen with a
> sufficiently large timeout. Have you tried making the GuC CT worker high
> priority? We could also consider making the G2H handlers RT once those
> land upstream.
> 
> In general, I'm quite unhappy with the existing LNL_FLUSH_WORK, and we
> never determined the root cause of the original issue. In retrospect, we
> probably should never have merged that code. Looking at it now, the LNL
> flush code isn't even scoped to LNL, which makes this even worse than I
> initially thought, as it can paper over bugs. I'm going to post a patch
> to scope the existing workaround to LNL and earlier platforms (or maybe
> just removing it completely) and see what happens in our CI over the
> next several months before it makes its way into a kernel release.
> 
> With that said, the patch as proposed is a no from me. If you want to
> pursue my suggestion of scoping this change to LNL and earlier
> platforms, we can discuss that separately.

This is roughly what I had in mind:

https://patchwork.freedesktop.org/series/170939/

Compile tested only, so if you could give it try and see what pops up, I
think that would be helpful. Fell free to use the code in anyway and
give me feedback.

Matt

> 
> Matt
> 
> > +	flush_work(&ct->g2h_worker);
> > +}
> > +
> >  static struct xe_guc_ct_snapshot *guc_ct_snapshot_alloc(struct xe_guc_ct *ct, bool atomic,
> >  							bool want_ctb)
> >  {
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
> > index 767365a33de..4e0338953f1 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ct.h
> > +++ b/drivers/gpu/drm/xe/xe_guc_ct.h
> > @@ -22,6 +22,7 @@ void xe_guc_ct_runtime_suspend(struct xe_guc_ct *ct);
> >  void xe_guc_ct_stop(struct xe_guc_ct *ct);
> >  void xe_guc_ct_flush_and_stop(struct xe_guc_ct *ct);
> >  void xe_guc_ct_fast_path(struct xe_guc_ct *ct);
> > +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct);
> >  
> >  struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_ct *ct);
> >  void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot, struct drm_printer *p);
> > diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > index 046d0655122..91960dc4ba9 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > @@ -327,7 +327,7 @@ static void tlb_inval_flush(struct xe_tlb_inval *tlb_inval)
> >  {
> >  	struct xe_guc *guc = tlb_inval->private;
> >  
> > -	LNL_FLUSH_WORK(&guc->ct.g2h_worker);
> > +	xe_guc_ct_flush_g2h(&guc->ct);
> >  }
> >  
> >  static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
> > -- 
> > 2.55.0
> > 
