Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E220C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8E710E242;
	Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VSg74UKk";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D4410E237
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:09:55 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso595541f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 02:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117793; cv=none;
 d=google.com; s=arc-20260327;
 b=JBFcRFuQ6XBU4QPtyafgb68HsQj5A07w7JhPMiFEOY6z+ZsKIPHwlKZyuvPedRGfYc
 bQta6MSftn8v1DhU3PQWu50Qzus+hI1ZJ6Q4xV+u1NZ6niz7sv1dOjahIQAiBwuD7AGs
 Jra9kk+j84dsMZ4GGTLV30e65WTcRih35yF6YtYOcNMhCLGUYqAujQEhgSn7hs5hmHKB
 CEkw4xOEAVO+5J29L5Z98PI00I6tCTdRTsuy2nK9hoqvnZYuPX7bfK5v0TuLd6qER590
 z/q5XH37T3zJkp19sl9dfYpUBJwkGnhVBAIjt3RLAO+dMC0scyqvmauVNLyQYREbgw/x
 BCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
 fh=jvT69n8bMVbCoxEhgLmInjNUrI5BeAZSTWXZUhOpaJY=;
 b=SpqPDiMJeOiucYXcCPaYLmyut+WUUgT0uqj9rRI0wqscjQfwpKKSP5e9aCju1NoL8Z
 47dtqMC5AV11ozVEmrjes6rJngcvrWRFKS3apon6X7wKqv1468caQLVSTMz3tkyAcyQb
 FVijAeH6LVJmsgg8FuFZGMuTceNbqTWLrUBJrvNe1xHsLEbrSK8OWJcZGRhmVSSylcUO
 XEqgpzoK51YEPvRUJiBlCK4Ue+S37GBZJg9aJDIxOtw169czqw+xmSQhtwZ5qaRPaW5e
 NSDhJs7qs64Yt1FyzA0wdn9HE5vcftm0s/cMata+LILjvrrVUdSqhvZhSOBD1Q1bN3xY
 NwGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789117793; x=1789722593;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
 b=VSg74UKkxTPnsRggkkjkwvtaU4nvQ72bmpbN22jaREQjw68Z5oCOx0wa5pmjURplO1
 l5vCxRFOtKWlxVXGtjtzZAuSlHvjd1HvhYL37eXI/8CpDL2RXKBKproOugnb0+jieBa0
 kPg9HS4F/Rm2YlzO5yVU8/cMh7EjHdpGThFQkcLi8U9FPdQ/SsV4yvpebrlN2eREIZPg
 0FYv1R6KaLpPHJNB8AXwxOH/It0U7bGZvjmUvQdCrVFYj+WtiRyhLKdLVfBgIW3p9PpT
 9NXuhor8GxvsSx6skbQMGNU7XnP+kTM9xYyigH/r9ZccgaMONvNIHisXukzFNGb8N4TJ
 npDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117793; x=1789722593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
 b=SFZ3SNa8CnWWN9khVcBbjPMYf8CQTnK7+SMLsABd+ou4VdlbfyDsJOVC1RuXj1/6rC
 F+y6/d7xQrAFJ3XPAEtkFSu9kP6LevoUQhGRK5OzDjQ/mfAVgzSd9441mP7x9NTFRJLc
 huXQmqPiyCv7xsNOc1WeCFtJJn2XSc7Hu0ZbIIg3JG19/QVZb4l7U8d70LThZ4zTS4Xo
 Idy05DBUif8RDR5xnrF8A2sg/UIFqxAvrYK1sfp4vyzzaC4UIVK1uKYCriISFJgSyPrw
 swP5nEZGMAvALgW1vnVFg0LLk7yhVFJPEgSA2GySG/pHkpShpyR75QbW8GHY77hdlPvu
 isUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwOhDw4o3y+zEv22sI1JJz+SMcEAOT1hzd/ViDq4X3TVwm9wMIMwcOPwr40tCKrtzRa21c45zqpG8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9ghKr1Ek9jmwct/WKzrwnVhGW4OEjdZCAUaOJzRtpPDJ8iHOa
 rkXLpyiBRFBNNpfQ2WCprNo7x6TURHk4Pz5bO7aURLEj8lusVGPZEVtOdd+yxrdnmb0F8xKscSm
 NW5JGwqMEcm6DbbxD3xtFPgSVCvkDBOEYf9ICyz5X
X-Gm-Gg: AYBFou3z1ieG5/zmDpHQFfUbgeOfjXrww3GkyQtoJr61ntaBPccGNeQyK5eE+wLZs6p
 Soefr7t32+JY7L8xZoec4jtQSP888WApuXN3UbRvX08zKqMMbjmVOA20KOcUDCmcN2sINNy2lcW
 KDcFCIFgvIe2ZeA9bgMvGRp7vYeDRIyJD2f6JhmzoNMdFe4dPPaAJ66/cPeVWC02eMuWWfs6b39
 8mnzTcjlLVmEYc5TyQHEghAEAwCXEpoJisH0PaSihjZdMyqrgj+8Si/kwwklP1UrG0j+9XQ3ucZ
 IUDxWLfcRIXTtVDT/5/YvVndh6D1WjgbIgA7SvUo/8bWIA1TLV8p1GHzoBcfKceZo2Y6woNgxKs
 JpYWBQTzcDyC18nNzG5dYJHMaXQFF2nT1T+TuGnfra+9M8trG/LRk
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef`
 example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Oliver Mangold <oliver.mangold@pm.me>
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

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
