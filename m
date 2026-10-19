Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FB606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GYXb1IoL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9655E10F2E9;
	Tue, 20 Oct 2026 07:36:27 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3CC10EA3D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:04:10 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-53ec2cc397aso1196374b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792407850; cv=none;
 d=google.com; s=arc-20260327;
 b=KEe60QCyTJ4RSVlM5QW+4fEo1daYAVmvYYeWgaFXV9JO4frKDp/dqVmMI6hw2wgfNs
 SY4lxcxyRU6UTvtEkfbvU90Bx1/uOChKmPs4gx13U3WOHKyoWc3iAyozpS/3/pG+gaC8
 0yit2fFVd5d++Eps/gFCp5pWhkLIef/V09JqBRCGD0QAZtlxxu0Dmi/FpOY0b/+SlS3J
 DL2RoZlOWkB6pcCZAJjZ4Tmrp5MwKis95KH5WfpVPJHEJWqGaZiPuTw/ZVBTGlOFtvNr
 KvFpT0epF9nCC5rHAf/cjlxbS65TfLUW+nyoRDLavYK8AgjLRgFuDzUvC/AeVce6WbG6
 z2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2RjmAJkJaRfKW8CM604T3xdOE/8FYHsXLHXgCKfQYGM=;
 fh=FiN0XQ6kFNIUjwtXmdLtleWGm2i/Ta/YiIuIckTWNSY=;
 b=W4KNeco4NWYq9EeULo2nU/DOrH5tFrp2XoCSZgvxbguhLGt/QDOPI5tTbSwxmnSk8F
 eFT9A/7+ZOEJNSTvI6ERVs37QS/z98QNZ8ms92iWZOQZkf3GNCa9uua69OJi/sJxFk/f
 7TN3v7s2CvwZsXyQthFUElLQiSUqXMCmwXo7bL/BOqvjiTRX5PgIg7Ldks20uwsoAG7d
 Kjv74W+MBsHqtA2Moa/qa6IC8fmiXX+O0Vl2S8L9SaUBPDk82TAQ0UNHUdUERsj1FF5+
 v51zlCbs1F1dPrZDLJXSLJnqGgl2O0JWs6hW4Mupi+2m0T2VmoMi24kEF4ZZqLyKa8eJ
 o4YA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792407850; x=1793012650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2RjmAJkJaRfKW8CM604T3xdOE/8FYHsXLHXgCKfQYGM=;
 b=GYXb1IoLlVASGqdbM168SG8nht6qafUj/TZK3DNe5SlBWXvQgWxen6sd5zAmXtC9P2
 hegWuooftETZeOyRD0+qqk+fDzxpv0yCLmBcU7x4g/Gn+k/CeTjKPjhHoT43BHfqi/tc
 nhM+79AgTpAbJ6XC2OJRkKEbISuTMzre6lyAmkVZ9bIv+5xO+r4l+s0oyKsyVuAcp3MJ
 qKHB69mL9yH+JMcPYURh4dANqb4FbQo4Ovg/tql7Nunl+ugpGEgBL5mCzy2JfZo68nG+
 2lCoFTAe02smDSQHCp+G6piC0rV1cLHZ/+PRlQobjG5tR1C8Vi7VG11YmfvACp77iNKu
 MqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407850; x=1793012650;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2RjmAJkJaRfKW8CM604T3xdOE/8FYHsXLHXgCKfQYGM=;
 b=MaPn8N5fcmJ0MoBDqm6ijbnal9gYzCg1A2vctJBWx50G3lF+UOtIqieJAZmetB6W2f
 spBZnFXkwL2xZxMJqZKgx3f+g23vbhO5zGX/5x+nYt/muwg+hJQjC73ZFknKses1ujj7
 0BwgkWrLYdgFfXzjfi2Q/xyPhGUlgMZyAiCjSfszIYm/akd7J5ZxX9QeUHyDGZfkKtl0
 R9ieahH1EEXyz8Kr5zM/PVKfCEuaSZbsFbGNhzXz0+Kgc55sZ2WMN7YPGfd3dUc0xoSh
 rM0HYuRy0A6otrFeY6zhwU9OxzacPezPMtfnmxulzHSm26Cz+uiCLbu9cNkFyeiZBvlb
 Se1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByu4ScTRAjmc81dzv5/GbXHPXetPzuaTz+BpolwViR2o17a/Dz3dzeyy/wc97OjqMKXcgAsg2E/31Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKk5tCbtZDZLBom/KpqIBJL2vvno5b03oiyx96dlCv/fLXoUefq
 V2I6g1HmitRhBNrWjJV4KsRiwRY2+R2piYMdAQGYKsaimbyew25yhfApO1g2iLOQWsJEUsAI6wR
 MXCK3PwdjC6kL5U6Q0PdeWTrrcM+xuDk=
