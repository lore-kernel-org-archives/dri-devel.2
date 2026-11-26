Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD7606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dF0zgYme
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D6810E117;
	Thu, 26 Nov 2026 10:45:07 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C3E10E117
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:45:01 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so4059337f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795689899; x=1796294699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dTzX6/OrqoSYIYFMnL47MVuXS44X2MuyVzOdV4a6oao=;
 b=dF0zgYmehyHwF6WARdAc2AtYjNV4IcfzsWzDkN2JxsFFvZv00gyCz63rNvHoiE25zp
 6hVDYo+KcVJaaoXQPbpN1r2tVojMm1zWtkigSi15s80hWP6L9KRiPBqai53aR1YJiIfv
 kLLD4df23LrgIJHgSvTy891ufTq99Gr+adzgfh8GNB8/gPzoUd3ZVAwpe4XXq8dWP+Lu
 9EINiIvJyW3FHyGx7QaVpEHT4UvagSYFkPsYfsrDEQgvZYDNK/8g/xscIGdLVYZQgGI3
 wliUeYpD3VQSnQN0sjE2j1wkJThW8l7+xHdonVzN08YmQ8/CaRlpRSwXVc+tBfasGLjg
 HkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795689899; x=1796294699;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dTzX6/OrqoSYIYFMnL47MVuXS44X2MuyVzOdV4a6oao=;
 b=sHchK/Q1cYKKSUvw5nOLpzXWHh8K1kPeTzsXtLZRwLgMaPzmwjB8PM3t7+b7bh2qXu
 8XfWwnP2OU+rJbYOoDbX59ipXiN0xPUydcIIrsGhDQjRGoOZ1t1IgfUXAuFO95qn+f5v
 xAeBeCiLSQVx8lsfqPvCXcapGaqF15Vu75kWUKSqtXCH8zhxILApL/jGs+PGILgzHlay
 Jp07AsimcyFB8Vm3xi+nHQfNII9JAFJpoqZRmBOIK/qFP/r7UPCJLRRHT+2MOa+QSBQm
 xB2r84jVNB/OVoUQHLjJi2d/b8qhqY018iZz7bG+pL38WuiuVrYZPBvT7udlO5PiXwCT
 FKvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH0xwCJpNHZ+66mxyCSrWzHMqVih7sDc7saLiIl1Qeritie10P0rp3fNGXfDU3eNBsGuuwFjRSBhYk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/X9BKc4x89/fMLdOoP9sm8iC4JI1Ees0I3+NJUBXsjtWro6hht
 AW4KuW+v6YP4z2fG5PpxQeUHIQsvFfBtixr4Erf8oFSn2w9Ew0OJB32n
X-Gm-Gg: AZFdTZf2GVGRos1YAJTbGl4C8AzGCOKSQVslrZ3WHsBqeSsqj3CwkGLiFfTb/Y2D9EU
 FBhVGpn8eNXmRwkn3cele9Hl25X92PdkMY8ne+lEdE+8tBlFVelyzneWVIXgITB+SY83VjakZjS
 Ae+K1qNxNS0PPn6eT4uQy5TSRG/ZtsxKQmBI3Fd7u/LQWLw06vw+WYDmM64ROPE0u2YFWdD5vYb
 Sqowu/ULSUhBGuIINe36JBnbhjYYNvBgBlK4+meF32KQkNItt3VYRYrQKlih8hlV/3b1gvdh8W8
 NaRp1lMSRRviNFQWpRtO1upul2XC9Ip54XZkGKoySkhDjHxrwh7lB3PREeuWV2+JnDX8lxHV73F
 N8PrycAXCVM2Tlr5Bw3XSIbWPpN+2nvXViiJHOa+mvJoRconnLOFogrEC7lOx7Rd0XlyoGLfvfT
 ms/CfwfWQk/AzSMmrDcB+uTlZ+D0zyJdG1vwuQxIP9Z45yk7sy/M6MC2C0c9I1UxC/YOjaVOeTq
 kb46okc9TE8bcHnj9Bkua4g4aV0d5GlO90R/13mZ+ymJLhWaX0pJqmcKsM+7/dhwowlki2HijZ4
 GAzZ9IIYMcTNO9c3xTOuumqAJXZj0199kkLqGQovSWAFwiHdP5uebRYZyLKB+dhdeVCUnuxaFa0
 6wkxxUCVmNeTG1lOFESIQhiER5RsvUaPkmAPxcC9rbtNr25quoQUf2OOYTrOcLDCFfjx1c+DHdF
 il8WA=
