Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA27C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 02:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380FD10E3C2;
	Fri,  7 Aug 2026 02:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=edera.io header.i=@edera.io header.b="heeeXGFN";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1854210E3C2
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 02:55:19 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-82011c59e66so54525717b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edera.io; s=google; t=1786071318; x=1786676118; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rD0P/EwWw7jwEPK55gnVfsYkHWCAigVS0mVtp0HL//Q=;
 b=heeeXGFNBZzjD6fWCUe3dRWdbBakxRjQVC6xkJcb2QcxM3nxr0ClJOV8UHC9XfkNS6
 nvCQxHrhNzeNzaXq7e1pGWUk+zn3ErRoOZY4Ts9HaRpWxhQ/ZHtEpB3fH2g7K72pKAAN
 AH8IfxQzkXzInymRYW32UPwbArpyKmdpXOkcsuHLN2SQyPuDdKkksyH4sD3cVpe+CTL1
 4r3efPois3c0HttQPRSuhq0rQbdGtywMVUaogQb/L5RAQ1dtXpK5uRfceADxN9RomcDi
 CwZFTHNz0Wz9b4Ckqsphk5lMeXGxj7YWOmZLT7aIwndyYbao3iDCLHC0m7xhabWQTfIQ
 9hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786071318; x=1786676118;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rD0P/EwWw7jwEPK55gnVfsYkHWCAigVS0mVtp0HL//Q=;
 b=AlJw7NcAJDI04jF56rU20qxb7Vy6coVi26SAr5WiYyP3hypLiPk+/GZD8wsV0WMglV
 2yQp3uOoUBdMJbsQHIZUXbmmhnx7h5JC5S+xPe3WYg3yCxkBsTvMhLR+OAhVgL3xP2lq
 3Sfemv8Q7/cLfXE6KqiVOjK2hO+udWtB/7UpXj0rZtRDvJK1Q16nzJBOyY+CWzCspyfi
 RikSFQ1qS5wJfjlJQcdNcaDvrooqJ1KO7vA1SMxIKhhjt35dHNcLeqsuTPForryraxIr
 gBtIhLvVL+RrJnQCZEwUwFn5GEOXkCJjh/gNT6kTPL2YLRrgMWWaCyYUhv97WZXEyu11
 v8/A==
X-Gm-Message-State: AOJu0YzGvTjqCspbPUAnnMpuPtdnJvtbUhOxO7awOEgG2V4TfV35gzfh
 8sU1KyKsSQERZe5kD/YPed1nR7zFyK63Hs68IfcXtqxEG1mZffq4ckC0ykYDtxcuDYkfraZHerM
 e36iUPE4=
X-Gm-Gg: AR+sD110iwvcgSoVLpzI8iLRd8cByGXOFKjX5lZdrlKCimqHfKIwQIhTxb4amwdrbow
 vrwiNk10bQiv6GoHlvw99ItXavfBqOByabnfwdu8FaPT3awx9VTwLRUkfCWPtRdxQLrNPmxb60f
 2x3IKTimfTTqq3Q5EmBr4xuIaAQpVRByWStan1vlBFexdhyEwxBM+E65hRJAFpX9coFGTRqPZLs
 Iwl+O5r6frMN98ZybQL3fyKMYQ+4ng/KG7MImvnqvwjePH7bKP/JL7rbaFC72hK1HCFzvtY36YG
 KufsOlGB1sqyHmm+AlDTVzauq5BamyoPcJ/d4BCe04IUaiLU79TQdjFqgyi7Atmn9ebQrOU0w/l
 RON8oJWQdas2v2wGdz4WaCN+Te/Sc+Y58oHBrGLr8Hvd+MPIyNNO2CQ5EpxQ1zcZi61ORCIGotp
 7WxCIzIARiYoKZM1u+NhbYtHaVtwBtddnTbun76J6lM16SLIEUhVp7P9FxqB+S
X-Received: by 2002:a05:690c:6e12:b0:81e:e313:2ed1 with SMTP id
 00721157ae682-8201f08fd34mr121177527b3.8.1786071317695; 
 Thu, 06 Aug 2026 19:55:17 -0700 (PDT)
Received: from StolidWingnut ([174.80.170.224])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f09910b2sm2600087b3.16.2026.08.06.19.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 19:55:17 -0700 (PDT)
From: Benjamin Leggett <benjamin@edera.io>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
In-Reply-To: <20260806231002.27B4D1F000E9@smtp.kernel.org>
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
 <20260806231002.27B4D1F000E9@smtp.kernel.org>
User-Agent: mu4e 1.12.12; emacs 32.0.50
Date: Thu, 06 Aug 2026 22:55:16 -0400
Message-ID: <875x1m8wrv.fsf@edera.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

> [Severity: High]
> This is a pre-existing issue, but while enabling the DMA API for Xen PV
> domains, does this leave guest-bound transfers vulnerable to data corrupt=
ion
> with SWIOTLB bounce buffers?

Yep, preexisting issue, but not reachable via plain `virtio-vga`.

Only reachable, AFAICT, if `has_virgl_3d` is enabled. The missing `_for_cpu=
`` sync
is pre-existing since 8f44ca223345 and pretty orthogonal to this change.

A correct fix most likely belongs in the completion path rather than at sub=
mission,
anyway, so I=E2=80=99m not sure it makes a lot of sense to include in this =
patch.

Happy to do that in a followup/separate patch, if requested.

Ben
