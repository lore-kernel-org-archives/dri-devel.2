Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD641606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RdK6p72r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039FB10EA9B;
	Thu, 19 Nov 2026 05:46:05 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D9810EB84
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:45:59 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-533202fe429so171561cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
 d=google.com; s=arc-20260327;
 b=FpVKovc7q/47QU8hX2tPLww/FNkCYRDtqUIU5/Pp9B8unDprD4HDQq7u1gpCFixvNl
 xbQiLiyX7VnVp2R02fDS4iNN+lE2J4Tl6oqabtQUdLW79L/PwV8MQClXFs2UGvAxqmb4
 tpQQpLw0tdZW+Vr0qElxSbHUTg0crgfHfYQepvDAqgmtvPVs4zqAT14PDtEPaP0Qx+H4
 Xg/o56Tm7TeZTYJJ0HlEqp3+tFSRNhOQjMl0fA3iv3bzVNYfYN8z6MsESpESa1XsjMlq
 X4x4aicxpDLjwbRalUszqSNqW0t22IPRuX9P/lZy+ZzAzdJnRKcvDg7buI2TOFksj+H8
 Q4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
 fh=W1VD7M5g+jJmaydU/DX1/Inj7fMupBJhf9jdnK/y1a0=;
 b=VyzZQyls3qCRNmR1ObeSyZ2vj2GFSnPFrexhiVNP7D2i8V07af15fwCFU2cHiRWsqR
 aYPiBVW7U5o9Qr/palSsyr2336tZe8FYEzBcOs9ca0kEn0zhCMTNY0DxS/e/ORcAsFhe
 xVaWfjMX2sBIV0WLSzILXdxKtqFSZ9co1SN9X8Tls1ekD4pXRI7oVsbelNOSzgakW/HT
 6p+pPxKGn32iuyd4tHPMUzPOV0UdqZCAK++hiuzCTyD+OLU4e3I9lEBE0mFM0uxybgSs
 4tJPv7SutSWuRm2O3tVV4YTyPM+TWpGU1nTozZjMCD3do+PojovYyTl3cI19CPImU0wQ
 IlhQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795067158; x=1795671958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
 b=RdK6p72rDxBl3a+RRoe+4d9nB67OkqHnrvJa6hds/RHNthdElJ+591YF5PyXfHVArP
 pQ2igpBBnNSglFmgMMQfNX9Io1gdBOKuPo7I9/GjgnP3oDPsrqSDlwrk9aW7/fMKvFi0
 nxfgNZ7/yInih4EdWS/SOGTo/WaMvwngcRPRjImZxgN582otGkqidnjNJYV9qieNCYDh
 vLOEHIa1nYngtIW3IkvtqhPrbvYWvejBCyM7WYhSSAUQzyU/uesRSwjhZ3YgkHAPcMqt
 saJF1nViN+J2wYQocTALx15qXGIrfW++jHSYsZRJhg6YsNIfZUfnaiKemrxgbRV8HUgv
 1Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795067158; x=1795671958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
 b=TxJZYUZKtySxuDVaz94a96aTFMXER+sQFLmT52zFqIu+ksQzT6CVpNqxI1YgHJyEJ8
 8HEvB7nz441p4d43oatV5aqOyMk3FMiCIS7vOnLKZiEymVkp+ooGkUc9nfDto+JbAwKi
 iuYNPRBRv7UXlylv3rWdsroxmU8q3ywuQT5bn9U9Yqs69D5XOtfNMSy3jKFrnT/XVvYI
 uE5rHqJ4KLOg+qNUMrJoFKaOoyd0QBslzX5YCdIP1OrrB7ALj8Defh3RaWmliiFwqyOf
 VsFPGKq2WxvGCPaC4/pnZKpVfLGFjJEjlOCRV/thN7uPnrYYXL/ZwW2S3kT3w87ht5wU
 D9ng==
X-Forwarded-Encrypted: i=1;
 AL+hErFIwRki9Zju+6lT0mLtROfHT2QfO/PFPvm1UnTtPqVvuHhUwXqxXeuHEi3Jt0p67IlEApOn2m3ji4w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+WzSIs6+XHnbI+RAtmSJAYUjxoMiR6GcZ0s5VLYdYvKtYKoHmL
 XFAQjnOsMFRgtLg/RQzYXBqL3GnSwBKl02ngjf7hVPI56j581kNWqrnu7XZ9+1vKvctmxbuT/um
 GL3f4zl9/K9sdLvZhwkJUfCNaWrReUssJNu0T4Bzr
X-Gm-Gg: AYBFou3TamqTIvbrV1MqN/gS/YbbTC/67giFLgDgnvsrlhHEVRB2wZo3SxgkLgD+6e5
 UPfiGXFTTzRDvSXI576pYJ2n4oriYqszaK/QU/rj1nsd1cUK7QyrvZDzP129MRGb5mROacxax53
 z4cvNwBTYyfuF4NNe217v5KvgmUsO39ORwv1imP6PROuvfSGXGyx0bMORGWg+JT6ECJ0jY0O2Rb
 t9hhvlBwieoo5AV8ad4TxaDA/104N0DLc4l3kGlI1Q9+08PCyV09NF0WQSmgpY9Mt+Rbdp8+7On
 l4Q2BQN3wcwBZe6h99/IBTa2JyJYhDMaH5pnVVnLTmNHvJzW01AtVTYm4LsySxmm8G3MgL181e4
 DZmsc5Q3M4e8aTeS48JjfMU9QE1cfQCTfbadH
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct
 kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
