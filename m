Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DAECD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D075E112A04;
	Thu,  4 Jun 2026 23:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZF7uXwT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979E0112A03
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 23:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2/LosGWYzz+pXqjsWBKXG7hQTD2fkIWaHEeLzelhKYOjpcR/Tkozs0SMFZZOZL5VrNgrL0jow63qdb//NmoZFzTrS0SFDgfBfdJSepnVaY7+wwDmO2HSqxGOb77ciOBV3eTm5RIymjWnyXEPXhLWDS7Ov2ochQHq05A6E99FEEzy8mH+fes+NUhbsMyQlBIPtnAOzsADvcR9CgL3bUbZl/OJwXTkbY5opDqI9MmohbQ0xDFzfGX9yQDgjAXOI+LBZBZjyEIlLAX16aCAVjGMZ99PFwOOVH+5aD1TEiVu0K/N4O9lgFmk/zZlVUPcylH3vJ7LAO/ZyQam2jDhAOzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKuzKDzvtgcpaOBovt/U/wJO++xQ7fzxJ4EIywiJLIA=;
 b=s2JK2zu41B2LDNTo4rza7CyL5POR6U5lYAi21oZtcx9Jvr28T3u/KoXNAHqeGXh7N4W6wnNp5yEbVaMvitJC9LPUVDunQTDGvchrrNleyYc6pbbI7B9hBuPYG+6Oo0r2mbrpslIlNMHz1WbocDkNVUhP2jdtATG8RRy4FPQSqfq3TIcnKGlnxIcB4Wgh6d8Y79w7rh7uplKhGStEaC+yTCVrtY58syywQqhawXi3QpWoKJO8Pep8Pe0+y/RFUP6DUTrVjv6+8llOOtCz/5ms4njF3b/eUC780WflI3+V6/2oX344VH4BmrUYxWy3eZ28ycGhZGIrGeBokDsuvR8u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKuzKDzvtgcpaOBovt/U/wJO++xQ7fzxJ4EIywiJLIA=;
 b=DZF7uXwTNNX501NvAMCAYWBbgZCTT4edRnufdkH0fAd5/j2Mtr1F3/gVK2G1kp5RNHMn0sUE5bXjFLQ0SjTsszQaUXzsT9rpu/f1oRAvD1zsNMSGj+0Dw3eQVxkzjggbkOgni2ojCV4ljT/ZGUvtUH9tIzg0XRp08Km1SATWD+dPMSZO8TsDha2FSgEpgyvT7Vq90fRxPn2JO1ztQLzfrSPHo/Ksl3fB6g/m9/DhvJ3W+GmivUNqXmc7adZuQrc+YiWkEejb69L4ltNI0bQ5A0bwiq1fqyR/UB+utOmF5xHpQzL1pbuS9kfJ0Duzr+yrv4rU7sOMkm1+zZZoUnmjSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 23:41:44 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 23:41:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 08:41:35 +0900
