Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21799F44852
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 13:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5544210E1F2;
	Fri, 10 Apr 2026 13:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RDdr44xX";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C0910E1F2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775826074; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=STCb+KR/JF03Ct5ZVbrqPeZsHexMoMw4+Z0Th3WIKWqjQBppLKeld8pZB3BC3bM1FmAXoCIBdqqNh/m4FPrzz+Imi5VLwaVmPwXCF6YVUch/HT3gLV6yt8VOk9neklsbO3VOLBNMNwu6hAc9xF93t/YHToXmd+OqmuBY815r2bQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775826074;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kl3Z780aRsua4P1zejE90IPe2FUZG1v23TcTvGJBWDQ=; 
 b=aIEqQmuzODWJ1sng7/dXfcYP19qSOeQRYGBtzuVZ8Gcrs68w6T99Ae5S50R3m1fCnUEo5/6NbQNIHj3CGPG563jaLF+wW/y4hWwI4vNilmasK74SjYvJ6C6tAIhZrIUIYbM2vFqeWArzwq8bMtOlcxx2od5Nbp+A3mTrrS3FS9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775826074; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=kl3Z780aRsua4P1zejE90IPe2FUZG1v23TcTvGJBWDQ=;
 b=RDdr44xXLfsOsnLRdDPubWZvxtZ3NhSU21oYBbAijmj+8dpjSSB8pvA4NijtgUdE
 wbMpY9NS2fOyOrzGBV4h6I3MGi0gxkR/ekEYPU1IkVv5tEs0NfH+KeCAFd9+qXl+ida
 OuEMWZJ9AV+ek8jhBVRSLi9q7w7WUlvyWOv9ibqE=
Received: by mx.zohomail.com with SMTPS id 1775826073160748.9776467229868;
 Fri, 10 Apr 2026 06:01:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aditNn-iQc3QXRfK@google.com>
Date: Fri, 10 Apr 2026 10:00:56 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, dakr@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AB77A5D-54F7-4AC5-A2C0-33498D532E32@collabora.com>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev> <20260319120828.52736966@fedora>
 <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
 <20260409114133.43134-1-work@onurozkan.dev>
 <395ED15F-3BC1-48C0-BE36-AF3A951E464D@collabora.com>
 <aditNn-iQc3QXRfK@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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


>>=20
>> I think that there are two things we're trying to implement =
correctly:
>>=20
>> 1) Deny access to a subset of the state while a reset is in progress
>> 2) Wait for anyone accessing 1) to finish before starting a reset
>>=20
>> IIUC, using Atomic<T> can solve 1 by bailing if the "reset in =
progress"
>> flag/variant is set, but I don't think it implements 2? One would =
have to
>> implement more logic to block until the state is not being actively =
used.
>>=20
>> Now, there are probably easier ways to solve this, but I propose that =
we do the
>> extra legwork to make this explicit and enforceable by the type =
system.
>>=20
>> How about introducing a r/w semaphore abstraction? It seems to =
correctly encode
>> the logic we want:
>>=20
>> a) multiple users can access the state if no reset is pending ("read" =
side)
>> b) the reset code can block until the state is no longer being =
accessed (the "write" side)
>>=20
>> In Tyr, this would roughly map to something like:
>>=20
>> struct TyrData {
>>  reset_gate: RwSem<ActiveHwState>
>>  // other, always accessible members
>> }
>>=20
>> impl TyrData {
>>  fn try_access(&self) -> Option<ReadGuard<'_, ActiveHwState>> {...}
>> }
>>=20
>> Where ActiveHwState contains the fw/mmu/sched blocks (these are not =
upstream
>> yet, Deborah has a series that will introduce the fw block that =
should land
>> soon) and perhaps more.
>>=20
>> Now, the reset logic would be roughly:
>>=20
>> fn reset_work(tdev: Arc<TyrDevice>) {
>>  // Block until nobody else is accessing the hw, prevent others from
>>  // initiating new accesses too..
>>  let _guard =3D tdev.reset_gate.write();
>>=20
>>  // pre_reset() all Resettable implementors
>>=20
>>  ... reset
>>=20
>>  // post_Reset all Resettable implementors
>> }
>>=20
>> Now, for every block that might touch a resource that would be =
unavailable
>> during a reset, we enforce a try_access() via the type system, and =
ensure that
>> the reset cannot start while the guard is alive. In particular, =
ioctls would
>> look like:
>>=20
>> fn ioctl_foo(...) {
>>  let hw =3D tdev.reset_gate.try_access()?;
>>  // resets are blocked while the guard is alive, no other way to =
access that state otherwise
>> }
>>=20
>> The code will not compile otherwise, so long as we keep the state in =
ActiveHwState, i.e.:=20
>> protected by the r/w sem.
>>=20
>> This looks like an improvement over Panthor, since Panthor relies on =
manually
>> canceling work that access hw state via cancel_work_sync(), and =
gating new work
>> submissions on the "reset_in_progress" flag, i.e.:
>>=20
>> /**
>> * sched_queue_work() - Queue a scheduler work.
>> * @sched: Scheduler object.
>> * @wname: Work name.
>> *
>> * Conditionally queues a scheduler work if no reset is =
pending/in-progress.
>> */
>> #define sched_queue_work(sched, wname) \
>> do { \
>> if (!atomic_read(&(sched)->reset.in_progress) && \
>>    !panthor_device_reset_is_pending((sched)->ptdev)) \
>> queue_work((sched)->wq, &(sched)->wname ## _work); \
>> } while (0)
>>=20
>>=20
>> Thoughts?
>=20
> I don't think a semaphore is the right answer. I think SRCU plus a
> counter makes more sense. (With a sentinal value reserved for =
"currently
> resetting".)

Can you expand a bit on why you think r/w semaphores are not the answer? =
They
seem to correctly encode the logic we want.

>=20
> When you begin using the hardware, you start an srcu critical region =
and
> read the counter. If the counter has the sentinel value, you know the
> hardware is resetting and you fail. Otherwise you record the couter =
and
> proceed.
>=20
> If at any point you release the srcu critical region and want to
> re-acquire it to continue the same ongoing work, then you must ensure
> that the counter still has the same value. This ensures that if the =
GPU
> is reset, then even if the reset has finished by the time you come =
back,
> you still fail because the counter has changed.

We don't want to "come back=E2=80=9D, anything that is in-flight must =
complete, i.e.:
the reset logic must wait for in-flight jobs, because the work has =
already been
dispatched to the hardware. We do want to forbid more work from being =
queued
while a reset is pending, though.


>=20
>=20
> Another option could be to rely on the existing Device unbind logic.
> Entirely remove the class device and run the full unbind procedure,
> cleaning up all devm work etc. Then once that has finished, probe the
> device again and start from scratch. After all, GPU reset does not =
have
> to be a cheap operation.
>=20
> Alice

What about all resources associated with this class device? Userspace =
would be
holding handles to resources that are effectively gone.


In any case, I'm not trying to push this r/w semaphore thing as "the =
right
thing", and if the "srcu + counter" idea turns out to be better, great! =
:)

The problem is what Boris said recently, though: there's a delay between =
the
point of "we need a reset" and the reset worker being scheduled.

In the design I proposed, there would be a window of time in which:

1) the hardware is in an invalid state, and must be reset
2) the reset worker hasn't run yet, so the "write" lock has not been =
taken
3) due to 2, the submit() logic sees the hardware as available, and =
queues more work
4) the work from 3 now gets to execute even though the hardware is =
crashed

=E2=80=94 Daniel=
