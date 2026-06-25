Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565EACDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB5110E223;
	Thu, 25 Jun 2026 16:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="tMvf2haY";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF0610E223
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 16:09:08 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3995e22ef81so10101811fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403746; cv=none;
 d=google.com; s=arc-20260327;
 b=Ze816EweiwSMt2KJsMYhrRbtU9YTe22mUGEYiM3t6RKu7QBmZSZ0LzXD6k+Fa7pIiC
 d2rZCmW8FbtQBTJ94sv48M/vI0U72q3zutDn+M/Y8FechvedpGeo+W4V2Lf2Ce2qxAZj
 ymIUXm66BigjkMTHDfwGfcJsPqJUzoj9+BtRGhJeHx4ojATmE/XSCT8kydGIcsZM+Uxf
 RrH2Dsk7Ycq02pYMf8FOxE3s80kGkrabkoB2nJeLcxmO/58nCt3c0sFxIUiRTCEpGQmc
 dThCME4fX/JIi+a/MuFVfj4GNvgrRrx0exLnp6T8kk1+uM7+84k9qKw+Q0EYJnIF+cGw
 V+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9IBPKGa+ko/+Qn4PB4WhLtb/NvAeWTe0OpULvmkM2Uw=;
 fh=JWW88LYHGqk7XCHdIOseDlVYnvGRWdNrjuQqulRuXiQ=;
 b=Ms6nLFwp09HEYEwbPEOTFktde1585Gz1MNtZp1wbivxvLevM8otNWD+ajCwcOAWCY7
 CO1fnPOlHzAjZB3z97wv+hPRdlsau8ULvUfpAr02jYzxTNN5rd0QRLr2CcdGzLT8ai44
 ju7cni0lbndP/bHLJSa/inNWFAcx3O9SE5qKyED5iczdQY5wFjHH71cz6Fv0Oz0TOqZ+
 lxoFh5+XFs8RMCJ3bPdT6wzyAKuI27NYnBGEUn1ZwSRFyruW/8/WdxxG5eF7GSszBk3e
 wLEOlhS5Mf2mjuoWfV4BaR27+mdEsX0/1lhDmqyM8M3XXUhlA4l2I4vXXp/1cs85yf7d
 elRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782403746; x=1783008546;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IBPKGa+ko/+Qn4PB4WhLtb/NvAeWTe0OpULvmkM2Uw=;
 b=tMvf2haY+7ZrYcvmQlZoSrcQQpkEw0DbZI+Ak2iynPUVESTfAYbwWo+DRSH81vVDHx
 0y2cGq6ItMScMCwG13SIVSPJRS1xuJUFGwP02S1xfjiPw46Llm+CP4S1ahq39M69+Oh4
 5gSz5rCuQCFNTHK5mnmEaxVbjdt5AgI2S6yPnSdqRqps3hI6D37MQ+wULIuQ19fCiDNu
 DlW1qTnwV8bZyyYJT0cB6dAUZNr+Y7e6H7mNIjkmo3NHNerovLtZ8jwK/fVwOwjjNuOX
 GuQe2qAmnJzC5vlokYupx1OyGkzk1x4YuZ7wGqGuXXFfGLZtaBwrnKAfZdxq8HcZhEIe
 cUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403746; x=1783008546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9IBPKGa+ko/+Qn4PB4WhLtb/NvAeWTe0OpULvmkM2Uw=;
 b=jKYr76UYtoENxXioAOxKFqc6Fhkx3fZxpe9tXpendpbZtrydlXqG8msXe/q3p83x+Z
 JekpxrCC4I22YstdF70IH+BHDTLZNrqdEZAIqvdXic/39zjAE6ttjOZaH4jWiWPIGgaH
 UlBxSpJ51AIwGDBa6haDykzvGGwl7bVmWRw2r74mv0K4DCMQMPrU4fFwUiG9IuVPnM5E
 elpMfufQ0MppuW+cYP3BC7W0HLLcxBKGaj/mTRRYofpvofd3K7PUbrKg527cLVw08myp
 gB4GIt43t6NvAX3vY80/8quUawOkok+LdK3PTCLGKgvjwiTsNt6V7WAhQn+MSSMZPZaI
 B3Ag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrE4o+nomzH/khAwgXTf6m3H/gybiEZ8m7CFYHuCcLUWPYfAlXauQG8o5cnF3hB2I6HxAfAxDJ1w+4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztBV6pzUTnzQg3f6CpJnCO9+accbIZXREtY28Q09C7Qe4sf+D5
 wF2GAGKUi9y/qHHysFpgDCL3WwBR6kAQJ5L+LxFgpEh93DJUG+8KmSkFZkcZRCg1HgI+GvjmYNW
 wkoAKcbGGrXLbNf4yIgWzBPge1hGuxdr4bsq2FFK1Y4gkSw9bKcErjAm/
X-Gm-Gg: AfdE7ckytqzD31Dmf9UxejaYUlsR2Ws7k/qZl9O+vIieO61vRd3Kh32PXs9YKzWSxMy
 0J3XZCnMW8S5QAkzdh7QoPWOoQroG4YYIHJWtlKYbC/zT1tr9JT5I/3estDxSgvt+1/ICLoZuK3
 OH5lI4b4H4EHS9a6H9IEobVPKwhR71+35JeIUSNDUTTNBtIa8OjvL+PXpwPFIpKfepFrdPX4o5N
 yQVnw8QI2KN995uV9BpWBib49Jwi1UkschJcD+awGBSaUCvqJyAZX/6XNdyXyu5lqnlCMcH6D8r
 Bvqv9swMYZmFXMxw37zAP+hQug4=
X-Received: by 2002:a05:600c:a00f:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-492663e185dmr44582795e9.5.1782403735036; Thu, 25 Jun 2026
 09:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260610141359.1033755-1-gary@kernel.org>
In-Reply-To: <20260610141359.1033755-1-gary@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jun 2026 18:08:43 +0200
X-Gm-Features: AVVi8CfZFCVmJzGvs9T38hUX91xJ32YYE_IUbnGa809OzGjdboCozyjSOBh_LyU
Message-ID: <CAH5fLghw1B=3dFg252iqgHWv58Q+De6fZCMCUAC7KcWq=WSeFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: remove imports available from prelude
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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

On Wed, Jun 10, 2026 at 4:14=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> No functional changes intended.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to drm-rust-next. Thanks!
