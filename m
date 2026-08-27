Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AC2C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C78510EFEE;
	Thu, 27 Aug 2026 12:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="IkWCT2Mu";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056BC10EFED
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:35:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso8315325e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1787834122; x=1788438922;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FqMm8FT0UDvKvnU0PABnBSS+wYbc4aE8U5V+uRrPoww=;
 b=IkWCT2MurZSNnzMBM4RejnY+6rh+AJHDQkIK+xTaTTj8zQ2hyzeHfcDvGwACFqNgSf
 MKyWZSxYfviAEt3UqVdXomWwdMvEcyLcBuE33L7MDbjSY9mWiOZs9bUqGzS3UP6ZNgm7
 wEwcZ50Zc7XZVx4LRvNFgGtXmNJXOvgrnAD9a326VAjt9vqbm7Quxs9sQylsdqsPZVS7
 NHaM/YX+3dT87UwfOMWUyqAA3Jfg3Bz6h2kPVuATvoPqU1bVEgjJpP5z0mM63cvdArHn
 DMtzeGogE5K7ZHrzG43TNyBQrtQ9AboJrVKYXD+wFo6qVLKnCj16hQaEAfdUoh/e9Nkq
 Qu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834122; x=1788438922;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FqMm8FT0UDvKvnU0PABnBSS+wYbc4aE8U5V+uRrPoww=;
 b=LjlUxanQPs+TL+3u3qAyVbze2vrwkWsyktYQIwLqPTKouQjRtKoE2YYGYCP+KZTUuX
 DJKO/HIPdeYj9toe6isCcjQSEzxGtvfmeh29quJN8aL/McTqPpEf7NzeRFGGBHdZ+jBN
 c6GNJKg4T3dI2m/j9UwbK2GJm9qBKltGKXNrdOI98ThvjcQhZQl9ezqLpWqaxHEdbg5O
 l28RGerdQl5G6gk90Ub438quwpoiuYDs+6IYIkk0IjtwbKxmPCprRjTlGBUVDHzAZeRm
 9fIu/nVQmeXgRpT7XYEtrczoLNvq24+5ZtGwRhSm85SpY/yels0cY3pqgpaZg0NbwzoA
 lgiA==
X-Gm-Message-State: AFuF++lz5lxS5RvuPOH2fczeHRhXHFr+kaatbwzxKQDx+fV2E98QykCO
 bQsAUuLiCptwzg699Y5tQSGxjKGRowfqDOiYA0jxXdFZtsLRA5D4K8sxW68PfgsZO/g=
X-Gm-Gg: AR+sD11ZXXnhq1p3NTBTC2TKADkzyUyhgTNQc6drjKz15+qeLDg+ZVVSGVkfzwI7ghi
 hKVx7puyNKFdLav2gme34SH4Zl5TrLpBBm7Cy71vpZaFXMkV4QwAmE004yG8mxjD8GQODV9U5ep
 PDyEI8ia225UljRz/TxTBgU1xoSOgLh1QCmj+ik+otz5LeBcLzl/2AJAmmEuOmlE/H8+ickB4g0
 Vg03Txg8Oe7hAR5+XY9LGHDY9NEOjUJwTl23qUqhNRsj6k7OkxTEhFHOKccnqTtojzcaYSyxE8L
 nUCn+xyM+qL9Cp0utKZP4+gFeJdJmdjHQTlH+9DANVUjWwOC0ewxwtYUVVVscWy2u822nFE3+oD
 rm2ecpVmaJ3lH9v5ubg3Mw68Eq+uEbj7b/vSYuY8zHICpc6TYUU6aVz0Rg4tsteZ8QfUuNOA8my
 9Q2eyKBA0CKGfgChqTFoDuFu60o7M1MqffjMWdCM0jYXfd/7WsQ4/zEli5fJQjSrxE3Y7tyNMBf
 u1Z74l5
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr84639315e9.7.1787834121595; 
 Thu, 27 Aug 2026 05:35:21 -0700 (PDT)
