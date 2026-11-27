Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08F606A33D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCzi375m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97A810E676;
	Fri, 27 Nov 2026 20:17:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183EC10E676
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:17:01 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso60976165e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795810619; x=1796415419; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EO5k6n/37i6TdunZgGiZGXGdx4jOGbhNEYDu4cn2rWw=;
 b=tCzi375m4SLe96zK4BjAINq0zSKE9NNaL99rOwvxkWpFAVmBtalMru4ZA7qeavSsuS
 S2SFpLNU/n+/nSHeoAROzrbg35kkuX03YUEdTEeXnGxI44iwJMiOcTSXbfBlswz69F6+
 38NlqSboGU6kjzbpbMpZmuDY/iHJ++r/eo2u4U+mkyUiWrBF6TmDprhOFDVFr2BqiDLn
 OU+GUtsLPu25GhgvgsEytsL+DZTUOBJVKlo3PNrmzgP+ekWtfSsi3IpqcuSl2BLqcB+Y
 awIK7WjQzQk88DN1nLj5BrJZO8XT4e57zyZHDJpbkzY00phdbLW8GNUS+GfI0kdXVAqz
 kEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810619; x=1796415419;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EO5k6n/37i6TdunZgGiZGXGdx4jOGbhNEYDu4cn2rWw=;
 b=cZYv/Nit5tASpLPiMDlwRIU+aY6xw0fZOJFa/2Ef8VFTNHi29fjgLSpR+V9MXhH30/
 4jNZILRn9zEzbLCDkTHQSSMmeooi9/pTWQzBX940Dpiudl9sMQevOwlMOiCDJzFWiZ7S
 NGRQgkH9Wlr16rIx0TbV43YmrBvXFkX5swWNgwMU9eVzsr9FPp0tJ0zEKyYC+toBEbZp
 IiNbuN1aEdWTfSnaxwr70Qhv46F6lALc1VUz+M6PTGF1sYjM5pZbPmnkejK1zCamwMXe
 H4xUsIMWTX1NtDbq/K8bi5pSCjRZatp77MnAh8WTrTmejfCh8O7xYilWQgOPFxR8w+aV
 htDA==
X-Forwarded-Encrypted: i=1;
 AL+hErH3nM2Ucn/RTs/VkYz0bAFVCe6iGtPeM4Ug6F1GLUnztJTs0GJRFb5RzpnGvgwRpeV2qjYhze4tSb8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+udC4AVtkl9yDZh8jCu1sXpp4PvoKFMuKYWWAhBpPQYmzaKpEc
 mfaDDqVLZ1NmF9k4IoXYQ/v0mShEyNgue6RRUIQcSGvtbyr5vJiBoCqw
X-Gm-Gg: AZFdTZdmFve7+d1FdHA4zRsrtPMG7DKBhGzG3f78t7Yq3YfYdyDcpctthe1GT1flwQv
 TKcOjQ0W+T9/SdFOjDkO44FyslrLAw0OvjudQnk3VV3eMBiQgxNrsv2OVlm6IFvqu3xsptLu/AM
 MPjtFimPsg4FOqtin+EBSHKHf/r6QQjLwlQkazk0xc42dO99HmnmDRxR+AyjjBRZk6cuWfIcq4i
 QSaoAC3a/k8oOyN/qEMd97kloD8OyX1PQ2r2GYbDmXC55g4zbH4SNsLA72VeraQpY84+2L6w/wD
 4n8Ek/BDqHs+pwsX97NjufuoPk1Rdq5dXZRoE6nA2pUV16wl87/rRlCBXE/V3/AurS5EupRSGWK
 vsPq6p7JaVp8yADed1ysiXkhhrif5i+aBtC0Vso7i8LK/knasaEyT2NE28DSvE7M5CR4a2CZYAQ
 c98xQWKD4UNmEBavEX1JVk3DLPS2hmlby1fgFmFj7T4DAmK9A7W51Sn0t6BbzyXSQO9CtJvWdMS
 /lgmcvZkBmXe62nX/0JPKrNGhNxZJerA9SEeKzvKqJjlJVK6XiOEDaW21sbLYvckAtdptWGZCM6
 p2SUv+JPTiZYepZ/RMCS1a/ShGCVSej/ykiNjSlGQUx3dg5qePzI763xldz5BCrRIsooXR+5jIx
 XfY0Vos/4xLJ8HdYlS4zOLfTx1wYTHowk4k9b+C8TlWSbbrY9u3qK/jhhxE+wUJmVh5fbc319xU
 zmW4iIfgajaNm8Qa/Kg5GTfbSfmCQeowq39cG5hW2FiVghZGiZpT2evw0EdvRNverreDPMpyfmi
 5/eO9hPyanzEhz9All1A2Ac+g==
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id
 5b1f17b1804b1-4bb88816acemr564296155e9.22.1795810619117; 
 Fri, 27 Nov 2026 12:16:59 -0800 (PST)
Received: from jernej-laptop.localnet
 ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm1298123635e9.4.2026.11.27.12.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:16:58 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hansg@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI
 support
Date: Fri, 27 Nov 2026 21:16:57 +0100
Message-ID: <QITIdKDQRWGwlU1DQqnbAg@gmail.com>
In-Reply-To: <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
References: <20261127080649.1982883-1-alastair@d-silva.org>
 <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
 <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 27. november 2026 ob 11:20:02 Srednjeevropski standardni =C4=8Da=
s je Alastair D'Silva napisal(a):
>=20
> On Fri, 2026-11-27 at 10:03 +0000, Andre Przywara wrote:
> > Hi,
> >=20
> > On 11/27/26 09:06, Alastair D'Silva wrote:
> > > This series adds boot-time simplefb HDMI support for Allwinner A733
> > > (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
> >=20
> > Where does it do that and which U-Boot version does?
> > I don't think we really want simplefb in the mainline DTs any more,=20
> > unless there is a big blocker or delay for proper Linux DE support (lik=
e=20
> > there was back in the A64 days).
> > In Jernej's HDMI series he hints about A733 support being pretty=20
> > straight-forward with the reworked H616 DE code, so chances are we see=
=20
> > proper DE3.5 support in DRM rather sooner than later.
> >=20
> > Cheers,
> > Andre
> >=20
>=20
> I think the blocker was firmware for DE for this SoC - it can be ripped o=
ut
> of the Orange Pi OS blobs, but that won't be acceptable for linux-firmwar=
e.
>=20
> I'm currently reverse engineering the GPU firmware blob, it's not very la=
rge,
> and is a well understood instruction set (MIPs) so that may be a path for=
ward
> without the vendor contributing the blob to linux-firmware themselves.

What is this GPU firmware blob? If you mean for Imagination GPU, that
blob is already in linux-firmware. But then, this has nothing to do with
actual display output. Display Engine 3.5 doesn't need any firmware...

I'm with Andre here. simplefb isn't needed. For anything more fancy,
Maxime is working on DRM readout series, which should allow seamless
takeover of display devices from bootloaders, like U-Boot.

Best regards,
Jernej


