Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244E606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NQohwp8A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C3610F312;
	Tue, 27 Oct 2026 09:31:59 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4CE10E088
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:20:23 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-353804b591eso6223503eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046023; cv=none;
 d=google.com; s=arc-20260327;
 b=EEY7DFYNO3TK2eIhqVGB9HLfkZhJQ8TemzRyWKhwXepcPFfMTkKExbEucof/48iH8/
 00pIueMkHf2lPRB5htMfY39/wxX4Q2Da1dElOt8FgGdn5u62v8gSE/lMBvsVr9iAAHAY
 ur2h1cPvkUuLLDHRsIaAmxzKA7Rwl0aQAmJBEVc8nSZMg/RkfmJFQ0I+RcaNZC34whXN
 1cGa+rt/Txm2IWl8henc7Jib1x3o+UjR3tRrKmJ9pzQZ63Kp/+vaf/iHQqiH4EAynbnb
 +Bz/cOiIv0cLVZH7qZPINW/sDp5LRl699fWUkPUZipE3+S/q5WjNertkzfBPp4TFtU9L
 yHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tiqrTwHchu5NQ4MCw4tFVhQh0jairqrYOuJxWycQiL8=;
 fh=mG08wL15d868HE2OnxCHbcPO2yRGzVPdx7+VT4B5Nes=;
 b=gw8SMWOa+YpTbaYWgJZlF3xCU1kux7uUenXUfEuuIDyoPWdEpM826l0HLJp/9QPHnN
 /7e2R2iM9XQyXOuURYsiODQDpMknkmhD9ZCIxGKv/MSWBLHqxsB56tfpvk/f1ULavF4B
 /cqK/ky0DU2bkbJY6JMMjs82dviAvbQsc8jjg9heLY35tC+/BKtv2aVjt8atnDBiQ75f
 ljFsxa69p44snYcCUlggp9bhEJgHnYpi8h4i5XhhhgUU6A5mgJ+OZlrIo5ne1/kmCjXR
 o///iMCOeUES179bSrwSbZru2Expc/78DzYlr1mnsUMxkB6WiGQCVPxR+mgqWhbIlkYN
 Fi3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793046023; x=1793650823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tiqrTwHchu5NQ4MCw4tFVhQh0jairqrYOuJxWycQiL8=;
 b=NQohwp8AN7WbAd9Wi2Ipn6v7qH7Th1I6gmghe7kZfMVVxfpWC5l8IEqHBG801gFWVH
 8jeGZmtHkGNgn4vtMSBqDmxKPSH8z/yqJpl2I0NUGL3J1FMUMosPSQ4ERu27rKmIG0E9
 7QRNQO2kEokxOI85OL5HIfNqvEX/1FHJLYspnUQWLsPE+zihjr7Zt9Hpy1SRBMIWjN5A
 DPKjO1XhAVRdzUobp3QUEosYGbYzJcTZeHJgkumdrAuzf/J+nX6J8+/xit8ip9n9EgqP
 MXWx5dGxTO9omx5Vke5m5AxrzwedN50AqyxUBW8cNQw47t23/U2UP2Xh0N2FXTb7BfkS
 KlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793046023; x=1793650823;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tiqrTwHchu5NQ4MCw4tFVhQh0jairqrYOuJxWycQiL8=;
 b=xWVxciLryc4eJo1fPP+0lUQqvrs4LbOxTO1fe1t88UhzygpWnpGEdgfoL6gqGJCv+K
 OfxpDclrFY0x/xy+7RSZbr95YNXgHIrQovsQbodJmkiZz4CTpZpoAElPN5IAMNTLCDLi
 o5IvOEIz5s8svjhn4snJh2fScKgUOU4HOtJgKE4+tp7/Siq4s/UrJZQcNA5yn+rThBYl
 7vnwMsIw7qc/qsHXzLto03I/G7MVH0FT6l2v87Ij0yZuHNO14bkqDSBaUf/MEQvyGiPX
 Duff1+/JpX3HCynT39ikp4p14Lhk1BK17nLxAc531CSeGdS4DBV8dFn+8VjMZaXOwC+i
 NNMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrY8TbYTKb7GrYD8A3Mk1iQVwOWJjheH/nRE8TjQuDWVBJP+fptnRVxnpPQKJ1hRhaLpCd84ECul0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJfjtQklsct/+SE/vFFACny3wzk73kpWo3N8AOMmYetLUnzM+0d
 xgBSZ5vmKXJuHiSvMw5F3vq+iPCmuqkFWawnYetsU756JE3QUU5qNb2r6nEMVkur6hupiRoKPyo
 e/BwzScB4a1V6Mv3NiLfs7UuIpBPaRVs=
