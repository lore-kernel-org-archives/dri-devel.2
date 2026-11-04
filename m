Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E6606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fv/hCEUR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC76010E1E2;
	Wed,  4 Nov 2026 23:52:13 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F1510E1E2
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:52:07 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c423b145922so185122566b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 15:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793836326; x=1794441126;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZDPMlWjER97QQloMvS3JLpRs94OY8/a/t6TOJ2vu8Gs=;
 b=fv/hCEURzMe2z0Wu86T/gOhnCzlobXemcbYAWHnMJ/xbenow5t4lo5gYpSaQunkiNX
 fV5wEQkNB3YIDtxhzLOE6blfbtBgpWvJ5tHZ1Q3UP8kDi/VLSusW9Xmc7XKgQ6RD6hyS
 ossXfRtegtHAdezmHq70p0IYmqyoebfCT8kzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793836326; x=1794441126;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDPMlWjER97QQloMvS3JLpRs94OY8/a/t6TOJ2vu8Gs=;
 b=MYD1/UNNRgRxYn6q2DZHZb1o1/lKsI7o8DWMOlQn0GcpKK1EaRL8gFj6NW7yp+qgcB
 LmurPWALJjov5NGVC7PcfTmx438OeuKXetnRlmJpNkF4fsqupt1KvZVYawGBy7WK9NR1
 9mW8oypW+MF8YU+2Jg6wGQGj4ixjEoQ8KlpOOPzxJLSzNvdpiiYY3BFYETL8jtmEo1D/
 EhGQTagL+T+p/jleWgNagNPQINdjF1pfFBg4HS/+I8MGLFQyg+3wTl/7P+T9XB2LdKvz
 sRBdARq3C/+x2AKZBxqOZI1UnV0p++Iaq/Mennkzx8kdg4uvC6TilKQMDJ+hRMSs72Su
 W3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvByKQAZNKChUG7/AjXpKFuwxwHUTf5ZR8MVxSTFBXGzBe39Gz4kxL05+EAYiFptFh9osw2kopQ5q62U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Qq8/3E5GDrYD1mR341YvVW5ay1eeexGEhgqTHjFzUJVa2tdmk
 orEgAAxhekRlqrY5NWj6ZTO8+A9U5bz859yxIYnHQ9AapT6hXsWw4jAfNX9VHMZ/WEPV8WdbJNK
 Zb6OrDGuj
X-Gm-Gg: AYBFou25T54Uk/6MYA8ehUekv+s4eGo8iUPG9wERaARSrD81gXAOQ9bQqzN5TVz1vQX
 fcS9Lew+P1tGFMQfJWW0cA7JA81vE3TTQtSj3ECH02h02Ein9tR4vEVQY9EnCAwZJcRst8Q2oM5
 Q9MrP38ltQQ/RtErm9Q0efIBnd4EAm0SbEBiOV60jUFFeXh4RN/bRoc3pas/PSj8W/hp6Jwzizq
 Y08J7d81REYVk6pR8VLTb3ZO2IKObzRHl/mp0CCklmMB4ISDXFj8LQgJ2hp8vO/CE0COZWxBVVe
 YWUV8i/HWux6x1nl8X6eiB3stIhUEsZK7YzbYapJntGKzMujSlBa5dK2bLsqvqErwPZAZhNavYA
 uYMAzRLWPm6rYAhrJhP9EyKPDxhdqY775vSfBPt28s9JGtUtENiWs10Bi33vVbyJPMFQtj5P1mW
 +Ni8HjZ7cyWolF+Azh1JKqBk/WGO8nq4oBq+s0GEWt2Erhl/Z3pF4OW8QPg3xCzoiqiMWSamsaJ
 rY3v/hVusYSsG+g1fhRo3IJS2//Dr9W0Ue/d+IryslwO2H3un7YvXDGpL/utveDtrSA8jVmPjfs
 C9YjbJjjm9cSwht6KhrytZcg4JscoisOGgetOZEia0vhUMZEhqKdoe1aXdRIShpw+cA=
