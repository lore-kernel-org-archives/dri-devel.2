Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A8FC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25A210E474;
	Sun, 12 Jul 2026 14:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uZaRC0tZ";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843C010E474
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:09:00 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47de008b020so1129999f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 07:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783865339; cv=none;
 d=google.com; s=arc-20260327;
 b=IHRja6oFH++mtmgT8rRk2Vgxr8JFMVcm3uziepf+5Y2sUUr8o1DhINw6pADB6WktqO
 DUe2LdNyWU7mHQ7K6fdw9Alvc2pYfzwCDolegFXlZ6tVeFQCCFIsI5K4fh7HQTRH9Dzv
 JQ6I0vBxz7yrcjfwozcODGAGRH4DWSwTE0dFzZkhHZMzXwVZajlxf7g1dkbfpn9SVVwk
 eRklt5SGVJLKsXvVJ/86T5KWNn5/xB32H6wC68LoF+8FQbxdauxa7BM6cgBmcTZuTGbC
 JSIJ/IeUR8Qvum2pPcOAmvz2RsVMf0eGW4V59BHmhf1jKJGtPNR1mX9WuGEqvf4WeSvG
 RVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OhN46kwiJyID2xs9srGI95r/1ozLnBdNV2rPzyVcP4Y=;
 fh=0cP7GaAoLj7pbjaBGpb/XHudbW8rIbaXWFsHPY2TnWs=;
 b=KkuSaEmuZZzrXag0kuFDQ9KmcN6cwqhfy2r0uxUoPYMIU8vy32mBVOfF9i2KQNfe09
 snJlXVBTN+iZMzQ7HQ5Zvr8Pk61XcovDd2AN/LA1umP2vHhsS9FXpIcfCcqfa94wnNjh
 OoIAtLdNLj2H9TriMGNyBb5d1utwRGkBEXjb2PAVY8l2l1kvow9aVQny9xY5r1+oXAOx
 PFWTk1BbFhSow/2pqPgRWSWQG3yABGX3KAzEJnSwOOLu6vlwIAivc6Fsg32kO5Rtk2OO
 FxxZQbsOYydaEpm551/Eh4G6CfosyDSGq4DT9LbHWU8oKWjPKVcWm26ggv9Eror03zn8
 YEHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783865339; x=1784470139;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OhN46kwiJyID2xs9srGI95r/1ozLnBdNV2rPzyVcP4Y=;
 b=uZaRC0tZbaXlKk4qA1gzbtk15Bnh9c5Q1MgAIIGhWY3VF6wqUrX4GNomBscQpuWCV5
 Zw/AXI0OvIvaETklwid45olVpdyUzymmkt4O+b/X9zfSRkYXKcVtgQcFC7+bnp4orQ/E
 qgXMSP18FSzprhj2YsB1dnJLcqFGbLeBHI0TsPE9OyrfL/MM1f3/ckJsNfc9pVteUSWZ
 R7uExHY/zd2S0wpoXa1IfdwJqRq4Hs0bIpLrJ7ZYAZBywOLeChfyhJzg/QumwoUo6hTm
 c1Q9afCY/dC9dHEEjEBdvwlEtckkI9jyOms/iXqfjG7uKrxzHYDMhpKhw7aT8bYz6qO1
 g4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783865339; x=1784470139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhN46kwiJyID2xs9srGI95r/1ozLnBdNV2rPzyVcP4Y=;
 b=iKvrVwqeBPaLor9bENNCFaQO4dbW8tfpeta7buGUuLpRLCCiql6o4qKADcjGJcGALB
 TJKyyeTifcYDZOs/VmlzpNUrZNDjHXxilVha5kZzPYn1ntx6TLuy/f3E/YlWFfBWoJjU
 /ivhzHCK67GNJpmNxsoktQJ/1CCS8i6/l/NVtR5ttAGAsMnNbQtBh2NUni1HNhL5JTyL
 w7IDoim+ToKvnfCVuoB9M7JPO02cWVssgSRPMwbnejBaWhyeapeCulSRw+pmoc8clmKG
 XiqgtYuVZrbDJ8FaLEN+fL2QOezcjda8MPcuGnjeOlInmNIlCD9jw3yy5I2jBLadydIs
 xIKw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+qtPdkEEuEiClWn2zY9oPmHaPdV+X+YHeRrp5dZSGObEPpc5QTK5T3A2G9JZh56Q+n7JDYnAYH+U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPszrY+pbvecd1/lF69iBzQmFqDjyUjLhw9PdFB4vlS08yvalO
 w9OPszIw+W2ZTT0Y6pPYzqIqrUDn/XzmhcAuWigFEP+FRTv4GrTBE2p3LqLl9tsOYrPFh/jgT+9
 ZdKHj/Xxrdn8kWSe9mcmM76R15uvQV2IujcOufoI9
X-Gm-Gg: AfdE7ckMfgCrsiIRGphr45+fDJCVHOfOyHlGM5Zl0892Sw+iflv2QzrYN8IUwXQqawm
 x0g981ZoWFsEK1Vr9hAMiIjZE2wJy7xTUVUHnQ1I16gxF2uAqDdoecWJvHwqxD0n8TJAOjMIm8J
 GumIHqhadqYHWkL1JPZ8xkcyzUf7YzttOD1jA2Nh6kiKtSEUjejIa2q/PH+/zc8d7XMJX+14DL5
 80uo3pEz9h/QKzVvT29JEt5BLvoVJGHclC/vS5XU0V8PVVTf3CKurjXWnV0fUFW8MgTjuW3Txnb
 xjOQsXM9cGINbAPHxssCLZfbgl4=
X-Received: by 2002:a05:6000:461c:b0:474:a0a3:df0c with SMTP id
 ffacd0b85a97d-47f2dc86345mr6255714f8f.10.1783865338431; Sun, 12 Jul 2026
 07:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260712-docs-drm-feat-render-rustdoc-typo-v1-1-c9df1cbbce4b@younes.io>
In-Reply-To: <20260712-docs-drm-feat-render-rustdoc-typo-v1-1-c9df1cbbce4b@younes.io>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 12 Jul 2026 16:08:46 +0200
X-Gm-Features: AUfX_mycHM_jQkgK2zFdp4Z2txwSWvgYY48UKO-G0U06UDfohdKyzRcwH8XJmjI
Message-ID: <CAH5fLgjHSU023AO5SWbC9qtNsLd70xQZtSq3-EPdBU_CJOPJ_g@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: Fix typo in FEAT_RENDER documentation
To: git@younes.io
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Sun, Jul 12, 2026 at 3:40=E2=80=AFPM Younes Akhouayri via B4 Relay
<devnull+git.younes.io@kernel.org> wrote:
>
> From: Younes Akhouayri <git@younes.io>
>
> Correct the spelling of "privilege" in the DRIVER_RENDER Rustdoc.
>
> Signed-off-by: Younes Akhouayri <git@younes.io>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