X-Gm-Gg: AYBFou3EOG3ljVh1Q6mcVBm62uPpj5QpyEzd188YKKhJFCX0Kw9wEe/JYpi49nFh7K9
 yz+XML5GvPokb8U7vyCgU1BkaKT0iO9PnrY8FQLp2I/TE6DOe64Di3BG6cBKM2OBPTL3Y1G1F2a
 EtJ+y+kLsvoJ9aGccxreM7XrupoAykinCZHXV20tgIZoHZGIEr/X35wzcJfDJviW663NAiAefgc
 QETPODK2YAND3rZWc6hLnA+yWdIpGNErn92NzPQCEdwq7ieG5/5I+OyKwSfFJh9IA5uYKLRtLPx
 6FkQELuWQWon74C7MGJ/KY9aHuG3sySLsMLSyODyr2mGnkZXDDUOXAtb2ChCueER98oJg5oQNWX
 Xde5/Hz5cBJWCrcCeo60aAsCV1FKeOBj/pDlgqrM=
X-Received: by 2002:a05:7300:cf94:b0:35c:99e1:c755 with SMTP id
 5a478bee46e88-369e86128c1mr10654244eec.38.1793046023002; Mon, 26 Oct 2026
 13:20:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019174930.7237-1-henryzhang62@gmail.com>
 <20261019174930.7237-4-henryzhang62@gmail.com>
 <CAPY8ntAyrZO5Oi5hxDfSKHdSFpJTR29J8kUDCL7Au0QCXR0iLg@mail.gmail.com>
In-Reply-To: <CAPY8ntAyrZO5Oi5hxDfSKHdSFpJTR29J8kUDCL7Au0QCXR0iLg@mail.gmail.com>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Mon, 26 Oct 2026 13:20:11 -0700
X-Gm-Features: AclHuK-iBnPKK7sw-qt71TTD819kBJb9qh_63xWkNErRExQHTxQtY5RxBWBzRdo
Message-ID: <CANTW0yqXVVbim2UhZjHVr8HrruXb+jP9vCC9H_Nhuw+JiGkrJg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/vc4: dsi: Serialize host transfers
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
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:20=E2=80=AFAM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> On Mon, 19 Oct 2026 at 18:55, Henry Zhang <henryzhang62@gmail.com> wrote:
> >
> > vc4_dsi_host_transfer() fills the command FIFOs and the TXPKT registers
> > and waits on a single completion without any locking. Two callers
> > sending at the same time, for example a panel driver and a backlight
> > update, can overwrite each other's packets, and the timeout recovery
> > added in the previous patch could reset the block under a transfer
> > that is still in flight.
> >
> > Hold a mutex for the whole host transfer, including the recovery.
> >
> > Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
>
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Hi Dave,

Thanks for the reviews. Our mails crossed: I sent v3 shortly after,
see:
https://lore.kernel.org/r/20261026191618.9430-1-henryzhang62@gmail.com

Please don't apply v2. Further testing on a Raspberry Pi 4 showed that
the recovery in v2 2/3 can turn a lane error into an interrupt storm
that hangs the system. v3 rate-limits the error messages, masks the
interrupts during the reset and only recovers while the block is
enabled.

v3 1/4 is unchanged from v2 1/3, so your Reviewed-by still applies
there.

v3 3/4 is not the same as v2 3/3: the lock is now also taken in the
bridge pre_enable, enable, disable and post_disable callbacks, and the
patch comes before the recovery, so I did not carry your tag over.
I'd be grateful if you could have another look.

An automated review of v3 found a race in 4/4: an error interrupt can
still run during the reset. I'll fix it in v4 by keeping the handler
out with disable_irq() around the reset; 1/4 to 3/4 won't change.

Henry
