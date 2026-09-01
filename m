Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A94AC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD74B10EEC0;
	Tue,  1 Sep 2026 19:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+AJT3oI";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7CC10EED4
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:28:08 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c252dcc5143so2193666b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788290887; x=1788895687; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JTuffngLp6NHCRIvBVVHOhPBP9shIWiSyWJB5rJizD4=;
 b=R+AJT3oIf/J5ukckqBa+3TENAp19PmDf6GgXfwC3z0+dYCYb0XVAhrkIWRte/9pq17
 +Tcb1ZkWAmNM5RiAYkmpnXdTYspxakD0vGfwdbghOVjeegYFD5MhzDbsCjXSiKNV9+oL
 yJ2lR63hSj17HMXD+IxJrFDuN0lIixlYsEgGhAmoKpTM4VfePqUQMQxDSVvNcsGnjXpK
 pkxT8Xzey5VY82jAKFJoLFIHHaUUt2PBfuaa0lyy2PC34m18s9G+0zX+4T+E4quDUx5U
 qLLtU6KHOSFi5jdbMUsVx/o/nqs2xXlup+wcvsPyjg5R3YCIqVAv3SLsAsQNdeLXfiIC
 GAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788290887; x=1788895687;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JTuffngLp6NHCRIvBVVHOhPBP9shIWiSyWJB5rJizD4=;
 b=CNtkez/YECpJhMA2gxDLSBBYuaiObTtMBw8LdBHSXJ3rkPaVBMFLeLZhThzzA/VJ61
 3yu0fCxqptBolmMYF51XKmwQwRnFqtEfC/10TcAg0Pi/J/oGq1pJhFwSXhMk/CUURtfi
 0TH0R61L7tM/OH7XDPGS6C6BLKgQlu/65fF2xC7SR9xBB1GvFYgmYYUWYDZkPq9gVe0X
 IeHcl2iv8jAv8+GJymMfdnUAl9VOn675G6dIA/f3MvV5FTKNaxc+/WnwgMn47h7BxM4N
 lgLA9sEy3llNH3VSuMQ/vGhtUnR5k90gfnDhoq7B0YR4rVID3y92Uc1B44a1QscEFlqX
 PAaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpl5hY+rbRNsBhn/W2Zd/SZqiMGjc2KEbybfSIlO9/jou6mCTfkQSRnJEo3vHXRcVEH7lW0WGYCsq4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lzsYK5/ioqx+UI1Wf4IaRSNkBRFWZYD+KEWimXItaVejl3XAHy
 XLoOm2v2mcjzbHKnqhHqqh5zimvstgy0Jk/dNn5vrnKG97WxnBfvP+mI
X-Gm-Gg: AR+sD12f3g1JJ7DmDk6xOBk1wYDHErpFQH9z/Xgubu8toJwymTCcpnPNbCHWZbCb6YS
 qku4To/eTUyNbyiVZ/EVoR9CJNpfMbmonyhPsD0VHl8VXfa7M3nfjb7JWK1hpPPdp5f8slHjy8G
 gwql2O9oVHgt0niEn/Cj9pk1XEWod1CgOqdoBPwhzEFaMcA7ja38nr7r5bq/pP5n2P6RAcJgdkF
 SDftG22T1huEUcbhrPsAJ2O5HcSj7g/RAkZ3XDrNJPx1hBcEJuN+gzx6GT1d7t16wgWzpOmIGCr
 uU7OIvTeJmeze7P2Ov1ZpBmEgx1zwmWNXKIikNFlWpiob+1zinKQqmOaFF8rMa1/hmzXmWjRBd2
 24JlddAronX3hhN9mtZAO2KzPc7cpcSGq2YEKVjlrjXeue6FBe8NyjhFMbpZs8a+OtimT89wR+M
 Lo7HJXk2aIS6IJzIxZ8BUR4Oi/wjUQ3c99xsYuUTEa4bbY+D7YM+BWLQumVbeUrxkanttvI4TDG
 JcjkpYNvGfY4qQTA0wJdtyyo4Kg/DkhVhX2f67nXYBzsm7M
X-Received: by 2002:a17:906:ef05:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c255746474cmr1136558866b.4.1788290886866; 
 Tue, 01 Sep 2026 12:28:06 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d002e542sm15212566b.14.2026.09.01.12.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:28:06 -0700 (PDT)
Message-ID: <9480a7c15ccc389120246a1403ea1860f5f05b56.camel@gmail.com>
Subject: Re: [PATCH v1 1/3] drm: Add passive_vrr properties for
 passive/desktop VRR
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Fangzhi Zuo <jerry.zuo@amd.com>, adolfotregosa@gmail.com, 
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Date: Tue, 01 Sep 2026 21:28:04 +0200
In-Reply-To: <20260901191251.2653684-2-jerry.zuo@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
 <20260901191251.2653684-2-jerry.zuo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
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

On Tue, 2026-09-01 at 15:12 -0400, Fangzhi Zuo wrote:
> Add the PASSIVE_VRR_DISABLED atomic CRTC property

Michel D=C3=A4nzer already commented on this:
https://lore.kernel.org/amd-gfx/c6a852ae-4edf-4336-9f2a-448c296cc045@mailbo=
x.org/

"Having a negation term like "disabled" in the property name can be
confusing (as it involves double negation when the property value is 0)
and is better avoided."

To this day, I'm not sure how to better handle this, without the driver
just forcing VRR on it's own. Consequently, this will enforce ALLM so
probably there is a benefit to leaving this configurable and somehow
default for HDMI.

IDK, smarter people can probably deal with this, just wanted to forward
the comments I received previously.

On windows, AMD driver just doesn't care and forces VRR signaling all
the time, without a way to disable it.
