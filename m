Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705BACA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 22:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FE910E008;
	Sun, 11 Oct 2026 22:11:05 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC0E10E008
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 22:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791756650; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n3jN3Bqouu0nY6sX/sUfVukLaVRnkHKbMehkBXF2gK3uKUMDdDIKKQ1h8hj60JBgfh+aQYSoe3EkpSUivdxmoQa5ZJ27g7xRHEB7nrPWPDtQ5XPrlZdXBX07FZ/corieglk3OdVukCD55ERreomqq9X0bMx4xrciJnELifgBWOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791756650;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ms1Sj4b8K+z26gx8JG2rV9uppLq7GLGS0paorRFW28c=; 
 b=nNuNrcaRRdYieF7LdaaTFhYUViuA4Orv4z/nemMbNB+giO1ty0r5w/EF4KCzLWL/JT2Y5vp6OBw4JDUKgcBqoOUxt3X2nVpMPYNaoAYvC2IGy+ti82oCpjV8FN+gUkMEBmLOFzzTdMtZNeI6s5RDRx1l+ZlPoTvhCNTVQQ9m1qI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791756650; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Ms1Sj4b8K+z26gx8JG2rV9uppLq7GLGS0paorRFW28c=;
 b=TQMK5nM6dMDDsnX82yzq7UMhsbNg3Cwa+7Axkdsk7iq31M08MLEbbpPMZ2iXMyUZ
 avnrTNW27eZWP9AOrSE7hHYSVzGu+evlJi7bAJ/A9Zo5AXj/0raa9WZUmQTirAxNAz1
 1xk7TB0Ynv6MSOLTs446wgTEjk1rSP2H3Rudunic=
Received: by smtp.zohomail.com with SMTPS id 1791756648895284.2782609469007;
 Sun, 11 Oct 2026 15:10:48 -0700 (PDT)
Message-ID: <d27374f9-d0ec-4637-a4b4-d5e6ce1922a1@collabora.com>
Date: Mon, 12 Oct 2026 01:10:44 +0300
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
 <b8064104-99dd-472d-883d-56b362d60371@collabora.com>
 <067c22f6-206a-421f-8837-1f8a88f55299@suse.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <067c22f6-206a-421f-8837-1f8a88f55299@suse.de>
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

On 10/1/26 16:31, Thomas Zimmermann wrote:
> Hi
> 
> Am 01.10.26 um 12:46 schrieb Dmitry Osipenko:
>> On 9/30/26 18:03, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
>>>> Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
>>>> virtio-gpu primary planes. Without this, glmark2-drm fails at
>>>> startup because it selects ARGB visual configs by default, which
>>>> don't match the XRGB-only plane capabilities. This causes
>>>> drmModeSetCrtc to fail with EINVAL.
>>> But does the host also support ARGB on the primary plane? We usually
>>> don't export formats that are not available in (virtual) hardware.
>>>
>>> Best regards
>>> Thomas
>>>
>>>> The virtio_gpu_translate_format() function already handles
>>>> ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
>>>> so this just exposes the existing capability to userspace.
>>>>
>>>> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>> For primary plane, alpha channel often doesn't matter as primary has
>> fixed z=0 order and a usual alpha blending mode would account only
>> overlay's alpha channel. Many real hw drivers expose alpha-channel
>> formats for primary plane for compatibility with userspace, even though
>> for them the alpha has no meaning for the primary plane.
> 
> We decidedly do not offer formats that are not native to the hardware;
> except for adding XRGB888.
> 
> 
>>
>> QEMU is most popular VMM using virtio-gpu, but there are others. For a
>> stricter compatibility we can translate B8G8R8A8 to X8R8G8B8 for the
>> primary plane in the driver code, but I assume in practice it's very
>> unlike this will be necessary and we can always do it later on if will
>> be needed.
> 
> No in-kernel format conversion please; again except for adding XRGB8888.

Chances are low this may ever become necessary. Confirm glmark2-drm now
works with this change.

Applied to misc-next

-- 
Best regards,
Dmitry
