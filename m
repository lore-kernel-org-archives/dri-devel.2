Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A762606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPgYBcR9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A3910FCE6;
	Thu, 19 Nov 2026 07:48:53 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D0E10E5CB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:55:31 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso3767247eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795046130; cv=none;
 d=google.com; s=arc-20260327;
 b=qQ+B5a+Hc3YQpD3GWLrcpLsZ8/QwSJEZjBqCyVP9rka9PpMn40WHaRIeT2wtjfR1j3
 r8QS6toLcnzlOHbNEqwq13f4uUAv2PpHM37RuDPOtamQMdC09cDGuJRhqWzIFH6a1ipB
 1yEmkpRUTK56nNsp/zDT60NUbdP48peKtJ0DMk5ECqRVAyIVAAnsgAVQh2eSIu3nbXO3
 1lNR6A8jkQzdTRI4DiZexSGHZfpptwXdPP5iM4T33I4JQd/hkPLBLmIR7JQLaHGUGopC
 IMXj0Cvb+kFWSJ0TaA5/I3hbK1IgZIKdog7eESX/17lUsozsj5WMDE8kMy1r4W5SJDv3
 iy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=63Ce5k5KgJ7kCxdquHv1PxDcyB7zPmX8ddeWZ4cRjbg=;
 fh=JWjEjSWP3YJvq6VSG93ZZZGGa9nGmI8nn+a5XGW3bxs=;
 b=PmVjZGFXqQUM84vZ1zuOBLTCQzM/8tjCTtUVwzkssFDr5fm1DFesOI9AwGZ36OvLWb
 qyRotzPZoZ1FgEQGERUFea4YWHat4WyBtIxY18430EzwW7lkMuj4z1QtKjyiW2QKaoKu
 4mS/NAM5k0X1lYlYOo/t1am7DgJVPB7UxcYTdSgcggByjcwGn0x6XGZHU/OZ8uDaK2JS
 twVj/z6LuoTfMdkX+mhAiazoaM4pbyRUrUJrPOe1XdQbpa6Tb+czSKxrqSqP441MDKEI
 l9qg22lLD6bruAXXsyy2wjFpifnc600XDS6JKsjo8cjXQLuvmwy27D6oVZTrsQaxuv6U
 1Lfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795046130; x=1795650930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=63Ce5k5KgJ7kCxdquHv1PxDcyB7zPmX8ddeWZ4cRjbg=;
 b=OPgYBcR9kIuvX3hL7Jif5YgICFehN7PcMA9s9MYCGLEkNpJWeHKtq2scoSU5IAN98a
 uA+tmOHy8w44oT8XiACu5XdnCbiyzIa8ES9MAeZ/srr8/yme7xlS0VURiYrGyi/hPjxS
 Ej2ZfeTPjZe+BrNnGHpdT58jUxa7I3VMJED1UN3S/Hn67X2N32j85wezWqmJWxCsZ/6C
 Sx2WonaFbVZrjFEK1HYxQnGzd9yfZ4XhCj1Cg4RlHzSh/bCHK2LwhnpughT0RbIaiGvy
 bVCQYczAid+R1/AXHmUPZSgK34uEpJ0MCRLFmkZUzNlQ/xmmkKpDNjDRrZdE/V6ih702
 CC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795046130; x=1795650930;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=63Ce5k5KgJ7kCxdquHv1PxDcyB7zPmX8ddeWZ4cRjbg=;
 b=xRtkyA53p13aSIEBbkUoFgmPsV4Nf9v8zyM90VyR0fePUpyTpxRYprl3SWnaJjORld
 cEgKkqnqZTtO6J2onlNrdkekb+OWfffKI8Jddaf6SEFFmJEvJoBF459c+m/OsYg42DIu
 joCUI5dMsf9vcOxNQsNdoUkCph2MXngMtBBqLfOg11T6DM7SWeN+R79kWlnhHUOBMPPq
 2nw+wRhixuxRwG7gAE2mWpt62IOoMQYaHXBa+Kq3GtRT60yw7wrO0JsSKKUt9xfSOfEY
 vAo9SlEGt4WxNUt+yhhNoxM3bJZDGmsYi0NyUhvEFRCr5bLfs9+rnAHc6kd++NSCig4O
 8ZnA==
