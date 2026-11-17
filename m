Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DC606A334
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yvhYtvNA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07A810E641;
	Tue, 17 Nov 2026 19:12:10 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A7510E641
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:12:04 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6b8627e0eb2so292961a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794942723; cv=none;
 d=google.com; s=arc-20260327;
 b=NNl1ZY/++touLgqiKvmP+69KVMGHT2ORJ9DFRcFJ/OoCP0SSMp9VefZtxnCWUU65Gi
 6Tb4hmYrOLyV545UWKc7SJ3iRfVcoKz97R+A46NUcaRAmOddDy6FBpuF0+67MzXorMNA
 exPn8a4f8tUolPlCMfDi+JAdI5I/OGwAtmpQ8wtu2GxhYn63jKBhGVyJ8K3DKrYpcQg5
 tKQqSWBf0hQvQrzBHHaIq4IabMzqQyVMln9TaIHl31KdiehrbeT9FeHcYuYhbcmh5JeO
 9dhxdVAwx3siui/rspBmj58D7zQz/uh6j6zXEZM146Cfn+wtl3TgddJ4Dnj6oVdydxS+
 oR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vOL/Nw17lyMhYB+phC9VVdqxP1Km2LT+SN3+8ZuNcpE=;
 fh=NaliPj2Grt7KFWx+phF6DNuK1Zscz2/nWmdfI9ziMBU=;
 b=G/pgzluRdQDkHtNY88QcpuKYi+MTmT3Z43D/Unu2q77xmvQ9Oltf2rzILo0CMA7Tgt
 6voieCPXsyD20gFtfyFU+RjH67G0tw7I3I1SgcD8L3tSNRfP5tUI4TdWEuHSW0iB9sro
 9y8eFAIZ18SaRjDhig5M4yY6TYDnpWXUEmD7seNu5OkllYePyjWPikp/V81O4mGBIMAL
 clmcP/KMHVPwfe6aQwMVQTIkKs96lfqpUoVsNvpnrRx3c/oe5d03G1FkZgfKWucPyhjj
 FD4P+PVO9X32EIYmyhHEbc3RVXUwedZWY8WZXVidhTcwy27s4oBVyPxpyjBZmDjqKtD/
 tpmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794942723; x=1795547523; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vOL/Nw17lyMhYB+phC9VVdqxP1Km2LT+SN3+8ZuNcpE=;
 b=yvhYtvNAJVNx0yP4pMBsu627oDF/SOXLE6oYcR1+dwQdB4dfhhKzzuatTuzjd+FR0p
 p/GYcrTXnj5sueX237SRyFLftsooKQxTijbdc+STELP/gTwNOTPQNdPyDhod9kc6tZJh
 v8fkmQX+yWZYPHk/fmXZ7fIMhMPcxrOs2zWad3zqJBA0DT3NoFCAdcx+sEhy1oCx+ReN
 6kZhTqgisoYNwvKYa9w8FT3PpUha2h3WmVpPC7YUQRatgFkN4zzHMEmlgACkZ7gWPjpW
 CIxn9rZtqwBJaT7Y4wePMb2S6YiKdAl0WPx0UbN9Q0LY4RLxLB37nVFfGgl5tZMXhefE
 bN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942723; x=1795547523;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vOL/Nw17lyMhYB+phC9VVdqxP1Km2LT+SN3+8ZuNcpE=;
 b=QjZKZ2Jri+dOssMS1nbETyReFYzxJNbsMTGgzMYc5KmvGVXW7bqkHgrr9lGtX7u0ZZ
 VuwfURtpo76Ai+wcVY+Uko6HxucBOVPBHKHR4a2cTneduqSqXOyq7ihbgtbp13bDf7hI
 fckpBxX+NPoaevZ+OZ3tv89QJNv4rwUV9r/X3ZOQupFY6XWqY0ksTs16qUK9MhGkKhnS
 pYd0lnv2X8/11IxoyeRvyzAwdw5Ejt0YH7pgPTrIAEf8+mnhGvgzNPm51tc18z69S1r1
 Kq8OziEB9+LnoBKVQSqS9zgQHM5kuQtInXSsmTbLlU7jLWXKcRjZUhesAhVsmi5KDNgd
 nW1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHaRoQkxiaE6MURYsl+GG1alIBbmJGi4hoColFUd0peP2wtuzsos4c3V3go5WaFyVXLCba4nXRoJwY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RlUQfOWzNVURHjbfqmdwd0ZI/yEwW6ehvL+D1s6sqinzbAfkg
 gKR89k/yr856X+4Y1sznINV/MTUnOwrUMmvm6XQMqgR6R8oTHPph4d7yvgOuIQi/FvQBlJhzOGe
 ByOXXkBorNpgFIEMFktbadoekVF9X808=
