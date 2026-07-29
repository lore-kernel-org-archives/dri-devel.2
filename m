Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC30C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDDBB10EA93;
	Wed, 29 Jul 2026 11:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EZeIv7HK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFDC10EA93
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:22:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFD2A43FE3;
 Wed, 29 Jul 2026 11:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C921F00A3A;
 Wed, 29 Jul 2026 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785324147;
 bh=Iyvl6ldDVcJQRwOTFkwENJGNteJzfpY7qz7JnLdEsp8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=EZeIv7HKaQj5ikLdnyIfzVZQW6VzigiIgWHvW4Y0heigR5R7jvwRXgAexjhQ+U6dQ
 +6ulFhOAecMIUg7nbEySax7QhmUT6a8gTnf0+DR3fhKhjNJqfrgHN0zvs59AcZ7S5T
 J839jZLVkiUgEwKRIpRjrPmi+XLMeYYYaBqYV5os6gWZrP0A7m0gsbiSDMxu9iPteT
 QtEqAqKdzWnBJz5T1rBAg2l/359IW3Xlmn3UFR+esgerZm2ucSyr05L2ODoEEdce1Y
 xoDbfP5GIgLN4z6kBOYVGDnvRHVlAOzNeszd2PrVdDekJCmcUTZgaWE7FogKdN42Zv
 RxPMJJIvj9aaw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 13:22:23 +0200
Message-Id: <DKB0L93Q3OKI.26PNHHQOIF3EH@kernel.org>
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Cc: "John Hubbard" <jhubbard@nvidia.com>, <nova-gpu@lists.linux.dev>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org>
 <amhdA35CcMD_uY2f@nvdebian.thelocal>
 <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
 <57e2b956-89fd-43e8-8cb3-a15aee272660@nvidia.com>
 <DKAKR85QX9UM.1VYAAL82QBWJ5@kernel.org>
 <ammyfspYkXOwMsdU@nvdebian.thelocal>
In-Reply-To: <ammyfspYkXOwMsdU@nvdebian.thelocal>
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

On Wed Jul 29, 2026 at 10:24 AM CEST, Alistair Popple wrote:
> On 2026-07-29 at 08:57 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Tue Jul 28, 2026 at 11:49 PM CEST, John Hubbard wrote:
>> > On 7/28/26 2:29 PM, Danilo Krummrich wrote:
>> >> On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
>> >>> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wro=
te...
>> >>>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
>> > ...
>> >>>> For instance, what's valid for userspace to extract from this? Give=
n chipid is a
>> >>>> composed value, is userspace e.g. allowed to make assumptions on ex=
tracting the
>> >>>> architecture? Or is this something we want to expose separately and=
 tell
>> >>>> userspace that the chipid is an opaque value identifying a specific=
 chip only?
>> >>>
>> >>> I _think_ it makes sense for this to just be an opaque value, but it=
's a good
>> >>> question that I should probably try and get some internal feedback o=
n as well.
>> >>> Reading the arch would then be a separate parameter.
>> >>=20
>> >> I'd prefer exposing it as an opaque value and provide other informati=
on
>> >> separately; the kernel already does the work anyway, so why duplicate=
 it in
>> >> userspace. It would also remain much cleaner if encoding details ever=
 change.
>
> Yep, I agree. Just want to make sure we get everyone in agreement.
>
>> >
>> > Just to orient myself, I'm assuming that by "opaque values", you mean =
using
>> > something that just counts up from, say, 1, instead of using real boot=
42
>> > values below, right?
>
> No. We'd just document these as a unique magic value that identifies the =
GPU
> chip rather than something that could be decoded into anything else.
>
>> > That seems like a good approach to me, too. Because I can't imagine an=
ything
>> > particularly good coming from providing unnecessary details to user sp=
ace
>> > here. :)
>>=20
>> I'd probably not be too worried about keeping it as is, but just documen=
t it as
>> being an opaque value that shouldn't be messed with.
>
> Yes, agree with this. I don't think we want to mess with the value. It ju=
st
> makes life hard when a new chip is added thats only difference from the n=
ova-drm
> perspective is a new chipid. You don't want to have to worry about backpo=
rting
> patches to distros and kernels just to add the identifier for say TU117 e=
ven
> though it's functionally the same as TU116 from a Nova perspective.
>
> Obviously chipid would still get added to the header and eventually backp=
orted,
> but having been there and done that it's not a good user story to require=
 it.
