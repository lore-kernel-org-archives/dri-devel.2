Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A00C79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B726B10E326;
	Thu, 10 Sep 2026 20:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JQ2HgL/Z";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB08010E326
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:55:25 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7f4e729368fso238032a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073725; x=1789678525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=;
 b=JQ2HgL/Zsyp7YQBogPdu+per4SkSkbULRZ+WuGSwRo9QFseaLOlTQcwGZlztPSezlF
 l2XS9IKc07DJfDfkSStgaHii5Z1xfVASnMikrBzrcwBCySL4JnpXa3aOI5JvlRlBj5BF
 P56d8C1Rt4+sBUWEjh7p+6YHl6xj5JvehnAQPGMgck7ClhjJQQcy69FmBKxsbnGWp8kW
 nPiUeZXtEkEKV4tiBfdehyA9sT1gx6pTYvguuVSwFMa+24nxdDFo9FITkqIQXM/JjZOT
 OFUCUWRI2XyS4cEbibqucBDeZwrtzndtVOSYXWknyzspvKY/VwmDmBLy+sLbRpEDNZb3
 iwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789073725; x=1789678525;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=;
 b=XF1ZzDwbz2dZH+aPWjqfo19P++xjCwZR5T7msDUX5wXUaprW+3sV65zvw3Pj2HwvtS
 AUdfYZMRXNrEFIVAyS5KxpCtQCcfKwiQPMZw6EpAntBC0S/0pBufD4BDhuUR5lvjSnnV
 DrMu9zdoHJVCZByuvFETR6dk2xtWZ4bw+JBtaOicQVMNGb1bxp3WWI1If44v2rNHooB7
 92x3zqKBBwQYD6GhnyFpA9iYl7M7xqqjVRZDJUsLEvTH3e2U9vnbC6HqNLb9HAWjcuHL
 lIVRw+s8xQboO6VYVNSr3zSpWB5w+bmjxFmWsezAzGG1gVCRmXa6otbpZ/w9xX+3kMij
 sWrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLZpsGm59KJYsHU7u+sd981T1O/+XN6qM+DVNpbiToMk176AzESnFz/P5GbqLU3O/d+B1HlXeRQts=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l0NRbKFWmhDdEldDjfHGzxw+q0WuMF6DS3sSzwf4zajrJyaUbO
 3INAlNfS22P3Zm+D7mlkXy2LDRodumhgQ+1HR6kOyuxERbugsBDHMT/YzpzzVzDR4hA=
X-Gm-Gg: AYBFou14yLdLDMsDYm9BrJh1qJErM6tar3zvbKkPkQYODcIc/UnAwMQk/0OcoQkB14N
 ZQ/nBt4WRlP0zO4BpByqSjMDg+kcZWoJgQifAiea/kJMM8ssGKy4yZi6c4Brb+Btrk4D+ph1Ph6
 DXtM0htys1HXZdVQ6PrYUnNjNN+z+E4VT6/Yyh3NVl7mC2pPqkY0G6Z05nwAvekYKpl48oOWzoy
 VNmktl1aGQJnAKcW9PpCsYfLItYNtzwP07+7ZmgLsD3M5cOYwbj/saQV5KM4mnwX3DvnyV7tg69
 U+mgmW0uGxqENVoTXMblSiaJ070Wee/255/wTyqDXd5ywoQmKJ1OAfMC+EfQe/yZZ8Q4mRQfcq2
 nocS6F1Cuo8ltbvl3SKVsNNhCE/2CkzhFOePGkeaMBgwFb3S/Ac3w/SGtCwgXPPnQgiujcqidP2
 aIaShhbOf4Q5fJSMH5TvcfQJ8SRKLd7F3sXflHQBFcInw205+ApgaGDfy+N19TmTykw+zxoXWqw
 Ui3MpebF81CZ28co0AbzRiVXpPRxQnMC27hqCrLWWjlo46e2to=
X-Received: by 2002:a05:6830:2702:b0:800:d883:997f with SMTP id
 46e09a7af769-803fec02e59mr471619a34.2.1789073724704; 
 Thu, 10 Sep 2026 13:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:55:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Phil Cayton <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>, 
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
Message-Id: <178907372259.484803.15807864431748251506.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:22 -0600
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


On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1]
> (from where I borrowed a good number of changes). Later it was brough
> back up to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/16] dma-buf: introduce initial file I/O infrastructure
        (no commit info)
[02/16] iov_iter: add iterator type for dmabuf maps
        (no commit info)
[03/16] block: rename bi_bvec_done
        (no commit info)
[04/16] block: always adjust bi_offset on bio_advance_iter
        (no commit info)
[05/16] block: move bvec init into __bio_clone
        (no commit info)
[06/16] block: introduce bio_iov_iter_set()
        (no commit info)
[07/16] block: introduce dma map backed bio type
        (no commit info)
[08/16] block: add dma-buf support for raw bdev
        (no commit info)
[09/16] nvme-pci: implement dma-buf backed requests
        (no commit info)
[10/16] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        (no commit info)
[11/16] nvme-pci: add SGL support for the dmabuf path
        (no commit info)
[12/16] io_uring/rsrc: introduce buf registration structure
        (no commit info)
[13/16] io_uring/rsrc: extend buffer update
        (no commit info)
[14/16] io_uring/rsrc: add uncloneable regbuf flag
        (no commit info)
[15/16] io_uring/rsrc: add regbuf import flags
        (no commit info)
[16/16] io_uring/rsrc: add dmabuf backed registered buffers
        (no commit info)

Best regards,
-- 
Jens Axboe



