Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68067EA71AA
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 23:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D96F10E01F;
	Sun, 19 Apr 2026 23:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="My++E4bh";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8899D10E01F
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5j1hxsxDcHYnCCY75WYYD4pCz2FrUQeTAsF2SbfQqNE=; b=My++E4bhMyVs+rFIhJUam4usS7
 vqY3/38Mt6AX36h9VCCWV1dE8Bbx7f1izP+7fx9H3AnX0YG6m7X6x3tTwM2UxXmaoZQcxN1rHucvK
 zITd6iYGxvfJXavw4cvH1wcvLjwKFR4ylbmy911VC824+gMId8pdpXk0ecU9onDN+csUiFIFh/m4V
 9Kv/1OyXQzxaOtl6xAPKLZsy6fWuTpa/tfWOLqzmSigafO4cwu/B98S+YtdtFedIH60dOFVB0r1qI
 CblKRGgNZA4wwDQ3xkjCRv+XXs0hPsOp/eqSta7GAtiH3E9nBpAn1BUFahGKAJhD0moGO9kHIQyAe
 DpCECMCw==;
Received: from [187.36.208.231] (helo=[192.168.1.103])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wEbHi-000ibz-SO; Mon, 20 Apr 2026 01:10:39 +0200
Message-ID: <58293dd4-b82b-42e7-b863-6d91d58e6a20@igalia.com>
Date: Sun, 19 Apr 2026 20:10:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/v3d: Reject empty multisync extension to prevent
 infinite loop
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, mwen@igalia.com
Cc: itoral@igalia.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260415050000.3816128-1-ashutoshdesai993@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260415050000.3816128-1-ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Ashutosh,

On 15/04/26 02:00, Ashutosh Desai wrote:
> v3d_get_extensions() walks a userspace-provided singly-linked list of
> ioctl extensions without any bound on the chain length. A local user
> can craft a self-referential extension (ext->next == &ext) with zero
> in_sync_count and out_sync_count, which bypasses the existing duplicate-
> extension guard:
> 
>      if (se->in_sync_count || se->out_sync_count)
>              return -EINVAL;
> 
> The guard never fires because v3d_get_multisync_post_deps() returns
> immediately when count is zero, leaving both fields at zero on every
> iteration. The result is an infinite loop in kernel context, blocking
> the calling thread and pegging a CPU core indefinitely.
> 
> Fix this by rejecting a multisync extension where both in_sync_count
> and out_sync_count are zero in v3d_get_multisync_submit_deps(). An
> empty multisync carries no synchronization information and serves no
> useful purpose, so returning -EINVAL for such an extension is the
> correct defense against this attack vector.
> 
> Fixes: 9032d5f633ed ("drm/v3d: Detach job submissions IOCTLs to a new specific file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>

Applied to misc/kernel.git (drm-misc-fixes) with a fix: I changed the
"Fixes" tag to reflect the commit in which the issue was indeed
introduced, that is: commit e4165ae8 ("drm/v3d: add multiple syncobjs
support").

Thanks for the contribution!

Best Regards,
- Maíra

> ---
> V3 -> V4: fix indentation
> V2 -> V3: drop depth counter; instead reject empty multisync
>            (in_sync_count == 0 && out_sync_count == 0) in
>            v3d_get_multisync_submit_deps()
> V1 -> V2: change cap from 16 to V3D_MAX_EXTENSIONS (7), add #define
> 
> v3: https://lore.kernel.org/dri-devel/177614548527.3603641.5360701002746181082@gmail.com/
> v2: https://lore.kernel.org/dri-devel/20260413055230.3349114-1-ashutoshdesai993@gmail.com/
> v1: https://lore.kernel.org/dri-devel/20260410013907.2404175-1-ashutoshdesai993@gmail.com/
> 
>   drivers/gpu/drm/v3d/v3d_submit.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 18f2bf1fe89f..fc74351efad5 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -393,6 +393,11 @@ v3d_get_multisync_submit_deps(struct drm_file *file_priv,
>   	if (multisync.pad)
>   		return -EINVAL;
>   
> +	if (!multisync.in_sync_count && !multisync.out_sync_count) {
> +		drm_dbg(&v3d->drm, "Empty multisync extension\n");
> +		return -EINVAL;
> +	}
> +
>   	ret = v3d_get_multisync_post_deps(file_priv, se, multisync.out_sync_count,
>   					  multisync.out_syncs);
>   	if (ret)

