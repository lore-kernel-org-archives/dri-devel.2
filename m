Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2A710F3DE5
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 17:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F3C10E0AA;
	Sat, 28 Mar 2026 17:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rnp5eKSl";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C860C10E0AA
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 17:50:12 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b97ba4c2be2so415985666b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 10:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774720211; cv=none;
 d=google.com; s=arc-20240605;
 b=C9zSI1YaveprVVEq2iuF+J05GzJ4/mfTrC3rzqXUOxIWW7OnCUUVq4xpWJAL2+yDox
 bYrIhyy3yHH0SBpB3KZdMANF+RIhtP0pKalhc6gTNmRtU7E9COUaSNkYTXmIs92f3396
 wUccxNcCiLEBj8AP6pNTy1VQt/lKAndB+IFR9Kzny1twbmSB/ZgVVazVIvJjkFegDDVa
 nwY04MN0ZzLVNb18gLkWglZv0rvYd6VEZHSHa6gqCJNSH/SZ1YsqClKegds3BqTS99uq
 ngF4Sip2GNMWP0uiBb6+CnPWmSJ0wZhdKKqCAmRVUiRvGtsN0idaYvZYCnkoiWxu1qnj
 J+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
 fh=8Lw5uciBYSvd0ShuARV+zT57/XngiuYNDOKDnLEi45c=;
 b=jMAdyIA4bxcpidISCIFk4OfvxGGstFOc3uJPcvPM19YgVq87K+oN1T4ebqV9mVjoQU
 yAsZruV90xMGOYaKJ0PL3+Woi2hHjJTsgawTzoALQ/AKrV/cDUOwJ7mmtf7D/k0FLI1p
 Rh6UvlJG2y2GKJvN7CijbWDUBzzjRZ7icTLrI4qHXRcucLuQBXP6rCVi8KWUdgCbrel7
 j7lSeAl6HqbQApSEsjUsHDYLzm+uSK87ZVOA9hVHyThI0MlWU+aqXkEv0I7PTwo4W0n1
 Xe0cxwP0WxT8lqqMjyoGzFvj/rCYvq4eXRF9mfokXobds7BcEHXkBizkzHQs3y+OZeFq
 Oouw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774720211; x=1775325011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
 b=rnp5eKSlGmWSrM0ukCCdNNowYBgVecoS/M9hhhAGVEnS1dj9KOHBW5kuTBuQ/ZRcuP
 14135BbTFSW8yNNTtE8RMpMrzWoz3IK2yJWozpc/ONx/AvKmwPV0N46ub/+mnQtvD3oA
 xmZOCqmidDaKYHLTDfT9bmxFx13ZALr1prRzlJwzVEp4GjN84kowMUj7qjl1RAityd7Q
 I7RBcYxgdFAAmWxJRYY0fHp0b5wS2lGAW7MiudqHJogda/aiylNK2pXIkIeITFvwLeel
 p/DA4TdCCBHT2It7nIV/+veeECujyJB7A0G6RoR5GQCEynJJDoAtX2Oii/+u0iPvKhc2
 mCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774720211; x=1775325011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
 b=hheKsEdOYLPwbUgt8vrBs8jHRSiMp9VFlv9FxTk7sSa9snhejNLzvbffFuPpq52wT9
 WF7dpVbSzNO8c0bLMg/dklYfsS8BEAHBizzv+eKP2lMZI6nomI8VdIavFsNvFowoOqbS
 Z8Ui+dH3EuTSkOoS7pHBSnEf7TrdZXcHdX+/CQuQmsPT7GAzmueZqWzriIHZ9/wiGRLs
 YHxeBX8tOmbBsLML2QwpqhKnviF9y1Fy0sACFX91kvGYUz+Ff0/PxY9x4iTUE90+ERHD
 yaZ9f+ONAs57udQJo7bC3zSzF6Yr6E6hgxGB1CESOpjnlJfM8NrwpRUOMtYWvybOOv9q
 Jnxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVJ5RXdu16EXyNhcE3BXCSXVylDZhK8Ek6MhD1B4tjo7BjELUIgnLvYInsyiky5j5URMfNIuCPi74=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUCc9gfYv25goE+EPBBHsqBWc7S1x8Yf2/EHW3PBZr/hxYst1K
 j5WMxPmFgTZMMgo49nCNXEOh4sm5Jvzai27l2HUtJEG6YhbfauqrTCqGc0BIg2n6M/sET97nPmw
 7Ey8QWLj32wtZ7WefIJXZVjuEQV1vAZeaSGUt2gw=
X-Gm-Gg: ATEYQzyHshDAZ2bTxh3Eb3sobjl+U00cVekpQu/XWFvqovIrFefNrGFJ8YKt/vl/vLk
 hwRzkycwVpKJsD9+GwTq7S4T1gohZHBKREkmSehmj+seBmp9fykiXFDkakxI8HhIgv/NJaozK+a
 9ab1tR6DiuaAvnVsM1fiCsbf8XK0d7Hh8+hkjXOG+4dfFCbD6eHNYJPgIQs3aETHhLazJT3nkSB
 cF7/YV7nz4OiinQH8cTqirTQCD45bYc/AKBkeIO7oILx3d1lr5jEzNxDJAnsFsbfq9rPy1RjaC6
 t6d53njoDJW/Ce8z6UjUb0KFthnU6hxnOL8hOKPzaabRBzlX4Ntez23s/Zo1BKfWiZGZ34si336
 9et8CF0U=
X-Received: by 2002:a17:907:846:b0:b98:51d6:883b with SMTP id
 a640c23a62f3a-b9b502bee4bmr483537266b.4.1774720210902; Sat, 28 Mar 2026
 10:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260328160114.1143108-1-caiyuhe80@gmail.com>
In-Reply-To: <20260328160114.1143108-1-caiyuhe80@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 28 Mar 2026 19:49:34 +0200
X-Gm-Features: AQROBzAslN_ZWujLGMIjg5dfPBwHz5pbP2BKbO1h93l6if0I00QuCKVboVXLlB8
Message-ID: <CAHp75VdGieY2qTZ_HeODxLMW8P2E3O9O27K6RRJoujxB3NZ-DA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: avoid empty macro argument
To: amanohina1 <caiyuhe80@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Sat, Mar 28, 2026 at 6:02=E2=80=AFPM amanohina1 <caiyuhe80@gmail.com> wr=
ote:

Read Submitting Patches documentation along with
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/dri=
vers/staging/fbtft/README?h=3Dstaging-next

Act accordingly.

--=20
With Best Regards,
Andy Shevchenko
