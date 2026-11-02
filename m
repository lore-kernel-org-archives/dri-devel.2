Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1F606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JY/wmp8u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742A510E2DE;
	Mon,  2 Nov 2026 22:01:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAB710E2DE
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793656867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmYBbIk5usy6FeDyc+DCeJpHSSfN/V5GCfHKFupvluE=;
 b=JY/wmp8uEajzUkf1vNeZ7IdqqrYGiqbB+JyZfHIwoBnRWFnXx6MxOMBQ1QPWUuN47HN3vw
 WfXsqF3y2s4CK8roeZtKzy6VSl6JCH36pHlSmbwr5v1VaCKfqJsb28FskLBuSe+4H8NHu8
 7PydJ4vC0jswAldSb+/rh1oN5K8jTB0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Vjgg1CNaOtOm0abMDPArag-1; Mon, 02 Nov 2026 17:01:06 -0500
X-MC-Unique: Vjgg1CNaOtOm0abMDPArag-1
X-Mimecast-MFC-AGG-ID: Vjgg1CNaOtOm0abMDPArag_1793656865
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so2328934f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793656865; x=1794261665;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmYBbIk5usy6FeDyc+DCeJpHSSfN/V5GCfHKFupvluE=;
 b=TPimTv1dVDikTvFIdIKXdtRMAPcisibTWR7vVleA4Ztc4nU2vtQh0Ywdh/oRDkbxP2
 /eKjOM9osT2A/VI6TE8CGo9N/95ck1euIdGlwjMYK0jOybu2+Y1YXf3wBzlj/ncSvt0d
 Onub9YhGjKE3J8/9O+ei+NFnIiHc6N3ua2tFsNeXkjJCBLz8daOt8gXqDTP0lv/c8a5r
 feMOBLmGmBPXhrVg5tEz66LGVWUrO2JuLUpmPpN8oDlzm4d1s7KoYQO+7cUWiLBviDIM
 vJNiw7iNwBzAvtCvkMy/ABgMB+ldtQov4pK96hdNuAZm4iXdtjcp9YstZ9ANyOdsHX7y
 jE7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzcflj2Uir+y1Lusx9Uyr7AwdIW9K74vLxc1OqGzepSUeeFp5KHI7Gd7CPRglRaaaoA3EDqpNkMj4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9XZvB61Ptu1eKrek1lLS7nvuLTW6hfvDdrTWmOR0bE2j1oBLuV
 W359KLxvS2I6rv/2VNCHq80lLWHK7aIpPPnE823TIbR2tuo6ET17VtxFMhpHPeDFuKxnPBGTyD/
 n3QkN4lkZpwlKOVa1Bp1Qz4U2VSPTPaqQ7+hcY6qwEoci0lveaAw3yQ7q7U96iEGsJfG92A==
X-Gm-Gg: AYBFou2GrCfc4wsRbAL4wT04Ilaw7NXda2bsvWWCfB9Dc7VleykLjFu1YQNCzoJQXop
 IPo+t39Jqc1OD3+XSN6l84OdY6fgxQsp9gbCp3bDEKvGqKXzJUfB2boR66sEvw0KSOQqKBtHtEd
 7ci5Wz7CzyE6Kps1dwgoZnjD6GNGekHvJlFA8czjxfdFm4w614ob96f+ZHWNxpIStKqF7X2GbYU
 V7oF9Nbzio06gcCEG+F/AqwlHFRjmccbnji6DPBZdSgOLnNUEtD0FhJLF98q7vcKfMQNBoslHcp
 Q6IGoE9wYRU7H6Il/lPldMpvbgmyDBbsnyhlVH5eFb9YUDOIpx54VQLVAReNfbNmdww510McF3p
 ophx8VAn7rmfuHDHABKD3GnJla1V1pAiXFNqdcQ2+4WZCkKyb/RL5J/M/ykHrfG6g9cWbO2CAEa
 t/PF6yjCUZIEuw6oGCw1SxAvX09634v1E0i5G5c4iuChA=
X-Received: by 2002:a5d:5f41:0:b0:48e:68d5:818d with SMTP id
 ffacd0b85a97d-48e6e2eb83emr27445800f8f.16.1793656864987; 
 Mon, 02 Nov 2026 14:01:04 -0800 (PST)
X-Received: by 2002:a5d:5f41:0:b0:48e:68d5:818d with SMTP id
 ffacd0b85a97d-48e6e2eb83emr27445750f8f.16.1793656864628; 
 Mon, 02 Nov 2026 14:01:04 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it.
 [82.192.128.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71baa1b3sm20953601f8f.56.2026.11.02.14.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 14:01:03 -0800 (PST)
Message-ID: <f4f0fbd6-63e4-42d3-87bf-9f888a8de1a8@redhat.com>
Date: Mon, 2 Nov 2026 23:01:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Mina Almasry <almasrymina@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 sdf@fomichev.me, kaiyuanz@google.com, kuba@kernel.org,
 bobbyeshleman@meta.com, asml.silence@gmail.com, dw@davidwei.uk,
 ap420073@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 horms@kernel.org, shuah@kernel.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, andrew+netdev@lunn.ch,
 sdf.kernel@gmail.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 daniel@iogearbox.net, razor@blackwall.org, tariqt@nvidia.com,
 kaifengw@google.com, dtatulea@nvidia.com
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
 <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
 <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
 <20261102185856.1824792-1-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102185856.1824792-1-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RGQwl-s37XU_OFSDq9uN3gwbOXoljZfPK7MpU4z2rbk_1793656865
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 19:58, Mina Almasry wrote:
> On Mon, Nov 2, 2026 at 7:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/2/26 00:16, Mina Almasry wrote:
>>> On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
>>>>
>>>> - [High] The dma_dev use-after-free this patch says it fixes can still
>>>>     happen for RX bindings made on a virtual device that leases queues,...
>>>>
>>>
>>> I know about the issues with leased devices. That needs a bit of a
>>> rework, which I have done locally, and would like to send out as a
>>> follow up fix.
>> Will such follow-up rework the code touched by  current patch/series?
>> how much? I'm under the impression that at least the fix for the issue
>> reported here would be quite overlapping.
>>
>> /P
> 
> I pushed the follow-up branch on top of v5 here so you can see the exact diff:
> https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease-bind-map-dev
> (commits: https://github.com/mina/linux/commits/devmem-lease-bind-map-dev)
> 
> There is some overlap (~55 lines of v5 touched across a 6-patch +262/-99
> follow-up): it renames binding->dev/vdev to binding->map_dev/bind_dev, passes
> the net_device explicitly to net_devmem_lock_dev(), factors out
> net_devmem_close_rxqs(), and replaces the !rxq->lease / !netif_is_queue_leasee()
> skips in net_devmem_dev_unregister() and mp_dmabuf_devmem_uninstall().
> 
> I kept it separate only to keep this net fix smaller and easier to review,
> since the lease issue is pre-existing. Happy to either land v5 first and send
> those 6 patches right after, or fold them into a v6 if you prefer avoiding the
> churn.
I hoped for something smaller :)

I definitely would not fold the 2 series.

I'm wondering if this could be considered net-next material? pointing to
net-next will offer better guarantees for all the work to land in the same
release (no need to repost in such a case, I can apply this one to net-next
directly).

/P

