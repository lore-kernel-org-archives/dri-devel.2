Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31284C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2159D10E339;
	Mon, 31 Aug 2026 20:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="WIKveXy2";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022094.outbound.protection.outlook.com [52.101.96.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306FB10E20B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq//gNpz4Lkri25Ks+J9fhUxaXCdS+j80m0B7ncH+khHynMIXGhk8wH9UsV7a4VFPXyy2YNXFahniNcR0CSStb9J2Av7Bt8kPzzSl0mEeS0dpr07EoDEbyjFtwotsijHkX4jBl3Nz3qHr0C+bHkGAFS1+dnkZfh9A82ku4/vkZtyoEcl7r9X59/aXcucQ03DbZLqnRUbNX5P+KgYJBPLSzYvhvKSABZy0BWBima1xFpDZA3PmSlJVQ6j079raMyH1qtyOD0s7ZTsRPGi6Yh9xeihPTPwQ8aiiWUIXMqjcmTNbGB1F55iD54NuH4KxNKgWsZntBkTlG5B3PlfvSGUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBNOR9CJeplUUoxRXX3rH3i5YybGZO83lhDr3z6Auu4=;
 b=m2EkWlkHRZTkFnHNq0+erZ7jMLfHfCqZ7xWkDCRXjGu4LkmGBITCJPiSv+TmJetDVsYB40CsYEOsqNS1gp0qboRm/bueH6t9fkWUoUTRt3u7FH+yBHNfAwSU61rqpOZe8BFZJ4y0Lns95EP7ACfsmq2xB2FnMqO7p9SW2URUVtc0tsrIp2pE8X6g91VHcsqQqoNy0s4Ujo52oPwmdEAwprFKeRZ8NI3EOm+7aWMGfX+jZUB/hP0pf48WUcyikA3KRt1To+ZkpX4+kq4RnI4LjYQ3wl04Pi3mXQVIUw3dB5iNH5UTCBHACsXmqAgNpL8o6Uextvl7OsmfS49ojITTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBNOR9CJeplUUoxRXX3rH3i5YybGZO83lhDr3z6Auu4=;
 b=WIKveXy2VZjvKI+PlYWdcUpOF6gl9CQJ1I6YpRbyGw6JJzFCNdw9YanWovzYqO24WurwbneGOjhr2V3IVgROSFZbw91wlpa90R6ofxtaRkB4NSP8d6HKQr9TwjLZFHtgWInGswbnwde0V7w6es9cY5vuc+rHgt9Vg3mzHlhkYxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6961.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:42:56 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 20:42:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 21:42:55 +0100
Message-Id: <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alistair Popple"
 <apopple@nvidia.com>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
In-Reply-To: <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: d159f670-1640-4e92-9555-08df07a06fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|10070799003|4143699003|5023799004|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jJjbJJvQkZjksYulZAaMe/6wUsTwneM3rjmTgLNaeDZvWsFsOgKeezO5pgwUgCcr/eb9ipRU30zeOjbtQluZ8ExV4OY4sczUPqFOuEZynymVKV3qchn9NyCgC7DrdZHoLhPKtBPHaXl26UzpxbsaysK0w7Zc3BTrmR2XQfheWKxXNCo/RklgtIs/aAnHpD2jKKZhEE6bQ2BmunK8QuF/t9eXUYwXnIxl1vFjNNNrhTx6hwYvv5OQazf860UWVho/Z1ZdXTCqqQ47WbwLuqBarojW3y7meY/6O5iitURox7VZtRebjNTcsIMV3S5lXZmNduAqnjghHajx7rjGBnP7nJarhqSSUHMHaD+sEgdETPt+DaTPwFetWCQQYNg3ZGp8n6A0FYaZlgOEUSNRopDh7eyGzZDbpYnY5F/jclE3UkAdzbsJGRVAV7OTVE0Ks/corMQKxm7oE0C/ZMIVJ+ElDsCtxE2eMt73g/8FVyfNrWkaQg2JfM31vfSF+fzXCBImMjkY5aevY6V92SDmdOqO2fcqLBAR1RBprO5WgpkCtSoLizNHAn4SiS7QvnSq3KihFbLaPDqZn63co6m4aFSe/qdtQ364SPU4NtjHmXAUxl9MRwHjdhXrNIXbyEjinO3iqZ3xgd+L6Ug9A9Gab7/s9X8NQ1efPnFPb3n87EKvoLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10070799003)(4143699003)(5023799004)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJVMFJGcG8xZmN4M2tGR2VvNWQ0eGlBN1QzU1RFY3o3b2ErSUhzSmJmTlVP?=
 =?utf-8?B?azc2UzhMZ3dLZWNDSkt3RTA5QS9ONnFyUEFGblBiTXJBYzZwTTlUbHlkSFdS?=
 =?utf-8?B?aSsrZTZUY085M002SVFUckg3aGV0SUZ3MlNXanVUTHZXR3F3d2w5OUZZZTJC?=
 =?utf-8?B?S0Z2RmdMYm1iRzZmT0xHVnFPV3NVUC9VZXBQOVNUdUNWN1ZpQTV4cE52V0hn?=
 =?utf-8?B?bklYNENPZHJJQ2R1dGxvZVhuSmp5WWNuemRXcjJKWnlackdKYUFiSWc0YmFq?=
 =?utf-8?B?b1JDWDhkTmxxS2dob1FtRFI1S0tDU2I0Y0c5ZEt6Mmh3RWtsSnUzcEZyUTF4?=
 =?utf-8?B?cTU4YTNHL3E3T29UMUhhMkVOaW5KQWtPQ1FEaVFkdFlYMGxTaHpzSjd2WUJw?=
 =?utf-8?B?eDV5R2ZlaWRJY20xb1hGVURDcEticElrdU10UG5kNlhjNi8wRHU2OStiSHhu?=
 =?utf-8?B?U0lORE9INTVRMzNEcmZ4bXh6Q1daM0N0Z09KcldxY1NlVG9WWEtvd2lrTS9p?=
 =?utf-8?B?bldQRkRGVUJLTklxSWZSV0F2UDBqY1hLVU9SQzlsM1lnSnVFb0ErZitxR0tr?=
 =?utf-8?B?N0o4TU83bEpBZGdiZ2xYenJ5eFNJS1kzdUhZc2xvT0RpNE1yTU5uQWZEM2lr?=
 =?utf-8?B?enFKK210S2xJenZzeVdkK0g0dlBNY2FoN1dMVGZEd1JXc1dOcVNzR2FabWNo?=
 =?utf-8?B?a3dZVEU2Qmdtb1RlSWg3K3RRZDlMN2ovZ0Z5SFRzVjFFRS9lYVpLdXMzdk5R?=
 =?utf-8?B?QzUybkIrdGNxWUM2T2pvYmpmNCtGRWxBaWtkbGp3K2ZNeUt3WUdZTkVkdXdy?=
 =?utf-8?B?Rm1QTnVadytiVzNwc0tJZDJZeGlIWWxRRmlZMmpTWWc5aVFwVnNwUVpyWnYz?=
 =?utf-8?B?UUF2VHJaSit3TDlBcmlzSXN5TlArRUNMdWtTbXR5QzhSTnJLU2NKanIvMzYv?=
 =?utf-8?B?UTY4T0VNbE9TOUxkWU1ISkY4ZHM5NjNjQmhOdFEraXBWeUNzdWhjNEZuay9h?=
 =?utf-8?B?TFRpYlRCQy9iVlMySHAvTE1FVFByZmNRUjR6b3hiN1d3VjVEQXNVeUc4dlVj?=
 =?utf-8?B?ZmxXZVpLN0h6NkliR3U1M3VVb2xMVFAxZlJwOUVKY3ovbFNodXBIaWdmakFL?=
 =?utf-8?B?SFY0M2w3YkMrTThqcXdqSGNhNHRVVytnSmxySVY2VnRPM3ljNzhQN0tzM3Fw?=
 =?utf-8?B?UFdLVkc5UVp6YWtVUXRsbXE0TWRnVjRYaGxUYmYrcGU3UG5YVnZyL0FjZzFM?=
 =?utf-8?B?MWFFVjZFQm42cXZTanBhMzI1UXhtYXYvcHIwWUZXVDB5ck8wWFErN0lMY0Mz?=
 =?utf-8?B?UTVHelYxZDRENnNDMWF4ZXk1OXZmVFFiR25WT2praDJHWHkzbVpaTkxhTitw?=
 =?utf-8?B?dUwzd2YwUm5GMUFJRERzMXBNaXc2U214SThEOEg1b0hXKzg5enBDYVBPZXl2?=
 =?utf-8?B?MUdxYjRFUnJ1dEI0ampwaEpnNzN5TktWVU4zWnJIZWkzMnlJTU9hb2NBRDY2?=
 =?utf-8?B?R3RHMmJEeW9VdFMyL1A0MUFJaEQ4aVhiUU5xVzMxMFN2bmhVYVdwK1lXZzN0?=
 =?utf-8?B?UjF2Z3lXaENBQ29KMTltM0piUU9RT0p6YmxNbXNNUXVqQ3JRRmdlZ0pYN2Zw?=
 =?utf-8?B?R3F2aHdMekNVWE9yKzFYc0lMNGtqK2xJSGJoNG1nZnFUVnRVRGo2SEJjU1BR?=
 =?utf-8?B?Y295RkxBaCt0SHNQVWFmOE1Cb2tvdFpQMjFLbHJ3WDBrSFk5Z2RTc0YwVEJj?=
 =?utf-8?B?cStnSUZ3Nm9VQmFTT1dHdTA2bkk0ZTZKZXdXK252S3hmOVoxWEdSQUlncHRE?=
 =?utf-8?B?WGR6MmxhbGRvbWtlTExKdmFvaUZJc09KMmF1dEQvZEpra3h4a3ZyeXM3aEtn?=
 =?utf-8?B?cUdHZjFEVStuS3l6TXlLWmduWkxKbWtzZUd5WFFRaDZCRU5PUnBSbmxaTTAy?=
 =?utf-8?B?dTR3Zy95akJVRXFsakNuQVMrbE5SVzluM21xckNteDZJem5FL2QvU0k4RDBC?=
 =?utf-8?B?Y2FjK0hVd1V2bjhOb0w5N3dTL0hUY0VTUlRwRFhHVm9ScEloUmFWUU4rT29Y?=
 =?utf-8?B?bStWRkZLeGJDandtUVFTTTNMTUJYU2RmREsyNGtsZTh6VzhNRVRSWFZKYkpw?=
 =?utf-8?B?UWppSC8wWnhTSDVMTW4xL3RjRXZ1VDI3Zk42SDNFM3lkN0txZHZBQVlTc3M4?=
 =?utf-8?B?c1YyTUNTOHQvamMvWWxWczdBTzVZcnVnTlIyNnNKZ1R6OGZRRlFzVlNuc05p?=
 =?utf-8?B?SDdUYi81WGFUb1hJNHpnYmRNbnMzdGtidkVxM21oRC80Z2ZjRXU0ZWw5L20y?=
 =?utf-8?B?RSs0VGMyY0tSRVRUd2s0UlFocktmejhEY0xrYmpmUzhqNDJMNUt6UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d159f670-1640-4e92-9555-08df07a06fbc
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:42:56.1583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCdZJ91oQ8B7X4NyNKxg4WkUY7RYdnDAiNa99UdyPRTWKZrIsJ65iyByLmSlTk0zR8ys8PTZA+wxezcqlkoYmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6961
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

