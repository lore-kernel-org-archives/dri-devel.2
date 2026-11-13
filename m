Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC005606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DDsrFlcJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCAD10E79D;
	Fri, 13 Nov 2026 13:02:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160BC10E79D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794574972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SmBoR6Vj1QeVffmXogWgD5Pkl7UaW+NO5BD9KJS6mXg=;
 b=DDsrFlcJG+gDEGo0hCv+zYpCVVkpluqhlaUQLUtVCTMUYVhVQ/nv5QsE8ob5pLdu2kzE5T
 /hv0LgqNOJnFLkkgOUKGYDVp9rvtGsQiKfj0x0oj00JrBs892Io5fEs/lv3hmWhK5aRKh9
 pXTskTJ5WMOCilOjfQz0xyOieKsmIco=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-zOgso56vNwCqYacGtd1gbg-1; Fri, 13 Nov 2026 08:02:47 -0500
X-MC-Unique: zOgso56vNwCqYacGtd1gbg-1
X-Mimecast-MFC-AGG-ID: zOgso56vNwCqYacGtd1gbg_1794574967
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c505ee610feso93078966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 05:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794574966; x=1795179766;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SmBoR6Vj1QeVffmXogWgD5Pkl7UaW+NO5BD9KJS6mXg=;
 b=bebMaMK/iQA/JiZlox6kgtAS5oOG7p30PoueDRbDlXjiOeekjmWsDYKi5M/fVYAswI
 43Uaqtc08uEvue1Sz//vJecDdaYpPXdiEeiIRrQx6dH7Wamy2ZHElRQwmZ/G46rKvB9N
 FZB8K25sV6Fnyw37HedTnNVV3zvyXciTMHoRF08AB2kIX2AAB9z1EC/qr8U1WVCvBfqd
 cEQb5Zr0N163doWzcf7bpM2dE4qPbv+kBnAx7K0VUXk2U2rU2pXfL+3CBdVGr+dNIT0l
 wDYHbFzbf9RxRDi/BQZobSmdyAo7vHm5+Yd8sWUfVJ7QiX1QZjMkr69Hv9rgAEgqnTMh
 HO6A==
X-Forwarded-Encrypted: i=1;
 AL+hErHhS/UevVSDOx9DI3VolRNjwJWpxuZResnIgBXmtWlZxIZ4qCDxj6w7TAlWaPwYZm1BqljQYehFKnQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9HRKKNXf2qtU2CO+WLNDxs7Ve0O5cuG3lRG/IZnk0B0d/EmqYW
 MbvskPRCPL8V5T8mgX3nMcg1eoWbeObqT5VV7a3Y6GOHlyw21rK5yZZxnbRU7361PWj9rzih4di
 HA/3uf+FwHtOwaP81VR2TZAtxwGO23ezfdJsGSak7owJAt0sZbscXyqOQF0ZIzGktb4UTiw==
X-Gm-Gg: AYBFou3XxAaEyppGvYRk3iz4B335qsTig7Xr4QhZVv4yTywlDhKlofUxoDcCZQhhKhk
 MK9XSm4traF+n9njDY6QcT3lRB6/JzitMFYNf9luFnEOtZXqNMBD4EcJq3N3l496SST1BtS1pKX
 tSoYvJli0MWIjcEhET6dgKq5KHUr+iAJo8uC63IJbVgRs1G/eqFnDkY18fxmPtfsPGIOgoIWtT0
 TlEghDfsUjCxUYXNtLH5/q0RPzDjnfAOc477m2I/0R52WA9tnMWh5IsI/D888omfb0eCUPW/O57
 YJ0gme7JveA3kq8hU/rH4OUnrstnDdh+Tf+REqM2dKmCOGIgfdcNRuWjRtIokXivgpGCVe8vVcA
 DPnoAKFEHPHlBULPXoOPqwaGV+l9wwDgAimZ4R7LNCCr+sWrnGEioJsFZUY36SGiUHg1MtroX86
 xMWAWDwouB8Gpnn5C1t1MynVOetLZXO5+IC6neTJo=
