Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F7AC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8671810E1EF;
	Thu, 20 Aug 2026 18:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Lr1+46gD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B79D10E1EF
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787250980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5nqpu3ZqFlUyLUMsvX3rrVYOr33g0gJgBhNDeFcm2o=;
 b=Lr1+46gD5wM1e97Y9NNUKe9Xp55/0Htf+wD+Kja8bVK2aiNn1JlyZC9KZiumgWGWNU0FAN
 OANYeakVzFqTvkowLEG4me69EwbIiKgrO1qBR7B0IYq5XXRk8XJv65egLDcUJ+NuiO021c
 cW5JUey5STz8259CWTwfLafnh8cDXME=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-n_tHb0ZzP6eUPrkHa0xo3g-1; Thu, 20 Aug 2026 14:36:18 -0400
X-MC-Unique: n_tHb0ZzP6eUPrkHa0xo3g-1
X-Mimecast-MFC-AGG-ID: n_tHb0ZzP6eUPrkHa0xo3g_1787250978
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso2385951cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787250978; x=1787855778;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L5nqpu3ZqFlUyLUMsvX3rrVYOr33g0gJgBhNDeFcm2o=;
 b=a5G1fTGWD025FxabBvCPwG/ZMPVeB5QLSJ/n4uGKJgTLAIWmo+9iHO5u/Wp4xKL8FC
 qUJHltssOWPKiOtfLta6NMUBPON6aIGdklmcK8l4YPqA4dxtyZOUcNzWJpRn6uMmSVXF
 z4/nL0NcTqgB1JAKDizgK0zgWBZg8oBP7o1Mgfe/pY8MIFpAX+pZf9lOWMOVRHrvS2jw
 H4rw7RsGt3f42D1hBpH659nmrsOB4y282MHCENle1ZDHl1O612lgRJdslZ8dGI1DF5Ls
 eRRVhr0RLiB2RfXYKXe3GudkKbh8XLrCc7eRZZ349ltnKFIc2TjJFSLJmC53aky0MIUv
 F8AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNpFLQ7pIpHHhLudHG+gGgcTCrmu3T/Ouq3I+xIHvL6aMYc8f9dfR8uLlWPnp4lSHO4171N3QlrC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2D/nTqfV4ZjlIg28KP1za2hZ8H/3W7VKraVK7I4LicBnjEarW
 FWxqhZGT5/fsycTPJ4tQjt9p7hiSppyG6ZV9QrffzG1Qyv++r/aXo7LBHkv2O3AvdFD2BSN0CGq
 5saQ9fiNl9fyYZiBFwoBwnkKcrmGvM/3c2kRkhbS1aPalhNeFEKWq8LO1Ws0qyhRjjflRcQ==
X-Gm-Gg: AR+sD12Fj+tHS68ibQYQW795/wSjVyDMinJsnycW29RRNLp2625sOlhivvPQeykL3m9
 G3yWO87+YFN/EBHDd5GWqFvoSWfZ3ujjFSkYGPbv0/fXvPEdlNmseAYCPKK3n0+2PqKB8gecj/J
 t2pgT+EjDlzXcFPqfGuncqxKvdY3LFMsqf9Z+ca/WKSt/nL0vjNDjP1EqjOC3Q/ndMRQJdKcAbL
 nxENPTkTVyKB5o8ZWRm8PwHd0sRVf4l/9R4eS/jPISffhJuhUAmEEKFhKfyCRaTVpAcUcL6dNaK
 fsAkxa0U7IGu3Zcjv98gRg0KgUU3Dd2icLFYizAxisUU7+j2s+aXRCAkVyBq2HE/d2zcOrrr
X-Received: by 2002:a05:622a:1925:b0:52d:9637:5546 with SMTP id
 d75a77b69052e-52df5a4f8aamr3812241cf.33.1787250978283; 
 Thu, 20 Aug 2026 11:36:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1925:b0:52d:9637:5546 with SMTP id
 d75a77b69052e-52df5a4f8aamr3811731cf.33.1787250977830; 
 Thu, 20 Aug 2026 11:36:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5edb4f75sm43971916d6.1.2026.08.20.11.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:36:17 -0700 (PDT)
Message-ID: <8e39067b5dd30b8e345c55bbf156d897322c6e70.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing
 the connector
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, linux-kernel@vger.kernel.org, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 14:36:16 -0400
In-Reply-To: <178682657122.3795552.6920623796751043528@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.4096452389040554615@gmail.com>
 <20260815201130.7BDDF1F000E9@smtp.kernel.org>
 <178682657122.3795552.6920623796751043528@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fRbCSunjNUD7NLMjeRvMUuY82DxOeTU-5SZ2wP1qVaw_1787250978
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 2026-08-15 at 22:42 +0200, Marek Czernohous wrote:
> But the wider question the bot is asking is fair, and my cover letter
> answered it too confidently.=C2=A0 It says "there is no fourth patch here=
"
> on the strength of drm->hpd_work being drained in
> nouveau_display_fini().=C2=A0 Having looked again after the bot's mail: t=
hat
> drain runs at nouveau_display.c:600 under "if (!runtime &&
> !drm->headless)", and disp->fini() drains it a second time under the
> same condition (dispnv50/disp.c:2686, dispnv04/disp.c:72, which I had
> not spotted when I wrote the cover).=C2=A0 Both of those are before
> drm_mode_config_cleanup() reaches nouveau_connector_destroy().=C2=A0 So a
> late irq_work really can re-arm hpd_work after every drain, and nothing
> drains it again.=C2=A0 Whether that is reachable in practice I do not kno=
w:
> nvif_event_block() on conn->irq has already run by then, so it needs
> work that was queued before the block and has not run yet.

Actually - after rereading this again, nah - this isn't an issue. So
long as the connector IRQs are blocked at that point, it should be
good. MST connectors aren't, but that's also fine - they use the IRQ
notify thingies of the non-MST connectors, so they're indirectly
blocked by that.

