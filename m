Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD7CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859310EA11;
	Mon,  5 Oct 2026 09:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="KzcuAL9r";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1136D10EA11
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:35:58 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso15303805e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791192957; x=1791797757; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=glJhOe3o69hGuf36JpkU5EUJfHjbvLOwKHaTPoIM6ys=;
 b=KzcuAL9rSCpCtDQETjx9x9Yr+ST6R0zReUhxW/R0ZnBj7hA3Py+s5BcTAaaxUZJNn6
 Q/uj4B0WHgSrI+mITXqNBe+pOdq60FM0VqHMna2UY3kJqA/pAllqfI/DieryAAzael8v
 JjJFf1BBqBZC/+1uwnwdl928nYUW62O2u8CpCW4bfZOqIrN9cCQoQH7qcMOzUivgahLA
 WkTY6tJso/S835BK5DQUP3HYVJnhaK7N1/PLhjEe8NIWsdhiGLUwVTKe4+clo/QGMf/1
 Bf5fs0YNn1pFNIz0kIsm7nw2q3Vot5++5vuDdYAgxzdl1nJ1yUy+MSAB6hwnMsz3UnfE
 4GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192957; x=1791797757;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=glJhOe3o69hGuf36JpkU5EUJfHjbvLOwKHaTPoIM6ys=;
 b=0AFvakQuRfrKa2n80vR+xA5H0CS7oL+znnIOLSuWc79h2nm6o13MW/ChmuSiZFwjw6
 pUMXfIdFh3p6ATBBu+CMlKmI1PU9tjOn5dM/inzyNQ+dUKgl9r61gjKPXrhCABjvKO6A
 VdXKxuHSXtTp1O0vpQ0VFE5qoe/mv3a5JZPQXTPlZj8oDisQn25nxSe3Rtec4JDkTJC9
 JIORSmDAyvwJVC2bwkAuOj13IMoO7rAkiBcJ+G5rtmEt7zjbFRTQ3rgYya8Fio1Xp4tv
 lj6FeVyI1mTsaDmWmpo1noPwNgPbmgnq7BRdSehaqUlI20gVXZkXfjMCOikOFoMRwkRr
 167g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxhbakvV7B4CWXNJ9KsNV4xIPtTOYUtK4CNq3tGgUongKEl/1Bq10NIH6hXBJSVuuv5MHRc5YMz0c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lR9kTViWcOkANucqDq31tO+nqoHIKUSv5VGZfAKUqybd+mqfN+
 jPZGEUn2SR4IyvJeWLBSbhllDLp7IxJZi/Gn1ppeEnQeZGd5Fvpw4MBAk3Yc2jnvPhU=
X-Gm-Gg: AYBFou2wrYdzs6mFbGOitpy8/0XO94JcFxQ7ngfLWnuECI1XSGDpHBbUa7aI7ahtLnZ
 Oqtxuxjjeatsjir964897RvTB8QxngcE+5Xrb8PJ7h0KKVRvi/I1WZvqzIOUSG6TOlhxGgg3Zza
 Iih0rL+UIkh0z5KxrgPQ28NJafCPaloAVobwgoH185hvs2li8JTH84QUJ1PZxLTJjqWv4K47/Dh
 POzQdjuw/EI0yL+PispOCUsXb4YVwIUkBMe/pbJ20alX8j/ovs/qFsQQ9X4W7ObMbsbDmCkpf7L
 z9P5t4+F5G7U1ek9l73GuFjl2ENXKkzga/X5WL4CPfswzkwVUBc996ThLlEAQKSs6quKqgBgMTo
 dgByyR7FbdKVEiQRp/nBl6+BLpIkdqemBiORW2lamSBff3b9wfErgA3Uzjo6VbMfDKms6pSR51o
 f0HLPm+O6vdqAxgz5y3xbNtcRCVi60/NZK9SaZSBzDyZ27ZEAluWGblPQoYJqxxB7AYlxZ
X-Received: by 2002:a05:600c:4705:b0:49c:fc6e:a3da with SMTP id
 5b1f17b1804b1-4a1680ffb88mr111842255e9.25.1791192957347; 
 Mon, 05 Oct 2026 02:35:57 -0700 (PDT)
Received: from localhost ([41.66.99.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm313414045e9.1.2026.10.05.02.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:35:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 11:35:54 +0200
Message-Id: <DLWSWRKGNB1K.303TRIRF4FH16@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: himax,hx83112a:
 Tighten compatible matching
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Luca Weiss" <luca@lucaweiss.eu>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
 <20261002-hx83112-compatible-contains-v1-1-d558635ab7fc@fairphone.com>
 <9be89803-974c-4746-8af0-a13e5a19fb33@linaro.org>
In-Reply-To: <9be89803-974c-4746-8af0-a13e5a19fb33@linaro.org>
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

On Mon Oct 5, 2026 at 11:27 AM CEST, Neil Armstrong wrote:
> Hi,
>
> On 10/2/26 16:49, Luca Weiss wrote:
>> The compatible was defined too wide, we just want "djn,9a-3r063-1102b"
>> and nothing else.
>
> Can you add Fixes tags ?

Sure, I can do that. Wasn't sure if that's a thing on dt-bindings
patches, but it seems to be used regularly.

Fixes: 3b59787a5170 ("dt-bindings: display: panel: Add Himax HX83112A")

Regards
Luca

>
> Thanks,
> Neil
>
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml | =
3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx831=
12a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.y=
aml
>> index 2c60d0cd704e..3dd9b25ff13f 100644
>> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yam=
l
>> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yam=
l
>> @@ -18,8 +18,7 @@ allOf:
>>  =20
>>   properties:
>>     compatible:
>> -    contains:
>> -      const: djn,9a-3r063-1102b
>> +    const: djn,9a-3r063-1102b
>>  =20
>>     reg:
>>       maxItems: 1
>>=20


