Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D3CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A938C10E4EB;
	Tue, 26 May 2026 14:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVc26bQD";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63E710E4EB
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:05 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2f6e6a0a215so911569eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807185; cv=none;
 d=google.com; s=arc-20240605;
 b=hS4BceXBoQTuT/Ol2nZsUZOAYB4aZBOdZiW4KncIEHBqyV4Gv0+7OMjQLMaXieQKth
 wHTAuPPR5VS802EorJpEII5uhW8CJuyxHS09BtipL6EZDZ0IugRXTRyDgz/KeG84ns8G
 BgYB1qQ/iEE48BrhktxFQegebH9V8Xf5b800H7gUM/Ni41VDlsP9EXw7N/ils0YLrDHm
 FFQ1x7OUFTfxf4Wb9bW+074YAmpwosaY47Q/1hPya1mc6io2Phu1VTznGSj8UItEj9Fu
 jQhSPCG9+tVCPs2wDBp5pIGTCdvEQFAYmvOva/uAsMZtGCbqx3q9yXUTWvFikERLMfi+
 hlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kuzpY6XgB0sl9R2wkZih4Zz2Dy5QZS8ND0a9lUvUZwQ=;
 fh=BtuRJVwAkX2E4OO+BDUpq2amV+Zo+8WfPbzAut06qYE=;
 b=gwAPtZL+NhXJQcuJXIP4vAXVK8r527m/mgXcpu4dd0YumC24Rkn1kIXs4k0JUwgTeF
 ndBZgcSUNeqPUw8KD3AoYAttGoj+RlYpHfVRzNrJwlW565omCouDyp1T+lPh4zPQQNFO
 RShHuElxBguULPQmVaWwA7pwFmWkLVkGPplfvWxSS5E1P31jmLkuZkm+QYla+XDmdVug
 GfHHH4PXFJJLa2PTEXe1tmwSiCM9UzZM8acsk/R83RK8JzX0fF8j7FVHQIo+mj7wEzLO
 WDrB66NfTS1Uh5JCvrxSO+ly9ix2YH/tzZukhIUxih/nNTGQET9IP97EE+srtas9dnaX
 5+vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807185; x=1780411985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuzpY6XgB0sl9R2wkZih4Zz2Dy5QZS8ND0a9lUvUZwQ=;
 b=MVc26bQDm4q0rXKyurX2HyLEwCa/yeFIYFAP8FDXcpKNJVdap7aaSRqLY8IbCru1Hr
 6w/0xdyspfjUqCP31c1AiZfIApCYO3b848HTT4l/CJVUWyJLt/Fw92ASFjxAG/mv2gWx
 BVwln6XFAaXjOtCm6oSIEiogfbM4DV1c3d7TkfzrnbRlXKjzDFR6ZvTG1PY8NqtLxumK
 KLomk7ltzjY1rcpNDNBI5Yjkf9lSdyrtEgsfih5yDk0IEPJoJLLwIbdsmqHVSVvEovWg
 aHbhP4Vri4n0jw3OjnbTn+DS5zU/fIiNCkO7jz1hVMAL+VbiJQ/E69aDqsRffMJU72lK
 2P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807185; x=1780411985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kuzpY6XgB0sl9R2wkZih4Zz2Dy5QZS8ND0a9lUvUZwQ=;
 b=iSRFlEjzyLVVtprJ3i6JLfZaR7ZIa1TrjR6HvalQUUW5w70grD49T5/ZV0yNIVVD54
 afcddSjpbuUuFHuiYpmCS+xEIKKCRCV+WV7mtNnO9LDiRzMArkPTVlhnyNNk8IIXWARB
 7y15fdx4DhzPRvZ5FFln4D+6IEvEOb6Fd6I4PEAYfryVmaRPSWFMnuSYsNLWteUB3Jza
 zHmvFcViZuhy3QxxDj0V84LrWG8R9YD0ZDqGP9vbjiDjzAb5diPX+jfyVADZPJlANQpy
 9b9NTXh+ak6ybNgtCiaue3YRYxBTQIe99oDXY9cUlf0QaSX0jO9Dr3EeMkjq8RmB3K8c
 rUmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7Zdzpoux9bAzNK5gtqxQZGo7sgNaCVUY/yE12yNaFZl1O2rVRD/ubeCTp5SZzGYh9Z41omhx/g50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVGH/mG3R/Kg5ui9ZIobiGIalIsYjPy2J9FSn6/C8r8AnBtGeF
 e0lnVsrE1Q929L/y2431MqutfIsecUzAtFmHcmKk3j2icovwXrq0Nqlhs+jHwkGJQ3W8Ljrrw2W
 FaIlvIXtmc10lVQ+M1ozBLclDMyFaMY4=
