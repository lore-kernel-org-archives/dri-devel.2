Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809FDCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B038A10FDAD;
	Wed, 14 Oct 2026 13:43:27 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585C010FC90
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:43:21 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6d290b10a35so1619656eaf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791985400; x=1792590200;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UfknVFgwY+ADn2+7Gfp8pJoPMV5PqQ31vPcFrLztQY=;
 b=vNo9Opn8iCTw96iIVt/qstOKSmffAAqyjzaJUJRUEktPNwpOteXAE1sj0eWslMa2zo
 fFTfnuiQBQEig6BZG5dX+PjQ/mfW9hZ5T93xKvnVAqNPFXqoO+Q3/tyHFnmLDSzoV+uX
 v8MWpu6yMn+BZ7GcGnAablX7Qvk3SlR747u1++vs0e9F6SouqdwMM36Vpg8/2RAnPOEA
 yrDwsn1nHwYvJ3of2XJFxeiUB5G+DxclqKIZnkMlywGLlpALv5fUb74eJPB35gNRYv6y
 RUO5FfvkMK3u0gZuCxjtZFsr7NbUKaIYXflFQu7y1/xnjCA7XMa+TarerujXQqH4yzLf
 NpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791985400; x=1792590200;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/UfknVFgwY+ADn2+7Gfp8pJoPMV5PqQ31vPcFrLztQY=;
 b=XwZXBPymvAnVfEhwPIEKoR1gYNAa71aLH88GfcFwnXm5rhS33SttVtzuPN+wVnjpeS
 D0KAo/s36+Sp+s5+0KgwRU4H9igka3mZJDQLR/7BCIt1H0InyY8D6j9RDqwM34Ooamo+
 3i7kuU8199uYMTRLI/rzYDl0nuPT3DVA457OpgbhQbiP0fBLfOIeNjSbcWxW8atWFge7
 BUhTOZHirPoVseZLpZ6DngbW0gHHtBAcfpiOcf1LTRRgQakOd9wCFY1iiBGGOWld1kSS
 CpRD+Gt41VWxcVRz76FVhbZ8DCsNxdh7nEeUP7QkKsZ2Ig2Xxmu95IpQBsdT1LoHOP4H
 C8GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2pz89NbCn6PsQ7AACrqCjZudt6BC5mR2KTrcIEDJdj7l+qzCJFk05ZtVaz1UzCqZs32psY99mkGo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/N+UumiOyKyoR3zf1BsySorRDQoTWvQ8VBqXXe59f2Yt1HQP/
 mcc8f1hfh9ErJk15Wc/H/JkpS0BAY40NnIzqxaN631tWeug6aeiaWYKGBLmcapImt/g=
X-Gm-Gg: AYBFou2sia9wv9oAexGop3AEzryggMeVynVGQAmym+fWnwH9UIMG/3XBrOyzL0jkrsV
 KCGUUlNiIkcIK9litt7th2sgYYF7wWvvn1fLd+EkZ0B5waaqvnV21dDCTucFWda62mlMrKhyX1k
 O2uh2P3ro/OV/lo6DCshnux7dkcjqNrkC0uJECi2HCAn8R3tTwQfFs/joD2T7bp/8WasBnSzXMO
 yB9Ps0I/nJoL9WSke9w5WAcbqiGxZEsYMv0TTNYpzIT2ITT20gkenCqPPrjD5gnE+iMokZ/S89v
 tl8VLVlxzOE/Kgqy5CyN/DS19UFH0K/QH4qK8K/UpHIn+11lFq0qWDdtU49VYL3VqN6WaOGjV+4
 +1GeydzhyriHKWEBMK9e+x1Ndt3faulap4qFY1AGnCTM1pK85xY5/26swgaBMJklRp3j9KGXD8m
 yry8iYzEvaHDn2LTQm9X/qqMtAUT5ZTp52gtakGnzwmNJBOBHuikLQ9d0ArIIjwglZzGPrLXzve
 r1kc0qkmf4rcXvKE0dGCWnJc7gatKrMGJNNA5fZ88EUr2BGPR4mN0Zalw==
X-Received: by 2002:a05:6820:1c8d:b0:6fd:3c3e:3c66 with SMTP id
 006d021491bc7-6fd3c3e3e7fmr1002063eaf.3.1791985400251; 
 Wed, 14 Oct 2026 06:43:20 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a6dfb4e92asm2073695fac.6.2026.10.14.06.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:43:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
Subject: Re: [PATCH v11 00/13] Add dmabuf read/write via io_uring
Message-Id: <179198539824.583283.3195125120949504062.b4-ty@b4>
Date: Wed, 14 Oct 2026 07:43:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Wed, 14 Oct 2026 12:01:58 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/13] dma-buf: introduce initial file I/O infrastructure
        commit: 0d3120db2cbe0a8793650e19f0923968a406ca2e
[02/13] iov_iter: add iterator type for dmabuf maps
        commit: aeb3bb52052b3548b3acf0cc5606dbb5babb228b
[03/13] block: always adjust bi_offset on bio_advance_iter
        commit: 801503b9a66f7c2423b5e495d8e77e0f4447e5d4
[04/13] block: introduce dma map backed bio type
        commit: d88e44f43e939e6ac0ca8302c6f3c957b33aa5fe
[05/13] block: add dma-buf support for raw bdev
        commit: 839231d193932ca0d592c2859669066f7c43731c
[06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        commit: a03648e2efda070322cd4066abf4dff15be093c4
[07/13] nvme-pci: implement dma-buf backed requests
        commit: ce5e386c110815e3a29e3ba27d97575c28589c39
[08/13] nvme-pci: add SGL support for the dmabuf path
        commit: d5c8cfd41d2575c65c3f1d543017949e578a92d3
[09/13] io_uring/rsrc: introduce buf registration structure
        commit: 727a66ad21b013555eedfd84559cd4707717463c
[10/13] io_uring/rsrc: extend buffer update
        commit: a5819c456b716fa8bcb7792b942ab02b15e07fc5
[11/13] io_uring/rsrc: add uncloneable regbuf flag
        commit: 13b1690bb4767d3f1c847baf71a704c5f2da99e2
[12/13] io_uring/rsrc: add regbuf import flags
        commit: d218f3e381908da0e68429f3a4b764e666564c60
[13/13] io_uring/rsrc: add dmabuf backed registered buffers
        commit: 62e4bf5b25d4458cf8aa9dece9022359f39f2294

Best regards,
-- 
Jens Axboe