>
>> If we expose the encoded information separately I don't see a huge incen=
tive for
>> userspace to redo the work and mess with it anyway.
>>=20
>> The advantage of keeping the values as they are is that we avoid having =
to deal
>> with mapping values back and forth. I kind of like that nova-core uses t=
he
>> values from the uAPI header to define the Chipset struct, passes it to n=
ova-drm
>> and nova-drm does use it to fill in the userspace exposed data.
>
> So do I.
>
>> Something else worth to consider in this context is whether we really wa=
nt to go
>> with the key-value pair GETPARAM approach, which can become a bit tediou=
s.
>>=20
>> I think for the basic GPU information we could have a struct drm_nova_gp=
u_info,
>> which contains all the relevant information obtained at probe time, such=
 as
>> chipid, architecture, VRAM size, etc.
>>=20
>> If everything is available in a single struct there should be no reason =
for
>> userspace to mess with the chipid value. However, I'd also not object to=
 make it
>> a "real" opaque value.
>>=20
>> In order to deal with additions to the struct we could take a two stage =
approach
>> to obtain the information from userspace; probe size first, then allocat=
e with
>> the returned size:
>>=20
>> We can have a DRM_NOVA_INFO ioctl, which takes a struct containing the i=
nfo
>> identifier (e.g. DRM_NOVA_GPU_INFO), a size and a pointer to the actual =
info
>> structure.
>>=20
>> 	struct drm_nova_info {
>> 		__u32 id;
>> 		__u32 size;
>> 		__u64 info;
>> 	};
>>=20
>> Userspace can call the DRM_NOVA_INFO with the identifier (e.g.
>> DRM_NOVA_GPU_INFO), size and info pointer set to zero, and the kernel fi=
lls in
>> the size of the info struct (e.g. struct drm_nova_gpu_info).
>>=20
>> Subsequently, userspace can allocate memory with the size reported by th=
e kernel
>> and call the same ioctl with the info pointer set to the allocated memor=
y.
>>=20
>> This way existing info structs remain extensible (as long as the layout =
isn't
>> changed of course) and new ones can be added at any time.
>
> I did consider an approach like this but having to do the two ioctl memor=
y
> allocation dance doesn't seem any less tedious.

Well, it is two ioctls for a structured set of properties, whereas GETPARAM=
 is N
ioctls with no structure and slightly less type information.

> Also my experience is these structs tend to just grow over time and becom=
e
> unwieldy as new bits of info get added

Note that there's no need to grow existing info groups endlessly; if someth=
ing
truly becomes a separate concern we can just add a new group, e.g.
DRM_NOVA_MEMORY_INFO.

> and old ones deprecated forcing userspace to allocate memory for things i=
t
> might no longer care about.

This is equally true of GETPARAM; we accumulate keys that nobody uses anymo=
re.

Allocating for one or two deprecated fields for a single query doesn't seem=
 like
a big deal; plus we can always create a new info group and leave the old on=
e
alone, just like a deprecated GETPARAM key.

> Ultimately though I'm thinking (hoping?) there will not be a huge number =
of
> these - a lot of this info should probably get exposed via sysfs anyway.

I don't think sysfs is a good fit; it seems tedious for a UMD to do a bunch=
 of
sysfs file reads, each of them requiring at least three syscalls. Plus the
effort to parse the value from the string sysfs provides, which is more err=
or
prone than reading a typed struct.
