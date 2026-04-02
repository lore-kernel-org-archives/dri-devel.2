Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF86D6AAF4
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BB310E3CF;
	Thu,  2 Apr 2026 17:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dl+Qup7z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3407710E3CF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 17:16:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 476D2600C4;
 Thu,  2 Apr 2026 17:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A08C116C6;
 Thu,  2 Apr 2026 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775150207;
 bh=q2ENSVdXL9UKqPBougkuIFpXYN+LGvwxDJpSdkRe9Ns=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=dl+Qup7z7Tc98Ztt+iWlXK/Q8X0gMUKI5vMwrgSYk4vNr979EgAfJr5jvFWvwUdqn
 X9V+qmPQH/nINq3CbMK1/+Y738cooTCq0nNRl9eH4HW+iwPh6y9mcltfM8iBZsQbT3
 0rVdOJrAg1YsnLP+/e3meuUO59+avboDyLEUV+HX4K7xLar4idJ2sBtwyFAaJ1z13z
 t6YIdZZzynhs4JQqEDmJGAEXLntj/kxIaw+XKH/Q2rFKKAAKVsd+ONUFw/9UDpBreD
 PxpG69RsW24/OtKUzY5pPtbtJ9zIx5eE2jblWv/sTpmLU9Cg/R+i1hPv/s83mthrsq
 TiSi2wZQOQoTg==
Message-ID: <ef82c1e910558e82ac228c9dcf9ae79e9f78a238.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] net/rds: Use special gfp_t format specifier
From: Allison Henderson <achender@kernel.org>
To: Brendan Jackman <jackmanb@google.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  Stanislaw Gruszka <stf_xl@wp.pl>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-mm@kvack.org,  netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Date: Thu, 02 Apr 2026 10:16:44 -0700
In-Reply-To: <20260326-gfp64-v2-4-d916021cecdf@google.com>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
 <20260326-gfp64-v2-4-d916021cecdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

On Thu, 2026-03-26 at 12:32 +0000, Brendan Jackman wrote:
> %pGg produces nice readable output and decouples the format string from
> the size of gfp_t.
>=20
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  net/rds/tcp_recv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
> index 49f96ee0c40f6..ffe843ca219c7 100644
> --- a/net/rds/tcp_recv.c
> +++ b/net/rds/tcp_recv.c
> @@ -275,7 +275,7 @@ static int rds_tcp_read_sock(struct rds_conn_path *cp=
, gfp_t gfp)
>  	desc.count =3D 1; /* give more than one skb per call */
> =20
>  	tcp_read_sock(sock->sk, &desc, rds_tcp_data_recv);
> -	rdsdebug("tcp_read_sock for tc %p gfp 0x%x returned %d\n", tc, gfp,
> +	rdsdebug("tcp_read_sock for tc %p gfp %pGg returned %d\n", tc, &gfp,
>  		 desc.error);
> =20
>  	if (skb_queue_empty_lockless(&sock->sk->sk_receive_queue) &&
>=20
This looks fine to me. Thanks Brendan!

Acked-by: Allison Henderson <achender@kernel.org>
