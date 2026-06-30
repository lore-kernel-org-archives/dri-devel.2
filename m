Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1329C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1389410E218;
	Tue, 30 Jun 2026 11:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hg2VDauN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164A910EBFB
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amHpzfUmKT8sjyK1getHmVRb7HA//l56eGC/7NYzz/S6+5vVBCqW3GwfnP6gjAg0cWO0xP3C8FvkISawYq6ua1FH+05DE5ZmtBM3z4liRJLPWMIzeFTbRlHaVJ4TlFnqfGQPW9yXUjZ4ewIJPrT9rCmdCS9MREe9LW0o8gGl1uzlqmY23mQ+dzHC/l44I9vZP+EzNXqO6F5DJalQBhYpCw9t1jHaOd8xCgoAnvCfT7b+JZV0R0bQ9hc8DAZwFMTuUKXRlyMQrlzN9nJ343DAkf6SH+l4PJYQ/QmHvLs1+iakLBquxNzeBiJv/LXSKDC2jvizGn+9DPOchbJs77/qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp79tQH7KMc37nwA+N6aZ8h1FW584mX854f4TZHP1qA=;
 b=P/YRxCeledUK7kt2AY9C0na2T/uDwWN2PC0TBsI6Sb7n1DoR9NhN+Ara4bjFs9afR+PAoMMxFjVqDELVcFiQikzYExyOLxKTo/RZfJsdKx6BSE/0iq27RZxkhq1BId6jyhPril7I+nhHl4aJYD/Akcq6gGDO7chsTmoXQfvOdd0koYWjTQGTVJn9iVIFzMbVD564fvGAYDPg1alqz4UmbwMHJqE4lCtf7/2NG7uHoGwtwScDV6YvQh7V7QwqJ71yjsEABQ1LRYXXt3qBFtbQ5w9hygVhUU5wQIu+oo+EOBvjSOhhhJ5ozSPwjesSPgMXfpZ0N1eECarCdSnT11r6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp79tQH7KMc37nwA+N6aZ8h1FW584mX854f4TZHP1qA=;
 b=Hg2VDauNmI0dXqInG5GKrYfRi4Mg9IagBFJLtkQz373h2MI9X2v3kxWRrfvOa3lPJHmMK+m3tIHB9BxHehOpDV5OvU65ECdZK3o+oKnAjeU7By0nXVprUm44S7AcZn9xLHckHaK00mNZGBgn7BtHL9hmJX5r2qgj9UfHLSN1NUbyTIjcJB/dR31B44CnwpgsCqRQM86oVGIF9Y+abVS16LSuZbcdK/4sFshO8SNqUeYBDho/9BOEOims//4mRsNUIuZ5RLUEi1ChYseh++YG1fY/1alpZ4MGCOyNaf5/QvIiaM2LtM4fIc/2t/0wtqP3zoVvXn9rsZuruGp0yaeg5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:51:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 11:51:51 +0000
