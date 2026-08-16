Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348D9C5CFC1
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 00:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FA910E08B;
	Sun, 16 Aug 2026 00:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RL5AzT3H";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8886010E08B
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 00:01:37 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-4a427e628a9so649804b6e.0
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838496; x=1787443296;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=;
 b=RL5AzT3HA/VYH4H2lexh+wtwq54PFudg2kVWa5ABOAjHyQ8uw/b5JxTXvMxgfUtwd7
 /klVrPnQDz5jvVj2Np/m/1ZomYYdWNorascfDnD5P06r8IdHgb63oSw5U/6lu6BIqCdB
 j0U3Fu4RmcJK5Zxtc/PviNfG33QhkgVYmJkPxYJ2pv+ozrlcyfhzyZiF8xHOWLNR3uw5
 fu+YhXnJN/axhDobvajQFPrWMn9ZTaBNkCu/Sawi/MqdtiGHIaIvmkHH2OQ4fGJA1HdV
 hJ2WDIhWJmeYsJFpKk1zkwCPJkE4yYKl1rK71TMQp7TC2ZsHmqbw2tmzTpj/9OTJd1TT
 vXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786838496; x=1787443296;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=;
 b=gUiHE/rN2PKpIMS86Avsl5ZRDfWDzdhooZP120I1w7PqChyjezNshoDzREdJ38FSs2
 XrnHZjR1ugsAzspkPiyqKzrQk8Wf6NPPDWQxHIRSAyArK2N8m2Vgze0zxZcJ/5NMjIvP
 wltpqO+JlnrOTE+08sR9XcGRIx+yLQblQGMb7CU6Q/p1VS7kz2Hj0RxSwDIxcqtIy9j9
 BLFdclvSA9aobWC9rDMB0hdtpaxqUbTCNgleX6r05xwGoD66iwISdyzpndfTOT1Y8Bz3
 dsZ5EmDcBOZGKyxktCYPQkm73e0sDlHctyAxNdWl8UTpmYDkzYFml3grH34HIIhnDUV/
 QEfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBb1F/s2P0kTQO+bXr4fzhLucIxYAuayPEGaVNtF3IAJLtwelvhtliH+7TiCbr8xwS5z/UscpqwRQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkmYBYfLL9lKceyYp9SuBdTNo7lE0LMs9pcJ8Uixu9k5axrQuK
 mEbwVTCGtNyd8PFfv9jMzSFuoDMBTDy98uxiiZkh6xKkWv7H6xy0XFBfAXuqd/kuzLc=
X-Gm-Gg: AR+sD11xSXS4BeY/bhajqynR/SpKxZnT6u1ACO+uxF1yMClPusTo2WhKctSIFtrzDwK
 f98julFuTzU3+qRxnR5+XvzHAQQOmiQZ1gEaK+/WM6Ce1dIh1mIN0MKEcf6MuDFlbrKSsNd9n6k
 ZZR+RYFtUdAam9dBxiDgZdEUqfVLPp9P6cUeAvbw4pPXjyosnccR/g93b3V9p78yZNdIWycrI8s
 39jLGEElZVUuc+xYHn4TdbEhuCE67cPvx9X28RXD3H9j0SScUqpJSdFEo4xVLiTupgThh3dAutW
 SxWIDsjyS5yETVNrhMDfp+4d5tSbIk90JA5eWeIvE40A2CnWzEP38GhITi616Yxc/ynQI82bTCu
 DN9uxSFfkEJXClUBKfes0YvfXj4PVacmbj9iW5ClEen7+ZvpYnZ19w0FjobWzrrXdjRYyMC6fDf
 D2keiFpHxtOl3fS4Uwm7lcEDhf+Xflum1FVGrI76wECmfxwPt7phx5YLt/Iln6i6YUaVotGdjyn
 epL3YNxCDW+olfwSAa9ueZYldsBgZcbXtZlk4ZkDw==
X-Received: by 2002:a05:6808:23d4:b0:4a4:ddde:5207 with SMTP id
 5614622812f47-4b24198f27dmr12801839b6e.8.1786838496365; 
 Sat, 15 Aug 2026 17:01:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 17:01:17 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v5 00/16] Add dmabuf read/write via io_uring
Message-Id: <178683847578.1984298.10059277109543676478.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:15 -0600
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

[05/16] block: move bvec init into __bio_clone
        commit: e228404b05c8293f6a1286856e49ba3e55da1933
[06/16] block: introduce bio_iov_iter_set()
        commit: 8b8755e00847da1027fe6624277e43d289e2300e

Best regards,
-- 
Jens Axboe



