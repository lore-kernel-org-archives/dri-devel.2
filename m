Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F194C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B845B10EC13;
	Tue, 22 Sep 2026 09:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSCad90Y";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DE310EC13
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:05:32 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9a2b95b72so6269187a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790067930; cv=none;
 d=google.com; s=arc-20260327;
 b=RB67fHCzCikIZE8KnLH8GugpN9fvXhyRqMtGLUm6pasmwa3aDvui1JadMts7hek2AH
 zgjKZ1ll7wzodw3aV1FvBU+qqGINTNy7xI9b4FI+Rx4WoUUMZAlnFKYy3ylJYdbubUzR
 g89OPNJ+6u+EZZyvZPzDMSG2Dq5nmUalcPRUBcMfMu7u1tCpkbyzRJBSiYKAzry481L2
 KboUlZR3q8OmCMGns2T1+kSZUG+Td/+2S9o+7n33vn4eDIKfrGxxy3VV1eQYJUQF+vq1
 ykLrEeHnyB/kk2CpSAME4NhaqjVPEh2wMFuHpiMYlzykqIYEcjaWYLV6PCSkIWUzCrPx
 4Y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
 fh=yLCSLf/Q/xRu9VtSYL9NOPGDK0fp/OLT362RwBNB/gA=;
 b=e8CFJ4BBgQKpr+7cGBZH+VurRrbu8DEd7cx0NIkfTC+36lnx5XI06ZwTPdPIvjozx+
 zogTWmEvsd6Jv95MuHZqMvytuQgFZtZv8Ujsk0pMmJ9JGNBu+puIC2bNjzil6K9suZ5W
 8SQyzfT6mLRrxahEDZRzbSL8ZTiISAr/mB8LM5AfpNAjfCle7OyzoaUbvDxv5d4ag72P
 GItRJGd9BeJVInp6Dd6WnR+J29FWqvpbsHjoYZeOxHd/LtjWK7Xk+zJl1YwNaVERtg0i
 d8NbXUMuO9bknRrbz7YKK92NUwwuPLAYA112eSYqnRUylp4Wl/JPPxppk/+NfcK4APl+
 5Ynw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790067930; x=1790672730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
 b=eSCad90YZIgyVfrOAlHFhT7pRE2DBbrCMg/Ro+A5JLKwuyjs9s3OVR+Nj4kTHyJsdX
 uDfb9TThR2MegB8Tqx07mziPFkvnQ4TyLs8D6s2UEQmp4gbxM6ZcmkFHd6Z236Ws6Ztf
 7L0cDkRPorngHkigxhswx0+WZow0YpFF2GjqOIrOOR369bMnXdY3ysYD6uIIw9tR/6tO
 NYejkRz1pHUKSGT+gvdHpePHe6IblfNkUknjt74jyvmwJHQ7KErW/YzExG/32vpiJAfk
 IjGAdjhhPcM539FeXOJB948kTt3GRo0FHjdYYGHOnAtVpfVtExjSOVn9DqKweCxVdVrI
 Aa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067930; x=1790672730;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6VxrMknAVb1vDWNanfZgZOBYSwjkUtQT3TOXrqHvrks=;
 b=Ju+FeioJjXS25WdLYDgf1zl0+nRCkf2qfwNVP1JgsLk11WlmTUWM0WQY1S7DaW8qy/
 OdOt2z6y3BZMu8G+AXVTNROXMb4tcL34+Y/6HOoLDMIWQc8vMvomWNBEcH7SSyE7Zy/4
 XynkW6MrIrFRpVAqJQoT5R860xDGid3j0EYpR8zXOQ6bt0a3+h1jfXVEpJ9Gzcz2hYaQ
 vSpsQ82ddbHWSRp9QwDuMGJ/EQ5FnUz8DzV1s7xXysVd5wtHHDXbi4UT4MAs1CDa67iZ
 79FXI6I1Mqs7MeO5AyHcvGaQD8ZQvtMzCuQSfawU6ohSBQFp65ns0Wne1yXU8OnZ2GRV
 M0tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2pR/qy7p90aQKY/WZq/5/ErUQzTjwOnjAS4PUSN51Dgdw0+FC4UQImv52wwE3cAUbQbvC0IWZlrk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++npUmZs3dRbCcPJJBrsfU/hsFAFHht69lg7QSSwY1S/+JRSgs3p
 HTY8sxZPNKp7OegRG9GzyCLMjdFKdkttOPfKmsU5JNXSCCII+4UV14u4ieU8FvcpXcS5d4Ne/wr
 8/e7qjGB7DK0T7FJcV4eYc2DgeOOtxj4B13V+s8XFuA==
X-Gm-Gg: AYBFou38rvl30J0b+Rg3TByifpZGIZ7sOTE+7T5KfqQeG+oKruijhrLRdfjC38ix/rg
 dmRDTe2FH4hYcAWzyr/+hj/WzLTDUYXVjnwzcGSrC0mBWwgb/8UjBL8S3Kc/aNynGMsSwkbqO/7
 zO/ACLG2MuzlzydIx3jR8SIttfB5WD6HQUBnHgrwiBjUyaGuMNtXL6IwEfikZvpo3NryeYx00Kt
 NuBXZb8EuKrtS2D3zqQN/0wxOlQp0T0JOZKoir74YdkD8jIQBcyA0STSzylR4Z8l7/fVEVF2ad1
 SCErT2drd792YHvN/bxHGjILdvrCL1CJ1OjRtvQkJHeekJwjGU7fr5qKXBGjDj9shi9ADPhI/uV
 moWkEjuB0x1Zog5YfaWH8lSr62jn/wOBivPYpCHSdDry6bFvUmUrYG+iNUoywqL2eLgTsUjIcgZ
 ajoRgcrR8FEHDt/z0H30u2hX0dMGcd5nNu5EaqOOCcfb5UTED2XbOY
X-Received: by 2002:a17:906:c10b:b0:c26:19de:9139 with SMTP id
 a640c23a62f3a-c2a15cf8ea1mr1261725566b.44.1790067930361; Tue, 22 Sep 2026
 02:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260921183313.92795-1-hikarialiyev@gmail.com>
In-Reply-To: <20260921183313.92795-1-hikarialiyev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Sep 2026 11:04:53 +0200
X-Gm-Features: AcwNN1X5O3CnNVl33I3dVh03PNniNtuSKukKjtL-OpPtcpVg5gCiGP8Rn-l-Dyo
Message-ID: <CAHp75Ve=Wxe=2VjuEyMaeigskU=CmWDLN0baFbxwJ54pKDponw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: fbtft-bus: remove space before close
 parenthesis
To: UgwuRhema <hikarialiyev@gmail.com>
Cc: gregkh@linuxfoundation.org, Andy Shevchenko <andy@kernel.org>, 
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

On Mon, Sep 21, 2026 at 8:33=E2=80=AFPM UgwuRhema <hikarialiyev@gmail.com> =
wrote:
>
> Fix checkpatch.pl errors regarding prohibited spaces before closing
> parentheses in fbtft-bus.c while retaining trailing commas required
> by macro definitions.

It makes no sense. It's a false positive of checkpatch.

--=20
With Best Regards,
Andy Shevchenko
