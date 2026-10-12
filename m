Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F4CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC39D10E5ED;
	Mon, 12 Oct 2026 20:16:33 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD4210E5ED
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:16:26 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-82109f51565so870786a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836186; x=1792440986;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
 b=ISZ05pp7e8UlJSMIP/S5OPJixt7xQxW1sU5PuHTpOS05/c56GPI4aQbu3A7U8XV8Qs
 AuNl1Aj0t4bQlbTJyH5E+U3JXLotBiuCjhQstA7KXDwbvejZxcOEAxTzIUa5PGHOWBs6
 b4QDm6qeUCj3zzEQeeypXt3aPapiBy62y3dxBK+iIzRwVk3kQ354VMWRe5uFOue62+An
 lI7RG7R6fCmzqpw2u3WGrN/nd2zSPk2P2K+GgEY93QyMV80Ly6AJDEXQ36tg5Lzb1v24
 An7s7+o4q+acQU944ot2qedqoKiuzFBd+8f50onFiXTCJL8vQbPt33XMADVqExH8aS1T
 igWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836186; x=1792440986;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
 b=LM676eTe2IOMgPla6ICEpHISlIyaD93MDqayOnVnuThxERL2ISJIlovIX7EWUYxILy
 iutjqOFiuBMV2HdRy7wu0dDUPL6nIPZ1iWufEnw0ta7r2JlerWQAF5fo+XSQbS3N61LU
 yRGHBzs2EfP9bcLFtP8edBkKrQyawC1IvAdG2eT2b3B6keYshvcJdpimyyV0mF6KpGZU
 q+iyNAO5tXM5+rtpV2/aRFSy+G0V5do23vessZ6tBW33Ln4fphFe/aHxylzlT/S0Jmuc
 nOr7RXzbEF+mPWJ2VZ085FM9ihDkOGJC+Lbi7tX8qSymwMBRSeU7Ii+5rJe/ANE6NMaX
 MpKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvnQlpJ90QIXJhm5AGQtFgB5x7dgOA71rZbMRi3XBOkDsjAxjTPtwtJt4F4/MoxFOmH7wTGNfDXFk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJufa7VWTpW5jgUo67MssG+UuDWRHFevoWnZEFexRmj3jXwH99x
 q2JrTcNXs+KUM0Bhn15Ma93he9ouonzIrAiEDzt/wRWDqPVwuBu7ICCkO6pGeHcjIUQ=
X-Gm-Gg: AYBFou3OPlLF3ZEi8m9j1TxqmawshwcGo55LEgZNRvAWWZCUptZGADFWZ4ZXBflopm+
 H4IyuHmAscdg4HVgsCYxMMQQOUqipsI98E9Z28NBCNpHuEHyY1a81KjjoinaRdBrpFEMOmvseiJ
 1ZEZKVerkNBA54Kvqfw8qk9jmr063Rnunlwjkg2amyR7RGpQWRZS2mqNUwZXlsvGZtd0yb3WkUX
 sDa2IlnGXuzF19vEccDCdLzLrAV5hbLTpIJKUUgkfLZFI1nwYll7WJW+GH5RPiVbdm+R+KF8uC4
 VkiOZ5mqIUTl95hS/3CFkMDMZ+5dlrS6sGYP2FUZmFEmqk0/avUU9e4gFHF/7XUNTOxQSSvXOXA
 Un8r4Y4e8eZi6t2LidyeCBazTF72M9Ir99b6t+LhGTKK7z3JUypIfbV5Qr8QG0CzeGcvp5TMimK
 JVGJgS4BiUoesEyNn+APewUecOG6p0JRoiJnmAutv3G+RGYpqOvoD+0631mazSYesI0avQC6Cv2
 RSNUO0jBj6sLVz92VI2GVqmoWpFCfZuMMXo+qvL51kEgWKAdCxBhUjx1Y6moOTGT4ZF
X-Received: by 2002:a05:6830:4104:b0:81f:92c9:1f80 with SMTP id
 46e09a7af769-83095b2dcfdmr13038337a34.16.1791836185941; 
 Mon, 12 Oct 2026 13:16:25 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039076d72sm10441653a34.12.2026.10.12.13.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:16:24 -0700 (PDT)
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
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Message-Id: <179183618332.250226.7412463798702866633.b4-ty@b4>
Date: Mon, 12 Oct 2026 14:16:23 -0600
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


On Wed, 07 Oct 2026 02:42:43 +0100, Pavel Begunkov wrote:
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
        commit: b899f5d8a9594f3e5be7c481e4631521f0a6e42d
[02/13] iov_iter: add iterator type for dmabuf maps
        commit: f41f84796a1129838524d2aa542598c22822a2ec
[03/13] block: always adjust bi_offset on bio_advance_iter
        commit: dda48c57e1484f967727d827923d3fb47d6b8aa3
[04/13] block: introduce dma map backed bio type
        commit: dfc9cc23122deeffcbf562a0989c695e8505d54e
[05/13] block: add dma-buf support for raw bdev
        commit: 738881239a914b2d92cafdf1030c382f1614a293
[06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        commit: db93ee31780323044eb5d6279d89f6ae49493f39
[07/13] nvme-pci: implement dma-buf backed requests
        commit: bb3e58f540e95ad55bc7ba6a6f713f79b4e79e7e
[08/13] nvme-pci: add SGL support for the dmabuf path
        commit: 3676bad01d84421fbf8567edafac63bef9f648cc
[09/13] io_uring/rsrc: introduce buf registration structure
        commit: fa1925e901c00b00695edd29d053564a6de63d9c
[10/13] io_uring/rsrc: extend buffer update
        commit: b497df80ba7536cffb2c5364e725c0812135886c
[11/13] io_uring/rsrc: add uncloneable regbuf flag
        commit: 10b6521fae14c5941b3fd77d1a48eb7a424ee487
[12/13] io_uring/rsrc: add regbuf import flags
        commit: b5a1e426d22fa059eaac1106292ad60c8da52d17
[13/13] io_uring/rsrc: add dmabuf backed registered buffers
        commit: 4bb797852328975051b001189f3e3840cfaad2d7

Best regards,
-- 
Jens Axboe



