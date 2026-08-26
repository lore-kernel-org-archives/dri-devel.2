Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57C1C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F0A10E31B;
	Wed, 26 Aug 2026 16:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fJ8kl4Nw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7D610E31B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:58:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B44D560AAA;
 Wed, 26 Aug 2026 16:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6201F000E9;
 Wed, 26 Aug 2026 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763490;
 bh=290Fi4zUPnRCx4MvZZDTo65v5fgt39G4UxPL0SHEyIs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fJ8kl4NwI4c1o0CHziuOUMAf0Nh/FP47ugic9C0XyTX8UmimsmAzpvpPsH3HfhEik
 YK5AjC22TahPscCQtpSZ4X9TgbrkzNYnDb91Eku1ztCUV8nQIx0e/kNLBZO+Y4feQO
 JtxDYYXUP8SyXuBM7dYW+2gvdtFp2r+0dXI9RMv8Y3CtBC3NMZntY0DwH9fdR3i7wZ
 2fIWBv4vYut6F0BlWvDptXx1zTYCWbKvB5f1wXbKABDNAWDNNu3Y3P64Rsq1pC6PbC
 QwZnxSngFicFvWUSVySgyfKG5K5NJeO/DjPwdJt8w8npNIbJzAUqXG1SLx+Mdvwqmx
 K0hQorfyl3bUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/13] drm/vino: add the USB transport
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826163913.7052-3-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-3-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:58:09 +0000
Message-Id: <20260826165810.3E6201F000E9@smtp.kernel.org>
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
- [Medium] The commit message and driver documentation claim support for an=
 interrupt endpoint, but it is never opened or exposed, leading to a meanin=
gful mismatch and potential device wedging.
--

commit a40630ab675c3654c37821d57cc77e281c7a9a17
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the USB transport

This commit introduces the USB transport for the dock. It adds a wrapper
to manage endpoint resolution and provides functions to handle control
and video data pipelines, as well as endpoint stall recovery.

> diff --git a/drivers/gpu/drm/vino/usb_link.rs b/drivers/gpu/drm/vino/usb_=
link.rs
> new file mode 100644
> index 0000000000000..04b9131d05ed9
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/usb_link.rs

[ ... ]

> +#[derive(Clone, Copy)]
> +pub(crate) struct Endpoints {
> +    /// EP02: host->dock control-plane bulk writes.
> +    pub(crate) ctrl_out: usb::Endpoint<usb::BulkOut>,
> +    /// EP84: dock->host control-plane bulk replies.
> +    pub(crate) ctrl_in: usb::Endpoint<usb::BulkIn>,
> +    /// Per-connector video bulk-OUT endpoints, from [`DockProfile::vide=
o_endpoints`].
> +    pub(crate) video: [usb::Endpoint<usb::BulkOut>; drm_sink::MAX_CONNEC=
TORS],
> +}

[Severity: Medium]
The commit message mentions an interrupt endpoint the dock pushes on and
states that this wrapper opens those pipes. Does the Endpoints struct omit
the interrupt endpoint entirely?

If the dock hardware requires its interrupt endpoint to be serviced to prev=
ent
its internal FIFO from filling up, could ignoring it wedge the dock?

[ ... ]

> +    pub(crate) fn resolve<Ctx: device::DeviceContext>(
> +        intf: &usb::Interface<Ctx>,
> +        profile: &DockProfile,
> +    ) -> Result<(Self, u8)> {

[ ... ]

> +        Ok((
> +            Self {
> +                ctrl_out: intf.endpoint::<usb::BulkOut>(EP_CTRL_OUT)?,
> +                ctrl_in: intf.endpoint::<usb::BulkIn>(EP_CTRL_IN)?,
> +                video,
> +            },
> +            connectors.min(profile.topology.connectors),
> +        ))
> +    }

[Severity: Medium]
In Endpoints::resolve(), the endpoint resolution logic does not seem to par=
se
or open the interrupt endpoint. Does this contradict the commit message cla=
im
that the wrapper opens those pipes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D2
