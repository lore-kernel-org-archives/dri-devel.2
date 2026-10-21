Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16972606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=O0pXyXik
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD1E10FD99;
	Wed, 21 Oct 2026 11:44:34 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB7310FD99
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:44:27 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so491159f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792583066; cv=none;
 d=google.com; s=arc-20260327;
 b=VvESuMIB+Thcve97kcJpbMOeSAhVpYN79XrGz1jsP+V84fF/SkKxI3msJXnGiD5RL4
 Fxk2y1zCuJSaplaiRCiTnHOpyWMRogMOyUv6A5AGQP0WBAdheZNqekBpDBjFHaNH1Tuo
 Oz9VBtA5oJqzcGuzRTZWyi7tZt7deXrV5vLj7QHnN+7M4ocnsceMBRftsX+4cruvjVzl
 MifIiCb9pLXbBsB5wjCqRfQk39tjahzUhkFIJ4Rmm3VWGvD4tedmeNc8GwKrnlq2ntVa
 yMqLAbMpPU0tQfu4gchhTocd5ke/Vn4otG+7jK5gVKrZfEEo+AQaojNI7IA9MhZXgc/j
 rCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZZYr3eBHIRZzy2m2KZECWH5MwINu9our1XGNLE3fKJc=;
 fh=wbj4FPix1iKUDsRXrMuP6t1l/34cmNIyArvkqgjh+UY=;
 b=imgCkDk+m/MZ/bluvvmqkgtuBDLCJfWViVRzmgmDTRi65m6tolp8+vjD4Ig6GhlEHU
 a/RbnG4nIykN4seWMLOKs620HD5UWo3KWokIuG8Low8wwEmS25LyuTPhrdOZmXvOraHu
 wDzeBMiN+LQ7oOlqhNM1lvPCcT0e82d8bKzZ4PWlMtmYAmbxFHFj9PC3UvuzWWNCPpA+
 nuQgVwNOxlqM+DWUOTuydKy8xhYH8eioT36wE1BLfF3ALWn+5pHTGe0t6HrY1b/Suaeh
 A6DhfUpOMqpElAuY/XJ6MeIFjh7HR2mynAHHLE8KRNHTK6ySzkIt4k4u50H6kngufn8P
 zEEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792583066; x=1793187866;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZZYr3eBHIRZzy2m2KZECWH5MwINu9our1XGNLE3fKJc=;
 b=O0pXyXik8kAc1jOQioS7HyOpnBFuwPvJ4EhK54wdtZ3JeeJ9f8+z0UNp5sz9D+ur+m
 D8WLBKT5tg1EV8J6B5JPV2gsl2oZ7SrIBjmiBWSSD5UhDdEXk1b4GsqTIyJB3wkAMWdN
 dIVaxqKzrpey/jQBKA7EE+oXfwp9nXF1gOAOiS2jP4ZYxzrpk/wX/1mbcbSGiQvlgF09
 10ljxUWZiE5P2CnGfiq4tVBgS87InthjJV0zKhGD8RkUeKnMIL42/n7KCifGR3rgTIxP
 nWlbPplFQeJBLd4LvUJ07BSO11n3VCR91948qZFa4Rs50/q0MgA+dsQBMiRCMQXgJQGL
 LlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792583066; x=1793187866;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZZYr3eBHIRZzy2m2KZECWH5MwINu9our1XGNLE3fKJc=;
 b=z1Ke7zGf3ok2wUyOctDh2eqttRFZ71XQf1PyAFBKSxDNF70c/Ojewsk1+1fwjL+BIo
 xh0oankPBa+vDcHEIn725ld60tWG95V90rtiRT/A1eHzwKEPg+HSAk10eTBF/3SWE9Sv
 sPi1j8erK9cTXu3Kw/HaCTrJ3vHUG5EGIPgr0RnbUz0lDPXMaJ9IJRCV3EAgt209gTbs
 cSSfOvbvraRHieYzr/X72rvxv2VbKrar+vSBpbeqic2OdMJJCZ+uVYSSFsn+3QFybZb4
 oZg338GjDH0pHjZDSXgbAvuRecKCE9P27hpZFAG3AfS5YJ33ezPR5IAlG1+8/iqVe/hq
 9wgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByM87PHdZhRTOAlOf2OvTFcWkjqYjG+bbXjInx3d9wS5JYi/6UZ1ekgqq5iDQVzU/8Wk+TBq9kyu78=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLiB+iL8XieFl9nUnyj8RysiktiVH3aQcFuCdNi+MbuUHeC/O/d
 MO6yUIFEVyHIkJxFy7nwJePh4S/1gwtOTGn9S9ScdaZ52xkO6LtIP45kGjmKemFz4Z/CMi1dlW7
 rtzh4DnCNr6otERmT0/Gw3mhncGtrEGyJBqwBAvEj
X-Gm-Gg: AYBFou1/BMFICTSo4OUjbXjW+33F2kI5lNGOZf1kS0pNG7sDOtU2MemXhMlPRZlAjLJ
 O3WcVs2aN0vBuKeZ6DhkRJ1fM+1h8QMhIrvjgoOGFtHXniK3f3Gphk4fnEL7VOponlr13cCqUiX
 yze2DwA2045U/kxr94fcwdUFU+QxhHYzuGWW/Zl7nZ2i5H9sSnOPMdQCz6l9haq9oAYPIjjf1Hk
 ZHpB+n84Y+p2C6BOV5nOGSN235gS0JaZNOo/2zGIm3otGaSGwx5SmUbKujtRgUM3xwmGVDQBIAj
 2XZ8YafTk6ArTp9gBKpP4iKNOV49sGDbqucKSIiEZ4Dj28lDg5i+gSreI9ZK5Y19b9JPwlhHbIa
 1lFI4QDfltpKvyOH+qj1iMpSpO8vDzt/fGUl2NPSyMN32wJHlIYSa/qarw+Sj6RHfIOLNjvnNkd
 IAkZ/RIl6SjhmQZpxzu7UeM6sU/pVhSjtxFeTSCAB30ckpaw==
X-Received: by 2002:a05:6000:4a0f:b0:48b:e50:7159 with SMTP id
 ffacd0b85a97d-48e264adfafmr3173042f8f.30.1792583065670; Wed, 21 Oct 2026
 04:44:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
 <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
 <athToIRyTjSB_jVg@google.com>
 <CANiq72nP1cXVOQp0xciGfBhZZfEfNP5hx8c+1ZPhXwrr=EOUGA@mail.gmail.com>
In-Reply-To: <CANiq72nP1cXVOQp0xciGfBhZZfEfNP5hx8c+1ZPhXwrr=EOUGA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Oct 2026 13:44:12 +0200
X-Gm-Features: AclHuK8jFkj1SdL-sn9s7gZYVhHgWgNf9M81gFX7u1yfFc_Pok1tIoSVJ9rDId8
Message-ID: <CAH5fLggAuPdmwOFiOMMRUCP+yLPjmdjYGGfBxZJ=7+bkGODJmQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: add zerocopy to bindings and uapi
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jesung Yang <y.j3ms.n@gmail.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 1:37=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Oct 21, 2026 at 7:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Miguel, is this something we can take through drm-rust-next? Or perhaps
> > you want to take both through rust-next? Let me know what you prefer.
>
> Both sounds reasonable, so whatever it is easier -- do you think there
> will be lots of movement in the Tyr side?

If we're able to land JobQueue soon, then yes, otherwise no. But I
think we've aligned on how to get it merged at LPC, so probably yes.

Alice
