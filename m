Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uny10jB2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385EC1120F7;
	Thu, 26 Nov 2026 08:09:23 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2677210E789
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:42:44 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-74ab99038afso3646179137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:42:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795603363; cv=none;
 d=google.com; s=arc-20260327;
 b=EsahN36q7oVCN+Y1Yks8ffGkCRgtjiE2acE2ZlFCQvRIUcilntmJog+hNjPX3W+dTL
 82FBC8I5bJo0ZMs9b6Rje4ofdZhn1WdwU2M6QhSrMLcXpG/QpVHBvTC7ujL2e8BeRwl2
 2JiCQJZ5vohB21wqFi4T1DcLDWcBPANdlcPHhEinUfchCjFjvUGYKi+YREvaFXNAS+OT
 5CIXLC0wCUEayfGAizi1/GE8mk1Ma7oun20aAwnX+u8R1BU3XL8gAJqGB91hOPLcLMEW
 /wfwCWySvKD9LbnE07Kzeb/ww+AdQKvy29Qsw+V7mrYB5ae0DH3IKbhNduLRPYlUgZGb
 9CHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/a/ZG6zKgHMqLc4mvHHEORZFp2S/0ZUiRBVyNDZzcWc=;
 fh=b+jxNvKkXZJIkkvFrwX8Sb/1oVFoPfa8VQjs6pxFw6k=;
 b=lDhMdcq8LnRVjX85sez0UK5Pv0uZi8744kfRXzM5+XjOMY+zj9a0C/A1pdoclaqr38
 ocMbYnoZNurgl0+As9/1IELen9J7IkXWqMLs07lQ2MvWllS1FQiKLw3cxyz2Cuk8+LAt
 f+hW65xhLBZsOWmu/1XcUN+rt2rs6LSRVOxLa4A9OzS4ox8GoqTYn2GyoSVPUtGkQAWG
 /IHS1/2VtQmae62dhQ3ChzstqYFZnEtVJ266WqsBXXzcjKmjQvagH6u608besAFSlaWU
 e0bn7DPI0D4SYhDgR1cR0436wWGILToi4C/qtXVQm4PmefrJVjP20mFCqjsZkXnA6LaK
 t79g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795603363; x=1796208163; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/a/ZG6zKgHMqLc4mvHHEORZFp2S/0ZUiRBVyNDZzcWc=;
 b=uny10jB2bY1AF5Tybujn5ks2dLs985AkE+NLqS8x83ldMGM3JPzhgpJLjJe/ujYAPb
 kby/Em0wXqnBPwBeTorIpjrFXgJ8anQNTeNH0dKeZ1J+fobZK+hlZLLNcaeKXfl4GcYn
 hJATT4k5RvPjQPkdUQcxbHKZXOcvSbfeiT9oMXgpCJo2SvN3kn/3GCDMfFEcZDj6HBPU
 5Xzsqtz8tbxxFE35q0pAkrEgXw+n6c3cKXyj7pVWCoOGxeevAIb3/Abgob5LhPXoWiRN
 POCDI8nD0ROZ0dAVFHJId6dhP0yEgdjycF49VBUiqvBgWAbXfWP1inqxb7nyAjsmzyt7
 gUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795603363; x=1796208163;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/a/ZG6zKgHMqLc4mvHHEORZFp2S/0ZUiRBVyNDZzcWc=;
 b=bSLECkUcqOCTUr5RrVJXXLVP5O95Ug7rN6fMIm/gLUhLH2jBVJGBhDQHjC5A52GC7f
 dg1YlTRHn7j3m0nhzhhceGBJ60RrC8dhzddlCN0hWKaHwBgVvw2otgluPnNAZ5n0i8dP
 bZKMLu+k/hoXvF845y43D9lVbtoJqWM8RnAL0RQOcOUOKxnffeaX7xFtPbarKYHJXjlb
 o5N7aefbr69U4YsmwICYmCtKThYk+vBlfxzEv3kcbwEyBWeNpQ+IX7u36O0YJG0xiiyd
 OU57CAwDzDqYVudltyhgzyNwVw+skrz5TOnzqSigraKxIWeogdXTzCS/pBAUPQ4EMnDS
 n6Sw==