X-Gm-Gg: Acq92OH1EtGK0hnRkxDKQpxGdbhX/RqcjnHX0vLB/vkzfn/dxvwfinMwilLziQR0ENz
 MY2Xx3HG2nHRs1I+iEZHWYoEMYRg16VBBvTtz08sdJ5RiLFpnG8hjmsvXQ7phfSnQYWTgSh9J4l
 08t01nyGYVeh85md1YomIgaGwXXwGXub2oqZGfgAF0mZ++kFJU9XLyfypaICIrMDrDIrCf4ibQg
 Xa/7+sQTlCVjBdUHk7hY6ssZ5i8MV0zE9nA1V/FtGoZmTGoReV015NW1KWADSXTeWMKBiHAE/cg
 xNdDGo0/yORm0l6GR0/yp9aSkqrE0cY7YcODSs00kSxkcJoYFFXTR1sYPNaQqfFmw1O11z7ILHA
 58yMB
X-Received: by 2002:a05:7022:626:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1365fa3ef8bmr3010059c88.3.1779807184983; Tue, 26 May 2026
 07:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260519030624.51613-1-leorize+oss@disroot.org>
 <20260519030624.51613-2-leorize+oss@disroot.org>
In-Reply-To: <20260519030624.51613-2-leorize+oss@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:52:53 -0400
X-Gm-Features: AVHnY4LcPsiYYQmh-1BOJDsIdKpDtx2NbLr3E_yI9k27EGP0u5MvvjHIjHnWQ-Q
Message-ID: <CADnq5_MrUaLRP70hwb5YGawjfft9qUaH4h_t4TQ17AEgAwj3ww@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: set MSA MISC1 bit 6 when using VSC
 SDP for DCE 11.x
To: Leorize <leorize+oss@disroot.org>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

@Leo (Sunpeng) Li
, @Wentland, Harry

Can you take a look at this?

On Tue, May 19, 2026 at 3:19=E2=80=AFAM Leorize <leorize+oss@disroot.org> w=
rote:
>
> When BT.2020 colorimetry is selected, the driver sends information using
> VSC SDP but does not set "ignore MSA colorimetry" bit on older GPUs with
> DCE-based IPs. This causes certain sinks to prefer colorimetry
> information in DP MSA, resulting in terrible color rendering ("dull"
> colors) when HDR is enabled.
>
> This commit wires up the MISC1 bit 6 for GPUs with DCE 11.x based IPs to
> correctly configure sinks to ignore colorimetry information in MSA,
> resolving the color rendering issue.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4849
> Assisted-by: oh-my-pi:GPT-5.5
> Signed-off-by: Leorize <leorize+oss@disroot.org>
> ---
>  .../drm/amd/display/dc/dce/dce_stream_encoder.c   | 15 ++++++++++++++-
>  .../drm/amd/display/dc/dce/dce_stream_encoder.h   |  3 ++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> index ed407e779c12..2c3a20d35fe9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> @@ -271,7 +271,6 @@ static void dce110_stream_encoder_dp_set_stream_attri=
bute(
>         bool use_vsc_sdp_for_colorimetry,
>         uint32_t enable_sdp_splitting)
>  {
> -       (void)use_vsc_sdp_for_colorimetry;
>         (void)enable_sdp_splitting;
>         uint32_t h_active_start;
>         uint32_t v_active_start;
> @@ -334,6 +333,16 @@ static void dce110_stream_encoder_dp_set_stream_attr=
ibute(
>         if (REG(DP_MSA_MISC))
>                 misc1 =3D REG_READ(DP_MSA_MISC);
>
> +       /* For YCbCr420 and BT2020 Colorimetry Formats, VSC SDP shall be =
used.
> +        * When MISC1, bit 6, is Set to 1, a Source device uses a VSC SDP=
 to indicate the
> +        * Pixel Encoding/Colorimetry Format and that a Sink device shall=
 ignore MISC1, bit 7,
> +        * and MISC0, bits 7:1 (MISC1, bit 7, and MISC0, bits 7:1, become=
 "don't care").
> +        */
> +       if (use_vsc_sdp_for_colorimetry)
> +               misc1 =3D misc1 | 0x40;
> +       else
> +               misc1 =3D misc1 & ~0x40;
> +
>         /* set color depth */
>
>         switch (hw_crtc_timing.display_color_depth) {
> @@ -499,6 +508,10 @@ static void dce110_stream_encoder_dp_set_stream_attr=
ibute(
>                                 hw_crtc_timing.h_addressable + hw_crtc_ti=
ming.h_border_right,
>                                 DP_MSA_VHEIGHT, hw_crtc_timing.v_border_t=
op +
>                                 hw_crtc_timing.v_addressable + hw_crtc_ti=
ming.v_border_bottom);
> +       } else {
> +               /* DCE-only path */
> +               if (REG(DP_MSA_MISC))
> +                       REG_WRITE(DP_MSA_MISC, misc1);   /* MSA_MISC1 */
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> index 342c0afe6a94..88d6044904d1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> @@ -96,7 +96,8 @@
>
>  #define SE_COMMON_REG_LIST(id)\
>         SE_COMMON_REG_LIST_DCE_BASE(id), \
> -       SRI(AFMT_CNTL, DIG, id)
> +       SRI(AFMT_CNTL, DIG, id), \
> +       SRI(DP_MSA_MISC, DP, id)
>
>  #define SE_DCN_REG_LIST(id)\
>         SE_COMMON_REG_LIST_BASE(id),\
> --
> 2.54.0
>
