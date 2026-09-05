Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA70C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 05:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2734C10E23E;
	Sat,  5 Sep 2026 05:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="KlPnISX9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GspcRagj";
	dkim-atps=neutral
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2214610E23E
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 05:13:28 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E5D561400175;
 Sat,  5 Sep 2026 01:13:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 05 Sep 2026 01:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1788585207; x=1788671607; bh=mKQ6T09s6vUza8FyMAXZboJoVa94KKSs
 2rJD+9vX/zI=; b=KlPnISX9RQo//VMkPodDUvpmLZvzYT8VGGKuQNH11B0i7H34
 u9n19x7ea7yeDSNuKQGnW+nrfS7kNqUdIbWrbnKdIvbuSWetXiW8fwxWMIWNx925
 oZI2mvhzxjr+MoYDgrLTaeNTZeLh/H09bUSjrDjYWjlNu7iNaKwYFScbnscD0eoP
 AJCS3qD0iTUIqhz/X5XMPqlshuhSuIgFBAus+XTrg1FFnCsSAMGPPyLVdkSxeq/K
 MP164mVEHIVHEE6XsgmKBFabNUUR51zJ78l8Yg33IjRr4h41FdpXQ9ojiu/N8+2z
 MVIAi1LqeoXuyxRV3RtvckGgN2aEY+oHu3RVmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788585207; x=
 1788671607; bh=mKQ6T09s6vUza8FyMAXZboJoVa94KKSs2rJD+9vX/zI=; b=G
 spcRagjldvZlFYHdc8x3EXNRKSXnBXTY+BeMgAairmezS9Fhwr0Zvi71fwc/Nu2W
 ntmTSK3nWEXlRX4Tg6cCsXYkJilnd5MiyCE3gF/UcHL38jiJtCb1YxfzpcaBYMi1
 Q4TeMOx1xYYaOzQ9da92WJ4KGnLzpdsaATG/9ekPhdZqMS/Gy2VMP6HTITE6g9Kf
 87u35TwPSJNu1a/HH6KjMB87NJcZefUgmn/xvQUtkOgYchql8DbTh2Tvp+dtFD/a
 u6EmSQs998Bs6CEhcQv/ZmUAs2naNXSIcCftwTF//PE+97FQWgqtM8k5p1Ku6/rv
 75IjcS7nM/AU+iSZ72saA==
X-ME-Sender: <xms:96SbanjMUZW6CtRP_9R_WsuiNs53V9bkMiKHGhy46lUIOa-OJkx83w>
 <xme:96SbalgJySWdJjQutYu4B06nUFbBya4fE3eQkNvci0_l8xpj2VS1QK2r3olLV83-P
 Yx-CVMF2XQrUsKqVOYwptSyF7AE8m12ufMt_Xruqk9PH4YPqoH1Od900g>
X-ME-Received: <xmr:96SbanLHM9eNCEtKLtThkio_WrVXfWQ76k5HkDNeZbj59LoBPS7bQwaR8HxE2QFwz4FcBZUvjg>
X-ME-Proxy-Cause: dmFkZTGDJEw3t5iHUzRHZjn+JaBo5KAsVspEkoW8MCWPkMvUPAnU+fwjT8R/Jig6eJ4/xE
 0zGjqMF8FwH7siWqoG/yGhrGtL/LXq+uDX7Chexn0Sb1JESrAzFA0f2++iQtztSGIlKNso
 w8ZOYt6acu1pCDa4sMTjugJ7s1Qbnj5GMvaSK4DeEWeUTjznkFkAqy9v/X6H3UyfoZgv9w
 Eo9KrUE6FHDOvBTuDCh4QrH+f0bHaSr2AeorWamohzw5ehfvjnPXHuMikjlx6uT2H3S0kc
 qDXNfnfNHqQVLUylP3Zozf0f5Ua3y2B65bXT54vspD0Pvvmw26R5j9f/EGTfrg8pd8z3U9
 eNK/fX3MeqP3ejXaQT/mFW6C2nAUjjWGlxYusdQn4tI6t9U6z/YOkmilJ/Cm0HyAp9X96V
 4MdoINtYhfnTjioBmkRREXX0Deh0D5e87pP5asxtooNHL/m3mTlXJ80u2vAuarmTdgQ0TB
 O1OQNrzUhFjMv1aygeFPam+tyzm9lb0hnp0hfydfHld8jEu8bZvnWr3EDx4LlVhTyTjhcd
 +LYFSOUz0MGzE3LDeZddoWsjAu98qrU6hkVLYwBCFkL7t2jQXgGPb3sarPPSSJQllZzFde
 hlyoQgdEnkzrhg3eGOYJ2igOjDQcDl+7qJh1OXCIDirLKD/VPktBQ24z3xiw
