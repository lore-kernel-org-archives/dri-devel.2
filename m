Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B70C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E22A10F5CB;
	Fri, 17 Jul 2026 17:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="faTpka9w";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220B910F5CB
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 17:13:38 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5bfb3347ce0so1848993e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784308417; x=1784913217;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tro9IEkWE0wA0iLOLH23/hNQbNrW7zpGA5T7R3foEiE=;
 b=faTpka9wqGM7QUV2AcvvmRBl3ndEKPxHrA0JE/Mp22U2p7iS+bfiwExl89ghj9QsUA
 vgJn6edvQcKDcnE+JBKy890PCqrfo7SJPB+RWwe74AshBH+dcDXkvTEBlzhKzm/QzfGW
 Ld8Fadu+EKKkFYIysLTe77GO6LwqIM+jLEONg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784308417; x=1784913217;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tro9IEkWE0wA0iLOLH23/hNQbNrW7zpGA5T7R3foEiE=;
 b=s03e8uCaz82scNtsFPACzAaekCe4aOUtjgDcaKCV8YtUKXZvidOgE5RmPInlLXMEpE
 SNhuA7/kwHk6Ev1cBoklWmolkdJPUBOLLKIF56xpL5Z5EOoY0fQjpHbURqGqVNEd3vXO
 dfPeM07xLovAk5HTTNe5NAk7nlxUVqyXElH6yIiYMWpbIoblxp1lA33a6QSgrBpHNcg1
 dTQ7xPkKguyb+mW3cGQ0QXyRoORC25Cd1J6y8mV+gwB7mvLXw7PGsXfCx/clAbRWOeLV
 NrQBHuoteErWtymOSghiEwZHfnijcY5b2OEcx2/QDHTkmxVb+wkXrFhsGoynnmGPWPwg
 3Axw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6B7UT0PwtrmB30XtiTEtlYHtTzoWxHueMRActiowGC821eH9MYZ9vwiwEGeWuZU3w2WC55W/B6sY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsiA++9IpLkZu73/4zmWLjI7buVv330rXjVQ/b1eHw83D7eaIu
 40GqA9LGf8otzbv/fIdtiTDKa8ibwumZmMajnZ57Q4lWoxuG/BU3TCD6MN2aVMNliqVmYKbdYVK
 49lw=
X-Gm-Gg: AfdE7cn/fZknCwO6abz2lAoSL1C6XKSwUTWncEIi3QO+j9mhG/U5d/N5hjXKBb0LWEn
 P5odW0PFhYdK4C2/mYan9nBzvpPiHMJkpc4csrMVH5qiJHqrKdCRG4K8KVlsv3WapnOOnVO/zKF
 KnMhyVITACxsa4tzXRf8tGfC26mBiJ1eZ8LdB/uXR3bxbfHN1Uw4GqL2HhCdDMIWTesoZ4VIqyS
 9n0n7ehbBEF5VaCsmLiDAOb+nVa1PCjm1bf6ou5laCZDb+U7J/jQskRB0UPCzxEYUnmfDz44uJb
 PdQU1jiQyHsPAoTotZwXbuytjero6rVLSI1erVatusKVZ2KrIwD31w3QJO+36akknsJYLGnwmmQ
 olRC6NYgsmonqZI/uJFz4THVV3O9OlMmkaNDOpJHmZV0xvUF8k/fBnzLKoCKMpxtGM4Qgyqty8h
 PK6KmL/1OWIimoRZMFRX8NV1G+MpkXjPoqk7VOkiKaiNpx
X-Received: by 2002:a05:6122:7c9:b0:5c1:706d:aec3 with SMTP id
 71dfb90a1353d-5c1bf8d7704mr612032e0c.11.1784308416923; 
 Fri, 17 Jul 2026 10:13:36 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com.
 [209.85.221.182]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1eefe46b9sm970271e0c.12.2026.07.17.10.13.35
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 10:13:35 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5bfaa014978so2666898e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoxJo7wplak2NfMwo+5tPkLHeFsaBLUOKvSgbBSwkZC8mpjTK+BHuDgQmyVBNaolovYHf7Qz0yYTmg=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f54:b0:728:53be:7c87 with SMTP id
 ada2fe7eead31-747534fef2emr706637137.7.1784308414717; Fri, 17 Jul 2026
 10:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260717025946.2751081-1-dioyc_zhang@compal.corp-partner.google.com>
In-Reply-To: <20260717025946.2751081-1-dioyc_zhang@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Jul 2026 10:13:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJ+xycNUZCuoipVOueu5R=WhCSjQLqWDxa9r4T-a9p4g@mail.gmail.com>
X-Gm-Features: AUfX_mxfaacOyxhSfaX6Z6BIBsDh0ia2n38BHY2wGWyxHBmixo_1sniFkfApgG8
Message-ID: <CAD=FV=VJ+xycNUZCuoipVOueu5R=WhCSjQLqWDxa9r4T-a9p4g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: panel-edp: Adjust T8 timing for AUO
 B116XAK01.6 and B140XTK02.4
To: dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch, 
 sam@ravnborg.org, dri-devel@lists.freedesktop.org, 
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

Hi,

On Thu, Jul 16, 2026 at 8:00=E2=80=AFPM dioyc_zhang
<dioyc_zhang@compal.corp-partner.google.com> wrote:
>
> Screen garbage or flickering can be observed during mode changes (such
> as VT switches) on systems using the AUO B116XAK01.6 and B140XTK02.4 pane=
ls.
> This occurs because the backlight is enabled before the video signal
> stabilizes. Waveform measurements show that the panel signal takes around
> 140ms to stabilize after a mode change, meaning the previous 50ms T8
> timing was insufficient.
>
> To resolve this issue, adjust the eDP panel delay entry from
> delay_200_500_e50 to delay_200_500_e200 (increasing T8 from 50ms to 200ms=
).
> This matches the updated panel specifications from AUO, which now formall=
y
> define T8 as 200ms to mask any display abnormalities during mode changes.

Great description / justification. Increasing delays always stinks,
but sometimes is unavoidable.


> Signed-off-by: dioyc_zhang <dioyc_zhang@compal.corp-partner.google.com>

Any chance you could improve the "Name" part of your Signed-off-by
(and patch authorship, too)? Is "dioyc_zhang" really a name that you
usually use to identify yourself? It seems like it was just git
automatically assigning something since you typed in an email address
but not a name...

-Doug
