Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CA1CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2013310F495;
	Fri, 19 Jun 2026 08:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UK036SSU";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6201A10F495
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 08:01:32 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-beeba001887so227805266b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781856091; x=1782460891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=3mJ4+yPazGX/EmJnGyTTRQON60jZ3TTYbd2qIckSE/o=;
 b=UK036SSUDrj/56RaFEHwDeDZQyD/VbLcT3WT8VydelAcixSwnT49DBdJoleWgKdjat
 v7O6yWzro8T5WGomUh1lhuDDtRDdG81xUfaGJAruGq2mB6DAWdPUsRGBUe2HUT+t3f6H
 SJaASChieaOIhPjERgMZULCbzS8nrgdHQKkvXiRfCSt/zky+55S8w2vfJ+Y7B+2Q+BEz
 3kW1UfXa+WaPWC/QFREp5MrMtZTW+1XzG+pAreZn47drbVqzNFMjkUWcsISDDSn+Enac
 ZdfmAbaztb3khNI4gJDI+mUBqSwSJSG1Jdpwa/ynWh3L0g6oivZ0x+9GVUxV+sBSxLiC
 Nq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781856091; x=1782460891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mJ4+yPazGX/EmJnGyTTRQON60jZ3TTYbd2qIckSE/o=;
 b=sSAkH0MqbH4w85tUR9gQOrYHJSMFPRrKl4XexmXPa3GMN/OpYDcA+SzM66cQCOdh8I
 0LhK652DdDTyxu4wQjoiPGVpDJCdKbtYvNNyJvGdvNLcbiMw/Lo9TVIELEgiu7wc/KSI
 fSWaSDYsOvrGF1CtxADyeQ4bChUhVJ3pGQyVFzTEwjHnKQoUtWUGxfNSwOoKAawTsQP/
 dLGJgI6JCA9SaypzBK0fZ1sn/e1XrSel/YKL5+kTVvHGQTDhIeI+J22O//3+CQirEXNx
 ue/rVi81BXU0yqAd18a5ySzalrfAd4nj8SaRZZlh8KBFe74+A8GANNR/LLxbNT493P2+
 cncA==
X-Gm-Message-State: AOJu0YwnoEOUhcU0riydyiG2jJOYWJpmd5dmAO7Nr7V397xnsd/L6a1c
 yxczsQKlqD926cl/h62dmIV0tgMLUilOBeTUBMtlOoHINcJMT2OVuqHK
X-Gm-Gg: AfdE7cnaw03Pa173xdXEjCabQ8yU/M7I+PPyg/w0awQ5tPvev2EwoHLnbWzirpIvzJ5
 udcCgJsqMOY1BU/WChvA7y8QmS+TIT02r9kwGWYcxs932mRFni1nGJuVTj/zTL4XkbF/TWFdJOI
 97Lf6PO2iWs1hAxAy/7LH1fsRQyCtqtU73bdg4vT9kVJZyhHwL7LRf0H7WSvpsBXqs7OeMBiSjl
 8QLiMe62QW02YsFYE1FVeLeT2hAf862/X1NAo9ZFWL8thLfxbwKJ3x8wkoCfkVy913sbeb21FxT
 jBCYns6bwTXFBBab5A6L6l6PGSmpAEDqm9z7IftekvkzxxTEQK7TeCIN4jFqT7tcz9piZtwY+Df
 8/jO1+RW7r0xzf1MD+a4EMvyq9+tQa77JPbccqPQbZKYmV3HjxRuH5VuFEpzzwutOzLkLz3ofi7
 2HVN5Jy+MHa/ruYF81+KEaH2ol4NZ/XPZa8ACLBUtQCWdBgsAZuf85Fw6/pxuDAPQBBmAhv2n8u
 UdRJSMrLoeSLh670boEiU0=
X-Received: by 2002:a17:907:6d16:b0:c07:3c89:7790 with SMTP id
 a640c23a62f3a-c097c4af7b3mr124076366b.29.1781856061142; 
 Fri, 19 Jun 2026 01:01:01 -0700 (PDT)
Received: from ?IPV6:2001:8a0:e962:d100:f83d:6b5c:de84:5311?
 ([2001:8a0:e962:d100:f83d:6b5c:de84:5311])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0a844f84f4sm56704366b.11.2026.06.19.01.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 01:01:00 -0700 (PDT)
Message-ID: <0e38e21a-eb7d-4503-8b3e-3e056d6ac454@gmail.com>
Date: Fri, 19 Jun 2026 09:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: cleanup duplicate dependencies in kconfig
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260618204654.458654-1-julianbraha@gmail.com>
 <9937cd6d-7724-47bf-8bf6-a5d0580bdd60@suse.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <9937cd6d-7724-47bf-8bf6-a5d0580bdd60@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Thomas,

On 6/19/26 07:25, Thomas Zimmermann wrote:
> Is there a functional difference between 'if' and 'depends on'?

No functional difference. In Kconfig, 'if..endif' is just a way to
factor out repeated 'depends on'.

> IMHO it would be nicer to remove the if.

I think the if..endif style is more succinct, and many other subsystems
do this too. But it would also be dangerous to remove it since there may
be config options that don't also have the 'depends on DRM'.

- Julian Braha
