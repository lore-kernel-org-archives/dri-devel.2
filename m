Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4CFCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631C410F581;
	Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from mail-qv2-f8.google.com (mail-qv2-f8.google.com [74.125.230.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82C210E00B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:32:36 +0000 (UTC)
Received: by mail-qv2-f8.google.com with SMTP id
 6a1803df08f44-91438935506so14637526d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791858755; x=1792463555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ePY+63uYRMrFDWAptdadiuSJ2ZP+/koDWoDpXgbL1M=;
 b=CjF+soWAtXO/mgJgRoIlE4ZCMftLnaAuFZE1pq9o7AWGs3ho5A1JehorKDdBjiTo7G
 xxVj78lDoPJx9RoXFLfShW8W6rEzYli/lODySwcL3LRYHQl0h9bnKtyB0Bwyx1usRlHE
 YdjVfFNWtKC3ySb1GCLcNw1oiE2e5VHhovM77TaNdWBmVQtjz1KVK6LBNgrlhvP62Xwf
 IeIIFJSn0MDgYUI54c70wm94eab95TiGCYNE8vpnwmW6AlpbPd3957CIIRbDqM1HxI8R
 pvqNb2ZJop3X3KMqrfeV0nBNMmx6xWR2kIN7Cdrmkr86mew4k3c0+j/ulC36SVxV9vXc
 fRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791858755; x=1792463555;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ePY+63uYRMrFDWAptdadiuSJ2ZP+/koDWoDpXgbL1M=;
 b=G8osM96naqPc4nXqPTNGeuh1FHYhmf0Z1Ihu0C+pRIFpcG6M64czkmSi4WreVkjOIz
 l+lbEn933IOhOTxJccmAOLaEFhlSpExorKDf5U5QUOa7IpJZW+XXY+aIwMG9nmuzLOLW
 IdE2dmYGkn198rr8Z5Q2tLlgv3oBSgyNB2ruEjbf24Vq8u7hYnvitJwGKVdaTSGxjb0b
 BA34HGzd2F/yV5dVUPz/Utyd62ZGbBRBnndM3I4oQX4VUoUjmz0ObUYcjp6Np0EmfjAz
 m/ujjnIZ5dW6dbvVIh0PNM/EZjawUjAN7+TZAKox4/biLzvI/Id0hB3nIw//vOhpnAHz
 zReA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhL26tijNN3U9p/OoT4RjWj7iGaldA8D9MIUKGpesKBGJtPY1wvAS74FGeiQwNG4Jma4FS1kOUOtU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJOWkc6G5sWmA0mfWiUgmkcyfpNG5uA3ejTftPAEi8wJ196a42S
 SsZBJ3irRWUMunNfOJ54W9uEXo6GwnbUOVEx33LbW1WIOjT5jxmPlyEr
X-Gm-Gg: AYBFou2ay+zMhtwQVAO0DhFa3mf1Ve6OvrNsaiTB8c7USOMqTq+8Cdpi+SH808Ll7Pt
 8XaVDD8a0xP8OHt5vM4q4O5hOnxVyKSMNqmdOT15p+CeFu0OvhYdabrMUUELrx6kr5CY7y293PL
 YaokjiphzwI1MY6Be3YYwa4ZeUxn7pt3aGUGsS7vF48fTP0eCmnkUej8UnaLsxAjcI+bPMc7DUc
 ASDGowEs838jUW5NxlphosEOtKic5d74ReC0C7em0/v+qvMUGrtd7MBU1tQOUz+QVtt7Kw23SIq
 hwpmV9jf5nCkXWoABrJolyv3qYYDY0Rz24RdN4XKadtmuPBjSclfyihyuB6ZY0ikLE//WqYuxD/
 49+vtvUj7R6hPkCe4yRAgIXauIiPj2pmV7cnPGCXUZXZQ3bWfV2cqkxPLF6+FVQenEq8EA2M+mK
 voWx+7quLsO7ryyA0Adndf0a26CnuF9QEEW9imruR08KV7diPiNximUpuvR9U9+rOqb0ZndxAJF
 7i9Qb0=
X-Received: by 2002:a05:620a:4552:b0:93c:6abf:c8ae with SMTP id
 af79cd13be357-93ebd231201mr1979508485a.50.1791858755323; 
 Mon, 12 Oct 2026 19:32:35 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:8019:c46c:3784:400f])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef500973asm134755585a.15.2026.10.12.19.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 19:32:34 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 0/6] AFBC fixes for MediaTek DRM
Date: Mon, 12 Oct 2026 22:32:22 -0400
Message-ID: <20261013023224.2195490-1-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cc128facb246d89408cf46aa7c9e250c56900940.camel@collabora.com>
References: <cc128facb246d89408cf46aa7c9e250c56900940.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

Hi Nícolas,

On Fri, Jan 9, 2026, Nícolas F. R. A. Prado wrote:
> I received a suggestion that the Lx_2ND_SUBBUF bit in OVL is not needed
> when cropping is not enabled, and that removing it should fix the extra
> pixels after the image described in 2.a., and perhaps even fix AFBC not
> working with MT8188, though I haven't had time to test it.

I tried this on an MT8189 Chromebook (Lenovo IdeaPad Slim 3 Chromebook,
board "quigon" of the skywalker family), and the suggestion holds there.

Setup: next-20261008 with the posted MT8189 display series and this
board's DT, plus patches 1-4 and 6 of this RFC (5 is MT8188-only; the
MT8189 OVL uses the MT8195 data). AFBC announced on OVL0 only, which
drives the internal 1920x1200 eDP panel. Mesa 26.2.4 Panfrost
(Mali-G57), Hyprland. The compositor picked AFBC 32x8|SPLIT|SPARSE for
both the 1920x1200 primary plane and the 512x512 cursor plane.

With the series as posted, I see what you list as 2.a: the top 4 rows
are missing, and stray pixels show up after the image (here right below
the cursor, on the cursor plane). On top of that, the IOMMU reports read
faults from the display side while AFBC layers are on:

  mtk-iommu 1e802000.iommu: fault type=0x5 iova=0xfad06000 pa=0x0 master=0x21810410(larb=1 port=4) layer=1 read

(always larb 1 port 4, two different iovas, presumably one per plane)

With OVL_PITCH_MSB_2ND_SUBBUF left out of DISP_REG_OVL_PITCH_MSB for
these layers, the picture is correct (nothing missing at the top, no
stray pixels) and there are no faults. I made the bit switchable at
runtime to check that it is the cause: with the bit off, 0 faults in
30 s; set again, 20 faults in the next 10 s and the artifacts are back;
off again, the faults stop once both planes have been updated.

What I run now sets it only when the layer is cropped, going by the
suggestion:

	bool cropped = pending->clip_left || pending->clip_right ||
		       pending->clip_top || pending->clip_bottom;

	mtk_ddp_write_relaxed(cmdq_pkt,
			      (cropped ? OVL_PITCH_MSB_2ND_SUBBUF : 0) | pitch_msb,
			      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));

I haven't been able to exercise a cropped AFBC layer here (the
compositor only uses full-screen and cursor planes), so I can't say
whether the bit is right in that case. I also haven't tried the
resolutions from 2.b/2.c or the external pipeline (OVL1).

I can test a v2 on MT8189. The board's patches and notes are at
https://github.com/zoan37/lenovo-slim3-chromebook-omarchy

The testing was done with help from an AI assistant (Claude).

Thanks,
zoan37