X-Forwarded-Encrypted: i=1;
 AL+hErGmlq5Npd4ixOP25ymRNmwsXs4UvuSQrklM/JRmQfZt7VN7qwP3sVQ4nwwmuO/RKpQUwOF/x52XzD0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vzDw9lSbo0pmX3EsDfZdPzbvX/ZanOWr62dTl6AHnS/M6dIcv
 kVgBGMEgjs0lqiBIWr3dpTkcsDxLDat5jVSgj9IjIKTkA39STAMYRfV2ur+TFPHcR9OcyGOp9de
 wDV5DACSR0jMO47DfIVIEgSOoH+Y0DA==
X-Gm-Gg: AZFdTZfasqOKOQS/tcTHFhga4eOyCUiEVFXBsa0Ce0tVCBxdA5TaS84qUxIj6bdOoAY
 jO5G0fEyKYXxhTdBQodwk3vul+M2E1wQHu7fV1dYO9jqxSVIU7+E/vTPGdd27FzYMZHK6RPFYmH
 12yKTIjZPrxs8d79EDLXJPXt862aP1/qdgmBneONkb3cBLPuGTQjactMobSl/RYw4ek54rAwdjT
 UTttmCFE1xY/AOpmuZTWOG1e8TzTD9y6jlWwrZxJ6yJwR/PritD2c8KDIEduGoyHacjpa7B5o+m
 mXzyDAocQWbU6QYhIN1InOBFwJDWLBi0JSeK54//km9fade9f0W6QUdkr08T62i/hu7QvclNXd2
 FdtivlC/CZC0IqVjHZJNg8LpnCnTznqSgdYZWR25dAz1QFdbLObyH4fZlkjnUEfOfhxf9RQ==
X-Received: by 2002:a05:6102:3593:b0:7d2:cf82:1a5f with SMTP id
 ada2fe7eead31-7d7395d2150mr8740665137.24.1795603362685; Wed, 25 Nov 2026
 02:42:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121214105.32596-1-gianfranco.mariotti94@gmail.com>
 <6298b3d0-db8e-4342-9abd-4c104bac8e27@oldschoolsolutions.biz>
In-Reply-To: <6298b3d0-db8e-4342-9abd-4c104bac8e27@oldschoolsolutions.biz>
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Date: Wed, 25 Nov 2026 11:42:31 +0100
X-Gm-Features: Aa3M54roFIr0PhnlmT_bXjlKsY_WD56KJINpDz9vkucYv15wjRk7DGwl6xU0iag
Message-ID: <CAAX85RvitbgA09Qj+-LfhpKJ5p3HP-8QCDG5e4U69q_xrZ2V4A@mail.gmail.com>
Subject: Re: [PATCH 0/7] drm/msm/dp: fix DisplayPort hotplug, link training,
 and multi-lane PHY setup
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dale Whinham <daleyo@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jens,

Thank you for backporting and testing this on X1P42100 across both
the PS186 bridge and the LTTPR dock setup.

While doing additional DPMS/connector-off and branch-adapter hotplug
testing on QCS8275 (plus addressing automated review feedback on v1), I
actually hit the same post-link-disable HPD/IRQ_HPD pulse behavior from
an active DP-to-HDMI adapter and found a few edge cases in v1's HPD and
link-maintenance patches.

I am about to send v2 against msm-next with the following updates:
- Reordered the series so the self-contained fixes (1-5) come before the
  HPD state tracking (6/7) and IRQ_HPD dispatch (7/7) patches.
- Patch 2/7: also reset link_info->use_rate_set alongside rate.
- Patch 4/7: drop the redundant msm_dp_ctrl_configure_source_params()
  call (msm-next already calls msm_dp_ctrl_config_ctrl_streams() in
  msm_dp_ctrl_link_train(), avoiding unclocked pixel_base access when no
  stream is active) and guard SEND_VIDEO with stream_clks_on.
