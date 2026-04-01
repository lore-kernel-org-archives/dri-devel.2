Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA5AD35159
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C9F10E39D;
	Wed,  1 Apr 2026 07:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLVRBM+l";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E898310EC61
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:54:07 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d7653db148so3556012a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775030047; cv=none;
 d=google.com; s=arc-20240605;
 b=EMTyAUBRF95DuVdn95VS1mRRC7jqkuYD3SfU+JImPxZKKr6y910EQVgSrU4Dffedl7
 hEMCo7tMaRvEhcrHit0N5eUIu75HJLK3nYiCHg4n2Fnne9k62IZrGIJiU3DghSiZp9SC
 UbM7vKx82HoQM7hCOsyOpU/BoTznLTcOIteZcmW8FxUdRM09/uvq0AlL2mcQ5ZbfkMzw
 WByEWX50GCWKIiFfV6kCsCQgArMsZiOauI/eocIeW4HaFrjc5t8hBphcYUc8BfQs1ARa
 NOdrWi95cukgBD8QG6rdFBiL0j6IfCnFmk5zB4dHuwkRfKy/103Dun6P5JfunpqLoo+V
 IfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Onegw/uhjhmbOLrBOIvAd+f/C9ZHUdcCB0fhOs3Zv+c=;
 fh=FT0md9ss5E50+T4QAGoBFMe1RmKqSIMftlC6V8SFgXc=;
 b=dUtkxxDsK0VYh+hACvKBnFOrQARtSCnxp+7eYO2is/eZQ+NQ281hNqHNsRRZmH1ux+
 /uxRYxk4lvLC6tkyL5mlgV6dAgZ/llyOQNe+SAPx8fmqjzTs6tS2ToRWP3/UWNj/l0bO
 Fm5AiPjXiuIQ52y+X1ncjEkrPY3SRC5EEujR8qaXBoizIoQGI6I3IYhrbPciynKuq4iD
 9YMkQyhLTRnXkISEMgvl9N2VDRJMcUy2yDZJ0HSYMDnGnp3T2Jheff7Fnup0oQdM8nHI
 GSttXMsewS8GsEgsrbtNtgsUiUuvq3AC7LWQNN8iN6UO1ZZTBDkkAtriPbzwLnxBzaFX
 jYdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775030047; x=1775634847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onegw/uhjhmbOLrBOIvAd+f/C9ZHUdcCB0fhOs3Zv+c=;
 b=PLVRBM+lBe78/Gu2kemUgpiDlxzBvrKw15wd//UhJhS/1hIQGVenAv3vhEN2xSuUAR
 nFJftVhHAVU00gD/n+D68GdQvhIxKC+ZNMcuEGGTYKr7gzVpG8CF2v8z1LoCah5Ttsts
 F9/sYgxYVpexk+OBUSIu8jcaPEY9d4wTy3AzKa4Y485JhdhFwCgJ7j4GPTSei1gT0orG
 GEMlgZC1ILN4fdXFXMbrMq1rcRhMfK7866gvLUnFGdVH/CjL9mvn+OFuJktnNh9kvSpr
 Ti/zgXknblEu6X8a4QvHTa5QDk6iNPS+UbXVPLPDeiW+SAHdz6wY1ii0PVKOWzKoDGcU
 rqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775030047; x=1775634847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Onegw/uhjhmbOLrBOIvAd+f/C9ZHUdcCB0fhOs3Zv+c=;
 b=NFr059v2mdAaZGzyOjrwbxE0ggSnpCK73XILi74SQT1gXIxidFcwlJ30OTp18NJp+N
 hRmVpaaMNWx2UXz39L/Ov9BE9pVYRcgeQ/FGoSqwy1wijyJd/ALxwO+PZsTfL6X58IOL
 L3WLmZm8dEO9S8jiZdX/FIBfl/nIMAwWqWt7vV9/pCN8ACMHPWzknsqS49MS2OmFkjeb
 8E3KKjwCUbfSk7GgVVYauaaWTW+ZTUT2SVppGN91cM2J6b3vAfOROWVaCeJ1BdaJUAuL
 e7kcuLZuS34Mt9mSK/q7w+txtC9CXeF59ly68OLjCgCLbvfYqGNg/FgWwO3wrTj7hu3s
 JEkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrd6piELVBkRtxgfSK8nYYZcF1UhQwLTN9S4vYcxHEDLRpbxteQIZlFp5msFHOX5WrieqsSxbMroo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC1siTL8GIzSRUwIw5IYz4vKK+Wq3Y8N43KwC7ykrCb0cJGGPc
 JIRk5Bf/EpvXcOraWetj+ISeAGwLnvC4EW83JqCoF/OUvnhFP/16NIg/goxxWguMKfFxBE0qzei
 oNpUU/OsUPpN1WGf4PYVqt61YT5K7KlQ=
X-Gm-Gg: ATEYQzyAnM6O/7d0bUETKA+jAJeGk8eITNuQ4ID94MLBdADVVKEPAwxjyoH5UgB91Ew
 SZ5BJX6itlz97RaT6XKFozz7ydcUu0fILl2Ig3nuMW2o4Q0pXe64A2D5C+456r+YzMmNRQNNBBn
 klFw2dv77RMvP8sN40ldpVsSPx4vp/WvOQeR9QHQfRzC4SCpeoLzUPL2cyUd07T/4QZZh92Wkvz
 csAzTaFbedURG1OsWoqsoYhbRrsjLLaRM5WkCrmXLe7e0LIYCyL7DzMwTmvGc7ohMJqi3Bl2N2R
 vc1QFirFJYOGjFtHebUr
X-Received: by 2002:a05:6830:67ed:b0:7d7:d66c:a445 with SMTP id
 46e09a7af769-7db99415a63mr1700486a34.31.1775030046975; Wed, 01 Apr 2026
 00:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
 <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
 <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
In-Reply-To: <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 1 Apr 2026 12:53:55 +0500
X-Gm-Features: AQROBzBUL17ggoQ_c8L1rGFMdlEb7hWGH8F-hvG65ADndRBXDtdXw3A8WWNL9XY
Message-ID: <CABXGCsMtdqaLEOo3v5h2b3Kmn-1SUTHSU9NW3dJfzKig8=hKfQ@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Wed, Apr 1, 2026 at 12:24=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Alex already applied the v7 so it would probably be best if you provide a=
 delta patch on top of that.
>

Hi Christian,

Done, delta patch sent:
https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmai=
l.com/

--=20
Thanks,
Mikhail
