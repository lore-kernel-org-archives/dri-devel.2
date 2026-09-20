Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFF6C982D0
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 06:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D8A10E115;
	Sun, 20 Sep 2026 06:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="hgui0ygf";
	dkim-atps=neutral
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com
 [74.125.229.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1221010E115
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 06:46:51 +0000 (UTC)
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b5e4f1801fso2051696e87.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 23:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1789886809; x=1790491609;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NaOoXMCD5+08vNUZK7B5Sw9F8Wgv/VWmCEv3fUCICio=;
 b=hgui0ygfQDTeY5q9s7Orew/ruXzx9raIqHz+qqM276SNKo9XPigpZy2Fi5kWAq6u2v
 YX2q8vQ1bqSdfxBCi6kf4iyzWlE4Ct6xCXGJCsSqR9wc7dVOgp6c1zYlXWvkJMe6PUet
 J4zLXlqCULBnh4qZR74I+WoLRYAqDwU58eOs12WGpVC4pM0fUHy87dG9//1kqnFceLLo
 TiF2p+Y+EsSWXVZQneyrA5f/s/FYITRPOlrjLpcSh+pHUIBFCk4D/LTsih8aodWMiH9f
 xstd8AFsqZKj+2dvBT/N7hu7pJtSrC3c7HeeTMwzm+vcDceWQSDmEQf0jOYzKCTkkjpA
 N29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789886809; x=1790491609;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NaOoXMCD5+08vNUZK7B5Sw9F8Wgv/VWmCEv3fUCICio=;
 b=kGGUjlaasvKVMqmZ0OeHfmAZA/+N5sgIaNFNWlywmVOxnDe2h+SNV9C2dZQ6RiccO2
 wo/0aekaEfVKqftRG/p4l2H508p2Yp9eys5RCDENCbIR4y4Fi2kTX6OPZwj/dDW0cPbG
 opoBT/sP7qL6ZPpm65Dj9ZGF+FQbfMF96Rh3JVsht3kI8anfRqreRhZS5aJ8gFf3wCuL
 lCBzTrI1S8jZILS3/6Mm9/4/dfbNtsCtSamnnwnI6MWtIGfKG2/woKUinVHZ7MkNcsrf
 18+9L4i0Emp2e0GKlZ50XkAsqF3CQQjX/0u71XbfBaOqhD3MN3gsEdBE5iZQwlYvkXLg
 F+vA==
X-Gm-Message-State: AFuF++krFZNCjozaAEI44T6NMAL/zXYhkdydjApx99QgFaJ71tEhoRfc
 Ny9VPI7dZxVY27tdVymNxrhCXHqSwktivz1TFlRrgNl5Hh0tyhadh/6/YPYJuNgMaks=
X-Gm-Gg: AYBFou0D13P3ncTgMQt7kFjxt1pxmvJnUY33Oysu2dzjP7GwrNCCKPFr7AyJa930AbD
 3V8kkwcDFmK+7DaxUp0Tq+xZMc13h2EHq1E5aSk40Wope6Pl4dmyDikbQbs+mW5NnE8+pVVYj4j
 yHVazM/y5SzJ23vtgW0XN+Ndrg9QFAuLIWySQKKw3JGnfhTyAest2IM683O9B1xbCYeBuzg2Mlj
 k+CgnGRfzBeIlzcSsHMQmVNQzOngwDlHq9YPY4SekZ1kKtANkIbbASQ+c4s4mk0EaO8B3CZo+6A
 8LjOoynkee0oxHFfnnXo8HEldOpOGT/z0aavT4vYJt1Q+/3ZIiEg/dpNjgOAfMLGk0Beq5gj43L
 EQwa1Bd5t2cP+cDdMYrRp23hcMtxqGLB6pfw5sADyqCpBNoLvMWS6Z9N/hrsY35jxJ7qHgFnS/U
 +NuYzHYbcmHSXeGHdGPg+g2G+NM58ZnO1efnodG6UwRqJO0GqYozgVQvZXJnkYvqG9qTHY38q30
 e367ziV
X-Received: by 2002:a05:6512:3a8d:b0:5b8:c147:f363 with SMTP id
 2adb3069b0e04-5b8c19618a8mr1949385e87.64.1789886809102; 
 Sat, 19 Sep 2026 23:46:49 -0700 (PDT)
Received: from localhost ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c88d537bsm891722e87.45.2026.09.19.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 23:46:48 -0700 (PDT)
Date: Sun, 20 Sep 2026 08:46:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Konstantin Sinyuk <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ilia Levi <ilia.levi@intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
 jgg@nvidia.com
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <aq-AwReIVop1qv82@FV6GYCPJ69>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <apAsfOowcG0cTvT8@FV6GYCPJ69>
 <fabric-jiri-reply.1788176464.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabric-jiri-reply.1788176464.ksinyuk@kernel.org>
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

Mon, Aug 31, 2026 at 01:45:15PM +0200, ksinyuk@kernel.org wrote:
>On Thu, Aug 27, 2026 at 02:35:16PM +0200, Jiri Pirko wrote:
>> Using generic netlink instead of sysfs for this makes a lot of sense,
>> but it may be a bit odd to use it outside the networking area.
>> I've been struggling with the same in another non-networking use-case
>> as well.
>
>Agreed, and the series shows the friction. The namespace handling is
>nominal, and CAP_NET_ADMIN as the mutation gate is another borrowed
>part of the model. I went into that in more detail in the reply to
>Jason.
>
>> - One character device per registered instance, not one global family.
>>   Access control is the file: udev rules, ACLs, an fd passed into
>>   a container.
>
>The fd-based access and event model addresses real problems with one
>global family and one multicast group.
>
>The main question is what the CTLV instance would represent. A fabric
>can span multiple devices and has its own lifetime. An endpoint can also
>be detached from a fabric with fabric-id 0 and continue to exist. A
>character device per accelerator would not provide the same global view
>as the current family.

CTVL is supposed to be just "transport". So however you use it is up to
you.


>
>Can a CTLV instance represent a multi-device fabric or the global
>fabric registry rather than one physical device?

Yes, whoever creates the ctlv instance is in charge of the lifecycle.


>
>> Would this make sense to use for you?
>
>In principle, yes. I cannot base this series on an out-of-tree pre-RFC,
>but the fabric, endpoint, port and peer model is separate from the
>current serialization.
>
>Changing transports would be more than regeneration, so I will read the
>draft before saying more.
>
>Thanks,
>Konstantin