Date: Tue, 30 Jun 2026 08:51:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org, Alistair Popple <apopple@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <20260630115150.GD7481@nvidia.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
X-ClientProxiedBy: YT4PR01CA0442.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: cf71988d-8e50-41e0-ef7b-08ded69df959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: JvHCIF5cFljM89aZpmLqL1VfojLjjc2mjzDQ3n7pYs/JJszCB9Cc/G+hmDjArm7XgmbpSqO6fJTUH/ZkRME/oDo9blaAC0riOcEgAOTYXg3cJUE2AO4Rl1Z0FHx44MP/ZGMWLl4yVDaRa6SoUW72g1t1OeJAmBUKR6fAlPC432QIvfbweFenclnabXA7p2KTG2o7h49nB6Q0dQ2QTKN6i8GyQqK7nr1oMBu6sG/qCjNgEyOJMKD7sDsQkoHz5Nnxi7+6yiJc1bTRDeFARZPb+oSfyNGq3L9cjzRS5gXx4DaEDTrXpXOP1oFqESZrGfYEjXctqCJ6Xb3nhNSGMfIS0KCaIjf5mDVNd/ZWh9TAM1D71TRjQJ8+qXq6NZksfsi8a2VBGjq21BDcvk/22G0GLZAZI0bu5AEua0ycDFLeXTt2VXtkw5hMeyQGMWB91wK3s0dGuC5AW9OtKwKQR4NbUjrVRuDBtDy5Go/iG9qCTOERAiExTDNDn4VtxpKS03iZ35v9BylfL9JhIfXa8GggCykpZakGkfJfxaOtDk0Coy9d3dxxaZYcS3h5bmqBE3Nopku81ZYOyl60Npq+G/wXFBCGqrDTKc60llyjcQ+fGmO7nheEDnXBpELbKAhz1C37ZpQy/bkmcWcLgJDh30bN8NG4MCQRSDSZanVK4RysFSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVJWVV6NitIY3JOOVZIaG9jWEtwcTUzZVVMLzZyOFhDU0dnVmYwQ2JKRWdh?=
 =?utf-8?B?Ui9BMndRMDNYTWpSNmRLamV6dE55WFVvaUJZNlk1WU1PVUE2WHJEVDdVR3Zu?=
 =?utf-8?B?UU1SRlVNRnFHR2dXSjJkdVJxbjVFTVV0OVU4YlpXSFA1Zll6VzVINjVLZFpF?=
 =?utf-8?B?cjc0ZkhLOUFROE1LSkFKMlRqSCtDcktYeFo4c0tHLzZ6dE5CWkVJdit3UFJ5?=
 =?utf-8?B?c0IydUM5c2puSmsveW1CZDcrd2dNMDlIREhGQ21YRHJySW1KUmN0Qlc0bi8x?=
 =?utf-8?B?c3c4R21lbFJ6b3h6YXdqVUxFTTdiNnRhYmV3MmZpQk04UVJVR3VIOW5odE5Z?=
 =?utf-8?B?WDIvcEp5dEx0OWRIaS9mVWh6UmZPeTMwTVIwbTFqUW1rdEkzUXNNMWtEYjg2?=
 =?utf-8?B?SDNsT1NWTi9OMC9jcTY1Tm5kYWh2YmR3T0M4VWRkcFp4YmJ1YW0zS2xXTkFJ?=
 =?utf-8?B?L3prU3lkb2kwM01BSzRqRHd4RE1aa2F2S25iSDY5dlFHYlZsSWN1VHlSSkhE?=
 =?utf-8?B?RVFLVTJURWRLSVpLSWx2MWJ0dGZlTE90T2tNL2xodVowYU82U2FreCtzT2Zq?=
 =?utf-8?B?NnNRNWJoVUVyMmlhUWUyNk9KNlQyOWNhei9OSkFwMjRWbHo1TXdDaCtwNFZu?=
 =?utf-8?B?UnBJMXFJbk0rcXNhc3I1QkRnSkJ5ZEo3QlhDRU5PY2t0MjJVZkc4dTR5S1M5?=
 =?utf-8?B?cTV0bmxjSDExZmRIU242S3I0K2VrOW50MUM5a2lFaXZmRkhJK3VzcWlZUUdl?=
 =?utf-8?B?OEpDMGg1NjhIUk11VEJVL1VzZHpUTXQxMlRIYmZlQm5Qd2dkNGlzejFHMDYw?=
 =?utf-8?B?b1A0VDUrODBvVFk4eHlkbjd5ZkZxL2VnNjJ1TVlxRTRUUE9IcWowQ2x6NHFS?=
 =?utf-8?B?VG1ieDU0azc0NjRTbVdpd01VSVZqRE5vcFplRW5zenNNYnZyNzhzWG9RZEJM?=
 =?utf-8?B?VWtsaTMxSVNVbTViK3VIZmlKRDBOL1dJRElkMnpzbElHS3RIdXlmTnpPZHlX?=
 =?utf-8?B?c1pKLzFVb2RMVUM5WVVGY0ZXL1R6TWs1cHUvOHJGc1RWNmVBOUVONnFtWWhU?=
 =?utf-8?B?NnBtVXVzZzdkUTMvTnBWRnNQMzBhODRtdW00OEJhY09KR2xCaFU1V01WRHd5?=
 =?utf-8?B?bTZkYlMyUXY2WGFJL1NlWVg3TVFEWEs1ZWJkWXhnQ0MrajN3QTQ2QS9sRWlw?=
 =?utf-8?B?WXd3QSs5aGRrKzJvc0Rvb3laQlZFS0s4eGxCNTRtYmZ0NWVnYWlRVEM2bG5i?=
 =?utf-8?B?NmNqZytWaTRKTlp2UlpTbzRVc01UKzBWeVVPTGtnM29ncnE0dmwrb1VhT0li?=
 =?utf-8?B?MzV2YktuK0F1WWtJY29yYWhVZHJrQjNnempBa3dsRWF4bG80ZlYvVWx2ZW1S?=
 =?utf-8?B?TWo0eXo5ODZzREE1bHVBQ1NmNTNmcW5IMTR4ZWVBMjJLNlNVZ25saTNpQUVG?=
 =?utf-8?B?L0ZaSGpTemRzazVxM1E3ZU5oZ3hUM2NNUkllTHhDZWQvUVJhMVZUcEJhWlQz?=
 =?utf-8?B?VWUzckxIbTUxdVBFR2I2ai9jbU9CR0hCYmpqNW5ZSks2RDhpeFh4VXNiS1pr?=
 =?utf-8?B?cURWTmZHcG1vc2Q1OE5HdW1lWm5KZ05NRTRTYkprQ1kwSFNOUFZqYVp1N0Nx?=
 =?utf-8?B?YnB6RHEzK1dCSmp0YlptUVg2UWhEN0VGM3BqcDY4VFBCZTFFTVVUbFBRcHJi?=
 =?utf-8?B?c1RFNmozVTJFTnBrNWRyTjVwYnZ0YnUvY0pQakNFb1Vkd25jQWpFYmpzaldw?=
 =?utf-8?B?bWhhN1BZdW5lQ215R2R4L1pGcEtvbG9za0tTTDVPelorNnBSdGtWdXQwdEpM?=
 =?utf-8?B?c3M1THEyM1B6QzI0Qy82ZVkyaUZ3elZiRHpkbE5TN2hZdnNaRjZsSVBjN1BD?=
 =?utf-8?B?Um1kUXprdmJBazRTT2Vqd1NXdXQzVHBwN2QxeFp3dEFsZnloVUIzZlpOTE9v?=
 =?utf-8?B?TnNxNjVaY29VM3FzVWNNNCszMXpVTGxYNnk5WFJrdDhYRUM2SVZRTDVvQWU4?=
 =?utf-8?B?b0NJVW4vTzZYMHQ5OTlSSm82THR1VXVyR1o1QWFJL3ZlSUhSNWRiWlQ1b0xl?=
 =?utf-8?B?M0lRSXJQWmVMdURpcFBTcm1qbWtQc0NLYTBVZ2RxeklxRE93NGNVV1FNOGMz?=
 =?utf-8?B?K0N3Z3l0RzdXTlNDNnpEWEFsaHYxU3l3clZEYXMyemg5cHpTMkhMY29CZzlW?=
 =?utf-8?B?c3dmRkFrOEl0aFVFTXJ3azA1YWJzc25ONDl1L0s2MnZqNUt5K2cwK214Zk51?=
 =?utf-8?B?ajhUR1dDQm9SeFJSRkVHZlBxZVYvMEhaOEhtaW40TzRwYUd4eExoSEY1RTh2?=
 =?utf-8?Q?gjqid1DFD1PtROtK86?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf71988d-8e50-41e0-ef7b-08ded69df959
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:51:51.7203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nvl/HY+s6Fqflv6ZszYtfc6i8xyjDNMcKsDQboCylNC/dwGnVBadNPuenJ41MhvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
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

