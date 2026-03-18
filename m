Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB2103E17A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B09610E153;
	Wed, 18 Mar 2026 14:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRtVHlls";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DB810E36C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:42:00 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c0c9994199so147928eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844920; cv=none;
 d=google.com; s=arc-20240605;
 b=hJlBwIKtxU0VEzjjDf21uDCmhTGXqQT/QYMPCrCigKpdmobMEYbqqhCyvHfX29yHp6
 7sbkd2X3g5fyq6J52oH6gfaQXqw+46VEzvXYyvkmAeN+cMrqro0BXUVUF9lZ/vgEyip6
 tkK2nVW5BavP8ZKbViwchF7FH3JLnKvqgSquPb3z+ebq120LEPPQjKZkbJsTtTCodwuc
 4+yQyJbyVpLOXMikaJqpz/CxB/8dV498y3KxdcbQquh3CHgN31VekSdwvWi932h1h8qB
 L8FrgnCsLnMtCl611vcmG0DcJqwYPCF6U/ICedadwr/dHiv19LUq7g58+AgSc1FUI7FB
 uTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
 fh=4ey7eJzm8H1aGeglsGhpsyFAeRnaQt0tDBkUf0wU4uY=;
 b=G6PG2i0f1PV09iluOUM8QGUUF9cclogV5OQoCNZoxEg0CuXb8Bh0TeHhCV+L8rp1eS
 7mo0yVfDyzjPwwm25Hp5lawQYclJ4xen+Tsy/6RWtb3uBA1DJ2XrVaAjlZFKVKgnL7YP
 S8++BEb6jhMcZTzUiH1BwY7vWR0GtjPam7Ry+zMbyFTLeKUSLDxJpGZXZer7Y7q1ZEcl
 TlbRPAP5MYq93/IkWrDcLByXZD7OrCZBRKOYz1EPny8rFZadDFcsL5GXOKlAQRSxMZhN
 Gt4BcGDGBj97EPcZEiQcOVA8gIHzMTeiy/CSwr6SvRyPqNQLYlf6wFRdP7R6OBotFhcU
 IvJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773844920; x=1774449720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
 b=VRtVHllsYbUfS99x8ZJ5g4p32kEK+wtGik6SRcit90VBBH3EYlfQvrWNK/tzalFF1H
 8wZkA7EkU80PjeueroLcaAIw9QUWh0vkexlBYUyjfR8smumbcQbUg50DdmaGxRhpf1CN
 qmSE+vyb4lIRosAVGh/7tpW5LldPt5aSoI6zTzlzK2nMsVqoIj+/IbT8MbdxkaXcQTgk
 3qNAT1/I1MJyie16WYZrzWbXNgWmd2ksC636kT67MAXZpBaJaYMVQeXoyvqAcdzV+jBo
 emYB/hHO63xnRO7ZqfTZbwbhWeRgeIPbJQ157/IUZqB5lz/o/3g50Ou2B4IvpBx7vlfM
 50SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844920; x=1774449720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
 b=Ar7gd2vqrti/wJJysxCgbelXxjn5evLDb6VeGRMJVq++l6E/gEkYVgBt0Pj3QbbUF0
 NJmYODNVcfbmC8kpfCRmq9zoIuZCWOJx0PN6zFLRY6py6G376sixFB/y/G1arltS6ntb
 8ZfHofHHmyMkGiKDjYZOcC++WrC7HGBwdnl4HWsHsitNTlsAMqfUPnzIAGH7sHCshaKi
 T8IpNgyei+KkASTq/4fJGwSgNm9n64hY3rXY6p3i6Yzp/n7hHk3YKVIElahaB5ku7uRI
 B3waToG7+KSg/MdiI3+tYMJPjktbEMNyXRES2DVKHn+MJZiPV1OFyZrkkQUXNd0wyFVy
 B5Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCoyAyJ7QNQIq/LgzF+L9rEwFunMH9e/Z39grHBfJbguNcAup8sGhjT4l05L1kryZgq5Lux1PBv6A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy28nrOdlBJcNsVIaLMyNNthTYs4C2w863TfUm3UgpNNNbRXXER
 mnX9RUzzOZnM258Yz1enWWClytAo69YrkeIMokXYCmFDVjBSWFBAAMF0Mcf0kBfj4zQTBdC3UEj
 IMa1iVw9Xf1AMGnmZ6dwOkdrrcJdnSZY=
X-Gm-Gg: ATEYQzzV9mAvNRfOv4yTYfiYULqebly+rXJjs6bfpQ/HHovqbVdNqiGdmQ4RBP++3Y0
 LTKRh3pcup4nAiwRlrtbgCZYl2Y07iPVYRTRGROWtxTU+bB6xY4o6XilWG+UIHpDI4IL0u2XtgC
 jd7uvBmoLNPQp+Ec++RmpZGRRHkskGlHizVRiuwQQoFwi8Y9beloIEhW7OR5KcQg8fj09vue9i2
 uKhw8PcYKpVZO/AEG3hpHdkbuFYx1uv3geJre11ZlXjJLhoHPIIZCtHblFoXVvaSH/kqLFZqCpa
 uf0Q8WbPR0M9nz+t760z0zQei+hyHwN5KoYCdki+3zIQ+olBzD1ho24CaLTZupuQgWA/22YqYuy
 XpY8gqXb1FiUn+hSLvIrj6kY=
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr877942eec.1.1773844919477; Wed, 18 Mar 2026
 07:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
In-Reply-To: <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:41:44 +0100
X-Gm-Features: AaiRm52glbQ5k03i38HLvFJrknMe1XNNnKvvWBogM8moiNwsNZDgYGGN20TDKPc
Message-ID: <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, 
 Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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

On Wed, Mar 18, 2026 at 3:31=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> In principle this is possible using
>
> #[path =3D "pci/pci.rs"]
> pub mod pci;

No, I meant supported natively, i.e. without having to write an extra
file everywhere (which could perhaps be simpler as just a symlink
instead).

We could also generate the `mod.rs` on the fly, but that means a clean
tree isn't great for tooling etc.

Cheers,
Miguel
