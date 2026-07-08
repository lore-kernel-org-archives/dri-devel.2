Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CA8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD28210E5AF;
	Wed,  8 Jul 2026 10:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M3akJEj8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834FA10E5AF
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783507815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RthwfiaiuQwFULsU9rLR+4p2hP6BkmVyKgFOz4tjmA=;
 b=M3akJEj8BXkizpmrP+oShItOKayzlTdO0Ra42jiCdnwGLP5IsgxwsssBoivvCY5qYRNdjW
 hOrBHfzMTyQu0Ry/eGhWV6P11mObrzrZY7uq/jvkIrt+WxK/HEKeEA6YLFiYhDZcqiIl3g
 eryO5sM3ldLHLPAcDbZGimAs7qkmY9A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-aNdjsvB3P5SeqtdaeRoqvw-1; Wed, 08 Jul 2026 06:50:12 -0400
X-MC-Unique: aNdjsvB3P5SeqtdaeRoqvw-1
X-Mimecast-MFC-AGG-ID: aNdjsvB3P5SeqtdaeRoqvw_1783507811
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so7259825e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 03:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783507811; x=1784112611;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7RthwfiaiuQwFULsU9rLR+4p2hP6BkmVyKgFOz4tjmA=;
 b=b8+8HQ3wQQjlJ60UBhPUWEbzVEQWuVlrj5hr0vtmFNhmy0ky5dZNTV8HJ8vBn1cEOM
 tSVLe/03VKTaGj7jJmMp9/sYnnrQy27UpxpUgl2ZmP1kCjzwRP7EpP2CdpcJFReuXBUE
 Db3DuTSgzfZhZtJ/uozcyCCZnRm9MMmRpY1fHTH44OSbPiJ9C0yJf3hvHtHpppN8d+8Z
 emd6FS0TOHj4bXtI4+c/09rztjSrVMAPi3hYsu/8/wC/f3MX9XcAquha5w9C42+S5ro0
 JQzRFKFV2E4Fp3jeUx05kA+nzz6b5R7fseK/EtlxPqNY0UOSl1Oo62r2kJcwd/GTR5f7
 eJKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI8L7n8l3qgvBe5vAtmPGZgbzRNF3LM0fYSK4bQa+3+lhwmWM6HDg4uX3LoiyFll289eZNNkD0gEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXQW9uNSxxEVLK2YClix2YYVIRcPyYmI0PnASDLy56sIsXGhDl
 CsxU0NO7F1s38QtP0B3s2LCrd+vfiJ8ShCNbIyb+dAy0LMt+ldWgdWzh+3BbXfdf3vt8nt6GRrH
 NHC4nD6nM0RxLdcUR9wIB+gpS7JqdDI4LSfM4jdQqrmxTDilOQme1X7S0Q4DkJ2watwu0Bw==
X-Gm-Gg: AfdE7cl9i6HPgVn58nuDy/yJXTKLwkx4d77oOK7L0W0wqMWMkD3tCofU7n1vluYPdYC
 lZYGjC3PQLMeMU63CWen1f8/qmlklR7JKG9nlGn6LvWWxF1HLG7XY0xFM9Gk2TAJq3qQ2blB1nV
 6UMf1BSw3+dyvrOqyPejPUNSMhqLFlsnla9KTkP1YbX5Fr+uyPcrQIRZkXZX/PQ/NImTuuyTqLD
 N/2qVf5rAf4dWwstj4lO2N94Uz+Lyzyd1slkAHpdSby8mXbkCC9qFRJAJgUWFr871a1UfTXKeCI
 eq2yyCYiWRrX3F1czo0w54/tCN6ssq6vMCpNFLQTIo642mygjsHad+H7zVqiVqpU19uLhT+ztz+
 UdXak9MLByUJVudR/XlDRpD+h5c2b7l+o3XNqwOzSYOeIUnPRDZUTj5qCoobyGzsUb6+oa6ATm4
 j9HjEdZgJBqK04
X-Received: by 2002:a05:600c:3b92:b0:493:e892:f03c with SMTP id
 5b1f17b1804b1-493e892f05amr3891685e9.10.1783507811115; 
 Wed, 08 Jul 2026 03:50:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3b92:b0:493:e892:f03c with SMTP id
 5b1f17b1804b1-493e892f05amr3891245e9.10.1783507810639; 
 Wed, 08 Jul 2026 03:50:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d?
 ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f40912sm123922735e9.4.2026.07.08.03.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 03:50:10 -0700 (PDT)
Message-ID: <15e72c82-ca99-481b-bd53-744fabd503b0@redhat.com>
Date: Wed, 8 Jul 2026 12:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
To: Mina Almasry <almasrymina@google.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me, razor@blackwall.org,
 daniel@iogearbox.net, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
 <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Se7yq_rdbEGGyBiiGGxgxcNCUYz9Njby8hOQf3icJB8_1783507811
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 7/7/26 10:36 PM, Mina Almasry wrote:
> On Wed, Jul 1, 2026 at 12:22 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>>
>> From: Bobby Eshleman <bobbyeshleman@meta.com>
>>
>> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
>> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
>> churn for large flows.
>>
>> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
>> lets userspace request a larger niov size. The value must be a power of
>> two >= PAGE_SIZE.
>>
>> Measurements
>> ------------

Checkpatch complains about this separator usage:

ERROR: Invalid commit separator - some tools may have problems applying this
#15:
------------

Please replace or remove it in the next revision

>> @@ -90,16 +90,17 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>>         struct dmabuf_genpool_chunk_owner *owner;
>>         unsigned long dma_addr;
>>         struct net_iov *niov;
>> -       ssize_t offset;
>> -       ssize_t index;
>> +       size_t offset;
>> +       size_t index;
>>
> 
> nit: I would keep this signed. Some of the most frustrating issues I
> ran into is some of the underflowing and then passing a > check or
> something. Although if the LLM is not complaining about this
> particular case, there is probably no issue with it. I also notice a
> lot of existing code that deals with indexes and offsets goes for
> signed.

At very least the above change should go in a separate patch, as is
quite unrelated from the rest.

/P

