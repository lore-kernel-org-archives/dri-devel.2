Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E4AC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4ABD10ED2B;
	Wed, 19 Aug 2026 06:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oy7lkkJP";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0251310E453
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:12:53 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so2162055a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997572; cv=none;
 d=google.com; s=arc-20260327;
 b=jfPLVUabow7Zf+FKsxiyGKa5vTG+5el2bd+QkaBFaw1RuNFYdEJRA1oQFM5Od0dz4c
 utm/2HNSFzPAjA32YQVNtpQtj+3shWLAYPrutzYiGy+eF0dIi52EAAkPfNpmQWFOIGfF
 jT+Oiwwn+VO4y0fC7AbndEjlUx/pbCgzxOkSrb6BjaJ1UTdkSMuCEd5iZCW2sB8YucUm
 gw+j4WJj77hS2zfbnB4oFioqe4xHymWAXt14dotm4Uf98l9rfHdRaZJOr3AXulxmmQGU
 v4Bpiv/DLX3MHC6CBJludb7dp3fT9X1NwLUSr702TNavWzETgcW59DDsa/yvEfxCV/1A
 0MPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rmF0p5wb5vrcnie95iYpLQsIO/+hD7X9foCeks4E8TQ=;
 fh=RYMHx4XxpXgjSPpVoRzZLJ5ceBvC2DniTGY/UyiZ85w=;
 b=WaZxNBpjkWf/OrJIqSDYST12Pyidw9tvU8J4oG97DSSsrGHyZb8lBtqrcFq6tgGNQo
 eVjzE3v3siFXTE9wiW2VIIXhC1CmzgPJrA3AJEWni8ODsQA7oRZFZ86d2vPyQNeTA/eR
 MFPtFJYBEfRK0rnDMemwTSpVdfskeQZsZWmGPDbzum92FlabPjat6b8cNu85Ph1VPHz5
 SGxXvBZTJJxqFjSmSn3I+3WaszLSW+440eIzIXzFDD4IfV1P3m2RL77/gneKmvb2QAdo
 JT4kdOgm5eH7Syza+twbLDzGflETaXE+VKYevJ0xfYwvWsfjDy/mZjDrGF7jOLOGQ8rb
 b9uw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786997572; x=1787602372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rmF0p5wb5vrcnie95iYpLQsIO/+hD7X9foCeks4E8TQ=;
 b=oy7lkkJP9WS4ksxDCTlIyM1QycC2AtudTCMalceeyPf9gcGJiZm4lw98d1lTYN569F
 RDgUANi6lA65jM2X7zWNivYA1Nw8RG7jxs9gfJA6Zr4Eo1sa/N2+dTL3HG/0SOed8UGG
 Eg30+TGa6UzTYv1KzAgb+d4SVtHDNh4/WLo+jFC8vI3drWFOX1EqhGreZlk7QSZJa8aK
 1l+oHWXK1B/yJ58UCDNB7Vk5wDLg+xpp5rLJ42v1PDCTfwIZHDxpyId8cmYq4c2d1e5w
 618QzQsFAm5LGVti/z5CZhTM/aL3ZyghSRc/N6IzlH9L8VllDu/WUW1Bt+vpT+XwEmLQ
 xsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786997572; x=1787602372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rmF0p5wb5vrcnie95iYpLQsIO/+hD7X9foCeks4E8TQ=;
 b=kAdFLofjIVAx893aNu54yfJN6x2xmDig1NSIUzXvEe+UXe9RqbYArt/mUYWGkJEb2Y
 x09ryYwPMf16Tk1IwTaNl4Ga3ca69c9nU4qIcu+YyTJEi57anAMXxXwVMG1Hz0nu3jNz
 GVJKPI9i+++vgoszreKJRYlbb79sC1Xzk3bZJNQNJazejWBqeYtAcEQSVl9rhvPJl5rF
 1jOP8D1pzBvo54fP1Yijd3ZqfpVeySJJfgR3fiazIjzGP61zJggi4SohVZECCH5fIqcE
 cJr7XjX+ORjCZVkY6mZfCxm/s1FwBVeI6zlzJC9UIRbTSTb0kuQnVgTXR9DeowB8i+AN
 Pmgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTxeidP3cFi5r8o68lbJ+IrIGXCm8KD6MTZr5T6YSWVKloiAcCXhX/ckoYeK+o4BBkYuqVXLS3VS8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycPOcpUw7GJ9nZhYXVG88o0WVd4H8YpIndiTEE+vUgxqZIEzWF
 REnaI89oMAdsWhEU2eDhvxoQ2k5n3QiLc7daqN8emy/yGtaXiTiG4AQ5Gp5+tDPFwePp/9EtttH
 I39XBq/reotYp6BI2o2S49x0OJTW3EI4=
X-Gm-Gg: AR+sD11jspfm5mVfkR+0wIBMbqv/Ay48TV/pdv5R+Ku60D4V4xGoM6JFnJP4kvms0ly
 LghE6yMTNcQiT8kji4XVesKK2bupxgkpmrcrvFnreBTmhc4cSLKtwAlpeV+GWTrpXgzaeK7pQo6
 JMEFJLllDNnssRuyX6wNKjfq8fykImrGeUKPUxK+h9bFWON4neCof6adxdjBvCSIh+QSKY/9ohB
 ZNuakeP6jHVnf5RYzFCANat9SCsMDcq/1WGeRhSzyR0EifHpYjtq8ShM8hzpVe8CmWTf87EsEiN
 9xYD7hlnmKXg/Qr65+3zczb0PdKek4fhU+LvGMTlIWNP/j8Gmt1mIupI5FpUC7FFfATkZsC9qvM
 p8pHmdFeJqgLtZqeu65wZMdXH+f/q0A==
X-Received: by 2002:a05:6a20:cc0b:b0:3b7:807b:3cd3 with SMTP id
 adf61e73a8af0-3cc71cb2dcamr30661148637.23.1786997572429; Mon, 17 Aug 2026
 13:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 22:12:40 +0200
X-Gm-Features: AcwNN1XodtdSigZSPtT09IgGY6kHgbqKpKTjm9HggxTjtCUIibmVj2ooHM0J-GU
Message-ID: <CABwQupNAv1bpPF_J9owrHaENx9O2Gt1spaz8HNHyDy+uBXzKng@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

On Mon, Aug 17, 2026 at 9:04=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>
> Add tests demonstrating the edge cases.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Burak Emir <burak.emir@gmail.com>
