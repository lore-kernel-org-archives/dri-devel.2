Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB5606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZlarZeFd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61AF010E401;
	Fri, 13 Nov 2026 01:24:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF6910E401
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794533033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DsXff4wUSwO9ldrbmutLQskXhM3zDPw23zXqnnHOUEs=;
 b=ZlarZeFdv5S/Tob0bvl6WaV3wlM5kQJ3JJCVM1Okryj6nmEWGQvgGG8Z0bMqPzOjKSlCzd
 YFWvvtBavtD9B+Rj2YYIKtrfemJB0Nlhdcgx0u5Gpl7pBXKxJHKFcJqeQ8gw+knWfYLomE
 IgzGumG/4dSeLLkSp7zf5v0BhHWTc6A=
X-MC-Rep: binary re single
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-HoSpS93XOEuTOIsUl79XwQ-1; Thu, 12 Nov 2026 20:23:51 -0500
X-MC-Unique: HoSpS93XOEuTOIsUl79XwQ-1
X-Mimecast-MFC-AGG-ID: HoSpS93XOEuTOIsUl79XwQ_1794533031
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1a2af4c8cbaso241609c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794533030; x=1795137830;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DsXff4wUSwO9ldrbmutLQskXhM3zDPw23zXqnnHOUEs=;
 b=a1rn4cmZ7fDV1Y2m4Ddcag8+aDaYPGDkR02DFL+iatLcWLdHXZtHIF+Yy/EyFZd8dj
 1ewAw57HX6NwjkaKCNeq+r0iPxMQpzGSGSAgkZXoYtI5qN8fy9fmuUDAYmQ123VYXJgm
 syOv4wY7hw3OlMi32whyVKPnA60I63Ou7VMbg5+2j0IwnqsfneHQ2zqYplb0mb/xI/yt
 C3HEWv92/Yz1aE5MFZsSZqRX8FvpFnNN2AkQ09qUC0nfEjS6ya215BcnY877CbIGvH7I
 dm0sMdCQJQUhOyQTjtkRNXEQ4OIGEsxnruGQwjDyGZTz2M7tpNscZZcBU99B9G6C488f
 YjiA==
X-Forwarded-Encrypted: i=1;
 AL+hErExxsMvIpf6pSkgkav/o9koRc6SXT2JfxO1aARqH2QCuIsh0gZO2ruURp0gSeKctS/SNLFbgTIsYFY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ek23UdhnoCplrSCGZG3DUDBdN0ZFhnJVmG58lAhNZFQyqdAxt
 zcqO3ULRvgYiEy8e6RhXUe8Cb5xhkssI7VZvT2a14ZP/U39Qc+weLEUrZ/fCUJ10mJDDLUmgGIf
 yVnj8rAgJ8uZzB4dN3o8A2phhe4kIhkfgA35SBl4ljPrEtIM+LwOinidK7Jd/hmVAm/TBwCXoRa
 witlGsmDAQFXKNdH5OZp3oRgTB7D3BJflOz1F7eIOhP9eG
X-Gm-Gg: AYBFou1ceZegX8L/uMKZeBXUVDkqxG3l9o9nfWYBj89Oo/bpmFuftbpYB2V1g3NWHrG
 /HsOWfTPTdICSfz6vILhRphc5RRUW8gInhGcButPJ0FO9FDTzPegwlsmhf1+jJEh/bXocLCu2Pu
 TJq0paWEcS6+UKCDMkLOzMA5Qv2YBxxJ9Z/+/DjAiOF2tbKTy6hXk9xG1Mjgzj5e1BtK7OveYs3
 RmVfBFCTChjwB1H
X-Received: by 2002:a05:7022:f106:b0:1b2:3bdb:35cb with SMTP id
 a92af1059eb24-1b503098c42mr1091836c88.11.1794533030238; 
 Thu, 12 Nov 2026 17:23:50 -0800 (PST)
X-Received: by 2002:a05:7022:f106:b0:1b2:3bdb:35cb with SMTP id
 a92af1059eb24-1b503098c42mr1091817c88.11.1794533029655; Thu, 12 Nov 2026
 17:23:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
 <179448764517.621816.16006004780926601543.b4-ty@b4>
 <DMT91N7BGPUU.17BEZWQDLH3CC@kernel.org>
 <87tslmupje.fsf@t14s.mail-host-address-is-not-set>
 <DMTASPUDKG3F.1H8JUZ5C0A2M3@kernel.org>
In-Reply-To: <DMTASPUDKG3F.1H8JUZ5C0A2M3@kernel.org>
From: David Airlie <airlied@redhat.com>
Date: Fri, 13 Nov 2026 11:23:35 +1000
X-Gm-Features: AclHuK-zYR3AUvkF_u5QDgTC20BaU9keQdeygM7H-nBWqghbHRTVA4F7Q-vtAO0
Message-ID: <CAMwc25pvQ6tz7BBtKT4RGBmjnUZC=ivOQHO4M=3EHeASs8WEdQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] rust: time: expose as_nanos for clock sources.
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Qc4CQqrSRH6J9f37rsUlTU_gqzSoFFQo6nsNCExZ0U_1794533031
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

On Fri, Nov 13, 2026 at 12:22=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Thu Nov 12, 2026 at 2:50 PM CET, Andreas Hindborg wrote:
> > "Danilo Krummrich" <dakr@kernel.org> writes:
> >
> >> On Thu Nov 12, 2026 at 1:47 PM CET, Andreas Hindborg wrote:
> >>>
> >>> On Wed, 11 Nov 2026 15:23:24 +1000, Dave Airlie wrote:
> >>>> The nouveau C driver does ktime_to_ns(ktime_get()) to program
> >>>> the cpu ns into some hw/fw, so allow this method for rust drivers.
> >>>>
> >>>> This is needed for following nova patch.
> >>>
> >>> Applied, thanks!
> >>
> >> Do you mind if we take this through the DRM tree? Otherwise the subseq=
uent patch
> >> in this series has to wait for a cycle.
> >
> > No it is fine, I can drop it from my tree. I asked on v6 what you
> > wanted, either way is fine :)
>
> Great, thanks!
>

I've pushed this to drm-rust-next.

Dave.

