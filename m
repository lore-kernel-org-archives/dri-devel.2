Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ECBCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D63B10E3E1;
	Fri,  2 Oct 2026 07:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UaFFM1M3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D3410E3E1
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790926663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WV95wAdEBW1v5k5upi/D6jheWF0Dkl/DxQsG1HnT/70=;
 b=UaFFM1M34rq1KbgrY4ZV43tXC78Sbs1+Q1kFeAp3HTrt9wbb3S85IB41tgfqxRZw50WP0Q
 L1y0mF1CNeQKHRDL0LHRrG9OIOImhJH2EWlwpG8Ley69BKhr86LH9K0t+NApUbWUA9Lflb
 /cWL2xlvWd6CoQ2/ixfUKllf52NhFEQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-XihWNu9VOaig-oKvG2lA5A-1; Fri, 02 Oct 2026 03:37:42 -0400
X-MC-Unique: XihWNu9VOaig-oKvG2lA5A-1
X-Mimecast-MFC-AGG-ID: XihWNu9VOaig-oKvG2lA5A_1790926661
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so53581445e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926661; x=1791531461;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WV95wAdEBW1v5k5upi/D6jheWF0Dkl/DxQsG1HnT/70=;
 b=0DnxDy1i+tTePV5ZCCkTTf22GeJHsn5tBS/p1CWFxddeHC/RVjt6oACx8wU42mnESY
 DoCzRuNw7+EVgp0QSef5Wx5A/aVH1Us4izt3TahFYcCaFYIEb3aUdvyJWRLcUmJWtWQD
 bzCQ35za103R/dNVyUn0/iPAO5eOTyzlVuT2MrZiGSqWLKDk56Hu2neq9nRHLoX21ScD
 PhSEScf0Z3d5ugGp6P5sO+dhDv5lINwFHmdHcYQnfKQssSinON5CNOJviunm6iwZzHaM
 Eh6g9tVD88PL6/g92NMfcTKzTG8tdSFaza8ln/FE80tv+tlp42VsfJz7urdKW6ZSgZde
 5hsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXfR13C5FsnEp9yEu3MYHYY/U70CouHBrKgom4JnWjAAyvHWLqLxdNNTJeT44oT7WVAn9d4NB5cqM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljW7pPWEhKg5G6ZInLkFguNrZW+jUifi8m5aiNuTuYkiNFDXHR
 CocyHU7IjZ61qF+SSAzSrCX/ASirvZ7ioMZaT35rva1dUiURAKoa46bpgWVtCja5cttxlouoy5R
 T7YHUGpRy7lBrpdbPBuxS1+NnVK51wsgj+iZBxjYdgsHjoOQdE1yaYtfzU211CPbEfnvU3Q==
X-Gm-Gg: AYBFou1KW3mAejCQtmwCAk8BEhlmIn//JallBh20/Svn1SUxIFiTZ4VCaFSeVkr/UXn
 wAeSfYBweqGE63Z5fc+uRRO+rHzg9QodGl4jee4OqFJ/A1YSs5sPOuo3uz+SPtWClioFuS3nEsU
 WyL6B9LM0M6Din//1YaE6xUy+sn4/9bZOZD+Z15S2JA85FkklTFEPjby3nX56nUNZrfx8hfvZx5
 kFhuqkZjre1xfgZcl2eH8ROUzmAQWcqo4rt/QIc9TvPo/oTlhC0SIxjoEEQpDumDU+5FlpYDcdG
 dcEk2NxO6ApMLFER7mNA/uxGpI140KKivRxKLWWPpLK5UcjiFlZa4t+UVscqXTZNhOsbadBARzl
 bRb8zAZK4NJpkJhDD2Dsp5QBVzr+g8+lzKcP6RZNHKjzW7iAd0jSYG2pxjT9KhM/BpA==
X-Received: by 2002:a05:600c:4e8e:b0:49f:fe79:62f9 with SMTP id
 5b1f17b1804b1-4a0276afe79mr34251365e9.25.1790926659537; 
 Fri, 02 Oct 2026 00:37:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8e:b0:49f:fe79:62f9 with SMTP id
 5b1f17b1804b1-4a0276afe79mr34250535e9.25.1790926658971; 
 Fri, 02 Oct 2026 00:37:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027da120bsm63581875e9.0.2026.10.02.00.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:37:38 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard
 <mripard@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
In-Reply-To: <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
 <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <828c9108-2db1-45a6-9301-19159a094301@linaro.org> <ar4CRTMQGs5_nGKY@houat>
 <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
Date: Fri, 02 Oct 2026 09:37:37 +0200
Message-ID: <xlv1cxtsft8e.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1_JKHRG8gkAnwWuF6pAKCZPZWusvd9kJFUhuOjDuil8_1790926661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Neil Armstrong <neil.armstrong@linaro.org> writes:

Hello Neil,

> On 10/1/26 08:50, Maxime Ripard wrote:

[...]

>>>
>>> I don't want to add a supplementary maintenance burden for the sake of using a cool
>>> technology which has serious drawbacks and dependencies on user-space even if looks
>>> really cool.
>> 
>> Spoiler alert: v2 won't. I've got the in-kernel loader to work and thus
>> you can have a built-in panel driver that works without user-space
>> intervention. So this is not a topic of discussion anymore.
>
> It will still have users-space dependency, meaning the BPF files will need to
> exist in the fs when drivers probes.
>

It doesn't have to AFAIU. The BPF programs could be built into the kernel
image, just like firmware binaries could be built-in as well.

> Neil
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

