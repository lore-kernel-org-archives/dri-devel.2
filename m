Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AA2C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147F410F071;
	Wed,  2 Sep 2026 08:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eXdJEC4f";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C44010F06E;
 Wed,  2 Sep 2026 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337560; x=1819873560;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=tuHpcLSyYHVGHVj4HpPP/yt/dcI+9OM1mkF81eTXtUE=;
 b=eXdJEC4f+mAs2Y3P5DUGfA0DuuMju8HQgwzQaLF3UTx+vBw+DyH9I34F
 UFxliSqMryNxejJTxaNuPHA/8Cc902Pe70D1JjBhgCPNUgGZDfZ0Ic9/Z
 X0Cz65r9kt2TvPBb1x9kX2jFnoA4Eoof9blpujIm7T6qW+gBBW6dAD++S
 tlphJgF1apPYaMY3V9wSV1fxWcP+F5cMXX8y7O2hs5hZhGe9E37DJA77T
 tPDKox1b3AJmDdTo4hBbPsl7d5U97jMi/lWhylASPInQ5MwBaK0qaTPzr
 ST396LzoJ4CJIvAscptWmoCHfkoXDHlXcofdqfi/O8SmxI2yi/dc1wApX Q==;
X-CSE-ConnectionGUID: Nq8lWvp9RyuPUfnwKneraQ==
X-CSE-MsgGUID: xCZtt5QJRL6sHRZMfSv+9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88994780"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88994780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:00 -0700
X-CSE-ConnectionGUID: tBCDetJBS96TOgyX5cSt6w==
X-CSE-MsgGUID: /VuzX0YGSRiI+s/K0QtI3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="294180899"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:25:59 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDwkfJFOqiIlPvPt5VlOsSdom3PbTCGQQNv/M+r8eegyQTxDKcu5Np8SlCJNiwz9n9DTtfxfdGGRpZkkpAlyh4QhhVKycCpzjmJL0XJo0C3lww/7BBTEXH20uvhFMfZ27+vl42I7QD62aZrVfOsJjyM9Gv9tZQe1GMNnfGTNhI46ehvBL0yhwp73NAZDWctGdgMxjoEvBKaIsZugRZ4sHJ1xrjC6gaT/Dafl3w1gJWmiA18iwSqC1Op0950E7v7XqwcwrV211m+KWMWD6nKnah3Kf43aWMzBGKltjqxChEUOnqHPMLXwowYrFydzKCMKjtCTubESCZw6dvfRHscTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqB+RPGZvFZ5AyjOAF1UUiP5ED7dGAFym6F6rB6FFLA=;
 b=t51JwRK88tpMJqk+fEVtKLajpVOnd6ZbJjhUB4woxB0BASwnWm3c3TUp/WHMlG4Rdnyb3d9HvORl3luCmEyhqtzau0y0xQ9717TRGE+pfKitBg/fQkuYMVhU/PbDqHlwA/yE4PKOZytisCjqtyVHvMelvOYyHDfAOlZOkchKWEXBrL5nmtY2zI3NIiyLvRWyGO+jHoZvHASnh73bkRNSftP4RzEw67ecskHc23HsnBab3NG0F93DoPdrE36o7InUi6ZXYTLGa70DDqAYfLTsz3sACMlZiNKnSYZbRt6CKl6owqM3pf+nNLiPTkNlbZfoBKWBoihNG9df3VjuYkhtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:25:57 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:25:57 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Date: Wed, 2 Sep 2026 08:25:22 +0000