X-Gm-Gg: AYBFou2bf0EzLxVewkOFIRbV5HQrhgEXsDrSrJnPELn5KWKBpcGX0/DgygOwlrSHaZN
 66APVj1EF1i8qkUJystzM2MbQIIF9CV3KHuzhsQog4Y/nLFPFhUX3mPfcwHVTaRF/+NHLuFNrRo
 7D4twA1+APbhBLaHlKYpg7LV86YJd5HAQe1jmD3MydufQVcDfWeJnoS8UxY1uHDPzWKND1hK4Sc
 DWDaOduY2OX9pjjjFW6tl6MeEa8Sw9oiHfU1+rvk6kMkLZ+d/j56Sp/6p/UBo2H2z7kVFT3q9BL
 GSg+xswwpOUXJLJWgQDt/2HZBoEzvFrVlzvPh9+GvNjZENQC4W8XWvb4TrY66VhuJhgStuIkE35
 CrPyZxzaOp/eOEHs0wT1Wm9D0JuaKol76y8I=
X-Received: by 2002:a05:6402:2805:b0:6b8:7775:515b with SMTP id
 4fb4d7f45d1cf-6b887e52cc5mr201512a12.8.1794942722510; Tue, 17 Nov 2026
 11:12:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-2-l.scorcia@gmail.com>
 <3701981f-cdda-46a7-8079-de5479ae9c27@kernel.org>
 <CAORyz2+wF=VDTFkRFU7jBu-zNTW7T8mnPrJZAj8ZVD-Yyr2b6A@mail.gmail.com>
 <53298044-3595-4231-a498-d78052799727@kernel.org>
In-Reply-To: <53298044-3595-4231-a498-d78052799727@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 17 Nov 2026 20:11:50 +0100
X-Gm-Features: AclHuK_tAaAmV8XPp2n_nIuVB_4g8FKHhKrmOBsZ4DZheY4_R5_9zza4TO_AcK8
Message-ID: <CAORyz2J9HrKr5JU1rigB7apEUpHg-P_ke=STWz-_sn64afqQgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: mediatek: dpi: Add
 compatible for mt8167
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>, 
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> bindings and DTS should be complete

Thank you for your patience, I understand now.

According to the current mediatek-drm code, aliases are not really
required unless there's multiple instances of the same block type [1].
On mt8167 this only happens for the dpi1 block and the rdma1 block. It
should be possible to introduce main display support without the
aliases with a couple of changes:

- rdma1 drives the secondary display pipeline; it can be omitted from
the DTS while still having the primary display pipeline work;
- dpi1 is used to drive HDMI output (not upstreamed yet). I can omit
it from the DTS for now, adding only the dpi0 node.

With this approach the DPI bindings would remain as submitted. Once an
appropriate mechanism to describe the blocks' indexing is in place
those two nodes can be reintroduced without having to change any other
component.
I have done a quick test on my devices and the approach seems to work.

Please let me know if you can see any issue with this idea, meanwhile
I'll run more rigorous device and DT tests.
Thank you for your help
--
Luca

[1] https://github.com/torvalds/linux/blob/666539eecdf4db623f5e3c3e55cf9f2dfad24aa4/drivers/gpu/drm/mediatek/mtk_ddp_comp.c#L566
