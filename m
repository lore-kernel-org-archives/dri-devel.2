Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47401C5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A10E10E4B9;
	Tue, 18 Aug 2026 11:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QmTvrnp9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807F810E4B9
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:45:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE34B429C5;
 Tue, 18 Aug 2026 11:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC4E1F000E9;
 Tue, 18 Aug 2026 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787053528;
 bh=+oxPcNqI3PZAHqM9v3WwprvFy/3gIlcIsJcj85Aon4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QmTvrnp9fL/D0PyKCZ908Xy5MzGvQyXPXvc1fWjWpjgUk+Y3HTZJlGiassc+VefGB
 LUFlYBHvFPPAkkrQdvJIq33GAifd6tTbWliGLaEU2EMwagmB3JIetKbVDm/+UbEhXb
 HaCq5yaHaTvv2n2P1NHTUgZPGnB1a2evKi7ZbTrgjqH/h+Lo/PS3cMsoJ5yYYIO6jQ
 USBJaG8M5N964hkLMyvHL97YcHVbn9IVODSTPKaI0pBDqMt9dyBehWQb7BKm2eeZ1q
 jN2o3oSqmUqifTeKZhKj1P9fV2F+HymGYznIpFcp/vTFvhzN7cJ3v3dFLPd6fm+tbH
 v15GyEORQR3rw==
Date: Tue, 18 Aug 2026 13:45:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/5] rust: drm: add panel bindings
Message-ID: <20260818-encouraging-lime-kestrel-d0d819@houat>
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ih6zdmnfjowuha6b"
Content-Disposition: inline
In-Reply-To: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
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


--ih6zdmnfjowuha6b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] rust: drm: add panel bindings
MIME-Version: 1.0

Hi,

On Mon, Aug 17, 2026 at 01:40:45PM +0200, Albert Esteve wrote:
> This series adds Rust abstractions for the DRM panel subsystem,
> covering both the consumer and producer sides of the API.
> This helps closing the gap so that future panel drivers
> can be written directly in Rust.
>=20
> Background
> ----------
> The DRM panel C API has been progressively hardened over the past
> year (see [1], [2], and [3]). All panel drivers were fully migrated
> to kref-based allocation via devm_drm_panel_alloc(). Panel lookup
> functions (i.e., of_drm_find_panel() and find_panel_by_fwnode())
> were also updated to acquire a reference before returning.
>=20
> Note this series depends on [3] being merged in the base
> tree. Currently it has been only applied to drm-misc-next.
> The other series mentioned above are already part of the
> base for the current version of this series.
>=20
> As a personal note, part of my motivation for creating this series
> was learning more about Rust in the kernel. I would appreciate
> feedback on Rust-specific idioms or kernel conventions used here
> that I may have missed.
>=20
> What this series does
> ---------------------
> Patch 1 adds of::Node, a Rust wrapper for struct device_node
> implementing AlwaysRefCounted. C helpers are added so that of_node_get()
> and of_node_put() are reachable from Rust independently of CONFIG_OF_DYNA=
MIC.
>=20
> Patch 2 adds drm::Connector, a minimal Rust wrapper for
> struct drm_connector. Its sole purpose is to provide a typed reference
> for the get_modes() callback argument; no ownership or refcounting is
> exposed at this stage.
>=20
> Patch 3 adds the consumer side of the panel abstraction:
> - Panel wraps struct drm_panel and implements AlwaysRefCounted via
>   drm_panel_get/put. Consumer lifecycle methods are exposed as safe wrapp=
ers.
> - PanelOrientation wraps enum drm_panel_orientation and provides
>   from_of_node() to read the "rotation" device tree property.
> - Registration manages the panel's presence in the global registry
>   via drm_panel_add/remove, decoupling registry lifetime from
>   reference count lifetime.
>=20
> Patch 4 adds the producer side:
> - PanelFuncs is a #[vtable] trait that panel drivers implement to
>   provide their callbacks. All but get_modes are optional.
> - Panel::new wraps __devm_drm_panel_alloc, returning an ARef<Panel>.
>   Registration with the global registry is kept separate via
>   Registration::register, following the pattern of drm::Device::new.
> - ConnectorType mirrors the DRM_MODE_CONNECTOR_* defines from
>   include/uapi/drm/drm_mode.h, required by Panel::new to specify the
>   panel's connector type.
>=20
> Patch 5 adds gated tests, covering data type conversions and layout
> invariants.

So while it's definitely welcome on principle, I wonder if panels would
be a place to invest in at the moment

The series
https://lore.kernel.org/dri-devel/20260814-drm-bridge-every-panel-v1-0-19cd=
5277cc8d@bootlin.com/
is likely to move every consumer to use bridges exclusively.

https://lore.kernel.org/ksummit/0fa2fb42-0714-49f7-ba43-22928e1dd488@linaro=
=2Eorg/
raised a discussion that the panel API is very limited at the moment
(while the bridge API isn't, or could be much more easily extended).

This is supposed to be discussed at plumbers, but I seriously think the
outcome of that discussion would be to just deprecate panels.

Bridges would be a much more long-term-proof investment.

Maxime

--ih6zdmnfjowuha6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaoRFzwAKCRAnX84Zoj2+
dlGQAYDYIAOqhHx0r6fLK8nL73TpSPjwnj7GDvkvyW8rtyvEnJnwJtKUz3FlzEIu
QTiiVi0BfjlGkOxjUBXGBY6GrqOPUssitDNX9C7kIp3Sl7Fwv9uKTg40JiFLOHtB
+22qEwBmsQ==
=txvi
-----END PGP SIGNATURE-----

--ih6zdmnfjowuha6b--