X-Received: by 2002:a17:907:9615:b0:c41:e75e:5889 with SMTP id
 a640c23a62f3a-c4ca7ab6062mr1640374666b.33.1793836326179; 
 Wed, 04 Nov 2026 15:52:06 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e140f93sm117344566b.6.2026.11.04.15.52.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 15:52:05 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso171165f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 15:52:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBzwirU5a4qbYQQMqJQQsGpUTVIhVd+0EdoM6a9x2orSaJPJ24UYWH7CKS7hYrb047d+uvtfg0C++QE=@lists.freedesktop.org
X-Received: by 2002:a05:6000:1603:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-48e6e262c42mr27271389f8f.0.1793836324117; Wed, 04 Nov 2026
 15:52:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Nov 2026 15:51:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=USBt_pE--C0P1=PZt+iaoTpgNebZ+DXP=dKb-8VUcoVQ@mail.gmail.com>
X-Gm-Features: AclHuK-CEolTZr0relxi0kTBUfKlXKIQK4RtBZ_FLD2bdc50G61iDALtJZq5MD8
Message-ID: <CAD=FV=USBt_pE--C0P1=PZt+iaoTpgNebZ+DXP=dKb-8VUcoVQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/panel: Convert four panel drivers to
 mipi_dsi_*_multi()
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 12, 2026 at 9:35=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> This series converts deprecated mipi_dsi_dcs_*() calls to their
> _multi() equivalents in four panel drivers: leadtek-ltk500hd1829,
> kingdisplay-kd097d04, innolux-p079zca, and newvision-nv3051d. The
> first two drivers also convert mipi_dsi_generic_write().
>
> In patches 2-4, unprepare() previously returned early when
> enter_sleep_mode() failed, skipping GPIO and regulator teardown.
> Because drm_panel_unprepare() leaves panel->prepared set when the
> callback returns an error, the panel could not be prepared again.
> These patches remove the early return, so GPIO and regulator
> teardown always runs, and have unprepare() always return 0, so
> drm_panel_unprepare() clears panel->prepared. Patches 2 and 3
> likewise stop returning regulator disable errors from unprepare().
>
> In patches 1, 3, and 4, the original code treated a set_display_off()
> failure as non-fatal and still attempted enter_sleep_mode(). These
> patches clear accum_err after set_display_off_multi() to keep that
> behaviour.
>
> All four patches are compile tested only. checkpatch and a W=3D1 build
> are clean. Tested-by tags would be very welcome.
>
> While converting nv3051d, I noticed that panel_nv3051d_init_sequence()
> always returns 0, so init sequence errors never reach prepare(). This
> series leaves that unchanged, and I plan to send a separate fix.
>
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Akash Sukhavasi (4):
>       drm/panel: leadtek-ltk500hd1829: Use mipi_dsi_*_multi()
>       drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi(); fix minor =
bugs
>       drm/panel: innolux-p079zca: Use mipi_dsi_*_multi(); fix minor bugs
>       drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi(); fix minor bug=
s
>
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c      | 43 +++++++---------=
--
>  drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 53 ++++++++--------=
------
>  drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c | 40 ++++++----------
>  drivers/gpu/drm/panel/panel-newvision-nv3051d.c    | 36 ++++++---------
>  4 files changed, 61 insertions(+), 111 deletions(-)

Pushed all 4 to drm-misc-next:

[1/4] drm/panel: leadtek-ltk500hd1829: Use mipi_dsi_*_multi()
      commit: d8b25f5f482250ecb4afc48913cb34de4938234c
[2/4] drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi(); fix minor bu=
gs
      commit: 7877fc6d086f861e0006dc5f008217899d7af3e3
[3/4] drm/panel: innolux-p079zca: Use mipi_dsi_*_multi(); fix minor bugs
      commit: a00bd7fb1dcdb3d2e33d11242e38e317a4111828
[4/4] drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi(); fix minor bugs
      commit: 3944ca3e6b7d25e545e8ef6498f69941e8e0c8ae

There were followups suggested in several of the threads, but these
patches still improve the status quo.

-Doug
