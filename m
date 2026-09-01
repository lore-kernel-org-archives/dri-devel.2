Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70935C61DE4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F87210E37F;
	Tue,  1 Sep 2026 03:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fwv3mAyK";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76B610E37F
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 03:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGPrv65p0OSs7TcYFRQ3Eq0AEUmoJvtw5P2NrwmgR4nkoYst1m2gJfzjMTB2wLFRpr0mEp5jebgwwpMIAVqn8GBwfRg+YvOMuyJsseHhGy/P+lA383Sy6KBA5UhSA5qQ3iD0CLL5t1ZJVRfN6/8zBqkSI4OOaXAGFaCdg7VydxDVG1456MEEIMUJoM1WvfrE+nbjO+Dbl6VuENyhYrxsx0Cw4TJDUGGLbKJZSX75Hjkv9DAvb+QwHflfMfqqH2dRxSERx31n65tHdN7JmqaWRZe1H2W5gEGcl8bs9tJ6NMd9d6brHZ8k2dQzsCJ/20sYcsY3Zfbeu/RolfUiacx/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROX5LBvaIf6lRRKFRJT6HTvyjmO95dXz82C1sk59e3s=;
 b=HjCM5ab8y1LCHhZUenpwnvKJVuqaHE4SQxoBwEPiTkjXyd/IFZ5SGn8ceap2DAZNpR2bqoe7GhxNIIPsNivo60RiVYXudhzLpW3IBwgV6/BiS9CF0QS8C9REIyt7eelPZyuJ+qVrHIWCJdMbTtcrSigIbMVuGJb8rXmhfQzkPI+U4D3YSiLUXbUhufu001A7vFfUXi3yBkIucqwxtNYuNsgEslHqCjh31aNccB20BiGMt6JHtDj6lpQ/rkPymFzvWfxclBmChZpW1Hmp1SvqgBCE/wUaJwXIbGAGyDMaoWEXoblRlUk0fRKe5aZ2w41fxvr4v1wOokivHlMwyGUabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROX5LBvaIf6lRRKFRJT6HTvyjmO95dXz82C1sk59e3s=;
 b=Fwv3mAyKR9acVEnbRf/Ff+58L5enSB3AQ9kuXAhn5SJ4NsGc+bA0MH0/3jasYDw4gy+i9BOzHTsNKnhLZD7TWGLXunQBJAeXStKwCje83ytLLY886B6+Jl8t54l0TsX6OSOkeQeXCxqMPl2GLVfSR7soo434IhQrAlzrEkpZapkyaPS67CB3Il3N52d4fGqHBFDGA6P9MSj432sYiEsQnnh85T7O3ZZVoJ60FDRyGGmg90pkvQh9CvdRAM92uR0QHU50pVvKIjQGz0rrMOm4JYY7SUDpWibdcX1WvPf8pQpVKJA3PuFwTxNkIDYSsQGTng9gdTPcauLk/6JtWD0aGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:53:36 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:53:36 +0000
