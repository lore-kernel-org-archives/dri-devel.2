Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A5C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 13:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A765210E067;
	Sat,  4 Jul 2026 13:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Se96sFgD";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A072710E067
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 13:00:21 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84787ee07f2so422473b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 06:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783170021; cv=none;
 d=google.com; s=arc-20260327;
 b=FUA4JLiJR+i3URTnz6roFNk3dPk/IM1GAW5b2KyRov1er+T86KhTKRZBd5o6/D+ykh
 /5+Ykdyys3mY1iSy+jGf0kzrdZU78U7oMjzRwEV38BO1uh13/1LP4Fx+AUtSBdnoEFdc
 J4I2iSjllo5nz1aOaghrUkv0L0J380P6oydKerU29biGylc45AWpFvLxNfeky8OLif2w
 wgPv/1+hAFb8TXabhnlRU2mMDcA+4KTv72dXLcLJcEb0HUDQapPPj6Zc/dlkXVcRydvg
 qMajVFLSuOPogIbtJGM4EZ/VjhMF31ugozhmAY3Lh4DEEd4IOMsCvqO4GFf5eSFNuU7n
 P/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WIb0LAhy6ZohB5fTEBHLOSF58e1DkPpYw83fCrDECVs=;
 fh=SA3wJr+2a+Om7K/Gs4ovTVC1i3qsLFkKDiqfYZ43xRs=;
 b=piobM2B5snksIJopq53XBgXwOXO+OHuA3d8jbLBU/87wfdmfFSwz30hPdQJbV5LrLQ
 NmAUfwMyKcbmojW9mo88wlvqDnk6NhpvvQ+YQBTIY2+EnBuv7PIaJZoVOdCQ23WlE01l
 3gN28BbHCetBO8WmtBsb+tSsZH2Yy2nNS6e6otsvEstgp/XSOPxmPkCMutlCm3smD7V1
 3X3e12hD6q+DoPonF1aEgewVFOgMzabMXNG87OF1AyJfTqTZSWzPokJBM8qTrEjkYy/s
 +6qcnUssGxgxnUVr/9harCIWR7G6lFnhOKaOaxweBEcT5bDsQQ4pDSUfkmt/sKRVS+eX
 CtZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783170021; x=1783774821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WIb0LAhy6ZohB5fTEBHLOSF58e1DkPpYw83fCrDECVs=;
 b=Se96sFgDaDdDsQ9rvx9Ef+SazWKEa0vXha98kLJrGiMfuwScQheVgQVFsLFuJ1jt3u
 rDuhW7p/DOH8NaqoTcz81RpQcqFJE3pkO1w17mA3gRNPPTk+G5bOxP+xCjrwTPKdeviV
 e1wxr6Sfrp0FKhxOhX8EW4ZY8LNJr91A6SuMhULBoyyBcVNNxfOxqe9vuW2I+nkwdSpm
 1eTT2VSFFXTQ+cCKRBgBJBTY7WXMlLG2Uif2m24nEv9sO6C9XeqeA+n1FYDAURdXyL3n
 ujs45Vl0rCEKyKrRF0hqxB3Kjp9pMp4rZMzsRZM8LCaeNpnIRxQyUQT+A8DEnhpLvIm7
 a3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783170021; x=1783774821;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WIb0LAhy6ZohB5fTEBHLOSF58e1DkPpYw83fCrDECVs=;
 b=VdWOVa517RKYxdSh2WuZbm92IdVf/ahNDTI5Mqv1u6bViOd/+B62ji2hBPSxkrupdZ
 BhG/sKwrcP6e5mSCVsstTlF4uFa8IMArP2n+HoBIUd0j9sERvjX1i4YHHEr8Y7FohHPr
 K7kuxoAbl00UI/wLCbJ7JI1H3/IKEL8cLkfTiXorTp9rvaj/c0UjYtWH72zbUI7UFU01
 /ZjoT15VdkxL792BYFrrYorhJqATKZm2oIlabtnvzdp3GFhrlPmB0hKa3rOPpo4WYtpr
 rsfaG5XRnrdrA3dn946k1XxjMLDroI4k3spipNpmWDm7eUn0kfN2XjZIJE7yv+v5TYOP
 Kq1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJM5kj9+o0LtF3u3LDDmT0PUMXrc0VcPjEsvK10Xg7KwRZV6LpQ6o72g2jr6esvGTaFyZLmR+xl2U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBBlbEYQvB51Ph5PFkKB1ssMQt0ua93fpCrNvkOKzf3+fVRr9p
 Rj0VZNn0iTPboQyylChZsN4jEmj58OAG6oI10oUYAGG3MwyDOMw5ST6KqwfM0ofggUQLBdXQuAV
 eAPcszVz5VgAa2Ii4HQ3IRIzdjN5shUo=
X-Gm-Gg: AfdE7clPdDdSXEg7ATVSr+o/I7HeTLTfVFtZc9PFC/vkm2R2eJs+LNUdVBE0jPD7KVd
 cJQVpYM9hVkkFgLoBF7DRDtIp5xMqlcuuuGkuxhYjnjYam1kupfzZ8vhgiyIj5aw28y4Yyq9FWq
 g8pyj8XaVwQ3A2GB7UoMlFC4Gq+AtajfxEKtwfR2czyLcq7Xd/WLRp1bGBYwnOfsNYQfw4a5nni
 K1f/pi7TMUaBivJx0Ekly7z6La7AwZIXok87AoHUVgSqNunMng5MiD6qwcjoxLQxEiPg8BmNG++
 L6mITMSxFC/nsAlKJfQvKpk67TttrNqZ431esp8yHemMxFR7nK+0vZrj/xHLZSeSGOLMewVGtXI
 p5/Ez7+1ksod9
X-Received: by 2002:a17:90b:3e4f:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-382802bcc65mr2215108a91.1.1783170020948; Sat, 04 Jul 2026
 06:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
In-Reply-To: <20260702120324.40388-1-niyudi.honda@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Jul 2026 15:00:08 +0200
X-Gm-Features: AVVi8CdSg2ksdLfnEyguJvA5pU1IOucVtgAfWvHPCYCaaf11PZEGGbNUW2d7mys
Message-ID: <CANiq72=g2mXOPtobn4oQUUASKgJzX6LOpuEvUUBH75UvbcUVdg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] drm/nova: replace `transmute` with
 `zerocopy`
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, apopple@nvidia.com, 
 nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
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

On Thu, Jul 2, 2026 at 2:05=E2=80=AFPM Pedro Yudi Honda <niyudi.honda@usp.b=
r> wrote:
>
> Resent because of wrong target list and wrong email in "From:".

It is good that you mention this, thanks!

For future series, please also include a changelog between versions,
i.e. so that reviewers know what changed :)

Cheers,
Miguel
