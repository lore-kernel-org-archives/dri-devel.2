Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E3BCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA74510EE6E;
	Tue, 29 Sep 2026 12:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="di+LRluI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E6610EE6E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EueHNRcVQac84xhTf5mGEcwMUSXc+64uiCNfAMQ/WYaEro0wxZmE+Q8SwlbznWZNi4PhbQiNRiGls5sNNKjr3BNJ9Mg9Rfg5zGMqd3wca/iyuYP0eC9RWlR/WMDsj1l/IA22DXLRk2AoZ4piZ64P+7AcnrxN8ivCHR1DF4C59L04e/A7cg2n0OzBumzRmXglm/KDcUe3b8ZG435gd3QTpQS5u/z6pUvSAhBZlhhy40KrZGrOvASOnSzMnJ78Iq+Ynes9BIUYj3lFE38+k9vE8iLlrS4SZr9BTEeNUaQl4qHltt0osdH8CQiGuSjFycptUKflSPNgRSrhmYcGPIpYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al/UBYHE+/xo9e5AfOmSk1P7TrhRh5H1m/yoTabharw=;
 b=eKIu4pSav6YcL1oJOrkKIcwP01PvoRmoXtQgwvmt5lIlUy5T2AJQcuGQJxm/zkd391NDa2dKbXks7b8yGf1JvwHVIBGR8ejAQAOrHA/c/oqoX9d14a616UC/+kWNPiveWfThswR4Oq2xKL6UK4hf+fwo0ADj3PCNnH8dgYLe1LNuZ7ndl+8mhKX70H4rlWe9zV0kV1UhC4UY8/yLeH6fEmlkNIO2skxPIxi7PffE2O6hU3QRRVV/DYhjP2jWtR57efB/iJiVMC1kQiM5b1nEeR22kMFbb4SNE6xym9nWILllp21ssT2GRK4B4lVb1W0dOT+VpFAzurkz2EM65Fsydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al/UBYHE+/xo9e5AfOmSk1P7TrhRh5H1m/yoTabharw=;
 b=di+LRluIdURrpxsABOB1oWi5L51I1NtizpnBY7u2JKw1xCZVAiZTRSRefF5i/MNCxTGVD1A33yqLjUT4dV16YJ1NaXGWtq5l12/X/GpliaeodN6NfQ2AhUtE/+sZIwPVn7JgXarKAmqXuLl/J2PFcvNFprTHWOcI5+9TBk5twZH1j6ntDCUszkXXrqErkCj8BOqqaP/eMRhfP74Z5H1UBC5dsKXAv/7BwMXGK/TOHa0g+I1doBbyG36f/oDCOs0R6LZwHkMIUqZzuFUaGVcqiHs1u/QZWjDJ1Oejgw75nrYGsNTR2kzllIh2g00D5g7Et/EKv2otc1vYlp9BeU9/Xg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 12:03:18 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 12:03:18 +0000
Date: Tue, 29 Sep 2026 09:03:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: sashiko-bot@kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udmabuf: respect the device's maximum segment size
Message-ID: <20260929120317.GH1616761@nvidia.com>
References: <20260929054835.94118-1-kmehltretter@gmail.com>
 <20260929060028.371041F00893@smtp.kernel.org>
 <20260929065601.99518-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929065601.99518-1-kmehltretter@gmail.com>