Date: Tue, 1 Sep 2026 13:53:31 +1000
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
Message-ID: <apZLLjyTqPnYRa-k@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
X-ClientProxiedBy: SY5P282CA0127.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::20) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e79ad9-a2cc-451b-76b2-08df07dc99cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|5023799004|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sS0PuR0sbxxKCbLF6wuzAcQ0UvbbDgoQ3NVgb+PSdRVq/uR+7JST+WmChiYaEjZWs3Z01ShnpodUzgrY4Buv+d8iKBXTu3wvkT1YtWaig6rdCDUQN1cSY3t/hrlsHtTSWeaaNgQizvAD1TNYTXCUs4Y9TxdYMDTt6VTozgMB5vFDWTnKIbNVPtqtMNme+zgijgAbuj9dGzIaEofYLFrBbf9swzAuOCWTGosWrY5M/otNjgt1N+D0mRTuRifkP0LNA6vxFEqvQtHNA87bUn5/yrZn/9fNikK3rXOX0+1h1teXB0UJZMrzDzfe6tTj9PT2B61+nQNCkSnyqjpv2zt05MaVaQCVS69ImJo/aL8Cl1is3cvNgGfGd7T/JMVUu1ThjTtIiXusTMM5SVokSu5umPapqlwJw+3yzVzuq2IxCyEom7qsVZktMJGuCSwkll94NXdHi5bYLV+PYJaSzGJOYivL61ikITpsViL0xskme13ToDd2Tj8xvB+xqsD5OKexNHZQw/lNOoN/dfcz+xeI0SUY4F1HdbX3zAtur4MhUA2lMChnTTL0g7iCxb0LDdRQKQTJ3uuhysXbb+kz+ZdXWU8wP0hGAZfkBXZbQU2vENgBjHylPPqk17JpZmrubuf3q794V7nwBo1J+r0+OYXSLmkMqq2OFPYIkKXI7SpBxkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(5023799004)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OkM1A1zowmG+6+IHLw3PoRglOGeYLmfGaOmz9s8PLdWpAWnFjtq5tnLDS+td?=
 =?us-ascii?Q?Y+TKCOV2qjZXaoio4BD2aJiTknv4kDwxVK2Ko9ndrb2kt+9x7p0xQJyRGpmp?=
 =?us-ascii?Q?IoivNgnrDjdxnYF7zVJ5tEXFlKXPyTz10FVHHo6AcDm46KqlIuTiZQFYBy4/?=
 =?us-ascii?Q?NcWdTTzUzqHyoxGXOFEKER63K+r9pO1DsZFD0NEykK3skDoqo3zzmWN0hj1T?=
 =?us-ascii?Q?OFGyn8OW/pl8KFwd4XgLPzRjPFnCOLeaafb5dARSahgUP2I4Mm9tQfqyMw3G?=
 =?us-ascii?Q?DXxV6XUvcEdcPFY1GxxtTT9bFu2Wb93WczITv8yfAAxKcVOkUaGIiF9Z+DKX?=
 =?us-ascii?Q?MGs+YhRAro6wdxNxGycK5q7eR8VhOh1vPNVseFGRsff7rvwi3JD/kpYzkiHL?=
 =?us-ascii?Q?5PXDg9ZbyfMqDkkw7okBgFR7kzgaONPO5aBjWlgabwnHc4MjXKj1WFLjtWuR?=
 =?us-ascii?Q?H4nXNAQoN4iDezfAGDaqCcb2M2k93d3kJZfJfJcmb2yNwRlPEWe96ph8xx0C?=
 =?us-ascii?Q?FFPD21jKmVfZ55J0fqawUX47J3vvTzRZby5u4SqOuBOMHl2VrgmrBXxAcDaI?=
 =?us-ascii?Q?aoWE9v1JioOuRc0ED2XoRwYtjQI3+2ZBca7m1+iLJ0H7po8BGF6AqU2SluSj?=
 =?us-ascii?Q?kQ82g8UNqx0pXt0lbLByMAqu2/7O5P47pEn07nsrBInY+mqqycF2IR8mSAw4?=
 =?us-ascii?Q?4YGnzitEsTLc56zux7iyMlxECwub6pdFapZWZURLDGFueZMqocc99Xhkf31n?=
 =?us-ascii?Q?KWJou33d7ChMrmw/WWIW58/vwcrQu9nA6JtOJTwoaOIKiGyQ5MV14Abr2wAl?=
 =?us-ascii?Q?3+GFQjKN7NVBLkuESgzbz6F6Q5AcSL2lS16b0kxRc/dNeNkGGWPTBOVlzBju?=
 =?us-ascii?Q?rT09/UMFw8p8e9MUmBv3JXbY3gQboXOYIrOBsVfbFKlmtWvvAQxqV2X4SHtZ?=
 =?us-ascii?Q?Yfn2bBr1WlRuwSq/Q2VWnFOrgNzGCNqpuvAZ5DBv6cQA6jVyL9Bc//TTeJrq?=
 =?us-ascii?Q?qYXQB/qJD8JkhumxvmDfIJIa+Y5N1BQXKJBTthSGosiLo+U8GMN96Ex7GkSV?=
 =?us-ascii?Q?A+ZI4CQYyBurCc6fGipRtj63h6XdKEgdQ467b9fk7hvHH7LxtF9fWO5b4nnP?=
 =?us-ascii?Q?K/dgIjnVcgVq/BdAqheKYeeT7pIEOJp20ghOOOlQ5QLPS+hjFy2qY7Uu8a+A?=
 =?us-ascii?Q?6mM0Qez+decXdLMqvG4ALwMUctKX8fJgercazx6QVJEG9HrC28UVjjHSuvR+?=
 =?us-ascii?Q?mcDWGqFmBsXO2kpqr8Jsbve1zzOGzILTzkySaWwCJ3V36JMHtoMUZ5BtqweF?=
 =?us-ascii?Q?pS+rWzPyOA0b0VAp5Y3ThulnKbWJZjH/mTQ3v0JZXuWt6XUD8NjmamhMf54g?=
 =?us-ascii?Q?5Z1y2qEEdC8WF1nt+A1sTFZnU80pif6tK4i8yPtT0GAssXjpdTMJ16euvsBr?=
 =?us-ascii?Q?GzMRomoROsWdzQhrWwgQISM9wbB2Nd6/07hBmldgK6QWda3VqGbj3VrNWvWd?=
 =?us-ascii?Q?Q/SU1AMOkpWBuhJtOlHmfevhe9Q8WGdvAwELE2OKopgZdLsKLddgfUN8zryN?=
 =?us-ascii?Q?ok6/aZDJxhlWVAyvO25NhxDzbWI+QC6AyY1ObKpf28T9T+EgmpOdUca9ILUQ?=
 =?us-ascii?Q?FLtEyHkWvf0TYrF8g7mN8ly81wJ72RFT+DxkOrYw5s66gWEAzb3e6hxFTFZt?=
 =?us-ascii?Q?nn1DnjrI9+HeEU5HH/e27CDbMcW7pUKroMnD0r9QoayrquYdF/8Deut8kZWc?=
 =?us-ascii?Q?8Arrcx9ZqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e79ad9-a2cc-451b-76b2-08df07dc99cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:53:36.7157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPMDst8KwTPM/3n3e3s0/rMxR7yeYGK0/YTa4QzjywqyzZCPfci16z18d5wCEWi2Hg5xVJ8yTYhakZy2IrztsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

Thanks. I remember that conversation, just that up until now I could get away
with it being Covariant which was nice :)

I'm in a bit of a painful situation atm where my local test box doesn't work
with older 570.144 firmware so I have to carry this on top of John's r000
patches to test which makes rebasing all kinds of fun. But will rebase to latest
drm-rust-next and see how I go with the below.

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