On Mon Aug 31, 2026 at 9:08 PM BST, Danilo Krummrich wrote:
> On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
>> +/// API handle for the auxiliary bus child drivers to interact with nov=
a-core.
>> +pub struct NovaCoreApi<'bound> {
>> +    #[expect(unused)]
>> +    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
>> +}
>> +
>> +impl NovaCoreApi<'_> {
>> +    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device regist=
ered
>> +    /// by nova-core.
>> +    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreA=
pi<'_>>> {
>> +        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
>> +    }
>> +}
>
> CovariantForLt does not hold anymore on latest drm-rust-next, as Cmdq has=
 a
> Mutex. So, this needs ForLt now and therefore the approach that I shared =
in [1]
> a while ago. I applied the changes in [2] to fix it up.
>
> I think the closure access through api.with(|api| ...) is fine in most ca=
ses,
> but there are a few options if we run into cases where we consider it a b=
it
> inconvinient.
>
> I think it should be possible to support projections into T: 'static and
> covariant fields. The reason I differentiate them is because T: 'static i=
s very
> convinient, but non-'static covariant types need an annoying turbofish.
>
> For T: 'static types it would turn out like this
>
> 	let spec =3D reg_data.api.project(|api| api.spec());
>
> such that everything that needs spec does not need to be in the closure a=
nymore.
>
> For non-'static covariant fields we could have
>
> 	let foo =3D reg_data.api.project_lt::<CovariantForLt!(Foo<'_>)>(|api| ap=
i.foo());
>
> but as mentioned it unfortunately needs the turbofish. Of course we could=
 invent
