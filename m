Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10558CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692AC10EEAB;
	Tue,  2 Jun 2026 10:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="kJprL328";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021121.outbound.protection.outlook.com [52.101.95.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FFA10EEAC
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8hLZIbx1cNyrUPaVQM6dREetPQt34pk4xiBezwZoOP1CRoeLD065ZZWVdO+6/2Pdhw2dLVFgTMevJZYm9Oi6xuj5Qqls7m/zPc4pBOipA5RzNLOxvKy73Nul/CCt3XhkB3Q7MV2jDg8xvwHLNd63NzRMu5XsJA75oQPJ3nN0Ry9X5EKLVbxZFFY9G2tdldF9jxs1qwwQUYh1lbvFge+fCGm7ulQKJsZfrzmCCstRZNlYtU1qolFGDzLIJ4bqhOvKuIS2zEqph3DvYIUL0jDiznf6f198xTeDVChjPiVV/o2CsLtNM5uM4Z3fgdXu/XYcxT0K0RQr3hZnxWHKwIASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0XHWVBWMC/ZiBi2lWkrzUtgO5tFa2uddX4W1nP220c=;
 b=sBFwMCmyjiprwOnIkwLL6LxR0kG05yzpMT2b0PwUxDcF/+PeSE8DeMhU5I+fanzp1BnA380GO9Aw8kXLOpKISOmqng6T0J7nhH6+zWcIY178kvuLu0+FGkHGEwBWkwHtbS872n9d64wUqOsNwwcFW1sYzrO3z8N2IlA4D5Sk616jc2wbOmulVQciOaUq+3K54/CyYdIxEeT9s8cPuy9DyUvmNhR6BCNu++/irPUina4RV4kD9mtWAb0ts86WHdvI3enGMHWUgqDGPHoUifRYLxMrglB8/LSclJOw53F+N+bxxMJ28QtbIPwOX71mP/Y/Ephw5XMdx/429LngVBct+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0XHWVBWMC/ZiBi2lWkrzUtgO5tFa2uddX4W1nP220c=;
 b=kJprL328qyCAvSZlKTqKxbYAjqJCHJ7BpVFxbxnOu1h1s9Wu5PxkAZdPSFaWC670EqBnrj8ljMgoK5lrk0ljpH/vKJWiIaqabi/nUnS1PpdPDGUGkBBbyVU6o9FnJfc57tQtTDd9Slo8mStif1H28PQxzjINrff0X5RxFs8LX0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8419.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 10:35:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 10:35:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 11:35:25 +0100
Message-Id: <DIYHW8MAG0AY.FJ96EJ5RDZK7@garyguo.net>
Subject: Re: [PATCH v2 2/2] drm/tyr: use IoMem directly instead of Devres
From: "Gary Guo" <gary@garyguo.net>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, <daniel.almeida@collabora.com>,
 <boris.brezillon@collabora.com>, <gary@garyguo.net>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260529000106.2257996-1-dakr@kernel.org>
 <20260529000106.2257996-3-dakr@kernel.org> <ah1SSN8_dCEA4Osz@google.com>
 <ah4t8IPo1L6XZMy_@um790>
In-Reply-To: <ah4t8IPo1L6XZMy_@um790>
X-ClientProxiedBy: LO4P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a5e06b-0857-4db7-d2eb-08dec092a8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Oecv4qTiMkFOU7x2DkG77h0i2Hn6E5sYULCRLcg8EWzmYhNEVjAMF/PKj7ErYTaSw9Enj5rbPkylWeMi2HVjJeLX9V1ISoT/sc9d8IZOhXjVNM9I1zscJrBIfswRqw2tEchoHt/UkrBLF1EhJafdbFn0T2iKIuXVg7FHGvglUhvSmvuGXIxzOtph371oYss73vct+lQNfAbgMS6HJPjx4bmcoIuhpQmxhzZrEnoBzKzOK4GXUAjEl4cdGSiDrVMAGebKccZ9QksRJroSWxip36qrFBxLEv3Z4F7h+NtSZQbML3p2neyd8Yo4uCiJdthf7IPvbkotgoOM2K9eMorkkOP0K1BOYhjbeVSJuOZz9vwz6ooBiwvGMIBdpY37TpEYtHXj7k6BYQAcOsbeSWGyzrDk0wjQWzJxxA6y8UfpznleHxT4gjTvghGmY7Om1tQJr6ODlvrNeLNFwDQoHvGsrMcACIlPlhWPUHgBenX5OgfdShotdrSBS1/AuVH4bj8dXOLsWvMfZhHRJ2IsVSbJKcmdv34YMoQ9B8z/UIi5WoaK8iIiQ+atGEgTKdyFu1SbmQ/CdBZ83g+JPqaQgjdyGVuHpTfKwENE26ahGK4hQeMUF8vCPemo6GZDsz2K7YSO5qgGOPjy5D99aMDGdrjYhBXWR5ZUSdICDzPYOSEcct76kvnfdGx+qK4ZBmaswYph
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnUxdUpMdnQrblcrVVY0aFlRTDJPZUhCbFU3cTMwb1plcnFWc0pWNy9qQXln?=
 =?utf-8?B?cml4bng5MC8rS2swWGg0U3JxaHRhZUVuWjlwYVd2ZTNLWFhOaE80aVhaR00y?=
 =?utf-8?B?N0hvZk9kQlNmVHBEcUlOZXBxZWVhRmRscHZ0TUc2RGJSRDRObTNueHE5dXJN?=
 =?utf-8?B?bDdaYkcvTHJYSEwvcjBnRE9ZMnlDczFYUmJXZndxRXBkWFVsRWVTTENDVUg3?=
 =?utf-8?B?WFI1Vk9EcytYeVNCUFVlLzFKSnJPZWQrdkxKZWFYWVJrTnBWOXZQTHU5bWxr?=
 =?utf-8?B?T3J1Wlpybk1VTENDYjQyYlZSTEdCd0pjeFU2elJlZXAvdFlUQmpnZDVkR3l0?=
 =?utf-8?B?MWEvdTltSEdpblg3NFYwYk52d1FmNFAyaHg2M1JkWlZFT200bkEzb3pQSGxh?=
 =?utf-8?B?OCtHOVhtUmF6MzJNanhSQlU1QVExeEVJVVNaTDdjb29heGNTZHRRQUlPSUZq?=
 =?utf-8?B?QmVEZHpRSW9PK3lHT3ZuZFU0cnZtc2JJWkhlRUgrNkl0MDI3aEJYcDJvTm1V?=
 =?utf-8?B?dk5UakFBM3oxQUxqa3hWUEFqZHczd1FqVDBteE04WTlsVVcrYi8reXVQL1hw?=
 =?utf-8?B?bXdRWlJZejJHOUJmMWFtcVdZQ3ErbTRXWnU1Z2laamFXZnVsR1VBUGFuVW9K?=
 =?utf-8?B?VTg3dFpNNzkxc3Y4a3E2alVsOXpVZmkzQmdxUVQ2TjRZN3IzNk9uTzRPb2JT?=
 =?utf-8?B?RnQxWjhLQ1NGcXphZ0FnLzdnU2F0RURFdGNrb2UzS0RZTGFsRzh3VUhvRjla?=
 =?utf-8?B?Y1krZTgwK0NNclVmTVBnV3BpMGxVY1F1Nm1DU1pwa0h4Q2R5OW9NMUs5eWdN?=
 =?utf-8?B?K2QvL2pWRDVwRHk4TzdDdVJrQ1pzeTVENnI0OGdVWURDYzgvYlBEMGZPTDRu?=
 =?utf-8?B?TjZRMzFiYXp1WGVNbCt6aUNyY2tCNnhtakQxb0RuT2xyQUFidVhPUmsrTWhL?=
 =?utf-8?B?Zy9IQXpvU2F1QjJkbjNBSnoxdjg2Z29RbmxXVXMzOWtVWFBLazMvNzRPS1RE?=
 =?utf-8?B?R25qd0d2MkloUWRNanBZZU5VMDhJc2xtTXM5S0o1dGltRjE5MU1DUnJwU2N6?=
 =?utf-8?B?WjBOWWZPZEp5V3RQb1NoeDFsY3VHbDRFdXNxeXNtQ2w4NC9pMFpwaVE2UGVh?=
 =?utf-8?B?bmFwZTBUL3JQTFdmUDliU0F0WTZYSDhQeFVUWWlxd3lLYVF3M1h1bS9UdDgw?=
 =?utf-8?B?UU1IL1I3VkgvRlA0dElDNUVlam1ZaEs4WS9Sb0RMQWlpRlJuZTk2eU14UUc4?=
 =?utf-8?B?RDRjSjY0MHlsSlMwekdtTTN6OEFrVWJTWmdUT1J1VHFkajhxMTJFNmFSZk9N?=
 =?utf-8?B?eTBGUy9QTGxSVlI4R3dnK0ZNMnU4MU1mUS9RQU00SEtvM3doODB3b1pCeW9a?=
 =?utf-8?B?ZmJUTVdpSW1Ob3FaQzhTZzhZTHYzTVhMUGFaNDVQSFlWckZ1NndNc1J3OGdE?=
 =?utf-8?B?cWZ3WlcwNU1NTW9wUzBwWWxOODF3UDVKYlBpdUp4RXNlaVdCTFpZTnVBamNO?=
 =?utf-8?B?TllFcXg4VWN5M0Irb0ptSjdldS9MbTV0NG9CZ1JBZEVNL1Z4OG5sOUxWOHZQ?=
 =?utf-8?B?em13WnlyN0tkczE1eEUrb2hMOXBNOHZDRHpiNzF5Q1ExRmc5VE1IWUUwckZ1?=
 =?utf-8?B?VGpDZ0RGRHVCaGd3YjNQOW8xMUN2USt3MmlZWWdlYUY2WFVUTlU4Q1Z3cU1t?=
 =?utf-8?B?RnpMNmJVM01qUUlLakRLK2RYQkNINGU3cXU1dklWZnRXRWRoSm80SVRNbllk?=
 =?utf-8?B?MVVCOXY3amNFdFU4b0p1SkN1YnRXNUppNzdKU3NFUHFSaUo1Z1VjQWhTclBN?=
 =?utf-8?B?MS9tVDlodlNzOFZLSUcrOCswckNYZkRQQlhCYWJYTGxqZXhyYlN1YVJrYjFX?=
 =?utf-8?B?eGJ2L2RVdCsyaE9CNWd4U3VickdlQzVmYmRObDNkQjlqZEozdTkxRVBrYTls?=
 =?utf-8?B?RlFieHh2VzkvSDM2dzR3S0tlWHpUakNQRzdDUldsNXNwRjA1clJRYXZQM0wy?=
 =?utf-8?B?QjZqVDFhZEovcjd2UkxBUkFHQXh4ZVZ0TStpaE1COElCQUpRdlJwV2ZEaXRn?=
 =?utf-8?B?K3pxUU9Dd1dKU0k1T0FuTHBiSGlvNVZhNG1tNHFyQklNUW9WV3YxMEN0S1hS?=
 =?utf-8?B?cTAyREpTRFBtL2N4ZVJKM2czb0huT3hEMXZ5c0FXRk0wMU96dlpxVlFxVDhS?=
 =?utf-8?B?S1NvaGdwWWY2VWFZeEkzRU13bWZoUGRKQWp0NmJBQ1lQK2tOYTJjTml4Ky9V?=
 =?utf-8?B?RHZKQnlvWTltNm1hbnRWZXNlcUpER0NPZUI4WG5jSFVOYWNtS3VXakttb1ln?=
 =?utf-8?B?MWlRR1BHejZhSi9ieXNhMDc5SDNvZERhQ0NpL0pOaWsyRklIQkFRQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a5e06b-0857-4db7-d2eb-08dec092a8a3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:35:26.1498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8+rFRgBTBxfCl5Ym6pDV/AiNcmGGzFqL3D3JjZOobwuQc49Q9PYuOU5eCTejVKAVTxc3dz//kPqsmdgxRmABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8419
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

On Tue Jun 2, 2026 at 2:12 AM BST, Deborah Brouwer wrote:
> On Mon, Jun 01, 2026 at 09:35:04AM +0000, Alice Ryhl wrote:
>> On Fri, May 29, 2026 at 02:00:54AM +0200, Danilo Krummrich wrote:
>> > Now that IoMem is lifetime-parameterized, use it directly in probe
>> > rather than wrapping it in Devres and Arc. The I/O memory mapping is
>> > only used during probe and not stored in driver data, so device-manage=
d
>> > revocation is unnecessary.
>> >=20
>> > This removes the Devres access(dev) pattern from issue_soft_reset(),
>> > GpuInfo::new(), and l2_power_on(), simplifying register access.
>> >=20
>> > Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>=20
>> > -pub(crate) type IoMem =3D kernel::io::mem::IoMem<'static, SZ_2M>;
>> > +pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
>>=20
>> It'd make more sense for me to put 'b or 'bound here.
>>=20
>> >          let sram_regulator =3D Regulator::<regulator::Enabled>::get(p=
dev.as_ref(), c"sram")?;
>> > =20
>> >          let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
>> > -        let iomem =3D Arc::new(request.iomap_sized::<SZ_2M>()?.into_d=
evres()?, GFP_KERNEL)?;
>> > +        let iomem =3D request.iomap_sized::<SZ_2M>()?;
>> > =20
>> >          issue_soft_reset(pdev.as_ref(), &iomem)?;
>> >          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
>> > =20
>> > -        let gpu_info =3D GpuInfo::new(pdev.as_ref(), &iomem)?;
>> > +        let gpu_info =3D GpuInfo::new(&iomem);
>>=20
>>=20
>> While this change is fine, I notice that we don't actually keep the
>> iomem alive past the probe method. I assume we're going to need that,
>> which leads to the question of whether we can store the iomem in the
>> places we need it.
>>=20
>> As far as I can tell, we can store it in TyrPlatformDriverData but not
>> in TyrDrmDeviceData, is that right?
>
> I'm still getting my head around how this applies to tyr's firmware
> series, but yes we stop storing iomem in TyrDrmDeviceData, but we won't
> store it in TyrPlatformDriverData.
> Instead there is a new struct "RegistrationData" that will store the iome=
m
> like this:
>
> #[vtable]
> impl drm::Driver for TyrDrmDriver {
>     type Data =3D TyrDrmDeviceData;
>     type RegistrationData =3D TyrDrmRegistrationData<'static>;
>

I am not sure what the distinction even mean for a class device?

There's 1 device per registration, so they're equal. Am I missing something=
?

Best,
Gary

> And then in probe something like:
>
>  let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
>   pdev: platform.clone(),
>   fw: firmware,
>   clks <- new_mutex!(Clocks {
>     core: core_clk,
>     stacks: stacks_clk,
>     coregroup: coregroup_clk,
>   }),
>   regulators <- new_mutex!(Regulators {
>     _mali: mali_regulator,
>     _sram: sram_regulator,
>   }),
>   iomem,
>   gpu_info,
>  });
>
>  drm::driver::Registration::new_foreign_owned(ddev, pdev.as_ref(), reg_da=
ta, 0)?;
>
>
>>=20
>> I guess it does make sense because the io memory goes away if the
>> underlying platform device (the bus) goes away, even if the drm device
>> still exists due to open fds from userspace.
>>=20
>> Alice


