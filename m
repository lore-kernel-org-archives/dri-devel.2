Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739A9C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F7B10E1C6;
	Tue, 25 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A/ii/jGS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AE210E1DC;
 Tue, 25 Aug 2026 12:26:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 034596011F;
 Tue, 25 Aug 2026 12:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CD21F000E9;
 Tue, 25 Aug 2026 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660802;
 bh=S8jrV7vrsiewaQAeJhs+EDT+bYTiak1pT9WQgKiA3hg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A/ii/jGSWP3kkBD2qOzprrVF4IUlmUNP4saguXs6ovbIG0p37d0oTgT8qYbsE/nVg
 C6YRMEn7iWv2CF4H7wxyBtTNkUJ6PWVz0e4uTh2VG4rGyDYdWtQ02Zub2R/u3jXLMf
 4Wai9IxYq2RMbqDHeLJB2gnUsgF3TCEEgFzt6dwtd9NFfT/H9kfWqJxjuJsLizGd2z
 auU4ZLOJHgEvXYjMQNiylgWJpKA/J4VXxJDKgXW8Qo2+7NF+EdtMovi0V5I0fF0p5K
 6ONVqOKk78M7m91FcGyv4wov8hEWBBpECDe0+vRxiNGu8SYeB20t9tM10gAGm6Nsyw
 mjOkBxNOZ8UBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] rust: hrtimer: document deadlock when starting a
 timer in its handler
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260825-expires-v2-v1-5-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-5-90411c6217c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:26:42 +0000
Message-Id: <20260825122642.73CD21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dropping `HrTimerHandle` from within its own timer callback deadlo=
cks the CPU.
--

--- Patch [5]: [PATCH 5/6] rust: hrtimer: document deadlock when starting a=
 timer in its handler ---
commit 728bf4e6c510d8fc30ab14edb4327239f3f07e2b
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: hrtimer: document deadlock when starting a timer in its handler

This commit updates the hrtimer documentation to note that calling the
start operation from within the timer handler will lead to a deadlock.
This happens because the handle returned by start cancels the timer
when dropped, waiting for the current handler to finish.

> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -78,6 +78,8 @@
>  //! handler returns, and a restart requested by the return value of the =
handler is discarded in
>  //! favor of the `restart` operation.
>  //!
> +//! =E2=9A=A0=EF=B8=8F Issuing the `start` operation from within the tim=
er handler will lead to deadlock.

[Severity: High]
This is a pre-existing issue, but does relying on documentation here
leave safe Rust code vulnerable to triggering a kernel deadlock?

The handle types unconditionally invoke a synchronous cancel when dropped.
For example, looking at ArcHrTimerHandle:

rust/kernel/time/hrtimer/arc.rs:Drop for ArcHrTimerHandle {
    fn drop(&mut self) {
        self.cancel();
    }
}

This means if safe code invokes start() from within the timer callback
and allows the returned HrTimerHandle to drop, or replaces an existing
handle in a shared structure (implicitly dropping the old one), it will
block on hrtimer_cancel().

Since calling a synchronous cancel from the timer's own callback results
in a CPU deadlock, can safe Rust currently trigger a hard lockup just by
following standard drop patterns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-expires-v2=
-v1-0-90411c6217c7@kernel.org?part=3D5