> a macro around it to get rid of the turbofish, but we'd still need to exp=
licitly
> mention the type Foo<'_>, so it doesn't buy us a lot.
>
> This is the implementation I came up with in nova-core
>
> 	/// Projects a `'static` sub-field out of the registration data.
> 	///
> 	/// `T` is fully inferred from the closure. For projected types with a l=
ifetime parameter,
> 	/// use [`Self::project_lt`].
> 	pub fn project<T: 'static>(
> 	    &self,
> 	    f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> &'b T,
> 	) -> &'a T {
> 	    self.adev
> 	        .registration_data_field::<ForLt!(NovaCoreApi<'_>), T>(f)
> 	        .expect("TypeId was validated in NovaCoreApiHandle::of()")
> 	}
> =09
> 	/// Projects a covariant sub-field out of the registration data.
> 	///
> 	/// Supports projected types with a lifetime parameter via a
> 	/// [`CovariantForLt`](trait@CovariantForLt) encoding. Unlike [`Self::pr=
oject`], `G` cannot
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
> 	/// Projects a covariant sub-field out of potentially invariant registra=
tion data.
> 	///
> 	/// `F` is the [`ForLt`](trait@ForLt) encoding of the registration data =
type. `G` is the
> 	/// [`CovariantForLt`](trait@CovariantForLt) encoding of the projected s=
ub-field type.
> 	///
> 	/// For projected types that are `'static`, prefer [`Self::registration_=
data_field`] which
> 	/// does not require a [`CovariantForLt`](trait@CovariantForLt) encoding=
 and fully infers `T`.
> 	///
> 	/// Returns [`EINVAL`] if `F` does not match the type used by the parent=
 driver when calling
> 	/// [`Registration::new()`]. Returns [`ENOENT`] if no registration data =
has been set.
> 	#[inline]
> 	pub fn registration_data_project<F, G>(
> 	    &self,
> 	    project: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> &'a G::Of<'a>,
> 	) -> Result<&G::Of<'_>>
> 	where
> 	    F: ForLt + 'static,
> 	    G: CovariantForLt + 'static,
> 	{
> 	    let ptr =3D self.registration_data_with::<F, *const ()>(|data| {
> 	        core::ptr::from_ref::<G::Of<'_>>(project(data)).cast::<()>()
> 	    })?;
> =09
> 	    // SAFETY:
> 	    // - The HRTB bound on `project` ensures the returned pointer is der=
ived from the
> 	    //   registration data (nothing else lives for universally quantifie=
d `'a`).
> 	    // - `G: CovariantForLt` guarantees that shortening the lifetime of =
`G::Of` is sound.
> 	    // - The registration data is heap-allocated and outlives the device=
's bound state.
> 	    Ok(unsafe { &*ptr.cast::<G::Of<'_>>() })
> 	}

I think this is a bit complex, you should be able to let Rust figure out th=
e
relation between two lifetimes.

I think if you change the signatue of `registration_data_with` slightly:

    pub fn registration_data_with<'this, F: ForLt + 'static, R>(
        &'this self,
        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
                                    ^ note this is changed from 'a to 'this
    ) -> Result<R>;

then there will be an implied bound available inside the callback where 'a
outlives 'this, and thus the function callback is able to perform coercion =
of
any T<'a> to T<'this> provided that `T` is covariant over lifetime `'a`.

[ The coercion won't work when doing abstract `F::Of` on the bus abstractio=
n
side, but for any user it is dealing with concrete types so the compiler se=
es
specific types and thus can check variance ]

Then your projection can just be

    aux.registration_data_project(|x| &x.field)

I haven't tried it out but I think it should work.

Best,
Gary