X-ME-Proxy: <xmx:96SbakGxUOMC35hRyUhA9yR8cLRjt09zFjc9HoSySveBB1qtEYUIuw>
 <xmx:96SbarQmwWR-N82pO9eowxazvUGMd841q3xkqPJqDOvjgbE7uveP8Q>
 <xmx:96Sbagd0ZCxffcKcyXE_cr_b2AY_kfr8a6q-xT0OFlZq5YWJMNvl4g>
 <xmx:96SbaqoLO3gupUamJKeyoBfZxHjUsCFre0PGlSXxaZhD1ae9YxRlPg>
 <xmx:96SbasHRrL0u21cpLEqdGOPoUDj56UO965n4ddNIDthbmO5FLBS16GRW>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 01:13:25 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Sat,  5 Sep 2026 17:13:23 +1200
Message-ID: <20260905051323.189794-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904124659.25971-1-royalnet026@gmail.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <20260904110853.85150-1-gahing@gahingwoo.com>
 <20260904124659.25971-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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

Hi Igor,

> You are not in the delivery path of my series, so by
> submitting-patches.rst it does not belong on that copy and I would
> drop it there - your Reviewed-by is the credit that matters and it
> stays, on both copies.

Drop it. A Signed-off-by says I passed the patch along, and on your
copy I did not. Reviewed-by is right on both, and the copy in my series
keeps my sign-off because there I did.

> You may want it on RK3576 too, where the same code runs with two
> cores.

Tested on a ROCK 4D, two cores, on next-20260730 with my series and two
patches of my own on top. Unbinding both cores in bind order and binding
them again, twice over:

  bound: 0            both gone, the device torn down
  bound: 2            core 0 and core 1 again
  bound: 0
  bound: 2            core 0 and core 1 again

Without your patch the second unbind never happens and the numbering
walks off the end; with it the count reaches zero and a rebind starts
clean. Nine models then decode with their batched prompt identical to
their token loop.

  Tested-by: Jiaxing Hu <gahing@gahingwoo.com> # RK3576, two cores

On my kernel the first unbind Oopsed even with your patch, and that one
is mine. A patch of mine that keeps the IOMMU domain attached across
jobs detaches it in rocket_job_fini() through core->iommu_group, and
rocket_core_fini() put that group and cleared the pointer before calling
it.

  pc : mutex_lock+0x20/0x54
  lr : iommu_detach_group+0x20/0x40
  rocket_job_fini+0x30/0x5c
  rocket_core_fini+0x40/0x50
  rocket_remove+0x64/0xac

Mainline and my posted series do not detach there, so neither has this.
I mention it because your patch is what made me run unbind at all, and
it found a bug in my unsent work the same afternoon.

Not the kernel's fault, but it cost me an hour: an accel device takes
the next free minor, so after two rebinds the NPU sat at
/dev/accel/accel2 while my userspace opened accel0 and reported no
hardware.

Three clients bit-exact at 900 and 1000 MHz is the test I was hoping
for, and the aggregate at 2.5x one client is what shows the three cores
really did overlap. Thanks for running it before sending.

Cheers,
Jiaxing
