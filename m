Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F8606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm2 header.b=eWoSYr5q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qYHYQXQl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA47112905;
	Fri, 23 Oct 2026 00:36:28 +0000 (UTC)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7B511293B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 00:36:17 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 32AC2EC0104
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 20:36:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 22 Oct 2026 20:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1792715776; x=1792802176; bh=Jp5mdh9VzM
 PCAWV0XCl+JdXmq0weGr7TRow0yGFj7Qk=; b=eWoSYr5qX29LwIvho3zKn11Cow
 7letmyTofY71krsR8OT3pJYX5yTUFXLJU/lmRWCPwhDMspUP4ch08Yn0GjxE9ksx
 PyOngPENR/U2wgcjP/A2ivGJHzCNMDjGBarFDsBqQhoW55bPiJsrVJ64LlNQsdlw
 wj3wlvXsedmH0tfD/JY6NCzdNV6Js4+X8LCHeomKzG/QNLVv9rO6ElN1AQBknlHr
 0tFfCgVlDj+ZrdJusdrC+NOlY7tKemREz75bLBQ2z5XJlD3WyWkCsIKiHm4gIsm2
 gDwNANcFw/ETw8C5kzlogLHirKrdJ8XFJl4VO4kLkXM6hMrIB8dCFlPAJSUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792715776; x=
 1792802176; bh=Jp5mdh9VzMPCAWV0XCl+JdXmq0weGr7TRow0yGFj7Qk=; b=q
 YHYQXQlPrRpKgiFfzC0abMv0NefVC/BZCthmfhRy5+5PuslTxQmxhQ1VTiBCrsn5
 V2b6pefq/V31wCM4VgTmuzIM2MK+gEeADo6EWwepAjiT4xEobuFeHtW1dcEkKKbE
 ZeNGeVvTuw+8dSEHqGwP7ii9xOKDHjZpbZmAqZKUYepNBdMMId7I2T7PJ9BBqqBw
 Au29N4olgwlm6hfrsf2ITR0cDt6zu2lp964kHvHYssIWNmmoFNSoa0PJpvVb/jhT
 r77Zpg//lbkWT73sdCYFin+BYfzYQS+arkvYwdoqF52eUmouQwhSqH4ehMzt/Bhv
 CrsY6sTUN0d7jKY5/idWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792715776; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:dY5Zu7Tx9idF3G1Lv7/ioWESdTealyfVgoXtGo/oH23R1la
 7ati3gA03zhI/M4EcvI92sRDxdcH8cx9EnRn3FFa3EYNlYTZCl3NwjtMdoS4I0nB
 5YdukCsx27u8U7y4cFtsT56LDPzXy9aE5jHcXSpw6GMD1NQw5jHuh0EMsQNhftl8
 8Xj/rNW830UTFN1+uMYZW3vFF4AQT0wyXmTbIYLfdT2RblXxd+/+l8GGwnim89JM
 l609dgfrV14D/BrWrfte1teJicRWgJQNmvcfHgQMXw+4/SCMmoegztgrWBf5ZiC4
 7NgKyqXN1eoqeRx5akAY9BooFKxmMd5TH4IHOBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=15;
 hn=autocrypt,cc,content-language,content-transfer-encoding,
 content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,references,subject,to,user-agent;
Message-Instance: m=1;
 h=sha256:K5XLcmA2adlmkrdMWiRBdzs/Pgs5Rf1o7ihP751Ftog=:qsc4PC1ughL3lDrwaL4s0jtV9KY9pylnf0Fjyzpak8Y=;
X-ME-Sender: <xms:_6vaamYQKZ_lYiuZBOE87z4IR0Dme_RnqZk-XOuUugKc5V68o3XMZw>
 <xme:_6vaaoeaqMliQXCIEd4jYzpGC3zYU6ooQvlbvqFlTNNgvxzd4dWItBMsFmW7NBB-U
 t0UH5vUpbCTjik6isnbazg_z54ewc_u7GhFCx0bt8UOfWWmwSsZrA>
