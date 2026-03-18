Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD6FCD0DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674EE10E74F;
	Wed, 18 Mar 2026 08:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oq93M5Yp";
	dkim-atps=neutral
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E7110E559
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:53:47 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-417c34b0509so3494653fac.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773798827; cv=none;
 d=google.com; s=arc-20240605;
 b=HBbnXONAUdEicIP2vo7cWo9khelBykM9Wlv5cje95CRiLXKzuxPVFObz/l35lqEBtU
 TGwGxOeRSUtJRINv2Prvi9+I1E4ZK7QjCBmx0TT07UbqcgzlScLt/yZQKFAV1WbLLpGx
 FIb3C4qBa0czhI7TOGyonaN1NU6czdEAu8utVdJvSlcs8Q+b0VegBvhujCimEvdRqXKR
 kYeFO9wzNDS5k2sS3cQyqm29TJd1XGvWKwnDhs5y0E/UY5KkYeUXjvwWDtyeNxWEAzL3
 oV/6ZAcI1cFs3MccNABxxLtOcbP/tzV+Wfvo8JOugzQSOaEkhgqnhDoarMDw+5woYgVG
 TQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cp9Ep/hNNUKT/Q107TyB692cBkvdQAk6sieLmz8xQmg=;
 fh=T9KKZ6yGp/xiRwgubC7jSKXmJzcBMTa946ORpAa1obs=;
 b=eN7IkfZEzTnPfn3kEuJ6qgA1fHHbf2bkZZTtN3HApQ7nAJm9li8Ek26zuWxn30cfSV
 BAt6nD2VRPruuow8sUNSdQ5j66Sb2q2Ft9VEFb0H9q0e+AjcoFuzRxlAeapUcGObhyhI
 Tav/f/GPzExJUuPRybARMwRu1ixUFW0x0bIf4Md+R4CRngiuiqWfU8RkeKDoCushd+iO
 A7ie1YorO/0cutckHRXMwCgUCFz0eGPpALaNk2IoWp3bMP+H5nfXEwMQ2VMAVxuserUa
 ZpE9zPiVtKbLFm1r8+v2Vy82sPXkb426SsN/2+rULTBHaV+9k6gUCMJdwWkQcCRrY7aL
 cjig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773798827; x=1774403627; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cp9Ep/hNNUKT/Q107TyB692cBkvdQAk6sieLmz8xQmg=;
 b=Oq93M5Ypo1IoM7uJy+2vr0sn4ZxZhrqkYVsw6Nv47twXCyOnHMbw0DJVvMuRhPQ3//
 pfuyJ6URGsE3NZlha0G4+APHPdgH2bpqylpDdS1IKs/e385IL70aSCuIiePA+8VDE6xw
 H/dzbAQGlxFfrnA/L/Kj5Wwn6m7myDpJIqMg4GPJ74ZHHaVe1vKLWskvo1HNZWyB0Z8s
 ZpsAyZTkGqltxWOKPUgrMQxbVsbb/f/ShP85qOHeTz7suMqNgkmXAIzakfWQXUmMmsm+
 5hVvGi/BtvRaJl0W7EzLNOwZ7xDaV7OGet7LwWeykxsyy5TAqpJPgRpi7mqvX5OIeuq5
 eFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773798827; x=1774403627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cp9Ep/hNNUKT/Q107TyB692cBkvdQAk6sieLmz8xQmg=;
 b=aziYijnUkg/x8T1F8/1MvmAC1abzUqvgE/gZDC+GTVNDUHEe+qEmmxohL7sJpdP8/G
 wXi412qHF4Ogwrct8roSvvGyz4lk6BkdDl1wE0VTlSg2UJr3rd0XHBufLpNlfyqrghN2
 wwMw7kjjaIGTDtOs4tq2as4qP2R108UxN0HtX+Gc7cljYI+dcZAfUpuhCxG34ZdIC3H/
 Pp3CLqfcoZWQAV8iNVJ2M6H4ujoRkOIWoe5G+AHnk280OCyBRCPLbE6BWo2VLnGqMsyW
 8R8ClcBwDqgBZIeboERVU3YCgeU/mct9E3ZJJi0CRb41Od0I3RlLa+TFCloeqgJcwn4h
 /Jsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn4kGlsD3g0A70NHXbRRv0/lKK+ALxNNOkbPIzhG9cqiE59tfKO8AbDOpwz0iv9dmcRhFsUrVwdpU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwN23SizBFnA/4YEkPaemfuDr09c9uop2mbadOFkVlsT8KSIED5
 J/DSQoTvkPVX51qc02wXgBHq9uJFNabo4a+oDPIYx9b/pLJM+OlQbz+21uOyRR/Synj0YiyxIb5
 BDx+s3d89nVbwH3wJ4RAy7O09Bueo0do=
