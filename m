Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F7606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqsxDtP9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D001910E6C0;
	Fri, 13 Nov 2026 01:24:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D52610E6C0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794533058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYneTTXCjtmbOlbjA+MpKhipMzV/P86BWbzDfmqFm6o=;
 b=OqsxDtP9VQnS8iG4FvnwXRLglR4QOkgSj4jvyobzCKFK3MzkGvbgvXRYNvZskzRzHB7V1W
 dujIuIVQzYpTLPjKmZUvGfG+4a10rnGqxY1AiPGqapkJLJejhwie9xIIGR43Aa3evcy/so
 IDy+/fsq568QujFFFR73U4DheZ/0nQ8=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-v8So84TKP0exjDjV7s14eA-1; Thu, 12 Nov 2026 20:24:17 -0500
X-MC-Unique: v8So84TKP0exjDjV7s14eA-1
X-Mimecast-MFC-AGG-ID: v8So84TKP0exjDjV7s14eA_1794533056
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so519887eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794533056; x=1795137856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VYneTTXCjtmbOlbjA+MpKhipMzV/P86BWbzDfmqFm6o=;
 b=yMx9MFYeVADSGRtZxEvLlY4AdfPHPJS9QOWfBGTa5Myqy1sw/ED60vrBMa7R5n47Lq
 0nrMGrFd/rJvbK8JveXcY/wl8e8eOkSIXXjg9rukg4spoYXEOAbY59exWCi7GQAP7XNC
 cmSxyLEZ7goq47dFO0vwJdzWExogAQxMmjmBNfJ9rT39UOScDUs8Ur/CSvmfZdTn3ux5
 Rfgh0RoJgQVjqp/p1Dfj32Z1mRu7scuMuXc3w2TSgV6pKjCmttERmr2qlqGQnthOksSg
 3hEYM9svhoICEAkLae1Eu3a9Z4YOlK+E5ES56hfxl4RNapMRMaYzDI1CB+ckreAlIXrL
 QwNA==
X-Forwarded-Encrypted: i=1;
 AL+hErG1q2Zumm6OXg2FAbODgmG/lcnvQ5jCIFHchB0A0Y57nNsj3F86FIFTuBvivjfEASZbTB1rMbV9kLE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+OTcqgGq6GGJfVu9fODDyhxmCA6A9gArt3Oh/VZG4+i0dUbTsZ
 7YlCgA+Ydquz3YoDDmDeiCfVwRIbNupmYuMvRovfWwDtqUhLHAClX5LMMWjaDF+7yR0Zj++vZSK
 /eMaiXg7MxQEGkDEbMgY0rxS4ABfchIYZJ4YU3Di4qu6XkbPEwDpvMUvTVHCqRA7q+4hAprqoXy
 dFw8EghB3D7EZ/7//c2NGhGFUCqDoiX0PdEiRQ3gXqxLlr
X-Gm-Gg: AYBFou1O+UBa3gvzSnwTBXCQ06CB84BfI0Zikdb/pgPqivHgKI4M90VaZtnNYB0DKeZ
 u3Cxe3DjbhDSnYJ5rh9QPupsxuMGBeW4ih3UO1aFlx4uftZ/mQ267uZ/LK7FpsrmBRgJk1tJBg0
 llYQPepezA3dP/sZ7MkW8r3fb4Aiqeto/u2RhJCfCIbd0a+8/U7u7Ve9gFlH8kGDEWZ5zkv+mb/
 yDv0E0ALKiVlGLl
X-Received: by 2002:a05:7022:f909:b0:1b0:20:6444 with SMTP id
 a92af1059eb24-1b50313d943mr1020542c88.39.1794533055637; 
 Thu, 12 Nov 2026 17:24:15 -0800 (PST)
X-Received: by 2002:a05:7022:f909:b0:1b0:20:6444 with SMTP id
 a92af1059eb24-1b50313d943mr1020523c88.39.1794533054920; Thu, 12 Nov 2026
 17:24:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-nova-timer-v7-0-3031c2476551@redhat.com>
 <20261111-nova-timer-v7-2-3031c2476551@redhat.com>
 <DMT9NWCA0XW1.936X5AXCNUE3@nvidia.com>
In-Reply-To: <DMT9NWCA0XW1.936X5AXCNUE3@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Fri, 13 Nov 2026 11:24:01 +1000
X-Gm-Features: AclHuK9rsswqzMyBRxjIm2gfwoldtH6M87AlEIZfwdKaC_-fdnm9ONrfhZkTVY4
Message-ID: <CAMwc25p3pENjrMvbYe=DMB+Nre44_Gx26h5LpTrCEJE3DujVjQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] gpu: nova-core: add support for GPU timer block.
 (v7)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L6pXvkS4odVGOBbkJwvNPIHVYI2Aat1r_ETRkhswhCY_1794533056
X-Mimecast-Originator: redhat.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:29=E2=80=AFPM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> On Wed Nov 11, 2026 at 2:23 PM JST, Dave Airlie via B4 Relay wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This is needed to calculate the system timer offset that is passed
> > to GSP init.
> >
> > 2 HALs exist:
> >
> > a) tu102 is the gv100 path from open-gpu, the priv level is checked
> > and the cpu time is written to the gpu timer. no offset is used.
> >
> > b) gh100 is for hopper+
> > This is the gh100 path from open-gpu, where the secure system
> > timer is read, the offset is calculated.
> > The offset is written to hw offset registers, except on the
> > original gh100 where a workaround is needed for older FSP versions.
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> One last nit (which can be addressed upon applying) below.

Thanks, fixed the nit and pushed to drm-rust-next.

Dave.

