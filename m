Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEC7C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1015710F1F7;
	Fri, 18 Sep 2026 07:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cqWJoRLt";
	dkim-atps=neutral
Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com
 [74.125.231.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AE210E055
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:56:43 +0000 (UTC)
Received: by mail-oo2-f39.google.com with SMTP id
 006d021491bc7-6c24d19ebcfso54773eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789682202; cv=none;
 d=google.com; s=arc-20260327;
 b=FYbL621FKTCOqiio8wvd3/ZdZ/9+QdVgCsiJqrh2NWK5gX0yRGfZNU/qINZ/tsxPWO
 cV4Tr1fId27xxOmTDhacdNGRP53nyXtzMme8L1vkYJ5Z7PJyGziPErS6t+eRGRuoXJF1
 yHz7E4ZohzuWblAzKXeUsM1AMCq2e+cIU+iFzoHDo7HbUxp1V7y64YEpAB+7TI0EWxid
 BAb9S/+MC7po/UGDA+qwneXQFEXZqaou9W210rC7SxSoCz4JSNLZKvXly/N+vFWANuGq
 cIlRAA/aVUGwAM4vtJA8JBL0ZIDjWMlQPOflJevaNgcOAky6HtQZeIfKzQm2j0pTgC9Q
 vXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=er5a82jOE/dMjvQLmdh6qXHLj1Ar/Uat8F/LKGOIt+k=;
 fh=kwQd/Uma5UGYtEkJPVCPjK7eO95OZpR+GXczQRuBO+8=;
 b=fEhNqp5OiK6j3sA7954AJIbA2fGmh398K0RrPtVRF3GbZOTFkIYpQWjabWuN8tt189
 jezmTIO3G2fXK14ugAfHJWDaMpyOmCrrT+cFTTvV33FKtmowxKwXPACrR7vnIfNpm2rc
 Ybtl0FTTE2qD/SGArkF9VCClcyOoNzQCepMvMqS+hxns6E38fx4BPGWNC1b2LGGZXpRD
 8Gl3eQCgvU/sG0v4q+MknrnDH8ZgrVCgbHMDqBdkbS8nvlMWs/2DPr4iNlJoxIy7AVME
 L3XetacSDMs7m9yEV1bxGqcjgN8suvENM2EZZsu2PkpJg22lbd3Gvxaw66/+VRwF1w2y
 5qTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789682202; x=1790287002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=er5a82jOE/dMjvQLmdh6qXHLj1Ar/Uat8F/LKGOIt+k=;
 b=cqWJoRLt436bOgof+JkIZOaDjWVC6y7c+ZcBs3hBQtNVb3ldj66F63QtHlsWS2K5au
 NVlashruLeb9xaFGrAJojVfRHZywKRn2oE797vW698uNDJaonrXGEspbnr/ZuUVX2QME
 F4D4uBxVcJTgx8VOa1JjX5GDYrwovnFYqhUXOVX9cHcuBLQZUriCUCrs5gaYZUs6omHU
 dOAJZVQ2Mvo3FYkHR7UQTKKuhrU8GdmOu80sZNM4WP4DEoPjVsbMK2m999v/hWky2uuL
 iyCfPlmeoo8WGqgt3znnbTPnUpXE+MEMhWEBTZ757k9sKiniQyps03kZ6wQkjkneWu3S
 +33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789682202; x=1790287002;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=er5a82jOE/dMjvQLmdh6qXHLj1Ar/Uat8F/LKGOIt+k=;
 b=jHAT2PmYugjXNg0XidsIoH4ti8yj60Y1PHqRmgwfYLaLFPbMOnRvheIEAmETNVTijN
 bi1tS093GN2SPptZEj3VmBqz5sWvP5DtAZJUx7tBvnD7KgQoSmC9oq0prSuNfA4trEio
 BKkqzloWhA+KcYVBjnrRhyBbIQaqqr8cRe6iDK8+UwaMzQE/uH4FyUomQAKTziA4I1H5
 Henh6hbHwpkb1x+/h4bneJgjRh6DWb6slNNtglfGVJl0CQT4K8CbXkSGglphephuD+MJ
 cNGjy1q62cST+KAesoRN/PNgdRxTXg8bP/2Pdj2ey/5o4jqOI96ENKr+g+l6vwSCe7wx
 hjqg==
X-Forwarded-Encrypted: i=1;
 AKwUvByRsbHNvK/YSFXAWGsgpKb5fSI4QB35op+PYBYbK2eKnt2+uKNaC0e2xihSpB2aOa6KIboCQaL2n7c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kyefNzqmnL1hFZspKqX1h1b9szwytorMGSPmFOAOHVNEvC5Is4
 g0o8+KD2Y69AiplK6bpvqwXKpcyj19cEcsFfXjpmol0+VX9xBYQZb4LzMelQFCAyzj3WwpU2XfM
 JD61hHdOQSYcvQxCy8Yq8b3JxyOSXGa4=
X-Gm-Gg: AYBFou2TQryMZUKyxjNHHQYBqhuvxHOxls/CXU2/aYdS5Cu2DLeTYSB/3p7McANYULS
 fYxdN+P3SQmT3/FDe9/a6G/aP9DmFiMTG1uglkUgDX2J3fY6ZuoUYY5POYt2T5UnoRx8GR29lWf
 3Bd003od1y0a8fXx7ftxXSNyW6zgiKvyPiw23hDKXdpcoe9aAWjJ+iPIa/kyG5dTNYxqxpoOGld
 yT889por7tnQMchxpnP8mrrVIqAKd6OfS1Zyze0HSz9HCynz61YK9OYpM2BLBZaMfEV9XHGbs9U
 0/AMutywzrbUKxgoZbKTVza1r3YlfE+ph/3O8kAhf1lseRVLEPgDadC9E0DXGL53/zIyuiZLHWh
 Zf26AlrWxfQYr0UbBw5zyyvgYwKKhIU4/54ar
X-Received: by 2002:a05:6820:2219:b0:6b1:61b8:7ed5 with SMTP id
 006d021491bc7-6ca9a132698mr439448eaf.1.1789682201892; Thu, 17 Sep 2026
 14:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
 <20260917215114.1136715-1-tano.dzhinski@gmail.com>
In-Reply-To: <20260917215114.1136715-1-tano.dzhinski@gmail.com>
From: tanodzh <tano.dzhinski@gmail.com>
Date: Fri, 18 Sep 2026 00:56:26 +0300
X-Gm-Features: AcwNN1UdQBWI62Niu39vnc_MepV5q8WTyFHhbRmt4e0Z1fYt3vUYBBKqOEmd_No
Message-ID: <CAJhzm-8wFgQoAt3gYHnKg-f-dVCiUycdcs38CUOa-rSrmT2NFQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Giuseppe Ranieri <giuseppe@ranieri.dev>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

FYI - the CC to Giuseppe bounced: ranieri.dev no longer resolves
(NXDOMAIN on the MX lookup), so he can't be reached at that address
anymore. Possibly why the original posting went unanswered from his
side too.

The From: and Signed-off-by: in v2 still record him as the author,
which seemed right to keep regardless.

Everything else on the CC list delivered fine.

Tano


=D0=9D=D0=B0 =D0=BF=D1=82, 18.09.2026=E2=80=AF=D0=B3. =D0=B2 0:51 Tano Dzhi=
nski <tano.dzhinski@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
>
> From: Giuseppe Ranieri <giuseppe@ranieri.dev>
>
> nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
> straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is no
> hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
> configuration with -EINVAL, and nv50_hdmi_enable() returns before
> hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.
>
> The result on such a card driving an SCDC-capable HDMI 2.0 sink is that
> HDMI audio silently stops working. Video is unaffected, and nothing is
> logged, which makes the failure hard to attribute.
>
> SCDC is optional, and the hdmi->scdc() call further down is already
> guarded against a missing callback. Requesting it on a card that cannot
> do it need not invalidate the rest of the HDMI configuration, so drop
> that term from the condition and let the existing guard skip SCDC alone.
>
> Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config method")
> Signed-off-by: Giuseppe Ranieri <giuseppe@ranieri.dev>
> Co-authored-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> Tested-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> ---
> v2: restore Giuseppe Ranieri's original authorship and Signed-off-by
>     (he posted this fix to the nouveau list on 2026-01-17,
>     https://ratatoskr.run/nouveau/2026/01/16963412), per Lyude's
>     review of v1. Added Co-authored-by and Tested-by.
>     Tested on GK104 (GTX 670MX) with BenQ PD2700U and EW2790U.
>
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/disp/uoutp.c
> index 377d0e0cef84..9887b3898505 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *ar=
gv, u32 argc)
>
>         if (!ior->func->hdmi ||
>             args->v0.max_ac_packet > 0x1f ||
> -           args->v0.rekey > 0x7f ||
> -           (args->v0.scdc && !ior->func->hdmi->scdc))
> +           args->v0.rekey > 0x7f)
>                 return -EINVAL;
>
>         if (!args->v0.enable) {
> --
> 2.43.0
>
