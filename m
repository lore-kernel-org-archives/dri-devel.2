Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6097C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F83610E386;
	Mon,  7 Sep 2026 02:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SPx2LmT1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FC910E386
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 02:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3+7E7VsLgE766eRm6zplGrm7tmsfLmhNWp+XN0D1fNjikX0lYELwXF2jDWe6xXMaL0Cwuoqb1JxDjwmS1DB12MI8ZWwit4K2t01HMGBkiUP35PQch5xbHXZhVY+M6ILh37tUu4MhHzhaYYMXMElJ5uDEnRYmYOYieq93qQHK4CsFQEdU5hBp5w140+r5g2VW72k6rIj4oEXdaQde0x+3pYocQXlmzcu0BqZjh+O80rtRit5JtZ/jVWe+Ze3wmUI+MCaHnsviGxEi+X200HinUV85s4tNYYSvDidcLMRHm9NeQz52B23zMynAF0yOP6ryMfJTUMHlwNhPcq2tqu9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhujsUq4hzQzlVL2oDvoIlBCEmSkojnM4GbWpRCzsyw=;
 b=yQUDV+Idsu/L4Vd2QK1rY9w4T+f57GTixGqy1XaO+VBDtdNcj063N9egiibWgFpYOD8gPXfQMoDr12LoyuAKcbgImPHoLY+JaHGBvjKpZhUFqVQHfIibTOCf2irWqpStE5airvm0TlUPDjXlx+FEpTIaxEiJ1nssT5lDy6fXwGo7RvmhIl9lDvbvKg7xtYH4phAubxEB71TSJJjtq0G7Bz7AyYuz3f1Z7hPYiFHs7eL6+XM+tnWBPHj1sGVm/a00UouQ5db1hk9rXW8FuMidCvNJKuUbOd/Uy/el25zNP8dGgy7TDdqMQruqQDdeUHme/HRV9BRPQvdSmmJBl5Fnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhujsUq4hzQzlVL2oDvoIlBCEmSkojnM4GbWpRCzsyw=;
 b=SPx2LmT1DcMAHC8MfKhHmsf4tHQN4tgfIhBzEnR7nORo8FZCOb9yV2hrCEACDSCkKC0ZXw49dGnJSKqmxr+tpGmWepdApVQMPlMVrQauEtHoEvSsKbVWI88MMIqOZXiQpYEfLXaaZliXj50v/cNcO+k5Aj4NzGMx5/rD0tpKs201Td3OgmKV/vLlqheKOYmEZLgahpABZm6LA/JwcBechJn0apeoK4pJKKLBWTGB4TuJChmVN4hGbDwrj27jMBd7GD6CvSCUwpLQRh62I0TYHmnD+1FBr+3Y5A5Rdw3TT2V7Q7I2CnactHKTw00i9u0WntW5ozUbZkMVxnG4RjjnFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 02:43:49 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 02:43:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 11:43:46 +0900
