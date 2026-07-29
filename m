Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD98C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0507510ED46;
	Wed, 29 Jul 2026 17:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVFNeosq";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2A510ED65
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 17:46:10 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956242332dso10966545e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785347168; x=1785951968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=;
 b=IVFNeosqFvHnAdM+pbk2+IYWfA0C4udKh+EW7R8MKlmMuJWV2vEidN8j2JsGW50T2t
 WtJsiqDkxScvJsntdut7bDeCoShY4SnoaMTGIpS06gdaSTRZaZx7IVYDWqX1IkQ2UnKp
 HfBxEel/HTBPfmsNUz6RgZH8TuCJNyywH//5PCO2kw/Ubgg6lz0JrFbBsbbcytxpCsai
 nVSHiULaldOVoktalSt/0+Khb9dPyO9uLl48Ys9ftZc9rPBLXoOYM7q+Xnv6N8g2FpCO
 nSbJ+3b3VaR7J1enKSaC5fHC/BiI2iunEVhJtuvNt38aqywOLuHPNi7ZWFWNOAE8B/9O
 I/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347168; x=1785951968;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=;
 b=M8ejld4Rvn9vWLM1KQp2SHYcp+/TZa4KCJwig+WMI2phtrpZGWN6q60dJSZ5+QHmwc
 /Lxs/MU+qpDnTPLUX2sMieua6cXDnSgW5et7V6dYXm0tnhro1cq+ofo5Z5/lIjX4BxDN
 on5ZVtvIm2D0xibYsA8jFIY0Pla4d4/pfvFGo4EnhLU5r2rkJz4O3kjod+26c5gnz0Q2
 2NWhmiNmcFjR/AiMQN9mq8QO+kc2C9iEnmcFFogO2jtQPXdoC1s1wrwdH9hOp8pRjXwt
 ThpTBKet7Gw4ZPvS806D+CZDkaK2Z7Bb2PU7vVYoaE5DJSwMPi+3uNNSKrRSgmsbrWo4
 NlHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFwjqdZzGjVR63HNhxSXjnWdHWCbhE3KQEv7ctP0EU42quSBffRzbiqzQY29wpJi/us96S2BKLyq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydwIWOilnIALt/ZrGc979WFjANp2d8mcGyrZkD+ng/IMV0mr5T
 q1ZNqaqcsmSRAngUFc+Im8L4eUZW+xZPpFlG1/gJ4v2fH4zt15/81N87
X-Gm-Gg: AR+sD11nJLhoEZgmMSILv5c3MOZEklVnGbzIX8exAOabHy/1b7yi6by5gdqf0rP1JW+
 QUO+By8mTW70fsych4YteKtzU5r7HINyXJeOEqiFMWSoHLqjSMvpu4g/QavEdVtMF/dxkuPnxxF
 jTyydIgzj4XGBGM2DCkxSpEXGkGLwBz6zkefS3EvUnXUzGl9O4AjLikDJpuYGLNPkCJLqFCt3Ok
 M6f5Phw/txgCwdNHeWgRIw7PufDbdUC+4qjkghHrDmQjWdBHN2wL0I/C6Rrn4cwXRntywUN8JP7
 Bxcdg4Kn0fWAJPbTGL0y9fjQmk5SyzOwB5O6reK2a7SqwqNcnFXUOaSboygENMtPJHtGweQ4tUz
 vr0ZryT2JztM/ubGNR3JxmKeVCsZSPK8MKZZ9dH8TS5LyzgVQL8I2rPJv0BYiRDHtMDet49KvkA
 ehcPXD9ITZRYhqoCxTzoCw+iCRoZe9mw7a88wJrTJN+FKNYaskTbDDrwiePQp6PCLqhx0bEikCG
 f2Lt4wmmsU7wcXokkkVBOQxF/WTX9Dtw1RpRXrZWoaTVlDt5Sw2/tzC8YhrizVc515f0YOQq5Ol
 6XUODl/gCnQURGPvzpk3XXmxV6WytbqDtVim8ok=
X-Received: by 2002:a05:600c:4fd2:b0:493:e79e:da6b with SMTP id
 5b1f17b1804b1-496c6590660mr98300165e9.21.1785347168019; 
 Wed, 29 Jul 2026 10:46:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b1c2asm171605965e9.5.2026.07.29.10.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 10:46:07 -0700 (PDT)
Message-ID: <5afa3726-6c15-41c8-af19-766eb76b4b46@gmail.com>
Date: Wed, 29 Jul 2026 18:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
 <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
 <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/29/26 17:52, Anuj gupta wrote:
> On Wed, Jul 29, 2026 at 7:37 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>> +static int io_import_dmabuf(struct io_kiocb *req,
>>>> +                       int ddir, struct iov_iter *iter,
>>>> +                       struct io_mapped_ubuf *imu,
>>>> +                       size_t len, size_t offset,
>>>> +                       unsigned issue_flags)
>>>> +{
>>>> +    struct io_regbuf_dma *db = imu->priv;
>>>> +    struct dma_buf_io_map *map;
>>>> +
>>>> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>>>> +            return -EOPNOTSUPP;
>>>> +    if (!len)
>>>> +            return -EFAULT;
>>>> +    if (req->file != db->target_file)
>>>> +            return -EBADF;
>>>> +
>>>> +    if (req->flags & REQ_F_DROP_DMABUF) {
>>>> +            map = req->dmabuf_map;
>>>> +            goto init_iter;
>>>> +    }
>>>
>>> O_DIRECT is checked only during registration; we should recheck
>>> (file->f_flags & O_DIRECT) per request.
>>
>> Nobody should be able to clear O_DIRECT, unless I missed something?
>> And fwiw, io_uring wouldn't be the right place to do it.
>>
> 
> fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
> open fd succeeds. The consequence is that subsequent I/Os switch to

Very exciting.

> buffered I/O and cause silent data loss. Something on this path needs
> to reject this combination.

Yeah, I'll fix it, thanks

-- 
Pavel Begunkov

