Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F39606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MKf+q+w/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B133710E1ED;
	Mon,  2 Nov 2026 22:38:33 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB7E10F277
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:38:27 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso537320066b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793659106; x=1794263906;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n2if1RTPZbo5SFsEjRB4Jy0O0oymGB/SO+FAdZRGXuk=;
 b=MKf+q+w/p8YedhQIC1qU05qlaLoDaiINhSbxG5BsOYrINbs36GXhRLCHs6OqqJ/OE0
 JTconhQb7f6K9BFergpWkTfgqjx2LDpQDsOrfKVV+/EmurfEM/M2H9gMy8drIMOReabc
 Zi9Bk4VCnqhE0BY7ZIo/fn4VJr8ZqOJXjIK4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793659106; x=1794263906;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n2if1RTPZbo5SFsEjRB4Jy0O0oymGB/SO+FAdZRGXuk=;
 b=LbW2LHSYhUX9DG9Zw/0LcdFWtHPqT9ftMhYcP7x2yj1NyWbtMZ6GF4HhamyJsMVZuz
 81SjlKPFbL3vKsVHGwlyOOGUKCyoCArsaxV/lAn+2ulNZduNXQ4nxFLVSqKe3U7nSuaY
 UiaxIhMEnfWTJs1RQyTHmxxx5pHy27Qf4JqavfCD9FADJkTWvPCI4G3dCpA4p8p0kHW3
 ht8qybO/HxpT4KziGvzxrJCvSzveDdZvLmxtgpbJcBFZdCi7OaUfR1mkYJnYHInRBaEK
 I4zIB2fpBGr1qSJg0kD6OBD7v2UzrYk+4re4aCRCNZ7N0MREy6TTHJhWH1yv8mVpCSF6
 tn3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnHa27HTr1nZV+X0GwgzuiW+4lQQbYR7ceUytZr0N+6WwEaifF7xTc4chy07m5nixj7HrBmks0mWg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vNEIfocIrRWOt4T4gz0UN7rwZpGwU0U07xK9cq7wW+XMR1QHe
 CU7lkzFlfhHd5FQaOO4r1qAYwqkBtwjDt4aAR9PJ6Pe93UF5WzqODWTjTomg19ZZOPveSOMXB7e
 cqGCSWA==
X-Gm-Gg: AYBFou2ZPsLiOGXOByeRpKKWdQVUrIo9qmwn9cO05mpMxt8PkTfRdSBzrsrwPN8LuwP
 ae97iTO8BA231HwSSnyQjoML0MaBmbwIspfLv128shcdCyRh7/F+GNL0Qtvc6ShxTro+9OSUhcF
 D5halIn+S81DEUv39/rG5agZqDhL+RXH3C2DvtjGA+cMw6+yAGMbVKufPQX9oFyUeIqt9fk6j9G
 kU4C/+/gSLOLCTZjbunTFCIC6ecsQJd2ipL7BU5WJKHKy5if9+CARVo6K4eDfgoytMsVOIKmmtf
 fKnap0nPNEDOO8RqcoXZpNlAXA2zQetBOlM1mXFLcmvuktjKSZZLIjuzTi8pk3ntXGfFhy520tF
 Fx/kl/igPeKLA1u+6uUCcqwN3irlckJHNpT4KqechaNOkuh0Ylbj11Zu6AR6pAmdZaB/eaE9EY+
 Z8Tq/1wWEn2oZyzBXx70ax4blKsTIi9dOGK9UHcL2SVSRIzNuc/mK38Ys8K8mTLZEvGY2vm2YRz
 WlrpKfMnmuf6TK7wbBmnJKzBVPFQDP9oTTHVBVVJyYm9mmouK5yTax4r2DFtwrIV0uF2hmyFjRp
 EQT8g87ARFcsyBjCxgVT1it2SFTbYhzIdehwvChnf5eF3IpQp4NOLaJwT4ADDrZ2QdU=