Message-Id: <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Matteo Kloiber" <kernel@matt3o12.de>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <ojeda@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
In-Reply-To: <20260831233215.287881-3-kernel@matt3o12.de>
X-ClientProxiedBy: TYCP286CA0059.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 541488fe-e2bd-4091-cc53-08df0c89d87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|7416014|376014|23010399003|366016|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: aUiTGCuKKphqJ3P9B3FVn+BbgvhwnXJ743M+RDF9p2TZq0of+pUdBl6zeefPGYP6Prj11019Wu2NH+2xVEkzCHrT4znMWyYiBTScaxDDnmBkcYCxlmyJ4ehrco6ieF+OWtsbnd6jPMaoL8KwqTYKMUXPz6OS6sn5FyLHT058osa2ehl7iS60YSp76WjxSFT5xiQwdjo4E0rD58Cgf+Q4KjboHQUS+IrDzpdIEJ+Mfs+St3UCfvUHN4hizatiMwBF1IizMyCycoDBJZ/mDkU81zUUkVYp8KCYUqPFXouD+9h7VPeUUv7WHA4pLY2JTNbdlMKt8/ppRQuefXtPDMQOKvrLWRXJ+6XT7334CXuI2RArG2fDJK+CZiW9Ya3ZMIcLwDDiosQSmsyzso9yJLJadmxhxc4RBe+JTU48Dw+pRgtMpl7hJNiCJ5hcBuDzdWhhhTxP4yBkvxLqzGj0v70IBzgkVivste1OWa0XDY+a+B5BrQFAU4CszszAGB+JzRJKcwfUDL86bF7smVC7Ywh9KZq+843ko32Rvig3TT0VlI5Ax8jKAYC2/zFxdUeSb0UI8yiwbum6nh90TDVITZhojVu+RK2l276YLWn05+aA7pOvrRJD/7qxnpeUQUKwPpd+8HuQlRINUj+1aqjIO0zgF2mQ2kST9HO8K6Bv+E7D5Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(23010399003)(366016)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFpJcFpLYUdremhkaXBkY1cwOEluVENUY29FbGY1ek14R2VianBWUFNlbzVl?=
 =?utf-8?B?eWJ2N2N4TVRSZjBkRmxWTU5tMTVhUUJrUldKNE5Jb2RjNTRVSUhmc3ordmlK?=
 =?utf-8?B?SnBQMDNZUm91WW9WOFdVakgxeWFwSTNWb0cwWUN5bDE5T0xQNVU1azFCK1hF?=
 =?utf-8?B?S2t4NmxyUmFyaFhXY1ptNEV1WmdrRU84YzBkaWM2OEFOYkJ4SllQY2lHcldo?=
 =?utf-8?B?bmVQczY2SmJRRHVrWDVadkc3QnZLUW9YV1VrQlBwV0pXcU0vK0F4d0Z5Y2w1?=
 =?utf-8?B?czFCWGlqVklpZDloeUZhMm1WRDlqeG8wMjhHTm5Rc1pXNGdEaFRFYjZ1T0lG?=
 =?utf-8?B?Ukl0MitqVmo5SG1LRTkzYkZoTmpVRjhHajBkYzUwbGs2eGpTL3Z0NHVNd2tV?=
 =?utf-8?B?QzJ3UDcyV043dzZZaUliVGVvYk1NTERNZjZFd0dKUTA5M0JWTG9nZmJlcmpa?=
 =?utf-8?B?ckdSMmNPdFhQQ0VvVjVOdWhjU0wveVlSTGJsM0VUTVBmZHlzTGJxWXgwTmI2?=
 =?utf-8?B?OWtrNmxXMm1Ed0N4Zms2Z3ZuL1dOUm1UZWxCQUZSRXJkeGI5ZWZOci93ZmlJ?=
 =?utf-8?B?WUJxMVBvZ05seFpBQ3QweTJYL1krZXdvWVlMNXdvaVdRaDFoQ0VYZGNVZFha?=
 =?utf-8?B?UEFXeWM3cExDa1FlYm1yb25KK3B2UktBOUpwcDhCVnh3L09QOFl4QlgxTHNq?=
 =?utf-8?B?aFB2cktXN2VVenJPZkhSZ2FlRUVXWWRzL0tDK1QwWTBlNUZEYTl3b2JYKy81?=
 =?utf-8?B?b1dqWWV0UlphZW5qbDdBNEdTMnh6S2lNWUxMYk9CTWI4Nm0wRkoyUVp2SDZz?=
 =?utf-8?B?MnFBN0RpTlowZGJSVDUrRWc1RWZNVzZuSDZSNC9ySXlWa3Q3Z1FrMTVDTlRD?=
 =?utf-8?B?eUFIUzhPVVFIUHc1TUcyS0x4VXE5VFNuNSt3NDZNenhqRC9JMng4TTdDOWJ4?=
 =?utf-8?B?MnFwRzJpd0NRRXhzZ1lZUlVBYW12c1lkaVhBMU80dS9EMnN3WjUyRVpKMVNz?=
 =?utf-8?B?NTlYZzVlOWRPZHQ3WnFEYyt5cnZLQlowTHkyM1ViMHozV21ENG5wakg4RkQ2?=
 =?utf-8?B?Nm9Jd2lTM0wxSExGUjJBNEFZQnJBVENDVlBTWDFEMGhiTzdtUE50TkdYRkUy?=
 =?utf-8?B?ZDJ3NHdYZmJxbXZtR3V4bnpGUldQQVZva1NVQkRqTXR5cEFaTEI5RWZvd2d4?=
 =?utf-8?B?elpTYUFnSUhHOXJaWWk5VFV1NFBPZ2ExQ1V5eHlEd2hmcG1aclNjQXBrcWZI?=
 =?utf-8?B?UExDbCtpOUsxaUVsOHNHN21EK0NXdllzaytzS1QzVnRUbmRzTTdVYXlnNjFw?=
 =?utf-8?B?Ukl3RFVacUNLTTNPM25vVkFYTTB0bkNWTTBoMnZtR0srK21jd0tNSFFRTUpR?=
 =?utf-8?B?bzNkeGhlcGJRUktFeUxCc2JuOG03aVYwYnZqREo1d1BIWVVXZ3hrN3pKbVoz?=
 =?utf-8?B?QnFjdENVQTBDK05xbnlFY3g2eGl2clFWUkE5RHZweFJiSXNoRXhyUjMwYnBF?=
 =?utf-8?B?cVUzTkpKa2dPaUFpU2hWcHBQTnlJOWttNWZ3K2JoYnBiQVFDM0dsRmdXNVhn?=
 =?utf-8?B?QUVmbjhNOFhVdUM2dFl1SnZkd0wyOHg1Vit1SXFNanBWRTBnTjR0UHhKSVNx?=
 =?utf-8?B?TXNEL0ZkYjR5SVBJTnRSUkJha1NERTFXOXVSdWs5cmpxVXB1YW9RMExiRElY?=
 =?utf-8?B?dkhRZ0txUnZ6ZDVUQ3A1bWJYa0t3U2dJTmNWN2xpZzZtWWJ1WlZLa2lhL04y?=
 =?utf-8?B?bW9Vbm9vVUkya2RMY1ZNMlcwK2x3NE9RZU9YSXhiblpnd0s1ZG1DeTFRdXJm?=
 =?utf-8?B?M2EzcEIvTVE2ZGdGMlh5cytrcDdGaGlTMVorRFFXY3Vac2dIY0U2V0s0c3Ay?=
 =?utf-8?B?VXdsN0FxVDZjd3JPM0U0U3dDMWN4MkJlTS9Ed3J4THR0ZGt3ZFZ3OVUwcXU3?=
 =?utf-8?B?QXdocy9CMlRRQ0VlaDlacnZQQXE1UVI4d1l2cnI4Rmg5SWVoSXQ3TEFBOEVN?=
 =?utf-8?B?M08ydmZ1ak9SbjIvbVlWU3drK0QvVmVrUW05TjdYK2RNWHlCZHRnc3M0Vk85?=
 =?utf-8?B?di9UQ0RaMWNLeHBGNjVoSWJ4RFgwYUhsUDVSTVV0aVFIOTE3VCs4UUNWNVZV?=
 =?utf-8?B?YlFiUzdFZmRjQXU4aithaWt1bmZzUU1JdTY4SUZkSHFLNy91VkYybEhOOXBV?=
 =?utf-8?B?NWdmejhXQk1EQ2x0Ym1FQU5NOFpqeGhFTit4a3RKWk1TSFQzVEI2bEdqamVU?=
 =?utf-8?B?R0JIY3QyS3A1Y0FiZjlQSDcxdFc2WnlFSjRWNXJzbjUvYzEzTTVtclg1aGNa?=
 =?utf-8?B?c1NuTSsrOHlRZUsrZjJjU1M4dXRXb0w3eFBYcERTRmtwblc2REFvb3YrNUZj?=
 =?utf-8?Q?Go+ZSe8idf68mxryvLL8oCHGNnP1ulu4/2vytP4gcPUw+?=
