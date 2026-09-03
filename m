Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A84DC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B8610E0F1;
	Thu,  3 Sep 2026 13:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="P5H0Umuq";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021107.outbound.protection.outlook.com [52.101.95.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1F210E0F1
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/iuctHNgWGM9yTFZDv6WcQ6npQUcxn2xp6ZIIoxb2bWEBCQ4ANsWOI+gENWrEz3LiUGH8yZP7VoDJ2qbVTyHb1efOSnQ0f+Eju768SIgwNZ2BInz01B57q7RbRM4k/r5iPffsq2gPNnQI+P0o+JDVuqRmbRBNHr6rp7dccdraenj0RMRZKyJqxn/U9R1Wl+sElJ/N7q6BqBjWUjCd4YG8GQByzsp5pyJfvHzcJDbasIhkBTRSm56AXVucGaBKICFZzwgSrq2/cigWFrrf2A0rR8c09Yw3Pn3oof1dKPHajKo6AgtUj5KK3kShrwzCHPTu1JhDaPZL+P6JdorCo8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgM+ygrXTJNA09wHqLuSxkysYymx9jjYgpUqm1moiLE=;
 b=WQZiAQcgZLuXUcVqSKLTMovxem5pJD0XiO9FmueW+iqfYXxDiuPU9nCNLWcV8Iny0BsKo3ca+02DROLKM08wTR9b6XHaTLB3+JzH+rH4PBwgcneI6/lJBWgLfkMsk2Q0v2xx0c8NGOrhgD4/eMm6rTcKck1Is5JwiYjzwIhKHE7Qoo6AmXXhC8GdgwZJwP7vCdn31+I5inZDy2+OwbKnaN+tIlG03z+oQ6wLs9CIQjUZaTcyLxloil60neBK26oELSysus5ZBOHBG1OpQhDoEMtXQOviOeTC72iecQbBf5sx99bbWuxEaAtVBvEVgGU0FOztDLOD+Xluo08oP+mqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgM+ygrXTJNA09wHqLuSxkysYymx9jjYgpUqm1moiLE=;
 b=P5H0Umuqc7FjNjWTqKy0lYQVO/lb/u0jTf0jtwcftgdGFhyzHGMkT+axGYYff9GPezr0TJk9YYYMw1ViYmD1ei8iCKwZTazjrtTnja4CiZ+CsQnl48D6DGowCkRDO9FHsNadnDRsWSZY/g8+qh9C8wZPxHvuHgHMDp9gUrYwOos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7602.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:12:50 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:12:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 14:12:49 +0100
Message-Id: <DL5PHF5BPGJN.86AWUD4D5BL3@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <mmaurer@google.com>
Cc: <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/4] rust: dma: tie CoherentHandle to the device's bound
 lifetime
