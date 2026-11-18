Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3A60A2625
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CRwiwoQT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6AF10E7C1;
	Wed, 18 Nov 2026 16:42:26 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377FB10E0DB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:42:21 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so1183266b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795020139; x=1795624939;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oxOuGc8f47gMHpuI4bZ1qBRpP63fNQyLbMXtHjN4yGY=;
 b=CRwiwoQTTONNgeiKydRO6E9Mf3vJE1n0EwzohOvMdRAnwT9I7myHBNWKevtk7bzNCB
 yGUUs7vIk0fLVHk9cUgJ6bMNt3Yp/q8Q9lXMKyBIV1WN1LBHsAsFlRtUieYhFgp1eLrV
 a4ILNgvmXwEeskaqCMgqkfBhRZH2a6ovIy5cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020139; x=1795624939;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oxOuGc8f47gMHpuI4bZ1qBRpP63fNQyLbMXtHjN4yGY=;
 b=dEXTsWhsooowiy7yt8bSMa1Au9I1ejOfhChbVvOtz4VzNdtasVJXGkzgLs+xmsQtms
 oSVkF9RdZ7fyxQ9cloe98K+9732kmyawJtm37dCV7iRsf/ZC17rzgpmSqU+elI1DGVEY
 +8SrgfA5Xf4jHDVaeEq+Puef5rTy1enPDwjEulX7EXzdCQzU6M9rA5yviY+Y+a6QVK+X
 z3NV4qEX08lkTudXqspdJcOrIBIm2I1pf/p7WQUZNIp/1OHLlZUkyeGBZZtGZQwA7RYx
 AUPUJPyzSPFcOY1xEPfQewLRnWWtybONuyMe1DpkVyPJFju+Cp3uw70vybEq3H1uITnT
 ItZw==
X-Forwarded-Encrypted: i=1;
 AL+hErHi1KMtqIOHrf/orGA+65ZBdUSipVKSRp+NOBwn3lHwmklXE8UnnQDvvXm2Vu+k8IbxP2vnsupTzfM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9G2BSvIPEWVxCOKO/wb9z/hhfEHDjnIwCHHlwoIRqyIuMambGD
 Gd9u+PJEqMI5AoirHuf5m8JihauSTlv5x9LhPMy46ew3YFReQWBCzuN321keXlJwLidSRMBx2/R
 tNpHNkF8t
X-Gm-Gg: AYBFou2vtMZslsw/gOpqkAju8dkrGewVut28dblOVxBEA3pvI70gTWt8QqFB4fCwI6n
 S+732tAnuSawwCoubYto7N+O3taezjlai7er4QYTSKm7ag/o+RwyOM5mxUsv9VvrsuxCG+yIZvH
 gE8VKqRN0PkHtfd6vrOSrrg6MMgTuYPjLj9zg8YQkH8yQc5XViEgXqCOIygVYlv29WW6RwOLMQa
 ftxopckaVkxIMFr+YWNa1f8JfVFE3k9cIUszFJuwv7VY4v1OrqayeyTeiNawbuFNgaWfILzlpxa
 ZM8ws07MvT8+203HfMOVQnTkq2ThoZhXSOWioTvsYjH35xESgfwwfN4PtCdXsP4Yx3qTd96ygz0
 DmtNZJKglvyJ0stTbRZzftein/KXxt14KXT39onSqlubWK8XFO1aGBEXLdlaVQRqqJiMxJXHMZ6
 UEjNMNjojVSHSXNtCUQYjulUlG7+NXIsMZXePYDouKMAgtnG4g01ux588pVh58TnumvYZVFUTcn
 h/BXzrl2JJG0Z/4t3u/GOpZt3wzWIZZz1kTDI009tOKLTvmPTM48uUFWfw/2U+arPI7WIFt0xsq
 7Q0XHB+UUes7YVLZHxaIu5LxZThMXJ3QJ6MoY+Bqsr2101uzXjYzVsQfzPL+S2bw86Qn
X-Received: by 2002:a17:907:7b85:b0:c50:8612:d441 with SMTP id
 a640c23a62f3a-c512620de8emr2957066b.21.1795020139556; 
 Wed, 18 Nov 2026 08:42:19 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com.
 [209.85.221.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5122e68675sm26307666b.0.2026.11.18.08.42.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:42:18 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso838356f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:42:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGHM1QLLQGf6+1CQYhJXI8mmIiybx/iu0X+C3+wJlTT6P/RGQLcBAGpoAfVDo/GiE6GeCFv9RcKI6g=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2286:b0:4a3:c963:c1c3 with SMTP id
 ffacd0b85a97d-4a8e557d595mr123263f8f.15.1795020136499; Wed, 18 Nov 2026
 08:42:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118150045.2414052-1-haoxiang_li2024@163.com>
In-Reply-To: <20261118150045.2414052-1-haoxiang_li2024@163.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 18 Nov 2026 08:42:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQQyw8_bhVi8Y0JbxXB8XP62ivBPUnfrgWGMcLo7qLtQ@mail.gmail.com>
X-Gm-Features: Aa3M54pB6COHcWFeP1e0tF6KVDem24lURpneNehSl_Twk7SaRLtLmSvQAajZ5BI
Message-ID: <CAD=FV=WQQyw8_bhVi8Y0JbxXB8XP62ivBPUnfrgWGMcLo7qLtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix DSI host node reference leak
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 luca.ceresoli@bootlin.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 sam@ravnborg.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, Nov 18, 2026 at 7:01=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> ti_sn_bridge_parse_dsi_host() acquires a reference to the remote DSI
> host node with of_graph_get_remote_node(). If ti_sn_attach_host()
> fails, the probe error path removes the bridge but does not release
> this reference.
>
> Call of_node_put() after removing the bridge in the probe error path.
>
> Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI =
device at probe")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll probably let this sit for a bit and then merge it in a week or
two. It doesn't seem urgent, so I'd plan to land it in drm-misc-next
instead of -fixes. If anyone else feels like landing it sooner, feel
free.


-Doug
