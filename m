Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFB606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTx/P6zI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0768910FBD1;
	Thu, 19 Nov 2026 07:48:41 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B899C10E7C1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:41:01 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-380b40312e2so3383384eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795020061; cv=none;
 d=google.com; s=arc-20260327;
 b=sfrn5bvqoIuyQ4sN7rIjKt7LMcq9yRa9WH2DskdQHrs7duTpWumhvnwyA/hrPmH1xt
 MC2lV1gscuszShDutLr4CfCOqfWPVOSGecePHuveaxz/yTwx5FJpTy7sNbdyOxzxBr2c
 eBu4V6mUks0ii0FNO1EsMs5y+53ESIlJ0Pq1DHlzZvf2hdvFgC8/r1j3Wdnz+56LNPr3
 /rf7mv8uw2XEdBeLxoYDFUS4NbeQLUMsjQ3m/MjGmYN/r5JZS0fanxYpN9uFwC3n8+BP
 9WmAcYkkUgOA5uCcrdF/nIcAYh+z1vHy8/MKQ/tBSDhSoyBcJZyJdk+1F8nFNSUk0TjJ
 aSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zNj1ZiOii4huTkwwxrEikQoB6e6UFur9DfGbzo+0Afk=;
 fh=KChIKuPCg+qxHHSlFg8Sxw5bASfp6rRIGOA3j9cWxGo=;
 b=Jh0RaKcxWKZoiA0Ct6r60mdamEkcU7KsduMbsTQPgSL8Sl2JGRVLg18SDUqNzq6J7T
 rwGFHznGeBq8oIyRYWxJ99POGz+Lcgzyx62NdiXkT1kZBb3m8iHoj0zKQe+lp5Gms6OX
 r6YRT0E2jcsuiR1LNDMGtJoujR80X3nlThi6WNh9wVwDFcA3QDIU/qKpSmWEBuEJX2Dm
 OV5Yt3bFOztJiaz0hC99I0CfppLEbTZQerQEVS6FIoIY7Jo7jmP0X/Zy27g8m/whrGvq
 DCHzWz6BlQCfYQnyaABMk2zs8e5FS2H6b6jMWEw+tElIEDCu9ATUP8ol8xHLCxvbX3O/
 vVqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795020061; x=1795624861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zNj1ZiOii4huTkwwxrEikQoB6e6UFur9DfGbzo+0Afk=;
 b=GTx/P6zIHuCsyipoZWxIXrNYDu+j9ba11fQTl0sAbeCGgFLT8sgeHOoqLWtYXzH5kD
 exS8XOc31SsZ0iOrr7l0xmXkHdHOK3CvN2Flz93ans+Zfd+TK3zmj+pb0zbhSIlflsQi
 l37MXQemKzFqy6dRqmfL9mXr14ATzOqLSLATaWbhiIcw2T2RLStbIA8D36rO8cTmnVlD
 TK0GwPtbhL5oXPKFZSeK435TJryr2anxEa7MyZueNmXd7LlszUYDJmw7lQRtkiwudZDM
 iy1B+QmZRAj50tRXNYT3IYdawWTJUQ1VDBcNCQ2ZkHo+xxf0XOWe4NECcCjeSMdyOsxA
 QlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020061; x=1795624861;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zNj1ZiOii4huTkwwxrEikQoB6e6UFur9DfGbzo+0Afk=;
 b=kiIQkCGbyIr/vZ41Q1U84N6TGBXJthPhhdNrVOoYqpHYFpAiTiH6sDqeNDvrYRWMWU
 1iYD1D5IOdW2R98rEFt9hmrAY4iZDoibFjl9O0IiyHWPR0qn3yCCcbcmdGtfIJ1F16EF
 w66TsPCWFu6q3moWmpmbBNruT3XwT0Oi9GHROAkHOqa/5bMawnFunbMWcdc/lnWthnBA
 c3FHlaXWxiRv6Kwim+ItGs+w4cUUW4Zv1mM+J71YN6AOkmJInbR5IRFS1xVvjmnMzKlQ
 HKuSq1oy7XdLgjfWJsPPHnkOqDLa0eAo8qQHJXiI1UyfUuGCrs2MM3E34SQVNswieU7A
 sgKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG+Cd1SllHQ/HqHg6gg1QALgGQo4Hkxaf0CGBr3ZA61dtm/jHHtEx8FelxNEgSnQehd5WsY+M1ZoU0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z94XSW1kHM00nflmr6QxfyRcpsIGfyl6yphPItZh1m+FOxq4JXm
 BwYqE4bPAmm9+WTogoUgOjdDrq2dfsuxgZ0Kxn9zbxRZtSDUugyCUHwZb8MYbKTzY3pSkZdoHbY
 VeMq1JQNVwPliw5jNUCHb4Otxk8h06xs=
