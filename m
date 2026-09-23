Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2ACC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BDC10F8D1;
	Fri, 25 Sep 2026 07:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Orx/ngjU";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1E210F15A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:01:33 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d4ddd1d91so13534047b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790179293; x=1790784093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L5cBFxA21gxY4ecZu/0nuSNb0vunI24srETSPHg2T8M=;
 b=Orx/ngjUN78pQ5AeHviLnMFyd/o/3NEv88kHDYaKIIVjO/ywc8cHglpVcVuWvWzcz5
 MbF5Wd+R0tL669E+e/NMPiVKEwkv3EmjN+XN4Cl+e61+xkq/bxLgwqEfWwZ+fyaw4DY2
 hb7oU9cKLe0tsaXAaOiH8NAuhg6Yymh5QG/9feDRG00BTDxoyH6/0BhdVvEzCYqtPu0V
 Enen2GgeS6JyG1n6rXRBRa/NgtwNydU7fys9J7pGeZ7zCiFUMcqDbEgvqtlUcH7/hRTI
 3GZtyQxzmbEs65AsdJa8UcBSEJdrkVjZWAqBeT++Cn2EWnIffLWGYzzsKYiQCq77hI6g
 1FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790179293; x=1790784093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L5cBFxA21gxY4ecZu/0nuSNb0vunI24srETSPHg2T8M=;
 b=LyOuOIb9IyFAfaaBFYWCx4HpW9tWpVGNDcOQMuVqerb8UTT9wINKQmjF2IFSqboKqu
 retlFjrjCjeVtRIh4SeHUUIqxQlPhzbjt28gaTUqZab7FLW5sP+Txy06482Qff8hvLXC
 eGt1PQNm7MMdpJrmKnPKsvHfmcQitytRVBQDZ5yGJv1Wu686/9pijTYRx3zeoYHcWUqv
 acHnP4Ae6AMdiJD74Fml0SqA1k0Lh2xbkQnZ9I1rMNgY83bs4AlQxmdiwVRzI1oQp899
 M05e2QkVAEpJZark2vf/+E1BWPWSuG3bFv5fPzEWFVtWIuLUmvsZvXm+OxgIRF/OZij9
 ayMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL6igvyjg9h5rqpMkUzuhi0U7EGBL7lqM2UL/ItORKaNWr6gSVv3gERCM+GzHutEtqPd6uX+GjYFA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmD2OKwB0KA3sXAYTf42YpXMTu9khD2PSs5s/vDtqkCjSzj1t8
 rda1UdwG1SA8uEYIGAMz/qrXXYXRBlyfMOzuXGlq8vsKSHGgwvEPZfRh
X-Gm-Gg: AYBFou1gvbQqeYA9uOFRr6xsRjuS4z0rvN0G8Wyetm7ATLbUsqVhjQbULPM/nSGxDEm
 ipGYhmTFrUUEQGEU6bIlkp9hspy3Jbdrf6ksqqtyTMpxSwBBsWV1f/tH1ZaGbwfrgr81fiOXpe2
 F0aQM2JlbJug6reMyjwUZBdY72E5YkgGGk25K8GKDGoaTgh9FHkTurczwu+icwAQEl3d9e++bxC
 EigsGqtUf0xj92jh4OxEmeXpGybpS9S7dV4vy3JdMZChKnRu6gs9pxol2hj6UuCpnpK58W/BJ3B
 i6PSgzBpwyhYEFMrHsRZIkkwYjMVljXbQpA4zWbLHbt+EUdKl8eVoC78asld53w9JIsdZM1CLlF
 9NDkaO640OA8L47FpDmx3bBYF+ykZr5cuLZX2W4BeF0pr9+LCnT77u88kxrkxPScxqLqsR4eWlr
 GlAFhtMkA1IN7eOqGHJ7fHEwnL+y9jMPtw4V6mp2k80o+JWuXMqW0pYnmQJwcw9B9B+sWnLqp9n
 n/niG2nMCBTf3XRo9uQhlKeT95l4CQoWkE=
X-Received: by 2002:a05:690c:113:b0:8a5:c04e:12a7 with SMTP id
 00721157ae682-8a5c05d5670mr9454857b3.31.1790179292766; 
 Wed, 23 Sep 2026 09:01:32 -0700 (PDT)
Received: from holowork.lan (static-68-235-46-62.cust.tzulo.com.
 [68.235.46.62]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532eb399581sm21911581cf.28.2026.09.23.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:01:31 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, Fabio Piparo <holofermes@gmail.com>
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
Date: Wed, 23 Sep 2026 12:00:49 -0400
Message-ID: <20260923160049.1741651-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1f383114-e367-4b67-899b-14a393fece94@suse.de>
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

Thanks for taking a look.

On 14.09.26 10:43, Thomas Zimmermann wrote:
> I assume you write these frames quickly one after the other? As i2c is
> really slow, you might write to buffers that are still being transferred
> in the background.
>
> Do you read back the status of the page flips? DRM should tell you when
> it has completed transferring a frame. See [1]

The test renders with the GPU: two dumb buffers allocated on the
ssd130x device and shared with v3d over PRIME. It runs at 10 fps.
Before each flip it calls glFinish(), then flips with
DRM_MODE_PAGE_FLIP_EVENT and waits for the event before drawing into
the other buffer. The same test drawing with the CPU instead comes out
clean.

I'm happy to send the test program if it would help.

Best regards,
Fabio