X-Gm-Gg: ATEYQzz67IvqcR4RAJiP5zqOD4UE3/aOpnrWsn3L5IpnevJNmvbu1alYGDcgtO2KxkO
 m5nmTCSb2wZkj9xHPlhyaqCC9J/g2S0ChiK0VpGVRVDy19Mj7D6FH1zOweLWuVHJAAFLertLFph
 kiq06dCDEx4QkkwVmIx++VFdzuh1Ya8ljD88Ml2sAsnPxiAMC7MI6EzlPiwgVk6aSnma8WRnSRP
 2MkyloosOcrcUVDDDIlWKirFhYsSdzxLEGfj+6vhSdawXgs3oC05+HCF3T8wGKgzsK67RnbiC6S
 UclGHFaIZjrMaf3wO2IzTZOdgw9rXW1b4pbW9J2htVxJoBXBuD5hr0+WbTjlbD9Nk+5gKbRx6mp
 2wi7k4esSRw==
X-Received: by 2002:a05:6870:ebcb:b0:417:1ba0:7320 with SMTP id
 586e51a60fabf-41bd41cda0bmr1126217fac.33.1773798826608; Tue, 17 Mar 2026
 18:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260317185920.43387-1-hanguidong02@gmail.com>
 <20260317191538.43535-1-hanguidong02@gmail.com>
 <c14b399c9c6bf96f8c7d33615561b0d787ff175b@intel.com>
In-Reply-To: <c14b399c9c6bf96f8c7d33615561b0d787ff175b@intel.com>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 18 Mar 2026 09:53:36 +0800
X-Gm-Features: AaiRm52nR_v9OD3YNBiYZ0KMPL0_wApDenMFnYnmDk762NDAGBxD5i0lDEEX0xA
Message-ID: <CALbr=LadoX8g--rtU==HQfNQ9f1=KP=7AS-PGfooKaSbnYPz+Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/i915/display: initialize string params to empty
 strings
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org, 
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, 
 airlied@gmail.com, simona@ffwll.ch, gustavo.sousa@intel.com, 
 demarchi@kernel.org, jouni.hogander@intel.com, luciano.coelho@intel.com, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org, 
 akaieurus@gmail.com, me@ziyao.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

On Wed, Mar 18, 2026 at 4:12=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 18 Mar 2026, Gui-Dong Han <hanguidong02@gmail.com> wrote:
> > Passing NULL to debugfs_create_str() causes a NULL pointer dereference
> > upon reading, and is no longer permitted. Change the default values of
> > dmc_firmware_path and vbt_firmware to empty strings ("").
> >
> > Existing code that consumes these parameters already verifies both
> > pointer validity and string length, so empty strings are handled
> > correctly. Furthermore, heap allocation is not required here: these
> > debugfs parameters are created with strictly read-only permissions
> > (0400). As a result, the debugfs write operation is never invoked,
> > meaning the static empty string will not be erroneously freed by
> > kfree().
> >
> > Fixes: e9913f0bd2e1 ("drm/i915/display: move dmc_firmware_path to displ=
ay params")
> > Fixes: 29292bc6cc37 ("drm/i915/display: Move vbt_firmware module parame=
ter under display")
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display_params.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/driv=
ers/gpu/drm/i915/display/intel_display_params.h
> > index b95ecf728daa..0a8cad98d480 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_params.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
> > @@ -23,8 +23,8 @@ struct drm_printer;
> >   *       debugfs file
> >   */
> >  #define INTEL_DISPLAY_PARAMS_FOR_EACH(param) \
> > -     param(char *, dmc_firmware_path, NULL, 0400) \
> > -     param(char *, vbt_firmware, NULL, 0400) \
> > +     param(char *, dmc_firmware_path, "", 0400) \
> > +     param(char *, vbt_firmware, "", 0400) \
>
> Admittedly this is all very convoluted, but these NULL pointers (or
> pointers to them) are never passed to debugfs_create_str().

Hi Jani,

Thanks for your review.

Could you elaborate on why they are never passed? Looking at
intel_display_debugfs_params.c, the intel_display_debugfs_params()
function iterates over INTEL_DISPLAY_PARAMS_FOR_EACH using the
REGISTER macro. This eventually calls
_intel_display_param_create_file(), which uses _Generic to dispatch
char ** types to debugfs_create_str().

Thanks.
