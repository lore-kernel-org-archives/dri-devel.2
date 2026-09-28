Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A96CCA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7423910E93B;
	Mon, 28 Sep 2026 18:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="A1ZkpBaX";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCCF10E93B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:44:55 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c67e529da9so1063917e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621093; cv=none;
 d=google.com; s=arc-20260327;
 b=nXRMKKSKw6WQznIp5O40t2RyTmJQSJax1xIPCEbf8iLq8WEc5rBC4pp20ovnlgxlB7
 UAuOaFYW84mYBJo55TcS8rAU5lzRq564smgPRvTzJX6wwMKI5lJT30pQMHgc6AHygUvv
 NdWXWJtnpAA9bLX33yYrFoZw4Lp6mjktPRhq7xs9RzdaIQsBRUe/twz6Fe3KlqWp4jyL
 XUHMW/u1H6cYJTbQi7xQ4aZzQfdg3no1wi0Ljg3SoYEOnh1njG52qamZqSDo1to2Xxzn
 vWPTPvoHw4jy+Owfy++kNWj8MWPMI9xIk36gpjolbe85ahfIo9c5aIAvfB78iO5Y3a87
 h1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9MUoqVvpT69Aq5ZarehzNgWsu7OePV3YFvLIai8Gmus=;
 fh=au9yJ8qY40zRauwnut6OdhAa1U5PfT1LUPSJUI/IbmY=;
 b=ayQFFb1S6/LgaYlFprPrXcGLOi7PItd/6F5V/2iFdQrjjtBXROnUg6u5f57n/xWJd5
 cKuWQqbM6YUyIthbi7ZpdiRx9rpqbT9E8jU9/GwWgwwFPIRKrzYFL2hwreg/l3cKzq+t
 xrPXioeEzCyB7MMHlscadivFqt+YOAXyuproSKgc+evELGYXri3k88NIDOQqtODbLmCK
 kXNbTQggjG0in2Ww9WbatK8jyoZA895DMMIOg57QGa8Q6PNP8ik6bT28uOG52o6Isfa3
 TsrUvKttd2pAmHZmb3sefcsFfizbBhqI4MCRFa+nNInBi3OlzVE+v2yn9dwkhInho+Vp
 OgYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790621093; x=1791225893;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MUoqVvpT69Aq5ZarehzNgWsu7OePV3YFvLIai8Gmus=;
 b=A1ZkpBaXEx1WyxMtJuYPuI851AKMMHU/pAQrJmi9pdsGeQCAZw4Stg+K+/kimbEPXL
 FH4BJbZCXNFDCrauwIUmzP3UGyPezhcqNcDlG95UmIQQXGkU626zZWAee10cGbj+Ebtz
 sopsT6XttulLiN3fomplL/m2o2/Fqw3YrzHoEqgFNb7eonOBANxaAscglRSJnklwxH94
 T+0ZgCPH+8qxSntZ4hM3/8nxaShWdG4yGv49hfxq2ejXZlXcizOW86t0CAlt2acOnJFH
 ENgcMTVM1ixIeqQzG0dDybdfzC7UnLNIgcCFxOXmFyjISTd9biqOQA6TiBzQGrBNA+dD
 TY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790621093; x=1791225893;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MUoqVvpT69Aq5ZarehzNgWsu7OePV3YFvLIai8Gmus=;
 b=RzySYNzYUUyS2C5XToy4XGy17IWn0ssBCkKVsK74VGCDf/g7ZzoeSm+Lm8/JWEUZP0
 Se8l7svvzbP6aOqb1G4ofNImRGTuWf6FLXya2LQq3QhLs24m09wiZgT/rRX/ZCGMZ1EM
 2HQL5pxbT5TLR1IHmaY5JhWG92YyMlrJuz4pYlXVwa23blqHqews8f1P8OxXjEE4etJh
 xDcfNc2A70kj/hYbTOusajqo/rpiYpCZBkqsxgvsPhGTJ8kYJxSOt+l7M0zw+V1OuUFb
 qEOVLZZloFfRis00gmIqPX+WTM+mlC8iUImzotH9cVnjjpqACB42EY+njRIU45rbaJqn
 Qt7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx17CT2WU/BC4OzzVFXq9EC6EFi9TYHAvwrU3i38YvO2rKVtRO5dkWss0C/U/O4DztuX2a8LnNNUmM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQRdwJ/6d8SxWPADZ32R6M30m+Y8O1xUan9c/VH/SQu6kp/swE
 FT1gyWCwooFeSKSwtWtqPZ0zdHnDBQytUEVN/O4BnOEAkZWTfNtR+v9OHm2EKVqOiKkym9Rt81H
 opGz81D28vRVaJGyrBO7sn30CZ5cq153IEpnifWw=
