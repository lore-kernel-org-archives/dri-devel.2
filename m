Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852C606A328
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm2 header.b=atp5/hIL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Bwf4dz12
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E72A1121F0;
	Wed, 21 Oct 2026 20:17:12 +0000 (UTC)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6FD1121F0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:17:01 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 13A0B14000F2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:17:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 21 Oct 2026 16:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1792613819; x=1792700219; bh=WsOu/rRUjY
 L7OCikxdUqQkdguWvT2iaNfaZpeKUs+qo=; b=atp5/hILPS7RjOeTpIcMO/fh1r
 spzLdAb4T9cgeaiF+HSxAoT9TVTX80macpFUl49eZ1zGQgRQaaZZ1q+18DFYRaoa
 y/5BFmzCLHSPNHP+0ZENhAEkIlY3JCCYimL8yib5c0FNiK/6gyEyvij5g0Tdc1lb
 Kdl4KUG5KyDS5AsL4Tfkz8qFNJkWlsZL/2SgupMtUFSeAgSHpSmUMuPhApXdMDNu
 uXRtZ2fyZLyZBHq2zL9yzwTsJWxGaIJX9vbg4CabpYqtSuDAmj/XXhfUCbv+NtrR
 iRX+8BV120sfMNGvQmUEPzfI9lIsqVsSSsQm24oT5LkRdvnLzbhqaL+vN/wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792613819; x=
 1792700219; bh=WsOu/rRUjYL7OCikxdUqQkdguWvT2iaNfaZpeKUs+qo=; b=B
 wf4dz12Mv+nHxgpgq5usKeX7+n1aC5jdk6ftFenJLJxzd4/WxnSj5gR7K6FiPWZM
 rg2PL8Wvr/yMaIAL0a8cVWwpErdrCrUR2o8Vt1tFakqMjqpVceiworGkhccX61WQ
 kJKkmXoH0povlrDtxN4wEIFg/vtz+ZIq714RaJjqxDv9jKd4PHeVZb3uwmpb29Jv
 XxMKBiLuIBI91qQ7Y8PqvOm9JjlqG3DTh7gbxaWNZ2E4OOiWcLdJBTyc+fgkkYH0
 lxiwmKEViPuXUkyflhTQx+/lCvQaILi0l4FV+4biOrap1MIXrtUd5xls1F2v1RiP
 LVC2rMVJ9OutP7iwozQow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792613819; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:Bx0J8/JdJOZ4I2Wp1/Al54Kj0gV8O4Y5tsjz7tqFp0Nf0no
 zPBPkTxcr7dNwtw8ahBoEhMz779nKwcultS7bji5NrYMDE3nzXxWUOJ87tLpweJt
 ASWDTRjaEhUe1noEhRbDMcOvkrQ+pkVyELRr3RV3XzfCy9O3I8sM8g2b8zSfoQHT
 2F9XZiVlvC8/ibzp+uTvRQEl5JvV/4083o6ta5Y7pFEi8DCobtaNB9pioTGfWKqy
 mwaAu1Zn+SbdcXpxwCqx2qKulISd7dmXadd+VrL2GZcEvOc6GiFk/XhGGzgcdD/c
 dgtFMUqsHT5sht/cfxREsVGtYNl/P7Dq+Q0wVzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=15;
 hn=autocrypt,cc,content-language,content-transfer-encoding,
 content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,references,subject,to,user-agent;
Message-Instance: m=1;
 h=sha256:o5K+uoy2p3l+rotmqQ/lqLog1mD1ccTslh81foHS7SA=:XQ6PYviYeH6meLP/28q9IYylvU0BkycclHGqpiogBlI=;
X-ME-Sender: <xms:ux3Zardsg0Lmvr9uoNcj9PcvvACU9BeUbyg5t3mfyIFUv71d342reA>
 <xme:ux3ZagSvvt4TBAfY_GPH-oRbUq6Jd4_FXijHbIIjNlkg7Ne02H7PqSWEtkO4XPyOQ
 V0AZNlcK2NQ4MvxJO9NuFx-2ExYOv7jtS3ifbLJu1hhUG7MrzRx>
