Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53791C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673CC10E7E8;
	Mon, 17 Aug 2026 14:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="todHf1/6";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508C410E7E6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:24:56 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso16817365e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786976695; x=1787581495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
 b=todHf1/6Lee1pVfwV42+birTAzmjP2WpMb9LfMPG/lVHN7Tpyib5VlZ4hJhlMTdynL
 FJkgy1iAoDfDqPgctE3zSLVvN+shT/l99oJGv3l8YDrJrFEjxELxsoQ5aDUpSulHxBPZ
 mVkqYAXUHneUyXira212/9/1yfZVUdCYM1yXLL8E02EORp4sijrvTY4MXSGuvdfCWhHO
 ZNJOuVDTyPiLQH9CqmlOqdYRCCcStOV+2eshuRpo5RUVfEXPnQr/ItWRhRIuIwzq4rFk
 OHwuRGKndEBViAyhT+AFHCVvq1M2NyDj6det+a++qypHZsnLACs6FNQeZu+1BCDtlYis
 6urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976695; x=1787581495;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
 b=C3vRvLyt+KmJaXe3pKnNjBCubHxjnqZi2ZeP/UCKkD/Bc4mScLUJfw12/+foCcy6CL
 ceZ+darR83K/n9lrgEj2BPb3gap6vh5ItTH8VA474et3noOZ4kHq5tP7TExMmBTFfGZT
 sFwlnxPYrouUo5q1pbIipwcfoAaEcyYjcdb8AZ6ZsE0wQSNQIqTWGUJPgSptpytou4fS
 CW3NahA93OiyAq4JOspeSKvovUYgPp0+dkw1k7C7U03EBQHBF1mfcO7F5iirjZU9KYvb
 hlG9Rx26LRsnlOXzxaZulS9Av3vmnwaYKIUOwx5h71vaEZd/bFtuFy8Vs6nFHx4cwQHU
 9fRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNzsUFO+eSR+Mnn2Ns7a1S06uQGrJy/iFQFW81/zKb8kdLRnuixJahZEVsgeTzsAqU3iZYsCNPi1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYOm0pXve1XMGoWtim0YRcdaFw9aOwC53bh3rrwFSR8QCqgWN9
 EfjB5H1FsFeJRBouIcCsJBZZbb0YV7xWeYIVnGuYyYOgeBUScyw4XmE04yoz5SvJY3A=
X-Gm-Gg: AR+sD10pwNvhTrF90JXe0d3S1ugOAB/FfmmaNb/V13D373T6Je9Ribk/nBjhQrOzMB/
 cN+0S/am26z9e9Xh9ElcJTa5V4SjlreN7UswUhGowAerj1hgyqd0FSSvB2aagQ8anEfw4t/o2nP
 zOJ9WX/R7ipGJSje7LnYiAbIVlTCysPUAiHOpRQrwakxTGt/Clgv+n2TWYk6TiAKPUyDlXHkFwo
 uYy46Jmi3hcA5dhoE+FudVsow7QjgZHq0fdFQEhltFPeAQMq0Po/rkpEZcTVTCLKMRukgcIq3zp
 ZXe0DbeDqvzVfsyxF86WOj7mi0WahaZ+1JkMjFPmtF3OqPeAvHKPcTlEASH1KYXrmCvbWTqC9Df
 a4E0pJpLUKSLCP+f2jq7ysOcQLtshVcbNUA/qudC7v2SEHQ+Umuz4GXxz4ETUS/71i2f18gOv9n
 u2iNU31qJhegLBNKEQEtdrfrLecGm0wGmSJpm53Ii73l39SMjsLM3/x+0PhX2E
X-Received: by 2002:a05:600c:348b:b0:499:5282:f8d1 with SMTP id
 5b1f17b1804b1-4999fb76c29mr9022705e9.12.1786976694599; 
 Mon, 17 Aug 2026 07:24:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996183b89sm185398105e9.12.2026.08.17.07.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:24:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C3B05F86C;
 Mon, 17 Aug 2026 15:24:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Huang, Honglei" <honghuan@amd.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  qemu-devel@nongnu.org,
 virtio-comment@lists.oasis-open.org,  dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,  Honglei Huang <honglei1.huang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  David Airlie <airlied@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: About new backend for GPU compute ROCm in qemu
In-Reply-To: <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com> (Honglei Huang's
 message of "Mon, 17 Aug 2026 21:44:21 +0800")
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
 <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Mon, 17 Aug 2026 15:24:52 +0100
Message-ID: <87pkzgsu2z.fsf@draig.linaro.org>
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

> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>
>>> Hi Michael, Alex, Dmitry, Akihiko,
>> Hi Honglei,
>>=20
>>>
>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
>>> over virtio
>>> implementation to virglrenderer nine months ago (MR !1568 [1]). The
>>> ROCm side has
>>> been supportted by ROCm offical.
>>>
>>> Current implementation is a virtio gpu context type capset handled insi=
de
>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>> compute GPUs have no display engine at all.
<snip>
>>> =C2=A0=C2=A0 - that instance served by a separate ROCm backend library =
loaded
>>> =C2=A0=C2=A0=C2=A0=C2=A0 in-process by QEMU.
>> First, I think we need to establish why ROCm cannot or should not
>> remain
>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>> likely better placed to advise on that boundary. Once the protocol
>> requirements and performance measurements are clear, we can assess the
>> appropriate QEMU integration.
>
> venus is borned for GFX.
> virCL not merged.
>
> To be clear, I'm not saying virglrenderer can't host a ROCm native
> context it clearly can. My hesitation is more about fit and direction:
> virglrenderer has grown up around GL/graphics, and I haven't yet found
> compute oriented plumbing there to build on, while ROCm moves very
> fast and I need something I can keep current with low friction.

I'm unsure what the current development status of virglrenderer is but
it does see a continuing stream of merges. However the threading model
does make things tricky for QEMU when we are sharing lifetime of blobs
between QEMU proper and the virglrenderer thread. Perhaps there is a
better way to organise things?

Could we do the marshalling of VirtIO GPU commands into ROCm directly
inside QEMU rather than going through additional plumbing? Are the
sequences we need to handle more or less complex than your general gfx
rendering? How might this work with other frameworks?

>
> Regards,
> Honglei
>
>
>> [2]
>> https://developers.redhat.com/articles/2025/06/05/how-we-improved-
>> ai-inference-macos-podman-containers
>> [3] https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu-
>> opencl-driver
>> Regards,
>> Akihiko Odaki
>>=20
>>>
>>> That reuses the existing pluggable backend model, a second virtio gpu +=
 a
>>> backend library. It doesn't add dedicated queues for
>>> debug/profiling currently.
>>>
>>> Waiting for reply and=C2=A0 happy to share more detail. Thanks!
>>>
>>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>>> merge_requests/1568
>>>
>>> Regards,
>>> Honglei
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
