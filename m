Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB78606A332
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=oVp838lb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE4D10E47F;
	Sun, 22 Nov 2026 00:49:30 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694E110E47F
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:49:24 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-33fb4680717so5870209eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.dk; s=google; t=1795308563; x=1795913363; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HB4GGGiTx/77gkcgbtZkvnLnAdHz3bFsq58nhMt/PIc=;
 b=oVp838lbMbT/cJzjtEqJIMKWWLvki+rbVa9GtG77Bh8ONyCPuEcpIerKQwkP4UzxTG
 xE4X6IPbcIoPNO/avGGb4RZJP8KorFgz3fa1fWBdAHz85t7dlJymJjkMpHaClv+Ckl0G
 8j4NnD+IiT4doYzncZdRf2iokom/OJpf53Bdlye5qz6iF+gaut+GCYw/v8Vfzq0gx64P
 BgG10Xh6DIZMJv2sgSc+YEaVXas2ZpWd2/OfIrXbW5UEAxGfB0uTRBevAHYkjYCbR/3E
 uSSSgCWjGxDZFRv+vSXaOqf9iPYbNo92nw2xo9DoNCNBuwG1iZB2KFHt7cFGT2S78nAT
 sEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795308563; x=1795913363;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HB4GGGiTx/77gkcgbtZkvnLnAdHz3bFsq58nhMt/PIc=;
 b=kks9R1gz2SVE4jyBIUk0nkUr2hH+4biy/d1ks4PLWmWYD2YrbWRuj9o3mRFxsVUInO
 ZveSQ7A2Xp4rbYvhl3XWT+QZ7m+4JHg8OAmOumRAwj1jTjeqUNxL2ca9Rg1/ac2v5blz
 O4ghHjkvc8+dQoAeNoaNz/O5Nys9VUJ1H4UwhEdoI+k2s80psbsBh+i9uBepopmNKl8I
 y1aZc6C6j9fhQXtWlrfIxhYGj8ZVIoe7RxmFOeH7RBlwhLBKItr5fEHYlHGAB8NaSE6A
 QIsnbmD6ucl3oZW+luFZ8LK5zYOGtHxaf5+Oyc8BEplDg7inRzdVRDqtlW2F6Bld06Xt
 Hn6A==
X-Forwarded-Encrypted: i=1;
 AL+hErEcvPyWj9rCmUlHPpdjNyIQwuwHRXbdTUFBW+GaZXlXdBfQxk3ept8+d6ygYsD8cnovIMCrB0w5W/U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gvjSInEfSGEX/xUhXkU9vZs9u/0zAfyuJ4PutG4ZqVs2pzaoD
 EjbdV3Py8iRtegYZO4QO/PBK1D1eJUNgR+ZMdk58wQYHkkCwERMl2bAanvWUFIW1O+k=
X-Gm-Gg: AZFdTZfIS0eEvYQjZ8rNWSPg+WonFALIMpPqfAvO7G0csLFw1ZE6cAcQW0+g+oBzlGu
 DMtvVgYRNUtYx1aFrM4yNUHCmKEyjwoVH/7x5E48mJnUuL+V6L4O/w5eKqot/4LrbpMBUKORfri
 KxFplTcg+FS0A6qCg62uyMl284LS4xBCl7Tv0WgtuZy8dkQK9GLE/W6NR2LSexlafXJ3fMRfh10
 uGnJ0b0gbm87Kce45oA3ddOHY6daiuz1x2agWs5AuOyLV8mjdn3G6EmGMTg75JkbrjQ1Av/KrIc
 La+8gDHLyB/g/jqshFD7TLYUXqpIenuPv6zcJhJUjnbAvBqYWE4JwPsQK5ueAaEipiM31pyWQrg
 qdlcW3+RE/Klf2YQYKDLnTuPKUrMXBAUzDoB2f9I3m+ZQKShkWNqU+70vx1azPPhqOOZ/+6TZGD
 NVNk/LB9Cklb7xcEwVfhVZ0BQEizdRyCw7tQMvbSgFaXR9v2irVGfRhzMwLkyqqrXhjy9Jbn9JH
 VNVyWkfru33W2eYNtJ5mnoixjhqtmhm/rP9lvE/ig3KYKOwexArvx5xJdt8eT0Zeewg8K3EkypS
 uYrPeq5N2NFSDhgUloE7NSQWDUYtimp0j5N2tsuChpR/gQJkstce5J0uaZOyun44z1CEnQixdbe
 eC0ZrAUMwXdIzJy/3onpvdNQo0Yvrm6UaR4sLIkffBUungtkQ
X-Received: by 2002:a05:7022:ea54:b0:193:9aa3:474c with SMTP id
 a92af1059eb24-1b56d7cf637mr883791c88.21.1795308563262; 
 Sat, 21 Nov 2026 16:49:23 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm17621494c88.12.2026.11.21.16.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 16:49:22 -0800 (PST)
Message-ID: <35aef1da-2277-4d9c-9bf4-cbc6094be4cb@kernel.dk>
Date: Sat, 21 Nov 2026 17:49:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: fix leak of ctx and dmabuf reference in
 dma_buf_io_ctx_create() WARN path
To: Falconet3 <Falconet3@proton.me>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 5:05 PM, Falconet3 wrote:
> (leak of ctx + dmabuf ref on the WARN_ON_ONCE path, new file in v7.4-rc1, patch attached)

Please see how patches are usually sent - not a huge deal, attachments can
be applied, it's just a lot more inconvenient than a properly sent
patch as you can't comment on it in email. The bigger issue is your
From and Signed-off-by - that needs to be a real identify, not some
leet handle.

-- 
Jens Axboe

