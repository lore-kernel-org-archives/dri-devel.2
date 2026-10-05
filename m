Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C96CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDC810E0E8;
	Mon,  5 Oct 2026 19:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fbrRx6gJ";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9223A10E0E8
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 19:33:32 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-98c7798ce74so331518241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 12:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791228811; cv=none;
 d=google.com; s=arc-20260327;
 b=s0B5+bEduuZ16mclwAg4Ihpjqo8bqAzLqJe+/OPQBTSrjiwwPm8+L8dDziccIvezOK
 fbfhrK7+UplZbr/BVqIOE0I9O2C38nGOW3eg7ItF6puWVU1TxPRLt+Zp2FtLrw0olJBz
 13cnArcTpgLAjDaFNCUBt9QX6xNX03CXhB+kKN7x4HLxsSI2tLJwzRxAnwvJRwAs2P4e
 llN5kMKVcPO+K2scS5ikD+0J3xa2SIaealXBj4zr6QntKe7jISImn23kc0yxTZA6xnf/
 9kdd90iLo3c2wYjcFdmsw4UgeQW/9TlH3AmiPIy/rNFabBbCXv5pnWJbV+DOfmU1o8Fh
 IP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+lWtKVXMW2++bit7wvkgTZ38ocIpzbCdiXdguzjZOQY=;
 fh=RE4V8zyDgi4zzXLacZkJ6+m+xvPavWhej8aRI39uNx8=;
 b=sJu7S+T1Dn54Vp/YfnivDHn+d9nISFR1fDxbRKzuFBDzZoUB17ZmDIu4AVNsTzZRf3
 KaoUwVhkbWBnrD/XlHoekeAovNQbMXxlhFGNP6Jo/BFL2qe2vcZgVoWQO58Gc2XSE/56
 /Izgts6IyclAzJ9lTYRK6ZZi7lGlBttB/ss+vcaumPlDuk3s03Q7PQSoPDNx6T+uJqE7
 aQmnoeUWbpAT+fTsNUJB0cNMGppC5KZa7Dwygf2kldzhoPXhapSPZTrySSW/eAyLziAP
 Ags6YPw+sZE5I99m6nrg8F7pESt7gvkN3OBo9yxkt+wGuR814rHMlMoLj1Xm1S95GyVp
 7Y0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791228811; x=1791833611;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+lWtKVXMW2++bit7wvkgTZ38ocIpzbCdiXdguzjZOQY=;
 b=fbrRx6gJVx/6jeqU25XuRvjUu3YduigmXhrxQewI4PvH5Ubnq64QaqWAhSGswkEnVW
 qmx6/e0BWVAbn6CXmZgGzsUB53clcBo4CeOpklJLYW8nivKAOdAGhCgFP6nmOhJULIJ/
 j1083SjyS3sDKemXveW9MGS9HMR5KBicPmsdSDmi4d5CyLkZRnRbidR6VtdOFvRLaXm0
 KFpNT97pmHfPKmhsYGOzYgG2uNO3XSnZMjb5ZVl+D+ePHGWUz81acaphQ3Og0gbLVzLG
 5Kr92gvbL8DefT28teZnrzpPr5yf09sR2bw+r18OM+eRVQ9HYgue63fKh1n4EVgYw2s2
 gbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791228811; x=1791833611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lWtKVXMW2++bit7wvkgTZ38ocIpzbCdiXdguzjZOQY=;
 b=Xi8lthAXRMyP1iXTVCHU8pR5Iu5M/Z8srcRsIvT6pg1TvjGyI0rn9QjLhsQswG0ZdD
 JmBRMIqTMNcB6uqGwyi9H3aLx0Uv9K6U03RzsWYbtoAq1i7LDZXUsLsoUR6KjMBk0J81
 IivMjyaLIY4NOjiGumCj9BpHEiCiZVv1UzCmVlOHTlcqAspCzuWKTyCzBJj1FEv7v1iM
 157+Dtoo9zHgjWXQ0XceSRVimvHlaWYuNtOzhYI9tVrHvA66aWwRSAygza4Vq6Db5ISe
 mm+4nFyoFUed0hs5zAG/2qmxz11yeJZhK47mAwlN+Ua2Ep7ioQ0A3iDwUfLG/8fyy5n+
 Dxhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0N8m2Uy1NLhCmmHsOGxszb0BydBW85CafT3HoLv47j946Enp3pKh8eSB3wrL5AqGg1mwiZ16zoTM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI68Je5nxqanJOgrDfZc4DSICZ6MGhOfbV/3riZy2cx2tHw3Mrq
 kZhfwG3h2kedBG5yErxxul645ALoUtd2n3oIUAb7yVWTAnaiEZpSkbEvSXWseI8VMvraiiTxbPn
 xrMwt4+q9roNZRTDZyeUpIB+I3HP7qEw9znU9NMM=
