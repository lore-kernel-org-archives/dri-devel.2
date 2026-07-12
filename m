Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE980C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 19:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0346F10E4C8;
	Sun, 12 Jul 2026 19:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BGyoDG1b";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF12F10E4C8
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 19:20:13 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so3514329a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783884012; cv=none;
 d=google.com; s=arc-20260327;
 b=RNKID14d0Lu0h6BkIz9cxokJaYBFN8KBPGUWAIgdIIRnK8LP2txvYPLeI7+PxrCMJY
 vI+z9kTbclI72ir9hOHPppYKJHAXAXD35tnycsmHGNqZBqyv7UwQJ/HGOuoI36ET5C4o
 I5Xc3y1AeUtHF3PC6/Pq3NCBuVDSKwZAVUZBDjpqy2ayLxFqfUqniW6XP4+QuCbttLnH
 Btq+2i9XLu64o6xwDr9i47UxmX7PKdR9qXd276ZrHJSgCATl9EKnL02PO9vIOc0E0yes
 2c4ZDL41BCLgiKd5TT9AHhJ+VrxML5+uWpiczHGaTAnJk/0foOHzTlxIHMWxU5bJrpNc
 smyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=envEX1zOzIKuUrK8VeemThjCFlpTmLy704Os8qfEEOg=;
 fh=Kaxblu2UzGUTn5N0J3e76sM+t83mAPiXWWOj4Gb5K/A=;
 b=DD4ioAhp6f3RJ8GBrbRSkCOCEXOg4wMXpS+KVJLYC21HdwBuAAKyEXcuyITHcDmlp5
 51TUsL82jqfI7ehF1bYejuWVGPfbb4huxqgnR3StD5/cAnvwiwx+CfL5shc+D1LaOfH0
 t7fomMRlCkVRnFkVraz4pSmLRR3sDV+sE0+TnYQ2Cn+O90Hj1CTvEH7XhS2zY/mqmNai
 ZmuybEfrHyik1m9DiOrDqUEeA07ugeunbe3kB29Omlp2gS77GI6u4T9TfFjLG8yDcxzU
 sEepMmLLl30Uj8M6MKsnSa9zldGaUkicBc9ZhiN6b0FkpAnHOaAK+INOPfb6SEO4nTEO
 kA/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783884012; x=1784488812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=envEX1zOzIKuUrK8VeemThjCFlpTmLy704Os8qfEEOg=;
 b=BGyoDG1b2qFIJZAixNFyKX9+9T2TqQRdEBjhcqXICnzizw+hdfEXU9eugdwU25c4UB
 PGYJ/tFEzaVKG596MkbKrsKdqoj4ZiuzohW7liDq7KenLUesiB2PsZJ0Z27ml5QAME8d
 eyyB/u/mMBloRSu1OgDZghV7iCl1jNY9Mq0HN6loriyVqt8G1gVnNyWt6KsnVZMOxqTf
 1aFUFN2J+Ub+arNajfUfkLdyzYKZRib+KvWb7DLJFcpOh0LVy0VzuH9U7zVwuKhWvBPT
 101HsSwzEMU/SvnJ2bc8UAuBv2pf70bCdUEiL64ODa4JDx98Ku+BJRvtrKmsdbyvlkUM
 s3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783884012; x=1784488812;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=envEX1zOzIKuUrK8VeemThjCFlpTmLy704Os8qfEEOg=;
 b=kajN5f7xA2PQA1dw8UnK4svdPXom6duYHNkMWrr5ygGjMe5AKrXZx5sJ1nJ60JDs6L
 1aqeWS9AxRJ/4ikfyvVkn+S7XwMGgjaMDNt36HBTQgccXbq8Ylzz0Z5YkYoO5mOz2t/X
 5mg1HpM/X+rJEpcHMHT5OHBkU3aOtzeqp4+p8yq03nMJuggGDRcJT+HVgDMYzL9u82qw
 n6UOD2I83R9zwmeszB5wPNVqAbwdRUiBHM1Ow5ZDpWpSxsx1pWzum6Uw8DGfYzUvhH8k
 N/k0DNLl0LjKl1FQWbsbPUHnGN2kI4ss9RA6+ARGptkqADuYpfks0UPgq1rkbAEK8vST
 362Q==