X-ME-Received: <xmr:_6vaanLTn3FyvZf_c9P9ZPO2tPoYahiecQTCA6nB9TmLM6FNxaDHYsHCvcTjvzy3FkMnt1YsJ1kAAmdKLIH87zWo2aIvgk9naw>
X-ME-Proxy-Cause: dmFkZTFRu798DO+VUgryXpScRSVTKDOSp2hirnxjU8Hcf1udFt7yEdLhyatJpT2zj58gRg
 eRZGhA+gTb5eUsPISs8n8+GAqrDjH1k7wDYJEmamRDj3qcrOO5/9gsOgNvMJccvtg6VwBq
 DEK2IzKzjLssd74CynsD6jcuk8BsksyugUageIswRb3CSLe8N9y4qs+e57iyGBG+QYPOoQ
 G4uPIYj+V8tYo0L8ithtykbT9XdSnIicxLCanLp3juqgloGyKLAxGJBGGt5fA6j/9zfp/D
 G6cK2iG7EgLzrAVF6wZhbBj5E84y/tUMTUDD8QbqGkIMioTFWDwUnBAfv0xePsRJKbwSIO
 khpB6X0G23sV2KQagywUn3N/I5b28nsFnTpvpg1c9Wb0ugmrejCGLjrGqbE3xvYtnLpthx
 +Tbtw1GxjLfcjo7WJ8Y5JMz7SoYqAWtW5meMT8yfcJ2+hFMzGQX9tQODLCBcCinJGuUtLF
 uEgm17LkUPYdDpp4ZzIz7Qz5wM2sVeCMfwWnLmP+F+tyiBhI4g9VJ04evWPo2/FId++oJV
 rGtQDk1Li7S3ONKi/5PfikqDnRaiAGbwL3HYvShIBZRy5qsU6/hPFfFjpMEUSFB0Yh8GiZ
 5DD6foA4V49PPsfhnPIXva1K3gBpG/godvtmznB9XsMVTwFAZmp0kvBrSGXQ
X-ME-Proxy: <xmx:_6vaalKRBjdt24sH07qZIJ9hOeRjepB10sZpGPDByqJbzB8MJIFLAA>
 <xmx:_6vaamUaMpDwpzNwCo-LvwggtsBN25Q_1ogSUviqcNixmaauojffkg>
 <xmx:_6vaaun43zSqM9GogBSLAukCtf3ojUIHtiYuMJ_MtzMVpjiTFmKx0A>
 <xmx:_6vaasmhjcSAKVtO6XcA8Iy1AX6ckbFqAorSEx9GiY8298G_vb7A7Q>
 <xmx:AKzaar5kkL-tAsIRQaMekWdy_cUxUrQ8HlCj3LhUXf5UfWaCm34LGKsk>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 20:36:14 -0400 (EDT)
Message-ID: <3d654cee-81a5-4f0c-bf15-a24e31db60d0@invisiblethingslab.com>
Date: Thu, 22 Oct 2026 21:36:11 -0300
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
 <a1057af1-2390-41c0-ac57-4ab9ef0fe31d@invisiblethingslab.com>
 <bcb4f2fd-dec9-4d2f-869e-a1578843ab84@amd.com>
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
In-Reply-To: <bcb4f2fd-dec9-4d2f-869e-a1578843ab84@amd.com>
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


On 10/22/26 9:26 AM, Christian König wrote:
> On 10/21/26 22:16, Val Packett wrote:
>> On 10/21/26 10:43 AM, Christian König wrote:
>>> [..]
>>>> The buffer lifecycle coordination we need this for applies to KVM as well
>>>> and it generally doesn't make sense to have this as a provider-specific
>>>> thing since it's not related to the provider in any way, it's just
>>>> something we want from dmabufs in general.
>>> I wouldn't put that on the DMA-buf file descriptor where basically anybody can mess with it. That is just an recipe for trouble.
>>>
>>> The better approach seems to be putting it into the udmabuf_ioctl(), so that from the very beginning you add the eventfd which signals when the udmabuf is released.
>>>
>>> If we need that for more implementations than just udmabuf, we can potentially add it to dma_buf_export_info so that exporters can provide the eventfd file descriptor directly on creation.
>> Well, we already need it with both udmabuf and gntdev-dmabuf..
>>
>> Involving the exporter sounds really annoying when it's not something exporter dependent really.. What if the policy is just "only one eventfd ever" i.e. the first call of the ioctl succeeds but later calls on the same dmabuf return an error?
> No, exactly that is what I'm trying to avoid.
>
> Nobody except the original creater should be able to insert an eventfd here.

If there's no replacement allowed anymore, what could possibly be 
harmful/undesirable about "someone else" being able to do this?

With a "first caller only" policy, the original creator already can be 
100% sure that no one else is able to insert an eventfd:

If the original creator calls this API before sending the fd to anyone 
else, well, the original creator *is* the first caller, that's it.

Otherwise, i.e. if the original creator is not interested in this API.. 
it's unlikely a different process would use it, but if one does for some 
reason, I don't see any negative consequences from that?



Thanks,
~val
