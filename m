Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427C606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQvVsKcP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1B310E88D;
	Wed,  4 Nov 2026 19:03:32 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3ED10E6C8
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:03:25 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so9638275e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793819004; x=1794423804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OLEYM5/Ge5Y+DVw/IRXDnmBgDl4ccX4rWqykyHVmYlQ=;
 b=YQvVsKcP2IBcttkxhUipuAZMg7mx+sU81xvdz12LpuBkKHdSOY7VtbypQhfvfcK7/1
 ZHLPoru5esEqWN7eXu64bW15P69yFxhpQuCFuFE5Y2p3TFiAV3FCJzRNwhKTXZDn7sUB
 AMkkO8W5w7pNOZgBrhS5iyiFeuHpOuDfqZruhuGayishy5IFfeNNBixH1FKstQmAVphM
 Q5jaK/jChtzmdkI+xJftmj4oNs2nruvnf4L1KIoxojAgG/XGHqN9CwnO7qDPeV6lGANM
 tDdZhMZXe4DNtPRNAo+fehrYt64L7nHSkMCTEHth0RA0B+9sPhX+MZaVCvHXYoiU/JFh
 O57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793819004; x=1794423804;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLEYM5/Ge5Y+DVw/IRXDnmBgDl4ccX4rWqykyHVmYlQ=;
 b=Bgoq32WNmJ4iZX8LlQHMywnSWUQQmL9gR0njtQuxyCO2YFDhMkheZgGRyqfnlyyPKf
 YJhkTBen4TYPHcPnkN2XKgOBFTLUCXt4ljSZckWYBa/cNum4tPqjW8AIEt1KhQJcTFqa
 P4FKjdO/H1TKMVFpuwAJKlt+pN4deVoSyLEyMfJRDLChyQCXHGqJmWFPTcdGDpqejTHk
 BCnR0oFHk+olwx1jvbOvYxJLwnWaokrTCpBgRbcn8Xkd1Ph1qTVRKCgWkLwLcOHLOd7F
 lRZW/GhTQTvQMT4WndaBzIePRF8qy/PQWXhgDMG/kN3YnxrsRZ8Vc0b9N/v1Evij1QCU
 /b0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwr/+RnFISpaWr+rzDeJHU4uKkJEPaeWrJqaYqyWiZ3yxxnBWK4ttRWyWB0xqDT/0N2YiVdWP2aq0o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/n3fuENN5cZapk5jBahYgJLdOUx6+uFhZSR0e0X9PR+6kbKb9u
 Jyh46lwTd5WwUVorb0a/lxiynSlP9anLOoif+PMPxfiVyYWz5fL4SiNr
X-Gm-Gg: AYBFou27W1uxBwyONnzlNsp15rG22yfr8ZBBDLWDnw7Pwfq5Xa2t2dBAb8Xrgb27fZA
 +Da8e45+zlQwD+I/kWZf9bSsJUVxRNVLmR9+x5ZdsRcJYb5ImlQxJYqPaKQhZ5lBEX3MozCqa2w
 brmhlzokTO8qAjpN2I2bkEUZ4QLaP4dWyOdTxvW7T8UywLv1teVbszy16+nszXwe+X+8TKs8HY5
 tvrjKJEuCjct0Z+oprDoXZ0S6ZQS2ib5SnexnUDsQu0biXpRzF/zZWin+1bPVSGinE+Y9UgnqA2
 Sc6ZNREnqA+3Hw8vk+lP6RSn/KCA2zM2n1+bzjkNR7CO0b+7JJFjwCdblyRX9EtmHdq2CXqOT9L
 JLHzpIGfPbarL+zCktsHgmz5xJeqjP2+XmCFfDQYTPE1PZYy2t5Y4YwgtYwLyxvZBQz0stjSkl6
 6DKl19utifpAddp9leA0nbbeaDMvHWDX6Ksb2Vy5fqoHBbCBXxFxz0sUox72/pNGr41EpsjoOLW
 voLjwimD1vqIYuxbZpC4bTLOOD3Kr8RcuTRmMuDXIbLmOojKvhnI65O5LXRf+dveFIMvdXoTjwE
 YmMcPDQAnfWO0N8iY3kw18zdLgMo2vRsFe2fWuAFZIoGcKsFBfVFq4RlYaV6enLCLf07TUEocDV
 8wq0=
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4ac17b2cde9mr440533985e9.7.1793819003817; 
 Wed, 04 Nov 2026 11:03:23 -0800 (PST)
