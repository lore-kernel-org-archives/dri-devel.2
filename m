Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D543108E1EB
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9302410E981;
	Thu, 19 Mar 2026 11:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WZwO5313";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7948E10E974
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773918514;
 bh=Z+pvxwULPAJ0NoC3Ncj8v/9V/z4PlztUUfLRSdmoAQk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WZwO5313OWvF9cfZ+fYEB0eKLkWCD7pmODugEUoCGMcH7J4G9i3i3oWKVeKVmGyxh
 XLHgVpkdC9seCiAMmeSsmwV9RhMVJM/CVakrjofoOtmRdAXb0Qb2qK9stmoW51wJvl
 JVBsrJ9JoUnjE1QfHJMj0dDtH6G4Qi4wEanoY8VBsg+D+yBBXd7HGNflVuK9d0QeYd
 uiibx5tlV3tDtIE7D0LewGgqxsT5G1VjiZZXLUAAMAvUafnxnHUacXqB7H7MCO1DeT
 q2rPLw4D7PDY+ce5mWZ297vyTEyteWk/RDoM9NvL/1DOPYVeYfnsC6i4S7P/YVwOcT
 sVaMErzXLd3QQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BECF517E01B1;
 Thu, 19 Mar 2026 12:08:33 +0100 (CET)
Date: Thu, 19 Mar 2026 12:08:28 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Deborah
 Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
Message-ID: <20260319120828.52736966@fedora>
In-Reply-To: <20260313091646.16938-5-work@onurozkan.dev>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 13 Mar 2026 12:16:44 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> +impl Controller {
> +    /// Creates a [`Controller`] instance.
> +    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) -> R=
esult<Arc<Self>> {
> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", 0)?;
> +
> +        Arc::pin_init(
> +            try_pin_init!(Self {
> +                pdev,
> +                iomem,
> +                pending: Atomic::new(false),
> +                wq,
> +                work <- kernel::new_work!("tyr::reset"),
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +
> +    /// Processes one scheduled reset request.
> +    ///
> +    /// Panthor reference:
> +    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset=
_work()
> +    fn reset_work(self: &Arc<Self>) {
> +        dev_info!(self.pdev.as_ref(), "GPU reset work is started.\n");
> +
> +        // SAFETY: `Controller` is part of driver-private data and only =
exists
> +        // while the platform device is bound.
> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };
> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {
> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n", e);
> +        } else {
> +            dev_info!(self.pdev.as_ref(), "GPU reset work is done.\n");
> +        }

Unfortunately, the reset operation is not as simple as instructing the
GPU to reset, it's a complex synchronization process where you need to
try to gracefully put various components on hold before you reset, and
then resume those after the reset is effective. Of course, with what we
currently have in-tree, there's not much to suspend/resume, but I think
I'd prefer to design the thing so we can progressively add more
components without changing the reset logic too much.

I would probably start with a Resettable trait that has the
{pre,post}_reset() methods that exist in Panthor.

The other thing we need is a way for those components to know when a
reset is about to happen so they can postpone some actions they were
planning in order to not further delay the reset, or end up with
actions that fail because the HW is already unusable. Not too sure how
we want to handle that though. Panthor is currently sprinkled with
panthor_device_reset_is_pending() calls in key places, but that's still
very manual, maybe we can automate that a bit more in Tyr, dunno.

> +
> +        self.pending.store(false, Release);
> +    }
> +}
