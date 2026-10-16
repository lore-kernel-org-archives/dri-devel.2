Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF94CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E323A11265E;
	Fri, 16 Oct 2026 07:48:16 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5546911264E
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=dEewYLgjiHZW/eBsP71quKAyI9xH1OB5VK7isGmpV9M=; b=D6KttBco6oKvOVvuQteTR3mxtX
 PF8LU3WAmb6M/akdAnh1Vyl3hBGJXNZSIgbZFgDBYJBJOWR0VNSaiXhElGixer4inykAglFtw9dPx
 /Of+Q4G/WIx9zTv/S5xPMzNnuV+eyfQ0wCMe/3XiBXN6lquFk5Y+Zkk/AknVzd67GmYXAl1ocaD+q
 KRhPWFhAT8iukup6lEHAVFtPd/r9MUK/HSmwmzp0Y7r7f5qeTsOV/So8EM0whfqu4yGcsL6fdgzcr
 EKtNkhPTChyZR8j5j30JuYnv1qvc77UIaRfezeV6wIWmm750LQtetUWfGavXT9N4yz3I6zoSwAaVM
 gm0IIsiQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHcfR-000vwg-1T; Fri, 16 Oct 2026 09:47:53 +0200
Message-ID: <388e5d83-89cb-4159-886f-afb57921911c@igalia.com>
Date: Fri, 16 Oct 2026 08:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panic: Accept a trailing newline in panic_screen
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
 <20261016052722.60051-2-lucid_duck@justthetip.ca>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261016052722.60051-2-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 16/10/2026 06:27, Devin Wittmayer wrote:
> Setting the panic screen through sysfs with echo fails with EINVAL,
> because the value ends in a newline. Ignore it when matching.
> 
> Fixes: e85e9ccf3f84 ("drm/panic: Report invalid or unsupported panic modes")
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
> QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next:
> 
>                                       before    after
>    write of "user\n"                  refused   takes
>    write of "bsod\n"                  refused   refused

Hah funny, becuase before e85e9ccf3f84 it used to take "bsod\n" but 
AFAIR it would silently revert to displaying "user". Because old code 
was this:

static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
{
        if (!strcmp(drm_panic_screen, "kmsg")) {
                draw_panic_static_kmsg(sb);
        } else if (!strcmp(drm_panic_screen, "qr_code")) {
                draw_panic_static_qr_code(sb);
        } else {
                draw_panic_static_user(sb);
        }
}

But it is true that it would also silently accept "user\n" so I guess 
you can call it a partial regression.

Anyway, the fix LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>    drm.panic_screen=user at boot      takes     takes
> 
> amdgpu, 2 runs each, 7.2.6 with Arch's source and config:
> 
>    echo user                          refused   takes
> 
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 29b1487de7ae0..7847b38ba9aab 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -839,7 +839,7 @@ static int drm_panic_type_set(const char *val, const struct kernel_param *kp)
>   	unsigned int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(drm_panic_type_map); i++) {
> -		if (!strcmp(val, drm_panic_type_map[i])) {
> +		if (sysfs_streq(val, drm_panic_type_map[i])) {
>   			drm_panic_type = i;
>   			return 0;
>   		}

