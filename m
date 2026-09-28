Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0526CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACE610E58C;
	Mon, 28 Sep 2026 19:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rfIUkCMG";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77ACB10E58C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:39:10 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b926f0so2206670f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790624349; x=1791229149; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oxVLIRI0OWy7GmeotPDiP09/QY2zlDyWkimQu7VpxRs=;
 b=rfIUkCMGkqX7N8oqPWfUQrBoi89Nn6kg+Kyf38Is9zYOLbaJo3m1o5HJTU8Yi+L/+V
 HlZT/GZS4ZLUzQvuuU1FyC7OqrYLctinCXM5QDmTM7Wqbgifo09tLWFMi+6fXKJibttS
 XtAVXvu/ekFKouiVXnwUgDhpHR6GoGgIJgxUcxo8/zy0fnn9qIv/6eka143J7lTP7Usw
 zSkuEHo4afJiNC4fCOoT2wMLBHy+rZJKNuDmMLsd4Go5NMYy3lYjn65qdwL0lOXFp/yp
 BwHRcyyPq4PEc4yr5H4hRi05WqYErJifpA8znpHjNv4FTuB3TwyO7I4A9p+wqX+KMCyo
 WNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790624349; x=1791229149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oxVLIRI0OWy7GmeotPDiP09/QY2zlDyWkimQu7VpxRs=;
 b=WI4W81uWOR7B+1xbzqIW4GZEl3WSHtRU71LYpYhAgkPr1MW0HH8wEe0M0rsXR0ahUR
 yE6TYDCFpWqMruCGWZHU9l68aZa7fL/iuPVsYcxj2kpJMXkGFYxKmZm5ST5oOeMijC79
 uKSrn5TEE1iRj1gL0FWKiEhYPfauq3Ph3Ul5wWsSx9IIJRttwzfDka6njdlLP37meB7l
 a1xxVEcs/ISd7Ph4hfT7BO5wpibpwsIuf8hzKc0637XJKlND9EMra7moHwYDWCsrRnEF
 J98Ji1qbbBb7pvbZWg7uCf4COdKlHJtwsat3Zio43PFG0mwYq/AgCVAU7Scd/UXqgrmX
 dyNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwADDwy5sAEnIJcuZqB5H1epVXeQW/4FSR0nji3SbVhxFCB37LCvYHSzFGmGrOfwqqbe4rHQW3BL8U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICavx4EnJWGLVvexKmszMFbdCZEq8SgsCn1q+0HSe2ip8w6SVu
 VE1+QF2nbzmMCmlHpeTCJ9Hq3CJpS1AUskUCSD2WpriHko2unYAHLUPS
X-Gm-Gg: AYBFou1jgOlImBLKajJkEQxzmSZrUdNmjoH8+ZqtgsfoMi3ve+uchCUT6EJL5GBPDHp
 XIo1o125yO+eDoR7iNzfTcl+8jswFN8C8y98oq3DctebaddwAlD/b1zFXPIkR3d10AchJJ2SUTA
 mZP25940Q13k/mq5SmyZ3AqWy7s6pwvuRxkIP7+MCOoBlQ9gzjbE0DcqENk0LQd22yjYQsam9ik
 30WqzGAtiaiEejmTA7KpFFNSJXlB0SVRNDmUEE01soNQjIQsd6cj1nSSPtvAsyMIIxCju75l4gj
 ZQA9lgHDJzR2/I0GI2YoiX3+OFqfX4TooFxEfjzC2nDsgIDDFP2jZZcNaanQo0WR6Z8q25ouK7R
 2frvlYVVQFzZ10n2hNGvjIQEtWMHchLm79OivwKXlemF7hVDmIIM6+UBhqVyeFSB0yptPXiAt8Z
 jh2wDVhj9+XRBQrLxzO/1NsVHmyGiBrgHR3ydRMhthI2RORs2zklxuPe+0xxwTW3xJWcWALOiLG
 0fZFUL3Uv9IfhBr118826bMsu7rBr0BdXCZv2z7wKn+kMxypvQc4yQtkvoAnlKnZjQbkulGeBZ1
 yGOJpwCPiVq77YL5I/ol39km8CwOb536p5iIctnHl/LkXfssyq/OWYreU++K6WQdv5Ldij3xjw=
 =
X-Received: by 2002:a05:6000:3104:b0:48a:eff0:c31d with SMTP id
 ffacd0b85a97d-48aeff0c6e7mr1174394f8f.38.1790624348461; 
 Mon, 28 Sep 2026 12:39:08 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de.
 [2a02:3100:acba:a601:4494:3582:465b:eab])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6456f8sm29487793f8f.26.2026.09.28.12.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:39:08 -0700 (PDT)
Date: Mon, 28 Sep 2026 21:39:05 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
 Bryan O'Donoghue <bod.linux@nxsw.ie>, Dmitry Baryshkov <lumag@kernel.org>, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
Message-ID: <arrAvk4aYQ4sDEzN@gmail.com>
References: <20260926022026.10539-1-liujianfeng1994@gmail.com>
 <17bf71c6-2442-4eaa-847d-29ef625870bd@amd.com>
 <CACSVV02WCQwQy9BpUUqziQTtKV7QyJruiM+iTiLE_SEVKtpVNQ@mail.gmail.com>
 <50a9c1f1-6889-4bd5-b4f7-0500d30d3dd9@amd.com>
 <CACSVV02BPHGeGFo0vs8-Q2JvcvQ_gw_xe4kZj_nuzk8n6sW7kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV02BPHGeGFo0vs8-Q2JvcvQ_gw_xe4kZj_nuzk8n6sW7kg@mail.gmail.com>
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

On Mon, Sep 28, 2026 at 04:21:41AM +0100, Rob Clark wrote:
> On Mon, Sep 28, 2026 at 3:48 AM Christian König
> > What I can offer is to set it to default N for another few month to give you more time to fix things.
> 
> If it is disabled by default in distro kernels, that sounds fine.

Another option is to restore the earlier DMABUF_DEBUG default for now,
although off by default is also fine with me:

	default y if DMA_API_DEBUG

I would like to help fix the affected importers, and have started work
on several of them. Beyond msm, my LLM agent found paths that use the
page or CPU-length fields of imported attachment tables in:

  - rockchip, tegra, rcar-du/VSP, omapdrm and xen_drm_front;
  - tegra-vde, staging ipu3, pxa_camera and sur40;
  - fastrpc's SECUREMAP path;
  - the IIO dmaengine buffer, USB FunctionFS and UVC gadget DMABUF paths.

The host1x imported-buffer gather path also looks susceptible. There
are less severe cases too: amdxdna rejects the affected import, while
mali-dp loses MMU prefetch.

For sur40, IIO, FunctionFS and UVC gadget, I have reproduced failures
and tested local fixes in QEMU using local device models. The other
entries above are findings from source inspection, not hardware tests.
Some failures depend on the architecture and configuration, in
particular whether NEED_SG_DMA_LENGTH is enabled.

Unfortunately, I don't have hardware for most of these drivers...

I think the drivers managing their own IOMMU mappings also need a
clearer supported path here. Simply switching from physical addresses
to DMA addresses is not generally sufficient, since the latter belong
to the attachment device's address space.

I also have a draft warning-only mode for DMABUF_DEBUG that I can post
as an RFC. It preserves the CPU fields and logs suspect accesses
instead of deliberately breaking importers. Coverage is incomplete
and the underlying bugs still need fixing; strict mode would remain
available.

Thanks,
Karl
