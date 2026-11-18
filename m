Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86D606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=g9mPXJDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE89C10E105;
	Wed, 18 Nov 2026 04:25:15 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F5410E105
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:25:09 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso1373925a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794975908; x=1795580708;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g/y0SanlVtgObYSEwLsEUV68JNF5YijD2dEdh3NZmus=;
 b=g9mPXJDaP+l7m5oZ9S3nhkJfF1D7seB18RQxNfKPKVPDJ3NJAolpmdNEYwF4P93gJh
 zumRm2/N8D2CwJ80ahhxPZj7rKqmzUiYWcf465Uq9UHR5We+42I9OJ1pb9SuW9UnTQ8c
 HNaEGai4zj19Fj70JI/vlpkjW38jNZZgqpcPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794975908; x=1795580708;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/y0SanlVtgObYSEwLsEUV68JNF5YijD2dEdh3NZmus=;
 b=zG9ScR/GYKEUwdlUVWVsnpnUv99FSMjDdGxRq5H0Rpdnn9XyRixBqX4EV5MaU3IXmW
 xNSPGG8ei9DKHEsdSp0AqONNVRlt5DGhbJgFQyVw10dVk/LbQGA40ISDS9mPmcNSVdbY
 IJbgfbiRhmDv+hkZ3IJNOPgnUr0ChvWQ0BJCkpuhsOAZOaCymgFr/YG5A2wdQziY4uZO
 lL1LzzRjQphz0XFljvK1iJ/AjdgAw1SL4pzmEacxdRkHt/ATzxVZwCPR+BYCqBeVRBgX
 6s1ZB6MwTOTEc45H+c/jL1/nS1tSZqm9qb0h66eokvzbxd/2Q8MakpAuRTuPDvVj4rn9
 Aiag==
X-Forwarded-Encrypted: i=1;
 AL+hErGAl2cuaUmC/WMDziQ8Ax7XPadqv2qoB0KOJTUn6B5I+7gBQjuQV5S0KIz+ec5qJZzNnc5m2eqP/hQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RRZCgELo6YDwLtFfvq2w2em+OV1NIxc+w4TfQGV/yYtiGrygr
 paybGapwzyZe1YsNYQCLeHTybRncyX2aREKJspCSJdtgJXddPebXL8DCh2rVQtMi/qARuWiZWwO
 2JzDXIFsn
X-Gm-Gg: AYBFou1dE8TsQAZjzBDA43z4EdYQkBaJwczrlrlX6nemFSPQq0B5gSIiR4bBJJVcJzh
 N8X2ugf9HwDECZbi/qEwF/fvDB0BeNa0X8MubwqC6lEO1P/0XyObBiaOQfIIGFIvDJ/iqxun6/0
 mYdu0ZbLeFsrFtFHT11wci35vNILseJxjBKF+tGNDNng5JnaUrJKjexURbfZPYKtoeMNk/SxZbJ
 nmwE+GS46r8hBVPOxzdS1XJjHHDL6APoi+6hOZtJmy52gW/5bByTXv3qZo5O51xlfGCzCTaQnvO
 8DtTepZj09ewXUQ7qxBu7PNjYWFUaWTTfcEZtC+Vvu5bIWFJ5FRx5W9GvQJQZ1dS2qMl7R7B+Bl
 S5kK1EVrletw+szX/hMF74nBhzGBWkLSyTzPvpXzEVSiAX1wzRQwIPY2Rbp6mpoi5GKslLflPNg
 300BIm3MTNMy/CG9hu6zGBjEM0ZlbnynPora4UDZHCmu8s23dGbx2gUwrs0VWC9RmAWVVYJ48ms
 34rwG0ret4gTO8yuqANJSvrMrWEfNewHnZ8Mlt7w7s+0isMt71mv0CXtsy0bgDhbHOG/KqHsRkC
 1dqbSasTtQ7hChiTVgm4haRvu4cOIRZXbSvEEdvm14RFuQ0oGXpASjfMAXIKt8/uKexH
X-Received: by 2002:a05:6402:2812:b0:6b8:8167:733e with SMTP id
 4fb4d7f45d1cf-6b887e516a6mr1047723a12.11.1794975908017; 
 Tue, 17 Nov 2026 20:25:08 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b889c2379asm545891a12.17.2026.11.17.20.25.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 20:25:07 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so3294745e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:25:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErELEiMkP0OR3QFGbnnhWoxkYKl2ypaeIH9OSF+BjZP+joSbc5BtF/T/VC0eAGs7WMnwZBSdxIRDg9I=@lists.freedesktop.org
X-Received: by 2002:a05:600c:a303:b0:4a2:84c:52f3 with SMTP id
 5b1f17b1804b1-4bb7da13acdmr20021395e9.6.1794975905159; Tue, 17 Nov 2026
 20:25:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260716132334.1565183-1-johan@kernel.org>
 <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
 <avw_XKo3EzosfyIh@hovoldconsulting.com>
In-Reply-To: <avw_XKo3EzosfyIh@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Nov 2026 20:24:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X5DTqanxUBt9KoVh_93u9EUQm8_B2mnej=+-nxpA81gw@mail.gmail.com>
X-Gm-Features: Aa3M54og-zJOYzu0vMfj1XrR0iPAewvsqdZk6M931gUhwaCa4nfWXvCzQ92vVVo
Message-ID: <CAD=FV=X5DTqanxUBt9KoVh_93u9EUQm8_B2mnej=+-nxpA81gw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Nov 17, 2026 at 3:49=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Aug 12, 2026 at 04:12:00PM +0200, Johan Hovold wrote:
> > On Thu, Jul 16, 2026 at 03:23:34PM +0200, Johan Hovold wrote:
> > > The i2c subsystem currently blocks during adapter deregistration
> > > whenever there are consumers holding a reference.
> > >
> > > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > > reference to the adapter module so that an attempt to unload the modu=
le
> > > while in use fails gracefully instead of blocking uninterruptibly.
> > >
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> >
> > Can this one be picked up for 7.3-rc1?
>
> This one is still not in linux-next. Can I get one more ack or whatever
> is needed for this to move forward?
>
> Also adding Doug who merged a corresponding patch for panel-edp back in
> July. [1]
>
> Johan
>
>
> [1] https://lore.kernel.org/all/20260717143119.1815106-1-johan@kernel.org=
/

I took a quick gander. One thing I notice is that earlier in the
thread there is a Sashiko review [1]. It seems to point out a valid
problem here. I'd imagine that if I land this patch, I'll get a
nastygram from Arnd and his RANDCONFIG testing. Am I confused? Is
Sashiko wrong in its analysis?

[1] http://lore.kernel.org/r/20260716134901.05E221F00A3E@smtp.kernel.org
