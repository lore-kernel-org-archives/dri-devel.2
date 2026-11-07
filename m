Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F5606A32F
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMw1HOP4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD65510E6FF;
	Sat,  7 Nov 2026 23:18:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D611610E11E
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 23:18:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8132840094;
 Sat,  7 Nov 2026 23:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8C11F0089F;
 Sat,  7 Nov 2026 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794093496;
 bh=B+YhXZl+/eWRBv4RgozyREqWo5C8cExmqjC652z4jDc=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=lMw1HOP4tnW3JvJhlRS8xA+R2LNpa3onQ1CAogENBEfkTxzwNmmROKB0asKESEdHa
 LPIFeYVb3lS1Dz/iFj/qicZ3WDrRan1q0WmYQMKdOmySZWwKAyYqj5h3Ue0MzFgZ/+
 9TEKM6luuvc7jGFr4RZoSECPhQJjVn1VcGYbIDdVIK36Rj6y6VKjavPgCBtGMT87ml
 +f896MxhHF4w08uLf3NpmqjGiitdaHUvjreWODi0J4zt1FQxJkBFnQIyeV2izKbLu7
 nGH2dRZ0aaKmytkZrSSMcmRvqg9Fzc9PBJjsNk4a8qe7s06vm5RyJTirG0+5Tf+6aF
 UE3hcIKF20jDw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 00:18:12 +0100
Message-Id: <DMPD2CDIAW74.2Q60A9JGEPTR2@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 1/3] gpu: nova-core: move the debugfs root into the
 module data
Cc: "Vladislav Zaharov" <vladazaharova2018@gmail.com>,
 <jhubbard@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <20261014154554.231015-2-vladazaharova2018@gmail.com>
 <DMOS00OZYWU5.2SUZRN37DEH87@nvidia.com>
 <DMP087IP6EDP.2QB7783SVNV2T@kernel.org>
 <DMP0LNXEI7YF.1G8UBZKO2W3U9@nvidia.com>
In-Reply-To: <DMP0LNXEI7YF.1G8UBZKO2W3U9@nvidia.com>
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

On Sat Nov 7, 2026 at 2:32 PM CET, Alexandre Courbot wrote:
> On Sat Nov 7, 2026 at 10:14 PM JST, Danilo Krummrich wrote:
>> On Sat Nov 7, 2026 at 7:47 AM CET, Alexandre Courbot wrote:
>>> On Thu Oct 15, 2026 at 12:45 AM JST, Vladislav Zaharov wrote:
>>> Another thing: since this is declaring now a proper interface, can you
>>> move `DebugfsData`, `debugfs_data` and `DEBUGFS_DATA` into a sub-module=
,
>>> say `debugfs.rs`?
>>
>> I think that makes sense.
>>
>>>>  impl InPlaceModule for NovaCoreModule {
>>>>      fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self=
, Error> {
>>>> -        let dir =3D debugfs::Dir::new(c"nova-core");
>>>> -
>>>> -        // SAFETY: We are the only driver code running during init, s=
o there
>>>> -        // cannot be any concurrent access to `DEBUGFS_ROOT`.
>>>> -        unsafe { DEBUGFS_ROOT =3D Some(dir) };
>>>> -
>>>>          try_pin_init!(Self {
>>>> +            _debugfs <- DebugfsData::new(),
>>>> +            _: {
>>>> +                // SAFETY: Nothing reads `DEBUGFS_DATA` before a devi=
ce is bound, which cannot
>>>> +                // happen until the driver is registered below. What =
it points at is dropped only
>>>> +                // once the driver is unregistered, so it is valid fo=
r as long as any device is
>>>> +                // bound, and nothing reads it outside of that.
>>>> +                unsafe { DEBUGFS_DATA =3D &*_debugfs };
>>>> +            },
>>>
>>> Let's move this initialization into `DebugfsData::new`, using
>>> `pin_chain`:
>>>
>>>     /// Returns an initializer that creates the shared debugfs data.
>>>     ///
>>>     /// # Safety
>>>     ///
>>>     /// The returned initializer must be run exactly once before the dr=
iver is registered. The
>>>     /// initialized [`DebugfsData`] must outlive the driver registratio=
n.
>>>     pub(super) unsafe fn new() -> impl PinInit<Self> {
>>>         pin_init!(Self {
>>>             root: debugfs::Dir::new(c"nova-core"),
>>>         })
>>>         .pin_chain(|debugfs| {
>>>             // SAFETY: Per the method's safety block, the driver is not=
 registered yet, meaning that
>>>             // no device can be probed and thus nothing can access `DEB=
UGFS_DATA` concurrently.
>>>             //
>>>             // INVARIANT: Per the method's safety block, `DEBUGFS_DATA`=
 is written before the driver
>>>             // is registered and points to a valid instance of `Debugfs=
Data`, which is pinned
>>>             // and dropped after the driver is unregistered.
>>>             unsafe { DEBUGFS_DATA =3D &*debugfs };
>>>             Ok(())
>>>         })
>>>     }
>>>
>>> That way, the burden of enforcing the invariants for `DEBUGFS_DATA`
>>> relies exclusively on `new` (and we made it unsafe to force the caller
>>> to do that).
>>
>> Actually, I would leave that part as is.
>>
>> Eventually we'll have registration data for driver registrations to shar=
e module
>> data. Once we have that, we'd need to change DebugfsData::new() again an=
d move
>> that part bnack into NovaCoreModule::init().
>>
>> Besides that, DebugfsData has nothing to do with the current limitation =
of
>> publishing module data to driver registrations; the module code seems li=
ke the
>> correct place to deal with this.
>
> Makes sense, let's reduce the churn indeed. In this case I guess
> `DEBUGFS_DATA` will need to be made `pub(super)` so this module can
> initialize it.

I think DEBUGFS_DATA still belongs into nova_core.rs (including the
debugfs_data() accessor) since it is a workaround to make module data
accessible.

I'd also like the accessor to be an associated function:
NovaCoreModule::debugfs_data().

Thanks,
Danilo
