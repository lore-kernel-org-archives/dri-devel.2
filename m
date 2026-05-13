Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F3ACD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 21:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34FC10E086;
	Wed, 13 May 2026 21:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ekRMWwLY";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA9C10E086
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778708450; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CUCNlIDTzpC85wfIH8PeaV6qNZl70nQT0vhjX3RNxFsa/9j6wFaiRWVzoMQ2y8fIjxyqKpcVTvJIOQlHJ/S/mZENDcewi5Yr+oOaz41mrk2oYs8o1st1aJ2Hi+9B9YENA8dVYZJ9Oig+a+yXr0xT0tQx7WMatxPThPLr/gjbMjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778708450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AAfkCdUncn2lwPDL1s9t85c0zO4+110KbKaWrEKLqBg=; 
 b=bp29dGNPOwh84pqU6Z8EkzH2Sn/3uZaCy836/fynPzy7Kr3rL1HjegCuOXS6oDXUtVs4Tw9dTRKIA68oZZzeEGXVb0+nzRtTFwc6khu1NijHsNptXAokuslwC/fJ5M7nSF+6cFvm4DOF4cw10j90rmKdO3B6oPvfNbHZVL7teDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778708450; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=AAfkCdUncn2lwPDL1s9t85c0zO4+110KbKaWrEKLqBg=;
 b=ekRMWwLY598KP3V0fqX0v0nrmF8cXBLkDOSfLHD1KgrJ6K+HS5ElsQAzxRi6SrfL
 ceKzxRo7CKFOpC22dHWade5FYnkg4w0L51YymjuTsZZCie1M18wNLCuHE2dLDBvPXdI
 hWW8NOjosh592xr89ZGN7KOm/hhcThxgDVh423nI=
Received: by mx.zohomail.com with SMTPS id 1778708446967774.4798640957364;
 Wed, 13 May 2026 14:40:46 -0700 (PDT)
Message-ID: <82aeba42-7872-4e92-ade8-2b7b6a8a5e43@collabora.com>
Date: Thu, 14 May 2026 00:40:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com,
 syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
References: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Hi,

On 5/12/26 11:59, Ryosuke Yasuoka wrote:
> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
> wait_event() without timeout when waiting for virtqueue space. If the
> host device stops processing commands, these waits block indefinitely.
> Since callers may hold DRM locks, this can make the entire system
> unresponsive.
> 
> Replace wait_event() with wait_event_timeout() using a 5-second timeout,
> consistent with the existing timeout pattern in the driver. On timeout,
> clean up and return -ENODEV, following the same error path as
> drm_dev_enter() failure.
> 
> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

If host stops processing commands, this is a problem on host side. Isn't it?

-- 
Best regards,
Dmitry
