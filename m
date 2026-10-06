Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65251CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5CC10E5AF;
	Wed,  7 Oct 2026 13:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="plEwQNrl";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7529210ECF8
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 16:09:25 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2e5f8fe879so119801066b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791302964; cv=none;
 d=google.com; s=arc-20260327;
 b=L2eeH6bpnWh6n4mwlaMN6Mwx8A5JgTmx8wenJwESSmXibQtvFHRxK0Y6mlK5qWmfXS
 Q6fDat1sc6coKje7D4er0LxuWzWNhc80ragPtoZIezO+nxr4Ol1GqsXkRSrUbR2XwASK
 zzl0JhBM0DhYNK0L+9KBRapNzjSLZsqlHLvbUuCRlodTBsdI4Bvs9QAOBGcnzA9IcQvX
 aGZZIhFUCLTvu3xPQFfFGwTH8knd64B0HE7osSHrz+VAbHKzWbFyz8rZjJltC9xPCXxs
 FUmCBw/8zfdy+bZrVSdH7+pUg57NPYATKQkecj3d77RY4MVYeRBIBjqp9MSOcRAV+R2V
 JhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3usypQk1aH/wgn8+3d6DUOUXO79QcDW+qxXIhYKt0d8=;
 fh=SjrAXtnGfqYKc92rC+6EW+MawOWPFvkQtSCl1DqIPkQ=;
 b=WhPiKVVSv+LAvXznZ66hq5Iufpfj+7GfxJgH9rWOtA8tEQdQTyG55hQXm1vY+aeM+P
 N5gQGS6Mh7HjNwWOFxnDEa+2RNoLRlBybtLX9rw+Aq7oaqVNryxsOHBVSal3L9InXbR5
 fsoAHXVxVJjEC1Zabv5C0nMhHUVsZbAeKeaNvQctShDZBjIw8dOyIIe1j+u/JHwI8cHr
 nJ1Gembuo6cBbxvw4DIFE6ltTts41LSaePx4qRMCzWYVlS93GgSW2LjTe33DuFR7AAow
 jc9GSV/aELdWJe/Bdj/525zu/U6CPXvbnku0L7Fs9l2GryY1Dld2OOs0gwXYItv5SfoJ
 unBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791302964; x=1791907764; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3usypQk1aH/wgn8+3d6DUOUXO79QcDW+qxXIhYKt0d8=;
 b=plEwQNrlMzsQd3Isq9+RihNRY1j4ilg4ew6ZqWTMV65VCgZXNwzSul6z/Vbt6qIni2
 cN7jb+UUhk8hxAEPszmY0tdCXIJ00FgsKaWiw0qbNb3kVuCA0YWv9f9y9NqQoK3AtFyy
 5T6hcUAwLficWpmWlM5plRZdrdDMYh1SILNbYcH/ndPXW39gYfjkPHbmIXmQXfaaysJx
 ujc4K3ZQzjKrpDN68u9fZ12V+zEK4ISkRdN5uo4AwTw080elGU7dkKmxeTHMw5jCBt7M
 HtByqWHHpT4eFf/iD9VKjuivhygq0U/wdI0UVuluL/hd4LYxiJwTOvEP7jvcNqLNwkuA
 7a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791302964; x=1791907764;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3usypQk1aH/wgn8+3d6DUOUXO79QcDW+qxXIhYKt0d8=;
 b=zWFns7N8PrQh343r+xuDXOLpesX+3SPcFZSlY6z9pUdi5C/Us/dAmtanFcu8knfykk
 1RmaYT3qNzrtwLCuSyi834A+MKu+JXhsUl1ELW0cIEinXd2HEi+SrFRB45SKAwmlpUgX
 zvsP1Th8GWXotOwjdm5GGHKITByavagew0QQ8C+RkRaxS6VRDlY4I6BTMJlIZJ1X/uFj
 MOpPTFbNn0f5awwcC36hdL+t7BqD84Gv4rl2w/FiP47VIbBWuHs6GoJbCVyglysYCJ1g
 srW9IhQDFEappkuN9f8N9dHAjimlbcw1a5gqYZxOZiS4qVYzxv5xwzmCkYmgzz0l0iAB
 /5jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbzsPlwxqyRFadIN1hDPFdS8fHTLtcBGxe7EJZLSm9PcVwG7CHUkLw1bx/ZvDRxDai0y5dHqh56Xg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFv08DenV+v8MZVUzyhPRlDyv6r3j46XLQON37tSqpfgrWODY0
 xMeWuNOybMaUX8ZBRdotFUy9mC1pzAOgj+fIRqV0GiOjiGwK7mMRjFarMQDL+fNbiG+t8wZW8bv
 jdBPNmBmCccOawiHTXDa4Iav7rhXSzKE=
X-Gm-Gg: AYBFou35lcXGqwccKsq9pbBggnil2TYRzv5moO1Oz0fYIJgX4QLCbshkGjPBxxX5ode
 Mf4Ap5CX7U8UgdHtf5o9zNK5XZifSDDRpjn7aiYlZGIf0Baw/dDQCQBTEhrhYHXGa8TsP5AWSll
 EaU974KhLjVtkKLFVfeOPNNwTzsZgXgm+qI4ah9heIo3Bql/EqqOENBlG0UdgN2GylUmrfYMnbZ
 e7BL6Il13y/2Y0hcL94Gysv/VR3tkbFedHcQD+5k4S2qJx1PgEAiPE5cwsudae99reF8Q5BKaKg
 7NpsvDPBNQD3obDq9THzm2+QAfR45FCrA1taO2xVZeE0V3sL8Ow2144xBwAma1QxNFk2aEpjr1N
 G+hnd0whFg5evR3ESMXwvQ1jU2h7qMfpbmw+MJlbxdFCrWsvWZvEgq4loX+7bzUjR+kx/n8srRg
 ==
