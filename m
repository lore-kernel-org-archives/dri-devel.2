Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF8606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLS1FZtl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F43210FA9A;
	Wed, 25 Nov 2026 10:09:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF3910FA9A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:09:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FC3B407FC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0C81F00A36
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795601361;
 bh=9Go3NrC6R1k3c+zu1uu0vGbFmy/uD6Bj5+pEG6pyJzc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=mLS1FZtlW/uBOd8uYBASLUw7dL8m9Cq3WOCGR+qLTLOINHxdiJqcVBElWNdcIZRFD
 +A4pF2DOHjjuyoVAtTmsc5CVWjpwsNNyDXTel3uWZktq8sv/WR0vKkYJYdbImYJdgk
 X9hbN4TaNJzdQGYcPQzLRKg3GKj3gUS1YfjD82L+62CJk27+ndu/jcm0xKxhSnoLA8
 mcW4TfWVXpXvUgwpsd8YqCHdKdRngXZ4sWikgqiBwjXCXPFykO3fVB/0/dOkJMVNDr
 S60jEr5lffFgJaeQPPD8R3xWy0rT4hePGqw/JcIqfSFURZYQuE4+ivClmJJVs3FNSq
 1yKmzXyQRPP/Q==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5be3d5927ceso7646772e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:09:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEbKtFL1x1w1LJGt6a2hXasdD24qckRM16fI1Y0ZRGPMIkuqkcrLUfDZUxHCjvTWcPWiG0qWKsZ0lk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8SjWaJuAkSG0c97PP0gsaE3Avci2eQfvcdXVYn97TphKQzGLvm
 PxOKbeepEv5PIqdhAMo4stTw1NNTTntoe1VQDtlplXtuj+fh1c1Cxxf/sTej2UORoIySrn0p9iq
 gNF9G5Ghd+x7v8pwtMGBdP7QphccZWIQ=
X-Received: by 2002:a05:6512:3e1a:b0:5c1:4f34:922b with SMTP id
 2adb3069b0e04-5c1bc8726b5mr4818493e87.54.1795601359755; Wed, 25 Nov 2026
 02:09:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-15-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-15-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 11:09:07 +0100
X-Gmail-Original-Message-ID: <CAD++jL=bXyBRP8oBr2xtzwkzbEPHXCKA0XPXRueY6pUSagbXtQ@mail.gmail.com>
X-Gm-Features: Aa3M54rLQayJf3xCdY0Eq4zHAmpJ1R1cYyaDehvs8Q24SnEwz4VjC8tWxJP40dg
Message-ID: <CAD++jL=bXyBRP8oBr2xtzwkzbEPHXCKA0XPXRueY6pUSagbXtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/15] misc/arm-cla: Support exclusive context
 assignment
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, 
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ryan, Jean-Philippe,

On Thu, Oct 15, 2026 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> From: Jean-Philippe Brucker <jpb@kernel.org>
>
> Introduce a nr_contexts members to cla_domain to count the mapped
> contexts. At the moment PL0 contexts share the domain, while PL1
> contexts require exclusive assignment, since there is no context
> save/restore.

Do you mean to say there is no context save/restore for the
virtualiuzed users? Because there seems to be for the ordinary
(kernel arbitrated) ones.

> A negative count indicates the domain is exclusive.

Exclusive to what? Please be more specific.

> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>

(...)

> diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cl=
a.h
> index c9ecab5ab6bf..43a58a329525 100644
> --- a/drivers/misc/arm-cla/arm-cla.h
> +++ b/drivers/misc/arm-cla/arm-cla.h
> @@ -105,6 +105,7 @@ struct cla_dev {
>   * @lock:              Protects the following members.
>   * @ctxs:              All live contexts, keyed on cla_ctx_key.
>   * @queued_ctxs:       Queue of contexts waiting for assignment.
> + * @nr_ctxs:           Context count. Negative value for exclusive assig=
nment.

Describe here what it means if a context is excludive,

> +static int cla_domain_get(struct cla_domain *domain, bool share)
> +{
> +       lockdep_assert_held(&domain->lock);
> +
> +       if (share) {
> +               /* Time share the domain with other contexts. */
> +               if (domain->nr_ctxs < 0)
> +                       return -EBUSY;
> +               domain->nr_ctxs++;
> +               WARN_ON(domain->nr_ctxs < 0); /* LONG_MAX contexts?! */
> +       } else {
> +               /* Reserve the domain for exclusive assignment. */
> +               if (domain->nr_ctxs !=3D 0)
> +                       return -EBUSY;
> +               domain->nr_ctxs--;

Maybe:
domain->nr_ctxs =3D -1;

So it is clear what is going on?

> +       }
> +       return 0;
> +}

Notice that here the _get() semantics are reference counting as is
proper, compared to the other _get() in the series that I complained about.

> +/* Undo cla_domain_get() */
> +static void cla_domain_put(struct cla_domain *domain)
> +{
> +       lockdep_assert_held(&domain->lock);
> +
> +       if (domain->nr_ctxs =3D=3D -1)
> +               domain->nr_ctxs =3D 0;
> +       else if (domain->nr_ctxs > 0)
> +               domain->nr_ctxs--;nr_c
> +       else
> +               WARN(1, "invalid domain refcount %ld\n", domain->nr_ctxs)=
;

Looks good

> @@ -53,7 +85,7 @@ struct cla_ctx *cla_ctx_create(struct cla_domain *domai=
n,
>                                struct cla_ctx_key *key)
>  {
>         struct cla_ctx *ctx;
> -       int ret =3D -ENOMEM;
> +       int ret;
>
>         mutex_lock(&domain->lock);
>         ctx =3D cla_domain_lookup_ctx(domain, key);
> @@ -68,9 +100,14 @@ struct cla_ctx *cla_ctx_create(struct cla_domain *dom=
ain,
>                 goto err_unlock;
>         }
>
> +       ret =3D cla_domain_get(domain, key->type =3D=3D CLA_CTX_PL0);

Add a comment that we can share PL0 domains only.

Yours,
Linus Walleij
