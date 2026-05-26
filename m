Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BAECD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA7B10E1B9;
	Tue, 26 May 2026 01:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNbKk2co";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA68810E1B9
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 01:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJuhkOz+Oz5fIVIS5Wgx/IhvnJ3wGyDeGKzghYrLmKAnUQENT3HWz5c9TvKHPgrkZkGpvOf57tb2THEJdA1GNL7QU0qCjyVdKI7TvW73YwgPvzIiubiiuMUb+3Yw/WKmhdc9mQYf5zHi4EGpN/ZZ7C5qur2Lb0u/AdZs1ALyTHghbVry9W/ykU22hX1cO/lswhFpI1rQnq83imOA1hDdgR/b3SduNW4O84cRj1cmOWlPVObwsi/Sn4pVDTY57caOEccdbTVKQIRFG+nUFrmV/JYHOQHI+QVfPbukeCpBfyqOq1vakyYRxPJbw9K8cQOS0PaKdvPhQRBjANmUjBjbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CwI0w/CzWk1es0iLWxGFpKhgftCoYbbqI5DCR7t3rs=;
 b=KY6F3woVDhpOAl0qMYdbZhNHn+j2WwN7WPSGWQgJAtngILSfnxE/iRhMOhxWoOsd+L0jtf8rzSRWIxdEKuSPpK+y62KnsCQLWt5nTN/1mLnWWisjN2AGT4Qb9elhcN+JDjLKwZs+xupOXLaFcjRYwP/3C5C7qh0G6HkycgaWN6hgdkOt1F3xtoje8zpXfxdJvwPQewzSv8jJNZkhum7x55VYlFhyTHhVVK19MH0vTcDmlhkHXdxA4qn4HANJaOSqPnStjksayQiceMttXR4Yj3HY4xtrhzkg/LNNIhvts2+tikIhzWEaBUqKQGV1SAxcH2KGZacSBloST4RO2yu3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CwI0w/CzWk1es0iLWxGFpKhgftCoYbbqI5DCR7t3rs=;
 b=JNbKk2coyrBZbl4qS5gC0UqpbV2rjmYAOft8CPfYHg2QAZE18HggMeFDQDJNCfTUcm+nF0FvCI379+E7x5+hWZ4hnnFXm6qKRZywi53SnhuyMJoTi0RulQSecJBSpBKh+ZShTyStkpX2O+quJkvtm+tleollsUGBUqvsa974gnSOQ9WRfFTmvQqa5YaxTHbG4NjCynDpHgt7UW22HkIUUmLS/jTUB0a11yuELGYw+BILJZ+bRtwGcI9Frtk5ENShRd43g5dMGZ1JJatjB5xKcAP6m39aAd/5D65fi8wZEyy4Zhin3w8gFidauNL/G0uXa8ngBTtqCCGTLsmdWg4zkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 01:30:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 01:30:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:30:41 +0900
