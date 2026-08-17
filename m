Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093BAC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A6D10E61A;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCZH9vQJ";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CEE10E453
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:14:08 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso2731535a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997648; cv=none;
 d=google.com; s=arc-20260327;
 b=ejr87WSh/gGJdGzRqZKRqnycojxe25+1T6ydqsiHLog2VQr4r4dtq1QZQeWxDDVxja
 VKSol0fXEQjRYX2WKTg1KYf8YgKSuD/aRb5OdCZEjXyGARA9XexZwV5xwK6mk1lPatAT
 EdMv+m6FcsiX88N7JNqDfN2XoIi7hhiLd9GbPFRMX52xYFbqTLXjcwC2TnI+6A95O5ia
 z9SLWrStZWZe7P+C6EdzNfB4+ZFk4sEo5yRWT5IOrAUFqaIdLkHLb5nAsEJ98SfbF4HV
 KZ4u1Y46J+fJDx3hF1uWfOz1dT0uQgIraZopVUbOP9MrL5QBgv4YRXN77uMIQcjB8U8B
 qnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XLVsMWdtExaM9s+oU+lazgOsPzVgtcsSdhrjyJ2RQxM=;
 fh=2RkMa5QawuwenycGbpm8JfH3k+1xDqV/h1Z+/Z9Zzxg=;
 b=rBPqqj5rWVH3J1679Y9akiW3PsrUyuMCbUeXwa4/hI7i8bhU9JOwj0p3qCkOXm+8b/
 Tz/0LzmTsIGYbNVrWl1z0vHBTr8FGFKJAIaZJpx2+IMZF81TdZVV3lZWKuKXD2A5apFX
 PaEdzpreCN8iCpcGHtCs+aalCqRA0ZCDkr97h/GznJZUDVEMPyojrGP7SDxdta+kNV4b
 jYpV5UjHvS3usBxB5y2tU/QWjA/8J0e7QzLpgbTdm03FiWP2SzeZWKtDGzciWjC3u8b1
 cmF8Q80vU1d67dUMZ3LtbfzC8Pqe/XrT09/1mxGq0VFyiZJGlBpltJA0zg1rVH+G48w3
 1QWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786997648; x=1787602448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XLVsMWdtExaM9s+oU+lazgOsPzVgtcsSdhrjyJ2RQxM=;
 b=nCZH9vQJIYt3epmL1vpN55Dk+WwIOMXBZ3j9yiPA1gGSl0gKkAQl9Tr+WcBFckdf6w
 Xqlwi7EkdcG5I6CTXXjmuUy4saSbcvNowNQQ/5TP85KPUG+lw/tfTAgJAZ7nAsAu+Lx0
 rx4lDXpesSE0NFtIBx7jjDd1KRXTLonHRNR7JJy1dO2tfxJFfR6se2EH3TQ1hv70QSSK
 W4jU2rQyhkFMPoF7tare1ONnd5Uh6wj1UWuRtCWtcglNLi02cIZldlxM+58eBtqnbIie
 GjS4DwVIN0Fkbh7F2272iDDojEEq0GUVrXCD4hmZICIyK4iXPd5IAjOU2tV6L/HFFYgi
 VWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786997648; x=1787602448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XLVsMWdtExaM9s+oU+lazgOsPzVgtcsSdhrjyJ2RQxM=;
 b=EPhiHgRkGi3dmoz//kELr3RLu7wDE3olOOPbHHfCvlzUqWf2fHqhn4waDTC3gNGj1m
 3kzglU3B2N11/yk7L2NTyOtjj0B/ess9/ats15CkcO15M0AoM1dHYBWbp6U2Xu+da8AX
 vTFS9DfYJoONd/ueDW9RhKZFaqDlvJTLXk858w/zZje3dVH/ua5qKeGhzW5Gyl70kNe1
 Sg+ltQkX778i7ChfG3MeyQ/898um7rtUzT6xtOp00pw3XxGvodCaADfqj1rdGF+KDjzO
 DbR2f+6C3WhPxyED4ztM+yhEF8BBcDCWQyffEkOzPnDjKQh7P9a8WYnTeiN4yTfbuSzj
 0FeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWFxxgMkmFmdmrIU1R5tgrm9dsTr2CJhiuC1BpLBBw6FHs2RwAB1TDQdlWRvH/fHPOQKFiKICiRcg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYncuUnxeaxE0eqUt3x2Z0fl9TYpnD3LEHODIx6OQGT17aS7sq
 vRL4LudnGlgcY5zKzAZ/9W/+LCQubl6p3ze7rE1MR2gK6awChkcf0m+5TK5pFrdyOp5O4YEpJ3N
 DPRJIlHNpu9rGlhNSRfMiG99yb9CoBkc=
X-Gm-Gg: AR+sD11z3ZOEptegW8aLC4wB9zhebBN1up5Vr3mm4OT2R9ucr7W5A7kzBo+OnI2sFKW
 DccC1uuO+bOOkH4YkPdiCajF+GMhqYgWs6oamH+WiBdIO2Ku2euvdPgbIJOfwqINZWrQTRIlfJX
 r9ghjm9J7v69xpXOlt3pwFXuY2Nro0BWtKXxGR2BmlyFL7hBD8Lz8ntcmryFzH/uVM57cydC3Yg
 U72gZWr+beQa/TVD2CuakMNBDv0EIBSc3Zlae4/x2DSx5A0HCMInjWBuA6Ig2/g7F6eWvODHrnf
 0bClPdvTJBh9VJPjqdP5st/OrDws4pW15J+fJJfM9eYu89VzDOb6XTpKVUjYVH5AaUocmOFlJe2
 amV6uaN2dTZlLa3XbIVfVKT65h3UXcw==
X-Received: by 2002:a05:6a21:150c:b0:3c3:af85:85e7 with SMTP id
 adf61e73a8af0-3cc72094353mr31538761637.34.1786997648060; Mon, 17 Aug 2026
 13:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 22:13:56 +0200
X-Gm-Features: AcwNN1VtNSRUVX_S4c1aAwvBlBumGK9sX5NggnTFPh0VlTehKX72W5UNOW-1T3s
Message-ID: <CABwQupOTqnF8iSccT+imXKeOBbTxeUWHR--em3C3LAnwVBwWZw@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
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
> There is no good reason to allocate an IdPool with zero capacity.
> Reflect this in IdPool::with_capacity.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Burak Emir <burak.emir@gmail.com>