Message-ID: <20260902082525.1149367-5-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902082525.1149367-1-krzysztof.karas@intel.com>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0200.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::25) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SABPR11MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d324c27-7ebc-4e63-9443-08df08cbd036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YnCFW1dSHgwuMRcOw/YERPar4mIV/nfYLwmZFN0GSh+vjipdBlHOIWCey+sstijo8J+6uHaV27j+9aTIl/+Q1Xtqq4Gimw9yY7ix3Ll2k4QCcgbMPl1EQ3AIOthfCH3AiNZxl0uP0ivyXXC2lJ1zzgtnO03N6fVYAPmIzRuQS8SODNLTANTnro3f/Mrpa5lWdEbRIyd4E0h+FebHOjDoI5ZjyI5bixg9AaagrNXUA3ZrLVoouHAWfsJft7mPgzYWp2OtTW9RfEfMn4By4TR6Hf0JxEnh5SoBQPFe4qkVng82iEg4lbF9eAO4W1pSfLlvqNFNSHj7mHG4YP8YxLfNodwGfxubYBJkQA5kDvLj52SnDPFHF9D8asorCWyXZQeEJlADxTFq3XNaxQ76GjiVgB0paztxxTzaHQB/Gd3EeN9mDZIbE1O9s+3/tujhMBJ8q+3Ku6mCr/YFJmg6CBjTiM67nUOJOpiKWk4iNiFCzn/tknizXo2uL+rraPeLerAjhj2LlFcSeFevUN4EMs5IEIb3zT8zu4T/QQ4lBEXhHheOh5iLOuFmrzzyEu4B2nnEWsGBwZy6FzmYW3VyaopNbt0p8kb4zOHZiPG2MQ14fjZjivpSPsqGa0v9FvgxiF9t8aj1mrCb5rauvdVyelSYfrWGuSMsso1UapJy0CG59w0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ii4jLHyJE+ApfuEqU5ED7xrdaARdtkDppCgSXU3149+UYA7jlqnuKfy9JLyM?=
 =?us-ascii?Q?jlc9Uw7JoVdkibE8MsG6GplioaQ2y3zrMzNMiO+pqoeah4kxbZgxojVpaIS6?=
 =?us-ascii?Q?xLQ+v0WHkuiu2uvIRohJN7WrhGf8b733i2h2mRvyBnV63lmOzycf2Gt40IEB?=
 =?us-ascii?Q?p9eTKKeRRkvnwvRgSRWNYgdFDkCj31gSCrBPZAuxOIRcpxzETMVebvRAoxd3?=
 =?us-ascii?Q?BZCPN5B//fhw3X72T7rkuWTOjcBscfy/XlBrk4QvkgVkyTQcJkIQ+21hWx0T?=
 =?us-ascii?Q?eHi68lkeiuL9uZXMm16TDOft5mEZHHjasrwtdq00YKls39VLI8ka2Ih03vCF?=
 =?us-ascii?Q?I7iYt7QmP/3Cu0EFbIen8mp1led/UCiGNx11cZVtdm7Q6S/LoCCnOJ6Z7/nm?=
 =?us-ascii?Q?m/MaJar6i9gUe1U8IMzP/jbuB1oipg2PV1DFYgMiwg6D2SZHvaLlg7LocT+X?=
 =?us-ascii?Q?iZy4UiwCNyVPUDrmxP4mxTMr/UPjhPJbO8sIvXmZuQku6b4AoMU7zGY0mR6I?=
 =?us-ascii?Q?AUrHWeh1S6LtKjQAF+lueoSaQMtMxr0kwCiHQhAI4ttmUCtat6Aq+53wkV7O?=
 =?us-ascii?Q?5wMYeKPv/mYB4nS09jma8CEGffAzahWPAGIHw10NlFe6GmrZGwmKxl7wgHGP?=
 =?us-ascii?Q?9ZGjDauNoowgd3uUHTrsEi2/2kirhaRTdDm3RbZoiBo9g7mneGQeIew6Wbaz?=
 =?us-ascii?Q?FsfKkGlVaKcnS9F+xGh5VsA7o+R4xzn7NQWivwAn5IxYRJf8xfh3L3g9Hfy7?=
 =?us-ascii?Q?n3zFmawHqxI9Gyj017DE6bkj/zdWJX/MCCWqpDu836K+rTYlRhHTAMGLDopP?=
 =?us-ascii?Q?CmAENRrGA+52GMX3Qoo1033obXOKAX14jgCNYto6pENcrxXCd31SHFn+dhVE?=
 =?us-ascii?Q?68SDtVzPCCjs5ckKySQpISQaXGvAfeQhZAVxUIVRmXi1xU8mpjKcjdbaSua2?=
 =?us-ascii?Q?p6SR2zQW+/2LSeACMMdgOnnWZ5Rr/1n0PLe5gYSoVLATlTAtKLWJe1sd8cWm?=
 =?us-ascii?Q?KHbtfL8FrjC8YMZbTcApKMmiqKb41ao0W04q86wVJ8TxXOcsvcM11tMVOddI?=
 =?us-ascii?Q?750tcNs72B83evM2KU41080x6eCVHdFRyBnFx56JTkAKTI8UdJUffF1Yf9An?=
 =?us-ascii?Q?70jGtxQN/YD6VUD8o6uD06qV9eDaX5lALsX52BlSv6gbQAZYfLA9LOlqJ2Vt?=
 =?us-ascii?Q?PRHFVdsgSbkQWp6YmLiQNWbuqQNlzOLm6rF4qFTeBkRjQYU/vBQXRw1+DD71?=
 =?us-ascii?Q?TbK56ibxjz7SrUUtYqUsKKwm0THx3dCQUyoYcw5oBe0Yv76xHHxFFnaXN31c?=
 =?us-ascii?Q?nr0o25l4UjaI13tAaPKz0f3Bp3VDeKpU47YsNIbrc5Wrfin0o1qcJdKUHkfp?=
 =?us-ascii?Q?Ht3JfH/dhRafeDmHQSM1FSGaM9DQY+2VZZdeKTwH4UUgXGuIzTgJbJ8o/rPg?=
 =?us-ascii?Q?4wvoLt3Zb8gyN6HPYbvoz7WnVuVOlaDHXjAVOP3jg+P5Y+YCaCNs1Vqtmnrv?=
 =?us-ascii?Q?KA7b2P8HGKqFyPBHzKVGZuhfmhJqaD1oAV4WMkhf0XIqYmBnaKPZltVpY8IT?=
 =?us-ascii?Q?onN6qXzNTgXXSVDmGYyUp4MnDQKOfrLlJBxqRpmtl91Kg8xkjIBI1+rd7Xui?=
 =?us-ascii?Q?cl7Dk3hJl2X2k7QF/PWdrquGznGY1iauNbbxsV+NwscS569USvztSw6NuWGQ?=
 =?us-ascii?Q?9KTCBCWZWoLoJG+004QtLwO2WvZVJoif9mLVZpl2Llbc06smxeoIQJf58q+W?=
 =?us-ascii?Q?OaHmit2xrEq2zVJ39iXErvwFyrBT7qE=3D?=
