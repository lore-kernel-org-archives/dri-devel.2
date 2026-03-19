Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428871075264
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDF910E8A6;
	Thu, 19 Mar 2026 06:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lr8o1C13";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D43110E8A6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGNIVOoTZTSioGd9QTDM9uFV0THX3+1S+M0W1xyxGrMRSd8EVOll8KUnGh+gxx+5bISfrkgZVPiC2+ZCpQgFfNDxIFQLUMTjqIDj9ronN710V+N+qUMlZr+NAFz1sThkGGQ/z6unnb5y2x9A0cY8HTobqLigv5thsbz7PsAYcxQzEBeNuUQPSDXDxpv6JQGMSazmLb7Nvchj1g2MurdhI/SA9jG6ODPkw10vW3pF4xAk3gVoLRejj2Ppsu+wbG1eO3BiSn0EW6kfr/++MbMwQqo/X52TJ9njESopCxK97tXkW5V3safq3H7Bxj8tFseV2YdmaeZWge6SNxxVyXUEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQuyTms4NKAlgV5V7mc4z03e2JtnTPhRi6mfK+jvH3A=;
 b=ZoZ1Kenfggf3QHIqDTOtBybnRUNqc6lG6pu2LCfioY2XgbFP7bLvDQHZEbRGqNhGNWw5yyEEBDjs4BCC/NfxR/7tnSGKnil4HHwaQ/fJcXDPnjTCbIx+v+LJ13pyts+zx1qgzBdq4Ed42/NWgY2vVWq1DmqsnbFbN9juz4aKQ0cwgIQsJ9QFzb5X8dLjgGculPs1lT1GOWPm0/xiKhmpRQ8wd1okoxlL1HJYlZXCC+AJ9IfqH7OCJQqqYvIBIafPL3YjdD+Mpu8FBribAuzNHut0xNTUCLH2hb4hMGQQPtWmPLXPFvi2heLK7S2PtpfQz7DRRQZaq+qgZbf9zI5lcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQuyTms4NKAlgV5V7mc4z03e2JtnTPhRi6mfK+jvH3A=;
 b=Lr8o1C13AhXLjX0XvS/YpDLq8pUp6zTHxa/aai0iZkCJMpE5GlJ7YJ4DF3E7gpiG9hxDl8zBWBTW5tTqRnxqr+rDcmmORTUUv49RL/S1LaMadHirx6kC//8Nj2fOUmq7Q+6iEyMj670KqBCYg+JMbogDeIXpjscdqgUFwqV2xVfuqZkEAs9RjnWwYq/7cu6L/2qs/ODqLB8KcXVIossxJoIVx5wP5z5w0W1WEcv2oqSBpZmBKuxXEUDqlwQ6UoRzwt8/eu0CZ91XqKUzFa3TNbjKghMlbYfzFcxLRacT1MUfYMkfAmN7sjq7m14zvNqdOKElrq6qm1ajqKC5oqedTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:41:29 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 06:41:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 15:41:26 +0900
