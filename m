Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F55C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7996410E5EF;
	Sat, 18 Jul 2026 19:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="HkhQC06B";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DD110E5E8
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784401710; x=1785006510; i=deller@gmx.de;
 bh=y4PU9fwto4NyG0GTrieub80l7mENqpXJjTT+cs1F0tM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HkhQC06BsYisLWWPVEU6h0Pwlqbvium9fykyOB0Xd3SEKG/zalcXLsRNoM6OkhSw
 0VzhA2VSrEstxS1bKKHCC3qO1mtlpX7xTMqdgOrzvDO6yz6WMquIfVi48AXOOnMrc
 IAv3qOPQoPGhM2fC22YtUD+PTFrdWZpelnXK9AkuLrFQ1/NO0N2YzXVM1TRtDGrDh
 b+YVmiWPpR0c2wvv/3ZE25LmC2qbTgwdudly5E7xiDLkWQMwptb2Y44uYUX+asQQM
 2BVq14OQvVQF5pE/zvFVIg1u7xm6i4LRtP8wuLehNaf2AMWRx8F8f0ixNh2dehmrD
 BVjk0XJlW6BSGgNodw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1x86h82bQa-016QUC; Sat, 18
 Jul 2026 21:08:30 +0200
Message-ID: <88fa0f85-0960-464a-a602-f797785f0c2e@gmx.de>
Date: Sat, 18 Jul 2026 21:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] vga_switcheroo, drm: Push fbcon handling into DRM
 clients
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260709092215.168172-1-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260709092215.168172-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S615kaKGtHvAIvX1MLD8FaoYbeTIwzEgGOPwh9vdydqoHXirudj
 b0mrrgB41GGwFepfcF+QBUOVKIehuYJmUJArjXTQcSoV0/w4y/StDh2qxAf6Bk+i+1QYa1M
 x8fWPefk08P7Q17Ap1642RVRNda3VpN6oEXj2Igy3Nm8SmZnMNpHsN1C4qUQ7S8Jf2MowzB
 SpyeYaYkTHL+1gtqnwh2Q==
UI-OutboundReport: notjunk:1;M01:P0:hZct43mhCvE=;qBO4ro/mry68eOt/Qff5hh3M2R8
 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
 orJgof70Paq++Ns3T/jNC
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

On 7/9/26 11:15, Thomas Zimmermann wrote:
> Vga_switcheroo currently invokes fb_switch_outputs() to inform fbcon
> about switching of the physical outputs among framebuffer devices. But
> new DRM clients to not use fbdev/fbcon and might require their own
> vga_switcheroo support. Let's strictly separate them from each other.
>=20
> Remove fbdev/fbcon from vga_switcheroo. Introduce a pre_switch callback
> for vga_switcheroo clients to do the fbcon update. Allows for removing
> all direct interactions between vga_switcheroo and fbdev/fbcon.
>=20
> There are only four drivers that support vga_switcheroo: amdgpu,
> radeon, i915 and nouveau. Update each of them with the new callback.
> When vga_switcheroo now invokes pre_switch, each DRM driver forwards
> to aquire_outputs and lets the DRM clients handle the new outputs.
>=20
> At the same time, push the fbcon update into DRM's client for fbdev
> emulation. Do this with the new DRM client callback acquire_outputs,
> so that other clients can have their own handling of vga_switcheroo.
>=20
> Also replace the existing reprobe hook with post_switch for symetry.
> For nouveau, this is merely a rename of the helper function. The other
> drivers dor not implement reprobe.
>=20
> Tested with radeon on a notebook with Radeon HD 4225 and HD 5430.
>=20
> v2:
> - implement all of pre_switch in a single commit to avoid possible
>    deadlock in intermediate state (Sashiko)
> - fix erroneous docs (Sashiko)
>=20
> Thomas Zimmermann (7):
>    drm/edid: Include <linux/fb.h>
>    drm/client: Add acquire_outputs callback; implement for fbdev
>      emulation
>    vga_switcheroo: Add pre_switch callback to client ops
>    vga_switcheroo: Add post_switch callback to client ops
>    drm: Implement struct vga_switcheroo_client_ops.pre_switch
>    drm: Implement vga_switcheroo_client_ops.post_switch
>    vga-switcheroo: Remove unused interfaces
>=20
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++++-
>   drivers/gpu/drm/clients/drm_fbdev_client.c | 23 ++++++++----
>   drivers/gpu/drm/drm_client_event.c         | 18 ++++++++++
>   drivers/gpu/drm/drm_edid.c                 |  1 +
>   drivers/gpu/drm/i915/i915_switcheroo.c     | 11 +++++-
>   drivers/gpu/drm/nouveau/nouveau_vga.c      | 28 +++++++++------
>   drivers/gpu/drm/radeon/radeon_device.c     |  9 ++++-
>   drivers/gpu/vga/vga_switcheroo.c           | 41 +++++-----------------
>   drivers/video/fbdev/core/fbcon.c           |  8 -----
>   include/drm/drm_client.h                   | 14 ++++++++
>   include/drm/drm_client_event.h             |  3 ++
>   include/linux/vga_switcheroo.h             | 29 ++++++++-------
>   12 files changed, 121 insertions(+), 73 deletions(-)
You may add a
Acked-by: Helge Deller <deller@gmx.de>
to the series.

Just in case you want me to take the series through the fbdev git tree,
please let me know.

Helge
