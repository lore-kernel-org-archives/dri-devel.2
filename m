Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E8606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJaeQ4sq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BF310E104;
	Mon, 23 Nov 2026 00:35:39 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0386310E104
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 00:35:32 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-53644b28706so49042001cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 16:35:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795394132; cv=none;
 d=google.com; s=arc-20260327;
 b=noUTuk2kvYi/wdmwwvnbxBrmZxgcPaC0nYDKy+YuGFOOIws1+vNhWXTsl6QFrs765B
 GdwU6OSjWLdkxc56AYJ1ZGFWUWmmkHKVL8KESeGO+FFbXknS3GPxjXjJ4F6pJCwTSqJz
 dnFpEcwUftQU2iE3xeo3qNu2K5qoh5UAUrahJBJfv7EePupxZj20zvuj0iteTr56y4xw
 28VlV/oa1q6nV+mhkqwk6sGLlo7TXGuyY+vsTN+VUvpw8U6J3CQh1RRBCRQsNu6uXBzZ
 2Lk08CM2k0oZMKOkEcdPZgq7WiiZ/fqYuAxMYAqUBltDwM/q7/7MBbcAafkuaKZGRc4m
 5Edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JKCeabG1X7BtsMR6W4u1bK2Jr8N5Im1Zy35mutmMZ18=;
 fh=+khNkGDNHpW+OAtAobOAwdn5gm6fmpXO5Z7Qpj6Y3GE=;
 b=X1rkjrJKFPhUUx0/iYRcGSkCg//aUKuoFz1E/KS4rmbCFi5cj3CUEfDnS2XH/i70YX
 80FFZyo2uztvoOuZzcCADeiD5nKAmmKgJTJCP3Ug3uH5PpWTjLZypirik1UEMoGj1OEv
 TYmOLM6xduXWdcdBjTh+IOBCbHeBfvGhCukj+dmvMLIkohjwXKBh9l0ShGeDTgEHvfIv
 qv9x8lA4nnJdG4yq3N7AeiA83waYuxAzMHnQYWJTCzxheZc/ZU8qKzNivOTUYQs6K4vq
 TYqTLUvHan0eaOswBCsjuE7o9QlzqLM8fY3c9IQiL60/svMphwoLUuTRF9k2a7ZKfbfC
 mdrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795394132; x=1795998932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JKCeabG1X7BtsMR6W4u1bK2Jr8N5Im1Zy35mutmMZ18=;
 b=mJaeQ4sqduLoHsxPsPfofidKdE3kuzHsa/vIqiOaSz5CF7w6WG5AVoaojCN0QbVczB
 en6N8a6qLLkv7sM0+OjzXACzBreeyJcWueUClUxAaM9u4u2aqsL0x/gxj+1q6G/5EkFw
 wWLt22FqmaWnKjZyYFNSAgWqB7DrsfBY+XdyCWa1BnsFPZJZufXmCBinygir1Xgo6QWi
 ITH8pyQwLmuWB6JFk6WAR+p7N5TalNXj6vb6+6N4f466Av2m4lbSSW78ekOKOuWRRBoT
 qqQT4CcvbCiKh/jNuLCH632XlhiNG6vhrEm50QLRe0gr/YbMFnUzC4AmJfwdhMNtux3Y
 rSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795394132; x=1795998932;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JKCeabG1X7BtsMR6W4u1bK2Jr8N5Im1Zy35mutmMZ18=;
 b=J7iDaJZnsKaGscwDrzKiIU14LzF9emM/AGBR/wLRUdTLY14xhZqfPyu1lS/71Y/uyV
 m1+RQ89GQToA5zVqCBp3aggh0lp7r24Eu1f3LqCwW1p50RP6HhtR82TpQybtKtS2/vgS
 KGxu5b1n53eJsqbu+MiMhguI9PkqJj6RlakKEEjA6Sl4agOqYFdJVgDeQNu98Fczf+g6
 JqjDjCxQLiOPDnJzjrr4Ov0af5ENZZzlwJ1iqGrjN5S7OTmHSQkCgV11n6IMuDJ+ySCH
 Vm0j5eeJy2PVLZ92XwppDwFT1RCrLa8H2RANi8sONVmCKWdBQ7pVxcFGaYC9WfAlKmG5
 PQeA==
