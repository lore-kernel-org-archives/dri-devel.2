Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C17AF54AAE
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFF610E5D5;
	Tue, 24 Mar 2026 13:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XbgeiCYm";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10EE10E5D4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:11:32 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-5ffabb1dfbaso772471137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357892; cv=none;
 d=google.com; s=arc-20240605;
 b=daZwtIJqsSzLrfI1vhbJJFlGzyM7kwEmhg3Ktz80mpF9rBdP5IUEzjwqheTkdKaD6Y
 iCcLlQJAAOoMpdKbEiPgaP0AXgugRxgb6dZADlIPa49QFs5vH09KBy4QWlPcYWfh3E23
 +diyfF9q/cRi96jfZ+F0YlUlnCgI/WM3ExCsIFIxJaGt0r1qVjeFPMSOFpy/4JX7FKUm
 BI1SM7r/1NeNpmmsVWZU/mwt38+85C9jHwzYIUp6FG65iyb2GVHeR66jrbzMuM/5mneE
 6GUn502gk4Fj9T+i5iI4wg1oNT3KS2tYcFSun6utZ4eD6g95cKoE6CxlU61xJzAjMJ3G
 hnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7hnWVjysxJQ+llkIpwUpAvaG3bbkSHFMxdZKyrsvBG4=;
 fh=R4zg0Tk7HjQwNS+ISiMVZth6mH+qOm7maRQ9u7MH5C8=;
 b=Izm5ogbnsuQ4gKeqzS5xgtrSTxIGIm07TSnmg9LxWu6kUmdP2lhKCNzn5YJoSWoqaO
 adGqrArGtfT58yDQe122QDeNwDPy9+wDmrLiqZXF6Px2E5uQSdPHoNx/axxyeOI2jEjg
 j+ngpEMQ3CvXngRNoMW3X9m+Io2sGxgeFEjzM5uiz6yLyzek4gvzaa8GL46o7guC2T3u
 eMooIXTJWBqbzU5b2iy6yAVK8IQj0emiZtmOkyfmVT0hme84rafadFlrLllFzWoMPSBT
 PICzfpzaUYzqJl3hYQ+UKo509DJgDQyhRsEZsBLco2jJHnQbIiLl1WfwffOfNS1bD0qU
 N4BQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774357892; x=1774962692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hnWVjysxJQ+llkIpwUpAvaG3bbkSHFMxdZKyrsvBG4=;
 b=XbgeiCYmupGgo9VyhGm8lsWTDdqseO5jDslB/DD/Bg1y0hRS3dkGQJQEmdRkDP1hAM
 pNpRTw8/MwwP87a3QlG6Gm8uaiWIc0if1skVdc37AffiHncNbFmC+JVvhTaQ/AQOjxVW
 wC0/h4Mke5sfqIqehIiw200BqeOlZNgYitzWCtFbLkUwATgwg6beapRfWL4c4zaiRUbj
 bvU18NEQiafpCWXC34TAe8hP019oUKSh1HIgDKKDIDu5OjcPDp4wAnYLLRVhnsmdI1Nd
 VMpe3x49wqIZkYZmipXa6FTAilrvuzcipWT/p8B6hTuwvcGQkVV4eARnJ1nVMPBKO5DZ
 ruBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357892; x=1774962692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hnWVjysxJQ+llkIpwUpAvaG3bbkSHFMxdZKyrsvBG4=;
 b=NncsncFcLR/4bGtIXP+F+PRvfrcQ1ZRB6bI/AWzgtB/jz8AjG6RZuSjEoq5Y0eI3tr
 1eU2na8FHsaoXaQ6I3QJVGUsyRH6Z2mMn3Wx5UlTFO0hNi4IMbxe+KSAMR4PV42sPJhI
 tzZhX0oTWrQVZLqQnL4VYvjn3sg6Xa506Nhi54uh2QLAp5A0RHfrQsUuIpEpAALeufTT
 fIrSxWXQvkLfHso9WfQYq5lo9llsstQD7BRuV54aONMXYV0nP8cbXqUalTDC1zUPhjLi
 uEeWzWjC1FF2UXu/M0MfNrtKMS9mMF2Sc0tmVvlCu6il1Os0drSLzXTiEBLrSV2stdPD
 c2dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyOcQEA/GaHS9ITaBz8Jmvt6HNKh0GlfFbpl0PLyUXWIdfrvgZDS9LzL/hNaP8i6F6tmOXeIIsK/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwF32V0f7m+7eFWttwORQKK7NUMDZf8zJEaCsNpdw3wMT/8/0mD
 6mDqv1RFK1tjSQBrKxE23ua3Ayl7eX4XEsJvmlWube0IMa4/qUpd6838zy2cIESmB8J38fTXyXL
 Ltg+B/AtCkmaAbIyBaTO1FWNL9w7n1zg=
X-Gm-Gg: ATEYQzz5yumULJOTHsT98QO2kcsThTBYfZ1y7qpL+yj1VR7Pzc58XUE93cixKoLe5oh
 lYfClFpQbQq1a9QS+5NI9GdfmY6NmPacP14AgOp5nYduG6b4rLW3DeLmS4mmDzxjDdRHUs1TKxF
 UM/+AXc2Rr9TK1vCcOPzmOtkJYPSg4vRRq8KE544UFRbk+GAG96xuZBMM0QmcpUBKI1buL3Yq6r
 f3THrf4l+hjHxi7qqMbPDVqlwpemEpghdDadEP4LvAEZjjYwYXQjEvQWCoiihOgPKOnu3+p7yzi
 vathd3Y=
X-Received: by 2002:a05:6102:3910:b0:602:8cee:8246 with SMTP id
 ada2fe7eead31-602aeb3db5fmr8903441137.16.1774357891859; Tue, 24 Mar 2026
 06:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260322-fix-data-width-calc-v2-1-d5f28136bc4e@pm.me>
In-Reply-To: <20260322-fix-data-width-calc-v2-1-d5f28136bc4e@pm.me>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Tue, 24 Mar 2026 21:11:03 +0800
X-Gm-Features: AQROBzA-Uf5D5nbMpZdLi_R6pDLsyJrw69YbWtlJy_Jgt4MFR_t_cYHPAAA05S0
Message-ID: <CAH2e8h5mZSYEbQ4Y_EEQnxOKPkyuOF1W-4FQQ4XFqdkib427JA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: calculate data_width like downstream
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
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

On Mon, Mar 23, 2026 at 2:48=E2=80=AFAM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
> Derive INTF data_width from dce_bytes_per_line rather than
> timing->width when DSC is enabled. Use DIV_ROUND_UP to avoid
> rounding errors.
>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Tested-by: Pengyu Luo <mitltlatltl@gmail.com> # Lenovo Legion Y700 Gen4 (SM=
8750)

Best wishes,
Pengyu
