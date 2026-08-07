Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD40C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DE310E308;
	Fri,  7 Aug 2026 17:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YY3DrGbQ";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82F410E308
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 17:12:39 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbe437a530dso284570a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 10:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786122759; cv=none;
 d=google.com; s=arc-20260327;
 b=rB05XYo7J62+C4UFILx+9h5vyHjl4cesckOVsY+MFpPHcSLG6rvDDG9yiQrGsKsZQa
 C4RLiIz4WHshLfVDv31eWGtfokEd0tJ3bfgZGrmKIfUH96tV+aH19XRPPUQqHl7Qtp2o
 hOGM6XQfmtXwevWUjUZKvw6EkqooEItYVdRqfKGQNRjL0BqdbqD/ufENJ40LtmWglF5L
 Ypoy/8m+y6uungx3/ERvxwcCy0OW/HHtOm5aDW7VxpNJHtaB3UDlNECs0xgDk/2tj+z1
 kf2KjjB1zp3gj0uc7Vhs5N8upH2aH2hh173YH4JbFDfLRk1+RUg2FRuVqJvZnHm8IlfE
 b8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rYN3WqMlSBD8p+Coyo0jjeKucvb7gFDKdiYxoZH2MVw=;
 fh=peG+fNenkfgcyYyrLyheNvg7S31stKMSpdC9dTgARZQ=;
 b=QdyEDRpQpQZFo5mbx8vHbUDE96T6yfRLAHP7lY9koEGuDGBnUc1iHxoafdILPibYXJ
 ecTl8NSEbqoWDVLTd3q33TVxBi3ubfxuD4uGWlseKJEjFC7v1strqj0zPL3utjvH4/aE
 g36+DtkMOYhBOgm09zb1Y7Sc9D1QVzXjx7OXc+WmZpe8a8paTqCyo9nH+umabrJ9pF7O
 HOSYRgOqKGEIQjSdTy9Y7W1tdFknFznY406TvIf6zJSmRC9W1GvRtugrzwLabXVYS9+w
 2F49tiM2lxxoGFZbIrraxzASpuXBK8oHNpw+fJBC5XIM8//3rffmiLgoG97ROeC5y/RK
 dplw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786122759; x=1786727559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rYN3WqMlSBD8p+Coyo0jjeKucvb7gFDKdiYxoZH2MVw=;
 b=YY3DrGbQo9acR2U3nE99We7o/XRcgXIIV7kTZxUpdXOl37u8MUpt1FqS8DuxEWkIVV
 O5GjpkShiJ/K88zFpigZAhZ/xVd0yolpsymVflrycqXI5B7ZfcqrqIB8W3tFKy2wR+9P
 97TkqPUdorYgwSuckE1NaJ892Nnd3yV2xpn51cJbhXIuxVQmPuYE8PzrP8GXFwcMQJr6
 XSvs/4SMwd9oyINWgqUTym7jNbjTZF44iSG7MKbAoTcnjNeXZciz2buUSznpnZlbJvuB
 EOArhra+DlYt8wKyJv1mNfylAsi9c0ZGi4erS5orOq1jubGP/DGt3NkftQDJC+kfDW0E
 lNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786122759; x=1786727559;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rYN3WqMlSBD8p+Coyo0jjeKucvb7gFDKdiYxoZH2MVw=;
 b=GrtyfE1UWqU2VY2GpeUsLNzDgCsBIn5Vgc9KIVC+SE5zOe4hvMzuTQ/qm9G8k2m/9U
 nCNZUhcSlNBbcLffa6kiQK/kIhEDrXUwI0lR+lgTt9hU/VuTTCNpSMOvCscnKQFD7xNe
 BQknImzPsZoPb7I9Opd3TD8GM/r8IC2hYyaxVHX/1KxsAOyNQWWcECenhuinP0hMAxqk
 YBhO1tNeAKdReoWrnXoqZ96dCpQarKStqASSx+4kbI2Jr5E5b0qU5u+t21Oh/qJwX372
 FpdLU9LE8qezqmyP0c92NQarmMafyCD3RfmbtTWDYV+kmJNB0eWKrFLCZqHUg/GAKB++
 +I1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOUAeh8sRiC9kQxqrobR6nLSjXvczXEwlMu5cor18Me8Pfb9WFESMMMrpTciFsb38KxJ/OynwxeTs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+TmBHhK1J96bhWDxD7apQap8zO5gbylRhr/g1yehg7kJUkNqd
 v+C3C410m02lUos8P0T08GGBbr4y5Q3wwCQattZCJHUfsh1IkyBatCjyTwhn0FEUiVtNDNk8iSw
 WOL9K7vIZ+D3wcY7FM7riKEq+hEs3NKY=
X-Gm-Gg: AR+sD10G6erLwUgKplFJczXv/UpVOPV/t5792MytHJHKG8Fav3EHzvnj6QJxySM3oSg
 F/FVnjmPJkyBcOiB7rjeCk6sDW3sOzTBQTQLBlJgElm2IsjNoc8DTAiGxlaAhCxeZKgD/kJcDIn
 uALZ9mFc545H2GPExu3N61dCtmEg5yDTfvAPTaB3CnnZ5K3rSpk1/5G/Yubs4mJAewJNsjFZSwj
 jSFQ/EDWjKyoI2fTM+LnGU40sN0fE3i6UBe5VQw1g7DkQQZkFdzngzUVUBwAts6+8Zen0gc0SJI
 mxVsT4v8Xar10aKuuYiJObggcbttbniLo2ZmjdDIAiEPiVmauq5YuSK3EJ9wlWUmKHj3QoJ6EeR
 xYSXfM1FddTKrfZzZzwnDjE5jr621roLT91yXI0u5LgZljnEgTL+xUU7ZA2Je
X-Received: by 2002:a17:90b:1fc8:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-3903c628181mr18187876a91.2.1786122759120; Fri, 07 Aug 2026
 10:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
 <DKIRNHGHK4O6.2IRJZGM6W79B@nvidia.com>
In-Reply-To: <DKIRNHGHK4O6.2IRJZGM6W79B@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Aug 2026 19:12:25 +0200
X-Gm-Features: AUfX_mw-cYa1MKRYuhH-uVGjXrAOGt3b9pyVqsuViit8BjsQ3XkXMD2u-qTWwOs
Message-ID: <CANiq72kYqPySwS8ci84CEsvjJqCTBjrveSx14xxnNWJZWRFAuw@mail.gmail.com>
Subject: Re: [PATCH 02/12] rust: num: reject Bounded::shr overshifts at build
 time
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org
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

On Fri, Aug 7, 2026 at 4:03=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Indeed it looks like this would panic with the kernel build, and can be
> easily caught at build-time since `SHIFT` is a constant.
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Do you want me to take it this cycle? And maybe the next one too?

Cheers,
Miguel
