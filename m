Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61218606A338
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N/a4p+4M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA9F10E304;
	Wed,  4 Nov 2026 19:15:16 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C3910E304
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:15:11 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so8499685e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793819709; x=1794424509; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XzHnKQ1ardUs+9dftxxB/DnpUdQxoDWmHTP8fmVOjhs=;
 b=N/a4p+4MFosJTHrabz+6U06Na0G6wVszpvdmOvTvrQhqSrTJRWU44s3d6ZhShycpc4
 wyNsIl73x047og1oSn+mtgOsEpeJIRRvEkFvyjaRl09AyQwnNytZhvW1ZUDfWlLFSzPL
 shzGAA492KRCBTOgqcJoCOdG8/rt48xqnrI9+v+Ws/QbAIjcIveFG/t8eZ0ceouCfZRF
 cvXCNFD421/qI2RJJhJ6FjR7p85qNE/2aySQbUz4LVaJtHsFbCSFTtycqrMYf+bpxNnv
 0nIV4yAHsPkYxW782IJBU+wjIze5OzPzUez1B+U/sRrWb9b9h76ijO+Jod5KIE9OwVNj
 z8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793819709; x=1794424509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XzHnKQ1ardUs+9dftxxB/DnpUdQxoDWmHTP8fmVOjhs=;
 b=Kjj89lVAnfMR/mk/NKPZqPJ3dIMLQvtm8xyZsysV22X//E6b5LWo9ilUiSD6GMfP3c
 PiRSHPo+p6KeMwHPJzqEssw4GJ118PVgGeYJhlxLpxUhAvxhnQAJYmKUrYO9ESFc0e2E
 nXA2X/NsuqWRKzE0jhP0/NWpAGFjODjBLcoYXWBr7lk73Y5lgqZh+F1fTfN5Dhh2Wi/e
 eVoDm9tpHWZFOB5lSAgZ3HXJYPIfVl5WPNFhrpUDuTpJ5pQjcHsp7sXLa24BXtve/O/S
 lTubts4J0JOFpk7QkIrEI9C3+5SjtVT/h3HN9HgFsnzzpPixUE6/WHXXPW17j9Fy2pzd
 LIYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLxR0xKEuzfqyiDUgH4Gm3sM3wV78AVl/Q3L37CeiEogf/ypmwRT+MXYeOlxsdOF8EN1ZL/uSd5SA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9arsnk29itgzGA6zTblJJdAPuY3tpx6le5su8b55vhqFg0EMvr
 PzaslgMeRqKd9X3yvMo13JYGCmHteOZNDh2LJ/B3Z8dCCWLPm188Nj37
X-Gm-Gg: AYBFou2D4eAPBjrwAqpotLwRP+tzu0iWt/twsV8KWru05oO28Yf7L2jAke8fNyYU35O
 ryal+CiHwa4u2CFaXy1z+pWfoaiNUf8fJL61wRNiDugQmdUFQHGvIQJHEUo9792YwHUua7XXUuI
 wphLt3iHSjJSzyJobHZElEqfnjyiyWEb+8kHFi7pgn3M6hI2ozz9d36cO86B5761/ADCcevIDg+
 6ACyjQRD84ZqwCRXVIhhm+JT6AnKBWhQ1MtfjabRr6SkLgqaD1KUrpc7wHgjy9bVU44AXphnL2n
 DHSKxLljkmq+O5HCQPxthmIG6+BzoULmslsgTpGA2LOPxZhxmU+wFNx4IrL+ewDGSVzJ2VUohVi
 2Q/7ZM6VXL/N7aYad7L9ajhTH3xNdk07y05D2fS/fS0hD1+ut2APP7x1/FryDR+2+q0ntbMhwTE
 bfKcflsydrA8ufExVBW4ZaDbeyv7/AIMmoxO1ExGCIhp3Roo7uxSaOEzFhPqwDtnGMooG28sVeQ
 AKHPmYoMQmFy98tb+goVt0znobxD91MDC7rpwY90JLQVA82Hjk/FnJfaS30opjsy1gizahtbf6X
 kArOBFMDZVtcQwoabZe1vz6RoQxDImfBmQ==
