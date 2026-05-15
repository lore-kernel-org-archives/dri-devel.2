Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F54CD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131110E6D7;
	Mon, 18 May 2026 07:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6a6nbMx";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD08F10F48F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:41:54 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-65c477a3278so11089187d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834513; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbwStF2RrMnu9IfNaZ2J5OEoNVWui8OoA94LIkoFFWsyOlGHvmfEA1QLcJmobtGcC9
 +7K6dk20FNZUmmWE3cCUGUAuysWDgste2qIhMwrLZsAtQw/qSE5lyYyIrWtzbczEwn8q
 XuTBOoUCfSogDGB5x8uo1UDyt/PLt5HuTl2Kno6Y33jPR3xGHjO/o2hA6r8aqHdSlcTa
 SBbohC0e2bfPD427Fu8PQto7/q9ks8htyDvoqFGVp2xTE3yuSRodogyCDcJ32qOgAVca
 Dsct6dZdKd8yG/8Uee8XjUYuSOi0kcz+kI+cAFb4gXtiFncUdBr1QU0/ebGax7hLVWPx
 9Rqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
 fh=8ZdOuvYdlFR9drBoqqPAp4V0MTj7lx1ClX5TiBAOmf0=;
 b=A561nDU5/LVsMxlAXsHqqTCPZWeBFq6r0PQWurOjC4A2cxEotB1v5ufW6OYH7bka4R
 If6WFSibRI2XI7mcdZsh1woNcXasqxE9y2thj7Xi/OvakRwfXMQ59lN6jGHskiH18bhE
 e5XCHbfMD4legAO9PysAU3o0QDfjVvHgcIhMX0p7+2utcEbKbTKv+j+VKzzzE5NF2YkT
 MGBFPzXCVQcRhLnKX0ulJaq0uIbD6tDMtW3Q64cQ4BUhJ8y4fe0gpI3IX4SLSFvJnpWI
 cIpP7a5X3xSFZE0IYClWPDaS10LPzLXAX/iXHyRThDRzSNy65cLvrw+y95U5J867mzVP
 FD1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778834513; x=1779439313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
 b=N6a6nbMxtdaZN4RJIxsOtZhZhreCNf7uZreriyU87DmOjE7TujMnqBZHg2239lio6E
 whoAyGxlb/6BjeV9depsVU4aWjxe/HuU3BCXad434NVUzVfhJKnbXahDmqoyWPRoSk/T
 q7+XPDhMJLQqlJDea3zeQfSiyMusCcbSgd3Wq1IFzLvfwNko6nJ2ZMJxYqXAFVxMSL3H
 WCHGR9i76xP9EiCSytfld0DQLcjoS2x6ciCsQDBS2d4NuTd3bf01ksRtRR4WR8jmQ0vS
 77CAesQemN0zBG0ALmpabHKdIstwhxFm3+7JM2I7G9oq6pHLiVQh8LSVxKDLMCp18Nd8
 L0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778834513; x=1779439313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
 b=aR/OW2UU560maF0lAQySFCShobD/KVfNKQYcrPh+0GL4xhoAq4ZADnlQw1MjWpPDaS
 xaCPaADnMRYwvBI6CXOxsU9g5GfTJ54GVKUQMe6up8cwSJvEALucqSz+uNvLnraSsPPh
 s9cdPjqWu3QLE2EIY2yFLbbxLZPWosaIARCn8w58c5rhWPx0ydirkBgqo4SMRGz+KVNH
 0isNmCGO/YhLCbTFtOJrApCZO9Q/1nad7crgzzSt1jtipPetDZKjOL6kgUURJRBFODUQ
 cVL1++zghLFFyrxBF7UVvnUl928pGMQzfFlyuZZ0ocYjlZhNHUrXMCz3H5mE1dKIpTyH
 2L5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9L06IQiL89Us44fdurLDeYUEF9vC2ZFN/V4kZRqyrKKYSg1v6h1/TN/KlZeXZKwfMie84QQSYTOOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxb3nV7FP2w59m3fgo4KKES6AufAi65bKSHFA48jFWoMgiBnDqW
 bU6/3jB1QKraiDvZ+5Eexz4e4hEpcizs4bH6ywGBCk59iGxqTXfr6oQ0mBBKyKZaOcPaAl0fQGS
 2qAwUfP7XSYrALUncN5hqxvkOw+MBUu4=
X-Gm-Gg: Acq92OG+D3AS9M1464wI88LOjNzbm9y4tBC0LhbJk6Hpuhib2Tr/cePArKYcMWcVemq
 JJIjlampo2phcY+ymUma+7ROkqMGM0UQHo+NTfpOw7jVFL6tHMjW4ofLgcfGfsAxwT1iCd4QyAU
 pDuMmlUr1j66/bJkCckRJhEWMGLs448GnUMi9N0VVOrUomwktHeJ/wkOn57vQsVHvWTUVcjtvXS
 SP62nrc49BuwugNS1FgLVWbTq8wYkmjGqGYU9rNmAo9I6z836hMEw5lqdgvnUY/LeB1PzdjNtDa
 u3ptwmQKtzV+Y1fMXncPcr08Zh53oS2XwRfP0dniwbco6sZUXsqJIJhmHOGt8MyqXUviM60O
X-Received: by 2002:a05:690c:4:b0:79f:d961:47bf with SMTP id
 00721157ae682-7c9594b0105mr32678827b3.8.1778834513472; Fri, 15 May 2026
 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260512020718.108044-1-kartikey406@gmail.com>
 <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
 <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
 <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
In-Reply-To: <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 15 May 2026 14:11:42 +0530
X-Gm-Features: AVHnY4IGHTZnfpb9msWE08vJttVqhQ6G8dsaF1hRX2r-HcKGXn0VdlxicBL5ZuQ
Message-ID: <CADhLXY6L1RJvgfMGuogmw7bx5Sj-_6G2C7zR5q+xLQXu_M-Tjw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to
 prepare_fb
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

On Wed, May 13, 2026 at 2:40=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> > Does that match what you had in mind?
>
> Sounds good. The virtio_gpu_resource_flush() also should be updated to
> use uninterruptible() variant.
>
> --
> Best regards,
> Dmitry

I  have sent patch v3.

Thanks

Deepanshu
