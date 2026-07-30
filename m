Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47341C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A44810EDAE;
	Thu, 30 Jul 2026 04:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEqSqEY6";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4213610EDAE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:51:34 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-81062fdeaf5so6517667b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785387093; cv=none;
 d=google.com; s=arc-20260327;
 b=gY5cBOn+UOHF0kdVEJ2dmqQS45xUzcr389CZzlSRbtXdGcXIw41hPTFQnUNE2YrrqQ
 eXzvuwH+weU5ZL0nAuiW+k+3wWftLMAF8/p9DDn8eBCBnWZ9M+yyCRrymGUPYpndq4G1
 pBHuLqj6afw5jVd8NnHZ7zo4pXyBKq1uiJKm+DR8Lqk9EJa581pX7xcBJh/Uz7/hKgET
 +jeDkj5TM1AYNuwJS7zn8AZcHy0w9UV1+/0N73fbnfG6/ck9fbPg/JJdFTqXXQKmkHiJ
 Xckxkwu+wvebpAABsiE/Qx74aCWn2kEyEgOm8zIwgmUt/B6f3yhpSx1SSPAOubNd+lG8
 fCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ayTdrhGTmTRlS5yubk7pA+8kF1TugqiIc+iTJFgG25U=;
 fh=xhnT5KcyERGQAD9pGBZESWXUmk0zyAo487eqffyyqdA=;
 b=kltSFtH1wpNzxFnHbcYUOGmqw3NaezsiGaPKixUIXkTvoQzeLko+9qVssOqAmj+x8+
 74SRhbwfzhH+GVY1NdOUowsYPRIXWIk9j7gaFO9BSiry3mPwSOz4ROaMUQleFoKg37cM
 Q0SN/f6D8rh2nnafTi8P79fewAr4xzUz/aPsd+hgWmdKdPVCly6K1FIfzHsEnCBkjWJ0
 /2VUrumeTQ+p86DknlNbLLmmWW3zS/6KUmaWz/fgADoZwUgFqiG37fFYYofvn0pCEtqc
 +756oF2CO5v4cUYpQwPMiq6JP+WL+UiStaURMtvvCLpYsXeFkFN9yAKEW/NKldNEQyDB
 K1sQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785387093; x=1785991893;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ayTdrhGTmTRlS5yubk7pA+8kF1TugqiIc+iTJFgG25U=;
 b=XEqSqEY6ivK6jdDjfy1dS5B3OF9U22R4dBFp0xY+vGjUqg8cLUX2h1eF1+UN8IAkvA
 Nae/IqXksYEx6ByvoHg006Z+bOIBwdmlssquHTyRLjMTEXAAue77JoFkdxt9YTbp+Mtz
 Kp3Xs4aGEIGRj+Mpg2dVlH2X1ra6IDyN8tJv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785387093; x=1785991893;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ayTdrhGTmTRlS5yubk7pA+8kF1TugqiIc+iTJFgG25U=;
 b=cqnBBJ+p0i7TfJrJQasnyzvpKgJK7NAmTntKEOFZkmpAv0Y6e1DZ4+6oXHm8drJ9UA
 FIPOSokncjA5LSJwAbxlvibcZuyrdJqyMydU+xgDwzKsdz51J2LCnxLSOggvCwOh4QkN
 pBIgP2W28M4FSn+4Gjlb52PxcPixB6FZlAtzmD1ULCi3Y11e4e051G2VnOgzGW/H4hvq
 ZlkCQBP08KgQ3TaODungQelDpavWu8p6KjTtxaBwMyxlebVzvXWK7YrI4MDhFKx+mQdf
 5tVg6FYrRN9LkbsCXdJFg7a5UAh0IidyHzdwb9fvbYMcu9IzXY9+UrQ9hYs3GlYiR0ZW
 KBEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrewodkjonHjRFvpSRndnm7BdNZEq6kmtKhIO9BKD2TezEtG+nMLmHV0V4QkT18WpZ62duLE20gfgE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA3M1JKguvsJ59MegLO5oxgpEwjyYjXF9BXT7svAW4x6oyDlvF
 s+ZPndQZjQEnit2ZNk9Ag6hPmZKmbF31TW5xA0I4XRUsWvQ1mFkyxQetrQdGn4+RefPMoaKmsNK
 yfj3kricyU7gJxkkSqGC8Hq8Uw9dlEiTkzV8XsWj1
