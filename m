Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE29606A326
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=darkrefraction-com.20251104.gappssmtp.com header.i=@darkrefraction-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=prDbIRPU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8E410EA16;
	Tue, 20 Oct 2026 14:37:25 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2331810EA16
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:37:20 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so4425470a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792507038; cv=none;
 d=google.com; s=arc-20260327;
 b=kVeWlqA76sazDUjkXcWR799YMAqYCvoW7i89cKXdtO7GIngZ4d+r4p/XLOkje9mwXH
 xTmSO8SFid6yGscjbFVHRFsu9XzXMQAIpkvDecddtpxH5i2F+NoFKeSpB4UlNGfh8j9s
 W7Fiqn0QXuOoVZ5BQA0C5/4CyRPzd9+zpwcBPVzqpkFTPOUU6Y53wT/yoLWqwhOQ0NHk
 6Avc2KRosT7EReWoJTR8wGKoK/g43klb7yVp4P/xfoUrP88bI3iwOY7b5+rIzC6im4yw
 YtFEWlvy7RJAQwV0wq/W6wX/uCd9GaKy3k6myWs1iWfXUXheA7Mn2qilUp8cEO/5YNNs
 7D/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Th2n2oDQlswuf1BVeMTn3nKsEA75XKAvSzInb/NsZ8c=;
 fh=vc+yGJGfAe4eni7mHnmKX6pX7gTBhxCeoVKuSHXmT/E=;
 b=ork0cMT+h5yFw9lfx/d+A+BXF5/fkCYXDolDLiQw57SFNrRqK2mc8jlLv7n8WCwJ2N
 gOdC4Hnd73q2Yge2Ln0daxJVzewoAr4UyccEwCDgTl4uNT9aUKnbFKB1uQEYLyHhEggY
 YkDw3dY8DwnnAL47kf+f7lWvQUJNUwLttPmGanK/YApMl/BrgsYGEVoGgtonJgPbZEUA
 i5SsUz7AFriVcQaxtF6QLderLdq8PtdNcS4X5WFpeUamnuMUg4ki/F6v5NY3aNKVxL9h
 9FAaM/VZvnXXqvTW4TbcU0oWw84ESDNRTp6U/k6g8pnk+3lfVGj6rvZ4IcfFnB3/jS51
 6rdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darkrefraction-com.20251104.gappssmtp.com; s=20251104; t=1792507038;
 x=1793111838; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Th2n2oDQlswuf1BVeMTn3nKsEA75XKAvSzInb/NsZ8c=;
 b=prDbIRPUe0yQ1ZzACZalNU++4KVMO3vkAZOk1LHJMRiiLuH5D1qt2vhN6GLzYxXR3Q
 ocFhbBOhs31DcFmD8G38Tbc0whHkmLgT8lhkgwURlhEkQJBaxH2qq9PC+QLIldnFelzO
 8amoKlCXzOLAu9Cx1ZLTz8M2Bukn0FlLHDlsZ3enr7E9vo5j0W7uSr4w2mnK/piwyLmB
 iuZkCmTr2Mo6coWDDVpjDoPvHQbNUWBsWpIijqJHawEXmLZLJAwdKw4lOIXC5PYArJDb
 IM4xDd9YQvRHOQq592kiBxjitMZh+doOFyrQ15KiO9Tzfk4LMX2vwtxw3Bzid/PvuwpA
 SfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507038; x=1793111838;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Th2n2oDQlswuf1BVeMTn3nKsEA75XKAvSzInb/NsZ8c=;
 b=mDt648ozLdV66wSyJpZqs8uggyS8cPtW/RU5WvRTnWypPuOZuprwQad5g18EGsLspy
 xW4iQvey4lmfwztjDMJjteex1a8+jYk+SdXK4I6WZTr78f2qPwlL1XS0iJbV9DjcB/Rv
 nnc6O8NHbzZQyO6BS3pASeo/J/usEnTR4gz1eSVl+NlVGWUIs5dlR4yqhvvjnIM1NF/j
 xTxLbSV0O29lgqTk2KLwIYl92u92vnj9A99y0lXbI0B0gXG0oN93q56IQM4AyAjt/DwA
 GfzkvL9JO8CXcdSqXdi5W5DAjEB6Ryd5JnIjxfNuI0mOsXFVsb6hgCZdxWqal37iKwtF
 QsHA==
X-Forwarded-Encrypted: i=1;
 AKwUvByf/iw56X2FpJeERqxYiI9hxDi03Ygwe8qQhOcWsRWTqKCRag6TyuoUt4+KJlwdjBHP1rklgosSWIE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI9G93Tsz4BGl1MR5PUm2JH3HYPqfW4cYfsdL9VHJqngPJXKXDf
 PNFabZ7VMt9JsujBLuQgipG4T+IKNPg0INF2RZ/6B3193GSd6CoCRcfBYBqreOLyTuF4VCSE2Ql
 Ezij2fQ04yzmT2fxQVrkr9Ncj5NGUHyG7GKC2hyuRWA==
X-Gm-Gg: AYBFou2H13XW5kjYHzxGISoI42q9qYfhu7GG2ImNlhmNpSuY+ShigVKyUfyvbHfGVgF
 WqvekEY9NauUPNRGHG6Ta5cvnvEGN1vr8HitJ4EwklrTb42iVySshBTKkKu/8CFiaNiXK9wAuA7
 wVeA8p6RjS+LDW08WXE+maabDx9A5bKpoVkyZYqOby1mP0mk4Z44fKzVIquR1VuITTUzVP7FH1V
 oS+gjUPQFdZ86KG+uvqpckj9c7gIPXiLil41v7C+As5xFf9ww7jAgjLaqZk9hAl14lIx5yCCPMy
 MOswReM5yyOqNnYmOeAydzy4rCw2/MbUFeycVv8isXDtRD6u7SwDsKuaLA0bjrP0UcOqVmb7A4H
 Uc4e9SRu9yT7F
X-Received: by 2002:a05:6402:46c3:b0:6ac:a1e1:3f88 with SMTP id
 4fb4d7f45d1cf-6b3e479af2cmr1805659a12.14.1792507038070; Tue, 20 Oct 2026
 07:37:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212535.88390-1-dakr@kernel.org>
 <20261019212535.88390-2-dakr@kernel.org>
In-Reply-To: <20261019212535.88390-2-dakr@kernel.org>
From: M Henning <mhenning@darkrefraction.com>
Date: Tue, 20 Oct 2026 10:36:52 -0400
X-Gm-Features: AclHuK-6VS79fqbsrkK5l4dmV47FN6lL1AdlVauDg0y-CgJGi7jnOJDni7bx-HA
Message-ID: <CAAgWFh30UryzqyU0As6qi8AaHzQbO=pp-Y+gWMs0ap7i1D4qKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/nova: mark the uAPI header as unstable
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
 work@onurozkan.dev, jhubbard@nvidia.com, apopple@nvidia.com, 
 ecourtney@nvidia.com, lyude@redhat.com, kherbst@redhat.com, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 5:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> The header already documents that its uAPI is unstable and intended for
> development. It may change incompatibly as it is developed upstream.
> Rename it to nova_drm_unstable.h and move it out of include/uapi/ to
> make this more explicit.
>
> As individual interfaces become stable, move them to
> include/uapi/drm/nova_drm.h.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Mel Henning <mhenning@darkrefraction.com>
