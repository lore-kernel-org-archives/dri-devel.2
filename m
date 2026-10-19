Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF73606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bzu2r/Jw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE9A10EAAB;
	Mon, 19 Oct 2026 18:41:36 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5081C10EAAB;
 Mon, 19 Oct 2026 18:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVZaUB3DYEsjIdqK/Eibod6uGu84mGnogII1S5bIi6biA6yxurIwedBm2WwQRTPgZ/O+J3MDQWdNczCcu7KdTUqEpE+75qvbYqYNi1IaMKBCodH4cg2B41HIllRLons7xLYZqFmmIM943jQzzziO169cYiTV2r1kJVkqAUTFr2WdFSw8P1CnBRb6CKrP57h337dV/Hl5TcC89QZ6u0bRcriRvxaTPPuh/IQ0Miv6uGz/QvMCzE3QSLG6gvp2e84tkEv08toGcT8X6hWd96bRLHJm8YncV7YZKaS/ulEY+4ZkUwLwkxPWDUaOD7bPiUGdCCzp556rxzp4na030jgHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVYyPmgmY8Brr/rlJ6a6L55sC/o6visWk4Cshg7uCPo=;
 b=HRy1wdJRzverLdM6II5Y4J64TQaGuj6T8b5Km9IjDSOMxmVHBhP9AZy0yanV/7rZ2nH7XgXEra08bJZ//jp+rhY3/TP6krHFNKZ1cza8FS7eg/6nmxwbvvusPnpQi+b77RPPrDTscrh0kAk6BskHEaRN67x6tUl84TMyoj9qgpK3aapMm+T+J4tJqYP2VOGQrjT2b8FxS0TzMguWm5SA9yZdQMuN+tc+pD5n1RUy9lkDByyvlSjNP7HQx+0EOLcTxhmtAENIGkb9SC8qSQOmAwOUN4LETQH6D3xrdk75Ei22zulcqiCZpCu0Lcb8X0LcKJEmEVKWKkWoDOSzqVNQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVYyPmgmY8Brr/rlJ6a6L55sC/o6visWk4Cshg7uCPo=;
 b=bzu2r/JwBhEi7T1grqVZJ4I7Cgz2VtRqsWgOsXDWurA/cyYwqNE8IkeL5Trxnng4VfDoLp9g2n5qJlugC+WbPlVmYClnQDnACSKH4J8mWYvlFEQqcJP6ncGM99VpqX5XLv2q1jQg3PlV3Ni0LfwWswP4VjdcBfTgYUdLrcShSsRyWGD6HsN3ekT15EzA95nv383w2NauP5dSypZ11J+XuHCDKuyHL7kdhLTKFYmlbFHoLJEkWTdxlC9Ey8+/xBeJ4ZNoPa+DOcsdGPGfy92Fy7eCnjxyn8Zd2ZKha/EDe0c9rbIlhb3IJLSG2Ber92zuTGtI2+ZydzQj5rvPTQfDBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM3PR12MB9325.namprd12.prod.outlook.com
 (2603:10b6:0:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 18:41:24 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 18:41:24 +0000
Date: Mon, 19 Oct 2026 15:41:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
Message-ID: <20261019184123.GR13920@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
 <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
 <20261019133031.GQ13920@nvidia.com>
 <5f57c49d34f2812b0b68be71218ce0a9b6510c14.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f57c49d34f2812b0b68be71218ce0a9b6510c14.camel@linux.intel.com>
X-ClientProxiedBy: YT4P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::9) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cceabd-f44f-4c1c-4687-08df2e1093f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TNUSVWdzh6X0mmwX1SoG4ISL4VsvjeTrkfARDRnGsMR7m4kMMX0lvf4/HFmaxgzsqE4Pg2SRTn5hmXTukChSZEdvAn2a5PCcRCTt9+hC9ipKNbND3s+iLM3PD8LgOTBPNQgI15VHvVFz1cY5MHi0U2hyCN38JnxbP2Bjg/9dHuFLhk2HMn0zPgBQnaQXS1wmgbyPYet+an0YkyPgjM616Zftp6OA+Dop2115l90/HGUsN+yvGeILOEq2iInNVtuAxMogDDQt+WeOoVsn+N0h1z6YR3REVQg5hp7CaiBfCZq+WYILlR++NVwRjqWolSiiFfy0kYlVL8NoEGS9ZHO8ycqVy9scQz13vutVy8L+soJp+p9usHjnrtA7+rbky9zxh6/UHK3lOOQ2j3/g7hyCRxJUlkEFortCcY/ocW64zKmRDBAm45Cq/Hf/2t49tIVXTxbl6qJvr0W4nhVAfN/7NL/5biCet5fyFyUcufjD0IliUciEdSVe3H/mRi8dyq8TN9c9uM3yOq42GMgatEudsB2Z4sHV4YFeWfYFcU1cdPk0vehel7CIpW4xlEF+KeX8PsCwBSAJP1xHqO/ODO39GHU0X1f1u8fTbnrP8UzLt9gpxbB0WW1HWsY/0I716VRMiNWpUeigoopmxqWQUpLe5NmlXdLNM3EbUCHF4dhluCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9MREdSWWVnQVpjRTJqcnNhY1N3VVF1cXNNWG5WOVgrR0dnL0tpeG5kNkY0?=
 =?utf-8?B?cWVGdGR3SUM5WlRKYW1zUW43b280NHRUd05XQU5vQnVMcWY0bzNNZ29RU1Rq?=
 =?utf-8?B?TkRFbGdHQWRjQ01ST3g5SUdhelR6Qy8yY01xeG1xaldXT21XQm9CR1JrV3dh?=
 =?utf-8?B?bkpSKzBEdVV6QTB2dzY2Q05uOHcvM2pkczNSbkRNN2g4dk1FU0pJNFhzTFJU?=
 =?utf-8?B?elVpNnJkOTNMQjE4QTEyMUxES3NmWWZLY1dyODQ3L09iTGx1Qk5jb08wWDk5?=
 =?utf-8?B?dmpnVFh2Ykc4WCtaeTVoTnVRNEY3T0NxVWZnMDF4ZkhTQW4zNEZMeVN6MS95?=
 =?utf-8?B?Q1ZxSXl5SHVsYitZWFlOQWcvYkduTVpESTVaZGlOVlJtMUN5bzdUT1pjbWE5?=
 =?utf-8?B?ZHJ4ZDBkUVltK1FqZ01kU01PaGdyYVRreW0yb0RWSzlsOVlpREh0NzAyUWZm?=
 =?utf-8?B?QmhnSkxHMzZvbmc5RVJ0Vk1lOVpIWE9iRTJMajNXRGdtRVhBTVJSRGtnVlBX?=
 =?utf-8?B?YW56MEpuYVplTFV0aHF2SmtNWmdYeVFXNHZhSTZtR1NoeTBSaS9HbkRaNUtl?=
 =?utf-8?B?UzVVc2pvdFpTMi9ERVRxUmxONm9lZnNkOGlmZHluSkwyWHh4bkJ4T1V3Yzdm?=
 =?utf-8?B?M3ZrTi9DcUd5SlY1dGUzMHlZVmp4bjZsWFR2UFdzYW9oVGhSMkU1dmVDZnRL?=
 =?utf-8?B?aGE5dk5JeDc5RU9BcGxHbW1ZOElRbVgzYzd3Y1RjbnI2Y3Foa3UzOEMwYWw2?=
 =?utf-8?B?RTU1a3BhbGNlMFU2Z1N0WHNKWUxWa2hIUE13SFdvckZ6aExoZmZVVWRXMDUv?=
 =?utf-8?B?RUJHVURSNzVUWUxPbGI5eXF0aXBHeUZMQmwvb25jRENQM2MzbkpMcDhuenFp?=
 =?utf-8?B?T3NLdURCZ2ltUmJKRldpQ1BjOERIcmNvK2VCd0tMWDVESTY4V081WGZacDYw?=
 =?utf-8?B?c0pHWE9pbWtXeWlHWEtnb2Vyb0J5UUpjSTlubnVycFFHWjQrU25KVkxaelRa?=
 =?utf-8?B?djUvZWNkQXlaUHlUUjArT2JXY3kxNi9Fd3N3b1RXc2xWTjBWa0ROWFZ4UStS?=
 =?utf-8?B?UWovOS9oSzZoVXhycnVjY3RmQmdEMzZsRkN3UEdCcnpXaUc0ZzhtUzR3U3dE?=
 =?utf-8?B?R2J4eHgzSUtPRCt1dnFDREJGRG1XaGVZaFI1TWx5WitCRUs1NFVFVjlyd2c4?=
 =?utf-8?B?SGJaWUZXUis3d0JQekh3aHByTHNxczZxblBXd2M2T0FFbFVWaG1XYTd0eUxO?=
 =?utf-8?B?UGFYSDR2Y0N6OVdPYVhOdklNTXE5RFpBT3RobVRyaEh0NXVzT2hjTUFLN2VL?=
 =?utf-8?B?SXdUMzhRaGdYNG9wdWo0ZXdnOXN6OXZLdFlvR0FRbkxRdTRKRHVxM2xPK2JH?=
 =?utf-8?B?OG5WcWpIWlYyeWxhQlpzNzVwME43MWV0bTlzTEZDZTlEZnJIRFRyRmg0T0dp?=
 =?utf-8?B?ODdRZUUzVTVkU1FnZll0R3pZdGdoaEFpODZDek54N3NkbkpmTHQzNGx1Ukhj?=
 =?utf-8?B?NElwYldjRmtQVDRmejlEOTZyYmJQazhQcUM1VUE4ZXBRL3lCRGZGRElIS1dU?=
 =?utf-8?B?VUlmSGpFK0pMYW1IZUhPaUx2cGY5aVJCSjRtTGJBdm00V0FBVHBtLzJaaDhG?=
 =?utf-8?B?NWxsVjhaTTZRb0JCUkRmYWx2b1QwcFN4OUdnUjBITmM3aExrbE5XMUREdEh5?=
 =?utf-8?B?K2ZlbXpNcVhQaXF4ZCtzclVJak9SR1VjeC8xSllVRGNOdlJHL08wQnRudWJh?=
 =?utf-8?B?SVp5d09FLzF3ZkdaSEYzakk0SHovcGRDWU5oWjV5bTFkNnkyT1JCSjFiWHo4?=
 =?utf-8?B?Sk5tcVo0NldDdUluWFkrRytTR3pZaGhJVWRvL3RoRmxMNnlhcjdnMDBaZ2Fh?=
 =?utf-8?B?L3l3U1dLTytpU2d2bkhIVFB5eCtTNHpiK21CMWsxUEFVdzRkR0Q0T0h2RXJP?=
 =?utf-8?B?RnIyWWZ1WVpEWjlTKys2M3N3cUc3b2VVZTZjQjAwRlVFc21MVTk4b3hhSXNq?=
 =?utf-8?B?VHZNMHdmSzA0NHpjRS91NTBMODNoUUFQMGx4a0hsNGtYUVhEWUU1cUI3emVT?=
 =?utf-8?B?NTNKY0U2cTBpSm1yTmxDM2VjL3hOUG1qVmxIVHdWRnk0NEl4bk9JVjQ0VEYz?=
 =?utf-8?B?a25wWmFqUmtKZnZ2Und4R3lrM0lNaExOR3lqOHRESngreFZnMEFGanlGdnE0?=
 =?utf-8?B?TlA2WTRCeTU1RVlQQUM0Q2hYQkdxeDA4ckFSaHB5UHFwZmVDQmRJb1YveERk?=
 =?utf-8?B?YXdVWHNoeWJZWTJYZDFFTnBaUEU4bWtwVEVDbGpDTWh1TXVQcWczL21xNVRu?=
 =?utf-8?Q?Z3N+uHbFoqVo6io+wO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cceabd-f44f-4c1c-4687-08df2e1093f0
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 18:41:24.7236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08ma072+WEsec1s/yd1Qgh0rH31/7zE/rNKSbRYCMivAs0ZgoTiCxiT78d54dHiW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 03:47:55PM +0200, Thomas Hellström wrote:
> > Making the decision right before map seems like a reasonable

> > enhancement, but I can no longer remember off hand if that would
> > cause complications :)
> 
> It was that mellanox ATS thing, right? That's the only case I heard of
> that needed the mapping type decision (or at least a strong hint)
> early.

No, it would work after the fact just mlx5 forms the attachment and
the map approximately at the same time in most important cases.

Also after LPC I've also realized that UIO shares alot of similarity
with ATS, except getting UIO correct on both sides is functionally
required not just a performance optimization :\

Jason
