Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093560A2621
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9hf5H4D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DC010EC5B;
	Mon,  2 Nov 2026 09:25:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9D810EC5B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793611544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0YJmDm8gA/DEKgkw5VE7O1KDlOMQNvIwmHotjeEm44=;
 b=b9hf5H4DrmdY7A86dNfaJfOwye9JS61z0qo4sUjGLYFO9cVmgFDHFKLdeExPdgSBNE9Wy3
 e4YuRRwe44XFQBHA1ZFAe9WJ+VxUKy00C2cnEHvnCFZWQaxvDZdjIIg0TFygi0QmC0rMCV
 HtkR+wVJYHsf+NEGlRCLCUgtN4rjFT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-cuRO3PhDP1mjGS6di4pFZg-1; Mon, 02 Nov 2026 04:25:43 -0500
X-MC-Unique: cuRO3PhDP1mjGS6di4pFZg-1
X-Mimecast-MFC-AGG-ID: cuRO3PhDP1mjGS6di4pFZg_1793611542
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so25675285e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 01:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793611542; x=1794216342;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i0YJmDm8gA/DEKgkw5VE7O1KDlOMQNvIwmHotjeEm44=;
 b=Asb482IJ5wPLoX4HjEzez2ioD0n/X81dI5BzftUzaPO5ztQJQ2dv+lIk9oiGneO61I
 c2dr3BcznUJlvW0uhv6sUM4soRfzGHb6hQYXtmx5UYQzuNXKRazqyTrOGMUk4dCfBB++
 7rM3F0BZ9CokcvzrWbPqkvNHXczcrU2GqSa2xAViT9ICUBBF+FBxbdc3rgxPDcP/nDg1
 bt0i7xyggFV0SiNwiDe9MjC+AVLSyUYetGksB7qY3mMgljs/XlZ96xOSIyDai1jrbcLu
 9trYpP4IAuX/GnGi9el18XfgjQ8vtkuYPk/evnMio67jZ2+2+//rSxVxhg5tc5rNYxWQ
 gtKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb3FdARhxO18jR0YV3P/VhAnHi4nUjzQFmZmWJbb29+SAl2xOsBTDt2UhPwnMu+1U1xHBdvIkm5mE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLQtElGuS0UpAq0yaqqUByiW3w49jzSXB7Eq6kK9NcrMREHwUsn
 GWjm9bB7rXqs1kgUWl683qYhhyc9pneb3oXeHhBEcP6/XqBeOQoYLVUGcdMfiKtI0xj2QyeHC1i
 LzyOQx0x7uNGS7gxWnylR92rUEkpD2f+Yr96zPdbyFM0zcaGHOgMJgmE+S4zyUTa6a/lbng==
X-Gm-Gg: AYBFou2/Dm/5nrBXt6UHJsVp0joGkcJk7fh7lf46aoyxJawlrRpZe+nQxDm86Ugtybj
 e7iUOm+MbzXjMqUueDjwypGX4DqyqwSiWDJD9ZUl8iGuXI3EVT15EmGbnT4SIupAGFmvTuajFQm
 uShsuucpuVliSMnH/iGTaTeUO7l84dYCH49yok7z2EdO3ndHMNZGZAIT6ZkPdnPQR1lFi+Dd38x
 5hAL2pgOJTodfIlyLoOnFCf+MzRPcW3dpUbXu9K3ZcbhuB/eICp974ody1hpuyS+hvxiy4/JljC
 J6qUginK75W7gPiiXawFmNLvOkljhbJ/ThtbT6qlaes/Suq4gkqVQjMobVagykZr1kvQv10PL5N
 PNmb76qtYwU9Z7wSG+sFJmnZhoj6YmmJCC70Z1IqO2P4ee6eVtPcjsBuurJrjWYcungawOVNX1N
 XqHlgUnmSCPKLvZ0d4ETc=
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ac17567fe1mr225820255e9.12.1793611541861; 
 Mon, 02 Nov 2026 01:25:41 -0800 (PST)
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ac17567fe1mr225819905e9.12.1793611541508; 
 Mon, 02 Nov 2026 01:25:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad5ff8sm182618865e9.4.2026.11.02.01.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 01:25:41 -0800 (PST)