X-Received: by 2002:a17:907:868f:b0:c50:475d:980e with SMTP id
 a640c23a62f3a-c50963ced7cmr207753166b.38.1794574966282; 
 Fri, 13 Nov 2026 05:02:46 -0800 (PST)
X-Received: by 2002:a17:907:868f:b0:c50:475d:980e with SMTP id
 a640c23a62f3a-c50963ced7cmr207744866b.38.1794574965555; 
 Fri, 13 Nov 2026 05:02:45 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm4784229f8f.34.2026.11.13.05.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:02:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Piparo <holofermes@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Barzilai <amit.barzilai22@gmail.com>, Mario
 Limonciello <mario.limonciello@amd.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: solomon,ssd132x: Add
 col-offset and dclk properties for the SSD1322
In-Reply-To: <CAB3Lz5a67uvP3+1fXd8iUeJWzH8wUoPdauu8zVW4t4KXMbTN8A@mail.gmail.com>
References: <20261029205751.3513474-1-holofermes@gmail.com>
 <20261029205751.3513474-2-holofermes@gmail.com>
 <20261030-dynamic-oarfish-of-dignity-feaef6@quoll>
 <CAB3Lz5a67uvP3+1fXd8iUeJWzH8wUoPdauu8zVW4t4KXMbTN8A@mail.gmail.com>
Date: Fri, 13 Nov 2026 14:02:43 +0100
Message-ID: <xlv1wlqgsx3g.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JA9AWBU2j31GlCzY2dCSwG-PphToyG4XMlf87m-wXGE_1794574967
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fabio Piparo <holofermes@gmail.com> writes:

> On Fri, Oct 30, 2026 at 8:06 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Thu, Oct 29, 2026 at 04:57:50PM -0400, Fabio Piparo wrote:
>> > +  solomon,dclk-div:
>> > +    $ref: /schemas/types.yaml#/definitions/uint32
>> > +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
>> > +    default: 2
>> > +    description:
>> > +      Clock divisor.
>>
>> Why this cannot be deduced from clock frequency?
>
> On this module the SSD1322 runs from its internal oscillator, and the
> external clock pin is not on the ribbon. These two values only set how
> often the panel redraws.
>

Yeah, the property name is misleading. Note that properies Fabio is adding
are from Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml,
which is for another family of controllers supported by the same driver.

The ssd132x, ssd133x and ssd135x families don't make use of them. That's
why they are not defined in the DT binding schemas of these controllers.

>> > +  solomon,dclk-frq:
>> > +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Use either existing properties or - if there aren't such - existing unit
>> suffixes.
>>

Again Fabio just took what currently exists in solomon,ssd1307fb.yaml, I
agree with Krzysztof though that these properties are not nice and don't
really describe the hardware...

The ssd1307fb is pretty old and was originally for a fbdev driver, then
a DRM driver was written based on that for ssd130x, and finally the DRM
driver extended to support othere families, which had newer DT bindings.

>> > +    minimum: 0
>> > +    maximum: 15
>> > +    default: 9
>> > +    description:
>> > +      Clock frequency, higher value means higher frequency.
>>
>> Why would the frequency be fixed/static?
>
> Right, it doesn't need to be, and I'll drop both properties in v2.
>
> I still need the redraw rate to be adjustable. I drive this panel at
> about 200 FPS, and at the default clock it redraws at about
> 115 times a second. One way would be to offer the 256x64 mode
> at a few refresh rates and set the clock divider from the mode
> userspace picks, the way panel-newvision-nv3051d offers
> 640x480 at 60, 100 and 120 Hz. The rates would be approximate
> since the panel's oscillator is not exact, is this a good way to do it
> here?
>

Fabio, I suggest to just drop this patch and as a first step just
set a default_dclk_{div,freq} in the SSD1322 struct deviceinfo.

That way, your driver changes won't be blocked by the DT binding
schema changes. Later, once your driver changes land, we can figure
out what to do to make all this configurable from DT.

But Krzysztof is correct here that these properties don't seem the
correct way to do it. They are just exposing raw register values
in the DT, which is not the proper approach.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