X-Gm-Gg: AYBFou39cHuVp4vVgjAmBSwm0M+wc+kPhMr1h1BEMLeM/tWarXoO7ex07QZFQOaGm1R
 HtP6/IPipjq1CcqgztHPxejz2BBN9Vem+LRUasam3eAUw0+t0oQU7jPa5pChSZl9HmOBnKHZaf8
 il+gd8PgFhy75tUuRLitD/CEOpwzlRfV2Qvb7kFwwLIZGVO3KMBZ4jv2P8bwN9fqi++v6kVbeyU
 6wyBdu5wvVbgfXI1eWVAhz85LX6FezVF2g1YKmb25QNr5a9QZdE/w/78Bt3QdBVBcxd8VD/yJz4
 BYShzzf4L05T3/NpJzB41064WsIxAs5/SIGxIIHs253Dz9GiQlwU6xn0UR/uw3GsKL1zfa5zgeM
 fdbpvsL1PAqLKNj8c1jrneOSy3Q1+2RC9ulswRo6wfcv70nZQUvbd
X-Received: by 2002:a05:6102:4494:b0:7c3:7ce9:4382 with SMTP id
 ada2fe7eead31-7c37ce9454dmr1299257137.23.1791228809910; Mon, 05 Oct 2026
 12:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260925204423.80661-1-morbo@google.com>
 <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
 <CAGG=3QWoa0sK1P2VEAW+76EkFsjzXEZ9ucJg4iiOv29i8Sgzxw@mail.gmail.com>
 <8093ecff-842a-4063-bb29-4eb4903f7f73@intel.com>
In-Reply-To: <8093ecff-842a-4063-bb29-4eb4903f7f73@intel.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 5 Oct 2026 12:33:13 -0700
X-Gm-Features: AclHuK-08Gp8lXrK0ezKgiJftqCSrSRzq-iRMR2siWd-Z9YgizK2rcJ2TL6POD4
Message-ID: <CAGG=3QVooPkjbNi10D7MwN7WHgyhHderziJzdmEet5ne6dPQSA@mail.gmail.com>
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

On Tue, Sep 29, 2026 at 1:36=E2=80=AFAM Matthew Auld <matthew.auld@intel.co=
m> wrote:
> On 28/09/2026 19:44, Bill Wendling wrote:
> > On Mon, Sep 28, 2026 at 5:20=E2=80=AFAM Matthew Auld <matthew.auld@inte=
l.com> wrote:
> >>
> >> On 25/09/2026 21:44, Bill Wendling wrote:
> >>> In 'struct gpu_buddy', the 'roots' field points to an array of pointe=
rs
> >>> to 'struct gpu_buddy_block'. The number of allocated roots is tracked
> >>> by the 'n_roots' field.
> >>>
> >>> Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
> >>> referencing 'n_roots' to enable compile-time and runtime bounds-check=
ing
> >>> via KASAN and '__builtin_dynamic_object_size'.
> >>>
> >>> In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roo=
ts' is
> >>> subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
> >>> mm->n_roots)'.
> >>>
> >>> Since the bounds associated with 'roots' ('n_roots') are fully set pr=
ior
> >>> to any array allocation or access and remain invariant, this annotati=
on
> >>> will not cause runtime panics or false-positive bounds checks.
> >>>
> >>> Cc: codemender-patching+linux@google.com
> >>> Assisted-by: LLM
> >>> Signed-off-by: Bill Wendling <morbo@google.com>
> >>
> >> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> >>
> >> Would it make sense to also do this for *_scoreboard and free_tree, if
> >> we add a new field n_orders?
> >>
> > Sure! There's already a 'max_order'. I assume that 'n_orders' would be
> > more dynamic?
>
> Yeah, I think just mm.n_orders =3D max_order + 1. I assume the
> __counted_by_ptr() only works with a field?
>
Well, yes*.

* The original Clang design of __counted_by (and associated)
attributes accepted context-free expressions. However, GCC isn't able
to handle expressions and we weren't able to agree on a syntax that
was acceptable to both compiler teams. Thus, we won't be supporting
expressions in these attributes, unless something miraculous happens.

-bw

> >
> > -bw
> >
> >>> ---
> >>>    include/linux/gpu_buddy.h | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> >>> index 2c36124bb696..d7249e500ab6 100644
> >>> --- a/include/linux/gpu_buddy.h
> >>> +++ b/include/linux/gpu_buddy.h
> >>> @@ -172,7 +172,7 @@ struct gpu_buddy {
> >>>         * a power of two, with each root being the largest power-of-t=
wo
> >>>         * that fits in the remaining space.
> >>>         */
> >>> -     struct gpu_buddy_block **roots;
> >>> +     struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
> >>>        /*
> >>>         * Per-order free block scoreboard: free_scoreboard[order] hol=
ds the
> >>>         * number of blocks of that order currently in the free state.
> >>
>
