Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF3CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0E410E03B;
	Thu,  1 Oct 2026 10:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="F0U1KVhC";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1090710E03B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790851578; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h0X+2Z8FTOuZxR4NaFKUOo4BEeNPSS6M/zba4h8v827HnHaFgAJtCF7pVY44Oplvv9DuppvdAD49QoOJMFE6+9Ai/AkfJNF+9NasfyaSAqjmMIDYlxaZjltl6Vm2bCgTNNEVSYEMoDZzmpkxwjTGbGhu5R0SyT1/AOSGIcUnUMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790851578;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2HzGCzDfJRSxURSFLUp5EFwzSKrik2fgPy8B4HnFxCE=; 
 b=XQYX9XxneS9roREzfIftliV0HLRFMBp+0v1Atk+rOTmyUd9L8XUJErwQIQ1BfBDECU1oNW5lg2qDXLn7PjVk0iwoD2wZ2vVZKD6rT/2BPvMW90q4kSMil2XhGB6HTbAO4F+1vloqZWlnNu56Ruhqr46drJGBMofNYWM1tHLM95s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790851578; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2HzGCzDfJRSxURSFLUp5EFwzSKrik2fgPy8B4HnFxCE=;
 b=F0U1KVhCyjzzZ7tGAijotnDY4dtGPmcI7HEANAqbpPKxp3V4LtsUeTO07XzJS1sk
 APFm7IHS2cV+LWZDn0RVzakRHfK+IfeXHPMk1q5fFQ9+CE2H3yzf3IKiKFbeuN6Tuow
 I9w+Gmr7rWCu30FS3BZzGEv3VtR+g1GIh6Bq3XXA=
Received: by smtp.zohomail.com with SMTPS id 1790851576827524.4943374976424;
 Thu, 1 Oct 2026 03:46:16 -0700 (PDT)
Message-ID: <b8064104-99dd-472d-883d-56b362d60371@collabora.com>
Date: Thu, 1 Oct 2026 13:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Dorinda Bassey <dbassey@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: kraxel@redhat.com, airlied@redhat.com, slp@redhat.com, mhrica@redhat.com, 
 gurchetansingh@chromium.org, mripard@kernel.org, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
References: <20260930132707.500748-1-dbassey@redhat.com>
 <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 9/30/26 18:03, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
>> Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
>> virtio-gpu primary planes. Without this, glmark2-drm fails at
>> startup because it selects ARGB visual configs by default, which
>> don't match the XRGB-only plane capabilities. This causes
>> drmModeSetCrtc to fail with EINVAL.
> 
> But does the host also support ARGB on the primary plane? We usually
> don't export formats that are not available in (virtual) hardware.
> 
> Best regards
> Thomas
> 
>>
>> The virtio_gpu_translate_format() function already handles
>> ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
>> so this just exposes the existing capability to userspace.
>>
>> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>>   1 file changed, 1 insertion(+)

For primary plane, alpha channel often doesn't matter as primary has
fixed z=0 order and a usual alpha blending mode would account only
overlay's alpha channel. Many real hw drivers expose alpha-channel
formats for primary plane for compatibility with userspace, even though
for them the alpha has no meaning for the primary plane.

QEMU is most popular VMM using virtio-gpu, but there are others. For a
stricter compatibility we can translate B8G8R8A8 to X8R8G8B8 for the
primary plane in the driver code, but I assume in practice it's very
unlike this will be necessary and we can always do it later on if will
be needed.

The change looks okay, will apply after testing.

-- 
Best regards,
Dmitry