Message-Id: <DJ0NV9GMHAIY.B9CQXQBBPYQ8@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/6] rust: ptr: rename `ProjectIndex::index` to
 `build_index`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
 <20260602-projection-syntax-rework-v2-1-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-1-6989470f5440@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0226.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 53993ede-dc09-4acb-54fb-08dec292d315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: wOhr/+xZlsTvcuPnKzxolkMX6/D6b3z7M2KU2cwMRdPfARNXPdVeblCUXpOSgt4VbL2Sr4SOKXnKp75JE8kXGu2nMjV55dEfkidWbsewwpbARaFuoxah3LIF/plFRXjSnlXHmuJ/UuuxIv2Pqhlinatn1c5Ms0WdksDWuDv2feW1JYvqinv4tN1Ko8q4SrCN+Yq5hnXRo+UP0w526pwlgk+7R5Pgd+5Wzg1manOhHywjtTlFcVdJI4VGZoE2P5gkK8wRTKJ+jXMIWvRZNaQZXcbaLnyOiQuOtXQK2cXqNRJozDMEfPXaFHk9hgoFhyskZJS/PtoYrcN7nLAkKvoKl1mBtUt+1159btgnIRThtujnokGJuGuJqjoB/2ieAWaBEox9Gb0kjzYNJcDUDrqhyJRgnguRIxqKI9frc3lDu681fje0NfS9DCN+z6GjI2h8pAv4OvG0yIz0E34tIwPm9gsx6atHah6sTDKz8TvJ3sKZrdr3mCu1k9uL7zxxFXmMzV/MZYHgxOWPq6a2rqAy35ZLwKMa0z50aYk49MrimNPwLT5LHUf/mBaADThNHHovLlDa+6KtorxZA0+IMjXBDwlEO2Jfwp7E+LrcXQj/Os3bhGF187PzUd+AvS5AIUvIYOGtIQKIy7mrtiNVT002oq9QpECHLEjqIRt0wBQ4UVO8bZp9rS6ARqhGao3qRxW3QcTOPj05BpgwdlXe8xBhmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTltNmg3dEVCV1ZiL3hRTFFwVk5ibjMvdXF2SGcyeGROMFBPRkt5dU1OSzBZ?=
 =?utf-8?B?QTRyM0IyZTV4VHc3eVJZN2hNOE9qM1UySm54cSt3OFJybkpWK0RwcWFBTHpn?=
 =?utf-8?B?T3cyUGhxY2crVzNrQjZGYjhoUmwvMFpYTXE0cDdSN1ZTY3JrRnhHN2RFdld3?=
 =?utf-8?B?MmFrZHJneUphRjVxVW8vdlE1UGpybTh5alRWRnAzVXcxM3JsUHQxRXlqdXJC?=
 =?utf-8?B?NlZjbEhSOTlKRXJ4S1UyemVkZWNVYW1UZWg5TmIvaERKbnl3ZFE1c0FOVENO?=
 =?utf-8?B?SzkrRmh5TXVmNGlQVlB3VklOc2ZOWGkxSDB4NWR1d2l4RmNRTnorVzh6STRB?=
 =?utf-8?B?TVd1Mjdqalp2eFJaTUFnL2NUNlhBRDVJZ3ZnZExSS1V3bTgxWTNXY3AyOWNJ?=
 =?utf-8?B?amVIRGM1Vy92US9qOTVMeUtTcExHNmg4VnpqMUx0OE5SM2ZQbHY5T09LNkVP?=
 =?utf-8?B?TEVwZkgyRldibXRyV0JTUkVjZVJ4eGZxeFpteWNXaDRKWHdoc29rSFpaSWIv?=
 =?utf-8?B?cWlibERXT2lEV1dDa29wQmk4YkxjVnRmRVVJS1V2ZEpCYmpmMVNMY2lZMDlE?=
 =?utf-8?B?enZhUmVuVFFjMXJSTzNPTUR3QVRqYU0ySlhDaUdqSzdFN1pJdE5uL2MrL2NZ?=
 =?utf-8?B?VHEzRnN0RE4xWWpkT2JYbHhiY2tpNmxISjJNN3RJWGt0SDBOMHhmQmNiZHIx?=
 =?utf-8?B?Y2paTHhsSWdtWE1pNDhhVW1hQ3ZIWDlEbnRhODVrUGlDcVhFSEdFTHZyN2ox?=
 =?utf-8?B?ZmJtOUt1cmRXWEpXQ0RvNlN0UG1VNUdYVVVDZG15YTBqc0hKc05UQWcwbDhw?=
 =?utf-8?B?T3dWVUtpdWdHZkdBSW51ckJYWXI4bldWTVlJTVQvdjRUajEwZGVsZUdQYVBK?=
 =?utf-8?B?bVV1YjNVZ2EwQXlOQ3p0OS8zbmtBT3JiSVJ4VUU5TXZQK3MrdS9pY1NPZWlD?=
 =?utf-8?B?Q3FwY1E1dTNnQnVpSnBEY1R2ZUpxcVN3cVRyUTZSVDZCYUZGdkQ5Y2JYWE9w?=
 =?utf-8?B?bTJsV3J5NmR0SWNKeTYvbWdDV0hwcE9pZStka3Q1VXRNRTZYRFVSQVpSSHB2?=
 =?utf-8?B?eUlYT2J3UE9MR1NmcVJrN3FSeTVqK3BZOE41SDhUTGFReDNqN0Y0djArSUxY?=
 =?utf-8?B?Qk1mUExidGxmRy9WQ3MwM2haTlp3MlBpNkRna1VzVzNXcjhZNFZaNlRVeEtK?=
 =?utf-8?B?L1ZwTmF2ejIzVUZLMkxBUzMvZlVLYjNLTjk5ODNWbmlwWmR2V3NpTHFZeTJ5?=
 =?utf-8?B?NXFRcVFsUDlyY01jemZBanphYXB1TDBqOFIwbjJ2UVVQZ0U0T01nazdBRU9v?=
 =?utf-8?B?REVtcmdRMUpQdzR3cHBnM3FwK0JMU0x1QjA3TGx3czRPbmkvVFNNMHlJWkFY?=
 =?utf-8?B?L2NNZW90dTN6UzdpVEN4amdWcTN2ME1teG5KZHUxVUszUi9xVWRjZmtINENJ?=
 =?utf-8?B?QWZHamJpSjlkSGlRa2ZoQ2tITllvTGR4RHd4VkliWW0rVWozT3p0eXdTZ04x?=
 =?utf-8?B?a0hFcjBmWktYcENiaDBodTR1ZFRJRmJ1dTRvbWdQemQ3V3hFa2dWdG9YMDMv?=
 =?utf-8?B?T2piSW5PZmtwVk80NStGNWxleDZrZTdIK2swOTBKdklnNlRIZ0FNUDI0aDlV?=
 =?utf-8?B?NGNESnkrUEtvY0tMNUt6YlhoWE9jbldZejUxdUNSRk1BcGJ5K3NEbk9HWjUv?=
 =?utf-8?B?d0l5UDErY0Zqejh2bGNOVktoUjVOODd1c0xYdVFueG9kZ2hyL2RCY3FlRFVm?=
 =?utf-8?B?bnpubXJucVl4cGpwb2xZVmIzZTRFS0haUGE1NmNXUzVZcXVlbjNpMHRHVTBO?=
 =?utf-8?B?UWNPSFJJMEVOZ280dC9vQ0EyUDhRZE5PMmx0QW9OblVRV2xnSVVSbjhoaVY3?=
 =?utf-8?B?cmVUUGx3T3Uxcm9CbTVzb2V0cFlhSm51UG5LU3pmdlNPbE90TXdZZ0hYNWNS?=
 =?utf-8?B?MDBLaHJCOGZDOFF6cGRKRFQ0MSs3ekVvU3lTM1JmMXZDbFd0TlBUNjFoSkox?=
 =?utf-8?B?bG1XWmVESTJ4dSt4T2dlaFhyQnQ3Z05TSllnTTVWVXQ2VDlFbGlLQi91VFFv?=
 =?utf-8?B?Tit4MForS2hiOS9lOHBLczBsdUhieEpRRlhNdFNIUGlDSVpBR2dhUHE0U2Ra?=
 =?utf-8?B?bmwxc0pIdGhhQVBTaEZacDFxdXBHVXdXZUs2d2NiM3Y2d2pFWmZPd2M2RERO?=
 =?utf-8?B?QW80eXJEOVhETTgwS3FIUkszbnRoVkRtNEFUaUtKNFg5VnZYdFpsWEI3bjFQ?=
 =?utf-8?B?TXFoMXdMZG5LMENpRnBPVmtXYmtvaDZhUUdQbkV2YVVmY0VvQlN3ZUJlcnls?=
 =?utf-8?B?amRrWEtma2o0VyttYkg1dWk2a3pwRThGd2dRZXJPVWpxTGFOeFh3TjhMMnda?=
 =?utf-8?Q?qtm4yfawiZ6cmNspPfevh6u58MH/cbqtK7y/+2vr5URjG?=
X-MS-Exchange-AntiSpam-MessageData-1: yG5S5PAKg69aEg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53993ede-dc09-4acb-54fb-08dec292d315
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 23:41:44.0690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRvXzeBLVrFJcWcbqkh8cmLuBa0oZXuByLix2h7LZ9ykRpBsxadCpNjWvLfkDKvqmxG3KpzUIa1vc67zo6ouaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On Tue Jun 2, 2026 at 11:17 PM JST, Gary Guo wrote:
> The corresponding `SliceIndex` trait in Rust uses `index` to mean the
> panicking variant, which is also being added to `ProjectIndex`. Hence
> rename our custom `build_error!` index variant to `build_index`.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: https://lore.kernel.org/rust-for-linux/DI5LLN2V3XCS.34H4CG99N4MPA@n=
vidia.com
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
