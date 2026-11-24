Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130DF606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=appMNZ8H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F51510EC9D;
	Tue, 24 Nov 2026 01:41:55 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550A110EC9D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 01:41:49 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-9213eb1f3a7so33632816d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795484508; cv=none;
 d=google.com; s=arc-20260327;
 b=gf0XG/AuY+HGAFuSiY5KANL5NJZOmfeYPjUHsUk53VbZpnvI4TsIe+xMKBWXfPmhCc
 GqH4YWfeoiy7fJCcCP0+gUZSdOHr/tMaQL/jskJlecpw/ilep7VKr0Cu+gypVwJUwXkK
 xyawCcy+fTIle6VLdk/b4x8BjAtUkSMXWHHgtErJCcdMCUlO5IHdoO7Vuiu/Egg+Ml/A
 XxkIqME7xTfhlQPhsVYxe5myEHnQ8j+3wtLyC/hqBAF1kzGYQDVuHtpGSWqgT1YTfC3W
 bJPwt1XAFbqsARp9fEM8aRx0K84ZJr6DLTYZH8Jt1o/fiFARD14kRT9G0UKJGGFXhYuh
 xdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1nyS5zQ3JA24VIPo3NXdZD11p5Dc6cnKOuQvmzCMlI0=;
 fh=Yk9REqO3OquIz6RXcVLuA2qjEOitsuI84T4QCKA+vdM=;
 b=oC45FWFOZdIrfY5tMUKO2zf4qRy+G6i9SBSbO/YtKfdZ7yyxWAXRyx3l45UuHkRytu
 yAsHpO04qoJO6wUlvDX+mZMG4khnUqLbcYHZS4DrjD/36ZnTZ8L3oXyagRMqun5TJ/ZK
 SR9jL4Nzpv65UPvu4t0Yv6WoPi4PdZQOhKElFZdzM8eM/WaZVV4xAySJiEpXyBb9r2Dv
 MdMDEHKO4zENEAP2n4+/LQ5Nb+RXOUtRlvOJPLT2RVcsO2tsqHZxZmf3ajoehzdKUBDH
 vWupzWp3/LHtCeSvQdjYEaoTItQZnYr/1Q0L8yTgO+RbklIE/vKY1qIlF7IlY82W8/wd
 zIbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795484508; x=1796089308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1nyS5zQ3JA24VIPo3NXdZD11p5Dc6cnKOuQvmzCMlI0=;
 b=appMNZ8Hnac/gIVbZfNqhmjC2kwWE7FqfLEfPAFs4Qd6D2QzcNfXVQYnWDPhoW01+T
 EfpOeQwM4Y1HebXiNHzXBUQgdkx9vJ3Kzp0phEysBCzHnmCavOLTAjnrxxmMuGTxRZw8
 BKv/mFjysmlZsH+crIJ/8XWDbNaMu5I6/x533RoXOh/Hlfvdx+msL9rl0G2KpEhM/Q1Z
 dX2Rly//v7jbXrB7mnui6MJrZXNHSFK9PKG3paBSIpl8KNlyFUkjUNTvghUioCX2cVkf
 YgVBJ1TtIacErkPyVcXvZM2QfjsL6mUQ9qgTWqjGSJmZc+A5YOZCqT1B6xNIWNvm/jLh
 4bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795484508; x=1796089308;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1nyS5zQ3JA24VIPo3NXdZD11p5Dc6cnKOuQvmzCMlI0=;
 b=ZYIVlaJVyUU9S4XKgK3rI4qdQI2odYAE0ayi4uMHLm24i1RMSaIqYrCFmIerGfOugz
 jbuQ5Nyk2KTyKoUU7vWSfh5PohaTImmr25R4uUCFzbi5XfbWt9dkmDo9zm9Lb/AY+Yhz
 K4vVBOFe2UQlWKqMEoDiFJhvD9X5fF35A8mOkhZMMBx1MsFtKlh9xHbM0UBVgznqEXXJ
 6ocMuuQHzsHDi910Zcqewb2kz1R+MUxSSVOBetD3xorZuHpdFywT9Cv5+5amS8yLlXMZ
 2F15vVN7+GLtarfoeOVcEjDA3GNLxmLRp7CM6Kl+0HvQ2PWs7gIjgbssgH/HvCI2oi1h
 fHYw==
X-Gm-Message-State: APuU4Z+l5X55OcLfcYn/g1hAtitNAmkmWHEVAvDyEgYCot6pwLUdzi8A
 SHyTKo13zC6QlxlD58nplmNKN9FAuRSqyI52MY1QP5utNIWZJKi/81VwZUIt285aN0DseL5N2mG
 jpRB75of0tIAYNTw1s2ow6c8HbSauE5U=
