Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EAFC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB77610EB1D;
	Tue, 18 Aug 2026 12:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HUCPP/Fj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D749610EAF0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787057020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9G3iSxs63cmwbUmYiEX69zc+tabrPwShtlbbS8QAMw=;
 b=HUCPP/FjWPi9LOpaQAeZW+I8Ng4QSrrWt7yU/ZFyY0YEsoMC2fHviuNEHe8vTncPLnSOb9
 P7GHmwag7RkQx3oBiFI0wU7NRUKZtNqPtc1ppr6C94iXt+fjjY1GSiHhN/eZnQ6X2dh8EL
 LU591ghoPLQRQOFBEBZZYHwB7ONcAAM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-5M21xHSaMzOe-e4d_OvB7g-1; Tue, 18 Aug 2026 08:43:36 -0400
X-MC-Unique: 5M21xHSaMzOe-e4d_OvB7g-1
X-Mimecast-MFC-AGG-ID: 5M21xHSaMzOe-e4d_OvB7g_1787057016
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e735bcceaso75699327b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787057016; x=1787661816;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9G3iSxs63cmwbUmYiEX69zc+tabrPwShtlbbS8QAMw=;
 b=MErLOWeYxtcoEXK2TvJ/L4zcCgIAfheUnDCRFKoTT+HWcLsifosF8qCfbhrtOIuFTc
 Y5VBtcDPDlnm88L1MalOd5zzbkTERCunBHv6oi10pAtyv4MbxiF+fGDEJLa/O9Gubf1Q
 zHixiF91Y2mckwkRd4ewhAnLIvbnWXXdiaJ9898P/8w8MRtEElBEMp1d/RGIvJE+yQmZ
 pX6Br0XQJ3S6uJFIvfHb4yNGMDNtByw4b/NkKVHUkwwteM19rVzWZIbIeg1qEsnrCok7
 S0f6/Z8g7dorw4rSMwoL1KO0Vs2Jsb4YVGDcBNad50aTfb36PzDWWAUqdn/6GNImVU2v
 xW+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RozgUdpPXjEDjyUqaXrKtsu1vVTUY4ihHLpYyMzLg6Nkygm0U51Mk9s1COJY8QuI3CwbBMi2WPGCdE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrQvWqgFlfGJDKsKpYlJiGjs79XmEqMXm1cveqViLHMuri97C4
 AYCfc2swwLX0TPSK5NCG6A1C5z1mLNSliX6MZFeRu5VHf/2EGMSI5qNDuSev27xYoDlgLu3waFP
 FIq9HZ4lGMyxNEfGIVOmEsSGKk6ty/Snh15HPtGAZU/afadxkIukgN2UVzRP2Shy72jNwbRxne2
 IOyw4We9LLKtwktYDl8ZBWv/ZDCXuIhDmvf81Iz3kSpSCL
X-Gm-Gg: AR+sD12WW4i4ZSyVnLD+AHj8d8unsVMpZEkPblnS37gPm0py3anScpLyXEzPRbgsoHP
 GGlJQDVjr+ca70TR8HF7QR9h0/g+UrYe6YnsBp53IlnXl9mt/Ykw5TQwcKtqpRplLLe1Ij4gXIX
 UYDp4cMpyer2licYul4VcHjALeW8p85FlPeJJPx0tOi9v1SpLUGQLYg4w=
X-Received: by 2002:a05:690c:6807:b0:81e:45a6:bd5a with SMTP id
 00721157ae682-83707af976cmr125335307b3.0.1787057016200; 
 Tue, 18 Aug 2026 05:43:36 -0700 (PDT)
X-Received: by 2002:a05:690c:6807:b0:81e:45a6:bd5a with SMTP id
 00721157ae682-83707af976cmr125334917b3.0.1787057015697; Tue, 18 Aug 2026
 05:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
 <20260818-encouraging-lime-kestrel-d0d819@houat>
