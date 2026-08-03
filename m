Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B165C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3C710E884;
	Tue,  4 Aug 2026 07:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TD2enaVc";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36DB10E653
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:21:30 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso5522353a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 06:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763289; cv=none;
 d=google.com; s=arc-20260327;
 b=p28MdXPa8Sv3j+z63y/lLOURC1le1XR8R69rMZ+T0w9vnQIrdRXO79qRgfvJYuyq4E
 PixcQil+6FnX2zmVuGbTkJFEHYOgDbdhS5XsvVNjz46DPxl9EX5Li4zcndLzdOKiM/6J
 Mu0b+z1uWmYVxURGVIWwdz7yHTfbnbbmsJw7qabs1N6at/kaigHtLAlKqrJ7VQrRp0a4
 mpURDXZA3PO8oOkqY8nfifZQe9LHC55iG7jLmwrLzqknA1gKU5Kn9ePFjeV93KzF7uvI
 U6iPtKPeW323AGB3gP8XCCpyjjh4h0ivvj20n0qekxHBs5xZPcB7RlhceXDEXpMsidZm
 0+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
 fh=Le+1sSTz13xt4uY7uX0q9iYK1s+uahdsVkzL8HQVSeI=;
 b=c7CvKj428PsUDE6rQBTPub4oTYleks4KEY0JNMIZ8QArvcr3VBMh1Ahd73nll3m2mU
 8QT6xnV9/MIm/0vU7QBneslf+ELvjXxr0JbHHldeYXAV90rxvp9X+Qn2uba87K7uk27v
 94DXFVygy4zWuNygxZpi4Ealg5PVcR7KT0hQ2Hc5noiEsOUKt2tUpV5/EOAoNkm+yU34
 22R05QphxOHm4zQRyz1NouAHOj95jLTjmqAIWvSw6R+fZorpkKRuCQxw54aYPLdc/w9p
 oDQADtchl431OB+6sjwa0x0/njuxF3oprOGMXzNQyLJT0m/x4pCyqTp5YES3S+ALYAbu
 bWhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763289; x=1786368089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
 b=TD2enaVcnvO8kN6FLdXBOK4a3III9YpQBJV8+wvT3Z1ITGpPupVr0BQ8ZSXK6WISGF
 UOXJHxt3tFMREBuTEY5VnysHsq2M5KUFXuPJCBR7RM3UIr9ZPsAuYYse66/9IICCnZKm
 eQeo0PwlrX0798FN2Yz1lVwdHAo8dzJQIgJVI4CCv0FXs3YgAeCpttd+RTErzgAjaHXZ
 U1rV7RpxZTV3YB8SL3Hf7HJvC/IZFWr1B2MzOuvpsXln/SNfE/25MjX17lB4vGIzwj6b
 LxHxbbFp5aawFd4HqVFabfy7T5mddC8Xy7FIIiMl3HZ9u3afCmzGWbE53JFDb9ro4SPo
 +ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763289; x=1786368089;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
 b=LeZr8oSlsp71qiNRd/Pzqz0x/NV2aZsLRjP6+aKEFTAok9oafeOC+LbHq7EFuej2co
 NDKV6vYSxT5dsGAm68k7N+FlUpsLIWdaarMxKoR/daekSSELlR7YVOlGR6DcyGq1bETm
 IDkUiRLe68fnQCR4JJrlAUGBpgORCIg7W5K4TjljUkPppNa4kk8C3ZjJjvcjWUTj4nkg
 1a7XV+lJMtQ57jfp5Tw8KIsghkAMSkuUz9HIwmGaBYt1y1h8sw953Z3UTGULOQa9smiP
 Wm0Ip09oMrzgCwPAAR6w2XDAwi+0g06n7P6wBip5PPdy/ybgcshu4E1vlVnLHTgiz/Ya
 dsGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzeEKZpBkx4SBrqAvnlb50SHSofNqFQcr34jonnrLjnNNn2p4ubwJM4m6Wljb8FXdE7PUZCTIHPcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMFvdzEV5c0KCMFQwGfRPliKTV2hlLiaa1vCXPlPSHG7H9dPC/
 iPwYP9IQkxLL9qmWZMq5vYA6LSIiY9j4+HfkQHQVbaQylSTNCSTDwzvknTY5DKyZ2hGl4BFgUKr
 PKK6/UsTw0UpoWifYkRiYOXXThiTmgg==
X-Gm-Gg: AR+sD11A4IpS5TTV8EqfiUaxSSDkIQz9oXH7qk5ayF/MMsGj9E+5BVDDe2NOjA2ImzY
 Ze7HcTPs9cYyQ0S01T55DdyF3iEQeTrDt8FaBdx7aNXudLxZiG7S5e3WLZdZu1ejJVFErnxAPiP
 vPrBR1OHMj0E3NJOAMj+N7MMRZRmeGHWq5+sERqhPgSugjNuB1E/6MRMUz1zQMFrkO+qp0ZpM14
 eeFj+AljkI5Bm/Xz+S6V++0O7VUUF6HhkOPxgmiUyFCzR3jnYSRs58S7X5GlHEqfBgPe9Khd1tq
 ER9+8G1tN8HNZU6mkj5imlwClAw6ojXEIg094H5i55arOKZRQwu5UCpCOrXFqCjGxMYzke7/qqW
 1syhNuIIm713OKxw=
X-Received: by 2002:a05:6402:21d9:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a0a7c614f9mr7875783a12.7.1785763288576; Mon, 03 Aug 2026
 06:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785596451.git.asml.silence@gmail.com>
 <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
In-Reply-To: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Aug 2026 18:50:50 +0530
X-Gm-Features: AUfX_mwnLWCAPfRurFp37qU73Xc2KDpD6en6Q3cA2kgelroMq6uNFVC_YKEZqSE
Message-ID: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 dm-devel@lists.linux.dev, 
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:15:10 +0000
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

On Sat, Aug 1, 2026 at 9:19=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const st=
ruct iov_iter *i)
>
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -       if (likely(iter_is_ubuf(i))) {
> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>                 size_t size =3D i->count;
>                 if (size)
>                         return ((unsigned long)i->ubuf + i->iov_offset) |=
 size;

dmabuf_map shares the same union slot as ubuf, so this reads the map
pointer as a user address. gap_alignment() below already returns 0
correctly for dmabuf - this should too. Checked the rest of this patch
(advance/revert/restore) - none of them dereference the union pointer
for dmabuf, so it's isolated to this one spot. Doesn't affect the
current series, nothing reaches this with a dmabuf iter yet.

> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov=
_iter *i)
>         size_t size =3D i->count;
>         unsigned k;
>
> -       if (iter_is_ubuf(i))
> +       if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>                 return 0;