X-Forwarded-Encrypted: i=1;
 AL+hErE/jtG5TQtopOrp+vW89kNPxMkU4vllQe4X7ojI/VVBsaIPYi6geNyLaY2XFML56n36JvgDcMdqE+Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+RUfZFO3tqICrm001XZSRCBVZe5FXUlm+HPRmYmKPUdH6fhp3B
 /x/I3cx8ZoCCADuuCkBnOBrMxbUsHQ++sqP32aXcFh/vTxaJFfPP0jy1WLAwV021cYMxBreq9lB
 gKq7E4wefbx9YCbEn4gEtJBZWeeO7drg=
X-Gm-Gg: AZFdTZctU6umqpFy1xCJGLWWlxGbAOI4SfJe5yo6IflEre6RUkJTtEFrpdm2IxThQu2
 7Kzj/I9XVPJooQODiZ7/IuOKYVhVEiHwVeKhUDr3To9t2VQ9CMKkwSuZz3Nx6V2Ka37l5NwwoW4
 6AgFgdn2di3MZL4vmy0zYmqZKx1W2lJ4AXnwppq6NmIYypDsn/4evQxhvKAx9S5AAcKsVVCW585
 fq8+v83/5sK176dYNrifuprLj/GzL+zmURwjdhucH81eUVcCDnXFLzznOGY/dSZeGsE+5WfILun
 moUnSjJxtgPEC26rfzNQPYJ68HQ+IowRU7/ajdoIGFMAFfZu0cokVvE1fax2TXn5HU/IDWJzmsr
 4AHK9OauQORCogIjXMuhRSFFJComuR+twnA3ntWx1iirUBmh9KrZXGDeN1BMIbt5XONmlAhQkxw
 86MkwHgeyvV5zhO7W52x2j9w==
X-Received: by 2002:a05:622a:4a89:b0:55c:9c77:de99 with SMTP id
 d75a77b69052e-55d76aa8580mr171012381cf.73.1795394131756; Sun, 22 Nov 2026
 16:35:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cf3c13a8-1dc3-4b2a-8d37-0be289a31980@amd.com>
 <20261122140812-09f251792405451c0dc74623-pchelkin@ispras>
In-Reply-To: <20261122140812-09f251792405451c0dc74623-pchelkin@ispras>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 23 Nov 2026 10:35:19 +1000
X-Gm-Features: Aa3M54rP2yLFSzAhlEa-grBq-B7YBS5JLc46UQRKJNk-DMqkDni6BU_mvJzWulA
Message-ID: <CAPM=9tx4ausyL0qoxA+4gDN8ciWhd8m99obh5O7-M2y2ndGTcw@mail.gmail.com>
Subject: Re: [PATCH] ttm/pool: Don't leak LRU list on shutdown
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 airlied@redhat.com, dri-devel@lists.freedesktop.org, 
 Ian Forbes <ian.forbes@broadcom.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks,

Pushed to drm-misc-fixes now.

Dave.

On Sun, 22 Nov 2026 at 22:16, Fedor Pchelkin <pchelkin@ispras.ru> wrote:
>
> Christian K=C3=B6nig wrote:
> > On 5/27/26 22:20, Ian Forbes wrote:
> > > TTM pool was changed from a regular list to an lru list in the
> > > referenced fixes commit. list_lru_init allocates state and it needs t=
o
> > > be freed unlike a simple list.
> > >
> > > Found using the igt@core_hotunplug and kmemleak.
> > >
> > > Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
> > > Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > > ---
> > >  drivers/gpu/drm/ttm/ttm_pool.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm=
_pool.c
> > > index 26a3689e5fd9..a41addbf3ddf 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > @@ -395,6 +395,7 @@ static void ttm_pool_type_fini(struct ttm_pool_ty=
pe *pt)
> > >
> > >     list_lru_walk(&pt->pages, pool_move_to_dispose_list, &dispose, LO=
NG_MAX);
> > >     ttm_pool_dispose_list(pt, &dispose);
> > > +   list_lru_destroy(&pt->pages);
> > >  }
> > >
> > >  /* Return the pool_type to use for the given caching and order */
>
> The patch probably fell through the cracks.  Can't find it at drm-tip.git=
.
> Would you apply this, please?
