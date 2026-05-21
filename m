Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4CDCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186C810F364;
	Thu, 21 May 2026 15:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="MfD27lOh";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BC210F37A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:00:29 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ba0714574fso34151675ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779375629; cv=none;
 d=google.com; s=arc-20240605;
 b=XGEU5mv1dTTyWuXxZQ8XB7R+xLaJVUbknFR45yI3uy2Zg9uG1I3N5a6B3BzAwqYdJJ
 iGOvklpghOBw2KbGyFqsEVqau6R6oPpNrA/IrC9udmfYygNvKMchuCbRgVhwTE1tA3XN
 jv0N0CVAa/x4qXgg6k6sRCCR4WCqVnvKWuMw7xdJZ4Dk8BOUAL6EhtBYsaujCgBDLC6r
 2EcwvrkWFOpWZcf2GxR+734ExEXxoYtSrqoppYMmzLYfaAiLaazTIxzivqQZHPCBo3Lo
 FKqMpB20BR2JDv5TDFKR/26uWE4yxgOAEn7JZyPkQy/6jJaAI5PLKrHGVKG9yWcctJqK
 nwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oPh+y9TDKBc3xWjD/+iekTZlADxTReWs9UieOSNAqew=;
 fh=YhRrKwh40ONvNyJR3Eyv9P755oPH5f2a48WsHbBEF7I=;
 b=gZ1RcgRm8ojAUJoByR3LKFDzQiIztdoJ72xAjWXHNKwC4JSRe6vU1v9OE662K8pt5w
 3JZqJWBzSHejpIdLHxM0TTEMGlxh0oqh9KjRrIYmL3ZdusmathbeclKx1X5AZS8S+Ogk
 pgoeu6YQrnk3P+f2x44w5/5/ZsH90RKAGemBYlHLVg6B1Wzz86vLT0sSsqESA+k+JY2o
 SsV9xvaGfDor2/vp8ff8DNVHFuqhHblwrt2rkLGnzWDtQaKdrZCiPapRfGaekDTdLP/7
 ad4MuUquY66DGbXRKkZLM7LcJXy6Yg3k3RSvunjK+JzuRK6PrNQ5Kw2258jzX35e4/8e
 symQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779375629; x=1779980429;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oPh+y9TDKBc3xWjD/+iekTZlADxTReWs9UieOSNAqew=;
 b=MfD27lOh+qG6fYSJZoQtjx208spYbDZQX0wXS3id4myhgI/ECwB5AmnTTsPTsa+BwS
 BPYpBXnp7a7lNXRFC7YjBZWUtspt8/p8Dg2xG1dbWdzGJIFBWbFY/AK2HlcGgdBL2gav
 vERGDMEI27MzRatpPDSHcJWUXTAgowo2oVWzA3uosPsUhrwF0L+3KoeF9fXH2F7wj1Gr
 umKf1/F3TBeGREHvcz5+NOLIqMvsFhgYkcSAohRvxoLAYrtOeiDKxFrsSJ6dS0svXZlt
 kpkiSoppe86J0yI7g0BNGvbrnJuzjE9a1d4pdeUZ36KHttMSjplxzQYKGaaTOG07UWHU
 GkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375629; x=1779980429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPh+y9TDKBc3xWjD/+iekTZlADxTReWs9UieOSNAqew=;
 b=N9o/Sr72sXPdhTRL3QhEYCy2r85kzJRSOLA61N6NVVMfRhr4k6RtcY4o0V/KI9YJo2
 UaJGCT/xInrSSZWGNyuKG+Sizj1rE5yZemTQEuxbEDQ7+yx24w90f+vL6IYWtVhCOF9I
 Qf428Cd0gCJDMaut+XAA5N/dWP9bdITRnvCtX8iU8LBybE5j4yTHI6iBoqAH34y2ySjb
 bL02Goj3oQkt5XY6I2aEWoypPW6HiJCgbmMGQ0GyeKjL+ZbTTviCQNvOzFzgHJANyS2Q
 AQp/ge3B4QxysbGjoe4iYttPDiBPr8BEkOFiYGcWcUbLwQT/Ki946dOKG9pvtwdHIgmF
 aqsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wfFUAiz6BIeVTJuj1Er2ZD1x6LZqMSlYs/EBbTkjyu1Lcfque8IYyJFdAk/IijBYwSBjV6f+W0dU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCtAIIfU1q1qeWAcJEpt9d52BR1fK8P1x5SdE7uy/ZxHlT8ghl
 EshZQmvQTVFXA0juvjpBq+0y4hgGhAvIKeooSI7MX8MtmJ5hxFDKODIGG9csh9DVPTa1eEEHlc3
 P9AqCuaJhgSxg+R5aRh5qP9qzmhFCDuZRk0ULOw7m6w==
X-Gm-Gg: Acq92OHbKdJFx4J87VDGc/pshoUZeyDc8VpiGLCFND/+14WomWdj49fZSJOH4MxMDG7
 E5vs10GWHzNYOnVE6DymVfF0sJNYtn23/MU+4sUU2wtPpadCmhF8mOH3MqHPyVxP7DD8yaWecqI
 yTdU1L7E4Lcnrn+9CqW4qkFu8IfKZyLVc0nChMKzKZnSsskh57EE2+LjCN5u7tmlcI2zApxERt1
 lttPsicl58te1svYxqsvZVIobSC+JgKG5xKmEdYQYwVtKs5dLmwHaeFLfdJ31MHIyVRSre5hqkS
 vQDKUEDZILueyX72VyYqbOrUqFMSj+tHhb81GrY=
X-Received: by 2002:a17:903:94d:b0:2bc:dc18:35a2 with SMTP id
 d9443c01a7336-2bea308c6a3mr37419515ad.26.1779375629099; Thu, 21 May 2026
 08:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
 <20260422-hot-plug-passup-v9-2-aef804255986@collabora.com>
In-Reply-To: <20260422-hot-plug-passup-v9-2-aef804255986@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 16:00:17 +0100
X-Gm-Features: AVHnY4K4PUGNR4sBWYkVcCif49a2uC8a5uMYD45duYjouwqQ5pH5MswZ0edBvG0
Message-ID: <CAPj87rNHsa2TKMcSMHeq3M7ZfyZp0P_i3FtjxQp8Qk53UwXGLQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] drm: Send per-connector hotplug events
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
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

Hi,

On Wed, 22 Apr 2026 at 19:24, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> @@ -760,16 +760,12 @@ static void output_poll_execute(struct work_struct *work)
>         struct drm_connector *connector;
>         struct drm_connector_list_iter conn_iter;
>         enum drm_connector_status old_status;
> -       bool repoll = false, changed;
> +       bool repoll = false, changed = false;
>         u64 old_epoch_counter;
>
>         if (!dev->mode_config.poll_enabled)
>                 return;
>
> -       /* Pick up any changes detected by the probe functions. */
> -       changed = dev->mode_config.delayed_event;
> -       dev->mode_config.delayed_event = false;
> -
>         if (!drm_kms_helper_poll) {
>                 if (dev->mode_config.poll_running) {
>                         drm_kms_helper_disable_hpd(dev);
> @@ -844,8 +841,15 @@ static void output_poll_execute(struct work_struct *work)
>         mutex_unlock(&dev->mode_config.mutex);
>
>  out:
> +       /* Pick up any changes detected by the probe functions. */
> +       if (dev->mode_config.delayed_event) {

Not your doing, as it was just the same before, but doesn't this read
need to be protected by the mode_config mutex?

The series is very satisfying otherwise; both patches are:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
