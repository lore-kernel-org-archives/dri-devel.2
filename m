Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A151C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD6B10E474;
	Fri, 28 Aug 2026 06:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mriXr5QC";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2272810E47B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:27:42 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d319b84213so574455ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 23:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787898462; cv=none;
 d=google.com; s=arc-20260327;
 b=JJIk7KUlNNeG99DtTekirbsApTWajliOrYL9qfaRDtuW0ZLLR+SzaQMH0q6z2FS42t
 F7ACCaQdiyeP3CuEqugPf389Yd563AHQMzrhNRh5nKWVY2/nmFdzGdko/DiSIWjh8SpU
 I9vLKCi0xaM7bLZpsrvITF5eGLmLVzuXYDrBFykRZesM7oiYKpD6RL1fBrcBlmOPFDZD
 no+VCNttPm7zqIboZQYMtP9l2VdFR7BhK/2m0wqywCforph3gcknVbGa9bZqHOj235Co
 Ncd3MeWOP7vLuGeOGgLGWB2h8mN/HJH6w69nV++Fpc4iZbwLC2sxHJH26sRGIM+gwtbv
 P8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0FpSUPDMQtu2ZqaSK17CZnsys4mRnbF+hvV6Nhgnp7c=;
 fh=kIvVcZwtUrrXq9YAoTh+gs/QXci/TTQZ8ld66Pds4Lg=;
 b=lm7NlLYKJ1JvHe68SVfdCaLVG5SdXQXDECOaxLCHi5mHhDKozCtWd1avyMupqZ5odX
 ySLDA39OwGQ0yn0Os1v5qPQuCIfmCCLqedHE65CvRVN0CVA95vMODss1mgeb44LBBVXF
 UPrG0Fr+ixv4fX8HuEcnNPsbD620WjIuxp7D3FW+YWkG/qBMliox9X4TARefaXC4AYgO
 DZbLxIVmLL4sE658Zv/h2cchJi6KwthTy5cRg+utVaKQxXzNTsXUvH3y3ZUKhWw+jPyl
 L837PD1CYF2mb6DggEIPkb39tIArfa0pQIzzX+lEYmV2OUt5QeJsTfmKIP4eywr7D0P+
 k/hQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787898461; x=1788503261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0FpSUPDMQtu2ZqaSK17CZnsys4mRnbF+hvV6Nhgnp7c=;
 b=mriXr5QCRZtYVdiKQOSrGyGcuo92JVylZdSWOHJnqjGB7/MvAE1cLnpANLQz5WF6Uc
 RedVCoUYF+dcGkl+BySWnkPswWIe0VjDIo8qWof+vMK8TgfLPEjZ0Z+4bdz49ZTWP7jw
 hftzZcNZHYXfj/SxoAheL+LgIWam1vCVDSJlmEPwIPO4Lw9Ajq7gaJC6/tBCek0Cp5E0
 IAQ1Xqc44BVuiohagRPi3Xg4iZDXSVkTJ/rrMek0g3LbxpI7EB8CRccGwc69JFToCdP/
 pid0sanAUpG4bW8926OkKmJPtYi+GHIaAt+5HOeMyHPJDEXrN5+QzXEoW6B+h2W81+0F
 UCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787898461; x=1788503261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0FpSUPDMQtu2ZqaSK17CZnsys4mRnbF+hvV6Nhgnp7c=;
 b=HNsjnaEviFy8/v5OW3dUPdOVL65Cb6FiSU7rZcdOgo1qJcv1JrTwrGsyja6OzCQjGT
 6cVJFGV6UIn/vplrRHcoi58uebma1yhSOXiw3KAuGR7dGaJ+QJ7p+g4CxCxfnG6FSLYG
 DRXJpFtbcizhv8GglW0NqHcvkrHmwPVBxA1jO8oWiY3Dax44Zl6IhyCltGoVmfQni1i3
 T3OUS+IApKKttLFCdo31Z1exhU3qmmIeVDsik2o8zsRQPuRN4sROcQuB3yk4/uowgPVU
 3gH2ORBJzUtiSchzpPhmVT9vr9bEFH2ZT0lRLcG1huBkeQ4ewi/Wxx209sx3ghlLVSTT
 uXFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqf0ueuYzthYAXOOINkiZWz/Jrekjtd7prSWvDmp/pU043grtR00Mvqhjs3WR94o/La1I9zkYd/RRo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQQptYaPuxBi69yRlNqFb893u66+3At2V5nJOk+cY+t4SVNCBs
 qtfKOTcVs5BLQC19kxFoZFBDix0cl1MALbDHHLD+4N2uo3aSlmkqE0B9kv8rnTcTvJN5fTkk1Wq
 6LwufEe4lGNETlGZuLEbymfCowUcDmS0=
X-Gm-Gg: AR+sD13hRmUYc57h+ov43kaVt5W7gH1bQQ+eiOoFFKMcSn3Fzp0SwhPQ29Y0tasIH+i
 cJZXdpisQ9vnRCbyXoNKYXWpvRO8chYGGsS38eWSECZtiAlMDF4+TipASv/CYK5sV5Cg9C/M2Hb
 WBKaiIbMlFFFJ/UC5i4Sz5GNdDc7px+LUeHx3QSZelAi/qrnHCQ1ZZvZ2IeyTqc/pXs5v5lYPkS
 yxRiaHHU3y7lmrnbOOtVln6SAdjoq2/AfMKP/3APIN7OcJt6lJaW+qQVrwI1fSkDOwX+LWQ1Z9g
 gLrqlNVCgx1Dx7KecAQBK5nt17sheKfQwPII/tivgG3ZqX06MuqE2qCQJwQIH+LAq6z0lBiCS7A
 4ptgpaFi0wa4ZCwYqXkN5cYiO7DuLqcR12jqlUCwxoeDHo2ZmLuZZpqByOtVdQsdfhUgqNOI=
X-Received: by 2002:a17:902:e742:b0:2d7:d12:552f with SMTP id
 d9443c01a7336-2d74ce2e25dmr42511675ad.0.1787898461636; Thu, 27 Aug 2026
 23:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-7-bc74c77d0214@nvidia.com>
 <DL0BIY2CGYQ3.TY18JERIWOUK@nvidia.com> <DL0BR314U4Q3.PMFAV27Q6EM8@nvidia.com>
 <DL0C0HAK8CKB.PES9IOYFNA9D@nvidia.com>
In-Reply-To: <DL0C0HAK8CKB.PES9IOYFNA9D@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Aug 2026 08:27:28 +0200
X-Gm-Features: AcwNN1XEykTRjxOk-JWsfu04X-RzlIeD5qnkPfp1CbxkCq_OEMkQfZ4p6INdjp4
Message-ID: <CANiq72nunnWs7+-fwJTvqYQn5J-0bbNq_O4LBkua5GymX1vN0g@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] rust: sizes: implement SizeConstants for
 Alignment
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Fri, Aug 28, 2026 at 7:36=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> The custom is generally to have `Link:` follow tags like `Suggested-by`
> or `Fixes`, but I guess it is also ok to keep them as general context
> when nothing matches.

Yeah, normally one provides a Link tag after e.g. Suggested-by or
Reported-by, but the Link tag is more general, i.e. it is meant to
provide context in general.

What I suggest is using a reference like [1] from somewhere in the
text to the link, so that it is clear what is the context being added
for:

  Link: https://... [1]

But sometimes that doesn't make too much sense, and so it is fine to
have the Link: tag on its own too.

By the way, the commit message also has a "code span" in a new line --
I would suggest indenting it and removing the backticks:

    Alignment::new::<8>()

Cheers,
Miguel
