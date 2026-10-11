Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D5CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D251C10E30E;
	Sun, 11 Oct 2026 15:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FzLcNe1B";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2146B10E30E
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 15:51:30 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-169be2dfbacso1794c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 08:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791733889; cv=none;
 d=google.com; s=arc-20260327;
 b=k7ayNvBnvGXry4fZfWwcFJDW36ngliSqEknAX0+0kZUlCudIkSc0+2okmuGmu0vq2k
 Dm60BLDQni/dzXMf8smsqruTzDsHow6KfknRCdq12gSeRBL+KVUuTPs4Wjbh+qrrZW+s
 XAi7QkQHBO7CuqKqdwxhh25PwEqPN+zwMUnVzsI4WTIgtYd2y7QC7GO294eKPpRZoR53
 8eNyFtE5aXTUD/cQDWLMoCGE4uOwISSZeBjShpL1+dpJV1+WQroouCXAhITWTaOYH+ZQ
 AoWXy6kypQ2LRZzrcwGcXN3L9Lu+sl00WH+GN/2U15e2QUIpJbO+BvSwBbZ6wHyjY7N3
 xLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PARpiAioxVcNkPOHU3+6w0RqdWPgrhBEQsd+ZWP6NEs=;
 fh=vXD+UrY8JeykfWBQo1JI3gbjhF48AVnG4q+9Hw02DfM=;
 b=YxBZSaydNExCPpLfpqWgWyBnT8YnBMwycxy+nnTpkYpfxlTj1kMQrUS7Bu0NKIBYD9
 XXaymyzEYG99Ph9MIHG8C85KPHgC9lVxMAsJLGyqpzr8myK7FH4+w35DyuuoPDAvlULl
 iE5jwxmoRgFwv7j8oHApW/9TJWFkd2x1B9q5O2G8ki6YkOxwaI8d9yZqafLsFdMenUs5
 bBKLVg3Ql/Cpau1VYcDWdhl/Dhbzm9qr1D2uc6nrPJzhYjP9FPDTuwvVI9EkhjqeZvW+
 BtxCfiN37nstJBwvPc3BjjZ38tgT6kW4N7KfANqrqOeXZoIdGHCZQaG0YodzcrTUFVIm
 Fy3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791733889; x=1792338689;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PARpiAioxVcNkPOHU3+6w0RqdWPgrhBEQsd+ZWP6NEs=;
 b=FzLcNe1B3FfQuz6ICKvkJjjHKGw8DaNuFYX6NI02UDCbtdSARKMfpdeEFoZvGiKNwx
 XUmqVbj7GJF+NCtIVM4AunFKIn6EfKfDuK9X1ntJbrHMSsvfso7g0e9Kdd8LgJnUx+mQ
 /Xcoe8py3RDzfXYYJN4Yet9KZgY2FEhgu20iQXG6ipyGdJuXWiqE828LHnEArNfIXYRf
 RM66755VMXxwXMNphb12CrPHfCiR93itcE706aJNyflLYvWFLHllU/b/jA7SXAnzmSx6
 j8HqVyl6TprF2nUikeTF1Aj6EC9AzfdMzLWDVT3Thbh/GLdO8dZk2CB+r+ZD8ayGZJFR
 w5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791733889; x=1792338689;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PARpiAioxVcNkPOHU3+6w0RqdWPgrhBEQsd+ZWP6NEs=;
 b=kbyzGfZDihr/rndKYBmYwgYbosf69yCrExW1Os6fTZia/FqB0bVTj9cveI5yRTY39l
 NBNsnvO5dr6xVOBPmFWApEWUjDdBd2ZT4RNCFOdXPGpJYedAXOFXKwj69u4qP4ZHDttj
 3Dt/zAKwHvLFmy4BvTBzew2Hj3DoDeTYzx07DjQPNLps5UKV3dUSSTRRzI143zCZNNQG
 KTHiyRl24lmY4KdYw2MoYeuV674wgG10Xku+xD+7JxZx7OQ3NJ19BzxA2GeD/nKlEHyu
 XNHVN/bgMC+xmEvZQPaoqdJLC3QGCVz50DPZN1scwKSsVmZ4mHRyDuZAxMCxjzHBlx0W
 oHlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygT3E+RLuiCMdCst1r2OpSCFInQMlUQgnxf5wRV0hM4M/lrJWE2AywxJFZcuxRsTxd2t737i/RZ5k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIiXvLxjgYAH6GAiS/EQ7UcEpp6RXZcyYKXb1rggVXvAmilSxZU
 h1XuTUt4x9yT8rkK7kyc6IUd4ey8lecc1Ev/qcWW+oYuS/fWxuPmQv+i3vKQHvvPnW9z7dJLgZZ
 wH3J7/Ir3+qzhBfCIOHGVHAyJzIZ+EFPyPdo3f87p
X-Gm-Gg: AYBFou3FsxjtfynPJ0+l1zF8HGjVLK6C58jTiX+aE6tnCt4LLyZogTgcDQC94T2/DSY
 aQEExnwujDLDuPtqxBtTbagzUS7DYKSaLpn9ph4xxZ+XKh6+p08OIdQelkM2n8EMyNaDIapFqZx
 M8/if2ay68zM9WbyugfDw9ATjRpi4XGtLNyzW4f9HIUQX3RNwxib5PSsRd/mkysk837EmTVlZw3
 1hHFg2zrCEPL2R2DlpdplKsTMUMSAiksZwU+ASc024DH4m16YhYKuQrz3NtWNYMPrFjxKwJNKHl
 luizJ/lbPvHxFeCFtfiIysygRh5+XAWvLhw6IwSb9jo8rukiLmNDlw==
X-Received: by 2002:a05:701b:2506:b0:146:85b9:974c with SMTP id
 a92af1059eb24-16e81b7bcb1mr124139c88.18.1791733888132; Sun, 11 Oct 2026
 08:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261010025532.839559-2-almasrymina@google.com>
 <179168989611.434549.16378879758158058625@kernel.org>
In-Reply-To: <179168989611.434549.16378879758158058625@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 08:51:12 -0700
X-Gm-Features: AclHuK930gGDDJHBRZhLwx30RqRng6RPlhHFuLPE0htp8kvWdbnGSu8mFAUgs1o
Message-ID: <CAHS8izNWaWF5-Zo=rqaUzC3joNkwoYnrxawUUVn73BJEaPSGFg@mail.gmail.com>
Subject: Re: [PATCH net v1 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com, 
 ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com, 
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, daniel@iogearbox.net, 
 razor@blackwall.org, tariqt@nvidia.com, kaifengw@google.com
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

On Sat, Oct 10, 2026 at 8:38=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Incomplete fix: a binding that has already been unbound (netlink
>   socket closed) but is still alive because a TCP socket or page pool=E2=
=80=A6
> - [High] The patch unmaps and detaches the dma-buf in
>   mp_dmabuf_devmem_uninstall() as soon as bound_rxqs becomes empty.
> - [Low] The comment on struct net_devmem_dmabuf_binding::lock in
>   net/core/devmem.h still reads '/* Protect dev */'.
> - [Low] The comment on struct net_devmem_dmabuf_binding::ref in
>   net/core/devmem.h still says 'The binding undos itself and unmaps the=
=E2=80=A6

The findings look legitimate.

pw-bot: cr

--=20
Thanks,
Mina