X-Received: by 2002:a17:907:cbc6:b0:c49:4450:6248 with SMTP id
 a640c23a62f3a-c4ca7aefa1fmr912591166b.16.1793659106082; 
 Mon, 02 Nov 2026 14:38:26 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf009b8sm29462566b.42.2026.11.02.14.38.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 14:38:24 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2444935f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:38:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBy4axA3FyrSMRmue/AO9MYLB73yMf4SM/Fwjrzsted88I9jMCQhT0CSWWKi/j+XuwE2zOFgYSIZJb4=@lists.freedesktop.org
X-Received: by 2002:a05:6000:46c3:b0:48e:f47:273c with SMTP id
 ffacd0b85a97d-48e6e2bcd97mr17576125f8f.8.1793659103258; Mon, 02 Nov 2026
 14:38:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-sp11-bl-upstream-1-v2-1-efc84396adf1@gmail.com>
 <CAD=FV=U2sZaobJMHCimqB5Kw0fZ_-7=9tHAxT-KrSP8uQiY-vw@mail.gmail.com>
 <49e9a6d2-8665-4e78-ac17-da5a55abf065@linaro.org>
In-Reply-To: <49e9a6d2-8665-4e78-ac17-da5a55abf065@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 2 Nov 2026 14:38:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WiOkG2_4w8iarx40FOhmJOY_pRQOW+6jOW29nea6y-wg@mail.gmail.com>
X-Gm-Features: AclHuK9QTI8PVDWnzL2eO8ikSkqp3uUAySr3iNnFFlAceBchakK_x41BCxCieLM
Message-ID: <CAD=FV=WiOkG2_4w8iarx40FOhmJOY_pRQOW+6jOW29nea6y-wg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: disable the backlight at probe
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: jimmie.lin@gmail.com, Maxime Ripard <mripard@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dale Whinham <daleyo@gmail.com>, 
 linux-arm-msm@vger.kernel.org, aarch64-laptops@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Nov 2, 2026 at 5:15=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> On 10/30/26 02:40, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 26, 2026 at 6:14=E2=80=AFPM Haipeng Lin via B4 Relay
> > <devnull+jimmie.lin.gmail.com@kernel.org> wrote:
> >>
> >> From: Haipeng Lin <jimmie.lin@gmail.com>
> >>
> >> pwm-backlight can preserve the enabled state left by firmware to
> >> support a seamless display handoff. However, panel-edp does not suppor=
t
> >> such a handoff. When probing a generic eDP panel, it powers the panel
> >> on to read its EDID. If display pipeline binding takes longer than the
> >> runtime-PM autosuspend delay, the panel is then powered off while the
> >> backlight remains enabled.
>
> So we don't support handoff _now_ but we may certainly support it someday=
.

Yup, that's fair.


