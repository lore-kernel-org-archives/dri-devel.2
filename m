Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B30606A332
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oS55w/Wh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1CA10E88D;
	Mon,  9 Nov 2026 20:17:50 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FBF10F500
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:17:44 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b56c90b38eso3106a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255463; cv=none;
 d=google.com; s=arc-20260327;
 b=UqLiJEZiinwMY9qcg5hu7pR/CvSGcBZulrI4hkYm/sO8o+bME8tchW38LCU0ZLy3M2
 zn761EyREfaV8GrkqRm8owURes5XxCvVuSHpIiumbMuuO+Tbuw1JJa0L7bPr2fDNy9rJ
 CDSnQq7igNcSeVxYsGebGI1DSjO2DLKH+XKkxZ0oEKnK2zqQSZ2NC2MzhZ7Cw56oFhcT
 3bbiHDNwUtnQvhXVTAVcOA++/q4xPrSup1Z+pVCdahLtgwXxl8mI4AvvF5qbRbC8p1Ki
 CoeUbisS6IQ7c+mt5+Xp0O0KdSpZ8ieF96y/nUoCy+N7nxTPW7d+o9mqXYeYAwXBxEgX
 9LNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
 fh=tB+gft8foCWdg2WSNxbWP+F4hMcAQDzXpwVo3gak2TU=;
 b=aPN6lu5daIbpJRZan3OyLgeNYgOeAUBve3Rukrl5jnyongExZUGIAoceevCu0D1W90
 ypcqbMS5NAjPRs4AsisyFs+Ahh9cZtoGKkwQImeZ8p+ULyztIg5kmfiSwLlfuPj+5od3
 /dgMU0qZzOj6LSazUCiovCqH91xCvyw2tOjzF/qp8DEdYyK0GcI99yPZ9Kje/pe2Rytt
 J6z8Brv+YQMDW7yIEC11XU8Oxp3+9EvKZQCnpaqbIJ/lq4JG6dBxEc81o3PfH7yp5aJg
 6NTWnATjr6yjCREj6vMtac44eI/d3q1q5dLR9FxGA46GrEpkE2fgK17DZ6YfxcGp84gZ
 fKZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794255463; x=1794860263;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
 b=oS55w/WhVazR9L/pD2gl+PDu4Ts45AA6DcV1agatenPypU1Et2ov6QTqv1KRLa2X2j
 3VNMFgkQyNob72Gb/ZFb1GdGJ+Hq6AtT5Pk35q4MuLXRmciIqtO+/KcAAkag0TG1y/8p
 URHt4EUZCH19YXCw+97l2i4TmmRE7vrvmiBeJMTUCCSpIx52v/mE7DK0PF5cPwWGnzXc
 jltudcM4RCyaPozD/xX88yojVGsNYIPXDp87KlXeomv6dXVhGcv7doFNtBrS3jPyeyu+
 PI62VveReSmgwHKAisUxF1jU3Sl4OeuEkUAAF2U+X6lp0FZ9udaMAHfFPZYtwakk6ein
 meRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255463; x=1794860263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
 b=uVJj+eEy8Wguvars4Fraq8A7StTImi03Fr70iBbMTHeVkrQaX2pKxNzZdp+kbRsjMO
 Zny6Yi/4SRrRe25ZdbGUvrDpepfrNr2cmORdP/JNu+a7ESO0BL7Y7c89YolN4SnTPoWZ
 SvPMatBLmmMDUEQjlEgRglvnqUqDTY/p7y4fv57zm/eMkDEmA1emf1ilVg9YcB0X7SCk
 O9Iv1HPM7Yae90lYxgLLnD3wSW9HuScvEvGQ8zBFuLZS2YVQJQ6yE4LAEDOEepnZ1IZy
 dlHMVo25drBFJnzxsZJi/Ga7x2uKz7TCrKQDgaw6lT81n4djguaYissdX777Rb7677/6
 xdIg==
X-Forwarded-Encrypted: i=1;
 AL+hErGUOWWhuiQR/WoDSeM5zC0JqcI2H+miu3/jAXnUD1WgZkdpJnGmte/vhJ798gF/9xXhZkRkkcs7gzo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wV+I3hUUPemZZzRLv5nrDDbAogQIr304/xEzRPhQaKO0GOpv7
 oK3JVU0E0JoVK0OTdu9/XIzyQ7ExmD8vuNrSjK0KkhXZHePkQTzhWEl/tsfo8LBoWQdipvt6wUi
 Ki0AdHkos3Z6nKbqnA3zXlWHMhAPPBjTrxmGlwF+N
X-Gm-Gg: AYBFou1JDuLkNbThvYjIZNedgVCM9QYa5/nFe/1kDUQSaE/IzOlZW6SA0zkdpWYjMyn
 1zODYHQ/LW4Co3RDHlrNJGtGJN33j46XbpsdhGooNdVP3ibvhrELzQY39HnWgQ2jAcJdnxWTDLp
 nBfxsBro6/SaYjWGSGjwObsftYeS4YUFTO2t79LHKKku4T232hHtBLonkENf2D+hntuKZPWim/I
 qxyHUFI2K5NWZR1cnot68cm0A/s7MVw15JR9EiEfg2gZIRE1hhZF6uepTqfB2Yp7IDVm2VVGt7V
 cvfnocaFbvIlkfNWJcQPcO7PF8IqNoAHYV/VfkwQ1W77G+oFpPWqW30NjzX5+qkmlTPFO9p/ZHq
 PTFzXqAC4NMuRO2cg3pcqrWmDt0/3x6N85szjfY2McZSI5AaC2+ZtqFT2aXTh7trAqkA=
X-Received: by 2002:aa7:d7d3:0:b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b756af180fmr22485a12.16.1794255462346; Mon, 09 Nov 2026
 12:17:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org>
 <CAHS8izNTbs8ONvjhiw+6cRkZQq+cX3t=BZK9aCr39JNkVbY9gA@mail.gmail.com>
 <20261109104959.181a3b35@kernel.org>
In-Reply-To: <20261109104959.181a3b35@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Nov 2026 12:17:30 -0800
X-Gm-Features: AclHuK_0MFErjqghvOz060hZJCCzy2vAPCeLH5qWi-kHJsJTH_MqHsOjMY4lEMM
Message-ID: <CAHS8izPcFSLdmq16ZrUDKpCqUJf513EMs+Y45brc56s+mUBmeg@mail.gmail.com>
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 10:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 7 Nov 2026 22:21:48 -0800 Mina Almasry wrote:
> > So I started looking into whether we can improve test and fuzz
> > coverage with an improved netdevsim. My LLM prototyped full datapath
> > (with devmem) and offload support in netdevsim so the hardware
> > selftests and packetdrill run and pass in a plain VM without physical
> > NICs. I posted the branch at:
> >
> > https://github.com/mina/linux/tree/nsim-devmem-rx-tx
> >
> > The main problem is the total LLM generated diff to netdevsim: 62
> > files changed with 5,525 additions and 672 deletions :( So it's a big
> > change.
>
> Great! Please keep that slop to yourself, tho.
> Upstream isn't built to host people weekend slop.

Understood and sorry for the bad suggestion! I was indeed unsure how
you felt about including that kind of slop in test code. It was a bit
too tempting to suggest it to enable the extra test coverage.

--=20
Thanks,
Mina
