Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F521CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AA310EE12;
	Thu, 11 Jun 2026 10:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LC4snhAW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4814210EE12
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
 b=LC4snhAWv4yRwbIM/7+kiepQ8iY2E7POtngyepcQ4X7KHWQ04IuGvo1eqyPwqmrxRbMdaM
 AyjOfe4TIlDX9S+3aKBsH7tuR01eRst6kainVfB83T02vBpmqk9ajh0JhXF01txccr9gvO
 DYlLNUwKs+Zq9lCYDB9ylyVzUBHyrnk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-GLtQGc6bNuCBsm1gCGHi7w-1; Thu, 11 Jun 2026 06:12:56 -0400
X-MC-Unique: GLtQGc6bNuCBsm1gCGHi7w-1
X-Mimecast-MFC-AGG-ID: GLtQGc6bNuCBsm1gCGHi7w_1781172776
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso19176215e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172775; x=1781777575;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
 b=LKKnBG7jd+WXu6WTVB79JnyFkMpmbWltIVNKvPZYwwYr6G0xdcbeqJ2hBZC9ek80pN
 sUudN06a/wqY7+jJKodOOv+ky/4yhT/G2mS+BVWLx789cH/K3ySKI+SH76BWvPOl6jo+
 ccgvCZLOhxrXfGdxQ2+EEPABAS0LIZXc+9hDg/Jz1ss/he+eC/ajNePGOVo+Ej72pvtp
 vXLu2Rs8w/xiiFqNfId9U+fjq4oBH8ORrDzdgjzVjxDSTsNK6leYWx6u8FQgMS/pKVHi
 54ulbWeCHOIVLHGY+omOz2BlWPoooioE5HRVTs9XKcFpJg3VtQe4nqKuF5jwUMQrsObH
 Icxw==
X-Gm-Message-State: AOJu0Yy4UlI7oFR4dxvtNo5RdLGaYXdoqi+rLxDTG7nyLvC8fDARSVoV
 TtsVyB0iUCstJ3BdS8AUOf7KkNYQIIcmBYQ/rfKdf7aYWqRU9nnzXI7KoPpXfJ+SaE6JkYoixOJ
 wA194u644/mxZUcbwtSDELjK95SvyKNa5q21Ksg7bCRMdQiYSEYC63HkOj/YfgKrjxFmuIA==
X-Gm-Gg: Acq92OEsYIHyTDerZjzfrHKGxQM+a2M04FGdq3P0xhXCjT0kluyyo8oNOm+cwObOQ5m
 oz9NE5U9AXo7ILovXOcmxU+iJGdmK1a8E71KKeBy9+CpEs2M5dD8o0AwXFi2T4YmB0Xjz8QvXU9
 oe8IJvXqVsUEYKZD/GHWAbaqTxkGdBQRxJVmWzS2KpkVunsNjPysyHktsW+6aW5MMqCV3lPoW5T
 7D+hkBPED2DwojzUUb2jMpVLIgyFtftEiauLEGSHihjthlLjAsoDWqoqAKbKvnvwK7FYQW8MnYy
 QNKXhLP7caLTbgIV39TjUV68XuTt+Tu2XqCXa+uKxrpz5K20H1JRxD9lgVOhWIA/fw5eBU5PlmA
 YSRY+z7i/NT2wNzPvYcdjS52Oz0bnnmyS6PyJX8nW2Ta9upDQWVjACHiGBxWG6EBhzvOK1Twr/d
 fwMPg/BwhHRk2dhik=
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490e5639bf0mr26218575e9.24.1781172775404; 
 Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490e5639bf0mr26217975e9.24.1781172775016; 
 Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e532c778sm38051805e9.14.2026.06.11.03.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:12:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/15] drm/vmwgfx: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-5-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-5-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:53 +0200
Message-ID: <87pl1x5qsa.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1CZV1Z1jBJEEDtRsydWAIF0jXoxI6d8iNyPsTy78uz4_1781172776
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary ldu plane's atomic_update and do a full
> update if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vmwgfx does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

