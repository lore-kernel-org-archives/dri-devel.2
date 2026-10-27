Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88F606A326
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oX4gxBvx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F7110E1A0;
	Tue, 27 Oct 2026 13:03:37 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B7110F487
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:03:31 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso7465852eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793106211; x=1793711011;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ReSdqMrGBGnsTnwVh5aa3vwJIfFSFewN0arb4MIegpw=;
 b=oX4gxBvxiEQLtrh4EawBE/YMX2BmJvvKXk1yhMUhJc6n50pjOonCa1aI3ld4SPfR1M
 lPIgKnSdsZIc85L16s3uCXijIFlrkdRtGPh448YPSRIcHN8VqVMI9f4A31cqNqffD3QT
 06b5N7YoxXbwT2US8dbWJ4T68YA9fTzQ1qrJ7XV/hKR7rRjK06HoB87SYFRiHHutsWlN
 BHLpdDmA3RXCvNK+3SyUaRZpP0WxKKhZl7vnrcCWet1WnOAdDM4xVftZi+qsgh5p98iK
 oHXPHCZdxlyYCs8RhO3YXOPzdBwI7FPzrS1intBZzT+AAQHPUktfTJN75kPqgnsAj+nk
 ufwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793106211; x=1793711011;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ReSdqMrGBGnsTnwVh5aa3vwJIfFSFewN0arb4MIegpw=;
 b=Tob8ZTsT/LCsTIGdJuJQqvvVHMrOpjhxd9s0z90QoNpw75VC6NKrmUvRiej+9WfRl9
 KQwKhuHUna+kXGTCmz2sqeF1TaCupJbIfHzKAhuyWwGHNpR1l1AMWXKpzGjTCGYtITFb
 /aby4sgtvBxMu17U95JaXDL1v8bBNxVH5h5XMGQZWIeZa6hLyUm/9jlXCciqL7l/2665
 WH+5MOvIgZiQb9ajT4purm5Ojv0mYSJ8TUaAPiQr2CMAbY6yHnmVhmgyKF0IXY/k7VcK
 hL0nsO5IIqNMaq8b8rBOcQKhSKHw58jlNkbk7E3lvAJlqWcSuYgZhw1PTm0WMS3V8N1y
 /K2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqxnrILpbFLKlZPVFhthnuO99947GcxMQknl3ft/zPS0FSQ/cd5SYf2EE8S9zVkm2Lt6kMA9034Z4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJd13FFyibh5ytTLQ79Fz78AvAfFinyzN0xSUTjr+rBno71V9QW
 BN7q5Lf2/S75VjYa13RnUQnXLEsb7rsXQ/iIxGel3HBtwUrX7Lhz4tGXQg+6UlW6KK0=
X-Gm-Gg: AYBFou011AH5+1pBQ8hW0y5S1cBDZ9J/dDuhBe1V6DMyMS/vcKIneYplHhtVQtj7RQY
 9sxfMX6BfK2IzIZMuopeBJbqkZ4PeVcpd6iLn4cLJXYB7fNcNpCbtNgxUhP5petNIGop/afpt8N
 8Qr8aOm8WIuELKQ/k1pajKXl7OWMYeAgOpuON1wI1bR9BG1X38oKMbv6Qpbe6skAOs5AuFbWCnh
 Dc3VVtGjt+BR02Cy8NgPDrEkdoH+bpVCAnsBFqd1QE+RKkGQDPgODVIHUyE5qP/0nF8dnyRnLGH
 VurWLq5KwH7C/D/kuUAA25StyI+JzF+RjnfiM10fxJvpDmHRtSwCMuBhp9C5rNk78wpmgikQcem
 XqpJ7/IvdjrSwP+ugmFt2tx3uJY0vtTG8ZE4mmEO0LYEXuMLFet1YSh1PSegVvRQQb+zHcUhlaA
 olzgcg7wy8rkwIaNPsO3Zwtc3TMUbrFstVoHY+wnK2sa/3IMNAen742MYeNZX8QOGab34n3nKqD
 kUP5vhhV9kiQVZGzEex+kfLkCkg6EmN6jW95CyzBxO8/bmaQe5eKIWLaChEsSsJb9QFKZ3VgG+C
 PgrOT3o6BTI2ya7RATQWbXPAft9MQU7nLswmMqM=
X-Received: by 2002:a05:7301:77cc:b0:36a:168a:96c4 with SMTP id
 5a478bee46e88-36a168a9865mr1879705eec.1.1793106210431; 
 Tue, 27 Oct 2026 06:03:30 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm46576346eec.19.2026.10.27.06.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 06:03:29 -0700 (PDT)
Message-ID: <f92baf52-bc4b-432b-bc0a-f39f59483805@kernel.dk>
Date: Tue, 27 Oct 2026 07:03:29 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] misc: fgds: introduce GPU-File direct I/O via
 dma-buf
To: Li Wang <liwang@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <20261027090853.30099-1-liwang@kylinos.cn>
 <20261027090853.30099-2-liwang@kylinos.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261027090853.30099-2-liwang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 3:08 AM, Li Wang wrote:
> From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
> 
> This patch introduces a driver that allows moving data between a GPU
> dma-buf and a regular file on NVME without staging it through the page 
> cache. Userspace registers the GPU dma-buf with the device, then issues 
> read and write requests via the device's ioctls. Each transfer is direct 
> I/O: an ITER_DMABUF_MAP iterator is passed to the file's read_iter or
> write_iter, and the filesystem's iomap path submits REQ_DMABUF bios that
> already carry the dma addresses.
> 
> Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>  drivers/dma-buf/dma-buf-io.c                  |   3 +
>  drivers/misc/Kconfig                          |  16 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/fgds.c                           | 506 ++++++++++++++++++
>  fs/iomap/buffered-io.c                        |  11 +
>  fs/iomap/direct-io.c                          |  23 +-
>  fs/xfs/xfs_file.c                             |   4 +
>  include/linux/iov_iter.h                      |   4 +
>  include/uapi/linux/fgds.h                     | 124 +++++
>  lib/iov_iter.c                                |   1 +
>  mm/filemap.c                                  |  22 +-
>  12 files changed, 713 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/misc/fgds.c
>  create mode 100644 include/uapi/linux/fgds.h

What's the point of this, when you can just use io_uring to do
the same?!

-- 
Jens Axboe

