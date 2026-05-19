Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405EACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 19:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFEE10E076;
	Tue, 19 May 2026 19:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="G15pZRrA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D576B10E076
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779217336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k0U0SPErPKCW9LWawSkKTcXgFGdc7H4m2CUvw8GQtis=;
 b=G15pZRrAmm/GYWygQuao36aQPPrj/gNJSGGzetAzUUD1PLMQ5eYGIijfWCpk4cj5GXLxWk
 TJJ9xwG6IIwLOmXbK5OHbyWdJvjdqweHHiquZ8c/oW0P2Fu/+l+m/DQJAohin9UpO/RnjW
 CrvDanSlLhNkzNGWrsW6fqSnBlHzO7U=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-8c_dXrS_NNy35__K8K01-A-1; Tue, 19 May 2026 15:02:14 -0400
X-MC-Unique: 8c_dXrS_NNy35__K8K01-A-1
X-Mimecast-MFC-AGG-ID: 8c_dXrS_NNy35__K8K01-A_1779217334
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135fe34cb98so191688c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779217334; x=1779822134;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0U0SPErPKCW9LWawSkKTcXgFGdc7H4m2CUvw8GQtis=;
 b=nPqUPZDkMABzQvL7SNMM8daSCP2Hk7eFrJbMGJ76MRqebJvNBBukDaN7BJd4bMSbD1
 SgN/uDgBlyNe0IYb/9PvG6EuGxap6/NrSup5GWA/8tUJEXR/g3snJLB15bo/scri0hAB
 X+TF0NpNVqil/7LDWWjwWBFx9/tnfiL7JRobPo7NU/kauOHcAtT1HZ5MVfCTL/Gl5rpV
 uZZccOytRViOB4vQPegSlC54OMrvT5W6xEbThEBYvStVLt9wUULD1s/7vp7577cU566B
 ZnTNf7mA1A/zxL5H1FcF3TwXKQJHsVZ4swWfTGDb7zV6L8C3k2z4gZRr7AiUZd/93CtT
 JCtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1Q7TEZWHzVbQPVblgWxQF2lFE3siG7q4/CGUvtms18l5S5njlYzmisFjJFIgUMo7PH9pa+TFztYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/CsEXs4PeHqo6IcUZ+Wfkh7fcXktHTFXxp3+HFQ1e4w4LMLbb
 BY2EIxVthLK+qjq8BQCAXnpwjQjZoZWpWxDcMArGsuxxyhclEZKUrgPDguiCU7M7/RvVMg9/m6k
 +f7iR0wDjLG8goiy9os/Gvxbgi/lmE35FzlhEVdRCPvVeZqpuxhb/4dTosTUW0ZKiMd/IGw==
X-Gm-Gg: Acq92OEr/mKM7MMzLImJe67viCTsiaKIzZpvUi1OG1RicC6TeSCTbqMOsOhFkH6rf60
 kevSwo5wn+od/DUEKaupIrXHs6HeCOhJUGiL3dVXEDqcfafafoTRnHnXWF1zjSMeHNavsrSO9Ob
 y9PRTbg9gvP58rsa1tRq6ALZD++rs0tUiyX09Opy45sxCAmKzg0qbURHLOANHbl2X1WKdZXYrZ9
 sb4PxefULflTUEd8J3aO4DwlGnuivWhFa6M+HinLuttGudD/QfaQABqa6Fg29eJqUhvBkvJwXQN
 x80uADtHo8u1RmS/IrqYx0qpun091tR9YjAGIIzkfjRGvwjmNqO5PuGdTh38PqH/fzeoCuLgeDC
 8rcHXTQNgQJOdden8bA==
X-Received: by 2002:a05:7022:6baa:b0:135:578a:cde2 with SMTP id
 a92af1059eb24-135578ad3admr5580680c88.34.1779217333607; 
 Tue, 19 May 2026 12:02:13 -0700 (PDT)
X-Received: by 2002:a05:7022:6baa:b0:135:578a:cde2 with SMTP id
 a92af1059eb24-135578ad3admr5580606c88.34.1779217332985; 
 Tue, 19 May 2026 12:02:12 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910baf22315sm1962832785a.21.2026.05.19.12.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:02:12 -0700 (PDT)
Message-ID: <3ed6a4bc42a547ed973cf2b77bde7171e0a15314.camel@redhat.com>
Subject: Re: [PATCH 0/6] rust: drm: Higher-Ranked Lifetime private data
From: lyude@redhat.com
To: Boris Brezillon <boris.brezillon@collabora.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>, aliceryhl@google.com, 
 airlied@gmail.com, simona@ffwll.ch, daniel.almeida@collabora.com, 
 acourbot@nvidia.com, apopple@nvidia.com, ecourtney@nvidia.com,
 ojeda@kernel.org, 	boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, 	a.hindborg@kernel.org,
 tmgross@umich.edu, driver-core@lists.linux.dev, 	nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Date: Tue, 19 May 2026 15:02:11 -0400
In-Reply-To: <20260519205947.3c9d99b3@fedora>
References: <20260506221027.858481-1-dakr@kernel.org>
 <DICCEKZ3HU84.34ES3SW3D1FNI@kernel.org>	<agYbppHWXk_hW99M@um790>
 <DIIMVPTLV3O5.3Q3DHU66WQZUA@kernel.org> <20260519205947.3c9d99b3@fedora>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _EF3Wb05cpjHS2JNMaa-RkfYidVwjiRTV6i2sIPsqY8_1779217334
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

On Tue, 2026-05-19 at 20:59 +0200, Boris Brezillon wrote:
> On Thu, 14 May 2026 21:07:11 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>=20
> > On Thu May 14, 2026 at 8:59 PM CEST, Deborah Brouwer wrote:
> > > let unreg_dev =3D
> > > drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;=C2=A0=20
> >=20
> > You shouldn't need this anymore as the drm::Registration itself has
> > private data
> > now that is bound to the lifetime of the underlying bus device,
> > which should be
> > the correct lifetime for juggling the GPU page tables.
>=20
> The problem we have is that, to initialize some of the sub-components
> of the driver, we need to be able to allocate GEM objects before the
> DRM
> device is exposed (registered), and because the data we want to
> attach
> to the final registration contains these sub-components, we need to
> defer the data assignment to the registration step (which was allowed
> by [1], but apparently this was dropped from the latest version of
> the series for some reason).
>=20
> [1]
> https://lore.kernel.org/dri-devel/20260320233645.950190-4-lyude@redha
> t.com/

I dropped it because when talking with Danilo I had the impression that
we weren't going to need this (and I thought we explicitly had
mentioned it when talking with eachother). But I'm always happy to add
it back

