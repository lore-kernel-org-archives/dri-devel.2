Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257D606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PjtWr9eW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC5F10ECF0;
	Tue, 24 Nov 2026 01:54:02 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38C910F2C2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 01:53:55 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-91ebf4cd218so33016576d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795485235; cv=none;
 d=google.com; s=arc-20260327;
 b=hWHxWqcua+/V3NKHU418YMKjW8RqIPxlKxLSzLB/NIWVgIoz48q1SHUYgh3+SILqYs
 nCrA8BkJY1NFoeLQ6Jd1BC4xgR9RtSxReMSsDdCB5SnYNuEGNeM/5tsxvfkae+81VN/C
 2SsagwA+nEhuccLXtjB9btTQTQgpwCz4mTle/fmf03djXBm2lsMrqLaxYvk45AXXTlWm
 jC6D+XepqRBnEY+KLrTMI2FdnFzBXf0JAzDVR3M/rY3r5VOwHu0iXpEtGzKsS/sEmsdT
 /lE2S6Gpx3YAOLUb7ZurSbeJ8xY6OfYQTlGSRx3rGDaX3FlETPlEsAzzNGxy/k9iLvpC
 kqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cqXrnujEt5rPik7Z3L5BcXXRInlNZ0roSGhQAAJNBos=;
 fh=lri9+caRXqwABXAeZPfcXgrS9atRfftEe7IVwoujpkU=;
 b=TFy11GwaPcRH9qfXDfqy7ReZrQL1iMQA46e4/Usy0POBoT8vIFd+tubJdcB/wj9MOR
 br0S3E1wRanegJoxymafxkVVaCQocGamQvgiO5ZWlGvOU08EBHujCC0SMXQ9KEHLckN6
 ehdXSv4izQSAFSv2H/pZM3nIYPqI32eNxEsbzCsY/cn2SCqKKX0J5FmC2eZSjnFTVo+B
 gMZ8bS3pmO/KIyYoq0O6dpfheDutFI8rDbRikijrx4S/awDKfW4ndXwkyLoHMIe847Uq
 xjcF/ik5hrIGl4put81v8UZ+aU0UGdxvraWm348omVms5j5fcGxmuNJSwUWHtCYMIfkQ
 lQPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795485235; x=1796090035; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cqXrnujEt5rPik7Z3L5BcXXRInlNZ0roSGhQAAJNBos=;
 b=PjtWr9eWB0ttFaPALTbT55U0MMM2ewHbPJ8PjKWwQ0Mh1JMuhhphen8TKqfSeCWere
 dvdwgQLPBvWxE2GcX3YIsNR5L8P/Pr7cdCkCKCRSxoeAKKs0W7d4ZNbEuPPlNIZYDhvw
 mBOHFnl2mb6c16zT5ajMzBIi+XFUSEOhXVEkYrHEmX9WNNCASmve/R1IMHDyuyskzQvs
 OUEO9OqK1U+t0gOT2YFXJ7JahfcFmu9AyqtCq2kP7GefY3Bg2QFATuI7L7rc2DQs5o5x
 +iIztq1Qog4K3ZRe5KY90YfXjvhX6WzV29SPN1S9RyGsp52TnU/PheGFpQDmz5lsKZbj
 TsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795485235; x=1796090035;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cqXrnujEt5rPik7Z3L5BcXXRInlNZ0roSGhQAAJNBos=;
 b=fNyuaWFekx9XtyKI4W8FFKUyZ2uWUfEmNtSIenMkkihEYnJwYDc7ThILi7HHWTQqb9
 bpq6dTqhXVG3iU1aIMqSA/3u9+oZUMTCHL23XvjggpP2CeU2QFku/4xX3CVv3jCRSxyi
 u4G9+QrhXAB+bnqxuHhm3dnCy7i1cdj2SN7Qr/QRZpfmz9xIF49NmI1BmfiPR6c/acdH
 YVdCa61VXWd5hPuk2f9TU+KDQKC0FEGYREiWHFTnklpUAw7nuhu5seh78OM0oXQhL5T8
 ndyJh1LWkd01jBc7HIbQ85oZzTZeappJyEIFuqMdw+mvft4VWMm6pzTbvOYg489TDxRL
 7Akw==
X-Forwarded-Encrypted: i=1;
 AL+hErEBOrZ0ggGAxcikoOJV5STW5YQXXbf5h9i2mEi7WPGvudada5fvS765f6DAvAcqMcb6mK94jChdD7I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z826tjo+nm2HYkmqLRUYa1hst74rDTzTVrNn26ChLY4ZndfSN0i
 nCIWZCsQo/MVTqRXIapJxCqZqphdEuHyAhzPBo7LvrNR/KleCYVGo6awq8p//BD+aj8LM4uucEv
 60ghv6JsFWqWCtmAkK3Kdv+5M1Mi9HOs=
