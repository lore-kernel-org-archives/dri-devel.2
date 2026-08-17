Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FE9C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3713D88CE4;
	Mon, 17 Aug 2026 09:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aYu2ye9H";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2F988CE4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:06:42 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so29038895e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786957601; x=1787562401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3ngolhcvbMqLUeFoPbLYsoQGaTEjccLb93LdN0z4Iq0=;
 b=aYu2ye9HPKLwuQvwWBtHTMJOnfQ/AdWeYepUcbg5HSH3QDhPBhPtVgaAIT13qPH2ng
 Mvkhco+4LxO94lOQSpItk39XMT3vFXP2YyxFHhExf33K+pczZyo6psr3oYSkA8cy0XsH
 hT5UGCgsBAyRB62dwiVyZzs9GlB4W9wT5fxdTN+lL0a0ZecdGiKmGgP7pNNA5PtxvKpb
 AtaFyIugxLfyT8L+iNOAGz98RI4LltPbHhowZkupwV4Hf7NZgpXKDznnxTQo80v2WFBW
 o9F+1M+hHlkojWQNPwvZ7EeKS0GLlh1sdSeXF+5fcJm67B4KYjzJNYb0VphnCyNMgPf3
 H/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786957601; x=1787562401;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ngolhcvbMqLUeFoPbLYsoQGaTEjccLb93LdN0z4Iq0=;
 b=oToop5GMg0Fz2pWP7q+wP07Blj86wFZb6hAWcGruN1fcMgZM0a1MeobV4LQqvXEXyp
 0BXehmSpJSKBitGS998il4YmZ3sakS0CH1ZMP40dVLMGHfABzMmbvTwG63xTfNm/jo10
 7gB1ZYz875u4V+RJViEAKG3ICdaNvob3Tv1RCGW+/en9R4iQK61zqctZRscqEQ70Ou5U
 +d+Efkf29YE71hjVMzW+ifCLbk8kG5e6VOmlEoGVem1uY4cG08jS8qeXgC0W9RyENWeR
 bAqHMdje0IGI00JWEesf4dtCsigjUbU3ahvV+hfmTUJIXb5daTrEeQ7LVNGymoV0rdLf
 axFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQtuHcR1QS8KoyCNcPeRd5DnqrujCIrU9n2e5Cvpmh+A8Fml0dkMsGQMOFAEYlhARQK6PJFTQHAM8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkiXNQXyjKrQQAndfoAUKTBiM82ZcRvTBQijPGEc7WKs3SjmRp
 9MmMoIfOQTXwT3DELbKuyBcTt2XhE/n/adzJv6PWcP1nWIknlTxiKvd5oFGTM47sg7I=
X-Gm-Gg: AR+sD117MDKHUOe00UYdQ+3yTgPvaiy8Y2AVLMsw3hrUF8aHn2VcoUO8E02NnoQipQN
 GDORuTvuIrD+V6RtKDU+6/AmDK20wnipv0CJrBQpcpat46dHNp51oh8kfsRoP+Seu9X0oOFDKhX
 PbDm3aSzfKsXGsVFmGGZmllQqfn3l1iF1V6I28xFg++AQp8puNSy+LUcJnwJG5gHlVihis/M5HM
 hhRRffoWx44GXuZ8dApUolyAqGZs96b7dPPbrR/6gIXgNRz3+J4GLjO7SfdcU/XUSoJYvIAmlXn
 mbHsBt7+uLYjjOtFCKoJPPRivJ7yTP7bSDrd+zMwWBC5uNxUb5NE1rJTJTEAtPy30EbQ9moRlLS
 PNRzb63kf43DcG/7++4sXzl1QrkI0cGTYXbHMKQkvj6scgcKwRlEADBIb0nFoVKdjD+7drRMn4U
 rXji6rqchT81l5oIgwNNSUJQr8enC0+gP0d7n6tWncVTHYWnT8TsQJ+yZu6moq
X-Received: by 2002:a05:600c:820d:b0:499:7a36:88b with SMTP id
 5b1f17b1804b1-4998794402emr411655325e9.5.1786957601263; 
 Mon, 17 Aug 2026 02:06:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb872sm34734505e9.9.2026.08.17.02.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:06:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F3B55F86C;
 Mon, 17 Aug 2026 10:06:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Huang, Honglei" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  David Airlie <airlied@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 virtio-comment@lists.oasis-open.org,  dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,  Honglei Huang <honglei1.huang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>
Subject: Re: About new backend for GPU compute ROCm in qemu
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com> (Honglei Huang's
 message of "Mon, 17 Aug 2026 11:19:44 +0800")
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Mon, 17 Aug 2026 10:06:39 +0100
Message-ID: <87v799ru8w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

"Huang, Honglei" <honghuan@amd.com> writes:

> Hi Michael, Alex, Dmitry, Akihiko,
>
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
> over virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The
> ROCm side has
> been supportted by ROCm offical.
>
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.
>
> Beyond that, sharing the display path is increasingly painful:
>
>   - Compute hammers the queues more than graphics, so sharing
>     virtio gpu's single control queue with display/virgl causes contention
>     and display stutter.

Is this just due to iteration? From a layman's point of view I'm curious
as to what the queues are doing.

>   - Compute contexts need far more blob / shared memory than a display
>   one.

I guess weights and context are long lived blobs compared to rendering asse=
ts?

>   - Maybe needs a wider ROCm / compute stack, cause the render model
>     fits poorly:
>     rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
>     and ROCgdb (wave control, address watch, async exceptions an
>     out of band channel that must not block display).
>   - Events, faults and GPU reset/SMI are async and don't map onto fences.
>   - All of this is hard to extend cleanly inside a display capset.
>
> On the QEMU/host side, would something like this be OK? One step, two par=
ts:
>
>   - a dedicated headless virtio gpu instance for compute.

An oft-asked for VirtIO model is virtio-npu but I wonder if there is
enough commonality for a virtio-compute device with the same sort native
context type handling to deal with the those that want to have guests
targeting specific hardware rather than going through an abstraction
like Vulkan Computer or OpenGL CL.

>   - that instance served by a separate ROCm backend library loaded
>     in-process by QEMU.

Is this library a binary blob or open source? The last time I looked at
ROCm I had to give up as my AMD card was in an Aarch64 AVA machine.

> That reuses the existing pluggable backend model, a second virtio gpu + a
> backend library. It doesn't add dedicated queues for debug/profiling
> currently.
>
> Waiting for reply and  happy to share more detail. Thanks!
>
> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1=
568
>
> Regards,
> Honglei

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