X-Received: by 2002:a05:600c:198e:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4ac1932a23fmr389597675e9.32.1793819709210; 
 Wed, 04 Nov 2026 11:15:09 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm74643035e9.4.2026.11.04.11.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:15:07 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: clear config->dev when vkms_create() fails
Date: Thu,  5 Nov 2026 03:15:00 +0800
Message-ID: <20261104191500.210592-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101032728.11422-1-yuz08559@gmail.com>
References: <20261101032728.11422-1-yuz08559@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resending, as my mail client wrapped my previous reply in an extra
level of quoting. The content is unchanged.

On Sun, Nov 01, 2026 at 01:27:28PM +1000, Yu Zhang wrote:
> The configfs "enabled" store returns the error without marking the
> device as enabled, so the next "enabled" write runs
> vkms_config_is_valid() again, which uses config->dev to print its
> diagnostics and dereferences the freed drm_device.

I traced and tested this issue path on drm-misc-next; the dangling pointer is real
and the one-line fix is correct.

I'd suggest rewording the commit message in two places:

 "dereferences the freed drm_device" is only true for one of the two
   retry cases.

   a) the retry happens with a config that no longer validates: a
      validity check takes its failure branch, calls drm_info(), and the
      freed memory is read.

   b) the retry happens with a still-valid config: vkms_config_is_valid()
      returns true at its first check, drm_info() is never called, and
      vkms_create() just stores a new pointer.

   Only a) triggers. The reason: the stale pointer is dereferenced only by
   drm_info() -- __drm_to_dev() loads drm->dev (drm_print.h:608) and
   dev_printk() then walks the freed struct device -- and every drm_info()
   in vkms_config.c sits in a failure branch of a validity check. The
   ternary itself reads nothing: struct drm_device is the first member of
   struct vkms_device (vkms_drv.h:252), so
   config->dev ? &config->dev->drm : NULL is address arithmetic.

> device_enabled_store(), drivers/gpu/drm/vkms/vkms_configfs.c
>> 	scoped_guard(mutex, &dev->lock) {
>> 		if (!dev->enabled && enabled) {
>> 			if (!vkms_config_is_valid(dev->config))
>> 				return -EINVAL;
>>
>> 			ret = vkms_create(dev->config);
>> 			if (ret)
>> 				return ret;
>> 		} else if (dev->enabled && !enabled) {
>> 			vkms_destroy(dev->config);
>> 		}
>>
>> 		dev->enabled = enabled;
>> 	}

   config->dev was introduced by 2df7af93fdad ("drm/vkms: Add vkms_config
   type"); at that point nothing read the pointer after a failed create.
   The problem was introduced by 13fc9b9745cc, which changed the lifetime:
   configfs keeps the config alive across a failed enable, so the pointer
   stored in vkms_create() outlives the device and is read again by the
   next write. So Fixes: 13fc9b9745cc is the right tag even though the
   pointer is older; please keep it, and say so in the message so that it
   does not read like a mis-attribution.

   Background:

   config->dev is the only backpointer from the configfs side to the
   drm_device. It is used by the validity diagnostics, by vkms_destroy()
   and by the connector hotplug path (vkms_configfs.c:555).

   The configfs/drm_device lifetime separation was spelled out when this
   design was agreed on:

>>> the issue is that configfs and drm_device have independent lifetimes,
>>> and we cannot have links between the two. The configfs structures might
>>> have shorter lifetime thatn the vkms_device (and there's no refcounting
>>> on configfs afaict), which means we cannot have a backpointer from
>>> vkms_device to configfs.

>>> The vkms_device->configfs backpointer needs to go, it's fundamentally
>>> busted.

   https://lore.kernel.org/all/ZjCh9DGnh2JQ3vtk@phenom.ffwll.local/

   Note that dev->enabled in struct vkms_configfs_device and
   config->dev != NULL encode the same state, which is why they can
   diverge here in the first place. Dropping the field and passing the
   drm_device explicitly to vkms_config_is_valid() is the real fix, but
   it changes the signature and the hotplug path, so it belongs with the
   vkms_config lifetime rework rather than here. Clearing the pointer on
   the error path is the right minimal stopgap.

Thanks,
Oarora Etimis
