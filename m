Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE2DCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127C110E18C;
	Wed, 14 Oct 2026 01:47:00 +0000 (UTC)
X-Greylist: delayed 324 seconds by postgrey-1.36 at gabe;
 Wed, 14 Oct 2026 01:46:53 UTC
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn
 [61.135.153.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4213E10E18C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1791942413; bh=Gukd+7qBDkCL0LwJkx1bGcwYtROGaDWytHz0r2JFleE=;
 h=From:Subject:Date:Message-ID;
 b=M6SqxvulUlq+yfdeZnOtekO8KtcHQ0I6LmjrqTsdCrCGETeu/GnHMLvmo0HsP6htT
 qIwhGjocqgz3t5QLY+GV2+bAav8hd5inVSwUXUbeTZ8LDfbbCJbEBHwlcNC7zqkDzC
 MCAv6yIlsaANz5hm1ENWYomtP4uFkIe6E48j7/Mg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
 by sina.com (10.54.253.34) with ESMTP
 id 6ACEDDC100004107; Wed, 14 Oct 2026 09:41:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=hdanton@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3659906291904
X-SMAIL-UIID: 3E8AF85D807741DB8AE66A308ECF1F7E-20261014-094125-1
From: Hillf Danton <hdanton@sina.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Wed, 14 Oct 2026 09:41:10 +0800
Message-ID: <20261014014112.515-1-hdanton@sina.com>
In-Reply-To: <bf25fc38-95d7-4cb5-b0ee-6afe1488e5e7@collabora.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Fri, 9 Oct 2026 20:39:54 +0300 Dmitry Osipenko wrote:
>27.09.2026 07:09, Nguyen Ngoc Thang пишет:
>> On Sun, 27 Sep 2026, Hillf Danton wrote:
>>> What is unclear -- why is kmalloc failing to work in 2026?
>> 
>> kmalloc isn't failing. The failure is in kmem_cache_create(): the driver
>> creates a dedicated cache with a fixed global name for each device, so a
>> second probe while the first drm_device is still alive (release is
>> deferred by an open /dev/fbN) trips the duplicate-name check.
>> 
>> Your question made me look at whether the dedicated cache is needed at all.
>> A vbuf is sizeof(struct virtio_gpu_vbuffer) + 96 + 24 = 216 bytes, which
>> lands in kmalloc-256 anyway, so the cache buys nothing over kzalloc()/kfree().
>> Dropping it also removes the lifetime problem entirely and needs no
>> module-level state.
>> 
>> I'll send a v2 that switches the kmem_cache_zalloc() calls and
>> kmem_cache_free() to kzalloc()/kfree() and deletes the cache setup and
>> teardown.
>> 
>> Thanks,
>> Nguyen Ngoc Thang
>
> kmem_cache is used by GPU drivers to avoid kmalloc stalls in a
> latency-sensitive job-submission code path.
>
This makes no sense before showing the stall, given my failure of locating
the lore page where the tglx dude was taught a few years back (by Mathew
Wilcox?) that the percpu page is faster that thought.