X-Forwarded-Encrypted: i=1;
 AL+hErH6vu+ngELYeoYBsjydaOKw77gc57kyT55K/c6F2ktuK3vagBuycBNxMnOSc5F3rwW9SEshEOil9Dg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CyvHZ1cV99K/wVisEOS+/BSv/vQ0ze3jm8u+WZn4HJ12peLVW
 +DAAmRBQnrknIXzQ1nrOabDHadlL5vvUhYn9lsG1SB/G4w2JKgu2DDwQwuhBAhRQcWcFfdr+MgL
 hj0540AVUZGmpOLZPHb2dAr8M90uU4w8=
X-Gm-Gg: AZFdTZcTGHK7CVn8hve5WXSdYRIO0nL6D6Qi50R8hLm83glad/YHvxdf/u7SPQR95Fj
 XV51OUAy9m0zLEwWaru2uC/bnVVJd/kbQCsVaozY9oGljdMtWmTgZKiz8szz9pO6BWmib6X9Cz5
 88kb80FZrQavJxHtAj7sLZQkMnRlCRndebq5Sdq3h8XzY1dniFre2wSsivgvB6K+i5KFxjIaKpN
 HMcJl+ExWlEQbtS8hFPtnMK7+iUbLBWxcg1x8wQqWd9sOpDOA/zGVhBju8qLLBUpUcuuoUEX5rY
 JOeOgHSGFarhCuGr9hBy6bfM38q9ZfB09DSg0iplUB/B0JdJhguYo1YrbaBX6DTOhmz0+ZLRrsP
 FaQK9UZvfIMNSmw4nPQHKker3lmFikPKmmx+DQXMZHAyhoxpU71fv+u/rc5N+
X-Received: by 2002:a05:7301:32cd:b0:375:c862:34e with SMTP id
 5a478bee46e88-3828093e35cmr3846344eec.20.1795046130285; Wed, 18 Nov 2026
 15:55:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-6-henryzhang62@gmail.com>
 <CAPY8ntD7UqYwGfSOp4XW5V6574e7o_bq_hnzNfVoq8y92-3awA@mail.gmail.com>
In-Reply-To: <CAPY8ntD7UqYwGfSOp4XW5V6574e7o_bq_hnzNfVoq8y92-3awA@mail.gmail.com>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Wed, 18 Nov 2026 15:55:19 -0800
X-Gm-Features: Aa3M54q8rC9hdRr05t6wi4III9tiHqZZwbdjk1rChRebknqJVFK6FeLFd7oXKKg
Message-ID: <CANTW0yq8H8WO4kg3kZru7oZ58wnd0go=8F+RtSi4GL3SsXW8Dg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/vc4: dsi: Recover from a timed-out transfer
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
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

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
> Whilst it's a belt and braces approach to work around the issue, I'll
> have a dig next week to see if I can reproduce it and see what is
> going on.

Thanks, that would help. In case it saves you time, this is how we hit
it, on a Pi 4 with the panel on DSI1 in video mode, display on:

- It starts with a DCS read whose bus turnaround the peripheral does
  not complete, so the read gets the LP receive timeout.
- From then on, every transfer times out with no interrupt and STAT
  reading back 0, writes included, until the next modeset.

I don't have a reliable way to trigger the first failed read. I have
not tried a peripheral that never answers a read, so I don't know if
that alone is enough to get the block stuck.

> There are very few use cases that have a need for sending DCS commands
> whilst transmitting video, so it's a bit niche. The reset stopping
> video isn't nice although I guess it should be fairly brief.

I understand it is niche in general, but for us it is a requirement: we
need reads (with the bus turnaround) in both video mode and command
mode. In video mode our test tools read panel registers only when no
video content is being played, but the display is still on, so the
host is still sending video frames during the reads. The same reads
have to work with the panel in command mode. So a stuck block hurts us
in either mode.

I checked both today, on our downstream kernel with this series and
some local changes: 1000 reads in video mode (display on, static
picture) and 1000 in command mode all completed. We did not reproduce a
timeout in this run, so it did not exercise the recovery. That does not
change the failure described above, which we did capture earlier; we
still have no reliable way to trigger it.

I haven't measured how long video stops during the reset. It is only
done after a timeout, when the link is already unusable for commands.

If you find the cause and a fix that avoids the stuck state, I am happy
to drop this patch, or rework it, and test whatever you have on our
setup. Until then I'll hold 5/5 in v5 as it is.

Thanks,
Henry
