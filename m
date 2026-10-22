Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05D606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gF0RD75n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED00112733;
	Thu, 22 Oct 2026 15:42:02 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C57F112733
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:41:57 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6ae14cdc63aso12645a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683715; cv=none;
 d=google.com; s=arc-20260327;
 b=CscFnwbYn5rMD1eIeDVLY97tGlpHn0WRqBm8qe72H79GopQSTMGaSXdeHVhmNZqB8m
 B2Fvx0AeT45maWWc9pOK/8WcETzeaRwZYWxL+NJO6vZAA+IuCediWlNHTvGD8agQXy6Z
 VOevVA0lyrHnQpATElsGWhYfUSUwEkskVil/SKd+3sPVIf7aXHDySJXyOM5Rtf2l1E2x
 fkArGcPBI5stUVNorqxy5jBnj/ytPKaInBAL47EzxBDIlGjfshEoE3fbR/ouHESoxqmA
 pURi+42mr2Z8Zxh9Z5DrXm7MNp0ikjg1ply2aDAy20fK/g+HZFW35d2EDb/sgp0hoi2L
 kqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
 fh=czfKriXUJHqTVpYl75YR6WrnEjMOS8LTP6eHpba3hCs=;
 b=A32OaP9Gu2HQrLfiIcETqwFnH3Cr5Z026lefJYHTdPZXNgbe8TcEjODpXTeV1zCBXa
 bMO1QB3TR85X+yFCh1qLQLcKqAdvvOJNIXvjaWvMPZHDiidd/jwKS8byS4qlO6MbensI
 A1I6UGqqRTcvnhvl7JYVVw/qvb+OxRcq/Z2sdiQ+gFlsMSxIpsEBQYmUilSJZe/Yw5kN
 DrVy66KESTQnEubvCgnTRoiiPHy4BBpI1Dup9s9LEx/KP4OqxL0oodSXHiNt/2xXZMhx
 VK8qc7YPBZBjH92vFZL2qxOk4ivLC2ywtRCDL+6XSmqOx9kuHBr+aKtY3HcT0r7oKfQf
 x0Ig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792683715; x=1793288515;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
 b=gF0RD75nMJ+RluxzWvLfg+HA6CBknK5QJ0JcG2XWv7kIBHurIOj3oujez+wo+sFs07
 Df1sCDDPXc+1g+2mNQbTWCGyTyQuRA4NesCR2Wzb9SYQWrFJh7FmHeT7rXrZXvBW/WCc
 O5FPUw4oKYIEcxbvsaPIdX4ulFOf0UQ27kfh200DBUV4q7qWAFTjR3yAedp8bnQe74nk
 xSpu8gHPrtY94UqB2hXL401fvru210X8vGX+zUtLkLyMZFKxO6QBFbePfChEyDuc566A
 F6Y97SI/nC6HEVRELuwrkKcu2vV46w2GN9Z13bctyz0hAkNPhb9rhEI9JlBD0tu6fGvy
 f49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683715; x=1793288515;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
 b=F4ZPekieGhQUWHvQR8OD+h4MKXlDR5mjq41xXy3nSI7lUGUjPleQP9IiOq6b9ulusm
 BjbLZh+5epTMql+35ggOZuZpyQG3XWcDAbAHtgHwC82Mv64B5KJD6RBOwwExN5daPJjX
 9Hhx/6YLrHdSfo5BEg+X9g4cKMfTlQcKbP3W8EcrstZm50mhCyywCcjR/Giq2UEUNnMi
 +R7jjFCsO6lEee5Me+HV0f7nZ6sQnQLcoA3iFsggliDKb2jZv2RV8SHU0BCa1huH9PE9
 nEW0g2Ty5bx6Xp+SZ8ezZcFu8vfRg/EoqpHdpRu8XHFNo+QP7moew3VeVpQ+VQhLnOsw
 4m2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV7bWHVbdNLoTZGd+zvf5oTt7B/NhSIjv8mw+aQZ1fdMhFGWxGaXTw5d9b83wdY6Jk5XzsKSx8NGI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKKGfF+92pR5TDghDP3dhqhKWHcjRe6ZlW71FxS/LXH4xuQ1uxN
 BSFy5AgeiY/Qg8O94ph2RDT48b6cZXogn5sxFtbKMf9K5EmaMFkCirr9i6JAkQa0iF0rEzf+0jX
 9HEKxH/cWvXpaOIfdvnftGRr6Juj5/kWctyBfIPdK
X-Gm-Gg: AYBFou0d3o/RxJY3LmMDc4ExRFf4x/eaNc1ua5yNgXdQWHRF+74vs8ZBTuqiPLRC0fl
 6+X2SBpp5BiFhh1TW23zhl0iv49gG5mq3d9k+rQ52G3CE1fF/1VYx9m8YWFcPAs3qWRA0XNTd9N
 mK/v6dgag/IjKabfB/sVi0M/t5on6gsKvXBS1gv7k6XBKXDKLG29P6qGYqRCJ3uLRH1mpJp4g7/
 vZ4NK3sS5n978QjNYeNPFA2iGfeWSq3tpWxjjA9vhBD4r8Ksto+9t9bPo1epVDUqlpVLs1QiO6w
 ZuD6KBLg/wyHouz3/RpwOq2p1p+i0Zepd255Eo6JcMPk9sRhTWCcLdT8uRc7OtBmAv3KM3ZrbQ1
 OSztOfi8NDw9NKRnxcedrKuiEMD2SJijHQiWA+vFmtPfaUNbHOIhUowOclu9Yyb5vBeB/ZZ951+
 4hHwcVUPSreJtPHA==
X-Received: by 2002:a05:6402:8d8:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b42037090amr51165a12.15.1792683714889; Thu, 22 Oct 2026
 08:41:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org>
In-Reply-To: <20261021132304.23e0a4e7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 Oct 2026 08:41:43 -0700
X-Gm-Features: AclHuK8XnKCgw_zM2po_QzMrph49LXNIEmHOTKG5LdhHg2Whq1BLNJdt4N18LfA
Message-ID: <CAHS8izN_N25mm9vALax+P+W45gyxVoMbZoTXW3r6nPC2Z0A7JQ@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 1:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 23:17:34 -0700 Mina Almasry wrote:
> > But on the other hand the test coverage is nice, and maybe one day if
> > we add enough devmem support in netdevsim we'll be able to fuzz the
> > data path or something. Is there a way to get the best of both worlds?
> > Like put a comment on top of netdevsim that this is test simulator
> > device and any missing functionality and/or bugs in it should be
> > medium criticality max or something? Or is it too much trouble and I
> > should drop the netdevsim support and tests?
>
> I already strip Fixes tags and apply the patches to net-next.
> But it's still a burden. If you're signing up to fix the issues /
> review the slop we can try.

I'm more than happy to help but I'm not sure what you have
specifically in mind. What I was going to do is put a comment/readme
in drivers/net/netdevsim with a note to sashiko and LLMs, "this is a
netdev simulator, used for testing; do not call out missing or
incomplete functionality as bugs." And then hope that the LLMs and
sashiko pick the directive. If not, I can tell patch submitters to
ignore sashiko code review bug findings in netdevsim. Is that
sufficient, or do you need something else from me?

And we can always revert the added devmem supprot in netdev sim if it
becomes an issue.

--=20
Thanks,
Mina
