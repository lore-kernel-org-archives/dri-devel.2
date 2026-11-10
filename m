Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LImKCfbG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F9810E031;
	Tue, 10 Nov 2026 22:20:47 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78CD10E382
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 22:20:41 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso5587139a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794349240; cv=none;
 d=google.com; s=arc-20260327;
 b=flB7ARPFQBe/U/8Vf6lKVw9I1fVB2YA52FZa0Gndrih225X5eQzi5e1rchVnTJgexX
 sdQZk+c3qOpaOBZwbRmOzAo1VZ5bHSz+5R0dZm/3XBxyfLOkOrdTCfLwnHP8Trvu0yOH
 CQVGfqWmUpMKLKwYnWQdh6Fps70cJXRwpNeD7X7Yy2eMDjcT5NY2OotMi18oq5CvN4/8
 ffA31j1n6orDmdFajwbjXNrB2A+YVM2UCwNinxNH91Dp3rYWOyJ5iUFDg8EO0cA6ejGw
 qQvSIFJ6zRjn0QQGwRm7JgUjOO7su5Y4F/M14Dc2jUj8upK/VIARaJ2SyXlnbnwB1caY
 3OKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m99sVTP2KDQCUkIDg8pOb2kGKHgwxWRF675z9CkWM7I=;
 fh=/Gf4wAWTX3WuOD4H14ZaCpd7ApX7J4ROTH7/eviOvKU=;
 b=bd/O04/dioLNOqavQBoM0r5VF1+cO1vEOJG7dxnvhQbw7gkOTLEjV5XO/dD8bKwB8/
 z4wzjCPidRWxGPVNmFU3GApa9uC+fuKfQrba81ylv8+E7aX6vEdnVLQSbnfxYHKi83MA
 080EaOFb828eI37smJ9A7tqn0VOtI5tVJBBheU82BuyhoYIVXs5R8LKdb0amWZCX9gFM
 H3JxFr0Kd1QwYwVw2KVTpEjJC4gP05l/kfFYy2zZsDHG1kUXS5bfzR6xyaW3HW0WmIWx
 IELa+hmsfGWh588mRFsFmp6fYWH5//R8f3Iz8kJCJTiUPoak5hTZH9coUZx19j4klpnu
 DQRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794349240; x=1794954040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m99sVTP2KDQCUkIDg8pOb2kGKHgwxWRF675z9CkWM7I=;
 b=LImKCfbGmx+1FDeOMzEPrJOGjTdFIiXW4T8Z5MlBotn71iOBONrZf9sK/XjLaVNj/z
 rVZKRnFFc+WpOWMdgwddBMlllDTPKMbwWwmcxzIwTWhtQ8u46TPyI9BaFUZg3IrAZ9d2
 yvrbQpNeESO24wOgFY9S7IO23PaaNxAbO1ZDUBEy0QnfdQZPquaZngncJVvaoTSZxwFH
 0vK0SnlG0SpkgGdpCedd7M67t4mD3JC1HHV8X1B1FZnoxavmIJ5qcSaMGlnSwHy6jqNA
 ZOTZ+NI42qvfZ88JwqZmtgaK3+7JBMX6OmHgKMf3H8t/CdfJeH2bodKnb19GYih2Vdwb
 aJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794349240; x=1794954040;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m99sVTP2KDQCUkIDg8pOb2kGKHgwxWRF675z9CkWM7I=;
 b=BpiDP18t4djTQhrfKzo7tpJUFscJ03UnS/PpBi6fa/9t/vnj/XIq9VhGcd0V73P/mJ
 Ft6l3oDOKCOelqXsM1gMfSvDqQoFqVp/sX4K4tz6Sw+GozGzVqcE8G/ewovMV8sRVZxw
 96Z4HWPl/0InTKAvvkZs6Sd53WASCVXqGiJ94gpWjOWHi2LmmbZ5BNwmQo5zKXDCppWT
 KUqJIip+0I9oQsLrTz7RnBaEn59NRvNPx+pZvfHwcwqrItIhId3/fTpr+NVQ41DX2Dma
 yfEO0WhPVsgQtljdOiXI+cMSq7cFc4Y7ERW53YsQ9dMb0ncNt23Z7u4OEPjeUNJRYQql
 Jsrw==
X-Forwarded-Encrypted: i=1;
 AL+hErE+Ta+mMVxL2xeASw0cCGx5OLYEFP51SsqgXSRSk+ZHr4GtnZqX8e+2KBPnXaRVWKXotAT4GmVpn2o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8pRS/sN6HEV88100wejkgg30V3chT7wOfJCbIKpPUy6f9/xSRL
 b7YlkR2gnnI6wjRXJE4N8NU1LkBc1c+93PCdhdPm3JSjExkbFKNOMG+FiXulG9Hj3Pkp6oFHfT6
 UpnU+oi9qi0ybKdls2cC1XFAJ89CshgQ=