X-Gm-Gg: AZFdTZcQSVJqOSXRxD0o5j4M3jk9t9EIZ0vj5jdhGS/CiuMl18J0SwUWscHzyvzucT+
 wutXBiOUnFKqalbmdlwbWVqP2THAbzltXc7A25BZnVudpBlUtNwlRnUsSPocrGXQVkujvSeXd9z
 KvggdIHswbdCsA1HQu5ktWzVYUlkHOc1Zv4lGmNIgvXewA6GVDl8WIvryMCWuAY5ZxU+MK9w+aW
 hum4kSTh4vs3Ux2q9O6puTFNHywsIdu0whfB9/vIXgE7ZIwKwsswXa2yxXdpcQHrP/2cneiGhBF
 6Pjtn5aCh+kzwXa+UqGDO6jwHJno2OnnpTk0caCXo3q6PrIRFfSI86u88ttnM1r8alJmcYw1buP
 NBQ4qGqBzM/uRpNeL9uMRWOzWtEoIwCwMvQ4puFk=
X-Received: by 2002:a05:7301:18a3:b0:378:314:4042 with SMTP id
 5a478bee46e88-3828016fee6mr2937643eec.14.1795020060831; Wed, 18 Nov 2026
 08:41:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <d76571d7-6c5e-4a36-85e3-db5a5b0cc2aa@igalia.com>
In-Reply-To: <d76571d7-6c5e-4a36-85e3-db5a5b0cc2aa@igalia.com>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Wed, 18 Nov 2026 08:40:49 -0800
X-Gm-Features: Aa3M54qe_yD0XNC9GaTofiJrDb-PQ0zcKl37JpPx5Zb8JNEkYSkgfuhaEqLV0WU
Message-ID: <CANTW0yoj3VstRJ_omwyc=7xBk+VhovWH6wG9xJu5ObbE_nqk4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] drm/vc4: dsi: Make failed reads visible and
 recoverable
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 6:35=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
> Applied the first patch (1/5) to drm-misc-fixes, thanks!
>
> I'll leave the review of the rest of the patches for Dave, as he has
> more expertise on the DSI side. Anyway, you should consider addressing
> Sashiko's comment on 4/5.

Thanks, Ma=C3=ADra.

Sashiko's comment is on 5/5. It concerns the single reg_dma_mem buffer
used by the DMA write workaround on BCM2835 DSI1. The threaded
interrupt handler writes INT_STAT through the same buffer as the
transfer path, without serialization, so a concurrent write to CTRL in
the timeout path can receive the wrong value.

This race predates the series and also affects the existing timeout
path. I sent a separate fix the same day:

    [PATCH] drm/vc4: dsi: Serialize register writes through the DMA workaro=
und
    https://lore.kernel.org/all/20261028181720.3476629-1-henryzhang62@gmail=
.com/

That patch serializes the shared-buffer writes, while 5/5 keeps the
interrupt handler out during the reset itself. The separate fix is
compile-tested only; the RP4 tests do not exercise the BCM2835
DMA-workaround path.

If you prefer, I can resend the remaining patches as v5 with the
DMA-workaround fix first, making the dependency explicit and omitting
the already-applied 1/5. I'll wait for Dave's review before doing so.

Thanks,
Henry
