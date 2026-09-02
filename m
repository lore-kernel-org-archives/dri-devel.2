Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F69EC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB5A10EDC5;
	Thu,  3 Sep 2026 07:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=x6u.co header.i=@x6u.co header.b="Vaq/Dnrm";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457D610F36D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 23:08:02 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-39675172593so1655344a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 16:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390481; cv=none;
 d=google.com; s=arc-20260327;
 b=jLknRkRB8XeIy09Izvn2W/njJqqTmsVEknwG/hot8fCQfqIqvJIAylWV51rMyRKfOI
 sVTdsrx8KSmYGET3ox8WbdoQLWIZkOKqY5nIDl3uFFeVQqVxcNWZrUzZdCnA0rxk6TyA
 nV74vYFNXgHiadRrPG/mmsPFKuuMLrCtm71b8RgdBZN0cyQodOL40IEhjV81EA0rzH5j
 H1kCkAg3JRCZrYmKVJ6DavhslCpN/D2RvrpDGs+zzdfO7IUvVh8/zl3jtICpKTCGBh1z
 9KFYQWRn/rgfsPfjN5wqgBjVQgUGdhq1HIUFWcXI6mdvikB3xSyb9CASPX5juh5RWm7R
 gMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
 fh=25D7rNU0gUpV3tl9YnXYOKLvsYllZjX5mexgC6Ig8Ds=;
 b=MXiU1hWjKGQ/tF+IxfQ04F8h+uNl6m0/WolhEh8UblnGH+uwR+MOioyuBjt3AFnlEP
 uPPjSJI+8ao3U7nXGREcPHVPM7F/2E6t4f1OOyCbYVuNvCraSfD4lUSt4PlpkFoWqL8/
 23QWFjFYonWJRtocNwFywcbGkuFgdwfPk7FEz0UN1wDs0MOYIlV2EgMM8J5XpJepw0hL
 8irXQi4lmlgTFuEhh/Ul7h2aEbaaHQ0lwq4vdtR2Jo5hZXm+6IUTTdxl9ghAEN8PpLGy
 bMmX8fNtiOVtQ6VhAoTs5IGr1cnos//tTKnc8kNTvISsR87ohkBNvAyHgJutQ3bh5R/t
 y73w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1788390481; x=1788995281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
 b=Vaq/DnrmiP13fc7lzQECbu5vGs/3FuZHUsXVpbFJhkFdTMblF2N5MGRnkRsSfPjwsu
 7d1z59EADz5q7629G9STIB6lP5oYm5DPzOcZqmwlAYu4MtOulynJBfNFX1K0v+74B1BD
 UmnaECEnXyGyjyEVNYXZQhM/9F+0IqvWJrYREmJgC0yiqweKagrVdwoCHFHbO9BlADQF
 njQa8YN9FNbavX16j2yUj5cBWXEKuwe0VfhA8N8HLTj33Mp8Sn51tHTi+vum0lUAHOXT
 HtcZMSbwYVcX2gVbR7OM5SupPdSok1pM9YIssj7iwDpi3NFkqYHZxtdeqGFS5UUXJNKR
 de9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788390481; x=1788995281;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
 b=VdhD7UWyu8HbmKPCkInDXBkDNhEvTtEY6S870/cC3kZarkEjRrX4MD2h6ollR4sV4b
 90hi+XHwQV17d5EoRxXoLjySjYaWzI5k0Zk7a34MsRJtDXO3k67EVJm0RfkAGECwYFU2
 5AL8wuBffBvZX2anmunXr1QEBorSOm492/R2OwWbrW5JNVEXHje9ItTNQBO7qDlyAdpg
 hrQbxthScx8f4twYWy3D6BBFUEYHafnKuSZjTKtfCXtAfcQc6bMWr7m9lVEO77oGD6ol
 Brfkm/+0NlVNWG0MkhKi1vxG6cYVpF1OvQChXbH9g5KZ9UF3+99/zJU5Q8++qMohggjM
 tIaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1DES3sn0x5/2vg0M5V6LS24qJJu+GhhFWatJf3vJ84R/p693CATmADVRQEeP1ItgtF8KrUNNbjH8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgBdWiXRSvid29ZTtjNK3jZ8hp0lG4AN2nbsM9xrRSD+85Yr/t
 XYEjtgT4MGYdrCcFY8w5I9ysMSGE1fg4/eBHLPMkxieoxLe4vCmNm5bFB37itdx2d8CVi9k9AHO
 XvCkorW7CWOvAkcmaAILEH9H6zd35LFajqrwAU/3Mty4=
X-Gm-Gg: AYBFou1BU4UieBty7jcfYhXNlzynIA8935b0jaZKBRVh6o4r2t/m4YEgtXgGZJ1P3Mm
 RJQQ0HcnPozWl4KGQCpZO6J+JWLGjMfRdGT0WxK8S200MTVgHdAw84fOBKPB2YXp2PpE/29A6jm
 KLfw2Dyt5Qu0HhPzwYGTAAfu4GbR5zNoYCYsG5YM4dJt7EvAVz6vSWBpD+noNVYtHL4VIxJ25KO
 64WI8uQxihDbfnV77eoMFPs/TfqEPJO9q5SI+9UGh0HTJO7T8e4fckYPUsCd419QDbp2JN2xxLw
 v5fgZxJ3DPsKJULXA+xUIZ4A4ddNFM6HxVOolYwyw84MAvSWKri9hbHLGJSGK3lmehy1NHMD5w=
 =
X-Received: by 2002:a17:90b:3e8d:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39aee153e79mr9644253a91.16.1788390481503; Wed, 02 Sep 2026
 16:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
 <20260902120832.GB2890729@ziepe.ca>
In-Reply-To: <20260902120832.GB2890729@ziepe.ca>
From: David Hu <dhu@x6u.co>
Date: Wed, 2 Sep 2026 19:07:50 -0400
X-Gm-Features: AcwNN1UWr9DtGOkBk_AsJGV3X93dnPOEvrR1ndZaMb2yMaRxX36LCdah5a513PI
Message-ID: <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org, 
 ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com, 
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jmoroni@google.com, 
 kevin.tian@intel.com, kpberry@google.com, leon@kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com, 
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com, 
 xuehaohu@google.com, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 2, 2026 at 8:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
> >
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
>
> This patch is fine, but pedenatically a scatterlist's entry limit
> should be bounded to dma_get_max_seg_size(), though I don't think it
> helps this. Operating scatterlists at the size limits has proven
> problematic in a number of places already...
>
> > In addition, a non-page-aligned sgl length will trigger an edge case
> > in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> > buffers, we will have a `va` with lowest bit set to 1. That will lead
> > to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> > to find best page size for the mapping on the NIC side.
>
> That's an IB side bug, the newer logic that joins adjacent SGLs should
> have avoided it?

Hi Jason,

Thank you for the review. I think you are right on both counts.
Regarding the IB side, the new SGL joining logic in
`ib_umem_find_best_pgsz()` indeed avoids the issue. `mask |=3D va` is
skipped for artifically split, contiguous SGLs. Since Christian has
already pulled v8 into drm-misc-next, I won't spin a v9 to avoid
creating unnecessary noise on the list. If you prefer a followup,
please let me know.

Thanks again for catching the IB logic detail!

Regards,
David
