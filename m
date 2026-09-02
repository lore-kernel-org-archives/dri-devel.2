Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC9C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7BC10E47B;
	Wed,  2 Sep 2026 06:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWcktYrP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DABA10EFFC
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 06:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+ketqHfJ6uHhcfHTW/9pSLvnB69GR5rJDjRbQbdt2Jhi9vgTOME21T5njCxSfQZ0dxKlkHSeJXQ6PNovG811M2ytcMfDrCGfC3myYDA8FX3KBNGkdYHuc0EMOhKYdUfgSlVHx8GZkTF5PXU+pSVa8rkO/Cfne6/n/Nm2IFMZeWFoiPNVyuxf8pgXEbYJvbEFSUFBIcknJbKlDsU5zkos7nTmHYDPo4jXlc3vAxNoWlXLCqC8BYyjqFvHrIF1DuSTAcPvULUxd5LHZh5/etifZIyxnhT9Sr9B6dRjXNvEIs4A3k+V7O5r/Bw04FRbEg9DbLkdoOPrS9c1f2mGqh8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYAlejoqxj1zGpaoq63HZvLkIzQNjvsT0yBJDBlCDU0=;
 b=ihbFz4wVXXeuP7LYLJqBdC1pXW5pOiIttgHSz7SZ+luSFkhLbn+ZhZflbbB2seToTVI7z8mvrXbwxL9wkoTogdwYwgv5JgpslLqXv/pAD7zrN8hBH28Sd30Buk5Ya0GcBkDekfGgW8fR9mDuZmz9BTLEAUo/4EXiFmpDGsVwueI3OBR0ZR8hObcKsDG+vvg0uUvx3FqwxyC7E0m/TXkuY0wgoTkjeNHj7B+uuZ/nneW2sdrptbp3AAVEZtSHXHFkvVFOKfBh/xmlWF7/v/QDWVIQ9XI88OSSxiGsDFbsRcd3Lj/k1Rr9wlQt0yPjeiNaTBo7M9rQrPBuAkwSTYRI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYAlejoqxj1zGpaoq63HZvLkIzQNjvsT0yBJDBlCDU0=;
 b=EWcktYrPFBhSG20xJqOUJlqYxV2mSXzjGPD9RCcCONwmqez/EJM1QD5bDV02YVUxzCOocTpmVjM5rpBjLiRTwALNG452rKzvK2YWWCfOZmcbg2Vn8LbkjxuR29KZy9oFLHg/OHykG0Xby9MlIlbl9TN4uj1xgUtRvJTUnCEB7wFnbkcKUsX9mmxwYRjQ4g8Hn+dTHaL5NxAbV4zxJwWsCfopWDPlRlyB+W2s45SE7JjNNbCvy1JJYnP7CCcodYbpJrp1oLPuonGXbRNbWOdhhODTOKBt1/bUuRsMzZisUqtU3ulhWPPLAV31/4e1vBM5KUjm/GDzEcWgSSWC4tekHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 06:57:25 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:57:25 +0000
