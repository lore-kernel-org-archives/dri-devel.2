Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA92AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EB910E3F1;
	Mon, 17 Aug 2026 11:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Hjm/Gblz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF7510E3F1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786966864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mY1l25E03ZXeteA83B/irMr+xfrr1Cyvpdg7ez8aiZA=;
 b=Hjm/GblzJoz5BNhfwER+1JRZTDj3sOBvHYUIp4pyYmSB9kd2OAJlR1FD46td/kFgQNvOj9
 A+4oeaj1AZyVzIr84qYqhjYbv1OixQyl5ju5M96P4852SNco3CyXoOtQiAjTdLKPB0ZD3Y
 Ed0mKQit6tbfA4aJBpe94qNnn8HmTJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-modafi1CNrugVqv0LZDfcA-1; Mon,
 17 Aug 2026 07:40:59 -0400
X-MC-Unique: modafi1CNrugVqv0LZDfcA-1
X-Mimecast-MFC-AGG-ID: modafi1CNrugVqv0LZDfcA_1786966856
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9B671956095; Mon, 17 Aug 2026 11:40:55 +0000 (UTC)
Received: from [192.168.1.153] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E9E426; Mon, 17 Aug 2026 11:40:50 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 0/5] rust: drm: add panel bindings
Date: Mon, 17 Aug 2026 13:40:45 +0200
Message-Id: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1hZaf6hXESnRRg1olBZEkN7d4
 vItZl4I5JkC9NkLnm4OfEqCyTOYN5SVFLtkKHTR6NZUyvnDXii024nFsaxBdQZLRKqd7mZI4eV
 p4eefDmOMHyHK6E1kAAAA
X-Change-ID: 20260814-drm_panel_bindings-91a3aae5d09c
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786966849; l=3774;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=JSrjBrj5BTLlADlVdzs5WU3IgxBDvOu7+w58WHPWh9s=;
 b=D3PTPWJDVJra3G0gCMgII6Ru+zOM+IXnQuj4lFWmw/PcW+U/qZ0NJErSw6SZ7cUml9C9LDxru
 bIkOTCidznpBWwKH8ishi1j3UsHRM3NMdo/o47t33+r+ZQ1JyAWIl2b
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 0mmon5nsw5pl60O-cep1ZXfJHxNJCD7L13jDK45X-kY_1786966856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

This series adds Rust abstractions for the DRM panel subsystem,
covering both the consumer and producer sides of the API.
This helps closing the gap so that future panel drivers
can be written directly in Rust.

Background
----------
The DRM panel C API has been progressively hardened over the past
year (see [1], [2], and [3]). All panel drivers were fully migrated
to kref-based allocation via devm_drm_panel_alloc(). Panel lookup
functions (i.e., of_drm_find_panel() and find_panel_by_fwnode())
were also updated to acquire a reference before returning.

Note this series depends on [3] being merged in the base
tree. Currently it has been only applied to drm-misc-next.
The other series mentioned above are already part of the
base for the current version of this series.

As a personal note, part of my motivation for creating this series
was learning more about Rust in the kernel. I would appreciate
feedback on Rust-specific idioms or kernel conventions used here
that I may have missed.

What this series does
---------------------
Patch 1 adds of::Node, a Rust wrapper for struct device_node
implementing AlwaysRefCounted. C helpers are added so that of_node_get()
and of_node_put() are reachable from Rust independently of CONFIG_OF_DYNAMIC.

Patch 2 adds drm::Connector, a minimal Rust wrapper for
struct drm_connector. Its sole purpose is to provide a typed reference
for the get_modes() callback argument; no ownership or refcounting is
exposed at this stage.

Patch 3 adds the consumer side of the panel abstraction:
- Panel wraps struct drm_panel and implements AlwaysRefCounted via
  drm_panel_get/put. Consumer lifecycle methods are exposed as safe wrappers.
- PanelOrientation wraps enum drm_panel_orientation and provides
  from_of_node() to read the "rotation" device tree property.
- Registration manages the panel's presence in the global registry
  via drm_panel_add/remove, decoupling registry lifetime from
  reference count lifetime.

Patch 4 adds the producer side:
- PanelFuncs is a #[vtable] trait that panel drivers implement to
  provide their callbacks. All but get_modes are optional.
- Panel::new wraps __devm_drm_panel_alloc, returning an ARef<Panel>.
  Registration with the global registry is kept separate via
  Registration::register, following the pattern of drm::Device::new.
- ConnectorType mirrors the DRM_MODE_CONNECTOR_* defines from
  include/uapi/drm/drm_mode.h, required by Panel::new to specify the
  panel's connector type.

Patch 5 adds gated tests, covering data type conversions and layout
invariants.

[1] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-0-dad50c60c6c9@redhat.com/
[2] https://lore.kernel.org/all/20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com/
[3] https://lore.kernel.org/all/20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com/

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Albert Esteve (5):
      rust: of: add Node type
      rust: drm: add connector abstraction
      rust: drm: add panel consumer abstractions
      rust: drm: add panel producer abstractions
      rust: drm: add KUnit tests for panel

 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/drm.c              |  15 +
 rust/helpers/of.c               |  10 +
 rust/kernel/Kconfig.test        |  10 +
 rust/kernel/drm/connector.rs    |  33 ++
 rust/kernel/drm/mod.rs          |   2 +
 rust/kernel/drm/panel.rs        | 684 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/of.rs               |  43 +++
 8 files changed, 799 insertions(+)
---
base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
change-id: 20260814-drm_panel_bindings-91a3aae5d09c

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

