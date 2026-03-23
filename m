Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA86D58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D5710E22C;
	Mon, 23 Mar 2026 01:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T4bResP5";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF6A10E22C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 01:39:03 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c0bf0a0236so122875eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 18:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774229943; cv=none;
 d=google.com; s=arc-20240605;
 b=hezU7DPdUSQWGyo7k8RKTTQT2APvn70Z459mtK9Y0Jx5a4DPV3/U7CaiYRFrzeJ0XP
 1YK+TuXnBIqO4EBIJt5+1E3BOKkpi2UfNjbfjkxCh6hzcXTYjqqgjlfFDmVREbYNZeZb
 AYI+QkElebS2OuGpJW6q1LAExR9r8ayZl4ap94yQa986DQ4d23HOutXpF/P8unNEH9lw
 QAQpS7uCEY7FPIXwZrsfwkZudJZ/fJl6sv1LiYQEGZpSpDir1NI6syZeJ9zb91GX7Q93
 HxXcZ+VC9ituzkEXGwEG2Gm5RiA3GVd6oTCl+tdj94rjEF56cGMpCZ1wE9gdlzDFGBYg
 TNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
 fh=zSXo6kYNgQrvH/H3MZgRdBxpJvbj/WJQolkEaLllfY0=;
 b=CVt5TrKjZspO9bS49GwQlUcqdLJAqQtmWHnrghmnLX3gfljYUY0mrwQ+migAeDFCV0
 CZQbVhpr57gDNnTUJ6ArfSYFIeHyHVt74zxjsIGxLOSqx6xXz7bRrioBh9jJCM0siTH+
 yPGYONihO5FpQ63TgV6L21830nYuGlhzW74G+iadNA1qpgGsFxa0xW6v5RTjUdSfXxgD
 fovJk4/0J9HQjy2Rwc9tkjTNlKJnjxSF7KeZ0Bn4dwUWk7AV6z5MUMQLNiDfxpc8Ng9u
 Le9akvnsopFqYXtOywy8U/OcSgEwycCGJWbgJg1+EDIY5UBIcpeCBvNrGRbkydoP/xAs
 Cd8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774229943; x=1774834743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
 b=T4bResP5bSsY9jkIfy0jNBAVViIz9+RUxKyKIYYanRUaZl3ouL8S/MjzN5luT0woTG
 W7FOXEWi8NCFquNake6/UWdnzzRuidTV2HCn2j7UgKosD+QAqs7t1tDxZrRzPhsWr+9P
 kpOZ063M2GnHr+t7mtZd5Z08T/3GDBH/KM4q2g2ZCJJ49FkN4eJewyJNlaMhZodXRYQI
 J0D/c2oZybJRXljHYx6YlmUg5+kJM5tynGxBdCg137k3cgHMUzI6owMfFrNBjsh3og6+
 BN6bNT3f1HzBJ3U7sDuXnB+mD+vt16AxXO2bI1yiZMdNOKp/WHNZ5K3cgga9RFvxllvC
 gvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774229943; x=1774834743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
 b=HHu+L35EurqdrHSbCbL7EwiTaqtulBJuSwRibxen4IrPgHTlyjcCMkGuTxIsZHc5vU
 mUmbmJrhJYd3j1S+oDQukJz0WrZKticvARGJzJqj7OzSAFuF2ZeIqLEzpzs15NE8ASlZ
 VmIL5UDzQVzX+6C1vWKAViAcl1CCEOdE93gwT72x8zEj8s2NCGzy6rgBTRaL3zBvG0fI
 jGyZmXILiQfN/J6OjsZoYuN763BXj1F85+P8JiQGDY6gFHhKVU+Q7bwYMhaTAaS90mg8
 Of4kzUHrUGMXDHIKxidSGsm0vuXw5V81EapuHMtEa5LDS7Exjb+QLJ9bZ3strs2lM3Ck
 JgrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHKS3I8OWb6XGqt13D5PLh5b19v2kVCn+HJzX4wQlgr6ogcG7G1ccu36Tcs8x6SEb0VmBI4O9A5eI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCaNhC3ScpP1bOQXaviglmhICr5uc3INCK8KrWx5514wRXzS3Z
 EpOKcXwsQKfALHZe/CPyXGKwuZ6+syVr+7yvoU46jZwblFZVM6bt2f6dexsTThE/+yITYYedKiO
 4yViph4k8Bp/YE7AQfc++Rnldltd6lmI=
X-Gm-Gg: ATEYQzy1pX+gL7A6H91DpjNvujjn+TfR2wH+vrwAB2pwqZRGbc7N5aLFV0dAvHRf8SH
 9LSW2Lc8O5UnD2gE6zm7/9/cZ4OsoMuQgXR5kCRa+At5zwRwFIrag6lvtChGbQgRTyHAaOMGk+d
 gUi2R7ltBXW1+r/S4QIebZLadseDBPdVsATSLsPXVB81E9cCilzEfSy8kf9NuHMX4yT8kVQjV2u
 z834YpDdUQVVTBGYkKJERVLl+jTLV2fo61fyHWCe0eMdx2HiprqsYPoYVqvqkJj7LwT2gXPZUch
 HWaNL5uJ+sw40fh4hm/WR2cuPelIh6NjUd09wcAHuTrsZ8gGLr8lL+tjUjaSkKn4m8Y5EM9km/B
 E2Cy+qHDuE1PjQA1PT1WNVIQ=
X-Received: by 2002:a05:693c:3118:b0:2c0:fec3:fd2b with SMTP id
 5a478bee46e88-2c10973f6e7mr1912078eec.5.1774229943149; Sun, 22 Mar 2026
 18:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
 <DH9RDC77E3NE.3F8BURMZ8INBX@nvidia.com>
In-Reply-To: <DH9RDC77E3NE.3F8BURMZ8INBX@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 02:38:49 +0100
X-Gm-Features: AQROBzAdgpVg6NMG5khS7OAHwybEFX4tptApRBIZ_6EE7KPQ0oZWmoN7Dzb4nwM
Message-ID: <CANiq72knM0_w_eHbu1qV2Ps8KbST6KcAZRtTH9FEd_5sRMqWdQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Tamir Duberstein <tamird@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Yury Norov <ynorov@nvidia.com>, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, netdev@vger.kernel.org
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

On Mon, Mar 23, 2026 at 2:08=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>
> (sorry, assumed my Reviewed-by carried an implicit ack as well)

Ah, I saw your tag for #2 and #3, but not #4 (nor #1).

Did I miss it/them?

Thanks!

Cheers,
Miguel
