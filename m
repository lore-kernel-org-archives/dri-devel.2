Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4525C531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC47A10E2BA;
	Mon, 27 Jul 2026 15:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rz6ycj/p";
	dkim-atps=neutral
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201C210E2BA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:43:57 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-9693bbb962eso1948172241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785167036; x=1785771836;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f6vPxfAH0pUagI/HidZ7JMfd8RuHEK2Qk8uZ0coxgHo=;
 b=Rz6ycj/p4G3BTH1StqjpnapOuUnT3z6m+NnCrHUqsj5ALlrOVMoUMPCtmIo/Ys7q6z
 ZuIdlJyufkcx6KaQ/QT8N6uJGHCcRqJi1LI5VO+fuwZCdF8FL5r5ldgC4zHrDySWtQ5B
 b+m04zK6ckI4mJv+5bPIPE27FHHtVPNG6lqp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167036; x=1785771836;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f6vPxfAH0pUagI/HidZ7JMfd8RuHEK2Qk8uZ0coxgHo=;
 b=qLWFjRsf/CgwhLTJsWDG4CX1+/Ob2S6yT6/qFPwzbxJ9oN1ofjolS3EZwqw9B70tqM
 VZIGjstIPp8VvIhUyj3hyZkVSkPSLrBbWySD/fI+iY9UrGmv3aJCc+D+NZVL2a0b4L6A
 RhTvt42EFFgP1Za4YHTtqF+OgHVKIJ1HeQpVjqq8QZzmhmIDe1et0G3Qyce5wmn6WfBw
 nkAfvxdrwI0H9aP9iVgLHXst1NmZy274K/kAXvxW3bG63Y68aByDmcAArpvegV0M6yMD
 TL38vfkumMmacxqNoNtsjC81UDwXT4+9atnK21dudOlNi7GJfBOsewzWjoNtE5Cp+juT
 tp4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHEdecAVdLZIylO47HlFlu70dliprTOMip1liW+dLCsSuPDctKxK42rV7d2XzDVQkP9CzfuBdN4C4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVcwQP+6F3TfbKZ6CFuqvmVwmotB7v0N2oLrX3WAujE+7tsYf0
 RE/WVX79RqBX1tVhvEi2EoqDs0zlhrYYsjB1uigBVKun2GcczQleMVmNraEdsLolKEoH4hEa4jO
 VpxU=
X-Gm-Gg: AR+sD11gNZVBvJWhoaUWVpg0snf0YKT5+YTeDeCPD6MdqY2S/1WjrQWcs6esaJ7Sr1e
 uLiecPefLPpZs7eil0jJ68u0saqYBCE48E7sMS1UTziRQ1JtHwQpW/ic32ekwpEYbdkgbQBPfUj
 WunrW8wkrwcCFu0G4aphJKyZYkfn0zW+pau2zTd+011TOFSiw+Ylvlo49C5UKWt0QB5uhWFNEGQ
 wKDyf7FQaqTdzQM0eN5juLBWNdALwL+VOMGWlhVXniJ/iJkakFyJO+kwo7i8/wcY0FUxz0O/Hax
 i3N+uieHBfm1gSyeyx6Qc46qrDd14HGk8wkDZ4ynTOdL5ASoDAxv9eUoeZIx+Fd1fkvoaQbP+Uq
 JjbgVW8ukOa63/zdftH7cCxh5phYI8F90GiOW/sdcHvWrMCWpC+/0qnLyRCgW+Ve3SlICpYbbF9
 jDJwUlW9M7GKEZvz76+axtCaFEpsbP7i19I9HH3famFoIKHMZcQrePv4KYrjXKQGZ26FZ0JMAZw
 gLJN2gVexGJ+O2hzgam/9ZkqSA=
X-Received: by 2002:a05:6102:26ca:b0:737:d2e8:d64b with SMTP id
 ada2fe7eead31-75040abec3bmr4910344137.20.1785167035638; 
 Mon, 27 Jul 2026 08:43:55 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774ce146csm5439450241.7.2026.07.27.08.43.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 08:43:52 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-74dceb46291so1008039137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:43:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5FIY5NphtuN+Ole+ZvjA0k1FBzgqm2kPxP0ra4BqI+i4+jf5JDNvUcTk/4DFxJ4Xu/emHAYOiofs=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5348:b0:737:8ff4:147f with SMTP id
 ada2fe7eead31-750400aa6e4mr5096864137.17.1785167031893; Mon, 27 Jul 2026
 08:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260727101623.2058775-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260727101623.2058775-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 27 Jul 2026 08:43:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_e=4RFNJGJxUb5xezCgjYsnmyP09qsAaj_rqPpqp64Q@mail.gmail.com>
X-Gm-Features: AUfX_mxvwT1rPeBCT5k33Up40LsJkMMSpMFk81edEJyWW1clS3IB3ytpzghmpvk
Message-ID: <CAD=FV=X_e=4RFNJGJxUb5xezCgjYsnmyP09qsAaj_rqPpqp64Q@mail.gmail.com>
Subject: Re: [PATCH v1] FROMGIT: drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)
To: "terry_hsiao@compal.corp-partner.google.com"
 <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

On Mon, Jul 27, 2026 at 3:16=E2=80=AFAM
terry_hsiao@compal.corp-partner.google.com
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDID:
> 00 ff ff ff ff ff ff 00 0d ae 6c 11 00 00 00 00
> 02 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
> 30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 47 ff 08 3c 7d 0d 0a 15 7d 00 00 00 00 05
>
> Signed-off-by: terry_hsiao@compal.corp-partner.google.com <terry_hsiao@co=
mpal.corp-partner.google.com>

This is not a proper Signed-off-by. Also: please remove FROMGIT from
your subject line.

-Doug