- Patch 6/7 (was 7/7): fix a runtime PM leak in msm_dp_bridge_detect(),
  track drm_dp_read_sink_count_cap() + prev_sink_count properly, keep
  the PHY initialized for AUX/IRQ_HPD across msm_dp_display_unprepare()
  while dp->plugged remains true (balanced across system sleep), re-read
  EDID on demand in msm_dp_display_get_modes() if edid_blob_ptr was
  cleared, serialize prepare_link()/unprepare() under plugged_lock, and
  keep empty branch dongles (-ENOTCONN) plugged.
- Patch 7/7 (was 5/7): skip sink requests in
  msm_dp_ctrl_handle_sink_request() when link_clks_on is false (which
  cleanly ignores those DP_LINK_STATUS_UPDATED pulses right after DPMS
  off), and emit drm_bridge_hpd_notify() on branch
  DS_PORT_STATUS_CHANGED transitions.

(Side note on that "No sink connected" debug message you noticed: the
if/else in msm_dp_bridge_get_modes() actually has an inverted debug log
and prints "No sink connected" whenever rc > 0 modes are returned.)

Since patches 2, 4, 6, and 7 changed non-trivially, I only carried your
Tested-by tag onto the unchanged patches (1/7, 3/7, and 5/7) in v2.

Best regards,
Gianfranco

Il giorno lun 23 nov 2026 alle ore 12:03 Jens Glathe
<jens.glathe@oldschoolsolutions.biz> ha scritto:
>
> On 11/21/26 22:40, Gianfranco Mariotti wrote:
>
> > On platforms with a native DisplayPort connector using direct HPD
> > interrupts, DisplayPort initializes on cold boot, but physical cable
> > unplug and re-plug cycles leave the display blank even though link
> > training and stream enable callbacks report success.
> >
> > This series fixes the underlying PHY lane setup, DPCD link-rate caching,
> > SST training-pattern handover, link maintenance BPC restoration, and
> > HPD / runtime-PM state tracking issues:
>
> Hi Gianfranco,
>
> thanks for this series. I backported it to 7.3.y [1] and tested it on a
> Lenovo IdeaCentre Mini 01Q8X10 (X1P42100) with 50 rounds of DPMS
> off/on, first HDMI only (Parade PS186 branch), then HDMI plus a second
> display behind a Lenovo USB-C dock (40B0, DP alt mode pin D, 2 lanes
> through two LTTPRs).
>
> Before, external displays behind the HDMI bridge regularly failed to
> retrain after DPMS wake on 7.2+. With the series, every wake trained
> once at HBR2, CR/EQ passed on both links, and video came up every
> round on both outputs. No "already disabled" or PHY power_count issues.
>
> Notes on the backport:
> - 2/7 is covered in 7.3 by the link_info memset from Anthony Ruhier's
>    172c1648222e ("drm/msm/dp: recompute the link capabilities on every
>    sink read"), so I dropped it.
> - 5/7: 7.3 already routes native IRQ_HPD via 216110888698 ("drm/msm/dp:
>    Handle IRQ HPD as a sink request"), so I only carried over the
>    pm_runtime_put() change there.
> - 7/7: 7.3 lacks 1bda647ce61b ("drm/msm/dp: move link-level teardown
>    from display_disable to display_unprepare"), so the teardown still
> lives in
>    msm_dp_display_disable(); I applied the dp->plugged gating there
>    instead of in unprepare.
>
> One observation: on DPMS off, the PS186 still raises an HPD IRQ about
> 100 ms after the link is disabled, which sends a hotplug uevent per
> connector, with get_modes reporting "No sink connected". It's harmless
> here, but some debouncing may be worth adding on top later.
>
> For the series, as tested on X1P42100:
>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz> #
> x1p42100-lenovo-ideacentre-mini
>
> [1]
> https://github.com/jglathe/linux_ms_dev_kit/tree/jg/ubuntu-qcom-x1e-7.3.y
>
> Best regards,
> Jens
>