Received: from localhost ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4a940aeasm46658765e9.10.2026.08.27.05.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:35:21 -0700 (PDT)
Date: Thu, 27 Aug 2026 14:35:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Konstantin Sinyuk <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ilia Levi <ilia.levi@intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
 jgg@nvidia.com
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <apAsfOowcG0cTvT8@FV6GYCPJ69>
References: <cover.1787552412.git.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
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

Mon, Aug 24, 2026 at 10:09:28AM +0200, ksinyuk@kernel.org wrote:

[..]

>Example queries using the in-tree YNL tool are:
>
>    $ ./tools/net/ynl/pyynl/cli.py \
>          --spec Documentation/netlink/specs/drm_fabric.yaml \
>          --dump fabric-get
>    $ ./tools/net/ynl/pyynl/cli.py \
>          --spec Documentation/netlink/specs/drm_fabric.yaml \
>          --dump endpoint-get --json '{"fabric-id": <id>}'
>    $ ./tools/net/ynl/pyynl/cli.py \
>          --spec Documentation/netlink/specs/drm_fabric.yaml \
>          --do port-get --json '{"endpoint-id": <id>, "port-index": 0}'

Using generic netlink instead of sysfs for this makes a lot of sense,
but it may be a bit odd to use it outside the networking area.
I've been struggling with the same in another non-networking use-case
as well. I have been building a framework that keeps the benefits of
generic netlink, extends it and is fd-based.
I call it CTLV, here's a link to an early pre-RFC draft:

https://github.com/jpirko/linux_mlxsw/commits/wip_ctlv_pre_rfc_draft1/

What are the benefits over generic netlink:

- No networking in the dependency chain. No netlink sockets,
  no CAP_NET_ADMIN, and no network namespace semantics to reason about
  for a device that has none.

- One character device per registered instance, not one global family.
  Access control is the file: udev rules, ACLs, an fd passed into
  a container. The open mode decides what is allowed - actions need
  write, queries need read - so there is no permission model
  to reinvent per family.

- Events per open file description, not a multicast group.
  Each descriptor has its own subscriptions and queue, and an overflow
  is reported in-band: the next read returns an event-overflow record
  naming the first and last sequence lost and how many.

- Large payloads are referenced, not copied. A blob attribute carries
  a user VA, a memfd and offset, or a dma-buf fd. Nothing big travels
  through the message.

- One YAML specification, everything generated from it: kernel metadata,
  UAPI headers, userspace bindings and the reference documentation.
  Introspectio. is answered out of the same metadata the validator
  enforces, so a device cannot advertise an operation it will refuse.
  A checked-in ABI snapshot makes any wire change a reviewable diff.

- Family inheritance. A family inherits another's operations and fills
  declared extension points. The effective schema is resolved per
  device and the chain is exposed to user. A shared core with
  per-driver extensions is declared once, and both attributes and
  operations can be extended.

- Introspection is per-device and live. The framework answers three
  queries on every device: the family chain, one entry per published
  operation, and any operation's full attribute tree with its bounds
  and limits.

  The answer is what this device accepts right now, including what
  a vendor extension added to an inherited operation and whether an op
  is currently disabled, and op-changed events carry the generation
  ops-dump reports, so a dump can be ordered against a change.
  GETFAMILY and GETPOLICY describe a family statically - there is
  no device in that model to ask.

- Fragmented queries are built in, with a consistency check.
  A continuation carries the generation it started from, and if
  the answer changed underneath it is refused with ESTALE,
  reporting the expected and the current generation instead of
  reassembling a torn reply.

- Attributes are 8-byte aligned. CTLV_ALIGNTO is 8, so
  a 64-bit payload is naturally aligned and there is no per-family
  padding to remember - netlink's 4-byte alignment is why
  nla_put_64bit() needs an explicit NOP pad attribute.

- Cheaper round trip. A one-attribute query measured 2.6x cheaper
  than a genetlink one in the same guest - a debug kernel.

- Async operations using io_uring are planned as a follow-up extension.

The framework owns validation, schema resolution, blob acquisition,
reply serialization and the event queues. All getters and putters
are generated helpers. A family implements semantics only, and
the aim is to make that hard to get wrong.

Would this make sense to use for you?

[..]
