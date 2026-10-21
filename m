Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585D2606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iSVbx2+M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01C610FD8A;
	Wed, 21 Oct 2026 11:37:55 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DEE10E132
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:37:30 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-34c522572bfso68665eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792582650; cv=none;
 d=google.com; s=arc-20260327;
 b=UHLnrm5Ya/3Z2A44XpueHb6Zxw25ekM/pltUOiepq6lVehv0erpr1el2X5FvtKxh1y
 ALnuhxv89Ife/jNWryqm9jow99inKF6hlqYx9z2Ok3uXhP9+ITzA2XjlCw91uFsTBUdA
 dIEgy3kL9mkUFOoBlOe/ZWFvjlDf4B1jZ0FiObfEHLPfjS8WjZh1c/PFI+w5CKuHgCZ6
 AZp9bBC6pG6HDUF2mLnFx+jj4Tq98hZlJMWPXWA4A2W9gP7ZuFAi//Zj5Zgh4+8Pms6/
 eHfy5zAfktUFEt48aV6bf0RBx3ZZ03XrLvGaS26eEVQ2ljodrzLQKGjmOX8kHiyuNgx3
 agDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L9TNqnfcFMmSJAaSkxyxoiwG4lEBGzzPIAP5LrLyRIg=;
 fh=Es4Mx8KPyteGhhGVShmOcKHb/sHVzDCkGcOy83e1bcY=;
 b=cgINMa2I1+15t5BJkhWGPm+VOuGbGXR5g1YyaAvF6Q8BwNI13lbpkbKdfoaLc1eCMy
 DmCKnpPW2QnNVKbgUPppc8YrqbFvv8i0TRCM4ZptMIj8NjZHZ5fMPy+7ZtlxFL7n6Lhn
 yc+UqcsnCcfLS6h/vg9KmEX+EGfrvbkGmi3paKFeEtaulzFxj71o2IOskTq9SCWpYiVv
 6W7d8kayuRWMhLI3KbMf1wvcTqp+b6hCYtOz1Y1U8/tg5RoHd2TAqQ95L/zLcqblpva3
 LLy2eOiEtx40GEjRt6ffH5dffZptlM6gSmAQRqy/dC/FXp/0sgZCLi+5IqBjts46WUmz
 CHKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792582650; x=1793187450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L9TNqnfcFMmSJAaSkxyxoiwG4lEBGzzPIAP5LrLyRIg=;
 b=iSVbx2+MTCquHhs4VCuj5P3ypIIJ5NNI7lKLsRSfK1v+9nK8x58TSmN10uVgq+OCPD
 w5p6wVXhZEv5mzTaSF/GmF9B/S3vTtK1uu44ZB8enQ0+h9vFXoVKXCM8fmUVnvyMtwXT
 YPrzJhnx9BXTFQYUEAo0E9GTU+/u7/leoK3N7w7kfUcbDncVEAGR6C6xcgKjJacS+wLw
 e1jRfowsqvmnlYTI5blmkTCodwSgaytRFf0E9h02zKT6xl3Drf9qYUH0ho618wcJsotL
 tjeEtrCOeGaT7KLLi++zROaYZ/Wa6Xg0Ljk37LJB7vkq0heZVFYnxeKwFzST2Om6g6c2
 GlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582650; x=1793187450;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9TNqnfcFMmSJAaSkxyxoiwG4lEBGzzPIAP5LrLyRIg=;
 b=GaxGqQyNR++NV9sjBgi8WxHxLusCj/9gDKEJ80YaZxyJ86DgmKbSASqxpUiXjgOVv4
 kZgrlxZLifDx3kbf4EO45UIq1uIutwj4A6mpciBdOSCT3m8Jyv8W/McUhoSHym5T7uxH
 YYnrXyN3dKhldEzr/KhF/8xO3eyv17lTJHrU8h9GQOj6LDTuQ5jgOgB9buhuTMOPiTp9
 6/fiUry0XuojbXm129YJZtC2MthR5PD1oId11apmf20H8pMnkbDuw+Z2LBFn7qFhnvB/
 AnAIXrJ9azOk1aNOlrg39xGR8gQ9+dZHkai8wcTTEqjyvXU1HuIvtI68mbE5PKAcfubG
 n2XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZykie0LVsTaFhOJmCerMVaqkccMGqtlGEbt8XC8oVUp5VEFfUwpZo6rClE33ffHlPyMfq8vq+NwA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIpgLET32jg3HC9M0+Bd/h2/q2SqhORfBjX2QgdBfrNau2b9dJg
 f18fRtVsIm4lDRSzq87PvgelghNHzBbUJSHzUpowxHLvoHs+ueS2l87L1tTDZd22cIJD7pCMl79
 pNKSN2lM+mKT4j16CcYKd8p0wjCqTDYc=
X-Gm-Gg: AYBFou0jd0PWxKNxGC4oF7TG5/xpAqLmsWewc+iKqaYzgpvs++ej6omH8bWTjlr3dad
 rab/An4jsXfHK5QhVRFNjGCv1HtWH2f1YvDc7WH2b8hse5U7EEr1ef0ixUQQkOh3KUS+WenDw93
 89FoMUp0NhZBONXbPiolAtwpw4nm2OQumZ+Axf4Ay5HuOd1Qsmwg7dPZHI95jGGLOalodgSVPKW
 S7ZLs7+WeeBV6YPygKZMEu92+KFsB7hOixGx6h4N2hDaC2eo6HUByClrZHzG66JFJHzmKfp3KN0
 /o7FAcPC8gs7jCGNax87B1kT5+W1P139AeDA5woxUtzITaXVfK4BI4L+v8ToZFIUFv8gyNvULW/
 mjUzaNww2MVgexfIjICq0QurmiQfOiWlu7xsixLP+xIcpu/WyxwsHZnJJ5T3TeP6dMGRLnx2B+S
 AfYjVDXysA1a0BOIuaNKdBsdS8SrAZwRCmtEUL2lmqQ3/fP8v0tEQNtdhTrIxnxqtITqy5JCujp
 C/LYggFsz5MH+AfYt5UWDnhxvW6lVe4hj4n
X-Received: by 2002:a05:693c:821b:b0:368:2548:c08c with SMTP id
 5a478bee46e88-3682558082fmr823558eec.1.1792582649514; Wed, 21 Oct 2026
 04:37:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
 <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
 <athToIRyTjSB_jVg@google.com>
In-Reply-To: <athToIRyTjSB_jVg@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Oct 2026 13:37:16 +0200
X-Gm-Features: AclHuK8_aYwJYOtfW9noTsKcimxOtxn3KEZMWBPUv5CixPzxJgOV79J2faUPU-g
Message-ID: <CANiq72nP1cXVOQp0xciGfBhZZfEfNP5hx8c+1ZPhXwrr=EOUGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: add zerocopy to bindings and uapi
To: Alice Ryhl <aliceryhl@google.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 7:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Miguel, is this something we can take through drm-rust-next? Or perhaps
> you want to take both through rust-next? Let me know what you prefer.

Both sounds reasonable, so whatever it is easier -- do you think there
will be lots of movement in the Tyr side?

Cheers,
Miguel