Message-Id: <DIS7XCG7NW8G.14R9ZG7S9LKR5@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <boris.brezillon@collabora.com>, <deborah.brouwer@collabora.com>,
 <gary@garyguo.net>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpu: drm: tyr: use IoMem directly instead of Devres
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-3-dakr@kernel.org>
In-Reply-To: <20260525230152.277820-3-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd6a905-cc0d-42db-500a-08debac6683b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: +3ifulj115+a943mzDqI8jZ/GxaUM32ViXJK1OrTALGY7mytrpoyOvPqI1dOmyhxxyzkymlX7bXyYabclSgc9k9vQLfWlvQOD49lSDrj46Fu9zgGKXeknRSdTlCcV1Ud4D0WrP/Ik6uj3xTYyT2YYOPCUtH8LDyk+tHO/cXlFhD7bu7VDjg7W1ePU9cckvLCnsdq84NMHJ+j2IiwMmzYvPF9j6r+0TErDVQa00vm+mtdp9GJs/YSJeq9a7nsm4eJBWmu7cUrOMeUJbU5DGM0vLyFA82v6Fe47hvncJnlPIRNWES4sDt/6S7SuoJ7SBC16Iyn6HnD6XiREYfAosEf7Hp+N5m7wWkHbziZZa+4Oig58mNab2m9GdtKbMKR6Eufzh7CqgBACq44y+QSCVzXeEdeP14Fo2Mql5x01QCb2PwvhBnwdb+E8cIJwQs7bh6OEUdvD3ssLgV5P8MErTczd5Cj243jIG20gp1vheXpkOiWCMdWPlnjTW0+ZamAW1u6jhqgZ6X3VKGo+ejGy/ITm6gCNxyLLEG6t4Tgdu1Ijc3H/d3H+CIdpZQtHCm/kjeBw/wmFjo591Tyr7tcgte3fQVK09yH4rkdJucPkx1nGMazEsiIYIWm8WXHn0Gp2muGwgEPFQMwWrkyKyfIpCbivgNQcpAK1+2OxfFp3tTRRVDyoyoLyJ0ITtIfivxY4yot
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVuQlpnY0thbm1jbDgzZjFkcUVJREtqOHU2TmR4TWJHRjQvZW5tcm5TeHRv?=
 =?utf-8?B?TmJSOUZndnB1ME5XcmxHQ3RZbzZyZHB5L3ptV2dKMTBTdDYrQk9CNDRoMGdm?=
 =?utf-8?B?ZnB4USt1cDArcXU5aVcxeXh4SDVPSEdvTklnZGVNc2FybFBiMjNlWmd5UDhp?=
 =?utf-8?B?R3JMdERVRDZQSlNSSU8rNDVBRXZZa1RzZ3BXb21WTlEzT1g3eFRCQkQ1S3Bo?=
 =?utf-8?B?NDZyV2pqMkxOQ0p0WkVHMkdTcCtmQVp6MUZnVWhXRWVuOHlNYWhWdTNTL0Vh?=
 =?utf-8?B?SnpOdEdhT2tOZU5lWHNTOC9IVFdFZ1BrSUt4UC85aUN4aHdIcnhBM2loU0Y4?=
 =?utf-8?B?RUJweDIzMlZDTjlCZWpNZDhyNHNwM2tBd05qOVdXRGtWK2xQd3dwL2QwUlha?=
 =?utf-8?B?bDM3c3VEMVhSbGV1Y1huM053VCtrM1dEYURiRlBUcWJSS3lNNi96NU1GOTJi?=
 =?utf-8?B?K1gxM2tWNm9ycUJCUWlsZStqWmY4L09JR0x0ZnphaEhJRzRrNFpjZis2ejVZ?=
 =?utf-8?B?Zm5kUDAyN2tQa1hzSUNtRDIzMGZILzFTMWg2Tk9zMVl1SExkcDZrYS9iSUJG?=
 =?utf-8?B?RjZSaTV5TnN4czNxYlloTUdpemRxaVE5TjdiZkorSzZwN3RkRktzNWN4LzJE?=
 =?utf-8?B?dk4rY25WSjFXYzRFOW5UN0FadFd5K2lSWTR1cmFCMEFQellHMDF1OUhKS3li?=
 =?utf-8?B?bFlkeU1WTkkvZFk5b3Nnc3BGMXFVQk1VUzN3TEtOOHlZNUYzSDk4SElGaThZ?=
 =?utf-8?B?b2RIWU9XTGFQM0xLTUNOYUhUQUEwT2xkRVFUc3JjOVVkcDdJSjRWR1RvWVNh?=
 =?utf-8?B?NnFRUTFOQ2V5ejVtOWxTd2ZhYldPMU95SEs3TFViSTFwK1ZOMndlVTlHdzNK?=
 =?utf-8?B?VklUajZIbDV5ZGd3VVNHSktoNTJsYmxQckpHanhsc2NPQm9PWWR2YlV4MFZO?=
 =?utf-8?B?cjdaMmNhd2N1Q2pDNFJGaTVWcDZxM2VHR1dpcWNCakxVdE53WXRqb0hFZ0hV?=
 =?utf-8?B?aWFneUgxNnJidkx2Sk9HVjB5OXRyaTZMWXlFWWR6N212c3UyWkNZbGtCbWI3?=
 =?utf-8?B?SGxVNmdVeWlKL2JtR25EMVRYLzM0Nk9IS0ZJemhDd2JUMkZvWFBVMGtidHhD?=
 =?utf-8?B?UHU3UW4yeDBsd1pvanZXU25sMDFrRDJPRmNtUEVRWWVwZU9YYm9kRWVPRVBz?=
 =?utf-8?B?ZndwTWg0TE5aN3VTWldRS2FXOGgyTFBxRk9Xc1llNUFWcTdqREVvUjhVS2o5?=
 =?utf-8?B?S3JRRmNxZFZ2azJFeis5ZmdpTjlhQSs1S2d1N0pQRzRZaEVNUjdGc203dDZm?=
 =?utf-8?B?WjJXTXBkRDBBb09SSWRjdER3VmxYK1dObWhCTWgydGk2Vm8zOXJQK2s5dklp?=
 =?utf-8?B?aE92ZjR0OW11KzdWby9ZeXhpazNES2ZaQkEvZW9TLzNGZG5Ec2tqV1BUYUIr?=
 =?utf-8?B?RDZxRW54NHB5ZlBnQTlSV0ZHZmVoSjdjTTgzcGtvc3BZNEs1YnVqaHl4UXU5?=
 =?utf-8?B?N0hQMlgySUIzdjVlVzk5Y3pGNkNCZE5iaVJJL1pnSEdST3dEQ2l0Q3d6TEFK?=
 =?utf-8?B?ZldLeloycjFhSG1oV1JnM1VLMU9oNkp3RmxOTGdNSjA0aFZySllRK2pNc29E?=
 =?utf-8?B?LzB5bU9Cc1NQbnh2MGZaWklGMHRrY0lGWitWeDhnbFk3VW5zNFpDVHdGR1hz?=
 =?utf-8?B?ZkdPRnlaV2hwbG9PQlFBRHlaQ0VqRTdnVTFOeTM1VjFmV04zZHQ1ZE1Lclk4?=
 =?utf-8?B?WGdVY0UwQ0JQT3RiK1BBTHBuVUZZMmR0RVZYU1ZXR21wNlJSNTloSHlQaVkr?=
 =?utf-8?B?cU5OOFo5QmI4RTNTT3JXMk5TNWl4Q08zSHJSY2NIbWpjZUkvbjVEOXIvU1lw?=
 =?utf-8?B?VEUvUnlHUFJBdEVnb2ZUSUZESFBlUUVoUitaU3NaVTl2M0hWYnRWSmx3QXps?=
 =?utf-8?B?TjBhZ1VBejlJSFpwVWNQTUpueHF6dFJDVEZJQ0IrSmRwL2pDaDVnOTZRNm9D?=
 =?utf-8?B?S1FtVVVneThTZjVpbUZ2OGJCdU50UFhhcXF0T1hkOGZ6aThqRHd4anN6V2xN?=
 =?utf-8?B?aG9YblpMS1ZWSGxWdTM0c0hqWjE5MVB0T2RtRlMrZGlreVJFRFJXTzR1TW5j?=
 =?utf-8?B?VGEwemlwcmh2LzlkaEhHaFFzazdldVFoa0c4Y1d4MTYvaXp2Q1ZlR29TZ3Bs?=
 =?utf-8?B?NStKc3hFYVloaVJjZmpqMStNckdnMlp6M1I0dE0vWnFVbFc0RzRudUNVZDhn?=
 =?utf-8?B?aTVlVVFsYUdZQmlLZVFyY3Vkem5WKzBhcVRPL1NlNUhqb0tRNUtRU0xuajM0?=
 =?utf-8?B?aXcwemo5QUJSR3hyckRvNXdZNmJRNEJzSjRWdmxWTUZGekR2emwvTXcyWWg4?=
 =?utf-8?Q?MNCiy82hBXe+sYabLwRTFFARbwYax8uvXhN5C8tc5igqY?=
X-MS-Exchange-AntiSpam-MessageData-1: XUeh2LNKj4XIvg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd6a905-cc0d-42db-500a-08debac6683b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:30:48.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikcnfcLmmR1iJwoUcM7S4/XRciTp2G0QVpjtGWiNU/5efCGjXNxp7CzouyqyrhjcWHb4WOLA8X+/1IAGdlmE0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
> Now that IoMem is lifetime-parameterized, use it directly in probe
> rather than wrapping it in Devres and Arc. The I/O memory mapping is
> only used during probe and not stored in driver data, so device-managed
> revocation is unnecessary.
>
> This removes the Devres access(dev) pattern from issue_soft_reset(),
> GpuInfo::new(), and l2_power_on(), simplifying register access.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/tyr/driver.rs | 19 ++++++-------------
>  drivers/gpu/drm/tyr/gpu.rs    | 13 +++----------
>  2 files changed, 9 insertions(+), 23 deletions(-)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
