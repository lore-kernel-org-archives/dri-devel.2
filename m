Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A7FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF6110E3C8;
	Fri, 26 Jun 2026 18:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z5ZmyL5t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9E610E3C8
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 18:50:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C67860A6C;
 Fri, 26 Jun 2026 18:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA331F000E9;
 Fri, 26 Jun 2026 18:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782499855;
 bh=IStO88XHZPtIT0shR+QnhDZxd8FpsK3IRCV0Kq9xZto=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z5ZmyL5tUFZGeffAzfbkzby+YcDt5rIeNfarNTvnzQ/G7nRpebPMKRd8cbvLLijbY
 K9LGwdP7R4ccs0OeBkLWRpvHL2Mq455OYqdmYYp3e4UVk/VHZcvMp5afx94UFrIlDy
 HiZ1Syl9lALaFuUS/hHOXl7j2LjBi+vo9IugQfa8aUEwdDfJx2lOfGGdC1XyPOWp9h
 QIVjD/Fcmv9aPY4Qz+rLQSyGbvRisjGzZ30FGwZNaP6PdzWSLpj6iefuG5PzvI3ffP
 QXdsGOd65rX5r/hm1YN9VqCyQ8gIf2UUw8DfARod4xY86QeF6LITS5dc33ohGaF99U
 xIoVXVjEvJZGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] rust: devres: add DevresLt for ForLt-aware
 device resource access
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260626183630.2585057-6-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:50:54 +0000
Message-Id: <20260626185055.7CA331F000E9@smtp.kernel.org>
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
- [High] `DevresGuard` implements `Deref` tying the returned reference's in=
ner lifetime to the `DevresLt` borrow rather than the guard itself, allowin=
g references to escape the RCU read-side lock and causing a use-after-free.
--

commit 62b48d10ff277ed9a20edb541dfb07cf0af74ca2
Author: Danilo Krummrich <dakr@kernel.org>

rust: devres: add DevresLt for ForLt-aware device resource access

This commit introduces DevresLt, a wrapper around Devres that safely shorte=
ns
the synthetic 'static lifetime of stored resources to the caller's borrow
lifetime. It provides both direct-reference accessors for CovariantForLt ty=
pes
and closure-based accessors for plain ForLt types.

> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 11ce500e9b76f..b7c075a39ba47 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs

[ ... ]

> @@ -365,6 +367,110 @@ fn drop(&mut self) {
>      }
>  }
> =20
> +/// Guard returned by [`DevresLt::try_access`].
> +///
> +/// Dereferences to `F::Of<'a>`, shortening the lifetime of the stored d=
ata to the guard's borrow
> +/// lifetime.
> +pub struct DevresGuard<'a, F: CovariantForLt>(RevocableGuard<'a, F::Of<'=
static>>);
> +
> +impl<'a, F: CovariantForLt> core::ops::Deref for DevresGuard<'a, F> {
> +    type Target =3D F::Of<'a>;
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        F::cast_ref(&*self.0)
> +    }
> +}

[Severity: High]
Does this allow references to escape the RCU read-side lock and cause a
use-after-free?

Because Target is F::Of<'a>, the inner lifetime of the returned type is tied
to the DevresLt borrow ('a) rather than the guard itself. If a caller extra=
cts
a reference from the returned type, it will have the lifetime 'a.

The caller can then drop the guard, releasing the RCU read lock, and the
device could unbind. This would free the devres allocation while the extrac=
ted
reference remains alive in safe Rust for the duration of 'a.

[ ... ]

> +impl<F: CovariantForLt> DevresLt<F>
> +where
> +    for<'a> F::Of<'a>: Send,
> +{

[ ... ]

> +    /// [`DevresLt`] accessor for [`Revocable::try_access`].
> +    #[inline]
> +    pub fn try_access(&self) -> Option<DevresGuard<'_, F>> {
> +        self.0.data().try_access().map(DevresGuard)
> +    }
> +}

[Severity: High]
Does this accessor create a guard that enables the lifetime escape mentioned
above?

By parameterizing DevresGuard with the DevresLt borrow lifetime ('_), this
sets up the condition where inner references can outlive the guard itself.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626183630.2585=
057-1-dakr@kernel.org?part=3D5