X-Received: by 2002:a17:907:9608:b0:c2e:350b:7220 with SMTP id
 a640c23a62f3a-c3169faf310mr221144966b.9.1791302963551; Tue, 06 Oct 2026
 09:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <5893371ab206c97d5d2f1d72eb149d5ace4250e2@intel.com>
 <20260924211852.436787-1-conor10@gmail.com>
In-Reply-To: <20260924211852.436787-1-conor10@gmail.com>
From: Conor Svensson <conor10@gmail.com>
Date: Tue, 6 Oct 2026 17:09:11 +0100
X-Gm-Features: AclHuK8euk8GLEFfAD6Rnbhy2sHY5UC2jDl_5n4HYrsNEmactwXBlRsXbHOqyPw
Message-ID: <CALr9iFoWV7YVSb9Hi+kUUmZP5wUhGwaKf1XTa67KViqj1=4b3A@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/dp: Configure protocol converter only for TMDS
 outputs
To: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, 
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

Hi Jani,

A gentle follow-up on this patch. Following your advice on the
original RFC, I investigated the root cause and posted the findings
and testing results to the GitLab issue:

https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180#note_3679658

The revised patch replaces the device-specific quirk with a change to
the protocol-converter configuration. Feedback on the approach and
whether this belongs in i915 or the DP helper would be appreciated.

Thanks for your time,

Conor


On Thu, 24 Sept 2026 at 22:19, Conor Svensson <conor10@gmail.com> wrote:
>
> intel_dp_configure_protocol_converter() currently writes the HDMI/DVI
> output-selection control for every DP 1.3+ branch. The write is only
> meaningful for a TMDS downstream output; a native DisplayPort output should
> not be switched to the HDMI/DVI protocol-converter mode.
>
> An Anker 565 branch (Synaptics OUI 90:cc:24) changes its downstream port
> descriptor from DisplayPort to DVI immediately after this write. i915 then
> derives a 165 MHz TMDS limit on the next hotplug probe and drops the
> monitor's native modes. Skipping the write for non-TMDS outputs prevents
> the transition.
>
> The existing dfp.min_tmds_clock classification is nonzero for HDMI/DVI
> outputs and zero for native DisplayPort outputs, so retain the write for
> the protocol-converter cases that need it. Colour-conversion controls are
> unchanged.
>
> Tested on a ThinkPad L14 Gen 4 with an Anker 565 A8388 hub and a Dell
> S3422DWG:
>
> - native 3440x1440@59.973 after DP recovery
> - three USB-C reconnects on the first USB-C port
> - one test on the second USB-C port
> - suspend/resume on the second port
> - HDMI through the hub at 3440x1440@59.973, with HDMI-specific modes
>   present
>
> On the unpatched control kernel, the live descriptor changed from
> 08 f0 01 1e 00 00 00 00 to 0a 42 00 00 00 00 00 00 across the 0x3050 write.
>
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180
>
> Root-cause findings and validation details were added to the linked issue.
>
> Assisted-by: LLM Codex GPT-6
>
> Signed-off-by: Conor Svensson <conor10@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index ffddf4b33..cdc3d7786 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4422,14 +4422,17 @@ void intel_dp_configure_protocol_converter(struct intel_dp *intel_dp,
>         if (!drm_dp_is_branch(intel_dp->dpcd))
>                 return;
>
> -       tmp = intel_dp_has_hdmi_sink(intel_dp) ? DP_HDMI_DVI_OUTPUT_CONFIG : 0;
> +       /* HDMI/DVI output selection only applies to TMDS downstream ports. */
> +       if (intel_dp->dfp.min_tmds_clock) {
> +               tmp = intel_dp_has_hdmi_sink(intel_dp) ? DP_HDMI_DVI_OUTPUT_CONFIG : 0;
>
> -       ret = drm_dp_dpcd_write_byte(&intel_dp->aux,
> -                                    DP_PROTOCOL_CONVERTER_CONTROL_0, tmp);
> -       if (ret < 0)
> -               drm_dbg_kms(display->drm,
> -                           "Failed to %s protocol converter HDMI mode\n",
> -                           str_enable_disable(intel_dp_has_hdmi_sink(intel_dp)));
> +               ret = drm_dp_dpcd_write_byte(&intel_dp->aux,
> +                                            DP_PROTOCOL_CONVERTER_CONTROL_0, tmp);
> +               if (ret < 0)
> +                       drm_dbg_kms(display->drm,
> +                                   "Failed to %s protocol converter HDMI mode\n",
> +                                   str_enable_disable(intel_dp_has_hdmi_sink(intel_dp)));
> +       }
>
>         if (crtc_state->sink_format == INTEL_OUTPUT_FORMAT_YCBCR420) {
>                 switch (crtc_state->output_format) {
>
> base-commit: 703cd271db3a35088460ab3fec0a96bd48e7fe04
> --
> 2.55.0
>


--

Conor Svensson

Schedule a Meeting

+44 (0) 7497 376 365

LinkedIn  X (Twitter)
