Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3C606A332
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MiepeEfS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A211121D8;
	Thu, 29 Oct 2026 10:51:58 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42758112106
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:10:30 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-705cb6ceebaso1250055eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 02:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793265029; cv=none;
 d=google.com; s=arc-20260327;
 b=gChQ2slMiIHEdDU4/eVMnW4U1q9py4CDzRnTOPF/q/U3DADCrvDanD7MoFn/UUSDzJ
 A8LRHa6mFvIJsb2szWByl3qwP0hptNb9blspwQu9DYrYEpfFvrqKd3T1v8quVlZ1zDHH
 8eboY/9bIeS2WIHoCk2UrtL2fkVtUPIrj/tPx0kZFQ3c7Fnm5yLzLjS+bUnylMo1NyGL
 +URnYWCec4fFdCYuF5rnwHcn9s1pCZvn6UKPPraIMKdaOQAqytBLEqqb9Dfa0Pzcqvj6
 Scbv1YRTz4JLLopyO0vwNNivuuZ1DeqFo6l4Omk96l9HQNpPGqk3p5V4Tkm0Ypp8TO0+
 cZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=caAQWiNBFevbYkZD4cIAvcMK/yRV1Te8kfxrLtz0u0Y=;
 fh=ReiH5hCKckF5LBZhIerwYitImKP/7DXqVqGh6WAeP5k=;
 b=UNUwvkYb9iQ44J5VEQwP4lzXXM0Up9dihMuO9FSnjdlNRfZTQ2j4/ugTXf7Hj5mNrQ
 H/Yx/o9ilAHPTewJmy3bNU6XZD+2QSsMcEpfK3P3ivqNo9Kj9aJEmkpp/BmiI3ns3M9P
 oWEFEVngOhtLBtfzuyMHfVTVVHSHyliQ897AAukOzNS+t3IPmzlhQ3J7Y8MurpfNxgQH
 PA6Fjz7j4T7XFfWkNS9j3P8wVQhbUJdfbtrGWn5ygu7NLgzQ/E/ImQnTmbhuiLGeljZy
 N5nRjh8VWdKU3ll1FYkRR4CsdYvFahp7eeFVdyS73vxWvFZXTjqpymWuhaujcEkHQatc
 AXUQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793265029; x=1793869829; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=caAQWiNBFevbYkZD4cIAvcMK/yRV1Te8kfxrLtz0u0Y=;
 b=MiepeEfSnhStKh90hUtQGq/44wxG2fLPsb73pQJAdhp5NvYpM1y/kKpu/nsT5CqVD+
 8t+MD5oOSxhZaoCHn1Q2aL5oh0NNZMPUUcesLyTdRuSyVE60eoqM7uw5sGuN+PCxA4iG
 YcuhFZlDq2r9so99kvg+2qSu3tzBFYHC7HwfTC+HYbwoHgdmciVRKoZZuDPIx8Fn6VBE
 jeMghwOevlxssWujbXo2t2F005DtoB2q+y8v+oCey2hrt4JHtLMvtS5QUtekkRlnq2cE
 IXLXocQk6c3+2Mnjkd0ysBngBunCwSpvwrMncT5oTnBYb6b0fMzyOVUXiScLekjnpyhC
 0NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793265029; x=1793869829;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=caAQWiNBFevbYkZD4cIAvcMK/yRV1Te8kfxrLtz0u0Y=;
 b=xg/Tc+dLJ639v+hKcmvpc6uNve7JbFFII3VjkGXO/Z3DfGHPktWcmON3YlpshtqHgP
 7/4D03UgU3vq9o8WRelDHuBIXgOFffjgwjxy9bMSdBlRnz4tblzyYW+NznvxbEfFvFWb
 ATaZioU+ArzyYRzLfhjNQq5P0QUrPnYII76+JON4E/YmP4UezVdkpf4dEi8Y55oudVph
 aDsfKPI3yqzTRv37k2k+v75bR78jiAkI4DnEuCYFudjb3i+UJPQB04XOyFCIZs7Zv7iU
 6CeZNOo4p/bva8Z7UvmTXC7R24QC63u615rT3lehzrw5HSFAJ3WiTa6JoS0B0jWCWk0A
 xJdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylZtlXg3I7qlRp15bMjejNQtcuy22jFXr1oq9cMcfaSaKhFnrntObxUYaFH/U9s262iG/dd36a2rg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJgE4K4OFoiV4eGTEafZyhjM5S8zWc4LeOQ6YIwhbrBQOX3hkdL
 5267thiAAx7WoFNY1Xvb7rb0A85aZ+Rha093ygquYpdH/wfXqebRM7up3NXUsbbSekNvqfXbly+
 sqz8f3C4+/rlfr+Py1u4fa24mObOAlMA=