Message-Id: <DH6JY86QZEYL.PKQ2W4ZA9UUE@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
In-Reply-To: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
X-ClientProxiedBy: DM6PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::27) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 34631ae0-a581-4c2e-70dc-08de85828cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: s4qsD77V7MMWTfym8HHn8yyoWbCOjmQQHGNbVObZMVrITJaT4PuijaapPngxAqh/UUL5Wdzh0dnUsQiuF1NmfgqgB5rHwVRR+hYYSZCT+FsZU+YdJxljfkxZoQDsjOwiNzMXkSiCdMZlvezSoEDgUGH36dbMQx+BSAOcXmrx+dXYCgXiueWh0+MEYJK4hvqZiFmh93LB0cWQ0LIHsB1KJWsHRehNdwuGI5zJsBsHbPGdJ5LX84/A7wHdORQy98fmzkVJ1E+y9taIzgTAenf2FEY3vj0COVkIggtYnEd49VKvJfcKucGTSCwjdng89Ty+ghk7svv3QzwPWVYstlbLQT1huk3CQcC4OYcEVW4oIchnfJQdDSb1Pnx8UfQf5yYbxbMLEAbrJ3ZaU94hUie6DXEjfuaLteQ0d3r+lh5nUSBEFORXU8cX3OIQSdaio8kM2UHLa57aNHAhETzqNoO98BECDuDkF+jXirfDCM9HSH5nr1DvcBa5XBbj95XApIojyyaSHoYg5ibXpu4RyRe8OVqWnkQZG6J1bNlgV79Vv2rtGZmZ2GjB90+1Euh0BxR6DtayCY7wq8jwx6+85lPd7ceJ+xFXnExri0iJWRsNrJU6MQV0AMnXGNrktUs8YVBPeFwMrFkkgcrMjNuniMSLdDeqaNaVVlGKvroG/AUfrDtYPBQMjvxHaXcFjnQf9b9WkAYyFAUZHnr3IG8wRVBIGJLn2wqUAfJXwX/xR5Cq+0WV/0Pg6zkzFUaPCG0Hhofn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNFOTFNcGphUkJxalJiRmdSOTIvWGNtaENqUjV1dFFrbjNQNmJkdzZYazdZ?=
 =?utf-8?B?Z3dtaWxNbXZicG16NlRaT2lEbzVWeE9oODVGbG5LanhLZ3I3OHg5UEhXZm04?=
 =?utf-8?B?UFRCM3BnQnhLbCtTYXMra0FxanZPa1VhQlluVWFoa1EzU21rRVEzYy9DY1Nq?=
 =?utf-8?B?NWRsTzlwVDlMbmlCaFF5c1NoNFdOeHQ2RTRRYnBobjJrNS9vdjdTaTRoazEv?=
 =?utf-8?B?U2ZRbjRMM2R3aTRGdEhldW1lN3dqVHBRZy8rR1F3OTMxdVN2Y3VPc3ZZdFlF?=
 =?utf-8?B?Y0F5VEhscUZFU015MjlNYXJpU0laZWR2Z1piVlA0Zy9PQ05vQmJjL2NXdktZ?=
 =?utf-8?B?Sy9xZWdDd2tQS25OVGh1Y3k5WjFXSnYzeW90SDM2ZHlvM2lzUUVBZEgyblJW?=
 =?utf-8?B?blZVUWt3TlVIWSszSFplR2tieXVleUFleE9CaW8yL1kvcElENmNTcFpzeWhW?=
 =?utf-8?B?c0d1Y05MQlRJY1BPL1VTQ25sZENGRGRlUVpYMUhIYnorN3hpYmhLZFhoTDdF?=
 =?utf-8?B?QlBHWlNjOGZmL053TFpCM240c0VVQlpxeTV5TkRuN1JYckZTOXlORHhPT3Z4?=
 =?utf-8?B?OFg0bDhHZVJkcWJWUDVibkw0dXFpMFB2dFFJaUxuL01tbTY3cDQrV0RxY3NK?=
 =?utf-8?B?bkZnSFNRMlJkOTUxZWpRMiswR3V1Vk1OMmQ4Uy92Slh1ckRoSUw2ZVZkdGQ1?=
 =?utf-8?B?THByeEdHNXpQekxyTUVTeVEvdGIxekJrOWRkcFVQQ2s5azRFT3JaK1VYR1BV?=
 =?utf-8?B?ajRlWTRJcjVvRGtBL25Ha3kzQU9rTm1PVzRzalp0cW1iY0N6WjZ6UEFEVktF?=
 =?utf-8?B?eWFLbG42bkFWQk92WVFoVCtzcTNWNUVhMnhFUnVJWEM3amJBdDRsbUs5NWhi?=
 =?utf-8?B?VEFtYllIaDdxS0hzNUlRLzE3YU8ySlVCRFBRU0k3SG5VUVh0Z1psd2c2aVpC?=
 =?utf-8?B?aGlYVnZOR0puclplMlBicVg4VGdJMy8wTDd1emhZWFV0eWN5NlppMWx0d3h4?=
 =?utf-8?B?VkNvWTZZbkRDUW5yb1FuQlZGUTlCUlFqZ2ZmVGZoRVhiaFJyVFF5cEZDV2NT?=
 =?utf-8?B?TmpzSDkvZEpSN2FsQ2Nhd0gvTTJrWFB5a0R6TEYwdWl1Nkw3eXRnc0hTYjFP?=
 =?utf-8?B?QUlyc3VvYzVTVDNXVVJNblhxQ3BCRW1ab2dnQklWWFpZOElGRzg2UzIrVlpV?=
 =?utf-8?B?L3F3MXc1Y05icDh6QmwrNXdnTmEveW5EcXNMdGsyL2hmNEFDRkFLeE01Yk9l?=
 =?utf-8?B?OHNMRmdCQU1LWWpwQnZmRjRwNGVZOTJOa1BjZmxUOUk3VDNHY0puYitscXoz?=
 =?utf-8?B?YURlMWlJY0tsOTZ3djNOSzI1NzNEc3JWczA3Kzc3YzJyZHB0VUdpd2NQaXE5?=
 =?utf-8?B?Z3ZEY0QyRHdubkVrVUFCZGZGR3RIcHE0ZjVWTEZyTHZ4UXVwZWxBbEFqKzJT?=
 =?utf-8?B?N0FrbThMSUNsMkhKYVByOGRlSXNDT2RWNGpmMk1ZanhjRERvZlpGL0creTgy?=
 =?utf-8?B?SXB6M2lMcGN6K0dxNzFYN2VZNFRrNlpJaXJpWTR4cGNUa2RZekNKZmwwblBY?=
 =?utf-8?B?eERwbVFFSW5xa29JNTVLRzZtNkxMMHhhUWQxbnRJUTE2cEswNk5UbVM1UFRM?=
 =?utf-8?B?TEVhTE5HdE5BakdRRUhlVDhsNlZVdWxFdk5zbStnY3VXSjNWZDJuRFhWYUJ5?=
 =?utf-8?B?S0Y2c3d6ZDVMM2R4d09TRjNueUxkOFBrbmRPM2ZFOEV4ZUtwcGpPSXY5dzJw?=
 =?utf-8?B?QU1FZ1lXcUd4TTNNRSsycStUM1U0U2VOV1ZxZnJ2WldsSWxyY3ZrMTlhT2hm?=
 =?utf-8?B?RW52OURrVTF3djJOeC9UbC9zby9NTTJDWlE2SC8xOU9ZVUNPRGIzRmVkMStu?=
 =?utf-8?B?SUYyRVMrbFpyK25wTzZtbXR6aVJBbHByM0k3NUJOa083NG9DVmF6allFSEp1?=
 =?utf-8?B?VGlxSFZQaXEwby96QzM2cnVFVDR0RUhuYjRBTEtpMm9aYjNLc0xBQzJmaHdT?=
 =?utf-8?B?L3orKzNGNlYzUENjZ1BTbFFWcmF1K3AxNFowY0w0Wi9MZVA2MTlONHNaTG4v?=
 =?utf-8?B?MFVUMkVyam1UVUJzL1huQUNOMElMWndhL010STJlNmRxOXhNTUJLdXd3cVd1?=
 =?utf-8?B?cGVNMjJrVXdJa1NMdTF4Tzl0K3ZEU2FVL2xGa0RIczNLV2NFcU43YVFWcWxL?=
 =?utf-8?B?T0Fhd1YwNTRxMjgrdnhIb0VHNm1rQlNyRjBxSzZzS3RVTWtzWDZSeE9lTFVC?=
 =?utf-8?B?YjVqOGR6SXo2QXNQcUFmc0M2VEg2aVlKeGtyb1FqV1JUUHkzOVdBKzNPckRJ?=
 =?utf-8?B?VzNrUjF2Uy9CUGdUUzl6MTN2dmgrY25jYzJsNzF5Wk9JKytLdnZYMFdaek1t?=
 =?utf-8?Q?bESmzV2RlnlowrBE3U4XJwJh1ueJ0j8K2/YuTbItNLqgI?=