Message-ID: <5ee324c3-ddcc-4042-8708-01418225025a@redhat.com>
Date: Mon, 2 Nov 2026 10:25:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is drm_log the intended replacement for fbcon? It needs
 console=drm_log0 and loglevel=7 to show anything (7.3.0, amdgpu)
To: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: javierm@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>,
 deller@gmx.de, simona@ffwll.ch, linux-fbdev@vger.kernel.org
References: <CALykNV4sPj4PPUfx3j9qbc2pPsriNgiUHk2cL1N3+1H_FMc4oQ@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CALykNV4sPj4PPUfx3j9qbc2pPsriNgiUHk2cL1N3+1H_FMc4oQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h-gTlmnzMXVqWP6wjZ-AMq5OMLEAEsc1WvZPMd0vRbg_1793611542
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 00:44, Guilherme Bember Duarte wrote:
> Hi,
> 
> I've been trying to run a kernel without fbcon, with drm_log for boot 
> output and kmscon as the userspace console. Before I go further, I'd 
> like to ask where this is heading:
> 
> 1. Is fbcon (and fbdev emulation) planned to be deprecated?

No, and probably not in the foreseeable future. Fedora 45 is switching 
to userspace terminal, so it will be able to disable fbcon in the next 
one or two release. But that's only one of the Linux desktop distribution.
The Linux kernel is also used in a lot of different hardware and setup 
than desktop, where fbcon might still be a better choice.
> 2. If so, is drm_log the intended in-kernel replacement for its boot 
> output, with the terminal left to userspace?

Desktop distributions that wants to replace fbcon with a userspace 
terminal and drm_log can do so. But they can also stay on fbcon, that's 
their choice.

> 3. If that's the plan, why does drm_log need so much setup to work? 
> Right now it doesn't behave like something meant to replace fbcon.
> 
> What I found (7.3.0, amdgpu RX 6600, one DP monitor, 
> CONFIG_FRAMEBUFFER_CONSOLE and DRM_FBDEV_EMULATION off, 
> CONFIG_DRM_CLIENT_LOG=y and DEFAULT="log"):
> 
> - console=tty0 loglevel=7                         -> no video
> - console=tty0 console=drm_log0 loglevel=3        -> no video
> - console=tty0 console=drm_log0 loglevel=7        -> video, and kmscon 
> takes over cleanly

Yes, that's the current way to make it work, I'm sorry it's not that 
clear in the documentation.
The first problem is that the console has an historical default to tty0, 
and it's difficult to change that to drm_log0 if fbcon is not present, 
and drm_log is the default.

Regarding loglevel, it is intentional to not modeset if there are no 
message. That way, if you have plymouth, or another boot splash screen, 
drm_log won't introduce another display flicker at boot.
Most Linux distributions use "quiet" and "rhgb"/"splash" to hide the 
kernel boot logs by default, so drm_log makes it a bit easier.

I really should update the Kconfig entry for DRM_CLIENT_LOG, as you're 
right it's missing those important command line parameters, and I 
understand your frustration.

Best regards,

-- 

Jocelyn
> 
> Why, as far as I can tell:
> 
> - Without console=drm_log0 the console is registered but never enabled 
> (flags 0x101, no CON_ENABLED; with the argument it is 0x107). tty0 is 
> already first in the console list and has a tty binding, so 
> register_console() doesn't enable drm_log by default. I saw this was 
> discussed in the v9 drm_log thread in Dec 2024. The Kconfig help for 
> DRM_CLIENT_LOG says nothing about console=, so a user gets a dark screen 
> and no message.
> - Even once enabled, drm_log_init_client() only runs when the first 
> record passes the console loglevel (it's called from 
> drm_log_write_thread()). With a normal loglevel the screen stays dark. 
> Needing loglevel=7 to get a display at all seems like a poor requirement 
> for a boot display, and it is not documented anywhere I could find.
> 
> If drm_log is meant to replace fbcon, at least for boot information 
> before userspace handoff, I think it should light the display at boot 
> without extra command line arguments and without depending on the 
> loglevel, for example by doing the first probe and commit when the 
> client registers, or on the first hotplug. If it is only meant as a 
> debugging aid, as its DOC comment says, then a kernel without fbcon has 
> no supported way to get a boot display, and I'd like to know that too.
> 
> Thanks,
> Guilherme B.