X-Gm-Gg: AZFdTZd/QB4GlwAIAcIxtKYpVVcYMxY2PF9u/U0OPNCbON6y+xnTpgXIoTpM7dwYJto
 lIscZLWUeXivVyRv8YXmSW1s464XK25BzmlPwtyknUcC0ATdHk+o7VRcQo+rNhJWfifaeMYplHr
 kMKVQOo71JJ3m2+L+Exa2GhVRSuElapF/KkfzUh44vtG3d7xh31GVWib0B8TaRUp9/2W+WVpHy3
 7SuZ93BbV8GGN/H6Iebd8c1J/rlaz+2Y8a1AnyrHD0zNp2fNrL/UziSnZshlutqX+yZ+jo1gtUG
 0YV7DLduWFQjriyPzpZDwFf8gqb+j+A0fbiqiu69/fJo8eKSNaVP73vLSkkyy31z0xjSYume4Rv
 Z9RJM2rfNkMnY6sdBzBr78uibseVivXLa40ur+ebITed+xor/aP9Ffm0I0QHJ1p9OfohxcEE/iT
 jrfwJFbz0N1vO6zu1C1tpgww==
X-Received: by 2002:a05:6214:496:b0:921:425e:ce17 with SMTP id
 6a1803df08f44-921425ece58mr177583616d6.53.1795485234693; Mon, 23 Nov 2026
 17:53:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-3-5e8c27aa8555@redhat.com>
 <DN2OVF03FAL6.2EKLEYINW79YO@kernel.org>
 <DN2QWVWVB2FP.2DL4ZSBMYRXEC@kernel.org>
In-Reply-To: <DN2QWVWVB2FP.2DL4ZSBMYRXEC@kernel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 24 Nov 2026 11:53:43 +1000
X-Gm-Features: Aa3M54oEI4QoCcO0MeXwp_iIffckWQaTxkpH1_V4RY3XhRFR0hSACFK4S3mzVE0
Message-ID: <CAPM=9tw4_Kn2+q0JTZ5Y6+m6PFORJSgq4qSrqtutwWJniusgvQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] nova-core: only bind to GPUs when explicitly
 requested
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>,
 airlied@redhat.com, 
 Alexandre Courbot <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, nova-gpu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 24 Nov 2026 at 02:54, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Mon Nov 23, 2026 at 4:18 PM CET, Danilo Krummrich wrote:
> > On Mon Nov 23, 2026 at 3:50 AM CET, Dave Airlie via B4 Relay wrote:
> >> @@ -30,3 +30,24 @@ config NOVA_CORE_SELFTESTS
> >>        logs its failure and lets the probe continue.
> >>
> >>        If unsure, say N.
> >> +
> >> +config NOVA_CORE_BIND_GSP
> >> +    bool "Make nova-core the default driver for GSP-capable GPUs"
> >> +    depends on NOVA_CORE
> >> +    default n
> >> +    help
> >> +      Make nova-core bind to all NVIDIA GPUs it supports by default.
> >> +
> >> +      By default nova-core does not bind to any GPU and leaves NVIDIA
> >> +      GPUs to other drivers, such as nouveau. Say Y here, or boot with
> >> +      nova-core.bind_gsp=1, to make nova-core claim NVIDIA GPUs
> >> +      instead.
> >> +
> >> +      nova-core is work in progress and may not be functional, so this
> >> +      is intended for nova developers and testers only. When enabled,
> >> +      nouveau must not bind to the same (GSP-capable) GPUs, i.e.
> >> +      CONFIG_DRM_NOUVEAU_BIND_GSP=N or nouveau.bind_gsp=0 is required.
> >> +      Otherwise both drivers compete for the same devices and
> >> +      whichever is loaded first wins.
> >
> > I think this is a bit unsatisfying, for the Kconfig at least it would be nice to
> > avoid the possibility of being able to configure
> >
> >       - NOVA_CORE_BIND_GSP=y && DRM_NOUVEAU_BIND_GSP=y
> >
> >       - NOVA_CORE_BIND_GSP=n && DRM_NOUVEAU_BIND_GSP=n
> >
> > since I wouldn't consider them valid combinations of Kconfig options.

While I like the idea, expressing this sort of thing in Kconfig seems
to never end well, I'd prefer to just keep them separate until we can
figure out scenarios where it's screwed up.

I'll think about it a bit more, but I'd rather not encode too much
complexity here for fear of one or two people screwing it up and not
reading dmesg.

Dave.