X-ClientProxiedBy: BL1PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cbfd87-9cc0-49be-30eb-08df1e21a670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|23010399003|376014|4143699003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ttpBtk++R6iRJ2y0jgacfzYo5A2CdWflHtQU+gi932an65oixACI2xSFJez9cBPFLE73GZcz3XnZSwAg/d605l896q5z1vko6HH4ZpGV105Kuwv14JNI1MN+NoS5y6Wq71bP3dxiv134h/uRP3ulGI9aasKAM1AZdlORAxAnjN2JaLWr3Yw2v308vRQ39sUY4IDf5zWMblcU9Uwy//1uQTehONf7hAmjJTckc4KXUVTXHfomvaipRmgXKikrp2yVousuPkjdB6vuH15ZGj5lEWw0IYdJlYiVDXiCT2RB+UIz2njdfMNwEZLP3qEOc92IQx294daqxmQhRCko65NNSBOSk+vTptTAdCAAyHanPfZTFQLWbck2zf/paOSRgr7mkhJ2jldnVu8hmbTJqYMvEJN1RO5ShkeUpVxwDGFD93tEXG+jphzAZ9+MnZxXwoApkwvvRjBu2OSO+bH2U5wdZM/5IGjR0YuLTxLvf+Ee826SmrVBgPszNHHysTktwyH1CSAU2JsotJPj1D/7aFcqEj/ZGEkUyAGbYMRWFtY0s2jh53iaIsRbc0vWh/fPuAZhJvMmdpyprIPWk3jXWo4wDTDIu4/ZnfvPgZc8dw+WbvrL4PUS3CPCba4Noa2zvtAvbOUWT+ki/2kjKBed01dAYPkpHeDMMKbhCk0Y96ArO5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(4143699003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fHCFwXod6qKncq59WtT4XPVLnsS8o3zt2UORQIjlg2f6QtmouO5WhVA3hNu?=
 =?us-ascii?Q?IBUh+lE37aSvm3XU1cAReunJQZUOkiUqGY+bRQb58GszP+Mzt5oIigcnWZnH?=
 =?us-ascii?Q?Yh9FkUETnIbLBWkv74Gq5vv7Y+e/OBqFFX2QdmY+N6jApwVPoPkNSuSFTNPx?=
 =?us-ascii?Q?RpTuXxJ0EG1476IeSGFD799bb3zneuDIfAVWxerUel9a4EocgT6098wx8/PE?=
 =?us-ascii?Q?Grb/i+WycR9zbMWLJ6ohBr6sPbHtqCIWjDmQeRF3cR/3kAknSZrYQ3LcxgLZ?=
 =?us-ascii?Q?wVmJGsFE17x6rBm4pVilyK0qfYSNjquf6ql8z4ztZV0WP3NHUn7v5se1wo4f?=
 =?us-ascii?Q?0Xs6OSzJvUExVx5OXZg0tm1PeFLmX48X+TqkWbiv0M2lXHctMsSiYoDJF+RH?=
 =?us-ascii?Q?iqN1ul8iRvYNV6+FtKrgWPQaX4DhSXt5yPk1+OwiqeLNWGNMjhUo9Sp7Ooy/?=
 =?us-ascii?Q?8EXkMnosuu2FheXvmwLKH9uoJ+IGqPRsiCryL10pXUbTwAv2ZpGZczk9lfec?=
 =?us-ascii?Q?q3j+qv2RbC57o9Y/piJRV2I4/szxAd4TSEYNfHwMkwA4aFOG3KxxIyBHA4Tz?=
 =?us-ascii?Q?9qnOlcp3hZjfeFx9uQu+wOm5nBqzo879MYFl9lGVogp0P4E6Wze4obPbviOv?=
 =?us-ascii?Q?fwbg/0VIWozm0Jy3wOFztY0lXtgJQySwDSJtQ9zeJdYw5MeWPpdnVsSwL0Cm?=
 =?us-ascii?Q?/gYTD+nFRiNhZq8G5ZjgyLXDNvZkTcW9vSXAM2+DD9UUfmy/gMwIZ4wL2AOQ?=
 =?us-ascii?Q?g8/YMi/3AnkBWHNsK+lr7+PGYUQbAMP4TsBRgl3oC5KG8aCKc5y6srROkA/s?=
 =?us-ascii?Q?p/rH0wUZC48jQLAZyNjy26biXsyOholdngZxr3Bk4ASJ9wEbtmirs4e17Jon?=
 =?us-ascii?Q?uL6my3hDVR8sj4b6MRWf0is4cN4FY8Wt3I80f0Ksg1mD2WWUJoLSrb8gC5uS?=
 =?us-ascii?Q?ZzOtqsR4w+vAIjAyjSLWX9ilMF5x6bwqJwE8q2kkANUmbiLnBSOjrX/gJqx/?=
 =?us-ascii?Q?F2N6JpBMHKSDTACYS/Ao0JgDquTPK86J+CgIXCYGPD7fmAVSC4sNJJpiLBG3?=
 =?us-ascii?Q?3HeODP4l3WHJyoBpk9ZAy0NazNrR2rTasfvfTkyI/n5shU0/DAKNDRT27ew/?=
 =?us-ascii?Q?o2sgT93JKf0NDJ3H62ikBrw7oPRW8Ljvlc/6dlGH16s4udfJTe5XqPDa9X91?=
 =?us-ascii?Q?aLFCCP3S9Mb5NVqRtu/W0XE2/3KLGCEM9ZbntBDpPN/F9TAfCVcOWjXqeOhR?=
 =?us-ascii?Q?aKGodkjy6i2f3YCuk8pOpcWtDCowMXppKingTNOWZrT1DBYK/M2bcLsHcLLd?=
 =?us-ascii?Q?QFWajYqsWjb7Y1tAQvXo+NvfPlKEJ+do4v3csn6zeM/fN6o/qUHlVmEakiAo?=
 =?us-ascii?Q?uwOBaQ7FUt5EwjMU2JG5WMzESEo4KeaxlGZRD5rP3PHITGNiRgfyJiv7Er+C?=
 =?us-ascii?Q?RXfkeh1B8glZQmggJiCYqeXxkTdduEe4XowGuvRTe7/3cCXobf0/8ZiyIA6Y?=
 =?us-ascii?Q?aPsorCtZpinhvzRtSx9pST5n4lTBpOBFHO7mPisXmfmFJ7eDG/r4DiUb9+P/?=
 =?us-ascii?Q?CLGjgPznHqymmUYH2l4/1Lzgd0KwIHRdg1XqYFT1t8scwEYQv6TGl8IzyFqr?=
 =?us-ascii?Q?xJKlmDsfRHqffcaQlENaMRIQ/u9essuGDzXPvaV00fY0/wWdxMJjI2D1JEs+?=
 =?us-ascii?Q?K9RjkMSjvcNXfuHdDQbF34Oxst1LSji9LOjEdCOwLZ09p8qz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cbfd87-9cc0-49be-30eb-08df1e21a670
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:03:18.5770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODHmMjz7E2aHPCqIkFU6tI9oSrCOPT+XUnOsBaGb5U163cdeYxJpWGiGz6KoG+YI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
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

On Tue, Sep 29, 2026 at 08:56:01AM +0200, Karl Mehltretter wrote:
> On Tue, Sep 29, 2026 at 06:00:27AM +0000, sashiko-bot@kernel.org wrote:
> > On architectures with a 256KB PAGE_SIZE (such as Hexagon or PowerPC), this
> > new validation evaluates to 65536 < 262144, unconditionally returning
> > -EINVAL and breaking all CPU mappings.
> 
> Right, the misc device has no dma_parms, so it gets the 64K default and
> sync fails with 256K pages

I would ignore this, it seems fictional to me, and if someone really
needs to support this rediculous combination it should be done inside
sg_alloc_table_from_pages_segment(:)
 
> The misc device has no real segment limit, so for v3 I'll give it
> dma_parms with an unlimited max segment size and keep the -EINVAL for
> importers that report a limit below PAGE_SIZE.

The params have to come from the *importing* device, not the udmabuf
misc device. You don't get to control what they are, and there is no
reason to put a dma_parms on a misc deivce.

Jason