Date: Wed, 2 Sep 2026 16:57:19 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
Message-ID: <apfHOxl6uB8xQHBq@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
X-ClientProxiedBy: SY5P300CA0049.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::12) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 4874e533-3fd9-4103-63a5-08df08bf71cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|10067099003|11063799006|6133799003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2YjFWaw0X2cuKUN1+Ro4pYeH7am0FDWXz4G4ajs7GGrNZiDytjjy0+njZQe9yq3vsiwU4hjm0BBpSLt3ML1jbw8GOszkM91S5Z5HsnHNcQViDoQpX0CLkmOzV+wZroFDFBE6IvMuxAACgfCpEKtaIWgSp1zHxD7iU4rNKkViVqw0EVGzK5Xlnr+l4fUYv1FXNvQthjJ88g3lsfwZeWs4BsoKkznhK/z6ES89XXKpoNSeUS+k2I6i5pkFhhYi/SlKsgWoj4xjl4B1I7m4gHXvjTNUeWoWvrx+SBYOIz8dedwRyHLXd8w7Oe2vk2rKEW7sRsiaO4fAtT3jPo0IF4tv9Tvu84bzbXdPn9iVFin89YfzjBpFcTBJB7w53GXAZBVv5ckMVEs8FsEO++iSHtlDViu/4ov4Sp2HFp79esi3tqqYgK4zof/x9AAFt2d6fGKTJR4pHFHkqYCCvngexs/zqmApEc9g1wJZQByTKRr+I9tdTU0Rv+uuHong/hWlpJRgOtpPGXV5EwdLHqiHD1ghI4uj1mk43FC/dptyk8/ki7iml5F0XxK/6ow91jhd2jisQUgqLT17c40yeWSthL8gkWgSohRp8eslmsgbIsEpqoikRYsVa3r/fqD1uv0Jbmd2nFd7fJx2leQQiAPKT8JExFFfWlUF5hWvjsXtCoECfTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(6133799003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Am5yqs4GSqhu36N/TVYOhUkO+UaU4u8ixyGahjM2FFgRb90D996jiVR4K2eU?=
 =?us-ascii?Q?H2CJTRsbutOZU6aAVb3PqI2qgzIllwdOgrQE904KAtI1nvzrtlneYrKWZ9P8?=
 =?us-ascii?Q?8ZVHU6LVL6gFkg+xCA9NcKInRfrK4oxNA5pXG7yuITyaLifH9qi5h3U+D7v1?=
 =?us-ascii?Q?ItfPkl3k3ivZWa7xWCiq3FLVju3V6Oy/e8SdIgggK/4ZO19FSJajZNH+ojIM?=
 =?us-ascii?Q?aax7xl6ctOIb4t187LGF1BGTgUpH2RTux3t6anXoRC+2CFRCrDqX0c3xj/Sa?=
 =?us-ascii?Q?jTfslvA2Phs0/C85vfroxmySxOCCIMH7Ig5ukEkvAu9jboC8Xhha+SS+2Nr2?=
 =?us-ascii?Q?1K2Pg7/woZ+tzLd4ZF+wKDk+/dsHQb6+JyPcgFpXYTsgog9AJcX76y59wKkB?=
 =?us-ascii?Q?5NFmhx8PYgaUNOxCdV6JBoKFFbE2DPCBVu4zvnUx8egznuLSeUlkdaqNGTnx?=
 =?us-ascii?Q?yBT25WLJwNl2W+kE2sCo3SG9vFo6aNUolbnCaKySQ5fLT4mdMcf36uwdjJy9?=
 =?us-ascii?Q?nBN6Tm+TbmNTzKONVKOHcaLkpa4+bkg+MPZiyzBfWfVmYKzVRNNboRH17cj1?=
 =?us-ascii?Q?Rb8dygI0eQDNSqgpHSbdg60OSEh/Wn3oZ6nZaf21/GVBFRtnzoD1DgCw2wPI?=
 =?us-ascii?Q?YTjCPR+vs4WUX9pgkanPItbOqdzsYtU84naRVDVoiBVcCs8530b63i6RkZyq?=
 =?us-ascii?Q?QZbcoJ5rIRIWj7vDhdUHlPYqvK/Y15VVR/38nwHdIk7POxs+2eVaJDfSshJg?=
 =?us-ascii?Q?7XjCTR1dBPegUS7v8YxoEaxU7CK1Slq6PsFOKgYNUzjiepl3Hmta5e0/iObv?=
 =?us-ascii?Q?ZwVPAnghj+xbdKCkLR4NtfJ+A8Rf+hPCaOjDbIrALEkOFo7PJkexRj7XTPvu?=
 =?us-ascii?Q?1OXHL3KA19+A9II/jamcKqOjT8Sv08RXLx2lw41Nji0VECKaOBYar5tO5HSC?=
 =?us-ascii?Q?QzkJ6p+ypZCRvCrPWdaMaUjOv2oAIq0RO/wqnoelxS7pcG6KZqSx3+KCR/oV?=
 =?us-ascii?Q?aNiBcXiixJ14q0Yhi3KL5l6VrIVl70MuEmfZOzKAl/PrIA48FNLZ3syEPHev?=
 =?us-ascii?Q?fKLx99mKPMJI3Oc5veVTndK5U6KrtY124nE7f/Ny05vONRTRY5nMtlfsGcnO?=
 =?us-ascii?Q?fr7RWHg2KDp3F8Qx/gqaWoSDg563iuejiiU0H17BPc5TJTZD0wJruQ9y/oG7?=
 =?us-ascii?Q?dCVyxpvSg4pp3PYQ5BpqDq+YBewy64Liffix3YCj/9MQeHbOFnyOIrZltOut?=
 =?us-ascii?Q?8GXcR3d7bT7NHY/NLdP3cYIhRr2aGZzndkkT0szF7oM/xCPA2Op0ViAvziSg?=
 =?us-ascii?Q?Qeh2bEOsZjVnOKOjVMNx7QM7nvLuQccBNvYVp+8EiZFsFEqqlWfVHMp5HsMz?=
 =?us-ascii?Q?z3lLTWWGIs0Y66eZ36fRNQ6DEDzf4dgOfVtiNituhdb60/0eQjEnlsSMEDV6?=
 =?us-ascii?Q?ZeoD05X1p1vEI9gvTa5VQtbThmAoCPXv0YkhXLG4lECXgqF2V33jstGFd+RL?=
 =?us-ascii?Q?LHwKJnLC1ch6cSY8iFSHuBhlmV++oJJOn5JAhRf48C4zZdaFc/oBl4HLiTVd?=
 =?us-ascii?Q?6bm8Ako1Y/NnEH70eteGn18U1qpTzjhIkZo51XUJCJDl2Rv/e7y+39BzSRlX?=
 =?us-ascii?Q?oBm1tfOdkme3dCM5YukniQHPy5SfJB7SHB5PyBqra3ZId5gXo2k7t2/EPhxb?=
 =?us-ascii?Q?RtFE86JmLzVN4KhXxJEmnSssFRMsdRZwXamOeDkPv2J9QhOf+HrPMlwjJqK0?=
 =?us-ascii?Q?8JaQAmKy5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4874e533-3fd9-4103-63a5-08df08bf71cd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:57:25.3983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yWbj0y4bu+9/pMvtuUe72FG03Bd59BMJAUNEHeJt5ofTzJMiuI38fw0nO2BVXWuKWCdGXL9K+HEoEwpK1nt2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

On 2026-09-01 at 06:08 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> > +/// API handle for the auxiliary bus child drivers to interact with nova-core.
> > +pub struct NovaCoreApi<'bound> {
> > +    #[expect(unused)]
> > +    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> > +}
> > +
> > +impl NovaCoreApi<'_> {
> > +    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
> > +    /// by nova-core.
> > +    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> > +        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> > +    }
> > +}
> 
> CovariantForLt does not hold anymore on latest drm-rust-next, as Cmdq has a
> Mutex. So, this needs ForLt now and therefore the approach that I shared in [1]
> a while ago. I applied the changes in [2] to fix it up.
> 
> I think the closure access through api.with(|api| ...) is fine in most cases,
> but there are a few options if we run into cases where we consider it a bit
> inconvinient.
> 
> I think it should be possible to support projections into T: 'static and
> covariant fields. The reason I differentiate them is because T: 'static is very
> convinient, but non-'static covariant types need an annoying turbofish.
> 
> For T: 'static types it would turn out like this
> 
> 	let spec = reg_data.api.project(|api| api.spec());
> 
> such that everything that needs spec does not need to be in the closure anymore.
> 
> For non-'static covariant fields we could have
> 
> 	let foo = reg_data.api.project_lt::<CovariantForLt!(Foo<'_>)>(|api| api.foo());
> 
> but as mentioned it unfortunately needs the turbofish. Of course we could invent
> a macro around it to get rid of the turbofish, but we'd still need to explicitly
> mention the type Foo<'_>, so it doesn't buy us a lot.
> 
> This is the implementation I came up with in nova-core
> 
> 	/// Projects a `'static` sub-field out of the registration data.
> 	///
> 	/// `T` is fully inferred from the closure. For projected types with a lifetime parameter,
> 	/// use [`Self::project_lt`].
> 	pub fn project<T: 'static>(
> 	    &self,
> 	    f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> &'b T,
> 	) -> &'a T {
> 	    self.adev
> 	        .registration_data_field::<ForLt!(NovaCoreApi<'_>), T>(f)
> 	        .expect("TypeId was validated in NovaCoreApiHandle::of()")
> 	}
> 	
> 	/// Projects a covariant sub-field out of the registration data.
> 	///
> 	/// Supports projected types with a lifetime parameter via a
> 	/// [`CovariantForLt`](trait@CovariantForLt) encoding. Unlike [`Self::project`], `G` cannot
> 	/// be inferred and must be specified explicitly.
> 	pub fn project_lt<G: CovariantForLt + 'static>(
> 	    &self,
> 	    f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> &'b G::Of<'b>,
> 	) -> &'a G::Of<'a> {
> 	    self.adev
> 	        .registration_data_project::<ForLt!(NovaCoreApi<'_>), G>(f)
> 	        .expect("TypeId was validated in NovaCoreApiHandle::of()")
> 	}
> 
> and this is what we'd need in the auxiliary bus
> 
> 	/// Projects a covariant sub-field out of potentially invariant registration data.
> 	///
> 	/// `F` is the [`ForLt`](trait@ForLt) encoding of the registration data type. `G` is the
> 	/// [`CovariantForLt`](trait@CovariantForLt) encoding of the projected sub-field type.
> 	///
> 	/// For projected types that are `'static`, prefer [`Self::registration_data_field`] which
> 	/// does not require a [`CovariantForLt`](trait@CovariantForLt) encoding and fully infers `T`.
> 	///
> 	/// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
> 	/// [`Registration::new()`]. Returns [`ENOENT`] if no registration data has been set.
> 	#[inline]
> 	pub fn registration_data_project<F, G>(
> 	    &self,
> 	    project: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> &'a G::Of<'a>,
> 	) -> Result<&G::Of<'_>>
> 	where
> 	    F: ForLt + 'static,
> 	    G: CovariantForLt + 'static,
> 	{
> 	    let ptr = self.registration_data_with::<F, *const ()>(|data| {
> 	        core::ptr::from_ref::<G::Of<'_>>(project(data)).cast::<()>()
> 	    })?;
> 	
> 	    // SAFETY:
> 	    // - The HRTB bound on `project` ensures the returned pointer is derived from the
> 	    //   registration data (nothing else lives for universally quantified `'a`).
> 	    // - `G: CovariantForLt` guarantees that shortening the lifetime of `G::Of` is sound.
> 	    // - The registration data is heap-allocated and outlives the device's bound state.
> 	    Ok(unsafe { &*ptr.cast::<G::Of<'_>>() })
> 	}
> 	
> 	/// Projects a `'static` sub-field out of potentially invariant registration data.
> 	///
> 	/// Simplified variant of [`Self::registration_data_project`] for projected types that are
> 	/// `'static`. Since `&'a T` is trivially covariant when `T: 'static`, no
> 	/// [`CovariantForLt`](trait@CovariantForLt) encoding is needed and `T` is fully inferred
> 	/// from the closure.
> 	///
> 	/// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
> 	/// [`Registration::new()`]. Returns [`ENOENT`] if no registration data has been set.
> 	#[inline]
> 	pub fn registration_data_field<F: ForLt + 'static, T: 'static>(
> 	    &self,
> 	    project: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> &'a T,
> 	) -> Result<&T> {
> 	    let ptr = self.registration_data_with::<F, *const T>(|data| {
> 	        core::ptr::from_ref(project(data))
> 	    })?;
> 	
> 	    // SAFETY:
> 	    // - The HRTB bound on `project` ensures the returned pointer is derived from the
> 	    //   registration data (nothing else lives for universally quantified `'a`).
> 	    // - `T: 'static` means `&T` is trivially covariant; lifetime shortening is sound.
> 	    // - The registration data is heap-allocated and outlives the device's bound state.
> 	    Ok(unsafe { &*ptr })
> 	}
> 
> with the documentation being written by an LLM and unchecked.
> 
> I think at least the T: 'static projection can provide an ergonomic advantage
> and might be useful to add. Please let me know what you think.

Not being a Rust variance ninja it took me a while to figure this out :) But now
that I have I agree the projections for 'static at least are quite nice and I
think Gary's suggestion helps a bit as well for non-static. So assuming you're
ok with me adding this code with your Co-developed-by or other appropriate tag
then I will incorporate this idea into v6 so everything keeps working if/when
Covariance no longer holds for Gpu.

Thanks!

 - Alistair

> 
> Thanks,
> Danilo
> 
> [1] https://lore.kernel.org/all/DJQSY9ZY5M5F.3VI537GS00E1G@kernel.org/
> [2] CovariantForLt to ForLt changes for nova-core
> 
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
> index 7fc0baef5f04..028020213ac5 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> 
> -use core::pin::Pin;
> -
>  use kernel::{
>      auxiliary,
>      device::{
> @@ -20,7 +18,10 @@
>  use crate::file::File;
>  use crate::gem::NovaObject;
> 
> -use nova_core::api::NovaCoreApi;
> +use nova_core::api::{
> +    NovaCoreApi,
> +    NovaCoreApiHandle, //
> +};
> 
>  pub(crate) struct NovaDriver;
> 
> @@ -32,7 +33,7 @@ pub(crate) struct Nova<'bound> {
> 
>  /// DRM registration data, accessible from ioctl handlers via the registration guard.
>  pub(crate) struct DrmRegData<'bound> {
> -    pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
> +    pub(crate) api: NovaCoreApiHandle<'bound>,
>  }
> 
>  /// Convienence type alias for the DRM device type for this driver
> @@ -69,7 +70,7 @@ fn probe<'bound>(
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>          let drm = drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
>          let reg_data = DrmRegData {
> -            api: NovaCoreApi::of(adev)?,
> +            api: NovaCoreApi::handle(adev)?,
>          };
>          // SAFETY: `reg` is stored in `Nova` and dropped when the driver is unbound; it is
>          // never forgotten.
> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index e1223a29f8b1..798b14f33e20 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -32,13 +32,15 @@
> 
>  impl GpuInfo {
>      fn new(reg_data: &DrmRegData<'_>) -> Self {
> -        Self(uapi::drm_nova_gpu_info {
> -            architecture: reg_data.api.architecture(),
> -            implementation: reg_data.api.implementation(),
> -            vram_size: reg_data.api.vram_size(),
> -            gpu_name: reg_data.api.gpu_name(),
> -            gpu_short_name: reg_data.api.gpu_short_name(),
> -            gpu_gid: reg_data.api.gpu_gid(),
> +        reg_data.api.with(|api| {
> +            Self(uapi::drm_nova_gpu_info {
> +                architecture: api.architecture(),
> +                implementation: api.implementation(),
> +                vram_size: api.vram_size(),
> +                gpu_name: api.gpu_name(),
> +                gpu_short_name: api.gpu_short_name(),
> +                gpu_gid: api.gpu_gid(),
> +            })
>          })
>      }
>  }
> @@ -74,7 +76,7 @@ pub(crate) fn get_param(
>          _file: &drm::File<File>,
>      ) -> Result<u32> {
>          let value = match getparam.param as u32 {
> -            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.bar1_size()?,
> +            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.with(|api| api.bar1_size())?,
>              _ => return Err(EINVAL),
>          };
> 
> diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
> index ad4b62db1e5f..c9ae48d278af 100644
> --- a/drivers/gpu/nova-core/api.rs
> +++ b/drivers/gpu/nova-core/api.rs
> @@ -10,7 +10,7 @@
>      device::Bound,
>      pci,
>      prelude::*,
> -    types::CovariantForLt, //
> +    types::ForLt, //
>  };
> 
>  use crate::gpu::{
> @@ -39,10 +39,9 @@ impl NovaCoreApi<'_> {
>          *self.gpu.gsp_static_info.gpu_gid()
>      }
> 
> -    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
> -    /// by nova-core.
> -    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> -        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> +    /// Obtain a [`NovaCoreApiHandle`] from an auxiliary device registered by nova-core.
> +    pub fn handle(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
> +        NovaCoreApiHandle::of(adev)
>      }
> 
>      /// Returns the architecture identifier of this GPU.
> @@ -66,3 +65,22 @@ pub fn vram_size(&self) -> u64 {
>          self.gpu.gsp_static_info.vram_size()
>      }
>  }
> +
> +/// Closure-based API handle for invariant registration data types.
> +pub struct NovaCoreApiHandle<'a> {
> +    adev: &'a auxiliary::Device<Bound>,
> +}
> +
> +impl<'a> NovaCoreApiHandle<'a> {
> +    fn of(adev: &'a auxiliary::Device<Bound>) -> Result<Self> {
> +        adev.registration_data_with::<ForLt!(NovaCoreApi<'_>), ()>(|_| ())?;
> +        Ok(Self { adev })
> +    }
> +
> +    /// Access the [`NovaCoreApi`] through a closure.
> +    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> R) -> R {
> +        self.adev
> +            .registration_data_with::<ForLt!(NovaCoreApi<'_>), R>(f)
> +            .expect("TypeId was validated in NovaCoreApiHandle::of()")
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 4d3c18d6a733..025ba2869d6c 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -15,7 +15,7 @@
>          Atomic,
>          Relaxed, //
>      },
> -    types::CovariantForLt,
> +    types::ForLt,
>  };
> 
>  use crate::{
> @@ -29,7 +29,7 @@
>  #[pin_data]
>  pub(crate) struct NovaCore<'bound> {
>      #[allow(clippy::type_complexity)]
> -    _reg: auxiliary::Registration<'bound, CovariantForLt!(NovaCoreApi<'_>)>,
> +    _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
>      #[pin]
>      pub(crate) gpu: Gpu<'bound>,
>      bar: pci::Bar<'bound, BAR0_SIZE>,