X-Gm-Gg: AR+sD13nOaHvSd2hS9u1BUIhp8O2/1XFhI1/4sJwmas4oj5JsmVj6/LhfO9Tgdj6U4s
 Uw7gb5+BO8BkRyvt5J5PAruYTsP3Wzawt28fJFGpeQUFOZxnjKw9uHlqJ/Wn7WG9VTWtlhChJa7
 +OxkAudnufOiJi7LHLEwnGcIUF+jx62d+ftG4lyvUogYnUVUrtYsEngvuXQTZ+nw0xfZCv+byEE
 EF3QKTcxIqwXc+jXjlgv377NdQia+KFvB2jc4vs8nJQxTqFxlyDL1St90LD28j6I8euzgZwbjVl
 ecrd2kHs/xwbyGui574UCHkEid32QQvwxo5/DnCvwNCAf8aqs0PB18j7A7iN369fP+MDy02gOZ9
 X8nurRoK8YA==
X-Received: by 2002:a05:690c:288:b0:81e:ba92:b253 with SMTP id
 00721157ae682-81fb964be1amr5292937b3.4.1785387092765; Wed, 29 Jul 2026
 21:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
In-Reply-To: <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 30 Jul 2026 12:51:21 +0800
X-Gm-Features: AUfX_mxnxexVKpsRakYQvwrmIlkydC8kB3j1QZQvD5J6WTjr-o8egQw_wYmWxF8
Message-ID: <CAGXv+5EgGYFVt4TJCysQgRqA1J5=Qz9c0oWY5YTxgc5PnNC_AQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Brian Masney <bmasney@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 YoungJoon Lee <getfeus@gmail.com>
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

On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@redhat.co=
m> wrote:
> >>
> >> Hi Chen-Yu,
> >>
> >> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> >>> Hi everyone,
> >>>
> >>> This is v4 of my MT8173 PowerVR GPU support series.
> >>>
> >>> This time around Mesa was ready for basic testing, using both vulkanm=
ark
> >>> and glmark2-es2-drm (with Zink). Details below.
> >>>
> >>> Changes since v3 (all in the clk driver patch):
> >>> - Changed pm_runtime_put() to pm_runtime_put_sync()
> >>> - Added missing of_node_put() in remove function
> >>>
> >>> Changes since v2 (all in the clk driver patch):
> >>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> >>>    - Needed since the driver implements PM domains using the generic =
PM
> >>>      domain library, which also depends on PM
> >>>    - Fixes build breakage (kernel test robot)
> >>> - Fixed "RST_DELAY_CNT" name (Brian)
> >>> - Dropped unused mfg_desc (Brian)
> >>> - Added check of clk_prepare_enable()'s return value in
> >>>    clk_mt8173_mfgtop_power_on() (Brian)
> >>> - Saved error value for return in IS_ERR(data->clk_26m) branch
> >>>    (Dan Carpenter / kernel test robot w/ smatch)
> >>>
> >>> Changes since v1:
> >>> - Adapted to changed DT bindings
> >>> - Dropped driver change
> >>> - Use same power domain for "a" and "b" GPU power domains
> >>>
> >>>
> >>> This series enables the PowerVR GPU found in the MT8173 SoC, found in
> >>> some Chromebooks.
> >>
> >> I'm making a pull for Stephen for the clk changes. Should patches 1,2,=
4
> >> go through the clk tree? Patches 3,5 go through the DRM tree?
> >
> > Only patches 1 and 2 should go through the clock tree.
> >
> > Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pick u=
p
> > DT binding patches. Otherwise I can push patch 3 through drm-misc.
> >
>
> Not sure if I can really take the DRM bindings patch through soc.
>
> I will take the devicetree ones exactly right now, even though it's going=
 to
> give warnings.

Apologies for missing this, but the first DT patch depends on the clk DT
bindings patch for the clk ID macros. This is causing build errors in
linux-next right now.

Not sure how we can fix this right now.

Brian, would it be possible for you to split out that patch into a
separate immutable branch for Angelo to merge?

Otherwise Angelo might need to drop the DT patches until the next cycle.


Thanks
ChenYu
