Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403A606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtxLFc0r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5C910E363;
	Thu, 12 Nov 2026 10:20:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB5110E363
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:20:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A730D65781;
 Thu, 12 Nov 2026 10:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326E61F00A06;
 Thu, 12 Nov 2026 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794478830;
 bh=bedR6qqFwmX4cSFPk0JhRiqxq6siSDyGFCMslcmdg0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZtxLFc0rQowAeFZzbaWFiTuK9yLQOEVRM3eXnN2u65SXDD608Kgq7JX0aj+ppy+zj
 ZBWX2RGUnj7dCdaqdhCP6KV1oniJFyhVHbhIWZ9lURI8YDb8yM+jZCajex2joRgJEH
 UZFExDBSfdIERUtsCQO8WuyYiM3V65XushMQLzhgln+VPDrt1c7wK5a0Sb7pa16fID
 nF/HnmlwYCfZsabCu1jFzvtSAg77qQ1TcLouM99fw0fchAL6jbWpwxH5L1LYuZ5Dyr
 JwGYwoYvwVR4T4VDY668sMKCizeus2BAgW2fcCjzluk6q8Gwrjfq3q6iA/H06XWNAK
 NhJyjwIUHhxWg==
Message-ID: <sashiko-outbox-210930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261112101015.528127-2-phasta@kernel.org>
References: <20261112101015.528127-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:20:29 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rust: dma_fence: stale DriverFence rustdoc after warning removal
  in drop()
--

commit 1fa69b16f405cf6ecb2511fccf990063ada22d3a
Author: Philipp Stanner <phasta@kernel.org>

rust: DamFence: Remove warning about unsignaled drop

This commit removes the error message printed when a DriverFence is dropped
before being signaled.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 18a43e1bb442f..a46b6a1f114f1 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -934,7 +934,6 @@ fn drop(&mut self) {
>          // SAFETY: `guard` is valid until the `call_rcu()` below.
>          let signaled: bool =3D unsafe { bindings::dma_fence_test_signale=
d_flag(guard.as_raw()) };
>          if !signaled {
> -            pr_err!("DriverFence drops unsignaled. Danger of memory corr=
uption!\n");
>              // SAFETY: `guard` is valid until the `call_rcu()` below. Th=
e fence
>              // must not have been signaled yet, which we check directly =
above.
>              unsafe { bindings::dma_fence_set_error(guard.as_raw(), ECANC=
ELED.to_errno()) };

[Severity: Low]
Should the rustdoc comment on struct DriverFence also be updated now that
dropping an unsignaled fence is canonical teardown and no longer logs a
message?

rust/kernel/dma_buf/dma_fence.rs:
    /// As a last resort, a [`DriverFence`] will signal itself if it drops
    /// unsignaled and print a warning.
    pub struct DriverFence<'a, T: FenceContextOps> {

Also, the commit subject misspells the component as DamFence, and the
commit message refers to the removed pr_err!() call as pr_warn!().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112101015.5281=
27-2-phasta@kernel.org?part=3D1