X-Exchange-RoutingPolicyChecked: FAsS1bpR02jC0s7TmNpA7xMrGtFEhwfd0AUeTwAUsj/ABqsuYGiAvekMr0P2e9gveYcNbxlRXfM/8lhI5dceVZYhrjccADgmEiCGpfAechYM4OoAvNbWcgTb1odavk9T0PIH/6QKNIqGDi6S96iAWbv15FBpUeZb1WJxExXWCUAccD4mJF8X0ChliQm+T173XPQo/H4yYnHnmqN2PmkHO6OEp2HSkmMwwwJ905ovOFyBxRziCHdZkh9/ebKAV/UukXZjkIpxdkL1WrYrI2GfM2b0ujjMRG8MRJA+v3oJnpeijsZ8n6LMFY34O2i0LKfCURW0qSnRdcRF72gOB52WQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d324c27-7ebc-4e63-9443-08df08cbd036
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:25:57.5598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAv/+RPjc3DYEBxXnr+JuL/pAhp+kpDfHMHTpxjI2oRPhJ/nOK19UVio3p+8is6Zgdn7e3gfK+eiccJEIpua87E40EFi537zuZSX6/Kn3qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
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

It is possible, when a very large mapping uses only one
scatterlist, that padding overflows scatterlist's length field.
This results in:
 1) silently wrapping the value
 2) smaller than desired mappings produced by iommu_map_sg
 3) leaving mapped bytes in memory (no iommu_unmap)

Address this issue by adding overflow detection for scatterlist
length field.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * dropped overflow checks on s_length + s_iova_off and removed
   s_length_tmp variable along with
   s_length_tmp != 0 && s_length == 0 test(Robin);
 * dropped useless limits.h include;
 * addedd Fixes tag and CC to linux stable;
 * ran final checks with Claude Opus and added a tag.

 drivers/iommu/dma-iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..05cfd51016e6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1477,6 +1477,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		if (overflows_type(s_length, s->length)) {
+			ret = -EOVERFLOW;
+			goto out_restore_sg;
+		}
 		s->length = s_length;
 
 		/*
@@ -1493,7 +1497,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 *   time through here (i.e. before it has a meaningful value).
 		 */
 		if (pad_len && pad_len < s_length - 1) {
-			prev->length += pad_len;
+			unsigned int new_prev_len;
+			/*
+			 * For large mappings spanning multiple GBs we
+			 * may not be able to fit all needed padding into
+			 * sg->length.
+			 */
+			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
+				ret = -EOVERFLOW;
+				goto out_restore_sg;
+			}
+
+			prev->length = new_prev_len;
 			iova_len += pad_len;
 		}
 
-- 
2.34.1

