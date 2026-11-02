Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05A60D2B9D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gd4WZnKb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC74810EFFE;
	Mon,  2 Nov 2026 15:29:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE04710EFFE
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793633386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ttXRStBxZjXNHjuvGXMWk9I1gtHZhhcUuBKOaR2A9w=;
 b=gd4WZnKbgNwuq63q5Q50bSzto4Pjm38hz30WgvlqCSiNF41gpJm7hovsK2j+yIQ1yiHnhs
 K7MxLQy/Qvk+TAyIF45hFYKw9su+qF9D5/g2xkVJKTgigd2iNDTu1bUdRCoC8LIdSd4v31
 n8AX8G7+tPoh6LykgRXvmZ/D65LZA7Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-LKHmKFXKM5m58PBjPOMx5w-1; Mon, 02 Nov 2026 10:29:42 -0500
X-MC-Unique: LKHmKFXKM5m58PBjPOMx5w-1
X-Mimecast-MFC-AGG-ID: LKHmKFXKM5m58PBjPOMx5w_1793633382
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a2b0669946so22811205e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 07:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793633381; x=1794238181;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ttXRStBxZjXNHjuvGXMWk9I1gtHZhhcUuBKOaR2A9w=;
 b=hWJJkXPm33sC0IMYsFy1PPN7g+qkF2s2LuQKdB2ZlEI2rCo5gEh6v+SQClXEsLV0mT
 trgNRZLuvdXUoHW+7epzp28OihyLmOPJoT8qbcolZfQ7t0y3DgSERXb7hzVMTJKVrre9
 Pqv/+LoUZjYbV1yvpGpM/yR6QEUjaj7LFNosHdXJCXZ71fawTElri/tjS402D2HBW4e3
 t90wM0GPVtPRcld1/woehSi3XZ7WYssOwy3ab8ya8u3PLOxg/7hNCEfKAZI/5mUvXzuw
 jOK/msW1dOSqoXJuIdiiODhiXrmHiIcmUYnLsEKMPz6wiGAsNuzUzIvAFq1K+Myd6zDG
 UOUg==
X-Forwarded-Encrypted: i=1;
 AKwUvByo0WGq9hGoHUPSXvtnq/yl4XSh4+T1Lz7nDdKKZh4JXTe3cGaAvSmTYsBvlAVU3HE+VZ6cKaqz83E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ33FlwqS8bvj6CmgE2dzi7wGnGWFNmewNIyXfvLkQz34ApQ9mU
 XOrgGW0HGNPUr/Jqlw3+T9XvXBJku5LBDbj7z0BJj4IE817syiawVjMm21X0hRBKfOdZt5Cp0nO
 5rGi3SH9DU4OnA63CVzYkZUVWBcAm26C8Km+NtHn6q60AohW/OCC7pc5QEJeLl2YP5QCNEw==
X-Gm-Gg: AYBFou3UKQKWLLoGGHSUt3T4L4hQqEtptlMuZILMtD8OeuSggS6PoHfbRCcSGwKOkah
 LyC2c27EzZCEcrz1pNz3mPjyIjxE0DU/TABLyY+05Vtta8Vz/HNc7nPX238KXEv2Brzc9Mhqe11
 QBZ2Edh8shOJRkyMMDFNZ9k64EL/O+k6ZzP3O4EJSirqZnAPQ5HFaLY3UHSSu/9LGm1qOn6xfb3
 KN8GNSIuKrzlawb2TLLxZOMRoYHDXS7FMW/Umix1aT9EQ19Mb1AfVSDzNfQCHok5SE9ZwWkTLzc
 XG8TiEC7egHaEgCyaDCN/q0WqRPJ1yc0Sa4OHVZnBn7i65ouxjm36cK/hseejA6nmrpc2aoFJ8C
 sJJbPIcEZeIMyms3TtqdMjPXrwutr/08/pn2Tp5fxpA6+fOW+HWCGG5ExT+/nXDZdPaLntFQgch
 wf3w2hiHJIXqbUxUr0KBNOQB6Q+QQ9lSg3Ddq6+shYP0g=
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ac185bd243mr241030455e9.17.1793633381484; 
 Mon, 02 Nov 2026 07:29:41 -0800 (PST)
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ac185bd243mr241029635e9.17.1793633381011; 
 Mon, 02 Nov 2026 07:29:41 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it.
 [82.192.128.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm352011105e9.4.2026.11.02.07.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 07:29:40 -0800 (PST)
Message-ID: <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
Date: Mon, 2 Nov 2026 16:29:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Mina Almasry <almasrymina@google.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, sdf@fomichev.me, kaiyuanz@google.com,
 kuba@kernel.org, bobbyeshleman@meta.com, asml.silence@gmail.com,
 dw@davidwei.uk, ap420073@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org,
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
 <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cy8wfl02Wsd7P8irmJaaBiZpNBqEVnrM-1bAJEu79O0_1793633382
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 00:16, Mina Almasry wrote:
> On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] The dma_dev use-after-free this patch says it fixes can still
>>    happen for RX bindings made on a virtual device that leases queues,…
>>
> 
> I know about the issues with leased devices. That needs a bit of a
> rework, which I have done locally, and would like to send out as a
> follow up fix.
Will such follow-up rework the code touched by  current patch/series?
how much? I'm under the impression that at least the fix for the issue
reported here would be quite overlapping.

/P