X-Gm-Gg: AYBFou0RAW++Q20WU9pn6QShBSah3su/cT3FEaEfKZtDJR2k1zqTGSIOsAHq8zakh+X
 EprEi3r2PJ6W6lxe5X4aGrsxYD8sbWis1oHEsh2kdMmMazArEH3AiFf6UUzQCPOwN/ARA/xwe2+
 TCdOlbtbhuhGMxiLK7pPaALqx2oOOxlhXUejf52HjIIdNET4Og80hf7EEZnVcsY4U7KVpGoiuZz
 j7+4Okhn3NbPBkOwOsNiLenkpI3RHhyGz68qj3CBKTvysq0Jjdh1rAVSVV5IA5ENi8c/CQEAN7S
 MN2vJrsTuRgRSqwdDMwle1wyRG4T8lBC0UdDA+AvmK7JbxxoFYhz8jAOTdBadrMzPobIR+5DzAn
 F6w88uUGU72ixzYUPYWWgx1x9Mlwz+QyUu0M=
X-Received: by 2002:a05:6820:1621:b0:702:5ff2:ba20 with SMTP id
 006d021491bc7-713efd0ce3amr2688820eaf.60.1793265029284; Thu, 29 Oct 2026
 02:10:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028162941.62762-1-dmitrymalovanyy@gmail.com>
 <77b574384ed695f8ea06a2ed142907e7d5f118d6@intel.com>
In-Reply-To: <77b574384ed695f8ea06a2ed142907e7d5f118d6@intel.com>
From: Dmitry Malovanyy <dmitrymalovanyy@gmail.com>
Date: Thu, 29 Oct 2026 10:10:18 +0100
X-Gm-Features: AclHuK-YKZMvoeI3CtZ25U_SjKR3_KVJy7xMS0FRnia5X4eD1IOJsW8DEIDfCPE
Message-ID: <CAKCCmHOLiSkBp0kTy128it5znRpQ4yS_MOohZOq38T0TF3RFmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Keep base enhanced framing cap from extended DPCD
 caps
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> Additionally, a DPRX with DPCD r1.2+ must indicate support for enhanced
> framing. The display is also in violation of the spec.
>
> That said, the spec kind of says to use enhanced framing for DPRX with
> DPCD r1.2+. It's subtle, but it doesn't say check the capability
> anymore, just the DPCD revision. That's my reading of DP v1.1a, v1.2a,
> v1.3, v1.4a and v2.1a anyway.

Thanks for the quick review!

Yes, I checked DP 1.2 and it is there in 2.2.1.1, "An upstream device
interoperating with a downstream device with DPCD Revision of 1.2 or
higher must enable Enhanced Framing Mode". So doing it in
drm_dp_enhanced_frame_cap() makes more sense, agree.