X-Mailer: aerc 0.22.0
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-3-dakr@kernel.org>
In-Reply-To: <20260830193824.471089-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 216c52ac-bcd2-4a00-5d8b-08df09bd0e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|22082099003|56012099006|18002099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info: xkaR5zHIONucB1m5FgxSuDtbkeyz0NHOZmke/K+39FpdJSqhxVNEYpMCBWpB/rgPsno4hsS8DxO2WFEYaxLcKacLRI3KuKnv5Jd3ZipQxObZWuLuASGIxEJ+UDsIILgCHQDvnA3C2fFg8/b2FqJp5yR3YRulYpu26TrhAy2LRmo1piBereRLm0YcPaBiTod4EB7fNstKdMxGUY/DlO+dTMiqf8dsSTijroxLreBlSWyn8XehXHxQCxsuB828kUpvThKJKeyQzHQfY2jLr4gKWkUC6QME55dzeEj7B0Lp5SKJGPo5ZmlFc+y4barO9fFTpnZffHXRSIGXX/64aJExSC6mi5w/mfomHP/JKaE79oVNwx6+nKWpAjR2/VMa9ST9evvo3J5P2dHhuvmsYbErzyv74pfrRe4eIgPjCQ0O9WZGDb6avBNjhqltlQWA5AAsAjRqlnEJASIefwWA3E1ynPn3VAczSTy0PHhYSzsH8xfl26rM4I1mGX4Wbs9L63a1cfQtBxD/QB8vxu/Ua2+g/bnqwxmtCcbcsl5ZB8ZMOYtDUxETUR4AlwiXIEUpq9JVBgvGCo9UP2tG9CjXtOUWVnSev1yWNJcZ4OdzhZ9NH/1PsTkuiA8zSZuWZ/J/FXOu4lVme3qzR/D6WIGC95JG8Eom2mLC0sVF5tHEs1Q7M0W/Z5KYWUI/l90IGwjO8r65cTgZvGRH8JcT7Lls5pVHHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(22082099003)(56012099006)(18002099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3h4LzljVGpJYjUzK3BOOTFwT2RIaGJ1YitBNWhGOEdqNmlreDhiWFFsdnBB?=
 =?utf-8?B?QkUzRWFzeFM5RG5zMFlham1ZNnR5eWVyRnB2cjNUSUREU2VyOHdlbW40bmFH?=
 =?utf-8?B?cWM4L0p5d0I0aE5NQ01JOVJmVWtIUzZPZzFFdHVnd1Q5QzhnN1VjdFJTMXc4?=
 =?utf-8?B?b20vYUxGRnB3Q0thNkYvbzdKaW1Dblh5VkROeWJxd01WaVR5QzdwUjlOUmRt?=
 =?utf-8?B?S1cwU0N5SVhzb1BxUERnWWQwM0ZCSDMzZ2U4aHBJS0FRaE1IbmFjTUVuVlJa?=
 =?utf-8?B?S3I3TkZ2Tmc5RFRDdlZ6SGRGRGllcUkyejkzUi9tblI0NzZHdnAxeVBFUTRR?=
 =?utf-8?B?ZGM5UXc4Ri9OZlYzaGJMY3d2d01JMWEzRTJpZEV0WjZyd3JwQXMxQUZpd3lW?=
 =?utf-8?B?ampYMlZYZEphb09OaXpmVk5mc1ltZjBkdVVjcHphVmhkWkM0TnVneXE5Y1hC?=
 =?utf-8?B?TEhuVDg5cGQybktZNVdrL01ZZ3NQVHBlMnVPamdJQnlFQnNxVitCTVNsdEZp?=
 =?utf-8?B?Zy9hUDBNelcya0ZVQ0x1TlFjVWphbUtnbXAzYmRWT2ZpN25rLzZVVVU2b2tM?=
 =?utf-8?B?Wkl1bVcrL3IzaUdtcWd6dzFzeXluUWhWYkp5ZHluYW5GeXIrR3MzOXVFbEIw?=
 =?utf-8?B?dTQ5NTV2TkdBK2FiSHBKdkVndjc2bFRGRisyOGZjMlBLTitZUjBTTUh1ZXEw?=
 =?utf-8?B?cXhLMy82WGtXTitzMDBnU0xDbS9oS1ZqajFwQTVMZDdYdnljaUQzeGFQZmxQ?=
 =?utf-8?B?bnM3UXRJT2ZodFNnSTdTc2w4OFUzU0xLMlVhbkkxcmRGaFYreDhZU1hkYTBI?=
 =?utf-8?B?ZGV1Mm5vNndhR3AvaHRaZmNBWWNueWhWL2ZDK05sWHhuOW5McEsrL0ZjMG5O?=
 =?utf-8?B?c0Rob1dPQWNRWUxsN2R6dkZWUEhrcjR0MjlHdFY3MVc3RS92MzNCTTFpdk50?=
 =?utf-8?B?SHUrNlMwNDI0M3Q5K1FWYmFzZDAwZjF3aG9VZEJyRXMrdGxOd2V6aUpON2NW?=
 =?utf-8?B?SnJ2TnF4dS9Ib0J1OVE5OUd4YVcyUW4yYlZKSUxVSHBRY1Z5UDNNL1FEa0ll?=
 =?utf-8?B?dFRPZW1wQTBZS3liQ01jeDdyQzdjUlM0NldReVg4R3VLVC9oN2RFd01ZaUlJ?=
 =?utf-8?B?MWRER1NwVzdxekpDckxUZjNkWW9WcmpHWGlNb3BacUpHWVFRcHhwamlIRUhM?=
 =?utf-8?B?Szh6bXZ1SG5hcERPakxSR2JtT2RxQTRuelhJV2gyZlM4RHN1LzQ0YmMrcFhV?=
 =?utf-8?B?UDRVdzkrQ0M2bFk0bnZPdXg5SEN1eTQ0NjdqR3g0anZJSmVkc1RxU3l3L2tQ?=
 =?utf-8?B?czVRMXd5WWh6NjN0aHdMaWFIR0tmWmdmNDduYkhJZGNYejhtVUVsRFFLUG43?=
 =?utf-8?B?bXFmOFJ6Q2FrTWozVzhmdm5rUFMyaDhITzRDKzlwSTQ4eW9ZczBRdDFybDBv?=
 =?utf-8?B?TnFwK2p0MWkwNkVpWkJKMTIwVDk0OWNieE9XUFZGUVNqL2l3aWZUS0doUXRR?=
 =?utf-8?B?SVRJUmNVeURWN25ENWZWUGhZQUZNc1VTZ2I4K21naGVwVkhDNkdNVHl2VFhF?=
 =?utf-8?B?ZnRGRFRaVkR0d0gzUzRjcHN5ZlBPcWNlenNLaGFUYks4TDJkTW9WZGRXcEM1?=
 =?utf-8?B?ZDJZVnVYOE5kQThDaDBPVHRVMm9OcGlnQmFTRkR1akMvUlNBQmlOUmhFY2dP?=
 =?utf-8?B?Y1pXeFVxcnBCd05NUTVQa3lBN1ZHYy90a1VrWWZaSkZXMjhNRmhaMk92eisv?=
 =?utf-8?B?M3J0elVVYmxET1N6WUg5UjFhUUxQMTFaODlESDBSSE5yZFFWNXV5YjVWNHNV?=
 =?utf-8?B?SE01NWwveUVha0VHTDF2WmZKOXdoR20rVFBUMFlZSDIreHRteUR1WG1mLzNq?=
 =?utf-8?B?L0ZEdENWV1p6V2ZPbTJaZ3NVWjVnbHc1VVMrL3A1ZFBlTHA1eE5Nb1lybCt6?=
 =?utf-8?B?bVR1TGxNS3V3bmlrMDFFeW9rdkJTSnE2OHFXZUUrMWFtTkNHWFgzUmhVWHBM?=
 =?utf-8?B?NmxQMTlVdDNhZ0laYmRPQmFJTms3bjlaZ3RRUFdZUzJQOVNhNnhtaE9NeCta?=
 =?utf-8?B?RG5aSVY2cnFLbWk1UWRaWTRZS3JsZW9LU1doUGRVbGJvRGJPSlN3ZWMyQmpl?=
 =?utf-8?B?VXJzVHBmRURVME1mditDdFpjc28ySkJtbEY2aGt6TXExRzhQTW9Dc2htMEZl?=
 =?utf-8?B?aDI2VE9JNnJFdVdMdUU5blBjWC9UVkVLVnVFQk92L0VqdmNPM2t5eTIzcGF2?=
 =?utf-8?B?MWUvTWRmTkNmd1VsaFUybUtnWFNvdTRuTW1DcitldTl0VjdncCtuOG14enQr?=
 =?utf-8?B?bTdlcUlKRVE1Nmt3ZGdCRE8yTEgzc3MwUjFmSjFLVXZkRTZWYTdkZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 216c52ac-bcd2-4a00-5d8b-08df09bd0e6a
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:12:50.6917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l32zG7dYw4OC8fffmMTtYK7KHYiVkuRLi7p+C8KoiEVwItVK9t4koQIArlx/8hLlIvPCMj7CvCR0rU/xNHCNTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7602
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

On Sun Aug 30, 2026 at 8:37 PM BST, Danilo Krummrich wrote:
> Add a lifetime parameter to CoherentHandle that ties the DMA allocation
> to the device's bound scope, ensuring it is freed before the device is
> unbound.
>=20
> DMA allocations carry device resources (e.g. IOMMU mappings) that must
> not outlive the device's bound lifetime. Without a lifetime parameter,
> there was no compile-time enforcement that a CoherentHandle is dropped
> before the device is unbound.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/fb.rs |  2 +-
>  rust/kernel/dma.rs          | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