On Tue, Jun 30, 2026 at 01:24:57PM +0200, Christian König wrote:

> > Today I finally hit up iommu.strict=1 makes things a lot happier,
> > non-strict IOMMU seems to allow a race between dma_unmap_page and
> > free_page where the unmap goes into the IOMMU flush queue, where the
> > actual unmap are delayed until something triggers a flush later, and
> > the ATS translations stay alive past when they should, and after the
> > page has been allocated by some subsequent user.
> 
> Try disabling ATS, that was a common source of problems during HW
> bringup for us in the past.

The spark HW cannot run without ATS.

> > 2. split ttm page unmap/free into two stages, and force an iommu
> > flush/ATS sync operation after the unmap before the free. (I don't
> > think iommu has an interface for this).
> 
> Yeah that idea already came up on similar issues as well. I
> certainly wouldn't be opposed to that.

Only for debugging, it is completely wrong to rely on this for
functionality.

> You either have to use memory fences which use the same path as the
> DMA operations itself

Yes, in a PCIe system generally something like the GPU TLB
invalidation command will complete and flush the fabric path to quiet
the DMAs. That won't be true on spark though.

Dave could be facing a fabric issue. AFAIK the ATS invalidation that
the iommu=strict pushses should fence the fabric so would resolve a
missing fabric fence. I suppose if you don't see any evidence of a
non-present ATS response explosion with strict then this would be a
really good theory.

However, the GPU must have another way to inject a fabric fence. The
production driver does not rely on ATS fencing to synchronize memory
operations!

> So far the record for grace periods you need after a TLB flush is 6
> seconds on production HW with up to 10 seconds on engineering
> samples (because of HW bugs).

Yeah, if the HW mechanism to fence the fabric don't work spark would
need similar times to guarentee a fabric drain.

Jason