X-Gm-Gg: AZFdTZe7P5H+hRQF44HYk6M8Jl3GFBHWYHjX8CQRP0s61afY2F5A3ECPXGIfZUnTQKg
 KrgMSynigm1204eSQhKUbiI5DSNLyoBpdqLB1ZJLm+6G21xdQLSDiAJi2hptAOcBKtsso3l5Y0r
 uuEoPW7xVl2K9Wmi0zL5qsabyubiEgi+6WVyc7eGzqW15XhHz0AKi7nbSebuxKb5RXaAlPhoQDZ
 JLynQtCl8CC9HLYbTK9ykkFfiD3BvWEFlHHu8HGsiqo+Wv6jTmapvXjocS4tOdVoSo2pWS26Qfo
 vAn8lemsLMFfZrO4gRB69OngKTDNZcS3IQq/y9KdG/Bs2FH80y5AHV37KXqzkA44uSHgxmu4WdX
 tfSWXlgGNQKiSJVWyno0FCC8Dsve+B6Kl318FZzIvXjNSd4Nqnu6FjY58W0VL0zl/sr4BhHp2wQ
 3PGgZvu/SI2waXTeARk6Jovw==
X-Received: by 2002:a05:6214:5c06:b0:921:3f1a:ee86 with SMTP id
 6a1803df08f44-9213f1af746mr203910826d6.25.1795484507945; Mon, 23 Nov 2026
 17:41:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
 <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
In-Reply-To: <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 24 Nov 2026 11:41:35 +1000
X-Gm-Features: Aa3M54oVAKSZF4YJ0povn4IQXDaHqZqgbt-9vZWggXI9FtScVyM8m1lCO2fB4dQ
Message-ID: <CAPM=9tz_nwv4Cy5N_ihBqp6JS5rghETbJYiub4aVrJh=wy2-iQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/ttm/tests: do not count pages after pool's
 teardown
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Ian Forbes <ian.forbes@broadcom.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 11:01, Micha=C5=82 Grzelak
<michal.grzelak@linux.intel.com> wrote:
>
> Currently ttm_pool_fini_basic() checks if page count of pool-type's lru
> list is zero after tearing down its pre-populated pool.
>
> After commit 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> this check causes NULL dereference because page's lru list is destroyed
> during pool's teardown which leads to KUnit's crash:
>
> [20:08:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] ttm_pool_alloc_basic_d=
ma_addr =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:08:24] [PASSED] ttm_pool_alloc_order_caching_match
> [20:08:24] [PASSED] ttm_pool_alloc_caching_mismatch
> [20:08:24] [PASSED] ttm_pool_alloc_order_mismatch
> [20:08:24] [PASSED] ttm_pool_free_dma_alloc
> [20:08:24] [PASSED] ttm_pool_free_no_dma_alloc
> [20:08:25] [ERROR] Test: ttm_pool: missing expected subtest!
> [20:08:25]
> [20:08:25] Pid: 80, comm: kunit_try_catch Tainted: G        W        N  7=
.4.0-rc4-g401a3e7b64d1
> [20:08:25] RIP: 0033:list_lru_count_node+0xe/0x20
> [20:08:25] RSP: 00000000a08dbef8  EFLAGS: 00010246
> [20:08:25] RAX: 0000000000000001 RBX: 00000000a0803c70 RCX: 0000000000000=
020
> [20:08:25] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000060853=
030
> [20:08:25] RBP: 0000000060853000 R08: 00000000a08dbe98 R09: 0000000060124=
6ac
> [20:08:25] R10: 000000009f227d00 R11: 0000000000000000 R12: 0000000060124=
640
> [20:08:25] R13: 0000000060853030 R14: 000000006047c950 R15: 00000000604c6=
488
> [20:08:25] Kernel panic - not syncing: Segfault with no mm
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: ttm_pool: missing subtest result line!
> [20:08:25] # module: ttm_pool_test
> [20:08:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [=
CRASHED] ttm_pool =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:08:25] Testing complete. Ran 28 tests: passed: 23, crashed: 5, errors=
: 6
>
> The crash in turn prevents Xe CI from running IGT.
>
> Drop the post-teardown assertion.
>
> Fixes: 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> Cc: Ian Forbes <ian.forbes@broadcom.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Micha=C5=82 Grzelak <michal.grzelak@linux.intel.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>

Let's land this and unblock CI and if we need to revisit do it after.

Dave.