X-Gm-Gg: AYBFou1IXbXfz2yCJoVyY5IF3ZCS9JsYcJj3gIEQqP46Io/hw8yCkwcq3+Bqp+OkJ5L
 OkCLkUzPNT6ZTwjpBtWIOZli6uQ+jQPabPbHTvnYuT/fGiXREba2haIElPP0FBidVM9b4NFdvxq
 Xv7lVR4DxVAqFfQq8bbV2TqJaNNnSirfbmF8AWXSYVXTfYhe84BRmvMQ/ya2NT3odLqCMg+xVXV
 sTN9C/8hWp6PFjcVpp8SVdKZ+5S/kFQmcJZHa5yCecwCiax04c5wMch0OFHmMyBy0QMBsRfBdia
 H0xvgt1CTKOVIAqyHvsaTcxRFcWPGGrTphJLlgFO8SprrCZLOjqvxiQ1BEN76genKYyXBFK4ej0
 FBrdZjA==
X-Received: by 2002:a05:6102:549e:b0:7b3:3b4e:e4 with SMTP id
 ada2fe7eead31-7b33b4e251emr2377156137.2.1790621092753; Mon, 28 Sep 2026
 11:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260925204423.80661-1-morbo@google.com>
 <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
In-Reply-To: <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 11:44:36 -0700
X-Gm-Features: AclHuK9vzOTIpe5NYpVAFSvvrNTDuflNtvpsUCuDxpjVBNqxintxAyJXqYTQDl8
Message-ID: <CAGG=3QWoa0sK1P2VEAW+76EkFsjzXEZ9ucJg4iiOv29i8Sgzxw@mail.gmail.com>
Subject: Re: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
To: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 28, 2026 at 5:20=E2=80=AFAM Matthew Auld <matthew.auld@intel.co=
m> wrote:
>
> On 25/09/2026 21:44, Bill Wendling wrote:
> > In 'struct gpu_buddy', the 'roots' field points to an array of pointers
> > to 'struct gpu_buddy_block'. The number of allocated roots is tracked
> > by the 'n_roots' field.
> >
> > Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
> > referencing 'n_roots' to enable compile-time and runtime bounds-checkin=
g
> > via KASAN and '__builtin_dynamic_object_size'.
> >
> > In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots=
' is
> > subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
> > mm->n_roots)'.
> >
> > Since the bounds associated with 'roots' ('n_roots') are fully set prio=
r
> > to any array allocation or access and remain invariant, this annotation
> > will not cause runtime panics or false-positive bounds checks.
> >
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
> Would it make sense to also do this for *_scoreboard and free_tree, if
> we add a new field n_orders?
>
Sure! There's already a 'max_order'. I assume that 'n_orders' would be
more dynamic?

-bw

> > ---
> >   include/linux/gpu_buddy.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> > index 2c36124bb696..d7249e500ab6 100644
> > --- a/include/linux/gpu_buddy.h
> > +++ b/include/linux/gpu_buddy.h
> > @@ -172,7 +172,7 @@ struct gpu_buddy {
> >        * a power of two, with each root being the largest power-of-two
> >        * that fits in the remaining space.
> >        */
> > -     struct gpu_buddy_block **roots;
> > +     struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
> >       /*
> >        * Per-order free block scoreboard: free_scoreboard[order] holds =
the
> >        * number of blocks of that order currently in the free state.
>