In-Reply-To: <20260818-encouraging-lime-kestrel-d0d819@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 18 Aug 2026 14:43:24 +0200
X-Gm-Features: AcwNN1Xf5TcQWb8-1dGKED6s68kinvfHK33o_OU_E9S6-z4zydpISHNRJ6-TMKU
Message-ID: <CADSE00JgK-CYnBiCA8aB2tGXG2CqC-zB_Tvz3eU=2ap00th3bw@mail.gmail.com>
Subject: Re: [PATCH 0/5] rust: drm: add panel bindings
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8i0dYu-vvV6C-WgCJ4nKPFHBTWdcfWqtGaNXm-qUxo0_1787057016
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Aug 18, 2026 at 1:45=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Mon, Aug 17, 2026 at 01:40:45PM +0200, Albert Esteve wrote:
> > This series adds Rust abstractions for the DRM panel subsystem,
> > covering both the consumer and producer sides of the API.
> > This helps closing the gap so that future panel drivers
> > can be written directly in Rust.
> >
> > Background
> > ----------
> > The DRM panel C API has been progressively hardened over the past
> > year (see [1], [2], and [3]). All panel drivers were fully migrated
> > to kref-based allocation via devm_drm_panel_alloc(). Panel lookup
> > functions (i.e., of_drm_find_panel() and find_panel_by_fwnode())
> > were also updated to acquire a reference before returning.
> >
> > Note this series depends on [3] being merged in the base
> > tree. Currently it has been only applied to drm-misc-next.
> > The other series mentioned above are already part of the
> > base for the current version of this series.
> >
> > As a personal note, part of my motivation for creating this series
> > was learning more about Rust in the kernel. I would appreciate
> > feedback on Rust-specific idioms or kernel conventions used here
> > that I may have missed.
> >
> > What this series does
> > ---------------------
> > Patch 1 adds of::Node, a Rust wrapper for struct device_node
> > implementing AlwaysRefCounted. C helpers are added so that of_node_get(=
)
> > and of_node_put() are reachable from Rust independently of CONFIG_OF_DY=
NAMIC.
> >
> > Patch 2 adds drm::Connector, a minimal Rust wrapper for
> > struct drm_connector. Its sole purpose is to provide a typed reference
> > for the get_modes() callback argument; no ownership or refcounting is
> > exposed at this stage.
> >
> > Patch 3 adds the consumer side of the panel abstraction:
> > - Panel wraps struct drm_panel and implements AlwaysRefCounted via
> >   drm_panel_get/put. Consumer lifecycle methods are exposed as safe wra=
ppers.
> > - PanelOrientation wraps enum drm_panel_orientation and provides
> >   from_of_node() to read the "rotation" device tree property.
> > - Registration manages the panel's presence in the global registry
> >   via drm_panel_add/remove, decoupling registry lifetime from
> >   reference count lifetime.
> >
> > Patch 4 adds the producer side:
> > - PanelFuncs is a #[vtable] trait that panel drivers implement to
> >   provide their callbacks. All but get_modes are optional.
> > - Panel::new wraps __devm_drm_panel_alloc, returning an ARef<Panel>.
> >   Registration with the global registry is kept separate via
> >   Registration::register, following the pattern of drm::Device::new.
> > - ConnectorType mirrors the DRM_MODE_CONNECTOR_* defines from
> >   include/uapi/drm/drm_mode.h, required by Panel::new to specify the
> >   panel's connector type.
> >
> > Patch 5 adds gated tests, covering data type conversions and layout
> > invariants.
>
> So while it's definitely welcome on principle, I wonder if panels would
> be a place to invest in at the moment
>
> The series
> https://lore.kernel.org/dri-devel/20260814-drm-bridge-every-panel-v1-0-19=
cd5277cc8d@bootlin.com/
> is likely to move every consumer to use bridges exclusively.
>
> https://lore.kernel.org/ksummit/0fa2fb42-0714-49f7-ba43-22928e1dd488@lina=
ro.org/
> raised a discussion that the panel API is very limited at the moment
> (while the bridge API isn't, or could be much more easily extended).

Thanks for sharing all the information and links!

>
> This is supposed to be discussed at plumbers, but I seriously think the
> outcome of that discussion would be to just deprecate panels.
>
> Bridges would be a much more long-term-proof investment.

I picked panels because I had recently worked on their refcounting
improvement efforts. And even though I saw some comments in reviews
hinting at what you pointed out above, I did not connect the dots.

I will certainly pay attention to the discussion at plumbers. But for
this series, I'd be happy to drop the panel bindings and switch to
bridges for the next version.

BR,
Albert

>
> Maxime

