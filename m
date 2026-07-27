Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABE6C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B11310E7C1;
	Tue, 28 Jul 2026 07:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caOuAUS9";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFF510E2DB
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 19:55:35 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-381216921aaso3041048a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785182135; x=1785786935; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Oed6vlTg2jovt+HXI4BLBlvs0THVNl54mqZ9EdzbJV0=;
 b=caOuAUS9iVFOC+taM2zXpLRJWJWwtjPygtJH/ipjLNSZy45SX9/jjNkQ3reTUlFf3x
 f7Emx7h5l5f+ac6RA/U/OUuYaKvATd20dkEypDDQmi7WHFMGFXOM92kvFfnQulrlNTPB
 IEoVfFmlR49Wn3eCxQBWUmQ2Qya+mTXmlIMDMVNg4h49BYlm9AWP1tRuc9PWiAbyFqp1
 tg/TP3Di7L/XX5FqQiCGf8+Ve+7OZb/Ij5at/AmNaeZczgO4hocm/f6iftAFvho7wlJc
 veaBXjHbBBZLaSIbHPSCuVv63EOBWBnlGAkna0WTbAB8ZDvxISrW7mGe6TMXbFysx76m
 9UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785182135; x=1785786935;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oed6vlTg2jovt+HXI4BLBlvs0THVNl54mqZ9EdzbJV0=;
 b=Knpufu/hsUkmwxBJh6Ado9ESWouYmJfC3F0TX9pVfn0+XMfWAHhJJVM51Ug7FCtpxR
 uR3C5EGn6PZflR/tMTpor85XuqyKrpWSN2+5MEZJmPEJvgqCy/uaeK3P4EuFq6O/S764
 jGXDZyCJwZBggnEDyStNZ87CJ0pImTMcyq1wewkYv1T945LRMQYRVgcfI+6Z8GMVBJTw
 xOthIDIwXw67PLAt9DbHqEiq6ePlV6HOKfMRzCeQ52q+0MyM3Opew4p37WPD2D7zY8ih
 k7Z7ZvgUrIz0y1vIJIJ/Vz73zKq7aVuW0/jbmy3UFbj7GYJj6IDJjTPWJpo29+V6iPWJ
 049A==
X-Gm-Message-State: AOJu0Yw4jSJ2yYEY6+SHEISryFvMLBaayWrKk6OTGREogd97RydIguD9
 YpiN5kUYUKPBm2i8d/JEjvCV22PzN1AVgi2S3JYCxtOWX8g+CRFn/U6v
X-Gm-Gg: AR+sD13q6VCBGD1l78ystUiTHih+f5Q3GepCjUm0SR89hN4vaNjqqSsmdKnpgrMvoz9
 xsaJJyvJShpQHsdrhrLlKPrHHdvTaGrtXp6bHh/Gr1wWq0iCBdpR15E8c5JDHyxBWMfUnR9ymlJ
 9cVj2fnFe5WpADLA91LqitUurhJwd8sH5TYtz29C8RgShFt/Obm2haqd+2fk2W375lV/cQeaxEk
 wuLlHCfR62eWPISk9VhpJgXMF1ER6m7CanHzQjh5LRQW1OxUTX7OB6hNMqw0EApGD5KqLRS1wWZ
 5HluzV6lZegd9q+aPFoXWNUjGGOWsQrLswqxyocFdEowWCoxO+sVcTLLU35H3h5au4/rea2hlf4
 LFwbPQoPw/sUErISxPydAhRP7Xr0Xk46V/PY7wNcHVav390XwUPycCmE+JoUEnhj8dcoH1rKSOk
 OhzIZtRlpkPGt4jWMp
X-Received: by 2002:a17:90b:3942:b0:38e:7cb6:5c36 with SMTP id
 98e67ed59e1d1-38f64d03974mr604558a91.40.1785182134811; 
 Mon, 27 Jul 2026 12:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([154.17.229.144]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e53094d65sm27505674c88.13.2026.07.27.12.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 12:55:34 -0700 (PDT)
Message-ID: <5e845a21-776e-4206-9bce-cd809f6122f6@gmail.com>
Date: Tue, 28 Jul 2026 03:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel-edp: Add BOE NE140QDM-NX2
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <697e79c2-98a9-4bb3-b5fb-db327cbe1bce@gmail.com>
 <CAD=FV=UmtBnHuOc6oFeKAPrZSeAcx1EcjMdfm+FDV7uZgxa=zw@mail.gmail.com>
 <051ca77a-4308-4084-b9c1-5bbe4ea39f9c@gmail.com>
 <CAD=FV=VVjZRst=SCY0SCuwynzcG4vpjJ3ZAiRR=q+2ry-rt9CQ@mail.gmail.com>
 <9f2d7be0-e93e-480e-bcb1-6bc494f42640@gmail.com>
 <CAD=FV=XtR3YuUJoMk5sFPBihamdXY+WsETsPXf_oKHh1zT_Udg@mail.gmail.com>
Content-Language: en-US
From: Weiji Wang <nebclllo0444@gmail.com>
In-Reply-To: <CAD=FV=XtR3YuUJoMk5sFPBihamdXY+WsETsPXf_oKHh1zT_Udg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

Hi,


On 7/26/26 07:48, Doug Anderson wrote:
> If it doesn't mention T6-min, then the assumption is that the panel
> has no constraints on T6. Thus, T6-min would be 0.


Many thanks for your help. Verified this change on 'next-20260726' and
will file a patch v2 for it.

