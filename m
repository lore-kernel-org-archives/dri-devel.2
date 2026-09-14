Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72478C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAE210E54D;
	Mon, 14 Sep 2026 07:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RZjIuL4E";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D06910E54D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789369652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z11npAfyXyZLp3jcVQ/pUy+RYhbspHGhoXmnEqcpbHY=;
 b=RZjIuL4EWj1JZIc7k9drEEt82liG19hybXtWy29ZVcJC/it5u1sZJDXbjsS+8oUYjCiXKA
 h+Jw1tkybIBmnTqXFNpzPeo7L3FtuLcUC85YNAOw5go5Rojf4Gxki6u+wS6wWTG7qiyZja
 9CxtFcKCnPG8XPaolg5PC+B8+0/ACoY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Iy-6Zum0MZqZXuEioNU5eg-1; Mon, 14 Sep 2026 03:07:28 -0400
X-MC-Unique: Iy-6Zum0MZqZXuEioNU5eg-1
X-Mimecast-MFC-AGG-ID: Iy-6Zum0MZqZXuEioNU5eg_1789369648
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486fd4264ffso442682f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789369648; x=1789974448;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q3T8MmJHP0lKCHrHGSLSWbPMgzGHktYBz/oTT4ophsQ=;
 b=Lj9K9bX9YKXuQDZyUBWMwQm57CLLrRbeACGaTkzBkM6NpesyQtOMdilPQUq10LXIWK
 jIDgD7HCC/FgqcSmZIaVAYI/gKAyULb6JBEWgKI0fXxqMCAFyjg4Yy0u8QceSsfEEbXC
 6d7lK/H0kalD3DXAeLCtacxjKASVK6SKdoSmPT5EW5xBe6ilcdbmHHcFJfePPXao3Z36
 RpTrgJCNXGK1gYBpgY2wJgFQDZwPReQfB0VlV1iAyIgOa5S3J6Se1sRfiPPASjCmDG6s
 DLA5ec58IkPPs5VtNna0ikplJHhmvqM9umlOpYDv8mHNyjQ6g1GDNYQdjb5k8cXyCAiL
 l3Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIXQiHF9l0kp0K7Y/UKNkelgmtyL6y+EuNUQXr5XgKOsHCnRINz3OyhITcEZNT2SY6cZaRyM4TIpg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mR9+07PdspyjeKl0LCT4g0jWK5l8/THi/Bh26CI0baKS5KWWGo
 H54WQq3Oi7GQFZ+jFh9hVq+sT5gcgOn902ZpbdhM7UvVZ2DG+86bphR0bvp1hWVe1Zax4SYqGmN
 EG1Sg7sXR6s/nBfSyaUHYy9KZbNijQm3V9lb//SmsqJY2hYiNlPw/adP9ZVZVXpzMia6rCw==
X-Gm-Gg: AYBFou02/I/D0DUotKsZ7+/GP+v95vWXQTWf5tqFBMPYNdn96n09+8tWs/22fqFsEtT
 U75M/iMFi2QgEyCx72fBsnnoZfgzNCk2EZ6fiLqhX6aK416PSnyhl7khjJ78S/OmcpylMN109i9
 IkOWYsVGTlJUSqnrk0bYWHPSReUD+WyzX28A3GAmoIGwjoWfYsdJfTu9yQ6tUcHaSL56gsvcYKw
 ohjH5knXWD76jxoABv5jiOnj5jzz3LJ7gfFTguJ4hG1T2DCOvurhifZfg2qY3GnL/rvAIFWldY3
 aqXwl1St9PnHCOmcZdCjuEvefQGQHc+vrH4AQ3Qj3WAE4rSMDUzVcsnyBbNKgh7UYyv+REoP6dk
 glYspaDl+MoYifnSja+nzplhMiKrccdtBesalnuPpxCqOHTmSivYaW5na7A==
X-Received: by 2002:a05:6000:386:b0:485:8bc6:3caa with SMTP id
 ffacd0b85a97d-48702acc272mr1050456f8f.16.1789369647578; 
 Mon, 14 Sep 2026 00:07:27 -0700 (PDT)
X-Received: by 2002:a05:6000:386:b0:485:8bc6:3caa with SMTP id
 ffacd0b85a97d-48702acc272mr1050421f8f.16.1789369647201; 
 Mon, 14 Sep 2026 00:07:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm25154298f8f.19.2026.09.14.00.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:07:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
In-Reply-To: <CAOEgbEqd6pGUL6o2CbyePUWm=NBy1GJJaOm+_7rg3CsEGqEfYw@mail.gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-2-amit.barzilai22@gmail.com>
 <20260823112814.896AE1F000E9@smtp.kernel.org>
 <8733vhmk4p.fsf@ocarina.mail-host-address-is-not-set>
 <CAOEgbEqd6pGUL6o2CbyePUWm=NBy1GJJaOm+_7rg3CsEGqEfYw@mail.gmail.com>
Date: Mon, 14 Sep 2026 09:07:25 +0200
Message-ID: <87v7881fbm.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AFV6tPlT4GlXiw7etGAIVx5eTPUaZ1Pl-LyLzssemvo_1789369648
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

> On Thu, Sep 10, 2026 at 2:16=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> sashiko-bot@kernel.org writes:
>>
>> >> +allOf:
>> >> +  - $ref: solomon,ssd-common.yaml#
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    enum:
>> >> +      - solomon,ssd1351
>> >
>> > [Severity: Low]
>> > Should this properties block also declare default values for solomon,w=
idth
>> > and solomon,height?
>> >
>> > Other bindings that include solomon,ssd-common.yaml, such as
>> > solomon,ssd133x.yaml, establish default geometry values for their spec=
ific
>> > compatible strings in this block. Without these default values, device=
 trees
>> > that omit the width and height properties will lack a schema-defined d=
efault
>> > geometry.
>> >
>> > --
>> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823111959=
.17029-1-amit.barzilai22@gmail.com?part=3D1
>> >
>>
>> I think Sashiko is correct here. Let's include the default values in the
>> DT binding schema to be consistent to what is done in the other bindings=
.
>
> I included them in v1, Krzysztof mentioned that they should be removed
> since they are deducible from the compatible:
> https://lore.kernel.org/dri-devel/20260611-psychedelic-funky-foxhound-a8e=
39d@quoll/
>
> I personally agree with Krzysztof, but I won't die on this hill.
> Let me know which way you'd like this to go.
>

I see. I don't have a strong opinion either so I'm OK with not having it
in the binding doc then.

> --=20
> Thanks,
> Amit
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