X-Gm-Gg: AYBFou1o3gW5cuebnXze848EfXIwH6VFs4mrIxC9rRvl19pzjX+wU6vSM+czAYiECX6
 SjYlsb4wCR43/Q1iMInTrMx+4rT7K1A8FWAo2tO8V4Cf1GjQ4/qk9NHbhdJ9/iA6jfBmxM5qwMt
 FloYXWyuh+V8V7CYCGpHdgSv1cucGK741isomWFfh05U6/76ce9jsyq4fH9vbXAB5WwjcBFe3pC
 DzRM14XkU+GHe1skXICUAOxp5NthWj8HtFQMVakFYGIXXeuc9d/ZmQT3qEKdGCnrDygznJIgPmh
 4y1HqgHIp/CNb0pNfd6iWVBvHKn3DEn4psSRNn4pp5kArKlKrlDtxI7i3Fxq/UmUcP0npEh6oeQ
 lpprbFOXIFL2QFyDadN1IVIjqJY/MjBuwrnLVQ19a
X-Received: by 2002:a05:6808:3509:b0:53a:6769:c35b with SMTP id
 5614622812f47-53ccaf1f442mr5332468b6e.12.1792407849778; Mon, 19 Oct 2026
 04:04:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
 <atXp2NSPKZUPj8sq@ashevche-desk.local>
In-Reply-To: <atXp2NSPKZUPj8sq@ashevche-desk.local>
From: Michael Anderson <mwwa919@gmail.com>
Date: Mon, 19 Oct 2026 07:03:57 -0400
X-Gm-Features: AclHuK8biEMfZ_1GVer949iI38PfSha8JvD86j9Plx2_choI2YB3QRBY5aZp0yo
Message-ID: <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV MIPI
 sequences
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hans de Goede <hansg@kernel.org>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for looking at this. I'd like to make sure I understand before
doing a v2.

Here both users of pin 10 are i915 itself: intel_dsi_vbt_gpio_init()
takes it as the "backlight" enable GPIO (soc_panel_gpio_table,
PPS_BLC_SOC), and the VBT MIPI sequences on this tablet then toggle the
same pin as the panel reset (low in ASSERT_RESET, high-low-high in
DEASSERT_RESET). Do you mean describing pin 10 with a software-node
"reset-gpios" reference and having both paths go through
reset_control_*(), or something else?

One concern: the VBT drives explicit pulses on the pin, and shared reset
controls are refcounted, so a pulse from one path wouldn't reach the line
while the other holds it deasserted. Would an exclusive reset obtained
once by i915 and used by both paths work instead, or am I missing how
reset-gpio handles this?

Thanks,
Mike


On Mon, Oct 19, 2026 at 5:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrot=
e:
>
> > On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> > backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> > itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> > GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> > sequences also request their pin through gpiolib, so when a sequence
> > toggles one of these two pins the request fails and the toggle is
> > dropped:
> >
> >   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY=
)
> >
> > Before that commit the pad registers were written directly, so the
> > sequences could still drive the pins i915 owned.
> >
> > The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> > panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> > MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> > failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> > during takeover and stays black, even though the backlight PWM and both
> > enable GPIOs read back as on. The tablet only has a usable display
> > with nomodeset.
> >
> > When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> > corresponding descriptor, set it through that descriptor instead of
> > requesting the pin a second time.
>
> Ah, nice, this should be solved via using reset-gpio, which is exactly fi=
xed
> for the reset shared lines case.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Michael Anderson
