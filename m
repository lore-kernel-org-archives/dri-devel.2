Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE02C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385AA10F07D;
	Thu, 30 Jul 2026 20:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KjmbXDg/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A05710F071
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:27:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B0D060052;
 Thu, 30 Jul 2026 20:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108FD1F000E9;
 Thu, 30 Jul 2026 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785443244;
 bh=C++Bvrv53e+mdEUKG+FlpR12ip8iKXJgxgrtdGivgQo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=KjmbXDg/jc53CVnn7y6aWl6eUyWI/OLStyeHYVrMD5SgtnlR4cQU7yRuwD7GJG445
 XUEpowHjO7R5yEO48C7v+wl81lypy9EVIjzdSXQI89fnEVqo9X3un+9YlzId9PpHnv
 NHZ6G8DXgmVEL3KfEjt85R+3XXbMfqbQ7zre2ZOMuOUqcDnkDFywXsmRlQYC5HolbB
 ZMwxaDUlkc5oLLXyIcm8koyMIsWGCQfhOfINvB3HnfwTLSNt7rG/Wrc887vm1wX8zH
 /z/5aHgb9csWEbHPjsqb2JfzJWrIETY/nsLC8bo0UGfS2sCoD/eiB/7BzsfVF+HJAI
 Tk8Yi5XB2SWkw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 22:27:20 +0200
Message-Id: <DKC6T1DQX2L3.HTHPB2L167TC@kernel.org>
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
 <DKB0L93Q3OKI.26PNHHQOIF3EH@kernel.org>
 <amsx2tAppi1OV28C@nvdebian.thelocal>
In-Reply-To: <amsx2tAppi1OV28C@nvdebian.thelocal>
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

On Thu Jul 30, 2026 at 1:46 PM CEST, Alistair Popple wrote:
> On 2026-07-29 at 21:22 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Wed Jul 29, 2026 at 10:24 AM CEST, Alistair Popple wrote:
>> > On 2026-07-29 at 08:57 +1000, Danilo Krummrich <dakr@kernel.org> wrote=
...
>> >> On Tue Jul 28, 2026 at 11:49 PM CEST, John Hubbard wrote:
>> >> > On 7/28/26 2:29 PM, Danilo Krummrich wrote:
>> >> >> On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
>> >> >>> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> =
wrote...
>> >> >>>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
>> >> > ...
>> >> >>>> For instance, what's valid for userspace to extract from this? G=
iven chipid is a
>> >> >>>> composed value, is userspace e.g. allowed to make assumptions on=
 extracting the
>> >> >>>> architecture? Or is this something we want to expose separately =
and tell
>> >> >>>> userspace that the chipid is an opaque value identifying a speci=
fic chip only?
>> >> >>>
>> >> >>> I _think_ it makes sense for this to just be an opaque value, but=
 it's a good
>> >> >>> question that I should probably try and get some internal feedbac=
k on as well.
>> >> >>> Reading the arch would then be a separate parameter.
>> >> >>=20
>> >> >> I'd prefer exposing it as an opaque value and provide other inform=
ation
>> >> >> separately; the kernel already does the work anyway, so why duplic=
ate it in
>> >> >> userspace. It would also remain much cleaner if encoding details e=
ver change.
>> >
>> > Yep, I agree. Just want to make sure we get everyone in agreement.
>> >
>> >> >
>> >> > Just to orient myself, I'm assuming that by "opaque values", you me=
an using
>> >> > something that just counts up from, say, 1, instead of using real b=
oot42
>> >> > values below, right?
>> >
>> > No. We'd just document these as a unique magic value that identifies t=
he GPU
>> > chip rather than something that could be decoded into anything else.
>> >
>> >> > That seems like a good approach to me, too. Because I can't imagine=
 anything
>> >> > particularly good coming from providing unnecessary details to user=
 space
>> >> > here. :)
>> >>=20
>> >> I'd probably not be too worried about keeping it as is, but just docu=
ment it as
>> >> being an opaque value that shouldn't be messed with.
>> >
>> > Yes, agree with this. I don't think we want to mess with the value. It=
 just
>> > makes life hard when a new chip is added thats only difference from th=
e nova-drm
>> > perspective is a new chipid. You don't want to have to worry about bac=
kporting
>> > patches to distros and kernels just to add the identifier for say TU11=
7 even
>> > though it's functionally the same as TU116 from a Nova perspective.
>> >
>> > Obviously chipid would still get added to the header and eventually ba=
ckported,
>> > but having been there and done that it's not a good user story to requ=
ire it.
>> >
>> >> If we expose the encoded information separately I don't see a huge in=
centive for
>> >> userspace to redo the work and mess with it anyway.
>> >>=20
>> >> The advantage of keeping the values as they are is that we avoid havi=
ng to deal
>> >> with mapping values back and forth. I kind of like that nova-core use=
s the
>> >> values from the uAPI header to define the Chipset struct, passes it t=
o nova-drm
>> >> and nova-drm does use it to fill in the userspace exposed data.
>> >
>> > So do I.
>> >
>> >> Something else worth to consider in this context is whether we really=
 want to go
>> >> with the key-value pair GETPARAM approach, which can become a bit ted=
ious.
>> >>=20
>> >> I think for the basic GPU information we could have a struct drm_nova=
_gpu_info,
>> >> which contains all the relevant information obtained at probe time, s=
uch as
>> >> chipid, architecture, VRAM size, etc.
>> >>=20
>> >> If everything is available in a single struct there should be no reas=
on for
>> >> userspace to mess with the chipid value. However, I'd also not object=
 to make it
