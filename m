Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7E0F483DD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0728F10E164;
	Mon, 23 Mar 2026 17:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8dok5KG";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4573010E16A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:42:59 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-128eb45835cso179393c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774287778; cv=none;
 d=google.com; s=arc-20240605;
 b=gKu5f/XAEn0ARAbxx9ztO0aVsb1YtBbQLarLUFggAakxl0sJTXMZ9smfunP5fnR2fG
 +mbeLEBXRXOg/BxsfncTTx5+gK5SwM+Hd6rxH751kHCJSgxSzS+LMgbXXMYWfxQR1NxA
 9L928vdalEK1x4uCCoda0M9EmTID5Rv+AzAV0TCjfGijRtmQrLcuCP1lT1jr95w6z8F9
 8Aqxi70wwLzdyLF/4OeD55hs/MlUDg5pfuFx6hBA8ODhbhrQCImstjCeAA1sp7xvdLwr
 oaMiOrOc5qBZh0FpuP8e5Qi5zM3ALsk71w32ZD3ybfZhnqPVVF1Ye3Fnk1mbEF0Kw9E0
 z0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CunB0afxvU/gEx3rEbTE4vI3pmEepGsuyogimCbubLY=;
 fh=S297jrh2iO+6T1Q4Z3b+Buk1x1Vu9lb3aFPv/pMVb88=;
 b=f5tUNefDdhni5b+w5+RkDeyfeVG2zHDmcqi+GeZe1sQpjvHcdWKNLLpquEiqI6k6bo
 E9qwBGL1o5Xc0icKLSvgBWIBljoIpo6R3ZYob4tFSgxKbj/ICwCOXWHYI9RElNEQSHWa
 1WP7zxBcqEdJRstDno45lqLXaS4BxBT1CrUF3PE6yoJvD9WoKRfNJCJJ6saUUYQL6j14
 O/LKgb27MofTL1gpfgLCeDx0taogyx8ZaiBokm3l+B53YY4DlvEd/NAVIzoz3pKQr+B5
 qaj86tE87sdoouS07vFzxssKbPC4ZUG8iVRHHU4LjTLQkHYqz33r8tSxiyYUxZw/u5h0
 QFyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774287778; x=1774892578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CunB0afxvU/gEx3rEbTE4vI3pmEepGsuyogimCbubLY=;
 b=B8dok5KGhi3VJDHLXB09uQF250/MX6qSRC6DE4RRlXxese01grmMsPJ33bLhaHEsYi
 NnIQhHPh/Sw0rFFwyZBvn4FB5C4kJhTG/epKLTgMpjjel/Cd05/pZcXHEpW1SSdOmA1s
 4ElfEBHHptBJStKKvWkbQWIHU1m3YE5fvtBjUfetW74FDbFayndHuNzGKSREj3fR6gnk
 OpUaeo1Dlhi8SQAxuqfEvnufyudPhPADDHkKimpsbUGTkvLoODSmclMdFgNWNBWRRGPt
 CYJ29l3XCcICAFMs36X2A7U+pYlMh+6v6trTGHKfLRmJvSm9XSa79wM5DBvNX00on/LW
 XGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774287778; x=1774892578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CunB0afxvU/gEx3rEbTE4vI3pmEepGsuyogimCbubLY=;
 b=i8Hbwqh5XJO0v7/p3rtZBynnl1MR6qSaY14SQoH6WMHLpBrq/QTQeiWOMAbieafrc8
 YIfcbFcSWJBjn+VzJCSDEs1eKCKItYyGKkuwB+Q8nmi9f7kkIXMH9nYRU6bDNFF46Nn4
 xfzcQbuKrvAJUJrnpWOHE/2s2t4NMRC2JA9A4ZME+SP34arq6mUJl1OhWeGafIPWD+MB
 I5pMjR2MYL41TV+OSwkD5LvnfMl/SRcQCuPoGD9UHPPKVYSHG9EbqjVhE9fdZUfj5TeD
 kIVV6OSM8ImSg5AwDFG8kwotLS5Lvk6TIonaLn4Cr4TCBhzoe/DX4ynYDH2JSosrUt37
 0ujw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURPpMhrWjo2iuIICzEvFOty8o3Ja1NxZytKNnLvTM1a93cT1pOvoITFkPnGPWt1/Kk0bDnE0JJprw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/saAxIFeCXLR4NvbYBxh0DNav36hPJntptuvkwQWOhVZ+5mwf
 6+EnLwzcHFgVxxAUvHsa4KetbRGd7Hdxd7yGTK3ND6bGD+/X+MXu8kGN+b/+aio83KLLWiqWAOe
 hsVPIERRgfis8FOFpwHYtQAyNYqvZlC4=
X-Gm-Gg: ATEYQzxk5e0dfz489y7VFe7j/FmNjN0rYGg1YEZzOVlVEcr9HXh8/g9+Tb787Izfp7d
 1k2Ayk80JNSfMjRv7UE/JT4o9vaRYHuyd1pkxIJO+bKEjlEm1F22j+ERwOxBqfiVezP5Wyu5sUt
 zswVuUeuYhPRlxcu+rnib+fDyccan1tLSxxVkEe495fXhG0gOA1L+n1OTaNB4U5HzfP9WhECx49
 XpoP+qmcygDa5MLufGQ/pwRTfQGMMj0dkSZSMwygK9EJUQCjKWbPP24k1AWN5Kgi7ncI565afvW
 hfk0LbQXgLQBW6PkPwpgZEiQjGCODHHvqTsldcPARegvlRIAWMjgPxS2VyIPiONsaqugbNc0YTE
 opUZiIoIwkDzwWn/izUjzsyQ=
X-Received: by 2002:a05:7300:d709:b0:2b7:ff3a:af82 with SMTP id
 5a478bee46e88-2c109563bbdmr2193158eec.1.1774287778207; Mon, 23 Mar 2026
 10:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
 <abkQTEcRujrFLsdn@lstrano-desk.jf.intel.com>
 <CANiq72=gHArzFS=SkiZyPpEfSL+0AcU3ifKRnwfEyet42662PA@mail.gmail.com>
 <acF41mM66Gh7m4vS@lstrano-desk.jf.intel.com>
In-Reply-To: <acF41mM66Gh7m4vS@lstrano-desk.jf.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 18:42:44 +0100
X-Gm-Features: AQROBzDKSGfCowA5deNWr-GZ-_NHP2AiqkVwZir4qy3OHPmJLmEcG1YCXbf5NSg
Message-ID: <CANiq72n6aAARCm0_k1gQqKDxOL-MSbP1=M-inbdMSJN8tPn20Q@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Stone <daniels@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, shashanks@nvidia.com, jajones@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>
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

On Mon, Mar 23, 2026 at 6:31=E2=80=AFPM Matthew Brost <matthew.brost@intel.=
com> wrote:
>
> I appologize here I shouldn't type when I get annoyed. This the 2nd
> comment that pointing out difference between C and Rust which really
> wasn't direction I have hoping this thread would take.

No worries, it happens to everyone from time to time.

Thanks!

Cheers,
Miguel
