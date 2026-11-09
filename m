Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AA606A320
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bjzJQ2n+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF3110E546;
	Mon,  9 Nov 2026 03:10:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D64310E546
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 03:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794193839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tW6nGmM8EeKf4Kx9zfqvxzBQJe7+fMs2MouFfO3xxR0=;
 b=bjzJQ2n+TGBL8aU3rKfyk4sDnUdQj1VtfJ6MbofZ1qUBmopNQhfXo9lRrbFmnjv1LHBbBy
 v4eH+S1JSMms0qBlwBC6M0jOqqBDvMV0JHPMIk2bFABAARFyrdBj9i8Px7um/+RVXiiOy5
 EjnNoml8dLeJR1d7pxAJ703kUlxDdI8=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-HFa0LZ0wMbmSG_fsqJ_vQQ-1; Sun, 08 Nov 2026 22:10:37 -0500
X-MC-Unique: HFa0LZ0wMbmSG_fsqJ_vQQ-1
X-Mimecast-MFC-AGG-ID: HFa0LZ0wMbmSG_fsqJ_vQQ_1794193837
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36d69ab3c2bso702867eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 19:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794193836; x=1794798636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tW6nGmM8EeKf4Kx9zfqvxzBQJe7+fMs2MouFfO3xxR0=;
 b=xZEsYKS3xrrceM9u749oAX9fn88UGokjK4/JbAP7rvCVRUVn2M4Ca3nKoMid2gRTTb
 7sxsBnaPVjwjFbqodjyz5zG/XW3O3BjMaHGZ70i49QiYhOOV5jwyIoQM2AJ2FNydlGHg
 Lg5i4SA4ifsEFG292NgW5dZCmSz+LK0HZxopSQlCrhVtIQMxTmQ/x8SrO2EWGzZ1SJSD
 ACMGuPdQlJmckhKvUnHKUj2Rjj9cv5addhu5a1pfAKcgVuBnkxpKlYI6UtgF7KgUXYKj
 NL/WrhfIREOuesNCWcp+OvgNIX8vV/FtQsTBwGcBXClGFkSKOCWy6D2VPuDSDKOcmPYd
 4KaA==
X-Forwarded-Encrypted: i=1;
 AL+hErHY4ywUPrs/aXsDkQQhjMyj/e5IQDZN8FzvVnHFPQFPp5FXvPdJ9JAcqF8/MfgtN1waKAvY1SDvwyU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9oHtSS4V0b4/GsmJzA8yOIW5ApcJL+mKhGczxskv5/TQP/S/go
 OLtjFhjMD09evHOmYCWoN4A3zfSf1aBMieVZZFP553sVenVr5fRVt8mswvdmpaeBCcDyOpczPks
 RQYHog7PTn125asDo3tz3pPdx9SnwkHi2vuwljZ2KLr28eqSJ/MkrzcLYuj5us76NiR7zPYEv3N
 gfepBW1PniuK8Y2e9dnKuKSuGiKOL4jGlepm6WIi6gcNvU
X-Gm-Gg: AYBFou2JySVXdwo+hz/YEe8mXwaBHymGtBRMNYg5KgZkLZ66ZrHsoVuTy8RmVCzpO6f
 aBarT2ixjeTU/UEYuEfJN92Katk6FQnORlUSWWO/OJdmgfZJ+UNADfGGYsNW+ZWjtv5PatBMrsG
 AsS6Ey2DCMVPf4ItHBXpoiEabCkyrTWGerKpA89++Vc3kS3gE44pNJmlhNXwBI0hue8TXMP+0gX
 RcORPCFbA5yr1Pq
X-Received: by 2002:a05:7022:1701:b0:1a8:ff0b:a4e1 with SMTP id
 a92af1059eb24-1b39fe9a6f7mr4227468c88.18.1794193836371; 
 Sun, 08 Nov 2026 19:10:36 -0800 (PST)
X-Received: by 2002:a05:7022:1701:b0:1a8:ff0b:a4e1 with SMTP id
 a92af1059eb24-1b39fe9a6f7mr4227436c88.18.1794193835747; Sun, 08 Nov 2026
 19:10:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
 <DMNCVDFYPL3I.3CCYXY4641F13@nvidia.com>
 <CAMwc25rODe5F7MdhWEr80q+eOitKqg-O0LQhEWOMSVWZodfyMg@mail.gmail.com>
 <DMO7FUYY05LK.123ZPLIW24C2S@nvidia.com>
 <DMPVN025DBS8.1HVI0U45RAS5J@nvidia.com>
In-Reply-To: <DMPVN025DBS8.1HVI0U45RAS5J@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Mon, 9 Nov 2026 13:10:23 +1000
X-Gm-Features: AclHuK_55-IbEj0SHASbnczQ15jOjxzPGzrLVLoFZHP1WelyYfdlCxNf25lfq2Q
Message-ID: <CAMwc25pL8fY=Z6D5wKZ5vFhv_438dp0Vm2Uksvq4db-jDZSF2g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block.
 (v4)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: usaZBFcF1uCVhC1w6tjSd0I1Cva-RawDBpFdy8qhCeQ_1794193837
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 11:51=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Fri Nov 6, 2026 at 11:41 PM JST, Alexandre Courbot wrote:
> <...>
> >> nsec_lo/hi are now used in the register from_nsec for both tu102 and
> >> gh100 registers.
> >>
> >>> I'd ignore Sashiko's suggestion as it looks like it is trying to
> >>> reconcile the code against the comment instead of the other way aroun=
d.
> >>
> >> I just fixed things to truncate and used wrapping_sub, to be honest
> >> being careful here is probably the wrong answer, my local review bot
> >> pointed out some wierdness can occur in 2043 with the current scheme,
> >> so let's just keep it simple, wrapping subtract, and feed the result
> >> to the hardware which is what the other driver does and what nouveau
> >> did.
> >
> > The other drivers do what they do, but here again do we understand what
> > happens when we write a wrapped value into the timer registers?
>
> I checked what OpenRM does and it doesn't appear to wrap. Actually
> `tmrSetCurrentTime_GH100` has the following line:
>
>     NV_ASSERT_OR_RETURN(secTimerNs < osTimeNs, NV_ERR_INVALID_STATE);
>
> meaning it expects the OS/GPU time delta to be positive. The error it
> returns in that case is ignored by the caller, so nothing gets
> programmed. In the absence of a better alternative I guess we should do
> the same thing, i.e. the `checked_sub` and return early (but the
> returned error should be just logged and ignored).
>
> Nouveau AFAICT does not write `NV_PGC6_SCI_SYS_TIMER_OFFSET_*` at all.

I did this in one version, but this seems to fall down the systems
will just stop working at some point in time.

To be honest I don't think OpenRM is doing the right thing here at
all, so it might be valuable to find out what the hardware actually
expects.

Like if i'm storing an offset between the system and gpu timer, why
would I care about it being + or -, it's an offset just handle it.
It's why I previously used i64 to calculate things.

I think the wrapping sub we have now is safest, else at some point
someone will change their clock and the GPU will stop booting.

Dave.

