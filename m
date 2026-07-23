Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C61C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A21210E5D3;
	Thu, 23 Jul 2026 18:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="YamoZPMd";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81ADD10E5D3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784833018; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CJIbD8yOleAUy9bEhZcO/zZqgSaP61T7VfkuW6rIX0kUCfWqAwzWRaEnqd499o8QExH1n9C+OLF/ZXHQBCg/GsLhjatkcIkkpKOj9llQiOjk2jrHEqGyBcDAVC4SU+p69oYhc32E2hdJvlgQumxbnDtwKCEruTNKK6tp6Klk+dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784833018;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3iaYVEsIVCyK0ND5jM1y+PZ+xDP3CS2E9BUMZ4Up2Oo=; 
 b=HXviSh6rM0PX/IgdSe7SqmrRqy2MY/G1i8UoHtCvRBAg1oeltqGu6XDIYB3l0a86tMwgCbV6zNMzT9nAmCdj8JjGt1QEbvYg8E0zYl1VF5Ts6DIzMYSiyHqHABOwy0XIGCtRQJ6Sk8ijF0DCdSW/l4jGnvSephUoZLiWYU+2OfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784833018; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3iaYVEsIVCyK0ND5jM1y+PZ+xDP3CS2E9BUMZ4Up2Oo=;
 b=YamoZPMdaXhYXYKEpapZW9MZ51OlN7/5lzOhIWIGJ8h5vL8d8itbArwecTr5VIOf
 2at1Mifxi1JOv0cws94u7QMcQTrKrfX4zh3Z/11cKr+fxjNboP3RBcaPj3JcM+K5pRA
 4n0YBtmne91ZEZqpULB/77poNQuzEgNQFD9GZYWg=
Received: by mx.zohomail.com with SMTPS id 1784833016441800.3413712097565;
 Thu, 23 Jul 2026 11:56:56 -0700 (PDT)
Message-ID: <d425f956-ab89-4381-a655-176bd6d7e8da@collabora.com>
Date: Thu, 23 Jul 2026 21:56:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by
 removing hotplug from dequeue worker
To: Mikko Rapeli <mikko.rapeli@linaro.org>, stable@vger.kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
 <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>
 <amG_T7Kb7DW3VTxm@nuoska>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <amG_T7Kb7DW3VTxm@nuoska>
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

On 7/23/26 10:14, Mikko Rapeli wrote:
> Hi, adding stable@vger.kernel.org
> 
> In Yocto distro, this change released in v7.2-rc4 seems to fix quite severe qemu
> boot hangs seen with 6.18 stable kernels. Details in
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=16217
> 
> Please apply this to to 6.18 and other stable trees.

The patch will be auto-applied to all stable kernel versions covered by
the `fixes` tag in the commit message, including 6.18. Thanks for
letting know that it fixes a practical problem.

-- 
Best regards,
Dmitry
