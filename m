Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D980BC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365DD10E477;
	Mon, 17 Aug 2026 22:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="efVfvtC/";
	dkim-atps=neutral
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com
 [209.85.221.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2E510E96C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:02:51 +0000 (UTC)
Received: by mail-vk1-f227.google.com with SMTP id
 71dfb90a1353d-5bf8a2932a3so2020294e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787004170; x=1787608970;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lpevTTOuGGNXC+eEr/j3g9lgBKB/WoPLprJ5ZBHucBY=;
 b=TMkoT5NKwxMHHZt/m/OMeUXfxp7nCRYCiogCY6QSfmQdNuYunlwbNW1rkrsBYy7QsS
 ibSJJOdymPGWNoCxAExCzY+9WXVdS4upBvfEzdp/qtQ+vYzIOQzvb0unKIPAPOGlbjiN
 gATUoupMJfhaJ1ScU5W7mCbDF6DFuFtQ6UaLBvp8GyZhaOqP1BkwFJ99KgGp7VpLO1fR
 0q0mpxBd/4bs2kVsNvf8NT24V4LU7bBm8cckFfJkBP+Z8e1qpkJ2O2IYFoXAj6DyvUgs
 rRj2503rHe3t3wW33hk82Af6rJGvm8QC/o1FWpRFY54a4tsCt2hZfIN3GG5DSLq7IWkQ
 j3EQ==
X-Gm-Message-State: AOJu0Yyed201/Mpf1CwAr2hrfG2aKmzl1vBw4HBXHFZYHFrpq35OyNVM
 fuSXbTLq8jVGNQX1ytuvAhYNO1oxmKpxXRk06EQ9b5EuMvuo0ZuexvXTKIRZT9eFMBM/L2Citbg
 E08jrM5k9xeJ/pJYBB19S3JPD+3aZl40zrfAktj96FQaoRdTxgqelNnZ8agy2TvwHZSfyUWP9O1
 EZFaFc6NlKSuHM0hcBeGVzpVq/Grb+QwlfFBlMXDnYTxSfTnjdY1Z8Duk5yDxwGekchUp5VtR+V
 MI3+04JceKWJ/NROslzde7XihL5
X-Gm-Gg: AR+sD1289hhfAPMbZVE3pozspTy28F4XC/V6Z2ntmGo/BLC6USUUNS/R86a52OLVML4
 0DGP/g5xiD9tfM9+HEiE6HJJtv54WIYHNoCKgtH0Gf90d6xYFwaFzH3jvPOw5F7sWkIkOI83/fR
 6tgj8TU0qBLTRd7aIQ3G6Hb/ZpxPzE5X3lD3nd0vqieCanA6TLlk6N2MWtg9FTY/FcOV+LWLsOl
 JI5xGbaC2synoJ3Dfv0cxDKgsVpU9lR0mBrfWjBfoF6FlN1IJlzS1plely62JP9TYA5ht1T6fL+
 OtMiNnPqCkEvobvHMAkbNZGjMs5DkmUSQVercsc48j8KVbJYLWZ5raz7ksjx4l+icAcyn810j7R
 i6oGV2XzJ1LSj7ssili36YM5GYJb+73QWW1jrZiq5QSFRy4DHPn9O6XY6MtKoOAJUPVwo3QhG4l
 SeELIhjkypvfzI5QN5MO/lkn3/AiXf6K3Tm1aaHB6n
X-Received: by 2002:a05:6122:208a:b0:5c2:bfdc:f49c with SMTP id
 71dfb90a1353d-5c5ce8c30e3mr937062e0c.9.1787004169697; 
 Mon, 17 Aug 2026 15:02:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c5c786642csm695356e0c.6.2026.08.17.15.02.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2026 15:02:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91931144870so501425185a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787004169; x=1787608969;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lpevTTOuGGNXC+eEr/j3g9lgBKB/WoPLprJ5ZBHucBY=;
 b=efVfvtC/uCYNvNO3QmyEfx7qRL9AK9hzNzBIpBtTWa01gB33ww2Mh1dGvj4EgpHEZM
 SYzCQNCPwbrHSCeUlNql0Fujrp564iNnw0aY26SEsFX12YYuOrgivNgmxDIR435AapEP
 z+bety4M/6EGDkAVjGIA0Jp0s4y6w37qFlEoQ=
X-Received: by 2002:a05:6214:45a0:b0:8f7:40b8:e8ab with SMTP id
 6a1803df08f44-90c4b2a8a09mr45823656d6.3.1787004168786; 
 Mon, 17 Aug 2026 15:02:48 -0700 (PDT)
X-Received: by 2002:a05:6214:45a0:b0:8f7:40b8:e8ab with SMTP id
 6a1803df08f44-90c4b2a8a09mr45822246d6.3.1787004168092; 
 Mon, 17 Aug 2026 15:02:48 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4580f611sm18671206d6.6.2026.08.17.15.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 15:02:47 -0700 (PDT)
Message-ID: <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
Date: Mon, 17 Aug 2026 15:02:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Jellis Onsea | AccessWeb <jellis@accessweb.be>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
 <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

For the 3D enabled case, that sounds a lot like the memory leak for which I submitted the
fix to mesa recently. The fix has been included in mesa version 26.1.7, could you try with
that version? I see you're using mesa 26.1.6 right now.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