>> >> a "real" opaque value.
>> >>=20
>> >> In order to deal with additions to the struct we could take a two sta=
ge approach
>> >> to obtain the information from userspace; probe size first, then allo=
cate with
>> >> the returned size:
>> >>=20
>> >> We can have a DRM_NOVA_INFO ioctl, which takes a struct containing th=
e info
>> >> identifier (e.g. DRM_NOVA_GPU_INFO), a size and a pointer to the actu=
al info
>> >> structure.
>> >>=20
>> >> 	struct drm_nova_info {
>> >> 		__u32 id;
>> >> 		__u32 size;
>> >> 		__u64 info;
>> >> 	};
>> >>=20
>> >> Userspace can call the DRM_NOVA_INFO with the identifier (e.g.
>> >> DRM_NOVA_GPU_INFO), size and info pointer set to zero, and the kernel=
 fills in
>> >> the size of the info struct (e.g. struct drm_nova_gpu_info).
>> >>=20
>> >> Subsequently, userspace can allocate memory with the size reported by=
 the kernel
>> >> and call the same ioctl with the info pointer set to the allocated me=
mory.
>> >>=20
>> >> This way existing info structs remain extensible (as long as the layo=
ut isn't
>> >> changed of course) and new ones can be added at any time.
>> >
>> > I did consider an approach like this but having to do the two ioctl me=
mory
>> > allocation dance doesn't seem any less tedious.
>>=20
>> Well, it is two ioctls for a structured set of properties, whereas GETPA=
RAM is N
>> ioctls with no structure and slightly less type information.
>
> I guess I could be convinced of the struct approach, but there's no need =
to
> do the whole two ioctl dance. Fields can only ever get appended so just d=
o it
> based on size - an old user-space passing a too small struct doesn't get =
the new
> fields and a new user-space passing a too big struct can get an error cod=
e or we
> allow it and return the actual size written.

I thought about this too, and I agree we should support this.

The advantage is that the userspace side can remain much simpler (especiall=
y in
memory safe languages), since it can just use the size of its struct versio=
n.

IOW, the "buffer is smaller than struct" case goes into the kernel, where w=
e
could leverage a UserSliceWriter::write_truncated() helper [1].

When userspace passes a bigger buffer than needed by the kernel we should n=
ot
return an error code; a newer userspace can work perfectly fine with an old=
er
kernel.

We could still keep the probe semantics for size =3D=3D 0 though. It should=
n't cost
us anything, as it should be trivial. And it could be useful for diagnostic
purposes / tooling to dump the full kernel struct regardless of version (e.=
g.
for bug reports).

[1] UserSliceWriter::write_truncated()

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 5f6c4d7a1a51..c63b91942631 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -624,6 +624,20 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Resu=
lt {
         self.length -=3D len;
         Ok(())
     }
+
+    /// Writes as much of the provided value as fits in the remaining buff=
er.
+    ///
+    /// Copies `min(size_of::<T>(), self.len())` bytes to userspace. Retur=
ns the number of bytes
+    /// actually written. This is useful for versioned structs where an ol=
der userspace may provide
+    /// a smaller buffer than the current kernel struct.
+    ///
+    /// Fails with [`EFAULT`] if the write happens on a bad address. This =
call may modify the
+    /// associated userspace slice even if it returns an error.
+    pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<usi=
ze> {
+        let len =3D self.length.min(size_of::<T>());
+        self.write_slice(&value.as_bytes()[..len])?;
+        Ok(len)
+    }
 }

 /// Reads a nul-terminated string into `dst` and returns the length.

>> > Also my experience is these structs tend to just grow over time and be=
come
>> > unwieldy as new bits of info get added
>>=20
>> Note that there's no need to grow existing info groups endlessly; if som=
ething
>> truly becomes a separate concern we can just add a new group, e.g.
>> DRM_NOVA_MEMORY_INFO.
>
> Fair enough, although you likely end up with duplicated information as it=
ems
> from one group get copied into another which would be a bit ugly, having =
two
> ways to read the same thing. My main motivation here was really just that
> GETPARAM is very easy to extend as we discover we need other parameters g=
iven
> that we don't know what they all are yet.
>
> I was also thinking there wasn't much of a downside, but you make a good =
point
> on slightly less type information.
>
>> > and old ones deprecated forcing userspace to allocate memory for thing=
s it
>> > might no longer care about.
>>=20
>> This is equally true of GETPARAM; we accumulate keys that nobody uses an=
ymore.
>>=20
>> Allocating for one or two deprecated fields for a single query doesn't s=
eem like
>> a big deal; plus we can always create a new info group and leave the old=
 one
>> alone, just like a deprecated GETPARAM key.
>>=20
>> > Ultimately though I'm thinking (hoping?) there will not be a huge numb=
er of
>> > these - a lot of this info should probably get exposed via sysfs anywa=
y.
>>=20
>> I don't think sysfs is a good fit; it seems tedious for a UMD to do a bu=
nch of
>> sysfs file reads, each of them requiring at least three syscalls. Plus t=
he
>> effort to parse the value from the string sysfs provides, which is more =
error
>> prone than reading a typed struct.
>
> Yeah, that was an idea I'd heard floating around and I thought it may hav=
e come
> from upstream but I'm not entirely convinced of it for the reasons you st=
ate.
>
>  - Alistair