X-Received: by 2002:a5d:5888:0:b0:490:a481:7ac8 with SMTP id
 ffacd0b85a97d-4abb532ea79mr37997103f8f.29.1795689899355; 
 Thu, 26 Nov 2026 02:44:59 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm40898578f8f.2.2026.11.26.02.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 02:44:58 -0800 (PST)
Message-ID: <0b76171b-7f2e-41d2-8a5c-102dbe4cb85b@gmail.com>
Date: Thu, 26 Nov 2026 10:44:53 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] ext4: Add dma-buf read/write support
To: Mengmeng Zhao <mengmeng.zhao@linux.dev>, Anuj Gupta
 <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Christian Brauner <brauner@kernel.org>
Cc: Anuj Gupta <anuj1072538@gmail.com>, Nitesh Shetty
 <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Li Wang <liwang@kylinos.cn>,
 Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
 <20261120154153.GC28611@lst.de>
 <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
 <CGME20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d@epcas5p3.samsung.com>
 <20261124084025.2101804-1-anuj20.g@samsung.com>
 <3bce3a69-e41c-4683-b1ca-9477dd41a7e0@linux.dev>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <3bce3a69-e41c-4683-b1ca-9477dd41a7e0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 01:25, Mengmeng Zhao wrote:
> On 11/24/26 16:40, Anuj Gupta wrote:
>> On Mon, Nov 23, 2026 at 09:51:41AM +0800, Mengmeng Zhao wrote:
>>> Hi Anuj, I'd be happy to help pull our patches together into a single
>>> unified series and send it out for review, if you're okay with that—and
>>> would appreciate your review once it's posted as well. Please let me know how
>>> you'd like to coordinate, or if you have any updates in progress on your
>>> side before I put the series together.
>>
>> Hi Mengmeng,
>>
>> We already have updates in progress on the XFS side.
>>
>> We will consolidate the combined series along with your ext4 work and
>> related patches, keeping your authorship.
>>
>> One more thing that we are looking at combining is the ability to share
>> the registration across files. Pavel had mentioned this earlier in our
>> xfs series [1] and posted a series too [2] which needs some more work.
>>
>> FWIW, we also had ext4 changes, but intentionally started with one
>> filesystem (XFS) so that the common interface could settle first.
>>
>> [1] https://lore.kernel.org/linux-block/4649a20f-aba9-418e-987f-66f21ab24410@gmail.com/
>> [2] https://lore.kernel.org/linux-block/cover.1793751001.git.asml.silence@gmail.com/
> 
> Hi Anuj,
> 
> Sounds good, that makes sense given the ongoing XFS and shared registration
> updates. Thanks for including our ext4 patches and keeping the authorship.
> Feel free to loop me in once you post the combined series—I'd be happy to
> help review and test it.
> 
> I looked at Pavel's patchset as well, and noticed it adds a new f_dma_io_tag
> field to struct file, whereas Christoph and Christian want to avoid bloating
> struct file. Did I miss something, or do you have a different approach in mind
> to avoid adding fields to struct file?

I'll resend it later, how to store the tag is the least interesting
part, it can just move inside the block/ext4/etc code, which would
be uglier, but whatever.

-- 
Pavel Begunkov

