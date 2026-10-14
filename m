Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A08CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B9A112181;
	Thu, 15 Oct 2026 07:57:13 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DE110E32B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 14:38:26 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso1316992a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988705; cv=none;
 d=google.com; s=arc-20260327;
 b=W8V6zzXKHrg+EvTTNmTK38GSRAIAfoQ8NZCYvVdcZpzvhnLn4zBszuKZDlzqypp8Eu
 KLl58JiEDUT3V3BT3ZNCsNB/ktuPa9mi8etAzNk/s7OHF4X5yFt3kHswSaAmeupDgBJ/
 yg+1jlX+02dDGwrmgTy4A33Cv8sdnQMm6aQ11uJmRJO0/EiRd/ksc85HB3HX3bmw7K4H
 bzLGP2jR8UdPZdBFWkRs+4dEYTf8lM7vpGfZGSglvEcUw+R2OKgVZXrGOxbftXrxU16j
 /tVSXH6hSHphALYqImORZFbwlLqUueqKi9TQjON3Uq2NOE6XIMXYDDK2vH5FZl8jdKNk
 H5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
 fh=Xx32ESbqbgCCxn/U75+w13ntG2mqRS5OnIZeklkIOf0=;
 b=bzhLTFSwjPheS8gh2p3LMBA533oyccRDW1+YaOaHBO2+0LyHePtPExpysWJxWHBpzD
 hWItL34PenshatHifHXoG08w60ooS8Df4HCckjN62NnrzZbzVLUBqHYv29usVQfnZc2F
 uvfNIn4kbzGXCAAiMDl6tovu6XSRGCGpNEqMnJZeHNmZYPwV8Zq1FnLyLzqT6/yFHdhh
 9G66SmbkM0h0kocHNQXVUQdeyUqm+vV6443xZFqOYgfjI0EB0qHYrBD4EDcrgzGi92rx
 8teNjTfGXpCpHLX7EyXrLbtTSN4Bm4f5z5KHN1EncXKP+8tHiGcldrJiagvWz6FdXmc/
 2Sow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791988705; x=1792593505; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
 b=nS7yhThxRqhK+0uDMxYnvEfQOff7a1JLd7DH6asHxYNwoaMM+/WlCsC8UfWdySuyON
 aDthKcsdkmDxCCFUOqv+3fGMKdNg2eqO/2B7u9aVBwck1Gd8L4s18RMrxJG9zYDdCSwN
 EeonmpcAxVNePAOGJDphu66dsfbOE5Limn9q4D1CoAAz5vD+u5G05+N3mOR6laiuWoBw
 akpDrm3crGDZcUsQAKjgcVMlDuLwM2SS3+UGSR4UsgJYgOC99g6H8u9olleCofDkbdxo
 W69AoW8tcHpd+EGVG0mqsnxcrEUDeqYWnvNoJgGPVOABS/oYdIUHqXCpL78HJdBxfnRL
 nAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791988705; x=1792593505;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
 b=1lyzox9YaJ90WcFstE1DRsk+ABTsYmIo5+GoaEEhUAOWC6g6n8IqQMaa4GcidnDnSg
 mx/UXMlrB45phrpgoBqZlif9VcaNp9a9BGUQHvZAELxMXg85DnYkh7eVtrqRYz7PeVRG
 I8rVIRaz0UNyMEcxy93YuGknvf+upocWgIWPHDnPiXYR9mdsFBebcY0mNyJRoeInYVMG
 fEyd4h3hEmzRYs72i8vl0sME15VGEs/LDEG3NccXxm0+3klorvCmENBkkSrvMVOPYK+g
 MNkVCi41ut/6ZYn6/uFsS8aQxXWGJ5Toiksk5i/y0XX039VQcn8uo7xuCqxLILVJpqD2
 M3Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyEus+abAsxQHxvt+lJLadv+H7YJUrzFadAhWWhOVrCxpYFbOajjQDGCes7elUgJMTvnqTzZibMRk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLELqN2c5fmj0ODYGbLgaItQm1+WkSA22477ZwDht6epyBIUAJ9
 8MwsqWMRCbFg5gdkwJ8M4ytQ8xb0euOLxCMcFQ4DX5YA0I24z0t945sgETpEiewCV0Pfh+zRWwp
 bxCa+45hfRe7AdeJaL1DtN4eR1kr/aA==
X-Gm-Gg: AYBFou0KcyxMY/27kl4g+CusYcwd625pLcSc4T3wRKXv3Z4VjLLiW1aS7igfbfGHaV+
 TCSqzaGupeTl5Miht/nvRHXxCvkqrLSB6mIYOLoa40qOeGRKq+xGe1FcgXGpMzpjV1hnAG/tTg/
 t6KdMTqXYn0Ra0a1oBX8LC6mMDyC/BgX1LkSKHzdR8lWXKppCR/iHxc6Qy+tRCM4dawZ34pQl7V
 pdKu2NJqOiCE6ZbGzZsma+x3ifBRZ2RevD/C+v9OCsOWPWQX5u+n17LEPkmvm0zSgVJZ4Y4VLan
 5rKQa42zWTni+pIyoFgrfjJlHRiFn4o6fisT1hQVvuylP6+1ThxzZlLMcT8zc4Wv9pabkYaJk7m
 t4fxhmtzrybEQQMLAydDCtbgQx1Z8VbKaL3TCMWs=
X-Received: by 2002:a05:6402:1912:b0:6ac:b9b5:8e8b with SMTP id
 4fb4d7f45d1cf-6b17c2a3670mr12616709a12.15.1791988704432; Wed, 14 Oct 2026
 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1791975048.git.asml.silence@gmail.com>
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 14 Oct 2026 20:07:46 +0530
X-Gm-Features: AclHuK8DZ9QwF2AgJ3SDr4lT4xl3Cf9evBnlWqjNFK8bj0mT2h6JXCYZXSbhb_A
Message-ID: <CACzX3Ases=5auovox0XFNheDHY9iNmxv2BvB0dugC-W3mnjGLw@mail.gmail.com>
Subject: Re: [PATCH v11 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

> Tushar, William, Phil did a lot of testing and experimentation on various
> devices with previous versions of the patch set, and I've received lots
> of help from Anuj, Kanchan and Nitesh with investigations, testing, and
> patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
> showed:
>
> STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

I've been involved in the development of this series, so I won't add a
Reviewed-by tag, but I tested it on NVMe with both an AMD GPU dma-buf
and udmabuf exporter, using the liburing tests and custom fio plumbing.

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
