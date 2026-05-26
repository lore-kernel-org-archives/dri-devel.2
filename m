Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA634CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3CD10E172;
	Tue, 26 May 2026 11:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DdKpm/Ue";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997AD10E172
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779795292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VD+dmiG81dGo1mjueRmNr772xEYjIurIakGJoB8fU4s=;
 b=DdKpm/UezA3KpMPxgHlp1Sn9g6Plmp6vyALmeK7Ri6QRFhbU6voF0bN43I6wZnMVl7Ao7l
 ZpWSCSzFCljR+2N6Y82uwT3cy92SxTEqAS3yrwGihdb10KjsdLlM4TOMJxraQSYviRiAX7
 1ENHpaEmYJD2guIP3GbZo1J4JdEbI0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-U_zekg4YNK6ewj5nEws0kA-1; Tue, 26 May 2026 07:34:50 -0400
X-MC-Unique: U_zekg4YNK6ewj5nEws0kA-1
X-Mimecast-MFC-AGG-ID: U_zekg4YNK6ewj5nEws0kA_1779795290
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490479c2911so44522975e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 04:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795289; x=1780400089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VD+dmiG81dGo1mjueRmNr772xEYjIurIakGJoB8fU4s=;
 b=RlQhJKKV/xWzdvbWzlZJJDuM1RAn9KXaZe8KiBCZGD0LxA/pihqpek3dsvzemH2Y2o
 IqiQOghEGwfFTucvOwZtegT4ckJOZFJ0A8SMMWAedsjEkxB10pZPqYu/1SZ5KOwg7m1Z
 C0OUxONW1X46BJN71xSXAQ4xm66FsPgrKKvIRHpQLPstEccRPJlzSFHIu21asxgua+k/
 41wPbwlVlK394z1RG1/bQWiZtBjY3CECPXMLC3y5Osq0LSwQ712wjipPjkCSC+5Ow/JM
 avK5Is+o4SAlIVuqREm3vCxBZdtyI4uDcrOUp9bDs/QR+iHv2XEwUmXf/6FO0n8Zy75j
 /Ecg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zIq+ztKsu27+2VdDIDMXr5ulwQ9ps5KFc+xzPdzzeaqlR9nGv8lxu8LdIGwVVJD4JukrK1qGU5zM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIufyfN6OdvzsCPOD8ahnz9cp7decPZpw67vrG2NAd5AKX+SXd
 zIR3Zvd82IPW7OR2rWbJ6pSo9N1HEUCdDmIGB1jM4AFPSO+AOzmHEm7aar6E6Xs4Oe4WrzA3vyR
 1+8njwcSN3gGXPIG0dZ177yX2mtHZqYRxMdJsgN/yguj9wQPBm/dl17DHc65FfUEZTUqTpA==
X-Gm-Gg: Acq92OFOZtmF46w0n5XBtMwZyX5g5Cx0TJDXHYH8kd9+8xEx431q23KwJ91SBs2/sNh
 oKNrho0/Ntw8l3BlFs3jYKSLraAAeGBsOWnx+9J/63myC28Bu3oze1c/x0ycIGVTHmVEJlqTLMy
 oie9vzhJ53p/jp24jnLZxbVOOxD4Bz39TE83kEItsaG0TuoEFvi4m4JHim6T0yRWtD8DrBcPC0V
 w3DVJa7lAU/LvklaUMBnwMG5j0fnGf1l2LyAZK1SHY7aHRn/st9Ly6iW0KZW2+lyeuP3uRAK8RX
 39cfOO7MSXPAsot2RX43roLMEMG7oVFOZZZLUsVHPLT1TonklVXM+01coL8gtXXe8F66kxVk/3r
 FtpNE2NY1cHNsNaz55YjJAi0KXFJVfAqpSweLIjw/zFLZQo2TZmLSFf7NqA==
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-490424b3c7fmr275107535e9.11.1779795289592; 
 Tue, 26 May 2026 04:34:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-490424b3c7fmr275106815e9.11.1779795289064; 
 Tue, 26 May 2026 04:34:49 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm565711385e9.1.2026.05.26.04.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 04:34:48 -0700 (PDT)
Message-ID: <5a54d307-0b8c-468d-9183-6433f9daba56@redhat.com>
Date: Tue, 26 May 2026 13:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 netdev@vger.kernel.org, mayank.rana@oss.qualcomm.com,
 quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
 <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
 <CAFEp6-1sdQn11NKom6cfwtJvZX-CnPRpJeVzQ+99Sb4A4L-qaQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAFEp6-1sdQn11NKom6cfwtJvZX-CnPRpJeVzQ+99Sb4A4L-qaQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0hf8a5KIWUR0fQzEtr6iNbtTSCrTaAKFgj5jFzhUWSM_1779795290
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

On 5/22/26 10:09 PM, Loic Poulain wrote:
> On Fri, May 22, 2026 at 12:01 PM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>>
>> The mhi_net driver does not coordinate with runtime PM, which allows the
>> underlying MHI controller to be runtime-suspended while transmit, receive,
>> or RX buffer refill operations are in progress. This can lead to stalled
>> transfers or failed queueing once runtime PM is enabled in the MHI core.
>>
>> Add runtime PM reference counting to the mhi_net data path to keep the
>> controller active for the duration of TX, RX, and buffer management
>> operations. Enable runtime PM during probe and take/release references
>> explicitly around these critical paths.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index ae169929a9d8..5d7f9ccdb17b 100644
>> --- a/drivers/net/mhi_net.c
>> +++ b/drivers/net/mhi_net.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>>  #include <linux/netdevice.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/skbuff.h>
>>  #include <linux/u64_stats_sync.h>
>>
>> @@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>>         struct mhi_device *mdev = mhi_netdev->mdev;
>>         int err;
>>
>> +       err = pm_runtime_get(&mdev->dev);
>> +       if (err < 0 && err != -EINPROGRESS) {
>> +               dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
>> +               pm_runtime_put_noidle(&mdev->dev);
>> +               goto exit_drop;
>> +       }
>> +
> 
> I am wondering what the value is in pushing this PM responsibility to
> each individual MHI client driver and requiring every MHI operation to
> be bracketed with runtime PM handling.
> 
> What does the client driver know here that the MHI core itself cannot
> handle centrally? It feels like ensuring the controller is
> runtime-active during transfer could be handled generically in the
> framework instead of duplicating the same logic in every client.

Indeed if *feel* like the MHI core should be able to put together all
the status needed to correctly track the PM.

Adding PM tracking to the NIC driver network data-path looks quite bad.

/P

