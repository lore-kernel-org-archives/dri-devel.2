Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F297CD5BD2
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131410E14B;
	Mon, 25 May 2026 14:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VPpdPOz9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26ED10E14B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:46:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 202EE600C3;
 Mon, 25 May 2026 14:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BB11F000E9;
 Mon, 25 May 2026 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779720382;
 bh=p8bI0W/hdn902yJe2xP7w0AZ0/K6OZ+j/YWXcl7hIF0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=VPpdPOz9SBWmfS4IE/Aim3UiRM9wwUCl7UjXZ/kv6ncdjsyNvotNir4Vu30dgnhnx
 3hpA/OqaSuOrNylGCZkEcQlXmxukgtse2agkad3nWUkC5lL1SNmhkHjq8gHO69EaIt
 vVVgaTk5vHI1vPstGEzJTrBc+MFba8VoJSuOJ4WtugTbWvzqn15pncG9g46IevsWmA
 F41he+0vMWlTPAdd3KKZnVLNNUCgU0GrD1PbzvRd6zT/l6QNqM/Dd4+6eopIQeYcnC
 UAF4xZJAu1fEBL/ulVCp6p3Viivmcm2oeRZd4yvyVYSl7r0/s7fewIwT4QQTiB7Cd4
 spGiZpc+TlXXQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 16:46:18 +0200
Message-Id: <DIRU7Z3NH9J2.2HT7Z93HFCFW0@kernel.org>
Subject: Re: [PATCH v5 15/22] gpu: nova-core: vbios: use the first PCI-AT image
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
 <20260525-fix-vbios-v5-15-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-15-e5e455251537@nvidia.com>
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

On Mon May 25, 2026 at 3:57 PM CEST, Eliot Courtney wrote:
> @@ -333,7 +333,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0)=
 -> Result<Vbios> {
>              // Convert to a specific image type
>              match BiosImageType::try_from(image.pcir.code_type) {
>                  Ok(BiosImageType::PciAt) =3D> {
> -                    pci_at_image =3D Some(PciAtBiosImage::try_from(image=
)?);
> +                    // Silently ignore any extra PCI-AT images.
> +                    if pci_at_image.is_none() {
> +                        pci_at_image =3D Some(PciAtBiosImage::try_from(i=
mage)?);
> +                    }
>                  }
>                  Ok(BiosImageType::FwSec) =3D> {
>                      if first_fwsec_image.is_none() {

This does produce the following warning:

  CLIPPY [M] drivers/gpu/nova-core/nova_core.o
warning: this `if` can be collapsed into the outer `match`
   --> drivers/gpu/nova-core/vbios.rs:337:21
    |
337 | /                     if pci_at_image.is_none() {
338 | |                         pci_at_image =3D Some(PciAtBiosImage::try_f=
rom(image)?);
339 | |                     }
    | |_____________________^
    |
    =3D help: for further information visit https://rust-lang.github.io/rus=
t-clippy/rust-1.95.0/index.html#collapsible_match
    =3D note: `-W clippy::collapsible-match` implied by `-W clippy::all`
    =3D help: to override `-W clippy::all` add `#[allow(clippy::collapsible=
_match)]`
help: collapse nested if block
    |
335 ~                 Ok(BiosImageType::PciAt)
336 |                     // Silently ignore any extra PCI-AT images.
337 ~                     if pci_at_image.is_none() =3D> {
338 |                         pci_at_image =3D Some(PciAtBiosImage::try_fro=
m(image)?);
339 ~                     }
    |

warning: 1 warning emitted

I can fix it up this way:

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.r=
s
index 82811e42e858..bf61b085d7c0 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -332,11 +332,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) =
-> Result<Vbios> {

             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
-                Ok(BiosImageType::PciAt) =3D> {
+                Ok(BiosImageType::PciAt)
                     // Silently ignore any extra PCI-AT images.
-                    if pci_at_image.is_none() {
+                    if pci_at_image.is_none() =3D> {
                         pci_at_image =3D Some(PciAtBiosImage::try_from(ima=
ge)?);
-                    }
                 }
                 Ok(BiosImageType::FwSec) =3D> {
                     if first_fwsec_image.is_none() {

However, I'm not exactly sure it really is an improvement in terms of
readability and whether this is a prime example for this lint.
