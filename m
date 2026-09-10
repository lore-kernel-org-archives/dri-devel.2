Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA11C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4230210E29B;
	Thu, 10 Sep 2026 11:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BpuNTwAQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108A010E29B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789039003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YIwXGsyCKQHxSzxIAQbVXvS5Mx9+nIZhzE2of2xmdw=;
 b=BpuNTwAQnK3qHtq+oAYnE5duhf87BwfbfE5HYRVTq83Ev18TWYUp5SWT17u+Y4eP56VBSZ
 4M5Dofy9ggw+mh/JtMjlD4rrUWTOfYVwoliM7HzM4AF1Syh+jAXENn/ZY4WJ8MIqyPaFJW
 6SZ1pmGogdiunwiqolXSJOLjPmCjeIc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hjqiD9hENCaLR2RtQgeK5g-1; Thu, 10 Sep 2026 07:16:41 -0400
X-MC-Unique: hjqiD9hENCaLR2RtQgeK5g-1
X-Mimecast-MFC-AGG-ID: hjqiD9hENCaLR2RtQgeK5g_1789039001
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-482e2541c30so528044f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 04:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789039000; x=1789643800;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5mtIFV5PhR8YaKeQBUyczM0xpE62wYImfp+kBJSJQh8=;
 b=lk6qP5jaZtPaHpi6c8z7QgjuKgXvUnplFPieI9xo6pWgI5gf4AJ7/KR8kcXmcM8vkb
 BSKqV+lMEMTnbb9EmRcV1MAeBrwWJ1JpCE9+yauV8WOYwSYkveKjU8K+oer6ksKzgsNH
 uQwfZGi+9QWaktyVAY/pRf1/VarRvwLqvlMghAePswhdcBCaLORrytgyYSXf3nYQ7LH/
 qZeqGTVkHePoCrczukjT6nBSdIdSCk52fi9bGYa9V3w1l6SWzS0lIIMOc9zqSnNPdg4X
 FGE1IXXweXj6+ogk3jr+8gvRm5cUwF9EZQmh7nzqWHHE9OMYPWdzAWe/z8igwm0ZXmtH
 OJ2g==
X-Gm-Message-State: AFuF++mZY2dv7MSZHbpp00vFUyXPTHFy5rgbFX95LUYbd//B8MySnjI2
 snRDO7tNY66QbzrYap4t8vd6otmrADVh4GU2+vleXOpIlXpxTRi1sDaQTpns6yBjwn8kcER23Mc
 +C8KCiggiV9qC0t5OC2rNHmTagkvgwCbu/adI19sH6zEb6TWb7Ih7X3Q5vNE0m9OH0YAj0w==
X-Gm-Gg: AYBFou0UKQ3Urz44TMCt8o671Cfm4yXG7Hw1ZpuMzjVKdgeZvfXCenhLWtW8DCEp6K2
 EJWNg4dhBRnNsftFkeFz7VjTOcbb8c2xVlSXZ5M7k/P0lyUsGzp51besnxsvT//7bPWQBCGWZPa
 l2Og2k6frByNRlELfa2JfGHKXlWCGvIifsdkhVAoqbD3mg+OCc8QbIgYKpdjbZGLAPhtbFdjZji
 Kblfyw6lKaB+ed2btXCfShX66FNe2oflHs80wO4rr6GV5Jxj/4lOqagaIJpjDbrFDVAwhGmSyos
 ZcN/O5WJupzBfIgCUkppnrP5KabjTSPf9APEC0uXh9K0GixNVNgOnqRLpoOiXj1KZmAukPMdWrr
 GfE9Q0TuvtgkvaW/1YEtqoROY/9gqCXQUQ+I8EqhP0zKW9cMaC/fNHuzs3Q==
X-Received: by 2002:a05:6000:1801:b0:485:8226:c698 with SMTP id
 ffacd0b85a97d-486e0f8565fmr3043549f8f.23.1789039000679; 
 Thu, 10 Sep 2026 04:16:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1801:b0:485:8226:c698 with SMTP id
 ffacd0b85a97d-486e0f8565fmr3043528f8f.23.1789039000339; 
 Thu, 10 Sep 2026 04:16:40 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48591eb3d3bsm34310512f8f.0.2026.09.10.04.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:16:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: sashiko-reviews@lists.linux.dev, Amit Barzilai <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
In-Reply-To: <20260823112814.896AE1F000E9@smtp.kernel.org>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-2-amit.barzilai22@gmail.com>
 <20260823112814.896AE1F000E9@smtp.kernel.org>
Date: Thu, 10 Sep 2026 13:16:38 +0200
Message-ID: <8733vhmk4p.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zOja2phRfA0AqvpE9Izxuq98pmdvO7CEAxyDTaFNbBc_1789039001
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

sashiko-bot@kernel.org writes:

>> +allOf:
>> +  - $ref: solomon,ssd-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - solomon,ssd1351
>
> [Severity: Low]
> Should this properties block also declare default values for solomon,widt=
h
> and solomon,height?
>
> Other bindings that include solomon,ssd-common.yaml, such as
> solomon,ssd133x.yaml, establish default geometry values for their specifi=
c
> compatible strings in this block. Without these default values, device tr=
ees
> that omit the width and height properties will lack a schema-defined defa=
ult
> geometry.
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823111959.17=
029-1-amit.barzilai22@gmail.com?part=3D1
>

I think Sashiko is correct here. Let's include the default values in the
DT binding schema to be consistent to what is done in the other bindings.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