X-Gm-Message-State: AOJu0YwlEIoR/ylLLoZAHguvk8pIcPtwlBaMtYscXvbMNqdGG71d5FTv
 45O8OcdBINAqg79jHvaLiRyOrMJuREob3958+k5V5ssGsOF5K6KFd5fikdEHsSgnSCU5VOwBRMG
 G60S5oh7vUFQdwJuR9qN6gmDpnYGobWs=
X-Gm-Gg: AfdE7cnOi7tEnZVCqUV7kqMqABigse7Dt9vY2fmUvEfKIiQqA8ZjER7mtbrMM2LRNog
 WXtkZLlazoZWBmZVDrg1UD+5QtWS8Prqll6+S2Sdr6ra04X3maRESL6o6cNhT1RJa4hkMcvc96C
 oWLVhRhjA/RPIFMBNeH6wzin6VycrnXh9hA+1ffj1gs7Z8Z3XfJg2yIQ7q5znL6M6mReEP+Mvvb
 ah45boIIHLaFH1fE2y/oQPnjBTqb0buW7yVjRw77qOQQ/pxJRltpljZS4h+ZURKZovlHeiXinwI
 tnqVbV+/QELo6w1hI3vc0il4g9jcp53eBUJiDN+Wq0j1EG3B3kqtHVtItZ/BijN2+X1xDoAEl4k
 vksEk+M2IaJR60owMEcf/yJZ+QAcScDIX+zRVTwtwcLbPCq5Ie1WxoMAoq7VvNJVCy2KEzxobPk
 kK0QIRztg=
X-Received: by 2002:a05:6402:c44:b0:698:3b7c:7e4f with SMTP id
 4fb4d7f45d1cf-69c5f25087emr2860055a12.37.1783884011638; Sun, 12 Jul 2026
 12:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260530201342.10538-1-rosenp@gmail.com>
 <u5ozkmhq3ll4pfhvxl63ezf5dtgz25lvrwmpk6u7ofccnjicw7@skim2jft2cyp>
In-Reply-To: <u5ozkmhq3ll4pfhvxl63ezf5dtgz25lvrwmpk6u7ofccnjicw7@skim2jft2cyp>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 12 Jul 2026 12:19:59 -0700
X-Gm-Features: AUfX_mxXjd-PzYF2J5t6POcGiPu8wkdfdxMveXKURMVFOAJvEcjTdq6lpkFJg3U
Message-ID: <CAKxU2N9tizK6xbzscbeLHs4noLj5X1Dk8SRog5yHkLnkFBW0zA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: fix parameter name in
 dpu_core_perf_adjusted_mode_clk kernel-doc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <freedreno@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
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

On Sun, Jul 12, 2026 at 2:37=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, May 30, 2026 at 01:13:42PM -0700, Rosen Penev wrote:
> > The kernel-doc referred to @crtc_clk_rate but the actual parameter is @=
mode_clk_rate.
> >
> > Assisted-by: Opencode:Big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode cl=
ock")
Is a v2 needed?
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
>
>
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gp=
u/drm/msm/disp/dpu1/dpu_core_perf.c
> > index 13cc658065c5..2ff255d7795e 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> > @@ -34,7 +34,7 @@ enum dpu_perf_mode {
> >  /**
> >   * dpu_core_perf_adjusted_mode_clk - Adjust given mode clock rate acco=
rding to
> >   *   the perf clock factor.
> > - * @crtc_clk_rate - Unadjusted mode clock rate
> > + * @mode_clk_rate: unadjusted mode clock rate
> >   * @perf_cfg: performance configuration
> >   */
> >  u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
> > --
> > 2.54.0
> >
>
> --
> With best wishes
> Dmitry
