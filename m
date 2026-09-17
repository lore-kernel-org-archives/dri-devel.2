Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA10C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A52510F076;
	Thu, 17 Sep 2026 20:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hyp29NaH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1706410F085
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789676805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya+cIlw22G+pUR3u7ErvGhK75QjcpcCjqrMDeSWo6yw=;
 b=hyp29NaHyZlOgkDHgmbmNYOe6bCBS5j1cJfFeAY/sRcguEXVoK7GSGbLNIvx5SmuWsfGEy
 bA0r0qltyRY1CWwWNtRJssBy4ykZ8OvA5r2zmcHy9FP1RR1atYU0qYEWa9qFZ1Jmx0BlRL
 oLZQDwCe+dah/JQ6Wag8naXsvqMci3k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-F-0POpC0NB2l1E8QHzZo7w-1; Thu, 17 Sep 2026 16:26:43 -0400
X-MC-Unique: F-0POpC0NB2l1E8QHzZo7w-1
X-Mimecast-MFC-AGG-ID: F-0POpC0NB2l1E8QHzZo7w_1789676803
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53001b668a6so33922821cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789676803; x=1790281603;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ya+cIlw22G+pUR3u7ErvGhK75QjcpcCjqrMDeSWo6yw=;
 b=Hw2o9Emy4ZARzMGzwpCp7afBHy7KMnvO7Iwj64oOq3aOhqeKrdFzRlH2HfL0SehsgL
 nsD+pskI639f857UiVO1+Sy+cXbS8KRTPyrR+/xV0tIxgPFjKrqPS3lpaB/xVaqIJqgU
 F2bUK7yXIpSpS1KmEqGKG3cd/t2UtoauOGNqGA++1G6Q12ml0/WjH7WBcgukHaQLhzCg
 eSPzel4qw3ZwL/IUlQDS+Xe0C8vpb1KPMi5pvL+Dmk7VUICbbxYrB4mdTmJMF7h8xKMA
 DA4HcmZFakZhKNmw72+b+bT2OuYqixHsGYdiVlombudUukKIH/b4+ogKVzt+bTVNqyFB
 eokQ==
X-Gm-Message-State: AFuF++nPyEqOmOzGiuywxYmO3gvi8K7L2llRpPTtOuc7yK2o42EI5he/
 SdJHZRMki1tr9/373ZkPzRInAYYulVsx8VPINeno3G7iUUskyKXU11+4QIdgfJYRxK6SKyxa+pj
 l1LT8j9yxz8Ci8z3ail5IgrCWLNEod7xX+XPPDghwReDuZgK71ki/QaWa5gNTOFtJoY9dkg==
X-Gm-Gg: AYBFou1ooelL/QQnXBBQAVQ931cebtANDxFNDjfl300UJVXKHPvnDrK/kpGLB55OmYU
 n4qsRX0LF0vbJ6HNpUlz/UKXafLY0e73huyoMO1SjndDWNfHP+9uH+AOrav7v6hePK9R31JVC+H
 NScmCQMXpkyEnMvfFdMMp/guClZcDYf2BZm3Y+GGGhTQJSLj7sQcOqOEjr2V4ni7bcS6tzPGV2I
 n4n0qkBXRaeCBUDOtHrJWIyxEiR3aTTLqu/Jq05XhZqiwHQZ/+Uu1OpCUhqRTxUCmusoa81MLi/
 lZbgmmOBAtPjoOykzkWe9ysLNFO7DR+PGM9DH5N+ZEqzpvyV5+ZLWf+y0FTTRicsxfn9QPdY
X-Received: by 2002:ac8:7e81:0:b0:530:256c:3718 with SMTP id
 d75a77b69052e-5329e4f5460mr6673671cf.38.1789676803116; 
 Thu, 17 Sep 2026 13:26:43 -0700 (PDT)
X-Received: by 2002:ac8:7e81:0:b0:530:256c:3718 with SMTP id
 d75a77b69052e-5329e4f5460mr6672891cf.38.1789676802166; 
 Thu, 17 Sep 2026 13:26:42 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c805e1sm6287236d6.19.2026.09.17.13.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:26:41 -0700 (PDT)
Message-ID: <bd730e30c96bea38d8430460ee73f073e280374c.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in
 GETPARAM ioctl
From: lyude@redhat.com
To: Jim Cromie <jim.cromie@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 16:26:40 -0400
In-Reply-To: <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
References: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
 <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2jjksUwaFxMrWKJDKjTD-KQfDCu2cIz_ptfUE0E94jA_1789676803
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

On Sat, 2026-08-15 at 11:30 -0600, Jim Cromie wrote:
> When hardware or firmware initialization fails, the graphics engine
> (gr) or device functions may remain NULL. Attempting to access these
> during the GETPARAM ioctl (e.g., NOUVEAU_GETPARAM_GRAPH_UNITS)
> results
> in a kernel NULL pointer dereference, causing a crash when userspace
> (GNOME/Mesa) attempts to probe the device.
>=20
> Add safety checks for 'gr', 'gr->func', and 'nvkm_device->func' in
> the
> ioctl handler. Return -ENODEV to signal the missing hardware state to
> userspace, and use NV_ERROR_ONCE to provide diagnostic proof in the
> kernel log without risking a console flood.
>=20
> RFC:
>=20
> These crashes may not be repeatable, they happened while I was trying
> to build nouveau as a builtin module, with binary blobs in the kernel
> image, on a laptop with an encrypted disk.=C2=A0 Gemini tells me this
> won't
> work, so I punted.

"Gemini tells me this won't work, so I punted."

I'm sorry, what exactly do you mean here? And could you clarify what
LLMs were used for in writing this series? Code generation, analysis,
etc.?

>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

