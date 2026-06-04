Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5A6CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE4A11A2ED;
	Thu,  4 Jun 2026 20:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X6BoWS1o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B90F11A2ED
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:24:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B495660145
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340981F00893;
 Thu,  4 Jun 2026 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604661;
 bh=QfSrwsy4h63k8R1NgFs9hzn4oHFV07X8TtyVzxw2KTo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X6BoWS1o4mT0r190+r2uWTZ/95EYf6GAnWsVhrdixre1zk0nMpH9UV3/8ARQIdWOB
 U3O866K33wrzPwY/ADRrxFGzWCthkf/p03IlgMQ1f7tlbqGx7nrV/uGu+2/rFYyLgd
 yF+AvCvE871mX3P29HSlLOFbfN8GMhdwIN69HI/RMwAeoS5zAW0kcwws9EU81w5Tpn
 zrXr0QRUVfxIAmGzAfeQxCkOFbFTvPdS3JF56/JXNDcnP8GoR9OYPFmusACXAfUgN/
 d7uGnoHUMKZ1slaRS1QzctDwMlquB6v5SdSj0LE6P11Ys1FhjH6Q5A1PObt4MTgrAn
 xces+0+SStjEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/10] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260604-unique-ref-v17-6-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-6-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:24:20 +0000
Message-Id: <20260604202421.340981F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch misses updating `rust/kernel/pwm.rs` for the `AlwaysRefCo=
unted` trait split, resulting in a compilation failure.
- [Low] Lingering `AlwaysRefCounted` trait bounds in `aref.rs` and `workque=
ue.rs` artificially restrict `ARef<T>` functionality for types that only im=
plement `RefCounted`.
--

commit 821007fa381542ee45e7b6c5b8f66ecf2e17afcd
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename AlwaysRefCounted to RefCounted.

This commit splits the AlwaysRefCounted trait into RefCounted (which holds
inc_ref and dec_ref) and an empty marker trait AlwaysRefCounted. It updates
various implementers across the kernel to use the new traits.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 4ee5fac0e0b67..2d656f672b97c 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -40,9 +38,8 @@
>  /// at least until matching decrements are performed.
>  ///
>  /// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc=
_ref`] keep the object
> -/// alive.)
> -pub unsafe trait AlwaysRefCounted {
> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`]=
 keep the object alive.)
> +pub unsafe trait RefCounted {

[Severity: Low]
Does rust/kernel/pwm.rs need to be updated for this trait split? It appears
Chip<T> still implements AlwaysRefCounted and attempts to define inc_ref and
dec_ref within that block, which are no longer part of the trait and will c=
ause
a compilation failure:

unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
    #[inline]
    fn inc_ref(&self) {

[ ... ]

> @@ -70,7 +83,7 @@ pub unsafe trait AlwaysRefCounted {
>  ///
>  /// The pointer stored in `ptr` is non-null and valid for the lifetime o=
f the [`ARef`] instance. In
>  /// particular, the [`ARef`] instance owns an increment on the underlyin=
g object's reference count.
> -pub struct ARef<T: AlwaysRefCounted> {
> +pub struct ARef<T: RefCounted> {
>      ptr: NonNull<T>,
>      _p: PhantomData<T>,
>  }

[Severity: Low]
Since ARef now only requires T: RefCounted, should we also relax the trait
bounds for ARef in rust/kernel/sync/aref.rs for PartialEq and Eq? They still
explicitly bind T: AlwaysRefCounted, which prevents equality checks on ARef
wrappers of types that are only RefCounted:

impl<T: AlwaysRefCounted + PartialEq<U>, U: AlwaysRefCounted> PartialEq<ARe=
f<U>> for ARef<T> {

Similarly, should the trait bounds in rust/kernel/workqueue.rs for
WorkItemPointer, RawWorkItem, and RawDelayedWorkItem be relaxed? They curre=
ntly
enforce the old bound, which prevents workqueue scheduling via ARef for typ=
es
that are only RefCounted:

unsafe impl<T, ID> WorkItemPointer<ID> for ARef<T>
where
    T: AlwaysRefCounted,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D6