X-ME-Received: <xmr:ux3Zaqvaqos80rBkdWZn-2rFXQCXLOecqFLjEuGM1xCAY-RFT16rbcej5OtjppBmipsp-19JByaebM53lCwBRhhVWCa7Fu3jSQ>
X-ME-Proxy-Cause: dmFkZTF5+fcfy/Oo5Le9I+Kjc3hGsGqRVtTBvtalw9ldQrZqqDF7kj28w0isq6NWkXIq78
 bnL/tBTa9p8XouAsJCZEPacqdUuiQHvxkGXGoODmdc7SuUBv6enBUYuu6AMstMsnQdRDLu
 HfVHmZElus2f0sABEVTnCvOWeiBL0FP4rKKqyj9i81HnyAxUWglZ6uxANNdU+bv9XHuBCk
 mEigObqboa9yoo9hYGU2J9bGlxKpiQwp2C0RjwbLlOSMCkc5F9QXvlKfT16RuGyV4zqxSo
 Hi/odAbWpKwBZtJkUm7dptQPsR12CDTWnofHtUvT7t0y5Dlr0X8sH+U+vhNJYtmusUmoAH
 Tu9fZDy2TQVHoSl5Z/NIa+jg+DvjZrloWWFXJHsnon3XOeUF8s7NbsxMnBdPbTNhDSQEB7
 zKi+Wq74T/qCn7uoQL+vCw9w9srbhX6Y6mnIWbnqMGGwrgHgGnSGluhnhlZBrX3oZqng/w
 MijAYp1axMDt1P3JcCHuvhj9tLcHohL+UysFvhVed074/EUS4Z5Dd9lV0YZY9576cGXlmK
 5kJjU6R2yOhBc+nsiV9sYkTvOUdsq8G2xhPB9FsWDvKDNUWue9XqwHglyGCnJfbTvVvXZM
 +mp4Ofob1vR+eGlkAbOkY/JSgD7CBPb7dro38E67Ram2gWNkDi3klIqZWFAQ
X-ME-Proxy: <xmx:ux3ZapfawUxz73R2n_YRTOJMP_jvbze2m3g3Xbciftk9ShjKXn6uSg>
 <xmx:ux3ZasZKYHY-MN8s23tolDr-8ktT9clQRZgcbifzN2UfWeyo8Fuuow>
 <xmx:ux3Zaja4bW2GE2fTz1n1lNL6OqqO0YTnaoBa-ubZQaXQ7HuN-0dUBA>
 <xmx:ux3ZapJDw1OE9bJirGPrnDNcq9M8Bma6VmxBRRE4A7Z2IEdV2QdkYA>
 <xmx:ux3ZasswRekrGH_gOF085VCwg4JwBJBJ0QE5V7jcAuUCFq-YS5A0ayCM>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 16:16:57 -0400 (EDT)
Message-ID: <a1057af1-2390-41c0-ac57-4ab9ef0fe31d@invisiblethingslab.com>
Date: Wed, 21 Oct 2026 17:16:54 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261021093533.1990028-1-val@invisiblethingslab.com>
 <6e45ae81-0319-4857-a96e-159509c1b140@amd.com>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <6e45ae81-0319-4857-a96e-159509c1b140@amd.com>
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/21/26 10:43 AM, Christian König wrote:
> [..]
>> The buffer lifecycle coordination we need this for applies to KVM as well
>> and it generally doesn't make sense to have this as a provider-specific
>> thing since it's not related to the provider in any way, it's just
>> something we want from dmabufs in general.
> I wouldn't put that on the DMA-buf file descriptor where basically anybody can mess with it. That is just an recipe for trouble.
>
> The better approach seems to be putting it into the udmabuf_ioctl(), so that from the very beginning you add the eventfd which signals when the udmabuf is released.
>
> If we need that for more implementations than just udmabuf, we can potentially add it to dma_buf_export_info so that exporters can provide the eventfd file descriptor directly on creation.

Well, we already need it with both udmabuf and gntdev-dmabuf..

Involving the exporter sounds really annoying when it's not something 
exporter dependent really.. What if the policy is just "only one eventfd 
ever" i.e. the first call of the ioctl succeeds but later calls on the 
same dmabuf return an error? That should remove the concern about one 
user messing with another's events (and avoid the concurrent replacement 
issue sashiko-bot warned about)..

Thanks,
~val

