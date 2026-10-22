Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2581606A327
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NkzhPbpx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D7611267B;
	Thu, 22 Oct 2026 14:00:53 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1648811267B;
 Thu, 22 Oct 2026 14:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPVedZt8i6pAZhGCm0SFP1mHOGvSLURtJGp2/v8pEH4TAwdixZNL1PfCg3pJvqIasRgrdj3VEolFIX1H6cRCnQSevzlCMxUroW92IFgvBWIePQ4e+YOyK8BRjxA/sZOCxliCMN6GqZMw39G7loEz4sNUvZ7ZeaUwZOrm92+wGTPSc7mcmpX6auwr34Oc1KM2LlPhau/S5AxUHHLUYpUx02ih3aibZ7BPXJGtZq1Wm+7DInPjEu4CeNfVzoibP7x5ZHUIMjMUfjtx2AlQJtm+hSiJiMJCkm8sqkpJcka6fUzi2TXpHh+CNmkP4R69t3g3gAF9uqxrUgSwy+i/Kd723Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPVJIMVGuyY+vJPxZyj+rsE3xlw1I93BOVIS+paGTzs=;
 b=eaKuB4bCyR9q1gFEnDuPo7jUmZCRzY9FSL24wf+hAObKQByX9BbC+VEqSDIykwD3u4jnlPeqwfHps2WS0tmyQZ5qRM9gzo+7Sjuc+rZH3yBT4ZGF7PA7TZdgH0kC4TCFu9FXoAdxetI1HJ7BB1epEj5ydq6/bMywrne+jAsuYddJb5BLRKWOEkCJOW8Gb6Rl5NMW5bu9W/DTEZdHTwD0WWviSmoj/xGJEMCX4+rvQdR7y4EUrbbUOJ3sEE4xOG6CR8PHPfD+6QObwxnzo/1mScKCS4R8me0fJh8RVE4E/AuUnSXw5dXefkShNYcoT+z4z3heBa0uWd+Mi3xecRwTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPVJIMVGuyY+vJPxZyj+rsE3xlw1I93BOVIS+paGTzs=;
 b=NkzhPbpx8xmV+DBUn4tUnuoEdd7z3ZLLwj9vjse4DDkaTcY1ddmZKIcyYmRCnAewU3xgwiygpQaVV7uNAbMa6REyttMavR4vBpTrXmDzpHhWGi6uWllC8OYs6iZPo5D8rdmqytuy3+SUOgMpGXMH/h9GRih0rhkRPZqCmLuDJoBQauvwM4dA8Pb1IMWjA6iK8Icg1mt+A83zs1tFceiz7LVHgw61yEhHstoAio3WD1L7sINAsKYtO8KOKvQ99j/25meqPFc2htW8/iFueYPJdHrBlaeCfZdE8XaPe2HSMy1hQF+dbIjzeGaSwEqXHUIxodElV8KjKXyCJTV9l6kslg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH0PR12MB7472.namprd12.prod.outlook.com
 (2603:10b6:510:1e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:00:41 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 14:00:41 +0000
Date: Thu, 22 Oct 2026 11:00:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
Message-ID: <20261022140039.GF3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
 <atmurtZOhKwwGjV3@nvdebian.thelocal>
 <7b4dc988-5dbd-40e4-b17a-47b6eaf4bf81@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b4dc988-5dbd-40e4-b17a-47b6eaf4bf81@amd.com>
X-ClientProxiedBy: YT4PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 09383e4e-e74f-47cb-c29a-08df3044db97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: DYEQljaj9yIEGfO/+SqC7BjqHtxDV/GTFXH5uX2ezaifqKUv5RT51aqPVikxuPqm70CgmTITdz2gtB0HyYAeGBCWkRKT2DFUpg9VxN0tRMzcsIKNy6w4IA2BQSfToAEUeUMBAJr9YHpVe5kN2Zzkdo4mFN3b911I5NXXvc4X+o+UF5WBXmHL0vxyFjZ0iq75Cp4Q+p5Rz9eV/7F2CNOszsg4idpQkMkMmeNH1W8Cq48bHk4TDhvYQUq0MvhC8EKJF6dVLHlGqVW3EtvSusmnWSaYjTVFE852bbkf9Kp9l+1gXA6+6mnIoufCHDdUFrX5ywNUtkOXxM5m06OI9IvDN75ygln2QsW2gwuEFmb3vlIvt6wx/skQhggReE27FwWnXE7j/CkWJtwDT8lZ3TPiiSTxFfZ1lNsGuDuh98UlrlL3dZMRGkHxTsfwkpQsjM+07btlPZvUF9P2cuOJkaqMqeM2otBi0GfNHWQuSnf8x2/a6nyT0D75yaAIy1fFyRTxIwMut+eY0spHzW6IdgY1cqBHgfJMeTU4g0ZOmZDcOLMgQngTVtvjtcdvuTCNWad+qkgrTLebmrkBLyd4aKjDFRTK5gGM9CdpUorN8hZfF/sbhIk8EFxxCiiGH4MatUyXYaetru7Rf5tcIQdFVNQog7BoF+ey0arh+YYO9xI9odg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2VFNTA5cFoweU5tRGlSU0pxa2EwS01YQVlFUUJrZjJweU9qZkR5NkJMN1RO?=
 =?utf-8?B?Z01VYnB5aHllTUdkM281RDA5bUd3RU1qTkZOVzBwUE9UNy9Ebzl2alRxQVZF?=
 =?utf-8?B?TllvK2taUmNsbkpZU2xIQ0k4a3o2T3lWYjRBSFhWeU9iSTJEMHBGL1k4YkRv?=
 =?utf-8?B?YzRtemtleFNMMjFwM0piUXpYdzlYQmo0Y0x4aDZUTDliSDNibVB4ZHZEdUFw?=
 =?utf-8?B?eXVNb2RhY0NQMzhKbkd5UW1jNjQvU3h5YWl2QzV0a043cEVZOVJNc0laMHNE?=
 =?utf-8?B?dG1QQWU5Zk5ONnFTVjBwMjZ3aEJXZ293UFRvbUcxU2ZBOXpQbzJSZWQxNXB1?=
 =?utf-8?B?RVFYYmJCamR3ZTRpK1pYVzU0VXFVZlplaUhnWFlERkhIMkJFSWowRkp0TmZj?=
 =?utf-8?B?c2oxSnNIUmZ0aHpuNHhyQnRUT2p1cG1ydXZMK2R5RVZOdW9QU0NwNHZoVTlV?=
 =?utf-8?B?NWdWWDI5dlIxaEtpbzhyWmdWK2NnclZiVmVpWFJXaVdLMzRkRnBEWHZGVnFY?=
 =?utf-8?B?ei81WkNkdW9hUDNlTWdZN3dZZFVXZi9obnVoTWt1T1cycTJIUG5BMDhxbzBv?=
 =?utf-8?B?Tldjakp6bjBtbXdWaHY1TXB3anZjQlcrWmw0UGRnVm9TeXZ0YzlNZXppKytD?=
 =?utf-8?B?c3AyUDkxV09IVjJTRlBVYy9jWmVqSGZQanFDN0RFSUtIMmZyU21HeVBBWXNO?=
 =?utf-8?B?cU1pRWtVdng1aFVSR1RhKzFSZ3R2UkQwbFdVVnJGNWUxeGU1TVBaZ0dLWXg3?=
 =?utf-8?B?MjRRb2piVnptR3FmN3FPRlJoYUJXMzNLSXJ3R01UZjI5RFk4Qnplc3R5Y2pJ?=
 =?utf-8?B?TjRVRU1vQ0dyNWMxdWVkRWVjMGVSU3R6NG9HZ29US1NieENoQUh0elZuWlBl?=
 =?utf-8?B?YStwc0Y3SVJ0M1pORDNFOTdSK2lBSURDbnJlU2dmRUtKaytpQldEZmdPQ0FY?=
 =?utf-8?B?amxUMmJkUlFaMEYxRVFyanhUS0p2KzhQT2NoejhvQ3MrZTNDdzNIUXFDSlJ0?=
 =?utf-8?B?c0RhdWhDODZXM25HSXpXczAvcnQ5M1ZOVWo0QjNHRG9uakR0TWZyWmpTcFcx?=
 =?utf-8?B?SkpwZEczUXFiMjY0WnBRVXg3dUh3VnM5SEZUUXNRamsvOFlBV1RKcjZZYWFw?=
 =?utf-8?B?KzhzUkg0WWtTQjZnMFViU3ZlRERTdklVaWN6WEhwOEV2S3dOd1hNWFRHdlp1?=
 =?utf-8?B?ZHkyUHB1YVpIZXFlVWdkQzlxVU9XL1JOVXYxM05tNlpKa1h3K1o4anRvRE5D?=
 =?utf-8?B?TldvMThlbHAyVGFVNHJxN1EyaGw3QysxSmFKd0g4Z1E5cmdJSnBTVTA4b2gz?=
 =?utf-8?B?a2RDMlpzUEtucndYK01yRUo3aFVLZWprVE11YkZuS1V4RHk3UXM3aXdpVnh4?=
 =?utf-8?B?STN6cEh0NVlveURPSmt6cHlVMlBjWXBpQ05ZRHR3R3ArejFta2ZJM20xL2Z3?=
 =?utf-8?B?aHd2LytRQ1lqUTdqOHVrVlFUcTVBNWpsem9OUHZLclRwZitUVkU4a0RvUW5I?=
 =?utf-8?B?bDJ4a1FRT205bzJRbDVmTFNFMUpWRWRSQlJKamxWT3dHVWZaSkFPMFJ1TUlH?=
 =?utf-8?B?RGU3dlkwL1EyU3FvaEZCNGRpK00xcVRNQ2lKRXdIREd6c1U3THlSY0thMGRu?=
 =?utf-8?B?c3R6L1Q5ZzVjbHhVSExjbVo0QUREL2hhRGljdDNxSkhVL0NBMEw0aWtzQkFl?=
 =?utf-8?B?UlBFNG11ZzZ1WDhDSTg5R0FLTWFSdUN0aVNyT0ViaVJCTERHOHdzWXVWeHhn?=
 =?utf-8?B?cVBIK3p4U0RESWw3UHFVVXcvZjBmb09jWnZpbXBQbFdic0p2YUtVcmZoWS9p?=
 =?utf-8?B?ME9WbW50U0ZUMEVvZUNUeVpuMnhJckIxcVFNRUNHRDVCOHRRdFl3WG10OWFO?=
 =?utf-8?B?R2JJYTFTOE9EdEVrSWZ6NHEvREoyZldzWS8rdXc1MjIwdndWTVRNQ2NkSWJa?=
 =?utf-8?B?WWRUV3BqZ0hGWFBOcDhJNVduSHZyOFQyMCtLL1kvOXZMNG9kKzRNWDVuTnJQ?=
 =?utf-8?B?UGtSNy9OVEpmYTIrREw3bS9SaTNqekJlczZ5R3oxN3R2cDFLYTc2UE9XeUtT?=
 =?utf-8?B?OXNsMUVnRk9FaXVaL09OZWRVQTRCUmQxb0VWMjc1Q0hTSExhWkxqNzNad0Iv?=
 =?utf-8?B?bzNCanRCb3huazU5ZDZYY054ZWh1Wi9idjVhVzM4Uk9HNzJ1UFd3bnFnN3M5?=
 =?utf-8?B?K1NIckdYYS92OVhLbDRCS0Y1UW0wOTJJbWFYWlFyTmhoWVFLQm4zYXVkcWtp?=
 =?utf-8?B?VHR1bFhmcldTMHJtUVd0STYvR0l5VGFsK1FmMG1SL1hTTy8yNENacElJTk9Q?=
 =?utf-8?Q?n4oc37T6/lPWRa91CL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09383e4e-e74f-47cb-c29a-08df3044db97
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:00:41.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jpqqho0i80QaAiqeE4Pu0ht1WG9oysgNAG0irhte3v9SyFmc82RfC+y7MhkIZRKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:30:11PM +0200, Christian König wrote:
> > If I'm understanding things correctly we're expecting a change in path between
> > attach and map time to be rare in practice. Therefore the need to handle this
> > case is mostly as a fallback to not break things. So instead of pinning could
> > new attachments just invalidate all existing incompatible attachments on the
> > list by setting eg. attach->valid = 0?
> 
> No, that would result in ping/pong behavior which is something we explicitly try to avoid.
> 
> This is also not something uncommon, it happens multiple times a
> second on a standard X11 Linux desktop when a new buffer is started
> to be scanned out on an A+A or A+I laptop.

It seems to me to be very similar to an importer not accepting P2P,
that already creates a placement restriction that the exporter cannot
use VRAM. I don't know how well we handle that, but mapping type is a
generalization of that same idea.

If the environment is complicated and asymmetric there absolutely are
going to be placement restrictions where the GPU driver gets to put
the object. You cannot put an object in CPU memory if you have ualink
only importers, for example.

The best we can do is provide up to date information to the exporter
so if it chooses it can make informed placement decisions. This is why
I tend to prefer we keep the attachment and somehow update the maping
types to reflect any limitations from the importer HW.

At least in the AI server world the migrations are rare/non-existent
so we do need to keep in mind slightly different usage models for this
API than a X11 desktop.

Jason
