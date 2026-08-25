Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F448C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8496410E1D9;
	Tue, 25 Aug 2026 12:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XeJkv6cn";
	dkim-atps=neutral
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC4010E1D9
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:33:00 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-481558a96e2so2471419f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787661179; x=1788265979;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xlb7XfoBk1nmP2689qZHRSaAXYmnb0joWXGBYKuH+kY=;
 b=XeJkv6cnS0mvd6cQ1DHANmK7CprfSZXkp3X/+9y/QeKdylgBKqSb+1M5rfvpOMcnuu
 EAOQuhFQpppN2wi1BYuoFtEZI4oOX1/Hpo5STYNoG9G27+T1wdUpMO+A/RNCXjFSxALe
 zS/CExpSP1DTXUI96liC6HhUuEdHUf/74DSNvh9x5rA7YT4OxPwJ/7EoFg/D1cWcsKpy
 S0OoixZbSIyv2eSlJiJhHKG1b9dHQ78TfVUWsoMfIJrqaAMtPH/skr5K2zlhpERdbPj8
 SS/+vd+Gf5s9jGFHh6VHdYgDzQWs/O916bGC2X4VoIRS9jdZRjiGnhjyX4xXswTpEwLo
 xwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661179; x=1788265979;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xlb7XfoBk1nmP2689qZHRSaAXYmnb0joWXGBYKuH+kY=;
 b=RdAYo6FnuNU+glzYNECL68uEpfRyygrQwsKbpq2tySe7Zbi2QkMYg9/xpvxJLhK12m
 XxEWvLirohkpUmY7AH1NhXtbSiXAWwKXuFquVS1GINwzk3TBTjEyRD1v7mDFPXlRj1yN
 tAbMD2pSMtZf+pR1i3AUGpdvWu5+iD/WDa150mk/ctswcneRrxt0rW9XU1xDXP6EdDfB
 46WMG2UZXEzR9W56CSiDwAcSyUxzz2KCeg+SY2FkOOKe6szbq6O3+tua0egrn3StQyos
 7ZPmB9YeoUP5LeYabtUUlLCR69/OGYf/Ba1PS77QxvxVzhjE3/rH7fZ4zKZjgf6RdjQ5
 hqOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFRd0IGV2Lhe3QiQM9tEV3Y/OsixBn80FEoG0InnRCULVT1QpVtaEu8ZTiatT4IQx7JAKHXW38c/I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l56zE4M49pu9QbE5yZk5n0VeFfPCatP4DpTvxzL/kfznHptZa6
 MHu1pJZSz8JCaTuwv9KDCPeyCI8K/lv8bmA/P+kAWCYrpLW4iMoleFa9r43tkZQhWsm3zqLLg7D
 OQB/MP96DMaKT20HnUw==
X-Received: from wroy3.prod.google.com ([2002:adf:f143:0:b0:47f:51bf:11c1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5846:0:b0:481:5dea:3f0d with SMTP id
 ffacd0b85a97d-482c0b8eaabmr42274248f8f.11.1787661178297; 
 Tue, 25 Aug 2026 05:32:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:32:57 +0000
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-3-5d0b5594e52b@mailbox.org>
Mime-Version: 1.0
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-3-5d0b5594e52b@mailbox.org>
Message-ID: <ao2Lef62ZvkP9eWI@google.com>
Subject: Re: [PATCH v3 3/5] rust: pci: make Vendor::from_raw() public
From: Alice Ryhl <aliceryhl@google.com>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
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

On Wed, Aug 12, 2026 at 09:52:37PM +0200, Maurice Hieronymus wrote:
> `Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be
> obtained through the named constants generated from the
> `PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore
> cannot match a device whose vendor ID has no symbolic name.
> 
> Such devices exist. QEMU's "edu" educational device and the legacy
> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
> `pci_ids.h`. Per the policy stated at the top of that header, IDs are
> only added there when shared between multiple drivers; a single-driver
> ID is expected to be open-coded in the driver instead. C drivers already
> do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare
> ".vendor = 0x1234".

IMO we should just add Qemu to the list. No reason to hard-code it per
driver for this case.

Alice