X-MS-Exchange-AntiSpam-MessageData-1: N19vjRMxCI26yw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34631ae0-a581-4c2e-70dc-08de85828cf1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:41:29.3487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWY7yZvf7H/i6I9VTlH/wUpOYqaSZUC8QEZXuZcQsjM8GuELXryJFjzwAsG4/w+O4R3/Ah8CyoSfz9gcr1eD3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

On Thu Mar 19, 2026 at 2:36 PM JST, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read of write access, respectively.
>
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them is undefined behavior.
>
> Fix this by replacing the slice logic with pointer arithmetic and
> creating slices to valid regions only. It relies on unsafe code, but
> should be mostly replaced by `IoView` and `IoSlice` once they land.
>
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 135 ++++++++++++++++++++++++++++----=
------
>  1 file changed, 100 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index d36a62ba1c60..4200e7986774 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -251,38 +251,77 @@ fn new(dev: &device::Device<device::Bound>) -> Resu=
lt<Self> {
>      /// As the message queue is a circular buffer, the region may be dis=
contiguous in memory. In
>      /// that case the second slice will have a non-zero length.
>      fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut=
 [[u8; GSP_PAGE_SIZE]]) {
> -        let tx =3D self.cpu_write_ptr() as usize;
> -        let rx =3D self.gsp_read_ptr() as usize;
> +        let tx =3D num::u32_as_usize(self.cpu_write_ptr());
> +        let rx =3D num::u32_as_usize(self.gsp_read_ptr());
> +        // Number of pages between `tx` and the end of the command queue=
.
> +        // PANIC: Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_P=
AGES`.
> +        let after_tx_len =3D num::u32_as_usize(MSGQ_NUM_PAGES) - tx;
> =20
> +        // Pointer to the start of the CPU message queue.
> +        //
>          // SAFETY:
> -        // - The `CoherentAllocation` contains exactly one object.
> -        // - We will only access the driver-owned part of the shared mem=
ory.
> -        // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D &mut unsafe { self.0.as_slice_mut(0, 1) }.unwrap=
()[0];
> -        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_=
NUM_PAGES`.
> -        let (before_tx, after_tx) =3D gsp_mem.cpuq.msgq.data.split_at_mu=
t(tx);
> +        // - `self.0` contains exactly one element.
> +        // - `cpuq.msgq.data[0]` is within the bounds of that element.
> +        let data =3D unsafe { &raw mut (*self.0.start_ptr_mut()).cpuq.ms=
gq.data[0] };
> =20
> -        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_=
NUM_PAGES, inclusive,
> -        // belongs to the driver for writing.
> +        // Safety/Panic comments to be referenced by the code below.
> +        //
> +        // SAFETY[1]:
> +        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
> +        // - The area starting at `tx` and ending at `rx - 2` modulo `MS=
GQ_NUM_PAGES`,
> +        //   inclusive, belongs to the driver for writing and is not acc=
essed concurrently by
> +        //   the GSP.
> +        // - `tx + after_tx_len` =3D=3D `MSGQ_NUM_PAGES`.
> +        //
> +        // PANIC[1]:
> +        // - Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES`=
.
> +        // - Per the invariant of `gsp_read_ptr`, `rx < MSGQ_NUM_PAGES`.
> =20
>          if rx =3D=3D 0 {
> -            // Since `rx` is zero, leave an empty slot at end of the buf=
fer.
> -            let last =3D after_tx.len() - 1;
> -            (&mut after_tx[..last], &mut [])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                unsafe {
> +                    core::slice::from_raw_parts_mut(
> +                        data.add(tx),
> +                        // Since `rx` is zero, leave an empty slot at en=
d of the buffer.
> +                        // PANIC: See PANIC[1].
> +                        after_tx_len - 1,
> +                    )
> +                },
> +                &mut [],
> +            )
>          } else if rx <=3D tx {
>              // The area is discontiguous and we leave an empty slot befo=
re `rx`.
> -            // PANIC:
> -            // - The index `rx - 1` is non-negative because `rx !=3D 0` =
in this branch.
> -            // - The index does not exceed `before_tx.len()` (which equa=
ls `tx`) because
> -            //   `rx <=3D tx` in this branch.
> -            (after_tx, &mut before_tx[..(rx - 1)])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                unsafe { core::slice::from_raw_parts_mut(data.add(tx), a=
fter_tx_len) },
> +                // SAFETY: See SAFETY[1].
> +                unsafe {
> +                    core::slice::from_raw_parts_mut(
> +                        data,
> +                        // Leave one empty slot before `rx`.
> +                        // PANIC:
> +                        // - See PANIC[1].
> +                        // - `rx - 1` is non-negative because `rx !=3D 0=
` in this branch.
> +                        rx - 1,
> +                    )
> +                },
> +            )
>          } else {
>              // The area is contiguous and we leave an empty slot before =
`rx`.
> -            // PANIC:
> -            // - The index `rx - tx - 1` is non-negative because `rx > t=
x` in this branch.
> -            // - The index does not exceed `after_tx.len()` (which is `M=
SGQ_NUM_PAGES - tx`)
> -            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` inv=
ariant.
> -            (&mut after_tx[..(rx - tx - 1)], &mut [])
> +            (
> +                // SAFETY: See SAFETY[1].
> +                unsafe {
> +                    core::slice::from_raw_parts_mut(
> +                        data.add(tx),
> +                        // PANIC:
> +                        // - See PANIC[1].
> +                        // - `rx - tx - 1` is non-negative because `rx >=
 tx` in this branch.
> +                        rx - tx - 1,
> +                    )
> +                },
> +                &mut [],
> +            )
>          }
>      }
> =20
> @@ -308,24 +347,50 @@ fn driver_write_area_size(&self) -> usize {
>          let tx =3D self.gsp_write_ptr() as usize;
>          let rx =3D self.cpu_read_ptr() as usize;

Should we use u32_as_usize here too?

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
