Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6224606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRH/He+r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBF110F037;
	Sat, 14 Nov 2026 16:25:10 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D5910E224
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:40:07 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so10912705e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794645606; x=1795250406; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DiDcxP5ac6YkeYjA21NF5sNzCAmKzyT92ze3FWnxVUo=;
 b=DRH/He+rNEoAzf6YVGkKaQVDNNQx685TmKH4GNf2Iap9Fd7MfZ20Qj8HS+l+q6wK6K
 qRrjiRdUCGNWQseDZRrGJoW9heGugBAAVjdPXd1bkCbqPXQdEzI5aBuSrLn4qQYsq7/f
 od6f7spUKJCjJNt+DtK1iXoOfNzLli0n2I/BgN7JYbfSiSbB9E7v7m06v8fx+KTfJu1w
 wiSGY8ZzuqCmRZhUKIYK9GVOzHC8D39xHfrcup4zXIYGq0taDt3qd1VHN+U3enzr7S1G
 bhQcgV6k+9Tsva7/c5z3uYlBr2O4WI4FUFBqiusiRSvfIxZSj5eHoxF8ohobW2TeuVB2
 W1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794645606; x=1795250406;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DiDcxP5ac6YkeYjA21NF5sNzCAmKzyT92ze3FWnxVUo=;
 b=HI2Knp1CszJF8m09l1AjF49el5OizEAZdWIhl+F0dGrthoKDNv/ID8643NUYvmd63N
 qizL1LGmrDvu7VpVC/1FkoqIxlWpsnQsCxfvXrV3eY2Rrb0kfry+XZwKJzK4f4WRsh4D
 ojljWrSgDVKlCdsUb9ZjGawlX30oHHOgInV9WaBVNA36XRaCnHcPN/g3f1OCpvFgbLpt
 6p3EVOgSdSaOph5VyZDGNDI+c4FBnvZZuqLlA39+k7OfOzKAwQKWcHYkMqv7Phs8Nywb
 PxTNpYIb3iZIr0nsoSL/wnF0OmTNTHy3dzrR5xlv8/LXxyvrlMEEnHoR8tyi1QbGzYos
 n2ug==
X-Forwarded-Encrypted: i=1;
 AL+hErFeXXhVrjkJ6lExtqdg8bNBo2j3KPZEZ59VHlRg0L2KwBdMPLe0jqAv5F9JeTElQsLhsFaPNhRQIO0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RSUd/b3QgR7Wqr8gjsi9PeOR/K7KC4XoCTKmmXDl9OXfBS5vt
 cjNXbyssL6uSw9hx6Wnxh+nceKZ3s2wenOWXIgoBDntu8Fhd1NkfLvmG
X-Gm-Gg: AYBFou3wRu1uXjyQfXpxtOYX3A9H3glp+6iLIijWFK7vpzzfEP8pjr2j2GufwEinBcH
 wjRQj3VsDLU02MzmZG0LyfZxb8aaPUuDZgc7achtYxQTKsG0LNbfSldExvWmebYoaNBZQElJWzw
 YU70iVmNj1ze05wsAfmtYDKMWl1feigf+Oz28eWU9LGY0XbZurQCl8Y8c/pqDpSMKkHzi3oDl31
 OLFM8nz1Sv8nuCxBRvESCuFP7LwnJSbLtpNE4o6Bvpz2eViv059KRsNxcu+V8W8Nad2sVbsPkxE
 nZwCsq2yobcUtSS3H5Uk7M8VFT+5umc+exwKezOzg18jvQL8CNY53+v2Q3uS2rFzrM5Mm6AfJZ5
 kfp//UccK/ZDp1cpx60Kn6BzpPrtiYmfb+wLicfqJqH1Rx/j1EAiinV23em/COZLerUifpJ2sJX
 nOfeGFmXcazFSKSoR47D3CZcLUkbj5+u1UcbvSIl1gsvqcRoBes6QOaTlIHfXhwY3soquNkXPh2
 i3/vsNeVEzuf2bKyheBtsJbu2pVJ89nYjmujBtjBQ33OVxOwtIMDjZitXe4Yxzeg2bHLIZg830M
 cfPD7l4wbG7ROVdlwWaFylChaNINmLKRtWDhjTxh4A==
X-Received: by 2002:a05:600c:8b8a:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4bb55abbadamr104311415e9.31.1794645605614; 
 Sat, 14 Nov 2026 00:40:05 -0800 (PST)
Received: from [192.168.1.44] ([156.208.106.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571cfa2esm114312485e9.2.2026.11.14.00.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:40:05 -0800 (PST)
Message-ID: <8b360042593f7efa4f7891ba81c3735b4aabb329.camel@gmail.com>
Subject: Re: [PATCH 0/2] drm/nouveau: fix GK107 VDPAU regressions
From: Youssef Mahmoud <youssefma255681@gmail.com>
To: or.pajula@gmail.com
Cc: dakr@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, lyude@redhat.com,
 nouveau@lists.freedesktop.org
Date: Sat, 14 Nov 2026 10:40:04 +0200
In-Reply-To: <20260913201225.5975-1-or.pajula@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have tested the patch series on NVIDIA GK104 (Kepler) using a Linux
7.2 based
drm-misc tree:
  drm/nouveau/fifo/gk104: fix legacy video engine context mappings
  drm/nouveau/fifo: use global nonstall event on legacy FIFO

 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c | 14 ++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c | 3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

Tested with Mesa (including patches from
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45340), mpv
(with
VA-API), and Clapper.

With both patches applied:
- H.264 1920x1080: PASS

Tested-by: Youssef Mahmoud <youssefma255681@gmail.com>

Thanks,
Youssef
