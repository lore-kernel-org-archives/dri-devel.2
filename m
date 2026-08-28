Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4858C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C809810E3EA;
	Fri, 28 Aug 2026 12:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JOD/tATy";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4396810E3EA
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:16:22 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d01548ac96so711455ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919382; cv=none;
 d=google.com; s=arc-20260327;
 b=nniNwDSljZxsHKEg2/7SXTe6RFlFvZfTzMxmTO32VW2z0fQ4k26BC+/c5V/hgfKevk
 SQSrg1bA4qNY5KWhYvNfVLT+Z7d6070vBwcCP6qjXAVEYLIDJK/RpomQJqXW5ZnUGD/n
 4T8oPPm1ksZiBxfDtFbI7xIuo0KW+Uoj/atPHn+4Px5FWmhbvBYjsVAueZRtCPoTzATx
 MArwCGVY8/1JRZ4cuHTk9CtNqqr0b0E3BNww1c4GzUxkJ6RCYX+Spws3M/Ig/Z9vR0x1
 GCWmX6ckytooueY2DnMYEUJ4i58Ap8dwPHQOd4xMIh5zlHDmi5rSzcH3sDNULDRoccIa
 Cyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YJeEPyBPzLxDNEZ0JnLBB6831Z29vJZEqt0XxGqWMq4=;
 fh=vDm1gwEf0d49qcr/focExHrJtyJ15pT3aEUQcBlTDbw=;
 b=DljgNluSTLsuWV2lr3JrjBlL8yy7d0lQ+Vhg5DZdXE0PMgF64YhVnGYCvcZTY7xGxz
 dEaPpdlRP+sK83BT/3eRKsujEPVgKtUtF+gJU7gJ6yOkXDJT5fbtjXmPTFSzsZeSCAcw
 hAfI+gIhOO1rswyTKrxzANkcbxgBgZdO1/Ve0LQhjyr7nPKFxUBorLNYHTbNlnn6kMR8
 r2A9o3BBKlQaNDvLfYOlvwPfLojZ+XIXrPWX/PDUspsGwsKWJE+M4d88N/EI271Yez4n
 NLwgi9turmSnbdodrvgqQIxQXN7VETSefNeWegUnzZ8XThypvaxdCM1Jead1w1VGMGsi
 VisA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787919382; x=1788524182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YJeEPyBPzLxDNEZ0JnLBB6831Z29vJZEqt0XxGqWMq4=;
 b=JOD/tATyWddU3StNGT+CLODNFbYBgD5gVgODzlq1yROTQe68Wd5m9xfACpYtr4SOMD
 DvswlDzCAQ135LmOCdr97bAufnEkasERA2tgpKd7rKc9vTPhc6xQ0Cvus/FFDd3aTZkm
 9BAlbhccSnyzpzIsSeMh6Q2qQEMnjgQ8699YVVuGq6ronuSzlkOR5rwuyb4XUY4Cn8s+
 jGFvpJHk7cMgiuXhLlr2ZmNwyf/+FWsC6e7+z2gWh1xFXdJVeR+QSz4+o72TtcbLGr/a
 WxYTAZUxrU51X/HNfQw+ULv+BwvnJM6uptz6hjnLJXAyJ+v6BqMLYlks+v4R0heZNfuh
 JaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919382; x=1788524182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YJeEPyBPzLxDNEZ0JnLBB6831Z29vJZEqt0XxGqWMq4=;
 b=S2uojXdxOy2n5f+QcsZQUtwVpMlDO3Nz4G74iXKkkEsDaz8qKcuoD+3zNkW/+RyCLg
 zdb3pEo3q9+GuV+YErAPpSbbpXFsVov8KwZo8Bfgue1c3nXmKY2QtUNDR9PNccUwkb9J
 Nf6FuWQxjEbVlYiM+J4bUI09YgIHA71vEyUcGPCToJaUVGuV+unUpV/mmMjeeDBLRvRB
 sgDNyNuvnvxApxoDrq9JtFDLP6Qe47hk1lluA+Y7MzvLkhvA7AOj9ntY1QReRjZhQ6Iv
 e4Qo+qMK3nPbdr6QKwgrA0SqzDF7EuGUH5IeAsAvBC2lEVjgtPTY3s9jx+JsLqfd5vO5
 z4sQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RppEQROoqVwqMbrRBnCK67HPAoVfTjZv+zmjbYDp+d9bv3/qeazXBj493RwHoUjl5K7IrHZ+aibdUE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kG/gs5Shtu/NfnSGn5MpGJxgsSLB2dtZMt0OGyd4xDuxyz1VLS
 mcpr3ZmyAe1/1zPAw2+IHuoNUfz7cp1d/w1ITJNBCeKeoJt64TS1DY3Rw42jL6ou4DntJOpuRnK
 RAiC+MSFAKWkQxtsKmjS5eztg+armCwg=
X-Gm-Gg: AR+sD10l9Wwb37wz3QJM+5r5no71iX5aEMyKGbEFIvMkjKRw1JcQmLR8LovXgEAPXG6
 7W+4gYXCOJggQJwudIqIWnRSI89UPC8UnxIPWeBJaRb+gmk7QVxbfoXsKNPvC7j8hMXMEFcOteL
 dTRg6sBCc0nRf33KXc5Erc4ahm0fobf1eD8Oj8sWXCXQyOS0ik6n3QjFFADVenOi3mQVZTDFv0O
 uA0saFaELZFTVYCPwapT/OxmFN0S6Uxv4g4Nti2R0imGl8NyhvgHqHmtFlg0PcEZUP3ay0dUwjm
 S1eLsm4+XaQmTZ3iEXdgNg8kUeAA+9z/akNDNGME7lRdXBHAV1TmCsQ+e5Sn7rycAadHoixyur9
 iDliAzMEynjr1NajrK3j0lJRz1IMR6ApgUPP0SGu6X8hmlKtAZvg+wAnLjwmj
X-Received: by 2002:a17:902:e742:b0:2d7:d12:552f with SMTP id
 d9443c01a7336-2d74ce2e25dmr61601145ad.0.1787919381589; Fri, 28 Aug 2026
 05:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
 <DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org>
In-Reply-To: <DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Aug 2026 14:16:07 +0200
X-Gm-Features: AcwNN1XLnWNk0tl21KUKDNYvB86AzsWOBloGy7JyyvYK182UvGVrdB50k0AdYw4
Message-ID: <CANiq72kBF4xyKpB2oSvq+MgRuT2xk-VYSbtXW8HQaT0wmc3ehg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpu: nova-core: use kernel lossless integer
 conversion module
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, ojeda@kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, 
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

On Fri, Aug 28, 2026 at 2:09=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> But honestly, the former would just be unnecessary noise. If we don't do =
the
> latter, let's just keep the nova-core num module until the dust has been
> settled.

Yeah, keeping the nova `num` for a bit sounds fine.

Cheers,
Miguel
