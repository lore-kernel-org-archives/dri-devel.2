Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A14606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CFijV9LI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2309210E64A;
	Wed, 28 Oct 2026 15:36:11 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A559610E64B
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:36:05 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-533202fe429so405341cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201765; cv=none;
 d=google.com; s=arc-20260327;
 b=A3faNv51MnP6nKk2pjPM54LoHZzmobInLbGRRp/pnMsiJIxxDU66lW2vBvqJf6vssZ
 dNC6hE78XMbnD53fZjcUrnzJiQGurNwPZfRBdfQ8dBMeHxDje12pBSncCELkP2FG1YhQ
 m5qgL0cpXzPHxr9dJGL9wkgpHB5bGePl0m4aftQObzlrUJPZB0IfH29+UDnoEFXdisgB
 x0xTHQCj3dT/udzDONUj5yRAiv59jZ76cTU2NqImzR7/PzR+OiiXa4vFWUbeb3iUgY9m
 1q13fRcX1BYmj/k9ocLJffBn0Pa4H/L0u9NWV5cp/MUY3XLebMdocImj9ELM7TNg+Qd/
 XJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
 fh=grnicUJ5D9wLxghLkyvoeUx+ryqTJVRWoHmdyrDQa+M=;
 b=SxiNNLRjV2wTDaz2FSoBxNttDnGGsP6MA5JD6457mXVFk08mdqNH+C55C4vftCmmRS
 14UUGKccI+juFzbj7VCtgRbgFzy5V/Ju10qJarQMmWrb8yhjKj6ULsWRTeQhENY3AnA2
 F4ZpsVr3BRhXE9dpNFDPKUD2NC801FN5+qkip8+yCNiZlzDb+SMjBpcrXjW2GeFLUTKS
 JlocUWdZC5nfAvJMqNQLM+aHL1G6w8lhx1Z2pR0xnnrR2TpJVD0sMkcALf8xwtdLkP5m
 i0ZvUhQO2MEEIvBj0Q0De4xDbkbtxm3e3e6HxE7oKWcCdxuunE/ho5pru/rxix5sDLlS
 n8WA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793201765; x=1793806565;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
 b=CFijV9LIXPY9+s42V1W/T+El6QfW1d/zMfuTVIy2LsVL7hua+GjGoBb5zsfYUX+OKJ
 Yt+mPtM246RxaAv8oUeiwBDR1PWXp86T/phjBOAQE2WMwx5ZErOLlOSOHYIF4+PJDqUw
 Fwy4Ysx3gOFIXlF24oU4DeeIDFCeM3qQEObU+TgqvAcXaWqT+Hi3Ztx/11AD4m9aQwK9
 wfmMSwYIGSi/MdtoUE9U0aNXaFo/NoSpPiCZaELarCBcvKBCaQiy4gD/gCHU5sehtiOj
 TiCvXZXykDvU5BneJpu/w3sme2X9IpbQ4BRh86Wgd4Rl+aEMdUzisb43xuy5MdgZ2AVj
 HyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793201765; x=1793806565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
 b=yDbtiIvaoXbPnbqPSTSz/2vutUkz1ItfojJtLTPMAWGZ03EyPABobXsQL+359wOEAy
 AJt7+m7133gfOsbYDz/N/bRp3qT9yZZaeeO7mkGJRUvC34zsTzPitjidpHt6EQN/Jh9d
 cFAhn1pwpz1TNek84oRg4/hkZX/Z2dxW21N/px62iwtp94aQzWYPh6Z7FDRHKIotZB/+
 IL8Rm8FI98q2ty2tL+x0lD8jt+s/msubFrsFEDNLiIEUqsLmXepjC0KaPYnKV7StNzLX
 jQ1FP/3YIiXQ15cAU+hbMkP9RRF6xA1ZKO0DY9lIOE9lupjOaHtV8eviCHtRCeLKoV2a
 kXmg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUjTASwBC0hlZ6cqu9ccD62ci7eljywwmrP2gME/B6haxoi4k0vQlZF+oGUPepyI9Y7DMUJkceLG8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKN6MGEXxbmZpOiNNkjWVAxWbuD3FaQoDL3z1GUCBfithFs95Od
 v4poA06aRg0hp44InYWmms8Qfx0S9EnqdqK6Yo6AV/Am5+l8bRqUtLQiLU32FfgXtsfGHQ9S+Mc
 0K31pxNDGE7YG9hfdf6CtKBa6FSf/BW7e4u8aNwIq
X-Gm-Gg: AYBFou1cbTCkbNKSdF1WGeuH6Pn0fyYNNXXRnAJZD92A6zsQ03EX8lOf3QQTiQpPDnv
 X49QhwStvuaxt7HijiJi6kBnBXakJm/h6Tb0EFRVM7j/QX1gNK52Ihh0eaLTpsH0VbzrMnfVi5C
 PXNrdzActBteVOwV5QfO84GU+f2x0zOafVOTz1I/EM0u4uGzDTGw2lSEb52GXs4BFXlou/7rdcu
 H3TRTtarFRB57sDOCUf/Vy4YQMZF80mC3IznUFf7Q+xnK+rdIJAqlR5hq6gCJfY8NhaWOtCNAdc
 gD7KVcpImSjmET+JcKFDYiNd+HNdF2g3g10io9jMAlo1kUm+AHei/4R4PqlLhwgw/1NFKEfiRqt
 w48Lxp15JaRtuwhzIV0/E0BuIBm0Rj3dH8q4Jx586uPfs6Pt0krArwrLo5LU=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
