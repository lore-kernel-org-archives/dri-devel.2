Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3AD606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KuP8WKZ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA8210E046;
	Wed, 21 Oct 2026 06:17:54 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39C510E046
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:17:48 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6ae14cdc63aso5201a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792563467; cv=none;
 d=google.com; s=arc-20260327;
 b=U7U1shH83+r/7q/1A4AUTys83nI88TjjA6NqlZVqe3yUAttV1uAHqMbNE5zOnjyWAQ
 yFkAiU5Z5brDF51i1DXlS7U2m5mhW7a9sr/JMFC+97cBnwSvoWtaB19399DBOQWi7tlM
 LDJ1mPlsU0VBuNF6+usUAbwWQzHfGW1GvaQ8Vr1UNSX5P2M8OhEa5ZvWifW1U9kPIJBz
 eQznTP208FqURLDE9khjz96SPR/wW16PXZG0dlPOMKTTU7AnNtMB+65eDg9Q7Yl4OT0D
 JpVC0PMKJuZg7D41ljsnPcnXHpSUvCi6LuDU77nK+lGMxq3yf4PxTwefl8N9i9F9L+XT
 oVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
 fh=Jk3m26Sq64rHxyE1eh1yoXc2o276z1RjWkLusmdvcH0=;
 b=PvH8wgKE8Hzk6O5gh4X7na8/KmaYUR6zAqX8N7h0VEslwM9rqHRrgQJRaATq28rSVC
 xCzdoKhi2GgCeJiJr108P3j5CrYrE8UUeZfb6OenC19isMswBKi96UGjOvbkwaywJRQO
 Jz64+Xvv4CIeHlS2Y+q3KN750Z/8DN0pj9dD5Sy+0NYIXt+CNH9hRTsgqNOiv3m80qtb
 +psyGJ0mgWT9gwrrVvf0leqxS2bCbXYhClApo4jbOGTfnjtZRtbI210At7ISm2OnLS/V
 Y7NXuIOJAiWkqy9mb0fkPx7kdpkz1EJzg4ixHkcYX85BwlbcQIW47QeLeago3hySP8+G
 FLuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792563467; x=1793168267;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
 b=KuP8WKZ6jLwhaYLSFSf12zUtA9VkG/tNW9PqE9WehFkKnqXY94uARKxeD4Onk/hrRN
 SwTjVbwIgztayzckDJEcyP58ttgbHC68usb3RKVXEE7+B1dcvO66OONNnMb8xpeSaBYU
 VdT00yjLiaiavcSMuqycgORIO722GmaxLvGy4ghD2VGNQ1+6xD7/PTMk5OMBtEqnBk6E
 Y+p2HYQC+RKYQCxYp/hSJvSm9Cv6FxbEpMaV0ItWVL4FoYyhuAATB85vv6RHI3U5GTQZ
 MOQCywhx3dtBd66y5/EugdlVP27Awr8ZxTdWreh71SeBsNKIcs7xga9fe9csgMXa+VDE
 /qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792563467; x=1793168267;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
 b=rHyHV9eqVXCrmeVXPLTP6Nj2QUEusVYwuSE4wtO4j4DC7sMgYAFltrkk/XwpktVwAi
 uU+PCNK6tygruv+xeXn/ZLGZaMOb84s28ifGkem4HdtYhfVQWlMNd3jEyDPlv7elqTdS
 t3IEgH1+qPP+bzmekUdXKnY8ynLxe26tgrkMdwTkzp8dgrPpZIoj0wUeXvL83hNTPsGv
 0+aJlsIrlQEVENj5f0RHQlhK38NAU48k/fIWMnglnJ53FDad8p5OihB0lvj9MbGJu9K4
 4OtNto5/eBg2VVDgqZqAfCkxBO7Vm8CWic03p6/CWmcv3sTD9Oko7De+wwgb3zqLD+yK
 DDEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXxa+JR6obMMpbZTHGV3hIAODJ+p/jzzRfrRkTxpZ5oR36Yp6CtEiHhXvF6pfVP6CCefrsv2uo5lk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLMRVC2Mujkpc2H/f81wojC4fqbTzjoLxoQ0kze1LNwE2JI18WY
 0bB+AckDxhRPYrvJxlNR3Et+nhMWFbZEibjJZNUw3mWeaB5DD0Ebj91p6/Qbl5lM7iIGE8IRd+q
 Kmq8okxq6Kk6Pwy9nxvv9ziOPBiPSAumjvMEY2EeU
X-Gm-Gg: AYBFou2eJpbsrrlY8PXbxDZIZLlNtUPk5hwriZzeW9o5bWP9NHVLXcUIFPaz66VYesE
 +wNT261VhhTtPiZ1mrtjT8adR9ioC4SY/u2nIeyFjSK7UIFavObOMRIi8Rx6PopGZIInHRBYWvA
 2HAoTW6ZO6BexCEX8xBg0Dx0nRNP6vRIenhUJ05XWvaoa4NR669PWPVcrjQmVBINEuN/tZOwe3a
 QtkKeC0em5MtSfVdVjpRBUm7kinV1G2WEaD02Zsjv2EWeEJLKRje0f1qW/angKmfUX8tUGnBhJX
 bcyHy1BN46iLug03HHw4KzlFGwWigcWLk61RHApTBr8xT7A0SGGwlUCp0HZEzAjnGGOS9bnZ/cj
 3nPAGXe4h3vZ+Osuzp9P/quXUVPTbNFsusQ==
X-Received: by 2002:a05:6402:4050:20b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b3e77153d8mr91222a12.12.1792563466679; Tue, 20 Oct 2026
 23:17:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <20261020121858.3b9107c5@kernel.org>
In-Reply-To: <20261020121858.3b9107c5@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 23:17:34 -0700
X-Gm-Features: AclHuK9x4qWdNnjJvUjsI2EHUcAIAKj09plc1NcLTKxrSfCtCSi6D5JlUi63xuU
Message-ID: <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 12:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 15 Oct 2026 16:39:14 +0000 Mina Almasry wrote:
> > Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
> > netdevsim net_device, and configure page_pool instances with
> > PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus PP_FLAG_DMA_MAP |
> > PP_FLAG_DMA_SYNC_DEV when CONFIG_HAS_DMA is set, so devmem bind-rx and
> > bind-tx netlink operations can be tested against netdevsim in software
> > selftests.
>
> Slightly worried this will bring a bunch of maintenance burden and
> "bugs" in netdevsim. IOW that this will be more pain than gain.

I felt the same way when I noticed many reported bugs against this
series because I didn't add proper support.

But on the other hand the test coverage is nice, and maybe one day if
we add enough devmem support in netdevsim we'll be able to fuzz the
data path or something. Is there a way to get the best of both worlds?
Like put a comment on top of netdevsim that this is test simulator
device and any missing functionality and/or bugs in it should be
medium criticality max or something? Or is it too much trouble and I
should drop the netdevsim support and tests?

--
Thanks,
Mina
