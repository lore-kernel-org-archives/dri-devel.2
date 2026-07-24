Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04611C531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F133710E2FC;
	Mon, 27 Jul 2026 07:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GVpdBeZB";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BB610F367
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:56:24 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84847482584so197767b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784890584; cv=none;
 d=google.com; s=arc-20260327;
 b=Bv9BQreFdGiJyhMM+QS72r5At6Soa35hpYIpIO0NJWRrV2aSgj2vMC1I4ua5dp65Ys
 1wLfRIqdl6GciUPlLHLffi4KwVfvvdowSjNbn6tn+6g4xD0ZMDeHrrzO75AnBIS3uru+
 UvR6iVUpqGHC/BLs8uNrJBiybYp5ctMYVcX8R3QcyyK+TLKTX3V12Oa8Xs882mOODr/X
 TFGFwyQkZ2bDWOPpsybYE9JTEo2q95qXAzckabDNU983v07pmq0ulRRPmDGpIfngA4ms
 FTQqeZkhhdLygkhnG+JXrrxba9DYi1YaBpAoN939Msj4dyKPTXt/2xLYbzk9IfusISSr
 YPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LaBBw1Z+OK0y5QSl9ZqQfHOA0SHi2/BpA98UbYazhF0=;
 fh=0QEbgeNZt5rukPBcSGyeLt1PQ++q0HtsnVKriapip9M=;
 b=qmdjYK1RKzvbXSjK+j4bi+UrS835JTNB4FRSqi/5/FAQj8xu//Nwj4sgG80IQ57lIf
 wrNZ+U6bIKxlTo9+d71ll12eX3LG55zLUbY4kwlyVI1KdKimR/LfWcM+suz6htk+jv7f
 tB5GSd+VBpb5JcEombU/CMGxHYOBg/dPRxTU9ZKQstwNsRUchpDbK8pzs5sFu/ZyQJmt
 wgTBpgVpumEq0Vx7RH4Bls9+bS5sCRztmab72RQcb3b0FGFS4qDbY/kWqMt19Ts1rvza
 lKyAIqbybZ2q6g9F3H/Kmd6jV3IjTdwQiswdbENQjgOjOH0hapvH9IGyLkzF6CHwhdNM
 cOpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784890584; x=1785495384; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LaBBw1Z+OK0y5QSl9ZqQfHOA0SHi2/BpA98UbYazhF0=;
 b=GVpdBeZBRJLTlqmdLLO7QQD7d9+8cKifkfkqW6YNP5EbPotMKk1q1Isaulqb5mQ86L
 cI6o58Jel45tKxJNJ9QL76RPL2YxveyZ6w2hZ5RxpLYfU/lNUKOVVpcCH0EcjhUhuq3M
 xrFsSKqXgjg8y/L/V8AIQtn08KOKl4TmmUE5bmNu7I2/HEeAsE7jJger4eESU/LNQheg
 DFyu1/RADwCXR6JIe8YHMFujvMlMsTwYHrTeJZf1VRHFYAcsHJFqpY9RZ0KTtsTjMccg
 +5ihpAce6ISXCzH6MmM0waJYGoakISKNR5RyAwfiU7WLy9cyVaUEe32Gjsj6RwZ+aa5f
 dElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890584; x=1785495384;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LaBBw1Z+OK0y5QSl9ZqQfHOA0SHi2/BpA98UbYazhF0=;
 b=sKU6hG/sAh09uVSPiz5YLgh5wIlyiSDhOTPRKQHGA5cw4snFjYwFXsIvgh75+cw+Pe
 N6uskVM/DVjJCnl1CxsWgLIzDLjj9czwxNFgxsTUgSMgYlhCqTaABVweQ6GRJr+x+YwA
 87RzH5+oIs/RFbXhLNQ5BOHQfnyNcIYCJ56R05AYeD5Hen5RSq+QEi1izFkBR6bsWfG5
 rBaDnYiHiO7WJzW8KU4fBC9EqsgOaFP/FIkTujBheh6r9AnIMQTB4c9csa+QAMfz3A6B
 iN8cqOE984nlJi8L5vpkYLUKXqeiw/1j7d7DnGQDuyovV7cTNYoi0jmKJ7KcOO/P0iJR
 IL6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoU8SwWANONBoNriupd+33C9TjPBuYXcRr68ZWR9570fYprEd5uSQYFI7x/hiuau2Ct0W/lNmvsdlA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjpvM6WWeV4NVzRGPmC9yWIVl9d1AtEu0yYMEznYL4UZN1JJ11
 iP6/XXySCXmKwI2fdAOWyIa8HA+gaW87tkavmZmE6cdUa7TMdAasPaa6/8yuOvO7vaqItgacfQH
 oQFtEc+hKbmpNSA/3qN2V0D9okXJVQII=
X-Gm-Gg: AR+sD116efBP6AInGNlJei2+gv4iemjCEyk2JJdCgaH37y5b4jDIZ1hVnE1bVsYicac
 HgNMfJQvr2xA3Mu7EDdiXtKQWxP8ARnguexqgxXrb3sX2VnWToKhEk2ZMuk3bKIuyB8Sp87fn3O
 cGjF3p0AzOrn53midtM+J+3cwkFt4gWPsQfBK0jK3BiQaviwwLYU0eZtXBIzQOEXMYP1WdToO8V
 MogmNfI1qI72TlBaCyn6OdHZNVGTGr4MCzcHphp7ACT1R7RPtjQAkpIP2i46RWSsrrFIdHtnD27
 B+yAHFodLjyg0RN4ox6k1rfZoiz5uCH2F7syt1uBZcn5pCkisZMClkc8o37oWG8BhmFxtZN5+g=
 =
X-Received: by 2002:a05:6a00:4396:b0:848:4ee6:4d0 with SMTP id
 d2e1a72fcca58-84e4e3a7829mr12484b3a.23.1784890584431; Fri, 24 Jul 2026
 03:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260724103235.57577-1-phucduc.bui@gmail.com>
 <20260724103901.GA1051157@killaraus.ideasonboard.com>
In-Reply-To: <20260724103901.GA1051157@killaraus.ideasonboard.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 24 Jul 2026 17:56:13 +0700
X-Gm-Features: AUfX_mw88r9o995VuCAisWDyQ8Qkton3OpBaQIzCfq35Vd2fG-swYYjGnXrLc38
Message-ID: <CAABR9nHd9eSsu49zhzimr0NVSnb6NnxU-bR=3rkeK99K_7CHAw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/bridge: adv7511: use cache_only during power down
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Hi Laurent,

Thanks for the feedback.
>
> Please give a detailed example of a scenario where that can happen, and
> make sure you can reproduce the scenario and see the issue on your
> hardware.

I don't have the hardware to reproduce or validate this scenario,
which is why I sent this as an RFC.
The idea was based on the recent regcache_sync()/cache_only changes
that were merged:

https://lore.kernel.org/all/20260720033238.52479-1-phucduc.bui@gmail.com/
https://lore.kernel.org/all/20260713050312.38729-1-phucduc.bui@gmail.com/


Best regards,
Phuc
