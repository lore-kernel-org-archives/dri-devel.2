Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE0BC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631DB10E758;
	Mon,  3 Aug 2026 18:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+boavB4";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE8E10E764
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:22:10 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c1f7666a90bso568589566b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 11:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781329; cv=none;
 d=google.com; s=arc-20260327;
 b=BEEHJxkI09ItHLcdGNbMWPv4uV9NaGuiD364yTZDmWdEkHQ0aWuxUch9HPlJrZ/0+8
 gJDI65DRRUFKkacQfLILcIZIpnJ4Xn0u5vXeHY9PifPx2+bExT2PgRmVocvjHj8TdLEY
 4Qu9zJmBH9Nozcn+cOGQ5ALG5Hvwi2pdLiougDUnH0iEsZXkyqHcnnjkzdVmoqq+GndP
 iyMyroLVoWssZRYX/OpNcILIs7KcWcnJwyW9zcmFeznC0F/w9GjgjFSFWVoleB8AkSV5
 6TgBF7xmERpaNRtOLVYZ38xtb4r+rtbDjXsHOCRHg1qKgGkwwjKEw2bVHZz0muPmm8nn
 X7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x9ZImVd/rO7BV0YppEaOdAU/wiWFe96AuvDqT6HskHA=;
 fh=EsT3r/xynwoBZ3R+re7jBLs+uKdmpVam1GF54SGgyMQ=;
 b=POTgRl6yqN1F0e8/dIkFu4jN2D7guWA9yBnnws1rMRIRlXm6xpAhXQjEsyzEWmwJUu
 9m4GaG4eT5rK9+fvWH+4JnWAelnbCF5yLq8alvJVVf0GgVKITLEEm7uIA0tqiueVmk6P
 hjo6c1f5niqHFZebE79kKqdpd5IOF3YvTN8iO0m8wmKG/hnIsE/61O/MMN1KpqdJO/jV
 iFstd4incl+xg3kPtFSD6hBsvFz3Tt67KEO9KWXjtTlakd7XrEQUb5E0/igKImK9bW4D
 PAAjcDh7i/4UTh+mR7jByDLCxNwPTBv0zla1itUgtWHodKaislS3StolUYuSVyQb1KDP
 l4vg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785781329; x=1786386129; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x9ZImVd/rO7BV0YppEaOdAU/wiWFe96AuvDqT6HskHA=;
 b=e+boavB4wbxOC8IQIB4wtlmcrACN0Fr4QTD2/4XG4BXbAmNq+/keJPnlbbeKFiU0/m
 oLS/hxK+t4lCE/Dpl5gRARWp+T/XCS+WmGgNISr6GXRSbwo1nFMBQkt7sDcFkaDzOLt9
 HRY8YW4GpFQPdrJhXAuRT725jhgYdWmHrpRG9ZLAJBL/XnMwolPsKAvW9Bqiz5KU9/SI
 bTxmULro1gzpaUj2bA8q89kBCJY0gSMwoiIPiLX0Hqsp+qbzZieTY2CD2dkpvEw0VrQL
 X4XLEUcKCj/NkjUry6lEYgQIVb86qFQtuw6o7VHgQcM/+m0BF3FyVUO3g1vS1KQtZLoE
 0XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785781329; x=1786386129;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x9ZImVd/rO7BV0YppEaOdAU/wiWFe96AuvDqT6HskHA=;
 b=D37j8GcsCHApNquhb+qII0f68m2SfJBhC9/O7ti31Du+FOMp3gUO49acfGGEPyjvVX
 uSeNwRhzQULSzPxQu7wt9ImJuMVUE5mM8ofG/gBUFSyWVbdIdlBIF6K66rQ9cPsPtB8p
 xl5A4vvXqIuR5EljHfm/qIjw4e780taXrPB9qhfSH8zVAJj9uZEwpHmPeUN2JDemsRv1
 twmVauC43lXyYpaxbjy2VllaN9XBfoMKv64wFxso4DfihtVM2kwT4+vKkvGAAZoa1hP+
 eZKkJPFBXh0vxLKkecRmBgRVOeJ2pcruGjKte5K+8Q/E+BmpeicjB4JlFsX5BogZIvnn
 CMFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX1P2EpwPR5vci86Yw5p4gpdMDSyKgHH2OvA+Pa5ayWNbjoxD2Gjn5StdV2fLGKZNOFoumBLUGJtA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqUPj0LrXxfiuViOg41rm6caQMFxzZVRHBMumg375Pxtlxbwdf
 KvOLYOJWUMXKGPztjltXlm2w797UaYMlYtOxQFnsoGKN+kTHwp+7fLQAKOr6AwhnwW3og8q50PX
 ZhtrGJx2POG9ZoOKs5MadYRP03SE6eAA=
X-Gm-Gg: AR+sD12oZHMTmhOPTFts2uYj6xJg9Y8WSrRuYkXmtAjcPyzq11pv07jPo49k+AC8VgO
 ZYlLMhziVw4hG4HFzTrAfFkQxIAIQHXEAqOYILtLpRifqNeqeyLlU2SkglIVtANhREPXroPKJ+d
 UR47BzdCkGr+2jmMsLjtrOz/Jp3tSGUS6kTDlyukV8dOENvlNm7v6AudizSwJXQF1WPB52VzERq
 reNtlusuXQ3S4eGrGozPg9UsyuAfwwn2mKb4kdkr8s3DxQBWqpaNR/5gHXjqPz38HCREL0n3GIq
 RNV8R8wBHqUcZ09AhssFcIjY438HCp1o/oMbL8O8qmhxwfymAkjPit95eNm0KUxLG42KUdcOJ6I
 FATubsllLnLmfG2EXEywLE9pV
X-Received: by 2002:a17:906:345a:b0:c15:df42:952c with SMTP id
 a640c23a62f3a-c1fe814f9d3mr623164666b.28.1785781329045; Mon, 03 Aug 2026
 11:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260707175212.412699-1-dbgh9129@gmail.com>
 <20260707180553.78C7F1F000E9@smtp.kernel.org>
 <ka3af5qc63pdcvh3uf6ulb25wrsf6udjugm62ooxuscxvz6zhz@mbuivewege2k>
In-Reply-To: <ka3af5qc63pdcvh3uf6ulb25wrsf6udjugm62ooxuscxvz6zhz@mbuivewege2k>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Mon, 3 Aug 2026 14:21:58 -0400
X-Gm-Features: AUfX_mxg5JGAIlsbnyi6v5lSwC5pBz1uJRyo3H-rzUgbkZm2NvpqldQcxoYUhKc
Message-ID: <CACrCO_UUX_A+Z7uCsT9=JkXqqkG0Tp=n0rXO3j+KAzNxGRuVQQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dp: Disable stream clock after video-ready
 timeout
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Kees Cook <kees@kernel.org>, Dale Whinham <daleyo@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 31 Jul 2026 at 10:05, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Jul 07, 2026 at 06:05:53PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Disabling the pixel clock while the DP controller is actively in the SEND_VIDEO state violates the teardown sequence and can lock up the hardware.
> > --
>
> Could you please comment on this Sashiko comment?

Thanks, agreed. The posted patch disables the pixel clock before
reverting the controller from SEND_VIDEO, and the bridge disable path
may later issue PUSH_IDLE with the clock disabled. I will send the
revised patch addressing the comment.
I appreciate your time for the review.

Thanks,
Yuho