X-MS-Exchange-AntiSpam-MessageData-1: QWPXB4KDFFNXjQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541488fe-e2bd-4091-cc53-08df0c89d87e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:43:49.5483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyqualnZqErKemPbymW/0PHUFCYkPA/tO8p/jJMg2KE63+rBpGoWlVJDJBPrAsKFozzbrfpPmaG/v9G0uGK5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

On Tue Sep 1, 2026 at 8:32 AM JST, Matteo Kloiber wrote:
> SGTable::new() caps segment length at dma_max_mapping_size() only, which
> limits the DMA mapping path (e.g. swiotlb), not the device itself. The
> per-device limit from dma_set_max_seg_size() is ignored, so contiguous
> page segments can be longer than the declared max segment size,
> potentially causing problems for future drivers that use this
> abstraction.
>
> nova-core declares an unlimited segment size, so this does not change
> its behavior.

I guess what this last paragraph wants to state is that no user is
affected by this patch? There is another subtle user though: the Rust
DMA sample.

In any case, this patch without patch 1 wouldn't break either of those
(only waste a bit more memory in SG entries with nova-core), so maybe we
can skip it.

>
> Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
> Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
> ---
>  rust/helpers/dma.c         |  5 +++++
>  rust/kernel/scatterlist.rs | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> index 9fbeb507b08c..ff8f24dae9df 100644
> --- a/rust/helpers/dma.c
> +++ b/rust/helpers/dma.c
> @@ -49,3 +49,8 @@ __rust_helper void rust_helper_dma_set_max_seg_size(str=
uct device *dev,
>  {
>  	dma_set_max_seg_size(dev, size);
>  }
> +
> +__rust_helper unsigned int rust_helper_dma_get_max_seg_size(struct devic=
e *dev)
> +{
> +	return dma_get_max_seg_size(dev);
> +}
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> index b83c468b5c63..d677dcbe7aac 100644
> --- a/rust/kernel/scatterlist.rs
> +++ b/rust/kernel/scatterlist.rs
> @@ -350,15 +350,23 @@ fn new(
>              page_vec.push(page.as_ptr(), flags)?;
>          }
> =20
> +        // Cap segments at both the DMA mapping-path limit and the devic=
e's declared
> +        // max segment size.
> +        //
>          // `dma_max_mapping_size` returns `size_t`, but `sg_alloc_table_=
from_pages_segment()` takes
>          // an `unsigned int`.
>          //
>          // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device=
`.
> -        let max_segment =3D match unsafe { bindings::dma_max_mapping_siz=
e(dev.as_raw()) } {
> +        let max_mapping =3D match unsafe { bindings::dma_max_mapping_siz=
e(dev.as_raw()) } {
>              0 =3D> u32::MAX,
> -            max_segment =3D> u32::try_from(max_segment).unwrap_or(u32::M=
AX),
> +            max_mapping =3D> u32::try_from(max_mapping).unwrap_or(u32::M=
AX),

nit: if we rename this variable, let's name it `max_mapping_size` for
consistency.

>          };
> =20
> +        // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device=
`.
> +        let max_seg_size =3D unsafe { bindings::dma_get_max_seg_size(dev=
.as_raw()) };
> +
> +        let max_segment =3D max_mapping.min(max_seg_size);

This looks like the correct thing to do indeed.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(the following is a related thought, not a request for this patch)

It also means that without patch 1, nova-core would split the firmware
into hundreds of 64KB SG entries, which is not breaking but still
something we want to avoid. The correct fix is to make sure that
`dma_set_max_seg_size` is called by the driver, and while we are at it
we also want every driver to call `dma_set_mask_and_coherent`. Ideally
we would use the type system to make sure that both functions are called
before any DMA operation can take place (using a safe interface), but
I'm not quite sure yet how we can do this.
