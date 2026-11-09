Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A7606A336
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EeBwMfDh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E001710E116;
	Mon,  9 Nov 2026 22:30:15 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBB210E27A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-535f598d126so39721cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
 d=google.com; s=arc-20260327;
 b=aUoQ8C6YnZ8aBbXI4MUrhZwypJ8MYuLQglAMzvZx2bz2XvzeaOYv5ndXFYDdNvw4/H
 yv70+3fKtICGUWTjqnsZjgek8uVwgRzY3KgxDDQ0hUavkk40sr//SUHY8ITokqFjGUkr
 LXmLRSp8OeF0tZT55atVB8f0l1D6YnevK6SnKaxweSuS9L8OIFfaqEx7hEpQy+3lcBLn
 wRrEl+0rKazz/f9IwkZltBRPwWSMYnOFyzha6wEzsQs+YN707Kmn6yJj2XnfSkku3xW9
 K2K8hzNQctegoKPmgcerIic0qZpfgdqzUc7EaCYQQVDZeDg/V4IcgcNDqLRlYz1vluEH
 9ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
 fh=U/e/4IiK3C3/HWMkNafo6DtkBESw3NhOmST+YlkTkxE=;
 b=O2P+gjgrlyyJpAu70p/oMj1/AgNOGSJVE5rPGR0QaH0f4+c8LffCgAWWT7efH63f6v
 GoN1NfUcMsOYsw/x+RW/cFu3yK3H/VuUWLtAgjlF+P/mQjCGaZGY0mMWWZRcBP7CuEi3
 nEbsV5gHLQsZ4Q03QyXVEUjByRJhqyflPV5+WON7X1c8UHNq9/dx7O8dqmkc35LTUftW
 mQyG2NYuqNIwx7A6+mS6QF3E9YXV0zsOSDHdJkItbdG1lg4n3wLXj1tBnOplA74b9U2M
 QIdbWBJvIPhkE48FYjzroCRoug8bNAGm278boCzEFpj/QMW1C+43m57sXQfBB3V146Tb
 ieTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794263408; x=1794868208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
 b=EeBwMfDh4Cmh6OOfmPKYL5tG9yOeAoN7gd5IF8LUkWrJHrIj5iW/kTKa8Quc+0t0e7
 v0x73wPQ7RtCBIrsiV8DPFS64Oa105vPLa8/BRpY5LGTg1V0ihVDCSsn5+Py+cdoq7CD
 mTpSKeeqfa6cIQbIcGl4chBPlaDeEEWtZWlsALFUnl2QVNOSQybSRz+m1qPt3pv6BIIX
 5oFa13ayFtQgLs9xmH/hOlsQnoRziO8vbQF5tXz91ezbJ+BLNlsy1aOiux0zs9al03aT
 X+63FU3gZC+LO7y2XbRrq8Pwskb8n6MA4SEM4uwxw6Ei3a+7TeEoK54Ly2n9dNW52YpC
 6Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263408; x=1794868208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
 b=ybqWz5FfGSJjlCFfGU/xeFyhuy7LBJh4SjAnJpBATjvICwUNS7XJMVYz7DsCRlkWw+
 8z03rWik5D1ZqeVnutcN7wRGqGEPbZaiQwxcq0DXbLSeneS6aE4+EzzO4i9q33xGfRvA
 5EXrCQRZyof4Z0dC9gjtnldhcxpaFAUeECIDslpSYCIuvGo4qZ+A0WWn21jIqbxH90VD
 M2Kh7YtlHRW/SlK2QBmyUcdWm0hEngGhW4JtjwIdyoHboSLVEKEuiJcowUfEIObPLlTg
 TPhI7A7p1Czb9xsfXVz4J9YPd6azMrr6QL4spDOENsccpqb2C/a2fnqJuARrq/hGEgib
 L8/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFnjJ6X5WnEipONKPJv4MmzcYHiwOgEKmNowNOduzdqIeSEC8wEXOvr/kUeLH4uSQlTTI0gmaIQ3wY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8FKynawWkDV2cHdGWUSYGNzfkckaTe64dCbdVexpqiGs0jYrzi
 hVRqXJ7vrCEvod/KeWPK8uXm0c/oMXIsw5Mav+OurxvpMDA+QqiVK9yUcqC53agu/AIk/00QfPK
 rOLum7V8B948YpqocqbUpe8WXD9COCj7fXvoDxUL6
X-Gm-Gg: AYBFou1gBIXlprnkbLpg+10DxboW96MtHYE1Mq1eqksO7CagvfPLDy9yC9JrRTVuYZj
 IJrnxh40krvi99G2pTiEaFx4oI4wECqxBdXkfztwUAWDq06OtY19TP8GV5k6jf1FDvHvMRfDhdR
 6YLMQ8lPSO1rWxP846SZ7OIK8/H4+Ne/L8FIAOSjUXp5+JGmRdxTQ9x9PfdPmeqW/9h1AMK6yhT
 DD0XdK5e22XSgyumnUShImuPCFF3aUcTHzmgrKa4oisEAdVnZ7/xeuQpCHCJnVIpvTvdqpRzqwl
 UCq8Ok0Teeau/2KARQAWj0a3z0rfIqGSCCqgIK19sPfrmXTgjxsnbD66u0xwDhH9aI02q7pMUV0
 IfGdlG9FCsOi+/E3lAG4ATR304XNEP1Vb+j4+yYWaggrmwwvLqqsckbZUgsU3l1Xozi0=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