X-Gm-Gg: AYBFou3iaCnLVkQOU8VELT2XwGxopoDOsbIXJ2GUyH6iiCHGktmz/s0RcfUjmS5DLNe
 ILbFcNYj5XrhjEOUeAviXQTmN6cKphCPrFl0kt1SkNN9jNZjOzXX+78IGrto5UCIkV1Y7iDaZzy
 1ZlmgfsU2hWAd562G1cIb0vFTDypk4IeSsS1fxyF46CRsmsMC2jVWJg3g1+ySd3iAlwxxWF3vM/
 Eg9+oZMYWCtOvZCgUo6AduJ82WuBSoLzueqQYpvqyuGOzFPQs2/jYegYGcDoYfJwnUNwF7LOQTT
 vk5wv/szx75TW1A3+bygOoKUnHdb9ytrUdmZ5xPHzQMIf3ooA0THDjN4igUDSRuPl4MjruxUl8X
 DYU/5NpYXEPd9OnECy0IZ96e556ezK33+fBh+9OU1AV9jJHWR7CHyFXIGzzFfZvt13xLMkt7n
X-Received: by 2002:a05:6402:2279:b0:6b4:e433:ee16 with SMTP id
 4fb4d7f45d1cf-6b777832d28mr414278a12.43.1794349239980; Tue, 10 Nov 2026
 14:20:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
In-Reply-To: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
From: =?UTF-8?Q?Andrzej_Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Date: Tue, 10 Nov 2026 23:20:03 +0100
X-Gm-Features: AclHuK9T0jEWuuyeKcsaFJF8n0gaPG1UTvH-Fz13rz1eUpDPmmJS8CQsHVhEDC4
Message-ID: <CABwS-fbOhshTN1KQV81LNRmyZ9cOvJsHgyYnOQvosLUF87iAog@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: HDMI FRL training fixes for slow
 sinks
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, 
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please drop this series.

As Sashiko pointed out, patch 2 raises the LTS:3 timeout past the HDMI
T_FLT limit, which commits f38686268b0d and 007834be6760 tuned for
compliance. I'll send a v2 that keeps patch 1 as a general fix and
enables the rest only for the affected TV, through an EDID quirk.

Thanks,
Andrzej


wt., 10 lis 2026 o 14:15 Andrzej Pi=C4=85tyszek
<andrzej.piatyszek@gmail.com> napisa=C5=82(a):
>
> With FRL on by default since commit 5fd3b60d9b80 ("drm/amd/display:
> Enable HDMI FRL by default"), an RX 9070 XT mostly trains a Samsung
> QE65Q80T (2020) at 6 Gbps x 3, where 4K 120 Hz needs DSC. Windows on
> the same machine trains it at 10 Gbps x 4.
>
> The TV needs one TxFFE step at 10 Gbps x 4, but requested levels never
> reach the PHY; with patch 1, the driver programs them right away. The
> TV sometimes answers an LTP request only after up to 967 ms, while the
> driver waits only 220 ms in LTS:3; patch 2 raises the limit to 1 s.
> After waking up, the TV can stay silent at 10 Gbps x 4 for up to about
> four seconds, but link verification gives up on that rate after one
> attempt; with patch 3, verification tries the same rate again first, as
> the enable path does.
>
> Tested on 7.3 with an equivalent backport. Without the series, 4 of 6
> boots and TV wake-ups ended at 6 Gbps x 3. With patches 1 and 2, 16 of
> 20 reached 10 Gbps x 4, and the other 4 are the case patch 3 handles.
> With all three, all 63 boots and TV wake-ups over 12 days reached
> 10 Gbps x 4. In 13 of them the sink stayed silent at first during link
> verification and answered after one to three more attempts at the same
> rate. On amd-staging-drm-next the series is build-tested only.
>
> Andrzej Pi=C4=85tyszek (3):
>   drm/amd/display: Apply requested TxFFE level right away in FRL
>     training
>   drm/amd/display: Wait up to 1 s for slow sinks in FRL link training
>   drm/amd/display: Retry the same FRL rate after a sink timeout
>
>  .../display/dc/link/protocols/link_hdmi_frl.c | 56 +++++++++++--------
>  1 file changed, 33 insertions(+), 23 deletions(-)
>
>
> base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
> --
> 2.56.0
>