Received: from ?IPV6:240e:47e:50a8:5f12:138d:ea9a:7198:b89e?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b40ff10f88sm54699225e9.0.2026.11.04.11.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 11:03:23 -0800 (PST)
Message-ID: <51a04472-d421-42fa-8552-e94f4743e226@gmail.com>
Date: Thu, 5 Nov 2026 03:03:17 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: clear config->dev when vkms_create() fails
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261101032728.11422-1-yuz08559@gmail.com>
Content-Language: en-US
In-Reply-To: <20261101032728.11422-1-yuz08559@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 1/1/70 8:00 AM, Oarora Etimis wrote:
> On Sun, Nov 01, 2026 at 01:27:28PM +1000, Yu Zhang wrote:
>> The configfs "enabled" store returns the error without marking the
>> device as enabled, so the next "enabled" write runs
>> vkms_config_is_valid() again, which uses config->dev to print its
>> diagnostics and dereferences the freed drm_device.
> I traced and tested this issue path on drm-misc-next; the dangling pointer is real
> and the one-line fix is correct.
>
> I'd suggest rewording the commit message in two places:
>
>   "dereferences the freed drm_device" is only true for one of the two
>     retry cases.
>
>     a) the retry happens with a config that no longer validates: a
>        validity check takes its failure branch, calls drm_info(), and the
>        freed memory is read.
>
>     b) the retry happens with a still-valid config: vkms_config_is_valid()
>        returns true at its first check, drm_info() is never called, and
>        vkms_create() just stores a new pointer.
>
>     Only a) triggers. The reason: the stale pointer is dereferenced only by
>     drm_info() -- __drm_to_dev() loads drm->dev (drm_print.h:608) and
>     dev_printk() then walks the freed struct device -- and every drm_info()
>     in vkms_config.c sits in a failure branch of a validity check. The
>     ternary itself reads nothing: struct drm_device is the first member of
>     struct vkms_device (vkms_drv.h:252), so
>     config->dev ? &config->dev->drm : NULL is address arithmetic.
>
>> device_enabled_store(), drivers/gpu/drm/vkms/vkms_configfs.c
>>> 	scoped_guard(mutex, &dev->lock) {
>>> 		if (!dev->enabled && enabled) {
>>> 			if (!vkms_config_is_valid(dev->config))
>>> 				return -EINVAL;
>>>
>>> 			ret = vkms_create(dev->config);
>>> 			if (ret)
>>> 				return ret;
>>> 		} else if (dev->enabled && !enabled) {
>>> 			vkms_destroy(dev->config);
>>> 		}
>>>
>>> 		dev->enabled = enabled;
>>> 	}
>     config->dev was introduced by 2df7af93fdad ("drm/vkms: Add vkms_config
>     type"); at that point nothing read the pointer after a failed create.
>     The problem was introduced by 13fc9b9745cc, which changed the lifetime:
>     configfs keeps the config alive across a failed enable, so the pointer
>     stored in vkms_create() outlives the device and is read again by the
>     next write. So Fixes: 13fc9b9745cc is the right tag even though the
>     pointer is older; please keep it, and say so in the message so that it
>     does not read like a mis-attribution.
>
>     Background:
>
>     config->dev is the only backpointer from the configfs side to the
>     drm_device. It is used by the validity diagnostics, by vkms_destroy()
>     and by the connector hotplug path (vkms_configfs.c:555).
>
>     The configfs/drm_device lifetime separation was spelled out when this
>     design was agreed on:
>
>>>> the issue is that configfs and drm_device have independent lifetimes,
>>>> and we cannot have links between the two. The configfs structures might
>>>> have shorter lifetime thatn the vkms_device (and there's no refcounting
>>>> on configfs afaict), which means we cannot have a backpointer from
>>>> vkms_device to configfs.
>>>> The vkms_device->configfs backpointer needs to go, it's fundamentally
>>>> busted.
>     https://lore.kernel.org/all/ZjCh9DGnh2JQ3vtk@phenom.ffwll.local/
>
>     Note that dev->enabled in struct vkms_configfs_device and
>     config->dev != NULL encode the same state, which is why they can
>     diverge here in the first place. Dropping the field and passing the
>     drm_device explicitly to vkms_config_is_valid() is the real fix, but
>     it changes the signature and the hotplug path, so it belongs with the
>     vkms_config lifetime rework rather than here. Clearing the pointer on
>     the error path is the right minimal stopgap.
>
> Thanks,
> Oarora Etimis
