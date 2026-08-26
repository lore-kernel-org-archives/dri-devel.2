Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0697C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2112B10EC4F;
	Wed, 26 Aug 2026 08:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eEYQyxV/";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C8E10EC49
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:11:04 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-66c9995ca60so2907384d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731864; cv=none;
 d=google.com; s=arc-20260327;
 b=n/6D4r78O5S7s08oMSTOi3KDIs80Ji9M6AZ4K6jGOfbdfhgpoCR8rJc9IBg+T7juB0
 rl2qBoxdj9/ZbqKOKCzXrQp0osN74F3Fq0w20nYa+uSSy/BeNg1Z4Gj/v+uM/7ldFVtg
 kVj0ZJkL9Arbq73Qwxw9XgfXwjvvMMc6IiGQoq8Vpl4X3ZShZn4scy8JqO/vFVtcYggS
 YoVWu6XEp0UepTXLLrOZVt6gVaJXJAVgA7xYAoLb/QMhX4VI04EXSonKCtEUxVdz+Gf4
 Y/mlNOMiTxHhE4i4knFUQRi5tl1YXlEIZYe745FQFLR/R8tUJBHcZfbZfazaNNJA4N95
 VvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
 fh=eqF2UhgqjlkN2heBUBuyO3wOPpR3wswlNBnP6a7WS3Y=;
 b=SfAPHynaqUdfN/VSEFNyafGosfFiC2LTGY/B+mfUdPNbFbh3tdZKn6bYyFUtp4SVKz
 q8iF+PAB13UuZLrFCFyFsxC7vfGKNWtQT/6pBPIfXp+ZhfYFJdV3zaXxrdUanS+GH56/
 ehifbupjtMcP3JpgPnGM0kqxkjPH38vCInNHxO3ekFxeMEAYeR1R9En/3PouMSI/XpFM
 5LbxKILQA26i+z7PTa5eJl0nAOVjwXOdE1CTnfjIVmkY6QLQXv8m962zAUuIXp2hvIk8
 f2o45p+tW6dNatzmV1sCwoeuLHeluFjtlYNzUaL/zo0iXtef0pzNR0fla35EFfv1I+ul
 YQvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787731864; x=1788336664; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
 b=eEYQyxV/Oa732OHOXXtYO7sNVINgMNdeJc5cd/eQ9tPIwMUiTCM34mAZQCNRcdWa9w
 AEprhQcHz6lhhWy6aHci8fhPZttMO/Mz61w+Lg7u3/Ei6QBR+bnnFYDp/B7jOGuF9Fmt
 tg+djfsXi7aFuiH59jGuggBlwe6A2tICsobI5MMF1W8YVieedXTkSPLBNjy2i8lxG4vg
 UsiBfCiHt1F8JUxNGRmJRQ3/nfLAwXFDB5XU2Ce/Ost5SO6HRqLm7Dlz/hQdmLasTuZu
 H0fIuqi8+lx+CMN21ymjs6fZQVLlZhzRgu9LI+4mCZGHm/RBiXHewuSwXhIGmUvmOs5V
 /zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731864; x=1788336664;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
 b=DhKDX86fpP8GYONq1l2DB/1NW9usm9WhRH1qVumQe3+evfnLfuN13xfEly2JPml/gZ
 huKoa9jtF7MxoOU09nTJ7kPWD7+2Fh778mifMSsLAgk/3SIrU2lWwb31/Bh+EPjyEL5l
 I5l41fEIG1KAamCpFs9oMeaA++8NkQaOGCzQrm10zh6Bb+LtcPM/jSE399m2WU4A/Ipd
 y6a/EqaTXq5OWilFNSfItfIALAkQPfZo6lzUsErgY61z3NCLT8kL9jHKvH7gR9nEVOnj
 LPWDMfiEI5IGYyVKTM99ndyETR5ux1djC5yZMICce8nI9QrdiAiQ+U/vOtl2YHkydqcz
 SH9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWBcFh9QhRzumnP8ku82oxR2FpUKUBKunPmbAB9i4AgMbGBFagRoknv60ZtxGMETsB5wa14fFCQSw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m14vV8MEoprF2uQk3hRf9sX7vuCQ6kBeEXS3RxQoy4dOGGf0Ir
 Sba0DGqTGB+hO+HFXkJNxv2yAKzjEWa4djTeB58SWy/U4MSO+3TLwibWoMnR4yvug4wmP8oHzgq
 pMe+Vw7kP1HHKW4Bf3WRMaLGkNzX1+MY=
X-Gm-Gg: AR+sD12XjfcNZzRnkibnBeoPrVkUkVlP6gE9Pp0Vu+Gxie4Lpz7YLlzVgxAB/OsWEtA
 P8oCpTmYXKuQyHu+jIM85/V6RagVqyFtoMsfrEH8XwEcE6/CgYaVd3Ge4bb4U/CFdJMz9OCbIPd
 ycLLwzUk3W5hF3tOYkYLg+/G/YJVF0YJZ7HcyOah0wJjKFET6XMfNubVe1FAXKrHa2V9aRazxzv
 woGI0QMFLbDnLuCu4APECOvrOCu7m5MKdo/t6aTuC5STXJSPeOv9UbryfqZcWf4Rut8FIdDdzE3
 LzQ5ueU+e6f4MugRFCl3o6qo6U9bDpPXXCtYCejCLVLyEXE=
X-Received: by 2002:a05:690e:214f:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-66d25197bf4mr1276551d50.13.1787731863957; Wed, 26 Aug 2026
 01:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
 <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
 <d85c9ffc-d9a4-4f33-bd63-5cb7a505a840@kernel.org>
In-Reply-To: <d85c9ffc-d9a4-4f33-bd63-5cb7a505a840@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:10:51 +0800
X-Gm-Features: AcwNN1X9rQBObyVrmy9DFrGufRcw2p9RUUYyy3KtMY7rqaV5_V0d3WC11PgO3Yo
Message-ID: <CANUHTR8sA2xbXsex1VQu2acL2kZyCHAK6xQk1EKA_Hxv4n12rQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hi Krzysztof,

On Mon, 24 Aug 2026 at 14:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 18/08/2026 12:40, Konrad Dybcio wrote:
> > On 8/8/26 3:16 PM, Guangshuo Li wrote:
> >> adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
> >> adreno_gpu_cleanup() does not call the matching
> >> pm_runtime_dont_use_autosuspend() during teardown.
> >>
> >> If the autosuspend delay is set to a negative value while autosuspend
> >> is enabled, the runtime PM core increments usage_count to prevent
> >> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> >> during teardown, this reference is not dropped and usage_count remains
> >> unbalanced.
> >>
> >> The documentation for pm_runtime_use_autosuspend() also notes that it
> >> is important to undo it with pm_runtime_dont_use_autosuspend() at
> >> driver exit time, unless runtime PM was initially enabled with
> >> devm_pm_runtime_enable().
> >>
> >> Add the missing pm_runtime_dont_use_autosuspend() call to
> >> adreno_gpu_cleanup().
> >>
> >> This issue was found by manual code inspection.
> >>
> >> Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> >> ---
> >
> > I think we can use devm_pm_runtime_enable() instead, which will take
> > care of cleaning up both the autosuspend and runpm halves
> >
>
> Author here is unresponsive, he was told a few times to send corrections
> for his vast amount of unthreaded patches and there is zero reaction.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