> >> On the Surface Pro 11 LCD (LGD0779), leaving BL_EN high across this
> >> power cycle appears to leave the backlight controller in an incorrect
> >> state: brightness is pinned near maximum with a greatly reduced
> >> dimming range. Subsequent brightness changes update the PWM duty, but
> >> do not restore it to normal. Cycling the backlight off and on at
> >> unchanged brightness restores the full range.
> >>
> >> The first drm_panel_enable() does not recover from this because
> >> pwm-backlight still considers itself enabled and leaves BL_EN high.
> >>
> >> Disable the backlight at probe, after acquiring it and before enabling
> >> runtime PM. This clears the firmware's enabled state so the DRM panel
> >> core turns the backlight on after panel power and video are ready at
> >> the first modeset.
> >>
> >> This also turns off the firmware display at probe on systems where it
> >> previously remained lit until the first modeset.
> >>
> >> Verified on the Surface Pro 11 LCD by delaying display pipeline bind
> >> past the autosuspend timeout. BL_EN now drops at probe, before panel
> >> runtime autosuspend, and brightness control works at the first modeset=
.
> >>
> >> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s pr=
obed by EDID")
> >> Link: https://github.com/dwhinham/archiso-aarch64-sp11/issues/41
> >> Suggested-by: Douglas Anderson <dianders@chromium.org>
> >> Assisted-by: LLM
> >> Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
> >> ---
> >> Can reproduce on an installed system on Surface Pro 11 LCD (X1P-64-100=
,
> >> LGD0779 LCD) by booting with modprobe.blacklist=3Dphy_qcom_qmp_combo t=
hen
> >> loading that module manually after ~20s. This delays DPU component bin=
d
> >> past the panel's runtime autosuspend timeout.
> >>
> >> A/B tested against the same v7.2 tree:
> >>
> >> - Unpatched: panel VDD off 3.5s..20.5s while BL_EN stays high.
> >> After the first modeset brightness is pinned near max brightness with
> >> a "collapsed" dimming range. sysfs brightness writes still reprogram
> >> the PMIC LPG. One bl_power off/on cycle at unchanged brightness
> >> restores the full range.
> >>
> >> - Patched v2: patch provides the same full brightness range on boot
> >> (stalled or not) as the v1 patch. BL_EN drops at panel-edp probe,
> >> ~1s before VDD cut, rises ~0.5s after panel power at the first modeset=
.
> >>
> >> Tracing and functional testing on the SP11 shows unchanged sequencing
> >> for fast boots (without artificial delay), DPMS off/on, and system
> >> suspend/resume.
> >>
> >> Panels with shared/always-on supplies and no panel enable GPIO
> >> may continue displaying the firmware framebuffer during the
> >> runtime suspend before first modeset. With this change panel-edp
> >> disables the backlight obtained through the backlight phandle at probe=
.
> >> The DRM panel core enables the backlight again at the first modeset.
> >> I have not tested this configuration.
> >>
> >> Testing on other panel-edp systems particularly with pwm-backlight,
> >> would be appreciated.
> >> ---
> >> Changes in v2:
> >> - Disables the backlight once at probe instead of
> >>    in panel_edp_suspend() following Doug Anderson's suggestion.
> >> - Only disable the backlight obtained through the backlight phandle.
> >>    The driver's AUX backlight setup is untouched.
> >> - Link to v1: https://lore.kernel.org/r/20261024-sp11-bl-upstream-1-v1=
-1-d39bfaf9afbc@gmail.com
> >> ---
> >>   drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel=
/panel-edp.c
> >> index 94bc54c3833a..d019f4165674 100644
> >> --- a/drivers/gpu/drm/panel/panel-edp.c
> >> +++ b/drivers/gpu/drm/panel/panel-edp.c
> >> @@ -21,6 +21,7 @@
> >>    * DEALINGS IN THE SOFTWARE.
> >>    */
> >>
> >> +#include <linux/backlight.h>
> >>   #include <linux/debugfs.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/gpio/consumer.h>
> >> @@ -918,6 +919,16 @@ static int panel_edp_probe(struct device *dev, co=
nst struct panel_desc *desc,
> >>          if (err)
> >>                  return err;
> >>
> >> +       /*
> >> +        * Backlight drivers may preserve the state left by firmware,
> >> +        * but panel-edp does not support seamless handoff.
> >> +        * Runtime PM may power off the panel before the first modeset=
,
> >> +        * leaving the backlight on.
> >> +        * Disable it here so the DRM panel core enables it in the cor=
rect
> >> +        * order at the first modeset.
> >> +        */
> >> +       backlight_disable(panel->base.backlight);
> >
> > While still feeling a little ugly, I can't think of anything better to
> > do in this case. Thus I'd say:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I'd prefer to get a second opinion from someone else in the DRM
> > community to make sure I'm not missing something, though. Neil,
> > Maxime, or Linus W maybe?
>
> I lack some knowledge, but when the display pipeline is probed
> who's in charge of disabling the backlight when suspending ?

I'm afraid I don't understand this question.


> Why don't we handle the backlight state in the PM ops ?

That was what Haipeng proposed in v1. ...but it felt wrong to me. The
core panel code is supposed to manage the backlight and it handles
this in most cases. The only problem needing a fix was at bootup.

-Doug