> I think drm_dp_enhanced_frame_cap() should probably be:
>
> static inline bool
> drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> {
>         return dpcd[DP_DPCD_REV] >= 0x12 || dpcd[DP_DPCD_REV] >= 0x11 &&
>                 (dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
> }
>
> And the remaining direct references to DP_ENHANCED_FRAME_CAP should be
> migrated to use drm_dp_enhanced_frame_cap().

Will do it in v2. I will add parens around the && part, otherwise gcc
complains with -Wparentheses.

For the direct users I found cdns-mhdp8546, it6505 and gma500, I will
convert them into separate patches.

There is also nouveau, dispnv50/disp.c checks the bit for the watermark
calculation, but the actual enable is in nvkm/engine/disp/dp.c with its
own definition. If I change only disp.c they will not agree with each
other. Should I convert both, or leave nouveau out for now?

drm_dp_get_phy_test_pattern() also uses DP_ENHANCED_FRAME_CAP but there
it is the DP_TEST_LANE_COUNT register, so I would leave it as is.

> One of the main reasons I don't like this is that we have the logging
> for the base and extended caps, and this sneaks in a change without it
> being present in the logs.

Makes sense, I didn't think about the logs.

Thanks,
Dmytro

On Wed, 28 Oct 2026 at 18:24, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 28 Oct 2026, Dmytro Malovanyi <dmitrymalovanyy@gmail.com> wrote:
> > Some sinks set DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT and advertise
> > DP_ENHANCED_FRAME_CAP in the base receiver caps, but clear it in the
> > extended receiver caps at 0x2200. drm_dp_read_extended_dpcd_caps()
> > replaces the base caps with the extended ones, so the link is trained
> > without enhanced framing.
> >
> > The Xiaomi Monitor A24i (P24FBA-RAGL) is one such sink:
> >
> >   base:     12 0a c4 01 01 00 01 80 02 00 06 00 00 00 81
> >   extended: 14 0a 44 00 01 00 01 80 02 02 06 00 00 00 81
> >
> > Without enhanced framing all lanes train (0x202-0x204: 77 77 81), but
> > the sink never syncs to the stream (SINK_STATUS 0x205: 00) and shows
> > "No signal" until it is power cycled. The same monitor works on macOS.
> >
> > DP 1.4 section 2.9.3.1, as quoted in the commit that added extended
> > caps support, says the extended caps match the base caps except for
> > DPCD_REV, MAX_LINK_RATE and DOWN_STREAM_PORT_PRESENT. Keep the base
> > value of DP_ENHANCED_FRAME_CAP.
>
> Thanks for the patch and explanation, refreshing clarity.
>
> The display is obviously being silly.
>
> Additionally, a DPRX with DPCD r1.2+ must indicate support for enhanced
> framing. The display is also in violation of the spec.
>
> That said, the spec kind of says to use enhanced framing for DPRX with
> DPCD r1.2+. It's subtle, but it doesn't say check the capability
> anymore, just the DPCD revision. That's my reading of DP v1.1a, v1.2a,
> v1.3, v1.4a and v2.1a anyway.
>
> So I guess that might be the more appropriate fix, really. Even if it's
> slightly more work.
>
> I think drm_dp_enhanced_frame_cap() should probably be:
>
> static inline bool
> drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> {
>         return dpcd[DP_DPCD_REV] >= 0x12 || dpcd[DP_DPCD_REV] >= 0x11 &&
>                 (dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
> }
>
> And the remaining direct references to DP_ENHANCED_FRAME_CAP should be
> migrated to use drm_dp_enhanced_frame_cap().
>
> > With this change the link uses enhanced framing (0x101: 84) and the
> > sink syncs (0x205: 03).
> >
> > Tested on i915 (Arrow Lake-U) through a USB4 dock.
> >
> > Fixes: a1d926527b79 ("drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT")
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17719
> > Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> > index e623ccb4c..205b6cc89 100644
> > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > @@ -1219,6 +1219,9 @@ static int drm_dp_read_extended_dpcd_caps(struct drm_dp_aux *aux,
> >
> >       drm_dbg_kms(aux->drm_dev, "%s: Base DPCD: %*ph\n", aux->name, DP_RECEIVER_CAP_SIZE, dpcd);
> >
> > +     /* Keep the base enhanced framing cap if the extended caps drop it */
> > +     dpcd_ext[DP_MAX_LANE_COUNT] |= dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP;
>
> One of the main reasons I don't like this is that we have the logging
> for the base and extended caps, and this sneaks in a change without it
> being present in the logs.
>
> And having the decision in drm_dp_enhanced_frame_cap() is explicit and
> same for everyone.
>
> BR,
> Jani.
>
> > +
> >       memcpy(dpcd, dpcd_ext, sizeof(dpcd_ext));
> >
> >       return 0;
> >
> > base-commit: feaa32dc98090b2f45f7b6f179711a6640169c1a
>
> --
> Jani Nikula, Intel
